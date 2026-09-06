unit wbDataFormatWwise;

interface

uses
  System.Classes,

  wbInterface;

type
  IwbSoundBankArray = interface(IInterface)
  ['{5FEF18BF-C357-4B8A-9DBB-6F6D58923F89}']
    function TryLookupGUID(const aNodeType : TwbWwiseNodeType;
                           const aGUID     : TGUID;
                             var aName     : string;
                             var aFilename : string)
                                           : Boolean;

    function TryLookupDisplay(const aNodeType   : TwbWwiseNodeType;
                              const aDisplayStr : string;
                                var aGUID       : TGUID)
                                                : Boolean;

    procedure GetChildStrings(const aParentGUID: TGUID;
                              const aChildType: TwbWwiseNodeType;
                                var aList: TStringList);

    procedure GetStrings(const aNodeType : TwbWwiseNodeType;
                         const aMasters  : TStringList;
                           var aList     : TStringList);
  end;

var
  wbSoundBankCache: IwbSoundBankArray;

procedure wbBuildSoundBankCache(const aLoadOrder: TStringList);

implementation

uses
  System.Generics.Collections,
  System.Generics.Defaults,
  System.IOUtils,
  System.SysUtils,

  JsonDataObjects,

  wbHash;

type
  TwbSoundBankArray = class;

  TwbWwiseObject = class
  public
    FGUID: TGUID;
    FName: string;
    FParent: TwbWwiseObject;
    FRoot: TwbSoundBankArray;

    function DisplayName: string; virtual;
  end;

  TwbActionSetState = class(TwbWwiseObject) end;
  TwbActionPostEvent = class(TwbWwiseObject) end;
  TwbAuxBusSend = class(TwbWwiseObject) end;
  TwbExternalSource = class(TwbWwiseObject) end;
  TwbGameParameter = class(TwbWwiseObject) end;
  TwbIncludedAuxBuss = class(TwbWwiseObject) end;

  TwbGroupMember = class(TwbWwiseObject)
    function DisplayName: string; override;
  end;

  TwbSwitch = class(TwbGroupMember) end;
  TwbState = class(TwbGroupMember) end;

  TwbSwitchGroup = class(TwbWwiseObject)
  public
    FSwitches: TArray<TwbSwitch>;

    procedure BuildSwitchGroup(const aSwitchGroup: TJSONArray; var aCount: Integer; const aBankFilename: string);
  end;

  TwbStateGroup = class(TwbWwiseObject)
  public
    FStates: TArray<TwbState>;

    procedure BuildStateGroup(const aStateGroup: TJSONArray; var aCount: Integer; const aBankFilename: string);
  end;

  TwbIncludedEvent = class(TwbWwiseObject)
  public
    FActionSetStates: TArray<TwbActionSetState>;
    FActionPostEvents: TArray<TwbActionPostEvent>;
    FAuxBusSends: TArray<TwbAuxBusSend>;

    procedure BuildEvent(const aEvent: TJSONObject; var aCount: Integer; const aBankFilename: string);
  end;

  TwbSoundBank = class(TwbWwiseObject)
  public
    FFilename: string;
    FIncludedEvents: TArray<TwbIncludedEvent>;
    FGameParameters: TArray<TwbGameParameter>;
    FStateGroups: TArray<TwbStateGroup>;
    FSwitchGroups: TArray<TwbSwitchGroup>;
    FIncludedAuxBusses: TArray<TwbIncludedAuxBuss>;
    FExternalSources: TArray<TwbExternalSource>;

    procedure BuildSoundBank(const aSoundBank: TJSONObject; var aCount: Integer; const aBankFilename: string);
  end;

  TwbPendingNode = record
    NodeType: TwbWwiseNodeType;
    Node: TwbWwiseObject;
    BankFilename: string;
  end;

  TwbSoundBankArray = class(TInterfacedObject, IwbSoundBankArray)
  strict private
    {---IwbSoundBankArray---}
    function TryLookupDisplay(const aNodeType   : TwbWwiseNodeType;
                              const aDisplayStr : string;
                                var aGUID       : TGUID)
                                                : Boolean;

    function TryLookupGUID(const aNodeType : TwbWwiseNodeType;
                           const aGUID     : TGUID;
                             var aName     : string;
                             var aFilename : string)
                                           : Boolean;

    procedure GetChildStrings(const aParentGUID: TGUID;
                              const aChildType: TwbWwiseNodeType;
                                var aList: TStringList);

    procedure GetStrings(const aNodeType : TwbWwiseNodeType;
                         const aMasters  : TStringList;
                           var aList     : TStringList);


    {---TwbSoundBankArray---}
    var FComboBoxMap: TDictionary<string, TDictionary<TwbWwiseNodeType, TStringList>>;
    var FDisplayMap: TDictionary<TwbWwiseNodeType, TDictionary<string, TGUID>>;
    var FGuidMap: TDictionary<TwbWwiseNodeType, TDictionary<TGUID, TwbWwiseObject>>;
    var FSoundBanks: TArray<TwbSoundBank>;
    var FOwned: TObjectDictionary<TwbWwiseObject, Boolean>;
    var FPending: TList<TwbPendingNode>;

    procedure BuildIndexFile(const aFileName, aModuleName: string);
    procedure BuildIndexFiles(const aFileNames: TStringList; const aModuleName: string = '');
    procedure BuildSoundBanks(const aJSON: TJSONObject; const aModuleName: string; var aCount: Integer);
    procedure IndexNode(const aNodeType: TwbWwiseNodeType; const aObject: TwbWwiseObject; const aBankFileName: string);

  public
    {---TwbSoundBankArray---}
    constructor Create; overload;
    constructor Create(const aLoadOrder: TStringList); overload;

    destructor Destroy; override;

    procedure BuildIndex(const aLoadOrder: TStringList);

    procedure RegisterNode(const aNodeType: TwbWwiseNodeType; const aObject: TwbWwiseObject; const aBankFileName: string);
  end;

