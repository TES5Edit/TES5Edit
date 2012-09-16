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

unit ScriptParse;
interface
uses
  Windows,
  Classes,
  SysUtils,
    CocoaBase,
  ScriptTok,
  wbScriptBuilder;

type
  TScriptParser = class(TBaseParser)
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
    procedure compPROD_Expression(var aExpressionBuilder: IwbExpressionBuilder);
    procedure compPROD_ModifyStatement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_SetStatement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_Statement(var aStatementBuilder: IwbStatementBuilder);
    procedure compPROD_Statements(const aRuleBuilder: IwbRuleBuilder);
    procedure compPROD_MatchRule(var aRule: IwbRuleBuilder);
    procedure compPROD_Rule(var aRule: IwbRuleBuilder);
    procedure compPROD_Rules(const aScriptBuilder: IwbScriptBuilder);
    procedure compPROD_Script;
    function isPROD_FieldRef: Boolean;
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
    function isPROD_Expression: Boolean;
    function IsProduction_ModifyStatement: Boolean;
    function IsParseTerm_ModifyStatement: Boolean;
    function isPROD_ModifyStatement: Boolean;
    function IsParseTerm_SetStatement: Boolean;
    function isPROD_SetStatement: Boolean;
    function IsProduction_Statement: Boolean;
    function isPROD_Statement: Boolean;
    function IsParseTerm_Statements: Boolean;
    function IsParseFactor_Statements: Boolean;
    function isPROD_Statements: Boolean;
    function IsParseFactor_MatchRule_2: Boolean;
    function IsParseTerm_MatchRule_2: Boolean;
    function IsParseFactor_MatchRule: Boolean;
    function IsParseTerm_MatchRule: Boolean;
    function isPROD_MatchRule: Boolean;
    function isPROD_Rule: Boolean;
    function IsParseTerm_Rules: Boolean;
    function IsParseFactor_Rules: Boolean;
    function isPROD_Rules: Boolean;
    function IsParseFactor_Script: Boolean;
    function IsParseTerm_Script: Boolean;
    function isPROD_Script: Boolean;
  public
    ScriptBuilder : IwbScriptBuilder;
  public
    constructor Create(Tokens: TTokenList);
    function Parse: Boolean; override;
    procedure Compile; override;
  end;

implementation

function TScriptParser.TokenStr(Token: Integer): string;
begin
  Result := TokStr[Token];
end;

function TScriptParser.MatchIdent: Boolean;
begin
  Result := 
    Match(TOK_identifier) or 
    MatchInterval(FirstDirective, LastDirective);
end;

function TScriptParser.IsParseFactor_Script: Boolean;
begin
  PushAddCode_1;
  if not isPROD_Rules then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseTerm_Script: Boolean;
begin
  Push;
  Result := IsParseFactor_Script and Match(TOK_eof);
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_Script: Boolean;
begin
  Result := IsParseTerm_Script;
end;

function TScriptParser.IsParseTerm_Rules: Boolean;
begin
  Push;
  Result := isPROD_Rule and Match(TOK_semicolon);
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_Rules: Boolean;
begin
  PushAddCode_1;
  if IsParseTerm_Rules then begin
    dec(STP); { Drop; }
    PushAddCode_1;
    while IsParseTerm_Rules do begin
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

function TScriptParser.isPROD_Rules: Boolean;
begin
  Result := IsParseFactor_Rules;
end;

function TScriptParser.isPROD_Rule: Boolean;
begin
  Result := isPROD_MatchRule;
end;

function TScriptParser.IsParseTerm_MatchRule_2: Boolean;
begin
  Push;
  Result := Match(TOK_WHERE) and isPROD_Expression;
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_MatchRule: Boolean;
begin
  PushAddCode_1;
  if not IsParseTerm_MatchRule_2 then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseFactor_MatchRule_2: Boolean;
begin
  PushAddCode_1;
  if not isPROD_Statements then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseTerm_MatchRule: Boolean;
begin
  Push;
  Result := Match(TOK_MATCH) and Match(TOK_signature) and IsParseFactor_MatchRule and Match(TOK_BEGIN) and IsParseFactor_MatchRule_2 and Match(TOK_END) and Match(TOK_MATCH);
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_MatchRule: Boolean;
begin
  Result := IsParseTerm_MatchRule;
