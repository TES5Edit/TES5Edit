{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

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
  GroupToSkip        : TStringList;
  ChaptersToSkip     : TStringList;
  SubRecordOrderList : TStringList;

function wbMastersForFile(const aFileName: string; aMasters: TStrings; aIsESM: PBoolean = nil; aIsESL: PBoolean = nil): Boolean; overload;
function wbMastersForFile(const aFileName: string; out aMasters: TDynStrings; aIsESM: PBoolean = nil; aIsESL: PBoolean = nil): Boolean; overload;

function wbFile(const aFileName: string; aLoadOrder: Integer = -1; aCompareTo: string = '';
  IsTemporary: Boolean = False; aOnlyHeader: Boolean = False): IwbFile;
function wbNewFile(const aFileName: string; aLoadOrder: Integer; aIsESL: Boolean): IwbFile; overload;
function wbNewFile(const aFileName: string; aLoadOrder: Integer; aTemplate: PwbModuleInfo): IwbFile; overload;
procedure wbFileForceClosed;

function StartsWith(const s, t: string): Boolean;

function wbCopyElementToFile(const aSource: IwbElement; aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
function wbCopyElementToRecord(const aSource: IwbElement; aMainRecord: IwbMainRecord; aAsNew, aDeepCopy: Boolean): IwbElement;

function wbFindWinningMainRecordByEditorID(const aSignature: TwbSignature; const aEditorID: string): IwbMainRecord;
function wbFormListToArray(const aFormList: IwbMainRecord; const aSignatures: string): TDynMainRecords;

function wbCreateKeepAliveRoot: IwbKeepAliveRoot;

function wbBeginKeepAlive: Integer;
function wbEndKeepAlive: Integer;

implementation

uses
  wbHelpers,
  wbSort;

const
  EmptyPtr: AnsiChar = #0;

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
    mrehGeneration : Cardinal;
    mrehHead       : Pointer;
    mrehTail       : Pointer;
    mrehCount      : Cardinal;
    mrehInUse      : Boolean;

    procedure BeginUse;
    procedure EndUse;
  end;

var
  mreHeader: TwbMainRecordEntryHeader;

function wbCopyElementToFile(const aSource: IwbElement; aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
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
        Container := MainRecord.HighestOverrideOrSelf[aFile.LoadOrder];
      Target := wbCopyElementToFile(Container, aFile, False, False, aPrefixRemove, aPrefix, aSuffix)
    end else begin
      Result := aFile;
      Exit;
    end;

    if Assigned(Target) then
      Result := Target.AddIfMissing(aSource, aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix)
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
  Assert(Assigned(Container));
  Target := wbCopyElementToRecord(Container, aMainRecord, False, False);

  if Assigned(Target) then
    Result := Target.AddIfMissing(aSource, aAsNew, aDeepCopy, '', '', '')
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
    procedure SetModified(aValue: Boolean);
    procedure SetInternalModified(aValue: Boolean);
    function GetCountedRecordCount: Cardinal;
    procedure PrepareSave;
    procedure MasterCountUpdated(aOld, aNew: Byte);
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
    procedure FindUsedMasters(aMasters: PwbUsedMasters);
    procedure InvalidateStorage;
    function Reached: Boolean;

    function BeginDecide: Boolean;
    procedure EndDecide;

    property Modified: Boolean
      read GetModified
      write SetModified;

    property MemoryOrder: Integer
      read GetMemoryOrder
      write SetMemoryOrder;

    property InternalModified: Boolean
      write SetInternalModified;
  end;

  TwbElement = class(TInterfacedObject, IInterface, IwbElement, IwbElementInternal)
  protected
    eContainer       : Pointer{IwbContainer}; //weak reference
    eSortOrder       : Integer;
    eMemoryOrder     : Integer;
    eStates          : TwbElementStates;
    eSortKey         : string;
    eExtendedSortKey : string;

    eExternalRefs    : Integer;
    eContainerRef    : IwbContainerElementRef;

    eUpdateCount     : Integer;

    eGeneration      : Integer;

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
    procedure MasterCountUpdated(aOld, aNew: Byte); virtual;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); virtual;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); virtual;
    procedure InvalidateStorage; virtual;
    procedure InvalidateParentStorage; virtual;
    function Reached: Boolean; virtual;
    function LinksToParent: Boolean; virtual;
    procedure SetMemoryOrder(aIndex: Integer);
    function GetMemoryOrder: Integer;

    function BeginDecide: Boolean;
    procedure EndDecide;

    procedure NotifyChanged(aContainer: Pointer);
    procedure NotifyChangedInternal(aContainer: Pointer); virtual;

    procedure ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false); virtual;

    function GetElementID: Pointer;
    function GetElementStates: TwbElementStates;
    procedure SetElementState(aState: TwbElementState; Clear: Boolean = false);
    function Equals(const aElement: IwbElement): Boolean; reintroduce;

    procedure Hide;
    procedure Show;
    function GetIsHidden: Boolean;

    function HasErrors: Boolean; virtual;

    function GetValue: string; virtual;
    function GetCheck: string; virtual;
    function GetSortKey(aExtended: Boolean): string; virtual;
    function GetSortKeyInternal(aExtended: Boolean): string; virtual;
    function GetSortPriority: Integer; virtual;
    function GetName: string; virtual;
    function GetBaseName: string; virtual;
    function GetDisplayName: string; virtual;
    function GetShortName: string; virtual;
    function GetPath: string; virtual;
    function GetFullPath: string; virtual;
    function GetPathName: string; virtual;
    function GetSkipped: Boolean; virtual;
    function GetDef: IwbNamedDef; virtual;
    function GetValueDef: IwbValueDef; virtual;
    function GetResolvedValueDef: IwbValueDef; virtual;
    function GetElementType: TwbElementType; virtual;
    procedure DoReset(aForce: Boolean); virtual;
    function GetContainer: IwbContainer;
    function GetContainingMainRecord: IwbMainRecord; virtual;
    function GetFile: IwbFile; virtual;
    function GetReferenceFile: IwbFile; virtual;
    function GetSortOrder: Integer;
    procedure BuildRef; virtual;
    procedure AddReferencedFromID(aFormID: TwbFormID); virtual;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; virtual;
    function GetIsEditable: Boolean; virtual;
    function GetIsRemoveable: Boolean; virtual;
    function GetEditValue: string; virtual;
    procedure SetEditValue(const aValue: string); virtual;
    function GetNativeValue: Variant; virtual;
    procedure SetNativeValue(const aValue: Variant); virtual;
    procedure RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal); virtual;
    function GetConflictPriority: TwbConflictPriority; virtual;
    function GetConflictPriorityCanChange: Boolean; virtual;
    function GetModified: Boolean;
    procedure MarkModifiedRecursive; virtual;
    function GetIsInjected: Boolean; virtual;
    function GetReferencesInjected: Boolean; virtual;
    function GetInjectionSourceFiles: TDynFiles; virtual;
    function GetIsNotReachable: Boolean; virtual;
    procedure SetModified(aValue: Boolean); virtual;
    procedure SetInternalModified(aValue: Boolean); virtual;
    function GetDataSize: Integer; virtual;
    procedure SetDataSize(aSize: Integer); virtual;
    procedure MergeStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); virtual;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); virtual;
    procedure Remove; virtual;
    function CanContainFormIDs: Boolean; virtual;
    function AddIfMissing(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; virtual;
    procedure ResetConflict; virtual;
    procedure ResetReachable; virtual;
    function RemoveInjected(aCanRemove: Boolean): Boolean; virtual;
    function GetEditType: TwbEditType; virtual;
    function GetEditInfo: string; virtual;
    function GetDontShow: Boolean; virtual;
    procedure SetToDefault;
    procedure SetToDefaultInternal; virtual;

    function CanAssign(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; virtual;
    function Assign(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; virtual;

    procedure WriteToStream(aStream: TStream; aResetModified: Boolean);
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); virtual;
    function GetLinksTo: IwbElement; virtual;
    function GetNoReach: Boolean;

    procedure SetContainer(const aContainer: IwbContainer); virtual;
    procedure SetSortOrder(aIndex: Integer);

    procedure DoAfterSet(const aOldValue, aNewValue: Variant); virtual;

    procedure MoveUp;
    procedure MoveDown;
    function CanMoveUp: Boolean;
    function CanMoveDown: Boolean;

    procedure NextMember;
    procedure PreviousMember;
    function CanChangeMember: Boolean;

    procedure Tag;
    procedure ResetTags; virtual;
    function IsTagged: Boolean;

    function CopyInto(const aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;

    function BeginUpdate: Integer;
    function EndUpdate: Integer;
    procedure UpdatedEnded; virtual;

    constructor Create(const aContainer: IwbContainer);
    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;

    function GetTreeHead: Boolean;              // Is the element expected to be a "header record" in the tree navigator
    function GetTreeBranch: Boolean;            // Is the element expected to show in the tree navigator
  end;

  TDynElementInternals = array of IwbElementInternal;

  IwbContainerInternal = interface(IwbContainer)
    ['{8D9AC0D3-3961-4320-A036-EB4771B081CD}']

    function ReleaseElements: TDynElementInternals;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer);
    procedure SortBySortOrder;
    procedure CreatedEmpty;

    procedure MoveElementUp(const aElement: IwbElement);
    procedure MoveElementDown(const aElement: IwbElement);
    function CanMoveElementUp(const aElement: IwbElement): Boolean;
    function CanMoveElementDown(const aElement: IwbElement): Boolean;

    procedure NextElementMember(const aElement: IwbElement);
    procedure PreviousElementMember(const aElement: IwbElement);
    function CanChangeElementMember(const aElement: IwbElement): Boolean;
  end;

  TwbContainer = class(TwbElement, IwbContainerElementRef, IwbContainer, IwbContainerInternal)
  protected
    cntElements      : TDynElementInternals;
    cntElementsMap   : TDynCardinalArray;
    cntElementRefs   : Integer;
    cntStates        : TwbContainerStates;
    cntKeepAliveNext : IwbContainerElementRef;
    cntRefsBuildAt   : Integer;

    function _AddRef: Integer; override; stdcall;
    function _Release: Integer; override; stdcall;

    {---IwbContainerElementRef---}
    function ElementAddRef: Integer; stdcall;
    function ElementRelease: Integer; stdcall;
    function IwbContainerElementRef._AddRef = ElementAddRef;
    function IwbContainerElementRef._Release = ElementRelease;
    function GetCountedRecordCount: Cardinal; override;
    procedure PrepareSave; override;
    procedure MasterCountUpdated(aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;

    procedure SortBySortOrder; virtual;
    procedure CreatedEmpty;

    function Reached: Boolean; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;

    procedure ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false); override;
    procedure ResetConflict; override;
    procedure ResetReachable; override;

    procedure DoReset(aForce: Boolean); override;
    procedure DoInit; virtual;

    function HasErrors: Boolean; override;

    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetDataSize: Integer; override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure BuildRef; override;
    procedure MarkModifiedRecursive; override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function GetIsInSK(aIndex: Integer): Boolean; virtual;

    procedure SetToDefaultInternal; override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;

    function GetElement(aIndex: Integer): IwbElement;
    function GetElementCount: Integer;
    function GetElementByName(const aName: string): IwbElement;
    function GetRecordBySignature(const aSignature: TwbSignature): IwbRecord;
    function GetElementByMemoryOrder(aSortOrder: Integer): IwbElement;
    function GetElementBySignature(const aSignature: TwbSignature): IwbElement;
    function GetElementBySortOrder(aSortOrder: Integer): IwbElement;
    function GetAdditionalElementCount: Integer; virtual;
    procedure ReverseElements;
    function GetContainerStates: TwbContainerStates;
    function GetElementByPath(const aPath: string): IwbElement;
    function GetElementValue(const aName: string): string;
    function GetElementExists(const aName: string): Boolean;
    function GetElementEditValue(const aName: string): string;
    procedure SetElementEditValue(const aName, aValue: string);
    function GetElementNativeValue(const aName: string): Variant;
    procedure SetElementNativeValue(const aName: string; const aValue: Variant);
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

    function IsElementRemoveable(const aElement: IwbElement): Boolean; virtual;
    function IsElementEditable(const aElement: IwbElement): Boolean; virtual;

    function IndexOf(const aElement: IwbElement): Integer; virtual;

    function ReleaseElements: TDynElementInternals;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); virtual;
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

    procedure NextElementMember(const aElement: IwbElement);
    procedure PreviousElementMember(const aElement: IwbElement);
    function CanChangeElementMember(const aElement: IwbElement): Boolean;

    function FindBySortKey(const aSortKey: string; aExtended: Boolean; out aIndex: Integer): Boolean;

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
  end;

  TwbFile = class(TwbContainer, IwbFile, IwbFileInternal)
  protected
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
    flSize                   : Cardinal;
    flEndPtr                 : Pointer;
    flCRC32                  : Cardinal;

    flMasters                : array of IwbFile;

    flRecords                : array of IwbMainRecord;
    flRecordsCount           : Integer; {only used during loading}

    flRecordsByEditorID      : array of IwbMainRecord;
    flRecordsByEditorIDCount : Integer; {only used during loading}

    flLoadFinished           : Boolean;
    flFormIDsSorted          : Boolean;

    flInjectedRecords        : array of IwbMainRecord;

    flModule                 : PwbModuleInfo;

    procedure flOpenFile; virtual;
    procedure flCloseFile; virtual;
    procedure flProgress(const aStatus: string);

    function Reached: Boolean; override;

    function GetElementType: TwbElementType; override;
    function GetFile: IwbFile; override;
    function GetReferenceFile: IwbFile; override;
    function GetName: string; override;
    function GetBaseName: string; override;
    procedure PrepareSave; override;
    procedure SetModified(aValue: Boolean); override;

    procedure BuildRef; override;
    function BuildOrLoadRef(aOnlyLoad: Boolean): TwbBuildOrLoadRefResult;

    function FindFormID(aFormID: TwbFormID; var Index: Integer): Boolean;
    function FindInjectedID(aFormID: TwbFormID; var Index: Integer): Boolean;
    function FindEditorID(const aEditorID: string; var Index: Integer): Boolean;
    function GetMasterRecordByFormID(aFormID: TwbFormID; aAllowInjected: Boolean): IwbMainRecord;

    function GetAddList: TDynStrings; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    function IsElementEditable(const aElement: IwbElement): Boolean; override;
    function GetIsEditable: Boolean; override;
    function GetIsRemoveable: Boolean; override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;

    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;

    function NewFormID: TwbFormID;

    {---IwbFile---}
    function GetFileName: string;
    function GetFileNameOnDisk: string;
    function GetModuleInfo: Pointer;
    function GetUnsavedSince: TDateTime; inline;
    function HasMaster(const aFileName: string): Boolean;
    function GetMaster(aIndex: Integer): IwbFile; inline;
    function GetMasterCount: Integer; inline;
    function GetRecordByFormID(aFormID: TwbFormID; aAllowInjected: Boolean): IwbMainRecord;
    function GetRecordByEditorID(const aEditorID: string): IwbMainRecord;
    function GetGroupBySignature(const aSignature: TwbSignature): IwbGroupRecord;
    function HasGroup(const aSignature: TwbSignature): Boolean;
    function GetFileStates: TwbFileStates; inline;
    function GetCRC32: Cardinal;
    function GetRecord(aIndex: Integer): IwbMainRecord; inline;
    function GetRecordCount: Integer; inline;
    function GetHeader: IwbMainRecord;

    function GetLoadOrder: Integer; inline;
    procedure ForceLoadOrder(aValue: Integer);
    procedure SetLoadOrder(aValue: Integer);

    function GetLoadOrderFileID: TwbFileID;
    function GetFileFileID: TwbFileID;

    function LoadOrderFormIDtoFileFormID(aFormID: TwbFormID): TwbFormID;
    function FileFormIDtoLoadOrderFormID(aFormID: TwbFormID): TwbFormID;

    function LoadOrderFileIDtoFileFileID(aFileID: TwbFileID): TwbFileID;
    function FileFileIDtoLoadOrderFileID(aFileID: TwbFileID): TwbFileID;

    procedure AddMasters(aMasters: TStrings);
    procedure AddMasterIfMissing(const aMaster: string);
    procedure SortMasters;
    procedure CleanMasters;

    procedure BuildReachable;

    function GetIsESM: Boolean;
    procedure SetIsESM(Value: Boolean);

    function GetIsESL: Boolean;
    procedure SetIsESL(Value: Boolean);

    function GetIsLocalized: Boolean;
    procedure SetIsLocalized(Value: Boolean);

    function GetNextObjectID: Cardinal;
    procedure SetNextObjectID(aObjectID: Cardinal);

    function GetIsNotPlugin: Boolean;
    function GetHasNoFormID: Boolean;
    procedure SetHasNoFormID(Value: Boolean);

    {---IwbFileInternal---}
    procedure AddMainRecord(const aRecord: IwbMainRecord);
    procedure RemoveMainRecord(const aRecord: IwbMainRecord);
    procedure InjectMainRecord(const aRecord: IwbMainRecord);
    procedure RemoveInjectedMainRecord(const aRecord: IwbMainRecord);
    procedure ForceClosed;
    procedure GetMasters(aMasters: TStrings); virtual;

    procedure Scan; virtual;
    procedure SortRecords;
    procedure SortRecordsByEditorID;

    procedure AddMaster(const aFileName: string; isTemporary: Boolean = False); overload;
    procedure AddMaster(const aFile: IwbFile); overload;

    procedure UpdateModuleMasters;

    constructor Create(const aFileName: string; aLoadOrder: Integer; aCompareTo: string; aOnlyHeader: Boolean; IsTemporary: Boolean = False);
    constructor CreateNew(const aFileName: string; aLoadOrder: Integer; aIsEsl: Boolean); overload;
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
    dcfStorageInvalid
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
                             aEndPtr         : Pointer;
                       const aPrevMainRecord : IwbMainRecord); virtual;
    procedure InitDataPtr; virtual; abstract;
    function GetDataPrefixSize: Integer; virtual;

    function GetResolvedValueDef: IwbValueDef; override;

    procedure InvalidateStorage; override;
    procedure SetContainer(const aContainer: IwbContainer); override;

    procedure SetModified(aValue: Boolean); override;
    procedure RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal); override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function DoCheckSizeAfterWrite: Boolean; virtual;
    procedure SetToDefaultInternal; override;
    function IsFlags: Boolean; virtual;

    function GetEditType: TwbEditType; override;
    function GetEditInfo: string; override;

    function GetConflictPriority: TwbConflictPriority; override;

    {---IwbDataContainer---}
    function GetDataBasePtr: Pointer;
    function GetDataEndPtr: Pointer;
    function GetDataSize: Integer; override;
    procedure SetDataSize(aSize: Integer); override;
    function GetDontCompare: Boolean;
    function GetDontSave: Boolean;
    function IsValidOffset(aBasePtr, aEndPtr: Pointer; anOffset: Integer): Boolean;
    function IsLocalOffset(anOffset: Integer): Boolean;

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
                             aEndPtr         : Pointer;
                       const aPrevMainRecord : IwbMainRecord); overload; override;

    function GetSignature: TwbSignature;
    procedure ScanData; virtual; abstract;
    procedure InformPrevMainRecord(const aPrevMainRecord : IwbMainRecord); virtual;
    procedure SortBySortOrder; override;
  public
    class function CreateForPtr(var aPtr            : Pointer;
                                    aEndPtr         : Pointer;
                              const aContainer      : IwbContainer;
                              const aPrevMainRecord : IwbMainRecord)
                                                    : IwbRecord;

    function GetName: string; override;
    function GetSkipped: Boolean; override;
  end;

  PwbMainRecordStruct = ^TwbMainRecordStruct;
  TwbMainRecordStruct = packed record
    mrsSignature : TwbSignature;
    mrsDataSize  : Cardinal;
    mrsFlags     : TwbMainRecordStructFlags;
    mrsFormID    : TwbFormID;
    mrsVCS1      : Cardinal;
    mrsVersion   : Word;
    mrsVCS2      : Word;
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

    procedure SaveRefsToStream(aStream: TStream);
    procedure LoadRefsFromStream(aStream: TStream);

    procedure MakeHeaderWriteable;
    function mrStruct: PwbMainRecordStruct;
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
    mrsSearchedChildGroup,
    mrsHasVWDMeshChecked,
    mrsHasVWDMesh,
    mrsHasPrecombinedMeshChecked,
    mrsHasPrecombinedMesh,
    mrsBaseRecordChecked,
    mrsQuickInit,
    mrsQuickInitDone,
    mrsHasMeshChecked,
    mrsHasMesh,
    mrsNoUpdateRefs,
    mrsBasePtrAllocated,
    mrsOverridesSorted
  );

  TwbMainRecordStates = set of TwbMainRecordState;

  IwbContainedIn = interface
    ['{002F064A-81B8-40EB-AA09-E5F7AE061D9E}']
    procedure ContainerChanged;
  end;

  TwbMainRecord = class(TwbRecord, IwbMainRecord, IwbMainRecordInternal, IwbMainRecordEntry, IwbContainedIn)
  protected
    mrDef               : IwbRecordDef;
    mrLoadOrderFormID   : TwbFormID;
    mrFixedFormID       : TwbFormID;
    mrMaster            : Pointer{IwbMainRecord};
    mrOverrides         : TDynMainRecords;
    mrMasterAndLeafs    : array of Pointer{IwbMainRecord};
    mrEditorID          : string;
    mrFullName          : string;
    mrStates            : TwbMainRecordStates;
    mrBaseRecordID      : TwbFormID;
    mrPrecombinedCellID : Cardinal;
    mrPrecombinedID     : Cardinal;
    mrConflictAll       : TConflictAll;
    mrConflictThis      : TConflictThis;
    mrDataStorage       : TBytes;
    mrGroup             : IwbGroupRecord;

    mrReferencedBy      : TDynMainRecords;
    mrReferencedByCount : Integer;
    mrReferencedBySize  : Integer;

    mrReferences        : TwbFormIDs;
    mrTmpRefFormIDs     : TwbFormIDs;
    mrTmpRefFormIDHigh  : Integer;

    mreGeneration       : Integer;
    mrePrev             : Pointer;
    mreNext             : Pointer;

    function mrStruct: PwbMainRecordStruct; inline;

    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    function RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement; overload; override;
    function ResolveElementName(aName: string; out aRemainingName: string; aCanCreate: Boolean = False): IwbElement; override;

    function GetIsInjected: Boolean; override;
    function GetReferencesInjected: Boolean; override;
    function GetInjectionSourceFiles: TDynFiles; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;
    function GetIsNotReachable: Boolean; override;
    function GetCountedRecordCount: Cardinal; override;
    procedure InitDataPtr; override;
    procedure DecompressIfNeeded;
    procedure ScanData; override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function CanContainFormIDs: Boolean; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function CanElementReset: Boolean; override;
    procedure Remove; override;
    procedure PrepareSave; override;
    procedure MasterCountUpdated(aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
    function GetReferenceFile: IwbFile; override;
    procedure ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false); override;
    function LinksToParent: Boolean; override;
    function Reached: Boolean; override;
    function GetContainingMainRecord: IwbMainRecord; override;

    procedure DoBuildRef(aRemove: Boolean);
    procedure BuildRef; override;
    procedure AddReferencedFromID(aFormID: TwbFormID); override;
    procedure ResetConflict; override;
    procedure ResetReachable; override;

    procedure Init; override;
    procedure Reset; override;

    function GetPath: string; override;
    function GetValue: string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetSortPriority: Integer; override;
    function GetAdditionalElementCount: Integer; override;
    function GetIsEditable: Boolean; override;
    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;
    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;
    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    procedure SetContainer(const aContainer: IwbContainer); override;

    function FindReferencedBy(const aMainRecord: IwbMainRecord; var Index: Integer): Boolean;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;

    procedure CollapseStorage;

    function GetAddList: TDynStrings; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function CheckChildOfCell: Boolean;
    procedure UpdateCellChildGroup;
    procedure UpdateInteriorCellGroup;

    procedure MarkModifiedRecursive; override;

    {---IwbMainRecord---}
    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;
    function GetFormID: TwbFormID; inline;
    function GetFixedFormID: TwbFormID; inline;
    function DoGetFixedFormID: TwbFormID;
    function GetLoadOrderFormID: TwbFormID; inline;
    function DoGetLoadOrderFormID: TwbFormID;
    procedure SetLoadOrderFormID(aFormID: TwbFormID);
    function GetEditorID: string;
    function GetCanHaveEditorID: Boolean;
    procedure SetEditorID(const aValue: string);
    function GetFullName: string;
    function GetDisplayNameKey: string;
    function GetMaster: IwbMainRecord;
    function GetIsMaster: Boolean;
    function GetMasterOrSelf: IwbMainRecord;
    function GetOverride(aIndex: Integer): IwbMainRecord;
    function GetOverrideCount: Integer;
    procedure AddReferencedBy(aMainRecord: IwbMainRecord);
    procedure RemoveReferencedBy(aMainRecord: IwbMainRecord);
    procedure SortReferencedBy;
    function GetReferencedBy(aIndex: Integer): IwbMainRecord;
    function GetReferencedByCount: Integer;
    function GetCheck: string; override;
    function GetIsWinningOverride: Boolean;
    function GetWinningOverride: IwbMainRecord;
    function GetHighestOverrideOrSelf(aMaxLoadOrder: Integer): IwbMainRecord;
    function GetFlags: TwbMainRecordStructFlags;
    function GetFlagsPtr: PwbMainRecordStructFlags;
    function GetChildGroup: IwbGroupRecord;
    function EnsureChildGroup: IwbGroupRecord;
    function GetBaseRecord: IwbMainRecord;
    function GetBaseRecordID: TwbFormID;
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
    function GetIsESL: Boolean;
    procedure SetIsESL(aValue: Boolean);

    procedure UpdateRefs;

    function GetPosition(out aPosition: TwbVector): Boolean;
    function SetPosition(const aPosition: TwbVector): Boolean;
    function GetRotation(out aRotation: TwbVector): Boolean;
    function GetScale(out aScale: Single): Boolean;
    function GetGridCell(out aGridCell: TwbGridCell): Boolean;
    function GetFormVersion: Cardinal; {>>> Form Version access <<<}
    procedure SetFormVersion(aFormVersion: Cardinal); {>>> Form Version access <<<}
    function GetFormVCS1: Cardinal;
    procedure SetFormVCS1(aVCS: Cardinal);
    function GetFormVCS2: Cardinal;
    procedure SetFormVCS2(aVCS: Cardinal);
    procedure ChangeFormSignature(aSignature: TwbSignature);
    procedure ClampFormID(aIndex: Cardinal);

    procedure Delete;
    procedure DeleteInto(const aFile: IwbFile);

    function MasterRecordsFromMasterFilesAndSelf: TDynMainRecords;

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
    procedure SaveRefsToStream(aStream: TStream);
    procedure LoadRefsFromStream(aStream: TStream);

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
                             aEndPtr         : Pointer;
                       const aPrevMainRecord : IwbMainRecord); override;
    constructor Create(const aContainer : IwbContainer;
                       const aSignature : TwbSignature;
                             aFormID    : TwbFormID); overload;
    destructor Destroy; override;

    function GetName: string; override;
    function GetShortName: string; override;
    function GetDisplayName: string; override;
  end;

  PwbSubRecordHeaderStruct = ^TwbSubRecordHeaderStruct;
  TwbSubRecordHeaderStruct = packed record
    srsSignature : TwbSignature;
    srsDataSize  : Word;
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

    procedure DoInit; override;
    procedure Init; override;
    procedure Reset; override;

    function GetDataPrefixSize: Integer; override;
    procedure CheckCount;

    function GetName: string; override;
    function GetDisplayName: string; override;

    function IsFlags: Boolean; override;

    function GetValue: string; override;
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
    procedure MasterCountUpdated(aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    procedure SetModified(aValue: Boolean); override;
    function CanContainFormIDs: Boolean; override;
    function CanElementReset: Boolean; override;
    function GetLinksTo: IwbElement; override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    procedure PrepareSave; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;

    procedure SetToDefaultInternal; override;

    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;
    function GetIsInSK(aIndex: Integer): Boolean; override;
    function DoCheckSizeAfterWrite: Boolean; override;

    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;

    function GetDataSize: Integer; override;

    function CanMoveElement: Boolean; override;

    procedure CheckTerminator;

    {--- IwbSubRecord ---}
    function GetSubRecordHeaderSize: Integer;

    {--- IwbSortableContainer ---}
    function GetSorted: Boolean;
  end;

  TwbValueBase = class(TwbDataContainer)
  protected
    vbValueDef   : IwbValueDef;
    vbNameSuffix : string;
  protected
    procedure InitDataPtr; override;

    function GetDef: IwbNamedDef; override;
    function GetValueDef: IwbValueDef; override;

    function GetName: string; override;
    function GetBaseName: string; override;
    function GetDisplayName: string; override;

    function GetCheck: string; override;
    function GetValue: string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;

    function GetIsEditable: Boolean; override;
    function CanElementReset: Boolean; override;

    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;

    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;

    procedure BuildRef; override;
    function CanContainFormIDs: Boolean; override;
    function GetLinksTo: IwbElement; override;
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

  TwbArray = class(TwbValueBase, IwbSortableContainer)
  protected {private}
    arrSorted        : Boolean;
    arrSortInvalid   : Boolean;
    arrSizePrefix    : Integer;
  protected
    procedure DoInit; override;
    procedure Init; override;
    procedure Reset; override;

    function GetElementType: TwbElementType; override;
    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    procedure SetModified(aValue: Boolean); override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;

    procedure PrepareSave; override;
    procedure CheckTerminator;

    function GetDataPrefixSize: Integer; override;
    procedure CheckCount;

    function CanMoveElement: Boolean; override;

    {--- IwbSortableContainer ---}
    function GetSorted: Boolean;
  end;

  TwbStruct = class(TwbValueBase)
  protected
    szCompressedSize   : Integer;
    szUncompressedSize : Cardinal;
    szCompressedType   : TwbStructCompression;
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

  TwbUnion = class(TwbValueBase)
  protected
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    procedure Init; override;
    procedure Reset; override;

    function GetElementType: TwbElementType; override;
    procedure MasterCountUpdated(aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
  end;

  TwbRecordHeaderStruct = class(TwbStruct)
  protected
    function CanContainFormIDs: Boolean; override;
    procedure BuildRef; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    function IsElementEditable(const aElement: IwbElement): Boolean; override;
    function GetIsEditable: Boolean; override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;
  end;

  TwbValue = class(TwbValueBase, IwbSortableContainer)
  protected {private}
    vIsFlags    : Boolean;
  protected
    function GetValue: string; override;
    function CompareExchangeFormID(aOldFormID: TwbFormID; aNewFormID: TwbFormID): Boolean; override;
    procedure MasterCountUpdated(aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;

    function IsFlags: Boolean; override;

    procedure Init; override;
    procedure Reset; override;

    function GetElementType: TwbElementType; override;
    procedure SetEditValue(const aValue: string); override;
    procedure SetNativeValue(const aValue: Variant); override;

    {--- IwbSortableContainer ---}
    function GetSorted: Boolean;
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

  IwbStringListTerminator = interface
    ['{0D8ED4AA-1AFE-4283-87D7-2B66C5496227}']
  end;

  TwbStringListTerminator = class(TwbElement, IwbStringListTerminator)
    function GetName: string; override;
    function GetElementType: TwbElementType; override;
    function GetConflictPriority: TwbConflictPriority; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    procedure SetEditValue(const aValue: string); override;
    procedure SetNativeValue(const aValue: Variant); override;
    function GetDataSize: Integer; override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;
    procedure MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
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
    function GetSortKey(aExtended: Boolean): string; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetConflictPriority: TwbConflictPriority; override;
    function GetDontShow: Boolean; override;
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer); override;
    function GetDataSize: Integer; override;
    procedure InvalidateParentStorage; override;

    function GetIsEditable: Boolean; override;
    function GetIsRemoveable: Boolean; override;

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
    procedure Sort;
    procedure SetModified(aValue: Boolean);
  end;

  TwbGroupState = (
    gsSorted,
    gsSorting,
    gsSortPostponed
  );

  TwbGroupStates = set of TwbGroupState;

  TwbGroupRecord = class(TwbRecord, IwbGroupRecord, IwbGroupRecordInternal)
  protected {private}
    grStates: TwbGroupStates;
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

    function grStruct: PwbGroupRecordStruct; inline;

    function GetCountedRecordCount: Cardinal; override;
    procedure InitDataPtr; override;
    procedure ScanData; override;
    procedure InformPrevMainRecord(const aPrevMainRecord : IwbMainRecord); override;

    function GetName: string; override;
    function GetShortName: string; override;
    function GetElementType: TwbElementType; override;
    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    procedure Remove; override;
    procedure NotifyChangedInternal(aContainer: Pointer); override;

    function GetAddList: TDynStrings; override;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;
    procedure Sort;

    procedure UpdatedEnded; override;

    procedure SetModified(aValue: Boolean); override;

    procedure PrepareSave; override;
    procedure WriteToStreamInternal(aStream: TStream; aResetModified: Boolean); override;
    procedure MasterCountUpdated(aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(const aOld, aNew: TwbFileIDs); override;
    procedure FindUsedMasters(aMasters: PwbUsedMasters); override;

    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;

    procedure MakeHeaderWriteable;

    procedure BuildRef; override;
    function LinksToParent: Boolean; override;
    function Reached: Boolean; override;

    function FindChildGroup(aType: Integer; aMainRecord: IwbMainRecord): IwbGroupRecord;

    function GetMainRecordByEditorID(const aEditorID: string): IwbMainRecord;
    function GetMainRecordByFormID(const aFormID: TwbFormID): IwbMainRecord;

    function GetGroupType: Integer; inline;
    function GetGroupLabel: Cardinal; inline;
    procedure SetGroupLabel(aLabel: Cardinal);
    function GetChildrenOf: IwbMainRecord;

    procedure AddElement(const aElement: IwbElement); override;
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
  protected
    constructor Create(const aOwner     : IwbContainer;
                       const aContainer : IwbContainer;
                             aPos       : Integer;
                       const aDef       : IwbSubRecordArrayDef);

    procedure DoProcess(const aContainer : IwbContainer;
                              aPos       : Integer);

    procedure DoInit; override;

    function GetName: string; override;
    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;
    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    procedure SetModified(aValue: Boolean); override;
    function CanContainFormIDs: Boolean; override;
    function CanElementReset: Boolean; override;
    procedure ElementChanged(const aElement: IwbElement; aContainer: Pointer); override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;

    function CanMoveElement: Boolean; override;

    {---IwbSortableContainer---}
    function GetSorted: Boolean;

    {--- IwbHasSignature ---}
    function GetSignature: TwbSignature;
  end;

  TwbSubRecordStruct = class(TwbContainer, IwbHasSignature)
  protected {private}
    srcDef: IwbRecordDef;
  protected
    constructor Create(const aOwner     : IwbContainer;
                       const aContainer : IwbContainer;
                             aPos       : Integer;
                       const aDef       : IwbSubRecordStructDef);

    procedure AddRequiredElements;
    function Add(const aName: string; aSilent: Boolean): IwbElement; override;

    function GetSortKeyInternal(aExtended: Boolean): string; override;
    function GetName: string; override;
    function GetDef: IwbNamedDef; override;
    function GetElementType: TwbElementType; override;
    function IsElementRemoveable(const aElement: IwbElement): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    function CanElementReset: Boolean; override;
    function RemoveInjected(aCanRemove: Boolean): Boolean; override;

    function CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean; override;
    function AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement; override;
    function AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement; override;
    function GetIsInSK(aIndex: Integer): Boolean; override;

    {--- IwbHasSignature ---}
    function GetSignature: TwbSignature;
  end;

const
  NONE : TwbSignature = #0#0#0#0;

function CompareFormIDs(Item1, Item2: Pointer): Integer;
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
  xor rax, rax
  cmp rcx, rdx
  ja @@GT
  je @@EQ
@@LT:
  dec rax
  dec rax
@@GT:
  inc rax
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
    SortKey1 := IwbElement(Item1).Value;
    SortKey2 := IwbElement(Item1).Value;

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

procedure TwbFile.AddMaster(const aFileName: string; IsTemporary: Boolean);
var
  _File : IwbFile;
  s     : string;
  t     : string;
  i     : Integer;
begin
  if not wbRequireLoadorder and IsTemporary then begin
    for i := 0 to Pred(GetMasterCount) do
      if SameText(ExtractFileName(aFileName), GetMaster(i).FileName) then
        Exit;
  end;

  s := ExtractFilePath(aFileName);
  t := ExtractFileName(aFileName);
  if s = '' then
    s := ExtractFilePath(flFileName);
  if s <> '' then
    s := IncludeTrailingPathDelimiter(s);

  flProgress('Adding master "' + t + '"');
  _File := wbFile(s + t, -1, '', IsTemporary, False);
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
    raise Exception.Create('File "'+GetFileName+'" is not editable');

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
    wbMergeSort(@cntElements[1], High(cntElements), CompareSortOrder);
end;

function TwbFile.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  GroupRecord : IwbGroupRecord;
  Dummy       : Integer;
  Signature   : TwbSignature;
  SelfRef     : IwbContainerElementRef;
  i           : Integer;
begin
  if not IsElementEditable(nil) then
    raise Exception.Create('File "'+GetFileName+'" is not editable');

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
      wbMergeSort(@cntElements[1],  High(cntElements), CompareSortOrder);
  end;

  if aDeepCopy then
    for i := 0 to Pred(GroupRecord.ElementCount) do
      Result.AddIfMissing(GroupRecord.Elements[i], aAsNew, True, aPrefixRemove, aPrefix, aSuffix);
end;

procedure TwbFile.AddMainRecord(const aRecord: IwbMainRecord);
const
  MGEF      : TwbSignature = 'MGEF';
  GMST      : TwbSignature = 'GMST';
var
  FormID    : TwbFormID;
  s         : string;
  i         : Integer;
  Master    : IwbMainRecord;
  FileID    : Byte;
  Signature : TwbSignature;
begin
  if not Assigned(aRecord) then
    Exit;
  FormID := aRecord.FormID;
  if not FormID.IsNull then begin

    if flFormIDsSorted then begin

      if Length(flRecords) > 0 then begin
        if FindFormID(FormID, i) then
          raise Exception.Create('Duplicate FormID ['+FormID.ToString(True)+'] in file ' + GetName);
      end else
        i := 0;

      SetLength(flRecords, Succ(Length(flRecords)));
      if i < High(flRecords) then begin
        Move(flRecords[i], flRecords[Succ(i)], SizeOf(Pointer) * (High(flRecords) - i));
        Pointer(flRecords[i]) := nil;
      end;
      flRecords[i] := aRecord;

    end else begin

      if flRecordsCount >= Length(flRecords) then
        SetLength(flRecords, Succ(flRecordsCount));

      flRecords[flRecordsCount] := aRecord;
      Inc(flRecordsCount);

    end;

    FileID := FormID.FileID.FullSlot;
    if FileID >= Cardinal(GetMasterCount) then begin

      if (FormID.ToCardinal and $00FFF000) <> 0 then begin
        Exclude(flStates, fsPseudoESLCompatible);
        if wbHasProgressCallback then
          if GetIsESL or flLoadOrderFileID.IsLightSlot then
              wbProgressCallback('<Error: ' + aRecord.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for a light module. You will not be able to save this file with ESL flag active.>');
      end;

      {new record...}
    end else try
      Master := GetMasterRecordByFormID(FormID, True);
      if Assigned(Master) then
        (Master as IwbMainRecordInternal).AddOverride(aRecord)
      else
        (GetMaster(FileID) as IwbFileInternal).InjectMainRecord(aRecord);
    except
      on E: Exception do
        if wbHasProgressCallback then
          wbProgressCallback('Error: <'+e.Message+'> while trying to determine master record for ' + aRecord.Name);
    end;
  end;

  if flFormIDsSorted then
    Exit;

  Signature := aRecord.Signature;

  if (Cardinal(Signature) = Cardinal(MGEF)) or (Cardinal(Signature) = Cardinal(GMST)) or wbTrackAllEditorID then begin
    s := aRecord.EditorID;
    if s <> '' then begin
      if flRecordsByEditorIDCount >= Length(flRecordsByEditorID) then
        SetLength(flRecordsByEditorID, Succ(flRecordsByEditorIDCount));

      flRecordsByEditorID[flRecordsByEditorIDCount] := aRecord;
      Inc(flRecordsByEditorIDCount);
    end;
  end;
end;

procedure TwbFile.AddMaster(const aFile: IwbFile);
begin
  SetLength(flMasters, Succ(Length(flMasters)));
  flMasters[High(flMasters)] := aFile;
  UpdateModuleMasters;
end;

procedure TwbFile.AddMasterIfMissing(const aMaster: string);
var
  i       : Integer;
  Masters : TStringList;
begin
  for i := 0 to Pred(GetMasterCount) do
    if SameText(aMaster, GetMaster(i).FileName) then
      Exit;
  Masters := TStringList.Create;
  try
    Masters.Add(aMaster);
    AddMasters(Masters);
    SortMasters;
  finally
    Masters.Free;
  end;
end;

procedure TwbFile.AddMasters(aMasters: TStrings);
var
  OldMasterCount : Integer;
  Header         : IwbContainerElementRef;
  MasterFiles    : IwbContainerElementRef;
  IsNew          : Boolean;
  rec            : IwbRecord;
  i, j           : Integer;
  NotAllAdded    : Boolean;
  MaxMasterCount : Integer;
begin
  NotAllAdded := False;
  OldMasterCount := GetMasterCount;

  if not IsElementEditable(nil) then
    raise Exception.Create('File "'+GetFileName+'" is not editable');

  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbContainerElementRef, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  IsNew := False;
  MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
  if not Assigned(MasterFiles) then begin
    Header.Assign(5, nil, False);
    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    Assert(Assigned(MasterFiles));
    IsNew := True;
  end;

  if wbIsEslSupported or wbPseudoESL then
    MaxMasterCount := $FD
  else
    MaxMasterCount := $FF;

  for i := 0 to Pred(aMasters.Count) do begin
    if GetMasterCount >= MaxMasterCount then begin
      NotAllAdded := True;
      Break;
    end;
    if IsNew then begin
      Assert(MasterFiles.ElementCount = 1);
      Rec := (MasterFiles[0] as IwbContainer).RecordBySignature['MAST'];
      IsNew := False;
    end else begin
      j := MasterFiles.ElementCount;
      MasterFiles.Assign(High(Integer), nil, False);
      Assert(MasterFiles.ElementCount = Succ(j));
      Rec := (MasterFiles[j] as IwbContainer).RecordBySignature['MAST'];
    end;

    Assert(Assigned(Rec));
    Assert(Rec.EditValue = '');

    Rec.EditValue := aMasters[i];
    AddMaster(aMasters[i]);
  end;

  if OldMasterCount <> GetMasterCount then begin
    MasterCountUpdated(OldMasterCount, GetMasterCount);
    SortRecords;
  end;

  if NotAllAdded then
    raise Exception.Create('Only '+IntToStr(GetMasterCount - OldMasterCount)+' of '+IntToStr(aMasters.Count)+' masters could be added. Master list now contains '+IntToStr(GetMasterCount)+' entries and is full.');
end;

function TwbFile.BuildOrLoadRef(aOnlyLoad: Boolean): TwbBuildOrLoadRefResult;
var
  CachePath     : string;
  CacheFileName : string;
  FileStream    : TBufferedFileStream;
  i, j          : Integer;
  StartTime,
  EndTime       : TDateTime;
begin
  Result := blrNone;
  if not wbDontCache and (not (fsRefsBuild in flStates)) and ((not (esModified in eStates) or (esInternalModified in eStates))) then begin
    CacheFileName := ExtractFileName(flFileName);
    if CacheFileName.EndsWith('.ghost', True) then
      SetLength(CacheFileName, Length(CacheFileName) - Length('.ghost'));
    CacheFileName :=
            wbCachePath +
            IntToHex64(wbCRC32App, 8) +
      '_' + ChangeFileExt(CacheFileName, '') +
      '_' + Copy(ExtractFileExt(CacheFileName), 2) +
      '_' + IntToHex64(GetCRC32, 8) +
      '.refcache';
    if not wbDontCacheLoad and FileExists(CacheFileName) then begin
      Include(flStates, fsRefsBuild);
      FileStream := TBufferedFileStream.Create(CacheFileName, fmOpenRead or fmShareDenyWrite);
      try
        FileStream.Read(flRecordsCount, SizeOf(flRecordsCount));
        Assert(flRecordsCount=Length(flRecords));
        for i := 0 to Pred(flRecordsCount) do
          (flRecords[i] as IwbMainRecordInternal).LoadRefsFromStream(FileStream);
      finally
        FileStream.Free;
      end;
      inherited BuildRef;
      Result := blrLoaded;
    end else begin
      if not aOnlyLoad then begin
        Include(flStates, fsRefsBuild);
        StartTime := Now;
        inherited BuildRef;
        EndTime := Now;
        Result := blrBuilt;
        if not wbDontCacheSave then begin
          flRecordsCount := Length(flRecords);
          if (flRecordsCount > wbCacheRecordsThreshold) or (EndTime - StartTime > wbCacheTimeThreshold) then try
            FileStream := TBufferedFileStream.Create(CacheFileName, fmCreate);
            try
              FileStream.Write(flRecordsCount, SizeOf(flRecordsCount));
              for i := 0 to Pred(flRecordsCount) do
                (flRecords[i] as IwbMainRecordInternal).SaveRefsToStream(FileStream);
            finally
              FileStream.Free;
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
  Group : IwbGroupRecord;
  i     : Integer;
  Rec   : IwbMainRecord;
  Cnt   : IwbContainerElementRef;
  Cnt2  : IwbContainerElementRef;
  Flg   : IwbElement;
  s     : string;
begin
  Assert(Length(cntElements) > 0);
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
              if (Integer(Cnt.NativeValue) and 1) <> 0 then
                (Rec as IwbElementInternal).Reached;
            end;
          end;
        end;

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
                  (Rec as IwbElementInternal).Reached;
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
          if Supports(Cnt.RecordBySignature['DATA'], IwbContainerElementRef, Cnt) then begin
            Flg := Cnt.Elements[0];
            if Assigned(Flg) then begin
              s := Flg.EditValue;
              if (Length(s) > 0) and (s[1]='1') then
                (Rec as IwbElementInternal).Reached;
            end;
          end;
        end;
      end;
end;

procedure TwbFile.BuildRef;
begin
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
    raise Exception.Create('File "'+GetFileName+'" is not editable');
  if (GetElementCount < 1) or not Supports(GetElement(0), IwbContainerElementRef, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Length(flMasters) >= 1 then begin
    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    Assert(Assigned(MasterFiles));
    Assert(MasterFiles.ElementCount = Length(flMasters));

    for i := Low(flMasters) to High(flMasters) do begin
      Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
      Assert(Assigned(Rec));
      Assert(SameText(Rec.Value, flMasters[i].FileName));
      MasterFiles[i].SortOrder := i;
    end;

    FillChar(UsedMasters, SizeOf(UsedMasters), 0);
    FindUsedMasters(@UsedMasters);

    Old := nil;
    New := nil;
    j := 0;
    for i := Low(flMasters) to High(flMasters) do
      if UsedMasters[i] then begin
        if i <> j then begin
          flMasters[j] := flMasters[i];

          MasterFiles[i].SortOrder := j;
          SetLength(Old, Succ(Length(Old)));
          Old[High(Old)] := TwbFileID.Create(i);
          SetLength(New, Succ(Length(New)));
          New[High(New)] := TwbFileID.Create(j);
        end;
        Inc(j);
      end else
        MasterFiles[i].SortOrder := $100;

    k := Length(flMasters);
    if j <> k then begin
      SetLength(flMasters, j);

      (MasterFiles as IwbContainerInternal).SortBySortOrder;
      for i := Pred(MasterFiles.ElementCount) downto 0 do
        if MasterFiles[i].SortOrder = $100 then
          MasterFiles.RemoveElement(i);

      Assert(Length(flMasters) = MasterFiles.ElementCount);

      for i := Low(flMasters) to High(flMasters) do begin
        Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
        Assert(Assigned(Rec));
        Assert(SameText(Rec.Value, flMasters[i].FileName));
      end;

      if Length(Old) > 0 then
        MasterIndicesUpdated(Old, New);
      MasterCountUpdated(k, j);
      SortRecords;
    end;
  end;

  UpdateModuleMasters;
end;

constructor TwbFile.Create(const aFileName: string; aLoadOrder: Integer; aCompareTo: string; aOnlyHeader: Boolean; IsTemporary: Boolean = False);
begin
  flLoadOrderFileID := TwbFileID.Create(-1, -1);
  if IsTemporary then
    Include(flStates, fsIsTemporary);
  if aCompareTo <> '' then begin
    Include(flStates, fsIsCompareLoad);
    if SameText(ExtractFileName(aFileName), wbGameName + wbHardcodedDat) then
      Include(flStates, fsIsHardcoded);
    flCompareTo := wbExpandFileName(aCompareTo);
  end else if SameText(ExtractFileName(aFileName), wbGameName + '.esm') then
    Include(flStates, fsIsGameMaster);
  if aOnlyHeader then
    Include(flStates, fsOnlyHeader);

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

  flOpenFile;
  Scan;
end;

var
  _NextFullSlot: Integer;
  _NextLightSlot: Integer;
  Files : array of IwbFile;
  FilesMap: TStringList;

constructor TwbFile.CreateNew(const aFileName: string; aLoadOrder: Integer; aIsESl: Boolean);
var
  Header : IwbMainRecord;
begin
  flLoadOrderFileID := TwbFileID.Create(-1, -1);
  Include(flStates, fsIsNew);
  flLoadOrder := aLoadOrder;
  flFileName := aFileName;
  flFileNameOnDisk := flFileName;
  flModule := wbModuleByName(GetFileName);
  if not flModule.IsValid then
    flModule := nil;
  if not Assigned(flModule) then
    flModule := TwbModuleInfo.AddNewModule(GetFileName, False);

  Header := TwbMainRecord.Create(Self, wbHeaderSignature, TwbFormID.Null);
  if wbGameMode = gmFNV then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.34'
  else if wbGameMode = gmFO3 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '0.94'
  else if wbGameMode = gmTES3 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.30'
  else if wbGameMode = gmTES4 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.0'
  else if wbIsSkyrim then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.7'
  else if wbIsFallout4 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '0.95';
  Header.RecordBySignature['HEDR'].Elements[2].EditValue := '$800';

  if aIsESL then begin
    Header.IsESL := True;
    Include(flModule.miFlags, mfHasESLFlag);
  end;

  flLoadFinished := True;
  flFormIDsSorted := True;

  if flLoadOrder >= 0 then begin
    if wbIsEslSupported or wbPseudoESL then begin
      if Header.IsESL and not wbIgnoreESL then begin
        if _NextLightSlot > $FFF then
          raise Exception.Create('Too many light modules');
        flLoadOrderFileID := TwbFileID.Create($FE, _NextLightSlot);
        Inc(_NextLightSlot);
      end else begin
        if _NextFullSlot >= $FE then
          raise Exception.Create('Too many full modules');
        flLoadOrderFileID := TwbFileID.Create(_NextFullSlot);
        Inc(_NextFullSlot);
      end;
    end else
      flLoadOrderFileID := TwbFileID.Create(flLoadOrder);

    if Assigned(flModule) and not Assigned(flModule.miFile) then begin
      flModule.miFile := Self;
      flModule.miLoadOrder := flLoadOrder;
      flModule.miFileID := flLoadOrderFileID;
      Include(flModule.miFlags, mfHasFile);
      Include(flModule.miFlags, mfLoaded);
    end;
  end;
end;

constructor TwbFile.CreateNew(const aFileName: string; aLoadOrder: Integer; aTemplate: PwbModuleInfo);
var
  Header : IwbMainRecord;
  i      : Integer;
begin
  flLoadOrderFileID := TwbFileID.Create(-1, -1);
  Include(flStates, fsIsNew);
  flLoadOrder := aLoadOrder;
  flFileName := aFileName;
  flFileNameOnDisk := flFileName;
  flModule := wbModuleByName(GetFileName);
  if not flModule.IsValid then
    flModule := nil;
  if not Assigned(flModule) then
    flModule := TwbModuleInfo.AddNewModule(GetFileName, False);

  Header := TwbMainRecord.Create(Self, wbHeaderSignature, TwbFormID.Null);
  if wbGameMode = gmFNV then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.34'
  else if wbGameMode = gmFO3 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '0.94'
  else if wbGameMode = gmTES3 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.30'
  else if wbGameMode = gmTES4 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.0'
  else if wbIsSkyrim then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '1.7'
  else if wbIsFallout4 then
    Header.RecordBySignature['HEDR'].Elements[0].EditValue := '0.95';
  Header.RecordBySignature['HEDR'].Elements[2].EditValue := '$800';

  if mfHasESLFlag in aTemplate.miFlags then begin
    Header.IsESL := True;
    Include(flModule.miFlags, mfHasESLFlag);
  end;

  if mfHasESMFlag in aTemplate.miFlags then begin
    Header.IsESM := True;
    Include(flModule.miFlags, mfHasESMFlag);
  end;

  if mfIsESM in aTemplate.miFlags then
    Include(flModule.miFlags, mfIsESM);

  flLoadFinished := True;
  flFormIDsSorted := True;

  if flLoadOrder >= 0 then begin
    if wbIsEslSupported or wbPseudoESL then begin
      if Header.IsESL and not wbIgnoreESL then begin
        if _NextLightSlot > $FFF then
          raise Exception.Create('Too many light modules');
        flLoadOrderFileID := TwbFileID.Create($FE, _NextLightSlot);
        Inc(_NextLightSlot);
      end else begin
        if _NextFullSlot >= $FE then
          raise Exception.Create('Too many full modules');
        flLoadOrderFileID := TwbFileID.Create(_NextFullSlot);
        Inc(_NextFullSlot);
      end;
    end else
      flLoadOrderFileID := TwbFileID.Create(flLoadOrder);

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

function TwbFile.FileFileIDtoLoadOrderFileID(aFileID: TwbFileID): TwbFileID;
begin
  if aFileID.FullSlot >= GetMasterCount then begin
    Result := flLoadOrderFileID;
    if Result.FullSlot < 0 then
      raise Exception.Create('File has no slot assigned');
  end else
    Result := flMasters[aFileID.FullSlot].LoadOrderFileID;
end;

function TwbFile.FileFormIDtoLoadOrderFormID(aFormID: TwbFormID): TwbFormID;
begin
  Result := aFormID;
  if aFormID.IsNull then
    Exit;
  Result.FileID := FileFileIDtoLoadOrderFileID(Result.FileID);
end;

function TwbFile.FindEditorID(const aEditorID: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if not flLoadFinished then
    Exit;

  L := Low(flRecordsByEditorID);
  H := High(flRecordsByEditorID);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CompareText(flRecordsByEditorID[I].EditorID, aEditorID);
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

function TwbFile.FindFormID(aFormID: TwbFormID; var Index: Integer): Boolean;
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

  i := GetMasterCount;
  if aFormID.FileID.FullSlot > i then
    aFormID.FileID := TwbFileID.Create(i);

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
  Index := L;
end;

function TwbFile.FindInjectedID(aFormID: TwbFormID; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  aFormID.FileID := TwbFileID.Create(0);

  L := Low(flInjectedRecords);
  H := High(flInjectedRecords);
  while L <= H do begin
    I := (L + H) shr 1;
    C := TwbFormID.Compare(flInjectedRecords[I].FormID.ChangeFileID(TwbFileID.Create(0)), aFormID);
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

procedure TwbFile.flCloseFile;
begin
  if fsMemoryMapped in flStates then begin
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
      flProgress('Could not delete temporary file '+flFileNameOnDisk);
    end;
  end else
    if Assigned(flView) then begin
      VirtualFree(flView, 0 , MEM_RELEASE);
      flView := nil;
    end;
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

  if not FileExists(flFileName) then begin
    s := flFileName + '.ghost';
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

    flSize := GetFileSize(flFileHandle, nil);
  end else begin
    with TFileStream.Create(flFileNameOnDisk, fmOpenRead or fmShareDenyWrite) do try
      flSize := Size;
      flView := VirtualAlloc(0, flSize, MEM_COMMIT, PAGE_READWRITE);
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

  flEndPtr := PByte(flView) + flSize;

  if wbHasProgressCallback then
    flProgress('File loaded (CRC32:'+IntToHex64(GetCRC32,8)+')');
end;

procedure TwbFile.flProgress(const aStatus: string);
begin
  if wbHasProgressCallback then
    wbProgressCallback('['+GetFileName+'] ' + aStatus);
end;

procedure TwbFile.ForceClosed;
var
  i: Integer;
begin
  for i := High(flRecords) downto Low(flRecords) do
    (flRecords[i] as IwbMainRecordInternal).ClearForRelease;
  for i := High(flInjectedRecords) downto Low(flInjectedRecords) do
    (flInjectedRecords[i] as IwbMainRecordInternal).ClearForRelease;
  flMasters                := nil;
  flRecords                := nil;
  flRecordsByEditorID      := nil;
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
  RecordDef   : PwbRecordDef;
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
      if wbFindRecordDef(AnsiString(Strings[i]), RecordDef) then
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

function TwbFile.GetBaseName: string;
begin
  Result := GetFileName;
  if fsIsHardcoded in flStates then
    Result := wbGameName + '.exe';
end;

function TwbFile.GetCRC32: Cardinal;
begin
  Result := flCRC32;
  if Result = 0 then begin
    Result := wbCRC32Ptr(flView, flSize);
    flCRC32 := Result;
  end;
end;

function TwbFile.GetElementType: TwbElementType;
begin
  Result := etFile;
end;

function TwbFile.GetFile: IwbFile;
begin
  Result := Self;
end;

function TwbFile.GetLoadOrderFileID: TwbFileID;
begin
  Result := flLoadOrderFileID;
  if Result.FullSlot < 0 then
    raise Exception.Create('File has no slot assigned');
end;

function TwbFile.GetFileFileID: TwbFileID;
begin
  Result := TwbFileID.Create(GetMasterCount);
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

function TwbFile.GetGroupBySignature(const aSignature: TwbSignature): IwbGroupRecord;
var
  SelfRef: IwbContainerElementRef;
  i: Integer;
begin
  SelfRef := Self;
  DoInit;

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
  DoInit;

  if (Length(cntElements) > 0) and
     (Supports(cntElements[0], IwbMainRecord, Result)) and
     (Result.Signature = wbHeaderSignature) then begin
    {Result already set}
  end else
    Result := nil;
end;

function TwbFile.GetIsEditable: Boolean;
begin
  Result := wbIsInternalEdit or (
        wbEditAllowed and
    ((not (fsIsGameMaster in flStates)) or wbAllowEditGameMaster) and
    not (fsIsHardcoded in flStates) and
    not (fsIsCompareLoad in flStates)
  );
end;

function TwbFile.GetIsESL: Boolean;
var
  Header         : IwbMainRecord;
begin
  if wbPseudoESL then
    Exit(fsPseudoESL in flStates);

  if not wbIsEslSupported or GetIsNotPlugin then
    Exit(False);

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  Result := Header.IsESL;
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
  if (GetElementCount > 0) and Supports(GetElement(0), IwbContainerElementRef, Header) then begin
    V := Header.ElementNativeValues['HEDR\Next Object ID'];
    i := V;
    Result := i;
  end else
    Result := 0;
end;

procedure TwbFile.SetNextObjectID(aObjectID: Cardinal);
var
  Header         : IwbMainRecord;
begin
  if (GetElementCount > 0) and Supports(GetElement(0), IwbContainerElementRef, Header) then
    Header.ElementNativeValues['HEDR\Next Object ID'] := aObjectID;
end;

function TwbFile.GetIsNotPlugin: Boolean;
begin
  Result := not wbIsPlugin(flFileName);
end;

function TwbFile.GetIsRemoveable: Boolean;
begin
  Result := False;
end;

function TwbFile.GetLoadOrder: Integer;
begin
  Result := flLoadOrder;
end;

function TwbFile.GetMaster(aIndex: Integer): IwbFile;
begin
  Result := flMasters[aIndex];
end;

function TwbFile.GetMasterCount: Integer;
begin
  Result := Length(flMasters);
end;

function TwbFile.GetMasterRecordByFormID(aFormID: TwbFormID; aAllowInjected: Boolean): IwbMainRecord;
var
  FileID : Integer;
  Master : IwbFile;
begin
  FileID := aFormID.FileID.FullSlot;
  if FileID >= GetMasterCount then begin
    Result := nil;
  end else begin
    Master := flMasters[FileID];
    Result := Master.RecordByFormID[aFormID.ChangeFileID(Master.FileFileID), aAllowInjected];
  end;
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
      raise Exception.CreateFmt('Expected header signature '+wbHeaderSignature+', found %s in file "%s"', [String(Header.Signature), flFileName]);

    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    if Assigned(MasterFiles) then
      for i := 0 to Pred(MasterFiles.ElementCount) do begin
        Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
        if not Assigned(Rec) then
          raise Exception.CreateFmt('Unexpected error reading master list for file "%s"', [flFileName]);
        aMasters.Add(Rec.Value);
      end;
  end else
    for i := Low(flMasters) to High(flMasters) do
      aMasters.AddObject(flMasters[i].FileName, Pointer(flMasters[i]));
end;

function TwbFile.GetModuleInfo: Pointer;
begin
  Result := flModule;
end;

function TwbFile.GetName: string;
var
  s: string;
begin
  Result := GetFileName;
  if fsIsHardcoded in flStates then
    Result := wbGameName + '.exe';
  if flLoadOrderFileID.FullSlot >= 0 then
    Result := '['+flLoadOrderFileID.ToString+'] ' + Result;
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
  if FindEditorID(aEditorID, i) then
    Result := flRecordsByEditorID[i]
  else
    for i := Pred(GetMasterCount) downto 0 do begin
      Result := GetMaster(i).RecordByEditorID[aEditorID];
      if Assigned(Result) then
        Exit;
    end;
end;

function TwbFile.GetRecordByFormID(aFormID: TwbFormID; aAllowInjected: Boolean): IwbMainRecord;
var
  i: Integer;
begin
  if FindFormID(aFormID, i) then begin
    Result := flRecords[i];
    Exit;
  end else if aAllowInjected and (aFormID.FileID.FullSlot >= GetMasterCount) and FindInjectedID(aFormID, i) then begin
    Result := flInjectedRecords[i];
    Exit;
  end;

  Result := GetMasterRecordByFormID(aFormID, aAllowInjected);
end;

function TwbFile.GetRecordCount: Integer;
begin
  Result := Length(flRecords);
end;

function TwbFile.GetReferenceFile: IwbFile;
begin
  Result := Self;
end;

function TwbFile.GetUnsavedSince: TDateTime;
begin
  Result := flUnsavedSince;
end;

function TwbFile.HasGroup(const aSignature: TwbSignature): Boolean;
begin
  Result := GetGroupBySignature(aSignature) <> nil;
end;

function TwbFile.HasMaster(const aFileName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Pred(GetMasterCount) do begin
    Result := SameText(GetMaster(i).FileName, aFileName);
    if Result then
      Exit;
  end;
end;

procedure TwbFile.InjectMainRecord(const aRecord: IwbMainRecord);
var
  i: Integer;
begin
  if Length(flInjectedRecords) > 0 then begin
    if FindInjectedID(aRecord.FormID, i) then begin
      if [fsIsHardcoded, fsIsCompareLoad] * flInjectedRecords[i]._File.FileStates = [] then begin
        if wbHasProgressCallback then
          wbProgressCallback('<Warning: ' + aRecord.Name + ' was injected into ' + GetFileName + ' which already has been injected with '+flInjectedRecords[i].Name+' from '+flInjectedRecords[i]._File.FileName+' >');
      end;
      (flInjectedRecords[i] as IwbMainRecordInternal).AddOverride(aRecord);
      Exit;
    end
  end else
    i := 0;

  if [fsIsHardcoded, fsIsCompareLoad] * aRecord._File.FileStates = [] then begin
    if wbHasProgressCallback then
      wbProgressCallback('<Note: ' + aRecord.Name + ' was injected into ' + GetFileName + '>');
  end;

  SetLength(flInjectedRecords, Succ(Length(flInjectedRecords)));
  if i < High(flInjectedRecords) then begin
    Move(flInjectedRecords[i], flInjectedRecords[Succ(i)], SizeOf(Pointer) * (High(flInjectedRecords) - i));
    Pointer(flInjectedRecords[i]) := nil;
  end;
  flInjectedRecords[i] := aRecord;
end;

function TwbFile.IsElementEditable(const aElement: IwbElement): Boolean;
begin
  Result := wbIsInternalEdit or GetIsEditable;
end;

function TwbFile.IsElementRemoveable(const aElement: IwbElement): Boolean;
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

function TwbFile.LoadOrderFileIDtoFileFileID(aFileID: TwbFileID): TwbFileID;
var
  i         : Integer;
begin
  if aFileID = flLoadOrderFileID then
    Exit(TwbFileID.Create(GetMasterCount))
  else
    for i := Pred(GetMasterCount) downto 0 do
      if flMasters[i].LoadOrderFileID = aFileID then
        Exit(TwbFileID.Create(i));

  raise Exception.Create('Load order FileID ['+aFileID.ToString+'] can not be mapped to file FileID for file "'+GetFileName+'"');
end;

function TwbFile.LoadOrderFormIDtoFileFormID(aFormID: TwbFormID): TwbFormID;
begin
  Result := aFormID;
  if aFormID.IsNull then
    Exit;
  Result.FileID := LoadOrderFileIDtoFileFileID(Result.FileID);
end;

function TwbFile.NewFormID: TwbFormID;
var
  SelfRef      : IwbContainerElementRef;
  FileHeader   : IwbMainRecord;
  HEDR         : IwbRecord;
  NextObjectID : Cardinal;
  First        : TwbFormID;
  IsESL        : Boolean;
  Mask         : Cardinal;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if Length(cntElements) < 1 then
    raise Exception.Create('File '+GetFileName+' has no file header');

  if cntElements[0].ElementType <> etMainRecord then
    raise Exception.Create('File '+GetFileName+' has invalid record '+cntElements[0].Name+' as file header.');

  FileHeader := cntElements[0] as IwbMainRecord;
  if FileHeader.Signature <> wbHeaderSignature then
    raise Exception.Create('File '+GetFileName+' has invalid record '+cntElements[0].Name+' with invalid signature as file header.');

  HEDR := FileHeader.RecordBySignature['HEDR'];
  if not Assigned(HEDR) then
    raise Exception.Create('File '+GetFileName+' has a file header with missing HEDR subrecord');

  IsESL := GetIsESL or flLoadOrderFileID.IsLightSlot;
  if IsESL then
    Mask := $FFF
  else
    Mask := $FFFFFF;

  NextObjectID := StrToInt64Def(HEDR.Elements[2].EditValue, $800) and Mask;

  if (NextObjectID = 0) or (NextObjectID = Mask) then
    NextObjectID := StrToInt64Def(HEDR.Elements[1].EditValue, $800) and Mask;

  if NextObjectID < $800 then
    NextObjectID := $800;

  Result := TwbFormID.FromCardinal(NextObjectID).ChangeFileID(GetFileFileID);
  First := Result;
  while GetRecordByFormID(Result, True) <> nil do begin
    Inc(NextObjectID);
    if NextObjectID > Mask then
      NextObjectID := $800;
    Result := TwbFormID.FromCardinal(NextObjectID).ChangeFileID(GetFileFileID);
    if Result = First then //we've gone through all possible FormIDs once, no more space free
      raise ERangeError.Create('File '+GetFileName+' has no more space for a new FormID');
  end;

  Inc(NextObjectID);
  if NextObjectID > Mask then
    NextObjectID := $800;

  HEDR.Elements[2].EditValue := IntToStr(NextObjectID);
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
  FileID: Cardinal;
  Signature : TwbSignature;
  Master : IwbMainRecord;
  FileFileID: TwbFileID;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if Length(cntElements) < 1 then
    raise Exception.Create('File '+GetFileName+' has no file header');

  if not GetIsNotPlugin then begin
    if cntElements[0].ElementType <> etMainRecord then
      raise Exception.Create('File '+GetFileName+' has invalid record '+cntElements[0].Name+' as file header.');

    FileHeader := cntElements[0] as IwbMainRecord;
    if FileHeader.Signature <> wbHeaderSignature then
      raise Exception.Create('File '+GetFileName+' has invalid record '+cntElements[0].Name+' with invalid signature as file header.');

    HEDR := FileHeader.RecordBySignature['HEDR'];
    if not Assigned(HEDR) then
      raise Exception.Create('File '+GetFileName+' has a file header with missing HEDR subrecord');

    inherited;

    SetLength(Groups, wbGroupOrder.Count);
    for i := Succ(Low(cntElements)) to High(cntElements) do begin
      if not Supports(cntElements[i], IwbGroupRecord, GroupRecord) then
        raise Exception.Create('File '+GetFileName+' contains invalid top level record: '+ cntElements[i].Name);
      if GroupRecord.GroupType <> 0 then
        raise Exception.Create('File '+GetFileName+' contains invalid top level group type '+IntToStr(GroupRecord.GroupType)+' for group: '+ cntElements[i].Name);
      if GroupRecord.SortOrder < 0 then
        raise Exception.Create('File '+GetFileName+' contains top level group without known sort order: '+ cntElements[i].Name);
      if GroupRecord.SortOrder > High(Groups) then
        raise Exception.Create('File '+GetFileName+' contains top level group with invalid sort order: '+ cntElements[i].Name);
      if Groups[GroupRecord.SortOrder] then
        raise Exception.Create('File '+GetFileName+' contains duplicated top level group: '+ cntElements[i].Name);
      Groups[GroupRecord.SortOrder] := True;
    end;

    if Length(cntElements) > 1 then
      wbMergeSort(@cntElements[1],  High(cntElements), CompareSortOrder);

    RecordCount := GetCountedRecordCount;
    if RecordCount < 1 then
      raise Exception.Create('File '+GetFileName+' has an invalid record count');

    HEDR.Elements[1].EditValue := IntToStr(Pred(RecordCount));

    j := 0;
    ONAMs := nil;
    if wbIsSkyrim or wbIsFallout3 or wbIsFallout4 then begin
      Include(TwbMainRecord(FileHeader).mrStates, mrsNoUpdateRefs);
      while FileHeader.RemoveElement('ONAM') <> nil do
        ;
      if Supports(FileHeader.ElementByName['Master Files'], IwbContainerElementRef, MasterFiles) then
        for i := 0 to Pred(MasterFiles.ElementCount) do begin
          if Supports(MasterFiles.Elements[i], IwbContainerElementRef, MasterFile) then begin
            // Fallout 4 CK creates ONAMs in ESP too
            if FileHeader.IsESM or wbIsFallout4 then
              while j <= High(flRecords) do begin
                Current := flRecords[j];
                FormID := Current.FixedFormID;
                FileID := FormID.FileID.FullSlot;
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
                   (wbIsFallout4 and (
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
                      Assert(ONAMs.ElementCount = 1);
                      NewONAM := ONAMs.Elements[0];
                    end else
                      NewONAM := ONAMs.Assign(High(Integer), nil, True);

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
          end;
          if j > High(flRecords) then
            Break;
        end;
      Exclude(TwbMainRecord(FileHeader).mrStates, mrsNoUpdateRefs);
      FileHeader.UpdateRefs;
    end;

    if wbClampFormID then begin
      if Supports(FileHeader.ElementByName['Master Files'], IwbContainerElementRef, MasterFiles) then
        k := MasterFiles.ElementCount
      else
        k := 0;
      for i := Low(flRecords) to High(flRecords) do
        flRecords[i].ClampFormID(k);
    end;

    if GetIsESL then begin
      FileFileID := GetFileFileID;
      for i := High(flRecords) downto Low(flRecords) do begin
        Current := flRecords[i];
        FormID := Current.FixedFormID;
        if FormID.FileID = FileFileID then begin
          if (FormID.ToCardinal and $00FFF000) <> 0 then
            raise Exception.Create('Record ' + Current.Name + ' has invalid ObjectID ' + IntToHex64((FormID.ToCardinal and $00FFFFFF),6) + ' for a light module. You will not be able to save this file with ESL flag active');
        end else
          Break;
      end;
    end;

  end else
    inherited;
end;

function TwbFile.Reached: Boolean;
begin
  Result := False;
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

  end;
end;

procedure TwbFile.RemoveMainRecord(const aRecord: IwbMainRecord);
var
  i      : Integer;
  Master : IwbMainRecord;
  FileID : Byte;
begin
  if not Assigned(aRecord) then
    Exit;
  if not aRecord.FormID.IsNull then begin
    Assert(flLoadFinished);

    if (Length(flRecords) < 1) or not FindFormID(aRecord.FormID, i) then
      raise Exception.Create('Can''t remove FormID ['+aRecord.FormID.ToString(True)+'] from file '+GetName+': FormID not registered');

    flRecords[i] := nil;
    if i < High(flRecords) then begin
      Move(flRecords[Succ(i)], flRecords[i], SizeOf(Pointer) * (High(flRecords) - i));
      Pointer(flRecords[High(flRecords)]) := nil;
    end;
    SetLength(flRecords, Pred(Length(flRecords)));

    FileID := aRecord.FormID.FileID.FullSlot;
    if FileID >= Cardinal(GetMasterCount) then begin
      {record for this file}
    end else try
      Master := GetMasterRecordByFormID(aRecord.FormID, True);
      if Assigned(Master) and ((Master as IwbElement) <> (aRecord as IwbElement)) then
        (Master as IwbMainRecordInternal).RemoveOverride(aRecord)
      else
        (GetMaster(FileID) as IwbFileInternal).RemoveInjectedMainRecord(aRecord);
    except
      on E: Exception do
        if wbHasProgressCallback then
          wbProgressCallback('Error: <'+e.Message+'> while trying to determine master record for ' + aRecord.Name);
    end;
  end;
end;

procedure TwbFile.Scan;
var
  Header      : IwbMainRecord;

  procedure AssignSlot;
  begin
    if flLoadOrderFileID.FullSlot >= 0 then
      Exit;

    if flLoadOrder >= 0 then begin
      if wbIsEslSupported or wbPseudoESL then begin
        if (fsPseudoESL in flStates) or (Header.IsESL and not wbIgnoreESL) then begin
          if _NextLightSlot > $FFF then
            raise Exception.Create('Too many light modules');
          flLoadOrderFileID := TwbFileID.Create($FE, _NextLightSlot);
          Inc(_NextLightSlot);
        end else begin
          if _NextFullSlot >= $FE then
            raise Exception.Create('Too many full modules');
          flLoadOrderFileID := TwbFileID.Create(_NextFullSlot);
          Inc(_NextFullSlot);
        end;
      end else begin
        if flLoadOrder > $FF then
          raise Exception.Create('Too many modules');
        flLoadOrderFileID := TwbFileID.Create(flLoadOrder);
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
  Rec         : IwbRecord;
  i, j        : Integer;
  SelfRef     : IwbContainerElementRef;

  Groups      : array of IwbGroupRecord;
  GroupRecord : IwbGroupRecord;

  IsInternal  : Boolean;
begin
  SelfRef := Self as IwbContainerElementRef;
  flProgress('Start processing');

  Include(flStates, fsScanning);
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
        flLoadOrderFileID := TwbFileID.Create($FF);
    end;

    { add required masters BEFORE deciding on the slot }
    MasterFiles := Header.ElementByName['Master Files'] as IwbContainerElementRef;
    if Assigned(MasterFiles) then
      for i := 0 to Pred(MasterFiles.ElementCount) do begin
        Rec := (MasterFiles[i] as IwbContainer).RecordBySignature['MAST'];
        if not Assigned(Rec) then
          raise Exception.CreateFmt('Unexpected error reading master list for file "%s"', [flFileName]);
        AddMaster(Rec.Value);
      end;

    if flCompareTo <> '' then
      AddMaster(flCompareTo);

    if wbPseudoESL then
      Include(flStates, fsPseudoESLCompatible);

    if Header.IsESL then begin
      if wbPseudoESL then
        Include(flStates, fsPseudoESL);
      AssignSlot;
    end;

    flRecordsCount := 0;
    HEDR := Header.RecordBySignature['HEDR'];
    if Assigned(HEDR) then begin
      SetLength(flRecords, StrToInt(HEDR.Elements[1].Value));
    end;

    flProgress('Header processed. Expecting ' + IntToStr(Length(flRecords)) + ' records');

    while NativeUInt(CurrentPtr) < NativeUInt(flEndPtr) do begin
      Rec := TwbRecord.CreateForPtr(CurrentPtr, flEndPtr, Self, nil);
      flProgress(Rec.Name + ' processed');
    end;

    if flRecordsCount < Length(flRecords) then
      SetLength(flRecords, flRecordsCount);

    if fsPseudoESLCompatible in flStates then
      Include(flStates, fsPseudoESL);

    AssignSlot;
  finally
    Include(flStates, fsScanning);
  end;

  flProgress('Building FormID index');
  if flRecordsCount < Length(flRecords) then
    SetLength(flRecords, flRecordsCount);
  SortRecords;
  flProgress('FormID index built');

  flProgress('Building EditorID index');
  if flRecordsByEditorIDCount < Length(flRecordsByEditorID) then
    SetLength(flRecordsByEditorID, flRecordsByEditorIDCount);
  SortRecordsByEditorID;
  flProgress('EditorID index built');

  if wbIsSkyrim or wbIsFallout3 or wbIsFallout4 then begin
    IsInternal := not GetIsEditable and wbBeginInternalEdit(True);
    try
      SetLength(Groups, wbGroupOrder.Count);
      for i := High(cntElements) downto Succ(Low(cntElements)) do begin
        if not Supports(cntElements[i], IwbGroupRecord, GroupRecord) then begin
          flProgress('Error: File contains invalid top level record: '+ cntElements[i].Name);
          Continue;
        end;
        if GroupRecord.GroupType <> 0 then begin
          flProgress('Error: File contains invalid top level group type '+IntToStr(GroupRecord.GroupType)+' for group: '+ cntElements[i].Name);
          Continue;
        end;
        if GroupRecord.SortOrder < 0 then begin
          flProgress('Error: File contains top level group without known sort order: '+ cntElements[i].Name);
          Continue;
        end;
        if GroupRecord.SortOrder > High(Groups) then begin
          flProgress('Error: File contains top level group with invalid sort order: '+ cntElements[i].Name);
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

  flProgress('Processing completed');
  flLoadFinished := True;
end;

procedure TwbFile.SetHasNoFormID(Value: Boolean);
begin
  if Value or GetIsNotPlugin then
    Include(flStates, fsHasNoFormID)
  else
    Exclude(flStates, fsHasNoFormID);
end;

procedure TwbFile.SetIsESL(Value: Boolean);
var
  Header         : IwbMainRecord;
begin
  if not wbIsEslSupported then
    Exit;
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbMainRecord, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Value <> Header.IsESL then begin
    if not IsElementEditable(nil) then
      raise Exception.Create('File "'+GetFileName+'" is not editable');

    Header.IsESL := Value;
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
      raise Exception.Create('File "'+GetFileName+'" is not editable');

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
      raise Exception.Create('File "'+GetFileName+'" is not editable');

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
    raise Exception.Create('File "'+GetFileName+'" is not editable');
  if GetIsNotPlugin then
    Exit;

  if (GetElementCount < 1) or not Supports(GetElement(0), IwbContainerElementRef, Header) then
    raise Exception.CreateFmt('Unexpected error reading file "%s"', [flFileName]);

  if Length(flMasters) > 1 then begin
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
        Assert(SameText(Rec.Value, flMasters[i].FileName));
        OldList.AddObject(flMasters[i].FileName, Pointer(i));
        MasterFiles[i].SortOrder := i;
      end;

      wbMergeSort(@flMasters[0], Length(flMasters), CompareLoadOrder);

      Old := nil;
      New := nil;
      for i := Low(flMasters) to High(flMasters) do begin
        j := Integer(OldList.Objects[OldList.IndexOf(flMasters[i].FileName)]);
        if i <> j then begin
          MasterFiles[j].SortOrder := i;
          SetLength(Old, Succ(Length(Old)));
          Old[High(Old)] := TwbFileID.Create(j);
          SetLength(New, Succ(Length(New)));
          New[High(New)] := TwbFileID.Create(i);
        end;
      end;
      if Length(Old) > 0 then begin
        (MasterFiles as IwbContainerInternal).SortBySortOrder;
        MasterIndicesUpdated(Old, New);
      end;
    finally
      OldList.Free;
    end;
    SortRecords;
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
    wbMergeSort(@SortEntryPtrs[0], Length(SortEntryPtrs), CompareSortEntryPtrs);
    for i := Low(flRecords) to High(flRecords) do
      Pointer(flRecords[i]) := SortEntryPtrs[i].rseMainRecord;
  end;
  flFormIDsSorted := True;
end;

procedure TwbFile.SortRecordsByEditorID;
begin
  if Length(flRecordsByEditorID) > 0 then
    wbMergeSort(@flRecordsByEditorID[0], Length(flRecordsByEditorID), CompareRecordsByEditorID);
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

procedure TwbFile.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  PrepareSave;
  inherited WriteToStreamInternal(aStream, aResetModified);

  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
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
function UnionDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer): TwbUnionFlags; forward;
function ValueDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Boolean; forward;

{ TwbContainer }

function TwbContainer.Add(const aName: string; aSilent: Boolean): IwbElement;
begin
  Result := nil;
end;

procedure TwbContainer.AddElement(const aElement: IwbElement);
begin
  if not Assigned(aElement) then
    Exit;

  SetLength(cntElements, Succ(Length(cntElements)));
  cntElements[High(cntElements)] := aElement as IwbElementInternal;
  cntElements[High(cntElements)].SetContainer(Self);
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
  i: Integer;
  j: Integer;
  k: Integer;
  l: Integer;
  m: Integer;
  n: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;
  m := Low(Integer);
  for l := Low(cntElements) to High(cntElements) do
    if cntElements[l].MemoryOrder > m then
      m := cntElements[l].MemoryOrder;
  for l := Low(cntElements) to High(cntElements) do
    if cntElements[l].MemoryOrder = Low(Integer) then begin
      cntElements[l].MemoryOrder := m + 1;
      Inc(m);
    end;
  m := Low(Integer);
  k := Low(Integer);
  for i := Low(cntElements) to High(cntElements) do begin
    n := k;
    j := High(Integer);
    for l := Low(cntElements) to High(cntElements) do begin
      if (m<cntElements[l].MemoryOrder) and (cntElements[l].MemoryOrder < j) then begin
        k := l;
        j := cntElements[l].MemoryOrder;
      end;
    end;
    Assert(k <= High(cntElements));
    Assert(k >= Low(cntElements));
    Assert(k <> n);
    m := cntElements[k].MemoryOrder;
    cntElements[k].InformStorage(aBasePtr, aEndPtr);
  end;
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
  cntElements[aPosition].SetContainer(Self);
  NotifyChanged(eContainer);
end;

function TwbContainer.IsElementEditable(const aElement: IwbElement): Boolean;
begin
  if Assigned(eContainer) then
    Result := IwbContainer(eContainer).IsElementEditable(Self)
  else
    Result := True;
end;

function TwbContainer.IsElementRemoveable(const aElement: IwbElement): Boolean;
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
end;

function TwbContainer.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Container  : IwbContainer;
  uContainer : IwbContainerElementRef;
  sElement   : IwbElement;
  BasePtr    : Pointer;
  i, j       : Integer;
  SelfRef    : IwbContainerElementRef;
  ValueDef   : IwbValueDef;
  UnionDef   : IwbUnionDef;
  HasMap     : Boolean;
  StructDef  : IwbStructDef;
  OurSize    : Integer;
begin
  Result := nil;

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  DoInit;

  if inherited CanAssignInternal(aIndex, aElement, False) then
    Result := inherited AssignInternal(aIndex, aElement, aOnlySK);

  if (aIndex = Low(Integer)) and (Length(cntElements) > 0) then begin

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
                 Supports(uContainer.GetValueDef, IwbUnionDef, UnionDef) then begin
                if (uContainer.ElementCount = 1) then begin // At this point it is usually the default choice set by default
                  uContainer.RemoveElement(0);
                end;
                if (uContainer.ElementCount = 0) then begin
                  BasePtr := nil;
                  UnionDoInit(UnionDef, uContainer as IwbContainer, BasePtr, nil);
                end;
              end;
              if (not aOnlySK or GetIsInSK(cntElements[j].SortOrder)) then begin
                if cntElements[j].CanAssign(Low(Integer), sElement, False) then
                  cntElements[j].Assign(Low(Integer), sElement, aOnlySK)
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
  Assert(cntElementRefs = 0);
  inherited BeforeDestruction;
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

procedure TwbContainer.BuildRef;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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
  ValueDef  : IwbValueDef;
begin
  Result := False;
  if not wbEditAllowed then
    Exit;

  if not Assigned(aElement) then
    Exit;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  SelfRef := Self as IwbContainerElementRef;

  Result := inherited CanAssignInternal(aIndex, aElement, aCheckDontShow);

  DoInit;

  if not Result and (aIndex = Low(Integer)) and (Length(cntElements) > 0) then begin

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
          cntElements[i].CanAssign(Low(Integer), Container.Elements[i], aCheckDontShow);
        if not Result then
          Exit;
      end;
  end;
end;

function TwbContainer.CanChangeElementMember(const aElement: IwbElement): Boolean;
var
  SubRecordArrayDef : IwbSubRecordArrayDef;
begin
  Result := Supports(GetDef, IwbSubRecordArrayDef, SubRecordArrayDef) and
    Supports(SubRecordArrayDef.Element, IwbSubRecordUnionDef) and
    IsElementEditable(Self);
end;

function TwbContainer.CanMoveElement: Boolean;
begin
  Result := False;
end;

function TwbContainer.CanMoveElementDown(const aElement: IwbElement): Boolean;
var
  i: Integer;
begin
  Result := False;
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
begin
  Result := False;
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
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  Result := False;
  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].CanContainFormIDs then
      Result := cntElements[i].CompareExchangeFormID(aOldFormID, aNewFormID) or Result;
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

procedure TwbContainer.DoInit;
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
  Include(cntStates, csInitializing);
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
    Exclude(cntStates, csInitializing);
  end;
end;

procedure TwbContainer.DoReset(aForce: Boolean);
begin
  if not aForce then begin
    if Length(cntElements) = 0 then
      Exit;
    if not (csInit in cntStates) then
      Exit;
    if esModified in eStates then
      Exit;
    if cntElementRefs > 0 then
      Exit;
    if not CanElementReset then
      Exit;
  end;

  if [csInitializing, csReseting] * cntStates <> [] then
    Exit;

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

procedure TwbContainer.FindUsedMasters(aMasters: PwbUsedMasters);
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  inherited;
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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

function TwbContainer.GetContainerStates: TwbContainerStates;
begin
  Result := cntStates;
end;

function TwbContainer.GetDataSize: Integer;
var
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  DataContainer : IwbDataContainer;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := 0;
  DoInit;
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

  DoInit;
  if not Assigned(cntElements) or (aIndex>=Length(cntElements)) then begin // Using the wrong contained array at the time
    if wbMoreInfoForIndex and (DebugHook <> 0) and wbHasProgressCallback then
      wbProgressCallback('Debugger: ['+ IwbElement(Self).Path +'] Index ' + IntToStr(aIndex) + ' greater than max '+
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
  DoInit;
  Result := nil;
  for i := Low(cntElements) to High(cntElements) do
    if SameText(cntElements[i].Name, aName) then begin
      Result := IInterface(cntElements[i]) as IwbElement;
      Exit;
    end;
  for i := Low(cntElements) to High(cntElements) do
    if SameText(cntElements[i].DisplayName, aName) then begin
      Result := IInterface(cntElements[i]) as IwbElement;
      Exit;
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
  DoInit;

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
  DoInit;
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
  DoInit;
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
  DoInit;
  Dec(aSortOrder, GetAdditionalElementCount);
  Result := nil;
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
  DoInit;
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
  DoInit;

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

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
  DoInit;

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
  DoInit;

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
  DoInit;

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

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
  DoInit;

  Element := ResolveElementName(aName, Name);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Result := Element.SortKey[aExtended]
  else if Supports(Element, IwbContainerElementRef, Container) then
    Result := Container.ElementSortKeys[Name, aExtended];
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
  DoInit;

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

function TwbContainer.GetRecordBySignature(const aSignature: TwbSignature): IwbRecord;
var
  i: integer;
  lRecord: IwbRecord;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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
  DoInit;
  for i := Low(cntElements) to High(cntElements) do
    Inc(Result, cntElements[i].GetCountedRecordCount);
end;

function TwbContainer.GetSortKeyInternal(aExtended: Boolean): string;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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
  DoInit;

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
  DoInit;
  if Length(cntElements) > 0 then
    Result := IInterface(cntElements[High(cntElements)]) as IwbElement
  else
    Result := nil;
end;

procedure TwbContainer.MarkModifiedRecursive;
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].MarkModifiedRecursive;
  inherited;
end;

procedure TwbContainer.MasterCountUpdated(aOld, aNew: Byte);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].CanContainFormIDs then
      cntElements[i].MasterCountUpdated(aOld, aNew);
end;

procedure TwbContainer.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
var
  i       : Integer;
  SelfRef : IwbContainerElementRef;
begin
  inherited;
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  for i := Low(cntElements) to High(cntElements) do
    if cntElements[i].CanContainFormIDs then
      cntElements[i].MasterIndicesUpdated(aOld, aNew);
end;

procedure TwbContainer.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  i: Integer;
  j: Integer;
  k: Integer;
  l: Integer;
  m: Integer;
  n: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;
  If GetElementType in SortedElementTypes then
    begin
      m := Low(Integer);
      for l := Low(cntElements) to High(cntElements) do
        if (cntElements[l].MemoryOrder > m) and not Supports(cntElements[l], IwbStringListTerminator) then
          m := cntElements[l].MemoryOrder;
      for l := Low(cntElements) to High(cntElements) do
        if cntElements[l].MemoryOrder = Low(Integer) then begin
          cntElements[l].MemoryOrder := m + 1;
          Inc(m);
        end;
      for l := Low(cntElements) to High(cntElements) do
        if Supports(cntElements[l], IwbStringListTerminator) then
          cntElements[l].MemoryOrder := m+1;
      m := Low(Integer);
      k := Low(Integer);
      for i := Low(cntElements) to High(cntElements) do begin
        n := k;
        j := High(Integer);
        for l := Low(cntElements) to High(cntElements) do begin
          if (m<cntElements[l].MemoryOrder) and (cntElements[l].MemoryOrder < j) then begin
            k := l;
            j := cntElements[l].MemoryOrder;
          end;
        end;
        Assert(k <= High(cntElements));
        Assert(k >= Low(cntElements));
        if k = n then
          Assert(k <> n);
        m := cntElements[k].MemoryOrder;
        cntElements[k].MergeStorage(aBasePtr, aEndPtr);
      end;
    end
  else
    for l := Low(cntElements) to High(cntElements) do
      cntElements[l].MergeStorage(aBasePtr, aEndPtr);
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
      Exit;
    end;
end;

class function TwbContainer.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TwbContainer(Result).cntElementRefs := 1;
end;

procedure TwbContainer.NextElementMember(const aElement: IwbElement);
var
  ElementIndex      : Integer;
  ElementDef        : IwbRecordMemberDef;
  Element           : IwbElement;
  Container         : IwbContainer;
  SubRecordArrayDef : IwbSubRecordArrayDef;
  SubRecordUnionDef : IwbSubRecordUnionDef;
  RecordDef         : IwbRecordDef;
  i                 : Integer;
begin
  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;
  if not CanChangeElementMember(aElement) then
    Exit;
  if not Supports(GetDef, IwbSubRecordArrayDef, SubRecordArrayDef) or
     not Supports(SubRecordArrayDef.Element, IwbSubRecordUnionDef, SubRecordUnionDef) then
    Exit;
  if not Supports(SubRecordArrayDef.Element, IwbRecordDef, RecordDef) then
    Exit;
  if Supports(aElement.Container, IwbContainer, Container) then begin
    for i := 0 to Pred(RecordDef.MemberCount) do
      if RecordDef.Members[i].Equals(aElement.Def) then
        break;
    if i < RecordDef.MemberCount then begin
      RemoveElement(aElement);
      ElementIndex := (i + 1) mod RecordDef.MemberCount;
      ElementDef := RecordDef.Members[ElementIndex];

      case ElementDef.DefType of
        dtSubRecord:
          Element := TwbSubRecord.Create(Self, ElementDef as IwbSubRecordDef);
        dtSubRecordArray:
          Element := TwbSubRecordArray.Create(Self, nil, Low(Integer), ElementDef as IwbSubRecordArrayDef);
        dtSubRecordStruct:
          Element := TwbSubRecordStruct.Create(Self, nil, Low(Integer), ElementDef as IwbSubRecordStructDef);
      else
        Assert(False);
      end;

      if Assigned(Element) and Assigned(aElement) then try
        Element.Assign(Low(Integer), nil, False);
        if csAsCreatedEmpty in cntStates then
          Exclude(cntStates, csAsCreatedEmpty);
      except
        Element.Container.RemoveElement(Element);
        raise;
      end;
    end;
  end;
end;

procedure TwbContainer.NotifyChangedInternal(aContainer: Pointer);
begin
  if [csInitializing, csReseting] * cntStates <> [] then
    Exit;
  if csAsCreatedEmpty in cntStates then
    Exclude(cntStates, csAsCreatedEmpty);

  inherited;

  if esModified in eStates then
    DoAfterSet(varEmpty, varEmpty);
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
  DoInit;
  for i := High(cntElements) downto Low(cntElements) do
    cntElements[i].PrepareSave;
end;

procedure TwbContainer.PreviousElementMember(const aElement: IwbElement);
var
  ElementIndex      : Integer;
  ElementDef        : IwbRecordMemberDef;
  Element           : IwbElement;
  Container         : IwbContainer;
  SubRecordArrayDef : IwbSubRecordArrayDef;
  SubRecordUnionDef : IwbSubRecordUnionDef;
  RecordDef         : IwbRecordDef;
  i                 : Integer;
begin
  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;
  if not CanChangeElementMember(aElement) then
    Exit;
  if not Supports(GetDef, IwbSubRecordArrayDef, SubRecordArrayDef) or
     not Supports(SubRecordArrayDef.Element, IwbSubRecordUnionDef, SubRecordUnionDef) then
    Exit;
  if not Supports(SubRecordArrayDef.Element, IwbRecordDef, RecordDef) then
    Exit;
  if Supports(aElement.Container, IwbContainer, Container) then begin
    for i := 0 to Pred(RecordDef.MemberCount) do
      if RecordDef.Members[i].Equals(aElement.Def) then
        break;
    if i < RecordDef.MemberCount then begin
      RemoveElement(aElement);
      ElementIndex := (i - 1) mod RecordDef.MemberCount;
      ElementDef := RecordDef.Members[ElementIndex];

      case ElementDef.DefType of
        dtSubRecord:
          Element := TwbSubRecord.Create(Self, ElementDef as IwbSubRecordDef);
        dtSubRecordArray:
          Element := TwbSubRecordArray.Create(Self, nil, Low(Integer), ElementDef as IwbSubRecordArrayDef);
        dtSubRecordStruct:
          Element := TwbSubRecordStruct.Create(Self, nil, Low(Integer), ElementDef as IwbSubRecordStructDef);
      else
        Assert(False);
      end;

      if Assigned(Element) and Assigned(aElement) then try
        Element.Assign(Low(Integer), nil, False);
        if csAsCreatedEmpty in cntStates then
          Exclude(cntStates, csAsCreatedEmpty);
      except
        Element.Container.RemoveElement(Element);
        raise;
      end;
    end;
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
  DoInit;

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
  DoInit;

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
  DoInit;

  Result := GetReferencesInjected;
  if not Result then
    for i := High(cntElements) downto Low(cntElements) do
      if cntElements[i].CanContainFormIDs then begin
        Result := cntElements[i].RemoveInjected(True) or Result;
        if Result and aCanRemove then
          Break;
      end;
  if Result and aCanRemove and GetIsRemoveable then begin
    Result := False;
    Remove;
  end;
end;

procedure TwbContainer.ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  inherited;
  if Recursive or (Initial and not Supports(Self, IwbGroupRecord)) then
    for i := Low(cntElements) to High(cntElements) do
      if cntElements[i].CanContainFormIDs then
        cntElements[i].ReportRequiredMasters(aStrings, aAsNew, Recursive);
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
  NotifyChanged(eContainer);
end;

procedure TwbContainer.Reset;
begin
  { can be overriden }
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
  aRemainingName := '';
  i := Pos('\', aName);
  if i > 0 then begin
    aRemainingName := Copy(aName, Succ(i), High(Integer));
    Delete(aName, i, High(Integer));
  end;
  if aName = '..' then
    Result := GetContainer
  else if (Length(aName) > 0) and (aName[1] = '[') and (aName[Length(aName)] = ']') then begin
    i := StrToIntDef(Copy(aName, 2, Length(aName) - 2), 0);
    Result := GetElement(i);
  end
  else
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
end;

procedure TwbContainer.SetElementEditValue(const aName, aValue: string);
var
  SelfRef   : IwbContainerElementRef;
  Element   : IwbElement;
  Name      : string;
  Container : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  Element := ResolveElementName(aName, Name, True);
  if not Assigned(Element) then
    Exit;

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
  DoInit;

  Element := ResolveElementName(aName, Name, True);
  if not Assigned(Element) then
    Exit;

  if Name = '' then
    Element.NativeValue := aValue
  else if Supports(Element, IwbContainerElementRef, Container) then
    Container.ElementNativeValues[Name] := aValue;
end;

procedure TwbContainer.SetToDefaultInternal;
var
  i         : Integer;
  SelfRef   : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  inherited;

  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].SetToDefault;
end;

procedure TwbContainer.SortBySortOrder;
var
  i, j: Integer;
begin
  SetModified(True);
  i := GetAdditionalElementCount;
  j := Length(cntElements) - i;
  if j > 1 then begin
    wbMergeSort(@cntElements[i], j, CompareSortOrder);
    InvalidateStorage;
  end;
end;

procedure TwbContainer.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
var
  i: Integer;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;
  inherited;
  for i := Low(cntElements) to High(cntElements) do
    cntElements[i].WriteToStream(aStream, aResetModified);

  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
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
                                   aEndPtr         : Pointer;
                             const aPrevMainRecord : IwbMainRecord);
var
  Dummy: Integer;
begin
  inherited Create(aContainer, aBasePtr, aEndPtr, aPrevMainRecord);
  recSkipped := recSkipped or RecordToSkip.Find(GetSignature, Dummy);
  InformPrevMainRecord(aPrevMainRecord);
  ScanData;
end;

class function TwbRecord.CreateForPtr(var aPtr            : Pointer;
                                          aEndPtr         : Pointer;
                                    const aContainer      : IwbContainer;
                                    const aPrevMainRecord : IwbMainRecord)
                                                          : IwbRecord;
begin
  if aContainer.ElementType = etMainRecord then
    Result := TwbSubRecord.Create(aContainer, aPtr, aEndPtr, aPrevMainRecord)
  else
    if PwbSignature(aPtr)^ = 'GRUP' then
      Result := TwbGroupRecord.Create(aContainer, aPtr, aEndPtr, aPrevMainRecord)
    else
      Result := TwbMainRecord.Create(aContainer, aPtr, aEndPtr, aPrevMainRecord);
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

procedure TwbRecord.SortBySortOrder;
begin
  SetModified(True);
  if Length(cntElements) > 1 then begin
    wbMergeSort(@cntElements[1],  High(cntElements), CompareSortOrder);
    InvalidateStorage;
  end;
end;

function TwbRecord.GetSignature: TwbSignature;
begin
  if Assigned(dcBasePtr) then
    Result := PwbSignature(dcBasePtr)^
  else
    Result := NONE;
end;

{ TwbMainRecord }

function TwbMainRecord.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  s         : string;
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
  Group     : IwbGroupRecord;
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

    SelfRef := Group as IwbContainerElementRef;
    Group := nil;
    for i := 0 to Pred(SelfRef.ElementCount) do
      if Supports(SelfRef.Elements[i], IwbGroupRecord, Group) then
        if (Group.GroupType = 9) and (Group.GroupLabel = Self.GetFormID.ToCardinal) then
          Break
        else
          Group := nil;
    if not Assigned(Group) then
      Group := TwbGroupRecord.Create(SelfRef as IwbContainer, 9, Self);

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
    DoInit;

    for i := 0 to Pred(mrDef.MemberCount) do
      if SameText(mrDef.Members[i].Name, aName) or SameText(mrDef.Members[i].DefaultSignature, aName) then begin
        Result := GetElementBySortOrder(i + GetAdditionalElementCount);
        if not Assigned(Result) then begin
          Assign(i, nil, False);
          Result := GetElementBySortOrder(i + GetAdditionalElementCount);
          Assert(Assigned(Result));

          if wbSortSubRecords and (Length(cntElements) > 1) then
            wbMergeSort(@cntElements[0], Length(cntElements), CompareSubRecords);
        end;

        Exit;
      end;
  end;
end;

function TwbMainRecord.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  if GetIsDeleted then
    Exit;

  if Assigned(mrDef) then begin

    SelfRef := Self as IwbContainerElementRef;
    DoInit;

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
        wbMergeSort(@cntElements[0], Length(cntElements), CompareSubRecords);
    end else
      Result.Assign(Low(Integer), aElement, not aDeepCopy);
  end;
end;

procedure TwbMainRecord.AddOverride(const aMainRecord: IwbMainRecord);
begin
  if aMainRecord.Signature <> GetSignature then
    if wbHasProgressCallback then
      wbProgressCallback(Format('Warning: Record %s in file %s is being overridden by record %s in file %s.', [
        '['+ GetSignature + ':' + GetFormID.ToString(True) + ']',
        GetFile.FileName,
        '['+ aMainRecord.Signature + ':' + aMainRecord.FormID.ToString(True) + ']',
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

procedure TwbMainRecord.AddReferencedBy(aMainRecord : IwbMainRecord);
var
  i, j: Integer;
begin
(**)
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
    _ResizeLock.Leave;
  end;
{$ENDIF}
(**)
end;

procedure TwbMainRecord.AddReferencedFromID(aFormID: TwbFormID);
begin
  Assert(mrsBuildingRef in mrStates);

  if aFormID.IsNull then
    Exit;

  Inc(mrTmpRefFormIDHigh);
  if High(mrTmpRefFormIDs) < mrTmpRefFormIDHigh then
    if mrTmpRefFormIDHigh = 0 then
      SetLength(mrTmpRefFormIDs, 64)
    else
      SetLength(mrTmpRefFormIDs, mrTmpRefFormIDHigh * 2);

  mrTmpRefFormIDs[mrTmpRefFormIDHigh] := aFormID;
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

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  if GetIsDeleted then
    Exit;

  if Assigned(mrDef) then begin

    wbBeginKeepAlive;
    try
      SelfRef := Self as IwbContainerElementRef;
      DoInit;

      if aIndex = Low(Integer) then begin

        NeedUpdate := CheckChildOfCell;

        SetModified(True);
        InvalidateStorage;
        ReleaseElements;

        if Assigned(aElement) then begin
          Container := aElement as IwbContainerElementRef;

          if Supports(aElement, IwbMainRecord, MainRecord) then begin
            MakeHeaderWriteable;
            with TwbMainRecord(MainRecord.ElementID) do begin
              Self.mrStruct.mrsFlags := mrStruct.mrsFlags;
              Self.mrStruct.mrsVCS1 := DefaultVCS1;
              if wbIsSkyrim or wbIsFallout3 or wbIsFallout4 then begin
                Self.mrStruct.mrsVersion := mrStruct.mrsVersion;
                Self.mrStruct.mrsVCS2 := DefaultVCS2; //mrStruct.mrsVCS2;
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
            Assign(Element.SortOrder, Element, aOnlySK);
          end;
        end else begin
          for i := 0 to Pred(mrDef.MemberCount) do
            if mrDef.Members[i].Required then
              Assign(i, nil, False);
        end;

        if NeedUpdate then
          UpdateCellChildGroup;

        CollapseStorage;

      end else begin
        if (aIndex >= 0) and (aIndex < mrDef.MemberCount) then begin
          Member := mrDef.Members[aIndex];
          IsAdd := not Assigned(aElement) or Member.CanAssign(Self, Low(Integer), aElement.Def);
          IsAddChild := not IsAdd and Assigned(aElement) and Member.CanAssign(Self, High(Integer), aElement.Def);
          if IsAdd or IsAddChild then begin
            Element := GetElementBySortOrder(aIndex + GetAdditionalElementCount);
            if Assigned(Element) then begin
              if IsAdd and Assigned(aElement) then
                Element.Assign(Low(Integer), aElement, aOnlySK)
              else if IsAddChild then
                Element.Assign(High(Integer), aElement, aOnlySK);
            end else begin

              if Member.DefType = dtSubRecordUnion then begin
                if Assigned(aElement) then begin
                  Supports(aElement, IwbDataContainer, DataContainer);
                  Member := (Member as IwbRecordDef).GetMemberFor((aElement as IwbHasSignature).Signature, DataContainer);
                end else
                  Member := (Member as IwbRecordDef).Members[0];
                Assert(Assigned(Member));
              end;

              case Member.DefType of
                dtSubRecord:
                  Element := TwbSubRecord.Create(Self, Member as IwbSubRecordDef);
                dtSubRecordArray:
                  Element := TwbSubRecordArray.Create(Self, nil, Low(Integer), Member as IwbSubRecordArrayDef);
                dtSubRecordStruct:
                  Element := TwbSubRecordStruct.Create(Self, nil, Low(Integer), Member as IwbSubRecordStructDef);
              else
                Assert(False);
              end;

              if Assigned(Element) then try
                Element.SortOrder := aIndex;
                Element.MemoryOrder := aIndex;
                if IsAdd and Assigned(aElement) then
                  Element.Assign(Low(Integer), aElement, aOnlySK)
                else if IsAddChild then
                  Element.Assign(High(Integer), aElement, aOnlySK);
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
            Element.Assign(Low(Integer), aElement, False);
          Result := Element;
        end;
      end;
    finally
      wbEndKeepAlive;
    end;

    if wbSortSubRecords and (Length(cntElements) > 1) then
      wbMergeSort(@cntElements[0], Length(cntElements), CompareSubRecords);

  end else
    Result := inherited AssignInternal(aIndex, aElement, aOnlySK);
end;

procedure TwbMainRecord.BuildRef;

  procedure UseKAC;
  var
    KAR: IwbKeepAliveRoot;
  begin
    KAR := wbCreateKeepAliveRoot;
    DoBuildRef(False);
  end;

begin
  if (csRefsBuild in cntStates) and (cntRefsBuildAt >= eGeneration) then
    Exit;

  if wbSpeedOverMemory then
    DoBuildRef(False)
  else
    UseKAC;

  if wbHasProgressCallback then
    wbProgressCallback;
end;

procedure TwbMainRecord.DoBuildRef(aRemove: Boolean);
var
  _File         : IwbFile;
  Files         : array of IwbFile;
  FilesCount    : Integer;
  SelfIntf      : IwbMainRecord;

  procedure ProcessRef(aFormID: TwbFormID; aAdd: Boolean);
  var
    FileID     : Integer;
    MainRecord : IwbMainRecord;
  begin
    if not Assigned(_File) then begin
      _File := GetFile;
      FilesCount := _File.MasterCount;
      SetLength(Files, Succ(FilesCount));
      Files[FilesCount] := _File;
      SelfIntf := Self as IwbMainRecord;
    end;

    FileID := aFormID.FileID.FullSlot;
    if FileID > FilesCount then
      FileID := FilesCount;

    if not Assigned(Files[FileID]) then
      Files[FileID] := _File.Masters[FileID];

    aFormID.FileID := Files[FileID].FileFileID;
    MainRecord := Files[FileID].RecordByFormID[aFormID, True];
    if Assigned(MainRecord) then
      if aAdd then
        MainRecord.AddReferencedBy(SelfIntf)
      else
        MainRecord.RemoveReferencedBy(SelfIntf);
  end;

var
  LastFormID    : TwbFormID;
  i, j          : Integer;
  NewCount      : integer;
  Cmp           : Integer;
  SelfRef : IwbContainerElementRef;
begin
  if mrsBuildingRef in mrStates then
    Exit;

  SelfRef := Self as IwbContainerElementRef;

  Assert(not (mrsBuildingRef in mrStates));
  Include(mrStates, mrsBuildingRef);
  try
    mrTmpRefFormIDHigh := -1;
    mrTmpRefFormIDs := nil;

    if aRemove then begin
      Exclude(cntStates, csRefsBuild);
      cntRefsBuildAt := 0;
    end else
      inherited BuildRef;

    NewCount := 0;
    if mrTmpRefFormIDHigh >= 0 then begin
      wbMergeSort(@mrTmpRefFormIDs[0], Succ(mrTmpRefFormIDHigh), CompareFormIDs);
      LastFormID := TwbFormID.Null;
      for i := 0 to mrTmpRefFormIDHigh do
        if mrTmpRefFormIDs[i] <> LastFormID then begin
          LastFormID := mrTmpRefFormIDs[i];
          mrTmpRefFormIDs[NewCount] := LastFormID;
          Inc(NewCount);
        end;
    end;
    SetLength(mrTmpRefFormIDs, NewCount);

    i := 0;
    j := 0;
    while (i < NewCount) and (j < Length(mrReferences)) do begin
      Cmp := TwbFormID.Compare(mrTmpRefFormIDs[i], mrReferences[j]);
      if Cmp = 0 then begin
        Inc(i);
        Inc(j);
      end else if Cmp < 0 then begin
        ProcessRef(mrTmpRefFormIDs[i], True);
        Inc(i);
      end else begin
        ProcessRef(mrReferences[j], False);
        Inc(j);
      end;
    end;
    while i < NewCount do begin
      ProcessRef(mrTmpRefFormIDs[i], True);
      Inc(i);
    end;
    while j < Length(mrReferences) do begin
      ProcessRef(mrReferences[j], False);
      Inc(j);
    end;

    mrReferences := mrTmpRefFormIDs;
    mrTmpRefFormIDs := nil;
    mrTmpRefFormIDHigh := -1;
  finally
    Exclude(mrStates, mrsBuildingRef);
    mrTmpRefFormIDs := nil;
  end;
end;

function TwbMainRecord.DoGetFixedFormID: TwbFormID;
var
  MasterCount: Cardinal;
  _File: IwbFile;
begin
  Result := PwbMainRecordStruct(dcBasePtr).mrsFormID;
  _File := GetFile;
  if Assigned(_File) then
    if Result.FileID.FullSlot > _File.MasterCount then
      Result.FileID := _File.FileFileID;
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
  Assert(Assigned(_File));

  Result := _File.FileFormIDtoLoadOrderFormID(Result);
  mrLoadOrderFormID := Result;
end;

procedure TwbMainRecord.ElementChanged(const aElement: IwbElement; aContainer: Pointer);
const
  EDID = $44494445;
  FULL = $4C4C5546;
  NAME = $454D414E;
var
  SubRecord: IwbSubRecord;
begin
  if Supports(aElement, IwbSubRecord, SubRecord) then
    case Cardinal(SubRecord.Signature) of
      EDID: mrEditorID := SubRecord.Value;
      FULL: mrFullName := SubRecord.Value;
      NAME: Exclude(mrStates, mrsBaseRecordChecked);
    end;
  inherited;
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
  Result := False;
  if not wbEditAllowed then
    Exit;

  if GetIsDeleted then
    Exit;

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
    Exit;
  end;

  if Assigned(mrDef) then begin
    if aIndex = Low(Integer) then
      Result := mrDef.Equals(aElement.Def)
    else begin
      Result := (aIndex >= 0) and (aIndex < mrDef.MemberCount) and
        (
          mrDef.Members[aIndex].CanAssign(Self, Low(Integer), aElement.Def) or
          mrDef.Members[aIndex].CanAssign(Self, High(Integer), aElement.Def)
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

procedure TwbMainRecord.CollapseStorage;
var
  Stream  : TMemoryStream;

begin
  if (esModified in eStates) then begin
    PrepareSave;
    Stream := TMemoryStream.Create;
    try
      WriteToStream(Stream, True);
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

      SetModified(True);
      InvalidateParentStorage;
    finally
      Stream.Free;
    end;
  end;
end;

function TwbMainRecord.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef : IwbContainerElementRef;
begin
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
  if csInit in cntStates then
    if Supports(GetElementBySortOrder(-2 + GetAdditionalElementCount), IwbContainedIn, ContainedIn) then
      ContainedIn.ContainerChanged;
end;

constructor TwbMainRecord.Create(const aContainer: IwbContainer; const aSignature: TwbSignature; aFormID: TwbFormID);
var
  BasePtr      : PwbMainRecordStruct;
  i            : Integer;
  SelfRef      : IwbContainerElementRef;
  Group        : IwbGroupRecordInternal;
  Group2       : IwbGroupRecordInternal;
  ContainerRef : IwbContainerElementRef;
  s            : string;
  Block        : Cardinal;
  SubBlock     : Cardinal;
  lContainer   : IwbContainer;
  IsInterior   : Boolean;
begin
  IsInterior := False;
  lContainer := aContainer;
  New(BasePtr);
  Include(mrStates, mrsBasePtrAllocated);
  BasePtr.mrsSignature := aSignature;
  BasePtr.mrsDataSize := 0;
  BasePtr.mrsFlags._Flags := 0;
  BasePtr.mrsFormID := aFormID;
  BasePtr.mrsVCS1 := DefaultVCS1;
  case wbGameMode of
    gmFO4, gmFO4VR   : BasePtr.mrsVersion := 131;
    gmSSE, gmTES5VR  : BasePtr.mrsVersion := 44;
    gmTES5           : BasePtr.mrsVersion := 43;
    gmFNV            : BasePtr.mrsVersion := 15;
    gmFO3            : BasePtr.mrsVersion := 15;
    else               BasePtr.mrsVersion := 15;
  end;
  BasePtr.mrsVCS2 := DefaultVCS2;

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

  Create(lContainer, Pointer(BasePtr), nil, nil);
  Assert(Assigned(mrDef));
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  SetModified(True);
  InvalidateStorage;
  for i := 0 to Pred(mrDef.MemberCount) do
    if mrDef.Members[i].Required then
      Assign(i, nil, False);
  if Supports(lContainer, IwbGroupRecordInternal, Group) then
    Group.Sort;

  if IsInterior then
    if Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, ContainerRef) then
      ContainerRef.EditValue := '1';
end;

constructor TwbMainRecord.Create(const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; const aPrevMainRecord : IwbMainRecord);
var
  _File: IwbFileInternal;
begin
  inherited;
  try
    _File := GetFile as IwbFileInternal;
    if Assigned(_File) then
      _File.AddMainRecord(Self);
  except
    if Assigned(aContainer) then
      aContainer.RemoveElement(Self);
    raise;
  end;
end;

procedure TwbMainRecord.DecompressIfNeeded;
var
  UncompressedLength: Cardinal;
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
    dcDataBasePtr := nil;
    dcDataEndPtr := nil;
  end;
end;

procedure TwbMainRecord.Delete;
var
  SelfRef     : IwbContainerElementRef;
  BasePtr     : Pointer;
  GroupRecord : IwbGroupRecord;
begin
  SelfRef := Self;
  DoInit;

  SetModified(True);
  InvalidateStorage;
  ReleaseElements;

  MakeHeaderWriteable;
  GetFlagsPtr.SetDeleted(True);

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
end;

procedure TwbMainRecord.DeleteInto(const aFile: IwbFile);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(CopyInto(aFile, False, False, '', '', ''), IwbMainRecord, MainRecord) then
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
{$IFDEF DBGSUBREC}
//  MainRecord             : IwbMainRecord;
  s: string;
{$ENDIF}
  RequiredRecords      : set of byte;
  PresentRecords       : set of byte;
  i                    : Integer;
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

    CurrentPtr := dcBasePtr;
    with TwbRecordHeaderStruct.Create(Self, CurrentPtr, PByte(CurrentPtr) + wbSizeOfMainRecordStruct, mrDef.RecordHeaderStruct, '') do begin
      Include(dcFlags, dcfDontSave);
      SetSortOrder(-1);
      SetMemoryOrder(Low(Integer));
      _AddRef; _Release;
    end;
  end;

{$IFDEF DBGSUBREC}
  s := '';
{$ENDIF}
  CurrentPtr := GetDataBasePtr;
  while NativeUInt(CurrentPtr) < NativeUInt(dcDataEndPtr) do begin
    Element := TwbRecord.CreateForPtr(CurrentPtr, dcDataEndPtr, Self, nil);
{$IFDEF DBGSUBREC}
    if Supports(Element, IwbSubRecord, CurrentRec) then
      s := s + CurrentRec.Signature + ' ';
{$ENDIF}
  end;
  Element := nil;

  if not Assigned(mrDef) then
    Exit;

  SetLength(LastElementForMember, mrDef.MemberCount);

  if not Assigned(cntElements) then
    Exit;

  CurrentDefPos := 0;
  CurrentRecPos := 0;

  while (CurrentRecPos < Length(cntElements)) do begin
    if cntElements[CurrentRecPos].ElementType <> etSubRecord then begin
      Inc(CurrentRecPos);
      Continue;
    end;
    CurrentRec := cntElements[CurrentRecPos] as IwbSubRecord;
    if wbIgnoreRecords.Find(CurrentRec.Signature, Dummy) then begin
      Inc(CurrentRecPos);
      Continue;
    end;

    if mrDef.AllowUnordered then begin
      CurrentDefPos := mrDef.GetMemberIndexFor(CurrentRec.Signature, CurrentRec);
      if CurrentDefPos < 0 then begin
        if wbHasProgressCallback then
          wbProgressCallback('Error: record '+ String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) + ' ' + IntToHex(Int64(Cardinal(CurrentRec.Signature)), 8) );
        FoundError := True;
        Inc(CurrentRecPos);
        Continue;
      end;
      CurrentDef := mrDef.Members[CurrentDefPos];
    end else begin
      if not mrDef.ContainsMemberFor(CurrentRec.Signature, CurrentRec) then begin
        if wbHasProgressCallback then
          wbProgressCallback('Error: record '+ String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) + ' ' + IntToHex(Int64(Cardinal(CurrentRec.Signature)), 8) );
        FoundError := True;
        Inc(CurrentRecPos);
        Continue;
      end;

      if (CurrentDefPos < mrDef.MemberCount) then begin
        CurrentDef := mrDef.Members[CurrentDefPos];
        if not CurrentDef.CanHandle(CurrentRec.Signature, CurrentRec) then begin
          Inc(CurrentDefPos);
          Continue;
        end;
      end else begin
        if wbHasProgressCallback then
          wbProgressCallback('Error: record '+ String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) );
        FoundError := True;
        Inc(CurrentRecPos);
        Continue;
      end;
    end;

    if CurrentDefPos > mrDef.QuickInitLimit then begin
      Include(mrStates, mrsQuickInitDone);
      if mrsQuickInit in mrStates then
        Exit;
    end;

    if CurrentDef.DefType = dtSubRecordUnion then begin
      CurrentDef := (CurrentDef as IwbRecordDef).GetMemberFor(CurrentRec.Signature, CurrentRec);
      Assert(Assigned(CurrentDef));
    end;

    case CurrentDef.DefType of
      dtSubRecord       : begin
        (CurrentRec as IwbSubRecordInternal).SetDef(CurrentDef as IwbSubRecordDef);
        if CurrentRec.Signature = 'EDID' then
          mrEditorID := CurrentRec.Value
        else if CurrentRec.Signature = 'FULL' then
          mrFullName := CurrentRec.Value
        else if (CurrentRec.Signature = 'NAME') and
                (
                  (mrDef.DefaultSignature = 'REFR') or
                  (mrDef.DefaultSignature = 'PGRE') or
                  (mrDef.DefaultSignature = 'PMIS') or
                  (mrDef.DefaultSignature = 'ACHR') or
                  (mrDef.DefaultSignature = 'ACRE') or
                  (mrDef.DefaultSignature = 'PARW') or {>>> Skyrim <<<}
                  (mrDef.DefaultSignature = 'PBEA') or {>>> Skyrim <<<}
                  (mrDef.DefaultSignature = 'PFLA') or {>>> Skyrim <<<}
                  (mrDef.DefaultSignature = 'PCON') or {>>> Skyrim <<<}
                  (mrDef.DefaultSignature = 'PBAR') or {>>> Skyrim <<<}
                  (mrDef.DefaultSignature = 'PHZD')    {>>> Skyrim <<<}
                ) then begin

          mrBaseRecordID := TwbFormID.FromCardinal(CurrentRec.NativeValue);
          Include(mrStates, mrsBaseRecordChecked);
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
    if wbIgnoreRecords.Find(CurrentRec.Signature, Dummy) then begin
      Inc(CurrentRecPos);
      Continue;
    end;

    if wbHasProgressCallback then
      wbProgressCallback('Error: record '+ String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) );
    FoundError := True;

    Inc(CurrentRecPos);
  end;

//  if GetSignature = 'DIAL' then
//    FoundError := True;

  if FoundError then
    if wbHasProgressCallback then begin
      wbProgressCallback('Errors were found in: ' + GetName);
{$IFDEF DBGSUBREC}
      wbProgressCallback('Contained subrecords: ' + s);
{$ENDIF}
    end;

  if wbSortSubRecords and (mrDef.AllowUnordered or (esModified in eStates)) and (Length(cntElements) > 1) then
    wbMergeSort(@cntElements[0], Length(cntElements), CompareSubRecords);

  mrDef.AfterLoad(Self);

  if not mrStruct.mrsFlags.IsDeleted then begin
    for i := 0 to Pred(mrDef.MemberCount) do
      if mrDef.Members[i].Required then
        Include(RequiredRecords, i);

    RequiredRecords := RequiredRecords - PresentRecords;
    if RequiredRecords <> [] then begin
      if wbBeginInternalEdit then try
        for i := 0 to Pred(mrDef.MemberCount) do
          if i in RequiredRecords then begin
            if wbMoreInfoForRequired  then
              wbProgressCallback(' ['+mrFixedFormID.ToString(True)+'] Adding missing record: ' + mrDef.Members[i].GetName);
            Assign(i, nil, False);
          end;
      finally
        wbEndInternalEdit;
      end;
    end;
  end;

  if wbReportMode {and mrDef.AllowUnordered} then begin
    s := GetSignature + ' -> ' + s;
    CurrentRecPos := SubRecordOrderList.Add(s);
    SubRecordOrderList.Objects[CurrentRecPos] := Pointer(Succ(Integer(SubRecordOrderList.Objects[CurrentRecPos])));
  end;

{
  if GetSignature = 'SCPT' then begin
//    s :=  (GetRecordBySignature('DATA') as IwbContainer).Elements[0].EditValue + s;
    CurrentRecPos := SubRecordOrderList.Add(s);
    SubRecordOrderList.Objects[CurrentRecPos] := Pointer(Succ(Integer(SubRecordOrderList.Objects[CurrentRecPos])));
  end;
}

  Include(cntStates, csInitOnce);

  if not GetIsDeleted and (GetSignature = 'INFO') and not Assigned(GetRecordBySignature('PNAM')) and wbAllowInternalEdit then
    if Supports(IwbContainer(eContainer), IwbGroupRecordInternal, GroupRecordInternal) then
      GroupRecordInternal.Sort;
end;

function TwbMainRecord.FindReferencedBy(const aMainRecord: IwbMainRecord; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;

{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
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
end;

procedure TwbMainRecord.FindUsedMasters(aMasters: PwbUsedMasters);
var
  FileID   : Integer;
  i        : Integer;

  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if not mrStruct.mrsFormID.IsNull then begin
    FileID := mrStruct.mrsFormID.FileID.FullSlot;
    aMasters[FileID] := True;
  end;

  if csRefsBuild in cntStates then begin

    for i := High(mrReferences) downto Low(mrReferences) do begin
      FileID := mrReferences[i].FileID.FullSlot;
      aMasters[FileID] := True;
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
  i, j      : Integer;
  RecordDef : PwbRecordDef;
begin
  Result := nil;

  if GetIsDeleted then
    Exit;

  if GetSignature = 'DIAL' then begin
    SetLength(Result, 1);
    Result[0] := 'INFO';
  end else if GetSignature = 'CELL' then begin
    SetLength(Result, 11);
    Result[0] := 'ACHR';
    Result[1] := 'ACRE';
    Result[2] := 'REFR';
    Result[3] := 'PGRE';
    Result[4] := 'PMIS';
    Result[5] := 'PARW'; {>>> Skyrim <<<}
    Result[6] := 'PBEA'; {>>> Skyrim <<<}
    Result[7] := 'PFLA'; {>>> Skyrim <<<}
    Result[8] := 'PCON'; {>>> Skyrim <<<}
    Result[9] := 'PBAR'; {>>> Skyrim <<<}
    Result[10] := 'PHZD'; {>>> Skyrim <<<}
  end else if GetSignature = 'WRLD' then begin
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

function TwbMainRecord.GetBaseRecord: IwbMainRecord;
var
  SelfRef: IwbContainerElementRef;
  NameRec: IwbContainerElementRef;
begin
  Result := nil;

  if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then begin
    SelfRef := Self as IwbContainerElementRef;
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

  if not (mrsBaseRecordChecked in mrStates) then begin
    SelfRef := Self as IwbContainerElementRef;
    mrBaseRecordID := TwbFormID.Null;
    Include(mrStates, mrsBaseRecordChecked);
    if Supports(GetRecordBySignature('NAME'), IwbContainerElementRef, NameRec) then
      if Supports(NameRec.LinksTo, IwbMainRecord, Result) then begin
        mrBaseRecordID := TwbFormID.FromCardinal(NameRec.NativeValue);
      end;
    Exit;
  end;
  if not mrBaseRecordID.IsNull then
    with GetFile do
      Result := RecordByFormID[mrBaseRecordID, True];
end;

function TwbMainRecord.GetBaseRecordID: TwbFormID;
begin
  if not (mrsBaseRecordChecked in mrStates) then
    GetBaseRecord;
  Result := GetFile.FileFormIDtoLoadOrderFormID(mrBaseRecordID);
end;

function TwbMainRecord.GetCanHaveEditorID: Boolean;
begin
  Result := Assigned(mrDef) and mrDef.ContainsEditorID;
end;

function TwbMainRecord.GetCheck: string;
var
  i, j: Integer;
  RequiredCount: Integer;
  Element: IwbElement;
  Def: IwbNamedDef;
  FoundIt: Boolean;
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  Result := '';

  if not Assigned(mrDef) then
    Exit;
  if recSkipped then
    Exit;

  if mrStruct.mrsFlags.IsDeleted then begin
    Result := '';

    for i := GetAdditionalElementCount to Pred(GetElementCount) do begin
      Element := cntElements[i];
      Def := Element.Def;
      if Assigned(Def) then
        Result := Result + Def.Name + ', ';
    end;
    SetLength(Result, Length(Result) - 2);

    if Result <> '' then
      Result := 'Record marked as deleted but contains: ' + Result;

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
          Result := Result + Def.Name + ', ';
      end;
    SetLength(Result, Length(Result) - 2);
  end;
end;

function TwbMainRecord.GetChildGroup: IwbGroupRecord;
var
  SearchForGroup: Integer;
  ContainingGroup: IwbGroupRecord;
begin
  Result := mrGroup;
  if not Assigned(Result) and not (mrsSearchedChildGroup in mrStates) then begin
    try
      Include(mrStates, mrsSearchedChildGroup);
      SearchForGroup := 0;
      if GetSignature = 'WRLD' then
        SearchForGroup := 1
      else if GetSignature = 'CELL' then
        SearchForGroup := 6
      else if GetSignature = 'DIAL' then
        SearchForGroup := 7
      else if wbVWDAsQuestChildren and (GetSignature = 'QUST') then
        SearchForGroup := 10;

      if (SearchForGroup > 0) and Supports(GetContainer, IwbGroupRecord, ContainingGroup) then
        mrGroup := ContainingGroup.FindChildGroup(SearchForGroup, Self);
      Result := mrGroup;
    finally
      Exclude(mrStates, mrsSearchedChildGroup);
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

function TwbMainRecord.GetDisplayName: string;
var
  Rec         : IwbRecord;
  GridCoords  : IwbContainerElementRef;
  GroupRecord : IwbGroupRecord;
  MapMarker   : IwbContainerElementRef;
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
          Rec := MapMarker.RecordBySignature['FULL']
        else
          Rec := GetRecordBySignature('NAME');
        if Assigned(Rec) then
          Result := Trim(Rec.Value)
    end else if (GetSignature = 'CELL') then begin
        if Supports(GetContainer, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1) then
          Result := '<Persistent Worldspace Cell>'
        else
          if Supports(GetRecordBySignature('XCLC'), IwbContainerElementRef, GridCoords) and
            (GridCoords.ElementCount >= 2) then
              Result := '<' + StrRight(GridCoords.Elements[0].Value,3) + ', ' + StrRight(GridCoords.Elements[1].Value,3) + '>';
    end else if (GetSignature = 'INFO') then begin
        Result := GetElementValue('Responses\Response\NAM1');
    end;
end;

function TwbMainRecord.GetDisplayNameKey: string;
var
  Rec         : IwbRecord;
  GridCoords  : IwbContainerElementRef;
  GroupRecord : IwbGroupRecord;
  MapMarker   : IwbContainerElementRef;
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
          Rec := MapMarker.RecordBySignature['FULL']
        else
          Rec := GetRecordBySignature('NAME');
        if Assigned(Rec) then
          Result := Trim(Rec.Value)
    end else if
      (GetSignature = 'CELL') then begin
        if Supports(GetContainer, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1) then
          Result := ' '
        else
          if Supports(GetRecordBySignature('XCLC'), IwbContainerElementRef, GridCoords) and
            (GridCoords.ElementCount >= 2) then
              Result := GridCoords.Elements[0].SortKey[True] + '|' + GridCoords.Elements[1].SortKey[True];
    end;
end;

function TwbMainRecord.GetEditorID: string;
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then begin
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

function TwbMainRecord.GetFixedFormID: TwbFormID;
begin
  Result := mrFixedFormID;
  if Result.IsNull then
    Result := DoGetFixedFormID;
end;

function TwbMainRecord.GetFlags: TwbMainRecordStructFlags;
begin
  Result := mrStruct.mrsFlags;
end;

function TwbMainRecord.GetFlagsPtr: PwbMainRecordStructFlags;
begin
  Result := @mrStruct.mrsFlags;
end;

function TwbMainRecord.GetFormID: TwbFormID;
begin
  Result := mrStruct.mrsFormID;
end;

function TwbMainRecord.GetFullName: string;
var
  SelfRef: IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  if not ((mrsQuickInitDone in mrStates) or (csInitOnce in cntStates)) then begin
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
  Result := mrStruct.mrsVersion;
end;

procedure TwbMainRecord.SetFormVersion(aFormVersion: Cardinal);
begin
  MakeHeaderWriteable;
  mrStruct.mrsVersion := aFormVersion;
end;

function TwbMainRecord.GetFormVCS1: Cardinal;
begin
  Result := mrStruct.mrsVCS1;
end;

procedure TwbMainRecord.SetFormVCS1(aVCS: Cardinal);
begin
  MakeHeaderWriteable;
  mrStruct.mrsVCS1 := aVCS;
end;

function TwbMainRecord.GetFormVCS2: Cardinal;
begin
  Result := mrStruct.mrsVCS2;
end;

procedure TwbMainRecord.SetFormVCS2(aVCS: Cardinal);
begin
  MakeHeaderWriteable;
  mrStruct.mrsVCS2 := aVCS;
end;

procedure TwbMainRecord.ChangeFormSignature(aSignature: TwbSignature);
begin
  MakeHeaderWriteable;
  mrStruct.mrsSignature := aSignature;
end;

procedure TwbMainRecord.ClampFormID(aIndex: Cardinal);
begin
  if mrStruct.mrsFormID.FileID.FullSlot > aIndex then begin
    MakeHeaderWriteable;
    mrStruct.mrsFormID.FileID := TwbFileID.Create(aIndex);
    if Assigned(mrGroup) then
      mrGroup.GroupLabel := mrStruct.mrsFormID.ToCardinal;
  end;
end;

function TwbMainRecord.GetGridCell(out aGridCell: TwbGridCell): Boolean;
var
  Signature : TwbSignature;
  SelfRef   : IwbContainerElementRef;
  XCLCRec   : IwbContainerElementRef;
begin
  Result := False;

  Signature := GetSignature;
  if (Signature <> 'CELL') then
    Exit;

  SelfRef := Self;
  DoInit;

  if not Supports(GetRecordBySignature('XCLC'), IwbContainerElementRef, XCLCRec) then
    Exit;

  if XCLCRec.ElementCount < 2 then
    Exit;

  with aGridCell, XCLCRec do begin
    X := StrToIntDef(Elements[0].Value, -10000);
    Y := StrToIntDef(Elements[1].Value, -10000);
    Result := (x <> -10000) and (y <> -10000);
  end;
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
          s := Trim(StringReplace(MODL.Value, '/', '\', [rfReplaceAll]));
          if s <> '' then begin
            s := 'meshes\'+ s;//
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

var
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
  cnt, i      : Cardinal;
  CellFormID  : TwbFormID;
  MasterFolder, s: string;
begin
  Result := '';

  if not wbIsFallout4 then
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
    if Cardinal(SelfRef.ElementNativeValues['NAME']) < $800 then
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
          s := Trim(StringReplace(MODL.Value, '/', '\', [rfReplaceAll]));
          if s <> '' then begin
            s := 'textures\trees\billboards'+ChangeFileExt(s, '.dds');
            if Length(wbContainerHandler.OpenResource(s)) > 0 then
              Include(mrStates, mrsHasVWDMesh);
          end;
        end;
    end else begin
      SelfRef := Self as IwbContainerElementRef;
      if Supports(GetElementByName('Model'), IwbContainerElementRef, ModelCnt) then
        if Supports(ModelCnt.RecordBySignature['MODL'], IwbContainerElementRef, MODL) then begin
          s := Trim(StringReplace(MODL.Value, '/', '\', [rfReplaceAll]));
          if s <> '' then begin
            s := 'meshes\'+ChangeFileExt(s, '_far.nif');
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
  for i := Pred(Master.OverrideCount) downto 0 do
    if Master.Overrides[i]._File.LoadOrder <= aMaxLoadOrder then begin
      Result := Master.Overrides[i];
      Exit;
    end;
end;

function TwbMainRecord.GetInjectionSourceFiles: TDynFiles;
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
      Rec := _File.RecordByFormID[mrReferences[i], True];
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
      wbMergeSort(@Result[0], j, CompareLoadOrder);
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
  if Result then
    Exit;

  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(Self) then
    Exit;

  Result := True;
end;

function TwbMainRecord.GetIsESL: Boolean;
begin
  Result := GetFlags.IsESL;
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
    if not Assigned(mrMaster) and
       not mrStruct.mrsFormID.IsNull and
           (mrStruct.mrsFormID.FileID.FullSlot < GetFile.MasterCount) and
       not (fsIsHardcoded in GetFile.FileStates) then
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
        if not (esNotReachable in mrOverrides[i].ElementStates) then begin
          Result := False;
          Exit;
        end;
  end;
end;

function TwbMainRecord.GetIsPersistent: Boolean;
begin
  Result := GetFlags.IsPersistent;
end;

function TwbMainRecord.GetIsVisibleWhenDistant: Boolean;
begin
  Result := GetFlags.IsVisibleWhenDistant;
end;

function TwbMainRecord.GetIsWinningOverride: Boolean;
var
  Master: IwbMainRecord;
begin
  if Assigned(mrMaster) then begin
    Master := IwbMainRecord(mrMaster);
    Assert(Master.OverrideCount > 0);
    Result := Equals(Master.Overrides[Pred(Master.OverrideCount)]);
  end else
    Result := Length(mrOverrides) < 1;
end;

function TwbMainRecord.GetLoadOrderFormID: TwbFormID;
begin
  Result := mrLoadOrderFormID;
  if Result.IsNull then
    Result := DoGetLoadOrderFormID;
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
          for j := Pred(_File.MasterCount) downto 0 do
            lMasters.Add(_File.Masters[j].FileName);
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
var
//  Rec: IwbRecord;
  s : string;
begin
  if wbDisplayShorterNames then begin
    Result := '';

    s := GetEditorID;
    if s <> '' then
      Result := Result + {'<' +} s {+'>'};

    s := GetFullName;
    if s <> '' then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + '"' + s +'"';
    end;

    if Result <> '' then
      Result := Result + ' ';

    if wbDisplayLoadOrderFormID then
      Result := Result + '[' + GetSignature + ':' + GetLoadOrderFormID.ToString(True) + ']'
    else
      Result := Result + '[' + GetSignature + ':' + GetFormID.ToString(True) + ']';

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
      Result := Result + ' <' + s +'>';

    s := GetFullName;
    if s <> '' then
      Result := Result + ' "' + s +'"';

  end;
end;

function TwbMainRecord.GetName: string;
var
  s : string;
begin
  Result := GetShortName;
  if Assigned(mrDef) then begin
    s := Trim(mrDef.AdditionalInfoFor(Self));
    if s <> '' then
      Result := Result + ' (' + s + ')';
  end;
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
    wbMergeSort(@mrOverrides[0], Length(mrOverrides), CompareOverrides);
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
    DoInit;

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
{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
{$ENDIF}

  if mrsReferencedByUnsorted in mrStates then
    SortReferencedBy;
  Result := mrReferencedBy[aIndex];
end;

function TwbMainRecord.GetReferencedByCount: Integer;
begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
{$ENDIF}

  Result := mrReferencedByCount;
end;

function TwbMainRecord.GetReferenceFile: IwbFile;
var
  FileID: Integer;
begin
  Result := GetFile;
  FileID := mrStruct.mrsFormID.FileID.FullSlot;
  if FileID < Result.MasterCount then
    Result := Result.Masters[FileID];
end;

function TwbMainRecord.GetReferencesInjected: Boolean;
var
  i, j    : Integer;
  _File   : IwbFile;
  RecFile : IwbFile;
  Rec     : IwbMainRecord;
  Found   : Boolean;
begin
  if not (mrsReferencesInjectedChecked in mrStates) and (csRefsBuild in cntStates) then begin
    Include(mrStates, mrsReferencesInjectedChecked);
    Exclude(mrStates, mrsReferencesInjected);
    if Length(mrReferences) > 0 then begin
      _File := GetFile;
      for i := Low(mrReferences) to High(mrReferences) do begin
        Rec := _File.RecordByFormID[mrReferences[i], True];
        if Assigned(Rec) then begin
          RecFile := Rec._File;
          if not _File.Equals(RecFile) then begin
            Rec := Rec.MasterOrSelf;
            if Rec.IsInjected then begin
              Found := False;
              for j := 0 to Pred(_File.MasterCount) do
                if _File.Masters[j].Equals(RecFile) then begin
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
  DoInit;

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
  DoInit;

  if not Supports(GetRecordBySignature('XSCL'), IwbContainerElementRef, XSclRec) then
    Exit;

  aScale := StrToFloatDef(XSclRec.Value, 0);
  Result := True;
end;

function TwbMainRecord.GetSortKeyInternal(aExtended: Boolean): string;
begin
  Result := mrStruct.mrsFormID.ToString(False)
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
    Result := IwbMainRecord(mrMaster).WinningOverride
  else
    if Length(mrOverrides) > 0 then
      Result := mrOverrides[High(mrOverrides)]
    else
      Result := Self;
end;

procedure TwbMainRecord.InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
begin
  Assert(False);
end;

procedure TwbMainRecord.InitDataPtr;
var
  RecordDef : PwbRecordDef;
begin
  if Assigned(dcEndPtr) then begin
    dcDataBasePtr := PByte(dcBasePtr) + wbSizeOfMainRecordStruct;
    dcDataEndPtr := PByte(dcDataBasePtr) + mrStruct.mrsDataSize;
    dcEndPtr := dcDataEndPtr;
  end;

  if not Assigned(mrDef) then begin
    if wbFindRecordDef(PwbSignature(dcBasePtr)^, RecordDef) then
      mrDef := RecordDef^
    else begin
      if wbHasProgressCallback then
        wbProgressCallback('Error: unknown record type '+ String(PwbSignature(dcBasePtr)^));
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

function TwbMainRecord.IsElementRemoveable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement) and not aElement.Def.Required;
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

procedure TwbMainRecord.LoadRefsFromStream(aStream: TStream);
var
  _File         : IwbFile;
  Files         : array of IwbFile;
  FilesCount    : Integer;
  SelfIntf      : IwbMainRecord;

  procedure ProcessRef(aFormID: TwbFormID);
  var
    FileID     : Integer;
    MainRecord : IwbMainRecord;
  begin
    if not Assigned(_File) then begin
      _File := GetFile;
      FilesCount := _File.MasterCount;
      SetLength(Files, Succ(FilesCount));
      Files[FilesCount] := _File;
      SelfIntf := Self as IwbMainRecord;
    end;

    FileID := aFormID.FileID.FullSlot;
    if FileID > FilesCount then
      FileID := FilesCount;

    if not Assigned(Files[FileID]) then
      Files[FileID] := _File.Masters[FileID];

    aFormID.FileID := Files[FileID].FileFileID;
    MainRecord := Files[FileID].RecordByFormID[aFormID, True];
    if Assigned(MainRecord) then
      MainRecord.AddReferencedBy(SelfIntf)
  end;

var
  lFormID: TwbFormID;
  i: Integer;
begin
  Assert(Length(mrReferences)=0);
  aStream.Read(lFormID, SizeOf(TwbFormID));
  Assert(lFormID = mrStruct.mrsFormID);
  aStream.Read(i, SizeOf(i));
  if i>0 then begin
    SetLength(mrReferences, i);
    aStream.Read(mrReferences[0], SizeOf(TwbFormID) * i);
    for i := 0 to Length(mrReferences) do
      ProcessRef(mrReferences[i]);
  end;
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

  DoInit;

  SetModified(True);
  InvalidateParentStorage;

  if Assigned(dcEndPtr) then begin
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

procedure TwbMainRecord.MarkModifiedRecursive;
var
  SelfRef : IwbContainerElementRef;
  Group   : IwbGroupRecord;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  inherited;
  Group := GetChildGroup;
  if Assigned(Group) then
    Group.MarkModifiedRecursive;
end;

procedure TwbMainRecord.MasterCountUpdated(aOld, aNew: Byte);
var
  i        : Integer;
  FoundOne : Boolean;

  SelfRef  : IwbContainerElementRef;
  NewFileID: TwbFileID;
begin
  wbTick;

  mrBaseRecordID := TwbFormID.Null;
  Exclude(mrStates, mrsBaseRecordChecked);

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  NewFileID := TwbFileID.Create(aNew);

  if not mrStruct.mrsFormID.IsNull then
    if mrStruct.mrsFormID.FileID.FullSlot >= aOld then begin
      MakeHeaderWriteable;
      mrStruct.mrsFormID.FileID := NewFileID;
      mrFixedFormID := TwbFormID.Null;
      mrLoadOrderFormID := TwbFormID.Null;
      Exclude(mrStates, mrsIsInjectedChecked);
    end;

  if csRefsBuild in cntStates then begin

    FoundOne := False;
    for i := High(mrReferences) downto Low(mrReferences) do begin
      if mrReferences[i].FileID.FullSlot < aOld then
        Break;
      FoundOne := True;
      mrReferences[i].FileID := NewFileID;
    end;

    if FoundOne then
      inherited;

  end else
    inherited;
end;

procedure TwbMainRecord.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
var
  OldFormID: TwbFormID;
  NewFormID: TwbFormID;
  i        : Integer;
  FoundOne : Boolean;

  SelfRef : IwbContainerElementRef;
begin
  wbTick;

  mrBaseRecordID := TwbFormID.Null;
  Exclude(mrStates, mrsBaseRecordChecked);

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  OldFormID := GetFormID;
  if not OldFormID.IsNull then begin
    NewFormID := FixupFormID(OldFormID, aOld, aNew);
    if OldFormID <> NewFormID then begin
      MakeHeaderWriteable;
      mrStruct.mrsFormID := NewFormID;
      mrFixedFormID := TwbFormID.Null;
      mrLoadOrderFormID := TwbFormID.Null;
      Exclude(mrStates, mrsIsInjectedChecked);
    end;
  end;

  if csRefsBuild in cntStates then begin

    FoundOne := False;
    for i := Low(mrReferences) to High(mrReferences) do begin
      OldFormID := mrReferences[i];
      NewFormID := FixupFormID(OldFormID, aOld, aNew);
      if OldFormID <> NewFormID then begin
        FoundOne := True;
        mrReferences[i] := NewFormID;
      end;
    end;

    if FoundOne then begin
      wbMergeSort(@mrReferences[0], Length(mrReferences), CompareFormIDs );
      inherited;
    end;

  end else
    inherited;
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
        for k := 0 to Pred(_File.MasterCount) do begin
          Result := _File.Masters[k].Equals(RecFile);
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

function TwbMainRecord.mrStruct: PwbMainRecordStruct;
begin
  Result := PwbMainRecordStruct(dcBasePtr);
end;

procedure TwbMainRecord.PrepareSave;
var
  _File       : IwbFile;
  GroupRecord : IwbGroupRecord;
begin
  if GetSignature = wbHeaderSignature then begin
    if not Supports(GetContainer, IwbFile, _File) then
      raise Exception.Create('File Header record '+GetName+' must be contained directly in the file.');
    if not GetFormID.IsNull then
      raise Exception.Create('File Header record '+GetName+' can not have a FormID.');
  end else begin
    if GetFormID.IsNull then
      raise Exception.Create('Record '+GetName+' must have a FormID.');
    if not Supports(GetContainer, IwbGroupRecord, GroupRecord) then
      raise Exception.Create('Record '+GetName+' is not contained in a group.');
    case GroupRecord.GroupType of
      0: begin {top level}
        if TwbSignature(GroupRecord.GroupLabel) <> GetSignature then
          raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);
      end;
      1: begin {World Children}
        if (GetSignature <> 'CELL') and (GetSignature <> 'ROAD') then
          raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);
      end;
      2, 4, 6: begin {interior and exterior block and cell children}
        raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);
      end;
      3, 5: begin {interior and exterior sub-block}
        if (GetSignature <> 'CELL') then
          raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);
      end;
      7: begin {topic children}
        if (GetSignature <> 'INFO') then
          raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);
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
            raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);

        case GroupRecord.GroupType of
          8:begin
            if not mrStruct.mrsFlags.IsPersistent then
              raise Exception.Create('Record ' + GetName + ' needs to have it''s Persistent flag set to be contained in ' + GroupRecord.Name);
          end;
          10: if not wbVWDAsQuestChildren then begin
            if not mrStruct.mrsFlags.IsVisibleWhenDistant then
              raise Exception.Create('Record ' + GetName + ' needs to have it''s Visible when Distant flag set to be contained in ' + GroupRecord.Name);
            if mrStruct.mrsFlags.IsPersistent then
              raise Exception.Create('Record ' + GetName + ' can not have it''s Persistent flag set to be contained in ' + GroupRecord.Name);
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
          raise Exception.Create('Record ' + GetName + ' can not be contained in ' + GroupRecord.Name);
        if mrStruct.mrsFlags.IsPersistent then
          raise Exception.Create('Record ' + GetName + ' can not have it''s Persistent flag set to be contained in ' + GroupRecord.Name);
        if mrStruct.mrsFlags.IsVisibleWhenDistant and not wbVWDInTemporary then
          raise Exception.Create('Record ' + GetName + ' can not have it''s Visible when Distant flag set to be contained in ' + GroupRecord.Name);
      end;
    end;
  end;

  if GetIsDeleted and (GetDataSize > 0) then begin
    GetDataSize;
    Delete;
  end;

  //not needed for now
  inherited;
end;

function TwbMainRecord.Reached: Boolean;
var
  Signature : TwbSignature;
  i         : Integer;
  IsComplex : Boolean;
{
  _File     : IwbFile;
  Rec       : IwbMainRecord;
}

  SelfRef   : IwbContainerElementRef;
begin
  if esReachable in eStates then
    Exit(False);

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  Signature := GetSignature;
  IsComplex := (Signature = 'DIAL') or (Signature = 'WRLD') or (Signature = 'CELL');
  if GetIsWinningOverride or IsComplex then begin
    {if csRefsBuild in cntStates then begin
      Result := esNotReachable in eStates;
      Exclude(eStates, esNotReachable);
      if Result and (Length(mrReferences) > 0) then begin
        _File := GetFile;
        for i := Low(mrReferences) to High(mrReferences) do begin
          Rec := _File.RecordByFormID[mrReferences[i], True];
          if Assigned(Rec) then
            (Rec as IwbElementInternal).Reached;
        end;
      end;
      if LinksToParent then begin
        if Assigned(eContainer) then
          (IwbContainer(eContainer) as IwbElementInternal).Reached;
        Exit;
      end;
    end else}
    Result := inherited Reached;

    if Result then begin
      if not Assigned(eContainer) then
        Exit;
      if LinksToParent then
        Exit;
      if not IsComplex then
        Exit;

      if Assigned(mrMaster) then
        (IwbMainRecord(mrMaster) as IwbElementInternal).Reached
      else
        for i := 0 to Pred(GetOverrideCount) do
          (GetOverride(i) as IwbElementInternal).Reached;

      if Assigned(mrGroup) then
        (mrGroup as IwbElementInternal).Reached;
    end;
  end else
    Result := (GetWinningOverride as IwbElementInternal).Reached;
end;

procedure TwbMainRecord.Remove;
var
  _File: IwbFileInternal;
begin
  DoBuildRef(True);

  _File := GetFile as IwbFileInternal;
  if Assigned(_File) then
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
  mrFixedFormID := TwbFormID.Null;
  mrLoadOrderFormID := TwbFormID.Null;
  Exclude(mrStates, mrsIsInjectedChecked);
  mrConflictAll := caUnknown;
  mrConflictThis := ctUnknown;

  inherited;
end;

procedure TwbMainRecord.RemoveChildGroup(const aGroup: IwbGroupRecord);
begin
  if Assigned(mrGroup) and mrGroup.Equals(aGroup) then begin
    mrGroup := nil;
    Exclude(mrStates, mrsSearchedChildGroup);
  end;
end;

function TwbMainRecord.RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement;
begin
  Result := inherited RemoveElement(aPos, aMarkModified);
  if Assigned(Result) and (Result.ElementType = etSubRecord) then
    with (Result as IwbSubRecord) do begin
      if Signature = 'EDID' then
        mrEditorID := ''
      else if Signature = 'FULL' then begin
        if (mrFullName <> '') and (Value = mrFullName) then
          mrFullName := '';
      end else if Signature = 'NAME' then
        Exclude(mrStates, mrsBaseRecordChecked);
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
  DoInit;

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
  if Result and aCanRemove and GetIsRemoveable then begin
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
end;

procedure TwbMainRecord.RemoveReferencedBy(aMainRecord: IwbMainRecord);
var
  i: Integer;
begin
{$IFDEF USE_PARALLEL_BUILD_REFS}
  Assert(not wbBuildingRefsParallel);
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
end;

procedure TwbMainRecord.ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false);
var
  _File: IwbFile;
begin
  if not aAsNew then begin
    _File := GetReferenceFile;
    aStrings.AddObject(_File.FileName, Pointer(_File));
  end;
  inherited;
end;

procedure TwbMainRecord.Reset;
begin
  ReleaseElements;
  mrDataStorage := nil;
  InitDataPtr;
  inherited;
end;

procedure TwbMainRecord.ResetConflict;
var
  i: Integer;
begin
  inherited;
  if Assigned(mrMaster) then
    IwbElement(mrMaster).ResetConflict
  else begin
    mrConflictAll := caUnknown;
    mrConflictThis := ctUnknown;
    for i := Low(mrOverrides) to High(mrOverrides) do
      with mrOverrides[i] do begin
        ConflictAll := caUnknown;
        ConflictThis := ctUnknown;
      end;
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
    i := mrDef.GetMemberIndexFor(StrToSignature(aName), nil);
    if i < 0 then
      Exit;
    Assign(i, nil, False);
    Result := GetElementBySignature(StrToSignature(aName));
  end;
end;

procedure TwbMainRecord.SaveRefsToStream(aStream: TStream);
var
  i: Integer;
begin
  aStream.Write(mrStruct.mrsFormID, SizeOf(TwbFormID));
  i := Length(mrReferences);
  aStream.Write(i, SizeOf(i));
  if i>0 then
    aStream.Write(mrReferences[0], SizeOf(TwbFormID) * i);
end;

procedure TwbMainRecord.ScanData;
var
  SelfRef : IwbContainerElementRef;
begin
  if not wbDelayLoadRecords then begin
    SelfRef := Self as IwbContainerElementRef;
    DoInit;
  end;
end;

procedure TwbMainRecord.SetChildGroup(const aGroup: IwbGroupRecord);
begin
  if Pointer(mrGroup) = Pointer(aGroup) then
    Exit;

  if Assigned(aGroup) then begin
    if not (not Assigned(mrGroup) or (mrGroup.Equals(aGroup))) then begin
      if not (not Assigned(mrGroup) or (mrGroup.Equals(aGroup))) then
        Assert(not Assigned(mrGroup) or (mrGroup.Equals(aGroup)), 'Found additional ' + mrGroup.Name + ' for ' + Self.GetName);
    end;
    if Assigned(eContainer) then
      IwbContainer(eContainer).Equals(aGroup.Container);
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
var
  ContainedIn: IwbContainedIn;
begin
  inherited;
  if csInit in cntStates then
    if Supports(GetElementBySortOrder(-2 + GetAdditionalElementCount), IwbContainedIn, ContainedIn) then
      ContainedIn.ContainerChanged;
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
  DoInit;

  Rec := GetRecordBySignature('EDID');
  if not Assigned(Rec) then begin
    i := mrDef.GetMemberIndexFor('EDID', nil);
    if i < 0 then
      Exit;
    Assign(i, nil, False);
    Rec := GetRecordBySignature('EDID');
    Assert(Assigned(Rec));
  end;

  if aValue = '' then
    Rec.Remove
  else
    Rec.EditValue := aValue;

  Assert(mrEditorID = aValue);
end;

procedure TwbMainRecord.SetEditValue(const aValue: string);
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

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
      DoInit;

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
        if not MainRecord.IsDeleted then begin
          for j := Pred(_File.MasterCount) downto 0 do
            if MainRecord._File.Equals(_File.Masters[j]) then begin
              Self.Assign(Low(Integer), MainRecord, False);
              Exit;
            end;
        end;
      end;

      if not Master.IsDeleted then
        Self.Assign(Low(Integer), Master, False);

    end;
  end;
end;

procedure TwbMainRecord.SetIsESL(aValue: Boolean);
begin
  if aValue <> GetIsESL then begin
    MakeHeaderWriteable;
    GetFlagsPtr.SetESL(aValue);
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
  _File: IwbFileInternal;
  i : Integer;
  Master: IwbMainRecord;
begin
  if GetLoadOrderFormID = aFormID then
    Exit;

  _File := GetFile as IwbFileInternal;

  aFormID := _File.LoadOrderFormIDtoFileFormID(aFormID);

  if GetFormID.ObjectID = aFormID.ObjectID then
    if (GetFormID.FileID.FullSlot >= _File.MasterCount) and (aFormID.FileID.FullSlot >= _File.MasterCount) then begin
      // we can do this relatively quietly and quickly...
      if Assigned(mrGroup) then
        Assert(mrGroup.GroupLabel = mrStruct.mrsFormID.ToCardinal);
      MakeHeaderWriteable;
      mrStruct.mrsFormID := aFormID;
      if Assigned(mrGroup) then
        mrGroup.GroupLabel := aFormID.ToCardinal;
      UpdateInteriorCellGroup;
      Exit;
    end;

  Master := _File.RecordByFormID[aFormID, False];
  if Assigned(Master) and ((Master._File as IwbFileInternal) = _File) then
    raise Exception.Create('FormID ['+aFormID.ToString(True)+'] is already present in file ' + _File.Name);

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
  mrFixedFormID := TwbFormID.Null;
  mrLoadOrderFormID := TwbFormID.Null;
  Exclude(mrStates, mrsIsInjectedChecked);
  mrConflictAll := caUnknown;
  mrConflictThis := ctUnknown;

  if Assigned(mrGroup) then
    Assert(mrGroup.GroupLabel = mrStruct.mrsFormID.ToCardinal);
  MakeHeaderWriteable;
  mrStruct.mrsFormID := aFormID;
  if Assigned(mrGroup) then
    mrGroup.GroupLabel := aFormID.ToCardinal;
  UpdateInteriorCellGroup;

  _File.AddMainRecord(Self);
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

procedure TwbMainRecord.SetNativeValue(const aValue: Variant);
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

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
  DoInit;

  if not Supports(GetRecordBySignature('DATA'), IwbContainerElementRef, DataRec) then
    Exit;

  if DataRec.ElementCount <> 2 then
    Exit;

  with aPosition, (DataRec.Elements[0] as IwbContainerElementRef) do begin
    if ElementCount <> 3 then
      Exit;

    Elements[0].NativeValue := X;
    Elements[1].NativeValue := Y;
    Elements[2].NativeValue := Z;
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
  Assert(not wbBuildingRefsParallel);
{$ENDIF}

  Exclude(mrStates, mrsReferencedByUnsorted);
  if mrReferencedByCount > 1  then
    wbMergeSort(@mrReferencedBy[0], mrReferencedByCount, CompareReferencedBy);
end;

procedure TwbMainRecord.UpdateCellChildGroup;
var
  OldTypeGroup      : IwbGroupRecord;
  OldChildGroup     : IwbGroupRecord;
  OldCellOwnerGroup : IwbGroupRecord;
  NewTypeGroup      : IwbGroupRecord;
  TempGroup         : IwbGroupRecord;
  TempGroup2        : IwbGroupRecord;
  NewChildGroup     : IwbGroupRecord;
  NewCellOwnerGroup : IwbGroupRecord;
  CorrectGroupType  : Integer;
  i                 : Integer;
  OldCell           : IwbMainRecord;
  NewCell           : IwbMainRecord;
  Worldspace        : IwbMainRecord;
  IsExterior        : Boolean;
  SelfRef           : IwbElement;
  Position          : TwbVector;
  GridCell          : TwbGridCell;
  SubBlock          : TwbGridCell;
  Block             : TwbGridCell;
  TempGridCell      : TwbGridCell;
  SubBlockLabel     : Cardinal;
  BlockLabel        : Cardinal;
begin
  SelfRef := Self as IwbElement;

  if not Supports(GetContainer, IwbGroupRecord, OldTypeGroup) then
    raise Exception.Create(GetName + ' is not contained in a group.');
  if not (OldTypeGroup.GroupType in [8, 9, 10]) then
    raise Exception.Create(GetName + ' is not contained in a group of type "Cell Persistent Childen", "Cell Temporary Children" or "Cell Visible Distant Children"');
  if not Supports(OldTypeGroup.Container, IwbGroupRecord, OldChildGroup) then
    raise Exception.Create(OldTypeGroup.GetName + ' is not contained in a group');
  if not (OldChildGroup.GroupType in [6]) then
    raise Exception.Create(OldTypeGroup.GetName + ' is not contained in a group of type "Cell Children"');

  if GetIsPersistent then
    CorrectGroupType := 8
  else if GetIsVisibleWhenDistant and not wbVWDInTemporary then
    CorrectGroupType := 10
  else
    CorrectGroupType := 9;

  if OldTypeGroup.GroupType = CorrectGroupType then
    Exit;

  OldCell := OldChildGroup.ChildrenOf;
  if not Assigned(OldCell) then
    raise Exception.Create(OldChildGroup.GetName + ' can not find its CELL record');
  if not OldCell.ElementExists['DATA'] then
    raise Exception.Create(OldCell.GetName + ' is missing its DATA subrecord');

  i := OldCell.GetElementNativeValue('DATA');
  IsExterior := (i and 1) = 0;
  if IsExterior then begin
    if not Supports(OldCell.Container, IwbGroupRecord, OldCellOwnerGroup) then
      raise Exception.Create(OldCell.GetName + ' is not contained in a group');
    if not (OldCellOwnerGroup.GroupType in [1, 5]) then
      raise Exception.Create(OldCell.GetName + ' is not contained in a group of type "World Childen" or "Exterior Cell Sub-Block"');
    if (CorrectGroupType = 8) then begin
      if OldCellOwnerGroup.GroupType <> 1 then begin

        if not Supports(OldCellOwnerGroup.Container, IwbGroupRecord, TempGroup) then
          raise Exception.Create(OldCellOwnerGroup.GetName + ' is not contained in a group');
        if not (TempGroup.GroupType in [4]) then
          raise Exception.Create(OldCellOwnerGroup.GetName + ' is not contained in a group of type "Exterior Cell Block"');

        if not Supports(TempGroup.Container, IwbGroupRecord, NewCellOwnerGroup) then
          raise Exception.Create(TempGroup.GetName + ' is not contained in a group');
        if not (NewCellOwnerGroup.GroupType in [1]) then
          raise Exception.Create(TempGroup.GetName + ' is not contained in a group of type "World Childen"');

        NewCell := nil;
        for i := 0 to Pred(NewCellOwnerGroup.ElementCount) do
          if Supports(NewCellOwnerGroup.Elements[i], IwbMainRecord, NewCell) then
            if NewCell.Signature <> 'CELL' then
              NewCell := nil
            else
              Break;

        if not Assigned(NewCell) then begin
          Worldspace := NewCellOwnerGroup.ChildrenOf;
          if not Assigned(Worldspace) then
            raise Exception.Create(NewCellOwnerGroup.GetName + ' can not find its WRLD record');
          Worldspace := Worldspace.MasterOrSelf;
          TempGroup := Worldspace.ChildGroup;
          if not Assigned(TempGroup) then
            raise Exception.Create(Worldspace.GetName + ' can not find its child group');

          for i := 0 to Pred(TempGroup.ElementCount) do
            if Supports(TempGroup.Elements[i], IwbMainRecord, NewCell) then
              if NewCell.Signature <> 'CELL' then
                NewCell := nil
              else
                Break;

          if Assigned(NewCell) then
            NewCell := wbCopyElementToFile(NewCell, GetFile, False, True, '', '', '') as IwbMainRecord;
        end;

        if not Assigned(NewCell) then
          raise Exception.Create('Could not determine CELL for persistent exterior references');

        NewChildGroup := NewCell.EnsureChildGroup;
      end else
        NewChildGroup := OldChildGroup;
    end else begin
      if OldCellOwnerGroup.GroupType <> 5 then begin

        if not GetPosition(Position) then
          raise Exception.Create('Could not determine position of ' + GetName);

        GridCell := wbPositionToGridCell(Position);
        SubBlock := wbSubBlockFromGridCell(GridCell);
        Block := wbBlockFromSubBlock(SubBlock);

        SubBlockLabel := wbGridCellToGroupLabel(SubBlock);
        BlockLabel := wbGridCellToGroupLabel(Block);

        NewCell := nil;
        TempGroup := nil;
        for i := 0 to Pred(OldCellOwnerGroup.ElementCount) do
          if Supports(OldCellOwnerGroup.Elements[i], IwbGroupRecord, TempGroup) then
            if (TempGroup.GroupType = 4) and (TempGroup.GroupLabel = BlockLabel) then
              Break
            else
              TempGroup := nil;

        if Assigned(TempGroup) then begin
          NewCellOwnerGroup := nil;
          for i := 0 to Pred(TempGroup.ElementCount) do
            if Supports(TempGroup.Elements[i], IwbGroupRecord, NewCellOwnerGroup) then
              if (NewCellOwnerGroup.GroupType = 5) and (NewCellOwnerGroup.GroupLabel = SubBlockLabel) then
                Break
              else
                NewCellOwnerGroup := nil;
          if Assigned(NewCellOwnerGroup) then
            for i := 0 to Pred(NewCellOwnerGroup.ElementCount) do
              if Supports(NewCellOwnerGroup.Elements[i], IwbMainRecord, NewCell) then
                if NewCell.GetGridCell(TempGridCell) and (GridCell.x = TempGridCell.x) and (GridCell.y = TempGridCell.y) then
                  Break
                else
                  NewCell := nil;
        end;

        if not Assigned(NewCell) then begin
          Worldspace := OldCellOwnerGroup.ChildrenOf;
          if not Assigned(Worldspace) then
            raise Exception.Create(OldCellOwnerGroup.GetName + ' can not find its WRLD record');
          Worldspace := Worldspace.MasterOrSelf;
          TempGroup2 := Worldspace.ChildGroup;
          if not Assigned(TempGroup2) then
            raise Exception.Create(Worldspace.GetName + ' can not find its child group');

          TempGroup := nil;
          for i := 0 to Pred(TempGroup2.ElementCount) do
            if Supports(TempGroup2.Elements[i], IwbGroupRecord, TempGroup) then
              if (TempGroup.GroupType = 4) and (TempGroup.GroupLabel = BlockLabel) then
                Break
              else
                TempGroup := nil;

          if Assigned(TempGroup) then begin
            NewCellOwnerGroup := nil;
            for i := 0 to Pred(TempGroup.ElementCount) do
              if Supports(TempGroup.Elements[i], IwbGroupRecord, NewCellOwnerGroup) then
                if (NewCellOwnerGroup.GroupType = 5) and (NewCellOwnerGroup.GroupLabel = SubBlockLabel) then
                  Break
                else
                  NewCellOwnerGroup := nil;
            if Assigned(NewCellOwnerGroup) then
              for i := 0 to Pred(NewCellOwnerGroup.ElementCount) do
                if Supports(NewCellOwnerGroup.Elements[i], IwbMainRecord, NewCell) then
                  if NewCell.GetGridCell(TempGridCell) and (GridCell.x = TempGridCell.x) and (GridCell.y = TempGridCell.y) then
                    Break
                  else
                    NewCell := nil;
          end;

          if Assigned(NewCell) then
            NewCell := wbCopyElementToFile(NewCell, GetFile, False, True, '', '', '') as IwbMainRecord;
        end;

        if not Assigned(NewCell) then
          raise Exception.Create('Could not determine CELL for persistent exterior references');

        NewChildGroup := NewCell.EnsureChildGroup;
      end else
        NewChildGroup := OldChildGroup;
    end;
  end else
    NewChildGroup := OldChildGroup;

  if not Assigned(NewChildGroup) then
    raise Exception.Create('Could not determine new CELL child group');

  NewTypeGroup := nil;
  for i := 0 to Pred(NewChildGroup.ElementCount) do
    if Supports(NewChildGroup.Elements[i], IwbGroupRecord, NewTypeGroup) then
      if NewTypeGroup.GroupType = CorrectGroupType then
        Break
      else
        NewTypeGroup := nil;

  if not Assigned(NewTypeGroup) then
    NewTypeGroup := TwbGroupRecord.Create(NewChildGroup, CorrectGroupType, NewChildGroup.ChildrenOf);

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

  Block        : Integer;
  SubBlock     : Integer;

  SelfRef      : IwbElement;
begin
  SelfRef := Self as IwbElement;

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

  s := '00' + IntToStr(mrStruct.mrsFormID.ObjectID);
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

procedure TwbMainRecord.UpdateRefs;
begin
  if (csRefsBuild in cntStates) then
    BuildRef;
end;

procedure TwbMainRecord.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
var
  CurrentPosition   : Int64;
  NewPosition       : Int64;
  DataSize          : Cardinal;
  MemoryStream      : TMemoryStream;
  mrs               : TwbMainRecordStruct;
var
  SelfRef : IwbContainerElementRef;
begin
  if (esModified in eStates) or wbTestWrite then begin
    SelfRef := Self as IwbContainerElementRef;
    DoInit;

    CurrentPosition := aStream.Position;

    mrs := mrStruct^;
//    mrs.mrsFlags2 := 0;

    aStream.WriteBuffer(mrs, wbSizeOfMainRecordStruct );

    if wbForceNewHeader then
      aStream.WriteBuffer(wbNewHeaderAddon, SizeOf(wbNewHeaderAddon) );

    if mrStruct.mrsFlags.IsCompressed then begin

      MemoryStream := TMemoryStream.Create;
      try
        inherited WriteToStreamInternal(MemoryStream, aResetModified);
        DataSize := MemoryStream.Size;
        aStream.WriteBuffer(DataSize, SizeOf(DataSize));
        MemoryStream.Position := 0;
        ZCompressStream(MemoryStream, aStream);
      finally
        FreeAndNil(MemoryStream);
      end;

    end else
      inherited;

    NewPosition := aStream.Position;
    if wbForceNewHeader then
      DataSize := (NewPosition - CurrentPosition) - wbSizeOfMainRecordStruct - SizeOf(wbNewHeaderAddon)
    else
      DataSize := (NewPosition - CurrentPosition) - wbSizeOfMainRecordStruct;
    aStream.Position := CurrentPosition + 4;
    aStream.WriteBuffer(DataSize, SizeOf(DataSize));
    aStream.Position := NewPosition;

  end else begin
    CurrentPosition := aStream.Position;
    aStream.WriteBuffer(dcBasePtr^, NativeUInt(dcEndPtr) - NativeUInt(dcBasePtr));
    if CurrentPosition + wbSizeOfMainRecordStruct + mrStruct.mrsDataSize <> aStream.Position then
      Assert(CurrentPosition + wbSizeOfMainRecordStruct + mrStruct.mrsDataSize <> aStream.Position);
  end;

  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
  end;
end;

procedure TwbMainRecord.YouAreTheMaster(const aOverrides, aReferencedBy: TDynMainRecords; aReferencedByCount: Integer);
var
  i: Integer;
  FileID: Integer;
  _File: IwbFile;
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
  for i := Low(mrOverrides) to High(mrOverrides) do
    (mrOverrides[i] as IwbMainRecordInternal).SetMaster(Self);
  Exclude(mrStates, mrsOverridesSorted);
  mrMasterAndLeafs := nil;

  mrReferencedBy := aReferencedBy;
  mrReferencedBySize := Length(mrReferencedBy);
  mrReferencedByCount := aReferencedByCount;

  for i := 0 to Pred(mrReferencedByCount) do
    (mrReferencedBy[i] as IwbMainRecordInternal).SetReferencesInjected(True);

  FileID := GetFormID.FileID.FullSlot;
  _File := GetFile;
  Assert(FileID < _File.MasterCount);

  (_File.Masters[FileID] as IwbFileInternal).InjectMainRecord(Self);
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

function TwbSubRecord.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  SelfRef    : IwbContainerElementRef;
  i          : Integer;
  s          : string;
  ArrayDef   : IwbArrayDef;
  StructDef  : IwbStructDef;
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be modified.');

  SelfRef := Self as IwbContainerElementRef;

  DoInit;

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
              Result.Assign(Low(Integer), aElement, False);
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
              Result.Assign(Low(Integer), aElement, not aDeepCopy);
            except
              Result := nil;
              raise;
            end;
          end else case ArrayDef.Element.DefType of
            dtArray: Result := TwbArray.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
            dtStruct: Result := TwbStruct.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
            dtStructChapter: Result := TwbChapter.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
            dtUnion: Result := TwbUnion.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
          else
            Result := TwbValue.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
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

        Assert(StructDef.Members[aElement.SortOrder].CanAssign(Result, Low(Integer), aElement.ValueDef));

        if not aDeepCopy then
          if Supports(Result.ValueDef, IwbIntegerDef, IntegerDef) then
            if Supports(IntegerDef.Formater[Result], IwbFlagsDef, FlagsDef) then
              Exit(Result);

        Result.Assign(Low(Integer), aElement, not aDeepCopy);
      end;
      dtUnion: begin
        inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);
      end;
    else
      inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);
    end;

  end else
    inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);
end;

function TwbSubRecord.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Element   : IwbElement;
  ArrayDef  : IwbArrayDef;
  Container : IwbContainer;
  s         : string;
  i         : Integer;
  SelfRef   : IwbContainerElementRef;
  p, q      : Pointer;
begin
  Result := nil;

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if Assigned(srValueDef) then begin

    case srValueDef.DefType of
      dtRecord, dtSubRecord, dtSubRecordArray, dtSubRecordStruct: Assert(False);
      dtArray: begin

        ArrayDef := srValueDef as IwbArrayDef;

        if (aIndex = Low(Integer)) and ArrayDef.CanAssign(Self, aIndex, aElement.ValueDef) then begin

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
              RequestStorageChange(p, q, 4);

            for i := 0 to Pred(Container.ElementCount) do
              Assign(i, Container.Elements[i], aOnlySK);
          end else begin
            Assert(Container.ElementCount = ArrayDef.ElementCount);
            Assert(GetElementCount = ArrayDef.ElementCount);

            for i := 0 to Pred(Container.ElementCount) do
              cntElements[i].Assign(Low(Integer), Container.Elements[i], aOnlySK);
          end;

        end else begin
          if (aIndex >= 0) and (ArrayDef.ElementCount <= 0) and ((aIndex = High(Integer)) or ArrayDef.Element.CanAssign(Self, Low(Integer), aElement.ValueDef)) then begin
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
                Result.Assign(Low(Integer), aElement, aOnlySK);
              except
                Result := nil;
                raise;
              end;
            end else begin
              Element := nil;
              if not Supports(aElement, IwbStringListTerminator) then
                case ArrayDef.Element.DefType of
                  dtArray: Element := TwbArray.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
                  dtStruct: Element := TwbStruct.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
                  dtStructChapter: Element := TwbChapter.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
                  dtUnion: Element := TwbUnion.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
                else
                  Element := TwbValue.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
                end;
              Result := Element;
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

procedure TwbSubRecord.BuildRef;
var
  SelfRef: IwbElement;
begin
  SelfRef := Self as IwbContainerElementRef;

  if Assigned(srDef) then begin
    DoInit;

    if Assigned(srValueDef) then
      srValueDef.BuildRef(GetDataBasePtr, dcDataEndPtr, Self);
  end;

  inherited;
end;

function TwbSubRecord.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  ArrayDef: IwbArrayDef;
begin
  Result := False;
  if not wbEditAllowed then
    Exit;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  if srsIsArray in srStates then begin
    ArrayDef := srValueDef as IwbArrayDef;
    if not Assigned(aElement) then begin
      if aIndex = High(Integer) then
        Result := ArrayDef.ElementCount <= 0;
      Exit;
    end;
    Result :=
       ArrayDef.CanAssign(Self, aIndex, aElement.ValueDef) or
       ( (ArrayDef.ElementCount <= 0) and ArrayDef.Element.CanAssign(Self, Low(Integer), aElement.ValueDef) );
  end else begin
    if not Assigned(aElement) then
      Exit;

    Result := inherited CanAssignInternal(aIndex, aElement, aCheckDontShow);
    if not Result and Assigned(srDef) then
      Result := srDef.CanAssign(Self, aIndex, aElement.Def);
  end;
end;

function TwbSubRecord.CanContainFormIDs: Boolean;
begin
  Result := Assigned(srDef) and srDef.CanContainFormIDs;
end;

function TwbSubRecord.CanMoveElement: Boolean;
begin
  Result := srStates * [srsIsArray, srsSorted] = [srsIsArray];
end;

function TwbSubRecord.CanElementReset: Boolean;
begin
//  Result := inherited CanElementReset;
  Result := cntElementRefs < 1;
end;

procedure TwbSubRecord.CheckCount;
var
  Count       : Cardinal;
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

function Resolve(const aValueDef: IwbValueDef; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): IwbValueDef;
var
  Internal  : IwbElementInternal;
  UnionDef  : IwbUnionDef;
  CanDecide : Boolean;
begin
  Result := aValueDef;

  Supports(aElement, IwbElementInternal, Internal);
  CanDecide := False;
  try
    while Supports(Result, IwbUnionDef, UnionDef) do begin
      CanDecide := CanDecide or (Assigned(Internal) and Internal.BeginDecide);
      if CanDecide then
        Result := UnionDef.Decide(aBasePtr,aEndPtr,aElement)
      else
        break;
    end;
  finally
    if CanDecide then
      Internal.EndDecide;
  end;
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

  DoInit;

  Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);

  ResolvedDef := Resolve(srValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    Result := ResolvedDef.CompareExchangeFormID(GetDataBasePtr, dcDataEndPtr, Self, aOldFormID, aNewFormID) or Result;
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
  Create(aContainer, BasePtr, nil, nil);

  DoInit;

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
    FreeMem(dcBasePtr, SizeOf(TwbSubRecordHeaderStruct) );
  inherited;
end;

function TwbSubRecord.DoCheckSizeAfterWrite: Boolean;
begin
  Result := True;
end;

procedure TwbSubRecord.DoInit;
begin
  inherited;
  if srStates * [srsSorted, srsSortInvalid] = [srsSorted, srsSortInvalid] then begin
    if Length(cntElements) > 1 then
      wbMergeSort(@cntElements[0], Length(cntElements), CompareSortKeys);
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

  DoInit;

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

  if Assigned(ValueDef) then
    if ValueDef.Name = '' then begin
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
          case UnionDoInit(ValueDef, Self, BasePtr, dcDataEndPtr) of
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
        if ValueDoInit(ValueDef, Self, BasePtr, dcDataEndPtr, Self) then begin
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
        dtUnion: Element := TwbUnion.Create(Self, BasePtr, dcDataEndPtr, ValueDef, '');
      else
        Element := TwbValue.Create(Self, BasePtr, dcDataEndPtr, ValueDef, '');
      end;

  if Assigned(dcDataEndPtr) and Assigned(BasePtr) and (BasePtr <> dcDataEndPtr) then begin
    HasUnusedData := not SameText(ValueDef.Name, 'Unused');
    if HasUnusedData and (ValueDef.DefType = dtString) then begin
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
      if wbHasProgressCallback then
        wbProgressCallback('<Warning: Unused data in: ' + GetFullPath + '>');
      {$ENDIF}
    end;
  end;

  srDef.AfterLoad(Self);
end;

function TwbSubRecord.GetCheck: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(srDef) then
    Exit;
  DoInit;

  if Assigned(srValueDef) then
    Result := srValueDef.Check(GetDataBasePtr, dcDataEndPtr, Self);
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

  DoInit;

  if not Assigned(dcDataBasePtr) and Assigned(srValueDef) and not (dcfStorageInvalid in dcFlags) then begin
    Result := srValueDef.DefaultSize[nil, nil, Self];
    Assert(Result <> Cardinal(High(Integer)));
  end else
    Result := inherited GetDataSize;
end;

function TwbSubRecord.GetDef: IwbNamedDef;
begin
  Result := srDef;
end;

function TwbSubRecord.GetDisplayName: string;
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
end;

function TwbSubRecord.GetEditValue: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;

  Result := '';

  if not Assigned(srDef) then
    Exit;
  DoInit;

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

  if Assigned(eContainer) and not IwbContainer(eContainer).IsElementEditable(SelfRef) then
    Exit;

  if not Assigned(srDef) then
    Exit;
  DoInit;

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
  DoInit;

  if not Supports(srValueDef, IwbHasSortKeyDef, HasSortKey) then
    Exit;

  Result := HasSortKey.IsInSK(aIndex);
end;

function TwbSubRecord.GetLinksTo: IwbElement;
var
  SelfRef: IwbContainerElementRef;
begin
  Result := nil;
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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
  DoInit;

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
  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(srValueDef) then
    DoInit;

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
  DoInit;

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

function TwbSubRecord.GetValue: string;
var
//  i : Integer;
//  j : Int64;
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

  if not Assigned(srDef) then
    Exit;
  DoInit;

  if Assigned(srValueDef) then
    Result := srValueDef.ToString(GetDataBasePtr, dcDataEndPtr, Self);
end;

function TwbSubRecord.GetValueDef: IwbValueDef;
var
  SelfRef : IwbContainerElementRef;
begin
  if not Assigned(srValueDef) or ((srsIsUnion in srStates) and not (csInit in cntStates)) then begin
    SelfRef := Self as IwbContainerElementRef;
    DoInit;
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

  SizeNeeded := SizeOf(TwbSubRecordHeaderStruct);
  SizeAvailable := NativeUInt(aEndPtr) - NativeUInt(aBasePtr);
  Assert( SizeAvailable >= SizeNeeded );

  BasePtr := aBasePtr;
  Inc(PByte(aBasePtr), SizeNeeded );
  inherited;

  Assert(srStruct.srsDataSize = NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr));

  dcBasePtr := BasePtr;
  dcEndPtr := dcDataEndPtr;
end;

procedure TwbSubRecord.InitDataPtr;
var
  lDataSize  : Cardinal;
  LastRecord : IwbElement;
  Container  : IwbContainer;
begin
  if Assigned(dcBasePtr) then begin
    dcDataBasePtr := PByte(dcBasePtr) + SizeOf(TwbSubRecordHeaderStruct);

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
    GetMem(dcBasePtr, SizeOf(TwbSubRecordHeaderStruct) );
    if Assigned(srDef) then
      srStruct.srsSignature := srDef.DefaultSignature
    else
      srStruct.srsSignature := NONE;
  end;
end;

function TwbSubRecord.IsElementRemoveable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement)
    and (srsIsArray in srStates)
    and Assigned(srValueDef)
    and ((srValueDef as IwbArrayDef).ElementCount <= 0) and (Length(cntElements)>1);
end;

function TwbSubRecord.IsFlags: Boolean;
begin
  Result := srsIsFlags in srStates;
end;

procedure TwbSubRecord.MasterCountUpdated(aOld, aNew: Byte);
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(srDef) then
    Exit;

  DoInit;

  inherited MasterCountUpdated(aOld, aNew);

  ResolvedDef := Resolve(srValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.MasterCountUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew);
end;

procedure TwbSubRecord.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  if not Assigned(srDef) then
    Exit;

  DoInit;

  inherited MasterIndicesUpdated(aOld, aNew);

  ResolvedDef := Resolve(srValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.MasterIndicesUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew);
end;

procedure TwbSubRecord.MergeStorageInternal(var aBasePtr: Pointer; aEndPtr: Pointer);
var
  SizeNeeded    : Cardinal;
  SizeAvailable : Cardinal;
  BasePtr       : Pointer;
begin
  Assert(Assigned(dcBasePtr));
  SizeNeeded := SizeOf(TwbSubRecordHeaderStruct);
  SizeAvailable := NativeUInt(aEndPtr) - NativeUInt(aBasePtr);
  Assert( SizeAvailable >= SizeNeeded );

  BasePtr := aBasePtr;
  Move(dcBasePtr^, aBasePtr^, SizeNeeded);
  Inc(PByte(aBasePtr), SizeNeeded );
  inherited;

  if not Assigned(dcEndPtr) then
    FreeMem(dcBasePtr, SizeNeeded);

  dcBasePtr := BasePtr;
  dcEndPtr := dcDataEndPtr;
  srStruct.srsDataSize := NativeUInt(dcDataEndPtr) - NativeUInt(dcDataBasePtr);
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
  DoInit;

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
  if Result and aCanRemove and GetIsRemoveable then begin
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
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

  SelfRef := Self as IwbContainerElementRef;
  if not Assigned(srDef) then
    if aValue <> '' then
      raise Exception.Create(GetName + ' can not be edited')
    else
      Exit;

  DoInit;

  if GetEditValue <> aValue then begin
    if Assigned(srValueDef) then begin
      OldValue := GetNativeValue;
      srValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
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
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

  SelfRef := Self as IwbContainerElementRef;
  if not Assigned(srDef) then
    raise Exception.Create(GetName + ' can not be edited');

  DoInit;

  if Assigned(srValueDef) then begin
    OldValue := GetNativeValue;
    srValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
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

procedure TwbSubRecord.SetToDefaultInternal;
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
  DoInit;
  if Assigned(srValueDef) then
    RequestStorageChange(BasePtr, EndPtr, srValueDef.DefaultSize[nil, nil, Self]);
  inherited;
end;

function TwbSubRecord.srStruct: PwbSubRecordHeaderStruct;
begin
  Result := PwbSubRecordHeaderStruct(dcBasePtr);
end;

procedure TwbSubRecord.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
var
  CurrentPosition   : Int64;
  NewPosition       : Int64;
  BigDataSize       : Cardinal;
  SubHeader         : TwbSubRecordHeaderStruct;
  SelfRef           : IwbContainerElementRef;
begin
  if (esModified in eStates) or wbTestWrite or (srStruct.srsDataSize = 0) then begin
    SelfRef := Self as IwbContainerElementRef;
    DoInit;

    BigDataSize := GetDataSize;
    if BigDataSize > High(Word) then begin
      SubHeader.srsSignature := 'XXXX';
      SubHeader.srsDataSize := SizeOf(Cardinal);
      aStream.WriteBuffer(SubHeader, SizeOf(TwbSubRecordHeaderStruct) );
      aStream.WriteBuffer(BigDataSize, SizeOf(BigDataSize) );
      SubHeader.srsSignature := srStruct.srsSignature;
      SubHeader.srsDataSize := 0;
    end else begin
      SubHeader.srsSignature := srStruct.srsSignature;
      SubHeader.srsDataSize := BigDataSize;
    end;

    aStream.WriteBuffer(SubHeader, SizeOf(TwbSubRecordHeaderStruct) );
    CurrentPosition := aStream.Position;
    inherited;
    NewPosition := aStream.Position;
    if BigDataSize <> NewPosition - CurrentPosition then
      Assert(BigDataSize = NewPosition - CurrentPosition );

  end else begin
    aStream.WriteBuffer(dcBasePtr^, SizeOf(TwbSubRecordHeaderStruct) );
    CurrentPosition := aStream.Position;
    inherited;
    if CurrentPosition + srStruct.srsDataSize <> aStream.Position then
      Assert(CurrentPosition + srStruct.srsDataSize = aStream.Position);
  end;

  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
  end;
end;

{ TwbGroupRecord }

function TwbGroupRecord.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  Signature : TwbSignature;
  FormID    : TwbFormID;
  _File     : IwbFile;
  MainRecord: IwbMainRecord;
  IsInjected: Boolean;
  Group     : IwbGroupRecord;
  i         : Integer;

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
      for i := 0 to GetElementCount do
        if Supports(GetElement(i), IwbGroupRecord, Group) then
          if (Group.GroupType = 9) and (Group.GroupLabel = GetGroupLabel) then
            Break
          else
            Group := nil;
      if not Assigned(Group) then
        Group := TwbGroupRecord.Create(Self, 9, GetGroupLabel);

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

  if aSilent then
    FormID := _File.NewFormID
  else
    FormID := _File.LoadOrderFormIDtoFileFormID(wbGetFormID(Self));
  if FormID.IsNull then
    Exit;

  IsInjected := False;
  MainRecord := _File.RecordByFormID[FormID, True];
  if Assigned(MainRecord) then begin
    if _File.Equals(MainRecord._File) then
      raise Exception.Create('FormID ['+FormID.ToString(True)+'] is already defined in file "'+_File.Name+'"');

    IsInjected := FormID.FileID.FullSlot = _File.MasterCount;

    if MainRecord.Signature <> Signature then
      raise Exception.Create('Existing record '+MainRecord.Name+' has different signature');
  end;

  Result := TwbMainRecord.Create(Self, Signature, FormID);
  if IsInjected then
    (MainRecord as IwbMainRecordInternal).YouGotAMaster(Result as IwbMainRecord);
  if csRefsBuild in _File.ContainerStates then
    Result.BuildRef;
end;

function RemovePrefix(const s, aPrefix: string): string;
begin
  if SameText(Copy(s, 1, Length(aPrefix)), aPrefix) then
    Result := Copy(s, Succ(Length(aPrefix)), High(Integer))
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
                      InsertElement(i+1, aElement);
                      Exit;
                    end;
    inherited;
end;

function TwbGroupRecord.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  MainRecord   : IwbMainRecord;
  MainRecord2  : IwbMainRecord;
  FormID       : TwbFormID;
  i            : Integer;
  SelfRef      : IwbContainerElementRef;
  s            : string;
  GroupRecord  : IwbGroupRecord;
  GroupRecord2 : IwbGroupRecord;
begin
  Result := nil;
  SelfRef := Self as IwbContainerElementRef;
  case grStruct.grsGroupType of
    0: begin
      if TwbSignature(grStruct.grsLabel) = 'DIAL' then begin
        if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
          if GroupRecord.GroupType <> 7 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          MainRecord := GroupRecord.ChildrenOf;
          if not Assigned(MainRecord) then
            raise Exception.Create('Can''t find record for '+ GroupRecord.Name);
          MainRecord := MainRecord.HighestOverrideOrSelf[GetFile.LoadOrder];
          MainRecord := AddIfMissingInternal(MainRecord, aAsNew, True, aPrefixRemove, aPrefix, aSuffix) as IwbMainRecord;
          Assert(Assigned(MainRecord));
          Result := MainRecord.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 7, MainRecord);

          GroupRecord2 := Result as IwbGroupRecord;
          if aDeepCopy then
            for i := 0 to Pred(GroupRecord.ElementCount) do
              GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

          Exit;
        end;
      end else if TwbSignature(grStruct.grsLabel) = 'CELL' then begin
        if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
          if GroupRecord.GroupType <> 2 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          if GroupRecord.GroupLabel > 9 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          for i := 0 to Pred(GetElementCount) do
            if Supports(GetElement(i), IwbGroupRecord, GroupRecord2) then begin
              if (GroupRecord2.GroupType = 2) and (GroupRecord2.GroupLabel = GroupRecord.GroupLabel) then begin
                Result := GroupRecord2;
                break;
              end;
            end;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 2, GroupRecord.GroupLabel);

          GroupRecord2 := Result as IwbGroupRecord;
          if aDeepCopy then
            for i := 0 to Pred(GroupRecord.ElementCount) do
              GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

          Exit;
        end;
      end else if TwbSignature(grStruct.grsLabel) = 'WRLD' then begin
        if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
          if GroupRecord.GroupType <> 1 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          MainRecord := GroupRecord.ChildrenOf;
          if not Assigned(MainRecord) then
            raise Exception.Create('Can''t find record for '+ GroupRecord.Name);
          MainRecord := MainRecord.HighestOverrideOrSelf[GetFile.LoadOrder];
          MainRecord := AddIfMissingInternal(MainRecord, aAsNew, True, aPrefixRemove, aPrefix, aSuffix) as IwbMainRecord;
          Assert(Assigned(MainRecord));
          Result := MainRecord.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 1, MainRecord);

          GroupRecord2 := Result as IwbGroupRecord;
          if aDeepCopy then
            for i := 0 to Pred(GroupRecord.ElementCount) do
              GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

          Exit;
        end;
      end else if wbVWDAsQuestChildren and (TwbSignature(grStruct.grsLabel) = 'QUST') then begin
        if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
          if GroupRecord.GroupType <> 10 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          MainRecord := GroupRecord.ChildrenOf;
          if not Assigned(MainRecord) then
            raise Exception.Create('Can''t find record for '+ GroupRecord.Name);
          MainRecord := MainRecord.HighestOverrideOrSelf[GetFile.LoadOrder];
          MainRecord := AddIfMissingInternal(MainRecord, aAsNew, True, aPrefixRemove, aPrefix, aSuffix) as IwbMainRecord;
          Assert(Assigned(MainRecord));
          Result := MainRecord.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 10, MainRecord);

          GroupRecord2 := Result as IwbGroupRecord;
          if aDeepCopy then
            for i := 0 to Pred(GroupRecord.ElementCount) do
              GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

          Exit;
        end;
      end;
      if not Supports(aElement, IwbMainRecord, MainRecord) then
        raise Exception.Create('Only main records can be added to top level groups');
      if MainRecord.Signature <> TwbSignature(grStruct.grsLabel) then
        raise Exception.Create('Can''t add main record with signature '+MainRecord.Signature+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));

      if aAsNew then
        FormID := GetFile.NewFormID
      else begin
        FormID := GetFile.LoadOrderFormIDtoFileFormID(MainRecord.LoadOrderFormID);
        for i := Low(cntElements) to High(cntElements) do
          if Supports(cntElements[i], IwbMainRecord, MainRecord2) then
            if MainRecord2.FixedFormID = FormID then begin
              Result := MainRecord2;
              exit;
            end;
      end;

      Result := TwbMainRecord.Create(Self, MainRecord.Signature, FormID);
      if aDeepCopy then begin
        Result.Assign(Low(Integer), aElement, False);
        if (aPrefix <> '') or (aSuffix <> '') then
          with Result as IwbMainRecord do begin
            s := EditorID;
            s := RemovePrefix(s, aPrefixRemove);
            if s <> '' then
              EditorID := aPrefix + s + aSuffix;
          end;
      end;

      if not aAsNew and MainRecord.IsMaster and (Result._File.LoadOrder <= MainRecord._File.LoadOrder) then
        if Supports(Result, IwbMainRecord, MainRecord2) then
          (MainRecord as IwbMainRecordInternal).YouGotAMaster(MainRecord2);
      if Assigned(Result) and (csRefsBuild in Result._File.ContainerStates) then
        Result.BuildRef;
    end;
    1: begin
        if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
          if GroupRecord.GroupType = 4 then begin
            for i := 0 to Pred(GetElementCount) do
              if Supports(GetElement(i), IwbGroupRecord, GroupRecord2) then begin
                if (GroupRecord2.GroupType = GroupRecord.GroupType) and (GroupRecord2.GroupLabel = GroupRecord.GroupLabel) then begin
                  Result := GroupRecord2;
                  break;
                end;
              end;
            if not Assigned(Result) then
              Result := TwbGroupRecord.Create(Self, 4, GroupRecord.GroupLabel);

            GroupRecord2 := Result as IwbGroupRecord;
            if aDeepCopy then
              for i := 0 to Pred(GroupRecord.ElementCount) do
                GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

            Exit;
          end;
          if GroupRecord.GroupType <> 6 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          MainRecord := GroupRecord.ChildrenOf;
          if not Assigned(MainRecord) then
            raise Exception.Create('Can''t find record for '+ GroupRecord.Name);
          MainRecord := MainRecord.HighestOverrideOrSelf[GetFile.LoadOrder];
          MainRecord := AddIfMissingInternal(MainRecord, aAsNew, True, aPrefixRemove, aPrefix, aSuffix) as IwbMainRecord;
          Assert(Assigned(MainRecord));
          Result := MainRecord.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 6, MainRecord);

          GroupRecord2 := Result as IwbGroupRecord;
          if aDeepCopy then
            for i := 0 to Pred(GroupRecord.ElementCount) do
              GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

          Exit;
        end;
      if not Supports(aElement, IwbMainRecord, MainRecord) then
        raise Exception.Create('Only main records can be added to ' + GetName);
      if (MainRecord.Signature <> 'CELL') and (MainRecord.Signature <> 'ROAD') then
        raise Exception.Create('Can''t add main record with signature '+MainRecord.Signature+' to ' + GetName);

      if aAsNew then
        raise Exception.Create('Can''t copy record '+MainRecord.Name+' as new record.')
      else begin
        FormID := GetFile.LoadOrderFormIDtoFileFormID(MainRecord.LoadOrderFormID);
        for i := Low(cntElements) to High(cntElements) do
          if Supports(cntElements[i], IwbMainRecord, MainRecord2) then
            if MainRecord2.FixedFormID = FormID then begin
              Result := MainRecord2;
              exit;
            end;
      end;
      Result := TwbMainRecord.Create(Self, MainRecord.Signature, FormID);
      if aDeepCopy then begin
        Result.Assign(Low(Integer), aElement, False);
        if (aPrefix <> '') or (aSuffix <> '') then
          with Result as IwbMainRecord do begin
            s := EditorID;
            s := RemovePrefix(s, aPrefixRemove);
            if s <> '' then
              EditorID := aPrefix + s + aSuffix;
          end;
      end;
      if not aAsNew and MainRecord.IsMaster and (Result._File.LoadOrder <= MainRecord._File.LoadOrder) then
        if Supports(Result, IwbMainRecord, MainRecord2) then
          (MainRecord as IwbMainRecordInternal).YouGotAMaster(MainRecord2);
      if Assigned(Result) and (csRefsBuild in Result._File.ContainerStates) then
        Result.BuildRef;
    end;
    2, 4: begin
      if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
        if GroupRecord.GroupType <> grStruct.grsGroupType + 1 then
          raise Exception.Create('Can''t add '+GroupRecord.Name+' to ' + GetName);
        for i := 0 to Pred(GetElementCount) do
          if Supports(GetElement(i), IwbGroupRecord, GroupRecord2) then begin
            if (GroupRecord2.GroupType = GroupRecord.GroupType) and (GroupRecord2.GroupLabel = GroupRecord.GroupLabel) then begin
              Result := GroupRecord2;
              break;
            end;
          end;
        if not Assigned(Result) then
          Result := TwbGroupRecord.Create(Self, GroupRecord.GroupType, GroupRecord.GroupLabel);

        GroupRecord2 := Result as IwbGroupRecord;
        if aDeepCopy then
          for i := 0 to Pred(GroupRecord.ElementCount) do
            GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

        Exit;
      end;
      raise Exception.Create('Can''t add ' + aElement.Name + ' to ' + GetName);
    end;
    3, 5: begin
        if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
          if GroupRecord.GroupType <> 6 then
            raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
          MainRecord := GroupRecord.ChildrenOf;
          if not Assigned(MainRecord) then
            raise Exception.Create('Can''t find record for '+ GroupRecord.Name);
          MainRecord := MainRecord.HighestOverrideOrSelf[GetFile.LoadOrder];
          MainRecord := AddIfMissingInternal(MainRecord, aAsNew, True, aPrefixRemove, aPrefix, aSuffix) as IwbMainRecord;
          Assert(Assigned(MainRecord));
          Result := MainRecord.ChildGroup;
          if not Assigned(Result) then
            Result := TwbGroupRecord.Create(Self, 6, MainRecord);

          GroupRecord2 := Result as IwbGroupRecord;
          if aDeepCopy then
            for i := 0 to Pred(GroupRecord.ElementCount) do
              GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

          Exit;
        end;
      if not Supports(aElement, IwbMainRecord, MainRecord) then
        raise Exception.Create('Only main records can be added to ' + GetName);
      if MainRecord.Signature <> 'CELL' then
        raise Exception.Create('Can''t add main record with signature '+MainRecord.Signature+' to ' + GetName);

      if aAsNew then
        raise Exception.Create('Can''t copy record '+MainRecord.Name+' as new record.')
      else begin
        FormID := GetFile.LoadOrderFormIDtoFileFormID(MainRecord.LoadOrderFormID);
        for i := Low(cntElements) to High(cntElements) do
          if Supports(cntElements[i], IwbMainRecord, MainRecord2) then
            if MainRecord2.FixedFormID = FormID then begin
              Result := MainRecord2;
              exit;
            end;
      end;
      Result := TwbMainRecord.Create(Self, MainRecord.Signature, FormID);
      if aDeepCopy then begin
        Result.Assign(Low(Integer), aElement, False);
        if (aPrefix <> '') or (aSuffix <> '') then
          with Result as IwbMainRecord do begin
            s := EditorID;
            s := RemovePrefix(s, aPrefixRemove);
            if s <> '' then
              EditorID := aPrefix + s + aSuffix;
          end;
      end;
      if not aAsNew and MainRecord.IsMaster and (Result._File.LoadOrder <= MainRecord._File.LoadOrder) then
        if Supports(Result, IwbMainRecord, MainRecord2) then
          (MainRecord as IwbMainRecordInternal).YouGotAMaster(MainRecord2);
      if Assigned(Result) and (csRefsBuild in Result._File.ContainerStates) then
        Result.BuildRef;
    end;
    6: begin
      if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
        if not (GroupRecord.GroupType in [8, 9, 10]) then
          raise Exception.Create('Can''t add '+GroupRecord.Name+' to ' + GetName);
        for i := 0 to Pred(GetElementCount) do
          if Supports(GetElement(i), IwbGroupRecord, GroupRecord2) then begin
            if GroupRecord2.GroupType = GroupRecord.GroupType then begin
              Result := GroupRecord2;
              break;
            end;
          end;
        if not Assigned(Result) then
          Result := TwbGroupRecord.Create(Self, GroupRecord.GroupType, Self.GetChildrenOf);

        GroupRecord2 := Result as IwbGroupRecord;
        if aDeepCopy then
          for i := 0 to Pred(GroupRecord.ElementCount) do
            GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

        Exit;
      end;
      raise Exception.Create('Can''t add ' + aElement.Name + ' to ' + GetName);
    end;
    7: begin
      if not Supports(aElement, IwbMainRecord, MainRecord) then
        raise Exception.Create('Only main records can be added to ' + GetName);
      if MainRecord.Signature <> 'INFO' then
        raise Exception.Create('Can''t add main record with signature '+MainRecord.Signature+' to ' + GetName);

      if aAsNew then
        FormID := GetFile.NewFormID
      else begin
        FormID := GetFile.LoadOrderFormIDtoFileFormID(MainRecord.LoadOrderFormID);
        for i := Low(cntElements) to High(cntElements) do
          if Supports(cntElements[i], IwbMainRecord, MainRecord2) then
            if MainRecord2.FixedFormID = FormID then begin
              Result := MainRecord2;
              exit;
            end;
      end;

      Result := TwbMainRecord.Create(Self, MainRecord.Signature, FormID);
      if aDeepCopy then begin
        Result.Assign(Low(Integer), aElement, False);
        if (aPrefix <> '') or (aSuffix <> '') then
          with Result as IwbMainRecord do begin
            s := EditorID;
            s := RemovePrefix(s, aPrefixRemove);
            if s <> '' then
              EditorID := aPrefix + s + aSuffix;
          end;
      end;
      if not aAsNew and MainRecord.IsMaster and (Result._File.LoadOrder <= MainRecord._File.LoadOrder) then
        if Supports(Result, IwbMainRecord, MainRecord2) then
          (MainRecord as IwbMainRecordInternal).YouGotAMaster(MainRecord2);
      if Assigned(Result) and (csRefsBuild in Result._File.ContainerStates) then
        Result.BuildRef;
    end;
    8, 9, 10: begin
      if wbVWDAsQuestChildren and Supports(aElement, IwbGroupRecord, GroupRecord) then begin
        if GroupRecord.GroupType <> 7 then
          raise Exception.Create('Can''t add '+GroupRecord.Name+' to top level group with signature ' + TwbSignature(grStruct.grsLabel));
        MainRecord := GroupRecord.ChildrenOf;
        if not Assigned(MainRecord) then
          raise Exception.Create('Can''t find record for '+ GroupRecord.Name);
        MainRecord := MainRecord.HighestOverrideOrSelf[GetFile.LoadOrder];
        MainRecord := AddIfMissingInternal(MainRecord, aAsNew, True, aPrefixRemove, aPrefix, aSuffix) as IwbMainRecord;
        Assert(Assigned(MainRecord));
        Result := MainRecord.ChildGroup;
        if not Assigned(Result) then
          Result := TwbGroupRecord.Create(Self, 7, MainRecord);

        GroupRecord2 := Result as IwbGroupRecord;
        if aDeepCopy then
          for i := 0 to Pred(GroupRecord.ElementCount) do
            GroupRecord2.AddIfMissing(GroupRecord.Elements[i], aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);

        Exit;
      end;
      if not Supports(aElement, IwbMainRecord, MainRecord) then
        raise Exception.Create('Only main records can be added to ' + GetName);
      if (MainRecord.Signature <> 'REFR') and
         (MainRecord.Signature <> 'ACHR') and
         (MainRecord.Signature <> 'ACRE') and
         (MainRecord.Signature <> 'PGRE') and
         (MainRecord.Signature <> 'PMIS') and
         (MainRecord.Signature <> 'PARW') and {>>> Skyrim <<<}
         (MainRecord.Signature <> 'PBEA') and {>>> Skyrim <<<}
         (MainRecord.Signature <> 'PFLA') and {>>> Skyrim <<<}
         (MainRecord.Signature <> 'PCON') and {>>> Skyrim <<<}
         (MainRecord.Signature <> 'PBAR') and {>>> Skyrim <<<}
         (MainRecord.Signature <> 'PHZD')     {>>> Skyrim <<<}
      then
        // check any non reference record
        if not (
          // DIAL, DLBR and SCEN can be added to child group 10 (quest children)
          (wbVWDAsQuestChildren and (grStruct.grsGroupType = 10) and ((MainRecord.Signature = 'DLBR') or (MainRecord.Signature = 'DIAL') or (MainRecord.Signature = 'SCEN')))
          or
          // PGRD, LAND and NAVM can be added to child group 9 (temporary)
          (grStruct.grsGroupType = 9) and ((MainRecord.Signature = 'PGRD') or (MainRecord.Signature = 'LAND') or (MainRecord.Signature = 'NAVM'))
        ) then
          raise Exception.Create('Can''t add main record with signature '+MainRecord.Signature+' to ' + GetName);

      if aAsNew then
        FormID := GetFile.NewFormID
      else begin
        FormID := GetFile.LoadOrderFormIDtoFileFormID(MainRecord.LoadOrderFormID);
        for i := Low(cntElements) to High(cntElements) do
          if Supports(cntElements[i], IwbMainRecord, MainRecord2) then
            if MainRecord2.FixedFormID = FormID then begin
              Result := MainRecord2;
              exit;
            end;
      end;

      Result := TwbMainRecord.Create(Self, MainRecord.Signature, FormID);
      if aDeepCopy then begin
        Result.Assign(Low(Integer), aElement, False);
        if (aPrefix <> '') or (aSuffix <> '') then
          with Result as IwbMainRecord do begin
            s := EditorID;
            s := RemovePrefix(s, aPrefixRemove);
            if s <> '' then
              EditorID := aPrefix + s + aSuffix;
          end;
      end;
      if not aAsNew and MainRecord.IsMaster and (Result._File.LoadOrder <= MainRecord._File.LoadOrder) then
        if Supports(Result, IwbMainRecord, MainRecord2) then
          (MainRecord as IwbMainRecordInternal).YouGotAMaster(MainRecord2);
      if Assigned(Result) and (csRefsBuild in Result._File.ContainerStates) then
        Result.BuildRef;
    end;
  else
    raise Exception.Create(ClassName + '.AddIfMissingInternal is not implemented for GroupType ' + IntToStr(grStruct.grsGroupType));
  end;