procedure wbBuildSoundBankCache(const aLoadOrder: TStringList);
begin
  wbSoundBankCache := TwbSoundBankArray.Create(aLoadOrder);
end;

{ TwbSwitchGroup }

procedure TwbSwitchGroup.BuildSwitchGroup(const aSwitchGroup: TJSONArray; var aCount: Integer; const aBankFilename: string);
begin
  if aSwitchGroup.Count = 0 then
    Exit;

  SetLength(FSwitches, aSwitchGroup.Count);

  for var I := 0 to Pred(aSwitchGroup.Count) do
  begin
    var lObject := aSwitchGroup[I];
    var lGUID := StringToGUID(lObject.S['GUID']);
    var lName := lObject.S['Name'];
    FSwitches[I] := TwbSwitch.Create;

    with FSwitches[I] do
    begin
      FGUID := lGUID;
      FName := lName;
      FParent := Self;
      FRoot := FParent.FRoot;

      FRoot.RegisterNode(wntSwitch, FSwitches[I], aBankFilename);
    end;
  end;

  Inc(aCount, aSwitchGroup.Count);
  //wbProgress('Processed [%d] Switches', [aSwitchGroup.Count]);
end;

{ TwbStateGroup }

procedure TwbStateGroup.BuildStateGroup(const aStateGroup: TJSONArray; var aCount: Integer; const aBankFilename: string);
begin
  if aStateGroup.Count = 0 then
    Exit;

  SetLength(FStates, aStateGroup.Count);

  for var I := 0 to Pred(aStateGroup.Count) do
  begin
    var lObject := aStateGroup[I];
    var lGUID := StringToGUID(lObject.S['GUID']);
    var lName := lObject.S['Name'];
    FStates[I] := TwbState.Create;

    with FStates[I] do
    begin
      FGUID := lGUID;
      FName := lName;
      FParent := Self;
      FRoot := FParent.FRoot;

      FRoot.RegisterNode(wntState, FStates[I], aBankFilename);
    end;
  end;

  Inc(aCount, aStateGroup.Count);
  //wbProgress('Processed [%d] States', [aStateGroup.Count]);
end;

{ TwbWwiseObject }

function TwbWwiseObject.DisplayName: string;
begin
  Result := FName;
end;

{ TwbGroupMember }

function TwbGroupMember.DisplayName: string;
begin
  Result := Format('%s [%s]', [FName, FParent.FName]);
end;

{ TwbIncludedEvent }

