{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{
  Reader / writer for Valve's text KeyValues format (.vdf, .acf, .res, ...).

  A TKeyValues object is either a *section* (it has children) or a *value*
  (it holds a string). Loading a file fills the object you call LoadFromFile on
  with the file's top-level entries as its children, so for libraryfolders.vdf:

    Doc := TKeyValues.Create;
    try
      Doc.LoadFromFile(FileName);
      Folders := Doc.GetKey('libraryfolders');      // nil if missing
      if Assigned(Folders) then
        for Entry in Folders do                     // for..in over children
          if Entry.TryGetString('path', Path) then
            ...
    finally
      Doc.Free;
    end;

  Differences from Valve's C++ KeyValues (by design):
    * Values are kept as the original text. No type inference, so "007" stays
      "007"; use GetInteger / GetFloat / GetInt64 to convert on demand.
      Getters never modify the node.
    * Syntax errors raise EKeyValuesParseError (with line and column) instead
      of being logged and ignored. Use TryLoadFromFile for a Boolean result.
    * Escape sequences (\\ \" \n \t \r) are ON by default, because Steam
      writes its .vdf/.acf files with escaped backslashes in paths.
    * #include / #base directives are recognised and skipped (not loaded).
    * Key lookup is case-insensitive. Duplicate keys are kept in file order;
      lookups return the first match.
    * Binary KeyValues, the dump contexts, chaining and struct unpacking are
      not implemented.
}
unit wbKeyValues;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections;

type
  EKeyValuesError = class(Exception);

  EKeyValuesParseError = class(EKeyValuesError)
  private
    FLine: Integer;
    FColumn: Integer;
  public
    constructor CreateAt(const aMsg: string; aLine, aColumn: Integer);
    property Line: Integer read FLine;
    property Column: Integer read FColumn;
  end;

  TKeyValuesOption = (
    kvoEscapeSequences,      // translate \\ \" \n \t \r inside quoted tokens (and write them)
    kvoEvaluateConditionals  // honour [$WIN32] style tags; when off, every entry is kept
  );
  TKeyValuesOptions = set of TKeyValuesOption;

const
  cKeyValuesDefaultOptions = [kvoEscapeSequences, kvoEvaluateConditionals];

type
  TKeyValues = class
  private
    FName: string;
    FValue: string;
    FIsSection: Boolean;
    FParent: TKeyValues;
    FChildren: TObjectList<TKeyValues>;
    function GetCount: Integer;
    function GetItem(aIndex: Integer): TKeyValues;
    procedure SetValue(const aValue: string);
    procedure AddChild(aChild: TKeyValues);
    function ForceKey(const aKeyPath: string): TKeyValues;
  public
    /// Creates an (empty) section. Use it with no name as a document root.
    constructor Create(const aName: string = '');
    /// Creates a value node.
    constructor CreateValue(const aName, aValue: string);
    destructor Destroy; override;

    /// Enables: for Child in Node do ...  (iterates direct children in file order)
    function GetEnumerator: TList<TKeyValues>.TEnumerator;

    // ---- Lookup -------------------------------------------------------------
    /// Direct child with this name (case-insensitive), or nil.
    function GetKey(const aName: string): TKeyValues;
    /// Walks a path such as 'AppState/installdir' ('/' or '\' separated).
    /// An empty path returns Self. Returns nil if any part is missing.
    function FindKey(const aKeyPath: string): TKeyValues;
    function HasKey(const aKeyPath: string): Boolean;

    // ---- Reading values (aKeyPath is relative to this node) -----------------
    /// True only if the key exists and is a value (not a section).
    function TryGetString(const aKeyPath: string; out aValue: string): Boolean;
    function TryGetInteger(const aKeyPath: string; out aValue: Integer): Boolean;
    function TryGetInt64(const aKeyPath: string; out aValue: Int64): Boolean;
    function TryGetFloat(const aKeyPath: string; out aValue: Double): Boolean;

    function GetString(const aKeyPath: string; const aDefault: string = ''): string;
    function GetInteger(const aKeyPath: string; aDefault: Integer = 0): Integer;
    function GetInt64(const aKeyPath: string; aDefault: Int64 = 0): Int64;
    function GetFloat(const aKeyPath: string; aDefault: Double = 0): Double;
    /// "1"/"0" style (any non-zero number is True), also accepts true/false.
    function GetBoolean(const aKeyPath: string; aDefault: Boolean = False): Boolean;

    // ---- Writing values -----------------------------------------------------
    /// Creates missing path parts. Turns an existing section into a value.
    procedure SetString(const aKeyPath, aValue: string);
    procedure SetInteger(const aKeyPath: string; aValue: Integer);
    procedure SetInt64(const aKeyPath: string; aValue: Int64);
    procedure SetFloat(const aKeyPath: string; aValue: Double);
    procedure SetBoolean(const aKeyPath: string; aValue: Boolean);

    // ---- Structure ----------------------------------------------------------
    /// Always appends (duplicates allowed, as in the file format).
    function AddValue(const aName, aValue: string): TKeyValues;
    function AddSection(const aName: string): TKeyValues;
    /// Returns the existing child section, or appends a new one.
    function ForceSection(const aKeyPath: string): TKeyValues;
    /// Frees the child.
    procedure Remove(aChild: TKeyValues);
    /// Removes and frees the first direct child with that name.
    function RemoveKey(const aName: string): Boolean;
    /// Detaches the child without freeing it; the caller owns it afterwards.
    function Extract(aChild: TKeyValues): TKeyValues;
    /// Removes all children and the value.
    procedure Clear;

    // ---- Loading / saving ---------------------------------------------------
    // Loading replaces this node's children with the file's top-level entries.
    // Saving writes this node's children as top-level entries, so a document
    // round-trips. Files are read as UTF-8 (BOM honoured) and written as UTF-8
    // without BOM and with LF line endings, as Steam does.
    procedure LoadFromString(const aText: string; aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions);
    procedure LoadFromStream(aStream: TStream; aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions);
    procedure LoadFromFile(const aFileName: string; aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions);
    /// Returns False (and leaves the node empty) on any I/O or syntax error.
    function TryLoadFromFile(const aFileName: string; aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions): Boolean;

    function SaveToString(aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions): string;
    procedure SaveToStream(aStream: TStream; aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions);
    procedure SaveToFile(const aFileName: string; aOptions: TKeyValuesOptions = cKeyValuesDefaultOptions);

    // ---- Properties ---------------------------------------------------------
    property Name: string read FName write FName;
    /// Raw text of a value node ('' for sections). Setting it makes the node a value.
    property Value: string read FValue write SetValue;
    property IsSection: Boolean read FIsSection;
    property Parent: TKeyValues read FParent;
    property Count: Integer read GetCount;
    property Items[aIndex: Integer]: TKeyValues read GetItem; default;
  end;

implementation

uses
  System.Math;

const
  cMaxDepth = 256;

  cIsWindows = {$IFDEF MSWINDOWS}True{$ELSE}False{$ENDIF};
  cIsMacOS   = {$IFDEF MACOS}True{$ELSE}False{$ENDIF};
  cIsLinux   = {$IFDEF LINUX}True{$ELSE}False{$ENDIF};
  cIsPosix   = {$IFDEF POSIX}True{$ELSE}False{$ENDIF};

function SplitKeyPath(const aKeyPath: string): TArray<string>;
begin
  Result := aKeyPath.Split(['/', '\'], TStringSplitOptions.ExcludeEmpty);
end;

function DecodeBytes(const aBytes: TBytes): string;
var
  lEncoding: TEncoding;
  lPreamble: Integer;
begin
  lEncoding := nil;
  lPreamble := TEncoding.GetBufferEncoding(aBytes, lEncoding, TEncoding.UTF8);
  Result := lEncoding.GetString(aBytes, lPreamble, Length(aBytes) - lPreamble);
end;

{ EKeyValuesParseError }

constructor EKeyValuesParseError.CreateAt(const aMsg: string; aLine, aColumn: Integer);
begin
  inherited CreateFmt('%s (line %d, column %d)', [aMsg, aLine, aColumn]);
  FLine := aLine;
  FColumn := aColumn;
end;

{ Parser ---------------------------------------------------------------------- }

type
  TKVTokenKind = (tkEOF, tkString, tkOpenBrace, tkCloseBrace, tkConditional);

  TKVToken = record
    Kind: TKVTokenKind;
    Text: string;
    Quoted: Boolean;
    Line: Integer;
    Column: Integer;
  end;

  TKeyValuesParser = class
  private
    FText: string;
    FPos: Integer;
    FLen: Integer;
    FLine: Integer;
    FLineStart: Integer;
    FOptions: TKeyValuesOptions;
    FHasPeek: Boolean;
    FPeek: TKVToken;
    procedure Advance; inline;
    procedure SkipWhitespaceAndComments;
    function ReadQuoted(const aStart: TKVToken): string;
    function ReadUnquoted: string;
    function ReadRawToken: TKVToken;
    function NextToken: TKVToken;
    function PeekToken: TKVToken;
    procedure Error(const aMsg: string; const aToken: TKVToken);
    function EvaluateConditional(const aText: string): Boolean;
    procedure ParseBody(aNode: TKeyValues; aIsRoot: Boolean; aDepth: Integer);
  public
    constructor Create(const aText: string; aOptions: TKeyValuesOptions);
    procedure Parse(aRoot: TKeyValues);
  end;

constructor TKeyValuesParser.Create(const aText: string; aOptions: TKeyValuesOptions);
begin
  inherited Create;
  FText := aText;
  FLen := Length(aText);
  FPos := 1;
  FLine := 1;
  FLineStart := 1;
  FOptions := aOptions;
end;

procedure TKeyValuesParser.Advance;
begin
  if FText[FPos] = #10 then
  begin
    Inc(FLine);
    FLineStart := FPos + 1;
  end;
  Inc(FPos);
end;

procedure TKeyValuesParser.SkipWhitespaceAndComments;
var
  c: Char;
begin
  while FPos <= FLen do
  begin
    c := FText[FPos];
    if (c <= ' ') or (c = #$FEFF) then
      Advance
    else if (c = '/') and (FPos < FLen) and (FText[FPos + 1] = '/') then
    begin
      while (FPos <= FLen) and (FText[FPos] <> #10) do
        Advance;
    end
    else
      Break;
  end;
end;

function TKeyValuesParser.ReadQuoted(const aStart: TKVToken): string;
var
  sb: TStringBuilder;
  c: Char;
begin
  Advance; // opening quote
  sb := TStringBuilder.Create;
  try
    while FPos <= FLen do
    begin
      c := FText[FPos];
      if c = '"' then
      begin
        Advance;
        Exit(sb.ToString);
      end;

      if (c = '\') and (kvoEscapeSequences in FOptions) and (FPos < FLen) then
      begin
        case FText[FPos + 1] of
          'n': sb.Append(#10);
          't': sb.Append(#9);
          'r': sb.Append(#13);
          '\': sb.Append('\');
          '"': sb.Append('"');
        else
          // Unknown escape: keep the backslash literally, read the next char normally.
          sb.Append('\');
          Advance;
          Continue;
        end;
        Advance;
        Advance;
        Continue;
      end;

      sb.Append(c);
      Advance;
    end;
  finally
    sb.Free;
  end;
  Error('Unterminated quoted string', aStart);
end;

function TKeyValuesParser.ReadUnquoted: string;
var
  lStart: Integer;
  c: Char;
begin
  lStart := FPos;
  while FPos <= FLen do
  begin
    c := FText[FPos];
    if (c <= ' ') or (c = '"') or (c = '{') or (c = '}') then
      Break;
    Advance;
  end;
  Result := Copy(FText, lStart, FPos - lStart);
end;

function TKeyValuesParser.ReadRawToken: TKVToken;
begin
  SkipWhitespaceAndComments;
  Result.Line := FLine;
  Result.Column := FPos - FLineStart + 1;
  Result.Quoted := False;
  Result.Text := '';

  if FPos > FLen then
  begin
    Result.Kind := tkEOF;
    Exit;
  end;

  case FText[FPos] of
    '{':
      begin
        Result.Kind := tkOpenBrace;
        Result.Text := '{';
        Advance;
      end;
    '}':
      begin
        Result.Kind := tkCloseBrace;
        Result.Text := '}';
        Advance;
      end;
    '"':
      begin
        Result.Kind := tkString;
        Result.Quoted := True;
        Result.Text := ReadQuoted(Result);
      end;
  else
    Result.Text := ReadUnquoted;
    if (Length(Result.Text) >= 2) and (Result.Text[1] = '[') and (Result.Text[Length(Result.Text)] = ']') then
      Result.Kind := tkConditional
    else
      Result.Kind := tkString;
  end;
end;

function TKeyValuesParser.NextToken: TKVToken;
begin
  if FHasPeek then
  begin
    FHasPeek := False;
    Result := FPeek;
  end
  else
    Result := ReadRawToken;
end;

function TKeyValuesParser.PeekToken: TKVToken;
begin
  if not FHasPeek then
  begin
    FPeek := ReadRawToken;
    FHasPeek := True;
  end;
  Result := FPeek;
end;

procedure TKeyValuesParser.Error(const aMsg: string; const aToken: TKVToken);
begin
  raise EKeyValuesParseError.CreateAt(aMsg, aToken.Line, aToken.Column);
end;

function TKeyValuesParser.EvaluateConditional(const aText: string): Boolean;
var
  lTag: string;
  lNegate: Boolean;
begin
  if not (kvoEvaluateConditionals in FOptions) then
    Exit(True);

  lTag := Trim(Copy(aText, 2, Length(aText) - 2)); // strip [ ]
  lNegate := lTag.StartsWith('!');
  if lNegate then
    lTag := Trim(Copy(lTag, 2, MaxInt));
  lTag := UpperCase(lTag);

  if lTag = '$WIN32' then          // Valve: "$WIN32 really means IsPC"
    Result := True
  else if lTag = '$WINDOWS' then
    Result := cIsWindows
  else if lTag = '$OSX' then
    Result := cIsMacOS
  else if lTag = '$LINUX' then
    Result := cIsLinux
  else if lTag = '$POSIX' then
    Result := cIsPosix
  else if (lTag = '$X360') or (lTag = '$DECK') then
    Result := False
  else
    Exit(False); // unknown tags are false, even when negated (matches Valve)

  if lNegate then
    Result := not Result;
end;

procedure TKeyValuesParser.ParseBody(aNode: TKeyValues; aIsRoot: Boolean; aDepth: Integer);
var
  lKey, lValue: TKVToken;
  lAccepted: Boolean;
  lChild: TKeyValues;
begin
  while True do
  begin
    lKey := NextToken;
    case lKey.Kind of
      tkEOF:
        if aIsRoot then
          Exit
        else
          Error(Format('Unexpected end of file, "%s" is missing its closing "}"', [aNode.Name]), lKey);
      tkCloseBrace:
        if aIsRoot then
          Error('Unexpected "}"', lKey)
        else
          Exit;
      tkOpenBrace:
        Error('Unexpected "{", expected a key name', lKey);
      tkConditional:
        Error('Unexpected conditional, expected a key name', lKey);
    end;

    // #include / #base "file" — recognised but not loaded.
    if aIsRoot and not lKey.Quoted and
       (SameText(lKey.Text, '#include') or SameText(lKey.Text, '#base')) then
    begin
      NextToken;
      Continue;
    end;

    lAccepted := True;
    lValue := NextToken;
    if lValue.Kind = tkConditional then
    begin
      lAccepted := EvaluateConditional(lValue.Text);
      lValue := NextToken;
    end;

    case lValue.Kind of
      tkOpenBrace:
        begin
          if aDepth >= cMaxDepth then
            Error('Nesting too deep', lValue);
          lChild := TKeyValues.Create(lKey.Text);
          try
            ParseBody(lChild, False, aDepth + 1);
          except
            lChild.Free;
            raise;
          end;
          if lAccepted then
            aNode.AddChild(lChild)
          else
            lChild.Free;
        end;
      tkString:
        begin
          // "key" "value" [$TAG]
          if PeekToken.Kind = tkConditional then
            lAccepted := EvaluateConditional(NextToken.Text) and lAccepted;
          if lAccepted then
            aNode.AddChild(TKeyValues.CreateValue(lKey.Text, lValue.Text));
        end;
    else
      Error(Format('Expected a value or "{" after key "%s"', [lKey.Text]), lValue);
    end;
  end;
end;

procedure TKeyValuesParser.Parse(aRoot: TKeyValues);
begin
  ParseBody(aRoot, True, 0);
end;

{ Writer ---------------------------------------------------------------------- }

function EscapeText(const aText: string; aEscape: Boolean): string;
begin
  Result := aText;
  if aEscape then
    Result := StringReplace(Result, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '\"', [rfReplaceAll]);
end;

procedure WriteChildren(aBuilder: TStringBuilder; aNode: TKeyValues; aIndent: Integer; aEscape: Boolean);
var
  lChild: TKeyValues;
  lTabs: string;
begin
  lTabs := StringOfChar(#9, aIndent);
  for lChild in aNode do
  begin
    aBuilder.Append(lTabs).Append('"').Append(EscapeText(lChild.Name, aEscape)).Append('"');
    if lChild.IsSection then
    begin
      aBuilder.Append(#10).Append(lTabs).Append('{').Append(#10);
      WriteChildren(aBuilder, lChild, aIndent + 1, aEscape);
      aBuilder.Append(lTabs).Append('}').Append(#10);
    end
    else
      aBuilder.Append(#9#9'"').Append(EscapeText(lChild.Value, aEscape)).Append('"'#10);
  end;
end;

{ TKeyValues ------------------------------------------------------------------ }

constructor TKeyValues.Create(const aName: string);
begin
  inherited Create;
  FName := aName;
  FIsSection := True;
  FChildren := TObjectList<TKeyValues>.Create(True);
end;

constructor TKeyValues.CreateValue(const aName, aValue: string);
begin
  Create(aName);
  FIsSection := False;
  FValue := aValue;
end;

destructor TKeyValues.Destroy;
begin
  FChildren.Free;
  inherited;
end;

function TKeyValues.GetEnumerator: TList<TKeyValues>.TEnumerator;
begin
  Result := FChildren.GetEnumerator;
end;

function TKeyValues.GetCount: Integer;
begin
  Result := FChildren.Count;
end;

function TKeyValues.GetItem(aIndex: Integer): TKeyValues;
begin
  Result := FChildren[aIndex];
end;

procedure TKeyValues.SetValue(const aValue: string);
begin
  FChildren.Clear;
  FIsSection := False;
  FValue := aValue;
end;

procedure TKeyValues.AddChild(aChild: TKeyValues);
begin
  if Assigned(aChild.FParent) then
    raise EKeyValuesError.CreateFmt('Key "%s" already belongs to another node', [aChild.Name]);
  FIsSection := True;
  FValue := '';
  aChild.FParent := Self;
  FChildren.Add(aChild);
end;

function TKeyValues.GetKey(const aName: string): TKeyValues;
var
  lChild: TKeyValues;
begin
  for lChild in FChildren do
    if SameText(lChild.FName, aName) then
      Exit(lChild);
  Result := nil;
end;

function TKeyValues.FindKey(const aKeyPath: string): TKeyValues;
var
  lPart: string;
begin
  Result := Self;
  for lPart in SplitKeyPath(aKeyPath) do
  begin
    Result := Result.GetKey(lPart);
    if not Assigned(Result) then
      Exit;
  end;
end;

function TKeyValues.HasKey(const aKeyPath: string): Boolean;
begin
  Result := Assigned(FindKey(aKeyPath));
end;

function TKeyValues.ForceKey(const aKeyPath: string): TKeyValues;
var
  lParts: TArray<string>;
  lNext: TKeyValues;
  i: Integer;
begin
  lParts := SplitKeyPath(aKeyPath);
  Result := Self;
  for i := 0 to High(lParts) do
  begin
    lNext := Result.GetKey(lParts[i]);
    if not Assigned(lNext) then
    begin
      if i < High(lParts) then
        lNext := Result.AddSection(lParts[i])
      else
        lNext := Result.AddValue(lParts[i], '');
    end
    else if (i < High(lParts)) and not lNext.FIsSection then
    begin
      lNext.FIsSection := True; // intermediate value becomes a section
      lNext.FValue := '';
    end;
    Result := lNext;
  end;
end;

function TKeyValues.TryGetString(const aKeyPath: string; out aValue: string): Boolean;
var
  lNode: TKeyValues;
begin
  lNode := FindKey(aKeyPath);
  Result := Assigned(lNode) and not lNode.FIsSection;
  if Result then
    aValue := lNode.FValue
  else
    aValue := '';
end;

function TKeyValues.TryGetInteger(const aKeyPath: string; out aValue: Integer): Boolean;
var
  s: string;
begin
  Result := TryGetString(aKeyPath, s) and TryStrToInt(Trim(s), aValue);
  if not Result then
    aValue := 0;
end;

function TKeyValues.TryGetInt64(const aKeyPath: string; out aValue: Int64): Boolean;
var
  s: string;
begin
  Result := TryGetString(aKeyPath, s);
  if Result then
  begin
    s := Trim(s);
    if s.StartsWith('0x', True) then
      s := '$' + Copy(s, 3, MaxInt); // Valve writes uint64 as 0x + 16 hex digits
    Result := TryStrToInt64(s, aValue);
  end;
  if not Result then
    aValue := 0;
end;

function TKeyValues.TryGetFloat(const aKeyPath: string; out aValue: Double): Boolean;
var
  s: string;
begin
  Result := TryGetString(aKeyPath, s) and TryStrToFloat(Trim(s), aValue, TFormatSettings.Invariant);
  if not Result then
    aValue := 0;
end;

function TKeyValues.GetString(const aKeyPath, aDefault: string): string;
begin
  if not TryGetString(aKeyPath, Result) then
    Result := aDefault;
end;

function TKeyValues.GetInteger(const aKeyPath: string; aDefault: Integer): Integer;
begin
  if not TryGetInteger(aKeyPath, Result) then
    Result := aDefault;
end;

function TKeyValues.GetInt64(const aKeyPath: string; aDefault: Int64): Int64;
begin
  if not TryGetInt64(aKeyPath, Result) then
    Result := aDefault;
end;

function TKeyValues.GetFloat(const aKeyPath: string; aDefault: Double): Double;
begin
  if not TryGetFloat(aKeyPath, Result) then
    Result := aDefault;
end;

function TKeyValues.GetBoolean(const aKeyPath: string; aDefault: Boolean): Boolean;
var
  s: string;
  lInt: Int64;
  lFloat: Double;
begin
  if not TryGetString(aKeyPath, s) then
    Exit(aDefault);
  s := Trim(s);
  if TryStrToInt64(s, lInt) then
    Result := lInt <> 0
  else if TryStrToFloat(s, lFloat, TFormatSettings.Invariant) then
    Result := not IsZero(lFloat)
  else if SameText(s, 'true') then
    Result := True
  else if SameText(s, 'false') then
    Result := False
  else
    Result := aDefault;
end;

procedure TKeyValues.SetString(const aKeyPath, aValue: string);
begin
  ForceKey(aKeyPath).SetValue(aValue);
end;

procedure TKeyValues.SetInteger(const aKeyPath: string; aValue: Integer);
begin
  SetString(aKeyPath, IntToStr(aValue));
end;

procedure TKeyValues.SetInt64(const aKeyPath: string; aValue: Int64);
begin
  SetString(aKeyPath, IntToStr(aValue));
end;

procedure TKeyValues.SetFloat(const aKeyPath: string; aValue: Double);
begin
  SetString(aKeyPath, FloatToStr(aValue, TFormatSettings.Invariant));
end;

procedure TKeyValues.SetBoolean(const aKeyPath: string; aValue: Boolean);
begin
  case aValue of
    True:  SetString(aKeyPath, '1');
    False: SetString(aKeyPath, '0');
  end;
end;

function TKeyValues.AddValue(const aName, aValue: string): TKeyValues;
begin
  Result := TKeyValues.CreateValue(aName, aValue);
  AddChild(Result);
end;

function TKeyValues.AddSection(const aName: string): TKeyValues;
begin
  Result := TKeyValues.Create(aName);
  AddChild(Result);
end;

function TKeyValues.ForceSection(const aKeyPath: string): TKeyValues;
begin
  Result := ForceKey(aKeyPath);
  if not Result.FIsSection then
  begin
    Result.FIsSection := True;
    Result.FValue := '';
  end;
end;

procedure TKeyValues.Remove(aChild: TKeyValues);
begin
  if Assigned(aChild) and (aChild.FParent = Self) then
    FChildren.Remove(aChild);
end;

function TKeyValues.RemoveKey(const aName: string): Boolean;
var
  lChild: TKeyValues;
begin
  lChild := GetKey(aName);
  Result := Assigned(lChild);
  if Result then
    FChildren.Remove(lChild);
end;

function TKeyValues.Extract(aChild: TKeyValues): TKeyValues;
begin
  Result := nil;
  if Assigned(aChild) and (aChild.FParent = Self) then
  begin
    Result := FChildren.Extract(aChild);
    Result.FParent := nil;
  end;
end;

procedure TKeyValues.Clear;
begin
  FChildren.Clear;
  FValue := '';
end;

procedure TKeyValues.LoadFromString(const aText: string; aOptions: TKeyValuesOptions);
var
  lParser: TKeyValuesParser;
begin
  Clear;
  FIsSection := True;
  lParser := TKeyValuesParser.Create(aText, aOptions);
  try
    try
      lParser.Parse(Self);
    except
      Clear;
      raise;
    end;
  finally
    lParser.Free;
  end;
end;

procedure TKeyValues.LoadFromStream(aStream: TStream; aOptions: TKeyValuesOptions);
var
  lBytes: TBytes;
begin
  SetLength(lBytes, aStream.Size - aStream.Position);
  if Length(lBytes) > 0 then
    aStream.ReadBuffer(lBytes[0], Length(lBytes));
  LoadFromString(DecodeBytes(lBytes), aOptions);
end;

procedure TKeyValues.LoadFromFile(const aFileName: string; aOptions: TKeyValuesOptions);
var
  lStream: TFileStream;
begin
  // Share-deny-none so we can read while Steam has the file open.
  lStream := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone);
  try
    try
      LoadFromStream(lStream, aOptions);
    except
      on E: EKeyValuesParseError do
      begin
        E.Message := aFileName + ': ' + E.Message;
        raise;
      end;
    end;
  finally
    lStream.Free;
  end;
end;

function TKeyValues.TryLoadFromFile(const aFileName: string; aOptions: TKeyValuesOptions): Boolean;
begin
  try
    LoadFromFile(aFileName, aOptions);
    Result := True;
  except
    on Exception do
    begin
      Clear;
      Result := False;
    end;
  end;
end;

function TKeyValues.SaveToString(aOptions: TKeyValuesOptions): string;
var
  lBuilder: TStringBuilder;
begin
  lBuilder := TStringBuilder.Create;
  try
    WriteChildren(lBuilder, Self, 0, kvoEscapeSequences in aOptions);
    Result := lBuilder.ToString;
  finally
    lBuilder.Free;
  end;
end;

procedure TKeyValues.SaveToStream(aStream: TStream; aOptions: TKeyValuesOptions);
var
  lBytes: TBytes;
begin
  lBytes := TEncoding.UTF8.GetBytes(SaveToString(aOptions)); // no BOM
  if Length(lBytes) > 0 then
    aStream.WriteBuffer(lBytes[0], Length(lBytes));
end;

procedure TKeyValues.SaveToFile(const aFileName: string; aOptions: TKeyValuesOptions);
var
  lStream: TFileStream;
begin
  lStream := TFileStream.Create(aFileName, fmCreate);
  try
    SaveToStream(lStream, aOptions);
  finally
    lStream.Free;
  end;
end;

end.