end;

procedure TwbGroupRecord.BuildRef;
var
  Rec: IwbMainRecord;
begin
  inherited;
  if GetGroupType in [1, 6, 7] then begin
    Rec := (GetFile as IwbFileInternal).RecordByFormID[TwbFormID.FromCardinal(GetGroupLabel), False];
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
  Create(aContainer, Pointer(BasePtr), nil, nil);
  SetModified(True);
  InvalidateStorage;
  BuildRef;
  (aContainer as IwbGroupRecordInternal).Sort;
end;

constructor TwbGroupRecord.Create(const aContainer: IwbContainer; aType: Integer; aLabel: Cardinal);
var
  BasePtr : PwbGroupRecordStruct;
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
  Create(aContainer, Pointer(BasePtr), nil, nil);
  SetModified(True);
  InvalidateStorage;
  (aContainer as IwbGroupRecordInternal).Sort;
end;

constructor TwbGroupRecord.Create(const aContainer: IwbContainer; const aSignature: TwbSignature);
var
  BasePtr : PwbGroupRecordStruct;
begin
  New(BasePtr);
  BasePtr.grsSignature := 'GRUP';
  BasePtr.grsGroupSize := wbSizeOfMainRecordStruct;
  BasePtr.grsLabel := Cardinal(aSignature);
  BasePtr.grsGroupType := 0;
  BasePtr.grsStamp := 0;
  BasePtr.grsUnknown := 0;
  Create(aContainer, Pointer(BasePtr), nil, nil);
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

