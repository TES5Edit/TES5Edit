unit uMain;

{$IF CompilerVersion >= 17} {$DEFINE USEREGION} {$IFEND}

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, ExtCtrls, ComCtrls, CommCtrl, uESSFile, Grids,
  Buttons, Menus, uHelper, VistaProgressBar, GlassButton, XPMenu, ImgList, HexEdit,
  ShlObj, uCompare, uPapyrus, uViewer, Clipbrd, uCmpPapyrus, MMSystem;

const
  WM_ABOUT = WM_USER + 2;

type
  PInt = ^Integer;

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
    tsMain, tsScreen, tsData, tsInteger, tsReadCalc, tsString, tsFloat, tsFlags, tsGD01, tsGD02, tsGD04, tsGD32, tsGD0X: TTabSheet;
    tvFlags: TTreeView;
    pcGD01: TPageControl;
    tsGD01General, tsGD01Quest, tsGD01Combat, tsGD01Magic, tsGD01Crafting, tsGD01Crime: TTabSheet;
    lvGD01General, lvGD01Quest, lvGD01Combat, lvGD01Magic, lvGD01Crafting, lvGD01Crime: TListView;
    lvGD02, lvGD04: TListView;
    imImages: TImageList;
    imLogo: TImage;
    sgHeader: TStringGrid;
    tsForms: TTabSheet;
    lvForms: TListView;
    tsGD01All: TTabSheet;
    lvGD01All: TListView;
    pnGD01All: TPanel;
    pnForms: TPanel;
    pnGD04: TPanel;
    pnGD32Background: TPanel;
    odPapyrus: TOpenDialog;
    sdCSVSave: TSaveDialog;
    pnStructure: TPanel;
    pnSearch: TPanel;
    edSearch: TEdit;
    stNotFound: TStaticText;
    lbSearch: TLabel;
    pnPath: TPanel;
    pnTools: TPanel;
    lbPapyrusSearch: TLabel;
    edPapyrusSearch: TEdit;
    stPapyrusNotFound: TStaticText;
    pnInfo: TPanel;
    lbLink: TLabel;
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
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPapyrusDeleteClick(Sender: TObject);
    procedure btnPapyrusAnalysisClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnFormsClick(Sender: TObject);
    procedure btnFormsDataClick(Sender: TObject);
    procedure btnGD01AllClick(Sender: TObject);
    procedure btnGD04Click(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnZeroClick(Sender: TObject);
    procedure btnPapyrusEmptyClick(Sender: TObject);
    procedure btnPapyrusValuesClick(Sender: TObject);
    procedure btnPapyrusCmpClick(Sender: TObject);
    procedure btnPapyrusViewerClick(Sender: TObject);
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
    procedure tsGD32Show(Sender: TObject);
    procedure tsFormsShow(Sender: TObject);
    procedure lvFormsData(Sender: TObject; Item: TListItem);
    procedure lvFormsColumnClick(Sender: TObject; Col: TListColumn);
    procedure lvFormsDblClick(Sender: TObject);
    procedure vtPapyrusGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure vtPapyrusFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtPapyrusInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtPapyrusKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vtTMPInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtStructureKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edSearchChange(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnPapyrusSearchClick(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvFormsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvFormsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPapyrusSearchChange(Sender: TObject);
    procedure edPapyrusSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vtPapyrusChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure lbLinkClick(Sender: TObject);
  private
    odOpen: TExOpenDialog;
    vtStructure, vtPapyrus, vtTMP: TVirtualStringTree;
    sFileName: string;
    ESSFile: TESSFile;
    Papyrus, P1, P2: tPapyrus;
    bBreak: Boolean;
    BufNode: PVirtualNode;
    BufData: TBytes;
    pbProcess: TVistaProgressBar;
    heEdit: THexEditor;
    btnOpen, btnCompare, btnFirstACHR, btnFirstNPC, btnSave, btnBreak, btnExport, btnImport, btnZero: TGlassButton;
    btnForms, btnFormsData, btnGD01All, btnGD04, btnSearch, btnDelete, btnAdd: TGlassButton;
    btnPapytusEmpty, btnPapytusValues, btnPapytusValuesAll, btnPapyrusCmp, btnPapyrusViewer, btnPapyrusDelete, btnPapyrusSearch, btnPapyrusAnalysis: TGlassButton;
    FormViews: TFormViews;
    procedure Progress(const Percent: Integer; var Break: Boolean);
    procedure FillTree;
    procedure FillTreePapyrus;
    procedure PrepareDataToShow;
    procedure RefreshData(var MyData: PMyRec);
    function LoadPapyrusFromESS(sFileName: string; var yData: TBytes): boolean;
    function LoadPapyrusFromBIN(sFileName: string; var yData: TBytes): boolean;
    procedure vtStructureSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; Text: string);
    procedure WndMsg(var Msg: TMsg; var Handled: Boolean);
    procedure DeleteSelectedObject;
    procedure DeleteSelectedForms;
    procedure AddObject;
  end;

var
  fMain: TfMain;

procedure LoadPapyrusData(var Papyrus: tPapyrus; var Data: TBytes; LastPos: PInt = nil);
procedure SavePapyrusData(var Papyrus: tPapyrus; var Data: TBytes);

implementation

uses
  ShellAPI, uAddForm, uFormIDArray, uAddScript, uAddInstance, uView, uPapyrusDataView;

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

function GetVersion: string;
var
  Size: DWORD;
  Buffer: Pointer;
  FI: PVSFixedFileInfo;
begin
  Result := '';
  Size := GetFileVersionInfoSize(PChar(Application.Exename), Size);
  if Size <> 0 then
  begin
    GetMem(Buffer, Size);
    try
      if GetFileVersionInfo(PChar(Application.Exename), 0, Size, Buffer) then
        if VerQueryValue(Buffer, '\', Pointer(FI), Size) then
          Result := Result + IntToStr ((FI.dwFileVersionMS and $FFFF0000) shr $10) + '.' +
                  IntToStr (FI.dwFileVersionMS and $FFFF) + {'.' +
                  IntToStr ((FI.dwFileVersionLS and $FFFF0000) shr $10) + '.' +}
                  '  build ' + IntToStr (FI.dwFileVersionLS and $FFFF);
    finally
      FreeMem (Buffer);
    end;
  end;
end;

procedure TfMain.WndMsg(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.Message = WM_SYSCOMMAND then
    case Msg.wParam of
      WM_ABOUT: begin
        Handled := True;
        ShellAbout(Handle, PChar('About' + '#' + Self.Caption),
          PChar('TESV ESS SaveGame Editor version ' + GetVersion + #13#10 + 'Copyright © 2012-2013 fubrus'),
          Application.Icon.Handle);
      end;
    end;
end;

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
  MyData: PMyRec;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) then
      RefreshData(MyData);
  end;
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

procedure TfMain.btnDeleteClick(Sender: TObject);
begin
  if pcEditors.ActivePageIndex = tsForms.PageIndex then
    DeleteSelectedForms
  else
    DeleteSelectedObject;
end;

function GetSelection(Node: PVirtualNode): PVirtualNode;
begin
  if Node^.PrevSibling <> nil then
    Result := Node^.PrevSibling
  else
    if Node^.NextSibling <> nil then
      Result := Node^.NextSibling
    else
      Result := Node^.Parent;
end;

function DeleteScript(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yScripts) then
    begin
      while Length(yScripts[iIndex]^.yParameters) > 0 do
      begin
        Dispose(yScripts[iIndex]^.yParameters[Length(yScripts[iIndex]^.yParameters) - 1]);
        SetLength(yScripts[iIndex]^.yParameters, Length(yScripts[iIndex]^.yParameters) - 1);
      end;
      Dispose(yScripts[iIndex]);
      if iIndex < (Length(yScripts) - 1) then
        Move(yScripts[iIndex + 1], yScripts[iIndex], SizeOf(yScripts[iIndex]) * (Length(yScripts) - iIndex - 1));
      iScriptCount := Length(yScripts) - 1;
      SetLength(yScripts, iScriptCount);
      Result := True;
    end;
end;

function DeleteInstance(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yInstances) then
    begin
      Dispose(yInstances[iIndex]);
      if iIndex < (Length(yInstances) - 1) then
        Move(yInstances[iIndex + 1], yInstances[iIndex], SizeOf(yInstances[iIndex]) * (Length(yInstances) - iIndex - 1));
      iInstanceCount := Length(yInstances) - 1;
      SetLength(yInstances, iInstanceCount);
      Result := True;
    end;
end;

function DeleteInstanceData(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yInstanceData) then
    begin
      while Length(yInstanceData[iIndex]^.yMembers) > 0 do
      begin
        Dispose(yInstanceData[iIndex]^.yMembers[Length(yInstanceData[iIndex]^.yMembers) - 1]);
        SetLength(yInstanceData[iIndex]^.yMembers, Length(yInstanceData[iIndex]^.yMembers) - 1);
      end;
      Dispose(yInstanceData[iIndex]);
      if iIndex < (Length(yInstanceData) - 1) then
        Move(yInstanceData[iIndex + 1], yInstanceData[iIndex], SizeOf(yInstanceData[iIndex]) * (Length(yInstanceData) - iIndex - 1));
      SetLength(yInstanceData, Length(yInstanceData) - 1);
      Result := True;
    end;
end;

function DeleteReference(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yReferences) then
    begin
      Dispose(yReferences[iIndex]);
      if iIndex < (Length(yReferences) - 1) then
        Move(yReferences[iIndex + 1], yReferences[iIndex], SizeOf(yReferences[iIndex]) * (Length(yReferences) - iIndex - 1));
      iReferenceCount := Length(yReferences) - 1;
      SetLength(yReferences, iReferenceCount);
      Result := True;
    end;
end;

function DeleteReferenceData(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yReferenceData) then
    begin
      while Length(yReferenceData[iIndex]^.yMembers) > 0 do
      begin
        Dispose(yReferenceData[iIndex]^.yMembers[Length(yReferenceData[iIndex]^.yMembers) - 1]);
        SetLength(yReferenceData[iIndex]^.yMembers, Length(yReferenceData[iIndex]^.yMembers) - 1);
      end;
      Dispose(yReferenceData[iIndex]);
      if iIndex < (Length(yReferenceData) - 1) then
        Move(yReferenceData[iIndex + 1], yReferenceData[iIndex], SizeOf(yReferenceData[iIndex]) * (Length(yReferenceData) - iIndex - 1));
      SetLength(yReferenceData, Length(yReferenceData) - 1);
      Result := True;
    end;
end;

function DeleteArray(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yArrays) then
    begin
      Dispose(yArrays[iIndex]);
      if iIndex < (Length(yArrays) - 1) then
        Move(yArrays[iIndex + 1], yArrays[iIndex], SizeOf(yArrays[iIndex]) * (Length(yArrays) - iIndex - 1));
      iArrayCount := Length(yArrays) - 1;
      SetLength(yArrays, iArrayCount);
      Result := True;
    end;
end;

function DeleteArrayData(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yArrayData) then
    begin
      while Length(yArrayData[iIndex]^.yMembers) > 0 do
      begin
        Dispose(yArrayData[iIndex]^.yMembers[Length(yArrayData[iIndex]^.yMembers) - 1]);
        SetLength(yArrayData[iIndex]^.yMembers, Length(yArrayData[iIndex]^.yMembers) - 1);
      end;
      Dispose(yArrayData[iIndex]);
      if iIndex < (Length(yArrayData) - 1) then
        Move(yArrayData[iIndex + 1], yArrayData[iIndex], SizeOf(yArrayData[iIndex]) * (Length(yArrayData) - iIndex - 1));
      SetLength(yArrayData, Length(yArrayData) - 1);
      Result := True;
    end;
end;

function DeleteActive(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yActives) then
    begin
      Dispose(yActives[iIndex]);
      if iIndex < (Length(yActives) - 1) then
        Move(yActives[iIndex + 1], yActives[iIndex], SizeOf(yActives[iIndex]) * (Length(yActives) - iIndex - 1));
      iActiveCount := Length(yActives) - 1;
      SetLength(yActives, iActiveCount);
      Result := True;
    end;
end;

function DeleteActiveData(iIndex: integer; var Papyrus: TPapyrus): Boolean;
begin
  Result := False;
  with Papyrus do
    if iIndex < Length(yActiveData) then
    begin
      ClearActiveData(yActiveData[iIndex]^);
      Dispose(yActiveData[iIndex]);
      if iIndex < (Length(yActiveData) - 1) then
        Move(yActiveData[iIndex + 1], yActiveData[iIndex], SizeOf(yActiveData[iIndex]) * (Length(yActiveData) - iIndex - 1));
      SetLength(yActiveData, Length(yActiveData) - 1);
      Result := True;
    end;
end;

procedure DeleteAndInitData(Tree: TVirtualStringTree; Node: PVirtualNode);
var
  Next: PVirtualNode;
begin
  with Tree do
  begin
    ReinitNode(Node^.Parent, False);
    Next := Node^.NextSibling;
    DeleteNode(Node, True);
    Node := Next;
    if Node <> nil then
      repeat
        ReinitNode(Node, False);
        Node := Node^.NextSibling;
      until Node = nil;
    Repaint;
  end;
end;

function GetFullPath(Node: PVirtualNode; Tree: TBaseVirtualTree): string;
var
  MyData: PPapyrusRec;
begin
  with Tree do
    if Node <> RootNode then
    begin
      MyData := GetNodeData(Node);
      if Assigned(MyData) then
        Result := MyData^._Caption;
//      if Pos('(', Result) <> 0 then
//        Result := Trim(Copy(Result, 1, Pos('(', Result) - 1));
      Result := GetFullPath(Node^.Parent, Tree) + '\' + Result;
    end;
end;

procedure TfMain.btnPapyrusDeleteClick(Sender: TObject);
var
  pIndex, pData: PVirtualNode;
  iTmp: Integer;
  bIndex, bData: Boolean;
begin
  if btnPapyrusDelete.Visible and (btnPapyrusDelete.Tag <> 0) then
    with vtPapyrus, Papyrus do
    try
      pIndex := Pointer(btnPapyrusDelete.Tag);
      if pIndex <> nil then
      begin
        Screen.Cursor := crHourGlass;
        pData := GetSelection(pIndex);
        Selected[pData] := True;
        FocusedNode := pData;
        bIndex := False;
        bData := False;
        case pIndex^.Parent^.Index of
          1: if pIndex^.Index < Cardinal(Length(yScripts)) then
            bIndex := DeleteScript(pIndex^.Index, Papyrus);
          2: if pIndex^.Index < Cardinal(Length(yInstances)) then
          begin
            iTmp := GetInstanceDataIndex(pIndex^.Index, Papyrus);
            if iTmp <> -1 then
            begin
              pData := GetChild(GetChild(pIndex^.Parent^.Parent, 7), iTmp);
              if pData <> nil then
                bData := DeleteInstanceData(iTmp, Papyrus);
            end;
            bIndex := DeleteInstance(pIndex^.Index, Papyrus);
          end;
          3: if pIndex^.Index < Cardinal(Length(yReferences)) then
          begin
            iTmp := GetReferenceDataIndex(pIndex^.Index, Papyrus);
            if iTmp <> -1 then
            begin
              pData := GetChild(GetChild(pIndex^.Parent^.Parent, 8), iTmp);
              if pData <> nil then
                bData := DeleteReferenceData(iTmp, Papyrus);
            end;
            bIndex := DeleteReference(pIndex^.Index, Papyrus);
          end;
          4: if pIndex^.Index < Cardinal(Length(yArrays)) then
          begin
            iTmp := GetArrayDataIndex(pIndex^.Index, Papyrus);
            if iTmp <> -1 then
            begin
              pData := GetChild(GetChild(pIndex^.Parent^.Parent, 9), iTmp);
              if pData <> nil then
                bData := DeleteArrayData(iTmp, Papyrus);
            end;
            bIndex := DeleteArray(pIndex^.Index, Papyrus);
          end;
          6: if pIndex^.Index < Cardinal(Length(yActives)) then
          begin
            iTmp := GetActiveDataIndex(pIndex^.Index, Papyrus);
            if iTmp <> -1 then
            begin
              pData := GetChild(GetChild(pIndex^.Parent^.Parent, 10), iTmp);
              if pData <> nil then
                bData := DeleteActiveData(iTmp, Papyrus);
            end;
            bIndex := DeleteActive(pIndex^.Index, Papyrus);
          end;
          7: if pIndex^.Index < Cardinal(Length(yInstanceData)) then
          begin
            pData := pIndex;
            iTmp := GetInstanceIndex(yInstanceData[pData^.Index].iID, Papyrus);
            if iTmp <> -1 then
            begin
              pIndex := GetChild(GetChild(pData^.Parent^.Parent, 2), iTmp);
              if pIndex <> nil then
                bIndex := DeleteInstance(iTmp, Papyrus);
            end;
            bData := DeleteInstanceData(pData^.Index, Papyrus);
          end;
          8: if pIndex^.Index < Cardinal(Length(yReferenceData)) then
          begin
            pData := pIndex;
            iTmp := GetReferenceIndex(yReferenceData[pData^.Index].iID, Papyrus);
            if iTmp <> -1 then
            begin
              pIndex := GetChild(GetChild(pData^.Parent^.Parent, 3), iTmp);
              if pIndex <> nil then
                bIndex := DeleteReference(iTmp, Papyrus);
            end;
            bData := DeleteReferenceData(pData^.Index, Papyrus);
          end;
          9: if pIndex^.Index < Cardinal(Length(yArrayData)) then
          begin
            pData := pIndex;
            iTmp := GetArrayIndex(yArrayData[pData^.Index].iID, Papyrus);
            if iTmp <> -1 then
            begin
              pIndex := GetChild(GetChild(pData^.Parent^.Parent, 4), iTmp);
              if pIndex <> nil then
                bIndex := DeleteArray(iTmp, Papyrus);
            end;
            bData := DeleteArrayData(pData^.Index, Papyrus);
          end;
          10: if pIndex^.Index < Cardinal(Length(yActiveData)) then
          begin
            pData := pIndex;
            iTmp := GetActiveIndex(yActiveData[pData^.Index].iID, Papyrus);
            if iTmp <> -1 then
            begin
              pIndex := GetChild(GetChild(pData^.Parent^.Parent, 6), iTmp);
              if pIndex <> nil then
                bIndex := DeleteActive(iTmp, Papyrus);
            end;
            bData := DeleteActiveData(pData^.Index, Papyrus);
          end;
        end;
        if bIndex then
          DeleteAndInitData(vtPapyrus, pIndex);
        if bData then
          DeleteAndInitData(vtPapyrus, pData);
        bSave := bSave or bIndex or bData;
        pnPath.Caption := '  ' + GetFullPath(GetFirstSelected, vtPapyrus);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
end;

procedure TfMain.btnPapyrusAnalysisClick(Sender: TObject);
var
  pIndex: PVirtualNode;
begin
  if btnPapyrusAnalysis.Visible and (btnPapyrusAnalysis.Tag <> 0) then
    with vtPapyrus, Papyrus do
    begin
      pIndex := Pointer(btnPapyrusAnalysis.Tag);
      if pIndex <> nil then
        if GetNodeLevel(pIndex) = 1 then
          ShowOtherData('Papyrus Other Data Viewer', Papyrus)
        else
          if pIndex^.Index < Cardinal(Length(yActiveData)) then
            ShowActiveData('Papyrus Active Script Data Viewer', yActiveData[pIndex^.Index]^, Papyrus);
    end;
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
            8: sName := sName + GetTypeString(ESSFile.globalDataTable1[BufNode^.Parent^.Index]^._type);
            9: sName := sName + GetTypeString(ESSFile.globalDataTable2[BufNode^.Parent^.Index]^._type);
            11: sName := sName + GetTypeString(ESSFile.globalDataTable3[BufNode^.Parent^.Index]^._type);
          end;
      btForm:
        sName := sName + Copy(GetFormString(ESSFile.changeForms[BufNode^.Parent^.Index]^._type), 1, 4);
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
          SetLength(Buff, ESSFile.ChangeForms[No]^.length1);
          if ESSFile.ChangeForms[No]^.length1 > 0 then
            Move(ESSFile.ChangeForms[No]^.Data^[0], Buff[0], ESSFile.ChangeForms[No]^.length1);
          if ESSFile.ChangeForms[No]^.length2 > 0 then
            DecompressData(Buff, ESSFile.ChangeForms[No]^.length2);
          AssignFile(F, sOutDir + RefIDToHex(ESSFile.ChangeForms[No]^.formID) + '.BIN');
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

{$IF Defined(USEREGION)}{$REGION 'RefreshData'}{$IFEND}
procedure TfMain.RefreshData(var MyData: PMyRec);
begin
  with MyData^ do
    case _Type of
      btForm:
        begin
          SetData(TBytes(_Pointer^), BufData, _Size, _Decompressed, heEdit, True);
          if BufNode^.Parent <> nil then
          begin
            ESSFile.changeForms[BufNode^.Parent^.Index]^.length1 := _Size;
            ESSFile.changeForms[BufNode^.Parent^.Index]^.length2 := _Decompressed;
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
              8: ESSFile.globalDataTable1[BufNode^.Parent^.Index]^._length := _Size;
              9: ESSFile.globalDataTable2[BufNode^.Parent^.Index]^._length := _Size;
              11: ESSFile.globalDataTable3[BufNode^.Parent^.Index]^._length := _Size;
            end;
            SetNodeText(vtStructure, GetChild(BufNode^.Parent, 1));
          end;
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
              MessageBox(Handle, PChar('Can''t read from selected file:'#13 + odBinOpen.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
          end;
        except
          SetLength(BufData, 0);
          MessageBox(Handle, PChar('File is to large!'), 'Error', MB_OK or MB_ICONERROR);
        end
      finally
        CloseFile(F);
      end
      else
        MessageBox(Handle, PChar('Can''t open selected file:'#13 + odBinOpen.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
      {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
      WriteHexEditor(BufData, heEdit);
      RefreshData(MyData);
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Fill zero BIN data'}{$IFEND}
procedure TfMain.btnZeroClick(Sender: TObject);
var
  MyData: PMyRec;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Size > 0)  then
    begin
      if MyData^._Decompressed <> 0 then
        SetLength(BufData, MyData^._Decompressed)
      else
        SetLength(BufData, MyData^._Size);
      ZeroMemory(@BufData[0], MyData^._Size);
      WriteHexEditor(BufData, heEdit);
      RefreshData(MyData);
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'btnPapyrusEmptyClick'}{$IFEND}
procedure TfMain.btnPapyrusEmptyClick(Sender: TObject);
var
  MyData: PMyRec;
  Res: Integer;
begin
  if vtStructure.GetFirstSelected <> nil then
  try
    bBreak := False;
    CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
    MyData := vtStructure.GetNodeData(GetChild(vtStructure.GetFirstSelected, 2));
    if Assigned(MyData) and (MyData^._Size > 0) then
    begin
      ZeroMemory(@TBytes(MyData^._Pointer^)[0], MyData^._Size);
      LoadPapyrusData(Papyrus, TBytes(MyData^._Pointer^));
      FillTreePapyrus;
    end;
    sFileName := ChangeFileExt(sFileName, '_Empty' + ExtractFileExt(sFileName));
    Res := SaveESSFile(ESSFile, sFileName, Progress);
    case Res of
      -2: MessageBox(Handle, 'Wrong data', 'Error', MB_OK or MB_ICONSTOP);
      -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
       0: pnStatus.Caption := MinimizeName(sFileName, THackPanel(pnStatus).Canvas, pnStatus.ClientWidth - 8);
      else
        MessageBox(Handle, PChar('Write error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
    end;
  finally
    FreeProgress(btnBreak, pbProcess, pnStatus);
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'LoadPapyrusFromESS'}{$IFEND}
function TfMain.LoadPapyrusFromESS(sFileName: string; var yData: TBytes): boolean;
var
  Res: Integer;
  ESS: TESSFile;
begin
  Result := False;
  SetLength(yData, 0);
  try
    bBreak := False;
    CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
    Res := ReadESSFile(ESS, sFileName, Progress);
    case Res of
      -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
      0: with ESS do
         begin
           for Res := 0 to Length(globalDataTable1) - 1 do
             with globalDataTable1[Res]^ do
               if _type = 1001 then
               begin
                 if Length(data^) > 0 then
                 begin
                   SetLength(yData, Length(data^));
                   Move(data^[0], yData[0], Length(data^));
                 end;
                 Result := True;
                 Break;
               end;
           if not Result then
             for Res := 0 to Length(globalDataTable2) - 1 do
               with globalDataTable2[Res]^ do
                 if _type = 1001 then
                 begin
                   if Length(data^) > 0 then
                   begin
                     SetLength(yData, Length(data^));
                     Move(data^[0], yData[0], Length(data^));
                   end;
                   Result := True;
                   Break;
                 end;
           if not Result then
             for Res := 0 to Length(globalDataTable3) - 1 do
               with globalDataTable3[Res]^ do
                 if _type = 1001 then
                 begin
                   if Length(data^) > 0 then
                   begin
                     SetLength(yData, Length(data^));
                     Move(data^[0], yData[0], Length(data^));
                   end;
                   Result := True;
                   Break;
                 end;
         end;
      else
        MessageBox(Handle, PChar('Read error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
    end;
  finally
    FreeProgress(btnBreak, pbProcess, pnStatus);
    FreeESSFile(ESS);
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'LoadPapyrusFromBIN'}{$IFEND}
function TfMain.LoadPapyrusFromBIN(sFileName: string; var yData: TBytes): boolean;
var
  F: file;
begin
  Result := False;
  AssignFile(F, sFileName);
  try
    Reset(F, 1);
    try
      SetLength(yData, FileSize(F));
      if Length(yData) > 0 then
        BlockRead(F, yData[0], FileSize(F));
      Result := True;
    finally
      CloseFile(F);
    end;
  except
    on E: Exception do MessageBox(Handle, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'btnPapyrusValuesClick'}{$IFEND}
procedure TfMain.btnPapyrusValuesClick(Sender: TObject);
var
  MyData: PMyRec;
  D: TBytes;
  V, P: TPapyrus;
  Res: integer;
begin
  if vtStructure.GetFirstSelected <> nil then
  begin
    MyData := vtStructure.GetNodeData(GetChild(vtStructure.GetFirstSelected, 2));
    if Assigned(MyData) and (MyData^._Size > 0) and odOpen.Execute and LoadPapyrusFromESS(odOpen.FileName, D) then
      with MyData^ do
      begin
        LoadPapyrusData(V, D);
        SetLength(D, 0);
        LoadPapyrusData(P, TBytes(_Pointer^));
        with TfPapyrus.Create(Application) do
        try
          CopyVariables(P, V, Sender = btnPapytusValuesAll);
          SavePapyrusData(P, TBytes(MyData^._Pointer^));
          MyData^._Size := Length(TBytes(MyData^._Pointer^));
          case vtStructure.GetFirstSelected^.Parent^.Index of
            8: ESSFile.globalDataTable1[vtStructure.GetFirstSelected^.Index]^._length := MyData^._Size;
            9: ESSFile.globalDataTable2[vtStructure.GetFirstSelected^.Index]^._length := MyData^._Size;
            11: ESSFile.globalDataTable3[vtStructure.GetFirstSelected^.Index]^._length := MyData^._Size;
          end;
          SetNodeText(vtStructure, GetChild(vtStructure.GetFirstSelected, 1));
        finally
          Release;
          ClearPapyrus(P);
          ClearPapyrus(V);
        end;
        LoadPapyrusData(Papyrus, TBytes(MyData^._Pointer^));
        FillTreePapyrus;
        try
          bBreak := False;
          CreateProgress(Self, pnWorkplace, btnBreak, pbProcess, pnStatus, btnBreakClick);
          sFileName := ChangeFileExt(sFileName, '_Restored' + ExtractFileExt(sFileName));
          Res := SaveESSFile(ESSFile, sFileName, Progress);
          case Res of
            -2: MessageBox(Handle, 'Wrong data', 'Error', MB_OK or MB_ICONSTOP);
            -1: MessageBox(Handle, 'User break', 'Information', MB_OK or MB_ICONINFORMATION);
             0: pnStatus.Caption := MinimizeName(sFileName, THackPanel(pnStatus).Canvas, pnStatus.ClientWidth - 8);
            else
              MessageBox(Handle, PChar('Write error in step: ' + IntToStr(Res) + #13 + SysErrorMessage(LastIOState)), 'Error', MB_OK or MB_ICONERROR);
          end;
        finally
          FreeProgress(btnBreak, pbProcess, pnStatus);
        end;
      end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.btnPapyrusCmpClick(Sender: TObject);
var
  D1, D2: TBytes;
  S: string;
begin
  if odPapyrus.Execute then
    if ((odPapyrus.FilterIndex = 1) and LoadPapyrusFromESS(odPapyrus.FileName, D1)) or
       ((odPapyrus.FilterIndex <> 1) and LoadPapyrusFromBIN(odPapyrus.FileName, D1)) then
    try
      S := odPapyrus.FileName;
      if odPapyrus.Execute then
        if ((odPapyrus.FilterIndex = 1) and LoadPapyrusFromESS(odPapyrus.FileName, D2)) or
           ((odPapyrus.FilterIndex <> 1) and LoadPapyrusFromBIN(odPapyrus.FileName, D2)) then
          try
            with TfCmpPapyrus.Create(Application) do
            begin
              Caption := 'Compare Papyrus [' + ExtractFileName(S) + '] - [' + ExtractFileName(odPapyrus.FileName) + ']';
              Compare(D1, D2, ExtractFileName(S), ExtractFileName(odPapyrus.FileName));
            end;
          finally
            SetLength(D2, 0);
          end;
    finally
      SetLength(D1, 0);
    end;
end;

procedure TfMain.btnPapyrusViewerClick(Sender: TObject);
var
  D: TBytes;
begin
  if odPapyrus.Execute then
    if ((odPapyrus.FilterIndex = 1) and LoadPapyrusFromESS(odPapyrus.FileName, D)) or
       ((odPapyrus.FilterIndex <> 1) and LoadPapyrusFromBIN(odPapyrus.FileName, D)) then
      try
        with TfViewer.Create(Application) do
        begin
          Caption := 'Papyrus Viewer [' + ExtractFileName(odPapyrus.FileName) + ']';
          LoadPapyrusData(Papyrus, D);
          FillTreePapyrus;
          Show;
        end;
      finally
        SetLength(D, 0);
      end;
end;

procedure TfMain.btnFirstACHRClick(Sender: TObject);
var
  i: Integer;
begin
  with ESSFile, vtStructure do
    if magic = C_TESVESS then
      for i := 0 to Length(changeForms) - 1 do
        with changeForms[i]^ do
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
        with changeForms[i]^ do
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
    vtPapyrus.Clear;
    ClearPapyrus(Papyrus);
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

procedure TfMain.edPapyrusSearchChange(Sender: TObject);
begin
  btnPapyrusSearch.Enabled := Trim(edPapyrusSearch.Text) <> '';
  stPapyrusNotFound.Visible := False;
end;

procedure TfMain.edPapyrusSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Trim(edPapyrusSearch.Text) <> '') then
    btnPapyrusSearch.Click;
end;

procedure TfMain.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Trim(edSearch.Text) <> '') then
    btnSearch.Click;
end;

procedure TfMain.edSearchChange(Sender: TObject);
begin
  btnSearch.Enabled := Trim(edSearch.Text) <> '';
  stNotFound.Visible := False;
end;

procedure TfMain.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  AppendMenu(GetSystemMenu(Application.Handle, FALSE), MF_SEPARATOR, 0, ' ');
  AppendMenu(GetSystemMenu(Application.Handle, FALSE), MF_STRING, WM_ABOUT, 'About...');
  AppendMenu(GetSystemMenu(Handle, FALSE), MF_SEPARATOR, 0, ' ');
  AppendMenu(GetSystemMenu(Handle, FALSE), MF_STRING, WM_ABOUT, 'About...');
  Application.OnMessage := WndMsg;
  Caption := Caption + ' ' + DateToStr(UnixTimeToDateTime(GetImageLinkTimeStamp(ParamStr(0))));
  {$IF Defined(USEREGION)}{$REGION 'Create controls'}{$IFEND}
  imLogo.Picture.Bitmap.LoadFromResourceName(hInstance, 'SM');
  TXPMenu.Create(Self);
  btnOpen := CreateButton('Open', True, clBlack, 2, 2, 25, 60, 0, 0, [akLeft, akTop], Self, pnWorkplace, imImages, btnOpenClick, nil);
  btnFirstACHR := CreateButton('Player ACHR', True, clBlack, btnOpen.Left + btnOpen.Width + 4, 2, 25, 75, 0, 1, [akLeft, akTop], Self, pnWorkplace, nil, btnFirstACHRClick, nil);
  btnFirstACHR.Visible := False;
  btnFirstNPC := CreateButton('Player NPC', True, clBlack, btnFirstACHR.Left + btnFirstACHR.Width + 4, 2, 25, 70, 0, 2, [akLeft, akTop], Self, pnWorkplace, nil, btnFirstNPCClick, nil);
  btnFirstNPC.Visible := False;
  btnCompare := CreateButton('Compare', True, clBlack, btnFirstNPC.Left + btnFirstNPC.Width + 4, 2, 25, 75, 7, 3, [akLeft, akTop], Self, pnWorkplace, imImages, btnCompareClick, nil);
  btnDelete := CreateButton('Delete', True, clBlack, btnCompare.Left + btnCompare.Width + 4, 2, 25, 75, 11, 4, [akLeft, akTop], Self, pnWorkplace, imImages, btnDeleteClick, nil);
  btnAdd := CreateButton('Add', True, clBlack, btnDelete.Left + btnDelete.Width + 4, 2, 25, 60, 13, 5, [akLeft, akTop], Self, pnWorkplace, imImages, btnAddClick, nil);
  btnDelete.Visible := False;
  btnAdd.Visible := False;
  btnSave := CreateButton('Save', True, clBlack, pnWorkplace.ClientWidth - 60, 2, 25, 60, 1, 6, [akRight, akTop], Self, pnWorkplace, imImages, btnSaveClick, nil);
  btnSave.Visible := False;
  btnExport := CreateButton('Export', True, clBlack, 2, 2, 25, 75, 4, 0, [akLeft, akTop], Self, pnData, imImages, btnExportClick, nil);
  btnImport := CreateButton('Import', True, clBlack, 83, 2, 25, 75, 5, 1, [akLeft, akTop], Self, pnData, imImages, btnImportClick, nil);
  btnZero := CreateButton('Fill zeros', True, clBlack, 164, 2, 25, 75, -1, 2, [akLeft, akTop], Self, pnData, nil, btnZeroClick, nil);
  btnPapytusEmpty := CreateButton('Empty papyrus', True, clBlack, 4, 4, 25, 130, 4, 0, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusEmptyClick, nil);
  btnPapytusValues := CreateButton('Load values', True, clBlack, 4, 33, 25, 130, 5, 1, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusValuesClick, nil);
  btnPapytusValuesAll := CreateButton('Complex load values', True, clBlack, 4, 62, 25, 130, 5, 2, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusValuesClick, nil);
  btnPapyrusCmp := CreateButton('Compare', True, clBlack, 4, 95, 25, 130, 10, 3, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusCmpClick, nil);
  btnPapyrusViewer := CreateButton('View', True, clBlack, 4, 124, 25, 130, 6, 4, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusViewerClick, nil);
  btnPapyrusDelete := CreateButton('Delete', True, clBlack, 4, 157, 25, 130, 11, 5, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusDeleteClick, nil);
  btnPapyrusDelete.Visible := False;
  btnPapyrusAnalysis := CreateButton('Analysis', True, clBlack, 4, 190, 25, 130, 15, 6, [akLeft, akTop], Self, pnTools, imImages, btnPapyrusAnalysisClick, nil);
  btnPapyrusAnalysis.Visible := False;
  btnForms := CreateButton('Export list', True, clBlack, 2, 2, 25, 100, 4, 0, [akLeft, akTop], Self, pnForms, imImages, btnFormsClick, nil);
  btnFormsData := CreateButton('Export data', True, clBlack, 110, 2, 25, 100, 6, 1, [akLeft, akTop], Self, pnForms, imImages, btnFormsDataClick, nil);
  btnGD01All := CreateButton('Export list', True, clBlack, 2, 2, 25, 100, 4, 0, [akLeft, akTop], Self, pnGD01All, imImages, btnGD01AllClick, nil);
  btnGD04 := CreateButton('Export list', True, clBlack, 2, 2, 25, 100, 4, 0, [akLeft, akTop], Self, pnGD04, imImages, btnGD04Click , nil);
  btnSearch := CreateButton('Search', False, clBlack, edSearch.Left + edSearch.Width + 4, edSearch.Top - 4, 25, 75, 7, 2, [akLeft, akTop], Self, pnSearch, fMain.imImages, btnSearchClick, nil);
  btnPapyrusSearch := CreateButton('Search', False, clBlack, 4, pnTools.ClientHeight - 29, 25, 130, 7, 6, [akLeft, akBottom], Self, pnTools, fMain.imImages, btnPapyrusSearchClick, nil);
  edPapyrusSearch.Width := edPapyrusSearch.Parent.ClientWidth - edPapyrusSearch.Left * 2;
  edPapyrusSearch.Top := btnPapyrusSearch.Top - edPapyrusSearch.Height -  edPapyrusSearch.Left;
  lbPapyrusSearch.Top := edPapyrusSearch.Top - lbPapyrusSearch.Height - edPapyrusSearch.Left;
  stPapyrusNotFound.Top := lbPapyrusSearch.Top;
  vtStructure := TVirtualStringTree.Create(Self);
  with vtStructure do
  begin
    Parent := pnStructure;
    Align := alClient;
    TabOrder := 1;
    Visible := False;
    Color := $F7F7F7;
    Colors.UnfocusedSelectionColor := clHighlight;
  end;
  vtPapyrus := TVirtualStringTree.Create(Self);
  with vtPapyrus do
  begin
    Parent := pnGD32Background;
    Align := alClient;
    TabOrder := 1;
    Color := $F7F7F7;
    Colors.UnfocusedSelectionColor := clHighlight;
  end;
  vtTMP := TVirtualStringTree.Create(Self);
  with vtTMP do
  begin
    Parent := tsGD0X;
    Align := alClient;
    TabOrder := 1;
    Color := $F7F7F7;
    Colors.UnfocusedSelectionColor := clHighlight;
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
    OnKeyUp := vtStructureKeyUp;
  end;
  with vtPapyrus do
  begin
    IncrementalSearch := isVisibleOnly;
    NodeDataSize := SizeOf(TPapyrusRec);
    OnGetText := vtPapyrusGetText;
    OnFreeNode := vtPapyrusFreeNode;
    OnInitNode := vtPapyrusInitNode;
    OnChange := vtPapyrusChange;
    OnKeyUp := vtPapyrusKeyUp;
  end;
  with vtTMP do
  begin
    IncrementalSearch := isVisibleOnly;
    NodeDataSize := SizeOf(TPapyrusRec);
    OnGetText := vtPapyrusGetText;
    OnFreeNode := vtPapyrusFreeNode;
    OnInitNode := vtTMPInitNode;
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
  ClearPapyrus(Papyrus);
  ClearPapyrus(P1);
  ClearPapyrus(P2);
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F3 then
    if Trim(edSearch.Text) = '' then
      pnSearch.Visible := pnStructure.Visible and (not pnSearch.Visible)
    else
      btnSearch.Click;
//  if Key = VK_F9 then
//    with TfAddInstance.Create(Application) do
//    try
//      AddInstance(@Papyrus);
//    finally
//      Release;
//    end;
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  pnStatus.Caption := MinimizeName(sFileName, THackPanel(pnStatus).Canvas, pnStatus.Parent.ClientWidth - 8);
  btnSave.Left := btnSave.Parent.ClientWidth - btnSave.Width - 2;
  spSplit.Left := pnStructure.Width;
  if pcEditors.ActivePage = tsData then
    heEdit.UpdateSize;
  lbLink.Top := pnWorkplace.ClientHeight - pnStatus.Height - lbLink.Height - 4;
  lbLink.Left := (pnWorkplace.ClientWidth - lbLink.Width) div 2;
end;

procedure TfMain.lbLinkClick(Sender: TObject);
begin
  if Sender is TLabel then
    ShellExecute(Application.Handle, PChar('open'), PChar((Sender as TLabel).Caption), nil, nil, SW_SHOW);
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

procedure TfMain.lvFormsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DELETE:
      if btnDelete.Visible then
        DeleteSelectedForms;
  end;
end;

procedure TfMain.lvFormsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Sender is TListView then
    with Sender as TListView do
      btnDelete.Visible := btnDelete.Visible or (Selected <> nil);
  if btnDelete.Visible and btnAdd.Visible and (btnAdd.Left = btnDelete.Left) then
    btnAdd.Left := btnDelete.Left + btnDelete.Width + 4;
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

procedure ExportActiveScriptData(Handle: THandle; var P: TPapyrus; sFileName: string);
var
  i: integer;
  F: file;
  s: string;
begin
  with P do
    for i := 0 to Length(yActiveData) do
    begin
      s := IntToStr(i);
      while Length(s) < 4 do
        s := '0' + s;
      s := ExtractFileDir(ParamStr(0)) + '\' + ExtractFileName(sFileName) + '.' + s + '.BIN';
      AssignFile(F, s);
      try
        try
          ReWrite(F, 1);
          if i = Length(yActiveData) then
          begin
            if Length(yOther) > 0 then
              BlockWrite(F, yOther[0], Length(yOther));
          end
          else
            if Length(yActiveData[i]^.yData) > 0 then
              BlockWrite(F, yActiveData[i]^.yData[0], Length(yActiveData[i]^.yData));
        finally
          CloseFile(F);
        end;
      except
        on E: Exception do MessageBox(Handle, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
      end;
    end;
end;

const
  VK_C = $43;

procedure TfMain.vtPapyrusKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  PapyrusRec: PPapyrusRec;
begin
  if (ssCtrl in Shift) and (Sender is TVirtualStringTree) then
    with Sender as TVirtualStringTree do
      case Key of
        VK_C:
          if GetFirstSelected <> nil then
          begin
            PapyrusRec := GetNodeData(GetFirstSelected);
            if Assigned(PapyrusRec) then
              Clipboard.AsText := PapyrusRec^._Caption;
          end;
        VK_F12:
          ExportActiveScriptData(Handle, Papyrus, sFileName);
      end;
end;

procedure TfMain.vtStructureKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  MyData: PMyRec;
begin
  if Sender is TVirtualStringTree then
    with Sender as TVirtualStringTree do
      case Key of
        VK_C:
          if (GetFirstSelected <> nil) and (ssCtrl in Shift) then
          begin
            MyData := GetNodeData(GetFirstSelected);
            if Assigned(MyData) then
              Clipboard.AsText := MyData^._Caption;
          end;
        VK_DELETE:
          if btnDelete.Visible then
            DeleteSelectedObject;
        VK_INSERT:
          if btnAdd.Visible then
            AddObject;
      end;
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
  with ESSFile, lvForms do
    if magic = C_TESVESS then
    begin
      SetLength(FormViews, Length(changeForms));
      for i := 0 to Length(changeForms) - 1 do
      begin
        CopyMemory(@FormViews[i].Form, @changeForms[i]^, SizeOf(TFormView) - SizeOf(Integer));
        FormViews[i].No := i + 1;
      end;
      OwnerData := True;
      Items.Count := Length(changeForms);
      if Boolean(Tag and 1) then
        QuickSortForms(FormViews, 0, Length(FormViews) - 1, True, Tag shr 1)
      else
        QuickSortForms(FormViews, 0, Length(FormViews) - 1, False, Tag shr 1);
      for i := 0 to Columns.Count - 1 do
        SetColumnSortOrder(lvForms, i, Tag shr 1, Boolean(Tag and 1));
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
      if (MyData^._Size <> iPos) and (iPos > 0) then
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
  fValue: float;
begin
  if not IsVista and (tsGD02.Tag = 0) then
  begin
    SetListHeadColor(lvGD02.Handle, lvGD02Proc, Longint(@lvGD02NewProc));
    tsGD02.Tag := 1;
  end;
  lvGD02.Clear;
  lvGD02.Tag := 0;
  lvGD02.Columns[0].Width := 150;
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
    begin
      iPos := 0;
      iValue := 0;
      fValue := 0.0;
      for i := 0 to 8 do
      begin
        iAddress := iPos;
        case i of
          1, 4:
          begin
            if iPos > 0 then
              rValue := Read_RefID(TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
              with lvGD02.Items.Add do
              begin
                Caption := RefIDToHex(rValue);
                Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                case i of
                  1: SubItems.Add('worldSpace1');
                  4: SubItems.Add('worldSpace2');
                else
                  SubItems.Add('unknown RefID');
                end;
              end;
          end;
          5..7:
          begin
            if iPos > 0 then
              fValue := Read_float32(TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
              with lvGD02.Items.Add do
              begin
                Caption := FloatToStr(fValue);
                Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                case i of
                  5: SubItems.Add('posX');
                  6: SubItems.Add('posY');
                  7: SubItems.Add('posZ');
                else
                  SubItems.Add('unknown float');
                end;
              end;
          end;
          8:
          begin
            if (iPos > 0) and (iPos < MyData^._Size) then
            begin
              iValue := Read_uint8(TBytes(MyData^._Pointer^), iPos);
              if iPos > 0 then
                with lvGD02.Items.Add do
                begin
                  Caption := IntToStr(iValue);
                  Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                  SubItems.Add('unk');
                end;
            end
          end
          else
          begin
            if (iPos > 0) or (i = 0) then
              iValue := Read_uint32(TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
              with lvGD02.Items.Add do
              begin
                Caption := IntToStr(iValue);
                Data := @(TBytes(MyData^._Pointer^)[iAddress]);
                case i of
                  2: SubItems.Add('coorX');
                  3: SubItems.Add('coorY');
                else
                  SubItems.Add('nextObjectID');
                end;
              end;
          end;
        end;
        if iPos = 0 then
        begin
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
          Break
        end;
      end;
      if (MyData^._Size <> iPos) and (iPos > 0) then
        MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
    end;
  end;
  lvGD02.Columns[0].Width := lvGD02.Columns[0].Width + 1;
  BufNode := nil;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}


procedure AnalyseActiveData(var Buf: TBytes; var FromPos: Integer; var Data: TActiveData);
var
  i, j, k, s: Integer;
  procedure CheckName;
  begin
    with Data.tUnknown4 do
    begin
      if AnsiUpperCase(sName) = AnsiUpperCase('QuestStage') then
      begin
        if FromPos > 0 then tRef := Read_RefID(Buf, FromPos);
        if FromPos > 0 then iStr := Read_uint16(Buf, FromPos);
        if FromPos > 0 then bUnk := Read_uint8(Buf, FromPos);
      end;
      if AnsiUpperCase(sName) = AnsiUpperCase('SceneResults') then
        if FromPos > 0 then tRef := Read_RefID(Buf, FromPos);
      if (AnsiUpperCase(sName) = AnsiUpperCase('ScenePhaseResults')) or (AnsiUpperCase(sName) = AnsiUpperCase('SceneActionResults')) then
        begin
          if FromPos > 0 then tRef := Read_RefID(Buf, FromPos);
          if FromPos > 0 then iUnk := Read_uint32(Buf, FromPos);
        end;
    end;
  end;
  function GetParametersCount(OpCode: Byte): integer;
  begin
    case OpCode of
      $14, $1A: Result := 1;
      $0A..$0E, $15, $16, $1E, $1F: Result := 2;
      $01..$09, $0F..$13, $18, $1B..$1D, $20, $21: Result := 3;
      $17, $19, $23, $24: Result := 4;
      else
        Result := 0;
    end;
  end;
begin
  ClearActiveData(Data);
  ZeroMemory(@Data, SizeOf(TActiveData));
  s := FromPos;
  with Data do
  begin
    iID := Read_uint32(Buf, FromPos);
    if FromPos > 0 then iMajorVersion := Read_uint8(Buf, FromPos);
    if FromPos > 0 then iMinorVersion := Read_uint8(Buf, FromPos);
    if FromPos > 0 then tUnknown := Read_variable(Buf, FromPos);
    if FromPos > 0 then bFlag := Read_uint8(Buf, FromPos);
    if FromPos > 0 then bUnknownByte := Read_uint8(Buf, FromPos);
    if (bFlag and $01) <> 0 then
      if FromPos > 0 then iUnknown2 := Read_uint32(Buf, FromPos);
    if FromPos > 0 then iUnknown3 := Read_uint8(Buf, FromPos);
    with tUnknown4 do
      case iUnknown3 of
        1:
        begin
          if FromPos > 0 then sName := Read_w32string(Buf, FromPos);
          CheckName;
        end;
        2: if FromPos > 0 then tVariable := Read_variable(Buf, FromPos);
        3:
        begin
          if FromPos > 0 then sName := Read_w32string(Buf, FromPos);
          CheckName;
          if FromPos > 0 then tVariable := Read_variable(Buf, FromPos);
        end;
      end;
      if FromPos > 0 then iStackframecount := Read_uint32(Buf, FromPos);
      SetLength(yStackframe, iStackframecount);
      for i := 0 to iStackframecount - 1 do
        with yStackframe[i] do
        begin
          if FromPos > 0 then iVariablecount := Read_uint32(Buf, FromPos);
          if FromPos > 0 then bFlag := Read_uint8(Buf, FromPos);
          if FromPos > 0 then bFunctionType := Read_uint8(Buf, FromPos);
          if FromPos > 0 then iScriptName := Read_uint16(Buf, FromPos);
          if FromPos > 0 then iScriptBaseName := Read_uint16(Buf, FromPos);
          if FromPos > 0 then iEvent := Read_uint16(Buf, FromPos);
          if ((bFlag and $01) = 0) and (bFunctionType = 0) then
            if FromPos > 0 then iStatus := Read_uint16(Buf, FromPos);
          if FromPos > 0 then iOpcodeVersion := Read_uint8(Buf, FromPos);
          if FromPos > 0 then iOpcodeMinorVersion := Read_uint8(Buf, FromPos);
          if FromPos > 0 then iReturnType := Read_uint16(Buf, FromPos);
          if FromPos > 0 then iFunctionDocString := Read_uint16(Buf, FromPos);
          if FromPos > 0 then iFunctionUserFlags := Read_uint32(Buf, FromPos);
          if FromPos > 0 then iFunctionFlags := Read_uint8(Buf, FromPos);
          if FromPos > 0 then iFunctionParameterCount := Read_uint16(Buf, FromPos);
          SetLength(uFunctionParam, iFunctionParameterCount);
          for j := 0 to iFunctionParameterCount - 1 do
            with uFunctionParam[j] do
            begin
              if FromPos > 0 then iName := Read_uint16(Buf, FromPos);
              if FromPos > 0 then iType := Read_uint16(Buf, FromPos);
            end;
          if FromPos > 0 then iFunctionLocalsCount := Read_uint16(Buf, FromPos);
          SetLength(yFunctionLocal, iFunctionLocalsCount);
          for j := 0 to iFunctionLocalsCount - 1 do
            with yFunctionLocal[j] do
            begin
              if FromPos > 0 then iName := Read_uint16(Buf, FromPos);
              if FromPos > 0 then iType := Read_uint16(Buf, FromPos);
            end;
          if FromPos > 0 then iOpcodeCount := Read_uint16(Buf, FromPos);
          SetLength(yOpcodeData, iOpcodeCount);
          for j := 0 to iOpcodeCount - 1 do
            with yOpcodeData[j] do
            begin
              if FromPos > 0 then iOpcode := Read_uint8(Buf, FromPos);
              SetLength(yParameter, GetParametersCount(iOpcode));
              k := 0;
              while k < Length(yParameter) do
                with yParameter[k] do
                begin
                  if FromPos > 0 then iType := Read_uint8(Buf, FromPos);
                  case iType of
                    0: ;
                    1, 2: if FromPos > 0 then iData := Read_uint16(Buf, FromPos);
                    3: if FromPos > 0 then iData := Read_uint32(Buf, FromPos);
                    4: if FromPos > 0 then fData := Read_float32(Buf, FromPos);
                    5: if FromPos > 0 then iData := Read_uint8(Buf, FromPos);
                  end;
                  if (iOpcode in [$17..$19]) and (k = (GetParametersCount(iOpcode) - 1)) and (iData > 0) then
                    SetLength(yParameter, Length(yParameter) + Integer(iData));
                  Inc(k);
                end;
            end;
          if FromPos > 0 then iUnknown3 := Read_uint32(Buf, FromPos);
          SetLength(tUnknown, iVariablecount + 1);
          for j := 0 to iVariablecount do
            if FromPos > 0 then tUnknown[j] := Read_variable(Buf, FromPos);
        end;
      if iStackframecount > 0 then
         if FromPos > 0 then unknown5 := Read_uint8(Buf, FromPos);
    if FromPos > 0 then
    begin
      SetLength(yData, FromPos - s);
      Move(Buf[s], yData[0], FromPos - s);
    end;
  end;
end;

procedure LoadPapyrusData(var Papyrus: tPapyrus; var Data: TBytes; LastPos: PInt = nil);
{$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData'}{$IFEND}
var
  iPos, iCount, iCount1, iCount2, i, j, k, l: Integer;
  iValue: integer;
  rValue: TRefID;
  wsValue: wstring;
  yPatern: TBytes;
  procedure ReadMessageData(var FunctionMessageData: TFunctionMessageData);
  var
    i: integer;
  begin
    with FunctionMessageData do
    begin
      if iPos > 0 then
        unknown := Read_uint8(Data, iPos);
      if iPos > 0 then
        iScriptName := Read_uint16(Data, iPos);
      if iPos > 0 then
        iEvent := Read_uint16(Data, iPos);
      if iPos > 0 then
        tUnknow := Read_variable(Data, iPos);
      if iPos > 0 then
        iVariableCount := Read_uint32(Data, iPos);
      SetLength(yUnknown, iVariableCount);
      for i := 0 to iVariableCount - 1 do
        if iPos > 0 then
          yUnknown[i] := Read_variable(Data, iPos);
    end;
  end;
begin
  with Papyrus do
  try
    ClearPapyrus(Papyrus);
    if Length(Data) > 0 then
    begin
      iPos := 0;
      iValue := Read_uint16(Data, iPos);
      iVersion := iValue;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Strings'}{$IFEND}
      if iPos > 0 then
      begin
        iCount := Read_uint32(Data, iPos);
        iStringCount := iCount;
        if (iPos > 0) and (iCount > 0) then
        begin
          SetLength(yStrings, iCount - 1);
          for i := 1 to iCount - 1 do
          begin
            if iPos > 0 then
              wsValue := Read_wstring(Data, iPos);
            New(yStrings[i - 1]);
            yStrings[i - 1]^.sName := wstringToString(wsValue);
          end;
        end;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      if iPos > 0 then
        iCount := Read_uint32(Data, iPos)
      else
        iCount := 0;
      iScriptCount := iCount;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Scripts'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yScripts, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yScripts[i]);
          if iPos > 0 then
            iValue := Read_uint16(Data, iPos);
          yScripts[i]^.iName := iValue;
          if iPos > 0 then
            iValue := Read_uint16(Data, iPos);
          yScripts[i]^.iSType := iValue;
          if iPos > 0 then
            iCount1 := Read_uint32(Data, iPos)
          else
            iCount1 := 0;
          yScripts[i]^.iParameterCount := iCount1;
          if (iPos > 0) and (iCount1 > 0) then
          begin
            SetLength(yScripts[i]^.yParameters, iCount1);
            for j := 0 to iCount1 - 1 do
            begin
              New(yScripts[i]^.yParameters[j]);
              if iPos > 0 then
                iValue := Read_uint16(Data, iPos);
              yScripts[i]^.yParameters[j]^.iName := iValue;
              if iPos > 0 then
                iValue := Read_uint16(Data, iPos);
              yScripts[i]^.yParameters[j]^.iSType := iValue;
            end;
          end;
        end;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      if iPos > 0 then
        iCount := Read_uint32(Data, iPos);
      iInstanceCount := iCount;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Table 1'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yInstances, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yInstances[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yInstances[i]^.iID := iValue;
          if iPos > 0 then
            iValue := Read_uint16(Data, iPos);
          yInstances[i]^.iScript := iValue;
          if iPos > 0 then
            iCount1 := Read_uint16(Data, iPos)
          else
            iCount1 := 0;
          if iCount1 <> 0 then
            iCount1 := iCount1;
          yInstances[i]^.iUnknow1 := iCount1;
          if iPos > 0 then
            iCount2 := Read_uint16(Data, iPos)
          else
            iCount2 := 0;
          yInstances[i]^.iUnknow2 := iCount2;
          if SmallInt((yInstances[i]^.iUnknow1 and $3) * 1000 + yInstances[i]^.iUnknow2) = -1 then
            ;
          if iPos > 0 then
            rValue := Read_RefID(Data, iPos);
          yInstances[i]^.rRef := rValue;
          if iPos > 0 then
            iValue := Read_uint8(Data, iPos);
          yInstances[i]^.iUsed := iValue;
        end;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      if iPos > 0 then
        iCount := Read_uint32(Data, iPos);
      iReferenceCount := iCount;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Table 2'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yReferences, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yReferences[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yReferences[i]^.iID := iValue;
          if iPos > 0 then
            iCount1 := Read_uint16(Data, iPos)
          else
            iCount1 := 0;
          yReferences[i]^.iSType := iCount1;
        end;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      if iPos > 0 then
        iCount := Read_uint32(Data, iPos);
      iArrayCount := iCount;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Table 3'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yArrays, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yArrays[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yArrays[i]^.iID := iValue;
          if iPos > 0 then
            iValue := Read_uint8(Data, iPos);
          yArrays[i]^.iType := iValue;
          if iPos > 0 then
            if iValue in [1, 11] then
            begin
              if iPos > 0 then
                iCount2 := Read_uint16(Data, iPos)
              else
                iCount2 := 0;
              yArrays[i]^.iReference := iCount2;
            end;
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yArrays[i]^.iMemberCount := iValue;
        end;
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      if iPos > 0 then
        iValue := Read_uint32(Data, iPos);
      iPapyrusRuntime := iValue;
      if iPos > 0 then
        iCount := Read_uint32(Data, iPos);
      iActiveCount := iCount;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Table 4'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yActives, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yActives[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yActives[i]^.iID := iValue;
          if iPos > 0 then
            iValue := Read_uint8(Data, iPos);
          yActives[i]^.iUsed := iValue;
        end;
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      iCount := Length(yInstances);
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Data 1'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yInstanceData, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yInstanceData[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yInstanceData[i]^.iID := iValue;
          if iPos > 0 then
            iCount1 := Read_uint8(Data, iPos)
          else
            iCount1 := 0;
          yInstanceData[i]^.iFlag := iCount1;
          if iPos > 0 then
            iValue := Read_uint16(Data, iPos);
          yInstanceData[i]^.iReference := iValue;
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yInstanceData[i]^.iData1 := iValue;
          if (yInstanceData[i]^.iFlag and $4) <> 0 then
          begin
            if iPos > 0 then
              iValue := Read_uint32(Data, iPos);
            yInstanceData[i]^.iData2 := iValue;
          end
          else
            yInstanceData[i]^.iData2 := 0;
          if iPos > 0 then
            iCount1 := Read_uint32(Data, iPos)
          else
            iCount1 := 0;
          yInstanceData[i]^.iMemberCount := iCount1;
          if (iPos > 0) and (iCount1 > 0) then
          begin
            SetLength(yInstanceData[i]^.yMembers, iCount1);
            for j := 0 to iCount1 - 1 do
            begin
              New(yInstanceData[i]^.yMembers[j]);
              if iPos > 0 then
                iValue := Read_uint8(Data, iPos);
              yInstanceData[i]^.yMembers[j]^.iType := iValue;
              case iValue of
                1, 11:
                begin
                  if iPos > 0 then
                    iValue := Read_uint16(Data, iPos);
                  yInstanceData[i]^.yMembers[j]^.iReference := iValue;
                  if iPos > 0 then
                    iValue := Read_uint32(Data, iPos);
                  yInstanceData[i]^.yMembers[j]^.iData := iValue;
                end;
                2:
                begin
                  if iPos > 0 then
                    iValue := Read_uint16(Data, iPos);
                  yInstanceData[i]^.yMembers[j]^.iData := iValue;
                end;
                0, 3..5, 12..15:
                begin
                  if iPos > 0 then
                    iValue := Read_uint32(Data, iPos);
                  yInstanceData[i]^.yMembers[j]^.iData := iValue;
                end
                else
                  ShowMessage('Invalid type: ' + IntToStr(iValue) + ' data1: ' + IntToStr(i) + ' member: ' + IntToStr(j));
              end;
            end;
          end;
        end;
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      iCount := Length(yReferences);
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Data 2'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yReferenceData, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yReferenceData[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yReferenceData[i]^.iID := iValue;
          if iPos > 0 then
            iCount1 := Read_uint8(Data, iPos)
          else
            iCount1 := 0;
          yReferenceData[i]^.iFlag := iCount1;
          if iPos > 0 then
            iValue := Read_uint16(Data, iPos);
          yReferenceData[i]^.iReference := iValue;
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yReferenceData[i]^.iData1 := iValue;
          if (yInstanceData[i]^.iFlag and $4) <> 0 then
          begin
            if iPos > 0 then
              iValue := Read_uint32(Data, iPos);
            yReferenceData[i]^.iData2 := iValue;
          end
          else
            yReferenceData[i]^.iData2 := 0;
          if iPos > 0 then
            iCount1 := Read_uint32(Data, iPos)
          else
            iCount1 := 0;
          yReferenceData[i]^.iMemberCount := iCount1;
          if (iPos > 0) and (iCount1 > 0) then
          begin
            SetLength(yReferenceData[i]^.yMembers, iCount1);
            for j := 0 to iCount1 - 1 do
            begin
              New(yReferenceData[i]^.yMembers[j]);
              if iPos > 0 then
                iValue := Read_uint8(Data, iPos);
              yReferenceData[i]^.yMembers[j]^.iType := iValue;
              case iValue of
                1, 11:
                begin
                  if iPos > 0 then
                    iValue := Read_uint16(Data, iPos);
                  yReferenceData[i]^.yMembers[j]^.iReference := iValue;
                  if iPos > 0 then
                    iValue := Read_uint32(Data, iPos);
                  yReferenceData[i]^.yMembers[j]^.iData := iValue;
                end;
                2:
                begin
                  if iPos > 0 then
                    iValue := Read_uint16(Data, iPos);
                  yReferenceData[i]^.yMembers[j]^.iData := iValue;
                end;
                0, 3..5, 12..15:
                begin
                  if iPos > 0 then
                    iValue := Read_uint32(Data, iPos);
                  yReferenceData[i]^.yMembers[j]^.iData := iValue;
                end
                else
                  ShowMessage('Invalid type: ' + IntToStr(iValue) + ' data2: ' + IntToStr(i) + ' member: ' + IntToStr(j));
              end;
            end;
          end;
        end;
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      iCount := Length(yArrays);
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Data 3'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yArrayData, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yArrayData[i]);
          if iPos > 0 then
            iValue := Read_uint32(Data, iPos);
          yArrayData[i]^.iID := iValue;
          if iPos > 0 then
          begin
            SetLength(yArrayData[i]^.yMembers, yArrays[i]^.iMemberCount);
            for j := 0 to yArrays[i]^.iMemberCount - 1 do
            begin
              New(yArrayData[i]^.yMembers[j]);
              if iPos > 0 then
                iValue := Read_uint8(Data, iPos);
              yArrayData[i]^.yMembers[j]^.iType := iValue;
              case iValue of
                1, 11:
                begin
                  if iPos > 0 then
                    iValue := Read_uint16(Data, iPos);
                  yArrayData[i]^.yMembers[j]^.iReference := iValue;
                  if iPos > 0 then
                    iValue := Read_uint32(Data, iPos);
                  yArrayData[i]^.yMembers[j]^.iData := iValue;
                end;
                2:
                begin
                  if iPos > 0 then
                    iValue := Read_uint16(Data, iPos);
                  yArrayData[i]^.yMembers[j]^.iData := iValue;
                end;
                0, 3..5, 12..15:
                begin
                  if iPos > 0 then
                    iValue := Read_uint32(Data, iPos);
                  yArrayData[i]^.yMembers[j]^.iData := iValue;
                end
                else
                  ShowMessage('Invalid type: ' + IntToStr(iValue) + ' data3: ' + IntToStr(i) + ' member: ' + IntToStr(j));
              end;
            end;
          end;
        end;
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      iCount := Length(yActives);
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Data 4'}{$IFEND}
      if (iPos > 0) and (iCount > 0) then
      begin
        SetLength(yActiveData, iCount);
        for i := 0 to iCount - 1 do
        begin
          New(yActiveData[i]);
          AnalyseActiveData(Data, iPos, yActiveData[i]^);
//          yActiveData[i]^.iID := yActives[i]^.iID;
//          if i = (iCount - 1) then
//          begin
//            SetLength(yPatern, 16);
//            ZeroMemory(@yPatern[0], Length(yPatern));
//          end
//          else
//          begin
//            SetLength(yPatern, SizeOf(yActives[i + 1]^.iID));
//            Move(yActives[i + 1]^.iID, yPatern[0], SizeOf(yActives[i + 1]^.iID));
////            SetLength(yPatern, SizeOf(yActives[i + 1]^.iID) + 2);
////            Move(yActives[i + 1]^.iID, yPatern[0], SizeOf(yActives[i + 1]^.iID));
////            yPatern[SizeOf(yActives[i + 1]^.iID)] := 3;
////            yPatern[SizeOf(yActives[i + 1]^.iID) + 1] := 1;
//          end;
//          iCount1 := SearchPatern(Data, iPos, yPatern);
//          if iCount1 > 0 then
//            iCount1 := iCount1 - iPos;
//          if iCount1 > 0 then
//            Read_data(Data, iPos, iCount1, yActiveData[i]^.yData);
        end;
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

      if iPos > 0 then
      begin
        {$IF Defined(USEREGION)}{$REGION 'Other Data'}{$IFEND}
        iCount := iPos;
        try
          if iPos > 0 then
            iFunctionMessageCount := Read_uint32(Data, iPos);
          SetLength(yFunctionMessages, iFunctionMessageCount);
          for i := 0 to iFunctionMessageCount - 1 do
          begin
            New(yFunctionMessages[i]);
            ZeroMemory(@yFunctionMessages[i]^, SizeOf(TFunctionMessage));
            with yFunctionMessages[i]^ do
            begin
              if iPos > 0 then
                unknown := Read_uint8(Data, iPos);
              if unknown <= 2 then
              begin
                if iPos > 0 then
                  iID := Read_uint32(Data, iPos);
                if iPos > 0 then
                  iFlag := Read_uint8(Data, iPos);
                if (iPos > 0) and (iFlag > 0) then
                  ReadMessageData(tMessageData);
              end;
            end;
          end;
          if iPos > 0 then
            iSuspendedStackCount1 := Read_uint32(Data, iPos);
          SetLength(ySuspendedStacks1, iSuspendedStackCount1);
          for i := 0 to iSuspendedStackCount1 - 1 do
          begin
            New(ySuspendedStacks1[i]);
            ZeroMemory(@ySuspendedStacks1[i]^, SizeOf(TSuspendedStack));
            with ySuspendedStacks1[i]^ do
            begin
              if iPos > 0 then
                iID := Read_uint32(Data, iPos);
              if iPos > 0 then
                iFlag := Read_uint8(Data, iPos);
              if (iPos > 0) and (iFlag > 0) then
                ReadMessageData(tMessageData);
            end;
          end;
          if iPos > 0 then
            iSuspendedStackCount2 := Read_uint32(Data, iPos);
          SetLength(ySuspendedStacks2, iSuspendedStackCount2);
          for i := 0 to iSuspendedStackCount2 - 1 do
          begin
            New(ySuspendedStacks2[i]);
            ZeroMemory(@ySuspendedStacks2[i]^, SizeOf(TSuspendedStack));
            with ySuspendedStacks2[i]^ do
            begin
              if iPos > 0 then
                iID := Read_uint32(Data, iPos);
              if iPos > 0 then
                iFlag := Read_uint8(Data, iPos);
              if (iPos > 0) and (iFlag > 0) then
                ReadMessageData(tMessageData);
            end;
          end;
          if iPos > 0 then
            iUnknown1 := Read_uint32(Data, iPos);
          if (iPos > 0) and (iUnknown1 > 0) then
            iUnknown2 := Read_uint32(Data, iPos);
          if iPos > 0 then
            iUnknownCount := Read_uint32(Data, iPos);
          SetLength(tUnknown, iUnknownCount);
          for i := 0 to iUnknownCount - 1 do
            if iPos > 0 then
              tUnknown[i] := Read_uint32(Data, iPos);
          if iPos > 0 then
            iQueuedUnbindCount := Read_uint32(Data, iPos);
          SetLength(yQueuedUnbinds, iQueuedUnbindCount);
          for i := 0 to iQueuedUnbindCount - 1 do
            with yQueuedUnbinds[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint32(Data, iPos);
            end;
          if iPos > 0 then
            saveFileVersion := Read_int16(Data, iPos);
        {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
 ///////////////////// RECOGNIZE WORK ////////////////////////////////////
try
        {$IF Defined(USEREGION)}{$REGION 'RECOGNIZE WORK'}{$IFEND}
          if iPos > 0 then
            iArrayCount1 := Read_uint32(Data, iPos);
          SetLength(yArray1, iArrayCount1);
          for i := 0 to iArrayCount1 - 1 do
            with yArray1[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint32(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount1a := Read_uint32(Data, iPos);
          if iArrayCount1a <> 0 then
             MessageBox(0, 'ArrayCount1a <> 0.'#13'Send this save to fubrus@yahoo.com', 'Error', MB_OK);
          if iPos > 0 then
            iArrayCount2 := Read_uint32(Data, iPos);
          SetLength(yArray2, iArrayCount2);
          for i := 0 to iArrayCount2 - 1 do
            with yArray2[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint32(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount3 := Read_uint32(Data, iPos);
          SetLength(yArray3, iArrayCount3);
          for i := 0 to iArrayCount3 - 1 do
            with yArray3[i] do
            begin
              if iPos > 0 then
                iType := Read_uint8(Data, iPos);
              if iPos > 0 then
                iStr1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iStr2 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iFlag := Read_uint16(Data, iPos);
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount4 := Read_uint32(Data, iPos);
          SetLength(yArray4, iArrayCount4);
          for i := 0 to iArrayCount4 - 1 do
            with yArray4[i] do
            begin
              if iPos > 0 then
                iStr1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint8(Data, iPos);
              if iPos > 0 then
                iStr2 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk3 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iFlag := Read_uint16(Data, iPos);
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
            end;
          if iPos > 0 then
            iScriptListCount := Read_uint32(Data, iPos);
          SetLength(yScriptList, iScriptListCount);
          for i := 0 to iScriptListCount - 1 do
            if iPos > 0 then
              yScriptList[i] := Read_w32string(Data, iPos);
          if iPos > 0 then
            iArrayCount4a := Read_uint32(Data, iPos);
          if iArrayCount4a <> 0 then
             MessageBox(0, 'ArrayCount4a <> 0'#13'Send this save to fubrus@yahoo.com', 'Error', MB_OK);
          if iPos > 0 then
            iArrayCount4b := Read_uint32(Data, iPos);
          if (DebugHook <> 0) and (iArrayCount4b > 0) then
            iArrayCount4b := iArrayCount4b;
          SetLength(yArray4b, iArrayCount4b);
          for i := 0 to iArrayCount4b - 1 do
            with yArray4b[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint8(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk3 := Read_uint16(Data, iPos);
              if iPos > 0 then
                tRef1 := Read_RefID(Data, iPos);
              if iPos > 0 then
                tRef2 := Read_RefID(Data, iPos);
              if iPos > 0 then
                tRef3 := Read_RefID(Data, iPos);
              if iPos > 0 then
                tRef4 := Read_RefID(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount4c := Read_uint32(Data, iPos);
          if (DebugHook <> 0) and (iArrayCount4c > 0) then
            iArrayCount4c := iArrayCount4c;
          SetLength(yArray4c, iArrayCount4c);
          for i := 0 to iArrayCount4c - 1 do
            with yArray4c[i] do
            begin
              if iPos > 0 then
                iFlag := Read_uint8(Data, iPos);
              if iPos > 0 then
                iUnk1 := Read_uint32(Data, iPos);
              if iPos > 0 then
                tRef1 := Read_RefID(Data, iPos);
              if (iPos > 0) and (iFlag = 0) then
                tRef2 := Read_RefID(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iUnk3 := Read_uint32(Data, iPos);
              if (iPos > 0) and (iFlag = 0) then
                iUnk4 := Read_uint16(Data, iPos);
              if (iPos > 0) and (iFlag = 0) then
                iUnk5 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk6 := Read_uint32(Data, iPos);
              if (iPos > 0) and (iFlag = 0) then
                iUnk7 := Read_uint32(Data, iPos);
              if (iPos > 0) and (iFlag = 0) then
                iUnk8 := Read_uint32(Data, iPos);
              if (iPos > 0) and (iFlag = 0) then
                iUnk9 := Read_uint16(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount4d := Read_uint32(Data, iPos);
          if iArrayCount4d <> 0 then
             MessageBox(0, 'ArrayCount4d <> 0'#13'Send this save to fubrus@yahoo.com', 'Error', MB_OK);
          if iPos > 0 then
            iArrayCount5 := Read_uint32(Data, iPos);
          SetLength(yArray5, iArrayCount5);
          for i := 0 to iArrayCount5 - 1 do
            with yArray5[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint16(Data, iPos);
              if iPos > 0 then
                tUnk3 := Read_RefID(Data, iPos);
              if iPos > 0 then
                tUnk4 := Read_RefID(Data, iPos);
              if iPos > 0 then
                tUnk5 := Read_RefID(Data, iPos);
              if iPos > 0 then
                iUnk6 := Read_uint16(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount6 := Read_uint32(Data, iPos);
          SetLength(yArray6, iArrayCount6);
          for i := 0 to iArrayCount6 - 1 do
            with yArray6[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iFlag := Read_uint16(Data, iPos);
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount7 := Read_uint32(Data, iPos);
          SetLength(yArray7, iArrayCount7);
          for i := 0 to iArrayCount7 - 1 do
            with yArray7[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iFlag := Read_uint16(Data, iPos);
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount8 := Read_uint32(Data, iPos);
          SetLength(yArray8, iArrayCount8);
          for i := 0 to iArrayCount8 - 1 do
            with yArray8[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iType := Read_uint16(Data, iPos);
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
              if iPos > 0 then
                iCount1 := Read_uint32(Data, iPos);
              if iPos > 0 then
                iCount2 := Read_uint32(Data, iPos);
              if (iCount1 <> 0) and (iCount2 <> 0) then
                MessageBox(0, 'Count1 <> 0 and Count2 <> 0'#13'Send this save to fubrus@yahoo.com', 'Error', MB_OK);
              SetLength(yRef, iCount1 + iCount2);
              for j := 0 to Length(yRef) - 1 do
                if iPos > 0 then
                  yRef[j] := Read_RefID(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount9 := Read_uint32(Data, iPos);
          SetLength(yArray9, iArrayCount9);
          for i := 0 to iArrayCount9 - 1 do
            if iPos > 0 then
                yArray9[i] := Read_uint32(Data, iPos);
          if iPos > 0 then
            iArrayCount10 := Read_uint32(Data, iPos);
          SetLength(yArray10, iArrayCount10);
          for i := 0 to iArrayCount10 - 1 do
            with yArray10[i] do
            begin
              if iPos > 0 then
                tArrayRef := Read_RefID(Data, iPos);
              if iPos > 0 then
                iArrayCount := Read_uint32(Data, iPos);
              SetLength(yArray, iArrayCount);
              for j := 0 to iArrayCount - 1 do
                with yArray[j] do
                begin
                  sName := Read_w32string(Data, iPos);
                  if iPos > 0 then
                    iCount1 := Read_uint32(Data, iPos);
                  SetLength(yData1, iCount1);
                  for k := 0 to iCount1 - 1 do
                    with yData1[k] do
                    begin
                      if iPos > 0 then
                        iCount := Read_uint32(Data, iPos);
                      SetLength(yData, iCount);
                      for l := 0 to iCount - 1 do
                        with yData[l] do
                        begin
                          if iPos > 0 then
                            iStr := Read_uint16(Data, iPos);
                          if iPos > 0 then
                            iFlag := Read_uint16(Data, iPos);
                        end;
                    end;
                  if iPos > 0 then
                    iCount2 := Read_uint32(Data, iPos);
                  SetLength(yData2, iCount2);
                  for k := 0 to iCount2 - 1 do
                    with yData2[k] do
                    begin
                      if iPos > 0 then
                        iUnk:= Read_uint16(Data, iPos);
                      if iPos > 0 then
                        iFlag := Read_uint16(Data, iPos);
                      if iPos > 0 then
                        tRef := Read_RefID(Data, iPos);
                    end;
                end;
            end;
          if iPos > 0 then
            iArrayCount11 := Read_uint32(Data, iPos);
          if (DebugHook <> 0) and (iArrayCount11 > 0) then
            iArrayCount11 := iArrayCount11;
          SetLength(yArray11, iArrayCount11);
          for i := 0 to iArrayCount11 - 1 do
            with yArray11[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint32(Data, iPos);
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint8(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount12 := Read_uint32(Data, iPos);
          if (DebugHook <> 0) and (iArrayCount12 > 0) then
            iArrayCount12 := iArrayCount12;
          SetLength(yArray12, iArrayCount12);
          for i := 0 to iArrayCount12 - 1 do
            with yArray12[i] do
            begin
              if iPos > 0 then
                iUnk1 := Read_uint8(Data, iPos);
              if iPos > 0 then
                iUnk2 := Read_uint16(Data, iPos);
              if iPos > 0 then
                iCount := Read_uint32(Data, iPos);
              SetLength(yData, iCount);
              for j := 0 to iCount - 1 do
                with yData[j] do
                begin
                  if iPos > 0 then
                    iUnk1 := Read_uint32(Data, iPos);
                  if iPos > 0 then
                    iUnk2 := Read_uint8(Data, iPos);
                  if iPos > 0 then
                    iStr := Read_uint16(Data, iPos);
                  if iPos > 0 then
                    iUnk3 := Read_uint16(Data, iPos);
                end;
            end;
          if iPos > 0 then
            iArrayCount13 := Read_uint32(Data, iPos);
          if (DebugHook <> 0) and (iArrayCount13 > 0) then
            iArrayCount13 := iArrayCount13;
          SetLength(yArray13, iArrayCount13);
          for i := 0 to iArrayCount13 - 1 do
            with yArray13[i] do
            begin
              if iPos > 0 then
                tRef := Read_RefID(Data, iPos);
              if iPos > 0 then
                iCount1 := Read_uint32(Data, iPos);
              SetLength(yData1, iCount1);
              for j := 0 to iCount1 - 1 do
                if iPos > 0 then
                  yData1[j] := Read_uint32(Data, iPos);
              if iPos > 0 then
                iCount2 := Read_uint32(Data, iPos);
              SetLength(yData2, iCount2);
              for j := 0 to iCount2 - 1 do
                if iPos > 0 then
                  yData2[j] := Read_uint32(Data, iPos);
              if iPos > 0 then
                iCount3 := Read_uint32(Data, iPos);
              SetLength(yData3, iCount3);
              for j := 0 to iCount3 - 1 do
                if iPos > 0 then
                  yData3[j] := Read_uint32(Data, iPos);
              if iPos > 0 then
                iUnk := Read_uint8(Data, iPos);
            end;
          if iPos > 0 then
            iArrayCount14 := Read_uint32(Data, iPos);
          if (DebugHook <> 0) and (iArrayCount14 > 0) then
            iArrayCount14 := iArrayCount14;
          SetLength(yArray14, iArrayCount14);
          for i := 0 to iArrayCount14 - 1 do
            if iPos > 0 then
              yArray14[i] := Read_uint32(Data, iPos);
          if iPos > 0 then
            iArrayCount15 := Read_uint32(Data, iPos);
          if iArrayCount15 <> 0 then
             MessageBox(0, 'ArrayCount15 <> 0'#13'Send this save to fubrus@yahoo.com', 'Error', MB_OK);
          if (iPos = 0) or (iPos < Length(Data)) then
            MessageBox(0, 'iPos is wrong'#13'Send this save to fubrus@yahoo.com', 'Error', MB_OK);
          {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
except
  if DebugHook <> 0 then
    MessageBox(0, 'Exception', 'Error', MB_OK);
end;
        finally
          iOther := Length(Data) - iPos;
          iPos := iCount;
        end;
      end;
      {$IF Defined(USEREGION)}{$REGION 'LoadPapyrusData Other'}{$IFEND}
      if iPos > 0 then
      begin
        iCount1 := Length(Data) - iPos;
        if iCount1 > 0 then
          Read_data(Data, iPos, iCount1, yOther);
      end;
      {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
      if LastPos <> nil then
        LastPos^ := iPos;
    end;
  finally
    SetLength(yPatern, 0);
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure SavePapyrusData(var Papyrus: tPapyrus; var Data: TBytes);
{$IF Defined(USEREGION)}{$REGION 'SavePapyrusData'}{$IFEND}
var
  iPos, i, j: Integer;
begin
  iPos := 0;
  SetLength(Data, 0);
  with Papyrus do
  begin
    Write_uint16(Data, 4, iPos);
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Strings'}{$IFEND}
    Write_uint32(Data, iStringCount, iPos);
    for i := 1 to iStringCount - 1 do
      Write_wstring(Data, StringTowstring(yStrings[i - 1]^.sName), iPos); {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    Write_uint32(Data, iScriptCount, iPos);
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Scripts'}{$IFEND}
    for i := 0 to iScriptCount - 1 do
    begin
      Write_uint16(Data, yScripts[i]^.iName, iPos);
      Write_uint16(Data, yScripts[i]^.iSType, iPos);
      Write_uint32(Data, yScripts[i]^.iParameterCount, iPos);
      for j := 0 to yScripts[i]^.iParameterCount - 1 do
      begin
        Write_uint16(Data, yScripts[i]^.yParameters[j]^.iName, iPos);
        Write_uint16(Data, yScripts[i]^.yParameters[j]^.iSType, iPos);
      end;
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    Write_uint32(Data, iInstanceCount, iPos);
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Table 1'}{$IFEND}
    for i := 0 to iInstanceCount - 1 do
    begin
      Write_uint32(Data, yInstances[i]^.iID, iPos);
      Write_uint16(Data, yInstances[i]^.iScript, iPos);
      Write_uint16(Data, yInstances[i]^.iUnknow1, iPos);
      Write_uint16(Data, yInstances[i]^.iUnknow2, iPos);
      Write_RefID(Data, yInstances[i]^.rRef, iPos);
      Write_uint8(Data, yInstances[i]^.iUsed, iPos);
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    Write_uint32(Data, iReferenceCount, iPos);
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Table 2'}{$IFEND}
    for i := 0 to iReferenceCount - 1 do
    begin
      Write_uint32(Data, yReferences[i]^.iID, iPos);
      Write_uint16(Data, yReferences[i]^.iSType, iPos);
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    Write_uint32(Data, iArrayCount, iPos);
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Table 3'}{$IFEND}
    for i := 0 to iArrayCount - 1 do
    begin
      Write_uint32(Data, yArrays[i]^.iID, iPos);
      Write_uint8(Data, yArrays[i]^.iType, iPos);
      if yArrays[i]^.iType in [1, 11] then
        Write_uint16(Data, yArrays[i]^.iReference, iPos);
      Write_uint32(Data, yArrays[i]^.iMemberCount, iPos);
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    Write_uint32(Data, iPapyrusRuntime, iPos);
    Write_uint32(Data, iActiveCount, iPos);
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Table 4'}{$IFEND}
    for i := 0 to iActiveCount - 1 do
    begin
      Write_uint32(Data, yActives[i]^.iID, iPos);
      Write_uint8(Data, yActives[i]^.iUsed, iPos);
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Data 1'}{$IFEND}
    for i := 0 to iInstanceCount - 1 do
    begin
      Write_uint32(Data, yInstanceData[i]^.iID, iPos);
      if yInstanceData[i]^.iData2 <> 0 then
        Write_uint8(Data, $F, iPos)
      else
        Write_uint8(Data, $B, iPos);
      Write_uint16(Data, yInstanceData[i]^.iReference, iPos);
      Write_uint32(Data, yInstanceData[i]^.iData1, iPos);
      if yInstanceData[i]^.iData2 <> 0 then
        Write_uint32(Data, yInstanceData[i]^.iData2, iPos);
      Write_uint32(Data, yInstanceData[i]^.iMemberCount, iPos);
      for j := 0 to yInstanceData[i]^.iMemberCount - 1 do
      begin
        Write_uint8(Data, yInstanceData[i]^.yMembers[j]^.iType, iPos);
        case yInstanceData[i]^.yMembers[j]^.iType of
          1, 11:
          begin
            Write_uint16(Data, yInstanceData[i]^.yMembers[j]^.iReference, iPos);
            Write_uint32(Data, yInstanceData[i]^.yMembers[j]^.iData, iPos);
          end;
          2: Write_uint16(Data, yInstanceData[i]^.yMembers[j]^.iData, iPos);
          0, 3..5, 12..15: Write_uint32(Data, yInstanceData[i]^.yMembers[j]^.iData, iPos);
        end;
      end;
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Data 2'}{$IFEND}
    for i := 0 to iReferenceCount - 1 do
    begin
      Write_uint32(Data, yReferenceData[i]^.iID, iPos);
      if yReferenceData[i]^.iData2 <> 0 then
        Write_uint8(Data, $F, iPos)
      else
        Write_uint8(Data, $B, iPos);
      Write_uint16(Data, yReferenceData[i]^.iReference, iPos);
      Write_uint32(Data, yReferenceData[i]^.iData1, iPos);
      if yReferenceData[i]^.iData2 <> 0 then
        Write_uint32(Data, yReferenceData[i]^.iData2, iPos);
      Write_uint32(Data, yReferenceData[i]^.iMemberCount, iPos);
      for j := 0 to yReferenceData[i]^.iMemberCount - 1 do
      begin
        Write_uint8(Data, yReferenceData[i]^.yMembers[j]^.iType, iPos);
        case yReferenceData[i]^.yMembers[j]^.iType of
          1, 11:
          begin
            Write_uint16(Data, yReferenceData[i]^.yMembers[j]^.iReference, iPos);
            Write_uint32(Data, yReferenceData[i]^.yMembers[j]^.iData, iPos);
          end;
          2: Write_uint16(Data, yReferenceData[i]^.yMembers[j]^.iData, iPos);
          0, 3..5, 12..15: Write_uint32(Data, yReferenceData[i]^.yMembers[j]^.iData, iPos);
        end;
      end;
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Data 3'}{$IFEND}
    for i := 0 to iArrayCount - 1 do
    begin
      Write_uint32(Data, yArrayData[i]^.iID, iPos);
      for j := 0 to yArrays[i]^.iMemberCount - 1 do
      begin
        Write_uint8(Data, yArrayData[i]^.yMembers[j]^.iType, iPos);
        case yArrayData[i]^.yMembers[j]^.iType of
          1, 11:
          begin
            Write_uint16(Data, yArrayData[i]^.yMembers[j]^.iReference, iPos);
            Write_uint32(Data, yArrayData[i]^.yMembers[j]^.iData, iPos);
          end;
          2: Write_uint16(Data, yArrayData[i]^.yMembers[j]^.iData, iPos);
          0, 3..5, 12..15: Write_uint32(Data, yArrayData[i]^.yMembers[j]^.iData, iPos);
        end;
      end;
    end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Data 4'}{$IFEND}
    for i := 0 to iActiveCount - 1 do
      Write_data(Data, iPos, yActiveData[i]^.yData); {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'SavePapyrusData Other'}{$IFEND}
    Write_data(Data, iPos, yOther);
    {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.tsGD32Show(Sender: TObject);
{$IF Defined(USEREGION)}{$REGION 'tsGD32Show'}{$IFEND}
var
  MyData: PMyRec;
  iPos: integer;
begin
  if BufNode <> nil then
  begin
    MyData := vtStructure.GetNodeData(BufNode);
    if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
    begin
      LoadPapyrusData(Papyrus, TBytes(MyData^._Pointer^), @iPos);
      Papyrus.pPapyrus := BufNode^.Parent;
      FillTreePapyrus;
      btnPapyrusDelete.Visible := False;
      btnPapyrusAnalysis.Visible := False;
      pnPath.Caption := '';
      if (MyData^._Size <> iPos) and (iPos > 0) then
        MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
    end;
    BufNode := nil;
  end;
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
      if (MyData^._Size <> iPos) and (iPos > 0) then
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
      uHelper.TEdit(edIntDec).Alignment := taRightJustify;
      uHelper.TEdit(edIntHex).Alignment := taRightJustify;
      uHelper.TEdit(edIntBin).Alignment := taRightJustify;
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
      uHelper.TEdit(edRODec).Alignment := taRightJustify;
      uHelper.TEdit(edROHex).Alignment := taRightJustify;
      uHelper.TEdit(edROBin).Alignment := taRightJustify;
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
    pnStructure.Visible := True;
    FormResize(Self);
    vtStructureChange(vtStructure, vtStructure.GetFirst(False));
    btnFirstACHR.Visible := True;
    btnFirstNPC.Visible := True;
    btnCompare.Left := btnFirstNPC.Left + btnFirstNPC.Width + 4;
  end
  else
  begin
    FreeESSFile(ESSFile);
    vtStructure.Visible := False;
    spSplit.Visible := False;
    pnStructure.Visible := False;
    pnStatus.Visible := False;
    pcEditors.Visible := False;
    btnSave.Visible := False;
    btnFirstACHR.Visible := False;
    btnFirstNPC.Visible := False;
    btnCompare.Left := btnOpen.Left + btnOpen.Width + 4;
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
                if (Node^.Parent <> nil) and (Node^.Parent = Sender.GetFirst(False)) and (Node^.Index = 10) then
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
                  8:
                  begin
                    pcEditors.Tag := 0;
                    case Node^.Index of
                      0: pcEditors.ActivePage := tsGD01;
                      1: pcEditors.ActivePage := tsGD02;
                      2, 4..8: begin
                        pcEditors.ActivePage := tsGD0X;
                        pcEditors.Tag := Node^.Index;
                      end;
                      3: pcEditors.ActivePage := tsGD04;
                      else
                        bShow := False;
                    end;
                    if bShow then
                    begin
                      Expanded[Node] := True;
                      BufNode := GetChild(Node, 2);
                    end;
                  end;
                  9:
                  begin
                    pcEditors.Tag := 0;
                    case Node^.Index of
                      0, 2..5, 8, 11: begin
                        pcEditors.ActivePage := tsGD0X;
                        pcEditors.Tag := Node^.Index + 100;
                      end;
                      else
                        bShow := False;
                    end;
                    if bShow then
                    begin
                      Expanded[Node] := True;
                      BufNode := GetChild(Node, 2);
                    end;
                  end;
                  11:
                  begin
                    case Node^.Index of
                      1: pcEditors.ActivePage := tsGD32;
                      2: begin
                        pcEditors.ActivePage := tsGD0X;
                        pcEditors.Tag := Node^.Index + 1000;
                      end;
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
                    ESSFile.changeForms[BufNode^.Parent^.Index]^.length1 := _Size;
                    ESSFile.changeForms[BufNode^.Parent^.Index]^.length2 := _Decompressed;
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
                      8: ESSFile.globalDataTable1[BufNode^.Parent^.Index]^._length := _Size;
                      9: ESSFile.globalDataTable2[BufNode^.Parent^.Index]^._length := _Size;
                      11: ESSFile.globalDataTable3[BufNode^.Parent^.Index]^._length := _Size;
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
        begin
          if lvForms.Items.Count > 0 then
          begin
            lvForms.Items.Count := 0;
            SetLength(FormViews, 0);
          end;
          if Papyrus.bSave then
          begin
            MyData := GetNodeData(GetChild(Papyrus.pPapyrus, 2));
            if Assigned(MyData) then
            begin
              SavePapyrusData(Papyrus, TBytes(MyData^._Pointer^));
              MyData^._Size := Length(TBytes(MyData^._Pointer^));
              case Papyrus.pPapyrus^.Parent^.Index of
                8: ESSFile.globalDataTable1[Papyrus.pPapyrus^.Index]^._length := MyData^._Size;
                9: ESSFile.globalDataTable2[Papyrus.pPapyrus^.Index]^._length := MyData^._Size;
                11: ESSFile.globalDataTable3[Papyrus.pPapyrus^.Index]^._length := MyData^._Size;
              end;
              SetNodeText(vtStructure, GetChild(Papyrus.pPapyrus, 1));
            end;
          end;
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
    if pcEditors.ActivePageIndex = tsGD0X.PageIndex then
      case pcEditors.Tag of
        2: tsTESShow(Handle, vtTMP, vtStructure, BufNode);
        4: tsCreatedObjectsShow(Handle, vtTMP, vtStructure, BufNode);
        5: tsEffectsShow(Handle, vtTMP, vtStructure, BufNode);
        6: tsWeatherShow(Handle, vtTMP, vtStructure, BufNode);
        7: tsAudioShow(Handle, vtTMP, vtStructure, BufNode);
        8: tsSkyCellsShow(Handle, vtTMP, vtStructure, BufNode);
        100: tsProcessListsShow(Handle, vtTMP, vtStructure, BufNode);
        102: tsInterfaceShow(Handle, vtTMP, vtStructure, BufNode);
        103: tsActorCausesShow(Handle, vtTMP, vtStructure, BufNode);
        104: tsDetectionManagerShow(Handle, vtTMP, vtStructure, BufNode);
        105: tsLocationMetaDataShow(Handle, vtTMP, vtStructure, BufNode);
        108: tsMagicFavoritesShow(Handle, vtTMP, vtStructure, BufNode);
        111: tsIngredientSharedShow(Handle, vtTMP, vtStructure, BufNode);
        1002: tsAnimObjectsShow(Handle, vtTMP, vtStructure, BufNode);
      end;
    if pcEditors.ActivePageIndex = tsGD04.PageIndex then
      tsGD04Show(Self);
    if pcEditors.ActivePageIndex = tsGD32.PageIndex then
      tsGD32Show(Self);
  end;
  pcEditors.Visible := bShow;
  with Sender do
  begin
    bShow := False;
    if GetFirstSelected <> nil then
      case GetNodeLevel(GetFirstSelected) of
        2: bShow := GetFirstSelected^.Parent^.Index in [10, 13, 15];
        3: bShow := GetFirstSelected^.Parent^.Parent^.Index in [6, 17];
      end;
    btnDelete.Visible := bShow;
    bShow := False;
    if GetFirstSelected <> nil then
      case GetNodeLevel(GetFirstSelected) of
        1: bShow := GetFirstSelected^.Index in [10, 13, 15];
        2: bShow := GetFirstSelected^.Parent^.Index in [6, 17];
      end;
    if bShow then
      if btnDelete.Visible then
        btnAdd.Left := btnDelete.Left + btnDelete.Width + 4
      else
        btnAdd.Left := btnDelete.Left;
    btnAdd.Visible := bShow;
  end;
end;

procedure TfMain.vtPapyrusChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  bShow, bAnalysis: Boolean;
  iAddress: integer;
  pNode: PVirtualNode;
begin
  with Sender do
  begin
    bShow := False;
    bAnalysis := False;
    iAddress := 0;
    pNode := GetFirstSelected;
    if pNode <> nil then
    begin
      case GetNodeLevel(pNode) of
        1: begin
          bAnalysis := pNode^.Index = 11;
          iAddress := Integer(pNode);
        end;
        2: begin
          bShow := pNode^.Parent^.Index in [1..4, 6..10];
          iAddress := Integer(pNode);
        end;
        3: begin
          bShow := pNode^.Parent^.Parent^.Index in [1..4, 6..10];
          bAnalysis := pNode^.Parent^.Parent^.Index = 10;
          iAddress := Integer(pNode^.Parent);
        end;
        4: begin
          bShow := pNode^.Parent^.Parent^.Parent^.Index in [1, 7..10];
          iAddress := Integer(pNode^.Parent^.Parent);
        end;
        5: begin
          bShow := pNode^.Parent^.Parent^.Parent^.Parent^.Index in [7..9];
          iAddress := Integer(pNode^.Parent^.Parent^.Parent);
        end;
      end;
      btnPapyrusDelete.Visible := bShow;
      btnPapyrusDelete.Tag := iAddress;
      btnPapyrusAnalysis.Visible := bAnalysis;
      btnPapyrusAnalysis.Tag := iAddress;
      pnPath.Caption := '  ' + GetFullPath(pNode, Sender);
    end;
  end;
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
            15: ChildCount[pLvl1] := Length(visitedWorldspaceArray); //uint32
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
        0: if (Node^.Index < 1) and (sFileName <> '') then
             _Caption := ExtractFileName(sFileName);
        1: GetCaptionLevel1(ESSFile, Node^.Index, MyData, Node);
        2: GetCaptionLevel2(ESSFile, Node^.Parent^.Index, Node^.Index, MyData, Node);
        3: GetCaptionLevel3(ESSFile, Node^.Parent^.Parent^.Index, Node^.Parent^.Index, Node^.Index, MyData, Node);
      end;
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Tree view interface Papyrus'}{$IFEND}
procedure TfMain.FillTreePapyrus;
begin
  uViewer.FillTree(vtPapyrus, Papyrus);
end;

procedure TfMain.vtPapyrusGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
var
  PapyrusRec: PPapyrusRec;
begin
  PapyrusRec := Sender.GetNodeData(Node);
  Text := PapyrusRec^._Caption;
end;

procedure TfMain.vtPapyrusFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  PapyrusRec: PPapyrusRec;
begin
  PapyrusRec := Sender.GetNodeData(Node);
  Finalize(PapyrusRec^);
end;

procedure TfMain.vtPapyrusInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  InitNode(Sender, Node, Papyrus);
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfMain.vtTMPInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  case pcEditors.Tag of
    2: vtTESInitNode(Sender, ParentNode, Node, InitialStates);
    4: vtCreatedObjectsInitNode(Sender, ParentNode, Node, InitialStates);
    5: vtEffectsInitNode(Sender, ParentNode, Node, InitialStates);
    6: vtWeatherInitNode(Sender, ParentNode, Node, InitialStates);
    7: vtAudioInitNode(Sender, ParentNode, Node, InitialStates);
    8: vtSkyCellsInitNode(Sender, ParentNode, Node, InitialStates);
    100: vtProcessListsInitNode(Sender, ParentNode, Node, InitialStates);
    102: vtInterfaceInitNode(Sender, ParentNode, Node, InitialStates);
    103: vtActorCausesInitNode(Sender, ParentNode, Node, InitialStates);
    104: vtDetectionManagerInitNode(Sender, ParentNode, Node, InitialStates);
    105: vtLocationMetaDataInitNode(Sender, ParentNode, Node, InitialStates);
    108: vtMagicFavoritesInitNode(Sender, ParentNode, Node, InitialStates);
    111: vtIngredientSharedInitNode(Sender, ParentNode, Node, InitialStates);
    1002: vtAnimObjectsInitNode(Sender, ParentNode, Node, InitialStates);
  end;
end;

procedure TfMain.vtStructureSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; Text: string);
var
  Start: PVirtualNode;
  MyData: PMyRec;
begin
  Start := Node;
  Text := AnsiUpperCase('*' + Text + '*');
  stNotFound.Visible := False;
  stNotFound.Tag := 0;
  repeat
    Node := GetNextNode(Node, Sender.RootNode);
    if not (vsInitialized in Node^.States) then
      Sender.ReinitNode(Node, False);
    MyData := Sender.GetNodeData(Node);
    if Assigned(MyData) and MatchStrings(PChar(AnsiUpperCase(String(MyData^._Caption))), PChar(Text)) then
    begin
      Start := Node;
      while Start <> Sender.RootNode do
      begin
        Start := Start.Parent;
        Sender.Expanded[Start] := True;
      end;
      Sender.Selected[Node] := True;
      Sender.FocusedNode := Node;
      Sender.VisiblePath[Node] := True;
      stNotFound.Tag := 1;
      Break;
    end;
  until Node = Start;
  if stNotFound.Tag = 0 then
  begin
    stNotFound.Visible := True;
    PlaySound('APPGPFAULT', 0, SND_ASYNC);
  end;
end;

procedure TfMain.btnSearchClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  if Trim(edSearch.Text) <> '' then
  begin
    if vtStructure.GetFirstSelected <> nil then
      Node := vtStructure.GetFirstSelected
    else
      Node := vtStructure.RootNode;
    try
      Screen.Cursor := crHourGlass;
      vtStructureSearch(vtStructure, Node, edSearch.Text);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfMain.btnPapyrusSearchClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  if Trim(edPapyrusSearch.Text) <> '' then
  begin
    if vtPapyrus.GetFirstSelected <> nil then
      Node := vtPapyrus.GetFirstSelected
    else
      Node := vtPapyrus.RootNode;
    try
      Screen.Cursor := crHourGlass;
      vtSearch(vtPapyrus, Node, edPapyrusSearch.Text, stPapyrusNotFound);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfMain.DeleteSelectedObject;
var
  iIndex: integer;
  Node: PVirtualNode;
  bDeleted: Boolean;
begin
  with vtStructure, ESSFile do
    if GetFirstSelected <> nil then
    try
      Screen.Cursor := crHourGlass;
      Node := GetFirstSelected;
      iIndex := Node^.Index;
      bDeleted := False;
      if ((GetNodeLevel(Node) = 2) and (Node^.Parent^.Index in [10, 13, 15])) or
        ((GetNodeLevel(Node) = 3) and (Node^.Parent^.Parent^.Index in [6, 17])) then
      begin
        Selected[GetSelection(Node)] := True;
        FocusedNode := GetSelection(Node);
      end;
      case GetNodeLevel(Node) of
        2:
          case Node^.Parent^.Index of
            10: if iIndex < Length(changeForms) then
            begin
              Dec(fileLocationTable.changeFormCount);
              SetLength(changeForms[iIndex]^.data^, 0);
              Dispose(changeForms[iIndex]^.data);
              Dispose(changeForms[iIndex]);
              if iIndex < (Length(changeForms) - 1) then
                Move(changeForms[iIndex + 1], changeForms[iIndex], SizeOf(changeForms[iIndex]) * (Length(changeForms) - iIndex - 1));
              SetLength(changeForms, Length(changeForms) - 1);
              bDeleted := True;
            end;
            13: if iIndex < Length(formIDArray) then
            begin
              Dec(formIDArrayCount);
              Dispose(formIDArray[iIndex]);
              if iIndex < (Length(formIDArray) - 1) then
                Move(formIDArray[iIndex + 1], formIDArray[iIndex], SizeOf(formIDArray[iIndex]) * (Length(formIDArray) - iIndex - 1));
              SetLength(formIDArray, Length(formIDArray) - 1);
              bDeleted := True;
            end;
            15: if iIndex < Length(visitedWorldspaceArray) then
            begin
              Dec(visitedWorldspaceArrayCount);
              if iIndex < (Length(visitedWorldspaceArray) - 1) then
                Move(visitedWorldspaceArray[iIndex + 1], visitedWorldspaceArray[iIndex], SizeOf(visitedWorldspaceArray[iIndex]) * (Length(visitedWorldspaceArray) - iIndex - 1));
              SetLength(visitedWorldspaceArray, Length(visitedWorldspaceArray) - 1);
              bDeleted := True;
            end;
          end;
        3:
          case Node^.Parent^.Parent^.Index of
            6: if iIndex < Length(pluginInfo.plugins) then
            begin
              Dec(pluginInfo.pluginCount);
              pluginInfo.plugins[iIndex]^ := StringTowstring('');
              Dispose(pluginInfo.plugins[iIndex]);
              if iIndex < (Length(pluginInfo.plugins) - 1) then
                Move(pluginInfo.plugins[iIndex + 1], pluginInfo.plugins[iIndex], SizeOf(pluginInfo.plugins[iIndex]) * (Length(pluginInfo.plugins) - iIndex - 1));
              SetLength(pluginInfo.plugins, Length(pluginInfo.plugins) - 1);
              pluginInfoSize := SizeOf(pluginInfo.pluginCount);
              for iIndex := 0 to pluginInfo.pluginCount - 1 do
                pluginInfoSize := pluginInfoSize + SizeOf(pluginInfo.plugins[iIndex]^.w) + pluginInfo.plugins[iIndex]^.w;
              bDeleted := True;
            end;
            17: if iIndex < Length(Unknown3Table.unknown) then
            begin
              Dec(Unknown3Table.Count);
              Unknown3Table.unknown[iIndex]^ := StringTowstring('');
              Dispose(Unknown3Table.unknown[iIndex]);
              if iIndex < (Length(Unknown3Table.unknown) - 1) then
                Move(Unknown3Table.unknown[iIndex + 1], Unknown3Table.unknown[iIndex], SizeOf(Unknown3Table.unknown[iIndex]) * (Length(Unknown3Table.unknown) - iIndex - 1));
              SetLength(Unknown3Table.unknown, Length(Unknown3Table.unknown) - 1);
              unknown3TableSize := SizeOf(Unknown3Table.Count);
              for iIndex := 0 to Unknown3Table.count - 1 do
                unknown3TableSize := unknown3TableSize + SizeOf(Unknown3Table.unknown[iIndex]^.w) + Unknown3Table.unknown[iIndex]^.w;
              bDeleted := True;
            end;
          end;
      end;
      if bDeleted then
      begin
        iIndex := Integer(Node^.NextSibling);
        DeleteNode(Node, True);
        Node := Pointer(iIndex);
        if Node <> nil then
          repeat
            ReinitNode(Node, False);
            Node := Node^.NextSibling;
          until Node = nil;
        Repaint;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
end;

procedure QSort(var Sort: array of integer; Low, Hi: integer);
var
  cmp, tmp, iLow, iHi : integer;
begin
  if Low > Hi then
    Exit;
  iLow := Low;
  iHi := Hi;
  cmp := Sort[(Low + Hi) div 2];
  repeat
    while Sort[iLow] < cmp do
      inc(iLow);
    while cmp < Sort[iHi] do
      dec(iHi);
    if iLow <= iHi then
    begin
      tmp := Sort[iLow];
      Sort[iLow] := Sort[iHi];
      Sort[iHi] := tmp;
      inc(iLow);
      dec(iHi)
    end;
  until iLow > iHi;
  if Low < iHi then
    QSort(Sort, Low, iHi);
  if iLow < Hi then
    QSort(Sort, iLow, Hi)
end;

procedure TfMain.DeleteSelectedForms;
var
  yItems: array of integer;
  i: integer;
  Node: PVirtualNode;
begin
  with ESSFile do
  try
    Screen.Cursor := crHourGlass;
    for i := 0 to lvForms.Items.Count - 1 do
      with lvForms.Items[i] do
        if Selected then
        begin
          SetLength(yItems, Length(yItems) + 1);
          yItems[Length(yItems) - 1] := Integer(Data);
        end;
    if Length(yItems) > 0 then
      with lvForms, vtStructure do
      begin
        QSort(yItems, 0, Length(yItems) - 1);
        Node := nil;
        while Length(yItems) > 0 do
        begin
          Node := GetChild(GetChild(GetFirst(False), 10), yItems[Length(yItems) - 1] - 1);
          if Node <> nil then
            with Node^ do
            begin
              Dec(fileLocationTable.changeFormCount);
              SetLength(changeForms[Index]^.data^, 0);
              Dispose(changeForms[Index]^.data);
              Dispose(changeForms[Index]);
              if Index < Cardinal(Length(changeForms) - 1) then
                Move(changeForms[Index + 1], changeForms[Index], SizeOf(changeForms[Index]) * (Length(changeForms) - Integer(Index) - 1));
              SetLength(changeForms, Length(changeForms) - 1);
              if Length(yItems) = 1 then
              begin
                i := Integer(Node^.NextSibling);
                DeleteNode(Node, True);
                Node := Pointer(i);
              end
              else
                DeleteNode(Node, False);
            end;
          SetLength(yItems, Length(yItems) - 1);
        end;
        if Node <> nil then
          repeat
            ReinitNode(Node, False);
            Node := Node^.NextSibling;
          until Node = nil;
        Repaint;
        if lvForms.Selected <> nil then
          i := lvForms.Selected.Index
        else
          i := -1;
        tsFormsShow(nil);
        if (i <> -1) and (i < lvForms.Items.Count) then
          lvForms.Selected := lvForms.Items[i];
      end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfMain.btnAddClick(Sender: TObject);
begin
  AddObject;
end;

procedure TfMain.AddObject;
var
  Node: PVirtualNode;
  bExists: Boolean;
  sValue: string;
  i, iValue: integer;
  cfForm: PChangeForm;
  fsForm: PFormIDArray;
begin
  with vtStructure, ESSFile do
    if GetFirstSelected <> nil then
    try
      Screen.Cursor := crHourGlass;
      Node := GetFirstSelected;
      case GetNodeLevel(Node) of
        1:
          case Node^.Index of
            10: with TfAddForm.Create(Application) do
            try
              New(cfForm);
              ZeroMemory(@cfForm^, SizeOf(cfForm^));
              bExists := True;
              if AddChangeForm(cfForm^, @ESSFile) then
              begin
                bExists := False;
                for i := 0 to Length(changeForms) - 1 do
                  if RefIDCompare(cfForm^.formID, changeForms[i]^.formID) = 0 then
                  begin
                    bExists := True;
                    Break;
                  end;
                if not bExists then
                begin
                  Inc(fileLocationTable.changeFormCount);
                  SetLength(changeForms, Length(changeForms) + 1);
                  changeForms[Length(changeForms) - 1] := cfForm;
                  AddChild(Node);
                  ChildCount[Node^.LastChild] := 7;
                  ReinitNode(Node^.LastChild, True);
                end
                else
                  MessageBox(Handle, PChar(RefIDToString(cfForm^.formID) + ' already exists in Change Forms'), 'Warning', MB_OK or MB_ICONWARNING)
              end;
              if bExists then
              begin
                if Assigned(cfForm^.data) then
                  Dispose(cfForm^.data);
                Dispose(cfForm);
              end;
            finally
              Release;
            end;
            13: with TfAddFormIDArray.Create(Application) do
            try
              New(fsForm);
              ZeroMemory(@fsForm^, SizeOf(fsForm^));
              bExists := True;
              if AddFormIDArray(fsForm^, @ESSFile) then
              begin
                bExists := False;
                for i := 0 to Length(formIDArray) - 1 do
                  if RefIDCompare(fsForm^.ID, formIDArray[i]^.ID) = 0 then
                  begin
                    bExists := True;
                    Break;
                  end;
                if not bExists then
                begin
                  Inc(formIDArrayCount);
                  SetLength(formIDArray, Length(formIDArray) + 1);
                  formIDArray[Length(formIDArray) - 1] := fsForm;
                  AddChild(Node);
                  ChildCount[Node^.LastChild] := 2;
                  ReinitNode(Node^.LastChild, True);
                end
                else
                  MessageBox(Handle, PChar(RefIDToString(fsForm^.ID) + ' already exists in FormID Array'), 'Warning', MB_OK or MB_ICONWARNING)
              end;
              if bExists then
                Dispose(fsForm);
            finally
              Release;
            end;
            15: if InputQuery('Add visited worldspace to array in ESS structure', 'Type visited worldspace', sValue) and (Trim(sValue) <> '')  then
              if not TryStrToInt(Trim(sValue), iValue) then
                MessageBox(Handle, PChar(Trim(sValue) + ' isn''t integer value'), 'Convert error', MB_OK or MB_ICONERROR)
              else
              begin
                bExists := False;
                for i := 0 to Length(visitedWorldspaceArray) - 1 do
                  if Cardinal(iValue) = visitedWorldspaceArray[i] then
                  begin
                    bExists := True;
                    Break;
                  end;
                if not bExists then
                begin
                  Inc(visitedWorldspaceArrayCount);
                  SetLength(visitedWorldspaceArray, Length(visitedWorldspaceArray) + 1);
                  visitedWorldspaceArray[Length(visitedWorldspaceArray) - 1] := iValue;
                  AddChild(Node);
                  ReinitNode(Node^.LastChild, False);
                end
                else
                  MessageBox(Handle, PChar(Trim(sValue) + ' already exists in visited worldspace array'), 'Warning', MB_OK or MB_ICONWARNING)
              end;
          end;
        2:
          case Node^.Parent^.Index of
            6: if InputQuery('Add plugin to ESS structure', 'Type plugin name', sValue) and (Trim(sValue) <> '') then
            begin
              bExists := False;
              sValue := Trim(sValue);
              for i := 0 to Length(pluginInfo.plugins) - 1 do
                if sValue = wstringToString(pluginInfo.plugins[i]^) then
                begin
                  bExists := True;
                  Break;
                end;
              if not bExists then
              begin
                Inc(pluginInfo.pluginCount);
                SetLength(pluginInfo.plugins, Length(pluginInfo.plugins) + 1);
                New(pluginInfo.plugins[Length(pluginInfo.plugins) - 1]);
                pluginInfo.plugins[Length(pluginInfo.plugins) - 1]^ := StringTowstring(sValue);
                pluginInfoSize := SizeOf(pluginInfo.pluginCount);
                for i := 0 to pluginInfo.pluginCount - 1 do
                  pluginInfoSize := pluginInfoSize + SizeOf(pluginInfo.plugins[i]^.w) + pluginInfo.plugins[i]^.w;
                AddChild(Node);
                ReinitNode(Node^.LastChild, False);
              end
              else
                MessageBox(Handle, PChar(sValue + ' already exists on plugins list'), 'Warning', MB_OK or MB_ICONWARNING)
            end;
            17: if InputQuery('Add unknown to ESS structure', 'Type unknown name', sValue) and (Trim(sValue) <> '')  then
            begin
              bExists := False;
              sValue := Trim(sValue);
              for i := 0 to Length(Unknown3Table.unknown) - 1 do
                if sValue = wstringToString(Unknown3Table.unknown[i]^) then
                begin
                  bExists := True;
                  Break;
                end;
              if not bExists then
              begin
                Inc(Unknown3Table.Count);
                SetLength(Unknown3Table.unknown, Length(Unknown3Table.unknown) + 1);
                New(Unknown3Table.unknown[Length(Unknown3Table.unknown) - 1]);
                Unknown3Table.unknown[Length(Unknown3Table.unknown) - 1]^ := StringTowstring(sValue);
                unknown3TableSize := SizeOf(Unknown3Table.Count);
                for i := 0 to Unknown3Table.count - 1 do
                  unknown3TableSize := unknown3TableSize + SizeOf(Unknown3Table.unknown[i]^.w) + Unknown3Table.unknown[i]^.w;
                AddChild(Node);
                ReinitNode(Node^.LastChild, False);
              end
              else
                MessageBox(Handle, PChar(sValue + ' already exists in Unknown3Table'), 'Warning', MB_OK or MB_ICONWARNING)
            end;
          end;
      end;
      Repaint;
    finally
      Screen.Cursor := crDefault;
    end;
end;

end.
