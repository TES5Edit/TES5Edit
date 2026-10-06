unit wbConflict;

interface

uses
  System.Generics.Collections,
  wbHash,
  wbInterface;

type
  TwbConflictEntry = record
    Stamp        : Cardinal;
    Epoch        : Cardinal;
    ConflictAll  : TConflictAll;
    ConflictThis : TConflictThis;
  end;

  TwbConflictTree = class;

  TwbConflictView = class
  private
    cvContextRef         : IwbGameContext;
    cvTrees              : TList<TwbConflictTree>;
    cvQuickShowConflicts : Boolean;
    cvOnlyMasterAndLeafs : Boolean;
    cvModGroupsEnabled   : Boolean;
    cvAlignArrayElements : Boolean;
    cvAlignArrayLimit    : Integer;
    cvModGroupTargets    : TDictionary<PwbModuleInfo, TwbModuleInfos>;
    cvHidden             : TwbHiddenSet;
    cvEpoch              : Cardinal;
    cvRulesGeneration    : Cardinal;
    procedure FollowContextRules; inline;
    function GetEpoch: Cardinal;
    procedure SetQuickShowConflicts(aValue: Boolean);
    procedure SetOnlyMasterAndLeafs(aValue: Boolean);
    procedure SetModGroupsEnabled(aValue: Boolean);
    procedure SetAlignArrayElements(aValue: Boolean);
    procedure SetAlignArrayLimit(aValue: Integer);
    function Lookup(const aRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis): Boolean;
    procedure Store(const aRecord: IwbMainRecord; aConflictAll: TConflictAll; aConflictThis: TConflictThis);
  protected
    cvEntries            : TArray<TwbConflictEntry>;
  public
    Context : TwbGameContext;
    Hits    : Int64;
    Misses  : Int64;
    constructor Create(aContext: TwbGameContext);
    destructor Destroy; override; final;
    procedure RulesChanged;
    procedure Peek(const aRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
    function NodeDatasForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles): TwbDynConflictNodeDatas;
    procedure LevelForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles; const aOnMessage: TwbConflictMessageProc; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
    function ModGroupTargets(aModule: PwbModuleInfo): TwbModuleInfos;
    procedure SetModGroupTargets(aTargets: TDictionary<PwbModuleInfo, TwbModuleInfos>); overload;
    procedure SetModGroupTargets(aFrom: TwbConflictView); overload;
    property QuickShowConflicts: Boolean read cvQuickShowConflicts write SetQuickShowConflicts;
    property OnlyMasterAndLeafs: Boolean read cvOnlyMasterAndLeafs write SetOnlyMasterAndLeafs;
    property ModGroupsEnabled: Boolean read cvModGroupsEnabled write SetModGroupsEnabled;
    property AlignArrayElements: Boolean read cvAlignArrayElements write SetAlignArrayElements;
    property AlignArrayLimit: Integer read cvAlignArrayLimit write SetAlignArrayLimit;
    property Hidden: TwbHiddenSet read cvHidden;
    property Epoch: Cardinal read GetEpoch;
  end;

  TwbConflictTreeNode = class
  private
    tnTree     : TwbConflictTree;
    tnParent   : TwbConflictTreeNode;
    tnIndex    : Integer;
    tnDatas    : TwbDynConflictNodeDatas;
    tnStates   : TwbConflictNodeStates;
    tnChildren : TArray<TwbConflictTreeNode>;
    tnCounted  : Boolean;
    tnVisible  : Boolean;
    function GetChildCount: Integer;
    function GetChild(aIndex: Integer): TwbConflictTreeNode;
  public
    destructor Destroy; override; final;
    function RowElement(aColumn, aRow: Integer): IwbElement;
    function IsAlignedGap(aColumn, aRow: Integer; out aMemoryIndex: Integer): Boolean;
    function CanAssignAligned(aColumn, aRow: Integer; const aSource: IwbElement; aCheckDontShow: Boolean): Boolean;
    function AssignAligned(aColumn, aRow: Integer; const aSource: IwbElement; aOnlySK: Boolean): IwbElement;
    function AddTarget(aColumn: Integer; out aRow: Integer): TwbConflictTreeNode;
    property Tree: TwbConflictTree read tnTree;
    property Parent: TwbConflictTreeNode read tnParent;
    property Index: Integer read tnIndex;
    property Datas: TwbDynConflictNodeDatas read tnDatas;
    property States: TwbConflictNodeStates read tnStates;
    property Visible: Boolean read tnVisible;
    property ChildCount: Integer read GetChildCount;
    property Children[aIndex: Integer]: TwbConflictTreeNode read GetChild;
  end;

  TwbConflictTree = class
  private
    ctView           : TwbConflictView;
    ctContextRef     : IwbGameContext;
    ctEpoch          : Cardinal;
    ctStamps         : TArray<Cardinal>;
    ctFileCount      : Integer;
    ctSiblingCompare : Boolean;
    ctInjected       : Boolean;
    ctRootCount      : Integer;
    ctOnMessage      : TwbConflictMessageProc;
    ctRoot           : TwbConflictTreeNode;
    ctHideNoConflict : Boolean;
    ctUndefinedChain : Boolean;
    ctFiles          : TwbFiles;
    procedure Setup(aView: TwbConflictView; const aRootDatas: TwbDynConflictNodeDatas; aSiblingCompare, aInjected: Boolean;
      aRootCount: Integer; const aOnMessage: TwbConflictMessageProc);
    procedure SettleDenseIDs(aView: TwbConflictView; const aRootDatas: TwbDynConflictNodeDatas);
    procedure ResolveNode(aNode: TwbConflictTreeNode);
    procedure ResolveUndefinedChain;
  public
    constructor CreateForMainRecord(aView: TwbConflictView; const aMainRecord: IwbMainRecord; const aFiles: TwbFiles;
      const aOnMessage: TwbConflictMessageProc);
    constructor CreateForRecords(aView: TwbConflictView; const aRecords: TDynMainRecords;
      const aOnMessage: TwbConflictMessageProc);
    constructor CreateForElement(aView: TwbConflictView; const aElement: IwbElement;
      const aOnMessage: TwbConflictMessageProc);
    constructor CreateForContainer(aView: TwbConflictView; const aContainer: IwbDataContainer; const aFiles: TwbFiles;
      const aOnMessage: TwbConflictMessageProc);
    destructor Destroy; override; final;
    function IsStale: Boolean;
    procedure Resolve(aHideNoConflict: Boolean = False);
    function NodeFor(const aElement: IwbElement; out aColumn: Integer): TwbConflictTreeNode;
    property View: TwbConflictView read ctView;
    property Root: TwbConflictTreeNode read ctRoot;
    property SiblingCompare: Boolean read ctSiblingCompare;
    property Injected: Boolean read ctInjected;
  end;

  TwbDeltaPatchCounts = record
    Copied     : Integer;
    Processed  : Integer;
    Candidates : Integer;
    Removed    : Integer;
    CantRemove : Integer;
  end;

  TwbCleanAction = (
    qcKeep,
    qcCantRemove,
    qcMakePartial,
    qcRemove
  );

  TwbDirtyInfo = record
    Plugin : string;
    CRC32  : TwbCRC32;
    ITM    : Integer;
    UDR    : Integer;
    NAV    : Integer;
    function LOOTEntry(aFileChanged: Boolean; const aAppName, aVersion, aNexusModsUrl: string): string;
    function BOSSEntry(const aAppName: string): string;
  end;
  PwbDirtyInfo = ^TwbDirtyInfo;
  TwbDirtyInfos = TArray<TwbDirtyInfo>;

  TwbCleanCounts = record
    FilterVisited     : Cardinal;
    FilterRemaining   : Cardinal;
    UndeleteProcessed : Cardinal;
    Undeleted         : Cardinal;
    DeletedNavMeshes  : Cardinal;
    NotUndeletable    : Cardinal;
    RemoveProcessed   : Cardinal;
    Removed           : Cardinal;
  end;

  TwbQuickClean = class
  private
    qcFile       : IwbFile;
    qcContext    : TwbGameContext;
    qcView       : TwbConflictView;
    qcOnMessage  : TwbConflictMessageProc;
    qcOnProgress : TwbConflictMessageProc;
    qcTree       : TObject;
    qcCounts     : TwbCleanCounts;
    qcDirtyInfos : TwbDirtyInfos;
    procedure Post(const aText: string);
    procedure Progress(const aText: string);
  protected
    function IsUnsaved: Boolean; virtual;
    function Save: Boolean; virtual; abstract;
    procedure Reset; virtual;
    procedure ReportDirtyInfo; virtual;
  public
    CountOnly : Boolean;
    constructor Create(const aFile: IwbFile; aView: TwbConflictView; const aOnMessage, aOnProgress: TwbConflictMessageProc);
    destructor Destroy; override; final;
    procedure Filter; virtual;
    procedure Undelete; virtual;
    procedure RemoveIdentical; virtual;
    function Run: Boolean;
    property Counts: TwbCleanCounts read qcCounts;
    property DirtyInfos: TwbDirtyInfos read qcDirtyInfos;
  end;

function wbConflictCellElement(const aParentData: TwbConflictNodeData; aIndex: Cardinal): IwbElement;

function wbConflictLevelForNodeDatas(const aNodeDatas: PwbConflictNodeDatas; aNodeCount: Integer; aSiblingCompare, aInjected: Boolean): TConflictAll;

procedure wbConflictInitNodes(const aNodeDatas: PwbConflictNodeDatas;
  const aParentDatas: PwbConflictNodeDatas;
  aNodeCount: Integer;
  aIndex: Cardinal;
  var aStates: TwbConflictNodeStates;
  const aOnElement: TwbConflictElementProc);

procedure wbConflictInitChildren(const aNodeDatas: PwbConflictNodeDatas; aNodeCount: Integer;
  var aChildCount: Cardinal; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc);

function wbConflictAlignedGap(const aParentData: TwbConflictNodeData; aRow: Integer; out aMemoryIndex: Integer): Boolean;

function wbConflictAssignAligned(const aContainer: IwbContainerElementRef; aIndex, aMemoryIndex: Integer; const aSource: IwbElement; aOnlySK: Boolean): IwbElement;

function wbConflictLevelForChildNodeDatas(const aNodeDatas: TwbDynConflictNodeDatas; aSiblingCompare, aInjected: Boolean; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc; const aOnField: TwbFieldConflictProc = nil): TConflictAll;

function wbConflictNodeDatasForContainer(const aContainer: IwbDataContainer; const aFiles: TwbFiles): TwbDynConflictNodeDatas;

function wbConflictMakeDeltaPatch(const aOld, aNew: IwbFile; aTemplate: TwbConflictView; const aOnMessage: TwbConflictMessageProc): TwbDeltaPatchCounts;

function wbCleanDecide(const aElement: IwbElement; aThis, aOrgThis: TConflictThis; aLiveChildren: Integer; aAllowMakePartial: Boolean): TwbCleanAction;
procedure wbCleanApply(aAction: TwbCleanAction; const aElement: IwbElement; const aContainer: IwbContainer);

function wbDirtyInfoFor(var aInfos: TwbDirtyInfos; const aPlugin: string; aCRC32: TwbCRC32): PwbDirtyInfo;
procedure wbReportDirtyInfos(const aInfos: TwbDirtyInfos; aGameDef: TwbGameDef; const aNexusModsUrl: string; const aOnMessage: TwbConflictMessageProc);

implementation

uses
  System.SysUtils,
  System.Classes,
  System.Math,
  wbBetterStringList,
  wbImplementation,
  wbHelpers,
  wbLoadOrder,
  wbDiff;

constructor TwbConflictView.Create(aContext: TwbGameContext);
begin
  inherited Create;
  Context := aContext;
  cvContextRef := aContext;
  cvAlignArrayElements := True;
  cvAlignArrayLimit := 5000;
  cvModGroupTargets := TDictionary<PwbModuleInfo, TwbModuleInfos>.Create;
  cvHidden := TwbHiddenSet.Create;
  cvTrees := TList<TwbConflictTree>.Create;
  cvEpoch := 1;
  cvRulesGeneration := aContext.ConflictRulesGeneration;
end;

destructor TwbConflictView.Destroy;
begin
  if Assigned(cvTrees) then
    for var lTree in cvTrees do
      lTree.ctView := nil;
  cvTrees.Free;
  cvHidden.Free;
  cvModGroupTargets.Free;
  inherited;
end;

procedure TwbConflictView.RulesChanged;
begin
  Inc(cvEpoch);
end;

procedure TwbConflictView.FollowContextRules;
begin
  if cvRulesGeneration <> Context.ConflictRulesGeneration then begin
    cvRulesGeneration := Context.ConflictRulesGeneration;
    Inc(cvEpoch);
  end;
end;

function TwbConflictView.GetEpoch: Cardinal;
begin
  FollowContextRules;
  Result := cvEpoch;
end;