function TwbGroupRecord.FindChildGroup(aType: Integer; aMainRecord: IwbMainRecord): IwbGroupRecord;
var
  SelfRef : IwbContainerElementRef;
  i       : Integer;
begin
  Result := nil;

  SelfRef := Self;
  DoInit;
  for i := Low(cntElements) to High(cntElements) do
    if Supports(cntElements[i], IwbGroupRecord, Result) then
      if Result.GroupType = aType then
        if Result.GroupLabel = aMainRecord.FormID.ToCardinal then
          Exit;
  Result := nil;
end;

procedure TwbGroupRecord.FindUsedMasters(aMasters: PwbUsedMasters);
var
  FileID: Integer;
begin
  inherited;

  if grStruct.grsGroupType in [1, 6..10] then begin
    if grStruct.grsLabel <> 0 then begin
      FileID := grStruct.grsLabel shr 24;
      aMasters[FileID] := True;
    end;
  end;
end;

function TwbGroupRecord.GetAddList: TDynStrings;
var
  i, j      : Integer;
  RecordDef : PwbRecordDef;
begin
  Result := nil;
  case grStruct.grsGroupType of
    0: begin
         SetLength(Result, 1);
         Result[0] := TwbSignature(grStruct.grsLabel);
       end;
    7: begin
         SetLength(Result, 1);
         Result[0] := 'INFO';
       end;
    8: begin
         SetLength(Result, 11);
         Result[0] := 'ACHR';
         Result[1] := 'ACRE';
         Result[2] := 'REFR';
         Result[3] := 'PGRE';
         Result[4] := 'PMIS';
         Result[5] := 'PARW'; {>>> Skyrim <<<}
         Result[6] := 'PBEA'; {>>> Skyrim <<<}
         Result[7] := 'PFLA'; {>>> Skyrim <<<}
         Result[8] := 'PCON'; {>>> Skyrim <<<}
         Result[9] := 'PBAR'; {>>> Skyrim <<<}
         Result[10] := 'PHZD'; {>>> Skyrim <<<}
       end;
    6, 9: begin
         SetLength(Result, 11);
         Result[0] := 'ACHR';
         Result[1] := 'ACRE';
         Result[2] := 'REFR';
         Result[3] := 'PGRE';
         Result[4] := 'PMIS';
         Result[5] := 'PARW'; {>>> Skyrim <<<}
         Result[6] := 'PBEA'; {>>> Skyrim <<<}
         Result[7] := 'PFLA'; {>>> Skyrim <<<}
         Result[8] := 'PCON'; {>>> Skyrim <<<}
         Result[9] := 'PBAR'; {>>> Skyrim <<<}
         Result[10] := 'PHZD'; {>>> Skyrim <<<}
       end;
    10: if wbVWDAsQuestChildren then begin
         SetLength(Result, 3);
         Result[0] := 'DIAL';
         Result[1] := 'DLBR';
         Result[2] := 'SCEN';
      end
      else begin
         SetLength(Result, 1);
         Result[0] := 'REFR';
       end;
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
begin
  Result := nil;
  if grStruct.grsGroupType in [1, 6..10] then
    Result := GetFile.RecordByFormID[TwbFormID.FromCardinal(grStruct.grsLabel), True];
