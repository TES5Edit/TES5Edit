{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvInterpreter_SysUtils.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Andrei Prygounkov <a dott prygounkov att gmx dott de>
Copyright (c) 1999, 2002 Andrei Prygounkov
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Description : adapter unit - converts JvInterpreter calls to delphi calls

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

unit JvInterpreter_SysUtils;

{$I jvcl.inc}
{$I crossplatform.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF RTL250_UP}
  AnsiStrings, // must be included before SysUtils
  {$ENDIF RTL250_UP}
  SysUtils,
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

function SearchRec2Var(const SearchRec: TSearchRec): Variant;
function Var2SearchRec(const SearchRec: Variant): TSearchRec;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL$';
    Revision: '$Revision$';
    Date: '$Date$';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Variants,
  {$IFDEF SUPPORTS_INLINE}
  Windows,
  {$ENDIF SUPPORTS_INLINE}
  JvJCLUtils;

{ TSearchRec }

function SearchRec2Var(const SearchRec: TSearchRec): Variant;
var
  Rec: ^TSearchRec;
begin
  New(Rec);
  Rec^ := SearchRec;
  Result := R2V('TSearchRec', Rec);
end;

function Var2SearchRec(const SearchRec: Variant): TSearchRec;
begin
  Result := TSearchRec(V2R(SearchRec)^);
end;

{ Exception }

{ constructor Create(Msg: string) }

procedure Exception_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(Exception.Create(Args.Values[0]));
end;

{ constructor CreateFmt(Msg: string; Args: array) }

procedure Exception_CreateFmt(var Value: Variant; Args: TJvInterpreterArgs);
begin
//  Value := O2V(Exception.CreateFmt(Args.Values[0], Args.Values[1]));
  NotImplemented('Exception.CreateFmt');
end;

{ constructor CreateRes(Ident: Integer) }

procedure Exception_CreateRes(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(Exception.CreateRes(Args.Values[0]));
end;

{ constructor CreateResFmt(Ident: Integer; Args: array) }

procedure Exception_CreateResFmt(var Value: Variant; Args: TJvInterpreterArgs);
begin
//  Value := O2V(Exception.CreateResFmt(Args.Values[0], Args.Values[1]));
  NotImplemented('Exception.CreateResFmt');
end;

{ constructor CreateHelp(Msg: string; AHelpContext: Integer) }

procedure Exception_CreateHelp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(Exception.CreateHelp(Args.Values[0], Args.Values[1]));
end;

{ constructor CreateFmtHelp(Msg: string; Args: array; AHelpContext: Integer) }

procedure Exception_CreateFmtHelp(var Value: Variant; Args: TJvInterpreterArgs);
begin
//  Value := O2V(Exception.CreateFmtHelp(Args.Values[0], Args.Values[1], Args.Values[2]));
  NotImplemented('Exception.CreateFmtHelp');
end;

{ constructor CreateResHelp(Ident: Integer; AHelpContext: Integer) }

procedure Exception_CreateResHelp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(Exception.CreateResHelp(Args.Values[0], Args.Values[1]));
end;

{ constructor CreateResFmtHelp(Ident: Integer; Args: array; AHelpContext: Integer) }

procedure Exception_CreateResFmtHelp(var Value: Variant; Args: TJvInterpreterArgs);
begin
//  Value := O2V(Exception.CreateResFmtHelp(Args.Values[0], Args.Values[1], Args.Values[2]));
  NotImplemented('Exception.CreateResFmtHelp');
end;

{ property Read HelpContext: Integer }

procedure Exception_Read_HelpContext(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Exception(Args.Obj).HelpContext;
end;

{ property Write HelpContext(Value: Integer) }

procedure Exception_Write_HelpContext(const Value: Variant; Args: TJvInterpreterArgs);
begin
  Exception(Args.Obj).HelpContext := Value;
end;

{ property Read Message: string }

procedure Exception_Read_Message(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Exception(Args.Obj).Message;
end;

{ property Write Message(Value: string) }

procedure Exception_Write_Message(const Value: Variant; Args: TJvInterpreterArgs);
begin
  Exception(Args.Obj).Message := Value;
end;

{ EAbort }

{ EOutOfMemory }

{ EInOutError }

{ EIntError }

{ EDivByZero }

{ ERangeError }

{ EIntOverflow }

{ EMathError }

{ EInvalidOp }

{ EZeroDivide }

{ EOverflow }

{ EUnderflow }

{ EInvalidPointer }

{ EInvalidCast }

{ EConvertError }

{ EAccessViolation }

{ EPrivilege }

{ EStackOverflow }

{ EControlC }

{ EVariantError }

{ EPropReadOnly }

{ EPropWriteOnly }

{ EExternalException }

{ EAssertionFailed }

{ EAbstractError }

{ EIntfCastError }

{ EInvalidContainer }

{ EInvalidInsert }

{ EPackageError }

{ EWin32Error }

{ function AllocMem(Size: Cardinal): Pointer; }

procedure JvInterpreter_AllocMem(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := P2V(AllocMem(Args.Values[0]));
end;

{ function UpperCase(const S: string): string; }

procedure JvInterpreter_UpperCase(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := UpperCase(Args.Values[0]);
end;

{ function LowerCase(const S: string): string; }

procedure JvInterpreter_LowerCase(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LowerCase(Args.Values[0]);
end;

{ function CompareStr(const S1, S2: string): Integer; }

procedure JvInterpreter_CompareStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CompareStr(Args.Values[0], Args.Values[1]);
end;

{ function CompareMem(P1, P2: Pointer; Length: Integer): Boolean; }

procedure JvInterpreter_CompareMem(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CompareMem(V2P(Args.Values[0]), V2P(Args.Values[1]), Args.Values[2]);
end;

{ function CompareText(const S1, S2: string): Integer; }

procedure JvInterpreter_CompareText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CompareText(Args.Values[0], Args.Values[1]);
end;
{ function ExtractQuotedString(s: string; Quote: Char): string; }
procedure JvInterpreter_ExtractQuotedString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractQuotedString(Args.Values[0], string(Args.Values[1])[1]);
end;

{ function AnsiUpperCase(const S: string): string; }

procedure JvInterpreter_AnsiUpperCase(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiUpperCase(Args.Values[0]);
end;

{ function AnsiLowerCase(const S: string): string; }

procedure JvInterpreter_AnsiLowerCase(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiLowerCase(Args.Values[0]);
end;

{ function AnsiCompareStr(const S1, S2: string): Integer; }

procedure JvInterpreter_AnsiCompareStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiCompareStr(Args.Values[0], Args.Values[1]);
end;

{ function AnsiCompareText(const S1, S2: string): Integer; }

procedure JvInterpreter_AnsiCompareText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiCompareText(Args.Values[0], Args.Values[1]);
end;

{ function AnsiStrComp(S1, S2: PChar): Integer; }

procedure JvInterpreter_AnsiStrComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiStrComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])));
end;

{ function AnsiStrIComp(S1, S2: PChar): Integer; }

procedure JvInterpreter_AnsiStrIComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiStrIComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])));
end;

{ function AnsiStrLComp(S1, S2: PChar; MaxLen: Cardinal): Integer; }

procedure JvInterpreter_AnsiStrLComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiStrLComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]);
end;

{ function AnsiStrLIComp(S1, S2: PChar; MaxLen: Cardinal): Integer; }

procedure JvInterpreter_AnsiStrLIComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiStrLIComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]);
end;

{ function AnsiStrLower(Str: PChar): PChar; }

procedure JvInterpreter_AnsiStrLower(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiStrLower(PChar(string(Args.Values[0]))));
end;

{ function AnsiStrUpper(Str: PChar): PChar; }

procedure JvInterpreter_AnsiStrUpper(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiStrUpper(PChar(string(Args.Values[0]))));
end;

{ function AnsiLastChar(const S: string): PChar; }

procedure JvInterpreter_AnsiLastChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiLastChar(Args.Values[0]));
end;

