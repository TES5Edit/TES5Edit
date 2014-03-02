unit wbScriptAdapterMisc;

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  Windows,
  Graphics,
  Classes,
  SysUtils,
  Variants,
  Controls,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
  Forms,
  Menus,
  CheckLst,
  ShellApi,
  FileCtrl,
  IniFiles,
  Registry,
  Math,
  RegularExpressionsCore,
  wbInterface;


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
  Value := Extended(Frac(Args.Values[0]));
end;

procedure JvInterpreter_Int(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Extended(Int(Args.Values[0]));
end;

procedure JvInterpreter_Floor(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Floor(Extended(Args.Values[0]));
end;

procedure JvInterpreter_Ceil(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Ceil(Extended(Args.Values[0]));
end;

{ Math }

procedure JvInterpreter_Max(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Max(Integer(Args.Values[0]), Integer(Args.Values[1]));
end;

procedure JvInterpreter_Min(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Min(Integer(Args.Values[0]), Integer(Args.Values[1]));
end;

procedure JvInterpreter_IntPower(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Extended(Math.IntPower(Extended(Args.Values[0]), Integer(Args.Values[1])));
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

procedure TStringList_Read_CaseSensitive(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStringList(Args.Obj).CaseSensitive;
end;

procedure TStringList_Write_CaseSensitive(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStringList(Args.Obj).CaseSensitive := Value;
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
  Value := DirectoryExists(Args.Values[0]);
end;

procedure JvInterpreter_FileExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FileExists(Args.Values[0]);
end;

procedure JvInterpreter_ForceDirectories(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ForceDirectories(Args.Values[0]);
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

procedure JvInterpreter_SelectDirectory(var Value: Variant; Args: TJvInterpreterArgs);
var
  aDir: string;
begin
  Value := '';
  aDir := String(Args.Values[2]);
  if SelectDirectory(String(Args.Values[0]), String(Args.Values[1]), aDir, [], TWinControl(V2O(Args.Values[3]))) then
    Value := aDir;
end;


{ TBytesStream }

procedure TBytesStream_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TBytesStream.Create(TBytes(Args.Values[0])));
end;



{ TBinaryReader }

procedure TBinaryReader_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TBinaryReader.Create(TFileStream(V2O(Args.Values[0]))));
end;

procedure TBinaryReader_Read(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).Read;
end;

procedure TBinaryReader_ReadBoolean(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadBoolean;
end;

procedure TBinaryReader_ReadByte(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadByte;
end;

procedure TBinaryReader_ReadBytes(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadBytes(Args.Values[0]);
end;

procedure TBinaryReader_ReadChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadChar;
end;

procedure TBinaryReader_ReadDouble(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadDouble;
end;

procedure TBinaryReader_ReadShortInt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadShortInt;
end;

procedure TBinaryReader_ReadSmallInt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadSmallInt;
end;

procedure TBinaryReader_ReadUInt16(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadUInt16;
end;

procedure TBinaryReader_ReadUInt32(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadUInt32;
end;

procedure TBinaryReader_ReadInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadInteger;
end;

procedure TBinaryReader_ReadSingle(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadSingle;
end;

procedure TBinaryReader_ReadString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadString;
end;


{ TBinaryWriter }

procedure TBinaryWriter_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TBinaryWriter.Create(TFileStream(V2O(Args.Values[0]))));
end;

procedure TBinaryWriter_Write(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case VarType(Args.Values[0]) of
    varByte:
      TBinaryWriter(Args.Obj).Write(Byte(Args.Values[0]));
    System.varArray:
      TBinaryWriter(Args.Obj).Write(TBytes(Args.Values[0]));
    varInteger, varLongWord:
      TBinaryWriter(Args.Obj).Write(Integer(Args.Values[0]));
    varWord, varShortInt, varSmallInt:
      TBinaryWriter(Args.Obj).Write(ShortInt(Args.Values[0]));
    varSingle:
      TBinaryWriter(Args.Obj).Write(Single(Args.Values[0]));
    varDouble:
      TBinaryWriter(Args.Obj).Write(Double(Args.Values[0]));
    varString, varUString:
      TBinaryWriter(Args.Obj).Write(String(Args.Values[0]));
  end;
end;

procedure TBinaryWriter_WriteSingle(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TBinaryWriter(Args.Obj).Write(Single(Args.Values[0]));
end;


{ TWinControl }

procedure TWinControl_Read_DoubleBuffered(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TWinControl(Args.Obj).DoubleBuffered;
end;

procedure TWinControl_Write_DoubleBuffered(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TWinControl(Args.Obj).DoubleBuffered := Boolean(Value);
end;


{ TCheckListBox }

type
  TJvInterpreterCheckListBoxEvents = class(TJvInterpreterEvent)
  private
    procedure OnClickCheck(Sender: TObject);
  end;

procedure TJvInterpreterCheckListBoxEvents.OnClickCheck(Sender: TObject);
begin
  CallFunction(nil, [O2V(Sender)]);
end;

procedure TCheckListBox_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TCheckListBox.Create(V2O(Args.Values[0]) as TComponent));
end;

procedure TCheckListBox_CheckAll(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).CheckAll(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCheckListBox_Read_Checked(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).Checked[Args.Values[0]];
end;

procedure TCheckListBox_Write_Checked(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).Checked[Args.Values[0]] := Value;
end;

procedure TCheckListBox_Read_State(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).State[Args.Values[0]];
end;

procedure TCheckListBox_Write_State(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).State[Args.Values[0]] := Value;
end;

procedure TCheckListBox_Read_Header(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).Header[Args.Values[0]];
end;

procedure TCheckListBox_Write_Header(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).Header[Args.Values[0]] := Value;
end;

procedure TCheckListBox_Read_ItemEnabled(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).State[Args.Values[0]];
end;

procedure TCheckListBox_Write_ItemEnabled(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).State[Args.Values[0]] := Value;
end;

procedure TCheckListBox_Read_AllowGrayed(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).AllowGrayed;
end;

procedure TCheckListBox_Write_AllowGrayed(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).AllowGrayed := Value;
end;


{ TComboBox }

procedure TComboBox_Read_DropDownCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TComboBox(Args.Obj).DropDownCount;
end;

procedure TComboBox_Write_DropDownCount(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TComboBox(Args.Obj).DropDownCount := Value;
end;


{ TCustomLabeledEdit }

procedure TCustomLabeledEdit_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TCustomLabeledEdit.Create(V2O(Args.Values[0]) as TComponent));
end;

procedure TCustomLabeledEdit_Read_EditLabel(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TCustomLabeledEdit(Args.Obj).EditLabel);
end;

procedure TCustomLabeledEdit_Read_LabelPosition(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomLabeledEdit(Args.Obj).LabelPosition;
end;

procedure TCustomLabeledEdit_Write_LabelPosition(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomLabeledEdit(Args.Obj).LabelPosition := TLabelPosition(Value);
end;

procedure TCustomLabeledEdit_Read_LabelSpacing(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomLabeledEdit(Args.Obj).LabelSpacing;
end;

procedure TCustomLabeledEdit_Write_LabelSpacing(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomLabeledEdit(Args.Obj).LabelSpacing := Value;
end;


{ TLabeledEdit }

procedure TLabeledEdit_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TLabeledEdit.Create(V2O(Args.Values[0]) as TComponent));
end;


{ TListItem }

procedure TListItem_Read_SubItems(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TListItem(Args.Obj).SubItems);
end;

procedure TListItem_Write_SubItems(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TListItem(Args.Obj).SubItems := V2O(Value) as TStrings;
end;


{ TListItems }

procedure TListItems_Write_Count(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TListItems(Args.Obj).Count := Value;
end;


{ TListView }

type
  TJvInterpreterListViewEvents = class(TJvInterpreterEvent)
  private
    procedure OnData(Sender: TObject; Item: TListItem);
    procedure OnSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
  end;

procedure TJvInterpreterListViewEvents.OnData(Sender: TObject; Item: TListItem);
begin
  CallFunction(nil, [O2V(Sender), O2V(Item)]);
end;

procedure TJvInterpreterListViewEvents.OnSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  CallFunction(nil, [O2V(Sender), O2V(Item), Selected]);
end;


{ TMenu }

procedure TMenu_Read_AutoHotKeys(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Integer(TMenu(Args.Obj).AutoHotKeys);
end;

procedure TMenu_Write_AutoHotKeys(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TMenu(Args.Obj).AutoHotKeys := Value;
end;


{ TMenuItem }

procedure TMenuItem_Clear(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TMenuItem(Args.Obj).Clear;
end;


{ TBitmap }

procedure TBitmap_SetSize(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TBitmap(Args.Obj).SetSize(Args.Values[0], Args.Values[1]);
end;


{ THashedStringList }

procedure THashedStringList_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(THashedStringList.Create);
end;


{ TCustomIniFile }

procedure TCustomIniFile_ReadString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadString(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_ReadInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadInteger(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_ReadFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadFloat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_ReadBool(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadBool(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_WriteString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteString(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_WriteInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteInteger(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_WriteFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteFloat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_WriteBool(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteBool(Args.Values[0], Args.Values[1], Args.Values[2])
end;

procedure TCustomIniFile_DeleteKey(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).DeleteKey(Args.Values[0], Args.Values[1]);
end;

procedure TCustomIniFile_EraseSection(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).EraseSection(Args.Values[0]);
end;

procedure TCustomIniFile_SectionExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).SectionExists(Args.Values[0]);
end;

procedure TCustomIniFile_ValueExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ValueExists(Args.Values[0], Args.Values[1]);
end;

procedure TCustomIniFile_ReadSection(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).ReadSection(Args.Values[0], TStrings(V2O(Args.Values[1])));
end;

procedure TCustomIniFile_ReadSections(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).ReadSections(TStrings(V2O(Args.Values[0])));
end;

procedure TCustomIniFile_ReadSectionValues(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).ReadSectionValues(Args.Values[0], TStrings(V2O(Args.Values[1])));
end;

procedure TCustomIniFile_UpdateFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).UpdateFile;
end;


{ TIniFile }

procedure TIniFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TIniFile.Create(String(Args.Values[0])));
end;


{ TMemIniFile }

procedure TMemIniFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TMemIniFile.Create(String(Args.Values[0])));
end;

procedure TMemIniFile_GetStrings(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TMemIniFile(Args.Obj).GetStrings(TStrings(V2O(Args.Values[0])));
end;

procedure TMemIniFile_SetStrings(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TMemIniFile(Args.Obj).SetStrings(TStrings(V2O(Args.Values[0])));
end;


{ TRegistryIniFile }

procedure TRegistryIniFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TRegistryIniFile.Create(String(Args.Values[0])));
end;


{ TPerlRegEx }

procedure TPerlRegEx_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TPerlRegEx.Create);
end;

procedure TPerlRegEx_EscapeRegExChars(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).EscapeRegExChars(String(Args.Values[0]));
end;

procedure TPerlRegEx_Compile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Compile;
end;

procedure TPerlRegEx_Study(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Study;
end;

procedure TPerlRegEx_Match(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Match;
end;

procedure TPerlRegEx_MatchAgain(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).MatchAgain;
end;

procedure TPerlRegEx_Replace(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).Replace);
end;

procedure TPerlRegEx_ReplaceAll(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).ReplaceAll;
end;

procedure TPerlRegEx_ComputeReplacement(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).ComputeReplacement);
end;

procedure TPerlRegEx_StoreGroups(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).StoreGroups;
end;

procedure TPerlRegEx_NamedGroup(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).NamedGroup(String(Args.Values[0]));
end;

procedure TPerlRegEx_Split(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Split(TStrings(V2O(Args.Values[0])), Args.Values[1]);
end;

procedure TPerlRegEx_SplitCapture(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).SplitCapture(TStrings(V2O(Args.Values[0])), Args.Values[1]);
end;

procedure TPerlRegEx_FoundMatch(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).FoundMatch;
end;

procedure TPerlRegEx_MatchedText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).MatchedText);
end;

procedure TPerlRegEx_MatchedLength(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).MatchedLength;
end;

procedure TPerlRegEx_MatchedOffset(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).MatchedOffset;
end;

procedure TPerlRegEx_Read_Start(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Start;
end;

procedure TPerlRegEx_Write_Start(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Start := Value;
end;

procedure TPerlRegEx_Read_Stop(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Stop;
end;

procedure TPerlRegEx_Write_Stop(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Stop := Value;
end;

procedure TPerlRegEx_GroupCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).GroupCount;
end;

procedure TPerlRegEx_Read_Groups(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).Groups[Args.Values[0]]);
end;

procedure TPerlRegEx_Read_GroupLengths(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).GroupLengths[Args.Values[0]];
end;

procedure TPerlRegEx_Read_GroupOffsets(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).GroupOffsets[Args.Values[0]];
end;

procedure TPerlRegEx_Read_Subject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).Subject);
end;

procedure TPerlRegEx_Write_Subject(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Subject := String(Value);
end;

procedure TPerlRegEx_SubjectLeft(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).SubjectLeft);
end;

procedure TPerlRegEx_SubjectRight(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).SubjectRight);
end;

procedure TPerlRegEx_Read_Options(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := S2V(Byte(TPerlRegEx(Args.Obj).Options));
end;

procedure TPerlRegEx_Write_Options(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Options := TPerlRegExOptions(Byte(V2S(Value)));
end;

procedure TPerlRegEx_Read_RegEx(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).RegEx);
end;

procedure TPerlRegEx_Write_RegEx(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).RegEx := String(Value);
end;



procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
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

    AddFunction('SysUtils', 'Inc', JvInterpreter_Inc, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'Dec', JvInterpreter_Dec, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'Succ', JvInterpreter_Succ, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Pred', JvInterpreter_Pred, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Frac', JvInterpreter_Frac, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Int', JvInterpreter_Int, 1, [varEmpty], varEmpty);
    AddFunction('Math', 'Floor', JvInterpreter_Floor, 1, [varEmpty], varEmpty);
    AddFunction('Math', 'Ceil', JvInterpreter_Ceil, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'SameText', JvInterpreter_SameText, 2, [varString, varString], varEmpty);
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
    AddFunction('FileCtrl', 'SelectDirectory', JvInterpreter_SelectDirectory, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);

    { Math }
    AddFunction('Math', 'Max', JvInterpreter_Max, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'Min', JvInterpreter_Min, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Math', 'IntPower', JvInterpreter_IntPower, 2, [varEmpty,varEmpty], varEmpty);

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

    { THashedStringList }
    AddClass('IniFiles', THashedStringList, 'THashedStringList');
    AddGet(THashedStringList, 'Create', THashedStringList_Create, 0, [varEmpty], varEmpty);

    { TBytesStream }
    AddClass('Classes', TBytesStream, 'TBytesStream');
    AddGet(TBytesStream, 'Create', TBytesStream_Create, 1, [varEmpty], varEmpty);

    { TBinaryReader }
    AddClass('Classes', TBinaryReader, 'TBinaryReader');
    AddGet(TBinaryReader, 'Create', TBinaryReader_Create, 1, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'Read', TBinaryReader_Read, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadBoolean', TBinaryReader_ReadBoolean, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadByte', TBinaryReader_ReadByte, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadBytes', TBinaryReader_ReadBytes, 1, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadChar', TBinaryReader_ReadChar, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadDouble', TBinaryReader_ReadDouble, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadShortInt', TBinaryReader_ReadShortInt, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadSmallInt', TBinaryReader_ReadSmallInt, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadUInt16', TBinaryReader_ReadUInt16, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadUInt32', TBinaryReader_ReadUInt32, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadInteger', TBinaryReader_ReadInteger, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadSingle', TBinaryReader_ReadSingle, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadString', TBinaryReader_ReadString, 0, [varEmpty], varEmpty);

    { TBinaryWriter }
    AddClass('Classes', TBinaryWriter, 'TBinaryWriter');
    AddGet(TBinaryWriter, 'Create', TBinaryWriter_Create, 1, [varEmpty], varEmpty);
    AddGet(TBinaryWriter, 'Write', TBinaryWriter_Write, 1, [varEmpty], varEmpty);
    AddGet(TBinaryWriter, 'WriteSingle', TBinaryWriter_WriteSingle, 1, [varEmpty], varEmpty);

    { TWinControl }
    AddGet(TWinControl, 'DoubleBuffered', TWinControl_Read_DoubleBuffered, 0, [varEmpty], varEmpty);
    AddSet(TWinControl, 'DoubleBuffered', TWinControl_Write_DoubleBuffered, 0, [varEmpty]);

    { TCheckListBox }
    AddClass('CheckLst', TCheckListBox, 'TCheckListBox');
    AddGet(TCheckListBox, 'Create', TCheckListBox_Create, 1, [varEmpty], varEmpty);
    AddGet(TCheckListBox, 'CheckAll', TCheckListBox_CheckAll, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddIGet(TCheckListBox, 'Checked', TCheckListBox_Read_Checked, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'Checked', TCheckListBox_Write_Checked, 1, [varNull]);
    AddIGet(TCheckListBox, 'State', TCheckListBox_Read_State, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'State', TCheckListBox_Write_State, 1, [varNull]);
    AddIGet(TCheckListBox, 'Header', TCheckListBox_Read_Header, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'Header', TCheckListBox_Write_Header, 1, [varNull]);
    AddIGet(TCheckListBox, 'ItemEnabled', TCheckListBox_Read_ItemEnabled, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'ItemEnabled', TCheckListBox_Write_ItemEnabled, 1, [varNull]);
    AddGet(TCheckListBox, 'AllowGrayed', TCheckListBox_Read_AllowGrayed, 0, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'AllowGrayed', TCheckListBox_Write_AllowGrayed, 0, [varEmpty]);
    AddHandler('CheckLst', 'TNotifyEvent', TJvInterpreterCheckListBoxEvents, @TJvInterpreterCheckListBoxEvents.OnClickCheck);

   { TComboBox }
    AddGet(TComboBox, 'DropDownCount', TComboBox_Read_DropDownCount, 0, [varEmpty], varEmpty);
    AddSet(TComboBox, 'DropDownCount', TComboBox_Write_DropDownCount, 0, [varEmpty]);

    { TCustomLabeledEdit }
    AddClass('ExtCtrls', TCustomLabeledEdit, 'TCustomLabeledEdit');
    AddGet(TCustomLabeledEdit, 'Create', TCustomLabeledEdit_Create, 1, [varEmpty], varEmpty);
    AddGet(TCustomLabeledEdit, 'EditLabel', TCustomLabeledEdit_Read_EditLabel, 0, [varEmpty], varEmpty);
    AddGet(TCustomLabeledEdit, 'LabelPosition', TCustomLabeledEdit_Read_LabelPosition, 0, [varEmpty], varEmpty);
    AddSet(TCustomLabeledEdit, 'LabelPosition', TCustomLabeledEdit_Write_LabelPosition, 0, [varEmpty]);
    AddGet(TCustomLabeledEdit, 'LabelSpacing', TCustomLabeledEdit_Read_LabelSpacing, 0, [varEmpty], varEmpty);
    AddSet(TCustomLabeledEdit, 'LabelSpacing', TCustomLabeledEdit_Write_LabelSpacing, 0, [varEmpty]);

    { TLabeledEdit }
    AddClass('ExtCtrls', TLabeledEdit, 'TLabeledEdit');
    AddGet(TLabeledEdit, 'Create', TLabeledEdit_Create, 1, [varEmpty], varEmpty);

    { TBoundLabel }
    AddClass('ExtCtrls', TBoundLabel, 'TBoundLabel');

    { TListItem }
    AddGet(TListItem, 'SubItems', TListItem_Read_SubItems, 0, [varEmpty], varEmpty);
    AddSet(TListItem, 'SubItems', TListItem_Write_SubItems, 0, [varEmpty]);

    { TListItems }
    AddSet(TListItems, 'Count', TListItems_Write_Count, 0, [varEmpty]);

    { TListView }
    AddHandler('ComCtrls', 'TLVOwnerDataEvent', TJvInterpreterListViewEvents, @TJvInterpreterListViewEvents.OnData);
    AddHandler('ComCtrls', 'TLVSelectItemEvent', TJvInterpreterListViewEvents, @TJvInterpreterListViewEvents.OnSelectItem);

    { TMenu }
    AddGet(TMenu, 'AutoHotKeys', TMenu_Read_AutoHotKeys, 0, [varEmpty], varEmpty);
    AddSet(TMenu, 'AutoHotKeys', TMenu_Write_AutoHotKeys, 0, [varEmpty]);

    { TMenuItem }
    AddGet(TMenuItem, 'Clear', TMenuItem_Clear, 0, [varEmpty], varEmpty);

    { TBitmap }
    AddGet(TBitmap, 'SetSize', TBitmap_SetSize, 2, [varEmpty, varEmpty], varEmpty);

    { TCustomIniFile }
    AddClass('IniFiles', TCustomIniFile, 'TCustomIniFile');
    AddGet(TCustomIniFile, 'ReadString', TCustomIniFile_ReadString, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadInteger', TCustomIniFile_ReadInteger, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadFloat', TCustomIniFile_ReadFloat, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadBool', TCustomIniFile_ReadBool, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteString', TCustomIniFile_WriteString, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteInteger', TCustomIniFile_WriteInteger, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteFloat', TCustomIniFile_WriteFloat, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteBool', TCustomIniFile_WriteBool, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'DeleteKey', TCustomIniFile_DeleteKey, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'EraseSection', TCustomIniFile_EraseSection, 1, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'SectionExists', TCustomIniFile_SectionExists, 1, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ValueExists', TCustomIniFile_ValueExists, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadSection', TCustomIniFile_ReadSection, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadSections', TCustomIniFile_ReadSections, 1, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadSectionValues', TCustomIniFile_ReadSectionValues, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'UpdateFile', TCustomIniFile_UpdateFile, 0, [varEmpty], varEmpty);

    { TIniFile }
    AddClass('IniFiles', TIniFile, 'TIniFile');
    AddGet(TIniFile, 'Create', TIniFile_Create, 1, [varEmpty], varEmpty);

    { TMemIniFile }
    AddClass('IniFiles', TMemIniFile, 'TMemIniFile');
    AddGet(TMemIniFile, 'Create', TMemIniFile_Create, 1, [varEmpty], varEmpty);
    AddGet(TMemIniFile, 'GetStrings', TMemIniFile_GetStrings, 1, [varEmpty], varEmpty);
    AddGet(TMemIniFile, 'SetStrings', TMemIniFile_SetStrings, 1, [varEmpty], varEmpty);

    { TRegistryIniFile }
    AddClass('Registry', TRegistryIniFile, 'TRegistryIniFile');
    AddGet(TRegistryIniFile, 'Create', TRegistryIniFile_Create, 1, [varEmpty], varEmpty);

    { TPerlRegExOptions }
    AddConst('RegularExpressionsCore', 'preCaseLess', Ord(preCaseLess));
    AddConst('RegularExpressionsCore', 'preMultiLine', Ord(preMultiLine));
    AddConst('RegularExpressionsCore', 'preSingleLine', Ord(preSingleLine));
    AddConst('RegularExpressionsCore', 'preExtended', Ord(preExtended));
    AddConst('RegularExpressionsCore', 'preAnchored', Ord(preAnchored));
    AddConst('RegularExpressionsCore', 'preUnGreedy', Ord(preUnGreedy));
    AddConst('RegularExpressionsCore', 'preNoAutoCapture', Ord(preNoAutoCapture));

    { TPerlRegEx }
    AddClass('RegularExpressionsCore', TPerlRegEx, 'TPerlRegEx');
    AddGet(TPerlRegEx, 'Create', TPerlRegEx_Create, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'EscapeRegExChars', TPerlRegEx_EscapeRegExChars, 1, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Compile', TPerlRegEx_Compile, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Study', TPerlRegEx_Study, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Match', TPerlRegEx_Match, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchAgain', TPerlRegEx_MatchAgain, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Replace', TPerlRegEx_Replace, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'ReplaceAll', TPerlRegEx_ReplaceAll, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'ComputeReplacement', TPerlRegEx_ComputeReplacement, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'StoreGroups', TPerlRegEx_StoreGroups, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'NamedGroup', TPerlRegEx_NamedGroup, 1, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Split', TPerlRegEx_Split, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'SplitCapture', TPerlRegEx_SplitCapture, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'FoundMatch', TPerlRegEx_FoundMatch, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchedText', TPerlRegEx_MatchedText, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchedLength', TPerlRegEx_MatchedLength, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchedOffset', TPerlRegEx_MatchedOffset, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Start', TPerlRegEx_Read_Start, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Start', TPerlRegEx_Write_Start, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'Stop', TPerlRegEx_Read_Stop, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Stop', TPerlRegEx_Write_Stop, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'GroupCount', TPerlRegEx_GroupCount, 0, [varEmpty], varEmpty);
    AddIGet(TPerlRegEx, 'Groups', TPerlRegEx_Read_Groups, 1, [varEmpty], varEmpty);
    AddIGet(TPerlRegEx, 'GroupLengths', TPerlRegEx_Read_GroupLengths, 1, [varEmpty], varEmpty);
    AddIGet(TPerlRegEx, 'GroupOffsets', TPerlRegEx_Read_GroupOffsets, 1, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Subject', TPerlRegEx_Read_Subject, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Subject', TPerlRegEx_Write_Subject, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'SubjectLeft', TPerlRegEx_SubjectLeft, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'SubjectRight', TPerlRegEx_SubjectRight, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Options', TPerlRegEx_Read_Options, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Options', TPerlRegEx_Write_Options, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'RegEx', TPerlRegEx_Read_RegEx, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'RegEx', TPerlRegEx_Write_RegEx, 0, [varEmpty]);

  end;
end;

end.
