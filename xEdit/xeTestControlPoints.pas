{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeTestControlPoints;

{$I xeDefines.inc}

interface

uses
  VirtualTrees.BaseTree,
  VirtualTrees.Types,
  System.Actions,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.IniFiles,
  System.SysUtils,
  System.Classes,

  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Mask,
  Vcl.Menus,
  Vcl.StdCtrls,

  FileContainer,

  JvBalloonHint,
  JvComponentBase,

  SynMemo,

  VirtualTrees,
  VirtualEditTree,

  Winapi.ActiveX,
  Winapi.Messages,
  Winapi.Windows,

  wbDataFormat,
  wbHash,
  wbInterface,
  wbConflict,
  wbLoadOrder,
  wbModGroups,

  xeScriptHost,
  xeTestHost,
  xeMainForm;

type
  TxeTestFormHelper = class helper for TfrmMain
  public
    procedure TestFilterAnswerTimer(Sender: TObject);
    procedure TestViewModalAnswerTimer(Sender: TObject);
    procedure TestPumpStart;
    procedure TestPumpBrowseStep;
    procedure TestPumpEdidWalkStep;
    procedure TestPumpInitWalkStep;
    function TestPumpRefDigest: string;
    function TestPumpInside: Boolean;
    procedure TestPumpNote(const aText: string);
    procedure TestPumpSetCtrl(aDown: Boolean);
    procedure TestPumpTimerTimer(Sender: TObject);
    procedure TestPumpShortCutExecute(Sender: TObject);
    procedure TestMergeRunTimer(Sender: TObject);
    procedure TestMergeAnswerTimer(Sender: TObject);
    procedure TestMergeWrite;
    procedure TestMergedPatchRunTimer(Sender: TObject);
    procedure TestMergedPatchAnswerTimer(Sender: TObject);
    procedure TestMergedPatchReportTimer(Sender: TObject);
    procedure TestMergedPatchWrite;
    procedure TestCopyIntoRunTimer(Sender: TObject);
    procedure TestCopyIntoAnswerTimer(Sender: TObject);
    procedure TestCopyIntoWrite;
    procedure TestRenumberRunTimer(Sender: TObject);
    procedure TestRenumberAnswerTimer(Sender: TObject);
    procedure TestRenumberWrite;
    procedure TestChangeFormIDRunTimer(Sender: TObject);
    procedure TestChangeFormIDAnswerTimer(Sender: TObject);
    procedure TestChangeFormIDReportTimer(Sender: TObject);
    procedure TestChangeFormIDAfter(aLines: TStrings);
    procedure TestChangeFormIDNodes(aLines: TStrings);
    procedure TestChangeFormIDLocView(aLines: TStrings);
    procedure TestChangeFormIDViewAdd(aLines: TStrings);
    function TestRefByMenuItem: TMenuItem;
    procedure TestRefByShow(aLines: TStrings);
    procedure TestRefByRows(aLines: TStrings; const aWhen: string);
    procedure TestChangeFormIDSave;
    procedure TestChangeFormIDWrite;
    procedure TestChangeFormIDOnClose;
    procedure TestLoaderHoldAfterDone;
    procedure TestLoaderHoldRelease;
    procedure TestDeltaPatchStates(const aWhen: string);
    procedure TestDeltaPatchWrite;
    procedure TestDeltaPatchLoad(const aMaster: IwbFile);
    procedure TestDeltaPatchCancelTimer(Sender: TObject);
    procedure TestDeltaPatchSecondTimer(Sender: TObject);
    procedure TestHideRunTimer(Sender: TObject);
    procedure TestOptionsRunTimer(Sender: TObject);
    procedure TestOptionsAnswerTimer(Sender: TObject);
    procedure TestOptionsCloseTimerTimer(Sender: TObject);
    procedure TestCopyIntoGapRunTimer(Sender: TObject);
    procedure TestDropMasterRunTimer(Sender: TObject);
    procedure TestDropMasterAnswerTimer(Sender: TObject);
    function TestNavCopyLastPhase: Integer;
    procedure TestNavCopyPhaseTimer(Sender: TObject);
    procedure TestNavCopyAnswerTimer(Sender: TObject);
    procedure TestNavCopyBuild;
    procedure TestNavCopyLocateOnDisk;
    procedure TestNavCopyShowPairs;
    procedure TestNavCopyInject;
    procedure TestNavCopyCacheReport(const aWhen: string);
    procedure TestNavCopyCopy;
    procedure TestNavCopyVerify;
    procedure TestNavCopyPaintAll;
    procedure TestNavCopyCollect(const aPhase: string; aWithTruth: Boolean);
    procedure TestNavCopyFields(const aRecord: IwbMainRecord);
    procedure TestNavCopyWrite;
    procedure DoTestConflictsDump;
    procedure DoTestNavCopy;
    procedure DoTestViewText;
    procedure DoTestViewTree;
    procedure DoTestOptions;
    procedure DoTestCopyIntoGap;
    procedure DoTestNewFile;
    procedure DoTestNewFileReport(const aFailure: string = '');
    procedure DoTestGameLink;
    procedure TestGameLinkRunTimer(Sender: TObject);
    procedure TestGameLinkWrite(const aBody: string);
    procedure DoTestFormIDSearch;
    procedure TestFormIDSearchRunTimer(Sender: TObject);
    procedure TestFormIDSearchWrite(const aBody: string);
    procedure DoTestSplitTreeLOD;
    procedure DoTestDropMaster;
    procedure DoTestDeltaPatchStart;
    procedure DoTestDeltaPatchReport;
    procedure DoTestMerge;
    procedure DoTestMergedPatch;
    procedure DoTestCopyInto;
    procedure DoTestRenumber;
    procedure DoTestChangeFormID;
    procedure DoTestHide;
    procedure DoTestFilter;
    procedure TestFilterImages(aLines: TStrings);
    procedure DoTestSaveContextsCompare;
    procedure TestWriteStateManifest(const aTarget: IwbFile);
    procedure TestWriteStateManifestEnd;
    procedure TestWriteFileLists;
  end;

procedure TestSaveContextsReport(const aStage: string);

implementation

uses
  StateManifest,
  StateManifestValues,
  System.Diagnostics,
  System.Hash,
  System.IOUtils,
  System.Math,
  System.RegularExpressionsCore,
  System.Rtti,
  System.StrUtils,
{$IFDEF USE_PARALLEL_BUILD_REFS}
  System.SyncObjs,
  System.Threading,
{$ENDIF}
  System.TypInfo,
  System.Types,
{$IFNDEF VER220}
  System.UITypes,
{$ENDIF VER220}

  Vcl.CheckLst,
  Vcl.ClipBrd,
  Vcl.Styles,
  Vcl.Styles.Utils.SystemMenu,
  Vcl.Themes,

  Winapi.CommCtrl,
  Winapi.CommDlg,
  Winapi.Dlgs,
  Winapi.ShellAPI,
  Winapi.WinInet,

{$IFNDEF LiteVersion}
  cxVTEditors,
{$ENDIF}

  DDetours,

  ImagingTypes,

  JsonDataObjects,

  VTEditors,

  wbBetterStringList,
  wbBSA,
  wbDataFormatWwise,
  wbHardcoded,
  wbHelpers,
  wbImplementation,
  wbLOD,
  wbSort,

  xeDeveloperMessageForm,
  xeEditWarningForm,
  xeFilterOptionsForm,
  xeFileSelectForm,
  xeInit,
  xeLegendForm,
  xeLocalizePluginForm,
  xeLocalizationForm,
  xeLODGenForm,
  xeLogAnalyzerForm,
  xeModGroupEditForm,
  xeModGroupSelectForm,
  xeModuleSelectForm,
  xeOptionsForm,
  xeRichEditForm,
  xeScriptForm,
  xeTipForm,
  xeViewElementsForm,
  xeWorldspaceCellDetailsForm;

var
  _TestSaveContextsFiles    : TArray<IwbFile>;
  _TestSaveContextsContexts : TArray<Pointer>;

procedure TestSaveContextsReport(const aStage: string);

  function FileLabel(const aFile: IwbFile): string;
  begin
    if not Assigned(aFile) then
      Exit('nil');
    for var lIdx := Low(_TestSaveContextsFiles) to High(_TestSaveContextsFiles) do
      if _TestSaveContextsFiles[lIdx].Equals(aFile) then
        Exit(Chr(Ord('A') + lIdx));
    Result := aFile.FileName;
  end;

  function ContextLabel(aSaveContext: TwbSaveContext): string;
  begin
    if not Assigned(aSaveContext) then
      Exit('nil');
    var lIdx := High(_TestSaveContextsContexts);
    while (lIdx >= 0) and (_TestSaveContextsContexts[lIdx] <> Pointer(aSaveContext)) do
      Dec(lIdx);
    if lIdx < 0 then begin
      _TestSaveContextsContexts := _TestSaveContextsContexts + [Pointer(aSaveContext)];
      lIdx := High(_TestSaveContextsContexts);
    end;
    Result := 'SC' + IntToStr(Succ(lIdx));
  end;

  function ModuleText(const aFile: IwbFile): string;
  begin
    if Assigned(aFile.ModuleInfo) then
      Result := 'assigned ' + PwbModuleInfo(aFile.ModuleInfo).miOriginalName
    else
      Result := 'nil';
  end;

  function MastersText(const aFile: IwbFile): string;
  begin
    Result := '';
    for var lIdx := 0 to Pred(aFile.MasterCount[False]) do
      Result := Result + ' ' + FileLabel(aFile.Masters[lIdx, False]);
  end;

begin
  var lGameExeName := xeContext.GameDefObj.GameExeName;
  var lLines := TStringList.Create;
  try
    lLines.Add('[' + aStage + ']');
    if (aStage = 'LOAD-DONE') or (aStage = 'LOAD-ERROR') then begin
      _TestSaveContextsFiles := nil;
      for var lCompareLoad := False to True do
        for var lFile in frmMain.Files do
          if not wbIsModule(lFile.FileName, lGameExeName) and ((fsIsCompareLoad in lFile.FileStates) = lCompareLoad) then
            _TestSaveContextsFiles := _TestSaveContextsFiles + [lFile];
    end;
    lLines.Add('contextFiles=' + IntToStr(Length(xeContext.Files)));
    for var lFile in xeContext.Files do
      lLines.Add('  ' + FileLabel(lFile));
    for var lFile in _TestSaveContextsFiles do begin
      lLines.Add(Format('save %s: file=%s compareLoad=%s saveContext=%s module=%s', [FileLabel(lFile), lFile.FileName,
        BoolToStr(fsIsCompareLoad in lFile.FileStates, True), ContextLabel(lFile.SaveContextObj), ModuleText(lFile)]));
      if aStage <> 'AFTER-FORCECLOSEDFILES' then
        lLines.Add(Format('save %s masters:%s', [FileLabel(lFile), MastersText(lFile)]));
    end;
    if (aStage = 'LOAD-DONE') and (Length(_TestSaveContextsFiles) = 2) then begin
      var lA := _TestSaveContextsFiles[0];
      var lB := _TestSaveContextsFiles[1];
      lLines.Add('A and B share a save context=' + BoolToStr(lA.SaveContextObj = lB.SaveContextObj, True));
      lLines.Add('B compare master is A=' + BoolToStr((lB.MasterCount[False] > 0) and
        lB.Masters[Pred(lB.MasterCount[False]), False].Equals(lA), True));
      lLines.Add('B compareToFile=' + FileLabel(lB.CompareToFile));
    end;
    if aStage = 'AFTER-FORCECLOSEDFILES' then begin
      lLines.Add('exit reached');
      _TestSaveContextsFiles := nil;
    end;
    TFile.AppendAllText(xeTestSwitches.SaveContextsFile, lLines.Text);
  finally
    lLines.Free;
  end;
end;

procedure TxeTestFormHelper.DoTestSaveContextsCompare;
begin
  for var lIdx := High(Files) downto Low(Files) do
    if not wbIsModule(Files[lIdx].FileName, xeContext.GameDefObj.GameExeName) then begin
      DoCompareTo(Files[lIdx], xeTestSwitches.SaveContextsCompare);
      Exit;
    end;
  TestSaveContextsReport('NO-SAVE-LOADED');
  CheckResult := 255;
  tmrShutdown.Enabled := True;
end;

function xeCompareTestConflictRows(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := CompareStr(List[Index1], List[Index2]);
end;

procedure TxeTestFormHelper.DoTestConflictsDump;
const
  cTab = #9;
var
  lHeader, lData : TStringList;
  lFile          : IwbFile;
  lCompareTo     : IwbFile;
  lRec           : IwbMainRecord;
  lCA            : TConflictAll;
  lCT            : TConflictThis;
  i, j           : Integer;
  lTmpFile       : string;
  lEditorID      : string;
  lFields        : TStreamWriter;
  lFieldsTmp     : string;
  lFieldRows     : Integer;
  lChain         : TDynViewNodeDatas;
  lChainKey      : string;
  lOnField       : TFieldConflictProc;
begin
  try
    lHeader := TStringList.Create;
    try
      lData := TStringList.Create;
      try
        lHeader.Add('# xEdit conflict status dump');
        lHeader.Add('# ' + xeApplicationTitle);
        lHeader.Add('#');
        lHeader.Add('# Columns, tab separated:');
        lHeader.Add('#   load order / file / signature / load order FormID / local FormID /');
        lHeader.Add('#   EditorID / ConflictAll / ConflictThis');
        lHeader.Add('#   EditorID escapes backslash, tab, CR and LF as \\ \t \r \n');
        lHeader.Add('#');
        lHeader.Add('# ConflictAll is the aggregate over the whole override chain and ConflictThis');
        lHeader.Add('# belongs to this record alone. Neither reaches individual fields: the child');
        lHeader.Add('# walk keeps maxima, so a field can move while both of these stand still.');
        lHeader.Add('# An unchanged dump is evidence that nothing moved, not proof of it.');
        lHeader.Add('#');
        lHeader.Add('# Inputs that change what gets computed. A comparison is only meaningful');
        lHeader.Add('# between runs whose values here agree. manifestVersion says which set');
        lHeader.Add('# of inputs this dump was required to record; a reader compares a dump');
        lHeader.Add('# against its own version rather than against the current one.');
        lHeader.Add('#   manifestVersion      = 2');
        lHeader.Add('#   ModGroupsEnabled     = ' + BoolToStr(ConflictView.ModGroupsEnabled, True));
        lHeader.Add('#   OnlyShowMasterAndLeafs = ' + BoolToStr(ConflictView.OnlyMasterAndLeafs, True));
        lHeader.Add('#   wbAlignArrayElements = ' + BoolToStr(ConflictView.AlignArrayElements, True));
        lHeader.Add('#   wbAlignArrayLimit    = ' + IntToStr(ConflictView.AlignArrayLimit));
        lHeader.Add('#   wbBuildRefs          = ' + BoolToStr(xeContext.Settings.BuildRefs, True));
        lHeader.Add('#   wbCompareRawData     = ' + BoolToStr(xeContext.Settings.CompareRawData, True));
        lHeader.Add('#   wbTranslationMode    = ' + BoolToStr(xeContext.Settings.TranslationMode, True));
        lHeader.Add('#   wbLoadBSAs           = ' + BoolToStr(xeContext.Settings.LoadBSAs, True));
        lHeader.Add('#   wbLoaderDone         = ' + BoolToStr(xeContext.LoaderDone, True));
        lHeader.Add('#   xeQuickShowConflicts = ' + BoolToStr(xeQuickShowConflicts, True));
        lHeader.Add('#   wbActorTemplateHide  = ' + BoolToStr(wbActorTemplateHide, True));
        lHeader.Add('#   wbAllowInternalEdit  = ' + BoolToStr(xeContext.Settings.AllowInternalEdit, True));
        lHeader.Add('#   wbCanSortINFO        = ' + BoolToStr(gcCanSortINFO in xeContext.GameDefObj.Capabilities, True));
        lHeader.Add('#   wbDecodeTextureHashes = ' + BoolToStr(xeContext.GameDefObj.DefinedOptions.DecodeTextureHashes, True));
        lHeader.Add('#   wbDisplayLoadOrderFormID = ' + BoolToStr(wbDisplayLoadOrderFormID, True));
        lHeader.Add('#   wbDisplayShorterNames = ' + BoolToStr(wbDisplayShorterNames, True));
        lHeader.Add('#   wbEditAllowed        = ' + BoolToStr(xeContext.Settings.EditAllowed, True));
        lHeader.Add('#   wbFillINOA           = ' + BoolToStr(xeContext.Settings.FillINOA, True));
        lHeader.Add('#   wbFillINOM           = ' + BoolToStr(xeContext.Settings.FillINOM, True));
        lHeader.Add('#   wbFillPNAM           = ' + BoolToStr(xeContext.Settings.FillPNAM, True));
        lHeader.Add('#   wbFlagsAsArray       = ' + BoolToStr(xeContext.Settings.FlagsAsArray, True));
        lHeader.Add('#   wbHideIgnored        = ' + BoolToStr(xeContext.Settings.HideIgnored, True));
        lHeader.Add('#   wbHideLargeSubrecords = ' + BoolToStr(xeContext.GameDefObj.DefinedOptions.HideLargeSubrecords, True));
        lHeader.Add('#   wbHideNeverShow      = ' + BoolToStr(xeContext.Settings.HideNeverShow, True));
        lHeader.Add('#   wbHideUnused         = ' + BoolToStr(wbHideUnused, True));
        lHeader.Add('#   wbShowFlagEnumValue  = False');
        lHeader.Add('#   wbSimpleRecords      = ' + BoolToStr(xeContext.GameDefObj.DefinedOptions.SimpleRecords, True));
        lHeader.Add('#   wbSortFLST           = ' + BoolToStr(wbSortFLST, True));
        lHeader.Add('#   wbSortINFO           = ' + BoolToStr(xeContext.Settings.SortINFO, True));
        lHeader.Add('#   wbSortSubRecords     = ' + BoolToStr(xeContext.Settings.SortSubRecords, True));
        lHeader.Add('#');
        lHeader.Add('# Loaded modules, and for each one whether it carries a compare to file.');
        lHeader.Add('#');
        lHeader.Add('# sameMasters is the flag that decides whether the compare to identity branch');
        lHeader.Add('# can be taken at all, so it is the value worth reading here.');
        lHeader.Add('#');
        lHeader.Add('# The two master counts are read AFTER loading finished, and they are NOT the');
        lHeader.Add('# numbers the flag was computed from. The flag is decided while the file is');
        lHeader.Add('# being built, and a master added after that point still shows up here. So the');
        lHeader.Add('# counts below can disagree with the flag beside them without either being');
        lHeader.Add('# wrong, and they must not be read as its explanation. Observed on Oblivion:');
        lHeader.Add('# the hardcoded overlay reports one master here and sameMasters is still True,');
        lHeader.Add('# because it had none at the moment the comparison ran.');

        for i := Low(Files) to High(Files) do begin
          lFile := Files[i];
          lTmpFile := Format('#   %.3d %s mastersAfterLoad=%d', [lFile.LoadOrder, lFile.FileName,
                                                                 lFile.MasterCount[True]]);
          if fsIsHardcoded in lFile.FileStates then
            lTmpFile := lTmpFile + ' hardcoded';
          if fsIsGameMaster in lFile.FileStates then
            lTmpFile := lTmpFile + ' gamemaster';
          lCompareTo := lFile.CompareToFile;
          if Assigned(lCompareTo) then
            lTmpFile := lTmpFile + Format(' compareTo=%s compareToMastersAfterLoad=%d sameMasters=%s',
                                          [lCompareTo.FileName, lCompareTo.MasterCount[True],
                                           BoolToStr(fsCompareToHasSameMasters in lFile.FileStates, True)]);
          lHeader.Add(lTmpFile);
        end;
        lHeader.Add('#');

        lFields := nil;
        lOnField := nil;
        lFieldRows := 0;
        try
          if xeTestSwitches.ConflictsFieldsFile <> '' then begin
            lFieldsTmp := xeTestSwitches.ConflictsFieldsFile + '.partial';
            lFields := TStreamWriter.Create(lFieldsTmp, False, TEncoding.UTF8);
            lFields.WriteLine('# xEdit conflict status dump, fields');
            lFields.WriteLine('# ' + xeApplicationTitle);
            lFields.WriteLine('#');
            lFields.WriteLine('# Columns, tab separated:');
            lFields.WriteLine('#   load order FormID of the first record in the override chain / signature /');
            lFields.WriteLine('#   element path / ConflictAll of this element over the chain / load order /');
            lFields.WriteLine('#   file / ConflictThis of this file''s element');
            lFields.WriteLine('#   The path escapes tab, CR and LF as \t \r \n');
            lFields.WriteLine('#');
            lFields.WriteLine('# One row per element per file of the chain, in walk order: files in load');
            lFields.WriteLine('# order, records in file order, elements in tree order. A file whose record');
            lFields.WriteLine('# lacks the element still gets a row, carrying the verdict the comparison gave');
            lFields.WriteLine('# the missing element. Every chain of two or more records is walked, including');
            lFields.WriteLine('# a compare to pair the record dump reports as identical to master.');
            lFields.WriteLine('# The row count is the last line.');
            lFields.WriteLine('#');
            lOnField :=
              procedure(const aNodeDatas: TDynViewNodeDatas; aConflictAll: TConflictAll)
              var
                k        : Integer;
                lElement : IwbElement;
                lPath    : string;
                lMember  : IwbMainRecord;
                lWhere   : string;
              begin
                lElement := nil;
                for k := Low(aNodeDatas) to High(aNodeDatas) do
                  if Assigned(aNodeDatas[k].Element) then begin
                    lElement := aNodeDatas[k].Element;
                    Break;
                  end;
                if not Assigned(lElement) then
                  Exit;

                lPath := lElement.Path
                  .Replace(#9, '\t', [rfReplaceAll])
                  .Replace(#13, '\r', [rfReplaceAll])
                  .Replace(#10, '\n', [rfReplaceAll]);

                for k := Low(aNodeDatas) to High(aNodeDatas) do begin
                  if (k <= High(lChain)) and Supports(lChain[k].Element, IwbMainRecord, lMember) then
                    lWhere := Format('%.3d', [lMember._File.LoadOrder]) + cTab + lMember._File.FileName
                  else
                    lWhere := cTab;
                  lFields.WriteLine(lChainKey + lPath + cTab +
                                    wbNameConflictAll[aConflictAll] + cTab +
                                    lWhere + cTab +
                                    wbNameConflictThis[aNodeDatas[k].ConflictThis]);
                  Inc(lFieldRows);
                end;
              end;
          end;

          for i := Low(Files) to High(Files) do begin
            lFile := Files[i];
            wbProgress('[Test Conflicts] ' + lFile.FileName + ' (' + IntToStr(lFile.RecordCount) + ' records)');
            for j := 0 to Pred(lFile.RecordCount) do begin
              lRec := lFile.Records[j];
              if not Assigned(lRec) then
                Continue;

              ConflictLevelForMainRecord(lRec, lCA, lCT);

              if lRec.CanHaveEditorID then
                lEditorID := lRec.EditorID
                  .Replace('\', '\\', [rfReplaceAll])
                  .Replace(#9, '\t', [rfReplaceAll])
                  .Replace(#13, '\r', [rfReplaceAll])
                  .Replace(#10, '\n', [rfReplaceAll])
              else
                lEditorID := '';

              lData.Add(Format('%.3d', [lFile.LoadOrder]) + cTab +
                        lFile.FileName + cTab +
                        string(lRec.Signature) + cTab +
                        IntToHex(lRec.LoadOrderFormID.ToCardinal, 8) + cTab +
                        IntToHex(lRec.FormID.ToCardinal, 8) + cTab +
                        lEditorID + cTab +
                        wbNameConflictAll[lCA] + cTab +
                        wbNameConflictThis[lCT]);

              if Assigned(lFields) then begin
                lChain := NodeDatasForMainRecord(lRec);
                if (Length(lChain) > 1) and Assigned(lChain[0].Element) and lChain[0].Element.Equals(lRec) then begin
                  lChainKey := IntToHex(lRec.LoadOrderFormID.ToCardinal, 8) + cTab + string(lRec.Signature) + cTab;
                  ConflictLevelForChildNodeDatas(lChain, False,
                    lRec.MasterOrSelf.IsInjected and not ((lRec.Signature = 'GMST') or (lRec.Signature = 'DFOB')),
                    ConflictView,
                    procedure(const aMessage: string) begin PostAddMessage(aMessage); end,
                    lOnField);
                end;
              end;
            end;
          end;

          if Assigned(lFields) then begin
            lFields.WriteLine('# rows: ' + IntToStr(lFieldRows));
            FreeAndNil(lFields);
            if not MoveFileEx(PChar(lFieldsTmp), PChar(xeTestSwitches.ConflictsFieldsFile), MOVEFILE_REPLACE_EXISTING) then
              RaiseLastOSError;
            wbProgress('Test Conflicts fields: ' + IntToStr(lFieldRows) + ' rows written to ' + xeTestSwitches.ConflictsFieldsFile);
          end;
        finally
          lFields.Free;
        end;

        lData.CustomSort(xeCompareTestConflictRows);
        lHeader.Add('# rows: ' + IntToStr(lData.Count));
        lHeader.AddStrings(lData);

        lTmpFile := xeTestSwitches.ConflictsFile + '.partial';
        lHeader.SaveToFile(lTmpFile, TEncoding.UTF8);
        if not MoveFileEx(PChar(lTmpFile), PChar(xeTestSwitches.ConflictsFile), MOVEFILE_REPLACE_EXISTING) then
          RaiseLastOSError;

        wbProgress('Test Conflicts mode finished. ' + IntToStr(lData.Count) + ' rows written to ' +
                   xeTestSwitches.ConflictsFile);
      finally
        lData.Free;
      end;
    finally
      lHeader.Free;
    end;
  except
    on E: Exception do begin
      wbProgress('Test Conflicts mode FAILED: ' + E.ClassName + ': ' + E.Message);
      CheckResult := 255;
    end;
  end;
end;

procedure TxeTestFormHelper.DoTestNavCopy;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  TestHost.TestNavCopyRows := TStringList.Create;
  TestHost.TestNavCopyPhase := 0;
  TestHost.TestNavCopyTimer := TTimer.Create(Self);
  TestHost.TestNavCopyTimer.Interval := 1500;
  TestHost.TestNavCopyTimer.OnTimer := TestNavCopyPhaseTimer;
  TestHost.TestNavCopyTimer.Enabled := True;
end;

function TxeTestFormHelper.TestNavCopyLastPhase: Integer;
begin
  Result := 3;
  if xeTestSwitches.NavCopyInject then
    Inc(Result);
end;

procedure TxeTestFormHelper.TestNavCopyPhaseTimer(Sender: TObject);
begin
  TestHost.TestNavCopyTimer.Enabled := False;
  try
    Inc(TestHost.TestNavCopyPhase);
    if TestHost.TestNavCopyPhase = 1 then
      TestNavCopyBuild
    else if xeTestSwitches.NavCopyInject and (TestHost.TestNavCopyPhase = 2) then
      TestNavCopyInject
    else if TestHost.TestNavCopyPhase = Pred(TestNavCopyLastPhase) then
      TestNavCopyCopy
    else if TestHost.TestNavCopyPhase = TestNavCopyLastPhase then
      TestNavCopyVerify;
    if TestHost.TestNavCopyPhase < TestNavCopyLastPhase then
      TestHost.TestNavCopyTimer.Enabled := True
    else if xeAutoExit then
      tmrShutdown.Enabled := True;
  except
    on E: Exception do begin
      AddMessage(Format('[Test Nav Copy] FAILED in phase %d: %s: %s', [TestHost.TestNavCopyPhase, E.ClassName, E.Message]));
      CheckResult := 255;
      if xeAutoExit then
        tmrShutdown.Enabled := True;
    end;
  end;
end;

procedure TxeTestFormHelper.TestNavCopyAnswerTimer(Sender: TObject);
var
  lForm   : TCustomForm;
  lResult : TModalResult;
  lText   : string;
  lExtra  : string;

  function HasButton(aOwner: TComponent; aResult: TModalResult): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to Pred(aOwner.ComponentCount) do begin
      if (aOwner.Components[i] is TButton) and (TButton(aOwner.Components[i]).ModalResult = aResult) then
        Exit(True);
      if HasButton(aOwner.Components[i], aResult) then
        Exit(True);
    end;
  end;

  procedure CollectText(aOwner: TComponent);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

  function FindEdit(aOwner: TComponent): TEdit;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TEdit then
        Exit(TEdit(aOwner.Components[i]));
      Result := FindEdit(aOwner.Components[i]);
      if Assigned(Result) then
        Exit;
    end;
  end;

var
  lEdit : TEdit;
begin
  if (TestHost.TestNavCopyPhase = Pred(TestNavCopyLastPhase)) and not xeTestSwitches.NavCopyNoTouch then
    TestNavCopyPaintAll;
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then
    Exit;
  lResult := mrNone;
  lExtra := '';
  lText := '';
  CollectText(lForm);
  if lForm is TfrmModuleSelect then begin
    lResult := mrOk;
    if Assigned(TestHost.TestNavCopyFileA) then
      Include(PwbModuleInfo(TestHost.TestNavCopyFileA.ModuleInfo).miFlags, mfTagged);
    with TfrmModuleSelect(lForm) do
      lExtra := ' modules: ' + string.Join(' | ', AllModules.ToStrings(True)) + ' error: ' + pnlError.Caption;
  end else if lText.Contains('preserve ObjectIDs') and HasButton(lForm, mrNo) then
    lResult := mrNo
  else if string(lForm.Caption).StartsWith('Start from') and HasButton(lForm, mrOk) then begin
    lEdit := FindEdit(lForm);
    if Assigned(lEdit) then begin
      lExtra := ' offered: ' + lEdit.Text;
      if not TestHost.TestNavCopyStartGiven then begin
        lEdit.Text := xeTestSwitches.NavCopyStart;
        TestHost.TestNavCopyStartGiven := True;
      end;
      lExtra := lExtra + ' entered: ' + lEdit.Text;
    end;
    lResult := mrOk;
  end else if xeTestSwitches.NavCopyEach and HasButton(lForm, mrYes) then
    lResult := mrYes
  else if HasButton(lForm, mrYesToAll) then
    lResult := mrYesToAll
  else if HasButton(lForm, mrYes) then
    lResult := mrYes
  else if HasButton(lForm, mrOk) then
    lResult := mrOk;
  if lResult = mrNone then
    Exit;
  lText := lText.Replace(#13, ' ').Replace(#10, ' ');
  if Length(lText) > 300 then
    lText := Copy(lText, 1, 300) + '...';
  AddMessage(Format('[Test Nav Copy] answering "%s" (%s) with %d:%s%s', [lForm.Caption, lForm.ClassName, lResult, lText, lExtra]));
  lForm.ModalResult := lResult;
end;

procedure TxeTestFormHelper.TestNavCopyBuild;
var
  i           : Integer;
  lGameMaster : IwbFile;
  lGroup      : IwbContainerElementRef;
  lSource     : IwbMainRecord;
  lRecordA    : IwbMainRecord;
  lRecordB    : IwbMainRecord;
  lRecordC    : IwbMainRecord;
  lNode       : PVirtualNode;
begin
  if not xeContext.Settings.EditAllowed then
    raise Exception.Create('editing is not allowed in this run');

  lGameMaster := nil;
  for i := Low(Files) to High(Files) do
    if fsIsGameMaster in Files[i].FileStates then
      lGameMaster := Files[i];
  if not Assigned(lGameMaster) then
    raise Exception.Create('no game master is loaded');
  if not Supports(lGameMaster.GroupBySignature['QUST'], IwbContainerElementRef, lGroup) then
    raise Exception.Create('no QUST group in ' + lGameMaster.FileName);

  if xeTestSwitches.NavCopyDisk then begin
    TestNavCopyLocateOnDisk;
    Exit;
  end;

  if xeTestSwitches.NavCopyEsm then begin
    TestHost.TestNavCopyFileA := AddNewFileName('NavCopyA.esm', False, False);
    TestHost.TestNavCopyFileA.IsESM := True;
  end else
    TestHost.TestNavCopyFileA := AddNewFileName('NavCopyA.esp', False, False);
  TestHost.TestNavCopyFileA.AddMasterIfMissing(xeContext.GameDefObj.GameMasterEsm);
  TestHost.TestNavCopyFileB := AddNewFileName('NavCopyB.esp', False, False);
  TestHost.TestNavCopyFileB.AddMasterIfMissing(xeContext.GameDefObj.GameMasterEsm);
  TestHost.TestNavCopyFileB.AddMasterIfMissing(TestHost.TestNavCopyFileA.FileName);
  if xeTestSwitches.NavCopyTwo then
    TestHost.TestNavCopyFileC := TestHost.TestNavCopyFileB
  else begin
    TestHost.TestNavCopyFileC := AddNewFileName('NavCopyC.esp', False, False);
    TestHost.TestNavCopyFileC.AddMasterIfMissing(xeContext.GameDefObj.GameMasterEsm);
    TestHost.TestNavCopyFileC.AddMasterIfMissing(TestHost.TestNavCopyFileA.FileName);
  end;

  for i := 0 to Pred(lGroup.ElementCount) do begin
    if Length(TestHost.TestNavCopyRecordsA) >= xeTestSwitches.NavCopyCount then
      Break;
    if not Supports(lGroup.Elements[i], IwbMainRecord, lSource) then
      Continue;
    if not lSource.CanCopy or not Assigned(lSource.ElementBySignature['FULL']) then
      Continue;
    lRecordA := TestHost.TestNavCopyFileA.AddCopy(lSource, [cfAsNew, cfDeepCopy], wbNoCopyRules) as IwbMainRecord;
    if not Assigned(lRecordA) then
      Continue;
    lRecordB := TestHost.TestNavCopyFileB.AddCopy(lRecordA, [cfDeepCopy], wbNoCopyRules) as IwbMainRecord;
    if not Assigned(lRecordB) then
      raise Exception.Create('no override of ' + lRecordA.Name + ' was created');
    lRecordB.ElementEditValues['FULL'] := lRecordB.ElementEditValues['FULL'] + ' (B)';
    if Assigned(lRecordB.ElementByPath['DATA - General\Priority']) then
      lRecordB.ElementNativeValues['DATA - General\Priority'] := (Integer(lRecordB.ElementNativeValues['DATA - General\Priority']) + 1) and $FF;
    if xeTestSwitches.NavCopyTwo then
      lRecordC := lRecordB
    else begin
      lRecordC := TestHost.TestNavCopyFileC.AddCopy(lRecordA, [cfDeepCopy], wbNoCopyRules) as IwbMainRecord;
      if not Assigned(lRecordC) then
        raise Exception.Create('no second override of ' + lRecordA.Name + ' was created');
      lRecordC.ElementEditValues['FULL'] := lRecordC.ElementEditValues['FULL'] + ' (C)';
      if Assigned(lRecordC.ElementByPath['DATA - General\Priority']) then
        lRecordC.ElementNativeValues['DATA - General\Priority'] := (Integer(lRecordC.ElementNativeValues['DATA - General\Priority']) + 2) and $FF;
    end;
    SetLength(TestHost.TestNavCopyRecordsA, Succ(Length(TestHost.TestNavCopyRecordsA)));
    TestHost.TestNavCopyRecordsA[High(TestHost.TestNavCopyRecordsA)] := lRecordA;
    SetLength(TestHost.TestNavCopyRecordsB, Succ(Length(TestHost.TestNavCopyRecordsB)));
    TestHost.TestNavCopyRecordsB[High(TestHost.TestNavCopyRecordsB)] := lRecordB;
    SetLength(TestHost.TestNavCopyRecordsC, Succ(Length(TestHost.TestNavCopyRecordsC)));
    TestHost.TestNavCopyRecordsC[High(TestHost.TestNavCopyRecordsC)] := lRecordC;
  end;
  if Length(TestHost.TestNavCopyRecordsA) < 1 then
    raise Exception.Create('no QUST record could be copied from ' + lGameMaster.FileName);

  for i := Low(TestHost.TestNavCopyRecordsA) to High(TestHost.TestNavCopyRecordsA) do begin
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsA[i]);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + TestHost.TestNavCopyRecordsA[i].Name);
    vstNav.FullyVisible[lNode] := True;
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsB[i]);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + TestHost.TestNavCopyRecordsB[i].Name);
    vstNav.FullyVisible[lNode] := True;
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsC[i]);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + TestHost.TestNavCopyRecordsC[i].Name);
    vstNav.FullyVisible[lNode] := True;
    if i = 0 then
      vstNav.FocusedNode := lNode;
  end;
  AddMessage(Format('[Test Nav Copy] %d QUST records copied as new into %s and overridden with a changed FULL and priority in %s and again in %s',
    [Length(TestHost.TestNavCopyRecordsA), TestHost.TestNavCopyFileA.FileName, TestHost.TestNavCopyFileB.FileName, TestHost.TestNavCopyFileC.FileName]));
  if xeTestSwitches.NavCopySave then begin
    xeContext.Settings.DontSave := False;
    AddMessage('[Test Nav Copy] the fixture will be saved on shutdown; no copy in this run');
    CheckResult := 0;
    TestNavCopyWrite;
    TestHost.TestNavCopyPhase := TestNavCopyLastPhase;
  end;
end;

procedure TxeTestFormHelper.TestNavCopyLocateOnDisk;
var
  i        : Integer;
  lGroup   : IwbContainerElementRef;
  lRecordA : IwbMainRecord;
  lRecordB : IwbMainRecord;
begin
  for i := Low(Files) to High(Files) do
    if SameText(Files[i].FileName, xeTestSwitches.NavCopyMaster) then
      TestHost.TestNavCopyFileA := Files[i]
    else if SameText(Files[i].FileName, xeTestSwitches.NavCopyPlugin) then
      TestHost.TestNavCopyFileB := Files[i];
  if not Assigned(TestHost.TestNavCopyFileA) or not Assigned(TestHost.TestNavCopyFileB) then
    raise Exception.Create(xeTestSwitches.NavCopyMaster + ' and ' + xeTestSwitches.NavCopyPlugin + ' must both be loaded');
  TestHost.TestNavCopyFileC := TestHost.TestNavCopyFileB;
  if xeTestSwitches.NavCopyNew then begin
    var lLayout := xeContext.SlotLayout;
    for i := 0 to Pred(TestHost.TestNavCopyFileB.RecordCount) do begin
      if Length(TestHost.TestNavCopyRecordsB) >= xeTestSwitches.NavCopyCount then
        Break;
      lRecordB := TestHost.TestNavCopyFileB.Records[i];
      if not SameText(string(lRecordB.Signature), xeTestSwitches.NavCopySignature) or
         (lRecordB.LoadOrderFormID.FileID[lLayout] <> TestHost.TestNavCopyFileB.LoadOrderFileID) then
        Continue;
      SetLength(TestHost.TestNavCopyRecordsA, Succ(Length(TestHost.TestNavCopyRecordsA)));
      TestHost.TestNavCopyRecordsA[High(TestHost.TestNavCopyRecordsA)] := lRecordB;
      SetLength(TestHost.TestNavCopyRecordsB, Succ(Length(TestHost.TestNavCopyRecordsB)));
      TestHost.TestNavCopyRecordsB[High(TestHost.TestNavCopyRecordsB)] := lRecordB;
      SetLength(TestHost.TestNavCopyRecordsC, Succ(Length(TestHost.TestNavCopyRecordsC)));
      TestHost.TestNavCopyRecordsC[High(TestHost.TestNavCopyRecordsC)] := lRecordB;
      AddMessage(Format('[Test Nav Copy] new record %s', [lRecordB.Name]));
    end;
    if Length(TestHost.TestNavCopyRecordsB) < 1 then
      raise Exception.Create('no new ' + xeTestSwitches.NavCopySignature + ' record in ' + TestHost.TestNavCopyFileB.FileName);
    TestNavCopyShowPairs;
    AddMessage(Format('[Test Nav Copy] %d new %s records of %s loaded from disk, to be copied as override into %s',
      [Length(TestHost.TestNavCopyRecordsB), xeTestSwitches.NavCopySignature, TestHost.TestNavCopyFileB.FileName, TestHost.TestNavCopyFileA.FileName]));
    Exit;
  end;
  if not Supports(TestHost.TestNavCopyFileA.GroupBySignature[StrToSignature(xeTestSwitches.NavCopySignature)], IwbContainerElementRef, lGroup) then
    raise Exception.Create('no ' + xeTestSwitches.NavCopySignature + ' group in ' + TestHost.TestNavCopyFileA.FileName);
  for i := 0 to Pred(lGroup.ElementCount) do begin
    if Length(TestHost.TestNavCopyRecordsA) >= xeTestSwitches.NavCopyCount then
      Break;
    if not Supports(lGroup.Elements[i], IwbMainRecord, lRecordA) then
      Continue;
    lRecordB := TestHost.TestNavCopyFileB.ContainedRecordByLoadOrderFormID[lRecordA.LoadOrderFormID, False];
    if not Assigned(lRecordB) then
      Continue;
    SetLength(TestHost.TestNavCopyRecordsA, Succ(Length(TestHost.TestNavCopyRecordsA)));
    TestHost.TestNavCopyRecordsA[High(TestHost.TestNavCopyRecordsA)] := lRecordA;
    SetLength(TestHost.TestNavCopyRecordsB, Succ(Length(TestHost.TestNavCopyRecordsB)));
    TestHost.TestNavCopyRecordsB[High(TestHost.TestNavCopyRecordsB)] := lRecordB;
    SetLength(TestHost.TestNavCopyRecordsC, Succ(Length(TestHost.TestNavCopyRecordsC)));
    TestHost.TestNavCopyRecordsC[High(TestHost.TestNavCopyRecordsC)] := lRecordB;
  end;
  if Length(TestHost.TestNavCopyRecordsA) < 1 then
    raise Exception.Create('no record of ' + TestHost.TestNavCopyFileA.FileName + ' is overridden by ' + TestHost.TestNavCopyFileB.FileName);
  TestNavCopyShowPairs;
  AddMessage(Format('[Test Nav Copy] %d QUST records of %s loaded from disk are overridden by %s loaded from disk',
    [Length(TestHost.TestNavCopyRecordsA), TestHost.TestNavCopyFileA.FileName, TestHost.TestNavCopyFileB.FileName]));
end;

procedure TxeTestFormHelper.TestNavCopyShowPairs;
var
  i     : Integer;
  lNode : PVirtualNode;
begin
  for i := Low(TestHost.TestNavCopyRecordsA) to High(TestHost.TestNavCopyRecordsA) do begin
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsA[i]);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + TestHost.TestNavCopyRecordsA[i].Name);
    vstNav.FullyVisible[lNode] := True;
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsB[i]);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + TestHost.TestNavCopyRecordsB[i].Name);
    vstNav.FullyVisible[lNode] := True;
    if i = 0 then
      vstNav.FocusedNode := lNode;
  end;
end;

procedure TxeTestFormHelper.TestNavCopyInject;
var
  lNode   : PVirtualNode;
  lBefore : Integer;
  lAfter  : Integer;

  function OwnRecords(const aFile: IwbFile): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    var lLayout := xeContext.SlotLayout;
    for i := 0 to Pred(aFile.RecordCount) do
      if aFile.Records[i].LoadOrderFormID.FileID[lLayout] = aFile.LoadOrderFileID then
        Inc(Result);
  end;

begin
  lNode := FindNodeForElement(TestHost.TestNavCopyFileB);
  if not Assigned(lNode) then
    raise Exception.Create('no nav node for ' + TestHost.TestNavCopyFileB.FileName);
  vstNav.ClearSelection;
  vstNav.Selected[lNode] := True;
  vstNav.FocusedNode := lNode;
  lBefore := OwnRecords(TestHost.TestNavCopyFileB);
  AddMessage(Format('[Test Nav Copy] injecting the %d own records of %s into %s through Inject Forms into master, start FormID %s, ObjectIDs not preserved',
    [lBefore, TestHost.TestNavCopyFileB.FileName, TestHost.TestNavCopyFileA.FileName, xeTestSwitches.NavCopyStart]));
  mniNavRenumberFormIDsFromClick(mniNavRenumberFormIDsInject);
  lAfter := OwnRecords(TestHost.TestNavCopyFileB);
  AddMessage(Format('[Test Nav Copy] inject returned; %s has %d own records now, %d before', [TestHost.TestNavCopyFileB.FileName, lAfter, lBefore]));
  if (lBefore > 0) and (lAfter = lBefore) then begin
    AddMessage('[Test Nav Copy] NO VERDICT: the inject changed no FormID');
    CheckResult := 2;
    TestNavCopyWrite;
    TestHost.TestNavCopyPhase := TestNavCopyLastPhase;
    Exit;
  end;
  vstNav.Expanded[lNode] := True;
  TestNavCopyShowPairs;
end;

procedure TestNavCopyProgress(const s: string);
begin
  if Assigned(frmMain) then
    frmMain.TestNavCopyPaintAll;
  GeneralProgress(s);
end;

procedure TxeTestFormHelper.TestNavCopyCopy;
var
  i          : Integer;
  lNode      : PVirtualNode;
  lModified  : Integer;
begin
  TestNavCopyPaintAll;
  TestNavCopyCollect('pre', False);
  if (TestHost.TestNavCopyControlMisses > 0) and not xeTestSwitches.NavCopyNew then begin
    AddMessage(Format('[Test Nav Copy] NO VERDICT: %d of %d overriding nodes did not show a conflict before the copy',
      [TestHost.TestNavCopyControlMisses, Length(TestHost.TestNavCopyRecordsC)]));
    CheckResult := 2;
    TestNavCopyWrite;
    TestHost.TestNavCopyPhase := TestNavCopyLastPhase;
    Exit;
  end;

  vstNav.ClearSelection;
  for i := Low(TestHost.TestNavCopyRecordsC) to High(TestHost.TestNavCopyRecordsC) do begin
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsC[i]);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + TestHost.TestNavCopyRecordsC[i].Name);
    vstNav.Selected[lNode] := True;
    if i = 0 then
      vstNav.FocusedNode := lNode;
  end;

  SetLength(_PreviousCopyIntoSelectedModules, 1);
  _PreviousCopyIntoSelectedModules[0] := PwbModuleInfo(TestHost.TestNavCopyFileA.ModuleInfo);
  var lItem := mniNavCopyAsOverrideWithOverwrite;
  if xeTestSwitches.NavCopyNew then
    lItem := mniNavCopyAsOverride;
  AddMessage(Format('[Test Nav Copy] copying the %d selected records of %s through "%s" into %s, painting every nav node at each progress call',
    [Length(TestHost.TestNavCopyRecordsC), TestHost.TestNavCopyFileC.FileName, StripHotkey(lItem.Caption), TestHost.TestNavCopyFileA.FileName]));
  if not xeTestSwitches.NavCopyNoTouch then
    _wbProgressCallback := TestNavCopyProgress;
  try
    mniNavCopyIntoClick(lItem);
  finally
    _wbProgressCallback := GeneralProgress;
  end;

  lModified := 0;
  if xeTestSwitches.NavCopyNew then begin
    for i := Low(TestHost.TestNavCopyRecordsC) to High(TestHost.TestNavCopyRecordsC) do begin
      var lCopy := TestHost.TestNavCopyFileA.ContainedRecordByLoadOrderFormID[TestHost.TestNavCopyRecordsC[i].LoadOrderFormID, False];
      if Assigned(lCopy) then begin
        TestHost.TestNavCopyRecordsA[i] := lCopy;
        Inc(lModified);
      end;
    end;
    AddMessage(Format('[Test Nav Copy] copy returned; %d of %d records now exist in %s', [lModified, Length(TestHost.TestNavCopyRecordsA), TestHost.TestNavCopyFileA.FileName]));
  end else begin
    for i := Low(TestHost.TestNavCopyRecordsA) to High(TestHost.TestNavCopyRecordsA) do
      if TestHost.TestNavCopyRecordsA[i].ElementEditValues['FULL'] = TestHost.TestNavCopyRecordsC[i].ElementEditValues['FULL'] then
        Inc(lModified);
    AddMessage(Format('[Test Nav Copy] copy returned; %d of %d records in %s now carry the FULL of their override', [lModified, Length(TestHost.TestNavCopyRecordsA), TestHost.TestNavCopyFileA.FileName]));
  end;
  TestNavCopyCacheReport('after the copy returned');
  if lModified < Length(TestHost.TestNavCopyRecordsA) then begin
    AddMessage('[Test Nav Copy] NO VERDICT: the copy did not reach every record');
    CheckResult := 2;
    TestNavCopyWrite;
    TestHost.TestNavCopyPhase := TestNavCopyLastPhase;
  end;
end;

procedure TxeTestFormHelper.TestNavCopyCacheReport(const aWhen: string);
var
  i        : Integer;
  lNode    : PVirtualNode;
  lNodeCA  : string;
  lRecord  : IwbMainRecord;
  lCA, lMasterCA : TConflictAll;
  lCT, lMasterCT : TConflictThis;

  function SortedFlags(const aRecord: IwbMainRecord): string;
  var
    lPath     : string;
    lSortable : IwbSortableContainer;
  begin
    Result := '';
    for lPath in ['VMAD - Virtual Machine Adapter\Scripts', 'Aliases'] do
      if Supports(aRecord.ElementByPath[lPath], IwbSortableContainer, lSortable) then
        Result := Result + ' ' + lPath.Substring(lPath.LastIndexOf('\') + 1) + '=' + BoolToStr(lSortable.Sorted, True) +
          '/' + IntToStr(lSortable.ElementCount) + '/' + BoolToStr(lSortable.Sorted, True)
      else
        Result := Result + ' ' + lPath.Substring(lPath.LastIndexOf('\') + 1) + '=none';
  end;

begin
  AddMessage(Format('[Test Nav Copy] record caches %s: wbCopyIsRunning=%d', [aWhen, wbCopyIsRunning]));
  for i := Low(TestHost.TestNavCopyRecordsC) to High(TestHost.TestNavCopyRecordsC) do begin
    lRecord := TestHost.TestNavCopyRecordsC[i];
    lNode := FindNodeForElement(lRecord);
    if Assigned(lNode) then
      lNodeCA := wbNameConflictAll[PNavNodeData(vstNav.GetNodeData(lNode)).ConflictAll] + ' gen ' + IntToStr(PNavNodeData(vstNav.GetNodeData(lNode)).ElementGen)
    else
      lNodeCA := 'no node';
    ConflictView.Peek(lRecord, lCA, lCT);
    ConflictView.Peek(TestHost.TestNavCopyRecordsA[i], lMasterCA, lMasterCT);
    AddMessage(Format('[Test Nav Copy]   %s: record %s / %s gen %d sorted%s; master %s / %s gen %d sorted%s; node %s',
      [lRecord.EditorID, wbNameConflictAll[lCA], wbNameConflictThis[lCT], lRecord.ElementGeneration, SortedFlags(lRecord),
       wbNameConflictAll[lMasterCA], wbNameConflictThis[lMasterCT], TestHost.TestNavCopyRecordsA[i].ElementGeneration, SortedFlags(TestHost.TestNavCopyRecordsA[i]),
       lNodeCA]));
  end;
end;

procedure TxeTestFormHelper.TestNavCopyVerify;
var
  lNode  : PVirtualNode;
  lImage : Vcl.Graphics.TBitmap;
begin
  TestNavCopyCacheReport('before the post paint');
  if xeTestSwitches.NavCopyNoTouch then begin
    lNode := FindNodeForElement(TestHost.TestNavCopyRecordsC[0]);
    if Assigned(lNode) then begin
      vstNav.ScrollIntoView(lNode, True);
      vstNav.Repaint;
    end;
    DoProcessMessages;
    lImage := GetFormImage;
    try
      lImage.SaveToFile(ChangeFileExt(xeTestSwitches.NavCopyFile, '.bmp'));
    finally
      lImage.Free;
    end;
    AddMessage('[Test Nav Copy] no explicit paint after the copy; the form image is ' + ChangeFileExt(xeTestSwitches.NavCopyFile, '.bmp'));
  end else
    TestNavCopyPaintAll;
  TestNavCopyCollect('post', True);
  if TestHost.TestNavCopyStale > 0 then
    CheckResult := 1
  else
    CheckResult := 0;
  AddMessage(Format('[Test Nav Copy] %d STALE, %d WOULD-REFRESH nav nodes after the copy', [TestHost.TestNavCopyStale, TestHost.TestNavCopyWouldRefresh]));
  TestNavCopyWrite;
end;

procedure TxeTestFormHelper.TestNavCopyPaintAll;
var
  lNode   : PVirtualNode;
  lColor  : TColor;
  lAction : TItemEraseAction;
begin
  lNode := vstNav.GetFirstInitialized;
  while Assigned(lNode) do begin
    lColor := clNone;
    lAction := eaDefault;
    vstNavBeforeItemErase(vstNav, vstNav.Canvas, lNode, Default(TRect), lColor, lAction);
    lNode := vstNav.GetNextInitialized(lNode);
  end;
end;

procedure TxeTestFormHelper.TestNavCopyCollect(const aPhase: string; aWithTruth: Boolean);
const
  cTab = #9;
var
  lNode     : PVirtualNode;
  lNodeData : PNavNodeData;
  lRecord   : IwbMainRecord;
  lRecords  : TDynMainRecords;
  lNodes    : TNodeArray;
  lGens     : TArray<Integer>;
  i         : Integer;
  lCA       : TConflictAll;
  lCT       : TConflictThis;
  lRow      : string;
  lVerdict  : string;
begin
  lNode := vstNav.GetFirstInitialized;
  while Assigned(lNode) do begin
    lNodeData := vstNav.GetNodeData(lNode);
    if Assigned(lNodeData) and Supports(lNodeData.Element, IwbMainRecord, lRecord) and (lRecord.Signature <> xeContext.GameDefObj.HeaderSignature) then
      if lRecord._File.Equals(TestHost.TestNavCopyFileA) or lRecord._File.Equals(TestHost.TestNavCopyFileB) or lRecord._File.Equals(TestHost.TestNavCopyFileC) then begin
        SetLength(lNodes, Succ(Length(lNodes)));
        lNodes[High(lNodes)] := lNode;
        SetLength(lRecords, Succ(Length(lRecords)));
        lRecords[High(lRecords)] := lRecord;
        SetLength(lGens, Succ(Length(lGens)));
        lGens[High(lGens)] := lRecord.ElementGeneration;
      end;
    lNode := vstNav.GetNextInitialized(lNode);
  end;

  if aWithTruth then
    for i := Low(lRecords) to High(lRecords) do
      lRecords[i].ResetConflict;

  for i := Low(lRecords) to High(lRecords) do begin
    lNodeData := vstNav.GetNodeData(lNodes[i]);
    lRecord := lRecords[i];
    lRow := aPhase + cTab +
            lRecord._File.FileName + cTab +
            string(lRecord.Signature) + cTab +
            IntToHex(lRecord.LoadOrderFormID.ToCardinal, 8) + cTab +
            lRecord.EditorID + cTab +
            wbNameConflictAll[lNodeData.ConflictAll] + cTab +
            wbNameConflictThis[lNodeData.ConflictThis] + cTab +
            IntToStr(lNodeData.ElementGen) + cTab +
            IntToStr(lGens[i]);
    if aWithTruth then begin
      ConflictLevelForMainRecord(lRecord, lCA, lCT);
      if lRecord._File.Equals(TestHost.TestNavCopyFileC) then begin
        var lCA2: TConflictAll;
        var lCT2: TConflictThis;
        lRecord.ResetConflict;
        ConflictLevelForMainRecord(lRecord, lCA2, lCT2);
        if (lCA2 <> lCA) or (lCT2 <> lCT) then
          AddMessage(Format('[Test Nav Copy] SECOND fresh computation differs for %s: first %s / %s, second %s / %s',
            [lRecord.EditorID, wbNameConflictAll[lCA], wbNameConflictThis[lCT], wbNameConflictAll[lCA2], wbNameConflictThis[lCT2]]));
        lCA := lCA2;
        lCT := lCT2;
      end;
      if (lCA = lNodeData.ConflictAll) and (lCT = lNodeData.ConflictThis) then
        lVerdict := 'OK'
      else if lNodeData.ConflictAll = caUnknown then begin
        lVerdict := 'UNPAINTED';
        Inc(TestHost.TestNavCopyWouldRefresh);
      end else if lNodeData.ElementGen = lGens[i] then begin
        lVerdict := 'STALE';
        Inc(TestHost.TestNavCopyStale);
      end else begin
        lVerdict := 'WOULD-REFRESH';
        Inc(TestHost.TestNavCopyWouldRefresh);
      end;
      lRow := lRow + cTab + wbNameConflictAll[lCA] + cTab + wbNameConflictThis[lCT] + cTab + lVerdict;
      if lRecord._File.Equals(TestHost.TestNavCopyFileC) and (lCT <> ctIdenticalToMaster) then
        TestNavCopyFields(lRecord);
    end else
      if lRecord._File.Equals(TestHost.TestNavCopyFileC) and
         ((lNodeData.ConflictAll <= caNoConflict) or (lNodeData.ConflictThis = ctIdenticalToMaster)) then
        Inc(TestHost.TestNavCopyControlMisses);
    TestHost.TestNavCopyRows.Add(lRow);
  end;
  AddMessage(Format('[Test Nav Copy] %s: %d nav nodes recorded', [aPhase, Length(lRecords)]));
end;

procedure TxeTestFormHelper.TestNavCopyFields(const aRecord: IwbMainRecord);
const
  cTab = #9;
var
  lChain : TDynViewNodeDatas;
  lKey   : string;
begin
  lChain := NodeDatasForMainRecord(aRecord);
  if Length(lChain) < 2 then
    Exit;
  lKey := 'field' + cTab + aRecord._File.FileName + cTab + IntToHex(aRecord.LoadOrderFormID.ToCardinal, 8) + cTab;
  ConflictLevelForChildNodeDatas(lChain, False,
    aRecord.MasterOrSelf.IsInjected and not ((aRecord.Signature = 'GMST') or (aRecord.Signature = 'DFOB')),
    ConflictView,
    procedure(const aMessage: string) begin PostAddMessage(aMessage); end,
    procedure(const aNodeDatas: TDynViewNodeDatas; aConflictAll: TConflictAll)
    var
      k        : Integer;
      lElement : IwbElement;
    begin
      lElement := nil;
      for k := Low(aNodeDatas) to High(aNodeDatas) do
        if Assigned(aNodeDatas[k].Element) then begin
          lElement := aNodeDatas[k].Element;
          Break;
        end;
      if not Assigned(lElement) then
        Exit;
      for k := Low(aNodeDatas) to High(aNodeDatas) do
        if (k <= High(lChain)) and Assigned(lChain[k].Element) and lChain[k].Element.Equals(aRecord) then
          if aNodeDatas[k].ConflictThis > ctIdenticalToMaster then
            TestHost.TestNavCopyRows.Add(lKey + lElement.Path.Replace(#9, '\t', [rfReplaceAll]) + cTab +
              wbNameConflictAll[aConflictAll] + cTab + wbNameConflictThis[aNodeDatas[k].ConflictThis]);
    end);
end;

procedure TxeTestFormHelper.TestNavCopyWrite;
var
  lLines : TStringList;
  lTmp   : string;
begin
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit nav tree copy probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('#');
    lLines.Add('# Columns, tab separated: phase / file / signature / load order FormID / EditorID /');
    lLines.Add('#   node ConflictAll / node ConflictThis / node ElementGen / record ElementGeneration');
    lLines.Add('#   post rows add: fresh ConflictAll / fresh ConflictThis / verdict');
    lLines.Add('# STALE = the node shows a verdict a fresh computation contradicts and its generation');
    lLines.Add('#   equals the record''s, so a repaint would not recompute it.');
    lLines.Add('# WOULD-REFRESH = the node is wrong but its generation differs, so a repaint recomputes it;');
    lLines.Add('#   UNPAINTED = the node holds no verdict yet (never painted since its last reset), so a paint computes it.');
    lLines.Add('#');
    lLines.Add('# controlMisses = ' + IntToStr(TestHost.TestNavCopyControlMisses));
    lLines.Add('# stale = ' + IntToStr(TestHost.TestNavCopyStale));
    lLines.Add('# wouldRefresh = ' + IntToStr(TestHost.TestNavCopyWouldRefresh));
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lLines.AddStrings(TestHost.TestNavCopyRows);
    lTmp := xeTestSwitches.NavCopyFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.NavCopyFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
    AddMessage(Format('[Test Nav Copy] %d rows written to %s', [TestHost.TestNavCopyRows.Count, xeTestSwitches.NavCopyFile]));
  finally
    lLines.Free;
  end;
end;

procedure TxeTestFormHelper.DoTestViewText;
var
  lRecord : IwbMainRecord;
  lLines  : TStringList;
  lTmp    : string;
begin
  lRecord := nil;
  var lFormID := TwbFormID.FromStr(xeTestSwitches.ViewTextRecord);
  for var i := High(Files) downto Low(Files) do begin
    lRecord := Files[i].RecordByFormID[lFormID, True, True];
    if Assigned(lRecord) then
      Break;
  end;
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit view text probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# showFlagEnumValue = ' + BoolToStr(ShowFlagEnumValue, True));
    lLines.Add('# record = ' + xeTestSwitches.ViewTextRecord);
    lLines.Add('# Columns, tab separated: indented name / per record column: cell text, edit text');
    if not Assigned(lRecord) then
      lLines.Add('# NOT FOUND')
    else begin
      lLines.Add('# found = ' + lRecord.Name);
      DoSetActiveRecord(lRecord);
      vstView.FullExpand;
      for var lNode in vstView.Nodes(False) do begin
        var lLine := StringOfChar(' ', 2 * Integer(vstView.GetNodeLevel(lNode))) + vstView.Text[lNode, 0, False];
        for var lColumn := 1 to Pred(vstView.Header.Columns.Count) do begin
          var lEditText := '';
          vstViewGetEditText(vstView, lNode, lColumn, lEditText);
          lLine := lLine + #9 + vstView.Text[lNode, lColumn, False] + #9 + lEditText;
        end;
        lLines.Add(lLine);
      end;
    end;
    lTmp := xeTestSwitches.ViewTextFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.ViewTextFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
    AddMessage(Format('[Test View Text] %d rows written to %s', [lLines.Count, xeTestSwitches.ViewTextFile]));
  finally
    lLines.Free;
  end;
end;

procedure TxeTestFormHelper.DoTestViewTree;
const
  cFlagChars: array[TwbConflictNodeFlag] of Char = ('D', 'I', 'U', 'S', 'A', 'P');
var
  lLines   : TStringList;
  lList    : TStringList;
  lRecords : TDynMainRecords;
  lTmp     : string;

  function FindRecord(const aFormID: string): IwbMainRecord;
  begin
    Result := nil;
    var lParts := Trim(aFormID).Split(['@']);
    var lFormID := TwbFormID.FromStr(lParts[0]);
    for var i := High(Files) downto Low(Files) do
      if (Length(lParts) = 1) or SameText(Files[i].FileName, lParts[1]) then begin
        Result := Files[i].RecordByFormID[lFormID, True, True];
        if Assigned(Result) then
          Exit;
      end;
    raise Exception.Create('no record ' + aFormID);
  end;

  function Cells(aDatas: PViewNodeDatas): string;
  begin
    Result := '';
    for var i := Low(ActiveRecords) to High(ActiveRecords) do begin
      var lFlags := '';
      for var lFlag := Low(TwbConflictNodeFlag) to High(TwbConflictNodeFlag) do
        if lFlag in aDatas[i].ViewNodeFlags then
          lFlags := lFlags + cFlagChars[lFlag];
      Result := Result + #9 + IfThen(Assigned(aDatas[i].Element), 'E', '-') + ':' +
        wbNameConflictThis[aDatas[i].ConflictThis] + ':' + lFlags;
    end;
  end;

  function Path(aNode: PVirtualNode): string;
  begin
    Result := '';
    while Assigned(aNode) and (aNode <> vstView.RootNode) do begin
      if Result = '' then
        Result := IntToStr(aNode.Index)
      else
        Result := IntToStr(aNode.Index) + '.' + Result;
      aNode := aNode.Parent;
    end;
  end;

  procedure Build(const aRecords: TDynMainRecords);
  begin
    var lLoaderDone := xeContext.LoaderDone;
    if xeTestSwitches.ViewTreeLoading then
      xeContext.LoaderDone := False;
    try
      DoSetActiveRecord(IwbMainRecord(nil));
      if Length(aRecords) = 1 then
        DoSetActiveRecord(aRecords[0], True)
      else
        DoSetActiveRecord(aRecords);
      if xeTestSwitches.ViewTreeReset then
        ResetActiveTree;
    finally
      xeContext.LoaderDone := lLoaderDone;
    end;
  end;

  procedure FocusProbe(aEntry: Integer; const aRecords: TDynMainRecords);
  var
    lNodes    : TArray<PVirtualNode>;
    lPaths    : TArray<string>;
    lColumns  : TArray<Integer>;
    lElements : TArray<IwbElement>;
  begin
    for var lNode in vstView.Nodes(False) do
      lNodes := lNodes + [lNode];
    var lStep := Max(1, Length(lNodes) div xeTestSwitches.ViewTreeFocus);
    var lIndex := 0;
    while lIndex <= High(lNodes) do begin
      var lNode := lNodes[lIndex];
      var lDatas: PViewNodeDatas := ViewCells(lNode);
      var lParent: PViewNodeDatas;
      if lNode.Parent = vstView.RootNode then
        lParent := @ActiveRecords[0]
      else
        lParent := ViewCells(lNode.Parent);
      for var c := Low(ActiveRecords) to High(ActiveRecords) do begin
        var lElement := lDatas[c].Element;
        if not Assigned(lElement) and Assigned(lParent) then
          lElement := wbConflictCellElement(lParent[c], lNode.Index);
        if Assigned(lElement) then begin
          lPaths := lPaths + [Path(lNode)];
          lColumns := lColumns + [c];
          lElements := lElements + [lElement];
        end;
      end;
      Inc(lIndex, lStep);
    end;
    for var k := Low(lElements) to High(lElements) do begin
      ViewFocusedElement := lElements[k];
      NodeForViewFocusedElement := nil;
      ColumnForViewFocusedElement := NoColumn;
      Build(aRecords);
      var lFound := 'none';
      if Assigned(NodeForViewFocusedElement) then
        lFound := Path(NodeForViewFocusedElement);
      lLines.Add(Format('# focus %d'#9'%s'#9'%d'#9'%s'#9'%d', [aEntry, lPaths[k], lColumns[k], lFound, ColumnForViewFocusedElement]));
    end;
    ViewFocusedElement := nil;
    NodeForViewFocusedElement := nil;
    ColumnForViewFocusedElement := NoColumn;
  end;

  procedure HeldMemory(out aBytes, aBlocks: Int64);
  var
    lState : TMemoryManagerState;
  begin
    GetMemoryManagerState(lState);
    aBytes := lState.TotalAllocatedMediumBlockSize + lState.TotalAllocatedLargeBlockSize;
    aBlocks := lState.AllocatedMediumBlockCount + lState.AllocatedLargeBlockCount;
    for var i := Low(lState.SmallBlockTypeStates) to High(lState.SmallBlockTypeStates) do begin
      Inc(aBytes, Int64(lState.SmallBlockTypeStates[i].AllocatedBlockCount) * lState.SmallBlockTypeStates[i].UseableBlockSize);
      Inc(aBlocks, lState.SmallBlockTypeStates[i].AllocatedBlockCount);
    end;
  end;

  procedure TimeProbe(aEntry: Integer; const aRecords: TDynMainRecords);
  var
    lTicks   : TArray<Int64>;
    lBytes0  : Int64;
    lBlocks0 : Int64;
    lBytes1  : Int64;
    lBlocks1 : Int64;
  begin
    DoSetActiveRecord(IwbMainRecord(nil));
    HeldMemory(lBytes0, lBlocks0);
    Build(aRecords);
    HeldMemory(lBytes1, lBlocks1);
    for var k := 1 to xeTestSwitches.ViewTreeTime do begin
      var lWatch := TStopwatch.StartNew;
      Build(aRecords);
      lTicks := lTicks + [lWatch.ElapsedTicks];
    end;
    TArray.Sort<Int64>(lTicks);
    lLines.Add(Format('# time %d'#9'min %.3f ms'#9'median %.3f ms'#9'held %d bytes %d blocks',
      [aEntry, lTicks[0] * 1000 / TStopwatch.Frequency, lTicks[Length(lTicks) div 2] * 1000 / TStopwatch.Frequency,
       lBytes1 - lBytes0, lBlocks1 - lBlocks0]));
  end;

  function RootLine: string;
  begin
    Result := wbNameConflictAll[ActiveRecords[0].ConflictAll] + Cells(@ActiveRecords[0]);
  end;

  procedure Collapsed(aEntry: Integer);
  begin
    var lCount := 0;
    var lPaths := '';
    for var lNode in vstView.Nodes(False) do
      if vstView.HasChildren[lNode] and not vstView.Expanded[lNode] then begin
        Inc(lCount);
        lPaths := lPaths + ' ' + Path(lNode);
      end;
    lLines.Add(Format('# collapsed %d'#9'%d'#9'%s', [aEntry, lCount, Trim(lPaths)]));
  end;

  procedure WalkProbe(aEntry: Integer);
  var
    lRecord       : IwbMainRecord;
    lConflictAll  : TConflictAll;
    lConflictThis : TConflictThis;
  begin
    var lBuilt := ViewTree.IsStale;
    for var i := Low(ActiveRecords) to High(ActiveRecords) do
      if Supports(ActiveRecords[i].Element, IwbMainRecord, lRecord) then
        ConflictLevelForMainRecord(lRecord, lConflictAll, lConflictThis);
    lLines.Add(Format('# treestale %d'#9'%s'#9'%s', [aEntry, BoolToStr(lBuilt, True), BoolToStr(ViewTree.IsStale, True)]));
  end;

  procedure IdleProbe(aEntry: Integer; const aRecords: TDynMainRecords);

    function RowLines: string;
    begin
      Result := '';
      for var lNode in vstView.Nodes(False) do
        Result := Result + Path(lNode) + #9 + wbNameConflictAll[PViewNodeDatas(ViewCells(lNode))[0].ConflictAll] + #9 +
          IfThen(vstView.IsVisible[lNode], 'V', 'h') + Cells(ViewCells(lNode)) + #10;
    end;

    procedure Pump;
    begin
      Application.ProcessMessages;
      UpdateActions;
    end;

    procedure Run(const aCase: string; const aHold, aRelease, aChange, aUndo: TProc);
    begin
      TFile.AppendAllText(xeTestSwitches.ViewTreeFile + '.progress', Format('%d'#9'idle %s', [aEntry, aCase]) + sLineBreak);
      Build(aRecords);
      var lGeneration := ViewTreeGeneration;
      if Assigned(aHold) then
        aHold();
      aChange();
      Pump;
      var lHeld := ViewTreeGeneration <> lGeneration;
      var lPage := pgMain.ActivePage.Name;
      if Assigned(aRelease) then begin
        aRelease();
        Pump;
      end;
      var lRebuilt := ViewTreeGeneration <> lGeneration;
      var lShown := RowLines;
      Build(aRecords);
      var lFresh := lShown = RowLines;
      if Assigned(aUndo) then
        aUndo();
      lLines.Add(Format('# idle %d'#9'%s'#9'held %s'#9'rebuilt %s'#9'fresh %s'#9'page %s',
        [aEntry, aCase, BoolToStr(lHeld, True), BoolToStr(lRebuilt, True), BoolToStr(lFresh, True), lPage]));
    end;

  var
    lEdited : IwbMainRecord;
  begin
    var lOptionsWith: TProc<string, TColor> :=
      procedure(aFlip: string; aColor: TColor)
      begin
        TestHost.TestViewOptionsFlip := aFlip;
        TestHost.TestViewOptionsColor := aColor;
        TestHost.TestViewModalAnswer.Enabled := True;
        try
          mniNavOptionsClick(nil);
        finally
          TestHost.TestViewModalAnswer.Enabled := False;
          TestHost.TestViewOptionsFlip := '';
          TestHost.TestViewOptionsColor := clNone;
        end;
      end;
    var lOptions: TProc :=
      procedure
      begin
        lOptionsWith('cbHideIgnored', clNone);
      end;
    var lBenign: TProc :=
      procedure
      begin
        lOptionsWith('cbCollapseBenignArray', clNone);
      end;
    var lToggle: TProc :=
      procedure
      begin
        ConflictView.QuickShowConflicts := not ConflictView.QuickShowConflicts;
      end;
    var lSetHeaderStates: TProc<THeaderStates> :=
      procedure(aStates: THeaderStates)
      begin
        var lField := TRttiContext.Create.GetType(vstView.Header.ClassType).GetField('FStates');
        if not Assigned(lField) then
          raise Exception.Create('no RTTI for the header''s FStates');
        lField.SetValue(vstView.Header, TValue.From<THeaderStates>(aStates));
      end;
    Run('quiet', nil, nil, procedure begin end, nil);
    Run('options', nil, nil, lOptions, lOptions);
    Run('view input', nil, nil, lToggle, lToggle);
    for var i := Low(ActiveRecords) to High(ActiveRecords) do
      if not Assigned(lEdited) and Supports(ActiveRecords[i].Element, IwbMainRecord, lEdited) then
        if not lEdited.IsEditable or lEdited.IsMaster then
          lEdited := nil;
    if Assigned(lEdited) then begin
      var lEditorID := lEdited.EditorID;
      Run('edit', nil, nil,
        procedure begin lEdited.EditorID := lEditorID + 'Idle' end,
        procedure begin lEdited.EditorID := lEditorID end);
    end else
      lLines.Add(Format('# idle %d'#9'edit'#9'skipped: no editable override shown', [aEntry]));
    if aEntry = 1 then
      Run('file', nil, nil, procedure begin AddNewFileName(Format('xeIdleProbe%d.esp', [aEntry]), False, False) end, nil);
    var lHeld: TArray<TPair<string, TVirtualTreeStates>> := [
      TPair<string, TVirtualTreeStates>.Create('tsEditing', [tsEditing]),
      TPair<string, TVirtualTreeStates>.Create('tsEditPending', [tsEditPending]),
      TPair<string, TVirtualTreeStates>.Create('tsVCLDragging', [tsVCLDragging]),
      TPair<string, TVirtualTreeStates>.Create('tsVCLDragPending', [tsVCLDragPending]),
      TPair<string, TVirtualTreeStates>.Create('tsOLEDragging', [tsOLEDragging]),
      TPair<string, TVirtualTreeStates>.Create('tsOLEDragPending', [tsOLEDragPending])];
    for var lPair in lHeld do
      Run('held ' + lPair.Key,
        procedure begin vstView.TreeStates := vstView.TreeStates + lPair.Value end,
        procedure begin vstView.TreeStates := vstView.TreeStates - lPair.Value end,
        lToggle, lToggle);
    Run('held nav tsVCLDragging',
      procedure begin vstNav.TreeStates := vstNav.TreeStates + [tsVCLDragging] end,
      procedure begin vstNav.TreeStates := vstNav.TreeStates - [tsVCLDragging] end,
      lToggle, lToggle);
    for var lHeader in [hsDragging, hsColumnWidthTracking] do
      Run('held header ' + GetEnumName(TypeInfo(THeaderState), Ord(lHeader)),
        procedure begin lSetHeaderStates(vstView.Header.States + [lHeader]) end,
        procedure begin lSetHeaderStates(vstView.Header.States - [lHeader]) end,
        lToggle, lToggle);
    Run('held pnlClient disabled',
      procedure begin pnlClient.Enabled := False end,
      procedure begin pnlClient.Enabled := True end,
      lToggle, lToggle);
    Run('held loading',
      procedure begin xeContext.LoaderDone := False end,
      procedure begin xeContext.LoaderDone := True end,
      lToggle, lToggle);
    Run('held other page',
      procedure begin pgMain.ActivePage := tbsMessages end,
      procedure begin pgMain.ActivePage := tbsView end,
      lToggle, lToggle);
    lHeld := [
      TPair<string, TVirtualTreeStates>.Create('tsLeftButtonDown', [tsLeftButtonDown]),
      TPair<string, TVirtualTreeStates>.Create('tsMiddleButtonDown', [tsMiddleButtonDown]),
      TPair<string, TVirtualTreeStates>.Create('tsRightButtonDown', [tsRightButtonDown])];
    for var lPair in lHeld do
      Run('held ' + lPair.Key,
        procedure begin vstView.TreeStates := vstView.TreeStates + lPair.Value end,
        procedure begin vstView.TreeStates := vstView.TreeStates - lPair.Value end,
        lToggle, lToggle);
    Run('held script running',
      procedure begin ScriptRunning := True end,
      procedure begin ScriptRunning := False end,
      lToggle, lToggle);
    Run('held view expanding',
      procedure begin RebuildingViewTree := True end,
      procedure begin RebuildingViewTree := False end,
      lToggle, lToggle);
    Run('options collapse benign array', nil, nil, lBenign, lBenign);
    TFile.AppendAllText(xeTestSwitches.ViewTreeFile + '.progress', Format('%d'#9'idle colour', [aEntry]) + sLineBreak);
    Build(aRecords);
    if ViewHeaderConflictAll >= caNoConflict then begin
      var lConflictAll := ViewHeaderConflictAll;
      var lColor := wbColorConflictAll[lConflictAll];
      lOptionsWith('', lColor xor $00404040);
      Pump;
      var lExpected := wbLighter(ConflictAllToColor(lConflictAll), 0.85);
      lLines.Add(Format('# idle %d'#9'colour %s'#9'header %s', [aEntry, wbNameConflictAll[lConflictAll],
        BoolToStr(vstView.Header.Background = lExpected, True)]));
      lOptionsWith('', lColor);
    end else
      lLines.Add(Format('# idle %d'#9'colour'#9'skipped: no header verdict colour', [aEntry]));
    Build(aRecords);
  end;

  procedure RemoveProbe(aEntry: Integer);
  var
    lRecord : IwbMainRecord;
  begin
    lRecord := ActiveRecord;
    if not Assigned(lRecord) and (Length(ActiveRecords) > 0) then
      Supports(ActiveRecords[High(ActiveRecords)].Element, IwbMainRecord, lRecord);
    if not Assigned(lRecord) or not lRecord.IsRemovable then begin
      lLines.Add(Format('# remove %d'#9'skipped: no removable record shown', [aEntry]));
      Exit;
    end;
    var lName := lRecord.Name;
    lRecord.Remove;
    lLines.Add(Format('# remove %d'#9'%s'#9'file %s'#9'stale %s'#9'due %s', [aEntry, lName,
      IfThen(Assigned(lRecord._File), 'kept', 'nil'), BoolToStr(Assigned(ViewTree) and ViewTree.IsStale, True),
      BoolToStr(ViewRefreshDue, True)]));
    try
      ResetActiveTree;
      var lShown: string := '-';
      if Assigned(ActiveRecord) then
        if ActiveRecord.Equals(lRecord) then
          lShown := 'the removed record'
        else
          lShown := ActiveRecord.Name;
      var lRemovedColumn := False;
      for var i := Low(ActiveRecords) to High(ActiveRecords) do
        if Assigned(ActiveRecords[i].Element) and ActiveRecords[i].Element.Equals(lRecord) then
          lRemovedColumn := True;
      lLines.Add(Format('# remove %d'#9'reset'#9'shown %s'#9'%d columns'#9'removed record in a column %s',
        [aEntry, lShown, Length(ActiveRecords), BoolToStr(lRemovedColumn, True)]));
    except
      on E: Exception do
        lLines.Add(Format('# remove %d'#9'reset'#9'%s: %s', [aEntry, E.ClassName, E.Message]));
    end;
  end;

  procedure FloorProbe(aEntry: Integer; const aRecords: TDynMainRecords);
  begin
    var lHeaderRows := ActiveRecords[0].Container.AdditionalElementCount;
    var lEdits := 0;
    if xeContext.BeginInternalEdit(True) then try
      for var lNode in vstView.Nodes(False) do begin
        if vstView.HasChildren[lNode] then
          Continue;
        var lTop := lNode;
        while lTop.Parent <> vstView.RootNode do
          lTop := lTop.Parent;
        if Integer(lTop.Index) < lHeaderRows then
          Continue;
        var lDatas: PViewNodeDatas := ViewCells(lNode);
        if not Assigned(lDatas[0].Element) then
          Continue;
        var lValue := lDatas[0].Element.EditValue;
        for var c := Succ(Low(ActiveRecords)) to High(ActiveRecords) do
          if Assigned(lDatas[c].Element) and (lDatas[c].Element.EditValue <> lValue) then begin
            lDatas[c].Element.EditValue := lValue;
            Inc(lEdits);
          end;
      end;
    finally
      wbEndInternalEdit;
    end;
    lLines.Add(Format('# floor %d'#9'edits'#9'%d', [aEntry, lEdits]));
    lLines.Add(Format('# floor %d'#9'before'#9'%s', [aEntry, RootLine]));
    ResetActiveTree;
    lLines.Add(Format('# floor %d'#9'reset'#9'%s', [aEntry, RootLine]));
    DoSetActiveRecord(IwbMainRecord(nil));
    DoSetActiveRecord(aRecords);
    lLines.Add(Format('# floor %d'#9'fresh'#9'%s', [aEntry, RootLine]));
  end;

  function Dominant(aBitmap: Vcl.Graphics.TBitmap; aLeft, aRight: Integer): string;
  begin
    var lCounts := TDictionary<TColor, Integer>.Create;
    try
      var lTotal := 0;
      for var y := 2 to aBitmap.Height - 3 do
        for var x := Max(aLeft, 0) to Min(aRight, aBitmap.Width - 1) do begin
          var lColor := aBitmap.Canvas.Pixels[x, y];
          var lCount := 0;
          lCounts.TryGetValue(lColor, lCount);
          lCounts.AddOrSetValue(lColor, lCount + 1);
          Inc(lTotal);
        end;
      var lBest: TColor := clNone;
      var lBestCount := 0;
      var lSecond: TColor := clNone;
      var lSecondCount := 0;
      for var lPair in lCounts do
        if lPair.Value > lBestCount then begin
          lSecond := lBest;
          lSecondCount := lBestCount;
          lBest := lPair.Key;
          lBestCount := lPair.Value;
        end else if lPair.Value > lSecondCount then begin
          lSecond := lPair.Key;
          lSecondCount := lPair.Value;
        end;
      if lTotal = 0 then
        Result := 'empty'
      else
        Result := Format('%.6x %d%% / %.6x %d%%', [ColorToRGB(lBest), lBestCount * 100 div lTotal, ColorToRGB(lSecond),
          lSecondCount * 100 div lTotal]);
    finally
      lCounts.Free;
    end;
  end;

  function PaintHeader(const aMode: string; aEntry: Integer): string;
  begin
    var lColumns := vstView.Header.Columns;
    var lBitmap := Vcl.Graphics.TBitmap.Create;
    try
      lBitmap.PixelFormat := pf32bit;
      lBitmap.SetSize(lColumns.TotalWidth + 40, vstView.Header.Height);
      lBitmap.Canvas.Brush.Color := $FF00FF;
      lBitmap.Canvas.FillRect(Rect(0, 0, lBitmap.Width, lBitmap.Height));
      lColumns.PaintHeader(lBitmap.Canvas, Rect(0, 0, lBitmap.Width, lBitmap.Height), Point(0, 0));
      lBitmap.SaveToFile(Format('%s.header%d-%s.bmp', [xeTestSwitches.ViewTreeFile, aEntry, StringReplace(aMode, ' ', '', [rfReplaceAll])]));
      Result := Format('%s'#9'themes %s'#9'background %.6x'#9'dark %s', [aMode, BoolToStr(tsUseThemes in vstView.TreeStates, True),
        ColorToRGB(vstView.Header.Background), BoolToStr(ViewHeaderIsDark, True)]);
      for var c := 0 to Pred(lColumns.Count) do
        Result := Result + #9 + Dominant(lBitmap, lColumns[c].Left + 3, lColumns[c].Left + lColumns[c].Width - 4);
      Result := Result + #9'tail ' + Dominant(lBitmap, lColumns.TotalWidth + 3, lBitmap.Width - 4);
    finally
      lBitmap.Free;
    end;
  end;

  procedure HeaderProbe(aEntry: Integer);
  begin
    var lExpected := 'none';
    var lRoot := caUnknown;
    if Length(ActiveRecords) > 0 then
      lRoot := ActiveRecords[0].ConflictAll;
    if lRoot >= caNoConflict then
      lExpected := Format('%.6x', [ColorToRGB(wbLighter(ConflictAllToColor(lRoot), 0.85))]);
    for var i := Low(ActiveRecords) to High(ActiveRecords) do
      lExpected := lExpected + Format(' | %s text %.6x', [wbNameConflictThis[ActiveRecords[i].ConflictThis],
        ColorToRGB(ViewHeaderCaptionColor(ActiveRecords[i].ConflictThis))]);
    var lOptions := vstView.TreeOptions.PaintOptions;
    vstView.TreeOptions.PaintOptions := lOptions - [toThemeAware];
    try
      lLines.Add(Format('# header %d'#9'%s'#9'expected %s'#9'style %s'#9'%s',
        [aEntry, wbNameConflictAll[lRoot], lExpected, TStyleManager.ActiveStyle.Name, PaintHeader('unthemed first', aEntry)]));
    finally
      vstView.TreeOptions.PaintOptions := lOptions;
    end;
    lLines.Add(Format('# header %d'#9'%s'#9'expected %s'#9'style %s'#9'%s',
      [aEntry, wbNameConflictAll[lRoot], lExpected, TStyleManager.ActiveStyle.Name, PaintHeader('as is', aEntry)]));
    vstView.TreeOptions.PaintOptions := lOptions - [toThemeAware];
    try
      lLines.Add(Format('# header %d'#9'%s'#9'expected %s'#9'style %s'#9'%s',
        [aEntry, wbNameConflictAll[lRoot], lExpected, TStyleManager.ActiveStyle.Name, PaintHeader('unthemed', aEntry)]));
    finally
      vstView.TreeOptions.PaintOptions := lOptions;
    end;
  end;

  procedure ModalProbe(aEntry: Integer; const aRecord, aTarget, aSwitchTo: IwbMainRecord);

    procedure Restore;
    begin
      for var lRecord in [aRecord, aTarget] do
        if lRecord.IsEditable and not lRecord.IsMaster then begin
          lRecord.Assign(Low(Integer), lRecord.Master, False);
          lRecord.UpdateRefs;
        end;
    end;

    procedure SelectInNav;
    begin
      vstNav.ClearSelection;
      for var lRecord in [aRecord, aTarget] do begin
        var lNode := FindNodeForElement(lRecord);
        if not Assigned(lNode) then
          raise Exception.Create('no nav node for ' + lRecord.Name);
        vstNav.Selected[lNode] := True;
      end;
      if tmrPendingSetActive.Enabled then
        tmrPendingSetActiveTimer(tmrPendingSetActive);
    end;

    function Digest(const aMainRecord: IwbMainRecord): string;
    begin
      var lText := '';
      for var i := 0 to Pred(aMainRecord.ElementCount) do
        lText := lText + aMainRecord.Elements[i].Name + '=' + aMainRecord.Elements[i].EditValue + #10;
      var lHash: Cardinal := 2166136261;
      for var lChar in lText do
        lHash := Cardinal((UInt64(lHash xor Ord(lChar)) * 16777619) and $FFFFFFFF);
      Result := Format('%d elements, %d chars, hash %.8x', [aMainRecord.ElementCount, Length(lText), lHash]);
    end;

    procedure BeginGesture(const aName: string; aRow: PVirtualNode; aColumn: Integer; aSwitch: Boolean; out aDelay, aFocused: Integer);
    begin
      TFile.AppendAllText(xeTestSwitches.ViewTreeFile + '.progress', Format('%d'#9'%s', [aEntry, aName]) + sLineBreak);
      vstViewFocusedNode := aRow;
      vstView.FocusedColumn := aColumn;
      EditWarnOk := False;
      TestHost.TestViewModalFactory := ViewTreeFactory;
      TestHost.TestViewModalSeen := '';
      aDelay := tmrPendingSetActive.Interval;
      if aSwitch then begin
        tmrPendingSetActive.Interval := 50;
        SetActiveRecord(aSwitchTo);
      end;
      aFocused := vstView.FocusedColumn;
      TestHost.TestViewModalAnswer.Enabled := True;
    end;

    procedure EndGesture(const aName, aResult: string; aDelay, aFocused: Integer);
    begin
      TestHost.TestViewModalAnswer.Enabled := False;
      TestHost.TestViewModalFactory := nil;
      tmrPendingSetActive.Enabled := False;
      tmrPendingSetActive.Interval := aDelay;
      EditWarnOk := True;
      if vstView.IsEditing then
        vstView.CancelEditNode;
      ViewFocusedElement := nil;
      EditFocusedViewElement := False;
      var lShown: string := '-';
      if (Length(ActiveRecords) > 0) and Assigned(ActiveRecords[0].Element) then
        lShown := ActiveRecords[0].Element.Name;
      lLines.Add(Format('# modal %d'#9'%s'#9'column %d'#9'dialogs%s'#9'%s'#9'shows %s',
        [aEntry, aName, aFocused, TestHost.TestViewModalSeen, aResult, lShown]));
    end;

    procedure Run(const aName: string; aSwitch, aCopy: Boolean);
    begin
      Restore;
      if aCopy then
        SelectInNav;
      Build([aRecord]);
      var lRow: PVirtualNode := nil;
      for var lNode in vstView.Nodes(False) do
        if (lNode.Parent = vstView.RootNode) and Assigned(ViewCells(lNode)[0].Element) and
           ViewCells(lNode)[0].Element.Name.StartsWith('EDID') then begin
          lRow := lNode;
          Break;
        end;
      if not Assigned(lRow) then begin
        lLines.Add(Format('# modal %d'#9'%s'#9'no EDID row', [aEntry, aName]));
        Exit;
      end;
      var lDelay, lFocused: Integer;
      BeginGesture(aName, lRow, Length(ActiveRecords), aSwitch, lDelay, lFocused);
      var lResult := 'returned';
      try
        if aCopy then
          mniViewCopyMultipleToSelectedRecordsClick(nil)
        else
          mniViewEditClick(nil);
      except
        on E: Exception do
          lResult := E.ClassName + ': ' + E.Message;
      end;
      EndGesture(aName, lResult, lDelay, lFocused);
      if aCopy then
        lLines.Add(Format('# modal %d'#9'%s'#9'target %s', [aEntry, aName, Digest(aTarget)]));
    end;

    procedure RunMemo(const aName: string);
    begin
      Restore;
      Build([aRecord]);
      var lColumn := Pred(Length(ActiveRecords));
      var lRow: PVirtualNode := nil;
      for var lNode in vstView.Nodes(False) do
        if (lNode.Parent = vstView.RootNode) and Assigned(ViewCells(lNode)[lColumn].Element) and
           ViewCells(lNode)[lColumn].Element.Name.StartsWith('EDID') then begin
          lRow := lNode;
          Break;
        end;
      if not Assigned(lRow) then begin
        lLines.Add(Format('# modal %d'#9'%s'#9'no EDID row', [aEntry, aName]));
        Exit;
      end;
      var lEdited := ViewCells(lRow)[lColumn].Element;
      var lBefore := lEdited.EditValue;
      TestHost.TestViewModalMemo := 'D174Probe';
      var lDelay, lFocused: Integer;
      BeginGesture(aName, lRow, Succ(lColumn), False, lDelay, lFocused);
      var lResult := 'returned';
      try
        mniViewEditClick(nil);
      except
        on E: Exception do
          lResult := E.ClassName + ': ' + E.Message;
      end;
      EndGesture(aName, lResult, lDelay, lFocused);
      TestHost.TestViewModalMemo := '';
      lLines.Add(Format('# modal %d'#9'%s'#9'value before %s'#9'after %s'#9'record %s',
        [aEntry, aName, lBefore, lEdited.EditValue, aRecord.EditorID]));
    end;

  const
    mgCopyToSelected = 0;
    mgSetToDefault   = 1;
    mgDrop           = 2;
    mgAdd            = 3;
    mgEditLeaf       = 4;
    mgEditStruct     = 5;
    mgRemove         = 6;
    mgHeaderDropped  = 7;

    function CompareRow(aGesture: Integer): PVirtualNode;
    begin
      Result := nil;
      var lHeaderRows := 0;
      if Assigned(ActiveRecords[0].Container) then
        lHeaderRows := ActiveRecords[0].Container.AdditionalElementCount;
      for var lNode in vstView.Nodes(False) do begin
        if (lNode.Parent <> vstView.RootNode) or (Integer(lNode.Index) < lHeaderRows) then
          Continue;
        var lCells: PViewNodeDatas := ViewCells(lNode);
        if not Assigned(lCells) then
          Continue;
        var lFirst := lCells[0].Element;
        var lSecond := lCells[1].Element;
        var lFound := False;
        case aGesture of
          mgCopyToSelected, mgDrop:
            lFound := Assigned(lFirst) and Assigned(lSecond) and lSecond.IsEditable and not lFirst.Name.StartsWith('EDID') and
              (lFirst.EditValue <> lSecond.EditValue);
          mgSetToDefault:
            lFound := Assigned(lSecond) and lSecond.IsEditable and not vstView.HasChildren[lNode] and lSecond.CanContainFormIDs;
          mgAdd:
            lFound := Assigned(lFirst) <> Assigned(lSecond);
          mgEditLeaf:
            lFound := Assigned(lSecond) and lSecond.IsEditable and not vstView.HasChildren[lNode] and
              not lSecond.Name.StartsWith('EDID');
          mgEditStruct:
            lFound := Assigned(lSecond) and not lSecond.IsEditable and vstView.HasChildren[lNode];
          mgRemove:
            lFound := Assigned(lFirst) and Assigned(lSecond) and lFirst.IsRemovable and lSecond.IsRemovable;
          mgHeaderDropped:
            lFound := True;
        end;
        if lFound then
          Exit(lNode);
      end;
    end;

    procedure RunCompare(const aName: string; aSwitch: Boolean; aGesture: Integer);
    begin
      Restore;
      Build([aRecord, aTarget]);
      if Length(ActiveRecords) <> 2 then begin
        lLines.Add(Format('# modal %d'#9'%s'#9'no compare view', [aEntry, aName]));
        Exit;
      end;
      var lRow := CompareRow(aGesture);
      if not Assigned(lRow) then begin
        lLines.Add(Format('# modal %d'#9'%s'#9'no row', [aEntry, aName]));
        Exit;
      end;
      var lColumn := 2;
      if (aGesture in [mgCopyToSelected, mgDrop, mgRemove, mgHeaderDropped]) or
         (aGesture = mgAdd) and not Assigned(ViewCells(lRow)[0].Element) then
        lColumn := 1;
      var lSource := ViewCells(lRow)[0].Element;
      var lEdited := ViewCells(lRow)[Pred(lColumn)].Element;
      var lRowName := '';
      for var c := 0 to 1 do
        if (lRowName = '') and Assigned(ViewCells(lRow)[c].Element) then
          lRowName := ViewCells(lRow)[c].Element.Name;
      var lDelay, lFocused: Integer;
      BeginGesture(aName, lRow, lColumn, aSwitch, lDelay, lFocused);
      var lResult := 'returned';
      try
        case aGesture of
          mgCopyToSelected:
            mniViewCopyToSelectedRecordsClick(nil);
          mgSetToDefault:
            mniViewSetToDefaultClick(nil);
          mgDrop:
            PerformDrop(vstView, lRow, 2, lSource);
          mgAdd: begin
            pmuViewPopup(Self);
            if mniViewAdd.Visible and mniViewAdd.Enabled and (mniViewAdd.Count = 0) then
              mniViewAdd.Click
            else
              lResult := 'add not offered';
          end;
          mgEditLeaf, mgEditStruct:
            vstView.EditNode(lRow, 2);
          mgRemove:
            mniViewRemoveFromSelectedClick(nil);
          mgHeaderDropped: begin
            var lHandled := False;
            vstViewHeaderDropped(vstView.Header, 1, 2, lHandled);
          end;
        end;
      except
        on E: Exception do
          lResult := E.ClassName + ': ' + E.Message;
      end;
      EndGesture(aName, lResult, lDelay, lFocused);
      var lRefs := '';
      for var i := 0 to Pred(aTarget.ReferencesCount) do
        lRefs := lRefs + ' ' + aTarget.References[i].Signature + ':' + IntToHex64(Cardinal(aTarget.References[i].LoadOrderFormID), 8);
      var lValue: string := '-';
      if Assigned(lEdited) then
        lValue := lEdited.EditValue;
      lLines.Add(Format('# modal %d'#9'%s'#9'row %s'#9'value %s'#9'focus after %d'#9'records %s, refs %d | %s, refs%s',
        [aEntry, aName, lRowName, lValue, vstView.FocusedColumn, Digest(aRecord), aRecord.ReferencesCount, Digest(aTarget),
         lRefs]));
    end;

  begin
    RunCompare('set to default', False, mgSetToDefault);
    RunCompare('set to default, switched', True, mgSetToDefault);
    RunCompare('drop', False, mgDrop);
    RunCompare('drop, switched', True, mgDrop);
    RunCompare('copy to selected', False, mgCopyToSelected);
    RunCompare('copy to selected, switched', True, mgCopyToSelected);
    RunCompare('add', False, mgAdd);
    RunCompare('add, switched', True, mgAdd);
    RunCompare('edit in place', False, mgEditLeaf);
    RunCompare('edit in place, switched', True, mgEditLeaf);
    RunCompare('edit in place, struct', False, mgEditStruct);
    RunCompare('edit in place, struct, switched', True, mgEditStruct);
    RunCompare('remove from selected', False, mgRemove);
    RunCompare('remove from selected, switched', True, mgRemove);
    RunCompare('header drop', False, mgHeaderDropped);
    RunCompare('header drop, switched', True, mgHeaderDropped);
    Run('edit', False, False);
    Run('edit, switched', True, False);
    RunMemo('edit, memo changed');
    Run('copy multiple', False, True);
    Run('copy multiple, switched', True, True);
  end;

begin
  lLines := TStringList.Create;
  lList := TStringList.Create;
  try
    lLines.Add('# xEdit view tree probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# list = ' + xeTestSwitches.ViewTreeList + ', hide = ' + xeTestSwitches.ViewTreeHide + ', hide no conflict = ' +
      BoolToStr(xeTestSwitches.ViewTreeHideNoConflict, True) + ', loading = ' + BoolToStr(xeTestSwitches.ViewTreeLoading, True) + ', reset = ' +
      BoolToStr(xeTestSwitches.ViewTreeReset, True) + ', focus = ' + IntToStr(xeTestSwitches.ViewTreeFocus) + ', floor = ' +
      BoolToStr(xeTestSwitches.ViewTreeFloor, True) + ', translate = ' + BoolToStr(xeTestSwitches.ViewTreeTranslate, True) + ', time = ' +
      IntToStr(xeTestSwitches.ViewTreeTime) + ', hide ignored = ' +
      BoolToStr(xeContext.Settings.HideIgnored, True) + ', hide never show = ' + BoolToStr(xeContext.Settings.HideNeverShow, True));
    lLines.Add('# Columns, tab separated: entry / row path / row ConflictAll / visible / per record column: element:ConflictThis:flags');
    CheckResult := 2;
    try
      if xeTestSwitches.ViewTreeHide <> '' then begin
        var lHidden := False;
        for var i := Low(Files) to High(Files) do
          if SameText(Files[i].FileName, xeTestSwitches.ViewTreeHide) then begin
            ConflictView.Hidden.Hide(Files[i]);
            lHidden := True;
          end;
        if not lHidden then
          raise Exception.Create('no module ' + xeTestSwitches.ViewTreeHide);
      end;
      if xeTestSwitches.ViewTreeHideNoConflict then
        HideNoConflict := True;
      if xeTestSwitches.ViewTreeTranslate then
        xeContext.Settings.TranslationMode := True;
      if xeTestSwitches.ViewTreeFloor then
        xeContext.Settings.DontSave := True;
      if xeTestSwitches.ViewTreeModal or xeTestSwitches.ViewTreeIdle or xeTestSwitches.ViewTreeRemove then begin
        xeContext.Settings.DontSave := True;
        TestHost.TestViewModalAnswer := TTimer.Create(Self);
        TestHost.TestViewModalAnswer.Enabled := False;
        TestHost.TestViewModalAnswer.Interval := 300;
        TestHost.TestViewModalAnswer.OnTimer := TestViewModalAnswerTimer;
        TestHost.TestViewOptionsColor := clNone;
        System.SysUtils.DeleteFile(xeTestSwitches.ViewTreeFile + '.progress');
      end;
      lList.LoadFromFile(xeTestSwitches.ViewTreeList);
      var lEntry := 0;
      for var lLine in lList do begin
        if (Trim(lLine) = '') or lLine.StartsWith('#') then
          Continue;
        Inc(lEntry);
        lRecords := nil;
        for var lFormID in lLine.Split([',']) do
          lRecords := lRecords + [FindRecord(lFormID)];
        Build(lRecords);
        var lColumns := '';
        for var i := Low(ActiveRecords) to High(ActiveRecords) do
          if Assigned(ActiveRecords[i].Element) then
            lColumns := lColumns + ' ' + ActiveRecords[i].Element._File.FileName
          else
            lColumns := lColumns + ' -';
        lLines.Add(Format('# entry %d: %s -> %s | %d columns:%s | %d root rows',
          [lEntry, Trim(lLine), lRecords[0].Name, Length(ActiveRecords), lColumns, vstView.RootNodeCount]));
        if Length(ActiveRecords) = 0 then
          Continue;
        lLines.Add(IntToStr(lEntry) + #9 + 'root' + #9 + wbNameConflictAll[ActiveRecords[0].ConflictAll] + #9 + '-' +
          Cells(@ActiveRecords[0]));
        for var lNode in vstView.Nodes(False) do
          lLines.Add(IntToStr(lEntry) + #9 + Path(lNode) + #9 +
            wbNameConflictAll[PViewNodeDatas(ViewCells(lNode))[0].ConflictAll] + #9 +
            IfThen(vstView.IsVisible[lNode], 'V', 'h') + Cells(ViewCells(lNode)));
        var lStale := False;
        for var i := Low(ActiveRecords) to High(ActiveRecords) do
          with ActiveRecords[i] do
            if Assigned(Element) and (ElementGen <> Element.ElementGeneration) or
               Assigned(Container) and (ContainerGen <> Container.ElementGeneration) then
              lStale := True;
        lLines.Add(Format('# stale %d'#9'%s', [lEntry, BoolToStr(lStale, True)]));
        if xeTestSwitches.ViewTreeWalk then
          WalkProbe(lEntry);
        if xeTestSwitches.ViewTreeIdle then
          IdleProbe(lEntry, lRecords);
        Collapsed(lEntry);
        if xeTestSwitches.ViewTreeHeader then
          HeaderProbe(lEntry);
        if xeTestSwitches.ViewTreeModal and (Length(lRecords) > 1) then
          ModalProbe(lEntry, lRecords[0], lRecords[1], lRecords[High(lRecords)]);
        if xeTestSwitches.ViewTreeFocus > 0 then
          FocusProbe(lEntry, lRecords);
        if xeTestSwitches.ViewTreeFloor and (Length(lRecords) > 1) then
          FloorProbe(lEntry, lRecords);
        if xeTestSwitches.ViewTreeTime > 0 then
          TimeProbe(lEntry, lRecords);
        if xeTestSwitches.ViewTreeRemove then
          RemoveProbe(lEntry);
      end;
      DoSetActiveRecord(IwbMainRecord(nil));
      if xeTestSwitches.ViewTreeHeader then
        HeaderProbe(0);
      CheckResult := 0;
    except
      on E: Exception do begin
        AddMessage('[Test View Tree] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.ViewTreeFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.ViewTreeFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lList.Free;
    lLines.Free;
  end;
end;

procedure TxeTestFormHelper.DoTestOptions;
begin
  xeContext.Settings.DontSave := True;
  TestHost.TestOptionsAnswer := TTimer.Create(Self);
  TestHost.TestOptionsAnswer.Enabled := False;
  TestHost.TestOptionsAnswer.Interval := 250;
  TestHost.TestOptionsAnswer.OnTimer := TestOptionsAnswerTimer;
  TestHost.TestOptionsTimer := TTimer.Create(Self);
  TestHost.TestOptionsTimer.Interval := 500;
  TestHost.TestOptionsTimer.OnTimer := TestOptionsRunTimer;
  TestHost.TestOptionsTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestOptionsRunTimer(Sender: TObject);
const
  cArms    : array[0..8] of string = ('unchanged', 'toggle', 'restore', 'toggle never show', 'restore never show',
    'toggle template hide', 'restore template hide', 'colour', 'restore colour');
  cVerdict : array[Boolean] of string = ('FAIL', 'PASS');
var
  lPathNode        : PVirtualNode;
  lPathStale       : Integer;
  lColourSaved     : TColor;
  lLines           : TStringList;
  lFailed          : Integer;
  lEpochBefore     : Cardinal;
  lEpochAfter      : Cardinal;
  lAlignBefore     : Boolean;
  lAlignAfter      : Boolean;
  lNeverShowBefore : Boolean;
  lNeverShowAfter  : Boolean;
  lPass            : Boolean;
  lTmp             : string;
  lNavRecords      : TDynMainRecords;
  lNavVerdicts     : TArray<string>;
  lNavGens         : TArray<Integer>;
  lNavEpoch        : Cardinal;

  function NavVerdict(const aRecord: IwbMainRecord): string;
  var
    lCA : TConflictAll;
    lCT : TConflictThis;
  begin
    ConflictLevelForMainRecord(aRecord, lCA, lCT);
    Result := wbNameConflictAll[lCA] + ' / ' + wbNameConflictThis[lCT];
  end;

  procedure NavBefore;
  var
    lFile : IwbFile;
  begin
    lNavRecords := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, xeTestSwitches.OptionsNav) then
        lFile := Files[i];
    if not Assigned(lFile) then
      raise Exception.Create('-testoptionsnav: no loaded file ' + xeTestSwitches.OptionsNav);
    SetLength(lNavRecords, lFile.RecordCount);
    SetLength(lNavVerdicts, lFile.RecordCount);
    SetLength(lNavGens, lFile.RecordCount);
    var lCount := 0;
    for var i := 0 to Pred(lFile.RecordCount) do begin
      var lRecord := lFile.Records[i];
      if lRecord.Signature = xeContext.GameDefObj.HeaderSignature then
        Continue;
      lNavRecords[lCount] := lRecord;
      lNavVerdicts[lCount] := NavVerdict(lRecord);
      lNavGens[lCount] := lRecord.ElementGeneration;
      Inc(lCount);
    end;
    SetLength(lNavRecords, lCount);
    lNavEpoch := ConflictView.Epoch;
  end;

  procedure NavAfter(const aArm: string);
  begin
    var lMoved := 0;
    var lStale := 0;
    var lExamples := 0;
    var lCachedStale := 0;
    var lEpochKept := ConflictView.Epoch = lNavEpoch;
    for var i := Low(lNavRecords) to High(lNavRecords) do begin
      var lGenKept := lNavRecords[i].ElementGeneration = lNavGens[i];
      var lCached := NavVerdict(lNavRecords[i]);
      lNavRecords[i].ResetConflict;
      var lFresh := NavVerdict(lNavRecords[i]);
      if lCached <> lFresh then begin
        Inc(lCachedStale);
        if lCachedStale <= 5 then
          lLines.Add(Format('# nav %s'#9'cached example'#9'%s'#9'cached %s'#9'fresh %s', [aArm, lNavRecords[i].Name, lCached, lFresh]));
      end;
      if lFresh <> lNavVerdicts[i] then begin
        Inc(lMoved);
        if lGenKept and lEpochKept then
          Inc(lStale);
        if lExamples < 5 then begin
          Inc(lExamples);
          lLines.Add(Format('# nav %s'#9'example'#9'%s'#9'before %s'#9'after %s'#9'generation %s'#9'epoch %s', [aArm,
            lNavRecords[i].Name, lNavVerdicts[i], lFresh, IfThen(lGenKept, 'kept', 'moved'), IfThen(lEpochKept, 'kept', 'moved')]));
        end;
      end;
    end;
    lLines.Add(Format('# nav %s'#9'file %s'#9'records %d'#9'moved %d'#9'moved with generation and epoch kept %d',
      [aArm, xeTestSwitches.OptionsNav, Length(lNavRecords), lMoved, lStale]));
    lLines.Add(Format('# nav %s'#9'cached verdict differs from fresh %d', [aArm, lCachedStale]));
    lNavRecords := nil;
  end;

  procedure PathCheck(const aArm: string);
  var
    lData : PNavNodeData;
    lBack : TColor;
    lFont : TColor;
  begin
    var lPending := False;
    var lRgn := CreateRectRgn(0, 0, 0, 0);
    try
      if GetUpdateRgn(vstNav.Handle, lRgn, False) > NULLREGION then
        lPending := RectInRegion(lRgn, vstNav.GetDisplayRect(lPathNode, NoColumn, False));
    finally
      DeleteObject(lRgn);
    end;
    vstNav.Repaint;
    lData := vstNav.GetNodeData(lPathNode);
    if lData.ConflictAll >= caNoConflict then
      lBack := wbLighter(ConflictAllToColor(lData.ConflictAll), 0.85)
    else
      lBack := vstNav.Color;
    lFont := wbDarker(ConflictThisToColor(lData.ConflictThis));
    var lStale := (lblPath.Color <> lBack) or (lblPath.Font.Color <> lFont);
    if lStale then
      Inc(lPathStale);
    lLines.Add(Format('# path %s'#9'nav %s / %s'#9'label %s / %s'#9'expected %s / %s'#9'%s'#9'row repaint pending %s', [aArm,
      wbNameConflictAll[lData.ConflictAll], wbNameConflictThis[lData.ConflictThis], ColorToString(lblPath.Color),
      ColorToString(lblPath.Font.Color), ColorToString(lBack), ColorToString(lFont), IfThen(lStale, 'STALE', 'current'),
      BoolToStr(lPending, True)]));
  end;

  procedure PathSelect;
  begin
    var lAt := Pos('@', xeTestSwitches.OptionsPath);
    if lAt < 2 then
      raise Exception.Create('-testoptionspath: not <FormID>@<module>: ' + xeTestSwitches.OptionsPath);
    var lFormID := TwbFormID.FromStr(Copy(xeTestSwitches.OptionsPath, 1, Pred(lAt)));
    var lModule := Copy(xeTestSwitches.OptionsPath, Succ(lAt), MaxInt);
    var lRecord: IwbMainRecord := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, lModule) then
        lRecord := Files[i].RecordByFormID[lFormID, True, True];
    if not Assigned(lRecord) then
      raise Exception.Create('-testoptionspath: no record ' + xeTestSwitches.OptionsPath);
    lPathNode := FindNodeForElement(lRecord);
    if not Assigned(lPathNode) then
      raise Exception.Create('-testoptionspath: no nav node for ' + lRecord.Name);
    vstNav.ClearSelection;
    vstNav.FocusedNode := lPathNode;
    vstNav.Selected[lPathNode] := True;
    vstNav.ScrollIntoView(lPathNode, True);
    vstNav.Repaint;
    vstNavChange(vstNav, lPathNode);
    TestHost.TestOptionsColourAll := PNavNodeData(vstNav.GetNodeData(lPathNode)).ConflictAll;
    lColourSaved := wbColorConflictAll[TestHost.TestOptionsColourAll];
    lLines.Add('# path record' + #9 + lRecord.Name);
    PathCheck('selected');
  end;

begin
  TestHost.TestOptionsTimer.Enabled := False;
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit options epoch probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# Columns, tab separated: arm, toggled, dialog shown, dialog align, epoch before, epoch after, align before, align after, ' +
      'dialog never show, never show before, never show after, verdict');
    lFailed := 0;
    lPathNode := nil;
    lPathStale := 0;
    try
      if xeTestSwitches.OptionsPath <> '' then
        PathSelect;
      for var lArm := Low(cArms) to High(cArms) do begin
        if (lArm in [7, 8]) and not Assigned(lPathNode) then
          Continue;
        TestHost.TestOptionsToggle := lArm in [1, 2];
        TestHost.TestOptionsToggleNeverShow := lArm in [3, 4];
        TestHost.TestOptionsToggleTemplate := lArm in [5, 6];
        TestHost.TestOptionsColourSet := lArm in [7, 8];
        if lArm <> 7 then
          TestHost.TestOptionsColourValue := lColourSaved
        else if lColourSaved = TColor($004080FF) then
          TestHost.TestOptionsColourValue := TColor($0080FF40)
        else
          TestHost.TestOptionsColourValue := TColor($004080FF);
        TestHost.TestOptionsShown := False;
        var lTemplateBefore := wbActorTemplateHide;
        lEpochBefore := ConflictView.Epoch;
        lAlignBefore := ConflictView.AlignArrayElements;
        lNeverShowBefore := xeContext.Settings.HideNeverShow;
        if xeTestSwitches.OptionsNav <> '' then
          NavBefore;
        if xeTestSwitches.OptionsClose and (lArm = 1) then begin
          System.SysUtils.DeleteFile(xeTestSwitches.OptionsFile + '.progress');
          TestHost.TestOptionsClosePosted := False;
          TestHost.TestOptionsCloseTimer := TTimer.Create(Self);
          TestHost.TestOptionsCloseTimer.Interval := 1;
          TestHost.TestOptionsCloseTimer.OnTimer := TestOptionsCloseTimerTimer;
        end;
        TestHost.TestOptionsAnswer.Enabled := True;
        try
          try
            mniNavOptionsClick(nil);
            if Assigned(TestHost.TestOptionsCloseTimer) then
              TFile.AppendAllText(xeTestSwitches.OptionsFile + '.progress', 'Options handler returned' + sLineBreak);
          except
            on E: Exception do begin
              if Assigned(TestHost.TestOptionsCloseTimer) then
                TFile.AppendAllText(xeTestSwitches.OptionsFile + '.progress', 'Options handler raised ' + E.ClassName + ': ' + E.Message + sLineBreak);
              raise;
            end;
          end;
        finally
          TestHost.TestOptionsAnswer.Enabled := False;
          TestHost.TestOptionsColourSet := False;
          FreeAndNil(TestHost.TestOptionsCloseTimer);
        end;
        if Assigned(lPathNode) then
          PathCheck(cArms[lArm]);
        if xeTestSwitches.OptionsNav <> '' then
          NavAfter(cArms[lArm]);
        lEpochAfter := ConflictView.Epoch;
        lAlignAfter := ConflictView.AlignArrayElements;
        lNeverShowAfter := xeContext.Settings.HideNeverShow;
        lPass := TestHost.TestOptionsShown and (TestHost.TestOptionsDialogAlign = lAlignBefore) and (TestHost.TestOptionsDialogNeverShow = lNeverShowBefore) and
          ((lAlignAfter <> lAlignBefore) = TestHost.TestOptionsToggle) and ((lNeverShowAfter <> lNeverShowBefore) = TestHost.TestOptionsToggleNeverShow) and
          ((wbActorTemplateHide <> lTemplateBefore) = TestHost.TestOptionsToggleTemplate);
        if not (TestHost.TestOptionsToggleNeverShow or TestHost.TestOptionsToggleTemplate) then
          lPass := lPass and ((lEpochAfter <> lEpochBefore) = TestHost.TestOptionsToggle);
        if TestHost.TestOptionsToggleTemplate then
          lLines.Add(Format('# %s'#9'actor template hide %s -> %s', [cArms[lArm], BoolToStr(lTemplateBefore, True),
            BoolToStr(wbActorTemplateHide, True)]));
        if not lPass then
          Inc(lFailed);
        lLines.Add(string.Join(#9, [cArms[lArm], BoolToStr(TestHost.TestOptionsToggle, True), BoolToStr(TestHost.TestOptionsShown, True),
          BoolToStr(TestHost.TestOptionsDialogAlign, True), lEpochBefore.ToString, lEpochAfter.ToString, BoolToStr(lAlignBefore, True),
          BoolToStr(lAlignAfter, True), BoolToStr(TestHost.TestOptionsDialogNeverShow, True), BoolToStr(lNeverShowBefore, True),
          BoolToStr(lNeverShowAfter, True), cVerdict[lPass]]));
        AddMessage(Format('[Test Options] %s: epoch %d -> %d, align %s -> %s, never show %s -> %s, %s', [cArms[lArm], lEpochBefore,
          lEpochAfter, BoolToStr(lAlignBefore, True), BoolToStr(lAlignAfter, True), BoolToStr(lNeverShowBefore, True),
          BoolToStr(lNeverShowAfter, True), cVerdict[lPass]]));
      end;
      if Assigned(lPathNode) then
        lLines.Add(Format('# path stale %d', [lPathStale]));
      if xeTestSwitches.OptionsNav <> '' then
        for var lReset := 0 to 1 do begin
          NavBefore;
          TestHost.TestOptionsToggle := True;
          TestHost.TestOptionsToggleNeverShow := False;
          TestHost.TestOptionsToggleTemplate := False;
          TestHost.TestOptionsAnswer.Enabled := True;
          try
            mniNavOptionsClick(nil);
          finally
            TestHost.TestOptionsAnswer.Enabled := False;
          end;
          var lWatch := TStopwatch.StartNew;
          ResetAllConflict;
          lLines.Add(Format('# nav reset all conflict'#9'%d ms', [lWatch.ElapsedMilliseconds]));
          NavAfter(IfThen(lReset = 0, 'toggle then reset', 'restore then reset'));
        end;
      if lFailed = 0 then
        CheckResult := 0
      else
        CheckResult := 1;
    except
      on E: Exception do begin
        AddMessage('[Test Options] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
        CheckResult := 255;
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.OptionsFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.OptionsFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.TestOptionsCloseTimerTimer(Sender: TObject);
begin
  if TestHost.TestOptionsClosePosted or pnlClient.Enabled then
    Exit;
  TestHost.TestOptionsClosePosted := True;
  TFile.AppendAllText(xeTestSwitches.OptionsFile + '.progress', 'close posted during the reset: ' + wbCurrentAction + sLineBreak);
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TxeTestFormHelper.TestOptionsAnswerTimer(Sender: TObject);
var
  lForm: TfrmOptions;
begin
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] is TfrmOptions) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := TfrmOptions(Screen.CustomForms[i]);
      TestHost.TestOptionsShown := True;
      TestHost.TestOptionsDialogAlign := lForm.cbAlignArrayElements.Checked;
      TestHost.TestOptionsDialogNeverShow := lForm.cbHideNeverShow.Checked;
      if TestHost.TestOptionsToggle then
        lForm.cbAlignArrayElements.Checked := not lForm.cbAlignArrayElements.Checked;
      if TestHost.TestOptionsToggleNeverShow then
        lForm.cbHideNeverShow.Checked := not lForm.cbHideNeverShow.Checked;
      if TestHost.TestOptionsToggleTemplate then
        lForm.cbActorTemplateHide.Checked := not lForm.cbActorTemplateHide.Checked;
      if TestHost.TestOptionsColourSet then
        wbColorConflictAll[TestHost.TestOptionsColourAll] := TestHost.TestOptionsColourValue;
      lForm.ModalResult := mrOk;
      Exit;
    end;
end;

procedure TxeTestFormHelper.TestViewModalAnswerTimer(Sender: TObject);
begin
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      var lReplaced := PPointer(@ViewTreeFactory)^ <> PPointer(@TestHost.TestViewModalFactory)^;
      TestHost.TestViewModalSeen := TestHost.TestViewModalSeen + ' ' + Screen.CustomForms[i].ClassName + IfThen(lReplaced, ':replaced', ':kept') +
        IfThen(IsWindowEnabled(Handle), ':main-enabled', ':main-disabled');
      if (TestHost.TestViewModalMemo <> '') and (Screen.CustomForms[i] is TfrmViewElements) then begin
        var lPage := TfrmViewElements(Screen.CustomForms[i]).pcView.ActivePage;
        if Assigned(lPage) then
          for var c := 0 to Pred(lPage.ControlCount) do
            if (lPage.Controls[c] is TMemo) and not TMemo(lPage.Controls[c]).ReadOnly then begin
              TMemo(lPage.Controls[c]).Text := TestHost.TestViewModalMemo;
              TMemo(lPage.Controls[c]).Modified := True;
              TestHost.TestViewModalSeen := TestHost.TestViewModalSeen + '(memo set on ' + lPage.Caption + ')';
            end;
      end;
      if Screen.CustomForms[i] is TfrmOptions then begin
        if TestHost.TestViewOptionsFlip <> '' then
          with Screen.CustomForms[i].FindComponent(TestHost.TestViewOptionsFlip) as TCheckBox do
            Checked := not Checked;
        if TestHost.TestViewOptionsColor <> clNone then
          wbColorConflictAll[ViewHeaderConflictAll] := TestHost.TestViewOptionsColor;
      end;
      Screen.CustomForms[i].ModalResult := mrOk;
      Exit;
    end;
  var lWnd: HWND := 0;
  repeat
    lWnd := FindWindowEx(0, lWnd, '#32770', nil);
    if (lWnd <> 0) and IsWindowVisible(lWnd) and IsWindowEnabled(lWnd) and
       (GetWindowThreadProcessId(lWnd, nil) = MainThreadID) then begin
      var lReplaced := PPointer(@ViewTreeFactory)^ <> PPointer(@TestHost.TestViewModalFactory)^;
      var lCaption: array[0..255] of Char;
      GetWindowText(lWnd, lCaption, Length(lCaption));
      TestHost.TestViewModalSeen := TestHost.TestViewModalSeen + ' "' + string(lCaption) + '"' + IfThen(lReplaced, ':replaced', ':kept') +
        IfThen(IsWindowEnabled(Handle), ':main-enabled', ':main-disabled');
      SendMessage(lWnd, WM_USER + 102, IDYES, 0);
      Exit;
    end;
  until lWnd = 0;
end;

procedure TxeTestFormHelper.DoTestCopyIntoGap;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  TestHost.TestCopyIntoGapTimer := TTimer.Create(Self);
  TestHost.TestCopyIntoGapTimer.Interval := 500;
  TestHost.TestCopyIntoGapTimer.OnTimer := TestCopyIntoGapRunTimer;
  TestHost.TestCopyIntoGapTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestCopyIntoGapRunTimer(Sender: TObject);

  function ElementText(const aElement: IwbElement): string;
  var
    lContainer : IwbContainerElementRef;
  begin
    if Supports(aElement, IwbContainerElementRef, lContainer) and (lContainer.ElementCount > 0) then begin
      Result := '';
      for var i := 0 to Pred(lContainer.ElementCount) do begin
        if i > 0 then
          Result := Result + ' | ';
        Result := Result + ElementText(lContainer.Elements[i]);
      end;
    end else
      Result := aElement.EditValue;
  end;

  procedure AddContainer(aLines: TStrings; const aTag: string; const aContainer: IwbContainerElementRef);
  var
    lRows : string;
  begin
    lRows := '';
    for var i := 0 to Pred(aContainer.ElementCount) do begin
      aLines.Add(aTag + #9 + IntToStr(i) + #9 + ElementText(aContainer.Elements[i]));
      lRows := lRows + ' ' + IntToStr(aContainer.Elements[i].SortOrder);
    end;
    aLines.Add('# ' + aTag + ' rows:' + lRows);
  end;

var
  lLines       : TStringList;
  lSource      : IwbMainRecord;
  lRecord      : IwbMainRecord;
  lColumn      : Integer;
  lGapNode     : PVirtualNode;
  lNodeDatas   : PViewNodeDatas;
  lParentDatas : PViewNodeDatas;
  lGapSource   : IwbElement;
  lContainer   : IwbContainerElementRef;
  lTmp         : string;
begin
  TestHost.TestCopyIntoGapTimer.Enabled := False;
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit copy-into-gap probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# record = ' + xeTestSwitches.CopyIntoGapRecord + ', source = ' + xeTestSwitches.CopyIntoGapSource + ', op = ' + xeTestSwitches.CopyIntoGapOp);
    lLines.Add('# Columns, tab separated: what / index / text; the "#" rows lines carry each element''s SortOrder');
    CheckResult := 2;
    try
      lSource := nil;
      var lFormID := TwbFormID.FromStr(xeTestSwitches.CopyIntoGapRecord);
      for var i := Low(Files) to High(Files) do
        if SameText(Files[i].FileName, xeTestSwitches.CopyIntoGapSource) then
          lSource := Files[i].RecordByFormID[lFormID, True, True];
      if not Assigned(lSource) then
        raise Exception.Create('no record ' + xeTestSwitches.CopyIntoGapRecord + ' in ' + xeTestSwitches.CopyIntoGapSource);

      var lFile := AddNewFileName('CopyIntoGap.esp', False, False);
      if not AddRequiredMasters(lSource, lFile, False, True) then
        raise Exception.Create('the masters of ' + lSource.Name + ' could not be added');
      lRecord := lFile.AddCopy(lSource, [cfDeepCopy], wbNoCopyRules) as IwbMainRecord;
      if not Assigned(lRecord) then
        raise Exception.Create('no override of ' + lSource.Name + ' was created');

      DoSetActiveRecord(lRecord);
      vstView.FullExpand;
      lColumn := -1;
      for var i := Low(ActiveRecords) to High(ActiveRecords) do
        if Assigned(ActiveRecords[i].Element) and ActiveRecords[i].Element.Equals(lRecord) then
          lColumn := i;
      if lColumn < 0 then
        raise Exception.Create('the override is not a column of the View tab');
      lLines.Add('columns' + #9 + IntToStr(Length(ActiveRecords)) + #9 + 'target ' + IntToStr(lColumn) + ' ' + lFile.FileName);

      lGapNode := nil;
      lGapSource := nil;
      lParentDatas := nil;
      for var lNode in vstView.Nodes(False) do begin
        lNodeDatas := ViewCells(lNode);
        if lNode.Parent = vstView.RootNode then
          lParentDatas := @ActiveRecords[0]
        else
          lParentDatas := ViewCells(lNode.Parent);
        if not Assigned(lNodeDatas) or not Assigned(lParentDatas) then
          Continue;
        if not (vnfIsAligned in lParentDatas[lColumn].ViewNodeFlags) or Assigned(lNodeDatas[lColumn].Element) or
           not Assigned(lParentDatas[lColumn].Element) then
          Continue;
        for var k := Low(ActiveRecords) to High(ActiveRecords) do
          if (k <> lColumn) and Assigned(lNodeDatas[k].Element) then begin
            lGapSource := lNodeDatas[k].Element;
            Break;
          end;
        if Assigned(lGapSource) then begin
          lGapNode := lNode;
          Break;
        end;
      end;
      if not Assigned(lGapNode) then
        raise Exception.Create('no aligned gap in the override''s column');
      if not Supports(lParentDatas[lColumn].Element, IwbContainerElementRef, lContainer) then
        raise Exception.Create('the gap''s parent is not a container');
      lLines.Add('gap' + #9 + IntToStr(lGapNode.Index) + #9 + lContainer.Path);
      var lGapMemoryIndex: Integer;
      var lGapValid := wbConflictAlignedGap(lParentDatas[lColumn], lGapNode.Index, lGapMemoryIndex);
      lLines.Add('# gap valid' + #9 + BoolToStr(lGapValid, True) + #9 + 'memory index ' + IntToStr(lGapMemoryIndex));
      lLines.Add('source' + #9 + '-' + #9 + ElementText(lGapSource));
      AddContainer(lLines, 'before', lContainer);

      if SameText(xeTestSwitches.CopyIntoGapOp, 'popup') then begin
        OverrideViewFocusedNode := lGapNode;
        try
          vstView.FocusedColumn := Succ(lColumn);
          pmuViewPopup(Self);
          lLines.Add('popup' + #9 + 'add visible' + #9 + BoolToStr(mniViewAdd.Visible and mniViewAdd.Enabled, True));
        finally
          OverrideViewFocusedNode := nil;
        end;
      end else if SameText(xeTestSwitches.CopyIntoGapOp, 'dragover') then begin
        var lTargetNode := lGapNode;
        var lTargetIndex: Integer;
        var lTargetElement: IwbElement;
        var lAlignedMemoryIndex: Integer;
        var lAccept := GetTargetElement(vstView, lTargetNode, Succ(lColumn), lTargetIndex, lTargetElement, lAlignedMemoryIndex) and
          (lTargetElement <> lGapSource) and lTargetElement.CanAssign(lTargetIndex, lGapSource, True);
        lLines.Add('dragover' + #9 + 'accept' + #9 + BoolToStr(lAccept, True));
        lLines.Add('# dragover aligned memory index' + #9 + IntToStr(lAlignedMemoryIndex));
      end else if SameText(xeTestSwitches.CopyIntoGapOp, 'drop') then begin
        lLines.Add('drop' + #9 + 'performed' + #9 + BoolToStr(PerformDrop(vstView, lGapNode, Succ(lColumn), lGapSource), True));
        AddContainer(lLines, 'after', lContainer);
      end else begin
        OverrideViewFocusedNode := lGapNode;
        try
          vstView.FocusedColumn := Succ(lColumn);
          pmuViewPopup(Self);
          var lClicked := mniViewAdd.Visible and mniViewAdd.Enabled;
          if lClicked then
            if mniViewAdd.Count > 0 then
              mniViewAdd.Items[0].Click
            else
              mniViewAdd.Click;
          lLines.Add('add' + #9 + 'clicked' + #9 + BoolToStr(lClicked, True));
        finally
          OverrideViewFocusedNode := nil;
        end;
        AddContainer(lLines, 'after', lContainer);
      end;
      CheckResult := 0;
    except
      on E: Exception do begin
        AddMessage('[Test Copy Into Gap] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.CopyIntoGapFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.CopyIntoGapFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

function TestFileIDText(const aFile: IwbFile): string;
begin
  if aFile.HasLoadOrderFileID then
    Result := aFile.LoadOrderFileID.ToString
  else
    Result := 'no slot';
end;

procedure TxeTestFormHelper.DoTestNewFile;
begin
  xeContext.Settings.DontSave := True;
  if xeTestSwitches.NewFileCompareTo = '' then begin
    DoTestNewFileReport;
    Exit;
  end;
  for var lFile in Files do
    if SameText(lFile.FileName, xeTestSwitches.NewFileModule) then begin
      DoCompareTo(lFile, xeTestSwitches.NewFileCompareTo);
      if xeContext.LoaderDone then
        DoTestNewFileReport('the compare load of ' + xeTestSwitches.NewFileCompareTo + ' did not start');
      Exit;
    end;
  DoTestNewFileReport('no module ' + xeTestSwitches.NewFileModule);
end;

procedure TxeTestFormHelper.DoTestNewFileReport(const aFailure: string);
var
  lLines    : TStringList;
  lMasters  : TStringList;
  lNew      : IwbFile;
  lLast     : IwbFile;
  lShared   : string;
  lSharedID : string;
  lRefused  : Boolean;
  lTmp      : string;
begin
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit new-file probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# compareto = ' + xeTestSwitches.NewFileCompareTo + ', module = ' + xeTestSwitches.NewFileModule +
      ', overload = ' + IfThen(xeTestSwitches.NewFileTemplate, 'template', 'boolean'));
    lLines.Add('# Columns, tab separated: what / file / load order / load order FileID / text');
    CheckResult := 2;
    try
      if aFailure <> '' then
        raise Exception.Create(aFailure);
      if xeContext.LoaderError then
        raise Exception.Create('an error occured while loading the compare to module');
      for var lFile in Files do
        lLines.Add('file' + #9 + lFile.FileName + #9 + IntToStr(lFile.LoadOrder) + #9 + TestFileIDText(lFile) + #9 +
          IfThen(fsIsCompareLoad in lFile.FileStates, 'compare load', ''));

      var lName := 'xeNewFileProbe.esp';
      if xeTestSwitches.NewFileTemplate then begin
        var lTemplates := xeContext.ModuleList.ModulesByLoadOrder(True).FilteredByFlag(mfValid).FilteredByFlag(mfTemplate);
        if Length(lTemplates) = 0 then
          raise Exception.Create('no module template');
        lName := 'xeNewFileProbe' + lTemplates[0].miExtension.ToString;
        lNew := AddNewFileName(lName, lTemplates[0]);
      end else
        lNew := AddNewFileName(lName, False, False);
      if not Assigned(lNew) then
        raise Exception.Create('no new file was created');
      if not SameText(lNew.FileName, lName) or not lNew.Equals(Files[High(Files)]) then
        raise Exception.Create('the new file is ' + lNew.FileName + ', not a new ' + lName);
      lShared := '';
      lSharedID := '';
      lLast := nil;
      for var lFile in Files do
        if not lFile.Equals(lNew) then begin
          if lFile.LoadOrder = lNew.LoadOrder then
            lShared := lShared + ' ' + lFile.FileName;
          if lFile.HasLoadOrderFileID and lNew.HasLoadOrderFileID and (lFile.LoadOrderFileID = lNew.LoadOrderFileID) then
            lSharedID := lSharedID + ' ' + lFile.FileName;
          if not (fsIsCompareLoad in lFile.FileStates) and not lFile.IsNotPlugin and
             (not Assigned(lLast) or (lFile.LoadOrder > lLast.LoadOrder)) then
            lLast := lFile;
        end;
      lLines.Add('new' + #9 + lNew.FileName + #9 + IntToStr(lNew.LoadOrder) + #9 + TestFileIDText(lNew) + #9 +
        'shares its load order with:' + lShared + '; its FileID with:' + lSharedID);
      if not Assigned(lLast) then
        raise Exception.Create('no module was loaded');

      lRefused := False;
      lMasters := TStringList.Create;
      try
        lMasters.AddObject(lLast.FileName, Pointer(lLast));
        try
          AddRequiredMasters(lMasters, lNew, True);
          var lAdded := False;
          for var m := 0 to Pred(lNew.MasterCount[True]) do
            if lNew.Masters[m, True].Equals(lLast) then
              lAdded := True;
          if lAdded then
            lLines.Add('master' + #9 + lLast.FileName + #9 + IntToStr(lLast.LoadOrder) + #9 + TestFileIDText(lLast) + #9 + 'added')
          else begin
            lRefused := True;
            lLines.Add('master' + #9 + lLast.FileName + #9 + IntToStr(lLast.LoadOrder) + #9 + TestFileIDText(lLast) + #9 +
              'not among the masters afterwards');
          end;
        except
          on E: Exception do begin
            lRefused := True;
            lLines.Add('master' + #9 + lLast.FileName + #9 + IntToStr(lLast.LoadOrder) + #9 + TestFileIDText(lLast) + #9 +
              'refused: ' + E.Message);
          end;
        end;
      finally
        lMasters.Free;
      end;
      if (lShared <> '') or (lSharedID <> '') or lRefused then
        CheckResult := 1
      else
        CheckResult := 0;
    except
      on E: Exception do begin
        AddMessage('[Test New File] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.NewFileFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.NewFileFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestGameLink;
begin
  xeContext.Settings.DontSave := True;
  TestHost.TestGameLinkTarget := nil;
  try
    if xeContext.GameDefObj.GameMode = gmTES4 then
      raise Exception.Create('Oblivion links through Pluggy''s files, which this switch does not write');
    var lModule: IwbFile := nil;
    for var lFile in Files do
      if SameText(lFile.FileName, xeTestSwitches.GameLinkModule) and not (fsIsCompareLoad in lFile.FileStates) then
        lModule := lFile;
    if not Assigned(lModule) then
      raise Exception.Create('no module ' + xeTestSwitches.GameLinkModule);
    for var j := 0 to Pred(lModule.RecordCount) do begin
      var lRecord := lModule.Records[j];
      if (lRecord.Signature <> 'TES4') and lRecord.MasterOrSelf.Equals(lRecord) and not lRecord.IsInjected then begin
        TestHost.TestGameLinkTarget := lRecord;
        Break;
      end;
    end;
    if not Assigned(TestHost.TestGameLinkTarget) then
      raise Exception.Create('no record of its own in ' + lModule.FileName);
    var lFolder := xeContext.Settings.DataPath + 'xEdit\';
    ForceDirectories(lFolder);
    TFile.WriteAllText(lFolder + 'xEditLink.ini', '[Console]'#13#10'selectedRefID=' +
      TestHost.TestGameLinkTarget.LoadOrderFormID.ToString + #13#10);
    DoSetActiveRecord(nil);
    pmuMainPopup(Self);
    if not mniMainPluggyLinkReference.Visible then
      raise Exception.Create('GameLink is not offered');
    mniMainPluggyLinkReference.Checked := True;
    mniMainPluggyLinkReference.Click;
  except
    on E: Exception do begin
      TestHost.TestGameLinkTarget := nil;
      CheckResult := 2;
      TestGameLinkWrite('# FAILED: ' + E.ClassName + ': ' + E.Message);
      Exit;
    end;
  end;
  TestHost.TestGameLinkStart := GetTickCount64;
  TestHost.TestGameLinkTimer := TTimer.Create(Self);
  TestHost.TestGameLinkTimer.Interval := 250;
  TestHost.TestGameLinkTimer.OnTimer := TestGameLinkRunTimer;
  TestHost.TestGameLinkTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestGameLinkRunTimer(Sender: TObject);
begin
  if not Assigned(ActiveRecord) and (GetTickCount64 < TestHost.TestGameLinkStart + 20000) then
    Exit;
  TestHost.TestGameLinkTimer.Enabled := False;
  var lTarget := TestHost.TestGameLinkTarget;
  TestHost.TestGameLinkTarget := nil;
  var lActive := 'none';
  if Assigned(ActiveRecord) then
    lActive := ActiveRecord.Name + #9 + ActiveRecord._File.FileName + #9 + ActiveRecord.LoadOrderFormID.ToString;
  if Assigned(ActiveRecord) and ActiveRecord.Equals(lTarget.WinningOverride) then
    CheckResult := 0
  else
    CheckResult := 1;
  TestGameLinkWrite(
    'target' + #9 + lTarget.Name + #9 + lTarget._File.FileName + #9 + lTarget.LoadOrderFormID.ToString + #13#10 +
    'active' + #9 + lActive);
end;

procedure TxeTestFormHelper.TestGameLinkWrite(const aBody: string);
var
  lLines : TStringList;
  lTmp   : string;
begin
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit GameLink probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# module = ' + xeTestSwitches.GameLinkModule);
    lLines.Add('# Columns, tab separated: what / record / file / load order FormID');
    for var lFile in Files do
      lLines.Add('file' + #9 + lFile.FileName + #9 + IntToStr(lFile.LoadOrder) + #9 + TestFileIDText(lFile));
    lLines.Add(aBody);
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.GameLinkFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.GameLinkFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestFormIDSearch;
var
  lKey : Word;
begin
  xeContext.Settings.DontSave := True;
  TestHost.TestFormIDSearchTarget := nil;
  try
    var lModule: IwbFile := nil;
    for var lFile in Files do
      if SameText(lFile.FileName, xeTestSwitches.FormIDSearchModule) and not (fsIsCompareLoad in lFile.FileStates) then
        lModule := lFile;
    if not Assigned(lModule) then
      raise Exception.Create('no module ' + xeTestSwitches.FormIDSearchModule);
    for var j := 0 to Pred(lModule.RecordCount) do begin
      var lRecord := lModule.Records[j];
      if (lRecord.Signature <> 'TES4') and lRecord.MasterOrSelf.Equals(lRecord) and not lRecord.IsInjected then begin
        TestHost.TestFormIDSearchTarget := lRecord;
        Break;
      end;
    end;
    if not Assigned(TestHost.TestFormIDSearchTarget) then
      raise Exception.Create('no record of its own in ' + lModule.FileName);
    DoSetActiveRecord(nil);
  except
    on E: Exception do begin
      TestHost.TestFormIDSearchTarget := nil;
      CheckResult := 2;
      TestFormIDSearchWrite('# FAILED: ' + E.ClassName + ': ' + E.Message);
      Exit;
    end;
  end;
  var lTarget := TestHost.TestFormIDSearchTarget;
  edFormIDSearch.Text := lTarget.LoadOrderFormID.ToString;
  lKey := VK_RETURN;
  try
    edFormIDSearchKeyDown(edFormIDSearch, lKey, []);
  except
    on E: Exception do begin
      TestHost.TestFormIDSearchTarget := nil;
      CheckResult := 1;
      TestFormIDSearchWrite(
        'target' + #9 + lTarget.Name + #9 + lTarget._File.FileName + #9 + lTarget.LoadOrderFormID.ToString + #13#10 +
        'search' + #9 + 'raised ' + E.ClassName + ': ' + E.Message);
      Exit;
    end;
  end;
  if edFormIDSearch.Color = wbLighter(clLime, 0.85) then
    TestHost.TestFormIDSearchResult := 'found, with a node'
  else if edFormIDSearch.Color = wbLighter(clYellow, 0.85) then
    TestHost.TestFormIDSearchResult := 'found, without a node'
  else if edFormIDSearch.Color = wbLighter(clRed, 0.85) then
    TestHost.TestFormIDSearchResult := 'not found'
  else
    TestHost.TestFormIDSearchResult := 'no result';
  TestHost.TestFormIDSearchStart := GetTickCount64;
  TestHost.TestFormIDSearchTimer := TTimer.Create(Self);
  TestHost.TestFormIDSearchTimer.Interval := 250;
  TestHost.TestFormIDSearchTimer.OnTimer := TestFormIDSearchRunTimer;
  TestHost.TestFormIDSearchTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestFormIDSearchRunTimer(Sender: TObject);
begin
  if not Assigned(ActiveRecord) and (GetTickCount64 < TestHost.TestFormIDSearchStart + 20000) then
    Exit;
  TestHost.TestFormIDSearchTimer.Enabled := False;
  var lTarget := TestHost.TestFormIDSearchTarget;
  TestHost.TestFormIDSearchTarget := nil;
  var lActive := 'none';
  if Assigned(ActiveRecord) then
    lActive := ActiveRecord.Name + #9 + ActiveRecord._File.FileName + #9 + ActiveRecord.LoadOrderFormID.ToString;
  if Assigned(ActiveRecord) and ActiveRecord.Equals(lTarget) then
    CheckResult := 0
  else
    CheckResult := 1;
  TestFormIDSearchWrite(
    'target' + #9 + lTarget.Name + #9 + lTarget._File.FileName + #9 + lTarget.LoadOrderFormID.ToString + #13#10 +
    'search' + #9 + TestHost.TestFormIDSearchResult + #13#10 +
    'active' + #9 + lActive);
end;

procedure TxeTestFormHelper.TestFormIDSearchWrite(const aBody: string);
var
  lLines : TStringList;
  lTmp   : string;
begin
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit FormID search probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# module = ' + xeTestSwitches.FormIDSearchModule);
    lLines.Add('# Columns, tab separated: what / record / file / load order FormID');
    for var lFile in Files do
      lLines.Add('file' + #9 + lFile.FileName + #9 + IntToStr(lFile.LoadOrder) + #9 + TestFileIDText(lFile));
    lLines.Add(aBody);
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.FormIDSearchFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.FormIDSearchFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestSplitTreeLOD;
var
  lLines  : TStringList;
  lStage  : string;
  lTmp    : string;
begin
  xeContext.Settings.DontSave := True;
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit split-tree-LOD probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# world = ' + xeTestSwitches.SplitTreeLODWorld + ', light modules created = ' +
      IntToStr(xeTestSwitches.SplitTreeLODLight) + ', output = ' + xeContext.Settings.OutputPath);
    CheckResult := 2;
    lStage := 'setup';
    try
      for var i := 1 to xeTestSwitches.SplitTreeLODLight do
        if not Assigned(AddNewFileName(Format('xeLodProbe%.4d.esp', [i]), True, False)) then
          raise Exception.Create('no light module ' + IntToStr(i) + ' was created');
      var lMax := -1;
      for var lFile in Files do
        if lFile.LoadOrder > lMax then
          lMax := lFile.LoadOrder;
      lLines.Add('files' + #9 + IntToStr(Length(Files)) + #9 + 'highest load order ' + IntToStr(lMax));
      var lWorld := Files[0].RecordByFormID[TwbFormID.FromStr(xeTestSwitches.SplitTreeLODWorld), True, True];
      if not Assigned(lWorld) or (lWorld.Signature <> 'WRLD') then
        raise Exception.Create('no worldspace ' + xeTestSwitches.SplitTreeLODWorld + ' in ' + Files[0].FileName);
      lLines.Add('world' + #9 + lWorld.Name);
      var lFolder := xeContext.Settings.OutputPath + 'Textures\Terrain\LODGen\';
      if TDirectory.Exists(lFolder) and (Length(TDirectory.GetFiles(lFolder, '*', TSearchOption.soAllDirectories)) > 0) then
        raise Exception.Create('the output folder already holds files: ' + lFolder);
      lStage := 'split';
      wbSplitTreeLOD(lWorld, Files);
      var lWritten := 0;
      if TDirectory.Exists(lFolder) then
        lWritten := Length(TDirectory.GetFiles(lFolder, '*.dds', TSearchOption.soAllDirectories));
      lLines.Add('written' + #9 + IntToStr(lWritten) + ' billboard textures');
      if lWritten > 0 then
        CheckResult := 0
      else
        CheckResult := 1;
    except
      on E: Exception do begin
        if lStage = 'split' then
          CheckResult := 1;
        AddMessage('[Test Split Tree LOD] FAILED in ' + lStage + ': ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED in ' + lStage + ': ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.SplitTreeLODFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.SplitTreeLODFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestDropMaster;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  TestHost.TestDropMasterTimer := TTimer.Create(Self);
  TestHost.TestDropMasterTimer.Interval := 500;
  TestHost.TestDropMasterTimer.OnTimer := TestDropMasterRunTimer;
  TestHost.TestDropMasterTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestDropMasterAnswerTimer(Sender: TObject);

  procedure Detach;
  begin
    if not Assigned(TestHost.TestDropMasterDetach) then
      Exit;
    TestHost.TestDropMasterDetach.Remove;
    TestHost.TestDropMasterDetach := nil;
    TestHost.TestDropMasterSeen := TestHost.TestDropMasterSeen + '(detached)';
  end;

begin
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      TestHost.TestDropMasterSeen := TestHost.TestDropMasterSeen + ' ' + Screen.CustomForms[i].ClassName;
      Detach;
      Screen.CustomForms[i].ModalResult := mrYes;
      Exit;
    end;
  var lWnd: HWND := 0;
  repeat
    lWnd := FindWindowEx(0, lWnd, '#32770', nil);
    if (lWnd <> 0) and IsWindowVisible(lWnd) and IsWindowEnabled(lWnd) and
       (GetWindowThreadProcessId(lWnd, nil) = MainThreadID) then begin
      TestHost.TestDropMasterSeen := TestHost.TestDropMasterSeen + ' #32770';
      Detach;
      SendMessage(lWnd, WM_USER + 102, IDYES, 0);
      Exit;
    end;
  until lWnd = 0;
end;

procedure TxeTestFormHelper.TestDropMasterRunTimer(Sender: TObject);

  function ElementText(const aElement: IwbElement): string;
  var
    lContainer : IwbContainerElementRef;
  begin
    if Supports(aElement, IwbContainerElementRef, lContainer) and (lContainer.ElementCount > 0) then begin
      Result := '';
      for var i := 0 to Pred(lContainer.ElementCount) do begin
        if i > 0 then
          Result := Result + ' | ';
        Result := Result + ElementText(lContainer.Elements[i]);
      end;
    end else
      Result := aElement.EditValue;
  end;

  function FindRecord(const aSpec: string): IwbMainRecord;
  begin
    Result := nil;
    var lAt := Pos('@', aSpec);
    if lAt < 2 then
      raise Exception.Create('not <FormID>@<module>: ' + aSpec);
    var lFormID := TwbFormID.FromStr(Copy(aSpec, 1, Pred(lAt)));
    var lModule := Copy(aSpec, Succ(lAt), MaxInt);
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, lModule) then
        Result := Files[i].RecordByFormID[lFormID, True, True];
    if not Assigned(Result) then
      raise Exception.Create('no record ' + aSpec);
  end;

  function MasterNames(const aFile: IwbFile): string;
  begin
    Result := '';
    for var i := 0 to Pred(aFile.MasterCount[True]) do
      Result := Result + ' ' + aFile.Masters[i, True].FileName;
    Result := Trim(Result);
  end;

  function RecordState(const aRecord: IwbMainRecord): string;
  begin
    Result := aRecord.Name + #9 + 'modified=' + BoolToStr(aRecord.Modified, True) + #9 +
      'internal=' + BoolToStr(esInternalModified in aRecord.ElementStates, True);
  end;

  function FirstElement(const aRecord: IwbMainRecord; const aName: string): IwbElement;
  var
    lContainer : IwbContainerElementRef;
  begin
    if not Supports(aRecord.ElementByName[aName], IwbContainerElementRef, lContainer) or (lContainer.ElementCount < 1) then
      raise Exception.Create('no element in ' + aName + ' of ' + aRecord.Name);
    Result := lContainer.Elements[0];
  end;

  procedure TagContainer(const aRecord: IwbMainRecord; const aName: string);
  var
    lElement : IwbElement;
  begin
    lElement := aRecord.ElementByName[aName];
    if not Assigned(lElement) then
      raise Exception.Create('no ' + aName + ' in ' + aRecord.Name);
    lElement.SetElementState(esTagged);
  end;

  function ContainerTagged(const aRecord: IwbMainRecord; const aName: string): Boolean;
  var
    lElement : IwbElement;
  begin
    lElement := aRecord.ElementByName[aName];
    Result := Assigned(lElement) and (esTagged in lElement.ElementStates);
  end;

  procedure AddMastersOnly(aLines: TStrings; const aTarget, aSource: IwbMainRecord; const aName: string; aHeld: Boolean);
  var
    lSourceElement : IwbElement;
    lHeld          : IwbElement;
  begin
    if aHeld then
      DoSetActiveRecord(aTarget)
    else
      DoSetActiveRecord(aSource);
    lSourceElement := FirstElement(aSource, aName);
    aLines.Add('source' + #9 + aSource.Name + #9 + ElementText(lSourceElement));
    TagContainer(aTarget, aName);
    if aHeld then
      lHeld := aTarget.ElementByName[aName];
    aLines.Add('masters' + #9 + 'added silently' + #9 + BoolToStr(AddRequiredMasters(lSourceElement, aTarget._File, False, True), True));
    aLines.Add('masters' + #9 + 'after' + #9 + MasterNames(aTarget._File));
    aLines.Add('target' + #9 + 'after' + #9 + RecordState(aTarget));
    aLines.Add('container' + #9 + 'kept' + #9 + BoolToStr(ContainerTagged(aTarget, aName), True));
    aLines.Add('container' + #9 + 'held' + #9 + BoolToStr(Assigned(lHeld), True));
  end;

var
  lLines     : TStringList;
  lSpec      : TArray<string>;
  lTarget    : IwbMainRecord;
  lSource    : IwbMainRecord;
  lColumn    : Integer;
  lNode      : PVirtualNode;
  lContainer : IwbContainerElementRef;
  lCaptured  : IwbElement;
  lSourceElement : IwbElement;
  lTmp       : string;
begin
  TestHost.TestDropMasterTimer.Enabled := False;
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit drop-adds-master probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# spec = ' + xeTestSwitches.DropMasterSpec);
    lLines.Add('# Columns, tab separated: what / detail / value');
    CheckResult := 2;
    try
      lSpec := xeTestSwitches.DropMasterSpec.Split([',']);
      if Length(lSpec) <> 4 then
        raise Exception.Create('the spec needs four parts');
      lTarget := FindRecord(lSpec[0]);
      lSource := FindRecord(lSpec[1]);
      var lFile := lTarget._File;
      lLines.Add('masters' + #9 + 'before' + #9 + MasterNames(lFile));
      if SameText(lSpec[3], 'modified') then
        lTarget.ElementEditValues['EDID'] := lTarget.EditorID + 'X';
      lLines.Add('target' + #9 + 'before' + #9 + RecordState(lTarget));

      if SameText(lSpec[3], 'mastersonly') or SameText(lSpec[3], 'unheld') then
        AddMastersOnly(lLines, lTarget, lSource, lSpec[2], SameText(lSpec[3], 'mastersonly'))
      else begin
        DoSetActiveRecord(lTarget);
        vstView.FullExpand;
        lColumn := -1;
        for var i := Low(ActiveRecords) to High(ActiveRecords) do
          if Assigned(ActiveRecords[i].Element) and ActiveRecords[i].Element.Equals(lTarget) then
            lColumn := i;
        if lColumn < 0 then
          raise Exception.Create('the target is not a column of the View tab');

        if not Supports(lTarget.ElementByName[lSpec[2]], IwbContainerElementRef, lContainer) then
          raise Exception.Create('no container ' + lSpec[2] + ' in the target');
        lSourceElement := FirstElement(lSource, lSpec[2]);
        var lTargetNode: PVirtualNode := nil;
        for lNode in vstView.Nodes(False) do begin
          var lDatas := ViewCells(lNode);
          if Assigned(lDatas) and Assigned(lDatas[lColumn].Element) and lDatas[lColumn].Element.Equals(lContainer) then begin
            lTargetNode := lNode;
            Break;
          end;
        end;
        if not Assigned(lTargetNode) then
          raise Exception.Create('no View tab row for ' + lContainer.Path);
        lLines.Add('drop target' + #9 + IntToStr(lColumn) + #9 + lContainer.Path);
        lLines.Add('source' + #9 + lSource.Name + #9 + ElementText(lSourceElement));
        lLines.Add('before' + #9 + IntToStr(lContainer.ElementCount) + #9 + ElementText(lContainer));
        lCaptured := lContainer;
        lContainer := nil;

        if SameText(lSpec[3], 'detach') then
          TestHost.TestDropMasterDetach := lCaptured;
        TestHost.TestDropMasterSeen := '';
        TestHost.TestDropMasterAnswer := TTimer.Create(Self);
        try
          TestHost.TestDropMasterAnswer.Interval := 100;
          TestHost.TestDropMasterAnswer.OnTimer := TestDropMasterAnswerTimer;
          TestHost.TestDropMasterAnswer.Enabled := True;
          try
            lLines.Add('drop' + #9 + 'performed' + #9 + BoolToStr(PerformDrop(vstView, lTargetNode, Succ(lColumn), lSourceElement), True));
          except
            on E: Exception do
              lLines.Add('drop' + #9 + 'raised' + #9 + E.ClassName + ': ' + E.Message);
          end;
        finally
          FreeAndNil(TestHost.TestDropMasterAnswer);
          TestHost.TestDropMasterDetach := nil;
        end;
        lLines.Add('dialogs' + #9 + '-' + #9 + Trim(TestHost.TestDropMasterSeen));
        lLines.Add('masters' + #9 + 'after' + #9 + MasterNames(lFile));
        lLines.Add('target' + #9 + 'after' + #9 + RecordState(lTarget));

        var lInRecord := False;
        var lParent := lCaptured.Container;
        while Assigned(lParent) and not lInRecord do begin
          lInRecord := (lParent as TObject) = (lTarget as TObject);
          lParent := lParent.Container;
        end;
        lLines.Add('captured' + #9 + 'in target' + #9 + BoolToStr(lInRecord, True));
        if Supports(lTarget.ElementByName[lSpec[2]], IwbContainerElementRef, lContainer) then begin
          lLines.Add('current' + #9 + 'is captured' + #9 + BoolToStr((lContainer as TObject) = (lCaptured as TObject), True));
          lLines.Add('after' + #9 + IntToStr(lContainer.ElementCount) + #9 + ElementText(lContainer));
          var lFound := False;
          var lWanted := ElementText(lSourceElement);
          for var i := 0 to Pred(lContainer.ElementCount) do
            if ElementText(lContainer.Elements[i]) = lWanted then
              lFound := True;
          lLines.Add('copy' + #9 + 'in target' + #9 + BoolToStr(lFound, True));
        end else
          lLines.Add('copy' + #9 + 'in target' + #9 + 'False (no ' + lSpec[2] + ')');
      end;
      CheckResult := 0;
    except
      on E: Exception do begin
        AddMessage('[Test Drop Master] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.DropMasterFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.DropMasterFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.TestDeltaPatchStates(const aWhen: string);
var
  lRecord : IwbMainRecord;
begin
  for var i := Low(Files) to High(Files) do
    TestHost.TestDeltaPatchLines.Add('file' + #9 + aWhen + #9 + Files[i].FileName + #9 +
      'member=' + BoolToStr(ConflictView.Hidden.Contains(Files[i]), True) + #9 + 'hidden=' + BoolToStr(ConflictView.Hidden.IsHidden(Files[i]), True));
  if xeTestSwitches.DeltaPatchHideRecord = '' then
    Exit;
  lRecord := nil;
  if Assigned(TestHost.TestDeltaPatchMasterFile) then
    lRecord := TestHost.TestDeltaPatchMasterFile.RecordByFormID[TwbFormID.FromStr(xeTestSwitches.DeltaPatchHideRecord), True, True];
  if Assigned(lRecord) then
    TestHost.TestDeltaPatchLines.Add('record' + #9 + aWhen + #9 + lRecord.Name + #9 +
      'member=' + BoolToStr(ConflictView.Hidden.Contains(lRecord), True) + #9 + 'hidden=' + BoolToStr(ConflictView.Hidden.IsHidden(lRecord), True));
end;

procedure TxeTestFormHelper.TestDeltaPatchWrite;
var
  lTmp : string;
begin
  try
    TestHost.TestDeltaPatchLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.DeltaPatchFile + '.partial';
    TestHost.TestDeltaPatchLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.DeltaPatchFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    FreeAndNil(TestHost.TestDeltaPatchLines);
    TestHost.TestDeltaPatchMasterFile := nil;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.TestDeltaPatchLoad(const aMaster: IwbFile);
var
  lRecord : IwbMainRecord;
  lTarget : string;
begin
  TestHost.TestDeltaPatchMasterFile := aMaster;
  TestDeltaPatchStates('loaded');
  if xeTestSwitches.DeltaPatchHide <> '' then
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, xeTestSwitches.DeltaPatchHide) then
        ConflictView.Hidden.Hide(Files[i]);
  if xeTestSwitches.DeltaPatchHideRecord <> '' then begin
    lRecord := aMaster.RecordByFormID[TwbFormID.FromStr(xeTestSwitches.DeltaPatchHideRecord), True, True];
    if not Assigned(lRecord) then
      raise Exception.Create('no record ' + xeTestSwitches.DeltaPatchHideRecord + ' in ' + aMaster.FileName);
    ConflictView.Hidden.Hide(lRecord);
  end;
  TestDeltaPatchStates('before');

  lTarget := xeContext.Settings.DataPath + xeTestSwitches.DeltaPatchName + '.esu';
  if FileExists(lTarget) then
    raise Exception.Create(lTarget + ' already exists');
  if not CopyFile(PChar(xeTestSwitches.DeltaPatchNewer), PChar(lTarget), True) then
    RaiseLastOSError;
  TestHost.TestDeltaPatchLines.Add('# delta patch file = ' + lTarget);

  vstNav.PopupMenu := nil;
  bnMainMenu.Enabled := False;
  xeContext.LoaderDone := False;
  xeContext.LoaderError := False;
  DoSetActiveRecord(nil);
  mniNavFilterRemoveClick(Self);
  wbStartTime := Now;
  DoSetActiveRecord(nil);
  pgMain.ActivePage := tbsMessages;
  TLoaderThread.Create(lTarget, aMaster, [fsIsDeltaPatch]);
  if xeTestSwitches.DeltaPatchCancel then begin
    TestHost.TestDeltaPatchTimer := TTimer.Create(Self);
    TestHost.TestDeltaPatchTimer.Interval := 50;
    TestHost.TestDeltaPatchTimer.OnTimer := TestDeltaPatchCancelTimer;
    TestHost.TestDeltaPatchTimer.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestDeltaPatchStart;
var
  lMaster : IwbFile;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  CheckResult := 2;
  TestHost.TestDeltaPatchLines := TStringList.Create;
  TestHost.TestDeltaPatchLines.Add('# xEdit delta patch probe');
  TestHost.TestDeltaPatchLines.Add('# ' + xeApplicationTitle);
  TestHost.TestDeltaPatchLines.Add('# master = ' + xeTestSwitches.DeltaPatchMaster + ', newer = ' + xeTestSwitches.DeltaPatchNewer +
    ', name = ' + xeTestSwitches.DeltaPatchName + ', hide = ' + xeTestSwitches.DeltaPatchHide + ', hide record = ' + xeTestSwitches.DeltaPatchHideRecord);
  if xeTestSwitches.DeltaPatchCompareTo <> '' then
    TestHost.TestDeltaPatchLines.Add('# compare to = ' + xeTestSwitches.DeltaPatchCompareTo);
  TestHost.TestDeltaPatchLines.Add('# Columns, tab separated: what / when / name / states');
  try
    lMaster := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, xeTestSwitches.DeltaPatchMaster) then
        lMaster := Files[i];
    if not Assigned(lMaster) then
      raise Exception.Create('no module ' + xeTestSwitches.DeltaPatchMaster);
    if xeTestSwitches.DeltaPatchCompareTo <> '' then begin
      TestHost.TestDeltaPatchComparing := True;
      DoCompareTo(lMaster, xeTestSwitches.DeltaPatchCompareTo);
      if xeContext.LoaderDone then begin
        TestHost.TestDeltaPatchComparing := False;
        raise Exception.Create('the compare load of ' + xeTestSwitches.DeltaPatchCompareTo + ' did not start');
      end;
      Exit;
    end;
    TestDeltaPatchLoad(lMaster);
  except
    on E: Exception do begin
      AddMessage('[Test Delta Patch] FAILED: ' + E.ClassName + ': ' + E.Message);
      TestHost.TestDeltaPatchLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      TestDeltaPatchWrite;
    end;
  end;
end;

procedure TxeTestFormHelper.TestDeltaPatchSecondTimer(Sender: TObject);
var
  lTarget : string;
begin
  TestHost.TestDeltaPatchTimer.Enabled := False;
  try
    lTarget := xeContext.Settings.DataPath + xeTestSwitches.DeltaPatchName + '2.esu';
    if FileExists(lTarget) then
      raise Exception.Create(lTarget + ' already exists');
    if not CopyFile(PChar(xeTestSwitches.DeltaPatchSecond), PChar(lTarget), True) then
      RaiseLastOSError;
    TestHost.TestDeltaPatchLines.Add('# second delta patch file = ' + lTarget);
    vstNav.PopupMenu := nil;
    bnMainMenu.Enabled := False;
    xeContext.LoaderDone := False;
    xeContext.LoaderError := False;
    DoSetActiveRecord(nil);
    mniNavFilterRemoveClick(Self);
    wbStartTime := Now;
    pgMain.ActivePage := tbsMessages;
    TLoaderThread.Create(lTarget, TestHost.TestDeltaPatchMasterFile, [fsIsDeltaPatch]);
  except
    on E: Exception do begin
      AddMessage('[Test Delta Patch] FAILED: ' + E.ClassName + ': ' + E.Message);
      TestHost.TestDeltaPatchLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      TestDeltaPatchWrite;
    end;
  end;
end;

procedure TxeTestFormHelper.TestDeltaPatchCancelTimer(Sender: TObject);
begin
  if not Assigned(TestHost.TestDeltaPatchLines) then begin
    TestHost.TestDeltaPatchTimer.Enabled := False;
    Exit;
  end;
  if not TestHost.TestDeltaPatchCancelled then begin
    if SameText(wbCurrentAction, 'Applying Filter') then begin
      AddMessage('[Test Delta Patch] cancelling the delta patch while "' + wbCurrentAction + '" runs');
      TestHost.TestDeltaPatchLines.Add('# cancelled while: ' + wbCurrentAction);
      TestHost.TestDeltaPatchCancelled := True;
      wbForceTerminate := True;
    end;
  end else if not SameText(wbCurrentAction, 'Applying Filter') and not SameText(wbCurrentAction, 'Creating Delta Patch') then begin
    TestHost.TestDeltaPatchTimer.Enabled := False;
    wbForceTerminate := False;
    DoTestDeltaPatchReport;
  end;
end;

procedure TxeTestFormHelper.DoTestDeltaPatchReport;

  procedure AddTree(const aContainer: IwbContainer; aDepth: Integer);
  var
    lGroup  : IwbGroupRecord;
    lRecord : IwbMainRecord;
  begin
    for var i := 0 to Pred(aContainer.ElementCount) do
      if Supports(aContainer.Elements[i], IwbGroupRecord, lGroup) then begin
        TestHost.TestDeltaPatchLines.Add('patchtree' + #9 + IntToStr(aDepth) + #9 + 'GRUP' + #9 + IntToStr(lGroup.GroupType) + #9 +
          IntToHex(lGroup.GroupLabel, 8));
        AddTree(lGroup, Succ(aDepth));
      end else if Supports(aContainer.Elements[i], IwbMainRecord, lRecord) then
        TestHost.TestDeltaPatchLines.Add('patchtree' + #9 + IntToStr(aDepth) + #9 + string(lRecord.Signature) + #9 +
          IntToHex(lRecord.LoadOrderFormID.ToCardinal, 8) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);
  end;

var
  lRecord : IwbMainRecord;
  lStream : TMemoryStream;
begin
  if not Assigned(TestHost.TestDeltaPatchLines) then
    Exit;
  if TestHost.TestDeltaPatchComparing then begin
    TestHost.TestDeltaPatchComparing := False;
    try
      if xeContext.LoaderError or wbForceTerminate then
        raise Exception.Create('the compare load failed or was cancelled');
      var lCopy: IwbFile := nil;
      for var i := High(Files) downto Low(Files) do
        if (fsIsCompareLoad in Files[i].FileStates) and not (fsIsDeltaPatch in Files[i].FileStates) and
           Assigned(Files[i].CompareToFile) and SameText(Files[i].CompareToFile.FileName, xeTestSwitches.DeltaPatchMaster) then begin
          lCopy := Files[i];
          Break;
        end;
      if not Assigned(lCopy) then
        raise Exception.Create('no compare copy of ' + xeTestSwitches.DeltaPatchMaster + ' is loaded');
      TestHost.TestDeltaPatchLines.Add('# the delta patch is loaded against the compare copy ' + lCopy.FileName);
      TestDeltaPatchLoad(lCopy);
    except
      on E: Exception do begin
        AddMessage('[Test Delta Patch] FAILED: ' + E.ClassName + ': ' + E.Message);
        TestHost.TestDeltaPatchLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
        TestDeltaPatchWrite;
      end;
    end;
    Exit;
  end;
  if (xeTestSwitches.DeltaPatchSecond <> '') and not TestHost.TestDeltaPatchSecondDone then begin
    TestHost.TestDeltaPatchSecondDone := True;
    TestHost.TestDeltaPatchLines.Add('# the first delta patch load failed: ' + BoolToStr(xeContext.LoaderError, True) +
      '; the second follows');
    TestHost.TestDeltaPatchTimer := TTimer.Create(Self);
    TestHost.TestDeltaPatchTimer.Interval := 50;
    TestHost.TestDeltaPatchTimer.OnTimer := TestDeltaPatchSecondTimer;
    TestHost.TestDeltaPatchTimer.Enabled := True;
    Exit;
  end;
  try
    if xeContext.LoaderError then
      raise Exception.Create('the delta patch load failed');
    TestDeltaPatchStates('after');
    var lFound := False;
    for var i := Low(Files) to High(Files) do
      if fsIsDeltaPatch in Files[i].FileStates then begin
        lFound := True;
        TestHost.TestDeltaPatchLines.Add('patch' + #9 + Files[i].FileName + #9 + 'records ' + IntToStr(Files[i].RecordCount));
        if (xeTestSwitches.DeltaPatchCompareTo <> '') and Assigned(Files[i].CompareToFile) then
          TestHost.TestDeltaPatchLines.Add('patchmaster' + #9 + Files[i].CompareToFile.FileName);
        for var j := 0 to Pred(Files[i].RecordCount) do begin
          lRecord := Files[i].Records[j];
          TestHost.TestDeltaPatchLines.Add('patchrecord' + #9 + string(lRecord.Signature) + #9 + IntToHex(lRecord.LoadOrderFormID.ToCardinal, 8) + #9 +
            'deleted=' + BoolToStr(lRecord.IsDeleted, True) + #9 + lRecord.EditorID);
        end;
        AddTree(Files[i], 0);
        for var lInfo in LOOTPluginInfos do
          TestHost.TestDeltaPatchLines.Add('loot' + #9 + lInfo.Plugin + #9 + IntToHex(lInfo.CRC32, 8) + #9 + 'itm=' + IntToStr(lInfo.ITM));
        lStream := TMemoryStream.Create;
        try
          Files[i].WriteToStream(lStream, rmNo);
          Files[i].SetElementState(esUnsaved, True);
          TestHost.TestDeltaPatchLines.Add('patchbytes' + #9 + IntToStr(lStream.Size) + #9 + IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
          if xeTestSwitches.DeltaPatchSave <> '' then begin
            lStream.SaveToFile(xeTestSwitches.DeltaPatchSave);
            TestHost.TestDeltaPatchLines.Add('patchsaved' + #9 + xeTestSwitches.DeltaPatchSave);
          end;
        finally
          lStream.Free;
        end;
      end;
    if not lFound then
      raise Exception.Create('no delta patch file is loaded');
    if xeTestSwitches.DeltaPatchCompareTo <> '' then begin
      var lPaired := False;
      for var i := Low(Files) to High(Files) do
        if (fsIsDeltaPatch in Files[i].FileStates) and Assigned(Files[i].CompareToFile) and
           Files[i].CompareToFile.Equals(TestHost.TestDeltaPatchMasterFile) then
          lPaired := True;
      if not lPaired then
        raise Exception.Create('no delta patch is loaded against the compare copy');
    end;
    CheckResult := 0;
  except
    on E: Exception do begin
      AddMessage('[Test Delta Patch] FAILED: ' + E.ClassName + ': ' + E.Message);
      TestHost.TestDeltaPatchLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
  TestDeltaPatchWrite;
end;

procedure TxeTestFormHelper.DoTestMerge;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  CheckResult := 2;
  TestHost.TestMergeLines := TStringList.Create;
  TestHost.TestMergeLines.Add('# xEdit merge into master probe');
  TestHost.TestMergeLines.Add('# ' + xeApplicationTitle);
  TestHost.TestMergeLines.Add('# source = ' + xeTestSwitches.MergeSource + ', target = ' + xeTestSwitches.MergeTarget + ', out = ' + xeTestSwitches.MergeOut);
  TestHost.TestMergeLines.Add('# Columns, tab separated: what / details');
  TestHost.TestMergeTimer := TTimer.Create(Self);
  TestHost.TestMergeTimer.Interval := 500;
  TestHost.TestMergeTimer.OnTimer := TestMergeRunTimer;
  TestHost.TestMergeTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestMergeRunTimer(Sender: TObject);

  function OwnRecords(const aFile: IwbFile): Integer;
  begin
    Result := 0;
    var lLayout := xeContext.SlotLayout;
    for var i := 0 to Pred(aFile.RecordCount) do
      if aFile.Records[i].LoadOrderFormID.FileID[lLayout] = aFile.LoadOrderFileID then
        Inc(Result);
  end;

  procedure AddTree(const aContainer: IwbContainer; aDepth: Integer);
  var
    lGroup  : IwbGroupRecord;
    lRecord : IwbMainRecord;
  begin
    for var i := 0 to Pred(aContainer.ElementCount) do
      if Supports(aContainer.Elements[i], IwbGroupRecord, lGroup) then begin
        TestHost.TestMergeLines.Add('targettree' + #9 + IntToStr(aDepth) + #9 + 'GRUP' + #9 + IntToStr(lGroup.GroupType) + #9 +
          IntToHex(lGroup.GroupLabel, 8));
        AddTree(lGroup, Succ(aDepth));
      end else if Supports(aContainer.Elements[i], IwbMainRecord, lRecord) then
        TestHost.TestMergeLines.Add('targettree' + #9 + IntToStr(aDepth) + #9 + string(lRecord.Signature) + #9 +
          IntToHex(lRecord.LoadOrderFormID.ToCardinal, 8) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);
  end;

var
  lSource : IwbFile;
  lTarget : IwbFile;
  lNode   : PVirtualNode;
  lBefore : Integer;
  lGroups : Integer;
  lStream : TMemoryStream;
begin
  TestHost.TestMergeTimer.Enabled := False;
  try
    lSource := nil;
    lTarget := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, xeTestSwitches.MergeSource) then
        lSource := Files[i]
      else if SameText(Files[i].FileName, xeTestSwitches.MergeTarget) then
        lTarget := Files[i];
    if not Assigned(lSource) or not Assigned(lTarget) then
      raise Exception.Create(xeTestSwitches.MergeSource + ' and ' + xeTestSwitches.MergeTarget + ' must both be loaded');
    TestHost.TestMergeTarget := lTarget;
    TestHost.TestMergeLines.Add('source' + #9 + lSource.FileName + #9 + 'records ' + IntToStr(lSource.RecordCount) + #9 +
      'own ' + IntToStr(OwnRecords(lSource)));
    TestHost.TestMergeLines.Add('target' + #9 + lTarget.FileName + #9 + 'records ' + IntToStr(lTarget.RecordCount));

    TestHost.TestMergeAnswer := TTimer.Create(Self);
    TestHost.TestMergeAnswer.Interval := 100;
    TestHost.TestMergeAnswer.OnTimer := TestMergeAnswerTimer;
    TestHost.TestMergeAnswer.Enabled := True;

    lNode := FindNodeForElement(lSource);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + lSource.FileName);
    vstNav.ClearSelection;
    vstNav.Selected[lNode] := True;
    vstNav.FocusedNode := lNode;
    lBefore := OwnRecords(lSource);
    mniNavRenumberFormIDsFromClick(mniNavRenumberFormIDsInject);
    if TestHost.TestMergeNotOffered then
      raise Exception.Create(lTarget.FileName + ' was not offered by the inject''s module picker');
    TestHost.TestMergeLines.Add('inject' + #9 + 'own records before ' + IntToStr(lBefore) + ', after ' + IntToStr(OwnRecords(lSource)));

    vstNav.ClearSelection;
    lGroups := 0;
    for var i := 0 to Pred(lSource.ElementCount) do
      if Supports(lSource.Elements[i], IwbGroupRecord) then begin
        lNode := FindNodeForElement(lSource.Elements[i]);
        if not Assigned(lNode) then
          raise Exception.Create('no nav node for ' + lSource.Elements[i].Name);
        vstNav.Selected[lNode] := True;
        if lGroups = 0 then
          vstNav.FocusedNode := lNode;
        Inc(lGroups);
        TestHost.TestMergeLines.Add('selected' + #9 + lSource.Elements[i].Name);
      end;
    if lGroups > 0 then
      mniNavCopyIntoClick(mniNavDeepCopyAsOverrideWithOverwriting)
    else
      TestHost.TestMergeLines.Add('copy' + #9 + 'no top level group in ' + lSource.FileName + ', nothing to copy');
    TestHost.TestMergeAnswer.Enabled := False;
    if TestHost.TestMergeNotOffered then
      raise Exception.Create(lTarget.FileName + ' was not offered by the copy''s module picker');

    TestHost.TestMergeLines.Add('target' + #9 + lTarget.FileName + #9 + 'records ' + IntToStr(lTarget.RecordCount) + #9 +
      'masters ' + IntToStr(lTarget.MasterCount[True]));
    AddTree(lTarget, 0);
    lStream := TMemoryStream.Create;
    try
      lTarget.WriteToStream(lStream, rmNo);
      lTarget.SetElementState(esUnsaved, True);
      lStream.SaveToFile(xeTestSwitches.MergeOut);
      TestHost.TestMergeLines.Add('merged' + #9 + xeTestSwitches.MergeOut + #9 + IntToStr(lStream.Size) + #9 +
        IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
    finally
      lStream.Free;
    end;
    CheckResult := 0;
  except
    on E: Exception do begin
      AddMessage('[Test Merge] FAILED: ' + E.ClassName + ': ' + E.Message);
      TestHost.TestMergeLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
  if Assigned(TestHost.TestMergeAnswer) then
    TestHost.TestMergeAnswer.Enabled := False;
  TestMergeWrite;
end;

procedure TxeTestFormHelper.TestMergeAnswerTimer(Sender: TObject);
var
  lForm   : TCustomForm;
  lResult : TModalResult;
  lText   : string;

  function HasButton(aOwner: TComponent; aResult: TModalResult): Boolean;
  begin
    Result := False;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if (aOwner.Components[i] is TButton) and (TButton(aOwner.Components[i]).ModalResult = aResult) then
        Exit(True);
      if HasButton(aOwner.Components[i], aResult) then
        Exit(True);
    end;
  end;

  procedure CollectText(aOwner: TComponent);
  begin
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

begin
  if not Assigned(TestHost.TestMergeLines) then
    Exit;
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then
    Exit;
  lText := '';
  CollectText(lForm);
  lResult := mrNone;
  if lForm is TfrmModuleSelect then begin
    var lOffered := False;
    for var lInfo in TfrmModuleSelect(lForm).AllModules do
      if lInfo = PwbModuleInfo(TestHost.TestMergeTarget.ModuleInfo) then
        lOffered := True;
    if lOffered then begin
      Include(PwbModuleInfo(TestHost.TestMergeTarget.ModuleInfo).miFlags, mfTagged);
      lResult := mrOk;
    end else begin
      TestHost.TestMergeNotOffered := True;
      lResult := mrCancel;
    end;
  end else if HasButton(lForm, mrYesToAll) then
    lResult := mrYesToAll
  else if HasButton(lForm, mrYes) then
    lResult := mrYes
  else if HasButton(lForm, mrOk) then
    lResult := mrOk;
  if lResult = mrNone then
    Exit;
  lText := lText.Replace(#13, ' ').Replace(#10, ' ');
  if Length(lText) > 300 then
    lText := Copy(lText, 1, 300) + '...';
  TestHost.TestMergeLines.Add('answer' + #9 + lForm.Caption + #9 + IntToStr(lResult) + #9 + lText.Trim);
  lForm.ModalResult := lResult;
end;

procedure TxeTestFormHelper.TestMergeWrite;
var
  lTmp : string;
begin
  try
    TestHost.TestMergeLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.MergeFile + '.partial';
    TestHost.TestMergeLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.MergeFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    FreeAndNil(TestHost.TestMergeLines);
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestMergedPatch;
begin
  xeContext.Settings.DontSave := True;
  CheckResult := 2;
  TestHost.TestMergedPatchLines := TStringList.Create;
  TestHost.TestMergedPatchLines.Add('# xEdit create merged patch probe');
  TestHost.TestMergedPatchLines.Add('# ' + xeApplicationTitle);
  TestHost.TestMergedPatchLines.Add('# name = ' + xeTestSwitches.MergedPatchName + ', out = ' + xeTestSwitches.MergedPatchOut +
    ', answer = ' + xeTestSwitches.MergedPatchAnswer);
  TestHost.TestMergedPatchLines.Add('# Columns, tab separated: what / details');
  TestHost.TestMergedPatchTimer := TTimer.Create(Self);
  TestHost.TestMergedPatchTimer.Interval := 500;
  TestHost.TestMergedPatchTimer.OnTimer := TestMergedPatchRunTimer;
  TestHost.TestMergedPatchTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestMergedPatchRunTimer(Sender: TObject);
begin
  TestHost.TestMergedPatchTimer.Enabled := False;
  try
    for var i := Low(Files) to High(Files) do
      TestHost.TestMergedPatchLines.Add('file' + #9 + IntToStr(i) + #9 + IntToStr(Files[i].LoadOrder) + #9 + Files[i].FileName);
    var lContextFiles := xeContext.Files;
    for var i := Low(lContextFiles) to High(lContextFiles) do
      TestHost.TestMergedPatchLines.Add('contextfile' + #9 + IntToStr(i) + #9 + IntToStr(lContextFiles[i].LoadOrder) + #9 +
        lContextFiles[i].FileName);
    TestHost.TestMergedPatchLines.Add('allowinternaledit' + #9 + 'before' + #9 + BoolToStr(xeContext.Settings.AllowInternalEdit, True));
    TestHost.TestMergedPatchFileCount := Length(Files);
    TestHost.TestMergedPatchMessages := mmoMessages.Lines.Count;

    TestHost.TestMergedPatchAnswer := TTimer.Create(Self);
    TestHost.TestMergedPatchAnswer.Interval := 100;
    TestHost.TestMergedPatchAnswer.OnTimer := TestMergedPatchAnswerTimer;
    TestHost.TestMergedPatchAnswer.Enabled := True;

    mniNavCreateMergedPatchClick(mniNavCreateMergedPatch);

    TestHost.TestMergedPatchAnswer.Enabled := False;
    TestHost.TestMergedPatchLines.Add('allowinternaledit' + #9 + 'after' + #9 + BoolToStr(xeContext.Settings.AllowInternalEdit, True));
    TestHost.TestMergedPatchTimer.OnTimer := TestMergedPatchReportTimer;
    TestHost.TestMergedPatchTimer.Interval := 2000;
    TestHost.TestMergedPatchTimer.Enabled := True;
  except
    on E: Exception do begin
      AddMessage('[Test Merged Patch] FAILED: ' + E.ClassName + ': ' + E.Message);
      TestHost.TestMergedPatchLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      if Assigned(TestHost.TestMergedPatchAnswer) then
        TestHost.TestMergedPatchAnswer.Enabled := False;
      TestMergedPatchWrite;
    end;
  end;
end;

procedure TxeTestFormHelper.TestMergedPatchAnswerTimer(Sender: TObject);
var
  lForm   : TCustomForm;
  lResult : TModalResult;
  lText   : string;
  lExtra  : string;

  function HasButton(aOwner: TComponent; aResult: TModalResult): Boolean;
  begin
    Result := False;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if (aOwner.Components[i] is TButton) and (TButton(aOwner.Components[i]).ModalResult = aResult) then
        Exit(True);
      if HasButton(aOwner.Components[i], aResult) then
        Exit(True);
    end;
  end;

  procedure CollectText(aOwner: TComponent);
  begin
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

  function FindEdit(aOwner: TComponent): TEdit;
  begin
    Result := nil;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TEdit then
        Exit(TEdit(aOwner.Components[i]));
      Result := FindEdit(aOwner.Components[i]);
      if Assigned(Result) then
        Exit;
    end;
  end;

begin
  if not Assigned(TestHost.TestMergedPatchLines) then
    Exit;
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then
    Exit;
  lText := '';
  lExtra := '';
  CollectText(lForm);
  lResult := mrNone;
  Inc(TestHost.TestMergedPatchAnswers);
  if TestHost.TestMergedPatchAnswers > 10 then begin
    lResult := mrCancel;
    lExtra := 'too many dialogs, cancelled';
  end else if SameText(lForm.Caption, 'New Module File') then begin
    var lEdit := FindEdit(lForm);
    if Assigned(lEdit) then begin
      lExtra := 'offered: ' + lEdit.Text;
      lEdit.Text := xeTestSwitches.MergedPatchName;
      lExtra := lExtra + ' entered: ' + lEdit.Text;
    end;
    lResult := mrOk;
  end else if HasButton(lForm, mrYes) then begin
    if SameText(xeTestSwitches.MergedPatchAnswer, 'no') then
      lResult := mrNo
    else
      lResult := mrYes;
  end else if HasButton(lForm, mrOk) then
    lResult := mrOk;
  if lResult = mrNone then
    Exit;
  lText := lText.Replace(#13, ' ').Replace(#10, ' ');
  if Length(lText) > 300 then
    lText := Copy(lText, 1, 300) + '...';
  TestHost.TestMergedPatchLines.Add('answer' + #9 + lForm.Caption + #9 + IntToStr(lResult) + #9 + lText.Trim + #9 + lExtra);
  lForm.ModalResult := lResult;
end;

procedure TxeTestFormHelper.TestMergedPatchReportTimer(Sender: TObject);

  procedure AddElements(const aElement: IwbElement; aDepth: Integer);
  var
    lContainer : IwbContainerElementRef;
  begin
    TestHost.TestMergedPatchLines.Add('element' + #9 + IntToStr(aDepth) + #9 + aElement.Name + #9 + aElement.EditValue);
    if Supports(aElement, IwbContainerElementRef, lContainer) then
      for var i := 0 to Pred(lContainer.ElementCount) do
        AddElements(lContainer.Elements[i], Succ(aDepth));
  end;

  procedure AddTree(const aContainer: IwbContainer; aDepth: Integer);
  var
    lGroup  : IwbGroupRecord;
    lRecord : IwbMainRecord;
  begin
    for var i := 0 to Pred(aContainer.ElementCount) do
      if Supports(aContainer.Elements[i], IwbGroupRecord, lGroup) then begin
        TestHost.TestMergedPatchLines.Add('targettree' + #9 + IntToStr(aDepth) + #9 + 'GRUP' + #9 + IntToStr(lGroup.GroupType) + #9 +
          IntToHex(lGroup.GroupLabel, 8));
        AddTree(lGroup, Succ(aDepth));
      end else if Supports(aContainer.Elements[i], IwbMainRecord, lRecord) then begin
        TestHost.TestMergedPatchLines.Add('targettree' + #9 + IntToStr(aDepth) + #9 + string(lRecord.Signature) + #9 +
          IntToHex(lRecord.LoadOrderFormID.ToCardinal, 8) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);
        AddElements(lRecord, Succ(aDepth));
      end;
  end;

var
  lTarget : IwbFile;
  lStream : TMemoryStream;
begin
  TestHost.TestMergedPatchTimer.Enabled := False;
  try
    for var i := TestHost.TestMergedPatchMessages to Pred(mmoMessages.Lines.Count) do
      TestHost.TestMergedPatchLines.Add('message' + #9 + mmoMessages.Lines[i]);
    lTarget := nil;
    if Length(Files) > TestHost.TestMergedPatchFileCount then
      lTarget := Files[High(Files)];
    if not Assigned(lTarget) then
      TestHost.TestMergedPatchLines.Add('target' + #9 + 'none')
    else begin
      TestHost.TestMergedPatchLines.Add('target' + #9 + lTarget.FileName + #9 + 'load order ' + IntToStr(lTarget.LoadOrder) + #9 +
        'records ' + IntToStr(lTarget.RecordCount) + #9 + 'masters ' + IntToStr(lTarget.MasterCount[True]));
      for var i := 0 to Pred(lTarget.MasterCount[True]) do
        TestHost.TestMergedPatchLines.Add('master' + #9 + IntToStr(i) + #9 + lTarget.Masters[i, True].FileName);
      AddTree(lTarget, 0);
      lStream := TMemoryStream.Create;
      try
        lTarget.WriteToStream(lStream, rmNo);
        lTarget.SetElementState(esUnsaved, True);
        lStream.SaveToFile(xeTestSwitches.MergedPatchOut);
        TestHost.TestMergedPatchLines.Add('patch' + #9 + ExtractFileName(xeTestSwitches.MergedPatchOut) + #9 + IntToStr(lStream.Size) + #9 +
          IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
      finally
        lStream.Free;
      end;
    end;
    CheckResult := 0;
  except
    on E: Exception do begin
      AddMessage('[Test Merged Patch] FAILED: ' + E.ClassName + ': ' + E.Message);
      TestHost.TestMergedPatchLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
  TestMergedPatchWrite;
end;

procedure TxeTestFormHelper.TestMergedPatchWrite;
var
  lTmp : string;
begin
  try
    TestHost.TestMergedPatchLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.MergedPatchFile + '.partial';
    TestHost.TestMergedPatchLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.MergedPatchFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    FreeAndNil(TestHost.TestMergedPatchLines);
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

var
  _TestCopyIntoSink         : TStringList;
  _TestCopyIntoPrevProgress : TwbProgressCallback;

procedure TestCopyIntoProgress(const aStatus: string);
begin
  if Assigned(_TestCopyIntoSink) then
    _TestCopyIntoSink.Add('progress' + #9 + aStatus);
  if Assigned(_TestCopyIntoPrevProgress) then
    _TestCopyIntoPrevProgress(aStatus);
end;

procedure TxeTestFormHelper.DoTestCopyInto;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  CheckResult := 2;
  TestHost.TestCopyIntoLines := TStringList.Create;
  TestHost.TestCopyIntoLines.Add('# xEdit copy into probe');
  TestHost.TestCopyIntoLines.Add('# ' + xeApplicationTitle);
  TestHost.TestCopyIntoLines.Add('# mode = ' + xeTestSwitches.CopyIntoMode + ', source = ' + xeTestSwitches.CopyIntoSource +
    ', records = ' + xeTestSwitches.CopyIntoRecords + ', targets = ' + xeTestSwitches.CopyIntoTargets +
    ', template = ' + xeTestSwitches.CopyIntoTemplate + ', editorid = ' + xeTestSwitches.CopyIntoEditorID +
    ', affixes = ' + xeTestSwitches.CopyIntoAffixes + ', answers = ' + xeTestSwitches.CopyIntoAnswers);
  TestHost.TestCopyIntoLines.Add('# Columns, tab separated: what / details');
  TestHost.TestCopyIntoTimer := TTimer.Create(Self);
  TestHost.TestCopyIntoTimer.Interval := 500;
  TestHost.TestCopyIntoTimer.OnTimer := TestCopyIntoRunTimer;
  TestHost.TestCopyIntoTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestCopyIntoRunTimer(Sender: TObject);
var
  lLines : TStringList;

  function FindFile(const aName: string): IwbFile;
  begin
    Result := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, aName) then
        Exit(Files[i]);
  end;

  procedure AddTree(const aContainer: IwbContainer; aDepth: Integer);
  var
    lGroup  : IwbGroupRecord;
    lRecord : IwbMainRecord;
  begin
    for var i := 0 to Pred(aContainer.ElementCount) do
      if Supports(aContainer.Elements[i], IwbGroupRecord, lGroup) then begin
        lLines.Add('tree' + #9 + IntToStr(aDepth) + #9 + 'GRUP' + #9 + IntToStr(lGroup.GroupType) + #9 + IntToHex(lGroup.GroupLabel, 8));
        AddTree(lGroup, Succ(aDepth));
      end else if Supports(aContainer.Elements[i], IwbMainRecord, lRecord) then
        lLines.Add('tree' + #9 + IntToStr(aDepth) + #9 + string(lRecord.Signature) + #9 +
          IntToHex(lRecord.LoadOrderFormID.ToCardinal, 8) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);
  end;

var
  lMode     : string;
  lSource   : IwbFile;
  lSpec     : TArray<string>;
  lGroup    : IwbContainerElementRef;
  lRecord   : IwbMainRecord;
  lSkip     : Integer;
  lCount    : Integer;
  lSeen     : Integer;
  lElements : TDynElements;
  lResult   : TDynElements;
  lBefore   : TArray<IwbFile>;
  lWrite    : TArray<IwbFile>;
  lStream   : TMemoryStream;
begin
  TestHost.TestCopyIntoTimer.Enabled := False;
  lLines := TestHost.TestCopyIntoLines;
  try
    lMode := LowerCase(xeTestSwitches.CopyIntoMode);
    lSource := FindFile(xeTestSwitches.CopyIntoSource);
    if not Assigned(lSource) then
      raise Exception.Create(xeTestSwitches.CopyIntoSource + ' is not loaded');
    TestHost.TestCopyIntoTargets := nil;
    for var lName in xeTestSwitches.CopyIntoTargets.Split([',']) do
      if lName <> '' then begin
        var lTarget := FindFile(lName);
        if not Assigned(lTarget) then
          raise Exception.Create(lName + ' is not loaded');
        TestHost.TestCopyIntoTargets := TestHost.TestCopyIntoTargets + [lTarget];
      end;

    lSpec := xeTestSwitches.CopyIntoRecords.Split([':']);
    if (Length(lSpec) < 1) or (Length(lSpec[0]) <> 4) then
      raise Exception.Create('-testcopyintorecords needs a signature first: ' + xeTestSwitches.CopyIntoRecords);
    lSkip := 0;
    lCount := 1;
    if Length(lSpec) > 1 then
      lSkip := StrToInt(lSpec[1]);
    if Length(lSpec) > 2 then
      lCount := StrToInt(lSpec[2]);
    if not Supports(lSource.GroupBySignature[StrToSignature(lSpec[0])], IwbContainerElementRef, lGroup) then
      raise Exception.Create('no ' + lSpec[0] + ' group in ' + lSource.FileName);
    lSeen := 0;
    for var i := 0 to Pred(lGroup.ElementCount) do
      if Supports(lGroup.Elements[i], IwbMainRecord, lRecord) then begin
        Inc(lSeen);
        if lSeen <= lSkip then
          Continue;
        if Length(lElements) >= lCount then
          Break;
        lElements := lElements + [lRecord as IwbElement];
        lLines.Add('selected' + #9 + IntToStr(High(lElements)) + #9 + lRecord.Name);
      end;
    if Length(lElements) < lCount then
      raise Exception.Create(Format('%s has %d %s records after skipping %d, %d asked for',
        [lSource.FileName, Length(lElements), lSpec[0], lSkip, lCount]));

    lBefore := Copy(Files);

    TestHost.TestCopyIntoAnswer := TTimer.Create(Self);
    TestHost.TestCopyIntoAnswer.Interval := 100;
    TestHost.TestCopyIntoAnswer.OnTimer := TestCopyIntoAnswerTimer;
    TestHost.TestCopyIntoAnswer.Enabled := True;

    _TestCopyIntoSink := lLines;
    _TestCopyIntoPrevProgress := _wbProgressCallback;
    _wbProgressCallback := TestCopyIntoProgress;
    try
      try
        lResult := CopyInto(lMode = 'new', lMode = 'wrapper', lMode = 'spawn', (lMode = 'deep') or (lMode = 'deepoverwrite'),
          (lMode = 'overwrite') or (lMode = 'deepoverwrite'), lElements);
        lLines.Add('returned' + #9 + IntToStr(Length(lResult)) + ' slots');
      except
        on E: Exception do
          lLines.Add('raised' + #9 + E.ClassName + #9 + E.Message);
      end;
    finally
      _wbProgressCallback := _TestCopyIntoPrevProgress;
      _TestCopyIntoSink := nil;
      _TestCopyIntoPrevProgress := nil;
      TestHost.TestCopyIntoAnswer.Enabled := False;
    end;
    if TestHost.TestCopyIntoNotOffered <> '' then
      lLines.Add('notoffered' + #9 + TestHost.TestCopyIntoNotOffered.Trim);
    if xeTestSwitches.CopyIntoAnswers <> '' then begin
      var lListed := xeTestSwitches.CopyIntoAnswers.Split([',']);
      if TestHost.TestCopyIntoAnswerIndex < Length(lListed) then
        lLines.Add('unusedanswers' + #9 + IntToStr(Length(lListed) - TestHost.TestCopyIntoAnswerIndex) + #9 +
          string.Join(',', lListed, TestHost.TestCopyIntoAnswerIndex, Length(lListed) - TestHost.TestCopyIntoAnswerIndex));
    end;
    lLines.Add('after' + #9 + 'progress "' + wbCurrentProgress + '"');
    for var i := Low(lElements) to High(lElements) do
      if Supports(lElements[i], IwbMainRecord, lRecord) then
        lLines.Add('sourceafter' + #9 + IntToStr(i) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);

    for var i := Low(lResult) to High(lResult) do
      if Assigned(lResult[i]) then begin
        var lSlotFile := lResult[i]._File;
        if Assigned(lSlotFile) then
          lLines.Add('result' + #9 + IntToStr(i) + #9 + lSlotFile.FileName + #9 + lResult[i].Name)
        else
          lLines.Add('result' + #9 + IntToStr(i) + #9 + '<no file>');
      end else
        lLines.Add('result' + #9 + IntToStr(i) + #9 + 'nil');

    lWrite := TestHost.TestCopyIntoTargets;
    for var i := Low(Files) to High(Files) do begin
      var lNew := True;
      for var j := Low(lBefore) to High(lBefore) do
        if lBefore[j].Equals(Files[i]) then
          lNew := False;
      if lNew then
        lWrite := lWrite + [Files[i]];
    end;
    ForceDirectories(xeTestSwitches.CopyIntoOut);
    for var lFile in lWrite do begin
      var lMasters := '';
      for var j := 0 to Pred(lFile.MasterCount[True]) do
        lMasters := lMasters + ' ' + lFile.Masters[j, True].FileName;
      lLines.Add('file' + #9 + lFile.FileName + #9 + 'records ' + IntToStr(lFile.RecordCount) + #9 + 'masters' + lMasters + #9 +
        'modified ' + BoolToStr(lFile.Modified, True));
      AddTree(lFile, 0);
      lStream := TMemoryStream.Create;
      try
        lFile.WriteToStream(lStream, rmNo);
        lFile.SetElementState(esUnsaved, True);
        lStream.SaveToFile(TPath.Combine(xeTestSwitches.CopyIntoOut, lFile.FileName));
        lLines.Add('written' + #9 + lFile.FileName + #9 + IntToStr(lStream.Size) + #9 +
          IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
      finally
        lStream.Free;
      end;
    end;
    CheckResult := 0;
  except
    on E: Exception do begin
      AddMessage('[Test Copy Into] FAILED: ' + E.ClassName + ': ' + E.Message);
      lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
  if Assigned(TestHost.TestCopyIntoAnswer) then
    TestHost.TestCopyIntoAnswer.Enabled := False;
  TestCopyIntoWrite;
end;

procedure TxeTestFormHelper.TestCopyIntoAnswerTimer(Sender: TObject);
var
  lForm   : TCustomForm;
  lResult : TModalResult;
  lText   : string;
  lExtra  : string;
  lEdit   : TEdit;

  function HasButton(aOwner: TComponent; aResult: TModalResult): Boolean;
  begin
    Result := False;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if (aOwner.Components[i] is TButton) and (TButton(aOwner.Components[i]).ModalResult = aResult) then
        Exit(True);
      if HasButton(aOwner.Components[i], aResult) then
        Exit(True);
    end;
  end;

  procedure CollectText(aOwner: TComponent);
  begin
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

  function FindEdit(aOwner: TComponent): TEdit;
  begin
    Result := nil;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TEdit then
        Exit(TEdit(aOwner.Components[i]));
      Result := FindEdit(aOwner.Components[i]);
      if Assigned(Result) then
        Exit;
    end;
  end;

  function NextAnswer: TModalResult;
  var
    lAnswers : TArray<string>;
    lToken   : string;
  begin
    Result := mrNone;
    lAnswers := xeTestSwitches.CopyIntoAnswers.Split([',']);
    if TestHost.TestCopyIntoAnswerIndex > High(lAnswers) then
      Exit;
    lToken := LowerCase(Trim(lAnswers[TestHost.TestCopyIntoAnswerIndex]));
    Inc(TestHost.TestCopyIntoAnswerIndex);
    if lToken = 'yes' then
      Result := mrYes
    else if lToken = 'no' then
      Result := mrNo
    else if lToken = 'yesall' then
      Result := mrYesToAll
    else if lToken = 'noall' then
      Result := mrNoToAll
    else if lToken = 'cancel' then
      Result := mrCancel;
    lExtra := 'listed answer ' + lToken;
  end;

  procedure SetEdit(const aValue: string);
  begin
    lEdit := FindEdit(lForm);
    if Assigned(lEdit) then begin
      lExtra := 'offered: ' + lEdit.Text;
      lEdit.Text := aValue;
      lExtra := lExtra + ' entered: ' + lEdit.Text;
    end;
  end;

begin
  if not Assigned(TestHost.TestCopyIntoLines) then
    Exit;
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then
    Exit;
  lText := '';
  lExtra := '';
  CollectText(lForm);
  lResult := mrNone;
  if lForm is TfrmModuleSelect then begin
    lExtra := 'offered: ' + string.Join(' | ', TfrmModuleSelect(lForm).AllModules.ToStrings(False));
    for var lTarget in TestHost.TestCopyIntoTargets do begin
      var lOffered := False;
      for var lInfo in TfrmModuleSelect(lForm).AllModules do
        if lInfo = PwbModuleInfo(lTarget.ModuleInfo) then
          lOffered := True;
      if lOffered then
        Include(PwbModuleInfo(lTarget.ModuleInfo).miFlags, mfTagged)
      else
        TestHost.TestCopyIntoNotOffered := TestHost.TestCopyIntoNotOffered + ' ' + lTarget.FileName;
    end;
    if xeTestSwitches.CopyIntoTemplate <> '' then begin
      var lFound := False;
      for var lInfo in TfrmModuleSelect(lForm).AllModules do
        if mfTemplate in lInfo.miFlags then begin
          Include(lInfo.miFlags, mfTagged);
          lFound := True;
          Break;
        end;
      if not lFound then
        TestHost.TestCopyIntoNotOffered := TestHost.TestCopyIntoNotOffered + ' <template>';
    end;
    if TestHost.TestCopyIntoNotOffered <> '' then
      lResult := mrCancel
    else
      lResult := mrOk;
  end else if SameText(lForm.Caption, 'New Module File') then begin
    if TestHost.TestCopyIntoNameGiven then
      lResult := mrCancel
    else begin
      SetEdit(xeTestSwitches.CopyIntoTemplate);
      TestHost.TestCopyIntoNameGiven := True;
      lResult := mrOk;
    end;
  end else if SameText(lForm.Caption, 'EditorID') then begin
    if xeTestSwitches.CopyIntoEditorID <> '' then
      SetEdit(xeTestSwitches.CopyIntoEditorID)
    else begin
      lEdit := FindEdit(lForm);
      if Assigned(lEdit) then
        SetEdit(lEdit.Text);
    end;
    lResult := mrOk;
  end else if SameText(lForm.Caption, 'EditorID Prefix') or SameText(lForm.Caption, 'EditorID Suffix') then begin
    var lParts := xeTestSwitches.CopyIntoAffixes.Split(['|']);
    var lIdx := -1;
    if lText.Contains('prefix that should be removed') then
      lIdx := 0
    else if lText.Contains('suffix that should be removed') then
      lIdx := 1
    else if lText.Contains('prefix that should be added') then
      lIdx := 2
    else if lText.Contains('suffix that should be added') then
      lIdx := 3;
    if (lIdx >= 0) and (lIdx <= High(lParts)) then
      SetEdit(lParts[lIdx])
    else
      SetEdit('');
    lResult := mrOk;
  end else if lText.Contains('need to be added') and HasButton(lForm, mrYes) then
    lResult := mrYes
  else if HasButton(lForm, mrYes) or HasButton(lForm, mrNo) then begin
    lResult := NextAnswer;
    if (lResult <> mrNone) and not HasButton(lForm, lResult) then begin
      lExtra := lExtra + ', no such button';
      lResult := mrNone;
    end;
    if lResult = mrNone then begin
      if HasButton(lForm, mrYesToAll) then
        lResult := mrYesToAll
      else if HasButton(lForm, mrYes) then
        lResult := mrYes;
      lExtra := (lExtra + ' fallback').Trim;
    end;
  end else if HasButton(lForm, mrOk) then
    lResult := mrOk;
  if lResult = mrNone then
    Exit;
  Inc(TestHost.TestCopyIntoAnswerCount);
  if TestHost.TestCopyIntoAnswerCount > 40 then begin
    lResult := mrCancel;
    lExtra := (lExtra + ' too many dialogs, cancelled').Trim;
  end;
  lText := lText.Replace(#13, ' ').Replace(#10, ' ');
  if Length(lText) > 300 then
    lText := Copy(lText, 1, 300) + '...';
  TestHost.TestCopyIntoLines.Add('answer' + #9 + lForm.Caption + #9 + IntToStr(lResult) + #9 + lText.Trim + #9 + lExtra);
  lForm.ModalResult := lResult;
end;

procedure TxeTestFormHelper.TestCopyIntoWrite;
var
  lTmp : string;
begin
  try
    TestHost.TestCopyIntoLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.CopyIntoFile + '.partial';
    TestHost.TestCopyIntoLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.CopyIntoFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    FreeAndNil(TestHost.TestCopyIntoLines);
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

var
  _TestRenumberSink         : TStringList;
  _TestRenumberPrevProgress : TwbProgressCallback;

procedure TestRenumberProgress(const aStatus: string);
begin
  if Assigned(_TestRenumberSink) then
    _TestRenumberSink.Add('progress' + #9 + aStatus);
  if Assigned(_TestRenumberPrevProgress) then
    _TestRenumberPrevProgress(aStatus);
end;

procedure TxeTestFormHelper.DoTestRenumber;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  CheckResult := 2;
  TestHost.TestRenumberLines := TStringList.Create;
  TestHost.TestRenumberLines.Add('# xEdit renumber / inject / compact probe');
  TestHost.TestRenumberLines.Add('# ' + xeApplicationTitle);
  TestHost.TestRenumberLines.Add('# op = ' + xeTestSwitches.RenumberOp + ', source = ' + xeTestSwitches.RenumberSource +
    ', target = ' + xeTestSwitches.RenumberTarget + ', starts = ' + xeTestSwitches.RenumberStarts +
    ', answers = ' + xeTestSwitches.RenumberAnswers + ', compareto = ' + xeTestSwitches.RenumberCompareTo +
    ', filter = ' + BoolToStr(xeTestSwitches.RenumberFilter, True));
  TestHost.TestRenumberLines.Add('# Columns, tab separated: what / details');
  TestHost.TestRenumberTimer := TTimer.Create(Self);
  TestHost.TestRenumberTimer.Interval := 500;
  TestHost.TestRenumberTimer.OnTimer := TestRenumberRunTimer;
  TestHost.TestRenumberTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestRenumberRunTimer(Sender: TObject);
const
  cListLimit = 100;
var
  lLines  : TStringList;
  lLayout : TwbSlotLayout;

  function FindFile(const aName: string): IwbFile;
  begin
    Result := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, aName) then
        Exit(Files[i]);
  end;

  function FormIDText(const aFormID: TwbFormID): string;
  begin
    Result := IntToHex(aFormID.ToCardinal, 8);
  end;

  procedure AddFields(const aPrefix, aPath: string; const aElement: IwbElement);
  var
    lContainer : IwbContainerElementRef;
    lValue     : string;
  begin
    if Supports(aElement, IwbContainerElementRef, lContainer) and (lContainer.ElementCount > 0) then begin
      for var i := 0 to Pred(lContainer.ElementCount) do
        AddFields(aPrefix, aPath + '\' + IntToStr(i) + ' ' + lContainer.Elements[i].Name, lContainer.Elements[i]);
      Exit;
    end;
    try
      lValue := aElement.EditValue;
    except
      on E: Exception do
        lValue := '<raised ' + E.ClassName + ': ' + E.Message + '>';
    end;
    lLines.Add(aPrefix + aPath + #9 + lValue);
  end;

  procedure AddFiles(const aWhen: string);
  var
    lFile   : IwbFile;
    lRecord : IwbMainRecord;
  begin
    for var i := Low(Files) to High(Files) do begin
      lFile := Files[i];
      lLines.Add('file' + #9 + aWhen + #9 + lFile.FileName + #9 + 'records ' + IntToStr(lFile.RecordCount) + #9 +
        'next ' + IntToHex(lFile.NextObjectID, 6) + #9 + 'modified ' + BoolToStr(lFile.Modified, True) + #9 +
        'editable ' + BoolToStr(lFile.IsEditable, True) + #9 + 'compareload ' + BoolToStr(fsIsCompareLoad in lFile.FileStates, True));
      if [fsIsGameMaster, fsIsHardcoded] * lFile.FileStates <> [] then
        Continue;
      if lFile.RecordCount > cListLimit then begin
        lLines.Add('records' + #9 + aWhen + #9 + lFile.FileName + #9 + 'not listed, more than ' + IntToStr(cListLimit));
        Continue;
      end;
      for var j := 0 to Pred(lFile.RecordCount) do begin
        lRecord := lFile.Records[j];
        lLines.Add('record' + #9 + aWhen + #9 + lFile.FileName + #9 + IntToStr(j) + #9 + FormIDText(lRecord.LoadOrderFormID) + #9 +
          string(lRecord.Signature) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);
        AddFields('field' + #9 + aWhen + #9 + lFile.FileName + #9 + IntToStr(j) + #9, '', lRecord);
      end;
    end;
  end;

  procedure AddOwn(const aWhen: string; const aOwn: TDynMainRecords; const aBefore: TArray<TwbFormID>);
  var
    lMaster : IwbMainRecord;
  begin
    if Length(aOwn) > cListLimit then begin
      lLines.Add('own' + #9 + aWhen + #9 + 'not listed, more than ' + IntToStr(cListLimit));
      Exit;
    end;
    for var i := Low(aOwn) to High(aOwn) do begin
      lMaster := aOwn[i].MasterOrSelf;
      lLines.Add('own' + #9 + aWhen + #9 + IntToStr(i) + #9 + FormIDText(aBefore[i]) + #9 + FormIDText(aOwn[i].LoadOrderFormID) + #9 +
        string(aOwn[i].Signature) + #9 + aOwn[i].EditorID + #9 + 'refby ' + IntToStr(lMaster.ReferencedByCount) + #9 +
        'overrides ' + IntToStr(aOwn[i].OverrideCount));
      for var j := 0 to Pred(lMaster.ReferencedByCount) do
        with lMaster.ReferencedBy[j] do
          lLines.Add('refby' + #9 + aWhen + #9 + IntToStr(i) + #9 + FormIDText(LoadOrderFormID) + #9 + string(Signature) + #9 +
            _File.FileName + #9 + 'editable ' + BoolToStr(IsEditable, True));
      for var j := 0 to Pred(aOwn[i].OverrideCount) do
        with aOwn[i].Overrides[j] do
          lLines.Add('override' + #9 + aWhen + #9 + IntToStr(i) + #9 + FormIDText(LoadOrderFormID) + #9 + _File.FileName);
    end;
  end;

  procedure AddUnused(const aWhat, aList: string; aUsed: Integer);
  var
    lListed : TArray<string>;
  begin
    if aList = '' then
      Exit;
    lListed := aList.Split([',']);
    if aUsed < Length(lListed) then
      lLines.Add('unusedanswers' + #9 + aWhat + #9 + IntToStr(Length(lListed) - aUsed) + #9 +
        string.Join(',', lListed, aUsed, Length(lListed) - aUsed));
  end;

var
  lSource : IwbFile;
  lItem   : TMenuItem;
  lNode   : PVirtualNode;
  lRecord : IwbMainRecord;
  lOwn    : TDynMainRecords;
  lBefore : TArray<TwbFormID>;
  lStream : TMemoryStream;
begin
  TestHost.TestRenumberTimer.Enabled := False;
  lLines := TestHost.TestRenumberLines;
  try
    lLayout := xeContext.SlotLayout;
    lSource := FindFile(xeTestSwitches.RenumberSource);
    if not Assigned(lSource) then
      raise Exception.Create(xeTestSwitches.RenumberSource + ' is not loaded');
    TestHost.TestRenumberTarget := nil;
    if xeTestSwitches.RenumberTarget <> '' then begin
      TestHost.TestRenumberTarget := FindFile(xeTestSwitches.RenumberTarget);
      if not Assigned(TestHost.TestRenumberTarget) then
        raise Exception.Create(xeTestSwitches.RenumberTarget + ' is not loaded');
    end;
    if SameText(xeTestSwitches.RenumberOp, 'inject') then
      lItem := mniNavRenumberFormIDsInject
    else if SameText(xeTestSwitches.RenumberOp, 'compact') then
      lItem := mniNavCompactFormIDs
    else if SameText(xeTestSwitches.RenumberOp, 'compactmedium') then
      lItem := mniNavCompactFormIDsMedium
    else
      lItem := mniNavRenumberFormIDsFrom;

    for var i := 0 to Pred(lSource.RecordCount) do begin
      lRecord := lSource.Records[i];
      if lSource.HasLoadOrderFileID and (lRecord.LoadOrderFormID.FileID[lLayout] = lSource.LoadOrderFileID) then begin
        lOwn := lOwn + [lRecord];
        lBefore := lBefore + [lRecord.LoadOrderFormID];
      end;
    end;
    lLines.Add('source' + #9 + lSource.FileName + #9 + 'records ' + IntToStr(lSource.RecordCount) + #9 + 'own ' + IntToStr(Length(lOwn)));
    AddOwn('before', lOwn, lBefore);
    AddFiles('before');

    if xeTestSwitches.RenumberFilter then begin
      mniNavFilterForCleaningClick(nil);
      lLines.Add('filter' + #9 + 'cleaning applied');
    end;

    lNode := FindNodeForElement(lSource);
    if not Assigned(lNode) then
      raise Exception.Create('no nav node for ' + lSource.FileName);
    vstNav.ClearSelection;
    vstNav.Selected[lNode] := True;
    vstNav.FocusedNode := lNode;
    vstNav.Expanded[lNode] := True;
    pmuNavPopup(nil);
    lLines.Add('menu' + #9 + 'renumber ' + BoolToStr(mniNavRenumberFormIDsFrom.Visible, True) + #9 +
      'compact ' + BoolToStr(mniNavCompactFormIDs.Visible, True) + #9 + 'inject ' + BoolToStr(mniNavRenumberFormIDsInject.Visible, True));
    if xeContext.GameDefObj.IsLightSupported then
      lLines.Add('compactitems' + #9 + StripHotkey(mniNavCompactFormIDs.Caption) + ' ' + BoolToStr(mniNavCompactFormIDs.Visible, True) + #9 +
        StripHotkey(mniNavCompactFormIDsMedium.Caption) + ' ' + BoolToStr(mniNavCompactFormIDsMedium.Visible, True));
    lLines.Add('call' + #9 + lItem.Name + #9 + 'expanded ' + BoolToStr(vstNav.Expanded[lNode], True) + #9 +
      'filterhint ' + BoolToStr(lblFilterHint.Visible, True));

    TestHost.TestRenumberAnswer := TTimer.Create(Self);
    TestHost.TestRenumberAnswer.Interval := 100;
    TestHost.TestRenumberAnswer.OnTimer := TestRenumberAnswerTimer;
    TestHost.TestRenumberAnswer.Enabled := True;

    _TestRenumberSink := lLines;
    _TestRenumberPrevProgress := _wbProgressCallback;
    _wbProgressCallback := TestRenumberProgress;
    try
      try
        mniNavRenumberFormIDsFromClick(lItem);
        lLines.Add('returned');
      except
        on E: Exception do
          lLines.Add('raised' + #9 + E.ClassName + #9 + E.Message);
      end;
    finally
      _wbProgressCallback := _TestRenumberPrevProgress;
      _TestRenumberSink := nil;
      _TestRenumberPrevProgress := nil;
      TestHost.TestRenumberAnswer.Enabled := False;
    end;

    if TestHost.TestRenumberNotOffered then
      lLines.Add('notoffered' + #9 + xeTestSwitches.RenumberTarget);
    AddUnused('starts', xeTestSwitches.RenumberStarts, TestHost.TestRenumberStartIndex);
    AddUnused('answers', xeTestSwitches.RenumberAnswers, TestHost.TestRenumberAnswerIndex);
    if TestHost.TestRenumberFallback then
      lLines.Add('fallback' + #9 + 'a dialog was answered with no listed answer');
    lLines.Add('after' + #9 + 'expanded ' + BoolToStr(vstNav.Expanded[lNode], True) + #9 +
      'progress "' + wbCurrentProgress + '"' + #9 + 'page ' + pgMain.ActivePage.Name);
    AddOwn('after', lOwn, lBefore);
    AddFiles('after');

    ForceDirectories(xeTestSwitches.RenumberOut);
    for var i := Low(Files) to High(Files) do
      if [fsIsGameMaster, fsIsHardcoded] * Files[i].FileStates = [] then begin
        lStream := TMemoryStream.Create;
        try
          try
            Files[i].WriteToStream(lStream, rmNo);
            Files[i].SetElementState(esUnsaved, True);
            lStream.SaveToFile(TPath.Combine(xeTestSwitches.RenumberOut, Files[i].FileName));
            lLines.Add('written' + #9 + Files[i].FileName + #9 + IntToStr(lStream.Size) + #9 +
              IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
          except
            on E: Exception do
              lLines.Add('notwritten' + #9 + Files[i].FileName + #9 + E.ClassName + #9 + E.Message);
          end;
        finally
          lStream.Free;
        end;
      end;
    CheckResult := 0;
  except
    on E: Exception do begin
      AddMessage('[Test Renumber] FAILED: ' + E.ClassName + ': ' + E.Message);
      lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
  if Assigned(TestHost.TestRenumberAnswer) then
    TestHost.TestRenumberAnswer.Enabled := False;
  TestRenumberWrite;
end;

procedure TxeTestFormHelper.TestRenumberAnswerTimer(Sender: TObject);
var
  lForm   : TCustomForm;
  lResult : TModalResult;
  lText   : string;
  lExtra  : string;
  lEdit   : TEdit;
  lToken  : string;

  function HasButton(aOwner: TComponent; aResult: TModalResult): Boolean;
  begin
    Result := False;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if (aOwner.Components[i] is TButton) and (TButton(aOwner.Components[i]).ModalResult = aResult) then
        Exit(True);
      if HasButton(aOwner.Components[i], aResult) then
        Exit(True);
    end;
  end;

  procedure CollectText(aOwner: TComponent);
  begin
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

  function FindEdit(aOwner: TComponent): TEdit;
  begin
    Result := nil;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TEdit then
        Exit(TEdit(aOwner.Components[i]));
      Result := FindEdit(aOwner.Components[i]);
      if Assigned(Result) then
        Exit;
    end;
  end;

  function NextToken(const aList: string; var aIndex: Integer): string;
  var
    lTokens : TArray<string>;
  begin
    Result := '';
    lTokens := aList.Split([',']);
    if aIndex > High(lTokens) then
      Exit;
    Result := LowerCase(Trim(lTokens[aIndex]));
    Inc(aIndex);
  end;

begin
  if not Assigned(TestHost.TestRenumberLines) then
    Exit;
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then
    Exit;
  lText := '';
  lExtra := '';
  CollectText(lForm);
  lResult := mrNone;
  if lForm is TfrmModuleSelect then begin
    lExtra := 'offered: ' + string.Join(' | ', TfrmModuleSelect(lForm).AllModules.ToStrings(False));
    var lOffered := False;
    if Assigned(TestHost.TestRenumberTarget) then
      for var lInfo in TfrmModuleSelect(lForm).AllModules do
        if lInfo = PwbModuleInfo(TestHost.TestRenumberTarget.ModuleInfo) then
          lOffered := True;
    if lOffered then begin
      Include(PwbModuleInfo(TestHost.TestRenumberTarget.ModuleInfo).miFlags, mfTagged);
      lResult := mrOk;
    end else begin
      TestHost.TestRenumberNotOffered := True;
      lResult := mrCancel;
    end;
  end else if string(lForm.Caption).StartsWith('Start from') then begin
    lEdit := FindEdit(lForm);
    if Assigned(lEdit) then
      lExtra := 'offered: ' + lEdit.Text;
    lToken := NextToken(xeTestSwitches.RenumberStarts, TestHost.TestRenumberStartIndex);
    if lToken = '' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' fallback').Trim;
      TestHost.TestRenumberFallback := True;
    end else if lToken = 'cancel' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' listed answer cancel').Trim;
    end else begin
      if Assigned(lEdit) then begin
        lEdit.Text := lToken;
        lExtra := lExtra + ' entered: ' + lEdit.Text;
      end;
      lResult := mrOk;
    end;
  end else if HasButton(lForm, mrYes) or HasButton(lForm, mrNo) then begin
    lToken := NextToken(xeTestSwitches.RenumberAnswers, TestHost.TestRenumberAnswerIndex);
    if lToken = 'yes' then
      lResult := mrYes
    else if lToken = 'no' then
      lResult := mrNo
    else if lToken = 'cancel' then
      lResult := mrCancel;
    if lToken <> '' then
      lExtra := 'listed answer ' + lToken;
    if (lResult <> mrNone) and not HasButton(lForm, lResult) then begin
      lExtra := lExtra + ', no such button';
      lResult := mrNone;
    end;
    if lResult = mrNone then begin
      if HasButton(lForm, mrCancel) then
        lResult := mrCancel
      else
        lResult := mrNo;
      lExtra := (lExtra + ' fallback').Trim;
      TestHost.TestRenumberFallback := True;
    end;
  end else if HasButton(lForm, mrOk) then
    lResult := mrOk;
  if lResult = mrNone then
    Exit;
  Inc(TestHost.TestRenumberAnswerCount);
  if TestHost.TestRenumberAnswerCount > 40 then begin
    lResult := mrCancel;
    lExtra := (lExtra + ' too many dialogs, cancelled').Trim;
    TestHost.TestRenumberFallback := True;
  end;
  lText := lText.Replace(#13, ' ').Replace(#10, ' ');
  if Length(lText) > 600 then
    lText := Copy(lText, 1, 600) + '...';
  TestHost.TestRenumberLines.Add('answer' + #9 + lForm.Caption + #9 + IntToStr(lResult) + #9 + lText.Trim + #9 + lExtra);
  lForm.ModalResult := lResult;
end;

procedure TxeTestFormHelper.TestRenumberWrite;
var
  lTmp : string;
begin
  try
    TestHost.TestRenumberLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.RenumberFile + '.partial';
    TestHost.TestRenumberLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.RenumberFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    FreeAndNil(TestHost.TestRenumberLines);
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

var
  _TestChangeFormIDSink         : TStringList;
  _TestChangeFormIDPrevProgress : TwbProgressCallback;

procedure TestChangeFormIDProgress(const aStatus: string);
begin
  if Assigned(_TestChangeFormIDSink) then
    _TestChangeFormIDSink.Add('progress' + #9 + aStatus);
  if Assigned(_TestChangeFormIDPrevProgress) then
    _TestChangeFormIDPrevProgress(aStatus);
end;

function TestChangeFormIDText(const aFormID: TwbFormID): string;
begin
  Result := IntToHex(aFormID.ToCardinal, 8);
end;

function TestChangeFormIDMask(const aLine: string): string;
var
  i: Integer;
begin
  Result := aLine;
  if (Length(aLine) < 3) or (aLine[1] <> '[') then
    Exit;
  i := 2;
  while (i <= Length(aLine)) and CharInSet(aLine[i], ['0'..'9', ':', '.']) do
    Inc(i);
  if (i > 2) and (i < Length(aLine)) and (aLine[i] = ']') and (aLine[i + 1] = ' ') then
    Result := '[<t>]' + Copy(aLine, i + 1, MaxInt);
end;

procedure TestChangeFormIDFields(aLines: TStrings; const aPrefix, aPath: string; const aElement: IwbElement);
var
  lContainer : IwbContainerElementRef;
  lValue     : string;
begin
  if Supports(aElement, IwbContainerElementRef, lContainer) and (lContainer.ElementCount > 0) then begin
    for var i := 0 to Pred(lContainer.ElementCount) do
      TestChangeFormIDFields(aLines, aPrefix, aPath + '\' + IntToStr(i) + ' ' + lContainer.Elements[i].Name, lContainer.Elements[i]);
    Exit;
  end;
  try
    lValue := aElement.EditValue;
  except
    on E: Exception do
      lValue := '<raised ' + E.ClassName + ': ' + E.Message + '>';
  end;
  aLines.Add(aPrefix + aPath + #9 + lValue);
end;

procedure TestChangeFormIDFiles(aLines: TStrings; const aWhen: string; const aFiles: TwbFiles);
const
  cListLimit = 100;
var
  lFile    : IwbFile;
  lRecord  : IwbMainRecord;
  lMasters : string;
begin
  for var i := Low(aFiles) to High(aFiles) do begin
    lFile := aFiles[i];
    lMasters := '';
    for var j := 0 to Pred(lFile.MasterCount[True]) do
      lMasters := lMasters + ' ' + lFile.Masters[j, True].FileName;
    aLines.Add('file' + #9 + aWhen + #9 + lFile.FileName + #9 + 'records ' + IntToStr(lFile.RecordCount) + #9 +
      'next ' + IntToHex(lFile.NextObjectID, 6) + #9 + 'modified ' + BoolToStr(lFile.Modified, True) + #9 +
      'editable ' + BoolToStr(lFile.IsEditable, True) + #9 + 'compareload ' + BoolToStr(fsIsCompareLoad in lFile.FileStates, True) +
      #9 + 'masters' + lMasters);
    if [fsIsGameMaster, fsIsHardcoded] * lFile.FileStates <> [] then
      Continue;
    if lFile.RecordCount > cListLimit then begin
      aLines.Add('records' + #9 + aWhen + #9 + lFile.FileName + #9 + 'not listed, more than ' + IntToStr(cListLimit));
      Continue;
    end;
    for var j := 0 to Pred(lFile.RecordCount) do begin
      lRecord := lFile.Records[j];
      aLines.Add('record' + #9 + aWhen + #9 + lFile.FileName + #9 + IntToStr(j) + #9 + TestChangeFormIDText(lRecord.LoadOrderFormID) + #9 +
        string(lRecord.Signature) + #9 + 'flags=' + IntToHex(lRecord.Flags._Flags, 8) + #9 + lRecord.EditorID);
      TestChangeFormIDFields(aLines, 'field' + #9 + aWhen + #9 + lFile.FileName + #9 + IntToStr(j) + #9, '', lRecord);
    end;
  end;
end;

procedure TestChangeFormIDLocalization(aLines: TStrings; const aWhen: string; const aTarget: IwbFile);
var
  lHandler : TwbLocalizationHandler;
  lStrings : TwbLocalizationFile;
begin
  if Assigned(aTarget) then
    aLines.Add('localized' + #9 + aWhen + #9 + aTarget.FileName + #9 + BoolToStr(aTarget.IsLocalized, True));
  lHandler := xeContext.LocalizationHandler;
  for var i := 0 to Pred(lHandler.Count) do begin
    lStrings := lHandler[i];
    aLines.Add('strings' + #9 + aWhen + #9 + lStrings.Name + #9 + 'count ' + IntToStr(lStrings.Count) + #9 + 'modified ' +
      BoolToStr(lStrings.Modified, True) + #9 + 'next ' + IntToStr(lStrings.NextID));
    for var j := 0 to Pred(lStrings.Count) do
      aLines.Add('string' + #9 + aWhen + #9 + lStrings.Name + #9 + IntToStr(lStrings.IndexToID(j)) + #9 +
        lStrings.Items[j].Replace(#13, '\r').Replace(#10, '\n'));
  end;
end;

procedure TestChangeFormIDRecordLines(aLines: TStrings; const aWhen: string; const aRecords: TDynMainRecords;
  const aBefore: TArray<TwbFormID>);
var
  lMaster : IwbMainRecord;
  lOther  : IwbMainRecord;
begin
  for var i := Low(aRecords) to High(aRecords) do begin
    if not Assigned(aRecords[i]._File) then begin
      aLines.Add('rec' + #9 + aWhen + #9 + IntToStr(i) + #9 + TestChangeFormIDText(aBefore[i]) + #9 + 'removed');
      Continue;
    end;
    lMaster := aRecords[i].MasterOrSelf;
    aLines.Add('rec' + #9 + aWhen + #9 + IntToStr(i) + #9 + TestChangeFormIDText(aBefore[i]) + #9 +
      TestChangeFormIDText(aRecords[i].LoadOrderFormID) + #9 + aRecords[i]._File.FileName + #9 + string(aRecords[i].Signature) + #9 +
      aRecords[i].EditorID + #9 + 'master ' + lMaster._File.FileName + #9 + 'refby ' + IntToStr(lMaster.ReferencedByCount) + #9 +
      'overrides ' + IntToStr(lMaster.OverrideCount));
    for var j := 0 to Pred(lMaster.ReferencedByCount) do begin
      lOther := lMaster.ReferencedBy[j];
      aLines.Add('refby' + #9 + aWhen + #9 + IntToStr(i) + #9 + TestChangeFormIDText(lOther.LoadOrderFormID) + #9 +
        string(lOther.Signature) + #9 + lOther._File.FileName + #9 + 'editable ' + BoolToStr(lOther.IsEditable, True));
    end;
    for var j := 0 to Pred(lMaster.OverrideCount) do begin
      lOther := lMaster.Overrides[j];
      aLines.Add('override' + #9 + aWhen + #9 + IntToStr(i) + #9 + IntToStr(j) + #9 + TestChangeFormIDText(lOther.LoadOrderFormID) + #9 +
        lOther._File.FileName);
    end;
  end;
end;

procedure TxeTestFormHelper.DoTestChangeFormID;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  CheckResult := 2;
  TestHost.TestChangeFormIDLines := TStringList.Create;
  TestHost.TestChangeFormIDLines.Add('# xEdit change FormID probe');
  TestHost.TestChangeFormIDLines.Add('# ' + xeApplicationTitle);
  TestHost.TestChangeFormIDLines.Add('# records = ' + xeTestSwitches.ChangeFormIDRecords + ', shift = ' +
    BoolToStr(xeTestSwitches.ChangeFormIDShift, True) + ', target = ' + xeTestSwitches.ChangeFormIDTarget + ', ids = ' +
    xeTestSwitches.ChangeFormIDIds + ', answers = ' + xeTestSwitches.ChangeFormIDAnswers + ', refs = ' +
    xeTestSwitches.ChangeFormIDRefs + ', compareto = ' + xeTestSwitches.ChangeFormIDCompareTo + ', op = ' +
    xeTestSwitches.ChangeFormIDOp + ', csv = ' + ExtractFileName(xeTestSwitches.ChangeFormIDCsv) + ', view = ' +
    xeTestSwitches.ChangeFormIDView);
  TestHost.TestChangeFormIDLines.Add('# Columns, tab separated: what / details');
  TestHost.TestChangeFormIDTimer := TTimer.Create(Self);
  TestHost.TestChangeFormIDTimer.Interval := 500;
  TestHost.TestChangeFormIDTimer.OnTimer := TestChangeFormIDRunTimer;
  TestHost.TestChangeFormIDTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestChangeFormIDRunTimer(Sender: TObject);

  function FindFile(const aName: string): IwbFile;
  begin
    Result := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, aName) then
        Exit(Files[i]);
  end;

  procedure AddUnused(aLines: TStrings; const aWhat, aList: string; aUsed: Integer);
  var
    lListed : TArray<string>;
  begin
    if aList = '' then
      Exit;
    lListed := aList.Split([',']);
    if aUsed < Length(lListed) then
      aLines.Add('unusedanswers' + #9 + aWhat + #9 + IntToStr(Length(lListed) - aUsed) + #9 +
        string.Join(',', lListed, aUsed, Length(lListed) - aUsed));
  end;

  function FindRecord(const aSpec: string): IwbMainRecord;
  var
    lAt   : Integer;
    lFile : IwbFile;
  begin
    lAt := aSpec.LastIndexOf('@');
    if lAt < 1 then
      raise Exception.Create('not <EditorID>@<module>: ' + aSpec);
    lFile := FindFile(aSpec.Substring(lAt + 1));
    if not Assigned(lFile) then
      raise Exception.Create(aSpec.Substring(lAt + 1) + ' is not loaded');
    for var j := 0 to Pred(lFile.RecordCount) do
      if SameText(lFile.Records[j].EditorID, aSpec.Substring(0, lAt)) then
        Exit(lFile.Records[j]);
    raise Exception.Create('no record ' + aSpec.Substring(0, lAt) + ' in ' + lFile.FileName);
  end;

var
  lLines  : TStringList;
  lRecord : IwbMainRecord;
  lNode   : PVirtualNode;
  lFirst  : PVirtualNode;
  lState  : TKeyboardState;
  lShift  : Byte;
  lMenuItem : TMenuItem;
  lShowView : Boolean;
  lSelFiles : TArray<IwbFile>;
  lSelFile  : IwbFile;
begin
  TestHost.TestChangeFormIDTimer.Enabled := False;
  lLines := TestHost.TestChangeFormIDLines;
  try
    var lRefBy := xeTestSwitches.ChangeFormIDOp.StartsWith('refby', True);
    TestHost.TestChangeFormIDTarget := nil;
    if (xeTestSwitches.ChangeFormIDTarget <> '') and not SameText(xeTestSwitches.ChangeFormIDTarget, 'new') then begin
      TestHost.TestChangeFormIDTarget := FindFile(xeTestSwitches.ChangeFormIDTarget);
      if not Assigned(TestHost.TestChangeFormIDTarget) then
        raise Exception.Create(xeTestSwitches.ChangeFormIDTarget + ' is not loaded');
    end;
    TestHost.TestChangeFormIDRecords := nil;
    TestHost.TestChangeFormIDBefore := nil;
    lSelFiles := nil;
    for var lSpec in xeTestSwitches.ChangeFormIDRecords.Split([',']) do begin
      if lSpec.StartsWith('@') and (SameText(xeTestSwitches.ChangeFormIDOp, 'setvwd') or
         SameText(xeTestSwitches.ChangeFormIDOp, 'setvwdinto') or SameText(xeTestSwitches.ChangeFormIDOp, 'createseq')) then begin
        lSelFile := FindFile(lSpec.Substring(1));
        if not Assigned(lSelFile) then
          raise Exception.Create(lSpec.Substring(1) + ' is not loaded');
        lSelFiles := lSelFiles + [lSelFile];
        lLines.Add('selectedfile' + #9 + IntToStr(High(lSelFiles)) + #9 + lSelFile.FileName + #9 + 'editable ' +
          BoolToStr(lSelFile.IsEditable, True));
        Continue;
      end;
      lRecord := FindRecord(lSpec);
      TestHost.TestChangeFormIDRecords := TestHost.TestChangeFormIDRecords + [lRecord];
      TestHost.TestChangeFormIDBefore := TestHost.TestChangeFormIDBefore + [lRecord.LoadOrderFormID];
      lLines.Add('selected' + #9 + IntToStr(High(TestHost.TestChangeFormIDRecords)) + #9 + lRecord._File.FileName + #9 +
        lSpec.Substring(0, lSpec.LastIndexOf('@')) + #9 + TestChangeFormIDText(lRecord.LoadOrderFormID) + #9 +
        string(lRecord.Signature) + #9 + 'editable ' + BoolToStr(lRecord.IsEditable, True));
    end;
    TestChangeFormIDRecordLines(lLines, 'before', TestHost.TestChangeFormIDRecords, TestHost.TestChangeFormIDBefore);
    TestChangeFormIDFiles(lLines, 'before', Files);

    lShowView := SameText(xeTestSwitches.ChangeFormIDOp, 'changerefs') and (xeTestSwitches.ChangeFormIDView = '');
    if SameText(xeTestSwitches.ChangeFormIDOp, 'changerefs') and (xeTestSwitches.ChangeFormIDView <> '') and
       not SameText(xeTestSwitches.ChangeFormIDView, 'none') then begin
      lNode := FindNodeForElement(FindRecord(xeTestSwitches.ChangeFormIDView));
      if not Assigned(lNode) then
        raise Exception.Create('no nav node for ' + xeTestSwitches.ChangeFormIDView);
      vstNav.ClearSelection;
      vstNav.FocusedNode := lNode;
      vstNav.Selected[lNode] := True;
      if tmrPendingSetActive.Enabled then
        tmrPendingSetActiveTimer(tmrPendingSetActive);
    end;

    lFirst := nil;
    vstNav.ClearSelection;
    if SameText(xeTestSwitches.ChangeFormIDOp, 'batchrefs') or SameText(xeTestSwitches.ChangeFormIDOp, 'localize') then begin
      lFirst := FindNodeForElement(TestHost.TestChangeFormIDTarget);
      if not Assigned(lFirst) then
        raise Exception.Create('no nav node for ' + TestHost.TestChangeFormIDTarget.FileName);
      vstNav.FocusedNode := lFirst;
      vstNav.Selected[lFirst] := True;
    end else if lRefBy then begin
      lFirst := FindNodeForElement(FindRecord(xeTestSwitches.ChangeFormIDView));
      if not Assigned(lFirst) then
        raise Exception.Create('no nav node for ' + xeTestSwitches.ChangeFormIDView);
      vstNav.FocusedNode := lFirst;
      vstNav.Selected[lFirst] := True;
    end else
      for lRecord in TestHost.TestChangeFormIDRecords do begin
        lNode := FindNodeForElement(lRecord);
        if not Assigned(lNode) then
          raise Exception.Create('no nav node for ' + lRecord.Name);
        if not Assigned(lFirst) then begin
          lFirst := lNode;
          vstNav.FocusedNode := lNode;
        end;
        vstNav.Selected[lNode] := True;
      end;
    for lSelFile in lSelFiles do begin
      lNode := FindNodeForElement(lSelFile);
      if not Assigned(lNode) then
        raise Exception.Create('no nav node for ' + lSelFile.FileName);
      if not Assigned(lFirst) then begin
        lFirst := lNode;
        vstNav.FocusedNode := lNode;
      end;
      vstNav.Selected[lNode] := True;
    end;
    pmuNavPopup(nil);
    if lRefBy then
      TestRefByShow(lLines);
    if SameText(xeTestSwitches.ChangeFormIDOp, 'copyrows') then begin
      var lViewSpec := xeTestSwitches.ChangeFormIDView;
      var lNavRoute := lViewSpec.StartsWith('nav:', True);
      if lNavRoute then
        lViewSpec := lViewSpec.Substring(4);
      if xeTestSwitches.ChangeFormIDPinned <> '' then begin
        vstNav.ClearSelection;
        lFirst := nil;
        for var lSpec in xeTestSwitches.ChangeFormIDPinned.Split([',']) do begin
          lNode := FindNodeForElement(FindRecord(lSpec));
          if not Assigned(lNode) then
            raise Exception.Create('no nav node for ' + lSpec);
          if not Assigned(lFirst) then begin
            lFirst := lNode;
            vstNav.FocusedNode := lNode;
          end;
          vstNav.Selected[lNode] := True;
        end;
        vstNavChange(vstNav, vstNav.FocusedNode);
        if tmrPendingSetActive.Enabled then
          tmrPendingSetActiveTimer(tmrPendingSetActive);
        bnPinned.Down := True;
        bnPinnedClick(bnPinned);
        vstNav.ClearSelection;
        lFirst := nil;
        for var lSelected in TestHost.TestChangeFormIDRecords do begin
          lNode := FindNodeForElement(lSelected);
          if not Assigned(lNode) then
            raise Exception.Create('no nav node for ' + lSelected.Name);
          if not Assigned(lFirst) then begin
            lFirst := lNode;
            vstNav.FocusedNode := lNode;
          end;
          vstNav.Selected[lNode] := True;
        end;
        vstNavChange(vstNav, vstNav.FocusedNode);
      end else if lNavRoute then
        vstNavChange(vstNav, vstNav.FocusedNode)
      else
        SetActiveRecord(TestHost.TestChangeFormIDRecords);
      if tmrPendingSetActive.Enabled then
        tmrPendingSetActiveTimer(tmrPendingSetActive);
      if lNavRoute or (xeTestSwitches.ChangeFormIDPinned <> '') then begin
        var lShown := '';
        var lShownRecord: IwbMainRecord;
        for var i := Low(ActiveRecords) to High(ActiveRecords) do begin
          if lShown <> '' then
            lShown := lShown + ',';
          if Supports(ActiveRecords[i].Element, IwbMainRecord, lShownRecord) then
            lShown := lShown + lShownRecord.EditorID + '@' + lShownRecord._File.FileName;
        end;
        lLines.Add('viewrecords' + #9 + lShown + #9 + 'pinned ' + BoolToStr(IsPinned, True) + #9 + 'nav selected ' +
          IntToStr(vstNav.SelectedCount));
      end;
      var lSource := FindRecord(lViewSpec);
      var lColumn := -1;
      for var i := Low(ActiveRecords) to High(ActiveRecords) do
        if Assigned(ActiveRecords[i].Element) and ActiveRecords[i].Element.Equals(lSource) then
          lColumn := i;
      vstView.FocusedColumn := Succ(lColumn);
      vstViewFocusedNode := vstView.GetFirst;
      pmuViewPopup(nil);
      lLines.Add('view' + #9 + 'columns ' + IntToStr(Length(ActiveRecords)) + #9 + 'source ' + lSource.EditorID + ' column ' +
        IntToStr(lColumn));
    end;
    if SameText(xeTestSwitches.ChangeFormIDOp, 'changerefs') then
      lMenuItem := mniNavChangeReferencingRecords
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'batchrefs') then
      lMenuItem := mniNavBatchChangeReferencingRecords
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'cleanupinjected') then
      lMenuItem := mniNavCleanupInjected
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'localize') then
      lMenuItem := mniNavLocalizationSwitch
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'locview') or SameText(xeTestSwitches.ChangeFormIDOp, 'viewadd') then
      lMenuItem := nil
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'setvwd') then
      lMenuItem := mniNavSetVWDAuto
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'setvwdinto') then
      lMenuItem := mniNavSetVWDAutoInto
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'copyidle') then
      lMenuItem := mniNavCopyIdle
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'copyspawnrate') then
      lMenuItem := mniNavCopyAsSpawnRateOverride
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'copyrows') then
      lMenuItem := mniViewCopyMultipleToSelectedRecords
    else if SameText(xeTestSwitches.ChangeFormIDOp, 'createseq') then
      lMenuItem := mniNavCreateSEQFile
    else if lRefBy then
      lMenuItem := TestRefByMenuItem
    else
      lMenuItem := mniNavChangeFormID;
    if Assigned(lMenuItem) then
      lLines.Add('menu' + #9 + LowerCase(xeTestSwitches.ChangeFormIDOp) + ' ' + BoolToStr(lMenuItem.Visible, True) + #9 + 'selected ' +
        IntToStr(vstNav.SelectedCount) + #9 + 'focused first ' + BoolToStr(vstNav.FocusedNode = lFirst, True));
    if lMenuItem = mniNavLocalizationSwitch then begin
      lLines.Add('caption' + #9 + StripHotkey(lMenuItem.Caption) + #9 + 'submenu ' + BoolToStr(mniNavLocalization.Visible, True));
      TestChangeFormIDLocalization(lLines, 'before', TestHost.TestChangeFormIDTarget);
    end;
    if lShowView and tmrPendingSetActive.Enabled then
      tmrPendingSetActiveTimer(tmrPendingSetActive);
    if SameText(xeTestSwitches.ChangeFormIDOp, 'changerefs') then
      if Assigned(ActiveRecord) then
        lLines.Add('view' + #9 + ActiveRecord.Name + #9 + ActiveRecord._File.FileName + #9 + 'master ' +
          ActiveRecord.MasterOrSelf._File.FileName + #9 + 'refby ' + IntToStr(ActiveRecord.MasterOrSelf.ReferencedByCount))
      else
        lLines.Add('view' + #9 + 'none');

    lShift := 0;
    if xeTestSwitches.ChangeFormIDShift then begin
      GetKeyboardState(lState);
      lShift := lState[VK_SHIFT];
      lState[VK_SHIFT] := lState[VK_SHIFT] or $80;
      SetKeyboardState(lState);
    end;
    lLines.Add('call' + #9 + 'shift ' + BoolToStr(GetKeyState(VK_SHIFT) < 0, True));
    if xeTestSwitches.FileLists <> '' then
      TestWriteFileLists;
    TestHost.TestChangeFormIDMessages := mmoMessages.Lines.Count;

    TestHost.TestChangeFormIDAnswer := TTimer.Create(Self);
    TestHost.TestChangeFormIDAnswer.Interval := 100;
    TestHost.TestChangeFormIDAnswer.OnTimer := TestChangeFormIDAnswerTimer;
    TestHost.TestChangeFormIDAnswer.Enabled := True;

    _TestChangeFormIDSink := lLines;
    _TestChangeFormIDPrevProgress := _wbProgressCallback;
    _wbProgressCallback := TestChangeFormIDProgress;
    try
      try
        if lMenuItem = mniNavChangeReferencingRecords then
          mniNavChangeReferencingRecordsClick(lMenuItem)
        else if lMenuItem = mniNavBatchChangeReferencingRecords then
          mniNavBatchChangeReferencingRecordsClick(lMenuItem)
        else if lMenuItem = mniNavCleanupInjected then
          mniNavCleanupInjectedClick(lMenuItem)
        else if lMenuItem = mniNavLocalizationSwitch then
          mniNavLocalizationSwitchClick(lMenuItem)
        else if lMenuItem = mniNavSetVWDAuto then
          mniNavSetVWDAutoClick(lMenuItem)
        else if lMenuItem = mniNavSetVWDAutoInto then
          mniNavSetVWDAutoIntoClick(lMenuItem)
        else if lMenuItem = mniNavCopyIdle then
          mniNavCopyIdleClick(lMenuItem)
        else if lMenuItem = mniNavCopyAsSpawnRateOverride then
          mniNavCopyIntoClick(lMenuItem)
        else if lMenuItem = mniViewCopyMultipleToSelectedRecords then
          mniViewCopyMultipleToSelectedRecordsClick(lMenuItem)
        else if lMenuItem = mniNavCreateSEQFile then
          mniNavCreateSEQFileClick(lMenuItem)
        else if lRefBy then begin
          if lMenuItem.Visible then
            lMenuItem.Click
          else
            lLines.Add('notclicked' + #9 + 'the menu item is hidden');
        end else if SameText(xeTestSwitches.ChangeFormIDOp, 'viewadd') then
          TestChangeFormIDViewAdd(lLines)
        else if not Assigned(lMenuItem) then
          TestChangeFormIDLocView(lLines)
        else
          mniNavChangeFormIDClick(lMenuItem);
        lLines.Add('returned');
      except
        on E: Exception do
          lLines.Add('raised' + #9 + E.ClassName + #9 + E.Message);
      end;
    finally
      _wbProgressCallback := _TestChangeFormIDPrevProgress;
      _TestChangeFormIDSink := nil;
      _TestChangeFormIDPrevProgress := nil;
      TestHost.TestChangeFormIDAnswer.Enabled := False;
      if xeTestSwitches.ChangeFormIDShift then begin
        GetKeyboardState(lState);
        lState[VK_SHIFT] := lShift;
        SetKeyboardState(lState);
      end;
    end;

    if TestHost.TestChangeFormIDClosed then begin
      _wbProgressCallback := nil;
      FreeAndNil(TestHost.TestChangeFormIDLines);
      TestHost.TestChangeFormIDRecords := nil;
      TestHost.TestChangeFormIDTarget := nil;
      Exit;
    end;

    if TestHost.TestChangeFormIDNotOffered then
      lLines.Add('notoffered' + #9 + xeTestSwitches.ChangeFormIDTarget);
    AddUnused(lLines, 'ids', xeTestSwitches.ChangeFormIDIds, TestHost.TestChangeFormIDIdIndex);
    AddUnused(lLines, 'answers', xeTestSwitches.ChangeFormIDAnswers, TestHost.TestChangeFormIDAnswerIndex);
    AddUnused(lLines, 'refs', xeTestSwitches.ChangeFormIDRefs, TestHost.TestChangeFormIDRefIndex);
    if (xeTestSwitches.ChangeFormIDCsv <> '') and not TestHost.TestChangeFormIDCsvAnswered then
      lLines.Add('unusedanswers' + #9 + 'csv' + #9 + '1' + #9 + ExtractFileName(xeTestSwitches.ChangeFormIDCsv));
    if TestHost.TestChangeFormIDFallback then
      lLines.Add('fallback' + #9 + 'a dialog was answered with no listed answer');
    lLines.Add('after' + #9 + 'progress "' + wbCurrentProgress + '"' + #9 + 'page ' + pgMain.ActivePage.Name);
    if lRefBy then
      TestRefByRows(lLines, 'after');
    TestChangeFormIDNodes(lLines);

    TestHost.TestChangeFormIDTimer.OnTimer := TestChangeFormIDReportTimer;
    TestHost.TestChangeFormIDTimer.Interval := 1000;
    TestHost.TestChangeFormIDTimer.Enabled := True;
  except
    on E: Exception do begin
      AddMessage('[Test Change FormID] FAILED: ' + E.ClassName + ': ' + E.Message);
      lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      if Assigned(TestHost.TestChangeFormIDAnswer) then
        TestHost.TestChangeFormIDAnswer.Enabled := False;
      TestChangeFormIDWrite;
    end;
  end;
end;

procedure TxeTestFormHelper.TestChangeFormIDNodes(aLines: TStrings);
var
  lNode     : PVirtualNode;
  lNodeData : PNavNodeData;
  lFlags    : string;
begin
  for var i := Low(TestHost.TestChangeFormIDRecords) to High(TestHost.TestChangeFormIDRecords) do begin
    lNode := FindNodeForElement(TestHost.TestChangeFormIDRecords[i]);
    lNodeData := vstNav.GetNodeData(lNode);
    if not Assigned(lNodeData) then begin
      aLines.Add('node' + #9 + IntToStr(i) + #9 + 'none');
      Continue;
    end;
    lFlags := '';
    for var lFlag := Low(TNavNodeFlag) to High(TNavNodeFlag) do
      if lFlag in lNodeData.Flags then
        lFlags := lFlags + ' ' + GetEnumName(TypeInfo(TNavNodeFlag), Ord(lFlag));
    aLines.Add('node' + #9 + IntToStr(i) + #9 + GetEnumName(TypeInfo(TConflictAll), Ord(lNodeData.ConflictAll)) + #9 +
      GetEnumName(TypeInfo(TConflictThis), Ord(lNodeData.ConflictThis)) + #9 + 'flags' + lFlags + #9 +
      'focused ' + BoolToStr(lNode = vstNav.FocusedNode, True) + #9 + 'selected ' + BoolToStr(vstNav.Selected[lNode], True));
  end;
end;

procedure TxeTestFormHelper.TestChangeFormIDLocView(aLines: TStrings);
var
  lRows    : TArray<PVirtualNode>;
  lColumn  : Integer;
  lElement : IwbElement;
begin
  for var lRecord in TestHost.TestChangeFormIDRecords do begin
    DoSetActiveRecord(IwbMainRecord(nil));
    DoSetActiveRecord(lRecord, True);
    vstView.FullExpand;
    lColumn := -1;
    for var c := Low(ActiveRecords) to High(ActiveRecords) do
      if Assigned(ActiveRecords[c].Element) and ActiveRecords[c].Element.Equals(lRecord) then
        lColumn := c;
    if lColumn < 0 then begin
      aLines.Add('locview' + #9 + lRecord.EditorID + #9 + 'no column');
      Continue;
    end;
    lRows := nil;
    for var lNode in vstView.Nodes(False) do begin
      lElement := ViewCells(lNode)[lColumn].Element;
      if Assigned(lElement) and Assigned(lElement.ValueDef) and (lElement.ValueDef.DefType = dtLString) then
        lRows := lRows + [lNode];
    end;
    for var lRow in lRows do begin
      lElement := ViewCells(lRow)[lColumn].Element;
      aLines.Add('locview' + #9 + lRecord.EditorID + #9 + lElement.Name + #9 + 'value ' + lElement.EditValue);
      vstViewFocusedNode := lRow;
      vstView.FocusedColumn := Succ(lColumn);
      try
        mniViewEditClick(nil);
        aLines.Add('locview' + #9 + lRecord.EditorID + #9 + lElement.Name + #9 + 'returned');
      except
        on E: Exception do
          aLines.Add('locview' + #9 + lRecord.EditorID + #9 + lElement.Name + #9 + 'raised' + #9 + E.ClassName + #9 + E.Message);
      end;
    end;
  end;
end;

procedure TxeTestFormHelper.TestChangeFormIDViewAdd(aLines: TStrings);
var
  lColumn : Integer;
  lRow    : PVirtualNode;
  lRows   : Integer;
  lTarget : IwbMainRecord;
  lCell   : IwbMainRecord;
  lBefore : IwbElement;
  lAdded  : IwbElement;
  lPath   : TArray<string>;

  function NodeNamed(aNode: PVirtualNode; const aName: string): Boolean;
  begin
    for var c := Low(ActiveRecords) to High(ActiveRecords) do
      if Assigned(ViewCells(aNode)[c].Element) and SameText(ViewCells(aNode)[c].Element.Name, aName) then
        Exit(True);
    Result := False;
  end;

  function NodeAtPath(aNode: PVirtualNode): Boolean;
  begin
    if Integer(vstView.GetNodeLevel(aNode)) <> High(lPath) then
      Exit(False);
    for var i := High(lPath) downto Low(lPath) do begin
      if not NodeNamed(aNode, lPath[i]) then
        Exit(False);
      aNode := aNode.Parent;
    end;
    Result := True;
  end;

begin
  lPath := xeTestSwitches.ChangeFormIDRow.Split(['\']);
  for var i := Low(lPath) to High(lPath) do
    lPath[i] := lPath[i].Trim;
  for var lRecord in TestHost.TestChangeFormIDRecords do begin
    DoSetActiveRecord(IwbMainRecord(nil));
    DoSetActiveRecord(lRecord, True);
    vstView.FullExpand;
    lColumn := -1;
    lTarget := nil;
    for var c := Low(ActiveRecords) to High(ActiveRecords) do
      if Supports(ActiveRecords[c].Element, IwbMainRecord, lCell) and lCell._File.Equals(TestHost.TestChangeFormIDTarget) then begin
        lColumn := c;
        lTarget := lCell;
      end;
    if lColumn < 0 then begin
      aLines.Add('viewadd' + #9 + lRecord.EditorID + #9 + 'no column for ' + xeTestSwitches.ChangeFormIDTarget);
      Continue;
    end;
    lRow := nil;
    lRows := 0;
    for var lNode in vstView.Nodes(False) do
      if NodeAtPath(lNode) then begin
        lRow := lNode;
        Inc(lRows);
      end;
    if lRows <> 1 then begin
      aLines.Add('viewadd' + #9 + lRecord.EditorID + #9 + IntToStr(lRows) + ' rows at ' + xeTestSwitches.ChangeFormIDRow);
      Continue;
    end;
    lBefore := lTarget.ElementByPath[xeTestSwitches.ChangeFormIDRow];
    aLines.Add('viewadd' + #9 + lRecord.EditorID + #9 + 'column ' + IntToStr(lColumn) + ' of ' + IntToStr(Length(ActiveRecords)) + #9 +
      'partial ' + BoolToStr(lTarget.IsPartialForm, True) + #9 + 'cell ' + IfThen(Assigned(ViewCells(lRow)[lColumn].Element), 'E', '-') +
      #9 + 'had ' + BoolToStr(Assigned(lBefore), True));
    vstViewFocusedNode := lRow;
    vstView.FocusedColumn := Succ(lColumn);
    pmuViewPopup(nil);
    aLines.Add('viewadd' + #9 + lRecord.EditorID + #9 + 'offered ' + BoolToStr(mniViewAdd.Visible and mniViewAdd.Enabled, True) + #9 +
      'caption ' + StripHotkey(mniViewAdd.Caption) + #9 + 'choices ' + IntToStr(mniViewAdd.Count));
    if mniViewAdd.Visible and mniViewAdd.Enabled then
      if mniViewAdd.Count > 0 then
        mniViewAdd.Items[0].Click
      else
        mniViewAdd.Click;
    lAdded := lTarget.ElementByPath[xeTestSwitches.ChangeFormIDRow];
    aLines.Add('viewadd' + #9 + lRecord.EditorID + #9 + 'after' + #9 + 'has ' + BoolToStr(Assigned(lAdded), True) + #9 + 'new ' +
      BoolToStr(Assigned(lAdded) and not (Assigned(lBefore) and lBefore.Equals(lAdded)), True) + #9 + 'partial ' +
      BoolToStr(lTarget.IsPartialForm, True) + #9 + 'modified ' + BoolToStr(lTarget.Modified, True) + #9 + 'elements ' +
      IntToStr(lTarget.ElementCount));
  end;
end;

function TxeTestFormHelper.TestRefByMenuItem: TMenuItem;
var
  lOp : string;
begin
  lOp := LowerCase(xeTestSwitches.ChangeFormIDOp);
  if lOp = 'refbyvwd' then
    Result := mniRefByVWD
  else if lOp = 'refbynotvwd' then
    Result := mniRefByNotVWD
  else if lOp = 'refbymarkmodified' then
    Result := mniRefByMarkModified
  else if lOp = 'refbyremove' then
    Result := mniRefByRemove
  else if lOp = 'refbycopyinto' then
    Result := mniRefByCopyOverrideInto
  else if lOp = 'refbycopyintooverwrite' then
    Result := mniRefByCopyOverrideIntoWithOverwriting
  else if lOp = 'refbydeepcopyinto' then
    Result := mniRefByDeepCopyOverrideInto
  else if lOp = 'refbydeepcopyintooverwrite' then
    Result := mniRefByDeepCopyOverrideIntoWithOverwriting
  else if lOp = 'refbycopyasnew' then
    Result := mniRefByCopyAsNewInto
  else if lOp = 'refbydisabledinto' then
    Result := mniRefByCopyDisabledOverrideInto
  else if lOp = 'refbycompare' then
    Result := mniRefByCompareSelected
  else
    raise Exception.Create('no Referenced By menu item for -testchangeformidop:' + xeTestSwitches.ChangeFormIDOp);
end;

procedure TxeTestFormHelper.TestRefByShow(aLines: TStrings);
var
  lItem   : TListItem;
  lRecord : IwbMainRecord;
begin
  vstNavChange(vstNav, vstNav.FocusedNode);
  if tmrPendingSetActive.Enabled then
    tmrPendingSetActiveTimer(tmrPendingSetActive);
  pgMain.ActivePage := tbsReferencedBy;
  pgMainChange(pgMain);
  lvReferencedBy.ClearSelection;
  for var i := 0 to Pred(lvReferencedBy.Items.Count) do begin
    lItem := lvReferencedBy.Items[i];
    if not Assigned(lItem) or not Assigned(lItem.Data) then
      Continue;
    lRecord := IwbMainRecord(lItem.Data);
    for var lWanted in TestHost.TestChangeFormIDRecords do
      if lWanted.Equals(lRecord) then begin
        lItem.Selected := True;
        Break;
      end;
  end;
  TestRefByRows(aLines, 'before');
  pmuRefByPopup(nil);
end;

procedure TxeTestFormHelper.TestRefByRows(aLines: TStrings; const aWhen: string);
var
  lItem   : TListItem;
  lRecord : IwbMainRecord;
  lActive : string;
begin
  lActive := 'none';
  if Assigned(ActiveRecord) then
    lActive := ActiveRecord.EditorID + '@' + ActiveRecord._File.FileName;
  aLines.Add('refbylist' + #9 + aWhen + #9 + 'active ' + lActive + #9 + 'page ' + pgMain.ActivePage.Name + #9 + 'rows ' +
    IntToStr(lvReferencedBy.Items.Count) + #9 + 'selected ' + IntToStr(lvReferencedBy.SelCount));
  var lColumns := '';
  for var i := Low(ActiveRecords) to High(ActiveRecords) do
    if Supports(ActiveRecords[i].Element, IwbMainRecord, lRecord) then
      lColumns := lColumns + ' ' + lRecord.EditorID + '@' + lRecord._File.FileName;
  aLines.Add('refbyview' + #9 + aWhen + #9 + 'columns' + lColumns);
  for var i := 0 to Pred(lvReferencedBy.Items.Count) do begin
    lItem := lvReferencedBy.Items[i];
    if not Assigned(lItem) or not Assigned(lItem.Data) then begin
      aLines.Add('refbyrow' + #9 + aWhen + #9 + IntToStr(i) + #9 + 'no record');
      Continue;
    end;
    lRecord := IwbMainRecord(lItem.Data);
    aLines.Add('refbyrow' + #9 + aWhen + #9 + IntToStr(i) + #9 + TestChangeFormIDText(lRecord.LoadOrderFormID) + #9 +
      string(lRecord.Signature) + #9 + lRecord.EditorID + #9 + lItem.SubItems[1] + #9 + 'selected ' + BoolToStr(lItem.Selected, True));
  end;
end;

procedure TxeTestFormHelper.TestChangeFormIDAnswerTimer(Sender: TObject);
var
  lForm   : TCustomForm;
  lResult : TModalResult;
  lText   : string;
  lExtra  : string;
  lEdit   : TEdit;
  lToken  : string;
  lList   : TCheckListBox;

  function HasButton(aOwner: TComponent; aResult: TModalResult): Boolean;
  begin
    Result := False;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if (aOwner.Components[i] is TButton) and (TButton(aOwner.Components[i]).ModalResult = aResult) then
        Exit(True);
      if HasButton(aOwner.Components[i], aResult) then
        Exit(True);
    end;
  end;

  procedure CollectText(aOwner: TComponent);
  begin
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

  function FindEdit(aOwner: TComponent): TEdit;
  begin
    Result := nil;
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TEdit then
        Exit(TEdit(aOwner.Components[i]));
      Result := FindEdit(aOwner.Components[i]);
      if Assigned(Result) then
        Exit;
    end;
  end;

  function NextToken(const aList: string; var aIndex: Integer): string;
  var
    lTokens : TArray<string>;
  begin
    Result := '';
    lTokens := aList.Split([',']);
    if aIndex > High(lTokens) then
      Exit;
    Result := LowerCase(Trim(lTokens[aIndex]));
    Inc(aIndex);
  end;

  function ListItems: string;
  begin
    Result := '';
    for var i := 0 to Pred(lList.Count) do begin
      Result := Result + ' | ' + lList.Items[i];
      if not lList.ItemEnabled[i] then
        Result := Result + ' (disabled)';
      if lList.Checked[i] then
        Result := Result + ' [checked]';
    end;
    Result := 'items:' + Result;
  end;

  procedure AnswerOpenDialog;
  var
    lWnd     : HWND;
    lItem    : Integer;
    lAnswer  : Integer;
    lCaption : array[0..255] of Char;
  begin
    if (xeTestSwitches.ChangeFormIDCsv = '') or TestHost.TestChangeFormIDCsvAnswered then
      Exit;
    lWnd := 0;
    repeat
      lWnd := FindWindowEx(0, lWnd, '#32770', nil);
      if (lWnd = 0) or not IsWindowVisible(lWnd) or (GetWindowThreadProcessId(lWnd, nil) <> MainThreadID) then
        Continue;
      if GetDlgItem(lWnd, cmb13) <> 0 then
        lItem := cmb13
      else if GetDlgItem(lWnd, edt1) <> 0 then
        lItem := edt1
      else
        Continue;
      TestHost.TestChangeFormIDCsvAnswered := True;
      GetWindowText(lWnd, lCaption, Length(lCaption));
      if SameText(xeTestSwitches.ChangeFormIDCsv, 'cancel') then
        lAnswer := IDCANCEL
      else begin
        SendMessage(lWnd, CDM_SETCONTROLTEXT, lItem, LPARAM(PChar(xeTestSwitches.ChangeFormIDCsv)));
        lAnswer := IDOK;
      end;
      TestHost.TestChangeFormIDLines.Add('answer' + #9 + string(lCaption) + #9 + IntToStr(lAnswer) + #9 + 'open dialog' + #9 +
        'listed csv ' + ExtractFileName(xeTestSwitches.ChangeFormIDCsv));
      PostMessage(lWnd, WM_COMMAND, lAnswer, 0);
      Exit;
    until lWnd = 0;
  end;

begin
  if not Assigned(TestHost.TestChangeFormIDLines) then
    Exit;
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then begin
    AnswerOpenDialog;
    Exit;
  end;
  lText := '';
  lExtra := '';
  CollectText(lForm);
  lResult := mrNone;
  if lForm is TfrmModuleSelect then begin
    lExtra := 'offered: ' + string.Join(' | ', TfrmModuleSelect(lForm).AllModules.ToStrings(False));
    var lOffered: PwbModuleInfo := nil;
    for var lInfo in TfrmModuleSelect(lForm).AllModules do
      if Assigned(TestHost.TestChangeFormIDTarget) then begin
        if lInfo = PwbModuleInfo(TestHost.TestChangeFormIDTarget.ModuleInfo) then
          lOffered := lInfo;
      end else if SameText(xeTestSwitches.ChangeFormIDTarget, 'new') and (mfTemplate in lInfo.miFlags) and not Assigned(lOffered) then
        lOffered := lInfo;
    if Assigned(lOffered) then begin
      Include(lOffered.miFlags, mfTagged);
      lResult := mrOk;
    end else begin
      TestHost.TestChangeFormIDNotOffered := True;
      lResult := mrCancel;
    end;
  end else if lForm is TfrmFileSelect then begin
    lList := TfrmFileSelect(lForm).CheckListBox1;
    if SameText(lForm.Caption, 'Please select records to update') or SameText(lForm.Caption, 'What subrecords do you want to copy?') or
       SameText(lForm.Caption, 'Which records should this value be copied to?') then begin
      lExtra := ListItems;
      lToken := NextToken(xeTestSwitches.ChangeFormIDRefs, TestHost.TestChangeFormIDRefIndex);
      if lToken = '' then begin
        lResult := mrCancel;
        lExtra := lExtra + ' fallback';
        TestHost.TestChangeFormIDFallback := True;
      end else if lToken = 'cancel' then begin
        lResult := mrCancel;
        lExtra := lExtra + ' listed answer cancel';
      end else begin
        for var i := 0 to Pred(lList.Count) do
          lList.Checked[i] := False;
        if lToken = 'all' then begin
          for var i := 0 to Pred(lList.Count) do
            if lList.ItemEnabled[i] then
              lList.Checked[i] := True;
        end else if lToken <> 'none' then
          for var lIndex in lToken.Split([';']) do begin
            var i := StrToIntDef(lIndex, -1);
            if (i >= 0) and (i < lList.Count) and lList.ItemEnabled[i] then
              lList.Checked[i] := True
            else
              lExtra := lExtra + ' index ' + lIndex + ' not checkable';
          end;
        lExtra := lExtra + ' listed answer ' + lToken;
        lResult := mrOk;
      end;
    end else if SameText(lForm.Caption, 'Which Idles do you want to copy?') then begin
      lExtra := 'items ' + IntToStr(lList.Count);
      lToken := NextToken(xeTestSwitches.ChangeFormIDRefs, TestHost.TestChangeFormIDRefIndex);
      if lToken = '' then begin
        lResult := mrCancel;
        lExtra := lExtra + ' fallback';
        TestHost.TestChangeFormIDFallback := True;
      end else if lToken = 'cancel' then begin
        lResult := mrCancel;
        lExtra := lExtra + ' listed answer cancel';
      end else begin
        lList.ItemIndex := -1;
        if lToken <> 'none' then
          for var lFolder in lToken.Split([';']) do begin
            var lListed := False;
            for var i := 0 to Pred(lList.Count) do
              if SameText(lList.Items[i], lFolder) then begin
                lList.Selected[i] := True;
                lListed := True;
              end;
            if not lListed then
              lExtra := lExtra + ' ' + lFolder + ' not listed';
          end;
        lExtra := lExtra + ' listed answer ' + lToken + ' selected ' + IntToStr(lList.ItemIndex);
        lResult := mrOk;
      end;
    end else begin
      lExtra := ListItems;
      lResult := mrOk;
    end;
  end else if lForm is TfrmLocalizePlugin then begin
    var lLocalize := TfrmLocalizePlugin(lForm);
    lExtra := 'offered: ' + string.Join(' | ', lLocalize.clbFrom.Items.ToStringArray);
    lToken := NextToken(xeTestSwitches.ChangeFormIDAnswers, TestHost.TestChangeFormIDAnswerIndex);
    if lToken = 'ok' then
      lResult := mrOk
    else if lToken = 'cancel' then
      lResult := mrCancel
    else if lToken.StartsWith('translate:') then begin
      var lParts := lToken.Split([':']);
      lLocalize.cbTranslation.Checked := True;
      for var i := 0 to Pred(lLocalize.clbFrom.Count) do begin
        lLocalize.clbFrom.Checked[i] := (Length(lParts) > 1) and SameText(lLocalize.clbFrom.Items[i], lParts[1]);
        lLocalize.clbTo.Checked[i] := (Length(lParts) > 2) and SameText(lLocalize.clbTo.Items[i], lParts[2]);
      end;
      lResult := mrOk;
    end;
    if lToken <> '' then
      lExtra := lExtra + ' listed answer ' + lToken;
    if lResult = mrNone then begin
      lResult := mrCancel;
      lExtra := lExtra + ' fallback';
      TestHost.TestChangeFormIDFallback := True;
    end;
  end else if lForm is TfrmLocalization then begin
    var lStrings := TfrmLocalization(lForm).vetStrings;
    var lFocused := lStrings.FocusedNode;
    if Assigned(lFocused) and (lFocused.Parent <> lStrings.RootNode) then
      lExtra := 'focused ' + lStrings.Text[lFocused, 0, False] + ' | ' + lStrings.Text[lFocused, 1, False] + ' | file ' +
        lStrings.Text[lFocused.Parent, 0, False]
    else
      lExtra := 'focused none';
    lResult := mrOk;
  end else if SameText(lForm.Caption, 'Model Prefix') or SameText(lForm.Caption, 'New Module File') then begin
    lEdit := FindEdit(lForm);
    if Assigned(lEdit) then
      lExtra := 'offered: ' + lEdit.Text;
    lToken := NextToken(xeTestSwitches.ChangeFormIDIds, TestHost.TestChangeFormIDIdIndex);
    if lToken = '' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' fallback').Trim;
      TestHost.TestChangeFormIDFallback := True;
    end else if lToken = 'cancel' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' listed answer cancel').Trim;
    end else begin
      if Assigned(lEdit) and (lToken <> 'offered') then
        lEdit.Text := lToken;
      if Assigned(lEdit) then
        lExtra := lExtra + ' entered: ' + lEdit.Text;
      lResult := mrOk;
    end;
  end else if SameText(xeTestSwitches.ChangeFormIDOp, 'copyidle') and string(lForm.Caption).StartsWith('EditorID ') then begin
    lEdit := FindEdit(lForm);
    if Assigned(lEdit) then
      lExtra := 'offered: ' + lEdit.Text;
    lToken := NextToken(xeTestSwitches.ChangeFormIDAnswers, TestHost.TestChangeFormIDAnswerIndex);
    if lToken = '' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' fallback').Trim;
      TestHost.TestChangeFormIDFallback := True;
    end else if lToken = 'cancel' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' listed answer cancel').Trim;
    end else begin
      if Assigned(lEdit) and (lToken <> 'ok') then
        lEdit.Text := lToken;
      if Assigned(lEdit) then
        lExtra := lExtra + ' entered: ' + lEdit.Text;
      lResult := mrOk;
    end;
  end else if string(lForm.Caption).StartsWith('New FormID') then begin
    lEdit := FindEdit(lForm);
    if Assigned(lEdit) then
      lExtra := 'offered: ' + lEdit.Text;
    lToken := NextToken(xeTestSwitches.ChangeFormIDIds, TestHost.TestChangeFormIDIdIndex);
    if lToken = '' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' fallback').Trim;
      TestHost.TestChangeFormIDFallback := True;
    end else if lToken = 'cancel' then begin
      lResult := mrCancel;
      lExtra := (lExtra + ' listed answer cancel').Trim;
    end else begin
      if Assigned(lEdit) then begin
        if lToken = 'empty' then
          lEdit.Text := ''
        else if lToken <> 'offered' then
          lEdit.Text := lToken;
        lExtra := lExtra + ' entered: ' + lEdit.Text;
      end;
      lResult := mrOk;
    end;
  end else if HasButton(lForm, mrYes) or HasButton(lForm, mrNo) or HasButton(lForm, mrYesToAll) then begin
    lToken := NextToken(xeTestSwitches.ChangeFormIDAnswers, TestHost.TestChangeFormIDAnswerIndex);
    if lToken = 'yes' then
      lResult := mrYes
    else if lToken = 'no' then
      lResult := mrNo
    else if lToken = 'yesall' then
      lResult := mrYesToAll
    else if lToken = 'cancel' then
      lResult := mrCancel;
    if lToken <> '' then
      lExtra := 'listed answer ' + lToken;
    if (lResult <> mrNone) and not HasButton(lForm, lResult) then begin
      lExtra := lExtra + ', no such button';
      lResult := mrNone;
    end;
    if lResult = mrNone then begin
      if HasButton(lForm, mrCancel) then
        lResult := mrCancel
      else
        lResult := mrNo;
      lExtra := (lExtra + ' fallback').Trim;
      TestHost.TestChangeFormIDFallback := True;
    end;
  end else if HasButton(lForm, mrOk) then
    lResult := mrOk;
  if lResult = mrNone then
    Exit;
  Inc(TestHost.TestChangeFormIDAnswerCount);
  if TestHost.TestChangeFormIDAnswerCount > 40 then begin
    lResult := mrCancel;
    lExtra := (lExtra + ' too many dialogs, cancelled').Trim;
    TestHost.TestChangeFormIDFallback := True;
  end;
  lText := lText.Replace(#13, ' ').Replace(#10, ' ');
  if Length(lText) > 600 then
    lText := Copy(lText, 1, 600) + '...';
  TestHost.TestChangeFormIDLines.Add('answer' + #9 + lForm.Caption + #9 + IntToStr(lResult) + #9 + lText.Trim + #9 + lExtra);
  lForm.ModalResult := lResult;
end;

procedure TxeTestFormHelper.TestChangeFormIDReportTimer(Sender: TObject);
begin
  TestHost.TestChangeFormIDTimer.Enabled := False;
  TestChangeFormIDAfter(TestHost.TestChangeFormIDLines);
  TestChangeFormIDWrite;
end;

procedure TxeTestFormHelper.TestChangeFormIDAfter(aLines: TStrings);

  function LeveledText(const aRecord: IwbMainRecord): string;
  var
    lEntries : IwbContainerElementRef;
    lEntry   : IwbContainerElementRef;
    lData    : IwbContainerElementRef;
    lCounter : IwbElement;
  begin
    if not Assigned(aRecord) then
      Exit('none');
    Result := 'entries 0';
    if Supports(aRecord.ElementByName['Leveled List Entries'], IwbContainerElementRef, lEntries) then begin
      Result := 'entries ' + IntToStr(lEntries.ElementCount);
      for var i := 0 to Pred(lEntries.ElementCount) do
        if Supports(lEntries.Elements[i], IwbContainerElementRef, lEntry) then begin
          if not Supports(lEntry.ElementBySignature['LVLO'], IwbContainerElementRef, lData) then
            lData := lEntry;
          Result := Result + ' ' + lData.ElementEditValues['Level'] + '/' + lData.ElementEditValues['Count'];
        end;
    end;
    lCounter := aRecord.ElementBySignature['LLCT'];
    if Assigned(lCounter) then
      Result := Result + #9 + 'LLCT ' + lCounter.EditValue
    else
      Result := Result + #9 + 'LLCT none';
  end;

var
  lLines    : TStrings;
  lStream   : TMemoryStream;
  lPosted   : TDictionary<string, Integer>;
  lText     : string;
  lCount    : Integer;
  lLocalize : Boolean;
  lHandler  : TwbLocalizationHandler;
begin
  lLines := aLines;
  lLocalize := SameText(xeTestSwitches.ChangeFormIDOp, 'localize');
  try
    lPosted := TDictionary<string, Integer>.Create;
    try
      for var lLine in lLines do
        if lLine.StartsWith('progress' + #9) and (Length(lLine) > 9) then begin
          lText := lLine.Substring(9);
          if lPosted.TryGetValue(lText, lCount) then
            lPosted[lText] := lCount + 1
          else
            lPosted.Add(lText, 1);
        end;
      for var i := TestHost.TestChangeFormIDMessages to Pred(mmoMessages.Lines.Count) do begin
        lText := TestChangeFormIDMask(mmoMessages.Lines[i]);
        if lText.StartsWith('[<t>] ') and lPosted.TryGetValue(lText.Substring(6), lCount) and (lCount > 0) then
          lPosted[lText.Substring(6)] := lCount - 1
        else if lPosted.TryGetValue(lText, lCount) and (lCount > 0) then
          lPosted[lText] := lCount - 1
        else
          lLines.Add('message' + #9 + lText);
      end;
    finally
      lPosted.Free;
    end;
    TestChangeFormIDRecordLines(lLines, 'after', TestHost.TestChangeFormIDRecords, TestHost.TestChangeFormIDBefore);
    TestChangeFormIDFiles(lLines, 'after', Files);
    if lLocalize then
      TestChangeFormIDLocalization(lLines, 'after', TestHost.TestChangeFormIDTarget);
    if SameText(xeTestSwitches.ChangeFormIDOp, 'copyspawnrate') then
      for var lSource in TestHost.TestChangeFormIDRecords do begin
        var lCopy: IwbMainRecord := nil;
        if Assigned(TestHost.TestChangeFormIDTarget) then
          lCopy := TestHost.TestChangeFormIDTarget.ContainedRecordByLoadOrderFormID[lSource.LoadOrderFormID, False];
        lLines.Add('leveled' + #9 + 'source ' + lSource.EditorID + '@' + lSource._File.FileName + #9 + LeveledText(lSource));
        lLines.Add('leveled' + #9 + 'copy in ' + xeTestSwitches.ChangeFormIDTarget + #9 + LeveledText(lCopy));
      end;

    ForceDirectories(xeTestSwitches.ChangeFormIDOut);
    for var i := Low(Files) to High(Files) do
      if [fsIsGameMaster, fsIsHardcoded] * Files[i].FileStates = [] then begin
        lStream := TMemoryStream.Create;
        try
          try
            Files[i].WriteToStream(lStream, rmNo);
            Files[i].SetElementState(esUnsaved, True);
            lStream.SaveToFile(TPath.Combine(xeTestSwitches.ChangeFormIDOut, Files[i].FileName));
            lLines.Add('written' + #9 + Files[i].FileName + #9 + IntToStr(lStream.Size) + #9 +
              IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
          except
            on E: Exception do
              lLines.Add('notwritten' + #9 + Files[i].FileName + #9 + E.ClassName + #9 + E.Message);
          end;
        finally
          lStream.Free;
        end;
      end;
    if lLocalize then begin
      lHandler := xeContext.LocalizationHandler;
      ForceDirectories(TPath.Combine(xeTestSwitches.ChangeFormIDOut, 'Strings'));
      for var i := 0 to Pred(lHandler.Count) do
        if lHandler[i].Modified then begin
          lStream := TMemoryStream.Create;
          try
            lHandler[i].WriteToStream(lStream);
            lStream.SaveToFile(TPath.Combine(TPath.Combine(xeTestSwitches.ChangeFormIDOut, 'Strings'), lHandler[i].Name));
            lLines.Add('written' + #9 + 'Strings\' + lHandler[i].Name + #9 + IntToStr(lStream.Size) + #9 +
              IntToHex(TwbHash.XXH64(lStream.Memory, lStream.Size), 16));
          finally
            lStream.Free;
          end;
        end;
    end;
    CheckResult := 0;
  except
    on E: Exception do begin
      AddMessage('[Test Change FormID] FAILED: ' + E.ClassName + ': ' + E.Message);
      lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
end;

procedure TxeTestFormHelper.TestChangeFormIDSave;
var
  lTmp : string;
begin
  TestHost.TestChangeFormIDLines.Add('# checkResult = ' + IntToStr(CheckResult));
  lTmp := xeTestSwitches.ChangeFormIDFile + '.partial';
  TestHost.TestChangeFormIDLines.SaveToFile(lTmp, TEncoding.UTF8);
  if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.ChangeFormIDFile), MOVEFILE_REPLACE_EXISTING) then
    RaiseLastOSError;
end;

procedure TxeTestFormHelper.TestChangeFormIDWrite;
begin
  try
    TestChangeFormIDSave;
  finally
    FreeAndNil(TestHost.TestChangeFormIDLines);
    TestHost.TestChangeFormIDRecords := nil;
    TestHost.TestChangeFormIDTarget := nil;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.TestChangeFormIDOnClose;
begin
  if not Assigned(TestHost.TestChangeFormIDLines) or TestHost.TestChangeFormIDClosed then
    Exit;
  TestHost.TestChangeFormIDClosed := True;
  TestHost.TestChangeFormIDLines.Add('close');
  TestChangeFormIDAfter(TestHost.TestChangeFormIDLines);
  try
    TestChangeFormIDSave;
  except
    on E: Exception do
      AddMessage('[Test Change FormID] the report could not be written: ' + E.ClassName + ': ' + E.Message);
  end;
end;

procedure TxeTestFormHelper.DoTestHide;
begin
  xeContext.Settings.DontSave := True;
  TestHost.TestHideTimer := TTimer.Create(Self);
  TestHost.TestHideTimer.Interval := 500;
  TestHost.TestHideTimer.OnTimer := TestHideRunTimer;
  TestHost.TestHideTimer.Enabled := True;
end;

procedure TxeTestFormHelper.TestHideRunTimer(Sender: TObject);
var
  lLines    : TStringList;
  lMaster   : IwbMainRecord;
  lOverride : IwbMainRecord;
  lModule   : IwbFile;
  lTmp      : string;

  procedure Verdict(const aArm, aWhen: string);
  var
    lCA      : TConflictAll;
    lCT      : TConflictThis;
    lColumns : string;
  begin
    DoSetActiveRecord(lMaster, True);
    lColumns := '';
    for var i := Low(ActiveRecords) to High(ActiveRecords) do
      if Assigned(ActiveRecords[i].Element) then
        lColumns := lColumns + ' ' + ActiveRecords[i].Element._File.FileName;
    ConflictLevelForMainRecord(lMaster, lCA, lCT);
    lLines.Add(string.Join(#9, [aArm, aWhen, 'view', IntToStr(Length(ActiveRecords)) + ' columns:' + lColumns,
      wbNameConflictAll[lCA] + ' / ' + wbNameConflictThis[lCT]]));
  end;

  procedure NavFocus(const aElement: IwbElement);
  var
    lNode : PVirtualNode;
  begin
    lNode := FindNodeForElement(aElement);
    if not Assigned(lNode) then
      raise Exception.Create('no navigation node for ' + aElement.Name);
    vstNav.ClearSelection;
    vstNav.FocusedNode := lNode;
    vstNav.Selected[lNode] := True;
    pmuNavPopup(nil);
  end;

  procedure NavMenu(const aArm, aWhen: string; const aElement: IwbElement);
  begin
    NavFocus(aElement);
    lLines.Add(string.Join(#9, [aArm, aWhen, 'nav Hidden', 'visible ' + BoolToStr(mniNavHidden.Visible, True) + ', checked ' +
      BoolToStr(mniNavHidden.Checked, True)]));
  end;

  procedure NavToggle(const aElement: IwbElement);
  begin
    NavFocus(aElement);
    mniNavHidden.Click;
  end;

  procedure HeaderMenu(const aArm, aWhen: string; const aRecord: IwbMainRecord);
  var
    lColumn : Integer;
  begin
    DoSetActiveRecord(lMaster, True);
    lColumn := -1;
    for var i := Low(ActiveRecords) to High(ActiveRecords) do
      if Assigned(ActiveRecords[i].Element) and ActiveRecords[i].Element.Equals(aRecord) then
        lColumn := i;
    if lColumn < 0 then
      raise Exception.Create(aRecord.Name + ' is not a column of the View tab');
    var lRtti := TRttiContext.Create;
    lRtti.GetType(vstView.Header.Columns.ClassType).GetField('FPopupIndex').SetValue(vstView.Header.Columns, lColumn + 1);
    pmuViewHeaderPopup(nil);
    lLines.Add(string.Join(#9, [aArm, aWhen, 'header column ' + IntToStr(lColumn), 'Hide visible ' +
      BoolToStr(mniViewHeaderHidden.Visible, True) + ', checked ' + BoolToStr(mniViewHeaderHidden.Checked, True) +
      ', Unhide all visible ' + BoolToStr(mniViewHeaderUnhideAll.Visible, True)]));
  end;

  procedure Search(const aArm, aWhen: string);
  var
    lKey  : Word;
    lData : PNavNodeData;
  begin
    edEditorIDSearch.Text := lMaster.EditorID;
    vstNav.ClearSelection;
    vstNav.FocusedNode := vstNav.GetFirst;
    lKey := VK_RETURN;
    edEditorIDSearchKeyDown(nil, lKey, []);
    lData := vstNav.GetNodeData(vstNav.FocusedNode);
    if Assigned(lData) and Assigned(lData.Element) then
      lLines.Add(string.Join(#9, [aArm, aWhen, 'EditorID search', 'found ' + lData.Element.Name + ' in ' + lData.Element._File.FileName]))
    else
      lLines.Add(string.Join(#9, [aArm, aWhen, 'EditorID search', 'found nothing']));
  end;

begin
  TestHost.TestHideTimer.Enabled := False;
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit hide probe');
    lLines.Add('# ' + xeApplicationTitle);
    lLines.Add('# record = ' + xeTestSwitches.HideRecord + ' of ' + xeTestSwitches.HideMaster + ', module = ' + xeTestSwitches.HideModule);
    lLines.Add('# Columns, tab separated: arm / when / what / state');
    CheckResult := 2;
    try
      lMaster := nil;
      lModule := nil;
      for var i := Low(Files) to High(Files) do begin
        if SameText(Files[i].FileName, xeTestSwitches.HideMaster) then
          lMaster := Files[i].RecordByFormID[TwbFormID.FromStr(xeTestSwitches.HideRecord), True, True];
        if SameText(Files[i].FileName, xeTestSwitches.HideModule) then
          lModule := Files[i];
      end;
      if not Assigned(lMaster) then
        raise Exception.Create('no record ' + xeTestSwitches.HideRecord + ' in ' + xeTestSwitches.HideMaster);
      if not Assigned(lModule) then
        raise Exception.Create('no module ' + xeTestSwitches.HideModule);
      lMaster := lMaster.MasterOrSelf;
      lOverride := nil;
      for var i := 0 to Pred(lMaster.OverrideCount) do
        if lMaster.Overrides[i]._File.Equals(lModule) then
          lOverride := lMaster.Overrides[i];
      if not Assigned(lOverride) then
        raise Exception.Create(lMaster.Name + ' has no override in ' + xeTestSwitches.HideModule);
      if lMaster.EditorID = '' then
        raise Exception.Create(lMaster.Name + ' has no EditorID to search for');
      lLines.Add('# master = ' + lMaster.Name + ' in ' + lMaster._File.FileName + ', override in ' + lModule.FileName);

      Verdict('base', 'before');

      NavMenu('navRecord', 'before', lOverride);
      NavToggle(lOverride);
      NavMenu('navRecord', 'hidden', lOverride);
      Verdict('navRecord', 'hidden');
      NavToggle(lOverride);
      NavMenu('navRecord', 'shown', lOverride);
      Verdict('navRecord', 'shown');

      HeaderMenu('header', 'before', lOverride);
      mniViewHeaderHidden.Click;
      Verdict('header', 'hidden');
      HeaderMenu('header', 'master column', lMaster);
      mniViewHeaderUnhideAll.Click;
      Verdict('header', 'unhidden');
      HeaderMenu('header', 'after', lOverride);

      NavMenu('navFile', 'before', lModule);
      NavToggle(lModule);
      NavMenu('navFile', 'hidden', lModule);
      Verdict('navFile', 'hidden');
      NavToggle(lModule);
      Verdict('navFile', 'shown');

      Search('search', 'nothing hidden');
      NavToggle(lMaster);
      Search('search', 'master hidden');
      NavToggle(lMaster);
      Search('search', 'master shown');

      NavToggle(lModule);
      HeaderMenu('unhideAll', 'file hidden', lMaster);
      mniViewHeaderUnhideAll.Click;
      NavMenu('unhideAll', 'clicked', lModule);
      Verdict('unhideAll', 'clicked');
      HeaderMenu('unhideAll', 'clicked', lMaster);
      NavToggle(lModule);
      Verdict('unhideAll', 'file shown');

      CheckResult := 0;
    except
      on E: Exception do begin
        AddMessage('[Test Hide] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.HideFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.HideFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestFilter;
var
  lLines : TStringList;
  lTmp   : string;
  lNode  : PVirtualNode;
  lData  : PNavNodeData;
  lCount : Integer;
begin
  lLines := TStringList.Create;
  try
    lLines.Add('# xEdit filter probe');
    lLines.Add('# ' + xeApplicationTitle);
    if xeTestSwitches.FilterPreset = '' then
      lLines.Add('# filter = by persistent, everything else off')
    else
      lLines.Add('# filter = the "' + xeTestSwitches.FilterPreset + '" preset');
    if xeTestSwitches.FilterByValue <> '' then
      lLines.Add('# before the filter: FilterByElementValue = True, FilterElementValue = ' + xeTestSwitches.FilterByValue +
        ' (what the filter dialog''s apply leaves after a filter by element value)');
    lLines.Add('# Columns, tab separated: record left in the tree / file');
    CheckResult := 2;
    try
      if xeTestSwitches.FilterByValue <> '' then begin
        FilterByElementValue := True;
        FilterElementValue := xeTestSwitches.FilterByValue;
      end;
      if SameText(xeTestSwitches.FilterPreset, 'cleaning') then
        mniNavFilterForCleaningClick(nil)
      else if SameText(xeTestSwitches.FilterPreset, 'onlyone') then
        mniNavFilterForOnlyOneClick(nil)
      else if SameText(xeTestSwitches.FilterPreset, 'conflicts') then
        mniNavFilterConflictsClick(nil)
      else begin
        FilterConflictAll := False;
        FilterConflictThis := False;
        FilterByInjectStatus := False;
        FilterInjectStatus := False;
        FilterByNotReachableStatus := False;
        FilterNotReachableStatus := False;
        FilterByReferencesInjectedStatus := False;
        FilterReferencesInjectedStatus := False;
        FilterByEditorID := False;
        FilterEditorID := '';
        FilterByName := False;
        FilterName := '';
        FilterByBaseEditorID := False;
        FilterBaseEditorID := '';
        FilterByBaseName := False;
        FilterBaseName := '';
        FilterScaledActors := False;
        FilterByPersistent := True;
        FilterPersistent := True;
        FilterUnnecessaryPersistent := False;
        FilterMasterIsTemporary := False;
        FilterIsMaster := False;
        FilterPersistentPosChanged := False;
        FilterDeleted := False;
        FilterByVWD := False;
        FilterVWD := False;
        FilterByHasVWDMesh := False;
        FilterHasVWDMesh := False;
        FilterByHasPrecombinedMesh := False;
        FilterHasPrecombinedMesh := False;
        FilterBySignature := False;
        FilterSignatures := '';
        FilterByBaseSignature := False;
        FilterBaseSignatures := '';
        FilterConflictAllSet := [];
        FilterConflictThisSet := [];
        FlattenBlocks := True;
        FlattenCellChilds := True;
        AssignPersWrldChild := True;
        InheritConflictByParent := True;
        FilterPreset := True;
        try
          mniNavFilterApplyClick(nil);
        finally
          FilterPreset := False;
        end;
      end;
      lLines.Add('# after the filter: FilterByElementValue = ' + BoolToStr(FilterByElementValue, True));
      lCount := 0;
      lNode := vstNav.GetFirst;
      while Assigned(lNode) do begin
        lData := vstNav.GetNodeData(lNode);
        if Assigned(lData) and Supports(lData.Element, IwbMainRecord) then begin
          Inc(lCount);
          if xeTestSwitches.FilterPreset = '' then
            lLines.Add(lData.Element.Name + #9 + lData.Element._File.FileName);
        end;
        lNode := vstNav.GetNext(lNode);
      end;
      lLines.Add('# records left: ' + IntToStr(lCount));
      if xeTestSwitches.FilterImages > 0 then
        TestFilterImages(lLines);
      if xeTestSwitches.FilterRemove <> '' then begin
        xeContext.Settings.DontSave := True;
        EditWarnOk := True;
        var lFile : IwbFile := nil;
        for var i := Low(Files) to High(Files) do
          if SameText(Files[i].FileName, xeTestSwitches.FilterRemove) then
            lFile := Files[i];
        if not Assigned(lFile) then
          raise Exception.Create('no module ' + xeTestSwitches.FilterRemove);
        lNode := FindNodeForElement(lFile);
        if not Assigned(lNode) then
          raise Exception.Create('no nav node for ' + lFile.FileName);
        var lBefore := lFile.RecordCount;
        vstNav.ClearSelection;
        vstNav.Selected[lNode] := True;
        vstNav.FocusedNode := lNode;
        TestHost.TestFilterAnswered := '';
        TestHost.TestFilterAnswer := TTimer.Create(Self);
        TestHost.TestFilterAnswer.Interval := 100;
        TestHost.TestFilterAnswer.OnTimer := TestFilterAnswerTimer;
        TestHost.TestFilterAnswer.Enabled := True;
        try
          mniNavRemoveIdenticalToMasterClick(nil);
        finally
          TestHost.TestFilterAnswer.Enabled := False;
        end;
        if TestHost.TestFilterAnswered <> '' then
          lLines.Add('# remove: a dialog was answered: ' + TestHost.TestFilterAnswered);
        lLines.Add('# remove: ' + lFile.FileName + ' records before ' + IntToStr(lBefore) + ', after ' + IntToStr(lFile.RecordCount));
      end;
      CheckResult := 0;
    except
      on E: Exception do begin
        AddMessage('[Test Filter] FAILED: ' + E.ClassName + ': ' + E.Message);
        lLines.Add('# FAILED: ' + E.ClassName + ': ' + E.Message);
      end;
    end;
    lLines.Add('# checkResult = ' + IntToStr(CheckResult));
    lTmp := xeTestSwitches.FilterFile + '.partial';
    lLines.SaveToFile(lTmp, TEncoding.UTF8);
    if not MoveFileEx(PChar(lTmp), PChar(xeTestSwitches.FilterFile), MOVEFILE_REPLACE_EXISTING) then
      RaiseLastOSError;
  finally
    lLines.Free;
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.TestFilterImages(aLines: TStrings);
var
  lNode  : PVirtualNode;
  lData  : PNavNodeData;
  lRow   : TRect;
  lBelow : TRect;
  lAsIs  : Vcl.Graphics.TBitmap;

  function Grab: Vcl.Graphics.TBitmap;
  begin
    Result := Vcl.Graphics.TBitmap.Create;
    Result.PixelFormat := pf32bit;
    Result.SetSize(vstNav.ClientWidth, vstNav.ClientHeight);
    var lDC := GetDC(vstNav.Handle);
    try
      BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, lDC, 0, 0, SRCCOPY);
    finally
      ReleaseDC(vstNav.Handle, lDC);
    end;
  end;

  function Pixel(aImage: Vcl.Graphics.TBitmap; x, y: Integer): Cardinal;
  begin
    Result := PCardinal(PByte(aImage.ScanLine[y]) + x * 4)^ and $FFFFFF;
  end;

  procedure Step(const aTag: string);
  begin
    DoProcessMessages;
    Sleep(100);
    DoProcessMessages;
    var lImage := Grab;
    try
      lImage.SaveToFile(ChangeFileExt(xeTestSwitches.FilterFile, '.' + aTag + '.bmp'));
      if not Assigned(lAsIs) then begin
        lAsIs := lImage;
        lImage := nil;
        var lMarks := 0;
        for var y := 0 to Pred(lRow.Height) do
          for var x := 0 to Pred(lAsIs.Width) do
            if Pixel(lAsIs, x, lRow.Top + y) <> Pixel(lAsIs, x, lBelow.Top + y) then
              Inc(lMarks);
        aLines.Add(Format('# image %s: the last row differs from the empty row below it on %d pixels', [aTag, lMarks]));
      end else begin
        var lMarks := 0;
        var lCopied := 0;
        var lChanged := 0;
        for var y := 0 to Pred(lRow.Height) do
          for var x := 0 to Pred(lAsIs.Width) do begin
            var lMark := Pixel(lAsIs, x, lRow.Top + y);
            var lEmpty := Pixel(lAsIs, x, lBelow.Top + y);
            var lNow := Pixel(lImage, x, lBelow.Top + y);
            if lNow <> lEmpty then
              Inc(lChanged);
            if lMark <> lEmpty then begin
              Inc(lMarks);
              if lNow = lMark then
                Inc(lCopied);
            end;
          end;
        aLines.Add(Format('# image %s: the row below the last node changed on %d pixels; it copies the last row on %d of its %d marks',
          [aTag, lChanged, lCopied, lMarks]));
      end;
    finally
      lImage.Free;
    end;
  end;

begin
  lAsIs := nil;
  try
    lNode := vstNav.GetLastVisible;
    if not Assigned(lNode) then begin
      aLines.Add('# image: no visible node');
      Exit;
    end;
    vstNav.ScrollIntoView(lNode, False);
    DoProcessMessages;
    lRow := vstNav.GetDisplayRect(lNode, NoColumn, False);
    lBelow := lRow;
    OffsetRect(lBelow, 0, lRow.Height);
    lBelow.Left := 0;
    lBelow.Right := vstNav.ClientWidth;
    aLines.Add(Format('# image: last row %d..%d, client %d x %d, style %s', [lRow.Top, lRow.Bottom, vstNav.ClientWidth,
      vstNav.ClientHeight, TStyleManager.ActiveStyle.Name]));
    if lBelow.Bottom > vstNav.ClientHeight then begin
      aLines.Add('# image: no empty row below the last node');
      Exit;
    end;
    Step('asis');

    InvalidateRect(vstNav.Handle, @lBelow, False);
    UpdateWindow(vstNav.Handle);
    Step('invalidrow');

    var lStrip := lBelow;
    lStrip.Left := lStrip.Right - lStrip.Width div 4;
    InvalidateRect(vstNav.Handle, @lStrip, False);
    UpdateWindow(vstNav.Handle);
    Step('invalidstrip');

    for var i := 0 to 40 do begin
      var lY := lBelow.Top + lBelow.Height div 2 + (i mod 3) * lRow.Height;
      SendMessage(vstNav.Handle, WM_MOUSEMOVE, 0, MakeLParam(10 + i * (vstNav.ClientWidth - 20) div 40, lY));
      DoProcessMessages;
    end;
    Step('mousebelow');

    for var i := 0 to 40 do begin
      var lY := lRow.Top + lRow.Height div 2;
      if Odd(i) then
        lY := lBelow.Top + lBelow.Height div 2;
      SendMessage(vstNav.Handle, WM_MOUSEMOVE, 0, MakeLParam(20 + i * 10, lY));
      DoProcessMessages;
    end;
    Step('mouseacross');

    for var c := 0 to Pred(vstNav.Header.Columns.Count) do begin
      vstNav.InvalidateColumn(c);
      UpdateWindow(vstNav.Handle);
      Step('column' + IntToStr(c));
    end;

    vstNav.Invalidate;
    UpdateWindow(vstNav.Handle);
    Step('whole');
  finally
    lAsIs.Free;
  end;

  while Assigned(lNode) do begin
    lData := vstNav.GetNodeData(lNode);
    if Assigned(lData) and Assigned(lData.Element) then
      aLines.Add(Format('# last visible: %s (level %d, index %d, verdict %s / %s)', [lData.Element.Name,
        vstNav.GetNodeLevel(lNode), lNode.Index, wbNameConflictAll[lData.ConflictAll], wbNameConflictThis[lData.ConflictThis]]))
    else
      aLines.Add(Format('# last visible: (no element) (level %d, index %d)', [vstNav.GetNodeLevel(lNode), lNode.Index]));
    lNode := lNode.Parent;
    if lNode = vstNav.RootNode then
      Break;
  end;
end;

procedure TxeTestFormHelper.TestFilterAnswerTimer(Sender: TObject);
var
  lForm : TCustomForm;
  lText : string;

  procedure CollectText(aOwner: TComponent);
  begin
    for var i := 0 to Pred(aOwner.ComponentCount) do begin
      if aOwner.Components[i] is TLabel then
        lText := lText + ' ' + TLabel(aOwner.Components[i]).Caption;
      CollectText(aOwner.Components[i]);
    end;
  end;

begin
  lForm := nil;
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      lForm := Screen.CustomForms[i];
      Break;
    end;
  if not Assigned(lForm) then
    Exit;
  lText := '';
  CollectText(lForm);
  TestHost.TestFilterAnswered := TestHost.TestFilterAnswered + '[' + lForm.Caption + ']' + lText.Replace(#13, ' ').Replace(#10, ' ');
  lForm.ModalResult := mrOk;
end;

function TxeTestFormHelper.TestPumpInside: Boolean;
begin
  if xeTestSwitches.PumpDuringLoad <> '' then
    Result := LoaderStarted and not xeContext.LoaderDone and
      (SameText(xeTestSwitches.PumpDuringLoad, 'any') or xeContext.BuildingRefsParallel)
  else if xeTestSwitches.PumpGenerator then
    Result := GeneratorStarted and not GeneratorDone
  else if xeTestSwitches.PumpModal then
    Result := (ProcessMessagesLockCount < 1) and HandleAllocated and not IsWindowEnabled(Handle)
  else
    Result := ProcessMessagesLockCount > 0;
end;

procedure TxeTestFormHelper.TestPumpShortCutExecute(Sender: TObject);
begin
  TestPumpNote('the shortcut action ran ' + IfThen(TestPumpInside, 'inside the nested loop', 'outside any nested loop'));
end;

procedure TxeTestFormHelper.TestPumpNote(const aText: string);
begin
  TFile.AppendAllText(xeTestSwitches.PumpFile, aText + sLineBreak);
end;

procedure TxeTestFormHelper.TestPumpSetCtrl(aDown: Boolean);
var
  lState: TKeyboardState;
begin
  GetKeyboardState(lState);
  if aDown then
    lState[VK_CONTROL] := lState[VK_CONTROL] or $80
  else
    lState[VK_CONTROL] := lState[VK_CONTROL] and not $80;
  SetKeyboardState(lState);
  TestHost.TestPumpCtrlDown := aDown;
end;

procedure TxeTestFormHelper.TestPumpStart;
begin
  System.SysUtils.DeleteFile(xeTestSwitches.PumpFile);
  TestPumpNote('# xEdit pump probe: arrival "' + xeTestSwitches.Pump + '"');
  if SameText(xeTestSwitches.Pump, 'xback') then begin
    if not Assigned(BackHistory) then
      BackHistory := TInterfaceList.Create;
    BackHistory.Add(TMainRecordPosHistoryEntry.Create(Files[High(Files)].Header));
    TestPumpNote('back history: ' + Files[High(Files)].Header.Name);
  end;
  if SameText(xeTestSwitches.Pump, 'cancelshortcut') then begin
    TestHost.TestPumpShortCut := TAction.Create(Self);
    TestHost.TestPumpShortCut.ActionList := ActionList1;
    TestHost.TestPumpShortCut.ShortCut := ShortCut(VK_F12, [ssCtrl]);
    TestHost.TestPumpShortCut.OnExecute := TestPumpShortCutExecute;
  end;
  TestHost.TestPumpDelivered := False;
  TestHost.TestPumpEnded := False;
  TestHost.TestPumpBrowseNode := nil;
  TestHost.TestPumpBrowseCount := 0;
  TestHost.TestPumpClosePosted := False;
  TestHost.TestPumpWalkFile := 0;
  TestHost.TestPumpWalkIndex := 0;
  TestHost.TestPumpWalkReads := 0;
  TestHost.TestPumpWalkChars := 0;
  TestHost.TestPumpWalkFaults := 0;
  TestHost.TestPumpWalkFirstFault := '';
  TestHost.TestPumpSeen := '';
  TestHost.TestPumpModalBase := nil;
  TestHost.TestPumpFocus := 0;
  TestHost.TestPumpTimer := TTimer.Create(Self);
  TestHost.TestPumpTimer.Interval := 1;
  TestHost.TestPumpTimer.OnTimer := TestPumpTimerTimer;
end;

procedure TxeTestFormHelper.TestPumpBrowseStep;
begin
  var lNode := TestHost.TestPumpBrowseNode;
  if Assigned(lNode) then
    lNode := vstNav.GetNext(lNode)
  else
    lNode := vstNav.GetFirst;
  while Assigned(lNode) do begin
    var lData := PNavNodeData(vstNav.GetNodeData(lNode));
    if Assigned(lData) and Supports(lData.Element, IwbMainRecord) then
      Break;
    lNode := vstNav.GetNext(lNode);
  end;
  TestHost.TestPumpBrowseNode := lNode;
  if not Assigned(lNode) then
    Exit;
  vstNav.ClearSelection;
  vstNav.FocusedNode := lNode;
  vstNav.Selected[lNode] := True;
  Inc(TestHost.TestPumpBrowseCount);
end;

procedure TxeTestFormHelper.TestPumpEdidWalkStep;
begin
  var lUntil := GetTickCount64 + 200;
  while (GetTickCount64 < lUntil) and (Length(Files) > 0) do begin
    if TestHost.TestPumpWalkFile > High(Files) then
      TestHost.TestPumpWalkFile := 0;
    var lFile := Files[TestHost.TestPumpWalkFile];
    if TestHost.TestPumpWalkIndex >= lFile.RecordCount then begin
      TestHost.TestPumpWalkIndex := 0;
      Inc(TestHost.TestPumpWalkFile);
      Continue;
    end;
    try
      var lRec := lFile.Records[TestHost.TestPumpWalkIndex];
      if Assigned(lRec) then
        Inc(TestHost.TestPumpWalkChars, Length(lRec.EditorID));
      Inc(TestHost.TestPumpWalkReads);
    except
      on E: Exception do begin
        Inc(TestHost.TestPumpWalkFaults);
        if TestHost.TestPumpWalkFirstFault = '' then
          TestHost.TestPumpWalkFirstFault := E.ClassName + ': ' + E.Message;
      end;
    end;
    Inc(TestHost.TestPumpWalkIndex);
  end;
end;

procedure TxeTestFormHelper.TestPumpInitWalkStep;
begin
  var lUntil := GetTickCount64 + 200;
  while (GetTickCount64 < lUntil) and (Length(Files) > 0) do begin
    var lTop := High(TestHost.TestPumpWalkStack);
    if lTop < 0 then begin
      if TestHost.TestPumpWalkFile > High(Files) then
        TestHost.TestPumpWalkFile := 0;
      TestHost.TestPumpWalkStack := [Files[TestHost.TestPumpWalkFile] as IwbContainer];
      TestHost.TestPumpWalkPos := [0];
      Inc(TestHost.TestPumpWalkFile);
      Continue;
    end;
    try
      var lContainer := TestHost.TestPumpWalkStack[lTop];
      if TestHost.TestPumpWalkPos[lTop] >= lContainer.ElementCount then begin
        lContainer := nil;
        SetLength(TestHost.TestPumpWalkStack, lTop);
        SetLength(TestHost.TestPumpWalkPos, lTop);
        Continue;
      end;
      var lElement := lContainer.Elements[TestHost.TestPumpWalkPos[lTop]];
      Inc(TestHost.TestPumpWalkPos[lTop]);
      var lRec: IwbMainRecord;
      var lGroup: IwbGroupRecord;
      if Supports(lElement, IwbMainRecord, lRec) then begin
        Inc(TestHost.TestPumpWalkChars, (lRec as IwbContainer).ElementCount);
        Inc(TestHost.TestPumpWalkReads);
      end else if Supports(lElement, IwbGroupRecord, lGroup) then begin
        TestHost.TestPumpWalkStack := TestHost.TestPumpWalkStack + [lGroup as IwbContainer];
        TestHost.TestPumpWalkPos := TestHost.TestPumpWalkPos + [0];
      end;
    except
      on E: Exception do begin
        Inc(TestHost.TestPumpWalkFaults);
        if TestHost.TestPumpWalkFirstFault = '' then
          TestHost.TestPumpWalkFirstFault := E.ClassName + ': ' + E.Message;
        TestHost.TestPumpWalkStack := nil;
        TestHost.TestPumpWalkPos := nil;
      end;
    end;
  end;
end;

function TxeTestFormHelper.TestPumpRefDigest: string;
var
  lHash    : THashSHA2;
  lMasters : Int64;
  lRefs    : Int64;
begin
  lMasters := 0;
  lRefs := 0;
  lHash := THashSHA2.Create;
  for var lFile in Files do
    for var lIndex := 0 to Pred(lFile.RecordCount) do begin
      var lRec := lFile.Records[lIndex];
      if not Assigned(lRec) or not lRec.MasterOrSelf.Equals(lRec) then
        Continue;
      Inc(lMasters);
      var lLine := IntToHex(lRec.LoadOrderFormID.ToCardinal, 8) + '@' + IntToStr(lFile.LoadOrder) + ':';
      for var lRefIndex := 0 to Pred(lRec.ReferencedByCount) do begin
        var lRef := lRec.ReferencedBy[lRefIndex];
        lLine := lLine + ' ' + IntToHex(lRef.LoadOrderFormID.ToCardinal, 8) + '@' + IntToStr(lRef._File.LoadOrder);
        Inc(lRefs);
      end;
      lHash.Update(TEncoding.UTF8.GetBytes(lLine + #10));
    end;
  Result := 'masters ' + IntToStr(lMasters) + ', references ' + IntToStr(lRefs) + ', referenced-by sha256 ' + lHash.HashAsString;
end;

procedure TxeTestFormHelper.TestPumpTimerTimer(Sender: TObject);
var
  lFocus : HWND;
  lCtrl  : TWinControl;
  lWhere : string;
begin
  if not TestHost.TestPumpDelivered then begin
    if not TestPumpInside then
      Exit;
    if xeTestSwitches.PumpDirect and (ProcessMessagesLockCount > 0) then
      Exit;
    if SameText(xeTestSwitches.PumpClient, 'enabled') and not pnlClient.Enabled then
      Exit;
    if SameText(xeTestSwitches.PumpClient, 'disabled') and pnlClient.Enabled then
      Exit;
    if (xeTestSwitches.PumpAction <> '') and not ContainsText(wbCurrentAction + '|' + Caption, xeTestSwitches.PumpAction) then
      Exit;
    TestHost.TestPumpDelivered := True;
    if xeTestSwitches.PumpModal then begin
      for var i := 0 to Pred(Screen.CustomFormCount) do
        if (Screen.CustomForms[i] <> Self) and Screen.CustomForms[i].Visible and (fsModal in Screen.CustomForms[i].FormState) then
          TestHost.TestPumpModalBase := Screen.CustomForms[i];
      var lBase: HWND := 0;
      repeat
        lBase := FindWindowEx(0, lBase, '#32770', nil);
        if (lBase <> 0) and IsWindowVisible(lBase) and (GetWindowThreadProcessId(lBase, nil) = MainThreadID) then
          TestHost.TestPumpLastDialog := lBase;
      until lBase = 0;
    end;
    if Assigned(ActiveRecord) then
      TestHost.TestPumpSeen := ActiveRecord.Name
    else
      TestHost.TestPumpSeen := '-';
    if SameText(xeTestSwitches.Pump, 'cancelctrlo') or SameText(xeTestSwitches.Pump, 'cancelshortcut') then
      if btnCancel.CanFocus then
        btnCancel.SetFocus;
    lFocus := GetFocus;
    TestHost.TestPumpFocus := lFocus;
    lCtrl := FindControl(lFocus);
    if Assigned(lCtrl) then
      lWhere := lCtrl.Name + ' (' + lCtrl.ClassName + ', enabled ' + BoolToStr(IsWindowEnabled(lFocus), True) + ')'
    else
      lWhere := '$' + IntToHex(lFocus, 8);
    var lModalName: string := '-';
    if Assigned(TestHost.TestPumpModalBase) then
      lModalName := TestHost.TestPumpModalBase.ClassName;
    var lDelivery := 'inside a nested pump';
    if xeTestSwitches.PumpDuringLoad <> '' then
      lDelivery := 'while the loader runs'
    else if xeTestSwitches.PumpModal then
      lDelivery := 'inside a modal loop outside any pump';
    TestPumpNote('delivered ' + xeTestSwitches.Pump + ' ' + lDelivery +
      ' during: "' + wbCurrentAction + '", caption "' + Caption +
      '"; client panel enabled ' + BoolToStr(pnlClient.Enabled, True) + '; pump depth ' + IntToStr(NestedPumpDepth) +
      ', lock count ' + IntToStr(ProcessMessagesLockCount) + ', form enabled ' + BoolToStr(Enabled, True) +
      ', window enabled ' + BoolToStr(IsWindowEnabled(Handle), True) + ', modal ' + lModalName + '; focus ' + lWhere +
      '; the View tab shows ' + TestHost.TestPumpSeen +
      IfThen(xeTestSwitches.PumpDuringLoad <> '', '; loader done ' + BoolToStr(xeContext.LoaderDone, True) + ', building references ' +
        BoolToStr(xeContext.BuildingRefsParallel, True) + ', files in the nav tree ' + IntToStr(Length(Files)), ''));
    if SameText(xeTestSwitches.Pump, 'tab') then begin
      if lFocus = 0 then
        lFocus := Handle;
      PostMessage(lFocus, WM_KEYDOWN, VK_TAB, 0);
      PostMessage(lFocus, WM_KEYUP, VK_TAB, LPARAM($C0000000));
    end else if SameText(xeTestSwitches.Pump, 'cancelctrlo') or SameText(xeTestSwitches.Pump, 'cancelshortcut') then begin
      if lFocus = 0 then
        lFocus := Handle;
      TestPumpSetCtrl(True);
      if SameText(xeTestSwitches.Pump, 'cancelctrlo') then begin
        PostMessage(lFocus, WM_KEYDOWN, Ord('O'), 0);
        PostMessage(lFocus, WM_KEYUP, Ord('O'), LPARAM($C0000000));
      end else begin
        PostMessage(lFocus, WM_KEYDOWN, VK_F12, 0);
        PostMessage(lFocus, WM_KEYUP, VK_F12, LPARAM($C0000000));
      end;
    end else if SameText(xeTestSwitches.Pump, 'endsession') then
      TestPumpNote('WM_QUERYENDSESSION answered ' + IntToStr(SendMessage(Handle, WM_QUERYENDSESSION, 0, 0)) +
        '; close deferred ' + BoolToStr(CloseDeferred, True))
    else if SameText(xeTestSwitches.Pump, 'hotkey') then begin
      if not Assigned(ScriptHotkeys) then
        ScriptHotkeys := TStringList.Create;
      ScriptHotkeys.AddObject(xeTestSwitches.PumpHotkey, TObject(ShortCut(VK_F12, [ssCtrl])));
      TestHost.TestPumpShortCut := TAction.Create(Self);
      TestHost.TestPumpShortCut.ActionList := ActionList1;
      TestHost.TestPumpShortCut.ShortCut := ShortCut(VK_F12, [ssCtrl]);
      TestHost.TestPumpShortCut.Tag := ScriptHotkeys.Count;
      TestHost.TestPumpShortCut.OnExecute := acScriptExecute;
      if lFocus = 0 then
        lFocus := Handle;
      TestPumpSetCtrl(True);
      PostMessage(lFocus, WM_KEYDOWN, VK_F12, 0);
      PostMessage(lFocus, WM_KEYUP, VK_F12, LPARAM($C0000000));
    end else if SameText(xeTestSwitches.Pump, 'edidsearch') then begin
      edEditorIDSearch.Text := xeTestSwitches.PumpSearch;
      PostMessage(edEditorIDSearch.Handle, WM_KEYDOWN, VK_RETURN, 0);
      PostMessage(edEditorIDSearch.Handle, WM_KEYUP, VK_RETURN, LPARAM($C0000000));
    end else if SameText(xeTestSwitches.Pump, 'close') then
      PostMessage(Handle, WM_CLOSE, 0, 0)
    else if SameText(xeTestSwitches.Pump, 'ctrlo') then begin
      if lFocus = 0 then
        lFocus := Handle;
      TestPumpSetCtrl(True);
      PostMessage(lFocus, WM_KEYDOWN, Ord('O'), 0);
      PostMessage(lFocus, WM_KEYUP, Ord('O'), LPARAM($C0000000));
    end else if SameText(xeTestSwitches.Pump, 'xback') then
      PostMessage(Handle, WM_XBUTTONUP, MakeWParam(0, 1), 0)
    else if SameText(xeTestSwitches.Pump, 'pendingset') then begin
      PendingContainer := nil;
      PendingMainRecords := [Files[High(Files)].Header];
      tmrPendingSetActive.Enabled := False;
      tmrPendingSetActive.Enabled := True;
    end;
    Exit;
  end;

  if TestHost.TestPumpEnded and (GetTickCount64 > TestHost.TestPumpEndTick) then begin
    TestHost.TestPumpTimer.Enabled := False;
    TestHost.TestPumpWalkStack := nil;
    TestHost.TestPumpWalkPos := nil;
    if xeTestSwitches.PumpDuringLoad <> '' then
      TestPumpNote('after loading: ' + TestPumpRefDigest);
    TestPumpNote('observation ended');
    if xeTestSwitches.PumpDuringLoad <> '' then
      tmrShutdown.Enabled := True;
    Exit;
  end;

  if xeTestSwitches.PumpDuringLoad <> '' then
    lWhere := IfThen(TestPumpInside, 'while the loader runs', 'after the loader')
  else if xeTestSwitches.PumpModal then
    lWhere := IfThen(TestPumpInside, 'inside the modal loop', 'outside any modal loop')
  else
    lWhere := IfThen(TestPumpInside, 'inside the nested pump', 'outside any nested pump');

  if TestHost.TestPumpFocus <> GetFocus then begin
    TestHost.TestPumpFocus := GetFocus;
    lCtrl := FindControl(TestHost.TestPumpFocus);
    if Assigned(lCtrl) then
      TestPumpNote('focus now ' + lCtrl.Name + ' (' + lCtrl.ClassName + ') ' + lWhere)
    else
      TestPumpNote('focus now $' + IntToHex(TestHost.TestPumpFocus, 8) + ' ' + lWhere);
  end;

  if TestPumpInside then
  for var i := 0 to Pred(Screen.CustomFormCount) do
    if (Screen.CustomForms[i] <> Self) and (Screen.CustomForms[i] <> TestHost.TestPumpModalBase) and Screen.CustomForms[i].Visible and
       (fsModal in Screen.CustomForms[i].FormState) and (Screen.CustomForms[i].ModalResult = mrNone) then begin
      if SameText(xeTestSwitches.PumpAnswer, 'yes') then
        Screen.CustomForms[i].ModalResult := mrYes
      else if SameText(xeTestSwitches.PumpAnswer, 'no') then
        Screen.CustomForms[i].ModalResult := mrNo
      else
        Screen.CustomForms[i].ModalResult := mrCancel;
      TestPumpNote('a dialog opened ' + lWhere + ': ' + Screen.CustomForms[i].ClassName + ' "' + Screen.CustomForms[i].Caption +
        '", answered ' + IfThen(xeTestSwitches.PumpAnswer = '', 'cancel', xeTestSwitches.PumpAnswer));
      if TestHost.TestPumpCtrlDown then
        TestPumpSetCtrl(False);
      Break;
    end;

  var lWnd: HWND := 0;
  if TestPumpInside then
  repeat
    lWnd := FindWindowEx(0, lWnd, '#32770', nil);
    if (lWnd <> 0) and IsWindowVisible(lWnd) and IsWindowEnabled(lWnd) and
       (GetWindowThreadProcessId(lWnd, nil) = MainThreadID) then begin
      if lWnd <> TestHost.TestPumpLastDialog then begin
        TestHost.TestPumpLastDialog := lWnd;
        var lCaption: array[0..255] of Char;
        GetWindowText(lWnd, lCaption, Length(lCaption));
        var lText := '';
        var lChild: HWND := 0;
        repeat
          lChild := FindWindowEx(lWnd, lChild, nil, nil);
          if lChild <> 0 then begin
            var lPart: array[0..1023] of Char;
            if GetWindowText(lChild, lPart, Length(lPart)) > 0 then
              lText := lText + ' [' + string(lPart) + ']';
          end;
        until lChild = 0;
        TestPumpNote('a task dialog opened ' + lWhere + ': "' + string(lCaption) + '"' + lText + ', answered ' +
          IfThen(SameText(xeTestSwitches.PumpAnswer, 'yes'), 'yes', 'no'));
        if SameText(xeTestSwitches.PumpAnswer, 'yes') then
          SendMessage(lWnd, WM_USER + 102, IDYES, 0)
        else
          SendMessage(lWnd, WM_USER + 102, IDNO, 0);
      end;
      Break;
    end;
  until lWnd = 0;

  var lBrowsing := (SameText(xeTestSwitches.Pump, 'browse') or SameText(xeTestSwitches.Pump, 'browseclose')) and TestPumpInside;
  if lBrowsing then begin
    if not SameText(xeTestSwitches.Pump, 'browseclose') or (TestHost.TestPumpBrowseCount < 20) then
      TestPumpBrowseStep
    else if Assigned(ActiveRecord) and not TestHost.TestPumpClosePosted then begin
      TestHost.TestPumpClosePosted := True;
      TestPumpNote('closing the editor after browsing ' + IntToStr(TestHost.TestPumpBrowseCount) +
        ' records while the loader runs; the View tab shows ' + ActiveRecord.Name);
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;
  end;
  if SameText(xeTestSwitches.Pump, 'edidwalk') and TestPumpInside then
    TestPumpEdidWalkStep;
  if SameText(xeTestSwitches.Pump, 'initwalk') and TestPumpInside then
    TestPumpInitWalkStep;

  var lShown: string := '-';
  if Assigned(ActiveRecord) then
    lShown := ActiveRecord.Name;
  if not lBrowsing and (lShown <> TestHost.TestPumpSeen) then begin
    TestHost.TestPumpSeen := lShown;
    var lInFile := '';
    if Assigned(ActiveRecord) then
      lInFile := ' (in a file ' + BoolToStr(Assigned(ActiveRecord._File), True) + ')';
    TestPumpNote('the View tab shows ' + TestHost.TestPumpSeen + lInFile + ' ' + lWhere +
      IfThen(TestPumpInside, ', during "' + wbCurrentAction + '"', ''));
  end;

  if not TestPumpInside and not TestHost.TestPumpEnded then begin
    TestHost.TestPumpEnded := True;
    TestHost.TestPumpEndTick := GetTickCount64 + 2000;
    if TestHost.TestPumpCtrlDown then
      TestPumpSetCtrl(False);
    if xeTestSwitches.PumpDuringLoad <> '' then
      TestPumpNote('the loader phase has ended (loader done ' + BoolToStr(xeContext.LoaderDone, True) + '); records browsed ' +
        IntToStr(TestHost.TestPumpBrowseCount) + '; records walked ' + IntToStr(TestHost.TestPumpWalkReads) + ' (' + IntToStr(TestHost.TestPumpWalkChars) +
        ' EditorID characters or elements), faults ' + IntToStr(TestHost.TestPumpWalkFaults) + IfThen(TestHost.TestPumpWalkFirstFault <> '', ', first ' +
        TestHost.TestPumpWalkFirstFault, '') + '; the View tab shows ' + lShown +
        '; close deferred ' + BoolToStr(CloseDeferred, True) + '; observing for 2 s')
    else if xeTestSwitches.PumpModal then
      TestPumpNote('the modal loop has ended; close deferred ' + BoolToStr(CloseDeferred, True) + '; observing for 2 s')
    else
      TestPumpNote('back in the outermost message loop; close deferred ' + BoolToStr(CloseDeferred, True) + '; observing for 2 s');
  end;
end;

procedure TxeTestFormHelper.TestWriteStateManifest(const aTarget: IwbFile);
var
  lLines : TStringList;
begin
  lLines := TStringList.Create;
  try
    WriteStateManifest(lLines, xeContext, ConflictView);
    AddRuntime(lLines, xeContext);
    lLines.Add('runtime.target=' + aTarget.FileName);
    lLines.Add('runtime.version=' + VersionString.ToString);
    lLines.Add('runtime.nexusurl=' + xeNexusModsUrl);
    lLines.Add('runtime.qac.quickclean=' + BoolToStr(xeQuickClean, True));
    lLines.Add('runtime.qac.autosave=' + BoolToStr(xeQuickCleanAutoSave, True));
    lLines.Add('runtime.navsort.infosort=' + BoolToStr(xeContext.Settings.SortINFO and mniNavHeaderINFObyPreviousINFO.Checked, True));
    lLines.SaveToFile(xeTestSwitches.StateManifest, TEncoding.UTF8);
  finally
    lLines.Free;
  end;
end;

procedure TxeTestFormHelper.TestWriteStateManifestEnd;
var
  lLines : TStringList;
begin
  if not FileExists(xeTestSwitches.StateManifest) then
    Exit;
  lLines := TStringList.Create;
  try
    lLines.LoadFromFile(xeTestSwitches.StateManifest, TEncoding.UTF8);
    AddRuntimeEnd(lLines, xeContext);
    lLines.SaveToFile(xeTestSwitches.StateManifest, TEncoding.UTF8);
  finally
    lLines.Free;
  end;
end;

procedure TxeTestFormHelper.TestWriteFileLists;

  function Describe(const aFile: IwbFile): string;
  var
    lStates : string;
  begin
    lStates := '';
    for var lState := Low(TwbFileState) to High(TwbFileState) do
      if lState in aFile.FileStates then begin
        if lStates <> '' then
          lStates := lStates + ',';
        lStates := lStates + GetEnumName(TypeInfo(TwbFileState), Ord(lState));
      end;
    Result := aFile.FileName + ' | lo ' + IntToStr(aFile.LoadOrder) + ' | esm ' + BoolToStr(aFile.IsESM, True) +
      ' | editable ' + BoolToStr(aFile.IsEditable, True) + ' | masters ' + IntToStr(aFile.MasterCount[True]) +
      ' | states [' + lStates + ']';
  end;

var
  lLines   : TStringList;
  lContext : TwbFiles;
  lSame    : Boolean;
begin
  lContext := xeContext.Files;
  lLines := TStringList.Create;
  try
    lLines.Add('toolmode=' + GetEnumName(TypeInfo(TwbToolMode), Ord(xeToolMode)));
    lLines.Add('editor.Count=' + IntToStr(Length(Files)));
    for var i := Low(Files) to High(Files) do
      lLines.Add('editor[' + IntToStr(i) + ']=' + Describe(Files[i]));
    lLines.Add('context.Count=' + IntToStr(Length(lContext)));
    for var i := Low(lContext) to High(lContext) do
      lLines.Add('context[' + IntToStr(i) + ']=' + Describe(lContext[i]));
    lSame := Length(Files) = Length(lContext);
    if lSame then
      for var i := Low(Files) to High(Files) do
        if not Files[i].Equals(lContext[i]) then begin
          lLines.Add('differs at ' + IntToStr(i));
          lSame := False;
        end;
    lLines.Add('same=' + BoolToStr(lSame, True));
    lLines.SaveToFile(xeTestSwitches.FileLists, TEncoding.UTF8);
  finally
    lLines.Free;
  end;
end;

var
  _TestLoaderHoldReleased: THandle;

procedure TxeTestFormHelper.TestLoaderHoldAfterDone;
begin
  if xeTestSwitches.LoaderHold then
    WaitForSingleObject(_TestLoaderHoldReleased, 30000);
end;

procedure TxeTestFormHelper.TestLoaderHoldRelease;
begin
  if xeTestSwitches.LoaderHold then
    SetEvent(_TestLoaderHoldReleased);
end;

initialization
  _TestLoaderHoldReleased := CreateEvent(nil, True, False, nil);
end.