end;

function TScriptParser.IsParseTerm_Statements: Boolean;
begin
  Push;
  Result := isPROD_Statement and Match(TOK_semicolon);
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_Statements: Boolean;
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

function TScriptParser.isPROD_Statements: Boolean;
begin
  Result := IsParseFactor_Statements;
end;

function TScriptParser.IsProduction_Statement: Boolean;
begin
  Result := False;
  PushAddCode_0;
  if isPROD_SetStatement then begin
    dec(STP); { Drop; }
    Result := True;
  end else begin
    PopPushAddCode(1);
    if isPROD_ModifyStatement then begin
      dec(STP); { Drop; }
      Result := True;
    end else begin
      Pop;
    end;
  end;
end;

function TScriptParser.isPROD_Statement: Boolean;
begin
  Result := IsProduction_Statement;
end;

function TScriptParser.IsParseTerm_SetStatement: Boolean;
begin
  Push;
  Result := Match(TOK_SET) and isPROD_FieldRef and Match(TOK_TO) and isPROD_Expression;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_SetStatement: Boolean;
begin
  Result := IsParseTerm_SetStatement;
end;

function TScriptParser.IsProduction_ModifyStatement: Boolean;
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

function TScriptParser.IsParseTerm_ModifyStatement: Boolean;
begin
  Push;
  Result := Match(TOK_MODIFY) and isPROD_FieldRef and IsProduction_ModifyStatement and isPROD_Expression;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_ModifyStatement: Boolean;
begin
  Result := IsParseTerm_ModifyStatement;
end;

function TScriptParser.isPROD_Expression: Boolean;
begin
  Result := isPROD_TermOr;
end;

function TScriptParser.IsParseTerm_TermOr_2: Boolean;
begin
  Push;
  Result := Match(TOK_OR) and isPROD_TermAnd;
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_TermOr: Boolean;
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

function TScriptParser.IsParseTerm_TermOr: Boolean;
begin
  Push;
  Result := isPROD_TermAnd and IsParseFactor_TermOr;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_TermOr: Boolean;
begin
  Result := IsParseTerm_TermOr;
end;

function TScriptParser.IsParseTerm_TermAnd_2: Boolean;
begin
  Push;
  Result := Match(TOK_AND) and isPROD_TermAnd;
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_TermAnd: Boolean;
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

function TScriptParser.IsParseTerm_TermAnd: Boolean;
begin
  Push;
  Result := isPROD_TermNot and IsParseFactor_TermAnd;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_TermAnd: Boolean;
begin
  Result := IsParseTerm_TermAnd;
end;

function TScriptParser.IsParseFactor_TermNot: Boolean;
begin
  PushAddCode_1;
  if not Match(TOK_NOT) then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseTerm_TermNot: Boolean;
begin
  Push;
  Result := IsParseFactor_TermNot and isPROD_TermDash;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_TermNot: Boolean;
begin
  Result := IsParseTerm_TermNot;
end;

function TScriptParser.IsProduction_TermDash: Boolean;
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

function TScriptParser.IsParseTerm_TermDash_2: Boolean;
begin
  Push;
  Result := IsProduction_TermDash and isPROD_TermPoint;
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_TermDash: Boolean;
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

function TScriptParser.IsParseTerm_TermDash: Boolean;
begin
  Push;
  Result := isPROD_TermPoint and IsParseFactor_TermDash;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_TermDash: Boolean;
begin
  Result := IsParseTerm_TermDash;
end;

function TScriptParser.IsProduction_TermPoint: Boolean;
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

function TScriptParser.IsParseTerm_TermPoint_2: Boolean;
begin
  Push;
  Result := IsProduction_TermPoint and isPROD_Factor;
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_TermPoint: Boolean;
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

function TScriptParser.IsParseTerm_TermPoint: Boolean;
begin
  Push;
  Result := isPROD_Factor and IsParseFactor_TermPoint;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_TermPoint: Boolean;
begin
  Result := IsParseTerm_TermPoint;
end;

