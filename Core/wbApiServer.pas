{******************************************************************************

  xEdit external HTTP/JSON API server (secondary development).

  Starts a localhost-only HTTP server inside xEdit after plugins are loaded,
  so external programs can query the loaded plugin/record data and
  (in later milestones) modify records / create patches.

  Architecture:
    - A background thread accepts HTTP connections (blocking sockets).
    - Every request becomes a TwbApiJob executed on the VCL main thread
      through a TTimer pump, because all wb* element/file objects are bound
      to the main thread.
    - Responses are JSON.

  Command line switches (parsed by wbApiServerConfigureFromCmdLine):
    -api[:<port>]     enable the API server (default port 7000)
    -apitoken:<tok>   require "Authorization: Bearer <tok>" for every call
                      except GET /api/status

  Saving: the API deliberately has NO save capability. Edits are applied in
  memory only; persisting them to disk stays the user's decision and must be
  done from the xEdit GUI (File > Save / Ctrl+S). There is no save endpoint
  and no save op in the batch engine.

  Endpoints: see GET /api for the live index.

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbApiServer;

{$I wbDefines.inc}

interface

uses
  System.Classes,
  System.SyncObjs,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.ExtCtrls,
  wbInterface;

const
  wbApiDefaultPort   = 7000;
  wbApiVersion       = 1;
  wbApiMaxHeaderSize = 1024 * 1024;   // 1 MB upper bound for request headers
  wbApiMaxBodySize   = 32 * 1024 * 1024; // 32 MB upper bound for request body

type
  // Supplies the currently loaded plugin files (set by xeMainForm).
  TwbApiFilesProvider = reference to function: TwbFiles;
  TwbApiInteractionResponder = reference to procedure(aYes: Boolean);
  TwbApiRemoveRecordProc = reference to procedure(const aRecord: IwbMainRecord);
  // Creates a new plugin through the GUI (adds it to Files and the nav tree).
  TwbApiAddFileProc = reference to function(const aFileName: string;
                                            aIsLight, aIsMedium: Boolean): IwbFile;

  TwbApiRequest = record
    Method  : string;             // GET / POST / ...
    Path    : string;             // percent-decoded path, query removed
    RawPath : string;
    Query   : string;
    Headers : TStringList;        // "name=value", names lower-cased
    Body    : string;
  end;

  TwbApiResponse = record
    StatusCode : Integer;
    Body       : string;
  end;

  TwbApiReplay = record
    Fingerprint: string;
    Response: TwbApiResponse;
  end;

  TwbApiValueChange = record
    FileName, FormID, Path, BeforeValue, AfterValue: string;
  end;

  TwbApiChangeSet = class
  public
    Changes: TArray<TwbApiValueChange>;
    BeforeTree, AfterTree, State: string;
    Kind, FileName, FormID, BeforeNodes, AfterNodes, ErrorText: string;
    AddedElement: IwbElement;
    AddedPath, AddedFingerprint: string;
    OriginalLinkFile, OriginalLinkID: string;
    OriginalLinkWasNull: Boolean;
    DiffComplete: Boolean;
  end;

  TwbApiJob = class
  public
    Request  : TwbApiRequest;
    Response : TwbApiResponse;
    Done     : TEvent;
    constructor Create;
    destructor  Destroy; override;
  end;

  TwbApiServer = class;

  TwbApiServerThread = class(TThread)
  private
    FServer : TwbApiServer;
  protected
    procedure Execute; override;
  public
    constructor Create(aServer: TwbApiServer);
  end;

  TwbApiServer = class
  private
    FFilesProvider : TwbApiFilesProvider;
    FToken         : string;
    FPort          : Word;
    FThread        : TwbApiServerThread;
    FTimer         : TTimer;
    FQueue         : TThreadList;          // of TwbApiJob
    FListenSocket  : NativeUInt;           // SOCKET of the listening socket
    FCurrentSocket : NativeUInt;           // SOCKET currently being served
    FProcessing    : Boolean;
    FStarted       : Boolean;
    FSelecting: Boolean;
    FSelectionDone: Boolean;
    FReplays: TDictionary<string, TwbApiReplay>;
    FChangeSets: TObjectDictionary<string, TwbApiChangeSet>;
    FInteractionID, FInteractionMessage, FInteractionChoice: string;
    FInteractionResponder: TwbApiInteractionResponder;
    FPhase, FPhaseSince, FLastLoadError: string;
    FPhaseTick: UInt64;
    FLogs: TStringList;
    FLogSequence: Int64;

    procedure RefreshPhase;
    procedure HandleLogs(aJob: TwbApiJob);
    procedure HandleInteraction(aJob: TwbApiJob);
    procedure HandleElementInfo(aJob: TwbApiJob; const aFile: IwbFile;
      const aFormID: TwbFormID);
    function ExecuteElementOp(const aBody: string; out aResult: string): string;
    function ExecuteRecordCreate(const aBody: string; out aResult: string): string;
    function ExecuteRecordRemove(const aBody: string; out aResult: string): string;
    function StructuralSnapshot(const aFile: IwbFile; const aRecord: IwbMainRecord;
      out aNodes: string): string;
    procedure HandleElementChangeSet(aJob: TwbApiJob; const aID: string;
      aChangeSet: TwbApiChangeSet; aRollback: Boolean);
    procedure HandleStartupModules(aJob: TwbApiJob);
    procedure HandleChangeSet(aJob: TwbApiJob; const aID: string;
      aRollback: Boolean);
    function CheckPreconditions(aJob: TwbApiJob): Boolean;

    procedure   TimerTick(Sender: TObject);
    procedure   ProcessJob(aJob: TwbApiJob);
    procedure   HandleRequest(aJob: TwbApiJob);

    procedure   HandleConnection(aSocket: NativeUInt);
    procedure   SendResponse(aSocket: NativeUInt; aJob: TwbApiJob);

    function    PluginToJson(const aFile: IwbFile; aIndex: Integer): string;
    function    RecordMetaJson(const aRecord: IwbMainRecord; aWithNames: Boolean): string;
    function    RecordChainJson(const aRecord: IwbMainRecord): string;
    function    FindRecordAnyFile(const aFormID: TwbFormID): IwbMainRecord;
    function    ElementToJson(const aElement: IwbElement; aDepth: Integer): string;
    function    MainRecordToJson(const aRecord: IwbMainRecord; aDepth: Integer): string;
    procedure   HandleRecordTree(aJob: TwbApiJob; const aFile: IwbFile;
                                 const aFormID: TwbFormID);
    procedure   HandleRecordValues(aJob: TwbApiJob; const aFile: IwbFile;
                                   const aFormID: TwbFormID);
    procedure   HandleAddMasters(aJob: TwbApiJob; const aFile: IwbFile);
    function    FindTopLevelElement(const aRecord: IwbMainRecord;
                                    const aName: string): IwbElement;
    procedure   HandleCopyElements(aJob: TwbApiJob; const aFile: IwbFile;
                                   const aFormID: TwbFormID);
    procedure   HandleApiIndex(aJob: TwbApiJob);
    procedure   HandleFind(aJob: TwbApiJob);
    function    FindPlugin(const aFileName: string): IwbFile;
    procedure   HandleBatch(aJob: TwbApiJob);
    function    ResolveElement(const aElement: IwbElement; const aPath: string;
                               out aContainer: IwbContainerElementRef;
                               out aIndex: Integer): IwbElement;
    procedure   HandlePatch(aJob: TwbApiJob);
    function    RecordsPageJson(aFile: IwbFile; const aSignature, aEditorID: string;
                               aOffset, aLimit: Integer; aWithNames: Boolean;
                               out aReturned, aMore: Integer): string;
    procedure   HandlePluginRecords(aJob: TwbApiJob; const aFile: IwbFile);
    procedure   HandlePluginRecord(aJob: TwbApiJob; const aFile: IwbFile;
                                   const aFormID: TwbFormID);
    procedure   HandleGlobalRecord(aJob: TwbApiJob; const aFormID: TwbFormID);
    procedure   RespondJson(aJob: TwbApiJob; aCode: Integer; const aBody: string);
    procedure   RespondError(aJob: TwbApiJob; aCode: Integer;
                             const aCodeStr, aMessage: string);
  public
    constructor Create(aPort: Word; const aToken: string);
    destructor  Destroy; override;
    procedure   Start(aFilesProvider: TwbApiFilesProvider);   // main thread only
    procedure   Stop;                                          // main thread only
    property    Port: Word read FPort;
    property    Started: Boolean read FStarted;
  end;

// --- global entry points (called from xeInit / xeMainForm / xEdit.dpr) -----

procedure wbApiServerConfigureFromCmdLine;                    // parse -api switches
function  wbApiServerEnabled: Boolean;
procedure wbApiServerStart(const aFilesProvider: TwbApiFilesProvider); // main thread, after load
procedure wbApiServerStop;                                     // main thread, on exit
procedure wbApiServerBeginSelection;
procedure wbApiServerBeginInteraction(const aMessage: string;
  const aResponder: TwbApiInteractionResponder);
procedure wbApiServerEndInteraction(aYes: Boolean);
procedure wbApiServerLog(const aMessage: string);
procedure wbApiServerLoadFailed(const aMessage: string);
function wbApiServerSelectionDone: Boolean;
// UI-backed helpers, registered by xeMainForm after load (main thread).
procedure wbApiServerSetAddFileHandler(const aHandler: TwbApiAddFileProc);
procedure wbApiServerSetRemoveRecordHandler(const aHandler: TwbApiRemoveRecordProc);

implementation

uses
  System.StrUtils,
  System.DateUtils,
  System.Variants,
  Winapi.Windows,
  Winapi.WinSock2,
  JsonDataObjects,
  wbLoadOrder,
  wbCommandLine;

var
  wbApiServerInstance      : TwbApiServer;
  wbApiServerAddFileHandler : TwbApiAddFileProc;
  wbApiServerRemoveRecordHandler: TwbApiRemoveRecordProc;

{ =========================================================================== }
{  helpers                                                                    }
{ =========================================================================== }

// Mirrors xeMainForm.IsValidWindowsFileName (which is local to that unit).
// Used by HandlePatch so that an invalid name is rejected with a clean 400
// instead of raising inside frmMain.AddNewFileName.
function wbApiIsValidPluginFileName(const aFileName: string): Boolean;
const
  InvalidChars = '\/*?:"<>|';
var
  c : Char;
begin
  Result := aFileName <> '';
  if not Result then
    Exit;
  for c in aFileName do
    if Pos(c, InvalidChars) > 0 then
      Exit(False);
end;

function wbApiJsonEscape(const aValue: string): string;
var
  i : Integer;
  c : Char;
begin
  Result := '';
  for i := 1 to Length(aValue) do begin
    c := aValue[i];
    case c of
      '"' : Result := Result + '\"';
      '\' : Result := Result + '\\';
      #8  : Result := Result + '\b';
      #9  : Result := Result + '\t';
      #10 : Result := Result + '\n';
      #12 : Result := Result + '\f';
      #13 : Result := Result + '\r';
    else
      if Ord(c) < $20 then
        Result := Result + Format('\u%.4x', [Ord(c)])
      else
        Result := Result + c;
    end;
  end;
end;

function wbApiJsonString(const aValue: string): string;
begin
  Result := '"' + wbApiJsonEscape(aValue) + '"';
end;

function wbApiJsonBool(aValue: Boolean): string;
begin
  if aValue then
    Result := 'true'
  else
    Result := 'false';
end;

function wbApiHexVal(c: Char): Integer;
begin
  case c of
    '0'..'9' : Result := Ord(c) - Ord('0');
    'a'..'f' : Result := Ord(c) - Ord('a') + 10;
    'A'..'F' : Result := Ord(c) - Ord('A') + 10;
  else
    Result := -1;
  end;
end;

function wbApiUrlDecode(const aValue: string): string;

  procedure AddByte(var aBytes: TBytes; aValue: Byte);
  var
    l : Integer;
  begin
    l := Length(aBytes);
    SetLength(aBytes, l + 1);
    aBytes[l] := aValue;
  end;

var
  bytes : TBytes;
  i, l, h : Integer;
  utf8  : TBytes;
  c     : Char;
begin
  bytes := nil;
  l := Length(aValue);
  i := 1;
  while i <= l do begin
    if (aValue[i] = '%') and (i + 2 <= l) then begin
      h := (wbApiHexVal(aValue[i+1]) shl 4) or wbApiHexVal(aValue[i+2]);
      if h >= 0 then begin
        AddByte(bytes, Byte(h));
        Inc(i, 3);
        Continue;
      end;
    end;
    c := aValue[i];
    if Ord(c) <= $7F then
      AddByte(bytes, Byte(Ord(c)))
    else begin
      utf8 := TEncoding.UTF8.GetBytes(c);
      for h := Low(utf8) to High(utf8) do
        AddByte(bytes, utf8[h]);
    end;
    Inc(i);
  end;
  Result := TEncoding.UTF8.GetString(bytes);
end;

function wbApiHeaderValue(aHeaders: TStringList; const aName: string): string;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Pred(aHeaders.Count) do
    if SameText(aHeaders.Names[i], aName) then begin
      Result := aHeaders.ValueFromIndex[i];
      Exit;
    end;
end;

// index of the first #13#10#13#10 in aBuf, or -1
function wbApiFindHeaderEnd(const aBuf: TBytes): Integer;
var
  i, n : Integer;
begin
  Result := -1;
  n := Length(aBuf);
  for i := 0 to n - 4 do
    if (aBuf[i]     = 13) and (aBuf[i+1] = 10) and
       (aBuf[i+2]   = 13) and (aBuf[i+3] = 10) then begin
      Result := i;
      Exit;
    end;
end;

// parse 1..8 hex characters into a FormID value; $, 0x, # prefixes allowed
function wbApiParseFormID(const aValue: string; out aFormID: Cardinal): Boolean;
var
  i, l, digits : Integer;
  acc          : Int64;
  c            : Char;
begin
  Result := False;
  aFormID := 0;
  l := Length(aValue);
  i := 1;
  if (l >= 2) and ((aValue[1] = '$') or (aValue[1] = '#')) then
    i := 2
  else if (l >= 3) and (aValue[1] = '0') and
          ((aValue[2] = 'x') or (aValue[2] = 'X')) then
    i := 3;
  acc    := 0;
  digits := 0;
  while i <= l do begin
    c := aValue[i];
    case c of
      '0'..'9' : acc := acc * 16 + (Ord(c) - Ord('0'));
      'a'..'f' : acc := acc * 16 + (Ord(c) - Ord('a') + 10);
      'A'..'F' : acc := acc * 16 + (Ord(c) - Ord('A') + 10);
    else
      Exit(False);
    end;
    if acc > $FFFFFFFF then
      Exit(False);
    Inc(digits);
    Inc(i);
  end;
  if digits = 0 then
    Exit(False);
  aFormID := Cardinal(acc);
  Result  := True;
end;

// canonical signature string, e.g. 'ARMO' (trailing padding trimmed)
function wbApiSignatureToString(const aSignature: TwbSignature): string;
var
  tmp : AnsiString;
  i   : Integer;
begin
  SetLength(tmp, 4);
  for i := 0 to 3 do
    tmp[i + 1] := aSignature[i];
  Result := TrimRight(string(tmp));
end;

// inverse: build a 4-char TwbSignature from a string (padded with spaces)
function wbApiStringToSignature(const aValue: string): TwbSignature;
var
  i, l : Integer;
begin
  for i := 0 to 3 do
    Result[i] := ' ';
  l := Length(aValue);
  if l > 4 then
    l := 4;
  for i := 1 to l do
    Result[i - 1] := AnsiChar(aValue[i]);
end;

// value of one query parameter ("name=value&..."), '' when absent
function wbApiQueryParam(const aQuery, aName: string): string;
var
  pairs : TArray<string>;
  pair  : string;
  eq    : Integer;
begin
  Result := '';
  pairs := aQuery.Split(['&'], TStringSplitOptions.ExcludeEmpty);
  for pair in pairs do begin
    eq := Pos('=', pair);
    if eq > 0 then begin
      if SameText(Copy(pair, 1, eq - 1), aName) then begin
        // Query strings commonly use form encoding: '+' means space here.
        // Replace before percent decoding so %2B remains a literal plus.
        // URL paths still use wbApiUrlDecode directly and keep literal '+'.
        Result := wbApiUrlDecode(StringReplace(Copy(pair, eq + 1, MaxInt),
          '+', ' ', [rfReplaceAll]));
        Exit;
      end;
    end;
  end;
end;

{ =========================================================================== }
{  TwbApiJob                                                                  }
{ =========================================================================== }

constructor TwbApiJob.Create;
begin
  inherited Create;
  Done := TEvent.Create(nil, True, False, '');
  Request.Headers := TStringList.Create;
  Request.Headers.NameValueSeparator := '=';
  Response.StatusCode := 500;
end;

destructor TwbApiJob.Destroy;
begin
  Request.Headers.Free;
  Done.Free;
  inherited Destroy;
end;

{ =========================================================================== }
{  TwbApiServerThread                                                         }
{ =========================================================================== }

constructor TwbApiServerThread.Create(aServer: TwbApiServer);
begin
  inherited Create(True);
  FServer := aServer;
  FreeOnTerminate := False;
end;

procedure TwbApiServerThread.Execute;
var
  wsadata : TWSADATA;
  s       : TSocket;
  Client  : TSocket;
  sin     : TSockAddrIn;
  la      : TSockAddrIn;
  lalen   : Integer;
begin
  if WSAStartup($0202, wsadata) <> 0 then
    Exit;
  try
    s := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if s = INVALID_SOCKET then
      Exit;
    FServer.FListenSocket := NativeUInt(s);
    try
      FillChar(sin, SizeOf(sin), 0);
      sin.sin_family      := AF_INET;
      sin.sin_addr.S_addr := inet_addr('127.0.0.1');
      sin.sin_port        := htons(FServer.FPort);
      if bind(s, PSockAddr(@sin)^, SizeOf(sin)) = SOCKET_ERROR then
        Exit;
      if listen(s, 16) = SOCKET_ERROR then
        Exit;

      while not Terminated do begin
        FillChar(la, SizeOf(la), 0);
        lalen := SizeOf(la);
        Client := accept(s, PSockAddr(@la), @lalen);
        if Client = INVALID_SOCKET then
          Continue;              // socket was closed by Stop() to wake us up
        FServer.FCurrentSocket := NativeUInt(Client);
        try
          FServer.HandleConnection(NativeUInt(Client));
        finally
          FServer.FCurrentSocket := 0;
        end;
        closesocket(Client);
      end;
    finally
      closesocket(s);
      FServer.FListenSocket := 0;
    end;
  finally
    WSACleanup;
  end;
end;

{ =========================================================================== }
{  TwbApiServer                                                               }
{ =========================================================================== }

constructor TwbApiServer.Create(aPort: Word; const aToken: string);
begin
  inherited Create;
  FPort  := aPort;
  FToken := aToken;
  FQueue := TThreadList.Create;
  FLogs := TStringList.Create;
  RefreshPhase;
  FReplays := TDictionary<string, TwbApiReplay>.Create;
  FChangeSets := TObjectDictionary<string, TwbApiChangeSet>.Create([doOwnsValues]);
end;

destructor TwbApiServer.Destroy;
begin
  Stop;
  FQueue.Free;
  FLogs.Free;
  FReplays.Free;
  FChangeSets.Free;
  inherited Destroy;
end;

procedure TwbApiServer.Start(aFilesProvider: TwbApiFilesProvider);
begin
  if FStarted then
    Exit;
  FStarted       := True;
  FFilesProvider := aFilesProvider;

  FTimer := TTimer.Create(nil);
  FTimer.Interval := 20;
  FTimer.OnTimer  := TimerTick;

  FThread := TwbApiServerThread.Create(Self);
  FThread.Start;
end;

procedure TwbApiServer.Stop;
var
  list : TList;
  i    : Integer;
  job  : TwbApiJob;
begin
  if Assigned(FTimer) then begin
    FTimer.Enabled := False;
    FreeAndNil(FTimer);
  end;

  if Assigned(FThread) then begin
    FThread.Terminate;

    if FListenSocket <> 0 then begin
      closesocket(TSocket(FListenSocket));
      FListenSocket := 0;
    end;
    if FCurrentSocket <> 0 then begin
      closesocket(TSocket(FCurrentSocket));
      FCurrentSocket := 0;
    end;

    // wake up any job the server threads may be waiting on
    list := FQueue.LockList;
    try
      for i := 0 to Pred(list.Count) do begin
        job := TwbApiJob(list[i]);
        job.Response.StatusCode := 503;
        job.Response.Body := '{"ok":false,"error":{"code":"shutting_down","message":"xEdit is shutting down"}}';
        job.Done.SetEvent;
      end;
      list.Clear;
    finally
      FQueue.UnlockList;
    end;

    // the sockets above were closed and queued jobs signalled, so the worker
    // thread exits promptly; wait for it (no timeout overload on all versions)
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;

  FFilesProvider := nil;
  FStarted       := False;
end;

procedure TwbApiServer.TimerTick(Sender: TObject);
var
  list : TList;
  jobs : array of TwbApiJob;
  i, n : Integer;
begin
  RefreshPhase;
  if FProcessing then
    Exit;

  list := FQueue.LockList;
  try
    n := list.Count;
    if n = 0 then
      Exit;
    SetLength(jobs, n);
    for i := 0 to Pred(n) do
      jobs[i] := TwbApiJob(list[i]);
    list.Clear;
  finally
    FQueue.UnlockList;
  end;

  for i := 0 to Pred(n) do
    ProcessJob(jobs[i]);
end;

procedure TwbApiServer.ProcessJob(aJob: TwbApiJob);
var
  key, fingerprint: string;
  replay: TwbApiReplay;
  reserved: Boolean;
begin
  FProcessing := True;
  reserved := False;
  try
    try
      key := '';
      if aJob.Request.Method = 'POST' then
        key := wbApiHeaderValue(aJob.Request.Headers, 'idempotency-key');
      if key <> '' then begin
        if Length(key) > 128 then begin
          RespondError(aJob, 400, 'bad_idempotency_key', 'Key exceeds 128 characters');
          Exit;
        end;
        fingerprint := aJob.Request.Method + #10 + aJob.Request.RawPath + #10 + aJob.Request.Body;
        if FReplays.TryGetValue(key, replay) then begin
          if replay.Fingerprint <> fingerprint then
            RespondError(aJob, 409, 'idempotency_conflict', 'Key already used with a different request')
          else
            aJob.Response := replay.Response;
          Exit;
        end;
        // Never evict keys: eviction could execute an old retry twice.
        if FReplays.Count >= 128 then begin
          RespondError(aJob, 503, 'idempotency_capacity', 'Session replay cache is full; request was not executed');
          Exit;
        end;
        replay.Fingerprint := fingerprint;
        replay.Response.StatusCode := 409;
        replay.Response.Body := '{"ok":false,"error":{"code":"request_in_progress","message":"Request has not completed"}}';
        FReplays.Add(key, replay);
        reserved := True;
      end;
      if CheckPreconditions(aJob) then
        HandleRequest(aJob);
    except
      on E: Exception do
        RespondError(aJob, 500, 'internal_error', E.Message);
    end;
  finally
    if reserved then begin
      replay.Response := aJob.Response;
      FReplays.AddOrSetValue(key, replay);
    end;
    FProcessing := False;
    aJob.Done.SetEvent;
  end;
end;

procedure TwbApiServer.RespondJson(aJob: TwbApiJob; aCode: Integer; const aBody: string);
begin
  aJob.Response.StatusCode := aCode;
  aJob.Response.Body       := aBody;
end;

procedure TwbApiServer.RespondError(aJob: TwbApiJob; aCode: Integer;
                                    const aCodeStr, aMessage: string);
begin
  RespondJson(aJob, aCode,
    '{"ok":false,"error":{"code":' + wbApiJsonString(aCodeStr) +
    ',"message":' + wbApiJsonString(aMessage) + '}}');
end;

{ ---------------- request handling on the main thread ---------------------- }

procedure TwbApiServer.HandleRequest(aJob: TwbApiJob);
var
  sb     : TStringBuilder;
  files  : TwbFiles;
  f      : IwbFile;
  i, j   : Integer;
  n      : Integer;
  fc     : Integer;
  parts  : TArray<string>;
  p      : string;
begin
  if aJob.Request.Path = '/api/logs' then begin
    HandleLogs(aJob);
    Exit;
  end;
  if (aJob.Request.Path = '/api/interactions') or
     aJob.Request.Path.StartsWith('/api/interactions/') then begin
    HandleInteraction(aJob);
    Exit;
  end;
  if (aJob.Request.Path = '/api/modules') or (aJob.Request.Path = '/api/load') then begin
    HandleStartupModules(aJob);
    Exit;
  end;
  if (not wbLoaderDone or wbLoaderError or (FLastLoadError <> '')) and (aJob.Request.Path <> '/api/status') and
     (aJob.Request.Path <> '/api') then begin
    RespondError(aJob, 503, 'not_loaded', 'Plugins are still loading');
    Exit;
  end;

  if not ((aJob.Request.Method = 'GET') or (aJob.Request.Method = 'POST')) then begin
    RespondError(aJob, 405, 'method_not_allowed', 'Only GET and POST are supported');
    Exit;
  end;

  p := aJob.Request.Path;
  if p = '/api/element-changesets' then begin
    HandleElementChangeSet(aJob, '', nil, False);
    Exit;
  end;
  if p = '/api/changesets' then begin
    HandleChangeSet(aJob, '', False);
    Exit;
  end;
  if p.StartsWith('/api/changesets/') then begin
    var changeParts := Copy(p, Length('/api/changesets/') + 1, MaxInt).Split(['/']);
    if Length(changeParts) = 1 then
      HandleChangeSet(aJob, changeParts[0], False)
    else if (Length(changeParts) = 2) and (changeParts[1] = 'rollback') then
      HandleChangeSet(aJob, changeParts[0], True)
    else
      RespondError(aJob, 404, 'not_found', 'Unknown changeset endpoint');
    Exit;
  end;
  if p = '/api' then begin
    HandleApiIndex(aJob);
    Exit;
  end;
  if not p.StartsWith('/api/') then begin
    RespondError(aJob, 404, 'not_found', 'Unknown endpoint: ' + aJob.Request.Path);
    Exit;
  end;

  parts := Copy(p, 6, MaxInt).Split(['/'], TStringSplitOptions.ExcludeEmpty);
  n := Length(parts);
  if n < 1 then begin
    RespondError(aJob, 404, 'not_found', 'Unknown endpoint: ' + aJob.Request.Path);
    Exit;
  end;

  sb := TStringBuilder.Create;
  try
    if parts[0] = 'status' then begin
      RefreshPhase;
      sb.Append('{"ok":true,"apiVersion":').Append(wbApiVersion);
      sb.Append(',"pid":').Append(GetCurrentProcessId);
      sb.Append(',"title":').Append(wbApiJsonString(wbApplicationTitle));
      sb.Append(',"gameMode":').Append(Ord(wbGameMode));
      sb.Append(',"toolMode":').Append(Ord(wbToolMode));
      sb.Append(',"pluginsLoaded":').Append(wbApiJsonBool(wbLoaderDone));
      sb.Append(',"waitingForSelection":').Append(wbApiJsonBool(FSelecting));
      sb.Append(',"loaderError":').Append(wbApiJsonBool(wbLoaderError));
      sb.Append(',"waitingForInteraction":').Append(wbApiJsonBool(Assigned(FInteractionResponder)));
      sb.Append(',"phase":').Append(wbApiJsonString(FPhase));
      sb.Append(',"phaseSince":').Append(wbApiJsonString(FPhaseSince));
      sb.Append(',"phaseDurationMs":').Append(GetTickCount64 - FPhaseTick);
      sb.Append(',"lastLoadError":').Append(wbApiJsonString(FLastLoadError));
      sb.Append(',"logCursor":').Append(FLogSequence);
      // FProcessing protects the main-thread pump from reentrancy. It is
      // necessarily true inside this handler, including for the status query
      // itself, so it cannot describe application activity to a client.
      // Requests are serialized; this status reflects background loading only.
      sb.Append(',"busy":').Append(wbApiJsonBool(
        FPhase = 'loading'));
      sb.Append(',"port":').Append(FPort);
      sb.Append('}');
      RespondJson(aJob, 200, sb.ToString);
      Exit;
    end;

    if parts[0] = 'plugins' then begin
      if not Assigned(FFilesProvider) then begin
        RespondError(aJob, 500, 'no_provider', 'Plugin list provider is not registered');
        Exit;
      end;
      files := Copy(FFilesProvider(), 0, MaxInt); // copy: never mutate frmMain.Files storage
      fc    := Length(files);

      // find the plugin named parts[1], if the path has one
      f := nil;
      if n >= 2 then
        for i := 0 to Pred(fc) do
          if SameText(files[i].FileName, parts[1]) then begin
            f := files[i];
            Break;
          end;

      if n >= 3 then begin
        // sub-resources under a plugin: /api/plugins/{file}/...
        if f = nil then begin
          RespondError(aJob, 404, 'not_found', 'Plugin not loaded: ' + parts[1]);
          Exit;
        end;
        if (n = 3) and (parts[2] = 'records') then begin
          HandlePluginRecords(aJob, f);
          Exit;
        end;
        if (n = 3) and (parts[2] = 'addmasters') then begin
          HandleAddMasters(aJob, f);
          Exit;
        end;
    if (n = 4) and (parts[2] = 'records') then begin
          var fid: Cardinal;
          if not wbApiParseFormID(parts[3], fid) then begin
            RespondError(aJob, 400, 'bad_formid', 'Invalid FormID: ' + parts[3]);
            Exit;
          end;
          HandlePluginRecord(aJob, f, TwbFormID.FromCardinal(fid));
          Exit;
        end;
        if (n = 5) and (parts[2] = 'records') then begin
          // /api/plugins/{file}/records/{formid}/tree  or  /values
          var fid: Cardinal;
          if not wbApiParseFormID(parts[3], fid) then begin
            RespondError(aJob, 400, 'bad_formid', 'Invalid FormID: ' + parts[3]);
            Exit;
          end;
          if parts[4] = 'tree' then begin
            HandleRecordTree(aJob, f, TwbFormID.FromCardinal(fid));
            Exit;
          end;
          if parts[4] = 'element' then begin
            HandleElementInfo(aJob, f, TwbFormID.FromCardinal(fid));
            Exit;
          end;
          if parts[4] = 'values' then begin
            HandleRecordValues(aJob, f, TwbFormID.FromCardinal(fid));
            Exit;
          end;
          if parts[4] = 'copy-elements' then begin
            HandleCopyElements(aJob, f, TwbFormID.FromCardinal(fid));
            Exit;
          end;
          RespondError(aJob, 404, 'not_found', 'Unknown endpoint: ' + aJob.Request.Path);
          Exit;
        end;
        RespondError(aJob, 404, 'not_found', 'Unknown endpoint: ' + aJob.Request.Path);
        Exit;
      end;

      if n = 2 then begin
        // /api/plugins/{fileName}
        if f <> nil then
          // prepend "ok" so this endpoint follows the same convention as the
          // rest of the API, without nesting the plugin object
          RespondJson(aJob, 200, '{"ok":true,' + Copy(PluginToJson(f, 0), 2, MaxInt))
        else
          RespondError(aJob, 404, 'not_found', 'Plugin not loaded: ' + parts[1]);
        Exit;
      end;

      // /api/plugins -> full list, sorted by load order
      for i := 1 to Pred(fc) do begin
        f := files[i];
        j := i;
        while (j > 0) and (files[j-1].LoadOrder > f.LoadOrder) do begin
          files[j] := files[j-1];
          Dec(j);
        end;
        files[j] := f;
      end;

      sb.Append('{"ok":true,"count":').Append(fc);
      sb.Append(',"plugins":[');
      for i := 0 to Pred(fc) do begin
        if i > 0 then
          sb.Append(',');
        sb.Append(PluginToJson(files[i], i));
      end;
      sb.Append(']}');
      RespondJson(aJob, 200, sb.ToString);
      Exit;
    end;

    if parts[0] = 'records' then begin
      // /api/records/{loadOrderFormID} - resolve a record across all files
      if n <> 2 then begin
        RespondError(aJob, 404, 'not_found', 'Unknown endpoint: ' + aJob.Request.Path);
        Exit;
      end;
      var fid: Cardinal;
      if not wbApiParseFormID(parts[1], fid) then begin
        RespondError(aJob, 400, 'bad_formid', 'Invalid FormID: ' + parts[1]);
        Exit;
      end;
      HandleGlobalRecord(aJob, TwbFormID.FromCardinal(fid));
      Exit;
    end;

    if (parts[0] = 'patch') and (n = 1) then begin
      HandlePatch(aJob);
      Exit;
    end;

    if (parts[0] = 'batch') and (n = 1) then begin
      HandleBatch(aJob);
      Exit;
    end;

    if (parts[0] = 'find') and (aJob.Request.Method = 'GET') then begin
      HandleFind(aJob);
      Exit;
    end;

    RespondError(aJob, 404, 'not_found', 'Unknown endpoint: ' + aJob.Request.Path);
  finally
    sb.Free;
  end;
end;

procedure TwbApiServer.HandleStartupModules(aJob: TwbApiJob);
var
  modules, previous: TwbModuleInfos;
  requested: TArray<PwbModuleInfo>;
  body: TJsonObject;
  sb: TStringBuilder;
  i: Integer;
begin
  modules := wbModulesByLoadOrder(False).FilteredByFlag(mfValid);
  if (aJob.Request.Path = '/api/modules') and (aJob.Request.Method = 'GET') then begin
    sb := TStringBuilder.Create;
    try
      sb.Append('{"ok":true,"modules":[');
      for i := 0 to High(modules) do begin
        if i > 0 then sb.Append(',');
        sb.Append('{"fileName":').Append(wbApiJsonString(modules[i].miName));
        sb.Append(',"active":').Append(wbApiJsonBool(modules[i].IsActive)).Append('}');
      end;
      sb.Append(']}');
      RespondJson(aJob, 200, sb.ToString);
    finally
      sb.Free;
    end;
    Exit;
  end;
  if (aJob.Request.Path <> '/api/load') or (aJob.Request.Method <> 'POST') then begin
    RespondError(aJob, 405, 'method_not_allowed', 'Use GET /api/modules or POST /api/load');
    Exit;
  end;
  if not FSelecting then begin
    RespondError(aJob, 409, 'not_waiting_for_selection', 'Loading can only be requested once during startup');
    Exit;
  end;
  body := nil;
  try
    try
      var parsed := TJsonObject.Parse(aJob.Request.Body);
      if not (parsed is TJsonObject) then begin
        parsed.Free;
        raise Exception.Create('Expected JSON object');
      end;
      body := TJsonObject(parsed);
      if (body = nil) or (body.Types['plugins'] <> jdtArray) then
        raise Exception.Create('Expected plugins array');
      if body.A['plugins'].Count = 0 then raise Exception.Create('Select at least one plugin');
      SetLength(requested, body.A['plugins'].Count);
      for i := 0 to High(requested) do begin
        if body.A['plugins'].Types[i] <> jdtString then raise Exception.Create('Plugin names must be strings');
        requested[i] := wbModuleByName(body.A['plugins'].S[i]);
        if (requested[i] = nil) or not requested[i].IsValid then
          raise Exception.Create('Plugin not available: ' + body.A['plugins'].S[i]);
      end;
      previous := modules.FilteredBy(function(m: PwbModuleInfo): Boolean
        begin Result := m.IsActive; end);
      try
        modules.DeactivateAll;
        for i := 0 to High(requested) do requested[i].Activate(True);
        modules.SimulateLoad;
      except
        modules.DeactivateAll;
        for i := 0 to High(previous) do previous[i].Activate;
        raise;
      end;
      modules.ExcludeAll(mfTaggedForPluginMode);
      for i := 0 to High(requested) do
        Include(requested[i].miFlags, mfTaggedForPluginMode);
      FSelectionDone := True;
      FSelecting := False;
      RefreshPhase;
      RespondJson(aJob, 200, '{"ok":true,"state":"loading","note":"Selection accepted; poll /api/status for completion"}');
    except
      on E: Exception do RespondError(aJob, 400, 'invalid_selection', E.Message);
    end;
  finally
    body.Free;
  end;
end;

function wbApiGetContainer(const aElement: IwbElement;
  out aContainer: IwbContainerBase): Boolean;
var
  ref: IwbContainerElementRef;
  container: IwbContainer;
begin
  aContainer := nil;
  // Query concrete interfaces: the common base is not independently exposed
  // by all xEdit implementations through QueryInterface.
  if Supports(aElement, IwbContainerElementRef, ref) then
    aContainer := ref
  else if Supports(aElement, IwbContainer, container) then
    aContainer := container;
  Result := aContainer <> nil;
end;

procedure TwbApiServer.HandleElementInfo(aJob: TwbApiJob; const aFile: IwbFile;
  const aFormID: TwbFormID);
var
  rec: IwbMainRecord;
  el: IwbElement;
  parent: IwbContainerElementRef;
  container: IwbContainerBase;
  templates: TwbTemplateElements;
  choices: TwbStringArray;
  idx, i: Integer;
  path: string;
  sb: TStringBuilder;
begin
  if aJob.Request.Method <> 'GET' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'Element inspection requires GET');
    Exit;
  end;
  rec := aFile.ContainedRecordByLoadOrderFormID[aFormID, True];
  if rec = nil then begin
    RespondError(aJob, 404, 'not_found', 'Record not found');
    Exit;
  end;
  path := wbApiQueryParam(aJob.Request.Query, 'path');
  el := ResolveElement(rec, path, parent, idx);
  if el = nil then begin
    RespondError(aJob, 404, 'not_found', 'Element path not found');
    Exit;
  end;
  sb := TStringBuilder.Create;
  try
    sb.Append('{"ok":true,"file":').Append(wbApiJsonString(aFile.FileName));
    sb.Append(',"formID":').Append(wbApiJsonString(IntToHex(aFormID.ToCardinal, 8)));
    sb.Append(',"name":').Append(wbApiJsonString(el.Name));
    sb.Append(',"path":').Append(wbApiJsonString(path));
    sb.Append(',"displayPath":').Append(wbApiJsonString(el.Path));
    sb.Append(',"elementType":').Append(Ord(el.ElementType));
    sb.Append(',"value":').Append(wbApiJsonString(el.Value));
    sb.Append(',"editValue":').Append(wbApiJsonString(el.EditValue));
    sb.Append(',"editable":').Append(wbApiJsonBool(el.IsEditable));
    sb.Append(',"removable":').Append(wbApiJsonBool(el.IsRemovable));
    sb.Append(',"clearable":').Append(wbApiJsonBool(el.IsClearable));
    sb.Append(',"canContainFormIDs":').Append(wbApiJsonBool(el.CanContainFormIDs));
    sb.Append(',"isContainer":').Append(wbApiJsonBool(wbApiGetContainer(el, container)));
    if container <> nil then
      sb.Append(',"childCount":').Append(container.ElementCount);
    // Enumerating choices/templates is opt-in: large reference selectors can
    // be expensive. Return truncation explicitly rather than implying a schema.
    if wbApiQueryParam(aJob.Request.Query, 'options') = '1' then begin
      choices := el.EditInfo;
      sb.Append(',"editOptions":[');
      for i := 0 to High(choices) do begin
        if i >= 256 then Break;
        if i > 0 then sb.Append(',');
        sb.Append(wbApiJsonString(choices[i]));
      end;
      sb.Append('],"editOptionsTruncated":').Append(wbApiJsonBool(Length(choices) > 256));
    end;
    if wbApiQueryParam(aJob.Request.Query, 'templates') = '1' then begin
      templates := el.GetAssignTemplates(wbAssignAdd);
      sb.Append(',"addTemplates":[');
      for i := 0 to High(templates) do begin
        if i >= 256 then Break;
        if i > 0 then sb.Append(',');
        if templates[i] = nil then sb.Append('null')
        else sb.Append(wbApiJsonString(templates[i].Name));
      end;
      sb.Append('],"addTemplatesTruncated":').Append(wbApiJsonBool(Length(templates) > 256));
    end;
    sb.Append('}');
    RespondJson(aJob, 200, sb.ToString);
  finally
    sb.Free;
  end;