procedure TwbIncludedEvent.BuildEvent(const aEvent: TJSONObject; var aCount: Integer; const aBankFilename: string);
begin
  var lArray := aEvent.A['ActionSetStates'];
  if lArray.Count > 0 then
  begin
    var lArrayCount := lArray.Count;
    SetLength(FActionSetStates, lArrayCount);

    for var I := 0 to Pred(lArrayCount) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FActionSetStates[I] := TwbActionSetState.Create;

      with FActionSetStates[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntActionSetState, FActionSetStates[I], aBankFilename)
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] ActionSetStates', [lArray.Count]);
  end;

  lArray := aEvent.A['ActionPostEvents'];
  if lArray.Count > 0 then
  begin
    var lArrayCount := lArray.Count;
    SetLength(FActionPostEvents, lArrayCount);

    for var I := 0 to Pred(lArrayCount) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FActionPostEvents[I] := TwbActionPostEvent.Create;

      with FActionPostEvents[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntActionPostEvent, FActionPostEvents[I], aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] ActionPostEvents', [lArray.Count]);
  end;

  lArray := aEvent.A['AuxBusSends'];
  if lArray.Count > 0 then
  begin
    var lArrayCount := lArray.Count;
    SetLength(FAuxBusSends, lArrayCount);

    for var I := 0 to Pred(lArrayCount) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FAuxBusSends[I] := TwbAuxBusSend.Create;

      with FAuxBusSends[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntAuxBusSend, FAuxBusSends[I], aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] AuxBusSends', [lArray.Count]);
  end;
end;

{ TwbSoundBank }

procedure TwbSoundBank.BuildSoundBank(const aSoundBank: TJSONObject; var aCount: Integer; const aBankFilename: string);
begin
  var lArray := aSoundBank.A['IncludedEvents'];
  if lArray.Count > 0 then
  begin
    SetLength(FIncludedEvents, lArray.Count);

    for var I := 0 to Pred(lArray.Count) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FIncludedEvents[I] := TwbIncludedEvent.Create;

      with FIncludedEvents[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntIncludedEvent, FIncludedEvents[I], aBankFilename);

        BuildEvent(lObject, aCount, aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] IncludedEvents', [lArray.Count]);
  end;

  lArray := aSoundBank.A['GameParameters'];
  if lArray.Count > 0 then
  begin
    SetLength(FGameParameters, lArray.Count);

    for var I := 0 to Pred(lArray.Count) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FGameParameters[I] := TwbGameParameter.Create;

      with FGameParameters[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntGameParameter, FGameParameters[I], aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] GameParameters', [lArray.Count]);
  end;

  lArray := aSoundBank.A['StateGroups'];
  if lArray.Count > 0 then
  begin
    SetLength(FStateGroups, lArray.Count);

    for var I := 0 to Pred(lArray.Count) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FStateGroups[I] := TwbStateGroup.Create;

      with FStateGroups[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntStateGroup, FStateGroups[I], aBankFilename);

        BuildStateGroup(lObject.A['States'], aCount, aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] StateGroups', [lArray.Count]);
  end;

  lArray := aSoundBank.A['SwitchGroups'];
  if lArray.Count > 0 then
  begin
    SetLength(FSwitchGroups, lArray.Count);

    for var I := 0 to Pred(lArray.Count) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FSwitchGroups[I] := TwbSwitchGroup.Create;

      with FSwitchGroups[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntSwitchGroup, FSwitchGroups[I], aBankFilename);

        BuildSwitchGroup(lObject.A['Switches'], aCount, aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] SwitchGroups', [lArray.Count]);
  end;

  lArray := aSoundBank.A['IncludedAuxBusses'];
  if lArray.Count > 0 then
  begin
    SetLength(FIncludedAuxBusses, lArray.Count);

    for var I := 0 to Pred(lArray.Count) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FIncludedAuxBusses[I] := TwbIncludedAuxBuss.Create;

      with FIncludedAuxBusses[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntIncludedAuxBuss, FIncludedAuxBusses[I], aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] IncludedAuxBusses', [lArray.Count]);
  end;

  lArray := aSoundBank.A['ExternalSources'];
  if lArray.Count > 0 then
  begin
    SetLength(FExternalSources, lArray.Count);

    for var I := 0 to Pred(lArray.Count) do
    begin
      var lObject := lArray[I];
      var lGUID := StringToGUID(lObject.S['GUID']);
      var lName := lObject.S['Name'];
      FExternalSources[I] := TwbExternalSource.Create;

      with FExternalSources[I] do
      begin
        FGUID := lGUID;
        FName := lName;
        FParent := Self;
        FRoot := FParent.FRoot;

        FRoot.RegisterNode(wntExternalSource, FExternalSources[I], aBankFilename);
      end;
    end;

    Inc(aCount, lArray.Count);
    //wbProgress('Processed [%d] ExternalSources', [lArray.Count]);
  end;