end;

function TwbGroupRecord.GetElementType: TwbElementType;
begin
  Result := etGroupRecord;
end;

function TwbGroupRecord.GetGroupLabel: Cardinal;
begin
  Result := grStruct.grsLabel;
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
  DoInit;
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
  DoInit;
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
      Result := Result + ' Exterior Cell Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi);
      Exit;
    end;
    5: begin
      Result := Result + ' Exterior Cell Sub-Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi);
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

//  if wbDisplayLoadOrderFormID then
//    Result := Result + wbFormID.ToString(GetChildrenOf.FixedFormID, Self)
//  else
    Result := Result + wbFormID.ToString(grStruct.grsLabel, Self);
end;

function TwbGroupRecord.GetCountedRecordCount: Cardinal;
begin
  Result := Succ(inherited GetCountedRecordCount);
end;

function TwbGroupRecord.GetShortName: string;
var
  RecordDef : PwbRecordDef;
begin
  case grStruct.grsGroupType of
    0: begin
      Result := PwbSignature(@grStruct.grsLabel)^;
      if wbFindRecordDef(AnsiString(Result), RecordDef) then
        Result := RecordDef.GetName;
    end;
    1: Result := 'World Children';
    2: Result := 'Block ' + IntToStr(grStruct.grsLabel);
    3: Result := 'Sub-Block ' + IntToStr(grStruct.grsLabel);
    4: Result := 'Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo);
    5: Result := 'Sub-Block ' + IntToStr(LongRecSmall(grStruct.grsLabel).Hi) + ', ' + IntToStr(LongRecSmall(grStruct.grsLabel).Lo);
    6: Result := 'Children of ' + IntToHex(grStruct.grsLabel, 8);
    7: Result := 'Children of ' + IntToHex(grStruct.grsLabel, 8);
    8: Result := 'Persistent';
    9: Result := 'Temporary';
    10: if wbVWDAsQuestChildren then
      Result := 'Children of ' + IntToHex(grStruct.grsLabel, 8)
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
    Result := Result + IntToHex64(grStruct.grsLabel, 8);
  end;