end;

procedure TwbApiServer.RefreshPhase;
var
  phase: string;
begin
  if wbLoaderError or (FLastLoadError <> '') then begin
    phase := 'failed';
    if FLastLoadError = '' then
      FLastLoadError := 'Plugin loading failed; inspect /api/logs for details';
  end else if Assigned(FInteractionResponder) then phase := 'waiting_for_interaction'
  else if FSelecting then phase := 'waiting_for_selection'
  else if wbLoaderDone then phase := 'ready'
  else if FSelectionDone then phase := 'loading'
  else phase := 'initializing';
  if phase <> FPhase then begin
    FPhase := phase;
    FPhaseSince := DateToISO8601(TTimeZone.Local.ToUniversalTime(Now), True);
    FPhaseTick := GetTickCount64;
  end;
end;

procedure TwbApiServer.HandleLogs(aJob: TwbApiJob);
var
  after, first: Int64;
  i: Integer;
  sb: TStringBuilder;
begin
  if aJob.Request.Method <> 'GET' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'Logs require GET');
    Exit;
  end;
  var value := wbApiQueryParam(aJob.Request.Query, 'after');
  after := 0;
  if (value <> '') and (not TryStrToInt64(value, after) or (after < 0)) then begin
    RespondError(aJob, 400, 'bad_cursor', 'after must be a nonnegative integer');
    Exit;
  end;
  first := FLogSequence - FLogs.Count + 1;
  sb := TStringBuilder.Create;
  try
    sb.Append('{"ok":true,"nextCursor":').Append(FLogSequence);
    sb.Append(',"truncated":').Append(wbApiJsonBool(after < first - 1));
    sb.Append(',"entries":[');
    var comma := False;
    for i := 0 to Pred(FLogs.Count) do
      if first + i > after then begin
        if comma then sb.Append(',');
        comma := True;
        sb.Append(FLogs[i]);
      end;
    sb.Append(']}');
    RespondJson(aJob, 200, sb.ToString);
  finally
    sb.Free;
  end;
