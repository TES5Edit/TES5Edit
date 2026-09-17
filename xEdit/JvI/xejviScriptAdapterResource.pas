{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterResource;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.SysUtils,

  Vcl.Graphics,

  wbBSArchive,
  wbHash,
  wbHelpers,
  xeInit,
  wbInterface,
  wbLocalization,
  wbNifScanner;

const
  cUnit = 'Dummy';
  cTwbVector = 'TwbVector';
  cTwbGridCell = 'TwbGridCell';


function Var2wbVector(const wbVector: Variant): TwbVector;
begin
  Result := TwbVector(V2R(wbVector)^);
end;

function Var2wbGridCell(const wbGridCell: Variant): TwbGridCell;
begin
  Result := TwbGridCell(V2R(wbGridCell)^);
end;

function wbGridCell2Var(const wbGridCell: TwbGridCell): Variant;
var
  Rec: ^TwbGridCell;
begin
  New(Rec);
  Rec^ := wbGridCell;
  Result := R2V(cTwbGridCell, Rec);
end;


{ wbContainerHandler }

procedure IwbContainerHandler_ResourceContainerList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  xeContext.ContainerHandler.ContainerList(TStrings(V2O(Args.Values[0])));
end;

procedure IwbContainerHandler_ResourceCopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  xeContext.ContainerHandler.ResourceCopy(Args.Values[0], Args.Values[1], Args.Values[2]);
end;

procedure IwbContainerHandler_ResourceCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeContext.ContainerHandler.ResourceCount(Args.Values[0], TStrings(V2O(Args.Values[1])));
end;

procedure IwbContainerHandler_ResourceExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeContext.ContainerHandler.ResourceExists(Args.Values[0]);
end;

procedure IwbContainerHandler_ResourceList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: xeContext.ContainerHandler.ContainerResourceList(Args.Values[0], TStrings(V2O(Args.Values[1])));
    3: xeContext.ContainerHandler.ContainerResourceList(Args.Values[0], TStrings(V2O(Args.Values[1])), string(Args.Values[2]));
    else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure IwbContainerHandler_ResourceOpenData(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeContext.ContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]);
end;

{ TwbAsset }

procedure TwbAsset_AssetTypeByExtension(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbAsset.AssetTypeByExtension(Args.Values[0]);
end;

procedure TwbAsset_AssetTypeByFolder(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbAsset.AssetTypeByFolder(Args.Values[0]);
end;

procedure TwbAsset_wbNormalizeResourceName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbAsset.GetAssetName(string(Args.Values[0]), '', Args.Values[1]);
end;


{ TwbFastStringList }

procedure TwbFastStringList_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbFastStringList.Create);
end;


{ Nif routines }

procedure NifUtils_NifBlockList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifBlockList(TBytes(Args.Values[0]), TStrings(V2O(Args.Values[1])));
end;

procedure NifUtils_NifTextureList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifTextures(TBytes(Args.Values[0]), TStrings(V2O(Args.Values[1])));
end;

procedure NifUtils_NifTextureListResource(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifTextures(xeContext.ContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]), TStrings(V2O(Args.Values[2])));
end;

