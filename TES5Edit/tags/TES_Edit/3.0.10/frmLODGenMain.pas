unit frmLODGenMain;

interface

uses
  Windows, Messages,
  Classes, SysUtils,
  Controls, StdCtrls, Forms,
  wbInterface, ExtCtrls, IniFiles;

const
  VersionString               = '2.2.2 (2009-02-25)';
  DefaultInterval             = 1 / 24 / 6;

type
  TfrmMain = class(TForm)
    mmoMessages: TMemo;
    tmrMessages: TTimer;
    tmrStartup: TTimer;
    tmrGenerator: TTimer;

    {--- Form ---}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    {--- Timer ---}
    procedure tmrStartupTimer(Sender: TObject);
    procedure tmrMessagesTimer(Sender: TObject);
    procedure tmrGeneratorTimer(Sender: TObject);
  protected
    procedure GenerateLOD(const aWorldspace: IwbMainRecord);
    procedure DoGenerateLOD;
  private
    procedure WMUser(var Message: TMessage); message WM_USER;
    procedure WMUser1(var Message: TMessage); message WM_USER + 1;
    procedure WMUser2(var Message: TMessage); message WM_USER + 2;
  private
    PluginsFileName: string;
    TheGameIniFileName: string;
    SettingsFileName: string;
    Files: TDynFiles;
    NewMessages: TStringList;
    LoaderDone: Boolean;
    LoaderError: Boolean;
    LoaderStarted: Boolean;
    ForceTerminate: Boolean;
    Settings: TMemIniFile;

    InitStarted: Boolean;
    GeneratorStarted: Boolean;
    GeneratorDone: Boolean;

    procedure DoInit;
    procedure SetDoubleBuffered(aWinControl: TWinControl);
  public
    destructor Destroy; override;

    procedure AddMessage(const s: string);
    procedure AddFile(const aFile: IwbFile);

    procedure PostAddMessage(const s: string);
    procedure SendAddFile(const aFile: IwbFile);
    procedure SendLoaderDone;
  end;

  TLoaderThread = class(TThread)
  protected
    ltLoadOrderOffset: Integer;
    ltLoadList: TStringList;
    ltDataPath: string;
    ltMaster: string;
    ltFiles: array of IwbFile;

    procedure Execute; override;
  public
    constructor Create(var aList: TStringList); overload;
    constructor Create(aFileName: string; aMaster: string; aLoadOrder: Integer); overload;
    destructor Destroy; override;
  end;

var
  frmMain                     : TfrmMain;

  DataPath                    : string;
  ProgramPath                 : string;
  MyGamesTheGamePath         : string;

implementation

{$R *.dfm}

uses
  ShlObj, Registry, Math, 
  Direct3D9,
  wbImplementation, wbBSA,
  FileSelectFrm;

function GetCSIDLShellFolder(CSIDLFolder: integer): string;
begin
  SetLength(Result, MAX_PATH);
  SHGetSpecialFolderPath(0, PChar(Result), CSIDLFolder, True);
  SetLength(Result, StrLen(PChar(Result)));
  if (Result <> '') then
    Result := IncludeTrailingBackslash(Result);
end;

procedure TfrmMain.AddFile(const aFile: IwbFile);
begin
  SetLength(Files, Succ(Length(Files)));
  Files[High(Files)] := aFile;
  aFile._AddRef;
end;

procedure TfrmMain.AddMessage(const s: string);
begin
  mmoMessages.Lines.Add(s);
  mmoMessages.CaretPos := Point(0, mmoMessages.Lines.Count - 1);
  mmoMessages.SelLength := 1;
  mmoMessages.SelLength := 0;
end;

type
  TCoords = TD3DVector;

  PRefInfo = ^TRefInfo;
  TRefInfo = record
    FormID : Cardinal;
    Pos    : TCoords;
    Rot    : TCoords;
    Scale  : Single;
    Next   : PRefInfo;
  end;

function PluginListCompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  IsESM1                      : Boolean;
  IsESM2                      : Boolean;
  FileAge1                    : Integer;
  FileAge2                    : Integer;
