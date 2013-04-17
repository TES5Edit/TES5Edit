unit wbScriptAdapterMisc;

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  Windows,
  Classes,
  SysUtils,
  Variants,
  CheckLst,
  wbInterface;

{ Missing code }

procedure Pascal_Inc(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Inc(Args.Values[0]);
end;

procedure Pascal_Dec(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Dec(Args.Values[0]);
end;

procedure Pascal_Succ(var Value: Variant; Args: TJvInterpreterArgs);
begin
  // in JvInterpreter all ordinals are integers
  Value := Succ(Integer(Args.Values[0]));
end;

procedure Pascal_Pred(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Pred(Integer(Args.Values[0]));
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

procedure TStrings_Read_DelimitedText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).DelimitedText;
end;

procedure TStrings_Write_DelimitedText(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).DelimitedText := Value;
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

procedure JvInterpreter_CopyFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CopyFile(PWideChar(String(Args.Values[0])), PWideChar(String(Args.Values[1])), Args.Values[2]);
end;

procedure JvInterpreter_StringOfChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Length(String(Args.Values[0])) > 0 then
    Value := StringOfChar(String(Args.Values[0])[1], Integer(Args.Values[1]));
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

procedure TBinaryReader_ReadInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadInteger;
end;

procedure TBinaryReader_ReadSingle(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadSingle;
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

{ TCheckListBox }

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



procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    AddConst('SysUtils', 'rfReplaceAll', Ord(rfReplaceAll));
    AddConst('SysUtils', 'rfIgnoreCase', Ord(rfIgnoreCase));
    AddConst('SysUtils', 'fmCreate', Ord(fmCreate));
    AddConst('SysUtils', 'LowInteger', Low(Integer));
    AddConst('SysUtils', 'HighInteger', High(Integer));
    AddFunction('SysUtils', 'Inc', Pascal_Inc, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'Dec', Pascal_Dec, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'Succ', Pascal_Succ, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'Pred', Pascal_Pred, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'SameText', JvInterpreter_SameText, 2, [varString, varString], varEmpty);
    AddFunction('SysUtils', 'StringReplace', JvInterpreter_StringReplace, 4, [varString, varString, varString, varEmpty], varEmpty);
    AddFunction('SysUtils', 'IntToHex64', JvInterpreter_IntToHex64, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToInt64', JvInterpreter_StrToInt64, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToInt64Def', JvInterpreter_StrToInt64Def, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToFloatDef', JvInterpreter_StrToFloatDef, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'DirectoryExists', JvInterpreter_DirectoryExists, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'FileExists', JvInterpreter_FileExists, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'ForceDirectories', JvInterpreter_ForceDirectories, 1, [varEmpty], varEmpty);
    AddFunction('System', 'StringOfChar', JvInterpreter_StringOfChar, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Windows', 'CopyFile', JvInterpreter_CopyFile, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { TStrings }
    AddGet(TStrings, 'Delimiter', TStrings_Read_Delimiter, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'Delimiter', TStrings_Write_Delimiter, 0, [varEmpty]);
    AddSet(TStrings, 'StrictDelimiter', TStrings_Write_StrictDelimiter, 0, [varEmpty]);
    AddGet(TStrings, 'DelimitedText', TStrings_Read_DelimitedText, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'DelimitedText', TStrings_Write_DelimitedText, 0, [varEmpty]);

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
    AddGet(TBinaryReader, 'ReadInteger', TBinaryReader_ReadInteger, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadSingle', TBinaryReader_ReadSingle, 0, [varEmpty], varEmpty);

    { TBinaryWriter }
    AddClass('Classes', TBinaryWriter, 'TBinaryWriter');
    AddGet(TBinaryWriter, 'Create', TBinaryWriter_Create, 1, [varEmpty], varEmpty);
    AddGet(TBinaryWriter, 'Write', TBinaryWriter_Write, 1, [varEmpty], varEmpty);
    AddGet(TBinaryWriter, 'WriteSingle', TBinaryWriter_WriteSingle, 1, [varEmpty], varEmpty);

    { TCheckListBox }
    AddClass('StdCtrls', TCheckListBox, 'TCheckListBox');
    AddGet(TCheckListBox, 'Create', TCheckListBox_Create, 1, [varEmpty], varEmpty);
    AddGet(TCheckListBox, 'CheckAll', TCheckListBox_CheckAll, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCheckListBox, 'Checked', TCheckListBox_Read_Checked, 1, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'Checked', TCheckListBox_Write_Checked, 1, [varNull]);
    AddGet(TCheckListBox, 'State', TCheckListBox_Read_State, 1, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'State', TCheckListBox_Write_State, 1, [varNull]);
    AddGet(TCheckListBox, 'Header', TCheckListBox_Read_Header, 1, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'Header', TCheckListBox_Write_Header, 1, [varNull]);
    AddGet(TCheckListBox, 'ItemEnabled', TCheckListBox_Read_ItemEnabled, 1, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'ItemEnabled', TCheckListBox_Write_ItemEnabled, 1, [varNull]);
    AddGet(TCheckListBox, 'AllowGreyed', TCheckListBox_Read_AllowGrayed, 0, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'AllowGreyed', TCheckListBox_Write_AllowGrayed, 0, [varEmpty]);
  end;
end;

end.
