{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterMiscVcl;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.IniFiles,
  System.IOUtils,
  System.SysUtils,
  System.Variants,
  System.Win.Registry,

  Vcl.CheckLst,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Vcl.StdCtrls;

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

procedure TBinaryReader_ReadInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadInteger;
end;

procedure TBinaryReader_ReadShortInt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadShortInt;
end;

procedure TBinaryReader_ReadSingle(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadSingle;
end;

procedure TBinaryReader_ReadSmallInt(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadSmallInt;
end;

procedure TBinaryReader_ReadString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadString;
end;

procedure TBinaryReader_ReadUInt16(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadUInt16;
end;

procedure TBinaryReader_ReadUInt32(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TBinaryReader(Args.Obj).ReadUInt32;
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

{ TBitmap }

procedure TBitmap_SetSize(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TBitmap(Args.Obj).SetSize(Args.Values[0], Args.Values[1]);
end;

{ TBytesStream }

procedure TBytesStream_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TBytesStream.Create(TBytes(Args.Values[0])));
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

procedure TCheckListBox_Read_AllowGrayed(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).AllowGrayed;
end;

procedure TCheckListBox_Write_AllowGrayed(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).AllowGrayed := Value;
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

procedure TCheckListBox_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TCheckListBox.Create(V2O(Args.Values[0]) as TComponent));
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
  Value := TCheckListBox(Args.Obj).ItemEnabled[Args.Values[0]];
end;

procedure TCheckListBox_Write_ItemEnabled(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).ItemEnabled[Args.Values[0]] := Value;
end;

procedure TCheckListBox_Read_State(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCheckListBox(Args.Obj).State[Args.Values[0]];
end;

procedure TCheckListBox_Write_State(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCheckListBox(Args.Obj).State[Args.Values[0]] := Value;
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

{ TControl }

procedure TControl_ScaleValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case VarType(Args.Values[0]) of
    varInteger: Value := Args.Values[0] * (Screen.PixelsPerInch / Screen.DefaultPixelsPerInch);
  else
    JvInterpreterError(ieTypeMistmatch, -1);
  end;
end;

procedure TControl_Read_StyleElements(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := S2V(Byte(TControl(Args.Obj).StyleElements));
end;

procedure TControl_Write_StyleElements(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TControl(Args.Obj).StyleElements := TStyleElements(Byte(V2S(Value)));
end;

{ TCustomForm }

procedure TCustomForm_Read_PopupMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomForm(Args.Obj).PopupMode;
end;

procedure TCustomForm_Write_PopupMode(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomForm(Args.Obj).PopupMode := Value;
end;

procedure TCustomForm_Read_PopupParent(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TCustomForm(Args.Obj).PopupParent);
end;

procedure TCustomForm_Write_PopupParent(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomForm(Args.Obj).PopupParent := TCustomForm(V2O(Value));
end;

{ TCustomIniFile }

procedure TCustomIniFile_DeleteKey(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).DeleteKey(Args.Values[0], Args.Values[1]);
end;

procedure TCustomIniFile_EraseSection(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).EraseSection(Args.Values[0]);
end;

procedure TCustomIniFile_ReadBool(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadBool(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_ReadFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadFloat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_ReadInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadInteger(Args.Values[0], Args.Values[1], Args.Values[2]);
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

procedure TCustomIniFile_ReadString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ReadString(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_SectionExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).SectionExists(Args.Values[0]);
end;

procedure TCustomIniFile_UpdateFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).UpdateFile;
end;

procedure TCustomIniFile_ValueExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TCustomIniFile(Args.Obj).ValueExists(Args.Values[0], Args.Values[1]);
end;

procedure TCustomIniFile_WriteBool(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteBool(Args.Values[0], Args.Values[1], Args.Values[2])
end;

procedure TCustomIniFile_WriteFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteFloat(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_WriteInteger(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteInteger(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TCustomIniFile_WriteString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TCustomIniFile(Args.Obj).WriteString(Args.Values[0], Args.Values[1], Args.Values[2]);
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

{ TDirectory }

procedure TDirectory_GetDirectories(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TDirectory.GetDirectories(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure TDirectory_GetFiles(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TDirectory.GetFiles(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

{ TFile }

procedure TFile_ReadAllText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TFile.ReadAllText(Args.Values[0]);
end;

procedure TFile_WriteAllText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TFile.WriteAllText(Args.Values[0], Args.Values[1]);
end;

{ THashedStringList }

procedure THashedStringList_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(THashedStringList.Create);
end;

{ TIniFile }

procedure TIniFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TIniFile.Create(String(Args.Values[0])));
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

{ TRegistryIniFile }

procedure TRegistryIniFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TRegistryIniFile.Create(String(Args.Values[0])));
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

{ Registration }

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { TBinaryReader }
    AddClass('Classes', TBinaryReader, 'TBinaryReader');
    AddGet(TBinaryReader, 'Create', TBinaryReader_Create, 1, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'Read', TBinaryReader_Read, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadBoolean', TBinaryReader_ReadBoolean, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadByte', TBinaryReader_ReadByte, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadBytes', TBinaryReader_ReadBytes, 1, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadChar', TBinaryReader_ReadChar, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadDouble', TBinaryReader_ReadDouble, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadInteger', TBinaryReader_ReadInteger, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadShortInt', TBinaryReader_ReadShortInt, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadSingle', TBinaryReader_ReadSingle, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadSmallInt', TBinaryReader_ReadSmallInt, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadString', TBinaryReader_ReadString, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadUInt16', TBinaryReader_ReadUInt16, 0, [varEmpty], varEmpty);
    AddGet(TBinaryReader, 'ReadUInt32', TBinaryReader_ReadUInt32, 0, [varEmpty], varEmpty);

    { TBinaryWriter }
    AddClass('Classes', TBinaryWriter, 'TBinaryWriter');
    AddGet(TBinaryWriter, 'Create', TBinaryWriter_Create, 1, [varEmpty], varEmpty);
    AddGet(TBinaryWriter, 'Write', TBinaryWriter_Write, 1, [varEmpty], varEmpty);
    AddGet(TBinaryWriter, 'WriteSingle', TBinaryWriter_WriteSingle, 1, [varEmpty], varEmpty);

    { TBitmap }
    AddGet(TBitmap, 'SetSize', TBitmap_SetSize, 2, [varEmpty, varEmpty], varEmpty);

    { TBoundLabel }
    AddClass('ExtCtrls', TBoundLabel, 'TBoundLabel');

    { TBytesStream }
    AddClass('Classes', TBytesStream, 'TBytesStream');
    AddGet(TBytesStream, 'Create', TBytesStream_Create, 1, [varEmpty], varEmpty);

    { TCheckListBox }
    AddClass('CheckLst', TCheckListBox, 'TCheckListBox');
    AddGet(TCheckListBox, 'AllowGrayed', TCheckListBox_Read_AllowGrayed, 0, [varEmpty], varEmpty);
    AddSet(TCheckListBox, 'AllowGrayed', TCheckListBox_Write_AllowGrayed, 0, [varEmpty]);
    AddGet(TCheckListBox, 'CheckAll', TCheckListBox_CheckAll, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddIGet(TCheckListBox, 'Checked', TCheckListBox_Read_Checked, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'Checked', TCheckListBox_Write_Checked, 1, [varNull]);
    AddGet(TCheckListBox, 'Create', TCheckListBox_Create, 1, [varEmpty], varEmpty);
    AddIGet(TCheckListBox, 'Header', TCheckListBox_Read_Header, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'Header', TCheckListBox_Write_Header, 1, [varNull]);
    AddIGet(TCheckListBox, 'ItemEnabled', TCheckListBox_Read_ItemEnabled, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'ItemEnabled', TCheckListBox_Write_ItemEnabled, 1, [varNull]);
    AddIGet(TCheckListBox, 'State', TCheckListBox_Read_State, 1, [varEmpty], varEmpty);
    AddISet(TCheckListBox, 'State', TCheckListBox_Write_State, 1, [varNull]);
    AddHandler('CheckLst', 'TNotifyEvent', TJvInterpreterCheckListBoxEvents, @TJvInterpreterCheckListBoxEvents.OnClickCheck);

    { TComboBox }
    AddGet(TComboBox, 'DropDownCount', TComboBox_Read_DropDownCount, 0, [varEmpty], varEmpty);
    AddSet(TComboBox, 'DropDownCount', TComboBox_Write_DropDownCount, 0, [varEmpty]);

    { TControl }
    AddConst('Controls', 'seBorder', Ord(seBorder));
    AddConst('Controls', 'seClient', Ord(seClient));
    AddConst('Controls', 'seFont', Ord(seFont));
    AddGet(TControl, 'ScaleValue', TControl_ScaleValue, 1, [varEmpty], varEmpty);
    AddGet(TControl, 'StyleElements', TControl_Read_StyleElements, 0, [varEmpty], varEmpty);
    AddSet(TControl, 'StyleElements', TControl_Write_StyleElements, 0, [varEmpty]);

    { TCustomForm }
    AddGet(TCustomForm, 'PopupMode', TCustomForm_Read_PopupMode, 0, [varEmpty], varEmpty);
    AddSet(TCustomForm, 'PopupMode', TCustomForm_Write_PopupMode, 0, [varEmpty]);
    AddGet(TCustomForm, 'PopupParent', TCustomForm_Read_PopupParent, 0, [varEmpty], varEmpty);
    AddSet(TCustomForm, 'PopupParent', TCustomForm_Write_PopupParent, 0, [varEmpty]);

    { TCustomIniFile }
    AddClass('IniFiles', TCustomIniFile, 'TCustomIniFile');
    AddGet(TCustomIniFile, 'DeleteKey', TCustomIniFile_DeleteKey, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'EraseSection', TCustomIniFile_EraseSection, 1, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadBool', TCustomIniFile_ReadBool, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadFloat', TCustomIniFile_ReadFloat, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadInteger', TCustomIniFile_ReadInteger, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadSection', TCustomIniFile_ReadSection, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadSections', TCustomIniFile_ReadSections, 1, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadSectionValues', TCustomIniFile_ReadSectionValues, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ReadString', TCustomIniFile_ReadString, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'SectionExists', TCustomIniFile_SectionExists, 1, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'UpdateFile', TCustomIniFile_UpdateFile, 0, [varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'ValueExists', TCustomIniFile_ValueExists, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteBool', TCustomIniFile_WriteBool, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteFloat', TCustomIniFile_WriteFloat, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteInteger', TCustomIniFile_WriteInteger, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddGet(TCustomIniFile, 'WriteString', TCustomIniFile_WriteString, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { TCustomLabeledEdit }
    AddClass('ExtCtrls', TCustomLabeledEdit, 'TCustomLabeledEdit');
    AddGet(TCustomLabeledEdit, 'Create', TCustomLabeledEdit_Create, 1, [varEmpty], varEmpty);
    AddGet(TCustomLabeledEdit, 'EditLabel', TCustomLabeledEdit_Read_EditLabel, 0, [varEmpty], varEmpty);
    AddGet(TCustomLabeledEdit, 'LabelPosition', TCustomLabeledEdit_Read_LabelPosition, 0, [varEmpty], varEmpty);
    AddSet(TCustomLabeledEdit, 'LabelPosition', TCustomLabeledEdit_Write_LabelPosition, 0, [varEmpty]);
    AddGet(TCustomLabeledEdit, 'LabelSpacing', TCustomLabeledEdit_Read_LabelSpacing, 0, [varEmpty], varEmpty);
    AddSet(TCustomLabeledEdit, 'LabelSpacing', TCustomLabeledEdit_Write_LabelSpacing, 0, [varEmpty]);

    { TDirectory }
    AddConst('IOUtils', 'soAllDirectories', Ord(TSearchOption.soAllDirectories));
    AddConst('IOUtils', 'soTopDirectoryOnly', Ord(TSearchOption.soTopDirectoryOnly));
    AddRec('IOUtils', 'TDirectory', SizeOf(TDirectory), [], nil, nil, nil);
    AddRecGet('IOUtils', 'TDirectory', 'GetDirectories', TDirectory_GetDirectories, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddRecGet('IOUtils', 'TDirectory', 'GetFiles', TDirectory_GetFiles, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { TFile }
    AddRec('IOUtils', 'TFile', SizeOf(TFile), [], nil, nil, nil);
    AddRecGet('IOUtils', 'TFile', 'ReadAllText', TFile_ReadAllText, 1, [varEmpty], varEmpty);
    AddRecGet('IOUtils', 'TFile', 'WriteAllText', TFile_WriteAllText, 2, [varEmpty, varEmpty], varEmpty);

    { THashedStringList }
    AddClass('IniFiles', THashedStringList, 'THashedStringList');
    AddGet(THashedStringList, 'Create', THashedStringList_Create, 0, [varEmpty], varEmpty);

    { TIniFile }
    AddClass('IniFiles', TIniFile, 'TIniFile');
    AddGet(TIniFile, 'Create', TIniFile_Create, 1, [varEmpty], varEmpty);

    { TLabeledEdit }
    AddClass('ExtCtrls', TLabeledEdit, 'TLabeledEdit');
    AddGet(TLabeledEdit, 'Create', TLabeledEdit_Create, 1, [varEmpty], varEmpty);

    { TListItem }
    AddGet(TListItem, 'SubItems', TListItem_Read_SubItems, 0, [varEmpty], varEmpty);
    AddSet(TListItem, 'SubItems', TListItem_Write_SubItems, 0, [varEmpty]);

    { TListItems }
    AddSet(TListItems, 'Count', TListItems_Write_Count, 0, [varEmpty]);

    { TListView }
    AddHandler('ComCtrls', 'TLVOwnerDataEvent', TJvInterpreterListViewEvents, @TJvInterpreterListViewEvents.OnData);
    AddHandler('ComCtrls', 'TLVSelectItemEvent', TJvInterpreterListViewEvents, @TJvInterpreterListViewEvents.OnSelectItem);

    { TMemIniFile }
    AddClass('IniFiles', TMemIniFile, 'TMemIniFile');
    AddGet(TMemIniFile, 'Create', TMemIniFile_Create, 1, [varEmpty], varEmpty);
    AddGet(TMemIniFile, 'GetStrings', TMemIniFile_GetStrings, 1, [varEmpty], varEmpty);
    AddGet(TMemIniFile, 'SetStrings', TMemIniFile_SetStrings, 1, [varEmpty], varEmpty);

    { TMenu }
    AddGet(TMenu, 'AutoHotKeys', TMenu_Read_AutoHotKeys, 0, [varEmpty], varEmpty);
    AddSet(TMenu, 'AutoHotKeys', TMenu_Write_AutoHotKeys, 0, [varEmpty]);

    { TMenuItem }
    AddGet(TMenuItem, 'Clear', TMenuItem_Clear, 0, [varEmpty], varEmpty);

    { TRegistryIniFile }
    AddClass('Registry', TRegistryIniFile, 'TRegistryIniFile');
    AddGet(TRegistryIniFile, 'Create', TRegistryIniFile_Create, 1, [varEmpty], varEmpty);

    { TWinControl }
    AddGet(TWinControl, 'DoubleBuffered', TWinControl_Read_DoubleBuffered, 0, [varEmpty], varEmpty);
    AddSet(TWinControl, 'DoubleBuffered', TWinControl_Write_DoubleBuffered, 0, [varEmpty]);
  end;
end;

end.