end;

function TwbGroupRecord.grStruct: PwbGroupRecordStruct;
begin
  Result := PwbGroupRecordStruct(dcBasePtr);
end;

procedure TwbGroupRecord.InformPrevMainRecord(const aPrevMainRecord: IwbMainRecord);
begin
  inherited;
  if (grStruct.grsGroupType in [1, 6, 7]) and Assigned(aPrevMainRecord) and (aPrevMainRecord.FormID.ToCardinal = grStruct.grsLabel) then
    (aPrevMainRecord as IwbMainRecordInternal).SetChildGroup(Self);
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

function TwbGroupRecord.IsElementRemoveable(const aElement: IwbElement): Boolean;
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

  DoInit;

  SetModified(True);
  InvalidateParentStorage;

  if Assigned(dcEndPtr) then begin
    New(p);
    p^ := grStruct^;
    dcBasePtr := p;
    dcEndPtr := nil;
  end;
end;

procedure TwbGroupRecord.MasterCountUpdated(aOld, aNew: Byte);
var
  FileID: Integer;
begin
  if grStruct.grsGroupType in [1, 6..10] then begin
    if grStruct.grsLabel <> 0 then begin
      FileID := grStruct.grsLabel shr 24;
      if FileID >= aOld then begin
        FileID := aNew;
        MakeHeaderWriteable;
        grStruct.grsLabel := (grStruct.grsLabel and $00FFFFFF) or (Cardinal(FileID) shl 24);
      end;
    end;
  end;

  // do not sort records while we are updating
  Include(grStates, gsSorting);
  try
    inherited;
  finally
    Exclude(grStates, gsSorting);
  end;

