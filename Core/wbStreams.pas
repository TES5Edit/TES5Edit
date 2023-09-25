{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbStreams;

{$I wbDefines.inc}

interface

uses
  SysUtils, Math, Classes, Windows;

type
  TwbBaseCachedFileStream = class(TBufferedFileStream)
  public
    function ReadByte: Byte; inline;
    function ReadWord: Word; inline;
    function ReadCardinal: Cardinal; inline;
    function ReadInt64: Int64; inline;
    function ReadUInt64: UInt64; inline;
    function ReadStringLen(Term: Boolean = True): string;
    function ReadStringLen16: string;
    function ReadStringTerm: string;

    procedure WriteByte(aValue: Byte); inline;
    procedure WriteWord(aValue: Word); inline;
    procedure WriteCardinal(aValue: Cardinal); inline;
    procedure WriteSmallInt(aValue: SmallInt); inline;
    procedure WriteInt64(aValue: Int64); inline;
    procedure WriteUInt64(aValue: UInt64); inline;
    procedure WriteStringLen(const aValue: string; Term: Boolean = True);
    procedure WriteStringLen16(const aValue: string);
    procedure WriteStringTerm(const aValue: string);
  end;

  TwbReadOnlyCachedFileStream = TwbBaseCachedFileStream;
  TwbWriteCachedFileStream = TwbBaseCachedFileStream;

  TwbNothing = record
  end;

const
  wbNothing: TwbNothing = ();

implementation

function TwbBaseCachedFileStream.ReadCardinal: Cardinal;
begin
  ReadBuffer(Result, SizeOf(Result));
end;

function TwbBaseCachedFileStream.ReadInt64: Int64;
begin
  ReadBuffer(Result, SizeOf(Result));
end;

function TwbBaseCachedFileStream.ReadUInt64: UInt64;
begin
  ReadBuffer(Result, SizeOf(Result));
end;

function TwbBaseCachedFileStream.ReadByte: Byte;
begin
  ReadBuffer(Result, SizeOf(Result));
end;

function TwbBaseCachedFileStream.ReadWord: Word;
begin
  ReadBuffer(Result, SizeOf(Result));
end;

function TwbBaseCachedFileStream.ReadStringLen(Term: Boolean = True): string;
var
  Len : Byte;
  s   : AnsiString;
begin
  ReadBuffer(Len, 1);
  SetLength(s, Len);
  if Len > 0 then begin
    ReadBuffer(s[1], Len);
    if Term then
      SetLength(s, Pred(Length(s)));
  end;
  Result := string(s);
end;

function TwbBaseCachedFileStream.ReadStringLen16: string;
var
  Len : Word;
  s   : AnsiString;
begin
  ReadBuffer(Len, 2);
  SetLength(s, Len);
  if Len > 0 then
    ReadBuffer(s[1], Len);
  Result := string(s);
end;

function TwbBaseCachedFileStream.ReadStringTerm: string;
var
  i: Integer;
  s: AnsiString;
begin
  SetLength(s, 256);
  i := 0;
  repeat
    Inc(i);
    ReadBuffer(s[i], 1);
  until s[i] = #0;
  SetLength(s, Pred(i));
  Result := string(s);
end;

procedure TwbBaseCachedFileStream.WriteByte(aValue: Byte);
begin
  WriteBuffer(aValue, SizeOf(aValue));
end;

procedure TwbBaseCachedFileStream.WriteWord(aValue: Word);
begin
  WriteBuffer(aValue, SizeOf(aValue));
end;

procedure TwbBaseCachedFileStream.WriteCardinal(aValue: Cardinal);
begin
  WriteBuffer(aValue, SizeOf(aValue));
end;

procedure TwbBaseCachedFileStream.WriteSmallInt(aValue: SmallInt);
begin
  WriteBuffer(aValue, SizeOf(aValue));
end;

procedure TwbBaseCachedFileStream.WriteInt64(aValue: Int64);
begin
  WriteBuffer(aValue, SizeOf(aValue));
end;

procedure TwbBaseCachedFileStream.WriteUInt64(aValue: UInt64);
begin
  WriteBuffer(aValue, SizeOf(aValue));
end;

procedure TwbBaseCachedFileStream.WriteStringLen(const aValue: string; Term: Boolean = True);
var
  Len : Byte;
  s   : AnsiString;
begin
  if Term then
    s := AnsiString(aValue) + #0
  else
    s := AnsiString(aValue);

  Len := Length(s);
  WriteBuffer(Len, SizeOf(Len));
  WriteBuffer(s[1], Length(s));
end;

procedure TwbBaseCachedFileStream.WriteStringLen16(const aValue: string);
var
  Len : Word;
  s   : AnsiString;
begin
  s := AnsiString(aValue);
  Len := Length(s);
  WriteBuffer(Len, SizeOf(Len));
  WriteBuffer(s[1], Length(s));
end;

procedure TwbBaseCachedFileStream.WriteStringTerm(const aValue: string);
var
  s   : AnsiString;
begin
  s := AnsiString(aValue) + #0;
  WriteBuffer(s[1], Length(s));
end;

initialization
finalization
end.