procedure NifUtils_NifTextureListUVRange(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifTexturesUVRange(TBytes(Args.Values[0]), Single(Args.Values[1]), TStrings(V2O(Args.Values[2])));
end;


{ DDS routines }

procedure DDSUtils_wbDDSDataToBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDDSDataToBitmap(TBytes(Args.Values[0]), TBitmap(V2O(Args.Values[1])));
end;

procedure DDSUtils_wbDDSResourceToBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDDSDataToBitmap(xeContext.ContainerHandler.OpenResourceData('', Args.Values[0]), TBitmap(V2O(Args.Values[1])));
end;

procedure DDSUtils_wbDDSStreamToBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDDSStreamToBitmap(TStream(V2O(Args.Values[0])), TBitmap(V2O(Args.Values[1])));
end;


{ Misc routines }

procedure Misc_bscrc32(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbHash.BSCRC32(string(Args.Values[0]));
end;

procedure Misc_CreateHashFO4(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbHash.FO4(Args.Values[0]);
end;

procedure Misc_CreateHashTES3(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbHash.TES3(Args.Values[0]);
end;

procedure Misc_CreateHashTES4(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: Value := TwbHash.TES4(Args.Values[0], False);
   2: Value := TwbHash.TES4(Args.Values[0], Args.Values[1]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure Misc_LocalizationGetStringsFromFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if wbLocalizationHandler(xeContext) <> nil then
    wbLocalizationHandler(xeContext).GetStringsFromFile(string(Args.Values[0]), TStrings(V2O(Args.Values[1])));
end;

procedure Misc_wbAlphaBlend(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbAlphaBlend(
    Args.Values[0], // DestDC
    Args.Values[1], // X
    Args.Values[2], // Y
    Args.Values[3], // Width
    Args.Values[4], // Height
    Args.Values[5], // SrcDC
    Args.Values[6], // SrcX
    Args.Values[7], // SrcY
    Args.Values[8], // SrcWidth
    Args.Values[9], // SrcHeight
    Args.Values[10] // Alpha
  );
end;

procedure Misc_wbBlockFromSubBlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCell2Var(wbBlockFromSubBlock(Var2wbGridCell(Args.Values[0])));
end;

procedure Misc_wbCRC32Data(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbHash.CRC32(TBytes(Args.Values[0]));
end;

procedure Misc_wbCRC32File(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbHash.CRC32(string(Args.Values[0]));
end;

procedure Misc_wbCRC32Resource(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbHash.CRC32(xeContext.ContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]));
end;

// find REFR records in child groups by base record signatures
// that are not deleted or disabled
procedure Misc_wbFindREFRsByBase(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord          : IwbMainRecord;
  REFRs               : TDynMainRecords;
  i, Opt              : Integer;
  lst                 : TList;
  BaseSignatures      : string;
begin
  if not Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Exit;
  BaseSignatures := string(Args.Values[1]);
  Opt := Integer(Args.Values[2]);
  lst := TList(V2O(Args.Values[3]));
  if not Assigned(lst) then
    Exit;

  REFRs := wbGetSiblingRecords(MainRecord, wbStringToSignatures('REFR'), True);
  for i := Low(REFRs) to High(REFRs) do
    if  not ((Opt and 1 <> 0) and REFRs[i].IsDeleted)
    and not ((Opt and 2 <> 0) and REFRs[i].IsInitiallyDisabled)
    and not ((Opt and 4 <> 0) and REFRs[i].ElementExists['XESP'])
    then
      if Assigned(REFRs[i].BaseRecord) and (Pos(REFRs[i].BaseRecord.Signature, BaseSignatures) <> 0) then
        lst.Add(Pointer(REFRs[i]));
end;

procedure Misc_wbFlipBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbFlipBitmap(TBitmap(V2O((Args.Values[0]))), Integer(Args.Values[1]));
end;

procedure Misc_wbFormIDErrorCheckLock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbFormIDErrorCheckLock;
end;

procedure Misc_wbFormIDErrorCheckUnlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbFormIDErrorCheckUnlock;
end;

procedure Misc_wbGetSiblingRecords(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element             : IwbElement;
  Records             : TDynMainRecords;
  Overrides           : Boolean;
  i                   : Integer;
  lst                 : TList;
  sigs                : string;
begin
  if not Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Exit;
  sigs := string(Args.Values[1]);
  Overrides := Boolean(Args.Values[2]);
  lst := TList(V2O(Args.Values[3]));
  if not Assigned(lst) then
    Exit;

  Records := wbGetSiblingRecords(Element, wbStringToSignatures(sigs), Overrides);
  for i := Low(Records) to High(Records) do
    lst.Add(Pointer(Records[i]));
end;

procedure Misc_wbGridCellToGroupLabel(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCellToGroupLabel(Var2wbGridCell(Args.Values[0]));
end;

procedure Misc_wbIsInGridCell(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeContext.GameDefObj.IsInGridCell(Var2wbVector(Args.Values[0]), Var2wbGridCell(Args.Values[1]));
end;

procedure Misc_wbIsPseudoLightMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeContext.GameDefObj.IsLightSupported and xeContext.Settings.PseudoLight;
end;

procedure Misc_wbIsPseudoMediumMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := xeContext.GameDefObj.IsMediumSupported and xeContext.Settings.PseudoMedium;
end;

{procedure Misc_wbMD5Data(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbMD5Data(Args.Values[0]);
end;

procedure Misc_wbMD5File(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbMD5File(string(Args.Values[0]));
end;}

procedure Misc_wbPositionToGridCell(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCell2Var(xeContext.GameDefObj.PositionToGridCell(Var2wbVector(Args.Values[0])));
end;

{procedure Misc_wbSHA1Data(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbSHA1Data(Args.Values[0]);
end;

procedure Misc_wbSHA1File(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbSHA1File(string(Args.Values[0]));
end;}

procedure Misc_wbStringListInString(var Value: Variant; Args: TJvInterpreterArgs);
var
  sl: TStringList;
  s: string;
  i: integer;
begin
  Value := -1;
  sl := TStringList(V2O(Args.Values[0]));
  if not Assigned(sl) then
    Exit;
  s := string(Args.Values[1]);
  for i := 0 to Pred(sl.Count) do
    if Pos(Lowercase(sl[i]), Lowercase(s)) > 0 then begin
      Value := i;
      Exit;
    end;
end;

procedure Misc_wbSubBlockFromGridCell(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCell2Var(wbSubBlockFromGridCell(Var2wbGridCell(Args.Values[0])));
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { IwbContainerHandler }
    AddFunction(cUnit, 'ResourceContainerList', IwbContainerHandler_ResourceContainerList, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceCopy', IwbContainerHandler_ResourceCopy, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceCount', IwbContainerHandler_ResourceCount, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceExists', IwbContainerHandler_ResourceExists, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceList', IwbContainerHandler_ResourceList, -1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceOpenData', IwbContainerHandler_ResourceOpenData, 2, [varEmpty, varEmpty], varEmpty);

    { TwbAsset }
	AddFunction(cUnit, 'AssetTypeByExtension', TwbAsset_AssetTypeByExtension, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'AssetTypeByFolder', TwbAsset_AssetTypeByFolder, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbNormalizeResourceName', TwbAsset_wbNormalizeResourceName, 2, [varEmpty, varEmpty], varEmpty);
	
	{ IwbFastStringList }
    AddClass('TwbFastStringList', TwbFastStringList, 'TwbFastStringList');
    AddGet(TwbFastStringList, 'Create', TwbFastStringList_Create, 0, [varEmpty], varEmpty);

    { Nif routines }
    AddFunction(cUnit, 'NifBlockList', NifUtils_NifBlockList, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'NifTextureList', NifUtils_NifTextureList, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'NifTextureListResource', NifUtils_NifTextureListResource, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'NifTextureListUVRange', NifUtils_NifTextureListUVRange, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { DDS routines }
    AddFunction(cUnit, 'wbDDSDataToBitmap', DDSUtils_wbDDSDataToBitmap, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbDDSResourceToBitmap', DDSUtils_wbDDSResourceToBitmap, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbDDSStreamToBitmap', DDSUtils_wbDDSStreamToBitmap, 2, [varEmpty, varEmpty], varEmpty);

    { Misc routines }
    AddFunction(cUnit, 'bscrc32', Misc_bscrc32, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CreateHashFO4', Misc_CreateHashFO4, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CreateHashTES3', Misc_CreateHashTES3, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CreateHashTES4', Misc_CreateHashTES4, -1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'LocalizationGetStringsFromFile', Misc_LocalizationGetStringsFromFile, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbAlphaBlend', Misc_wbAlphaBlend, 11, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbBlockFromSubBlock', Misc_wbBlockFromSubBlock, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCRC32Data', Misc_wbCRC32Data, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCRC32File', Misc_wbCRC32File, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCRC32Resource', Misc_wbCRC32Resource, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFindREFRsByBase', Misc_wbFindRefrsByBase, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFlipBitmap', Misc_wbFlipBitmap, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFormIDErrorCheckLock', Misc_wbFormIDErrorCheckLock, 0, [], varEmpty);
    AddFunction(cUnit, 'wbFormIDErrorCheckUnlock', Misc_wbFormIDErrorCheckUnlock, 0, [], varEmpty);
    AddFunction(cUnit, 'wbGetSiblingRecords', Misc_wbGetSiblingRecords, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbGridCellToGroupLabel', Misc_wbGridCellToGroupLabel, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbIsInGridCell', Misc_wbIsInGridCell, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbIsPseudoESLMode', Misc_wbIsPseudoLightMode, 0, [], varEmpty);
    AddFunction(cUnit, 'wbIsPseudoLightMode', Misc_wbIsPseudoLightMode, 0, [], varEmpty);
    AddFunction(cUnit, 'wbIsPseudoMediumMode', Misc_wbIsPseudoMediumMode, 0, [], varEmpty);
    AddFunction(cUnit, 'wbIsPseudoSmallMode', Misc_wbIsPseudoLightMode, 0, [], varEmpty);
    //AddFunction(cUnit, 'wbMD5Data', Misc_wbMD5Data, 1, [varEmpty], varEmpty);
    //AddFunction(cUnit, 'wbMD5File', Misc_wbMD5File, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbPositionToGridCell', Misc_wbPositionToGridCell, 1, [varEmpty], varEmpty);
    //AddFunction(cUnit, 'wbSHA1Data', Misc_wbSHA1Data, 1, [varEmpty], varEmpty);
    //AddFunction(cUnit, 'wbSHA1File', Misc_wbSHA1File, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbStringListInString', Misc_wbStringListInString, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbSubBlockFromGridCell', Misc_wbSubBlockFromGridCell, 1, [varEmpty], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