end;

procedure TwbGroupRecord.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
var
  OldFormID: TwbFormID;
  NewFormID: TwbFormID;
begin
  // do not sort records while we are updating
  Include(grStates, gsSorting);
  try
    inherited;
  finally
    Exclude(grStates, gsSorting);
  end;

  // sort INFOs afterwards if group is a DIAL children
  if grStruct.grsGroupType = 7 then
    Sort;

  if grStruct.grsGroupType in [1, 6..10] then begin
    OldFormID := TwbFormID.FromCardinal(grStruct.grsLabel);
    if not OldFormID.IsNull then begin
      NewFormID := FixupFormID(OldFormID, aOld, aNew);
      if OldFormID <> NewFormID then begin
        MakeHeaderWriteable;
        grStruct.grsLabel := NewFormID.ToCardinal;
      end;
    end;
  end;
end;

procedure TwbGroupRecord.NotifyChangedInternal(aContainer: Pointer);
begin
  if gsSorting in grStates then
    Exit;
  inherited;
  // Let's try to sort only when the group membership change and not when one of its member change.
  if Assigned(aContainer) and (IwbContainerInternal(aContainer).ElementID = GetElementID) then
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
  if esReachable in eStates then
    Exit(False);

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if GetGroupType in [0, 2, 3] then begin
    Result := False;
    Exit;
  end;
  Result := inherited Reached;
  if Result and (GetGroupType in [1, 6..10]) then begin
    Rec := (GetFile as IwbFileInternal).RecordByFormID[TwbFormID.FromCardinal(GetGroupLabel), False];
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
var
  OldLabel    : Cardinal;
  i           : Integer;
  GroupRecord : IwbGroupRecord;

  SelfPtr     : IwbContainerElementRef;
  ContainedIn : IwbContainedIn;
