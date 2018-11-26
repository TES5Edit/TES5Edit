unit frmLogAnalyzerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees, VirtualEditTree, wbInterface;

type
  TLogType = (
    ltTES4RuntimeScriptProfiler,
    ltTES5Papyrus
  );

  TLogEntry = record
    LoadOrder: Byte;
    FormID: TwbFormID;
    Name, Text: string;
    Element: IwbElement;
    Value1: Single;
    Value2: Single;
    Value3: Single;
  end;
  PLogEntry = ^TLogEntry;

  TfrmLogAnalyzer = class(TForm)
    pnlTop: TPanel;
    btnFileSelect: TButton;
    btnAnalyze: TButton;
    edLogFile: TLabeledEdit;
    dlgOpen: TOpenDialog;
    Label1: TLabel;
    pnlClient: TPanel;
    vstForms: TVirtualEditTree;
    Splitter1: TSplitter;
    memoText: TMemo;
    edLogSize: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btnFileSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure vstFormsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstFormsInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var ChildCount: Cardinal);
    procedure vstFormsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstFormsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstFormsDblClick(Sender: TObject);
    procedure vstFormsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstFormsCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstFormsHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    LogEntries: array of TLogEntry;
    LogPlugins: array of TLogEntry;
    ProcessLog: function (const aFileName: String): Boolean of object;
//    function FormIDFromString(s: String): String;
    function BracketedFormIDFromString(s: String; Brackets: string = '()'): String;
    function RecordByLoadOrderFormID(FormID: TwbFormID): IwbMainRecord;
    procedure BuildPluginsList;
    function ParsePapyrusData(const aData: String): Boolean;
    function ReadPapyrusLog(const aFileName: String): Boolean;
    function ParseRuntimeScriptProfilerData(const aData: String): Boolean;
    function ReadRuntimeScriptProfilerLog(const aFileName: String): Boolean;
  public
    { Public declarations }
    lDataPath, lMyGamesTheGamePath: string;
    ltLog: TLogType;
    MaxLogSize: integer;
    FormIDErrors: integer;
    PFiles: ^TDynFiles;
    JumpTo: procedure (aInterface: IInterface; aBackward: Boolean) of object;
  end;

  // modified version from
  // http://stackoverflow.com/questions/2815839/delphi-alternative-to-using-reset-readln-for-text-file-reading
  TTextStream = class(TObject)
  private
    FHost: TStream;
    FOffset, FSize, FLimit: Integer;
    FBuffer: array[0..4095] of AnsiChar;
    FEOF: Boolean;
    function FillBuffer: Boolean;
  protected
    property Host: TStream read FHost;
  public
    constructor Create(AHost: TStream);
    destructor Destroy; override;
    function ReadLn: string; overload;
    function ReadLn(out Line: string): Boolean; overload;
    property EOF: Boolean read FEOF;
    property HostStream: TStream read FHost;
    property Offset: Integer read FOffset write FOffset;
    property Limit: Integer read FLimit write FLimit;
  end;

implementation

uses
  frmViewMain;

{$R *.dfm}