end;


{ TwbSoundBankArray }

procedure TwbSoundBankArray.BuildIndex(const aLoadOrder: TStringList);
begin
  BuildIndexFile('sound\soundbanks\soundbanksinfo.json', 'Starfield.esm');

  var lHardcodedSoundBanks := TStringList.Create;
  with lHardcodedSoundBanks do
  try
    Add('Init');
    Add('Starfield_AMB');
    Add('Starfield_DRS');
    Add('Starfield_FST');
    Add('Starfield_FX');
    Add('Starfield_ITM');
    Add('Starfield_MUS');
    Add('Starfield_NPC');
    Add('Starfield_OBJ');
    Add('Starfield_PHY');
    Add('Starfield_QST');
    Add('Starfield_UI');
    Add('Starfield_VEH');
    Add('Starfield_VOC');
    Add('Starfield_WPN');

    BuildIndexFiles(lHardcodedSoundBanks, 'Starfield.esm');
  finally
    Free;
  end;

  BuildIndexFiles(aLoadOrder);
end;

function wbSoundBankJSONWithinBounds(const aData: TBytes): Boolean;
const
  cMaxBytes = 256 * 1024 * 1024;
  cMaxDepth = 256;
var
  lDepth, lMaxDepth   : Integer;
  lInString, lEscaped : Boolean;