begin
  SelfPtr := Self as IwbContainerElementRef;

  OldLabel := grStruct.grsLabel;
  if aLabel = OldLabel then
    Exit;

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

  MakeHeaderWriteable;
  grStruct.grsLabel := aLabel;

//  if grStruct.grsGroupType <> 6 then
//    Exit;

  for i := 0 to Pred(GetElementCount) do
    if Supports(GetElement(i), IwbGroupRecord, GroupRecord) then begin
      if GroupRecord.GroupType in [8..10] then
        if GroupRecord.GroupLabel = OldLabel then
          GroupRecord.GroupLabel := aLabel;
    end else if Supports(GetElement(i), IwbContainedIn, ContainedIn) then
      ContainedIn.ContainerChanged;
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

var
  ElementRefs      : array of IwbContainerElementRef;
  ElementRefsCount : Integer;

procedure TwbGroupRecord.Sort;

  procedure DoInserRecord(const InsertRecord: IwbMainRecordEntry);
  var
    TargetRecord: IwbMainRecordEntry;
  begin
    SetLength(ElementRefs, Succ(Length(ElementRefs)));
    if not Supports(InsertRecord, IwbContainerElementRef, ElementRefs[High(ElementRefs)]) then
      Assert(False);

    if Supports(InsertRecord.ElementLinksTo['PNAM'], IwbMainRecordEntry, TargetRecord) then begin

      SetLength(ElementRefs, Succ(Length(ElementRefs)));
      if not Supports(TargetRecord, IwbContainerElementRef, ElementRefs[High(ElementRefs)]) then
        Assert(False);

      if not TargetRecord.IsInList then
        DoInserRecord(TargetRecord);

      InsertRecord.InsertEntryAfter(TargetRecord);

    end else if InsertRecord.ElementExists['PNAM'] then
      InsertRecord.InsertEntryHead
    else
      InsertRecord.InsertEntryTail;
  end;

var
  ChildrenOf  : IwbMainRecord;
  MainRecords : TDynMainRecords;
  Groups      : TDynGroupRecords;
  Group       : IwbContainerElementRef;
  g           : IwbGroupRecord;
  i, j, k     : Integer;
  InsertRecord: IwbMainRecordEntry;
  TargetRecord: IwbMainRecordEntry;
  PrevRecord  : IwbMainRecordEntry;
  InfoQuest   : Int64;
  InfoQuest2  : Int64;
  Inserted    : Boolean;
  NewElements : TDynElementInternals;

begin
  if grStates * [gsSorted, gsSorting] <> [] then
    Exit;

  if eUpdateCount > 0 then begin
    Include(grStates, gsSortPostponed);
    Exit;
  end;

  Include(grStates, gsSorting);
  try
    ChildrenOf := GetChildrenOf;
    // there is no PNAM in Fallout 4, looks like INFOs are no longer linked lists
    if (not wbIsFallout4) and Assigned(ChildrenOf) and (ChildrenOf.Signature = 'DIAL') then begin
      {>>> Sorting DIAL group doesn't always work, and Skyrim.esm has a plenty of unsorted DIALs <<<}
      {>>> Also disabled for FNV, https://code.google.com/p/skyrim-plugin-decoding-project/issues/detail?id=59 <<<}
      if not wbSortGroupRecord then
        Exit;

      if not wbDisplayLoadOrderFormID then
        Exit;

      Inc(ElementRefsCount);
      try
        MainRecords := ChildrenOf.MasterRecordsFromMasterFilesAndSelf;
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

        mreHeader.BeginUse;
        try
          for i := Low(Groups) to High(Groups) do
            if Supports(Groups[i], IwbContainerElementRef, Group) then
              for j := 0 to Pred(Group.ElementCount) do
                if Supports(Group.Elements[j], IwbMainRecordEntry, InsertRecord) then
                   DoInserRecord(InsertRecord);
          TargetRecord := IwbMainRecordEntry(mreHeader.mrehTail);
          while Assigned(TargetRecord) do begin
            PrevRecord := TargetRecord.PrevEntry;
            if not Equals(TargetRecord.Container) then
              TargetRecord.RemoveEntry
            else if not TargetRecord.IsDeleted then if wbBeginInternalEdit then try
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

          Assert(mreHeader.mrehCount = Length(cntElements));

          SetLength(NewElements, Length(cntElements));
          k := High(NewElements);
          TargetRecord := IwbMainRecordEntry(mreHeader.mrehTail);
          while Assigned(TargetRecord) do begin
            Assert(k >= Low(NewElements));
            if not Supports(TargetRecord, IwbElementInternal, NewElements[k]) then
              Assert(False);
            TargetRecord := TargetRecord.PrevEntry;
            Dec(k);
          end;
          Assert(k = -1);

          cntElements := NewElements;
          Include(grStates, gsSorted);
        finally
          mreHeader.EndUse;
        end;
      finally
        Dec(ElementRefsCount);
        if ElementRefsCount = 0 then
          ElementRefs := nil;
      end;
      Exit;
    end;

    if Length(cntElements) > 1 then
      wbMergeSort(@cntElements[0], Length(cntElements), CompareGroupContents);
    Include(grStates, gsSorted);
  finally
    Exclude(grStates, gsSorting);
  end;
end;

procedure TwbGroupRecord.UpdatedEnded;
begin
  if gsSortPostponed in grStates then begin
    Exclude(grStates, gsSortPostponed);
    Sort;
  end;
  inherited;
end;

procedure TwbGroupRecord.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
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
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
  end;
end;

{ TwbElement }

function TwbElement.AddIfMissing(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
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
    Result := AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix);
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

function TwbElement.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
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
    Result := AssignInternal(aIndex, aElement, aOnlySK);
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
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  Result := GetDef.Assign(Self, aIndex, aElement, aOnlySK);
end;

procedure TwbElement.BeforeDestruction;
begin
  Assert(eExternalRefs = 0);
  if (FRefCount and $7FFFFFFF) <> 0 then
    Assert(FRefCount = 0);
  Include(eStates, esDestroying);
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

function TwbElement.BeginDecide: Boolean;
begin
  Result := not (esDeciding in eStates);
  if Result then
    Include(eStates, esDeciding);
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
  TargetValueDef: IwbValueDef;
  SourceValueDef: IwbValueDef;
begin
  Result := wbIsInternalEdit;
  if Result then
    Exit;

  if not wbEditAllowed then
    Exit;

  if not GetIsEditable then
    Exit;

  if not Assigned(aElement) then
    Exit;

  TargetValueDef := GetValueDef;
  if TargetValueDef = nil then
    Exit;

  SourceValueDef := aElement.ValueDef;
  if SourceValueDef = nil then
    Exit;

  Result := TargetValueDef.CanAssign(Self, aIndex, SourceValueDef);

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

function TwbElement.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
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

procedure AddRequiredMasters(aMasters: TStrings; const aTargetFile: IwbFile);
var
  sl                          : TStringList;
  i, j                        : Integer;
begin
  sl := TStringList.Create;
  try
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;
    sl.AddStrings(aMasters);

    for i := 0 to Pred(aTargetFile.MasterCount) do
      if sl.Find(aTargetFile.Masters[i].FileName, j) then
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

function TwbElement.CopyInto(const aFile: IwbFile; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  sl          : TStringList;
  MainRecord  : IwbMainRecord;
  GroupRecord : IwbGroupRecord;
begin
  sl := TStringList.Create;
  try
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;
    ReportRequiredMasters(sl, aAsNew);
    AddRequiredMasters(sl, aFile);

    if aDeepCopy and Supports(Self, IwbMainRecord, MainRecord) and Assigned(MainRecord.ChildGroup) then begin
      Result := wbCopyElementToFile(MainRecord.ChildGroup, aFile, aAsNew, True, aPrefixRemove, aPrefix, aSuffix);
      if Supports(Result, IwbGroupRecord, GroupRecord) then
        Result := GroupRecord.ChildrenOf
      else
        Result := nil;
    end else
      Result := wbCopyElementToFile(Self, aFile, aAsNew, True, aPrefixRemove, aPrefix, aSuffix);
  finally
    sl.Free;
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
  NamedDef: IwbNamedDef;
begin
  NamedDef := GetValueDef;
  if Assigned(NamedDef) then
    NamedDef.AfterSet(Self, aOldValue, aNewValue);
  if Supports(GetDef, IwbNamedDef, NamedDef) then
    NamedDef.AfterSet(Self, aOldValue, aNewValue);
end;

procedure TwbElement.DoReset(aForce: Boolean);
begin
  {nothing}
end;

procedure TwbElement.EndDecide;
begin
  Exclude(eStates, esDeciding);
end;

function TwbElement.EndUpdate: Integer;

begin
  Result := Pred(eUpdateCount);
  eUpdateCount := Result;
  if Result = 0 then
    UpdatedEnded;
end;

function TwbElement.Equals(const aElement: IwbElement): Boolean;
begin
  Result := Assigned(aElement) and (aElement.ElementID = GetElementID);
end;

procedure TwbElement.FindUsedMasters(aMasters: PwbUsedMasters);
begin
  {can be overriden}
end;

procedure TwbElement.FreeInstance;
begin
  if (FRefCount and $7FFFFFFF) <> 1 then
    Assert(FRefCount = 1);
  Assert(eExternalRefs = 1);
  inherited;
end;

function TwbElement.GetBaseName: string;
begin
  Result := GetName;
end;

function TwbElement.GetCheck: string;
begin
  Result := '';
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

  if wbTranslationMode then begin
    if Result <> cpTranslate then
      Result := cpIgnore
    else
      Result := cpNormal;
  end else begin
    if Result = cpTranslate then
      Result := cpNormal;
  end;

  if Result = cpFormID then begin
    Result := cpCritical;
    MainRecord := GetContainingMainRecord;
    if Assigned(MainRecord) and (MainRecord.Signature = 'GMST') then
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

function TwbElement.GetDisplayName: string;
begin
  Result := GetName;
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

function TwbElement.GetEditInfo: string;
begin
  Result := '';
end;

function TwbElement.GetEditType: TwbEditType;
begin
  Result := etDefault;
end;

function TwbElement.GetEditValue: string;
begin
  Result := '';
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

function TwbElement.GetFullPath: string;
begin
  if Assigned(eContainer) then
    Result := IwbElement(eContainer).FullPath
  else
    Result := '';
  Result := Result + ' \ ';
  if Assigned(eContainer) then
    Result := Result + '['+IntToStr(IwbContainer(eContainer).IndexOf(Self))+'] ';
  Result := Result + GetName;
end;

function TwbElement.GetPathName: string;
begin
  if Assigned(eContainer) then
    Result := IwbElement(eContainer).PathName
  else
    Result := '';
  Result := Result + '\';
  if Assigned(eContainer) then
    Result := Result + '['+IntToStr(IwbContainer(eContainer).IndexOf(Self))+'] ';
  Result := Result + GetShortName;
end;

function TwbElement.GetInjectionSourceFiles: TDynFiles;
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

function TwbElement.GetIsRemoveable: Boolean;
begin
  Result := not Assigned(eContainer) or IwbContainer(eContainer).IsElementRemoveable(Self);
end;

function TwbElement.GetLinksTo: IwbElement;
begin
  Result := nil;
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
      for i := 0 to Pred(_File.MasterCount) do
        if _File.Masters[i].Equals(ElementFile) then begin
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

procedure TwbElement.MarkModifiedRecursive;
begin
  if not Assigned(eContainer) or IwbContainer(eContainer).IsElementEditable(Self) then begin
    SetModified(True);
    InvalidateParentStorage;
  end;
end;

procedure TwbElement.MasterCountUpdated(aOld, aNew: Byte);
begin
  {can be overriden}
end;

procedure TwbElement.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
begin
  Assert( Length(aOld) = Length(aNew) );
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
    if StartsWith(Self.GetValue, '<Error') then
      asm nop end;
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

procedure TwbElement.NextMember;
begin
  if not CanChangeMember then
    Exit;
  IwbContainerInternal(eContainer).NextElementMember(Self);
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

procedure TwbElement.PreviousMember;
begin
  if not CanChangeMember then
    Exit;
  IwbContainerInternal(eContainer).PreviousElementMember(Self);
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
begin
  if Assigned(eContainer) then begin
    SetModified(True);
    InvalidateParentStorage;
    IwbContainer(eContainer).RemoveElement(Self as IwbElement);
  end;
end;

function TwbElement.RemoveInjected(aCanRemove: Boolean): Boolean;
begin
  Result := GetReferencesInjected;
  if Result and GetIsRemoveable then begin
    Result := False;
    Remove;
  end;
end;

procedure TwbElement.ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean; Recursive: Boolean = True; Initial: Boolean = false);
var
  Element       : IwbElement;
  ReferenceFile : IwbFile;
begin
  Element := GetLinksTo;
  if Assigned(Element) then begin
    ReferenceFile := Element.ReferenceFile;
    if Assigned(ReferenceFile) then begin
      aStrings.AddObject(ReferenceFile.FileName, Pointer(ReferenceFile));
    end;
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

procedure TwbElement.SetInternalModified(aValue: Boolean);
begin
  wbBeginInternalEdit(True);
  try
    SetModified(aValue);
  finally
    wbEndInternalEdit;
  end;
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

//    if wbIsInternalEdit and (Self is TwbMainRecord) then
//      Exit;

    Inc(eGeneration);

    if eUpdateCount > 0 then
      Include(eStates, esModifiedUpdated)
    else
      if Assigned(eContainer) then
        (IwbContainer(eContainer) as IwbElementInternal).Modified := True;
  end;
end;

procedure TwbElement.SetNativeValue(const aValue: Variant);
begin
  raise Exception.Create(GetName + ' can not be edited.');
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

procedure TwbElement.SetToDefaultInternal;
begin
  { can be overriden }
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

procedure TwbElement.UpdatedEnded;
begin
  if esChangeNotified in eStates then begin
    Exclude(eStates, esChangeNotified);
    NotifyChanged(eContainer);
  end;
  if esModifiedUpdated in eStates then begin
    Exclude(eStates, esModifiedUpdated);
    if Assigned(eContainer) and (esModified in eStates) then
      (IwbContainer(eContainer) as IwbElementInternal).Modified := True;
  end;
end;

procedure TwbElement.WriteToStream(aStream: TStream; aResetModified: Boolean);
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
    CodeSite.Send('aResetModified', aResetModified);
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

procedure TwbElement.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
begin
  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
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

function TwbSubRecordArray.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  Assert(Assigned(aElement.Def));
  Assert(arcDef.Element.Equals(aElement.Def));

  if arcSorted and not aAsNew then begin
    Assert(not arcSortInvalid);
    if FindBySortKey(aElement.SortKey[False], False,i) then begin
      Result := cntElements[i];
      if aDeepCopy then
        Result.Assign(Low(Integer), aElement, False);
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
        Result := TwbSubRecordArray.Create(Self, nil, Low(Integer), arcDef.Element as IwbSubRecordArrayDef);
      dtSubRecordStruct:
        Result := TwbSubRecordStruct.Create(Self, nil, Low(Integer), arcDef.Element as IwbSubRecordStructDef);
    else
      Assert(False);
    end;

  try
    Result.Assign(Low(Integer), aElement, not aDeepCopy);
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

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if (aIndex = Low(Integer)) and arcDef.CanAssign(Self, aIndex, aElement.Def) then begin

    if aOnlySK then
      Exit;

    Container := aElement as IwbContainer;

    SetModified(True);
    InvalidateStorage;
    ReleaseElements;

    for i := 0 to Pred(Container.ElementCount) do
      Assign(i, Container.Elements[i], aOnlySK);

  end else if (aIndex >= 0) and (not Assigned(aElement) or arcDef.Element.CanAssign(Self, Low(Integer), aElement.Def))  or
    ((aIndex = Low(Integer)) and arcDef.Element.CanAssign(Self, aIndex, aElement.Def)) then begin

    Element := nil;

    if (csAsCreatedEmpty in cntStates) and Assigned(aElement) then begin
      SetModified(True);
      Assert(Length(cntElements)=1);
      Element := cntElements[0];
      Exclude(cntStates, csAsCreatedEmpty);
    end else begin

      ElementDef := arcDef.Element;
      if ElementDef.DefType = dtSubRecordUnion then begin
        if Assigned(aElement) then begin
          Supports(aElement, IwbDataContainer, DataContainer);
          ElementDef := (ElementDef as IwbRecordDef).GetMemberFor((aElement as IwbHasSignature).Signature, DataContainer)
        end else
          ElementDef := (ElementDef as IwbRecordDef).Members[0];
        Assert(Assigned(ElementDef));
      end;

      case ElementDef.DefType of
        dtSubRecord:
          Element := TwbSubRecord.Create(Self, ElementDef as IwbSubRecordDef);
        dtSubRecordArray:
          Element := TwbSubRecordArray.Create(Self, nil, Low(Integer), ElementDef as IwbSubRecordArrayDef);
        dtSubRecordStruct:
          Element := TwbSubRecordStruct.Create(Self, nil, Low(Integer), ElementDef as IwbSubRecordStructDef);
      else
        Assert(False);
      end;
    end;

    if Assigned(Element) and Assigned(aElement) then try
      Element.Assign(Low(Integer), aElement, aOnlySK);
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
      wbMergeSort(@cntElements[0], Length(cntElements), CompareSortKeys);
    arcSorted := True;
  end;
end;

function TwbSubRecordArray.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
begin
  Result := False;
  if not wbEditAllowed then
    Exit;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  if not Assigned(aElement) then begin
    Result := aIndex >= 0;
    Exit;
  end;

  Result := arcDef.CanAssign(Self, aIndex, aElement.Def);
  if not Result then begin
    Result := arcDef.Element.CanAssign(Self, Low(Integer), aElement.Def);
    if Result then
      if aCheckDontShow and arcDef.Element.DontShow[aElement] then
        Result := False;
  end;
end;

function TwbSubRecordArray.CanContainFormIDs: Boolean;
begin
  Result := arcDef.CanContainFormIDs;
end;

function TwbSubRecordArray.CanMoveElement: Boolean;
begin
  Result := not arcSorted;
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
begin
  arcDef := aDef;
  eContainer := Pointer(aOwner);
  try
    if aPos <> Low(Integer) then begin
      DoProcess(aContainer, aPos)
    end else begin
      Assign(High(Integer), nil, False);
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

procedure TwbSubRecordArray.DoInit;
begin
  inherited;
  if arcSorted and arcSortInvalid then begin
    if Length(cntElements) > 1 then
      wbMergeSort(@cntElements[0], Length(cntElements), CompareSortKeys);
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
    ElementDef := arcDef.Element;
    if ElementDef.DefType = dtSubRecordUnion then begin
      ElementDef := (ElementDef as IwbRecordDef).GetMemberFor(SubRecord.Signature, SubRecord);
      if not Assigned(ElementDef) then
        Break;
    end;

    if not ElementDef.CanHandle(SubRecord.Signature, SubRecord) then
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
  Result := arcSorted;
end;

function TwbSubRecordArray.IsElementRemoveable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement) and (Length(cntElements) > 1);
end;

procedure TwbSubRecordArray.SetModified(aValue: Boolean);
begin
  inherited;
  if aValue and arcSorted then
    arcSortInvalid := True;
end;

{ TwbSubRecordStruct }

function TwbSubRecordStruct.Add(const aName: string; aSilent: Boolean): IwbElement;
var
  Signature : TwbSignature;
  Index     : Integer;
begin
  Result := nil;

  if not IsElementEditable(nil) then
    raise Exception.Create('"' + GetName + '" is not editable');

  Result := nil;

  if Length(aName) < 4 then
    Exit;

  Signature := StrToSignature(aName);

  Result := GetElementBySignature(Signature);
  if Assigned(Result) then
    Exit;

  Index := srcDef.GetMemberIndexFor(Signature, nil);
  if Index >= 0 then
    Assign(Index, nil, False);

  Result := GetElementBySignature(Signature);
  Assert(Assigned(Result));
end;

function TwbSubRecordStruct.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

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
      wbMergeSort(@cntElements[0], Length(cntElements), CompareSubRecords);
  end else
    Result.Assign(Low(Integer), aElement, not aDeepCopy);
end;

procedure TwbSubRecordStruct.AddRequiredElements;
var
  CurrentDefPos : Integer;
  CurrentDef    : IwbRecordMemberDef;
  Element       : IwbElementInternal;
begin
  for CurrentDefPos := 0 to Pred(srcDef.MemberCount) do begin
    CurrentDef := srcDef.Members[CurrentDefPos];
    if ((CurrentDefPos = 0) and not srcDef.AllowUnordered) or CurrentDef.Required then begin

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

    end;
  end;
end;

function TwbSubRecordStruct.AssignInternal(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
var
  Member    : IwbRecordMemberDef;
  Container : IwbContainer;
  Element   : IwbElement;
  i         : Integer;
begin
  Result := nil;

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  if aIndex = Low(Integer) then begin

    Container := aElement as IwbContainer;

    SetModified(True);
    InvalidateStorage;
    ReleaseElements;
    AddRequiredElements;

    if Assigned(Container) then
      for i := 0 to Pred(Container.ElementCount) do begin
        Element := Container.Elements[i];
        if not aOnlySK or GetIsInSK(Element.SortOrder) then
          Assign(Element.SortOrder, Element, aOnlySK);
      end;

  end else begin

    if (aIndex >= 0) and (aIndex < srcDef.MemberCount) then begin
      Member := srcDef.Members[aIndex];
      if not Assigned(aElement) or Member.CanAssign(Self, Low(Integer), aElement.Def) then begin
        Element := GetElementBySortOrder(aIndex + GetAdditionalElementCount);
        if Assigned(Element) then begin
          if Assigned(aElement) then
            Element.Assign(Low(Integer), aElement, aOnlySK)
        end else begin

          case Member.DefType of
            dtSubRecord:
              Element := TwbSubRecord.Create(Self, Member as IwbSubRecordDef);
            dtSubRecordArray:
              Element := TwbSubRecordArray.Create(Self, nil, Low(Integer), Member as IwbSubRecordArrayDef);
            dtSubRecordStruct:
              Element := TwbSubRecordStruct.Create(Self, nil, Low(Integer), Member as IwbSubRecordStructDef);
          else
            Assert(False);
          end;

          if Assigned(Element) then try
            Element.SortOrder := aIndex;
            if Assigned(aElement) then
              Element.Assign(Low(Integer), aElement, aOnlySK);
          except
            Element.Container.RemoveElement(Element);
            raise;
          end;

        end;
        Result := Element;
      end;
    end;
  end;

  if wbSortSubRecords and (Length(cntElements) > 1) then
    wbMergeSort(@cntElements[0], Length(cntElements), CompareSubRecords);
end;

function TwbSubRecordStruct.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
begin
  Result := False;
  if not wbEditAllowed then
    Exit;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  if not Assigned(aElement) then begin
    Result := (aIndex >= 0) and (aIndex < srcDef.MemberCount) and (GetElementBySortOrder(aIndex + GetAdditionalElementCount) = nil);
    if Result and aCheckDontShow then
      if srcDef.Members[aIndex].DontShow[Self] then
        Result := False;
    Exit;
  end;

  if Assigned(srcDef) then begin
    if aIndex = Low(Integer) then
      Result := srcDef.Equals(aElement.Def)
    else begin
      Result := (aIndex >= 0) and (aIndex < srcDef.MemberCount) and
        srcDef.Members[aIndex].CanAssign(Self, Low(Integer), aElement.Def);
      if Result and aCheckDontShow then
        if srcDef.Members[aIndex].DontShow[Self] then
          Result := False;
    end;
  end else
    Result := False;
end;

function TwbSubRecordStruct.CanContainFormIDs: Boolean;
begin
 Result := srcDef.CanContainFormIDs;
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
  Element       : IwbElementInternal;
begin
  srcDef := aDef as IwbRecordDef;

  if aPos = Low(Integer) then begin
    AddRequiredElements;
  end else begin
    CurrentDefPos := 0;
    while (aPos < aContainer.ElementCount) and (CurrentDefPos < srcDef.MemberCount) do begin

      if aContainer[aPos].ElementType <> etSubRecord then
        Break;

      CurrentRec := aContainer[aPos] as IwbSubRecordInternal;

      if not srcDef.ContainsMemberFor(CurrentRec.Signature, CurrentRec) then begin
        if srcDef.SkipSignature[CurrentRec.Signature] then begin
          Inc(aPos);
          Continue;
        end;
        Break;
      end;

      if srcDef.AllowUnordered then begin

        CurrentDefPos := srcDef.GetMemberIndexFor(CurrentRec.Signature, CurrentRec);
        if CurrentDefPos < 0 then begin
          if wbHasProgressCallback then
            wbProgressCallback('Error: record '+ String(GetSignature) + ' contains unexpected (or out of order) subrecord ' + String(CurrentRec.Signature) + ' ' + IntToHex(Int64(Cardinal(CurrentRec.Signature)), 8) );
          //FoundError := True;
          Inc(aPos);
          Continue;
        end;
        CurrentDef := srcDef.Members[CurrentDefPos];

      end;

      CurrentDef := srcDef.Members[CurrentDefPos];
      if not CurrentDef.CanHandle(CurrentRec.Signature, CurrentRec) then begin
        Inc(CurrentDefPos);
        Continue;
      end;

      if CurrentDef.DefType = dtSubRecordUnion then begin
        CurrentDef := (CurrentDef as IwbRecordDef).GetMemberFor(CurrentRec.Signature, CurrentRec);
        Assert(Assigned(CurrentDef));
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

      Inc(CurrentDefPos);
    end;
  end;

  srcDef.AfterLoad(Self);

  inherited Create(aOwner);
  if aPos = Low(Integer) then begin
    SetModified(True);
    InvalidateStorage;
  end;
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
  DoInit;

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
    DoInit;
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

function TwbSubRecordStruct.IsElementRemoveable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement) and (Length(cntElements) > 1) and (srcDef.AllowUnordered or not cntElements[0].Equals(aElement));
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
    DoInit;

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

function ArrayDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; out SizePrefix: Integer): Boolean;
var
  Element  : IwbElement;
  ArrayDef : IwbArrayDef;
  ValueDef : IwbValueDef;
  i        : Integer;
  t        : string;
  VarSize  : Boolean;
  ArrSize  : Integer;
