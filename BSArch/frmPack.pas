{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit frmPack;

interface

uses
  System.Classes,

  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls,

  wbBSArchive;

type
  TFormPack = class(TForm)
    pnlArchiveType: TFlowPanel;
    pnlArchiveFlags: TFlowPanel;
    pnlFileFlags: TFlowPanel;
    chkAutodetectFlags: TCheckBox;
    chkMultiThreaded: TCheckBox;
    chkSharedData: TCheckBox;
    Label3: TLabel;
    edFileName: TEdit;
    btnBrowse: TButton;
    btnPack: TButton;
    Button1: TButton;
    lblTip: TLabel;
    lblPack: TLabel;
    cmbSplit: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    cmbCompression: TComboBox;
    lblTarget: TLabel;
    cmbTarget: TComboBox;
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
    SourceArchives: TArray<TwbBSArchive>;
    FilesList: TStringList;
    CompressionList: TArray<Boolean>;
    ArchiveType: TwbBSArchiveType;
    ArchiveTarget: TwbBSArchiveTarget;
    ArchiveFileName: string;
    AutodetectFlags: Boolean;
    MultiThreaded: Boolean;
    SharedData: Boolean;
    ArchiveFlags: Cardinal;
    FileFlags: Cardinal;
    Split: Integer;
    CompressionType: string;
  end;

var
  FormPack: TFormPack;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  System.SysUtils,

  Vcl.Dialogs,
  Vcl.Graphics,

  Winapi.Windows,

  wbCompression;

//============================================================================
procedure TFormPack.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

//============================================================================
procedure TFormPack.btnBrowseClick(Sender: TObject);
begin
  with TFileSaveDialog.Create(Self) do try
    with FileTypes.Add do begin
      FileMask := '*' + TwbBSArchive.DefaultExtension(ArchiveType);
      DisplayName := 'Bethesda Archive (' + FileMask + ')';
    end;

    DefaultFolder := ExtractFilePath(edFileName.Text);
    FileName := ExtractFileName(edFileName.Text);
    if Execute then begin
      var f := FileName;
      if TPath.GetExtension(f) = '' then
        f := f + TwbBSArchive.DefaultExtension(ArchiveType);
      edFileName.Text := f;
    end;
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormPack.rbArchiveTypeClick(Sender: TObject);
begin
  lblTip.Visible := False;
  ArchiveType := TwbBSArchiveType(TControl(Sender).Tag);
  chkAutodetectFlags.Visible := ArchiveType in [baTES4, baFO3, baSSE];
  pnlArchiveFlags.Visible := chkAutodetectFlags.Visible;
  pnlFileFlags.Visible := chkAutodetectFlags.Visible;
  edFileName.Text := TPath.ChangeExtension(edFileName.Text, TwbBSArchive.DefaultExtension(ArchiveType));
  lblTip.Visible := not chkAutodetectFlags.Visible;
  cmbTarget.Visible := TwbBSArchive.IsDDSArchive(ArchiveType);
  lblTarget.Visible := cmbTarget.Visible;
  // update autodetected flags
  if chkAutodetectFlags.Visible and chkAutodetectFlags.Checked then
    chkAutodetectFlagsClick(nil);

  case ArchiveType of
    baFO4dds, baSFdds: lblTip.Caption :=
      'A special type of archive optimized for textures which can''t contain anything else.'#13#13 +
      'Due to the game engine bug it must be compressed (the game might crash otherwise). ' +
      'All textures will be compressed no matter their compression status in the list.'#13#13 +
      'When target platfrom is XBox textures must already be in XBox format. ' +
      'Otherwise put xtexconv.exe and xg.dll in the same folder with BSArchPro ' +
      '(they are bundled with Creation Kit) for automatic convertion.';
    baTES3: lblTip.Caption :=
      'Morrowind doesn''t support compression in archives. All files will always be uncompressed.';
    else lblTip.Caption := '';
  end;

  cmbCompression.Clear;
  for var ct := Succ(Low(TwbCompressionType)) to High(TwbCompressionType) do
    if TwbBSArchive.SupportsCompression(ArchiveType, ct) then
      cmbCompression.Items.Add(TwbCompression.Name(ct));

  if cmbCompression.Items.Count > 0 then begin
    var i := cmbCompression.Items.IndexOf(CompressionType);
    if i = -1 then i := 0;
    cmbCompression.ItemIndex := i;
  end;
end;

//============================================================================
procedure TFormPack.chkAutodetectFlagsClick(Sender: TObject);
var t: Integer;
begin
  if chkAutodetectFlags.Checked then
    TwbBSArchive.DetectFlags(ArchiveType, FilesList, CompressionList, ArchiveFlags, FileFlags);

  for var i := 0 to Pred(pnlArchiveFlags.ControlCount) do
    with TCheckBox(pnlArchiveFlags.Controls[i]) do begin
      Enabled := not chkAutodetectFlags.Checked;
      t := Tag;
      Checked := (ArchiveFlags and (1 shl t)) <> 0;
    end;
  for var i := 0 to Pred(pnlFileFlags.ControlCount) do
    with TCheckBox(pnlFileFlags.Controls[i]) do begin
      Enabled := not chkAutodetectFlags.Checked;
      Checked := (FileFlags and (1 shl Tag)) <> 0;
    end;
end;

//============================================================================
procedure TFormPack.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
    Exit;

  if edFileName.Text = '' then begin
    ShowMessage('Archive File Name is empty');
    Action := caNone;
    Exit;
  end;

  // trying to overwrite source archive
  for var bsa in SourceArchives do
    if SameText(bsa.FileName, edFileName.Text) then
    with TTaskDialog.Create(Self) do try
      Text := 'Trying to overwrite the source archive:'#13 +
        edFileName.Text + #13#13 +
        'Pack under different name, then close BSArch and rename as original manually. ' +
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
    end;

  // trying to overwrite other existing archive
  if FileExists(edFileName.Text) then
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

  ArchiveTarget := TwbBSArchiveTarget(cmbTarget.Items.Objects[cmbTarget.ItemIndex]);
  ArchiveFileName := edFileName.Text;
  if chkAutodetectFlags.Visible then AutodetectFlags := chkAutodetectFlags.Checked;
  MultiThreaded := chkMultiThreaded.Checked;
  SharedData := chkSharedData.Checked;
  Split := Integer(cmbSplit.Items.Objects[cmbSplit.ItemIndex]);
  CompressionType := cmbCompression.Text;

  if chkAutodetectFlags.Visible and not chkAutodetectFlags.Checked then begin
    ArchiveFlags := 0;
    for var i := 0 to Pred(pnlArchiveFlags.ControlCount) do
      if TCheckBox(pnlArchiveFlags.Controls[i]).Checked then
        ArchiveFlags := ArchiveFlags or (1 shl pnlArchiveFlags.Controls[i].Tag);
    FileFlags := 0;
    for var i := 0 to Pred(pnlFileFlags.ControlCount) do
      if TCheckBox(pnlFileFlags.Controls[i]).Checked then
        FileFlags := FileFlags or (1 shl pnlFileFlags.Controls[i].Tag);
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
var
  i: Integer;
begin
  edFileName.Text := ArchiveFileName;
  chkAutodetectFlags.Checked := AutodetectFlags;
  chkMultiThreaded.Checked := MultiThreaded;
  chkSharedData.Checked := SharedData;

  cmbTarget.Items.AddObject('PC', TObject(btPC));
  cmbTarget.Items.AddObject('XBox', TObject(btXBox));
  cmbTarget.Items.AddObject('PS', TObject(btPS));
  i := cmbTarget.Items.IndexOfObject(TObject(ArchiveTarget));
  if i = -1 then i := 0;
  cmbTarget.ItemIndex := i;

  cmbSplit.Items.AddObject('Auto', TObject(-1));
  cmbSplit.Items.AddObject('None', TObject(0));
  cmbSplit.Items.AddObject('2 GB', TObject(2));
  cmbSplit.Items.AddObject('4 GB', TObject(4));
  cmbSplit.Items.AddObject('6 GB', TObject(6));
  cmbSplit.Items.AddObject('8 GB', TObject(8));
  i := cmbSplit.Items.IndexOfObject(TObject(Split));
  if i = -1 then i := 0;
  cmbSplit.ItemIndex := i;

  for var t := High(TwbBSArchiveType) downto Succ(Low(TwbBSArchiveType)) do begin
    var r := TRadioButton.Create(Self);
    r.Parent := pnlArchiveType;
    r.Width := pnlArchiveType.Width;
    r.Height := r.Height + 8;
    r.Caption := TwbBSArchive.FormatName(t);
    r.Font.Style := [fsBold];
    r.Tag := Integer(t);
    r.Checked := t = ArchiveType;
    r.OnClick := rbArchiveTypeClick;
    if r.Checked then
      rbArchiveTypeClick(r);
  end;

  for i := 2 to 9 do begin
    var c := TCheckBox.Create(Self);
    c.Parent := pnlArchiveFlags;
    c.Width := pnlArchiveFlags.Width;
    c.Caption := TwbBSArchive.cArchiveFlagNames[i];
    if c.Caption = '' then c.Caption := 'Bit ' + IntToStr(i);
    c.Tag := i;
  end;

  for i := 0 to 8 do begin
    var c := TCheckBox.Create(Self);
    c.Parent := pnlFileFlags;
    c.Width := pnlFileFlags.Width;
    c.Caption := TwbBSArchive.cFileFlagNames[i];
    if c.Caption = '' then c.Caption := 'Bit ' + IntToStr(i);
    c.Tag := i;
  end;

  chkAutodetectFlagsClick(nil);
end;

end.
