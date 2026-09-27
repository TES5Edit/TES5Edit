unit wbConflict;

interface

uses
  wbInterface;

type
  TwbConflictEntry = record
    Stamp        : Cardinal;
    Epoch        : Cardinal;
    ConflictAll  : TConflictAll;
    ConflictThis : TConflictThis;
  end;

  TwbConflictView = class
  private
    cvContextRef         : IwbGameContext;
    cvQuickShowConflicts : Boolean;
    cvOnlyMasterAndLeafs : Boolean;
    cvModGroupsEnabled   : Boolean;
    cvAlignArrayElements : Boolean;
    cvAlignArrayLimit    : Integer;
    cvEpoch              : Cardinal;
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
    procedure RulesChanged;
    procedure Peek(const aRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
    property QuickShowConflicts: Boolean read cvQuickShowConflicts write SetQuickShowConflicts;
    property OnlyMasterAndLeafs: Boolean read cvOnlyMasterAndLeafs write SetOnlyMasterAndLeafs;
    property ModGroupsEnabled: Boolean read cvModGroupsEnabled write SetModGroupsEnabled;
    property AlignArrayElements: Boolean read cvAlignArrayElements write SetAlignArrayElements;
    property AlignArrayLimit: Integer read cvAlignArrayLimit write SetAlignArrayLimit;
    property Epoch: Cardinal read cvEpoch;
  end;

function wbConflictLevelForNodeDatas(const aNodeDatas: PwbConflictNodeDatas; aNodeCount: Integer; aSiblingCompare, aInjected: Boolean): TConflictAll;

procedure wbConflictInitNodes(const aNodeDatas: PwbConflictNodeDatas;
  const aParentDatas: PwbConflictNodeDatas;
  aNodeCount: Integer;
  aIndex: Cardinal;
  var aStates: TwbConflictNodeStates;
  const aOnElement: TwbConflictElementProc);

procedure wbConflictInitChildren(const aNodeDatas: PwbConflictNodeDatas; aNodeCount: Integer;
  var aChildCount: Cardinal; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc);

function wbConflictLevelForChildNodeDatas(const aNodeDatas: TwbDynConflictNodeDatas; aSiblingCompare, aInjected: Boolean; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc; const aOnField: TwbFieldConflictProc = nil): TConflictAll;

function wbConflictNodeDatasForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles; aView: TwbConflictView): TwbDynConflictNodeDatas;

procedure wbConflictLevelForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);

implementation

uses
  System.SysUtils,
  System.Classes,
  System.Math,
  wbBetterStringList,
  wbImplementation,
  wbLoadOrder,
  wbDiff;

constructor TwbConflictView.Create(aContext: TwbGameContext);
begin
  inherited Create;
  Context := aContext;
  cvContextRef := aContext;
  cvAlignArrayElements := True;
  cvAlignArrayLimit := 5000;
  cvEpoch := 1;
end;

procedure TwbConflictView.RulesChanged;
begin
  Inc(cvEpoch);
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
  SortableContainer           : IwbSortableContainer;
  i                           : Integer;
begin
  for i := 0 to Pred(aNodeCount) do begin
    NodeData := @aNodeDatas[i];
    ParentData := @aParentDatas[i];

    Container := ParentData.Container;
    if Assigned(Container) then begin
      if (vnfUseSortOrder in ParentData.ViewNodeFlags) or (Supports(Container, IwbSortableContainer, SortableContainer) and SortableContainer.Sorted) then
        NodeData.Element := Container.ElementBySortOrder[aIndex]
      else
        case Container.ElementType of
          etMainRecord, etSubRecordStruct:
            NodeData.Element := Container.ElementBySortOrder[aIndex];
          etSubRecordArray, etArray, etStruct, etSubRecord, etValue, etUnion, etStructChapter:
            if aIndex < Cardinal(Container.ElementCount) then
              NodeData.Element := Container.Elements[aIndex];
        end;
    end;
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

      for j := 0 to Pred(aChildCount) do begin
        SortKey := SortedKeys[aNodeCount].Strings[j];
        for i := 0 to Pred(aNodeCount) do
          if SortedKeys[i].Find(SortKey, k) then
            IwbElement(Pointer(SortedKeys[i].Objects[k])).SortOrder := j;
      end;

      for i := 0 to Pred(aNodeCount) do begin
        NodeData := @aNodeDatas[i];
        if Assigned(NodeData.Container) then
          NodeData.Container.SetIsSortedBySortOrder(False);
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
            etMainRecord, etSubRecordStruct: begin
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
                      if aChildCount < Count then
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
              for j := Low(KeyedElements[i]) to High(KeyedElements[i]) do
                if Assigned(KeyedElements[i, j]) then
                  IwbElement(KeyedElements[i, j]).SortOrder := j;
              if Assigned(NodeData.Container) then
                NodeData.Container.SetIsSortedBySortOrder(True);
            end;
          end;
        end;
      end;

    finally
      AllKeys.Free;
    end;
  end;
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

function wbConflictNodeDatasForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles; aView: TwbConflictView): TwbDynConflictNodeDatas;
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

    if aView.OnlyMasterAndLeafs then begin
      MainRecords := Master.MasterAndLeafs;
    end else begin
      SetLength(MainRecords, Succ(Master.OverrideCount));
      MainRecords[0] := Master;
      for i := 0 to Pred(Master.OverrideCount) do
        MainRecords[Succ(i)] := Master.Overrides[i];
    end;
  end;

  if aView.ModGroupsEnabled and (Length(MainRecords) > 2) then begin
    SetLength(Modules, Length(MainRecords));
    for i := Low(MainRecords) to High(MainRecords) do begin
      Modules[i] := MainRecords[i]._File.ModuleInfo;
      if Assigned(Modules[i]) then
        Exclude(Modules[i].miFlags, mfEphemeralModGroupTagged);
    end;
    FirstModule := nil;
    LastModule := nil;
    for i := Low(Modules) to High(Modules) do
      if Assigned(Modules[i]) then begin
        if not Assigned(FirstModule) then
          FirstModule := Modules[i];
        with Modules[i]^ do
          for j := Low(miModGroupTargets) to High(miModGroupTargets) do
            Include(miModGroupTargets[j].miFlags, mfEphemeralModGroupTagged);
        LastModule := Modules[i];
      end;

    if Assigned(FirstModule) then
      Exclude(FirstModule.miFlags, mfEphemeralModGroupTagged);
    if Assigned(LastModule) then
      Exclude(LastModule.miFlags, mfEphemeralModGroupTagged);

    j := 0;
    for i := Low(Modules) to High(Modules) do
      if not Assigned(Modules[i]) or not (mfEphemeralModGroupTagged in Modules[i].miFlags) then begin
        if i <> j then
          MainRecords[j] := MainRecords[i];
        Inc(j);
      end;
    SetLength(MainRecords, j);
  end;

  j := 0;
  for i := Low(MainRecords) to High(MainRecords) do
    if not MainRecords[i].IsHidden then begin
      if i <> j then
        MainRecords[j] := MainRecords[i];
      Inc(j);
    end;
  SetLength(MainRecords, j);

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

procedure wbConflictLevelForMainRecord(const aMainRecord: IwbMainRecord; const aFiles: TwbFiles; aView: TwbConflictView; const aOnMessage: TwbConflictMessageProc; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
var
  ThisConflict                : TConflictThis;

  procedure Put(const aRecord: IwbMainRecord; aAll: TConflictAll; aThis: TConflictThis);
  begin
    aView.Store(aRecord, aAll, aThis);
    if aRecord.Equals(aMainRecord) then
      ThisConflict := aThis;
  end;

  procedure Fix(const aRecord: IwbMainRecord);
  var
    lAll  : TConflictAll;
    lThis : TConflictThis;
  begin
    aView.Lookup(aRecord, lAll, lThis);
    if lThis = ctUnknown then
      lThis := ctHiddenByModGroup;
    Put(aRecord, aConflictAll, lThis);
  end;

  procedure Allocate(const aRecords: TDynMainRecords);
  begin
    for var lRecord in aRecords do
      if lRecord.DenseIDIn(aView.Context) = 0 then begin
        aView.Context.AllocateDenseIDs(aRecords);
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

  aView.Lookup(aMainRecord, aConflictAll, aConflictThis);

  if aConflictAll > caUnknown then begin
    Inc(aView.Hits);
    Exit;
  end;
  Inc(aView.Misses);

  TranslationMode := aView.Context.Settings.TranslationMode;
  Master := aMainRecord.MasterOrSelf;
  if (Master.OverrideCount = 0) and not TranslationMode and not ((Master.Signature = 'GMST') or (Master.Signature = 'DFOB')) then begin
    aConflictAll := caOnlyOne;
    aConflictThis := ctOnlyOne;
    Allocate([aMainRecord]);
    aView.Store(aMainRecord, aConflictAll, aConflictThis);
  end else begin
    NodeDatas := wbConflictNodeDatasForMainRecord(aMainRecord, aFiles, aView);
    if (Length(NodeDatas) = 1) and not TranslationMode then begin
      aConflictAll := caOnlyOne;
      NodeDatas[0].ConflictAll := caOnlyOne;
      NodeDatas[0].ConflictThis := ctOnlyOne;
    end else if Length(NodeDatas) = 2 then begin
      if aView.QuickShowConflicts then begin
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
        aConflictAll := wbConflictLevelForChildNodeDatas(NodeDatas, False, (aMainRecord.MasterOrSelf.IsInjected and not ((aMainRecord.Signature = 'GMST') or (aMainRecord.Signature = 'DFOB')) ), aView, aOnMessage);
    end else
      aConflictAll := wbConflictLevelForChildNodeDatas(NodeDatas, False, (aMainRecord.MasterOrSelf.IsInjected and not ((aMainRecord.Signature = 'GMST') or (aMainRecord.Signature = 'DFOB')) ), aView, aOnMessage);

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
      if Assigned(NodeDatas[i].Element) then
        Put(NodeDatas[i].Element as IwbMainRecord, aConflictAll, NodeDatas[i].ConflictThis);

    Fix(Master);
    for i := 0 to Pred(Master.OverrideCount) do
      Fix(Master.Overrides[i]);

    aConflictThis := ThisConflict;
  end;
end;

end.