{ function AnsiStrLastChar(P: PChar): PChar; }

procedure JvInterpreter_AnsiStrLastChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiStrLastChar(PChar(string(Args.Values[0]))));
end;

{ function Trim(const S: string): string; }

procedure JvInterpreter_Trim(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Trim(Args.Values[0]);
end;

{ function TrimLeft(const S: string): string; }

procedure JvInterpreter_TrimLeft(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TrimLeft(Args.Values[0]);
end;

{ function TrimRight(const S: string): string; }

procedure JvInterpreter_TrimRight(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TrimRight(Args.Values[0]);
end;

{ function QuotedStr(const S: string): string; }

procedure JvInterpreter_QuotedStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := QuotedStr(Args.Values[0]);
end;

{ function AnsiQuotedStr(const S: string; Quote: Char): string; }

procedure JvInterpreter_AnsiQuotedStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiQuotedStr(Args.Values[0], string(Args.Values[1])[1]);
end;

{ function AnsiExtractQuotedStr(var Src: PChar; Quote: Char): string; }

procedure JvInterpreter_AnsiExtractQuotedStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiExtractQuotedStr(PChar(TVarData(Args.Values[0]).vPointer), string(Args.Values[1])[1]);
end;

{ function AdjustLineBreaks(const S: string): string; }

procedure JvInterpreter_AdjustLineBreaks(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AdjustLineBreaks(Args.Values[0]);
end;

{ function IsValidIdent(const Ident: string): Boolean; }

procedure JvInterpreter_IsValidIdent(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IsValidIdent(Args.Values[0]);
end;

{ function IntToStr(Value: Integer): string; }

procedure JvInterpreter_IntToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IntToStr(Args.Values[0]);
end;

{ function IntToHex(Value: Integer; Digits: Integer): string; }

procedure JvInterpreter_IntToHex(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IntToHex(Args.Values[0], Args.Values[1]);
end;

{ function StrToInt(const S: string): Integer; }

procedure JvInterpreter_StrToInt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToInt(Args.Values[0]);
end;

{ function StrToIntDef(const S: string; Default: Integer): Integer; }

procedure JvInterpreter_StrToIntDef(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToIntDef(Args.Values[0], Args.Values[1]);
end;

{ function LoadStr(Ident: Integer): string; }

procedure JvInterpreter_LoadStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LoadStr(Args.Values[0]);
end;

(*
{ function FmtLoadStr(Ident: Integer; const Args: array of const): string; }
procedure JvInterpreter_FmtLoadStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FmtLoadStr(Args.Values[0], Args.Values[1]);
end;
*)

{ function FileOpen(const FileName: string; Mode: Integer): Integer; }

procedure JvInterpreter_FileOpen(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileOpen(Args.Values[0], Args.Values[1]);
end;

{ function FileCreate(const FileName: string): Integer; }

procedure JvInterpreter_FileCreate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  {$IFDEF MSWINDOWS}
  Value := FileCreate(Args.Values[0]);
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  Value := FileCreate(VarToStr(Args.Values[0]));
  {$ENDIF UNIX}
end;

{ function FileRead(Handle: Integer; var Buffer; Count: Integer): Integer; }

procedure JvInterpreter_FileRead(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileRead(Args.Values[0], TVarData(Args.Values[1]).vInteger, Args.Values[2]);
end;

{ function FileWrite(Handle: Integer; const Buffer; Count: Integer): Integer; }

procedure JvInterpreter_FileWrite(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileWrite(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{ function FileSeek(Handle, Offset, Origin: Integer): Integer; }

procedure JvInterpreter_FileSeek(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileSeek(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{ procedure FileClose(Handle: Integer); }

procedure JvInterpreter_FileClose(var Value: Variant; Args: TJvInterpreterArgs);
begin
  FileClose(Args.Values[0]);
end;

{ function FileAge(const FileName: string): Integer; }

procedure JvInterpreter_FileAge(var Value: Variant; Args: TJvInterpreterArgs);
begin
  {$IFDEF COMPILER10_UP}
  {$WARN SYMBOL_DEPRECATED OFF}
  Value := FileAge(Args.Values[0]);
  {$WARN SYMBOL_DEPRECATED ON}
  {$ELSE}
  Value := FileAge(Args.Values[0]);
  {$ENDIF COMPILER10_UP}
end;

{ function FileExists(const FileName: string): Boolean; }

procedure JvInterpreter_FileExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileExists(Args.Values[0]);
end;

{ function FindFirst(const Path: string; Attr: Integer; var F: TSearchRec): Integer; }

procedure JvInterpreter_FindFirst(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FindFirst(Args.Values[0], Args.Values[1], TSearchRec(V2R(Args.Values[2])^));
end;

{ function FindNext(var F: TSearchRec): Integer; }

procedure JvInterpreter_FindNext(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FindNext(TSearchRec(V2R(Args.Values[0])^));
end;

{ procedure FindClose(var F: TSearchRec); }

procedure JvInterpreter_FindClose(var Value: Variant; Args: TJvInterpreterArgs);
begin
  SysUtils.FindClose(SysUtils.TSearchRec(V2R(Args.Values[0])^));
end;

{ function FileGetDate(Handle: Integer): Integer; }

procedure JvInterpreter_FileGetDate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileGetDate(Args.Values[0]);
end;

{ function FileSetDate(Handle: Integer; Age: Integer): Integer; }

procedure JvInterpreter_FileSetDate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileSetDate({$IFDEF RTL200_UP}VarToStr{$ENDIF RTL200_UP}(Args.Values[0]), Args.Values[1]);
end;

{$IFDEF MSWINDOWS}

{ function FileGetAttr(const FileName: string): Integer; }

procedure JvInterpreter_FileGetAttr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileGetAttr(Args.Values[0]);
end;

{ function FileSetAttr(const FileName: string; Attr: Integer): Integer; }

procedure JvInterpreter_FileSetAttr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileSetAttr(Args.Values[0], Args.Values[1]);
end;

{$ENDIF MSWINDOWS}

{ function DeleteFile(const FileName: string): Boolean; }

procedure JvInterpreter_DeleteFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SysUtils.DeleteFile(Args.Values[0]);
end;

{ function RenameFile(const OldName, NewName: string): Boolean; }

procedure JvInterpreter_RenameFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := RenameFile(Args.Values[0], Args.Values[1]);
end;

{ function ChangeFileExt(const FileName, Extension: string): string; }

procedure JvInterpreter_ChangeFileExt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ChangeFileExt(Args.Values[0], Args.Values[1]);
end;

{ function ExtractFilePath(const FileName: string): string; }

procedure JvInterpreter_ExtractFilePath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractFilePath(Args.Values[0]);
end;

{ function ExtractFileDir(const FileName: string): string; }

procedure JvInterpreter_ExtractFileDir(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractFileDir(Args.Values[0]);
end;

{ function ExtractFileDrive(const FileName: string): string; }

procedure JvInterpreter_ExtractFileDrive(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractFileDrive(Args.Values[0]);
end;

{ function ExtractFileName(const FileName: string): string; }

procedure JvInterpreter_ExtractFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractFileName(Args.Values[0]);
end;

{ function ExtractFileExt(const FileName: string): string; }

procedure JvInterpreter_ExtractFileExt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractFileExt(Args.Values[0]);
end;

{ function ExpandFileName(const FileName: string): string; }

procedure JvInterpreter_ExpandFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExpandFileName(Args.Values[0]);
end;

{ function ExpandUNCFileName(const FileName: string): string; }

procedure JvInterpreter_ExpandUNCFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExpandUNCFileName(Args.Values[0]);
end;

{ function ExtractRelativePath(const BaseName, DestName: string): string; }


procedure JvInterpreter_ExtractRelativePath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExtractRelativePath(Args.Values[0], Args.Values[1]);
end;

{ function FileSearch(const Name, DirList: string): string; }

procedure JvInterpreter_FileSearch(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileSearch(Args.Values[0], Args.Values[1]);
end;

{$IFDEF MSWINDOWS}

{ function DiskFree(Drive: Byte): Integer; }

procedure JvInterpreter_DiskFree(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Integer(DiskFree(Args.Values[0]));
end;

{ function DiskSize(Drive: Byte): Integer; }

procedure JvInterpreter_DiskSize(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Integer(DiskSize(Args.Values[0]));
end;

{$ENDIF MSWINDOWS}

{ function FileDateToDateTime(FileDate: Integer): TDateTime; }

procedure JvInterpreter_FileDateToDateTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileDateToDateTime(Args.Values[0]);
end;

{ function DateTimeToFileDate(DateTime: TDateTime): Integer; }

procedure JvInterpreter_DateTimeToFileDate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DateTimeToFileDate(Args.Values[0]);
end;

{ function GetCurrentDir: string; }

procedure JvInterpreter_GetCurrentDir(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := GetCurrentDir;
end;

{ function SetCurrentDir(const Dir: string): Boolean; }

procedure JvInterpreter_SetCurrentDir(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SetCurrentDir(Args.Values[0]);
end;

{ function CreateDir(const Dir: string): Boolean; }

procedure JvInterpreter_CreateDir(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CreateDir(Args.Values[0]);
end;

{ function RemoveDir(const Dir: string): Boolean; }

procedure JvInterpreter_RemoveDir(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := RemoveDir(Args.Values[0]);
end;

{ function StrLen(Str: PChar): Cardinal; }

procedure JvInterpreter_StrLen(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Integer(StrLen(PChar(string(Args.Values[0]))));
end;

{ function StrEnd(Str: PChar): PChar; }

procedure JvInterpreter_StrEnd(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrEnd(PChar(string(Args.Values[0]))));
end;

{ function StrMove(Dest, Source: PChar; Count: Cardinal): PChar; }

procedure JvInterpreter_StrMove(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrMove(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]));
end;

{ function StrCopy(Dest, Source: PChar): PChar; }

procedure JvInterpreter_StrCopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrCopy(PChar(string(Args.Values[0])), PChar(string(Args.Values[1]))));
end;

{ function StrECopy(Dest, Source: PChar): PChar; }

procedure JvInterpreter_StrECopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrECopy(PChar(string(Args.Values[0])), PChar(string(Args.Values[1]))));
end;

{ function StrLCopy(Dest, Source: PChar; MaxLen: Cardinal): PChar; }

procedure JvInterpreter_StrLCopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrLCopy(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]));
end;

{ function StrPCopy(Dest: PChar; const Source: string): PChar; }

procedure JvInterpreter_StrPCopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrPCopy(PChar(string(Args.Values[0])), Args.Values[1]));
end;

{ function StrPLCopy(Dest: PChar; const Source: string; MaxLen: Cardinal): PChar; }

procedure JvInterpreter_StrPLCopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrPLCopy(PChar(string(Args.Values[0])), Args.Values[1], Args.Values[2]));
end;

{ function StrCat(Dest, Source: PChar): PChar; }

procedure JvInterpreter_StrCat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrCat(PChar(string(Args.Values[0])), PChar(string(Args.Values[1]))));
end;

{ function StrLCat(Dest, Source: PChar; MaxLen: Cardinal): PChar; }

procedure JvInterpreter_StrLCat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrLCat(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]));
end;

{ function StrComp(Str1, Str2: PChar): Integer; }

procedure JvInterpreter_StrComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])));
end;

{ function StrIComp(Str1, Str2: PChar): Integer; }

procedure JvInterpreter_StrIComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrIComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])));
end;

{ function StrLComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer; }

procedure JvInterpreter_StrLComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrLComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]);
end;

{ function StrLIComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer; }

procedure JvInterpreter_StrLIComp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrLIComp(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]);
end;

{ function StrScan(Str: PChar; Chr: Char): PChar; }

procedure JvInterpreter_StrScan(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrScan(PChar(string(Args.Values[0])), string(Args.Values[1])[1]));
end;

{ function StrRScan(Str: PChar; Chr: Char): PChar; }

procedure JvInterpreter_StrRScan(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrRScan(PChar(string(Args.Values[0])), string(Args.Values[1])[1]));
end;

{ function StrPos(Str1, Str2: PChar): PChar; }

procedure JvInterpreter_StrPos(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrPos(PChar(string(Args.Values[0])), PChar(string(Args.Values[1]))));
end;

{ function StrUpper(Str: PChar): PChar; }

procedure JvInterpreter_StrUpper(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrUpper(PChar(string(Args.Values[0]))));
end;

{ function StrLower(Str: PChar): PChar; }

procedure JvInterpreter_StrLower(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrLower(PChar(string(Args.Values[0]))));
end;

{ function StrPas(Str: PChar): string; }

procedure JvInterpreter_StrPas(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrPas(PChar(string(Args.Values[0])));
end;

{ function StrAlloc(Size: Cardinal): PChar; }

procedure JvInterpreter_StrAlloc(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrAlloc(Args.Values[0]));
end;

{ function StrBufSize(Str: PChar): Cardinal; }

procedure JvInterpreter_StrBufSize(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Integer(StrBufSize(PChar(string(Args.Values[0]))));
end;

{ function StrNew(Str: PChar): PChar; }

procedure JvInterpreter_StrNew(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(StrNew(PChar(string(Args.Values[0]))));
end;

{ procedure StrDispose(Str: PChar); }

procedure JvInterpreter_StrDispose(var Value: Variant; Args: TJvInterpreterArgs);
begin
  StrDispose(PChar(string(Args.Values[0])));
end;

{ function Format(const Format: string; const Args: array of const): string; }

procedure JvInterpreter_Format(var Value: Variant; Args: TJvInterpreterArgs);

  function FormatWorkaround(const MyFormat: string; const Args: array of const): string;
  begin
    Result := Format(MyFormat, Args);
  end;

begin
  Args.OpenArray(1);
  Value := FormatWorkaround(Args.Values[0], Slice(Args.OA^, Args.OAS));
end;

{ procedure FmtStr(var Result: string; const Format: string; const Args: array of const); }

procedure JvInterpreter_FmtStr(var Value: Variant; Args: TJvInterpreterArgs);

  procedure FmtStrWorkaround(var Result: string; const Format: string; const Args: array of const);
  begin
    FmtStr(Result, Format, Args);
  end;

begin
  Args.OpenArray(2);
  FmtStrWorkaround(string(TVarData(Args.Values[0]).vString), Args.Values[1], Slice(Args.OA^, Args.OAS));
end;

{ function StrFmt(Buffer, Format: PChar; const Args: array of const): PChar; }

procedure JvInterpreter_StrFmt(var Value: Variant; Args: TJvInterpreterArgs);

  function StrFmtWorkaround(Buffer, Format: PChar; const Args: array of const): PChar;
  begin
    Result := StrFmt(Buffer, Format, Args);
  end;

begin
  Args.OpenArray(2);
  Value := string(StrFmtWorkaround(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Slice(Args.OA^,
    Args.OAS)));
end;

{ function StrLFmt(Buffer: PChar; MaxLen: Cardinal; Format: PChar; const Args: array of const): PChar; }

procedure JvInterpreter_StrLFmt(var Value: Variant; Args: TJvInterpreterArgs);

  function StrLFmtWorkaround(Buffer: PChar; MaxLen: Cardinal; Format: PChar; const Args: array of const): PChar;
  begin
    Result := StrLFmt(Buffer, MaxLen, Format, Args);
  end;

begin
  Args.OpenArray(3);
  Value := string(StrLFmtWorkaround(PChar(string(Args.Values[0])), Args.Values[1], PChar(string(Args.Values[2])),
    Slice(Args.OA^, Args.OAS)));
end;

{ function FormatBuf(var Buffer; BufLen: Cardinal; const Format; FmtLen: Cardinal; const Args: array of const): Cardinal; }

procedure JvInterpreter_FormatBuf(var Value: Variant; Args: TJvInterpreterArgs);

  function FormatBufWorkaround(var Buffer; BufLen: Cardinal; const Format; FmtLen: Cardinal;
    const Args: array of const): Cardinal;
  begin
    Result := {$IFDEF RTL250_UP}AnsiStrings.{$ENDIF}FormatBuf(Buffer, BufLen, Format, FmtLen, Args);
  end;

begin
  Args.OpenArray(4);
  Value := Integer(FormatBufWorkaround(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], Slice(Args.OA^,
    Args.OAS)));
end;

{ function FloatToStr(Value: Extended): string; }

procedure JvInterpreter_FloatToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FloatToStr(Args.Values[0]);
end;

{ function CurrToStr(Value: Currency): string; }

procedure JvInterpreter_CurrToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CurrToStr(Args.Values[0]);
end;

{ function FloatToStrF(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): string; }

procedure JvInterpreter_FloatToStrF(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FloatToStrF(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3]);
end;

{ function CurrToStrF(Value: Currency; Format: TFloatFormat; Digits: Integer): string; }

procedure JvInterpreter_CurrToStrF(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CurrToStrF(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

(*
{ function FloatToText(Buffer: PChar; const Value; ValueType: TFloatValue; Format: TFloatFormat; Precision, Digits: Integer): Integer; }
procedure JvInterpreter_FloatToText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FloatToText(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2], Args.Values[3], Args.Values[4], Args.Values[5]);
end;
*)

{ function FormatFloat(const Format: string; Value: Extended): string; }

procedure JvInterpreter_FormatFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FormatFloat(Args.Values[0], Args.Values[1]);
end;

{ function FormatCurr(const Format: string; Value: Currency): string; }

procedure JvInterpreter_FormatCurr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FormatCurr(Args.Values[0], Args.Values[1]);
end;

(*
{ function FloatToTextFmt(Buffer: PChar; const Value; ValueType: TFloatValue; Format: PChar): Integer; }
procedure JvInterpreter_FloatToTextFmt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FloatToTextFmt(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2], PChar(string(Args.Values[3])));
end;
*)

{ function StrToFloat(const S: string): Extended; }

procedure JvInterpreter_StrToFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToFloat(Args.Values[0]);
end;

{ function StrToCurr(const S: string): Currency; }

procedure JvInterpreter_StrToCurr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToCurr(Args.Values[0]);
end;

(*
{ function TextToFloat(Buffer: PChar; var Value; ValueType: TFloatValue): Boolean; }
procedure JvInterpreter_TextToFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TextToFloat(PChar(string(Args.Values[0])), PChar(string(Args.Values[1])), Args.Values[2]);
end;
*)
(* need record
{ procedure FloatToDecimal(var Result: TFloatRec; const Value; ValueType: TFloatValue; Precision, Decimals: Integer); }
procedure JvInterpreter_FloatToDecimal(var Value: Variant; Args: TJvInterpreterArgs);
begin
  FloatToDecimal(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4]);
end;
*)

(* need record
{ function DateTimeToTimeStamp(DateTime: TDateTime): TTimeStamp; }
procedure JvInterpreter_DateTimeToTimeStamp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DateTimeToTimeStamp(Args.Values[0]);
end;

{ function TimeStampToDateTime(const TimeStamp: TTimeStamp): TDateTime; }
procedure JvInterpreter_TimeStampToDateTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TimeStampToDateTime(Args.Values[0]);
end;

{ function MSecsToTimeStamp(MSecs: Comp): TTimeStamp; }
procedure JvInterpreter_MSecsToTimeStamp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := MSecsToTimeStamp(Args.Values[0]);
end;

{ function TimeStampToMSecs(const TimeStamp: TTimeStamp): Comp; }
procedure JvInterpreter_TimeStampToMSecs(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TimeStampToMSecs(Args.Values[0]);
end;
*)

{ function EncodeDate(Year, Month, Day: Word): TDateTime; }

procedure JvInterpreter_EncodeDate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EncodeDate(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{ function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime; }

procedure JvInterpreter_EncodeTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EncodeTime(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3]);
end;

{ procedure DecodeDate(Date: TDateTime; var Year, Month, Day: Word); }

procedure JvInterpreter_DecodeDate(var Value: Variant; Args: TJvInterpreterArgs);
var
  Year, Month, Day: Word;
begin
  DecodeDate(Args.Values[0], Year, Month, Day);
  Args.Values[1] := Year;
  Args.Values[2] := Month;
  Args.Values[3] := Day;
end;

{ procedure DecodeTime(Time: TDateTime; var Hour, Min, Sec, MSec: Word); }

procedure JvInterpreter_DecodeTime(var Value: Variant; Args: TJvInterpreterArgs);
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Args.Values[0], Hour, Min, Sec, MSec);
  Args.Values[1] := Hour;
  Args.Values[2] := Min;
  Args.Values[3] := Sec;
  Args.Values[4] := MSec;
end;

(* need record
{ procedure DateTimeToSystemTime(DateTime: TDateTime; var SystemTime: TSystemTime); }
procedure JvInterpreter_DateTimeToSystemTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  DateTimeToSystemTime(Args.Values[0], Args.Values[1]);
end;

{ function SystemTimeToDateTime(const SystemTime: TSystemTime): TDateTime; }
procedure JvInterpreter_SystemTimeToDateTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SystemTimeToDateTime(Args.Values[0]);
end;
*)

{ function DayOfWeek(Date: TDateTime): Integer; }

procedure JvInterpreter_DayOfWeek(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DayOfWeek(Args.Values[0]);
end;

{ function Date: TDateTime; }

procedure JvInterpreter_Date(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Date;
end;

{ function Time: TDateTime; }

procedure JvInterpreter_Time(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Time;
end;

{ function Now: TDateTime; }

procedure JvInterpreter_Now(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Now;
end;

{ function IncMonth(const Date: TDateTime; NumberOfMonths: Integer): TDateTime; }

procedure JvInterpreter_IncMonth(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IncMonth(Args.Values[0], Args.Values[1]);
end;

{ function IsLeapYear(Year: Word): Boolean; }

procedure JvInterpreter_IsLeapYear(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IsLeapYear(Args.Values[0]);
end;

{ function DateToStr(Date: TDateTime): string; }

procedure JvInterpreter_DateToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DateToStr(Args.Values[0]);
end;

{ function TimeToStr(Time: TDateTime): string; }

procedure JvInterpreter_TimeToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TimeToStr(Args.Values[0]);
end;

{ function DateTimeToStr(DateTime: TDateTime): string; }

procedure JvInterpreter_DateTimeToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DateTimeToStr(Args.Values[0]);
end;

{ function StrToDate(const S: string): TDateTime; }

procedure JvInterpreter_StrToDate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToDate(Args.Values[0]);
end;

{ function StrToTime(const S: string): TDateTime; }

procedure JvInterpreter_StrToTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToTime(Args.Values[0]);
end;

{ function StrToDateTime(const S: string): TDateTime; }

procedure JvInterpreter_StrToDateTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToDateTime(Args.Values[0]);
end;

{ function FormatDateTime(const Format: string; DateTime: TDateTime): string; }

procedure JvInterpreter_FormatDateTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FormatDateTime(Args.Values[0], Args.Values[1]);
end;

{ procedure DateTimeToString(var Result: string; const Format: string; DateTime: TDateTime); }

procedure JvInterpreter_DateTimeToString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  DateTimeToString(string(TVarData(Args.Values[0]).vString), Args.Values[1], Args.Values[2]);
end;

{ function SysErrorMessage(ErrorCode: Integer): string; }

procedure JvInterpreter_SysErrorMessage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SysErrorMessage(Args.Values[0]);
end;

{ function GetLocaleStr(Locale, LocaleType: Integer; const Default: string): string; }

procedure JvInterpreter_GetLocaleStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := GetLocaleStr(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{ function GetLocaleChar(Locale, LocaleType: Integer; Default: Char): Char; }

procedure JvInterpreter_GetLocaleChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := GetLocaleChar(Args.Values[0], Args.Values[1], string(Args.Values[2])[1]);
end;

{ procedure GetFormatSettings; }

procedure JvInterpreter_GetFormatSettings(var Value: Variant; Args: TJvInterpreterArgs);
begin
  GetFormatSettings;
end;

{ function ExceptObject: TObject; }

procedure JvInterpreter_ExceptObject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(ExceptObject);
end;

{ function ExceptAddr: Pointer; }

procedure JvInterpreter_ExceptAddr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := P2V(ExceptAddr);
end;

{ function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer; Buffer: PChar; Size: Integer): Integer; }


procedure JvInterpreter_ExceptionErrorMessage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExceptionErrorMessage(V2O(Args.Values[0]), V2P(Args.Values[1]), PChar(string(Args.Values[2])),
    Args.Values[3]);
end;

{ procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer); }

procedure JvInterpreter_ShowException(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ShowException(V2O(Args.Values[0]), V2P(Args.Values[1]));
end;

{ procedure Abort; }

procedure JvInterpreter_Abort(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Abort;
end;

{ procedure OutOfMemoryError; }

procedure JvInterpreter_OutOfMemoryError(var Value: Variant; Args: TJvInterpreterArgs);
begin
  OutOfMemoryError;
end;

{ procedure Beep; }

procedure JvInterpreter_Beep(var Value: Variant; Args: TJvInterpreterArgs);
begin
  SysUtils.Beep;
end;

{ function ByteType(const S: string; Index: Integer): TMbcsByteType; }

procedure JvInterpreter_ByteType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ByteType(Args.Values[0], Args.Values[1]);
end;

{ function StrByteType(Str: PChar; Index: Cardinal): TMbcsByteType; }

procedure JvInterpreter_StrByteType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrByteType(PChar(string(Args.Values[0])), Args.Values[1]);
end;

{ function ByteToCharLen(const S: string; MaxLen: Integer): Integer; }

procedure JvInterpreter_ByteToCharLen(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := {$IFDEF RTL200_UP}ElementToCharLen{$ELSE}ByteToCharLen{$ENDIF RTL200_UP}(Args.Values[0], Args.Values[1]);
end;

{ function CharToByteLen(const S: string; MaxLen: Integer): Integer; }

procedure JvInterpreter_CharToByteLen(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := {$IFDEF RTL200_UP}CharToElementLen{$ELSE}CharToByteLen{$ENDIF RTL200_UP}(Args.Values[0], Args.Values[1]);
end;

{ function ByteToCharIndex(const S: string; Index: Integer): Integer; }

procedure JvInterpreter_ByteToCharIndex(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := {$IFDEF RTL200_UP}ElementToCharIndex{$ELSE}ByteToCharIndex{$ENDIF RTL200_UP}(Args.Values[0], Args.Values[1]);
end;

{ function CharToByteIndex(const S: string; Index: Integer): Integer; }

procedure JvInterpreter_CharToByteIndex(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := {$IFDEF RTL200_UP}CharToElementIndex{$ELSE}CharToByteIndex{$ENDIF RTL200_UP}(Args.Values[0], Args.Values[1]);
end;

{ function IsPathDelimiter(const S: string; Index: Integer): Boolean; }

procedure JvInterpreter_IsPathDelimiter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IsPathDelimiter(Args.Values[0], Args.Values[1]);
end;

{ function IsDelimiter(const Delimiters, S: string; Index: Integer): Boolean; }

procedure JvInterpreter_IsDelimiter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IsDelimiter(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{ function LastDelimiter(const Delimiters, S: string): Integer; }

procedure JvInterpreter_LastDelimiter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LastDelimiter(Args.Values[0], Args.Values[1]);
end;

{ function AnsiCompareFileName(const S1, S2: string): Integer; }

procedure JvInterpreter_AnsiCompareFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiCompareFileName(Args.Values[0], Args.Values[1]);
end;

{ function AnsiLowerCaseFileName(const S: string): string; }

procedure JvInterpreter_AnsiLowerCaseFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiLowerCase(Args.Values[0]);
end;

{ function AnsiUpperCaseFileName(const S: string): string; }

procedure JvInterpreter_AnsiUpperCaseFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiUpperCase(Args.Values[0]);
end;

{ function AnsiPos(const Substr, S: string): Integer; }

procedure JvInterpreter_AnsiPos(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := AnsiPos(Args.Values[0], Args.Values[1]);
end;

{ function AnsiStrPos(Str, SubStr: PChar): PChar; }

procedure JvInterpreter_AnsiStrPos(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiStrPos(PChar(string(Args.Values[0])), PChar(string(Args.Values[1]))));
end;

{ function AnsiStrRScan(Str: PChar; Chr: Char): PChar; }

procedure JvInterpreter_AnsiStrRScan(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiStrRScan(PChar(string(Args.Values[0])), string(Args.Values[1])[1]));
end;

{ function AnsiStrScan(Str: PChar; Chr: Char): PChar; }

procedure JvInterpreter_AnsiStrScan(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := string(AnsiStrScan(PChar(string(Args.Values[0])), string(Args.Values[1])[1]));
end;

{ function LoadPackage(const Name: string): HMODULE; }

procedure JvInterpreter_LoadPackage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Integer(LoadPackage(Args.Values[0]));
end;

{ procedure UnloadPackage(Module: HMODULE); }

procedure JvInterpreter_UnloadPackage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  UnloadPackage(Args.Values[0]);
end;

{$IFDEF MSWINDOWS}

{ procedure RaiseLastWin32Error; }

procedure JvInterpreter_RaiseLastWin32Error(var Value: Variant; Args: TJvInterpreterArgs);
begin
  RaiseLastOSError;
end;

{ function Win32Check(RetVal: BOOL): BOOL; }

procedure JvInterpreter_Win32Check(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Win32Check(Args.Values[0]);
end;

{$ENDIF MSWINDOWS}

{ regional options }

(*
{ read CurrencyString: string }
procedure JvInterpreter_Read_CurrencyString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CurrencyString;
end;

{ write CurrencyString: string }
procedure JvInterpreter_Write_CurrencyString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  CurrencyString := Value;
end;

{ read CurrencyFormat: Byte }
procedure JvInterpreter_Read_CurrencyFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CurrencyFormat;
end;

{ write CurrencyFormat: Byte }
procedure JvInterpreter_Write_CurrencyFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  CurrencyFormat := Value;
end;

{ read NegCurrFormat: Byte }
procedure JvInterpreter_Read_NegCurrFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NegCurrFormat;
end;

{ write NegCurrFormat: Byte }
procedure JvInterpreter_Write_NegCurrFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  NegCurrFormat := Value;
end;

{ read ThousandSeparator }
procedure JvInterpreter_Read_ThousandSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ThousandSeparator;
end;

{ write ThousandSeparator }
procedure JvInterpreter_Write_ThousandSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ThousandSeparator := string(Value)[1];
end;

{ read DecimalSeparator }
procedure JvInterpreter_Read_DecimalSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DecimalSeparator;
end;

{ write DecimalSeparator }
procedure JvInterpreter_Write_DecimalSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  DecimalSeparator := string(Value)[1];
end;

{ read CurrencyDecimals }
procedure JvInterpreter_Read_CurrencyDecimals(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CurrencyDecimals;
end;

{ write CurrencyDecimals }
procedure JvInterpreter_Write_CurrencyDecimals(var Value: Variant; Args: TJvInterpreterArgs);
begin
  CurrencyDecimals := Value;
end;

{ read DateSeparator }
procedure JvInterpreter_Read_DateSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DateSeparator;
end;

{ write DateSeparator }
procedure JvInterpreter_Write_DateSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  DateSeparator := string(Value)[1];
end;

{ read ShortDateFormat }
procedure JvInterpreter_Read_ShortDateFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ShortDateFormat;
end;

{ write ShortDateFormat }
procedure JvInterpreter_Write_ShortDateFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ShortDateFormat := Value;
end;

{ read LongDateFormat }
procedure JvInterpreter_Read_LongDateFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LongDateFormat;
end;

{ write LongDateFormat }
procedure JvInterpreter_Write_LongDateFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  LongDateFormat := Value;
end;

{ read TimeSeparator }
procedure JvInterpreter_Read_TimeSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TimeSeparator;
end;

{ write TimeSeparator }
procedure JvInterpreter_Write_TimeSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TimeSeparator := string(Value)[1];
end;

{ read TimeAMString }
procedure JvInterpreter_Read_TimeAMString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TimeAMString;
end;

{ write TimeAMString }
procedure JvInterpreter_Write_TimeAMString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TimeAMString := Value;
end;

{ read TimePMString }
procedure JvInterpreter_Read_TimePMString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TimePMString;
end;

{ write TimePMString }
procedure JvInterpreter_Write_TimePMString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TimePMString := Value;
end;

{ read ShortTimeFormat }
procedure JvInterpreter_Read_ShortTimeFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ShortTimeFormat;
end;

{ write ShortTimeFormat }
procedure JvInterpreter_Write_ShortTimeFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ShortTimeFormat := Value;
end;

{ read LongTimeFormat }
procedure JvInterpreter_Read_LongTimeFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LongTimeFormat;
end;

{ write LongTimeFormat }
procedure JvInterpreter_Write_LongTimeFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  LongTimeFormat := Value;
end;

{ read TwoDigitYearCenturyWindow }
procedure JvInterpreter_Read_TwoDigitYearCenturyWindow(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwoDigitYearCenturyWindow;
end;

{ write TwoDigitYearCenturyWindow }
procedure JvInterpreter_Write_TwoDigitYearCenturyWindow(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TwoDigitYearCenturyWindow := Value;
end;

{ read ListSeparator }
procedure JvInterpreter_Read_ListSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ListSeparator;
end;

{ write ListSeparator }
procedure JvInterpreter_Write_ListSeparator(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ListSeparator := string(Args.Values[0])[1];
end;

{ read ShortMonthNames }
procedure JvInterpreter_Read_ShortMonthNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ShortMonthNames[Integer(Args.Values[0])];
end;

{ write ShortMonthNames }
procedure JvInterpreter_Write_ShortMonthNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ShortMonthNames[Integer(Args.Values[0])] := Value;
end;

{ read LongMonthNames }
procedure JvInterpreter_Read_LongMonthNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LongMonthNames[Integer(Args.Values[0])];
end;

{ write LongMonthNames }
procedure JvInterpreter_Write_LongMonthNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  LongMonthNames[Integer(Args.Values[0])] := Value;
end;

{ read ShortDayNames }
procedure JvInterpreter_Read_ShortDayNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ShortDayNames[Integer(Args.Values[0])];
end;

{ write ShortDayNames }
procedure JvInterpreter_Write_ShortDayNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  ShortDayNames[Integer(Args.Values[0])] := Value;
end;

{ read LongDayNames }
procedure JvInterpreter_Read_LongDayNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LongDayNames[Integer(Args.Values[0])];
end;

{ write LongDayNames }
procedure JvInterpreter_Write_LongDayNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  LongDayNames[Integer(Args.Values[0])] := Value;
end;

{ read EraNames }
procedure JvInterpreter_Read_EraNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EraNames[Integer(Args.Values[0])];
end;

{ write EraNames }
procedure JvInterpreter_Write_EraNames(var Value: Variant; Args: TJvInterpreterArgs);
begin
  EraNames[Integer(Args.Values[0])] := Value;
end;

{ read EraYearOffsets }
procedure JvInterpreter_Read_EraYearOffsets(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EraYearOffsets[Integer(Args.Values[0])];
end;

{ write EraYearOffsets }
procedure JvInterpreter_Write_EraYearOffsets(var Value: Variant; Args: TJvInterpreterArgs);
begin
  EraYearOffsets[Integer(Args.Values[0])] := Value;
end;
*)

type
  PSearchRec = ^TSearchRec;

procedure JvInterpreter_NewTSearchRec(var Value: Pointer);
begin
  New(PSearchRec(Value));
end;

procedure JvInterpreter_DisposeTSearchRec(const Value: Pointer);
begin
  Dispose(PSearchRec(Value));
end;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
const
  cSysUtils = 'SysUtils';
{>>>}
var
  SR: TSearchRec;
{<<<}
begin
  with JvInterpreterAdapter do
  begin
    { Exception }
    AddClass(cSysUtils, Exception, 'Exception');
    AddGet(Exception, 'Create', Exception_Create, 1, [varEmpty], varEmpty);
    AddGet(Exception, 'CreateFmt', Exception_CreateFmt, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(Exception, 'CreateRes', Exception_CreateRes, 1, [varEmpty], varEmpty);
    AddGet(Exception, 'CreateResFmt', Exception_CreateResFmt, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(Exception, 'CreateHelp', Exception_CreateHelp, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(Exception, 'CreateFmtHelp', Exception_CreateFmtHelp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(Exception, 'CreateResHelp', Exception_CreateResHelp, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(Exception, 'CreateResFmtHelp', Exception_CreateResFmtHelp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(Exception, 'HelpContext', Exception_Read_HelpContext, 0, [varEmpty], varEmpty);
    AddSet(Exception, 'HelpContext', Exception_Write_HelpContext, 0, [varEmpty]);
    AddGet(Exception, 'Message', Exception_Read_Message, 0, [varEmpty], varEmpty);
    AddSet(Exception, 'Message', Exception_Write_Message, 0, [varEmpty]);
    { EAbort }
    AddClass(cSysUtils, EAbort, 'EAbort');
    { EOutOfMemory }
    AddClass(cSysUtils, EOutOfMemory, 'EOutOfMemory');
    { EInOutError }
    AddClass(cSysUtils, EInOutError, 'EInOutError');
    { EIntError }
    AddClass(cSysUtils, EIntError, 'EIntError');
    { EDivByZero }
    AddClass(cSysUtils, EDivByZero, 'EDivByZero');
    { ERangeError }
    AddClass(cSysUtils, ERangeError, 'ERangeError');
    { EIntOverflow }
    AddClass(cSysUtils, EIntOverflow, 'EIntOverflow');
    { EMathError }
    AddClass(cSysUtils, EMathError, 'EMathError');
    { EInvalidOp }
    AddClass(cSysUtils, EInvalidOp, 'EInvalidOp');
    { EZeroDivide }
    AddClass(cSysUtils, EZeroDivide, 'EZeroDivide');
    { EOverflow }
    AddClass(cSysUtils, EOverflow, 'EOverflow');
    { EUnderflow }
    AddClass(cSysUtils, EUnderflow, 'EUnderflow');
    { EInvalidPointer }
    AddClass(cSysUtils, EInvalidPointer, 'EInvalidPointer');
    { EInvalidCast }
    AddClass(cSysUtils, EInvalidCast, 'EInvalidCast');
    { EConvertError }
    AddClass(cSysUtils, EConvertError, 'EConvertError');
    { EAccessViolation }
    AddClass(cSysUtils, EAccessViolation, 'EAccessViolation');
    { EPrivilege }
    AddClass(cSysUtils, EPrivilege, 'EPrivilege');
    { EControlC }
    AddClass(cSysUtils, EControlC, 'EControlC');
    { EVariantError }
    AddClass(cSysUtils, EVariantError, 'EVariantError');
    { EPropReadOnly }
    AddClass(cSysUtils, EPropReadOnly, 'EPropReadOnly');
    { EPropWriteOnly }
    AddClass(cSysUtils, EPropWriteOnly, 'EPropWriteOnly');
    { EExternalException }
    AddClass(cSysUtils, EExternalException, 'EExternalException');

    { EAssertionFailed }
    AddClass(cSysUtils, EAssertionFailed, 'EAssertionFailed');
    {$IFNDEF PC_MAPPED_EXCEPTIONS} // Linux define symbol
    { EAbstractError }
    AddClass(cSysUtils, EAbstractError, 'EAbstractError');
    {$ENDIF !PC_MAPPED_EXCEPTIONS}
    { EIntfCastError }
    AddClass(cSysUtils, EIntfCastError, 'EIntfCastError');
    { EInvalidContainer }
    AddClass(cSysUtils, EInvalidContainer, 'EInvalidContainer');
    { EInvalidInsert }
    AddClass(cSysUtils, EInvalidInsert, 'EInvalidInsert');
    { EPackageError }
    AddClass(cSysUtils, EPackageError, 'EPackageError');
    // (rom) changed to EOSError for Delphi 6
    { EOSError }
    AddClass(cSysUtils, EOSError, 'EOSError');

    AddFunction(cSysUtils, 'AllocMem', JvInterpreter_AllocMem, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'UpperCase', JvInterpreter_UpperCase, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'LowerCase', JvInterpreter_LowerCase, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'CompareStr', JvInterpreter_CompareStr, 2, [varEmpty, varEmpty], varEmpty);

    AddFunction(cSysUtils, 'CompareMem', JvInterpreter_CompareMem, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    AddFunction(cSysUtils, 'CompareText', JvInterpreter_CompareText, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiUpperCase', JvInterpreter_AnsiUpperCase, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiLowerCase', JvInterpreter_AnsiLowerCase, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiCompareStr', JvInterpreter_AnsiCompareStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiCompareText', JvInterpreter_AnsiCompareText, 2, [varEmpty, varEmpty], varEmpty);

    AddFunction(cSysUtils, 'AnsiStrComp', JvInterpreter_AnsiStrComp, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrIComp', JvInterpreter_AnsiStrIComp, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrLComp', JvInterpreter_AnsiStrLComp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrLIComp', JvInterpreter_AnsiStrLIComp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrLower', JvInterpreter_AnsiStrLower, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrUpper', JvInterpreter_AnsiStrUpper, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiLastChar', JvInterpreter_AnsiLastChar, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrLastChar', JvInterpreter_AnsiStrLastChar, 1, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'Trim', JvInterpreter_Trim, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'TrimLeft', JvInterpreter_TrimLeft, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'TrimRight', JvInterpreter_TrimRight, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'QuotedStr', JvInterpreter_QuotedStr, 1, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'AnsiQuotedStr', JvInterpreter_AnsiQuotedStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiExtractQuotedStr', JvInterpreter_AnsiExtractQuotedStr, 2, [varByRef, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExtractQuotedString', JvInterpreter_ExtractQuotedString, 2, [varEmpty, varEmpty], varEmpty);

    AddFunction(cSysUtils, 'AdjustLineBreaks', JvInterpreter_AdjustLineBreaks, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'IsValidIdent', JvInterpreter_IsValidIdent, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'IntToStr', JvInterpreter_IntToStr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'IntToHex', JvInterpreter_IntToHex, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToInt', JvInterpreter_StrToInt, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToIntDef', JvInterpreter_StrToIntDef, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'LoadStr', JvInterpreter_LoadStr, 1, [varEmpty], varEmpty);
    // AddFunction(cSysUtils, 'FmtLoadStr', JvInterpreter_FmtLoadStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileOpen', JvInterpreter_FileOpen, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileCreate', JvInterpreter_FileCreate, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileRead', JvInterpreter_FileRead, 3, [varEmpty, varByRef, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileWrite', JvInterpreter_FileWrite, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileSeek', JvInterpreter_FileSeek, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileClose', JvInterpreter_FileClose, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileAge', JvInterpreter_FileAge, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileExists', JvInterpreter_FileExists, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FindFirst', JvInterpreter_FindFirst, 3, [varEmpty, varEmpty, varByRef], varEmpty);
    AddFunction(cSysUtils, 'FindNext', JvInterpreter_FindNext, 1, [varByRef], varEmpty);
    AddFunction(cSysUtils, 'FindClose', JvInterpreter_FindClose, 1, [varByRef], varEmpty);
    AddFunction(cSysUtils, 'FileGetDate', JvInterpreter_FileGetDate, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileSetDate', JvInterpreter_FileSetDate, 2, [varEmpty, varEmpty], varEmpty);
    {$IFDEF MSWINDOWS}
    AddFunction(cSysUtils, 'FileGetAttr', JvInterpreter_FileGetAttr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FileSetAttr', JvInterpreter_FileSetAttr, 2, [varEmpty, varEmpty], varEmpty);
    {$ENDIF MSWINDOWS}
    AddFunction(cSysUtils, 'DeleteFile', JvInterpreter_DeleteFile, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'RenameFile', JvInterpreter_RenameFile, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ChangeFileExt', JvInterpreter_ChangeFileExt, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExtractFilePath', JvInterpreter_ExtractFilePath, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExtractFileDir', JvInterpreter_ExtractFileDir, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExtractFileDrive', JvInterpreter_ExtractFileDrive, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExtractFileName', JvInterpreter_ExtractFileName, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExtractFileExt', JvInterpreter_ExtractFileExt, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExpandFileName', JvInterpreter_ExpandFileName, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExpandUNCFileName', JvInterpreter_ExpandUNCFileName, 1, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'ExtractRelativePath', JvInterpreter_ExtractRelativePath, 2, [varEmpty, varEmpty], varEmpty);

    AddFunction(cSysUtils, 'FileSearch', JvInterpreter_FileSearch, 2, [varEmpty, varEmpty], varEmpty);
    {$IFDEF MSWINDOWS}
    AddFunction(cSysUtils, 'DiskFree', JvInterpreter_DiskFree, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'DiskSize', JvInterpreter_DiskSize, 1, [varEmpty], varEmpty);
    {$ENDIF MSWINDOWS}
    AddFunction(cSysUtils, 'FileDateToDateTime', JvInterpreter_FileDateToDateTime, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'DateTimeToFileDate', JvInterpreter_DateTimeToFileDate, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'GetCurrentDir', JvInterpreter_GetCurrentDir, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'SetCurrentDir', JvInterpreter_SetCurrentDir, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'CreateDir', JvInterpreter_CreateDir, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'RemoveDir', JvInterpreter_RemoveDir, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLen', JvInterpreter_StrLen, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrEnd', JvInterpreter_StrEnd, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrMove', JvInterpreter_StrMove, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrCopy', JvInterpreter_StrCopy, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrECopy', JvInterpreter_StrECopy, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLCopy', JvInterpreter_StrLCopy, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrPCopy', JvInterpreter_StrPCopy, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrPLCopy', JvInterpreter_StrPLCopy, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrCat', JvInterpreter_StrCat, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLCat', JvInterpreter_StrLCat, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrComp', JvInterpreter_StrComp, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrIComp', JvInterpreter_StrIComp, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLComp', JvInterpreter_StrLComp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLIComp', JvInterpreter_StrLIComp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrScan', JvInterpreter_StrScan, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrRScan', JvInterpreter_StrRScan, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrPos', JvInterpreter_StrPos, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrUpper', JvInterpreter_StrUpper, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLower', JvInterpreter_StrLower, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrPas', JvInterpreter_StrPas, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrAlloc', JvInterpreter_StrAlloc, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrBufSize', JvInterpreter_StrBufSize, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrNew', JvInterpreter_StrNew, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrDispose', JvInterpreter_StrDispose, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Format', JvInterpreter_Format, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FmtStr', JvInterpreter_FmtStr, 3, [varByRef, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrFmt', JvInterpreter_StrFmt, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrLFmt', JvInterpreter_StrLFmt, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FormatBuf', JvInterpreter_FormatBuf, 5, [varByRef, varEmpty, varEmpty, varEmpty, varEmpty],
      varEmpty);
    AddFunction(cSysUtils, 'FloatToStr', JvInterpreter_FloatToStr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'CurrToStr', JvInterpreter_CurrToStr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FloatToStrF', JvInterpreter_FloatToStrF, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'CurrToStrF', JvInterpreter_CurrToStrF, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    // AddFunction(cSysUtils, 'FloatToText', JvInterpreter_FloatToText, 6, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FormatFloat', JvInterpreter_FormatFloat, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FormatCurr', JvInterpreter_FormatCurr, 2, [varEmpty, varEmpty], varEmpty);
    // AddFunction(cSysUtils, 'FloatToTextFmt', JvInterpreter_FloatToTextFmt, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToFloat', JvInterpreter_StrToFloat, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToCurr', JvInterpreter_StrToCurr, 1, [varEmpty], varEmpty);
    // AddFunction(cSysUtils, 'TextToFloat', JvInterpreter_TextToFloat, 3, [varEmpty, varByRef, varEmpty], varEmpty);
    // AddFunction(cSysUtils, 'FloatToDecimal', JvInterpreter_FloatToDecimal, 5, [varByRef, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
   { AddFunction(cSysUtils, 'DateTimeToTimeStamp', JvInterpreter_DateTimeToTimeStamp, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'TimeStampToDateTime', JvInterpreter_TimeStampToDateTime, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'MSecsToTimeStamp', JvInterpreter_MSecsToTimeStamp, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'TimeStampToMSecs', JvInterpreter_TimeStampToMSecs, 1, [varEmpty], varEmpty); }
    AddFunction(cSysUtils, 'EncodeDate', JvInterpreter_EncodeDate, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'EncodeTime', JvInterpreter_EncodeTime, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'DecodeDate', JvInterpreter_DecodeDate, 4, [varEmpty, varByRef, varByRef, varByRef], varEmpty);
    AddFunction(cSysUtils, 'DecodeTime', JvInterpreter_DecodeTime, 5, [varEmpty, varByRef, varByRef, varByRef, varByRef],
      varEmpty);
    { AddFunction(cSysUtils, 'DateTimeToSystemTime', JvInterpreter_DateTimeToSystemTime, 2, [varEmpty, varByRef], varEmpty);
    AddFunction(cSysUtils, 'SystemTimeToDateTime', JvInterpreter_SystemTimeToDateTime, 1, [varEmpty], varEmpty); }
    AddFunction(cSysUtils, 'DayOfWeek', JvInterpreter_DayOfWeek, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Date', JvInterpreter_Date, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Time', JvInterpreter_Time, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Now', JvInterpreter_Now, 0, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'IncMonth', JvInterpreter_IncMonth, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'IsLeapYear', JvInterpreter_IsLeapYear, 1, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'DateToStr', JvInterpreter_DateToStr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'TimeToStr', JvInterpreter_TimeToStr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'DateTimeToStr', JvInterpreter_DateTimeToStr, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToDate', JvInterpreter_StrToDate, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToTime', JvInterpreter_StrToTime, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrToDateTime', JvInterpreter_StrToDateTime, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'FormatDateTime', JvInterpreter_FormatDateTime, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'DateTimeToString', JvInterpreter_DateTimeToString, 3, [varByRef, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'SysErrorMessage', JvInterpreter_SysErrorMessage, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'GetLocaleStr', JvInterpreter_GetLocaleStr, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'GetLocaleChar', JvInterpreter_GetLocaleChar, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'GetFormatSettings', JvInterpreter_GetFormatSettings, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExceptObject', JvInterpreter_ExceptObject, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ExceptAddr', JvInterpreter_ExceptAddr, 0, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'ExceptionErrorMessage', JvInterpreter_ExceptionErrorMessage, 4, [varEmpty, varEmpty, varEmpty,
      varEmpty], varEmpty);

    AddFunction(cSysUtils, 'ShowException', JvInterpreter_ShowException, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Abort', JvInterpreter_Abort, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'OutOfMemoryError', JvInterpreter_OutOfMemoryError, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Beep', JvInterpreter_Beep, 0, [varEmpty], varEmpty);

    AddFunction(cSysUtils, 'ByteType', JvInterpreter_ByteType, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'StrByteType', JvInterpreter_StrByteType, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ByteToCharLen', JvInterpreter_ByteToCharLen, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'CharToByteLen', JvInterpreter_CharToByteLen, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'ByteToCharIndex', JvInterpreter_ByteToCharIndex, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'CharToByteIndex', JvInterpreter_CharToByteIndex, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'IsPathDelimiter', JvInterpreter_IsPathDelimiter, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'IsDelimiter', JvInterpreter_IsDelimiter, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'LastDelimiter', JvInterpreter_LastDelimiter, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiCompareFileName', JvInterpreter_AnsiCompareFileName, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiLowerCaseFileName', JvInterpreter_AnsiLowerCaseFileName, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiUpperCaseFileName', JvInterpreter_AnsiUpperCaseFileName, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiPos', JvInterpreter_AnsiPos, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrPos', JvInterpreter_AnsiStrPos, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrRScan', JvInterpreter_AnsiStrRScan, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'AnsiStrScan', JvInterpreter_AnsiStrScan, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cSysUtils, 'LoadPackage', JvInterpreter_LoadPackage, 1, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'UnloadPackage', JvInterpreter_UnloadPackage, 1, [varEmpty], varEmpty);
    {$IFDEF MSWINDOWS}
    AddFunction(cSysUtils, 'RaiseLastWin32Error', JvInterpreter_RaiseLastWin32Error, 0, [varEmpty], varEmpty);
    AddFunction(cSysUtils, 'Win32Check', JvInterpreter_Win32Check, 1, [varEmpty], varEmpty);
    {$ENDIF MSWINDOWS}

    { File open modes }
    AddConst(cSysUtils, 'fmOpenRead', Ord(fmOpenRead));
    AddConst(cSysUtils, 'fmOpenWrite', Ord(fmOpenWrite));
    AddConst(cSysUtils, 'fmOpenReadWrite', Ord(fmOpenReadWrite));
    {$IFDEF MSWINDOWS}
    AddConst(cSysUtils, 'fmShareCompat', Ord(fmShareCompat));
    {$ENDIF MSWINDOWS}
    AddConst(cSysUtils, 'fmShareExclusive', Ord(fmShareExclusive));
    AddConst(cSysUtils, 'fmShareDenyWrite', Ord(fmShareDenyWrite));
    {$IFDEF MSWINDOWS}
    AddConst(cSysUtils, 'fmShareDenyRead', Ord(fmShareDenyRead));
    {$ENDIF MSWINDOWS}
    AddConst(cSysUtils, 'fmShareDenyNone', Ord(fmShareDenyNone));
   { File attribute constants }
    AddConst(cSysUtils, 'faReadOnly', Ord(faReadOnly));
    AddConst(cSysUtils, 'faHidden', Ord(faHidden));
    AddConst(cSysUtils, 'faSysFile', Ord(faSysFile));
    {$IFNDEF COMPILER8_UP}
    AddConst(cSysUtils, 'faVolumeID', Ord(faVolumeID)); // deprecated
    {$ENDIF !COMPILER8_UP}
    AddConst(cSysUtils, 'faDirectory', Ord(faDirectory));
    AddConst(cSysUtils, 'faArchive', Ord(faArchive));
    AddConst(cSysUtils, 'faAnyFile', Ord(faAnyFile));

    AddRec(cSysUtils, 'TSearchRec', SizeOf(TSearchRec), [
      RFD('Time', NativeInt(@SR.Time)-NativeInt(@SR), varInteger),
      RFD('Size', NativeInt(@SR.Size)-NativeInt(@SR), varInteger),     // Supports only integer size
      RFD('Attr', NativeInt(@SR.Attr)-NativeInt(@SR), varInteger),
      RFD('Name', NativeInt(@SR.Name)-NativeInt(@SR), varString),
      RFD('ExcludeAttr', NativeInt(@SR.ExcludeAttr)-NativeInt(@SR), varInteger),
      RFD('FindHandle', NativeInt(@SR.FindHandle)-NativeInt(@SR), varInteger)
      ],
      JvInterpreter_NewTSearchRec, JvInterpreter_DisposeTSearchRec, nil);
    { regional options }
    { global variables are not supported by JvInterpreter :( }
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
