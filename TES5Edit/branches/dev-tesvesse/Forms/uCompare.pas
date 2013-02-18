unit uCompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uESSFile, ExtCtrls, StdCtrls, ComCtrls, Helper, GlassButton,
  VistaProgressBar, CommCtrl;

type
  TDiffType = (dtGlobal, dtForm);
  TDiffState = (dsOnly1st, dsOnly2nd, dsSize, dsContent);
  TDiff = record
    No: integer;
    DiffType: TDiffType;
    DiffState: TDiffState;
    Size1, Size2: uint32;
    globaID: uint32;
    formID: TRefID;
    Flags1, Flags2: uint32;
    Type1, Type2: uint8;
    Version1, Version2: uint8;
    Data1, Data2: PBytes;
  end;
  TDiffs = array of TDiff;

  TfCompare = class(TForm)
    pnMenu: TPanel;
    sdCSVSave: TSaveDialog;
    lvDiffs: TListView;
    mmDiff: TMemo;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormCreate(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnBreakClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure lvDiffsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvDiffsData(Sender: TObject; Item: TListItem);
    procedure lvDiffsColumnClick(Sender: TObject; Col: TListColumn);
    procedure lvDiffsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
  private
    Diffs: TDiffs;
    bBreak: Boolean;
    btnExport, btnBreak: TGlassButton;
    pbProcess: TVistaProgressBar;
    procedure CompareData(Data1, Data2: PBytes);
    function IsTheSameData(Data1, Data2: PBytes): Boolean;
    procedure CheckGlobal(var Table1, Table2: array of TGlobalData);
  public
    File1, File2: TESSFile;
    procedure Compare(sFile1, sFile2: string);
  end;

implementation

uses
  uMain, Math;

{$R *.dfm}

procedure TfCompare.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TfCompare.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  bBreak := True;
end;

procedure TfCompare.FormCreate(Sender: TObject);
begin
  btnExport := CreateButton('Export', False, clBlack, 2, 2, 25, 75, 1, 0, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnExportClick , nil);
  btnBreak := CreateButton('Break', True, clBlack, pnMenu.ClientWidth - 77, 2, 25, 75, 8, 1, [akRight, akTop], Self, pnMenu, fMain.imImages, btnBreakClick , nil);
  pbProcess := TVistaProgressBar.Create(Self);
  with pbProcess do
  begin
    Parent := Self;
    Align := alBottom;
    Height := 16;
    Position := 0;
  end;
  if not IsVista and (Tag = 0) then
  begin
    SetListHeadColor(lvDiffs.Handle, lvGD04Proc, Longint(@lvGD04NewProc));
    Tag := 1;
  end;
  lvDiffs.Clear;
  lvDiffs.Tag := 0;
  lvDiffs.Columns[0].Width := 75;
end;

procedure TfCompare.FormDestroy(Sender: TObject);
begin
  SetLength(Diffs, 0);
  FreeESSFile(File2);
  FreeESSFile(File1);
end;

procedure TfCompare.btnExportClick(Sender: TObject);
var
  sList: TStringList;
  i: integer;
  sLine: string;
begin
  if sdCSVSave.Execute then
  begin
    sList := TStringList.Create;
    try
      for i := 0 to Length(Diffs) - 1 do
        with Diffs[i] do
        begin
          sLine := IntToStr(No) + ListSeparator;
          if DiffType = dtGlobal then
            sLine := sLine + 'Global data' + ListSeparator
          else
            sLine := sLine + 'Change form' + ListSeparator;
          case DiffState of
            dsOnly1st: sLine := sLine + '1st only';
            dsOnly2nd: sLine := sLine + '2nd only';
            dsSize: sLine := sLine + 'Size';
            else
              sLine := sLine + 'Content';
          end;
          if DiffType = dtGlobal then
            sLine := ListSeparator + sLine + GetTypeString(globaID)
          else
            sLine := ListSeparator + sLine + RefIDToString(formID);
          sLine := sLine + ListSeparator + IntToStr(Size1);
          sLine := sLine + ListSeparator + IntToStr(Size2);
          if DiffType = dtForm then
          begin
            sLine := sLine + ListSeparator + GetFormString(Type1);
            sLine := sLine + ListSeparator + GetFormString(Type2);
            sLine := sLine + ListSeparator + IntToHex(Flags1, 8);
            sLine := sLine + ListSeparator + IntToHex(Flags2, 8);
            sLine := sLine + ListSeparator + IntToStr(Version1);
            sLine := sLine + ListSeparator + IntToStr(Version2);
          end;
          sList.Add(sLine);
      end;
      sList.SaveToFile(sdCSVSave.FileName);
    finally
      sList.Free
    end;
  end;
end;

procedure TfCompare.btnBreakClick(Sender: TObject);
begin
  bBreak := True;
  btnBreak.Enabled := False;
end;

procedure TfCompare.CompareData(Data1, Data2: PBytes);
var
  i: integer;
begin
  if Length(Data1^) <> Length(Data2^) then
    Exit
  else
  begin
    for i := 0 to Length(Data1^) - 1 do
      if Data1^[i] <> Data2^[i] then
        mmDiff.Lines.Add(IntToHex(i, 8) + ': ' + IntToHex(Data1^[i], 2) + ' ' + IntToHex(Data2^[i], 2));
    mmDiff.SelStart := mmDiff.Perform(EM_LINEINDEX, 0, 0);
    mmDiff.Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

function TfCompare.IsTheSameData(Data1, Data2: PBytes): Boolean;
var
  i: integer;
begin
  Result := False;
  if Length(Data1^) = Length(Data2^) then
  begin
    for i := 0 to Length(Data1^) - 1 do
      if Data1^[i] <> Data2^[i] then
        Exit;
    Result := True;
  end;
end;


function GetReference(DiffType: TDiffType; globaID: uint32; formID: TRefID): string;
begin
  case DiffType of
    dtGlobal: Result := GetTypeString(globaID);
    else
      Result := RefIDToHex(formID);
  end;
end;

procedure QuickSort(var aDiffs: TDiffs; aLow, aHi: Integer; aAscend: Boolean; aIndex: Integer);
var
  Act, Temp: TDiff;
  iL, iH: integer;
begin
  iL := aLow;
  iH := aHi;
  Act := aDiffs[(aLow + aHi) div 2];
  repeat
    if aAscend then
      case aIndex of
        0: while aDiffs[iL].No < Act.No do
             inc(iL);
        1: while aDiffs[iL].DiffType < Act.DiffType do
             inc(iL);
        2: while aDiffs[iL].DiffState < Act.DiffState do
             inc(iL);
        3: while AnsiCompareText(GetReference(aDiffs[iL].DiffType, aDiffs[iL].globaID, aDiffs[iL].formID), GetReference(Act.DiffType, Act.globaID, Act.formID)) < 0 do
             inc(iL);
        4: while aDiffs[iL].Size1 < Act.Size1 do
             inc(iL);
        5: while aDiffs[iL].Size2 < Act.Size2 do
             inc(iL);
        6: while aDiffs[iL].Flags1 < Act.Flags1 do
             inc(iL);
        7: while aDiffs[iL].Flags2 < Act.Flags2 do
             inc(iL);
        8: while aDiffs[iL].Type1 < Act.Type1 do
             inc(iL);
        9: while aDiffs[iL].Type2 < Act.Type2 do
             inc(iL);
        10: while aDiffs[iL].Version1 < Act.Version1 do
              inc(iL);
        11: while aDiffs[iL].Version2 < Act.Version2 do
              inc(iL);
      end
    else
      case aIndex of
        0: while aDiffs[iL].No > Act.No do
             inc(iL);
        1: while aDiffs[iL].DiffType > Act.DiffType do
             inc(iL);
        2: while aDiffs[iL].DiffState > Act.DiffState do
             inc(iL);
        3: while AnsiCompareText(GetReference(aDiffs[iL].DiffType, aDiffs[iL].globaID, aDiffs[iL].formID), GetReference(Act.DiffType, Act.globaID, Act.formID)) > 0 do
             inc(iL);
        4: while aDiffs[iL].Size1 > Act.Size1 do
             inc(iL);
        5: while aDiffs[iL].Size2 > Act.Size2 do
             inc(iL);
        6: while aDiffs[iL].Flags1 > Act.Flags1 do
             inc(iL);
        7: while aDiffs[iL].Flags2 > Act.Flags2 do
             inc(iL);
        8: while aDiffs[iL].Type1 > Act.Type1 do
             inc(iL);
        9: while aDiffs[iL].Type2 > Act.Type2 do
             inc(iL);
        10: while aDiffs[iL].Version1 > Act.Version1 do
              inc(iL);
        11: while aDiffs[iL].Version2 > Act.Version2 do
              inc(iL);
      end;
    if aAscend then
      case aIndex of
        0: while aDiffs[iH].No > Act.No do
             dec(iH);
        1: while aDiffs[iH].DiffType > Act.DiffType do
             dec(iH);
        2: while aDiffs[iH].DiffState > Act.DiffState do
             dec(iH);
        3: while AnsiCompareText(GetReference(aDiffs[iH].DiffType, aDiffs[iH].globaID, aDiffs[iH].formID), GetReference(Act.DiffType, Act.globaID, Act.formID)) > 0 do
             dec(iH);
        4: while aDiffs[iH].Size1 > Act.Size1 do
             dec(iH);
        5: while aDiffs[iH].Size2 > Act.Size2 do
             dec(iH);
        6: while aDiffs[iH].Flags1 > Act.Flags1 do
             dec(iH);
        7: while aDiffs[iH].Flags2 > Act.Flags2 do
             dec(iH);
        8: while aDiffs[iH].Type1 > Act.Type1 do
             dec(iH);
        9: while aDiffs[iH].Type2 > Act.Type2 do
             dec(iH);
        10: while aDiffs[iH].Version1 > Act.Version1 do
              dec(iH);
        11: while aDiffs[iH].Version2 > Act.Version2 do
              dec(iH);
      end
    else
      case aIndex of
        0: while aDiffs[iH].No < Act.No do
             dec(iH);
        1: while aDiffs[iH].DiffType < Act.DiffType do
             dec(iH);
        2: while aDiffs[iH].DiffState < Act.DiffState do
             dec(iH);
        3: while AnsiCompareText(GetReference(aDiffs[iH].DiffType, aDiffs[iH].globaID, aDiffs[iH].formID), GetReference(Act.DiffType, Act.globaID, Act.formID)) < 0 do
             dec(iH);
        4: while aDiffs[iH].Size1 < Act.Size1 do
             dec(iH);
        5: while aDiffs[iH].Size2 < Act.Size2 do
             dec(iH);
        6: while aDiffs[iH].Flags1 < Act.Flags1 do
             dec(iH);
        7: while aDiffs[iH].Flags2 < Act.Flags2 do
             dec(iH);
        8: while aDiffs[iH].Type1 < Act.Type1 do
             dec(iH);
        9: while aDiffs[iH].Type2 < Act.Type2 do
             dec(iH);
        10: while aDiffs[iH].Version1 < Act.Version1 do
              dec(iH);
        11: while aDiffs[iH].Version2 < Act.Version2 do
              dec(iH);
      end;
    if iL <= iH then
    begin
      Temp := aDiffs[iL];
      aDiffs[iL] := aDiffs[iH];
      aDiffs[iH] := Temp;
      inc(iL);
      dec(iH)
    end;
  until iL > iH;
  if aLow < iH then
    QuickSort(aDiffs, aLow, iH, aAscend, aIndex);
  if iL < aHi then
    QuickSort(aDiffs, iL, aHi, aAscend, aIndex)
end;

procedure TfCompare.lvDiffsColumnClick(Sender: TObject; Col: TListColumn);
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
        QuickSort(Diffs, 0, Length(Diffs) - 1, True, Col.Index)
      else
        QuickSort(Diffs, 0, Length(Diffs) - 1, False, Col.Index);
      for i := 0 to (Sender as TListView).Columns.Count - 1 do
        SetColumnSortOrder(Sender as TListview, i, Tag shr 1, Boolean(Tag and 1));
      Repaint;
    end;
end;

procedure TfCompare.lvDiffsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
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

procedure TfCompare.lvDiffsData(Sender: TObject; Item: TListItem);
begin
  if Item.Index < Length(Diffs) then
      with Diffs[Item.Index], Item do
      begin
        Data := Pointer(No - 1);
        Caption := IntToStr(No);
        if DiffType = dtGlobal then
          SubItems.Add('Global data')
        else
          SubItems.Add('Change form');
        case DiffState of
          dsOnly1st: SubItems.Add('1st only');
          dsOnly2nd: SubItems.Add('2nd only');
          dsSize: SubItems.Add('Size');
          else
            SubItems.Add('Content');
        end;
        if DiffType = dtGlobal then
          SubItems.Add(GetTypeString(globaID))
        else
          SubItems.Add(RefIDToString(formID));
        SubItems.Add(IntToStr(Size1));
        SubItems.Add(IntToStr(Size2));
        if DiffType = dtForm then
        begin
          SubItems.Add(GetFormString(Type1));
          SubItems.Add(GetFormString(Type2));
          SubItems.Add(IntToHex(Flags1, 8));
          SubItems.Add(IntToHex(Flags2, 8));
          SubItems.Add(IntToStr(Version1));
          SubItems.Add(IntToStr(Version2));
        end
        else
        begin
          SubItems.Add('');
          SubItems.Add('');
          SubItems.Add('');
          SubItems.Add('');
          SubItems.Add('');
          SubItems.Add('');
        end
      end;
end;

procedure TfCompare.lvDiffsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  bVisibled: Boolean;
begin
  if lvDiffs.Selected <> nil then
  begin
    mmDiff.Clear;
    bVisibled := mmDiff.Visible;
    mmDiff.Visible := (lvDiffs.Selected.Data <> nil) and (Integer(lvDiffs.Selected.Data) < Length(Diffs)) and (Diffs[Integer(lvDiffs.Selected.Data)].DiffState = dsContent);
    if not bVisibled and mmDiff.Visible then
    begin
      Self.Height := Self.Height + mmDiff.Height;
      mmDiff.Top := pnMenu.Top + pnMenu.Height;
    end
    else
      if bVisibled and not mmDiff.Visible then
        Self.Height := Self.Height - mmDiff.Height;
    if mmDiff.Visible then
      CompareData(Diffs[Integer(lvDiffs.Selected.Data)].Data1, Diffs[Integer(lvDiffs.Selected.Data)].Data2);
  end;
end;

procedure TfCompare.CheckGlobal(var Table1, Table2: array of TGlobalData);
var
  i, j: integer;
  bFound: boolean;
begin
  for i := 0 to Length(Table1) - 1 do
    with Table1[i] do
    begin
      bFound := False;
      for j := 0 to Length(Table2) - 1 do
        if _type = Table2[j]._type then
        begin
          bFound := True;
          Table2[j]._type := $FFFFFFFF;
          if (_length <> Table2[j]._length) or not IsTheSameData(@data, @Table2[j].data) then
          begin
            SetLength(Diffs, Length(Diffs) + 1);
            with Diffs[Length(Diffs) - 1] do
            begin
              No := Length(Diffs);
              DiffType := dtGlobal;
              globaID := _type;
              if _length <> Table2[j]._length then
                DiffState := dsSize
              else
                DiffState := dsContent;
              Size1 := _length;
              Data1 := @data;
              Size2 := Table2[j]._length;
              Data2 := @Table2[j].data;
            end;
          end;
        end;
      if not bFound then
      begin
        SetLength(Diffs, Length(Diffs) + 1);
        with Diffs[Length(Diffs) - 1] do
        begin
          No := Length(Diffs);
          DiffType := dtGlobal;
          globaID := _type;
          DiffState := dsOnly1st;
          Size1 := _length;
          Data1 := @data;
        end;
      end;
      pbProcess.Position := pbProcess.Position + 1;
      pnMenu.Caption := IntToStr(pbProcess.Position) + '/' + IntToStr(pbProcess.Max);
      Application.ProcessMessages;
      if bBreak then
        Exit;
    end;
  for i := 0 to Length(Table2) - 1 do
    with Table2[i] do
      if _type <> $FFFFFFFF then
      begin
        SetLength(Diffs, Length(Diffs) + 1);
        with Diffs[Length(Diffs) - 1] do
        begin
          No := Length(Diffs);
          DiffType := dtGlobal;
          globaID := _type;
          DiffState := dsOnly2nd;
          Size2 := _length;
          Data2 := @data;
        end;
        pbProcess.Position := pbProcess.Position + 1;
        pnMenu.Caption := IntToStr(pbProcess.Position) + '/' + IntToStr(pbProcess.Max);
        Application.ProcessMessages;
        if bBreak then
          Exit;
      end;
end;

procedure TfCompare.Compare(sFile1, sFile2: string);
var
  i, j, p: integer;
  bFound: boolean;
  Forms1, Forms2: TFormViews;
begin
  bBreak := False;
  pbProcess.Max := Max(Length(File1.globalDataTable1), Length(File2.globalDataTable1)) +
                   Max(Length(File1.globalDataTable2), Length(File2.globalDataTable2)) +
                   Max(Length(File1.globalDataTable3), Length(File2.globalDataTable3)) +
                   Max(Length(File1.changeForms), Length(File2.changeForms));
  try
    if (File1.magic <> C_TESVESS) or (File2.magic <> C_TESVESS) then
    begin
      MessageBox(Handle, 'Not correct file(s)', 'Error', MB_OK or MB_ICONERROR);
      Exit;
    end;
    CheckGlobal(File1.globalDataTable1, File2.globalDataTable1);
    CheckGlobal(File1.globalDataTable2, File2.globalDataTable2);

    SetLength(Forms1, Length(File1.changeForms));
    for i := 0 to Length(File1.changeForms) - 1 do
    begin
      CopyMemory(@Forms1[i].Form, @File1.changeForms[i], SizeOf(TFormView) - SizeOf(Integer));
      Forms1[i].No := i;
    end;
    QuickSortForms(Forms1, 0, Length(Forms1) - 1, True, 1);
    SetLength(Forms2, Length(File2.changeForms));
    for i := 0 to Length(File2.changeForms) - 1 do
    begin
      CopyMemory(@Forms2[i].Form, @File2.changeForms[i], SizeOf(TFormView) - SizeOf(Integer));
      Forms2[i].No := i;
    end;
    QuickSortForms(Forms2, 0, Length(Forms2) - 1, True, 1);
    i := 0;
    j := 0;
    p := pbProcess.Position;
    while i < Length(Forms1) do
    begin
      case RefIDCompare(Forms1[i].Form.formID, Forms2[j].Form.formID) of
        0: begin
             if (Forms1[i].Form.length1 <> Forms2[j].Form.length1) or
                (Forms1[i].Form._type <> Forms2[j].Form._type) or
                (Forms1[i].Form.changeFlags <> Forms2[j].Form.changeFlags) or
                (Forms1[i].Form.version <> Forms2[j].Form.version) or
                not IsTheSameData(@File1.changeForms[Forms1[i].No].data, @File2.changeForms[Forms2[j].No].data) then
             begin
               SetLength(Diffs, Length(Diffs) + 1);
               with Diffs[Length(Diffs) - 1] do
               begin
                 No := Length(Diffs);
                 DiffType := dtForm;
                 formID := Forms1[i].Form.formID;
                 if (Forms1[i].Form.length1 <> Forms2[j].Form.length1) or
                    (Forms1[i].Form._type <> Forms2[j].Form._type) or
                    (Forms1[i].Form.changeFlags <> Forms2[j].Form.changeFlags) or
                    (Forms1[i].Form.version <> Forms2[j].Form.version) then
                   DiffState := dsSize
                 else
                   DiffState := dsContent;
                 Size1 := Forms1[i].Form.length1;
                 Flags1 := Forms1[i].Form.changeFlags;
                 Type1 := Forms1[i].Form._type;
                 Version1 := Forms1[i].Form.version;
                 Data1 := @File1.changeForms[Forms1[i].No].data;
                 Size2 := Forms2[j].Form.length1;
                 Flags2 := Forms2[j].Form.changeFlags;
                 Type2 := Forms2[j].Form._type;
                 Version2 := Forms2[j].Form.version;
                 Data2 := @File2.changeForms[Forms2[j].No].data;
               end;
             end;
             Inc(i);
             Inc(j);
             Inc(p);
           end;
        1: while RefIDCompare(Forms1[i].Form.formID, Forms2[j].Form.formID) > 0 do
           begin
             SetLength(Diffs, Length(Diffs) + 1);
             with Diffs[Length(Diffs) - 1] do
             begin
               No := Length(Diffs);
               DiffType := dtForm;
               formID := Forms2[j].Form.formID;
               DiffState := dsOnly2nd;
               Size2 := Forms2[j].Form.length1;
               Flags2 := Forms2[j].Form.changeFlags;
               Type2 := Forms2[j].Form._type;
               Version2 := Forms2[j].Form.version;
               Data2 := @File2.changeForms[Forms2[j].No].data;
             end;
             Inc(j);
             Inc(p);
           end;
        -1: while RefIDCompare(Forms1[i].Form.formID, Forms2[j].Form.formID) < 0 do
            begin
              SetLength(Diffs, Length(Diffs) + 1);
              with Diffs[Length(Diffs) - 1] do
              begin
                No := Length(Diffs);
                DiffType := dtForm;
                formID := Forms1[i].Form.formID;
                DiffState := dsOnly1st;
                Size1 := Forms1[i].Form.length1;
                Flags1 := Forms1[i].Form.changeFlags;
                Type1 := Forms1[i].Form._type;
                Version1 := Forms1[i].Form.version;
                Data1 := @File1.changeForms[Forms1[i].No].data;
              end;
              Inc(i);
              Inc(p);
            end;
        else
          raise Exception.Create('Internal fault in RefIDCompare function')
      end;
      if (p - pbProcess.Position) > 100  then
      begin
        pbProcess.Position := p;
        pnMenu.Caption := IntToStr(pbProcess.Position) + '/' + IntToStr(pbProcess.Max);
      end;
      Application.ProcessMessages;
      if bBreak then
        Exit;
    end;

    CheckGlobal(File1.globalDataTable3, File2.globalDataTable3);
  finally
    lvDiffs.OwnerData := True;
    lvDiffs.Items.Count := Length(Diffs);
    lvDiffs.Enabled := True;
    btnExport.Enabled := True;
    btnBreak.Visible := False;
    pbProcess.Visible := False;
    pnMenu.Caption := '';
  end;
end;


end.