function TwbConflictView.ModGroupTargets(aModule: PwbModuleInfo): TwbModuleInfos;
begin
  if not cvModGroupTargets.TryGetValue(aModule, Result) then
    Result := nil;
end;

procedure TwbConflictView.SetModGroupTargets(aTargets: TDictionary<PwbModuleInfo, TwbModuleInfos>);
begin
  if aTargets <> cvModGroupTargets then begin
    cvModGroupTargets.Clear;
    for var lPair in aTargets do
      cvModGroupTargets.Add(lPair.Key, Copy(lPair.Value));
  end;
  RulesChanged;
end;

procedure TwbConflictView.SetModGroupTargets(aFrom: TwbConflictView);
begin
  SetModGroupTargets(aFrom.cvModGroupTargets);
end;

procedure TwbConflictView.SetQuickShowConflicts(aValue: Boolean);
begin
  if cvQuickShowConflicts <> aValue then begin
    cvQuickShowConflicts := aValue;
    RulesChanged;
  end;
end;

procedure TwbConflictView.SetOnlyMasterAndLeafs(aValue: Boolean);
begin
  if cvOnlyMasterAndLeafs <> aValue then begin
    cvOnlyMasterAndLeafs := aValue;
    RulesChanged;
  end;
end;

procedure TwbConflictView.SetModGroupsEnabled(aValue: Boolean);
begin
  if cvModGroupsEnabled <> aValue then begin
    cvModGroupsEnabled := aValue;
    RulesChanged;
  end;
end;

procedure TwbConflictView.SetAlignArrayElements(aValue: Boolean);
begin
  if cvAlignArrayElements <> aValue then begin
    cvAlignArrayElements := aValue;
    RulesChanged;
  end;
end;

procedure TwbConflictView.SetAlignArrayLimit(aValue: Integer);
begin
  if cvAlignArrayLimit <> aValue then begin
    cvAlignArrayLimit := aValue;
    RulesChanged;
  end;
end;

function TwbConflictView.Lookup(const aRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis): Boolean;
begin
  FollowContextRules;
  var lID := aRecord.DenseIDIn(Context);
  Result := (lID > 0) and (lID < Cardinal(Length(cvEntries)));
  if Result then
    with cvEntries[lID] do begin
      Result := (Epoch = cvEpoch) and (Stamp = aRecord.ChainStamp);
      if Result then begin
        aConflictAll := ConflictAll;
        aConflictThis := ConflictThis;
      end;
    end;
  if not Result then begin
    aConflictAll := caUnknown;
    aConflictThis := ctUnknown;
  end;
end;

procedure TwbConflictView.Store(const aRecord: IwbMainRecord; aConflictAll: TConflictAll; aConflictThis: TConflictThis);
begin
  FollowContextRules;
  var lID := aRecord.DenseIDIn(Context);
  if lID = 0 then
    Exit;
  if lID >= Cardinal(Length(cvEntries)) then
    SetLength(cvEntries, Max(2 * Length(cvEntries), Integer(lID) + 1));
  with cvEntries[lID] do begin
    Stamp := aRecord.ChainStamp;
    Epoch := cvEpoch;
    ConflictAll := aConflictAll;
    ConflictThis := aConflictThis;
  end;
  if (aConflictAll <> caUnknown) or (aConflictThis <> ctUnknown) then
    aRecord.MarkConflictStored;
end;

