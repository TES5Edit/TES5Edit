unit wbGameDefGlobals;

interface

uses
  wbInterface;

function wbHEDRVersion: Double; inline;

implementation

function wbHEDRVersion: Double;
begin
  Result := _CurrentGameDef.HEDRVersion;
end;

end.