begin
  IsESM1 := SameText(ExtractFileExt(List[Index1]), '.esm');
  IsESM2 := SameText(ExtractFileExt(List[Index2]), '.esm');

  if IsESM1 = IsESM2 then begin

    FileAge1 := Integer(List.Objects[Index1]);
    FileAge2 := Integer(List.Objects[Index2]);

    if FileAge1 < FileAge2 then
      Result := -1
    else if FileAge1 > FileAge2 then
      Result := 1
    else
      Result := 0;

  end
  else if IsESM1 then                                               
    Result := -1
  else
    Result := 1;
end;

destructor TfrmMain.Destroy;
begin
  inherited;
  FreeAndNil(NewMessages);
end;

procedure TfrmMain.DoInit;
const
  sBethRegKey             = '\SOFTWARE\Bethesda Softworks\';
var
  i, j                        : Integer;
  s                           : string;
  sl, sl2                     : TStringList;
  F                           : TSearchRec;
begin
  ProgramPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  SetDoubleBuffered(Self);
  wbDisplayLoadOrderFormID := True;
  wbSortSubRecords := True;
  wbDisplayShorterNames := True;
  wbHideUnused := True;
  wbFlagsAsArray := True;
  wbRequireLoadOrder := True;

  with TRegistry.Create do try
    RootKey := HKEY_LOCAL_MACHINE;

    if not OpenKeyReadOnly(sBethRegKey + wbGameName + '\') then begin
      AddMessage('Fatal: Could not open registry key: ' + sBethRegKey + wbGameName + '\');
      Exit;
    end;

    DataPath := ReadString('Installed Path');

    if DataPath = '' then begin
      AddMessage('Fatal: Could not determine '+wbGameName+' installation path.');
      Exit;
    end;

    DataPath := IncludeTrailingPathDelimiter(DataPath) + 'Data\';

    AddMessage('Using '+wbGameName+' Data Path: ' + DataPath);
  finally
    Free;
  end;

  PluginsFileName := '';
  if ParamCount >= 1 then begin
    PluginsFileName := ParamStr(1);
    if (Length(PluginsFileName) > 0) and (PluginsFileName[1] = '-') then
      PluginsFileName := '';
  end;

  if PluginsFileName = '' then begin
    PluginsFileName := GetCSIDLShellFolder(CSIDL_LOCAL_APPDATA);
    if PluginsFileName = '' then begin
      AddMessage('Fatal: Could not determine the local application data folder');
      Exit;
    end;

    PluginsFileName := PluginsFileName + wbGameName + '\Plugins.txt';
  end;

  if TheGameIniFileName = '' then begin
    TheGameIniFileName := GetCSIDLShellFolder(CSIDL_PERSONAL);
    if TheGameIniFileName = '' then begin
      AddMessage('Fatal: Could not determine my documents folder');
      Exit;
    end;

    MyGamesTheGamePath := TheGameIniFileName + 'My Games\'+ wbGameName +'\';

    if wbGameMode = gmFO3 then
      TheGameIniFileName := MyGamesTheGamePath + 'Fallout.ini'
    else
      TheGameIniFileName := MyGamesTheGamePath + wbGameName + '.ini';
    AddMessage('Using ini: ' + TheGameIniFileName);

    if not FileExists(TheGameIniFileName) then begin
      AddMessage('Fatal: Could not find ini');
      Exit;
    end;
  end;

  SettingsFileName := ChangeFileExt(PluginsFileName, '.'+LowerCase(wbAppName)+'lodgensettings');

  AddMessage('Using settings file: ' + SettingsFileName);

  Settings := TMemIniFile.Create(SettingsFileName);

  AddMessage('Loading active plugin list: ' + PluginsFileName);

  try
    sl := TStringList.Create;
    try

      with TfrmFileSelect.Create(nil) do try

        if FindFirst(DataPath + '*.*', faAnyFile, F) = 0 then try
          repeat
            s := ExtractFileExt(F.Name);
            if SameText(s, '.esm') or SameText(s, '.esp') then
              sl.AddObject(F.Name, TObject(FileAge(DataPath + F.Name)));
          until FindNext(F) <> 0;
        finally
          FindClose(F);
        end;

        sl.CustomSort(PluginListCompare);

        CheckListBox1.Items.Assign(sl);

        sl.LoadFromFile(PluginsFileName);
        for i := Pred(sl.Count) downto 0 do begin
          s := Trim(sl.Strings[i]);
          j := Pos('#', s);
          if j > 0 then
            System.Delete(s, j, High(Integer));
          s := Trim(s);
          if s = '' then begin
            sl.Delete(i);
            Continue;
          end;

          j := CheckListBox1.Items.IndexOf(s);
          if j < 0 then
            AddMessage('Error: Active plugin List contains nonexisting file "' + s + '"')
          else
            CheckListBox1.Checked[j] := True;

        end;
{
        sl2 := TStringList.Create;
        try
          sl2.Sorted := True;
          sl2.Duplicates := dupIgnore;

          sl.Clear;
          for i := 0 to Pred(CheckListBox1.Count) do
            if CheckListBox1.Checked[i] then
              sl.Add(CheckListBox1.Items[i]);

          while sl.Count > 0 do begin
            sl2.Clear;
            for i := 0 to Pred(sl.Count) do
              wbMastersForFile(DataPath + sl[i], sl2);

            sl.Clear;
            if sl2.Count > 0 then
              for i := 0 to Pred(CheckListBox1.Count) do
                if not CheckListBox1.Checked[i] then
                  if sl2.Find(CheckListBox1.Items[i], j) then begin
                    CheckListBox1.Checked[i] := True;
                    sl.Add(CheckListBox1.Items[i]);
                    sl2.Delete(j);
                    if sl2.Count < 1 then
                      Break;
                  end;
          end;

        finally
          FreeAndNil(sl2);
        end;
}

        sl.Clear;
        for i := 0 to Pred(CheckListBox1.Count) do
          if CheckListBox1.Checked[i] then
            sl.Add(CheckListBox1.Items[i]);

      finally
        Free;
      end;

      with TfrmFileSelect.Create(nil) do try

        if (not wbEditAllowed) or wbTranslationMode then begin
          Caption := 'Skip these records:';

          sl2 := TStringList.Create;
          try
            sl2.Sorted := True;
            sl2.Duplicates := dupIgnore;
            sl2.CommaText := 'LAND,ROAD,PGRD,REGN';

            for i := 0 to Pred(wbRecordDefMap.Count) do
              with IwbRecordDef(Pointer(wbRecordDefMap.Objects[i])) do begin
                j := CheckListBox1.Items.Add(DefaultSignature + ' - ' + GetName);
                if sl2.IndexOf(DefaultSignature) >= 0 then
                  CheckListBox1.Checked[j] := True;
              end;

            sl2.Clear;
            for i := 0 to Pred(CheckListBox1.Count) do
              if CheckListBox1.Checked[i] then begin
                RecordToSkip.Add(Copy(CheckListBox1.Items[i], 1, 4));
                sl2.Add(Copy(CheckListBox1.Items[i], 1, 4));
              end;
          finally
            FreeAndNil(sl2);
          end;
        end;
      finally
        Free;
      end;

      wbStartTime := Now;
      TLoaderThread.Create(sl);
    finally
      FreeAndNil(sl);
    end;
  except
    on E: Exception do begin
      AddMessage('Fatal: Error loading plugin list: <' + E.ClassName + ': ' + E.Message + '>');
      Exit;
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if (LoaderStarted and not LoaderDone) then begin
    ForceTerminate := True;
    Caption := 'Waiting for Loader to terminate...';
    Enabled := False;
    try
      while not LoaderDone do begin
        Application.ProcessMessages;
        Sleep(100);
      end;
    finally
      Enabled := True;
    end;
  end;
  ForceTerminate := True;
  Caption := 'Shutting down...';

  Files := nil;
  wbProgressCallback := nil;
end;

var
  LastUpdate    : Cardinal;

procedure GeneralProgress(const s: string);
begin
  if s <> '' then
    frmMain.PostAddMessage(s);
  if LastUpdate + 500 < GetTickCount then begin
    if wbCurrentAction <> '' then
      frmMain.Caption := '['+wbCurrentAction+'] Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    LastUpdate := GetTickCount;
  end;
  if frmMain.ForceTerminate then
    Abort;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  wbProgressCallback := GeneralProgress;
  LastUpdate := GetTickCount;
  Font := Screen.IconFont;
  Caption := Application.Title;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  tmrStartup.Enabled := True;
end;

function CompareRefInfos(Item1, Item2: Pointer): Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  Result := CmpW32(PRefInfo(Item1).FormID, PRefInfo(Item2).FormID);

  if frmMain.ForceTerminate then
    Abort;
end;

procedure TfrmMain.GenerateLOD(const aWorldspace: IwbMainRecord);
var
  StartTick: Cardinal;

  procedure FindREFRs(const aElement: IwbElement; var REFRs: TDynMainRecords; var TotalCount, Count: Integer);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
  begin
    if StartTick + 500 < GetTickCount then begin
      Caption := 'Scanning References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(TotalCount) +
        ' References Found: ' + IntToStr(Count) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;
    end;

    if Supports(aElement, IwbMainRecord, MainRecord) then begin
      if MainRecord.Signature = 'REFR' then begin
        if High(REFRs) < Count then
          SetLength(REFRs, Length(REFRs) * 2);
        REFRs[Count] := MainRecord;
        Inc(Count);
      end;
    end else if Supports(aElement, IwbContainerElementRef, Container) then
      for i := 0 to Pred(Container.ElementCount) do
        FindREFRs(Container.Elements[i], REFRs, TotalCount, Count);
  end;

type
  TRule = (rSkip, rClear, rReplace);

var
  Master     : IwbMainRecord;
  REFRs      : TDynMainRecords;
  Count      : Integer;
  TotalCount : Integer;
  i, j, k, l : Integer;
  NameRec    : IwbContainerElementRef;
  DataRec    : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  RefInfos   : array of TRefInfo;
  MinX, MaxX : Single;
  MinY, MaxY : Single;
  MinCell    : TwbGridCell;
  MaxCell    : TwbGridCell;
  Cells      : array of array of PRefInfo;
  RefInfo    : PRefInfo;
  RefsInCell : array of PRefInfo;
  CmpStream  : TwbFileStream;
  LODScale   : Single;
  LODAdd     : Single;
  F          : TSearchRec;
  s          : string;
  Rule       : TRule;
begin
  LODScale := 100;
  LODAdd := 0.970001220703;

  Master := aWorldspace.MasterOrSelf;

  s := Settings.ReadString('Worldspace', Master.EditorID, '');
  if s = '' then
    s := Settings.ReadString('Default', 'Rule', 'Replace');

  Rule := rSkip;
  if SameText(s, 'Replace') then begin
    Rule := rReplace;
    s := 'Replacing';
  end else if SameText(s, 'Clear') then begin
    Rule := rClear;
    s := 'Clearing';
  end else if not SameText(s, 'Skip') then begin
    frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] <Warning: Unknown Rule "'+s+'"> Worldspace is being skipped.');
    s := 'Skipping';
  end else
    s := 'Skipping';

  frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: '+s+' ' + Master.Name);

  if Rule = rSkip then
    Exit;

  if Rule > rClear then begin
    Caption := 'Scanning References: ' + aWorldspace.Name + ' Processed Records: 0 '+
      'References Found: 0 Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    Count := 0;
    TotalCount := 0;
    REFRs := nil;
    SetLength(REFRs, 1024);
    FindREFRs(Master.ChildGroup, REFRs, TotalCount, Count);
    for i := 0 to Pred(Master.OverrideCount) do
      FindREFRs(Master.Overrides[i].ChildGroup, REFRs, TotalCount, Count);
    SetLength(REFRs, Count);

    {only keep the newest version of each}
    if Length(REFRs) > 1 then begin
      Caption := 'Sorting References: ' + aWorldspace.Name +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;

      QuickSort(@REFRs[0], Low(REFRs), High(REFRs), CompareElementsFormIDAndLoadOrder);

      Caption := 'Removing duplicates: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
        ' Unique References Found: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      j := 0;
      for i := Succ(Low(REFRs)) to High(REFRs) do begin
        if REFRs[j].LoadOrderFormID <> REFRs[i].LoadOrderFormID then
          Inc(j);
        if j <> i then
          REFRs[j] := REFRs[i];

        if ForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Caption := 'Removing duplicates: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Unique References Found: ' + IntToStr(j) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
      end;
      SetLength(REFRs, Succ(j));
    end;

    MinX := MaxSingle;
    MaxX := -MaxSingle;
    MinY := MaxSingle;
    MaxY := -MaxSingle;

    Caption := 'Filtering VWD References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
      ' Matching Records: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    SetLength(RefInfos, Length(REFRs));
    if Length(REFRs) > 0 then begin
      j := -1;
      for i := Low(REFRs) to High(REFRs) do begin

        if Supports(REFRs[i].RecordBySignature['NAME'], IwbContainerElementRef, NameRec) and
           Supports(NameRec.LinksTo, IwbMainRecord, MainRecord) and
           MainRecord.WinningOverride.HasVisibleWhenDistantMesh and
           Supports(REFRs[i].RecordBySignature['DATA'], IwbContainerElementRef, DataRec) and
           (DataRec.ElementCount = 2) and
           not REFRs[i].Flags.IsInitiallyDisabled and
           not REFRs[i].Flags.IsDeleted then begin
          try
            with RefInfos[Succ(j)] do begin
              FormID := MainRecord.LoadOrderFormID;

              with Pos, (DataRec.Elements[0] as IwbContainerElementRef) do begin
                if ElementCount >= 1 then
                  X := Round(Elements[0].NativeValue)+0.5;
                if ElementCount >= 2 then
                  Y := Round(Elements[1].NativeValue)+0.5;
                if ElementCount >= 3 then
                  Z := Round(Elements[2].NativeValue)+0.970703125;

                if (x < -10000000.0) or (x > 10000000.0) or
                   (y < -10000000.0) or (y > 10000000.0) then
                  raise Exception.Create('Position out of bounds');

                if X < MinX then
                  MinX := x;
                if X > MaxX then
                  MaxX := x;
                if Y < MinY then
                  MinY := Y;
                if Y > MaxY then
                  MaxY := Y;
              end;
              with Rot, (DataRec.Elements[1] as IwbContainerElementRef) do begin
                if ElementCount >= 1 then
                  X := Elements[0].NativeValue;
                if ElementCount >= 2 then
                  Y := Elements[1].NativeValue;
                if ElementCount >= 3 then
                  Z := Elements[2].NativeValue;
              end;
              if Supports(REFRs[i].RecordBySignature['XSCL'], IwbContainerElementRef, DataRec) then
                Scale := DataRec.NativeValue
              else
                Scale := 1;
              Scale := RoundTo(Scale, -2);
              Scale := (Scale * LODScale);
              Scale := Scale + LODAdd;
            end;
            Inc(j);
          except
            on E: Exception do
              frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: <Error while processing ' + REFRs[i].Name+': '+E.Message + '>');
          end;
        end;

        if ForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Caption := 'Filtering VWD References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Matching Records: ' + IntToStr(Succ(j)) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;

      end;
      SetLength(RefInfos, Succ(j));
    end;

    if Length(RefInfos) < 1 then
      Exit;

    MinCell.x := Trunc(MinX / 4096);
    if MinX < 0 then
      Dec(MinCell.x);
    MinCell.y := Trunc(MinY / 4096);
    if MinY < 0 then
      Dec(MinCell.y);
    MaxCell.x := Trunc(MaxX / 4096);
    if MaxX < 0 then
      Dec(MaxCell.x);
    MaxCell.y := Trunc(MaxY / 4096);
    if MaxY < 0 then
      Dec(MaxCell.y);

    SetLength(Cells, Succ(-(MinCell.x-MaxCell.x)), Succ(-(MinCell.y-MaxCell.y)));

    if ForceTerminate then
      Abort;
  end;

  ForceDirectories(DataPath + 'DistantLOD\');

  i := 0;
  Caption := 'Deleting old .lod files: ' + aWorldspace.Name + ' Processed Files: ' + IntToStr(i) +
    ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
  Application.ProcessMessages;
  StartTick := GetTickCount;

  if ForceTerminate then
    Abort;

  if FindFirst(DataPath + 'DistantLOD\'+aWorldspace.EditorID+'*.lod', faAnyFile, F) = 0 then try
    repeat
      DeleteFile(DataPath + 'DistantLOD\' + F.Name);
      Inc(i);

      if StartTick + 500 < GetTickCount then begin
        Caption := 'Deleting old .lod files: ' + aWorldspace.Name + ' Processed Files: ' + IntToStr(i) +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;
      end;

      if ForceTerminate then
        Abort;

    until FindNext(F) <> 0;
  finally
    FindClose(F);
  end;

  if Rule > rClear then begin
    CmpStream := TwbFileStream.Create(DataPath + 'DistantLOD\'+aWorldspace.EditorID+'.cmp', fmCreate);
    try
      Caption := 'Assigning References to Cells: ' + aWorldspace.Name + ' Processed References: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      for i := Low(RefInfos) to High(RefInfos) do
        with RefInfos[i], wbPositionToGridCell(Pos) do begin
          X := x - MinCell.x;
          y := y - MinCell.y;
          Next := Cells[x,y];
          Cells[x,y] := @RefInfos[i];

          if ForceTerminate then
            Abort;
          if StartTick + 500 < GetTickCount then begin
            Caption := 'Assigning References to Cells: ' + aWorldspace.Name + ' Processed References: ' + IntToStr(i) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;

      Caption := 'Writing .lod files: ' + aWorldspace.Name + ' Processed Cells: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      for i := Low(Cells) to High(Cells) do
        for j := Low(Cells[i]) to High(Cells[i]) do begin
          RefInfo := Cells[i,j];
          Count := 0;
          while Assigned(RefInfo) do begin
            Inc(Count);
            RefInfo := RefInfo.Next;
          end;
          if Count > 0 then begin
            SetLength(RefsInCell, Count);

            RefInfo := Cells[i,j];
            Count := 0;
            while Assigned(RefInfo) do begin
              RefsInCell[Count] := RefInfo;
              RefInfo := RefInfo.Next;
              RefsInCell[Count].Next := nil;
              Inc(Count);
            end;

            QuickSort(@RefsInCell[0], Low(RefsInCell), High(RefsInCell), CompareRefInfos);

            l := 0;
            for k := Succ(Low(RefsInCell)) to High(RefsInCell) do begin
              if RefsInCell[l].FormID = RefsInCell[k].FormID then begin
                RefsInCell[k].Next := RefsInCell[l];
              end else
                Inc(l);
              if l <> k then
                RefsInCell[l] := RefsInCell[k];
            end;
            SetLength(RefsInCell, Succ(l));

            with TwbFileStream.Create(DataPath + 'DistantLOD\'+aWorldspace.EditorID+'_'+IntToStr(i+MinCell.x)+'_'+IntToStr(j+MinCell.y)+'.lod', fmCreate) do try
              WriteCardinal(Length(RefsInCell));

              for l := Low(RefsInCell) to High(RefsInCell) do begin
                RefInfo := RefsInCell[l];
                WriteCardinal(RefInfo.FormID);

                Count := 0;
                while Assigned(RefInfo) do begin
                  Inc(Count);
                  RefInfo := RefInfo.Next;
                end;
                WriteCardinal(Count);

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Pos, SizeOf(RefInfo.Pos));
                  RefInfo := RefInfo.Next;
                end;

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Rot, SizeOf(RefInfo.Rot));
                  RefInfo := RefInfo.Next;
                end;

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Scale, SizeOf(RefInfo.Scale));
                  RefInfo := RefInfo.Next;
                end;

              end;
            finally
              Free;
            end;
            CmpStream.WriteSmallInt(j+MinCell.y);
            CmpStream.WriteSmallInt(i+MinCell.x);
          end;

          if StartTick + 500 < GetTickCount then begin
            Caption := 'Writing .lod files: ' + aWorldspace.Name + ' Processed Cells: ' + IntToStr(i * Length(Cells[i]) + j) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;
      CmpStream.WriteCardinal(7);
    finally
      CmpStream.Free;
    end;
  end;
end;

procedure TfrmMain.DoGenerateLod;
var
  i, j        : Integer;
  _File       : IwbFile;
  Group       : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  Worldspaces : TDynMainRecords;
begin
  try
    frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: starting');

    Worldspaces := nil;
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      if Supports(_File.GroupBySignature['WRLD'], IwbContainerElementRef, Group) then begin
        for j := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then begin
            if Mainrecord.Signature = 'WRLD' then begin
              SetLength(Worldspaces, Succ(Length(Worldspaces)));
              Worldspaces[High(Worldspaces)] := MainRecord;
            end;
          end;
      end;
    end;

    if Length(WorldSpaces) > 1 then begin
      QuickSort(@WorldSpaces[0], Low(WorldSpaces), High(WorldSpaces), CompareElementsFormIDAndLoadOrder);

      j := 0;
      for i := Succ(Low(WorldSpaces)) to High(WorldSpaces) do begin
        if WorldSpaces[j].LoadOrderFormID <> WorldSpaces[i].LoadOrderFormID then
          Inc(j);
        if j <> i then
          WorldSpaces[j] := WorldSpaces[i];
      end;
      SetLength(WorldSpaces, Succ(j));
    end;

    if Length(Worldspaces) = 0 then
      Exit;

    try
      try
        for i := Low(WorldSpaces) to High(WorldSpaces) do begin
          GenerateLOD(WorldSpaces[i]);
          if ForceTerminate then
            Abort;
        end;
      except
        on E: Exception do begin
          frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: <Error: '+E.Message+'>');
          raise;
        end;
      end;
      frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: finished (you can close this application now)');
    finally
      Self.Caption := Application.Title;
    end;
  finally
    GeneratorDone := True;
  end;
end;

procedure TfrmMain.PostAddMessage(const s: string);
var
  t                           : string;
  p                           : Pointer;
begin
  t := s;
  UniqueString(t);
  p := Pointer(t);
  Pointer(t) := nil;
  PostMessage(Handle, WM_USER, Integer(p), 0);
end;

procedure TfrmMain.SendAddFile(const aFile: IwbFile);
begin
  SendMessage(Handle, WM_USER + 1, Integer(Pointer(aFile)), 0);
end;

procedure TfrmMain.SendLoaderDone;
begin
  SendMessage(Handle, WM_USER + 2, 0, 0);
end;

procedure TfrmMain.SetDoubleBuffered(aWinControl: TWinControl);
var
  i                           : Integer;
begin
  aWinControl.DoubleBuffered := True;
  for i := Pred(aWinControl.ControlCount) downto 0 do
    if aWinControl.Controls[i] is TWinControl then
      SetDoubleBuffered(TWinControl(aWinControl.Controls[i]))
    else
      Exit;
end;

procedure TfrmMain.tmrStartupTimer(Sender: TObject);
begin
  tmrStartup.Enabled := False;
  if InitStarted then
    Exit;
  InitStarted := True;

  DoInit;
end;

procedure TfrmMain.tmrGeneratorTimer(Sender: TObject);
begin
  tmrGenerator.Enabled := False;
  if GeneratorStarted then
    Exit;
  GeneratorStarted := True;
  DoGenerateLOD;
end;

procedure TfrmMain.tmrMessagesTimer(Sender: TObject);
begin
  if Assigned(NewMessages) and (NewMessages.Count > 0) then begin
    mmoMessages.Lines.AddStrings(NewMessages);
    NewMessages.Clear;
    mmoMessages.CaretPos := Point(0, mmoMessages.Lines.Count - 1);
    mmoMessages.SelLength := 1;
    mmoMessages.SelLength := 0;
  end;
end;

procedure TfrmMain.WMUser(var Message: TMessage);
var
  t                           : string;
begin
  Pointer(t) := Pointer(Message.WParam);
  if not Assigned(NewMessages) then
    NewMessages := TStringList.Create;
  NewMessages.Add(t);
end;

procedure TfrmMain.WMUser1(var Message: TMessage);
begin
  AddFile(IwbFile(Pointer(Message.WParam)));
end;

procedure TfrmMain.WMUser2(var Message: TMessage);
begin
  LoaderDone := True;
  if not (LoaderError or ForceTerminate) then
    tmrGenerator.Enabled := true;
end;

{ TLoaderThread }

constructor TLoaderThread.Create(var aList: TStringList);
begin
  ltDataPath := DataPath;
  ltMaster := '';
  ltLoadList := aList;
  aList := nil;
  inherited Create(False);
  FreeOnTerminate := True;
end;

constructor TLoaderThread.Create(aFileName: string; aMaster: string; aLoadOrder: Integer);
begin
  ltLoadOrderOffset := aLoadOrder;
  ltDataPath := '';
  ltLoadList := TStringList.Create;
  ltLoadList.Add(aFileName);
  ltMaster := aMaster;
  inherited Create(False);
  FreeOnTerminate := True;
end;

destructor TLoaderThread.Destroy;
begin
  inherited;
  FreeAndNil(ltLoadList);
end;

procedure LoaderProgress(const s: string);
begin
  if s <> '' then
    frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Loader: ' + s);
  if frmMain.ForceTerminate then
    Abort;
end;

procedure TLoaderThread.Execute;
var
  i                           : Integer;
  _File                       : IwbFile;
  s,t                         : string;
  F                           : TSearchRec;
begin
  LoaderProgress('starting...');
  try
    frmMain.LoaderStarted := True;
    wbProgressCallback := LoaderProgress;
    try
      wbStartTime := Now;
      for i := 0 to Pred(ltLoadList.Count) do begin
        LoaderProgress('loading "' + ltLoadList[i] + '"...');
        _File := wbFile(ltDataPath + ltLoadList[i], i + ltLoadOrderOffset, ltMaster);
        if wbEditAllowed and not wbTranslationMode then begin
          SetLength(ltFiles, Succ(Length(ltFiles)));
          ltFiles[High(ltFiles)] := _File;
        end;
        frmMain.SendAddFile(_File);
        if frmMain.ForceTerminate then
          Exit;
      end;

      for i := Low(ltFiles) to High(ltFiles) do
        if not SameText(ltFiles[i].FileName, wbGameName + '.esm') then begin
          LoaderProgress('[' + ltFiles[i].FileName + '] Building reference info.');
          ltFiles[i].BuildRef;
          if frmMain.ForceTerminate then
            Exit;
        end;

      if not Assigned(wbContainerHandler) then begin
        wbContainerHandler := wbCreateContainerHandler;

        with TMemIniFile.Create(frmMain.TheGameIniFileName) do try
          with TStringList.Create do try
            Text := StringReplace(ReadString('Archive','sArchiveList',''), ',',#10, [rfReplaceAll]);
            for i := 0 to Pred(Count) do begin
              s := Trim(Strings[i]);
              if Length(s) < 5 then
                Continue;
              if not ((s[1] = '\') or (s[2] = ':')) then
                t := ltDataPath + s;
              if not FileExists(t) then
                LoaderProgress('Warning: <Can''t find ' + t + '>')
              else begin
                LoaderProgress('[' + s + '] Loading Resources.');
                wbContainerHandler.AddBSA(t);
              end;
            end;
          finally
            Free;
          end;
        finally
          Free;
        end;

        for i := 0 to Pred(ltLoadList.Count) do begin
          if (ExtractFileExt(ltLoadList[i]) = '.esp') or (wbGameMode = gmFO3) then begin
            s := ChangeFileExt(ltLoadList[i], '');
            if FindFirst(ltDataPath + s + '*.bsa', faAnyFile, F) = 0 then try
              repeat
                LoaderProgress('[' + F.Name + '] Loading Resources.');
                wbContainerHandler.AddBSA(ltDataPath + F.Name);
              until FindNext(F) <> 0;
            finally
              FindClose(F);
            end;
          end;
        end;
        LoaderProgress('[' + ltDataPath + '] Setting Resource Path.');
        wbContainerHandler.AddFolder(ltDataPath);
      end;

    except
      on E: Exception do begin
        LoaderProgress('Fatal: <' + e.ClassName + ': ' + e.Message + '>');
        frmMain.LoaderError := True;
      end;
    end;
  finally
    frmMain.SendLoaderDone;
    LoaderProgress('finished');
    wbProgressCallback := nil;
  end;
end;

end.