begin
  ArrayDef := aValueDef as IwbArrayDef;
  Result := wbSortSubRecords and ArrayDef.Sorted;
  if not ArrayDef.CanAddTo then
    aContainer.SetElementState(esNotSuitableToAddTo);

  SizePrefix := ArrayDef.PrefixSize[aBasePtr];

  i := 0;

  ValueDef := ArrayDef.Element;
  VarSize := ArrayDef.IsVariableSize;
  ArrSize := ArrayDef.ElementCount;
  if ArrSize < 0 then begin
    ArrSize := ArrayDef.PrefixCount[aBasePtr];
  end else
    if (ArrSize < 1) and Assigned(ArrayDef.CountCallback) then
      ArrSize := ArrayDef.CountCallback(aBasePtr, aEndPtr, aContainer)
    else if VarSize then
      ArrSize := High(Integer);

  if Assigned(aBasePtr) then
    Inc(PByte(aBasePtr), SizePrefix);

  if ArrSize > 0 then
    while not VarSize or ((NativeUInt(aBasePtr) < NativeUInt(aEndPtr)) or (not Assigned(aBasePtr))) do begin
      if Result then
        t := ''
      else begin
        t := ArrayDef.ElementLabel[i];
        if t <> '' then
          t := ' (' + t + ')';
        t := '#' + IntToStr(i) + t;
      end;

      case ValueDef.DefType of
        dtArray: Element := TwbArray.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtStruct: Element := TwbStruct.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtStructChapter: Element := TwbChapter.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
        dtUnion: Element := TwbUnion.Create(aContainer, aBasePtr, aEndPtr, ValueDef, t);
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

      Inc(i);
      if VarSize and not Assigned(aBasePtr) then begin
        (aContainer as IwbContainerInternal).CreatedEmpty;
        Break;
      end;

      Dec(ArrSize);
      if ArrSize = 0 then
        Break
      { else if not (not VarSize or ((NativeUInt(aBasePtr) < NativeUInt(aEndPtr)) or (not Assigned(aBasePtr)))) then
        wbProgressCallback('Error: not enough data for array. Elements remaining are '+IntToStr(ArrSize)) Silently fails = called at an invalid time };
    end;

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

function TwbArray.AddIfMissingInternal(const aElement: IwbElement; aAsNew, aDeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
var
  SelfRef   : IwbContainerElementRef;
  i         : Integer;
  s         : string;
  ArrayDef  : IwbArrayDef;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be modified.');

  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  ArrayDef := vbValueDef as IwbArrayDef;

  if arrSorted then begin
    Assert(not arrSortInvalid);
    if FindBySortKey(aElement.SortKey[False], False, i) then begin
      Result := cntElements[i];
      if aDeepCopy then
        Result.Assign(Low(Integer), aElement, False);
      Exit;
    end;
  end;

  if arrSorted then
    s := ''
  else
    s := '#' + IntToStr(Length(cntElements));

  if not Supports(aElement, IwbStringListTerminator) then
    case ArrayDef.Element.DefType of
      dtArray: Result := TwbArray.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
      dtStruct: Result := TwbStruct.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
      dtStructChapter: Result := TwbChapter.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
      dtUnion: Result := TwbUnion.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
    else
      Result := TwbValue.Create(Self, ArrayDef.Element, aElement, not aDeepCopy, s);
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
  Container     : IwbContainer;
  DataContainer : IwbDataContainer;
  s             : string;
  i             : Integer;
  SelfRef       : IwbContainerElementRef;
  p, q          : Pointer;
begin
  Result := nil;

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  ArrayDef := vbValueDef as IwbArrayDef;

  if (aIndex = Low(Integer)) and ArrayDef.CanAssign(Self, aIndex, aElement.ValueDef) then begin

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
        dElement.Assign(Low(Integer), sElement, aOnlySK);
      end;
    end;

  end else begin
    if (aIndex >= 0) and (ArrayDef.ElementCount <= 0) and ((aIndex = High(Integer)) or ArrayDef.Element.CanAssign(Self, Low(Integer), aElement.ValueDef)) then begin
      {add one entry}

      if arrSorted then
        s := ''
      else
        s := '#' + IntToStr(Length(cntElements));

      Element := nil;

      if not Supports(aElement, IwbStringListTerminator) then
        case ArrayDef.Element.DefType of
          dtArray: Element := TwbArray.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
          dtStruct: Element := TwbStruct.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
          dtStructChapter: Element := TwbChapter.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
          dtUnion: Element := TwbUnion.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
        else
          Element := TwbValue.Create(Self, ArrayDef.Element, aElement, aOnlySK, s);
        end;

      Result := Element;

    end;
  end;

  CheckCount;
  CheckTerminator;
end;

function TwbArray.CanAssignInternal(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
var
  ArrayDef: IwbArrayDef;
begin
  Result := False;
  if not wbEditAllowed then
    Exit;

  if Assigned(eContainer) then
    if not IwbContainer(eContainer).IsElementEditable(Self) then
      Exit;

  if aCheckDontShow and GetDontShow then
    Exit;

  ArrayDef := vbValueDef as IwbArrayDef;
  if not Assigned(aElement) then begin
    if aIndex = High(Integer) then
      Result := ArrayDef.ElementCount <= 0;
    Exit;
  end;
  Result :=
     ArrayDef.CanAssign(Self, aIndex, aElement.ValueDef) or
     ( (ArrayDef.ElementCount <= 0) and ArrayDef.Element.CanAssign(Self, Low(Integer), aElement.ValueDef) );
end;

function TwbArray.CanMoveElement: Boolean;
begin
  Result := not arrSorted;
end;

procedure TwbArray.CheckCount;
var
  Count       : Cardinal;
  i           : Integer;
  UpdateCount : Integer;
  ArrayDef    : IwbArrayDef;
begin
  if arrSizePrefix = 0 then
    Exit;

  ArrayDef := vbValueDef as IwbArrayDef;
  Count := arrayDef.PrefixCount[dcDataBasePtr];

  DoInit;

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

procedure TwbArray.DoInit;
var
  i       : Integer;
  Sorting : Boolean;
begin
  inherited;
  if arrSorted and arrSortInvalid then
    if (Length(cntElements) > 1) then begin
      Sorting := False;
      for i := 0 to Length(cntElements)-1 do
        if (esSorting in (cntElements[i] as IwbElementInternal).ElementStates) then begin
          Sorting := TRue;
          Break;
        end;
        if not Sorting then begin
          wbMergeSort(@cntElements[0], Length(cntElements), CompareSortKeys);
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

function TwbArray.GetDataPrefixSize: Integer;
begin
  Result := arrSizePrefix;
end;

function TwbArray.GetElementType: TwbElementType;
begin
  Result := etArray;
end;

function TwbArray.GetSorted: Boolean;
begin
  Result := arrSorted;
end;

function TwbArray.IsElementRemoveable(const aElement: IwbElement): Boolean;
begin
  Result := IsElementEditable(aElement) and ((vbValueDef as IwbArrayDef).ElementCount <= 0) { and (Length(cntElements)>1)};
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

procedure TwbArray.SetModified(aValue: Boolean);
begin
  inherited;
  if aValue and arrSorted then
    arrSortInvalid := True;
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
  Size                : Integer;
  over                : Boolean;
begin
  StructDef := aValueDef as IwbStructDef;

  OptionalFromElement := StructDef.OptionalFromElement;
  if OptionalFromElement < 0 then
    OptionalFromElement := High(Integer);

  for i := 0 to Pred(StructDef.MemberCount) do begin
    ValueDef := StructDef.Members[i];
    if Assigned(aBasePtr) and (i >= OptionalFromElement) then begin
      over := (NativeUInt(aBasePtr) >= NativeUInt(aEndPtr));
      if not over then begin
        Size := ValueDef.Size[aBasePtr, aEndPtr, aContainer];
        over := (Size<High(Integer)) and  //Intercept multiple calls to Size[ during initialisation
                ((NativeUInt(aBasePtr) + Size) > NativeUInt(aEndPtr));
      end;
      if over then begin
        aEndPtr := aBasePtr;
        ValueDef := Resolve(ValueDef, aBasePtr, aEndPtr, aContainer);
        if Supports(ValueDef, IwbIntegerDef, IntegerDef) and Supports(IntegerDef.Formater[aContainer], IwbFlagsDef) then
          ValueDef := wbEmpty(ValueDef.Name, cpIgnore, False, nil, True)
        else
          ValueDef := wbEmpty(ValueDef.Name, cpIgnore);
      end;
    end;

    case ValueDef.DefType of
      dtArray: Element := TwbArray.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtStruct: Element := TwbStruct.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtStructChapter: Element := TwbChapter.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtUnion: Element := TwbUnion.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
    else
      Element := TwbValue.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
    end;

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

function UnionDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer): TwbUnionFlags;
var
  UnionDef : IwbUnionDef;
  ValueDef : IwbValueDef;
  ArrayDef : IwbArrayDef;
  Element  : IwbElementInternal;

begin
  Result := ufNone;
  UnionDef := aValueDef as IwbUnionDef;

  ValueDef := UnionDef.Decide(aBasePtr, aEndPtr, aContainer);

  if Assigned(ValueDef) then // I had one case. Most likely due to an error in wbXXXXDefinitions
    case ValueDef.DefType of
      dtArray: begin
        if wbSortSubRecords and Supports(ValueDef, IwbArrayDef, ArrayDef) and ArrayDef.Sorted then
          Result := ufSortedArray
        else
          Result := ufArray;
        Element := TwbArray.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      end;
      dtStruct: Element := TwbStruct.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtStructChapter: Element := TwbChapter.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      dtUnion: Element := TwbUnion.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
    else
      Element := nil; // >>> so that simple union behave as they did <<< TwbValue.Create(aContainer, aBasePtr, aEndPtr, ValueDef, '');
      if ValueDoInit(aValueDef, aContainer, aBasePtr, aEndPtr, aContainer) then Result := ufFlags;
    end;

  if Assigned(Element) then begin
    Element.SetSortOrder(0);
    Element.SetMemoryOrder(0);
  end;

  UnionDef.AfterLoad(aContainer);
end;

function TwbUnion.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    Result := ResolvedDef.CompareExchangeFormID(GetDataBasePtr, dcDataEndPtr, Self, aOldFormID, aNewFormID) or Result;
end;

function TwbUnion.GetElementType: TwbElementType;
begin
  Result := etUnion;
end;

procedure TwbUnion.Init;
var
  BasePtr: Pointer;
begin
  inherited;

  if GetSkipped then
    Exit;

  BasePtr := GetDataBasePtr;
  UnionDoInit(vbValueDef, Self, BasePtr, dcDataEndPtr);
end;

procedure TwbUnion.MasterCountUpdated(aOld, aNew: Byte);
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  inherited MasterCountUpdated(aOld, aNew);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.MasterCountUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew);
end;

procedure TwbUnion.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  inherited MasterIndicesUpdated(aOld, aNew);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.MasterIndicesUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew);
end;

procedure TwbUnion.FindUsedMasters(aMasters: PwbUsedMasters);
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  inherited FindUsedMasters(aMasters);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.FindUsedMasters(GetDataBasePtr, dcDataEndPtr, Self, aMasters);
end;

procedure TwbUnion.Reset;
begin
  ReleaseElements;
  inherited;
end;

{ TwbValue }

function TwbValue.AddIfMissingInternal(const aElement      :  IwbElement;
                                     aAsNew        :  Boolean;
                                     aDeepCopy     :  Boolean;
                               const aPrefixRemove : string;
                               const aPrefix       : string;
                               const aSuffix       : string)
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
        if FlagsDef.CanAssign(Self, Low(Integer), Flag.FlagsDef) then begin
          s := GetEditValue;
          s := s + StringOfChar('0', 64 - Length(s));
          if (Flag.FlagIndex >= 0) and (Flag.FlagIndex < Length(s)) then begin
            s[Succ(Flag.FlagIndex)] := '1';
            SetEditValue(s);
            Exit(GetElementBySortOrder(Flag.FlagIndex));
          end;
        end;

  Result := inherited AddIfMissingInternal(aElement, aAsNew, aDeepCopy, aPrefixRemove, aPrefix, aSuffix)
end;

function TwbValue.CompareExchangeFormID(aOldFormID, aNewFormID: TwbFormID): Boolean;
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  Result := inherited CompareExchangeFormID(aOldFormID, aNewFormID);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    Result := ResolvedDef.CompareExchangeFormID(GetDataBasePtr, dcDataEndPtr, Self, aOldFormID, aNewFormID) or Result;
end;

function ValueDoInit(const aValueDef: IwbValueDef; const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Boolean;
var
  IntegerDef : IwbIntegerDef;
  FlagsDef   : IwbFlagsDef;
  i          : Cardinal;
  j          : Cardinal;
  t          : string;
  BasePtr    : Pointer;
  Element    : IwbElement;
  ValueDef   : IwbValueDef;
begin
  Result := False;

  ValueDef := Resolve(aValueDef, aBasePtr, aEndPtr, aElement);

  if Assigned(ValueDef) then
  begin
    if wbFlagsAsArray then
      if Supports(ValueDef, IwbIntegerDef, IntegerDef) then
        if Supports(IntegerDef.Formater[aElement], IwbFlagsDef, FlagsDef) then begin
          if Assigned(aBasePtr) and (FlagsDef.FlagCount > 0) then begin
            j := IntegerDef.ToInt(aBasePtr, aEndPtr, aContainer);
            if j <> 0 then
              for i := 0 to Pred(FlagsDef.FlagCount) do
                if (j and (Cardinal(1) shl i)) <> 0 then begin
                  t := FlagsDef.Flags[i];
                  if (t <> '') and (not wbHideUnused or not SameText(t,'Unused')) then
                    Element := TwbFlag.Create(aContainer, aBasePtr, aEndPtr, IntegerDef, FlagsDef, i);
                  j := j and not (Cardinal(1) shl i);
                  if j = 0 then
                    Break;
                end;
          end;

          Result := True;

        end;

    ValueDef.AfterLoad(aContainer);
  end;

  if wbMoreInfoForUnknown then begin
    if Assigned(ValueDef) then
      t := ValueDef.Name
    else
      t := '';
    if t = '' then
      t := aContainer.Def.Name;
    if SameText(t, 'Unknown') and (not Assigned(aBasePtr) or (aBasePtr <> aEndPtr)) then
      for i := 0 to 3 do begin
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsU8', wbInteger('AsU8', itU8)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsS8', wbInteger('AsS8', itS8)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsU16', wbInteger('AsU16', itU16)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsS16', wbInteger('AsS16', itS16)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsU32', wbInteger('AsU32', itU32)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsS32', wbInteger('AsS32', itS32)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsS64', wbInteger('AsS64', itS64)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsFormID', wbInteger('AsFormID', itU32, wbFormID)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsChar4', wbInteger('AsChar4', itU32, wbChar4)), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsFloat', wbFloat('AsFloat')), '', True);
        BasePtr := PByte(aBasePtr) + i;
        Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsString', wbString('AsString')), '', True);
        if wbToolSource in [tsSaves] then begin
          BasePtr := PByte(aBasePtr) + i;
          Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsRefID', wbRefID('RefID')), '', True);
          BasePtr := PByte(aBasePtr) + i;
          Element := TwbArray.Create(aContainer, BasePtr, aEndPtr, wbArray('Offset '+IntToStr(i)+' AsU6to30', wbInteger('AsU6to30', itU6to30)), '', True);
        end;
      end;
  end;

  if assigned(ValueDef) then
    i := ValueDef.Size[aBasePtr, aEndPtr, aContainer]
  else
    i := High(Integer);
  if i = Cardinal(High(Integer)) then
    aBasePtr := aEndPtr
  else if Assigned(aBasePtr) then
    Inc(PByte(aBasePtr), i);
end;


procedure TwbValue.Init;
var
  BasePtr: Pointer;
begin
  inherited;
  BasePtr := GetDataBasePtr;
  vIsFlags := ValueDoInit(vbValueDef, Self, BasePtr, dcDataEndPtr, Self);
// flags should already have been created in the right order, no need to sort them
//  if vIsFlags then
//    if Length(cntElements) > 1 then
//      wbMergeSort(@cntElements[0], Length(cntElements), CompareSortKeys);
end;

function TwbValue.IsFlags: Boolean;
begin
  Result := vIsFlags;
end;

procedure TwbValue.MasterCountUpdated(aOld, aNew: Byte);
var
  SelfRef     : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  inherited MasterCountUpdated(aOld, aNew);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.MasterCountUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew);
end;

procedure TwbValue.MasterIndicesUpdated(const aOld, aNew: TwbFileIDs);
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  inherited MasterIndicesUpdated(aOld, aNew);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.MasterIndicesUpdated(GetDataBasePtr, dcDataEndPtr, Self, aOld, aNew);
end;

procedure TwbValue.FindUsedMasters(aMasters: PwbUsedMasters);
var
  SelfRef    : IwbContainerElementRef;
  ResolvedDef : IwbValueDef;
begin
  SelfRef := Self as IwbContainerElementRef;

  DoInit;

  inherited FindUsedMasters(aMasters);

  ResolvedDef := Resolve(vbValueDef, GetDataBasePtr, dcDataEndPtr, Self);
  if Assigned(ResolvedDef) then
    ResolvedDef.FindUsedMasters(GetDataBasePtr, dcDataEndPtr, Self, aMasters);
end;

function TwbValue.GetElementType: TwbElementType;
begin
  Result := etValue;
end;

function TwbValue.GetSorted: Boolean;
var
  EmptyDef: IwbEmptyDef;
begin
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
           Result := Result + '<Unknown: '+IntToStr(i)+'>, ';
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
var
  OldValue, NewValue: Variant;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

  if (not Assigned(dcDataBasePtr) or not Assigned(dcDataEndPtr)) or (aValue <> GetEditValue) then begin
    OldValue := GetNativeValue;
    vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
    if vIsFlags and (csInit in cntStates) then begin
      Reset;
      Init;
    end;
    NewValue := GetNativeValue;
    DoAfterSet(OldValue, NewValue);
    NotifyChanged(eContainer);
    if vIsFlags and (csInit in cntStates) then begin
      if vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] <> aValue then begin
        Reset;
        Init;
      end;
    end;
  end;
end;

procedure TwbValue.SetNativeValue(const aValue: Variant);
var
  OldValue, NewValue: Variant;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

  OldValue := GetNativeValue;
  vbValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
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
  _NextLightSlot := 0;
end;

function wbFile(const aFileName: string; aLoadOrder: Integer = -1; aCompareTo: string = '';
  IsTemporary: Boolean = False; aOnlyHeader: Boolean = False): IwbFile;
var
  FileName: string;
  i: Integer;
begin
  FileName := wbExpandFileName(aFileName);
  {if ExtractFilePath(aFileName) = '' then
    FileName := ExpandFileName('.\'+aFileName)
  else
    FileName := ExpandFileName(aFileName);}

  if FilesMap.Find(FileName, i) then
    Result := IwbFile(Pointer(FilesMap.Objects[i]))
  else begin
    if not wbIsPlugin(FileName) then
      Result := TwbFileSource.Create(FileName, aLoadOrder, aCompareTo, aOnlyHeader, IsTemporary)
    else
      Result := TwbFile.Create(FileName, aLoadOrder, aCompareTo, aOnlyHeader, IsTemporary);
    SetLength(Files, Succ(Length(Files)));
    Files[High(Files)] := Result;
    FilesMap.AddObject(FileName, Pointer(Result));
  end;
end;

function wbMastersForFile(const aFileName: string; aMasters: TStrings; aIsESM, aIsESL: PBoolean): Boolean;
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
  if Assigned(aIsESL) then
    aIsESL^ := False;
  wbProgressLock;
  try
    FileName := wbExpandFileName(aFileName);
    try
      if FilesMap.Find(FileName, i) then
        _File := IwbFile(Pointer(FilesMap.Objects[i])) as IwbFileInternal
      else if not wbIsPlugin(FileName) then
        _File := TwbFileSource.Create(FileName, -1, '', True)
      else
        _File := TwbFile.Create(FileName, -1, '', True);

      if Assigned(aMasters) then
        _File.GetMasters(aMasters);
      if Assigned(aIsESM) then
        aIsESM^ := _File.IsESM;
      if Assigned(aIsESL) then
        aIsESL^ := _File.IsESL;
      Result := True;
    except
      // File neither found nor replaced, ignore if in xDump
      if not (wbToolMode in [tmDump, tmExport]) then Raise;
    end;
  finally
    wbProgressUnlock;
  end;
end;

function wbMastersForFile(const aFileName: string; out aMasters: TDynStrings; aIsESM, aIsESL: PBoolean): Boolean; overload;
var
  sl : TStringList;
begin
  aMasters := nil;
  sl := TStringList.Create;
  try
    Result := wbMastersForFile(aFileName, sl, aIsESM, aIsESL);
    if Result then
      aMasters := sl.ToStringArray;
  finally
    sl.Free;
  end;
end;

function wbNewFile(const aFileName: string; aLoadOrder: Integer; aIsESL: Boolean): IwbFile;
var
  FileName: string;
  i: Integer;
begin
  FileName := wbExpandFileName(aFileName);
  if FilesMap.Find(FileName, i) then
    raise Exception.Create(FileName + ' exists already')
  else begin
    Result := TwbFile.CreateNew(FileName, aLoadOrder, aIsESL);
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
    if Assigned(MainRecord) and (MainRecord.Signature = 'GMST') then
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
begin
  Result := wbIsInternalEdit or GetContainer.IsEditable;
end;

function TwbFlag.GetIsRemoveable: Boolean;
begin
  Result := wbIsInternalEdit or GetContainer.IsEditable;
end;

function TwbFlag.GetName: string;
begin
  Result := GetFlagsDef.Flags[fIndex];
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
    s := FlagsDef.Flags[fIndex];
    if not SameText(s, BaseFlagsDef.Flags[fIndex]) then
      Result := Result + s;
  end;
  fLastDefID := FlagsDef.DefID;
end;

function TwbFlag.GetValue: string;
//var
//  i: Int64;
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
  Result := GetFlagsDef.Flags[fIndex];
{
  i := fIntegerDef.ToInt(fBasePtr, fEndPtr, Self);
  if (i and (Int64(1) shl fIndex)) <> 0 then
    Result := GetName
  else
    Result := '';
}
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
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

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
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

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

constructor TwbDataContainer.Create(const aContainer: IwbContainer; var aBasePtr: Pointer; aEndPtr: Pointer; const aPrevMainRecord : IwbMainRecord);
begin
  dcBasePtr := aBasePtr;
  dcEndPtr := aEndPtr;
  dcDataBasePtr := aBasePtr;
  dcDataEndPtr := aEndPtr;
  inherited Create(aContainer);
  try
    InitDataPtr;
    aBasePtr := dcEndPtr;
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

  if wbTranslationMode then begin
    if Result <> cpTranslate then
      Result := cpIgnore
    else
      Result := cpNormal;
  end else begin
    if Result = cpTranslate then
      Result := cpNormal;
  end;

  if Result = cpFormID then begin
    Result := cpCritical;
    MainRecord := GetContainingMainRecord;
    if Assigned(MainRecord) and (MainRecord.Signature = 'GMST') then
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

function TwbDataContainer.GetEditInfo: string;
var
  ValueDef: IwbValueDef;
begin
  Result := '';
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

function TwbDataContainer.GetResolvedValueDef: IwbValueDef;
begin
  Result := Resolve(GetValueDef, GetDataBasePtr, dcDataEndPtr, Self);
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
  inherited;
end;

function TwbDataContainer.IsFlags: Boolean;
begin
  Result := False;
end;

function TwbDataContainer.IsValidOffset(aBasePtr, aEndPtr: Pointer; anOffset: Integer): Boolean;
begin
  Result := False;
  if NativeUInt(aBasePtr) >= NativeUInt(dcBasePtr) then
    if NativeUInt(aBasePtr) < NativeUInt(dcEndPtr) then
      if NativeUInt(aEndPtr) > NativeUInt(dcBasePtr) then
        if NativeUInt(aEndPtr) <= NativeUInt(dcEndPtr) then
          if NativeUInt(aBasePtr) + anOffset < NativeUInt(dcEndPtr) then
            Result := True;
end;

function TwbDataContainer.IsLocalOffset(anOffset: Integer): Boolean;
begin
  if NativeUInt(dcDataBasePtr) + anOffset < NativeUInt(dcDataEndPtr) then
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
  DoInit;

  ValueDef := GetValueDef;
  if Assigned(ValueDef) then begin
    OldValue := GetNativeValue;
    if ValueDef.SetToDefault(GetDataBasePtr, GetDataEndPtr, Self) then begin
      NewValue := GetNativeValue;
      DoAfterSet(OldValue, NewValue);
      NotifyChanged(eContainer);

      if IsFlags and (csInit in cntStates) then begin
        Reset;
        Init;
      end;
    end;
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

procedure TwbDataContainer.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
var
  OldPosition  : Int64;
  Size         : NativeUInt;
  ExpectedSize : NativeUInt;
begin
  if [dcfDontSave, dcfDontCompare] * dcFlags <> [] then
    Exit;

  OldPosition := aStream.Position;
  ExpectedSize := GetDataSize;

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
      Assert(not DoCheckSizeAfterWrite);

  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
  end;
end;

{ TwbValueBase }

procedure TwbValueBase.BuildRef;
var
  SelfRef: IwbElement;
begin
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
  vbNameSuffix := aNameSuffix;
  inherited Create(aContainer, aBasePtr, aEndPtr, nil);
end;

function TwbValueBase.CanContainFormIDs: Boolean;
begin
  Result := vbValueDef.CanContainFormIDs;
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
    Assign(Low(Integer), aSource, aOnlySK);
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
  DoInit;
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

function TwbValueBase.GetDisplayName: string;
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
      Result := Result + ' {' + IntToHex64(NativeUInt(GetDataBasePtr) - wbBaseOffset, 8) + '}';
    // something for Dump: Displaying the size in {} and the array count in []
    //  Triggers a lot of pre calculations
    if (Resolved.DefType in dtNonValues) and (wbDumpOffset>2) then
      Result := Result + ' {' + IntToHex64(NativeUInt(GetDataEndPtr) - wbBaseOffset, 8) +
        '-' + IntToHex64(NativeUInt(GetDataBasePtr) - wbBaseOffset, 8) +
        ' = ' +IntToStr(Resolved.Size[GetDataBasePtr, GetDataEndPtr, Self]) + '}';
    if (Resolved.DefType = dtArray) and (wbDumpOffset>1) and Supports(Self, IwbDataContainer, Container) then
      Result := Result + ' [' + IntToStr(Container.GetElementCount) + ']';
  end;
  if vbNameSuffix <> '' then
    Result := Result + ' ' + vbNameSuffix;
end;

function TwbValueBase.GetEditValue: string;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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

  DoInit;
  Result := vbValueDef.IsEditable[GetDataBasePtr, dcDataEndPtr, Self];
end;

function TwbValueBase.GetIsInSK(aIndex: Integer): Boolean;
var
  SelfRef    : IwbContainerElementRef;
  HasSortKey : IwbHasSortKeyDef;
begin
  Result := False;

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if not Supports(vbValueDef, IwbHasSortKeyDef, HasSortKey) then
    Exit;

  Result := HasSortKey.IsInSK(aIndex);
end;

function TwbValueBase.GetLinksTo: IwbElement;
var
  SelfRef: IwbContainerElementRef;
begin
  Result := nil;
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
  if not Assigned(vbValueDef) then
    Exit;
  Result := vbValueDef.LinksTo[dcDataBasePtr, dcDataEndPtr, Self];
end;

function TwbValueBase.GetName: string;
begin
  Result := vbValueDef.Name;
  if vbNameSuffix <> '' then
    Result := Result + ' ' + vbNameSuffix;
end;

function TwbValueBase.GetNativeValue: Variant;
var
  SelfRef : IwbContainerElementRef;
begin
  SelfRef := Self as IwbContainerElementRef;
  DoInit;
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
    DoInit;
    Result := vbValueDef.ToSortKey(GetDataBasePtr, dcDataEndPtr, Self, aExtended);
  end;
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
  DoInit;
  Result := vbValueDef.ToString(GetDataBasePtr, dcDataEndPtr, Self);
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
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

  if aValue <> GetEditValue then begin
    OldValue := GetNativeValue;
    vbValueDef.EditValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
    NewValue := GetNativeValue;
    DoAfterSet(OldValue, NewValue);
    NotifyChanged(eContainer);
  end;
end;


procedure TwbValueBase.SetNativeValue(const aValue: Variant);
var
  OldValue, NewValue: Variant;
begin
  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be edited.');

  OldValue := GetNativeValue;
  vbValueDef.NativeValue[GetDataBasePtr, dcDataEndPtr, Self] := aValue;
  NewValue := GetNativeValue;
  DoAfterSet(OldValue, NewValue);
  NotifyChanged(eContainer);
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
  DoInit;
  RequestStorageChange(BasePtr, EndPtr, vbValueDef.DefaultSize[nil, nil, Self]);
  inherited;
end;

{ TwbRecordHeaderStruct }

function TwbRecordHeaderStruct.AddIfMissingInternal(const aElement      : IwbElement;
                                                  aAsNew        : Boolean;
                                                  aDeepCopy     : Boolean;
                                            const aPrefixRemove : string;
                                            const aPrefix       : string;
                                            const aSuffix       : string)
                                                                : IwbElement;
var
  StructDef : IwbStructDef;
  SelfRef   : IwbContainerElementRef;
begin
  Result := nil;

  if not wbEditAllowed then
    raise Exception.Create(GetName + ' can not be assigned.');

  SelfRef := Self as IwbContainerElementRef;
  DoInit;

  if not Supports(GetDef, IwbStructDef, StructDef) then
    Exit;

  Assert(aElement.SortOrder >= 0);
  Assert(aElement.SortOrder < StructDef.MemberCount);
  Assert(Assigned(aElement.Def));
  Assert(aElement.Def.Equals(StructDef.Members[aElement.SortOrder]));

  Result := GetElementBySortOrder(aElement.SortOrder + GetAdditionalElementCount);
  Assert(Assigned(Result));
  Result.Assign(Low(Integer), aElement, not aDeepCopy);
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

  ToggleDeleted            : Boolean;
  TogglePersistent         : Boolean;
  ToggleVisibleWhenDistant : Boolean;
begin

  ToggleDeleted := False;
  TogglePersistent := False;
  ToggleVisibleWhenDistant := False;

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

        if Flags.IsPersistent <> MainRecordInternal.mrStruct.mrsFlags.IsPersistent then begin
          Flags.SetPersistent(MainRecordInternal.mrStruct.mrsFlags.IsPersistent);
          TogglePersistent := True;
        end;

        if Flags.IsVisibleWhenDistant <> MainRecordInternal.mrStruct.mrsFlags.IsVisibleWhenDistant then begin
          Flags.SetVisibleWhenDistant(MainRecordInternal.mrStruct.mrsFlags.IsVisibleWhenDistant);
          ToggleVisibleWhenDistant := True;
        end;

        MainRecordInternal.mrStruct.mrsFlags := Flags;
      end;
    end;
    p := MainRecordInternal.mrStruct;
    InformStorage(p, PByte(p) + wbSizeOfMainRecordStruct);

    with MainRecordInternal do begin
      if ToggleDeleted then
        IsDeleted := not IsDeleted;

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

procedure TwbStringListTerminator.WriteToStreamInternal(aStream: TStream; aResetModified: Boolean);
const
  NullChar : AnsiChar = #0;
begin
  aStream.Write(NullChar, 1);
  Exclude(eStates, esUnsaved);
  if aResetModified then begin
    Exclude(eStates, esModified);
    Exclude(eStates, esInternalModified);
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
    SubRecordOrderList[i] := SubRecordOrderList[i] + ' (' + IntToStr(Integer(SubRecordOrderList.Objects[i]) )+ ')';

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

  if wbVWDAsQuestChildren then Grp := [8..9] else Grp := [8..10];
  if GroupRecord.GroupType in Grp then
    if not Supports(GroupRecord.Container, IwbGroupRecord, GroupRecord) then
      Exit;

  if wbVWDAsQuestChildren then Grp := [1, 6, 7, 10] else Grp := [1, 6, 7];
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
      NewOwner := _File.RecordByFormID[NewFormID, False];
      if not Assigned(NewOwner) then begin
        if Assigned(dcDataBasePtr) then
          PCardinal(dcDataBasePtr)^ := OldFormID.ToCardinal;
        Exit;
      end;
      if not _File.Equals(NewOwner._File) then
        NewOwner := wbCopyElementToFile(NewOwner, _File, False, True, '', '', '') as IwbMainRecord;
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

  Inc(mrehGeneration);
  mrehHead := nil;
  mrehTail := nil;
  mrehCount := 0;
end;

procedure TwbMainRecordEntryHeader.EndUse;
begin
  Assert(mrehInUse);
  mrehInUse := False;

  Inc(mrehGeneration);
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
      fPath := wbDataPath + MasterFiles[i].Value;
      if FileExists(fPath) then
        aMasters.Add(MasterFiles[i].Value)
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
      wbProgressCallback('Could not copy '+FileName+' into '+wbDataPath);
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

begin
  SelfRef := Self as IwbContainerElementRef;
  flProgress('Start processing');

  flLoadOrderFileID := TwbFileID.Create($FF);

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
      fPath := wbDataPath + MasterFiles[i].Value;
      if FileExists(fPath) then
        AddMaster(fPath)
      else if wbUseFalsePlugins then begin
        fPath := wbDataPath + wbAppName + TheEmptyPlugin; // place holder to keep save indexes
        if not FileExists(fPath) then
          fPath := ExtractFilePath(wbProgramPath) + wbAppName + TheEmptyPlugin; // place holder to keep save indexes
        if FileExists(fPath) then
          AddMaster(SelectTemporaryCopy(fPath, MasterFiles[i].Value), True);
      end;
    end;

  if flCompareTo <> '' then
    AddMaster(flCompareTo);

  if Assigned(wbExtractInfo) then
    ExtractInfo := wbExtractInfo^
  else
    ExtractInfo := [];

  for i := 0 to Pred(wbFileChapters.MemberCount) do begin
    case wbFileChapters.Members[i].DefType of
      dtArray: Element := TwbArray.Create(Self, currentPtr, flEndPtr, wbFileChapters.Members[i], '');
      dtStruct: Element := TwbStruct.Create(Self, currentPtr, flEndPtr, wbFileChapters.Members[i], '');
      dtStructChapter: Element := TwbChapter.Create(Self, currentPtr, flEndPtr, wbFileChapters.Members[i], '');
      dtUnion: Element := TwbUnion.Create(Self, currentPtr, flEndPtr, wbFileChapters.Members[i], '');
    else
      Element := TwbValue.Create(Self, currentPtr, flEndPtr, wbFileChapters.Members[i], '');
    end;
    if (i in ExtractInfo) and Supports(Element, IwbContainer, Container) then
      with Element as TwbContainer do DoInit;
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

initialization
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

{$IFDEF USE_PARALLEL_BUILD_REFS}
  _ResizeLock.Destroy;
{$ENDIF}
end.
