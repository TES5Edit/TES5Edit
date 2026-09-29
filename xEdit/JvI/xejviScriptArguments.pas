{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptArguments;

{$I xeDefines.inc}

interface

function ObjectArgument(const aValue: Variant; aClass: TClass; aIndex: Integer; aRequired: Boolean = False; const aMessage: string = ''): TObject;

implementation

uses
  JvInterpreter;

function ObjectArgument(const aValue: Variant; aClass: TClass; aIndex: Integer; aRequired: Boolean = False; const aMessage: string = ''): TObject;

  procedure Refuse;
  begin
    if aMessage <> '' then
      JvInterpreterErrorN(ieDirectInvalidArgument, aIndex, aMessage)
    else
      JvInterpreterError(ieDirectInvalidArgument, aIndex);
  end;

begin
  Result := nil;
  if (TVarData(aValue).VType = varObject) or (TVarData(aValue).VType = varPointer) then
    Result := V2O(aValue)
  else if Assigned(V2O(aValue)) then
    Refuse;
  if Assigned(Result) and not (Result is aClass) then
    Refuse;
  if aRequired and not Assigned(Result) then
    Refuse;
end;

end.
