{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapter;

{$I xeDefines.inc}

interface

implementation

uses
  System.Classes,
  System.SysUtils,

  JvInterpreter,
  JvInterpreterFm,
  JvInterpreter_Buttons,
  JvInterpreter_Classes,
  JvInterpreter_Comctrls,
  JvInterpreter_Controls,
  JvInterpreter_Dialogs,
  JvInterpreter_ExtCtrls,
  JvInterpreter_Forms,
  JvInterpreter_Graphics,
  JvInterpreter_Math,
  JvInterpreter_Menus,
  JvInterpreter_StdCtrls,
  JvInterpreter_System,
  JvInterpreter_SysUtils,
  JvInterpreter_Windows,

  wbBSArchive,
  wbHelpers,
  wbInterface,
  xeInit,

  xejviScriptAdapterContainer,
  xejviScriptAdapterDF,
  xejviScriptAdapterElement,
  xejviScriptAdapterFile,
  xejviScriptAdapterHost,
  xejviScriptAdapterMisc,
  xejviScriptAdapterRecord,
  xejviScriptAdapterResource;

const
  cUnit = 'Dummy';
  cInterface = 'wbInterface';
  cTwbVector = 'TwbVector';
  cTwbGridCell = 'TwbGridCell';


{ TElement }
//procedure IwbElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
//var
//  Element: IwbElement;
//begin
//  Value := '';
//  if Supports(IInterface(Pointer(Args.Obj)), IwbElement, Element) then
//    Value := Element.Name;
//end;

procedure _Assigned(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Assigned(V2O(Args.Values[0]));
end;

procedure ObjectToElement(var Value: Variant; Args: TJvInterpreterArgs);
begin
  try
    Value := IwbElement(Pointer(V2O(Args.Values[0])));
  except
  end;
end;

procedure _FullPathToFilename(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FullPathToFilename(String(Args.Values[0]));
end;

procedure EnableSkyrimSaveFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  xeContext.Settings.TestWrite := True;
  xeContext.Settings.ForceNewHeader := True;
end;

procedure GetRecordDefNames(var Value: Variant; Args: TJvInterpreterArgs);
var
  sl: TStrings;
  i: integer;
begin
  var lGameDef := xeContext.GameDefObj;
  sl := TStrings(V2O(Args.Values[0]));

  if not Assigned(sl) then
    Exit;

  for i := Low(lGameDef.RecordDefs) to High(lGameDef.RecordDefs) do
    with lGameDef.RecordDefs[i].rdeDef do
      sl.Add(DefaultSignature + ' - ' + GetName);
end;

procedure wbFilterStrings(var Value: Variant; Args: TJvInterpreterArgs);
var
  slIn, slOut: TStrings;
  Filter: string;
  i: integer;
begin
  slIn := TStrings(V2O(Args.Values[0]));
  slOut := TStrings(V2O(Args.Values[1]));
  if not Assigned(slIn) or not Assigned(slOut) then
    Exit;
  Filter := Lowercase(string(Args.Values[2]));
  for i := 0 to Pred(slIn.Count) do
    if Pos(Filter, Lowercase(slIn[i])) > 0 then
      slOut.Add(slIn[i]);
end;

procedure wbRemoveDuplicateStrings(var Value: Variant; Args: TJvInterpreterArgs);
var
  sl: TStringList;
  i, j: integer;
begin
  sl := TStringList(V2O(Args.Values[0]));
  for i := Pred(sl.Count) downto 0 do begin
    sl.Find(sl[i], j);
    if (j <> -1) and (j <> i) then
      sl.Delete(i);
  end;
end;

procedure wbGetVersionNumber(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := VersionString.ToCardinal;
end;

{ TwbVector }

function wbVector2Var(const wbVector: TwbVector): Variant;
var
  Rec: ^TwbVector;
begin
  New(Rec);
  Rec^ := wbVector;
  Result := R2V(cTwbVector, Rec);
end;

function Var2wbVector(const wbVector: Variant): TwbVector;
begin
  Result := TwbVector(V2R(wbVector)^);
end;

procedure JvInterpreter_wbVector(var Value: Variant; Args: TJvInterpreterArgs);
var
  Rec: TwbVector;
begin
  Rec.x := Args.Values[0];
  Rec.y := Args.Values[1];
  Rec.z := Args.Values[2];
  Value := wbVector2Var(Rec);
end;


{ TwbGridCell }

function wbGridCell2Var(const wbGridCell: TwbGridCell): Variant;
var
  Rec: ^TwbGridCell;
begin
  New(Rec);
  Rec^ := wbGridCell;
  Result := R2V(cTwbGridCell, Rec);
end;

function Var2wbGridCell(const wbGridCell: Variant): TwbGridCell;
begin
  Result := TwbGridCell(V2R(wbGridCell)^);
end;

procedure JvInterpreter_wbGridCell(var Value: Variant; Args: TJvInterpreterArgs);
var
  Rec: TwbGridCell;
begin
  Rec.x := Args.Values[0];
  Rec.y := Args.Values[1];
  Value := wbGridCell2Var(Rec);
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    AddExtUnit(cInterface);
    { TwbVector }
    AddRec(cInterface, cTwbVector, SizeOf(TwbVector), [RFD('x', 0, varSingle), RFD('y', 4, varSingle), RFD('z', 8, varSingle)], nil, nil, nil);
    AddFunction(cInterface, 'wbVector', JvInterpreter_wbVector, 3, [varEmpty, varEmpty, varEmpty], varRecord);
    { TwbGridCell }
    AddRec(cInterface, cTwbGridCell, SizeOf(TwbGridCell), [RFD('x', 0, varInteger), RFD('y', 4, varInteger)], nil, nil, nil);
    AddFunction(cInterface, 'wbGridCell', JvInterpreter_wbGridCell, 2, [varEmpty, varEmpty], varRecord);

    //AddIntfGet(IwbElement, 'Name', IwbElement_Name, 0, [VarEmpty], varEmpty);
    AddConst(cUnit, 'gmTES3', ord(gmTES3));
    AddConst(cUnit, 'gmTES4', ord(gmTES4));
    AddConst(cUnit, 'gmTES4R', ord(gmTES4R));
    AddConst(cUnit, 'gmTES5', ord(gmTES5));
    AddConst(cUnit, 'gmTES5VR', ord(gmTES5VR));
    AddConst(cUnit, 'gmFO3', ord(gmFO3));
    AddConst(cUnit, 'gmFNV', ord(gmFNV));
    AddConst(cUnit, 'gmFO4', ord(gmFO4));
    AddConst(cUnit, 'gmFO4VR', ord(gmFO4VR));
    AddConst(cUnit, 'gmFO76', ord(gmFO76));
    AddConst(cUnit, 'gmSSE', ord(gmSSE));
    AddConst(cUnit, 'gmEnderal', ord(gmEnderal));
    AddConst(cUnit, 'gmEnderalSE', ord(gmEnderalSE));
    AddConst(cUnit, 'gmSF1', ord(gmSF1));

    { TwbElementType }
    AddConst(cUnit, 'etFile', ord(etFile));
    AddConst(cUnit, 'etMainRecord', ord(etMainRecord));
    AddConst(cUnit, 'etGroupRecord', ord(etGroupRecord));
    AddConst(cUnit, 'etSubRecord', ord(etSubRecord));
    AddConst(cUnit, 'etSubRecordStruct', ord(etSubRecordStruct));
    AddConst(cUnit, 'etSubRecordArray', ord(etSubRecordArray));
    AddConst(cUnit, 'etSubRecordUnion', ord(etSubRecordUnion));
    AddConst(cUnit, 'etArray', ord(etArray));
    AddConst(cUnit, 'etStruct', ord(etStruct));
    AddConst(cUnit, 'etValue', ord(etValue));
    AddConst(cUnit, 'etFlag', ord(etFlag));
    AddConst(cUnit, 'etStringListTerminator', ord(etStringListTerminator));
    AddConst(cUnit, 'etUnion', ord(etUnion));
    AddConst(cUnit, 'etStructChapter', ord(etStructChapter));

    { TwbElementState }
    AddConst(cUnit, 'esModified', Ord(esModified));
    AddConst(cUnit, 'esInternalModified', Ord(esInternalModified));
    AddConst(cUnit, 'esUnsaved', Ord(esUnsaved));
    AddConst(cUnit, 'esSortKeyValid', Ord(esSortKeyValid));
    AddConst(cUnit, 'esExtendedSortKeyValid', Ord(esExtendedSortKeyValid));
    AddConst(cUnit, 'esHidden', Ord(esHidden));
    AddConst(cUnit, 'esParentHidden', Ord(esParentHidden));
    AddConst(cUnit, 'esParentHiddenChecked', Ord(esParentHiddenChecked));
    AddConst(cUnit, 'esNotReachable', Ord(esNotReachable));
    AddConst(cUnit, 'esReachable', Ord(esReachable));
    AddConst(cUnit, 'esTagged', Ord(esTagged));
    AddConst(cUnit, 'esDeciding', Ord(esResolving));
    AddConst(cUnit, 'esResolving', Ord(esResolving));
    AddConst(cUnit, 'esNotSuitableToAddTo', Ord(esNotSuitableToAddTo));

    { TwbDefType }
    AddConst(cUnit, 'dtRecord', ord(dtRecord));
    AddConst(cUnit, 'dtSubRecord', ord(dtSubRecord));
    AddConst(cUnit, 'dtSubRecordArray', ord(dtSubRecordArray));
    AddConst(cUnit, 'dtSubRecordStruct', ord(dtSubRecordStruct));
    AddConst(cUnit, 'dtSubRecordUnion', ord(dtSubRecordUnion));
    AddConst(cUnit, 'dtString', ord(dtString));
    AddConst(cUnit, 'dtLString', ord(dtLString));
    AddConst(cUnit, 'dtLenString', ord(dtLenString));
    AddConst(cUnit, 'dtByteArray', ord(dtByteArray));
    AddConst(cUnit, 'dtInteger', ord(dtInteger));
    AddConst(cUnit, 'dtIntegerFormater', ord(dtIntegerFormater));
    AddConst(cUnit, 'dtFloat', ord(dtFloat));
    AddConst(cUnit, 'dtArray', ord(dtArray));
    AddConst(cUnit, 'dtStruct', ord(dtStruct));
    AddConst(cUnit, 'dtUnion', ord(dtUnion));
    AddConst(cUnit, 'dtEmpty', ord(dtEmpty));
    AddConst(cUnit, 'dtStructChapter', ord(dtStructChapter));

    { TConflictThis }
    AddConst(cUnit, 'ctUnknown', ord(ctUnknown));
    AddConst(cUnit, 'ctIgnored', ord(ctIgnored));
    AddConst(cUnit, 'ctNotDefined', ord(ctNotDefined));
    AddConst(cUnit, 'ctIdenticalToMaster', ord(ctIdenticalToMaster));
    AddConst(cUnit, 'ctOnlyOne', ord(ctOnlyOne));
    AddConst(cUnit, 'ctHiddenByModGroup', ord(ctHiddenByModGroup));
    AddConst(cUnit, 'ctMaster', ord(ctMaster));
    AddConst(cUnit, 'ctConflictBenign', ord(ctConflictBenign));
    AddConst(cUnit, 'ctOverride', ord(ctOverride));
    AddConst(cUnit, 'ctIdenticalToMasterWinsConflict', ord(ctIdenticalToMasterWinsConflict));
    AddConst(cUnit, 'ctConflictWins', ord(ctConflictWins));
    AddConst(cUnit, 'ctConflictLoses', ord(ctConflictLoses));

    { TConflictAll }
    AddConst(cUnit, 'caUnknown', ord(caUnknown));
    AddConst(cUnit, 'caOnlyOne', ord(caOnlyOne));
    AddConst(cUnit, 'caNoConflict', ord(caNoConflict));
    AddConst(cUnit, 'caConflictBenign', ord(caConflictBenign));
    AddConst(cUnit, 'caOverride', ord(caOverride));
    AddConst(cUnit, 'caConflict', ord(caConflict));
    AddConst(cUnit, 'caConflictCritical', ord(caConflictCritical));

    { TwbContainerState }
    AddConst(cUnit, 'csInit', ord(csInit));
    AddConst(cUnit, 'csInitOnce', ord(csInitOnce));
    AddConst(cUnit, 'csInitDone', ord(csInitDone));
    AddConst(cUnit, 'csInitializing', ord(csInitializing));
    AddConst(cUnit, 'csRefsBuild', ord(csRefsBuild));
    AddConst(cUnit, 'csAsCreatedEmpty', ord(csAsCreatedEmpty));

    {TGameResourceType - Deprecated, use TwbAssetType }
    AddConst(cUnit, 'resMesh', ord(atMesh));
    AddConst(cUnit, 'resTexture', ord(atTexture));
    AddConst(cUnit, 'resSound', ord(atSound));
    AddConst(cUnit, 'resMusic', ord(atMusic));
    AddConst(cUnit, 'resMaterial', ord(atMaterial));
	
    { TwbAssetType }
    AddConst(cUnit, 'atNone',          ord(atNone));
    AddConst(cUnit, 'atBookArt',       ord(atBookArt));
    AddConst(cUnit, 'atDialogueViews', ord(atDialogueViews));
    AddConst(cUnit, 'atDistantLOD',    ord(atDistantLOD));
    AddConst(cUnit, 'atFacegen',       ord(atFacegen));
    AddConst(cUnit, 'atFont',          ord(atFont));
    AddConst(cUnit, 'atGeometry',      Ord(atGeometry));
    AddConst(cUnit, 'atGrass',         ord(atGrass));
    AddConst(cUnit, 'atIcon',          ord(atIcon));
    AddConst(cUnit, 'atInterface',     ord(atInterface));
    AddConst(cUnit, 'atLODSettings',   ord(atLODSettings));
    AddConst(cUnit, 'atLSData',        ord(atLSData));
    AddConst(cUnit, 'atMaterial',      ord(atMaterial));
    AddConst(cUnit, 'atMenus',         ord(atMenus));
    AddConst(cUnit, 'atMesh',          ord(atMesh));
    AddConst(cUnit, 'atMusic',         ord(atMusic));
    AddConst(cUnit, 'atPrevis',        ord(atPrevis));
    AddConst(cUnit, 'atProgram',       ord(atProgram));
    AddConst(cUnit, 'atScript',        ord(atScript));
    AddConst(cUnit, 'atSeq',           ord(atSeq));
    AddConst(cUnit, 'atShaders',       ord(atShaders));
    AddConst(cUnit, 'atSound',         ord(atSound));
    AddConst(cUnit, 'atSource',        ord(atSource));
    AddConst(cUnit, 'atSourceSSE',     ord(atSourceSSE));
    AddConst(cUnit, 'atSpeedTree',     ord(atSpeedTree));
    AddConst(cUnit, 'atSplash',        ord(atSplash));
    AddConst(cUnit, 'atStrings',       ord(atStrings));
    AddConst(cUnit, 'atTexture',       ord(atTexture));
    AddConst(cUnit, 'atVideo',         ord(atVideo));
    AddConst(cUnit, 'atVoice',         ord(atVoice));

    AddFunction(cUnit, 'Assigned', _Assigned, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ObjectToElement', ObjectToElement, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FullPathToFilename', _FullPathToFilename, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EnableSkyrimSaveFormat', EnableSkyrimSaveFormat, 0, [], varEmpty);
    AddFunction(cUnit, 'GetRecordDefNames', GetRecordDefNames, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFilterStrings', wbFilterStrings, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbRemoveDuplicateStrings', wbRemoveDuplicateStrings, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbVersionNumber', wbGetVersionNumber, 0, [], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreterFm.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_System.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_SysUtils.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Classes.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Dialogs.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Windows.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Graphics.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Controls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Buttons.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_StdCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_ComCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_ExtCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Forms.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Dialogs.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Menus.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Math.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  //JvInterpreter_JvEditor.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterMisc.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterDF.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterElement.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterContainer.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterRecord.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterFile.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterResource.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterHost.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