begin
  Result := False;
  if Length(aData) > cMaxBytes then
    Exit;

  lDepth := 0;
  lMaxDepth := 0;
  lInString := False;
  lEscaped := False;
  for var lByte in aData do
    if lInString then begin
      if lEscaped then
        lEscaped := False
      else if lByte = Ord('\') then
        lEscaped := True
      else if lByte = Ord('"') then
        lInString := False;
    end else
      case lByte of
        Ord('"'):
          lInString := True;
        Ord('{'), Ord('['): begin
          Inc(lDepth);
          if lDepth > lMaxDepth then
            lMaxDepth := lDepth;
        end;
        Ord('}'), Ord(']'):
          Dec(lDepth);
      end;

  Result := lMaxDepth <= cMaxDepth;
end;

procedure TwbSoundBankArray.BuildIndexFile(const aFileName, aModuleName: string);
begin
  var lFile := wbContainerHandler.OpenResourceData('', aFileName);

  if Length(lFile) > 0 then
  begin
    if not wbSoundBankJSONWithinBounds(lFile) then
    begin
      wbProgress('[%s] Skipped %s: larger or more deeply nested than a soundbank file can be', [aModuleName, aFileName]);
      Exit;
    end;

    var lSoundBankCount := Length(FSoundBanks);
    FPending := TList<TwbPendingNode>.Create;
    var lJSON := TJSONObject.Create;
    try
      try
        var lCount := 0;

        lJSON.FromUtf8JSON(PByte(@lFile[0]), Length(lFile));

        BuildSoundBanks(lJSON, aModuleName, lCount);

        for var lNode in FPending do
          IndexNode(lNode.NodeType, lNode.Node, lNode.BankFilename);

        wbProgress('[%s] Indexed %d GUIDs', [aModuleName, lCount]);
      except
        on E: Exception do
        begin
          for var lNode in FPending do
            lNode.Node.Free;
          SetLength(FSoundBanks, lSoundBankCount);
          wbProgress('[%s] Skipped %s: %s', [aModuleName, aFileName, E.Message]);
        end;
      end;
    finally
      lJSON.Free;
      FreeAndNil(FPending);
    end;
  end;
end;

procedure TwbSoundBankArray.BuildIndexFiles(const aFileNames: TStringList; const aModuleName: string = '');
begin
  var lByHash := TDictionary<UInt32, string>.Create;
  try
    for var I := 0 to Pred(aFileNames.Count) do
    begin
      var lFile := aFileNames[I];
      var lFileName := TPath.GetFileNameWithoutExtension(lFile);
      var lHash := TwbHash.FNV132(lFileName, True);
      var lBankName := 'sound\soundbanks\' + UIntToStr(lHash) + '.json';

      var lModuleName: string;
      if aModuleName <> '' then
        lModuleName := aModuleName
      else
        lModuleName := ExtractFileName(lFile);

      var lOther: string;
      if lByHash.TryGetValue(lHash, lOther) then
        wbProgress('[%s] %s is also the soundbank file of %s, the two names share one hash', [lModuleName, lBankName, ExtractFileName(lOther)])
      else
        lByHash.Add(lHash, lFile);

      BuildIndexFile(lBankName, lModuleName);
    end;
  finally
    lByHash.Free;
  end;
end;

procedure TwbSoundBankArray.BuildSoundBanks(const aJSON: TJSONObject; const aModuleName: string; var aCount: Integer);
begin
  var lSoundBanksInfo:= aJSON.O['SoundBanksInfo'];
  var lSoundBanks := lSoundBanksInfo.A['SoundBanks'];

  var lSoundBanksCount := lSoundBanks.Count;
  if lSoundBanksCount > 0 then
  begin
    for var I := 0 to Pred(lSoundBanksCount) do
    begin
      var lSoundBank := lSoundBanks[I];
      var lGUID := StringToGUID(lSoundBank.S['GUID']);
      var lName := lSoundBank.S['ShortName'];
      SetLength(FSoundBanks, Succ(Length(FSoundBanks)));

      var lIdx := High(FSoundBanks);
      FSoundBanks[lIdx] := TwbSoundBank.Create;

      with FSoundBanks[lIdx] do
      begin
        FFilename := aModuleName;
        FGUID := lGUID;
        FName := lName;
        FRoot := Self;

        RegisterNode(wntSoundBank, FSoundBanks[lIdx], FFilename);

        BuildSoundBank(lSoundBank, aCount, FFilename);
      end;
    end;
    Inc(aCount, lSoundBanksCount);
    //wbProgress('Processed [%d] SoundBanks', [lSoundBanksCount]);
  end;
end;

constructor TwbSoundBankArray.Create;
begin
  inherited Create;

  FComboBoxMap := TDictionary<string, TDictionary<TwbWwiseNodeType, TStringList>>.Create(TIStringComparer.Ordinal);
  FDisplayMap := TDictionary<TwbWwiseNodeType, TDictionary<string, TGUID>>.Create;
  FGuidMap := TDictionary<TwbWwiseNodeType, TDictionary<TGUID, TwbWwiseObject>>.Create;
  FOwned := TObjectDictionary<TwbWwiseObject, Boolean>.Create([doOwnsKeys]);

  for var lNodeType := Low(TwbWwiseNodeType) to High(TwbWwiseNodeType) do
  begin
    FDisplayMap.Add(lNodeType, TDictionary<string, TGUID>.Create(TIStringComparer.Ordinal));
    FGUIDMap.Add(lNodeType, TDictionary<TGUID, TwbWwiseObject>.Create);
  end;
end;

constructor TwbSoundBankArray.Create(const aLoadOrder: TStringList);
begin
  Create;

  BuildIndex(aLoadOrder);
end;

destructor TwbSoundBankArray.Destroy;
begin
  for var lNodeType := Low(TwbWwiseNodeType) to High(TwbWwiseNodeType) do
  begin
    FDisplayMap[lNodeType].Free;
    FGuidMap[lNodeType].Free;
  end;

  for var lInnerMap in FComboBoxMap.Values do
  begin
    for var llist in lInnerMap.Values do
      lList.Free;
    lInnerMap.Free;
  end;

  FComboBoxMap.Free;
  FDisplayMap.Free;
  FGuidMap.Free;
  FOwned.Free;

  inherited;
end;

procedure TwbSoundBankArray.GetChildStrings(const aParentGUID: TGUID;
                                            const aChildType: TwbWwiseNodeType;
                                              var aList: TStringList);
begin
  if not Assigned(aList) then
    Exit;

  aList.BeginUpdate;
  try
    aList.Sorted := True;
    aList.Duplicates := dupIgnore;

    var lParentType: TwbWwiseNodeType;
    case aChildType of
      wntSwitch: lParentType := wntSwitchGroup;
      wntState:  lParentType := wntStateGroup;
    else
      Exit;
    end;

    var lParentObject: TwbWwiseObject;
    if not FGuidMap[lParentType].TryGetValue(aParentGUID, lParentObject) then
      Exit;

    var lWalk := lParentObject;
    while not (lWalk is TwbSoundBank) do
      lWalk := lWalk.FParent;
    var lBankFilename := TwbSoundBank(lWalk).FFilename;

    if lParentObject is TwbSwitchGroup then
      for var lSwitch in TwbSwitchGroup(lParentObject).FSwitches do
        aList.Add(Format('%s [%s]', [lSwitch.DisplayName, lBankFilename]))
    else if lParentObject is TwbStateGroup then
      for var lState in TwbStateGroup(lParentObject).FStates do
        aList.Add(Format('%s [%s]', [lState.DisplayName, lBankFilename]));
  finally
    aList.EndUpdate;
  end;
end;

procedure TwbSoundBankArray.GetStrings(const aNodeType : TwbWwiseNodeType;
                                       const aMasters  : TStringList;
                                         var aList     : TStringList);
begin
  if not Assigned(aList) then
    Exit;

  aList.BeginUpdate;
  try
    aList.Sorted := True;
    aList.Duplicates := dupIgnore;

    var lInnerMap : TDictionary<TwbWwiseNodeType, TStringList>;
    for var I := 0 to Pred(aMasters.Count) do
    begin
      if FComboBoxMap.TryGetValue(aMasters[I], lInnerMap) then
      begin
        var lStrings: TStringList;
        if lInnerMap.TryGetValue(aNodeType, lStrings) then
          aList.AddStrings(lStrings);
      end;
    end;
  finally
    aList.EndUpdate;
  end;
end;

procedure TwbSoundBankArray.IndexNode(const aNodeType     : TwbWwiseNodeType;
                                      const aObject       : TwbWwiseObject;
                                      const aBankFilename : string);
begin
  var lDisplayString := Format('%s [%s]', [aObject.DisplayName, aBankFileName]);
  FDisplayMap[aNodeType].TryAdd(lDisplayString, aObject.FGUID);

  FGuidMap[aNodeType].TryAdd(aObject.FGUID, aObject);
  FOwned.TryAdd(aObject, True);

  var lInnerMap: TDictionary<TwbWwiseNodeType, TStringList>;
  if not FComboBoxMap.TryGetValue(aBankFilename, lInnerMap) then
  begin
    lInnerMap := TDictionary<TwbWwiseNodeType, TStringList>.Create;
    FComboBoxMap.Add(aBankFilename, lInnerMap);
  end;

  var lTargetList: TStringList;
  if not lInnerMap.TryGetValue(aNodeType, lTargetList) then
  begin
    lTargetList := TStringList.Create;
    lTargetList.Sorted := True;
    lTargetList.Duplicates := dupIgnore;
    lInnerMap.Add(aNodeType, lTargetList);
  end;

  lTargetList.Add(lDisplayString);
end;

procedure TwbSoundBankArray.RegisterNode(const aNodeType     : TwbWwiseNodeType;
                                         const aObject       : TwbWwiseObject;
                                         const aBankFilename : string);
begin
  var lNode: TwbPendingNode;
  lNode.NodeType := aNodeType;
  lNode.Node := aObject;
  lNode.BankFilename := aBankFilename;
  FPending.Add(lNode);
end;

function TwbSoundBankArray.TryLookupDisplay(const aNodeType     : TwbWwiseNodeType;
                                            const aDisplayStr   : string;
                                              var aGUID: TGUID) : Boolean;
begin
  Result := FDisplayMap[aNodeType].TryGetValue(aDisplayStr, aGUID);
end;

function TwbSoundBankArray.TryLookupGUID(const aNodeType : TwbWwiseNodeType;
                                         const aGUID     : TGUID;
                                           var aName     : string;
                                           var aFilename : string): Boolean;
begin
  var lObj : TwbWwiseObject;
  Result := FGuidMap[aNodeType].TryGetValue(aGUID, lObj);
  if Result then
  begin
    aName := lObj.DisplayName;

    var lParent := lObj;
    while not (lParent is TwbSoundBank)  do
      lParent := lParent.FParent;

    aFileName := TwbSoundBank(lParent).FFilename;
  end;
end;

initialization
  wbSoundBankCache := TwbSoundBankArray.Create;

end.
