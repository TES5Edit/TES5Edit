{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit frmPack;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, wbBSArchive, Vcl.StdCtrls,
  wbAssets;

type
  TFormPack = class(TForm)
    pnlArchiveType: TFlowPanel;
    pnlArchiveFlags: TFlowPanel;
    pnlFileFlags: TFlowPanel;
    chkAutodetectFlags: TCheckBox;
    chkMultiThreaded: TCheckBox;
    Label1: TLabel;
    chkSharedData: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    edFileName: TEdit;
    btnBrowse: TButton;
    btnPack: TButton;
    btnCancel: TButton;
    lblTip: TLabel;
    lblPack: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAutodetectFlagsClick(Sender: TObject);
    procedure rbArchiveTypeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBrowseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    po: PPackingOptions;
  end;

var
  FormPack: TFormPack;

implementation

{$R *.dfm}

uses
  System.IOUtils;

//============================================================================
procedure TFormPack.rbArchiveTypeClick(Sender: TObject);
begin
  lblTip.Visible := False;
  po.ArchiveType := TBSArchiveType(TControl(Sender).Tag);
  chkAutodetectFlags.Visible := po.ArchiveType in [baTES4, baFO3, baSSE];
  pnlArchiveFlags.Visible := chkAutodetectFlags.Visible;
  pnlFileFlags.Visible := chkAutodetectFlags.Visible;
  edFileName.Text := TPath.ChangeExtension(edFileName.Text, cArchiveTypeExtensions[po.ArchiveType]);
  lblTip.Visible := not chkAutodetectFlags.Visible;
  case po.ArchiveType of
    baFO4dds, baFO4NGdds, baFO4NG2dds, baSFdds: lblTip.Caption :=
      'A special type of archive optimized for textures which can''t contain anything else.'#13 +
      'Due to the game engine bug it must be compressed (the game might crash otherwise). ' +
      'All textures will be compressed regardless of their compression status in the list.';
    baTES3: lblTip.Caption :=
      'Morrowind doesn''t support compression in archives. All files will be ' +
      'uncompressed regardless of their compression status in the list.';
    else lblTip.Caption := '';
  end;
end;

//============================================================================
procedure TFormPack.btnBrowseClick(Sender: TObject);
begin
  with TFileSaveDialog.Create(Self) do try
    with FileTypes.Add do begin
      FileMask := '*' + cArchiveTypeExtensions[po.ArchiveType];
      DisplayName := 'Bethesda Archive (' + FileMask + ')';
    end;

    DefaultFolder := ExtractFilePath(edFileName.Text);
    FileName := ExtractFileName(edFileName.Text);
    if Execute then begin
      var f := FileName;
      if TPath.GetExtension(f) = '' then
        f := f + cArchiveTypeExtensions[po.ArchiveType];
      edFileName.Text := f;
    end;
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormPack.chkAutodetectFlagsClick(Sender: TObject);
begin
  for var i := 0 to Pred(pnlArchiveFlags.ControlCount) do
    pnlArchiveFlags.Controls[i].Enabled := not chkAutodetectFlags.Checked;
  for var i := 0 to Pred(pnlFileFlags.ControlCount) do
    pnlFileFlags.Controls[i].Enabled := not chkAutodetectFlags.Checked;
end;

//============================================================================
procedure TFormPack.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

//============================================================================
procedure TFormPack.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then begin

    if edFileName.Text = '' then
      ShowMessage('Archive File Name is empty')

    // trying to overwrite the opened archive
    else if ArchiveManager.IndexOf(edFileName.Text) <> -1 then
      with TTaskDialog.Create(Self) do try
        Text := 'Trying to overwrite the source archive:'#13 +
          edFileName.Text + #13#13 +
          'Pack under a different name, then close BSArch and rename as original manually. ' +
          'Don''t forget to make backup first just in case.';
        Caption := Application.Title;
        Flags := [tfAllowDialogCancellation, tfPositionRelativeToWindow, tfSizeToContent];
        MainIcon := tdiError;
        CommonButtons := [tcbClose];
        Execute;
        Action := caNone;
        Exit;
      finally
        Free;
      end

    // trying to overwrite other existing archive
    else if FileExists(edFileName.Text) then
      with TTaskDialog.Create(Self) do try
        Text := 'Archive already exists:'#13 +
          edFileName.Text + #13#13 +
          'Do you want to overwrite?';
        Caption := Application.Title;
        Flags := [tfUseHiconMain, tfAllowDialogCancellation, tfPositionRelativeToWindow, tfSizeToContent];
        CustomMainIcon := Application.Icon;
        CommonButtons := [tcbYes, tcbNo];
        Execute;
        if ModalResult <> mrYes then begin
          Action := caNone;
          Exit;
        end;
      finally
        Free;
      end;


    po.ArchiveFileName := edFileName.Text;
    if chkAutodetectFlags.Visible then po.bAutodetectFlags := chkAutodetectFlags.Checked;
    po.bMultiThreaded := chkMultiThreaded.Checked;
    po.bSharedData := chkSharedData.Checked;

    if chkAutodetectFlags.Visible and not chkAutodetectFlags.Checked then begin

      po.ArchiveFlags := 3; // 'Include Directory Names' and 'Include File Names' always set
      for var i := 0 to Pred(pnlArchiveFlags.ControlCount) do
        if TCheckBox(pnlArchiveFlags.Controls[i]).Checked then
          po.ArchiveFlags := po.ArchiveFlags or (1 shl pnlArchiveFlags.Controls[i].Tag);

      po.FileFlags := 0;
      for var i := 0 to Pred(pnlFileFlags.ControlCount) do
        if TCheckBox(pnlFileFlags.Controls[i]).Checked then
          po.FileFlags := po.FileFlags or (1 shl pnlFileFlags.Controls[i].Tag);

    end;

  end;
end;

//============================================================================
procedure TFormPack.FormCreate(Sender: TObject);
begin
  lblTip.Top := pnlArchiveType.Top;
  lblTip.Height := pnlArchiveType.Width;
end;

//============================================================================
procedure TFormPack.FormShow(Sender: TObject);
begin
  edFileName.Text := po.ArchiveFileName;
  chkAutodetectFlags.Checked := po.bAutodetectFlags;
  chkMultiThreaded.Checked := po.bMultiThreaded;
  chkSharedData.Checked := po.bSharedData;

  for var t := High(TBSArchiveType) downto Succ(Low(TBSArchiveType)) do begin
    var r := TRadioButton.Create(Self);
    r.Parent := pnlArchiveType;
    r.Width := pnlArchiveType.Width;
    r.Height := r.Height + 8;
    r.Caption := cArchiveFormatNames[t];
    r.Font.Style := [fsBold];
    r.Tag := Integer(t);
    r.Checked := t = po.ArchiveType;
    r.OnClick := rbArchiveTypeClick;
    if r.Checked then
      rbArchiveTypeClick(r);
  end;

  for var i := 3 to 9 do begin
    var c := TCheckBox.Create(Self);
    c.Parent := pnlArchiveFlags;
    c.Width := pnlArchiveFlags.Width;
    c.Caption := cArchiveFlagNames[i];
    if c.Caption = '' then
      c.Caption := 'Bit ' + IntToStr(i);
    c.Tag := i;
    c.Checked := i < 2;
    c.Enabled := i > 2;
    if i >= 3 then
      c.Checked := ((po.ArchiveFlags shr i) and 1) <> 0;
  end;

  for var i := 0 to 8 do begin
    var c := TCheckBox.Create(Self);
    c.Parent := pnlFileFlags;
    c.Width := pnlFileFlags.Width;
    c.Caption := cFileFlagNames[i];
    if c.Caption = '' then
      c.Caption := 'Bit ' + IntToStr(i);
    c.Tag := i;
    c.Checked := ((po.FileFlags shr i) and 1) <> 0;
  end;

  chkAutodetectFlagsClick(nil);
end;

end.
