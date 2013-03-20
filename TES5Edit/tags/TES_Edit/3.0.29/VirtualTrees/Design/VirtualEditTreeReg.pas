unit VirtualEditTreeReg;

interface

{$I COMPILERS.INC}

{$IFDEF DELPHI_6_UP}
uses SysUtils, Classes, Windows, Messages, Controls, VirtualEditTree,
  TypInfo, DesignIntf, DesignEditors, VTEditors;
{$ELSE}
uses SysUtils, Classes, Windows, Messages, Controls, VirtualEditTree,
  TypInfo, DsgnIntf, VTEditors;
{$ENDIF}

type

  TEditLinkProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Virtual Controls', [TVirtualEditTree]);
  RegisterPropertyEditor(TypeInfo(TEditLinkName), nil, 'EditLinkName', nil);
  RegisterPropertyEditor(TypeInfo(TCustomEditLink), nil, '', TEditLinkProperty);
end;

{ TEditLinkProperty }

function TEditLinkProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList, paSortList] - [paReadOnly, paSubProperties];
  if GetOrdValue <> 0 then Result := Result + [paValueList, paSortList, paSubProperties];
end;

function TEditLinkProperty.GetEditLimit: Integer;
begin
  Result := MaxIdentLength;
end;

function TEditLinkProperty.GetValue: string;
var
  C: TPersistent;
  P: PPropInfo;
begin
  C := GetComponent(0);
  P := TypInfo.GetPropInfo(C, 'EditLinkName', [tkLString, tkString, tkWString]);
  if Assigned(P) then
    Result := TypInfo.GetStrProp(C, P)
  else
    Result := '<not available>';
end;

procedure TEditLinkProperty.GetValues(Proc: TGetStrProc);
var
  L: TStringList;
  I: Integer;
begin
  L := TStringList.Create;
  try
    GetEditLinkClasses(L);
    for I := 0 to L.Count - 1 do
      Proc(L[I]);
  finally
    L.Free;
  end;
end;

procedure TEditLinkProperty.SetValue(const Value: string);
var
  C: TPersistent;
  P: PPropInfo;
  List: IDesignerSelections;
{$IFDEF DELPHI_6_UP}
  Dsgnr: IDesigner;
{$ELSE}
  Dsgnr: IFormDesigner;
{$ENDIF}
  OldValue: string;
  Refresh: Boolean;
begin
  Dsgnr := Self.Designer;
  C := GetComponent(0);
  P := TypInfo.GetPropInfo(C, 'EditLinkName', [tkLString, tkString, tkWString]);
  if not Assigned(P) then Exit;
  OldValue := GetValue;

  Refresh := not SameText(OldValue, Value) and (OldValue <> '');
  TypInfo.SetStrProp(C, P, Value);

  if Refresh then
  begin
    // Force the object inspector to discard its property editors.
    List := CreateSelectionList;
    Dsgnr.GetSelections(List);
    Dsgnr.NoSelection; // Self will be gone here
    Dsgnr.SetSelections(List);
    Dsgnr.Modified;
  end;
end;

end.