end;

procedure TwbApiServer.HandleInteraction(aJob: TwbApiJob);
var
  body: TJsonObject;
  choice: string;
begin
  if (aJob.Request.Path = '/api/interactions') and (aJob.Request.Method = 'GET') then begin
    if FInteractionID = '' then
      RespondJson(aJob, 200, '{"ok":true,"interactions":[]}')
    else
      RespondJson(aJob, 200, '{"ok":true,"interactions":[{"id":' +
        wbApiJsonString(FInteractionID) + ',"type":"reference_cache_cleanup","blocking":' +
        wbApiJsonBool(Assigned(FInteractionResponder)) + ',"state":' +
        wbApiJsonString(IfThen(Assigned(FInteractionResponder), 'pending', 'resolved')) +
        ',"message":' + wbApiJsonString(FInteractionMessage) +
        ',"choice":' + wbApiJsonString(FInteractionChoice) +
        ',"choices":[{"id":"yes","effect":"Delete old reference cache files"},' +
        '{"id":"no","effect":"Keep reference cache files"}]}]}');
    Exit;
  end;
  if (aJob.Request.Method <> 'POST') or (FInteractionID = '') or
     (aJob.Request.Path <> '/api/interactions/' + FInteractionID + '/respond') then begin
    RespondError(aJob, 404, 'not_found', 'Unknown interaction endpoint');
    Exit;
  end;
  body := nil;
  try
    try
      var parsed := TJsonObject.Parse(aJob.Request.Body);
      if not (parsed is TJsonObject) then begin
        parsed.Free;
        raise Exception.Create('Expected JSON object');
      end;
      body := TJsonObject(parsed);
      if body.Types['choice'] <> jdtString then raise Exception.Create('choice must be a string');
      choice := body.S['choice'];
      if (choice <> 'yes') and (choice <> 'no') then raise Exception.Create('Choose yes or no');
      if not Assigned(FInteractionResponder) then begin
        if choice = FInteractionChoice then
          RespondJson(aJob, 200, '{"ok":true,"state":"resolved"}')
        else
          RespondError(aJob, 409, 'interaction_resolved', 'Interaction was already answered');
        Exit;
      end;
      var responder := FInteractionResponder;
      FInteractionChoice := choice;
      FInteractionResponder := nil;
      RefreshPhase;
      responder(choice = 'yes');
      RespondJson(aJob, 200, '{"ok":true,"state":"resolved"}');
    except
      on E: Exception do RespondError(aJob, 400, 'invalid_response', E.Message);
    end;
  finally
    body.Free;
  end;
end;

function wbApiParseObject(const aBody: string): TJsonObject;
var
  parsed: TJsonBaseObject;
begin
  parsed := TJsonObject.Parse(aBody);
  if not (parsed is TJsonObject) then begin
    parsed.Free;
    raise Exception.Create('Request body must be a JSON object');
  end;
  Result := TJsonObject(parsed);
end;

function TwbApiServer.ExecuteElementOp(const aBody: string; out aResult: string): string;
var
  obj, source: TJsonObject;
  f, sourceFile: IwbFile;
  rec, linked: IwbMainRecord;
  el, created, template, link: IwbElement;
  parent: IwbContainerElementRef;
  container: IwbContainerBase;
  templates: TwbTemplateElements;
  fid: Cardinal;
  idx, i: Integer;
  op, path, beforeValue, afterValue, resultPath, displayPath, templateName, state: string;
  masterFound: Boolean;
begin
  Result := '';
  aResult := '{}';
  obj := nil;
  state := 'not_applied';
  beforeValue := '';
  afterValue := '';
  resultPath := '';
  displayPath := '';
  created := nil;
  try
    try
      obj := wbApiParseObject(aBody);
      op := obj.S['op'];
      if (obj.Types['file'] <> jdtString) or (obj.Types['formID'] <> jdtString) or
         (obj.Types['path'] <> jdtString) then
        raise Exception.Create('file/formID/path must be strings');
      f := FindPlugin(obj.S['file']);
      if (f = nil) or not wbApiParseFormID(obj.S['formID'], fid) then
        raise Exception.Create('Invalid file/formID');
      rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
      if (rec = nil) or not rec.IsEditable or not wbEditAllowed or wbTranslationMode then
        raise Exception.Create('Record is unavailable or editing is not allowed');
      path := obj.S['path'];
      el := ResolveElement(rec, path, parent, idx);
      if el = nil then raise Exception.Create('Element path not found: ' + path);
      beforeValue := el.EditValue;
      if obj.Contains('expected') then begin
        if obj.Types['expected'] <> jdtString then raise Exception.Create('expected must be a string');
        if obj.S['expected'] <> beforeValue then raise Exception.Create('precondition_failed: field value changed');
      end;
      if op = 'add-element' then begin
        if not wbApiGetContainer(el, container) then raise Exception.Create('Target must be a container');
        if obj.Contains('signature') then begin
          if obj.Contains('template') or (obj.Types['signature'] <> jdtString) then
            raise Exception.Create('Specify signature or template, not both');
          templateName := obj.S['signature'];
          if not el.Equals(rec) or (Length(templateName) <> 4) then
            raise Exception.Create('signature creation requires record root and a four-character subrecord signature');
          if rec.ElementByPath[templateName] <> nil then
            raise Exception.Create('Subrecord already exists');
          state := 'possibly_partial';
          created := container.Add(templateName);
          if created = nil then raise Exception.Create('Native Add rejected subrecord signature');
          created.SetToDefaultIfAsCreatedEmpty;
          afterValue := created.EditValue;
        end else begin
        if obj.Types['template'] <> jdtString then raise Exception.Create('template must be a native add template name');
        templateName := obj.S['template'];
        templates := el.GetAssignTemplates(wbAssignAdd);
        template := nil;
        for i := 0 to High(templates) do
          if (templates[i] <> nil) and (templates[i].Name = templateName) then begin
            if template <> nil then raise Exception.Create('Template name is ambiguous');
            template := templates[i];
          end;
        if template = nil then raise Exception.Create('Template is unavailable; query element?templates=1');
        if not el.CanAssign(wbAssignAdd, template, True) then raise Exception.Create('Native CanAssign rejected template');
        state := 'possibly_partial';
        created := el.Assign(wbAssignAdd, template, False);
        if created = nil then raise Exception.Create('Native Assign did not return an element');
        created.SetToDefaultIfAsCreatedEmpty;
        afterValue := created.EditValue;
        end;
      end else if (op = 'remove-element') or (op = 'clear-element') then begin
        if el.Equals(rec) then raise Exception.Create('Record root removal/clear is not an element operation');
        if op = 'remove-element' then begin
          if not el.IsRemovable then raise Exception.Create('Element is not removable');
          state := 'possibly_partial';
          el.Remove;
        end else begin
          if not el.IsClearable then raise Exception.Create('Element is not clearable');
          state := 'possibly_partial';
          el.Clear;
          afterValue := el.EditValue;
        end;
      end else if op = 'set-link' then begin
        if not el.IsEditable or not el.CanContainFormIDs or
           (wbApiGetContainer(el, container) and (container.ElementCount > 0)) or
           el.Equals(rec) then raise Exception.Create('Target must be an editable scalar reference field');
        if obj.Types['source'] <> jdtObject then raise Exception.Create('source must contain file and formID');
        source := obj.O['source'];
        sourceFile := FindPlugin(source.S['file']);
        if (sourceFile = nil) or not wbApiParseFormID(source.S['formID'], fid) then
          raise Exception.Create('Invalid reference source');
        linked := sourceFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
        if linked = nil then raise Exception.Create('Reference source record not found');
        masterFound := SameText(f.FileName, linked._File.FileName);
        for i := 0 to Pred(f.MasterCount[False]) do
          masterFound := masterFound or SameText(f.Masters[i, False].FileName, linked._File.FileName);
        if not masterFound then raise Exception.Create('Add source plugin as master before setting reference');
        state := 'possibly_partial';
        el.LinksTo := linked;
        link := el.LinksTo;
        if (link = nil) or not Supports(link, IwbMainRecord, linked) or
           (linked.LoadOrderFormID.ToCardinal <> fid) then
          raise Exception.Create('Native reference setter did not retain requested FormID');
        afterValue := el.EditValue;
      end else raise Exception.Create('Unsupported element operation');
      rec.UpdateRefs;
      if created <> nil then begin
        displayPath := created.Path;
        for i := 0 to Pred(container.ElementCount) do
          if created.Equals(container.Elements[i]) then begin
            resultPath := path;
            if resultPath <> '' then resultPath := resultPath + '\';
            resultPath := resultPath + IntToStr(i);
            Break;
          end;
      end;
      state := 'applied';
    except
      on E: Exception do Result := E.Message;
    end;
    aResult := '{"state":' + wbApiJsonString(state) +
      ',"before":' + wbApiJsonString(beforeValue) +
      ',"after":' + wbApiJsonString(afterValue) +
      ',"path":' + wbApiJsonString(resultPath) +
      ',"displayPath":' + wbApiJsonString(displayPath) + ',"reversible":false}';
  finally
    obj.Free;
  end;
end;

function TwbApiServer.ExecuteRecordCreate(const aBody: string; out aResult: string): string;
var
  obj: TJsonObject;
  f: IwbFile;
  group, created: IwbElement;
  container: IwbContainerBase;
  rec: IwbMainRecord;
  definition: PwbMainRecordDef;
  signature, edid, state, formID: string;

  function HasEditorID(const node: IwbElement): Boolean;
  var
    recordNode: IwbMainRecord;
    children: IwbContainerBase;
    n: Integer;
  begin
    if Supports(node, IwbMainRecord, recordNode) then
      Exit(SameText(recordNode.EditorID, edid));
    if wbApiGetContainer(node, children) then
      for n := 0 to Pred(children.ElementCount) do
        if HasEditorID(children.Elements[n]) then Exit(True);
    Result := False;
  end;
begin
  Result := '';
  obj := nil;
  formID := '';
  state := 'not_applied';
  try
    try
      obj := wbApiParseObject(aBody);
      if (obj.Types['file'] <> jdtString) or (obj.Types['signature'] <> jdtString) then
        raise Exception.Create('file and signature must be strings');
      if obj.Contains('source') or obj.Contains('values') or obj.Contains('formID') then
        raise Exception.Create('Empty creation accepts no source/values/formID; initialize the returned record afterward');
      f := FindPlugin(obj.S['file']);
      if (f = nil) or not wbEditAllowed or wbTranslationMode then
        raise Exception.Create('Plugin is unavailable or editing is not allowed');
      signature := UpperCase(obj.S['signature']);
      if (Length(signature) <> 4) or not wbFindRecordDef(AnsiString(signature), definition) then
        raise Exception.Create('Unknown record signature for this game');
      if (signature = 'TES4') or (signature = 'PLYR') or (signature = 'CELL') or
         (signature = 'WRLD') or (signature = 'INFO') or (signature = 'LAND') or
         (signature = 'PGRD') or (signature = 'ROAD') or (signature = 'NAVM') or
         (signature = 'REFR') or (signature = 'ACHR') or (signature = 'ACRE') then
        raise Exception.Create('Signature requires specialized parent/header creation');
      edid := '';
      if obj.Contains('editorID') then begin
        if obj.Types['editorID'] <> jdtString then raise Exception.Create('editorID must be a string');
        edid := obj.S['editorID'];
        if edid <> '' then begin
          // Work even when this xEdit session has EDID indexes disabled.
          if HasEditorID(f) then raise Exception.Create('EditorID already exists in destination plugin');
        end;
      end;
      state := 'possibly_partial';
      group := f.Add(signature, True);
      if (group = nil) or not wbApiGetContainer(group, container) then
        raise Exception.Create('Native file Add rejected top-level group');
      created := container.Add(signature, True);
      if (created = nil) or not Supports(created, IwbMainRecord, rec) then
        raise Exception.Create('Native group Add did not return a main record');
      formID := IntToHex(rec.LoadOrderFormID.ToCardinal, 8);
      rec.SetToDefaultIfAsCreatedEmpty;
      if edid <> '' then begin
        if not rec.CanHaveEditorID then raise Exception.Create('Record type cannot have an EditorID');
        rec.EditorID := edid;
      end;
      rec.UpdateRefs;
      state := 'applied';
    except
      on E: Exception do Result := E.Message;
    end;
    aResult := '{"state":' + wbApiJsonString(state) +
      ',"formID":' + wbApiJsonString(formID) + ',"reversible":false}';
  finally
    obj.Free;
  end;
end;

function TwbApiServer.ExecuteRecordRemove(const aBody: string; out aResult: string): string;
var
  obj: TJsonObject;
  f: IwbFile;
  rec, master, winner: IwbMainRecord;
  fid: Cardinal;
  state, formID, edid, mode, masterFile, winningFile: string;
  dryRun: Boolean;
