{******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit wbBetterStringList;

{$I wbDefines.inc}

interface

uses
  System.Types,
  System.Classes,
  System.SysUtils,
  DDetours;

implementation

type
  TAssign = procedure(Source: TPersistent) of object;

  TStringsPrivateHacker = class(TPersistent)
  private
    FEncoding: TEncoding;
    FDefaultEncoding: TEncoding;
    FLineBreak: string;
    FAdapter: IStringsAdapter;
    FUpdateCount: Integer;
    FDelimiter: Char;
    FQuoteChar: Char;
    FNameValueSeparator: Char;
    FOptions: TStringsOptions;
  end;

  TStringListPrivateHacker = class(TStringsPrivateHacker)
  private
    FList: TStringItemList;
    FCount: Integer;
    FCapacity: Integer;
    FSorted: Boolean;
    FDuplicates: TDuplicates;
    FCaseSensitive: Boolean;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    FOwnsObject: Boolean;
  end;

  TStringListProtectedHacker = class(TStringList);

var
  CodePointer_TStringList_Assign : TAssign;
  Trampoline_TStringList_Assign  : procedure(Self: TObject; Source: TPersistent);

procedure Detour_TStringList_Assign(Self: TStringListProtectedHacker; Source: TStringListPrivateHacker);
begin
  if TObject(Source) is TStringList then begin
    with TStringListPrivateHacker(Self), Self do begin
      BeginUpdate;
      try
        Clear;
        FCaseSensitive := Source.FCaseSensitive;
        FDuplicates := Source.FDuplicates;
        FSorted := False;

        DefaultEncoding := Source.FDefaultEncoding;
        SetEncoding(Source.FEncoding);

        FLineBreak := Source.FLineBreak;
        FDelimiter := Source.FDelimiter;
        FQuoteChar := Source.FQuoteChar;
        FNameValueSeparator := Source.FNameValueSeparator;
        FOptions := Source.FOptions;

        if Self.ClassType = TStringList then begin
          { we know exactly what class it is, so can shortcut this }
          FList := Copy(Source.FList);
          FCount := Source.FCount;
          FCapacity := Source.FCapacity;
        end else
          { there may be overriden methods that need to be called... }
          AddStrings(TStrings(Source));

        FSorted := Source.FSorted;
      finally
        EndUpdate;
      end;
    end;
  end else
    Trampoline_TStringList_Assign(Self, Source);
end;

initialization

  with TStringList.Create do try
    CodePointer_TStringList_Assign := Assign;
  finally
    Free;
  end;

  BeginHooks;
  try

    @Trampoline_TStringList_Assign := InterceptCreate(@CodePointer_TStringList_Assign, @Detour_TStringList_Assign);

  finally
    EndHooks;
  end;

finalization

  BeginUnHooks;
  try

    InterceptRemove(@Trampoline_TStringList_Assign);

  finally
    EndUnHooks;
  end;

end.