procedure TwbConflictView.Peek(const aRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
begin
  Lookup(aRecord, aConflictAll, aConflictThis);
end;

function wbConflictLevelForNodeDatas(const aNodeDatas: PwbConflictNodeDatas; aNodeCount: Integer; aSiblingCompare, aInjected: Boolean): TConflictAll;
var
  Element                : IwbElement;
  CompareElement         : IwbElement;
  i, j                   : Integer;
  UniqueValues           : TwbFastStringListCS;

  MasterPosition         : Integer;
  FirstElement           : IwbElement;
  FirstElementNotIgnored : IwbElement;
  LastElement            : IwbElement;
  SameAsLast             : Boolean;
  SameAsFirst            : Boolean;
  OverallConflictThis    : TConflictThis;
  Priority               : TwbConflictPriority;
  ThisPriority           : TwbConflictPriority;
  FoundAny               : Boolean;

  ElementTypes           : TwbElementTypes;
  DefTypes               : TwbDefTypes;
  OptionalAndMissing     : Boolean;
begin
//  if aSiblingCompare then
//    Priority := cpBenign
//  else
//    Priority := cpNormal;
//  IgnoreConflicts := False;
  FoundAny := False;
  MasterPosition := 0;
  OverallConflictThis := ctUnknown;

  var lNodeCount := 0;
  var lFirstNode := PwbConflictNodeData(nil);

  if aNodeCount = 1 then begin
    lNodeCount := 1;
    lFirstNode := @aNodeDatas[0];
  end else
    for i := 0 to Pred(aNodeCount) do
      if aNodeDatas[i].ViewNodeFlags * [vnfDontShow, vnfIgnore] <> [] then with aNodeDatas[i] do begin
        ConflictThis := ctNotDefined;
        if Assigned(Element) and (vnfIgnore in ViewNodeFlags) then
          ConflictThis := ctIgnored;
      end else begin
        Inc(lNodeCount);
        if not Assigned(lFirstNode) then
          lFirstNode := @aNodeDatas[i];
      end;

  case lNodeCount of
    0: Result := caUnknown;
    1: begin
        Element := lFirstNode^.Element;
        if Assigned(Element) then begin
          if Element.ConflictPriority = cpIgnore then
            lFirstNode^.ConflictThis := ctIgnored
          else
            lFirstNode^.ConflictThis := ctOnlyOne;
        end else
          lFirstNode^.ConflictThis := ctNotDefined;
        Result := caOnlyOne;
      end
  else
    var lLastIndex := Pred(aNodeCount);

    LastElement := aNodeDatas[lLastIndex].Element;
    while not Assigned(LastElement) and (vnfIsPartialForm in aNodeDatas[lLastIndex].ViewNodeFlags) and (lLastIndex > 0) do begin
      Dec(lLastIndex);
      LastElement := aNodeDatas[lLastIndex].Element;
    end;
    FirstElement := lFirstNode.Element;

    UniqueValues := TwbFastStringListCS.Create;
    UniqueValues.Sorted := True;
    UniqueValues.Duplicates := dupIgnore;
    Priority := cpNormal;
    try
      for i := 0 to Pred(aNodeCount) do begin
        Element := aNodeDatas[i].Element;
        if Assigned(Element) then begin
          FoundAny := True;
          Priority := Element.ConflictPriority;
          if Priority = cpNormalIgnoreEmpty then begin
            FirstElement := Element;
            MasterPosition := i;
            for j := Pred(aNodeCount) downto i do begin
              LastElement := aNodeDatas[j].Element;
              if Assigned(LastElement) then
                Break;
            end;
          end;
          if Element.ConflictPriorityCanChange then begin
            for j := Succ(i) to Pred(aNodeCount) do begin
              Element := aNodeDatas[j].Element;
              if Assigned(Element) then begin
                ThisPriority := Element.ConflictPriority;
                if ThisPriority > Priority then
                  Priority := ThisPriority;
              end;
            end;
          end;
          Break;
        end;
      end;

      if aSiblingCompare then
        if Priority > cpBenign then
          Priority := cpBenign;
      if aInjected and (Priority >= cpNormal) then
        Priority := cpCritical;

      if (Priority > cpIgnore) and (not Assigned(FirstElement) or (FirstElement.ConflictPriority = cpIgnore)) then
        FirstElementNotIgnored := nil
      else
        FirstElementNotIgnored := FirstElement;

      ElementTypes := [];
      DefTypes := [];
      OptionalAndMissing := False;

      for i := 0 to Pred(aNodeCount) do begin
        Element := aNodeDatas[i].Element;
        if Assigned(Element) then begin
          Include(ElementTypes, Element.ElementType);
          if Assigned(Element.ValueDef) then
            Include(DefTypes, Element.ValueDef.DefType)
          else
            Include(DefTypes, dtEmpty);
          OptionalAndMissing := OptionalAndMissing or (esOptionalAndMissing in Element.ElementStates);

          ThisPriority := Element.ConflictPriority;
          if ThisPriority <> cpIgnore then
            UniqueValues.Add(Element.DisplaySortKey[True]);
        end else if (vnfIsPartialForm in aNodeDatas[i].ViewNodeFlags) then begin
          ThisPriority := cpIgnore;
        end else begin
          Include(DefTypes, dtEmpty);
          ThisPriority := Priority;
          if not (vnfIgnore in aNodeDatas[i].ViewNodeFlags) then
            if Priority <> cpNormalIgnoreEmpty then
              UniqueValues.Add('');
        end;

        if (ThisPriority = cpNormalIgnoreEmpty) and not Assigned(Element) then
          aNodeDatas[i].ConflictThis := ctIgnored
        else if ThisPriority = cpIgnore then
          aNodeDatas[i].ConflictThis := ctIgnored
        else if aSiblingCompare then
          aNodeDatas[i].ConflictThis := ctOnlyOne
        else if i = MasterPosition then begin

          if Assigned(Element) then
            aNodeDatas[i].ConflictThis := ctMaster
          else
            aNodeDatas[i].ConflictThis := ctUnknown;

        end else begin
          SameAsLast := (i = Pred(aNodeCount)) or not (
            (Assigned(Element) <> Assigned(LastElement)) or
            (Assigned(Element) and not SameStr(Element.DisplaySortKey[True], LastElement.DisplaySortKey[True]))
            );

          SameAsFirst := not (
            (Assigned(Element) <> Assigned(FirstElementNotIgnored)) or
            (Assigned(Element) and not SameStr(Element.DisplaySortKey[True], FirstElementNotIgnored.DisplaySortKey[True]))
            );

          if not SameAsFirst and
             (ThisPriority = cpBenignIfAdded) and
             SameAsLast and  // We are not overriden later
             not Assigned(FirstElementNotIgnored) then begin // The master did not have that element
            ThisPriority := cpBenign;
            Priority := cpBenign;
            SameAsFirst := True;
          end;

          if SameAsFirst then
            aNodeDatas[i].ConflictThis := ctIdenticalToMaster
          else if SameAsLast then
            aNodeDatas[i].ConflictThis := ctConflictWins
          else
            aNodeDatas[i].ConflictThis := ctConflictLoses;
        end;

        if (ThisPriority = cpBenign) and (aNodeDatas[i].ConflictThis > ctConflictBenign) then
          aNodeDatas[i].ConflictThis := ctConflictBenign;
        if (ThisPriority = cpOverride) and (aNodeDatas[i].ConflictThis > ctOverride) then
          aNodeDatas[i].ConflictThis := ctOverride;

        if aNodeDatas[i].ConflictThis > OverallConflictThis then
          OverallConflictThis := aNodeDatas[i].ConflictThis;
      end;

      case UniqueValues.Count of
        0: Result := caNoConflict;
        1: Result := caNoConflict;
        2: begin
            Element := aNodeDatas[0].Element;
            var lCompareIndex := Pred(aNodeCount);
            CompareElement := aNodeDatas[lCompareIndex].Element;
            while not Assigned(CompareElement) and (vnfIsPartialForm in aNodeDatas[lCompareIndex].ViewNodeFlags) and (lCompareIndex > 0) do begin
              Dec(lCompareIndex);
              CompareElement := aNodeDatas[lCompareIndex].Element;
            end;
            if (Assigned(Element) <> Assigned(CompareElement)) or
              (Assigned(Element) and not SameStr(Element.DisplaySortKey[True], CompareElement.DisplaySortKey[True])) then
              Result := caOverride
            else if (UniqueValues.IndexOf('') >= 0) and Assigned(CompareElement) and (CompareElement.DisplaySortKey[True] <> '') then
              Result := caOverride
            else
              Result := caConflict;
          end
      else
        Result := caConflict;
      end;

      if aSiblingCompare and (Result > caConflictBenign) then
        Result := caConflictBenign;

      if not FoundAny then
        for i := 0 to Pred(aNodeCount) do
          aNodeDatas[i].ConflictThis := ctNotDefined;

      if Result > caNoConflict then
        case Priority of
          cpBenign: Result := caConflictBenign;
          cpOverride: Result := caOverride;
          cpCritical: begin
              if UniqueValues.Find('', i) then
                UniqueValues.Delete(i);
              if UniqueValues.Count > 1 then
                Result := caConflictCritical;
            end;
        end;

      if Priority > cpBenign then
        if OverallConflictThis > ctOverride then
          with aNodeDatas[Pred(aNodeCount)] do
            if ConflictThis < ctOverride then
              if ConflictThis = ctIdenticalToMaster then
                ConflictThis := ctIdenticalToMasterWinsConflict
              else
                ConflictThis := ctConflictWins;

      if Result in [caNoConflict, caOverride, caConflict] then
        for i := 0 to Pred(aNodeCount) do begin
          case aNodeDatas[i].ConflictThis of
            ctIdenticalToMaster: case Result of
                caNoConflict: ;
                caOverride, caConflict: if i = Pred(aNodeCount) then
                  aNodeDatas[i].ConflictThis := ctIdenticalToMasterWinsConflict
              end;
            ctConflictWins: case Result of
              caNoConflict: aNodeDatas[i].ConflictThis := ctIdenticalToMaster;
              caOverride: aNodeDatas[i].ConflictThis := ctOverride;
              caConflict: ;
            end;
          end;
        end;

      if Result < caConflict then
        for i := 0 to Pred(aNodeCount) do
          if aNodeDatas[i].ConflictThis >= ctIdenticalToMasterWinsConflict then begin
            Result := caConflict;
            Break;
          end;

      if    (Result > caNoConflict)
        and OptionalAndMissing
        and (ElementTypes <= [etArray, etStruct, etValue])
        and (dtEmpty in DefTypes)
        and ((DefTypes - [dtEmpty]).Count = 1)
        and ((DefTypes - [dtEmpty, dtString..dtInteger, dtFloat, dtArray, dtStruct]).Count = 0) then begin

        for i := 0 to Pred(aNodeCount) do
          if Assigned(aNodeDatas[i].Element) then
            if not aNodeDatas[i].Element.ContentIsAllZero then
              Exit;

        Result := caNoConflict;

        for i := 0 to Pred(aNodeCount) do begin
          if aNodeDatas[i].ConflictThis > ctIdenticalToMaster then
            aNodeDatas[i].ConflictThis := ctIdenticalToMaster;
          if aNodeDatas[i].ConflictAll > caNoConflict then
            aNodeDatas[i].ConflictAll := caNoConflict;
        end;

      end;

    finally
      FreeAndNil(UniqueValues);
    end;
  end;
end;

function wbConflictCellElement(const aParentData: TwbConflictNodeData; aIndex: Cardinal): IwbElement;
var
  Container         : IwbContainerElementRef;
  SortableContainer : IwbSortableContainer;
begin
  Result := nil;
  Container := aParentData.Container;
  if not Assigned(Container) then
    Exit;
  if (vnfUseSortOrder in aParentData.ViewNodeFlags) or (Supports(Container, IwbSortableContainer, SortableContainer) and SortableContainer.Sorted) then begin
    if aIndex < Cardinal(Length(aParentData.RowElements)) then
      Result := aParentData.RowElements[aIndex];
  end else
    case Container.ElementType of
      etMainRecord, etSubRecordStruct:
        Result := Container.ElementBySortOrder[aIndex];
      etSubRecordArray, etArray, etStruct, etSubRecord, etValue, etUnion, etStructChapter:
        if aIndex < Cardinal(Container.ElementCount) then
          Result := Container.Elements[aIndex];
    end;
end;

procedure wbConflictInitNodes(const aNodeDatas: PwbConflictNodeDatas;
  const aParentDatas: PwbConflictNodeDatas;
  aNodeCount: Integer;
  aIndex: Cardinal;
  var aStates: TwbConflictNodeStates;
  const aOnElement: TwbConflictElementProc);
var
  NodeData                    : PwbConflictNodeData;
  ParentData                  : PwbConflictNodeData;
  Container                   : IwbContainerElementRef;
  i                           : Integer;
begin
  for i := 0 to Pred(aNodeCount) do begin
    NodeData := @aNodeDatas[i];
    ParentData := @aParentDatas[i];

    Container := ParentData.Container;
    NodeData.Element := wbConflictCellElement(ParentData^, aIndex);
    if Assigned(NodeData.Element) then begin
      if Assigned(aOnElement) then
        aOnElement(i, NodeData.Element);
      if NodeData.Element.DontShow then begin
        NodeData.Element := nil;
        Include(NodeData.ViewNodeFlags, vnfDontShow);
      end;
    end;

    if not Assigned(NodeData.Element) and
       Assigned(Container) and
       (Container.ElementType = etMainRecord) and
       (Container as IwbMainRecord).IsPartialForm
    then begin
      Include(NodeData.ViewNodeFlags, vnfIgnore);
      Include(NodeData.ViewNodeFlags, vnfIsPartialForm);
    end;
  end;

  aStates := [cnsDisabled];
  for i := 0 to Pred(aNodeCount) do
    with aNodeDatas[i] do begin
      if Assigned(Element) then
        Exclude(aStates, cnsDisabled)
      else begin
        if Assigned(aParentDatas) and ((vnfIgnore in aParentDatas[i].ViewNodeFlags) or (Assigned(aParentDatas[i].Element) and (aParentDatas[i].Element.ConflictPriority in [cpIgnore, cpNormalIgnoreEmpty]))) then
          Include(ViewNodeFlags, vnfIgnore);
        if Assigned(aParentDatas) and (vnfIsPartialForm in aParentDatas[i].ViewNodeFlags) then
          Include(ViewNodeFlags, vnfIsPartialForm);
      end;

      if not Assigned(Container) then
        if Supports(Element, IwbContainerElementRef, Container) then begin
          //          if Container.ElementCount = 0 then
          //            Container := nil;
        end;

      if Assigned(Container) then
        if Container.ElementCount > 0 then
          Include(aStates, cnsHasChildren)
        else if Supports(Container, IwbSubRecordStruct) then
          Include(aStates, cnsHasChildren);
    end;
end;

procedure wbConflictInitChildren(const aNodeDatas: PwbConflictNodeDatas; aNodeCount: Integer;
  var aChildCount: Cardinal; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc);
var
  NodeData                    : PwbConflictNodeData;
  Container                   : IwbContainerElementRef;
  FirstContainer              : IwbContainerElementRef;
  SortableContainer           : IwbSortableContainer;
  Element                     : IwbElement;
  i, j, k                     : Integer;
  SortedCount                 : Integer;
  AlignableCount              : Integer;
  NonSortedCount              : Integer;
  SortedKeys                  : array of TwbFastStringListCS;
  Sortables                   : array of IwbSortableContainer;
  SortKey                     : string;
  LastSortKey                 : string;
  DupCounter                  : Integer;

  AllKeys                     : TwbFastStringListCS;
  LeftKeys,RightKeys          : array of integer;
  KeyedElements               : array of array of Pointer;{skip the ref counting}
begin
  SortedCount := 0;
  NonSortedCount := 0;
  AlignableCount := 0;
  FirstContainer := nil;
  for i := 0 to Pred(aNodeCount) do begin
    NodeData := @aNodeDatas[i];
    NodeData.RowElements := nil;
    NodeData.ViewNodeFlags := NodeData.ViewNodeFlags - [vnfUseSortOrder, vnfIsSorted, vnfIsAligned];
    Container := NodeData.Container;
    if not Assigned(FirstContainer) then
      FirstContainer := Container;
    if Assigned(Container) then
      if Supports(Container, IwbSortableContainer, SortableContainer) then begin
        if SortableContainer.Sorted then
          Inc(SortedCount)
        else if SortableContainer.Alignable then
          Inc(AlignableCount)
      end else
        Inc(NonSortedCount);
  end;

  i := 0;
  if SortedCount > 0 then
    Inc(i);
  if AlignableCount > 0 then
    Inc(i);
  if NonSortedCount > 0 then
    Inc(i);
  if i > 1 then begin
    if Assigned(FirstContainer) and Assigned(aOnMessage) then
      aOnMessage('Warning: Comparing a mix of sorted, unsorted, and/or alignable entries for "' + FirstContainer.Path + '" in "'+FirstContainer.ContainingMainRecord.Name+'"');
    SortedCount := 0;
    AlignableCount := 0;
  end;

  if SortedCount > 0 then begin
//    Assert(NonSortedCount = 0);

    SetLength(SortedKeys, Succ(aNodeCount));
    for i := Low(SortedKeys) to High(SortedKeys) do begin
      SortedKeys[i] := TwbFastStringListCS.Create;
      SortedKeys[i].Sorted := True;
      SortedKeys[i].Duplicates := dupError;
    end;

    try
      SortedKeys[aNodeCount].Duplicates := dupIgnore;

      SetLength(Sortables, aNodeCount);

      for i := 0 to Pred(aNodeCount) do begin
        NodeData := @aNodeDatas[i];
        Include(NodeData.ViewNodeFlags, vnfIsSorted);
        if Supports(NodeData.Container, IwbSortableContainer, Sortables[i]) then begin
          SortableContainer := Sortables[i];
          DupCounter := 0;
          LastSortKey := '';
          for j := 0 to Pred(SortableContainer.ElementCount) do begin
            Element := SortableContainer.Elements[j];
            SortKey := Element.DisplaySortKey[False];
            if SameStr(LastSortKey, SortKey) then
              Inc(DupCounter)
            else begin
              DupCounter := 0;
              LastSortKey := SortKey;
            end;

            SortKey := SortKey + '<' + IntToHex64(DupCounter, 4) + '>';

            SortedKeys[i].AddObject(SortKey, Pointer(Element));
            SortedKeys[aNodeCount].Add(SortKey);
          end;
        end;
      end;

      aChildCount := SortedKeys[aNodeCount].Count;

      for i := 0 to Pred(aNodeCount) do
        if Assigned(Sortables[i]) then
          SetLength(aNodeDatas[i].RowElements, aChildCount);

      for j := 0 to Pred(aChildCount) do begin
        SortKey := SortedKeys[aNodeCount].Strings[j];
        for i := 0 to Pred(aNodeCount) do
          if SortedKeys[i].Find(SortKey, k) then
            aNodeDatas[i].RowElements[j] := IwbElement(Pointer(SortedKeys[i].Objects[k]));
      end;

    finally

      for i := Low(SortedKeys) to High(SortedKeys) do
        FreeAndNil(SortedKeys[i]);

    end;

  end else begin
    if aView.AlignArrayElements and (AlignableCount > 1) then
      AllKeys := TwbFastStringListCS.Create
    else
      AllKeys := nil;
    try
      for i := 0 to Pred(aNodeCount) do begin
        NodeData := @aNodeDatas[i];
        Container := NodeData.Container;

        if Assigned(Container) then begin
          case Container.ElementType of
            etMainRecord, etSubRecordStruct: if Assigned(Container.Def) then begin
                aChildCount := (Container.Def as IwbRecordDef).MemberCount;
                Inc(aChildCount, Container.AdditionalElementCount);
                if (Cardinal(Container.ElementCount) > aChildCount) and Assigned(aOnMessage) then begin
                  aOnMessage('Error: Container.ElementCount {'+IntToStr(Container.ElementCount)+'} > aChildCount {'+IntToStr(aChildCount)+'} for ' + Container.Path + ' in ' + Container.ContainingMainRecord.Name);
                  for j := 0 to Pred(Container.ElementCount) do
                  aOnMessage('  #'+IntToStr(j)+': ' + Container.Elements[j].Name);
                  //Assert(Cardinal(Container.ElementCount) <= aChildCount);
                end;
              end;
            etSubRecordArray, etSubRecord, etArray: begin

              with aNodeDatas[i].Container do begin
                if ElementCount > aView.AlignArrayLimit then
                  FreeAndNil(AllKeys);
                if Assigned(AllKeys) then
                  for j := 0 to Pred(ElementCount) do
                    AllKeys.Add(Elements[j].DisplaySortKey[False]);
              end;
              if aChildCount < Cardinal(Container.ElementCount) then
                aChildCount := Container.ElementCount;
            end;
            etStruct, etValue, etUnion, etStructChapter:
              if aChildCount < Cardinal(Container.ElementCount) then
                aChildCount := Container.ElementCount;
          end;
        end;
      end;
      if Assigned(AllKeys) then begin
        AllKeys.Sorted := True;
        AllKeys.RemoveDuplicates;
        if AllKeys.Count > 1 then begin
          KeyedElements := nil;
          SetLength(KeyedElements, aNodeCount);
          FirstContainer := nil;
          if AllKeys.Count > 0 then begin
            for i := 0 to Pred(aNodeCount) do begin
              NodeData := @aNodeDatas[i];
              Container := NodeData.Container;
              if Assigned(Container) and (Container.ElementCount > 0) then begin
                if not Assigned(FirstContainer) then begin
                  FirstContainer := Container;
                  with Container do begin
                    SetLength(LeftKeys, ElementCount);
                    SetLength(KeyedElements[i], ElementCount);
                    for j := 0 to Pred(ElementCount) do begin
                      if not AllKeys.Find(Elements[j].DisplaySortKey[False], LeftKeys[j]) then
                        Assert(False);
                      KeyedElements[i, j] := Elements[j];
                    end;
                  end;
                end else begin
                  with Container do begin
                    SetLength(RightKeys, ElementCount);
                    for j := 0 to Pred(ElementCount) do
                      if not AllKeys.Find(Elements[j].DisplaySortKey[False], RightKeys[j]) then
                        Assert(False);
                  end;

                  with TDiff.Create(nil) do try
                    AllowModify := False;
                    if not Execute(PInteger(@LeftKeys[0]), PInteger(@RightKeys[0]), Length(LeftKeys), Length(RightKeys)) then
                      Assert(False);

                    for j := Pred(i) downto 0 do
                      if Length(KeyedElements[j]) > 0 then begin
                        SetLength(KeyedElements[j], Count);
                        for k := Pred(Count) downto 0 do
                          with Compares[k] do
                            if Kind in [ckNone, ckDelete] then
                              if oldIndex1 <> k then begin
                                KeyedElements[j, k] := KeyedElements[j, oldIndex1];
                                KeyedElements[j, oldIndex1] := nil;
                              end;
                      end;

                    with Container do begin
                      SetLength(KeyedElements[i], Count);
                      SetLength(LeftKeys, Count);
                      RightKeys := nil;
                      for k := Pred(Count) downto 0 do
                        with Compares[k] do begin
                          if Kind in [ckNone, ckAdd] then begin
                            KeyedElements[i, k] := Elements[oldIndex2];
                            LeftKeys[k] := int2;
                          end else
                            LeftKeys[k] := int1;
                        end;
                      if aChildCount < Cardinal(Count) then
                        aChildCount := Count;
                    end;

                  finally
                    Free;
                  end;

                end;

              end;
            end;
            for i := 0 to Pred(aNodeCount) do begin
              NodeData := @aNodeDatas[i];
              Include(NodeData.ViewNodeFlags, vnfUseSortOrder);
              Include(NodeData.ViewNodeFlags, vnfIsAligned);
              if Assigned(NodeData.Container) then begin
                SetLength(NodeData.RowElements, aChildCount);
                for j := Low(KeyedElements[i]) to High(KeyedElements[i]) do
                  NodeData.RowElements[j] := IwbElement(KeyedElements[i, j]);
              end;
            end;
          end;
        end;
      end;

    finally
      AllKeys.Free;
    end;
  end;
end;

function wbConflictAlignedGap(const aParentData: TwbConflictNodeData; aRow: Integer; out aMemoryIndex: Integer): Boolean;
var
  i, lCount, lBefore : Integer;
begin
  aMemoryIndex := -1;
  Result := False;

  if not (vnfIsAligned in aParentData.ViewNodeFlags) or not Assigned(aParentData.Container) then
    Exit;
  if (aRow < 0) or (aRow >= Length(aParentData.RowElements)) or Assigned(aParentData.RowElements[aRow]) then
    Exit;

  lCount := 0;
  lBefore := 0;
  for i := Low(aParentData.RowElements) to High(aParentData.RowElements) do
    if Assigned(aParentData.RowElements[i]) then begin
      if (lCount >= aParentData.Container.ElementCount) or not aParentData.RowElements[i].Equals(aParentData.Container.Elements[lCount]) then
        Exit;
      if i < aRow then
        Inc(lBefore);
      Inc(lCount);
    end;
  if lCount <> aParentData.Container.ElementCount then
    Exit;

  aMemoryIndex := lBefore;
  Result := True;
end;

function wbConflictAssignAligned(const aContainer: IwbContainerElementRef; aIndex, aMemoryIndex: Integer; const aSource: IwbElement; aOnlySK: Boolean): IwbElement;
begin
  Result := aContainer.AssignAligned(aIndex, aMemoryIndex, aSource, aOnlySK);
  if Assigned(Result) then
    aContainer.MoveElementTo(Result, aMemoryIndex);
end;

function wbConflictLevelForChildNodeDatas(const aNodeDatas: TwbDynConflictNodeDatas; aSiblingCompare, aInjected: Boolean; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc; const aOnField: TwbFieldConflictProc): TConflictAll;
var
  ChildCount       : Cardinal;
  i, j             : Integer;
  NodeDatas        : TwbDynConflictNodeDatas;
  States           : TwbConflictNodeStates;
  ConflictAll      : TConflictAll;
  ConflictThis     : TConflictThis;
  Element          : IwbElement;
  ElementCount     : Integer;
  TranslationMode  : Boolean;
begin
  TranslationMode := aView.Context.Settings.TranslationMode;
  case Length(aNodeDatas) of
    0: Result := caUnknown;
    1: begin
      Result := caOnlyOne;
      if not TranslationMode then
        aNodeDatas[0].ConflictThis := ctOnlyOne;
    end;
  else
    Result := caNoConflict;
  end;

  if TranslationMode then begin
    if Result < caOnlyOne then
      Exit;
  end
  else begin
    if Result < caNoConflict then
      Exit;
  end;

  ChildCount := 0;
  wbConflictInitChildren(@aNodeDatas[0], Length(aNodeDatas), ChildCount, aView, aOnMessage);
  if ChildCount > 0 then
    for i := 0 to Pred(ChildCount) do begin
      NodeDatas := nil;
      SetLength(NodeDatas, Length(aNodeDatas));
      States := [];
      wbConflictInitNodes(@NodeDatas[0], @aNodeDatas[0], Length(aNodeDatas), i, States, nil);
      if not (cnsDisabled in States) then begin

        if cnsHasChildren in States then
          ConflictAll := wbConflictLevelForChildNodeDatas(NodeDatas, aSiblingCompare, aInjected, aView, aOnMessage, aOnField)
        else begin
          ConflictAll := wbConflictLevelForNodeDatas(@NodeDatas[0], Length(NodeDatas), aSiblingCompare, aInjected);
          if Assigned(aOnField) then
            aOnField(NodeDatas, ConflictAll);
        end;

        if ConflictAll > Result then
          Result := ConflictAll;

        for j := Low(aNodeDatas) to High(aNodeDatas) do
          if NodeDatas[j].ConflictThis > aNodeDatas[j].ConflictThis then
            aNodeDatas[j].ConflictThis := NodeDatas[j].ConflictThis;

      end
      else begin

        ConflictThis := ctNotDefined;

        for j := Low(aNodeDatas) to High(aNodeDatas) do begin
          Element := aNodeDatas[j].Container;
          if Assigned(Element) then
            Break;
        end;

        if Assigned(Element) and (Element.ElementType in [etMainRecord, etSubRecordStruct]) then begin
          ElementCount := (Element.Def as IwbRecordDef).MemberCount;
          j := (Element as IwbContainer).AdditionalElementCount;
          if (i >= j) and (i-j < ElementCount) then
            with (Element.Def as IwbRecordDef).Members[i - j] do
              if (TranslationMode and (not (dfTranslatable in DefFlags))) or
                (TranslationMode and (ConflictPriority[nil] = cpIgnore)) then
                ConflictThis := ctIgnored;
        end;

        if not Assigned(Element) then
          if TranslationMode then
            ConflictThis := ctIgnored;

        for j := Low(aNodeDatas) to High(aNodeDatas) do
          if ConflictThis > aNodeDatas[j].ConflictThis then
            aNodeDatas[j].ConflictThis := ConflictThis;
      end;
    end;
end;

function TwbConflictView.NodeDatasForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles): TwbDynConflictNodeDatas;
var
  Master        : IwbMainRecord;
  Rec           : IwbMainRecord;
  i, j          : Integer;
  EditorID      : string;
  FormID        : TwbFormID;
  LoadOrder     : Integer;
  Group         : IwbGroupRecord;
  Signature     : TwbSignature;
  MainRecords   : TDynMainRecords;
  Modules       : TwbModuleInfos;
  FirstModule   : PwbModuleInfo;
  LastModule    : PwbModuleInfo;
  Targets       : TwbModuleInfos;
  Hidden        : TwbModuleInfos;
