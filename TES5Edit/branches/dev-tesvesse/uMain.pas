unit uMain;

{$IF CompilerVersion >= 17} {$DEFINE USEREGION} {$IFEND}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, ExtCtrls, ComCtrls, CommCtrl, uESSFile, Grids,
  Buttons, Menus, Helper, VistaProgressBar, GlassButton, XPMenu, ImgList, HexEdit,
  ShlObj, uCompare;

type
  TfMain = class(TForm)
    spSplit: TSplitter;
    pnWorkplace: TPanel;
    pnStatus: TPanel;
    pcEditors: TPageControl;
    sdSave: TSaveDialog;
    imMain: TImage;
    lbMain: TLabel;
    imScreen: TImage;
    pnScreen: TPanel;
    cbScreenCenter, cbScreenProportional, cbScreenStrech: TCheckBox;
    pnData: TPanel;
    odBinOpen: TOpenDialog;
    sdBinSave: TSaveDialog;
    lbIntDec, lbIntHex, lbIntBin: TLabel;
    sb00, sb01, sb02, sb03, sb04, sb05, sb06, sb07: TSpeedButton;
    sb08, sb09, sb10, sb11, sb12, sb13, sb14, sb15: TSpeedButton;
    sb16, sb17, sb18, sb19, sb20, sb21, sb22, sb23: TSpeedButton;
    sb24, sb25, sb26, sb27, sb28, sb29, sb30, sb31: TSpeedButton;
    edIntDec, edIntHex, edIntBin: TEdit;
    pmSave: TPopupMenu;
    pmiNormal, pmiUncompress, pmiCompress: TMenuItem;
    lbRODec, lbROHex, lbROBin: TLabel;
    edRODec, edROHex, edROBin: TEdit;
    lbReadOnly: TLabel;
    lbCalc: TLabel;
    lbRange: TLabel;
    edWString: TEdit;
    edFloat: TEdit;
    tsMain, tsScreen, tsData, tsInteger, tsReadCalc, tsString, tsFloat, tsFlags, tsGD01, tsGD02: TTabSheet;
    tvFlags: TTreeView;
    pcGD01: TPageControl;
    tsGD01General, tsGD01Quest, tsGD01Combat, tsGD01Magic, tsGD01Crafting, tsGD01Crime: TTabSheet;
    lvGD01General, lvGD01Quest, lvGD01Combat, lvGD01Magic, lvGD01Crafting, lvGD01Crime: TListView;
    lvGD02: TListView;
    imImages: TImageList;
    imLogo: TImage;
    tsGD04: TTabSheet;
    lvGD04: TListView;
    sgHeader: TStringGrid;
    tsForms: TTabSheet;
    lvForms: TListView;
    tsGD01All: TTabSheet;
    lvGD01All: TListView;
    pnGD01All: TPanel;
    pnForms: TPanel;
    pnGD04: TPanel;
    sdCSVSave: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure spSplitMoved(Sender: TObject);
    procedure btnBreakClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtStructureGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure vtStructureFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtStructureInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure odOpenSelectionChange(Sender: TObject);
    procedure tsScreenShow(Sender: TObject);
    procedure cbScreenClick(Sender: TObject);
    procedure tsMainShow(Sender: TObject);
    procedure vtStructureChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure btnExportClick(Sender: TObject);
    procedure btnFormsClick(Sender: TObject);
    procedure btnFormsDataClick(Sender: TObject);
    procedure btnGD01AllClick(Sender: TObject);
    procedure btnGD04Click(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnFirstACHRClick(Sender: TObject);
    procedure btnFirstNPCClick(Sender: TObject);
    procedure tsIntegerShow(Sender: TObject);
    procedure edChange(Sender: TObject);
    procedure edKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
    procedure pmiClick(Sender: TObject);
    procedure tsReadCalcShow(Sender: TObject);
    procedure tsStringShow(Sender: TObject);
    procedure tsFloatShow(Sender: TObject);
    procedure pcGD01DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tsGD01Show(Sender: TObject);
    procedure lvEdited(Sender: TObject; Item: TListItem; var S: string);
    procedure lvKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tsFlagsShow(Sender: TObject);
    procedure tvFlagsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvColumnClick(Sender: TObject; Col: TListColumn);
    procedure tsGD02Show(Sender: TObject);
    procedure lvGD02Edited(Sender: TObject; Item: TListItem; var S: string);
    procedure tsGD04Show(Sender: TObject);
    procedure lvGD04Edited(Sender: TObject; Item: TListItem; var S: string);
    procedure sgHeaderDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure tsFormsShow(Sender: TObject);
    procedure lvFormsData(Sender: TObject; Item: TListItem);
    procedure lvFormsColumnClick(Sender: TObject; Col: TListColumn);
    procedure lvFormsDblClick(Sender: TObject);
  private
    odOpen: TExOpenDialog;
    vtStructure: TVirtualStringTree;                 sFileName: string;
    ESSFile: TESSFile;
    bBreak: Boolean;
    BufNode: PVirtualNode;
    BufData: TBytes;
    pbProcess: TVistaProgressBar;
    heEdit: THexEditor;
    btnOpen, btnCompare, btnFirstACHR, btnFirstNPC, btnSave, btnBreak, btnExport, btnImport: TGlassButton;
    btnForms, btnFormsData, btnGD01All, btnGD04: TGlassButton;
    FormViews: TFormViews;
    procedure Progress(const Percent: Integer; var Break: Boolean);
    procedure FillTree;
    procedure PrepareDataToShow;
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

type
  THackPanel = class(TCustomPanel);
  TStatCategory = (scGeneral, scQuest, scCombat, scMagic, scCrafting, scCrime);

{$IF Defined(USEREGION)}{$REGION 'ExOpenDialog'}{$IFEND}
procedure TfMain.odOpenSelectionChange(Sender: TObject);
var
  ESSFileInfo: TESSFileInfo;
  bmpPicture: TBitmap;
begin
  with odOpen do
    if FileExists(FileName) then
    begin
      if ReadESSFileInfo(ESSFileInfo, FileName) = 0 then
        with ESSFileInfo do
        begin
          bmpPicture := ScreenShotToBMP(shotWidth, shotHeight, screenshotData);
          try
            imPicture.Picture.Assign(bmpPicture);
            if bmpPicture.Height > 0 then
              imPicture.Width := Round(bmpPicture.Width * (imPicture.Height / bmpPicture.Height));
            lbInfo.Left := imPicture.Width + 10;
            lbInfo.Caption := 'Save No: ' + IntToStr(saveNumber) + #13'Player: ' + playerName + #13'Level: ' + IntToStr(playerLevel) +
                              #13'Race: ' + playerRaceEditorId + #13'Location: ' + playerLocation + #13'Date: ' + gameDate;
          finally
            bmpPicture.Free;
          end;
        end
      else
      begin
        imPicture.Picture := nil;
        lbInfo.Left := 10;
        lbInfo.Caption := 'Can''t read file or file isn''t Skyrim ESS file';
      end;
    end
    else
    begin
      imPicture.Picture := nil;
      lbInfo.Caption := '';
    end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.pcGD01DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  R: TRect;
begin
  with Control.Canvas do
  begin
    Brush.Color := $00F0F0F0;
    Font.Color := clBtnText;
    R := Rect;
    FillRect(R);
    DrawText(Handle, PChar(TTabControl(Control).Tabs[Tabindex]), Length(TTabControl(Control).Tabs[Tabindex]), R, DT_VCENTER or DT_CENTER or DT_WORDBREAK or DT_NOPREFIX or DT_SINGLELINE);
  end;
end;

procedure TfMain.pmiClick(Sender: TObject);
var
  Res: Integer;
begin
  Res := 0;
  if Sender is TMenuItem then
    with Sender as TMenuItem do
      if sdSave.Execute then
      try
        bBreak := False;
        CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
        case Tag of
          0: Res := SaveESSFile(ESSFile, sdSave.FileName, Progress);
          1: Res := SaveESSFileUncompressed(ESSFile, sdSave.FileName, Progress);
          2: Res := SaveESSFileCompressed(ESSFile, sdSave.FileName, Progress);
        end;
        case Res of
          -2: MessageBox(Handle, 'Wrong data', 'Error', MB_OK or MB_ICONSTOP);
          -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
           0: begin
                sFileName := sdSave.FileName;
                pnStatus.Caption := MinimizeName(sFileName, THackPanel(pnStatus).Canvas, pnStatus.ClientWidth - 8);
              end
          else
            MessageBox(Handle, PChar('Write error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
        end;
      finally
        FreeProgress(btnBreak, pbProcess, pnStatus);
        PrepareDataToShow;
      end;
end;

procedure TfMain.btnBreakClick(Sender: TObject);
begin
  bBreak := True;
end;

procedure TfMain.Progress(const Percent: Integer; var Break: Boolean);
begin
  if Assigned(pbProcess) then
    pbProcess.Position := Percent;
  Break := bBreak;
  Application.ProcessMessages;
end;

{$IF Defined(USEREGION)}{$REGION 'Export data'}{$IFEND}
procedure TfMain.btnExportClick(Sender: TObject);
var
  sName: string;
  f: File;
  Res: Integer;
  MyData: PMyRec;
begin
  if BufNode = nil then
    Exit;
  MyData := vtStructure.GetNodeData(BufNode);
  if BufNode^.Parent <> nil then
    sName := IntToStr(BufNode^.Parent^.Index + 1) + '_'
  else
    sName := IntToStr(BufNode^.Index + 1) + '_';
  if Assigned(MyData) then
  begin
    case MyData^._Type of
      btGlobal:
        if (BufNode^.Parent <> nil) and (BufNode^.Parent^.Parent <> nil) then
          case BufNode^.Parent^.Parent^.Index of
            8: sName := sName + GetTypeString(ESSFile.globalDataTable1[BufNode^.Parent^.Index]._type);
            9: sName := sName + GetTypeString(ESSFile.globalDataTable2[BufNode^.Parent^.Index]._type);
            11: sName := sName + GetTypeString(ESSFile.globalDataTable3[BufNode^.Parent^.Index]._type);
          end;
      btForm:
        sName := sName + Copy(GetFormString(ESSFile.changeForms[BufNode^.Parent^.Index]._type), 1, 4);
    end;
    sName := sName + '.BIN';
    if (sdBinSave.FileName = '') and (BufNode <> nil) then
      sdBinSave.FileName := ExtractFilePath(ParamStr(0)) + sName
    else
      sdBinSave.FileName := ExtractFilePath(sdBinSave.FileName) + sName;
    ReadHexEditor(BufData, heEdit);
    if (Length(BufData) > 0) and sdBinSave.Execute then
    begin
      AssignFile(F, sdBinSave.FileName);
      {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
      ReWrite(F, 1);
      Res := IOResult;
      if Res = 0 then
      try
        BlockWrite(f, BufData[0], Length(BufData));
        Res := IOResult;
        if Res <> 0 then
          MessageBox(Handle, PChar('Can''t write to selected file:'#13 + sdBinSave.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
      finally
        CloseFile(f);
      end
      else
        MessageBox(Handle, PChar('Can''t create selected file:'#13 + sdBinSave.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
      {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
    end;
  end;
end;

procedure TfMain.btnFormsClick(Sender: TObject);
var
  sList: TStringList;
  i: integer;
  sLine: string;
begin
  if sdCSVSave.Execute then
  begin
    sList := TStringList.Create;
    try
      for i := 0 to Length(FormViews) - 1 do
        with FormViews[i], Form do
        begin
          sLine := IntToStr(No);
          sLine := sLine + ListSeparator + RefIDToString(Form.formID);
          sLine := sLine + ListSeparator + IntToHex(changeFlags, 8);
          sLine := sLine + ListSeparator + IntToStr(changeFlags);
          sLine := sLine + ListSeparator + IntToStr(Form._type);
          sLine := sLine + ListSeparator + Copy(GetFormString(Form._type), 1, 4);
          sLine := sLine + ListSeparator + IntToStr(Form.version);
          sLine := sLine + ListSeparator + IntToStr(Form.length1);
          if length2 > 0 then
            sLine := sLine + ListSeparator + IntToStr(Form.length2);
          sList.Add(sLine);
      end;
      sList.SaveToFile(sdCSVSave.FileName);
    finally
      sList.Free
    end;
  end;
end;

procedure TfMain.btnFormsDataClick(Sender: TObject);
var
  sOutDir: string;
  i: integer;
  Buff: TBytes;
  F: File;
begin
  if SelectDirectoryEx(Handle, sOutDir, 'Select output directory:', '', BIF_RETURNONLYFSDIRS or $40 or BIF_VALIDATE, @CallBack) then
  begin
    if (sOutDir <> '') and (sOutDir[Length(sOutDir)] <> '\') then
      sOutDir := sOutDir + '\';
    if (sOutDir <> '') and (ESSFile.magic = C_TESVESS) then
    try
      bBreak := False;
      CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
      for i := 0 to Length(FormViews) - 1 do
        with FormViews[i] do
        begin
          SetLength(Buff, ESSFile.ChangeForms[No].length1);
          if ESSFile.ChangeForms[No].length1 > 0 then
            Move(ESSFile.ChangeForms[No].Data[0], Buff[0], ESSFile.ChangeForms[No].length1);
          if ESSFile.ChangeForms[No].length2 > 0 then
            DecompressData(Buff, ESSFile.ChangeForms[No].length2);
          AssignFile(F, sOutDir + RefIDToHex(ESSFile.ChangeForms[No].formID) + '.BIN');
          {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
          ReWrite(F, 1);
          if IOResult = 0 then
          try
            if Length(Buff) > 0 then
              BlockWrite(f, Buff[0], Length(Buff));
          finally
            CloseFile(F);
          end;
          {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
          if Round((i + 1) / Length(FormViews) * 100) > pbProcess.Position then
          begin
            pbProcess.Position := Round((i + 1) / Length(FormViews) * 100);
            Application.ProcessMessages;
          end;
          if bBreak then
            Break;
        end;
    finally
      FreeProgress(btnBreak, pbProcess, pnStatus);
    end;
  end;
end;

procedure TfMain.btnGD01AllClick(Sender: TObject);
var
  sList: TStringList;
  i: integer;
begin
  if sdCSVSave.Execute then
  begin
    sList := TStringList.Create;
    try
      with lvGD01All do
        for i := 0 to Items.Count - 1 do
          with Items[i] do
            sList.Add(Caption + ListSeparator + SubItems[0] + ListSeparator + SubItems[1]);
      sList.SaveToFile(sdCSVSave.FileName);
    finally
      sList.Free
    end;
  end;
end;

procedure TfMain.btnGD04Click(Sender: TObject);
var
  sList: TStringList;
  i: integer;
begin
  if sdCSVSave.Execute then
  begin
    sList := TStringList.Create;
    try
      with lvGD04 do
        for i := 0 to Items.Count - 1 do
          with Items[i] do
            sList.Add(Caption + ListSeparator + SubItems[0]);
      sList.SaveToFile(sdCSVSave.FileName);
    finally
      sList.Free
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Import BIN data'}{$IFEND}
procedure TfMain.btnImportClick(Sender: TObject);
var
  f: File;
  Res: Integer;
  MyData: PMyRec;
begin
  if (BufNode <> nil) and odBinOpen.Execute then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) then
    begin
      AssignFile(F, odBinOpen.FileName);
      {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
      Reset(F, 1);
      Res := IOResult;
      if Res = 0 then
      try
        try
          SetLength(BufData, FileSize(F));
          if Length(BufData) > 0 then
          begin
            BlockRead(f, BufData[0], Length(BufData));
            Res := IOResult;
            if Res <> 0 then
              MessageBox(Handle, PChar('Can''t read from selected file:'#13 + sdBinSave.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
          end;
        except
          SetLength(BufData, 0);
          MessageBox(Handle, PChar('File is to large!'), 'Error', MB_OK or MB_ICONERROR);
        end
      finally
        CloseFile(F);
      end
      else
        MessageBox(Handle, PChar('Can''t open selected file:'#13 + sdBinSave.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
      {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
      WriteHexEditor(BufData, heEdit);
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.btnFirstACHRClick(Sender: TObject);
var
  i: Integer;
begin
  with ESSFile, vtStructure do
    if magic = C_TESVESS then
      for i := 0 to Length(changeForms) - 1 do
        with changeForms[i] do
          if (_type and $3F) = 1 then
          begin
            Expanded[GetFirst(False)] := True;
            Expanded[GetChild(GetFirst(False), 10)] := True;
            FocusedNode := GetChild(GetChild(GetFirst(False), 10), i);
            Expanded[FocusedNode] := True;
            Break;
          end;

end;

procedure TfMain.btnFirstNPCClick(Sender: TObject);
var
  i: Integer;
begin
  with ESSFile, vtStructure do
    if magic = C_TESVESS then
      for i := 0 to Length(changeForms) - 1 do
        with changeForms[i] do
          if (_type and $3F) = 9 then
          begin
            Expanded[GetFirst(False)] := True;
            Expanded[GetChild(GetFirst(False), 10)] := True;
            FocusedNode := GetChild(GetChild(GetFirst(False), 10), i);
            Expanded[FocusedNode] := True;
            Break;
          end;

end;

procedure TfMain.btnOpenClick(Sender: TObject);
var
  Res: Integer;
begin
  if odOpen.Execute then
  try
    sFileName := '';
    bBreak := False;
    CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
    Res := ReadESSFile(ESSFile, odOpen.FileName, Progress);
    case Res of
      -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
      0: begin
           sFileName := odOpen.FileName;
           Exit;
         end;
      else
        MessageBox(Handle, PChar('Read error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
    end;
  finally
    FreeProgress(btnBreak, pbProcess, pnStatus);
    PrepareDataToShow;
  end;
end;

procedure TfMain.btnCompareClick(Sender: TObject);
var
  Res: Integer;
  bContinue: Boolean;
  sFile: string;
begin
  bContinue := False;
  bBreak := False;
  with TfCompare.Create(Application) do
  begin
    if odOpen.Execute then
    try
      sFile := odOpen.FileName;
      CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
      Res := ReadESSFileUncompressed(File1, odOpen.FileName, Progress);
      case Res of
        -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
        0: bContinue := True;
        else
          MessageBox(Handle, PChar('Read error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
      end;
    finally
      FreeProgress(btnBreak, pbProcess, pnStatus);
    end;
    if bContinue then
    begin
      bContinue := False;
      if odOpen.Execute then
      try
        CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
        Res := ReadESSFileUncompressed(File2, odOpen.FileName, Progress);
        case Res of
          -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
          0: bContinue := True;
          else
            MessageBox(Handle, PChar('Read error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
        end;
      finally
        FreeProgress(btnBreak, pbProcess, pnStatus);
      end;
    end;
    if bContinue then
    begin
      Show;
      Compare(sFile, odOpen.FileName);
    end;
  end;
end;

procedure TfMain.btnSaveClick(Sender: TObject);
var
  pPoint: TPoint;
begin
  with Sender as TGlassButton do
  begin
    pPoint := Parent.ClientToScreen(Point(Left, Top + Height));
    pmSave.Popup(pPoint.X, pPoint.Y);
  end;
end;

procedure TfMain.cbScreenClick(Sender: TObject);
begin
  if Sender is TCheckBox then
    with Sender as TCheckBox do
    begin
      if Sender = cbScreenCenter then
        imScreen.Center := Checked;
      if Sender = cbScreenStrech then
        imScreen.Stretch := Checked;
      if Sender = cbScreenProportional then
        imScreen.Proportional := Checked;
    end;
end;

procedure TfMain.edChange(Sender: TObject);
var
  i64: Int64;
  MyData: PMyRec;
  {$IF Defined(USEREGION)}{$REGION 'SetIntValue'}{$IFEND}
  procedure SetDec;
  begin
    edIntDec.Text := IntToStr(i64);
  end;
  procedure SetHex;
  var
    sVal: string;
  begin
    sVal := IntToHex(i64, 8);
    while (sVal <> '') and (sVal[1] = '0') do
      Delete(sVal, 1, 1);
    edIntHex.Text := sVal;
  end;
  procedure SetBin;
  var
    sVal: string;
  begin
    sVal := IntToBin(i64, 32);
    while (sVal <> '') and (sVal[1] = '0') do
      Delete(sVal, 1, 1);
    edIntBin.Text := sVal;
  end;
  procedure SetButtons;
  var
    i: Integer;
  begin
    with Self do
      for i := 0 to ComponentCount - 1 do
        if (Components[i] is TSpeedButton) and ((Components[i] as TSpeedButton).Parent = tsInteger) then
          if (i64 and (1 shl Components[i].Tag)) <> 0 then
            (Components[i] as TSpeedButton).Caption := '1'
          else
            (Components[i] as TSpeedButton).Caption := '0';
  end;
  function GetButtons: Int64;
  var
    i: Integer;
  begin
    Result := 0;
    with Self do
      for i := 0 to ComponentCount - 1 do
        if (Components[i] is TSpeedButton) and ((Components[i] as TSpeedButton).Parent = tsInteger) then
          if (Components[i] as TSpeedButton).Caption = '1' then
            Result := Result or (1 shl Components[i].Tag);
  end;
  {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type in [btInt, btHex]) then
    begin
      edIntDec.OnChange := nil;
      edIntHex.OnChange := nil;
      edIntBin.OnChange := nil;
      if Sender is TEdit then
        if (Sender as TEdit).Text <> '' then
        begin
          if Sender = edIntDec then
            i64 := UInt32(StrToInt64((Sender as TEdit).Text));
          if Sender = edIntHex then
            i64 := StrToInt64('$' + (Sender as TEdit).Text);
          if Sender = edIntBin then
            i64 := BinToInt((Sender as TEdit).Text);
        end
        else
          i64 := 0;
      if Sender is TSpeedButton then
      begin
        with Sender as TSpeedButton do
          if Caption = '1' then
            Caption := '0'
          else
            Caption := '1';
        i64 := GetButtons;
      end;
      edIntDec.Font.Color := clWindowText;
      edIntHex.Font.Color := clWindowText;
      edIntBin.Font.Color := clWindowText;
      case MyData^._Size of
        4: begin
             if Sender is TEdit then
               if (i64 shr 32) > 0 then
                 (Sender as TEdit).Font.Color := clRed;
             i64 := uint32(i64);
           end;
        2: begin
             if Sender is TEdit then
               if (i64 shr 16) > 0 then
                 (Sender as TEdit).Font.Color := clRed;
             i64 := uint16(i64);
           end
        else
        begin
          if Sender is TEdit then
            if (i64 shr 8) > 0 then
              (Sender as TEdit).Font.Color := clRed;
          i64 := uint8(i64);
        end;
      end;
      if Sender <> edIntDec then
        SetDec;
      if Sender <> edIntHex then
        SetHex;
      if Sender <> edIntBin then
        SetBin;
      if not (Sender is TSpeedButton) then
        SetButtons;
      edIntDec.OnChange := edChange;
      edIntHex.OnChange := edChange;
      edIntBin.OnChange := edChange;
      case MyData^._Size of
        4: uInt32(MyData^._Pointer^) := uint32(i64);
        2: uInt16(MyData^._Pointer^) := uint16(i64);
        else
          uInt8(MyData^._Pointer^) := uint8(i64);
      end;
      SetNodeText(vtStructure, BufNode);
    end;
  end
end;

procedure TfMain.edKeyPress(Sender: TObject; var Key: Char);
begin
  if not (((Sender = edIntDec) and (Key in ['0'..'9', Char(VK_BACK)])) or
          ((Sender = edIntHex) and (Key in ['0'..'9', 'A'..'F', 'a'..'f', Char(VK_BACK)])) or
          ((Sender = edFloat) and (Key in ['0'..'9', 'E', 'e', '$', Char(VK_BACK), '-', DecimalSeparator])) or
          ((Sender = edIntBin) and (Key in ['0'..'1', Char(VK_BACK)]))) then
     Key := #0;
  if ((Sender = edIntHex) and (Key in ['a'..'f'])) or ((Sender = edFloat) and (Key = 'e')) then
     Key := UpCase(Key);
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  {$IF Defined(USEREGION)}{$REGION 'Create controls'}{$IFEND}
  imLogo.Picture.Bitmap.LoadFromResourceName(hInstance, 'SM');
  TXPMenu.Create(Self);
  btnOpen := CreateButton('&Open', True, clBlack, 2, 2, 25, 75, 0, 0, [akLeft, akTop], Self, pnWorkplace, imImages, btnOpenClick , nil);
  btnCompare := CreateButton('&Compare', True, clBlack, 2, 2, 25, 75, 7, 1, [akLeft, akTop], Self, pnWorkplace, imImages, btnCompareClick , nil);
  btnFirstACHR := CreateButton('Player &ACHR', True, clBlack, 83, 2, 25, 75, 0, 2, [akLeft, akTop], Self, pnWorkplace, nil, btnFirstACHRClick , nil);
  btnFirstACHR.Visible := False;
  btnFirstNPC := CreateButton('Player &NPC', True, clBlack, 166, 2, 25, 75, 0, 3, [akLeft, akTop], Self, pnWorkplace, nil, btnFirstNPCClick , nil);
  btnFirstNPC.Visible := False;
  btnSave := CreateButton('&Save', True, clBlack, pnWorkplace.ClientWidth - 75, 2, 25, 75, 1, 4, [akRight, akTop], Self, pnWorkplace, imImages, btnSaveClick , nil);
  btnSave.Visible := False;
  btnExport := CreateButton('Export', True, clBlack, 2, 2, 25, 75, 4, 0, [akLeft, akTop], Self, pnData, imImages, btnExportClick , nil);
  btnImport := CreateButton('Import', True, clBlack, 83, 2, 25, 75, 5, 1, [akLeft, akTop], Self, pnData, imImages, btnImportClick , nil);
  btnForms := CreateButton('Export list', True, clBlack, 2, 2, 25, 100, 4, 0, [akLeft, akTop], Self, pnForms, imImages, btnFormsClick , nil);
  btnFormsData := CreateButton('Export data', True, clBlack, 110, 2, 25, 100, 6, 1, [akLeft, akTop], Self, pnForms, imImages, btnFormsDataClick , nil);
  btnGD01All := CreateButton('Export list', True, clBlack, 2, 2, 25, 100, 4, 0, [akLeft, akTop], Self, pnGD01All, imImages, btnGD01AllClick , nil);
  btnGD04 := CreateButton('Export list', True, clBlack, 2, 2, 25, 100, 4, 0, [akLeft, akTop], Self, pnGD04, imImages, btnGD04Click , nil);
  vtStructure := TVirtualStringTree.Create(Self);
  with vtStructure do
  begin
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 337;
    Height := 475;
    Align := alLeft;
    TabOrder := 1;
    Visible := False;
    Color := $F7F7F7
  end;
  odOpen := TExOpenDialog.Create(Self);
  with odOpen do
  begin
    Filter := 'TESV save game files (*.ess)|*.ess|All files (*.*)|*.*';
    Options := [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing];
    OnSelectionChange := odOpenSelectionChange;
  end;
  with pcEditors do
  begin
    for i := 0 to PageCount - 1 do
      Pages[i].TabVisible := False;
    ActivePageIndex := 0;
    Style := tsFlatButtons;
    Top := btnOpen.Top + btnOpen.Height + 2;
    Left := 0;
    Height := pnStatus.Top - Top;
    Width := Parent.ClientWidth;
  end;
  imLogo.Left := pcEditors.Left;
  imLogo.Top := pcEditors.Top;
  imLogo.Height := pcEditors.Height;
  imLogo.Width := pcEditors.Width;
  with vtStructure do
  begin
    IncrementalSearch := isVisibleOnly;
    NodeDataSize := SizeOf(TMyRec);
    OnGetText := vtStructureGetText;
    OnFreeNode := vtStructureFreeNode;
    OnInitNode := vtStructureInitNode;
    OnChange := vtStructureChange;
  end;
  heEdit := THexEditor.Create(Self);
  with heEdit do
  begin
    Parent := tsData;
    Align := alClient;
  end;
  {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  PrepareDataToShow;
  with sgHeader do
  begin
    Selection := TGridRect(Rect(-1, -1, -1, -1));
    ColWidths[0] := 100;
    Cells[0, 0] := 'Address';
    ColWidths[1] := 5;
    ColWidths[18] := 15;
    for i := 0 to 15 do
    begin
      ColWidths[i + 2] := 30;
      ColWidths[i + 19] := 10;
      if i < 10 then
      begin
        Cells[i + 2, 0] := Char(Ord('0') + i);
        Cells[i + 19, 0] := Char(Ord('0') + i);
      end
      else
      begin
        Cells[i + 2, 0] := Char(Ord('A') + (i - 10));
        Cells[i + 19, 0] := Char(Ord('A') + (i - 10));
      end;
    end;
  end;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  FreeESSFile(ESSFile);
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  pnStatus.Caption := MinimizeName(sFileName, THackPanel(pnStatus).Canvas, pnStatus.Parent.ClientWidth - 8);
  btnSave.Left := btnSave.Parent.ClientWidth - btnSave.Width - 2;
  spSplit.Left := vtStructure.Width;
  if pcEditors.ActivePage = tsData then
    heEdit.UpdateSize;
end;

procedure TfMain.lvCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  i: Integer;
  Rect: TRect;
begin
  with Sender as TListView do
  begin
    DefaultDraw := False;
    if Item.Selected then
      Canvas.Brush.Color := clHighlight
    else
    begin
      Canvas.Brush.Color := clWhite;
      if Odd(Item.Index) then
        Canvas.Brush.Color := Canvas.Brush.Color - $080808;
    end;
    if Item.Selected then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color := clBlack;
    Rect := Item.DisplayRect(drBounds);
    for i := 0 to Columns.Count - 1 do
    begin
      Rect.Right := Rect.Left + Integer(SendMessage(Handle, LVM_GETCOLUMNWIDTH, i, 0));
      if i = 0 then
        Canvas.TextRect(Rect, Rect.Left + 4, Rect.Top, Item.Caption)
      else
        Canvas.TextRect(Rect, Rect.Left + 4, Rect.Top, Item.SubItems[i - 1]);
      Rect.Left := Rect.Right;
    end;
    if ItemFocused = Item then
      Canvas.DrawFocusRect(Item.DisplayRect(drBounds));
  end;
end;

procedure TfMain.lvEdited(Sender: TObject; Item: TListItem; var S: string);
var
  Value: uint32;
begin
  S := Trim(S);
  with Item do
    if TryStrToInt(S, Integer(Value)) then
    begin
      Move(Value, Data^, SizeOf(uint32));
      Caption := IntToStr(Value);
    end
    else
      S := Caption;
end;

procedure TfMain.lvFormsColumnClick(Sender: TObject; Col: TListColumn);
var
  i: Integer;
begin
  if Sender is TListView then
    with Sender as TListView do
    begin
      if Col.Index = (Tag shr 1) then
        if Boolean(Tag and 1) then
          Tag := Tag and $FFFFFFFE
        else
          Tag := Tag or 1
      else
        Tag := (Col.Index shl 1) or (Tag and 1);
      if Boolean(Tag and 1) then
        QuickSortForms(FormViews, 0, Length(FormViews) - 1, True, Col.Index)
      else
        QuickSortForms(FormViews, 0, Length(FormViews) - 1, False, Col.Index);
      for i := 0 to (Sender as TListView).Columns.Count - 1 do
        SetColumnSortOrder(Sender as TListview, i, Tag shr 1, Boolean(Tag and 1));
      Repaint;
    end;
end;

procedure TfMain.lvFormsData(Sender: TObject; Item: TListItem);
begin
  if Item.Index < Length(FormViews) then
      with FormViews[Item.Index], Item do
      begin
        Data := Pointer(No);
        Caption := IntToStr(No);
        SubItems.Add(RefIDToString(Form.formID));
        SubItems.Add(IntToHex(Form.changeFlags, 8));
        SubItems.Add(IntToStr(Form.changeFlags));
        SubItems.Add(IntToStr(Form._type));
        SubItems.Add(Copy(GetFormString(Form._type), 1, 4));
        SubItems.Add(IntToStr(Form.version));
        SubItems.Add(IntToStr(Form.length1));
        if Form.length2 > 0 then
          SubItems.Add(IntToStr(Form.length2))
        else
          SubItems.Add('');
      end;
end;

procedure TfMain.lvFormsDblClick(Sender: TObject);
begin
  if (lvForms.Selected <> nil) and (lvForms.Selected.Data <> nil) then
    with vtStructure do
    begin
      Expanded[GetFirst(False)] := True;
      Expanded[GetChild(GetFirst(False), 10)] := True;
      FocusedNode := GetChild(GetChild(GetFirst(False), 10), Integer(lvForms.Selected.Data) - 1);
      Expanded[FocusedNode] := True;
    end;
end;

procedure TfMain.lvGD02Edited(Sender: TObject; Item: TListItem; var S: string);
var
  Value: uint32;
begin
  S := Trim(S);
  with Item do
    case Index  of
      1, 6:
        if TryStrToInt('$' + S, Integer(Value)) and (Value < $1000000) then
        begin
          Move(Value, Data^, SizeOf(TRefID));
          Caption := IntToHex(Value, 6);
        end
        else
          S := Caption;
      else
        if TryStrToInt(S, Integer(Value)) then
        begin
          Move(Value, Data^, SizeOf(uint32));
          Caption := IntToStr(Value);
        end
        else
          S := Caption;
    end;
end;

procedure TfMain.lvGD04Edited(Sender: TObject; Item: TListItem; var S: string);
var
  Value: float32;
begin
  S := Trim(S);
  with Item do
    if TryStrToFloat(S, Value) then
    begin
      Move(Value, Data^, SizeOf(float32));
      Caption := FloatToStr(Value);
    end
    else
      S := Caption;
end;

procedure TfMain.lvColumnClick(Sender: TObject; Col: TListColumn);
var
  i: Integer;
begin
  if Sender is TListView then
    with Sender as TListView do
    begin
      if Col.Index = (Tag shr 1) then
        if Boolean(Tag and 1) then
          Tag := Tag and $FFFFFFFE
        else
          Tag := Tag or 1
      else
        Tag := (Col.Index shl 1) or (Tag and 1);
      if Boolean(Tag and 1) then
        TListView(Sender).CustomSort(@SortByColumnAscend, Col.Index)
      else
        TListView(Sender).CustomSort(@SortByColumnDescend, Col.Index);
      for i := 0 to (Sender as TListView).Columns.Count - 1 do
        SetColumnSortOrder(Sender as TListview, i, Tag shr 1, Boolean(Tag and 1));
    end;
end;

procedure TfMain.lvKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Sender is TListView then
    with Sender as TListView do
      if Key = VK_F2 then
        if Assigned(Selected) then
          Selected.EditCaption;
end;

procedure TfMain.sgHeaderDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid), Canvas do
  begin
    Font := (Sender as TStringGrid).Font;
    Brush.Color := $00F0F0F0;
    FillRect(Rect);
    Pen.Color := clBtnText;
    MoveTo(Rect.Left, Rect.Bottom - 1);
    LineTo(Rect.Right, Rect.Bottom - 1);
    DrawText(Canvas.Handle, PChar(Cells[ACol, ARow]), Length(Cells[ACol, ARow]), Rect, DT_CENTER or DT_SINGLELINE);
  end;
end;

procedure TfMain.spSplitMoved(Sender: TObject);
begin
  FormResize(Self);
end;

procedure TfMain.tsScreenShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsScreenShow'}{$IFEND}
var
  bmTmp: TBitmap;
begin
  with ESSFile, Header do
    if magic = C_TESVESS then
      if not ((shotWidth > 4096) or (shotHeight > 4096)) then
      begin
        bmTmp := ScreenShotToBMP(shotWidth, shotHeight, screenshotData);
        try
          imScreen.Picture.Assign(bmTmp);
        finally
          bmTmp.Free;
        end;
      end
      else
        imMain.Picture := nil;
  cbScreenCenter.OnClick := nil;
  cbScreenStrech.OnClick := nil;
  cbScreenProportional.OnClick := nil;
  cbScreenCenter.Checked := imScreen.Center;
  cbScreenStrech.Checked := imScreen.Stretch;
  cbScreenProportional.Checked := imScreen.Proportional;
  cbScreenCenter.OnClick := cbScreenClick;
  cbScreenStrech.OnClick := cbScreenClick;
  cbScreenProportional.OnClick := cbScreenClick;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsStringShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsStringShow'}{$IFEND}
var
  MyData: PMyRec;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btString) and (MyData^._Pointer <> nil) then
      edWString.Text := wstringToString(wstring(MyData^._Pointer^));
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tvFlagsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node <> nil then
    with Sender.Canvas.Font do
      if IsChecked(TTreeView(Sender), Node.Index) then
        Style := [fsBold]
      else
        Style := [];
end;

procedure TfMain.tsFlagsShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsFlagsShow'}{$IFEND}
var
  MyData: PMyRec;
  i: Integer;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btFlags) and (MyData^._Pointer <> nil) then
    with tvFlags do
    begin
      Items.Clear;
      Items.Add(nil, ' 0 - CHANGE_FORM_FLAGS');  //0
      Items.Add(nil, ' 1 - CHANGE_REFR_MOVE / CHANGE_QUEST_FLAGS'); //1
      Items.Add(nil, ' 2 - CHANGE_REFR_HAVOK_MOVE'); //2
      Items.Add(nil, ' 3 - CHANGE_REFR_CELL_CHANGED'); //3
      Items.Add(nil, ' 4 - CHANGE_REFR_SCALE'); //4
      Items.Add(nil, ' 5 - CHANGE_REFR_INVENTORY'); //5
      Items.Add(nil, ' 6 - CHANGE_REFR_EXTRA_OWNERSHIP'); //6
      Items.Add(nil, ' 7 - CHANGE_REFR_BASEOBJECT'); //7
      Items.Add(nil, ' 8'); //8
      Items.Add(nil, ' 9'); //9
      Items.Add(nil, ' 10 - CHANGE_OBJECT_EXTRA_ITEM_DATA'); //10
      Items.Add(nil, ' 11'); //11
      Items.Add(nil, ' 12 - CHANGE_OBJECT_EXTRA_LOCK'); //12
      Items.Add(nil, ' 13'); //13
      Items.Add(nil, ' 14'); //14
      Items.Add(nil, ' 15'); //15
      Items.Add(nil, ' 16'); //16
      Items.Add(nil, ' 17'); //17
      Items.Add(nil, ' 18'); //18
      Items.Add(nil, ' 19'); //19
      Items.Add(nil, ' 20'); //20
      Items.Add(nil, ' 21 - CHANGE_OBJECT_EMPTY'); //21
      Items.Add(nil, ' 22'); //22
      Items.Add(nil, ' 23 - CHANGE_OBJECT_OPEN_STATE'); //23
      Items.Add(nil, ' 24'); //24
      Items.Add(nil, ' 25 - CHANGE_REFR_PROMOTED'); //25
      Items.Add(nil, ' 26 - CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN / CHANGE_QUEST_ALREADY_RUN'); //26
      Items.Add(nil, ' 27 - CHANGE_REFR_LEVELED_INVENTORY / CHANGE_QUEST_INSTANCES'); //27
      Items.Add(nil, ' 28 - CHANGE_REFR_ANIMATION / CHANGE_QUEST_RUNDATA'); //28
      Items.Add(nil, ' 29 - CHANGE_REFR_EXTRA_ENCOUNTER_ZONE / CHANGE_QUEST_OBJECTIVES'); //29
      Items.Add(nil, ' 30'); //30
      Items.Add(nil, ' 31 - CHANGE_REFR_EXTRA_GAME_ONLY / CHANGE_QUEST_STAGES'); //31
      SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or TVS_CHECKBOXES);
      for i := 0 to 31 do
        if (uint32(MyData^._Pointer^) and (1 shl i)) <> 0 then
          SetChecked(tvFlags, i, True);
    end;
  end;
end;  {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsFloatShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsFloatShow'}{$IFEND}
var
  MyData: PMyRec;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btFloat) and (MyData^._Pointer <> nil) then
      if MyData^._Size = 8 then
        edFloat.Text := FloatToStr(Double(MyData^._Pointer^))
      else
        edFloat.Text := FloatToStr(Single(MyData^._Pointer^));
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsFormsShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsFormsShow'}{$IFEND}
var
  i: integer;
begin
  lvForms.Clear;
  lvForms.Tag := 0;
  with ESSFile, lvForms do
    if magic = C_TESVESS then
    begin
      SetLength(FormViews, Length(changeForms));
      for i := 0 to Length(changeForms) - 1 do
      begin
        CopyMemory(@FormViews[i].Form, @changeForms[i], SizeOf(TFormView) - SizeOf(Integer));
        FormViews[i].No := i + 1;
      end;
      OwnerData := True;
      Items.Count := Length(changeForms);
    end;
end;  {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsGD01Show(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsGD01Show'}{$IFEND}
var
  iCount, iPos, i, iAddress: Integer;
  MyData: PMyRec;
  iCategory: uInt8;
  iValue: uInt32;
  sDescription: string;
begin
  if not IsVista and (tsGD01.Tag = 0) then
  begin
    SetListHeadColor(lvGD01General.Handle, lvGD01GeneralProc, Longint(@lvGD01GeneralNewProc));
    SetListHeadColor(lvGD01Quest.Handle, lvGD01QuestProc, Longint(@lvGD01QuestNewProc));
    SetListHeadColor(lvGD01Combat.Handle, lvGD01CombatProc, Longint(@lvGD01CombatNewProc));
    SetListHeadColor(lvGD01Magic.Handle, lvGD01MagicProc, Longint(@lvGD01MagicNewProc));
    SetListHeadColor(lvGD01Crafting.Handle, lvGD01CraftingProc, Longint(@lvGD01CraftingNewProc));
    SetListHeadColor(lvGD01Crime.Handle, lvGD01CrimeProc, Longint(@lvGD01CrimeNewProc));
    SetListHeadColor(lvGD01All.Handle, lvGD01AllProc, Longint(@lvGD01AllNewProc));
    tsGD01.Tag := 1;
  end;
  pcGD01.ActivePageIndex := pcGD01.PageCount - 1;
  lvGD01General.Clear;
  lvGD01General.Tag := 0;
  lvGD01Quest.Clear;
  lvGD01Quest.Tag := 0;
  lvGD01Combat.Clear;
  lvGD01Combat.Tag := 0;
  lvGD01Magic.Clear;
  lvGD01Magic.Tag := 0;
  lvGD01Crafting.Clear;
  lvGD01Crafting.Tag := 0;
  lvGD01Crime.Clear;
  lvGD01Crime.Tag := 0;
  lvGD01All.Clear;
  lvGD01All.Tag := 0;
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
    begin
      iPos := 0;
      iCount := Read_uint32(TBytes(MyData^._Pointer^), iPos);
      if iPos > 0 then
        for i := 0 to iCount - 1 do
        begin
          iCategory := 0;
          iValue := 0;
          sDescription := wstringToString(Read_wstring(TBytes(MyData^._Pointer^), iPos));
          if iPos > 0 then
            iCategory := Read_uint8(TBytes(MyData^._Pointer^), iPos);
          iAddress := iPos;
          if iPos > 0 then
            iValue := Read_int32(TBytes(MyData^._Pointer^), iPos);
          if iPos > 0 then
          begin
            case TStatCategory(iCategory) of
              scGeneral:
                with lvGD01General.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add(sDescription);
                end;
              scQuest:
                with lvGD01Quest.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add(sDescription);
                end;
              scCombat:
                with lvGD01Combat.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add(sDescription);
                end;
              scMagic:
                with lvGD01Magic.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add(sDescription);
                end;
              scCrafting:
                with lvGD01Crafting.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add(sDescription);
                end;
              scCrime:
                with lvGD01Crime.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add(sDescription);
                end;
            end;
            with lvGD01All.Items.Add do
            begin
              Caption := IntToStr(iValue);
              Data := @(TBytes(MyData^._Pointer^)[iAddress]);
              SubItems.Add(GetCategoryString(iCategory));
              SubItems.Add(sDescription);
            end;
          end
          else
          begin
            MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
            Break
          end;
        end;
      if MyData^._Size <> iPos then
        MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
    end;
    pcGD01.ActivePage := tsGD01General;
  end;
  BufNode := nil;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsGD02Show(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsGD02Show'}{$IFEND}
var
  iPos, i, iAddress: Integer;
  MyData: PMyRec;
  iValue: uInt32;
  rValue: TRefID;
begin
  if not IsVista and (tsGD02.Tag = 0) then
  begin
    SetListHeadColor(lvGD02.Handle, lvGD02Proc, Longint(@lvGD02NewProc));
    tsGD02.Tag := 1;
  end;
  lvGD02.Clear;
  lvGD02.Tag := 0;
  lvGD02.Columns[0].Width := 100;
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
    begin
      iPos := 0;
      iValue := 0;
      for i := 0 to 7 do
      begin
        iAddress := iPos;
        case i of
          1, 6:
          begin
            if iPos > 0 then
              rValue := Read_RefID(TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
              with lvGD02.Items.Add do
              begin
                Caption := RefIDToHex(rValue);
                Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                SubItems.Add('unknown RefID');
              end;
          end;
          else
          begin
            if (iPos > 0) or (i = 0) then
              iValue := Read_uint32(TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
              with lvGD02.Items.Add do
              begin
                Caption := IntToStr(iValue);
                Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                SubItems.Add('unknown uint32');
              end;
          end;
        end;
        if iPos = 0 then
        begin
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
          Break
        end;
      end;
      if MyData^._Size <> iPos then
        MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
    end;
  end;
  lvGD02.Columns[0].Width := lvGD02.Columns[0].Width + 1;
  BufNode := nil;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsGD04Show(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsGD04Show'}{$IFEND}
var
  iPos, iCount, i, iAddress: Integer;
  MyData: PMyRec;
  fValue: float;
  rValue: TRefID;
begin
  if not IsVista and (tsGD04.Tag = 0) then
  begin
    SetListHeadColor(lvGD04.Handle, lvGD04Proc, Longint(@lvGD04NewProc));
    tsGD04.Tag := 1;
  end;
  lvGD04.Clear;
  lvGD04.Tag := 0;
  lvGD04.Columns[0].Width := 200;
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
    begin
      iPos := 0;
      fValue := 0.0;
      iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
      if iPos > 0 then
        for i := 0 to iCount - 1 do
        begin
          if iPos > 0 then
            rValue := Read_RefID(TBytes(MyData^._Pointer^), iPos);
          iAddress := iPos;
          if iPos > 0 then
            fValue := Read_float32(TBytes(MyData^._Pointer^), iPos);
          if iPos > 0 then
            with lvGD04.Items.Add do
            begin
              Caption := FloatToStr(fValue);
              Data := @(TBytes(MyData^._Pointer^)[iAddress]);
              SubItems.Add(RefIDToString(rValue));
            end;
          if iPos = 0 then
          begin
            MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
            Break
          end;
        end;
      if MyData^._Size <> iPos then
        MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
    end;
  end;
  lvGD04.Columns[0].Width := lvGD04.Columns[0].Width + 1;
  BufNode := nil;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsIntegerShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsIntegerShow'}{$IFEND}
var
  i: Integer;
  MyData: PMyRec;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type in [btInt, btHex]) then
    begin
      with Self do
        for i := 0 to ComponentCount - 1 do
          if (Components[i] is TSpeedButton) and ((Components[i] as TSpeedButton).Parent = tsInteger) then
            if StrToInt(Copy(Components[i].Name, 3, Length(Components[i].Name))) < (MyData^._Size * 8) then
            begin
              Components[i].Tag := StrToInt(Copy(Components[i].Name, 3, Length(Components[i].Name)));
              (Components[i] as TSpeedButton).OnClick := edChange;
              (Components[i] as TSpeedButton).Visible := True;
            end
            else
            begin
              Components[i].Tag := -1;
              (Components[i] as TSpeedButton).OnClick := nil;
              (Components[i] as TSpeedButton).Visible := False;
            end;
      Helper.TEdit(edIntDec).Alignment := taRightJustify;
      Helper.TEdit(edIntHex).Alignment := taRightJustify;
      Helper.TEdit(edIntBin).Alignment := taRightJustify;
      lbRange.Caption := 'Value range:';
      case MyData^._Size of
        4: begin
             edIntDec.Text := IntToStr(uint32(MyData^._Pointer^));
             lbRange.Caption := lbRange.Caption + #13'0..4294967295'#13#13'Orginal value:'#13 + IntToStr(uint32(MyData^._Pointer^));
           end;
        2: begin
             edIntDec.Text := IntToStr(uint16(MyData^._Pointer^));
             lbRange.Caption := lbRange.Caption + #13'0..65525'#13#13'Orginal value:'#13 + IntToStr(uint16(MyData^._Pointer^));;
           end
        else
        begin
          edIntDec.Text := IntToStr(uint8(MyData^._Pointer^));
          lbRange.Caption := lbRange.Caption + #13'0..255'#13#13'Orginal value:'#13 + IntToStr(uint8(MyData^._Pointer^));;
        end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsMainShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsMainShow'}{$IFEND}
var
  bmTmp: TBitmap;
begin
  with ESSFile, Header do
    if magic = C_TESVESS then
    begin
      if not ((shotWidth > 4096) or (shotHeight > 4096)) then
      begin
        bmTmp := ScreenShotToBMP(shotWidth, shotHeight, screenshotData);
        try
          imMain.Picture.Assign(bmTmp);
        finally
          bmTmp.Free;
        end;
        imMain.Height := bmTmp.Height + 16;
      end
      else
      begin
        imMain.Picture := nil;
        imMain.Height := 0;
      end;
      lbMain.Top := imMain.Height;
      lbMain.Caption := 'Save No: ' + IntToStr(saveNumber) +
                     #13'Player: ' + wstringToString(playerName) +
                     #13'Level: ' + IntToStr(playerLevel) +
                     #13'Race: ' + wstringToString(playerRaceEditorId) +
                     #13'Location: ' + wstringToString(playerLocation) +
                     #13'Date: ' + wstringToString(gameDate);
    end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsReadCalcShow(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsReadCalcShow'}{$IFEND}
var
  i64: Int64;
  MyData: PMyRec;
  sVal: string;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type in [btReadOnly, btCalc]) then
    begin
      Helper.TEdit(edRODec).Alignment := taRightJustify;
      Helper.TEdit(edROHex).Alignment := taRightJustify;
      Helper.TEdit(edROBin).Alignment := taRightJustify;
      edRODec.Visible := MyData^._Pointer <> nil;
      edROHex.Visible := edRODec.Visible;
      edROBin.Visible := edRODec.Visible;
      lbRODec.Visible := edRODec.Visible;
      lbROHex.Visible := edRODec.Visible;
      lbROBin.Visible := edRODec.Visible;
      if edRODec.Visible then
      begin
        case MyData^._Size of
          4: i64 := uint32(MyData^._Pointer^);
          2: i64 := uint16(MyData^._Pointer^);
          else
            i64 := uint8(MyData^._Pointer^);
        end;
        edRODec.Text := IntToStr(i64);
        sVal := IntToHex(i64, MyData^._Size * 2);
        while (sVal <> '') and (sVal[1] = '0') do
          Delete(sVal, 1, 1);
        edROHex.Text := sVal;
        sVal := IntToBin(i64, MyData^._Size * 8);
        while (sVal <> '') and (sVal[1] = '0') do
          Delete(sVal, 1, 1);
        edROBin.Text := sVal;
        while (sVal <> '') and (sVal[1] = '0') do
          Delete(sVal, 1, 1);
      end;
      lbReadOnly.Visible := MyData^._Type = btReadOnly;
      lbCalc.Visible := MyData^._Type = btCalc;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.PrepareDataToShow;
begin
  BufNode := nil;
  vtStructure.Clear;
  if sFileName <> '' then
  begin
    pnStatus.Visible := True;
    btnSave.Visible := True;
    FillTree;
    vtStructure.Visible := True;
    spSplit.Visible := True;
    FormResize(Self);
    vtStructureChange(vtStructure, vtStructure.GetFirst(False));
    btnFirstACHR.Visible := True;
    btnFirstNPC.Visible := True;
    btnCompare.Left := btnFirstNPC.Left + btnFirstNPC.Width + 8;
  end
  else
  begin
    FreeESSFile(ESSFile);
    vtStructure.Visible := False;
    spSplit.Visible := False;
    pnStatus.Visible := False;
    pcEditors.Visible := False;
    btnSave.Visible := False;
    btnFirstACHR.Visible := False;
    btnFirstNPC.Visible := False;
    btnCompare.Left := btnOpen.Left + btnOpen.Width + 8;
  end;
end;

procedure TfMain.vtStructureChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  i: Integer;
  bShow: Boolean;
  MyData: PMyRec;
  fTmp: Double;
  iuInt32: uInt32;
begin
  bShow := True;
  with Sender do
  begin
    if Node <> nil then
    {$IF Defined(USEREGION)}{$REGION 'Node selected'}{$IFEND}
    begin
      BufNode := nil;
      MyData := GetNodeData(Node);
      if Assigned(MyData) then
        with MyData^ do
          case _Type of
            btNone:
              if Node = Sender.GetFirst(False) then
                pcEditors.ActivePage := tsMain
              else
                if (Node.Parent <> nil) and (Node.Parent = Sender.GetFirst(False)) and (Node.Index = 10) then
                  pcEditors.ActivePage := tsForms
                else
                  bShow := False;
            btShot:
              pcEditors.ActivePage := tsScreen;
            btForm, btGlobal:
              begin
                pcEditors.ActivePage := tsData;
                bBreak := False;
                if _Type = btForm then
                  bShow := GetData(TBytes(_Pointer^), BufData, _Size, _Decompressed, heEdit)
                else
                  bShow := GetData(TBytes(_Pointer^), BufData, _Size, 0, heEdit);
                if bShow then
                  BufNode := Node
                else
                  SetLength(BufData, 0);
              end;
            btInt, btHex:
              begin
                pcEditors.ActivePage := tsInteger;
                BufNode := Node;
              end;
            btReadOnly, btCalc:
              begin
                pcEditors.ActivePage := tsReadCalc;
                BufNode := Node;
              end;
            btString:
              begin
                pcEditors.ActivePage := tsString;
                BufNode := Node;
              end;
            btFloat:
              begin
                pcEditors.ActivePage := tsFloat;
                BufNode := Node;
              end;
            btFlags:
              begin
                pcEditors.ActivePage := tsFlags;
                BufNode := Node;
              end;
            btRec:
              if Node^.Parent <> nil then
              begin
                case Node^.Parent^.Index of
                  8:  begin
                        case Node^.Index of
                          0: pcEditors.ActivePage := tsGD01;
                          1: pcEditors.ActivePage := tsGD02;
                          3: pcEditors.ActivePage := tsGD04;
                          else
                            bShow := False;
                        end;
                        if bShow then
                        begin
                          Expanded[Node] := True;
                          BufNode := GetChild(Node, 2);
                        end;
                      end
                  else
                    bShow := False;
                end;
              end
            else
              bShow := False;
          end;
    end
    {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    else
      begin
        bShow := False;
        if Assigned(BufNode) then
        {$IF Defined(USEREGION)}{$REGION 'Node unselected'}{$IFEND}
        begin
          MyData := GetNodeData(BufNode);
          if Assigned(MyData) then
          with MyData^ do
            case _Type of
              btForm:
                begin
                  SetData(TBytes(_Pointer^), BufData, _Size, _Decompressed, heEdit, True);
                  if BufNode^.Parent <> nil then
                  begin
                    ESSFile.changeForms[BufNode^.Parent^.Index].length1 := _Size;
                    ESSFile.changeForms[BufNode^.Parent^.Index].length2 := _Decompressed;
                    SetNodeText(vtStructure, GetChild(BufNode^.Parent, 4));
                    SetNodeText(vtStructure, GetChild(BufNode^.Parent, 5));
                  end;
                end;
              btGlobal:
                begin
                  SetData(TBytes(_Pointer^), BufData, _Size, _Decompressed, heEdit);
                  if (BufNode^.Parent <> nil) and (BufNode^.Parent^.Parent <> nil) then
                  begin
                    case BufNode^.Parent^.Parent^.Index of
                      8: ESSFile.globalDataTable1[BufNode^.Parent^.Index]._length := _Size;
                      9: ESSFile.globalDataTable2[BufNode^.Parent^.Index]._length := _Size;
                      11: ESSFile.globalDataTable3[BufNode^.Parent^.Index]._length := _Size;
                    end;
                    SetNodeText(vtStructure, GetChild(BufNode^.Parent, 1));
                  end;
                end;
              btString:
                begin
                  wString(MyData^._Pointer^) := StringTowstring(edWString.Text);
                  SetNodeText(vtStructure, BufNode);
                end;
              btFloat:
                begin
                  if not TryStrToFloat(Trim(edFloat.Text), fTmp) then
                    MessageBox(Handle, PChar('Wrong float value: ' + Trim(edFloat.Text)), 'Error', MB_OK or MB_ICONERROR)
                  else
                  begin
                    if MyData^._Size = 8 then
                      Double(MyData^._Pointer^) := fTmp
                    else
                      Single(MyData^._Pointer^) := fTmp;
                    SetNodeText(vtStructure, BufNode);
                  end;
                end;
              btFlags:
                begin
                  iuInt32 := 0;
                  for i := 0 to 31 do
                    if IsChecked(tvFlags, i) then
                      iuInt32 := iuInt32 or (1 shl i);
                  uint32(MyData^._Pointer^) := iuInt32;
                  SetNodeText(vtStructure, BufNode);
                end;
            end;
          BufNode := nil;
        end
        else
          if lvForms.Items.Count > 0 then
          begin
            lvForms.Items.Count := 0;
            SetLength(FormViews, 0);
          end;
        {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      end;
  end;
  if bShow then
  begin
    if pcEditors.ActivePageIndex = tsMain.PageIndex then
      tsMainShow(Self);
    if pcEditors.ActivePageIndex = tsScreen.PageIndex then
      tsScreenShow(Self);
    if pcEditors.ActivePageIndex = tsForms.PageIndex then
      tsFormsShow(Self);
    if pcEditors.ActivePageIndex = tsInteger.PageIndex then
      tsIntegerShow(Self);
    if pcEditors.ActivePageIndex = tsReadCalc.PageIndex then
      tsReadCalcShow(Self);
    if pcEditors.ActivePageIndex = tsString.PageIndex then
      tsStringShow(Self);
    if pcEditors.ActivePageIndex = tsFloat.PageIndex then
      tsFloatShow(Self);
    if pcEditors.ActivePageIndex = tsFlags.PageIndex then
      tsFlagsShow(Self);
    if pcEditors.ActivePageIndex = tsGD01.PageIndex then
      tsGD01Show(Self);
    if pcEditors.ActivePageIndex = tsGD02.PageIndex then
      tsGD02Show(Self);
    if pcEditors.ActivePageIndex = tsGD04.PageIndex then
      tsGD04Show(Self);
  end;
  pcEditors.Visible := bShow;
end;

{$IF Defined(USEREGION)}{$REGION 'Tree view interface'}{$IFEND}
procedure TfMain.FillTree;
var
  pRoot, pLvl1, pLvl2: PVirtualNode;
begin
  with vtStructure, ESSFile do
  begin
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      begin
        ChildCount[pRoot] := 18;
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          case pLvl1.Index of
            2: ChildCount[pLvl1] := 13; //THeader
            6: ChildCount[pLvl1] := 2; //TPluginInfo
            7: ChildCount[pLvl1] := 11; //TFileLocationTable
            8: ChildCount[pLvl1] := Length(globalDataTable1); //TGlobalData
            9: ChildCount[pLvl1] := Length(globalDataTable2); //TGlobalData
            10: ChildCount[pLvl1] := Length(changeForms); //TChangeForm
            11: ChildCount[pLvl1] := Length(globalDataTable3); //TGlobalData
            13: ChildCount[pLvl1] := Length(formIDArray); //TRefID
            15: ChildCount[pLvl1] := Length(unknown2Table); //uint32
            17: ChildCount[pLvl1] := 2; //TUnknown3Table
          end;
          InvalidateToBottom(pLvl1);
          pLvl2 := pLvl1.FirstChild;
          if Assigned(pLvl2) then
          repeat
            Expanded[pLvl2] := False;
            case pLvl1.Index of
              6: if pLvl2.Index = 1 then
                   ChildCount[pLvl2] := Length(pluginInfo.plugins); //TFileLocationTable
              7: if pLvl2.Index = 10 then
                   ChildCount[pLvl2] := 15; //TFileLocationTable
              8: ChildCount[pLvl2] := 3; //TGlobalData
              9: ChildCount[pLvl2] := 3; //TGlobalData
              10: ChildCount[pLvl2] := 7; //TChangeForm
              11: ChildCount[pLvl2] := 3; //TGlobalData
              13: ChildCount[pLvl2] := 2; //TRefID
              17: ChildCount[pLvl2] := Length(unknown3Table.unknown); //TUnknown3Table
            end;
            InvalidateToBottom(pLvl2);
            pLvl2 := pLvl2.NextSibling;
          until not Assigned(pLvl2);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfMain.vtStructureGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
begin
  Text := GetNodeText(Sender, Node);
end;

procedure TfMain.vtStructureFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  MyData: PMyRec;
begin
  MyData := Sender.GetNodeData(Node);
  Finalize(MyData^);
end;

procedure TfMain.vtStructureInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  MyData: PMyRec;
begin
  with Sender, ESSFile do
  begin
    MyData := GetNodeData(Node);
    with MyData^ do
    begin
      _Caption := '';
      _Type := btNone;
      _Pointer := nil;
      _Size := 0;
      _Decompressed := 0;
      case GetNodeLevel(Node) of
        0: if (Node.Index < 1) and (sFileName <> '') then
             _Caption := ExtractFileName(sFileName);
        1: GetCaptionLevel1(ESSFile, Node.Index, MyData, Node);
        2: GetCaptionLevel2(ESSFile, Node.Parent.Index, Node.Index, MyData, Node);
        3: GetCaptionLevel3(ESSFile, Node.Parent.Parent.Index, Node.Parent.Index, Node.Index, MyData, Node);
      end;
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

end.