const
  sLineBreak = {$IFDEF LINUX} AnsiChar(#10) {$ENDIF}
               {$IFDEF MSWINDOWS} AnsiString(#13#10) {$ENDIF};

type
  TTreeData = record
    PEntry: PLogEntry;
  end;
  PTreeData = ^TTreeData;

{ TTextStream }

constructor TTextStream.Create(AHost: TStream);
begin
  FHost := AHost;
  FillBuffer;
end;

destructor TTextStream.Destroy;
begin
  FHost.Free;
  inherited Destroy;
end;

function TTextStream.FillBuffer: Boolean;
begin
  FOffset := 0;
  FSize := FHost.Read(FBuffer, SizeOf(FBuffer));
  if (FLimit > 0) and (FHost.Position > FLimit) then
    FSize := 0;
  Result := (FSize > 0);
  FEOF := Result;
end;

function TTextStream.ReadLn(out Line: string): Boolean;
var
  Len, Start: Integer;
  Data: AnsiString;
  EOLChar: AnsiChar;
begin
  Data := '';
  Line := '';
  Result := False;
  try
    repeat
      if FOffset>=FSize then
        if not FillBuffer then
          Exit; // no more data to read from stream -> exit
      Result:=True;
      Start:=FOffset;
      while (FOffset<FSize) and (not (FBuffer[FOffset] in [#13,#10])) do
        Inc(FOffset);
      Len:=FOffset-Start;
      if Len>0 then begin
        SetLength(Data,Length(Data)+Len);
        Move(FBuffer[Start],Data[Succ(Length(Data)-Len)],Len);
      end else
        Data:='';
    until FOffset<>FSize; // EOL char found
    EOLChar:=FBuffer[FOffset];
    Inc(FOffset);
    if (FOffset=FSize) then
      if not FillBuffer then
        Exit;
    if FBuffer[FOffset] in ([#13,#10]-[EOLChar]) then begin
      Inc(FOffset);
      if (FOffset=FSize) then
        FillBuffer;
    end;
  finally
    Line := Data;
  end;
end;

function TTextStream.ReadLn: string;
begin
  ReadLn(Result);
end;

{ TfrmLogAnalyzer }

function TfrmLogAnalyzer.RecordByLoadOrderFormID(FormID: TwbFormID): IwbMainRecord;
var
  _File  : IwbFile;
  FileID : TwbFileID;
  j      : integer;
begin
  Result := nil;
  FileID := FormID.FileID;

  if FileID.FullSlot = $FF then
    Exit;

  _File := nil;
  j := Low(PFiles^);
  while (j <= High(PFiles^)) and not Assigned(_File) do begin
    if PFiles^[j].LoadOrderFileID = FileID then
      _File := PFiles^[j];
    Inc(j);
  end;
  while Assigned(_File) do begin
    Result := _File.RecordByFormID[FormID.ChangeFileID(_File.FileFileID[True]), True, True];
    if Assigned(Result) then
      Exit;

    _File := nil;
    while (j <= High(PFiles^)) and not Assigned(_File) do begin
      if PFiles^[j].LoadOrderFileID = FileID then
        _File := PFiles^[j];
      Inc(j);
    end;
  end;
end;

procedure TfrmLogAnalyzer.vstFormsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeData;
  MainRecord: IwbMainRecord;
begin
  Data := Sender.GetNodeData(Node);
  if not Assigned(Data) then
    Exit;

  case ltLog of
    ltTES4RuntimeScriptProfiler: begin
      if Node.Parent = Sender.RootNode then
        memoText.Lines.Text := Data.PEntry.Text
      else begin
        memoText.Lines.Clear;
        memoText.Lines.Add(Format('; RuntimeScriptProfiler - max execution time: %.4n ms', [Data.PEntry.Value3]));
        if Supports(Data.PEntry.Element, IwbMainRecord, MainRecord) then
          memoText.Lines.Add(MainRecord.ElementEditValues['SCTX']);
      end;
    end;
    ltTES5Papyrus: begin
      memoText.Lines.Text := Data.PEntry.Text;
    end;
  end;
  // scroll memo to the top
  memoText.SelStart := 0;
  memoText.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TfrmLogAnalyzer.vstFormsCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  PEntry1, PEntry2: PLogEntry;
begin
  Result := 0;
  PEntry1 := PTreeData(Sender.GetNodeData(Node1)).PEntry;
  PEntry2 := PTreeData(Sender.GetNodeData(Node2)).PEntry;

  case Column of
    0: Result := TwbFormID.Compare(PEntry1.FormID, PEntry2.FormID);
    1: Result := Comparetext(PEntry1.Text, PEntry2.Text);
    2: Result := CmpI32(round(PEntry1.Value1), round(PEntry2.Value1));
    3: Result := CmpI32(round(PEntry1.Value2), round(PEntry2.Value2));
  end;
end;

procedure TfrmLogAnalyzer.vstFormsDblClick(Sender: TObject);
var
  Data: PTreeData;
begin
  if not Assigned(JumpTo) then
    Exit;

  Data := vstForms.GetNodeData(vstForms.FocusedNode);

  if not Assigned(Data) then
    Exit;

  JumpTo(Data.PEntry.Element, False);
end;

procedure TfrmLogAnalyzer.vstFormsFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  with PTreeData(Sender.GetNodeData(Node))^ do begin
    PEntry.Element := nil;
  end;
end;

procedure TfrmLogAnalyzer.vstFormsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PTreeData;
  MainRecord: IwbMainRecord;
  IsPlugin: Boolean;
begin
  Data := Sender.GetNodeData(Node);
  IsPlugin := (Supports(Data.PEntry.Element, IwbFile) or (Node.Parent = Sender.RootNode));
  case Column of
    0: begin
      if IsPlugin then
        CellText := Data.PEntry.Text
      else
        CellText := Data.PEntry.FormID.ToString(True)
    end;
    1: begin
      if Supports(Data.PEntry.Element, IwbMainRecord, MainRecord) then
        CellText := MainRecord.Name
      else
        CellText := '';
    end;
    2: begin
      CellText := Format('%.0n', [Round(Data.PEntry.Value1) + 0.0]);
    end;
    3: begin
      CellText := Format('%.0n', [Round(Data.PEntry.Value2) + 0.0]);
    end;
  end;
end;

procedure TfrmLogAnalyzer.vstFormsHeaderClick(Sender: TVTHeader;
  HitInfo: TVTHeaderHitInfo);
begin
  with HitInfo do begin
    if Button <> mbLeft then
      Exit;

    if Sender.SortColumn = Column then
      if Sender.SortDirection = sdAscending then
        Sender.SortDirection := sdDescending
      else
        Sender.SortDirection := sdAscending
    else begin
      Sender.SortColumn := Column;
    end;
    vstForms.ScrollIntoView(vstForms.FocusedNode, True);
  end;
end;

procedure TfrmLogAnalyzer.vstFormsInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  Data: PTreeData;
  i: integer;
begin
  Data := Sender.GetNodeData(Node);
  ChildCount := 0;
  for i := Low(LogEntries) to High(LogEntries) do
    if LogEntries[i].LoadOrder = Data.PEntry.LoadOrder then
      Inc(ChildCount);
end;

procedure TfrmLogAnalyzer.vstFormsInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PTreeData;
  lo, i, j: integer;
begin
  Data := Sender.GetNodeData(Node);
  if ParentNode = nil then begin
    Data.PEntry := @LogPlugins[Node.Index];
    Include(InitialStates, ivsHasChildren);
  end else begin
    lo := PTreeData(Sender.GetNodeData(Node.Parent)).PEntry.LoadOrder;
    j := 0;
    for i := Low(LogEntries) to High(LogEntries) do
      if LogEntries[i].LoadOrder = lo then begin
        if j = Node.Index then
          Data.PEntry := @LogEntries[i];
        Inc(j);
      end;
  end;
end;

function IsHex(c: char): boolean;
begin
  Result := c in ['0'..'9', 'A'..'F'];
end;

function IsHexStr(s: string): boolean;
var
  i: integer;
begin
  Result := True;
  for i := 1 to Length(s) do begin
    Result := Result and IsHex(s[i]);
    if not Result then
      Exit;
  end;
  if Length(s) = 0 then
    Result := False;
end;

//function TfrmLogAnalyzer.FormIDFromString(s: String): String;
//var
//  i: integer;
//  f: string;
//begin
//  Result := '';
//  for i := 1 to Length(s) - 7 do begin
//    f := Copy(s, i, 8);
//    if IsHexStr(f) then begin
//      Result := f;
//      Exit;
//    end;
//  end;
//end;

function TfrmLogAnalyzer.BracketedFormIDFromString(s: String; Brackets: string = '()'): String;
var
  i: integer;
  f: string;
begin
  Result := '';
  for i := 1 to Length(s) - 9 do
    if (s[i] = Brackets[1]) and (s[i+9] = Brackets[2]) then begin
      f := Copy(s, i + 1, 8);
      if IsHexStr(f) then begin
        Result := f;
        Exit;
      end;
    end;
end;

function TfrmLogAnalyzer.ParsePapyrusData(const aData: String): Boolean;
var
  s, txt: string;
  IsError: boolean;
  IsWarning: boolean;
  i: integer;
  fid: TwbFormID;
  elem: IwbElement;
begin
  Result := True;
  IsError := False;
  IsWarning := False;

  // skip papyrus timestamp
  txt := trim(Copy(aData, 27, Length(aData)));
  if Copy(txt, 1, 6) = 'error:' then IsError := True else
    if Copy(txt, 1, 8) = 'warning:' then IsWarning := True;

  if not (IsError or IsWarning) then
    Exit;

  s := BracketedFormIDFromString(txt);

  if s = '' then begin
    // check for "saved game" messages
    if
      (Pos('[None].', txt) > 0) or
      (Pos('in the type table in save', txt) > 0) or
      (Pos('referenced by the save game', txt) > 0)
    then
      fid := TwbFormID.FromCardinal($FF000000)
    else
      Exit;
  end else
    fid := TwbFormID.FromStrDef(s, 0);

  for i := Low(LogEntries) to High(LogEntries) do
    if LogEntries[i].FormID = fid then begin
      if IsError then LogEntries[i].Value1 := LogEntries[i].Value1 + 1 else
        if IsWarning then LogEntries[i].Value2 := LogEntries[i].Value2 + 1;
      if Pos(txt, LogEntries[i].Text) = 0 then
        LogEntries[i].Text := LogEntries[i].Text + sLineBreak + sLineBreak + txt;
      Exit;
    end;

  elem := RecordByLoadOrderFormID(fid);
  if (fid.FileID.FullSlot <> $FF) and not Assigned(elem) then begin
    if FormIDErrors = 0 then
      memoText.Lines.Add('Unknown FormID [' + s + '], changed load order? All other unknown forms will be ignored.');
    Inc(FormIDErrors);
    Exit;
  end;

  SetLength(LogEntries, Succ(Length(LogEntries)));
  with LogEntries[Pred(Length(LogEntries))] do begin
    FormID := fid;
    LoadOrder := FormID.FileID.FullSlot;
    Element := elem;
    Text := txt;
    if IsError then Value1 := 1 else Value1 := 0;
    if IsWarning then Value2 := 1 else Value2 := 0;
  end;
end;

function TfrmLogAnalyzer.ReadPapyrusLog(const aFileName: String): Boolean;
var
  sLine: string;
  Entry: string;
begin
  Result := True;
  Entry := '';
  with TTextStream.Create(TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite)) do try
    Limit := MaxLogSize;
    while ReadLn(sLine) do begin
      if (Length(sLine) > 25) and (sLine[1] = '[') and (sLine[2] in ['0'..'9']) then begin
        if Length(Entry) > 0 then
          ParsePapyrusData(Entry);
        Entry := sLine;
      end else begin
        if Length(Entry) > 0 then
          Entry := Entry + sLineBreak;
        Entry := Entry + sLine;
      end;
    end;
    if Length(Entry) > 0 then
      ParsePapyrusData(Entry);
  finally
    Free;
  end;
end;

function TfrmLogAnalyzer.ParseRuntimeScriptProfilerData(const aData: String): Boolean;
var
  s, txt, sTime: string;
  fTime: single;
  i: integer;
  fid: TwbFormID;
  elem: IwbElement;
begin
  Result := True;

  s := Copy(aData, 1, 8);

  if s = '' then
    Exit;

  fid := TwbFormID.FromStrDef(s, 0);

  sTime := Copy(aData, 18, Length(aData));
  sTime := Copy(sTime, 1, Pos(' ', sTime));
  fTime := StrToFloatDef(sTime, 0);

  for i := Low(LogEntries) to High(LogEntries) do
    if LogEntries[i].FormID = fid then with LogEntries[i] do begin
      // times executed
      Value1 := Value1 + 1;
      // total time
      Value2 := Value2 + fTime;
      // max execution time
      if fTime > Value3 then Value3 := fTime;
      Exit;
    end;

  elem := RecordByLoadOrderFormID(fid);
  if (fid.FileID.FullSlot <> $FF) and not Assigned(elem) then begin
    if FormIDErrors = 0 then
      memoText.Lines.Add('Unknown FormID [' + s + '], changed load order? All other unknown forms will be ignored.');
    Inc(FormIDErrors);
    Exit;
  end;

  SetLength(LogEntries, Succ(Length(LogEntries)));
  with LogEntries[Pred(Length(LogEntries))] do begin
    FormID := fid;
    LoadOrder := FormID.FileID.FullSlot;
    Element := elem;
    Text := txt;
    Value1 := 1;
    Value2 := fTime;
    Value3 := fTime;
  end;

end;

function TfrmLogAnalyzer.ReadRuntimeScriptProfilerLog(const aFileName: String): Boolean;
var
  sLine: string;
begin
  Result := True;
  with TTextStream.Create(TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite)) do try
    Limit := MaxLogSize;
    while ReadLn(sLine) do begin
      if (Length(sLine) > 9) and IsHexStr(Copy(sLine, 1, 8)) and (sLine[9] = #9) then
        if not ParseRuntimeScriptProfilerData(sLine) then begin
          Result := False;
          Exit;
        end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmLogAnalyzer.BuildPluginsList;

  procedure QuickSort(var A: array of TLogEntry; iLo, iHi: Integer);
	var
	  Lo, Hi, Pivot: Integer;
	  T: TLogEntry;
	begin
	  Lo := iLo;
	  Hi := iHi;
	  Pivot := A[(Lo + Hi) div 2].LoadOrder;
	  repeat
	    while A[Lo].LoadOrder < Pivot do Inc(Lo);
	    while A[Hi].LoadOrder > Pivot do Dec(Hi);
	    if Lo <= Hi then begin
	      T := A[Lo];
	      A[Lo] := A[Hi];
	      A[Hi] := T;
	      Inc(Lo);
	      Dec(Hi);
	    end;
	  until Lo > Hi;
	  if Hi > iLo then QuickSort(A, iLo, Hi);
	  if Lo < iHi then QuickSort(A, Lo, iHi);
	end;

var
  i, j: integer;
  fExists: boolean;
begin
  // make a list of affected plugins
  for i := Low(LogEntries) to High(LogEntries) do begin
    fExists := false;
    for j := Low(LogPlugins) to High(LogPlugins) do
      if LogPlugins[j].LoadOrder = LogEntries[i].LoadOrder then begin
        LogPlugins[j].Value1 := LogPlugins[j].Value1 + LogEntries[i].Value1;
        LogPlugins[j].Value2 := LogPlugins[j].Value2 + LogEntries[i].Value2;
        LogPlugins[j].Value3 := LogPlugins[j].Value3 + LogEntries[i].Value3;
        fExists := true;
        Break;
      end;
    if not fExists then begin
      SetLength(LogPlugins, Succ(Length(LogPlugins)));
      with LogPlugins[Pred(Length(LogPlugins))] do begin
        Value1 := LogEntries[i].Value1;
        Value2 := LogEntries[i].Value2;
        Value3 := LogEntries[i].Value3;
        LoadOrder := LogEntries[i].LoadOrder;
        if LoadOrder = $FF then
          Text := '[FF] Saved game'
        else
          if Assigned(LogEntries[i].Element) then begin
            if Assigned(LogEntries[i].Element._File) then begin
              Element := LogEntries[i].Element._File;
              Text := Element.Name;
            end;
          end else
            Text := 'Unknown';
      end;
    end;
  end;
  // sort plugins by load order
  if Length(LogPlugins) > 0 then
  	QuickSort(LogPlugins, Low(LogPlugins), High(LogPlugins));
end;

procedure TfrmLogAnalyzer.btnAnalyzeClick(Sender: TObject);
begin
  if not FileExists(edLogFile.Text) then begin
    memoText.Lines.Add('File does not exist');
    Exit;
  end;

  if not Assigned(ProcessLog) then
    Exit;

  vstForms.Clear;
  memoText.Lines.Clear;
  SetLength(LogPlugins, 0);
  SetLength(LogEntries, 0);

  MaxLogSize := StrToIntDef(edLogSize.Text, 0)*1024*1024;
  FormIDErrors := 0;
  Enabled := False;
  Application.ProcessMessages;
  try
    memoText.Lines.Add('Processing log...');
    if ProcessLog(edLogFile.Text) then begin
      BuildPluginsList;
      vstForms.NodeDataSize := SizeOf(TTreeData);
      vstForms.RootNodeCount := Length(LogPlugins);
      if FormIDErrors > 0 then
        memoText.Lines.Add(Format('Ignored %d unknown FormIDs', [FormIDErrors]));
      memoText.Lines.Add('Done.');
      memoText.Lines.Add('Hint: double click on FormID to jump to that record');
    end else begin
      SetLength(LogPlugins, 0);
      SetLength(LogEntries, 0);
    end;
  finally
    Enabled := True;
  end;
end;

procedure TfrmLogAnalyzer.btnFileSelectClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edLogFile.Text := dlgOpen.FileName;
end;

procedure TfrmLogAnalyzer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmLogAnalyzer.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);
end;

procedure TfrmLogAnalyzer.FormShow(Sender: TObject);
begin
  case ltLog of
    ltTES4RuntimeScriptProfiler: begin
      edLogFile.Text := ExtractFilePath(ExcludeTrailingBackslash(lDataPath)) + 'RuntimeScriptProfiler.log';
      ProcessLog := ReadRuntimeScriptProfilerLog;
      vstForms.Header.Columns[2].Width := 100;
      vstForms.Header.Columns[2].Text := 'Frames Executed';
      vstForms.Header.Columns[2].Width := 100;
      vstForms.Header.Columns[3].Text := 'Total Time, ms';
      memoText.Lines.Add('RuntimeScriptProfiler by ShadeMe');
      memoText.Lines.Add('http://www.oblivion.nexusmods.com/mods/41863');
    end;
    ltTES5Papyrus: begin
      edLogFile.Text := lMyGamesTheGamePath + 'Logs\Script\Papyrus.0.log';
      ProcessLog := ReadPapyrusLog;
      vstForms.Header.Columns[2].Width := 100;
      vstForms.Header.Columns[2].Text := 'Errors';
      vstForms.Header.Columns[2].Width := 100;
      vstForms.Header.Columns[3].Text := 'Warnings';
      memoText.Lines.Add('How to enable logging');
      memoText.Lines.Add('http://www.creationkit.com/FAQ:_My_Script_Doesn''t_Work!');
      memoText.Lines.Add('Papyrus errors description');
      memoText.Lines.Add('http://www.creationkit.com/Papyrus_Runtime_Errors');
    end;
  end;
  dlgOpen.InitialDir := ExtractFilePath(edLogFile.Text);
  dlgOpen.FileName := ExtractFileName(edLogFile.Text);
end;

end.