begin
  MainRecords := nil;
  Result := nil;

  if (aMainRecord.Signature = 'GMST') or (aMainRecord.Signature = 'DFOB') then begin
    EditorID := aMainRecord.EditorID;
    SetLength(MainRecords, Length(aFiles));
    Master := nil;
    j := 0;
    for i := Low(aFiles) to High(aFiles) do begin
      Group := aFiles[i].GroupBySignature[aMainRecord.Signature];
      if Assigned(Group) then begin
        Rec := Group.MainRecordByEditorID[EditorID];
        if Assigned(Rec) then begin
          if not Assigned(Master) then
            Master := Rec;
          MainRecords[j] := Rec;
          Inc(j);
        end;
      end;
    end;
    SetLength(MainRecords, j);

  end else if (aMainRecord.Signature = 'NAVI') (* or (aMainRecord.Signature = 'TES4') *) then begin
    Signature := aMainRecord.Signature;
    FormID := aMainRecord.FormID;
    LoadOrder := aMainRecord.GetFile.LoadOrder;
    SetLength(MainRecords, Length(aFiles));
    Master := nil;
    j := 0;
    for i := Low(aFiles) to High(aFiles) do
      if aFiles[i].LoadOrder = LoadOrder then begin
        Group := aFiles[i].GroupBySignature[Signature];
        if Assigned(Group) then begin
          Rec := Group.MainRecordByFormID[FormID];
          if Assigned(Rec) then begin
            if not Assigned(Master) then
              Master := Rec;
            MainRecords[j] := Rec;
            Inc(j);
          end;
        end;
      end;
    SetLength(MainRecords, j);

  end else if (aMainRecord.Signature = 'TES4') then begin
    Signature := aMainRecord.Signature;
    LoadOrder := aMainRecord.GetFile.LoadOrder;
    SetLength(MainRecords, Length(aFiles));
    Master := nil;
    j := 0;
    for i := Low(aFiles) to High(aFiles) do
      if aFiles[i].LoadOrder = LoadOrder then begin
        // header of .exe file, show only itself
        if SameText(ExtractFileExt(aMainRecord.GetFile.FileName), csDotExe) and not SameText(ExtractFileExt(aFiles[i].FileName), csDotExe) then
          Continue;
        // skip .exe file header by default
        if not SameText(ExtractFileExt(aMainRecord.GetFile.FileName), csDotExe) and SameText(ExtractFileExt(aFiles[i].FileName), csDotExe) then
          Continue;
        Rec := aFiles[i].Elements[0] as IwbMainRecord;
        if Assigned(Rec) then begin
          if not Assigned(Master) then
            Master := Rec;
          MainRecords[j] := Rec;
          Inc(j);
        end;
      end;
    SetLength(MainRecords, j);

  end else begin
    Master := aMainRecord.MasterOrSelf;

    if cvOnlyMasterAndLeafs then begin
      MainRecords := Master.MasterAndLeafs;
    end else begin
      SetLength(MainRecords, Succ(Master.OverrideCount));
      MainRecords[0] := Master;
      for i := 0 to Pred(Master.OverrideCount) do
        MainRecords[Succ(i)] := Master.Overrides[i];
    end;
  end;

  if cvModGroupsEnabled and (Length(MainRecords) > 2) then begin
    SetLength(Modules, Length(MainRecords));
    FirstModule := nil;
    LastModule := nil;
    Hidden := nil;
    for i := Low(MainRecords) to High(MainRecords) do begin
      Modules[i] := MainRecords[i]._File.ModuleInfo;
      if Assigned(Modules[i]) then begin
        if not Assigned(FirstModule) then
          FirstModule := Modules[i];
        LastModule := Modules[i];
        Targets := ModGroupTargets(Modules[i]);
        if Length(Targets) > 0 then
          Hidden := Hidden + Targets;
      end;
    end;

    j := 0;
    for i := Low(Modules) to High(Modules) do
      if not Assigned(Modules[i]) or (Modules[i] = FirstModule) or (Modules[i] = LastModule) or not Hidden.Contains(Modules[i]) then begin
        if i <> j then
          MainRecords[j] := MainRecords[i];
        Inc(j);
      end;
    SetLength(MainRecords, j);
  end;

  if cvHidden.Count > 0 then begin
    j := 0;
    for i := Low(MainRecords) to High(MainRecords) do
      if not MainRecords[i].IsHiddenIn(cvHidden) then begin
        if i <> j then
          MainRecords[j] := MainRecords[i];
        Inc(j);
      end;
    SetLength(MainRecords, j);
  end;

  if Length(MainRecords) < 1 then
    MainRecords := [aMainRecord];

  SetLength(Result, Length(MainRecords));
  for i := Low(MainRecords) to High(MainRecords) do
    with Result[i] do begin
      Rec := MainRecords[i];
      if i = 0 then
        Master := Rec;

      Container := Rec as IwbContainerElementRef;
      Element := Container;
      if (Container.ElementCount = 0) or (Rec.Signature <> Master.Signature) then
        Container := nil;
    end;
end;

function wbConflictNodeDatasForContainer(const aContainer: IwbDataContainer; const aFiles: TwbFiles): TwbDynConflictNodeDatas;
var
  i, l    : Integer;
  p       : string;
  Element : IwbElement;