function TScriptParser.IsParseFactor_Factor: Boolean;
begin
  PushAddCode_1;
  if not Match(TOK__45_) { '-' } then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseTerm_Factor: Boolean;
begin
  Push;
  Result := IsParseFactor_Factor and isPROD_PositiveFactor;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_Factor: Boolean;
begin
  Result := IsParseTerm_Factor;
end;

function TScriptParser.isPROD_PositiveFactor: Boolean;
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

function TScriptParser.IsParseTerm_NestedFactor: Boolean;
begin
  Push;
  Result := Match(TOK__40_) { '(' } and isPROD_Expression and Match(TOK__41_) { ')' };
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_NestedFactor: Boolean;
begin
  Result := IsParseTerm_NestedFactor;
end;

function TScriptParser.IsProduction_SimpleFactor: Boolean;
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

function TScriptParser.IsProduction_SimpleFactor_2: Boolean;
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

function TScriptParser.IsParseFactor_SimpleFactor_2: Boolean;
begin
  PushAddCode_1;
  if not IsProduction_SimpleFactor_2 then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseTerm_SimpleFactor_2: Boolean;
begin
  Push;
  Result := Match(TOK__45__62_) and IsParseFactor_SimpleFactor_2;
  IfDropElsePop(Result);
end;

function TScriptParser.IsParseFactor_SimpleFactor: Boolean;
begin
  PushAddCode_1;
  if not IsParseTerm_SimpleFactor_2 then begin
    PopAddCode_0;
  end else
    dec(STP); { Drop; }
  Result := true;
end;

function TScriptParser.IsParseTerm_SimpleFactor: Boolean;
begin
  Push;
  Result := IsProduction_SimpleFactor and IsParseFactor_SimpleFactor;
  IfDropElsePop(Result);
end;

function TScriptParser.isPROD_SimpleFactor: Boolean;
begin
  Result := IsParseTerm_SimpleFactor;
end;

function TScriptParser.isPROD_Literal: Boolean;
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
        Pop;
      end;
    end;
  end;
end;

function TScriptParser.isPROD_FieldRef: Boolean;
begin
  Result := MatchIdent;
end;

procedure TScriptParser.compPROD_Script;
begin
  begin
    if GetCode <> 0 then
      compPROD_Rules(ScriptBuilder);
    Inc(TokenPtr); { eof }
  end;
end;

procedure TScriptParser.compPROD_Rules(const aScriptBuilder: IwbScriptBuilder);
var RuleBuilder: IwbRuleBuilder;
begin
  while GetCode <> 0 do begin
    begin
      compPROD_Rule(RuleBuilder);
      aScriptBuilder.AddRule(RuleBuilder);
      RuleBuilder := nil;
      Inc(TokenPtr); { semicolon }
    end;
  end;
end;

procedure TScriptParser.compPROD_Rule(var aRule: IwbRuleBuilder);
begin
  compPROD_MatchRule(aRule);
end;

procedure TScriptParser.compPROD_MatchRule(var aRule: IwbRuleBuilder);
var Signature: PTokenRecord; Where: IwbExpressionBuilder;
begin
  begin
    Signature := nil;
    Where := nil;
    Inc(TokenPtr);  { "MATCH" }
    Inc(TokenPtr); { signature }
    Signature := CurTokenPtr;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr);  { "WHERE" }
        compPROD_Expression(Where);
      end;
    Inc(TokenPtr);  { "BEGIN" }
    Rule := wbCreateMatchRuleBuilder(Signature, Where);
    if GetCode <> 0 then
      compPROD_Statements(Rule);
    Inc(TokenPtr);  { "END" }
    Inc(TokenPtr);  { "MATCH" }
  end;
end;

procedure TScriptParser.compPROD_Statements(const aRuleBuilder: IwbRuleBuilder);
var StatementBuilder: IwbStatementBuilder;
begin
  while GetCode <> 0 do begin
    begin
      compPROD_Statement(StatementBuilder);
      aRuleBuilder.AddStatement(StatementBuilder);
      StatementBuilder := nil;
      Inc(TokenPtr); { semicolon }
    end;
  end;
end;