begin
  Result := '';
  obj := nil;
  state := 'not_applied';
  formID := '';
  edid := '';
  mode := '';
  masterFile := '';
  winningFile := '';
  try
    try
      obj := wbApiParseObject(aBody);
      if (obj.Types['file'] <> jdtString) or (obj.Types['formID'] <> jdtString) or
         (obj.Types['expectedEditorID'] <> jdtString) then
        raise Exception.Create('file/formID/expectedEditorID strings are required');
      if obj.Types['mode'] <> jdtString then
        raise Exception.Create('Explicit mode new-record or override is required');
      mode := obj.S['mode'];
      if (mode <> 'new-record') and (mode <> 'override') then
        raise Exception.Create('Unknown record-removal mode');
      dryRun := False;
      if obj.Contains('dryRun') then begin
        if obj.Types['dryRun'] <> jdtBool then raise Exception.Create('dryRun must be boolean');
        dryRun := obj.B['dryRun'];
      end;
      f := FindPlugin(obj.S['file']);
      if (f = nil) or not wbApiParseFormID(obj.S['formID'], fid) then
        raise Exception.Create('Invalid file/formID');
      rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
      if (rec = nil) or not SameText(rec._File.FileName, f.FileName) then
        raise Exception.Create('Record does not belong to destination plugin');
      formID := IntToHex(rec.LoadOrderFormID.ToCardinal, 8);
      edid := rec.EditorID;
      if edid <> obj.S['expectedEditorID'] then
        raise Exception.Create('EditorID precondition failed');
      if not wbEditAllowed or wbTranslationMode or not rec.IsEditable or not rec.IsRemovable then
        raise Exception.Create('Record removal is not allowed');
      if Assigned(rec.ChildGroup) then
        raise Exception.Create('Record has a child group; cascade removal is not implemented');
      if wbApiSignatureToString(rec.Signature) = 'TES4' then
        raise Exception.Create('File header removal is not allowed');
      if mode = 'new-record' then begin
        if not rec.IsMaster or (rec.OverrideCount > 0) then
          raise Exception.Create('Mode new-record requires an original record without overrides');
        if rec.ReferencedByCount > 0 then
          raise Exception.Create('Record has incoming references; detach them before removal');
      end else begin
        if rec.IsMaster or not Assigned(rec.Master) then
          raise Exception.Create('Mode override requires an override, not an original record');
        master := rec.MasterOrSelf;
        winner := master.WinningOverride;
        if not Assigned(winner) then winner := master;
        masterFile := master._File.FileName;
        winningFile := winner._File.FileName;
        if (obj.Types['expectedMasterFile'] <> jdtString) or
           (obj.Types['expectedWinningFile'] <> jdtString) then
          raise Exception.Create('Override removal requires expectedMasterFile/expectedWinningFile strings');
        if not SameText(masterFile, obj.S['expectedMasterFile']) or
           not SameText(winningFile, obj.S['expectedWinningFile']) then
          raise Exception.Create('Override chain precondition failed');
        // Incoming references identify the surviving FormID, not this particular
        // override. Keep the original and all other overrides intact.
      end;
      if not Assigned(wbApiServerRemoveRecordHandler) then
        raise Exception.Create('GUI record-removal handler is unavailable');
      if dryRun then
        state := 'preview'
      else begin
        state := 'possibly_partial';
        wbApiServerRemoveRecordHandler(rec);
        if Assigned(f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True]) then
          raise Exception.Create('Record remains in plugin after native removal');
        if mode = 'override' then begin
          if not Assigned(master._File.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True]) then
            raise Exception.Create('Original record is unavailable after override removal');
          winner := master.WinningOverride;
          if not Assigned(winner) then winner := master;
          winningFile := winner._File.FileName;
        end;
        state := 'applied';
      end;
    except
      on E: Exception do Result := E.Message;
    end;
    aResult := '{"state":' + wbApiJsonString(state) +
      ',"formID":' + wbApiJsonString(formID) + ',"editorID":' + wbApiJsonString(edid) +
      ',"mode":' + wbApiJsonString(mode) + ',"masterFile":' + wbApiJsonString(masterFile) +
      ',"winningFile":' + wbApiJsonString(winningFile) +
      ',"reversible":false}';
  finally
    obj.Free;
  end;
end;

function TwbApiServer.CheckPreconditions(aJob: TwbApiJob): Boolean;
var
  body, condition: TJsonObject;
  checks: TJsonArray;
  f: IwbFile;
  rec: IwbMainRecord;
  el: IwbElement;
  container: IwbContainerElementRef;
  fid: Cardinal;
  i, idx: Integer;
begin
  Result := True;
  if (aJob.Request.Method <> 'POST') or (aJob.Request.Body = '') then Exit;
  body := nil;
  try
    try
      body := wbApiParseObject(aJob.Request.Body);
      if (body = nil) or not body.Contains('preconditions') then Exit;
      Result := False;
      if body.Types['preconditions'] <> jdtArray then
        raise Exception.Create('preconditions must be an array');
      checks := body.A['preconditions'];
      for i := 0 to Pred(checks.Count) do begin
        if checks.Types[i] <> jdtObject then
          raise Exception.Create('Each precondition must be an object');
        condition := checks.O[i];
        if (condition.Types['file'] <> jdtString) or
           (condition.Types['formID'] <> jdtString) or
           (condition.Types['path'] <> jdtString) or
           (condition.Types['equals'] <> jdtString) then
          raise Exception.Create('Preconditions require file/formID/path/equals strings');
        f := FindPlugin(condition.S['file']);
        if (f = nil) or not wbApiParseFormID(condition.S['formID'], fid) then
          raise Exception.Create('Precondition target is unavailable');
        rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
        if rec = nil then raise Exception.Create('Precondition record is unavailable');
        el := ResolveElement(rec, condition.S['path'], container, idx);
        if (el = nil) or (el.EditValue <> condition.S['equals']) then begin
          RespondError(aJob, 409, 'precondition_failed',
            'Precondition failed at index ' + IntToStr(i) + '; no operations executed');
          Exit;
        end;
      end;
      Result := True;
    except
      on E: Exception do begin
        Result := False;
        RespondError(aJob, 400, 'bad_preconditions', E.Message);
      end;
    end;
  finally
    body.Free;
  end;
end;

function TwbApiServer.StructuralSnapshot(const aFile: IwbFile;
  const aRecord: IwbMainRecord; out aNodes: string): string;
var
  nodes: TStringBuilder;
  count: Integer;
  raw: string;
  procedure Walk(const el: IwbElement; const path: string; depth: Integer);
  var
    children: IwbContainerBase;
    n, childCount: Integer;
    childPath: string;
  begin
    if (depth > 128) or (count >= 16384) then
      raise Exception.Create('Structural snapshot exceeds depth/node limit');
    childCount := 0;
    if wbApiGetContainer(el, children) then childCount := children.ElementCount;
    if count > 0 then nodes.Append(',');
    Inc(count);
    nodes.Append(wbApiJsonString(path)).Append(':{"name":').Append(wbApiJsonString(el.Name));
    nodes.Append(',"editValue":').Append(wbApiJsonString(el.EditValue));
    nodes.Append(',"childCount":').Append(childCount).Append('}');
    if nodes.Length > 2 * 1024 * 1024 then
      raise Exception.Create('Structural snapshot exceeds 2 MiB node limit');
    for n := 0 to childCount - 1 do begin
      childPath := IntToStr(n);
      if path <> '' then childPath := path + '\' + childPath;
      Walk(children.Elements[n], childPath, depth + 1);
    end;
  end;
begin
  nodes := TStringBuilder.Create;
  try
    // Native serialization can normalize headers/rebuild containers. Capture
    // bytes first so node values and retained child identities follow it.
    raw := aRecord.RawDataAsString;
    count := 0;
    nodes.Append('{');
    Walk(aRecord, '', 0);
    nodes.Append('}');
    aNodes := nodes.ToString;
    Result := PluginToJson(aFile, 0) + #10 + raw + #10 + aNodes;
    if Length(Result) > 4 * 1024 * 1024 then
      raise Exception.Create('Structural snapshot exceeds 4 MiB total limit');
  finally
    nodes.Free;
  end;
end;

procedure TwbApiServer.HandleElementChangeSet(aJob: TwbApiJob; const aID: string;
  aChangeSet: TwbApiChangeSet; aRollback: Boolean);
var
  body, resultObj: TJsonObject;
  cs: TwbApiChangeSet;
  f: IwbFile;
  rec, originalLink: IwbMainRecord;
  linkFile: IwbFile;
  parentEl, candidate, linkedElement: IwbElement;
  parentRef: IwbContainerElementRef;
  parent: IwbContainerBase;
  oldChildren: TArray<IwbElement>;
  fid: Cardinal;
  idx, i, j, newCount: Integer;
  id, operationResult, errorText, nodes, current: string;
  guid: TGUID;
  owned, existed: Boolean;

  function ElementFingerprint(const el: IwbElement; depth: Integer): string;
  var
    children: IwbContainerBase;
    n: Integer;
  begin
    if depth > 128 then raise Exception.Create('Element fingerprint exceeds depth limit');
    Result := wbApiJsonString(el.Name) + ':' + wbApiJsonString(el.EditValue);
    if wbApiGetContainer(el, children) then
      for n := 0 to children.ElementCount - 1 do
        Result := Result + '[' + ElementFingerprint(children.Elements[n], depth + 1) + ']';
    if Length(Result) > 2 * 1024 * 1024 then raise Exception.Create('Element fingerprint exceeds size limit');
  end;

  function LocateAdded(const el: IwbElement; const path: string): Boolean;
  var
    children: IwbContainerBase;
    n: Integer;
    childPath: string;
  begin
    if el.Equals(cs.AddedElement) then begin cs.AddedPath := path; Exit(True); end;
    if wbApiGetContainer(el, children) then
      for n := 0 to children.ElementCount - 1 do begin
        childPath := IntToStr(n);
        if path <> '' then childPath := path + '\' + childPath;
        if LocateAdded(children.Elements[n], childPath) then Exit(True);
      end;
    Result := False;
  end;

  procedure Reply;
  var
    beforeObj, afterObj: TJsonObject;
    diff: TStringBuilder;
    key, beforeNode, afterNode: string;
    n: Integer;
    comma: Boolean;
    procedure Entry(const path, beforeValue, afterValue: string);
    begin
      if beforeValue = afterValue then Exit;
      if comma then diff.Append(',');
      comma := True;
      diff.Append('{"path":').Append(wbApiJsonString(path));
      diff.Append(',"before":').Append(beforeValue).Append(',"after":').Append(afterValue).Append('}');
    end;
  begin
    beforeObj := nil;
    afterObj := nil;
    diff := TStringBuilder.Create;
    try
      beforeObj := wbApiParseObject(cs.BeforeNodes);
      afterObj := wbApiParseObject(cs.AfterNodes);
      comma := False;
      for n := 0 to beforeObj.Count - 1 do begin
        key := beforeObj.Names[n];
        beforeNode := beforeObj.O[key].ToJSON;
        afterNode := 'null';
        if afterObj.Contains(key) then afterNode := afterObj.O[key].ToJSON;
        Entry(key, beforeNode, afterNode);
      end;
      for n := 0 to afterObj.Count - 1 do begin
        key := afterObj.Names[n];
        if not beforeObj.Contains(key) then Entry(key, 'null', afterObj.O[key].ToJSON);
      end;
      RespondJson(aJob, 200, '{"ok":' + wbApiJsonBool(cs.ErrorText = '') +
        ',"changeSetID":' + wbApiJsonString(id) + ',"state":' + wbApiJsonString(cs.State) +
        ',"error":' + wbApiJsonString(cs.ErrorText) +
        ',"diffComplete":' + wbApiJsonBool(cs.DiffComplete) +
        ',"recordOrMetadataChanged":' + wbApiJsonBool((cs.AfterTree <> '') and (cs.BeforeTree <> cs.AfterTree)) +
        ',"diffScope":"whole_record_positional_nodes","rollbackVerification":"raw_record_tree_and_plugin_metadata"' +
        ',"reversible":' + wbApiJsonBool((cs.State = 'applied') or (cs.State = 'rolled_back')) +
        ',"changes":[' + diff.ToString + ']}');
    finally
      beforeObj.Free;
      afterObj.Free;
      diff.Free;
    end;
  end;
begin
  cs := aChangeSet;
  body := nil;
  resultObj := nil;
  owned := False;
  id := aID;
  try
    try
      if cs <> nil then begin
        if not aRollback then begin
          if aJob.Request.Method <> 'GET' then
            RespondError(aJob, 405, 'method_not_allowed', 'Use GET to inspect a changeset')
          else Reply;
          Exit;
        end;
        if aJob.Request.Method <> 'POST' then begin
          RespondError(aJob, 405, 'method_not_allowed', 'Rollback requires POST'); Exit;
        end;
        if cs.State = 'rolled_back' then begin Reply; Exit; end;
        if cs.State <> 'applied' then begin
          RespondError(aJob, 409, 'rollback_unavailable', 'Structural changeset is not verified reversible'); Exit;
        end;
        f := FindPlugin(cs.FileName);
        if (f = nil) or not wbApiParseFormID(cs.FormID, fid) then
          raise Exception.Create('Target plugin is unavailable');
        rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
        if (rec = nil) or not rec.IsEditable or not wbEditAllowed or wbTranslationMode then
          raise Exception.Create('Record is unavailable or not editable');
        current := StructuralSnapshot(f, rec, nodes);
        if current <> cs.AfterTree then begin
          RespondError(aJob, 409, 'rollback_conflict', 'Record or plugin metadata changed; no rollback edits made'); Exit;
        end;
        // Snapshot serialization rebuilds native element objects. Re-resolve
        // only after the complete after-state has matched, then check subtree.
        candidate := ResolveElement(rec, cs.AddedPath, parentRef, idx);
        if (cs.AddedPath = '') or (candidate = nil) then
          raise Exception.Create('Changed element is unavailable');
        if ElementFingerprint(candidate, 0) <> cs.AddedFingerprint then begin
          RespondError(aJob, 409, 'rollback_conflict', 'Added element subtree does not match the captured state'); Exit;
        end;
        if cs.Kind = 'set-link' then begin
          if not candidate.IsEditable then raise Exception.Create('Reference field is not editable');
          if cs.OriginalLinkWasNull then begin
            cs.State := 'rollback_failed';
            candidate.LinksTo := nil;
            if (candidate.LinksTo <> nil) or not VarIsNumeric(candidate.NativeValue) or
               (candidate.NativeValue <> 0) then
              raise Exception.Create('Native setter did not restore null reference');
          end else begin
          linkFile := FindPlugin(cs.OriginalLinkFile);
          if (linkFile = nil) or not wbApiParseFormID(cs.OriginalLinkID, fid) then
            raise Exception.Create('Original reference plugin is unavailable');
          originalLink := linkFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
          if (originalLink = nil) or not candidate.IsEditable then
            raise Exception.Create('Original reference record is unavailable');
          cs.State := 'rollback_failed';
          candidate.LinksTo := originalLink;
          end;
        end else begin
          if not candidate.IsRemovable then raise Exception.Create('Added element is not removable');
          cs.State := 'rollback_failed';
          candidate.Remove;
        end;
        rec.UpdateRefs;
        if StructuralSnapshot(f, rec, nodes) <> cs.BeforeTree then
          raise Exception.Create('Native removal completed but whole-record restoration verification failed');
        cs.AddedElement := nil;
        cs.State := 'rolled_back';
        cs.ErrorText := '';
        Reply; Exit;
      end;
      if aJob.Request.Method <> 'POST' then begin
        RespondError(aJob, 405, 'method_not_allowed', 'Create an element changeset with POST'); Exit;
      end;
      if FChangeSets.Count >= 128 then begin
        RespondError(aJob, 503, 'changeset_capacity', 'Session changeset capacity reached'); Exit;
      end;
      if Length(aJob.Request.Body) > 256 * 1024 then raise Exception.Create('Request exceeds 256 KiB');
      body := wbApiParseObject(aJob.Request.Body);
      if (body.Types['op'] <> jdtString) or
         ((body.S['op'] <> 'add-element') and (body.S['op'] <> 'set-link')) then
        raise Exception.Create('Structural changesets support add-element and set-link');
      if body.Contains('dryRun') then raise Exception.Create('Structural dryRun is not implemented');
      if (body.Types['file'] <> jdtString) or (body.Types['formID'] <> jdtString) or
         (body.Types['path'] <> jdtString) then raise Exception.Create('file/formID/path strings are required');
      f := FindPlugin(body.S['file']);
      if (f = nil) or not wbApiParseFormID(body.S['formID'], fid) then raise Exception.Create('Invalid file/formID');
      if f.IsLocalized then raise Exception.Create('Localized structural rollback requires string-table snapshots');
      rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
      if (rec = nil) or not rec.IsEditable or not wbEditAllowed or wbTranslationMode then
        raise Exception.Create('Record is unavailable or not editable');
      parentEl := ResolveElement(rec, body.S['path'], parentRef, idx);
      if (parentEl = nil) or not wbApiGetContainer(parentEl, parent) then
        raise Exception.Create('Parent container is unavailable');
      cs := TwbApiChangeSet.Create;
      owned := True;
      cs.Kind := body.S['op']; cs.FileName := f.FileName; cs.FormID := body.S['formID'];
      cs.BeforeTree := StructuralSnapshot(f, rec, cs.BeforeNodes);
      parentEl := ResolveElement(rec, body.S['path'], parentRef, idx);
      if (parentEl = nil) or not wbApiGetContainer(parentEl, parent) then
        raise Exception.Create('Parent container changed while taking snapshot');
      SetLength(oldChildren, parent.ElementCount);
      for i := 0 to High(oldChildren) do oldChildren[i] := parent.Elements[i];
      if cs.Kind = 'set-link' then begin
        if (parent.ElementCount > 0) or not parentEl.IsEditable or not parentEl.CanContainFormIDs then
          raise Exception.Create('set-link requires an editable scalar reference');
        linkedElement := parentEl.LinksTo;
        if linkedElement = nil then begin
          if not VarIsNumeric(parentEl.NativeValue) or (parentEl.NativeValue <> 0) then
            raise Exception.Create('Unresolved nonzero original references are not reversible');
          cs.OriginalLinkWasNull := True;
        end else begin
          if not Supports(linkedElement, IwbMainRecord, originalLink) then
            raise Exception.Create('Original reference is not a main record');
          cs.OriginalLinkFile := originalLink._File.FileName;
          cs.OriginalLinkID := IntToHex(originalLink.LoadOrderFormID.ToCardinal, 8);
        end;
      end;
      cs.AfterNodes := cs.BeforeNodes;
      CreateGUID(guid); id := GUIDToString(guid);
      FChangeSets.Add(id, cs); owned := False;
      cs.State := 'partial';
      errorText := ExecuteElementOp(aJob.Request.Body, operationResult);
      cs.ErrorText := errorText;
      resultObj := wbApiParseObject(operationResult);
      if resultObj.S['state'] = 'not_applied' then cs.State := 'not_applied';
      if (errorText = '') and (cs.Kind = 'set-link') then begin
        cs.AddedElement := parentEl;
        if not LocateAdded(rec, '') then
          cs.ErrorText := 'Changed reference element cannot be located; rollback unavailable'
        else begin
          cs.AddedFingerprint := ElementFingerprint(parentEl, 0);
          cs.State := 'applied';
        end;
      end else if errorText = '' then begin
        newCount := 0;
        for i := 0 to parent.ElementCount - 1 do begin
          candidate := parent.Elements[i]; existed := False;
          for j := 0 to High(oldChildren) do
            if candidate.Equals(oldChildren[j]) then existed := True;
          if not existed then begin Inc(newCount); cs.AddedElement := candidate; end;
        end;
        if (newCount <> 1) or (parent.ElementCount <> Length(oldChildren) + 1) or
           (cs.AddedElement = nil) or not cs.AddedElement.IsRemovable then
          cs.ErrorText := Format('Native add eligibility failed: newChildren=%d, beforeCount=%d, afterCount=%d; rollback unavailable',
            [newCount, Length(oldChildren), parent.ElementCount])
        else if not LocateAdded(rec, '') then
          cs.ErrorText := 'Cannot locate added element before snapshot; rollback unavailable'
        else begin
          cs.AddedFingerprint := ElementFingerprint(cs.AddedElement, 0);
          cs.State := 'applied';
        end;
      end;
      cs.AfterTree := StructuralSnapshot(f, rec, cs.AfterNodes);
      cs.DiffComplete := True;
      if cs.State = 'applied' then begin
        candidate := ResolveElement(rec, cs.AddedPath, parentRef, idx);
        if (candidate = nil) or
           ((cs.Kind = 'add-element') and not candidate.IsRemovable) or
           (ElementFingerprint(candidate, 0) <> cs.AddedFingerprint) then begin
          cs.State := 'partial';
          cs.ErrorText := 'Added element location/content changed during normalization; rollback unavailable';
        end;
      end;
      cs.AddedElement := nil;
      Reply;
    except
      on E: Exception do begin
        if (cs <> nil) and not owned then begin
          cs.ErrorText := E.Message;
          Reply;
        end else RespondError(aJob, 400, 'element_changeset_error', E.Message);
      end;
    end;
  finally
    if owned then cs.Free;
    body.Free; resultObj.Free;
  end;