begin
  SetLength(Result, 0);
  l := 0;
  p := Copy(aContainer.Path, Succ(Length(aContainer.GetFile.Path + ' \ ')));
  repeat
    i := Pos(' \ ', p);
    if i>0 then begin
      Delete(p, i, 1);
      Delete(p, i+1, 1);
    end;
  until i = 0;  // Convert GetPath to ByPath

  for i := 0 to pred(Length(aFiles)) do
    if aFiles[i].IsNotPlugin then begin
      Element := aFiles[i].ElementByPath[p];
      if Assigned(Element) then begin
        SetLength(Result, Succ(l));
        Result[l].Element := Element;
        Result[l].Container := Element as IwbContainerElementRef;
        if Result[l].Container.ElementCount < 1 then
          Result[l].Container := nil;
        Inc(l);
      end;
    end;
  Assert(Length(Result)>0); // At least there should be ourself
end;

procedure TwbConflictView.LevelForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles; const aOnMessage: TwbConflictMessageProc; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
var
  ThisConflict                : TConflictThis;

  procedure Put(const aRecord: IwbMainRecord; aAll: TConflictAll; aThis: TConflictThis);
  begin
    Store(aRecord, aAll, aThis);
    if aRecord.Equals(aMainRecord) then
      ThisConflict := aThis;
  end;

  procedure Fix(const aRecord: IwbMainRecord);
  var
    lAll  : TConflictAll;
    lThis : TConflictThis;
  begin
    Lookup(aRecord, lAll, lThis);
    if lThis = ctUnknown then
      lThis := ctHiddenByModGroup;
    Put(aRecord, aConflictAll, lThis);
  end;

  procedure Allocate(const aRecords: TDynMainRecords);
  begin
    for var lRecord in aRecords do
      if lRecord.DenseIDIn(Context) = 0 then begin
        Context.AllocateDenseIDs(aRecords);
        Exit;
      end;
  end;

var
  NodeDatas                   : TwbDynConflictNodeDatas;

  function IsCompareToSame: Boolean;
  var
    MainRecordMaster, MainRecordOverride: IwbMainRecord;
    FileMaster, FileOverride: IwbFile;
  begin
    Result := False;

    if Length(NodeDatas) <> 2 then
      Exit;

    if not Supports(NodeDatas[0].Element, IwbMainRecord, MainRecordMaster) then
      Exit;
    if MainRecordMaster.Modified then
      Exit;

    if not Supports(NodeDatas[1].Element, IwbMainRecord, MainRecordOverride) then
      Exit;
    if MainRecordOverride.Modified then
      Exit;

    FileOverride := MainRecordOverride._File;
    if not Assigned(FileOverride) then
      Exit;

    if not (fsCompareToHasSameMasters in FileOverride.FileStates) then
      Exit;

    FileMaster := MainRecordMaster._File;
    if not Assigned(FileMaster) then
      Exit;

    if not FileMaster.Equals(FileOverride.CompareToFile) then
      Exit;

    Result := MainRecordMaster.ContentEquals(MainRecordOverride);
  end;

var
  i                           : Integer;
  Master                      : IwbMainRecord;
  KeepAliveRoot               : IwbKeepAliveRoot;
  TranslationMode             : Boolean;
begin
  KeepAliveRoot := wbCreateKeepAliveRoot;

  Lookup(aMainRecord, aConflictAll, aConflictThis);

  if aConflictAll > caUnknown then begin
    Inc(Hits);
    Exit;
  end;
  Inc(Misses);

  TranslationMode := Context.Settings.TranslationMode;
  Master := aMainRecord.MasterOrSelf;
  if (Master.OverrideCount = 0) and not TranslationMode and not ((Master.Signature = 'GMST') or (Master.Signature = 'DFOB')) then begin
    aConflictAll := caOnlyOne;
    aConflictThis := ctOnlyOne;
    Allocate([aMainRecord]);
    Store(aMainRecord, aConflictAll, aConflictThis);
  end else begin
    NodeDatas := NodeDatasForMainRecord(aMainRecord, aFiles);
    if (Length(NodeDatas) = 1) and not TranslationMode then begin
      aConflictAll := caOnlyOne;
      NodeDatas[0].ConflictAll := caOnlyOne;
      NodeDatas[0].ConflictThis := ctOnlyOne;
    end else if Length(NodeDatas) = 2 then begin
      if cvQuickShowConflicts then begin
        aConflictAll := caOverride;
        NodeDatas[0].ConflictAll := caOverride;
        NodeDatas[1].ConflictAll := caOverride;
        NodeDatas[0].ConflictThis := ctMaster;
        NodeDatas[1].ConflictThis := ctOverride;
      end else if IsCompareToSame then begin
        aConflictAll := caNoConflict;
        NodeDatas[0].ConflictAll := caNoConflict;
        NodeDatas[1].ConflictAll := caNoConflict;
        NodeDatas[0].ConflictThis := ctMaster;
        NodeDatas[1].ConflictThis := ctIdenticalToMaster;
      end else
        aConflictAll := wbConflictLevelForChildNodeDatas(NodeDatas, False, (aMainRecord.MasterOrSelf.IsInjected and not ((aMainRecord.Signature = 'GMST') or (aMainRecord.Signature = 'DFOB')) ), Self, aOnMessage);
    end else
      aConflictAll := wbConflictLevelForChildNodeDatas(NodeDatas, False, (aMainRecord.MasterOrSelf.IsInjected and not ((aMainRecord.Signature = 'GMST') or (aMainRecord.Signature = 'DFOB')) ), Self, aOnMessage);

    var lWritten: TDynMainRecords;
    SetLength(lWritten, Length(NodeDatas) + 1 + Master.OverrideCount);
    var lCount := 0;
    for i := Low(NodeDatas) to High(NodeDatas) do
      if Assigned(NodeDatas[i].Element) then begin
        lWritten[lCount] := NodeDatas[i].Element as IwbMainRecord;
        Inc(lCount);
      end;
    lWritten[lCount] := Master;
    Inc(lCount);
    for i := 0 to Pred(Master.OverrideCount) do begin
      lWritten[lCount] := Master.Overrides[i];
      Inc(lCount);
    end;
    SetLength(lWritten, lCount);
    Allocate(lWritten);

    ThisConflict := ctUnknown;
    for i := Low(NodeDatas) to High(NodeDatas) do
      if Assigned(NodeDatas[i].Element) then begin
        if NodeDatas[i].ConflictThis = ctUnknown then
          NodeDatas[i].ConflictThis := ctNotDefined;
        Put(NodeDatas[i].Element as IwbMainRecord, aConflictAll, NodeDatas[i].ConflictThis);
      end;

    Fix(Master);
    for i := 0 to Pred(Master.OverrideCount) do
      Fix(Master.Overrides[i]);

    aConflictThis := ThisConflict;
  end;
end;

type
  TwbByteSet = set of Byte;

  TwbCleanNode = class
  private
    cnElement   : IwbElement;
    cnContainer : IwbContainer;
    cnChildren  : TArray<TwbCleanNode>;
    cnGone      : Boolean;
    cnOwn       : TConflictThis;
    cnThis      : TConflictThis;
    function LiveChildCount: Integer;
    procedure Judge(aView: TwbConflictView; const aFiles: TwbFiles; aOnlyOne: Boolean; const aOnMessage: TwbConflictMessageProc);
    function NodeCount: Cardinal;
    function LiveCount(var aMainRecords: Cardinal): Cardinal;
  public
    constructor Create(const aElement: IwbElement; const aContainer: IwbContainer; const aParented: TwbByteSet);
    destructor Destroy; override; final;
  end;

function wbParentedGroupTypes(aContext: TwbGameContext): TwbByteSet;
begin
  Result := [1, 6, 7];
  if gcVWDAsQuestChildren in aContext.GameDefObj.Capabilities then
    Include(Result, 10);
end;

constructor TwbCleanNode.Create(const aElement: IwbElement; const aContainer: IwbContainer; const aParented: TwbByteSet);
var
  lRecord : IwbMainRecord;
  lGroup  : IwbGroupRecord;
  lChild  : IwbContainer;
  i       : Integer;
begin
  inherited Create;
  cnElement := aElement;
  cnContainer := aContainer;
  if not Assigned(cnContainer) then
    Exit;
  i := 0;
  while i < cnContainer.ElementCount do begin
    var lElement := cnContainer.Elements[i];
    lChild := nil;
    if Supports(lElement, IwbMainRecord, lRecord) then begin
      if (Succ(i) < cnContainer.ElementCount) and
         Supports(cnContainer.Elements[Succ(i)], IwbGroupRecord, lGroup) and
         (lGroup.GroupType in aParented) and
         (lRecord.FormID.ToCardinal = lGroup.GroupLabel)
      then begin
        lChild := lGroup;
        Inc(i);
      end;
    end else if Supports(lElement, IwbGroupRecord, lGroup) then
      lChild := lGroup;
    cnChildren := cnChildren + [TwbCleanNode.Create(lElement, lChild, aParented)];
    Inc(i);
  end;
end;

destructor TwbCleanNode.Destroy;
begin
  for var lChild in cnChildren do
    lChild.Free;
  inherited;
end;

function TwbCleanNode.LiveChildCount: Integer;
begin
  Result := 0;
  for var lChild in cnChildren do
    if not lChild.cnGone then
      Inc(Result);
end;

procedure TwbCleanNode.Judge(aView: TwbConflictView; const aFiles: TwbFiles; aOnlyOne: Boolean; const aOnMessage: TwbConflictMessageProc);
var
  lRecord : IwbMainRecord;
  lMaster : IwbMainRecord;
  lAll    : TConflictAll;
begin
  for var i := High(cnChildren) downto Low(cnChildren) do
    cnChildren[i].Judge(aView, aFiles, aOnlyOne, aOnMessage);
  wbTick;
  cnOwn := ctUnknown;
  cnThis := ctUnknown;
  if Supports(cnElement, IwbMainRecord, lRecord) then begin
    if aOnlyOne and (LiveChildCount = 0) then begin
      lMaster := lRecord.MasterOrSelf;
      if lMaster.OverrideCount > 0 then begin
        var lVisible := 0;
        if not aView.Hidden.IsHidden(lMaster) then
          Inc(lVisible);
        for var i := 0 to Pred(lMaster.OverrideCount) do
          if not aView.Hidden.IsHidden(lMaster.Overrides[i]) then begin
            Inc(lVisible);
            if lVisible > 1 then
              Break;
          end;
        if lVisible > 1 then begin
          cnGone := True;
          Exit;
        end;
      end;
    end;
    aView.LevelForMainRecord(lRecord, aFiles, aOnMessage, lAll, cnOwn);
    cnThis := cnOwn;
  end;
  if LiveChildCount > 0 then begin
    for var lChild in cnChildren do
      if not lChild.cnGone and (lChild.cnThis > cnThis) then
        cnThis := lChild.cnThis;
  end else if cnElement.Skipped then
    cnGone := True;
end;

function TwbCleanNode.NodeCount: Cardinal;
begin
  Result := 1;
  if Assigned(cnContainer) and Supports(cnElement, IwbMainRecord) then
    Inc(Result);
  for var lChild in cnChildren do
    Inc(Result, lChild.NodeCount);
end;

function TwbCleanNode.LiveCount(var aMainRecords: Cardinal): Cardinal;
begin
  Result := 0;
  if cnGone then
    Exit;
  Result := 1;
  if Supports(cnElement, IwbMainRecord) then
    Inc(aMainRecords);
  for var lChild in cnChildren do
    Inc(Result, lChild.LiveCount(aMainRecords));
end;

function wbCleanDecide(const aElement: IwbElement; aThis, aOrgThis: TConflictThis; aLiveChildren: Integer; aAllowMakePartial: Boolean): TwbCleanAction;
var
  lRecord : IwbMainRecord;
begin
  Result := qcKeep;
  if not Assigned(aElement) then
    Exit;

  if not (
    (
      (aLiveChildren = 0) or
      (
        aAllowMakePartial and
        Supports(aElement, IwbMainRecord, lRecord) and
        not lRecord.IsPartialForm and
        lRecord.CanBePartial
      )
    ) and
    (
      (aThis = ctIdenticalToMaster) or
      (
        (aThis = ctConflictBenign) and
        Supports(aElement, IwbMainRecord, lRecord) and
        (lRecord.Signature = 'NAVM')
      ) or
      (
        (aOrgThis = ctIdenticalToMaster) and
        aAllowMakePartial and
        (aLiveChildren > 0)
      ) or
      Supports(aElement, IwbGroupRecord) or
      (
        (aLiveChildren = 0) and
        aAllowMakePartial and
        Supports(aElement, IwbMainRecord, lRecord) and
        lRecord.IsPartialForm and
        (not Assigned(lRecord.ChildGroup) or (lRecord.ChildGroup.ElementCount = 0))
      )
    ) and
    not (Supports(aElement, IwbMainRecord, lRecord) and lRecord.MasterOrSelf.IsInjected)
  ) then
    Exit;

  if not aElement.IsRemovable then
    Result := qcCantRemove
  else if aLiveChildren > 0 then
    Result := qcMakePartial
  else
    Result := qcRemove;
end;

