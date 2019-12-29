{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbBetterStringList;

{$I wbDefines.inc}

interface

uses
  System.Types,
  System.Classes,
  System.SysUtils;

type
  TStringListHelper = class helper for TStringList
    procedure RemoveDuplicates;
  end;

implementation

uses
  DDetours,
  wbInterface,
  wbSort;

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

  TCompareStrings = function(const S1, S2: string): Integer of object;

var
  CodePointer_TStringList_Assign : TAssign;
  Trampoline_TStringList_Assign  : procedure(Self: TObject; Source: TPersistent);

procedure Detour_TStringList_Assign(Self: TStringListProtectedHacker; Source: TStringListPrivateHacker);
var
  CompareSelf, CompareSource: TCompareStrings;
begin
  if TObject(Source) is TStringList then begin
    with TStringListPrivateHacker(Self), Self do begin
      BeginUpdate;
      try
        Clear;
        FCaseSensitive := Source.FCaseSensitive;
        FDuplicates := Source.FDuplicates;

        { Don't sort during copying, will sort after if necessary }
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
          { there may be overriden methods that need to be called }
          AddStrings(TStrings(Source));

        CompareSelf := Self.CompareStrings;
        CompareSource := TStringListProtectedHacker(Source).CompareStrings;
        if TMethod(CompareSelf).Code = TMethod(CompareSelf).Code then
          { source and self are using the same compare method, so if source
            was already sorted, self is now already correctly sorted too }
          FSorted := Source.FSorted
        else
          { source and self are using different compare methods, we need to
            actually sort the strings now }
          Sorted := Source.FSorted;
      finally
        EndUpdate;
      end;
    end;
  end else
    Trampoline_TStringList_Assign(Self, Source);
end;

type
  TSort = procedure of object;

var
  CodePointer_TStringList_Sort           : TSort;
  CodePointer_TStringList_CompareStrings : TCompareStrings;
  Trampoline_TStringList_Sort            : procedure(Self: TStringListProtectedHacker);

function ListSortCompareStringItemPtr_AnsiCompareStr(Item1, Item2: TwbMergeSort<TwbTwoPtr>.TPtr): Integer;
{$IFDEF WIN32}
asm
  mov eax,[eax]
  mov edx,[edx]
  jmp AnsiCompareStr
end;
{$ENDIF}
{$IFDEF WIN64}
asm
  mov rcx,[rcx]
  mov rdx,[rdx]
  jmp AnsiCompareStr
end;
{$ENDIF}

function ListSortCompareStringItemPtr_AnsiCompareText(Item1, Item2: TwbMergeSort<TwbTwoPtr>.TPtr): Integer;
{$IFDEF WIN32}
asm
  mov eax,[eax]
  mov edx,[edx]
  jmp AnsiCompareText
end;
{$ENDIF}
{$IFDEF WIN64}
asm
  mov rcx,[rcx]
  mov rdx,[rdx]
  jmp AnsiCompareText
end;
{$ENDIF}

function ListSortCompareStringItemPtr_CompareStr(Item1, Item2: TwbMergeSort<TwbTwoPtr>.TPtr): Integer;
{$IFDEF WIN32}
asm
  mov eax,[eax]
  mov edx,[edx]
  jmp CompareStr
end;
{$ENDIF}
{$IFDEF WIN64}
asm
  mov rcx,[rcx]
  mov rdx,[rdx]
  jmp CompareStr
end;
{$ENDIF}

function ListSortCompareStringItemPtr_CompareText(Item1, Item2: TwbMergeSort<TwbTwoPtr>.TPtr): Integer;
{$IFDEF WIN32}
asm
  mov eax,[eax]
  mov edx,[edx]
  jmp CompareText
end;
{$ENDIF}
{$IFDEF WIN64}
(**)
asm
  mov rcx,[rcx]
  mov rdx,[rdx]
  jmp CompareText
end;
(** )
begin
  Result := CompareText(String(Item1^.A), string(Item2^.A));
end;
(**)
{$ENDIF}

procedure Detour_TStringList_Sort(Self: TStringListProtectedHacker);
var
  CanHandle       : Boolean;
  CompareSelf     : TCompareStrings;
  ListSortCompare : TwbMergeSort<TwbTwoPtr>.TListSortCompareTPtr;
  //List: TStringItemList;
  i: Integer;
begin
  with TStringListPrivateHacker(Self), Self do begin
    if FSorted or (FCount < 2) then
      Exit;
    CanHandle := True;
    if ClassType <> TStringList then begin
      CompareSelf := CompareStrings;
      if TMethod(CompareSelf).Code <> TMethod(CodePointer_TStringList_CompareStrings).Code then
        CanHandle := False;
    end;
    if CanHandle then begin
      if UseLocale then
        if CaseSensitive then
          ListSortCompare := ListSortCompareStringItemPtr_AnsiCompareStr
        else
          ListSortCompare := ListSortCompareStringItemPtr_AnsiCompareText
      else
        if CaseSensitive then
          ListSortCompare := ListSortCompareStringItemPtr_CompareStr
        else
          ListSortCompare := ListSortCompareStringItemPtr_CompareText;

      TwbMergeSort<TwbTwoPtr>.Sort(@FList[0], FCount, ListSortCompare);
    end else
      Trampoline_TStringList_Sort(Self);
  end;
end;

{ TStringListHelper }

procedure TStringListHelper.RemoveDuplicates;
var
  CanHandle       : Boolean;
  CompareSelf     : TCompareStrings;
  ListSortCompare : function(const S1, S2: string): Integer;
  i, j            : Integer;
  Obj             : TObject;
begin
  if Count < 2 then
    Exit;

  CanHandle := True;
  if ClassType <> TStringList then begin
    CompareSelf := CompareStrings;
    if TMethod(CompareSelf).Code <> TMethod(CodePointer_TStringList_CompareStrings).Code then
      CanHandle := False;
  end;

  if CanHandle then begin
    if UseLocale then
      if CaseSensitive then
        ListSortCompare := AnsiCompareStr
      else
        ListSortCompare := AnsiCompareText
    else
      if CaseSensitive then
        ListSortCompare := CompareStr
      else
        ListSortCompare := CompareText;

    with TStringListPrivateHacker(Self) do begin
      j := 1;
      for i := 1 to Pred(FCount) do
        if ListSortCompare(FList[i].FString, FList[Pred(j)].FString) <> 0 then begin
          if i <> j then begin
            FList[j] := FList[i];
          end;
          Inc(j);
        end else with FList[i] do begin
          if OwnsObjects then
            Obj := FObject
          else
            Obj := nil;
          FString := '';
          FObject := nil;
          Obj.Free;
        end;
      FCount := j;
    end;
  end else
    raise Exception.Create('Can''t handle RemoveDuplicates for this list.');
end;

initialization

  with TStringListProtectedHacker(TStringList.Create) do try
    CodePointer_TStringList_Assign := Assign;
    CodePointer_TStringList_Sort := Sort;
    CodePointer_TStringList_CompareStrings := CompareStrings;
  finally
    Free;
  end;

  BeginHooks;
  try

    @Trampoline_TStringList_Assign := InterceptCreate(@CodePointer_TStringList_Assign, @Detour_TStringList_Assign);
    @Trampoline_TStringList_Sort := InterceptCreate(@CodePointer_TStringList_Sort, @Detour_TStringList_Sort);

  finally
    EndHooks;
  end;

finalization

  BeginUnHooks;
  try

    InterceptRemove(@Trampoline_TStringList_Assign);
    InterceptRemove(@Trampoline_TStringList_Sort);

  finally
    EndUnHooks;
  end;

end.

