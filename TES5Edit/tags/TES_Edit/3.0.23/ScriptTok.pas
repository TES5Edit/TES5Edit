{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit ScriptTok;
interface
uses
  Windows,
  SysUtils,
  CocoaBase;

const
  TOK_eof = 0;
  TOK_whitespace = 1;
  TOK_comment = 2;
  TOK_signature = 3;
  TOK_identifier = 4;
  TOK_stringQ = 5;
  TOK_semicolon = 6;
  TOK_number = 7;
  TOK_float = 8;
  TOK__124__124_ = 9;
  TOK__47_ = 10;
  TOK__41_ = 11;
  TOK__40_ = 12;
  TOK__43_ = 13;
  TOK__45_ = 14;
  TOK__42_ = 15;
  TOK_MATCH = 16;
  TOK_WHERE = 17;
  TOK_BEGIN = 18;
  TOK_END = 19;
  TOK_SET = 20;
  TOK_TO = 21;
  TOK_MODIFY = 22;
  TOK_OFFSET = 23;
  TOK_FACTOR = 24;
  TOK_INCLUDE = 25;
  TOK_EXCLUDE = 26;
  TOK_OR = 27;
  TOK_AND = 28;
  TOK_NOT = 29;
  TOK__45__62_ = 30;
  TOK_div = 31;
  TOK_mod = 32;
  
  TokStr : array[0..32] of string = (
  '<eof>',
  '<white-space>',
  '<comment>',
  '<signature>',
  '<identifier>',
  '<stringQ>',
  '<semicolon>',
  '<number>',
  '<float>',
  '|' + '|',
  '/',
  ')',
  '(',
  '+',
  '-',
  '*',
  'MATCH',
  'WHERE',
  'BEGIN',
  'END',
  'SET',
  'TO',
  'MODIFY',
  'OFFSET',
  'FACTOR',
  'INCLUDE',
  'EXCLUDE',
  'OR',
  'AND',
  'NOT',
  '->',
  'div',
  'mod');
  FirstKeyword = 16;
  LastKeyword = 30;
  FirstDirective = 31;
  LastDirective = 32;


type
  TScriptTokenizer = class(TBaseTokenizer)
  protected
    function isTokTerm_float: Boolean;
    function isTokFactor_number: Boolean;
    function isTokFactor_semicolon: Boolean;
    function isTokFactor_stringQ_3: Boolean;
    function isTokFactor_stringQ_2: Boolean;
    function isTokFactor_stringQ: Boolean;
    function isTokTerm_stringQ: Boolean;
    function isTokFactor_identifier_7: Boolean;
    function isTokFactor_identifier_6: Boolean;
    function isTokFactor_identifier_5: Boolean;
    function isTokTerm_identifier_2: Boolean;
    function isTokFactor_identifier_4: Boolean;
    function isTokFactor_identifier_3: Boolean;
    function isTokFactor_identifier_2: Boolean;
    function isTokFactor_identifier: Boolean;
    function isTokTerm_identifier: Boolean;
    function isTokFactor_signature: Boolean;
    function isTokTerm_signature: Boolean;
  public
    function Tokenize(Buffer: PChar; Size: Integer;
      IncludeComments, IncludeWhitespace: Boolean;
        var Tokens: TTokenList): Boolean; override;
  end;

function IsKeyword(const Str: string): Boolean;

implementation
var
  KeywordTree: TTernaryTree;

function TScriptTokenizer.isTokFactor_signature: Boolean;
begin
  case Peek of
  'A'..'Z', '_', 'a'..'z' :
    begin
      Advance;
      Result := True;
    end;
  else
    Result := False;
  end;
end;

function TScriptTokenizer.isTokTerm_signature: Boolean;
begin
  Push;
  Result := isTokFactor_signature and isTokFactor_signature and isTokFactor_signature and isTokFactor_signature;
  IfDropElsePop(Result);
end;

function TScriptTokenizer.isTokFactor_identifier_2: Boolean;
begin
  case Peek of
  '0'..'9' :
    begin
      Advance;
      Result := True;
    end;
  else
    Result := False;
  end;
end;

function TScriptTokenizer.isTokFactor_identifier_3: Boolean;
begin
  if Peek = '/' then begin
    Advance;
    Result := True;
  end else
    Result := False;
end;

function TScriptTokenizer.isTokFactor_identifier_4: Boolean;
begin
  if Peek = '.' then begin
    Advance;
    Result := True;
  end else
    Result := False;
end;

function TScriptTokenizer.isTokFactor_identifier: Boolean;
begin
  if ((isTokFactor_signature or isTokFactor_identifier_2 or isTokFactor_identifier_3 or isTokFactor_identifier_4)) then begin
    Result := true;
    while ((isTokFactor_signature or isTokFactor_identifier_2 or isTokFactor_identifier_3 or isTokFactor_identifier_4)) do
      ;
  end else
    Result := false;
end;

function TScriptTokenizer.isTokTerm_identifier: Boolean;
begin
  Push;
  Result := isTokFactor_signature and isTokFactor_identifier;
  IfDropElsePop(Result);
end;

function TScriptTokenizer.isTokFactor_identifier_5: Boolean;
begin
  if Peek = '"' then begin
    Advance;
    Result := True;
  end else
    Result := False;
end;

function TScriptTokenizer.isTokFactor_identifier_7: Boolean;
begin
  case Peek of
  #10, #13, ' '..'!', '#'..'ÿ' :
    begin
      Advance;
      Result := True;
    end;
  else
    Result := False;
  end;
end;

function TScriptTokenizer.isTokFactor_identifier_6: Boolean;
begin
  if (isTokFactor_identifier_7) then begin
    repeat
    until not (isTokFactor_identifier_7);
  end;
  Result := true;
end;

function TScriptTokenizer.isTokTerm_identifier_2: Boolean;
begin
  Push;
  Result := isTokFactor_identifier_5 and isTokFactor_identifier_6 and isTokFactor_identifier_5;
  IfDropElsePop(Result);
end;

function TScriptTokenizer.isTokFactor_stringQ: Boolean;
begin
  if Peek = #39 then begin
    Advance;
    Result := True;
  end else
    Result := False;
end;

function TScriptTokenizer.isTokFactor_stringQ_3: Boolean;
begin
  case Peek of
  #10, #13, ' '..'&', '('..'ÿ' :
    begin
      Advance;
      Result := True;
    end;
  else
    Result := False;
  end;
end;

function TScriptTokenizer.isTokFactor_stringQ_2: Boolean;
begin
  if (isTokFactor_stringQ_3) then begin
    repeat
    until not (isTokFactor_stringQ_3);
  end;
  Result := true;
end;

function TScriptTokenizer.isTokTerm_stringQ: Boolean;
begin
  Push;
  Result := isTokFactor_stringQ and isTokFactor_stringQ_2 and isTokFactor_stringQ;
  IfDropElsePop(Result);
end;

function TScriptTokenizer.isTokFactor_semicolon: Boolean;
begin
  if Peek = ';' then begin
    Advance;
    Result := True;
  end else
    Result := False;
end;

function TScriptTokenizer.isTokFactor_number: Boolean;
begin
  if (isTokFactor_identifier_2) then begin
    Result := true;
    while (isTokFactor_identifier_2) do
      ;
  end else
    Result := false;
end;

function TScriptTokenizer.isTokTerm_float: Boolean;
begin
  Push;
  Result := isTokFactor_number and isTokFactor_identifier_4 and isTokFactor_number;
  IfDropElsePop(Result);
end;

function TScriptTokenizer.Tokenize(Buffer: PChar; Size: Integer;
  IncludeComments, IncludeWhitespace: Boolean;
  var Tokens: TTokenList): Boolean;

  procedure AddToken(TokenType: Integer);
  begin
    Tokens.AddToken(StartPtr, CurPtr,
      StartLine, CurLine, StartPos, CurPos, TokenType);
  end;

var
  b: boolean;
var
  i: Integer;
  SaveChar: Char;
begin
  Tokens := TTokenList.Create;
  CurPtr := PChar(Buffer);
  EndPtr := PChar(DWord(CurPtr) + DWord(Size));
  CurLine := 1;
  CurPos := 1;
  try
    while CurPtr < EndPtr do begin
      b := false;
      StartPtr := CurPtr;
      StartLine := CurLine;
      StartPos := CurPos;
      if (Peek(0) = '#') then begin
        Advance(1);
        b := true;
      end;
      if b then begin
        b := false;
        if (char(Peek(0)) in [ #13]) then begin
          Advance(1);
          b := true;
        end;
        if not b and (Peek <> #0) then
          repeat
            Advance;
            if (char(Peek(0)) in [ #13]) then begin
              Advance(1);
              b := true;
            end;
          until b or (Peek = #0);
        if IncludeComments then
          AddToken(TOK_comment);
        continue;
      end;
      if char(CurPtr^) in [#1..' '] then begin
        Advance;
        while char(Peek) in [#1..' '] do
          Advance;
        if IncludeWhitespace then
          AddToken(TOK_whitespace);
        continue;
      end;
      if (isTokTerm_signature) then begin
        AddToken(TOK_signature);
        continue;
      end;
      if (isTokTerm_identifier or isTokTerm_identifier_2) then begin
        SaveChar := CurPtr^;
        CurPtr^ := #0;
        i := KeywordTree.SearchUC(StartPtr);
        CurPtr^ := SaveChar;
        if i <> 0 then
          AddToken(i)
        else
          AddToken(TOK_identifier);
        continue;
      end;
      if (isTokTerm_stringQ) then begin
        AddToken(TOK_stringQ);
        continue;
      end;
      if (isTokFactor_semicolon) then begin
        AddToken(TOK_semicolon);
        continue;
      end;
      if (isTokFactor_number) then begin
        AddToken(TOK_number);
        continue;
      end;
      if (isTokTerm_float) then begin
        AddToken(TOK_float);
        continue;
      end;
      if (CurPtr^ = '|') and (Peek(1) = '|') then begin
        Advance(2);
        AddToken(TOK__124__124_);
        continue;
      end;
      case CurPtr^ of
      '/' : AddToken(TOK__47_);
      ')' : AddToken(TOK__41_);
      '(' : AddToken(TOK__40_);
      '+' : AddToken(TOK__43_);
      '-' : AddToken(TOK__45_);
      '*' : AddToken(TOK__42_);
      #0 :
        begin
          AddToken(TOK_eof);
          Result := True;
          exit;
        end;
      else
        break;
      end;
      Advance;
      continue;
    end;
    if CurPtr >= EndPtr then begin
      AddToken(TOK_eof);
      Result := True;
    end else
      Result := False;
  except
    Result := False;
  end;
end;

function IsKeyword(const Str: string): Boolean;
var
  i: Integer;
begin
  i := KeywordTree.SearchUC(PAnsiChar(Str));
  Result := (i >= FirstKeyword) and (i <= LastKeyword);
end;

procedure InitKeywordTree;
var i: Integer;
begin
  KeywordTree := TTernaryTree.Create;
  for i := FirstKeyword to LastKeyword do
    KeywordTree.InsertStr(PChar(TokStr[i]), i);
  for i := FirstDirective to LastDirective do
    KeywordTree.InsertStr(PChar(TokStr[i]), i);
end;

initialization
  InitKeywordTree;
finalization
  KeywordTree.Free;
end.
