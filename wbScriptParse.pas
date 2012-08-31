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

unit wbScriptParse;
interface
uses
  Windows,
  Classes,
  SysUtils,
  CocoaBase,
  wbScriptTok,
  wbScript;

type
  TwbScriptParser = class(TBaseParser)
  protected
    function TokenStr(Token: Integer): string; override;
    function MatchIdent: Boolean;
    procedure compPROD_FieldRef(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_Literal(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_SimpleFactor(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_NestedFactor(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_PositiveFactor(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_Factor(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_TermPoint(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_TermDash(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_TermNot(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_TermAnd(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_TermOr(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_MatchExpression(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_Expression(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_ModifyStatement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_SetStatement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_WithStatement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_StatementBlock(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_Statement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_Statements(const aStatementContainer: IwbStatementContainer);
    procedure compPROD_wbScript;
    function isPROD_FieldRef: Boolean;
    function IsParseTerm_Literal: Boolean;
    function isPROD_Literal: Boolean;
    function IsProduction_SimpleFactor_2: Boolean;
    function IsParseFactor_SimpleFactor_2: Boolean;
    function IsParseTerm_SimpleFactor_2: Boolean;
    function IsParseFactor_SimpleFactor: Boolean;
    function IsProduction_SimpleFactor: Boolean;
    function IsParseTerm_SimpleFactor: Boolean;
    function isPROD_SimpleFactor: Boolean;
    function IsParseTerm_NestedFactor: Boolean;
    function isPROD_NestedFactor: Boolean;
    function isPROD_PositiveFactor: Boolean;
    function IsParseFactor_Factor: Boolean;
    function IsParseTerm_Factor: Boolean;
    function isPROD_Factor: Boolean;
    function IsProduction_TermPoint: Boolean;
    function IsParseTerm_TermPoint_2: Boolean;
    function IsParseFactor_TermPoint: Boolean;
    function IsParseTerm_TermPoint: Boolean;
    function isPROD_TermPoint: Boolean;
    function IsProduction_TermDash: Boolean;
    function IsParseTerm_TermDash_2: Boolean;
    function IsParseFactor_TermDash: Boolean;
    function IsParseTerm_TermDash: Boolean;
    function isPROD_TermDash: Boolean;
    function IsParseFactor_TermNot: Boolean;
    function IsParseTerm_TermNot: Boolean;
    function isPROD_TermNot: Boolean;
    function IsParseTerm_TermAnd_2: Boolean;
    function IsParseFactor_TermAnd: Boolean;
    function IsParseTerm_TermAnd: Boolean;
    function isPROD_TermAnd: Boolean;
    function IsParseTerm_TermOr_2: Boolean;
    function IsParseFactor_TermOr: Boolean;
    function IsParseTerm_TermOr: Boolean;
    function isPROD_TermOr: Boolean;
    function IsParseTerm_MatchExpression_2: Boolean;
    function IsParseFactor_MatchExpression: Boolean;
    function IsParseTerm_MatchExpression: Boolean;
    function isPROD_MatchExpression: Boolean;
    function IsProduction_Expression: Boolean;
    function isPROD_Expression: Boolean;
    function IsProduction_ModifyStatement: Boolean;
    function IsParseTerm_ModifyStatement: Boolean;
    function isPROD_ModifyStatement: Boolean;
    function IsParseTerm_SetStatement: Boolean;
    function isPROD_SetStatement: Boolean;
    function IsParseFactor_WithStatement_2: Boolean;
    function IsParseFactor_WithStatement: Boolean;
    function IsParseTerm_WithStatement: Boolean;
    function isPROD_WithStatement: Boolean;
    function IsParseTerm_StatementBlock: Boolean;
    function isPROD_StatementBlock: Boolean;
    function IsProduction_Statement: Boolean;
    function isPROD_Statement: Boolean;
    function IsParseTerm_Statements: Boolean;
    function IsParseFactor_Statements: Boolean;
    function isPROD_Statements: Boolean;
    function isPROD_wbScript: Boolean;
  public
    ScriptBuilder : IwbScriptBuilder;
  public
    constructor Create(Tokens: TTokenList);
    function Parse: Boolean; override;
    procedure Compile; override;
  end;

implementation

function TwbScriptParser.TokenStr(Token: Integer): string;
begin
  Result := TokStr[Token];
end;

function TwbScriptParser.MatchIdent: Boolean;
begin
  Result := 
    Match(TOK_identifier) or 
    MatchInterval(FirstDirective, LastDirective);
end;

function TwbScriptParser.isPROD_wbScript: Boolean;
begin
  Result := Match(TOK_eof);
end;

function TwbScriptParser.IsParseTerm_Statements: Boolean;
begin
  Push;
  Result := isPROD_Statement and Match(TOK_semicolon);
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_Statements: Boolean;
begin
  PushAddCode_1;
  if IsParseTerm_Statements then begin
    dec(STP); { Drop; }
    PushAddCode_1;
    while IsParseTerm_Statements do begin
      dec(STP); { Drop; }
      PushAddCode_1;
    end;
    PopAddCode_0;
    Result := true;
  end else begin
    Pop;
    Result := false;
  end;
end;

function TwbScriptParser.isPROD_Statements: Boolean;
begin
  Result := IsParseFactor_Statements;
end;

function TwbScriptParser.IsProduction_Statement: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if isPROD_StatementBlock then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if isPROD_WithStatement then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      PopPushAddCode(2);
      if isPROD_SetStatement then begin
        dec(STP); { Drop; }
        Result := True;
      end else begin
        PopPushAddCode(3);
        if isPROD_ModifyStatement then begin
          dec(STP); { Drop; }
          Result := True;
        end else begin
          Pop;
        end;
      end;
    end;
  end;
end;

function TwbScriptParser.isPROD_Statement: Boolean;
begin
  Result := IsProduction_Statement;
end;

function TwbScriptParser.IsParseTerm_StatementBlock: Boolean;
begin
  Push;
  Result := Match(TOK_BEGIN) and isPROD_Statements and Match(TOK_END);
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_StatementBlock: Boolean;
begin
  Result := IsParseTerm_StatementBlock;
end;

function TwbScriptParser.IsParseFactor_WithStatement: Boolean;
begin
  PushAddCode_1;
  if not Match(TOK_EACH) then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseFactor_WithStatement_2: Boolean;
begin
  PushAddCode_1;
  if not isPROD_Statement then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseTerm_WithStatement: Boolean;
begin
  Push;
  Result := Match(TOK_WITH) and IsParseFactor_WithStatement and isPROD_Expression and Match(TOK_DO) and IsParseFactor_WithStatement_2;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_WithStatement: Boolean;
begin
  Result := IsParseTerm_WithStatement;
end;

function TwbScriptParser.IsParseTerm_SetStatement: Boolean;
begin
  Push;
  Result := Match(TOK_SET) and isPROD_FieldRef and Match(TOK_TO) and isPROD_Expression;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_SetStatement: Boolean;
begin
  Result := IsParseTerm_SetStatement;
end;

function TwbScriptParser.IsProduction_ModifyStatement: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if Match(TOK_OFFSET) then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if Match(TOK_FACTOR) then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      PopPushAddCode(2);
      if Match(TOK_INCLUDE) then begin
        dec(STP); { Drop; }
        Result := True;
      end else begin
        PopPushAddCode(3);
        if Match(TOK_EXCLUDE) then begin
          dec(STP); { Drop; }
          Result := True;
        end else begin
          Pop;
        end;
      end;
    end;
  end;
end;

function TwbScriptParser.IsParseTerm_ModifyStatement: Boolean;
begin
  Push;
  Result := Match(TOK_MODIFY) and isPROD_FieldRef and IsProduction_ModifyStatement and isPROD_Expression;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_ModifyStatement: Boolean;
begin
  Result := IsParseTerm_ModifyStatement;
end;

function TwbScriptParser.IsProduction_Expression: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if isPROD_MatchExpression then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if isPROD_TermOr then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      Pop;
    end;
  end;
end;

function TwbScriptParser.isPROD_Expression: Boolean;
begin
  Result := IsProduction_Expression;
end;

function TwbScriptParser.IsParseTerm_MatchExpression_2: Boolean;
begin
  Push;
  Result := Match(TOK_WHERE) and isPROD_Expression;
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_MatchExpression: Boolean;
begin
  PushAddCode_1;
  if not IsParseTerm_MatchExpression_2 then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseTerm_MatchExpression: Boolean;
begin
  Push;
  Result := Match(TOK_MATCH) and Match(TOK_signature) and IsParseFactor_MatchExpression;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_MatchExpression: Boolean;
begin
  Result := IsParseTerm_MatchExpression;
end;

function TwbScriptParser.IsParseTerm_TermOr_2: Boolean;
begin
  Push;
  Result := Match(TOK_OR) and isPROD_TermAnd;
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_TermOr: Boolean;
begin
  PushAddCode_1;
  if IsParseTerm_TermOr_2 then begin
    dec(STP); { Drop; }
    PushAddCode_1;
    while IsParseTerm_TermOr_2 do begin
      dec(STP); { Drop; }
      PushAddCode_1;
    end;
    PopAddCode_0;
  end else begin
    PopAddCode_0;
  end;
  Result := true;
end;

function TwbScriptParser.IsParseTerm_TermOr: Boolean;
begin
  Push;
  Result := isPROD_TermAnd and IsParseFactor_TermOr;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_TermOr: Boolean;
begin
  Result := IsParseTerm_TermOr;
end;

function TwbScriptParser.IsParseTerm_TermAnd_2: Boolean;
begin
  Push;
  Result := Match(TOK_AND) and isPROD_TermAnd;
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_TermAnd: Boolean;
begin
  PushAddCode_1;
  if IsParseTerm_TermAnd_2 then begin
    dec(STP); { Drop; }
    PushAddCode_1;
    while IsParseTerm_TermAnd_2 do begin
      dec(STP); { Drop; }
      PushAddCode_1;
    end;
    PopAddCode_0;
  end else begin
    PopAddCode_0;
  end;
  Result := true;
end;

function TwbScriptParser.IsParseTerm_TermAnd: Boolean;
begin
  Push;
  Result := isPROD_TermNot and IsParseFactor_TermAnd;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_TermAnd: Boolean;
begin
  Result := IsParseTerm_TermAnd;
end;

function TwbScriptParser.IsParseFactor_TermNot: Boolean;
begin
  PushAddCode_1;
  if not Match(TOK_NOT) then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseTerm_TermNot: Boolean;
begin
  Push;
  Result := IsParseFactor_TermNot and isPROD_TermDash;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_TermNot: Boolean;
begin
  Result := IsParseTerm_TermNot;
end;

function TwbScriptParser.IsProduction_TermDash: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if Match(TOK__43_) { '+' } then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if Match(TOK__45_) { '-' } then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      PopPushAddCode(2);
      if Match(TOK__124__124_) { '||' } then begin
        dec(STP); { Drop; }
        Result := True;
      end else begin
        Pop;
      end;
    end;
  end;
end;

function TwbScriptParser.IsParseTerm_TermDash_2: Boolean;
begin
  Push;
  Result := IsProduction_TermDash and isPROD_TermPoint;
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_TermDash: Boolean;
begin
  PushAddCode_1;
  if IsParseTerm_TermDash_2 then begin
    dec(STP); { Drop; }
    PushAddCode_1;
    while IsParseTerm_TermDash_2 do begin
      dec(STP); { Drop; }
      PushAddCode_1;
    end;
    PopAddCode_0;
  end else begin
    PopAddCode_0;
  end;
  Result := true;
end;

function TwbScriptParser.IsParseTerm_TermDash: Boolean;
begin
  Push;
  Result := isPROD_TermPoint and IsParseFactor_TermDash;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_TermDash: Boolean;
begin
  Result := IsParseTerm_TermDash;
end;

function TwbScriptParser.IsProduction_TermPoint: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if Match(TOK__42_) { '*' } then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if Match(TOK__47_) { '/' } then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      PopPushAddCode(2);
      if Match(TOK_div) { 'div' } then begin
        dec(STP); { Drop; }
        Result := True;
      end else begin
        PopPushAddCode(3);
        if Match(TOK_mod) { 'mod' } then begin
          dec(STP); { Drop; }
          Result := True;
        end else begin
          Pop;
        end;
      end;
    end;
  end;
end;

function TwbScriptParser.IsParseTerm_TermPoint_2: Boolean;
begin
  Push;
  Result := IsProduction_TermPoint and isPROD_Factor;
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_TermPoint: Boolean;
begin
  PushAddCode_1;
  if IsParseTerm_TermPoint_2 then begin
    dec(STP); { Drop; }
    PushAddCode_1;
    while IsParseTerm_TermPoint_2 do begin
      dec(STP); { Drop; }
      PushAddCode_1;
    end;
    PopAddCode_0;
  end else begin
    PopAddCode_0;
  end;
  Result := true;
end;

function TwbScriptParser.IsParseTerm_TermPoint: Boolean;
begin
  Push;
  Result := isPROD_Factor and IsParseFactor_TermPoint;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_TermPoint: Boolean;
begin
  Result := IsParseTerm_TermPoint;
end;

function TwbScriptParser.IsParseFactor_Factor: Boolean;
begin
  PushAddCode_1;
  if not Match(TOK__45_) { '-' } then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseTerm_Factor: Boolean;
begin
  Push;
  Result := IsParseFactor_Factor and isPROD_PositiveFactor;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_Factor: Boolean;
begin
  Result := IsParseTerm_Factor;
end;

function TwbScriptParser.isPROD_PositiveFactor: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if isPROD_NestedFactor then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if isPROD_SimpleFactor then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      Pop;
    end;
  end;
end;

function TwbScriptParser.IsParseTerm_NestedFactor: Boolean;
begin
  Push;
  Result := Match(TOK__40_) { '(' } and isPROD_Expression and Match(TOK__41_) { ')' };
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_NestedFactor: Boolean;
begin
  Result := IsParseTerm_NestedFactor;
end;

function TwbScriptParser.IsProduction_SimpleFactor: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if isPROD_Literal then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if isPROD_FieldRef then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      Pop;
    end;
  end;
end;

function TwbScriptParser.IsProduction_SimpleFactor_2: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if isPROD_NestedFactor then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if isPROD_FieldRef then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      Pop;
    end;
  end;
end;

function TwbScriptParser.IsParseFactor_SimpleFactor_2: Boolean;
begin
  PushAddCode_1;
  if not IsProduction_SimpleFactor_2 then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseTerm_SimpleFactor_2: Boolean;
begin
  Push;
  Result := Match(TOK__45__62_) and IsParseFactor_SimpleFactor_2;
  IfDropElsePop(Result);
end;

function TwbScriptParser.IsParseFactor_SimpleFactor: Boolean;
begin
  PushAddCode_1;
  if not IsParseTerm_SimpleFactor_2 then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TwbScriptParser.IsParseTerm_SimpleFactor: Boolean;
begin
  Push;
  Result := IsProduction_SimpleFactor and IsParseFactor_SimpleFactor;
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_SimpleFactor: Boolean;
begin
  Result := IsParseTerm_SimpleFactor;
end;

function TwbScriptParser.IsParseTerm_Literal: Boolean;
begin
  Push;
  Result := Match(TOK_FORMID) and Match(TOK_stringQ);
  IfDropElsePop(Result);
end;

function TwbScriptParser.isPROD_Literal: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if Match(TOK_stringQ) then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if Match(TOK_float) then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      PopPushAddCode(2);
      if Match(TOK_number) then begin
        dec(STP); { Drop; }
        Result := True;
      end else begin
        PopPushAddCode(3);
        if IsParseTerm_Literal then begin
          dec(STP); { Drop; }
          Result := True;
        end else begin
          Pop;
        end;
      end;
    end;
  end;
end;

function TwbScriptParser.isPROD_FieldRef: Boolean;
begin
  Result := MatchIdent;
end;

procedure TwbScriptParser.compPROD_wbScript;
begin
  Inc(TokenPtr); { eof }
end;

procedure TwbScriptParser.compPROD_Statements(const aStatementContainer: IwbStatementContainer);
var StatementBuilder: IwbStatementBuilder;
begin
  while GetCode <> 0 do begin
    begin
      compPROD_Statement(StatementBuilder);
      aStatementContainer.AddStatement(StatementBuilder);
      StatementBuilder := nil;
      Inc(TokenPtr); { semicolon }
    end;
  end;
end;

procedure TwbScriptParser.compPROD_Statement(var aStatementBuilder: IwbStatementBuilder);
begin
  case GetCode of
  0:
    compPROD_StatementBlock(aStatementBuilder);
  1:
    compPROD_WithStatement(aStatementBuilder);
  2:
    compPROD_SetStatement(aStatementBuilder);
  3:
    compPROD_ModifyStatement(aStatementBuilder);
  end;
end;

procedure TwbScriptParser.compPROD_StatementBlock(var aStatementBuilder: IwbStatementBuilder);
begin
  begin
    Inc(TokenPtr);  { "BEGIN" }
    aStatementBuilder := ScriptBuilder.CreateStatementBlock;
    compPROD_Statements(aStatementBuilder as IwbStatementContainer);
    Inc(TokenPtr);  { "END" }
  end;
end;

procedure TwbScriptParser.compPROD_WithStatement(var aStatementBuilder: IwbStatementBuilder);
var IsEach: Boolean; Expression: IwbExpressionBuilder; Statement: IwbStatementBuilder;
begin
  begin
    IsEach := False;
    Expression := nil;
    Statement := nil;
    Inc(TokenPtr);  { "WITH" }
    if GetCode <> 0 then
      begin
        Inc(TokenPtr);  { "EACH" }
        IsEach := True;
      end;
    compPROD_Expression(Expression);
    Inc(TokenPtr);  { "DO" }
    if GetCode <> 0 then
      compPROD_Statement(Statement);
    aStatementBuilder := ScriptBuilder.CreateWithStatement(IsEach, Expression, Statement);
  end;
end;

procedure TwbScriptParser.compPROD_SetStatement(var aStatementBuilder: IwbStatementBuilder);
var Field, Expression: IwbExpressionBuilder;
begin
  begin
    Inc(TokenPtr);  { "SET" }
    compPROD_FieldRef(Field);
    Inc(TokenPtr);  { "TO" }
    compPROD_Expression(Expression);
    aStatementBuilder := ScriptBuilder.CreateSetStatement(Field, Expression);
  end;
end;

procedure TwbScriptParser.compPROD_ModifyStatement(var aStatementBuilder: IwbStatementBuilder);
var Field, Expression: IwbExpressionBuilder; ModifyType: TwbModifyType;
begin
  begin
    Inc(TokenPtr);  { "MODIFY" }
    compPROD_FieldRef(Field);
    case GetCode of
    0:
      begin
        Inc(TokenPtr);  { "OFFSET" }
        ModifyType := mtOffset;
      end;
    1:
      begin
        Inc(TokenPtr);  { "FACTOR" }
        ModifyType := mtFactor;
      end;
    2:
      begin
        Inc(TokenPtr);  { "INCLUDE" }
        ModifyType := mtInclude;
      end;
    3:
      begin
        Inc(TokenPtr);  { "EXCLUDE" }
        ModifyType := mtExclude;
      end;
    end;
    compPROD_Expression(Expression);
    aStatementBuilder := ScriptBuilder.CreateModifyStatement(Field, ModifyType, Expression);
  end;
end;

procedure TwbScriptParser.compPROD_Expression(var aExpressionBuilder: IwbExpressionBuilder);
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    case GetCode of
    0:
      compPROD_MatchExpression(aExpressionBuilder);
    1:
      compPROD_TermOr(aExpressionBuilder);
    end;
  end;
end;

procedure TwbScriptParser.compPROD_MatchExpression(var aExpressionBuilder: IwbExpressionBuilder);
var Signature: PTokenRecord; Expression: IwbExpressionBuilder;
begin
  begin
    Inc(TokenPtr);  { "MATCH" }
    Inc(TokenPtr); { signature }
    Signature := CurTokenPtr;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr);  { "WHERE" }
        compPROD_Expression(Expression);
      end;
    aExpressionBuilder.AddMatch(Signature, Expression);
  end;
end;

procedure TwbScriptParser.compPROD_TermOr(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    TermHandle := aExpressionBuilder.BeginTerm;
    compPROD_TermAnd(aExpressionBuilder);
    while GetCode <> 0 do begin
      begin
        Inc(TokenPtr);  { "OR" }
        aExpressionBuilder.SetOperator(opOr);
        compPROD_TermAnd(aExpressionBuilder);
      end;
    end;
    aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TwbScriptParser.compPROD_TermAnd(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    TermHandle := aExpressionBuilder.BeginTerm;
    compPROD_TermNot(aExpressionBuilder);
    while GetCode <> 0 do begin
      begin
        Inc(TokenPtr);  { "AND" }
        aExpressionBuilder.SetOperator(opAnd);
        compPROD_TermAnd(aExpressionBuilder);
      end;
    end;
    aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TwbScriptParser.compPROD_TermNot(var aExpressionBuilder: IwbExpressionBuilder);
var IsNot: Boolean; TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    IsNot := False;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr);  { "NOT" }
        IsNot := True;
      end;
    if IsNot then TermHandle := aExpressionBuilder.BeginUnaryTerm(uoNot);
    compPROD_TermDash(aExpressionBuilder);
    if IsNot then aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TwbScriptParser.compPROD_TermDash(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    TermHandle := aExpressionBuilder.BeginTerm;
    compPROD_TermPoint(aExpressionBuilder);
    while GetCode <> 0 do begin
      begin
        case GetCode of
        0:
          begin
            Inc(TokenPtr); { '+' }
            aExpressionBuilder.SetOperator(opPlus);
          end;
        1:
          begin
            Inc(TokenPtr); { '-' }
            aExpressionBuilder.SetOperator(opMinus);
          end;
        2:
          begin
            Inc(TokenPtr); { '||' }
            aExpressionBuilder.SetOperator(opConCat);
          end;
        end;
        compPROD_TermPoint(aExpressionBuilder);
      end;
    end;
    aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TwbScriptParser.compPROD_TermPoint(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    TermHandle := aExpressionBuilder.BeginTerm;
    compPROD_Factor(aExpressionBuilder);
    while GetCode <> 0 do begin
      begin
        case GetCode of
        0:
          begin
            Inc(TokenPtr); { '*' }
            aExpressionBuilder.SetOperator(opMul);
          end;
        1:
          begin
            Inc(TokenPtr); { '/' }
            aExpressionBuilder.SetOperator(opFloatDiv);
          end;
        2:
          begin
            Inc(TokenPtr); { 'div' }
            aExpressionBuilder.SetOperator(opDiv);
          end;
        3:
          begin
            Inc(TokenPtr); { 'mod' }
            aExpressionBuilder.SetOperator(opMod);
          end;
        end;
        compPROD_Factor(aExpressionBuilder);
      end;
    end;
    aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TwbScriptParser.compPROD_Factor(var aExpressionBuilder: IwbExpressionBuilder);
var IsMinus: Boolean; TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    IsMinus := False;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr); { '-' }
        IsMinus := True;
      end;
    if IsMinus then TermHandle := aExpressionBuilder.BeginUnaryTerm(uoMinus);
    compPROD_PositiveFactor(aExpressionBuilder);
    if IsMinus then aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TwbScriptParser.compPROD_PositiveFactor(var aExpressionBuilder: IwbExpressionBuilder);
begin
  case GetCode of
  0:
    begin
      if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
      compPROD_NestedFactor(aExpressionBuilder);
    end;
  1:
    compPROD_SimpleFactor(aExpressionBuilder);
  end;
end;

procedure TwbScriptParser.compPROD_NestedFactor(var aExpressionBuilder: IwbExpressionBuilder);
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    Inc(TokenPtr); { '(' }
    compPROD_Expression(aExpressionBuilder);
    Inc(TokenPtr); { ')' }
  end;
end;

procedure TwbScriptParser.compPROD_SimpleFactor(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    case GetCode of
    0:
      compPROD_Literal(aExpressionBuilder);
    1:
      compPROD_FieldRef(aExpressionBuilder);
    end;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr);  { "->" }
        TermHandle := aExpressionBuilder.BeginDeRefTerm;
        if GetCode <> 0 then
          case GetCode of
          0:
            compPROD_NestedFactor(aExpressionBuilder);
          1:
            compPROD_FieldRef(aExpressionBuilder);
          end;
        aExpressionBuilder.EndTerm(TermHandle);
      end;
  end;
end;

procedure TwbScriptParser.compPROD_Literal(var aExpressionBuilder: IwbExpressionBuilder);
begin
  case GetCode of
  0:
    begin
      if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
      Inc(TokenPtr); { stringQ }
      aExpressionBuilder.AddLiteral(ltString, CurTokenPtr);
    end;
  1:
    begin
      Inc(TokenPtr); { float }
      aExpressionBuilder.AddLiteral(ltFloat, CurTokenPtr);
    end;
  2:
    begin
      Inc(TokenPtr); { number }
      aExpressionBuilder.AddLiteral(ltInteger, CurTokenPtr);
    end;
  3:
    begin
      Inc(TokenPtr);  { "FORMID" }
      Inc(TokenPtr); { stringQ }
      aExpressionBuilder.AddLiteral(ltFormID, CurTokenPtr);
    end;
  end;
end;

procedure TwbScriptParser.compPROD_FieldRef(var aExpressionBuilder: IwbExpressionBuilder);
var FieldName: PTokenRecord; IsDeRef, IsScoped: Boolean; TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := ScriptBuilder.CreateExpressionBuilder;
    Inc(TokenPtr); { identifier }
    aExpressionBuilder.AddFieldRef(CurTokenPtr);
  end;
end;

constructor TwbScriptParser.Create(Tokens: TTokenList);
begin
  inherited Create;
  FTokens := Tokens;
end;

function TwbScriptParser.Parse: Boolean;
begin
  if FCodes <> nil then
    FCodes.Clear
  else
    FCodes := TList.Create;
  try
    TokenPtr := 0;
    STP := 0;
    CodePtr := 0;
    FFailedTokenIndex := -1;
    Result := isPROD_wbScript;
  except
    FCodes.Free;
    FCodes := nil;
    Result := False;
  end;
end;

procedure TwbScriptParser.Compile;
begin
  CodePtr := 0;
  TokenPtr := 0;
  compPROD_wbScript;
end;

end.
