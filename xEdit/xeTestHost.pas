{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeTestHost;

{$I xeDefines.inc}

interface

uses
  System.Classes,
  System.SysUtils,

  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,

  VirtualTrees.Types,

  Winapi.Windows,

  wbConflict,
  wbInterface;

type
  TxeTestHost = class(TComponent)
  public
    TestNavCopyPhase         : Integer;
    TestNavCopyTimer         : TTimer;
    TestNavCopyAnswer        : TTimer;
    TestNavCopyFileA         : IwbFile;
    TestNavCopyFileB         : IwbFile;
    TestNavCopyFileC         : IwbFile;
    TestNavCopyRecordsA      : TDynMainRecords;
    TestNavCopyRecordsB      : TDynMainRecords;
    TestNavCopyRecordsC      : TDynMainRecords;
    TestNavCopyRows          : TStringList;
    TestNavCopyStale         : Integer;
    TestNavCopyWouldRefresh  : Integer;
    TestNavCopyControlMisses : Integer;
    TestNavCopyStartGiven    : Boolean;
    TestOptionsTimer         : TTimer;
    TestOptionsAnswer        : TTimer;
    TestOptionsToggle        : Boolean;
    TestOptionsShown         : Boolean;
    TestOptionsDialogAlign   : Boolean;
    TestOptionsToggleNeverShow : Boolean;
    TestOptionsDialogNeverShow : Boolean;
    TestOptionsToggleTemplate  : Boolean;
    TestOptionsColourSet       : Boolean;
    TestOptionsColourAll       : TConflictAll;
    TestOptionsColourValue     : TColor;
    TestOptionsCloseTimer      : TTimer;
    TestOptionsClosePosted     : Boolean;
    TestCopyIntoGapTimer     : TTimer;
    TestDropMasterTimer      : TTimer;
    TestDropMasterAnswer     : TTimer;
    TestDropMasterDetach     : IwbElement;
    TestDropMasterSeen       : string;
    TestDeltaPatchLines      : TStringList;
    TestDeltaPatchTimer      : TTimer;
    TestDeltaPatchCancelled  : Boolean;
    TestHideTimer            : TTimer;
    TestMergeLines           : TStringList;
    TestMergeTimer           : TTimer;
    TestMergeAnswer          : TTimer;
    TestMergeTarget          : IwbFile;
    TestMergeNotOffered      : Boolean;
    TestFilterAnswer         : TTimer;
    TestFilterAnswered       : string;
    TestPumpTimer            : TTimer;
    TestPumpDelivered        : Boolean;
    TestPumpEnded            : Boolean;
    TestPumpEndTick          : UInt64;
    TestPumpLastDialog       : HWND;
    TestPumpSeen             : string;
    TestPumpCtrlDown         : Boolean;
    TestPumpModalBase        : TCustomForm;
    TestPumpFocus            : HWND;
    TestPumpShortCut         : TAction;
    TestPumpBrowseNode       : PVirtualNode;
    TestPumpBrowseCount      : Integer;
    TestPumpClosePosted      : Boolean;
    TestPumpWalkFile         : Integer;
    TestPumpWalkIndex        : Integer;
    TestPumpWalkReads        : Int64;
    TestPumpWalkChars        : Int64;
    TestPumpWalkFaults       : Int64;
    TestPumpWalkFirstFault   : string;
    TestPumpWalkStack        : TArray<IwbContainer>;
    TestPumpWalkPos          : TArray<Integer>;
    TestViewModalAnswer      : TTimer;
    TestViewModalFactory     : TFunc<TwbConflictTree>;
    TestViewModalSeen        : string;
    TestViewModalMemo        : string;
    TestViewOptionsFlip      : string;
    TestViewOptionsColor     : TColor;
  end;

  TxeTestSwitches = record
    Conflicts             : Boolean;
    ConflictsFile         : string;
    ConflictsCompareTo    : string;
    ConflictsFieldsFile   : string;
    ConflictsModGroups    : Boolean;
    NavCopy               : Boolean;
    NavCopyFile           : string;
    NavCopyEach           : Boolean;
    NavCopyTwo            : Boolean;
    NavCopySave           : Boolean;
    NavCopyDisk           : Boolean;
    NavCopyNoTouch        : Boolean;
    NavCopyEsm            : Boolean;
    NavCopyInject         : Boolean;
    NavCopyStart          : string;
    NavCopyMaster         : string;
    NavCopyPlugin         : string;
    NavCopyCount          : Integer;
    NavCopyNew            : Boolean;
    NavCopySignature      : string;
    ViewText              : Boolean;
    ViewTextFile          : string;
    ViewTextRecord        : string;
    ViewTree              : Boolean;
    ViewTreeFile          : string;
    ViewTreeList          : string;
    ViewTreeHide          : string;
    ViewTreeHideNoConflict: Boolean;
    ViewTreeLoading       : Boolean;
    ViewTreeReset         : Boolean;
    ViewTreeFocus         : Integer;
    ViewTreeFloor         : Boolean;
    ViewTreeTranslate     : Boolean;
    ViewTreeTime          : Integer;
    ViewTreeHeader        : Boolean;
    ViewTreeModal         : Boolean;
    ViewTreeWalk          : Boolean;
    ViewTreeIdle          : Boolean;
    ViewTreeRemove        : Boolean;
    Options               : Boolean;
    OptionsNav            : string;
    OptionsPath           : string;
    OptionsClose          : Boolean;
    OptionsFile           : string;
    CopyIntoGap           : Boolean;
    CopyIntoGapFile       : string;
    CopyIntoGapRecord     : string;
    CopyIntoGapSource     : string;
    CopyIntoGapOp         : string;
    DropMaster            : Boolean;
    DropMasterFile        : string;
    DropMasterSpec        : string;
    DeltaPatch            : Boolean;
    DeltaPatchFile        : string;
    DeltaPatchMaster      : string;
    DeltaPatchNewer       : string;
    DeltaPatchName        : string;
    DeltaPatchHide        : string;
    DeltaPatchHideRecord  : string;
    DeltaPatchCancel      : Boolean;
    DeltaPatchSave        : string;
    Merge                 : Boolean;
    MergeFile             : string;
    MergeSource           : string;
    MergeTarget           : string;
    MergeOut              : string;
    Hide                  : Boolean;
    HideFile              : string;
    HideRecord            : string;
    HideMaster            : string;
    HideModule            : string;
    Filter                : Boolean;
    FilterFile            : string;
    FilterPreset          : string;
    FilterByValue         : string;
    FilterRemove          : string;
    FilterImages          : Integer;
    Pump                  : string;
    PumpFile              : string;
    PumpAction            : string;
    PumpClient            : string;
    PumpAnswer            : string;
    PumpGenerator         : Boolean;
    PumpDirect            : Boolean;
    PumpModal             : Boolean;
    PumpDuringLoad        : string;
    PumpHotkey            : string;
    PumpSearch            : string;
    SaveContexts          : Boolean;
    SaveContextsFile      : string;
    SaveContextsSave      : string;
    SaveContextsCompare   : string;

    function ParsePump: Boolean;
    function ParseEdit: Boolean;
    function ParseSaveContexts: Boolean;
  end;

var
  xeTestSwitches: TxeTestSwitches;

implementation

uses
  Vcl.Dialogs,

  wbCommandLine,

  xeInit;

function TxeTestSwitches.ParsePump: Boolean;
begin
  Result := True;
  if wbFindCmdLineParam('testpump', Pump) then begin
    wbFindCmdLineParam('testpumpfile', PumpFile);
    wbFindCmdLineParam('testpumpaction', PumpAction);
    wbFindCmdLineParam('testpumpclient', PumpClient);
    wbFindCmdLineParam('testpumpanswer', PumpAnswer);
    PumpGenerator := FindCmdLineSwitch('testpumpgenerator');
    PumpDirect := FindCmdLineSwitch('testpumpdirect');
    PumpModal := FindCmdLineSwitch('testpumpmodal');
    wbFindCmdLineParam('testpumpduringload', PumpDuringLoad);
    wbFindCmdLineParam('testpumphotkey', PumpHotkey);
    wbFindCmdLineParam('testpumpsearch', PumpSearch);
    if (PumpFile = '') or
       not ((PumpAnswer = '') or SameText(PumpAnswer, 'yes') or SameText(PumpAnswer, 'no')) or
       not (SameText(Pump, 'close') or SameText(Pump, 'ctrlo') or SameText(Pump, 'xback') or
            SameText(Pump, 'pendingset') or SameText(Pump, 'tab') or SameText(Pump, 'cancelctrlo') or
            SameText(Pump, 'cancelshortcut') or SameText(Pump, 'endsession') or
            SameText(Pump, 'browse') or SameText(Pump, 'browseclose') or SameText(Pump, 'edidwalk') or
            SameText(Pump, 'initwalk') or SameText(Pump, 'hotkey') or SameText(Pump, 'edidsearch')) or
       not ((PumpClient = '') or SameText(PumpClient, 'enabled') or SameText(PumpClient, 'disabled')) or
       not ((PumpDuringLoad = '') or SameText(PumpDuringLoad, 'any') or SameText(PumpDuringLoad, 'refs')) or
       ((PumpDuringLoad <> '') and (SameText(Pump, 'xback') or SameText(Pump, 'pendingset'))) or
       ((SameText(Pump, 'browse') or SameText(Pump, 'browseclose') or SameText(Pump, 'edidwalk') or
         SameText(Pump, 'initwalk')) and (PumpDuringLoad = '')) or
       (SameText(Pump, 'hotkey') <> (PumpHotkey <> '')) or
       (SameText(Pump, 'edidsearch') <> (PumpSearch <> '')) then begin
      ShowMessage('testpump requires -testpump:<close|ctrlo|xback|pendingset|tab|cancelctrlo|cancelshortcut|endsession|browse|browseclose|edidwalk|initwalk|hotkey|edidsearch> ' +
        '-testpumpfile:<filename> [-testpumpaction:<text in the current action or caption>] [-testpumpclient:<enabled|disabled>] ' +
        '[-testpumpanswer:<yes|no>] [-testpumpgenerator] [-testpumpdirect] [-testpumpmodal] [-testpumpduringload:<any|refs>] ' +
        '[-testpumphotkey:<script file>] [-testpumpsearch:<EditorID>]; browse, browseclose, edidwalk and initwalk only with -testpumpduringload, hotkey only with ' +
        '-testpumphotkey, edidsearch only with -testpumpsearch, ' +
        'xback and pendingset not with -testpumpduringload');
      Exit(False);
    end;
    if xeToolMode = tmLODgen then
      xeAutoLoad := True;
  end;
end;

function TxeTestSwitches.ParseEdit: Boolean;
var
  s: string;
begin
  Result := True;
  if wbFindCmdLineParam('testconflicts', ConflictsFile) then begin
    if ConflictsFile = '' then begin
      ShowMessage('testconflicts requires an output file, as -testconflicts:<filename>');
      Exit(False);
    end;
    Conflicts := True;
    xeAutoLoad      := True;
    wbFindCmdLineParam('comparetofile', ConflictsCompareTo);
    wbFindCmdLineParam('fieldsfile', ConflictsFieldsFile);
    ConflictsModGroups := FindCmdLineSwitch('modgroups');
  end;

  if wbFindCmdLineParam('testnavcopy', NavCopyFile) then begin
    if NavCopyFile = '' then begin
      ShowMessage('testnavcopy requires an output file, as -testnavcopy:<filename>');
      Exit(False);
    end;
    NavCopy := True;
    xeAutoLoad    := True;
    NavCopyEach := FindCmdLineSwitch('testnavcopyeach');
    NavCopyTwo := FindCmdLineSwitch('testnavcopytwo');
    NavCopySave := FindCmdLineSwitch('testnavcopysave');
    NavCopyNoTouch := FindCmdLineSwitch('testnavcopynotouch');
    NavCopyEsm := FindCmdLineSwitch('testnavcopyesm');
    NavCopyDisk := FindCmdLineSwitch('testnavcopydisk');
    NavCopyInject := FindCmdLineSwitch('testnavcopyinject');
    if NavCopySave then
      NavCopyTwo := True;
    var lValue: string;
    if wbFindCmdLineParam('testnavcopystart', lValue) and (lValue <> '') then
      NavCopyStart := lValue;
    if wbFindCmdLineParam('testnavcopymaster', lValue) and (lValue <> '') then
      NavCopyMaster := lValue;
    if wbFindCmdLineParam('testnavcopyplugin', lValue) and (lValue <> '') then
      NavCopyPlugin := lValue;
    if wbFindCmdLineParam('testnavcopycount', lValue) then
      NavCopyCount := StrToIntDef(lValue, NavCopyCount);
    NavCopyNew := FindCmdLineSwitch('testnavcopynew');
    if wbFindCmdLineParam('testnavcopysig', lValue) and (Length(lValue) = 4) then
      NavCopySignature := lValue;
  end;

  if wbFindCmdLineParam('testviewtext', ViewTextFile) then begin
    if ViewTextFile = '' then begin
      ShowMessage('testviewtext requires an output file, as -testviewtext:<filename>');
      Exit(False);
    end;
    ViewText := True;
    xeAutoLoad     := True;
    var lValue: string;
    if wbFindCmdLineParam('testviewrecord', lValue) and (lValue <> '') then
      ViewTextRecord := lValue;
  end;

  if wbFindCmdLineParam('testviewtree', ViewTreeFile) then begin
    if (ViewTreeFile = '') or not wbFindCmdLineParam('testviewrecords', ViewTreeList) or (ViewTreeList = '') then begin
      ShowMessage('testviewtree requires an output file and a record list, as -testviewtree:<filename> -testviewrecords:<filename>');
      Exit(False);
    end;
    ViewTree := True;
    xeAutoLoad     := True;
    wbFindCmdLineParam('testviewtreehide', ViewTreeHide);
    ViewTreeHideNoConflict := FindCmdLineSwitch('testviewtreehidenoconflict');
    ViewTreeLoading := FindCmdLineSwitch('testviewtreeloading');
    ViewTreeReset := FindCmdLineSwitch('testviewtreereset');
    ViewTreeFloor := FindCmdLineSwitch('testviewtreefloor');
    ViewTreeTranslate := FindCmdLineSwitch('testviewtreetranslate');
    ViewTreeHeader := FindCmdLineSwitch('testviewtreeheader');
    ViewTreeModal := FindCmdLineSwitch('testviewtreemodal');
    ViewTreeWalk := FindCmdLineSwitch('testviewtreewalk');
    ViewTreeIdle := FindCmdLineSwitch('testviewtreeidle');
    ViewTreeRemove := FindCmdLineSwitch('testviewtreeremove');
    var lFocus: string;
    if wbFindCmdLineParam('testviewtreefocus', lFocus) then
      ViewTreeFocus := StrToIntDef(lFocus, 0);
    if wbFindCmdLineParam('testviewtreetime', lFocus) then
      ViewTreeTime := StrToIntDef(lFocus, 0);
  end;

  if wbFindCmdLineParam('testoptions', OptionsFile) then begin
    if OptionsFile = '' then begin
      ShowMessage('testoptions requires an output file, as -testoptions:<filename>');
      Exit(False);
    end;
    Options := True;
    wbFindCmdLineParam('testoptionsnav', OptionsNav);
    wbFindCmdLineParam('testoptionspath', OptionsPath);
    OptionsClose := FindCmdLineSwitch('testoptionsclose');
    xeAutoLoad    := True;
  end;

  if wbFindCmdLineParam('testcopyintogap', CopyIntoGapFile) then begin
    if (CopyIntoGapFile = '') or
       not wbFindCmdLineParam('testcopyintogaprecord', CopyIntoGapRecord) or
       not wbFindCmdLineParam('testcopyintogapsource', CopyIntoGapSource) or
       not wbFindCmdLineParam('testcopyintogapop', CopyIntoGapOp) or
       not (SameText(CopyIntoGapOp, 'popup') or SameText(CopyIntoGapOp, 'dragover') or
            SameText(CopyIntoGapOp, 'drop') or SameText(CopyIntoGapOp, 'add')) then begin
      ShowMessage('testcopyintogap requires -testcopyintogap:<filename> -testcopyintogaprecord:<FormID> ' +
        '-testcopyintogapsource:<module> -testcopyintogapop:<popup|dragover|drop|add>');
      Exit(False);
    end;
    CopyIntoGap := True;
    xeAutoLoad        := True;
  end;

  if wbFindCmdLineParam('testdropmaster', DropMasterFile) then begin
    if (DropMasterFile = '') or not wbFindCmdLineParam('testdropmasterspec', DropMasterSpec) then begin
      ShowMessage('testdropmaster requires -testdropmaster:<filename> ' +
        '-testdropmasterspec:<FormID>@<target module>,<FormID>@<source module>,<container>,<plain|modified|detach|mastersonly|unheld>');
      Exit(False);
    end;
    DropMaster := True;
    xeAutoLoad       := True;
  end;

  if wbFindCmdLineParam('testdeltapatch', DeltaPatchFile) then begin
    if (DeltaPatchFile = '') or
       not wbFindCmdLineParam('testdeltapatchmaster', DeltaPatchMaster) or
       not wbFindCmdLineParam('testdeltapatchnewer', DeltaPatchNewer) or
       not wbFindCmdLineParam('testdeltapatchname', DeltaPatchName) then begin
      ShowMessage('testdeltapatch requires -testdeltapatch:<filename> -testdeltapatchmaster:<module> ' +
        '-testdeltapatchnewer:<file> -testdeltapatchname:<name> [-testdeltapatchhide:<module>] [-testdeltapatchhiderec:<formid>] ' +
        '[-testdeltapatchcancel] [-testdeltapatchsave:<file>]');
      Exit(False);
    end;
    wbFindCmdLineParam('testdeltapatchhide', DeltaPatchHide);
    wbFindCmdLineParam('testdeltapatchhiderec', DeltaPatchHideRecord);
    wbFindCmdLineParam('testdeltapatchsave', DeltaPatchSave);
    DeltaPatchCancel := FindCmdLineSwitch('testdeltapatchcancel');
    DeltaPatch := True;
    xeAutoLoad       := True;
  end;

  if wbFindCmdLineParam('testmerge', MergeFile) then begin
    if (MergeFile = '') or
       not wbFindCmdLineParam('testmergesource', MergeSource) or
       not wbFindCmdLineParam('testmergetarget', MergeTarget) or
       not wbFindCmdLineParam('testmergeout', MergeOut) then begin
      ShowMessage('testmerge requires -testmerge:<filename> -testmergesource:<module> -testmergetarget:<module> ' +
        '-testmergeout:<file>');
      Exit(False);
    end;
    Merge := True;
    xeAutoLoad  := True;
  end;

  if wbFindCmdLineParam('testhide', HideFile) then begin
    if (HideFile = '') or
       not wbFindCmdLineParam('testhiderecord', HideRecord) or
       not wbFindCmdLineParam('testhidemaster', HideMaster) or
       not wbFindCmdLineParam('testhidemodule', HideModule) then begin
      ShowMessage('testhide requires -testhide:<filename> -testhiderecord:<formid> -testhidemaster:<module> ' +
        '-testhidemodule:<module>');
      Exit(False);
    end;
    Hide := True;
    xeAutoLoad := True;
  end;

  if wbFindCmdLineParam('testfilter', FilterFile) then begin
    wbFindCmdLineParam('testfilterpreset', FilterPreset);
    wbFindCmdLineParam('testfilterbyvalue', FilterByValue);
    wbFindCmdLineParam('testfilterremove', FilterRemove);
    if wbFindCmdLineParam('testfilterimages', s) then
      FilterImages := StrToIntDef(s, 0);
    if (FilterFile = '') or
       not ((FilterPreset = '') or SameText(FilterPreset, 'cleaning') or SameText(FilterPreset, 'onlyone') or
            SameText(FilterPreset, 'conflicts')) then begin
      ShowMessage('testfilter requires -testfilter:<filename> [-testfilterpreset:<cleaning|onlyone|conflicts>] ' +
        '[-testfilterbyvalue:<text>] [-testfilterremove:<module>]');
      Exit(False);
    end;
    Filter := True;
    xeAutoLoad := True;
  end;
end;

function TxeTestSwitches.ParseSaveContexts: Boolean;
begin
  Result := True;
  if wbFindCmdLineParam('testsavecontexts', SaveContextsFile) then begin
    if (SaveContextsFile = '') or not xeSavesMode or
       not wbFindCmdLineParam('testsavecontextssave', SaveContextsSave) or
       not wbFindCmdLineParam('testsavecontextscompare', SaveContextsCompare) then begin
      ShowMessage('testsavecontexts runs in saves mode and requires -testsavecontexts:<filename> -testsavecontextssave:<save> -testsavecontextscompare:<save>');
      Exit(False);
    end;
    SaveContexts := True;
    xeAutoLoad := True;
    xeAutoExit := True;
  end;
end;

initialization
  xeTestSwitches.NavCopyStart := '000001';
  xeTestSwitches.NavCopyMaster := 'NavCopyA.esp';
  xeTestSwitches.NavCopyPlugin := 'NavCopyB.esp';
  xeTestSwitches.NavCopyCount := 12;
  xeTestSwitches.NavCopySignature := 'QUST';
  xeTestSwitches.ViewTextRecord := '00000007';
end.
