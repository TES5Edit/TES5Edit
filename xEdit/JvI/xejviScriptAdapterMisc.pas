{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterMisc;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.Math,
  System.StrUtils,
  System.SysUtils,
  System.Types,
  System.Variants,

  Vcl.Clipbrd,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.FileCtrl,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.StdCtrls,

  WinApi.ShellApi,
  WinApi.Windows,

  wbInterface,

  xejviScriptAdapterMiscJson,
  xejviScriptAdapterMiscRegEx,
  xejviScriptAdapterMiscVcl,
  xejviScriptArguments;


{ Classes Events }

{type
  TJvInterpreterClassesEvent = class(TJvInterpreterEvent)
  private
    procedure NotifyEvent(Sender: TObject);
  end;

procedure TJvInterpreterClassesEvent.NotifyEvent(Sender: TObject);
begin
  CallFunction(nil, [O2V(Sender)]);
end;}

function TStringList_IndexStr(const AText: String; const AValues: TStringList): Integer;
begin
  Result := -1;
  for var i := 0 to Pred(AValues.Count) do
    if SameStr(AText, AValues[i]) then
    begin
      Result := i;
      Break;
    end;
end;

{ Clipboard }

procedure JvInterpreter_Clipboard_GetAsText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Clipboard.AsText;
end;

procedure JvInterpreter_Clipboard_SetAsText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  var s := string(Args.Values[0]);
  if Length(s) > 0 then
    Clipboard.AsText := s
  else
    Clipboard.Clear;
end;

{ StrUtils }

procedure JvInterpreter_ContainsStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ContainsStr(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_ContainsText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ContainsText(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_DupeString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := DupeString(String(Args.Values[0]), Integer(Args.Values[1]));
end;

procedure JvInterpreter_EndsStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EndsStr(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_EndsText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EndsText(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_IfThen(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if VarType(Args.Values[1]) = VarType(Args.Values[2]) then
    case VarType(Args.Values[1]) of
      varString  : Value := IfThen(Boolean(Args.Values[0]), String(Args.Values[1]), String(Args.Values[2]));
      varUString : Value := IfThen(Boolean(Args.Values[0]), UTF8String(Args.Values[1]), UTF8String(Args.Values[2]));
      varInteger : Value := IfThen(Boolean(Args.Values[0]), Integer(Args.Values[1]), Integer(Args.Values[2]));
      varSingle  : Value := IfThen(Boolean(Args.Values[0]), Single(Args.Values[1]), Single(Args.Values[2]));
      varDouble  : Value := IfThen(Boolean(Args.Values[0]), Double(Args.Values[1]), Double(Args.Values[2]));
    end
  else
    if Boolean(Args.Values[0]) then
      Value := Variant(Args.Values[1])
    else
      Value := Variant(Args.Values[2]);
end;

procedure JvInterpreter_IndexStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := -1;
  if VarIsArray(Args.Values[1]) then
    Value := IndexStr(String(Args.Values[0]), System.TArray<string>(Args.Values[1]))
  else if ObjectArgument(Args.Values[1], TObject, 1) is TStringList then
    Value := TStringList_IndexStr(String(Args.Values[0]), TStringList(V2O(Args.Values[1])));
end;

procedure JvInterpreter_IndexText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := -1;
  if VarIsArray(Args.Values[1]) then
    Value := IndexText(String(Args.Values[0]), System.TArray<string>(Args.Values[1]))
  else if ObjectArgument(Args.Values[1], TObject, 1) is TStringList then
    Value := TStringList(V2O(Args.Values[1])).IndexOf(String(Args.Values[0]));
end;

procedure JvInterpreter_LeftStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := LeftStr(String(Args.Values[0]), Integer(Args.Values[1]));
end;

procedure JvInterpreter_MatchStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := False;
  if VarIsArray(Args.Values[1]) then
    Value := MatchStr(String(Args.Values[0]), System.TArray<string>(Args.Values[1]))
  else if ObjectArgument(Args.Values[1], TObject, 1) is TStringList then
    Value := TStringList_IndexStr(String(Args.Values[0]), TStringList(V2O(Args.Values[1]))) <> -1;
end;

procedure JvInterpreter_MatchText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := False;
  if VarIsArray(Args.Values[1]) then
    Value := MatchText(String(Args.Values[0]), System.TArray<string>(Args.Values[1]))
  else if ObjectArgument(Args.Values[1], TObject, 1) is TStringList then
    Value := TStringList(V2O(Args.Values[1])).IndexOf(String(Args.Values[0])) <> -1;
end;

procedure JvInterpreter_MidStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := MidStr(String(Args.Values[0]), Integer(Args.Values[1]), Integer(Args.Values[2]));
end;

procedure JvInterpreter_ReverseString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ReverseString(String(Args.Values[0]));
end;

procedure JvInterpreter_RightStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := RightStr(String(Args.Values[0]), Integer(Args.Values[1]));
end;

procedure JvInterpreter_StartsStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StartsStr(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_StartsText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StartsText(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_SplitString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SplitString(String(Args.Values[0]), String(Args.Values[1]));
end;

procedure JvInterpreter_StuffString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StuffString(String(Args.Values[0]), Cardinal(Args.Values[1]), Cardinal(Args.Values[2]), String(Args.Values[3]));
end;

{ Variants }

procedure JvInterpreter_VarType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := VarType(Variant(Args.Values[0]));
end;

procedure JvInterpreter_VarTypeAsText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := VarTypeAsText(VarType(Variant(Args.Values[0])));
end;

{ Missing code }

procedure JvInterpreter_Inc(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Inc(Args.Values[0]);
end;

procedure JvInterpreter_Dec(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Dec(Args.Values[0]);
end;

procedure JvInterpreter_Succ(var Value: Variant; Args: TJvInterpreterArgs);
begin
  // in JvInterpreter all ordinals are integers
  Value := Succ(Integer(Args.Values[0]));
end;

procedure JvInterpreter_Pred(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Pred(Integer(Args.Values[0]));
end;

procedure JvInterpreter_Frac(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Single(Frac(Args.Values[0]));
end;

procedure JvInterpreter_Int(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Single(Int(Args.Values[0]));
end;

{ TEncoding }

procedure TEncoding_Default(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TEncoding.Default);
end;

procedure TEncoding_ASCII(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TEncoding.ASCII);
end;

procedure TEncoding_Unicode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TEncoding.Unicode);
end;

procedure TEncoding_UTF8(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TEncoding.UTF8);
end;

{ Math: System.Math }

procedure JvInterpreter_CompareValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CompareValue(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure JvInterpreter_EnsureRange(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := EnsureRange(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure JvInterpreter_FMod(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FMod(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_GetPrecisionMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := GetPrecisionMode();
end;

procedure JvInterpreter_GetRoundMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := GetRoundMode();
end;

procedure JvInterpreter_InRange(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := InRange(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure JvInterpreter_IsZero(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IsZero(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_Lerp(var Value: Variant; Args: TJvInterpreterArgs);
begin
  var a := Args.Values[0];
  var b := Args.Values[1];
  var t := Args.Values[2];

  Value := a + (b - a) * EnsureRange(t, 0.000000, 1.000000);
end;

procedure JvInterpreter_LerpInverse(var Value: Variant; Args: TJvInterpreterArgs);
begin
  var a := Args.Values[0];
  var b := Args.Values[1];
  var v := Args.Values[2];

  if SameValue(a, b) then
    Value := 0.000000
  else begin
    var x := v - a;
    var y := b - a;
    Value := EnsureRange(x / y, 0.000000, 1.000000);
  end;
end;

procedure JvInterpreter_LerpUnclamped(var Value: Variant; Args: TJvInterpreterArgs);
begin
  var a := Args.Values[0];
  var b := Args.Values[1];
  var t := Args.Values[2];

  Value := a + (b - a) * t;
end;

procedure JvInterpreter_RoundTo(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := RoundTo(Args.Values[0], TRoundToEXRangeExtended(Args.Values[1]));
end;

procedure JvInterpreter_SameValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SameValue(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_SetPrecisionMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SetPrecisionMode(TFPUPrecisionMode(Args.Values[0]));
end;

procedure JvInterpreter_SetRoundMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SetRoundMode(TRoundingMode(Args.Values[0]));
end;

procedure JvInterpreter_Sign(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Sign(Args.Values[0]);
end;

procedure JvInterpreter_SimpleRoundTo(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SimpleRoundTo(Args.Values[0], TRoundToEXRangeExtended(Args.Values[1]));
end;

{ TStrings }

procedure TStrings_Read_Delimiter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).Delimiter;
end;

procedure TStrings_Write_Delimiter(const Value: Variant; Args: TJvInterpreterArgs);
begin
  if length(string(Value)) > 0 then
    TStrings(Args.Obj).Delimiter := string(Value)[1];
end;

procedure TStrings_Write_StrictDelimiter(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).StrictDelimiter := Value;
end;

procedure TStrings_Write_NameValueSeparator(const Value: Variant; Args: TJvInterpreterArgs);
begin
  if Length(String(Value)) > 0 then
    TStrings(Args.Obj).NameValueSeparator := String(Value)[1];
end;

procedure TStrings_Read_DelimitedText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).DelimitedText;
end;

procedure TStrings_Write_DelimitedText(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).DelimitedText := Value;
end;

procedure TStrings_Read_ValueFromIndex(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).ValueFromIndex[Args.Values[0]];
end;

procedure TStrings_Write_ValueFromIndex(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).ValueFromIndex[Args.Values[0]] := Value;
end;

{ TStringList }

procedure StringSetOp_Difference(const aSetListA: TStringList; const aSetListB: TStringList; const aLH: TStringList);
begin
  for var i := 0 to Pred(aSetListA.Count) do
    if aSetListB.IndexOf(aSetListA[i]) = -1 then
      aLH.Append(aSetListA[i]);
end;

procedure StringSetOp_Intersection(const aSetListA: TStringList; const aSetListB: TStringList; const aLH: TStringList);
begin
  for var i := 0 to Pred(aSetListA.Count) do
    if aSetListB.IndexOf(aSetListA[i]) > -1 then
      aLH.Append(aSetListA[i]);
end;

procedure StringSetOp_SymmetricDifference(const aSetListA: TStringList; const aSetListB: TStringList; const aLH: TStringList);
begin
  aLH.AddStrings(aSetListA);
  aLH.AddStrings(aSetListB);

  var Intersection: TStringList := TStringList.Create;

  for var i := 0 to Pred(aSetListA.Count) do
    if aSetListB.IndexOf(aSetListA[i]) > -1 then
      Intersection.Append(aSetListA[i]);

  for var i := 0 to Pred(Intersection.Count) do
  begin
    var j := aLH.IndexOf(Intersection[i]);
    if j > -1 then
      aLH.Delete(j);
  end;

  Intersection.Free;
end;

procedure StringSetOp_Union(const aSetListA: TStringList; const aSetListB: TStringList; const aLH: TStringList);
begin
  aLH.AddStrings(aSetListA);
  aLH.AddStrings(aSetListB);
end;

type
   TSetOperation = (D, I, S, U);

procedure StringSetOp(const aOperation: TSetOperation; const aLH: TStringList; const aRH: TStringList);
begin
  { Executes set operations on TStringList objects and modifies aListA in-place }

  aLH.Duplicates := dupIgnore;
  aLH.Sorted := True;

  var SetListA: TStringList := TStringList.Create;
  SetListA.Duplicates := dupIgnore;
  SetListA.Sorted := True;
  SetListA.AddStrings(aLH);

  var SetListB: TStringList := TStringList.Create;
  SetListB.Duplicates := dupIgnore;
  SetListB.Sorted := True;
  SetListB.AddStrings(aRH);

  aLH.Clear;

  case aOperation of
    D : StringSetOp_Difference(SetListA, SetListB, aLH);
    I : StringSetOp_Intersection(SetListA, SetListB, aLH);
    S : StringSetOp_SymmetricDifference(SetListA, SetListB, aLH);
    U : StringSetOp_Union(SetListA, SetListB, aLH);
  end;

  SetListA.Free;
  SetListB.Free;
end;

procedure TStringList_Read_CaseSensitive(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStringList(Args.Obj).CaseSensitive;
end;

procedure TStringList_Write_CaseSensitive(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStringList(Args.Obj).CaseSensitive := Value;
end;

procedure TStringList_Difference(var Value: Variant; Args: TJvInterpreterArgs);
begin
  StringSetOp(TSetOperation.D, TStringList(Args.Obj), TStringList(ObjectArgument(Args.Values[0], TStrings, 0)));
end;

procedure TStringList_Intersection(var Value: Variant; Args: TJvInterpreterArgs);
begin
  StringSetOp(TSetOperation.I, TStringList(Args.Obj), TStringList(ObjectArgument(Args.Values[0], TStrings, 0)));
end;

procedure TStringList_SymmetricDifference(var Value: Variant; Args: TJvInterpreterArgs);
begin
  StringSetOp(TSetOperation.S, TStringList(Args.Obj), TStringList(ObjectArgument(Args.Values[0], TStrings, 0)));
end;

procedure TStringList_Union(var Value: Variant; Args: TJvInterpreterArgs);
begin
  StringSetOp(TSetOperation.U, TStringList(Args.Obj), TStringList(ObjectArgument(Args.Values[0], TStrings, 0)));
end;

procedure TStrings_AddPair(var Value: Variant; Args: TJvInterpreterArgs);
var
  Strings: TStrings;
  Name, Val: string;
begin
  Strings := TStrings(Args.Obj);
  Name := string(Args.Values[0]);
  Val := string(Args.Values[1]);

  if Args.Count = 3 then
    Strings.AddPair(Name, Val, TObject(V2O(Args.Values[2])))
  else
    Strings.AddPair(Name, Val);

  Value := O2V(Strings);  // Return TStrings for method chaining
end;

procedure TStrings_Contains(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).Contains(string(Args.Values[0]));
end;

procedure TStrings_ContainsName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).ContainsName(string(Args.Values[0]));
end;

procedure TStrings_ContainsObject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).ContainsObject(TObject(V2O(Args.Values[0])));
end;

procedure TStrings_InsertObject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).InsertObject(Args.Values[0], string(Args.Values[1]), TObject(V2O(Args.Values[2])));
end;

procedure TStrings_LoadFromFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Args.Count = 2 then
    TStrings(Args.Obj).LoadFromFile(string(Args.Values[0]), TEncoding(ObjectArgument(Args.Values[1], TEncoding, 1)))
  else
    TStrings(Args.Obj).LoadFromFile(string(Args.Values[0]));
end;

procedure TStrings_SaveToFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Args.Count = 2 then
    TStrings(Args.Obj).SaveToFile(string(Args.Values[0]), TEncoding(ObjectArgument(Args.Values[1], TEncoding, 1)))
  else
    TStrings(Args.Obj).SaveToFile(string(Args.Values[0]));
end;

procedure TStrings_SetStrings(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).SetStrings(TStrings(ObjectArgument(Args.Values[0], TStrings, 0)));
end;

procedure JvInterpreter_SameText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SameText(string(Args.Values[0]), string(Args.Values[1]));
end;

procedure JvInterpreter_StringReplace(var Value: Variant; Args: TJvInterpreterArgs);
var
  rf: TReplaceFlags;
  f: byte;
begin
  f := V2S(Args.Values[3]);
  if (f and (1 shl ord(rfReplaceAll))) > 0 then rf := rf + [rfReplaceAll];
  if (f and (1 shl ord(rfIgnoreCase))) > 0 then rf := rf + [rfIgnoreCase];
  Value := StringReplace(Args.Values[0], Args.Values[1], Args.Values[2], rf);
end;

procedure JvInterpreter_IntToHex64(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IntToHex64(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_StrToInt64(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToInt64(Args.Values[0]);
end;

procedure JvInterpreter_StrToInt64Def(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToInt64Def(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_StrToFloatDef(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToFloatDef(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_DirectoryExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := System.SysUtils.DirectoryExists(Args.Values[0]);
end;

procedure JvInterpreter_FileExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileExists(Args.Values[0]);
end;

procedure JvInterpreter_ForceDirectories(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := System.SysUtils.ForceDirectories(Args.Values[0]);
end;

procedure JvInterpreter_IncludeTrailingBackslash(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IncludeTrailingBackslash(Args.Values[0]);
end;

procedure JvInterpreter_ExcludeTrailingBackslash(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExcludeTrailingBackslash(Args.Values[0]);
end;

procedure JvInterpreter_CopyFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CopyFile(PWideChar(String(Args.Values[0])), PWideChar(String(Args.Values[1])), Args.Values[2]);
end;

procedure JvInterpreter_StringOfChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Length(String(Args.Values[0])) > 0 then
    Value := StringOfChar(String(Args.Values[0])[1], Integer(Args.Values[1]));
end;

procedure JvInterpreter_ShellExecute(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ShellExecute(
    Args.Values[0],
    PWideChar(String(Args.Values[1])),
    PWideChar(String(Args.Values[2])),
    PWideChar(String(Args.Values[3])),
    PWideChar(String(Args.Values[4])),
    Args.Values[5]
  );
end;

// parent window, verb, file, params, dir, show window
procedure JvInterpreter_ShellExecuteWait(var Value: Variant; Args: TJvInterpreterArgs);
var
  SEInfo: TShellExecuteInfo;
  ExitCode: Cardinal;
begin
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  with SEInfo do begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Args.Values[0];
    lpVerb := PWideChar(String(Args.Values[1]));
    lpFile := PWideChar(String(Args.Values[2]));
    lpParameters := PWideChar(String(Args.Values[3]));
    lpDirectory := PWideChar(String(Args.Values[4]));
    nShow := Args.Values[5];
  end;
  if ShellExecuteEx(@SEInfo) then begin
    WaitforSingleObject(SEInfo.hProcess, INFINITE);
    GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    Value := ExitCode;
  end else
    raise Exception.Create('ShellExecute failed, error code ' + IntToStr(GetLastError));
end;

// file, params, show window, timeout
procedure JvInterpreter_CreateProcessWait(var Value: Variant; Args: TJvInterpreterArgs);
var
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  ExitCode: Cardinal;
begin
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := Args.Values[2];
  end;

  if CreateProcess(
    PWideChar(String(Args.Values[0])),
    PWideChar(String(Args.Values[1])),
    nil, nil, False, NORMAL_PRIORITY_CLASS,
    nil,
    nil,
    StartUpInfo, ProcessInfo)
  then begin
    WaitforSingleObject(ProcessInfo.hProcess, Cardinal(Args.Values[3]));
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
    Value := ExitCode;
  end else
    raise Exception.Create('CreateProcess failed, error code ' + IntToStr(GetLastError));
end;

procedure JvInterpreter_Sleep(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Sleep(Cardinal(Args.Values[0]));
end;

procedure JvInterpreter_GetKeyState(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := GetKeyState(Args.Values[0]);
end;

procedure JvInterpreter_SelectDirectory(var Value: Variant; Args: TJvInterpreterArgs);
var
  aDir: string;
begin
  Value := '';
  aDir := String(Args.Values[2]);
  if SelectDirectory(String(Args.Values[0]), String(Args.Values[1]), aDir, [], TWinControl(ObjectArgument(Args.Values[3], TWinControl, 3))) then
    Value := aDir;
end;

{ Registration }

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    AddConst('System', 'varEmpty', Ord(varEmpty));
    AddConst('System', 'varNull', Ord(varNull));
    AddConst('System', 'varSmallInt', Ord(varSmallInt));
    AddConst('System', 'varInteger', Ord(varInteger));
    AddConst('System', 'varSingle', Ord(varSingle));
    AddConst('System', 'varDouble', Ord(varDouble));
    AddConst('System', 'varCurrency', Ord(varCurrency));
    AddConst('System', 'varDate', Ord(varDate));
    AddConst('System', 'varOleStr', Ord(varOleStr));
    AddConst('System', 'varDispatch', Ord(varDispatch));
    AddConst('System', 'varError', Ord(varError));
    AddConst('System', 'varBoolean', Ord(varBoolean));
    AddConst('System', 'varVariant', Ord(varVariant));
    AddConst('System', 'varUnknown', Ord(varUnknown));
    AddConst('System', 'varShortInt', Ord(varShortInt));
    AddConst('System', 'varByte', Ord(varByte));
    AddConst('System', 'varWord', Ord(varWord));
    AddConst('System', 'varLongWord', Ord(varLongWord));
    AddConst('System', 'varInt64', Ord(varInt64));
    AddConst('System', 'varUInt64', Ord(varUInt64));
    AddConst('System', 'varStrArg', Ord(varStrArg));
    AddConst('System', 'varString', Ord(varString));
    AddConst('System', 'varAny', Ord(varAny));
    AddConst('System', 'varUString', Ord(varUString));
    AddConst('System', 'varTypeMask', Ord(varTypeMask));
    AddConst('System', 'varByRef', Ord(varByRef));
    AddConst('System', 'MaxInt', Ord(MaxInt));
    AddConst('System', 'MinInt', Low(Integer));
    AddConst('Math', 'NegativeValue', Ord(NegativeValue));
    AddConst('Math', 'pmDouble', Ord(pmDouble));
    AddConst('Math', 'pmExtended', Ord(pmExtended));
    AddConst('Math', 'pmReserved', Ord(pmReserved));
    AddConst('Math', 'pmSingle', Ord(pmSingle));
    AddConst('Math', 'PositiveValue', Ord(PositiveValue));
    AddConst('Math', 'rmDown', Ord(rmDown));
    AddConst('Math', 'rmNearest', Ord(rmNearest));
    AddConst('Math', 'rmTruncate', Ord(rmTruncate));
    AddConst('Math', 'rmUp', Ord(rmUp));
    AddConst('Math', 'ZeroValue', Ord(ZeroValue));
    AddConst('Types', 'EqualsValue', Ord(EqualsValue));
    AddConst('Types', 'GreaterThanValue', Ord(GreaterThanValue));
    AddConst('Types', 'LessThanValue', Ord(LessThanValue));
    AddConst('SysUtils', 'rfReplaceAll', Ord(rfReplaceAll));
    AddConst('SysUtils', 'rfIgnoreCase', Ord(rfIgnoreCase));
    AddConst('SysUtils', 'fmCreate', Ord(fmCreate));
    AddConst('SysUtils', 'LowInteger', Low(Integer));
    AddConst('SysUtils', 'HighInteger', High(Integer));
    AddConst('ExtCtrls', 'lpAbove', Ord(lpAbove));
    AddConst('ExtCtrls', 'lpBelow', Ord(lpBelow));
    AddConst('ExtCtrls', 'lpLeft', Ord(lpLeft));
    AddConst('ExtCtrls', 'lpRight', Ord(lpRight));
    AddConst('StdCtrls', 'cbChecked', Ord(cbChecked));
    AddConst('StdCtrls', 'cbUnchecked', Ord(cbUnchecked));
    AddConst('StdCtrls', 'cbGrayed', Ord(cbGrayed));
    AddConst('Forms', 'poMainFormCenter', Ord(poMainFormCenter));
    AddConst('Forms', 'pmAuto', Ord(pmAuto));
    AddConst('Forms', 'pmExplicit', Ord(pmExplicit));
    AddConst('Forms', 'pmNone', Ord(pmNone));
    AddConst('Menus', 'maAutomatic', Ord(maAutomatic));
    AddConst('Menus', 'maManual', Ord(maManual));
    AddConst('Controls', 'akLeft', Ord(akLeft));
    AddConst('Controls', 'akRight', Ord(akRight));
    AddConst('Controls', 'akTop', Ord(akTop));
    AddConst('Controls', 'akBottom', Ord(akBottom));
    AddConst('Windows', 'SW_HIDE', Ord(SW_HIDE));
    AddConst('Windows', 'SW_MAXIMIZE', Ord(SW_MAXIMIZE));
    AddConst('Windows', 'SW_MINIMIZE', Ord(SW_MINIMIZE));
    AddConst('Windows', 'SW_RESTORE', Ord(SW_RESTORE));
    AddConst('Windows', 'SW_SHOW', Ord(SW_SHOW));
    AddConst('Windows', 'SW_SHOWDEFAULT', Ord(SW_SHOWDEFAULT));
    AddConst('Windows', 'SW_SHOWMAXIMIZED', Ord(SW_SHOWMAXIMIZED));
    AddConst('Windows', 'SW_SHOWMINIMIZED', Ord(SW_SHOWMINIMIZED));
    AddConst('Windows', 'SW_SHOWMINNOACTIVE', Ord(SW_SHOWMINNOACTIVE));
    AddConst('Windows', 'SW_SHOWNA', Ord(SW_SHOWNA));
    AddConst('Windows', 'SW_SHOWNOACTIVATE', Ord(SW_SHOWNOACTIVATE));
    AddConst('Windows', 'SW_SHOWNORMAL', Ord(SW_SHOWNORMAL));

    { Clipboard }
    AddFunction('Vcl.Clipbrd', 'GetClipboardText', JvInterpreter_Clipboard_GetAsText, 0, [varEmpty], varEmpty);
    AddFunction('Vcl.Clipbrd', 'SetClipboardText', JvInterpreter_Clipboard_SetAsText, 1, [varString], varEmpty);

    { StrUtils }
    AddFunction('StrUtils', 'ContainsStr', JvInterpreter_ContainsStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'ContainsText', JvInterpreter_ContainsText, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'DupeString', JvInterpreter_DupeString, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'EndsStr', JvInterpreter_EndsStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'EndsText', JvInterpreter_EndsText, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'IfThen', JvInterpreter_IfThen, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'IndexStr', JvInterpreter_IndexStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'IndexText', JvInterpreter_IndexText, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'LeftStr', JvInterpreter_LeftStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'MatchStr', JvInterpreter_MatchStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'MatchText', JvInterpreter_MatchText, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'MidStr', JvInterpreter_MidStr, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'ReverseString', JvInterpreter_ReverseString, 1, [varEmpty], varEmpty);
    AddFunction('StrUtils', 'RightStr', JvInterpreter_RightStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'StartsStr', JvInterpreter_StartsStr, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'StartsText', JvInterpreter_StartsText, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'SplitString', JvInterpreter_SplitString, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('StrUtils', 'StuffString', JvInterpreter_StuffString, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);

    { Variants }
    AddFunction('Variants', 'VarType', JvInterpreter_VarType, 1, [varEmpty], varEmpty);
    AddFunction('Variants', 'VarTypeAsText', JvInterpreter_VarTypeAsText, 1, [varEmpty], varEmpty);

    { SysUtils }
    AddFunction('SysUtils', 'Inc', JvInterpreter_Inc, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'Dec', JvInterpreter_Dec, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'Succ', JvInterpreter_Succ, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Pred', JvInterpreter_Pred, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Frac', JvInterpreter_Frac, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Int', JvInterpreter_Int, 1, [varEmpty], varEmpty);

    AddFunction('SysUtils', 'SameText', JvInterpreter_SameText, 2, [varString, varString], varEmpty);
    AddFunction('SysUtils', 'SameValue', JvInterpreter_SameValue, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'StringReplace', JvInterpreter_StringReplace, 4, [varString, varString, varString, varEmpty], varEmpty);
    AddFunction('SysUtils', 'IntToHex64', JvInterpreter_IntToHex64, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToInt64', JvInterpreter_StrToInt64, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToInt64Def', JvInterpreter_StrToInt64Def, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToFloatDef', JvInterpreter_StrToFloatDef, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'DirectoryExists', JvInterpreter_DirectoryExists, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'FileExists', JvInterpreter_FileExists, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'ForceDirectories', JvInterpreter_ForceDirectories, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'IncludeTrailingBackslash', JvInterpreter_IncludeTrailingBackslash, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'ExcludeTrailingBackslash', JvInterpreter_ExcludeTrailingBackslash, 1, [varEmpty], varEmpty);
    AddFunction('System', 'StringOfChar', JvInterpreter_StringOfChar, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Windows', 'CopyFile', JvInterpreter_CopyFile, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('ShellApi', 'ShellExecute', JvInterpreter_ShellExecute, 6, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('ShellApi', 'ShellExecuteWait', JvInterpreter_ShellExecuteWait, 6, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Windows', 'CreateProcessWait', JvInterpreter_CreateProcessWait, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Windows', 'Sleep', JvInterpreter_Sleep, 1, [varEmpty], varEmpty);
    AddFunction('Windows', 'GetKeyState', JvInterpreter_GetKeyState, 1, [varEmpty], varEmpty);
    AddFunction('FileCtrl', 'SelectDirectory', JvInterpreter_SelectDirectory, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);

    { TEncoding }
    AddClass('SysUtils', TEncoding, 'TEncoding');
    AddGet(TEncoding, 'Default', TEncoding_Default, 0, [varEmpty], varEmpty);
    AddGet(TEncoding, 'ASCII', TEncoding_ASCII, 0, [varEmpty], varEmpty);
    AddGet(TEncoding, 'Unicode', TEncoding_Unicode, 0, [varEmpty], varEmpty);
    AddGet(TEncoding, 'UTF8', TEncoding_UTF8, 0, [varEmpty], varEmpty);

    { Math: System.Math }
    AddFunction('Math', 'CompareValue', JvInterpreter_CompareValue, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'EnsureRange', JvInterpreter_EnsureRange, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'FMod', JvInterpreter_FMod, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'GetPrecisionMode', JvInterpreter_GetPrecisionMode, 0, [varEmpty], varEmpty);
    AddFunction('Math', 'GetRoundMode', JvInterpreter_GetRoundMode, 0, [varEmpty], varEmpty);
    AddFunction('Math', 'InRange', JvInterpreter_InRange, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'IsZero', JvInterpreter_IsZero, 1, [varEmpty], varEmpty);
    AddFunction('Math', 'InverseLerp', JvInterpreter_LerpInverse, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'Lerp', JvInterpreter_Lerp, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'LerpUnclamped', JvInterpreter_LerpUnclamped, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'RoundTo', JvInterpreter_RoundTo, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'SetPrecisionMode', JvInterpreter_SetPrecisionMode, 1, [varEmpty], varEmpty);
    AddFunction('Math', 'SetRoundMode', JvInterpreter_SetRoundMode, 1, [varEmpty], varEmpty);
    AddFunction('Math', 'Sign', JvInterpreter_Sign, 1, [varEmpty], varEmpty);
    AddFunction('Math', 'SimpleRoundTo', JvInterpreter_SimpleRoundTo, 2, [varEmpty, varEmpty], varEmpty);

    { TStrings }
    AddGet(TStrings, 'Delimiter', TStrings_Read_Delimiter, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'Delimiter', TStrings_Write_Delimiter, 0, [varEmpty]);
    AddSet(TStrings, 'StrictDelimiter', TStrings_Write_StrictDelimiter, 0, [varEmpty]);
    AddSet(TStrings, 'NameValueSeparator', TStrings_Write_NameValueSeparator, 0, [varEmpty]);
    AddGet(TStrings, 'DelimitedText', TStrings_Read_DelimitedText, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'DelimitedText', TStrings_Write_DelimitedText, 0, [varEmpty]);
    AddIGet(TStrings, 'ValueFromIndex', TStrings_Read_ValueFromIndex, 1, [varEmpty], varEmpty);
    AddISet(TStrings, 'ValueFromIndex', TStrings_Write_ValueFromIndex, 1, [varNull]);

    { TStringList }
    AddGet(TStrings, 'CaseSensitive', TStringList_Read_CaseSensitive, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'CaseSensitive', TStringList_Write_CaseSensitive, 0, [varEmpty]);
    AddGet(TStrings, 'AddPair', TStrings_AddPair, 2, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TStrings, 'Contains', TStrings_Contains, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'ContainsName', TStrings_ContainsName, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'ContainsObject', TStrings_ContainsObject, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'InsertObject', TStrings_InsertObject, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TStrings, 'LoadFromFile', TStrings_LoadFromFile, 1, [varEmpty, varEmpty], varEmpty);
    AddGet(TStrings, 'SaveToFile', TStrings_SaveToFile, 1, [varEmpty, varEmpty], varEmpty);
    AddGet(TStrings, 'SetStrings', TStrings_SetStrings, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'Difference', TStringList_Difference, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'Intersection', TStringList_Intersection, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'SymmetricDifference', TStringList_SymmetricDifference, 1, [varEmpty], varEmpty);
    AddGet(TStrings, 'Union', TStringList_Union, 1, [varEmpty], varEmpty);
  end;

  xejviScriptAdapterMiscVcl.RegisterJvInterpreterAdapter(JvInterpreterAdapter);
  xejviScriptAdapterMiscRegEx.RegisterJvInterpreterAdapter(JvInterpreterAdapter);
  xejviScriptAdapterMiscJson.RegisterJvInterpreterAdapter(JvInterpreterAdapter);
end;

end.