end;

procedure TwbApiServer.HandleChangeSet(aJob: TwbApiJob; const aID: string;
  aRollback: Boolean);
var
  body, values, expected: TJsonObject;
  cs: TwbApiChangeSet;
  f: IwbFile;
  rec: IwbMainRecord;
  el: IwbElement;
  container: IwbContainerElementRef;
  base: IwbContainerBase;
  targets: TArray<IwbElement>;
  fid: Cardinal;
  idx, i, j: Integer;
  id, name, errorText, initialTree: string;
  guid: TGUID;
  dryRun, owned: Boolean;

  function Snapshot: string;
    function Walk(const node: IwbElement; depth: Integer): string;
    var
      children: IwbContainerBase;
      n: Integer;
    begin
      if depth > 128 then raise Exception.Create('Record exceeds snapshot depth limit');
      Result := wbApiJsonString(node.Name) + ':' + wbApiJsonString(node.EditValue);
      if wbApiGetContainer(node, children) then
        for n := 0 to Pred(children.ElementCount) do
          Result := Result + '[' + Walk(children.Elements[n], depth + 1) + ']';
    end;
  begin
    // Include raw bytes as well as the displayed tree. Do not silently accept
    // a matching display value after a different raw/structural edit.
    Result := PluginToJson(f, 0) + #10 + rec.RawDataAsString + #10 + Walk(rec, 0);
    if Length(Result) > 1024 * 1024 then
      raise Exception.Create('Record exceeds 1 MiB snapshot limit');
  end;

  procedure Reply;
  var
    json: TStringBuilder;
    n: Integer;
  begin
    json := TStringBuilder.Create;
    try
      json.Append('{"ok":').Append(wbApiJsonBool(errorText = ''));
      json.Append(',"changeSetID":').Append(wbApiJsonString(id));
      json.Append(',"state":').Append(wbApiJsonString(cs.State));
      json.Append(',"diffScope":"requested_fields","rollbackVerification":"whole_record_and_plugin_metadata"');
      json.Append(',"error":').Append(wbApiJsonString(errorText));
      json.Append(',"changes":[');
      for n := 0 to High(cs.Changes) do begin
        if n > 0 then json.Append(',');
        json.Append('{"file":').Append(wbApiJsonString(cs.Changes[n].FileName));
        json.Append(',"formID":').Append(wbApiJsonString(cs.Changes[n].FormID));
        json.Append(',"path":').Append(wbApiJsonString(cs.Changes[n].Path));
        json.Append(',"before":').Append(wbApiJsonString(cs.Changes[n].BeforeValue));
        json.Append(',"after":').Append(wbApiJsonString(cs.Changes[n].AfterValue)).Append('}');
      end;
      json.Append(']}');
      RespondJson(aJob, 200, json.ToString);
    finally
      json.Free;
    end;
  end;

begin
  body := nil;
  cs := nil;
  owned := False;
  errorText := '';
  id := aID;
  try
   try
    if aID <> '' then begin
      if not FChangeSets.TryGetValue(aID, cs) then begin
        RespondError(aJob, 404, 'not_found', 'Changeset not found in this process session');
        Exit;
      end;
      if cs.Kind <> '' then begin
        HandleElementChangeSet(aJob, aID, cs, aRollback);
        Exit;
      end;
      if not aRollback then begin
        if aJob.Request.Method <> 'GET' then
          RespondError(aJob, 405, 'method_not_allowed', 'Use GET to inspect a changeset')
        else
          Reply;
        Exit;
      end;
      if aJob.Request.Method <> 'POST' then begin
        RespondError(aJob, 405, 'method_not_allowed', 'Rollback requires POST');
        Exit;
      end;
      if cs.State = 'rolled_back' then begin
        Reply;
        Exit;
      end;
      if (cs.State <> 'applied') and (cs.State <> 'partial') then begin
        RespondError(aJob, 409, 'rollback_unavailable', 'Changeset is not in a reversible state');
        Exit;
      end;
      f := FindPlugin(cs.Changes[0].FileName);
      if (f = nil) or not wbApiParseFormID(cs.Changes[0].FormID, fid) then
        raise Exception.Create('Target plugin is no longer available');
      rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
      if (rec = nil) or not rec.IsEditable then
        raise Exception.Create('Target record is unavailable or read-only');
      if Snapshot <> cs.AfterTree then begin
        RespondError(aJob, 409, 'rollback_conflict', 'Record changed after this changeset; no rollback edits were made');
        Exit;
      end;
      SetLength(targets, Length(cs.Changes));
      for i := 0 to High(targets) do begin
        targets[i] := ResolveElement(rec, cs.Changes[i].Path, container, idx);
        if (targets[i] = nil) or not targets[i].IsEditable then
          raise Exception.Create('Rollback path unavailable: ' + cs.Changes[i].Path);
      end;
      cs.State := 'rollback_failed';
      try
        for i := High(targets) downto 0 do begin
          el := ResolveElement(rec, cs.Changes[i].Path, container, idx);
          if (el = nil) or not el.IsEditable then
            raise Exception.Create('Rollback target changed while restoring fields');
          el.EditValue := cs.Changes[i].BeforeValue;
        end;
        if Snapshot <> cs.BeforeTree then
          raise Exception.Create('Restored fields but complete record verification failed');
        cs.State := 'rolled_back';
      except
        on E: Exception do errorText := E.Message;
      end;
      Reply;
      Exit;
    end;

    if aJob.Request.Method <> 'POST' then begin
      RespondError(aJob, 405, 'method_not_allowed', 'Create a changeset with POST');
      Exit;
    end;
    if FChangeSets.Count >= 128 then begin
      RespondError(aJob, 503, 'changeset_capacity', 'Session changeset capacity reached');
      Exit;
    end;
    if Length(aJob.Request.Body) > 256 * 1024 then
      raise Exception.Create('Changeset request exceeds 256 KiB limit');
    body := wbApiParseObject(aJob.Request.Body);
    if body = nil then raise Exception.Create('Expected JSON object');
    if (body.Types['values'] <> jdtObject) or (body.Types['expected'] <> jdtObject) then
      raise Exception.Create('values and expected must be objects containing edit-value strings');
    values := body.O['values'];
    expected := body.O['expected'];
    if (values.Count = 0) or (values.Count > 256) or (values.Count <> expected.Count) then
      raise Exception.Create('Provide 1..256 values and one expected value for every path');
    f := FindPlugin(body.S['file']);
    if (f = nil) or not wbApiParseFormID(body.S['formID'], fid) then
      raise Exception.Create('Invalid target file/formID');
    if f.IsLocalized then
      raise Exception.Create('Localized plugins require string-table snapshots and are not supported');
    rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
    if (rec = nil) or not rec.IsEditable then
      raise Exception.Create('Target record is missing or read-only');
    if body.Contains('dryRun') and (body.Types['dryRun'] <> jdtBool) then
      raise Exception.Create('dryRun must be Boolean');
    dryRun := body.B['dryRun'];
    cs := TwbApiChangeSet.Create;
    owned := True;
    SetLength(cs.Changes, values.Count);
    SetLength(targets, values.Count);
    initialTree := Snapshot;
    for i := 0 to Pred(values.Count) do begin
      name := values.Names[i];
      if (values.Types[name] <> jdtString) or (expected.Types[name] <> jdtString) then
        raise Exception.Create('values and expected entries must be strings: ' + name);
      el := ResolveElement(rec, name, container, idx);
      if (el = nil) or not el.IsEditable or el.CanContainFormIDs then
        raise Exception.Create('Only editable scalar fields without FormID references are supported: ' + name);
      if wbApiGetContainer(el, base) and (base.ElementCount > 0) then
        raise Exception.Create('Container edits require structural snapshots and are not supported');
      for j := 0 to i - 1 do
        if el.Equals(targets[j]) then
          raise Exception.Create('Duplicate target through path aliases: ' + name);
      targets[i] := el;
      if el.EditValue <> expected.S[name] then begin
        RespondError(aJob, 409, 'precondition_failed', 'Expected value differs at ' + name);
        Exit;
      end;
      cs.Changes[i].FileName := f.FileName;
      cs.Changes[i].FormID := IntToHex(fid, 8);
      cs.Changes[i].Path := name;
      cs.Changes[i].BeforeValue := el.EditValue;
      cs.Changes[i].AfterValue := values.S[name];
    end;
    cs.BeforeTree := initialTree;
    cs.State := 'preview';
    if dryRun then begin
      Reply;
      Exit;
    end;
    CreateGUID(guid);
    id := GUIDToString(guid);
    FChangeSets.Add(id, cs);
    owned := False;
    cs.State := 'partial';
    try
      for i := 0 to High(targets) do begin
        el := ResolveElement(rec, cs.Changes[i].Path, container, idx);
        if (el = nil) or not el.IsEditable or
           (el.EditValue <> cs.Changes[i].BeforeValue) then
          raise Exception.Create('Target changed during application: ' + cs.Changes[i].Path);
        el.EditValue := cs.Changes[i].AfterValue;
      end;
      cs.State := 'applied';
    except
      on E: Exception do errorText := E.Message;
    end;
    // Capture actual values, including normalization and partially applied setters.
    for i := 0 to High(targets) do begin
      el := ResolveElement(rec, cs.Changes[i].Path, container, idx);
      if el = nil then raise Exception.Create('Target disappeared during application');
      cs.Changes[i].AfterValue := el.EditValue;
    end;
    cs.AfterTree := Snapshot;
    Reply;
  except
    on E: Exception do begin
      if (cs <> nil) and not owned then begin
        errorText := E.Message;
        Reply;
      end else
        RespondError(aJob, 400, 'changeset_error', E.Message);
    end;
  end;
  finally
    if owned then cs.Free;
    body.Free;
  end;
end;

function TwbApiServer.PluginToJson(const aFile: IwbFile; aIndex: Integer): string;

  procedure AppendMasters(aSB: TStringBuilder; const aProp: string;
                          aCount: Integer;
                          aGet: TFunc<Integer, IwbFile>);
  var
    j : Integer;
  begin
    aSB.Append(',').Append(wbApiJsonString(aProp)).Append(':[');
    for j := 0 to Pred(aCount) do begin
      if j > 0 then
        aSB.Append(',');
      aSB.Append(wbApiJsonString(aGet(j).FileName));
    end;
    aSB.Append(']');
  end;

var
  sb : TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    sb.Append('{');
    sb.Append('"index":').Append(aIndex);
    sb.Append(',"fileName":').Append(wbApiJsonString(aFile.FileName));
    sb.Append(',"fileID":').Append(wbApiJsonString(aFile.LoadOrderFileID.ToString));
    sb.Append(',"loadOrder":').Append(aFile.LoadOrder);
    sb.Append(',"isESM":').Append(wbApiJsonBool(aFile.IsESM));
    sb.Append(',"isLight":').Append(wbApiJsonBool(aFile.IsLight));
    sb.Append(',"isMedium":').Append(wbApiJsonBool(aFile.IsMedium));
    sb.Append(',"isUpdate":').Append(wbApiJsonBool(aFile.IsUpdate));
    sb.Append(',"isBlueprint":').Append(wbApiJsonBool(aFile.IsBlueprint));
    sb.Append(',"isLocalized":').Append(wbApiJsonBool(aFile.IsLocalized));
    sb.Append(',"isNotPlugin":').Append(wbApiJsonBool(aFile.IsNotPlugin));
    sb.Append(',"masterCount":').Append(aFile.MasterCount[False]);
    AppendMasters(sb, 'masters', aFile.MasterCount[False],
      function(j: Integer): IwbFile
      begin
        Result := aFile.Masters[j, False];
      end);
    sb.Append(',"fullMasterCount":').Append(aFile.FullMasterCount[False]);
    AppendMasters(sb, 'fullMasters', aFile.FullMasterCount[False],
      function(j: Integer): IwbFile
      begin
        Result := aFile.FullMasters[j, False];
      end);
    sb.Append(',"mediumMasterCount":').Append(aFile.MediumMasterCount[False]);
    AppendMasters(sb, 'mediumMasters', aFile.MediumMasterCount[False],
      function(j: Integer): IwbFile
      begin
        Result := aFile.MediumMasters[j, False];
      end);
    sb.Append(',"lightMasterCount":').Append(aFile.LightMasterCount[False]);
    AppendMasters(sb, 'lightMasters', aFile.LightMasterCount[False],
      function(j: Integer): IwbFile
      begin
        Result := aFile.LightMasters[j, False];
      end);
    sb.Append('}');
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

{ ------------------- record level JSON (M2) ------------------------------- }

function TwbApiServer.RecordMetaJson(const aRecord: IwbMainRecord; aWithNames: Boolean): string;
var
  sb : TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    sb.Append('{');
    sb.Append('"containingFile":').Append(wbApiJsonString(aRecord._File.FileName));
    sb.Append(',"signature":').Append(wbApiJsonString(wbApiSignatureToString(aRecord.Signature)));
    sb.Append(',"formID":').Append(wbApiJsonString(IntToHex(aRecord.FormID.ToCardinal, 8)));
    sb.Append(',"loadOrderFormID":').Append(wbApiJsonString(IntToHex(aRecord.LoadOrderFormID.ToCardinal, 8)));
    if aWithNames then begin
      sb.Append(',"editorID":').Append(wbApiJsonString(aRecord.EditorID));
      sb.Append(',"fullName":').Append(wbApiJsonString(aRecord.FullName));
    end;
    sb.Append(',"isMaster":').Append(wbApiJsonBool(aRecord.IsMaster));
    sb.Append(',"isWinningOverride":').Append(wbApiJsonBool(aRecord.IsWinningOverride));
    sb.Append(',"isDeleted":').Append(wbApiJsonBool(aRecord.IsDeleted));
    sb.Append(',"isPersistent":').Append(wbApiJsonBool(aRecord.IsPersistent));
    sb.Append('}');
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

function TwbApiServer.RecordChainJson(const aRecord: IwbMainRecord): string;
var
  sb     : TStringBuilder;
  master : IwbMainRecord;
  ovr    : IwbMainRecord;
  m      : IwbMainRecord;
  k, cnt : Integer;
begin
  master := aRecord;
  if not master.IsMaster then begin
    m := master.Master;
    if m <> nil then
      master := m;
  end;

  sb := TStringBuilder.Create;
  try
    cnt := master.OverrideCount;
    sb.Append('{"ok":true,"requested":').Append(RecordMetaJson(aRecord, True));
    sb.Append(',"master":').Append(RecordMetaJson(master, True));
    sb.Append(',"overrideCount":').Append(cnt);
    sb.Append(',"overrides":[');
    for k := 0 to Pred(cnt) do begin
      if k > 0 then
        sb.Append(',');
      ovr := master.Overrides[k];
      sb.Append(RecordMetaJson(ovr, False));
    end;
    sb.Append('],"winningOverride":');
    ovr := master.WinningOverride;
    if ovr <> nil then
      sb.Append(RecordMetaJson(ovr, False))
    else
      sb.Append('null');
    sb.Append('}');
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

function TwbApiServer.RecordsPageJson(aFile: IwbFile; const aSignature, aEditorID: string;
                                      aOffset, aLimit: Integer; aWithNames: Boolean;
                                      out aReturned, aMore: Integer): string;
var
  sb        : TStringBuilder;
  el, el2   : IwbElement;
  grp       : IwbGroupRecord;
  rec       : IwbMainRecord;
  i, j      : Integer;
  seen      : Integer;
  wantName  : Boolean;
begin
  aReturned := 0;
  aMore     := 0;
  seen      := 0;
  wantName  := aWithNames or (aEditorID <> '');
  sb := TStringBuilder.Create;
  try
    for i := 0 to Pred(aFile.ElementCount) do begin
      el := aFile.Elements[i];
      if not Supports(el, IwbGroupRecord, grp) then
        Continue;

      for j := 0 to Pred(grp.ElementCount) do begin
        el2 := grp.Elements[j];
        if not Supports(el2, IwbMainRecord, rec) then
          Continue;

        if (aSignature <> '') and
           not SameText(aSignature, wbApiSignatureToString(rec.Signature)) then
          Continue;
        if (aEditorID <> '') and not ContainsText(rec.EditorID, aEditorID) then
          Continue;

        if seen >= aOffset then begin
          if aReturned < aLimit then begin
            if aReturned > 0 then
              sb.Append(',');
            sb.Append(RecordMetaJson(rec, wantName));
            Inc(aReturned);
          end else begin
            aMore := 1;          // more matches exist past this page
            Break;
          end;
        end;
        Inc(seen);
      end;
      if aMore <> 0 then
        Break;
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

procedure TwbApiServer.HandlePluginRecords(aJob: TwbApiJob; const aFile: IwbFile);
var
  q        : string;
  sig, edid: string;
  offset   : Integer;
  limit    : Integer;
  withName : Boolean;
  returned : Integer;
  more     : Integer;
  arr      : string;