procedure wbCleanApply(aAction: TwbCleanAction; const aElement: IwbElement; const aContainer: IwbContainer);
var
  lRecord : IwbMainRecord;
begin
  case aAction of
    qcMakePartial:
      if Supports(aElement, IwbMainRecord, lRecord) then
        lRecord.MakePartialForm;
    qcRemove: begin
      if Assigned(aContainer) and not aContainer.Equals(aElement) then
        aContainer.Remove;
      aElement.Remove;
    end;
  end;
end;

function wbConflictMakeDeltaPatch(const aOld, aNew: IwbFile; aTemplate: TwbConflictView; const aOnMessage: TwbConflictMessageProc): TwbDeltaPatchCounts;
var
  lContext      : TwbGameContext;
  lView         : TwbConflictView;
  lFiles        : TwbFiles;
  lParented     : TwbByteSet;
  lCounts       : TwbDeltaPatchCounts;

  procedure CopyDeleted(aNode: TwbCleanNode);
  var
    lRecord : IwbMainRecord;
    lCopy   : IwbMainRecord;
  begin
    wbTick;
    if Supports(aNode.cnElement, IwbMainRecord, lRecord) and
       (lRecord.Signature <> 'TES4') and
       not lRecord.IsDeleted and
       (aNode.cnThis = ctOnlyOne) and
       Supports(wbCopyElementToFile(lRecord, aNew, False, False, '', '', '', '', False), IwbMainRecord, lCopy)
    then begin
      lCopy.IsDeleted := True;
      Inc(lCounts.Copied);
    end;
    for var lChild in aNode.cnChildren do
      if not lChild.cnGone then
        CopyDeleted(lChild);
  end;

  procedure RemoveIdentical(aNode: TwbCleanNode);
  begin
    for var i := High(aNode.cnChildren) downto Low(aNode.cnChildren) do
      if not aNode.cnChildren[i].cnGone then
        RemoveIdentical(aNode.cnChildren[i]);
    wbTick;
    Inc(lCounts.Processed);
    var lIsRec := Supports(aNode.cnElement, IwbMainRecord);
    var lAction := wbCleanDecide(aNode.cnElement, aNode.cnThis, aNode.cnOwn, aNode.LiveChildCount, False);
    if lAction <> qcKeep then begin
      Inc(lCounts.Candidates);
      if lAction = qcCantRemove then begin
        if Assigned(aOnMessage) then
          aOnMessage('Can''t remove: ' + aNode.cnElement.Name);
        Inc(lCounts.CantRemove);
      end else begin
        wbCleanApply(lAction, aNode.cnElement, aNode.cnContainer);
        aNode.cnGone := True;
        if lIsRec then
          Inc(lCounts.Removed);
      end;
    end;
  end;

var
  lTree : TwbCleanNode;
begin
  lCounts := Default(TwbDeltaPatchCounts);
  lContext := aNew.ContextObj;
  if aOld.ContextObj <> lContext then
    raise Exception.Create('Delta patch: ' + aOld.FileName + ' and ' + aNew.FileName + ' are not loaded in the same context');
  if not (fsIsDeltaPatch in aNew.FileStates) or not aOld.Equals(aNew.CompareToFile) then
    raise Exception.Create('Delta patch: ' + aNew.FileName + ' is not loaded as a delta patch of ' + aOld.FileName);
  if not aNew.IsEditable then
    raise Exception.Create('Delta patch: ' + aNew.FileName + ' is not editable');
  if lContext.Settings.TranslationMode then
    raise Exception.Create('Delta patch: not available in translation mode');

  lFiles := lContext.Files;
  lParented := wbParentedGroupTypes(lContext);

  lView := TwbConflictView.Create(lContext);
  try
    if Assigned(aTemplate) then begin
      lView.AlignArrayElements := aTemplate.AlignArrayElements;
      lView.AlignArrayLimit := aTemplate.AlignArrayLimit;
    end;
    for var lFile in lFiles do
      if not lFile.Equals(aOld) and not lFile.Equals(aNew) then
        lView.Hidden.Hide(lFile);

    lTree := TwbCleanNode.Create(aOld, aOld, lParented);
    try
      lTree.Judge(lView, lFiles, True, aOnMessage);
      CopyDeleted(lTree);
    finally
      lTree.Free;
    end;

    aNew.RemoveIdenticalDeltaFast;

    lTree := TwbCleanNode.Create(aNew, aNew, lParented);
    try
      lTree.Judge(lView, lFiles, False, aOnMessage);
      for var i := High(lTree.cnChildren) downto Low(lTree.cnChildren) do
        if not lTree.cnChildren[i].cnGone then
          RemoveIdentical(lTree.cnChildren[i]);
    finally
      lTree.Free;
    end;
  finally
    lView.Free;
  end;
  Result := lCounts;
end;

