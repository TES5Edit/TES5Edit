{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeChangeNameForm;

{$I xeDefines.inc}

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls,
  VirtualTrees,
  VirtualTrees.BaseTree,
  VirtualTrees.Types,
  wbInterface;

type
  PwbNameChangePlan = ^TwbNameChangePlan;

  TxeChangeNameLabel = record
    Rec      : IwbMainRecord;
    Name     : string;
    FileName : string;
  end;

  TxeChangeNameLabels = record
    Items : TArray<TxeChangeNameLabel>;
    function Find(const aRecord: IwbMainRecord; out aLabel: TxeChangeNameLabel): Boolean;
    function NameOf(const aRecord: IwbMainRecord): string;
    function FileOf(const aRecord: IwbMainRecord): string;
    function Describe(const aRecord: IwbMainRecord): string;
    class function Capture(const aPlan: TwbNameChangePlan): TxeChangeNameLabels; static;
  end;

  TxeChangeNameState = (cnsSelection, cnsBusy, cnsOutcome);

  TxeChangeNameOutcome = (cnoNotApplied, cnoRefused, cnoCompleted, cnoFailed);

  TfrmChangeName = class(TForm)
    lblHeading: TLabel;
    lblFields: TLabel;
    vstFields: TVirtualStringTree;
    mmoText: TMemo;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnApplyClick(Sender: TObject);
    procedure vstFieldsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vstFieldsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstFieldsChecking(Sender: TBaseVirtualTree; Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vstFieldsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstFieldsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstFieldsHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
  private
    fPlan    : PwbNameChangePlan;
    fLabels  : TxeChangeNameLabels;
    fRecheck : TFunc<string>;
    fApply   : TFunc<Boolean>;
    fState   : TxeChangeNameState;
    fOutcome : TxeChangeNameOutcome;
    fRaised  : string;
    fEnded   : string;
    fShown   : TArray<string>;
    function FieldOfNode(aNode: PVirtualNode): Integer;
    function FieldCellText(aField: Integer; aColumn: TColumnIndex): string;
    procedure SetState(aState: TxeChangeNameState);
    procedure ShowLines(const aLines: TArray<string>);
  public
    class function Execute(aOwner: TComponent; aPlan: PwbNameChangePlan; const aLabels: TxeChangeNameLabels;
      const aRecheck: TFunc<string>; const aApply: TFunc<Boolean>; out aRaised, aEnded: string): TxeChangeNameOutcome;
    property State: TxeChangeNameState read fState;
    property ShownLines: TArray<string> read fShown;
  end;

function xeChangeNameHeading(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels): string;
function xeChangeNameForecast(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels): TArray<string>;
function xeChangeNameOutcomeLines(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels; aOutcome: TxeChangeNameOutcome;
  const aRaised: string): TArray<string>;

const
  xeChangeNameFailedText = 'The rename did not complete, and some changes may have been made. It is highly recommended to exit ' +
    'without saving: close xEdit, uncheck every file in "Save changed files:" and choose OK - this discards every unsaved change, ' +
    'other edits included.';

implementation

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Generics.Collections,
  System.Generics.Defaults;

{$R *.dfm}

const
  cColNumber = 0;
  cColRecord = 1;
  cColFile   = 2;
  cColPath   = 3;
  cColValue  = 4;
  cColWill   = 5;

{ TxeChangeNameLabels }

function CompareRecordIDs(const aLeft, aRight: IwbMainRecord): Integer;
begin
  Result := CmpPtr(aLeft.ElementID, aRight.ElementID);
end;

function TxeChangeNameLabels.Find(const aRecord: IwbMainRecord; out aLabel: TxeChangeNameLabel): Boolean;
begin
  aLabel := Default(TxeChangeNameLabel);
  if Assigned(aRecord) then begin
    var lLow := 0;
    var lHigh := High(Items);
    while lLow <= lHigh do begin
      var lMiddle := (lLow + lHigh) shr 1;
      var lOrder := CompareRecordIDs(Items[lMiddle].Rec, aRecord);
      if lOrder < 0 then
        lLow := Succ(lMiddle)
      else if lOrder > 0 then
        lHigh := Pred(lMiddle)
      else begin
        aLabel := Items[lMiddle];
        Exit(True);
      end;
    end;
  end;
  Result := False;
end;

function TxeChangeNameLabels.NameOf(const aRecord: IwbMainRecord): string;
var
  lLabel : TxeChangeNameLabel;
begin
  Find(aRecord, lLabel);
  Result := lLabel.Name;
end;

function TxeChangeNameLabels.FileOf(const aRecord: IwbMainRecord): string;
var
  lLabel : TxeChangeNameLabel;
begin
  Find(aRecord, lLabel);
  Result := lLabel.FileName;
end;

function TxeChangeNameLabels.Describe(const aRecord: IwbMainRecord): string;
var
  lLabel : TxeChangeNameLabel;
begin
  if not Find(aRecord, lLabel) then
    Exit('');
  Result := lLabel.Name;
  if lLabel.FileName <> '' then
    Result := Result + ' in ' + lLabel.FileName;
end;

class function TxeChangeNameLabels.Capture(const aPlan: TwbNameChangePlan): TxeChangeNameLabels;
var
  lRecords : TList<IwbMainRecord>;

  procedure Add(const aRecord: IwbMainRecord);
  begin
    if Assigned(aRecord) then
      lRecords.Add(aRecord);
  end;

begin
  Result := Default(TxeChangeNameLabels);
  lRecords := TList<IwbMainRecord>.Create;
  try
    Add(aPlan.Rec);
    for var lRename in aPlan.Renames do
      Add(lRename.Rec);
    for var lLeft in aPlan.Left do
      Add(lLeft.Rec);
    for var lField in aPlan.Fields do
      Add(lField.Rec);
    for var lValue in aPlan.Values do begin
      Add(lValue.Rec);
      Add(lValue.Target);
      Add(lValue.AfterHit);
      for var lView in lValue.Views do
        Add(lView.Hit);
    end;
    for var lReport in aPlan.Reports do
      Add(lReport.Rec);
    for var lFilter in aPlan.Filters do
      Add(lFilter.Rec);
    lRecords.Sort(TComparer<IwbMainRecord>.Construct(CompareRecordIDs));
    SetLength(Result.Items, lRecords.Count);
    var lCount := 0;
    for var lRecord in lRecords do
      if (lCount = 0) or (CompareRecordIDs(Result.Items[Pred(lCount)].Rec, lRecord) <> 0) then begin
        Result.Items[lCount].Rec := lRecord;
        Result.Items[lCount].Name := lRecord.Name;
        if Assigned(lRecord._File) then
          Result.Items[lCount].FileName := lRecord._File.FileName;
        Inc(lCount);
      end;
    SetLength(Result.Items, lCount);
  finally
    lRecords.Free;
  end;
end;

{ the texts }

function Quoted(const aText: string): string;
begin
  Result := '"' + aText + '"';
end;

function SkipReason(const aPlan: TwbNameChangePlan; aField: Integer): string;
begin
  Result := '';
  case aPlan.FaultOf(aField) of
    ncfNotSelected:
      Result := 'not selected';
    ncfNotEditable, ncfDoesNotFit:
      Result := aPlan.Fields[aField].FaultText;
  end;
end;

function WillText(const aPlan: TwbNameChangePlan; aField: Integer): string;
begin
  if aPlan.OutcomeToBe(aField) = ncoUpdated then
    Result := 'rewritten'
  else
    Result := 'skipped: ' + SkipReason(aPlan, aField);
end;

function IsRenamed(const aPlan: TwbNameChangePlan; const aRecord: IwbMainRecord): Boolean;
begin
  if Assigned(aRecord) then
    for var lRename in aPlan.Renames do
      if Assigned(lRename.Rec) and lRename.Rec.Equals(aRecord) then
        Exit(True);
  Result := False;
end;

function VerdictText(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels; aVerdict: TwbNameVerdict;
  const aTarget: IwbMainRecord; aAfter: Boolean): string;
begin
  var lRenamed := aAfter and IsRenamed(aPlan, aTarget);
  Result := '';
  case aVerdict of
    nvNotJudged:
      Result := 'not judged';
    nvUndecodable:
      Result := 'does not decode';
    nvEmpty:
      Result := 'empty';
    nvSentinel:
      Result := 'names nothing by design';
    nvLink:
      if lRenamed then
        Result := 'links the renamed record ' + aLabels.Describe(aTarget) + ' (then ' + Quoted(aPlan.NewIdentity) + ')'
      else
        Result := 'links ' + aLabels.Describe(aTarget);
    nvWrongType:
      if lRenamed then
        Result := 'names the renamed record ' + aLabels.Describe(aTarget) + ' (then ' + Quoted(aPlan.NewIdentity) + '), of the wrong kind'
      else
        Result := 'names a record of the wrong kind, ' + aLabels.Describe(aTarget);
    nvAmbiguous:
      Result := 'is ambiguous';
    nvNotFound:
      Result := 'names no record';
  end;
end;

function KindText(aKind: TwbNameChangeReportKind): string;
begin
  Result := '';
  case aKind of
    ncpScriptText:  Result := 'script source naming the old identity';
    ncpResultText:  Result := 'result script naming the old identity';
    ncpNotScanned:  Result := 'text that could not be scanned; check it';
    ncpCondition:   Result := 'condition naming the old identity';
    ncpGameSetting: Result := 'game setting naming the old identity';
  end;
end;

function NameOrNone(const aName: string): string;
begin
  if aName = '' then
    Result := '(no derived name)'
  else
    Result := Quoted(aName);
end;

function TextOrNone(const aText: string): string;
begin
  if aText = '' then
    Result := '(nothing)'
  else
    Result := aText;
end;

function xeChangeNameHeading(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels): string;
begin
  Result := Format('Change NAME of %s from %s to %s', [aLabels.Describe(aPlan.Rec), Quoted(aPlan.OldIdentity), Quoted(aPlan.NewIdentity)]);
end;

type
  TLines = record
    Items : TArray<string>;
    Count : Integer;
    procedure Add(const aLine: string);
    procedure AddRange(const aLines: array of string);
    function ToArray: TArray<string>;
  end;

procedure TLines.Add(const aLine: string);
begin
  if Count = Length(Items) then
    SetLength(Items, 2 * Count + 16);
  Items[Count] := aLine;
  Inc(Count);
end;

procedure TLines.AddRange(const aLines: array of string);
begin
  for var lLine in aLines do
    Add(lLine);
end;

function TLines.ToArray: TArray<string>;
begin
  Result := Copy(Items, 0, Count);
end;

procedure AddReports(var aLines: TLines; const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels);
begin
  if Length(aPlan.Reports) = 0 then
    Exit;
  aLines.AddRange(['', 'Places the plan found to inspect (none proves an edit is needed):']);
  for var lReport in aPlan.Reports do
    aLines.Add(Format('  %s: %s, %s', [KindText(lReport.Kind), aLabels.Describe(lReport.Rec), lReport.Path]));
end;

function xeChangeNameForecast(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels): TArray<string>;
var
  lTarget : IwbMainRecord;
  lLines  : TLines;
begin
  var lRewritten := 0;
  var lSkipped := 0;
  for var i := 0 to High(aPlan.Fields) do
    if aPlan.OutcomeToBe(i) = ncoUpdated then
      Inc(lRewritten)
    else
      Inc(lSkipped);
  var lChanged := aPlan.ChangedValues;
  var lPairs := aPlan.CellPairs;
  var lMoves := aPlan.FilterMoves;
  lLines := Default(TLines);
  lLines.Add(Format('Records renamed: %d; records left: %d; fields rewritten: %d, skipped: %d; values that change: %d; ' +
    'derived names: %d; cell filters that change: %d; places to inspect: %d',
    [Length(aPlan.Renames), Length(aPlan.Left), lRewritten, lSkipped, Length(lChanged), Length(lPairs), Length(lMoves),
     Length(aPlan.Reports)]));
  if lRewritten = 0 then
    lLines.Add('The rename touches no field; Apply still renames the records below.');

  lLines.AddRange(['', 'Records renamed:']);
  for var lRename in aPlan.Renames do
    lLines.Add('  ' + aLabels.Describe(lRename.Rec));
  if Length(aPlan.Left) > 0 then begin
    lLines.AddRange(['', 'Records left as they are:']);
    for var lLeft in aPlan.Left do
      lLines.Add(Format('  %s: %s', [aLabels.Describe(lLeft.Rec), lLeft.Reason]));
  end;
  if Length(aPlan.Fields) > 0 then begin
    lLines.AddRange(['', 'Fields:']);
    for var i := 0 to High(aPlan.Fields) do
      lLines.Add(Format('  #%d %s, %s, %s: %s', [Succ(i), aLabels.Describe(aPlan.Fields[i].Rec), aPlan.Fields[i].Path,
        Quoted(aPlan.Fields[i].Value), WillText(aPlan, i)]));
  end;
  if Length(lChanged) > 0 then begin
    lLines.AddRange(['', 'Values whose meaning changes:']);
    for var lIndex in lChanged do begin
      var lValue := aPlan.Values[lIndex];
      var lAfter := aPlan.VerdictAfter(lIndex, lTarget);
      var lText := lValue.Value;
      if (lValue.Field >= 0) and (aPlan.OutcomeToBe(lValue.Field) = ncoUpdated) then
        lText := aPlan.NewIdentity;
      lLines.Add(Format('  %s, %s, %s: before %s, after %s', [aLabels.Describe(lValue.Rec), lValue.Path, Quoted(lText),
        VerdictText(aPlan, aLabels, lValue.Verdict, lValue.Target, False), VerdictText(aPlan, aLabels, lAfter, lTarget, True)]));
      var lDerivedAfter := aPlan.DerivedAfter(lIndex);
      if lValue.Derived or lDerivedAfter then
        lLines.Add(Format('    names an exterior cell: %s before, %s after', [BoolToStr(lValue.Derived, True),
          BoolToStr(lDerivedAfter, True)]));
      var lBefore := aPlan.ReportBefore(lIndex);
      var lReportAfter := aPlan.ReportAfter(lIndex);
      if (lBefore <> '') or (lReportAfter <> '') then
        lLines.Add(Format('    check before: %s; after: %s', [TextOrNone(lBefore), TextOrNone(lReportAfter)]));
    end;
  end;
  if Length(lPairs) > 0 then begin
    lLines.AddRange(['', 'Derived names:']);
    for var lPair in lPairs do
      lLines.Add(Format('  %s -> %s', [NameOrNone(lPair.Before), NameOrNone(lPair.After)]));
  end;
  if Length(lMoves) > 0 then begin
    lLines.AddRange(['', 'Cell filters whose answer changes (the test is about the name, not the whole response):']);
    for var lMove in lMoves do begin
      var lFilter := aPlan.Filters[lMove.Filter];
      var lRoute := 'Speaker Cell';
      if lFilter.Route = nfrNotCell then
        lRoute := 'Not Cell';
      var lHow := Format('%s %s matches the name as a prefix: %s before, %s after', [lRoute, Quoted(lFilter.Text),
        BoolToStr(lMove.WasPrefix, True), BoolToStr(not lMove.WasPrefix, True)]);
      if lFilter.Route = nfrNotCell then
        lHow := lHow + Format('; the condition holds: %s before, %s after', [BoolToStr(not lMove.WasPrefix, True),
          BoolToStr(lMove.WasPrefix, True)]);
      lLines.Add(Format('  %s, %s: %s -> %s; %s', [aLabels.Describe(lFilter.Rec), lFilter.Path,
        NameOrNone(lMove.Names.Before), NameOrNone(lMove.Names.After), lHow]));
    end;
  end;
  AddReports(lLines, aPlan, aLabels);
  Result := lLines.ToArray;
end;

function OutcomeText(aOutcome: TwbNameChangeOutcome; const aMessage: string; aFailed: Boolean): string;
begin
  case aOutcome of
    ncoUpdated:
      Result := 'updated';
    ncoSkipped:
      Result := 'skipped: ' + aMessage;
    ncoFailed:
      Result := 'failed, may hold a partial write: ' + aMessage;
  else
    if aMessage <> '' then
      Result := 'stopped: ' + aMessage
    else if aFailed then
      Result := 'not reported by the apply'
    else
      Result := 'not done';
  end;
end;

function FieldOutcomeText(const aPlan: TwbNameChangePlan; aField: Integer; aFailed: Boolean): string;
begin
  var lMessage := aPlan.Fields[aField].Message;
  if (aPlan.Fields[aField].Outcome = ncoSkipped) and (lMessage = '') then
    lMessage := SkipReason(aPlan, aField);
  Result := OutcomeText(aPlan.Fields[aField].Outcome, lMessage, aFailed);
end;

function xeChangeNameOutcomeLines(const aPlan: TwbNameChangePlan; const aLabels: TxeChangeNameLabels; aOutcome: TxeChangeNameOutcome;
  const aRaised: string): TArray<string>;
var
  lLines : TLines;
begin
  lLines := Default(TLines);
  case aOutcome of
    cnoRefused:
      lLines.AddRange(['Change NAME was refused before any write: ' + aPlan.StaleText, 'No record or field was written. ' +
        'Close and run Change NAME again to see a fresh plan.']);
    cnoCompleted:
      lLines.Add('Change NAME completed: ' + xeChangeNameHeading(aPlan, aLabels));
    cnoFailed:
      lLines.Add(xeChangeNameFailedText);
  else
    lLines.Add('Change NAME was not applied.');
  end;
  if aOutcome in [cnoCompleted, cnoFailed] then begin
    for var lRename in aPlan.Renames do
      lLines.Add(Format('  rename %s: %s', [aLabels.Describe(lRename.Rec), OutcomeText(lRename.Outcome, lRename.Message,
        aOutcome = cnoFailed)]));
    for var lLeft in aPlan.Left do
      lLines.Add(Format('  left %s: %s', [aLabels.Describe(lLeft.Rec), lLeft.Reason]));
    for var i := 0 to High(aPlan.Fields) do
      lLines.Add(Format('  field #%d %s, %s: %s', [Succ(i), aLabels.Describe(aPlan.Fields[i].Rec), aPlan.Fields[i].Path,
        FieldOutcomeText(aPlan, i, aOutcome = cnoFailed)]));
    if aRaised <> '' then
      lLines.Add('  the apply raised: ' + aRaised);
  end;
  AddReports(lLines, aPlan, aLabels);
  Result := lLines.ToArray;
end;

{ TfrmChangeName }

class function TfrmChangeName.Execute(aOwner: TComponent; aPlan: PwbNameChangePlan; const aLabels: TxeChangeNameLabels;
  const aRecheck: TFunc<string>; const aApply: TFunc<Boolean>; out aRaised, aEnded: string): TxeChangeNameOutcome;
begin
  var lForm := TfrmChangeName.Create(aOwner);
  try
    lForm.fPlan := aPlan;
    lForm.fLabels := aLabels;
    lForm.fRecheck := aRecheck;
    lForm.fApply := aApply;
    lForm.fOutcome := cnoNotApplied;
    lForm.lblHeading.Caption := xeChangeNameHeading(aPlan^, aLabels);
    lForm.vstFields.NodeDataSize := SizeOf(Integer);
    lForm.vstFields.BeginUpdate;
    try
      for var i := 0 to High(aPlan.Fields) do
        PInteger(lForm.vstFields.GetNodeData(lForm.vstFields.AddChild(nil)))^ := i;
    finally
      lForm.vstFields.EndUpdate;
    end;
    lForm.SetState(cnsSelection);
    lForm.ShowModal;
    aRaised := lForm.fRaised;
    aEnded := lForm.fEnded;
    Result := lForm.fOutcome;
  finally
    lForm.Free;
  end;
end;

procedure TfrmChangeName.ShowLines(const aLines: TArray<string>);
begin
  fShown := aLines;
  mmoText.HandleNeeded;
  mmoText.Text := string.Join(sLineBreak, aLines);
  mmoText.SelStart := 0;
  mmoText.Refresh;
  vstFields.Invalidate;
end;

procedure TfrmChangeName.SetState(aState: TxeChangeNameState);
begin
  fState := aState;
  case aState of
    cnsSelection: begin
      btnApply.Visible := True;
      btnApply.Enabled := True;
      btnCancel.Caption := 'Cancel';
      btnCancel.Enabled := True;
      vstFields.Enabled := True;
      ShowLines(xeChangeNameForecast(fPlan^, fLabels));
    end;
    cnsBusy: begin
      btnApply.Enabled := False;
      btnCancel.Enabled := False;
      vstFields.Enabled := False;
      ShowLines(['Applying the rename...']);
    end;
    cnsOutcome: begin
      btnApply.Visible := False;
      btnCancel.Caption := 'Close';
      btnCancel.Enabled := True;
      vstFields.Enabled := False;
      vstFields.Invalidate;
    end;
  end;
end;

procedure TfrmChangeName.btnApplyClick(Sender: TObject);
begin
  if fState <> cnsSelection then
    Exit;
  var lChanged := fRecheck();
  if lChanged <> '' then begin
    fEnded := lChanged;
    ModalResult := mrAbort;
    Exit;
  end;
  SetState(cnsBusy);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
  var lApplied := False;
  var lRaised := False;
  fRaised := '';
  try
    lApplied := fApply();
  except
    on E: Exception do begin
      lRaised := True;
      fRaised := E.Message;
      if fRaised = '' then
        fRaised := E.ClassName;
    end;
  end;
  if lRaised or fPlan.AnyFailed then
    fOutcome := cnoFailed
  else if not lApplied then
    fOutcome := cnoRefused
  else
    fOutcome := cnoCompleted;
  try
    var lShown := xeChangeNameOutcomeLines(fPlan^, fLabels, fOutcome, fRaised);
    if fOutcome = cnoCompleted then
      lShown := lShown + ['', 'Close returns to the editor and adds the text above to the Messages tab.'];
    ShowLines(lShown);
  finally
    var lQueued: TMsg;
    while PeekMessage(lQueued, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE) do ;
    while PeekMessage(lQueued, 0, WM_MOUSEFIRST, WM_MOUSELAST, PM_REMOVE) do ;
    while PeekMessage(lQueued, 0, WM_NCMOUSEMOVE, WM_NCXBUTTONDBLCLK, PM_REMOVE) do ;
    while PeekMessage(lQueued, Handle, WM_CLOSE, WM_CLOSE, PM_REMOVE) do ;
    while PeekMessage(lQueued, Handle, WM_SYSCOMMAND, WM_SYSCOMMAND, PM_REMOVE) do ;
    ModalResult := mrNone;
    SetState(cnsOutcome);
  end;
end;

procedure TfrmChangeName.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fState <> cnsBusy;
end;

function TfrmChangeName.FieldOfNode(aNode: PVirtualNode): Integer;
begin
  Result := -1;
  if Assigned(aNode) then begin
    var lData := PInteger(vstFields.GetNodeData(aNode));
    if Assigned(lData) then
      Result := lData^;
  end;
end;

function TfrmChangeName.FieldCellText(aField: Integer; aColumn: TColumnIndex): string;
begin
  Result := '';
  if (aField < 0) or (aField > High(fPlan.Fields)) then
    Exit;
  case aColumn of
    cColNumber: Result := IntToStr(Succ(aField));
    cColRecord: Result := fLabels.NameOf(fPlan.Fields[aField].Rec);
    cColFile:   Result := fLabels.FileOf(fPlan.Fields[aField].Rec);
    cColPath:   Result := fPlan.Fields[aField].Path;
    cColValue:  Result := fPlan.Fields[aField].Value;
    cColWill:   if fState = cnsOutcome then
                  Result := FieldOutcomeText(fPlan^, aField, fOutcome = cnoFailed)
                else
                  Result := WillText(fPlan^, aField);
  end;
end;

procedure TfrmChangeName.vstFieldsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
begin
  CellText := FieldCellText(FieldOfNode(Node), Column);
end;

procedure TfrmChangeName.vstFieldsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  Node.CheckType := ctCheckBox;
  var lField := FieldOfNode(Node);
  if lField < 0 then
    Exit;
  if fPlan.Fields[lField].Fault <> ncfNone then begin
    Node.CheckState := csUncheckedNormal;
    Sender.IsDisabled[Node] := True;
  end else if fPlan.Fields[lField].Selected then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUncheckedNormal;
end;

procedure TfrmChangeName.vstFieldsChecking(Sender: TBaseVirtualTree; Node: PVirtualNode; var NewState: TCheckState;
  var Allowed: Boolean);
begin
  var lField := FieldOfNode(Node);
  Allowed := (fState = cnsSelection) and (lField >= 0) and (fPlan.Fields[lField].Fault = ncfNone);
end;

procedure TfrmChangeName.vstFieldsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if fState <> cnsSelection then
    Exit;
  var lField := FieldOfNode(Node);
  if (lField < 0) or (fPlan.Fields[lField].Fault <> ncfNone) then
    Exit;
  fPlan.Fields[lField].Selected := Node.CheckState = csCheckedNormal;
  ShowLines(xeChangeNameForecast(fPlan^, fLabels));
end;

procedure TfrmChangeName.vstFieldsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
begin
  var lLeft := FieldOfNode(Node1);
  var lRight := FieldOfNode(Node2);
  Result := 0;
  if Column <> cColNumber then
    Result := CompareText(FieldCellText(lLeft, Column), FieldCellText(lRight, Column));
  if Result = 0 then
    Result := lLeft - lRight;
end;

procedure TfrmChangeName.vstFieldsHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  if (HitInfo.Button <> TMouseButton.mbLeft) or (HitInfo.Column < 0) then
    Exit;
  if Sender.SortColumn = HitInfo.Column then begin
    if Sender.SortDirection = sdAscending then
      Sender.SortDirection := sdDescending
    else
      Sender.SortDirection := sdAscending;
  end else begin
    Sender.SortColumn := HitInfo.Column;
    Sender.SortDirection := sdAscending;
  end;
  vstFields.SortTree(Sender.SortColumn, Sender.SortDirection);
end;

end.
