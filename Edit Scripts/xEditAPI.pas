{
  xEdit API declarations to be used for editing scripts using Delphi
  
  1. Download free Delphi Starter edition
  2. Create new console application project
  3. Add this file xEditAPI.pas and your script file to project (menu Project -> Add to project)
  4. Unit name must match the script's file name
  5. At the top of the script, right after the 'unit <name>;' add these lines
  
    interface
    implementation
    uses xEditAPI, Classes, SysUtils, StrUtils, Windows;
  
  6. Add additional Delphi units to the 'uses' line if needed, for example IniFiles if script works with them
  7. Check that project can be compiled Ctrl+F9 and the same script can be applied in xEdit
     without errors.
     
  Now when editing a script in Delphi it has the full Intellisense support and Code insights.
  Press Ctrl+F9 in Delphi to compile and ensure that the code is valid before applying script in xEdit.
  Remove added lines when the script is ready to be shared with others.
}
unit xEditAPI;

interface

const
  LowInteger = Low(Integer);
  HighInteger = High(Integer);

type
  IwbElement = IInterface;
  IwbFile = IInterface;
  IwbContainer = IInterface;

function Add(aeContainer: IInterface; asNameOrSignature: string; abSilent: boolean): IInterface;
procedure AddMasterIfMissing(aElement: IInterface; aMaster: string);
procedure AddMessage(aMessage: string);
function AddNewFileName(aFileName: string): IInterface;
function Assigned(aElement: IInterface): Boolean; overload;
function Assigned(aObject: TObject): Boolean; overload;
procedure CleanMasters(aeFile: IInterface);
procedure SortMasters(aeFile: IInterface);
function EditorID(aElement: IInterface): string;
function ElementAssign(aeContainer: IInterface; aiIndex: integer; aeSource: IInterface; abOnlySK: boolean): IInterface;
function ElementByIndex(aElement: IInterface; aIndex: integer): IInterface;
function ElementBySignature(aElement: IInterface; aSignature: string): IInterface;
function ElementCount(aElement: IInterface): integer;
function FileByIndex(aIndex: integer): IInterface;
function FileCount(): integer;
function GetEditValue(aElement: IInterface): string;
function GetElementEditValues(aElement: IInterface; aPath: string): string;
function GetElementNativeValues(aElement: IInterface; aPath: string): Variant;
function GetFile(aElement: IInterface): IInterface;
function GetFileName(aElement: IInterface): string;
function GetLoadOrderFormID(aElement: IInterface): integer;
function GroupBySignature(aElement: IInterface; aSignature: string): IInterface;
function HasGroup(aElement: IInterface; aSignature: string): boolean;
function IsMaster(aElement: IInterface): boolean;
function LinksTo(aElement: IInterface): IInterface;
function MasterOrSelf(aElement: IInterface): IInterface;
function Name(aElement: IInterface): string;
function ObjectToElement(aObject: TObject): IInterface;
function RecordByFormID(aeFile: IInterface; aiFormID: integer; abAllowInjected: boolean): IInterface;
procedure Remove(aElement: IInterface);
function ScriptsPath(): string;

/// <summary>Set element's value using a text representation</summary>
/// <param name="aElement">Container of elements</param>
/// <param name="aPath">Path to element to change</param>
/// <param name="aValue">Text value to set</param>
procedure SetElementEditValues(aElement: IInterface; aPath, aValue: string);

/// <summary>Set element's value using native variant value</summary>
/// <param name="aElement">Container of elements</param>
/// <param name="aPath">Path to element to change</param>
/// <param name="aValue">Variant value to set</param>
procedure SetElementNativeValues(aElement: IInterface; aPath: string; aValue: Variant);

/// <summary>Get signature of element</summary>
/// <param name="aElement">Element to get a signature from</param>
/// <returns>Signature of element</returns>
/// <remarks>If element doesn't have a signature, an empty string is returned</remarks>
function Signature(aElement: IInterface): string;

/// <summary>Get the current winning override of a record</summary>
/// <param name="aElement">A record</param>
/// <returns>Winning override record</returns>
function WinningOverride(aElement: IInterface): IInterface;
function wbAppName(): string;
function wbVersionNumber(): integer;


implementation

function Add(aeContainer: IInterface; asNameOrSignature: string; abSilent: boolean): IInterface;
begin
  Result := Nil;
end;

procedure AddMasterIfMissing(aElement: IInterface; aMaster: string);
begin
end;

procedure AddMessage(aMessage: string);
begin
end;

function AddNewFileName(aFileName: string): IInterface;
begin
end;

function Assigned(aElement: IInterface): boolean; Overload;
begin
  Result := False;
end;

function Assigned(aObject: TObject): boolean; Overload;
begin
  Result := False;
end;

procedure CleanMasters(aeFile: IInterface);
begin
end;

procedure SortMasters(aeFile: IInterface);
begin
end;

function EditorID(aElement: IInterface): string;
begin
  Result := '';
end;

function ElementAssign(aeContainer: IInterface; aiIndex: integer; aeSource: IInterface; abOnlySK: boolean): IInterface;
begin
  Result := Nil;
end;

function ElementByIndex(aElement: IInterface; aIndex: integer): IInterface;
begin
end;

function ElementBySignature(aElement: IInterface; aSignature: string): IInterface;
begin
  Result := Nil;
end;

function ElementCount(aElement: IInterface): integer;
begin
  Result := 0;
end;

function FileByIndex(aIndex: integer): IInterface;
begin
  Result := Nil;
end;

function FileCount(): integer;
begin
  Result := 0;
end;

function GetEditValue(aElement: IInterface): string;
begin
  Result := '';
end;

function GetElementEditValues(aElement: IInterface; aPath: string): string;
begin
  Result := '';
end;

function GetElementNativeValues(aElement: IInterface; aPath: string): Variant;
begin
end;

function GetFile(aElement: IInterface): IInterface;
begin
  Result := Nil;
end;

function GetFileName(aElement: IInterface): string;
begin
  Result := '';
end;

function GetLoadOrderFormID(aElement: IInterface): integer;
begin
  Result := 0;
end;

function GroupBySignature(aElement: IInterface; aSignature: string): IInterface;
begin
  Result := Nil;
end;

function HasGroup(aElement: IInterface; aSignature: string): boolean;
begin
  Result := false;
end;

function IsMaster(aElement: IInterface): boolean;
begin
  Result := true;
end;

function LinksTo(aElement: IInterface): IInterface;
begin
  Result := Nil;
end;

function MasterOrSelf(aElement: IInterface): IInterface;
begin
  Result := Nil;
end;

function Name(aElement: IInterface): string;
begin
  Result := '';
end;

function ObjectToElement(aObject: TObject): IInterface;
begin
  Result := Nil;
end;

function RecordByFormID(aeFile: IInterface; aiFormID: integer; abAllowInjected: boolean): IInterface;
begin
  Result := Nil;
end;

procedure Remove(aElement: IInterface);
begin
end;

function ScriptsPath(): string;
begin
  Result := '';
end;

procedure SetElementEditValues(aElement: IInterface; aPath, aValue: string);
begin
end;

procedure SetElementNativeValues(aElement: IInterface; aPath: string; aValue: Variant);
begin
end;

function Signature(aElement: IInterface): string;
begin
  Result := '';
end;

function WinningOverride(aElement: IInterface): IInterface;
begin
  Result := Nil;
end;

function wbAppName(): string;
begin
  Result := '';
end;

function wbVersionNumber(): integer;
begin
  Result := 0;
end;

end.