procedure TScriptParser.compPROD_Statement(var aStatementBuilder: IwbStatementBuilder);
begin
  case GetCode of
  0:
    compPROD_SetStatement(aStatementBuilder);
  1:
    compPROD_ModifyStatement(aStatementBuilder);
  end;
end;

procedure TScriptParser.compPROD_SetStatement(var aStatementBuilder: IwbStatementBuilder);
var Field, Expression: IwbExpressionBuilder;
begin
  begin
    Inc(TokenPtr);  { "SET" }
    compPROD_FieldRef(Field);
    Inc(TokenPtr);  { "TO" }
    compPROD_Expression(Expression);
    aStatementBuilder := wbCreateSetStatement(Field, Expression);
  end;
end;

procedure TScriptParser.compPROD_ModifyStatement(var aStatementBuilder: IwbStatementBuilder);
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
    aStatementBuilder := wbCreateModifyStatement(Field, ModifyType, Expression);
  end;
end;

procedure TScriptParser.compPROD_Expression(var aExpressionBuilder: IwbExpressionBuilder);
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
    compPROD_TermOr(aExpressionBuilder);
  end;
end;

procedure TScriptParser.compPROD_TermOr(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
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

procedure TScriptParser.compPROD_TermAnd(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
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

procedure TScriptParser.compPROD_TermNot(var aExpressionBuilder: IwbExpressionBuilder);
var IsNot: Boolean; TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
    IsNot := False;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr);  { "NOT" }
        IsNot := True;
      end;
    if IsNot then TermHandle := aExpressionBuilder.BeginUnaryTerm(utNot);
    compPROD_TermDash(aExpressionBuilder);
    if IsNot then aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TScriptParser.compPROD_TermDash(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
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

procedure TScriptParser.compPROD_TermPoint(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
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

procedure TScriptParser.compPROD_Factor(var aExpressionBuilder: IwbExpressionBuilder);
var IsMinus: Boolean; TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
    IsMinus := False;
    if GetCode <> 0 then
      begin
        Inc(TokenPtr); { '-' }
        IsMinus := True;
      end;
    if IsMinus then TermHandle := aExpressionBuilder.BeginUnaryTerm(utMinus);
    compPROD_PositiveFactor(aExpressionBuilder);
    if IsMinus then aExpressionBuilder.EndTerm(TermHandle);
  end;
end;

procedure TScriptParser.compPROD_PositiveFactor(var aExpressionBuilder: IwbExpressionBuilder);
begin
  case GetCode of
  0:
    begin
      if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
      compPROD_NestedFactor(aExpressionBuilder);
    end;
  1:
    compPROD_SimpleFactor(aExpressionBuilder);
  end;
end;

procedure TScriptParser.compPROD_NestedFactor(var aExpressionBuilder: IwbExpressionBuilder);
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
    Inc(TokenPtr); { '(' }
    compPROD_Expression(aExpressionBuilder);
    Inc(TokenPtr); { ')' }
  end;
end;

procedure TScriptParser.compPROD_SimpleFactor(var aExpressionBuilder: IwbExpressionBuilder);
var TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
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

procedure TScriptParser.compPROD_Literal(var aExpressionBuilder: IwbExpressionBuilder);
begin
  case GetCode of
  0:
    begin
      if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
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
  end;
end;

procedure TScriptParser.compPROD_FieldRef(var aExpressionBuilder: IwbExpressionBuilder);
var FieldName: PTokenRecord; IsDeRef, IsScoped: Boolean; TermHandle: TwbTermHandle;
begin
  begin
    if not Assigned(aExpressionBuilder) then aExpressionBuilder := wbCreateExpressionBuilder;
    Inc(TokenPtr); { identifier }
    aExpressionBuilder.FieldRef(CurTokenPtr);
  end;
end;

constructor TScriptParser.Create(Tokens: TTokenList);
begin
  inherited Create;
  FTokens := Tokens;
end;

function TScriptParser.Parse: Boolean;
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
    Result := isPROD_Script;
  except
    FCodes.Free;
    FCodes := nil;
    Result := False;
  end;
end;

procedure TScriptParser.Compile;
begin
  CodePtr := 0;
  TokenPtr := 0;
  compPROD_Script;
end;

end.