begin
  q := aJob.Request.Query;
  sig := UpperCase(Trim(wbApiQueryParam(q, 'signature')));
  edid := wbApiQueryParam(q, 'editorID');
  offset := StrToIntDef(wbApiQueryParam(q, 'offset'), 0);
  if offset < 0 then
    offset := 0;
  limit := StrToIntDef(wbApiQueryParam(q, 'limit'), 100);
  if limit < 1 then
    limit := 1;
  if limit > 500 then
    limit := 500;
  withName := (wbApiQueryParam(q, 'names') = '1') or SameText(wbApiQueryParam(q, 'names'), 'true');

  arr := RecordsPageJson(aFile, sig, edid, offset, limit, withName, returned, more);

  RespondJson(aJob, 200,
    '{"ok":true,"plugin":' + wbApiJsonString(aFile.FileName) +
    ',"signatureFilter":' + wbApiJsonString(sig) +
    ',"returned":' + IntToStr(returned) +
    ',"hasMore":' + wbApiJsonBool(more > 0) +
    ',"records":[' + arr + ']}');
end;

procedure TwbApiServer.HandlePluginRecord(aJob: TwbApiJob; const aFile: IwbFile;
                                          const aFormID: TwbFormID);
var
  rec : IwbMainRecord;
begin
  rec := aFile.ContainedRecordByLoadOrderFormID[aFormID, True];
  if rec = nil then begin
    RespondError(aJob, 404, 'not_found',
      'Record not found in ' + aFile.FileName + ': ' + IntToHex(aFormID.ToCardinal, 8));
    Exit;
  end;
  RespondJson(aJob, 200, RecordChainJson(rec));
end;

function TwbApiServer.ElementToJson(const aElement: IwbElement; aDepth: Integer): string;
var
  sb     : TStringBuilder;
  cef    : IwbContainerElementRef;
  c      : IwbContainerBase;
  i, cnt : Integer;
  v      : string;
begin
  sb := TStringBuilder.Create;
  try
    sb.Append('{"name":').Append(wbApiJsonString(aElement.Name));
    sb.Append(',"path":').Append(wbApiJsonString(aElement.Path));

    cnt := -1;
    if Supports(aElement, IwbContainerElementRef, cef) then
      cnt := cef.ElementCount
    else if wbApiGetContainer(aElement, c) then
      cnt := c.ElementCount;

    if (aDepth > 0) and (cnt > 0) then begin
      sb.Append(',"children":[');
      for i := 0 to Pred(cnt) do begin
        if i > 0 then
          sb.Append(',');
        if Supports(aElement, IwbContainerElementRef, cef) then
          sb.Append(ElementToJson(cef.Elements[i], aDepth - 1))
        else
          sb.Append(ElementToJson(c.Elements[i], aDepth - 1));
      end;
      sb.Append(']');
    end else begin
      // leaf (or container that could not enumerate children): expose its value
      try
        v := aElement.Value;
      except
        v := '';
      end;
      sb.Append(',"value":').Append(wbApiJsonString(v));
    end;
    sb.Append('}');
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

procedure TwbApiServer.HandleRecordTree(aJob: TwbApiJob; const aFile: IwbFile;
                                        const aFormID: TwbFormID);
var
  rec   : IwbMainRecord;
  depth : Integer;
  q     : string;
begin
  rec := aFile.ContainedRecordByLoadOrderFormID[aFormID, True];
  if rec = nil then begin
    RespondError(aJob, 404, 'not_found',
      'Record not found in ' + aFile.FileName + ': ' + IntToHex(aFormID.ToCardinal, 8));
    Exit;
  end;

  q := wbApiQueryParam(aJob.Request.Query, 'depth');
  depth := StrToIntDef(q, 8);
  if depth < 1 then
    depth := 1;
  if depth > 20 then
    depth := 20;

  RespondJson(aJob, 200,
    '{"ok":true,"plugin":' + wbApiJsonString(aFile.FileName) +
    ',"loadOrderFormID":' + wbApiJsonString(IntToHex(aFormID.ToCardinal, 8)) +
    ',"depth":' + IntToStr(depth) +
    ',"tree":' + MainRecordToJson(rec, depth) + '}');
end;

// Root node of a record tree. The main record's container methods are used
// through its declared interface chain (static upcast), which avoids runtime
// Supports/QueryInterface quirks on the record root object.
function TwbApiServer.MainRecordToJson(const aRecord: IwbMainRecord; aDepth: Integer): string;
var
  sb : TStringBuilder;
  cb : IwbContainerBase;
  i  : Integer;
begin
  sb := TStringBuilder.Create;
  try
    sb.Append('{"name":').Append(wbApiJsonString(aRecord.Name));
    sb.Append(',"path":').Append(wbApiJsonString(aRecord.Path));
    if aDepth > 0 then begin
      cb := aRecord; // static upcast: IwbMainRecord inherits IwbContainerBase
      sb.Append(',"children":[');
      for i := 0 to Pred(cb.ElementCount) do begin
        if i > 0 then
          sb.Append(',');
        sb.Append(ElementToJson(cb.Elements[i], aDepth - 1));
      end;
      sb.Append(']');
    end else
      sb.Append(',"value":').Append(wbApiJsonString(''));
    sb.Append('}');
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

procedure TwbApiServer.HandleRecordValues(aJob: TwbApiJob; const aFile: IwbFile;
                                          const aFormID: TwbFormID);
var
  rec    : IwbMainRecord;
  jo     : TJsonObject;
  vals   : TJsonObject;
  target : IwbElement;
  sb     : TStringBuilder;
  i, changed, failed : Integer;
  name, val, err : string;
  okBody : Boolean;
  container : IwbContainerElementRef;
  idx       : Integer;
begin
  if aJob.Request.Method <> 'POST' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'This endpoint requires POST');
    Exit;
  end;
  if aJob.Request.Body = '' then begin
    RespondError(aJob, 400, 'bad_request', 'Request body must contain {"values": { "path": "value", ... }}');
    Exit;
  end;

  rec := aFile.ContainedRecordByLoadOrderFormID[aFormID, True];
  if rec = nil then begin
    RespondError(aJob, 404, 'not_found',
      'Record not found in ' + aFile.FileName + ': ' + IntToHex(aFormID.ToCardinal, 8));
    Exit;
  end;
  if not rec.IsEditable then begin
    RespondError(aJob, 403, 'read_only',
      'Record is not editable (masters / protected records cannot be changed)');
    Exit;
  end;

  jo := nil;
  try
    try
      jo := TJsonObject(TJsonObject.Parse(aJob.Request.Body));
    except
      jo := nil;
    end;
    if jo = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Body is not valid JSON');
      Exit;
    end;
    vals := jo.O['values'];
    if vals = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "values" object in body');
      Exit;
    end;

    changed := 0;
    failed  := 0;
    sb := TStringBuilder.Create;
    try
      for i := 0 to Pred(vals.Count) do begin
        name := vals.Names[i];
        try
          val := VarToStr(vals[name]);
        except
          val := '';
        end;
        err := '';
        try
          // Same resolver as the batch engine, so display-name paths copied
          // straight out of the tree endpoint work here too; fall back to
          // xEdit's native syntax (e.g. a bare signature like "FULL").
          target := ResolveElement(rec, name, container, idx);
          if target = nil then
            target := rec.ElementByPath[name];
          if target = nil then
            err := 'path not found'
          else if not target.IsEditable then
            err := 'element is not editable'
          else begin
            target.EditValue := val;
            Inc(changed);
          end;
        except
          on E: Exception do
            err := E.Message;
        end;

        if i > 0 then
          sb.Append(',');
        if err = '' then
          sb.Append('{"path":').Append(wbApiJsonString(name)).Append(',"ok":true}')
        else begin
          Inc(failed);
          sb.Append('{"path":').Append(wbApiJsonString(name))
            .Append(',"ok":false,"error":').Append(wbApiJsonString(err)).Append('}');
        end;
      end;
      okBody := (failed = 0);
      RespondJson(aJob, 200,
        '{"ok":' + wbApiJsonBool(okBody) +
        ',"changed":' + IntToStr(changed) +
        ',"failed":' + IntToStr(failed) +
        ',"results":[' + sb.ToString + ']}');
    finally
      sb.Free;
    end;
  finally
    jo.Free;
  end;
end;

procedure TwbApiServer.HandleGlobalRecord(aJob: TwbApiJob; const aFormID: TwbFormID);
var
  files : TwbFiles;
  f     : IwbFile;
  rec   : IwbMainRecord;
  i, j, fc : Integer;
begin
  if not Assigned(FFilesProvider) then begin
    RespondError(aJob, 500, 'no_provider', 'Plugin list provider is not registered');
    Exit;
  end;
  files := Copy(FFilesProvider(), 0, MaxInt);

  // sort by load order (ascending) so the first hit is the master instance
  fc := Length(files);
  for i := 1 to Pred(fc) do begin
    f := files[i];
    j := i;
    while (j > 0) and (files[j-1].LoadOrder > f.LoadOrder) do begin
      files[j] := files[j-1];
      Dec(j);
    end;
    files[j] := f;
  end;

  for f in files do begin
    rec := f.ContainedRecordByLoadOrderFormID[aFormID, True];
    if rec <> nil then begin
      RespondJson(aJob, 200, RecordChainJson(rec));
      Exit;
    end;
  end;

  RespondError(aJob, 404, 'not_found',
    'Record not found in the load order: ' + IntToHex(aFormID.ToCardinal, 8));
end;

{ ---------------- socket level code (server thread) ------------------------ }

procedure TwbApiServer.HandleConnection(aSocket: NativeUInt);
var
  sock     : TSocket;
  buf      : TBytes;
  chunk    : array [0..4095] of Byte;
  n, i     : Integer;
  he       : Integer;
  s, line  : string;
  sl       : TStringList;
  job      : TwbApiJob;
  target   : string;
  sp       : Integer;
  cl       : Integer;
  hdr      : string;
begin
  sock := TSocket(aSocket);
  buf  := nil;
  he   := -1;

  // read until the header terminator or the size limit
  while Length(buf) < wbApiMaxHeaderSize do begin
    n := recv(sock, chunk, SizeOf(chunk), 0);
    if n <= 0 then
      Exit;
    i := Length(buf);
    SetLength(buf, i + n);
    Move(chunk, buf[i], n);
    he := wbApiFindHeaderEnd(buf);
    if he >= 0 then
      Break;
  end;
  if he < 0 then begin
    // no header terminator within the size limit: reply and close
    if Length(buf) >= wbApiMaxHeaderSize then begin
      job := TwbApiJob.Create;
      try
        job.Response.StatusCode := 400;
        job.Response.Body := '{"ok":false,"error":{"code":"bad_request","message":"Request headers too large"}}';
        SendResponse(sock, job);
      finally
        job.Free;
      end;
    end;
    Exit;                       // no proper request received
  end;

  job := TwbApiJob.Create;
  try
    try
      s := TEncoding.ASCII.GetString(buf, 0, he + 4);
      sl := TStringList.Create;
      try
        sl.Text := s;
        if sl.Count = 0 then begin
          job.Response.StatusCode := 400;
          job.Response.Body := '{"ok":false,"error":{"code":"bad_request","message":"Empty request"}}';
          SendResponse(sock, job);
          Exit;
        end;

        // request line: METHOD SP TARGET SP HTTP/x.y
        line := sl[0];
        sp := Pos(' ', line);
        if sp > 0 then begin
          job.Request.Method := Copy(line, 1, sp - 1);
          target := Trim(Copy(line, sp + 1, MaxInt));
        end else
          target := '';
        sp := Pos(' ', target);
        if sp > 0 then
          target := Copy(target, 1, sp - 1);
        job.Request.RawPath := target;
        sp := Pos('?', target);
        if sp > 0 then begin
          job.Request.Query := Copy(target, sp + 1, MaxInt);
          target := Copy(target, 1, sp - 1);
        end;
        job.Request.Path := wbApiUrlDecode(target);

        for i := 1 to Pred(sl.Count) do begin
          line := sl[i];
          sp := Pos(':', line);
          if sp > 0 then
            job.Request.Headers.Add(
              LowerCase(Trim(Copy(line, 1, sp - 1))) + '=' +
              Trim(Copy(line, sp + 1, MaxInt)));
        end;
      finally
        sl.Free;
      end;

      // body (later milestones use JSON request bodies)
      hdr := wbApiHeaderValue(job.Request.Headers, 'content-length');
      cl := StrToIntDef(hdr, 0);
      if cl < 0 then
        cl := 0;
      if cl > wbApiMaxBodySize then begin
        job.Response.StatusCode := 413;
        job.Response.Body := '{"ok":false,"error":{"code":"payload_too_large","message":"Request body too large"}}';
        SendResponse(sock, job);
        Exit;
      end;
      if cl > 0 then begin
        var bodyStart := he + 4;
        var have := Length(buf) - bodyStart;
        if have < 0 then
          have := 0;
        if have > cl then
          have := cl;
        var bodyBuf: TBytes;
        SetLength(bodyBuf, have);
        if have > 0 then
          Move(buf[bodyStart], bodyBuf[0], have);
        while Length(bodyBuf) < cl do begin
          var oldLen := Length(bodyBuf);
          SetLength(bodyBuf, oldLen + 4096);
          var got := recv(sock, bodyBuf[oldLen], Length(bodyBuf) - oldLen, 0);
          if got <= 0 then begin
            SetLength(bodyBuf, oldLen);
            Break;
          end;
          SetLength(bodyBuf, oldLen + got);
        end;
        job.Request.Body := TEncoding.UTF8.GetString(bodyBuf);
      end;

      // authentication
      if FToken <> '' then begin
        if (job.Request.Method = 'GET') and (job.Request.Path = '/api/status') then
          // status is always allowed
        else begin
          hdr := wbApiHeaderValue(job.Request.Headers, 'authorization');
          if not (SameText(hdr, 'Bearer ' + FToken) or SameText(hdr, FToken)) then begin
            job.Response.StatusCode := 401;
            job.Response.Body := '{"ok":false,"error":{"code":"unauthorized","message":"Invalid or missing API token"}}';
            SendResponse(sock, job);
            Exit;
          end;
        end;
      end;

      // dispatch to the main thread and wait for the result
      FQueue.Add(job);
      job.Done.WaitFor(INFINITE);
      SendResponse(sock, job);
    except
      on E: Exception do begin
        job.Response.StatusCode := 500;
        job.Response.Body := '{"ok":false,"error":{"code":"internal_error","message":' +
                             wbApiJsonString(E.Message) + '}}';
        SendResponse(sock, job);
      end;
    end;
  finally
    job.Free;
  end;
end;

procedure TwbApiServer.SendResponse(aSocket: NativeUInt; aJob: TwbApiJob);
var
  sock     : TSocket;
  code     : Integer;
  text     : string;
  head     : string;
  headB    : TBytes;
  bodyB    : TBytes;
  off, n   : Integer;
begin
  sock := TSocket(aSocket);
  code := aJob.Response.StatusCode;
  case code of
    200 : text := 'OK';
    400 : text := 'Bad Request';
    401 : text := 'Unauthorized';
    403 : text := 'Forbidden';
    404 : text := 'Not Found';
    405 : text := 'Method Not Allowed';
    413 : text := 'Payload Too Large';
    500 : text := 'Internal Server Error';
    503 : text := 'Service Unavailable';
  else
    text := 'Status';
  end;
  if code = 0 then
    code := 500;

  bodyB := TEncoding.UTF8.GetBytes(aJob.Response.Body);
  head  := Format('HTTP/1.1 %d %s'#13#10 +
                  'Content-Type: application/json; charset=utf-8'#13#10 +
                  'Content-Length: %d'#13#10 +
                  'Connection: close'#13#10#13#10, [code, text, Length(bodyB)]);
  headB := TEncoding.ASCII.GetBytes(head);

  off := 0;
  while off < Length(headB) do begin
    n := send(sock, headB[off], Length(headB) - off, 0);
    if n <= 0 then
      Exit;
    Inc(off, n);
  end;
  off := 0;
  while off < Length(bodyB) do begin
    n := send(sock, bodyB[off], Length(bodyB) - off, 0);
    if n <= 0 then
      Exit;
    Inc(off, n);
  end;
end;

{ ---------------- M3b: patch handler --------------------------------------- }

function TwbApiServer.FindRecordAnyFile(const aFormID: TwbFormID): IwbMainRecord;
var
  files : TwbFiles;
  f     : IwbFile;
  rec   : IwbMainRecord;
  t     : IwbFile;
  i, j, fc : Integer;
begin
  Result := nil;
  if not Assigned(FFilesProvider) then
    Exit;
  files := Copy(FFilesProvider(), 0, MaxInt);
  fc := Length(files);
  for i := 1 to Pred(fc) do begin
    t := files[i];
    j := i;
    while (j > 0) and (files[j-1].LoadOrder > t.LoadOrder) do begin
      files[j] := files[j-1];
      Dec(j);
    end;
    files[j] := t;
  end;
  for f in files do begin
    rec := f.ContainedRecordByLoadOrderFormID[aFormID, True];
    if rec <> nil then begin
      Result := rec;
      Exit;
    end;
  end;
end;

procedure TwbApiServer.HandleAddMasters(aJob: TwbApiJob; const aFile: IwbFile);
var
  jo      : TJsonObject;
  arr     : TJsonArray;
  name    : string;
  i, added, failed : Integer;
  err     : string;
begin
  if aJob.Request.Method <> 'POST' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'This endpoint requires POST');
    Exit;
  end;
  jo := nil;
  try
    try
      jo := TJsonObject(TJsonObject.Parse(aJob.Request.Body));
    except
      jo := nil;
    end;
    if jo = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Body is not valid JSON');
      Exit;
    end;
    arr := jo.A['masters'];
    if arr = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "masters" array');
      Exit;
    end;

    added := 0;
    failed := 0;
    for i := 0 to Pred(arr.Count) do begin
      try
        name := arr.S[i];
      except
        name := '';
      end;
      if name = '' then
        Continue;
      if SameText(name, aFile.FileName) then
        Continue;              // never add the file itself as its own master
      err := '';
      try
        aFile.AddMasterIfMissing(name);
        Inc(added);
      except
        on E: Exception do begin
          err := E.Message;
          Inc(failed);
        end;
      end;
    end;

    if jo.Contains('sort') and jo.B['sort'] then
      try
        aFile.SortMasters;
      except
      end;

    RespondJson(aJob, 200,
      '{"ok":' + wbApiJsonBool(failed = 0) +
      ',"added":' + IntToStr(added) +
      ',"failed":' + IntToStr(failed) + '}');
  finally
    jo.Free;
  end;
