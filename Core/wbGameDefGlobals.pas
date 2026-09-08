unit wbGameDefGlobals;

interface

uses
  wbInterface;

function wbHEDRVersion: Double; inline;
function wbHEDRNextObjectID: Integer; inline;
function wbHeaderSignature: TwbSignature; inline;
function wbNexusModsUrl: string; inline;

implementation

function wbHEDRVersion: Double;
begin
  Result := _CurrentGameDef.HEDRVersion;
end;

function wbHEDRNextObjectID: Integer;
begin
  Result := _CurrentGameDef.HEDRNextObjectID;
end;

function wbHeaderSignature: TwbSignature;
begin
  Result := _CurrentGameDef.HeaderSignature;
end;

function wbNexusModsUrl: string;
begin
  Result := _CurrentGameDef.NexusModsUrl;
end;

end.
