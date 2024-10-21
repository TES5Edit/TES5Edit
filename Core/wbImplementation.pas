{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbImplementation;

{$I wbDefines.inc}

{$DEFINE DBGSUBREC}

interface

uses
  Variants,
  Windows,
  Classes,
  SysUtils,
  Contnrs,
  Math,
  wbInterface,
  wbLoadOrder,
  System.Generics.Collections,
  {$IFDEF USE_CODESITE}
  CodeSiteLogging,
  {$ENDIF}
{$IFDEF USE_PARALLEL_BUILD_REFS}
  System.SyncObjs,
{$ENDIF}
  Zlibex,
  lz4;

const
  DefaultVCS1 = 0;
  DefaultVCS2 = 0;

var
  RecordToSkip       : TStringList;
  SubRecordToSkip    : TStringList;
  GroupToSkip        : TStringList;
  ChaptersToSkip     : TStringList;
  SubRecordOrderList : TStringList;

function wbMastersForFile(const aFileName: string; aMasters: TStrings; aIsESM: PBoolean = nil; aIsLight: PBoolean = nil; aIsLocalized: PBoolean = nil; aIsOverlay: PBoolean = nil; aIsMedium: PBoolean = nil): Boolean; overload;
function wbMastersForFile(const aFileName: string; out aMasters: TDynStrings; aIsESM: PBoolean = nil; aIsLight: PBoolean = nil; aIsLocalized: PBoolean = nil; aIsOverlay: PBoolean = nil; aIsMedium: PBoolean = nil): Boolean; overload;

function wbFile(const aFileName: string; aLoadOrder: Integer = -1; aCompareTo: string = ''; aStates: TwbFileStates = []; const aData: TBytes = nil): IwbFile;
function wbNewFile(const aFileName: string; aLoadOrder: Integer; aIsLight, aIsMedium: Boolean): IwbFile; overload;
function wbNewFile(const aFileName: string; aLoadOrder: Integer; aTemplate: PwbModuleInfo): IwbFile; overload;
procedure wbFileForceClosed;

function StartsWith(const s, t: string): Boolean;

function wbCopyElementToFile(const aSource: IwbElement; aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
function wbCopyElementToRecord(const aSource: IwbElement; aMainRecord: IwbMainRecord; aAsNew, aDeepCopy: Boolean): IwbElement;

function wbFindWinningMainRecordByEditorID(const aSignature: TwbSignature; const aEditorID: string): IwbMainRecord;
function wbFormListToArray(const aFormList: IwbMainRecord; const aSignatures: string): TDynMainRecords;

function wbGetGameMasterFile: IwbFile;

function wbCreateKeepAliveRoot: IwbKeepAliveRoot;

function wbBeginKeepAlive: Integer;
function wbEndKeepAlive: Integer;

function wbFormIDFromIdentity(aFormIDBase, aFormIDNameBase: Byte; aIdentity: string): TwbFormID;

function wbRecordByLoadOrderFormID(const aFormID: TwbFormID; const aSeenFromFile: IwbFile): IwbMainRecord;

function wbMultipleElements(const aElements: IwbElements): IwbMultipleElements;

implementation

uses
  TypInfo,
  lz4io,
  wbLocalization,
  wbHelpers,
  wbSort;

const
  EmptyPtr: AnsiChar = #0;

Type
  EFileNoSlotExecption = class(Exception);  // helper type, to ignore this exception during debugging sessions.

type
  PwbKeepAliveContext = ^TwbKeepAliveContext;
  TwbKeepAliveContext = record
    kacHead     : IwbContainerElementRef;
    kacPrev     : PwbKeepAliveContext;
    kacFinished : Boolean;
  end;

  TwbKeepAliveRoot = class(TInterfacedObject, IwbKeepAliveRoot)
  protected {private}
    karKAC: PwbKeepAliveContext;

    procedure Setup;
    procedure Teardown;

    constructor Create;
    destructor Destroy; override;

    {---IwbKeepAliveRoot---}
    procedure Done;
    function IsRoot: Boolean;
  end;

function wbCreateKeepAliveRoot: IwbKeepAliveRoot;
begin
  Result := TwbKeepAliveRoot.Create;
end;

threadvar
  wbKeepAliveContext : PwbKeepAliveContext;

  wbKeepAliveCount   : Integer;
  wbKeepAliveRoot    : IwbKeepAliveRoot;

function wbBeginKeepAlive: Integer;
begin
  Result := Succ(wbKeepAliveCount);
  wbKeepAliveCount := Result;
  if (Result > 0) and not Assigned(wbKeepAliveRoot) then
    wbKeepAliveRoot := wbCreateKeepAliveRoot;
end;

function wbEndKeepAlive: Integer;
begin
  Result := Pred(wbKeepAliveCount);
  wbKeepAliveCount := Result;
  if Result = 0 then
    wbKeepAliveRoot := nil;
end;

const
  TheEmptyPlugin = 'SavesEmptyPlugin.esp';

type
  TwbMainRecordEntryHeader = record
    mrehGeneration : Integer;
    mrehHead       : Pointer;
    mrehTail       : Pointer;
    mrehCount      : Integer;
    mrehInUse      : Boolean;

    procedure BeginUse;
    procedure EndUse;
  end;

threadvar
  mreHeader: TwbMainRecordEntryHeader;
var
  mreNextGen: Integer;

function wbCopyElementToFile(const aSource: IwbElement; aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  MainRecord  : IwbMainRecord;
  Container   : IwbContainer;
  Target      : IwbElement;
begin
  Inc(wbCopyIsRunning);
  try
    wbTick;
    Container := aSource.Container;
    if Assigned(Container) then begin
      if Supports(Container, IwbMainRecord, MainRecord) then
        Container := MainRecord.HighestOverrideVisibleForFile[aFile];
      Target := wbCopyElementToFile(Container, aFile, False, False, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False)
    end else begin
      Result := aFile;
      Exit;
    end;

    if Assigned(Target) then
      Result := Target.AddIfMissing(aSource, aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite)
    else
      Result := nil;
  finally
    Dec(wbCopyIsRunning);
  end;
end;

function wbCopyElementToRecord(const aSource: IwbElement; aMainRecord: IwbMainRecord; aAsNew, aDeepCopy: Boolean): IwbElement;
var
  Container                   : IwbContainer;
  Target                      : IwbElement;
  CER                         : IwbContainerElementRef;
begin
  CER := aMainRecord as IwbContainerElementRef;

  if Assigned(aSource) and (aSource.ElementType = etMainRecord) then begin
    if aSource.Equals(aMainRecord) then
      Result := nil
    else
      Result := aMainRecord;
    Exit;
  end;

  Container := aSource.Container;
  Assert(Assigned(Container), '[wbCopyElementToRecord] not Assigned(Container)');
  Target := wbCopyElementToRecord(Container, aMainRecord, False, False);

  if Assigned(Target) then
    Result := Target.AddIfMissing(aSource, aAsNew, aDeepCopy, '', '', '', '', False)
  else
    Result := nil;
end;

function StartsWith(const s, t: string): Boolean;
var
  i                           : Integer;
begin
  Result := False;
  if Length(s) < Length(t) then
    Exit;

  for i := 1 to Length(t) do
    if UpCase(s[i]) <> UpCase(t[i]) then
      Exit;
  Result := True;
end;

type
  IwbElementInternal = interface(IwbElement)
    ['{556DF03C-2723-46FC-99C6-F50BB5E66F86}']
    procedure SetContainer(const aContainer: IwbContainer);
    procedure SetSortOrder(aIndex: Integer);
    procedure SetMemoryOrder(aIndex: Integer);
    function GetMemoryOrder: Integer;
    procedure SetNameSuffix(const aSuffix: string);
    function GetNameSuffix: string;
    procedure SetModified(aValue: Boolean);
    procedure SetInternalModified(aValue: Boolean);
    function GetCountedRecordCount: Cardinal;
    procedure PrepareSave;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
    procedure FindUsedMasters(aMasters: PwbUsedMasters);
    procedure InvalidateStorage;
    function Reached: Boolean;
    procedure TryAssignMembers(const aSource: IwbElement);
    procedure ResetModified(aResetModified: TwbResetModified);
    procedure FlagAsOptionalAndMissing;

    function BeginResolve: Boolean;
    procedure EndResolve;

    property Modified: Boolean
      read GetModified
      write SetModified;

    property MemoryOrder: Integer
      read GetMemoryOrder
      write SetMemoryOrder;

    property NameSuffix: string
      read GetNameSuffix
      write SetNameSuffix;

    property InternalModified: Boolean
      write SetInternalModified;
  end;

  TwbElement = class(TInterfacedObject, IInterface, IwbElement, IwbElementInternal)
  protected
    eContainer         : Pointer{IwbContainerInternal}; //weak reference
    eSortOrder         : Integer;
    eMemoryOrder       : Integer;
    eStates            : TwbElementStates;
    eSortKey           : string;
    eExtendedSortKey   : string;

    eExternalRefs      : Integer;
    eContainerRef      : IwbContainerElementRef;

    eUpdateCount       : Integer;

    eGeneration        : Integer;
    eMastersGeneration : Integer;

    eNameSuffix        : string;

    eLinksToGeneration : Integer;
    eCachedLinksTo     : IwbElement;
    eSummaryLinksTo    : IwbElement;

    {---IInterface---}
    function _AddRef: Integer; virtual; stdcall;
    function _Release: Integer; virtual; stdcall;

    {---IwbElementInternal---}
    function InternalAddRef: Integer; stdcall;
    function InternalRelease: Integer; stdcall;
    function IwbElementInternal._AddRef = InternalAddRef;
    function IwbElementInternal._Release = InternalRelease;
    function GetCountedRecordCount: Cardinal; virtual;
    procedure PrepareSave; virtual;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; virtual;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); virtual;
    procedure InvalidateStorage; virtual;
    procedure InvalidateParentStorage; virtual;
    function Reached: Boolean; virtual;
    function LinksToParent: Boolean; virtual;
    procedure SetMemoryOrder(aIndex: Integer);
    function GetMemoryOrder: Integer;
    procedure SetNameSuffix(const aSuffix: string); virtual;
    function GetNameSuffix: string; virtual;
    procedure TryAssignMembers(const aSource: IwbElement); virtual;
    procedure FlagAsOptionalAndMissing;

    function BeginResolve: Boolean;
    procedure EndResolve;

    procedure NotifyChanged(aContainer: Pointer); virtual;
    procedure NotifyChangedInternal(aContainer: Pointer); virtual;

    procedure ReportRequiredMasters(aDict: TwbFilesDictionary; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false); virtual;

    function GetElementID: Pointer;
    function GetElementStates: TwbElementStates;
    procedure SetElementState(aState: TwbElementState; Clear: Boolean = false);
    function Equals(const aElement: IwbElement): Boolean; reintroduce;

    procedure Hide;
    procedure Show;
    function GetIsHidden: Boolean;

    function HasErrors: Boolean; virtual;

    function GetValue: string; virtual;
    function GetSummary: string; virtual;
    function GetCheck: string; virtual;
    function GetSortKey(aExtended: Boolean): string; virtual;
    function GetDisplaySortKey(aExtended: Boolean): string;
    function GetSortKeyInternal(aExtended: Boolean): string; virtual;
    function GetRawDataAsString: string; virtual;
    function GetSortPriority: Integer; virtual;
    function GetName: string; virtual;
    function GetBaseName: string; virtual;
    function GetDisplayName(aUseSuffix: Boolean): string; virtual;
    function GetShortName: string; virtual;
    function GetPath: string; virtual;
    function GetIndexedPath(aIndexFromFile: Boolean = True): string; virtual;
    function GetFullPath: string; virtual;
    function GetPathName: string; virtual;
    function GetSkipped: Boolean; virtual;
    procedure SetSkipped(aValue: Boolean); virtual;
    function GetDef: IwbNamedDef; virtual;
    function GetValueDef: IwbValueDef; virtual;
    function GetResolvedValueDef: IwbValueDef; virtual;
    function GetElementType: TwbElementType; virtual;
    procedure DoReset(aForce: Boolean); virtual;
    function ResetLeafFirst: Boolean; virtual;
    function GetContainer: IwbContainer;
    function GetContainingMainRecord: IwbMainRecord; virtual;
    function GetFile: IwbFile; virtual;
    function GetReferenceFile: IwbFile; virtual;
    function GetSortOrder: Integer;
    procedure BuildRef; virtual;
    procedure AddReferencedFromID(aFormID: TwbFormID); virtual;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; virtual;
    function GetIsEditable: Boolean; virtual;
    function GetIsRemovable: Boolean; virtual;
    function GetIsClearable: Boolean; virtual;
    function GetEditValue: string; virtual;
    procedure SetEditValue(const aValue: string); virtual;
    function GetNativeValue: Variant; virtual;
    procedure SetNativeValue(const aValue: Variant); virtual;
    procedure RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal); virtual;
    function GetConflictPriority: TwbConflictPriority; virtual;
    function GetConflictPriorityCanChange: Boolean; virtual;
    function GetCollapsed: TwbTriBool; virtual;
    function GetModified: Boolean;
    function GetElementGeneration: Integer;
    procedure MarkModifiedRecursive(const aElementTypes: TwbElementTypes); virtual;
    function GetIsInjected: Boolean; virtual;
    function GetReferencesInjected: Boolean; virtual;
    function GetInjectionSourceFiles: TwbFiles; virtual;
    function GetIsNotReachable: Boolean; virtual;
    function GetIsReachable: Boolean; virtual;
    procedure SetModified(aValue: Boolean); virtual;
    procedure SetParentModified; virtual;
    procedure SetInternalModified(aValue: Boolean); virtual;
    function GetDataSize: Integer; virtual;
    procedure SetDataSize(aSize: Integer); virtual;
    procedure MergeStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); virtual;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); virtual;
    procedure Remove; virtual;
    procedure Clear; virtual;
    procedure BeforeActualRemove; virtual;
    function CanContainFormIDs: Boolean; virtual;
    function ContainsReflection: Boolean; virtual;
    function ContainsUnmappedFormID: Boolean; virtual;
    function AddIfMissing(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; virtual;
    procedure ResetConflict; virtual;
    procedure ResetReachable; virtual;
    function RemoveInjected(aCanRemove: Boolean): Boolean; virtual;
    function GetEditType: TwbEditType; virtual;
    function GetEditInfo: TArray<string>; virtual;
    function GetDontShow: Boolean; virtual;
    procedure SetToDefault;
    procedure SetToDefaultInternal; virtual;
    procedure SetToDefaultIfAsCreatedEmpty; virtual;
    function ContentIsAllZero: Boolean; virtual;

    function ShouldReportError(aErrorType: TwbElementErrorType): Boolean;

    function CanAssign(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; virtual;
    function GetAssignTemplates(aIndex: Integer): TwbTemplateElements; virtual;
    function Assign(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; virtual;

    procedure WriteToStream(aStream: TStream; aResetModified: TwbResetModified); virtual;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); virtual;
    procedure ResetModified(aResetModified: TwbResetModified); virtual;
    function GetLinksTo: IwbElement;
    function InternalGetLinksTo: IwbElement; virtual;
    function GetSummaryLinksTo: IwbElement; virtual;
    procedure SetLinksTo(const aElement: IwbElement); virtual;
    function GetNoReach: Boolean;

    procedure SetContainer(const aContainer: IwbContainer); virtual;
    procedure SetSortOrder(aIndex: Integer);

    procedure DoAfterSet(const aOldValue, aNewValue: Variant); virtual;

    procedure MoveUp;
    procedure MoveDown;
    function CanMoveUp: Boolean;
    function CanMoveDown: Boolean;

    function CanCopy: Boolean; virtual;

    function NextMember: IwbElement;
    function PreviousMember: IwbElement;
    function CanChangeMember: Boolean;

    procedure Tag;
    procedure ResetTags; virtual;
    function IsTagged: Boolean;

    function GetFound: Boolean;
    procedure SetFound(const aValue: Boolean);

    function GetLocalized: TwbTriBool;
    procedure SetLocalized(const aValue: TwbTriBool);

    function CopyInto(const aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string): IwbElement;

    function BeginUpdate: Integer;
    function EndUpdate: Integer;
    procedure UpdateEnded; virtual;

    constructor Create(const aContainer: IwbContainer);
    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;

    function GetTreeHead: Boolean;              // Is the element expected to be a "header record" in the tree navigator
    function GetTreeBranch: Boolean;            // Is the element expected to show in the tree navigator

    function GetMastersUpdated: Boolean;
    procedure SetMastersUpdated(aValue: Boolean);

    function MergeMultiple(const aElement: IwbElement): Boolean; virtual;
  end;

  TwbTemplateElement = class(TwbElement, IwbTemplateElement)
  protected
    teDef: IwbNamedDef;
  protected
    {---TwbElement---}
    function GetName: string; override;
    function GetDef: IwbNamedDef; override;
    function GetValueDef: IwbValueDef; override;
    function GetElementType: TwbElementType; override;
  public
    constructor Create(aDef: IwbNamedDef);
  end;

  TwbMultipleElements = class(TwbElement, IwbMultipleElements)
  protected
    meElements: IwbElements;
  protected
    {---IwbMultipleElements---}
    function GetElement(aIndex: Integer): IwbElement;
    function GetElementCount: Integer;
  public
    constructor Create(const aElements: IwbElements);
  end;

  TDynElementInternals = array of IwbElementInternal;

  IwbContainerInternal = interface(IwbContainer)
    ['{8D9AC0D3-3961-4320-A036-EB4771B081CD}']

    function ReleaseElements: TDynElementInternals;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer);
    procedure CreatedEmpty;

    procedure MoveElementUp(const aElement: IwbElement);
    procedure MoveElementDown(const aElement: IwbElement);
    function CanMoveElementUp(const aElement: IwbElement): Boolean;
    function CanMoveElementDown(const aElement: IwbElement): Boolean;

    function ChangeElementMember(const aElement: IwbElement; aPrevious: Boolean): IwbElement;
    function CanChangeElementMember(const aElement: IwbElement): Boolean;

    procedure UpdateNameSuffixes;

    function ResolveElementName(aName: string; out aRemainingName: string; aCanCreate: Boolean = False): IwbElement;
  end;

  TwbContainer = class(TwbElement, IwbContainerElementRef, IwbContainer, IwbContainerInternal)
  protected
    cntElements      : TDynElementInternals;
    cntElementsMap   : TDynCardinalArray;
    cntElementRefs   : Integer;
    cntStates        : TwbContainerStates;
    cntKeepAliveNext : IwbContainerElementRef;
    cntRefsBuildAt   : Integer;
    cntCollapesGen   : Integer;

    function _AddRef: Integer; override; stdcall;
    function _Release: Integer; override; stdcall;

    function ContainsReflection: Boolean; override;
    function ContainsUnmappedFormID: Boolean; override;

    {---IwbContainerElementRef---}
    function ElementAddRef: Integer; stdcall;
    function ElementRelease: Integer; stdcall;
    function IwbContainerElementRef._AddRef = ElementAddRef;
    function IwbContainerElementRef._Release = ElementRelease;
    function GetCountedRecordCount: Cardinal; override;
    procedure PrepareSave; override;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;

    procedure ResetMemoryOrder(aFrom: Integer = 0; aTo: Integer = High(Integer)); virtual;
    procedure SortBySortOrder; virtual;
    procedure SetIsSortedBySortOrder(aForce: Boolean);
    procedure CreatedEmpty;

    function Reached: Boolean; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;

    procedure ReportRequiredMasters(aDict: TwbFilesDictionary; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false); override;
    procedure ResetConflict; override;
    procedure ResetReachable; override;

    procedure DoReset(aForce: Boolean); override;
    function ResetLeafFirst: Boolean; override;
    function ResetChildrenLeafFirst: Boolean; virtual;
    procedure DoInit(aNeedSorted: Boolean); virtual;

    function HasErrors: Boolean; override;
    function ContentIsAllZero: Boolean; override;

    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetDataSize: Integer; override;
    function GetDataSizeFromElements: Integer; virtual;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function UpdateMemoryOrder(out aMemoryOrderElements: TArray<Pointer>): Boolean;
    procedure BuildRef; override;
    procedure MarkModifiedRecursive(const aElementTypes: TwbElementTypes); override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function GetIsInSK(aIndex: Integer): Boolean; virtual;

    procedure SetToDefaultInternal; override;
    procedure SetToDefaultIfAsCreatedEmpty; override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;
    procedure ResetModified(aResetModified: TwbResetModified); override;

    function GetElement(aIndex: Integer): IwbElement;
    function GetAnyElement: IwbElement;
    function GetElementCount: Integer;
    function GetElementByName(const aName: string): IwbElement;
    function GetRecordBySignature(const aSignature: TwbSignature): IwbRecord; virtual;
    function GetElementByMemoryOrder(aSortOrder: Integer): IwbElement;
    function GetElementBySignature(const aSignature: TwbSignature): IwbElement; virtual;
    function GetElementBySortOrder(aSortOrder: Integer): IwbElement;
    function GetAdditionalElementCount: Integer; virtual;
    procedure ReverseElements;
    function GetContainerStates: TwbContainerStates;
    function GetCollapsed: TwbTriBool; override;
    procedure SetCollapsed(const aValue: TwbTriBool);
    function GetElementByPath(const aPath: string): IwbElement;
    function GetElementValue(const aName: string): string;
    function GetElementSummary(const aName: string): string;
    function GetElementExists(const aName: string): Boolean;

    function GetElementEditValue(const aName: string): string;
    function GetMemberEditValue(const aName: string): string;

    procedure SetElementEditValue(const aName, aValue: string);
    procedure SetMemberEditValue(const aName, aValue: string);

    function GetElementNativeValue(const aName: string): Variant;
    function GetMemberNativeValue(const aName: string): Variant;

    procedure SetElementNativeValue(const aName: string; const aValue: Variant);
    procedure SetMemberNativeValue(const aName: string; const aValue: Variant);

    function GetElementLinksTo(const aName: string): IwbElement;
    function GetElementSortKey(const aName: string; aExtended: Boolean): string;

    function ResolveElementName(aName: string; out aRemainingName: string; aCanCreate: Boolean = False): IwbElement; virtual;

    procedure AddElement(const aElement: IwbElement); virtual;
    procedure InsertElement(aPosition: Integer; const aElement: IwbElement);
    function RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement; overload; virtual;
    function RemoveElement(const aElement: IwbElement; aMarkModified: Boolean = False): IwbElement; overload; virtual;
    function RemoveElement(const aName: string): IwbElement; overload;
    function LastElement: IwbElement;

    function CanElementReset: Boolean; virtual;

    function GetAddList: TDynStrings; virtual;
    function Add(const aName: string; aSilent: Boolean): IwbElement; virtual;

    function IsElementRemovable(const aElement: IwbElement): Boolean; virtual;
    function IsElementEditable(const aElement: IwbElement): Boolean; virtual;

    function IndexOf(const aElement: IwbElement): Integer; virtual;

    function ReleaseElements: TDynElementInternals;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); virtual;
    procedure NotifyChanged(aContainer: Pointer); override;
    procedure NotifyChangedInternal(aContainer: Pointer); override;

    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;

    procedure Init; virtual;
    procedure Reset; virtual;
    procedure Bar;
    function ReleaseKeepAlive: IwbContainerElementRef;

    procedure MoveElementUp(const aElement: IwbElement);
    procedure MoveElementDown(const aElement: IwbElement);
    function CanMoveElementUp(const aElement: IwbElement): Boolean;
    function CanMoveElementDown(const aElement: IwbElement): Boolean;
    function CanMoveElement: Boolean; virtual;

    function ChangeElementMember(const aElement: IwbElement; aPrevious: Boolean): IwbElement;
    function CanChangeElementMember(const aElement: IwbElement): Boolean;

    procedure UpdateNameSuffixes; virtual;

    function FindBySortKey(const aSortKey: string; aExtended: Boolean; out aIndex: Integer): Boolean;
    function FindBySortOrder(const aSortOrder: Integer; out aIndex: Integer): Boolean;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    destructor Destroy; override;
    procedure FreeInstance; override;

    procedure ResetTags; override;
  end;

  IwbFileInternal = interface(IwbFile)
    ['{E1334034-06D0-4299-BFE0-E0DE97C128E2}']
    procedure AddMainRecord(const aRecord: IwbMainRecord);
    procedure RemoveMainRecord(const aRecord: IwbMainRecord);
    procedure InjectMainRecord(const aRecord: IwbMainRecord);
    procedure RemoveInjectedMainRecord(const aRecord: IwbMainRecord);
    procedure ForceClosed;
    procedure GetMasters(aMasters: TStrings);
    procedure IncGeneration;
    function GetFileGeneration: Integer;
    procedure UpdateIndexKeys(const aMainRecord: IwbMainRecord; const aChangedKeys: TwbChangedKeys);
    procedure AddAllMastersToDict(aDict: TwbFilesDictionary);
    function flFindKeyInIndex(aIndex: TwbNamedIndex; const aKey: string; out aMainRecord: IwbMainRecord): Boolean;
  end;

  TwbCachedEditInfo = record
    ceiEditInfo    : TArray<string>;
    ceiGeneration  : Integer;
    ceiLGeneration : Integer;
  end;

  TwbCachedEditInfos = TArray<TwbCachedEditInfo>;

  TwbMainRecordIndexDictionary = TDictionary<string, IwbMainRecord>;

  TwbFile = class(TwbContainer, IwbFile, IwbFileInternal)
  protected
    flData                   : TBytes;
    flFileName               : string;
    flFileNameOnDisk         : string;
    flLoadOrder              : Integer;
    flLoadOrderFileID        : TwbFileID;
    flCompareTo              : string;
    flCompareToFile          : IwbFile;
    flStates                 : TwbFileStates;
    flUnsavedSince           : TDateTime;

    flFileHandle             : THandle;
    flMapHandle              : THandle;

    flView                   : Pointer;
    flSize                   : Int64;
    flEndPtr                 : Pointer;
    flCRC32                  : TwbCRC32;

    flMasters                : TwbFiles;
    flOldMasters             : TwbFiles;

    flAllMasters             : TwbFiles;
    flAllMastersGeneration   : Integer;

    flRecords                : array of IwbMainRecord;
    flRecordFormIDs          : array of TwbFormID;
    flRecordsCount           : Integer; {only used during loading}
    flRecordProcessing       : IwbMainRecord;
    flRecordNeedCompactFrom  : Integer;
    flRecordBits             : array of array of array of set of Byte;

    flRecordsIndices         : array of TwbMainRecordIndexDictionary;

    flLoadFinished           : Boolean;
    flFormIDsSorted          : Boolean;
    flIndicesActive          : Boolean;

    flInjectedRecords        : array of IwbMainRecord;

    flModule                 : PwbModuleInfo;

    flCachedEditInfos        : TwbCachedEditInfos;
    flGeneration             : Integer;

    flEncoding               : TEncoding;
    flEncodingTrans          : TEncoding;

    flAllowHardcodedRangeUse : Boolean;
    flHardcodedGeneration    : Integer;

    procedure flOpenFile; virtual;
    procedure flCloseFile; virtual;
    procedure flProgress(const aStatus: string);

    function flSetContainsFixedFormID(const aFormID: TwbFormID): Boolean;

    function Reached: Boolean; override;

    function GetElementType: TwbElementType; override;
    function GetFile: IwbFile; override;
    function GetReferenceFile: IwbFile; override;
    function GetName: string; override;
    function GetBaseName: string; override;
    procedure PrepareSave; override;
    procedure SetModified(aValue: Boolean); override;
    procedure SetParentModified; override;

    procedure BuildRef; override;
    function BuildOrLoadRef(aOnlyLoad: Boolean): TwbBuildOrLoadRefResult;

    function FindFormID(aFormID: TwbFormID; var Index: Integer; aNewMasters: Boolean): Boolean;
    function FindInjectedID(aFormID: TwbFormID; var Index: Integer): Boolean;
    function GetMasterRecordByFormID(aFormID: TwbFormID; aAllowInjected, aNewMasters: Boolean): IwbMainRecord;

    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;

    function GetAddList: TDynStrings; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    function IsElementEditable(const aElement: IwbElement): Boolean; override;
    function GetIsEditable: Boolean; override;
    function GetIsRemovable: Boolean; override;

    procedure WriteToStream(aStream: TStream; aResetModified: TwbResetModified); override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;

    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;

    function NewFormID: TwbFormID;

    function GetHighestGenerationSelfAndMasters: Integer;

    function GetRecordBySignature(const aSignature: TwbSignature): IwbRecord; override;
    function GetElementBySignature(const aSignature: TwbSignature): IwbElement; override;

    procedure flAddKeysToIndices(const aMainRecord: IwbMainRecord; const aKeys: TwbDefinedKeys);
    procedure flRemoveKeysFromIndices(const aMainRecord: IwbMainRecord; const aKeys: TwbDefinedKeys);
    procedure flUpdateChangedKeysInIndices(const aMainRecord: IwbMainRecord; const aChangedKeys: TwbChangedKeys);

    function flFindKeyInIndex(aIndex: TwbNamedIndex; const aKey: string; out aMainRecord: IwbMainRecord): Boolean;

    procedure flActivateIndices;

    {---IwbFile---}
    function GetFileName: string;
    function GetFileNameOnDisk: string;
    function GetModuleInfo: Pointer;
    function GetModuleType: TwbModuleType;
    function GetUnsavedSince: TDateTime; inline;
    function HasMaster(const aFileName: string): Boolean;

    function GetMaster(aIndex: Integer; aNew: Boolean): IwbFile; inline;
    function GetMasterCount(aNew: Boolean): Integer; inline;
    function GetAllMasters: TwbFiles;

    function GetFullMaster(aIndex: Integer; aNew: Boolean): IwbFile;
    function GetFullMasterCount(aNew: Boolean): Integer;

    function GetMediumMaster(aIndex: Integer; aNew: Boolean): IwbFile;
    function GetMediumMasterCount(aNew: Boolean): Integer;

    function GetLightMaster(aIndex: Integer; aNew: Boolean): IwbFile;
    function GetLightMasterCount(aNew: Boolean): Integer;

    function GetMasterForFileID(const aFileID: TwbFileID; aNew, aAllowSelf: Boolean): IwbFile;
    function GetMasterIndexForFileID(const aFileID: TwbFileID; aNew: Boolean): Integer;

    procedure UpdateAllMasters;
    function GetRecordByFormID(aFormID: TwbFormID; aAllowInjected, aNewMasters: Boolean): IwbMainRecord;
    function GetRecordByEditorID(const aEditorID: string): IwbMainRecord;
    function GetContainedRecordByLoadOrderFormID(aFormID: TwbFormID; aAllowInjected: Boolean): IwbMainRecord;
    function GetRecordFromIndexByKey(aIndex: TwbNamedIndex; const aKey: string): IwbMainRecord;
    function GetGroupBySignature(const aSignature: TwbSignature): IwbGroupRecord;
    function HasGroup(const aSignature: TwbSignature): Boolean;
    function GetFileStates: TwbFileStates; inline;
    function GetCRC32: TwbCRC32;
    function GetRecord(aIndex: Integer): IwbMainRecord; inline;
    function GetRecordCount: Integer; inline;
    function GetInjectedRecord(aIndex: Integer): IwbMainRecord; inline;
    function GetInjectedRecordCount: Integer; inline;
    function GetHighObjectID: Cardinal;
    function GetHeader: IwbMainRecord;

    function GetLoadOrder: Integer; inline;
    procedure ForceLoadOrder(aValue: Integer);
    procedure SetLoadOrder(aValue: Integer);

    function GetLoadOrderFileID: TwbFileID;
    function GetResolvedLoadOrderFileID(aNew: Boolean): TwbFileID;
    function GetFileFileID(aNewMasters : Boolean): TwbFileID;

    function LoadOrderFormIDtoFileFormID(aFormID: TwbFormID; aNew: Boolean): TwbFormID;
    function FileFormIDtoLoadOrderFormID(aFormID: TwbFormID; aNew: Boolean): TwbFormID;

    function LoadOrderFileIDtoFileFileID(aFileID: TwbFileID; aNew: Boolean): TwbFileID;
    function FileFileIDtoLoadOrderFileID(aFileID: TwbFileID; aNew: Boolean): TwbFileID;

    procedure AddMasters(aMasters: TStrings); overload;
    procedure AddMasters(const aMasters: array of string); overload;
    procedure AddMasterIfMissing(const aMaster: string; aSortMasters: Boolean = True);

    procedure SortMasters;
    procedure CleanMasters;

    procedure BuildReachable;

    function GetCachedEditInfo(aIdent: Integer; var aEditInfo: TArray<string>): Boolean;
    procedure SetCachedEditInfo(aIdent: Integer; const aEditInfo: TArray<string>);

    function GetIsESM: Boolean;
    procedure SetIsESM(Value: Boolean);

    function GetIsFull: Boolean;
    function GetIsFullDirect: Boolean;

    function GetIsLight: Boolean;
    function GetIsLightDirect: Boolean;
    procedure SetIsLight(Value: Boolean);

    function GetIsMedium: Boolean;
    function GetIsMediumDirect: Boolean;
    procedure SetIsMedium(Value: Boolean);

    function GetIsOverlay: Boolean;
    function GetIsOverlayDirect: Boolean;
    procedure SetIsOverlay(Value: Boolean);

    function GetIsLocalized: Boolean;
    procedure SetIsLocalized(Value: Boolean);

    function GetNextObjectID: Cardinal;
    procedure SetNextObjectID(aObjectID: Cardinal);

    function GetVersion: Double;

    function GetAllowHardcodedRangeUse: Boolean;

    function HasONAM: Boolean;
    procedure MarkHeaderModified;

    function GetIsNotPlugin: Boolean;
    function GetHasNoFormID: Boolean;
    procedure SetHasNoFormID(Value: Boolean);

    function GetEncoding(aTranslatable: Boolean): TEncoding;

    function GetCompareToFile: IwbFile;
    procedure RemoveIdenticalDeltaFast;

    function IsNewRecord(const aFileID: TwbFileID; aNew: Boolean): Boolean; overload;
    function IsNewRecord(const aFormID: TwbFormID; aNew: Boolean): Boolean; overload;

    {---IwbFileInternal---}
    procedure AddMainRecord(const aRecord: IwbMainRecord);
    procedure RemoveMainRecord(const aRecord: IwbMainRecord);
    procedure InjectMainRecord(const aRecord: IwbMainRecord);
    procedure RemoveInjectedMainRecord(const aRecord: IwbMainRecord);
    procedure ForceClosed;
    procedure GetMasters(aMasters: TStrings); virtual;
    procedure IncGeneration;
    function GetFileGeneration: Integer;
    procedure UpdateIndexKeys(const aMainRecord: IwbMainRecord; const aChangedKeys: TwbChangedKeys);
    procedure AddAllMastersToDict(aDict: TwbFilesDictionary);

    procedure Scan; virtual;
    procedure SortRecords;

    procedure AddMaster(const aFileName: string; isTemporary: Boolean = False; aAutoLoadOrder: Boolean = False); overload;
    procedure AddMaster(const aFile: IwbFile); overload;

    procedure UpdateModuleMasters;

    constructor Create(const aFileName: string; aLoadOrder: Integer; aCompareTo: string; aStates: TwbFileStates; aData: TBytes);
    constructor CreateNew(const aFileName: string; aLoadOrder: Integer; aIsLight, aIsMedium: Boolean); overload;
    constructor CreateNew(const aFileName: string; aLoadOrder: Integer; aTemplate: PwbModuleInfo); overload;
  public
    destructor Destroy; override;
  end;

  TwbFileSource = class(TwbFile)
  protected
    procedure Scan; override;
    constructor CreateNew(const aFileName: string; aLoadOrder: Integer);
    procedure GetMasters(aMasters: TStrings); override;
  end;

  TwbDataContainerFlag = (
    dcfDontCompare,
    dcfDontMerge,
    dcfDontSave,
    dcfStorageInvalid,
    dcfBasePtrInvalid
  );

  TwbDataContainerFlags = set of TwbDataContainerFlag;

  IwbDataContainerInternal = interface(IwbDataContainer)
    ['{E13AE2AD-20CB-4429-86C2-0DEC3ECEE38B}']
    procedure UpdateStorageFromElements;
  end;

  TwbDataContainer = class(TwbContainer, IwbDataContainer, IwbDataContainerInternal)
  protected
    dcBasePtr       : Pointer;
    dcEndPtr        : Pointer;
    dcDataBasePtr   : Pointer;
    dcDataEndPtr    : Pointer;
    dcDataStorage   : TBytes;
    dcFlags         : TwbDataContainerFlags;

    constructor Create(const aContainer      : IwbContainer;
                         var aBasePtr        : Pointer;
                         var aEndPtr         : Pointer;
                       const aPrevMainRecord : IwbMainRecord); virtual;
    procedure AfterConstruction; override;
    procedure InitDataPtr; virtual; abstract;
    function GetDataPrefixSize: Integer; virtual;

    function GetResolvedValueDef: IwbValueDef; override;

    function ContentIsAllZero: Boolean; override;

    procedure InvalidateStorage; override;
    procedure SetContainer(const aContainer: IwbContainer); override;

    procedure SetModified(aValue: Boolean); override;
    procedure RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal); override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function DoCheckSizeAfterWrite: Boolean; virtual;
    procedure SetToDefaultInternal; override;
    function IsFlags: Boolean; virtual;

    function GetEditType: TwbEditType; override;
    function GetEditInfo: TArray<string>; override;

    function GetConflictPriority: TwbConflictPriority; override;

    {---IwbElement---}
    function GetRawDataAsString: string; override;

    {---IwbDataContainer---}
    function GetDataBasePtr: Pointer;
    function GetDataEndPtr: Pointer;
    function GetDataSize: Integer; override;
    procedure SetDataSize(aSize: Integer); override;
    function GetDontCompare: Boolean;
    function GetDontSave: Boolean;
    function IsValidOffset(aBasePtr, aEndPtr: Pointer; anOffset: Integer): Boolean;
    function IsLocalOffset(anOffset: Integer): Boolean;
    procedure CopyFrom(aSource: Pointer; aSize: Integer);

    {--- IwbDataContainerInternal ---}
    procedure UpdateStorageFromElements; virtual;
  end;

  TwbRecordClass = class of TwbRecord;
  TwbRecord = class(TwbDataContainer, IwbRecord, IwbHasSignature)
  protected
    recSkipped          : Boolean;
  protected
    constructor Create(const aContainer      : IwbContainer;
                         var aBasePtr        : Pointer;
                         var aEndPtr         : Pointer;
                       const aPrevMainRecord : IwbMainRecord); overload; override;

    function GetSignature: TwbSignature;
    function GetDisplaySignature: string; virtual;
    procedure ScanData; virtual; abstract;
    procedure InformPrevMainRecord(const aPrevMainRecord : IwbMainRecord); virtual;
  public
    class function CreateForPtr(var aPtr            : Pointer;
                                var aEndPtr         : Pointer;
                              const aContainer      : IwbContainer;
                              const aPrevMainRecord : IwbMainRecord)
                                                    : IwbRecord;

    function GetName: string; override;
    function GetSkipped: Boolean; override;
    procedure SetSkipped(aValue: Boolean); override;
  end;

  PwbMainRecordStruct = ^TwbMainRecordStruct;
  TwbMainRecordStruct = packed record
    mrsSignature : TwbSignature;
    mrsDataSize  : Cardinal;
    function mrsFlags   : PwbMainRecordStructFlags;
    function mrsFormID  : PwbFormID;
    function mrsVCS1    : PCardinal;
    function mrsVersion : PWord;
    function mrsVCS2    : PWord;
  private
    case Integer of
      0: (
            _Flags     : TwbMainRecordStructFlags;
            _FormID    : TwbFormID;
            _VCS1      : Cardinal;
            _Version   : Word;
            _VCS2      : Word;
         );
      1: (
            _TES3_VCS1  : Cardinal;
            _TES3_Flags : TwbMainRecordStructFlags;
         );
  end;

  IwbMainRecordInternal = interface(IwbMainRecord)
    ['{405C85E0-2261-4078-B99C-199007D31544}']
    procedure AddOverride(const aMainRecord: IwbMainRecord);
    procedure RemoveOverride(const aMainRecord: IwbMainRecord);
    procedure SetMaster(const aMaster: IwbMainRecord);
    procedure YouAreTheMaster(const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer); overload;
    procedure YouAreTheMaster(const aOldMaster: IwbMainRecord; const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer); overload;
    procedure YouGotAMaster(const aMaster: IwbMainRecord);
    procedure SetChildGroup(const aGroup: IwbGroupRecord);
    procedure RemoveChildGroup(const aGroup: IwbGroupRecord);
    procedure SetReferencesInjected(aValue: Boolean);
    procedure ClearForRelease;
    function DoBuildRef(aRemove: Boolean): Boolean;

    procedure SaveRefsToStream(aStream: TStream; aSaveNames: Boolean);
    procedure LoadRefsFromStream(aStream: TStream; aLoadNames: Boolean);

    procedure MakeHeaderWriteable;
    function mrStruct: PwbMainRecordStruct;

    function IsSameData(aBase, aEnd: Pointer): Boolean;
  end;

  IwbMainRecordEntry = interface(IwbMainRecordInternal)
    ['{0C89F580-C95A-4A6C-85EA-BD5E411788A4}']
    procedure RemoveEntry;
    procedure RemoveEntryInternal;

    procedure InsertEntryAfter(const aEntry: IwbMainRecordEntry);
    procedure InsertEntryHead;
    procedure InsertEntryTail;

    function GetPrevEntry: IwbMainRecordEntry;
    procedure SetPrevEntry(const aEntry: IwbMainRecordEntry);

    function GetNextEntry: IwbMainRecordEntry;
    procedure SetNextEntry(const aEntry: IwbMainRecordEntry);

    function GetIsInList: Boolean;

    property PrevEntry: IwbMainRecordEntry
      read GetPrevEntry
      write SetPrevEntry;

    property NextEntry: IwbMainRecordEntry
      read GetNextEntry
      write SetNextEntry;

    property IsInList: Boolean
      read GetIsInList;
  end;

  TwbMainRecordState = (
    mrsBuildingRef,
    mrsReferencedByUnsorted,
    mrsIsInjected,
    mrsIsInjectedChecked,
    mrsReferencesInjected,
    mrsReferencesInjectedChecked,
    mrsSearchingChildGroup,
    mrsHasVWDMeshChecked,
    mrsHasVWDMesh,
    mrsHasPrecombinedMeshChecked,
    mrsHasPrecombinedMesh,
    mrsBaseRecordChecked,
    mrsHasGridCell,
    mrsGridCellChecked,
    mrsQuickInit,
    mrsQuickInitDone,
    mrsHasMeshChecked,
    mrsHasMesh,
    mrsNoUpdateRefs,
    mrsBasePtrAllocated,
    mrsOverridesSorted,
    mrsEditorIDFromCache,
    mrsFullNameFromCache,
    mrsResettingConflict,
    mrsOFSTRemoved,
    mrsIndexKeysActive
  );

  TwbMainRecordStates = set of TwbMainRecordState;

  IwbContainedIn = interface
    ['{002F064A-81B8-40EB-AA09-E5F7AE061D9E}']
    procedure ContainerChanged;
  end;

  TwbMainRecord = class(TwbRecord, IwbMainRecord, IwbMainRecordInternal, IwbMainRecordEntry, IwbContainedIn)
  protected
    mrDef               : IwbMainRecordDef;
    mrLoadOrderFormID   : TwbFormID;
    mrFixedFormID       : TwbFormID;
    mrMaster            : Pointer{IwbMainRecord};
    mrOverrides         : TDynMainRecords;
    mrMasterAndLeafs    : array of Pointer{IwbMainRecord};
    mrEditorID          : string;
    mrFullName          : string;
    mrStates            : TwbMainRecordStates;
    mrBaseRecordID      : TwbFormID;
    mrGridCell          : TwbGridCell;
    mrPrecombinedCellID : Cardinal;
    mrPrecombinedID     : Cardinal;
    mrConflictAll       : TConflictAll;
    mrConflictThis      : TConflictThis;
    mrDataStorage       : TBytes;
    mrGroup             : IwbGroupRecord;
    mrGroupSearchGen    : Integer;

    mrReferencedBy      : TDynMainRecords;
    mrReferencedByCount : Integer;
    mrReferencedBySize  : Integer;

    mrReferences        : TwbFormIDs;
    mrTmpRefFormIDs     : TwbFormIDDictionary;

    mreGeneration       : Integer;
    mrePrev             : Pointer;
    mreNext             : Pointer;

    mrName              : string;
    mrShortName         : string;
    mrDisplayName       : string;

    mrLGeneration       : Integer;

    mrPositionGeneration: Integer;

    mrIndexKeys         : TwbIndexKeys;

    function mrStruct: PwbMainRecordStruct; inline;

    procedure mrInvalidateNameCache;

    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    function RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement; overload; override;
    function ResolveElementName(aName: string; out aRemainingName: string; aCanCreate: Boolean = False): IwbElement; override;

    function GetIsInjected: Boolean; override;
    function GetReferencesInjected: Boolean; override;
    function GetInjectionSourceFiles: TwbFiles; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;
    function GetIsNotReachable: Boolean; override;
    function GetIsReachable: Boolean; override;
    function GetCountedRecordCount: Cardinal; override;
    procedure InitDataPtr; override;
    procedure DecompressIfNeeded;
    procedure ScanData; override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function CanContainFormIDs: Boolean; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function CanElementReset: Boolean; override;
    procedure Remove; override;
    procedure PrepareSave; override;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
    function GetReferenceFile: IwbFile; override;
    procedure ReportRequiredMasters(aDict: TwbFilesDictionary; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false); override;
    function LinksToParent: Boolean; override;
    function Reached: Boolean; override;
    function GetContainingMainRecord: IwbMainRecord; override;
    procedure DoAfterSet(const aOldValue, aNewValue: Variant); override;
    procedure SetParentModified; override;
    procedure SetModified(aValue: Boolean); override;

    function DoBuildRef(aRemove: Boolean): Boolean;
    procedure BuildRef; override;
    procedure AddReferencedFromID(aFormID: TwbFormID); override;
    procedure ResetConflict; override;
    procedure ResetReachable; override;

    procedure NotifyChangedInternal(aContainer: Pointer); override;

    procedure Init; override;
    procedure Reset; override;

    function GetPath: string; override;
    function GetValue: string; override;
    function GetSummary: string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetSortPriority: Integer; override;
    function GetAdditionalElementCount: Integer; override;
    function GetIsEditable: Boolean; override;
    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;
    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;
    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    procedure SetContainer(const aContainer: IwbContainer); override;

    function FindReferencedBy(const aMainRecord: IwbMainRecord; var Index: Integer): Boolean;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;

    procedure CollapseStorage(aKAR: PwbKeepAliveRoot; aForce: Boolean);

    function GetAddList: TDynStrings; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function CheckChildOfCell: Boolean;
    procedure UpdateCellChildGroup;
    procedure UpdateInteriorCellGroup;

    procedure MarkModifiedRecursive(const aElementTypes: TwbElementTypes); override;

    procedure UpdateStorageFromElements; override;

    function BuildIndexKeys(out aKeys: TwbIndexKeys): Boolean;

    {---IwbMainRecord---}
    function GetDef: IwbNamedDef; override;
    function GetMainRecordDef: IwbMainRecordDef;
    function GetElementType: TwbElementType; override;
    function GetFormID: TwbFormID; inline;
    function GetFixedFormID: TwbFormID; inline;
    function DoGetFixedFormID: TwbFormID;
    function GetLoadOrderFormID: TwbFormID; inline;
    function DoGetLoadOrderFormID: TwbFormID;
    procedure SetLoadOrderFormID(aFormID: TwbFormID);
    function GetEditorID: string;
    function GetCanHaveEditorID: Boolean;
    function GetCanHaveFullName: Boolean;
    function GetCanHaveBaseRecord: Boolean;
    procedure SetEditorID(const aValue: string);
    function GetFullName: string;
    function GetDisplayNameKey: string;
    function GetMaster: IwbMainRecord;
    function GetIsMaster: Boolean;
    function GetMasterOrSelf: IwbMainRecord;
    function GetOverride(aIndex: Integer): IwbMainRecord;
    function GetOverrideCount: Integer;
    procedure AddReferencedBy(const aMainRecord: IwbMainRecord);
    procedure RemoveReferencedBy(const aMainRecord: IwbMainRecord);
    procedure SortReferencedBy;
    function GetReferencedBy(aIndex: Integer): IwbMainRecord;
    function GetReferencedByCount: Integer;
    function GetReference(aIndex: Integer): IwbMainRecord;
    function GetReferencesCount: Integer;
    function GetExternalReferencesCount: Integer;
    function GetCheck: string; override;
    function GetIsWinningOverride: Boolean;
    function GetWinningOverride: IwbMainRecord;
    function GetHighestOverrideOrSelf(aMaxLoadOrder: Integer): IwbMainRecord;
    function GetHighestOverrideVisibleForFile(const aFile: IwbFile): IwbMainRecord;
    function GetAllVisibleForFile(const aFile: IwbFile): TDynMainRecords;
    function GetChildBySignature(const aSignature: TwbSignature): IwbMainRecord;
    function GetChildByGridCell(const aGridCell: TwbGridCell): IwbMainRecord;
    function GetFlags: TwbMainRecordStructFlags;
    function GetFlagsPtr: PwbMainRecordStructFlags;
    function GetChildGroup: IwbGroupRecord;
    function EnsureChildGroup: IwbGroupRecord;
    function GetBaseRecord: IwbMainRecord;
    function GetBaseRecordID: TwbFormID;
    function GetBaseRecordSignature: TwbSignature;
    function GetMasterAndLeafs: TDynMainRecords;

    procedure MakeHeaderWriteable;

    function GetConflictAll: TConflictAll;
    procedure SetConflictAll(aValue: TConflictAll);
    function GetConflictThis: TConflictThis;
    procedure SetConflictThis(aValue: TConflictThis);

    function GetIsESM: Boolean;
    procedure SetIsESM(aValue: Boolean);
    function GetIsLocalized: Boolean;
    procedure SetIsLocalized(aValue: Boolean);
    function GetIsPersistent: Boolean;
    procedure SetIsPersistent(aValue: Boolean);
    function GetIsDeleted: Boolean;
    procedure SetIsDeleted(aValue: Boolean);
    function GetIsPartialForm: Boolean;
    procedure SetIsPartialForm(aValue: Boolean);
    function GetCanBePartial: Boolean;
    function GetIsCompressed: Boolean;
    procedure SetIsCompressed(aValue: Boolean);
    function GetIsVisibleWhenDistant: Boolean;
    procedure SetIsVisibleWhenDistant(aValue: Boolean);
    function GetHasVisibleWhenDistantMesh: Boolean;
    function GetHasMesh: Boolean;
    function GetHasPrecombinedMesh: Boolean;
    function GetPrecombinedMesh: string;
    function GetIsInitiallyDisabled: Boolean;
    procedure SetIsInitiallyDisabled(aValue: Boolean);
    function GetIsLight: Boolean;
    procedure SetIsLight(aValue: Boolean);
    function GetIsMedium: Boolean;
    procedure SetIsMedium(aValue: Boolean);
    function GetIsOverlay: Boolean;
    procedure SetIsOverlay(aValue: Boolean);

    procedure UpdateRefs;
    procedure UpdateKeys;

    function GetPosition(out aPosition: TwbVector): Boolean;
    function SetPosition(const aPosition: TwbVector): Boolean;
    function GetRotation(out aRotation: TwbVector): Boolean;
    function GetScale(out aScale: Single): Boolean;
    function GetGridCell(out aGridCell: TwbGridCell): Boolean;
    function SetGridCell(const aGridCell: TwbGridCell): Boolean;
    function GetFormVersion: Cardinal; {>>> Form Version access <<<}
    procedure SetFormVersion(aFormVersion: Cardinal); {>>> Form Version access <<<}
    function GetFormVCS1: Cardinal;
    procedure SetFormVCS1(aVCS: Cardinal);
    function GetFormVCS2: Cardinal;
    procedure SetFormVCS2(aVCS: Cardinal);
    procedure ChangeFormSignature(aSignature: TwbSignature);
    procedure ClampFormID(aIndex: Byte);

    function ContentEquals(const aMainRecord: IwbMainRecord): Boolean;

    procedure Delete;
    procedure DeleteInto(const aFile: IwbFile);

    procedure MakePartialForm;

    function MasterRecordsFromMasterFilesAndSelf: TDynMainRecords;

    function ActivateIndexKeys: TwbDefinedKeys;
    function DeactivateIndexKeys: TwbDefinedKeys;

    {---IwbMainRecordInternal---}
    procedure AddOverride(const aMainRecord: IwbMainRecord);
    procedure RemoveOverride(const aMainRecord: IwbMainRecord);
    procedure SetMaster(const aMaster: IwbMainRecord);
    procedure YouAreTheMaster(const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer); overload;
    procedure YouAreTheMaster(const aOldMaster: IwbMainRecord; const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer); overload;
    procedure YouGotAMaster(const aMaster: IwbMainRecord);
    procedure SetChildGroup(const aGroup: IwbGroupRecord);
    procedure RemoveChildGroup(const aGroup: IwbGroupRecord);
    procedure SetReferencesInjected(aValue: Boolean);
    procedure ClearForRelease;
    procedure SaveRefsToStream(aStream: TStream; aSaveNames: Boolean);
    procedure LoadRefsFromStream(aStream: TStream; aLoadNames: Boolean);
    function IsSameData(aBase, aEnd: Pointer): Boolean;

    {---IwbMainRecordEntry---}
    procedure RemoveEntry;
    procedure RemoveEntryInternal;

    procedure InsertEntryAfter(const aEntry: IwbMainRecordEntry);
    procedure InsertEntryHead;
    procedure InsertEntryTail;

    function GetPrevEntry: IwbMainRecordEntry;
    procedure SetPrevEntry(const aEntry: IwbMainRecordEntry);

    function GetNextEntry: IwbMainRecordEntry;
    procedure SetNextEntry(const aEntry: IwbMainRecordEntry);

    function GetIsInList: Boolean;

    {--- IwbContainedIn ---}
    procedure ContainerChanged;
  public
    constructor Create(const aContainer      : IwbContainer;
                         var aBasePtr        : Pointer;
                         var aEndPtr         : Pointer;
                       const aPrevMainRecord : IwbMainRecord); override;
    constructor Create(const aContainer : IwbContainer;
                       const aSignature : TwbSignature;
                             aFormID    : TwbFormID); overload;
    destructor Destroy; override;

    function GetName: string; override;
    function GetShortNameInternal(aForName: Boolean): string; virtual;
    function GetShortName: string; override;
    function GetDisplayName(aUseSuffix: Boolean): string; override;
  end;

  PwbSubRecordHeaderStruct = ^TwbSubRecordHeaderStruct;
  TwbSubRecordHeaderStruct = packed record
  private
    function srsGetDataSize: Cardinal;
    procedure srsSetDataSize(const Value: Cardinal);
  public
    srsSignature : TwbSignature;
    property srsDataSize: Cardinal
      read srsGetDataSize
      write srsSetDataSize;

    class function SizeOf: NativeInt; static;
    //not allowed, so assignments can try to copy too much data! WARNING!
    //class operator Implicit(const aSource : TwbSubRecordHeaderStruct): TwbSubRecordHeaderStruct;
  private
    case Integer of
      0: (_DataSizeCardinal : Cardinal);
      1: (_DataSizeWord     : Word);
  end;

  IwbSubRecordInternal = interface(IwbSubRecord)
    ['{AB66BAE8-2618-4B85-80CE-A108C3B80808}']
    procedure SetDef(const aDef: IwbSubRecordDef);
  end;

  TwbSubRecordState = (
    srsIsArray,
    srsIsFlags,
    srsIsUnion,
    srsSorted,
    srsSortInvalid
  );

  TwbSubRecordStates = set of TwbSubRecordState;

  TwbSubRecord = class(TwbRecord, IwbSubRecord, IwbSubRecordInternal, IwbSortableContainer)
  protected {private}
    srDef                : IwbSubRecordDef;
    srValueDef           : IwbValueDef;
    srResolvedDef        : IwbValueDef;
    srStates             : TwbSubRecordStates;
    srArraySizePrefix    : Integer;
  protected
    constructor Create(const aContainer : IwbContainer;
                       const aSubRecordDef: IwbSubRecordDef); overload;
    destructor Destroy; override;

    procedure SetDef(const aDef: IwbSubRecordDef);
    function srStruct: PwbSubRecordHeaderStruct; inline;

    procedure InitDataPtr; override;
    procedure ScanData; override;

    procedure DoInit(aNeedSorted: Boolean); override;
    procedure Init; override;
    procedure Reset; override;

    function GetDataPrefixSize: Integer; override;
    procedure CheckCount;

    function GetName: string; override;
    function GetDisplayName(aUseSuffix: Boolean): string; override;

    function GetDisplaySignature: string; virtual;   

    procedure ResetMemoryOrder(aFrom: Integer = 0; aTo: Integer = High(Integer)); override;

    function IsFlags: Boolean; override;

    procedure BeforeActualRemove; override;
    procedure DoAfterSet(const aOldValue, aNewValue: Variant); override;
    procedure UpdateCountViaPath;

    function GetValue: string; override;
    function GetSummary: string; override;
    function GetCheck: string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetIsEditable: Boolean; override;
    function GetValueDef: IwbValueDef; override;
    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;
    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;
    procedure BuildRef; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    procedure SetModified(aValue: Boolean); override;
    function CanContainFormIDs: Boolean; override;
    function CanElementReset: Boolean; override;
    function InternalGetLinksTo: IwbElement; override;
    procedure SetLinksTo(const aValue: IwbElement); override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    procedure PrepareSave; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;
    function ResetLeafFirst: Boolean; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    procedure SetToDefaultInternal; override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;
    function GetIsInSK(aIndex: Integer): Boolean; override;
    function DoCheckSizeAfterWrite: Boolean; override;

    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;

    function GetDataSize: Integer; override;

    function CanMoveElement: Boolean; override;

    procedure CheckTerminator;

    procedure NotifyChangedInternal(aContainer: Pointer); override;

    function MergeMultiple(const aElement: IwbElement): Boolean; override;

    {--- IwbSubRecord ---}
    function GetSubRecordHeaderSize: Integer;

    {--- IwbSortableContainer ---}
    function GetSorted: Boolean;
    function GetAlignable: Boolean;
  end;

  TwbValueBase = class(TwbDataContainer, IwbValueBase)
  protected
    vbValueDef   : IwbValueDef;
  protected
    procedure InitDataPtr; override;

    function GetDef: IwbNamedDef; override;
    function GetValueDef: IwbValueDef; override;

    function GetName: string; override;
    function GetBaseName: string; override;
    function GetDisplayName(aUseSuffix: Boolean): string; override;

    function GetCheck: string; override;
    function GetValue: string; override;
    function GetSummary: string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;

    function GetIsEditable: Boolean; override;
    function CanElementReset: Boolean; override;

    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;

    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;

    procedure BuildRef; override;
    function CanContainFormIDs: Boolean; override;
    function InternalGetLinksTo: IwbElement; override;
    procedure SetLinksTo(const aValue: IwbElement); override;
    function GetDataSize: Integer; override;
    function DoCheckSizeAfterWrite: Boolean; override;

    procedure SetToDefaultInternal; override;

    function GetIsInSK(aIndex: Integer): Boolean; override;
  public
    constructor Create(const aContainer  : IwbContainer;
                         var aBasePtr    : Pointer;
                             aEndPtr     : Pointer;
                       const aValueDef   : IwbValueDef;
                       const aNameSuffix : string;
                             aDontCompare: Boolean = False); reintroduce; overload;
    constructor Create(const aContainer  : IwbContainer;
                       const aValueDef   : IwbValueDef;
                       const aSource     : IwbElement;
                       const aOnlySK     : Boolean;
                       const aNameSuffix : string); reintroduce; overload;
  end;

  TwbArray = class(TwbValueBase, IwbSortableContainer, IwbArray)
  protected {private}
    arrSorted        : Boolean;
    arrSortInvalid   : Boolean;
    arrSizePrefix    : Integer;
  protected
    procedure DoInit(aNeedSorted: Boolean); override;
    procedure Init; override;
    procedure Reset; override;

    procedure SetToDefaultInternal; override;

    procedure ResetMemoryOrder(aFrom: Integer = 0; aTo: Integer = High(Integer)); override;

    procedure BeforeActualRemove; override;
    procedure DoAfterSet(const aOldValue, aNewValue: Variant); override;
    procedure UpdateCountViaPath;

    function GetElementType: TwbElementType; override;
    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    procedure SetModified(aValue: Boolean); override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;

    procedure PrepareSave; override;
    procedure CheckTerminator;

    function GetDataPrefixSize: Integer; override;
    procedure CheckCount;
    procedure NotifyChangedInternal(aContainer: Pointer); override;

    function CanMoveElement: Boolean; override;

    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function GetIsClearable: Boolean; override;
    procedure Clear; override;

    {--- IwbSortableContainer ---}
    function GetSorted: Boolean;
    function GetAlignable: Boolean;
  end;

  TwbStruct = class(TwbValueBase, IwbStruct)
  protected
    szCompressedSize   : Integer;
    szUncompressedSize : Cardinal;
    szCompressedType   : TwbStructCompression;
  protected
    procedure Init; override;
    procedure Reset; override;

    function GetElementType: TwbElementType; override;
    procedure DecompressIfNeeded;
    function GetIsCompressed: TwbStructCompression;
    property IsCompressed: TwbStructCompression read GetIsCompressed;
  end;

  TwbFileHeader = class(TwbStruct, IwbFileHeader)
  protected
    function GetFileMagic: TwbFileMagic;
  end;

  TwbChapter = class(TwbStruct, IwbChapter)
  protected
    cChapterSkipped : Boolean;
  protected
    function GetSkipped: Boolean; override;
    function GetElementType: TwbElementType; override;
    function GetChapterType: Integer;
    function GetChapterTypeName: String;
    function GetChapterName: String;
  public
    constructor Create(const aContainer  : IwbContainer;
                       const aValueDef   : IwbValueDef;
                       const aSource     : IwbElement;
                       const aOnlySK     : Boolean;
                       const aNameSuffix : string);  reintroduce; overload;
  end;

  TwbUnion = class(TwbValueBase, IwbUnion)
  protected
    unResolvedDef: IwbValueDef;
  protected
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    procedure Init; override;
    procedure Reset; override;
    function GetResolvedValueDef: IwbValueDef; override;

    function GetElementType: TwbElementType; override;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;

    {---IwbUnion---}
    procedure RecheckDecider;
  end;

  TwbRecordHeaderStruct = class(TwbStruct, IwbRecordHeaderStruct)
  protected
    function CanContainFormIDs: Boolean; override;
    procedure BuildRef; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function IsElementEditable(const aElement: IwbElement): Boolean; override;
    function GetIsEditable: Boolean; override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;
  end;

  TwbValue = class(TwbValueBase, IwbSortableContainer)
  protected {private}
    vIsFlags     : Boolean;
    vResolvedDef : IwbValueDef;
  protected
    function GetValue: string; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;

    function IsFlags: Boolean; override;

    procedure Init; override;
    procedure Reset; override;
    function GetResolvedValueDef: IwbValueDef; override;

    function GetElementType: TwbElementType; override;
    procedure SetEditValue(const aValue: string); override;
    procedure SetNativeValue(const aValue: Variant); override;

    {--- IwbSortableContainer ---}
    function GetSorted: Boolean;
    function GetAlignable: Boolean;
  end;

  TwbContainedInElement = class(TwbValue, IwbContainedIn)
  protected {private}
    cieLockCount: Integer;
  protected
    procedure InvalidateParentStorage; override;
    function CanContainFormIDs: Boolean; override;
    procedure BuildRef; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function IsElementEditable(const aElement: IwbElement): Boolean; override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    procedure SetModified(aValue: Boolean); override;
    procedure DoAfterSet(const aOldValue, aNewValue: Variant); override;

    {--- IwbContainedIn ---}
    procedure ContainerChanged;
  public
    constructor Create(const aMainRecord: IwbMainRecord);
  end;

  TwbStringListTerminator = class(TwbElement, IwbStringListTerminator)
    function GetName: string; override;
    function GetElementType: TwbElementType; override;
    function GetConflictPriority: TwbConflictPriority; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    procedure SetEditValue(const aValue: string); override;
    procedure SetNativeValue(const aValue: Variant); override;
    function GetDataSize: Integer; override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function GetDontShow: Boolean; override;
  end;

  IwbFlag = interface(IwbElement)
  ['{EED55516-C6D5-4ADD-B147-36B115E7449D}']
    function GetFlagsDef: IwbFlagsDef;
    function GetFlagIndex: Integer;

    property FlagsDef: IwbFlagsDef
      read GetFlagsDef;
    property FlagIndex: Integer
      read GetFlagIndex;
  end;

  TwbFlag = class(TwbElement, IwbFlag)
  protected {private}
    fBasePtr    : Pointer;
    fEndPtr     : Pointer;
    fIntegerDef : IwbIntegerDef;
    fFlagsDef   : IwbFlagsDef;
    fLastDefID  : Cardinal;
    fIndex      : Integer;
  protected
    constructor Create(const aContainer  : IwbContainer;
                             aBasePtr    : Pointer;
                             aEndPtr     : Pointer;
                       const aIntegerDef : IwbIntegerDef;
                       const aFlagsDef   : IwbFlagsDef;
                             aIndex      : Integer);

    function GetName: string; override;
    function GetDef: IwbNamedDef; override;
    function GetValueDef: IwbValueDef; override;

    function GetValue: string; override;
    function GetSummary: string; override;
    function GetSortKey(aExtended: Boolean): string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetConflictPriority: TwbConflictPriority; override;
    function GetDontShow: Boolean; override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function GetDataSize: Integer; override;
    procedure InvalidateParentStorage; override;

    function GetIsEditable: Boolean; override;
    function GetIsRemovable: Boolean; override;

    procedure Remove; override;

    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;

    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;

    function GetElementType: TwbElementType; override;

    {--- IwbFlag ---}
    function GetFlagsDef: IwbFlagsDef;
    function GetFlagIndex: Integer;
  end;

  PwbGroupRecordStruct = ^TwbGroupRecordStruct;
  TwbGroupRecordStruct = packed record
    grsSignature : TwbSignature;
    grsGroupSize : Cardinal;
    grsLabel     : Cardinal;
    grsGroupType : Integer;
    grsStamp     : Cardinal;
    grsUnknown   : Cardinal;
  end;

  IwbGroupRecordInternal = interface(IwbGroupRecord)
    ['{0BDDCF46-DFF6-4771-8FBB-0BC78828999B}']
    procedure SetModified(aValue: Boolean);
    procedure IsDuplicateOf(const aGroup: IwbGroupRecord);
  end;

  TwbGroupState = (
    gsSorted,
    gsSorting,
    gsSortPostponed,
    gsSortForcedPostponed,
    gsInformedMainRecord
  );

  TwbGroupStates = set of TwbGroupState;

  TwbGroupRecord = class(TwbRecord, IwbGroupRecord, IwbGroupRecordInternal, IwbContainedIn)
  protected {private}
    grStates      : TwbGroupStates;
    grDuplicateOf : IwbGroupRecord;
  protected
    constructor Create(const aContainer  : IwbContainer;
                       const aSignature  : TwbSignature); overload;
    constructor Create(const aContainer  : IwbContainer;
                             aType       : Integer;
                       const aMainRecord : IwbMainRecord); overload;
    constructor Create(const aContainer  : IwbContainer;
                             aType       : Integer;
                             aLabel      : Cardinal); overload;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    function grStruct: PwbGroupRecordStruct; inline;

    function GetCountedRecordCount: Cardinal; override;
    procedure InitDataPtr; override;
    procedure ScanData; override;
    procedure InformPrevMainRecord(const aPrevMainRecord : IwbMainRecord); override;

    function GetName: string; override;
    function GetShortName: string; override;
    function GetElementType: TwbElementType; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    procedure Remove; override;
    procedure NotifyChangedInternal(aContainer: Pointer); override;

    function CanCopy: Boolean; override;

    function GetAddList: TDynStrings; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;
    procedure Sort(aForce: Boolean = False);

    procedure UpdateEnded; override;

    procedure SetModified(aValue: Boolean); override;

    procedure PrepareSave; override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified); override;
    function MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean; override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;

    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;

    procedure MakeHeaderWriteable;

    procedure BuildRef; override;
    function LinksToParent: Boolean; override;
    function Reached: Boolean; override;

    function FindChildGroup(aType: Integer; const aMainRecord: IwbMainRecord): IwbGroupRecord; overload;
    function FindChildGroup(aType: Integer; const aLabel: Cardinal): IwbGroupRecord; overload;

    function GetMainRecordByEditorID(const aEditorID: string): IwbMainRecord;
    function GetMainRecordByFormID(const aFormID: TwbFormID): IwbMainRecord;

    function GetGroupType: Integer; inline;
    function GetGroupLabel: Cardinal; inline;
    function GetGroupLabelSignature: string;
    procedure SetGroupLabel(aLabel: Cardinal);
    function GetChildrenOf: IwbMainRecord;

    procedure AddElement(const aElement: IwbElement); override;

    procedure ContainerChanged;

    procedure IsDuplicateOf(const aGroup: IwbGroupRecord);
  end;

  IwbSubRecordArrayInternal = interface(IwbSubRecordArray)
    ['{4400F93F-9D13-43CA-B43D-727725EC73C8}']

    procedure DoProcess(const aContainer : IwbContainer;
                              aPos       : Integer);
  end;

  TwbSubRecordArray = class(TwbContainer, IwbSubRecordArray, IwbSubRecordArrayInternal, IwbSortableContainer, IwbHasSignature)
  protected {private}
    arcDef         : IwbSubRecordArrayDef;
    arcSorted      : Boolean;
    arcSortInvalid : Boolean;
    arcNameGen     : Integer;
  protected
    constructor Create(const aOwner     : IwbContainer;
                       const aContainer : IwbContainer;
                             aPos       : Integer;
                       const aDef       : IwbSubRecordArrayDef);

    procedure DoProcess(const aContainer : IwbContainer;
                              aPos       : Integer);

    procedure DoInit(aNeedSorted: Boolean); override;

    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    procedure BeforeActualRemove; override;
    procedure DoAfterSet(const aOldValue, aNewValue: Variant); override;
    procedure UpdateCountViaPath;

    function GetValue: string; override;
    function GetCheck: string; override;
    function GetSummary: string; override;
    function GetName: string; override;
    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;
    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    procedure SetModified(aValue: Boolean); override;
    function CanContainFormIDs: Boolean; override;
    function CanElementReset: Boolean; override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;

    procedure SetToDefaultInternal; override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
//    function GetAssignTemplates(aIndex: Integer): TwbTemplateElements; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;

    function CanMoveElement: Boolean; override;

    procedure UpdateNameSuffixes; override;

    {---IwbSortableContainer---}
    function GetSorted: Boolean;
    function GetAlignable: Boolean;

    {--- IwbHasSignature ---}
    function GetSignature: TwbSignature;
  end;

  TwbSubRecordStruct = class(TwbContainer, IwbSubRecordStruct, IwbHasSignature)
  protected {private}
    srcDef: IwbRecordDef;
  protected
    constructor Create(const aOwner     : IwbContainer;
                       const aContainer : IwbContainer;
                             aPos       : Integer;
                       const aDef       : IwbSubRecordStructDef);

    procedure TryAssignMembers(const aSource: IwbElement); override;

    procedure AddRequiredElements;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function GetValue: string; override;
    function GetSummary: string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetCheck: string; override;
    function GetName: string; override;
    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;
    function IsElementRemovable(const aElement: IwbElement): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    function CanElementReset: Boolean; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
//    function GetAssignTemplates(aIndex: Integer): TwbTemplateElements; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement; override;
    function GetIsInSK(aIndex: Integer): Boolean; override;

    {--- IwbHasSignature ---}
    function GetSignature: TwbSignature;
  end;

const
  NONE : TwbSignature = #0#0#0#0;

function CompareFormIDs(Item1, Item2: Cardinal): Integer;
asm
{$IFDEF WIN32}
  xor ecx, ecx
  cmp eax, edx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
{$ENDIF WIN32}
{$IFDEF WIN64}
  xor eax, eax
  cmp ecx, edx
  ja @@GT
  je @@EQ
@@LT:
  dec eax
  dec eax
@@GT:
  inc eax
@@EQ:
{$ENDIF WIN64}
end;

function CompareSubRecords(Item1, Item2: Pointer): Integer;
var
  SortOrder1: Integer;
  SortOrder2: Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  SortOrder1 := IwbElement(Item1).SortOrder;
  SortOrder2 := IwbElement(Item2).SortOrder;

  Result := CmpI32(SortOrder1, SortOrder2);

  if Result = 0 then begin
    Result := CmpW32(Ord(IwbElement(Item1).ElementType), Ord(IwbElement(Item2).ElementType));
    if Result = 0 then begin
      if IwbElement(Item1).ElementType = etSubRecord then
        {$IFDEF WIN64}
        Result := CmpI64(
          UInt64((IwbElement(Item1) as IwbSubRecord).DataBasePtr),
          UInt64((IwbElement(Item2) as IwbSubRecord).DataBasePtr)
        );
        {$ENDIF}
        {$IFDEF WIN32}
        Result := CmpW32(
          Cardinal((IwbElement(Item1) as IwbSubRecord).DataBasePtr),
          Cardinal((IwbElement(Item2) as IwbSubRecord).DataBasePtr)
        );
        {$ENDIF}
    end;
  end;
end;

function CompareSortKeys(Item1, Item2: Pointer): Integer;
var
  SortKey1   : string;
  SortKey2   : string;
//  Container1 : IwbContainer;
//  Container2 : IwbContainer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  SortKey1 := IwbElement(Item1).SortKey[True];
  SortKey2 := IwbElement(Item2).SortKey[True];

  Result := CompareStr(SortKey1, SortKey2);

  if Result = 0 then begin
    SortKey1 := IwbElement(Item1).EditValue;
    SortKey2 := IwbElement(Item1).EditValue;

    Result := CompareStr(SortKey1, SortKey2);

    if Result = 0 then begin
      Result := CmpW32(Ord(IwbElement(Item1).ElementType), Ord(IwbElement(Item2).ElementType));
      if Result = 0 then begin
        if IwbElement(Item1).ElementType = etSubRecord then
          {$IFDEF WIN64}
          Result := CmpI64(
            UInt64((IwbElement(Item1) as IwbSubRecord).DataBasePtr),
            UInt64((IwbElement(Item2) as IwbSubRecord).DataBasePtr)
          );
          {$ENDIF}
          {$IFDEF WIN32}
          Result := CmpW32(
            Cardinal((IwbElement(Item1) as IwbSubRecord).DataBasePtr),
            Cardinal((IwbElement(Item2) as IwbSubRecord).DataBasePtr)
          );
          {$ENDIF}
        {else try
          if Supports(IwbElement(Item1), IwbContainer, Container1) and Supports(IwbElement(Item2), IwbContainer, Container2) then
            Result := CmpW32(
              Cardinal((Container1 as TwbContainer).cntElements),  // Arbitrary value that should not change during the sort
              Cardinal((Container2 as TwbContainer).cntElements)
            );
        except
          // If an Element supporting IwbContainer could NOT be a TwbContainer
        end;}
      end;
    end;
  end;
end;


function CompareSortOrder(Item1, Item2: Pointer): Integer;
var
  SortOrder1: Integer;
  SortOrder2: Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  SortOrder1 := IwbElement(Item1).SortOrder;
  SortOrder2 := IwbElement(Item2).SortOrder;

  Result := CmpI32(SortOrder1, SortOrder2);
end;

function CompareMemoryOrder(Item1, Item2: Pointer): Integer;
var
  MemoryOrder1: Integer;
  MemoryOrder2: Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  MemoryOrder1 := IwbElement(Item1).MemoryOrder;
  MemoryOrder2 := IwbElement(Item2).MemoryOrder;

  Result := CmpI32(MemoryOrder1, MemoryOrder2);
end;

function CompareLoadOrder(Item1, Item2: Pointer): Integer;
var
  LoadOrder1: Integer;
  LoadOrder2: Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  LoadOrder1 := IwbFile(Item1).LoadOrder;
  LoadOrder2 := IwbFile(Item2).LoadOrder;

  Result := CmpI32(LoadOrder1, LoadOrder2);
  if Result = 0 then
    Result := CmpPtr(IwbFile(Item1).ElementID, IwbFile(Item2).ElementID);
end;

{ TwbFile }

var
  _FileGeneration: Integer = 1;
  _GlobalGeneration: Integer = 1;

procedure TwbFile.AddMaster(const aFileName: string; IsTemporary: Boolean; aAutoLoadOrder: Boolean);
var
  _File : IwbFile;
  s     : string;
  t     : string;
  i     : Integer;
  States: TwbFileStates;
begin
  if not wbRequireLoadorder and IsTemporary then begin
    for i := 0 to Pred(GetMasterCount(True)) do
      if SameText(ExtractFileName(aFileName), GetMaster(i, True).FileName) then
        Exit;
  end;

  s := ExtractFilePath(aFileName);
  t := ExtractFileName(aFileName);
  if s = '' then
    if not SameText(ExtractFileExt(t), csDotExe) then
      s := ExtractFilePath(flFileName);
  if s <> '' then
    s := IncludeTrailingPathDelimiter(s);

  if IsTemporary then
    States := [fsIsTemporary]
  else
    States := [];

  flProgress('Adding master "' + t + '"');
  i := -1;
  if aAutoLoadOrder then
    i := High(Integer);

  _File := wbFile(s + t, i, '', States);
  if not (wbToolMode in [tmDump, tmExport]) and (wbRequireLoadOrder and (_File.LoadOrder < 0)) then
    raise Exception.Create('"' + GetFileName + '" requires master "' + aFileName + '" to be loaded before it.')
  else
    AddMaster(_File);
end;

function TwbFile.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  Signature : TwbSignature;
  Dummy     : Integer;
begin
  if not IsElementEditable(nil) then
    raise Exception.Create('File "' + GetFileName + '" is not editable');

  Result := nil;

  if Length(aName) < 4 then
    Exit;

  Signature := StrToSignature(aName);

  Result := GetGroupBySignature(Signature);

  if Assigned(Result) then
    Exit;

  if not wbGroupOrder.Find(Signature, Dummy) then
    Exit;
  if GroupToSkip.Find(Signature, Dummy) then
    Exit;
  if RecordToSkip.Find(Signature, Dummy) then
    Exit;

  Result := TwbGroupRecord.Create(Self, Signature);

  if Length(cntElements) > 1 then
    wbMergeSortPtr(@cntElements[1], High(cntElements), CompareSortOrder);
end;

procedure TwbFile.AddAllMastersToDict(aDict: TwbFilesDictionary);
begin
  var lMasterFileInternal: IwbFileInternal;
  for var lMasterIdx := Pred(GetMasterCount(True)) downto 0 do
    if Supports(GetMaster(lMasterIdx, True), IwbFileInternal, lMasterFileInternal) then
      if aDict.TryAdd(lMasterFileInternal, wbNothing) then
        lMasterFileInternal.AddAllMastersToDict(aDict);
end;

function TwbFile.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  GroupRecord : IwbGroupRecord;
  Dummy       : Integer;
  Signature   : TwbSignature;
  SelfRef     : IwbContainerElementRef;
  i           : Integer;
begin
  if not IsElementEditable(nil) then
    raise Exception.Create('File "' + GetFileName + '" is not editable');

  SelfRef := Self as IwbContainerElementRef;
  if not Supports(aElement, IwbGroupRecord, GroupRecord) then
    raise Exception.Create('Only group records can be added to files');
  if GroupRecord.GroupType <> 0 then
    raise Exception.Create('Only top level group records can be added to files');
  Signature := TwbSignature(GroupRecord.GroupLabel);
  if not wbGroupOrder.Find(Signature, Dummy) then
    raise Exception.Create(Signature + 'is not a valid group label');
  Result := GetGroupBySignature(Signature);
  if not Assigned(Result) then begin
    Result := TwbGroupRecord.Create(Self, Signature);
    if Length(cntElements) > 1 then
      wbMergeSortPtr(@cntElements[1],  High(cntElements), CompareSortOrder);
  end;

  if aDeepCopy then
    for i := 0 to Pred(GroupRecord.ElementCount) do
      Result.AddIfMissing(GroupRecord.Elements[i], aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite);
end;

procedure TwbFile.AddMainRecord(const aRecord: IwbMainRecord);
const
  MGEF      : TwbSignature = 'MGEF';
  GMST      : TwbSignature = 'GMST';
  DFOB      : TwbSignature = 'DFOB';
var
  FormID    : TwbFormID;
  s         : string;
  i         : Integer;
  Master    : IwbMainRecord;
  Signature : TwbSignature;
  GameMasterFile : IwbFileInternal;
begin
  if not Assigned(aRecord) then
    Exit;

  Assert(not Assigned(flRecordProcessing), '[AddMainRecord] Assigned(flRecordProcessing)');
  Assert(Length(flRecordFormIDs) < 1, '[AddMainRecord] Length(flRecordFormIDs) >= 1');

  FormID := aRecord.FixedFormID;

  if not FormID.IsNull then begin

    if flFormIDsSorted then begin

      if Length(flRecords) > 0 then begin
        if FindFormID(FormID, i, True) then
          raise Exception.Create('Duplicate FormID [' + FormID.ToString(True) + '] in file ' + GetName);
      end else
        i := 0;

      SetLength(flRecords, Succ(Length(flRecords)));
      if i < High(flRecords) then begin
        Move(flRecords[i], flRecords[Succ(i)], SizeOf(Pointer) * (High(flRecords) - i));
        Pointer(flRecords[i]) := nil;
      end;
      flRecords[i] := aRecord;

    end else begin

      if wbGameMode > gmTES3 then begin
        var lFixedFormID := aRecord.FixedFormID;
        if flSetContainsFixedFormID(lFixedFormID) then
          raise EwbSkipLoad.Create('Duplicate FormID [' + lFixedFormID.ToString(True) + '] in file ' + GetName);
      end;

      if flRecordsCount >= Length(flRecords) then
        SetLength(flRecords, Succ(flRecordsCount));

      flRecords[flRecordsCount] := aRecord;
      Inc(flRecordsCount);

    end;

    var lFileID := FormID.FileID;
    if IsNewRecord(lFileID, True) and not (fsIsCompareLoad in flStates) and not (FormID.IsHardcoded and not (fsIsGameMaster in flStates))  then begin

      if not wbComplexFileFileID then begin

        if (FormID.ToCardinal and $00FFF000) <> 0 then begin
          Exclude(flStates, fsLightCompatible);
          if wbHasProgressCallback then
            if GetIsLight or flLoadOrderFileID.IsLightSlot then
              wbProgressCallback('<Error: ' + aRecord.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for a light module. You will not be able to save this file with the Light flag active.>');
        end;

        if (FormID.ToCardinal and $00FF0000) <> 0 then begin
          Exclude(flStates, fsMediumCompatible);
          if wbHasProgressCallback then
            if GetIsMedium or flLoadOrderFileID.IsMediumSlot then
              wbProgressCallback('<Error: ' + aRecord.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for a medium module. You will not be able to save this file with the Medium flag active.>');
        end;

      end;

      Exclude(flStates, fsOverlayCompatible);
      if wbHasProgressCallback then
        if GetIsOverlay then
          wbProgressCallback('<Error: ' + aRecord.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for an overlay module. You will not be able to save this file with the Overlay flag active.>');

      {new record...}
    end else try
      Master := GetMasterRecordByFormID(FormID, True, True);
      if Assigned(Master) then
        (Master as IwbMainRecordInternal).AddOverride(aRecord)
      else begin
        if FormID.IsHardcoded and not (fsIsGameMaster in flStates) then begin
          if Supports(wbGetGameMasterFile, IwbFileInternal, GameMasterFile) then
            GameMasterFile.InjectMainRecord(aRecord);
        end else
          (GetMasterForFileID(lFileId, True, False) as IwbFileInternal).InjectMainRecord(aRecord);
      end;
    except
      on E: Exception do
        if wbHasProgressCallback then
          wbProgressCallback('Error: <' + e.Message + '> while trying to determine master record for ' + aRecord.Name);
    end;
  end;

  if flIndicesActive then
    flAddKeysToIndices(aRecord, aRecord.ActivateIndexKeys);

  IncGeneration;
end;

procedure TwbFile.AddMaster(const aFile: IwbFile);
begin
  if not (fsScanning in flStates) then
    if wbStarfieldIsABugInfestedHellhole and wbComplexFileFileID then begin
      if GetModuleType <> mtFull then
        raise Exception.Create('Only full modules can add masters in ' + wbAppName + wbToolName);
      if aFile.ModuleType <> mtFull then
        raise Exception.Create('Only Full modules can be added as masters of other modules in ' + wbAppName + wbToolName);
      for var lMaster in flMasters do
        if lMaster.ModuleType <> mtFull then
          raise Exception.Create('Only modules where all existing masters are Full modules can add masters in ' + wbAppName + wbToolName);
    end;

  SetLength(flMasters, Succ(Length(flMasters)));
  flMasters[High(flMasters)] := aFile;
  UpdateModuleMasters;
end;

procedure TwbFile.AddMasterIfMissing(const aMaster: string; aSortMasters: Boolean = True);
var
  i       : Integer;
  Masters : TStringList;
begin
  for i := 0 to Pred(GetMasterCount(True)) do
    if SameText(aMaster, GetMaster(i, True).FileName) then
      Exit;
  Masters := TStringList.Create;
  try
    Masters.Add(aMaster);
    AddMasters(Masters);
    if aSortMasters then
      SortMasters;
  finally
    Masters.Free;
  end;
end;

procedure TwbFile.AddMasters(const aMasters: array of string);
begin
  If Length(aMasters) < 1 then
    Exit;

  var lMasters := TStringList.Create;
  try
    for var lMaster in aMasters do
      lMasters.Add(lMaster);
    AddMasters(lMasters);
  finally
    lMasters.Free;
  end;
end;

procedure TwbFile.AddMasters(aMasters: TStrings);
var
  NotAllAdded    : Boolean;
  lMasters       : TStringList;

  procedure Inner;
  var
    Header         : IwbContainerElementRef;
    MasterFiles    : IwbContainerElementRef;
    IsNew          : Boolean;
    rec            : IwbRecord;
    i, j           : Integer;
    MaxMasterCount : Integer;
  begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "' + GetFileName + '" is not editable');

    if GetIsNotPlugin then
      Exit;

    if (GetElementCount < 1) or not Supports(GetElement(0), IwbContainerElementRef, Header) then
      raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

    IsNew := False;
    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    if not Assigned(MasterFiles) then begin
      MasterFiles := Header.Add('Master Files') as IwbContainerElementRef;
      Assert(Assigned(MasterFiles), '[AddMasters] not Assigned(MasterFiles)');
      IsNew := True;
    end;

    MaxMasterCount := Succ(TwbFileID.MaxFullSlot);

    if wbBeginInternalEdit(True) then try
      for i := 0 to Pred(lMasters.Count) do begin
        if GetMasterCount(True) >= MaxMasterCount then begin
          NotAllAdded := True;
          Break;
        end;
        if IsNew then begin
          Assert(MasterFiles.ElementCount = 1, '[AddMasters] MasterFiles.ElementCount <> 1');
          Rec := (MasterFiles[0] as IwbContainer).RecordBySignature['MAST'];
          IsNew := False;
        end else begin
          j := MasterFiles.ElementCount;
          MasterFiles.Assign(wbAssignAdd, nil, False);
          Assert(MasterFiles.ElementCount = Succ(j), '[AddMasters]');
          Rec := (MasterFiles[j] as IwbContainer).RecordBySignature['MAST'];
        end;

        Assert(Assigned(Rec), '[AddMasters] not Assigned(Rec)');
        Assert(Rec.EditValue = '', '[AddMasters] Rec.EditValue <> ''''');

        try
          AddMaster(lMasters[i]);
        except
          Rec.Remove;
          raise;
        end;

        Rec.EditValue := lMasters[i];
        Rec := nil;
      end;
    finally
      wbEndInternalEdit;
    end else
      Assert(False, '[AddMasters] not wbBeginInternalEdit');
  end;

var
  i    : Integer;
  s, t : string;
begin;
  NotAllAdded := False;

  lMasters := TStringList.Create;
  flOldMasters := Copy(flMasters);
  try
    if Assigned(aMasters) then
      for i := 0 to Pred(aMasters.Count) do begin
        s := Trim(aMasters[i]);
        t := ExtractFileExt(s);
        if SameText(t, '.esm') or SameText(t, '.esp') or (wbIsLightSupported and SameText(t, '.esl')) then
          lMasters.Add(s);
      end;

    if lMasters.Count < 1 then
      Exit;

    Inner;

    if wbGameMode >= gmTES4 then
      if Length(flOldMasters) <> Length(flMasters) then begin
        MastersUpdated([], [], Length(flOldMasters), Length(flMasters));
        SortRecords;
      end;

    SetModified(True);
    IncGeneration;

    if NotAllAdded then
      raise Exception.Create('Only ' + (Length(flMasters) - Length(flOldMasters)).ToString + ' of ' + lMasters.Count.ToString + ' masters could be added. Master list now contains ' + Length(flMasters).ToString + ' entries and is full.');
  finally
    lMasters.Free;
    flOldMasters := nil;
  end;
end;

threadvar
  _FileRefsBuilding: Boolean;

function TwbFile.BuildOrLoadRef(aOnlyLoad: Boolean): TwbBuildOrLoadRefResult;
var
  CacheFileName : string;
  FileStream    : TBufferedFileStream;
  MemoryStream  : TMemoryStream;
  i             : Integer;
  StartTime,
  EndTime       : TDateTime;
begin
  Result := blrNone;
  if not wbDontCache and (not (fsRefsBuild in flStates)) and ((not (esModified in eStates) or (esInternalModified in eStates))) then begin
    CacheFileName := ExtractFileName(flFileName);
    if CacheFileName.EndsWith(csDotGhost, True) then
      SetLength(CacheFileName, Length(CacheFileName) - Length(csDotGhost));
    CacheFileName :=
            wbCachePath +
            IntToHex64(wbCRC32App, 8) +
      '_' + ChangeFileExt(CacheFileName, '') +
      '_' + Copy(ExtractFileExt(CacheFileName), 2) +
      '_' + GetCRC32.ToString +
      '_g' + GetEncoding(False).CodePage.ToString +
      '_t' + GetEncoding(True).CodePage.ToString +
      '_l' + wbEncodingForLanguage(wbLanguage, False).CodePage.ToString +
      '_' + wbLanguage;

    CacheFileName := CacheFileName + wbRefCacheExt;
    if not wbDontCacheLoad and FileExists(CacheFileName) then begin
      Include(flStates, fsRefsBuild);
      MemoryStream := TMemoryStream.Create;
      try
        FileStream := TBufferedFileStream.Create(CacheFileName, fmOpenRead or fmShareDenyWrite);
        try
          lz4DeCompressStream(FileStream, MemoryStream);
        finally
          FileStream.Free;
      end;
        MemoryStream.Position := 0;
        MemoryStream.Read(flRecordsCount, SizeOf(flRecordsCount));
        Assert(flRecordsCount = Length(flRecords), '[TwbFile.BuildOrLoadRef] flRecordsCount <> Length(flRecords)');
        for i := 0 to Pred(flRecordsCount) do begin
          (flRecords[i] as IwbMainRecordInternal).LoadRefsFromStream(MemoryStream, fsIsGameMaster in flStates);
          wbTick;
        end;
      finally
        MemoryStream.Free;
      end;
      inherited BuildRef;
      Result := blrLoaded;
    end else begin
      if not aOnlyLoad then begin
        Include(flStates, fsRefsBuild);
        StartTime := Now;
        try
          Include(flStates, fsRefsBuilding);
          _FileRefsBuilding := True;
          inherited BuildRef;
        finally
          _FileRefsBuilding := False;
          Exclude(flStates, fsRefsBuilding);
        end;
        EndTime := Now;
        Result := blrBuilt;
        if not wbDontCacheSave then begin
          flRecordsCount := Length(flRecords);
          if (flRecordsCount > wbCacheRecordsThreshold) or (EndTime - StartTime > wbCacheTimeThreshold) then try
            MemoryStream := TMemoryStream.Create;
            try
              MemoryStream.Write(flRecordsCount, SizeOf(flRecordsCount));
              for i := 0 to Pred(flRecordsCount) do begin
                (flRecords[i] as IwbMainRecordInternal).SaveRefsToStream(MemoryStream, fsIsGameMaster in flStates);
                wbTick;
              end;
              MemoryStream.Position := 0;
              FileStream := TBufferedFileStream.Create(CacheFileName, fmCreate);
              try
                lz4CompressStream(MemoryStream, FileStream);
              finally
                FileStream.Free;
              end;
            finally
              MemoryStream.Free;
            end;
            Result := blrBuiltAndSaved;
          except
            //ignore errors when saving cache
          end;
        end;
      end;
    end;
  end else begin
    if not aOnlyLoad then begin
      Include(flStates, fsRefsBuild);
      inherited BuildRef;
      Result := blrBuilt;
    end;
  end;
end;

procedure TwbFile.BuildReachable;
var
  Group    : IwbGroupRecord;
  i        : Integer;
  Rec      : IwbMainRecord;
  Cnt      : IwbContainerElementRef;
  Cnt2     : IwbContainerElementRef;
  Flg      : IwbElement;
  s        : string;
begin
  if Length(cntElements) < 1 then
    Exit;

  cntElements[0].Reached;

  for i := Low(flRecords) to High(flRecords) do
    if not flRecords[i].LoadOrderFormID.IsHardcoded then
      break
    else
      if flRecords[i].IsWinningOverride then
        (flRecords[i] as IwbElementInternal).Reached;

  Group := GetGroupBySignature('GMST');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      (Group.Elements[i] as IwbElementInternal).Reached;
  Group := GetGroupBySignature('DFOB');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      (Group.Elements[i] as IwbElementInternal).Reached;
  Group := GetGroupBySignature('ANIO');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      (Group.Elements[i] as IwbElementInternal).Reached;
  Group := GetGroupBySignature('IDLE');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      (Group.Elements[i] as IwbElementInternal).Reached;
  Group := GetGroupBySignature('LSCR');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      (Group.Elements[i] as IwbElementInternal).Reached;

  if wbGameMode = gmTES4 then begin
    Group := GetGroupBySignature('SKIL');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;
    Group := GetGroupBySignature('BSGN');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;

    Group := GetGroupBySignature('CLAS');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
          if Rec.IsWinningOverride then begin
            Cnt := Rec as IwbContainerElementRef;
            if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt) then begin
              Flg := Cnt.ElementByName['Flags'];
              if Assigned(Flg) then begin
                s := Flg.EditValue;
                if (Length(s) > 0) and (s[1]='1') then
                  (Rec as IwbElementInternal).Reached;
              end;
            end;
          end;
        end;
  end else begin
    Group := GetGroupBySignature('AVIF');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;
    Group := GetGroupBySignature('ADDN');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;
    Group := GetGroupBySignature('CAMS');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;
    Group := GetGroupBySignature('CPTH');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;
    Group := GetGroupBySignature('NAVI');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;
    Group := GetGroupBySignature('RADS');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        (Group.Elements[i] as IwbElementInternal).Reached;

    Group := GetGroupBySignature('PERK');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
          if Rec.IsWinningOverride then begin
            Cnt := Rec as IwbContainerElementRef;
            if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt) then begin
              Flg := Cnt.ElementByName['Playable'];
              if Assigned(Flg) then begin
                if Flg.NativeValue <> 0 then
                  (Rec as IwbElementInternal).Reached;
              end;
            end;
          end;
        end;

    Group := GetGroupBySignature('HDPT');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
          if Rec.IsWinningOverride then begin
            Cnt := Rec as IwbContainerElementRef;
            if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt) then begin
              s := Cnt.SortKey[False];
              if (Length(s)>0) and (s[1] = '1') then
                //Playable
                (Rec as IwbElementInternal).Reached;
            end;
          end;
        end;

    if wbGameMode >= gmTES5 then begin
      Group := GetGroupBySignature('EYES');
      if Assigned(Group) then
        for i := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
            if Rec.IsWinningOverride then begin
              Cnt := Rec as IwbContainerElementRef;
              if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt) then begin
                s := Cnt.SortKey[False];
                if (Length(s)>0) and (s[1] = '1') then
                  //Playable
                  (Rec as IwbElementInternal).Reached;
              end;
            end;
          end;
    end;

    if wbGameMode < gmTES5 then begin
      Group := GetGroupBySignature('DIAL');
      if Assigned(Group) then
        for i := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
            if Rec.IsWinningOverride then begin
              Cnt := Rec as IwbContainerElementRef;
              if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt2) then begin
                Flg := Cnt2.ElementByName['Flags'];
                if Assigned(Flg) then begin
                  s := Flg.SortKey[False];
                  if (Length(s)>1) and (s[2] = '1') then
                    //Top-level
                    (Rec as IwbElementInternal).Reached;
                end;
              end;
            end;
          end;
    end;

    Group := GetGroupBySignature('NPC_');
    if Assigned(Group) then
      for i := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
          if Rec.IsWinningOverride then begin
            Cnt := Rec as IwbContainerElementRef;
            if Supports(Cnt.RecordBySignature['ACBS'], IwbContainerElementRef, Cnt) then begin
              Flg := Cnt.ElementByName['Flags'];
              if Assigned(Flg) then begin
                s := Flg.EditValue;
                if (Length(s) > 2) and (s[3]='1') then
                  //Is CharGen Face Preset
                  (Rec as IwbElementInternal).Reached;
              end;
            end;
          end;
        end;
  end;

  Group := GetGroupBySignature('RACE');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
        if Rec.IsWinningOverride then begin
          Cnt := Rec as IwbContainerElementRef;
          if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt) then begin
            Flg := Cnt.ElementByName['Flags'];
            if Assigned(Flg) then begin
              s := Flg.EditValue;
              if (Length(s) > 0) and (s[1]='1') then
                //Playable
                (Rec as IwbElementInternal).Reached;
            end;
          end;
        end;
      end;

  Group := GetGroupBySignature('QUST');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      if Supports(Group.Elements[i], IwbMainRecord, Rec) then begin
        if Rec.IsWinningOverride then begin
          Cnt := Rec as IwbContainerElementRef;
          if Supports(Cnt.RecordBySignature[wb<TwbSignature>.Iff(wbGameMode >= gmTES5, 'DNAM', 'DATA')], IwbContainerElementRef, Cnt) then begin
            Flg := Cnt.Elements[0];
            if Assigned(Flg) then begin
              s := Flg.EditValue;
              if (Length(s) > 0) and (s[1]='1') then
                //Start game enabled
                (Rec as IwbElementInternal).Reached;
            end;
          end;
        end;
      end;

  Group := GetGroupBySignature('DOBJ');
  if Assigned(Group) then
    for i := 0 to Pred(Group.ElementCount) do
      (Group.Elements[i] as IwbElementInternal).Reached;
end;

procedure TwbFile.BuildRef;
begin
  if fsIsDeltaPatch in flStates then
    Exit;

  if (csRefsBuild in cntStates) and (cntRefsBuildAt >= eGeneration) then
    Exit;
  BuildOrLoadRef(False);
end;

procedure TwbFile.CleanMasters;
var
  i, j, k     : Integer;
  Old,New     : TwbFileIDs;
  Header      : IwbContainerElementRef;
  MasterFiles : IwbContainerElementRef;
  Rec         : IwbRecord;
  UsedMasters : TwbUsedMasters;
begin
  if not IsElementEditable(nil) then
    raise Exception.Create('File "' + GetFileName + '" is not editable');
  if (GetElementCount < 1) or not Supports(GetElement(0), IwbContainerElementRef, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Length(flMasters) >= 1 then begin
    flOldMasters := Copy(flMasters);
    try
      MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
      Assert(Assigned(MasterFiles), '[TwbFile.CleanMasters] not Assigned(MasterFiles)');
      Assert(MasterFiles.ElementCount = Length(flMasters), '[TwbFile.CleanMasters] MasterFiles.ElementCount <> Length(flMasters)');

      for i := Low(flMasters) to High(flMasters) do begin
        Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
        Assert(Assigned(Rec), '[TwbFile.CleanMasters] not Assigned(Rec)');
        Assert(SameText(Rec.EditValue, flMasters[i].FileName), '[TwbFile.CleanMasters] not SameText(Rec.EditValue, flMasters[i].FileName)');
        MasterFiles[i].SortOrder := i;
      end;

      FillChar(UsedMasters, SizeOf(UsedMasters), 0);
      FindUsedMasters(@UsedMasters);
      //!!! SF1 support
      Old := nil;
      New := nil;
      j := 0;
      for i := Low(flMasters) to High(flMasters) do
        if UsedMasters[i] or
           (
             wbStarfieldIsABugInfestedHellhole and
             wbIsStarfield and
             (
                  SameText(flMasters[i].FileName, 'Starfield.esm')
//             or SameText(flMasters[i].FileName, 'BlueprintShips-Starfield.esm')
             )
           )
        then begin
          if i <> j then begin
            flMasters[j] := flMasters[i];

            MasterFiles[i].SortOrder := j;
            SetLength(Old, Succ(Length(Old)));
            Old[High(Old)] := TwbFileID.CreateFull(i);
            SetLength(New, Succ(Length(New)));
            New[High(New)] := TwbFileID.CreateFull(j);
          end;
          Inc(j);
        end else
          MasterFiles[i].SortOrder := $100;

      var lRemovedCount := 0;

      k := Length(flMasters);
      if j <> k then begin
        SetLength(flMasters, j);

        (MasterFiles as IwbContainerInternal).SortBySortOrder;
        if wbBeginInternalEdit(True) then try
          for i := Pred(MasterFiles.ElementCount) downto 0 do
            if MasterFiles[i].SortOrder = $100 then
              MasterFiles.RemoveElement(i);

          (MasterFiles as IwbElementInternal).InvalidateStorage;
          if MasterFiles.ElementCount = 0 then
            MasterFiles.Remove;
          (Header as IwbElementInternal).InvalidateStorage;
        finally
          wbEndInternalEdit;
        end else
          Assert(False, '[TwbFile.CleanMasters] not wbBeginInternalEdit');

        SetModified(True);
        IncGeneration;
        lRemovedCount := Length(flOldMasters) - MasterFiles.ElementCount;

        Assert(Length(flMasters) = MasterFiles.ElementCount, '[TwbFile.CleanMasters] Length(flMasters) <> MasterFiles.ElementCount');

        for i := Low(flMasters) to High(flMasters) do begin
          Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
          Assert(Assigned(Rec), '[TwbFile.CleanMasters] not Assigned(Rec)');
          Assert(SameText(Rec.EditValue, flMasters[i].FileName), '[TwbFile.CleanMasters] not SameText(Rec.EditValue, flMasters[i].FileName)');
        end;

        if wbGameMode >= gmTES4 then
          MastersUpdated(Old, New, k, j);
        SortRecords;
      end;
      flProgress(Format('Removed %d unused masters.', [lRemovedCount]));
    finally
      flOldMasters := nil;
    end;
  end
  else flProgress('Has no masters.');

  UpdateModuleMasters;
end;

var
  _NextFullSlot: Integer;
  _NextLightSlot: Integer;
  _NextMediumSlot: Integer;
  _NextLoadOrder: Integer;
  Files : array of IwbFile;
  FilesMap: TStringList;

constructor TwbFile.Create(const aFileName: string; aLoadOrder: Integer; aCompareTo: string; aStates: TwbFileStates; aData: TBytes);
var
  s: string;
begin
  flData := aData;
  flStates := aStates * [fsIsTemporary, fsIsHardcoded, fsOnlyHeader, fsIsDeltaPatch];
  flLoadOrderFileID := TwbFileID.Invalid;
  if aCompareTo <> '' then begin
    Include(flStates, fsIsCompareLoad);
    if SameText(ExtractFileName(aFileName), wbGameExeName) then
      Include(flStates, fsIsHardcoded);
    flCompareTo := wbExpandFileName(aCompareTo);
  end else if SameText(ExtractFileName(aFileName), wbGameMasterEsm) then begin
    Include(flStates, fsIsGameMaster);
    Include(flStates, fsIsOfficial);
  end;

  flLoadOrder := aLoadOrder;
  flFileName := aFileName;
  flFileNameOnDisk := flFileName;

  if wbDontSave or (flStates * [fsIsHardcoded, fsOnlyHeader] <> []) then
    Include(flStates, fsMemoryMapped)
  else begin
    if (not wbAllowDirectSave) or (fsIsGameMaster in flStates) then
      Include(flStates, fsMemoryMapped)
    else begin
      flModule := wbModuleByName(GetFileName);
      if not flModule.IsValid then
        flModule := nil;
      if Assigned(flModule) then
        if (flModule.miOfficialIndex <> High(Integer)) or (flModule.miCCIndex <> High(Integer)) then
          Include(flStates, fsMemoryMapped);
    end;

    if (fsMemoryMapped in flStates) and
       Assigned(wbAllowDirectSaveFor) and
       (wbAllowDirectSaveFor.IndexOf(GetFileName) >= 0) then
      Exclude(flStates, fsMemoryMapped);
  end;

  if Length(flData) > 0 then
    Exclude(flStates, fsMemoryMapped);

  flOpenFile;

  s := ChangeFileExt(flFileName, '.cpoverride');
  if FileExists(s) then try
    with TStringList.Create do try
      LoadFromFile(s);
      if Count > 0 then begin
        s := Strings[0].Trim;
        if s <> '' then begin
          flEncodingTrans := wbMBCSEncoding(s);
          flProgress(Format('Using encoding (from .cpoverride): %s', [flEncodingTrans.EncodingName]));
         end;
      end;
    finally
      Free;
    end;
  except end;

  Scan;

  if Assigned(flModule) then begin
    if flModule.miOfficialIndex < High(Integer) then
      Include(flStates, fsIsOfficial)
  end else if fsIsHardcoded in flStates then begin
    flModule := wbModuleByName(GetFileName);
    if not Assigned(flModule) then
      flModule := TwbModuleInfo.AddNewModule(GetFileName, False);
    flModule.miFile := Self;
    flModule.miLoadOrder := flLoadOrder;
    flModule.miFileID := flLoadOrderFileID;
    Include(flModule.miFlags, mfHasFile);
    Include(flModule.miFlags, mfLoaded);
    Include(flModule.miFlags, mfIsHardcoded);
    Exclude(flModule.miFlags, mfValid);
  end else if not (fsOnlyHeader in flStates) then
    flModule := TwbModuleInfo.AddNewModule(GetFileName, False);

  if not (fsOnlyHeader in flStates) then begin
    if Assigned(flModule) and not Assigned(flModule.miFile) then begin
      flModule.miFile := Self;
      flModule.miLoadOrder := flLoadOrder;
      flModule.miFileID := flLoadOrderFileID;
      Include(flModule.miFlags, mfHasFile);
      Include(flModule.miFlags, mfLoaded);

      if GetIsESM then
        Include(flModule.miFlags, mfHasESMFlag);
      if GetIsLightDirect then
        Include(flModule.miFlags, mfHasLightFlag);
      if GetIsMediumDirect then
        Include(flModule.miFlags, mfHasMediumFlag);
      if GetIsOverlayDirect then
        Include(flModule.miFlags, mfHasOverlayFlag);
      if GetIsLocalized then
        Include(flModule.miFlags, mfHasLocalizedFlag);
    end;

    if fsAddToMap in aStates then begin
      SetLength(Files, Succ(Length(Files)));
      Files[High(Files)] := Self;
      FilesMap.AddObject(flFileName, Pointer(Files[High(Files)]));
    end;
  end;
end;

constructor TwbFile.CreateNew(const aFileName: string; aLoadOrder: Integer; aIsLight, aIsMedium: Boolean);
var
  Header : IwbMainRecord;
begin
  Assert(not (aIsLight and aIsMedium));

  Assert((not aIsLight) or wbIsLightSupported);
  Assert((not aIsMedium) or wbIsMediumSupported);

  flLoadOrderFileID := TwbFileID.Invalid;
  Include(flStates, fsIsNew);
  Include(flStates, fsLightCompatible);
  Include(flStates, fsMediumCompatible);
  Include(flStates, fsOverlayCompatible);
  flLoadOrder := aLoadOrder;
  flFileName := aFileName;
  flFileNameOnDisk := flFileName;
  flModule := wbModuleByName(GetFileName);
  if not flModule.IsValid then
    flModule := nil;
  if not Assigned(flModule) then
    flModule := TwbModuleInfo.AddNewModule(GetFileName, False);

  Header := TwbMainRecord.Create(Self, wbHeaderSignature, TwbFormID.Null);
  Header.RecordBySignature['HEDR'].Elements[0].NativeValue := wbHEDRVersion;
  if wbGameMode >= gmTES4 then
    Header.RecordBySignature['HEDR'].Elements[2].NativeValue := wbHEDRNextObjectID;

  if aIsLight then begin
    Header.IsLight := True;
    Include(flModule.miFlags, mfHasLightFlag);
  end;

  if aIsMedium then begin
    Header.IsMedium := True;
    Include(flModule.miFlags, mfHasMediumFlag);
  end;

  flLoadFinished := True;
  flFormIDsSorted := True;
  flIndicesActive := True;

  if flLoadOrder >= 0 then begin
    if wbIsLightSupported or wbPseudoLight or wbIsMediumSupported or wbPseudoMedium or wbPseudoOverlay then begin
      if Header.IsLight and not wbIgnoreLight then begin
        if _NextLightSlot > TwbFileID.MaxLightSlot then
          raise Exception.Create('Too many light modules');
        flLoadOrderFileID := TwbFileID.CreateLight(_NextLightSlot);
        Inc(_NextLightSlot);
      end else if Header.IsMedium and not wbIgnoreMedium then begin
        if _NextMediumSlot > TwbFileID.MaxMediumSlot then
          raise Exception.Create('Too many medium modules');
        flLoadOrderFileID := TwbFileID.CreateMedium(_NextMediumSlot);
        Inc(_NextMediumSlot);
      end else begin
        if (wbIsOverlaySupported or wbPseudoOverlay) and Header.IsOverlay and not wbIgnoreOverlay then begin
          flLoadOrderFileID := TwbFileID.Invalid;
        end else begin
          if _NextFullSlot >= TwbFileID.MaxFullSlot then
            raise Exception.Create('Too many full modules');
          flLoadOrderFileID := TwbFileID.CreateFull(_NextFullSlot);
          Inc(_NextFullSlot);
        end;
      end;
    end else
      flLoadOrderFileID := TwbFileID.CreateFull(flLoadOrder);

    if Assigned(flModule) and not Assigned(flModule.miFile) then begin
      flModule.miFile := Self;
      flModule.miLoadOrder := flLoadOrder;
      flModule.miFileID := flLoadOrderFileID;
      Include(flModule.miFlags, mfHasFile);
      Include(flModule.miFlags, mfLoaded);
    end;
  end;

  if wbStarfieldIsABugInfestedHellhole and wbIsStarfield then
    AddMasters(['Starfield.esm'{, 'BlueprintShips-Starfield.esm'}]);

  BuildOrLoadRef(False);
end;

constructor TwbFile.CreateNew(const aFileName: string; aLoadOrder: Integer; aTemplate: PwbModuleInfo);
var
  Header : IwbMainRecord;
  i      : Integer;
begin
  flLoadOrderFileID := TwbFileID.Invalid;
  Include(flStates, fsIsNew);
  Include(flStates, fsLightCompatible);
  Include(flStates, fsMediumCompatible);
  Include(flStates, fsOverlayCompatible);
  flLoadOrder := aLoadOrder;
  flFileName := aFileName;
  flFileNameOnDisk := flFileName;
  flModule := wbModuleByName(GetFileName);
  if not flModule.IsValid then
    flModule := nil;
  if not Assigned(flModule) then
    flModule := TwbModuleInfo.AddNewModule(GetFileName, False);

  Header := TwbMainRecord.Create(Self, wbHeaderSignature, TwbFormID.Null);
  Header.RecordBySignature['HEDR'].Elements[0].NativeValue := wbHEDRVersion;
  if wbGameMode >= gmTES4 then
    Header.RecordBySignature['HEDR'].Elements[2].NativeValue := wbHEDRNextObjectID;

  if (mfHasOverlayFlag in aTemplate.miFlags) and wbIsOverlaySupported then begin
    Header.IsOverlay := True;
    Include(flModule.miFlags, mfHasOverlayFlag);
  end;

  if (mfHasLightFlag in aTemplate.miFlags) and wbIsLightSupported then begin
    Header.IsLight := True;
    Include(flModule.miFlags, mfHasLightFlag);
    Exclude(flModule.miFlags, mfHasOverlayFlag);
  end;

  if (mfHasMediumFlag in aTemplate.miFlags) and wbIsMediumSupported then begin
    Header.IsMedium := True;
    Include(flModule.miFlags, mfHasMediumFlag);
    Exclude(flModule.miFlags, mfHasLightFlag);
    Exclude(flModule.miFlags, mfHasOverlayFlag);
  end;

  if mfHasESMFlag in aTemplate.miFlags then begin
    Header.IsESM := True;
    Include(flModule.miFlags, mfHasESMFlag);
  end;

  if mfIsESM in aTemplate.miFlags then
    Include(flModule.miFlags, mfIsESM);

  flLoadFinished := True;
  flFormIDsSorted := True;
  flIndicesActive := True;

  if flLoadOrder >= 0 then begin
    if wbIsLightSupported or wbPseudoLight or wbIsMediumSupported or wbPseudoMedium or wbPseudoOverlay then begin
      if Header.IsLight and not wbIgnoreLight then begin
        if _NextLightSlot > TwbFileID.MaxLightSlot then
          raise Exception.Create('Too many light modules');
        flLoadOrderFileID := TwbFileID.CreateLight(_NextLightSlot);
        Inc(_NextLightSlot);
      end else if Header.IsMedium and not wbIgnoreMedium then begin
        if _NextMediumSlot > TwbFileID.MaxMediumSlot then
          raise Exception.Create('Too many medium modules');
        flLoadOrderFileID := TwbFileID.CreateMedium(_NextMediumSlot);
        Inc(_NextMediumSlot);
      end else begin
        if (wbIsOverlaySupported or wbPseudoOverlay) and Header.IsOverlay and not wbIgnoreOverlay then begin
          flLoadOrderFileID := TwbFileID.Invalid;
        end else begin
          if _NextFullSlot > TwbFileID.MaxFullSlot then
            raise Exception.Create('Too many full modules');
          flLoadOrderFileID := TwbFileID.CreateFull(_NextFullSlot);
          Inc(_NextFullSlot);
        end;
      end;
    end else
      flLoadOrderFileID := TwbFileID.CreateFull(flLoadOrder);

    if Assigned(flModule) and not Assigned(flModule.miFile) then begin
      flModule.miFile := Self;
      flModule.miLoadOrder := flLoadOrder;
      flModule.miFileID := flLoadOrderFileID;
      Include(flModule.miFlags, mfHasFile);
      Include(flModule.miFlags, mfLoaded);
    end;
  end;

  with aTemplate^ do
    for i := Low(miMasters) to High(miMasters) do
      if Assigned(miMasters[i]) then
        with miMasters[i]^ do
          if Assigned(miFile) then
            AddMaster(_File);

  if wbStarfieldIsABugInfestedHellhole and wbIsStarfield then
    AddMasters(['Starfield.esm'{, 'BlueprintShips-Starfield.esm'}]);

  BuildOrLoadRef(False);
end;

destructor TwbFile.Destroy;
begin
  if Assigned(flModule) and (flModule.miFile = Self) then begin
    Exclude(flModule.miFlags, mfHasFile);
    flModule.miFile := nil;
  end;
  flCloseFile;
  inherited;
end;

function TwbFile.FileFileIDtoLoadOrderFileID(aFileID: TwbFileID; aNew: Boolean): TwbFileID;
begin
  if wbComplexFileFileID then case aFileID.ModuleType of
    mtLight:
      if aFileID.LightSlot < GetLightMasterCount(aNew) then
      Exit(GetLightMaster(aFileID.LightSlot, aNew).LoadOrderFileID);
    mtMedium:
      if aFileID.MediumSlot < GetMediumMasterCount(aNew) then
        Exit(GetMediumMaster(aFileID.MediumSlot, aNew).LoadOrderFileID);
    mtFull:
      if aFileID.FullSlot < GetFullMasterCount(aNew) then
        Exit(GetFullMaster(aFileID.FullSlot, aNew).LoadOrderFileID);
  end else
    if aFileID.FullSlot < GetMasterCount(aNew) then
      Exit(GetMaster(aFileID.FullSlot, aNew).LoadOrderFileID);

  Result := GetResolvedLoadOrderFileID(aNew);
  if not Result.IsValid then
    raise EFileNoSlotExecption.Create('File has no slot assigned');
end;

function TwbFile.FileFormIDtoLoadOrderFormID(aFormID: TwbFormID; aNew: Boolean): TwbFormID;
begin
  Result := aFormID;
  if Result.ObjectID < $800 then
    if GetAllowHardcodedRangeUse then begin
      if Result.IsHardcoded then
        Exit;
    end else begin
      Result.FileID := TwbFileID.Null;
      Exit;
    end;

  Result.FileID := FileFileIDtoLoadOrderFileID(Result.FileID, aNew);
end;

function TwbFile.FindFormID(aFormID: TwbFormID; var Index: Integer; aNewMasters: Boolean): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if not flFormIDsSorted then begin
    Exit;

    for i := 0 to Pred(flRecordsCount) do
      if flRecords[I].FixedFormID = aFormID then begin
        Index := i;
        Result := True;
        Exit;
      end;
    Exit;
  end;

  if flRecordNeedCompactFrom <= High(flRecords) then begin
    c := flRecordNeedCompactFrom;
    for i := flRecordNeedCompactFrom to High(flRecords) do begin
      if Assigned(flRecords[i]) then begin
        if i <> c then begin
          Assert(not Assigned(flRecords[c]));
          Pointer(flRecords[c]) := Pointer(flRecords[i]);
          Pointer(flRecords[i]) := nil;
        end;
        Inc(c);
      end;
    end;
    SetLength(flRecords, c);
    flRecordNeedCompactFrom := High(Integer);
  end;

  if IsNewRecord(aFormID, aNewMasters) then begin
    var lFileFileID := GetFileFileID(aNewMasters);
    if aFormID.FileID <> lFileFileID then
      aFormID.FileID := lFileFileID;
  end;

  if (fsMastersUpdating in flStates) and aNewMasters then begin
    //FormID is based on new masters, but list is still sorted based on old masters
    //convert FormID from new to old format
    aFormID := LoadOrderFormIDtoFileFormID(FileFormIDtoLoadOrderFormID(aFormID, True), False);
  end;

  if fsMastersUpdating in flStates then begin

    Assert(Length(flRecordFormIDs) = Length(flRecords));

    L := Low(flRecordFormIDs);
    H := High(flRecordFormIDs);
    while L <= H do begin
      I := (L + H) shr 1;
      C := TwbFormID.Compare(flRecordFormIDs[I], aFormID);
      if C < 0 then
        L := I + 1
      else begin
        H := I - 1;
        if C = 0 then begin
          Result := True;
          L := I;
        end;
      end;
    end;

  end else begin

    L := Low(flRecords);
    H := High(flRecords);
    while L <= H do begin
      I := (L + H) shr 1;
      C := TwbFormID.Compare(flRecords[I].FixedFormID, aFormID);
      if C < 0 then
        L := I + 1
      else begin
        H := I - 1;
        if C = 0 then begin
          Result := True;
          L := I;
        end;
      end;
    end;

  end;

 Index := L;
end;

function TwbFile.FindInjectedID(aFormID: TwbFormID; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  aFormID.FileID := TwbFileID.CreateFull(0);

  L := Low(flInjectedRecords);
  H := High(flInjectedRecords);
  while L <= H do begin
    I := (L + H) shr 1;
    C := TwbFormID.Compare(flInjectedRecords[I].FormID.ChangeFileID(TwbFileID.CreateFull(0)), aFormID);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TwbFile.flActivateIndices;
begin
  if flIndicesActive then
    Exit;

  flProgress('Building string indices');
  try
    flIndicesActive := True;
    for var lRecordIdx := Low(flRecords) to High(flRecords) do begin
      var lIndexKeys := flRecords[lRecordIdx].ActivateIndexKeys;
      flAddKeysToIndices(flRecords[lRecordIdx], lIndexKeys);
    end;
    flProgress('String indices built');
  except
    on E: Exception do begin
      flIndicesActive := True;
      flProgress('Building string indices failed: ' + E.Message);
    end;
  end;
end;

procedure TwbFile.flAddKeysToIndices(const aMainRecord: IwbMainRecord; const aKeys: TwbDefinedKeys);
begin
  if not flIndicesActive then
    Exit;
  for var lKeyIdx := Low(aKeys) to High(aKeys) do try
    with aKeys[lKeyIdx] do begin
      if dkIndex > High(flRecordsIndices) then
        SetLength(flRecordsIndices, Succ(dkIndex));
      if not Assigned(flRecordsIndices[dkIndex]) then
        flRecordsIndices[dkIndex] := TwbMainRecordIndexDictionary.Create(wbNamedIndexComparer(dkIndex));
      if not flRecordsIndices[dkIndex].TryAdd(dkKey, aMainRecord) then begin
        var lMainRecord: IwbMainRecord;
        flRecordsIndices[dkIndex].TryGetValue(dkKey, lMainRecord);
        flProgress('Duplicate Key in Index "' + wbNamedIndexName(dkIndex) + '": "' + dkKey + '" Existing: ' + lMainRecord.ShortName + ' New: ' + aMainRecord.ShortName);
      end;
    end;
  except
    on E: Exception do
      flProgress('Unexpected Error adding a Key to an Index: ' + E.Message);
  end;
end;

procedure TwbFile.flCloseFile;
begin
  if Length(flData) > 0 then begin
    flView := nil;
  end else if fsMemoryMapped in flStates then begin
    if Assigned(flView) then begin
      UnmapViewOfFile(flView);
      flView := nil;
    end;

    if (flMapHandle <> INVALID_HANDLE_VALUE) and (flMapHandle <> 0) then begin
      CloseHandle(flMapHandle);
      flMapHandle := INVALID_HANDLE_VALUE;
    end;

    if (flFileHandle <> INVALID_HANDLE_VALUE) and (flFileHandle <> 0) then begin
      CloseHandle(flFileHandle);
      flFileHandle := INVALID_HANDLE_VALUE;
    end;

    if fsIsTemporary in flStates then try
      DeleteFile(Self.flFileNameOnDisk);
    except
      flProgress('Could not delete temporary file ' + flFileNameOnDisk);
    end;
  end else
    if Assigned(flView) then begin
      VirtualFree(flView, 0 , MEM_RELEASE);
      flView := nil;
    end;
end;

function TwbFile.flFindKeyInIndex(aIndex: TwbNamedIndex; const aKey: string; out aMainRecord: IwbMainRecord): Boolean;
begin
  Result :=
    flIndicesActive and
    (aIndex >= 0) and
    (aIndex <= High(flRecordsIndices)) and
    Assigned(flRecordsIndices[aIndex]) and
    flRecordsIndices[aIndex].TryGetValue(aKey, aMainRecord);
  if not Result then
    aMainRecord := nil;
end;

procedure TwbFile.flOpenFile;
const
  FileAccessMode: array[Boolean] of Cardinal = (GENERIC_READ, GENERIC_READ or GENERIC_WRITE);
  FileShareMode: array[Boolean] of Cardinal = (FILE_SHARE_READ, 0);
  PageProtection: array[Boolean] of Cardinal = (PAGE_READONLY, PAGE_READWRITE);
  ViewAccessMode: array[Boolean] of Cardinal = (FILE_MAP_READ, FILE_MAP_READ or FILE_MAP_WRITE);
var
  s: string;
  OldProtect : Cardinal;
begin
  flProgress('Loading file');

  flSize := Length(flData);
  if flSize > 0 then begin
    flView := @flData[0];
  end else begin
    if not FileExists(flFileName) then begin
      s := flFileName + csDotGhost;
      if FileExists(s) then begin
        flProgress('File is .ghost''ed, adjusting file name...');
        flFileNameOnDisk := s;
        Include(flStates, fsIsGhost);
      end;
    end;

    if fsMemoryMapped in flStates then begin
      flFileHandle := CreateFile(
        PChar(flFileNameOnDisk),
        FileAccessMode[False],
        FileShareMode[False],
        nil,
        OPEN_EXISTING,
        FILE_FLAG_RANDOM_ACCESS,
        0
      );
      if (flFileHandle = INVALID_HANDLE_VALUE) or (flFileHandle = 0) then
        RaiseLastOSError;

      flSize := 0;
      if not GetFileSizeEx(flFileHandle, flSize) then
        RaiseLastOSError;

      if flSize < 1 then
        raise Exception.CreateFmt('"%s" is 0 bytes in size', [flFileName]);

      flMapHandle := CreateFileMapping(
        flFileHandle,
        nil,
        PageProtection[False],
        0,
        0,
        nil
      );
      if (flMapHandle = INVALID_HANDLE_VALUE) or (flMapHandle = 0) then
        RaiseLastOSError;

      flView := MapViewOfFileEx(
        flMapHandle,
        ViewAccessMode[False],
        0,
        0,
        0,
        nil
      );
       if not Assigned(flView) then
        RaiseLastOSError;
    end else begin
      with TFileStream.Create(flFileNameOnDisk, fmOpenRead or fmShareDenyWrite) do try
        flSize := Size;
        flView := VirtualAlloc(nil, flSize, MEM_COMMIT, PAGE_READWRITE);
        if not Assigned(flView) then
          RaiseLastOSError;
        Read(flView^, flSize);
        if not VirtualProtect(flView, flSize, PAGE_READONLY, OldProtect) then
          RaiseLastOSError;
      finally
        Free;
      end;

      if fsIsTemporary in flStates then try
        DeleteFile(flFileNameOnDisk);
      except
        flProgress('Could not delete temporary file ' + flFileNameOnDisk);
      end;
    end;
  end;

  flEndPtr := PByte(flView) + flSize;

  if wbHasProgressCallback then
    flProgress('File loaded (CRC32:' + GetCRC32.ToString + ')');
end;

procedure TwbFile.flProgress(const aStatus: string);
begin
  if wbHasProgressCallback then
    wbProgressCallback('[' + GetFileName + '] ' + aStatus);
end;

procedure TwbFile.flRemoveKeysFromIndices(const aMainRecord: IwbMainRecord; const aKeys: TwbDefinedKeys);
begin
  if not flIndicesActive then
    Exit;
  for var lKeyIdx := Low(aKeys) to High(aKeys) do try
    with aKeys[lKeyIdx] do begin
      if dkIndex > High(flRecordsIndices) then
        Exit;
      if Assigned(flRecordsIndices[dkIndex]) then begin
        var lMainRecord: IwbMainRecord;
        if flRecordsIndices[dkIndex].TryGetValue(dkKey, lMainRecord) and
           aMainRecord.Equals(lMainRecord)
        then
          flRecordsIndices[dkIndex].Remove(dkKey);
      end;
    end;
  except
    on E: Exception do
      flProgress('Unexpected Error removing a Key from an Index: ' + E.Message);
  end;
end;

function TwbFile.flSetContainsFixedFormID(const aFormID: TwbFormID): Boolean;
begin
  if wbGameMode <= gmTES3 then
    Exit(False);

  var ID := aFormID.ToCardinal;

  var i1: Byte := (ID and $FF000000) shr 24;
  if Length(flRecordBits) <= i1 then
    SetLength(flRecordBits, Succ(i1));

  var i2: Byte := (ID and $00FF0000) shr 16;
  if Length(flRecordBits[i1]) <= i2 then
    SetLength(flRecordBits[i1], Succ(i2));

  var i3: Byte := (ID and $0000FF00) shr 8;
  if Length(flRecordBits[i1, i2]) <= i3 then
    SetLength(flRecordBits[i1, i2], Succ(i3));

  var i4: Byte := ID and $000000FF;
  Result := i4 in flRecordBits[i1, i2, i3];
  Include(flRecordBits[i1, i2, i3], i4);
end;

procedure TwbFile.flUpdateChangedKeysInIndices(const aMainRecord: IwbMainRecord; const aChangedKeys: TwbChangedKeys);
begin
  if not flIndicesActive then
    Exit;

  var lIndexChanged := False;

  for var lKeyIdx := Low(aChangedKeys) to High(aChangedKeys) do try
    with aChangedKeys[lKeyIdx] do begin
      if ckIndex > High(flRecordsIndices) then
        if ckNewKey <> '' then
          SetLength(flRecordsIndices, Succ(ckIndex))
        else
          Continue;

      if not Assigned(flRecordsIndices[ckIndex]) then
        if ckNewKey <> '' then
          flRecordsIndices[ckIndex] := TwbMainRecordIndexDictionary.Create(wbNamedIndexComparer(ckIndex));

      if Assigned(flRecordsIndices[ckIndex]) then begin
        if ckOldKey <> '' then begin
          var lMainRecord: IwbMainRecord;
          if flRecordsIndices[ckIndex].TryGetValue(ckOldKey, lMainRecord) and
             aMainRecord.Equals(lMainRecord)
          then begin
            flRecordsIndices[ckIndex].Remove(ckOldKey);
            lIndexChanged := True;
          end;
        end;
        if ckNewKey <> '' then
          if not flRecordsIndices[ckIndex].TryAdd(ckNewKey, aMainRecord) then begin
            var lMainRecord: IwbMainRecord;
            flRecordsIndices[ckIndex].TryGetValue(ckNewKey, lMainRecord);
            flProgress('Duplicate Key in Index "' + wbNamedIndexName(ckIndex) + '": "' + ckNewKey + '" Existing Record: ' + lMainRecord.ShortName + ' New Record: ' + aMainRecord.ShortName);
          end else
            lIndexChanged := True;
      end;
    end;
  except
    on E: Exception do
      flProgress('Unexpected Error updating a Key in an Index: ' + E.Message);
  end;

  if lIndexChanged then
    IncGeneration;
end;

procedure TwbFile.ForceClosed;
var
  i: Integer;
begin
  for i := Low(flRecordsIndices) to High(flRecordsIndices) do
    FreeAndNil(flRecordsIndices[i]);
  flIndicesActive := False;
  for i := High(flRecords) downto Low(flRecords) do
    (flRecords[i] as IwbMainRecordInternal).ClearForRelease;
  for i := High(flInjectedRecords) downto Low(flInjectedRecords) do
    (flInjectedRecords[i] as IwbMainRecordInternal).ClearForRelease;
  flMasters                := nil;
  flRecords                := nil;
  flInjectedRecords        := nil;
  ReleaseElements;
  flCloseFile;
end;

procedure TwbFile.ForceLoadOrder(aValue: Integer);
begin
  flLoadOrder := aValue;
end;

function TwbFile.GetAddList: TDynStrings;
var
  i, j        : Integer;
  GroupRecord : IwbGroupRecord;
  RecordDef   : PwbMainRecordDef;
begin
  Result := nil;

  if not IsElementEditable(nil) then
    Exit;

  with TStringList.Create do try
    Sorted := True;
    Duplicates := dupIgnore;

    AddStrings(wbGroupOrder);

    for i := 0 to Pred(GroupToSkip.Count) do
      if Find(GroupToSkip[i], j) then
        Delete(j);
    for i := 0 to Pred(RecordToSkip.Count) do
      if Find(RecordToSkip[i], j) then
        Delete(j);
    for i := Succ(Low(cntElements)) to High(cntElements) do
      if Supports(cntElements[i], IwbGroupRecord, GroupRecord) then
        if GroupRecord.GroupType = 0 then
          if Find(TwbSignature(GroupRecord.GroupLabel), j) then
            Delete(j);

    Sorted := False;

    for i := Pred(Count) downto 0 do
      if wbFindRecordDef(AnsiString(Strings[i]), RecordDef) and not (dfInternalEditOnly in RecordDef.DefFlags) then
        Strings[i] := Strings[i] + ' - ' + RecordDef.Name
      else
        Delete(i);

    SetLength(Result, Count);
    for i := 0 to Pred(Count) do
      Result[i] := Strings[i];
  finally
    Free;
  end;
end;

function TwbFile.GetAllMasters: TwbFiles;
begin
  UpdateAllMasters;
  Result := flAllMasters;
end;

function TwbFile.GetAllowHardcodedRangeUse: Boolean;
begin
  if flHardcodedGeneration = _FileGeneration then
    Exit(flAllowHardcodedRangeUse);

  Result :=
    (
      (wbGameMode = gmTES3)
      or
      (((wbGameMode in [gmSSE, gmEnderalSE]) or ((wbGameMode = gmTES5VR) and wbHasAddedLightSupport)) and (GetVersion >= 1.709))
      or
      ((wbGameMode = gmFO4) and (GetVersion >= 1.0))
      or
      (wbGameMode = gmSF1)
    )
    and
    (GetMasterCount(True) > 0);

  flAllowHardcodedRangeUse := Result;
  flHardcodedGeneration := _FileGeneration;
end;

function TwbFile.GetBaseName: string;
begin
  Result := GetFileName;
  if fsIsHardcoded in flStates then
    Result := wbGameExeName;
end;

function TwbFile.GetCachedEditInfo(aIdent: Integer; var aEditInfo: TArray<string>): Boolean;
begin
  if aIdent > High(flCachedEditInfos) then
    Exit(False);
  with flCachedEditInfos[aIdent] do begin
    Result :=
      (ceiGeneration >= GetHighestGenerationSelfAndMasters) and
      (ceiLGeneration >= wbLocalizationHandler.Generation);
    if Result then
      aEditInfo := ceiEditInfo
    else begin
      ceiEditInfo := nil;
      ceiGeneration := 0;
      ceiLGeneration := 0;
    end;
  end;
end;

function TwbFile.GetCompareToFile: IwbFile;
begin
  Result := flCompareToFile;
end;

function TwbFile.GetContainedRecordByLoadOrderFormID(aFormID: TwbFormID; aAllowInjected: Boolean): IwbMainRecord;

  function LoadOrderToFile(const aFileID: TwbFileID): TwbFileID;
  begin
    if wbComplexFileFileID then begin
      if aFileID = flLoadOrderFileID then
        Exit(GetFileFileID(False));

      var lFullIndex := 0;
      var lLightIndex := 0;
      var lMediumIndex := 0;

      for var lIndex := 0 to Pred(GetMasterCount(False)) do begin
        var lMaster := GetMaster(lIndex, False);
        if lMaster.LoadOrderFileID = aFileID then case lMaster.ModuleType of
          mtLight: Exit(TwbFileID.CreateLight(lLightIndex));
          mtMedium: Exit(TwbFileID.CreateMedium(lMediumIndex));
          mtFull: Exit(TwbFileID.CreateFull(lFullIndex));
        end else case lMaster.ModuleType of
          mtLight: Inc(lLightIndex);
          mtMedium: Inc(lMediumIndex);
          mtFull: Inc(lFullIndex);
        end;
      end;
    end else begin
      if aFileID = flLoadOrderFileID then
        if fsIsCompareLoad in flStates then
          Exit(TwbFileID.CreateFull(Pred(GetMasterCount(False))))
        else
          Exit(GetFileFileID(False))
      else
        for var i := Pred(GetMasterCount(False)) downto 0 do
          if GetMaster(i, False).LoadOrderFileID = aFileID then
            Exit(TwbFileID.CreateFull(i));
    end;

    Result := TwbFileID.Invalid;
  end;

var
  i          : Integer;
  FileID     : TwbFileID;
begin
  Result := nil;

  FileID :=  LoadOrderToFile(aFormID.FileID);
  if not FileID.IsValid then
    Exit;

  aFormID.FileID := FileID;

  if FindFormID(aFormID, i, False) then
    Result := flRecords[i]
  else if aAllowInjected and IsNewRecord(FileID, False) and FindInjectedID(aFormID, i) then
    Result := flInjectedRecords[i];
end;

function TwbFile.GetCRC32: TwbCRC32;
begin
  Result := flCRC32;
  if Result = 0 then begin
    Result := wbCRC32Ptr(flView, flSize);
    flCRC32 := Result;
  end;
end;

function TwbFile.GetElementBySignature(const aSignature: TwbSignature): IwbElement;
begin
  var SelfRef := Self as IwbContainerElementRef;
  Result := inherited;
  if not Assigned(Result) then
  for var i := Low(cntElements) to High(cntElements) do begin
    var GroupRecord: IwbGroupRecord;
    if Supports(cntElements[i], IwbGroupRecord, GroupRecord) then
      if (GroupRecord.GroupType = 0) and (GroupRecord.GroupLabelSignature = aSignature) then begin
        Result := GroupRecord;
        Exit;
      end;
  end;
end;

function TwbFile.GetElementType: TwbElementType;
begin
  Result := etFile;
end;

function TwbFile.GetEncoding(aTranslatable: Boolean): TEncoding;
begin
  if aTranslatable then begin
    Result :=flEncodingTrans;
    if not Assigned(Result) then
      Result := wbEncodingTrans
  end else begin
    Result := flEncoding;
    if not Assigned(Result) then
      Result := wbEncoding;
  end;
end;

function TwbFile.GetFile: IwbFile;
begin
  Result := Self;
end;

function TwbFile.GetLoadOrderFileID: TwbFileID;
begin
  Result := flLoadOrderFileID;
  if Result.FullSlot < 0 then
    raise EFileNoSlotExecption.Create('File has no slot assigned');
end;

function TwbFile.GetFileFileID(aNewMasters : Boolean): TwbFileID;
begin
  var SelfRef := Self as IwbContainerElementRef;

  if wbComplexFileFileID then case GetModuleType of  
    mtLight:
      Result := TwbFileID.CreateLight(GetLightMasterCount(aNewMasters));
    mtMedium:
      Result := TwbFileID.CreateMedium(GetMediumMasterCount(aNewMasters));
    mtFull:
      Result := TwbFileID.CreateFull(GetFullMasterCount(aNewMasters));
  end else
    Result := TwbFileID.CreateFull(GetMasterCount(aNewMasters));
end;

function TwbFile.GetFileGeneration: Integer;
begin
  Result := flGeneration;
end;

function TwbFile.GetFileName: string;
begin
  Result := ExtractFileName(flFileName);
end;

function TwbFile.GetFileNameOnDisk: string;
begin
  Result := ExtractFileName(flFileNameOnDisk);
end;

function TwbFile.GetFileStates: TwbFileStates;
begin
  Result := flStates;
end;

function TwbFile.GetFullMaster(aIndex: Integer; aNew: Boolean): IwbFile;
begin
  //not very optimized... but should work for now
  Result := nil;
  for var lMasterIndex := 0 to Pred(GetMasterCount(aNew)) do
  begin
    Result := GetMaster(lMasterIndex, aNew);
    if Result.ModuleType = mtFull then begin
      Dec(aIndex);
      if aIndex < 0 then
        Exit;
    end else
      Result := nil;
  end;
end;

function TwbFile.GetFullMasterCount(aNew: Boolean): Integer;
begin
  //not very optimized... but should work for now
  Result := GetMasterCount(aNew);
  for var lMasterIndex := 0 to Pred(Result) do
    if GetMaster(lMasterIndex, aNew).ModuleType <> mtFull then
      Dec(Result);
end;

function TwbFile.GetGroupBySignature(const aSignature: TwbSignature): IwbGroupRecord;
var
  SelfRef: IwbContainerElementRef;
  i: Integer;
begin
  SelfRef := Self;
  DoInit(False);

  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbGroupRecord, Result) and
      (Result.GroupType = 0) and
      (TwbSignature(Result.GroupLabel) = aSignature) then
      Exit;

  Result := nil;
end;

function TwbFile.GetHasNoFormID: Boolean;
begin
  Result := GetIsNotPlugin or (fsHasNoFormID in flStates);
end;

function TwbFile.GetHeader: IwbMainRecord;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self;
  DoInit(True);

  if (Length(cntElements) > 0) and
     (Supports(cntElements[0], IwbMainRecord, Result)) and
     (Result.Signature = wbHeaderSignature) then begin
    {Result already set}
  end else
    Result := nil;
end;

function TwbFile.GetHighestGenerationSelfAndMasters: Integer;
var
  i: Integer;
begin
  Result := GetFileGeneration;
  for i := Low(flMasters) to High(flMasters) do
    Result := Max(Result, (flMasters[i] as IwbFileInternal).GetFileGeneration);
end;

function TwbFile.GetHighObjectID: Cardinal;
var
  FormID : TwbFormID;
begin
  Assert(not (fsMastersUpdating in flStates));

  if GetAllowHardcodedRangeUse then
    Result := 1
  else
    Result := $800;

  if not flFormIDsSorted then
    SortRecords;

  if Length(flRecords) > 0 then begin
    FormID := flRecords[High(flRecords)].FixedFormID;
    if IsNewRecord(FormID, True) then
      Result := FormID.ObjectID;
  end;
end;

function TwbFile.GetInjectedRecord(aIndex: Integer): IwbMainRecord;
begin
  Result := flInjectedRecords[aIndex];
end;

function TwbFile.GetInjectedRecordCount: Integer;
begin
  Result := Length(flInjectedRecords);
end;

function TwbFile.GetIsEditable: Boolean;
begin
  if wbIsStarfield and Assigned(flModule) then
   if (flModule.miExtension = meESP) and not wbRedPill then
     Exit(False);

  Result :=
    wbIsInternalEdit or
    (
      wbEditAllowed and
      ((not (fsIsGameMaster in flStates)) or wbAllowEditGameMaster) and
      not (fsIsHardcoded in flStates) and
      ((not (fsIsCompareLoad in flStates)) or (fsIsDeltaPatch in flStates))
    );

  if wbIsStarfield and wbStarfieldIsABugInfestedHellhole then
    if [fsIsGameMaster, fsIsHardcoded, fsIsOfficial] * flStates <> [] then
      Exit(False);
end;

function TwbFile.GetIsMedium: Boolean;
var
  Header         : IwbMainRecord;
begin
  if wbPseudoMedium then
    Exit(fsPseudoMedium in flStates);

  if not wbIsMediumSupported or GetIsNotPlugin then
    Exit(False);

  var SelfRef := Self as IwbContainerElementRef;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsMedium;
end;

function TwbFile.GetIsMediumDirect: Boolean;
var
  Header         : IwbMainRecord;
begin
  if not wbIsMediumSupported or GetIsNotPlugin then
    Exit(False);

  var SelfRef := Self as IwbContainerElementRef;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsMedium;
end;

function TwbFile.GetIsLight: Boolean;
var
  Header         : IwbMainRecord;
begin
  if wbPseudoLight then
    Exit(fsPseudoLight in flStates);

  if not wbIsLightSupported or GetIsNotPlugin then
    Exit(False);

  var SelfRef := Self as IwbContainerElementRef;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsLight;
end;

function TwbFile.GetIsLightDirect: Boolean;
var
  Header         : IwbMainRecord;
begin
  if not wbIsLightSupported or GetIsNotPlugin then
    Exit(False);

  var SelfRef := Self as IwbContainerElementRef;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsLight;
end;

function TwbFile.GetIsOverlay: Boolean;
var
  Header         : IwbMainRecord;
begin
  if wbPseudoOverlay then
    Exit(fsPseudoOverlay in flStates);

  if not wbIsOverlaySupported or GetIsNotPlugin then
    Exit(False);

  var SelfRef := Self as IwbContainerElementRef;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsOverlay;
end;

function TwbFile.GetIsOverlayDirect: Boolean;
var
  Header         : IwbMainRecord;
begin
  if not wbIsOverlaySupported or GetIsNotPlugin then
    Exit(False);

  var SelfRef := Self as IwbContainerElementRef;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsOverlay;
end;


function TwbFile.GetIsESM: Boolean;
var
  Header         : IwbMainRecord;
begin
  if GetIsNotPlugin then begin
    Result := False;
    Exit;
  end;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsESM;
end;

function TwbFile.GetIsFull: Boolean;
begin
  Result := not (GetIsLight or GetIsMedium);
end;

function TwbFile.GetIsFullDirect: Boolean;
begin
  Result := not (GetIsLightDirect or GetIsMediumDirect);
end;

function TwbFile.GetIsLocalized: Boolean;
var
  Header         : IwbMainRecord;
begin
  if GetIsNotPlugin then begin
    Result := False;
    Exit;
  end;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsLocalized;
end;

function TwbFile.GetNextObjectID: Cardinal;
var
  Header         : IwbContainerElementRef;
  V              : Variant;
  i              : Int64;
begin
  if (wbGameMode >= gmTES4) and (GetElementCount > 0) and Supports(GetElement(0), IwbContainerElementRef, Header) then begin
    V := Header.ElementNativeValues['HEDR\Next Object ID'];
    i := V;
    Result := i;
  end else
    Result := wbHEDRNextObjectID;
end;

procedure TwbFile.SetNextObjectID(aObjectID: Cardinal);
var
  Header         : IwbMainRecord;
begin
  if wbGameMode >= gmTES4 then
    if (GetElementCount > 0) and Supports(GetElement(0), IwbContainerElementRef, Header) then
      Header.ElementNativeValues['HEDR\Next Object ID'] := aObjectID;
end;

procedure TwbFile.SetParentModified;
begin
  Inc(wbGlobalModifedGeneration);
end;

function TwbFile.GetIsNotPlugin: Boolean;
begin
  Result := not wbIsModule(flFileName);
end;

function TwbFile.GetIsRemovable: Boolean;
begin
  Result := False;
end;

function TwbFile.GetLightMaster(aIndex: Integer; aNew: Boolean): IwbFile;
begin
  //not very optimized... but should work for now
  Result := nil;
  for var lMasterIndex := 0 to Pred(GetMasterCount(aNew)) do
  begin
    Result := GetMaster(lMasterIndex, aNew);
    if Result.ModuleType = mtLight then begin
      Dec(aIndex);
      if aIndex < 0 then
        Exit;
    end else
      Result := nil;
  end;
end;

function TwbFile.GetLightMasterCount(aNew: Boolean): Integer;
begin
  //not very optimized... but should work for now
  Result := GetMasterCount(aNew);
  for var lMasterIndex := 0 to Pred(Result) do
    if GetMaster(lMasterIndex, aNew).ModuleType <> mtLight then
      Dec(Result);
end;

function TwbFile.GetLoadOrder: Integer;
begin
  Result := flLoadOrder;
end;

function TwbFile.GetMaster(aIndex: Integer; aNew: Boolean): IwbFile;
begin
  if (not aNew) and (fsMastersUpdating in flStates) then
    Result := flOldMasters[aIndex]
  else
    Result := flMasters[aIndex];
end;

function TwbFile.GetMasterCount(aNew: Boolean): Integer;
begin
  if (not aNew) and (fsMastersUpdating in flStates) then
    Result := Length(flOldMasters)
  else
    Result := Length(flMasters);
end;

function TwbFile.GetMasterForFileID(const aFileID: TwbFileID; aNew, aAllowSelf: Boolean): IwbFile;
begin
  if aAllowSelf and IsNewRecord(aFileID, aNew) then
    Exit(Self);

  if wbComplexFileFileID then case aFileID.ModuleType of
    mtLight:
      Exit(GetLightMaster(aFileID.LightSlot, True));
    mtMedium:
      Exit(GetMediumMaster(aFileID.MediumSlot, True));
    mtFull:
      Exit(GetFullMaster(aFileID.FullSlot, True));
  end else
    Exit(GetMaster(aFileID.FullSlot, True));
end;

function TwbFile.GetMasterIndexForFileID(const aFileID: TwbFileID; aNew: Boolean): Integer;
begin
  if wbComplexFileFileID then begin
    var lFullIndex := -1;
    var lLightIndex := -1;
    var lMediumIndex := -1;

    for var lIndex := 0 to Pred(GetMasterCount(False)) do begin
      var lMaster := GetMaster(lIndex, False);
      case lMaster.ModuleType of
        mtLight: begin
          Inc(lLightIndex);
          if aFileID.IsLightSlot and (aFileID.LightSlot = lLightIndex) then
            Exit(lIndex);
        end;
        mtMedium: begin
          Inc(lMediumIndex);
          if aFileID.IsMediumSlot and (aFileID.MediumSlot = lMediumIndex) then
            Exit(lIndex);
        end;
        mtFull: begin
          Inc(lFullIndex);
          if aFileID.IsFullSlot and (aFileID.FullSlot = lFullIndex) then
            Exit(lIndex);
        end;
      end;
    end;
  end else begin
    Result := aFileID.FullSlot;
    if Result < GetMasterCount(aNew) then
      Exit;
  end;

  Result := -1;
end;

function TwbFile.GetMasterRecordByFormID(aFormID: TwbFormID; aAllowInjected, aNewMasters: Boolean): IwbMainRecord;
begin
  var lMaster: IwbFile;
  if aFormID.ObjectID < $800 then begin
    if GetAllowHardcodedRangeUse then begin
      if aFormID.IsHardcoded then
        lMaster := wbGetGameMasterFile
      else
        {just keep going};
    end else begin
      lMaster := wbGetGameMasterFile;
      if Assigned(lMaster) then
        aFormID := aFormID.ChangeFileID(lMaster.FileFileID[True])
    end;
  end;

  if not Assigned(lMaster) then begin
    if wbComplexFileFileID then begin
      var lFileID := aFormID.FileID;

      case lFileID.ModuleType of

        mtLight: begin
          var lLightSlot := lFileID.LightSlot;

          var lLightMasterCount := GetLightMasterCount(aNewMasters);
          if lLightSlot >= lLightMasterCount then begin
            if fsIsCompareLoad in flStates then
              lMaster := GetMaster(Pred(GetMasterCount(aNewMasters)), aNewMasters);
          end else
            lMaster := GetLightMaster(lLightSlot, aNewMasters);
        end;

        mtMedium: begin
          var lMediumSlot := lFileID.MediumSlot;

          var lMediumMasterCount := GetMediumMasterCount(aNewMasters);
          if lMediumSlot >= lMediumMasterCount then begin
            if fsIsCompareLoad in flStates then
              lMaster := GetMaster(Pred(GetMasterCount(aNewMasters)), aNewMasters);
          end else
            lMaster := GetMediumMaster(lMediumSlot, aNewMasters);
        end;

        mtFull: begin
          var lFullSlot := lFileID.FullSlot;

          var lFullMasterCount := GetFullMasterCount(aNewMasters);
          if lFullSlot >= lFullMasterCount then begin
            if fsIsCompareLoad in flStates then
              lMaster := GetMaster(Pred(GetMasterCount(aNewMasters)), aNewMasters);
          end else
            lMaster := GetFullMaster(lFullSlot, aNewMasters);
        end;

      end;

    end else begin
      var lSlot := aFormID.FileID.FullSlot;

      var lMasterCount := GetMasterCount(aNewMasters);
      if lSlot >= lMasterCount then begin
        if fsIsCompareLoad in flStates then
          lMaster := GetMaster(Pred(lMasterCount), aNewMasters);
      end else
        lMaster := GetMaster(lSlot, aNewMasters);
    end;
  end;

  if Assigned(lMaster) and not Equals(lMaster) then begin
    var lTargetFileID := lMaster.FileFileID[aNewMasters];
    var lTargetFileFormID := aFormID.ChangeFileID(lTargetFileID);

    if lTargetFileFormID.IsHardcoded and
       GetAllowHardcodedRangeUse and
       (lMaster.LoadOrderFileID.FullSlot <> 0)
    then
      Exit(nil);

    Result := lMaster.RecordByFormID[lTargetFileFormID, aAllowInjected, aNewMasters]
  end else
    Result := nil;
end;

procedure TwbFile.GetMasters(aMasters: TStrings);
var
  Header      : IwbMainRecord;
  MasterFiles : IwbContainerElementRef;
  Rec         : IwbRecord;
  i           : Integer;
begin
  if fsOnlyHeader in flStates then begin
    if (GetElementCount <> 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
      raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

    if Header.Signature <> wbHeaderSignature then
      raise Exception.CreateFmt('Expected header signature ' + wbHeaderSignature + ', found %s in file "%s"', [String(Header.Signature), flFileName]);

    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    if Assigned(MasterFiles) then
      for i := 0 to Pred(MasterFiles.ElementCount) do begin
        Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
        if not Assigned(Rec) then
          raise Exception.CreateFmt('Unexpected error reading master list for file "%s"', [flFileName]);
        if not wbStripEmptyMasters or (Trim(Rec.EditValue) <> '') then
          if not wbStripMasters or (wbStripMasters and wbStripMastersFileNames.Find(Rec.EditValue, i) = False) then
            aMasters.Add(Rec.EditValue);
      end;
  end else
    for i := Low(flMasters) to High(flMasters) do
      aMasters.AddObject(flMasters[i].FileName, Pointer(flMasters[i]));
end;

function TwbFile.GetMediumMaster(aIndex: Integer; aNew: Boolean): IwbFile;
begin
  //not very optimized... but should work for now
  Result := nil;
  for var lMasterIndex := 0 to Pred(GetMasterCount(aNew)) do
  begin
    Result := GetMaster(lMasterIndex, aNew);
    if Result.ModuleType = mtMedium then begin
      Dec(aIndex);
      if aIndex < 0 then
        Exit;
    end else
      Result := nil;
  end;
end;

function TwbFile.GetMediumMasterCount(aNew: Boolean): Integer;
begin
  //not very optimized... but should work for now
  Result := GetMasterCount(aNew);
  for var lMasterIndex := 0 to Pred(Result) do
    if GetMaster(lMasterIndex, aNew).ModuleType <> mtMedium then
      Dec(Result);
end;

function TwbFile.GetModuleInfo: Pointer;
begin
  Result := flModule;
end;

function TwbFile.GetModuleType: TwbModuleType;
begin
  if Assigned(flModule) then
    Result := flModule.GetModuleType
  else
    Result := mtFull;
end;

function TwbFile.GetName: string;
begin
  Result := GetFileName;
  if fsIsHardcoded in flStates then
    Result := wbGameExeName;
  Result := '[' + flLoadOrderFileID.ToString + '] ' + Result;
end;

function TwbFile.GetRecord(aIndex: Integer): IwbMainRecord;
begin
  Result := flRecords[aIndex];
end;

function TwbFile.GetRecordByEditorID(const aEditorID: string): IwbMainRecord;
var
  i: Integer;
begin
  Result := nil;
  if flFindKeyInIndex(wbIdxEditorID, aEditorID, Result) then
    Exit
  else
    for i := Pred(GetMasterCount(True)) downto 0 do begin
      Result := GetMaster(i, True).RecordByEditorID[aEditorID];
      if Assigned(Result) then
        Exit;
    end;
end;

function TwbFile.GetRecordByFormID(aFormID: TwbFormID; aAllowInjected, aNewMasters: Boolean): IwbMainRecord;
var
  i: Integer;
begin
  if FindFormID(aFormID, i, aNewMasters) then begin
    Result := flRecords[i];
    Exit;
  end else if aAllowInjected and IsNewRecord(aFormID, aNewMasters) and FindInjectedID(aFormID, i) then begin
    Result := flInjectedRecords[i];
    Exit;
  end;

  if not (fsIsGameMaster in flStates) then
    Result := GetMasterRecordByFormID(aFormID, aAllowInjected, aNewMasters)
  else
    Result := nil;

  if Assigned(Result) then
    Result := Result.HighestOverrideVisibleForFile[Self];
end;

function TwbFile.GetRecordBySignature(const aSignature: TwbSignature): IwbRecord;
begin
  var SelfRef := Self as IwbContainerElementRef;
  Result := inherited;
  if not Assigned(Result) then
  for var i := Low(cntElements) to High(cntElements) do begin
    var GroupRecord: IwbGroupRecord;
    if Supports(cntElements[i], IwbGroupRecord, GroupRecord) then
      if (GroupRecord.GroupType = 0) and (GroupRecord.GroupLabelSignature = aSignature) then begin
        Result := GroupRecord;
        Exit;
      end;
  end;
end;

function TwbFile.GetRecordCount: Integer;
begin
  Result := Length(flRecords);
end;

function TwbFile.GetRecordFromIndexByKey(aIndex: TwbNamedIndex; const aKey: string): IwbMainRecord;
begin
  if not flFindKeyInIndex(aIndex, aKey, Result) then begin
    UpdateAllMasters;
    for var lMasterIdx := Low(flAllMasters) to High(flAllMasters) do
      if (flAllMasters[lMasterIdx] as IwbFileInternal).flFindKeyInIndex(aIndex, aKey, Result) then
        Exit;
  end;
end;

function TwbFile.GetReferenceFile: IwbFile;
begin
  Result := Self;
end;

function TwbFile.GetResolvedLoadOrderFileID(aNew: Boolean): TwbFileID;
begin
  if fsIsCompareLoad in flStates then begin
    if GetMasterCount(True) > 0 then
      Result := GetMaster(Pred(GetMasterCount(aNew)), aNew).ResolvedLoadOrderFileID[True]
    else
      Result := TwbFileID.Invalid;
  end else begin
    Result := flLoadOrderFileID;
    if not Result.IsValid then
      if GetIsOverlay then
        if GetMasterCount(aNew) > 0 then
          Result := GetMaster(0, aNew).ResolvedLoadOrderFileID[True];
  end;
end;

function TwbFile.GetUnsavedSince: TDateTime;
begin
  Result := flUnsavedSince;
end;

function TwbFile.GetVersion: Double;
var
  Header         : IwbContainerElementRef;
  V              : Variant;
  d              : Double;
begin
  if (GetElementCount > 0) and Supports(GetElement(0), IwbContainerElementRef, Header) then begin
    V := Header.ElementNativeValues['HEDR\Version'];
    d := V;
    Result := d;
  end else
    Result := 0.0;
  Result := RoundTo(Result, -2);
end;

function TwbFile.HasGroup(const aSignature: TwbSignature): Boolean;
begin
  Result := GetGroupBySignature(aSignature) <> nil;
end;

function TwbFile.HasMaster(const aFileName: string): Boolean;
var
  i: Integer;
begin
  Assert(not (fsMastersUpdating in flStates));

  Result := False;
  for i := 0 to Pred(GetMasterCount(True)) do begin
    Result := SameText(GetMaster(i, True).FileName, aFileName);
    if Result then
      Exit;
  end;
end;

function TwbFile.HasONAM: Boolean;
var
  Header         : IwbMainRecord;
begin
  if GetIsNotPlugin then begin
    Result := False;
    Exit;
  end;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Assigned(Header.ElementByPath['ONAM']);
end;

procedure TwbFile.IncGeneration;
begin
  Inc(_FileGeneration);
  Inc(_GlobalGeneration);
  flGeneration := _FileGeneration;
end;

procedure TwbFile.InjectMainRecord(const aRecord: IwbMainRecord);
var
  i: Integer;
begin
  if Length(flInjectedRecords) > 0 then begin
    if FindInjectedID(aRecord.FixedFormID, i) then begin
      if wbHasProgressCallback then
        if (wbGameMode > gmTES3) or not (fsIsHardcoded in flStates) then
          if ([fsIsHardcoded, fsIsCompareLoad] * flInjectedRecords[i]._File.FileStates = []) then
            wbProgressCallback('<Warning: ' + aRecord.Name + ' was injected into ' + GetFileName + ' which already has been injected with ' + flInjectedRecords[i].Name + ' from ' + flInjectedRecords[i]._File.FileName + ' >');
      (flInjectedRecords[i] as IwbMainRecordInternal).AddOverride(aRecord);
      Exit;
    end
  end else
    i := 0;

  if wbHasProgressCallback then
    if (wbGameMode > gmTES3) or not (fsIsHardcoded in flStates) then
      if [fsIsHardcoded, fsIsCompareLoad] * aRecord._File.FileStates = [] then
        if wbReportInjected then
          wbProgressCallback('<Note: ' + aRecord.Name + ' was injected into ' + GetFileName + '>');

  SetLength(flInjectedRecords, Succ(Length(flInjectedRecords)));
  if i < High(flInjectedRecords) then begin
    Move(flInjectedRecords[i], flInjectedRecords[Succ(i)], SizeOf(Pointer) * (High(flInjectedRecords) - i));
    Pointer(flInjectedRecords[i]) := nil;
  end;
  flInjectedRecords[i] := aRecord;

  IncGeneration;
end;

function TwbFile.IsElementEditable(const aElement: IwbElement): Boolean;
begin
  Result := wbIsInternalEdit or GetIsEditable;
end;

function TwbFile.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := False;

  if not IsElementEditable(aElement) then
    Exit;

  if Assigned(aElement) then
    case aElement.ElementType of
      etMainRecord: Result := (aElement as IwbMainRecord).Signature <> wbHeaderSignature; {can't remove the file header}
      etGroupRecord: Result := True;
    else
      Assert(False);
    end;
end;

function TwbFile.IsNewRecord(const aFormID: TwbFormID; aNew: Boolean): Boolean;
begin
  Result := IsNewRecord(aFormID.FileID, aNew);
end;

function TwbFile.IsNewRecord(const aFileID: TwbFileID; aNew: Boolean): Boolean;
begin
  if wbComplexFileFileID then case aFileID.ModuleType of 
    mtLight:
      Result := aFileID.LightSlot >= GetLightMasterCount(aNew);
    mtMedium:
      Result := aFileID.MediumSlot >= GetMediumMasterCount(aNew);
    mtFull:
      Result := aFileID.FullSlot >= GetFullMasterCount(aNew);
  end else
    Result := aFileID.FullSlot >= GetMasterCount(aNew);
end;

function TwbFile.LoadOrderFileIDtoFileFileID(aFileID: TwbFileID; aNew: Boolean): TwbFileID;
begin
  if wbComplexFileFileID then begin
    if aFileID = flLoadOrderFileID then
      Exit(GetFileFileID(aNew));

    var lFullIndex := 0;
    var lLightIndex := 0;
    var lMediumIndex := 0;

    for var lIndex := 0 to Pred(GetMasterCount(aNew)) do begin
      var lMaster := GetMaster(lIndex, aNew);
      if lMaster.LoadOrderFileID = aFileID then case lMaster.ModuleType of 
        mtLight: Exit(TwbFileID.CreateLight(lLightIndex));
        mtMedium: Exit(TwbFileID.CreateMedium(lMediumIndex));
        mtFull: Exit(TwbFileID.CreateFull(lFullIndex));
      end else case lMaster.ModuleType of 
        mtLight: Inc(lLightIndex);
        mtMedium: Inc(lMediumIndex);
        mtFull: Inc(lFullIndex);
      end;
    end;
  end else begin
    if aFileID = flLoadOrderFileID then
      if fsIsCompareLoad in flStates then
        Exit(TwbFileID.CreateFull(Pred(GetMasterCount(aNew))))
      else
        Exit(GetFileFileID(aNew))
    else
      for var i := Pred(GetMasterCount(aNew)) downto 0 do
        if GetMaster(i, aNew).LoadOrderFileID = aFileID then
          Exit(TwbFileID.CreateFull(i));
  end;

  raise Exception.Create('Load order FileID [' + aFileID.ToString + '] can not be mapped to file FileID for file "' + GetFileName + '"');
end;

function TwbFile.LoadOrderFormIDtoFileFormID(aFormID: TwbFormID; aNew: Boolean): TwbFormID;
begin
  Result := aFormID;
  if aFormID.IsHardcoded then
    Exit;
  Result.FileID := LoadOrderFileIDtoFileFileID(Result.FileID, aNew);
end;

var
  _MastersGeneration: Integer;

procedure TwbFile.MarkHeaderModified;
var
  Header         : IwbMainRecord;
begin
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  (Header as IwbElementInternal).SetModified(True);
end;

function TwbFile.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  i: Integer;
begin
  Include(flStates, fsMastersUpdating);
  try
    Inc(_MastersGeneration);

    flRecordFormIDs := nil;
    SetLength(flRecordFormIDs, Length(flRecords));
    for i := Low(flRecords) to High(flRecords) do
      flRecordFormIDs[i] := flRecords[i].FixedFormID;

    Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);

  finally
    flRecordFormIDs := nil;
    Exclude(flStates, fsMastersUpdating);
  end;
end;

function TwbFile.NewFormID: TwbFormID;
var
  SelfRef      : IwbContainerElementRef;
  FileHeader   : IwbMainRecord;
  HEDR         : IwbRecord;
  NextObjectID : Cardinal;
  First        : TwbFormID;
  lModuleType  : TwbModuleType;
  Mask         : Cardinal;
begin
  if GetIsOverlay then
    raise Exception.Create('File ' + GetFileName + ' is an overlay and can not contain new records.');

  Assert(not (fsMastersUpdating in flStates));

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if Length(cntElements) < 1 then
    raise Exception.Create('File ' + GetFileName + ' has no file header');

  if cntElements[0].ElementType <> etMainRecord then
    raise Exception.Create('File ' + GetFileName + ' has invalid record ' + cntElements[0].Name + ' as file header.');

  FileHeader := cntElements[0] as IwbMainRecord;
  if FileHeader.Signature <> wbHeaderSignature then
    raise Exception.Create('File ' + GetFileName + ' has invalid record ' + cntElements[0].Name + ' with invalid signature as file header.');

  HEDR := FileHeader.RecordBySignature['HEDR'];
  if not Assigned(HEDR) then
    raise Exception.Create('File ' + GetFileName + ' has a file header with missing HEDR subrecord');

  lModuleType := mtFull;
  if GetIsLight or flLoadOrderFileID.IsLightSlot then
    lModuleType := mtLight
  else if GetIsMedium or flLoadOrderFileID.IsMediumSlot then
    lModuleType := mtMedium;

  if GetIsOverlay then
    raise ERangeError.Create('File ' + GetFileName + ' is Overlay flagged and can''t contain new records');

  case lModuleType of
    mtLight: Mask := $FFF;
    mtMedium: Mask := $FFFF;
    mtFull: Mask := $FFFFFF;
  end;
  
  NextObjectID := GetNextObjectID and Mask;

  if GetAllowHardcodedRangeUse then begin
    if (NextObjectID < 1) or (NextObjectID = Mask) then begin
      NextObjectID := GetHighObjectID;
      if NextObjectID > Mask then
        NextObjectID := 1;
    end;
  end else begin
    if (NextObjectID < $800) or (NextObjectID = Mask) then begin
      NextObjectID := GetHighObjectID;
      if NextObjectID > Mask then
        NextObjectID := $800;
    end;
  end;

  Result := TwbFormID.FromCardinal(NextObjectID).ChangeFileID(GetFileFileID(True));
  First := Result;
  while GetRecordByFormID(Result, True, True) <> nil do begin
    Inc(NextObjectID);
    if NextObjectID > Mask then begin
      if GetAllowHardcodedRangeUse then
        NextObjectID := 1
      else
        NextObjectID := $800;
    end;
    Result := TwbFormID.FromCardinal(NextObjectID).ChangeFileID(GetFileFileID(True));
    if Result = First then //we've gone through all possible FormIDs once, no more space free
      raise ERangeError.Create('File ' + GetFileName + ' has no more space for a new FormID');
  end;

  if GetRecordCount > 0 then
    Inc(NextObjectID);
  if NextObjectID > Mask then
    if GetAllowHardcodedRangeUse then
      NextObjectID := 1
    else
      NextObjectID := $800;

  SetNextObjectID(NextObjectID);
end;

procedure TwbFile.PrepareSave;
var
  SelfRef     : IwbContainerElementRef;
  i, j, k     : Integer;
  GroupRecord : IwbGroupRecord;
  Groups      : array of Boolean;
  RecordCount : Cardinal;

  FileHeader: IwbMainRecord;
  HEDR: IwbRecord;
  MasterFiles : IwbContainerElementRef;
  MasterFile : IwbContainerElementRef;
  ONAMs: IwbContainerElementRef;
  NewONAM: IwbElement;
  Current: IwbMainRecord;
  FormID: TwbFormID;
  Signature : TwbSignature;
  Master : IwbMainRecord;
begin
  Assert(not (fsMastersUpdating in flStates));

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if Length(cntElements) < 1 then
    raise Exception.Create('File ' + GetFileName + ' has no file header');

  if not GetIsNotPlugin then begin
    if cntElements[0].ElementType <> etMainRecord then
      raise Exception.Create('File ' + GetFileName + ' has invalid record ' + cntElements[0].Name + ' as file header.');

    FileHeader := cntElements[0] as IwbMainRecord;
    if FileHeader.Signature <> wbHeaderSignature then
      raise Exception.Create('File ' + GetFileName + ' has invalid record ' + cntElements[0].Name + ' with invalid signature as file header.');

    HEDR := FileHeader.RecordBySignature['HEDR'];
    if not Assigned(HEDR) then
      raise Exception.Create('File ' + GetFileName + ' has a file header with missing HEDR subrecord');

    if wbIsStarfield then begin
      if GetIsOverlayDirect then begin
        if GetIsLightDirect then begin
          SetIsOverlay(False);
          SetIsLight(True);
        end else if GetIsMediumDirect then begin
          SetIsOverlay(False);
          SetIsMedium(True);
        end;
      end;

      if flModule.miExtension in [meESM, meESL] then
        SetIsESM(True);
      if not GetIsOverlayDirect then begin
        if flModule.miExtension = meESL then
          SetIsLight(True);
      end;

      if (flModule.miExtension = meESP) and not wbRedPill then
        raise Exception.Create('".esp" modules can not be saved in ' + wbAppName + wbToolName);

      if wbRedPill then
        FileHeader.ElementEditValues['CNAM'] := 'RedPill';
    end;

    inherited;

    SetLength(Groups, wbGroupOrder.Count);
    for i := Succ(Low(cntElements)) to High(cntElements) do begin
      if not Supports(cntElements[i], IwbGroupRecord, GroupRecord) then
        raise Exception.Create('File ' + GetFileName + ' contains invalid top level record: ' + cntElements[i].Name);
      if GroupRecord.GroupType <> 0 then
        raise Exception.Create('File ' + GetFileName + ' contains invalid top level group type ' + IntToStr(GroupRecord.GroupType) + ' for group: ' + cntElements[i].Name);
      if GroupRecord.SortOrder < 0 then
        raise Exception.Create('File ' + GetFileName + ' contains top level group without known sort order: ' + cntElements[i].Name);
      if GroupRecord.SortOrder > High(Groups) then
        raise Exception.Create('File ' + GetFileName + ' contains top level group with invalid sort order: ' + cntElements[i].Name);
      if Groups[GroupRecord.SortOrder] then
        raise Exception.Create('File ' + GetFileName + ' contains duplicated top level group: ' + cntElements[i].Name);
      Groups[GroupRecord.SortOrder] := True;

      //make sure all WRLD records have been initialized, so that OFST have been removed and child groups sorted
      if GroupRecord.GroupLabelSignature = 'WRLD' then begin
        for j := 0 to Pred(GroupRecord.ElementCount) do
          if Supports(GroupRecord.Elements[j], IwbMainRecord, Current) then
            Current.ElementCount;
      end;
    end;

    if Length(cntElements) > 1 then
      wbMergeSortPtr(@cntElements[1],  High(cntElements), CompareSortOrder);

    RecordCount := GetCountedRecordCount;
    if RecordCount < 1 then
      raise Exception.Create('File ' + GetFileName + ' has an invalid record count');

    HEDR.Elements[1].EditValue := IntToStr(Pred(RecordCount));

    j := 0;
    ONAMs := nil;
    if wbIsSkyrim or wbIsFallout3 or wbIsFallout4 or wbIsFallout76 or wbIsStarfield then begin
      Include(TwbMainRecord(FileHeader).mrStates, mrsNoUpdateRefs);
      BeginUpdate;
      try
        while FileHeader.RemoveElement('ONAM') <> nil do
          ;

        {!!!!! SF1 support? }
        if Supports(FileHeader.ElementByName['Master Files'], IwbContainerElementRef, MasterFiles) then
          for i := 0 to Pred(MasterFiles.ElementCount) do begin
            if Supports(MasterFiles.Elements[i], IwbContainerElementRef, MasterFile) then begin
              // Fallout 4 CK creates ONAMs in ESP too. Cannot verify for FO76.
              if Assigned(ONAMs) then
                ONAMs.BeginUpdate;
              try
                if wbAlwaysSaveOnam or wbAlwaysSaveOnamForce or FileHeader.IsESM or (Assigned(flModule) and (mfHasESMExtension in flModule.miFlags)) then
                  while j <= High(flRecords) do begin
                    Current := flRecords[j];
                    FormID := Current.FixedFormID;
                    var FileID := FormID.FileID.FullSlot;
                    if FileID > i then
                      Break;
                    Assert(FileID = i);
                    Inc(j);

                    Signature := Current.Signature;

                    if (Signature = 'NAVM') or
                       (Signature = 'LAND') or
                       (Signature = 'REFR') or
                       (Signature = 'PGRE') or
                       (Signature = 'PMIS') or
                       (Signature = 'ACHR') or
                       (Signature = 'ACRE') or
                       (Signature = 'PARW') or {>>> Skyrim <<<}
                       (Signature = 'PBEA') or {>>> Skyrim <<<}
                       (Signature = 'PFLA') or {>>> Skyrim <<<}
                       (Signature = 'PCON') or {>>> Skyrim <<<}
                       (Signature = 'PBAR') or {>>> Skyrim <<<}
                       (Signature = 'PHZD') or {>>> Skyrim <<<}
                       // Fallout 4 (and later games?)
                       ((wbIsFallout4  or wbIsStarfield) and (
                         (Signature = 'SCEN') or
                         (Signature = 'DLBR') or
                         (Signature = 'DIAL') or
                         (Signature = 'INFO')
                       ))
                    then begin

                      if (not wbMasterUpdateFilterONAM) or Current.IsWinningOverride then begin
                        // ONAMs are for overridden temporary refs only
                        if Current.IsPersistent then
                          Continue;

                        if not Assigned(ONAMs) then begin
                          if not Supports(FileHeader.Add('ONAM', True), IwbContainerElementRef, ONAMs) then
                            Assert(False);
                          ONAMs.BeginUpdate;
                          Assert(ONAMs.ElementCount = 1);
                          NewONAM := ONAMs.Elements[0];
                        end else repeat
                          NewONAM := ONAMs.Assign(wbAssignAdd, nil, True);
                        until NewONAM.NativeValue = 0;

                        NewONAM.NativeValue := FormID.ToCardinal;

                        if wbMasterUpdateFixPersistence and not Current.IsPersistent and not Current.IsMaster then begin
                          Master := Current.Master;
                          if Assigned(Master) then begin
                            if Master.IsPersistent then begin
                              flProgress('Setting Persistent: ' + Current.Name);
                              Current.IsPersistent := True;
                            end else
                              for k := 0 to Pred(Master.OverrideCount) do
                                if Current.Equals(Master.Overrides[k]) then
                                  Break
                                else
                                  if Master.Overrides[k].IsPersistent then begin
                                    flProgress('Setting Persistent: ' + Current.Name);
                                    Current.IsPersistent := True;
                                    Break;
                                  end;
                          end;
                        end;

                      end;

                    end;

                  end;
              finally
                if Assigned(ONAMs) then
                  ONAMs.EndUpdate;
              end;
            end;
            if j > High(flRecords) then
              Break;
          end;
      finally
        EndUpdate;
      end;
      if not (fsIsDeltaPatch in flStates) then begin
        Exclude(TwbMainRecord(FileHeader).mrStates, mrsNoUpdateRefs);
        FileHeader.UpdateRefs;
      end;
    end;

    if wbClampFormID or (fsIsDeltaPatch in flStates) then begin
      if Supports(FileHeader.ElementByName['Master Files'], IwbContainerElementRef, MasterFiles) then begin
        k := MasterFiles.ElementCount;
        if fsIsDeltaPatch in flStates then
          Dec(k);
      end else
        k := 0;
      for i := Low(flRecords) to High(flRecords) do
        flRecords[i].ClampFormID(k);
    end;

    if wbComplexFileFileID then begin

      if wbStarfieldIsABugInfestedHellhole then begin

        for var lMasterIdx := 0 to Pred(GetMasterCount(True)) do begin
          var lMaster := GetMaster(lMasterIdx, True);
          if lMaster.GetIsLightDirect or lMaster.GetIsMediumDirect or lMaster.GetIsOverlayDirect or (PwbModuleInfo(lMaster.ModuleInfo).miFlags * [mfHasLightFlag, mfHasMediumFlag, mfHasOverlayFlag] <> []) then
            raise Exception.Create('Modules with Small, Medium, or Overlay flagged modules as masters can''t be saved in ' + wbAppName + wbToolName);
        end;

        if FileHeader.IsLight <> (mfHasLightFlag in flModule.miFlags) then
          raise Exception.Create('Small flag can''t be added or removed from existing files in ' + wbAppName + wbToolName);

        if FileHeader.IsMedium <> (mfHasMediumFlag in flModule.miFlags) then
          raise Exception.Create('Medium flag can''t be added or removed from existing files in ' + wbAppName + wbToolName);

        if FileHeader.IsOverlay <> (mfHasOverlayFlag in flModule.miFlags) then
          raise Exception.Create('Overlay flag can''t be added or removed from existing files in ' + wbAppName + wbToolName);

        if FileHeader.IsLight then
          raise Exception.Create('Small flagged files can''t be saved in ' + wbAppName + wbToolName);
        if FileHeader.IsMedium then
          raise Exception.Create('Medium flagged files can''t be saved in ' + wbAppName + wbToolName);
        if FileHeader.IsOverlay then
          raise Exception.Create('Overlay flagged files can''t be saved in ' + wbAppName + wbToolName);

      end;

    end else begin

      var lFileFileID := GetFileFileID(true);

      if FileHeader.IsLight then begin
        for i := High(flRecords) downto Low(flRecords) do begin
          Current := flRecords[i];
          FormID := Current.FixedFormID;
          if FormID.FileID = lFileFileID then begin
            if (FormID.ToCardinal and $00FFF000) <> 0 then
              raise Exception.Create('Record ' + Current.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for a Light module. You will not be able to save this file with Light flag active');
          end else
            Break;
        end;
      end;

      if FileHeader.IsMedium then begin
        for i := High(flRecords) downto Low(flRecords) do begin
          Current := flRecords[i];
          FormID := Current.FixedFormID;
          if FormID.FileID = lFileFileID then begin
            if (FormID.ToCardinal and $00FF0000) <> 0 then
              raise Exception.Create('Record ' + Current.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for a Medium module. You will not be able to save this file with Medium flag active');
          end else
            Break;
        end;
      end;

      if FileHeader.IsOverlay then begin
        if lFileFileID.FullSlot <= 0 then
          raise Exception.Create('File ' + Self.GetName + ' is an overlay module with no masters. You will not be able to save this file with Overlay flag active');

        for i := High(flRecords) downto Low(flRecords) do begin
          Current := flRecords[i];
          FormID := Current.FormID;
          if IsNewRecord(FormID, True) then begin
            raise Exception.Create('Record ' + Current.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for an overlay module. You will not be able to save this file with Overlay flag active');
          end else
            Break;
        end;
      end;

    end;

  end else
    inherited;
end;

function TwbFile.Reached: Boolean;
begin
  Result := False;
end;

procedure TwbFile.RemoveIdenticalDeltaFast;
var
  i, j                : Integer;
  MasterMainRecord    : IwbMainRecord;
  CompareToMainRecord : IwbMainRecord;
  ChildGroup          : IwbGroupRecord;
  Container           : IwbContainerElementRef;
  ParentContainer     : IwbContainerElementRef;
  RemovedAny          : Boolean;
  SkippedForChildren  : Boolean;
begin
  if not (fsCompareToHasSameMasters in flStates) then
    Exit;

  repeat

    RemovedAny := False;
    SkippedForChildren := False;

    for i := High(flRecords) downto Low(flRecords) do begin
      wbTick;
      flRecordProcessing := flRecords[i];
      try
        MasterMainRecord := flRecordProcessing.Master;
        if not Assigned(MasterMainRecord) then
          Continue;

        if esModified in flRecordProcessing.ElementStates then
          Continue;

        ChildGroup := flRecordProcessing.ChildGroup;
        if Assigned(ChildGroup) and (ChildGroup.ElementCount < 1) then begin
          ChildGroup.Remove;
          ChildGroup := nil;
        end;
        if Assigned(ChildGroup) then begin
          SkippedForChildren := True;
          Continue;
        end;

        CompareToMainRecord := nil;
        if flCompareToFile.Equals(MasterMainRecord._File) then
          CompareToMainRecord := MasterMainRecord
        else
          for j := 0 to Pred(MasterMainRecord.OverrideCount) do
            if flCompareToFile.Equals(MasterMainRecord.Overrides[j]._File) then begin
              CompareToMainRecord := MasterMainRecord.Overrides[j];
              Break;
            end;
        if not Assigned(CompareToMainRecord) then
          Continue;

        if esModified in CompareToMainRecord.ElementStates then
          Continue;

        if not CompareToMainRecord.ContentEquals(flRecordProcessing) then
          Continue;

        Container := flRecordProcessing.Container as IwbContainerElementRef;
        flRecordProcessing.Remove;
        flRecords[i] := nil;
        flRecordNeedCompactFrom := i;
        RemovedAny := True;
        while Assigned(Container) and (Container.ElementCount = 0) do begin
          ParentContainer := Container.Container as IwbContainerElementRef;
          Container.Remove;
          Container := ParentContainer;
        end;
      finally
        flRecordProcessing := nil;
      end;
    end;

    if flRecordNeedCompactFrom <= High(flRecords) then begin
      j := flRecordNeedCompactFrom;
      for i := flRecordNeedCompactFrom to High(flRecords) do begin
        if Assigned(flRecords[i]) then begin
          if i <> j then begin
            Assert(not Assigned(flRecords[j]));
            Pointer(flRecords[j]) := Pointer(flRecords[i]);
            Pointer(flRecords[i]) := nil;
          end;
          Inc(j);
        end;
      end;
      SetLength(flRecords, j);
      flRecordNeedCompactFrom := High(Integer);
    end;

    if not SkippedForChildren then
      RemovedAny := False;

  until not RemovedAny;
end;

procedure TwbFile.RemoveInjectedMainRecord(const aRecord: IwbMainRecord);
var
  i: Integer;
begin
  if (Length(flInjectedRecords) > 0) and FindInjectedID(aRecord.FormID, i) then begin

    Assert( (aRecord as IwbElement) = (flInjectedRecords[i] as IwbElement) );

    flInjectedRecords[i] := nil;
    if i < High(flInjectedRecords) then begin
      Move(flInjectedRecords[Succ(i)], flInjectedRecords[i], SizeOf(Pointer) * (High(flInjectedRecords) - i));
      Pointer(flInjectedRecords[High(flInjectedRecords)]) := nil;
    end;
    SetLength(flInjectedRecords, Pred(Length(flInjectedRecords)));

    IncGeneration;
  end;
end;

procedure TwbFile.RemoveMainRecord(const aRecord: IwbMainRecord);
var
  i      : Integer;
  Master : IwbMainRecord;
  FormID : TwbFormID;
begin
  if not Assigned(aRecord) then
    Exit;

  var lFormID := aRecord.FormID;

  if not lFormID.IsNull then begin
    Assert(flLoadFinished);
    Assert(not (fsMastersUpdating in flStates));

    if not aRecord.Equals(flRecordProcessing) then begin
      Assert(not Assigned(flRecordProcessing));

      lFormID := aRecord.FixedFormID;

      if (Length(flRecords) < 1) or not FindFormID(lFormID, i, True) then
        raise Exception.Create('Can''t remove FormID [' + lFormID.ToString(True) + '] from file ' + GetName + ': FormID not registered');

      flRecords[i] := nil;
      if i < High(flRecords) then begin
        Move(flRecords[Succ(i)], flRecords[i], SizeOf(Pointer) * (High(flRecords) - i));
        Pointer(flRecords[High(flRecords)]) := nil;
      end;
      SetLength(flRecords, Pred(Length(flRecords)));
    end;

    var lIsHardcoded := lFormID.ObjectID < $800;
    if lIsHardcoded then
      if GetAllowHardcodedRangeUse then
        lIsHardcoded := lFormID.IsHardcoded;

    if lIsHardcoded and (flLoadOrderFileID.FullSlot = 0) then
      lIsHardcoded := False;

    var lFileID := lFormID.FileID;

    if not lIsHardcoded and IsNewRecord(lFileID, True) then begin
      {record for this file}
    end else try
      Master := GetMasterRecordByFormID(lFormID, True, True);
      if Assigned(Master) and ((Master as IwbElement) <> (aRecord as IwbElement)) then
        (Master as IwbMainRecordInternal).RemoveOverride(aRecord)
      else
        (GetMasterForFileID(lFileID, True, False) as IwbFileInternal).RemoveInjectedMainRecord(aRecord);
    except
      on E: Exception do
        if wbHasProgressCallback then
          wbProgressCallback('Error: <' + e.Message + '> while trying to determine master record for ' + aRecord.Name);
    end;
  end;

  if flIndicesActive then
    flRemoveKeysFromIndices(aRecord, aRecord.DeactivateIndexKeys);

  IncGeneration;
end;

procedure TwbFile.Scan;
var
  Header      : IwbMainRecord;

  procedure AssignSlot;
  begin
    if flLoadOrderFileID.FullSlot >= 0 then
      Exit;

    if flLoadOrder = High(Integer) then
      flLoadOrder := _NextLoadOrder;

    if flLoadOrder >= 0 then begin
      _NextLoadOrder := Max(_NextLoadOrder, Succ(flLoadOrder));
      if wbIsLightSupported or wbPseudoLight or wbIsMediumSupported or wbPseudoMedium or wbIsOverlaySupported or wbPseudoOverlay then begin
        if (wbIsOverlaySupported or wbPseudoOverlay) and ((fsPseudoOverlay in flStates) or ((Header.IsOverlay) and not wbIgnoreOverlay)) then begin
          flLoadOrderFileID := TwbFileID.Invalid;
        end else if (fsPseudoLight in flStates) or ((Header.IsLight or flFileName.EndsWith(csDotEsl, True)) and not wbIgnoreLight) then begin
          if _NextLightSlot > TwbFileID.MaxLightSlot then
            raise Exception.Create('Too many light modules');
          flLoadOrderFileID := TwbFileID.CreateLight(_NextLightSlot);
          Inc(_NextLightSlot);
        end else if (fsPseudoMedium in flStates) or (Header.IsMedium and not wbIgnoreMedium) then begin
          if _NextMediumSlot > TwbFileID.MaxMediumSlot then
            raise Exception.Create('Too many medium modules');
          flLoadOrderFileID := TwbFileID.CreateMedium(_NextMediumSlot);
          Inc(_NextMediumSlot);
        end else begin
          if _NextFullSlot > TwbFileID.MaxFullSlot then
            raise Exception.Create('Too many full modules');
          flLoadOrderFileID := TwbFileID.CreateFull(_NextFullSlot);
          Inc(_NextFullSlot);
        end;
      end else begin
        if flLoadOrder > TwbFileID.MaxFullSlot then
          raise Exception.Create('Too many modules');
        flLoadOrderFileID := TwbFileID.CreateFull(flLoadOrder);
      end;

      flModule := wbModuleByName(GetFileName);
      if not flModule.IsValid then
        flModule := nil;
      if Assigned(flModule) and not Assigned(flModule.miFile) then begin
        flModule.miFile := Self;
        flModule.miLoadOrder := flLoadOrder;
        flModule.miFileID := flLoadOrderFileID;
        Include(flModule.miFlags, mfHasFile);
        Include(flModule.miFlags, mfLoaded);
      end;
    end;
  end;

var
  CurrentPtr  : Pointer;
  HEDR        : IwbRecord;
  MasterFiles : IwbContainerElementRef;
  MasterFilesAdded : Boolean;
  s           : string;
  Rec         : IwbRecord;
  i, j        : Integer;
  SelfRef     : IwbContainerElementRef;

  Groups       : array of IwbGroupRecord;
  GroupRecord  : IwbGroupRecord;
  GroupRecord2 : IwbGroupRecord;

  Container    : IwbContainer;
  Signature    : TwbSignature;

  TopGroups   : TStringList;
  MainRecord  : IwbMainRecord;
  DialRecord  : IwbMainRecord;
  CellRecord  : IwbMainRecord;
  GroupType   : Integer;

  IsInternal  : Boolean;
  EndPtr      : Pointer;
begin
  SelfRef := Self as IwbContainerElementRef;
  flProgress('Start processing');

  Include(flStates, fsScanning);
  TopGroups := nil;
  try
    CurrentPtr := flView;
    TwbRecord.CreateForPtr(CurrentPtr, flEndPtr, Self, nil);

    if (GetElementCount <> 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
      raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

    if Header.Signature <> wbHeaderSignature then
      raise Exception.CreateFmt('Expected header signature TES4, found %s in file "%s"', [String(Header.Signature), flFileName]);

    if fsOnlyHeader in flStates then
      Exit;

    { this one is easy, we can do it first }
    if fsIsCompareLoad in flStates then begin
      if not Assigned(flCompareToFile) then
        if FilesMap.Find(flCompareTo, i) then
          flCompareToFile := IwbFile(Pointer(FilesMap.Objects[i]));
      if Assigned(flCompareToFile) then begin
        flLoadOrderFileID := flCompareToFile.LoadOrderFileID
      end else
        flLoadOrderFileID := TwbFileID.CreateFull($FF);
    end;

    if wbGameMode = gmTES3 then
      if flLoadOrder > 0 then
        AddMaster(wbGameName + csDotExe, False, False);

    { add required masters BEFORE deciding on the slot }
    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    if Assigned(MasterFiles) then
      for i := 0 to Pred(MasterFiles.ElementCount) do begin
        Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
        if not Assigned(Rec) then
          raise Exception.CreateFmt('Unexpected error reading master list for file "%s"', [flFileName]);
        if not wbStripEmptyMasters or (Trim(Rec.EditValue) <> '') then
          if not wbStripMasters or (wbStripMasters and wbStripMastersFileNames.Find(Rec.EditValue, i) = False) then
            AddMaster(Rec.EditValue, False, flLoadOrder = High(Integer));
      end;

    s := Header.ElementEditValues['SNAM'].ToLower;
    i := Pos('<cp:', s);
    if i > 0 then begin
      s := Copy(s, i, 9);
      if (Length(s) = 9) and (s[9] = '>') then begin
        s := Copy(s, 5, 4);
        try
          flEncodingTrans := wbMBCSEncoding(s);
          flProgress(Format('Using encoding (from File Header Description): %s', [flEncodingTrans.EncodingName]));
        except
          on E: Exception do
            wbProgress('Couldn''t use encoding override "%s": [%s] %s', [s, E.ClassName, E.Message]);
        end;
      end;
    end;

    if flCompareTo <> '' then begin

      if Assigned(flCompareToFile) then
        if flCompareToFile.MasterCount[True] = GetMasterCount(True) then begin
          Include(flStates, fsCompareToHasSameMasters);
          for i := 0 to Pred(GetMasterCount(True)) do
            if not flCompareToFile.Masters[i, True].Equals(GetMaster(i, True)) then begin
              Exclude(flStates, fsCompareToHasSameMasters);
              Break;
            end;
        end;

      if fsIsDeltaPatch in flStates then begin
        MasterFilesAdded := False;
        if not Assigned(MasterFiles) then begin
          MasterFiles := Header.Add('Master Files', True) as IwbContainerElementRef;
          MasterFilesAdded := True;
        end;
        if Assigned(MasterFiles) then begin
          if wbBeginInternalEdit(True) then try
            j := MasterFiles.ElementCount;
            if not MasterFilesAdded then
              MasterFiles.Assign(wbAssignAdd, nil, False)
            else begin
              Assert(j=1);
              Dec(j);
            end;
            Assert(MasterFiles.ElementCount = Succ(j));
            Rec := (MasterFiles[j] as IwbContainer).RecordBySignature['MAST'];

            Assert(Assigned(Rec));
            Assert(Rec.EditValue = '');

            Rec.EditValue := flCompareToFile.FileName;
          finally;
            wbEndInternalEdit;
          end;
          (MasterFiles as IwbElementInternal).SetModified(True);
        end else
          raise Exception.Create('Delta patch source file must have at least one existing master');
      end;

      AddMaster(flCompareTo);
    end;

    if wbPseudoLight then
      Include(flStates, fsLightCompatible);
    if wbPseudoMedium then
      Include(flStates, fsMediumCompatible);
    if wbPseudoOverlay then
      Include(flStates, fsOverlayCompatible);

    if Header.IsOverlay then begin
      if wbPseudoOverlay then
        Include(flStates, fsPseudoOverlay);
      AssignSlot;
    end else if Header.IsLight then begin
      if not wbPseudoOverlay then begin
        if wbPseudoLight then
          Include(flStates, fsPseudoLight);
        AssignSlot;
      end;
    end else if Header.IsMedium then begin
      if not (wbPseudoOverlay or wbPseudoLight) then begin
        if wbPseudoMedium then
          Include(flStates, fsPseudoMedium);
        AssignSlot;
      end;
    end else
      if not (wbPseudoLight or wbPseudoMedium or wbPseudoOverlay) then
        AssignSlot;


    flRecordsCount := 0;
    HEDR := Header.RecordBySignature['HEDR'];
    if Assigned(HEDR) then
      SetLength(flRecords, Int64(HEDR.ElementNativeValues['Number of Records']));

    flProgress('Header processed. Expecting ' + IntToStr(Length(flRecords)) + ' records');

    Container := Self;
    Rec := nil;

    if GetAllowHardcodedRangeUse and
       (GetFileStates * [fsIsGameMaster, fsIsHardcoded] = []) and
       ((GetMasterCount(True) < 1) or (GetMaster(0, True).FileStates * [fsIsGameMaster, fsIsHardcoded] = []))
    then
      flProgress('<Warning: Modules with extended FormID range should always have the Game Master as their first master.>');


    var WasEditAllowed := wbEditAllowed;
    try
      if wbGameMode = gmTES3 then
        wbEditAllowed := True;

      EndPtr := flEndPtr;
      GroupType := 0;
      while NativeUInt(CurrentPtr) < NativeUInt(flEndPtr) do begin
        if wbGameMode = gmTES3 then begin
          Signature := PwbSignature(CurrentPtr)^;

          Container := nil;

          if Signature = 'INFO' then begin
            if Assigned(GroupRecord) then
              if not Assigned(DialRecord) or (GroupRecord.GroupType <> 7) or not DialRecord.Equals(GroupRecord.ChildrenOf) then
                GroupRecord := nil;
            if not Assigned(GroupRecord) and Assigned(DialRecord) then
              if wbBeginInternalEdit(True) then try
                GroupRecord := DialRecord.EnsureChildGroup;
              finally
                wbEndInternalEdit;
              end;
            Container := GroupRecord;
          end else
            DialRecord := nil;

          if (Signature = 'LAND') or (Signature = 'PGRD') or (Signature = 'FRMR') or (Signature = 'NAM0') then begin
            if (Signature = 'LAND') or (Signature = 'PGRD') then
              GroupType := 9;
            if Signature <> 'NAM0' then begin
              if Assigned(GroupRecord) then
                if not Assigned(CellRecord) or (GroupRecord.GroupType <> GroupType) or not CellRecord.Equals(GroupRecord.ChildrenOf) then
                  GroupRecord := nil;
              if not Assigned(GroupRecord) and Assigned(CellRecord) then
                if wbBeginInternalEdit(True) then try
                  GroupRecord2 := CellRecord.EnsureChildGroup;
                  GroupRecord := GroupRecord2.FindChildGroup(GroupType, CellRecord);
                  if not Assigned(GroupRecord) then
                    GroupRecord := TwbGroupRecord.Create(GroupRecord2, GroupType, CellRecord);
                finally
                  wbEndInternalEdit;
                end;
              Container := GroupRecord;
            end;
          end else
            CellRecord := nil;

          if Signature <> 'NAM0' then begin
            if not Assigned(Container) then begin
              if Assigned(GroupRecord) then
                if (GroupRecord.GroupType <> 0) or (GroupRecord.GroupLabelSignature <> Signature) then
                  GroupRecord := nil;

              if not Assigned(GroupRecord) then
                if Assigned(TopGroups) and TopGroups.Find(Signature, i) then
                  GroupRecord := IwbGroupRecord(Pointer(TopGroups.Objects[i]))
                else
                  if wbBeginInternalEdit(True) then try
                    GroupRecord := TwbGroupRecord.Create(Self, Signature);
                    if not Assigned(TopGroups) then begin
                      TopGroups := TStringList.Create;
                      TopGroups.Duplicates := dupError;
                      TopGroups.Sorted := True;
                    end;
                    TopGroups.AddObject(Signature, Pointer(GroupRecord));
                  finally
                    wbEndInternalEdit;
                  end;

              Container := GroupRecord;
            end;

            if not Assigned(Container) then
              Container := Self;
          end else
            Container := nil;
        end;

        Rec := TwbRecord.CreateForPtr(CurrentPtr, EndPtr, Container, nil);

        if Assigned(Rec) then
          if wbGameMode = gmTES3 then begin
            if (CurrentPtr = EndPtr) and (EndPtr <> flEndPtr) then
              EndPtr := flEndPtr;

            if Supports(Rec, IwbMainRecord, MainRecord) then begin
              if Signature = 'DIAL' then begin
                DialRecord := MainRecord;
              end else if Signature = 'CELL' then begin
                CellRecord := MainRecord;
                GroupType := 8;
              end;
            end else
              if Rec.Signature = 'NAM0' then
                GroupType := 9;
          end else
            flProgress(Rec.Name + ' processed');
      end;
    finally
      wbEditAllowed := WasEditAllowed;
    end;

    if flRecordsCount < Length(flRecords) then
      SetLength(flRecords, flRecordsCount);

    if wbPseudoOverlay then
      if fsOverlayCompatible in flStates then
        Include(flStates, fsPseudoOverlay);

    if not (fsPseudoOverlay in flStates) then begin
      if wbPseudoLight then
        if fsLightCompatible in flStates then
          Include(flStates, fsPseudoLight);

      if not (fsPseudoLight in flStates) then
        if wbPseudoMedium then
          if fsMediumCompatible in flStates then
            Include(flStates, fsPseudoMedium);
    end;

    AssignSlot;

  finally
    FreeAndNil(TopGroups);
    Exclude(flStates, fsScanning);
  end;

  flProgress('Building FormID index');
  if flRecordsCount < Length(flRecords) then
    SetLength(flRecords, flRecordsCount);
  SortRecords;
  flRecordBits := nil;
  flProgress('FormID index built');

  flActivateIndices;

  if wbIsSkyrim or wbIsFallout3 or wbIsFallout4 or wbIsFallout76 or wbIsStarfield then begin
    IsInternal := not GetIsEditable and wbBeginInternalEdit(True);
    try
      SetLength(Groups, wbGroupOrder.Count);
      for i := High(cntElements) downto Succ(Low(cntElements)) do begin
        if not Supports(cntElements[i], IwbGroupRecord, GroupRecord) then begin
          flProgress('Error: File contains invalid top level record: ' + cntElements[i].Name);
          Continue;
        end;
        if GroupRecord.ElementCount = 0 then begin
          var lName := GroupRecord.Name;
          flProgress('Warning: File contains empty top level group: ' + lName);
          if wbBeginInternalEdit(True) then try
            GroupRecord.Remove;
            flProgress('Removed empty group: ' + lName);
          finally
            wbEndInternalEdit;
          end;
          Continue;
        end;
        if GroupRecord.GroupType <> 0 then begin
          flProgress('Error: File contains invalid top level group type ' + IntToStr(GroupRecord.GroupType) + ' for group: ' + cntElements[i].Name);
          Continue;
        end;
        if GroupRecord.SortOrder < 0 then begin
          flProgress('Error: File contains top level group without known sort order: ' + cntElements[i].Name);
          Continue;
        end;
        if GroupRecord.SortOrder > High(Groups) then begin
          flProgress('Error: File contains top level group with invalid sort order: ' + cntElements[i].Name);
          Continue;
        end;
        if Assigned(Groups[GroupRecord.SortOrder]) then begin
          flProgress('Warning: File contains duplicated top level group: ' + cntElements[i].Name);
          if wbBeginInternalEdit(True) then try
            if Groups[GroupRecord.SortOrder].ElementCount = 0 then begin
              Groups[GroupRecord.SortOrder].Remove;
              Groups[GroupRecord.SortOrder] := nil;
              Groups[GroupRecord.SortOrder] := GroupRecord;
            end else begin
              j := 0;
              while GroupRecord.ElementCount > 0 do begin
                Groups[GroupRecord.SortOrder].AddElement(GroupRecord.RemoveElement(0, True));
                Inc(j);
              end;
              (Groups[GroupRecord.SortOrder] as IwbGroupRecordInternal).Sort;
              (Groups[GroupRecord.SortOrder] as IwbGroupRecordInternal).SetModified(True);
              flProgress('Merged ' + IntToStr(j) + ' record from duplicated group: ' + cntElements[i].Name);
              GroupRecord.Remove;
            end;
          finally
            wbEndInternalEdit;
          end;
          Continue;
        end;
        Groups[GroupRecord.SortOrder] := GroupRecord;
      end;
    finally
      if IsInternal then
        wbEndInternalEdit;
    end;
  end;

  if (fsIsHardcoded in flStates) and (wbGameMode > gmTES3) then
    if wbBeginInternalEdit(True) then try
      ((Add('PLYR', True) as IwbGroupRecord).Add('PLYR', True) as IwbMainRecord).EditorID := 'PlayerRef';
    finally
      wbEndInternalEdit;
    end;

  flProgress('Processing completed');
  flLoadFinished := True;
end;

procedure TwbFile.SetCachedEditInfo(aIdent: Integer; const aEditInfo: TArray<string>);
begin
  if High(flCachedEditInfos) < aIdent then
    SetLength(flCachedEditInfos, Succ(aIdent));
  with flCachedEditInfos[aIdent] do begin
    ceiEditInfo := aEditInfo;
    ceiGeneration := _FileGeneration;
    ceiLGeneration := wbLocalizationHandler.Generation;
  end;
end;

procedure TwbFile.SetHasNoFormID(Value: Boolean);
begin
  if Value or GetIsNotPlugin then
    Include(flStates, fsHasNoFormID)
  else
    Exclude(flStates, fsHasNoFormID);
end;

procedure TwbFile.SetIsMedium(Value: Boolean);
var
  Header         : IwbMainRecord;
begin
  if not wbIsMediumSupported then
    Exit;
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Value <> Header.IsMedium then begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "' + GetFileName + '" is not editable');

    Header.IsMedium := Value;
  end;
end;

procedure TwbFile.SetIsLight(Value: Boolean);
var
  Header         : IwbMainRecord;
begin
  if not wbIsLightSupported then
    Exit;
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Value <> Header.IsLight then begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "' + GetFileName + '" is not editable');

    Header.IsLight := Value;
  end;
end;

procedure TwbFile.SetIsOverlay(Value: Boolean);
var
  Header         : IwbMainRecord;
begin
  if not wbIsOverlaySupported then
    Exit;
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Value <> Header.IsOverlay then begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "' + GetFileName + '" is not editable');

    Header.IsOverlay := Value;
  end;
end;

procedure TwbFile.SetIsESM(Value: Boolean);
var
  Header         : IwbMainRecord;
begin
  if GetIsNotPlugin then begin
    Exit;
  end;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Value <> Header.IsESM then begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "' + GetFileName + '" is not editable');

    Header.IsESM := Value;
  end;
end;

procedure TwbFile.SetIsLocalized(Value: Boolean);
var
  Header         : IwbMainRecord;
begin
  if GetIsNotPlugin then begin
    Exit;
  end;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Value <> Header.IsLocalized then begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "' + GetFileName + '" is not editable');

    Header.IsLocalized := Value;
  end;
end;

procedure TwbFile.SetLoadOrder(aValue: Integer);
begin
  flLoadOrder := aValue;
end;

procedure TwbFile.SetModified(aValue: Boolean);
begin
  if not (esUnsaved in eStates) and not wbIsInternalEdit then
    flUnsavedSince := Now;

  inherited;
end;

function CompareRecords(Item1, Item2: Pointer): Integer;
begin
  Result := TwbFormID.Compare(
    IwbMainRecord(Item1).FixedFormID,
    IwbMainRecord(Item2).FixedFormID
  );
end;

function CompareOverrides(Item1, Item2: Pointer): Integer;
var
  LoadOrder1 : Cardinal;
  LoadOrder2 : Cardinal;
begin
  LoadOrder1 := IwbMainRecord(Item1)._File.LoadOrder;
  LoadOrder2 := IwbMainRecord(Item2)._File.LoadOrder;

  if LoadOrder1 < LoadOrder2 then
    Result := -1
  else if LoadOrder1 = LoadOrder2 then
    Result := 0
  else
    Result := 1;
end;

function CompareRecordsByEditorID(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(IwbMainRecord(Item1).EditorID, IwbMainRecord(Item2).EditorID);
end;

procedure TwbFile.SortMasters;
var
  OldList     : TStringList;
  i, j        : Integer;
  Old,New     : TwbFileIDs;
  Header      : IwbContainerElementRef;
  MasterFiles : IwbContainerElementRef;
  Rec            : IwbRecord;
begin
  if not IsElementEditable(nil) then
    raise Exception.Create('File "' + GetFileName + '" is not editable');
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbContainerElementRef, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Length(flMasters) > 1 then begin
    flOldMasters := Copy(flMasters);
    try
      MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
      Assert(Assigned(MasterFiles));
      Assert(MasterFiles.ElementCount = Length(flMasters));
      OldList := TStringList.Create;
      OldList.Sorted := True;
      OldList.Duplicates := dupError;
      try
        for i := Low(flMasters) to High(flMasters) do begin
          Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
          Assert(Assigned(Rec));
          Assert(SameText(Rec.EditValue, flMasters[i].FileName));
          OldList.AddObject(flMasters[i].FileName, Pointer(i));
          MasterFiles[i].SortOrder := i;
        end;

        wbMergeSortPtr(@flMasters[0], Length(flMasters), CompareLoadOrder);
        //!!! SF1 support
        Old := nil;
        New := nil;
        for i := Low(flMasters) to High(flMasters) do begin
          j := Integer(OldList.Objects[OldList.IndexOf(flMasters[i].FileName)]);
          if i <> j then begin
            MasterFiles[j].SortOrder := i;
            SetLength(Old, Succ(Length(Old)));
            Old[High(Old)] := TwbFileID.CreateFull(j);
            SetLength(New, Succ(Length(New)));
            New[High(New)] := TwbFileID.CreateFull(i);
          end;
        end;
        if Length(Old) > 0 then begin
          if wbBeginInternalEdit(True) then try
            (MasterFiles as IwbContainerInternal).SortBySortOrder;
          finally
            wbEndInternalEdit;
          end else
            Assert(False);
          if wbGameMode >= gmTES4 then
            MastersUpdated(Old, New, Length(flOldMasters), Length(flMasters));
          SetModified(True);
        end;
      finally
        OldList.Free;
      end;
      SortRecords;
    finally
      flOldMasters := nil;
    end;
  end;
  UpdateModuleMasters;
end;

type
  TwbRecordSortEntry = record
    rseFormID     : TwbFormID;
    rseMainRecord : Pointer;
  end;
  TwbRecordSortEntries = array of TwbRecordSortEntry;

  PwbRecordSortEntry = ^TwbRecordSortEntry;
  TwbRecordSortEntryPtrs = array of PwbRecordSortEntry;

function CompareSortEntryPtrs(Item1{eax}, Item2{edx}: Pointer): Integer;
asm
  {$IFDEF WIN32}
  mov ecx, [eax + TwbRecordSortEntry.rseFormID]
  mov edx, [edx + TwbRecordSortEntry.rseFormID]
  xor eax, eax
  cmp ecx, edx
  mov ecx, -1
  cmovb eax, ecx
  seta al
  {$ENDIF WIN32}
  {$IFDEF WIN64}
  mov rcx, [rcx + TwbRecordSortEntry.rseFormID]
  mov rdx, [rdx + TwbRecordSortEntry.rseFormID]
  xor rax, rax
  cmp rcx, rdx
  mov rcx, -1
  cmovb rax, rcx
  seta al
  {$ENDIF WIN64}
end;

procedure TwbFile.SortRecords;
var
  SortEntries   : TwbRecordSortEntries;
  SortEntryPtrs : TwbRecordSortEntryPtrs;
  i             : Integer;
begin
  i := Length(flRecords);
  if i > 0 then begin
    SetLength(SortEntries, i);
    SetLength(SortEntryPtrs, i);
    for i := Low(flRecords) to High(flRecords) do begin
      SortEntries[i].rseFormID := flRecords[i].FixedFormID;
      SortEntries[i].rseMainRecord := Pointer(flRecords[i]);
      SortEntryPtrs[i] := @SortEntries[i];
    end;
    wbMergeSortPtr(@SortEntryPtrs[0], Length(SortEntryPtrs), CompareSortEntryPtrs);
    for i := Low(flRecords) to High(flRecords) do
      Pointer(flRecords[i]) := SortEntryPtrs[i].rseMainRecord;
  end;
  flFormIDsSorted := True;
  flRecordNeedCompactFrom := High(Integer);
end;

procedure TwbFile.UpdateAllMasters;
begin
  if flAllMastersGeneration = _FileGeneration then
    Exit;

  flAllMasters := nil;

  var lDict := TwbFilesDictionary.Create;
  try
    AddAllMastersToDict(lDict);
    flAllMasters := lDict.Keys.ToArray;
    flAllMasters.SortByReverseLoadOrder;
  finally
    lDict.Free;
  end;

  flAllMastersGeneration := _FileGeneration;
end;

procedure TwbFile.UpdateIndexKeys(const aMainRecord: IwbMainRecord; const aChangedKeys: TwbChangedKeys);
begin
  if flIndicesActive then
    flUpdateChangedKeysInIndices(aMainRecord, aChangedKeys);
end;

procedure TwbFile.UpdateModuleMasters;
var
  i: Integer;
begin
  if Assigned(flModule) then
    with flModule^ do begin
      SetLength(miMasterNames, Length(flMasters));
      SetLength(miMasters, Length(flMasters));
      for i := Low(flMasters) to High(flMasters) do begin
        miMasterNames[i] := flMasters[i].FileName;
        miMasters[i] := flMasters[i].ModuleInfo;
      end;
    end;
end;

procedure TwbFile.WriteToStream(aStream: TStream; aResetModified: TwbResetModified);
var
  MemoryStream: TMemoryStream;
begin
  MemoryStream := TMemoryStream.Create;
  try
    inherited WriteToStream(MemoryStream, aResetModified);
    flCRC32 := wbCRC32Ptr(MemoryStream.Memory, MemoryStream.Size);
    MemoryStream.Position := 0;
    aStream.Write(MemoryStream.Memory^, MemoryStream.Size);
  finally
    MemoryStream.Free;
  end;
end;

procedure TwbFile.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  PrepareSave;
  inherited WriteToStreamInternal(aStream, aResetModified);

  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

type
  TwbUnionFlags = (
    ufNone,
    ufArray,
    ufSortedArray,
    ufFlags
  );

function ArrayDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; out SizePrefix: Integer): Boolean; forward;
procedure StructDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer); forward;
function UnionDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; var aResolvedDef : IwbValueDef): TwbUnionFlags; forward
function ValueDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; const aPrevFlags: TDynElementInternals; var aResolvedDef: IwbValueDef): Boolean; forward;

{ TwbContainer }

function TwbContainer.Add(const aName: string; aSilent: Boolean): IwbElement;
begin
  Result := nil;
end;

procedure TwbContainer.AddElement(const aElement: IwbElement);
begin
  if not Assigned(aElement) then
    Exit;

  var lLength := Length(cntElements);
  SetLength(cntElements, Succ(lLength));

  var lElementInternal := aElement as IwbElementInternal;

  cntElements[lLength] := lElementInternal;

  lElementInternal.MemoryOrder := lLength;
  lElementInternal.SetContainer(Self);

  NotifyChanged(eContainer);
end;

function TwbContainer.IndexOf(const aElement: IwbElement): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Assigned(aElement) then
    for i := Low(cntElements) to High(cntElements) do
      if aElement.Equals(cntElements[i]) then begin
        Result := i;
        Exit;
      end;
end;

procedure TwbContainer.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SelfRef             : IwbContainerElementRef;
  MemoryOrderElements : TArray<Pointer>;
  ElementPtrs         : PwbPointerArray;
  i                   : Integer;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(True);

  if Length(cntElements) < 1 then
    Exit;

  if UpdateMemoryOrder(MemoryOrderElements) then
    ElementPtrs := @MemoryOrderElements[0]
  else
    ElementPtrs := @cntElements[0];

  for i := Low(cntElements) to High(cntElements) do
    IwbElement(ElementPtrs[i]).InformStorage(aBasePtr, aEndPtr);
end;

procedure TwbContainer.InsertElement(aPosition: Integer; const aElement: IwbElement);
begin
  if not Assigned(aElement) then
    Exit;

  SetLength(cntElements, Succ(Length(cntElements)));

  if aPosition < Low(cntElements) then
    aPosition := Low(cntElements)
  else if aPosition > High(cntElements) then
    aPosition := High(cntElements);

  if aPosition < High(cntElements) then begin
    Move(cntElements[aPosition], cntElements[Succ(aPosition)], (High(cntElements) - aPosition) * SizeOf(Pointer));
    Pointer(cntElements[aPosition]) := nil;
  end;

  cntElements[aPosition] := aElement as IwbElementInternal;
  ResetMemoryOrder(aPosition);
  cntElements[aPosition].SetContainer(Self);
  NotifyChanged(eContainer);
end;

function TwbContainer.IsElementEditable(const aElement: IwbElement): Boolean;
var
  Def      : IwbNamedDef;
  ValueDef : IwbValueDef;
begin
  if not wbIsInternalEdit then begin
    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
        Exit(False);

    ValueDef := GetValueDef;
    if Assigned(ValueDef) and (dfInternalEditOnly in ValueDef.DefFlags) then
      Exit(False);
    if Assigned(aElement) then begin
      Def := aElement.GetDef;
      if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
          Exit(False);

      ValueDef := aElement.GetValueDef;
      if Assigned(ValueDef) and (dfInternalEditOnly in ValueDef.DefFlags) then
        Exit(False);
    end;
  end;
  if Assigned(eContainer) then
    Result := IwbContainer(eContainer).IsElementEditable(Self)
  else
    Result := True;
end;

function TwbContainer.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := False;
end;

function LockedInc(var Target: Integer): Integer; register;
asm
  {$IFDEF WIN32}
        mov     ecx, eax
        mov     eax, 1
   lock xadd    [ecx], eax
        inc     eax
  {$ENDIF WIN32}
  {$IFDEF WIN64}
        mov     rax, 1
   lock xadd    [rcx], rax
        inc     rax
  {$ENDIF WIN64}
end;

function LockedDec(var Target: Integer): Integer; register;
asm
  {$IFDEF WIN32}
        mov     ecx, eax
        mov     eax, -1
   lock xadd    [ecx], eax
        dec     eax
  {$ENDIF WIN32}
  {$IFDEF WIN64}
        mov     rax, -1
   lock xadd    [rcx], rax
        dec     rax
  {$ENDIF WIN64}
end;

procedure TwbContainer.AfterConstruction;
begin
  inherited;
  {$IFDEF WIN64}
  LockedDec(cntElementRefs);
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov eax, [Self]
    lock dec dword ptr [eax + cntElementRefs]
  end;
  {$ENDIF WIN32}
  Include(cntStates, csConstructionCompleted);
end;

function TwbContainer.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Container       : IwbContainer;
  uContainer      : IwbContainerElementRef;
  sElement        : IwbElement;
  BasePtr         : Pointer;
  i, j            : Integer;
  SelfRef         : IwbContainerElementRef;
  Def             : IwbDef;
  ValueDef        : IwbValueDef;
  ResolvableDef   : IwbResolvableDef;
  HasMap          : Boolean;
  StructDef       : IwbStructDef;
  OurSize         : Integer;
begin
  Result := nil;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');

    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
      Exit;
  end;

  SelfRef := Self as IwbContainerElementRef;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  DoInit(True);

  if inherited CanAssignInternal(aIndex, aElement, False) then
    Result := inherited AssignInternal(aIndex, aElement, aOnlySK);

  if (aIndex = wbAssignThis) and (Length(cntElements) > 0) then begin

    if Supports(aElement, IwbContainer, Container) and (Container.ElementCount = GetElementCount) then begin

      ValueDef := GetValueDef;
      if (ValueDef = aElement.ValueDef) or
        ( Assigned(ValueDef) and
          (
            ValueDef.Equals(aElement.ValueDef) or
            ValueDef.CanAssign(Self, aIndex, aElement.ValueDef)
          )
        ) then begin
            HasMap := Length(cntElementsMap) > 0;
            if HasMap then begin
              Assert(Length(cntElements) = Length(cntElementsMap));
              //if the elements haven't got their space allocated yet, we need
              //to make sure they are first written to in the "on disk" order
              //before copying in the mapped order below
              SetToDefault;
            end;
            for i := Low(cntElements) to High(cntElements) do begin
              if HasMap then
                j := cntElementsMap[i]
              else
                j := i;

              // if we have a union, we cannot progress until the union has been resolved and its cntElements is populated
              sElement := Container.Elements[i];
              if (sElement.ElementType = etUnion) and
                 Supports(cntElements[j], IwbContainerElementRef, uContainer) and
                 Supports(uContainer.GetValueDef, IwbResolvableDef, ResolvableDef) then begin
                if (uContainer.ElementCount = 1) then begin // At this point it is usually the default choice set by default
                  uContainer.RemoveElement(0);
                end;
                if (uContainer.ElementCount = 0) then begin
                  BasePtr := nil;
                  var lResolvedDef: IwbValueDef;
                  UnionDoInit(ResolvableDef, uContainer as IwbContainer, BasePtr, nil, lResolvedDef);
                end;
              end;
              if (not aOnlySK or GetIsInSK(cntElements[j].SortOrder)) then begin
                if cntElements[j].CanAssign(wbAssignThis, sElement, False) then
                  cntElements[j].Assign(wbAssignThis, sElement, aOnlySK)
                else if Supports(sElement.ValueDef, IwbEmptyDef) then begin
                  // this might be a case the source begin a struct
                  // with "OptionalFromElement" empty elements at the end
                  If Supports(Container.ResolvedValueDef, IwbStructDef, StructDef) then
                    if StructDef.OptionalFromElement >= 0 then
                      if StructDef.OptionalFromElement <= j then begin
                        //yes it is
                        Assert(not HasMap); //this would be really tricky to handle with mapped elements...
                        Assert(Self is TwbDataContainer); //if the source is a struct and is assignable to us, this should be guaranteed
                        OurSize := 0;
                        for j := Low(cntElements) to Pred(i) do
                          Inc(OurSize, cntElements[j].DataSize);
                        if GetDataSize > OurSize then
                          with TwbDataContainer(Self) do begin
                            UpdateStorageFromElements;
                            Assert(Length(dcDataStorage) >= OurSize);
                            Assert(not (dcfStorageInvalid in dcFlags));
                            Reset;
                            SetLength(dcDataStorage, OurSize);
                            if OurSize > 0 then begin
                              dcDataBasePtr := @dcDataStorage[Low(dcDataStorage)];
                              dcDataEndPtr := PByte(dcDataBasePtr) + OurSize;
                            end else begin
                              dcDataBasePtr := @EmptyPtr;
                              dcDataEndPtr := @EmptyPtr;
                            end;
                            Init;
                          end;
                        Exit;
                      end;

                  //source is a wbEmpty, target is something else, just reset target
                  cntElements[j].SetToDefault;
                end;
              end;
            end;
        end;
    end;

  end;
end;

procedure TwbContainer.Bar;
begin

end;

procedure TwbContainer.BeforeDestruction;
begin
  if csConstructionCompleted in cntStates then
    Assert(cntElementRefs = 0)
  else
    Assert(cntElementRefs = 1);

  inherited BeforeDestruction;

  if csConstructionCompleted in cntStates then begin
    {$IFDEF WIN64}
    LockedInc(cntElementRefs);
    {$ENDIF WIN64}
    {$IFDEF WIN32}
    asm
           mov eax, [Self]
      lock inc dword ptr [eax + cntElementRefs]
    end;
    {$ENDIF WIN32}
  end;
end;

procedure TwbContainer.BuildRef;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  var lDef := GetDef;
  if Assigned(lDef) and (dfExcludeFromBuildRef in lDef.DefFlags) then
    Exit;

  var lValueDef := GetValueDef;
  if Assigned(lValueDef) and (dfExcludeFromBuildRef in lValueDef.DefFlags) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Include(cntStates, csRefsBuild);
  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].CanContainFormIDs then
      cntElements[i].BuildRef;
  cntRefsBuildAt := eGeneration;
end;

function TwbContainer.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  Container : IwbContainer;
  i         : Integer;
  SelfRef   : IwbContainerElementRef;
  Def       : IwbDef;
  ValueDef  : IwbValueDef;
begin
  Result := False;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;

    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
      Exit;
  end;

  if not Assigned(aElement) then
    Exit;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  SelfRef := Self as IwbContainerElementRef;

  Result := inherited CanAssignInternal(aIndex, aElement, aCheckDontShow);

  DoInit(True);

  if not Result and (aIndex = wbAssignThis) and (Length(cntElements) > 0) then begin

    if Supports(aElement, IwbContainer, Container) and (Container.ElementCount = GetElementCount) then begin
      ValueDef := GetValueDef;
      Result := (ValueDef = aElement.ValueDef) or
        ( Assigned(ValueDef) and
          (
            ValueDef.Equals(aElement.ValueDef) or
            ValueDef.CanAssign(Self, aIndex, aElement.ValueDef)
          )
        );
    end;

    if Result then
      for i := Low(cntElements) to High(cntElements) do begin
        Result :=
          (cntElements[i].ConflictPriority = cpIgnore) or
          (Container.Elements[i].ConflictPriority = cpIgnore) or
          cntElements[i].CanAssign(wbAssignThis, Container.Elements[i], aCheckDontShow);
        if not Result then
          Exit;
      end;
  end;
end;

function TwbContainer.CanChangeElementMember(const aElement: IwbElement): Boolean;
var
  SubRecordArrayDef : IwbSubRecordArrayDef;
  SubRecordStructDef : IwbSubRecordStructDef;
  Def               : IwbDef;
  ValueDef          : IwbValueDef;
begin
  Result := False;
  if not wbIsInternalEdit then begin
    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
      Exit;
    ValueDef := GetValueDef;
    if Assigned(ValueDef) and (dfInternalEditOnly in ValueDef.DefFlags) then
      Exit;
  end;
  if not IsElementEditable(Self) then
    Exit;

  if Supports(GetDef, IwbSubRecordArrayDef, SubRecordArrayDef) then begin
    Result := Supports(SubRecordArrayDef.Element, IwbSubRecordUnionDef);
  end else if Supports(GetDef, IwbSubRecordStructDef, SubRecordStructDef) then begin
    var lSortOrder := aElement.SortOrder;
    if (lSortOrder >= 0) and
       (lSortOrder < SubRecordStructDef.MemberCount)
    then
      Result := Supports(SubRecordStructDef.Members[lSortOrder], IwbSubRecordUnionDef);
  end;
end;

function TwbContainer.CanMoveElement: Boolean;
begin
  Result := False;
end;

function TwbContainer.CanMoveElementDown(const aElement: IwbElement): Boolean;
var
  i        : Integer;
  Def      : IwbDef;
  ValueDef : IwbValueDef;
begin
  Result := False;
  if not wbIsInternalEdit then begin
    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
      Exit;
    ValueDef := GetValueDef;
    if Assigned(ValueDef) and (dfInternalEditOnly in ValueDef.DefFlags) then
      Exit;
  end;
  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;
  if not CanMoveElement then
    Exit;
  if Length(cntElements) < 2 then
    Exit;
  if cntElements[High(cntElements)].Equals(aElement) then
    Exit;
  Result := True;
  for i := 0 to Pred(High(cntElements)) do
    if cntElements[i].Equals(aElement) then
      Exit;
  Result := False;
end;

function TwbContainer.CanMoveElementUp(const aElement: IwbElement): Boolean;
var
  i: Integer;
  Def      : IwbDef;
  ValueDef : IwbValueDef;
begin
  Result := False;
  if not wbIsInternalEdit then begin
    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
      Exit;
    ValueDef := GetValueDef;
    if Assigned(ValueDef) and (dfInternalEditOnly in ValueDef.DefFlags) then
      Exit;
  end;
  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;
  if not CanMoveElement then
    Exit;
  if Length(cntElements) < 2 then
    Exit;
  if cntElements[0].Equals(aElement) then
    Exit;
  Result := True;
  for i := 1 to High(cntElements) do
    if cntElements[i].Equals(aElement) then
      Exit;
  Result := False;
end;

function TwbContainer.CanElementReset: Boolean;
begin
  if Assigned(eContainer) then
    Result := IwbContainer(eContainer).CanElementReset
  else
    Result := True;
end;

function TwbContainer.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  i        : Integer;
  SelfRef  : IwbContainerElementRef;
  Elements : TDynElementInternals;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Result := False;
  BeginUpdate;
  try
    Elements := Copy(cntElements);
    for i := Low(Elements) to High(Elements) do
      if Elements[i].CanContainFormIDs then
        Result := Elements[i].CompareExchangeFormID(aOldFormID, aNewFormID) or Result;
  finally
    EndUpdate;
  end;
end;

function TwbContainer.ContainsReflection: Boolean;
begin
  Result := inherited ContainsReflection;
  if Result then
    Exit;

  var lDef := GetDef;
  if not Assigned(lDef) or not (dfCanContainReflection in lDef.DefFlags) then
    Exit;

  var SelfRef := Self as IwbContainerElementRef;

  for var lElementIdx := 0 to Pred(GetElementCount) do begin
    Result := cntElements[lElementIdx].ContainsReflection;
    if Result then
      Exit;
  end;
end;

function TwbContainer.ContainsUnmappedFormID: Boolean;
begin
  Result := inherited ContainsUnmappedFormID;
  if Result then
    Exit;

  var lDef := GetDef;
  if not Assigned(lDef) or not (dfCanContainUnmappedFormID in lDef.DefFlags) then
    Exit;

  var SelfRef := Self as IwbContainerElementRef;

  for var lElementIdx := 0 to Pred(GetElementCount) do begin
    Result := cntElements[lElementIdx].ContainsUnmappedFormID;
    if Result then
      Exit;
  end;
end;

function TwbContainer.ContentIsAllZero: Boolean;
var
  SelfRef : IwbContainerElementRef;
  i       : Integer;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Result := True;
  for i := Low(cntElements) to High(cntElements) do begin
    Result := cntElements[i].ContentIsAllZero;
    if not Result then
      Exit;
  end;
end;

procedure TwbContainer.CreatedEmpty;
begin
  Include(cntStates, csAsCreatedEmpty);
end;

procedure TwbContainer.Init;
begin
  { can be overriden }
end;

destructor TwbContainer.Destroy;
begin
  ReleaseElements;
  inherited;
end;

procedure TwbContainer.DoInit(aNeedSorted: Boolean);
var
  i        : Integer;
  ValueDef : IwbValueDef;
  KAC      : PwbKeepAliveContext;
begin
  if esDestroying in eStates then
    Exit;
  if csInit in cntStates then
    Exit;
  if [csInitializing, csReseting] * cntStates <> [] then
    Exit;
  Exclude(cntStates, csSortedBySortOrder);
  Include(cntStates, csInitializing);
  wbLockProcessMessages;
  try
    cntElementsMap := nil;
    Include(cntStates, csInit);
    Include(cntStates, csInitOnce);
    Init;
    Include(cntStates, csInitDone);
    for i := Low(cntElements) to High(cntElements) do
      cntElements[i].MemoryOrder := i;
    ValueDef := GetValueDef;
    if Assigned(ValueDef) then
      cntElementsMap := ValueDef.GetElementMap;
    if not wbSpeedOverMemory then
      if not (GetElementType in [etMainRecord, etGroupRecord]) then
        if not Assigned(cntKeepAliveNext) and (Length(cntElements) > 0) then begin
          KAC := wbKeepAliveContext;
          if Assigned(KAC) then begin
            cntKeepAliveNext := KAC.kacHead;
            KAC.kacHead := Self as IwbContainerElementRef;
          end;
        end;
  finally
    wbUnLockProcessMessages;
    Exclude(cntStates, csInitializing);
  end;
end;

procedure TwbContainer.DoReset(aForce: Boolean);

  procedure CheckCollapsedGen;
  var
    Def: IwbDef;
  begin
    if Supports(GetDef, IwbDef, Def) then
      if Def.CollapsedGen > cntCollapesGen then begin
        Exclude(cntStates, csCollapsed);
        Exclude(cntStates, csExpanded);
      end;
  end;

begin
  if not aForce then begin
    if not (csInit in cntStates) then
      Exit;
    if esModified in eStates then
      Exit;
    if cntElementRefs > 0 then
      Exit;
    if not CanElementReset then
      Exit;
    if [csCollapsed, csExpanded] * cntStates <> [] then begin
      CheckCollapsedGen;
      if [csCollapsed, csExpanded] * cntStates <> [] then
        Exit;
    end;
  end;

  if [csInitializing, csReseting] * cntStates <> [] then
    Exit;

  Exclude(cntStates, csSortedBySortOrder);

  {$IFDEF WIN64}
  LockedInc(cntElementRefs);
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov eax, [Self]
    lock inc dword ptr [eax + cntElementRefs]
  end;
  {$ENDIF WIN32}
  try
    Include(cntStates, csReseting);
    Exclude(cntStates, csInitDone);
    Reset;
    cntElementsMap := nil;
  finally
    Exclude(cntStates, csReseting);
    {$IFDEF WIN64}
    LockedDec(cntElementRefs);
    {$ENDIF WIN64}
    {$IFDEF WIN32}
    asm
           mov eax, [Self]
      lock dec dword ptr [eax + cntElementRefs]
    end;
    {$ENDIF WIN32}
    Exclude(cntStates, csInit);
  end;
end;

function TwbContainer.ResetLeafFirst: Boolean;
begin
  Result := ResetChildrenLeafFirst;
  Result := inherited ResetLeafFirst and Result;
end;

{$D-}
function TwbContainer.ElementAddRef: Integer;
begin
  {$IFDEF WIN64}
  LockedInc(cntElementRefs);
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov eax, [Self]
    lock inc dword ptr [eax + cntElementRefs]
  end;
  {$ENDIF WIN32}
  Result := inherited _AddRef;
end;
{$D+}

procedure TwbContainer.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
begin
  NotifyChanged(aContainer);
end;

{$D-}
function TwbContainer.ElementRelease: Integer;
label
  Skip;
begin
  {$IFDEF WIN64}
  if LockedDec(cntElementRefs) = 0 then
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov  eax, -1
         mov  ecx, [Self]
    lock xadd dword ptr [ecx + cntElementRefs], eax
         cmp  eax, 1
         jne  Skip
  end;
  {$ENDIF WIN32}
  DoReset(False);
Skip:

  Result := inherited _Release;
end;
{$D+}

function TwbContainer.FindBySortKey(const aSortKey: string; aExtended: Boolean; out aIndex: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;

  L := Low(cntElements);
  H := High(cntElements);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CompareStr(cntElements[I].SortKey[aExtended], aSortKey);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        Result := True;
        L := I;
      end;
    end;
  end;
  aIndex := L;
end;

function TwbContainer.FindBySortOrder(const aSortOrder: Integer; out aIndex: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;

  L := Low(cntElements);
  H := High(cntElements);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpI32(cntElements[I].SortOrder, aSortOrder);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        Result := True;
        L := I;
      end;
    end;
  end;
  aIndex := L;
end;

procedure TwbContainer.FindUsedMasters(aMasters: PwbUsedMasters);
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  inherited;
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].CanContainFormIDs then
      cntElements[i].FindUsedMasters(aMasters);
end;

procedure TwbContainer.FreeInstance;
begin
  Assert(cntElementRefs = 1);
  inherited;
end;

function TwbContainer.GetAdditionalElementCount: Integer;
begin
  Result := 0;
end;

function TwbContainer.GetAddList: TDynStrings;
begin
  Result := nil;
end;

function TwbContainer.GetAnyElement: IwbElement;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);
  if Length(cntElements) > 0 then
    Result := cntElements[0]
  else
    Result := nil;
end;

function TwbContainer.GetCollapsed: TwbTriBool;
var
  Def: IwbDef;
begin
  Def := nil;
  if Supports(GetDef, IwbDef, Def) then
    if Def.CollapsedGen > cntCollapesGen then begin
      Exclude(cntStates, csCollapsed);
      Exclude(cntStates, csExpanded);
      cntCollapesGen := Def.CollapsedGen;
    end;

  if csCollapsed in cntStates then
    Result := tbTrue
  else if csExpanded in cntStates then
    Result := tbFalse
  else begin
    Result := tbUnknown;
    if Assigned(Def) then
      if Def.Collapsed then
        Result := tbTrue
      else
        Result := tbFalse;
   end;
end;

function TwbContainer.GetContainerStates: TwbContainerStates;
begin
  Result := cntStates;
end;

function TwbContainer.GetDataSize: Integer;
begin
  Result := GetDataSizeFromElements;
end;

function TwbContainer.GetDataSizeFromElements: Integer;
var
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  DataContainer : IwbDataContainer;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := 0;
  DoInit(False);

  var lArrayDef: IwbArrayDef;
  if Supports(GetValueDef, IwbArrayDef, lArrayDef) then begin
    var lWronglyAssumedFixedSizePerElement := lArrayDef.WronglyAssumedFixedSizePerElement;
    if lWronglyAssumedFixedSizePerElement > 0 then
      Exit(GetElementCount * lWronglyAssumedFixedSizePerElement);
  end;

  for i := Low(cntElements) to High(cntElements) do begin
    if Supports(cntElements[i], IwbDataContainer, DataContainer) and DataContainer.DontSave then
      Continue;

    Inc(Result, cntElements[i].DataSize);
  end;
end;

function TwbContainer.GetElement(aIndex: Integer): IwbElement;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(True);
  if not Assigned(cntElements) or (aIndex>=Length(cntElements)) then begin // Using the wrong contained array at the time
    if wbMoreInfoForIndex and (DebugHook <> 0) and wbHasProgressCallback then
      wbProgressCallback('Debugger: [' + (Self as IwbElement).Path + '] Index ' + IntToStr(aIndex) + ' greater than max ' +
        IntToStr(Length(cntElements)-1));
    Result := nil
  end else begin
    if Length(cntElementsMap) = Length(cntElements) then
      aIndex := cntElementsMap[aIndex];
    Result := IInterface(cntElements[aIndex]) as IwbElement;
  end;
end;

function TwbContainer.GetElementByName(const aName: string): IwbElement;
var
  i: integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Result := nil;
  try
    for i := Low(cntElements) to High(cntElements) do
      if SameText(cntElements[i].Name, aName) then begin
        Result := IInterface(cntElements[i]) as IwbElement;
        Exit;
      end;
    for i := Low(cntElements) to High(cntElements) do
      if SameText(cntElements[i].DisplayName[True], aName) then begin
        Result := IInterface(cntElements[i]) as IwbElement;
        Exit;
      end;
  except
    on E: Exception do
      wbProgressCallback('Debugger: [' + (Self as IwbElement).Path + '] Exception in GetElementByName: ['+E.ClassName+'] ' + E.Message);
  end;
end;

function TwbContainer.GetElementByPath(const aPath: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Path      : string;
  Container : IwbContainerElementRef;
begin
  Result := nil;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aPath, Path);
  if not Assigned(Element) then
    Exit;

  if Path = '' then
    Result := Element
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementByPath[Path];
end;

function TwbContainer.GetElementByMemoryOrder(aSortOrder: Integer): IwbElement;
var
  i: integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);
  Dec(aSortOrder, GetAdditionalElementCount);
  Result := nil;
  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].MemoryOrder = aSortOrder then begin
      Result := IInterface(cntElements[i]) as IwbElement;
      Exit;
    end;
end;

function TwbContainer.GetElementBySignature(const aSignature: TwbSignature): IwbElement;
var
  i: integer;
  HasSignature: IwbHasSignature;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);
  Result := nil;

  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbHasSignature, HasSignature) then
      if HasSignature.Signature = aSignature then begin
        Result := HasSignature;
        Exit;
      end;
end;

function TwbContainer.GetElementBySortOrder(aSortOrder: Integer): IwbElement;
var
  i: integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);
  Dec(aSortOrder, GetAdditionalElementCount);

  Result := nil;
  if (csSortedBySortOrder in cntStates) and (Length(cntElements) > 8)  then begin
    if FindBySortOrder(aSortOrder, i) then
      Result := IInterface(cntElements[i]) as IwbElement;
  end else
    for i := Low(cntElements) to High(cntElements) do
      if cntElements[i].SortOrder = aSortOrder then begin
        Result := IInterface(cntElements[i]) as IwbElement;
        Exit;
      end;
end;

function TwbContainer.GetElementCount: Integer;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
//  if not (csInit in cntStates) then
    DoInit(False);
  Result := Length(cntElements);
end;

function TwbContainer.GetElementEditValue(const aName: string): string;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  Result := '';

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then begin
    if Name = '' then
      Result := GetMemberEditValue(aName);
    Exit;
  end;

  if Name = '' then
    Result := Element.EditValue
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementEditValues[Name];
end;

function TwbContainer.GetElementExists(const aName: string): Boolean;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  Result := False;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Result := True
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementExists[Name];
end;

function TwbContainer.GetElementLinksTo(const aName: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  Result := nil;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Result := Element.LinksTo
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementLinksTo[Name];
end;

function TwbContainer.GetElementNativeValue(const aName: string): Variant;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  VarClear(Result);

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then begin
    if Name = '' then
      Result := GetMemberNativeValue(aName);
    Exit;
  end;

  if Name = '' then
    Result := Element.NativeValue
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementNativeValues[Name];
end;

function TwbContainer.GetElementSortKey(const aName: string;
  aExtended: Boolean): string;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  Result := '';

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Result := Element.SortKey[aExtended]
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementSortKeys[Name, aExtended];
end;

function TwbContainer.GetElementSummary(const aName: string): string;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  Result := '';

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Result := Element.Summary
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementSummaries[Name];
end;

function TwbContainer.GetElementValue(const aName: string): string;
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  Result := '';

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Result := Element.Value
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementValues[Name];
end;

function TwbContainer.GetIsInSK(aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TwbContainer.GetMemberEditValue(const aName: string): string;
var
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  FlagDef    : IwbFlagDef;
  s          : string;
  i          : Integer;
begin
  Result := '';
  if Supports(GetValueDef, IwbIntegerDef, IntegerDef) then
    if Supports(IntegerDef.Formater[Self], IwbFlagsDef, FlagsDef) then
      if FlagsDef.FindFlag(aName, FlagDef) then begin
        s := GetEditValue;
        i := Succ(FlagDef.FlagIndex);
        if Length(s) >= i then
          Result := s[i]
        else
          Result := '0';
      end;
end;

function TwbContainer.GetMemberNativeValue(const aName: string): Variant;
var
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  FlagDef    : IwbFlagDef;
  s          : string;
  i          : Integer;
begin
  VarClear(Result);
  if Supports(GetValueDef, IwbIntegerDef, IntegerDef) then
    if Supports(IntegerDef.Formater[Self], IwbFlagsDef, FlagsDef) then
      if FlagsDef.FindFlag(aName, FlagDef) then begin
        s := GetEditValue;
        i := Succ(FlagDef.FlagIndex);
        if Length(s) >= i then
          Result := s[i] = '1'
        else
          Result := False;
      end;
end;

function TwbContainer.GetRecordBySignature(const aSignature: TwbSignature): IwbRecord;
var
  i: integer;
  lRecord: IwbRecord;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Result := nil;
  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbRecord, lRecord) then
      if lRecord.Signature = aSignature then begin
        Result := lRecord;
        Exit;
      end;
end;

function TwbContainer.GetCountedRecordCount: Cardinal;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := 0;
  DoInit(False);
  for i := Low(cntElements) to High(cntElements) do
    Inc(Result, cntElements[i].GetCountedRecordCount);
end;

function TwbContainer.GetSortKeyInternal(aExtended: Boolean): string;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);
  Result := '';
  for i := Low(cntElements) to High(cntElements) do begin
    Result := Result + cntElements[i].SortKey[aExtended];
    if i < High(cntElements) then
      Result := Result + '|';
  end;
end;

function TwbContainer.HasErrors: Boolean;
var
  SelfRef : IwbContainerElementRef;
  i       : Integer;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Result := inherited HasErrors;
  if Result then
    Exit;

  for i := Low(cntElements) to High(cntElements) do begin
    Result := cntElements[i].HasErrors;
    if Result then
      Exit;
  end;
end;

function TwbContainer.LastElement: IwbElement;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);
  if Length(cntElements) > 0 then
    Result := IInterface(cntElements[High(cntElements)]) as IwbElement
  else
    Result := nil;
end;

procedure TwbContainer.MarkModifiedRecursive(const aElementTypes: TwbElementTypes);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  if not (GetElementType in aElementTypes) then
    Exit;

  wbTick;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  BeginUpdate;
  try
    for i := Low(cntElements) to High(cntElements) do
      cntElements[i].MarkModifiedRecursive(aElementTypes);
    inherited;
  finally
    EndUpdate;
  end;
end;

function TwbContainer.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  BeginUpdate;
  try
    wbTick;

    DoInit(False);
    Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);

    for i := Low(cntElements) to High(cntElements) do
      if cntElements[i].CanContainFormIDs then
        Result := cntElements[i].MastersUpdated(aOld, aNew, aOldCount, aNewCount) or Result;
  finally
    EndUpdate;
  end;
end;

procedure TwbContainer.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SelfRef             : IwbContainerElementRef;
  MemoryOrderElements : TArray<Pointer>;
  ElementPtrs         : PwbPointerArray;
  i                   : Integer;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(True);

  if Length(cntElements) < 1 then
    Exit;

  if UpdateMemoryOrder(MemoryOrderElements) then
    ElementPtrs := @MemoryOrderElements[0]
  else
    ElementPtrs := @cntElements[0];

  for i := Low(cntElements) to High(cntElements) do
    IwbElement(ElementPtrs[i]).MergeStorage(aBasePtr, aEndPtr);
end;

procedure TwbContainer.MoveElementDown(const aElement: IwbElement);
var
  i: Integer;
begin
  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;
  if not CanMoveElement then
    Exit;
  if Length(cntElements) < 2 then
    Exit;
  if cntElements[High(cntElements)].Equals(aElement) then
    Exit;
  for i := 0 to Pred(High(cntElements)) do
    if cntElements[i].Equals(aElement) then begin
      SetModified(True);
      InvalidateStorage;

      cntElements[i] := cntElements[Succ(i)];
      cntElements[Succ(i)] := aElement as IwbElementInternal;

      ResetMemoryOrder(i, Succ(i));

      Exit;
    end;
end;

procedure TwbContainer.MoveElementUp(const aElement: IwbElement);
var
  i: Integer;
begin
  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;
  if not CanMoveElement then
    Exit;
  if Length(cntElements) < 2 then
    Exit;
  if cntElements[0].Equals(aElement) then
    Exit;
  for i := 1 to High(cntElements) do
    if cntElements[i].Equals(aElement) then begin
      SetModified(True);
      InvalidateStorage;

      cntElements[i] := cntElements[Pred(i)];
      cntElements[Pred(i)] := aElement as IwbElementInternal;

      ResetMemoryOrder(Pred(i), i);

      Exit;
    end;
end;

class function TwbContainer.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TwbContainer(Result).cntElementRefs := 1;
end;

procedure TwbContainer.NotifyChanged(aContainer: Pointer);
begin
  if csInitializing in cntStates then
    Exit;
  inherited;
end;

procedure TwbContainer.NotifyChangedInternal(aContainer: Pointer);
begin
  if [csInitializing, csReseting] * cntStates <> [] then
    Exit;
  if csAsCreatedEmpty in cntStates then
    Exclude(cntStates, csAsCreatedEmpty);
  if csSortedBySortOrder in cntStates then begin
    Exclude(cntStates, csSortedBySortOrder);
    SetIsSortedBySortOrder(False);
  end;

  inherited;

  if esModified in eStates then
    DoAfterSet(Unassigned, Unassigned);
end;

procedure TwbContainer.PrepareSave;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  if wbDelayLoadRecords then
    if not (esModified in eStates) then
      Exit;

  SelfRef := Self as IwbContainerElementRef;
  //DoInit(True);
  for i := High(cntElements) downto Low(cntElements) do
    cntElements[i].PrepareSave;
end;

function TwbContainer.ChangeElementMember(const aElement: IwbElement; aPrevious: Boolean): IwbElement;
var
  SelfRef             : IwbContainerElementRef;
  Container           : IwbContainer;

  SubRecordArrayDef   : IwbSubRecordArrayDef;
  SubRecordStructDef   : IwbSubRecordStructDef;
  SubRecordUnionDef   : IwbSubRecordUnionDef;
  RecordDef           : IwbRecordDef;

  MemoryOrderElements : TArray<Pointer>;

  i                   : Integer;

  OldElementIndex     : Integer;

  OldMemberIndex      : Integer;
  NewMemberIndex      : Integer;

  NewElementDef       : IwbRecordMemberDef;
  NewElement          : IwbElement;
  NewElementIndex     : Integer;
begin
  Result := aElement;

  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(aElement) then
    Exit;
  if not Supports(aElement.Container, IwbContainer, Container) then
    Exit;
  if not Equals(Container) then
    Exit;

  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;

  if not CanChangeElementMember(aElement) then
    Exit;

  if not Supports(GetDef, IwbSubRecordArrayDef, SubRecordArrayDef) or
     not Supports(SubRecordArrayDef.Element, IwbSubRecordUnionDef, SubRecordUnionDef) then begin

    if Supports(GetDef, IwbSubRecordStructDef, SubRecordStructDef) then begin
      var lSortOrder := aElement.SortOrder;
      if (lSortOrder >= 0) and
         (lSortOrder < SubRecordStructDef.MemberCount)
      then begin
        if not Supports(SubRecordStructDef.Members[lSortOrder], IwbSubRecordUnionDef, SubRecordUnionDef) then
          Exit
      end else
        Exit;

      if not Supports(SubRecordUnionDef, IwbRecordDef, RecordDef) then
        Exit;

    end else
      Exit;

  end else begin
    if not Supports(SubRecordArrayDef.Element, IwbRecordDef, RecordDef) then
      Exit;
  end;

  OldMemberIndex := -1;
  for i := 0 to Pred(RecordDef.MemberCount) do
    if RecordDef.Members[i].Equals(aElement.Def) then begin
      OldMemberIndex := i;
      Break;
    end;

  if OldMemberIndex < 0 then
    Exit;

  if aPrevious then begin
    NewMemberIndex := OldMemberIndex - 1;
    if NewMemberIndex < 0 then
      NewMemberIndex := Pred(RecordDef.MemberCount);
  end else begin
    NewMemberIndex := OldMemberIndex + 1;
    if NewMemberIndex >= RecordDef.MemberCount then
      NewMemberIndex := 0;
  end;

  if NewMemberIndex = OldMemberIndex then
    Exit;

  NewElementDef := RecordDef.Members[NewMemberIndex];

  if Assigned(SubRecordArrayDef) then begin
    // Make sure memory order is updated properly
    UpdateMemoryOrder(MemoryOrderElements);

    OldElementIndex := -1;
    for i := Low(cntElements) to High(cntElements) do
      if aElement.Equals(cntElements[i]) then begin
        OldElementIndex := i;
        Break;
      end;

    if OldElementIndex < 0 then
      Exit;

    BeginUpdate;
    try
      case NewElementDef.DefType of
        dtSubRecord:
          NewElement := TwbSubRecord.Create(Self, NewElementDef as IwbSubRecordDef);
        dtSubRecordArray:
          NewElement := TwbSubRecordArray.Create(Self, nil, wbAssignThis, NewElementDef as IwbSubRecordArrayDef);
        dtSubRecordStruct:
          NewElement := TwbSubRecordStruct.Create(Self, nil, wbAssignThis, NewElementDef as IwbSubRecordStructDef);
      else
        Assert(False);
      end;

      NewElement.SetToDefault;

      Assert(aElement.Equals(cntElements[OldElementIndex]));

      NewElementIndex := -1;
      for i := High(cntElements) downto Low(cntElements) do
        if NewElement.Equals(cntElements[i]) then begin
          NewElementIndex := i;
          Break;
        end;

      Assert(NewElementIndex >= 0);

      cntElements[OldElementIndex] := NewElement as IwbElementInternal;
      cntElements[OldElementIndex].MemoryOrder := OldElementIndex;

      cntElements[NewElementIndex] := aElement as IwbElementInternal;
      cntElements[NewElementIndex].MemoryOrder := NewElementIndex;

{      if NewElement.CanAssign(wbAssignThis, aElement, False) then
        NewElement.Assign(wbAssignThis, aElement, False)
      else}
        (NewElement as IwbElementInternal).TryAssignMembers(aElement);

      Result := NewElement;
      aElement.Remove;
    finally
      EndUpdate;
    end;
  end else if Assigned(SubRecordStructDef) then begin
    var lSortOrder := aElement.SortOrder;
    aElement.Remove;

    Result := Assign(lSortOrder, TwbTemplateElement.Create(NewElementDef), False);
    Result.SetToDefault;

{    if Result.CanAssign(wbAssignThis, aElement, False) then
      Result.Assign(wbAssignThis, aElement, False)
    else}
      (Result as IwbElementInternal).TryAssignMembers(aElement);
  end;
end;

function TwbContainer.Reached: Boolean;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  Result := False;

  if GetDontShow then
    Exit;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Result := inherited Reached;
  if not Result then
    Exit;

  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].CanContainFormIDs then
      cntElements[i].Reached;
end;

function TwbContainer.ReleaseElements: TDynElementInternals;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  if not (esDestroying in eStates) then
    SelfRef := Self as IwbContainerElementRef;

  Result := cntElements;
  cntElements := nil;
  for i := Low(Result) to High(Result) do
    Result[i].SetContainer(nil);
  Exclude(cntStates, csAsCreatedEmpty);
  Exclude(cntStates, csSortedBySortOrder);
end;

function TwbContainer.ReleaseKeepAlive: IwbContainerElementRef;
begin
  Result := cntKeepAliveNext;
  cntKeepAliveNext := nil;
end;

function TwbContainer.RemoveElement(const aElement: IwbElement; aMarkModified: Boolean = False): IwbElement;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := aElement;
  if not Assigned(aElement) then
    Exit;

  if Length(cntElements) > 0 then begin
    if cntElements[High(cntElements)].Equals(aElement) then begin
      Result := RemoveElement(High(cntElements), aMarkModified);
      Exit;
    end;

    for i := Low(cntElements) to Pred(High(cntElements)) do
      if cntElements[i].Equals(aElement) then begin
        Result := RemoveElement(i, aMarkModified);
        Exit;
      end;
  end;

  Result := nil;
  Exit;
end;

function TwbContainer.RemoveElement(const aName: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Result := ResolveElementName(aName, Name);
  if not Assigned(Result) then
    Exit;

  if Name = '' then
    Result.Remove
  else if Supports(Result, IwbContainerElementRef, Container) then
    Result := Container.RemoveElement(Name)
  else
    Result := nil;
end;

function TwbContainer.RemoveInjected(aCanRemove: Boolean): Boolean;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Result := GetReferencesInjected;
  if not Result then
    for i := High(cntElements) downto Low(cntElements) do
      if cntElements[i].CanContainFormIDs then begin
        Result := cntElements[i].RemoveInjected(True) or Result;
        if Result and aCanRemove then
          Break;
      end;
  if Result and aCanRemove and GetIsRemovable then begin
    Result := False;
    Remove;
  end;
end;

procedure TwbContainer.ReportRequiredMasters(aDict: TwbFilesDictionary; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  var Def := GetDef;
  if Assigned(Def) and (dfDontAssign in Def.DefFlags) then
    Exit;

  var ValueDef := GetValueDef;
  if Assigned(ValueDef) and (dfDontAssign in ValueDef.DefFlags) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  inherited;
  if Recursive or (Initial and not Supports(Self, IwbGroupRecord)) then
    for i := Low(cntElements) to High(cntElements) do
      if cntElements[i].CanContainFormIDs then
        cntElements[i].ReportRequiredMasters(aDict, aAsNew, Recursive);
end;

function TwbContainer.RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := nil;

  if aPos < Low(cntElements) then
    Exit
  else if aPos > High(cntElements) then
    Exit;

  if aMarkModified then begin
    SetModified(True);
    InvalidateStorage;
  end;

  Result := IInterface(cntElements[aPos]) as IwbElement;
  cntElements[aPos].SetContainer(nil);
  cntElements[aPos] := nil;

  if aPos < High(cntElements) then begin
    Move(cntElements[Succ(aPos)], cntElements[aPos], (High(cntElements) - aPos) * SizeOf(Pointer));
    Pointer(cntElements[High(cntElements)]) := nil;
  end;

  SetLength(cntElements, Pred(Length(cntElements)));

  ResetMemoryOrder(aPos);

  NotifyChanged(eContainer);
end;

procedure TwbContainer.Reset;
begin
  { can be overriden }
end;

function TwbContainer.ResetChildrenLeafFirst: Boolean;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  Result := True;
  SelfRef := Self as IwbContainerElementRef;
  //DoInit; elements that don't exist yet don't have anything to reset...
  for i := Low(cntElements) to High(cntElements) do
    Result := cntElements[i].ResetLeafFirst and Result;
end;

procedure TwbContainer.ResetConflict;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
//  DoInit; elements that don't exist yet don't have anything to reset...
  inherited;
  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].ResetConflict;
end;

procedure TwbContainer.ResetMemoryOrder(aFrom: Integer = 0; aTo: Integer = High(Integer));
var
  i : Integer;
begin
  aFrom := Max(aFrom, Low(cntElements));
  aTo := Min(aTo, High(cntElements));
  for i := aFrom to aTo do
    cntElements[i].MemoryOrder := i;
end;

procedure TwbContainer.ResetModified(aResetModified: TwbResetModified);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  // NOT Init... we only need to reset elements that already exist

  inherited;

  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].ResetModified(aResetModified);

  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

procedure TwbContainer.ResetReachable;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
//  DoInit; elements that don't exist yet don't have anything to reset...
  inherited;
  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].ResetReachable;
end;

procedure TwbContainer.ResetTags;
var
  i: Integer;
begin
  inherited;
  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].ResetTags;
end;

function TwbContainer.ResolveElementName(aName: string; out aRemainingName: string; aCanCreate: Boolean = False): IwbElement;
var
  i : Integer;
begin
  Result := nil;

  aRemainingName := '';
  i := Pos('\', aName);
  if i > 0 then begin
    aRemainingName := Copy(aName, Succ(i), High(Integer));
    Delete(aName, i, High(Integer));
  end;

  if aName = '.' then
    Result := Self
  else if aName = '..' then
    Result := GetContainer
  else if aName = '...' then begin // this or any parent

    var lNextRemainingName := '';
    var lNextName := aRemainingName;
    i := Pos('\', lNextName);
    if i > 0 then begin
      lNextRemainingName := Copy(lNextName, Succ(i), High(Integer));
      Delete(lNextName, i, High(Integer));
    end;
    lNextName := lNextName.Trim;
    if lNextName = '' then
      Exit(Self);

    var lSigPtr    : PwbSignature := nil;
    var lSignature : TwbSignature := #0#0#0#0;
    if (Length(aName) = 4) then begin
      lSignature := StrToSignature(aName);
      lSigPtr := @lSigPtr;
    end;

    var lContainer: IwbContainerInternal := Self;
    while Assigned(lContainer) do begin

      var lRemainingName := '';
      var lCheckElement := lContainer.ResolveElementName(aRemainingName, lRemainingName, aCanCreate);
      if Assigned(lCheckElement) then begin
        aRemainingName := lRemainingName;
        Exit(lCheckElement);
      end;

      var lHasSignature: IwbHasSignature;
      if SameText(lContainer.Name, lNextName) or
         SameText(lContainer.DisplayName[True], lNextName) or
         (
           Assigned(lSigPtr) and
           Supports(lContainer, IwbHasSignature, lHasSignature) and
           (lHasSignature.Signature = lSigPtr^)
         )
      then begin
        aRemainingName := lNextRemainingName;
        Exit(lContainer);
      end;
      if not Supports(lContainer.Container, IwbContainerInternal, lContainer) then
        Exit(nil);
    end;

  end else if (Length(aName) > 0) and (aName[1] = '[') and (aName[Length(aName)] = ']') then begin
    i := StrToIntDef(Copy(aName, 2, Length(aName) - 2), 0);
    Result := GetElement(i);
  end else
    Result := GetElementByName(aName);

  if not Assigned(Result) and (Length(aName) = 4) then
    Result := GetElementBySignature(StrToSignature(aName));
end;

procedure TwbContainer.ReverseElements;
var
  Temp: TDynElementInternals;
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  SetLength(Temp, Length(cntElements));
  for i := Low(cntElements) to High(cntElements) do
    Temp[High(cntElements)-i] := cntElements[i];
  cntElements := Temp;
  Exclude(cntStates, csSortedBySortOrder);
end;

procedure TwbContainer.SetCollapsed(const aValue: TwbTriBool);
var
  Def: IwbDef;
begin
  Def := GetDef;
  if Assigned(Def) then
    cntCollapesGen := Def.CollapsedGen;
  case aValue of
    tbTrue: begin
      Include(cntStates, csCollapsed);
      Exclude(cntStates, csExpanded);
    end;
    tbFalse: begin
      Exclude(cntStates, csCollapsed);
      Include(cntStates, csExpanded);
    end;
  else
    Exclude(cntStates, csCollapsed);
    Exclude(cntStates, csExpanded);
  end;
end;

procedure TwbContainer.SetElementEditValue(const aName, aValue: string);
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name, True);
  if not Assigned(Element) then begin
    if Name = '' then
      SetMemberEditValue(aName, aValue);
    Exit;
  end;

  if Name = '' then
    Element.EditValue := aValue
  else if Supports(Element, IwbContainerElementRef, Container) then
    Container.ElementEditValues[Name] := aValue;
end;

procedure TwbContainer.SetElementNativeValue(const aName: string; const aValue: Variant);
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Element := ResolveElementName(aName, Name, True);
  if not Assigned(Element) then begin
    if Name = '' then
      SetMemberNativeValue(aName, aValue);
    Exit;
  end;

  if Name = '' then
    Element.NativeValue := aValue
  else if Supports(Element, IwbContainerElementRef, Container) then
    Container.ElementNativeValues[Name] := aValue;
end;

procedure TwbContainer.SetIsSortedBySortOrder(aForce: Boolean);
var
  i: Integer;
begin
  if not aForce then
    for i := 1 to High(cntElements) do
      if cntElements[Pred(i)].SortOrder >= cntElements[i].SortOrder then begin
        Exclude(cntStates, csSortedBySortOrder);
        Exit;
      end;
  Include(cntStates, csSortedBySortOrder);
end;

procedure TwbContainer.SetMemberEditValue(const aName, aValue: string);
var
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  FlagDef    : IwbFlagDef;
  s          : string;
  b          : Boolean;
  Element    : IwbElement;
begin
  if Supports(GetValueDef, IwbIntegerDef, IntegerDef) then
    if Supports(IntegerDef.Formater[Self], IwbFlagsDef, FlagsDef) then
      if FlagsDef.FindFlag(aName, FlagDef) then begin
        b := aValue = '1';
        s := GetEditValue;
        s := s + StringOfChar('0', 64 - Length(s));
        if (FlagDef.FlagIndex >= 0) and (FlagDef.FlagIndex < Length(s)) then begin
          if b then
            s[Succ(FlagDef.FlagIndex)] := '1'
          else
            s[Succ(FlagDef.FlagIndex)] := '0';
          SetEditValue(s);
        end;
        Exit;
      end;
  Element := Add(aName, True);
  if Assigned(Element) then
    Element.EditValue := aValue;
end;

procedure TwbContainer.SetMemberNativeValue(const aName: string; const aValue: Variant);
var
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  FlagDef    : IwbFlagDef;
  s          : string;
  b          : Boolean;
  Element    : IwbElement;
begin
  if Supports(GetValueDef, IwbIntegerDef, IntegerDef) then
    if Supports(IntegerDef.Formater[Self], IwbFlagsDef, FlagsDef) then
      if FlagsDef.FindFlag(aName, FlagDef) then begin
        b := aValue;
        s := GetEditValue;
        s := s + StringOfChar('0', 64 - Length(s));
        if (FlagDef.FlagIndex >= 0) and (FlagDef.FlagIndex < Length(s)) then begin
          if b then
            s[Succ(FlagDef.FlagIndex)] := '1'
          else
            s[Succ(FlagDef.FlagIndex)] := '0';
          SetEditValue(s);
        end;
        Exit;
      end;
  Element := Add(aName, True);
  if Assigned(Element) then
    Element.EditValue := aValue;
end;

procedure TwbContainer.SetToDefaultIfAsCreatedEmpty;
begin
  if csAsCreatedEmpty in cntStates then
    SetToDefault;
end;

procedure TwbContainer.SetToDefaultInternal;
var
  i         : Integer;
  SelfRef   : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  inherited;

  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].SetToDefault;

  Exclude(cntStates, csAsCreatedEmpty);
end;

procedure TwbContainer.SortBySortOrder;
var
  i, j: Integer;
begin
  SetModified(True);
  i := GetAdditionalElementCount;
  j := Length(cntElements) - i;
  if j > 1 then begin
    wbMergeSortPtr(@cntElements[i], j, CompareSortOrder);
    InvalidateStorage;
  end;
  Include(cntStates, csSortedBySortOrder);
end;

function TwbContainer.UpdateMemoryOrder(out aMemoryOrderElements: TArray<Pointer>): Boolean;
var
  i: Integer;
  j: Integer;

  l: Integer;
  m: Integer;
  n: Integer;

  NeedsSort : Boolean;

  Terminators : TArray<Pointer>;
begin
  Result := False;
  aMemoryOrderElements := nil;
  Terminators := nil;
  if Length(cntElements) < 1 then
    Exit;
  If not (GetElementType in SortedElementTypes) then
    Exit;

  m := Low(Integer);
  i := -1;
  j := -2;
  NeedsSort := False;
  for l := Low(cntElements) to High(cntElements) do begin
    if Supports(cntElements[l], IwbStringListTerminator) then
      Terminators.Add(cntElements[l])
    else begin
      n := cntElements[l].MemoryOrder;
      if n > m then
        m := n
      else begin
        NeedsSort := True;
        if n = Low(Integer) then begin
          if i < 0 then
            i := l;
          j := l;
        end;
      end;
    end;
  end;

  if m = Low(Integer) then
    m := -1;

  for l := i to j do
    if cntElements[l].MemoryOrder = Low(Integer) then begin
      Inc(m);
      cntElements[l].MemoryOrder := m;
    end;

  for l := Low(Terminators) to High(Terminators) do begin
    Inc(m);
    if IwbElement(Terminators[l]).MemoryOrder <> m then
      NeedsSort := True;
    IwbElement(Terminators[l]).MemoryOrder := m;
  end;

  if Length(cntElements) < 2 then
    NeedsSort := False;

  if NeedsSort then begin
    l := Length(cntElements);
    SetLength(aMemoryOrderElements, l);
    Move(cntElements[0], aMemoryOrderElements[0], l * SizeOf(Pointer));
    wbMergeSortPtr(@aMemoryOrderElements[0], l, CompareMemoryOrder);
    Result := True;
  end;
end;

procedure TwbContainer.UpdateNameSuffixes;
begin
  {can be overridden}
end;

procedure TwbContainer.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(True);
  inherited;
  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].WriteToStream(aStream, aResetModified);

  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

{$D-}
function TwbContainer._AddRef: Integer;
begin
  if wbSpeedOverMemory then
    Result := ElementAddRef
  else
    Result := inherited _AddRef;
end;

function TwbContainer._Release: Integer;
begin
  if wbSpeedOverMemory then
    Result := ElementRelease
  else begin
    Result := inherited _Release;
    if (Result > 0) and (cntElementRefs = 0) and (csInit in cntStates) then
      DoReset(False);
  end;
end;
{$D+}

//------------------------------------------------------------------------------
// TwbRecord
//------------------------------------------------------------------------------

constructor TwbRecord.Create(const aContainer      : IwbContainer;
                               var aBasePtr        : Pointer;
                               var aEndPtr         : Pointer;
                             const aPrevMainRecord : IwbMainRecord);
var
  Dummy: Integer;
begin
  inherited Create(aContainer, aBasePtr, aEndPtr, aPrevMainRecord);
  recSkipped := recSkipped or RecordToSkip.Find(GetSignature, Dummy);
  InformPrevMainRecord(aPrevMainRecord);
  ScanData;
  if aBasePtr <> dcDataEndPtr then begin
    Assert( (wbGameMode = gmTES3) and (GetSignature = 'CELL') or (GetSignature = 'REFR') );
    if GetSignature = 'CELL' then
      aEndPtr := aBasePtr;
    aBasePtr := dcDataEndPtr;
  end;
end;

class function TwbRecord.CreateForPtr(var aPtr            : Pointer;
                                      var aEndPtr         : Pointer;
                                    const aContainer      : IwbContainer;
                                    const aPrevMainRecord : IwbMainRecord)
                                                          : IwbRecord;
begin
  try
    if Assigned(aContainer) and (aContainer.ElementType = etMainRecord) then
      Result := TwbSubRecord.Create(aContainer, aPtr, aEndPtr, aPrevMainRecord)
    else
      if PwbSignature(aPtr)^ = 'GRUP' then
        Result := TwbGroupRecord.Create(aContainer, aPtr, aEndPtr, aPrevMainRecord)
      else begin
        if (wbGameMode = gmTES3) and (PwbSignature(aPtr)^ = 'NAM0') then
          Result := TwbSubRecord.Create(nil, aPtr, aEndPtr, nil)
        else
          Result := TwbMainRecord.Create(aContainer, aPtr, aEndPtr, aPrevMainRecord);
      end;

    wbTick;
  except
    on E: EwbSkipLoad do begin
      wbProgress('Skipped Load: ' + E.Message);
      Result := nil;
    end;
  end;
end;

function TwbRecord.GetDisplaySignature: string;
begin
  var Sig := GetSignature;
  if (Sig[1] = 'I') and (Sig[2] = 'A') and (Sig[3] = 'D') then
    Result := '#$' + IntToHex(Ord(Sig[0]), 2) + 'IAD'
  else
    Result := Sig;
end;

function TwbRecord.GetName: string;
var
  Sig : TwbSignature;
  i   : Integer;
begin
  Sig := GetSignature;
  for i := Low(Sig) to High(Sig) do
    if Ord(Sig[i]) < 32 then
      Sig[i] := AnsiChar( Ord('a') + Ord(Sig[i]) );

  Result := Sig;
end;

function TwbRecord.GetSkipped: Boolean;
begin
  Result := recSkipped;
end;

procedure TwbRecord.InformPrevMainRecord(const aPrevMainRecord: IwbMainRecord);
begin
  {can be overriden}
end;

procedure TwbRecord.SetSkipped(aValue: Boolean);
begin
  inherited;
  recSkipped := aValue;
end;

function TwbRecord.GetSignature: TwbSignature;
begin
  if Assigned(dcBasePtr) then
    Result := PwbSignature(dcBasePtr)^
  else
    Result := NONE;
end;

{ TwbMainRecord }

function TwbMainRecord.ActivateIndexKeys: TwbDefinedKeys;
begin
  Assert(not (mrsIndexKeysActive in mrStates));
  if BuildIndexKeys(mrIndexKeys) then begin
    Include(mrStates, mrsIndexKeysActive);
    Result := mrIndexKeys.GetDefinedKeys;
  end else
    Result := nil;
end;

function TwbMainRecord.DeactivateIndexKeys: TwbDefinedKeys;
begin
  if mrsIndexKeysActive in mrStates then begin
    Result := mrIndexKeys.GetDefinedKeys;
    Exclude(mrStates, mrsIndexKeysActive);
  end else
    Result := nil;
  mrIndexKeys.Clear;
end;

function TwbMainRecord.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  s         : string;
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
  Group     : IwbGroupRecord;
  GrpType   : Integer;
begin
  Result := nil;

  if not wbIsInternalEdit then
    if not wbEditAllowed or not GetIsEditable then
      raise Exception.Create(GetName + ' can not be edited');

  if GetIsDeleted then
    Exit;

  s := Copy(aName, 1, 4);

  if (GetSignature = 'CELL') and
     (
        SameText(s, 'NAVM') or
        SameText(s, 'PGRD') or
        SameText(s, 'LAND') or
        SameText(s, 'REFR') or
        SameText(s, 'PGRE') or
        SameText(s, 'PMIS') or
        SameText(s, 'ACRE') or
        SameText(s, 'ACHR') or
        SameText(s, 'PARW') or {>>> Skyrim <<<}
        SameText(s, 'PBEA') or {>>> Skyrim <<<}
        SameText(s, 'PFLA') or {>>> Skyrim <<<}
        SameText(s, 'PCON') or {>>> Skyrim <<<}
        SameText(s, 'PBAR') or {>>> Skyrim <<<}
        SameText(s, 'PHZD')    {>>> Skyrim <<<}
     ) then begin

    Group := GetChildGroup;
    if not Assigned(Group) then begin
      Group := TwbGroupRecord.Create(GetContainer, 6, Self);
      mrGroup := Group;
    end;
    Result := Group.Add(aName, aSilent);
    Exit;
  end else if (GetSignature = 'DIAL') and
     (
        SameText(s, 'INFO')
     ) then begin

    Group := GetChildGroup;
    if not Assigned(Group) then begin
      Group := TwbGroupRecord.Create(GetContainer, 7, Self);
      mrGroup := Group;
    end;

    Result := Group.Add(aName, aSilent);

    Exit;
  end else if (GetSignature = 'WRLD') and
     (
        SameText(s, 'ROAD') or
        SameText(s, 'CELL')
     ) then begin

    Group := GetChildGroup;
    if not Assigned(Group) then begin
      Group := TwbGroupRecord.Create(GetContainer, 1, Self);
      mrGroup := Group;
    end;

    Result := Group.Add(aName, aSilent);

    Exit;
  end else if wbVWDAsQuestChildren and (GetSignature = 'QUST') and
     (
        SameText(s, 'DLBR') or
        SameText(s, 'DIAL') or
        SameText(s, 'SCEN')
     ) then begin

    Group := GetChildGroup;
    if not Assigned(Group) then begin
      Group := TwbGroupRecord.Create(GetContainer, 10, Self);
      mrGroup := Group;
    end;

    Result := Group.Add(aName, aSilent);

    Exit;
  end;

  if Assigned(mrDef) then begin

    SelfRef := Self as IwbContainerElementRef;
    DoInit(True);

    for i := 0 to Pred(mrDef.MemberCount) do
      if SameText(mrDef.Members[i].Name, aName) or SameText(mrDef.Members[i].DefaultSignature, aName) then begin
        Result := GetElementBySortOrder(i + GetAdditionalElementCount);
        if not Assigned(Result) then begin
          Assign(i, nil, False);
          Result := GetElementBySortOrder(i + GetAdditionalElementCount);

          if wbSortSubRecords and (Length(cntElements) > 1) then
            wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSubRecords);
        end;

        Exit;
      end;
  end;
end;

function TwbMainRecord.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
begin
  if not wbIsInternalEdit then
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');

  if GetIsDeleted then begin
    var lHasSignature: IwbHasSignature;
    if (wbGameMode >= gmFO4) and
       Supports(aElement, IwbHasSignature, lHasSignature) and
       Assigned(mrDef) and
       (mrDef.KnownSubRecordSignatures[ksrBaseRecord] = lHasSignature.Signature)
    then begin
      //allow NAME in FO4, SSE, and newer for deleted records
    end else
      Exit;
  end;

  if GetIsPartialForm then begin
    var lHasSignature: IwbHasSignature;
    if Supports(aElement, IwbHasSignature, lHasSignature) and
       Assigned(mrDef) and
       (mrDef.KnownSubRecordSignatures[ksrEditorID] = lHasSignature.Signature)
    then begin
      //allow EDID for partial forms
    end else
      Exit;
  end;

  if Assigned(mrDef) then begin

    SelfRef := Self as IwbContainerElementRef;
    DoInit(True);

    Assert(Assigned(aElement.Def));
    if aElement.SortOrder < 0 then begin
      Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
      Assert(Assigned(Result));
      Assert(Assigned(Result.Def));
      Assert(aElement.Def.Equals(Result.Def));
    end else begin
      Assert(aElement.SortOrder >= 0);
      Assert(aElement.SortOrder < mrDef.MemberCount);
      if not aElement.Def.Equals(mrDef.Members[aElement.SortOrder]) then
        Assert(Self.CanAssign(aElement.SortOrder, aElement, True));
      Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
    end;

    if not Assigned(Result) then begin
      Assign(aElement.SortOrder, aElement, not aDeepCopy);
      Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
      Assert(Assigned(Result));

      if wbSortSubRecords and (Length(cntElements) > 1) then
        wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSubRecords);
    end else
      Result.Assign(wbAssignThis, aElement, not aDeepCopy);
  end;
end;

procedure TwbMainRecord.AddOverride(const aMainRecord: IwbMainRecord);
begin
  if aMainRecord.Signature <> GetSignature then
    if wbHasProgressCallback then
      wbProgressCallback(Format('Warning: Record %s in file %s is being overridden by record %s in file %s.', [
        '[' + GetSignature + ':' + GetFormID.ToString(True) + ']',
        GetFile.FileName,
        '[' + aMainRecord.Signature + ':' + aMainRecord.FormID.ToString(True) + ']',
        aMainRecord._File.FileName
      ]));

  SetLength(mrOverrides, Succ(Length(mrOverrides)));
  mrOverrides[High(mrOverrides)] := aMainRecord;
  (aMainRecord as IwbMainRecordInternal).SetMaster(Self);
  Exclude(mrStates, mrsOverridesSorted);
  mrMasterAndLeafs := nil;
end;

{$IFDEF USE_PARALLEL_BUILD_REFS}
var
  _ResizeLock: TRTLCriticalSection;
{$ENDIF}

procedure TwbMainRecord.AddReferencedBy(const aMainRecord : IwbMainRecord);
var
  i : Integer;
begin
  if Assigned(mrMaster) then begin
    IwbMainRecord(mrMasteR).AddReferencedBy(aMainRecord);
    Exit;
  end;
{$IFDEF USE_PARALLEL_BUILD_REFS}
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}
    begin
      i:= mrReferencedByCount;
      Inc(mrReferencedByCount);
      if i >= mrReferencedBySize then
        if mrReferencedBySize = 0 then
          mrReferencedBySize := 4
        else
          mrReferencedBySize := mrReferencedBySize * 2;
        SetLength(mrReferencedBy, mrReferencedBySize);
    end;
    mrReferencedBy[i] := aMainRecord;
    Include(mrStates, mrsReferencedByUnsorted);
{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

procedure TwbMainRecord.AddReferencedFromID(aFormID: TwbFormID);
begin
  Assert(mrsBuildingRef in mrStates);

  if aFormID.IsNull then
    Exit;

  if not Assigned(mrTmpRefFormIDs) then
    mrTmpRefFormIDs := TwbFormIDDictionary.Create(Length(mrReferences));

  mrTmpRefFormIDs.TryAdd(aFormID, wbNothing);
end;

function TwbMainRecord.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  MainRecord    : IwbMainRecord;
  Member        : IwbRecordMemberDef;
  Container     : IwbContainerElementRef;
  Element       : IwbElement;
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  BasePtr       : Pointer;
  IsAdd         : Boolean;
  IsAddChild    : Boolean;
  GroupRecord   : IwbGroupRecord;
  DataContainer : IwbDataContainer;
  NeedUpdate    : Boolean;
begin
  Result := nil;

  if wbIsStarfield and wbStarfieldIsABugInfestedHellhole then
    if (aIndex = wbAssignThis) and (GetSignature = 'PKIN') then begin
      var lMainRecord: IwbMainRecord;
      if Supports(aElement, IwbMainRecord, lMainRecord) then begin
        if lMainRecord.LoadOrderFormID = GetLoadOrderFormID then
          Exit;
      end else
        Exit;
    end;

  if not wbIsInternalEdit then
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');

  if GetIsDeleted then
    if aIndex <> wbAssignThis then begin
      var lDeleteShouldExit := True;
      if (wbGameMode >= gmFO4) and Assigned(mrDef) then begin
        lDeleteShouldExit := mrDef.KnownSubRecordMemberIndex[ksrBaseRecord] <> aIndex;

        if not lDeleteShouldExit and Assigned(aElement) then begin
          var lHasSignature: IwbHasSignature;
          if Supports(aElement, IwbHasSignature, lHasSignature) then
            lDeleteShouldExit := mrDef.KnownSubRecordSignatures[ksrBaseRecord] <> lHasSignature.Signature;
        end;
      end;

      if lDeleteShouldExit then
        Exit;
    end;

  if GetIsPartialForm then
    if aIndex <> wbAssignThis then begin
      var lPartialShouldExit := True;
      if Assigned(mrDef) then begin
        lPartialShouldExit := mrDef.KnownSubRecordMemberIndex[ksrEditorID] <> aIndex;

        if not lPartialShouldExit and Assigned(aElement) then begin
          var lHasSignature: IwbHasSignature;
          if Supports(aElement, IwbHasSignature, lHasSignature) then
            lPartialShouldExit := mrDef.KnownSubRecordSignatures[ksrEditorID] <> lHasSignature.Signature;
        end;

        if lPartialShouldExit and (wbFillINOM or wbFillINOA) and (GetSignature = 'DIAL') then begin
          var lDIALMember := mrDef.Members[aIndex];
          if Assigned(lDIALMember) then begin
            if (wbFillINOM and (lDIALMember.DefaultSignature = 'INOM')) or
               (wbFillINOA and (lDIALMember.DefaultSignature = 'INOA'))
            then
              lPartialShouldExit := False;
          end;
        end;
      end;

      if lPartialShouldExit then
        Exit;
    end;

  if Assigned(mrDef) then begin

    wbBeginKeepAlive;
    try
      SelfRef := Self as IwbContainerElementRef;
      DoInit(True);

      if aIndex = wbAssignThis then begin

        NeedUpdate := CheckChildOfCell;

        SetModified(True);
        InvalidateStorage;
        ReleaseElements;

        if Assigned(aElement) then begin
          Container := aElement as IwbContainerElementRef;

          if Supports(aElement, IwbMainRecord, MainRecord) then begin
            MakeHeaderWriteable;
            with TwbMainRecord(MainRecord.ElementID) do begin
              Self.mrStruct.mrsFlags^ := mrStruct.mrsFlags^;
              Self.mrStruct.mrsVCS1^ := DefaultVCS1;
              if wbGameMode >= gmFO3 then begin
                Self.mrStruct.mrsVersion^ := mrStruct.mrsVersion^;
                Self.mrStruct.mrsVCS2^ := DefaultVCS2;
              end;
            end;
          end;
        end;

        if Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
          if wbCreateContainedIn and (GroupRecord.GroupType in [1, 4..10]) then
            with TwbContainedInElement.Create(Self) do begin
              _AddRef; _Release;
            end;
        GroupRecord := nil;

        BasePtr := dcBasePtr;
        with TwbRecordHeaderStruct.Create(Self, BasePtr, PByte(BasePtr) + wbSizeOfMainRecordStruct, mrDef.RecordHeaderStruct, '') do begin
          Include(dcFlags, dcfDontSave);
          SetSortOrder(-1);
          SetMemoryOrder(Low(Integer));
          _AddRef; _Release;
        end;

        if Assigned(aElement) then begin
          for i := 0 to Pred(Container.ElementCount) do begin
            Element := Container.Elements[i];
            if Assigned(Element.Def) and (dfNoCopyAsOverride in Element.Def.DefFlags) then
              if GetMasterOrSelf.Equals(Element.ContainingMainRecord.MasterOrSelf) then
                Continue;
            Assign(Element.SortOrder, Element, aOnlySK);
          end;
        end else begin
          for i := 0 to Pred(mrDef.MemberCount) do
            if mrDef.Members[i].Required then
              Assign(i, nil, False);
        end;

        if NeedUpdate then
          UpdateCellChildGroup;

        CollapseStorage(nil, True);

      end else begin
        if (aIndex >= 0) and (aIndex < mrDef.MemberCount) then begin
          Member := mrDef.Members[aIndex];
          IsAdd := not Assigned(aElement) or Member.CanAssign(Self, wbAssignThis, aElement.Def);
          IsAddChild := not IsAdd and Assigned(aElement) and Member.CanAssign(Self, wbAssignAdd, aElement.Def);
          if IsAdd or IsAddChild then begin
            Element := GetElementBySortOrder(aIndex + GetAdditionalElementCount);
            if Assigned(Element) then begin
              if IsAdd and Assigned(aElement) then
                Element.Assign(wbAssignThis, aElement, aOnlySK)
              else if IsAddChild then
                Element.Assign(wbAssignAdd, aElement, aOnlySK);
            end else begin

              if Member.DefType = dtSubRecordUnion then begin
                var lHasSignature: IwbHasSignature;
                if Supports(aElement, IwbHasSignature, lHasSignature) then begin
                  if not Supports(aElement, IwbDataContainer, DataContainer) then
                    DataContainer := nil;
                  Member := (Member as IwbRecordDef).GetMemberFor(Self, lHasSignature.Signature, DataContainer);
                end else
                  Member := (Member as IwbRecordDef).Members[0];

                Assert(Assigned(Member));
                if not (Member.DefType in [dtSubRecord, dtSubRecordArray, dtSubRecordStruct]) then
                  Beep;
              end;

              case Member.DefType of
                dtSubRecord:
                  Element := TwbSubRecord.Create(Self, Member as IwbSubRecordDef);
                dtSubRecordArray:
                  Element := TwbSubRecordArray.Create(Self, nil, wbAssignThis, Member as IwbSubRecordArrayDef);
                dtSubRecordStruct:
                  Element := TwbSubRecordStruct.Create(Self, nil, wbAssignThis, Member as IwbSubRecordStructDef);
              else
                Assert(False);
              end;

              if Assigned(Element) then try
                Element.SortOrder := aIndex;
                Element.MemoryOrder := aIndex;
                if IsAdd and Assigned(aElement) then
                  Element.Assign(wbAssignThis, aElement, aOnlySK)
                else if IsAddChild then
                  Element.Assign(wbAssignAdd, aElement, aOnlySK);
              except
                Element.Container.RemoveElement(Element);
                raise;
              end;

            end;
            Result := Element;
          end;
        end else if (aIndex = -2) then begin
          Element := GetElementBySortOrder(aIndex + GetAdditionalElementCount);
          if Assigned(Element) then
            Element.Assign(wbAssignThis, aElement, False);
          Result := Element;
        end;
      end;
    finally
      wbEndKeepAlive;
    end;

    if wbSortSubRecords and (Length(cntElements) > 1) then
      wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSubRecords);

  end else
    Result := inherited AssignInternal(aIndex, aElement, aOnlySK);
end;

function TwbMainRecord.BuildIndexKeys(out aKeys: TwbIndexKeys): Boolean;
begin
  Result := False;
  aKeys.Clear;
  if Assigned(mrDef) then begin
    if GetCanHaveEditorID and wbTrackAllEditorID or (dfIndexEditorID in mrDef.DefFlags) then begin
      Result := True;
      aKeys.Keys[wbIdxEditorID] := GetEditorID;
    end
  end;
  if Assigned(mrDef) and mrDef.BuildIndexKeys(Self, aKeys) then
    Result := True;
end;

procedure TwbMainRecord.BuildRef;

  procedure UseKAC;
  var
    KAR: IwbKeepAliveRoot;
  begin
    KAR := wbCreateKeepAliveRoot;
    DoBuildRef(False);
    KAR := nil;
  end;

begin
  if not Assigned(mrDef) then
    Exit;

  if dfExcludeFromBuildRef in mrDef.DefFlags then
    Exit;

  if mrsNoUpdateRefs in mrStates then
    Exit;

  if (csRefsBuild in cntStates) and (cntRefsBuildAt >= eGeneration) then
    Exit;

  if wbSpeedOverMemory then
    DoBuildRef(False)
  else begin
    UseKAC;
    if _FileRefsBuilding and not (esModified in eStates) then
      if ResetChildrenLeafFirst then
        Reset;
  end;

  if wbHasProgressCallback then
    wbProgressCallback;
end;

procedure TwbMainRecord.DoAfterSet(const aOldValue, aNewValue: Variant);
var
  SelfRef   : IwbContainerElementRef;
  DataRec   : IwbContainerElementRef;
  Position  : IwbElement;
begin
  SelfRef := Self;
  DoInit(False);
  inherited;
  if mrDef.IsReference and CheckChildOfCell then begin
    if not Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, DataRec) then
      Exit;
    if DataRec.ElementCount <> 2 then
      Exit;
    Position := DataRec.Elements[0];
    if not Position.Modified then
      Exit;
    if Position.ElementGeneration = mrPositionGeneration then
      Exit;
    UpdateCellChildGroup;
    mrPositionGeneration := Position.ElementGeneration;
  end;
end;

function TwbMainRecord.DoBuildRef(aRemove: Boolean): Boolean;
var
  _File          : IwbFile;

  Files          : array of IwbFile;
  FilesCount     : Integer;

  FullFiles      : array of IwbFile;
  FullFilesCount : Integer;

  MediumFiles      : array of IwbFile;
  MediumFilesCount : Integer;

  LightFiles      : array of IwbFile;
  LightFilesCount : Integer;

  SelfIntf      : IwbMainRecord;

  procedure ProcessRef(aFormID: TwbFormID; aAdd: Boolean);
  begin
    Result := True;
    var MainRecord: IwbMainRecord := nil;

    if wbComplexFileFileID then begin

      var lFileID := aFormID.FileID;
      var lFileIndex: Integer;

      if not lFileID.IsValid or (lFileID.IsFullSlot and (lFileID.FullSlot > lFileID.MaxFullSlot)) then
        Exit;

      if not Assigned(_File) then begin
        _File := GetFile;
        SelfIntf := Self as IwbMainRecord;
      end;

      case lFileID.ModuleType of

        mtLight: begin

          if LightFilesCount < 0 then begin
            LightFilesCount := _File.LightMasterCount[GetMastersUpdated];
            SetLength(LightFiles, Succ(LightFilesCount));
            LightFiles[LightFilesCount] := _File;
          end;

          lFileIndex := lFileID.LightSlot;
          if lFileIndex > LightFilesCount then
            lFileIndex := LightFilesCount;

          if not Assigned(LightFiles[lFileIndex]) then
            LightFiles[lFileIndex] := _File.LightMasters[lFileIndex, GetMastersUpdated];

          aFormID.FileID := LightFiles[lFileIndex].FileFileID[True];
          MainRecord := LightFiles[lFileIndex].RecordByFormID[aFormID, True, True];

        end;

        mtMedium: begin

          if MediumFilesCount < 0 then begin
            MediumFilesCount := _File.MediumMasterCount[GetMastersUpdated];
            SetLength(MediumFiles, Succ(MediumFilesCount));
            MediumFiles[MediumFilesCount] := _File;
          end;

          lFileIndex := lFileID.MediumSlot;

          if lFileIndex > MediumFilesCount then
            lFileIndex := MediumFilesCount;

          if not Assigned(MediumFiles[lFileIndex]) then
            MediumFiles[lFileIndex] := _File.MediumMasters[lFileIndex, GetMastersUpdated];

          aFormID.FileID := MediumFiles[lFileIndex].FileFileID[True];
          MainRecord := MediumFiles[lFileIndex].RecordByFormID[aFormID, True, True];

        end;

        mtFull: begin
          if FullFilesCount < 0 then begin
            FullFilesCount := _File.FullMasterCount[GetMastersUpdated];
            SetLength(FullFiles, Succ(FullFilesCount));
            FullFiles[FullFilesCount] := _File;
          end;

          lFileIndex := lFileID.FullSlot;
          if lFileIndex > FullFilesCount then
            lFileIndex := FullFilesCount;

          if not Assigned(FullFiles[lFileIndex]) then
            FullFiles[lFileIndex] := _File.FullMasters[lFileIndex, GetMastersUpdated];

          aFormID.FileID := FullFiles[lFileIndex].FileFileID[True];
          MainRecord := FullFiles[lFileIndex].RecordByFormID[aFormID, True, True];

        end;
      end;
    end else begin
      if not Assigned(_File) then begin
        _File := GetFile;
        FilesCount := _File.MasterCount[GetMastersUpdated];
        SetLength(Files, Succ(FilesCount));
        Files[FilesCount] := _File;
        SelfIntf := Self as IwbMainRecord;
      end;

      var FileID := aFormID.FileID.FullSlot;
      if FileID > FilesCount then
        FileID := FilesCount;

      if not Assigned(Files[FileID]) then
        Files[FileID] := _File.Masters[FileID, GetMastersUpdated];

      aFormID.FileID := Files[FileID].FileFileID[True];
      MainRecord := Files[FileID].RecordByFormID[aFormID, True, True];
    end;

    if Assigned(MainRecord) then
      if aAdd then
        MainRecord.AddReferencedBy(SelfIntf)
      else
        MainRecord.RemoveReferencedBy(SelfIntf);
  end;

var
  SelfRef       : IwbContainerElementRef;
begin
  Result := False;

  if dfExcludeFromBuildRef in mrDef.DefFlags then
    Exit;

  if mrsBuildingRef in mrStates then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  FullFilesCount := -1;
  MediumFilesCount := -1;
  LightFilesCount := -1;

  Assert(not (mrsBuildingRef in mrStates));
  Include(mrStates, mrsBuildingRef);
  try
    var lTmpRefFormIDs: TwbFormIDs := nil;
    FreeAndNil(mrTmpRefFormIDs);
    try

      if aRemove then begin
        Exclude(cntStates, csRefsBuild);
        cntRefsBuildAt := 0;
      end else
        inherited BuildRef;

      if Assigned(mrTmpRefFormIDs) then
        lTmpRefFormIDs := mrTmpRefFormIDs.Keys.ToArray;

    finally
      FreeAndNil(mrTmpRefFormIDs)
    end;

    var lTmpRefFormIDsLength := Length(lTmpRefFormIDs);
    if lTmpRefFormIDsLength > 0 then
      wbMergeSort32(@lTmpRefFormIDs[0], lTmpRefFormIDsLength, CompareFormIDs);

    var lTmpIdx := 0;
    var lOldIdx := 0;
    while (lTmpIdx < lTmpRefFormIDsLength) and (lOldIdx < Length(mrReferences)) do begin
      var lCmpResult := TwbFormID.Compare(lTmpRefFormIDs[lTmpIdx], mrReferences[lOldIdx]);
      if lCmpResult = 0 then begin
        Inc(lTmpIdx);
        Inc(lOldIdx);
      end else if lCmpResult < 0 then begin
        ProcessRef(lTmpRefFormIDs[lTmpIdx], True);
        Inc(lTmpIdx);
      end else begin
        ProcessRef(mrReferences[lOldIdx], False);
        Inc(lOldIdx);
      end;
    end;
    while lTmpIdx < lTmpRefFormIDsLength do begin
      ProcessRef(lTmpRefFormIDs[lTmpIdx], True);
      Inc(lTmpIdx);
    end;
    while lOldIdx < Length(mrReferences) do begin
      ProcessRef(mrReferences[lOldIdx], False);
      Inc(lOldIdx);
    end;

    mrReferences := lTmpRefFormIDs;
  finally
    Exclude(mrStates, mrsBuildingRef);
    mrTmpRefFormIDs := nil;
  end;
end;

function TwbMainRecord.DoGetFixedFormID: TwbFormID;
begin
  if wbGameMode = gmTES3 then
    Result := GetFormID
  else
    Result := PwbMainRecordStruct(dcBasePtr).mrsFormID^;

  var lFile := GetFile;
  if Assigned(lFile) then begin
    if Result.ObjectID < $800 then
      if lFile.GetAllowHardcodedRangeUse then begin
        if Result.IsHardcoded then
          Exit;
      end else begin
        Result.FileID := TwbFileID.Null;
        Exit;
      end;

    if wbComplexFileFileID then begin
      var lFileID := Result.FileID;
      case lFileID.ModuleType of
        mtLight:
          if lFileID.LightSlot >= lFile.LightMasterCount[GetMastersUpdated] then
            Result.FileID := lFile.FileFileID[GetMastersUpdated];
        mtMedium:
          if lFileID.MediumSlot >= lFile.MediumMasterCount[GetMastersUpdated] then
            Result.FileID := lFile.FileFileID[GetMastersUpdated];
        mtFull:
          if lFileID.FullSlot >= lFile.FullMasterCount[GetMastersUpdated] then
            Result.FileID := lFile.FileFileID[GetMastersUpdated];
      end;
    end else
      if Result.FileID.FullSlot >= lFile.MasterCount[GetMastersUpdated] then
        Result.FileID := lFile.FileFileID[GetMastersUpdated];
  end;
  mrFixedFormID := Result;
end;

function TwbMainRecord.DoGetLoadOrderFormID: TwbFormID;
var
  _File   : IwbFile;
begin
  Result := GetFixedFormID;
  if Result.IsNull then
    Exit;

  _File := GetFile;
  if not Assigned(_File) then begin
    Result := TwbFormID.Null;
    Exit;
  end;

  Result := _File.FileFormIDtoLoadOrderFormID(Result, GetMastersUpdated);

  mrLoadOrderFormID := Result;
end;

procedure TwbMainRecord.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
var
  SubRecord   : IwbSubRecord;
  NotRelevant : Boolean;
begin
  if Supports(aElement, IwbSubRecord, SubRecord) then begin
    NotRelevant := False;
    if SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrEditorID] then begin
      mrEditorID := mrDef.GetEditorID(SubRecord);
      Exclude(mrStates, mrsEditorIDFromCache);
    end else if SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrFullName] then begin
      mrFullName := SubRecord.EditValue;
      Exclude(mrStates, mrsFullNameFromCache);
    end else if SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrBaseRecord] then
      Exclude(mrStates, mrsBaseRecordChecked)
    else if (SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrGridCell]) and (SubRecord.Container.Equals(Self)) then begin
      if mrDef.GetGridCell(SubRecord, mrGridCell) then
        Include(mrStates, mrsHasGridCell)
      else
        Exclude(mrStates, mrsHasGridCell);
      Include(mrStates, mrsGridCellChecked);
    end else
      NotRelevant := True;
    if not NotRelevant then begin
      (GetFile as IwbFileInternal).IncGeneration;
      mrName := '';
      mrShortName := '';
      mrDisplayName := '';
    end;
  end;
  inherited;
  UpdateKeys;
  if not (mrsNoUpdateRefs in mrStates) then
    UpdateRefs;
end;

function TwbMainRecord.EnsureChildGroup: IwbGroupRecord;
const
  WRLD = $444C5257;
  CELL = $4C4C4543;
  DIAL = $4C414944;
var
  SearchForGroup  : Integer;
  ContainingGroup : IwbGroupRecord;
begin
  Result := GetChildGroup;
  if not Assigned(Result) then begin
    case Cardinal(GetSignature) of
      WRLD: SearchForGroup := 1;
      CELL: SearchForGroup := 6;
      DIAL: SearchForGroup := 7;
    else
      if wbVWDAsQuestChildren and (GetSignature = 'QUST') then
        SearchForGroup := 10
      else
        SearchForGroup := 0;
    end;
    if (SearchForGroup > 0) and Supports(GetContainer, IwbGroupRecord, ContainingGroup) then begin
      mrGroup := ContainingGroup.FindChildGroup(SearchForGroup, Self);
      if not Assigned(mrGroup) and ContainingGroup.IsElementEditable(nil) then begin
        mrGroup := TwbGroupRecord.Create(ContainingGroup, SearchForGroup, Self);
        Result := mrGroup;
      end;
    end;
  end;
  Assert(Assigned(Result));
end;

function TwbMainRecord.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
begin
  if wbIsStarfield and wbStarfieldIsABugInfestedHellhole then
    if (aIndex = wbAssignThis) and (GetSignature = 'PKIN') then begin
      var lMainRecord: IwbMainRecord;
      if Supports(aElement, IwbMainRecord, lMainRecord) then begin
        if lMainRecord.LoadOrderFormID = GetLoadOrderFormID then
          Exit(False);
      end else
        Exit(False);
    end;

  Result := False;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;
    if dfInternalEditOnly in mrDef.DefFlags then
      Exit;
  end;

  if GetIsDeleted then
    if aIndex <> wbAssignThis then begin
      var lHasSignature: IwbHasSignature;
      if (wbGameMode >= gmFO4) and
         Supports(aElement, IwbHasSignature, lHasSignature) and
         Assigned(mrDef) and
         (mrDef.KnownSubRecordSignatures[ksrBaseRecord] = lHasSignature.Signature)
      then begin
        //allow NAME in FO4, SSE, and newer for deleted records
      end else
        Exit;
    end;

  if GetIsPartialForm then
    if aIndex <> wbAssignThis then begin
      var lHasSignature: IwbHasSignature;
      if Supports(aElement, IwbHasSignature, lHasSignature) and
         Assigned(mrDef) and
         (mrDef.KnownSubRecordSignatures[ksrEditorID] = lHasSignature.Signature)
      then begin
        //allow EDID for partial forms
      end else
        Exit;
    end;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow then
    if GetDontShow then
      Exit;

  if not Assigned(aElement) then begin
    Result := (aIndex >= 0) and (aIndex < mrDef.MemberCount) and (GetElementBySortOrder(aIndex + GetAdditionalElementCount) = nil);
    if Result and aCheckDontShow then
      Result := not mrDef.Members[aIndex].DontShow[Self];
    if Result and not wbIsInternalEdit then
      if dfInternalEditOnly in mrDef.Members[aIndex].DefFlags then
        Result := False;
    Exit;
  end;

  if Assigned(mrDef) then begin
    if aIndex = wbAssignThis then
      Result := mrDef.Equals(aElement.Def)
    else begin
      Result := (aIndex >= 0) and (aIndex < mrDef.MemberCount) and
        (
          mrDef.Members[aIndex].CanAssign(Self, wbAssignThis, aElement.Def) or
          mrDef.Members[aIndex].CanAssign(Self, wbAssignAdd, aElement.Def)
        );
      if Result and aCheckDontShow then
        Result := not mrDef.Members[aIndex].DontShow[Self];
    end;
  end else
    Result := False;
end;

function TwbMainRecord.CanContainFormIDs: Boolean;
begin
  Result := True; {There is a FormID in the header}
end;

function TwbMainRecord.CanElementReset: Boolean;
begin
  Result := cntElementRefs < 1;
end;

function TwbMainRecord.CheckChildOfCell: Boolean;
var
  Sig    : TwbSignature;
  Group1 : IwbGroupRecord;
  Group2 : IwbGroupRecord;
begin
  Sig := GetSignature;
  Result :=
    (Sig = 'REFR') or
    (Sig = 'PMIS') or
    (Sig = 'PGRE') or
    (Sig = 'ACRE') or
    (Sig = 'ACHR') or
    (Sig = 'PARW') or {>>> Skyrim <<<}
    (Sig = 'PBEA') or {>>> Skyrim <<<}
    (Sig = 'PFLA') or {>>> Skyrim <<<}
    (Sig = 'PCON') or {>>> Skyrim <<<}
    (Sig = 'PBAR') or {>>> Skyrim <<<}
    (Sig = 'PHZD');   {>>> Skyrim <<<}
  if not Result then
    Exit;
  if not Supports(GetContainer, IwbGroupRecord, Group1) then
    raise Exception.Create(GetName + ' is not contained in a group.');
  if not (Group1.GroupType in [8, 9, 10]) then
    raise Exception.Create(GetName + ' is not contained in a group of type "Cell Persistent Childen", "Cell Temporary Children" or "Cell Visible Distant Children"');
  if not Supports(Group1.Container, IwbGroupRecord, Group2) then
    raise Exception.Create(Group1.GetName + ' is not contained in a group.');
  if not (Group2.GroupType in [6]) then
    raise Exception.Create(Group1.GetName + ' is not contained in a group of type "Cell Children"');
end;

procedure TwbMainRecord.ClearForRelease;
begin
  mrMaster := nil;
  mrOverrides := nil;
  mrReferencedBy := nil;
  mrReferencedByCount := 0;
  mrReferencedBySize := 0;
  mrGroup := nil;
  ReleaseElements;
end;

procedure TwbMainRecord.CollapseStorage(aKAR: PwbKeepAliveRoot; aForce: Boolean);
var
  Stream      : TMemoryStream;
  KAR         : IwbKeepAliveRoot;
  WasInternal : Boolean;
begin
  if (esModified in eStates) then begin
    WasInternal := (esInternalModified in eStates);
    KAR := wbCreateKeepAliveRoot;
    UpdateKeys;
    UpdateRefs;
    PrepareSave;
    UpdateRefs;
    UpdateKeys;
    Stream := TMemoryStream.Create;
    try
      WriteToStream(Stream, rmYes);
      KAR := nil;
      if Assigned(aKAR) then
        aKAR^ := nil;

      if WasInternal then
        WasInternal := wbBeginInternalEdit(True);
      try
        if aForce or ResetChildrenLeafFirst then begin
          DoReset(True);
          ReleaseElements;

          if mrsBasePtrAllocated in mrStates then
            FreeMem(dcBasePtr);
          GetMem(dcBasePtr, Stream.Size);
          Include(mrStates, mrsBasePtrAllocated);

          Move(Stream.Memory^, dcBasePtr^, Stream.Size);

          dcEndPtr := PByte(dcBasePtr) + Stream.Size;

          Exclude(dcFlags, dcfStorageInvalid);
          mrDataStorage := nil;
          dcDataStorage := nil;
          dcDataBasePtr := nil;
          dcDataEndPtr := nil;

          InitDataPtr;
        end;

        SetModified(True);
        InvalidateParentStorage;
      finally
        if WasInternal then
          wbEndInternalEdit;
      end;
    finally
      Stream.Free;
    end;
  end;
end;

function TwbMainRecord.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef : IwbContainerElementRef;
  KAR: IwbKeepAliveRoot;
begin
  KAR := wbCreateKeepAliveRoot;
  SelfRef := Self as IwbContainerElementRef;

  mrBaseRecordID := TwbFormID.Null;
  Exclude(mrStates, mrsBaseRecordChecked);

  Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);
  if {Result and} (csRefsBuild in cntStates) then // if you changed to an already existing FormID
    BuildRef;
end;

procedure TwbMainRecord.ContainerChanged;
var
  ContainedIn: IwbContainedIn;
begin
  mrInvalidateNameCache;
  if csInit in cntStates then
    if Supports(GetElementBySortOrder(-2 + GetAdditionalElementCount), IwbContainedIn, ContainedIn) then
      ContainedIn.ContainerChanged;
end;

function TwbMainRecord.ContentEquals(const aMainRecord: IwbMainRecord): Boolean;
var
  MRI : IwbMainRecordInternal;
begin
  Result := False;
  if esModified in eStates then
    Exit;
  if Supports(aMainRecord, IwbMainRecordInternal, MRI) then
    Result := MRI.IsSameData(dcBasePtr, dcEndPtr);
end;

constructor TwbMainRecord.Create(const aContainer: IwbContainer; const aSignature: TwbSignature; aFormID: TwbFormID);
var
  lContainer   : IwbContainer;
  BasePtr      : PwbMainRecordStruct;
  IsInterior   : Boolean;

  procedure Inner;
  var
    i            : Integer;
    Group        : IwbGroupRecordInternal;
    Group2       : IwbGroupRecordInternal;
    ContainerRef : IwbContainerElementRef;
    s            : string;
    Block        : Cardinal;
    SubBlock     : Cardinal;
  begin
    IsInterior := False;
    lContainer := aContainer;
    New(BasePtr);
    Include(mrStates, mrsBasePtrAllocated);
    BasePtr.mrsSignature := aSignature;
    BasePtr.mrsDataSize := 0;
    BasePtr.mrsFlags._Flags := 0;
    if wbGameMode >= gmTES4 then
      BasePtr.mrsFormID^ := aFormID;
    BasePtr.mrsVCS1^ := DefaultVCS1;

    if wbGameMode >= gmFO3 then begin
      case wbGameMode of
        gmSF1                        : BasePtr.mrsVersion^ := 576;
        gmFO76                       : BasePtr.mrsVersion^ := 201;
        gmFO4, gmFO4VR               : BasePtr.mrsVersion^ := 131;
        gmSSE, gmTES5VR, gmEnderalSE : BasePtr.mrsVersion^ := 44;
        gmTES5, gmEnderal            : BasePtr.mrsVersion^ := 43;
        gmFNV                        : BasePtr.mrsVersion^ := 15;
        gmFO3                        : BasePtr.mrsVersion^ := 15;
        else                           BasePtr.mrsVersion^ := 15;
      end;
      BasePtr.mrsVCS2^ := DefaultVCS2;
    end;

    Group := nil;
    if Supports(lContainer, IwbGroupRecordInternal, Group) then
      if Group.GroupType = 8 then
        BasePtr.mrsFlags.SetPersistent(True)
      else if (Group.GroupType = 10) and not (wbVWDAsQuestChildren
                 and Supports(Group.Container, IwbGroupRecord, Group2) and (TwbSignature(Group2.GroupLabel) = 'QUST')) then
        BasePtr.mrsFlags.SetVisibleWhenDistant(True);

    if Assigned(Group) then
      if aSignature = 'CELL' then begin
        if Group.GroupType = 3 then
          Supports(Group.Container, IwbGroupRecordInternal, Group);
        if Assigned(Group) then begin
          if Group.GroupType = 2 then
            Supports(Group.Container, IwbGroupRecordInternal, Group);
          if Assigned(Group) then begin
            if (Group.GroupType = 0) and (TwbSignature(Group.GroupLabel) = 'CELL') then begin
              s := '00' + IntToStr(aFormID.ObjectID);
              Block := StrToInt(s[Length(s)]);
              SubBlock := StrToInt(s[Pred(Length(s))]);

              ContainerRef := Group as IwbContainerElementRef;
              Group := nil;
              for i := 0 to Pred(ContainerRef.ElementCount) do
                if Supports(ContainerRef.Elements[i], IwbGroupRecord, Group) then
                  if (Group.GroupType = 2) and (Group.GroupLabel = Block) then
                    Break
                  else
                    Group := nil;
              if not Assigned(Group) then
                Group := TwbGroupRecord.Create(ContainerRef as IwbContainer, 2, Block);

              ContainerRef := Group as IwbContainerElementRef;
              Group := nil;
              for i := 0 to Pred(ContainerRef.ElementCount) do
                if Supports(ContainerRef.Elements[i], IwbGroupRecord, Group) then
                  if (Group.GroupType = 3) and (Group.GroupLabel = SubBlock) then
                    Break
                  else
                    Group := nil;
              if not Assigned(Group) then
                Group := TwbGroupRecord.Create(ContainerRef as IwbContainer, 3, SubBlock);

              lContainer := Group as IwbContainer;
              IsInterior := True;
            end;
          end;
        end;
      end;
  end;

  procedure SortGroup;
  var
    Group        : IwbGroupRecordInternal;
  begin
    if Supports(lContainer, IwbGroupRecordInternal, Group) then
      Group.Sort;
  end;

begin
  Inner;

  var EndPtr: Pointer := nil;
  Create(lContainer, Pointer(BasePtr), EndPtr, nil);
  BeginUpdate;
  try
    wbCodeBlock(procedure
    var
      SelfRef      : IwbContainerElementRef;
      i            : Integer;
      ContainerRef : IwbContainerElementRef;
      Group        : IwbGroupRecordInternal;
      Cell         : IwbMainRecord;
      GridCell     : TwbGridCell;
    begin
      Assert(Assigned(mrDef));
      SelfRef := Self as IwbContainerElementRef;
      DoInit(True);
      SetModified(True);
      InvalidateStorage;
      for i := 0 to Pred(mrDef.MemberCount) do
        if mrDef.Members[i].Required then
          Assign(i, nil, False);

      if IsInterior then
        if Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, ContainerRef) then
          ContainerRef.EditValue := '1';

      if mrDef.IsReference then
        if Supports(lContainer, IwbGroupRecordInternal, Group) then begin
          Cell := Group.ChildrenOf;
          if Assigned(Cell) and not Cell.IsPersistent and Cell.GetGridCell(GridCell) then
            SetPosition(wbGridCellToCenterPosition(GridCell));
        end;
    end);

    CollapseStorage(nil, True);
  finally
    EndUpdate;
  end;

  if Assigned(lContainer) and (lContainer.ElementType = etGroupRecord) then
    SortGroup;
end;

constructor TwbMainRecord.Create(const aContainer: IwbContainer; var aBasePtr: Pointer; var aEndPtr: Pointer; const aPrevMainRecord : IwbMainRecord);
var
  _File: IwbFileInternal;
begin
  inherited Create(aContainer, aBasePtr, aEndPtr, aPrevMainRecord);
  try
    var lFixedFormID := GetFixedFormID;
    _File := GetFile as IwbFileInternal;
    if Assigned(aPrevMainRecord) and (aPrevMainRecord.FixedFormID = lFixedFormID) then begin
      var lFileName := '<unknown file>';
      if Assigned(_File) then
        lFileName := _File.Name;
      raise EwbSkipLoad.Create('Duplicate FormID [' + lFixedFormID.ToString(True) + '] in file ' + lFileName);
    end;
    if Assigned(_File) then begin
      _File.AddMainRecord(Self);
      if fsIsDeltaPatch in _File.FileStates then
        Include(mrStates, mrsNoUpdateRefs);
    end;
  except
    if Assigned(aContainer) then
      aContainer.RemoveElement(Self);
    raise;
  end;
end;

procedure TwbMainRecord.DecompressIfNeeded;
var
  UncompressedLength: Cardinal;
  //s                   : string;
begin
  InitDataPtr; // reset...

  if mrStruct.mrsFlags.IsCompressed then try
    UncompressedLength := PCardinal(dcDataBasePtr)^;
    if UncompressedLength > 0 then begin
      SetLength(mrDataStorage, UncompressedLength );

      DecompressToUserBuf(
        PByte(dcDataBasePtr) + SizeOf(Cardinal),
        mrStruct.mrsDataSize - SizeOf(Cardinal),
        @mrDataStorage[0],
        UncompressedLength
      );

      dcDataBasePtr := @mrDataStorage[0];
      dcDataEndPtr := PByte(dcDataBasePtr) + UncompressedLength;
    end else begin
      mrDataStorage := nil;
      dcDataBasePtr := @EmptyPtr;
      dcDataEndPtr := @EmptyPtr;
    end;
  except
    on E: Exception do begin
      wbProgress('<Error decompressing [%s:%s]: [%s] %s>', [string(GetSignature), GetFormID.ToString, E.ClassName, E.Message]);
      dcDataBasePtr := nil;
      dcDataEndPtr := nil;
    end;
  end;

  {
  var lPath := wbDataPath + 'Dump\' + GetFile.FileName + '\' + Self.GetSignature + '\';
  ForceDirectories(lPath);
  var lFileName := lPath + GetLoadOrderFormID.ToString;
  if not FileExists(lFileName) then
    with TFileStream.Create(lFileName, fmCreate) do try
      WriteBuffer(dcDataBasePtr^, NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr) );
    finally
      Free;
    end;
  }
end;

procedure TwbMainRecord.Delete;
var
  SelfRef     : IwbContainerElementRef;
  BasePtr     : Pointer;
  GroupRecord : IwbGroupRecord;
begin
  SelfRef := Self;
  DoInit(False);

  BeginUpdate;
  try

    var lBaseRecord := GetBaseRecord;

    SetModified(True);
    InvalidateStorage;
    ReleaseElements;

    MakeHeaderWriteable;
    GetFlagsPtr.SetDeleted(True);
    if Assigned(mrDef) and mrDef.CanBePartial then
      GetFlagsPtr.SetPartialForm(False);
    GetFlagsPtr.SetCompressed(False);

    if Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
      if wbCreateContainedIn and (GroupRecord.GroupType in [1, 4..10]) then
        with TwbContainedInElement.Create(Self) do begin
          _AddRef; _Release;
        end;
    GroupRecord := nil;

    BasePtr := dcBasePtr;
    with TwbRecordHeaderStruct.Create(Self, BasePtr, PByte(BasePtr) + wbSizeOfMainRecordStruct, mrDef.RecordHeaderStruct, '') do begin
      Include(dcFlags, dcfDontSave);
      SetSortOrder(-1);
      SetMemoryOrder(Low(Integer));
      _AddRef; _Release;
    end;

    if (wbGameMode >= gmFO4) and Assigned(lBaseRecord) then begin
      var lMemberIndex := mrDef.KnownSubRecordMemberIndex[ksrBaseRecord];
      if lMemberIndex >= 0 then begin
        var lBaseRecordElement := Assign(lMemberIndex, nil, False);
        if Assigned(lBaseRecordElement) then
          lBaseRecordElement.LinksTo := lBaseRecord;
      end;
    end;

    CollapseStorage(nil, True);
  finally
    EndUpdate;
  end;
end;

procedure TwbMainRecord.DeleteInto(const aFile: IwbFile);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(CopyInto(aFile, False, False, '', '', '', ''), IwbMainRecord, MainRecord) then
    MainRecord.Delete;
end;

destructor TwbMainRecord.Destroy;
begin
  if mrsBasePtrAllocated in mrStates then
    FreeMem(dcBasePtr);
  inherited;
end;

procedure TwbMainRecord.Init;
var
  FoundError           : Boolean;
  CurrentPtr           : Pointer;
  CurrentDefPos        : Integer;
  CurrentRecPos        : Integer;
  Element              : IwbElement;
  CurrentRec           : IwbSubRecord;
  CurrentDef           : IwbRecordMemberDef;
  SubRecordArray       : IwbSubRecordArrayInternal;
  Dummy                : Integer;
  LastElementForMember : array of IwbElement;
  GroupRecord          : IwbGroupRecord;
  GroupRecordInternal  : IwbGroupRecordInternal;
  RequiredRecords      : set of byte;
  PresentRecords       : set of byte;
  i                    : Integer;
  {$IFDEF DBGSUBREC}
  lSubRecords: TArray<IwbSubRecord>;
  lSubRecordCount: Integer;
  {$ENDIF}

  RecordHeaderStruct   : IwbStructDef;

  IsTES3CELL           : Boolean;
  IsTES3REFR           : Boolean;
  FRMRCount            : Integer;

  {$IFDEF DBGSUBREC}
  function lGetSubRecordsString: string;
  begin
    Result := '';
    for var lSubRecord in lSubRecords do begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + lSubRecord.DisplaySignature;
    end;
  end;
  {$ENDIF}

begin
  RequiredRecords := [];
  PresentRecords := [];

  inherited;

  if recSkipped then
    Exit;

  if Length(cntElements) > 0 then
    Exit;

  DecompressIfNeeded;

  FoundError := False;

  if not (mrsQuickInit in mrStates) then begin
    if Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
      if wbCreateContainedIn and (GroupRecord.GroupType in [1, 4..10]) then
        with TwbContainedInElement.Create(Self) do begin
          _AddRef; _Release;
        end;
    GroupRecord := nil;

    RecordHeaderStruct := nil;
    if Assigned(mrDef) then
      RecordHeaderStruct := mrDef.RecordHeaderStruct as IwbStructDef;
    if not Assigned(RecordHeaderStruct) then
      RecordHeaderStruct := wbMainRecordHeader as IwbStructDef;

    CurrentPtr := dcBasePtr;
    with TwbRecordHeaderStruct.Create(Self, CurrentPtr, PByte(CurrentPtr) + wbSizeOfMainRecordStruct, RecordHeaderStruct, '') do begin
      Include(dcFlags, dcfDontSave);
      SetSortOrder(-1);
      SetMemoryOrder(Low(Integer));
      _AddRef; _Release;
    end;
  end;

  IsTES3CELL := (wbGameMode = gmTES3) and (GetSignature = 'CELL');
  IsTES3REFR := (wbGameMode = gmTES3) and (GetSignature = 'REFR');
  FRMRCount := 0;

  {$IFDEF DBGSUBREC}
  lSubRecordCount := 0;
  SetLength(lSubRecords, 32);
  {$ENDIF}

  CurrentPtr := GetDataBasePtr;
  while NativeUInt(CurrentPtr) < NativeUInt(dcDataEndPtr) do begin
    if (IsTES3Cell or (FRMRCount > 0)) and ((PwbSignature(CurrentPtr)^ = 'FRMR') or (PwbSignature(CurrentPtr)^ = 'NAM0')) then begin
      if dcEndPtr = dcDataEndPtr then
        dcEndPtr := CurrentPtr;
      dcDataEndPtr := CurrentPtr;
      Break;
    end else begin
      if IsTES3REFR and (PwbSignature(CurrentPtr)^ = 'FRMR') then
        Inc(FRMRCount);
      Element := TwbRecord.CreateForPtr(CurrentPtr, dcDataEndPtr, Self, nil);
      if Supports(Element, IwbSubRecord, CurrentRec) then begin
        var lSignature := CurrentRec.Signature;
        if wbIgnoreRecords.Find(lSignature, Dummy) or mrDef.ShouldIgnore(lSignature) or SubRecordToSkip.Find(lSignature, Dummy) then
          CurrentRec.Skipped := True;
        {$IFDEF DBGSUBREC}
        if lSubRecordCount >= Length(lSubRecords) then
          SetLength(lSubRecords, 2 * lSubRecordCount); 
        lSubRecords[lSubRecordCount] := CurrentRec;
        Inc(lSubRecordCount);
        {$ENDIF}
      end;
    end;
  end;
  Element := nil;

  if not Assigned(mrDef) then
    Exit;

  {$IFDEF DBGSUBREC}
  SetLength(lSubRecords, lSubRecordCount);
  {$ENDIF}

  SetLength(LastElementForMember, mrDef.MemberCount);

  if not Assigned(cntElements) then
    Exit;

  CurrentDefPos := 0;
  CurrentRecPos := 0;
  Exclude(mrStates, mrsGridCellChecked);

  while (CurrentRecPos < Length(cntElements)) do begin
    if cntElements[CurrentRecPos].ElementType <> etSubRecord then begin
      Inc(CurrentRecPos);
      Continue;
    end;
    CurrentRec := cntElements[CurrentRecPos] as IwbSubRecord;
    if CurrentRec.Skipped then begin
      Inc(CurrentRecPos);
      Continue;
    end;

    if mrDef.AllowUnordered then begin
      CurrentDefPos := mrDef.GetMemberIndexFor(Self, CurrentRec.Signature, CurrentRec);
      if CurrentDefPos < 0 then begin
        if wbHasProgressCallback then
          wbProgressCallback('Error: record ' + String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.DisplaySignature) + ' ' + IntToHex(Int64(Cardinal(CurrentRec.Signature)), 8) );
        FoundError := True;
        Inc(CurrentRecPos);
        Continue;
      end;
      CurrentDef := mrDef.Members[CurrentDefPos];
    end else begin
      if not mrDef.ContainsMemberFor(Self, CurrentRec.Signature, CurrentRec) then begin
        if wbHasProgressCallback then
          wbProgressCallback('Error: record ' + String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.DisplaySignature) + ' ' + IntToHex(Int64(Cardinal(CurrentRec.Signature)), 8) );
        FoundError := True;
        Inc(CurrentRecPos);
        Continue;
      end;

      if (CurrentDefPos < mrDef.MemberCount) then begin
        CurrentDef := mrDef.Members[CurrentDefPos];
        if not CurrentDef.CanHandle(Self, CurrentRec.Signature, CurrentRec) then begin
          Inc(CurrentDefPos);
          Continue;
        end;
      end else begin
        if wbHasProgressCallback then
          wbProgressCallback('Error: record ' + String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.DisplaySignature) );
        FoundError := True;
        Inc(CurrentRecPos);
        Continue;
      end;
    end;

    if CurrentDefPos > mrDef.QuickInitLimit then begin
      Include(mrStates, mrsQuickInitDone);
      Include(mrStates, mrsGridCellChecked);
      if mrsQuickInit in mrStates then begin

        if FoundError then
          if wbHasProgressCallback then begin
            wbProgressCallback('Errors were found in: ' + GetName);
            {$IFDEF DBGSUBREC}
            wbProgressCallback('Contained subrecords: ' + lGetSubRecordsString());
            {$ENDIF}
          end;

        Exit;
      end;
    end;

    if CurrentDef.DefType = dtSubRecordUnion then begin
      CurrentDef := (CurrentDef as IwbRecordDef).GetMemberFor(Self, CurrentRec.Signature, CurrentRec);
      Assert(Assigned(CurrentDef));
    end;

    case CurrentDef.DefType of
      dtSubRecord       : begin
        (CurrentRec as IwbSubRecordInternal).SetDef(CurrentDef as IwbSubRecordDef);
        if CurrentRec.Signature = mrDef.KnownSubRecordSignatures[ksrEditorID] then
          mrEditorID := mrDef.GetEditorID(CurrentRec)
        else if CurrentRec.Signature = mrDef.KnownSubRecordSignatures[ksrFullName] then
          mrFullName := CurrentRec.EditValue
        else if (CurrentRec.Signature = mrDef.KnownSubRecordSignatures[ksrBaseRecord]) and mrDef.IsReference then begin
          mrBaseRecordID := TwbFormID.FromCardinal(CurrentRec.NativeValue);
          Include(mrStates, mrsBaseRecordChecked);
        end else if not (mrsGridCellChecked in mrStates) and (CurrentRec.Signature = mrDef.KnownSubRecordSignatures[ksrGridCell]) then begin
          if mrDef.GetGridCell(CurrentRec as IwbSubRecord, mrGridCell) then
            Include(mrStates, mrsHasGridCell)
          else
            Exclude(mrStates, mrsHasGridCell);
          Include(mrStates, mrsGridCellChecked);
        end;
      end;
      dtSubRecordArray  : begin
        if Supports(LastElementForMember[CurrentDefPos], IwbSubRecordArrayInternal, SubRecordArray) then begin
          SubRecordArray.DoProcess(Self, CurrentRecPos);
          Continue;
        end else
          InsertElement(CurrentRecPos, TwbSubRecordArray.Create(nil, Self, CurrentRecPos, CurrentDef as IwbSubRecordArrayDef));
      end;
      dtSubRecordStruct :
        InsertElement(CurrentRecPos, TwbSubRecordStruct.Create(nil, Self, CurrentRecPos, CurrentDef as IwbSubRecordStructDef));
    else
      raise Exception.CreateFmt('Unexpected def type for SubRecord %s in %s', [String(CurrentRec.Signature), String(GetSignature)]);
    end;

    (cntElements[CurrentRecPos] as IwbElementInternal).SetSortOrder(CurrentDefPos);
    (cntElements[CurrentRecPos] as IwbElementInternal).SetMemoryOrder(CurrentDefPos);
    Include(PresentRecords, CurrentDefPos);
    LastElementForMember[CurrentDefPos] := cntElements[CurrentRecPos];

    Inc(CurrentRecPos);
    Inc(CurrentDefPos);
  end;

  while CurrentRecPos < Length(cntElements) do begin
    if cntElements[CurrentRecPos].ElementType <> etSubRecord then begin
      Inc(CurrentRecPos);
      Continue;
    end;
    CurrentRec := cntElements[CurrentRecPos] as IwbSubRecord;
    if CurrentRec.Skipped then begin
      Inc(CurrentRecPos);
      Continue;
    end;

    if wbHasProgressCallback then
      wbProgressCallback('Error: record ' + String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) );
    FoundError := True;

    Inc(CurrentRecPos);
  end;

//  if GetSignature = 'DIAL' then
//    FoundError := True;

  if FoundError then
    if wbHasProgressCallback then begin
      wbProgressCallback('Errors were found in: ' + GetName);
{$IFDEF DBGSUBREC}
      wbProgressCallback('Contained subrecords: ' + lGetSubRecordsString());
{$ENDIF}
    end;

  if wbSortSubRecords and (mrDef.AllowUnordered or (esModified in eStates)) and (Length(cntElements) > 1) then
    wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSubRecords);

  if wbRemoveOffsetData and (GetSignature = 'WRLD') then begin
    if Supports(GetRecordBySignature('OFST'), IwbSubRecord, CurrentRec) then begin
      if wbBeginInternalEdit(True) then try
        RemoveElement('OFST');
      finally
        wbEndInternalEdit;
      end else
        RemoveElement(CurrentRec, True);
      Include(mrStates, mrsOFSTRemoved);
    end;
  end;

  mrDef.AfterLoad(Self);

  if not (mrStruct.mrsFlags.IsDeleted or GetIsPartialForm) then begin
    for i := 0 to Pred(mrDef.MemberCount) do
      if mrDef.Members[i].Required then
        Include(RequiredRecords, i);

    RequiredRecords := RequiredRecords - PresentRecords;
    if RequiredRecords <> [] then begin
      if wbBeginInternalEdit then try
        for i := 0 to Pred(mrDef.MemberCount) do
          if i in RequiredRecords then begin
            if wbMoreInfoForRequired  then
              wbProgressCallback(' [' + mrFixedFormID.ToString(True) + '] Adding missing record: ' + mrDef.Members[i].GetName);
            Assign(i, nil, False);
          end;
      finally
        wbEndInternalEdit;
      end;
    end;
  end;

  if wbReportMode {and mrDef.AllowUnordered} then
    if not wbSubRecordErrorsOnly or FoundError then begin
      var s := GetSignature + ' -> ' + lGetSubRecordsString();
      CurrentRecPos := SubRecordOrderList.Add(s);
      SubRecordOrderList.Objects[CurrentRecPos] := Pointer(Succ(Integer(SubRecordOrderList.Objects[CurrentRecPos])));
    end;

{$IFDEF DBGSUBREC}
//  if GetLoadOrderFormID.ObjectID = $175B9 then
//    wbProgressCallback('[' + GetFile.Name + ': '+ GetLoadOrderFormID.ToString(True) + '] Contained subrecords: ' + lGetSubRecordsString());
{$ENDIF}


{
  if GetSignature = 'SCPT' then begin
//    s :=  (GetRecordBySignature('DATA') as IwbContainer).Elements[0].EditValue + s;
    CurrentRecPos := SubRecordOrderList.Add(s);
    SubRecordOrderList.Objects[CurrentRecPos] := Pointer(Succ(Integer(SubRecordOrderList.Objects[CurrentRecPos])));
  end;
}

  Include(cntStates, csInitOnce);

  if {$IFDEF USE_PARALLEL_BUILD_REFS}not wbBuildingRefsParallel and{$ENDIF} wbCanSortINFO and wbSortINFO then
    if not (GetIsDeleted or GetIsPartialForm) and wbBeginInternalEdit(False) then try
      if wbFillPNAM and (GetSignature = 'INFO') and not Assigned(GetRecordBySignature('PNAM')) then begin
        if Supports(IwbContainer(eContainer), IwbGroupRecordInternal, GroupRecordInternal) then
          GroupRecordInternal.Sort(True);
      end else if GetSignature = 'DIAL' then
        if (wbFillINOM and not Assigned(GetRecordBySignature('INOM'))) or (wbFillINOA and not Assigned(GetRecordBySignature('INOA'))) then begin
          if Supports(GetChildGroup, IwbGroupRecordInternal, GroupRecordInternal) then
            GroupRecordInternal.Sort(True);
        end;
    finally
      wbEndInternalEdit;
    end;
end;

function TwbMainRecord.FindReferencedBy(const aMainRecord: IwbMainRecord; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;

{$IFDEF USE_PARALLEL_BUILD_REFS}
  //Assert(not wbBuildingRefsParallel);
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}
  L := 0;
  H := Pred(mrReferencedByCount);
  while L <= H do begin
    I := (L + H) shr 1;

    C := TwbFormID.Compare(mrReferencedBy[I].LoadOrderFormID , aMainRecord.LoadOrderFormID);
    if C = 0 then
      C := CmpI32(mrReferencedBy[I]._File.LoadOrder, aMainRecord._File.LoadOrder);

    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

procedure TwbMainRecord.FindUsedMasters(aMasters: PwbUsedMasters);
var
  SelfRef : IwbContainerElementRef;
  KAR     : IwbKeepAliveRoot;

  lFile: IwbFile;

  lCheckedMasterZero      : Boolean;
  lMasterZeroIsGameMaster : Boolean;
  lAllowHardcodedRangeUse : Boolean;

  function MasterZeroIsGameMaster: Boolean;
  begin
    if not lCheckedMasterZero then begin
      lCheckedMasterZero := True;
      if not Assigned(lFile) then
        lFile := GetFile;
      if Assigned(lFile) then begin
        lAllowHardcodedRangeUse := lFile.GetAllowHardcodedRangeUse;
        if lFile.MasterCount[True] > 0 then begin
          var lMaster := lFile.Masters[0, True];
          if Assigned(lMaster) and (lMaster.FileStates * [fsIsGameMaster, fsIsHardcoded] <> []) then
            lMasterZeroIsGameMaster := True;
        end;
      end;
    end;
    Result := lMasterZeroIsGameMaster;
  end;

  procedure MarkMaster(aFormID: TwbFormID);
  begin
    if aFormID.IsNull then
      Exit;

    if aFormID.ObjectID < $800 then begin
      MasterZeroIsGameMaster;
      if not lAllowHardcodedRangeUse then
        aFormID.FileID := TwbFileID.Null;
    end;

    if aFormID.IsHardcoded then begin
      if lMasterZeroIsGameMaster then
        aMasters[0] := True;
      Exit;
    end;

    if not Assigned(lFile) then
      lFile := GetFile;

    var lMasterIndex := lFile.GetMasterIndexForFileID(aFormID.FileID, False);
    if lMasterIndex >= 0 then
      aMasters[lMasterIndex] := True;
  end;

begin
  lCheckedMasterZero      := False;
  lMasterZeroIsGameMaster := False;

  KAR := wbCreateKeepAliveRoot;
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  var lFormID := GetFixedFormID;
  MarkMaster(lFormID);

  if (csRefsBuild in cntStates) and (cntRefsBuildAt >= eGeneration) then begin

    for var lReferenceIdx := High(mrReferences) downto Low(mrReferences) do begin
      lFormID := mrReferences[lReferenceIdx];
      MarkMaster(lFormID);
    end;

  end else
    inherited;
end;

function TwbMainRecord.GetAdditionalElementCount: Integer;
var
  GroupRecord: IwbGroupRecord;
begin
  Result := 1;
  if wbCreateContainedIn and Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
    if GroupRecord.GroupType in [1, 4..10] then
      Inc(Result);
end;

function TwbMainRecord.GetAddList: TDynStrings;
var
  i, j        : Integer;
  RecordDef   : PwbMainRecordDef;
  GroupRecord : IwbGroupRecord;
begin
  Result := nil;

  if GetIsDeleted then
    Exit;

  if GetSignature = 'DIAL' then begin
    Result.Add('INFO');
  end else if GetSignature = 'CELL' then begin
    Result.Add('ACHR');
    Result.Add('ACRE');
    Result.Add('REFR');
    Result.Add('PGRE');
    Result.Add('PMIS');
    Result.Add('PARW');
    Result.Add('PBEA');
    Result.Add('PFLA');
    Result.Add('PCON');
    Result.Add('PBAR');
    Result.Add('PHZD');
    if not GetIsPersistent then begin
      if Supports(GetContainer, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 5) then
        Result.Add('LAND');
      Result.Add('PGRD');
      Result.Add('NAVM');
    end;
  end else if GetSignature = 'WRLD' then begin
    Result.Add('CELL');
    Result.Add('ROAD');
  end else if wbVWDAsQuestChildren and (GetSignature = 'QUST') then begin
    SetLength(Result, 3);
    Result[0] := 'DIAL';
    Result[1] := 'DLBR';
    Result[2] := 'SCEN';
  end;

  j := 0;
  for i := Low(Result) to High(Result) do
    if wbFindRecordDef(AnsiString(Result[i]), RecordDef) then begin
      Result[j] := Result[i] + ' - ' + RecordDef.Name;
      Inc(j);
    end;
  SetLength(Result, j);
end;

function TwbMainRecord.GetAllVisibleForFile(const aFile: IwbFile): TDynMainRecords;
var
  MainRecord : IwbMainRecord;
  i          : Integer;
  FormID     : TwbFormID;
  _File      : IwbFile;
begin
  FormID := GetLoadOrderFormID;
  Result := nil;

  MainRecord := aFile.ContainedRecordByLoadOrderFormID[FormID, True];
  if Assigned(MainRecord) then
    Result.Add(MainRecord);

  for i := Pred(aFile.MasterCount[True]) downto 0 do begin
    _File := aFile.Masters[i, True];
    MainRecord := _File.ContainedRecordByLoadOrderFormID[FormID, True];
    if Assigned(MainRecord) then
      Result.Add(MainRecord);
  end;
end;

function TwbMainRecord.GetBaseRecord: IwbMainRecord;
var
  _File  : IwbFile;

  SelfRef: IwbContainerElementRef;
  NameRec: IwbContainerElementRef;
begin
  Result := nil;

  _File := GetFile;
  if (mrsBaseRecordChecked in mrStates) and Assigned(_File) then
    if fsMastersUpdating in _File.FileStates then
      Exclude(mrStates, mrsBaseRecordChecked);

  if not (mrsBaseRecordChecked in mrStates) then begin
    if mrDef.ContainsKnownSubRecord[ksrBaseRecord] then begin
      SelfRef := Self as IwbContainerElementRef;
      if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then begin
        Assert(not (csInit in cntStates));
        Include(mrStates, mrsQuickInit);
        Include(cntStates, csInit);
        try
          try
            Init;
          finally
            DoReset(True);
          end;
        finally
          Exclude(cntStates, csInit);
          Exclude(mrStates, mrsQuickInit);
        end;
      end;
      mrBaseRecordID := TwbFormID.Null;
      if not (Assigned(_File) and (fsMastersUpdating in _File.FileStates)) then
        Include(mrStates, mrsBaseRecordChecked);
      if Supports(GetRecordBySignature(mrDef.KnownSubRecordSignatures[ksrBaseRecord]), IwbContainerElementRef, NameRec) then
        if Supports(NameRec.LinksTo, IwbMainRecord, Result) then begin
          mrBaseRecordID := TwbFormID.FromCardinal(NameRec.NativeValue);
        end;
      Exit;
    end else begin
      mrBaseRecordID := TwbFormID.Null;
      Include(mrStates, mrsBaseRecordChecked);
      Exit(nil);
    end;
  end;

  if not mrBaseRecordID.IsNull then
    with GetFile do
      Result := RecordByFormID[mrBaseRecordID, True, True];
end;

function TwbMainRecord.GetBaseRecordID: TwbFormID;
var
  _File      : IwbFile;
  BaseRecord : IwbMainRecord;
begin
  _File := GetFile;
  if (mrsBaseRecordChecked in mrStates) and Assigned(_File) then
    if fsMastersUpdating in _File.FileStates then
      Exclude(mrStates, mrsBaseRecordChecked);

  if not (mrsBaseRecordChecked in mrStates) then begin
    BaseRecord := GetBaseRecord;
    if Assigned(BaseRecord) then
      Result := BaseRecord.LoadOrderFormID
    else
      Result := TwbFormID.Null;
  end else
    Result := GetFile.FileFormIDtoLoadOrderFormID(mrBaseRecordID, True);
end;

function TwbMainRecord.GetBaseRecordSignature: TwbSignature;
var
  BaseRecord: IwbMainRecord;
begin
  BaseRecord := GetBaseRecord;
  if Assigned(BaseRecord) then
    Result := BaseRecord.Signature
  else
    Result := 'NULL';
end;

function TwbMainRecord.GetCanBePartial: Boolean;
begin
  Result := Assigned(mrDef) and mrDef.CanBePartial;
  if not Result then
    Exit;

  if GetSignature <> 'CELL' then
    Exit;

  var lMasterOrSelf := GetMasterOrSelf;

  var lGridCell: TwbGridCell;
  if not GetIsPersistent then
    if lMasterOrSelf.GetGridCell(lGridCell) then
      //no partial for temporary exterior cells
      Exit(False);

  // only interior cells get here

  if wbGameMode = gmFO4 then begin
    var lFile := lMasterOrSelf._File;
    if not (fsIsGameMaster in lFile.FileStates) then
      //no partial for interior cells in FO4 if they are not defined in Fallout4.esm
      Exit(False);
  end;
end;

function TwbMainRecord.GetCanHaveBaseRecord: Boolean;
begin
  Result := Assigned(mrDef) and mrDef.ContainsKnownSubRecord[ksrBaseRecord];
end;

function TwbMainRecord.GetCanHaveEditorID: Boolean;
begin
  Result := Assigned(mrDef) and mrDef.ContainsKnownSubRecord[ksrEditorID];
end;

function TwbMainRecord.GetCanHaveFullName: Boolean;
begin
  Result := Assigned(mrDef) and mrDef.ContainsKnownSubRecord[ksrFullName];
end;

function TwbMainRecord.GetCheck: string;
var
  i, j: Integer;
  RequiredCount: Integer;
  Element: IwbElement;
  Def: IwbNamedDef;
  SigDef: IwbSignatureDef;
  FoundIt: Boolean;
  SelfRef : IwbContainerElementRef;
  _File: IwbFile;
  FormID : TwbFormID;
  FixedFormID : TwbFormID;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Assigned(mrDef) then
    Exit;
  if recSkipped then
    Exit;

  _File := GetFile;
  if Assigned(_File) then begin
    if _File.IsOverlay then begin
      FormID := GetFormID;
      if _File.IsNewRecord(FormID, True) then
        Result := 'An overlay module can not contain new records.';
    end;

    if Result = '' then begin
      {!!!!! SF1 support?}
      FormID := GetFormID;
      FixedFormID := GetFixedFormID;
      if _File.IsLight and (FormID.ObjectID > $FFF) and (FixedFormID.FileID = _File.FileFileID[True]) then
        Result := 'ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' is invalid for a light module.'
      else if _File.IsMedium and (FormID.ObjectID > $FFFF) and (FixedFormID.FileID = _File.FileFileID[True]) then
        Result := 'ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' is invalid for a medium module.'
      else begin
        if FormID <> FixedFormID then
          Result := 'Warning: internal file FormID is a HITME: ' + FormID.ToString(True) + ' (should be ' + FixedFormID.ToString(True) + ' )';
      end;
    end;

    if Result <> '' then
      Exit;
  end;

  if mrStruct.mrsFlags.IsDeleted then begin
    Result := '';

    for i := GetAdditionalElementCount to Pred(GetElementCount) do begin
      Element := cntElements[i];
      Def := Element.Def;
      if Assigned(Def) then begin
        if mrDef.IsReference and Supports(Def, IwbSignatureDef, SigDef) and (mrDef.KnownSubRecordSignatures[ksrBaseRecord] = SigDef.DefaultSignature) then
          Continue;
        Result := Result + Def.Name + ', ';
      end;
    end;
    SetLength(Result, Length(Result) - 2);

    if Result <> '' then
      Result := 'Record marked as deleted, but contains: ' + Result;

    Exit;
  end;

  if GetIsPartialForm then begin
    Result := '';

    for i := GetAdditionalElementCount to Pred(GetElementCount) do begin
      Element := cntElements[i];
      Def := Element.Def;
      if Assigned(Def) then begin
        if Supports(Def, IwbSignatureDef, SigDef) and (mrDef.KnownSubRecordSignatures[ksrEditorID] = SigDef.DefaultSignature) then
          Continue;
        if dfDontSave in Def.DefFlags then
          Continue;
        Result := Result + Def.Name + ', ';
      end;
    end;
    SetLength(Result, Length(Result) - 2);

    if Result <> '' then
      Result := 'Record is Partial Form, but contains: ' + Result;

    Exit;
  end;

  RequiredCount := 0;
  for i := 0 to Pred(mrDef.MemberCount) do
    if mrDef.Members[i].Required then
      Inc(RequiredCount);

  for i := 0 to Pred(GetElementCount) do begin
    Element := cntElements[i];
    Def := Element.Def;
    if Assigned(Def) then begin
      if Def.Required then
        Dec(RequiredCount);
    end;
  end;

  if RequiredCount > 0 then begin
    Result := 'Missing required members: ';

    for i := 0 to Pred(mrDef.MemberCount) do
      if mrDef.Members[i].Required then begin
        Def := mrDef.Members[i];
        FoundIt := False;
        for j := 0 to High(cntElements) do begin
          Element := cntElements[j];
          if Def.Equals(Element.Def) then begin
            FoundIt := True;
            Break;
          end;
        end;
        if not FoundIt then
          Result := Result + Def.FullPath + ', ';
      end;
    SetLength(Result, Length(Result) - 2);
  end;

  mrDef.ToString(Result, Self, ctCheck);
end;

function TwbMainRecord.GetChildByGridCell(const aGridCell: TwbGridCell): IwbMainRecord;
var
  Group    : IwbGroupRecord;
  Block    : TwbGridCell;
  SubBlock : TwbGridCell;
  i        : Integer;
  Cell     : IwbMainRecord;
  GridCell : TwbGridCell;
begin
  Group := GetChildGroup;
  if not Assigned(Group) then
    Exit(nil);
  if Group.GroupType <> 1 then
    Exit(nil);
  SubBlock := wbSubBlockFromGridCell(aGridCell);
  Block := wbBlockFromSubBlock(SubBlock);
  Group := Group.FindChildGroup(4, wbGridCellToGroupLabel(Block));
  if not Assigned(Group) then
    Exit(nil);
  Group := Group.FindChildGroup(5, wbGridCellToGroupLabel(SubBlock));
  if not Assigned(Group) then
    Exit(nil);
  for i := 0 to Pred(Group.ElementCount) do
    if Supports(Group.Elements[i], IwbMainRecord, Cell) and Cell.GetGridCell(GridCell) then
      if aGridCell = GridCell then
        Exit(Cell);
  Result := nil;
end;

function TwbMainRecord.GetChildBySignature(const aSignature: TwbSignature): IwbMainRecord;
var
  Group: IwbGroupRecord;
begin
  Group := GetChildGroup;
  if not Assigned(Group) then
    Exit(nil);

  Result := nil;
  if not Supports(Group.ElementBySignature[aSignature], IwbMainRecord, Result) then
    if Group.GroupType = 6 then begin
      Group := Group.FindChildGroup(9, Self);
      if Assigned(Group) then
        Supports(Group.ElementBySignature[aSignature], IwbMainRecord, Result);
    end;
end;

function TwbMainRecord.GetChildGroup: IwbGroupRecord;
var
  SearchForGroup: Integer;
  ContainingGroup: IwbGroupRecord;
begin
  Result := mrGroup;
  if not Assigned(Result) and not (mrsSearchingChildGroup in mrStates) then begin
    if Supports(GetContainer, IwbGroupRecord, ContainingGroup) then try
      if mrGroupSearchGen = ContainingGroup.ElementGeneration then
        Exit;

      Include(mrStates, mrsSearchingChildGroup);
      SearchForGroup := 0;
      if GetSignature = 'WRLD' then
        SearchForGroup := 1
      else if GetSignature = 'CELL' then
        SearchForGroup := 6
      else if GetSignature = 'DIAL' then
        SearchForGroup := 7
      else if wbVWDAsQuestChildren and (GetSignature = 'QUST') then
        SearchForGroup := 10;

      if SearchForGroup > 0 then
        mrGroup := ContainingGroup.FindChildGroup(SearchForGroup, Self);
      Result := mrGroup;
      mrGroupSearchGen := ContainingGroup.ElementGeneration;
    finally
      Exclude(mrStates, mrsSearchingChildGroup);
    end;
  end;
end;

function TwbMainRecord.GetConflictAll: TConflictAll;
begin
  Result := mrConflictAll;
end;

function TwbMainRecord.GetConflictThis: TConflictThis;
begin
  Result := mrConflictThis;
end;

function TwbMainRecord.GetContainingMainRecord: IwbMainRecord;
begin
  Result := Self;
end;

function TwbMainRecord.GetDef: IwbNamedDef;
begin
  Result := mrDef;
end;

function StrRight(const s: String; Len: Integer): string;
begin
  Result := s;
  while Length(Result)<Len do
    Result := ' ' + Result;
end;

function TwbMainRecord.GetDisplayName(aUseSuffix: Boolean): string;
var
  Rec         : IwbRecord;
  GroupRecord : IwbGroupRecord;
  MapMarker   : IwbContainerElementRef;
  _File       : IwbFile;
  GridCell    : TwbGridCell;
begin
  if mrLGeneration <> wbLocalizationHandler.Generation then
    mrInvalidateNameCache;

  if mrDisplayName <> '' then
    Exit(mrDisplayName);

  Result := GetFullName;
  if Result = '' then
    if
      (GetSignature = 'REFR') or
      (GetSignature = 'PGRE') or
      (GetSignature = 'PMIS') or
      (GetSignature = 'ACHR') or
      (GetSignature = 'ACRE') or
      (GetSignature = 'PARW') or {>>> Skyrim <<<}
      (GetSignature = 'PBEA') or {>>> Skyrim <<<}
      (GetSignature = 'PFLA') or {>>> Skyrim <<<}
      (GetSignature = 'PCON') or {>>> Skyrim <<<}
      (GetSignature = 'PBAR') or {>>> Skyrim <<<}
      (GetSignature = 'PHZD')    {>>> Skyrim <<<}
    then begin
      if Supports(GetElementByName('Map Marker'), IwbContainerElementRef, MapMarker) then
        Rec := MapMarker.RecordBySignature[mrDef.KnownSubRecordSignatures[ksrFullName]]
      else
        Rec := GetRecordBySignature(mrDef.KnownSubRecordSignatures[ksrBaseRecord]);
      if Assigned(Rec) then
        Result := Trim(Rec.Value)
    end else if (GetSignature = 'CELL') then begin
      if Supports(GetContainer, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1) then
        Result := '<Persistent Worldspace Cell>'
      else
        if GetGridCell(GridCell) then
          Result := '<' + StrRight(GridCell.X.ToString, 3) + ', ' + StrRight(GridCell.Y.ToString, 3) + '>';
    end else if (wbGameMode = gmTES3) and (GetSignature = 'LAND') then begin
      if GetGridCell(GridCell) then
        Result := '<' + StrRight(GridCell.X.ToString, 3) + ', ' + StrRight(GridCell.Y.ToString, 3) + '>';
    end else if (wbGameMode = gmTES3) and (GetSignature = 'PGRD') then begin
      if GetGridCell(GridCell) then
        Result := '<' + StrRight(GridCell.X.ToString, 3) + ', ' + StrRight(GridCell.Y.ToString, 3) + '>';
    end else if (GetSignature = 'INFO') then begin
        Result := GetElementValue('Responses\Response\NAM1');
    end;

  if Result = '' then
    Result := GetSummary;

  _File := GetFile;
  if Assigned(_File) and (fsIsOfficial in _File.FileStates) then
    mrDisplayName := Result;
end;

function TwbMainRecord.GetDisplayNameKey: string;
var
  Rec         : IwbRecord;
  GroupRecord : IwbGroupRecord;
  MapMarker   : IwbContainerElementRef;
  GridCell    : TwbGridCell;
begin
  Result := GetFullName;
  if Result = '' then
    if
      (GetSignature = 'REFR') or
      (GetSignature = 'PGRE') or
      (GetSignature = 'PMIS') or
      (GetSignature = 'ACHR') or
      (GetSignature = 'ACRE') or
      (GetSignature = 'PARW') or {>>> Skyrim <<<}
      (GetSignature = 'PBEA') or {>>> Skyrim <<<}
      (GetSignature = 'PFLA') or {>>> Skyrim <<<}
      (GetSignature = 'PCON') or {>>> Skyrim <<<}
      (GetSignature = 'PBAR') or {>>> Skyrim <<<}
      (GetSignature = 'PHZD')    {>>> Skyrim <<<}
    then begin
      if Supports(GetElementByName('Map Marker'), IwbContainerElementRef, MapMarker) then
        Rec := MapMarker.RecordBySignature[mrDef.KnownSubRecordSignatures[ksrFullName]]
      else
        Rec := GetRecordBySignature(mrDef.KnownSubRecordSignatures[ksrBaseRecord]);
      if Assigned(Rec) then
        Result := Trim(Rec.Value)
    end else if (GetSignature = 'CELL') then begin
      if Supports(GetContainer, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1) then
        Result := ' '
      else
        if GetGridCell(GridCell) then
          Result := GridCell.SortKey;
    end else if (wbGameMode = gmTES3) and (GetSignature = 'LAND') then begin
      if GetGridCell(GridCell) then
        Result := GridCell.SortKey;
    end else if (wbGameMode = gmTES3) and (GetSignature = 'PGRD') then
      if GetGridCell(GridCell) then
        Result := GridCell.SortKey;

  if Result = '' then
    Result := GetDisplayName(True);
end;

function TwbMainRecord.GetEditorID: string;
var
  SelfRef: IwbContainerElementRef;
begin
  if mrsEditorIDFromCache in mrStates then
    Exit(mrEditorID);

  SelfRef := Self as IwbContainerElementRef;

  if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then
    if GetCanHaveEditorID then begin
      if csInit in cntStates then begin
        Result := '<EditorID not yet available: init still running>';
        Exit;
      end;
      Include(mrStates, mrsQuickInit);
      Include(cntStates, csInit);
      try
        try
          Init;
        finally
          DoReset(True);
        end;
      finally
        Exclude(cntStates, csInit);
        Exclude(mrStates, mrsQuickInit);
      end;
    end;

  Result := mrEditorID;
end;

function TwbMainRecord.GetEditValue: string;
begin
  if wbDisplayLoadOrderFormID then
    Result := GetLoadOrderFormID.ToString(False)
  else
    Result := GetFormID.ToString(False);
end;

function TwbMainRecord.GetElementType: TwbElementType;
begin
  Result := etMainRecord;
end;

function TwbMainRecord.GetExternalReferencesCount: Integer;
begin
  Result := 0;
  var _File := GetFile;
  if not Assigned(_File) then
    Exit;
  var MasterCount := _File.MasterCount[GetMastersUpdated];
  if MasterCount < 1 then
    Exit;

  for var FormID in mrReferences do begin
    if wbComplexFileFileID then begin
      if _File.IsNewRecord(FormID, GetMastersUpdated) then
        Continue;
    end else begin
      if FormID.FileID.FullSlot >= MasterCount then
        Exit;
    end;
    Inc(Result);
  end;
end;

function TwbMainRecord.GetFixedFormID: TwbFormID;
begin
  Result := mrFixedFormID;
  if Result.IsNull then
    Result := DoGetFixedFormID;
end;

function TwbMainRecord.GetFlags: TwbMainRecordStructFlags;
begin
  Result := mrStruct.mrsFlags^;
end;

function TwbMainRecord.GetFlagsPtr: PwbMainRecordStructFlags;
begin
  Result := mrStruct.mrsFlags;
end;

function TwbMainRecord.GetFormID: TwbFormID;
begin
  if wbGameMode = gmTES3 then begin
    if not mrDef.GetFormID(Self, Result) then
      Result :=  wbFormIDFromIdentity(mrDef.GetFormIDBase, mrDef.GetFormIDNameBase, mrDef.GetIdentity(Self))
  end else
    Result := mrStruct.mrsFormID^;
end;

function TwbMainRecord.GetFullName: string;
var
  SelfRef: IwbContainerElementRef;
begin
  if mrLGeneration <> wbLocalizationHandler.Generation then
    mrInvalidateNameCache;

  if mrsFullNameFromCache in mrStates then
    Exit(mrFullName);

  SelfRef := Self as IwbContainerElementRef;

  if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then
    if GetCanHaveFullName then begin
      Include(mrStates, mrsQuickInit);
      if csInit in cntStates then begin
        Result := '<FullName not yet available: init still running>';
        Exit;
      end;
      Include(cntStates, csInit);
      try
        try
          Init;
        finally
          DoReset(True);
        end;
      finally
        Exclude(cntStates, csInit);
        Exclude(mrStates, mrsQuickInit);
      end;
    end;

  Result := mrFullName;
end;

function TwbMainRecord.GetFormVersion: Cardinal;
begin
  if wbGameMode >= gmFO3 then
    Result := mrStruct.mrsVersion^
  else
    Result := 0;
end;

procedure TwbMainRecord.SetFormVersion(aFormVersion: Cardinal);
begin
  if wbGameMode >= gmFO3 then begin
    MakeHeaderWriteable;
    mrStruct.mrsVersion^ := aFormVersion;
  end;
end;

function TwbMainRecord.SetGridCell(const aGridCell: TwbGridCell): Boolean;
var
  GridCellSig : TwbSignature;
  SelfRef     : IwbContainerElementRef;
  GridCellRec : IwbContainerElementRef;
begin
  Result := False;

  if not mrDef.ContainsKnownSubRecord[ksrGridCell] then
    Exit;

  SelfRef := Self;
  DoInit(False);

  GridCellSig := mrDef.KnownSubRecordSignatures[ksrGridCell];

  if not Supports(GetRecordBySignature(GridCellSig), IwbContainerElementRef, GridCellRec) then begin
    Add(GridCellSig, True);
    if not Supports(GetRecordBySignature(GridCellSig), IwbContainerElementRef, GridCellRec) then
      Exit;
  end;

  if GridCellRec.ElementCount < 2 then
    Exit;

  with aGridCell, GridCellRec do begin
    BeginUpdate;
    try
      ElementNativeValues['X'] := x;
      ElementNativeValues['Y'] := y;
    finally
      EndUpdate;
    end;
    Result := True;
  end;
end;

function TwbMainRecord.GetFormVCS1: Cardinal;
begin
  Result := mrStruct.mrsVCS1^;
end;

procedure TwbMainRecord.SetFormVCS1(aVCS: Cardinal);
begin
  MakeHeaderWriteable;
  mrStruct.mrsVCS1^ := aVCS;
end;

function TwbMainRecord.GetFormVCS2: Cardinal;
begin
  if wbGameMode >= gmFO3 then
    Result := mrStruct.mrsVCS2^
  else
    Result := 0;
end;

procedure TwbMainRecord.SetFormVCS2(aVCS: Cardinal);
begin
  if wbGameMode >= gmFO3 then begin
    MakeHeaderWriteable;
    mrStruct.mrsVCS2^ := aVCS;
  end;
end;

procedure TwbMainRecord.ChangeFormSignature(aSignature: TwbSignature);
begin
  MakeHeaderWriteable;
  mrStruct.mrsSignature := aSignature;
end;

procedure TwbMainRecord.ClampFormID(aIndex: Byte);
begin
  if wbGameMode = gmTES3 then
    Exit;
  if wbComplexFileFileID then 
    Exit;
 
  if mrStruct.mrsFormID.FileID.FullSlot > aIndex then begin
    MakeHeaderWriteable;
    mrStruct.mrsFormID.FileID := TwbFileID.CreateFull(aIndex);
    if Assigned(mrGroup) or (GetChildGroup <> nil) then
      mrGroup.GroupLabel := mrStruct.mrsFormID.ToCardinal;
  end else
    if mrStruct.mrsFormID.FileID.FullSlot = aIndex then
      if Assigned(mrGroup) or (GetChildGroup <> nil) then
        mrGroup.GroupLabel := mrStruct.mrsFormID.ToCardinal;
end;

function TwbMainRecord.GetGridCell(out aGridCell: TwbGridCell): Boolean;
var
  SelfRef   : IwbContainerElementRef;
begin
  Result := False;

  if not mrDef.ContainsKnownSubRecord[ksrGridCell] then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  if not (mrsGridCellChecked in mrStates) then
    if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then begin
      if csInit in cntStates then
        Exit(False);
      Include(mrStates, mrsQuickInit);
      Include(cntStates, csInit);
      try
        try
          Init;
        finally
          DoReset(True);
        end;
      finally
        Exclude(cntStates, csInit);
        Exclude(mrStates, mrsQuickInit);
      end;
    end;

  Result := (mrsHasGridCell in mrStates);
  if Result then
    aGridCell := mrGridCell;
end;

function TwbMainRecord.GetHasMesh: Boolean;
var
  SelfRef  : IwbContainerElementRef;
  ModelCnt : IwbContainerElementRef;
  MODL     : IwbContainerElementRef;
  s        : String;
begin
  if not (mrsHasMeshChecked in mrStates) and Assigned(wbContainerHandler) then begin
    Include(mrStates, mrsHasMeshChecked);
    if GetSignature = 'TREE' then begin
      Include(mrStates, mrsHasMesh);
    end else begin
      SelfRef := Self as IwbContainerElementRef;
      if Supports(GetElementByName('Model'), IwbContainerElementRef, ModelCnt) then
        if Supports(ModelCnt.RecordBySignature['MODL'], IwbContainerElementRef, MODL) then begin
          s := Trim(StringReplace(MODL.EditValue, '/', '\', [rfReplaceAll]));
          if s <> '' then begin
            s := 'meshes\' + s;//
            if Length(wbContainerHandler.OpenResource(s)) > 0 then
              Include(mrStates, mrsHasMesh);
          end;
        end;
    end;
  end;
  Result := mrsHasMesh in mrStates;
end;

function TwbMainRecord.GetHasPrecombinedMesh: Boolean;
begin
  if not (mrsHasPrecombinedMeshChecked in mrStates) then
    Self.GetPrecombinedMesh;

  Result := mrsHasPrecombinedMesh in mrStates;
end;

type
  TwbPrecombinedInfo = record
    Ref, ID: Cardinal;
  end;

threadvar
  PrecombinedCacheFileName: string;
  PrecombinedCacheCellFormID: TwbFormID;
  PrecombinedCache: array of TwbPrecombinedInfo;

function TwbMainRecord.GetPrecombinedMesh: string;
var
  Signature   : TwbSignature;
  SelfRef     : IwbContainerElementRef;
  Group       : IwbGroupRecord;
  Cell        : IwbMainRecord;
  CombinedRefs, CombinedRef: IwbContainerElementRef;
  cnt, i      : Integer;
  CellFormID  : TwbFormID;
  MasterFolder, s: string;
begin
  Result := '';

  if not wbIsFallout4 and not wbIsFallout76 then
    Exit;

  if not (mrsHasPrecombinedMeshChecked in mrStates) then begin

    // we need file for cache checking
    if not Assigned(IwbElement(Self)._File) then
      Exit;

    Include(mrStates, mrsHasPrecombinedMeshChecked);
    Self.mrPrecombinedCellID := 0;
    Self.mrPrecombinedID := 0;

    Signature := Self.GetSignature;

    if (Signature <> 'REFR') and
       (Signature <> 'PGRE') and
       (Signature <> 'PMIS') and
       (Signature <> 'PARW') and
       (Signature <> 'PBEA') and
       (Signature <> 'PFLA') and
       (Signature <> 'PCON') and
       (Signature <> 'PBAR') and
       (Signature <> 'PHZD')
    then
      Exit;

    SelfRef := Self as IwbContainerElementRef;

    // markers can't be precombined
    if Cardinal(SelfRef.ElementNativeValues[mrDef.KnownSubRecordSignatures[ksrBaseRecord]]) < $800 then
      Exit;

    if Supports(SelfRef.Container, IwbGroupRecord, Group) then
      Cell := Group.ChildrenOf;

    if not Assigned(Cell) then
      Exit;

    s := IwbElement(Self)._File.Name;
    CellFormID := Cell.FormID;

    // store cell's precombined index in cache
    if (CellFormID <> PrecombinedCacheCellFormID) or (s <> PrecombinedCacheFileName) then begin
      PrecombinedCacheCellFormID := CellFormID;
      PrecombinedCacheFileName := s;
      SetLength(PrecombinedCache, 0);

      if wbGameMode = gmFO76 then begin
        if Supports(Cell.ElementByPath['XCRP\References'], IwbContainerElementRef, CombinedRefs) then begin
          cnt := CombinedRefs.ElementCount;
          SetLength(PrecombinedCache, cnt);
          for i := 0 to Pred(cnt) do begin
            PrecombinedCache[i].Ref := CombinedRefs[i].NativeValue;
            PrecombinedCache[i].ID := 0;
          end;
        end;
      end else begin
        if Supports(Cell.ElementByPath['XCRI\References'], IwbContainerElementRef, CombinedRefs) then begin
          cnt := CombinedRefs.ElementCount;
          SetLength(PrecombinedCache, cnt);
          for i := 0 to Pred(cnt) do
            if Supports(CombinedRefs[i], IwbContainerElementRef, CombinedRef) and (CombinedRef.ElementCount = 2) then begin
              PrecombinedCache[i].Ref := CombinedRef.Elements[0].NativeValue;
              PrecombinedCache[i].ID := CombinedRef.Elements[1].NativeValue;
            end;
        end;
      end;
    end;

    // search for ref in precombined index cache
    if Length(PrecombinedCache) > 0 then
      for i := Low(PrecombinedCache) to High(PrecombinedCache) do
        if PrecombinedCache[i].Ref = Self.GetFormID.ToCardinal then begin
          Self.mrPrecombinedCellID := Cell.FormID.ObjectID;
          Self.mrPrecombinedID := PrecombinedCache[i].ID;
          Include(mrStates, mrsHasPrecombinedMesh);
          Break;
        end;
  end;

  if mrsHasPrecombinedMesh in mrStates then begin

    if wbGameMode = gmFO76 then begin
      Result := 'Precombined\' + IntToHex(Self.mrPrecombinedCellID, 8) + '\' + IntToHex(Self.mrPrecombinedCellID, 8) + 'nif';
    end else begin
      MasterFolder := '';
      SelfRef := Self as IwbContainerElementRef;
      if Supports(SelfRef.Container, IwbGroupRecord, Group) then
        if Supports(Group.ChildrenOf, IwbMainRecord, Cell) then begin
          Cell := Cell.MasterOrSelf;
          if Assigned(Cell) and Assigned(Cell._File) and (Cell._File.LoadOrder > 0) then
            MasterFolder := Cell._File.FileName + '\';
        end;

      Result := 'Precombined\' + MasterFolder + IntToHex(Self.mrPrecombinedCellID, 8) + '_' + IntToHex(Self.mrPrecombinedID, 8) + '_OC.nif';
    end;
  end;
end;

function TwbMainRecord.GetHasVisibleWhenDistantMesh: Boolean;
var
  SelfRef  : IwbContainerElementRef;
  ModelCnt : IwbContainerElementRef;
  MODL     : IwbContainerElementRef;
  s        : String;
begin
  if not (mrsHasVWDMeshChecked in mrStates) and Assigned(wbContainerHandler) then begin
    Include(mrStates, mrsHasVWDMeshChecked);
    if GetSignature = 'TREE' then begin
      SelfRef := Self as IwbContainerElementRef;
      if Supports(GetElementByName('Model'), IwbContainerElementRef, ModelCnt) then
        if Supports(ModelCnt.RecordBySignature['MODL'], IwbContainerElementRef, MODL) then begin
          s := Trim(StringReplace(MODL.EditValue, '/', '\', [rfReplaceAll]));
          if s <> '' then begin
            s := 'textures\trees\billboards' + ChangeFileExt(s, '.dds');
            if Length(wbContainerHandler.OpenResource(s)) > 0 then
              Include(mrStates, mrsHasVWDMesh);
          end;
        end;
    end else begin
      SelfRef := Self as IwbContainerElementRef;
      if Supports(GetElementByName('Model'), IwbContainerElementRef, ModelCnt) then
        if Supports(ModelCnt.RecordBySignature['MODL'], IwbContainerElementRef, MODL) then begin
          s := Trim(StringReplace(MODL.EditValue, '/', '\', [rfReplaceAll]));
          if s <> '' then begin
            s := 'meshes\' + ChangeFileExt(s, '_far.nif');
            if Length(wbContainerHandler.OpenResource(s)) > 0 then
              Include(mrStates, mrsHasVWDMesh);
          end;
        end;
    end;
  end;
  Result := mrsHasVWDMesh in mrStates;
end;

function TwbMainRecord.GetHighestOverrideOrSelf(aMaxLoadOrder: Integer): IwbMainRecord;
var
  Master : IwbMainRecord;
  i      : Integer;
begin
  Result := Self;
  Master := GetMasterOrSelf;
  for i := Pred(Master.OverrideCount) downto 0 do begin
    var lOverride := Master.Overrides[i];
    if not lOverride.IsPartialForm and (lOverride._File.LoadOrder <= aMaxLoadOrder) then
      Exit(lOverride);
  end;
end;

function TwbMainRecord.GetHighestOverrideVisibleForFile(const aFile: IwbFile): IwbMainRecord;
var
  MainRecord : IwbMainRecord;
  i          : Integer;
  FormID     : TwbFormID;
  _File      : IwbFile;
begin
  FormID := GetLoadOrderFormID;
  Result := Self;
  if (aFile.LoadOrder > GetFile.LoadOrder) or GetIsPartialForm then begin
    MainRecord := aFile.ContainedRecordByLoadOrderFormID[FormID, True];
    if Assigned(MainRecord) and not MainRecord.IsPartialForm then
      Result := MainRecord
    else
      for i := Pred(aFile.MasterCount[True]) downto 0 do begin
        _File := aFile.Masters[i, True];
        if (_File.LoadOrder > Result._File.LoadOrder) or Result.IsPartialForm then begin
          MainRecord := _File.ContainedRecordByLoadOrderFormID[FormID, True];
          if Assigned(MainRecord) and not MainRecord.IsPartialForm then
            Result := MainRecord;
        end;
      end;
  end;
end;

function TwbMainRecord.GetInjectionSourceFiles: TwbFiles;
var
  i, j, k : Integer;
  Rec     : IwbMainRecord;
  _File : IwbFile;
  LastID  : Pointer;
begin
  SetLength(Result, Length(mrReferences));
  if Length(Result) > 0 then begin
    _File := GetFile;
    j := 0;
    for i := Low(mrReferences) to High(mrReferences) do begin
      Rec := _File.RecordByFormID[mrReferences[i], True, GetMastersUpdated];
      if Assigned(Rec) then
        if not _File.Equals(Rec._File) then begin
          Rec := Rec.MasterOrSelf;
          if Rec.IsInjected then begin
            Result[j] := Rec._File;
            Inc(j);
          end;
        end;
    end;
    if j > 1 then begin
      wbMergeSortPtr(@Result[0], j, CompareLoadOrder);
      k := 1;
      LastID := Result[0].ElementID;
      for i := 1 to Pred(j) do
        if Result[i].ElementID <> LastID then begin
          LastID := Result[i].ElementID;
          if k <> i then
            Result[k] := Result[i];
          Inc(k);
        end;
      SetLength(Result, k);
    end else
      SetLength(Result, j);
  end;
end;

function TwbMainRecord.GetIsCompressed: Boolean;
begin
  Result := GetFlags.IsCompressed;
end;

function TwbMainRecord.GetIsDeleted: Boolean;
begin
  Result := GetFlags.IsDeleted;
end;

function TwbMainRecord.GetIsEditable: Boolean;
begin
  Result := wbIsInternalEdit;
  if Result or (dfInternalEditOnly in mrDef.DefFlags) then
    Exit;

  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;

  Result := True;
end;

function TwbMainRecord.GetIsMedium: Boolean;
begin
  Result := GetFlags.IsMedium;
end;

function TwbMainRecord.GetIsLight: Boolean;
begin
  Result := GetFlags.IsLight;
end;

function TwbMainRecord.GetIsOverlay: Boolean;
begin
  Result := GetFlags.IsOverlay;
end;


function TwbMainRecord.GetIsESM: Boolean;
begin
  Result := GetFlags.IsESM;
end;

function TwbMainRecord.GetIsLocalized: Boolean;
begin
  Result := GetFlags.IsLocalized;
end;

function TwbMainRecord.GetIsInitiallyDisabled: Boolean;
begin
  Result := GetFlags.IsInitiallyDisabled;
end;

function TwbMainRecord.GetIsInjected: Boolean;
begin
  if not (mrsIsInjectedChecked in mrStates) then begin
    var _File := GetFile;
    var FormID := GetFixedFormID;
    if Assigned(_File) and
       not Assigned(mrMaster) and
       not FormID.IsNull and
           (not _File.IsNewRecord(FormID, GetMastersUpdated)) and
       not (fsIsHardcoded in _File.FileStates) and
       ((wbGameMode > gmTES3) or (FormID.FileID.FullSlot > 0)) then
      Include(mrStates, mrsIsInjected)
    else
      Exclude(mrStates, mrsIsInjected);
    Include(mrStates, mrsIsInjectedChecked);
  end;
  Result := mrsIsInjected in mrStates;
end;

function TwbMainRecord.GetIsInList: Boolean;
begin
  with mreHeader do
    Result := mrehInUse and (mrehGeneration = mreGeneration);
end;

function TwbMainRecord.GetIsMaster: Boolean;
begin
  Result := not Assigned(mrMaster);
end;

function TwbMainRecord.GetIsNotReachable: Boolean;
var
  i: Integer;
begin
  if Assigned(mrMaster) then
    Result := IwbMainRecord(mrMaster).IsNotReachable
  else begin
    Result := inherited GetIsNotReachable;
    if Result then
      for i := Low(mrOverrides) to High(mrOverrides) do
        if not (esNotReachable in mrOverrides[i].ElementStates) then
          Exit(False);
  end;
end;

function TwbMainRecord.GetIsPartialForm: Boolean;
begin
  Result :=  Assigned(mrDef) and mrDef.CanBePartial and GetFlags.IsPartialForm;
end;

function TwbMainRecord.GetIsPersistent: Boolean;
begin
  Result := GetFlags.IsPersistent;
end;

function TwbMainRecord.GetIsReachable: Boolean;
var
  i: Integer;
begin
  if Assigned(mrMaster) then
    Result := IwbMainRecord(mrMaster).IsReachable
  else begin
    Result := inherited GetIsReachable;
    if not Result then
      for i := Low(mrOverrides) to High(mrOverrides) do
        if esReachable in mrOverrides[i].ElementStates then
          Exit(True);
  end;
end;

function TwbMainRecord.GetIsVisibleWhenDistant: Boolean;
begin
  Result := GetFlags.IsVisibleWhenDistant;
end;

function TwbMainRecord.GetIsWinningOverride: Boolean;
var
  Master: IwbMainRecord;
begin
  if GetIsPartialForm then
    Exit(False);
  if Assigned(mrMaster) then begin
    Master := IwbMainRecord(mrMaster);
    Result := Equals(Master.WinningOverride);
  end else begin
    for var lIndex := High(mrOverrides) downto Low(mrOverrides) do
      if not mrOverrides[lIndex].IsPartialForm then
        Exit(False);
    Result := True;
  end;
end;

function TwbMainRecord.GetLoadOrderFormID: TwbFormID;
begin
  Result := mrLoadOrderFormID;
  if Result.IsNull then
    Result := DoGetLoadOrderFormID;
end;

function TwbMainRecord.GetMainRecordDef: IwbMainRecordDef;
begin
  Result := mrDef;
end;

function TwbMainRecord.GetMaster: IwbMainRecord;
begin
  Result := IwbMainRecord(mrMaster);
end;

function TwbMainRecord.GetMasterAndLeafs: TDynMainRecords;
var
  lMasters : TStringList;
  i, j, k : Integer;
  _File   : IwbFile;
begin
  if Assigned(mrMaster) then
    Exit(IwbMainRecord(mrMaster).GetMasterAndLeafs);
  if Length(mrMasterAndLeafs) < 1 then begin
    k := Succ(Length(mrOverrides));
    SetLength(mrMasterAndLeafs, k);
    mrMasterAndLeafs[0] := GetMasterOrSelf;
    if k > 2 {there is more than one override} then begin
      k := 1;
      lMasters := TStringList.Create;
      lMasters.Sorted := True;
      lMasters.Duplicates := dupIgnore;
      try
        if not (mrsOverridesSorted in mrStates) then
          GetOverride(0); {forces sorting of overrides}

        for i := Low(mrOverrides) to High(mrOverrides) do begin
          _File := mrOverrides[i]._File;
          for j := Pred(_File.MasterCount[True]) downto 0 do
            lMasters.Add(_File.Masters[j, True].FileName);
        end;

        for i := Low(mrOverrides) to High(mrOverrides) do begin
          _File := mrOverrides[i]._File;
          if lMasters.IndexOf(_File.FileName) < 0 then begin
            mrMasterAndLeafs[k] := mrOverrides[i];
            Inc(k);
          end;
        end;
      finally
        lMasters.Free;
      end;
      SetLength(mrMasterAndLeafs, k);
    end else if k = 2 {there is exactly one override} then
      mrMasterAndLeafs[1] := mrOverrides[0];
  end;
  SetLength(Result, Length(mrMasterAndLeafs));
  for i := Low(mrMasterAndLeafs) to High(mrMasterAndLeafs) do
    Result[i] := IwbMainRecord(mrMasterAndLeafs[i]);
end;

function TwbMainRecord.GetMasterOrSelf: IwbMainRecord;
begin
  Result := GetMaster;
  if not Assigned(Result) then
    Result := Self;
end;

function TwbMainRecord.GetShortName: string;
begin
  Result := GetShortNameInternal(False);
end;

function TwbMainRecord.GetShortNameInternal(aForName: Boolean): string;
var
  s        : string;
  CanCache : Boolean;
begin
  CanCache := (not aForName) or not wbNoFullInShortName;

  if mrLGeneration <> wbLocalizationHandler.Generation then
    mrInvalidateNameCache;

  if wbDisplayShorterNames then begin
    if CanCache and (mrShortName <> '') then
      Exit(mrShortName);

    Result := '';

    s := GetEditorID;
    if s <> '' then
      Result := Result + {'<' + } s { + '>'};

    if not wbNoFullInShortName or aForName then begin
      s := GetFullName;
      if s <> '' then begin
        s := s.Replace('"', '""',[ rfReplaceAll]);
        if Result <> '' then
          Result := Result + ' ';
        Result := Result + '"' + s + '"';
      end;
    end;

    if Result <> '' then
      Result := Result + ' ';

    if wbDisplayLoadOrderFormID then
      Result := Result + '[' + GetSignature + ':' + GetLoadOrderFormID.ToString(True) + ']'
    else
      Result := Result + '[' + GetSignature + ':' + GetFormID.ToString(True) + ']';

    if CanCache and (fsIsOfficial in GetFile.FileStates) then
      mrShortName := Result;
  end else begin
    Result := inherited GetName;

    if Assigned(mrDef) then
      Result := Result + ' - ' + mrDef.GetName;

    if wbDisplayLoadOrderFormID then
      Result := Result + ' [' + GetLoadOrderFormID.ToString(True) + ']'
    else
      Result := Result + ' [' + GetFormID.ToString(True) + ']';

    s := GetEditorID;
    if s <> '' then
      Result := Result + ' <' + s + '>';

    s := GetFullName;
    if s <> '' then begin
      s := s.Replace('"', '""',[ rfReplaceAll]);
      Result := Result + ' "' + s + '"';
    end;

  end;
end;

function TwbMainRecord.GetName: string;
var
  s : string;
begin
  if mrLGeneration <> wbLocalizationHandler.Generation then
    mrInvalidateNameCache;

  if mrName <> '' then
    Exit(mrName);

  Result := GetShortNameInternal(True);
  if Assigned(mrDef) then begin
    s := Trim(mrDef.AdditionalInfoFor(Self));
    if s <> '' then
      Result := Result + ' (' + s + ')';
  end;

  if fsIsOfficial in GetFile.FileStates then
    mrName := Result;
end;

function TwbMainRecord.GetNativeValue: Variant;
begin
  if wbDisplayLoadOrderFormID then
    Result := GetLoadOrderFormID.ToCardinal
  else
    Result := GetFormID.ToCardinal;
end;

function TwbMainRecord.GetNextEntry: IwbMainRecordEntry;
begin
  Assert(mreHeader.mrehInUse);
  if mreGeneration = mreHeader.mrehGeneration then
    Result := IwbMainRecordEntry(mreNext)
  else
    Result := nil;
end;

function TwbMainRecord.GetOverride(aIndex: Integer): IwbMainRecord;
begin
  if not (mrsOverridesSorted in mrStates) then begin
    wbMergeSortPtr(@mrOverrides[0], Length(mrOverrides), CompareOverrides);
    Include(mrStates, mrsOverridesSorted);
  end;

  Result := mrOverrides[aIndex];
end;

function TwbMainRecord.GetOverrideCount: Integer;
begin
  Result := Length(mrOverrides);
end;

function TwbMainRecord.GetPosition(out aPosition: TwbVector): Boolean;
var
  Signature : TwbSignature;
  SelfRef   : IwbContainerElementRef;
  DataRec   : IwbContainerElementRef;
begin
  Result := False;
  try
    Signature := GetSignature;
    if (Signature <> 'REFR') and
       (Signature <> 'ACRE') and
       (Signature <> 'ACHR') and
       (Signature <> 'PGRE') and
       (Signature <> 'PMIS') and
       (Signature <> 'PARW') and {>>> Skyrim <<<}
       (Signature <> 'PBEA') and {>>> Skyrim <<<}
       (Signature <> 'PFLA') and {>>> Skyrim <<<}
       (Signature <> 'PCON') and {>>> Skyrim <<<}
       (Signature <> 'PBAR') and {>>> Skyrim <<<}
       (Signature <> 'PHZD')     {>>> Skyrim <<<}
    then
      Exit;

    SelfRef := Self;
    DoInit(False);

    if not Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, DataRec) then
      Exit;

    if DataRec.ElementCount <> 2 then
      Exit;

    with aPosition, (DataRec.Elements[0] as IwbContainerElementRef) do begin
      if ElementCount <> 3 then
        Exit;

      X := Elements[0].NativeValue;
      Y := Elements[1].NativeValue;
      Z := Elements[2].NativeValue;
    end;
  except
    on E: Exception do begin
      if wbHasProgressCallback then
        wbProgressCallback('Error getting position for "' + GetName + '": ' + E.Message);
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function TwbMainRecord.GetPrevEntry: IwbMainRecordEntry;
begin
  Assert(mreHeader.mrehInUse);
  if mreGeneration = mreHeader.mrehGeneration then
    Result := IwbMainRecordEntry(mrePrev)
  else
    Result := nil;
end;

function TwbMainRecord.GetPath: string;
begin
  Result := mrStruct.mrsSignature;
end;

function TwbMainRecord.GetCountedRecordCount: Cardinal;
begin
  Result := 1;
end;

function TwbMainRecord.GetReferencedBy(aIndex: Integer): IwbMainRecord;
begin
  if Assigned(mrMaster) then
    Exit(IwbMainRecord(mrMaster).ReferencedBy[aIndex]);

{$IFDEF USE_PARALLEL_BUILD_REFS}
  //Assert(not wbBuildingRefsParallel);
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}
  if mrsReferencedByUnsorted in mrStates then
    SortReferencedBy;
  Result := mrReferencedBy[aIndex];
{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

function TwbMainRecord.GetReferencedByCount: Integer;
begin
  if Assigned(mrMaster) then
    Exit(IwbMainRecord(mrMaster).ReferencedByCount);

{$IFDEF USE_PARALLEL_BUILD_REFS}
  //Assert(not wbBuildingRefsParallel);
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}
  Result := mrReferencedByCount;
{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

function TwbMainRecord.GetReferenceFile: IwbFile;
begin
  Result := GetFile;
  if Assigned(Result) then
    Result := Result.GetMasterForFileID(GetFormID.FileID, GetMastersUpdated, True);
end;

function TwbMainRecord.GetReference(aIndex: Integer): IwbMainRecord;
begin
  Result := nil;
  var _File := GetFile;
  if Assigned(_File) then
    Result := _File.RecordByFormID[mrReferences[aIndex], True, GetMastersUpdated];
end;

function TwbMainRecord.GetReferencesCount: Integer;
begin
  Result := Length(mrReferences);
end;

function TwbMainRecord.GetReferencesInjected: Boolean;
var
  i, j    : Integer;
  _File   : IwbFile;
  RecFile : IwbFile;
  Rec     : IwbMainRecord;
  Found   : Boolean;
begin
  if not (mrsReferencesInjectedChecked in mrStates) and (csRefsBuild in cntStates) then try
    if cntRefsBuildAt < eGeneration then
      BuildRef;

    Include(mrStates, mrsReferencesInjectedChecked);
    Exclude(mrStates, mrsReferencesInjected);
    if Length(mrReferences) > 0 then begin
      _File := GetFile;
      for i := Low(mrReferences) to High(mrReferences) do begin
        Rec := _File.RecordByFormID[mrReferences[i], True, GetMastersUpdated];
        if Assigned(Rec) then begin
          RecFile := Rec._File;
          if not _File.Equals(RecFile) then begin
            Rec := Rec.MasterOrSelf;
            if Rec.IsInjected then begin
              Found := False;
              for j := 0 to Pred(_File.MasterCount[GetMastersUpdated]) do
                if _File.Masters[j, GetMastersUpdated].Equals(RecFile) then begin
                  Found := True;
                  Break;
                end;
              if not Found then begin
                Include(mrStates, mrsReferencesInjected);
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      if wbHasProgressCallback then
        wbProgress('<[%s] Error in GetReferencesInjected: [%s] %s>', [GetShortName, E.ClassName, E.Message]);
    end;
  end;
  Result := mrsReferencesInjected in mrStates;
end;

function TwbMainRecord.GetRotation(out aRotation: TwbVector): Boolean;
var
  Signature : TwbSignature;
  SelfRef   : IwbContainerElementRef;
  DataRec   : IwbContainerElementRef;
begin
  Result := False;

  Signature := GetSignature;
  if (Signature <> 'REFR') and
     (Signature <> 'ACRE') and
     (Signature <> 'ACHR') and
     (Signature <> 'PGRE') and
     (Signature <> 'PMIS') and
     (Signature <> 'PARW') and {>>> Skyrim <<<}
     (Signature <> 'PBEA') and {>>> Skyrim <<<}
     (Signature <> 'PFLA') and {>>> Skyrim <<<}
     (Signature <> 'PCON') and {>>> Skyrim <<<}
     (Signature <> 'PBAR') and {>>> Skyrim <<<}
     (Signature <> 'PHZD')     {>>> Skyrim <<<}
  then
    Exit;

  SelfRef := Self;
  DoInit(False);

  if not Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, DataRec) then
    Exit;

  if DataRec.ElementCount <> 2 then
    Exit;

  with aRotation, (DataRec.Elements[1] as IwbContainerElementRef) do begin
    if ElementCount <> 3 then
      Exit;

    X := StrToFloatDef(Elements[0].Value, 0);
    Y := StrToFloatDef(Elements[1].Value, 0);
    Z := StrToFloatDef(Elements[2].Value, 0);
  end;
  Result := True;
end;

function TwbMainRecord.GetScale(out aScale: Single): Boolean;
var
  Signature : TwbSignature;
  SelfRef   : IwbContainerElementRef;
  XSclRec   : IwbContainerElementRef;
begin
  Result := False;
  aScale := 1;

  Signature := GetSignature;
  if (Signature <> 'REFR') and
     (Signature <> 'ACRE') and
     (Signature <> 'ACHR') and
     (Signature <> 'PGRE') and
     (Signature <> 'PMIS') and
     (Signature <> 'PARW') and {>>> Skyrim <<<}
     (Signature <> 'PBEA') and {>>> Skyrim <<<}
     (Signature <> 'PFLA') and {>>> Skyrim <<<}
     (Signature <> 'PCON') and {>>> Skyrim <<<}
     (Signature <> 'PBAR') and {>>> Skyrim <<<}
     (Signature <> 'PHZD')     {>>> Skyrim <<<}
  then
    Exit;

  SelfRef := Self;
  DoInit(False);

  if not Supports(GetRecordBySignature('XSCL'), IwbContainerElementRef, XSclRec) then
    Exit;

  aScale := StrToFloatDef(XSclRec.Value, 0);
  Result := True;
end;

function TwbMainRecord.GetSortKeyInternal(aExtended: Boolean): string;
begin
  Result := GetFormID.ToString(False)
end;

function TwbMainRecord.GetSortPriority: Integer;
begin
  if (GetSignature = 'ROAD') or (GetSignature = 'LAND') then
    Result := -2
  else if (GetSignature = 'CELL') or (GetSignature = 'PGRD') or (GetSignature = 'NAVM') then
    Result := -1
  else
    Result := 0;
end;

function TwbMainRecord.GetSummary: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := '';
  if Assigned(mrDef) then begin
    eSummaryLinksTo := nil;
    Result := mrDef.ToSummary(0, Self, eSummaryLinksTo);
  end;
end;

function TwbMainRecord.GetValue: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := '';
end;

function TwbMainRecord.GetWinningOverride: IwbMainRecord;
begin
  if Assigned(mrMaster) then
    Exit(IwbMainRecord(mrMaster).WinningOverride);

  for var lIndex := High(mrOverrides) downto Low(mrOverrides) do begin
    var lOverride := mrOverrides[lIndex];
    if not lOverride.IsPartialForm then
      Exit(lOverride);
  end;

  Result := Self;
end;

procedure TwbMainRecord.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  Assert(False);
end;

procedure TwbMainRecord.InitDataPtr;
var
  RecordDef : PwbMainRecordDef;
  p         : PwbMainRecordStruct;
begin
  if Assigned(dcEndPtr) then
    if (wbGameMode = gmTES3) and (PwbSignature(dcBasePtr)^ = 'FRMR') then begin
      Assert(not (mrsBasePtrAllocated in mrStates));
      dcDataBasePtr := dcBasePtr;
      dcDataEndPtr := dcEndPtr;
      New(p);
      FillChar(p^, SizeOf(TwbMainRecordStruct), 0);
      Include(mrStates, mrsBasePtrAllocated);
      p.mrsSignature := 'REFR';
      dcBasePtr := p;
      dcEndPtr := nil;
    end else begin
      dcDataBasePtr := PByte(dcBasePtr) + wbSizeOfMainRecordStruct;
      dcDataEndPtr := PByte(dcDataBasePtr) + mrStruct.mrsDataSize;
      dcEndPtr := dcDataEndPtr;
    end;

  if not Assigned(mrDef) then begin
    if wbFindRecordDef(PwbSignature(dcBasePtr)^, RecordDef) then
      mrDef := RecordDef^
    else begin
      if wbHasProgressCallback then
        wbProgressCallback('Error: unknown record type ' + String(PwbSignature(dcBasePtr)^));
    end;
  end;
end;

procedure TwbMainRecord.InsertEntryAfter(const aEntry: IwbMainRecordEntry);
var
  Entry: IwbMainRecordEntry;
begin
  Assert(Assigned(aEntry));
  RemoveEntry;
  Assert(mreGeneration = -1);
  with mreHeader do begin
    Assert(mrehInUse);
    mreGeneration := mrehGeneration;
    Entry := Self;
    mrePrev := Pointer(aEntry);
    mreNext := Pointer(aEntry.NextEntry);
    aEntry.NextEntry := Entry;
    if Assigned(mreNext) then begin
      Assert( aEntry.Equals(IwbMainRecordEntry(mreNext).PrevEntry) );
      IwbMainRecordEntry(mreNext).PrevEntry := Entry;
    end else begin
      Assert( aEntry.Equals(IwbMainRecordEntry(mrehTail)) );
      mrehTail := Pointer(Entry);
    end;
    Inc(mrehCount);
  end;
end;

procedure TwbMainRecord.InsertEntryHead;
var
  Entry: IwbMainRecordEntry;
begin
  RemoveEntry;
  Assert(mreGeneration = -1);
  with mreHeader do begin
    Assert(mrehInUse);
    mreGeneration := mrehGeneration;
    mrePrev := nil;
    mreNext := mrehHead;
    Entry := Self;
    mrehHead := Pointer(Entry);
    if Assigned(mreNext) then begin
      Assert(not Assigned(IwbMainRecordEntry(mreNext).PrevEntry));
      IwbMainRecordEntry(mreNext).PrevEntry := Entry
    end else begin
      Assert(not Assigned(mrehTail));
      mrehTail := Pointer(Entry);
    end;
    Inc(mrehCount);
  end;
end;

procedure TwbMainRecord.InsertEntryTail;
var
  Entry: IwbMainRecordEntry;
begin
  RemoveEntry;
  Assert(mreGeneration = -1);
  with mreHeader do begin
    Assert(mrehInUse);
    mreGeneration := mrehGeneration;
    mreNext := nil;
    mrePrev := mrehTail;
    Entry := Self;
    mrehTail := Pointer(Entry);
    if Assigned(mrePrev) then begin
      Assert(not Assigned(IwbMainRecordEntry(mrePrev).NextEntry));
      IwbMainRecordEntry(mrePrev).NextEntry := Entry
    end else begin
      Assert(not Assigned(mrehHead));
      mrehHead := Pointer(Entry);
    end;
    Inc(mrehCount);
  end;
end;

function TwbMainRecord.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement) and not aElement.Def.Required;
end;

function TwbMainRecord.IsSameData(aBase, aEnd: Pointer): Boolean;
var
  MySize: Int64;
  OtherSize: Int64;
  MyBase: PwbMainRecordStruct;
  OtherBase: PwbMainRecordStruct;
begin
  Result := False;
  if esModified in eStates then
    Exit;
  if not Assigned(aBase) then
    Exit;
  if not Assigned(aEnd) then
    Exit;
  if not Assigned(dcBasePtr) then
    Exit;
  if not Assigned(dcEndPtr) then
    Exit;

  MySize := NativeUInt(dcEndPtr) - NativeUInt(dcBasePtr);
  OtherSize := NativeUInt(aEnd) - NativeUInt(aBase);

  if MySize <> OtherSize then
    Exit;

  MyBase := dcBasePtr;
  OtherBase := aBase;

  if MyBase^.mrsSignature <> OtherBase^.mrsSignature then
    Exit;
  if MyBase^.mrsDataSize <> OtherBase^.mrsDataSize then
    Exit;
  if MyBase^.mrsFlags._Flags <> OtherBase^.mrsFlags._Flags then
    Exit;
  if MyBase^.mrsFormID <> OtherBase^.mrsFormID then
    Exit;

  Inc(MyBase);
  Inc(OtherBase);
  Dec(MySize, SizeOf(TwbMainRecordStruct));

  Result := CompareMem(MyBase, OtherBase, MySize);
end;

function TwbMainRecord.LinksToParent: Boolean;
var
  Signature : TwbSignature;
  DATA      : IwbRecord;
  SelfPtr   : IwbContainerElementRef;
  s         : string;
begin
  Signature := GetSignature;

  if (Signature = 'CELL') then begin
    Result := True;
    SelfPtr := Self as IwbContainerElementRef;
    DATA := GetRecordBySignature('DATA');
    if Assigned(DATA) then begin
      s := DATA.EditValue;
      if (Length(s)>0) and (s[1]='1') then
        Result := False;
    end;
  end else
    Result :=
      (Signature = 'INFO') or
      (Signature = 'REFR') or
      (Signature = 'PGRE') or
      (Signature = 'PMIS') or
      (Signature = 'ACHR') or
      (Signature = 'ACRE') or
      (Signature = 'PGRD') or
      (Signature = 'PARW') or {>>> Skyrim <<<}
      (Signature = 'PBEA') or {>>> Skyrim <<<}
      (Signature = 'PFLA') or {>>> Skyrim <<<}
      (Signature = 'PCON') or {>>> Skyrim <<<}
      (Signature = 'PBAR') or {>>> Skyrim <<<}
      (Signature = 'PHZD') or {>>> Skyrim <<<}
      (Signature = 'NAVM') or
      (Signature = 'ROAD') or
      (Signature = 'LAND') or
      (wbVWDAsQuestChildren and ((Signature = 'DLBR') or (Signature = 'DIAL') or (Signature = 'SCEN')));
end;

procedure TwbMainRecord.LoadRefsFromStream(aStream: TStream; aLoadNames: Boolean);
var
  _File          : IwbFile;

  Files          : array of IwbFile;
  FilesCount     : Integer;

  FullFiles      : array of IwbFile;
  FullFilesCount : Integer;

  MediumFiles      : array of IwbFile;
  MediumFilesCount : Integer;

  LightFiles      : array of IwbFile;
  LightFilesCount : Integer;

  SelfIntf      : IwbMainRecord;

  procedure ProcessRef(aFormID: TwbFormID);
  begin
    var MainRecord: IwbMainRecord := nil;

    if wbComplexFileFileID then begin

      var lFileID := aFormID.FileID;
      var lFileIndex: Integer;

      if not lFileID.IsValid or (lFileID.IsFullSlot and (lFileID.FullSlot > lFileID.MaxFullSlot)) then
        Exit;

      if not Assigned(_File) then begin
        _File := GetFile;
        SelfIntf := Self as IwbMainRecord;
      end;

      case lFileID.ModuleType of

        mtLight: begin

          if LightFilesCount < 0 then begin
            LightFilesCount := _File.LightMasterCount[GetMastersUpdated];
            SetLength(LightFiles, Succ(LightFilesCount));
            LightFiles[LightFilesCount] := _File;
          end;

          lFileIndex := lFileID.LightSlot;
          if lFileIndex > LightFilesCount then
            lFileIndex := LightFilesCount;

          if not Assigned(LightFiles[lFileIndex]) then
            LightFiles[lFileIndex] := _File.LightMasters[lFileIndex, GetMastersUpdated];

          aFormID.FileID := LightFiles[lFileIndex].FileFileID[True];
          MainRecord := LightFiles[lFileIndex].RecordByFormID[aFormID, True, True];

        end;

        mtMedium: begin

          if MediumFilesCount < 0 then begin
            MediumFilesCount := _File.MediumMasterCount[GetMastersUpdated];
            SetLength(MediumFiles, Succ(MediumFilesCount));
            MediumFiles[MediumFilesCount] := _File;
          end;

          lFileIndex := lFileID.MediumSlot;

          if lFileIndex > MediumFilesCount then
            lFileIndex := MediumFilesCount;

          if not Assigned(MediumFiles[lFileIndex]) then
            MediumFiles[lFileIndex] := _File.MediumMasters[lFileIndex, GetMastersUpdated];

          aFormID.FileID := MediumFiles[lFileIndex].FileFileID[True];
          MainRecord := MediumFiles[lFileIndex].RecordByFormID[aFormID, True, True];

        end;

        mtFull: begin

          if FullFilesCount < 0 then begin
            FullFilesCount := _File.FullMasterCount[GetMastersUpdated];
            SetLength(FullFiles, Succ(FullFilesCount));
            FullFiles[FullFilesCount] := _File;
          end;

          lFileIndex := lFileID.FullSlot;
          if lFileIndex > FullFilesCount then
            lFileIndex := FullFilesCount;

          if not Assigned(FullFiles[lFileIndex]) then
            FullFiles[lFileIndex] := _File.FullMasters[lFileIndex, GetMastersUpdated];

          aFormID.FileID := FullFiles[lFileIndex].FileFileID[True];
          MainRecord := FullFiles[lFileIndex].RecordByFormID[aFormID, True, True];

        end;

      end;
    end else begin
      if not Assigned(_File) then begin
        _File := GetFile;
        FilesCount := _File.MasterCount[GetMastersUpdated];
        SetLength(Files, Succ(FilesCount));
        Files[FilesCount] := _File;
        SelfIntf := Self as IwbMainRecord;
      end;

      var FileID := aFormID.FileID.FullSlot;
      if FileID > FilesCount then
        FileID := FilesCount;

      if not Assigned(Files[FileID]) then
        Files[FileID] := _File.Masters[FileID, GetMastersUpdated];

      aFormID.FileID := Files[FileID].FileFileID[True];
      MainRecord := Files[FileID].RecordByFormID[aFormID, True, True];
    end;

    if Assigned(MainRecord) then
      MainRecord.AddReferencedBy(SelfIntf)
  end;

var
  lFormID: TwbFormID;
  i: Integer;
begin
  Assert(wbGameMode > gmTES3);

  Assert(Length(mrReferences)=0);
  aStream.Read(lFormID, SizeOf(TwbFormID));
  Assert(lFormID = mrStruct.mrsFormID^);
  aStream.Read(i, SizeOf(i));
  if i>0 then begin
    SetLength(mrReferences, i);
    aStream.Read(mrReferences[0], SizeOf(TwbFormID) * i);
  end;

  aStream.Read(i, SizeOf(i));
  SetLength(mrEditorID, i);
  if i>0 then
    aStream.Read(mrEditorID[1], SizeOf(Char) * i);
  Include(mrStates, mrsEditorIDFromCache);

  aStream.Read(i, SizeOf(i));
  SetLength(mrFullName, i);
  if i>0 then
    aStream.Read(mrFullName[1], SizeOf(Char) * i);
  Include(mrStates, mrsFullNameFromCache);

  aStream.Read(mrBaseRecordID, SizeOf(mrBaseRecordID));
  Include(mrStates, mrsBaseRecordChecked);

  mrStates := mrStates - [mrsGridCellChecked, mrsHasGridCell];
  var b : Boolean;
  aStream.ReadData(b);
  if b then begin
    Include(mrStates, mrsGridCellChecked);
    aStream.ReadData(b);
    if b then begin
      Include(mrStates, mrsHasGridCell);
      aStream.ReadData<TwbGridCell>(mrGridCell);
    end;
  end;

  if aLoadNames then begin
    (**)
    aStream.Read(i, SizeOf(i));
    SetLength(mrName, i);
    if i>0 then
      aStream.Read(mrName[1], SizeOf(Char) * i);
    (**)
    aStream.Read(i, SizeOf(i));
    SetLength(mrShortName, i);
    if i>0 then
      aStream.Read(mrShortName[1], SizeOf(Char) * i);
    (** )
    aStream.Read(i, SizeOf(i));
    SetLength(mrDisplayName, i);
    if i>0 then
      aStream.Read(mrDisplayName[1], SizeOf(Char) * i);
    (**)
  end;

  FullFilesCount := -1;
  MediumFilesCount := -1;
  LightFilesCount := -1;

  for i := Low(mrReferences) to High(mrReferences) do
    ProcessRef(mrReferences[i]);
  Include(cntStates, csRefsBuild);
  cntRefsBuildAt := eGeneration;
end;

procedure TwbMainRecord.MakeHeaderWriteable;
var
  p            : PwbMainRecordStruct;
  BasePtr      : Pointer;
  SelfPtr      : IwbContainerElementRef;
  RecordHeader : IwbElement;
begin
  SelfPtr := Self as IwbContainerElementRef;

  DoInit(True);

  SetModified(True);
  InvalidateParentStorage;

  if not (mrsBasePtrAllocated in mrStates) then begin
    New(p);
    Include(mrStates, mrsBasePtrAllocated);
    p^ := mrStruct^;
    dcBasePtr := p;
    dcEndPtr := nil;

    RecordHeader := GetElementBySortOrder( (-1) + GetAdditionalElementCount );
    if Assigned(RecordHeader) then begin
      BasePtr := p;
      RecordHeader.InformStorage(BasePtr, PByte(BasePtr) + wbSizeOfMainRecordStruct);
    end;
  end;

end;

procedure TwbMainRecord.MakePartialForm;
var
  SelfRef     : IwbContainerElementRef;
  BasePtr     : Pointer;
  GroupRecord : IwbGroupRecord;
begin
  if not GetCanBePartial then
    Exit;

  SelfRef := Self;
  DoInit(False);

  BeginUpdate;
  try
    var lEditorID := GetEditorID;

    SetModified(True);
    InvalidateStorage;
    ReleaseElements;

    MakeHeaderWriteable;
    GetFlagsPtr.SetDeleted(False);
    GetFlagsPtr.SetPartialForm(True);
    GetFlagsPtr.SetCompressed(False);

    if Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
      if wbCreateContainedIn and (GroupRecord.GroupType in [1, 4..10]) then
        with TwbContainedInElement.Create(Self) do begin
          _AddRef; _Release;
        end;
    GroupRecord := nil;

    BasePtr := dcBasePtr;
    with TwbRecordHeaderStruct.Create(Self, BasePtr, PByte(BasePtr) + wbSizeOfMainRecordStruct, mrDef.RecordHeaderStruct, '') do begin
      Include(dcFlags, dcfDontSave);
      SetSortOrder(-1);
      SetMemoryOrder(Low(Integer));
      _AddRef; _Release;
    end;

    if lEditorID <> '' then begin
      var lMemberIndex := mrDef.KnownSubRecordMemberIndex[ksrEditorID];
      if lMemberIndex >= 0 then begin
        var lBaseRecordElement := Assign(lMemberIndex, nil, False);
        if Assigned(lBaseRecordElement) then
          lBaseRecordElement.EditValue := lEditorID;
      end;
    end;

    CollapseStorage(nil, True);
  finally
    EndUpdate;
  end;
end;

procedure TwbMainRecord.MarkModifiedRecursive(const aElementTypes: TwbElementTypes);
var
  SelfRef : IwbContainerElementRef;
  Group   : IwbGroupRecord;
begin
  if not (GetElementType in aElementTypes) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  inherited;
  Group := GetChildGroup;
  if Assigned(Group) then
    Group.MarkModifiedRecursive(aElementTypes);
end;


function TwbMainRecord.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  KAR: IwbKeepAliveRoot;

  procedure Inner;
  var
    OldFormID     : TwbFormID;
    NewFormID     : TwbFormID;
    i             : Integer;
    RefsOutOfDate : Boolean;
    FoundOne      : Boolean;
    HeaderUpdated : Boolean;

    SelfRef       : IwbContainerElementRef;
    IsInternalEdit: Boolean;
  begin
    IsInternalEdit := wbBeginInternalEdit(True);
    try
      KAR := wbCreateKeepAliveRoot;

      BeginUpdate;
      try
        wbTick;

        mrBaseRecordID := TwbFormID.Null;
        Exclude(mrStates, mrsBaseRecordChecked);

        SelfRef := Self as IwbContainerElementRef;
        DoInit(False);

        RefsOutOfDate := cntRefsBuildAt < eGeneration;

        var lAllowHardcodedRangeUse := False;

        var lFile := GetFile;
        if Assigned(lFile) then
          lAllowHardcodedRangeUse := lFile.AllowHardcodedRangeUse;

        HeaderUpdated := False;
        OldFormID := GetFormID;
        if not OldFormID.IsNull then begin
          NewFormID := FixupFormID(OldFormID, aOld, aNew, aOldCount, aNewCount, lAllowHardcodedRangeUse);
          if OldFormID <> NewFormID then begin
            MakeHeaderWriteable;
            mrStruct.mrsFormID^ := NewFormID;
            mrFixedFormID := TwbFormID.Null;
            mrLoadOrderFormID := TwbFormID.Null;
            Exclude(mrStates, mrsIsInjectedChecked);
            HeaderUpdated := True;
          end;
        end;

        FoundOne := False;
        if csRefsBuild in cntStates then begin

          for i := Low(mrReferences) to High(mrReferences) do begin
            OldFormID := mrReferences[i];
            NewFormID := FixupFormID(OldFormID, aOld, aNew, aOldCount, aNewCount, lAllowHardcodedRangeUse);
            if OldFormID <> NewFormID then begin
              FoundOne := True;
              mrReferences[i] := NewFormID;
            end;
          end;

          if FoundOne then
            wbMergeSort32(@mrReferences[0], Length(mrReferences), CompareFormIDs );

          if RefsOutOfDate then
            FoundOne := True;

        end else
          FoundOne := True;

        SetMastersUpdated(True);

        if FoundOne then begin
          Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);
          Exclude(mrStates, mrsBaseRecordChecked);
          mrBaseRecordID := TwbFormID.Null;
        end;

        Result := Result or HeaderUpdated;
      finally
        EndUpdate;
      end;
    finally
      if IsInternalEdit then
        wbEndInternalEdit;
    end;
  end;

var
  WasModifed: Boolean;

begin
  Result := False;

  WasModifed := [esModified, esInternalModified] * eStates = [esModified];
  Inner;
  if not WasModifed and (esModified in eStates) then begin
    Include(eStates, esInternalModified);
    CollapseStorage(@KAR, False);
  end;
end;

function TwbMainRecord.MasterRecordsFromMasterFilesAndSelf: TDynMainRecords;
var
  Res     : TDynMainRecords;
  _File   : IwbFile;
  Master  : IwbMainRecord;
  i, j    : Integer;

  function AddRecord(const aRecord: IwbMainRecord): Boolean;
  var
    k       : Integer;
    RecFile : IwbFile;
  begin
    Result := Equals(aRecord);
    if not Result then begin
      RecFile := aRecord._File;

      Result := _File.Equals(RecFile);
      if not Result then
        for k := 0 to Pred(_File.MasterCount[True]) do begin
          Result := _File.Masters[k, True].Equals(RecFile);
          if Result then
            Break;
        end;
      if Result then
        Result := False
      else
        Exit;
    end;

    Res[i] := aRecord;
    Inc(i);
  end;

begin
  Result := nil;
  Res := nil;
  if Assigned(mrMaster) then begin
    _File := GetFile;
    if Assigned(_File) then begin
      Master := IwbMainRecord(mrMaster);
      SetLength(Res, Succ(Master.OverrideCount));
      i := 0;
      if not AddRecord(Master) then
        for j := 0 to Pred(Master.OverrideCount) do
          if AddRecord(Master.Overrides[j]) then
            break;
      SetLength(Res, i);
      if i> 0 then begin
        Result := Res;
        Exit;
      end;
    end;
  end;
  SetLength(Res, 1);
  Res[0] := Self;
  Result := Res;
end;

procedure TwbMainRecord.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  Assert(False);
end;

procedure TwbMainRecord.mrInvalidateNameCache;
var
  _File   : IwbFile;
  FULLRec : IwbElement;
begin
  _File := GetFile;
  if Assigned(_File) and _File.IsLocalized then begin
    Exclude(mrStates, mrsFullNameFromCache);
    mrFullName := '';
    mrName := '';
    mrShortName := '';
    mrDisplayName := '';
    if (mrsQuickInitDone in mrStates) or (csInitOnce in cntStates) then begin
      FULLRec := GetRecordBySignature(mrDef.KnownSubRecordSignatures[ksrFullName]);
      if Assigned(FULLRec) then
        mrFullName := FULLRec.EditValue;
    end;
  end;
  mrLGeneration := wbLocalizationHandler.Generation
end;

function TwbMainRecord.mrStruct: PwbMainRecordStruct;
begin
  Result := PwbMainRecordStruct(dcBasePtr);
end;

procedure TwbMainRecord.NotifyChangedInternal(aContainer: Pointer);
begin
  ResetConflict;
  inherited;
end;

procedure TwbMainRecord.PrepareSave;
var
  KAR: IwbKeepAliveRoot;

  procedure Inner;
  var
    _File       : IwbFile;
    GroupRecord : IwbGroupRecord;
  begin
    KAR := wbCreateKeepAliveRoot;

    if GetSignature = wbHeaderSignature then begin
      if not Supports(GetContainer, IwbFile, _File) then
        raise Exception.Create('File Header record "' + GetFullPath + '" must be contained directly in the file.');
      if not GetFormID.IsNull then
        raise Exception.Create('File Header record "' + GetFullPath + '" can not have a FormID.');
    end else begin
      if GetFormID.IsNull then
        raise Exception.Create('Record "' + GetFullPath + '" must have a FormID.');
      if not Supports(GetContainer, IwbGroupRecord, GroupRecord) then
        raise Exception.Create('Record "' + GetFullPath + '" is not contained in a group.');
      case GroupRecord.GroupType of
        0: begin {top level}
          if TwbSignature(GroupRecord.GroupLabel) <> GetSignature then
            raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);
        end;
        1: begin {World Children}
          if (GetSignature <> 'CELL') and (GetSignature <> 'ROAD') then
            raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);
        end;
        2, 4, 6: begin {interior and exterior block and cell children}
          raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);
        end;
        3, 5: begin {interior and exterior sub-block}
          if (GetSignature <> 'CELL') then
            raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);
        end;
        7: begin {topic children}
          if (GetSignature <> 'INFO') then
            raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);
        end;
        8, 10: begin {Persistent and Visible when Distant/Quest Children}
          if (GetSignature <> 'REFR') and
             (GetSignature <> 'ACHR') and
             (GetSignature <> 'ACRE') and
             (GetSignature <> 'PGRE') and
             (GetSignature <> 'PMIS') and
             (GetSignature <> 'PARW') and {>>> Skyrim <<<}
             (GetSignature <> 'PBEA') and {>>> Skyrim <<<}
             (GetSignature <> 'PFLA') and {>>> Skyrim <<<}
             (GetSignature <> 'PCON') and {>>> Skyrim <<<}
             (GetSignature <> 'PBAR') and {>>> Skyrim <<<}
             (GetSignature <> 'PHZD')     {>>> Skyrim <<<}
          then
            if not (wbVWDAsQuestChildren and ((GetSignature = 'DLBR') or (GetSignature = 'DIAL') or (GetSignature = 'SCEN'))) then
              raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);

          case GroupRecord.GroupType of
            8:begin
              if not mrStruct.mrsFlags.IsPersistent then
                raise Exception.Create('Record "' + GetFullPath + '" needs to have it''s Persistent flag set to be contained in ' + GroupRecord.Name);
            end;
            10: if not wbVWDAsQuestChildren then begin
              if not mrStruct.mrsFlags.IsVisibleWhenDistant then
                raise Exception.Create('Record "' + GetFullPath + '" needs to have it''s Visible when Distant flag set to be contained in ' + GroupRecord.Name);
              if mrStruct.mrsFlags.IsPersistent then
                raise Exception.Create('Record "' + GetFullPath + '" can not have it''s Persistent flag set to be contained in ' + GroupRecord.Name);
            end;
          end;
        end;
        9: begin {Temporary}
          if (GetSignature <> 'REFR') and
             (GetSignature <> 'ACHR') and
             (GetSignature <> 'ACRE') and
             (GetSignature <> 'LAND') and
             (GetSignature <> 'PGRD') and
             (GetSignature <> 'NAVM') and
             (GetSignature <> 'PGRE') and
             (GetSignature <> 'PMIS') and
             (GetSignature <> 'PARW') and {>>> Skyrim <<<}
             (GetSignature <> 'PBEA') and {>>> Skyrim <<<}
             (GetSignature <> 'PFLA') and {>>> Skyrim <<<}
             (GetSignature <> 'PCON') and {>>> Skyrim <<<}
             (GetSignature <> 'PBAR') and {>>> Skyrim <<<}
             (GetSignature <> 'PHZD')     {>>> Skyrim <<<}
          then
            raise Exception.Create('Record "' + GetFullPath + '" can not be contained in ' + GroupRecord.Name);
          if mrStruct.mrsFlags.IsPersistent then
            raise Exception.Create('Record "' + GetFullPath + '" can not have it''s Persistent flag set to be contained in ' + GroupRecord.Name);
          if mrStruct.mrsFlags.IsVisibleWhenDistant and not wbVWDInTemporary then
            raise Exception.Create('Record "' + GetFullPath + '" can not have it''s Visible when Distant flag set to be contained in ' + GroupRecord.Name);
        end;
      end;
    end;

    {
    if GetIsDeleted and (GetDataSize > 0) then begin
      GetDataSize;
      Delete;
    end;
    }

    if mrsOFSTRemoved in mrStates then begin
      GroupRecord := GetChildGroup;
      if Assigned(GroupRecord) then
        GroupRecord.MarkModifiedRecursive([etFile, etMainRecord, etGroupRecord]);
      Exclude(mrStates, mrsOFSTRemoved);
    end;

    //not needed for now
    inherited;
  end;

begin
  Inner;
  if Assigned(KAR) and KAR.IsRoot then begin
    KAR := nil;
    ResetLeafFirst;
  end;
end;

type
  PwbMainRecordCollector = ^TwbMainRecordCollector;
  TwbMainRecordCollector = record
    mrcMainRecords : TDynMainRecords;
  end;

var
  _Collector       : PwbMainRecordCollector;
  _IgnoreCollector : Boolean;

function TwbMainRecord.Reached: Boolean;
var
  Signature : TwbSignature;
  i, j      : Integer;
  IsComplex : Boolean;
  SelfRef   : IwbContainerElementRef;
  Collector : TwbMainRecordCollector;
  RefRecord : IwbMainRecord;
  MainRecord: IwbMainRecord;
  Master    : IwbMainRecord;
  Keywords  : IwbContainerElementRef;
begin
  wbTick;

  if esReachable in eStates then
    Exit(False);

  if _IgnoreCollector then
    _IgnoreCollector := False
  else if Assigned(_Collector) then begin
    _Collector.mrcMainRecords.Add(Self);
    Exit(False);
  end;

  if not Assigned(_Collector) then
    _Collector := @Collector;

  try
    SelfRef := Self as IwbContainerElementRef;
    DoInit(False);

    Signature := GetSignature;
    IsComplex := (Signature = 'DIAL') or (Signature = 'WRLD') or (Signature = 'CELL') or (Signature = 'DOBJ');
    if GetIsWinningOverride or IsComplex then begin
      Result := inherited Reached;

      if Result then begin
        if Assigned(eContainer) then begin

          if (Signature = 'SMBN') or (Signature = 'SMQN') or (Signature = 'SMEN') then begin
            Master := GetMasterOrSelf;
            for i := 0 to Pred(Master.ReferencedByCount) do begin
              RefRecord := Master.ReferencedBy[i];
              Signature := RefRecord.Signature;
              if (Signature = 'SMBN') or (Signature = 'SMQN') or (Signature = 'SMEN') then
                if Supports(RefRecord.ElementLinksTo['PNAM'], IwbMainRecord, MainRecord) then
                  if MainRecord.LoadOrderFormID = GetLoadOrderFormID then
                    (RefRecord as IwbElementInternal).Reached;
            end;
          end else if Signature = 'FURN' then begin
            if wbGameMode >= gmTES5 then begin
              if GetElementNativeValue('WBDT\Bench Type') > 0 then
                if Supports(GetElementByPath('KWDA - Keywords'), IwbContainerElementRef, Keywords) then
                  for i := 0 to Pred(Keywords.ElementCount) do
                    if Supports(Keywords.Elements[i].LinksTo, IwbMainRecord, MainRecord) then begin
                      Master := MainRecord.MasterOrSelf;
                      for j := 0 to Pred(Master.ReferencedByCount) do begin
                        RefRecord := Master.ReferencedBy[j];
                        Signature := RefRecord.Signature;
                        if Signature = 'COBJ' then
                          if Supports(RefRecord.ElementLinksTo['BNAM'], IwbMainRecord, MainRecord) then
                            if MainRecord.LoadOrderFormID = Master.LoadOrderFormID then
                             (RefRecord as IwbElementInternal).Reached;
                      end;
                    end;
            end;
          end else if Signature = 'NPC_' then begin
            if wbGameMode >= gmTES5 then begin
              Master := GetMasterOrSelf;
              for i := 0 to Pred(Master.ReferencedByCount) do begin
                RefRecord := Master.ReferencedBy[i];
                Signature := RefRecord.Signature;
                if Signature = 'RELA' then
                  (RefRecord as IwbElementInternal).Reached;
              end;
            end;
          end else if Signature = 'QUST' then begin
            if wbGameMode >= gmTES5 then begin
              Master := GetMasterOrSelf;
              for i := 0 to Pred(Master.ReferencedByCount) do begin
                RefRecord := Master.ReferencedBy[i];
                Signature := RefRecord.Signature;
                if Signature = 'SCEN' then begin
                  if Supports(RefRecord.ElementLinksTo['PNAM'], IwbMainRecord, MainRecord) then
                    if MainRecord.LoadOrderFormID = GetLoadOrderFormID then
                      (RefRecord as IwbElementInternal).Reached;
                end else if Signature = 'DLBR' then begin
                  if Supports(RefRecord.ElementLinksTo['QNAM'], IwbMainRecord, MainRecord) then
                    if MainRecord.LoadOrderFormID = GetLoadOrderFormID then begin
                      if RefRecord.ElementNativeValues['DNAM'] > 0 then
                        (RefRecord as IwbElementInternal).Reached;
                    end;
                end else if Signature = 'DIAL' then begin
                  if Supports(RefRecord.ElementLinksTo['QNAM'], IwbMainRecord, MainRecord) then
                    if MainRecord.LoadOrderFormID = GetLoadOrderFormID then begin
                      if Int64(RefRecord.GetElementNativeValue('DATA\Category')) in [3, 4, 5, 7] then
                        (RefRecord as IwbElementInternal).Reached;
                    end;
                end;
              end;
            end;
          end;

          if not LinksToParent then begin
            if IsComplex then begin
              if Assigned(mrMaster) then
                (IwbMainRecord(mrMaster) as IwbElementInternal).Reached
              else
                for i := 0 to Pred(GetOverrideCount) do
                  (GetOverride(i) as IwbElementInternal).Reached;

              if Assigned(mrGroup) or (GetChildGroup <> nil) then
                (mrGroup as IwbElementInternal).Reached;
            end;
          end;
        end;
      end;
    end else
      Result := (GetWinningOverride as IwbElementInternal).Reached;

    i := 0;
    while i <= High(Collector.mrcMainRecords) do begin
      _IgnoreCollector := True;
      (Collector.mrcMainRecords[i] as IwbElementInternal).Reached;
      Inc(i);
    end;
  finally
    if _Collector = @Collector then
      _Collector := nil;
  end;
end;

procedure TwbMainRecord.Remove;
var
  _File: IwbFileInternal;
begin
  DoBuildRef(True);

  _File := GetFile as IwbFileInternal;
  if Assigned(_File) then
    _File.RemoveMainRecord(Self);

  var lMaster := IwbMainRecord(mrMaster);
  if Assigned(lMaster) then
    (lMaster as IwbMainRecordInternal).RemoveOverride(Self)
  else
    if Length(mrOverrides) > 0 then begin
      lMaster := mrOverrides[0];
      (lMaster as IwbMainRecordInternal).YouAreTheMaster(mrOverrides, mrReferencedBy, mrReferencedByCount);
    end;

  mrMaster := nil;
  mrOverrides := nil;
  mrReferencedBy := nil;
  mrReferencedByCount := 0;
  mrReferencedBySize := 0;
  mrFixedFormID := TwbFormID.Null;
  mrLoadOrderFormID := TwbFormID.Null;
  Exclude(mrStates, mrsIsInjectedChecked);
  mrConflictAll := caUnknown;
  mrConflictThis := ctUnknown;

  if Assigned(lMaster) then
    lMaster.ResetConflict;

  inherited;
end;

procedure TwbMainRecord.RemoveChildGroup(const aGroup: IwbGroupRecord);
begin
  if (Assigned(mrGroup) or (GetChildGroup <> nil)) and mrGroup.Equals(aGroup) then begin
    mrGroup := nil;
    mrGroupSearchGen := -1;
  end;
end;

function TwbMainRecord.RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement;
begin
  Result := inherited RemoveElement(aPos, aMarkModified);
  if aMarkModified then
    if Assigned(Result) and (Result.ElementType = etSubRecord) then begin
      var SubRecord : IwbSubRecord;
      if Supports(Result, IwbSubRecord, SubRecord) then begin
        var NotRelevant := False;
        if SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrEditorID] then begin
          mrEditorID := '';
          Exclude(mrStates, mrsEditorIDFromCache);
        end else if SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrFullName] then begin
          mrFullName := '';
          Exclude(mrStates, mrsFullNameFromCache);
        end else if SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrBaseRecord] then
          Exclude(mrStates, mrsBaseRecordChecked)
        else if (SubRecord.Signature = mrDef.KnownSubRecordSignatures[ksrGridCell]) and (SubRecord.Container.Equals(Self)) then begin
          Exclude(mrStates, mrsHasGridCell);
          Include(mrStates, mrsGridCellChecked);
        end else
          NotRelevant := True;
        if not NotRelevant then begin
          (GetFile as IwbFileInternal).IncGeneration;
          mrName := '';
          mrShortName := '';
          mrDisplayName := '';
        end;
      end;
    end;
end;

procedure TwbMainRecord.RemoveEntry;
var
  Entry : IwbMainRecordEntry;
  i     : Integer;
begin
  if Supports(IInterface(mrMaster), IwbMainRecordEntry, Entry) then
    Entry.RemoveEntry
  else begin
    RemoveEntryInternal;
    for i := Low(mrOverrides) to High(mrOverrides) do
    if Supports(mrOverrides[i], IwbMainRecordEntry, Entry) then
      Entry.RemoveEntryInternal;
  end;
end;

procedure TwbMainRecord.RemoveEntryInternal;
begin
  with mreHeader do begin
    Assert(mrehInUse);
    if mreGeneration = mrehGeneration then begin
      if Assigned(mrePrev) then
        IwbMainRecordEntry(mrePrev).NextEntry := IwbMainRecordEntry(mreNext)
      else begin
        Assert(Equals(IwbMainRecordEntry(mrehHead)));
        mrehHead := mreNext;
      end;

      if Assigned(mreNext) then
        IwbMainRecordEntry(mreNext).PrevEntry := IwbMainRecordEntry(mrePrev)
      else begin
        Assert(Equals(IwbMainRecordEntry(mrehTail)));
        mrehTail := mrePrev;
      end;
      Dec(mrehCount);
    end;
    mrePrev := nil;
    mreNext := nil;
    mreGeneration := -1;
  end;
end;

function TwbMainRecord.RemoveInjected(aCanRemove: Boolean): Boolean;
var
  i         : Integer;
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Result := False;
  if GetReferencesInjected then begin
    if GetSignature = 'SCPT' then begin
      Element := GetElementByName('References');
      if Assigned(Element) then
        Element.Remove;
      Element := GetRecordBySignature('SCDA');
      if Assigned(Element) then
        Element.EditValue := '1D 00 00 00';
      Element := GetRecordBySignature('SCHR');
      if Assigned(Element) then with (Element as IwbContainerElementRef) do begin
        ElementByName['RefCount'].EditValue := '0';
        ElementByName['CompiledSize'].EditValue := '4';
      end;
      Element := GetRecordBySignature('SCTX');
      if Assigned(Element) then
        with TStringList.Create do try
          Text := Element.EditValue;
          for i := 0 to Pred(Count) do
            if StartsWith(Trim(Strings[i]), 'begin') then begin
              while i <= Count do
                Delete(Pred(Count));
              Break;
            end;
          Element.EditValue := Text;
        finally
          Free;
        end;
    end else begin
      for i := High(cntElements) downto Low(cntElements) do
        if cntElements[i].CanContainFormIDs then begin
          Result := cntElements[i].RemoveInjected(True) or Result;
          if Result and aCanRemove then
            Break;
        end;
    end;
  end;
  Exclude(mrStates, mrsReferencesInjectedChecked);
  if Result and aCanRemove and GetIsRemovable then begin
    Result := False;
    Remove;
  end;
end;

procedure TwbMainRecord.RemoveOverride(const aMainRecord: IwbMainRecord);
var
  i,j: Integer;
begin
  j := 0;
  for i := Low(mrOverrides) to High(mrOverrides) do begin
    if (mrOverrides[i] as IwbElement) <> (aMainRecord as IwbElement) then begin
      if i <> j then
        mrOverrides[j] := mrOverrides[i];
      Inc(j);
    end;
  end;
  SetLength(mrOverrides, j);
  mrMasterAndLeafs := nil;
  ResetConflict;
end;

procedure TwbMainRecord.RemoveReferencedBy(const aMainRecord: IwbMainRecord);
var
  i: Integer;
begin
  if Assigned(mrMaster) then begin
    IwbMainRecord(mrMasteR).RemoveReferencedBy(aMainRecord);
    Exit;
  end;
{$IFDEF USE_PARALLEL_BUILD_REFS}
  //Assert(not wbBuildingRefsParallel);
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}
  if mrsReferencedByUnsorted in mrStates then
    SortReferencedBy;

  if FindReferencedBy(aMainRecord, i) then begin
    mrReferencedBy[i] := nil;
    if i < Pred(mrReferencedByCount) then begin
      Move(mrReferencedBy[Succ(i)], mrReferencedBy[i], SizeOf(Pointer) * (Pred(mrReferencedByCount) - i));
      Pointer(mrReferencedBy[Pred(mrReferencedByCount)]) := nil;
    end;
    Dec(mrReferencedByCount);
    if mrReferencedByCount < 1 then begin
      mrReferencedBy := nil;
      mrReferencedBySize := 0;
    end;
  end;
{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

procedure TwbMainRecord.ReportRequiredMasters(aDict: TwbFilesDictionary; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false);
begin
  var lFile := GetFile;
  if Assigned(lFile) and ([fsIsHardcoded, fsIsGameMaster] * lFile.FileStates <> []) then begin
    aDict.TryAdd(lFile, wbNothing);
    Exit;
  end;

  if not aAsNew then begin
    var lRefFile := GetReferenceFile;
    if Assigned(lRefFile) then
      aDict.TryAdd(lRefFile, wbNothing);
  end;

  inherited;
end;

procedure TwbMainRecord.Reset;
begin
  ReleaseElements;
  mrDataStorage := nil;
  InitDataPtr;
  inherited Reset;
end;

procedure TwbMainRecord.ResetConflict;
var
  i: Integer;
begin
  if mrsResettingConflict in mrStates then
    Exit;
  Include(mrStates, mrsResettingConflict);
  try
    inherited;
    if (mrConflictAll <> caUnknown) or (mrConflictThis <> ctUnknown) then begin
      mrConflictAll := caUnknown;
      mrConflictThis := ctUnknown;
      Inc(eGeneration);
      Inc(_GlobalGeneration);
    end;
    if Assigned(mrMaster) then
      IwbElement(mrMaster).ResetConflict
    else
      for i := Low(mrOverrides) to High(mrOverrides) do
        mrOverrides[i].ResetConflict;
  finally
    Exclude(mrStates, mrsResettingConflict);
  end;
end;

procedure TwbMainRecord.ResetReachable;
begin
  Include(eStates, esNotReachable);
  Exclude(eStates, esReachable);
end;

function TwbMainRecord.ResolveElementName(aName: string; out aRemainingName: string; aCanCreate: Boolean): IwbElement;
var
  i: Integer;
begin
  Result := inherited ResolveElementName(aName, aRemainingName, aCanCreate);
  if not Assigned(Result) and aCanCreate and Assigned(mrDef) and (Length(aName) = 4) then begin
    i := mrDef.GetMemberIndexFor(Self, StrToSignature(aName), nil);
    if i < 0 then
      Exit;
    Assign(i, nil, False);
    Result := GetElementBySignature(StrToSignature(aName));
  end;
end;

procedure TwbMainRecord.SaveRefsToStream(aStream: TStream; aSaveNames: Boolean);
var
  i            : Integer;
begin
  Assert(wbGameMode > gmTES3);

  aStream.Write(mrStruct.mrsFormID^, SizeOf(TwbFormID));

  i := Length(mrReferences);
  aStream.Write(i, SizeOf(i));
  if i>0 then
    aStream.Write(mrReferences[0], SizeOf(TwbFormID) * i);

  i := Length(GetEditorID);
  aStream.Write(i, SizeOf(i));
  if i>0 then
    aStream.Write(mrEditorID[1], SizeOf(Char) * i);

  i := Length(GetFullName);
  aStream.Write(i, SizeOf(i));
  if i>0 then
    aStream.Write(mrFullName[1], SizeOf(Char) * i);

  GetBaseRecord;
  aStream.Write(mrBaseRecordID, SizeOf(mrBaseRecordID));

  var b : Boolean := mrsGridCellChecked in mrStates;
  aStream.WriteData(b);
  if b then begin
    b := mrsHasGridCell in mrStates;
    aStream.WriteData(b);
    if b then
      aStream.WriteData<TwbGridCell>(mrGridCell);
  end;

  if aSaveNames then begin
    (**)
    if mrEditorID <> '' then
      i := Length(GetName)
    else
      i := 0;
    aStream.Write(i, SizeOf(i));
    if i>0 then
      aStream.Write(mrName[1], SizeOf(Char) * i);
    (**)
    if mrEditorID <> '' then
      i := Length(GetShortName)
    else
      i := 0;
    aStream.Write(i, SizeOf(i));
    if i>0 then
      aStream.Write(mrShortName[1], SizeOf(Char) * i);
    (** )
    i := Length(GetDisplayName);
    aStream.Write(i, SizeOf(i));
    if i>0 then
      aStream.Write(mrDisplayName[1], SizeOf(Char) * i);
    (**)
  end;
end;

procedure TwbMainRecord.ScanData;
var
  SelfRef : IwbContainerElementRef;
begin
  if (not wbDelayLoadRecords) or ((wbGameMode = gmTES3) and ((GetSignature = 'CELL') or (GetSignature = 'REFR')) ) then begin
    SelfRef := Self as IwbContainerElementRef;
    DoInit(True);
  end;
end;

procedure TwbMainRecord.SetChildGroup(const aGroup: IwbGroupRecord);
begin
  if Pointer(mrGroup) = Pointer(aGroup) then
    Exit;

  if Assigned(aGroup) then begin
    if not (not Assigned(mrGroup) or (mrGroup.Equals(aGroup))) then begin
      (aGroup as IwbGroupRecordInternal).IsDuplicateOf(mrGroup);
      wbProgress('<Error: Found additional ' + mrGroup.Name + ' for ' + Self.GetName + '>');
      Exit;
    end;
    if Assigned(eContainer) then
      if not IwbContainer(eContainer).Equals(aGroup.Container) then begin
        wbProgress('<Error: Group "' + aGroup.Name + '" has not the same container as record "' + Self.GetName + '">');
        Exit;
      end;
  end else
    Assert(Assigned(mrGroup));

  mrGroup := aGroup;
end;

procedure TwbMainRecord.SetConflictAll(aValue: TConflictAll);
begin
  mrConflictAll := aValue;
end;

procedure TwbMainRecord.SetConflictThis(aValue: TConflictThis);
begin
  mrConflictThis := aValue;
end;

procedure TwbMainRecord.SetContainer(const aContainer: IwbContainer);
begin
  inherited;
  ContainerChanged;
end;

procedure TwbMainRecord.SetEditorID(const aValue: string);
var
  SelfRef : IwbContainerElementRef;
  Rec     : IwbRecord;
  i       : Integer;
begin
  if not Assigned(mrDef) then
    Exit;

  if aValue = GetEditorID then
    Exit;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  Rec := GetRecordBySignature(mrDef.KnownSubRecordSignatures[ksrEditorID]);
  if not Assigned(Rec) then begin
    i := mrDef.GetMemberIndexFor(Self, mrDef.KnownSubRecordSignatures[ksrEditorID], nil);
    if i < 0 then
      Exit;
    Assign(i, nil, False);
    Rec := GetRecordBySignature(mrDef.KnownSubRecordSignatures[ksrEditorID]);
    Assert(Assigned(Rec));
  end;

  mrDef.SetEditorID(Rec as IwbSubRecord, aValue);

  Assert(mrEditorID = aValue);
end;

procedure TwbMainRecord.SetEditValue(const aValue: string);
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
    if dfInternalEditOnly in mrDef.DefFlags then
      Exit;
  end;

  if wbDisplayLoadOrderFormID then begin
    SetLoadOrderFormID(TwbFormID.FromStr(aValue));
    NotifyChanged(eContainer);
  end else
    raise Exception.Create('FormID can only be edited if wbDisplayLoadOrderFormID is active');
end;

procedure TwbMainRecord.SetIsCompressed(aValue: Boolean);
begin
  if aValue <> GetIsCompressed then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetCompressed(aValue);
  end;
end;

procedure TwbMainRecord.SetIsDeleted(aValue: Boolean);
var
  SelfRef     : IwbContainerElementRef;
  i, j        : Integer;
  BasePtr     : Pointer;
  GroupRecord : IwbGroupRecord;
  Master      : IwbMainRecord;
  MainRecord  : IwbMainRecord;
  SelfIndex   : Integer;
  _File       : IwbFile;
begin
  if aValue <> GetIsDeleted then begin
    if aValue then
      Delete
    else begin
      SelfRef := Self;
      DoInit(False);

      SetModified(True);
      InvalidateStorage;
      ReleaseElements;

      MakeHeaderWriteable;
      GetFlagsPtr.SetDeleted(False);

      if Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
        if wbCreateContainedIn and (GroupRecord.GroupType in [1, 4..10]) then
          with TwbContainedInElement.Create(Self) do begin
            _AddRef; _Release;
          end;
      GroupRecord := nil;

      BasePtr := dcBasePtr;
      with TwbRecordHeaderStruct.Create(Self, BasePtr, PByte(BasePtr) + wbSizeOfMainRecordStruct, mrDef.RecordHeaderStruct, '') do begin
        Include(dcFlags, dcfDontSave);
        SetSortOrder(-1);
        SetMemoryOrder(Low(Integer));
        _AddRef; _Release;
      end;

      BeginUpdate;
      try
        for i := 0 to Pred(mrDef.MemberCount) do
          if mrDef.Members[i].Required then
            Assign(i, nil, False);

        Master := GetMaster;

        if not Assigned(Master) then
          Exit;

        _File := GetFile;

        SelfIndex := -1;
        for i := 0 to Pred(Master.OverrideCount) do
          if Equals(Master.Overrides[i]) then begin
            SelfIndex := i;
            Break;
          end;

        for i := Pred(SelfIndex) downto 0 do begin
          MainRecord := Master.Overrides[i];
          if not (MainRecord.IsDeleted or MainRecord.IsPartialForm) then begin
            for j := Pred(_File.MasterCount[True]) downto 0 do
              if MainRecord._File.Equals(_File.Masters[j, True]) then begin
                Self.Assign(wbAssignThis, MainRecord, False);
                Exit;
              end;
          end;
        end;

        if not (Master.IsDeleted or Master.IsPartialForm) then
          Self.Assign(wbAssignThis, Master, False);
      finally
        EndUpdate;
      end;

    end;
  end;
end;

procedure TwbMainRecord.SetIsMedium(aValue: Boolean);
begin
  if aValue <> GetIsMedium then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetMedium(aValue);
  end;
end;

procedure TwbMainRecord.SetIsLight(aValue: Boolean);
begin
  if aValue <> GetIsLight then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetLight(aValue);
  end;
end;

procedure TwbMainRecord.SetIsOverlay(aValue: Boolean);
begin
  if aValue <> GetIsOverlay then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetOverlay(aValue);
  end;
end;

procedure TwbMainRecord.SetIsESM(aValue: Boolean);
begin
  if aValue <> GetIsESM then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetESM(aValue);
  end;
end;

procedure TwbMainRecord.SetIsLocalized(aValue: Boolean);
begin
  if aValue <> GetIsLocalized then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetLocalized(aValue);
  end;
end;

procedure TwbMainRecord.SetIsInitiallyDisabled(aValue: Boolean);
begin
  if aValue <> GetIsInitiallyDisabled then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetInitiallyDisabled(aValue);
  end;
end;

procedure TwbMainRecord.SetIsPartialForm(aValue: Boolean);
var
  SelfRef     : IwbContainerElementRef;
  i, j        : Integer;
  BasePtr     : Pointer;
  GroupRecord : IwbGroupRecord;
  Master      : IwbMainRecord;
  MainRecord  : IwbMainRecord;
  SelfIndex   : Integer;
  _File       : IwbFile;
begin
  if not GetCanBePartial then
    aValue := False;

  if aValue <> GetIsPartialForm then begin
    SetIsDeleted(False);
    if aValue then
      MakePartialForm
    else begin
      SelfRef := Self;
      DoInit(False);

      SetModified(True);
      InvalidateStorage;
      ReleaseElements;

      MakeHeaderWriteable;
      GetFlagsPtr.SetPartialForm(False);

      if Supports(Self.GetContainer, IwbGroupRecord, GroupRecord) then
        if wbCreateContainedIn and (GroupRecord.GroupType in [1, 4..10]) then
          with TwbContainedInElement.Create(Self) do begin
            _AddRef; _Release;
          end;
      GroupRecord := nil;

      BasePtr := dcBasePtr;
      with TwbRecordHeaderStruct.Create(Self, BasePtr, PByte(BasePtr) + wbSizeOfMainRecordStruct, mrDef.RecordHeaderStruct, '') do begin
        Include(dcFlags, dcfDontSave);
        SetSortOrder(-1);
        SetMemoryOrder(Low(Integer));
        _AddRef; _Release;
      end;

      BeginUpdate;
      try
        for i := 0 to Pred(mrDef.MemberCount) do
          if mrDef.Members[i].Required then
            Assign(i, nil, False);

        Master := GetMaster;

        if not Assigned(Master) then
          Exit;

        _File := GetFile;

        SelfIndex := -1;
        for i := 0 to Pred(Master.OverrideCount) do
          if Equals(Master.Overrides[i]) then begin
            SelfIndex := i;
            Break;
          end;

        for i := Pred(SelfIndex) downto 0 do begin
          MainRecord := Master.Overrides[i];
          if not (MainRecord.IsDeleted or MainRecord.IsPartialForm) then begin
            for j := Pred(_File.MasterCount[True]) downto 0 do
              if MainRecord._File.Equals(_File.Masters[j, True]) then begin
                Self.Assign(wbAssignThis, MainRecord, False);
                Exit;
              end;
          end;
        end;

        if not (Master.IsDeleted or Master.IsPartialForm) then
          Self.Assign(wbAssignThis, Master, False);
      finally
        EndUpdate;
      end;
    end;
  end;
end;

procedure TwbMainRecord.SetIsPersistent(aValue: Boolean);
var
  NeedUpdate: Boolean;
begin
  if aValue <> GetIsPersistent then begin
    NeedUpdate := CheckChildOfCell;
    MakeHeaderWriteable;
    GetFlagsPtr.SetPersistent(aValue);
    if NeedUpdate then
      UpdateCellChildGroup;
  end;
end;

procedure TwbMainRecord.SetIsVisibleWhenDistant(aValue: Boolean);
var
  NeedUpdate: Boolean;
begin
  if aValue <> GetIsVisibleWhenDistant then begin
    NeedUpdate := CheckChildOfCell;
    MakeHeaderWriteable;
    GetFlagsPtr.SetVisibleWhenDistant(aValue);
    if NeedUpdate then
      UpdateCellChildGroup;
  end;
end;

procedure TwbMainRecord.SetLoadOrderFormID(aFormID: TwbFormID);
var
  _File      : IwbFileInternal;
  Master     : IwbMainRecord;
  FileFormID : TwbFormID;
begin
  if GetSignature = 'TES4' then
    aFormID := TwbFormID.Null;

  if GetLoadOrderFormID = aFormID then
    Exit;

  if wbGameMode = gmTES3 then begin
    Exit; //|||
  end else begin
    _File := GetFile as IwbFileInternal;

    if not Assigned(_File) then
      Exit;

    if (aFormID.ObjectID < $800) and not aFormID.IsHardcoded then begin
      if _File.MasterCount[GetMastersUpdated] < 1 then
        raise Exception.Create('Using FormID [' + aFormID.ToString(True) + '] requires "' + _File.Name + '" to have at least 1 master' );
    end;

    FileFormID := _File.LoadOrderFormIDtoFileFormID(aFormID, True);

    if GetFormID.ObjectID = FileFormID.ObjectID then
      if _File.IsNewRecord(GetFormID, GetMastersUpdated) and _File.IsNewRecord(FileFormID, GetMastersUpdated) then begin
        // we can do this relatively quietly and quickly...
        if Assigned(mrGroup) or (GetChildGroup <> nil)  then
          Assert(mrGroup.GroupLabel = GetFormID.ToCardinal);
        MakeHeaderWriteable;
        mrStruct.mrsFormID^ := FileFormID;
        mrFixedFormID := TwbFormID.Null;
        mrLoadOrderFormID := TwbFormID.Null;
        SetMastersUpdated(True);
        if Assigned(mrGroup) or (GetChildGroup <> nil)  then
          mrGroup.GroupLabel := FileFormID.ToCardinal;
        UpdateInteriorCellGroup;
        Exit;
      end;

    Master := _File.RecordByFormID[FileFormID, False, True];
    if Assigned(Master) and ((Master._File as IwbFileInternal).Equals(_File)) then
      raise Exception.Create('FormID [' + aFormID.ToString(True) + '] is already present in file ' + _File.Name);

    Master := _File.RecordByFormID[FileFormID, True, True];
    if Assigned(Master) then
      Master := Master.MasterOrSelf;

    _File.RemoveMainRecord(Self);

    if Assigned(mrMaster) then
      (IwbMainRecord(mrMaster) as IwbMainRecordInternal).RemoveOverride(Self)
    else
      if Length(mrOverrides) > 0 then
        (mrOverrides[0] as IwbMainRecordInternal).YouAreTheMaster(mrOverrides, mrReferencedBy, mrReferencedByCount);

    mrMaster := nil;
    mrOverrides := nil;
    mrReferencedBy := nil;
    mrReferencedByCount := 0;
    mrReferencedBySize := 0;
    Exclude(mrStates, mrsIsInjectedChecked);
    mrConflictAll := caUnknown;
    mrConflictThis := ctUnknown;

    if Assigned(mrGroup) or (GetChildGroup <> nil)  then
      Assert(mrGroup.GroupLabel = GetFormID.ToCardinal);
    MakeHeaderWriteable;
    mrStruct.mrsFormID^ := FileFormID;
    mrFixedFormID := TwbFormID.Null;
    mrLoadOrderFormID := TwbFormID.Null;
    Exclude(mrStates, mrsIsInjectedChecked);
    if Assigned(mrGroup) or (GetChildGroup <> nil)  then
      mrGroup.GroupLabel := FileFormID.ToCardinal;
    UpdateInteriorCellGroup;

    _File.AddMainRecord(Self);
  
    if Assigned(Master) and Master.IsInjected and not Assigned(mrMaster) then
      (Master as IwbMainRecordInternal).YouGotAMaster(Self);

    ResetConflict;
  end;
end;

procedure TwbMainRecord.SetMaster(const aMaster: IwbMainRecord);
begin
  mrMaster := Pointer(aMaster);
  if Assigned(mrMaster) then begin
    Include(mrStates, mrsIsInjectedChecked);
    Exclude(mrStates, mrsIsInjected);
  end else
    Exclude(mrStates, mrsIsInjectedChecked);
end;

procedure TwbMainRecord.SetModified(aValue: Boolean);
begin
  mrDisplayName := '';
  inherited;
end;

procedure TwbMainRecord.SetNativeValue(const aValue: Variant);
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
    if dfInternalEditOnly in mrDef.DefFlags then
      Exit;
  end;

  if wbDisplayLoadOrderFormID then begin
    SetLoadOrderFormID(TwbFormID.FromVar(aValue));
    NotifyChanged(eContainer);
  end else
    raise Exception.Create('FormID can only be edited if wbDisplayLoadOrderFormID is active');
end;

procedure TwbMainRecord.SetNextEntry(const aEntry: IwbMainRecordEntry);
begin
  Assert(mreHeader.mrehInUse);
  Assert(mreGeneration = mreHeader.mrehGeneration);
  mreNext := Pointer(aEntry);
end;

procedure TwbMainRecord.SetParentModified;
begin
  mrInvalidateNameCache;
  inherited;
  UpdateRefs;
  UpdateKeys;
end;

function TwbMainRecord.SetPosition(const aPosition: TwbVector): Boolean;
var
  Signature : TwbSignature;
  SelfRef   : IwbContainerElementRef;
  DataRec   : IwbContainerElementRef;
begin
  Result := False;

  Signature := GetSignature;
  if (Signature <> 'REFR') and
     (Signature <> 'ACRE') and
     (Signature <> 'ACHR') and
     (Signature <> 'PGRE') and
     (Signature <> 'PMIS') and
     (Signature <> 'PARW') and {>>> Skyrim <<<}
     (Signature <> 'PBEA') and {>>> Skyrim <<<}
     (Signature <> 'PFLA') and {>>> Skyrim <<<}
     (Signature <> 'PCON') and {>>> Skyrim <<<}
     (Signature <> 'PBAR') and {>>> Skyrim <<<}
     (Signature <> 'PHZD')     {>>> Skyrim <<<}
  then
    Exit;

  SelfRef := Self;
  DoInit(False);

  if not Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, DataRec) then
    Exit;

  if DataRec.ElementCount <> 2 then
    Exit;

  with aPosition, (DataRec.Elements[0] as IwbContainerElementRef) do begin
    if ElementCount <> 3 then
      Exit;

    BeginUpdate;
    try
      Elements[0].NativeValue := X;
      Elements[1].NativeValue := Y;
      Elements[2].NativeValue := Z;
    finally
      EndUpdate;
    end;
  end;
  Result := True;
end;

procedure TwbMainRecord.SetPrevEntry(const aEntry: IwbMainRecordEntry);
begin
  Assert(mreHeader.mrehInUse);
  Assert(mreGeneration = mreHeader.mrehGeneration);
  mrePrev := Pointer(aEntry);
end;

procedure TwbMainRecord.SetReferencesInjected(aValue: Boolean);
begin
  if aValue then begin
    Include(mrStates, mrsReferencesInjectedChecked);
    Include(mrStates, mrsReferencesInjected);
  end else begin
    Exclude(mrStates, mrsReferencesInjectedChecked);
    Exclude(mrStates, mrsReferencesInjected);
  end;
end;

function CompareReferencedByFile(Item1, Item2: Pointer): Integer;
begin
  Result := CmpW32(IwbMainRecord(Item1)._File.LoadOrder, IwbMainRecord(Item2)._File.LoadOrder);
end;

function CompareReferencedBy(Item1, Item2: Pointer): Integer;
begin
  Result := TwbFormID.Compare(IwbMainRecord(Item1).LoadOrderFormID , IwbMainRecord(Item2).LoadOrderFormID);
  if Result = 0 then
    Result := CompareReferencedByFile(Item1, Item2);
end;

procedure TwbMainRecord.SortReferencedBy;
begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  //Assert(not wbBuildingRefsParallel);
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}
  Exclude(mrStates, mrsReferencedByUnsorted);
  if mrReferencedByCount > 1  then
    wbMergeSortPtr(@mrReferencedBy[0], mrReferencedByCount, CompareReferencedBy);
{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

procedure TwbMainRecord.UpdateCellChildGroup;
var
  OldTypeGroup      : IwbGroupRecord;
  OldChildGroup     : IwbGroupRecord;
  OldCellOwnerGroup : IwbGroupRecord;
  NewTypeGroup      : IwbGroupRecord;
  NewChildGroup     : IwbGroupRecord;
  CorrectGroupType  : Integer;
  i                 : Integer;
  OldCell           : IwbMainRecord;
  NewCell           : IwbMainRecord;
  Worldspace        : IwbMainRecord;
  IsExterior        : Boolean;
  SelfRef           : IwbElement;
  Position          : TwbVector;
  GridCell          : TwbGridCell;
  TempGridCell      : TwbGridCell;
begin
  SelfRef := Self as IwbElement;

  if not Supports(GetContainer, IwbGroupRecord, OldTypeGroup) then
    Exit;//raise Exception.Create(GetName + ' is not contained in a group.');
  if not (OldTypeGroup.GroupType in [8, 9, 10]) then
    Exit;//raise Exception.Create(GetName + ' is not contained in a group of type "Cell Persistent Childen", "Cell Temporary Children" or "Cell Visible Distant Children"');
  if not Supports(OldTypeGroup.Container, IwbGroupRecord, OldChildGroup) then
    Exit;//raise Exception.Create(OldTypeGroup.GetName + ' is not contained in a group');
  if not (OldChildGroup.GroupType in [6]) then
    Exit;//raise Exception.Create(OldTypeGroup.GetName + ' is not contained in a group of type "Cell Children"');

  if GetIsPersistent then
    CorrectGroupType := 8
  else if GetIsVisibleWhenDistant and not wbVWDInTemporary then
    CorrectGroupType := 10
  else
    CorrectGroupType := 9;

  if (OldTypeGroup.GroupType = CorrectGroupType) and (CorrectGroupType <> 9) then
    Exit;

  OldCell := OldChildGroup.ChildrenOf;
  if not Assigned(OldCell) then
    Exit;//raise Exception.Create(OldChildGroup.GetName + ' can not find its CELL record');

  var OldCellNotPartial := OldCell;
  if not OldCell.ElementExists['DATA'] then begin
    if not Supports(OldCell.HighestOverrideVisibleForFile[GetFile], IwbMainRecord, OldCellNotPartial) or
       not OldCellNotPartial.ElementExists['DATA']
    then
      Exit;//raise Exception.Create(OldCell.GetName + ' is missing its DATA subrecord');
  end;

  i := OldCellNotPartial.GetElementNativeValue('DATA');
  IsExterior := (i and 1) = 0;

  if (OldTypeGroup.GroupType = CorrectGroupType) and not IsExterior then
    Exit;

  NewCell := nil;

  if IsExterior then begin
    if not Supports(OldCell.Container, IwbGroupRecord, OldCellOwnerGroup) then
      Exit;//raise Exception.Create(OldCell.GetName + ' is not contained in a group');
    if not (OldCellOwnerGroup.GroupType in [1, 5]) then
      Exit;//raise Exception.Create(OldCell.GetName + ' is not contained in a group of type "World Childen" or "Exterior Cell Sub-Block"');
    if CorrectGroupType = 8 then begin
      if OldCellOwnerGroup.GroupType <> 1 then begin
        Worldspace := OldCellOwnerGroup.ChildrenOf;
        if not Assigned(Worldspace) or (Worldspace.Signature <> 'WRLD') then
           Exit;//raise Exception.Create(OldCell.GetName + ' can not find its WRLD record');
        NewCell := WorldSpace.Add('CELL[P]') as IwbMainRecord;

        if not Assigned(NewCell) then
           Exit;//raise Exception.Create('Could not determine CELL for persistent exterior references');

        NewChildGroup := NewCell.EnsureChildGroup;
      end else
        NewChildGroup := OldChildGroup;
    end else begin
      if not GetPosition(Position) then
        Exit;//raise Exception.Create('Could not determine position of ' + GetName);

      GridCell := wbPositionToGridCell(Position);

      NewCell := nil;
      if not OldCellNotPartial.IsPersistent then begin
        if not OldCellNotPartial.GetGridCell(TempGridCell) then
          raise Exception.Create('Could not determine grid cell of ' + OldCellNotPartial.GetName);
        if TempGridCell = GridCell then begin
          if OldTypeGroup.GroupType = CorrectGroupType then
            Exit;
          NewCell := OldCell;
        end;
      end;

      if not Assigned(NewCell) then begin
        Worldspace := OldCellOwnerGroup.ChildrenOf;
        if not Assigned(Worldspace) or (Worldspace.Signature <> 'WRLD') then
          Exit;//raise Exception.Create(OldCell.GetName + ' can not find its WRLD record');
        NewCell := WorldSpace.Add(Format('CELL[%d,%d]', [GridCell.x, GridCell.y])) as IwbMainRecord;
      end;

      if not Assigned(NewCell) then
        Exit;//raise Exception.CreateFmt('Could not determine CELL for temporary exterior references in grid [%d, %d]', [GridCell.x, GridCell.y]);

      NewChildGroup := NewCell.EnsureChildGroup;
    end;
  end else
    NewChildGroup := OldChildGroup;

  if not Assigned(NewChildGroup) then
    Exit;//raise Exception.Create('Could not determine new CELL child group');

  if not Assigned(NewCell) then
    NewCell := NewChildGroup.ChildrenOf;

  NewTypeGroup := NewChildGroup.FindChildGroup(CorrectGroupType, NewCell);
  if not Assigned(NewTypeGroup) then
    NewTypeGroup := TwbGroupRecord.Create(NewChildGroup, CorrectGroupType, NewCell);

  if OldTypeGroup.Equals(NewTypeGroup) then
    Exit;

  OldTypeGroup.RemoveElement(SelfRef);
  if OldTypeGroup.ElementCount = 0 then
    OldTypeGroup.Remove
  else
    (OldTypeGroup as IwbGroupRecordInternal).SetModified(True);
  NewTypeGroup.AddElement(SelfRef);
  (NewTypeGroup as IwbGroupRecordInternal).SetModified(True);
  (NewTypeGroup as IwbGroupRecordInternal).Sort;
  if OldChildGroup.ElementCount = 0 then
    OldChildGroup.Remove
  else
    (OldChildGroup as IwbGroupRecordInternal).SetModified(True);
end;

procedure TwbMainRecord.UpdateInteriorCellGroup;
var
  Container        : IwbContainer;

  SubBlockGroup    : IwbGroupRecord;
  BlockGroup       : IwbGroupRecord;
  TopGroup         : IwbGroupRecord;

  NewSubBlockGroup : IwbGroupRecord;
  NewBlockGroup    : IwbGroupRecord;

  ChildGroup       : IwbGroupRecord;

  i: Integer;
  s            : string;

  Block        : Word;
  SubBlock     : Word;

  SelfRef      : IwbElement;
begin
  SelfRef := Self as IwbElement;

  if wbGameMode = gmTES3 then
    Exit;

  if GetSignature <> 'CELL' then
    Exit;
  if not GetElementExists('DATA') then
    Exit;
  i := GetElementNativeValue('DATA');
  if (i and 1) <> 1 then
    Exit;

  Container := GetContainer;

  if not Supports(Container, IwbGroupRecord, SubBlockGroup) then
    raise Exception.Create(GetName + ' is not contained in a group.');
  if not (SubBlockGroup.GroupType in [3]) then begin
    if (SubBlockGroup.GroupType in [0]) and (TwbSignature(SubBlockGroup.GroupLabel) = 'CELL') then begin
      TopGroup := SubBlockGroup;
      SubBlockGroup := nil;
    end else
      raise Exception.Create(GetName + ' is not contained in a group of type "Interior Cell Sub-Block"');
  end else begin
    if not Supports(SubBlockGroup.Container, IwbGroupRecord, BlockGroup) then
      raise Exception.Create(SubBlockGroup.GetName + ' is not contained in a group.');
    if not (BlockGroup.GroupType in [2]) then
      raise Exception.Create(GetName + ' is not contained in a group of type "Interior Cell Block"');

    if not Supports(BlockGroup.Container, IwbGroupRecord, TopGroup) then
      raise Exception.Create(TopGroup.GetName + ' is not contained in a group.');
    if not (TopGroup.GroupType in [0]) or (TwbSignature(TopGroup.GroupLabel) <> 'CELL') then
      raise Exception.Create(GetName + ' is not contained in a group of type "Top CELL"');
  end;

  s := '00' + IntToStr(GetFormID.ObjectID);
  i := Length(s);
  if i > 2 then
    System.Delete(s, 1, i - 2);

  Block := StrToInt(s[2]);
  SubBlock := StrToInt(s[1]);

  NewBlockGroup := BlockGroup;
  NewSubBlockGroup := SubBlockGroup;

  if not Assigned(NewBlockGroup) or (NewBlockGroup.GroupLabel <> Block) then begin
    NewBlockGroup := nil;
    NewSubBlockGroup := nil;

    for i := 0 to Pred(TopGroup.ElementCount) do
      if Supports(TopGroup.Elements[i], IwbGroupRecord, NewBlockGroup) then
        if NewBlockGroup.GroupLabel = Block then
          Break
        else
          NewBlockGroup := nil;

    if not Assigned(NewBlockGroup) then begin
      NewBlockGroup := TwbGroupRecord.Create(TopGroup, 2, Block);
      (TopGroup as IwbGroupRecordInternal).SetModified(True);
      (TopGroup as IwbGroupRecordInternal).Sort;
    end;
  end;

  if not Assigned(NewSubBlockGroup) or (NewSubBlockGroup.GroupLabel <> SubBlock) then begin
    NewSubBlockGroup := nil;

    for i := 0 to Pred(NewBlockGroup.ElementCount) do
      if Supports(NewBlockGroup.Elements[i], IwbGroupRecord, NewSubBlockGroup) then
        if NewSubBlockGroup.GroupLabel = SubBlock then
          Break
        else
          NewSubBlockGroup := nil;

    if not Assigned(NewSubBlockGroup) then begin
      NewSubBlockGroup := TwbGroupRecord.Create(NewBlockGroup, 3, SubBlock);
      (NewBlockGroup as IwbGroupRecordInternal).SetModified(True);
      (NewBlockGroup as IwbGroupRecordInternal).Sort;
    end;
  end;

  if not Container.Equals(NewSubBlockGroup) then begin

    ChildGroup := mrGroup;

    Container.RemoveElement(SelfRef);
    if Assigned(ChildGroup) then
      Container.RemoveElement(ChildGroup);

    NewSubBlockGroup.AddElement(SelfRef);
    if Assigned(ChildGroup) then
      NewSubBlockGroup.AddElement(ChildGroup);
    (NewSubBlockGroup as IwbGroupRecordInternal).SetModified(True);
    (NewSubBlockGroup as IwbGroupRecordInternal).Sort;

    if Assigned(SubBlockGroup) then begin
      if SubBlockGroup.ElementCount = 0 then begin
        SubBlockGroup.Remove;
        if Assigned(BlockGroup) then begin
          if BlockGroup.ElementCount = 0 then begin
            BlockGroup.Remove;
            (TopGroup as IwbGroupRecordInternal).SetModified(True);
          end else
            (BlockGroup as IwbGroupRecordInternal).SetModified(True);
        end;
      end else
        (SubBlockGroup as IwbGroupRecordInternal).SetModified(True);
    end;
  end;
end;

procedure TwbMainRecord.UpdateKeys;
begin
  if mrsIndexKeysActive in mrStates then begin
    var lIndexKeys: TwbIndexKeys;
    BuildIndexKeys(lIndexKeys);
    var lChangedKeys := lIndexKeys.GetChangedKeys(mrIndexKeys);
    if Length(lChangedKeys) > 0 then begin
      mrIndexKeys := lIndexKeys;
      var lFile: IwbFileInternal;
      if Supports(GetFile, IwbFileInternal, lFile) then
        lFile.UpdateIndexKeys(Self, lChangedKeys);
    end;
  end;
end;

procedure TwbMainRecord.UpdateRefs;
begin
  if (csRefsBuild in cntStates) then
    BuildRef;
end;

procedure TwbMainRecord.UpdateStorageFromElements;
begin
  if not (dcfStorageInvalid in dcFlags) then
    Exit;
  // this is not optimal, as it invalidates all currently referenced child elements,
  // but it's better than calling inherited which corrupts data
  // under normal circumstances, this method should never be called
  CollapseStorage(nil, True);
end;

procedure TwbMainRecord.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
var
  KAR       : IwbKeepAliveRoot;
  MS        : TMemoryStream;
  NeedReset : Boolean;

  procedure Inner;
  var
    CurrentPosition   : Int64;
    DataSize          : Cardinal;
    Stream            : TStream;
    MemoryStream      : TMemoryStream;
    mrs               : TwbMainRecordStruct;

    SelfRef : IwbContainerElementRef;
  begin
    KAR := wbCreateKeepAliveRoot;

    if (esModified in eStates) or wbTestWrite then begin
      SelfRef := Self as IwbContainerElementRef;
      DoInit(True);

      mrs := mrStruct^;

      CurrentPosition := aStream.Position;

      if CurrentPosition = 0 then
        Stream := aStream
      else begin
        MS := TMemoryStream.Create;
        Stream := MS;
      end;

      Stream.WriteBuffer(mrs, wbSizeOfMainRecordStruct );

      if wbForceNewHeader then
        Stream.WriteBuffer(wbNewHeaderAddon, SizeOf(wbNewHeaderAddon) );

      if mrStruct.mrsFlags.IsCompressed then begin

        MemoryStream := TMemoryStream.Create;
        try
          inherited WriteToStreamInternal(MemoryStream, aResetModified);
          NeedReset := False;
          DataSize := MemoryStream.Size;
          Stream.WriteBuffer(DataSize, SizeOf(DataSize));
          MemoryStream.Position := 0;
          if (wbGameMode = gmFO76) then
            ZCompressStream(MemoryStream, Stream, zcLevel9)
          else
            ZCompressStream(MemoryStream, Stream);
        finally
          FreeAndNil(MemoryStream);
        end;

      end else begin
        inherited WriteToStreamInternal(Stream, aResetModified);
        NeedReset := False;
      end;

      if wbForceNewHeader then
        DataSize := Stream.Size - wbSizeOfMainRecordStruct - SizeOf(wbNewHeaderAddon)
      else
        DataSize := Stream.Size - wbSizeOfMainRecordStruct;
      Stream.Position := 4;
      Stream.WriteBuffer(DataSize, SizeOf(DataSize));

      if Assigned(MS) then
        aStream.Write(MS.Memory^, MS.Size)
      else
        Stream.Position := Stream.Size;

    end else begin

      if dcfStorageInvalid in dcFlags then
        Assert(not (dcfStorageInvalid in dcFlags));
      Assert(Assigned(dcBasePtr));
      Assert(Assigned(dcEndPtr));

      CurrentPosition := aStream.Position;
      aStream.WriteBuffer(dcBasePtr^, NativeUInt(dcEndPtr) - NativeUInt(dcBasePtr));
      if CurrentPosition + wbSizeOfMainRecordStruct + mrStruct.mrsDataSize <> aStream.Position then
        Assert(CurrentPosition + wbSizeOfMainRecordStruct + mrStruct.mrsDataSize <> aStream.Position);

    end;
  end;

var
  WasInternal : Boolean;
begin
  NeedReset := True;
  MS := nil;
  try
    WasInternal := (esInternalModified in eStates);
    Inner;
    if Assigned(KAR) and KAR.IsRoot then begin
      KAR := nil;
      if Assigned(MS) and (Length(cntElements) > 0) then begin
        if WasInternal then
          WasInternal := wbBeginInternalEdit(True);
        try
          if ResetChildrenLeafFirst then begin
            DoReset(True);
            ReleaseElements;

            if mrsBasePtrAllocated in mrStates then
              FreeMem(dcBasePtr);
            GetMem(dcBasePtr, MS.Size);
            Include(mrStates, mrsBasePtrAllocated);

            Move(MS.Memory^, dcBasePtr^, MS.Size);

            dcEndPtr := PByte(dcBasePtr) + MS.Size;

            Exclude(dcFlags, dcfStorageInvalid);
            mrDataStorage := nil;
            dcDataStorage := nil;
            dcDataBasePtr := nil;
            dcDataEndPtr := nil;

            InitDataPtr;
          end;
        finally
          if WasInternal then
            wbEndInternalEdit;
        end;
      end else
        ResetLeafFirst;
    end;
  finally
    MS.Free;
  end;

  if NeedReset then
    ResetModified(aResetModified)
  else begin
    Exclude(eStates, esUnsaved);
    case aResetModified of
      rmYes: begin
        Exclude(eStates, esModified);
        Exclude(eStates, esInternalModified);
      end;
      rmSetInternal:
        if esModified in eStates then
          Include(eStates, esInternalModified);
    end;
  end;
end;

procedure TwbMainRecord.YouAreTheMaster(const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer);
begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
{$ENDIF}

  Assert(Length(aOverrides) > 0);
  Assert(Equals(aOverrides[0]));
  Assert(Assigned(mrMaster));
  Assert(Length(mrOverrides) = 0);
  Assert(mrReferencedByCount = 0);

  mrMaster := nil;
  mrOverrides := Copy(aOverrides, 1, High(Integer));
  for var lOverrideIndex := Low(mrOverrides) to High(mrOverrides) do
    (mrOverrides[lOverrideIndex] as IwbMainRecordInternal).SetMaster(Self);
  Exclude(mrStates, mrsOverridesSorted);
  mrMasterAndLeafs := nil;

  mrReferencedBy := aReferencedBy;
  mrReferencedBySize := Length(mrReferencedBy);
  mrReferencedByCount := aReferencedByCount;

  for var lReferenceByIndex := 0 to Pred(mrReferencedByCount) do
    (mrReferencedBy[lReferenceByIndex] as IwbMainRecordInternal).SetReferencesInjected(True);

  var lFile := GetFile;
  if not Assigned(lFile) then
    Exit;

  var lMasterFile := lFile.GetMasterForFileID(GetFormID.FileID, GetMastersUpdated, False);
  if not Assigned(lMasterFile) then
    Exit;
  (lMasterFile as IwbFileInternal).InjectMainRecord(Self);

  Include(mrStates, mrsIsInjectedChecked);
  Include(mrStates, mrsIsInjected);
end;

procedure TwbMainRecord.YouAreTheMaster(const aOldMaster: IwbMainRecord; const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer);
var
  i      : Integer;
begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
{$ENDIF}

  Assert(not Assigned(mrMaster));
  Assert(Length(mrOverrides) = 0);
  Assert(mrReferencedByCount = 0);

  SetLength(mrOverrides, Succ(Length(aOverrides)));
  mrOverrides[0] := aOldMaster;
  for i := Low(aOverrides) to High(aOverrides) do
    mrOverrides[Succ(i)] := aOverrides[i];

  for i := Low(mrOverrides) to High(mrOverrides) do
    (mrOverrides[i] as IwbMainRecordInternal).SetMaster(Self);
  Exclude(mrStates, mrsOverridesSorted);
  mrMasterAndLeafs := nil;

  mrReferencedBy := aReferencedBy;
  mrReferencedBySize := Length(mrReferencedBy);
  mrReferencedByCount := aReferencedByCount;

  for i := 0 to Pred(mrReferencedByCount) do
    (mrReferencedBy[i] as IwbMainRecordInternal).SetReferencesInjected(False);
  Exclude(mrStates, mrsIsInjectedChecked);
end;

procedure TwbMainRecord.YouGotAMaster(const aMaster: IwbMainRecord);
begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
{$ENDIF}

  Assert(Assigned(aMaster));
  Assert(not Assigned(mrMaster));
  (aMaster as IwbMainRecordInternal).YouAreTheMaster(Self as IwbMainRecord, mrOverrides, mrReferencedBy, mrReferencedByCount);
  Assert(aMaster.Equals(IwbElement(mrMaster)));
  mrOverrides := nil;
  mrReferencedBy := nil;
  mrReferencedBySize := 0;
  mrReferencedByCount := 0;
  (aMaster._File as IwbFileInternal).RemoveInjectedMainRecord(Self);
  Include(mrStates, mrsIsInjectedChecked);
  Exclude(mrStates, mrsIsInjected);
end;

{ TwbSubRecord }

function Resolve(const aValueDef: IwbValueDef; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): IwbValueDef;
var
  Internal      : IwbElementInternal;
  ResolvableDef : IwbResolvableDef;
  CanResolve    : Boolean;
begin
  Result := aValueDef;

  Supports(aElement, IwbElementInternal, Internal);
  CanResolve := False;
  try
    while Supports(Result, IwbResolvableDef, ResolvableDef) do begin
      CanResolve := CanResolve or (Assigned(Internal) and Internal.BeginResolve);
      if (not ResolvableDef.NeedsElementToResolve) or CanResolve then
        Result := ResolvableDef.ResolveDef(aBasePtr,aEndPtr, aElement)
      else
        break;
    end;
  finally
    if CanResolve then
      Internal.EndResolve;
  end;
end;

function wbUnionCreate(const aContainer  : IwbContainer;
                         var aBasePtr    : Pointer;
                             aEndPtr     : Pointer;
                       const aValueDef   : IwbValueDef;
                       const aNameSuffix : string;
                             aDontCompare: Boolean = False): TwbValueBase; overload;
var
  UnionDef: IwbUnionDef;
begin
  if Supports(aValueDef, IwbUnionDef, UnionDef)
    and
    (
      (UnionDef.MemberTypes * [dtArray, dtStruct, dtStructChapter, dtUnion] <> [])
      or
      (dfMustBeUnion in UnionDef.DefFlags)
    )
  then
    Exit(TwbUnion.Create(aContainer, aBasePtr, aEndPtr, aValueDef, aNameSuffix, aDontCompare));

  Result := TwbValue.Create(aContainer, aBasePtr, aEndPtr, aValueDef, aNameSuffix, aDontCompare);
end;

function wbUnionCreate(const aContainer  : IwbContainer;
                       const aValueDef   : IwbValueDef;
                       const aSource     : IwbElement;
                       const aOnlySK     : Boolean;
                       const aNameSuffix : string): TwbValueBase; overload;
var
  UnionDef: IwbUnionDef;
begin
  if Supports(aValueDef, IwbUnionDef, UnionDef) and
    (UnionDef.MemberTypes * [dtArray, dtStruct, dtStructChapter, dtUnion] <> []) then
      Exit(TwbUnion.Create(aContainer, aValueDef, aSource, aOnlySK, aNameSuffix));

  Result := TwbValue.Create(aContainer, aValueDef, aSource, aOnlySK, aNameSuffix);
end;

function TwbSubRecord.Add(const aName: string; aSilent: Boolean): IwbElement;
begin
  if srsIsArray in srStates then
    Result := Assign(wbAssignAdd, nil, False)
  else
    Result := inherited Add(aName, aSilent);
end;

function TwbSubRecord.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  SelfRef    : IwbContainerElementRef;
  i          : Integer;
  s          : string;
  ArrayDef   : IwbArrayDef;
  StructDef  : IwbStructDef;
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  ValueDef   : IwbValueDef;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be modified.');
  end;

  SelfRef := Self as IwbContainerElementRef;

  DoInit(True);

  if Assigned(srValueDef) then begin

    case srValueDef.DefType of
      dtRecord, dtSubRecord, dtSubRecordArray, dtSubRecordStruct: Assert(False);
      dtArray: begin

        ArrayDef := srValueDef as IwbArrayDef;

        if srsSorted in srStates  then begin
          Assert(not (srsSortInvalid in srStates));
          if FindBySortKey(aElement.SortKey[False], False, i) then begin
            Result := cntElements[i];
            if aDeepCopy then
              Result.Assign(wbAssignThis, aElement, False);
            Exit;
          end;
        end;

        if srsSorted in srStates then
          s := ''
        else
          s := '#' + IntToStr(Length(cntElements));

        if not Supports(aElement, IwbStringListTerminator) then
          if (csAsCreatedEmpty in cntStates) then begin
            SetModified(True);
            Assert(Length(cntElements)=1);
            Result := cntElements[0];
            Exclude(cntStates, csAsCreatedEmpty);
            try
              Result.Assign(wbAssignThis, aElement, not aDeepCopy);
            except
              Result := nil;
              raise;
            end;
          end else begin
            ValueDef := ArrayDef.Element;
            if ValueDef.DefType = dtResolvable then
              ValueDef := Resolve(ValueDef, nil, nil, aElement);
            if dfUnionStaticResolve in ValueDef.DefFlags then
              ValueDef := Resolve(ValueDef, nil, nil, aElement);
            case ValueDef.DefType of
              dtArray: Result := TwbArray.Create(Self, ValueDef, aElement, not aDeepCopy, s);
              dtStruct: Result := TwbStruct.Create(Self, ValueDef, aElement, not aDeepCopy, s);
              dtStructChapter: Result := TwbChapter.Create(Self, ValueDef, aElement, not aDeepCopy, s);
              dtUnion: Result := wbUnionCreate(Self, ValueDef, aElement, not aDeepCopy, s);
            else
              Result := TwbValue.Create(Self, ValueDef, aElement, not aDeepCopy, s);
            end;
          end;

        CheckCount;
        CheckTerminator;
      end;
      dtStruct, dtStructChapter: begin
        StructDef := srValueDef as IwbStructDef;

        Assert(aElement.SortOrder >= 0);
        Assert(aElement.SortOrder < StructDef.MemberCount );
        Assert(Assigned(aElement.ValueDef));

        Result := GetElementBySortOrder(aElement.SortOrder);
        Assert(Assigned(Result));

        Assert(StructDef.Members[aElement.SortOrder].CanAssign(Result, wbAssignThis, aElement.ValueDef));

        if not aDeepCopy then
          if Supports(Result.ValueDef, IwbIntegerDef, IntegerDef) then
            if Supports(IntegerDef.Formater[Result], IwbFlagsDef, FlagsDef) then
              Exit(Result);

        Result.Assign(wbAssignThis, aElement, not aDeepCopy);
      end;
      dtUnion: begin
        inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite);
      end;
    else
      inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite);
    end;

  end else
    inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite);
end;

function TwbSubRecord.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Element       : IwbElement;
  ArrayDef      : IwbArrayDef;
  ValueDef      : IwbValueDef;
  Container     : IwbContainer;
  s             : string;
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  p, q          : Pointer;
  AlignedCreate : Boolean;
begin
  Result := nil;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if Assigned(srValueDef) then begin

    case srValueDef.DefType of
      dtRecord, dtSubRecord, dtSubRecordArray, dtSubRecordStruct: Assert(False);
      dtArray: begin

        var lMultipleElements: IwbMultipleElements;
        if  Supports(aElement, IwbMultipleElements, lMultipleElements) then begin
          for var lElementIdx := 0 to Pred(lMultipleElements.ElementCount) do begin
            var lResult := AssignInternal(aIndex, lMultipleElements.Elements[lElementIdx], aOnlySK);
            if Assigned(lResult) then
              Result := lResult;
          end;
          Exit;
        end;

        ArrayDef := srValueDef as IwbArrayDef;

        var lDef: IwbDef;
        if Assigned(aElement) then begin
          lDef := aElement.ValueDef;
          if not Assigned(lDef) then
            lDef := aElement.Def;
        end;

        if (aIndex = wbAssignThis) and ArrayDef.CanAssign(Self, aIndex, lDef) then begin

          if aOnlySK then
            Exit;

          Container := aElement as IwbContainer;

          var lDataContainer: IwbDataContainer;
          if (
               (dfFastAssign in srDef.DefFlags) or
               (dfFastAssign in ArrayDef.DefFlags) or
               wbAlwaysFastAssign
             ) and
             Supports(aElement, IwbDataContainer, lDataContainer)
          then begin
            SetModified(True);
            InvalidateStorage;
            ReleaseElements;
            dcDataStorage := nil;
            dcDataBasePtr := @EmptyPtr;
            dcDataEndPtr := @EmptyPtr;
            Exclude(dcFlags, dcfStorageInvalid);
            var lSize := lDataContainer.DataSize;
            RequestStorageChange(p, q, lSize);
            Move(lDataContainer.DataBasePtr^, dcDataBasePtr^, lSize);
            DoReset(True);
            Assert(GetElementCount = Container.ElementCount);
            for i := 0 to Pred(Container.ElementCount) do
              cntElements[i].Assign(wbAssignThis, Container.Elements[i], aOnlySK);
          end else if ArrayDef.IsVariableSize then begin
            SetModified(True);
            InvalidateStorage;
            ReleaseElements;
            dcDataStorage := nil;
            dcDataBasePtr := @EmptyPtr;
            dcDataEndPtr := @EmptyPtr;
            Exclude(dcFlags, dcfStorageInvalid);
            if ArrayDef.ElementCount < 0 then
              RequestStorageChange(p, q, 4)
            else if ArrayDef.ElementCount > 0 then
              SetToDefaultInternal;

            if Assigned(Container) then begin
              var CopyCount := Container.ElementCount;
              if (ArrayDef.ElementCount > 0) and (CopyCount > ArrayDef.ElementCount) then
                CopyCount := ArrayDef.ElementCount;

              for i := 0 to Pred(CopyCount) do
                if (i < Length(cntElements)) and not Supports(cntElements[i], IwbStringListTerminator) then
                  cntElements[i].Assign(wbAssignThis, Container.Elements[i], aOnlySK)
                else
                  Assign(i, Container.Elements[i], aOnlySK);
            end;
          end else begin
            if Assigned(Container) then begin
              Assert(Container.ElementCount = ArrayDef.ElementCount);
              Assert(GetElementCount = ArrayDef.ElementCount);

              for i := 0 to Pred(Container.ElementCount) do
                cntElements[i].Assign(wbAssignThis, Container.Elements[i], aOnlySK);
            end;
          end;

        end else begin
          if (aIndex = wbAssignThis) and Supports(aElement, IwbMainRecord) then
            aIndex := wbAssignAdd;

          if (aIndex >= 0) and (ArrayDef.ElementCount <= 0) then begin
            AlignedCreate := ( (aIndex < wbAssignAdd) and GetAlignable and (csSortedBySortOrder in cntStates) and not Assigned(GetElementBySortOrder(aIndex)) );
            if AlignedCreate or ((aIndex = wbAssignAdd) or ArrayDef.Element.CanAssign(Self, wbAssignThis, lDef)) then begin
              {add one entry}

              if srsSorted in srStates then
                s := ''
              else
                s := '#' + IntToStr(Length(cntElements));

              if (csAsCreatedEmpty in cntStates) then begin
                SetModified(True);
                Assert(Length(cntElements)=1);
                Result := cntElements[0];
                Exclude(cntStates, csAsCreatedEmpty);
                try
                  Result.Assign(wbAssignThis, aElement, aOnlySK);
                except
                  Result := nil;
                  raise;
                end;
              end else begin
                Element := nil;
                if not Supports(aElement, IwbStringListTerminator) then begin
                  ValueDef := ArrayDef.Element;
                  if ValueDef.DefType = dtResolvable then
                    ValueDef := Resolve(ValueDef, nil, nil, aElement);
                  if dfUnionStaticResolve in ValueDef.DefFlags then
                    ValueDef := Resolve(ValueDef, nil, nil, aElement);
                  case ValueDef.DefType of
                    dtArray: Element := TwbArray.Create(Self, ValueDef, aElement, aOnlySK, s);
                    dtStruct: Element := TwbStruct.Create(Self, ValueDef, aElement, aOnlySK, s);
                    dtStructChapter: Element := TwbChapter.Create(Self, ValueDef, aElement, aOnlySK, s);
                    dtUnion: Element := wbUnionCreate(Self, ValueDef, aElement, aOnlySK, s);
                  else
                    Element := TwbValue.Create(Self, ValueDef, aElement, aOnlySK, s);
                  end;
                end;
                Result := Element;
              end;
              if AlignedCreate then begin
                Result.SortOrder := aIndex;
                SortBySortOrder;
                ResetMemoryOrder;
              end;
            end;
          end;
        end;

        CheckCount;
        CheckTerminator;
      end;
    else
      Result := inherited AssignInternal(aIndex, aElement, aOnlySK);
    end;

  end else
    if inherited CanAssignInternal(aIndex, aElement, False) then
      Result := inherited AssignInternal(aIndex, aElement, aOnlySK);
end;

procedure TwbSubRecord.BeforeActualRemove;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self;

  inherited;

  var lArrayDef: IwbArrayDef;

  if Assigned(srResolvedDef) then
    if not Supports(srResolvedDef, IwbArrayDef, lArrayDef) then
      Exit;

  if not Assigned(lArrayDef) then
    if not Supports(srValueDef, IwbArrayDef, lArrayDef) then
      Exit;

  var lCountPath := lArrayDef.CountPath;

  if lCountPath = '' then
    Exit;

  var lContainer := GetContainer as IwbContainerElementRef;
  if not Assigned(lContainer) then
    Exit;

  //this way will prevent the creating of the Elements along the path if they don't already exist
  var lCounterElement := lContainer.ElementByPath[lCountPath];
  if not Assigned(lCounterElement) then
    Exit;

  lCounterElement.NativeValue := 0;
end;

procedure TwbSubRecord.BuildRef;
var
  SelfRef: IwbElement;
begin
  var lDef := GetDef;
  if Assigned(lDef) and (dfExcludeFromBuildRef in lDef.DefFlags) then
    Exit;

  var lValueDef := GetValueDef;
  if Assigned(lValueDef) and (dfExcludeFromBuildRef in lValueDef.DefFlags) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  if Assigned(srDef) then begin
    DoInit(False);

    if Assigned(srValueDef) then
      srValueDef.BuildRef(GetDataBasePtr, dcDataEndPtr, Self);
  end;

  inherited;
end;

function TwbSubRecord.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  ArrayDef: IwbArrayDef;

  function CheckAssign(const aElement: IwbElement): Boolean;
  begin
    Result := False;
    if not Assigned(aElement) then
      Exit;

    var lDef: IwbDef := aElement.ValueDef;
    if not Assigned(lDef) then
      lDef := aElement.Def;

    if srsIsArray in srStates then begin
      Result :=
         ArrayDef.CanAssign(Self, aIndex, lDef) or
         ( (ArrayDef.ElementCount <= 0) and ArrayDef.Element.CanAssign(Self, wbAssignThis, lDef) );
    end else begin
      Result := inherited CanAssignInternal(aIndex, aElement, aCheckDontShow);
      if not Result and Assigned(srDef) then
        Result := srDef.CanAssign(Self, aIndex, lDef);
    end;
  end;


begin
  Result := False;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;
    if Assigned(srDef) and (dfInternalEditOnly in srDef.DefFlags) then
      Exit;
  end;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  if srsIsArray in srStates then begin
    ArrayDef := srValueDef as IwbArrayDef;
    if not Assigned(aElement) then begin
      if (aIndex = wbAssignAdd) or ((aIndex >= 0) and GetAlignable and (csSortedBySortOrder in cntStates) and not Assigned(GetElementBySortOrder(aIndex)) )  then
        Result := ArrayDef.ElementCount <= 0;
      Exit;
    end;
  end;

  var lMultipleElements: IwbMultipleElements;
  if  Supports(aElement, IwbMultipleElements, lMultipleElements) then begin
    for var lElementIdx := 0 to Pred(lMultipleElements.ElementCount) do begin
      Result := CheckAssign(lMultipleElements.Elements[lElementIdx]);
      if Result then
        Exit;
    end;
  end else
    Result := CheckAssign(aElement);
end;

function TwbSubRecord.CanContainFormIDs: Boolean;
begin
  Result := Assigned(srDef) and (dfCanContainFormID in srDef.DefFlags);
end;

function TwbSubRecord.CanMoveElement: Boolean;
begin
  Result :=
    (srStates * [srsIsArray, srsSorted] = [srsIsArray]) and
    not (dfNoMove in srDef.DefFlags) and
    not (dfNoMove in srValueDef.DefFlags);
end;

function TwbSubRecord.CanElementReset: Boolean;
begin
//  Result := inherited CanElementReset;
  Result := cntElementRefs < 1;
end;

procedure TwbSubRecord.CheckCount;
var
  Count       : Int64;
  i           : Integer;
  UpdateCount : Integer;
begin
  if not (srArraySizePrefix in [1, 2, 4]) then
    Exit;

  if Assigned(dcDataBasePtr) then
    case srArraySizePrefix of
      1: Count := PByte(dcDataBasePtr)^;
      2: Count := PWord(dcDataBasePtr)^;
      4: Count := PCardinal(dcDataBasePtr)^;
    else
      Count := 0;
    end
  else
    Count := 0;

  if Count <> Length(cntElements) then begin
    UpdateCount := eUpdateCount;
    SetModified(True);
    for i := 1 to UpdateCount do EndUpdate;
    case srArraySizePrefix of
      1: PByte(GetDataBasePtr)^ := Length(cntElements);
      2: PWord(GetDataBasePtr)^ := Length(cntElements);
      4: PCardinal(GetDataBasePtr)^ := Length(cntElements);
    end;
    for i := 1 to UpdateCount do BeginUpdate;
  end;
end;

procedure TwbSubRecord.CheckTerminator;
var
  i         : Integer;
  ArrayDef  : IwbArrayDef;
  StringDef : IwbStringDef;
begin
  if eUpdateCount > 0 then
    Exit; {will be checked in NotifyChangedInternal}

  if not Supports(srValueDef, IwbArrayDef, ArrayDef) then
    Exit;
  if not ArrayDef.IsVariableSize then
    Exit;
  if ArrayDef.Element.DefType <> dtString then
    Exit;
  if (not Supports(ArrayDef.Element, IwbStringDef, StringDef)) or (StringDef.GetStringSize>0) then
    Exit;

  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbStringListTerminator) then
      Exit;

  SetModified(True);
  InvalidateStorage;
  TwbStringListTerminator.Create(Self);
  if srsSorted in srStates then
    Include(srStates, srsSortInvalid);
end;

function TwbSubRecord.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := False;
  if not Assigned(srDef) then
    Exit;

  DoInit(False);

  BeginUpdate;
  try
    Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);

    ResolvedDef := Resolve(srValueDef, GetDataBasePtr, dcDataEndPtr, Self);
    if Assigned(ResolvedDef) then
      if ResolvedDef.CompareExchangeFormID(GetDataBasePtr, dcDataEndPtr, Self, aOldFormID, aNewFormID) then begin
        SetModified(True);
        Result := True;
        //wbProgress('Replaced FormID [%s] with [%s] in "%s". New Value: %s', [aOldFormID.ToString, aNewFormID.ToString, GetPath, GetValue]);
      end;
  finally
    EndUpdate;
  end;
end;

constructor TwbSubRecord.Create(const aContainer: IwbContainer; const aSubRecordDef: IwbSubRecordDef);
var
  BasePtr            : Pointer;
  EndPtr             : Pointer;
  SaveAsCreatedEmpty : Boolean;
begin
  cntStates := [];
  srDef := aSubRecordDef;
  BasePtr := nil;
  EndPtr := nil;
  Create(aContainer, BasePtr, EndPtr, nil);

  DoInit(True);

  SaveAsCreatedEmpty := (csAsCreatedEmpty in cntStates);
  BasePtr := nil;
  EndPtr := nil;
  RequestStorageChange(BasePtr, EndPtr, GetDataSize);
  SetToDefault;

  if SaveAsCreatedEmpty then
    Include(cntStates, csAsCreatedEmpty);
end;

destructor TwbSubRecord.Destroy;
begin
  if not Assigned(dcEndPtr) and Assigned(dcBasePtr) then
    FreeMem(dcBasePtr, TwbSubRecordHeaderStruct.SizeOf );
  inherited;
end;

procedure TwbSubRecord.DoAfterSet(const aOldValue, aNewValue: Variant);
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self;

  inherited;

  UpdateCountViaPath;
end;

function TwbSubRecord.DoCheckSizeAfterWrite: Boolean;
begin
  Result := True;
end;

procedure TwbSubRecord.DoInit(aNeedSorted: Boolean);
begin
  inherited;
  if aNeedSorted or wbAlwaysSorted then
    if srStates * [srsSorted, srsSortInvalid] = [srsSorted, srsSortInvalid] then begin
      if Length(cntElements) > 1 then
        wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSortKeys);
      Exclude(srStates, srsSortInvalid);
    end;
end;

procedure TwbSubRecord.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
begin
  if srsSorted in srStates then
    Include(srStates, srsSortInvalid);
  inherited;
end;

procedure TwbSubRecord.FindUsedMasters(aMasters: PwbUsedMasters);
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(srDef) then
    Exit;

  DoInit(False);

  inherited FindUsedMasters(aMasters);

  ResolvedDef := Resolve(srValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.FindUsedMasters(GetDataBasePtr, dcDataEndPtr, Self, aMasters);
end;

//var
//  y: Integer;

procedure TwbSubRecord.Init;
var
  ValueDef          : IwbValueDef;
  BasePtr           : Pointer;
  Element           : IwbElement;
  HasUnusedData     : Boolean;
begin
  inherited;

  if GetSkipped then
    Exit;

  if not Assigned(srDef) then
    Exit;

  BasePtr := GetDataBasePtr;
  ValueDef := Resolve(srDef.Value, BasePtr, dcDataEndPtr, Self);
  srArraySizePrefix := 0;
  srResolvedDef := nil;

  if Assigned(ValueDef) then
    if (ValueDef.Name = '') or (dfUnionStaticResolve in srDef.Value.DefFlags) then begin
      srValueDef := ValueDef;
      case ValueDef.DefType of
        dtArray: begin
          Include(srStates, srsIsArray);
          if ArrayDoInit(ValueDef, Self, BasePtr, dcDataEndPtr, srArraySizePrefix) then
            Include(srStates, srsSorted);
        end;
        dtStruct, dtStructChapter: StructDoInit(ValueDef, Self, BasePtr, dcDataEndPtr);
        dtUnion:  begin
          Include(srStates, srsIsUnion);

          case UnionDoInit(ValueDef, Self, BasePtr, dcDataEndPtr, srResolvedDef) of
            ufArray: Include(srStates, srsIsArray);
            ufSortedArray: begin
              Include(srStates, srsIsArray);
              Include(srStates, srsSorted);
            end;
            ufFlags: begin
              Include(srStates, srsIsFlags);
              Include(srStates, srsSorted);
            end;
          end;
        end;
      else
        if ValueDoInit(ValueDef, Self, BasePtr, dcDataEndPtr, Self, nil, srResolvedDef) then begin
          Include(srStates, srsIsFlags);
          Include(srStates, srsSorted);
        end;
      end;
      // flags are already created in the right sort order
      if srStates * [srsSorted, srsIsFlags] = [srsSorted] then
        Include(srStates, srsSortInvalid);
    end else
      case ValueDef.DefType of
        dtArray: Element := TwbArray.Create(Self, BasePtr, dcDataEndPtr, ValueDef, '');
        dtStruct: Element := TwbStruct.Create(Self, BasePtr, dcDataEndPtr, ValueDef, '');
        dtStructChapter: Element := TwbChapter.Create(Self, BasePtr, dcDataEndPtr, ValueDef, '');
        dtUnion: Element := wbUnionCreate(Self, BasePtr, dcDataEndPtr, ValueDef, '');
      else
        Element := TwbValue.Create(Self, BasePtr, dcDataEndPtr, ValueDef, '');
      end;

  if Assigned(dcDataEndPtr) and Assigned(BasePtr) and (BasePtr <> dcDataEndPtr) then begin
    HasUnusedData := Assigned(ValueDef) and not SameText(ValueDef.Name, 'Unused');
    if HasUnusedData and Assigned(ValueDef) and (ValueDef.DefType = dtString) then begin
      HasUnusedData := False;
      while NativeUInt(BasePtr) < NativeUInt(dcDataEndPtr) do begin
        if PAnsiChar(BasePtr)^ <> #0 then begin
          HasUnusedData := True;
          Break;
        end;
        Inc(PByte(BasePtr));
      end;
    end;
    if HasUnusedData then begin
      if wbReportMode then
        srDef.HasUnusedData;
      {$IFDEF DBGSUBREC}
      if ShouldReportError(eeUnusedData) then
        if wbHasProgressCallback then
          wbProgressCallback('<Warning: Unused data in: ' + GetFullPath + '>');
      {$ENDIF}
    end;
  end;

  srDef.AfterLoad(Self);
end;

function TwbSubRecord.GetAlignable: Boolean;
var
  SelfRef  : IwbContainerElementRef;
begin
  if wbCompareRawData then
    Exit(False);

  SelfRef := Self as IwbContainerElementRef;

  if GetSorted then
    Exit(False);

  if Assigned(srDef) and (dfNotAlignable in srDef.DefFlags) then
    Exit(False);

  if not Assigned(srValueDef) then
    DoInit(False);

  if Assigned(srValueDef) and (dfNotAlignable in srValueDef.DefFlags) then
    Exit(False);

  Result := (srsIsArray in srStates) and ((srValueDef as IwbArrayDef).ElementCount <= 0);
end;

function TwbSubRecord.GetCheck: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(srDef) then
    Exit;
  if GetDontShow then
    Exit;
  DoInit(False);

  if Assigned(srValueDef) then
    Result := srValueDef.Check(GetDataBasePtr, dcDataEndPtr, Self);
  srDef.ToString(Result, Self, ctCheck);
end;

function TwbSubRecord.GetDataPrefixSize: Integer;
begin
  Result := srArraySizePrefix;
end;

function TwbSubRecord.GetDataSize: Integer;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);

  if not Assigned(dcDataBasePtr) and Assigned(srValueDef) and not (dcfStorageInvalid in dcFlags) then begin
    Result := srValueDef.DefaultSize[nil, nil, Self];
    Assert(Result <> High(Integer));
  end else
    Result := inherited GetDataSize;
end;

function TwbSubRecord.GetDef: IwbNamedDef;
begin
  Result := srDef;
end;

function TwbSubRecord.GetDisplayName(aUseSuffix: Boolean): string;
var
  s        : string;
  SelfRef  : IwbContainerElementRef;
  ValueDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := inherited GetName;

  ValueDef := Resolve(srValueDef, GetDataBasePtr, GetDataEndPtr, Self);

  if Assigned(ValueDef) then begin
    s := ValueDef.Name;
    if s <> '' then begin
      Result := Result + ' - ' + s;
      Exit;
    end;
  end;

  if not Assigned(srDef) then
    Exit;

  Result := Result + ' - ' + srDef.GetName;

  if aUseSuffix and (GetNameSuffix <> '') then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + eNameSuffix;
  end;
end;

function TwbSubRecord.GetDisplaySignature: string;
begin
  Result := inherited;
  if Assigned(srDef) and (dfIncludeValueInDisplaySignature in srDef.DefFlags) then
    Result := Result + '('+GetValue+')';
end;

function TwbSubRecord.GetEditValue: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(srDef) then
    Exit;
  DoInit(False);

  if Assigned(srValueDef) then
    Result := srValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self]
  else
    Result := '';
end;

function TwbSubRecord.GetElementType: TwbElementType;
begin
  Result := etSubRecord;
end;

function TwbSubRecord.GetIsEditable: Boolean;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := wbIsInternalEdit;
  if Result then
    Exit;

  if not Assigned(srDef) then
    Exit;

  if dfInternalEditOnly in srDef.DefFlags then
    Exit;

  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(SelfRef) then
    Exit;

  DoInit(False);

  Result := Assigned(srValueDef) and
    srValueDef.IsEditable[GetDataBasePtr, dcDataEndPtr, Self];
end;

function TwbSubRecord.GetIsInSK(aIndex: Integer): Boolean;
var
  SelfRef    : IwbContainerElementRef;
  HasSortKey : IwbHasSortKeyDef;
begin
  Result := False;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  if not Supports(srValueDef, IwbHasSortKeyDef, HasSortKey) then
    Exit;

  Result := HasSortKey.IsInSK(aIndex);
end;

function TwbSubRecord.InternalGetLinksTo: IwbElement;
var
  SelfRef: IwbContainerElementRef;
begin
  Result := nil;
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  if not Assigned(srValueDef) then
    Exit;
  Result := srValueDef.LinksTo[dcDataBasePtr, dcDataEndPtr, Self];
end;

function TwbSubRecord.GetName: string;
begin
  Result := inherited GetName;

  if not Assigned(srDef) then
    Exit;

  Result := Result + ' - ' + srDef.GetName;
end;

function TwbSubRecord.GetNativeValue: Variant;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(srDef) then
    Exit;
  DoInit(False);

  if Assigned(srValueDef) then
    Result := srValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self]
  else
    Result := Null;
end;

function TwbSubRecord.GetSorted: Boolean;
var
  EmptyDef : IwbEmptyDef;
  SelfRef  : IwbContainerElementRef;
begin
  if wbCompareRawData then
    Exit(False);

  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(srValueDef) then
    DoInit(True);

  Result := (srsSorted in srStates) or
    (Supports(Resolve(srValueDef, GetDataBasePtr, GetDataEndPtr, Self), IwbEmptyDef, EmptyDef) and EmptyDef.Sorted);
end;

function TwbSubRecord.GetSortKeyInternal(aExtended: Boolean): string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := GetSignature;

  if not Assigned(srDef) then
    Exit;
  DoInit(True);

  if Assigned(srValueDef) then
    Result := srValueDef.ToSortKey(GetDataBasePtr, dcDataEndPtr, Self, aExtended)
  else
    Result := inherited GetSortKeyInternal(aExtended);
end;

function TwbSubRecord.GetSubRecordHeaderSize: Integer;
begin
  if Assigned(dcBasePtr) then
    Result := srStruct.srsDataSize
  else
    Result := 0;
end;

function TwbSubRecord.GetSummary: string;
var
  SelfRef : IwbContainerElementRef;
  Def     : IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Assigned(srDef) then
    Exit;
  DoInit(True);

  if Assigned(srDef) then begin
    eSummaryLinksTo := nil;
    Result := srDef.ToSummary(0, Self, eSummaryLinksTo);
  end;
end;

function TwbSubRecord.GetValue: string;
var
  SelfRef : IwbContainerElementRef;
  Def     : IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Assigned(srDef) then
    Exit;
  DoInit(True);

  if Assigned(srValueDef) then
    Result := srValueDef.ToString(GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(srDef) then
    srDef.ToString(Result, Self, ctToStr);

  if wbShowDataSizeInValue then
    Result := Result + ' {DataSize: ' + GetDataSize.ToString + '}';
end;

function TwbSubRecord.GetValueDef: IwbValueDef;
var
  SelfRef : IwbContainerElementRef;
begin
  if not Assigned(srValueDef) or ((srsIsUnion in srStates) and not (csInit in cntStates)) then begin
    SelfRef := Self as IwbContainerElementRef;
    DoInit(False);
  end;
  Result := srValueDef;
end;

procedure TwbSubRecord.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SizeNeeded    : Cardinal;
  SizeAvailable : Cardinal;
  BasePtr       : Pointer;
begin
  Assert(Assigned(dcBasePtr));
  Assert(Assigned(dcEndPtr));

  SizeNeeded := TwbSubRecordHeaderStruct.SizeOf;
  SizeAvailable := NativeUInt(aEndPtr) - NativeUInt(aBasePtr);
  Assert( SizeAvailable >= SizeNeeded );

  BasePtr := aBasePtr;
  Inc(PByte(aBasePtr), SizeNeeded );
  inherited;

  Assert(srStruct.srsDataSize = NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr));

  dcBasePtr := BasePtr;
  if dcfBasePtrInvalid in dcFlags then
    Exclude(dcFlags, dcfBasePtrInvalid);
  dcEndPtr := dcDataEndPtr;
end;

procedure TwbSubRecord.InitDataPtr;
var
  lDataSize  : Cardinal;
  LastRecord : IwbElement;
  Container  : IwbContainer;
begin
  if Assigned(dcBasePtr) then begin
    dcDataBasePtr := PByte(dcBasePtr) + TwbSubRecordHeaderStruct.SizeOf;

    lDataSize := srStruct.srsDataSize;

    if lDataSize = 0 then begin
      Container := GetContainer;
      if Assigned(Container) and (Container.ElementCount >= 2) then begin
        LastRecord := Container.Elements[Container.ElementCount - 2];
        if Assigned(LastRecord) and (LastRecord.ElementType = etSubRecord) then
          with LastRecord as IwbSubRecord do
            if Signature = 'XXXX' then begin
              lDataSize := PCardinal(DataBasePtr)^;
              Container.RemoveElement(Container.ElementCount - 2);
            end;
      end;
    end;

    dcDataEndPtr := PByte(dcDataBasePtr) + lDataSize;
    dcEndPtr := dcDataEndPtr;
  end else begin
    GetMem(dcBasePtr, TwbSubRecordHeaderStruct.SizeOf );
    if Assigned(srDef) then
      srStruct.srsSignature := srDef.DefaultSignature
    else
      srStruct.srsSignature := NONE;
  end;
end;

function TwbSubRecord.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement)
    and not (dfArrayStaticSize in srValueDef.DefFlags)
    and (srsIsArray in srStates)
    and Assigned(srValueDef)
    and ( (srValueDef as IwbArrayDef).ElementCount <= 0 )
    and ( (dfArrayCanBeEmpty in srValueDef.DefFlags) or (Length(cntElements) > 1) );

  if Result and (dfRemoveLastOnly in srValueDef.DefFlags) then
    Result := cntElements[High(cntElements)].Equals(aElement);
end;

function TwbSubRecord.IsFlags: Boolean;
begin
  Result := srsIsFlags in srStates;
end;

function TwbSubRecord.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  Result := False;

  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(srDef) then
    Exit;

  BeginUpdate;
  try
    DoInit(False);

    Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);

    ResolvedDef := Resolve(srValueDef, GetDataBasePtr, dcDataEndPtr, Self);
    if Assigned(ResolvedDef) then
      if ResolvedDef.MastersUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew, aOldCount, aNewCount) then begin
        Result := True;
        SetMastersUpdated(True);
        SetModified(True);
      end;
  finally
    EndUpdate;
  end;
end;

function TwbSubRecord.MergeMultiple(const aElement: IwbElement): Boolean;
var
  SelfRef              : IwbContainerElementRef;
  lSourceDataContainer : IwbDataContainerInternal;
begin
  if not Supports(aElement, IwbDataContainerInternal, lSourceDataContainer) then
    Exit(False);
  if lSourceDataContainer.DataSize < 1 then
    Exit(True);
  if not Assigned(srDef) then
    Exit(False);
  if not (dfMergeIfMultiple in srDef.DefFlags) then
    Exit(False);
  var lValueDef := GetValueDef;
  if not Assigned(lValueDef) then
    Exit(False);
  if lValueDef.DefType <> dtArray then
    Exit(False);

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if not (srsIsArray in srStates) then
    Exit(False);
  if not Assigned(srValueDef) then
    Exit(False);

  var lOldElementCount := GetElementCount;
  if not wbBeginInternalEdit(True) then
    Exit(False);
  try
    BeginUpdate;
    try
      var lBasePtr := lSourceDataContainer.DataBasePtr;
      ArrayDoInit(srValueDef, Self, lBasePtr, lSourceDataContainer.DataEndPtr, srArraySizePrefix);
      var lNewElementCount := GetElementCount;
      if lNewElementCount > lOldElementCount then begin
        InvalidateStorage;
        for var lElementIdx := lOldElementCount to Pred(lNewElementCount) do
          (GetElement(lElementIdx) as IwbElementInternal).Modified := True;
        UpdateStorageFromElements;
      end;
      Result := True;
    finally
      EndUpdate;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure TwbSubRecord.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SizeNeeded    : Cardinal;
  SizeAvailable : Cardinal;
  BasePtr       : Pointer;
  lDataSize     : Cardinal;
begin
  Assert(Assigned(dcBasePtr));
  SizeNeeded := TwbSubRecordHeaderStruct.SizeOf;
  SizeAvailable := NativeUInt(aEndPtr) - NativeUInt(aBasePtr);
  Assert( SizeAvailable >= SizeNeeded );

  BasePtr := aBasePtr;
  Move(dcBasePtr^, aBasePtr^, SizeNeeded);
  Inc(PByte(aBasePtr), SizeNeeded );
  inherited;

  if not Assigned(dcEndPtr) then
    FreeMem(dcBasePtr, SizeNeeded);

  dcBasePtr := BasePtr;
  if dcfBasePtrInvalid in dcFlags then
    Exclude(dcFlags, dcfBasePtrInvalid);
  dcEndPtr := dcDataEndPtr;
  lDataSize := NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr);
  if (lDataSize <= High(Word)) or (wbGameMode = gmTES3) then
    srStruct.srsDataSize := lDataSize
  else
    //will need to write XXXX subrecord on save
    srStruct.srsDataSize := 0;
end;

procedure TwbSubRecord.NotifyChangedInternal(aContainer: Pointer);
begin
  if (srsIsArray in srStates) and (esModified in eStates) then begin
    CheckCount;
    CheckTerminator;
  end;
  inherited;
end;

procedure TwbSubRecord.PrepareSave;
begin
  if wbDelayLoadRecords then
    if not (esModified in eStates) then
      Exit;

  CheckCount;
  CheckTerminator;
  inherited;
  UpdateStorageFromElements;
end;

function TwbSubRecord.RemoveInjected(aCanRemove: Boolean): Boolean;
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  Result := False;
  if {(GetSignature = 'PTDT') or} (GetSignature = 'PLDT') then begin
    Assert(GetElementCount = 3);
    Result := GetElement(1).ReferencesInjected;
    if Result then begin
      GetElement(0).EditValue := '2';
      GetElement(1).EditValue := '00000000';
      Result := False;
    end;
  end else begin
    for i := High(cntElements) downto Low(cntElements) do
      if cntElements[i].CanContainFormIDs then begin
        Result := cntElements[i].RemoveInjected(True) or Result;
        if Result and aCanRemove then
          Break;
      end;
  end;
  if Result and aCanRemove and GetIsRemovable then begin
    Result := False;
    Remove;
  end;
end;

procedure TwbSubRecord.Reset;
begin
  ReleaseElements;
  srValueDef := nil;
  srStates := srStates - [srsIsArray, srsIsFlags, srsSorted, srsSortInvalid];
  inherited;
end;

function TwbSubRecord.ResetLeafFirst: Boolean;
begin
  Result := inherited ResetLeafFirst and (eExternalRefs = 0) and (cntElementRefs = 0);
end;

procedure TwbSubRecord.ResetMemoryOrder(aFrom: Integer = 0; aTo: Integer = High(Integer));
var
  SetSuffix : Boolean;
  i         : Integer;
begin
  SetSuffix := [srsIsArray, srsSorted] * srStates = [srsIsArray];
  aFrom := Max(aFrom, Low(cntElements));
  aTo := Min(aTo, High(cntElements));

  var lArrayDef: IwbArrayDef;
  SetSuffix := SetSuffix and Supports(srValueDef, IwbArrayDef, lArrayDef);

  for i := aFrom to aTo do begin
    cntElements[i].MemoryOrder := i;
    if SetSuffix then
      cntElements[i].NameSuffix := lArrayDef.ElementNameSuffix[i];
  end;
end;


procedure TwbSubRecord.ScanData;
begin
  { nothing }
end;

procedure TwbSubRecord.SetDef(const aDef: IwbSubRecordDef);
begin
  srDef := aDef;
  DoReset(True);
end;

procedure TwbSubRecord.SetEditValue(const aValue: string);
var
  SelfRef : IwbContainerElementRef;
  OldValue, NewValue: Variant;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  if not Assigned(srDef) then
    if aValue <> '' then
      raise Exception.Create(GetName + ' can not be edited')
    else
      Exit;

  DoInit(False);

  BeginUpdate;
  try
    if GetEditValue <> aValue then begin
      if Assigned(srValueDef) then begin
        OldValue := GetNativeValue;
        srValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
        SetModified(True);
        NewValue := GetNativeValue;
        DoAfterSet(OldValue, NewValue);
      end else
        raise Exception.Create(GetName + ' can not be edited');
      if (srsIsFlags in srStates) and (csInit in cntStates) then begin
        Reset;
        Init;
      end;
      NotifyChanged(eContainer);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TwbSubRecord.SetLinksTo(const aValue: IwbElement);
var
  SelfRef : IwbContainerElementRef;
  OldValue, NewValue: Variant;
  OldLinksTo: IwbElement;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  if not Assigned(srDef) then
    if Assigned(aValue) then
      raise Exception.Create(GetName + ' can not be edited')
    else
      Exit;

  DoInit(False);

  BeginUpdate;
  try
    OldLinksTo := srValueDef.LinksTo[dcDataBasePtr, dcDataEndPtr, Self];
    if (OldLinksTo <> aValue) and (not Assigned(OldLinksTo) or not OldLinksTo.Equals(aValue)) then begin
      if Assigned(srValueDef) then begin
        OldValue := GetNativeValue;
        srValueDef.LinksTo[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
        SetModified(True);
        NewValue := GetNativeValue;
        DoAfterSet(OldValue, NewValue);
      end else
        raise Exception.Create(GetName + ' can not be edited');
      if (srsIsFlags in srStates) and (csInit in cntStates) then begin
        Reset;
        Init;
      end;
      NotifyChanged(eContainer);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TwbSubRecord.SetModified(aValue: Boolean);
begin
  inherited;
  if aValue and (srsSorted in srStates) then
    Include(srStates, srsSortInvalid);
end;

procedure TwbSubRecord.SetNativeValue(const aValue: Variant);
var
  OldValue, NewValue: Variant;
  SelfRef : IwbContainerElementRef;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  if not Assigned(srDef) then
    raise Exception.Create(GetName + ' can not be edited');

  DoInit(False);

  BeginUpdate;
  try
    if Assigned(srValueDef) then begin
      OldValue := GetNativeValue;
      srValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
      SetModified(True);
      NewValue := GetNativeValue;
      DoAfterSet(OldValue, NewValue);
    end else
      raise Exception.Create(GetName + ' can not be edited');
    if (srsIsFlags in srStates) and (csInit in cntStates) then begin
      Reset;
      Init;
    end;
    NotifyChanged(eContainer);
  finally
    EndUpdate;
  end;
end;

procedure TwbSubRecord.SetToDefaultInternal;
var
  SelfRef: IwbContainerElementRef;
  BasePtr, EndPtr: Pointer;
  ArrayDef: IwbArrayDef;
  DefaultEditValues: TArray<string>;
  i: Integer;
begin
  SelfRef := Self as IwbContainerElementRef;

  if csInit in cntStates then
    DoReset(True);
  BasePtr := nil;
  EndPtr := nil;
  dcDataBasePtr := nil;
  dcDataEndPtr := nil;
  dcDataStorage := nil;
  DoInit(True);
  if Assigned(srValueDef) then
    RequestStorageChange(BasePtr, EndPtr, srValueDef.DefaultSize[nil, nil, Self]);
  inherited;
  if srsIsArray in srStates then begin
    if Supports(srValueDef, IwbArrayDef, ArrayDef) then begin
      DefaultEditValues := ArrayDef.GetDefaultEditValues;
      for i := 0 to Pred(Min(Length(DefaultEditValues), GetElementCount)) do
        cntElements[i].EditValue := DefaultEditValues[i];
    end;
    UpdateCountViaPath;
  end;
end;

function TwbSubRecord.srStruct: PwbSubRecordHeaderStruct;
begin
  Result := PwbSubRecordHeaderStruct(dcBasePtr);
end;

procedure TwbSubRecord.UpdateCountViaPath;
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self;

  var lArrayDef: IwbArrayDef;

  if Assigned(srResolvedDef) then
    if not Supports(srResolvedDef, IwbArrayDef, lArrayDef) then
      Exit;

  if not Assigned(lArrayDef) then
    if not Supports(srValueDef, IwbArrayDef, lArrayDef) then
      Exit;

  var lCountPath := (lArrayDef as IwbArrayDef).CountPath;

  if lCountPath = '' then
    Exit;

  var lContainer := GetContainer as IwbContainerElementRef;
  if not Assigned(lContainer) then
    Exit;

  var lElementCount := GetElementCount;

  if lElementCount > 0 then begin
    //setting it this way will try to create the elements along the path if necessary
    lContainer.ElementNativeValues[lCountPath] := lElementCount;
    Exit;
  end;

  //this way will prevent the creating of the Elements along the path if they don't already exist
  var lCounterElement := lContainer.ElementByPath[lCountPath];
  if not Assigned(lCounterElement) then
    Exit;

  lCounterElement.NativeValue := lElementCount;
end;

procedure TwbSubRecord.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
var
  CurrentPosition   : Int64;
  NewPosition       : Int64;
  BigDataSize       : Cardinal;
  SubHeader         : TwbSubRecordHeaderStruct;
  SelfRef           : IwbContainerElementRef;
begin
  if not (dcfDontSave in dcFlags) then begin
    if (esModified in eStates) or (dcfBasePtrInvalid in dcFlags) or wbTestWrite or (srStruct.srsDataSize = 0) then begin
      SelfRef := Self as IwbContainerElementRef;
      DoInit(True);

      if (aResetModified = rmYes) and (dcfStorageInvalid in dcFlags) then
        UpdateStorageFromElements;

      BigDataSize := GetDataSize;
      if (BigDataSize > High(Word)) and (wbGameMode <> gmTES3) then begin
        SubHeader.srsSignature := 'XXXX';
        SubHeader.srsDataSize := SizeOf(Cardinal);
        aStream.WriteBuffer(SubHeader, TwbSubRecordHeaderStruct.SizeOf );
        aStream.WriteBuffer(BigDataSize, SizeOf(BigDataSize) );
        SubHeader.srsSignature := srStruct.srsSignature;
        SubHeader.srsDataSize := 0;
      end else begin
        SubHeader.srsSignature := srStruct.srsSignature;
        SubHeader.srsDataSize := BigDataSize;
      end;

      aStream.WriteBuffer(SubHeader, TwbSubRecordHeaderStruct.SizeOf );
      CurrentPosition := aStream.Position;
      inherited;
      NewPosition := aStream.Position;
      if BigDataSize <> NewPosition - CurrentPosition then
        Assert(BigDataSize = NewPosition - CurrentPosition );

      if aResetModified = rmYes then begin
        Assert(not (dcfStorageInvalid in dcFlags), '[TwbSubRecord.WriteToStreamInternal] dcfStorageInvalid in dcFlags');
        Include(dcFlags, dcfBasePtrInvalid);
      end;
    end else begin
      aStream.WriteBuffer(dcBasePtr^, TwbSubRecordHeaderStruct.SizeOf );
      CurrentPosition := aStream.Position;
      inherited;
      if CurrentPosition + srStruct.srsDataSize <> aStream.Position then
        Assert(CurrentPosition + srStruct.srsDataSize = aStream.Position, 'CurrentPosition + srStruct.srsDataSize <> aStream.Position');
    end;
  end;

  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

{ TwbGroupRecord }

function TwbGroupRecord.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  Signature : TwbSignature;
  FormID    : TwbFormID;
  _File     : IwbFile;
  MainRecord: IwbMainRecord;
  MainRecords : TDynMainRecords;
  IsInjected: Boolean;
  Group     : IwbGroupRecord;
  i         : Integer;
  IsWorldCell: Boolean;
  s         : string;
  Params    : TArray<string>;
  Persistent: Boolean;
  GridCell  : TwbGridCell;
  SubBlock  : TwbGridCell;
  Block     : TwbGridCell;
  GrpType   : Integer;
  GrpLabel  : Cardinal;
  ChildGroup: IwbGroupRecord;

  SelfRef   : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := nil;
  if Length(aName) < 4 then
    Exit;
  Signature := StrToSignature(aName);

  case grStruct.grsGroupType of
    0: if Signature <> TwbSignature(grStruct.grsLabel) then
         Exit;
    1: if (Signature <> 'ROAD') and
          (Signature <> 'CELL') then
         Exit;
    7: if (Signature <> 'INFO') then
         Exit;
    6: begin
      Group := nil;
      GrpType := 9;
      MainRecord := GetChildrenOf;
      if not Assigned(MainRecord) then
        Exit;
      if MainRecord.IsPersistent then
        GrpType := 8;
      Group := FindChildGroup(GrpType, GetGroupLabel);
      if not Assigned(Group) then
        Group := TwbGroupRecord.Create(Self, GrpType, MainRecord);
      Result := Group.Add(aName, aSilent);
      Exit;
    end;
    8: if (Signature <> 'REFR') and
          (Signature <> 'ACRE') and
          (Signature <> 'PGRE') and
          (Signature <> 'PMIS') and
          (Signature <> 'PARW') and {>>> Skyrim <<<}
          (Signature <> 'PBEA') and {>>> Skyrim <<<}
          (Signature <> 'PFLA') and {>>> Skyrim <<<}
          (Signature <> 'PCON') and {>>> Skyrim <<<}
          (Signature <> 'PBAR') and {>>> Skyrim <<<}
          (Signature <> 'PHZD') and {>>> Skyrim <<<}
          (Signature <> 'ACHR') then
         Exit;
    9: if (Signature <> 'LAND') and
          (Signature <> 'PGRD') and
          (Signature <> 'NAVM') and
          (Signature <> 'REFR') and
          (Signature <> 'PGRE') and
          (Signature <> 'PMIS') and
          (Signature <> 'PARW') and {>>> Skyrim <<<}
          (Signature <> 'PBEA') and {>>> Skyrim <<<}
          (Signature <> 'PFLA') and {>>> Skyrim <<<}
          (Signature <> 'PCON') and {>>> Skyrim <<<}
          (Signature <> 'PBAR') and {>>> Skyrim <<<}
          (Signature <> 'PHZD') and {>>> Skyrim <<<}
          (Signature <> 'ACRE') and
          (Signature <> 'ACHR') then
         Exit;
   10: if (not wbVWDAsQuestChildren and (Signature <> 'REFR')) or
          (wbVWDAsQuestChildren and
             not ((Signature = 'REFR') or (Signature = 'DLBR') or (Signature = 'DIAL') or (Signature = 'SCEN')))
       then
         Exit;
  else
    Exit;
  end;

  _File := GetFile;
  if not Assigned(_File) then
    Exit;

  if Signature = 'ROAD' then begin
    if grStruct.grsGroupType <> 1 then
      raise Exception.Create('ROAD can only be added to groups of type 1');
    MainRecord := GetChildrenOf;
    if not Assigned(MainRecord) then
      raise Exception.Create('Can''t find MainRecord for group');
    if MainRecord.Signature <> 'WRLD' then
      raise Exception.Create('Expected WRLD record, but found: ' + MainRecord.Signature);
    MainRecords := MainRecord.AllVisibleForFile[_File];
    MainRecord := nil;
    for i := Low(MainRecords) to High(MainRecords) do begin
      MainRecord := MainRecords[i].ChildBySignature[Signature];
      if Assigned(MainRecord) then
        break;
    end;
    if Assigned(MainRecord) then begin
      if MainRecord._File.Equals(_File) then
        Exit(MainRecord);
      Result := wbCopyElementToFile(MainRecord, _File, false, true, '', '', '', '', False);
      Exit;
    end;
  end;

  if (Signature = 'LAND') or (Signature = 'PGRD') then begin
    if grStruct.grsGroupType <> 9 then
      raise Exception.Create(Signature + ' can only be added to groups of type 9');
    MainRecord := GetChildrenOf;
    if not Assigned(MainRecord) then
      raise Exception.Create('Can''t find MainRecord for group');
    if MainRecord.Signature <> 'CELL' then
      raise Exception.Create('Expected CELL record, but found: ' + MainRecord.Signature);
    MainRecords := MainRecord.AllVisibleForFile[_File];
    MainRecord := nil;
    for i := Low(MainRecords) to High(MainRecords) do begin
      MainRecord := MainRecords[i].ChildBySignature[Signature];
      if Assigned(MainRecord) then
        break;
    end;
    if Assigned(MainRecord) then begin
      if MainRecord._File.Equals(_File) then
        Exit(MainRecord);
      Result := wbCopyElementToFile(MainRecord, _File, false, true, '', '', '', '', False);
      Exit;
    end;
  end;

  IsWorldCell := (Signature = 'CELL') and (grStruct.grsGroupType = 1);

  if IsWorldCell then begin
    s := Copy(aName, 5);
    s := s.Trim;
    if s.StartsWith('[') and s.EndsWith(']') then begin
      Delete(s, 1, 1);
      Delete(s, Length(s), 1);
      Params := s.Split([',']).ForEach(Trim);
      if (Length(Params) = 1) and SameText(Params[0], 'P') then
        Persistent := True
      else if Length(Params) = 2 then begin
        Persistent := False;
        GridCell.x := StrToInt(Params[0]);
        GridCell.y := StrToInt(Params[1]);
      end else
        raise Exception.Create('Invalid Parameters: ' + aName);
    end else begin
      if aSilent then
        raise Exception.Create('To add a Worldspace CELL silently, parameters must be specified: CELL[P] for persistent world cell or CELL[x,y] for temporary cell');
      if not wbGetCellDetailsForWorldspace(GetChildrenOf, Persistent, GridCell) then
        Exit;
      if Persistent then begin
        GridCell.x := 0;
        GridCell.y := 0;
      end;
    end;

    MainRecord := GetChildrenOf;
    if not Assigned(MainRecord) then
      raise Exception.Create('Can''t find MainRecord for group');
    if MainRecord.Signature <> 'WRLD' then
      raise Exception.Create('Expected WRLD record, but found: ' + MainRecord.Signature);
    MainRecords := MainRecord.AllVisibleForFile[_File];
    MainRecord := nil;
    for i := Low(MainRecords) to High(MainRecords) do begin
      if Persistent then
        MainRecord := MainRecords[i].ChildBySignature['CELL']
      else
        MainRecord := MainRecords[i].ChildByGridCell[GridCell];
      if Assigned(MainRecord) then
        break;
    end;
    if Assigned(MainRecord) then begin
      if MainRecord._File.Equals(_File) then
        Exit(MainRecord);
      Result := wbCopyElementToFile(MainRecord, _File, false, true, '', '', '', '', False);
      Exit;
    end;
  end;

  if aSilent then
    if Signature = 'PLYR' then
      FormID := TwbFormID.FromCardinal($00000014)
    else
      FormID := _File.NewFormID
  else
    FormID := _File.LoadOrderFormIDtoFileFormID(wbGetFormID(Self), True);
  if FormID.IsNull then
    Exit;

  IsInjected := False;
  MainRecord := _File.RecordByFormID[FormID, True, True];
  if Assigned(MainRecord) then begin
    if _File.Equals(MainRecord._File) then
      raise Exception.Create('FormID [' + FormID.ToString(True) + '] is already defined in file "' + _File.Name + '"');

    IsInjected := _File.IsNewRecord(FormID, True);

    if MainRecord.Signature <> Signature then
      raise Exception.Create('Existing record ' + MainRecord.Name + ' has different signature');
  end;

  Group := Self;

  if IsWorldCell and not Persistent then begin
    SubBlock := wbSubBlockFromGridCell(GridCell);
    Block := wbBlockFromSubBlock(SubBlock);

    GrpLabel := wbGridCellToGroupLabel(Block);
    ChildGroup := Group.FindChildGroup(4, GrpLabel);
    if not Assigned(ChildGroup) then
      ChildGroup := TwbGroupRecord.Create(Group, 4, GrpLabel);
    Group := ChildGroup;

    GrpLabel := wbGridCellToGroupLabel(SubBlock);
    ChildGroup := Group.FindChildGroup(5, GrpLabel);
    if not Assigned(ChildGroup) then
      ChildGroup := TwbGroupRecord.Create(Group, 5, GrpLabel);
    Group := ChildGroup;
  end;

  Result := TwbMainRecord.Create(Group, Signature, FormID);
  if IsInjected then
    (MainRecord as IwbMainRecordInternal).YouGotAMaster(Result as IwbMainRecord);

  MainRecord := Result as IwbMainRecord;
  MainRecord.BeginUpdate;
  try
    if IsWorldCell then begin
      MainRecord.SetGridCell(GridCell);
      if Persistent then
        MainRecord.IsPersistent := True;
    end;
  finally
    MainRecord.EndUpdate;
  end;

  if csRefsBuild in _File.ContainerStates then
    Result.BuildRef;
end;

function RemovePrefix(const s, aPrefix: string): string;
begin
  if (s <> '') and (aPrefix <> '') and (Length(s) >= Length(aPrefix)) and SameText(Copy(s, 1, Length(aPrefix)), aPrefix) then
    Result := Copy(s, Succ(Length(aPrefix)), High(Integer))
  else
    Result := s;
end;

function RemoveSuffix(const s, aSuffix: string): string;
begin
  if (s <> '') and (aSuffix <> '') and (Length(s) >= Length(aSuffix)) and SameText(Copy(s, Succ(Length(s) - Length(aSuffix)) , Length(aSuffix)), aSuffix) then
    Result := Copy(s, 1, Length(s) - Length(aSuffix))
  else
    Result := s;
end;

procedure TwbGroupRecord.AddElement(const aElement: IwbElement);
var
  DialGroup : IwbGroupRecord;
  Container : IwbContainer;
  DialRec   : IwbMainRecord;
  i         : Integer;
begin
  if esUnsaved in aElement.ElementStates then  // Let's not penalised too much loading time.
    if ((TwbSignature(grStruct.grsLabel) = 'DIAL') or wbVWDAsQuestChildren) then  // Issue 86: https://code.google.com/p/skyrim-plugin-decoding-project/issues/detail?id=86
      if Supports(aElement, IwbGroupRecord, DialGroup) then // The DIAL GRUP must immediatly follow corresponding DIAL MainRecord.
        if DialGroup.GroupType = 7 then // Let's hope nobody messes up the groupType
          if Supports(Self, IwbContainer, Container) then
            if Container.ElementCount > 0 then
              for i := 0 to Pred(Container.ElementCount) - 1 do  // If we are reading the plugins and at the end don't bother moving data around.
                if Supports(Container.Elements[i], IwbMainRecord, DialRec) then
                  if DialRec.Signature = 'DIAL' then
                    if DialRec.FormID.ToCardinal = DialGroup.GroupLabel then begin
                      InsertElement(i + 1, aElement);
                      Exit;
                    end;
    inherited;
end;

function TwbGroupRecord.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  SelfRef      : IwbContainerElementRef;
  _File        : IwbFile;

  procedure CopyMainRecord(const aSource: IwbMainRecord);
  begin
    Result := nil;

    if wbIsStarfield and wbStarfieldIsABugInfestedHellhole then begin
      if aSource.LoadOrderFormID.ToCardinal = $25 then
        Exit;

      if (aSource.Signature = 'PKIN') and not aAsNew then begin
        var lSourceName := aElement.FullPath;
        var lTargetName := GetFullPath;
        wbProgress('Error adding [%s] to [%s]: %s', [lSourceName, lTargetName, 'Pack-In overrides don''t work correctly in Starfield']);
        Exit;
      end;

      if aElement.ContainsReflection then begin
        var lSourceName := aElement.FullPath;
        var lTargetName := GetFullPath;
        wbProgress('Error adding [%s] to [%s]: %s', [lSourceName, lTargetName, 'Source contains Reflection and can not be copied']);
        Exit;
      end;
    end;

    if aElement.ContainsUnmappedFormID then
      if Assigned(_File) and (_File.FileStates * [fsIsGameMaster, fsIsHardcoded] = []) then
        if (_File.MasterCount[True] < 1) or (_File.Masters[0, True].FileStates * [fsIsGameMaster] = []) then begin
          var lSourceName := aElement.FullPath;
          var lTargetName := GetFullPath;
          wbProgress('Error adding [%s] to [%s]: %s', [lSourceName, lTargetName, 'Source contains Unmapped FormID and can not be copied into a module which does not have the game master as its first master']);
          Exit;
        end;

    var lFormID := TwbFormID.Null;
    if aAsNew then
      lFormID := _File.NewFormID
    else begin
      Result := _File.ContainedRecordByLoadOrderFormID[aSource.LoadOrderFormID, False];
      if Assigned(Result) then
        lFormID := (Result as IwbMainRecord).FixedFormID
      else
        lFormID := _File.LoadOrderFormIDtoFileFormID(aSource.LoadOrderFormID, True);
    end;

    var lIsNew := False;

    if not Assigned(Result) then begin

      Result := TwbMainRecord.Create(Self, aSource.Signature, lFormID);
      lIsNew := True;

    end else begin

      if not aAllowOverwrite then
        Exit;

      if aDeepCopy then begin
        case wbCanOverwrite(Result, aElement) of
          coCopy: begin
            if not Equals(Result.Container) then begin
              Result.Remove;
              Result := nil;
              Result := TwbMainRecord.Create(Self, aSource.Signature, lFormID);
            end;
          end;
          coDelete: begin
            Result.Remove;
            Exit;
          end;
          coSkip:
            Exit;
        end;
      end else
        Exit;

    end;

    if aDeepCopy then begin
      var lResult := Result as IwbMainRecord;

      if not aSource.IsDeleted then
        lResult.IsDeleted := False;
      if not aSource.IsPartialForm then begin
        if lIsNew and wbAllowMakePartial and lResult.CanBePartial then
          lResult.IsPartialForm := True
        else
          lResult.IsPartialForm := False;
      end else
        lResult.IsPartialForm := True;

      if not (lResult.IsPartialForm or lResult.IsDeleted) then
        Result.Assign(wbAssignThis, aElement, False);

      if not lResult.IsDeleted and (aSource.EditorID <> '') then begin
        var lEditorID := aSource.EditorID;
        lEditorID := RemovePrefix(lEditorID, aPrefixRemove);
        lEditorID := RemoveSuffix(lEditorID, aSuffixRemove);
        if wbBeginInternalEdit(True) then try
          lResult.EditorID := aPrefix + lEditorID + aSuffix;
        finally
          wbEndInternalEdit;
        end;
      end;
    end;

    if not aAsNew and aSource.IsMaster then
      if (Result._File.LoadOrder < aSource._File.LoadOrder) or
        ((Result._File.LoadOrder = aSource._File.LoadOrder) and not (fsIsCompareLoad in Result._File.FileStates) )
      then begin
        var lMainRecordResult: IwbMainRecord;
        if Supports(Result, IwbMainRecord, lMainRecordResult) then
          (aSource as IwbMainRecordInternal).YouGotAMaster(lMainRecordResult);
      end;

    if Assigned(Result) and (csRefsBuild in Result._File.ContainerStates) then
      Result.BuildRef;
  end;


begin
  Result := nil;
  SelfRef := Self as IwbContainerElementRef;
  _File := GetFile;
  if not Assigned(_File) then begin
    wbTick;
    Exit;
  end;

  var lElementContainerElementRef: IwbContainerElementRef;
  Supports(aElement, IwbContainerElementRef, lElementContainerElementRef);

  case grStruct.grsGroupType of
    0: begin
      if TwbSignature(grStruct.grsLabel) = 'DIAL' then begin
        var lGroupRecord0Dial: IwbGroupRecord;
        if Supports(aElement, IwbGroupRecord, lGroupRecord0Dial) then begin
          if lGroupRecord0Dial.GroupType <> 7 then
            raise Exception.Create('Can''t add ' + lGroupRecord0Dial.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          var lSourceMainRecord0Dial := lGroupRecord0Dial.ChildrenOf;
          if not Assigned(lSourceMainRecord0Dial) then
            raise Exception.Create('Can''t find record for ' + lGroupRecord0Dial.Name);
          lSourceMainRecord0Dial := lSourceMainRecord0Dial.HighestOverrideVisibleForFile[_File];
          var lTargetMainRecord0Dial := AddIfMissingInternal(lSourceMainRecord0Dial, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!}) as IwbMainRecord;
          if Assigned(lTargetMainRecord0Dial) then begin
            Result := lTargetMainRecord0Dial.ChildGroup;
            if not Assigned(Result) then
              Result := TwbGroupRecord.Create(Self, 7, lTargetMainRecord0Dial);

            if aDeepCopy then begin
              var lContainerElementRef0DialResult: IwbContainerElementRef;
              if Supports(Result, IwbContainerElementRef, lContainerElementRef0DialResult) then begin
                lContainerElementRef0DialResult.BeginUpdate;
                try
                  for var lGroupRecord0DialElementIdx := 0 to Pred(lGroupRecord0Dial.ElementCount) do
                    lContainerElementRef0DialResult.AddIfMissing(lGroupRecord0Dial.Elements[lGroupRecord0DialElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
                finally
                  lContainerElementRef0DialResult.EndUpdate;
                end;
              end;
            end;
          end;

          Exit;
        end;
      end else if TwbSignature(grStruct.grsLabel) = 'CELL' then begin
        var lGroupRecord0Cell: IwbGroupRecord;
        if Supports(aElement, IwbGroupRecord, lGroupRecord0Cell) then begin
          if lGroupRecord0Cell.GroupType <> 2 then
            raise Exception.Create('Can''t add ' + lGroupRecord0Cell.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          if lGroupRecord0Cell.GroupLabel > 9 then
            raise Exception.Create('Can''t add ' + lGroupRecord0Cell.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          for var lSelfElementIndex0Cell := 0 to Pred(GetElementCount) do begin
            var lGroupRecord0Cell2: IwbGroupRecord;
            if Supports(GetElement(lSelfElementIndex0Cell), IwbGroupRecord, lGroupRecord0Cell2) then begin
              if (lGroupRecord0Cell2.GroupType = 2) and (lGroupRecord0Cell2.GroupLabel = lGroupRecord0Cell.GroupLabel) then begin
                Result := lGroupRecord0Cell2;
                break;
              end;
            end;
          end;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 2, lGroupRecord0Cell.GroupLabel);

          if aDeepCopy then begin
            var lContainerElementRef0CellResult: IwbContainerElementRef;
            if Supports(Result, IwbContainerElementRef, lContainerElementRef0CellResult) then begin
              lContainerElementRef0CellResult.BeginUpdate;
              try
                for var lGroupRecord0CellElementIdx := 0 to Pred(lGroupRecord0Cell.ElementCount) do
                  lContainerElementRef0CellResult.AddIfMissing(lGroupRecord0Cell.Elements[lGroupRecord0CellElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
              finally
                lContainerElementRef0CellResult.EndUpdate;
              end;
            end;
          end;

          Exit;
        end;
      end else if TwbSignature(grStruct.grsLabel) = 'WRLD' then begin
        var lGroupRecord0Wrld: IwbGroupRecord;
        if Supports(aElement, IwbGroupRecord, lGroupRecord0Wrld) then begin
          if lGroupRecord0Wrld.GroupType <> 1 then
            raise Exception.Create('Can''t add ' + lGroupRecord0Wrld.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          var lSourceMainRecord0Wrld := lGroupRecord0Wrld.ChildrenOf;
          if not Assigned(lSourceMainRecord0Wrld) then
            raise Exception.Create('Can''t find record for ' + lGroupRecord0Wrld.Name);
          lSourceMainRecord0Wrld := lSourceMainRecord0Wrld.HighestOverrideVisibleForFile[_File];
          var lTargetMainRecord0Wrld := AddIfMissingInternal(lSourceMainRecord0Wrld, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!}) as IwbMainRecord;
          if Assigned(lTargetMainRecord0Wrld) then begin
            Result := lTargetMainRecord0Wrld.ChildGroup;
            if not Assigned(Result) then
              Result := TwbGroupRecord.Create(Self, 1, lTargetMainRecord0Wrld);

            if aDeepCopy then begin
              var lContainerElementRef0WrldResult: IwbContainerElementRef;
              if Supports(Result, IwbContainerElementRef, lContainerElementRef0WrldResult) then begin
                lContainerElementRef0WrldResult.BeginUpdate;
                try
                  for var lGroupRecord0WrldElementIdx := 0 to Pred(lGroupRecord0Wrld.ElementCount) do
                    lContainerElementRef0WrldResult.AddIfMissing(lGroupRecord0Wrld.Elements[lGroupRecord0WrldElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
                finally
                  lContainerElementRef0WrldResult.EndUpdate;
                end;
              end;
            end;
          end;

          Exit;
        end;
      end else if wbVWDAsQuestChildren and (TwbSignature(grStruct.grsLabel) = 'QUST') then begin
        var lGroupRecord0Qust: IwbGroupRecord;
        if Supports(aElement, IwbGroupRecord, lGroupRecord0Qust) then begin
          if lGroupRecord0Qust.GroupType <> 10 then
            raise Exception.Create('Can''t add ' + lGroupRecord0Qust.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          var lSourceMainRecord0Qust := lGroupRecord0Qust.ChildrenOf;
          if not Assigned(lSourceMainRecord0Qust) then
            raise Exception.Create('Can''t find record for ' + lGroupRecord0Qust.Name);
          lSourceMainRecord0Qust := lSourceMainRecord0Qust.HighestOverrideVisibleForFile[_File];
          var lTargetMainRecord0Qust := AddIfMissingInternal(lSourceMainRecord0Qust, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!}) as IwbMainRecord;
          if Assigned(lTargetMainRecord0Qust) then begin
            Result := lTargetMainRecord0Qust.ChildGroup;
            if not Assigned(Result) then
              Result := TwbGroupRecord.Create(Self, 10, lTargetMainRecord0Qust);

            if aDeepCopy then begin
              var lContainerElementRef0QustResult: IwbContainerElementRef;
              if Supports(Result, IwbContainerElementRef, lContainerElementRef0QustResult) then begin
                lContainerElementRef0QustResult.BeginUpdate;
                try
                  for var lGroupRecord0QustElementIdx := 0 to Pred(lGroupRecord0Qust.ElementCount) do
                    lContainerElementRef0QustResult.AddIfMissing(lGroupRecord0Qust.Elements[lGroupRecord0QustElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
                finally
                  lContainerElementRef0QustResult.EndUpdate;
                end;
              end;
            end;
          end;

          Exit;
        end;
      end;
      begin
        var lMainRecord0: IwbMainRecord;
        if not Supports(aElement, IwbMainRecord, lMainRecord0) then
          raise Exception.Create('Only main records can be added to top level groups');
        if lMainRecord0.Signature <> TwbSignature(grStruct.grsLabel) then
          raise Exception.Create('Can''t add main record with signature ' + lMainRecord0.Signature + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
        CopyMainRecord(lMainRecord0);
      end;
    end;
    1: begin
      var lGroupRecord1: IwbGroupRecord;
      if Supports(aElement, IwbGroupRecord, lGroupRecord1) then begin
        if lGroupRecord1.GroupType = 4 then begin
          for var lSelfElementIndex1 := 0 to Pred(GetElementCount) do begin
            var lGroupRecord1Child: IwbGroupRecord;
            if Supports(GetElement(lSelfElementIndex1), IwbGroupRecord, lGroupRecord1Child) then begin
              if (lGroupRecord1Child.GroupType = lGroupRecord1.GroupType) and (lGroupRecord1Child.GroupLabel = lGroupRecord1.GroupLabel) then begin
                Result := lGroupRecord1Child;
                break;
              end;
            end;
          end;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 4, lGroupRecord1.GroupLabel);

          if aDeepCopy then begin
            var lContainerElementRef1Result: IwbContainerElementRef;
            if Supports(Result, IwbContainerElementRef, lContainerElementRef1Result) then begin
              lContainerElementRef1Result.BeginUpdate;
              try
                for var lGroupRecord1ElementIdx := 0 to Pred(lGroupRecord1.ElementCount) do
                  lContainerElementRef1Result.AddIfMissing(lGroupRecord1.Elements[lGroupRecord1ElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
              finally
                lContainerElementRef1Result.EndUpdate;
              end;
            end;
          end;

          Exit;
        end;
        if lGroupRecord1.GroupType <> 6 then
          raise Exception.Create('Can''t add ' + lGroupRecord1.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
        var lSourceMainRecord1 := lGroupRecord1.ChildrenOf;
        if not Assigned(lSourceMainRecord1) then
          raise Exception.Create('Can''t find record for ' + lGroupRecord1.Name);
        lSourceMainRecord1 := lSourceMainRecord1.HighestOverrideVisibleForFile[_File];
        var lTargetMainRecord1 := AddIfMissingInternal(lSourceMainRecord1, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!}) as IwbMainRecord;
        if Assigned(lTargetMainRecord1) then begin
          Result := lTargetMainRecord1.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 6, lTargetMainRecord1);

          if aDeepCopy then begin
            var lContainerElementRef1bResult: IwbContainerElementRef;
            if Supports(Result, IwbContainerElementRef, lContainerElementRef1bResult) then begin
              lContainerElementRef1bResult.BeginUpdate;
              try
                for var lGroupRecord1bElementIndex := 0 to Pred(lGroupRecord1.ElementCount) do
                  lContainerElementRef1bResult.AddIfMissing(lGroupRecord1.Elements[lGroupRecord1bElementIndex], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
              finally
                lContainerElementRef1bResult.EndUpdate;
              end;
            end;
          end;
        end;

        Exit;
      end;
      begin
        var lMainRecord1: IwbMainRecord;
        if not Supports(aElement, IwbMainRecord, lMainRecord1) then
          raise Exception.Create('Only main records can be added to ' + GetName);
        if (lMainRecord1.Signature <> 'CELL') and (lMainRecord1.Signature <> 'ROAD') then
          raise Exception.Create('Can''t add main record with signature ' + lMainRecord1.Signature + ' to ' + GetName);

        if aAsNew then
          raise Exception.Create('Can''t copy record ' + lMainRecord1.Name + ' as new record.');

        CopyMainRecord(lMainRecord1);
      end;
    end;
    2, 4: begin
      var lGroupRecord24: IwbGroupRecord;
      if Supports(aElement, IwbGroupRecord, lGroupRecord24) then begin
        if lGroupRecord24.GroupType <> grStruct.grsGroupType + 1 then
          raise Exception.Create('Can''t add ' + lGroupRecord24.Name + ' to ' + GetName);
        for var lSelfElementIndex24 := 0 to Pred(GetElementCount) do begin
          var lGroupRecord24Child: IwbGroupRecord;
          if Supports(GetElement(lSelfElementIndex24), IwbGroupRecord, lGroupRecord24Child) then begin
            if (lGroupRecord24Child.GroupType = lGroupRecord24.GroupType) and (lGroupRecord24Child.GroupLabel = lGroupRecord24.GroupLabel) then begin
              Result := lGroupRecord24Child;
              break;
            end;
          end;
        end;
        if not Assigned(Result) then
          Result := TwbGroupRecord.Create(Self, lGroupRecord24.GroupType, lGroupRecord24.GroupLabel);

        if aDeepCopy then begin
          var lContainerElementRef24Result: IwbContainerElementRef;
          if Supports(Result, IwbContainerElementRef, lContainerElementRef24Result) then begin
            lContainerElementRef24Result.BeginUpdate;
            try
              for var lGroupRecord24ElementIdx := 0 to Pred(lGroupRecord24.ElementCount) do
                lContainerElementRef24Result.AddIfMissing(lGroupRecord24.Elements[lGroupRecord24ElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
            finally
              lContainerElementRef24Result.EndUpdate;
            end;
          end;
        end;

        Exit;
      end;
      raise Exception.Create('Can''t add ' + aElement.Name + ' to ' + GetName);
    end;
    3, 5: begin
      var lGroupRecord35: IwbGroupRecord;
      if Supports(aElement, IwbGroupRecord, lGroupRecord35) then begin
        if lGroupRecord35.GroupType <> 6 then
          raise Exception.Create('Can''t add ' + lGroupRecord35.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
        var lSourceMainRecord35 := lGroupRecord35.ChildrenOf;
        if not Assigned(lSourceMainRecord35) then
          raise Exception.Create('Can''t find record for ' + lGroupRecord35.Name);
        lSourceMainRecord35 := lSourceMainRecord35.HighestOverrideVisibleForFile[_File];
        var lTargetMainRecord35 := AddIfMissingInternal(lSourceMainRecord35, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!}) as IwbMainRecord;
        if Assigned(lTargetMainRecord35) then begin
          Result := lTargetMainRecord35.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 6, lTargetMainRecord35);

          if aDeepCopy then begin
            var lContainerElementRef35Result: IwbContainerElementRef;
            if Supports(Result, IwbContainerElementRef, lContainerElementRef35Result) then begin
              lContainerElementRef35Result.BeginUpdate;
              try
                for var lGroupRecord35ElementIdx := 0 to Pred(lGroupRecord35.ElementCount) do
                  lContainerElementRef35Result.AddIfMissing(lGroupRecord35.Elements[lGroupRecord35ElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
              finally
                lContainerElementRef35Result.EndUpdate;
              end;
            end;
          end;
        end;

        Exit;
      end;

      begin
        var lMainRecord35: IwbMainRecord;
        if not Supports(aElement, IwbMainRecord, lMainRecord35) then
          raise Exception.Create('Only main records can be added to ' + GetName);
        if lMainRecord35.Signature <> 'CELL' then
          raise Exception.Create('Can''t add main record with signature ' + lMainRecord35.Signature + ' to ' + GetName);

        if aAsNew then
          raise Exception.Create('Can''t copy record ' + lMainRecord35.Name + ' as new record.');

        CopyMainRecord(lMainRecord35);
      end;
    end;
    6: begin
      var lGroupRecord6: IwbGroupRecord;
      if Supports(aElement, IwbGroupRecord, lGroupRecord6) then begin
        if not (lGroupRecord6.GroupType in [8, 9, 10]) then
          raise Exception.Create('Can''t add ' + lGroupRecord6.Name + ' to ' + GetName);
        for var lSelfElementIndex6 := 0 to Pred(GetElementCount) do begin
          var lGroupRecord6Child: IwbGroupRecord;
          if Supports(GetElement(lSelfElementIndex6), IwbGroupRecord, lGroupRecord6Child) then begin
            if lGroupRecord6Child.GroupType = lGroupRecord6.GroupType then begin
              Result := lGroupRecord6Child;
              break;
            end;
          end;
        end;
        if not Assigned(Result) then
          Result := TwbGroupRecord.Create(Self, lGroupRecord6.GroupType, Self.GetChildrenOf);

        if aDeepCopy then begin
          var lContainerElementRef6Result: IwbContainerElementRef;
          if Supports(Result, IwbContainerElementRef, lContainerElementRef6Result) then begin
            lContainerElementRef6Result.BeginUpdate;
            try
              for var lGroupRecord6ElementIdx := 0 to Pred(lGroupRecord6.ElementCount) do
                lContainerElementRef6Result.AddIfMissing(lGroupRecord6.Elements[lGroupRecord6ElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
            finally
              lContainerElementRef6Result.EndUpdate;
            end;
          end;
        end;

        Exit;
      end;
      raise Exception.Create('Can''t add ' + aElement.Name + ' to ' + GetName);
    end;
    7: begin
      var lMainRecord7: IwbMainRecord;
      if not Supports(aElement, IwbMainRecord, lMainRecord7) then
        raise Exception.Create('Only main records can be added to ' + GetName);
      if lMainRecord7.Signature <> 'INFO' then
        raise Exception.Create('Can''t add main record with signature ' + lMainRecord7.Signature + ' to ' + GetName);

      CopyMainRecord(lMainRecord7);
    end;
    8, 9, 10: begin
      var lGroupRecord8910: IwbGroupRecord;
      if wbVWDAsQuestChildren and Supports(aElement, IwbGroupRecord, lGroupRecord8910) then begin
        if lGroupRecord8910.GroupType <> 7 then
          raise Exception.Create('Can''t add ' + lGroupRecord8910.Name + ' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
        var lSourceMainRecord8910 := lGroupRecord8910.ChildrenOf;
        if not Assigned(lSourceMainRecord8910) then
          raise Exception.Create('Can''t find record for ' + lGroupRecord8910.Name);
        lSourceMainRecord8910 := lSourceMainRecord8910.HighestOverrideVisibleForFile[_File];
        var lTargetMainRecord8910 := AddIfMissingInternal(lSourceMainRecord8910, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!}) as IwbMainRecord;
        if Assigned(lTargetMainRecord8910) then begin
          Result := lTargetMainRecord8910.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 7, lTargetMainRecord8910);

          if aDeepCopy then begin
            var lContainerElementRef8910Result: IwbContainerElementRef;
            if Supports(Result, IwbContainerElementRef, lContainerElementRef8910Result) then begin
              lContainerElementRef8910Result.BeginUpdate;
              try
                for var lGroupRecord8910ElementIdx := 0 to Pred(lGroupRecord8910.ElementCount) do
                  lContainerElementRef8910Result.AddIfMissing(lGroupRecord8910.Elements[lGroupRecord8910ElementIdx], aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite {CheckMe!});
              finally
                lContainerElementRef8910Result.EndUpdate;
              end;
            end;
          end;
        end;

        Exit;
      end;
      begin
        var lMainRecord8910: IwbMainRecord;
        if not Supports(aElement, IwbMainRecord, lMainRecord8910) then
          raise Exception.Create('Only main records can be added to ' + GetName);
        if (lMainRecord8910.Signature <> 'REFR') and
           (lMainRecord8910.Signature <> 'ACHR') and
           (lMainRecord8910.Signature <> 'ACRE') and
           (lMainRecord8910.Signature <> 'PGRE') and
           (lMainRecord8910.Signature <> 'PMIS') and
           (lMainRecord8910.Signature <> 'PARW') and {>>> Skyrim <<<}
           (lMainRecord8910.Signature <> 'PBEA') and {>>> Skyrim <<<}
           (lMainRecord8910.Signature <> 'PFLA') and {>>> Skyrim <<<}
           (lMainRecord8910.Signature <> 'PCON') and {>>> Skyrim <<<}
           (lMainRecord8910.Signature <> 'PBAR') and {>>> Skyrim <<<}
           (lMainRecord8910.Signature <> 'PHZD')     {>>> Skyrim <<<}
        then
          // check any non reference record
          if not (
            // DIAL, DLBR and SCEN can be added to child group 10 (quest children)
            (wbVWDAsQuestChildren and (grStruct.grsGroupType = 10) and ((lMainRecord8910.Signature = 'DLBR') or (lMainRecord8910.Signature = 'DIAL') or (lMainRecord8910.Signature = 'SCEN')))
            or
            // PGRD, LAND and NAVM can be added to child group 9 (temporary)
            (grStruct.grsGroupType = 9) and ((lMainRecord8910.Signature = 'PGRD') or (lMainRecord8910.Signature = 'LAND') or (lMainRecord8910.Signature = 'NAVM'))
          ) then
            raise Exception.Create('Can''t add main record with signature ' + lMainRecord8910.Signature + ' to ' + GetName);

        CopyMainRecord(lMainRecord8910);
      end;
    end;
  else
    raise Exception.Create(ClassName + '.AddIfMissingInternal is not implemented for GroupType ' + IntToStr(grStruct.grsGroupType));
  end;
end;

procedure TwbGroupRecord.AfterConstruction;
begin
  if Assigned(grDuplicateOf) then try
    if wbBeginInternalEdit(True) then try
      var s := grDuplicateOf.ShortName;
      var Container := GetContainer;
      if GetElementCount = 0 then begin
        if Assigned(Container) then
          Container.RemoveElement(Self, True);
        raise EwbSkipLoad.Create('Skipped empty duplicate group "' + s + '"');
      end else begin
        var j := 0;
        grDuplicateOf.BeginUpdate;
        try
          BeginUpdate;
          try
            while GetElementCount > 0 do begin
              var SrcGrp: IwbGroupRecord;
              if Supports(GetElement(0), IwbGroupRecord, SrcGrp) then begin
                var TrgGrp := grDuplicateOf.FindChildGroup(SrcGrp.GroupType, SrcGrp.GroupLabel);
                if Assigned(TrgGrp) then begin
                  SrcGrp.BeginUpdate;
                  try
                    TrgGrp.BeginUpdate;
                    try
                      while SrcGrp.ElementCount > 0 do begin
                        TrgGrp.AddElement(SrcGrp.RemoveElement(0, True));
                        Inc(j);
                      end;
                    finally
                      TrgGrp.EndUpdate;
                    end;
                  finally
                    SrcGrp.EndUpdate;
                  end;
                  RemoveElement(0, True);
                  SrcGrp := nil;
                  (TrgGrp as IwbGroupRecordInternal).Sort;
                  (TrgGrp as IwbGroupRecordInternal).SetModified(True);
                  TrgGrp := nil;
                  Continue;
                end;
                Inc(j, SrcGrp.ElementCount);
                SrcGrp := nil;
              end else
                Inc(j);
              grDuplicateOf.AddElement(RemoveElement(0, True));
            end;
          finally
            EndUpdate;
          end;
        finally
          grDuplicateOf.EndUpdate;
        end;
        if Assigned(Container) then
          Container.RemoveElement(Self, True);
        (grDuplicateOf as IwbGroupRecordInternal).Sort;
        (grDuplicateOf as IwbGroupRecordInternal).SetModified(True);
        raise EwbSkipLoad.Create('Merged ' + j.ToString + ' elements from duplicate group into "' + s + '"');
      end;
    finally
      wbEndInternalEdit;
    end;
  finally
    grDuplicateOf := nil;
  end;
  inherited;
end;

procedure TwbGroupRecord.BuildRef;
var
  Rec: IwbMainRecord;
begin
  inherited;
  if GetGroupType in [1, 6, 7] then begin
    Rec := (GetFile as IwbFileInternal).RecordByFormID[TwbFormID.FromCardinal(GetGroupLabel), False, GetMastersUpdated];
    if Assigned(Rec) then begin
      if Rec._File.Equals(GetFile) then
        (Rec as IwbMainRecordInternal).SetChildGroup(Self)
      else begin
        if wbHasProgressCallback then
          wbProgressCallback('<Warning: File ' + GetFile.Name + ' with Group ' + GetName + ' is missing an overriden record for ' + Rec.Name);
      end;
    end;
  end;
end;

constructor TwbGroupRecord.Create(const aContainer: IwbContainer; aType: Integer; const aMainRecord: IwbMainRecord);
var
  BasePtr : PwbGroupRecordStruct;
  EndPtr  : Pointer;
begin
  Assert(Assigned(aContainer));
  Assert(Assigned(aMainRecord));
  Assert(aContainer._File.Equals(aMainRecord._File));
  Assert(aType in [1, 6, 7, 8, 9, 10]);

  if aType in [1, 6, 7] then
    Assert(aContainer.Equals(aMainRecord.Container));

  case aType of
    1: Assert(aMainRecord.Signature = 'WRLD');
    6, 8, 9: Assert(aMainRecord.Signature = 'CELL');
    10: Assert(
      (aMainRecord.Signature = 'CELL') or
      (wbVWDAsQuestChildren and (aMainRecord.Signature = 'QUST'))
    );
    7: Assert(aMainRecord.Signature = 'DIAL');
  end;

  Assert(aContainer.ElementType = etGroupRecord);

  New(BasePtr);
  BasePtr.grsSignature := 'GRUP';
  BasePtr.grsGroupSize := wbSizeOfMainRecordStruct;
  BasePtr.grsLabel := aMainRecord.FormID.ToCardinal;
  BasePtr.grsGroupType := aType;
  BasePtr.grsStamp := 0;
  BasePtr.grsUnknown := 0;
  Include(eStates, esUnsaved);
  EndPtr := nil;
  Create(aContainer, Pointer(BasePtr), EndPtr, nil);
  SetModified(True);
  InvalidateStorage;
  BuildRef;
  (aContainer as IwbGroupRecordInternal).Sort;
end;

function TwbGroupRecord.CanCopy: Boolean;
var
  RecordDef: PwbMainRecordDef;
begin
  Result := True;
  if not wbIsInternalEdit then
    if (grStruct.grsGroupType = 0) and wbFindRecordDef(PwbSignature(@grStruct.grsLabel)^, RecordDef) then
      if dfInternalEditOnly in RecordDef.DefFlags then
        Exit(False);
end;

procedure TwbGroupRecord.ContainerChanged;
var
  i           : Integer;
  ContainedIn : IwbContainedIn;
begin
  for i := 0 to Pred(GetElementCount) do
    if Supports(GetElement(i), IwbContainedIn, ContainedIn) then
      ContainedIn.ContainerChanged;
end;

constructor TwbGroupRecord.Create(const aContainer: IwbContainer; aType: Integer; aLabel: Cardinal);
var
  BasePtr : PwbGroupRecordStruct;
  EndPtr  : Pointer;
begin
  Assert(Assigned(aContainer));
  Assert(aType in [2, 3, 4, 5]);
  Assert(aContainer.ElementType = etGroupRecord);

  New(BasePtr);
  BasePtr.grsSignature := 'GRUP';
  BasePtr.grsGroupSize := wbSizeOfMainRecordStruct;
  BasePtr.grsLabel := aLabel;
  BasePtr.grsGroupType := aType;
  BasePtr.grsStamp := 0;
  BasePtr.grsUnknown := 0;
  EndPtr := nil;
  Create(aContainer, Pointer(BasePtr), EndPtr, nil);
  SetModified(True);
  InvalidateStorage;
  (aContainer as IwbGroupRecordInternal).Sort;
end;

constructor TwbGroupRecord.Create(const aContainer: IwbContainer; const aSignature: TwbSignature);
var
  BasePtr : PwbGroupRecordStruct;
  EndPtr  : Pointer;
begin
  New(BasePtr);
  BasePtr.grsSignature := 'GRUP';
  BasePtr.grsGroupSize := wbSizeOfMainRecordStruct;
  BasePtr.grsLabel := Cardinal(aSignature);
  BasePtr.grsGroupType := 0;
  BasePtr.grsStamp := 0;
  BasePtr.grsUnknown := 0;
  EndPtr := nil;
  Create(aContainer, Pointer(BasePtr), EndPtr, nil);
  SetModified(True);
  InvalidateStorage;
end;

destructor TwbGroupRecord.Destroy;
begin
  if Assigned(dcBasePtr) and not Assigned(dcEndPtr) then begin
    FreeMem(dcBasePtr, SizeOf(TwbGroupRecordStruct));
    dcBasePtr := nil;
  end;
  inherited;
end;

function TwbGroupRecord.FindChildGroup(aType: Integer; const aMainRecord: IwbMainRecord): IwbGroupRecord;
begin
  if not Assigned(aMainRecord) then
    Exit(nil);
  Result := FindChildGroup(aType, aMainRecord.FormID.ToCardinal);
end;

function TwbGroupRecord.FindChildGroup(aType: Integer; const aLabel: Cardinal): IwbGroupRecord;
var
  SelfRef : IwbContainerElementRef;
  i       : Integer;
begin
  Result := nil;

  SelfRef := Self;
  DoInit(False);
  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbGroupRecord, Result) then
      if Result.GroupType = aType then
        if Result.GroupLabel = aLabel then
          Exit;
  Result := nil;
end;

procedure TwbGroupRecord.FindUsedMasters(aMasters: PwbUsedMasters);
begin
  inherited;

  if grStruct.grsGroupType in [1, 6..10] then begin
    if grStruct.grsLabel <> 0 then begin
      var lFormID := TwbFormID.FromCardinal(GetGroupLabel);

      var lFile := GetFile;

      if lFormID.ObjectID < $800 then begin
        var lMasterZeroIsGameMaster := False;
        var lAllowHardcodedRangeUse := False;
        if Assigned(lFile) then begin
          lAllowHardcodedRangeUse := lFile.GetAllowHardcodedRangeUse;
          if lFile.MasterCount[True] > 0 then begin
            var lMaster := lFile.Masters[0, True];
            if Assigned(lMaster) and (lMaster.FileStates * [fsIsGameMaster, fsIsHardcoded] <> []) then
              lMasterZeroIsGameMaster := True;
          end;
        end;

        if lAllowHardcodedRangeUse then begin
          if lFormID.IsHardcoded then begin
            if lMasterZeroIsGameMaster then
              aMasters[0] := True;
            Exit;
          end;
        end else begin
          if lMasterZeroIsGameMaster then
            aMasters[0] := True;
          Exit;
        end;
      end;

      if Assigned(lFile) then begin
        var lMasterIndex := lFile.GetMasterIndexForFileID(lFormID.FileID, True);
        if lMasterIndex >= 0 then
          aMasters[lMasterIndex] := True;
      end;
    end;
  end;
end;

function TwbGroupRecord.GetAddList: TDynStrings;
var
  i, j        : Integer;
  RecordDef   : PwbMainRecordDef;
  GroupRecord : IwbGroupRecord;
begin
  Result := nil;
  case grStruct.grsGroupType of
    0: Result.Add(TwbSignature(grStruct.grsLabel));
    1: begin
         Result.Add('CELL');
         if wbGameMode = gmTES4 then
           Result.Add('ROAD');
       end;
    7: Result.Add('INFO');
    6, 8, 9: begin
         Result.Add('ACHR');
         Result.Add('ACRE');
         Result.Add('REFR');
         Result.Add('PGRE');
         Result.Add('PMIS');
         Result.Add('PARW');
         Result.Add('PBEA');
         Result.Add('PFLA');
         Result.Add('PCON');
         Result.Add('PBAR');
         Result.Add('PHZD');
         if grStruct.grsGroupType = 9 then begin
           if Supports(GetContainer, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 6) and
              Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 5) then
             Result.Add('LAND');
           Result.Add('PGRD');
           Result.Add('NAVM');
         end;
       end;
    10: if wbVWDAsQuestChildren then begin
          SetLength(Result, 3);
          Result[0] := 'DIAL';
          Result[1] := 'DLBR';
          Result[2] := 'SCEN';
        end else
          Result.Add('REFR');
  end;
  j := 0;
  for i := Low(Result) to High(Result) do
    if wbFindRecordDef(AnsiString(Result[i]), RecordDef) then begin
      Result[j] := Result[i] + ' - ' + RecordDef.Name;
      Inc(j);
    end;
  SetLength(Result, j);
end;

function TwbGroupRecord.GetChildrenOf: IwbMainRecord;
var
  Group : IwbGroupRecord;
  _File : IwbFile;
begin
  Result := nil;
  _File := GetFile;
  if Assigned(_File) then
    if grStruct.grsGroupType in [1, 6..10] then
      Result := _File.RecordByFormID[TwbFormID.FromCardinal(GetGroupLabel), True, GetMastersUpdated]
    else if grStruct.grsGroupType in [4, 5] then
      if Supports(GetContainer, IwbGroupRecord, Group) then
        Result := Group.ChildrenOf;
end;

function TwbGroupRecord.GetElementType: TwbElementType;
begin
  Result := etGroupRecord;
end;

function TwbGroupRecord.GetGroupLabel: Cardinal;
begin
  Result := grStruct.grsLabel;
  if grStruct.grsGroupType in [1, 6..10] then begin
    var lFile := GetFile;
    if Assigned(lFile) then begin
      var lFormID := TwbFormID.FromCardinal(Result);
      if lFile.IsNewRecord(lFormID, GetMastersUpdated) then begin
        var lFileFileID := lFile.FileFileID[GetMastersUpdated];
        if lFormID.FileID <> lFileFileID then begin
          lFormID.FileID := lFileFileID;
          Result := lFormID.ToCardinal;
        end;
      end;
    end;
  end;
end;

function TwbGroupRecord.GetGroupLabelSignature: string;
begin
  if grStruct.grsGroupType = 0 then
    Result := PwbSignature(@grStruct.grsLabel)^
  else
    Result := '';
end;

function TwbGroupRecord.GetGroupType: Integer;
begin
  Result := grStruct.grsGroupType;
end;

function TwbGroupRecord.GetMainRecordByEditorID(const aEditorID: string): IwbMainRecord;
var
  SelfRef : IwbContainerElementRef;
  i       : Integer;
begin
  Result := nil;

  SelfRef := Self;
  DoInit(False);
  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbMainRecord, Result) then
      if SameText(Result.EditorID, aEditorID) then
        Exit;
  Result := nil;
end;

function TwbGroupRecord.GetMainRecordByFormID(const aFormID: TwbFormID): IwbMainRecord;
var
  SelfRef : IwbContainerElementRef;
  i       : Integer;
begin
  Result := nil;

  SelfRef := Self;
  DoInit(False);
  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbMainRecord, Result) then
      if Result.FormID = aFormID then
        Exit;
  Result := nil;
end;

function TwbGroupRecord.GetName: string;
begin
  Result := inherited GetName;

  case grStruct.grsGroupType of
    0: begin
      Result := Result + ' Top "' + PwbSignature(@grStruct.grsLabel)^ + '"';
      Exit;
    end;
    1: Result := Result + ' World Children of ';
    2: begin
      Result := Result + ' Interior Cell Block ' + IntToStr(grStruct.grsLabel);
      Exit;
    end;
    3: begin
      Result := Result + ' Interior Cell Sub-Block ' + IntToStr(grStruct.grsLabel);
      Exit;
    end;
    4: begin
      Result := Result + ' Exterior Cell Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo);
      Exit;
    end;
    5: begin
      Result := Result + ' Exterior Cell Sub-Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo);
      Exit;
    end;
    6: Result := Result + ' Cell Children of ';
    7: Result := Result + ' Topic Children of ';
    8: Result := Result + ' Cell Persistent Children of ';
    9: Result := Result + ' Cell Temporary Children of ';
    10: if wbVWDAsQuestChildren then
      Result := Result + ' Quest Children of '
    else
      Result := Result + ' Cell Visible Distant Children of ';
  else
    Result := Result + ' Unknown type: ' + IntToStr(grStruct.grsGroupType);
    Exit;
  end;

  Result := Result + wbFormID.ToString(GetGroupLabel, Self, False);
end;

function TwbGroupRecord.GetCountedRecordCount: Cardinal;
begin
  Result := Succ(inherited GetCountedRecordCount);
end;

function TwbGroupRecord.GetShortName: string;
var
  RecordDef : PwbMainRecordDef;
begin
  case grStruct.grsGroupType of
    0: begin
      Result := PwbSignature(@grStruct.grsLabel)^;
      if wbFindRecordDef(AnsiString(Result), RecordDef) then
        Result := RecordDef.GetName;
    end;
    1: Result := 'World Children of ' + IntToHex(GetGroupLabel, 8);
    2: Result := 'Block ' + IntToStr(grStruct.grsLabel);
    3: Result := 'Sub-Block ' + IntToStr(grStruct.grsLabel);
    4: Result := 'Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo);
    5: Result := 'Sub-Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo);
    6: Result := 'Children of ' + IntToHex(GetGroupLabel, 8);
    7: Result := 'Children of ' + IntToHex(GetGroupLabel, 8);
    8: Result := 'Persistent';
    9: Result := 'Temporary';
    10: if wbVWDAsQuestChildren then
      Result := 'Children of ' + IntToHex(GetGroupLabel, 8)
    else
      Result := 'Visible when Distant';
  else
    Result := Result + ' Unknown type: ' + IntToStr(grStruct.grsGroupType);
  end;
end;

function TwbGroupRecord.GetSortKeyInternal(aExtended: Boolean): string;
begin
  Result := IntToHex64(GetGroupType, 2);

  case grStruct.grsGroupType of
    0: Result := Result + PwbSignature(@grStruct.grsLabel)^;
    4: Result := Result +
      IntToHex64(LongRecSmall(grStruct.grsLabel).Hi + Low(SmallInt), 5) +
      IntToHex64(LongRecSmall(grStruct.grsLabel).Lo + Low(SmallInt), 5);
    5: Result := Result +
      IntToHex64(LongRecSmall(grStruct.grsLabel).Hi + Low(SmallInt), 5) +
      IntToHex64(LongRecSmall(grStruct.grsLabel).Lo + Low(SmallInt), 5);
  else
    Result := Result + IntToHex64(GetGroupLabel, 8);
  end;
end;

function TwbGroupRecord.grStruct: PwbGroupRecordStruct;
begin
  Result := PwbGroupRecordStruct(dcBasePtr);
end;

procedure TwbGroupRecord.InformPrevMainRecord(const aPrevMainRecord: IwbMainRecord);
begin
  inherited;
  if (grStruct.grsGroupType in [1, 6, 7]) and Assigned(aPrevMainRecord) and (aPrevMainRecord.FixedFormID.ToCardinal = GetGroupLabel) then begin
    (aPrevMainRecord as IwbMainRecordInternal).SetChildGroup(Self);
    Include(grStates, gsInformedMainRecord);
  end;
end;

procedure TwbGroupRecord.InitDataPtr;
var
  Dummy: Integer;
begin
  if Assigned(dcEndPtr) then begin
    dcDataBasePtr := PByte(dcBasePtr) + wbSizeOfMainRecordStruct;
    dcDataEndPtr := PByte(dcBasePtr) + grStruct.grsGroupSize;
    dcEndPtr := dcDataEndPtr;
    if not recSkipped then
      if grStruct.grsGroupType = 0 then
        recSkipped := GroupToSkip.Find(PwbSignature(@grStruct.grsLabel)^, Dummy);
  end;
end;

procedure TwbGroupRecord.IsDuplicateOf(const aGroup: IwbGroupRecord);
begin
  grDuplicateOf := aGroup;
end;

function TwbGroupRecord.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement);
end;

function TwbGroupRecord.LinksToParent: Boolean;
begin
  Result := GetGroupType in [4, 5, 8..10];
end;

procedure TwbGroupRecord.MakeHeaderWriteable;
var
  p       : PwbGroupRecordStruct;
  SelfPtr : IwbContainerElementRef;
begin
  SelfPtr := Self as IwbContainerElementRef;

  DoInit(True);

  SetModified(True);
  InvalidateParentStorage;

  if Assigned(dcEndPtr) then begin
    New(p);
    p^ := grStruct^;
    dcBasePtr := p;
    dcEndPtr := nil;
  end;
end;

function TwbGroupRecord.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  SelfPtr     : IwbContainerElementRef;
  OldFormID   : TwbFormID;
  NewFormID   : TwbFormID;
  Changed     : Boolean;
  IsInternal  : Boolean;
begin
  SelfPtr := Self as IwbContainerElementRef;

  BeginUpdate;
  try
    // do not sort records while we are updating
    Include(grStates, gsSorting);
    try
      Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);
    finally
      Exclude(grStates, gsSorting);
    end;

    // sort INFOs afterwards if group is a DIAL children
    if grStruct.grsGroupType = 7 then
      Sort;

    Changed := False;

    if not GetMastersUpdated then begin
      IsInternal := wbBeginInternalEdit(True);
      try
        if grStruct.grsGroupType in [1, 6..10] then begin
          OldFormID := TwbFormID.FromCardinal(GetGroupLabel);
          if not OldFormID.IsNull then begin

            var lAllowHardcodedRangeUse := False;

            var lFile := GetFile;
            if Assigned(lFile) then
              lAllowHardcodedRangeUse := lFile.AllowHardcodedRangeUse;

            NewFormID := FixupFormID(OldFormID, aOld, aNew, aOldCount, aNewCount, lAllowHardcodedRangeUse);
            if grStruct.grsLabel <> NewFormID.ToCardinal then begin
              MakeHeaderWriteable;
              grStruct.grsLabel := NewFormID.ToCardinal;
              SetMastersUpdated(True);
              Changed := True;
              Result := True;
            end;
          end;
        end;
      finally
        if IsInternal then
          wbEndInternalEdit;
      end;
    end;

    if Changed then
      ContainerChanged;
  finally
    EndUpdate;
  end;
end;

procedure TwbGroupRecord.NotifyChangedInternal(aContainer: Pointer);
begin
  if gsSorting in grStates then
    Exit;
  inherited;
  // Let's try to sort only when the group membership change and not when one of its member change.
  if ((grStruct.grsGroupType = 7) and wbSortINFO) or (Assigned(aContainer) and (IwbContainerInternal(aContainer).ElementID = GetElementID)) then
    Exclude(grStates, gsSorted);
end;

procedure TwbGroupRecord.PrepareSave;
begin
  if esModified in eStates then
    Sort;
  inherited;
  if Length(cntElements) = 0 then
    Remove
  else if esModified in eStates then begin
    Exclude(grStates, gsSorted);
    Sort;
  end;
end;

function TwbGroupRecord.Reached: Boolean;
var
  Rec     : IwbMainRecord;
  SelfRef : IwbContainerElementRef;
begin
  wbTick;

  if esReachable in eStates then
    Exit(False);

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  if GetGroupType in [0, 2, 3] then begin
    Result := False;
    Exit;
  end;
  Result := inherited Reached;
  if Result and (GetGroupType in [1, 6..10]) then begin
    Rec := (GetFile as IwbFileInternal).RecordByFormID[TwbFormID.FromCardinal(GetGroupLabel), False, GetMastersUpdated];
    if Assigned(Rec) then
      (Rec as IwbElementInternal).Reached;
  end;
end;

procedure TwbGroupRecord.Remove;
var
  i          : Integer;
  SelfRef    : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  SelfRef := Self as IwbContainerElementRef;
  for i := High(cntElements) downto Low(cntElements) do
    cntElements[i].Remove;
  MainRecord := GetChildrenOf;
  if Assigned(MainRecord) and MainRecord._File.Equals(GetFile) then
    (MainRecord as IwbMainRecordInternal).RemoveChildGroup(Self);
  inherited Remove;
end;

procedure TwbGroupRecord.ScanData;
var
  CurrentPtr     : Pointer;
  Rec            : IwbRecord;
  MainRecord     : IwbMainRecord;
  PrevMainRecord : IwbMainRecord;
begin
  case grStruct.grsGroupType of
    0: begin
      SetSortOrder(wbGetGroupOrder(PwbSignature(@grStruct.grsLabel)^));
      SetMemoryOrder(wbGetGroupOrder(PwbSignature(@grStruct.grsLabel)^));
    end;
  end;

  if recSkipped then
    Exit;

  CurrentPtr := GetDataBasePtr;
  PrevMainRecord := nil;
  while NativeUInt(CurrentPtr) < NativeUInt(dcDataEndPtr) do begin
    Rec := TwbRecord.CreateForPtr(CurrentPtr, dcDataEndPtr, Self, PrevMainRecord);
    if Supports(Rec, IwbMainRecord, MainRecord) then
      PrevMainRecord := MainRecord;
    Rec := nil;
    MainRecord := nil;
  end;
  PrevMainRecord := nil;
end;

procedure TwbGroupRecord.SetGroupLabel(aLabel: Cardinal);
begin
  var SelfPtr := Self as IwbContainerElementRef;

  case grStruct.grsGroupType of
    1: ;//Result := Result + ' World Children of ';
    6: ;//Result := Result + ' Cell Children of ';
    7: ;//Result := Result + ' Topic Children of ';
    8: ;//Result := Result + ' Cell Persistent Children of ';
    9: ;//Result := Result + ' Cell Temporary Children of ';
    10: ;//Result := Result + ' Cell Visible Distant Children of ';
  else
    raise Exception.Create('Can not set Label of ' + GetName);
  end;

  var lFile := GetFile;
  if Assigned(lFile) then begin
    var lFormID := TwbFormID.FromCardinal(aLabel);
    if lFile.IsNewRecord(lFormID, GetMastersUpdated) then begin
      var lFileFileID := lFile.FileFileID[GetMastersUpdated];
      if lFormID.FileID <> lFileFileID then begin
        lFormID.FileID := lFileFileID;
        aLabel := lFormID.ToCardinal;
      end;
    end;
  end;

  var lChanged := False;
  if aLabel <> grStruct.grsLabel then begin
    MakeHeaderWriteable;
    grStruct.grsLabel := aLabel;
    SetMastersUpdated(True);
    lChanged := True;
  end;

  for var lElementIndex := 0 to Pred(GetElementCount) do begin

    var lElement := GetElement(lElementIndex);

    if lElement.ElementType = etGroupRecord then begin
      var lGroupRecord : IwbGroupRecord;
      if Supports(lElement, IwbGroupRecord, lGroupRecord) then
        if lGroupRecord.GroupType in [8..10] then begin
          lGroupRecord.GroupLabel := aLabel;
          Continue;
        end;
    end;

    if lChanged then begin
      var lContainedIn : IwbContainedIn;
      if Supports(lElement, IwbContainedIn, lContainedIn) then
        lContainedIn.ContainerChanged;
    end;

  end;
end;

procedure TwbGroupRecord.SetModified(aValue: Boolean);
begin
  inherited;
  InvalidateStorage;
end;

function FindSortElement(const aElement: IwbElement): IwbElement;
var
  GroupRecord                 : IwbGroupRecord;
begin
  if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
    Result := GroupRecord.ChildrenOf;
    if Assigned(Result) then
      Exit;
  end;
  Result := aElement;
end;

function CompareGroupContents(Item1, Item2: Pointer): Integer;
var
  Element1                    : IwbElement;
  Element2                    : IwbElement;
  SortElement1                : IwbElement;
  SortElement2                : IwbElement;
  GroupRecord1                : IwbGroupRecord;
  GroupRecord2                : IwbGroupRecord;
  MainRecord1                 : IwbMainRecord;
  MainRecord2                 : IwbMainRecord;
begin
  Element1 := IwbElement(Item1);
  Element2 := IwbElement(Item2);

  if Element1 = Element2 then begin
    Result := 0;
    Exit;
  end;

  if Assigned(Element1) <> Assigned(Element2) then begin
    if Assigned(Element1) then
      Result := -1
    else
      Result := 1;
    Exit;
  end
  else if not Assigned(Element1) then begin
    Result := 0;
    Exit;
  end;

  {"ChildrenOf" groups always sort like their owner}
  SortElement1 := FindSortElement(Element1);
  SortElement2 := FindSortElement(Element2);

  if Assigned(SortElement1) <> Assigned(SortElement2) then begin
    if Assigned(SortElement1) then
      Result := -1
    else
      Result := 1;
    Exit;
  end
  else if not Assigned(SortElement1) then begin
    Result := 0;
    Exit;
  end;

  Result := CmpI32(Ord(SortElement1.ElementType), Ord(SortElement2.ElementType));
  if Result = 0 then
    case SortElement1.ElementType of
      etFile: begin
          Assert(False);
          Exit;
        end;
      etGroupRecord: begin
          Assert(SortElement2.ElementType = etGroupRecord);
          GroupRecord1 := SortElement1 as IwbGroupRecord;
          GroupRecord2 := SortElement2 as IwbGroupRecord;
          Assert(GroupRecord1.GroupType = GroupRecord2.GroupType);
          case GroupRecord1.GroupType of
            0: Result := CompareText(
                TwbSignature(GroupRecord1.GroupLabel),
                TwbSignature(GroupRecord2.GroupLabel));
            2, 3: Result := CmpI32(
                Integer(GroupRecord1.GroupLabel),
                Integer(GroupRecord2.GroupLabel));
            4, 5: begin
                Result := CmpI32(
                  LongRecSmall(GroupRecord1.GroupLabel).Hi,
                  LongRecSmall(GroupRecord2.GroupLabel).Hi);
                if Result = 0 then
                  Result := CmpI32(
                    LongRecSmall(GroupRecord1.GroupLabel).Lo,
                    LongRecSmall(GroupRecord2.GroupLabel).Lo);
              end;
          else
            Assert(False);
          end;
        end;
      etMainRecord: begin
          Assert(SortElement2.ElementType = etMainRecord);
          MainRecord1 := SortElement1 as IwbMainRecord;
          MainRecord2 := SortElement2 as IwbMainRecord;
          Result := 0;
          if Result = 0 then begin
            Result := CmpI32(MainRecord1.SortPriority, MainRecord2.SortPriority);
            if Result = 0 then begin
              if wbDisplayLoadOrderFormID then
                Result := TwbFormID.Compare(MainRecord1.LoadOrderFormID, MainRecord2.LoadOrderFormID)
              else
                Result := TwbFormID.Compare(MainRecord1.FixedFormID, MainRecord2.FixedFormID);
              if Result = 0 then
                Result := CmpPtr(MainRecord1.ElementID, MainRecord2.ElementID);
            end;
          end;
        end
    else
      Assert(False);
    end;

  if Result = 0 then
    if Element1 <> SortElement1 then begin
      if Element2 <> SortElement2 then begin
        {both are groups of the same element }
        GroupRecord1 := Element1 as IwbGroupRecord;
        GroupRecord2 := Element2 as IwbGroupRecord;
        Result := CmpI32(GroupRecord1.GroupType, GroupRecord2.GroupType);
        if Result = 0 then
          Result := CmpW32(GroupRecord1.GroupLabel, GroupRecord2.GroupLabel);
      end
      else begin
        {element1 is a group of element2}
        Result := 1;
      end;
    end
    else begin
      if Element2 <> SortElement2 then begin
        {element2 is a group of element1}
        Result := -1;
      end
      else begin
        {really seems to be the same}
      end;
    end;
end;

threadvar
  ElementRefs      : array of IwbContainerElementRef;
  ElementRefsCount : Integer;

procedure TwbGroupRecord.Sort(aForce: Boolean = False);
{$IFDEF USE_CODESITE}
var
  ShouldLog: Boolean;
{$ENDIF}

type
  PInsertStackEntry = ^TInsertStackEntry;
  TInsertStackEntry = record
    isePrev   : PInsertStackEntry;
    iseRecord : IwbMainRecordEntry;
  end;

  procedure DoInsertRecord(const InsertRecord: IwbMainRecordEntry; aPrevInsertStackEntry: PInsertStackEntry);
  var
    TargetRecord     : IwbMainRecordEntry;

    procedure ReportCycle;
    var
      Current: PInsertStackEntry;
    begin
      wbProgress('Cyclic PNAM references found for %s %s: ', [InsertRecord._File.Name, InsertRecord.Name]);
      Current := aPrevInsertStackEntry;
      while Assigned(Current) do begin
        wbProgress('referenced by %s %s: ', [Current.iseRecord._File.Name, Current.iseRecord.Name]);
        if TargetRecord.Equals(Current.iseRecord) then
          Exit;
        Current := Current.isePrev;
      end;
    end;

  var
    InsertStackEntry : TInsertStackEntry;
    Run              : PInsertStackEntry;
    Master           : IwbMainRecord;
    PossibleTarget   : IwbMainRecordEntry;
  begin
    {$IFDEF USE_CODESITE}
    if laSortInfo in wbLoggingAreas then begin
      if ShouldLog then
        CodeSite.EnterMethod(Format('DoInsertRecord for %s from %s', [InsertRecord.ShortName, InsertRecord._File.Name]));
    end;
    try
    {$ENDIF}

    SetLength(ElementRefs, Succ(Length(ElementRefs)));
    if not Supports(InsertRecord, IwbContainerElementRef, ElementRefs[High(ElementRefs)]) then
      Assert(False);

    if Supports(InsertRecord.ElementLinksTo['PNAM'], IwbMainRecordEntry, TargetRecord) then begin

      SetLength(ElementRefs, Succ(Length(ElementRefs)));
      if not Supports(TargetRecord, IwbContainerElementRef, ElementRefs[High(ElementRefs)]) then
        Assert(False);

      if not TargetRecord.IsInList then begin
        Master := TargetRecord.MasterOrSelf;
        for var i := Pred(Master.OverrideCount) downto 0 do
          if Supports(Master.Overrides[i], IwbMainRecordEntry, PossibleTarget) then begin
            TargetRecord := PossibleTarget;
            Break;
          end;
        if not TargetRecord.IsInList then
          if Supports(Master, IwbMainRecordEntry, PossibleTarget) then
            TargetRecord := PossibleTarget;
      end;

      if not TargetRecord.IsInList then with InsertStackEntry do begin

        isePrev := aPrevInsertStackEntry;
        iseRecord := InsertRecord;

        Run := aPrevInsertStackEntry;
        while Assigned(Run) do begin
          if TargetRecord.Equals(Run.iseRecord) then begin
            ReportCycle;
            Abort;
          end;
          Run := Run.isePrev;
        end;

        DoInsertRecord(TargetRecord, @InsertStackEntry);
      end;

      InsertRecord.InsertEntryAfter(TargetRecord);
      {$IFDEF USE_CODESITE}
      if laSortInfo in wbLoggingAreas then begin
        if ShouldLog then
          CodeSite.SendMsg(Format('Inserting after [%s]', [TargetRecord.ShortName]));
      end;
      {$ENDIF}

    end else if InsertRecord.ElementExists['PNAM'] then begin
      InsertRecord.InsertEntryHead;
      {$IFDEF USE_CODESITE}
      if laSortInfo in wbLoggingAreas then begin
        if ShouldLog then
          CodeSite.SendMsg('Inserting as Head');
      end;
      {$ENDIF}
    end else begin
      InsertRecord.InsertEntryTail;
      {$IFDEF USE_CODESITE}
      if laSortInfo in wbLoggingAreas then begin
        if ShouldLog then
          CodeSite.SendMsg('Inserting as Tail');
      end;
      {$ENDIF}
    end;
    {$IFDEF USE_CODESITE}
    finally
      if laSortInfo in wbLoggingAreas then begin
        if ShouldLog then
          CodeSite.ExitMethod('');
      end;
    end;
    {$ENDIF}
  end;

var
  ChildrenOf  : IwbMainRecord;

  procedure ProcessDIAL(aOnlyMasters: Boolean);
  var
    MainRecords : TDynMainRecords;
    Groups      : TDynGroupRecords;
    Group       : IwbContainerElementRef;
    Master      : IwbMainRecord;
    MainRecord  : IwbMainRecord;
    g           : IwbGroupRecord;
    i, j, k     : Integer;
    InsertRecord: IwbMainRecordEntry;
    TargetRecord: IwbMainRecordEntry;
    PrevRecord  : IwbMainRecordEntry;
    InfoQuest   : Int64;
    InfoQuest2  : Int64;
    Inserted    : Boolean;
    NewElements : TDynElementInternals;
    INOM        : IwbContainerElementRef;
    ListSig     : TwbSignature;
  begin
    if aOnlyMasters then begin
      MainRecords := ChildrenOf.MasterRecordsFromMasterFilesAndSelf;
    end else begin
      MainRecords := nil;
      Master := ChildrenOf.MasterOrSelf;
      MainRecords.Add(Master);
      if not Master.Equals(ChildrenOf) then
        for var l := 0 to Pred(Master.OverrideCount) do begin
          MainRecord := Master.Overrides[l];
          MainRecords.Add(MainRecord);
          if MainRecord.Equals(ChildrenOf) then
            Break;
        end;
    end;

    SetLength(Groups, Length(MainRecords));
    i := 0;
    for j := Low(MainRecords) to High(MainRecords) do begin
      Groups[i] := MainRecords[j].ChildGroup;
      if Assigned(Groups[i]) and (Groups[i].ElementCount > 0) then
        Inc(i);
    end;
    SetLength(Groups, i);

    for i := Low(Groups) to High(Groups) do
      if not Equals(Groups[i]) then
        (Groups[i] as IwbGroupRecordInternal).Sort;

    MainRecords := nil;
    try
      mreHeader.BeginUse;
      try
        for i := Low(Groups) to High(Groups) do
          if Supports(Groups[i], IwbContainerElementRef, Group) then
            for j := 0 to Pred(Group.ElementCount) do
              if Supports(Group.Elements[j], IwbMainRecordEntry, InsertRecord) then
                 DoInsertRecord(InsertRecord, nil);
        TargetRecord := IwbMainRecordEntry(mreHeader.mrehTail);
        var KeepList := (wbFillINOM and aOnlyMasters) or (wbFillINOA and not aOnlyMasters);
        while Assigned(TargetRecord) do begin
          if KeepList then
            MainRecords.Add(TargetRecord);
          PrevRecord := TargetRecord.PrevEntry;
          if not Equals(TargetRecord.Container) then
            TargetRecord.RemoveEntry
          else
            if aOnlyMasters then
              if wbFillPNAM and (not TargetRecord.IsDeleted) then
                if wbBeginInternalEdit then try
                  if not TargetRecord.ElementExists['PNAM'] then begin
                    {>>> No QSTI in Skyrim, using DIAL\QNAM <<<}
                    if wbIsSkyrim then begin
                      Supports(TargetRecord.Container, IwbGroupRecord, g);
                      InfoQuest := g.ChildrenOf.ElementNativeValues['QNAM'];
                    end else
                      InfoQuest := TargetRecord.ElementNativeValues['QSTI'];
                    InsertRecord := PrevRecord;
                    Inserted := False;
                    while Assigned(InsertRecord) do begin
                      if wbIsSkyrim then begin
                        Supports(InsertRecord.Container, IwbGroupRecord, g);
                        InfoQuest2 := g.ChildrenOf.ElementNativeValues['QNAM'];
                      end else
                        InfoQuest2 := InsertRecord.ElementNativeValues['QSTI'];
                      if (not InsertRecord.IsDeleted) and (InfoQuest = InfoQuest2) then begin
                        try
                          Inserted := True;
                          TargetRecord.Add('PNAM').NativeValue := InsertRecord.LoadOrderFormID.ToCardinal;
                        except
                          TargetRecord.RemoveElement('PNAM');
                        end;
                        Break;
                      end;
                      InsertRecord := InsertRecord.PrevEntry;
                    end;
                    if not Inserted then
                      TargetRecord.Add('PNAM');
                  end;
                finally
                  wbEndInternalEdit;
                end;

          TargetRecord := PrevRecord;
        end;

        if aOnlyMasters then begin
          Assert(mreHeader.mrehCount = Length(cntElements), '[TwbGroupRecord.Sort] mreHeader.mrehCount <> Length(cntElements)');

          SetLength(NewElements, Length(cntElements));
          k := High(NewElements);
          TargetRecord := IwbMainRecordEntry(mreHeader.mrehTail);
          while Assigned(TargetRecord) do begin
            Assert(k >= Low(NewElements), '[TwbGroupRecord.Sort] k < Low(NewElements)');
            if not Supports(TargetRecord, IwbElementInternal, NewElements[k]) then
              Assert(False, '[TwbGroupRecord.Sort] not Supports(IwbElementInternal)');
            TargetRecord.SortOrder := k;
            TargetRecord := TargetRecord.PrevEntry;
            Dec(k);
          end;
          Assert(k = -1, '[TwbGroupRecord.Sort] k <> -1');
        end;

        if KeepList then begin
          if aOnlyMasters then
            ListSig := 'INOM'
          else
            ListSig := 'INOA';

          if wbBeginInternalEdit then try
            if Supports(ChildrenOf.RecordBySignature[ListSig], IwbContainerElementRef, INOM) then begin
              INOM.Remove;
              INOM := nil;
            end;
            if Supports(ChildrenOf.Add(ListSig), IwbContainerElementRef, INOM) then begin
              INOM.BeginUpdate;
              try
                for i := High(MainRecords) downto Low(MainRecords) do
                  INOM.Add('').LinksTo := MainRecords[i];
              finally
                INOM.EndUpdate;
              end;
            end;
          finally
            wbEndInternalEdit;
          end;
        end;

        if aOnlyMasters then begin
          cntElements := NewElements;
          Include(grStates, gsSorted);
        end;
      finally
        mreHeader.EndUse;
      end;
    except
      on E: Exception do begin
        wbProgress('<Error sorting INFO for ["%s" in "%s"]: [%s] %s>', [GetName, GetFile.Name, E.ClassName, E.Message]);
        raise;
      end;
    end;
  end;

begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  if wbBuildingRefsParallel then
    _ResizeLock.Enter;
  try
{$ENDIF}

  if grStates * [gsSorting] <> [] then
    Exit;

  if not aForce then
    if grStates * [gsSorted, gsSorting] <> [] then
      Exit;

  if not (esEndingUpdate in eStates) and (eUpdateCount > 0) then begin
    Include(grStates, gsSortPostponed);
    if aForce then
      Include(grStates, gsSortForcedPostponed);
    Exit;
  end;

  var _File := GetFile;
  if Assigned(_File) and (fsScanning in _File.FileStates) then
    Exit;

  Include(grStates, gsSorting);
  wbLockProcessMessages;
  try
    ChildrenOf := GetChildrenOf;
    // there is no PNAM in Fallout 4, looks like INFOs are no longer linked lists

    if {$IFDEF USE_PARALLEL_BUILD_REFS}not wbBuildingRefsParallel and{$ENDIF} wbCanSortINFO and (grStruct.grsGroupType = 7) then begin

      if not wbSortINFO then
        Exit;

      if not wbDisplayLoadOrderFormID then
        Exit;

      try
        Inc(ElementRefsCount);
        try
          {$IFDEF USE_CODESITE}
          ShouldLog := (ChildrenOf.LoadOrderFormID.ToCardinal = $00039F6C) and (ChildrenOf._File.LoadOrderFileID = TwbFileID.Create(4, 0));
          {$ENDIF}

          if wbFillINOA then
            ProcessDIAL(False);

          {$IFDEF USE_CODESITE}
          ShouldLog := False;
          {$ENDIF}

          ProcessDIAL(True);
        finally
          Dec(ElementRefsCount);
          if ElementRefsCount = 0 then
            ElementRefs := nil;
        end;
      except
        wbProgress('<Warning: could not sort INFO for ["%s" in "%s"] because of previous error>', [GetName, GetFile.Name]);
        if ElementRefsCount > 0 then
          raise;
      end;

      Include(grStates, gsSorted);
      Exit;
    end;

    if Length(cntElements) > 1 then
      wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareGroupContents);
    Include(grStates, gsSorted);
  finally
    wbUnLockProcessMessages;
    Exclude(grStates, gsSorting);
  end;

{$IFDEF USE_PARALLEL_BUILD_REFS}
  finally
    if wbBuildingRefsParallel then
      _ResizeLock.Leave;
  end;
{$ENDIF}
end;

procedure TwbGroupRecord.UpdateEnded;
begin
  if gsSortPostponed in grStates then begin
    Exclude(grStates, gsSortPostponed);
    var Force := gsSortForcedPostponed in grStates;
    Exclude(grStates, gsSortForcedPostponed);
    Sort(Force);
  end;
  inherited;
end;

procedure TwbGroupRecord.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
var
  CurrentPosition   : Int64;
  NewPosition       : Int64;
  DataSize          : Cardinal;
  grs               : TwbGroupRecordStruct;
begin
  CurrentPosition := aStream.Position;
  grs := grStruct^;
  aStream.WriteBuffer(grs, wbSizeOfMainRecordStruct );
  if wbForceNewHeader then
    aStream.WriteBuffer(wbNewHeaderAddon, SizeOf(wbNewHeaderAddon) );
  inherited;
  if (esModified in eStates) or wbTestWrite then begin

    NewPosition := aStream.Position;
    DataSize := (NewPosition - CurrentPosition);
    aStream.Position := CurrentPosition + 4;
    aStream.WriteBuffer(DataSize, SizeOf(DataSize));
    aStream.Position := NewPosition;

  end else
    if wbForceNewHeader then
      Assert(CurrentPosition + grStruct.grsGroupSize + SizeOf(wbNewHeaderAddon) = aStream.Position)
    else
      Assert(CurrentPosition + grStruct.grsGroupSize = aStream.Position);

  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

{ TwbElement }

function TwbElement.AddIfMissing(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
{$IFDEF USE_CODESITE}
var
  Log: Boolean;
  Group : IwbGroupRecord;
{$ENDIF}
begin
  wbTick;

  {$IFDEF USE_CODESITE}
  Log := (laAddIfMissing in wbLoggingAreas) and wbCodeSiteLoggingEnabled;
  if Log then begin
    CodeSite.EnterMethod(Self, 'AddIfMissing');
    CodeSite.Send('Self.Name', Self.GetName);
    CodeSite.Send('Self.Path', Self.GetPath);
    CodeSite.Send('Self.Value', Self.GetValue);
    if Assigned(aElement) then begin
      CodeSite.Send('aElement.Name', aElement.Name);
      CodeSite.Send('aElement.Path', aElement.Path);
      CodeSite.Send('aElement.Value', aElement.Value);
      if Supports(aElement, IwbGrouprecord, Group) then
        CodeSite.Send('aGroup.Type', Group.GroupType);
    end else
        CodeSite.Send('aElement', 'nil');
  end;
  {$ENDIF}
  BeginUpdate;
  try
    Result := AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite);
  finally
    EndUpdate;
  {$IFDEF USE_CODESITE}
    if Log then begin
      CodeSite.Send('Self.Value', Self.GetValue);
      if Assigned(Result) then begin
        CodeSite.Send('Result.Name', Result.Name);
        CodeSite.Send('Result.Path', Result.Path);
        CodeSite.Send('Result.Value', Result.Value);
      end else
        CodeSite.Send('Result', 'nil');
      CodeSite.ExitMethod(Self, 'AddIfMissing');
    end;
  {$ENDIF}
  end;
end;

function TwbElement.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
begin
  raise Exception.Create(ClassName + '.AddIfMissingInternal is not implemented');
end;

procedure TwbElement.AddReferencedFromID(aFormID: TwbFormID);
begin
  if Assigned(eContainer) then
    IwbElement(eContainer).AddReferencedFromID(aFormID);
end;

procedure TwbElement.AfterConstruction;
label
  Skip;
begin
  inherited;
  {$IFDEF WIN64}
  if LockedDec(eExternalRefs) = 0 then
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov  eax, -1
         mov  ecx, [Self]
    lock xadd dword ptr [ecx + eExternalRefs], eax
         cmp  eax, 1
         jne  Skip
  end;
  {$ENDIF WIN32}
  eContainerRef := nil;
Skip:
  Include(eStates, esConstructionComplete);
end;

function TwbElement.Assign(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
{$IFDEF USE_CODESITE}
var
  Log: Boolean;
{$ENDIF}
begin
  wbTick;

  {$IFDEF USE_CODESITE}
  Log := (laElementAssign in wbLoggingAreas) and wbCodeSiteLoggingEnabled;
  if Log then begin
    CodeSite.EnterMethod(Self, 'Assign');
    CodeSite.Send('Self.Name', Self.GetName);
    CodeSite.Send('Self.Path', Self.GetPath);
    CodeSite.Send('Self.DataSize', Self.GetDataSize);
    CodeSite.Send('Self.Value', Self.GetValue);
    CodeSite.Send('aIndex', aIndex);
    if Assigned(aElement) then begin
      CodeSite.Send('aElement.Name', aElement.Name);
      CodeSite.Send('aElement.Path', aElement.Path);
      CodeSite.Send('aElement.DataSize', aElement.GetDataSize);
      CodeSite.Send('aElement.Value', aElement.Value);
    end else
      CodeSite.Send('aElement', 'nil');
    CodeSite.Send('aOnlySK', aOnlySK);
  end;
  {$ENDIF}
  BeginUpdate;
  try
    try
      if Assigned(aElement) and aElement.ContainsReflection then
        if not Supports(aElement, IwbMainRecord) or Supports(Self, IwbMainRecord) then
          raise Exception.Create(aElement.Name + ' contains Reflection and can not be assigned');

      Result := AssignInternal(aIndex, aElement, aOnlySK);
    except
      on E: Exception do begin
        var lSourceName := 'nil';
        if Assigned(aElement) then
          lSourceName := aElement.FullPath;
        var lTargetName := GetFullPath;
        wbProgress('Error assigning to [%s] from [%s]: [%s] %s', [lTargetName, lSourceName, E.ClassName, E.Message]);
        Result := nil;
      end;
    end;
  finally
    EndUpdate;
  {$IFDEF USE_CODESITE}
    if Log then begin
      CodeSite.Send('Self.Value', Self.GetValue);
      CodeSite.Send('Self.DataSize', Self.GetDataSize);
      if Assigned(Result) then begin
        CodeSite.Send('Result.Name', Result.Name);
        CodeSite.Send('Result.Path', Result.Path);
        CodeSite.Send('Result.DataSize', Result.GetDataSize);
        CodeSite.Send('Result.Value', Result.Value);
      end else
        CodeSite.Send('Result', 'nil');
      CodeSite.ExitMethod(Self, 'Assign');
    end;
  {$ENDIF}
  end;
end;

function TwbElement.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  TargetValueDef: IwbValueDef;
begin
  if not wbIsInternalEdit then
    if (not wbEditAllowed) {or (not GetIsEditable)} then
      raise Exception.Create(GetName + ' can not be assigned');

  TargetValueDef := GetValueDef;
  if TargetValueDef = nil then
    raise Exception.Create(GetName + ' can not be assigned');

  if not wbIsInternalEdit then
    if dfInternalEditOnly in TargetValueDef.DefFlags then
      raise Exception.Create(GetName + ' can not be assigned');

  Result := TargetValueDef.Assign(Self, aIndex, aElement, aOnlySK);;
end;

procedure TwbElement.BeforeActualRemove;
begin
  {can be overriden}
end;

procedure TwbElement.BeforeDestruction;
begin
  if esConstructionComplete in eStates then
    Assert(eExternalRefs = 0)
  else
    Assert(eExternalRefs = 1);

  if (FRefCount and $7FFFFFFF) <> 0 then
    if esConstructionComplete in eStates then
      Assert(FRefCount = 0)
    else
      Assert(FRefCount = 1);

  Include(eStates, esDestroying);
  if esConstructionComplete in eStates then begin
    inherited BeforeDestruction;
    {$IFDEF WIN64}
    LockedInc(eExternalRefs);
    LockedInc(FRefCount);
    {$ENDIF WIN64}
    {$IFDEF WIN32}
    asm
           mov eax, [Self]
      lock inc dword ptr [eax + eExternalRefs]
      lock inc dword ptr [eax + FRefCount]
    end;
    {$ENDIF WIN64}
  end;
end;

function TwbElement.BeginResolve: Boolean;
begin
  Result := not (esResolving in eStates);
  if Result then
    Include(eStates, esResolving);
end;

function TwbElement.BeginUpdate: Integer;
begin
  Result := Succ(eUpdateCount);
  eUpdateCount := Result;
end;

procedure TwbElement.BuildRef;
begin
  {nothing}
end;

function TwbElement.CanAssign(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
{$IFDEF USE_CODESITE}
var
  Log: Boolean;
{$ENDIF}
begin
  {$IFDEF USE_CODESITE}
  Log := (laElementCanAssign in wbLoggingAreas) and wbCodeSiteLoggingEnabled;
  if Log then begin
    CodeSite.EnterMethod(Self, 'CanAssign');
    CodeSite.Send('Self.Name', Self.GetName);
    CodeSite.Send('Self.Path', Self.GetPath);
    CodeSite.Send('Self.Value', Self.GetValue);
    CodeSite.Send('aIndex', aIndex);
    if Assigned(aElement) then begin
      CodeSite.Send('aElement.Name', aElement.Name);
      CodeSite.Send('aElement.Path', aElement.Path);
      CodeSite.Send('aElement.Value', aElement.Value);
    end else
      CodeSite.Send('aElement', 'nil');
    CodeSite.Send('aCheckDontShow', aCheckDontShow);
  end;
  Result := False;
  try
  {$ENDIF}
    if Assigned(aElement) and aElement.ContainsReflection then
      if not Supports(aElement, IwbMainRecord) or Supports(Self, IwbMainRecord) then
        Exit(False);

    Result := CanAssignInternal(aIndex, aElement, aCheckDontShow);
  {$IFDEF USE_CODESITE}
  finally
    if Log then begin
      CodeSite.Send('Result', Result);
      CodeSite.ExitMethod(Self, 'CanAssign');
    end;
  end;
  {$ENDIF}
end;

function TwbElement.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  TargetDef: IwbDef;
  SourceDef: IwbDef;
begin
  Result := wbIsInternalEdit;
  if Result then
    Exit;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;
  end;

  if not GetIsEditable then
    Exit;

  if not Assigned(aElement) then
    Exit;

  TargetDef := GetValueDef;
  if TargetDef = nil then begin
    TargetDef := GetDef;
    if TargetDef = nil then
      Exit;
  end;

  if not wbIsInternalEdit then
    if dfInternalEditOnly in TargetDef.DefFlags then
      Exit;

  SourceDef := aElement.GetValueDef;
  if SourceDef = nil then begin
    SourceDef := aElement.GetDef;
    if SourceDef = nil then
      Exit;
  end;

  Result := TargetDef.CanAssign(Self, aIndex, SourceDef);

  if Result and aCheckDontShow and GetDontShow then
    Result := False;
end;

function TwbElement.CanChangeMember: Boolean;
begin
  Result := Assigned(eContainer) and
    IwbContainerInternal(eContainer).CanChangeElementMember(Self);
end;

function TwbElement.CanContainFormIDs: Boolean;
begin
  Result := True;
end;

function TwbElement.CanCopy: Boolean;
var
  Def      : IwbNamedDef;
  ValueDef : IwbValueDef;
begin
  Result := True;
  if not wbIsInternalEdit then begin
    Def := GetDef;
    if Assigned(Def) and (dfInternalEditOnly in Def.DefFlags) then
      Exit(False);
    ValueDef := GetValueDef;
    if Assigned(ValueDef) and (dfInternalEditOnly in ValueDef.DefFlags) then
      Exit(False);
  end;
end;

function TwbElement.CanMoveDown: Boolean;
begin
  Result := Assigned(eContainer) and
    IwbContainerInternal(eContainer).CanMoveElementDown(Self);
end;

function TwbElement.CanMoveUp: Boolean;
begin
  Result := Assigned(eContainer) and
    IwbContainerInternal(eContainer).CanMoveElementUp(Self);
end;

procedure TwbElement.Clear;
begin
  {can be overridden}
end;

function TwbElement.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
begin
  Result := False;
end;

function TwbElement.ContainsReflection: Boolean;
begin
  Result := False;

  var lDef := GetDef;
  if not Assigned(lDef) or not (dfCanContainReflection in lDef.DefFlags) then
    Exit;

  var lValueDef := GetValueDef;
  if not Assigned(lValueDef) or not (dfCanContainReflection in lValueDef.DefFlags) then
    Exit;

  if lValueDef.DefType = dtReflection then
    Exit(True);
end;

function TwbElement.ContainsUnmappedFormID: Boolean;
begin
  Result := False;

  var lDef := GetDef;
  if not Assigned(lDef) or not (dfCanContainUnmappedFormID in lDef.DefFlags) then
    Exit;

  var lValueDef := GetValueDef;
  if not Assigned(lValueDef) or not (dfUnmappedFormID in lValueDef.DefFlags) then
    Exit;

  var lNativeValue := GetNativeValue;
  if VarIsOrdinal(lNativeValue) and (lNativeValue <> 0) then
    Result := True;
end;

function TwbElement.ContentIsAllZero: Boolean;
begin
  Result := False;
end;

function CompareLoadOrderSL(List: TStringList; Index1, Index2: Integer): Integer;
begin
  if Index1 = Index2 then begin
    Result := 0;
    Exit;
  end;

  Result := CmpI32(
    IwbFile(Pointer(List.Objects[Index1])).LoadOrder,
    IwbFile(Pointer(List.Objects[Index2])).LoadOrder);
end;

procedure AddRequiredMasters(aMasters: TwbFilesDictionary; const aTargetFile: IwbFile);
var
  sl                          : TStringList;
  i, j                        : Integer;
begin
  sl := TStringList.Create;
  try
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;

    var lFiles:TwbFiles := aMasters.Keys.ToArray;
    lFiles.SortByLoadOrder;
    for var lFile in lFiles do
      sl.AddObject(lFile.FileName, Pointer(lFile));

    for i := 0 to Pred(aTargetFile.MasterCount[True]) do
      if sl.Find(aTargetFile.Masters[i, True].FileName, j) then
        sl.Delete(j);
    if sl.Find(aTargetFile.FileName, j) then
      sl.Delete(j);

    if sl.Count > 0 then begin

      for i := 0 to Pred(sl.Count) do
        if IwbFile(Pointer(sl.Objects[i])).LoadOrder >= aTargetFile.LoadOrder then
          raise Exception.Create('The required master "' + sl[i] + '" can not be added to "' + aTargetFile.FileName + '" as it has a higher load order');

      sl.Sorted := False;
      sl.CustomSort(CompareLoadOrderSL);

      aTargetFile.AddMasters(sl);
    end;
  finally
    sl.Free;
  end;
end;

function TwbElement.CopyInto(const aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string): IwbElement;
begin
  var lDict := TwbFilesDictionary.Create;
  try
    ReportRequiredMasters(lDict, aAsNew);
    AddRequiredMasters(lDict, aFile);

    var lMainRecord: IwbMainRecord;
    if aDeepCopy and Supports(Self, IwbMainRecord, lMainRecord) and Assigned(lMainRecord.ChildGroup) then begin
      Result := wbCopyElementToFile(lMainRecord.ChildGroup, aFile, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!});
      var lGroupRecord: IwbGroupRecord;
      if Supports(Result, IwbGroupRecord, lGroupRecord) then
        Result := lGroupRecord.ChildrenOf
      else
        Result := nil;
    end else
      Result := wbCopyElementToFile(Self, aFile, aAsNew, True, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, False {CheckMe!});
  finally
    lDict.Free
  end;
end;

constructor TwbElement.Create(const aContainer: IwbContainer);
begin
  eGeneration := 1;
  eSortOrder := High(Integer);
  eMemoryOrder := Low(Integer);
  inherited Create;
  if Assigned(aContainer) then
    aContainer.AddElement(Self);
end;

procedure TwbElement.DoAfterSet(const aOldValue, aNewValue: Variant);
var
  NamedDef1: IwbNamedDef;
  NamedDef2: IwbNamedDef;
begin
  NamedDef1 := GetValueDef;
  if Assigned(NamedDef1) then
    NamedDef1.AfterSet(Self, aOldValue, aNewValue);

  if Supports(GetDef, IwbNamedDef, NamedDef2) then
    if not NamedDef2.Equals(NamedDef1) then
      NamedDef2.AfterSet(Self, aOldValue, aNewValue);

  Exclude(eStates, esReportedErrorReading);
end;

procedure TwbElement.DoReset(aForce: Boolean);
begin
  {nothing}
end;

function TwbElement.ResetLeafFirst: Boolean;
begin
  DoReset(False);
  Result := eExternalRefs < 1;
end;

procedure TwbElement.ResetModified(aResetModified: TwbResetModified);
begin
  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

procedure TwbElement.EndResolve;
begin
  Exclude(eStates, esResolving);
end;

function TwbElement.EndUpdate: Integer;

begin
  Result := Pred(eUpdateCount);
  if Result = 0 then begin
    Include(eStates, esEndingUpdate);
    try
      UpdateEnded;
    finally
      Exclude(eStates, esEndingUpdate);
    end;
  end;
  eUpdateCount := Result;
end;

function TwbElement.Equals(const aElement: IwbElement): Boolean;
begin
  Result := Assigned(aElement) and (aElement.ElementID = GetElementID);
end;

procedure TwbElement.FindUsedMasters(aMasters: PwbUsedMasters);
begin
  {can be overriden}
end;

procedure TwbElement.FlagAsOptionalAndMissing;
begin
  Include(eStates, esOptionalAndMissing);
end;

procedure TwbElement.FreeInstance;
begin
  if (FRefCount and $7FFFFFFF) <> 1 then
    // this can happen if during the execution of the constructor,
    // counted interface references have been created to this object,
    // and then the constructor failed with an exception,
    // initiating destruction despite there being outstanding interface references
    // this is an unrecoverable error really
    Assert(FRefCount = 1);
  Assert(eExternalRefs = 1);
  inherited;
end;

function TwbElement.GetAssignTemplates(aIndex: Integer): TwbTemplateElements;
begin
  Result := nil;

  var lDef := GetDef;
  if Assigned(lDef) then begin
    var lSelfAsContainer: IwbContainerElementRef;
    Supports(Self, IwbContainerElementRef, lSelfAsContainer);

    var lDefTemplates := lDef.GetAssignTemplates(lSelfAsContainer, aIndex);
    var lDefTemplatesLength := Length(lDefTemplates);

    if lDefTemplatesLength > 0 then begin
      SetLength(Result, lDefTemplatesLength);
      for var lDefTemplateIdx := 0 to Pred(lDefTemplatesLength) do
        Result[lDefTemplateIdx] := TwbTemplateElement.Create(lDefTemplates[lDefTemplateIdx] as IwbNamedDef);
      Exit;
    end;

  end;

  var lValueDef := GetValueDef;
  if Assigned(lValueDef) and not lValueDef.Equals(lDef) then begin
    var lSelfAsContainer: IwbContainerElementRef;
    Supports(Self, IwbContainerElementRef, lSelfAsContainer);

    var lValueDefTemplates := lValueDef.GetAssignTemplates(lSelfAsContainer, aIndex);
    var lValueDefTemplatesLength := Length(lValueDefTemplates);

    if lValueDefTemplatesLength > 0 then begin
      SetLength(Result, lValueDefTemplatesLength);
      for var lValueDefTemplateIdx := 0 to Pred(lValueDefTemplatesLength) do
        Result[lValueDefTemplateIdx] := TwbTemplateElement.Create(lValueDefTemplates[lValueDefTemplateIdx] as IwbNamedDef);
      Exit;
    end;

  end;

end;

function TwbElement.GetBaseName: string;
begin
  Result := GetName;
end;

function TwbElement.GetCheck: string;
begin
  Result := '';
end;

function TwbElement.GetCollapsed: TwbTriBool;
begin
  Result := tbFalse;
end;

function TwbElement.GetConflictPriority: TwbConflictPriority;
var
  Def        : IwbDef;
  MainRecord : IwbMainRecord;
begin
  Result := cpNormal;

  Def := GetValueDef;

  if not Assigned(Def) then
    Def := GetDef;

  if Assigned(Def) then
    Result := Def.ConflictPriority[Self];

  if wbTranslationMode then
    if not (dfTranslatable in Def.DefFlags) then
      Result := cpIgnore;

  if Result = cpFormID then begin
    Result := cpCritical;
    MainRecord := GetContainingMainRecord;
    if Assigned(MainRecord) and ((MainRecord.Signature = 'GMST') or (MainRecord.Signature = 'DFOB')) then
      Result := cpBenign;
  end;
end;

function TwbElement.GetConflictPriorityCanChange: Boolean;
var
  Def        : IwbDef;
begin
  Result := False;

  Def := GetValueDef;

  if not Assigned(Def) then
    Def := GetDef;

  if Assigned(Def) then
    Result := Def.ConflictPriorityCanChange;
end;

function TwbElement.GetContainer: IwbContainer;
begin
  Result := IwbContainer(eContainer);
end;

function TwbElement.GetContainingMainRecord: IwbMainRecord;
begin
  if Assigned(eContainer) then
    Result := IwbContainer(eContainer).ContainingMainRecord
  else
    Result := nil;
end;

function TwbElement.GetDataSize: Integer;
begin
  Result := 0;
end;

function TwbElement.GetDef: IwbNamedDef;
begin
  Result := nil;
end;

function TwbElement.GetDisplayName(aUseSuffix: Boolean): string;
begin
  Result := GetName;
  if aUseSuffix and (GetNameSuffix <> '') then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + eNameSuffix;
  end;
end;

function TwbElement.GetDisplaySortKey(aExtended: Boolean): string;
begin
  if wbCompareRawData then
    Result := GetRawDataAsString
  else
    Result := GetSortKey(aExtended);
end;

function TwbElement.GetDontShow: Boolean;
var
  Def: IwbDef;
begin
  Result := False;
  Def := GetValueDef;
  if Assigned(Def) then
    Result := Def.DontShow[Self];
  if not Result then begin
    Def := GetDef;
    if Assigned(Def) then
      Result := Def.DontShow[Self];
  end;
end;

function TwbElement.GetEditInfo: TArray<string>;
begin
  Result := nil;
end;

function TwbElement.GetEditType: TwbEditType;
begin
  Result := etDefault;
end;

function TwbElement.GetEditValue: string;
begin
  Result := '';
end;

function TwbElement.GetElementGeneration: Integer;
begin
  Result := eGeneration;
end;

function TwbElement.GetElementID: Pointer;
begin
  Result := Pointer(Self);
end;

function TwbElement.GetElementStates: TwbElementStates;
begin
  Result := eStates;
end;

function TwbElement.GetElementType: TwbElementType;
begin
  Assert(False, 'This method is abstract');
  Result := TwbElementType(-1);
end;

function TwbElement.GetFile: IwbFile;
begin
  if Assigned(eContainer) then begin
    Result := IwbContainerInternal(eContainer)._File;
  end else
    Result := nil;
end;

function TwbElement.GetFound: Boolean;
begin
  Result := esFound in eStates;
end;

function TwbElement.GetIndexedPath(aIndexFromFile: Boolean = True): string;
begin
  if Assigned(eContainer) then
    Result := IwbElement(eContainer).IndexedPath[aIndexFromFile]
  else
    Result := '';

  if not aIndexFromFile and Assigned(eContainer) and (IwbElement(eContainer).ElementType in [etFile, etGroupRecord]) then
    Exit;

  if Length(Result) > 0 then
    Result := Result + '\';
  if Assigned(eContainer) then
    Result := Result + '[' + IntToStr(IwbContainer(eContainer).IndexOf(Self)) + ']';
end;

function TwbElement.GetFullPath: string;
begin
  if Assigned(eContainer) then
    Result := IwbElement(eContainer).FullPath
  else
    Result := '';
  Result := Result + ' \ ';
  if Assigned(eContainer) then
    Result := Result + '[' + IntToStr(IwbContainer(eContainer).IndexOf(Self)) + '] ';
  Result := Result + GetName;
end;

function TwbElement.GetPathName: string;
begin
  if Assigned(eContainer) then
    Result := IwbElement(eContainer).PathName
  else
    Result := '';
  Result := Result + ' \ ';
  if Assigned(eContainer) then
    Result := Result + '[' + IntToStr(IwbContainer(eContainer).IndexOf(Self)) + '] ';
  Result := Result + GetShortName;
end;

function TwbElement.GetInjectionSourceFiles: TwbFiles;
var
  Element : IwbElement;
  MainRecord : IwbMainRecord;
begin
  Result := nil;
  Element := GetLinksTo;
  if Supports(Element, IwbMainRecord, MainRecord) and not GetFile.Equals(MainRecord._File) and MainRecord.MasterOrSelf.IsInjected then begin
    SetLength(Result, 1);
    Result[0] := MainRecord.MasterOrSelf._File;
  end;
end;

function TwbElement.GetIsClearable: Boolean;
begin
  Result := False;
end;

function TwbElement.GetIsEditable: Boolean;
begin
  Result := wbIsInternalEdit;
end;

function TwbElement.GetIsHidden: Boolean;
begin
  if [esHidden, esParentHiddenChecked] * eStates = [] then begin
    Include(eStates, esParentHiddenChecked);
    if Assigned(eContainer) and IwbContainer(eContainer).IsHidden then
      Include(eStates, esParentHidden)
    else
      Exclude(eStates, esParentHidden);
  end;
  Result := eStates * [esHidden, esParentHidden] <> [];
end;

function TwbElement.GetIsInjected: Boolean;
begin
  Result := False;
end;

function TwbElement.GetIsNotReachable: Boolean;
begin
  Result := esNotReachable in eStates;
end;

function TwbElement.GetIsReachable: Boolean;
begin
  Result := esReachable in eStates;
end;

function TwbElement.GetIsRemovable: Boolean;
begin
  var Def := GetDef;
  if Assigned(Def) and not Def.IsRemovable(Self) then
    Exit(False);

  var ValueDef := GetValueDef;
  if Assigned(ValueDef) and (ValueDef <> Def) and not ValueDef.IsRemovable(Self) then
    Exit(False);

  Result := not Assigned(eContainer) or IwbContainer(eContainer).IsElementRemovable(Self);
end;

function TwbElement.InternalGetLinksTo: IwbElement;
begin
  Result := nil;
end;

function TwbElement.GetLinksTo: IwbElement;
begin
  if eLinksToGeneration = _GlobalGeneration then
    Result := eCachedLinksTo
  else begin
    Result := InternalGetLinksTo;
    eLinksToGeneration := _GlobalGeneration;
    eCachedLinksTo := Result;
  end;
end;

function TwbElement.GetLocalized: TwbTriBool;
begin
  if esLocalized in eStates then
    Result := tbTrue
  else if esNotLocalized in eStates then
    Result := tbFalse
  else
    Result := tbUnknown;
end;

function TwbElement.GetMastersUpdated: Boolean;
begin
  Result := eMastersGeneration = _MastersGeneration;
end;

function TwbElement.GetMemoryOrder: Integer;
begin
  Result := eMemoryOrder;
end;

function TwbElement.GetModified: Boolean;
begin
  if wbShowInternalEdit then
    Result := [esModified] * eStates = [esModified]
  else
    Result := [esModified, esInternalModified] * eStates = [esModified];
end;

function TwbElement.GetName: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := '';
end;

function TwbElement.GetNameSuffix: string;
begin
  if Assigned(eContainer) then
    IwbContainerInternal(eContainer).UpdateNameSuffixes;
  Result := eNameSuffix;
end;

function TwbElement.GetNativeValue: Variant;
begin
  Result := Null;
end;

function TwbElement.GetNoReach: Boolean;
var
  Def : IwbDef;
begin
  Def := GetValueDef;
  if not Assigned(Def) then
    Def := GetDef;
  if Assigned(Def) then
    Result := Def.NoReach
  else
    Result := False;
end;

function TwbElement.GetPath: string;
begin
  if Assigned(eContainer) then
    Result := IwbElement(eContainer).Path
  else
    Result := '';
  Result := Result + ' \ ' + GetName;
end;

function TwbElement.GetCountedRecordCount: Cardinal;
begin
  Result := 0;
end;

function TwbElement.GetRawDataAsString: string;
begin
  Result := '';
end;

function TwbElement.GetReferenceFile: IwbFile;
var
  Container: IwbContainer;
begin
  Container := GetContainer;
  if Assigned(Container) then
    Result := Container.ReferenceFile
  else
    Result := nil;
end;

function TwbElement.GetReferencesInjected: Boolean;
var
  Element     : IwbElement;
  _File       : IwbFile;
  ElementFile : IwbFile;
  i           : Integer;
begin
  Element := GetLinksTo;
  Result := Assigned(Element) and Element.IsInjected;

  if Result then begin
    _File := GetFile;
    ElementFile := Element._File;
    Result := not _File.Equals(ElementFile);
    if Result then begin
      for i := 0 to Pred(_File.MasterCount[True]) do
        if _File.Masters[i, True].Equals(ElementFile) then begin
          Result := False;
          Exit;
        end;
    end;
  end;
end;

function TwbElement.GetResolvedValueDef: IwbValueDef;
begin
  Result := GetValueDef;
end;

function TwbElement.GetShortName: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := GetName;
end;

function TwbElement.GetSkipped: Boolean;
begin
  Result := False;
end;

function TwbElement.GetSortKey(aExtended: Boolean): string;
begin
  if aExtended then begin
    if not (esExtendedSortKeyValid in eStates) then begin
      if not (esSorting in eStates) then begin
        Include(eStates, esSorting);
        eExtendedSortKey := GetSortKeyInternal(aExtended);
        Exclude(eStates, esSorting);
      end
      else
        eExtendedSortKey := GetSortKeyInternal(aExtended);
      Include(eStates, esExtendedSortKeyValid);
    end;
    Result := eExtendedSortKey;
  end else begin
    if not (esSortKeyValid in eStates) then begin
      if not (esSorting in eStates) then begin
        Include(eStates, esSorting);
        eSortKey := GetSortKeyInternal(aExtended);
        Exclude(eStates, esSorting);
      end else
        eSortKey := GetSortKeyInternal(aExtended);
      Include(eStates, esSortKeyValid);
    end;
    Result := eSortKey;
  end;
end;

function TwbElement.GetSortKeyInternal(aExtended: Boolean): string;
begin
  Result := '';
end;

function TwbElement.GetSortOrder: Integer;
begin
  Result := eSortOrder;
end;

function TwbElement.GetSortPriority: Integer;
begin
  Result := 0;
end;

function TwbElement.GetSummary: string;
begin
  Result := '';
end;

function TwbElement.GetSummaryLinksTo: IwbElement;
begin
  Result := eSummaryLinksTo;
  if Assigned(Result) then
    Exit;

  var lDef := GetDef;
  if not Assigned(lDef) then
    Exit;

  Result := lDef.GetSummaryLinksTo(Self);
  if Assigned(Result) then
    Exit;

  var lValueDef := GetResolvedValueDef;
  if not Assigned(lValueDef) then
    Exit;

  Result := lValueDef.GetSummaryLinksTo(Self);
end;

function TwbElement.GetTreeBranch: Boolean;
var
  NamedDef: IwbNamedDef;
begin
  if Supports(GetDef, IwbNamedDef, NamedDef) then
    Result := NamedDef.TreeBranch
  else
    Result := False;
end;

function TwbElement.GetTreeHead: Boolean;
var
  NamedDef: IwbNamedDef;
begin
  if Supports(GetDef, IwbNamedDef, NamedDef) then
    Result := NamedDef.TreeHead
  else
    Result := False;
end;

function TwbElement.GetValue: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := '';
end;

function TwbElement.GetValueDef: IwbValueDef;
begin
  Result := nil;
end;

function TwbElement.HasErrors: Boolean;
begin
  Result := Trim(GetCheck) <> '';
end;

procedure TwbElement.Hide;
begin
  if not (esHidden in eStates) then begin
    Include(eStates, esHidden);
    ResetConflict;
  end;
end;

procedure TwbElement.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  {can be overriden}
end;

{$D-}
function TwbElement.InternalAddRef: Integer;
begin
  Result := inherited _AddRef;
end;

function TwbElement.InternalRelease: Integer;
begin
  Result := inherited _Release;
end;
{$D+}

procedure TwbElement.InvalidateParentStorage;
begin
  if Assigned(eContainer) then
    (IwbContainer(eContainer) as IwbElementInternal).InvalidateStorage;
end;

procedure TwbElement.InvalidateStorage;
begin
  InvalidateParentStorage;
end;

function TwbElement.IsTagged: Boolean;
begin
  Result := esTagged in eStates;
end;

function TwbElement.LinksToParent: Boolean;
begin
  Result := False;
end;

procedure TwbElement.MarkModifiedRecursive(const aElementTypes: TwbElementTypes);
begin
  if not (GetElementType in aElementTypes) then
    Exit;

  if not Assigned(eContainer) or IwbContainer(eContainer).IsElementEditable(Self) then begin
    SetModified(True);
    InvalidateParentStorage;
  end;
end;

function TwbElement.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
begin
  Result := False;
  Assert( Length(aOld) = Length(aNew) );
end;

function TwbElement.MergeMultiple(const aElement: IwbElement): Boolean;
begin
  Result := False;
end;

procedure TwbElement.MergeStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
{$IFDEF USE_CODESITE}
var
  Log: Boolean;
{$ENDIF}
begin
  {$IFDEF USE_CODESITE}
  Log := (laElementMergeStorage in wbLoggingAreas) and wbCodeSiteLoggingEnabled;
  if Log then begin
    CodeSite.EnterMethod(Self, 'MergeStorage');
    CodeSite.Send('Self.Name', Self.GetName);
    CodeSite.Send('Self.Path', Self.GetPath);
    CodeSite.Send('Self.Value', Self.GetValue);
    CodeSite.Send('Self.SortOrder', Self.eSortOrder);
    CodeSite.Send('Self.MemoryOrder', Self.eMemoryOrder);
    CodeSite.Send('aBasePtr', NativeUInt(aBasePtr), True);
    CodeSite.Send('aEndPtr', NativeUInt(aEndPtr), True);
  end;
  try
  {$ENDIF}
    MergeStorageInternal(aBasePtr, aEndPtr);
  {$IFDEF USE_CODESITE}
  finally
    if Log then begin
      CodeSite.Send('Self.Value', Self.GetValue);
      CodeSite.Send('aBasePtr', NativeUInt(aBasePtr), True);
      CodeSite.Send('aEndPtr', NativeUInt(aEndPtr), True);
      CodeSite.ExitMethod(Self, 'MergeStorage');
    end;
  end;
  {$ENDIF}
end;

procedure TwbElement.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  {can be overriden}
end;

procedure TwbElement.MoveDown;
begin
  if not CanMoveDown then
    Exit;
  IwbContainerInternal(eContainer).MoveElementDown(Self);
end;

procedure TwbElement.MoveUp;
begin
  if not CanMoveUp then
    Exit;
  IwbContainerInternal(eContainer).MoveElementUp(Self);
end;

class function TwbElement.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TwbElement(Result).eExternalRefs := 1;
end;

function TwbElement.NextMember: IwbElement;
begin
  Result := Self;
  if not CanChangeMember then
    Exit;

  Result := IwbContainerInternal(eContainer).ChangeElementMember(Self, False);
end;

procedure TwbElement.NotifyChanged(aContainer: Pointer);
begin
  if eUpdateCount > 0 then
    Include(eStates, esChangeNotified)
  else
    NotifyChangedInternal(aContainer);
end;

procedure TwbElement.NotifyChangedInternal(aContainer: Pointer);
begin
  if Assigned(eContainer) then
    IwbContainerInternal(eContainer).ElementChanged(Self, aContainer);
end;

procedure TwbElement.PrepareSave;
begin
  {can be overriden}
end;

function TwbElement.PreviousMember: IwbElement;
begin
  Result := Self;
  if not CanChangeMember then
    Exit;

  Result := IwbContainerInternal(eContainer).ChangeElementMember(Self, True);
end;

function TwbElement.Reached: Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := not (esReachable in eStates);

  if GetDontShow then
    Exit;

  Exclude(eStates, esNotReachable);
  Include(eStates, esReachable);
  If Result then begin
    if not GetNoReach then
      if Supports(GetLinksTo, IwbMainRecord, MainRecord) then begin
        MainRecord := MainRecord.WinningOverride;
        (MainRecord as IwbElementInternal).Reached;
      end;
    if LinksToParent and Assigned(eContainer) then
      (IwbContainer(eContainer) as IwbElementInternal).Reached;
  end;
end;

procedure TwbElement.Remove;
var
  SelfRef : IwbElement;
  lContainer: IwbContainerElementRef;
begin
  if Assigned(eContainer) then begin
    SelfRef := Self as IwbElement;
    lContainer := IwbContainer(eContainer) as IwbContainerElementRef;

    lContainer.BeginUpdate;
    try
      SetModified(True);
      InvalidateParentStorage;
      BeforeActualRemove;
      lContainer.RemoveElement(SelfRef, True);
    finally
      lContainer.EndUpdate;
    end;
  end;
end;

function TwbElement.RemoveInjected(aCanRemove: Boolean): Boolean;
begin
  Result := GetReferencesInjected;
  if Result and GetIsRemovable then begin
    Result := False;
    Remove;
  end;
end;

procedure TwbElement.ReportRequiredMasters(aDict: TwbFilesDictionary; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false);
var
  Element       : IwbElement;
  ReferenceFile : IwbFile;
begin
  var Def := GetDef;
  if Assigned(Def) and (dfDontAssign in Def.DefFlags) then
    Exit;

  var ValueDef := GetValueDef;
  if Assigned(ValueDef) and (dfDontAssign in ValueDef.DefFlags) then
    Exit;

  Element := GetLinksTo;
  if Assigned(Element) then begin
    ReferenceFile := Element.ReferenceFile;
    if Assigned(ReferenceFile) then
      aDict.TryAdd(ReferenceFile, wbNothing);
  end;
end;

procedure TwbElement.RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal);
begin
  raise Exception.Create(GetName + ' is not editable');
end;

procedure TwbElement.ResetConflict;
begin
  Exclude(eStates, esParentHiddenChecked);
  Exclude(eStates, esParentHidden);
  Exclude(eStates, esSortKeyValid);
  Exclude(eStates, esExtendedSortKeyValid);
end;

procedure TwbElement.ResetReachable;
begin
  Include(eStates, esNotReachable);
  Exclude(eStates, esReachable);
end;

procedure TwbElement.ResetTags;
begin
  Exclude(eStates, esTagged);
end;

procedure TwbElement.SetContainer(const aContainer: IwbContainer);
begin
  if Assigned(aContainer) then begin
    Assert(not Assigned(eContainer));
    if esNotReachable in aContainer.ElementStates then
      Include(eStates, esNotReachable);
  end else
    Assert(Assigned(eContainer));

  if Assigned(aContainer) then
    eContainer := Pointer(aContainer as IwbContainerInternal)
  else
    eContainer := nil;

  if not Assigned(eContainer) then
    eContainerRef := nil
  else
    if eExternalRefs > 0 then
      eContainerRef := aContainer as IwbContainerElementRef;
end;

procedure TwbElement.SetDataSize(aSize: Integer);
begin
  Assert(False, 'Can''t SetDataSize on ' + ClassName);
end;

procedure TwbElement.SetEditValue(const aValue: string);
begin
  raise Exception.Create(GetName + ' can not be edited.');
end;

procedure TwbElement.SetElementState(aState: TwbElementState; Clear: Boolean);
begin
  if Clear then
    Exclude(eStates, aState)
  else
    Include(eStates, aState);
end;

procedure TwbElement.SetFound(const aValue: Boolean);
begin
  if aValue then
    Include(eStates, esFound)
  else
    Exclude(eStates, esFound);
end;

procedure TwbElement.SetInternalModified(aValue: Boolean);
var
  IsInternal: Boolean;
begin
  IsInternal := wbBeginInternalEdit(True);
  try
    SetModified(aValue);
  finally
    if IsInternal then
      wbEndInternalEdit;
  end;
end;

procedure TwbElement.SetLinksTo(const aElement: IwbElement);
begin
  raise Exception.CreateFmt('%s.SetLinksTo is not implemented', [ClassName]);
end;

procedure TwbElement.SetLocalized(const aValue: TwbTriBool);
begin
  case aValue of
    tbUnknown: begin
      Exclude(eStates, esLocalized);
      Exclude(eStates, esNotLocalized);
    end;
    tbFalse: begin
      Exclude(eStates, esLocalized);
      Include(eStates, esNotLocalized);
    end;
    tbTrue: begin
      Include(eStates, esLocalized);
      Exclude(eStates, esNotLocalized);
    end;
  end;
end;

procedure TwbElement.SetMastersUpdated(aValue: Boolean);
begin
  if aValue then
    eMastersGeneration := _MastersGeneration
  else
    eMastersGeneration := 0;
end;

procedure TwbElement.SetMemoryOrder(aIndex: Integer);
begin
  eMemoryOrder := aIndex;
end;

procedure TwbElement.SetModified(aValue: Boolean);
begin
  if aValue then begin

    if wbIsInternalEdit then begin
      if not (esModified in eStates) then
        Include(eStates, esInternalModified);
    end else begin
      Exclude(eStates, esInternalModified);
      Include(eStates, esUnsaved);
    end;

    Include(eStates, esModified);
    Exclude(eStates, esSortKeyValid);
    Exclude(eStates, esExtendedSortKeyValid);
    eSortKey := '';
    eExtendedSortKey := '';

    Inc(eGeneration);
    Inc(_GlobalGeneration);

    if eUpdateCount > 0 then
      Include(eStates, esModifiedUpdated)
    else
      SetParentModified;
  end;
end;

procedure TwbElement.SetNameSuffix(const aSuffix: string);
begin
  eNameSuffix := aSuffix;
end;

procedure TwbElement.SetNativeValue(const aValue: Variant);
begin
  raise Exception.Create(GetName + ' can not be edited.');
end;

procedure TwbElement.SetParentModified;
begin
  if Assigned(eContainer) then
    (IwbContainer(eContainer) as IwbElementInternal).Modified := True;
end;

procedure TwbElement.SetSkipped(aValue: Boolean);
begin
  { can be overridden }
end;

procedure TwbElement.SetSortOrder(aIndex: Integer);
begin
  eSortOrder := aIndex;
end;

procedure TwbElement.SetToDefault;
{$IFDEF USE_CODESITE}
var
  Log: Boolean;
{$ENDIF}
begin
  {$IFDEF USE_CODESITE}
  Log := (laElementSetToDefault in wbLoggingAreas) and wbCodeSiteLoggingEnabled;
  if Log then begin
    CodeSite.EnterMethod(Self, 'SetToDefault');
    CodeSite.Send('Self.Name', Self.GetName);
    CodeSite.Send('Self.Path', Self.GetPath);
    CodeSite.Send('Self.DataSize', Self.GetDataSize);
    CodeSite.Send('Self.Value', Self.GetValue);
  end;
  {$ENDIF}
  BeginUpdate;
  try
    SetToDefaultInternal;
  finally
    EndUpdate;
  {$IFDEF USE_CODESITE}
    if Log then begin
      CodeSite.Send('Self.Value', Self.GetValue);
      CodeSite.Send('Self.DataSize', Self.GetDataSize);
      CodeSite.ExitMethod(Self, 'SetToDefault');
    end;
  {$ENDIF}
  end;
end;

procedure TwbElement.SetToDefaultIfAsCreatedEmpty;
begin
  {overriden in TwbContainer}
end;

procedure TwbElement.SetToDefaultInternal;
begin
  { can be overriden }
end;

function TwbElement.ShouldReportError(aErrorType: TwbElementErrorType): Boolean;
var
  State: TwbElementState;
begin
  State := TwbElementState(Ord(esReportedErrorReading) + Ord(aErrorType));
  Result := not (State in eStates);
  Include(eStates, State);
end;

procedure TwbElement.Show;
begin
  if esHidden in eStates then begin
    Exclude(eStates, esHidden);
    ResetConflict;
  end;
end;

procedure TwbElement.Tag;
begin
  Include(eStates, esTagged);
end;

procedure TwbElement.TryAssignMembers(const aSource: IwbElement);
begin
  {can be overridden}
end;

procedure TwbElement.UpdateEnded;
var
  IsInternal: Boolean;
begin
  while esChangeNotified in eStates do begin
    Exclude(eStates, esChangeNotified);
    NotifyChangedInternal(eContainer);
  end;
  if esModifiedUpdated in eStates then begin
    Exclude(eStates, esModifiedUpdated);
    if esModified in eStates then begin
      if esInternalModified in eStates then begin
        IsInternal := wbBeginInternalEdit(True);
        try
          SetParentModified;
        finally
          if IsInternal then
            wbEndInternalEdit;
        end;
      end else
        SetParentModified;
    end;
  end;
end;

procedure TwbElement.WriteToStream(aStream: TStream; aResetModified: TwbResetModified);
{$IFDEF USE_CODESITE}
var
  Log: Boolean;
{$ENDIF}
begin
  {$IFDEF USE_CODESITE}
  Log := (laElementWriteToStream in wbLoggingAreas) and wbCodeSiteLoggingEnabled;
  if Log then begin
    CodeSite.EnterMethod(Self, 'WriteToStream');
    CodeSite.Send('Self.Name', Self.GetName);
    CodeSite.Send('Self.Path', Self.GetPath);
    CodeSite.Send('Self.Value', Self.GetValue);
    CodeSite.Send('aStream.Position', aStream.Position);
    CodeSite.Send('aResetModified', GetEnumName(TypeInfo(TwbResetModified), Ord(aResetModified)));
  end;
  try
  {$ENDIF}
    WriteToStreamInternal(aStream, aResetModified);
  {$IFDEF USE_CODESITE}
  finally
    if Log then begin
      CodeSite.Send('aStream.Position', aStream.Position);
      CodeSite.Send('Self.Value', Self.GetValue);
      CodeSite.ExitMethod(Self, 'WriteToStream');
    end;
  end;
  {$ENDIF}
end;

procedure TwbElement.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
begin
  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

{$D-}
function TwbElement._AddRef: Integer;
label
  Skip;
begin
  Assert(not (esDestroying in eStates));
  {$IFDEF WIN64}
  if LockedInc(eExternalRefs) = 1 then
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov  eax, 1
         mov  ecx, [Self]
    lock xadd dword ptr [ecx + eExternalRefs], eax
         cmp  eax, 0
         jne  Skip
  end;
  {$ENDIF WIN32}
  eContainerRef := IInterface(eContainer) as IwbContainerElementRef;
Skip:

  Result := inherited _AddRef;
end;

function TwbElement._Release: Integer;
label
  Skip;
begin
  {$IFDEF WIN64}
  if LockedDec(eExternalRefs) = 0 then
  {$ENDIF WIN64}
  {$IFDEF WIN32}
  asm
         mov  eax, -1
         mov  ecx, [Self]
    lock xadd dword ptr [ecx + eExternalRefs], eax
         cmp  eax, 1
         jne  Skip
  end;
  {$ENDIF WIN32}
  eContainerRef := nil;
Skip:
  Result := inherited _Release;
end;
{$D+}

{ TwbSubRecordArray }

function TwbSubRecordArray.Add(const aName: string; aSilent: Boolean): IwbElement;
begin
  Result := Assign(StrToIntDef(aName, wbAssignAdd), nil, False);
end;

function TwbSubRecordArray.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  Assert(Assigned(aElement.Def));
  Assert(arcDef.Element.Equals(aElement.Def));

  if arcSorted and not aAsNew then begin
    Assert(not arcSortInvalid);
    if FindBySortKey(aElement.SortKey[False], False,i) then begin
      Result := cntElements[i];
      if aDeepCopy then
        Result.Assign(wbAssignThis, aElement, False);
      Exit;
    end;
  end;

  if (csAsCreatedEmpty in cntStates) then begin
    SetModified(True);
    Assert(Length(cntElements)=1);
    Result := cntElements[0];
    Exclude(cntStates, csAsCreatedEmpty);
  end else
    case arcDef.Element.DefType of
      dtSubRecord:
        Result := TwbSubRecord.Create(Self, arcDef.Element as IwbSubRecordDef);
      dtSubRecordArray:
        Result := TwbSubRecordArray.Create(Self, nil, wbAssignThis, arcDef.Element as IwbSubRecordArrayDef);
      dtSubRecordStruct:
        Result := TwbSubRecordStruct.Create(Self, nil, wbAssignThis, arcDef.Element as IwbSubRecordStructDef);
    else
      Assert(False);
    end;

  try
    Result.Assign(wbAssignThis, aElement, not aDeepCopy);
  except
    Result.Container.RemoveElement(Result);
    Result := nil;
    raise;
  end;
end;

function TwbSubRecordArray.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Element       : IwbElement;
  Container     : IwbContainer;
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  ElementDef    : IwbRecordMemberDef;
  DataContainer : IwbDataContainer;
begin
  Result := nil;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  var lMultipleElements: IwbMultipleElements;
  if  Supports(aElement, IwbMultipleElements, lMultipleElements) then begin
    for var lElementIdx := 0 to Pred(lMultipleElements.ElementCount) do begin
      var lResult := AssignInternal(aIndex, lMultipleElements.Elements[lElementIdx], aOnlySK);
      if Assigned(lResult) then
        Result := lResult;
    end;
    Exit;
  end;

  if (aIndex = wbAssignThis) and arcDef.CanAssign(Self, aIndex, aElement.Def) then begin

    if aOnlySK then
      Exit;

    Container := aElement as IwbContainer;

    SetModified(True);
    InvalidateStorage;
    ReleaseElements;

    for i := 0 to Pred(Container.ElementCount) do
      Assign(i, Container.Elements[i], aOnlySK);

  end else if (aIndex >= 0) and (not Assigned(aElement) or arcDef.Element.CanAssign(Self, wbAssignThis, aElement.Def))  or
    ((aIndex = wbAssignThis) and arcDef.Element.CanAssign(Self, aIndex, aElement.Def)) then begin

    Element := nil;

    var lElement := aElement;

    if (csAsCreatedEmpty in cntStates) and Assigned(lElement) then begin
      SetModified(True);
      Assert(Length(cntElements)=1);
      Element := cntElements[0];
      Exclude(cntStates, csAsCreatedEmpty);
    end else begin

      ElementDef := arcDef.Element;
      while ElementDef.DefType = dtSubRecordUnion do begin
        if Assigned(lElement) then begin
          var lTemplate: IwbTemplateElement;
          if Supports(lElement, IwbTemplateElement, lTemplate) then begin
            if not Supports(lTemplate.Def, IwbRecordMemberDef, ElementDef) then
              ElementDef := nil;
            lElement := nil;
            Break;
          end else begin
            Supports(lElement, IwbDataContainer, DataContainer);
            ElementDef := (ElementDef as IwbRecordDef).GetMemberFor(Self, (lElement as IwbHasSignature).Signature, DataContainer)
          end;
        end else
          ElementDef := (ElementDef as IwbRecordDef).Members[0];
        Assert(Assigned(ElementDef));
      end;

      Element := nil;
      if Assigned(ElementDef) then
        case ElementDef.DefType of
          dtSubRecord:
            Element := TwbSubRecord.Create(Self, ElementDef as IwbSubRecordDef);
          dtSubRecordArray:
            Element := TwbSubRecordArray.Create(Self, nil, wbAssignThis, ElementDef as IwbSubRecordArrayDef);
          dtSubRecordStruct:
            Element := TwbSubRecordStruct.Create(Self, nil, wbAssignThis, ElementDef as IwbSubRecordStructDef);
        else
          Assert(False);
        end;
    end;

    if Assigned(Element) and Assigned(lElement) then try
      Element.Assign(wbAssignThis, lElement, aOnlySK);
      if csAsCreatedEmpty in cntStates then
        Exclude(cntStates, csAsCreatedEmpty);
    except
      Element.Container.RemoveElement(Element);
      raise;
    end;

    Result := Element;
  end;

  arcSorted := False;
  if wbSortSubRecords and arcDef.Sorted[IwbContainer(eContainer)] then begin
    if Length(cntElements) > 1 then
      wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSortKeys);
    arcSorted := True;
  end;
end;

procedure TwbSubRecordArray.BeforeActualRemove;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self;

  inherited;

  var lCountPath := arcDef.CountPath;

  if lCountPath = '' then
    Exit;

  var lContainer := GetContainer as IwbContainerElementRef;
  if not Assigned(lContainer) then
    Exit;

  //this way will prevent the creating of the Elements along the path if they don't already exist
  var lCounterElement := lContainer.ElementByPath[lCountPath];
  if not Assigned(lCounterElement) then
    Exit;

  lCounterElement.NativeValue := 0;
end;

function TwbSubRecordArray.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;

  function CheckAssign(const aElement: IwbElement): Boolean;
  begin
    Result := arcDef.CanAssign(Self, aIndex, aElement.Def);
    if not Result then begin
      Result := arcDef.Element.CanAssign(Self, wbAssignThis, aElement.Def);
      if Result then
        if aCheckDontShow and arcDef.Element.DontShow[aElement] then
          Result := False;
    end;
  end;

begin
  Result := False;
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;
    if dfInternalEditOnly in arcDef.DefFlags then
      Exit;
  end;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  if not Assigned(aElement) then begin
    Result := aIndex >= 0;
    Exit;
  end;

  var lMultipleElements: IwbMultipleElements;
  if  Supports(aElement, IwbMultipleElements, lMultipleElements) then begin
    for var lElementIdx := 0 to Pred(lMultipleElements.ElementCount) do begin
      Result := CheckAssign(lMultipleElements.Elements[lElementIdx]);
      if Result then
        Exit;
    end;
  end else
    Result := CheckAssign(aElement);
end;

function TwbSubRecordArray.CanContainFormIDs: Boolean;
begin
  Result := dfCanContainFormID in arcDef.DefFlags;
end;

function TwbSubRecordArray.CanMoveElement: Boolean;
begin
  Result :=
    not arcSorted and
    not (dfNoMove in arcDef.DefFlags);
end;

function TwbSubRecordArray.CanElementReset: Boolean;
begin
//  Result := inherited CanElementReset;
  Result := cntElementRefs < 1;
end;

constructor TwbSubRecordArray.Create(const aOwner     : IwbContainer;
                                     const aContainer : IwbContainer;
                                           aPos       : Integer;
                                     const aDef       : IwbSubRecordArrayDef);
var
  DEV      : TArray<string>;
  MinCount : Integer;
  i        : Integer;
begin
  arcDef := aDef;
  eContainer := Pointer(aOwner);
  try
    if aPos <> Low(Integer) then begin
      DoProcess(aContainer, aPos)
    end else begin
      DEV := arcDef.DefaultEditValues;
      if dfArrayCanBeEmpty in arcDef.DefFlags then
        MinCount := 0
      else
        MinCount := 1;
      MinCount := Max(Max(MinCount, arcDef.Count), Length(DEV));
      while Length(cntElements) < MinCount do
        Assign(wbAssignAdd, nil, False);
      for i := Low(DEV) to High(DEV) do
        cntElements[i].EditValue := DEV[i];
      Include(cntStates, csAsCreatedEmpty);
    end;
  finally
    eContainer := nil;
  end;
  inherited Create(aOwner);
  if aPos = Low(Integer) then begin
    SetModified(True);
    InvalidateStorage;
  end;
end;

procedure TwbSubRecordArray.DoAfterSet(const aOldValue, aNewValue: Variant);
var
  SelfRef    : IwbContainerElementRef;
begin
  SelfRef := Self;

  inherited;

  UpdateCountViaPath;
end;

procedure TwbSubRecordArray.DoInit(aNeedSorted: Boolean);
begin
  inherited;
  if aNeedSorted or wbAlwaysSorted then
    if arcSorted and arcSortInvalid then begin
      if Length(cntElements) > 1 then
        wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSortKeys);
      arcSortInvalid := False;
    end;
end;

procedure TwbSubRecordArray.DoProcess(const aContainer : IwbContainer;
                                                  aPos : Integer);
var
  SubRecord  : IwbSubRecordInternal;
  ElementDef : IwbRecordMemberDef;
  Element    : IwbElement;
  SelfRef    : IwbContainerElementRef;
begin
  SelfRef := Self;

  while (aPos < aContainer.ElementCount) and
    (aContainer[aPos].ElementType = etSubRecord) do begin

    SubRecord := aContainer[aPos] as IwbSubRecordInternal;
    if SubRecord.Skipped then begin
      Inc(aPos);
      Continue;
    end;
    ElementDef := arcDef.Element;
    if ElementDef.DefType = dtSubRecordUnion then begin
      ElementDef := (ElementDef as IwbRecordDef).GetMemberFor(Self, SubRecord.Signature, SubRecord);
      if not Assigned(ElementDef) then
        Break;
    end;

    if not ElementDef.CanHandle(Self, SubRecord.Signature, SubRecord) then
      Break;

    case ElementDef.DefType of
      dtSubRecord: begin
        aContainer.RemoveElement(aPos);
        SubRecord.SetDef(ElementDef as IwbSubRecordDef);
        AddElement(SubRecord);
      end;
      dtSubRecordArray: begin
        Element := TwbSubRecordArray.Create(Self, aContainer, aPos, ElementDef as IwbSubRecordArrayDef);
      end;
      dtSubRecordStruct:
        Element := TwbSubRecordStruct.Create(Self, aContainer, aPos, ElementDef as IwbSubRecordStructDef);
    else
      raise Exception.CreateFmt('Unexpected def type for SubRecord %s in array', [String(SubRecord.Signature)]);
    end;

  end;

  arcSorted := False;
  if wbSortSubRecords and arcDef.Sorted[aContainer] then begin
    arcSorted := True;
    arcSortInvalid := True;
  end;
end;

procedure TwbSubRecordArray.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
begin
  inherited;
  if arcSorted then
    arcSortInvalid := True;
end;

function TwbSubRecordArray.GetAlignable: Boolean;
begin
  if wbCompareRawData then
    Exit(False);

  if GetSorted then
    Exit(False);
  if Assigned(arcDef) and (dfNotAlignable in arcDef.DefFlags) then
    Exit(False);
  Result := True;
end;
{
function TwbSubRecordArray.GetAssignTemplates(aIndex: Integer): TwbTemplateElements;
begin
  Result := nil;
  if not Assigned(arcDef)  then
    Exit;
  if aIndex <> wbAssignAdd then
    Exit;

  var lRUnion: IwbSubRecordUnionDef;
  if not Supports(arcDef.Element, IwbSubRecordUnionDef, lRUnion) then
    Exit;
  SetLength(Result, lRUnion.MemberCount);
  for var lMemberIdx := Low(Result) to High(Result) do
    Result[lMemberIdx] := TwbTemplateElement.Create(lRUnion.Members[lMemberIdx]);
end;
}
function TwbSubRecordArray.GetCheck: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(arcDef) then
    Exit;
  DoInit(False);

  arcDef.ToString(Result, Self, ctCheck);
end;

function TwbSubRecordArray.GetDef: IwbNamedDef;
begin
  Result := arcDef;
end;

function TwbSubRecordArray.GetElementType: TwbElementType;
begin
  Result := etSubRecordArray;
end;

function TwbSubRecordArray.GetName: string;
begin
  Result := arcDef.GetName;
end;

function TwbSubRecordArray.GetSignature: TwbSignature;
var
  i       : Integer;
  lRecord : IwbRecord;

  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if GetElementCount > 0 then begin
    Assert(not arcSortInvalid);
    Result := NONE;
    for i := 0 to Pred(GetElementCount) do
      if Supports(GetElement(i), IwbRecord, lRecord) then begin
        Result := lRecord.Signature;
        Exit;
      end;
  end;
end;

function TwbSubRecordArray.GetSorted: Boolean;
begin
  if wbCompareRawData then
    Exit(False);

  Result := arcSorted;
end;

function TwbSubRecordArray.GetSummary: string;
var
  SelfRef : IwbContainerElementRef;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Assigned(arcDef) then
    Exit;
  DoInit(True);

  eSummaryLinksTo := nil;
  Result := arcDef.ToSummary(0, Self, eSummaryLinksTo);
end;

function TwbSubRecordArray.GetValue: string;
var
  SelfRef : IwbContainerElementRef;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Assigned(arcDef) then
    Exit;
  DoInit(True);

  arcDef.ToString(Result, Self, ctToStr);
end;

function TwbSubRecordArray.IsElementRemovable(const aElement: IwbElement): Boolean;
var
  MinCount: Integer;
begin
  MinCount := Max(1, arcDef.Count);
  Result := IsElementEditable(aElement)
    and not (dfArrayStaticSize in arcDef.DefFlags)
    and (Length(cntElements) > MinCount);

  if Result and (dfRemoveLastOnly in arcDef.DefFlags) then
    Result := cntElements[High(cntElements)].Equals(aElement);
end;

procedure TwbSubRecordArray.SetModified(aValue: Boolean);
begin
  inherited;
  if aValue and arcSorted then
    arcSortInvalid := True;
end;

procedure TwbSubRecordArray.SetToDefaultInternal;
begin
  inherited;
  UpdateCountViaPath;
end;

procedure TwbSubRecordArray.UpdateCountViaPath;
var
  SelfRef    : IwbContainerElementRef;
begin
  SelfRef := Self;

  var lCountPath := arcDef.CountPath;

  if lCountPath = '' then
    Exit;

  var lContainer := GetContainer as IwbContainerElementRef;
  if not Assigned(lContainer) then
    Exit;

  var lElementCount := GetElementCount;

  if lElementCount > 0 then begin
    //setting it this way will try to create the elements along the path if necessary
    lContainer.ElementNativeValues[lCountPath] := lElementCount;
    Exit;
  end;

  //this way will prevent the creating of the Elements along the path if they don't already exist
  var lCounterElement := lContainer.ElementByPath[lCountPath];
  if not Assigned(lCounterElement) then
    Exit;

  lCounterElement.NativeValue := lElementCount;
end;

procedure TwbSubRecordArray.UpdateNameSuffixes;
var
  i: Integer;
begin
  if arcSorted then
    Exit;
  if arcNameGen >= eGeneration then
    Exit;

  arcNameGen := eGeneration;

  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].NameSuffix := '#' + i.ToString;
end;

{ TwbSubRecordStruct }

function TwbSubRecordStruct.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  Signature : TwbSignature;
  Index     : Integer;
  SelfRef   : IwbContainerElementRef;
begin
  Result := nil;

  if not IsElementEditable(nil) then
    raise Exception.Create('"' + GetName + '" is not editable');

  Result := nil;

  if Length(aName) < 4 then
    Exit;

  Signature := StrToSignature(aName);

  SelfRef := Self;

  Result := GetElementBySignature(Signature);
  if Assigned(Result) then
    Exit;

  Index := srcDef.GetMemberIndexFor(Self, Signature, nil);
  if Index < 0 then
    Exit;

  Assign(Index, nil, False);
  Result := GetElementBySignature(Signature);
  Assert(Assigned(Result));
end;

function TwbSubRecordStruct.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  Assert(aElement.SortOrder >= 0);
  Assert(aElement.SortOrder < srcDef.MemberCount);
  Assert(Assigned(aElement.Def));
  Assert(aElement.Def.Equals(srcDef.Members[aElement.SortOrder]));

  Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
  if not Assigned(Result) then begin
    Assign(aElement.SortOrder, aElement, not aDeepCopy);
    Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
    Assert(Assigned(Result));

    if wbSortSubRecords and (Length(cntElements) > 1) then
      wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSubRecords);
  end else
    Result.Assign(wbAssignThis, aElement, not aDeepCopy);
end;

procedure TwbSubRecordStruct.AddRequiredElements;
var
  CurrentDefPos : Integer;
  CurrentDef    : IwbRecordMemberDef;
  Element       : IwbElementInternal;
begin
  var lAnyCreated := False;
  var lRepeated := False;
  repeat
    for CurrentDefPos := 0 to Pred(srcDef.MemberCount) do begin
      CurrentDef := srcDef.Members[CurrentDefPos];
      if lRepeated or ((CurrentDefPos = 0) and not (srcDef.AllowUnordered or (dfStructFirstNotRequired in srcDef.DefFlags))) or CurrentDef.Required then begin

        if CurrentDef.DefType = dtSubRecordUnion then begin
          CurrentDef := (CurrentDef as IwbRecordDef).Members[0];
          Assert(Assigned(CurrentDef));
        end;

        case CurrentDef.DefType of
          dtSubRecord :       Element := TwbSubRecord.Create(Self, CurrentDef as IwbSubRecordDef);
          dtSubRecordArray  : Element := TwbSubRecordArray.Create(Self, nil, Low(Integer), CurrentDef as IwbSubRecordArrayDef);
          dtSubRecordStruct : Element := TwbSubRecordStruct.Create(Self, nil, Low(Integer), CurrentDef as IwbSubRecordStructDef);
        else
          Assert(False);
        end;

        Element.SetSortOrder(CurrentDefPos);
        Element.SetMemoryOrder(CurrentDefPos);

        if lRepeated then
          Exit;
        lAnyCreated := True;
      end;
    end;
    Assert(not lRepeated);
    Exit;
    lRepeated := True;
  until lAnyCreated;
end;

function TwbSubRecordStruct.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
begin
  Result := nil;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  if aIndex = wbAssignThis then begin

    if Assigned(aElement) and not srcDef.Equals(aElement.Def) then begin
      var lTargetUnionParent: IwbSubRecordUnionDef;
      var lSourceUnionParent: IwbSubRecordUnionDef;
      if Assigned(srcDef) and
         Assigned(aElement.Def) and
         Supports(srcDef.Parent, IwbSubRecordUnionDef, lTargetUnionParent) and
         Supports(aElement.Def.Parent, IwbSubRecordUnionDef, lSourceUnionParent) and
         lTargetUnionParent.Equals(lSourceUnionParent)
      then begin
        //We are in an RUnion and need to switch to a different type

        var lContainer := GetContainer;
        var lContainerElementRef: IwbContainerElementRef;
        if not Supports(lContainer, IwbContainerElementRef, lContainerElementRef) then
          Exit;

        var lReplacementElement: IwbElement;
        case aElement.Def.DefType of
          dtSubRecord:
            lReplacementElement := TwbSubRecord.Create(lContainer, aElement.Def as IwbSubRecordDef);
          dtSubRecordArray:
            lReplacementElement := TwbSubRecordArray.Create(lContainer, nil, Low(Integer), aElement.Def as IwbSubRecordArrayDef);
          dtSubRecordStruct:
            lReplacementElement := TwbSubRecordStruct.Create(lContainer, nil, Low(Integer), aElement.Def as IwbSubRecordStructDef);
        else
          Assert(False);
        end;

        if Assigned(lReplacementElement) then try
          lReplacementElement.SortOrder := Self.GetSortOrder;
          lReplacementElement.MemoryOrder := Self.GetMemoryOrder;
          if Assigned(aElement) and (aElement.ElementType <> etTemplate) then
            lReplacementElement.Assign(wbAssignThis, aElement, aOnlySK);
          lContainer.RemoveElement(Self);
          lContainer.SortBySortOrder;
        except
          lReplacementElement.Container.RemoveElement(lReplacementElement);
          raise;
        end;
      end;

      Exit;
    end;

    var lElementAsContainer: IwbContainerElementRef;
    if not Supports(aElement, IwbContainerElementRef, lElementAsContainer) then
      lElementAsContainer := nil;

    SetModified(True);
    InvalidateStorage;
    ReleaseElements;
    AddRequiredElements;

    if Assigned(lElementAsContainer) then
      for var lContainedElementIdx := 0 to Pred(lElementAsContainer.ElementCount) do begin
        var lContainedElement := lElementAsContainer.Elements[lContainedElementIdx];
        if not aOnlySK or GetIsInSK(lContainedElement.SortOrder) then
          Assign(lContainedElement.SortOrder, lContainedElement, aOnlySK);
      end;

  end else begin

    if (aIndex >= 0) and (aIndex < srcDef.MemberCount) then begin
      var lMember := srcDef.Members[aIndex];
      if not Assigned(aElement) or lMember.CanAssign(Self, wbAssignThis, aElement.Def) then begin
        var lResultElement := GetElementBySortOrder(aIndex + GetAdditionalElementCount);
        if Assigned(lResultElement) then begin
          if Assigned(aElement) then
            lResultElement.Assign(wbAssignThis, aElement, aOnlySK)
        end else begin

          var lDefType := lMember.DefType;
          if lDefType = dtSubRecordUnion then begin
            if Assigned(aElement) then begin
              lMember := aElement.Def as IwbRecordMemberDef;
              lDefType := lMember.DefType;
            end else begin
              repeat
                var lUnion := lMember as IwbSubRecordUnionDef;
                lMember :=lUnion.Members[0];
                lDefType := lMember.DefType;
              until lDefType <> dtSubRecordUnion;
            end;
          end;

          case lDefType of
            dtSubRecord:
              lResultElement := TwbSubRecord.Create(Self, lMember as IwbSubRecordDef);
            dtSubRecordArray:
              lResultElement := TwbSubRecordArray.Create(Self, nil, Low(Integer), lMember as IwbSubRecordArrayDef);
            dtSubRecordStruct:
              lResultElement := TwbSubRecordStruct.Create(Self, nil, Low(Integer), lMember as IwbSubRecordStructDef);
            dtSubRecordUnion:
              lResultElement := nil;
          else
            Assert(False);
          end;

          if Assigned(lResultElement) then try
            lResultElement.SortOrder := aIndex;
            if Assigned(aElement) and (aElement.ElementType <> etTemplate) then
              lResultElement.Assign(wbAssignThis, aElement, aOnlySK);
          except
            lResultElement.Container.RemoveElement(lResultElement);
            raise;
          end;

        end;
        Result := lResultElement;
      end;
    end;
  end;

  if wbSortSubRecords and (Length(cntElements) > 1) then
    wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSubRecords);
end;

function TwbSubRecordStruct.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
begin
  Result := False;
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;
    if dfInternalEditOnly in srcDef.DefFlags then
      Exit;
  end;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  if Assigned(srcDef) then begin
    if not Assigned(aElement) then begin
      Result := (aIndex >= 0) and (aIndex < srcDef.MemberCount) and (GetElementBySortOrder(aIndex + GetAdditionalElementCount) = nil);
      if Result and aCheckDontShow then
        if srcDef.Members[aIndex].DontShow[Self] then
          Result := False;
        if Result and not wbIsInternalEdit then
          if dfInternalEditOnly in srcDef.Members[aIndex].DefFlags then
            Result := False;
      Exit;
    end;

    if aIndex = wbAssignThis then begin
      Result := srcDef.Equals(aElement.Def);
      if not Result then begin
        var lTargetUnionParent: IwbSubRecordUnionDef;
        var lSourceUnionParent: IwbSubRecordUnionDef;
        if Assigned(srcDef) and
           Assigned(aElement.Def) and
           Supports(srcDef.Parent, IwbSubRecordUnionDef, lTargetUnionParent) and
           Supports(aElement.Def.Parent, IwbSubRecordUnionDef, lSourceUnionParent) and
           lTargetUnionParent.Equals(lSourceUnionParent)
        then
          Result := True;
      end;
    end else begin
      Result := (aIndex >= 0) and (aIndex < srcDef.MemberCount) and
        srcDef.Members[aIndex].CanAssign(Self, wbAssignThis, aElement.Def);
      if Result and aCheckDontShow then
        if srcDef.Members[aIndex].DontShow[Self] then
          Result := False;
      if Result and not wbIsInternalEdit then
        if dfInternalEditOnly in srcDef.Members[aIndex].DefFlags then
          Result := False;
    end;
  end else
    Result := False;
end;

function TwbSubRecordStruct.CanContainFormIDs: Boolean;
begin
 Result := dfCanContainFormID in srcDef.DefFlags;
end;

function TwbSubRecordStruct.CanElementReset: Boolean;
begin
//  Result := inherited CanElementReset;
  Result := cntElementRefs < 1;
end;

constructor TwbSubRecordStruct.Create(const aOwner     : IwbContainer;
                                      const aContainer : IwbContainer;
                                            aPos       : Integer;
                                      const aDef       : IwbSubRecordStructDef);
var
  CurrentDefPos : Integer;
  CurrentRec    : IwbSubRecordInternal;
  CurrentDef    : IwbRecordMemberDef;
  LastDef       : IwbRecordMemberDef;
  Element       : IwbElementInternal;
  LastElement   : IwbElementInternal;
  FoundMembers  : IwbElements;
begin
  srcDef := aDef as IwbRecordDef;
  LastDef := nil;
  LastElement := nil;

  try
    inherited Create(aOwner);

    if aPos = Low(Integer) then begin
      AddRequiredElements;
    end else begin
      SetLength(FoundMembers, srcDef.MemberCount);
      CurrentDefPos := 0;
      while (aPos < aContainer.ElementCount) and (CurrentDefPos < srcDef.MemberCount) do begin

        if aContainer[aPos].ElementType <> etSubRecord then
          Break;

        CurrentRec := aContainer[aPos] as IwbSubRecordInternal;

        if CurrentRec.Skipped then begin
          Inc(aPos);
          Continue;
        end;

        if not srcDef.ContainsMemberFor(Self, CurrentRec.Signature, CurrentRec) then begin
          if srcDef.SkipSignature[CurrentRec.Signature] then begin
            Inc(aPos);
            Continue;
          end;
          Break;
        end;

        if srcDef.AllowUnordered then begin

          CurrentDefPos := srcDef.GetMemberIndexFor(Self, CurrentRec.Signature, CurrentRec);
          if CurrentDefPos < 0 then begin
            if wbHasProgressCallback then
              wbProgressCallback('Error: record ' + String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) + ' ' + IntToHex(Int64(Cardinal(CurrentRec.Signature)), 8) );
            //FoundError := True;
            Inc(aPos);
            Continue;
          end;
          CurrentDef := srcDef.Members[CurrentDefPos];

        end;

        CurrentDef := srcDef.Members[CurrentDefPos];
        if not CurrentDef.CanHandle(Self, CurrentRec.Signature, CurrentRec) then begin
          if Assigned(LastDef)
             and
             (dfMergeIfMultiple in LastDef.DefFlags)
             and
             LastDef.CanHandle(Self, CurrentRec.Signature, CurrentRec)
          then begin
            if LastElement.MergeMultiple(CurrentRec) then begin
              aContainer.RemoveElement(aPos);
              Continue;
            end;
          end;
          Inc(CurrentDefPos);
          Continue;
        end;

        if CurrentDef.DefType = dtSubRecordUnion then begin
          CurrentDef := (CurrentDef as IwbRecordDef).GetMemberFor(Self, CurrentRec.Signature, CurrentRec);
          Assert(Assigned(CurrentDef));
        end;

        if Assigned(FoundMembers[CurrentDefPos]) then begin
          if dfMergeIfMultiple in CurrentDef.DefFlags then
            if FoundMembers[CurrentDefPos].MergeMultiple(CurrentRec) then
              Continue;
          Break; // don't allow duplicate members
        end;

        case CurrentDef.DefType of
          dtSubRecord : begin
            aContainer.RemoveElement(aPos);
            CurrentRec.SetDef(CurrentDef as IwbSubRecordDef);
            AddElement(CurrentRec);
            Element := CurrentRec as IwbElementInternal;
          end;
          dtSubRecordArray  : Element := TwbSubRecordArray.Create(Self, aContainer, aPos, CurrentDef as IwbSubRecordArrayDef);
          dtSubRecordStruct : Element := TwbSubRecordStruct.Create(Self, aContainer, aPos, CurrentDef as IwbSubRecordStructDef);
        else
          raise Exception.CreateFmt('Unexpected def type for SubRecord %s', [String(CurrentRec.Signature)]);
        end;

        Element.SetSortOrder(CurrentDefPos);
        Element.SetMemoryOrder(CurrentDefPos);
        FoundMembers[CurrentDefPos] := Element;
        LastDef := CurrentDef;
        LastElement := Element;

        if dfTerminator in CurrentDef.DefFlags then
          Break;

        if srcDef.AllowUnordered then
          CurrentDefPos := 0
        else
          Inc(CurrentDefPos);
      end;
    end;

    FoundMembers := nil;

    srcDef.AfterLoad(Self);

    if aPos = Low(Integer) then begin
      SetModified(True);
      InvalidateStorage;
    end;
  except
    Remove;
    raise;
  end;
end;
{
function TwbSubRecordStruct.GetAssignTemplates(aIndex: Integer): TwbTemplateElements;
begin
  Result := nil;
  if not Assigned(srcDef) then
    Exit;
  if not ((aIndex >= 0) and (aIndex < srcDef.MemberCount)) then
    Exit;
  var lRUnion: IwbSubRecordUnionDef;
  if not Supports(srcDef.Members[aIndex], IwbSubRecordUnionDef, lRUnion) then
    Exit;
  SetLength(Result, lRUnion.MemberCount);
  for var lMemberIdx := Low(Result) to High(Result) do
    Result[lMemberIdx] := TwbTemplateElement.Create(lRUnion.Members[lMemberIdx]);
end;
}
function TwbSubRecordStruct.GetCheck: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(srcDef) then
    Exit;
  DoInit(False);

  srcDef.ToString(Result, Self, ctCheck);
end;

function TwbSubRecordStruct.GetDef: IwbNamedDef;
begin
  Result := srcDef;
end;

function TwbSubRecordStruct.GetElementType: TwbElementType;
begin
  Result := etSubRecordStruct;
end;

function TwbSubRecordStruct.GetIsInSK(aIndex: Integer): Boolean;
var
  SelfRef    : IwbContainerElementRef;
  HasSortKey : IwbHasSortKeyDef;
begin
  Result := False;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  if not Supports(srcDef, IwbHasSortKeyDef, HasSortKey) then
    Exit;

  Result := HasSortKey.IsInSK(aIndex);
end;

function TwbSubRecordStruct.GetName: string;
begin
  Result := srcDef.GetName;
end;

function TwbSubRecordStruct.GetSignature: TwbSignature;
var
  i       : Integer;
  lRecord : IwbRecord;

  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := NONE;
  for i := 0 to Pred(GetElementCount) do
    if Supports(GetElement(i), IwbRecord, lRecord) then begin
      Result := lRecord.Signature;
      Exit;
    end;
end;

function TwbSubRecordStruct.GetSortKeyInternal(aExtended: Boolean): string;
var
  HasSortKey : IwbHasSortKeyDef;
  SortMember : Integer;
  Element    : IwbElement;
  i          : Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := '';
  if Supports(srcDef, IwbHasSortKeyDef, HasSortKey) then begin
    DoInit(True);
    if HasSortKey.SortKeyCount[False] > 0 then
      for i := 0 to Pred(HasSortKey.SortKeyCount[aExtended]) do begin
        SortMember := HasSortKey.SortKeys[i, aExtended];
        Element := GetElementBySortOrder(SortMember + GetAdditionalElementCount);
        if Assigned(Element) then
          Result := Result + Element.SortKey[aExtended];

        if i < Pred(HasSortKey.SortKeyCount[aExtended]) then
          Result := Result + '|';
      end;
  end;
end;

function TwbSubRecordStruct.GetSummary: string;
var
  SelfRef    : IwbContainerElementRef;
  Def        : IwbDef;
  RMD        : IwbRecordMemberDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;

  Result := '';
  if not Supports(srcDef, IwbRecordMemberDef, RMD) then
    Exit;
  DoInit(True);

  eSummaryLinksTo := nil;
  Result := RMD.ToSummary(0, Self, eSummaryLinksTo);
end;

function TwbSubRecordStruct.GetValue: string;
var
  SelfRef    : IwbContainerElementRef;
  Def        : IwbDef;
  RMD        : IwbRecordMemberDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Supports(srcDef, IwbRecordMemberDef, RMD) then
    Exit;
  DoInit(True);

  RMD.ToString(Result, Self, ctToStr);
end;

function TwbSubRecordStruct.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement) and (Length(cntElements) > 1) and ((srcDef.AllowUnordered or (dfStructFirstNotRequired in srcDef.DefFlags)) or not cntElements[0].Equals(aElement));
  if Result and Assigned(aElement.Def) then
    Result := not aElement.Def.Required;
end;

function TwbSubRecordStruct.RemoveInjected(aCanRemove: Boolean): Boolean;
var
  Element   : IwbElement;
  Container : IwbContainerElementRef;
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
begin
  if SameText(GetName, 'Result Script') then begin
    Result := False;

    SelfRef := Self as IwbContainerElementRef;
    DoInit(False);

    if Supports(GetElementByName('References'), IwbContainerElementRef, Container) then
      for i := 0 to Pred(Container.ElementCount) do begin
        Result := Container.Elements[i].ReferencesInjected;
        if Result then
          Break;
      end;

    if Result then begin
      Result := False;
      Container.Remove;
      Element := GetRecordBySignature('SCHD');
      if Assigned(Element) then
        Element.Remove;
      Element := GetRecordBySignature('SCDA');
      if Assigned(Element) then
        Element.Remove;
      Element := GetRecordBySignature('SCTX');
      if Assigned(Element) then
        Element.Remove;
      if Supports(GetRecordBySignature('SCHR'), IwbContainerElementRef, Container) then begin
        Container.ElementByName['RefCount'].EditValue := '0';
        Container.ElementByName['CompiledSize'].EditValue := '0';
        Container.ElementByName['VariableCount'].EditValue := '0';
      end;
    end;
  end else
    Result := inherited RemoveInjected(aCanRemove);
end;

procedure TwbSubRecordStruct.TryAssignMembers(const aSource: IwbElement);
var
  SelfRef           : IwbContainerElementRef;
  SelfRecordDef     : IwbRecordDef;
  SelfHasSortKey    : IwbHasSortKeyDef;

  SourceContainer   : IwbContainerElementRef;
  SourceRecordDef   : IwbRecordDef;
  SourceHasSortKey  : IwbHasSortKeyDef;

  i, j              : Integer;

  SourceElement     : IwbElement;
  TargetElement     : IwbElement;

  SourceElementDef  : IwbNamedDef;
  SourceMemberIndex : Integer;

  TargetElementDef  : IwbNamedDef;
  TargetMemberIndex : Integer;
begin
  if not Supports(aSource, IwbContainerElementRef, SourceContainer) then
    Exit;

  if not Supports(SourceContainer.Def, IwbRecordDef, SourceRecordDef) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if not Supports(GetDef, IwbRecordDef, SelfRecordDef) then
    Exit;

  for i := 0 to Pred(SourceContainer.ElementCount) do begin
    SourceElement := SourceContainer.Elements[i];
    TargetElement := GetElementByName(SourceElement.Name);

    if Assigned(TargetElement) and TargetElement.CanAssign(wbAssignThis, SourceElement, False) then
      TargetElement.Assign(wbAssignThis, SourceElement, False)
    else begin
      SourceElementDef := SourceElement.Def;
      TargetMemberIndex := -1;
      for j := 0 to Pred(SelfRecordDef.MemberCount) do begin
        TargetElementDef := SelfRecordDef.Members[j];
        if SourceElementDef.Name = TargetElementDef.Name then
          if TargetElementDef.CanAssign(nil, wbAssignThis, SourceElementDef) then begin
            TargetMemberIndex := j;
            Break;
          end;
      end;
      if TargetMemberIndex >= 0 then
        TargetElement := Assign(TargetMemberIndex, SourceElement, False);
    end;
  end;

  if not Supports(GetDef, IwbHasSortKeyDef, SelfHasSortKey) then
    Exit;
  if not Supports(SourceContainer.Def, IwbHasSortKeyDef, SourceHasSortKey) then
    Exit;

  if SelfHasSortKey.SortKeyCount[False] < 1 then
    Exit;
  if SourceHasSortKey.SortKeyCount[False] < 1 then
    Exit;

  TargetMemberIndex := SelfHasSortKey.SortKeys[0, False];
  SourceMemberIndex := SourceHasSortKey.SortKeys[0, False];

  TargetElementDef := SelfRecordDef.Members[TargetMemberIndex];
  SourceElementDef := SourceRecordDef.Members[SourceMemberIndex];

  if TargetElementDef.CanAssign(nil, wbAssignThis, SourceElementDef) then begin
    SourceElement := SourceContainer.ElementBySortOrder[SourceMemberIndex + SourceContainer.AdditionalElementCount];
    if Assigned(SourceElement) then
      Assign(TargetMemberIndex, SourceElement, False);
  end;
end;

function ArrayDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; out SizePrefix: Integer): Boolean;
var
  Element     : IwbElement;
  ArrayDef    : IwbArrayDef;
  ValueDef    : IwbValueDef;
  i           : Integer;
  t           : string;
  VarSize     : Boolean;
  ArrSize     : Int64;
  ElementSize : Integer;

  DefaultEditValues: TArray<string>;


  function ElementCanBeZeroSize: Boolean;
  begin
    if ElementSize < 0 then
      ElementSize := ArrayDef.Element.DefaultSize[nil,nil,nil];
    Result := ElementSize = 0;
  end;

begin
  ElementSize := -1;
  ArrayDef := aValueDef as IwbArrayDef;
  Result := wbSortSubRecords and ArrayDef.Sorted;
  if not ArrayDef.CanAddTo then
    aContainer.SetElementState(esNotSuitableToAddTo);

  SizePrefix := ArrayDef.PrefixSize[aBasePtr];

  i := 0;

  ValueDef := ArrayDef.Element;
  if ValueDef.DefType = dtResolvable then
    ValueDef := Resolve(ValueDef, nil, nil, aContainer);
  if dfUnionStaticResolve in ValueDef.DefFlags then
    ValueDef := Resolve(ValueDef, nil, nil, aContainer);

  VarSize := ArrayDef.IsVariableSize;
  ArrSize := ArrayDef.ElementCount;

  if not Assigned(aBasePtr) then begin
    DefaultEditValues := ArrayDef.GetDefaultEditValues;
    if Length(DefaultEditValues) > 0 then
      ArrSize := Max(ArrSize, Length(DefaultEditValues));
  end;

  if ArrSize < 0 then begin
    ArrSize := ArrayDef.PrefixCount[aBasePtr];
  end else
    if (ArrSize < 1) and Assigned(ArrayDef.CountCallback) then
      ArrSize := ArrayDef.CountCallback(aBasePtr, aEndPtr, aContainer)
    else if VarSize then begin
      if (ArrSize > 0) and not Assigned(aBasePtr) then
        VarSize := False //the array is static in size, even if the elements aren't...
      else
        if Assigned(aBasePtr) then begin
          if ArrSize < 1 then
            ArrSize := High(Integer)
        end else
          if SizePrefix = 0 then
            ArrSize := 1;
    end;

  if Assigned(aBasePtr) then
    Inc(PByte(aBasePtr), SizePrefix);

  var lWronglyAssumedFixedSizePerElement := ArrayDef.WronglyAssumedFixedSizePerElement;
  var lFinalBasePtr := nil;
  if lWronglyAssumedFixedSizePerElement > 0 then
    if Assigned(aBasePtr) and Assigned(aEndPtr) then begin
      ArrSize := NativeInt((NativeUInt(aEndPtr) - NativeUInt(aBasePtr))) div lWronglyAssumedFixedSizePerElement;
      lFinalBasePtr := Pointer(NativeUInt(aBasePtr) + NativeUInt(lWronglyAssumedFixedSizePerElement * ArrSize));
    end;

  var lArrayElementNoName := ArrayDef.Element.Name = '';

  if ArrSize > 0 then
    while not VarSize or
          (not Assigned(aBasePtr)) or
          (NativeUInt(aBasePtr) < NativeUInt(aEndPtr)) or
          (ArrSize < High(Integer)) and ((NativeUInt(aBasePtr) = NativeUInt(aEndPtr)) and ElementCanBeZeroSize)
    do begin
      if Result then
        t := ''
      else
        t := ArrayDef.ElementNameSuffix[i];

      if not ArrayDef.ShouldInclude(aBasePtr, aEndPtr, aContainer) then
        Break;

      case ValueDef.DefType of
        dtArray: Element := TwbArray.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtStruct: Element := TwbStruct.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtStructChapter: Element := TwbChapter.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtUnion: Element := wbUnionCreate(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtString: begin
          if Assigned(aBasePtr) and (PAnsiChar(aBasePtr)^ = #0) and (ValueDef.IsVariableSize) then begin
            Inc(PByte(aBasePtr));
            Break;
          end;
          Element := TwbValue.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        end;
      else
        Element := TwbValue.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
      end;

      Element.MemoryOrder := i;

      if Length(DefaultEditValues) > i then
        Element.EditValue := DefaultEditValues[i];

      Inc(i);
      if VarSize and not Assigned(aBasePtr) then begin
        (aContainer as IwbContainerInternal).CreatedEmpty;
        Break;
      end;

      if ArrSize < High(Integer) then
        Dec(ArrSize);
      if ArrSize = 0 then
        Break
      { else if not (not VarSize or ((NativeUInt(aBasePtr) < NativeUInt(aEndPtr)) or (not Assigned(aBasePtr)))) then
        wbProgressCallback('Error: not enough data for array. Elements remaining are ' + IntToStr(ArrSize)) Silently fails = called at an invalid time };
    end;

  if Assigned(lFinalBasePtr) and  (NativeUInt(aBasePtr) < NativeUInt(lFinalBasePtr)) then
    aBasePtr := lFinalBasePtr;

  if (ValueDef.DefType = dtString) and (ValueDef.IsVariableSize) then
    Element := TwbStringListTerminator.Create(aContainer);

  ArrayDef.AfterLoad(aContainer);
end;

{ TwbArray }

procedure TwbArray.Init;
var
  BasePtr: Pointer;
begin
  inherited;

  if GetSkipped then
    Exit;

  BasePtr := GetDataBasePtr;
  arrSorted := ArrayDoInit(vbValueDef, Self, BasePtr, dcDataEndPtr, arrSizePrefix);

  arrSortInvalid := arrSorted;
end;

function TwbArray.Add(const aName: string; aSilent: Boolean): IwbElement;
begin
  Result := Assign(StrToIntDef(aName, wbAssignAdd), nil, False);
end;

function TwbArray.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aSuffixRemove, aPrefix, aSuffix: string; aAllowOverwrite: Boolean): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
  s         : string;
  ArrayDef  : IwbArrayDef;
  ValueDef  : IwbValueDef;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be modified.');
  end;

  SelfRef := Self as IwbContainerElementRef;

  DoInit(True);

  ArrayDef := vbValueDef as IwbArrayDef;

  if arrSorted then begin
    Assert(not arrSortInvalid);
    if FindBySortKey(aElement.SortKey[False], False, i) then begin
      Result := cntElements[i];
      if aDeepCopy then
        Result.Assign(wbAssignThis, aElement, False);
      Exit;
    end;
  end;

  if arrSorted then
    s := ''
  else
    s := '#' + IntToStr(Length(cntElements));

  if not Supports(aElement, IwbStringListTerminator) then
    ValueDef := ArrayDef.Element;
    if ValueDef.DefType = dtResolvable then
      ValueDef := Resolve(ValueDef, nil, nil, aElement);
    if dfUnionStaticResolve in ValueDef.DefFlags then
      ValueDef := Resolve(ValueDef, nil, nil, aElement);
    case ValueDef.DefType of
      dtArray: Result := TwbArray.Create(Self, ValueDef, aElement, not aDeepCopy, s);
      dtStruct: Result := TwbStruct.Create(Self, ValueDef, aElement, not aDeepCopy, s);
      dtStructChapter: Result := TwbChapter.Create(Self, ValueDef, aElement, not aDeepCopy, s);
      dtUnion: Result := wbUnionCreate(Self, ValueDef, aElement, not aDeepCopy, s);
    else
      Result := TwbValue.Create(Self, ValueDef, aElement, not aDeepCopy, s);
    end;

  CheckCount;
  CheckTerminator;
end;

function TwbArray.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Element       : IwbElement;
  sElement      : IwbElement;
  dElement      : IwbElement;
  ArrayDef      : IwbArrayDef;
  ValueDef      : IwbValueDef;
  Container     : IwbContainer;
  DataContainer : IwbDataContainer;
  s             : string;
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  p, q          : Pointer;
begin
  Result := nil;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False); //function will only either replace all elements or add new elements, sort order is irrelevant

  ArrayDef := vbValueDef as IwbArrayDef;

  if (aIndex = wbAssignThis) and ArrayDef.CanAssign(Self, aIndex, aElement.ValueDef) then begin

    if aOnlySK then
      Exit;

    Container := aElement as IwbContainer;

    if ArrayDef.IsVariableSize then begin
      Assert(ArrayDef.ElementCount <= 0);
      SetModified(True);
      InvalidateStorage;
      ReleaseElements;
      dcDataStorage := nil;
      dcDataBasePtr := @EmptyPtr;
      dcDataEndPtr := @EmptyPtr;
      Exclude(dcFlags, dcfStorageInvalid);
      if ArrayDef.ElementCount < 0 then
        if aElement.DataSize > 0 then begin
          RequestStorageChange(p, q, aElement.DataSize);
          if Supports(aElement, IwbDataContainer, DataContainer) then begin
            q := DataContainer.DataBasePtr;
            Move(q^, p^, aElement.DataSize);
          end;
        end else
          RequestStorageChange(p, q, ArrayDef.PrefixSize[nil]);
      NotifyChanged(eContainer);

      for i := 0 to Pred(Container.ElementCount) do
        Assign(i, Container.Elements[i], aOnlySK);
    end else begin
      Assert(Container.ElementCount = ArrayDef.ElementCount);
      Assert(GetElementCount = ArrayDef.ElementCount);

      for i := 0 to Pred(Container.ElementCount) do begin
        sElement := Container.Elements[i];
        dElement := GetElementByMemoryOrder(i);
        dElement.Assign(wbAssignThis, sElement, aOnlySK);
      end;
    end;

  end else begin
    if (aIndex >= 0) and (ArrayDef.ElementCount <= 0) and ((aIndex = wbAssignAdd) or ArrayDef.Element.CanAssign(Self, wbAssignThis, aElement.ValueDef)) then begin
      {add one entry}

      if arrSorted then
        s := ''
      else
        s := '#' + IntToStr(Length(cntElements));

      Element := nil;

      if not Supports(aElement, IwbStringListTerminator) then
        ValueDef := ArrayDef.Element;
        if ValueDef.DefType = dtResolvable then
          ValueDef := Resolve(ValueDef, nil, nil, aElement);
        if dfUnionStaticResolve in ValueDef.DefFlags then
          ValueDef := Resolve(ValueDef, nil, nil, aElement);
        case ValueDef.DefType of
          dtArray: Element := TwbArray.Create(Self, ValueDef, aElement, aOnlySK, s);
          dtStruct: Element := TwbStruct.Create(Self, ValueDef, aElement, aOnlySK, s);
          dtStructChapter: Element := TwbChapter.Create(Self, ValueDef, aElement, aOnlySK, s);
          dtUnion: Element := wbUnionCreate(Self, ValueDef, aElement, aOnlySK, s);
        else
          Element := TwbValue.Create(Self, ValueDef, aElement, aOnlySK, s);
        end;

      Result := Element;
    end;
  end;

  CheckCount;
  CheckTerminator;
end;

procedure TwbArray.BeforeActualRemove;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self;

  inherited;

  var lCountPath := (vbValueDef as IwbArrayDef).CountPath;

  if lCountPath = '' then
    Exit;

  var lContainer := GetContainer as IwbContainerElementRef;
  if not Assigned(lContainer) then
    Exit;

  //this way will prevent the creating of the Elements along the path if they don't already exist
  var lCounterElement := lContainer.ElementByPath[lCountPath];
  if not Assigned(lCounterElement) then
    Exit;

  lCounterElement.NativeValue := 0;
end;

function TwbArray.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  ArrayDef: IwbArrayDef;
begin
  Result := False;
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      Exit;
    if Assigned(vbValueDef) and (dfInternalEditOnly in vbValueDef.DefFlags) then
      Exit;
  end;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  ArrayDef := vbValueDef as IwbArrayDef;
  if not Assigned(aElement) then begin
    if aIndex = wbAssignAdd then
      Result := ArrayDef.ElementCount <= 0;
    Exit;
  end;
  Result :=
     ArrayDef.CanAssign(Self, aIndex, aElement.ValueDef) or
     ( (ArrayDef.ElementCount <= 0) and ArrayDef.Element.CanAssign(Self, wbAssignThis, aElement.ValueDef) );
end;

function TwbArray.CanMoveElement: Boolean;
begin
  Result :=
    not arrSorted and
    not (dfNoMove in vbValueDef.DefFlags);
end;

procedure TwbArray.CheckCount;
var
  Count       : Int64;
  i           : Integer;
  UpdateCount : Integer;
  ArrayDef    : IwbArrayDef;
begin
  if eUpdateCount > 0 then
    Exit; {will be checked in NotifyChangedInternal}

  if arrSizePrefix = 0 then
    Exit;

  ArrayDef := vbValueDef as IwbArrayDef;
  Count := arrayDef.PrefixCount[dcDataBasePtr];

  DoInit(False);

  if Count <> Length(cntElements) then begin
    UpdateCount := eUpdateCount;
    for i := 1 to UpdateCount do EndUpdate;  // Stops optimisation
    try
      SetModified(True);
      InvalidateStorage;
      UpdateStorageFromElements;
      ArrayDef.SetPrefixCount(dcDataBasePtr, Length(cntElements));
    finally
      for i := 1 to UpdateCount do BeginUpdate; // Restore optimisation
    end;
  end;
end;

procedure TwbArray.CheckTerminator;
var
  i        : Integer;
  ArrayDef : IwbArrayDef;
begin
  if eUpdateCount > 0 then
    Exit; {will be checked in NotifyChangedInternal}

  ArrayDef := vbValueDef as IwbArrayDef;
  if not ArrayDef.IsVariableSize then
    Exit;
  if ArrayDef.Element.DefType <> dtString then
    Exit;

  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbStringListTerminator) then
      Exit;

  SetModified(True);
  InvalidateStorage;
  TwbStringListTerminator.Create(Self);
  if arrSorted then
    arrSortInvalid := True;
end;

procedure TwbArray.Clear;
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self;

  if not GetIsClearable then
    Exit;

  inherited;

  for var lElementIdx := Pred(GetElementCount) downto 0 do begin
    var lElement := GetElement(lElementIdx);
    if lElement.IsRemovable then
      lElement.Remove;
  end;
end;

procedure TwbArray.DoAfterSet(const aOldValue, aNewValue: Variant);
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self;

  inherited;

  UpdateCountViaPath;
end;

procedure TwbArray.DoInit(aNeedSorted: Boolean);
var
  i       : Integer;
  Sorting : Boolean;
begin
  inherited;
  if aNeedSorted or wbAlwaysSorted then
    if arrSorted and arrSortInvalid then
      if (Length(cntElements) > 1) then begin
        Sorting := False;
        for i := 0 to Length(cntElements)-1 do
          if (esSorting in (cntElements[i] as IwbElementInternal).ElementStates) then begin
            Sorting := True;
            Break;
          end;
          if not Sorting then begin
            wbMergeSortPtr(@cntElements[0], Length(cntElements), CompareSortKeys);
            arrSortInvalid := False;
          end;
      end;
end;

procedure TwbArray.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
begin
  inherited;
  if arrSorted then
    arrSortInvalid := True;
end;

function TwbArray.GetAlignable: Boolean;
begin
  if wbCompareRawData then
    Exit(False);

  if GetSorted then
    Exit(False);
  if not Assigned(vbValueDef) then
    Exit(False);
  if dfNotAlignable in vbValueDef.DefFlags then
    Exit(False);

  Result := ((vbValueDef as IwbArrayDef).ElementCount <= 0);
end;

function TwbArray.GetDataPrefixSize: Integer;
begin
  Result := arrSizePrefix;
end;

function TwbArray.GetElementType: TwbElementType;
begin
  Result := etArray;
end;

function TwbArray.GetIsClearable: Boolean;
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self;

  Result := (vbValueDef as IwbArrayDef).ElementCount <= 0;
  if not Result then
    Exit;

  var lElementCount := GetElementCount;
  if lElementCount = 0 then
    Exit(False);

  for var lElementIdx := Pred(lElementCount) downto 0 do
    if not GetElement(lElementIdx).IsRemovable then
      Exit(False);
end;

function TwbArray.GetSorted: Boolean;
begin
  if wbCompareRawData then
    Exit(False);

  Result := arrSorted;
end;

function TwbArray.IsElementRemovable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement)
    and not (dfArrayStaticSize in vbValueDef.DefFlags)
    and ((vbValueDef as IwbArrayDef).ElementCount <= 0)
    { and (Length(cntElements)>1)};

  if Result and (dfRemoveLastOnly in vbValueDef.DefFlags) then
    Result := cntElements[High(cntElements)].Equals(aElement);
end;

procedure TwbArray.NotifyChangedInternal(aContainer: Pointer);
begin
  if esModified in eStates then begin
    CheckCount;
    CheckTerminator;
  end;
  inherited;
end;

procedure TwbArray.PrepareSave;
begin
  CheckCount;
  CheckTerminator;
  inherited;
end;

procedure TwbArray.Reset;
begin
  ReleaseElements;
  arrSorted := False;
  arrSortInvalid := False;
  inherited;
end;

procedure TwbArray.ResetMemoryOrder(aFrom: Integer = 0; aTo: Integer = High(Integer));
var
  SetSuffix : Boolean;
  i         : Integer;
begin
  SetSuffix := not arrSorted;
  aFrom := Max(aFrom, Low(cntElements));
  aTo := Min(aTo, High(cntElements));

  var lArrayDef: IwbArrayDef;
  SetSuffix := SetSuffix and Supports(vbValueDef, IwbArrayDef, lArrayDef);

  for i := aFrom to aTo do begin
    cntElements[i].MemoryOrder := i;
    if SetSuffix then
      cntElements[i].NameSuffix := lArrayDef.ElementNameSuffix[i];
  end;
end;

procedure TwbArray.SetModified(aValue: Boolean);
begin
  inherited;
  if aValue and arrSorted then
    arrSortInvalid := True;
end;

procedure TwbArray.SetToDefaultInternal;
var
  SelfRef           : IwbContainerElementRef;
  ArrayDef          : IwbArrayDef;
  DefaultEditValues : TArray<string>;
  i                 : Integer;
begin
  SelfRef := Self as IwbContainerElementRef;

  inherited;

  if Supports(vbValueDef, IwbArrayDef, ArrayDef) then begin
    DefaultEditValues := ArrayDef.GetDefaultEditValues;
    for i := 0 to Pred(Min(Length(DefaultEditValues), GetElementCount)) do
      cntElements[i].EditValue := DefaultEditValues[i];
  end;
  UpdateCountViaPath;
end;

procedure TwbArray.UpdateCountViaPath;
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self;

  var lCountPath := (vbValueDef as IwbArrayDef).CountPath;

  if lCountPath = '' then
    Exit;

  var lContainer := GetContainer as IwbContainerElementRef;
  if not Assigned(lContainer) then
    Exit;

  var lElementCount := GetElementCount;

  if lElementCount > 0 then begin
    //setting it this way will try to create the elements along the path if necessary
    lContainer.ElementNativeValues[lCountPath] := lElementCount;
    Exit;
  end;

  //this way will prevent the creating of the Elements along the path if they don't already exist
  var lCounterElement := lContainer.ElementByPath[lCountPath];
  if not Assigned(lCounterElement) then
    Exit;

  lCounterElement.NativeValue := lElementCount;
end;

{ TwbStruct }

procedure StructDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer);
var
  StructDef           : IwbStructDef;
  i                   : Integer;
  ValueDef            : IwbValueDef;
  Element             : IwbElementInternal;
  IntegerDef          : IwbIntegerDef;
  OptionalFromElement : Integer;
  Size                : Cardinal;
  over                : Boolean;
begin
  StructDef := aValueDef as IwbStructDef;

  OptionalFromElement := StructDef.OptionalFromElement;
  if OptionalFromElement < 0 then
    OptionalFromElement := High(Integer);

  for i := 0 to Pred(StructDef.MemberCount) do begin
    ValueDef := StructDef.Members[i];
    if ValueDef.DefType = dtResolvable then
      ValueDef := Resolve(ValueDef, nil, nil, aContainer);
    if dfUnionStaticResolve in ValueDef.DefFlags then
      ValueDef := Resolve(ValueDef, nil, nil, aContainer);

    Over := False;
    if Assigned(aBasePtr) and (i >= OptionalFromElement) then begin
      over := (NativeUInt(aBasePtr) >= NativeUInt(aEndPtr));
      if not over then begin
        Size := ValueDef.Size[aBasePtr, aEndPtr, aContainer];
        over := (Size<Cardinal(High(Integer))) and  //Intercept multiple calls to Size[ during initialisation
                ((NativeUInt(aBasePtr) + Size) > NativeUInt(aEndPtr));
      end;
      if over then begin
        aEndPtr := aBasePtr;
        ValueDef := Resolve(ValueDef, aBasePtr, aEndPtr, aContainer);
        if Supports(ValueDef, IwbIntegerDef, IntegerDef) and Supports(IntegerDef.Formater[aContainer], IwbFlagsDef) then
          ValueDef := wbEmpty(ValueDef.Name, ValueDef.ConflictPriority[nil], False, nil, True)
        else
          ValueDef := wbEmpty(ValueDef.Name, ValueDef.ConflictPriority[nil]);
      end;
    end;

    case ValueDef.DefType of
      dtArray: Element := TwbArray.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtStruct: Element := TwbStruct.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtStructChapter: Element := TwbChapter.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtUnion: Element := wbUnionCreate(aContainer, aBasePtr, aEndPtr, ValueDef, '');
    else
      Element := TwbValue.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
    end;

    if Over then
      Element.FlagAsOptionalAndMissing;

    {if wbHideUnused and not wbEditAllowed and (Element.GetName = 'Unused') then begin
      with aContainer do begin
        Assert((LastElement as IwbElementInternal) = Element);
        RemoveElement(Pred(ElementCount));
      end;
    end else} begin
      Element.SetSortOrder(i);
      Element.SetMemoryOrder(i);
    end;
  end;

  StructDef.AfterLoad(aContainer);
end;

procedure TwbStruct.Init;
var
  BasePtr: Pointer;
begin
  inherited;

  if GetSkipped then
    Exit;

  DecompressIfNeeded;

  BasePtr := GetDataBasePtr;
  StructDoInit(vbValueDef, Self, BasePtr, dcDataEndPtr);
end;

function TwbStruct.GetElementType: TwbElementType;
begin
  Result := etStruct;
end;

procedure TwbStruct.Reset;
begin
  ReleaseElements;
  inherited;
end;

procedure TwbStruct.DecompressIfNeeded;
var
  sc : TwbStructCompression;
begin
  sc := IsCompressed;
  if sc <> scNone then try
    InitDataPtr; // reset...

    SetLength(dcDataStorage, szUncompressedSize );

    case sc of
      scNone: Assert(False);  // Getting there would be very funny :)
      scZComp:
        DecompressToUserBuf(
          PByte(dcDataBasePtr),
          GetDataSize,
          @dcDataStorage[0],
          PCardinal(dcDataBasePtr)^
        );
      scLZComp:
        LZ4_decompress_safe(PAnsiChar(dcDataBasePtr), @dcDataStorage[0], GetDataSize, szUncompressedSize);
      else
        Assert(False);  // Something hasn't been updated yet.
    end;

    dcDataEndPtr := PByte(@dcDataStorage[0]) + szUncompressedSize;
    dcDataBasePtr := @dcDataStorage[0];
  except
    dcDataBasePtr := nil;
    dcDataEndPtr := nil;
  end;
end;

function TwbStruct.GetIsCompressed: TwbStructCompression;
var
  szDef : IwbStructZDef;
  lzDef : IwbStructLZDef;
begin
  if (szCompressedSize = 0) then
    if Supports(vbValueDef, IwbStructZDef, szDef)  then begin
      szUncompressedSize := szDef.GetSizing(GetDataBasePtr, GetDataEndPtr, Self, szCompressedSize);
      if szUncompressedSize <> 0 then szCompressedType := scZComp;
    end else if Supports(vbValueDef, IwbStructLZDef, lzDef)  then begin
      szUncompressedSize := lzDef.GetSizing(GetDataBasePtr, GetDataEndPtr, Self, szCompressedSize);
      if szUncompressedSize <> 0 then szCompressedType := scLZComp;
    end else
      szCompressedSize := -1;
  Result := szCompressedType;
end;

{ TwbUnion }

function UnionDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; var aResolvedDef : IwbValueDef): TwbUnionFlags;
var
  ResolvableDef : IwbResolvableDef;
  ArrayDef      : IwbArrayDef;
  Element       : IwbElementInternal;
begin
  Result := ufNone;
  ResolvableDef := aValueDef as IwbResolvableDef;

  aResolvedDef := ResolvableDef.ResolveDef(aBasePtr, aEndPtr, aContainer);

  if Assigned(aResolvedDef) then begin
    if aResolvedDef.DefType = dtResolvable then
      aResolvedDef := Resolve(aResolvedDef, aBasePtr, aEndPtr, aContainer);
    if dfUnionStaticResolve in aResolvedDef.DefFlags then
      aResolvedDef := Resolve(aResolvedDef, aBasePtr, aEndPtr, aContainer);
  end;

  if Assigned(aResolvedDef) then // I had one case. Most likely due to an error in wbXXXXDefinitions
    case aResolvedDef.DefType of
      dtArray: begin
        if wbSortSubRecords and Supports(aResolvedDef, IwbArrayDef, ArrayDef) and ArrayDef.Sorted then
          Result := ufSortedArray
        else
          Result := ufArray;
        Element := TwbArray.Create(aContainer, aBasePtr, aEndPtr, aResolvedDef, '');
      end;
      dtStruct: Element := TwbStruct.Create(aContainer, aBasePtr, aEndPtr, aResolvedDef, '');
      dtStructChapter: Element := TwbChapter.Create(aContainer, aBasePtr, aEndPtr, aResolvedDef, '');
      dtUnion: Element := wbUnionCreate(aContainer, aBasePtr, aEndPtr, aResolvedDef, '');
    else
      Element := nil; // >>> so that simple union behave as they did <<< TwbValue.Create(aContainer, aBasePtr, aEndPtr, aResolvedDef, '');
      if ValueDoInit(aValueDef, aContainer, aBasePtr, aEndPtr, aContainer, nil, aResolvedDef) then Result := ufFlags;
    end;

  if Assigned(Element) then begin
    Element.SetSortOrder(0);
    Element.SetMemoryOrder(0);
  end;

  ResolvableDef.AfterLoad(aContainer);
end;

function TwbUnion.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);

  BeginUpdate;
  try
    Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);

    ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
    if Assigned(ResolvedDef) then
      if ResolvedDef.CompareExchangeFormID(GetDataBasePtr, dcDataEndPtr, Self, aOldFormID, aNewFormID) then begin
        SetModified(True);
        Result := True;
        //wbProgress('Replaced FormID [%s] with [%s] in "%s". New Value: %s', [aOldFormID.ToString, aNewFormID.ToString, GetPath, GetValue]);
      end;
  finally
    EndUpdate;
  end;
end;

function TwbUnion.GetElementType: TwbElementType;
begin
  Result := etUnion;
end;

function TwbUnion.GetResolvedValueDef: IwbValueDef;
begin
  Result := inherited;
  if Assigned(Result) and
     Assigned(unResolvedDef) and
     not unResolvedDef.Equals(Result) and
     (unResolvedDef.DefType <> dtUnion) and
     (Result.DefType <> dtUnion)
  then begin
    var lShouldDataSize := Result.Size[GetDataBasePtr, dcDataEndPtr, Self];
    var lIsDataSize := GetDataSize;

    var lShouldDefType := Result.DefType;
    var lIsDefType := unResolvedDef.DefType;

    var lOldDef := unResolvedDef;
    unResolvedDef := Result;

    if (lShouldDataSize <> lIsDataSize)
       or
       (lShouldDefType <> lIsDefType)
       or
       not unResolvedDef.CanAssign(nil, wbAssignThis, lOldDef)
    then begin
      var lFile := GetFile;
      if not Assigned(lFile) or lFile.IsElementEditable(Self) then
        SetToDefault;
    end else
      Reset;
  end;
end;

procedure TwbUnion.Init;
var
  BasePtr: Pointer;
begin
  inherited;

  if GetSkipped then
    Exit;

  BasePtr := GetDataBasePtr;
  UnionDoInit(vbValueDef, Self, BasePtr, dcDataEndPtr, unResolvedDef);
end;

function TwbUnion.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  BeginUpdate;
  try
    DoInit(False);

    Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);

    ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
    if Assigned(ResolvedDef) then
      if ResolvedDef.MastersUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew, aOldCount, aNewCount) then begin
        Result := True;
        SetMastersUpdated(True);
        SetModified(True);
      end;
  finally
    EndUpdate;
  end;
end;

procedure TwbUnion.FindUsedMasters(aMasters: PwbUsedMasters);
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);

  inherited FindUsedMasters(aMasters);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.FindUsedMasters(GetDataBasePtr, dcDataEndPtr, Self, aMasters);
end;

procedure TwbUnion.RecheckDecider;
begin
  GetResolvedValueDef;
end;

procedure TwbUnion.Reset;
begin
  ReleaseElements;
  inherited;
end;

{ TwbValue }

function TwbValue.AddIfMissingInternal(const aElement        : IwbElement;
                                             aAsNew          : Boolean;
                                             aDeepCopy       : Boolean;
                                       const aPrefixRemove   : string;
                                       const aSuffixRemove   : string;
                                       const aPrefix         : string;
                                       const aSuffix         : string;
                                             aAllowOverwrite : Boolean)
                                                             : IwbElement;
var
  Flag       : IwbFlag;
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  s          : string;
begin
  if vIsFlags and Supports(aElement, IwbFlag, Flag) then
    if Supports(vbValueDef, IwbIntegerDef, IntegerDef) then
      if Supports(IntegerDef.Formater[Self], IwbFlagsDef, FlagsDef) then
        if FlagsDef.CanAssign(Self, wbAssignThis, Flag.FlagsDef) then begin
          s := GetEditValue;
          s := s + StringOfChar('0', 64 - Length(s));
          if (Flag.FlagIndex >= 0) and (Flag.FlagIndex < Length(s)) then begin
            s[Succ(Flag.FlagIndex)] := '1';
            SetEditValue(s);
            Exit(GetElementBySortOrder(Flag.FlagIndex));
          end;
        end;

  Result := inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aSuffixRemove, aPrefix, aSuffix, aAllowOverwrite)
end;

function TwbValue.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);

  BeginUpdate;
  try
    Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);

    ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
    if Assigned(ResolvedDef) then
      if ResolvedDef.CompareExchangeFormID(GetDataBasePtr, dcDataEndPtr, Self, aOldFormID, aNewFormID) then begin
        SetModified(True);
        Result := True;
        //wbProgress('Replaced FormID [%s] with [%s] in "%s". New Value: %s', [aOldFormID.ToString, aNewFormID.ToString, GetFullPath, GetValue]);
      end;
  finally
    EndUpdate;
  end;
end;

function ValueDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; const aPrevFlags: TDynElementInternals; var aResolvedDef: IwbValueDef): Boolean;
var
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  i, j, k, l : Int64;
  t          : string;
  BasePtr    : Pointer;
  Element    : IwbElement;
  Flag       : IwbFlag;
begin
  Result := False;

  aResolvedDef := Resolve(aValueDef, aBasePtr, aEndPtr, aElement);

  if Assigned(aResolvedDef) then
  begin
    if wbFlagsAsArray then
      if Supports(aResolvedDef, IwbIntegerDef, IntegerDef) then
        if Supports(IntegerDef.Formater[aElement], IwbFlagsDef, FlagsDef) then begin
          if Assigned(aBasePtr) and (FlagsDef.FlagCount > 0) then begin
            l := Low(aPrevFlags);
            j := IntegerDef.ToInt(aBasePtr, aEndPtr, aContainer);
            if j <> 0 then
              for i := 0 to Pred(FlagsDef.FlagCount) do
                if (j and (Int64(1) shl i)) <> 0 then begin
                  t := FlagsDef.Flags[i, False];
                  if (t <> '') and (not wbHideUnused or not SameText(t,'Unused')) then begin
                    Element := nil;
                    for k := l to High(aPrevFlags) do
                      if Supports(aPrevFlags[k], IwbFlag, Flag) then
                        if Flag.FlagsDef.Equals(FlagsDef) then begin
                          if Flag.FlagIndex = i then begin
                            l := Succ(k);
                            Element := Flag;
                            aPrevFlags[k] := nil;
                            aContainer.AddElement(Element);
                            Break;
                          end else if Flag.FlagIndex < i then
                            l := k
                          else
                            Break;
                        end;
                    if not Assigned(Element) then
                      Element := TwbFlag.Create(aContainer, aBasePtr, aEndPtr, IntegerDef, FlagsDef, i);
                  end;
                  j := j and not (Int64(1) shl i);
                  if j = 0 then
                    Break;
                end;
          end;

          Result := True;

        end;

    aResolvedDef.AfterLoad(aContainer);
  end;

  if wbMoreInfoForUnknown then begin
    var lSkip := False;
    if Assigned(aResolvedDef) then begin
      t := aResolvedDef.Name;
      if aResolvedDef.DefType <> dtByteArray then
        lSkip := True;
    end else
      t := '';
    if t = '' then
      t := aContainer.Def.Name;
    if t.StartsWith('Unknown', True) and (not Assigned(aBasePtr) or (aBasePtr <> aEndPtr)) and not lSkip then
      for i := 0 to 3 do begin
        BasePtr := PByte(aBasePtr) + i;
        var lContainer: IwbContainer := TwbStruct.Create(aContainer, BasePtr, aEndPtr, wbStruct('Offset ' + IntToStr(i), []), '');
        lContainer.Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsU8', wbInteger('AsU8', itU8)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsS8', wbInteger('AsS8', itS8)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsU16', wbInteger('AsU16', itU16)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsS16', wbInteger('AsS16', itS16)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsU32', wbInteger('AsU32', itU32)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsS32', wbInteger('AsS32', itS32)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsS64', wbInteger('AsS64', itS64)), '', True);
        (Element as IwbContainer).Collapsed := tbTrue;
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsFormID', wbInteger('AsFormID', itU32, wbFormID)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsChar4', wbInteger('AsChar4', itU32, wbChar4)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsFloat', wbFloat('AsFloat')), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsString', wbString('AsString')), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsLString', wbLString('AsLString')), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsLenString', wbLenString('AsLenString')), '', True);
        if wbToolSource in [tsSaves] then begin
          BasePtr := PByte(aBasePtr) + i;
          Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray('AsRefID', wbRefID('RefID')), '', True);
          BasePtr := PByte(aBasePtr) + i;
          Element := TwbArray.Create(lContainer, BasePtr, aEndPtr, wbArray(' AsU6to30', wbInteger('AsU6to30', itU6to30)), '', True);
        end;
      end;
  end;

  if assigned(aResolvedDef) then
    i := aResolvedDef.Size[aBasePtr, aEndPtr, aContainer]
  else
    i := High(Integer);
  if i = Cardinal(High(Integer)) then
    aBasePtr := aEndPtr
  else if Assigned(aBasePtr) then
    Inc(PByte(aBasePtr), i);
end;

threadvar
  _PrevFlags : TDynElementInternals;

procedure TwbValue.Init;
var
  BasePtr: Pointer;
begin
  inherited;
  BasePtr := GetDataBasePtr;
  vIsFlags := ValueDoInit(vbValueDef, Self, BasePtr, dcDataEndPtr, Self, _PrevFlags, vResolvedDef);
  _PrevFlags := nil;
end;

function TwbValue.IsFlags: Boolean;
begin
  Result := vIsFlags;
end;

function TwbValue.MastersUpdated(const aOld, aNew: TwbFileIDs; aOldCount, aNewCount: Byte): Boolean;
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  BeginUpdate;
  try
    DoInit(False);

    Result := inherited MastersUpdated(aOld, aNew, aOldCount, aNewCount);

    ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
    if Assigned(ResolvedDef) then
      if ResolvedDef.MastersUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew, aOldCount, aNewCount) then begin
        Result := True;
        SetMastersUpdated(True);
        SetModified(True);
      end;

  finally
    EndUpdate;
  end;
end;

procedure TwbValue.FindUsedMasters(aMasters: PwbUsedMasters);
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);

  inherited FindUsedMasters(aMasters);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.FindUsedMasters(GetDataBasePtr, dcDataEndPtr, Self, aMasters);
end;

function TwbValue.GetAlignable: Boolean;
begin
  Result := False;
end;

function TwbValue.GetElementType: TwbElementType;
begin
  Result := etValue;
end;

function TwbValue.GetResolvedValueDef: IwbValueDef;
begin
  Result := inherited;
  if Assigned(Result) and
     Assigned(vResolvedDef) and
     not vResolvedDef.Equals(Result) and
     (vResolvedDef.DefType <> dtUnion) and
     (Result.DefType <> dtUnion)
  then begin
    var lShouldDataSize := Result.Size[GetDataBasePtr, dcDataEndPtr, Self];
    var lIsDataSize := GetDataSize;

    var lShouldDefType := Result.DefType;
    var lIsDefType := vResolvedDef.DefType;

    var lOldDef := vResolvedDef;
    vResolvedDef := Result;

    if (lShouldDataSize <> lIsDataSize)
       or
       (lShouldDefType <> lIsDefType)
       or
       not vResolvedDef.CanAssign(nil, wbAssignThis, lOldDef)
    then begin
      var lFile := GetFile;
      if not Assigned(lFile) or lFile.IsElementEditable(Self) then
        SetToDefault;
    end else
      Reset;
  end;
end;

function TwbValue.GetSorted: Boolean;
var
  EmptyDef: IwbEmptyDef;
begin
  if wbCompareRawData then
    Exit(False);

  Result := vIsFlags or (Supports(Resolve(vbValueDef, GetDataBasePtr, GetDataEndPtr, Self), IwbEmptyDef, EmptyDef) and EmptyDef.Sorted);
end;

function TwbValue.GetValue: string;
//var
//  i : Integer;
//  j : Int64;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
 {
 if vIsFlags then begin
   Result := '';
   with (vbValueDef as IwbIntegerDef), (Formater as IwbFlagsDef) do begin
     j := ToInt(GetDataBasePtr, dcDataEndPtr, Self);
     for i := 0 to 63 do
       if (j and (Int64(1) shl i)) <> 0 then
         if (i >= FlagCount) or (Flags[i] = '') then
           Result := Result + '<Unknown: ' + IntToStr(i) + '>, ';
   end;
   SetLength(Result, Length(Result) - 2);
 end else}
   Result := inherited GetValue;
end;

procedure TwbValue.Reset;
begin
  vIsFlags := False;
  ReleaseElements;
  inherited;
end;

procedure TwbValue.SetEditValue(const aValue: string);

  procedure RecreateFlags;
  begin
    _PrevFlags := ReleaseElements;
    try
      Reset;
      Init;
    finally
      _PrevFlags := nil;
    end;
  end;

var
  OldValue, NewValue: Variant;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  var lValue := '';
  BeginUpdate;
  try
    if (not Assigned(dcDataBasePtr) or not Assigned(dcDataEndPtr)) or (aValue <> GetEditValue) then begin
      OldValue := GetNativeValue;
      vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
      SetModified(True);
      if vIsFlags and (csInit in cntStates) then begin
        lValue := vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self];
        RecreateFlags;
      end;
      NewValue := GetNativeValue;
      DoAfterSet(OldValue, NewValue);
      NotifyChanged(eContainer);
    end;
  finally
    EndUpdate;
    if vIsFlags and (csInit in cntStates) then begin
      if vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] <> lValue then
        RecreateFlags;
    end;
  end;
end;

procedure TwbValue.SetNativeValue(const aValue: Variant);
var
  OldValue, NewValue: Variant;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  BeginUpdate;
  try
    OldValue := GetNativeValue;
    vbValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
    SetModified(True);
    if vIsFlags and (csInit in cntStates) then begin
      Reset;
      Init;
    end;
    NewValue := GetNativeValue;
    DoAfterSet(OldValue, NewValue);
    NotifyChanged(eContainer);
    if vIsFlags and (csInit in cntStates) then begin
      Reset;
      Init;
    end;
  finally
    EndUpdate;
  end;
end;

procedure wbFileForceClosed;
var
  i: Integer;
begin
  for i := Low(Files) to High(Files) do begin
    (Files[i] as IwbFileInternal).ForceClosed;
    wbProgressCallback;
  end;
  Files := nil;
  FilesMap.Clear;
  _NextFullSlot := 0;
  _NextMediumSlot := 0;
  _NextLightSlot := 0;
end;

function wbFile(const aFileName: string; aLoadOrder: Integer = -1; aCompareTo: string = ''; aStates: TwbFileStates = []; const aData: TBytes = nil): IwbFile;
var
  FileName: string;
  i: Integer;
begin
  wbInitRecords;

  FileName := wbExpandFileName(aFileName);
  {if ExtractFilePath(aFileName) = '' then
    FileName := ExpandFileName('.\' + aFileName)
  else
    FileName := ExpandFileName(aFileName);}

  if FilesMap.Find(FileName, i) then
    Result := IwbFile(Pointer(FilesMap.Objects[i]))
  else begin
    if not wbIsModule(FileName) then
      Result := TwbFileSource.Create(FileName, aLoadOrder, aCompareTo, aStates + [fsAddToMap], aData)
    else
      Result := TwbFile.Create(FileName, aLoadOrder, aCompareTo, aStates + [fsAddToMap], aData);
  end;
end;

function wbMastersForFile(const aFileName: string; aMasters: TStrings; aIsESM, aIsLight, aIsLocalized, aIsOverlay, aIsMedium: PBoolean): Boolean;
var
  FileName : string;
  i        : Integer;
  _File    : IwbFileInternal;
begin
  Result := False;
  if Assigned(aMasters) then
    aMasters.Clear;
  if Assigned(aIsESM) then
    aIsESM^ := False;
  if Assigned(aIsLight) then
    aIsLight^ := False;
  if Assigned(aIsOverlay) then
    aIsOverlay^ := False;
  if Assigned(aIsMedium) then
    aIsMedium^ := False;
  wbProgressLock;
  try
    FileName := wbExpandFileName(aFileName);
    try
      if FilesMap.Find(FileName, i) then
        _File := IwbFile(Pointer(FilesMap.Objects[i])) as IwbFileInternal
      else if not wbIsModule(FileName) then
        _File := TwbFileSource.Create(FileName, -1, '', [fsOnlyHeader], nil)
      else
        _File := TwbFile.Create(FileName, -1, '', [fsOnlyHeader], nil);

      if Assigned(aMasters) then
        _File.GetMasters(aMasters);
      if Assigned(aIsESM) then
        aIsESM^ := _File.IsESM;
      if Assigned(aIsLight) then
        aIsLight^ := _File.IsLight;
      if Assigned(aIsOverlay) then
        aIsOverlay^ := _File.IsOverlay;
      if Assigned(aIsLocalized) then
        aIsLocalized^ := _File.IsLocalized;
      if Assigned(aIsMedium) then
        aIsMedium^ := _File.IsMedium;
      Result := True;
    except
      // File neither found nor replaced, ignore if in xDump
      if not (wbToolMode in [tmDump, tmExport]) then Raise;
    end;
  finally
    wbProgressUnlock;
  end;
end;

function wbMastersForFile(const aFileName: string; out aMasters: TDynStrings; aIsESM, aIsLight, aIsLocalized, aIsOverlay, aIsMedium: PBoolean): Boolean; overload;
var
  sl : TStringList;
begin
  aMasters := nil;
  sl := TStringList.Create;
  try
    Result := wbMastersForFile(aFileName, sl, aIsESM, aIsLight, aIsLocalized, aIsOverlay, aIsMedium);
    if Result then
      aMasters := sl.ToStringArray;
  finally
    sl.Free;
  end;
end;

function wbNewFile(const aFileName: string; aLoadOrder: Integer; aIsLight, aIsMedium: Boolean): IwbFile;
var
  FileName: string;
  i: Integer;
begin
  Assert( not (aIsLight and aIsMedium) );
  Assert( (not aIsLight) or wbIsLightSupported or wbPseudoLight);
  Assert( (not aIsMedium) or wbIsMediumSupported or wbPseudoMedium);

  wbInitRecords;

  FileName := wbExpandFileName(aFileName);
  if FilesMap.Find(FileName, i) then
    raise Exception.Create(FileName + ' exists already')
  else begin
    Result := TwbFile.CreateNew(FileName, aLoadOrder, aIsLight, aIsMedium);
    SetLength(Files, Succ(Length(Files)));
    Files[High(Files)] := Result;
    FilesMap.AddObject(FileName, Pointer(Result));
  end;
end;

function wbNewFile(const aFileName: string; aLoadOrder: Integer; aTemplate: PwbModuleInfo): IwbFile;
var
  FileName: string;
  i: Integer;
begin
  wbInitRecords;

  FileName := wbExpandFileName(aFileName);
  if FilesMap.Find(FileName, i) then
    raise Exception.Create(FileName + ' exists already')
  else begin
    Result := TwbFile.CreateNew(FileName, aLoadOrder, aTemplate);
    SetLength(Files, Succ(Length(Files)));
    Files[High(Files)] := Result;
    FilesMap.AddObject(FileName, Pointer(Result));
  end;
end;

function wbFindWinningMainRecordByEditorID(const aSignature: TwbSignature; const aEditorID: string): IwbMainRecord;
var
  i     : Integer;
  Group : IwbGroupRecord;
begin
  Result := nil;
  for i := High(Files) downto Low(Files) do
    if Supports(Files[i].GroupBySignature[aSignature], IwbGroupRecord, Group) then begin
      Result := Group.MainRecordByEditorID[aEditorID];
      if Assigned(Result) then begin
        Result := Result.WinningOverride;
        Exit;
      end;
    end;
end;

function wbFormListToArray(const aFormList: IwbMainRecord; const aSignatures: string): TDynMainRecords;
var
  Container  : IwbContainerElementRef;
  Signatures : TStringList;
  i, j       : Integer;
  MainRecord : IwbMainRecord;
begin
  Result := nil;
  if not Assigned(aFormList) or (aFormList.Signature <> 'FLST') then
    Exit;
  if not Supports(aFormList.ElementByName['wbFormListToArray FormIDs'], IwbContainerElementRef, Container) then
    Exit;
  if Container.ElementCount < 1 then
    Exit;
  Signatures := TStringList.Create;
  try
    Signatures.CommaText := aSignatures;
    Signatures.Sorted := True;
    for i := 0 to Pred(Container.ElementCount) do begin
      if Supports(Container.Elements[i].LinksTo, IwbMainRecord, MainRecord) then
        if Signatures.Find(MainRecord.Signature, j) then begin
          SetLength(Result, Succ(Length(Result)));
          Result[High(Result)] := MainRecord;
        end;
    end;
  finally
    Signatures.Free;
  end;
end;

function wbGetGameMasterFile: IwbFile;
var
  i     : Integer;
begin
  for i := Low(Files) to High(Files) do
    if fsIsGameMaster in Files[i].FileStates then
      Exit(Files[i]);
  for i := Low(Files) to High(Files) do
    with Files[i].LoadOrderFileID do
      if IsFullSlot and (FullSlot = 0) then
        Exit(Files[i]);
  Result := nil;
end;

{ TwbFlag }

constructor TwbFlag.Create(const aContainer  : IwbContainer;
                                 aBasePtr    : Pointer;
                                 aEndPtr     : Pointer;
                           const aIntegerDef : IwbIntegerDef;
                           const aFlagsDef   : IwbFlagsDef;
                                 aIndex      : Integer);
begin
  fBasePtr    := aBasePtr;
  fEndPtr     := aEndPtr;
  fIntegerDef := aIntegerDef;
  if not fIntegerDef.FormaterCanChange then
    fFlagsDef := aFlagsDef;
  fIndex      := aIndex;
  inherited Create(aContainer);
  SetSortOrder(aIndex);
  SetMemoryOrder(aIndex);
end;

function TwbFlag.GetConflictPriority: TwbConflictPriority;
var
  MainRecord: IwbMainRecord;
begin
  if wbTranslationMode then
    Result := cpIgnore
  else if GetFlagsDef.FlagIgnoreConflict[fIndex] then
    Result := cpIgnore
  else if Assigned(fIntegerDef) then
    Result := fIntegerDef.ConflictPriority[Self]
  else
    Result := cpNormal;

  if Result = cpFormID then begin
    Result := cpCritical;
    MainRecord := GetContainingMainRecord;
    if Assigned(MainRecord) and ((MainRecord.Signature = 'GMST') or (MainRecord.Signature = 'DFOB')) then
      Result := cpBenign;
  end;
end;

function TwbFlag.GetDataSize: Integer;
begin
  Result := 0;
end;

function TwbFlag.GetDef: IwbNamedDef;
begin
  Result := GetFlagsDef.FlagDef[fIndex];
end;

function TwbFlag.GetDontShow: Boolean;
begin
  Result := GetFlagsDef.FlagDontShow[Self, fIndex];
end;

function TwbFlag.GetEditValue: string;
var
  s: string;
begin
  s := GetContainer.EditValue;
  if Length(s) >= Succ(fIndex) then
    Result := s[Succ(fIndex)]
  else
    Result := '0';
end;

function TwbFlag.GetElementType: TwbElementType;
begin
  Result := etFlag;
end;

function TwbFlag.GetFlagIndex: Integer;
begin
  Result := fIndex;
end;

function TwbFlag.GetFlagsDef: IwbFlagsDef;
begin
  if Assigned(fFlagsDef) then
    Result := fFlagsDef
  else
    Result := fIntegerDef.Formater[IwbContainer(eContainer)] as IwbFlagsDef;
end;

function TwbFlag.GetIsEditable: Boolean;
var
  FlagsDef: IwbFlagsDef;
begin
  Result := wbIsInternalEdit or GetContainer.IsEditable;
  FlagsDef := GetFlagsDef;
  if Assigned(FlagsDef) and (dfInternalEditOnly in FlagsDef.DefFlags) then
    if not wbIsInternalEdit then
      Result := False;
end;

function TwbFlag.GetIsRemovable: Boolean;
begin
  Result := wbIsInternalEdit or GetContainer.IsEditable;
end;

function TwbFlag.GetName: string;
begin
  Result := GetFlagsDef.Flags[fIndex, False];
end;

function TwbFlag.GetNativeValue: Variant;
var
  s: string;
begin
  s := GetContainer.EditValue;
  if Length(s) >= Succ(fIndex) then
    Result := s[Succ(fIndex)] = '1'
  else
    Result := False;
end;

function TwbFlag.GetSortKey(aExtended: Boolean): string;

  procedure CheckFlagsChanged;
  var
    FlagsDef     : IwbFlagsDef;
  begin
    FlagsDef := GetFlagsDef.Root as IwbFlagsDef;
    if FlagsDef.DefID <> fLastDefID then begin
      Exclude(eStates, esExtendedSortKeyValid);
      Exclude(eStates, esSortKeyValid);
    end;
  end;

begin
  if not Assigned(fFlagsDef) then
    CheckFlagsChanged;
  Result := inherited GetSortKey(aExtended);
end;

function TwbFlag.GetSortKeyInternal(aExtended: Boolean): string;
var
  s            : string;
  FlagsDef     : IwbFlagsDef;
  BaseFlagsDef : IwbFlagsDef;
begin
  FlagsDef := GetFlagsDef.Root as IwbFlagsDef;
  BaseFlagsDef := FlagsDef.BaseFlagsDef;

  s := IntToHex64(BaseFlagsDef.DefID, 8);
  Result := s + IntToHex64(fIndex, 2);
  if not FlagsDef.Equals(BaseFlagsDef) then begin
    s := FlagsDef.Flags[fIndex, False];
    if not SameText(s, BaseFlagsDef.Flags[fIndex, False]) then
      Result := Result + s;
  end;
  fLastDefID := FlagsDef.DefID;
end;

function TwbFlag.GetSummary: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := GetFlagsDef.Flags[fIndex, True];
end;

function TwbFlag.GetValue: string;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;
  Result := GetFlagsDef.Flags[fIndex, False];
end;

function TwbFlag.GetValueDef: IwbValueDef;
begin
  Result := GetFlagsDef.FlagDef[fIndex];
end;

procedure TwbFlag.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  Size: Cardinal;
begin
  fBasePtr := aBasePtr;
  Size := fIntegerDef.Size[aBasePtr, aEndPtr, GetContainer];
  fEndPtr := PByte(fBasePtr) + Size;
  if NativeUInt(fEndPtr) > NativeUInt(aEndPtr) then
    fEndPtr := aEndPtr;
end;

procedure TwbFlag.InvalidateParentStorage;
begin
  {not inherited}
end;

procedure TwbFlag.Remove;
begin
  SetEditValue('0');
end;

procedure TwbFlag.SetEditValue(const aValue: string);
var
  s: string;
  c: Char;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  if aValue = '1' then
    c := '1'
  else
    c := '0';

  s := GetContainer.EditValue;
  if Length(s) >= Succ(fIndex) then
    s[Succ(fIndex)] := c
  else
    s := s + StringOfChar('0', fIndex - Length(s) ) + c;
  GetContainer.EditValue := s;
end;

procedure TwbFlag.SetNativeValue(const aValue: Variant);
var
  s: string;
  c: Char;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  if aValue = True then
    c := '1'
  else
    c := '0';

  s := GetContainer.EditValue;
  if Length(s) >= Succ(fIndex) then
    s[Succ(fIndex)] := c
  else
    s := s + StringOfChar('0', fIndex - Length(s) ) + c;
  GetContainer.EditValue := s;
end;

{ TwbDataContainer }

procedure TwbDataContainer.AfterConstruction;
var
  Def: IwbDef;
begin
  Def := GetDef;
  if Assigned(Def) and (dfDontSave in Def.DefFlags) then
    Include(dcFlags, dcfDontSave);{
  else begin
    Def := GetValueDef;
    if Assigned(Def) and (dfDontSave in Def.DefFlags) then
      Include(dcFlags, dcfDontSave);
  end;}
  inherited;
end;

function TwbDataContainer.ContentIsAllZero: Boolean;
var
  Run: PByte;
begin
  if (dcfStorageInvalid in dcFlags) then
    UpdateStorageFromElements;
  if Assigned(dcDataBasePtr) and Assigned(dcDataEndPtr) then begin
    Run := dcDataBasePtr;
    while NativeUInt(Run) < NativeUInt(dcDataEndPtr) do begin
      if Run^ <> 0 then
        Exit(False);
      Inc(Run);
    end;
  end;
  Result := True;
end;

procedure TwbDataContainer.CopyFrom(aSource: Pointer; aSize: Integer);
var
  SelfRef : IwbContainerElementRef;
  OldValue, NewValue: Variant;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  SelfRef := Self as IwbContainerElementRef;

  DoInit(False);

  BeginUpdate;
  try
    var lValueDef := GetValueDef;
    if Assigned(lValueDef) then begin
      OldValue := GetNativeValue;

      var lTargetBasePtr := GetDataBasePtr;
      var lTargetEndPtr := GetDataEndPtr;
      RequestStorageChange(lTargetBasePtr, lTargetEndPtr, aSize);
      if aSize > 0 then
      Move(aSource^, lTargetBasePtr^, aSize);

      SetModified(True);
      NewValue := GetNativeValue;

      DoAfterSet(OldValue, NewValue);
    end else
      raise Exception.Create(GetName + ' can not be edited');

    NotifyChanged(eContainer);
  finally
    EndUpdate;
  end;
end;

constructor TwbDataContainer.Create(const aContainer: IwbContainer; var aBasePtr: Pointer; var aEndPtr: Pointer; const aPrevMainRecord : IwbMainRecord);
begin
  dcBasePtr := aBasePtr;
  dcEndPtr := aEndPtr;
  dcDataBasePtr := aBasePtr;
  dcDataEndPtr := aEndPtr;
  inherited Create(aContainer);
  try
    InitDataPtr;
    if Assigned(dcEndPtr) then
      aBasePtr := dcEndPtr
    else
      aBasePtr := dcDataEndPtr;
  except
    if Assigned(aContainer) then
      aContainer.RemoveElement(Self);
    raise;
  end;
end;

function TwbDataContainer.DoCheckSizeAfterWrite: Boolean;
begin
  Result := False;
end;

function TwbDataContainer.GetConflictPriority: TwbConflictPriority;
var
  Def        : IwbDef;
  ValueDef   : IwbValueDef;
  MainRecord : IwbMainRecord;
begin
  Result := cpNormal;

  Def := GetValueDef;

  if not Assigned(Def) then
    Def := GetDef;

  if Supports(Def, IwbValueDef, ValueDef) then
    Def := Resolve(ValueDef, GetDataBasePtr, GetDataEndPtr, Self);

  if Assigned(Def) then
    Result := Def.ConflictPriority[Self];

  if wbTranslationMode then
    if not (dfTranslatable in Def.DefFlags) then
      Result := cpIgnore;

  if Result = cpFormID then begin
    Result := cpCritical;
    MainRecord := GetContainingMainRecord;
    if Assigned(MainRecord) and ((MainRecord.Signature = 'GMST') or (MainRecord.Signature = 'DFOB')) then
      Result := cpBenign;
  end;
end;

function TwbDataContainer.GetDataBasePtr: Pointer;
begin
  if (dcfStorageInvalid in dcFlags) then
    UpdateStorageFromElements;
  Result := dcDataBasePtr;
end;

function TwbDataContainer.GetDataEndPtr: Pointer;
begin
  if (dcfStorageInvalid in dcFlags) then
    UpdateStorageFromElements;
  Result := dcDataEndPtr;
end;

function TwbDataContainer.GetDataSize: Integer;
begin
  if (dcfStorageInvalid in dcFlags) or not Assigned(dcDataBasePtr) or not Assigned(dcDataEndPtr) then
    Result := inherited GetDataSize + GetDataPrefixSize
  else
    Result := NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr);
end;

function TwbDataContainer.GetDontCompare: Boolean;
begin
  Result := (dcfDontCompare in dcFlags);
end;

function TwbDataContainer.GetDontSave: Boolean;
begin
  Result := (dcfDontSave in dcFlags);
end;

function TwbDataContainer.GetEditInfo: TArray<string>;
var
  ValueDef: IwbValueDef;
begin
  Result := nil;
  if Supports(GetValueDef, IwbValueDef, ValueDef) then
    Result := ValueDef.EditInfo[GetDataBasePtr, dcDataEndPtr, Self];
end;

function TwbDataContainer.GetEditType: TwbEditType;
var
  ValueDef: IwbValueDef;
begin
  Result := etDefault;
  if Supports(GetValueDef, IwbValueDef, ValueDef) then
    Result := ValueDef.EditType[GetDataBasePtr, dcDataEndPtr, Self];
end;

function TwbDataContainer.GetRawDataAsString: string;
const
  HexDigits: PChar = '0123456789ABCDEF';
begin
  Result := '';
  var lData: PByte := GetDataBasePtr;
  if not Assigned(lData) then
    Exit;

  var lDataSize := NativeInt(dcDataEndPtr) - NativeInt(lData);
  if lDataSize < 1 then
    Exit;

  Result := StringOfChar(' ', Pred(lDataSize*3));
  var pResult := PChar(Result);
  for var lByteIdx := 0 to Pred(lDataSize) do begin
    var lByte := lData[lByteIdx];
    pResult[     lByteIdx * 3 ] := HexDigits[lByte shr 4];
    pResult[Succ(lByteIdx * 3)] := HexDigits[lByte and $0F];
  end;
end;

function TwbDataContainer.GetResolvedValueDef: IwbValueDef;
begin
  var lValueDef := GetValueDef;
  Exit(Resolve(lValueDef, GetDataBasePtr, dcDataEndPtr, Self));
{
  if Supports(lValueDef, IwbResolvableDef) then
    Exit(Resolve(lValueDef, GetDataBasePtr, dcDataEndPtr, Self));

  var lSortOrder := GetSortOrder;
  if lSortOrder >= 0 then begin
    var lContainer: IwbContainerElementRef;
    if Supports(GetContainer, IwbContainerElementRef, lContainer) then begin
      var lContainerValueDef := lContainer.ResolvedValueDef;
      var lStructDef: IwbStructDef;
      if Supports(lContainerValueDef, IwbStructDef, lStructDef) then begin
        if lSortOrder <= lStructDef.MemberCount then begin
          var lMemberValueDef := lStructDef.Members[lSortOrder];
          if Supports(lMemberValueDef, IwbResolvableDef) then
            Exit(Resolve(lMemberValueDef, GetDataBasePtr, dcDataEndPtr, Self));
        end;
      end;
    end;
  end;

  Result := lValueDef;}
end;

function TwbDataContainer.GetDataPrefixSize: Integer;
begin
  Result := 0;
end;

procedure TwbDataContainer.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SizeNeeded    : Cardinal;
  SizeAvailable : Cardinal;
  BasePtr       : Pointer;
begin
  if [dcfDontMerge, dcfDontCompare] * dcFlags <> [] then
    Exit;

  if Length(dcDataStorage) <> 0 then
    Assert(Length(dcDataStorage) = 0);
  SizeNeeded := GetDataSize;
  if SizeNeeded > 0 then begin
    SizeAvailable := NativeUInt(aEndPtr) - NativeUInt(aBasePtr);
    if (SizeAvailable < SizeNeeded) then
      Assert( SizeAvailable >= SizeNeeded );

    BasePtr := aBasePtr;
    Inc(PByte(aBasePtr), GetDataPrefixSize);
    inherited;

    if BasePtr = aBasePtr then begin
      if not (dcfDontMerge in dcFlags) then
        Inc(PByte(aBasePtr), SizeNeeded);
    end else
      if NativeUInt(aBasePtr) - NativeUInt(BasePtr) > SizeNeeded then // we overwrote something
        Assert( NativeUInt(aBasePtr) - NativeUInt(BasePtr) = SizeNeeded )
      else // Adjust size of data not initialized yet
        aBasePtr := PByte(BasePtr) + SizeNeeded;

    dcDataBasePtr := BasePtr;
    dcDataEndPtr := aBasePtr;
  end;
end;

procedure TwbDataContainer.InvalidateStorage;
begin
  Include(dcFlags, dcfStorageInvalid);
  inherited InvalidateStorage;
end;

function TwbDataContainer.IsFlags: Boolean;
begin
  Result := False;
end;

function TwbDataContainer.IsValidOffset(aBasePtr, aEndPtr: Pointer; anOffset: Integer): Boolean;
begin
  Result := False;
  if anOffset >= 0 then
    if NativeUInt(aBasePtr) >= NativeUInt(dcBasePtr) then
      if NativeUInt(aBasePtr) < NativeUInt(dcEndPtr) then
        if NativeUInt(aEndPtr) > NativeUInt(dcBasePtr) then
          if NativeUInt(aEndPtr) <= NativeUInt(dcEndPtr) then
            if NativeUInt(aBasePtr) + NativeUInt(anOffset) < NativeUInt(dcEndPtr) then
              Result := True;
end;

function TwbDataContainer.IsLocalOffset(anOffset: Integer): Boolean;
begin
  if (anOffset >= 0) and (NativeUInt(dcDataBasePtr) + NativeUInt(anOffset) < NativeUInt(dcDataEndPtr)) then
    Result := True
  else
    Result := False;
end;

procedure TwbDataContainer.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SizeNeeded    : NativeUInt;
  SizeAvailable : NativeUInt;
  BasePtr       : Pointer;
  PrefixSize   : Integer;
begin
  if [dcfDontMerge, dcfDontCompare] * dcFlags <> [] then
    Exit;

  if (dcfStorageInvalid in dcFlags) then begin
    BasePtr := aBasePtr;
    PrefixSize := GetDataPrefixSize;
    if (PrefixSize > 0) then begin
      Move(dcDataBasePtr^, aBasePtr^, PrefixSize);
      Inc(PByte(aBasePtr), PrefixSize);
    end;
    inherited;
    dcDataBasePtr := BasePtr;
    dcDataEndPtr := aBasePtr;
  end else begin
    SizeNeeded := NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr);
    if SizeNeeded > 0 then begin
      SizeAvailable := NativeUInt(aEndPtr) - NativeUInt(aBasePtr);
      if SizeAvailable < SizeNeeded then
        Assert( SizeAvailable >= SizeNeeded );

      Move(dcDataBasePtr^, aBasePtr^, SizeNeeded);

      dcDataBasePtr := aBasePtr;
      Inc(PByte(aBasePtr), SizeNeeded);
      dcDataEndPtr := aBasePtr;

      BasePtr := dcDataBasePtr;
      Inc(PByte(BasePtr), GetDataPrefixSize);
      inherited InformStorage(BasePtr, dcDataEndPtr);
    end else begin
      dcDataBasePtr := nil;
      dcDataEndPtr := nil;
    end;
    dcDataStorage := nil;
  end;
end;

procedure TwbDataContainer.RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal);
var
  BasePtr   : Pointer;
  OldSize   : NativeUInt;
  NeedsCopy : Boolean;
begin
  if (dcfStorageInvalid in dcFlags) then
    UpdateStorageFromElements;

  SetModified(True);
  InvalidateParentStorage;
  if aNewSize = 0 then begin
    dcDataStorage := nil;
    dcDataBasePtr := @EmptyPtr;
    dcDataEndPtr := @EmptyPtr;
  end else if Cardinal(Length(dcDataStorage)) <> aNewSize then begin
    OldSize := NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr);
    NeedsCopy := (Length(dcDataStorage) = 0) and (OldSize > 0);
    SetLength(dcDataStorage, aNewSize);
    if NeedsCopy then
      Move(dcDataBasePtr^, dcDataStorage[0], Min(OldSize, aNewSize));
    dcDataBasePtr := @dcDataStorage[0];
    dcDataEndPtr := PByte(dcDataBasePtr) + aNewSize;

    BasePtr := dcDataBasePtr;
    Inc(PByte(BasePtr), GetDataPrefixSize);
    inherited InformStorage(BasePtr, dcDataEndPtr);
  end;
  Exclude(dcFlags, dcfStorageInvalid);
  aBasePtr := dcDataBasePtr;
  aEndPtr := dcDataEndPtr;
end;

procedure TwbDataContainer.SetContainer(const aContainer: IwbContainer);
var
  DataContainer: IwbDataContainer;
begin
  if not (dcfDontCompare in dcFlags) then
    if Supports(aContainer, IwbDataContainer, DataContainer) and DataContainer.DontCompare then
      Include(dcFlags, dcfDontCompare);
  inherited;
end;

procedure TwbDataContainer.SetDataSize(aSize: Integer);
var
  BasePtr, EndPtr: Pointer;
begin
  if aSize = GetDataSize then
    Exit;

  BasePtr := nil;
  EndPtr := nil;
  RequestStorageChange(BasePtr, EndPtr, aSize);
  if csInit in cntStates then begin
    Reset;
    Init;
  end;
end;

procedure TwbDataContainer.SetModified(aValue: Boolean);
begin
  inherited SetModified(aValue);
end;

procedure TwbDataContainer.SetToDefaultInternal;
var
  SelfRef            : IwbContainerElementRef;
  ValueDef           : IwbValueDef;
  OldValue, NewValue : Variant;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  ValueDef := GetValueDef;
  if Assigned(ValueDef) then begin
    OldValue := GetNativeValue;
    if ValueDef.SetToDefault(GetDataBasePtr, GetDataEndPtr, Self) then begin
      SetModified(True);
      NewValue := GetNativeValue;
      DoAfterSet(OldValue, NewValue);
      NotifyChanged(eContainer);

      if IsFlags and (csInit in cntStates) then begin
        Reset;
        Init;
      end;
    end
  end;

  inherited;
end;

procedure TwbDataContainer.UpdateStorageFromElements;
var
  PrefixSize            : Integer;
  NewStorage            : TBytes;
  BasePtr               : Pointer;
  EndPtr                : Pointer;
  SelfRef               : IwbContainerElementRef;
  i                     : Integer;
  DataContainerInternal : IwbDataContainerInternal;
begin
  if not (dcfStorageInvalid in dcFlags) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbDataContainerInternal, DataContainerInternal) then
      DataContainerInternal.UpdateStorageFromElements;

  SetLength(NewStorage, inherited GetDataSize + GetDataPrefixSize);
  if Length(NewStorage) > 0 then begin
    BasePtr := @NewStorage[0];
    EndPtr := PByte(BasePtr) + Length(NewStorage);
    PrefixSize := GetDataPrefixSize;
    if (PrefixSize > 0) then
      Move(dcDataBasePtr^, BasePtr^, PrefixSize);
    Inc(PByte(BasePtr), PrefixSize);
    inherited MergeStorageInternal(BasePtr, EndPtr);

    dcDataStorage := NewStorage;
    dcDataBasePtr := @NewStorage[0];
    dcDataEndPtr := PByte(dcDataBasePtr) + Length(dcDataStorage);
    Assert(dcDataEndPtr = EndPtr);
  end else begin
    dcDataStorage := nil;
    dcDataBasePtr := nil;
    dcDataEndPtr := nil;
  end;

  Exclude(dcFlags, dcfStorageInvalid);
end;

procedure TwbDataContainer.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
var
  OldPosition  : Int64;
  Size         : NativeUInt;
  ExpectedSize : NativeUInt;
  NeedReset    : Boolean;
begin
  if [dcfDontSave, dcfDontCompare] * dcFlags <> [] then begin
    ResetModified(aResetModified);
    Exit;
  end;

  OldPosition := aStream.Position;
  ExpectedSize := GetDataSize;
  NeedReset := True;

  if (esModified in eStates) or wbTestWrite then begin
    if not (dcfStorageInvalid in dcFlags) and Assigned(dcDataEndPtr) and Assigned(dcDataBasePtr) then
      Size := NativeUInt(dcDataEndPtr ) - NativeUInt(dcDataBasePtr)
    else
      Size := 0;
    if Size > 0 then begin
      if Size <> ExpectedSize then
        Assert(Size = ExpectedSize);
      aStream.WriteBuffer(dcDataBasePtr^, Size);
    end else begin
      inherited WriteToStreamInternal(aStream, aResetModified);
      NeedReset := False;
      if aStream.Position = OldPosition then begin
        Size := GetDataSize;
        if Size > 0 then
          aStream.WriteBuffer(GetDataBasePtr^, Size);
      end;
    end;
  end else begin
    Size := ExpectedSize;
    if Size > 0 then
      aStream.WriteBuffer(GetDataBasePtr^, Size);
  end;

  if (aStream.Position - OldPosition) <> ExpectedSize then
    if DoCheckSizeAfterWrite then
      Assert(False, '[TwbDataContainer.WriteToStreamInternal] (aStream.Position - OldPosition) <> ExpectedSize');

  if NeedReset then
    // didn't call inherited WriteToStreamInternal, need to reset all elements
    ResetModified(aResetModified)
  else begin
    // elements already reset by call to inherited WriteToStreamInternal
    Exclude(eStates, esUnsaved);
    case aResetModified of
      rmYes: begin
        Exclude(eStates, esModified);
        Exclude(eStates, esInternalModified);
      end;
      rmSetInternal:
        if esModified in eStates then
          Include(eStates, esInternalModified);
    end;
  end;
end;

{ TwbValueBase }

procedure TwbValueBase.BuildRef;
var
  SelfRef: IwbElement;
begin
  var lDef := GetDef;
  if Assigned(lDef) and (dfExcludeFromBuildRef in lDef.DefFlags) then
    Exit;

  var lValueDef := GetValueDef;
  if Assigned(lValueDef) and (dfExcludeFromBuildRef in lValueDef.DefFlags) then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  inherited;
  vbValueDef.BuildRef(GetDataBasePtr, dcDataEndPtr, Self);
end;

constructor TwbValueBase.Create(const aContainer  : IwbContainer;
                                  var aBasePtr    : Pointer;
                                      aEndPtr     : Pointer;
                                const aValueDef   : IwbValueDef;
                                const aNameSuffix : string;
                                      aDontCompare: Boolean);
begin
  if aDontCompare then
    Include(dcFlags, dcfDontCompare);
  vbValueDef := aValueDef;
  eNameSuffix := aNameSuffix;
  inherited Create(aContainer, aBasePtr, aEndPtr, nil);
end;

function TwbValueBase.CanContainFormIDs: Boolean;
begin
  Result := dfCanContainFormID in vbValueDef.DefFlags;
end;

function TwbValueBase.CanElementReset: Boolean;
begin
//  Result := inherited CanElementReset;
  Result := eExternalRefs < 1;
end;

constructor TwbValueBase.Create(const aContainer  : IwbContainer;
                                const aValueDef   : IwbValueDef;
                                const aSource     : IwbElement;
                                const aOnlySK     : Boolean;
                                const aNameSuffix : string);
var
  BasePtr : Pointer;
  EndPtr  : Pointer;
begin
  BasePtr := nil;
  Create(aContainer, BasePtr, nil, aValueDef, aNameSuffix);
  if Assigned(aSource) then try
    RequestStorageChange(BasePtr, EndPtr, GetDataSize);
    SetToDefault;
    Assign(wbAssignThis, aSource, aOnlySK);
    SetModified(True);
  except
    if Assigned(aContainer) then
      aContainer.RemoveElement(Self);
    raise;
  end else begin
    BasePtr := nil;
    EndPtr := nil;
    SetModified(True);
    RequestStorageChange(BasePtr, EndPtr, GetDataSize);
    SetToDefault;
  end;
end;

function TwbValueBase.DoCheckSizeAfterWrite: Boolean;
begin
  Result := True;
end;

function TwbValueBase.GetBaseName: string;
begin
  Result := vbValueDef.Name;
end;

function TwbValueBase.GetCheck: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Result := vbValueDef.Check(GetDataBasePtr, dcDataEndPtr, Self);
end;

function TwbValueBase.GetDataSize: Integer;
begin
  if not Assigned(dcDataBasePtr) and not (dcfStorageInvalid in dcFlags) then
    Result := vbValueDef.DefaultSize[nil, nil, Self]
  else
    Result := inherited GetDataSize;
end;

function TwbValueBase.GetDef: IwbNamedDef;
begin
  Result := vbValueDef;
end;

function TwbValueBase.GetDisplayName(aUseSuffix: Boolean): string;
var
  Resolved: IwbValueDef;
  Container: IwbDataContainer;
begin
  Resolved := Resolve(vbValueDef, GetDataBasePtr, GetDataEndPtr, Self);
  if (not Assigned(Resolved)) or (Resolved <> vbValueDef) and (Resolved.DefType in dtNonValues) then
    Result := vbValueDef.Name
  else
    Result := Resolved.Name;
  if Assigned(Resolved) then
  begin
    if (Resolved.DefType in dtNonValues) and (wbDumpOffset=1) then // simply display starting offset.
      if wbBaseOffset <= NativeUInt(GetDataBasePtr) then
        Result := Result + ' {' + IntToStr(NativeUInt(GetDataBasePtr) - wbBaseOffset) + '}'
      else
        Result := Result + ' {{' + IntToStr(NativeUInt(GetDataBasePtr)) + '}}';
    // something for Dump: Displaying the size in {} and the array count in []
    //  Triggers a lot of pre calculations
    if (Resolved.DefType in dtNonValues) and (wbDumpOffset>2) then
      if wbBaseOffset <= NativeUInt(GetDataBasePtr) then
        Result := Result + ' {' + IntToStr(NativeUInt(GetDataEndPtr) - wbBaseOffset) +
          '-' + IntToStr(NativeUInt(GetDataBasePtr) - wbBaseOffset) +
          ' = ' + IntToStr(Resolved.Size[GetDataBasePtr, GetDataEndPtr, Self]) + '}'
      else
        Result := Result + ' {{' + IntToStr(NativeUInt(GetDataEndPtr)) +
          '-' + IntToStr(NativeUInt(GetDataBasePtr)) +
          ' = ' + IntToStr(Resolved.Size[GetDataBasePtr, GetDataEndPtr, Self]) + '}}';
    if (Resolved.DefType = dtArray) and (wbDumpOffset>1) and Supports(Self, IwbDataContainer, Container) then
      Result := Result + ' [' + IntToStr(Container.GetElementCount) + ']';
  end;
  if aUseSuffix and (GetNameSuffix <> '') then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + eNameSuffix;
  end;
end;

function TwbValueBase.GetEditValue: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Result := vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self]
end;

function TwbValueBase.GetIsEditable: Boolean;
var
  SelfRef : IwbContainerElementRef;
begin
  Result := wbIsInternalEdit;
  if Result then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(SelfRef) then
    Exit;

  DoInit(False);
  Result := vbValueDef.IsEditable[GetDataBasePtr, dcDataEndPtr, Self];
end;

function TwbValueBase.GetIsInSK(aIndex: Integer): Boolean;
var
  SelfRef    : IwbContainerElementRef;
  HasSortKey : IwbHasSortKeyDef;
begin
  Result := False;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);

  if not Supports(vbValueDef, IwbHasSortKeyDef, HasSortKey) then
    Exit;

  Result := HasSortKey.IsInSK(aIndex);
end;

function TwbValueBase.InternalGetLinksTo: IwbElement;
var
  SelfRef: IwbContainerElementRef;
begin
  Result := nil;
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  if not Assigned(vbValueDef) then
    Exit;
  Result := vbValueDef.LinksTo[dcDataBasePtr, dcDataEndPtr, Self];
end;

function TwbValueBase.GetName: string;
begin
  Result := vbValueDef.Name;
  if GetNameSuffix <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + eNameSuffix;
  end;
end;

function TwbValueBase.GetNativeValue: Variant;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit(False);
  Result := vbValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self]
end;

function TwbValueBase.GetSortKeyInternal(aExtended: Boolean): string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  if (dcfDontCompare in dcFlags) then
    Result := ''
  else begin
    DoInit(True);
    Result := vbValueDef.ToSortKey(GetDataBasePtr, dcDataEndPtr, Self, aExtended);
  end;
end;

function TwbValueBase.GetSummary: string;
var
  SelfRef : IwbContainerElementRef;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  eSummaryLinksTo := nil;
  Result := vbValueDef.ToSummary(0, GetDataBasePtr, dcDataEndPtr, Self, eSummaryLinksTo);
end;

function TwbValueBase.GetValue: string;
var
  SelfRef : IwbContainerElementRef;
var
  Def: IwbDef;
begin
  if wbReportMode then begin
    Def := GetValueDef;
    if Assigned(Def) then
      Def.Used;
    Def := GetDef;
    if Assigned(Def) then
      Def.Used;
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);
  Result := vbValueDef.ToString(GetDataBasePtr, dcDataEndPtr, Self);

  if wbShowDataSizeInValue then
    Result := Result + ' {DataSize: ' + GetDataSize.ToString + '}';
end;

function TwbValueBase.GetValueDef: IwbValueDef;
//var
//  SelfRef: IwbContainerElementRef;
begin
//  SelfRef := Self as IwbContainerElementRef;
//  DoInit;

  Result := vbValueDef;
end;

procedure TwbValueBase.InitDataPtr;
var
  Size : Integer;
begin
  if (GetDataBasePtr <> nil) and (NativeUInt(dcDataEndPtr) >= NativeUInt(dcDataBasePtr)) then begin
    Size := vbValueDef.Size[dcDataBasePtr, dcDataEndPtr, Self];
    if Size < High(Integer) then begin
      dcDataEndPtr := PByte(dcDataBasePtr) + Size;
      if NativeUInt(dcDataEndPtr) > NativeUInt(dcEndPtr) then
        dcDataEndPtr := dcEndPtr
      else
        dcEndPtr := dcDataEndPtr;
    end;
  end;
end;

procedure TwbValueBase.SetEditValue(const aValue: string);
var
  OldValue, NewValue: Variant;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  BeginUpdate;
  try
    if aValue <> GetEditValue then begin
      OldValue := GetNativeValue;
      vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
      SetModified(True);
      NewValue := GetNativeValue;
      DoAfterSet(OldValue, NewValue);
      NotifyChanged(eContainer);
    end;
  finally
    EndUpdate;
  end;
end;


procedure TwbValueBase.SetLinksTo(const aValue: IwbElement);
var
  OldValue, NewValue: Variant;
  OldLinksTo: IwbElement;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  BeginUpdate;
  try
    OldLinksTo := vbValueDef.LinksTo[dcDataBasePtr, dcDataEndPtr, Self];
    if (OldLinksTo <> aValue) and (not Assigned(OldLinksTo) or not OldLinksTo.Equals(aValue)) then begin
      if Assigned(vbValueDef) then begin
        OldValue := GetNativeValue;
        vbValueDef.LinksTo[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
        SetModified(True);
        NewValue := GetNativeValue;
        DoAfterSet(OldValue, NewValue);
      end else
        raise Exception.Create(GetName + ' can not be edited');
      NotifyChanged(eContainer);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TwbValueBase.SetNativeValue(const aValue: Variant);
var
  OldValue, NewValue: Variant;
begin
  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be edited.');
  end;

  BeginUpdate;
  try
    OldValue := GetNativeValue;
    vbValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
    SetModified(True);
    NewValue := GetNativeValue;
    DoAfterSet(OldValue, NewValue);
    NotifyChanged(eContainer);
  finally
    EndUpdate;
  end;
end;

procedure TwbValueBase.SetToDefaultInternal;
var
  SelfRef: IwbContainerElementRef;
  BasePtr, EndPtr: Pointer;
begin
  SelfRef := Self as IwbContainerElementRef;

  if csInit in cntStates then
    DoReset(True);
  BasePtr := nil;
  EndPtr := nil;
  dcDataBasePtr := nil;
  dcDataEndPtr := nil;
  dcDataStorage := nil;
  DoInit(True);
  RequestStorageChange(BasePtr, EndPtr, vbValueDef.DefaultSize[nil, nil, Self]{ + GetDataPrefixSize});
  inherited;
end;

{ TwbRecordHeaderStruct }

function TwbRecordHeaderStruct.AddIfMissingInternal(const aElement        : IwbElement;
                                                          aAsNew          : Boolean;
                                                          aDeepCopy       : Boolean;
                                                    const aPrefixRemove   : string;
                                                    const aSuffixRemove   : string;
                                                    const aPrefix         : string;
                                                    const aSuffix         : string;
                                                          aAllowOverwrite : Boolean)
                                                                          : IwbElement;
var
  StructDef : IwbStructDef;
  SelfRef   : IwbContainerElementRef;
begin
  Result := nil;

  if not wbIsInternalEdit then begin
    if not wbEditAllowed then
      raise Exception.Create(GetName + ' can not be assigned.');
  end;

  SelfRef := Self as IwbContainerElementRef;
  DoInit(True);

  if not Supports(GetDef, IwbStructDef, StructDef) then
    Exit;

  Assert(aElement.SortOrder >= 0);
  Assert(aElement.SortOrder < StructDef.MemberCount);
  Assert(Assigned(aElement.Def));
  Assert(aElement.Def.Equals(StructDef.Members[aElement.SortOrder]));

  Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
  Assert(Assigned(Result));
  Result.Assign(wbAssignThis, aElement, not aDeepCopy);
end;

procedure TwbRecordHeaderStruct.BuildRef;
begin
end;

function TwbRecordHeaderStruct.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

function TwbRecordHeaderStruct.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
begin
  Result := False;
end;

procedure TwbRecordHeaderStruct.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
var
  MainRecordInternal       : IwbMainRecordInternal;
  DataContainer            : IwbDataContainer;
  Flags                    : TwbMainRecordStructFlags;
  p                        : Pointer;
begin
  var ToggleDeleted := False;
  var TogglePartialForm := False;
  var TogglePersistent := False;
  var ToggleVisibleWhenDistant := False;

  if Supports(IInterface(eContainer) , IwbMainRecordInternal, MainRecordInternal) then begin
    if SameText(aElement.Def.Name, 'Record Flags') then begin
      if Supports(aElement, IwbDataContainer, DataContainer) then begin
        Flags._Flags := PCardinal(DataContainer.DataBasePtr)^;
        UpdateStorageFromElements;
        dcDataStorage := nil;
        Exclude(dcFlags, dcfStorageInvalid);
        MainRecordInternal.MakeHeaderWriteable;

        if Flags.IsESM then
          if MainRecordInternal.Signature <> wbHeaderSignature then
            Flags.SetESM(False);

        if Flags.IsDeleted <> MainRecordInternal.mrStruct.mrsFlags.IsDeleted then begin
          Flags.SetDeleted(MainRecordInternal.mrStruct.mrsFlags.IsDeleted);
          ToggleDeleted := True;
        end;

        if Flags.IsPartialForm <> MainRecordInternal.mrStruct.mrsFlags.IsPartialForm then begin
          Flags.SetPartialForm(MainRecordInternal.mrStruct.mrsFlags.IsPartialForm);
          TogglePartialForm := True;
        end;

        if Flags.IsPersistent <> MainRecordInternal.mrStruct.mrsFlags.IsPersistent then begin
          Flags.SetPersistent(MainRecordInternal.mrStruct.mrsFlags.IsPersistent);
          TogglePersistent := True;
        end;

        if Flags.IsVisibleWhenDistant <> MainRecordInternal.mrStruct.mrsFlags.IsVisibleWhenDistant then begin
          Flags.SetVisibleWhenDistant(MainRecordInternal.mrStruct.mrsFlags.IsVisibleWhenDistant);
          ToggleVisibleWhenDistant := True;
        end;

        MainRecordInternal.mrStruct.mrsFlags^ := Flags;
      end;
    end;
    p := MainRecordInternal.mrStruct;
    InformStorage(p, PByte(p) + wbSizeOfMainRecordStruct);

    with MainRecordInternal do begin
      if ToggleDeleted then
        IsDeleted := not IsDeleted;
      if TogglePartialForm then
        IsPartialForm := not IsPartialForm;

      if not IsDeleted then begin
        if TogglePersistent then
          IsPersistent := not IsPersistent;
        if ToggleVisibleWhenDistant then
          IsVisibleWhenDistant := not IsVisibleWhenDistant;
      end;
    end;
  end;

  inherited;
end;

function TwbRecordHeaderStruct.GetIsEditable: Boolean;
begin
  Result := wbIsInternalEdit;
end;

function TwbRecordHeaderStruct.IsElementEditable(const aElement: IwbElement): Boolean;
begin
  Result := Assigned(aElement) and Assigned(aElement.ValueDef) and
    SameText(aElement.ValueDef.Name, 'Record Flags');
  if Result and Assigned(eContainer) then
    Result := IwbContainer(eContainer).IsElementEditable(Self);
end;

{ TwbStringListTerminator }

function TwbStringListTerminator.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
begin
  Result := nil;
end;

function TwbStringListTerminator.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
begin
  Result := False;
  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  Result := Supports(aElement, IwbStringListTerminator);
end;

function TwbStringListTerminator.GetConflictPriority: TwbConflictPriority;
begin
  Result := cpIgnore;
end;

function TwbStringListTerminator.GetDataSize: Integer;
begin
  Result := 1;
end;

function TwbStringListTerminator.GetDontShow: Boolean;
begin
  Result := wbHideNeverShow;
end;

function TwbStringListTerminator.GetElementType: TwbElementType;
begin
  Result := etStringListTerminator;
end;

function TwbStringListTerminator.GetName: string;
begin
  Result := 'Terminator';
end;

function TwbStringListTerminator.GetSortKeyInternal(aExtended: Boolean): string;
begin
  Result := #255;
end;

procedure TwbStringListTerminator.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  Assert( NativeUInt(aBasePtr) < NativeUInt(aEndPtr) );
  Inc(PByte(aBasePtr));
end;

procedure TwbStringListTerminator.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  Assert( NativeUInt(aBasePtr) < NativeUInt(aEndPtr) );
  PAnsiChar(aBasePtr)^ := #0;
  Inc(PByte(aBasePtr));
end;

procedure TwbStringListTerminator.SetEditValue(const aValue: string);
begin
end;

procedure TwbStringListTerminator.SetNativeValue(const aValue: Variant);
begin
end;

procedure TwbStringListTerminator.WriteToStreamInternal(aStream: TStream; aResetModified: TwbResetModified);
const
  NullChar : AnsiChar = #0;
begin
  aStream.Write(NullChar, 1);
  Exclude(eStates, esUnsaved);
  case aResetModified of
    rmYes: begin
      Exclude(eStates, esModified);
      Exclude(eStates, esInternalModified);
    end;
    rmSetInternal:
      if esModified in eStates then
        Include(eStates, esInternalModified);
  end;
end;

procedure WriteSubRecordOrderList;
var
  i: Integer;
begin
  if not wbReportMode then
    Exit;

  SubRecordOrderList.Sorted := False;

  for i := 0 to Pred(SubRecordOrderList.Count) do
    SubRecordOrderList[i] := SubRecordOrderList[i] + ' (' + IntToStr(Integer(SubRecordOrderList.Objects[i]) ) + ')';

  SubRecordOrderList.SaveToFile('SubRecordOrderList.txt');
end;

var
  wbContainedInDef : array[0..10] of IwbIntegerDef;

{ TwbContainedInElement }

procedure TwbContainedInElement.BuildRef;
begin
end;

function TwbContainedInElement.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

function TwbContainedInElement.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
begin
  Result := False;
end;

procedure TwbContainedInElement.ContainerChanged;
var
  MainRecord     : IwbMainRecord;
  GroupRecord    : IwbGroupRecord;
  Grp            : TwbGroupTypes;
begin
  if cieLockCount > 0 then
    Exit;

  if not Supports(GetContainer, IwbMainRecord, MainRecord) then
    Exit;
  if not Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
    Exit;
  if GroupRecord.GroupType = 5 then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Exit;
  if GroupRecord.GroupType = 4 then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Exit;

  if wbVWDAsQuestChildren then
    Grp := [8..9]
  else
    Grp := [8..10];

  if GroupRecord.GroupType in Grp then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Exit;

  if wbVWDAsQuestChildren then
    Grp := [1, 6, 7, 10]
  else
    Grp := [1, 6, 7];

  if not (GroupRecord.GroupType in Grp) then
    Exit;

  PCardinal(GetDataBasePtr)^ := GroupRecord.GroupLabel;
  Exclude(eStates, esSortKeyValid);
  Exclude(eStates, esExtendedSortKeyValid);
  eSortKey := '';
  eExtendedSortKey := '';
end;

constructor TwbContainedInElement.Create(const aMainRecord: IwbMainRecord);
var
  BasePtr        : Pointer;
  EndPtr         : Pointer;
  GroupRecord    : IwbGroupRecord;
  Grp            : TwbGroupTypes;
begin
  // MainRecord must be in a group
  if not Supports(aMainRecord.Container, IwbGroupRecord, GroupRecord) then
    Assert(False);
  // if that group is Exterior Sub-Block, then it must be in a group too, get it
  if GroupRecord.GroupType = 5 then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Assert(False);
  // if that group is Exterior Block, then it must be in a group too, get it
  if GroupRecord.GroupType = 4 then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Assert(False);
  // if group is persistent, temporary or vwd cell children, it should be in a group too
  // if vwd is treated as quest children, then exclude it from check
  if wbVWDAsQuestChildren then Grp := [8..9] else Grp := [8..10];
  if GroupRecord.GroupType in Grp then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Assert(False);

  // the final list of parent groups, mainrecords in those will have ContainedIn element
  if wbVWDAsQuestChildren then Grp := [1, 6, 7, 10] else Grp := [1, 6, 7];
  Assert(GroupRecord.GroupType in Grp);

  Include(dcFlags, dcfDontMerge);
  Include(dcFlags, dcfDontSave);

  BasePtr := nil;
  EndPtr := nil;
  inherited Create(aMainRecord, BasePtr, EndPtr, wbContainedInDef[GroupRecord.GroupType], '', False);

  SetSortOrder(-2);

  BasePtr := nil;
  EndPtr := nil;

  RequestStorageChange(BasePtr, EndPtr, GetDataSize);
  Assert(Assigned(BasePtr));

  PCardinal(BasePtr)^ := GroupRecord.GroupLabel;
end;

procedure TwbContainedInElement.DoAfterSet(const aOldValue, aNewValue: Variant);
var
  OldFormID   : TwbFormID;
  NewFormID   : TwbFormID;
  _File       : IwbFile;
  MainRecord  : IwbMainRecord;
  NewOwner    : IwbMainRecord;
  GroupRecord : IwbGroupRecord;
  OldGroup    : IwbGroupRecord;

  Group1       : IwbGroupRecord;
  Group2       : IwbGroupRecord;
  Group3       : IwbGroupRecord;
  CorrectGroup : Integer;
  i            : Integer;
begin
  Inc(cieLockCount);
  try
    inherited;
    if aOldValue <> aNewValue then begin
      OldFormID := TwbFormID.FromVar(aOldValue);
      NewFormID := TwbFormID.FromVar(aNewValue);
      _File := GetFile;
      MainRecord := GetContainer as IwbMainRecord;
      OldGroup := MainRecord.Container as IwbGroupRecord;
      NewOwner := _File.RecordByFormID[NewFormID, False, True];
      if not Assigned(NewOwner) then begin
        if Assigned(dcDataBasePtr) then
          PCardinal(dcDataBasePtr)^ := OldFormID.ToCardinal;
        Exit;
      end;
      if not _File.Equals(NewOwner._File) then
        NewOwner := wbCopyElementToFile(NewOwner, _File, False, True, '', '', '', '', False) as IwbMainRecord;
      GroupRecord := NewOwner.EnsureChildGroup;

      case GroupRecord.GroupType of
        1: begin
          Assert(OldGroup.GroupType in [1, 5]);
          Group1 := OldGroup;
          Group2 := nil;
          Group3 := nil;
          if OldGroup.GroupType = 5 then begin
            if not Supports(Group1.Container, IwbGroupRecord, Group2) then
              Assert(False);
            Assert(Group2.GroupType = 4);

            Group3 := nil;
            for i := 0 to Pred(GroupRecord.ElementCount) do
              if Supports(GroupRecord.Elements[i], IwbGroupRecord, Group3) then
                if (Group3.GroupType = 4) and (Group3.GroupLabel = Group2.GroupLabel) then
                  Break
                else
                  Group3 := nil;
            if not Assigned(Group3) then
              Group3 := TwbGroupRecord.Create(GroupRecord, 4, Group2.GroupLabel);
            GroupRecord := Group3;

            Group3 := nil;
            for i := 0 to Pred(GroupRecord.ElementCount) do
              if Supports(GroupRecord.Elements[i], IwbGroupRecord, Group3) then
                if (Group3.GroupType = 5) and (Group3.GroupLabel = Group1.GroupLabel) then
                  Break
                else
                  Group3 := nil;
            if not Assigned(Group3) then
              Group3 := TwbGroupRecord.Create(GroupRecord, 5, Group1.GroupLabel);
            GroupRecord := Group3;

            if not Supports(Group2.Container, IwbGroupRecord, Group3) then
              Assert(False);
            Assert(Group3.GroupType = 1);
          end;

          Group1.RemoveElement(MainRecord);
          if Group1.ElementCount = 0 then begin
            (Group1 as IwbGroupRecordInternal).SetModified(True);
            Group1.Remove;
            if Assigned(Group2) then
              if Group2.ElementCount = 0 then begin
               (Group2 as IwbGroupRecordInternal).SetModified(True);
                Group2.Remove;
                if Assigned(Group3) then
                  if Group3.ElementCount = 0 then begin
                    (Group3 as IwbGroupRecordInternal).SetModified(True);
                    Group3.Remove;
                  end else
                    (Group3 as IwbGroupRecordInternal).SetModified(True);
              end else
                (Group2 as IwbGroupRecordInternal).SetModified(True);
          end else
            (Group1 as IwbGroupRecordInternal).SetModified(True);

          GroupRecord.AddElement(MainRecord);
          (GroupRecord as IwbGroupRecordInternal).SetModified(True);
          (GroupRecord as IwbGroupRecordInternal).Sort;
        end;
        6: begin
             if MainRecord.IsPersistent then
               CorrectGroup := 8
             else if MainRecord.IsVisibleWhenDistant and not wbVWDInTemporary then
               CorrectGroup := 10
             else
               CorrectGroup := 9;

             Group3 := nil;
             for i := 0 to Pred(GroupRecord.ElementCount) do
               if Supports(GroupRecord.Elements[i], IwbGroupRecord, Group3) then
                 if Group3.GroupType = CorrectGroup then
                   Break
                 else
                   Group3 := nil;

             if not Assigned(Group3) then
               Group3 := TwbGroupRecord.Create(GroupRecord, CorrectGroup, GroupRecord.ChildrenOf);

             OldGroup.RemoveElement(MainRecord);
             if OldGroup.ElementCount = 0 then
               OldGroup.Remove
             else
               (OldGroup as IwbGroupRecordInternal).SetModified(True);
             Group3.AddElement(MainRecord);
             (Group3 as IwbGroupRecordInternal).SetModified(True);
             (Group3 as IwbGroupRecordInternal).Sort;
        end;
        7: begin
             OldGroup.RemoveElement(MainRecord);
             if OldGroup.ElementCount = 0 then
               OldGroup.Remove
             else
               (OldGroup as IwbGroupRecordInternal).SetModified(True);
             GroupRecord.AddElement(MainRecord);
             (GroupRecord as IwbGroupRecordInternal).SetModified(True);
             (GroupRecord as IwbGroupRecordInternal).Sort;
          end;
      else
        Assert(False);
      end;

    end;
  finally
    Dec(cieLockCount);
  end;
  ContainerChanged;
end;

procedure TwbContainedInElement.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
begin
end;

procedure TwbContainedInElement.InvalidateParentStorage;
begin
end;

function TwbContainedInElement.IsElementEditable(const aElement: IwbElement): Boolean;
begin
  Result := False;
end;

procedure TwbContainedInElement.SetModified(aValue: Boolean);
begin
  if not aValue then
    inherited
  else begin
    Exclude(eStates, esSortKeyValid);
    Exclude(eStates, esExtendedSortKeyValid);
    eSortKey := '';
  end;
end;

{ TwbMainRecordEntryHeader }

procedure TwbMainRecordEntryHeader.BeginUse;
begin
  Assert(not mrehInUse);
  mrehInUse := True;

  mrehGeneration := LockedInc(mreNextGen);
  mrehHead := nil;
  mrehTail := nil;
  mrehCount := 0;
end;

procedure TwbMainRecordEntryHeader.EndUse;
begin
  Assert(mrehInUse);
  mrehInUse := False;

  mrehGeneration := LockedInc(mreNextGen);
  mrehHead := nil;
  mrehTail := nil;
  mrehCount := 0;
end;

const
  WRLD : TwbSignature = 'WRLD';
  CELL : TwbSignature = 'CELL';
  DIAL : TwbSignature = 'DIAL';
  QUST : TwbSignature = 'QUST';

{ TwbFileSource }

constructor TwbFileSource.CreateNew(const aFileName: string; aLoadOrder: Integer);
begin
  Include(flStates, fsIsNew);
  flLoadOrder := aLoadOrder;
  flFileName := aFileName;
  flFileNameOnDisk := flFileName;
end;

procedure TwbFileSource.GetMasters(aMasters: TStrings);
var
  Header      : IwbFileHeader;
  MasterFiles : IwbContainerElementRef;
  fPath       : String;
  i           : Integer;
  modPtr      : Pointer;
  mods        : TwbArray;
begin
  if (GetElementCount <> 1) or not Supports(GetElement(0), IwbFileHeader, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Header.FileMagic <> wbFileMagic then
    raise Exception.CreateFmt('Expected File Magic %s, found %s in file "%s"',
      [wbFileMagic, String(Header.FileMagic), flFileName]);

  if Pos('Absolute:', wbFilePlugins)=1 then begin
    modPtr := PByte(flView) + StrToInt(Copy(wbFilePlugins, 10, Length(wbFilePlugins)));
    mods := TwbArray.Create(nil, modPtr, flEndPtr, wbArray('Modules', wbLenString('PluginName', 2), -4), '', False);
    Supports(mods, IwbContainerElementRef, MasterFiles);
  end else
    MasterFiles := Header.ElementByName[wbFilePlugins] as IwbContainerElementRef;

  if Assigned(MasterFiles) then
    for i := 0 to Pred(MasterFiles.ElementCount) do begin
      fPath := wbDataPath + MasterFiles[i].EditValue;
      if FileExists(fPath) then
        aMasters.Add(MasterFiles[i].EditValue)
    end;

end;

function CreateTemporaryCopy(FileName, CompareFile: String): String;
var
  s : String;
  i : Integer;

begin
  if not SameText(ExtractFilePath(CompareFile), wbDataPath) then begin
    s := wbDataPath + ExtractFileName(CompareFile);
    if FileExists(s) then // Finds a unique name
      for i := 0 to 255 do begin
        s := wbDataPath + ExtractFileName(CompareFile) + IntToHex(i, 3);
        if not FileExists(s) then Break;
      end;
    if FileExists(s) then begin
      wbProgressCallback('Could not copy ' + FileName + ' into ' + wbDataPath);
      Exit;
    end;
    CompareFile := s;
    CopyFile(PChar(FileName), PChar(CompareFile), false);
  end;
  Result := CompareFile;
end;

function SelectTemporaryCopy(FileName, CompareFile: String): String;
var
  s : String;
  i : Integer;

begin
  if not SameText(ExtractFilePath(CompareFile), wbDataPath) then begin
    for i := 0 to 255 do begin
      s := wbDataPath + ExtractFileName(CompareFile) + IntToHex(i, 3);
      if FileExists(s) then Break;
    end;
    if not FileExists(s) then
      s := wbDataPath + CompareFile + IntToHex(0, 3);
    CompareFile := s;
    if not FileExists(CompareFile) then
      CopyFile(PChar(FileName), PChar(CompareFile), false);
  end;
  Result := CompareFile;
end;

procedure TwbFileSource.Scan;
var
  CurrentPtr  : Pointer;
  Header      : IwbFileHeader;
  MasterFiles : IwbContainerElementRef;
  i           : Integer;
  ExtractInfo : TByteSet;
  Element     : IwbElement;
  Container   : IwbContainer;
  SelfRef     : IwbContainerElementRef;
  fPath       : String;
  modPtr      : Pointer;
  mods        : TwbArray;
  ValueDef    : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;
  flProgress('Start processing');

  flLoadOrderFileID := TwbFileID.CreateFull($FF);

  wbBaseOffset := NativeUInt(flView);

  CurrentPtr := flView;
  TwbFileHeader.Create(Self, CurrentPtr, flEndPtr, wbFileHeader, '', False);

  if (GetElementCount <> 1) or not Supports(GetElement(0), IwbFileHeader, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Header.FileMagic <> wbFileMagic then
    raise Exception.CreateFmt('Expected header Magic %s, found %s in file "%s"',
      [wbFileMagic, String(Header.FileMagic), flFileName]);

  if fsOnlyHeader in flStates then
    Exit;

  if Pos('Absolute:', wbFilePlugins)=1 then begin
    modPtr := PByte(flView) + StrToInt(Copy(wbFilePlugins, 10, Length(wbFilePlugins)));
    mods := TwbArray.Create(nil, modPtr, flEndPtr, wbArray('Modules', wbLenString('PluginName', 2), -4), '', False);
    Supports(mods, IwbContainerElementRef, MasterFiles);
  end else
    MasterFiles := Header.ElementByName[wbFilePlugins] as IwbContainerElementRef;

  if Assigned(MasterFiles) then
    for i := 0 to Pred(MasterFiles.ElementCount) do begin
      fPath := wbDataPath + MasterFiles[i].EditValue;
      if FileExists(fPath) then
        AddMaster(fPath, False, True)
      else if wbUseFalsePlugins then begin
        fPath := wbDataPath + wbAppName + TheEmptyPlugin; // place holder to keep save indexes
        if not FileExists(fPath) then
          fPath := ExtractFilePath(wbProgramPath) + wbAppName + TheEmptyPlugin; // place holder to keep save indexes
        if FileExists(fPath) then
          AddMaster(SelectTemporaryCopy(fPath, MasterFiles[i].EditValue), True, True);
      end;
    end;

  if flCompareTo <> '' then
    AddMaster(flCompareTo);

  if Assigned(wbExtractInfo) then
    ExtractInfo := wbExtractInfo^
  else
    ExtractInfo := [];

  for i := 0 to Pred(wbFileChapters.MemberCount) do begin

    ValueDef := wbFileChapters.Members[i];
    if ValueDef.DefType = dtResolvable then
      ValueDef := Resolve(ValueDef, currentPtr, flEndPtr, Self);
    if dfUnionStaticResolve in ValueDef.DefFlags then
      ValueDef := Resolve(ValueDef, currentPtr, flEndPtr, Self);

    case ValueDef.DefType of
      dtArray: Element := TwbArray.Create(Self, currentPtr, flEndPtr, ValueDef, '');
      dtStruct: Element := TwbStruct.Create(Self, currentPtr, flEndPtr, ValueDef, '');
      dtStructChapter: Element := TwbChapter.Create(Self, currentPtr, flEndPtr, ValueDef, '');
      dtUnion: Element := wbUnionCreate(Self, currentPtr, flEndPtr, ValueDef, '');
    else
      Element := TwbValue.Create(Self, currentPtr, flEndPtr, ValueDef, '');
    end;
    if (i in ExtractInfo) and Supports(Element, IwbContainer, Container) then
      with Element as TwbContainer do DoInit(True);
  end;

  for i := 0 to Pred(GetElementCount) do
    GetElement(i).SortOrder := i;

  flProgress('Processing completed');
  flLoadFinished := True;
end;

{ TwbFileHeader }

function TwbFileHeader.GetFileMagic: TwbFileMagic;
var
  Element : IwbElement;
  Container : IwbContainer;
begin
  Result := '';
  if not Supports(Self, IwbContainer, Container) or (Container.ElementCount < 1) then Exit;
  Element := Container.Elements[0];
  if Assigned(Element) then
    Result := Element.NativeValue;
end;

{ TwbChapter }

constructor TwbChapter.Create(const aContainer  : IwbContainer;
                              const aValueDef   : IwbValueDef;
                              const aSource     : IwbElement;
                              const aOnlySK     : Boolean;
                              const aNameSuffix : string);
var
  Dummy : Integer;
begin
  if Assigned(aValueDef) then
    Assert(Supports(aValueDef, IwbStructCDef));
  inherited;
  cChapterSkipped := cChapterSkipped or ChaptersToSkip.Find(aValueDef.Name, Dummy);
end;

function TwbChapter.GetChapterName: String;
var
  Struct : IwbStructCDef;
begin
  if Assigned(vbValueDef) and Supports(vbValueDef, IwbStructCDef, Struct) then
    Result := Struct.GetChapterName(dcBasePtr, dcEndPtr, Self)
  else
    Result := Struct.GetChapterTypeName(dcBasePtr, dcEndPtr, Self);
end;

function TwbChapter.GetChapterType: Integer;
var
  Struct : IwbStructCDef;
begin
  Result := -1;
  if Assigned(vbValueDef) and Supports(vbValueDef, IwbStructCDef, Struct) then
    Result := Struct.GetChapterType(dcBasePtr, dcEndPtr, Self);
end;

function TwbChapter.GetChapterTypeName: String;
var
  Struct : IwbStructCDef;
begin
  if Assigned(vbValueDef) and Supports(vbValueDef, IwbStructCDef, Struct) then
    Result := Struct.GetChapterTypeName(dcBasePtr, dcEndPtr, Self)
  else
    Result := IntToStr(Struct.GetChapterType(dcBasePtr, dcEndPtr, Self));
end;

function TwbChapter.GetElementType: TwbElementType;
begin
  Result := etStructChapter;
end;

function TwbChapter.GetSkipped: Boolean;
begin
  Result := cChapterSkipped;
end;

{ TwbKeepAliveRoot }

constructor TwbKeepAliveRoot.Create;
begin
  inherited;
  Setup;
end;

destructor TwbKeepAliveRoot.Destroy;
begin
  inherited;
  Teardown;
end;

procedure TwbKeepAliveRoot.Done;
begin
  Teardown;
end;

function TwbKeepAliveRoot.IsRoot: Boolean;
begin
  Result := not Assigned(karKAC.kacPrev);
end;

procedure TwbKeepAliveRoot.Setup;
begin
  New(karKAC);
  karKAC.kacFinished := False;
  karKAC.kacPrev := wbKeepAliveContext;
  karKAC.kacHead := TwbContainer.Create(nil);
  wbKeepAliveContext := karKAC;
end;

procedure TwbKeepAliveRoot.Teardown;
var
  KAC : PwbKeepAliveContext;
begin
  if Assigned(karKAC) then begin
    karKAC.kacFinished := True;
    karKAC := nil;
  end;

  KAC := wbKeepAliveContext;
  while Assigned(KAC) and KAC.kacFinished do begin
    wbKeepAliveContext := KAC.kacPrev;
    while Assigned(KAC.kacHead) do
      KAC.kacHead := KAC.kacHead.ReleaseKeepAlive;
    Dispose(KAC);
    KAC := wbKeepAliveContext;
  end;
end;

{ TwbSubRecordHeaderStruct }

{
class operator TwbSubRecordHeaderStruct.Implicit(const aSource : TwbSubRecordHeaderStruct)
                                                               : TwbSubRecordHeaderStruct;
begin
  Result.srsSignature := aSource.srsSignature;
  Result.srsDataSize := aSource.srsDataSize;
end;
}
class function TwbSubRecordHeaderStruct.SizeOf: NativeInt;
begin
  if wbGameMode = gmTES3 then
    Result := System.SizeOf(TwbSignature) + System.SizeOf(Cardinal)
  else
    Result := System.SizeOf(TwbSignature) + System.SizeOf(Word);
end;

function TwbSubRecordHeaderStruct.srsGetDataSize: Cardinal;
begin
  if wbGameMode = gmTES3 then
    Result := _DataSizeCardinal
  else
    Result := _DataSizeWord;
end;

procedure TwbSubRecordHeaderStruct.srsSetDataSize(const Value: Cardinal);
begin
  if wbGameMode = gmTES3 then
    _DataSizeCardinal := Value
  else
    _DataSizeWord := Value;
end;

{ TwbMainRecordStruct }

function TwbMainRecordStruct.mrsFlags: PwbMainRecordStructFlags;
begin
  if wbGameMode = gmTES3 then
    Result := @_TES3_Flags
  else
    Result := @_Flags;
end;

function TwbMainRecordStruct.mrsFormID: PwbFormID;
begin
  if wbGameMode = gmTES3 then
    Result := nil
  else
    Result := @_FormID;
end;

function TwbMainRecordStruct.mrsVCS1: PCardinal;
begin
  if wbGameMode = gmTES3 then
    Result := @_TES3_VCS1
  else
    Result := @_VCS1;
end;

function TwbMainRecordStruct.mrsVCS2: PWord;
begin
  if wbGameMode = gmTES3 then
    Result := nil
  else
    Result := @_VCS2;
end;

function TwbMainRecordStruct.mrsVersion: PWord;
begin
  if wbGameMode = gmTES3 then
    Result := nil
  else
    Result := @_Version;
end;

var
  _Identitys  : array[Byte] of TDictionary<string, Cardinal>;
  _NextIDs    : array[Byte] of Cardinal;

function wbFormIDFromIdentity(aFormIDBase, aFormIDNameBase: Byte; aIdentity: string): TwbFormID;
var
  i: Cardinal;
begin
  Assert(wbGameMode = gmTES3);
  aIdentity := aIdentity.ToLowerInvariant;

  if not Assigned(_Identitys[aFormIDNameBase]) then
    _Identitys[aFormIDNameBase] := TDictionary<string, Cardinal>.Create;

  if not _Identitys[aFormIDNameBase].TryGetValue(aIdentity, i) then begin
    i := _NextIDs[aFormIDNameBase];
    Inc(_NextIDs[aFormIDNameBase]);
    _Identitys[aFormIDNameBase].Add(aIdentity, i);
  end;

  Result := TwbFormID.FromCardinal( (Cardinal(aFormIDBase) shl 16) + i );
end;

function wbRecordByLoadOrderFormID(const aFormID: TwbFormID; const aSeenFromFile: IwbFile): IwbMainRecord;
var
  FileID: TwbFileID;
begin
  Result := nil;
  FileID := aFormID.FileID;
  for var i:= Low(Files) to High(Files) do
    if Files[i].LoadOrderFileID = FileID then begin
      Result := Files[i].RecordByFormID[aFormID, True, False];
      if Assigned(Result) and Assigned(aSeenFromFile) then begin
        var lVisibleResult := Result.HighestOverrideVisibleForFile[aSeenFromFile];
        if Assigned(lVisibleResult) then
          Result := lVisibleResult;
      end;
      Exit;
    end;
end;

{ TwbTemplateElement }

constructor TwbTemplateElement.Create(aDef: IwbNamedDef);
begin
  teDef := aDef;
  inherited Create(nil);
end;

function TwbTemplateElement.GetDef: IwbNamedDef;
begin
  Result := teDef;
end;

function TwbTemplateElement.GetElementType: TwbElementType;
begin
  Result := etTemplate;
end;

function TwbTemplateElement.GetName: string;
begin
  Result := teDef.Name;
end;

function TwbTemplateElement.GetValueDef: IwbValueDef;
begin
  Supports(teDef, IwbValueDef, Result);
end;

{ TwbMultipleElements }

constructor TwbMultipleElements.Create(const aElements: IwbElements);
begin
  meElements := aElements;
end;

function TwbMultipleElements.GetElement(aIndex: Integer): IwbElement;
begin
  Result := meElements[aIndex];
end;

function TwbMultipleElements.GetElementCount: Integer;
begin
  Result := Length(meElements);
end;

function wbMultipleElements(const aElements: IwbElements): IwbMultipleElements;
begin
  Result := TwbMultipleElements.Create(aElements);
end;

initialization
  _MastersGeneration := 1;
{$IFDEF USE_PARALLEL_BUILD_REFS}
  _ResizeLock.Initialize;
{$ENDIF}

  wbContainedInDef[1] := wbFormIDCk('Worldspace', [WRLD], False, cpNormal, True);
  wbContainedInDef[6] := wbFormIDCk('Cell', [CELL], False, cpNormal, True);
  wbContainedInDef[7] := wbFormIDCk('Topic', [DIAL], False, cpNormal, True);
  wbContainedInDef[10] := wbFormIDCk('Quest', [QUST], False, cpNormal, True);

  SubRecordOrderList := TwbFastStringList.Create;
  SubRecordOrderList.Sorted := True;
  SubRecordOrderList.Duplicates := dupIgnore;

  RecordToSkip := TwbFastStringList.Create;
  RecordToSkip.Sorted := True;
  RecordToSkip.Duplicates := dupIgnore;

  SubRecordToSkip := TwbFastStringList.Create;
  SubRecordToSkip.Sorted := True;
  SubRecordToSkip.Duplicates := dupIgnore;

  GroupToSkip := TwbFastStringList.Create;
  GroupToSkip.Sorted := True;
  GroupToSkip.Duplicates := dupIgnore;

  ChaptersToSkip := TwbFastStringList.Create;
  ChaptersToSkip.Sorted := True;
  ChaptersToSkip.Duplicates := dupIgnore;

  FilesMap := TwbFastStringList.Create;
  FilesMap.Sorted := True;
  FilesMap.Duplicates := dupError;
finalization
  WriteSubRecordOrderList;
  FreeAndNil(SubRecordOrderList);
  FreeAndNil(RecordToSkip);
  FreeAndNil(GroupToSkip);
  FreeAndNil(ChaptersToSkip);
  FreeAndNil(FilesMap);
  wbContainedInDef[1] := nil;
  wbContainedInDef[6] := nil;
  wbContainedInDef[7] := nil;
  wbContainedInDef[10] := nil;
  for var i := Low(_Identitys) to High(_Identitys) do
    FreeAndNil(_Identitys[i]);

{$IFDEF USE_PARALLEL_BUILD_REFS}
  _ResizeLock.Destroy;
{$ENDIF}
end.