end;

// Resolves a relative element path (backslash separated, segments may be
// display names or numeric indexes) from a record/element. The last numeric
// segment resolves to a child index. Returns nil when a path cannot resolve.
function TwbApiServer.ResolveElement(const aElement: IwbElement; const aPath: string;
                                     out aContainer: IwbContainerElementRef;
                                     out aIndex: Integer): IwbElement;
var
  cur      : IwbElement;
  tokens   : TArray<string>;
  t        : string;
  k, n     : Integer;
  cef      : IwbContainerElementRef;
  el       : IwbElement;
  mr       : IwbMainRecord;
  rootName : string;
begin
  Result := nil;
  aContainer := nil;
  aIndex := -1;
  cur := aElement;
  // The element tree prints paths prefixed with the record root (a RACE record
  // yields "RACE \ FULL - Name"), so accept those verbatim by ignoring a
  // leading token that is merely the record's own signature.
  rootName := '';
  if Supports(aElement, IwbMainRecord, mr) then
    rootName := wbApiSignatureToString(mr.Signature);
  tokens := aPath.Split(['\'], TStringSplitOptions.ExcludeEmpty);
  for k := 0 to High(tokens) do begin
    t := Trim(tokens[k]);
    if (k = 0) and (rootName <> '') and SameText(t, rootName) then
      Continue;                     // record-root prefix, not an element name
    if t = '' then
      Continue;
    if not Supports(cur, IwbContainerElementRef, cef) then
      Exit;                                   // cannot descend further
    n := -1;
    if (Length(t) <= 9) and (t[1] in ['0'..'9']) then
      n := StrToIntDef(t, -1);
    if n >= 0 then begin
      if n < cef.ElementCount then begin
        aContainer := cef;
        aIndex := n;
        cur := cef.Elements[n];
      end else
        Exit;
    end else begin
      aIndex := -1;
      var found := False;
      for var i := 0 to Pred(cef.ElementCount) do begin
        el := cef.Elements[i];
        if SameText(el.Name, t) then begin
          aContainer := cef;
          cur := el;
          found := True;
          Break;
        end;
      end;
      if not found then begin
        // Native signatures (e.g. FULL) need not equal display names.
        el := cef.ElementByPath[t];
        if el = nil then Exit;
        aContainer := cef;
        cur := el;
      end;
    end;
  end;
  Result := cur;
end;

// JSON convenience readers
function WbApiJsonStr(const aObj: TJsonObject; const aName, aDef: string): string;
begin
  Result := aDef;
  try
    if aObj <> nil then
      if aObj.Contains(aName) then
        Result := aObj.S[aName];
  except
  end;
end;

function WbApiJsonObj(const aObj: TJsonObject; const aName: string): TJsonObject;
begin
  Result := nil;
  try
    if aObj <> nil then
      if aObj.Contains(aName) then
        Result := aObj.O[aName];
  except
  end;
end;

procedure TwbApiServer.HandleApiIndex(aJob: TwbApiJob);
begin
  RespondJson(aJob, 200,
    '{"ok":true,' +
    '"apiVersion":' + IntToStr(wbApiVersion) + ',' +
    '"note":"FormIDs are 8-hex load-order FormIDs. Paths use display names joined by \\ ; numeric segments select list indexes.",' +
    '"savePolicy":"not available by design: the API only edits in memory; the user must save from the xEdit GUI.",' +
    '"endpoints":[' +
    '"POST /api/changesets (scalar values + expected; optional dryRun)",' +
    '"POST /api/element-changesets (add-element; whole-record diff and verified removal rollback)",' +
    '"GET  /api/changesets/{id}",' +
    '"POST /api/changesets/{id}/rollback",' +
    '"GET  /api/plugins/{fileName}/records/{formID}/element?path&options&templates",' +
    '"GET  /api/logs?after",' +
    '"GET  /api/interactions",' +
    '"POST /api/interactions/{id}/respond",' +
    '"GET  /api/modules",' +
    '"POST /api/load",' +
    '"GET  /api/status",' +
    '"GET  /api/plugins",' +
    '"GET  /api/plugins/{fileName}",' +
    '"GET  /api/plugins/{fileName}/records?signature&editorID&offset&limit&names",' +
    '"GET  /api/plugins/{fileName}/records/{formID}",' +
    '"GET  /api/records/{formID}",' +
    '"GET  /api/plugins/{fileName}/records/{formID}/tree?depth",' +
    '"POST /api/plugins/{fileName}/records/{formID}/values",' +
    '"POST /api/plugins/{fileName}/records/{formID}/copy-elements",' +
    '"POST /api/plugins/{fileName}/addmasters",' +
    '"POST /api/patch",' +
    '"GET  /api/find?editorID&signature&file&exact&limit",' +
    '"POST /api/batch (ops: set/copy/add-item/remove-item/create-record/create-empty-record/remove-record/masters/add-element/remove-element/clear-element/set-link)",' +
    '"GET  /api (this index)"' +
    ']}');
end;

procedure TwbApiServer.HandleFind(aJob: TwbApiJob);
var
  q, edid, sig, fname, s : string;
  exact, more : Boolean;
  limit, count, i, j, k : Integer;
  files : TwbFiles;
  f, tf  : IwbFile;
  rec, w : IwbMainRecord;
  sb     : TStringBuilder;
  cef    : IwbContainerElementRef;
  grp    : IwbGroupRecord;
  el     : IwbElement;

  procedure AddRecord(const aRec: IwbMainRecord);
  begin
    if more or (aRec = nil) then
      Exit;
    if count > 0 then
      sb.Append(',');
    sb.Append('{"file":').Append(wbApiJsonString(aRec._File.FileName));
    sb.Append(',"formID":').Append(wbApiJsonString(IntToHex(aRec.FormID.ToCardinal, 8)));
    sb.Append(',"loadOrderFormID":').Append(wbApiJsonString(IntToHex(aRec.LoadOrderFormID.ToCardinal, 8)));
    sb.Append(',"signature":').Append(wbApiJsonString(wbApiSignatureToString(aRec.Signature)));
    sb.Append(',"editorID":').Append(wbApiJsonString(aRec.EditorID));
    sb.Append(',"isMaster":').Append(wbApiJsonBool(aRec.IsMaster));
    sb.Append(',"isWinningOverride":').Append(wbApiJsonBool(aRec.IsWinningOverride));
    sb.Append(',"overrideCount":').Append(aRec.OverrideCount);
    if aRec.IsMaster then
      w := nil
    else
      w := aRec.WinningOverride;
    if w <> nil then
      sb.Append(',"winningFile":').Append(wbApiJsonString(w._File.FileName))
    else
      sb.Append(',"winningFile":').Append(wbApiJsonString(aRec._File.FileName));
    sb.Append('}');
    Inc(count);
    if count >= limit then
      more := True;
  end;

begin
  if not Assigned(FFilesProvider) then begin
    RespondError(aJob, 500, 'no_provider', 'Plugin list provider is not registered');
    Exit;
  end;

  q := aJob.Request.Query;
  edid := wbApiQueryParam(q, 'editorID');
  if edid = '' then begin
    RespondError(aJob, 400, 'bad_request', 'Missing editorID parameter');
    Exit;
  end;
  sig := UpperCase(Trim(wbApiQueryParam(q, 'signature')));
  fname := wbApiQueryParam(q, 'file');
  s := wbApiQueryParam(q, 'exact');
  exact := not ((s = '0') or SameText(s, 'false'));
  limit := StrToIntDef(wbApiQueryParam(q, 'limit'), 100);
  if limit < 1 then
    limit := 1;
  if limit > 500 then
    limit := 500;

  files := Copy(FFilesProvider(), 0, MaxInt);
  for i := 1 to Pred(Length(files)) do begin
    tf := files[i];
    j := i;
    while (j > 0) and (files[j-1].LoadOrder > tf.LoadOrder) do begin
      files[j] := files[j-1];
      Dec(j);
    end;
    files[j] := tf;
  end;

  count := 0;
  more  := False;
  sb := TStringBuilder.Create;
  try
    for f in files do begin
      if more then
        Break;
      if (fname <> '') and not SameText(f.FileName, fname) then
        Continue;

      if exact then begin
        rec := f.RecordByEditorID[edid];
        if rec <> nil then
          AddRecord(rec)
        else if sig <> '' then begin
          // no EDID index (SSEEdit not started with -TrackAllEditorID): scan the group
          grp := f.GroupBySignature[wbApiStringToSignature(sig)];
          if grp <> nil then
            for i := 0 to Pred(grp.ElementCount) do begin
              el := grp.Elements[i];
              if Supports(el, IwbMainRecord, rec) then
                if SameText(rec.EditorID, edid) then
                  AddRecord(rec);
              if more then
                Break;
            end;
        end else if fname <> '' then begin
          if Supports(f, IwbContainerElementRef, cef) then
            for i := 0 to Pred(cef.ElementCount) do begin
              el := cef.Elements[i];
              if Supports(el, IwbGroupRecord, grp) then
                for k := 0 to Pred(grp.ElementCount) do begin
                  el := grp.Elements[k];
                  if Supports(el, IwbMainRecord, rec) then
                    if SameText(rec.EditorID, edid) then
                      AddRecord(rec);
                  if more then
                    Break;
                end;
              if more then
                Break;
            end;
        end;
      end else begin
        if sig <> '' then begin
          grp := f.GroupBySignature[wbApiStringToSignature(sig)];
          if grp <> nil then
            for i := 0 to Pred(grp.ElementCount) do begin
              el := grp.Elements[i];
              if Supports(el, IwbMainRecord, rec) then
                if StartsText(edid, rec.EditorID) then
                  AddRecord(rec);
              if more then
                Break;
            end;
        end else if Supports(f, IwbContainerElementRef, cef) then begin
          for i := 0 to Pred(cef.ElementCount) do begin
            el := cef.Elements[i];
            if Supports(el, IwbGroupRecord, grp) then
              for k := 0 to Pred(grp.ElementCount) do begin
                el := grp.Elements[k];
                if Supports(el, IwbMainRecord, rec) then
                  if StartsText(edid, rec.EditorID) then
                    AddRecord(rec);
                if more then
                  Break;
              end;
            if more then
              Break;
          end;
        end;
      end;
    end;

    RespondJson(aJob, 200,
      '{"ok":true,"count":' + IntToStr(count) +
      ',"hasMore":' + wbApiJsonBool(more) +
      ',"edidIndexEnabled":' + wbApiJsonBool(wbTrackAllEditorID) +
      ',"matches":[' + sb.ToString + ']}');
  finally
    sb.Free;
  end;
end;

function TwbApiServer.FindPlugin(const aFileName: string): IwbFile;
var
  files : TwbFiles;
  f     : IwbFile;
begin
  Result := nil;
  if not Assigned(FFilesProvider) then
    Exit;
  files := FFilesProvider();
  for f in files do
    if SameText(f.FileName, aFileName) then begin
      Result := f;
      Exit;
    end;
end;

procedure TwbApiServer.HandleBatch(aJob: TwbApiJob);
var
  jo, obj, src, values : TJsonObject;
  ops      : TJsonArray;
  sb       : TStringBuilder;
  i, k, failedCount, changed : Integer;
  strict   : Boolean;
  opName   : string;
  fn, fidS, path, vname, vval, msg, err, operationResult : string;
  fid      : Cardinal;
  f, srcFile, tgtFile : IwbFile;
  rec, srcRec, tgtRec : IwbMainRecord;
  newRec   : IwbMainRecord;
  el, srcEl, tgtEl, newEl : IwbElement;
  container, parentCef, listCef : IwbContainerElementRef;
  idx      : Integer;
  template : string;
begin
  if aJob.Request.Method <> 'POST' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'This endpoint requires POST');
    Exit;
  end;
  jo := nil;
  try
    try
      jo := TJsonObject(TJsonObject.Parse(aJob.Request.Body));
    except
      jo := nil;
    end;
    if jo = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Body is not valid JSON');
      Exit;
    end;
    ops := jo.A['ops'];
    if ops = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "ops" array');
      Exit;
    end;
    strict := False;
    if jo.Contains('strict') then
      strict := jo.B['strict'];

    failedCount := 0;
    sb := TStringBuilder.Create;
    try
      for i := 0 to Pred(ops.Count) do begin
        obj := ops.O[i];
        opName := WbApiJsonStr(obj, 'op', '');
        err := '';
        msg := '';
        operationResult := '';

        if opName = 'create-empty-record' then begin
          err := ExecuteRecordCreate(obj.ToJSON, operationResult);
          msg := opName;
        end else if opName = 'remove-record' then begin
          err := ExecuteRecordRemove(obj.ToJSON, operationResult);
          msg := opName;
        end else if (opName = 'add-element') or (opName = 'remove-element') or
           (opName = 'clear-element') or (opName = 'set-link') then begin
          err := ExecuteElementOp(obj.ToJSON, operationResult);
          msg := opName;
        end else if opName = 'set' then begin
          fn := WbApiJsonStr(obj, 'file', '');
          fidS := WbApiJsonStr(obj, 'formID', '');
          f := FindPlugin(fn);
          if (f = nil) or not wbApiParseFormID(fidS, fid) then
            err := 'bad file/formID'
          else begin
            rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            if rec = nil then
              err := 'record not found: ' + fidS
            else if not rec.IsEditable then
              err := 'record is read-only'
            else begin
              values := WbApiJsonObj(obj, 'values');
              if values = nil then
                err := 'missing values'
              else begin
                changed := 0;
                for k := 0 to Pred(values.Count) do begin
                  vname := values.Names[k];
                  try
                    vval := VarToStr(values[vname]);
                  except
                    vval := '';
                  end;
                  el := ResolveElement(rec, vname, container, idx);
                  if el = nil then
                    err := 'path not found: ' + vname
                  else if not el.IsEditable then
                    err := 'element not editable: ' + vname
                  else begin
                    try
                      el.EditValue := vval;
                      Inc(changed);
                    except
                      on E: Exception do
                        err := E.Message;
                    end;
                  end;
                  if err <> '' then
                    Break;
                end;
                if err = '' then
                  msg := 'changed ' + IntToStr(changed);
              end;
            end;
          end;
        end else if opName = 'copy' then begin
          src := WbApiJsonObj(obj, 'source');
          tgtFile := nil; srcFile := nil; srcRec := nil;
          if src <> nil then begin
            srcFile := FindPlugin(WbApiJsonStr(src, 'file', ''));
            if srcFile <> nil then begin
              fidS := WbApiJsonStr(src, 'formID', '');
              if wbApiParseFormID(fidS, fid) then
                srcRec := srcFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            end;
          end;
          fn := WbApiJsonStr(obj, 'file', '');
          fidS := WbApiJsonStr(obj, 'formID', '');
          f := FindPlugin(fn);
          if (f = nil) or not wbApiParseFormID(fidS, fid) then
            err := 'bad file/formID'
          else begin
            tgtRec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            if (srcRec = nil) or (tgtRec = nil) then
              err := 'could not resolve target/source record'
            else begin
              path := WbApiJsonStr(obj, 'path', '');
              if path = '' then
                err := 'missing path'
              else begin
                srcEl := ResolveElement(srcRec, path, container, idx);
                tgtEl := ResolveElement(tgtRec, path, container, idx);
                if srcEl = nil then
                  err := 'source path not found: ' + path
                else if tgtEl <> nil then begin
                  try
                    tgtEl.Assign(wbAssignThis, srcEl, False);
                    msg := 'copied ' + path;
                  except
                    on E: Exception do
                      err := E.Message;
                  end;
                end else begin
                  // target missing: create the optional sub-record under its parent
                  var tokens := path.Split(['\'], TStringSplitOptions.ExcludeEmpty);
                  var parentPath := '';
                  for k := 0 to High(tokens) - 1 do begin
                    if k > 0 then
                      parentPath := parentPath + '\';
                    parentPath := parentPath + tokens[k];
                  end;
                  var lastToken := tokens[High(tokens)];
                  var pe := ResolveElement(tgtRec, parentPath, parentCef, idx);
                  if (pe = nil) or not Supports(pe, IwbContainerElementRef, listCef) then
                    err := 'cannot create: parent not found for ' + path
                  else begin
                    try
                      var sourceSignature: IwbHasSignature;
                      if Supports(srcEl, IwbHasSignature, sourceSignature) then
                        newEl := listCef.Add(wbApiSignatureToString(sourceSignature.Signature))
                      else
                        newEl := listCef.Add(lastToken);
                      if newEl = nil then
                        err := 'could not add ' + lastToken
                      else begin
                        newEl.Assign(wbAssignThis, srcEl, False);
                        msg := 'created+copied ' + path;
                      end;
                    except
                      on E: Exception do
                        err := E.Message;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end else if opName = 'add-item' then begin
          fn := WbApiJsonStr(obj, 'file', '');
          fidS := WbApiJsonStr(obj, 'formID', '');
          f := FindPlugin(fn);
          if (f = nil) or not wbApiParseFormID(fidS, fid) then
            err := 'bad file/formID'
          else begin
            rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            path := WbApiJsonStr(obj, 'path', '');
            if (rec = nil) then
              err := 'record not found'
            else if path = '' then
              err := 'missing path (container)'
            else begin
              el := ResolveElement(rec, path, container, idx);
              if (el = nil) or not Supports(el, IwbContainerElementRef, listCef) then
                err := 'path is not a container: ' + path
              else begin
                template := WbApiJsonStr(obj, 'template', '');
                if template = '' then
                  if listCef.ElementCount > 0 then
                    template := listCef.Elements[0].Name;
                if template = '' then
                  err := 'cannot infer item template for ' + path
                else begin
                  try
                    newEl := listCef.Add(template);
                    if newEl = nil then
                      err := 'could not add item ' + template
                    else begin
                      msg := 'added ' + template + ' at index ' + IntToStr(Pred(listCef.ElementCount));
                      src := WbApiJsonObj(obj, 'source');
                      if src <> nil then begin
                        srcFile := FindPlugin(WbApiJsonStr(src, 'file', ''));
                        fidS := WbApiJsonStr(src, 'formID', '');
                        if (srcFile <> nil) and wbApiParseFormID(fidS, fid) then begin
                          srcRec := srcFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
                          if srcRec <> nil then begin
                            srcEl := ResolveElement(srcRec, WbApiJsonStr(src, 'path', path), container, idx);
                            if srcEl <> nil then
                              newEl.Assign(wbAssignThis, srcEl, False);
                          end;
                        end;
                      end;
                    end;
                  except
                    on E: Exception do
                      err := E.Message;
                  end;
                end;
              end;
            end;
          end;
        end else if opName = 'remove-item' then begin
          fn := WbApiJsonStr(obj, 'file', '');
          fidS := WbApiJsonStr(obj, 'formID', '');
          path := WbApiJsonStr(obj, 'path', '');
          f := FindPlugin(fn);
          if (f = nil) or not wbApiParseFormID(fidS, fid) then
            err := 'bad file/formID'
          else begin
            rec := f.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            if rec = nil then
              err := 'record not found'
            else begin
              el := ResolveElement(rec, path, container, idx);
              if (el = nil) or (container = nil) or (idx < 0) then
                err := 'path must end in a numeric list index: ' + path
              else begin
                try
                  container.RemoveElement(idx);
                  msg := 'removed ' + path;
                except
                  on E: Exception do
                    err := E.Message;
                end;
              end;
            end;
          end;
        end else if opName = 'create-record' then begin
          src := WbApiJsonObj(obj, 'source');
          fn := WbApiJsonStr(obj, 'file', '');
          f := FindPlugin(fn);
          srcFile := nil;
          srcRec := nil;
          if src <> nil then begin
            srcFile := FindPlugin(WbApiJsonStr(src, 'file', ''));
            if srcFile <> nil then begin
              fidS := WbApiJsonStr(src, 'formID', '');
              if wbApiParseFormID(fidS, fid) then
                srcRec := srcFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            end;
          end;
          if f = nil then
            err := 'plugin not loaded: ' + fn
          else if srcRec = nil then
            err := 'source record not found'
          else begin
            try
              newEl := srcRec.CopyInto(f, True, True, '', '', '', '');
              if newEl = nil then
                err := 'copy-as-new failed'
              else if not Supports(newEl, IwbMainRecord, newRec) then
                err := 'copy-as-new result is not a record'
              else begin
                var newED := WbApiJsonStr(obj, 'editorID', '');
                if newED <> '' then
                  if newRec.CanHaveEditorID then
                    newRec.EditorID := newED
                  else
                    err := 'record type cannot have an editor ID';
                if err = '' then begin
                  values := WbApiJsonObj(obj, 'values');
                  if values <> nil then
                    for k := 0 to Pred(values.Count) do begin
                      vname := values.Names[k];
                      try
                        vval := VarToStr(values[vname]);
                      except
                        vval := '';
                      end;
                      el := ResolveElement(newRec, vname, container, idx);
                      if el = nil then begin
                        err := 'path not found: ' + vname;
                        Break;
                      end else
                        try
                          el.EditValue := vval;
                        except
                          on E: Exception do begin
                            err := E.Message;
                            Break;
                          end;
                        end;
                    end;
                end;
                if err = '' then
                  msg := 'created ' + IntToHex(newRec.LoadOrderFormID.ToCardinal, 8) +
                         ' edid=' + newRec.EditorID;
              end;
            except
              on E: Exception do
                err := E.Message;
            end;
          end;
        end else if opName = 'masters' then begin
          fn := WbApiJsonStr(obj, 'file', '');
          f := FindPlugin(fn);
          if f = nil then
            err := 'plugin not loaded: ' + fn
          else begin
            var arr := obj.A['add'];
            if arr <> nil then
              for k := 0 to Pred(arr.Count) do begin
                try
                  var mname := arr.S[k];
                  if not SameText(mname, f.FileName) then
                    f.AddMasterIfMissing(mname);
                except
                end;
              end;
            if obj.Contains('sort') and obj.B['sort'] then
              f.SortMasters;
            if obj.Contains('clean') and obj.B['clean'] then
              f.CleanMasters;
            msg := 'masters updated';
          end;
        end else if opName = 'save' then
          // saving is intentionally not exposed through the API
          err := 'save is not available through the API; apply the edits, then save from the xEdit GUI'
        else
          err := 'unknown op: ' + opName;

        if i > 0 then
          sb.Append(',');
        if err = '' then
          sb.Append('{"index":').Append(i).Append(',"op":').Append(wbApiJsonString(opName))
            .Append(',"ok":true,"message":').Append(wbApiJsonString(msg))
            .Append(IfThen(operationResult <> '', ',"result":' + operationResult, '')).Append('}')
        else begin
          Inc(failedCount);
          sb.Append('{"index":').Append(i).Append(',"op":').Append(wbApiJsonString(opName))
            .Append(',"ok":false,"error":').Append(wbApiJsonString(err))
            .Append(IfThen(operationResult <> '', ',"result":' + operationResult, '')).Append('}');
          if strict then
            Break;
        end;
      end;

      RespondJson(aJob, 200,
        '{"ok":' + wbApiJsonBool(failedCount = 0) +
        ',"failed":' + IntToStr(failedCount) +
        ',"results":[' + sb.ToString + ']}');
    finally
      sb.Free;
    end;
  finally
    jo.Free;
  end;
end;

function TwbApiServer.FindTopLevelElement(const aRecord: IwbMainRecord;
                                          const aName: string): IwbElement;
var
  cb : IwbContainerBase;
  i  : Integer;
begin
  Result := nil;
  cb := aRecord;
  for i := 0 to Pred(cb.ElementCount) do
    if SameText(cb.Elements[i].Name, aName) then begin
      Result := cb.Elements[i];
      Exit;
    end;
end;

procedure TwbApiServer.HandleCopyElements(aJob: TwbApiJob; const aFile: IwbFile;
                                          const aFormID: TwbFormID);
var
  jo, src      : TJsonObject;
  arr          : TJsonArray;
  tgtRec       : IwbMainRecord;
  srcRec       : IwbMainRecord;
  srcFile      : IwbFile;
  files        : TwbFiles;
  tgtEl, srcEl : IwbElement;
  newEl        : IwbElement;
  sb           : TStringBuilder;
  i, changed, failed : Integer;
  name, srcFileName, srcFormIDStr, err : string;
  srcFID       : Cardinal;
begin
  if aJob.Request.Method <> 'POST' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'This endpoint requires POST');
    Exit;
  end;
  if aJob.Request.Body = '' then begin
    RespondError(aJob, 400, 'bad_request',
      'Body must be {"source":{"file":"X.esp","formID":"hex"},"elements":["DATA - DATA",...]}');
    Exit;
  end;

  tgtRec := aFile.ContainedRecordByLoadOrderFormID[aFormID, True];
  if tgtRec = nil then begin
    RespondError(aJob, 404, 'not_found',
      'Target record not found in ' + aFile.FileName + ': ' + IntToHex(aFormID.ToCardinal, 8));
    Exit;
  end;

  jo := nil;
  try
    try
      jo := TJsonObject(TJsonObject.Parse(aJob.Request.Body));
    except
      jo := nil;
    end;
    if jo = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Body is not valid JSON');
      Exit;
    end;
    src := jo.O['source'];
    if src = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "source" object');
      Exit;
    end;
    arr := jo.A['elements'];
    if arr = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "elements" array');
      Exit;
    end;

    srcFileName := src.S['file'];
    srcFormIDStr := src.S['formID'];
    if (srcFileName = '') or not wbApiParseFormID(srcFormIDStr, srcFID) then begin
      RespondError(aJob, 400, 'bad_request', 'source.file / source.formID invalid');
      Exit;
    end;

    srcFile := nil;
    if Assigned(FFilesProvider) then begin
      files := FFilesProvider();
      for var f2 in files do
        if SameText(f2.FileName, srcFileName) then begin
          srcFile := f2;
          Break;
        end;
    end;
    if srcFile = nil then begin
      RespondError(aJob, 404, 'not_found', 'Source plugin not loaded: ' + srcFileName);
      Exit;
    end;
    srcRec := srcFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(srcFID), True];
    if srcRec = nil then begin
      RespondError(aJob, 404, 'not_found',
        'Source record not found in ' + srcFileName + ': ' + srcFormIDStr);
      Exit;
    end;

    changed := 0;
    failed  := 0;
    sb := TStringBuilder.Create;
    try
      for i := 0 to Pred(arr.Count) do begin
        try
          name := arr.S[i];
        except
          name := '';
        end;
        err := '';
        if name = '' then
          err := 'empty element name'
        else begin
          tgtEl := FindTopLevelElement(tgtRec, name);
          if tgtEl = nil then
            err := 'element not found on target: ' + name
          else begin
            srcEl := FindTopLevelElement(srcRec, name);
            if srcEl = nil then
              err := 'element not found on source: ' + name
            else begin
              try
                newEl := tgtEl.Assign(wbAssignThis, srcEl, False);
                Inc(changed);
              except
                on E: Exception do
                  err := E.Message;
              end;
            end;
          end;
        end;

        if i > 0 then
          sb.Append(',');
        if err = '' then
          sb.Append('{"element":').Append(wbApiJsonString(name)).Append(',"ok":true}')
        else begin
          Inc(failed);
          sb.Append('{"element":').Append(wbApiJsonString(name))
            .Append(',"ok":false,"error":').Append(wbApiJsonString(err)).Append('}');
        end;
      end;

      RespondJson(aJob, 200,
        '{"ok":' + wbApiJsonBool(failed = 0) +
        ',"changed":' + IntToStr(changed) +
        ',"failed":' + IntToStr(failed) +
        ',"results":[' + sb.ToString + ']}');
    finally
      sb.Free;
    end;
  finally
    jo.Free;
  end;
end;

procedure TwbApiServer.HandlePatch(aJob: TwbApiJob);
var
  jo       : TJsonObject;
  recs     : TJsonArray;
  sb       : TStringBuilder;
  newFile  : IwbFile;
  rec      : IwbMainRecord;
  res      : IwbElement;
  fname    : string;
  fidStr   : string;
  fid      : Cardinal;
  fileName : string;
  err      : string;
  isLight  : Boolean;
  doWinning: Boolean;
  created, failed : Integer;
  i        : Integer;
begin
  if aJob.Request.Method <> 'POST' then begin
    RespondError(aJob, 405, 'method_not_allowed', 'This endpoint requires POST');
    Exit;
  end;
  if not Assigned(wbApiServerAddFileHandler) then begin
    RespondError(aJob, 501, 'not_available',
      'New-file handler is not registered (the API must run with the GUI)');
    Exit;
  end;

  jo := nil;
  try
    try
      jo := TJsonObject(TJsonObject.Parse(aJob.Request.Body));
    except
      jo := nil;
    end;
    if jo = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Body is not valid JSON');
      Exit;
    end;

    fileName := Trim(jo.S['fileName']);
    if fileName = '' then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "fileName"');
      Exit;
    end;
    if ExtractFileExt(fileName) = '' then
      fileName := fileName + '.esp';

    // Guard rails before touching the GUI: frmMain.AddNewFileName pops a modal
    // "A file of that name exists already." dialog, which would block the main
    // thread (and with it this whole API) until somebody clicks it.
    if not wbApiIsValidPluginFileName(fileName) then begin
      RespondError(aJob, 400, 'bad_file_name',
        'Invalid plugin file name: ' + fileName + ' (characters \/*?:"<>| are not allowed)');
      Exit;
    end;
    if FindPlugin(fileName) <> nil then begin
      RespondError(aJob, 409, 'file_exists',
        'A plugin with that name is already loaded: ' + fileName);
      Exit;
    end;
    if FileExists(wbDataPath + fileName) then begin
      RespondError(aJob, 409, 'file_exists',
        'A plugin file with that name already exists in the data folder: ' + fileName);
      Exit;
    end;

    isLight  := False;
    if jo.Contains('isLight') then
      isLight := jo.B['isLight'];

    recs := jo.A['records'];
    if recs = nil then begin
      RespondError(aJob, 400, 'bad_request', 'Missing "records" array');
      Exit;
    end;

    try
      newFile := wbApiServerAddFileHandler(fileName, isLight, False);
    except
      on E: Exception do begin
        if ContainsText(E.Message, 'exists already') then
          RespondError(aJob, 409, 'file_exists', E.Message)
        else
          RespondError(aJob, 400, 'create_failed', E.Message);
        Exit;
      end;
    end;
    if newFile = nil then begin
      RespondError(aJob, 400, 'create_failed', 'Could not create plugin file: ' + fileName);
      Exit;
    end;
    if isLight then
      newFile.IsLight := True;   // make sure the ESL flag is set on the header

    created := 0;
    failed  := 0;
    sb := TStringBuilder.Create;
    try
      for i := 0 to Pred(recs.Count) do begin
        err := '';
        try
          var o := recs.O[i];
          fname := '';
          if o.Contains('file') then
            fname := o.S['file'];
          fidStr := '';
          if o.Contains('formID') then
            fidStr := o.S['formID'];
          if not wbApiParseFormID(fidStr, fid) then
            err := 'invalid formID: ' + fidStr
          else begin
            if fname <> '' then begin
              var files := Copy(FFilesProvider(), 0, MaxInt);
              var srcFile: IwbFile := nil;
              for var f2 in files do
                if SameText(f2.FileName, fname) then begin
                  srcFile := f2;
                  Break;
                end;
              if srcFile = nil then
                err := 'plugin not loaded: ' + fname
              else
                rec := srcFile.ContainedRecordByLoadOrderFormID[TwbFormID.FromCardinal(fid), True];
            end else
              rec := FindRecordAnyFile(TwbFormID.FromCardinal(fid));

            if err = '' then begin
              if rec = nil then
                err := 'record not found: ' + fidStr
              else begin
                doWinning := False;
                if o.Contains('winning') then
                  doWinning := o.B['winning'];
                if doWinning then begin
                  var master := rec.MasterOrSelf;
                  var win := master.WinningOverride;
                  if win <> nil then
                    rec := win;
                end;
                res := rec.CopyInto(newFile, False, True, '', '', '', '');
                if res = nil then
                  err := 'copy failed for ' + fidStr;
              end;
            end;
          end;
        except
          on E: Exception do
            err := E.Message;
        end;

        if err <> '' then begin
          Inc(failed);
          sb.Append('{"formID":').Append(wbApiJsonString(fidStr))
            .Append(',"ok":false,"error":').Append(wbApiJsonString(err)).Append('}');
        end else begin
          Inc(created);
          if created > 1 then
            sb.Append(',');
          sb.Append('{"formID":').Append(wbApiJsonString(fidStr)).Append(',"ok":true}');
        end;
      end;

      try
        newFile.SortMasters;
        newFile.CleanMasters;
      except
        on E: Exception do
          sb.Append('{"formID":"","ok":false,"error":').Append(wbApiJsonString('masters: ' + E.Message)).Append('}');
      end;

      RespondJson(aJob, 200,
        '{"ok":' + wbApiJsonBool(failed = 0) +
        ',"fileName":' + wbApiJsonString(newFile.FileName) +
        ',"created":' + IntToStr(created) +
        ',"failed":' + IntToStr(failed) +
        ',"results":[' + sb.ToString + ']}');
    finally
      sb.Free;
    end;
  finally
    jo.Free;
  end;
end;

{ =========================================================================== }
{  global entry points                                                        }
{ =========================================================================== }

procedure wbApiServerConfigureFromCmdLine;
var
  s    : string;
  port : Integer;
begin
  if Assigned(wbApiServerInstance) then
    Exit;
  if wbFindCmdLineParam('api', s) then begin
    port := wbApiDefaultPort;
    if s <> '' then
      port := StrToIntDef(s, wbApiDefaultPort);
    if (port < 1) or (port > 65535) then
      port := wbApiDefaultPort;

    s := '';
    wbFindCmdLineParam('apitoken', s);

    wbApiServerInstance := TwbApiServer.Create(Word(port), s);
  end;
end;

function wbApiServerEnabled: Boolean;
begin
  Result := Assigned(wbApiServerInstance);
end;

procedure wbApiServerBeginSelection;
begin
  if Assigned(wbApiServerInstance) then begin
    wbApiServerInstance.FLastLoadError := '';
    wbApiServerInstance.FSelecting := True;
    wbApiServerInstance.FSelectionDone := False;
    wbApiServerInstance.RefreshPhase;
  end;
end;

procedure wbApiServerBeginInteraction(const aMessage: string;
  const aResponder: TwbApiInteractionResponder);
var
  guid: TGUID;
begin
  if Assigned(wbApiServerInstance) then with wbApiServerInstance do begin
    if Assigned(FInteractionResponder) then raise Exception.Create('Interaction already pending');
    CreateGUID(guid);
    FInteractionID := GUIDToString(guid);
    FInteractionMessage := aMessage;
    FInteractionChoice := '';
    FInteractionResponder := aResponder;
    RefreshPhase;
  end;
end;

procedure wbApiServerEndInteraction(aYes: Boolean);
begin
  if Assigned(wbApiServerInstance) then with wbApiServerInstance do begin
    FInteractionResponder := nil;
    if aYes then FInteractionChoice := 'yes' else FInteractionChoice := 'no';
    RefreshPhase;
  end;
end;

procedure wbApiServerLog(const aMessage: string);
begin
  // Called only from the GUI message consumer, never from loader threads.
  if Assigned(wbApiServerInstance) then with wbApiServerInstance do begin
    Inc(FLogSequence);
    FLogs.Add('{"sequence":' + IntToStr(FLogSequence) + ',"time":' +
      wbApiJsonString(DateToISO8601(TTimeZone.Local.ToUniversalTime(Now), True)) +
      ',"message":' + wbApiJsonString(Copy(aMessage, 1, 2000)) + '}');
    while FLogs.Count > 200 do FLogs.Delete(0);
    if (not wbLoaderDone or wbLoaderError) and aMessage.StartsWith('Fatal:') then
      FLastLoadError := Copy(aMessage, 1, 2000);
    RefreshPhase;
  end;
end;

procedure wbApiServerLoadFailed(const aMessage: string);
begin
  if Assigned(wbApiServerInstance) then begin
    wbApiServerInstance.FLastLoadError := Copy(aMessage, 1, 2000);
    wbLoaderError := True;
    wbApiServerInstance.RefreshPhase;
  end;
end;

function wbApiServerSelectionDone: Boolean;
begin
  Result := Assigned(wbApiServerInstance) and wbApiServerInstance.FSelectionDone;
end;

procedure wbApiServerStart(const aFilesProvider: TwbApiFilesProvider);
begin
  if Assigned(wbApiServerInstance) then
    wbApiServerInstance.Start(aFilesProvider);
end;

procedure wbApiServerStop;
begin
  if Assigned(wbApiServerInstance) then
    wbApiServerInstance.Stop;
end;

procedure wbApiServerSetAddFileHandler(const aHandler: TwbApiAddFileProc);
begin
  wbApiServerAddFileHandler := aHandler;
end;

procedure wbApiServerSetRemoveRecordHandler(const aHandler: TwbApiRemoveRecordProc);
begin
  wbApiServerRemoveRecordHandler := aHandler;
end;

initialization
finalization
  wbApiServerStop;
  FreeAndNil(wbApiServerInstance);
end.
