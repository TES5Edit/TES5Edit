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
    FormID: Cardinal;
    Name, Text: string;
    wbRecord: IwbMainRecord;
    Value1: Single;
    Value2: Single;
    Value3: Single;
  end;

  TfrmLogAnalyzer = class(TForm)
    pnlTop: TPanel;
    btnFileSelect: TButton;
    btnAnalyze: TButton;
    edLogFile: TLabeledEdit;
    dlgOpen: TOpenDialog;
    edLogSize: TLabeledEdit;
    Label1: TLabel;
    pnlClient: TPanel;
    vstForms: TVirtualEditTree;
    Splitter1: TSplitter;
    memoText: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnFileSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnalyzeClick(Sender: TObject);
  private
    { Private declarations }
    LogEntries: array of TLogEntry;
    LogPlugins: array of TLogEntry;
    ProcessLog: procedure (const aFileName: String) of object;
    function FormIDFromString(s: String): String;
    function RecordByFormID(FormID: Cardinal): IwbMainRecord;
    procedure ParsePapyrusData(const aData: String);
    procedure ReadPapyrusLog(const aFileName: String);
  public
    { Public declarations }
    lDataPath, lMyGamesTheGamePath: string;
    ltLog: TLogType;
    PFiles: ^TDynFiles;
  end;

  // modified version from http://stackoverflow.com/questions/2815839/delphi-alternative-to-using-reset-readln-for-text-file-reading
  TTextStream = class(TObject)
  private
    FHost: TStream;
    FOffset, FSize, FLimit: Integer;
    FBuffer: array[0..1023] of AnsiChar;
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

var
  frmLogAnalyzer: TfrmLogAnalyzer;

implementation

{$R *.dfm}

const
  sLineBreak = {$IFDEF LINUX} AnsiChar(#10) {$ENDIF}
               {$IFDEF MSWINDOWS} AnsiString(#13#10) {$ENDIF};

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
  Result := (FSize > 0);
  if (FLimit > 0) and (FHost.Position > FLimit) then
    Result := False;
  FEOF := Result;
end;

function TTextStream.ReadLn(out Line: string): Boolean;
var
  Len, Start: Integer;
  Data: AnsiString;
  EOLChar: AnsiChar;
begin
  Data := '';
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

function TfrmLogAnalyzer.RecordByFormID(FormID: Cardinal): IwbMainRecord;
var
  _File: IwbFile;
  FileID, j: integer;
begin
  Result := nil;
  FileID := FormID shr 24;

  if FileID = 255 then
    Exit;

  _File := nil;
  j := Low(PFiles^);
  while (j <= High(PFiles^)) and not Assigned(_File) do begin
    if PFiles^[j].LoadOrder = FileID then
      _File := PFiles^[j];
    Inc(j);
  end;
  while Assigned(_File) do begin
    FormID := (FormID and $00FFFFFF) or (Cardinal(_File.MasterCount) shl 24);
    Result := _File.RecordByFormID[FormID, True];
    if Assigned(Result) then
      Exit;

    _File := nil;
    while (j <= High(PFiles^)) and not Assigned(_File) do begin
      if PFiles^[j].LoadOrder = FileID then
        _File := PFiles^[j];
      Inc(j);
    end;
  end;
end;

function TfrmLogAnalyzer.FormIDFromString(s: String): String;

  function IsHex(c: char): boolean;
  begin
    Result := c in ['0'..'9', 'A'..'F'];
  end;

var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(s) - 7 do
    if
      IsHex(s[i]) and
      IsHex(s[i+1]) and
      IsHex(s[i+2]) and
      IsHex(s[i+3]) and
      IsHex(s[i+4]) and
      IsHex(s[i+5]) and
      IsHex(s[i+6]) and
      IsHex(s[i+7])
    then begin
      Result := Copy(s, i, 8);
      Exit;
    end;
end;

procedure TfrmLogAnalyzer.ParsePapyrusData(const aData: String);
var
  s, txt: string;
  IsError: boolean;
  IsWarning: boolean;
  i: integer;
  fid: Cardinal;
begin
  // skip papyrus timestamp
  txt := trim(Copy(aData, 27, Length(aData)));
  if Copy(txt, 1, 6) = 'error:' then IsError := True else
    if Copy(txt, 1, 8) = 'warning:' then IsWarning := True;

  if not (IsError or IsWarning) then
    Exit;

  s := FormIDFromString(txt);

  if s = '' then
    Exit;

  fid := StrToInt64Def('$' + s, 0);

  for i := Low(LogEntries) to High(LogEntries) do
    if LogEntries[i].FormID = fid then begin
      if IsError then LogEntries[i].Value1 := LogEntries[i].Value1 + 1 else
        if IsError then LogEntries[i].Value2 := LogEntries[i].Value2 + 1;
      if Pos(txt, LogEntries[i].Text) = 0 then
        LogEntries[i].Text := LogEntries[i].Text + sLineBreak + sLineBreak + txt;
      Exit;
    end;

  SetLength(LogEntries, Succ(Length(LogEntries)));
  with LogEntries[Pred(Length(LogEntries))] do begin
    FormID := fid;
    LoadOrder := FormID shr 24;
    wbRecord := RecordByFormID(FormID);
    Text := txt;
    if IsError then Value1 := 1 else Value1 := 0;
    if IsWarning then Value2 := 1 else Value2 := 0;
  end;

end;

procedure TfrmLogAnalyzer.ReadPapyrusLog(const aFileName: String);
var
  sLine: string;
  Entry: string;
begin
  Entry := '';
  with TTextStream.Create(TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite)) do try
    while ReadLn(sLine) do begin
      if (Length(sLine) > 25) and (sLine[1] = '[') and (sLine[2] in ['0'..'9']) then begin
        if Length(Entry) > 0 then
          ParsePapyrusData(Entry);
        Entry := sLine;
      end else begin
        Entry := Entry + sLine + sLineBreak;
      end;
    end;
    if Length(Entry) > 0 then
      ParsePapyrusData(Entry);
  finally
    Free;
  end;
end;

procedure TfrmLogAnalyzer.btnAnalyzeClick(Sender: TObject);
begin
  if not FileExists(edLogFile.Text) then begin
    memoText.Lines.Add('File does not exist');
    Exit;
  end;

  if Assigned(ProcessLog) then
    ProcessLog(edLogFile.Text);
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

procedure TfrmLogAnalyzer.FormShow(Sender: TObject);
begin
  case ltLog of
    ltTES4RuntimeScriptProfiler: begin
      edLogFile.Text := ExtractFilePath(ExcludeTrailingBackslash(lDataPath)) + 'RuntimeScriptProfiler.log';
    end;
    ltTES5Papyrus: begin
      edLogFile.Text := lMyGamesTheGamePath + 'Logs\Script\Papyrus.0.log';
      ProcessLog := ReadPapyrusLog;
    end;
  end;
  dlgOpen.InitialDir := ExtractFilePath(edLogFile.Text);
  dlgOpen.FileName := ExtractFileName(edLogFile.Text);
end;

end.
