{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterHost;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.SysUtils,
  System.Variants,

  VirtualTrees,

  wbDataFormat,
  wbHelpers,
  wbInterface,
  wbLOD,

  xeFileSelectForm,
  xeInit,
  xeMainForm;

const
  cUnit = 'Dummy';

{ Zero-arg globals — no frmMain dependency }

procedure _wbGameMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGameMode;
end;

procedure _wbGameName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGameName;
end;

procedure _wbGameMasterEsm(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGameMasterEsm;
end;

procedure _wbGameName2(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGameName2;
end;

procedure _wbAppName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbAppName;
end;

procedure _wbLoadBSAs(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbLoadBSAs;
end;

procedure _wbSimpleRecords(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbSimpleRecords;
end;

procedure _wbDecodeTextureHashes(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDecodeTextureHashes;
end;

procedure _wbTrackAllEditorID(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbTrackAllEditorID;
end;

procedure _wbRecordDefMap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(wbInterface._wbRecordDefMap);
end;

procedure _wbProgramPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbProgramPath;
end;

procedure _ScriptsPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  // the directory of the running script, so scripts in subdirectories find
  // their own data files
  if frmMain.ScriptPath <> '' then
    Value := frmMain.ScriptPath
  else
    Value := wbScriptsPath;
end;

// mirrors the global, which stays the scripts root even while a script in a
// subdirectory is running
procedure _wbScriptsPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbScriptsPath;
end;

procedure _wbDataPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDataPath;
end;

procedure _wbTempPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbTempPath;
end;

procedure _wbOutputPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbOutputPath;
end;

procedure _wbSettingsFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeSettingsFileName;
end;

procedure _dfFloatDecimalDigits(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := dfFloatDecimalDigits;
end;

procedure _frmMain(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(frmMain);
end;

procedure _AddMessage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if VarIsStr(Args.Values[0]) then
    wbProgress(Args.Values[0])
  else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _ExecuteCaptureConsoleOutput(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := ExecuteCaptureConsoleOutput(Args.Values[0]);
end;

{ frmMain-dependent }

procedure _wbSettings(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(frmMain.Settings);
end;

procedure _FilterApplied(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := frmMain.FilterApplied;
end;

procedure _ClearMessages(var Value: Variant; Args: TJvInterpreterArgs);
begin
  frmMain.mmoMessages.Clear;
  DoProcessMessages;
end;

procedure _FileCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Length(frmMain.Files);
end;

procedure _FileByIndex(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if VarIsNumeric(Args.Values[0]) and (Args.Values[0] < Length(frmMain.Files)) then
    Value := frmMain.Files[Integer(Args.Values[0])]
  else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _FileByLoadOrderFileID(var Value: Variant; Args: TJvInterpreterArgs);
var
  i: Integer;
begin
  if VarIsStr(Args.Values[0]) then begin
    for i := Low(frmMain.Files) to High(frmMain.Files) do
      if frmMain.Files[i].LoadOrderFileID.ToString = Args.Values[0] then begin
        Value := frmMain.Files[i];
        Break;
      end;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _FileByLoadOrder(var Value: Variant; Args: TJvInterpreterArgs);
var
  i: Integer;
begin
  if VarIsNumeric(Args.Values[0]) and (Args.Values[0] < Length(frmMain.Files)) then begin
    for i := Low(frmMain.Files) to High(frmMain.Files) do
      if frmMain.Files[i].LoadOrder = Integer(Args.Values[0]) then begin
        Value := frmMain.Files[i];
        Break;
      end;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _FileByName(var Value: Variant; Args: TJvInterpreterArgs);
var
  i: Integer;
begin
  if VarIsStr(Args.Values[0]) then begin
    for i := Low(frmMain.Files) to High(frmMain.Files) do
      if SameText(Args.Values[0], frmMain.Files[i].FileName) then begin
        Value := frmMain.Files[i];
        Break;
      end;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _RecordFromFileByFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  lFile: IwbFile;
  lFormID: TwbFormID;
  i: Integer;
begin
  case Args.Count of
  0, 1: JvInterpreterError(ieNotEnoughParams, -1);
  2:
    begin
      // detect if first arg is file by name or interface
      if VarIsStr(Args.Values[0]) then
      begin
        for i := Low(frmMain.Files) to High(frmMain.Files) do
          if SameText(Args.Values[0], frmMain.Files[i].FileName) then
          begin
            lFile := frmMain.Files[i];
            Break;
          end;
          if not Assigned(lFile) then
            JvInterpreterErrorN(ieUnitNotFound, -1, Args.Values[0]);
      end
      else if not Supports(IInterface(Args.Values[0]), IwbFile, lFile) then
        JvInterpreterError(ieTypeMistmatch, -1);

      // determine if second arg is form id as integer or string
      if VarIsStr(Args.Values[1]) then
        lFormID := TwbFormID.FromStr(string(Args.Values[1]))
      else if VarIsNumeric(Args.Values[1]) then
        lFormID := TwbFormID.FromVar(Args.Values[1]);

      if lFile.IsLight then
        lFormID.ObjectID := lFormID.ObjectID and $FFF
      else if lFile.IsMedium then
        lFormID.ObjectID := lFormID.ObjectID and $FFFF
      else
        lFormID.ObjectID := lFormID.ObjectID and $FFFFFF;

      lFormID.FileID := lFile.LoadOrderFileID;

      Value := lFile.RecordByFormID[lFormID, True, True];
    end
  else
    JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure _RecordByHexFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  i: Integer;
  aFormID: TwbFormID;
begin
  if VarIsStr(Args.Values[0]) then begin
    Value := Null;
    aFormID := TwbFormID.FromStr(string(Args.Values[0]));
    for i := Low(frmMain.Files) to High(frmMain.Files) do
      if frmMain.Files[i].LoadOrderFileID = aFormID.FileID then begin
        Value := frmMain.Files[i].RecordByFormID[aFormID, True, True];
        Break;
      end;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _IsPositionChanged(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := IsPositionChanged(MainRecord)
  else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _AddNewFile(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  case Args.Count of
    0: frmMain.AddNewFile(_File, False, False);
    1: frmMain.AddNewFile(_File, Args.Values[0], False);
    2: frmMain.AddNewFile(_File, Args.Values[0], Args.Values[1]);
  end;
  Value := _File;
end;

procedure _AddNewFileName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    1: Value := frmMain.AddNewFileName(Args.Values[0], False, False);
    2: Value := frmMain.AddNewFileName(Args.Values[0], Args.Values[1], False);
    3: Value := frmMain.AddNewFileName(Args.Values[0], Args.Values[1], Args.Values[2]);
  end;
end;

procedure _AddRequiredElementMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
  Silent: Boolean;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbFile, _File) then begin
      Silent := False;
      if Args.Count >= 4 then
        Silent := Args.Values[3];
      Value := frmMain.AddRequiredMasters(Element, _File, Args.Values[2], Silent);
    end;
end;

procedure _RemoveNode(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  MainRecord: IwbMainRecord;
  Node: PVirtualNode;
  NodeData: PNavNodeData;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    Node := frmMain.FindNodeForElement(Element);
    if Assigned(Node) then begin
      NodeData := frmMain.vstNav.GetNodeData(Node);
      if Supports(Element, IwbMainRecord, MainRecord) then begin
        frmMain.CheckHistoryRemove(frmMain.BackHistory, MainRecord);
        frmMain.CheckHistoryRemove(frmMain.ForwardHistory, MainRecord);
      end;
      frmMain.DoSetActiveRecord(nil);
      if Element.Equals(NodeData.Container) then
        NodeData.Container := nil;
      if Assigned(NodeData.Container) then
        NodeData.Container.Remove;
      Element.Remove;
      NodeData.Element := nil;
      NodeData.Container := nil;
      Element := nil;
      frmMain.vstNav.DeleteNode(Node);
      Value := True;
    end;
  end;
end;

procedure _ConflictThisForMainRecord(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  ConflictAll: TConflictAll;
  ConflictThis: TConflictThis;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    frmMain.ConflictLevelForMainRecord(MainRecord, ConflictAll, ConflictThis);
    Value := ConflictThis;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _ConflictAllForMainRecord(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  ConflictAll: TConflictAll;
  ConflictThis: TConflictThis;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    frmMain.ConflictLevelForMainRecord(MainRecord, ConflictAll, ConflictThis);
    Value := ConflictAll;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _ConflictThisForNode(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  Node: PVirtualNode;
  NodeData: PNavNodeData;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    Node := frmMain.FindNodeForElement(Element);
    if Assigned(Node) then begin
      NodeData := frmMain.vstNav.GetNodeData(Node);
      Value := NodeData.ConflictThis;
    end;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _ConflictAllForNode(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  Node: PVirtualNode;
  NodeData: PNavNodeData;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    Node := frmMain.FindNodeForElement(Element);
    if Assigned(Node) then begin
      NodeData := frmMain.vstNav.GetNodeData(Node);
      Value := NodeData.ConflictAll;
    end;
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _ConflictAllForElements(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  Container: IwbContainerElementRef;
  NodeDatas: TDynViewNodeDatas;
  List: TList;
  i: Integer;
begin
  if Args.Count = 3 then begin
    Value := caUnknown;
    List := TList(V2O(Args.Values[0]));
    if Assigned(List) then
    for i := 0 to Pred(List.Count) do begin
      if not Supports(IInterface(Pointer(List[i])), IwbElement, Element) then
        Continue;
      SetLength(NodeDatas, Succ(Length(NodeDatas)));
      NodeDatas[Pred(Length(NodeDatas))].Element := Element;
      if Supports(Element, IwbContainerElementRef, Container) and (Container.ElementCount > 0) then
        NodeDatas[Pred(Length(NodeDatas))].Container := Container;
    end;
    i := 0;
  end
  else if Args.Count = 4 then begin
    for i := 0 to 1 do begin
      if not Supports(IInterface(Args.Values[i]), IwbElement, Element) then
        Continue;
      SetLength(NodeDatas, Succ(Length(NodeDatas)));
      NodeDatas[Pred(Length(NodeDatas))].Element := Element;
      if Supports(Element, IwbContainerElementRef, Container) and (Container.ElementCount > 0) then
        NodeDatas[Pred(Length(NodeDatas))].Container := Container;
    end;
    i := 1;
  end else
    i := 0;
  Value := caUnknown;
  if Length(NodeDatas) > 0 then
    if Assigned(NodeDatas[0].Container) then
      Value := frmMain.ConflictLevelForChildNodeDatas(NodeDatas, Args.Values[i+1], Args.Values[i+2])
    else
      Value := frmMain.ConflictLevelForNodeDatas(@NodeDatas[0], Length(NodeDatas), Args.Values[i+1], Args.Values[i+2]);
end;

procedure _JumpTo(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    frmMain.vstNav.EndUpdate;
    if not frmMain.vstNav.Enabled then frmMain.vstNav.Enabled := True;
    frmMain.JumpTo(MainRecord, Boolean(Args.Values[1]));
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _ApplyFilter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  frmMain.FilterPreset := True; // skip filter dialog
  try
    frmMain.mniNavFilterApplyClick(nil);
  finally
    frmMain.FilterPreset := False;
  end;
end;

procedure _RemoveFilter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  frmMain.DoSetActiveRecord(nil);
  frmMain.mniNavFilterRemoveClick(nil);
end;

procedure _frmFileSelect(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TfrmFileSelect.Create(nil));
end;

procedure _GenerateLODTES4(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    if wbGameMode = gmTES4 then
      wbGenerateLODTES4(MainRecord, frmMain.Settings);
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _GenerateLODTES5Trees(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    if wbIsSkyrim then
      wbGenerateLODTES5(MainRecord, [lodTrees], frmMain.Files, frmMain.Settings);
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _GenerateLODTES5Objects(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    if wbIsSkyrim then
      wbGenerateLODTES5(MainRecord, [lodObjects], frmMain.Files, frmMain.Settings);
  end else
    JvInterpreterError(ieDirectInvalidArgument, 0);
end;

procedure _wbGetUVRangeTexturesList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbGetUVRangeTexturesList(
    TStrings(V2O(Args.Values[0])),  // TStrings list of meshes
    TStrings(V2O(Args.Values[1])),  // TStrings list of textures, output
    Single(Args.Values[2])          // UVRange
  );
end;

procedure _wbBuildAtlasFromTexturesList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbBuildAtlasFromTexturesList(
    TStrings(V2O(Args.Values[0])),  // TStrings list of textures
    Args.Values[1], // max texture size
    Args.Values[2], // max tile size
    Args.Values[3], // atlas width
    Args.Values[4], // atlas height
    Args.Values[5], // atlas file name
    Args.Values[6], // atlas map file name
    frmMain.Settings
  );
end;

procedure _wbBuildAtlasFromAtlasMap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbBuildAtlasFromAtlasMap(
    TStrings(V2O(Args.Values[0])),  // TStrings atlas map
    Args.Values[1],                // brightness
    Args.Values[2],                // GammaR
    Args.Values[3],                // GammaG
    Args.Values[4],                // GammaB
    frmMain.Settings
  );
end;

procedure _wbSelectedFiles(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
  MainRecord: IwbMainRecord;
  NodeData: PNavNodeData;
  Nodes: TNodeArray;
  List: TList;
  i, j: Integer;
  Found: Boolean;
begin
  List := TList(V2O(Args.Values[0]));
  if not Assigned(List) then
    Exit;

  Nodes := frmMain.vstNav.GetSortedSelection(True);

  for i := Low(Nodes) to High(Nodes) do begin
    NodeData := frmMain.vstNav.GetNodeData(Nodes[i]);
    if not Assigned(NodeData) then
      Continue;
    Element := NodeData.Element;
    if Supports(Element, IwbFile, _File) then begin
      // Check if this file is already in the list
      Found := False;
      for j := 0 to Pred(List.Count) do begin
        if Supports(IInterface(Pointer(List[j])), IwbFile, Element) and (Element as IwbFile = _File) then begin
          Found := True;
          Break;
        end;
      end;
      if not Found then
        List.Add(Pointer(_File));
    end
    else if Supports(Element, IwbMainRecord, MainRecord) then begin
      _File := MainRecord._File;
      // Check if this file is already in the list
      Found := False;
      for j := 0 to Pred(List.Count) do begin
        if Supports(IInterface(Pointer(List[j])), IwbFile, Element) and (Element as IwbFile = _File) then begin
          Found := True;
          Break;
        end;
      end;
      if not Found then
        List.Add(Pointer(_File));
    end;
  end;
end;

procedure _wbSelectedFilesToFileNames(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
  Container: IwbGroupRecord;
  MainRecord: IwbMainRecord;
  NodeData: PNavNodeData;
  Nodes: TNodeArray;
  i: Integer;
begin
  if not (V2O(Args.Values[0]) is TStrings) or not (V2O(Args.Values[0]) is TStringList) then begin
    JvInterpreterErrorN(ieDirectInvalidArgument, 0, 'Expected a TStrings or TStringsList'); // or ieNotEnoughParams, ieIncompatibleTypes or others.
  end;
  
  Nodes := frmMain.vstNav.GetSortedSelection(True);

  for i := Low(Nodes) to High(Nodes) do begin
    NodeData := frmMain.vstNav.GetNodeData(Nodes[i]);
    if not Assigned(NodeData) then
      Continue;
    Element := NodeData.Element;
    if Supports(Element, IwbFile, _File) then begin
      if TStrings(V2O(Args.Values[0])).IndexOf(_File.FileName) = -1 then
        TStrings(V2O(Args.Values[0])).AddObject(_File.FileName, TObject(Pointer(Element)));
    end
    else if Supports(Element, IwbMainRecord, MainRecord) then begin
      if TStrings(V2O(Args.Values[0])).IndexOf(MainRecord._File.FileName) = -1 then
        TStrings(V2O(Args.Values[0])).AddObject(MainRecord._File.FileName, TObject(Pointer(MainRecord._File)));
    end
	else if Supports(Element, IwbGroupRecord, Container) then begin
	  if TStrings(V2O(Args.Values[0])).IndexOf(Container._File.FileName) = -1 then
	    TStrings(V2O(Args.Values[0])).AddObject(Container._File.FileName, TObject(Pointer(Container._File)));
	end;
  end;
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { Zero-arg globals }
    AddFunction(cUnit, 'wbGameMode', _wbGameMode, 0, [], varEmpty);
    AddFunction(cUnit, 'wbGameName', _wbGameName, 0, [], varEmpty);
    AddFunction(cUnit, 'wbGameMasterEsm', _wbGameMasterEsm, 0, [], varEmpty);
    AddFunction(cUnit, 'wbGameName2', _wbGameName2, 0, [], varEmpty);
    AddFunction(cUnit, 'wbAppName', _wbAppName, 0, [], varEmpty);
    AddFunction(cUnit, 'wbLoadBSAs', _wbLoadBSAs, 0, [], varEmpty);
    AddFunction(cUnit, 'wbSimpleRecords', _wbSimpleRecords, 0, [], varEmpty);
    AddFunction(cUnit, 'wbDecodeTextureHashes', _wbDecodeTextureHashes, 0, [], varEmpty);
    AddFunction(cUnit, 'wbTrackAllEditorID', _wbTrackAllEditorID, 0, [], varEmpty);
    AddFunction(cUnit, 'wbRecordDefMap', _wbRecordDefMap, 0, [], varEmpty);
    AddFunction(cUnit, 'ProgramPath', _wbProgramPath, 0, [], varEmpty);
    AddFunction(cUnit, 'wbProgramPath', _wbProgramPath, 0, [], varEmpty);
    AddFunction(cUnit, 'ScriptsPath', _ScriptsPath, 0, [], varEmpty);
    AddFunction(cUnit, 'wbScriptsPath', _wbScriptsPath, 0, [], varEmpty);
    AddFunction(cUnit, 'DataPath', _wbDataPath, 0, [], varEmpty);
    AddFunction(cUnit, 'wbDataPath', _wbDataPath, 0, [], varEmpty);
    AddFunction(cUnit, 'TempPath', _wbTempPath, 0, [], varEmpty);
    AddFunction(cUnit, 'wbTempPath', _wbTempPath, 0, [], varEmpty);
    AddFunction(cUnit, 'wbOutputPath', _wbOutputPath, 0, [], varEmpty);
    AddFunction(cUnit, 'wbSettingsFileName', _wbSettingsFileName, 0, [], varEmpty);
    AddFunction(cUnit, 'dfFloatDecimalDigits', _dfFloatDecimalDigits, 0, [], varEmpty);
    AddFunction(cUnit, 'frmMain', _frmMain, 0, [], varEmpty);
    AddFunction(cUnit, 'AddMessage', _AddMessage, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ExecuteCaptureConsoleOutput', _ExecuteCaptureConsoleOutput, 1, [varEmpty], varEmpty);

    { frmMain-dependent }
    AddFunction(cUnit, 'wbSettings', _wbSettings, 0, [], varEmpty);
    AddFunction(cUnit, 'FilterApplied', _FilterApplied, 0, [], varEmpty);
    AddFunction(cUnit, 'ClearMessages', _ClearMessages, 0, [], varEmpty);
    AddFunction(cUnit, 'FileCount', _FileCount, 0, [], varEmpty);
    AddFunction(cUnit, 'FileByIndex', _FileByIndex, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FileByLoadOrderFileID', _FileByLoadOrderFileID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FileByLoadOrder', _FileByLoadOrder, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FileByName', _FileByName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'RecordFromFileByFormID', _RecordFromFileByFormID, -1, [], varEmpty);
    AddFunction(cUnit, 'RecordByHexFormID', _RecordByHexFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsPositionChanged', _IsPositionChanged, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'AddNewFile', _AddNewFile, -1, [], varEmpty);
    AddFunction(cUnit, 'AddNewFileName', _AddNewFileName, -1, [], varEmpty);
    AddFunction(cUnit, 'AddRequiredElementMasters', _AddRequiredElementMasters, -1, [], varEmpty);
    AddFunction(cUnit, 'RemoveNode', _RemoveNode, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ConflictThisForMainRecord', _ConflictThisForMainRecord, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ConflictAllForMainRecord', _ConflictAllForMainRecord, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ConflictThisForNode', _ConflictThisForNode, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ConflictAllForNode', _ConflictAllForNode, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ConflictAllForElements', _ConflictAllForElements, -1, [], varEmpty);
    AddFunction(cUnit, 'JumpTo', _JumpTo, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ApplyFilter', _ApplyFilter, 0, [], varEmpty);
    AddFunction(cUnit, 'RemoveFilter', _RemoveFilter, 0, [], varEmpty);
    AddFunction(cUnit, 'frmFileSelect', _frmFileSelect, 0, [], varEmpty);
    AddFunction(cUnit, 'GenerateLODTES4', _GenerateLODTES4, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GenerateLODTES5Trees', _GenerateLODTES5Trees, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GenerateLODTES5Objects', _GenerateLODTES5Objects, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbGetUVRangeTexturesList', _wbGetUVRangeTexturesList, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbBuildAtlasFromTexturesList', _wbBuildAtlasFromTexturesList, 7, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbBuildAtlasFromAtlasMap', _wbBuildAtlasFromAtlasMap, 5, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbSelectedFiles', _wbSelectedFiles, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbSelectedFilesToFileNames', _wbSelectedFilesToFileNames, 1, [varEmpty], varEmpty);
  end;
end;

end.
