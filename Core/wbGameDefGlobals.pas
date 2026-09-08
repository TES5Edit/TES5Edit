unit wbGameDefGlobals;

interface

uses
  System.Classes,
  wbInterface;

function wbHEDRVersion: Double; inline;
function wbHEDRNextObjectID: Integer; inline;
function wbHeaderSignature: TwbSignature; inline;
function wbNexusModsUrl: string; inline;
function wbIgnoreRecords: TStringList; inline;
function wbGroupOrder: TStringList; inline;
function wbFileMagic: TwbFileMagic; inline;
function wbFilePlugins: string; inline;
function wbActorValueEnum: IwbEnumDef; inline;

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

function wbIgnoreRecords: TStringList;
begin
  Result := _CurrentGameDef.IgnoreRecords;
end;

function wbGroupOrder: TStringList;
begin
  Result := _CurrentGameDef.GroupOrder;
end;

function wbFileMagic: TwbFileMagic;
begin
  Result := _CurrentGameDef.FileMagic;
end;

function wbFilePlugins: string;
begin
  Result := _CurrentGameDef.FilePlugins;
end;

function wbActorValueEnum: IwbEnumDef;
begin
  Result := _CurrentGameDef.ActorValueEnum;
end;

end.