function TwbDirtyInfo.LOOTEntry(aFileChanged: Boolean; const aAppName, aVersion, aNexusModsUrl: string): string;
begin
  Result := '';
  if (ITM <> 0) or (UDR <> 0) or (NAV <> 0) then begin
    if aFileChanged then begin
      Result := CRLF + Format(StringOfChar(' ', 2) + '- name: ''%s''', [Plugin.Replace('''', '''''', [rfReplaceAll])]) + CRLF;
      Result := Result + StringOfChar(' ', 4) + 'dirty:' + CRLF;
    end;
    if NAV <> 0 then
      Result := Result + StringOfChar(' ', 6) + '- <<: *reqManualFix'
    else
      Result := Result + StringOfChar(' ', 6) + '- <<: *quickClean';
    Result := Result + CRLF + Format(StringOfChar(' ', 8) + 'crc: 0x%s', [IntToHex(CRC32, 8)]);
    Result := Result + CRLF + Format(StringOfChar(' ', 8) + 'util: ''[%sEdit v%s](%s)''', [aAppName, aVersion, aNexusModsUrl]);
    if ITM <> 0 then Result := Result + CRLF + Format(StringOfChar(' ', 8) + 'itm: %d', [ITM]);
    if UDR <> 0 then Result := Result + CRLF + Format(StringOfChar(' ', 8) + 'udr: %d', [UDR]);
    if NAV <> 0 then Result := Result + CRLF + Format(StringOfChar(' ', 8) + 'nav: %d', [NAV]);
  end else begin
    if aFileChanged then
      Result := CRLF + Format(StringOfChar(' ', 2) + '- name: ''%s''', [Plugin.Replace('''', '''''', [rfReplaceAll])]) + CRLF;
    Result := Result + StringOfChar(' ', 4) + 'clean:';
    Result := Result + CRLF + Format(StringOfChar(' ', 6) + '- crc: 0x%s', [IntToHex(CRC32, 8)]);
    Result := Result + CRLF + Format(StringOfChar(' ', 8) + 'util: ''%sEdit v%s''', [aAppName, aVersion]);
  end;
end;

function TwbDirtyInfo.BOSSEntry(const aAppName: string): string;
begin
  Result := '';
  if (ITM <> 0) or (UDR <> 0) then begin
    Result := Result + CRLF + Plugin;
    Result := Result + CRLF + Format('  IF CHECKSUM("%s", %s) DIRTY: %d ITM, %d UDR records. Needs %sEdit cleaning: "http://cs.elderscrolls.com/index.php?title=TES4Edit_Cleaning_Guide"', [
      Plugin,
      IntToHex(CRC32, 8),
      ITM,
      UDR,
      aAppName
    ]);
  end;
end;

function wbDirtyInfoFor(var aInfos: TwbDirtyInfos; const aPlugin: string; aCRC32: TwbCRC32): PwbDirtyInfo;
begin
  for var i := Low(aInfos) to High(aInfos) do
    if (aInfos[i].Plugin = aPlugin) and (aInfos[i].CRC32 = aCRC32) then
      Exit(@aInfos[i]);
  SetLength(aInfos, Succ(Length(aInfos)));
  Result := @aInfos[High(aInfos)];
  Result.Plugin := aPlugin;
  Result.CRC32 := aCRC32;
end;

procedure wbReportDirtyInfos(const aInfos: TwbDirtyInfos; aGameDef: TwbGameDef; const aNexusModsUrl: string; const aOnMessage: TwbConflictMessageProc);
var
  lBOSS : Boolean;
begin
  if Length(aInfos) < 1 then
    Exit;
  lBOSS := False;
  aOnMessage('');
  aOnMessage('LOOT Masterlist Entries');
  for var i := Low(aInfos) to High(aInfos) do begin
    aOnMessage(aInfos[i].LOOTEntry((i = 0) or not SameText(aInfos[i].Plugin, aInfos[Pred(i)].Plugin), aGameDef.AppName, VersionString.ToString, aNexusModsUrl));
    if (aInfos[i].ITM <> 0) or (aInfos[i].UDR <> 0) then
      lBOSS := aGameDef.GameMode = gmTES4;
  end;
  aOnMessage('');
  if lBOSS then begin
    aOnMessage('BOSS Masterlist Entries');
    for var lInfo in aInfos do
      aOnMessage(lInfo.BOSSEntry(aGameDef.AppName));
  end;
end;

constructor TwbQuickClean.Create(const aFile: IwbFile; aView: TwbConflictView; const aOnMessage, aOnProgress: TwbConflictMessageProc);
begin
  inherited Create;
  qcFile := aFile;
  qcContext := aFile.ContextObj;
  qcView := aView;
  qcOnMessage := aOnMessage;
  qcOnProgress := aOnProgress;
end;

destructor TwbQuickClean.Destroy;
begin
  qcTree.Free;
  inherited;
end;

procedure TwbQuickClean.Post(const aText: string);
begin
  if Assigned(qcOnMessage) then
    qcOnMessage(aText);
end;

procedure TwbQuickClean.Progress(const aText: string);
begin
  if Assigned(qcOnProgress) then
    qcOnProgress(aText);
end;

procedure TwbQuickClean.Filter;
var
  lStart    : TDateTime;
  lTree     : TwbCleanNode;
  lRecords  : Cardinal;
  lFiltered : Integer;
begin
  FreeAndNil(qcTree);
  lStart := Now;
  Progress('Start: Applying Filter');
  try
    lTree := TwbCleanNode.Create(qcFile, qcFile, wbParentedGroupTypes(qcContext));
    qcTree := lTree;
    lTree.Judge(qcView, qcContext.Files, False, qcOnMessage);
    qcCounts.FilterVisited := lTree.NodeCount;
    lRecords := 0;
    qcCounts.FilterRemaining := lTree.LiveCount(lRecords);
    if lRecords > 0 then begin
      lFiltered := qcFile.RecordCount - Integer(lRecords);
      if (lFiltered > 0) and (lFiltered < qcFile.RecordCount) then
        Progress(Format('[%s] Filtered %.0n of %.0n records',
          [qcFile.FileName, Min(qcFile.RecordCount, lFiltered) + 0.0, qcFile.RecordCount + 0.0]));
    end;
  except
    on E: EAbort do begin
      Progress('Aborted: Applying Filter');
      raise;
    end;
    on E: Exception do begin
      Progress('Error during Applying Filter: ' + E.Message);
      raise;
    end;
  end;
  Progress('Done: Applying Filter, [Pass 1] Processed Records: ' + qcCounts.FilterVisited.ToString +
    ', [Pass 2] Processed Records: ' + qcCounts.FilterRemaining.ToString +
    ', Remaining unfiltered nodes: ' + qcCounts.FilterRemaining.ToString +
    ', Elapsed Time: ' + wbFormatElapsedTime(Now - lStart));
end;

procedure TwbQuickClean.Undelete;
var
  lStart     : TDateTime;
  lOperation : string;
  lPlugin    : string;
  lCRC32     : TwbCRC32;
  lCount     : Cardinal;
  lUndeleted : Cardinal;
  lNotUndeletable : Cardinal;
  lNavMeshes : Cardinal;

  procedure Walk(aNode: TwbCleanNode; aIsRoot: Boolean);
  var
    lRecord : IwbMainRecord;
  begin
    for var i := High(aNode.cnChildren) downto Low(aNode.cnChildren) do
      if not aNode.cnChildren[i].cnGone then
        Walk(aNode.cnChildren[i], False);
    if aIsRoot then
      Exit;
    wbTick;
    if Supports(aNode.cnElement, IwbMainRecord, lRecord) then begin
      if Assigned(lRecord._File) then begin
        lPlugin := lRecord._File.FileName;
        lCRC32 := lRecord._File.CRC32;
      end;
      case lRecord.UndeleteDecision of
        uoSkipNavMesh: begin
          Inc(lNavMeshes);
          Post('Skipping: ' + lRecord.Name);
        end;
        uoSkipOther: begin
          Inc(lNotUndeletable);
          Post('Skipping: ' + lRecord.Name);
        end;
        uoUndelete: begin
          Post(lOperation + 'ing: ' + lRecord.Name);
          if not CountOnly then
            lRecord.UndeleteAndDisable;
          Inc(lUndeleted);
        end;
      end;
    end;
    Inc(lCount);
  end;

begin
  if not CountOnly and not qcContext.Settings.EditAllowed then
    Exit;
  if qcContext.Settings.TranslationMode then
    Exit;
  if not Assigned(qcTree) then
    raise Exception.Create('Quick clean: Undelete needs a filtered tree; call Filter first');

  if CountOnly then
    lOperation := 'Count'
  else
    lOperation := 'Undelet';
  lStart := Now;
  lPlugin := '';
  lCRC32 := 0;
  lCount := 0;
  lUndeleted := 0;
  lNotUndeletable := 0;
  lNavMeshes := 0;

  Walk(TwbCleanNode(qcTree), True);

  Post('[' + lOperation + 'ing and Disabling References done] ' + ' Processed Records: ' + IntToStr(lCount) +
    ', ' + lOperation + 'ed Records: ' + IntToStr(lUndeleted) +
    ', Elapsed Time: ' + wbFormatElapsedTime(Now - lStart));
  if lNavMeshes > 0 then
    Post('<Warning: Plugin contains ' + IntToStr(lNavMeshes) + ' deleted NavMeshes which can not be undeleted>');
  if lNotUndeletable > 0 then
    Post('<Warning: Plugin contains ' + IntToStr(lNotUndeletable) + ' deleted references which can not be undeleted>');

  if lPlugin <> '' then begin
    var lInfo := wbDirtyInfoFor(qcDirtyInfos, lPlugin, lCRC32);
    lInfo.UDR := lUndeleted;
    lInfo.NAV := lNavMeshes;
  end;

  qcCounts.UndeleteProcessed := lCount;
  qcCounts.Undeleted := lUndeleted;
  qcCounts.DeletedNavMeshes := lNavMeshes;
  qcCounts.NotUndeletable := lNotUndeletable;
end;

procedure TwbQuickClean.RemoveIdentical;
var
  lStart     : TDateTime;
  lOperation : string;
  lPlugin    : string;
  lCRC32     : TwbCRC32;
  lCount     : Cardinal;
  lRemoved   : Cardinal;
  lAllowMakePartial : Boolean;

  procedure Walk(aNode: TwbCleanNode; aIsRoot: Boolean);
  begin
    for var i := High(aNode.cnChildren) downto Low(aNode.cnChildren) do
      if not aNode.cnChildren[i].cnGone then
        Walk(aNode.cnChildren[i], False);
    if aIsRoot then
      Exit;
    wbTick;
    var lAction := wbCleanDecide(aNode.cnElement, aNode.cnThis, aNode.cnOwn, aNode.LiveChildCount, lAllowMakePartial);
    if lAction <> qcKeep then begin
      var lIsRecord := Supports(aNode.cnElement, IwbMainRecord);
      if Assigned(aNode.cnElement._File) then begin
        lPlugin := aNode.cnElement._File.FileName;
        lCRC32 := aNode.cnElement._File.CRC32;
      end;
      if lAction = qcCantRemove then
        Post('Can''t remove: ' + aNode.cnElement.Name)
      else begin
        if CountOnly then
          Post(lOperation + 'ing: ' + aNode.cnElement.Name)
        else if lAction = qcMakePartial then begin
          Post('Making Partial Form: ' + aNode.cnElement.Name);
          wbCleanApply(lAction, aNode.cnElement, aNode.cnContainer);
        end else begin
          Post(lOperation + 'ing: ' + aNode.cnElement.Name);
          wbCleanApply(lAction, aNode.cnElement, aNode.cnContainer);
          aNode.cnGone := True;
        end;
        if lIsRecord then
          Inc(lRemoved);
      end;
    end;
    Inc(lCount);
  end;

begin
  if not CountOnly and not qcContext.Settings.EditAllowed then
    Exit;
  if qcContext.Settings.TranslationMode then
    Exit;
  if not Assigned(qcTree) then
    raise Exception.Create('Quick clean: Remove "Identical to Master" needs a filtered tree; call Filter first');

  if CountOnly then
    lOperation := 'Count'
  else
    lOperation := 'Remov';
  lAllowMakePartial := qcContext.Settings.AllowMakePartial;
  lStart := Now;
  lPlugin := '';
  lCRC32 := 0;
  lCount := 0;
  lRemoved := 0;

  Walk(TwbCleanNode(qcTree), True);

  Post('[' + lOperation + 'ing "Identical to Master" records done] ' + ' Processed Records: ' + IntToStr(lCount) +
    ', ' + lOperation + 'ed Records: ' + IntToStr(lRemoved) +
    ', Elapsed Time: ' + wbFormatElapsedTime(Now - lStart));

  if lPlugin <> '' then begin
    var lInfo := wbDirtyInfoFor(qcDirtyInfos, lPlugin, lCRC32);
    lInfo.ITM := lRemoved;
  end;

  qcCounts.RemoveProcessed := lCount;
  qcCounts.Removed := lRemoved;
end;

function TwbQuickClean.IsUnsaved: Boolean;
begin
  Result := esUnsaved in qcFile.ElementStates;
end;

procedure TwbQuickClean.Reset;
begin
  qcContext.ConflictRulesChanged;
end;

procedure TwbQuickClean.ReportDirtyInfo;
begin
  wbReportDirtyInfos(qcDirtyInfos, qcContext.GameDefObj, qcContext.GameDefObj.NexusModsUrl, Post);
end;

function TwbQuickClean.Run: Boolean;
var
  lWasUnsaved : Boolean;
begin
  Result := False;
  Filter;
  Undelete;
  RemoveIdentical;
  lWasUnsaved := IsUnsaved;
  if not Save then
    Exit;
  if lWasUnsaved then begin
    Reset;
    Filter;
    Undelete;
    RemoveIdentical;
    lWasUnsaved := IsUnsaved;
    if not Save then
      Exit;
    if lWasUnsaved then begin
      Filter;
      Undelete;
      RemoveIdentical;
    end;
  end;
  ReportDirtyInfo;
  Result := True;
end;

destructor TwbConflictTreeNode.Destroy;
begin
  for var lChild in tnChildren do
    lChild.Free;
  inherited;
end;

function TwbConflictTreeNode.GetChildCount: Integer;
begin
  if not tnCounted then begin
    var lCount: Cardinal := 0;
    if not Assigned(tnParent) then
      lCount := tnTree.ctRootCount
    else if cnsHasChildren in tnStates then begin
      if not Assigned(tnTree.ctView) then
        raise Exception.Create('The conflict view of this conflict tree has been freed');
      wbConflictInitChildren(@tnDatas[0], Length(tnDatas), lCount, tnTree.ctView, tnTree.ctOnMessage);
    end;
    SetLength(tnChildren, lCount);
    tnCounted := True;
  end;
  Result := Length(tnChildren);
end;

function TwbConflictTreeNode.GetChild(aIndex: Integer): TwbConflictTreeNode;
var
  lStates : TwbConflictNodeStates;
begin
  if (aIndex < 0) or (aIndex >= GetChildCount) then
    raise Exception.CreateFmt('Conflict tree row %d has no child row %d', [tnIndex, aIndex]);
  Result := tnChildren[aIndex];
  if not Assigned(Result) then begin
    Result := TwbConflictTreeNode.Create;
    Result.tnTree := tnTree;
    Result.tnParent := Self;
    Result.tnIndex := aIndex;
    SetLength(Result.tnDatas, Length(tnDatas));
    lStates := [];
    wbConflictInitNodes(@Result.tnDatas[0], @tnDatas[0], Length(tnDatas), aIndex, lStates, nil);
    Result.tnStates := lStates;
    tnChildren[aIndex] := Result;
  end;
end;

function TwbConflictTreeNode.RowElement(aColumn, aRow: Integer): IwbElement;
begin
  Result := nil;
  if (aRow >= 0) and (aRow < GetChildCount) then
    Result := wbConflictCellElement(tnDatas[aColumn], aRow);
end;

function TwbConflictTreeNode.IsAlignedGap(aColumn, aRow: Integer; out aMemoryIndex: Integer): Boolean;
begin
  GetChildCount;
  Result := wbConflictAlignedGap(tnDatas[aColumn], aRow, aMemoryIndex);
end;

function TwbConflictTreeNode.CanAssignAligned(aColumn, aRow: Integer; const aSource: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  lMemoryIndex : Integer;
begin
  Result := not tnTree.IsStale and IsAlignedGap(aColumn, aRow, lMemoryIndex);
  if Result then
    with tnDatas[aColumn] do
      if Assigned(aSource) then
        Result := Container.CanAssign(aRow - Container.AdditionalElementCount, aSource, aCheckDontShow)
      else
        Result := Container.CanAssignAligned(aRow - Container.AdditionalElementCount, aCheckDontShow);
end;

function TwbConflictTreeNode.AssignAligned(aColumn, aRow: Integer; const aSource: IwbElement; aOnlySK: Boolean): IwbElement;
var
  lMemoryIndex : Integer;
  lContainer   : IwbContainerElementRef;
begin
  Result := nil;
  if tnTree.IsStale or not IsAlignedGap(aColumn, aRow, lMemoryIndex) then
    Exit;
  lContainer := tnDatas[aColumn].Container;
  Result := wbConflictAssignAligned(lContainer, aRow - lContainer.AdditionalElementCount, lMemoryIndex, aSource, aOnlySK);
end;

function TwbConflictTreeNode.AddTarget(aColumn: Integer; out aRow: Integer): TwbConflictTreeNode;
begin
  aRow := -1;
  Result := Self;
  while Assigned(Result) do begin
    if Assigned(Result.tnDatas[aColumn].Element) then
      Exit;
    aRow := Result.tnIndex;
    Result := Result.tnParent;
  end;
  aRow := -1;
end;

constructor TwbConflictTree.CreateForMainRecord(aView: TwbConflictView; const aMainRecord: IwbMainRecord; const aFiles: TwbFiles;
  const aOnMessage: TwbConflictMessageProc);
var
  lMaster : IwbMainRecord;
  lCount  : Integer;
begin
  inherited Create;
  lMaster := aMainRecord.MasterOrSelf;
  lCount := 0;
  if Assigned(lMaster.Def) then
    lCount := (lMaster.Def as IwbRecordDef).MemberCount + lMaster.AdditionalElementCount;
  Setup(aView, aView.NodeDatasForMainRecord(aMainRecord, aFiles), False,
    lMaster.IsInjected and not ((lMaster.Signature = 'GMST') or (lMaster.Signature = 'DFOB')), lCount, aOnMessage);
  if not Assigned(lMaster.Def) then begin
    ctUndefinedChain := True;
    ctFiles := aFiles;
  end;
end;

constructor TwbConflictTree.CreateForRecords(aView: TwbConflictView; const aRecords: TDynMainRecords;
  const aOnMessage: TwbConflictMessageProc);
var
  lDatas : TwbDynConflictNodeDatas;
  lCount : Integer;
begin
  inherited Create;
  if Length(aRecords) < 1 then
    raise Exception.Create('A conflict tree needs at least one record');
  SetLength(lDatas, Length(aRecords));
  for var i := Low(aRecords) to High(aRecords) do begin
    lDatas[i].Element := aRecords[i];
    lDatas[i].Container := aRecords[i] as IwbContainerElementRef;
    lDatas[i].Container.ElementCount;
  end;
  lCount := 0;
  if Assigned(aRecords[0].Def) then
    lCount := (aRecords[0].Def as IwbRecordDef).MemberCount + aRecords[0].AdditionalElementCount;
  Setup(aView, lDatas, True, False, lCount, aOnMessage);
end;

function ContainerRootCount(const aContainer: IwbContainer): Integer;
begin
  if Supports(aContainer.Def, IwbStructDef) then
    Result := (aContainer.Def as IwbStructDef).MemberCount + aContainer.AdditionalElementCount
  else
    Result := 1;
end;

constructor TwbConflictTree.CreateForElement(aView: TwbConflictView; const aElement: IwbElement;
  const aOnMessage: TwbConflictMessageProc);
var
  lDatas  : TwbDynConflictNodeDatas;
  lRecord : IwbMainRecord;
  lCount  : Integer;
begin
  inherited Create;
  SetLength(lDatas, 1);
  lDatas[0].Element := aElement;
  lDatas[0].Container := aElement as IwbContainerElementRef;
  if Supports(aElement, IwbMainRecord, lRecord) then begin
    lCount := 0;
    if Assigned(lRecord.Def) then
      lCount := (lRecord.Def as IwbRecordDef).MemberCount + lRecord.AdditionalElementCount;
    Setup(aView, lDatas, False, lRecord.IsInjected and not ((lRecord.Signature = 'GMST') or (lRecord.Signature = 'DFOB')),
      lCount, aOnMessage);
  end else
    Setup(aView, lDatas, False, False, ContainerRootCount(aElement as IwbContainer), aOnMessage);
end;

constructor TwbConflictTree.CreateForContainer(aView: TwbConflictView; const aContainer: IwbDataContainer; const aFiles: TwbFiles;
  const aOnMessage: TwbConflictMessageProc);
begin
  inherited Create;
  Assert(aView.Context.LoaderDone);
  Setup(aView, wbConflictNodeDatasForContainer(aContainer, aFiles), False, False, ContainerRootCount(aContainer), aOnMessage);
end;

procedure TwbConflictTree.SettleDenseIDs(aView: TwbConflictView; const aRootDatas: TwbDynConflictNodeDatas);
var
  lMasters : TDynMainRecords;
  lRecords : TDynMainRecords;
  lCount   : Integer;
  lRecord  : IwbMainRecord;

  procedure AddChain(const aRecord: IwbMainRecord);
  begin
    var lMaster := aRecord.MasterOrSelf;
    for var lKnown in lMasters do
      if lKnown.Equals(lMaster) then
        Exit;
    lMasters := lMasters + [lMaster];
    if lCount + 1 + lMaster.OverrideCount > Length(lRecords) then
      SetLength(lRecords, 2 * (lCount + 1 + lMaster.OverrideCount));
    lRecords[lCount] := lMaster;
    Inc(lCount);
    for var i := 0 to Pred(lMaster.OverrideCount) do begin
      lRecords[lCount] := lMaster.Overrides[i];
      Inc(lCount);
    end;
  end;

begin
  lCount := 0;
  for var i := Low(aRootDatas) to High(aRootDatas) do
    if Supports(aRootDatas[i].Element, IwbMainRecord, lRecord) and (lRecord.ContextObj = aView.Context) then
      AddChain(lRecord);
  SetLength(lRecords, lCount);
  for lRecord in lRecords do
    if lRecord.DenseIDIn(aView.Context) = 0 then begin
      aView.Context.AllocateDenseIDs(lRecords);
      Exit;
    end;
end;

procedure TwbConflictTree.Setup(aView: TwbConflictView; const aRootDatas: TwbDynConflictNodeDatas; aSiblingCompare, aInjected: Boolean;
  aRootCount: Integer; const aOnMessage: TwbConflictMessageProc);
var
  lRecord : IwbMainRecord;
begin
  if aView.Context.LoaderDone then
    SettleDenseIDs(aView, aRootDatas);
  ctView := aView;
  ctContextRef := aView.cvContextRef;
  aView.cvTrees.Add(Self);
  ctEpoch := aView.Epoch;
  ctFileCount := aView.cvContextRef.FileCount;
  ctSiblingCompare := aSiblingCompare;
  ctInjected := aInjected;
  ctRootCount := aRootCount;
  ctOnMessage := aOnMessage;
  ctRoot := TwbConflictTreeNode.Create;
  ctRoot.tnTree := Self;
  ctRoot.tnIndex := -1;
  ctRoot.tnDatas := aRootDatas;
  SetLength(ctStamps, Length(aRootDatas));
  for var i := Low(aRootDatas) to High(aRootDatas) do
    with ctRoot.tnDatas[i] do begin
      if Supports(Element, IwbMainRecord, lRecord) then
        ctStamps[i] := lRecord.ChainStamp;
      if Assigned(Element) then
        ElementGen := Element.ElementGeneration;
      if Assigned(Container) then
        ContainerGen := Container.ElementGeneration;
    end;
end;

destructor TwbConflictTree.Destroy;
begin
  if Assigned(ctView) then
    ctView.cvTrees.Remove(Self);
  ctRoot.Free;
  inherited;
end;

function TwbConflictTree.IsStale: Boolean;
var
  lRecord : IwbMainRecord;
begin
  if not Assigned(ctView) or (ctView.Epoch <> ctEpoch) or (ctView.cvContextRef.FileCount <> ctFileCount) then
    Exit(True);
  for var i := Low(ctRoot.tnDatas) to High(ctRoot.tnDatas) do
    with ctRoot.tnDatas[i] do begin
      if Supports(Element, IwbMainRecord, lRecord) and (lRecord.ChainStamp <> ctStamps[i]) then
        Exit(True);
      if Assigned(Element) and (Element.ElementGeneration <> ElementGen) then
        Exit(True);
      if Assigned(Container) and (Container.ElementGeneration <> ContainerGen) then
        Exit(True);
    end;
  Result := False;
end;

procedure TwbConflictTree.Resolve(aHideNoConflict: Boolean);
begin
  if not Assigned(ctView) then
    raise Exception.Create('The conflict view of this conflict tree has been freed');
  ctHideNoConflict := aHideNoConflict;
  if ctUndefinedChain then
    ResolveUndefinedChain
  else
    ResolveNode(ctRoot);
  for var i := Low(ctRoot.tnDatas) to High(ctRoot.tnDatas) do
    with ctRoot.tnDatas[i] do begin
      if Assigned(Element) then
        ElementGen := Element.ElementGeneration;
      if Assigned(Container) then
        ContainerGen := Container.ElementGeneration;
    end;
end;

procedure TwbConflictTree.ResolveUndefinedChain;
var
  lRecord       : IwbMainRecord;
  lConflictAll  : TConflictAll;
  lConflictThis : TConflictThis;
  lChainAll     : TConflictAll;
begin
  lChainAll := caUnknown;
  for var i := Low(ctRoot.tnDatas) to High(ctRoot.tnDatas) do
    if Supports(ctRoot.tnDatas[i].Element, IwbMainRecord, lRecord) then begin
      ctView.LevelForMainRecord(lRecord, ctFiles, ctOnMessage, lConflictAll, lConflictThis);
      ctRoot.tnDatas[i].ConflictThis := lConflictThis;
      if lConflictAll > lChainAll then
        lChainAll := lConflictAll;
    end;
  for var i := Low(ctRoot.tnDatas) to High(ctRoot.tnDatas) do
    ctRoot.tnDatas[i].ConflictAll := lChainAll;
end;

procedure TwbConflictTree.ResolveNode(aNode: TwbConflictTreeNode);
var
  lDatas          : TwbDynConflictNodeDatas;
  lChild          : TwbConflictTreeNode;
  lConflictAll    : TConflictAll;
  lConflictThis   : TConflictThis;
  lHasElement     : Boolean;
  lTranslation    : Boolean;
  lHideIgnored    : Boolean;
  lDontShow       : Boolean;
  lVisible        : Boolean;
  lParentDatas    : TwbDynConflictNodeDatas;
  lElement        : IwbElement;
  lMemberCount    : Integer;
  lAdditional     : Integer;
begin
  lDatas := aNode.tnDatas;
  if aNode.ChildCount = 0 then
    lDatas[0].ConflictAll := wbConflictLevelForNodeDatas(@lDatas[0], Length(lDatas), ctSiblingCompare, ctInjected)
  else
    for var c := 0 to Pred(aNode.ChildCount) do begin
      lChild := aNode.Children[c];
      ResolveNode(lChild);
      for var i := Low(lDatas) to High(lDatas) do begin
        if lChild.tnDatas[i].ConflictAll > lDatas[i].ConflictAll then
          lDatas[i].ConflictAll := lChild.tnDatas[i].ConflictAll;
        if lChild.tnDatas[i].ConflictThis > lDatas[i].ConflictThis then
          lDatas[i].ConflictThis := lChild.tnDatas[i].ConflictThis;
      end;
    end;

  lConflictAll := caUnknown;
  lConflictThis := ctUnknown;
  lHasElement := False;
  for var i := Low(lDatas) to High(lDatas) do begin
    lHasElement := lHasElement or Assigned(lDatas[i].Element);
    if lDatas[i].ConflictAll > lConflictAll then
      lConflictAll := lDatas[i].ConflictAll;
    if lDatas[i].ConflictThis > lConflictThis then
      lConflictThis := lDatas[i].ConflictThis;
  end;

  lTranslation := ctView.Context.Settings.TranslationMode;
  if not lHasElement and lTranslation then
    lConflictThis := ctIgnored;

  if (lConflictAll in [caUnknown, caOnlyOne]) and ctSiblingCompare then
    lConflictAll := caNoConflict;

  for var i := Low(lDatas) to High(lDatas) do
    lDatas[i].ConflictAll := lConflictAll;

  if not Assigned(aNode.tnParent) then
    Exit;

  lHideIgnored := ctView.Context.Settings.HideIgnored;
  lDontShow := False;
  for var i := Low(lDatas) to High(lDatas) do begin
    if vnfDontShow in lDatas[i].ViewNodeFlags then
      lDontShow := True;
    if Assigned(lDatas[i].Container) then begin
      lDontShow := False;
      Break;
    end;
  end;

  case lConflictThis of
    ctUnknown: lVisible := not lDontShow and not lTranslation;
    ctIgnored: lVisible := not lHideIgnored;
    ctNotDefined: begin
        lParentDatas := aNode.tnParent.tnDatas;

        lElement := nil;
        for var i := Low(lParentDatas) to High(lParentDatas) do begin
          lElement := lParentDatas[i].Container;
          if Assigned(lElement) then
            Break;
        end;

        if Assigned(lElement) and (lElement.ElementType in [etMainRecord, etSubRecordStruct]) then begin
          lMemberCount := (lElement.Def as IwbRecordDef).MemberCount;
          lAdditional := (lElement as IwbContainer).AdditionalElementCount;
          if (aNode.tnIndex >= lAdditional) and (aNode.tnIndex - lAdditional < lMemberCount) then
            with (lElement.Def as IwbRecordDef).Members[aNode.tnIndex - lAdditional] do begin
              if (lTranslation and not (dfTranslatable in DefFlags)) or (lTranslation and (ConflictPriority[nil] = cpIgnore)) then begin
                lConflictThis := ctIgnored;
                for var k := Low(lDatas) to High(lDatas) do
                  lDatas[k].ConflictThis := lConflictThis;
              end;

              if (lConflictThis <> ctIgnored) and HasDontShow then begin
                lDontShow := True;
                for var k := Low(lParentDatas) to High(lParentDatas) do begin
                  lElement := lParentDatas[k].Container;
                  if Assigned(lElement) then begin
                    lDontShow := DontShow[lElement];
                    if not lDontShow then
                      Break;
                  end;
                end;
              end;
            end;
        end;

        if not Assigned(lElement) then
          if lTranslation then
            lConflictThis := ctIgnored;

        if lConflictThis = ctNotDefined then begin
          for var i := Low(lParentDatas) to High(lParentDatas) do begin
            lElement := lParentDatas[i].Container;
            if Assigned(lElement) then
              Break;
          end;
          if Assigned(lElement) and (lElement.ElementType in [etMainRecord, etSubRecordStruct]) then begin
            lMemberCount := (lElement.Def as IwbRecordDef).MemberCount;
            lAdditional := (lElement as IwbContainer).AdditionalElementCount;
            if (aNode.tnIndex >= lAdditional) and (aNode.tnIndex - lAdditional < lMemberCount) then
              with (lElement.Def as IwbRecordDef).Members[aNode.tnIndex - lAdditional] do
                if ConflictPriority[nil] = cpIgnore then
                  lConflictThis := ctIgnored;
          end;
        end;

        lVisible := ((lConflictThis <> ctIgnored) or not lHideIgnored) and not lDontShow;
      end;
  else
    lVisible := not lDontShow;
  end;

  if lVisible then
    if ctHideNoConflict then
      if Length(lDatas) > 1 then begin
        if ctSiblingCompare then begin
          if lConflictAll < caConflictBenign then
            lVisible := False;
        end else begin
          if lConflictThis < ctOverride then
            lVisible := False;
        end;
      end else
        if not lHasElement then
          lVisible := False;

  aNode.tnVisible := lVisible;
end;

function TwbConflictTree.NodeFor(const aElement: IwbElement; out aColumn: Integer): TwbConflictTreeNode;
var
  lPath    : TDynElements;
  lElement : IwbElement;
  lNode    : TwbConflictTreeNode;
  lFound   : Integer;
begin
  Result := nil;
  aColumn := -1;
  lPath := nil;
  lElement := aElement;
  while Assigned(lElement) do begin
    for var i := Low(ctRoot.tnDatas) to High(ctRoot.tnDatas) do
      if Assigned(ctRoot.tnDatas[i].Element) and ctRoot.tnDatas[i].Element.Equals(lElement) then begin
        aColumn := i;
        Break;
      end;
    if aColumn >= 0 then
      Break;
    lPath := [lElement] + lPath;
    lElement := lElement.Container;
  end;
  if aColumn < 0 then
    Exit;

  lNode := ctRoot;
  for var lStep in lPath do begin
    lFound := -1;
    for var r := 0 to Pred(lNode.ChildCount) do begin
      lElement := wbConflictCellElement(lNode.tnDatas[aColumn], r);
      if Assigned(lElement) and lElement.Equals(lStep) then begin
        lFound := r;
        Break;
      end;
    end;
    if lFound < 0 then begin
      aColumn := -1;
      Exit;
    end;
    lNode := lNode.Children[lFound];
  end;
  Result := lNode;
end;

end.
