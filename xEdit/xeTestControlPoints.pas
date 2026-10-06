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
    procedure TestDeltaPatchStates(const aWhen: string);
    procedure TestDeltaPatchWrite;
    procedure TestDeltaPatchCancelTimer(Sender: TObject);
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
    procedure DoTestDropMaster;
    procedure DoTestDeltaPatchStart;
    procedure DoTestDeltaPatchReport;
    procedure DoTestMerge;
    procedure DoTestHide;
    procedure DoTestFilter;
    procedure TestFilterImages(aLines: TStrings);
    procedure DoTestSaveContextsCompare;
  end;

procedure TestSaveContextsReport(const aStage: string);

implementation

uses
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

  Vcl.ClipBrd,
  Vcl.Styles,
  Vcl.Styles.Utils.SystemMenu,
  Vcl.Themes,

  Winapi.CommCtrl,
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
    lRecordA := wbCopyElementToFile(lSource, TestHost.TestNavCopyFileA, True, True, '', '', '', '', False) as IwbMainRecord;
    if not Assigned(lRecordA) then
      Continue;
    lRecordB := wbCopyElementToFile(lRecordA, TestHost.TestNavCopyFileB, False, True, '', '', '', '', False) as IwbMainRecord;
    if not Assigned(lRecordB) then
      raise Exception.Create('no override of ' + lRecordA.Name + ' was created');
    lRecordB.ElementEditValues['FULL'] := lRecordB.ElementEditValues['FULL'] + ' (B)';
    if Assigned(lRecordB.ElementByPath['DATA - General\Priority']) then
      lRecordB.ElementNativeValues['DATA - General\Priority'] := (Integer(lRecordB.ElementNativeValues['DATA - General\Priority']) + 1) and $FF;
    if xeTestSwitches.NavCopyTwo then
      lRecordC := lRecordB
    else begin
      lRecordC := wbCopyElementToFile(lRecordA, TestHost.TestNavCopyFileC, False, True, '', '', '', '', False) as IwbMainRecord;
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
      lRecord := wbCopyElementToFile(lSource, lFile, False, True, '', '', '', '', False) as IwbMainRecord;
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
  for var i := Low(Files) to High(Files) do
    if SameText(Files[i].FileName, xeTestSwitches.DeltaPatchMaster) then
      lRecord := Files[i].RecordByFormID[TwbFormID.FromStr(xeTestSwitches.DeltaPatchHideRecord), True, True];
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
    if xeAutoExit then
      tmrShutdown.Enabled := True;
  end;
end;

procedure TxeTestFormHelper.DoTestDeltaPatchStart;
var
  lMaster : IwbFile;
  lRecord : IwbMainRecord;
  lTarget : string;
begin
  xeContext.Settings.DontSave := True;
  EditWarnOk := True;
  CheckResult := 2;
  TestHost.TestDeltaPatchLines := TStringList.Create;
  TestHost.TestDeltaPatchLines.Add('# xEdit delta patch probe');
  TestHost.TestDeltaPatchLines.Add('# ' + xeApplicationTitle);
  TestHost.TestDeltaPatchLines.Add('# master = ' + xeTestSwitches.DeltaPatchMaster + ', newer = ' + xeTestSwitches.DeltaPatchNewer +
    ', name = ' + xeTestSwitches.DeltaPatchName + ', hide = ' + xeTestSwitches.DeltaPatchHide + ', hide record = ' + xeTestSwitches.DeltaPatchHideRecord);
  TestHost.TestDeltaPatchLines.Add('# Columns, tab separated: what / when / name / states');
  try
    lMaster := nil;
    for var i := Low(Files) to High(Files) do
      if SameText(Files[i].FileName, xeTestSwitches.DeltaPatchMaster) then
        lMaster := Files[i];
    if not Assigned(lMaster) then
      raise Exception.Create('no module ' + xeTestSwitches.DeltaPatchMaster);
    TestDeltaPatchStates('loaded');
    if xeTestSwitches.DeltaPatchHide <> '' then
      for var i := Low(Files) to High(Files) do
        if SameText(Files[i].FileName, xeTestSwitches.DeltaPatchHide) then
          ConflictView.Hidden.Hide(Files[i]);
    if xeTestSwitches.DeltaPatchHideRecord <> '' then begin
      lRecord := lMaster.RecordByFormID[TwbFormID.FromStr(xeTestSwitches.DeltaPatchHideRecord), True, True];
      if not Assigned(lRecord) then
        raise Exception.Create('no record ' + xeTestSwitches.DeltaPatchHideRecord + ' in ' + xeTestSwitches.DeltaPatchMaster);
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
    TLoaderThread.Create(lTarget, lMaster, [fsIsDeltaPatch]);
    if xeTestSwitches.DeltaPatchCancel then begin
      TestHost.TestDeltaPatchTimer := TTimer.Create(Self);
      TestHost.TestDeltaPatchTimer.Interval := 50;
      TestHost.TestDeltaPatchTimer.OnTimer := TestDeltaPatchCancelTimer;
      TestHost.TestDeltaPatchTimer.Enabled := True;
    end;
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
  try
    if xeContext.LoaderError then
      raise Exception.Create('the delta patch load failed');
    TestDeltaPatchStates('after');
    var lFound := False;
    for var i := Low(Files) to High(Files) do
      if fsIsDeltaPatch in Files[i].FileStates then begin
        lFound := True;
        TestHost.TestDeltaPatchLines.Add('patch' + #9 + Files[i].FileName + #9 + 'records ' + IntToStr(Files[i].RecordCount));
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

end.
