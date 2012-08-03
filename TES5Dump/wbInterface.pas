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
unit wbInterface;

interface

uses
  Classes,
  SysUtils,
  Graphics,
  D3DX9;

const
  VersionString               = '3.0.312 (2012-08-2) EXPERIMENTAL';

  clOrange                    = $004080FF;
  wbFloatDigits               = 6;

type
  TwbProgressCallback = procedure(const aStatus: string);

  TwbPointerArray = array [0..Pred(High(Integer) div SizeOf(Pointer))] of Pointer;
  PwbPointerArray = ^TwbPointerArray;       {General array of pointer}

threadvar
  wbProgressCallback : TwbProgressCallback;
  wbCurrentAction    : string;
  wbStartTime        : TDateTime;
  wbShowStartTime    : Integer;


var
  wbDisplayLoadOrderFormID : Boolean;
  wbSimpleLAND : Boolean = False;
  wbFixupPGRD : Boolean = False;
  wbIKnowWhatImDoing : Boolean = False;
  wbHideUnused : Boolean{} = False{True}{};
  wbHideIgnored : Boolean{} = False{True}{};
  wbDisplayShorterNames : Boolean;
  wbSortSubRecords: Boolean;
  wbEditAllowed: Boolean;
  wbFlagsAsArray: Boolean;
  wbDelayLoadRecords: Boolean = True;
  wbMoreInfoForUnknown: Boolean{} = False{True}{};
  wbTranslationMode: Boolean;
  wbTestWrite: Boolean;
  wbRequireLoadOrder: Boolean;
  wbVWDInTemporary: Boolean;
  wbAllowUnordered: Boolean{} = False{};

  wbMasterUpdate: Boolean;
  wbMasterUpdateDone: Boolean;
  wbMasterUpdateFilterONAM: Boolean;
  wbMasterUpdateFixPersistence: Boolean = True;
  wbMasterRestore: Boolean;
  wbDontSave: Boolean;

  wbLODGen: Boolean;

  wbAllowInternalEdit: Boolean{} = True{};
  wbShowInternalEdit: Boolean{ = True{};

  wbReportMode: Boolean{} = True{};
  wbReportUnused: Boolean{} = True{};
  wbReportRequired: Boolean{} = True{};
  wbReportUnusedData: Boolean{} = True{};
  wbReportUnknownFormIDs: Boolean{} = True{};
  wbReportUnknownFloats: Boolean{} = True{};
  wbReportUnknownStrings: Boolean{} = True{};
  wbReportEmpty: Boolean{} = True{};
  wbReportSometimesEmpty: Boolean {}= True{};
  wbReportFormIDs: Boolean{} = True{};
  wbReportNotFoundButAllowedFormIDs: Boolean{} = True{};
  wbReportUnknownFlags: Boolean{} = True{};
  wbReportUnknownEnums: Boolean{} = True{};
  wbReportFormIDNotAllowedReferences: Boolean{} = True{};
  wbReportUnknown: Boolean{} = True{};
//------------------------------------------------------------------------------
// Added LString Routine
//------------------------------------------------------------------------------
  wbReportUnknownLStrings: Boolean{} = False{};

  wbCheckExpectedBytes: Boolean{} = True{};

  wbRotationFactor : Extended = 180/Pi;
  wbRotationScale : Integer = 4;

//  wbRotationFactor : Extended = 1;
//  wbRotationScale : Integer = 6;

type
  TConflictAll = (
    caUnknown,
    caOnlyOne,
    caNoConflict,
    caConflictBenign,
    caOverride,
    caConflict,
    caConflictCritical
    );

  TConflictAllSet = set of TConflictAll;

  TConflictThis = (
    ctUnknown,
    ctIgnored,
    ctNotDefined,
    ctIdenticalToMaster,
    ctOnlyOne,
    ctHiddenByModGroup,
    ctMaster,
    ctConflictBenign,
    ctOverride,
    ctIdenticalToMasterWinsConflict,
    ctConflictWins,
    ctConflictLoses
    );

  TConflictThisSet = set of TConflictThis;

  TwbConflictPriority = (
    cpIgnore,
    cpBenign,
    cpTranslate,
    cpNormal,
    cpCritical,
    cpFormID
  );

  LongRecSmall = packed record
    Lo, Hi: Smallint;
  end;

  PwbSignature = ^TwbSignature;
  TwbSignature = array[0..3] of AnsiChar;
  TwbSignatures = array of TwbSignature;

  TwbIntType = (
    itU8,
    itS8,
    itU16,
    itS16,
    itU32,
    itS32,
    itU64,
    itS64
  );

  TwbDefType = (
    dtRecord,
    dtSubRecord,
    dtSubRecordArray,
    dtSubRecordStruct,
    dtSubRecordUnion,
    dtString,
    dtLenString,
    dtByteArray,
    dtInteger,
    dtIntegerFormater,
    dtFloat,
    dtArray,
    dtStruct,
    dtUnion,
    dtEmpty
  );

  IwbDef = interface;

  TwbDefs = array of IwbDef;
  TwbDefPath = array of record
    Def   : IwbDef;
    Index : Integer;
  end;

  IwbElement = interface;

  IwbDef = interface
    ['{C7739FBD-3B58-48A2-9DD0-8057D3496892}']
    function GetDefType: TwbDefType;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
    function GetDefID: Cardinal;
    function Equals(const aDef: IwbDef): Boolean;
    function GetConflictPriority: TwbConflictPriority;
    function GetRequired: Boolean;
    function CanContainFormIDs: Boolean;
    function GetDontShow(const aElement: IwbElement): Boolean;
    function GetHasDontShow: Boolean;
    function GetRoot: IwbDef;
    function GetNoReach: Boolean;

    procedure Report(const aParents: TwbDefPath);
    procedure Used(const aElement: IwbElement = nil; const s: string = '');
    procedure PossiblyRequired;
    procedure NotRequired;
    function IsNotRequired: Boolean;

    property DefType: TwbDefType
      read GetDefType;
    property DefID: Cardinal
      read GetDefID;
    property ConflictPriority: TwbConflictPriority
      read GetConflictPriority;
    property Required: Boolean
      read GetRequired;
    property DontShow[const aElement: IwbElement]: Boolean
      read GetDontShow;
    property HasDontShow: Boolean
      read GetHasDontShow;
    property Root: IwbDef
      read GetRoot;
    property NoReach: Boolean
      read GetNoReach;
  end;

  TwbElementType = (
    etFile,
    etMainRecord,
    etGroupRecord,
    etSubRecord,
    etSubRecordStruct,
    etSubRecordArray,
    atSubRecordUnion,
    etArray,
    etStruct,
    etValue,
    etFlag,
    etStringListTerminator
  );

  IwbContainer = interface;
  IwbFile = interface;
  IwbNamedDef = interface;
  IwbValueDef = interface;
  IwbMainRecord = interface;

  TwbElementState = (
    esModified,
    esInternalModified,
    esUnsaved,
    esSortKeyValid,
    esExtendedSortKeyValid,
    esHidden,
    esParentHidden,
    esParentHiddenChecked,
    esNotReachable,
    esReachable,
    esTagged,
    esDeciding
  );

  TwbElementStates = set of TwbElementState;

  TwbEditType = (
    etDefault,
    etComboBox,
    etCheckComboBox
  );

  TDynFiles = array of IwbFile;

  IwbElement = interface
    ['{F4B4637D-C794-415F-B5C7-587EAA4095B3}']

    function GetElementID: Cardinal;
    function GetElementStates: TwbElementStates;
    function Equals(const aElement: IwbElement): Boolean;

    function GetValue: string;
    function GetCheck: string;
    function GetSortKey(aExtended: Boolean): string;
    function GetSortPriority: Integer;
    function GetName: string;
    function GetDisplayName: string;
    function GetShortName: string;
    function GetPath: string;
    function GetFullPath: string;
    function GetSkipped: Boolean;
    function GetDef: IwbNamedDef;
    function GetValueDef: IwbValueDef;
    function GetElementType: TwbElementType;
    function GetContainer: IwbContainer;
    function GetContainingMainRecord: IwbMainRecord;
    function GetFile: IwbFile;
    function GetReferenceFile: IwbFile;
    function GetSortOrder: Integer;
    procedure SetSortOrder(aSortOrder: Integer);
    procedure BuildRef;
    function CompareExchangeFormID(aOldFormID: Cardinal; aNewFormID: Cardinal): Boolean;
    function GetEditValue: string;
    procedure SetEditValue(const aValue: string);
    function GetNativeValue: Variant;
    procedure SetNativeValue(const aValue: Variant);
    function GetIsEditable: Boolean;
    function GetIsRemoveable: Boolean;
    procedure RequestStorageChange(var aBasePtr, aEndPtr: Pointer; aNewSize: Cardinal);
    function GetConflictPriority: TwbConflictPriority;
    function GetModified: Boolean;
    procedure MarkModifiedRecursive;
    function GetIsInjected: Boolean;
    function GetReferencesInjected: Boolean;
    function GetInjectionSourceFiles: TDynFiles;
    function GetIsNotReachable: Boolean;
    function GetDataSize: Integer;
    procedure SetDataSize(aSize: Integer);
    procedure MergeStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
    procedure InformStorage(var aBasePtr: Pointer; aEndPtr: Pointer);
    procedure AddReferencedFromID(aFormID: Cardinal);
    function CanContainFormIDs: Boolean;
    function GetLinksTo: IwbElement;
    function GetNoReach: Boolean;
    procedure ReportRequiredMasters(aStrings: TStrings; aAsNew: Boolean);
    function AddIfMissing(const aElement: IwbElement; aAsNew, aDeepCopy : Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;
    procedure ResetConflict;
    procedure ResetReachable;
    function RemoveInjected(aCanRemove: Boolean): Boolean;
    function GetEditType: TwbEditType;
    function GetEditInfo: string;
    function GetDontShow: Boolean;
    procedure SetToDefault;

    procedure NotifyChanged;

    function CanAssign(aIndex: Integer; const aElement: IwbElement; aCheckDontShow: Boolean): Boolean;
    function Assign(aIndex: Integer; const aElement: IwbElement; aOnlySK: Boolean): IwbElement;
    procedure Remove;

    function HasErrors: Boolean;

    procedure Hide;
    procedure Show;
    function GetIsHidden: Boolean;

    procedure MoveUp;
    procedure MoveDown;
    function CanMoveUp: Boolean;
    function CanMoveDown: Boolean;

    procedure Tag;
    procedure ResetTags;
    function IsTagged: Boolean;

    property IsHidden: Boolean
      read GetIsHidden;

    procedure WriteToStream(aStream: TStream);

    function CopyInto(const aFile: IwbFile; AsNew, DeepCopy: Boolean; const aPrefixRemove, aPrefix, aSuffix: string): IwbElement;

    property ElementID: Cardinal
      read GetElementID;
    property ElementStates: TwbElementStates
      read GetElementStates;

    property Container: IwbContainer
      read GetContainer;
    property ContainingMainRecord: IwbMainRecord
      read GetContainingMainRecord;
    property _File: IwbFile
      read GetFile;
    property ReferenceFile: IwbFile
      read GetReferenceFile;
    property InjectionSourceFiles: TDynFiles
      read GetInjectionSourceFiles;

    property ElementType: TwbElementType
      read GetElementType;
    property Name: string
      read GetName;
    property DisplayName: string
      read GetDisplayName;
    property ShortName: string
      read GetShortName;
    property Path: string
      read GetPath;
    property FullPath: string
      read GetFullPath;
    property Skipped: Boolean
      read GetSkipped;

    property Value: string
      read GetValue;
    property SortKey[aExtended: Boolean]: string
      read GetSortKey;
    property Check: string
      read GetCheck;

    property Modified: Boolean
      read GetModified;
    property IsInjected: Boolean
      read GetIsInjected;
    property IsNotReachable: Boolean
      read GetIsNotReachable;
    property ReferencesInjected: Boolean
      read GetReferencesInjected;

    property IsEditable: Boolean
      read GetIsEditable;
    property EditValue: string
      read GetEditValue
      write SetEditValue;
    property NativeValue: Variant
      read GetNativeValue
      write SetNativeValue;

    property IsRemoveable: Boolean
      read GetIsRemoveable;

    property Def: IwbNamedDef
      read GetDef;
    property ValueDef: IwbValueDef
      read GetValueDef;

    property SortPriority: Integer
      read GetSortPriority;
    property SortOrder: Integer
      read GetSortOrder
      write SetSortOrder;

    property ConflictPriority: TwbConflictPriority
      read GetConflictPriority;

    property DateSize: Integer
      read GetDataSize
      write SetDataSize;

    property LinksTo: IwbElement
      read GetLinksTo;
    property NoReach: Boolean
      read GetNoReach;

    property EditType: TwbEditType
      read GetEditType;
    property EditInfo: string
      read GetEditInfo;

    property DontShow: Boolean
      read GetDontShow;
  end;

  IwbRecord = interface;

  TwbContainerState = (
    csInit,
    csInitOnce,
    csInitDone,
    csInitializing,
    csRefsBuild,
    csAsCreatedEmpty
  );

  TwbContainerStates = set of TwbContainerState;

  TDynStrings = array of string;

  IwbContainerBase = interface(IwbElement)
    ['{1484D26A-0F67-41FA-9044-8772E68CBA56}']

    function GetElement(aIndex: Integer): IwbElement;
    function GetElementCount: Integer;
    function GetElementByName(const aName: string): IwbElement;
    function GetRecordBySignature(const aSignature: TwbSignature): IwbRecord;
    function GetElementBySignature(const aSignature: TwbSignature): IwbElement;
    function GetElementBySortOrder(aSortOrder: Integer): IwbElement;
    function GetAdditionalElementCount: Integer;
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

    procedure AddElement(const aElement: IwbElement);
    procedure InsertElement(aPos: Integer; const aElement: IwbElement);
    function RemoveElement(aPos: Integer; aMarkModified: Boolean = False): IwbElement; overload;
    function RemoveElement(const aElement: IwbElement; aMarkModified: Boolean = False): IwbElement; overload;
    function RemoveElement(const aName: string): IwbElement; overload;
    procedure ReverseElements;

    function LastElement: IwbElement;

    function IsElementRemoveable(const aElement: IwbElement): Boolean;
    function IsElementEditable(const aElement: IwbElement): Boolean;

    function IndexOf(const aElement: IwbElement): Integer;

    function CanElementReset: Boolean;

    function GetAddList: TDynStrings;
    function Add(const aName: string; aSilent: Boolean = True): IwbElement;

    property Elements[aIndex: Integer]: IwbElement
      read GetElement; default;
    property ElementCount: Integer
      read GetElementCount;
    property AdditionalElementCount: Integer
      read GetAdditionalElementCount;

    property ElementByPath[const aPath: string]: IwbElement
      read GetElementByPath;
    property ElementValues[const aName: string]: string
      read GetElementValue;
    property ElementEditValues[const aName: string]: string
      read GetElementEditValue
      write SetElementEditValue;
    property ElementNativeValues[const aName: string]: Variant
      read GetElementNativeValue
      write SetElementNativeValue;
    property ElementLinksTo[const aName: string]: IwbElement
      read GetElementLinksTo;
    property ElementExists[const aName: string]: Boolean
      read GetElementExists;
    property ElementSortKeys[const aName: string; aExtended: Boolean]: string
      read GetElementSortKey;


    property ContainerStates: TwbContainerStates
      read GetContainerStates;

    property ElementByName[const aName: string]: IwbElement
      read GetElementByName;
    property RecordBySignature[const aSignature: TwbSignature]: IwbRecord
      read GetRecordBySignature;
    property ElementBySignature[const aSignature: TwbSignature]: IwbElement
      read GetElementBySignature;
    property ElementBySortOrder[aSortOrder: Integer]: IwbElement
      read GetElementBySortOrder;
  end;

  IwbContainer = interface(IwbContainerBase)
    ['{4C4FCDD0-C885-458A-B8F2-EA3EFF8B5EEE}']
    procedure Bar;
  end;

  IwbContainerElementRef= interface(IwbContainerBase)
    ['{4066BCCF-01AA-4638-9C3D-3475CD8D5749}']
    procedure Foo;
  end;


  IwbSortableContainer = interface(IwbContainer)
    ['{A8A65D99-507C-4D2D-86EF-57BC99E09964}']
    function GetSorted: Boolean;

    property Sorted: Boolean
      read GetSorted;
  end;

  IwbGroupRecord = interface;

  TwbFileState = (
    fsIsNew,
    fsIsCompareLoad,
    fsOnlyHeader,
    fsIsHardcoded,
    fsIsGameMaster
  );

  TwbFileStates = set of TwbFileState;

  IwbFile = interface(IwbContainer)
    ['{38AA15A6-F652-45C7-B875-9CB502E5DA92}']
    function GetFileName: string;
    function GetFullFileName: string;
    function GetUnsavedSince: TDateTime;
    function GetMaster(aIndex: Integer): IwbFile;
    function GetMasterCount: Integer;
    function GetRecordByFormID(aFormID: Cardinal; aAllowInjected: Boolean): IwbMainRecord;
    function GetRecordByEditorID(const aEditorID: string): IwbMainRecord;
    function GetLoadOrder: Integer;
    function GetGroupBySignature(const aSignature: TwbSignature): IwbGroupRecord;
    function HasGroup(const aSignature: TwbSignature): Boolean;
    function GetFileStates: TwbFileStates;
    procedure BuildReachable;

    function LoadOrderFormIDtoFileFormID(aFormID: Cardinal): Cardinal;
    function FileFormIDtoLoadOrderFormID(aFormID: Cardinal): Cardinal;

    function LoadOrderFileIDtoFileFileID(aFileID: Byte): Byte;
    function FileFileIDtoLoadOrderFileID(aFileID: Byte): Byte;

    function NewFormID: Cardinal;

    procedure AddMasters(aMasters: TStrings);
    procedure AddMasterIfMissing(const aMaster: string);
    procedure SortMasters;
    procedure CleanMasters;

    function GetRecord(aIndex: Integer): IwbMainRecord;
    function GetRecordCount: Integer;

    function GetIsESM: Boolean;
    procedure SetIsESM(Value: Boolean);

    function GetIsLocalized: Boolean;
    procedure SetIsLocalized(Value: Boolean);

    property FileName: string
      read GetFileName;
    property UnsavedSince: TDateTime
      read GetUnsavedSince;

    function HasMaster(const aFileName: string): Boolean;
    property Masters[aIndex: Integer]: IwbFile
      read GetMaster;
    property MasterCount: Integer
      read GetMasterCount;

    property RecordByFormID[aFormID: Cardinal; aAllowInjected: Boolean]: IwbMainRecord
      read GetRecordByFormID;
    property RecordByEditorID[const aEditorID: string]: IwbMainRecord
      read GetRecordByEditorID;
     property GroupBySignature[const aSignature: TwbSignature]: IwbGroupRecord
      read GetGroupBySignature;

    property Records[aIndex: Integer]: IwbMainRecord
      read GetRecord;
    property RecordCount: Integer
      read GetRecordCount;

    property LoadOrder: Integer
      read GetLoadOrder;

    property FileStates: TwbFileStates
      read GetFileStates;

    property IsESM: Boolean
      read GetIsESM
      write SetIsESM;

    property IsLocalized: Boolean
      read GetIsLocalized
      write SetIsLocalized;
  end;

  IwbDataContainer = interface(IwbContainer)
    ['{6E547F7C-87E4-4917-8F43-4D3CEE5AFE8C}']
    function GetDataBasePtr: Pointer;
    function GetDataEndPtr: Pointer;
    function GetDataSize: Integer;
    function GetDontCompare: Boolean;
    function GetDontSave: Boolean;

    property DataBasePtr: Pointer
      read GetDataBasePtr;
    property DataEndPtr: Pointer
      read GetDataEndPtr;
    property DateSize: Integer
      read GetDataSize;

    property DontCompare: Boolean
      read GetDontCompare;
    property DontSave: Boolean
      read GetDontSave;
  end;

  IwbRecord = interface(IwbDataContainer)
    ['{4FC53881-25E2-421D-8AF6-F589979767E6}']
    function GetSignature: TwbSignature;

    property Signature: TwbSignature
      read GetSignature;
  end;

  IwbHasSignature = interface(IwbElement)
    ['{DF563D7C-A441-4864-B47A-49F3A96508F7}']
    function GetSignature: TwbSignature;

    property Signature: TwbSignature
      read GetSignature;
  end;

  PwbMainRecordStructFlags = ^TwbMainRecordStructFlags;
  TwbMainRecordStructFlags = packed record
    _Flags: Cardinal;
    function IsESM: Boolean; inline;
    function IsDeleted: Boolean; inline;
    function IsLocalized: Boolean; inline;
    function CastsShadows: Boolean; inline;
    function IsPersistent: Boolean; inline;
    function IsInitiallyDisabled: Boolean; inline;
    function IsIgnored: Boolean; inline;
    function IsVisibleWhenDistant: Boolean; inline;
    function IsDangerous: Boolean; inline;
    function IsCompressed: Boolean; inline;
    function CantWait: Boolean; inline;

    procedure SetESM(aValue: Boolean);
    procedure SetDeleted(aValue: Boolean);
    procedure SetLocalized(aValue: Boolean);
    procedure SetPersistent(aValue: Boolean);
    procedure SetCompressed(aValue: Boolean);
    procedure SetInitiallyDisabled(aValue: Boolean);
    procedure SetVisibleWhenDistant(aValue: Boolean);
  end;

  PwbMainRecordStructFlags3 = ^TwbMainRecordStructFlags3;
  TwbMainRecordStructFlags3 = packed record
    _Flags: Cardinal;
  end;

  TwbGridCell = record
    x, y: Integer;
  end;

  TDynMainRecords = array of IwbMainRecord;

  IwbMainRecord = interface(IwbRecord)
    ['{F06FD5E2-621D-4422-BA00-CB3CA72B3691}']
    function GetFormID: Cardinal;
    function GetFixedFormID: Cardinal;
    function GetLoadOrderFormID: Cardinal;
    procedure SetLoadOrderFormID(aFormID: Cardinal);
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
    function GetReferencedBy(aIndex: Integer): IwbMainRecord;
    function GetReferencedByCount: Integer;
    function GetIsWinningOverride: Boolean;
    function GetWinningOverride: IwbMainRecord;
    function GetHighestOverrideOrSelf(aMaxLoadOrder: Integer): IwbMainRecord;
    function GetFlags: TwbMainRecordStructFlags;
    function GetChildGroup: IwbGroupRecord;
    function EnsureChildGroup: IwbGroupRecord;
    function GetBaseRecord: IwbMainRecord;
    function GetBaseRecordID: Cardinal;

    function GetConflictAll: TConflictAll;
    procedure SetConflictAll(aValue: TConflictAll);
    function GetConflictThis: TConflictThis;
    procedure SetConflictThis(aValue: TConflictThis);

    function GetIsESM: Boolean;
    procedure SetIsESM(aValue: Boolean);
    function GetIsPersistent: Boolean;
    procedure SetIsPersistent(aValue: Boolean);
    function GetIsDeleted: Boolean;
    procedure SetIsDeleted(aValue: Boolean);
    function GetIsLocalized: Boolean;
    procedure SetIsLocalized(aValue: Boolean);
    function GetIsCompressed: Boolean;
    procedure SetIsCompressed(aValue: Boolean);
    function GetIsVisibleWhenDistant: Boolean;
    procedure SetIsVisibleWhenDistant(aValue: Boolean);
    function GetHasVisibleWhenDistantMesh: Boolean;
    function GetHasMesh: Boolean;
    function GetIsInitiallyDisabled: Boolean;
    procedure SetIsInitiallyDisabled(aValue: Boolean);

    procedure UpdateRefs;

    function GetPosition(out aPosition: TD3DXVector3): Boolean;
    function SetPosition(const aPosition: TD3DXVector3): Boolean;
    function GetRotation(out aRotation: TD3DXVector3): Boolean;
    function GetScale(out aScale: Single): Boolean;

    function GetGridCell(out aGridCell: TwbGridCell): Boolean;

    procedure Delete;
    procedure DeleteInto(const aFile: IwbFile);

    function MasterRecordsFromMasterFilesAndSelf: TDynMainRecords;

    property BaseRecord: IwbMainRecord
      read GetBaseRecord;
    property BaseRecordID: Cardinal
      read GetBaseRecordID;
    property FormID: Cardinal
      read GetFormID;
    property FixedFormID: Cardinal
      read GetFixedFormID;
    property LoadOrderFormID: Cardinal
      read GetLoadOrderFormID
      write SetLoadOrderFormID;
    property EditorID: string
      read GetEditorID
      write SetEditorID;
    property CanHaveEditorID: Boolean
      read GetCanHaveEditorID;
    property FullName: string
      read GetFullName;
    property DisplayNameKey: string
      read GetDisplayNameKey;

    property Flags: TwbMainRecordStructFlags
      read GetFlags;

    property Master: IwbMainRecord
      read GetMaster;
    property MasterOrSelf: IwbMainRecord
      read GetMasterOrSelf;
    property IsMaster: Boolean
      read GetIsMaster;

    property ChildGroup: IwbGroupRecord
      read GetChildGroup;

    property Overrides[aIndex: Integer]: IwbMainRecord
      read GetOverride;
    property OverrideCount: Integer
      read GetOverrideCount;
    property IsWinningOverride: Boolean
      read GetIsWinningOverride;
    property WinningOverride: IwbMainRecord
      read GetWinningOverride;
    property HighestOverrideOrSelf[aMaxLoadOrder: Integer]: IwbMainRecord
      read GetHighestOverrideOrSelf;

    property ReferencedBy[aIndex: Integer]: IwbMainRecord
      read GetReferencedBy;
    property ReferencedByCount: Integer
      read GetReferencedByCount;

    property IsESM: Boolean
      read GetIsESM
      write SetIsESM;
    property IsPersistent: Boolean
      read GetIsPersistent
      write SetIsPersistent;
    property IsDeleted: Boolean
      read GetIsDeleted
      write SetIsDeleted;
    property IsCompressed: Boolean
      read GetIsCompressed
      write SetIsCompressed;
    property IsLocalized: Boolean
      read GetIsLocalized
      write SetIslocalized;
    property IsVisibleWhenDistant: Boolean
      read GetIsVisibleWhenDistant
      write SetIsVisibleWhenDistant;
    property HasVisibleWhenDistantMesh: Boolean
      read GetHasVisibleWhenDistantMesh;
    property HasMesh: Boolean
      read GetHasMesh;
    property IsInitiallyDisabled: Boolean
      read GetIsInitiallyDisabled
      write SetIsInitiallyDisabled;

    property ConflictAll: TConflictAll
      read GetConflictAll
      write SetConflictAll;
    property ConflictThis: TConflictThis
      read GetConflictThis
      write SetConflictThis;
  end;

  TDynElements = array of IwbElement;
  TDynCardinalArray = array of Cardinal;

  IwbSubRecord = interface(IwbRecord)
    ['{CDE36A3D-64F6-4B8E-980E-FBAB8D9FCAF7}']
  end;

  TDynGroupRecords = array of IwbGroupRecord;

  IwbGroupRecord = interface(IwbRecord)
    ['{BFF16E47-4E66-4EAD-9BEF-364728AE0A6B}']
    function GetGroupType: Integer;
    function GetGroupLabel: Cardinal;
    procedure SetGroupLabel(aLabel: Cardinal);
    function GetChildrenOf: IwbMainRecord;

    function FindChildGroup(aType: Integer; aMainRecord: IwbMainRecord): IwbGroupRecord;

    function GetMainRecordByEditorID(const aEditorID: string): IwbMainRecord;

    property GroupType: Integer
      read GetGroupType;
    property GroupLabel: Cardinal
      read GetGroupLabel
      write SetGroupLabel;

    property ChildrenOf: IwbMainRecord
      read GetChildrenOf;

    property MainRecordByEditorID[const aEditorID: string]: IwbMainRecord
      read GetMainRecordByEditorID;
  end;

  IwbSubRecordArray = interface
    ['{26937F7A-5F31-4D65-932F-038BD0FA9FEF}']
  end;

  IwbSubRecordStruct = interface
    ['{E8C496D3-D396-4685-87EC-82E1FD2588B8}']
  end;

  IwbSubRecordUnion = interface
    ['{11959F58-B396-4449-9D9D-5DF1251C3E76}']
  end;

  TwbCallbackType = (
    ctToStr,
    ctToSortKey,
    ctCheck,
    ctToEditValue,
    ctEditType,
    ctEditInfo
  );

  TwbAfterLoadCallback = procedure(const aElement: IwbElement);
  TwbAfterSetCallback = procedure(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
  TwbDontShowCallback = function(const aElement: IwbElement): Boolean;
  TwbFloatNormalizer = function(const aElement: IwbElement; aFloat: Extended): Extended;
  TwbIntToStrCallback = function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
  TwbStrToIntCallback = function(const aString: string; const aElement: IwbElement): Int64;
  TwbAddInfoCallback = function(const aMainRecord: IwbMainRecord): string;
  TwbUnionDecider = function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
  TwbIsSortedCallback = function(const aContainer: IwbContainer): Boolean;
  TwbCountCallback = function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

  IwbNamedDef = interface(IwbDef)
    ['{F8FEDE89-C089-42C5-B587-49A7D87055F0}']
    function GetName: string;
    procedure AfterLoad(const aElement: IwbElement);
    procedure AfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

    property Name: string
      read GetName;
  end;

  IwbSignatureDef = interface(IwbNamedDef)
    ['{EF20E1A2-8719-4934-AC36-C91DC72C3F70}']
    function GetDefaultSignature: TwbSignature;

    function GetSignatures(const aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;

    function CanHandle(aSignature     : TwbSignature;
                 const aDataContainer : IwbDataContainer)
                                      : Boolean;

    property DefaultSignature: TwbSignature
      read GetDefaultSignature;

    property Signatures[const aIndex: Integer]: TwbSignature
      read GetSignatures;
    property SignatureCount: Integer
      read GetSignatureCount;
  end;

  IwbRecordMemberDef = interface;

  IwbRecordDef = interface(IwbSignatureDef)
    ['{89FE380F-7A0B-493C-AA9E-08957A4C167B}']
    function ContainsMemberFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Boolean;
    function GetMemberFor(aSignature     : TwbSignature;
                    const aDataContainer : IwbDataContainer)
                                         : IwbRecordMemberDef;
    function GetMemberIndexFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Integer;

    function AllowUnordered: Boolean;
    function AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;

    function GetMember(aIndex: Integer): IwbRecordMemberDef;
    function GetMemberCount: Integer;

    function GetSkipSignature(const aSignature: TwbSignature): Boolean;

    function GetQuickInitLimit: Integer;
    function GetContainsEditorID: Boolean;

    property Members[aIndex: Integer]: IwbRecordMemberDef read GetMember;
    property MemberCount: Integer read GetMemberCount;

    property SkipSignature[const aSignature: TwbSignature]: Boolean
      read GetSkipSignature;

    property QuickInitLimit: Integer
      read GetQuickInitLimit;
    property ContainsEditorID: Boolean
      read GetContainsEditorID;
  end;

  IwbHasSortKeyDef = interface(IwbRecordDef)
    ['{877FEF58-72B1-4735-9E08-166B5F4043F3}']
    function GetSortKey(aIndex: Integer; aExtended: Boolean): Integer;
    function GetSortKeyCount(aExtended: Boolean): Integer;
    function IsInSK(aIndex: Integer): Boolean;

    property SortKeys[aIndex: Integer; aExtended: Boolean]: Integer
      read GetSortKey;
    property SortKeyCount[aExtended: Boolean]: Integer
      read GetSortKeyCount;
  end;


  IwbRecordMemberDef = interface(IwbSignatureDef)
    ['{259F3F08-F4ED-439D-8C1A-48137C84E52A}']
  end;

  TwbUsedMasters = array[Byte] of Boolean;
  PwbUsedMasters = ^TwbUsedMasters;

  IwbValueDef = interface(IwbNamedDef)
    ['{BBF684A6-0EE5-4EF6-83DD-D323A0D2919A}']
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
    function Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
    function GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement;
    procedure BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement);
    function GetIsVariableSize: Boolean;
    function GetCanBeZeroSize: Boolean;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
    function GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType;
    function GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
    function SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;

    procedure MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte);
    procedure MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes);
    procedure FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters);
    function CompareExchangeFormID(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOldFormID: Cardinal; aNewFormID: Cardinal): Boolean;

    property Size[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: Integer
      read GetSize;
    property IsVariableSize: Boolean
      read GetIsVariableSize;
    property CanBeZeroSize: Boolean
      read GetCanBeZeroSize;
    property IsEditable[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: Boolean
      read GetIsEditable;
    property EditValue[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: string
      read ToEditValue
      write FromEditValue;
    property NativeValue[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: Variant
      read ToNativeValue
      write FromNativeValue;
    property LinksTo[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: IwbElement
      read GetLinksTo;

    property EditType[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: TwbEditType
      read GetEditType;
    property EditInfo[aBasePtr, aEndPtr: Pointer; const aElement: IwbElement]: string
      read GetEditInfo;
  end;

  IwbSubRecordDef = interface(IwbRecordMemberDef)
    ['{D848E426-8768-45F4-B192-4DEFBE34D40A}']
    function GetValue: IwbValueDef;
    procedure HasUnusedData;

    property Value: IwbValueDef read GetValue;
  end;

  IwbSubRecordArrayDef = interface(IwbRecordMemberDef)
    ['{67943BAC-B558-4112-8DBC-C94A44E0B1D1}']
    function GetElement: IwbRecordMemberDef;
    function GetSorted(const aContainer: IwbContainer): Boolean;

    property Element: IwbRecordMemberDef read GetElement;
    property Sorted[const aContainer: IwbContainer]: Boolean read GetSorted;
  end;

  IwbSubRecordStructDef = interface(IwbRecordMemberDef)
    ['{B5441812-5229-488B-AEA6-C182CEBED441}']
  end;

  IwbSubRecordUnionDef = interface(IwbRecordMemberDef)
    ['{BC66ABFF-3108-4C64-B416-674A2A8F297D}']
  end;

  IwbUnionDef = interface(IwbValueDef)
    ['{04D6B7BA-B457-4E43-9910-592395FEA0D6}']
    function Decide(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): IwbValueDef;

    function GetMember(aIndex: Integer): IwbValueDef;
    function GetMemberCount: Integer;

    property Members[aIndex: Integer]: IwbValueDef read GetMember;
    property MemberCount: Integer read GetMemberCount;
  end;

  IwbStringDef = interface(IwbValueDef)
    ['{37B02D28-EDB4-41C6-B933-9F56C013A88A}']
    function GetStringSize: Integer;

    property StringSize: Integer
      read GetStringSize;
  end;

  IwbLenStringDef = interface(IwbValueDef)
    ['{1AD7FAE2-DAA7-4651-B78D-10E138EDF48B}']
  end;

  IwbByteArrayDef = interface(IwbValueDef)
    ['{3069E1AC-4307-421B-93E4-797E18075EF9}']
  end;

  IwbEmptyDef = interface(IwbValueDef)
    ['{0A858744-947B-4B6E-9972-D8BF5398C87C}']
    function GetSorted: Boolean;

    property Sorted: Boolean
      read GetSorted;
  end;

  IwbIntegerDefFormater = interface;

  IwbIntegerDef = interface(IwbValueDef)
    ['{00A270B0-ACFC-444C-A7E8-A577BD40704E}']
    function ToInt(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Int64;
    procedure FromInt(aValue: Int64; aBasePtr, aEndPtr: Pointer; const aElement: IwbElement);

    function GetFormater: IwbIntegerDefFormater;
    function GetIntType: TwbIntType;

    property Formater: IwbIntegerDefFormater
      read GetFormater;
    property IntType: TwbIntType
      read GetIntType;
  end;

  IwbFloatDef = interface(IwbValueDef)
    ['{29F116C6-0208-4D55-ACA7-2A9BB17BF80B}']
  end;

  IwbArrayDef = interface(IwbValueDef)
    ['{BD195F99-4AC3-4BD0-9193-267332E97D79}']
    function GetElement: IwbValueDef;
    function GetCount: Integer;
    function GetElementLabel(aIndex: Integer): string;
    function GetSorted: Boolean;

    property Element: IwbValueDef
      read GetElement;
    property ElementCount: Integer
      read GetCount;

    property ElementLabel[aIndex: Integer]: string
      read GetElementLabel;

    property Sorted: Boolean
      read GetSorted;
  end;

  IwbStructDef = interface(IwbValueDef)
    ['{9B20A03C-BC3F-433A-9781-E46BD5C660A9}']

    function GetMember(aIndex: Integer): IwbValueDef;
    function GetMemberCount: Integer;
    function GetOptionalFromElement: Integer;

    property Members[aIndex: Integer]: IwbValueDef read GetMember;
    property MemberCount: Integer read GetMemberCount;
    property OptionalFromElement: Integer read GetOptionalFromElement;
  end;

  IwbIntegerDefFormater = interface(IwbDef)
    ['{56A6EB7B-3A90-4F09-8E80-D7399569DFCC}']

    function ToString(aInt: Int64; const aElement: IwbElement): string;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string;
    function Check(aInt: Int64; const aElement: IwbElement): string;
    procedure BuildRef(aInt: Int64; const aElement: IwbElement);

    function GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType;
    function GetEditInfo(aInt: Int64; const aElement: IwbElement): string;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
    function GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement;

    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;

    function MasterCountUpdated(aInt: Int64; aOld, aNew: Byte): Int64;
    function MasterIndicesUpdated(aInt: Int64; const aOld, aNew: TBytes): Int64;
    procedure FindUsedMasters(aInt: Int64; aMasters: PwbUsedMasters);
    function CompareExchangeFormID(var aInt: Int64; aOldFormID: Cardinal; aNewFormID: Cardinal; const aElement: IwbElement): Boolean;

    property IsEditable[aInt: Int64; const aElement: IwbElement]: Boolean
      read GetIsEditable;
    property LinksTo[aInt: Int64; const aElement: IwbElement]: IwbElement
      read GetLinksTo;

    property EditType[aInt: Int64; const aElement: IwbElement]: TwbEditType
      read GetEditType;
    property EditInfo[aInt: Int64; const aElement: IwbElement]: string
      read GetEditInfo;
  end;

  IwbFormID = interface(IwbIntegerDefFormater)
    ['{71C4A255-B983-488C-9837-0A720132348A}']
  end;

  IwbFormIDChecked = interface(IwbFormID)
    ['{DC7CBC9F-07EC-430B-94EE-ECE1867A2660}']
    function GetSignature(aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;

    property Signatures[aIndex: Integer]: TwbSignature
      read GetSignature;
    property SignatureCount: Integer
      read GetSignatureCount;
  end;

  IwbChar4 = interface(IwbIntegerDefFormater)
    ['{CF657B3A-E7A6-48FE-AC68-8DF15962A531}']
  end;

  IwbFlagsDef = interface(IwbIntegerDefFormater)
    ['{EF564466-A671-453A-88CF-42A0AA32D849}']
    function GetFlag(aIndex: Integer): string;
    function GetFlagCount: Integer;
    function GetFlagDontShow(const aElement: IwbElement; aIndex: Integer): Boolean;
    function GetFlagHasDontShow(aIndex: Integer): Boolean;

    property Flags[aIndex: Integer] : string
      read GetFlag;
    property FlagCount: Integer
      read GetFlagCount;

    property FlagDontShow[const aElement: IwbElement; aIndex: Integer]: Boolean
      read GetFlagDontShow;
    property FlagHasDontShow[aIndex: Integer]: Boolean
      read GetFlagHasDontShow;
  end;

  IwbEnumDef = interface(IwbIntegerDefFormater)
    ['{A3AFE02E-F72D-4E0E-BC56-219F7EE2B564}']

    function GetName(aIndex: Integer): string;
    function GetNameCount: Integer;

    property Names[aIndex: Integer]: string
      read GetName;
    property NameCount: Integer
      read GetNameCount;
  end;

  IwbCallbackDef = interface(IwbIntegerDefFormater)
    ['{BF6A0830-F981-4E0A-B4F2-2A09D575CD19}']
    function GetCallback: TwbIntToStrCallback;

    property Callback: TwbIntToStrCallback
      read GetCallback;
  end;

  IwbResourceContainer = interface;

  IwbResource = interface(IInterface)
    ['{B626E8BF-D2E3-40D1-8F3A-E6001D76B97B}']
    function GetContainer: IwbResourceContainer;
    function GetData: TBytes;

    property Container: IwbResourceContainer
      read GetContainer;
  end;

  IwbResourceContainer = interface(IInterface)
    ['{023EA9C4-19B5-4587-B298-559EEF8F224E}']
    function OpenResource(const aFileName: string): IwbResource;
    procedure ResolveHash(const aHash: Int64; var Results: TDynStrings);
  end;

  IwbFolder = interface(IwbResourceContainer)
    ['{E71981ED-3C0C-4334-8476-116AEB0EEA1E}']
    function GetPathName: string;

    property PathName: string
      read GetPathName;
  end;

  IwbBSAFile = interface(IwbResourceContainer)
    ['{DC987017-9F5C-42D2-BAD2-E1A622E99081}']
    function GetFileName: string;

    property FileName: string
      read GetFileName;
  end;

  TDynResources = array of IwbResource;

  IwbContainerHandler = interface(IInterface)
    ['{0CC80043-EADC-4C7D-8677-8719735582C7}']
    procedure AddFolder(const aPath: string);
    procedure AddBSA(const aFileName: string);

    function OpenResource(const aFileName: string): TDynResources;
    function ResolveHash(const aHash: Int64): TDynStrings;
  end;

function wbRecord(const aSignature      : TwbSignature;
                  const aName           : string;
                  const aMembers        : array of IwbRecordMemberDef;
                        aAllowUnordered : Boolean = False;
                        aAddInfoCallback: TwbAddInfoCallback = nil;
                        aPriority       : TwbConflictPriority = cpNormal;
                        aRequired       : Boolean = False;
                        aAfterLoad      : TwbAfterLoadCallback = nil;
                        aAfterSet       : TwbAfterSetCallback = nil)
                                        : IwbRecordDef;

function wbSubRecord(const aSignature : TwbSignature;
                     const aName      : string;
                     const aValue     : IwbValueDef;
                           aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aSizeMatch : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;

function wbSubRecord(const aSignatures : array of TwbSignature;
                     const aName       : string;
                     const aValue      : IwbValueDef;
                           aAfterLoad  : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                           aPriority   : TwbConflictPriority = cpNormal;
                           aRequired   : Boolean = False;
                           aSizeMatch  : Boolean = False;
                           aDontShow   : TwbDontShowCallback = nil)
                                       : IwbSubRecordDef; overload;

function wbString(const aSignature : TwbSignature;
                  const aName      : string = 'Unknown';
                        aSize      : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbSubRecordDef; overload;

function wbString(const aName      : string = 'Unknown';
                        aSize      : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbStringDef; overload;

function wbStringScript(const aSignature : TwbSignature;
                        const aName      : string;
                              aSize      : Integer = 0;
                              aPriority  : TwbConflictPriority = cpNormal;
                              aRequired  : Boolean = False;
                              aDontShow  : TwbDontShowCallback = nil;
                              aAfterSet  : TwbAfterSetCallback = nil)
                                         : IwbSubRecordDef; overload;

function wbStringScript(const aName      : string;
                              aSize      : Integer = 0;
                              aPriority  : TwbConflictPriority = cpNormal;
                              aRequired  : Boolean = False;
                              aDontShow  : TwbDontShowCallback = nil;
                              aAfterSet  : TwbAfterSetCallback = nil)
                                         : IwbStringDef; overload;

function wbStringLC(const aSignature : TwbSignature;
                    const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbSubRecordDef; overload;

function wbStringLC(const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbStringDef; overload;

function wbLString(const aSignature : TwbSignature;
                    const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbSubRecordDef; overload;

function wbLString(const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbStringDef; overload;

function wbStringMgefCode(const aSignature : TwbSignature;
                          const aName      : string;
                                aSize      : Integer = 0;
                                aPriority  : TwbConflictPriority = cpNormal;
                                aRequired  : Boolean = False;
                                aDontShow  : TwbDontShowCallback = nil;
                                aAfterSet  : TwbAfterSetCallback = nil)
                                           : IwbSubRecordDef; overload;

function wbStringMgefCode(const aName      : string;
                                aSize      : Integer = 0;
                                aPriority  : TwbConflictPriority = cpNormal;
                                aRequired  : Boolean = False;
                                aDontShow  : TwbDontShowCallback = nil;
                                aAfterSet  : TwbAfterSetCallback = nil)
                                           : IwbStringDef; overload;

function wbLenString(const aSignature : TwbSignature;
                     const aName      : string;
                           aPrefix    : Integer = 4;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;

function wbLenString(const aName      : string;
                           aPrefix    : Integer = 4;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbLenStringDef; overload;

function wbUnion(const aSignature : TwbSignature;
                 const aName      : string;
                       aDecider   : TwbUnionDecider;
                 const aMembers   : array of IwbValueDef;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;

function wbUnion(const aName     : string;
                       aDecider  : TwbUnionDecider;
                 const aMembers  : array of IwbValueDef;
                       aPriority : TwbConflictPriority = cpNormal;
                       aRequired : Boolean = False;
                       aDontShow : TwbDontShowCallback = nil)
                                 : IwbUnionDef; overload;


function wbByteArray(const aSignature : TwbSignature;
                     const aName      : string = 'Unknown';
                           aSize      : Cardinal = 0;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aSizeMatch : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;

function wbByteArray(const aName      : string = 'Unknown';
                           aSize      : Cardinal = 0;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbByteArrayDef; overload;

function wbUnknown(const aSignature : TwbSignature;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aDontShow  : TwbDontShowCallback = nil)
                                    : IwbSubRecordDef; overload;

function wbUnknown(aPriority : TwbConflictPriority = cpNormal;
                   aRequired : Boolean = False;
                   aDontShow : TwbDontShowCallback = nil)
                             : IwbByteArrayDef; overload;

function wbInteger(const aSignature : TwbSignature;
                   const aName      : string;
                   const aIntType   : TwbIntType;
                   const aFormater  : IwbIntegerDefFormater = nil;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aMatchSize : Boolean = False;
                         aDontShow  : TwbDontShowCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil;
                         aDefault   : Int64 = 0)
                                    : IwbSubRecordDef; overload;

function wbInteger(const aName     : string;
                   const aIntType  : TwbIntType;
                   const aFormater : IwbIntegerDefFormater = nil;
                         aPriority : TwbConflictPriority = cpNormal;
                         aRequired : Boolean = False;
                         aDontShow : TwbDontShowCallback = nil;
                         aAfterSet : TwbAfterSetCallback = nil;
                         aDefault  : Int64= 0)
                                   : IwbIntegerDef; overload;

function wbInteger(const aSignature : TwbSignature;
                   const aName      : string;
                   const aIntType   : TwbIntType;
                   const aToStr     : TwbIntToStrCallback;
                   const aToInt     : TwbStrToIntCallback = nil;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aDontShow  : TwbDontShowCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil;
                         aDefault   : Int64 = 0)
                                    : IwbSubRecordDef; overload;

function wbInteger(const aName     : string;
                   const aIntType  : TwbIntType;
                   const aToStr    : TwbIntToStrCallback;
                   const aToInt    : TwbStrToIntCallback = nil;
                         aPriority : TwbConflictPriority = cpNormal;
                         aRequired : Boolean = False;
                         aDontShow : TwbDontShowCallback = nil;
                         aAfterSet : TwbAfterSetCallback = nil;
                         aDefault  : Int64 = 0)
                                   : IwbIntegerDef; overload;


function wbFloat(const aSignature  : TwbSignature;
                 const aName       : string = 'Unknown';
                       aPriority   : TwbConflictPriority = cpNormal;
                       aRequired   : Boolean = False;
                       aScale      : Extended = 1.0;
                       aDigits     : Integer = -1;
                       aDontShow   : TwbDontShowCallback = nil;
                       aNormalizer : TwbFloatNormalizer = nil;
                       aDefault    : Extended = 0.0)
                                   : IwbSubRecordDef; overload;

function wbFloat(const aName       : string = 'Unknown';
                       aPriority   : TwbConflictPriority = cpNormal;
                       aRequired   : Boolean = False;
                       aScale      : Extended = 1.0;
                       aDigits     : Integer = -1;
                       aDontShow   : TwbDontShowCallback = nil;
                       aNormalizer : TwbFloatNormalizer = nil;
                       aDefault    : Extended = 0.0)
                                   : IwbFloatDef; overload;

{--- wbArray - list of identical elements -------------------------------------}
function wbArray(const aSignature : TwbSignature;
                 const aName      : string;
                 const aElement   : IwbValueDef;
                       aCount     : Integer = 0;
                       aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;

function wbArray(const aName     : string;
                 const aElement  : IwbValueDef;
                       aCount    : Integer = 0;
                       aPriority : TwbConflictPriority = cpNormal;
                       aRequired : Boolean = False;
                       aDontShow : TwbDontShowCallback = nil)
                                 : IwbArrayDef; overload;

function wbArray(const aSignature : TwbSignature;
                 const aName      : string;
                 const aElement   : IwbValueDef;
                 const aLabels    : array of string;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;

function wbArray(const aSignature     : TwbSignature;
                 const aName          : string;
                 const aElement       : IwbValueDef;
                 const aLabels        : array of string;
                       aCountCallback : TwbCountCallback;
                       aPriority      : TwbConflictPriority = cpNormal;
                       aRequired      : Boolean = False;
                       aDontShow      : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;

function wbArray(const aName     : string;
                 const aElement  : IwbValueDef;
                 const aLabels   : array of string;
                       aPriority : TwbConflictPriority = cpNormal;
                       aRequired : Boolean = False;
                       aDontShow : TwbDontShowCallback = nil)
                                 : IwbArrayDef; overload;

function wbArray(const aName          : string;
                 const aElement       : IwbValueDef;
                 const aLabels        : array of string;
                       aCountCallback : TwbCountCallback;
                       aPriority      : TwbConflictPriority = cpNormal;
                       aRequired      : Boolean = False;
                       aDontShow      : TwbDontShowCallback = nil)
                                      : IwbArrayDef; overload;

function wbRArray(const aName     : string;
                  const aElement  : IwbRecordMemberDef;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil)
                                  : IwbSubRecordArrayDef; overload;

function wbArrayS(const aSignature : TwbSignature;
                  const aName      : string;
                  const aElement   : IwbValueDef;
                        aCount     : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbSubRecordDef; overload;

function wbArrayS(const aName      : string;
                  const aElement   : IwbValueDef;
                        aCount     : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbArrayDef; overload;

function wbArrayS(const aName          : string;
                  const aElement       : IwbValueDef;
                        aCountCallback : TwbCountCallback;
                        aPriority      : TwbConflictPriority = cpNormal;
                        aRequired      : Boolean = False;
                        aAfterLoad     : TwbAfterLoadCallback = nil;
                        aAfterSet      : TwbAfterSetCallback = nil;
                        aDontShow      : TwbDontShowCallback = nil)
                                       : IwbArrayDef; overload;

function wbArrayS(const aSignature : TwbSignature;
                  const aName      : string;
                  const aElement   : IwbValueDef;
                  const aLabels    : array of string;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbSubRecordDef; overload;

function wbArrayS(const aName      : string;
                  const aElement   : IwbValueDef;
                  const aLabels    : array of string;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbArrayDef; overload;


function wbRArrayS(const aName      : string;
                   const aElement   : IwbRecordMemberDef;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil;
                         aDontShow  : TwbDontShowCallback = nil;
                         aIsSorted  : TwbIsSortedCallback = nil)
                                    : IwbSubRecordArrayDef; overload;


{--- wbStruct - ordered list of members ----------------------------------------}
function wbStructSK(const aSortKey             : array of Integer;
                    const aName                : string;
                    const aMembers             : array of IwbValueDef;
                          aPriority            : TwbConflictPriority = cpNormal;
                          aRequired            : Boolean = False;
                          aDontShow            : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                          aAfterLoad : TwbAfterLoadCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                               : IwbStructDef; overload;

function wbStructSK(const aSignature : TwbSignature;
                    const aSortKey   : array of Integer;
                    const aName      : string;
                    const aMembers   : array of IwbValueDef;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                          aAfterLoad : TwbAfterLoadCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbSubRecordDef; overload;

function wbMultiStructSK(const aSignatures : array of TwbSignature;
                         const aSortKey    : array of Integer;
                         const aName       : string;
                         const aMembers    : array of IwbValueDef;
                               aPriority   : TwbConflictPriority = cpNormal;
                               aRequired   : Boolean = False;
                               aDontShow   : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                           : IwbSubRecordDef;

function wbStructExSK(const aSortKey   : array of Integer;
                      const aExSortKey : array of Integer;
                      const aName      : string;
                      const aMembers   : array of IwbValueDef;
                            aPriority  : TwbConflictPriority = cpNormal;
                            aRequired  : Boolean = False;
                            aDontShow  : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                       : IwbStructDef; overload;

function wbStructExSK(const aSignature : TwbSignature;
                      const aSortKey   : array of Integer;
                      const aExSortKey : array of Integer;
                      const aName      : string;
                      const aMembers   : array of IwbValueDef;
                            aPriority  : TwbConflictPriority = cpNormal;
                            aRequired  : Boolean = False;
                            aDontShow  : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                       : IwbSubRecordDef; overload;

function wbStruct(const aSignature : TwbSignature;
                  const aName      : string;
                  const aMembers   : array of IwbValueDef;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aOptionalFromElement : Integer = -1;
                        aAfterLoad : TwbAfterLoadCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbSubRecordDef; overload;

function wbStruct(const aName      : string;
                  const aMembers   : array of IwbValueDef;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aOptionalFromElement : Integer = -1;
                        aAfterLoad : TwbAfterLoadCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbStructDef; overload;

function wbRStruct(const aName           : string;
                   const aMembers        : array of IwbRecordMemberDef;
                   const aSkipSigs       : array of TwbSignature;
                         aPriority       : TwbConflictPriority = cpNormal;
                         aRequired       : Boolean = False;
                         aDontShow       : TwbDontShowCallback = nil;
                         aAllowUnordered : Boolean = False;
                         aAfterLoad      : TwbAfterLoadCallback = nil;
                         aAfterSet       : TwbAfterSetCallback = nil)
                                         : IwbSubRecordStructDef; overload;

function wbRStructSK(const aSortKey        : array of Integer;
                     const aName           : string;
                     const aMembers        : array of IwbRecordMemberDef;
                     const aSkipSigs       : array of TwbSignature;
                           aPriority       : TwbConflictPriority = cpNormal;
                           aRequired       : Boolean = False;
                           aDontShow       : TwbDontShowCallback = nil;
                           aAllowUnordered : Boolean = False;
                           aAfterLoad      : TwbAfterLoadCallback = nil;
                           aAfterSet       : TwbAfterSetCallback = nil)
                                           : IwbSubRecordStructDef; overload;

function wbRStructExSK(const aSortKey        : array of Integer;
                       const aExSortKey      : array of Integer;
                       const aName           : string;
                       const aMembers        : array of IwbRecordMemberDef;
                       const aSkipSigs       : array of TwbSignature;
                             aPriority       : TwbConflictPriority = cpNormal;
                             aRequired       : Boolean = False;
                             aDontShow       : TwbDontShowCallback = nil;
                             aAllowUnordered : Boolean = False;
                             aAfterLoad      : TwbAfterLoadCallback = nil;
                             aAfterSet       : TwbAfterSetCallback = nil)
                                             : IwbSubRecordStructDef; overload;

function wbRUnion(const aName     : string;
                  const aMembers  : array of IwbRecordMemberDef;
                  const aSkipSigs : array of TwbSignature;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil)
                                  : IwbSubRecordUnionDef;

{--- wbStructs - array of struct ----------------------------------------------}
function wbStructs(const aSignature   : TwbSignature;
                   const aName        : string;
                   const aElementName : string;
                   const aMembers     : array of IwbValueDef;
                         aPriority    : TwbConflictPriority = cpNormal;
                         aRequired    : Boolean = False;
                         aDontShow    : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;

function wbStructs(const aName        : string;
                   const aElementName : string;
                   const aMembers     : array of IwbValueDef;
                         aPriority    : TwbConflictPriority = cpNormal;
                         aRequired    : Boolean = False;
                         aDontShow    : TwbDontShowCallback = nil)
                                      : IwbArrayDef; overload;

function wbRStructs(const aName        : string;
                    const aElementName : string;
                    const aMembers     : array of IwbRecordMemberDef;
                    const aSkipSigs    : array of TwbSignature;
                          aPriority    : TwbConflictPriority = cpNormal;
                          aRequired    : Boolean = False;
                          aDontShow    : TwbDontShowCallback = nil)
                                       : IwbSubRecordArrayDef; overload;

function wbRStructsSK(const aName        : string;
                      const aElementName : string;
                      const aSortKey     : array of Integer;
                      const aMembers     : array of IwbRecordMemberDef;
                      const aSkipSigs    : array of TwbSignature;
                            aPriority    : TwbConflictPriority = cpNormal;
                            aRequired    : Boolean = False;
                            aAfterLoad   : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                            aDontShow    : TwbDontShowCallback = nil)
                                         : IwbSubRecordArrayDef; overload;

function wbEmpty(const aSignature : TwbSignature;
                 const aName      : string;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;

function wbEmpty(const aName      : string;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil;
                       aSorted    : Boolean = False)
                                  : IwbValueDef; overload;

function wbFormID: IwbFormID; overload;

function wbFormID(const aValidRefs : array of TwbSignature;
                        aPersistent: Boolean)
                                   : IwbFormID; overload;

function wbFormIDNoReach(const aValidRefs  : array of TwbSignature;
                               aPersistent : Boolean)
                                           : IwbFormID; overload;

function wbFormID(const aValidRefs     : array of TwbSignature;
                  const aValidFlstRefs : array of TwbSignature;
                        aPersistent    : Boolean)
                                       : IwbFormID; overload;

function wbFormIDNoReach(const aValidRefs     : array of TwbSignature;
                         const aValidFlstRefs : array of TwbSignature;
                               aPersistent    : Boolean)
                                              : IwbFormID; overload;

function wbFormID(const aSignature : TwbSignature;
                  const aName      : string = 'Unknown';
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbSubRecordDef; overload;

function wbFormID(const aName      : string;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbIntegerDef; overload;

function wbFormIDCk(const aSignature : TwbSignature;
                    const aName      : string;
                    const aValidRefs : array of TwbSignature;
                          aPersistent: Boolean = False;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil)
                                     : IwbSubRecordDef; overload;

function wbFormIDCkNoReach(const aSignature : TwbSignature;
                           const aName      : string;
                           const aValidRefs : array of TwbSignature;
                                 aPersistent: Boolean = False;
                                 aPriority  : TwbConflictPriority = cpNormal;
                                 aRequired  : Boolean = False;
                                 aDontShow  : TwbDontShowCallback = nil)
                                            : IwbSubRecordDef; overload;

function wbFormIDCk(const aName      : string;
                    const aValidRefs : array of TwbSignature;
                          aPersistent: Boolean = False;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil)
                                     : IwbIntegerDef; overload;

function wbFormIDCkNoReach(const aName      : string;
                           const aValidRefs : array of TwbSignature;
                                 aPersistent: Boolean = False;
                                 aPriority  : TwbConflictPriority = cpNormal;
                                 aRequired  : Boolean = False;
                                 aDontShow  : TwbDontShowCallback = nil)
                                            : IwbIntegerDef; overload;

function wbFormIDCk(const aSignature     : TwbSignature;
                    const aName          : string;
                    const aValidRefs     : array of TwbSignature;
                    const aValidFlstRefs : array of TwbSignature;
                          aPersistent    : Boolean = False;
                          aPriority      : TwbConflictPriority = cpNormal;
                          aRequired      : Boolean = False;
                          aDontShow      : TwbDontShowCallback = nil)
                                         : IwbSubRecordDef; overload;

function wbFormIDCk(const aName          : string;
                    const aValidRefs     : array of TwbSignature;
                    const aValidFlstRefs : array of TwbSignature;
                          aPersistent    : Boolean = False;
                          aPriority      : TwbConflictPriority = cpNormal;
                          aRequired      : Boolean = False;
                          aDontShow      : TwbDontShowCallback = nil)
                                         : IwbIntegerDef; overload;

function wbFormIDCkNoReach(const aName          : string;
                           const aValidRefs     : array of TwbSignature;
                           const aValidFlstRefs : array of TwbSignature;
                                 aPersistent    : Boolean = False;
                                 aPriority      : TwbConflictPriority = cpNormal;
                                 aRequired      : Boolean = False;
                                 aDontShow      : TwbDontShowCallback = nil)
                                                : IwbIntegerDef; overload;

function wbChar4: IwbChar4;

function wbFlags(const aNames           : array of string;
                       aUnknownIsUnused : Boolean = False)
                                        : IwbFlagsDef; overload;
function wbFlags(const aNames           : array of string;
                 const aDontShows       : array of TwbDontShowCallback;
                       aUnknownIsUnused : Boolean = False)
                                        : IwbFlagsDef; overload;
function wbEnum(const aNames : array of string)
                             : IwbEnumDef; overload;
function wbEnum(const aNames       : array of string;
                const aSparseNames : array of const)
                                   : IwbEnumDef; overload;


function wbDiv(aValue : Integer)
                      : IwbIntegerDefFormater;
function wbMul(aValue : Integer)
                      : IwbIntegerDefFormater;
function wbCallback(const aToStr : TwbIntToStrCallback;
                    const aToInt : TwbStrToIntCallback)
                                 : IwbIntegerDefFormater;


var
  wbRecordDefs       : array of IwbRecordDef;
  wbRecordDefMap     : TStringList;
  wbIgnoreRecords    : TStringList;
  wbGroupOrder       : TStringList;
  wbLoadBSAs         : Boolean{} = True{};
  wbBuildRefs        : Boolean{} = True{};
  wbContainerHandler : IwbContainerHandler;
  wbLoaderDone       : Boolean;
  wbLoaderError      : Boolean;

procedure wbAddGroupOrder(const aSignature: TwbSignature);
function wbGetGroupOrder(const aSignature: TwbSignature): Integer;

function IntToHex64(Value: Int64; Digits: Integer): string; inline;
procedure QuickSort(SortList: PwbPointerArray; L, R: Integer;
  SCompare: TListSortCompare);
function CmpI32(a, b : Integer) : Integer;
function CmpW32(a, b: Cardinal): Integer;
function CmpI64(const a, b : Int64) : Integer;
function CompareElementsFormIDAndLoadOrder(Item1, Item2: Pointer): Integer;

function ConflictAllToColor(aConflictAll: TConflictAll): TColor;
function ConflictThisToColor(aConflictThis: TConflictThis): TColor;

var
  wbGetFormIDCallback : function(const aElement: IwbElement): Cardinal;

function wbGetFormID(const aElement: IwbElement): Cardinal;
function wbPositionToGridCell(const aPosition: TD3DXVector3): TwbGridCell;
function wbSubBlockFromGridCell(const aGridCell: TwbGridCell): TwbGridCell;
function wbBlockFromSubBlock(const aSubBlock: TwbGridCell): TwbGridCell;
function wbGridCellToGroupLabel(const aGridCell: TwbGridCell): Cardinal;
function wbIsInGridCell(const aPosition: TD3DXVector3; const aGridCell: TwbGridCell): Boolean;

var
  wbRecordFlags            : IwbIntegerDef;
  wbMainRecordHeader       : IwbStructDef;
  wbSizeOfMainRecordStruct : Integer;

type
  TwbGameMode = (gmFNV, gmFO3, gmTES3, gmTES4, gmTES5);

var
  wbGameMode : TwbGameMode;
  wbAppName  : string;
  wbGameName : string;

function wbDefToName(const aDef: IwbDef): string;
function wbDefsToPath(const aDefs: TwbDefPath): string;

procedure ReportDefs;

type
  IwbProgress = interface
    ['{054006B0-096D-43CD-A92A-3095B525C854}']

    procedure UpdateStatus(aPosition: Integer; const aStatus: string);
  end;

  IwbWaitForm = interface
    ['{185C220C-3135-4A8A-8E0E-8001759F3C85}']
    function GetIsCanceled: Boolean;

    function CreateProgress(const aCaption : string;
                            const aStatus  : string;
                                  aMax     : Integer)
                                           : IwbProgress;

    property IsCanceled: Boolean
      read GetIsCanceled;
  end;

  TwbCreateWaitForm = function(const aCaption     : string;
                               const aMessage     : string;
                                     aCanCancel   : Boolean;
                                     aShowDelay   : Integer = 0;
                                     aUpdateDelay : Integer = 0)
                                                  : IwbWaitForm;

function NullCreateWaitForm(const aCaption     : string;
                            const aMessage     : string;
                                  aCanCancel   : Boolean;
                                  aShowDelay   : Integer = 0;
                                  aUpdateDelay : Integer = 0)
                                               : IwbWaitForm;

var
  wbCreateWaitForm : TwbCreateWaitForm = NullCreateWaitForm;

type
  TwbFastStringList = class(TStringList)
  protected
    function CompareStrings(const S1, S2: string): Integer; override;
  public
    constructor CreateSorted(aDups : TDuplicates = dupError);

    procedure Clear(aFreeObjects: Boolean = False); reintroduce;
  end;

  TwbFastStringListCS = class(TwbFastStringList)
  public
    procedure AfterConstruction; override;
  end;

  TwbFastStringListIC = class(TwbFastStringList)
  end;

function RadiansNormalize(const aElement: IwbElement; aFloat: Extended): Extended;

function wbBeginInternalEdit(aForce: Boolean = False): Boolean;
procedure wbEndInternalEdit;
function wbIsInternalEdit: Boolean;

function StrToSignature(const s: string): TwbSignature;

function FixupFormID(aFormID: Cardinal; const aOld, aNew: TBytes): Cardinal;

threadvar
  _InternalEditCount: Integer;
  _BlockInternalEdit: Boolean;

var
  wbActorValueEnum: IwbEnumDef;

implementation

uses
  Windows,
  Variants,
  Math,
  AnsiStrings,
  TypInfo,
  wbLocalization;

function StrToSignature(const s: string): TwbSignature;
var
  t: AnsiString;
begin
  t := s;
  if Length(t) >= 4 then
    Result := PwbSignature(@t[1])^
  else
    raise Exception.Create('"'+t+'" is not a valid signature');
end;

function wbBeginInternalEdit(aForce: Boolean): Boolean;
begin
  Result := (wbAllowInternalEdit or aForce) and not _BlockInternalEdit;
  if Result then
    Inc(_InternalEditCount);
end;

procedure wbEndInternalEdit;
begin
  Dec(_InternalEditCount);
end;

function wbIsInternalEdit: Boolean;
begin
  Result := _InternalEditCount > 0;
end;


var
  OnePi : Single = 3.1415927;//(2!) 653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067;
  TwoPi : Extended;

function RoundToEx(const AValue: Extended; const ADigit: TRoundToRange): Extended;
var
  LFactor: Extended;
begin
  LFactor := IntPower(10, ADigit);
  Result := Round(AValue / LFactor) * LFactor;
end;

function DoSingleSameValue(const A, B: Single): Boolean;
const
  SingleResolution : Single = 0.00000499999999999999999999;
begin
  Result := Abs(A - B) <= Max(Min(Abs(A), Abs(B)) * SingleResolution, SingleResolution)
end;

function SingleSameValue(const A, B: Extended): Boolean;
var
  sA, sB: Single;
begin
  sA := A;
  sB := B;
  Result := DoSingleSameValue(sA, sB);
end;

function RadiansNormalize(const aElement: IwbElement; aFloat: Extended): Extended;
begin
//  Result := RoundToEx(aFloat, -6);
  Result := aFloat;

  while Result < 0.0 do
    Result := Result + TwoPi;
  while Result > TwoPi do
    Result := Result - TwoPi;
  if SingleSameValue(Result, 0.0) or (Result < 0.0) then
    Result := 0.0;
  if SingleSameValue(Result, TwoPi) or (Result > TwoPi) then
    Result := 0.0;

//  Result := RoundToEx(Result, -6);
end;

type
  TwbNullWaitForm = class(TInterfacedObject, IwbWaitForm)
  protected
    {--- IwbWaitForm ---}
    function GetIsCanceled: Boolean;

    function CreateProgress(const aCaption : string;
                            const aStatus  : string;
                                  aMax     : Integer)
                                           : IwbProgress;
  end;

  TwbNullProgress = class(TInterfacedObject, IwbProgress)
  protected
    {--- IwbProgress ---}
    procedure UpdateStatus(aPosition: Integer; const aStatus: string);
  end;

{ TwbNullWaitForm }

function TwbNullWaitForm.CreateProgress(const aCaption, aStatus: string; aMax: Integer): IwbProgress;
begin
  Result := TwbNullProgress.Create;
end;

function TwbNullWaitForm.GetIsCanceled: Boolean;
begin
  Result := False;
end;

{ TwbNullProgress }

procedure TwbNullProgress.UpdateStatus(aPosition: Integer; const aStatus: string);
begin
end;

function NullCreateWaitForm(const aCaption     : string;
                            const aMessage     : string;
                                  aCanCancel   : Boolean;
                                  aShowDelay   : Integer = 0;
                                  aUpdateDelay : Integer = 0)
                                               : IwbWaitForm;
begin
  Result := TwbNullWaitForm.Create;
end;

procedure ReportDefs;
var
  i: Integer;
begin
  for i:= Low(wbRecordDefs) to High(wbRecordDefs) do
    wbRecordDefs[i].Report(nil);
end;

function wbDefToName(const aDef: IwbDef): string;
var
  SignatureDef : IwbSignatureDef;
  NamedDef     : IwbNamedDef;
begin
  if Supports(aDef, IwbSignatureDef, SignatureDef) then begin
    Result := SignatureDef.DefaultSignature + ' - ' + SignatureDef.Name;
  end else if Supports(aDef, IwbNamedDef, NamedDef) then begin
    Result := NamedDef.Name;
  end else if Assigned(aDef) then begin
    Result := '<'+GetEnumName(TypeInfo(TwbDefType), Ord(aDef.DefType))+'>';
  end else
    Result := '<nil>';
end;

function wbDefsToPath(const aDefs: TwbDefPath): string;
var
  i: Integer;
begin
  Result := '';
  for i := Low(aDefs) to High(aDefs) do begin
    Result := Result + wbDefToName(aDefs[i].Def) + ' \ ';
    if aDefs[i].Index >= 0 then
      Result := Result + '['+IntToStr(aDefs[i].Index)+'] ';
  end;
end;
function wbIsInGridCell(const aPosition: TD3DXVector3; const aGridCell: TwbGridCell): Boolean;
var
  GridCell : TwbGridCell;
begin
  GridCell := wbPositionToGridCell(aPosition);
  Result := (GridCell.x = aGridCell.x) and (GridCell.y = aGridCell.y);
end;

function wbPositionToGridCell(const aPosition: TD3DXVector3): TwbGridCell;
begin
  Result.x := Trunc(aPosition.x / 4096);
  if aPosition.x < 0 then
    Dec(Result.x);
  Result.y := Trunc(aPosition.y / 4096);
  if aPosition.y < 0 then
    Dec(Result.y);
end;

function wbSubBlockFromGridCell(const aGridCell: TwbGridCell): TwbGridCell;
begin
  Result.x := aGridCell.x div 8;
  if (aGridCell.x < 0) and ((aGridCell.x mod 8) <> 0) then
    Dec(Result.x);
  Result.y := aGridCell.y div 8;
  if (aGridCell.y < 0) and ((aGridCell.y mod 8) <> 0) then
    Dec(Result.y);
end;

function wbBlockFromSubBlock(const aSubBlock: TwbGridCell): TwbGridCell;
begin
  Result.x := aSubBlock.x div 4;
  if (aSubBlock.x < 0) and ((aSubBlock.x mod 4) <> 0) then
    Dec(Result.x);
  Result.y := aSubBlock.y div 4;
  if (aSubBlock.y < 0) and ((aSubBlock.y mod 4) <> 0) then
    Dec(Result.y);
end;

function wbGridCellToGroupLabel(const aGridCell: TwbGridCell): Cardinal;
var
  x, y: Smallint;
  xx,yy: Word;
begin
  x := aGridCell.x;
  y := aGridCell.y;
  xx := PWord(@x)^;
  yy := PWord(@y)^;
  Result := Cardinal(yy) or (Cardinal(xx) shl 16);
end;

function wbGetFormID(const aElement: IwbElement): Cardinal;
begin
  if Assigned(wbGetFormIDCallback) then
    Result := wbGetFormIDCallback(aElement)
  else
    Result := 0;
end;

function ConflictAllToColor(aConflictAll: TConflictAll): TColor;
begin
  Result := clDefault;
end;

function ConflictThisToColor(aConflictThis: TConflictThis): TColor;
begin
  case aConflictThis of
    ctMaster:
      Result := clPurple;
    ctIdenticalToMaster:
      Result := clDkGray;
    ctNotDefined:
      Result := clMedGray;
    ctHiddenByModGroup:
      Result := clLtGray;
    ctOverride:
      Result := clGreen;
    ctConflictWins:
      Result := clOrange;
    ctIdenticalToMasterWinsConflict:
      Result := clOlive;
    ctConflictLoses:
      Result := clRed;
  else
    //Result := clBlack;
    Result := clWindowText;
  end;
end;


procedure wbAddGroupOrder(const aSignature: TwbSignature);
begin
  if not Assigned(wbGroupOrder) then
    wbGroupOrder := TwbFastStringListCS.CreateSorted;
  wbGroupOrder.AddObject(aSignature, Pointer(wbGroupOrder.Count));
end;

function wbGetGroupOrder(const aSignature: TwbSignature): Integer;
begin
  if Assigned(wbGroupOrder) then begin
    Result := wbGroupOrder.IndexOf(aSignature);
    if Result >= 0 then
      Result := Integer(wbGroupOrder.Objects[Result]);
  end else
    Result := -1;
end;

function CompareElementsFormIDAndLoadOrder(Item1, Item2: Pointer): Integer;
var
  MainRecord1, MainRecord2: IwbMainRecord;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  MainRecord1 := IwbElement(Item1) as IwbMainRecord;
  MainRecord2 := IwbElement(Item2) as IwbMainRecord;

  Result := CmpW32(
    MainRecord1.LoadOrderFormID,
    MainRecord2.LoadOrderFormID);
  if Result = 0 then
    Result := CmpI32(
      MainRecord1._File.LoadOrder,
      MainRecord2._File.LoadOrder);
end;

procedure QuickSort(SortList: PwbPointerArray; L, R: Integer;
  SCompare: TListSortCompare);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := SortList^[(L + R) shr 1];
    repeat
      while SCompare(SortList^[I], P) < 0 do
        Inc(I);
      while SCompare(SortList^[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := SortList^[I];
        SortList^[I] := SortList^[J];
        SortList^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(SortList, L, J, SCompare);
    L := I;
  until I >= R;
end;

type
  TwbDef = class;

  IwbDefInternal = interface(IwbDef)
    ['{8EBA62A9-AF6B-4377-B52C-A1CEBF5B3ED6}']
    function SetParent(const aParent: TwbDef): IwbDef;
  end;

  TwbDefClass = class of TwbDef;
  TwbDef = class(TInterfacedObject, IwbDef, IwbDefInternal)
  private
    defRoot     : IwbDef;
    defParent   : TwbDef;

    defPriority : TwbConflictPriority;
    defRequired : Boolean;

    defUsed     : Boolean;
    defReported : Boolean;
    defPossiblyRequired : Boolean;
    defNotRequired : Boolean;

    IsUnknown        : Boolean;
    IsUnknownChecked : Boolean;
    UnknownValues    : TStringList;
  protected
    constructor Clone(const aSource: TwbDef); virtual;
    constructor Create(aPriority: TwbConflictPriority; aRequired: Boolean);

    {---IwbDef---}
    function GetDefType: TwbDefType; virtual; abstract;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; virtual;
    function GetDefID: Cardinal;
    function Equals(const aDef: IwbDef): Boolean; reintroduce; virtual;
    function GetConflictPriority: TwbConflictPriority;
    function GetRequired: Boolean;
    function CanContainFormIDs: Boolean; virtual;
    function GetDontShow(const aElement: IwbElement): Boolean; virtual;
    function GetHasDontShow: Boolean; virtual;
    function GetRoot: IwbDef;

    procedure Report(const aParents: TwbDefPath); virtual;
    procedure Used(const aElement: IwbElement; const s: string);
    procedure PossiblyRequired;
    procedure NotRequired;
    function IsNotRequired: Boolean;
    function GetNoReach: Boolean; virtual;

    {--- IwbDefInternal ---}
    function SetParent(const aParent: TwbDef): IwbDef; virtual;

    function Duplicate: TwbDef;
  end;

  TwbNamedDef = class(TwbDef, IwbNamedDef)
  private
    noName      : string;
    noAfterLoad : TwbAfterLoadCallback;
    noAfterSet  : TwbAfterSetCallback;
    noDontShow  : TwbDontShowCallback;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aName      : string;
                       aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback);

    {--- IwbDef ---}
    function GetDontShow(const aElement: IwbElement): Boolean; override;
    function GetHasDontShow: Boolean; override;

    {--- IwbDefInternal ---}
    function SetParent(const aParent: TwbDef): IwbDef; override;

    {---IwbNamedDef---}
    function GetName: string;
    procedure AfterLoad(const aElement: IwbElement); virtual;
    procedure AfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
  end;

  TwbSignatureDef = class(TwbNamedDef, IwbSignatureDef)
  private
    soSignatures : TwbSignatures;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aSignature : TwbSignature;
                 const aName      : string;
                       aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback); overload;
    constructor Create(aPriority   : TwbConflictPriority; aRequired: Boolean;
                 const aSignatures : array of TwbSignature;
                 const aName       : string;
                       aAfterLoad  : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow   : TwbDontShowCallback); overload;

    {---IwbSignatureDef---}
    function GetDefaultSignature: TwbSignature;

    function GetSignatures(const aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;

    function CanHandle(aSignature     : TwbSignature;
                 const aDataContainer : IwbDataContainer)
                                      : Boolean; virtual;
  end;

  TwbRecordDef = class(TwbSignatureDef, IwbRecordDef)
  private
    recMembers           : array of IwbRecordMemberDef;
    recSignatures        : TStringList;
    recAllowUnordered    : Boolean;
    recAddInfoCallback   : TwbAddInfoCallback;
    recCanContainFormIDs : Boolean;
    recQuickInitLimit    : Integer;
    recContainsEditorID  : Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aSignature : TwbSignature;
                 const aName      : string;
                 const aMembers   : array of IwbRecordMemberDef;
                       aAllowUnordered  : Boolean;
                       aAddInfoCallback : TwbAddInfoCallback;
                       aAfterLoad       : TwbAfterLoadCallback;
                       aAfterSet        : TwbAfterSetCallback);
    destructor Destroy; override;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbRecordDef---}
    function ContainsMemberFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Boolean;
    function GetMemberFor(aSignature     : TwbSignature;
                    const aDataContainer : IwbDataContainer)
                                         : IwbRecordMemberDef;
    function GetMemberIndexFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Integer;
    function AllowUnordered: Boolean;
    function AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;

    function GetMember(aIndex: Integer): IwbRecordMemberDef;
    function GetMemberCount: Integer;
    function CanContainFormIDs: Boolean; override;
    function GetSkipSignature(const aSignature: TwbSignature): Boolean; virtual;
    function GetQuickInitLimit: Integer;
    function GetContainsEditorID: Boolean;

    procedure AfterLoad(const aElement: IwbElement); override;
  end;

  TwbSubRecordDef = class(TwbSignatureDef, IwbRecordMemberDef, IwbSubRecordDef)
  private
    srValue     : IwbValueDef;
    srSizeMatch : Boolean;

    srHasUnusedData: Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aSignature : TwbSignature;
                 const aName      : string;
                 const aValue     : IwbValueDef;
                       aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aSizeMatch : Boolean;
                       aDontShow  : TwbDontShowCallback); overload;
    constructor Create(aPriority   : TwbConflictPriority; aRequired: Boolean;
                 const aSignatures : array of TwbSignature;
                 const aName       : string;
                 const aValue      : IwbValueDef;
                       aAfterLoad  : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aSizeMatch  : Boolean;
                       aDontShow   : TwbDontShowCallback); overload;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbSubRecordDef---}
    function GetValue: IwbValueDef;
    function CanContainFormIDs: Boolean; override;
    procedure HasUnusedData;
    function CanHandle(aSignature     : TwbSignature;
                 const aDataContainer : IwbDataContainer)
                                      : Boolean; override;
  end;

  TwbSubRecordArrayDef = class(TwbNamedDef, IwbRecordMemberDef, IwbSubRecordArrayDef)
  private
    sraElement  : IwbRecordMemberDef;
    sraSorted   : Boolean;
    sraIsSorted : TwbIsSortedCallback;
  public
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aName      : string;
                 const aElement   : IwbRecordMemberDef;
                       aSorted    : Boolean;
                       aAfterLoad : TwbAfterLoadCallback;
                       aAfterSet  : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback;
                       aIsSorted  : TwbIsSortedCallback);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbNamedDef---}
    procedure AfterLoad(const aElement: IwbElement); override;

    {---IwbSignatureDef---}
    function GetDefaultSignature: TwbSignature;

    function GetSignatures(const aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;

    function CanHandle(aSignature     : TwbSignature;
                 const aDataContainer : IwbDataContainer)
                                      : Boolean; virtual;

    {---IwbSubRecordArrayDef---}
    function GetElement: IwbRecordMemberDef;
    function GetSorted(const aContainer: IwbContainer): Boolean;
  end;

  TwbSubRecordStructDef = class(TwbNamedDef, IwbRecordMemberDef, IwbSubRecordStructDef, IwbRecordDef)
  private
    srsMembers           : array of IwbRecordMemberDef;
    srsSignatures        : TStringList;
    srsSkipSignatures    : TStringList;
    srsCanContainFormIDs : Boolean;
    srsAllowUnordered    : Boolean;
  public
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority       : TwbConflictPriority;
                       aRequired       : Boolean;
                 const aName           : string;
                 const aMembers        : array of IwbRecordMemberDef;
                 const aSkipSigs       : array of TwbSignature;
                       aDontShow       : TwbDontShowCallback;
                       aAllowUnordered : Boolean;
                       aAfterLoad      : TwbAfterLoadCallback;
                       aAfterSet       : TwbAfterSetCallback);
    destructor Destroy; override;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbNamedDef---}
    procedure AfterLoad(const aElement: IwbElement); override;

    {---IwbSignatureDef---}
    function GetDefaultSignature: TwbSignature;

    function GetSignatures(const aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;

    function CanHandle(aSignature     : TwbSignature;
                 const aDataContainer : IwbDataContainer)
                                      : Boolean; virtual;

    {---IwbRecordDef---}
    function ContainsMemberFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Boolean;
    function GetMemberFor(aSignature     : TwbSignature;
                    const aDataContainer : IwbDataContainer)
                                         : IwbRecordMemberDef;
    function GetMemberIndexFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Integer;
    function AllowUnordered: Boolean;
    function AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;

    function GetMember(aIndex: Integer): IwbRecordMemberDef;
    function GetMemberCount: Integer;
    function GetSkipSignature(const aSignature: TwbSignature): Boolean; virtual;
    function GetQuickInitLimit: Integer; virtual;
    function GetContainsEditorID: Boolean;
  end;

  TwbSubRecordUnionDef = class(TwbNamedDef, IwbRecordMemberDef, IwbSubRecordUnionDef, IwbRecordDef)
  private
    sruMembers           : array of IwbRecordMemberDef;
    sruSignatures        : TStringList;
    sruSkipSignatures    : TStringList;
    sruCanContainFormIDs : Boolean;
  public
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority : TwbConflictPriority;
                       aRequired : Boolean;
                 const aName     : string;
                 const aMembers  : array of IwbRecordMemberDef;
                 const aSkipSigs : array of TwbSignature;
                       aDontShow : TwbDontShowCallback);
    destructor Destroy; override;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbSignatureDef---}
    function GetDefaultSignature: TwbSignature;

    function GetSignatures(const aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;

    function CanHandle(aSignature     : TwbSignature;
                 const aDataContainer : IwbDataContainer)
                                      : Boolean; virtual;

    {---IwbRecordDef---}
    function ContainsMemberFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Boolean;
    function GetMemberFor(aSignature     : TwbSignature;
                    const aDataContainer : IwbDataContainer)
                                         : IwbRecordMemberDef;
    function GetMemberIndexFor(aSignature     : TwbSignature;
                         const aDataContainer : IwbDataContainer)
                                              : Integer;
    function AllowUnordered: Boolean;
    function AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;

    function GetMember(aIndex: Integer): IwbRecordMemberDef;
    function GetMemberCount: Integer;
    function GetSkipSignature(const aSignature: TwbSignature): Boolean; virtual;
    function GetQuickInitLimit: Integer; virtual;
    function GetContainsEditorID: Boolean;
  end;


  TwbSubRecordStructSKDef = class(TwbSubRecordStructDef, IwbHasSortKeyDef)
  private
    srsSortKey    : array of Integer;
    srsExSortKey  : array of Integer;
    srsMemberInSK : array of Boolean;
  public
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aName      : string;
                 const aMembers   : array of IwbRecordMemberDef;
                 const aSkipSigs  : array of TwbSignature;
                 const aSortKey   : array of Integer;
                 const aExSortKey : array of Integer;
                       aDontShow  : TwbDontShowCallback;
                       aAllowUnordered : Boolean;
                       aAfterLoad      : TwbAfterLoadCallback;
                       aAfterSet       : TwbAfterSetCallback);

    {---IwbHasSortKeyDef---}
    function GetSortKey(aIndex: Integer; aExtended: Boolean): Integer;
    function GetSortKeyCount(aExtended: Boolean): Integer;
    function IsInSK(aIndex: Integer): Boolean;
  end;

  TwbValueDef = class(TwbNamedDef, IwbValueDef)
  protected
    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; reintroduce; virtual; abstract;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; virtual;
    function Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; virtual;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; virtual; abstract;
    function GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement; virtual;
    procedure BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement); virtual;
    function GetIsVariableSize: Boolean; virtual;
    function GetCanBeZeroSize: Boolean; virtual;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; virtual;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); virtual;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; virtual;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); virtual;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; virtual;
    function GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType; virtual;
    function GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; virtual;
    function SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; virtual;

    procedure MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte); virtual;
    procedure MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes); virtual;
    procedure FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters); virtual;
    function CompareExchangeFormID(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOldFormID: Cardinal; aNewFormID: Cardinal): Boolean; virtual;
  end;

  TwbUnionDef = class(TwbValueDef, IwbUnionDef)
  protected {private}
    udDecider: TwbUnionDecider;
    udMembers: array of IwbValueDef;
    ubCanContainFormIDs: Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority : TwbConflictPriority;
                       aRequired : Boolean;
                 const aName     : string;
                       aDecider  : TwbUnionDecider;
                 const aMembers  : array of IwbValueDef;
                       aDontShow : TwbDontShowCallback);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; override;
    function Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement; override;
    procedure BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement); override;
    function GetIsVariableSize: Boolean; override;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; override;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;
    function GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType; override;
    function GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;

    {---IwbUnionDef---}
    function Decide(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): IwbValueDef;
    function GetMember(aIndex: Integer): IwbValueDef;
    function GetMemberCount: Integer;
  end;

  TwbStringTransformType = (
    ttToString,
    ttToSortKey,
    ttToEditValue,
    ttFromEditValue,
    ttToNativeValue,
    ttFromNativeValue
  );

  TwbStringDef = class(TwbValueDef, IwbStringDef)
  protected
    sdSize: Integer;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority;
                       aRequired  : Boolean;
                 const aName      : string;
                       aSize      : Integer;
                       aAfterLoad : TwbAfterLoadCallback;
                       aAfterSet  : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback); virtual;

    function ToStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): AnsiString; virtual;
    function ToStringTransform(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aTransformType: TwbStringTransformType): string;

    procedure FromStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: AnsiString); virtual;
    procedure FromStringTransform(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string; aTransformType: TwbStringTransformType);

    function TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString; virtual;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function GetIsVariableSize: Boolean; override;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; override;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;

    {---IwbStringDef---}
    function GetStringSize: Integer;
  end;

  TwbStringScriptDef = class(TwbStringDef)
  protected
    function TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString; override;
  end;

  TwbStringLCDef = class(TwbStringDef)
  protected
    function TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString; override;
  end;

  TwbStringMgefCodeDef = class(TwbStringDef)
  protected
    function TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString; override;

    {---IwbDef---}
    function CanContainFormIDs: Boolean; override;

    {---IwbValueDef---}
    function GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement; override;
    procedure BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement); override;

    procedure MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes); override;
    procedure FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters); override;
  end;

  TwbLStringDef = class(TwbStringDef)
  protected
    function ToStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): AnsiString; override;
    procedure FromStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: AnsiString); override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
  end;

  TwbLenStringDef = class(TwbValueDef, IwbLenStringDef)
  protected
    Prefix: Integer;
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aName      : string;
                       aPrefix    : integer;
                       aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function GetIsVariableSize: Boolean; override;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; override;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;
  end;

  TwbByteArrayDef = class(TwbValueDef, IwbByteArrayDef)
  protected {private}
    badSize                : Cardinal;

    FoundFormIDAtOffSet    : array of Integer;
    NotFoundFormIDAtOffSet : array of Integer;
    SignaturesAtOffSet     : array of TStringList;
    FormIDsAtOffSetFoundIn  : array of TStringList;

    FoundFloatAtOffSet     : array of Integer;
    NotFoundFloatAtOffSet  : array of Integer;
    FloatsAtOffSet         : array of TStringList;

    FoundString            : Integer;
    NotFoundString         : Integer;
    Strings                : TStringList;

//------------------------------------------------------------------------------
// Added LString Routine
//------------------------------------------------------------------------------
    FoundLString            : Integer;
    NotFoundLString         : Integer;

    IsEmpty                : Integer;
    IsNotEmpty             : Integer;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority : TwbConflictPriority; aRequired: Boolean;
                 const aName     : string;
                       aSize     : Cardinal;
                       aDontShow : TwbDontShowCallback);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;

    procedure Report(const aParents: TwbDefPath); override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function GetIsVariableSize: Boolean; override;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; override;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;
  end;

  TwbEmptyDef = class(TwbValueDef, IwbEmptyDef)
  protected {private}
    edSorted: Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority  : TwbConflictPriority;
                       aRequired  : Boolean;
                 const aName      : string;
                       aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback;
                       aSorted    : Boolean);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanContainFormIDs: Boolean; override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function GetCanBeZeroSize: Boolean; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;

    {--- IwbEmptyDef ---}
    function GetSorted: Boolean;
  end;

  TwbIntegerDef = class(TwbValueDef, IwbIntegerDef)
  private
    inType     : TwbIntType;
    inFormater : IwbIntegerDefFormater;
    inDefault  : Int64;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority : TwbConflictPriority; aRequired: Boolean;
                 const aName     : string;
                 const aIntType  : TwbIntType;
                 const aFormater : IwbIntegerDefFormater;
                       aDontShow : TwbDontShowCallback;
                       aAfterSet : TwbAfterSetCallback = nil;
                       aDefault  : Int64 = 0);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;
    function GetNoReach: Boolean; override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; override;
    function Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement; override;
    procedure BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement); override;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; override;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;
    function GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType; override;
    function GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;

    procedure MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte); override;
    procedure MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes); override;
    procedure FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters); override;
    function CompareExchangeFormID(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOldFormID: Cardinal; aNewFormID: Cardinal): Boolean; override;

    {---IwbIntegerDef---}
    function ToInt(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Int64;
    procedure FromInt(aValue: Int64; aBasePtr, aEndPtr: Pointer; const aElement: IwbElement);
    function GetFormater: IwbIntegerDefFormater;
    function GetIntType: TwbIntType;
  end;

  TwbFloatDef = class(TwbValueDef, IwbFloatDef)
  private
    fdDefault    : Extended;
    fdScale      : Extended;
    fdDigits     : Integer;
    fdNormalizer : TwbFloatNormalizer;
  protected
    constructor Clone(const aSource: TwbDef); override;
    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;

    {---IwbValueDef---}
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; override;
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    procedure FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string); override;
    function ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant; override;
    procedure FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant); override;
    function GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;
    function SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean; override;
  public
    constructor Create(aPriority   : TwbConflictPriority; aRequired: Boolean;
                 const aName       : string;
                       aAfterLoad  : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aScale      : Extended;
                       aDigits     : Integer;
                       aDontShow   : TwbDontShowCallback;
                       aNormalizer : TwbFloatNormalizer;
                       aDefault    : Extended);
  end;

  TwbArrayDef = class(TwbValueDef, IwbArrayDef)
  private
    arCount         : Integer;
    arCountCallback : TwbCountCallback;
    arElement       : IwbValueDef;
    arLabels        : array of string;
    arSorted        : Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;

    constructor Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                 const aName      : string;
                 const aElement   : IwbValueDef;
                       aCount     : Integer;
                 const aLabels    : array of string;
                       aSorted    : Boolean;
                       aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow  : TwbDontShowCallback); overload;

    constructor Create(aPriority      : TwbConflictPriority;
                       aRequired      : Boolean;
                 const aName          : string;
                 const aElement       : IwbValueDef;
                       aCountCallback : TwbCountCallback;
                 const aLabels        : array of string;
                       aSorted        : Boolean;
                       aAfterLoad     : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                       aDontShow      : TwbDontShowCallback); overload;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbValueDef---}
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function GetIsVariableSize: Boolean; override;
    function GetCanBeZeroSize: Boolean; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    {---IwbArrayDef---}
    function GetElement: IwbValueDef;
    function GetCount: Integer;
    function GetElementLabel(aIndex: Integer): string;
    function GetSorted: Boolean;
  end;

  TwbStructDef = class(TwbValueDef, IwbStructDef)
  private
    stMembers             : array of IwbValueDef;
    stSortKey             : array of Integer;
    stExSortKey           : array of Integer;
    stCanContainFormIDs   : Boolean;
    stOptionalFromElement : Integer;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aPriority            : TwbConflictPriority;
                       aRequired            : Boolean;
                 const aName                : string;
                 const aMembers             : array of IwbValueDef;
                 const aSortKey             : array of Integer;
                 const aExSortKey           : array of Integer;
                       aOptionalFromElement : Integer;
                       aDontShow            : TwbDontShowCallback;
                         aAfterLoad : TwbAfterLoadCallback;
                         aAfterSet  : TwbAfterSetCallback);

    {---IwbDef---}
    function GetDefType: TwbDefType; override;
    function CanContainFormIDs: Boolean; override;
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbValueDef---}
    function GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer; override;
    function ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string; override;
    function ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    {---IwbStructDef---}
    function GetMember(aIndex: Integer): IwbValueDef;
    function GetMemberCount: Integer;
    function GetOptionalFromElement: Integer;
  end;

  TwbIntegerDefFormater = class(TwbDef, IwbIntegerDefFormater)
  protected
    constructor Clone(const aSource: TwbDef); override;

    {---IwbDef---}
    function GetDefType: TwbDefType; override;

    {---IwbIntegerDefFormater---}
    function ToString(aInt: Int64; const aElement: IwbElement): string; reintroduce; virtual; abstract;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; virtual; abstract;
    function Check(aInt: Int64; const aElement: IwbElement): string; virtual;
    procedure BuildRef(aInt: Int64; const aElement: IwbElement); virtual;

    function GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType; virtual;
    function GetEditInfo(aInt: Int64; const aElement: IwbElement): string; virtual;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; virtual;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; virtual;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; virtual;
    function GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement; virtual;

    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    function MasterCountUpdated(aInt: Int64; aOld, aNew: Byte): Int64; virtual;
    function MasterIndicesUpdated(aInt: Int64; const aOld, aNew: TBytes): Int64; virtual;
    procedure FindUsedMasters(aInt: Int64; aMasters: PwbUsedMasters); virtual;
    function CompareExchangeFormID(var aInt: Int64; aOldFormID: Cardinal; aNewFormID: Cardinal; const aElement: IwbElement): Boolean; virtual;
  end;

  TwbFormID = class(TwbIntegerDefFormater, IwbFormID)
  protected
    FoundSignatures: TStringList;
    FoundNotAllowedReferences: TStringList;
    NotResolved: TStringList;

    constructor Clone(const aSource: TwbDef); override;

    function IsValid(const aSignature: TwbSignature): Boolean; virtual;
    function IsValidFlst(const aSignature: TwbSignature): Boolean; virtual;
    function CheckFlst(const aMainRecord: IwbMainRecord): Boolean; virtual;
    function IsValidMainRecord(const aMainRecord: IwbMainRecord): Boolean; virtual;

    function FindRecordForAVCode(aInt: Int64; const aElement: IwbElement): IwbMainRecord;

    {---IwbDef---}
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbIntegerDefFormater---}
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    procedure BuildRef(aInt: Int64; const aElement: IwbElement); override;

    function GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType; override;
    function GetEditInfo(aInt: Int64; const aElement: IwbElement): string; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;
    function GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement; override;

    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;

    function MasterCountUpdated(aInt: Int64; aOld, aNew: Byte): Int64; override;
    function MasterIndicesUpdated(aInt: Int64; const aOld, aNew: TBytes): Int64; override;
    procedure FindUsedMasters(aInt: Int64; aMasters: PwbUsedMasters); override;
    function CompareExchangeFormID(var aInt: Int64; aOldFormID: Cardinal; aNewFormID: Cardinal; const aElement: IwbElement): Boolean; override;
  end;

  TwbFormIDChecked = class(TwbFormID, IwbFormIDChecked)
  protected {private}
    fidcValidRefsArr     : array of TwbSignature;
    fidcValidRefs        : TStringList;
    fidcValidFlstRefsArr : array of TwbSignature;
    fidcValidFlstRefs    : TStringList;
    fidcPersistent       : Boolean;
    fidcNoReach          : Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(const aValidRefs     : array of TwbSignature;
                       const aValidFlstRefs : array of TwbSignature;
                             aPersistent    : Boolean;
                             aNoReach       : Boolean = False);
    destructor Destroy; override;

    function IsValid(const aSignature: TwbSignature): Boolean; override;
    function IsValidFlst(const aSignature: TwbSignature): Boolean; override;
    function CheckFlst(const aMainRecord: IwbMainRecord): Boolean; override;
    function IsValidMainRecord(const aMainRecord: IwbMainRecord): Boolean; override;

    {---IwbDef---}
    procedure Report(const aParents: TwbDefPath); override;
    function GetNoReach: Boolean; override;

    {---IwbIntegerDefFormater---}
    function Check(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    {---IwbFormIDChecked---}
    function GetSignature(aIndex: Integer): TwbSignature;
    function GetSignatureCount: Integer;
  end;

  TwbChar4 = class(TwbIntegerDefFormater, IwbChar4)
  protected
    constructor Clone(const aSource: TwbDef); override;

    {---IwbIntegerDefFormater---}
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    procedure BuildRef(aInt: Int64; const aElement: IwbElement); override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;
    function CanContainFormIDs: Boolean; override;
  end;

  TwbFlagsDef = class(TwbIntegerDefFormater, IwbFlagsDef)
  private
    flgNames           : array of string;
    flgDontShows       : array of TwbDontShowCallback;
    flgHasDontShows    : Boolean;
    flgUnusedMask      : Int64;
    flgUnknownIsUnused : Boolean;

    UnknownFlags       : array[0..63] of Integer;
    HasUnknownFlags    : Boolean;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(const aNames           : array of string;
                       const aDontShows       : array of TwbDontShowCallback;
                             aUnknownIsUnused : Boolean);

    {---IwbDef---}
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbIntegerDefFormater---}
    function Check(aInt: Int64; const aElement: IwbElement): string; override;
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;
    function CanContainFormIDs: Boolean; override;

    function GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType; override;
    function GetEditInfo(aInt: Int64; const aElement: IwbElement): string; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;

    {---IwbFlagsDef---}
    function GetFlag(aIndex: Integer): string;
    function GetFlagCount: Integer;
    function GetFlagDontShow(const aElement: IwbElement; aIndex: Integer): Boolean;
    function GetFlagHasDontShow(aIndex: Integer): Boolean;
  end;

  PwbSparseName = ^TwbSparseName;
  TwbSparseName = record
    snIndex : Int64;
    snName  : string;
  end;

  TwbEnumDef = class(TwbIntegerDefFormater, IwbEnumDef)
  private
    enNames          : array of string;
    enSparseNames    : array of TwbSparseName;
    enSparseNamesMap : array of PwbSparseName;
    enEditInfo       : string;

    UnknownEnums: TStringList;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(const aNames       : array of string;
                       const aSparseNames : array of const);

    function FindSparseName(aSearchIndex: Int64; var Index: Integer): Boolean;

    function CanContainFormIDs: Boolean; override;

    {---IwbDef---}
    procedure Report(const aParents: TwbDefPath); override;

    {---IwbIntegerDefFormater---}
    function Check(aInt: Int64; const aElement: IwbElement): string; override;
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    function GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType; override;
    function GetEditInfo(aInt: Int64; const aElement: IwbElement): string; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;

    {---IwbEnumDef---}
    function GetName(aIndex: Integer): string;
    function GetNameCount: Integer;
  end;

  TwbDivDef = class(TwbIntegerDefFormater)
  private
    ddValue: Integer;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aValue: Integer);

    function CanContainFormIDs: Boolean; override;

    {---IwbIntegerDefFormater---}
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;
  end;

  TwbMulDef = class(TwbIntegerDefFormater)
  private
    mdValue: Integer;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(aValue: Integer);

    function CanContainFormIDs: Boolean; override;

    {---IwbIntegerDefFormater---}
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;
  end;

  TwbCallbackDef = class(TwbIntegerDefFormater, IwbCallbackDef)
  private
    cdToStr: TwbIntToStrCallback;
    cdToInt: TwbStrToIntCallback;
  protected
    constructor Clone(const aSource: TwbDef); override;
    constructor Create(const aToStr : TwbIntToStrCallback;
                       const aToInt : TwbStrToIntCallback);

    function CanContainFormIDs: Boolean; override;

    {---IwbIntegerDefFormater---}
    function Check(aInt: Int64; const aElement: IwbElement): string; override;
    function ToString(aInt: Int64; const aElement: IwbElement): string; override;
    function ToSortKey(aInt: Int64; const aElement: IwbElement): string; override;
    function CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean; override;

    function GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType; override;
    function GetEditInfo(aInt: Int64; const aElement: IwbElement): string; override;

    function ToEditValue(aInt: Int64; const aElement: IwbElement): string; override;
    function FromEditValue(const aValue: string; const aElement: IwbElement): Int64; override;
    function GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean; override;

    {---IwbCallbackDef---}
    function GetCallback: TwbIntToStrCallback;
  end;


function wbRecord(const aSignature       : TwbSignature;
                  const aName            : string;
                  const aMembers         : array of IwbRecordMemberDef;
                        aAllowUnordered  : Boolean = False;
                        aAddInfoCallback : TwbAddInfoCallback = nil;
                        aPriority        : TwbConflictPriority = cpNormal;
                        aRequired        : Boolean = False;
                        aAfterLoad       : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil)
                                         : IwbRecordDef;
begin
//  if aSignature <> 'WATR' then
//    aAllowUnordered := True;
  if not Assigned(wbRecordDefMap) then
    wbRecordDefMap := TwbFastStringListCS.CreateSorted;

  if wbRecordDefMap.IndexOf(aSignature) >= 0 then
    raise Exception.CreateFmt('Duplicated record definition for signature %s', [String(aSignature)]);

  Result := TwbRecordDef.Create(aPriority, aRequired, aSignature, aName, aMembers, aAllowUnordered, aAddInfoCallback, aAfterLoad, aAfterSet);
  SetLength(wbRecordDefs, Succ(Length(wbRecordDefs)));
  wbRecordDefs[High(wbRecordDefs)] := Result;
  wbRecordDefMap.AddObject(aSignature, Pointer(Result));
end;

function wbSubRecord(const aSignature : TwbSignature;
                     const aName      : string;
                     const aValue     : IwbValueDef;
                           aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aSizeMatch : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef;
begin
  Result := TwbSubRecordDef.Create(aPriority, aRequired, aSignature, aName, aValue, aAfterLoad, aAfterSet,aSizeMatch, aDontShow);
end;

function wbSubRecord(const aSignatures : array of TwbSignature;
                     const aName       : string;
                     const aValue      : IwbValueDef;
                           aAfterLoad  : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                           aPriority   : TwbConflictPriority = cpNormal;
                           aRequired   : Boolean = False;
                           aSizeMatch  : Boolean = False;
                           aDontShow   : TwbDontShowCallback = nil)
                                       : IwbSubRecordDef;
begin
  Result := TwbSubRecordDef.Create(aPriority, aRequired, aSignatures, aName, aValue, aAfterLoad, aAfterSet, aSizeMatch, aDontShow);
end;


function wbString(const aSignature : TwbSignature;
                  const aName      : string = 'Unknown';
                        aSize      : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbString('', aSize, aPriority), nil, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbString(const aName      : string = 'Unknown';
                        aSize      : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbStringDef; overload;
begin
  Result := TwbStringDef.Create(aPriority, aRequired, aName, aSize, nil, aAfterSet, aDontShow);
end;


function wbStringScript(const aSignature : TwbSignature;
                  const aName      : string;
                        aSize      : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                        aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbStringScript('', aSize, aPriority), nil, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbStringScript(const aName      : string;
                             aSize      : Integer = 0;
                             aPriority  : TwbConflictPriority = cpNormal;
                             aRequired  : Boolean = False;
                             aDontShow  : TwbDontShowCallback = nil;
                             aAfterSet  : TwbAfterSetCallback = nil)
                                        : IwbStringDef; overload;
begin
  Result := TwbStringScriptDef.Create(aPriority, aRequired, aName, aSize, nil, aAfterSet, aDontShow);
end;

function wbStringLC(const aSignature : TwbSignature;
                    const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbStringLC('', aSize, aPriority), nil, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbStringLC(const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbStringDef; overload;
begin
  Result := TwbStringLCDef.Create(aPriority, aRequired, aName, aSize, nil, aAfterSet, aDontShow);
end;

function wbLString(const  aSignature : TwbSignature;
                    const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbLString('', aSize, aPriority), nil, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbLString(const  aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbStringDef; overload;
begin
  Result := TwbLStringDef.Create(aPriority, aRequired, aName, aSize, nil, aAfterSet, aDontShow);
end;

function wbStringMgefCode(const aSignature : TwbSignature;
                    const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbStringMgefCode('', aSize, aPriority), nil, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbStringMgefCode(const aName      : string;
                          aSize      : Integer = 0;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil;
                          aAfterSet  : TwbAfterSetCallback = nil)
                                     : IwbStringDef; overload;
begin
  Result := TwbStringMgefCodeDef.Create(aPriority, aRequired, aName, aSize, nil, aAfterSet, aDontShow);
end;

function wbLenString(const aSignature : TwbSignature;
                     const aName      : string;
                           aPrefix    : Integer = 4;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbLenString('', aPrefix, aPriority), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbLenString(const aName      : string;
                           aPrefix    : Integer = 4;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbLenStringDef; overload;
begin
  Result := TwbLenStringDef.Create(aPriority, aRequired, aName, aPrefix, nil, nil, aDontShow);
end;

function wbUnion(const aSignature : TwbSignature;
                 const aName      : string;
                       aDecider   : TwbUnionDecider;
                 const aMembers   : array of IwbValueDef;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbUnion('', aDecider, aMembers, aPriority), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbUnion(const aName     : string;
                       aDecider  : TwbUnionDecider;
                 const aMembers  : array of IwbValueDef;
                       aPriority : TwbConflictPriority = cpNormal;
                       aRequired : Boolean = False;
                       aDontShow : TwbDontShowCallback = nil)
                                 : IwbUnionDef; overload;
begin
  Result := TwbUnionDef.Create(aPriority, aRequired, aName, aDecider, aMembers, aDontShow);
end;


function wbByteArray(const aSignature : TwbSignature;
                     const aName      : string = 'Unknown';
                           aSize      : Cardinal = 0;
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aSizeMatch : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbByteArray('', aSize, aPriority), nil, nil, aPriority, aRequired, aSizeMatch, aDontShow);
end;

function wbByteArray(const aName     : string = 'Unknown';
                           aSize     : Cardinal = 0;
                           aPriority : TwbConflictPriority = cpNormal;
                           aRequired : Boolean = False;
                           aDontShow : TwbDontShowCallback = nil)
                                     : IwbByteArrayDef; overload;
begin
  Result := TwbByteArrayDef.Create(aPriority, aRequired, aName, aSize, aDontShow);
end;

function wbUnknown(const aSignature : TwbSignature;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aDontShow  : TwbDontShowCallback = nil)
                                    : IwbSubRecordDef;
begin
  Result := wbByteArray(aSignature, 'Unknown', 0, aPriority, aRequired, False, aDontShow);
end;

function wbUnknown(aPriority : TwbConflictPriority = cpNormal;
                   aRequired : Boolean = False;
                   aDontShow : TwbDontShowCallback = nil)
                             : IwbByteArrayDef;
begin
  Result := wbByteArray('Unknown', 0, aPriority, aRequired, aDontShow);
end;

function wbInteger(const aSignature : TwbSignature;
                   const aName      : string;
                   const aIntType   : TwbIntType;
                   const aFormater  : IwbIntegerDefFormater = nil;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aMatchSize : Boolean = False;
                         aDontShow  : TwbDontShowCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil;
                         aDefault   : Int64 = 0)
                                    : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbInteger('', aIntType, aFormater, aPriority, False, nil, nil, aDefault), nil, aAfterSet, aPriority, aRequired, aMatchSize, aDontShow);
end;

function wbInteger(const aName     : string;
                   const aIntType  : TwbIntType;
                   const aFormater : IwbIntegerDefFormater = nil;
                         aPriority : TwbConflictPriority = cpNormal;
                         aRequired : Boolean = False;
                         aDontShow : TwbDontShowCallback = nil;
                         aAfterSet : TwbAfterSetCallback = nil;
                         aDefault  : Int64 = 0)
                                   : IwbIntegerDef; overload;
begin
  Result := TwbIntegerDef.Create(aPriority, aRequired, aName, aIntType, aFormater, aDontShow, aAfterSet, aDefault);
end;

function wbInteger(const aSignature : TwbSignature;
                   const aName      : string;
                   const aIntType   : TwbIntType;
                   const aToStr     : TwbIntToStrCallback;
                   const aToInt     : TwbStrToIntCallback = nil;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aDontShow  : TwbDontShowCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil;
                         aDefault   : Int64 = 0)
                                    : IwbSubRecordDef; overload;
var
  Callback: IwbIntegerDefFormater;
begin
  if Assigned(aToStr) then
    Callback := wbCallback(aToStr, aToInt);
  Result := wbInteger(aSignature, aName, aIntType, Callback, aPriority, aRequired, False, aDontShow, aAfterSet, aDefault);
end;

function wbInteger(const aName     : string;
                   const aIntType  : TwbIntType;
                   const aToStr    : TwbIntToStrCallback;
                   const aToInt    : TwbStrToIntCallback = nil;
                         aPriority : TwbConflictPriority = cpNormal;
                         aRequired : Boolean = False;
                         aDontShow : TwbDontShowCallback = nil;
                         aAfterSet : TwbAfterSetCallback = nil;
                         aDefault  : Int64 = 0)
                                   : IwbIntegerDef; overload;
var
  Callback: IwbIntegerDefFormater;
begin
  if Assigned(aToStr) then
    Callback := wbCallback(aToStr, aToInt);
  Result := wbInteger(aName, aIntType, Callback, aPriority, aRequired, aDontShow, aAfterSet, aDefault);
end;

function wbFloat(const aSignature  : TwbSignature;
                 const aName       : string = 'Unknown';
                       aPriority   : TwbConflictPriority = cpNormal;
                       aRequired   : Boolean = False;
                       aScale      : Extended = 1.0;
                       aDigits     : Integer = -1;
                       aDontShow   : TwbDontShowCallback = nil;
                       aNormalizer : TwbFloatNormalizer = nil;
                       aDefault    : Extended = 0.0)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbFloat('', aPriority, False, aScale, aDigits, nil, aNormalizer, aDefault), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbFloat(const aName       : string = 'Unknown';
                       aPriority   : TwbConflictPriority = cpNormal;
                       aRequired   : Boolean = False;
                       aScale      : Extended = 1.0;
                       aDigits     : Integer = -1;
                       aDontShow   : TwbDontShowCallback = nil;
                       aNormalizer : TwbFloatNormalizer = nil;
                       aDefault    : Extended = 0.0)
                                   : IwbFloatDef; overload;
begin
  Result := TwbFloatDef.Create(aPriority, aRequired, aName, nil, nil, aScale, aDigits, aDontShow, aNormalizer, aDefault);
end;

{--- wbArray - list of identical elements -------------------------------------}
function wbArray(const aSignature : TwbSignature;
                 const aName      : string;
                 const aElement   : IwbValueDef;
                       aCount     : Integer = 0;
                       aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbArray('', aElement, aCount, aPriority), aAfterLoad, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbArray(const aName      : string;
                 const aElement   : IwbValueDef;
                       aCount     : Integer = 0;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbArrayDef; overload;
begin
  Result := TwbArrayDef.Create(aPriority, aRequired, aName, aElement, aCount, [], False, nil, nil, aDontShow);
end;


function wbRArray(const aName     : string;
                  const aElement  : IwbRecordMemberDef;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil)
                                  : IwbSubRecordArrayDef; overload;
begin
  Result := TwbSubRecordArrayDef.Create(aPriority, aRequired, aName, aElement, False, nil, nil, aDontShow, nil);
end;

function wbArray(const aSignature : TwbSignature;
                 const aName      : string;
                 const aElement   : IwbValueDef;
                 const aLabels    : array of string;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbArray('', aElement, aLabels, aPriority), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbArray(const aSignature     : TwbSignature;
                 const aName          : string;
                 const aElement       : IwbValueDef;
                 const aLabels        : array of string;
                       aCountCallback : TwbCountCallback;
                       aPriority      : TwbConflictPriority = cpNormal;
                       aRequired      : Boolean = False;
                       aDontShow      : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbArray('', aElement, aLabels, aCountCallback, aPriority), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbArray(const aName     : string;
                 const aElement  : IwbValueDef;
                 const aLabels   : array of string;
                       aPriority : TwbConflictPriority = cpNormal;
                       aRequired : Boolean = False;
                       aDontShow : TwbDontShowCallback = nil)
                                 : IwbArrayDef; overload;
begin
  Result := TwbArrayDef.Create(aPriority, aRequired, aName, aElement, Length(aLabels), aLabels, False, nil, nil, aDontShow);
end;

function wbArray(const aName          : string;
                 const aElement       : IwbValueDef;
                 const aLabels        : array of string;
                       aCountCallback : TwbCountCallback;
                       aPriority      : TwbConflictPriority = cpNormal;
                       aRequired      : Boolean = False;
                       aDontShow      : TwbDontShowCallback = nil)
                                      : IwbArrayDef; overload;
begin
  Result := TwbArrayDef.Create(aPriority, aRequired, aName, aElement, aCountCallback, aLabels, False, nil, nil, aDontShow);
end;

{--- wbArrayS - list of identical elements - gets sorted ----------------------}
function wbArrayS(const aSignature : TwbSignature;
                  const aName      : string;
                  const aElement   : IwbValueDef;
                        aCount     : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbArrayS('', aElement, aCount, aPriority, False, aAfterLoad), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbArrayS(const aName      : string;
                  const aElement   : IwbValueDef;
                        aCount     : Integer = 0;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbArrayDef; overload;
begin
  Result := TwbArrayDef.Create(aPriority, aRequired, aName, aElement, aCount, [], True, aAfterLoad, aAfterSet,aDontShow);
end;

function wbArrayS(const aName          : string;
                  const aElement       : IwbValueDef;
                        aCountCallback : TwbCountCallback;
                        aPriority      : TwbConflictPriority = cpNormal;
                        aRequired      : Boolean = False;
                        aAfterLoad     : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow      : TwbDontShowCallback = nil)
                                       : IwbArrayDef; overload;
begin
  Result := TwbArrayDef.Create(aPriority, aRequired, aName, aElement, aCountCallback, [], True, aAfterLoad, aAfterSet, aDontShow);
end;

function wbRArrayS(const aName      : string;
                   const aElement   : IwbRecordMemberDef;
                         aPriority  : TwbConflictPriority = cpNormal;
                         aRequired  : Boolean = False;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil;
                         aDontShow  : TwbDontShowCallback = nil;
                         aIsSorted  : TwbIsSortedCallback = nil)
                                    : IwbSubRecordArrayDef; overload;
begin
  Result := TwbSubRecordArrayDef.Create(aPriority, aRequired, aName, aElement, True, aAfterLoad, aAfterSet,aDontShow, aIsSorted);
end;

function wbArrayS(const aSignature : TwbSignature;
                  const aName      : string;
                  const aElement   : IwbValueDef;
                  const aLabels    : array of string;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbArrayS('', aElement, aLabels, aPriority, False, aAfterLoad), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbArrayS(const aName      : string;
                  const aElement   : IwbValueDef;
                  const aLabels    : array of string;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aAfterLoad : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbArrayDef; overload;
begin
  Result := TwbArrayDef.Create(aPriority, aRequired, aName, aElement, Length(aLabels), aLabels, True, aAfterLoad, aAfterSet,aDontShow);
end;



{--- wbStruct - ordered list of members ----------------------------------------}
function wbStructSK(const aSignature           : TwbSignature;
                    const aSortKey             : array of Integer;
                    const aName                : string;
                    const aMembers             : array of IwbValueDef;
                          aPriority            : TwbConflictPriority = cpNormal;
                          aRequired            : Boolean = False;
                          aDontShow            : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                               : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbStructSK(aSortKey, '', aMembers, aPriority, False, nil, aOptionalFromElement), aAfterLoad, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbMultiStructSK(const aSignatures          : array of TwbSignature;
                         const aSortKey             : array of Integer;
                         const aName                : string;
                         const aMembers             : array of IwbValueDef;
                               aPriority            : TwbConflictPriority = cpNormal;
                               aRequired            : Boolean = False;
                               aDontShow            : TwbDontShowCallback = nil;
                               aOptionalFromElement : Integer = -1;
                               aAfterLoad           : TwbAfterLoadCallback = nil;
                               aAfterSet            : TwbAfterSetCallback = nil)
                                                    : IwbSubRecordDef;
begin
  Result := wbSubRecord(aSignatures, aName, wbStructSK(aSortKey, '', aMembers, aPriority, False, nil, aOptionalFromElement), aAfterLoad, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbStructSK(const aSortKey  : array of Integer;
                    const aName     : string;
                    const aMembers  : array of IwbValueDef;
                          aPriority : TwbConflictPriority = cpNormal;
                          aRequired : Boolean = False;
                          aDontShow : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                    : IwbStructDef; overload;
begin
  Result := TwbStructDef.Create(aPriority, aRequired, aName, aMembers, aSortKey, [], aOptionalFromElement, aDontShow, aAfterLoad, aAfterSet);
end;

function wbStructExSK(const aSignature : TwbSignature;
                      const aSortKey   : array of Integer;
                      const aExSortKey : array of Integer;
                      const aName      : string;
                      const aMembers   : array of IwbValueDef;
                            aPriority  : TwbConflictPriority = cpNormal;
                            aRequired  : Boolean = False;
                            aDontShow  : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                       : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbStructExSK(aSortKey, aExSortKey, '', aMembers, aPriority, False, nil, aOptionalFromElement), aAfterLoad, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbStructExSK(const aSortKey   : array of Integer;
                      const aExSortKey : array of Integer;
                      const aName      : string;
                      const aMembers   : array of IwbValueDef;
                            aPriority  : TwbConflictPriority = cpNormal;
                            aRequired  : Boolean = False;
                            aDontShow  : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                       : IwbStructDef; overload;
begin
  Result := TwbStructDef.Create(aPriority, aRequired, aName, aMembers, aSortKey, aExSortKey, aOptionalFromElement, aDontShow, aAfterLoad, aAfterSet);
end;

function wbStruct(const aSignature : TwbSignature;
                  const aName      : string;
                  const aMembers   : array of IwbValueDef;
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbStruct('', aMembers, aPriority, False, nil, aOptionalFromElement), aAfterLoad, aAfterSet, aPriority, aRequired, False, aDontShow);
end;

function wbStruct(const aName     : string;
                  const aMembers  : array of IwbValueDef;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil;
                          aOptionalFromElement : Integer = -1;
                         aAfterLoad : TwbAfterLoadCallback = nil;
                         aAfterSet  : TwbAfterSetCallback = nil)
                                  : IwbStructDef; overload;
begin
  Result := TwbStructDef.Create(aPriority, aRequired, aName, aMembers, [], [], aOptionalFromElement, aDontShow, aAfterLoad, aAfterSet);
end;


function wbRStruct(const aName           : string;
                   const aMembers        : array of IwbRecordMemberDef;
                   const aSkipSigs       : array of TwbSignature;
                         aPriority       : TwbConflictPriority = cpNormal;
                         aRequired       : Boolean = False;
                         aDontShow       : TwbDontShowCallback = nil;
                         aAllowUnordered : Boolean = False;
                         aAfterLoad      : TwbAfterLoadCallback = nil;
                         aAfterSet       : TwbAfterSetCallback = nil)
                                         : IwbSubRecordStructDef; overload;
begin
  Result := TwbSubRecordStructDef.Create(aPriority, aRequired, aName, aMembers, aSkipSigs, aDontShow, aAllowUnordered, aAfterLoad, aAfterSet);
end;

function wbRStructSK(const aSortKey        : array of Integer;
                     const aName           : string;
                     const aMembers        : array of IwbRecordMemberDef;
                     const aSkipSigs       : array of TwbSignature;
                           aPriority       : TwbConflictPriority = cpNormal;
                           aRequired       : Boolean = False;
                           aDontShow       : TwbDontShowCallback = nil;
                           aAllowUnordered : Boolean = False;
                           aAfterLoad      : TwbAfterLoadCallback = nil;
                           aAfterSet       : TwbAfterSetCallback = nil)
                                           : IwbSubRecordStructDef; overload;
begin
  Result := TwbSubRecordStructSKDef.Create(aPriority, aRequired, aName, aMembers, aSkipSigs, aSortKey, [], aDontShow, aAllowUnordered, aAfterLoad, aAfterSet);
end;

function wbRStructExSK(const aSortKey        : array of Integer;
                       const aExSortKey      : array of Integer;
                       const aName           : string;
                       const aMembers        : array of IwbRecordMemberDef;
                       const aSkipSigs       : array of TwbSignature;
                             aPriority       : TwbConflictPriority = cpNormal;
                             aRequired       : Boolean = False;
                             aDontShow       : TwbDontShowCallback = nil;
                             aAllowUnordered : Boolean = False;
                             aAfterLoad      : TwbAfterLoadCallback = nil;
                             aAfterSet       : TwbAfterSetCallback = nil)
                                             : IwbSubRecordStructDef; overload;
begin
  Result := TwbSubRecordStructSKDef.Create(aPriority, aRequired, aName, aMembers, aSkipSigs, aSortKey, aExSortKey, aDontShow, aAllowUnordered, aAfterLoad, aAfterSet);
end;

function wbRUnion(const aName     : string;
                  const aMembers  : array of IwbRecordMemberDef;
                  const aSkipSigs : array of TwbSignature;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil)
                                  : IwbSubRecordUnionDef; overload;
begin
  Result := TwbSubRecordUnionDef.Create(aPriority, aRequired, aName, aMembers, aSkipSigs, aDontShow);
end;

{--- wbStructs - array of struct ----------------------------------------------}
function wbStructs(const aSignature   : TwbSignature;
                   const aName        : string;
                   const aElementName : string;
                   const aMembers     : array of IwbValueDef;
                         aPriority    : TwbConflictPriority = cpNormal;
                         aRequired    : Boolean = False;
                         aDontShow    : TwbDontShowCallback = nil)
                                      : IwbSubRecordDef; overload;
begin
  Result := wbArray(aSignature, aName, wbStruct(aElementName, aMembers, aPriority), 0, nil, nil, aPriority, aRequired, aDontShow);
end;

function wbStructs(const aName        : string;
                   const aElementName : string;
                   const aMembers     : array of IwbValueDef;
                         aPriority    : TwbConflictPriority = cpNormal;
                         aRequired    : Boolean = False;
                         aDontShow    : TwbDontShowCallback = nil)
                                      : IwbArrayDef; overload;
begin
  Result := wbArray(aName, wbStruct(aElementName, aMembers, aPriority), 0, aPriority, aRequired, aDontShow);
end;

function wbRStructs(const aName        : string;
                    const aElementName : string;
                    const aMembers     : array of IwbRecordMemberDef;
                    const aSkipSigs    : array of TwbSignature;
                          aPriority    : TwbConflictPriority = cpNormal;
                          aRequired    : Boolean = False;
                          aDontShow    : TwbDontShowCallback = nil)
                                       : IwbSubRecordArrayDef; overload;
begin
  Result := wbRArray(aName, wbRStruct(aElementName, aMembers, aSkipSigs ,aPriority), aPriority, aRequired, aDontShow);
end;

function wbRStructsSK(const aName        : string;
                      const aElementName : string;
                      const aSortKey     : array of Integer;
                      const aMembers     : array of IwbRecordMemberDef;
                      const aSkipSigs    : array of TwbSignature;
                            aPriority    : TwbConflictPriority = cpNormal;
                            aRequired    : Boolean = False;
                            aAfterLoad   : TwbAfterLoadCallback = nil; aAfterSet: TwbAfterSetCallback = nil;
                            aDontShow    : TwbDontShowCallback = nil)
                                         : IwbSubRecordArrayDef; overload;
begin
  Result := wbRArrayS(aName, wbRStructSK(aSortKey, aElementName, aMembers, aSkipSigs, aPriority), aPriority, aRequired, aAfterLoad, aAfterSet,aDontShow);
end;

function wbEmpty(const aSignature : TwbSignature;
                 const aName      : string;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil)
                                  : IwbSubRecordDef;
begin
  Result := wbSubRecord(aSignature, aName, wbEmpty('', aPriority, aRequired), nil, nil, aPriority, aRequired, False, aDontShow);
end;

function wbEmpty(const aName      : string;
                       aPriority  : TwbConflictPriority = cpNormal;
                       aRequired  : Boolean = False;
                       aDontShow  : TwbDontShowCallback = nil;
                       aSorted    : Boolean = False)
                                  : IwbValueDef;
begin
  Result := TwbEmptyDef.Create(aPriority, aRequired, aName, nil, nil, aDontShow, aSorted);
end;

var
  _FormID: IwbFormID;

function wbFormID: IwbFormID;
begin
  if wbReportMode then
    Result := TwbFormID.Create(cpNormal, False)
  else begin
    if not Assigned(_FormID) then
      _FormID := TwbFormID.Create(cpNormal, False);
    Result := _FormID;
  end;
end;

function wbFormID(const aValidRefs : array of TwbSignature;
                        aPersistent: Boolean)
                                   : IwbFormID;
begin
  Result := TwbFormIDChecked.Create(aValidRefs, [], aPersistent);
end;

function wbFormID(const aValidRefs     : array of TwbSignature;
                  const aValidFlstRefs : array of TwbSignature;
                        aPersistent    : Boolean)
                                       : IwbFormID;
begin
  Result := TwbFormIDChecked.Create(aValidRefs, aValidFlstRefs, aPersistent);
end;

function wbFormIDNoReach(const aValidRefs : array of TwbSignature;
                               aPersistent: Boolean)
                                          : IwbFormID;
begin
  Result := TwbFormIDChecked.Create(aValidRefs, [], aPersistent, True);
end;

function wbFormIDNoReach(const aValidRefs     : array of TwbSignature;
                         const aValidFlstRefs : array of TwbSignature;
                               aPersistent    : Boolean)
                                              : IwbFormID;
begin
  Result := TwbFormIDChecked.Create(aValidRefs, aValidFlstRefs, aPersistent, True);
end;


function wbChar4: IwbChar4;
begin
  Result := TwbChar4.Create(cpNormal, False);
end;

function wbFormID(const aSignature : TwbSignature;
                  const aName      : string = 'Unknown';
                        aPriority  : TwbConflictPriority = cpNormal;
                        aRequired  : Boolean = False;
                        aDontShow  : TwbDontShowCallback = nil)
                                   : IwbSubRecordDef; overload;
begin
  Result := wbInteger(
              aSignature,
              aName,
              itU32,
              wbFormID,
              aPriority,
              aRequired,
              False,
              aDontShow);
end;

function wbFormID(const aName     : string;
                        aPriority : TwbConflictPriority = cpNormal;
                        aRequired : Boolean = False;
                        aDontShow : TwbDontShowCallback = nil)
                                  : IwbIntegerDef; overload;
begin
  Result := wbInteger(aName, itU32, wbFormID, aPriority, aRequired, aDontShow);
end;

function wbFormIDCk(const aSignature : TwbSignature;
                    const aName      : string;
                    const aValidRefs : array of TwbSignature;
                          aPersistent: Boolean = False;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil)
                                     : IwbSubRecordDef; overload;
begin
  Result := wbInteger(aSignature, aName, itU32, wbFormID(aValidRefs, aPersistent), aPriority, aRequired, False, aDontShow);
end;

function wbFormIDCkNoReach(const aSignature : TwbSignature;
                           const aName      : string;
                           const aValidRefs : array of TwbSignature;
                                 aPersistent: Boolean = False;
                                 aPriority  : TwbConflictPriority = cpNormal;
                                 aRequired  : Boolean = False;
                                 aDontShow  : TwbDontShowCallback = nil)
                                            : IwbSubRecordDef; overload;
begin
  Result := wbInteger(aSignature, aName, itU32, wbFormIDNoReach(aValidRefs, aPersistent), aPriority, aRequired, False, aDontShow);
end;

function wbFormIDCk(const aName      : string;
                    const aValidRefs : array of TwbSignature;
                          aPersistent: Boolean = False;
                          aPriority  : TwbConflictPriority = cpNormal;
                          aRequired  : Boolean = False;
                          aDontShow  : TwbDontShowCallback = nil)
                                     : IwbIntegerDef; overload;
begin
  Result := wbInteger(aName, itU32, wbFormID(aValidRefs, aPersistent), aPriority, aRequired, aDontShow);
end;

function wbFormIDCkNoReach(const aName      : string;
                           const aValidRefs : array of TwbSignature;
                                 aPersistent: Boolean = False;
                                 aPriority  : TwbConflictPriority = cpNormal;
                                 aRequired  : Boolean = False;
                                 aDontShow  : TwbDontShowCallback = nil)
                                            : IwbIntegerDef; overload;
begin
  Result := wbInteger(aName, itU32, wbFormIDNoReach(aValidRefs, aPersistent), aPriority, aRequired, aDontShow);
end;


function wbFormIDCk(const aSignature     : TwbSignature;
                    const aName          : string;
                    const aValidRefs     : array of TwbSignature;
                    const aValidFlstRefs : array of TwbSignature;
                          aPersistent    : Boolean = False;
                          aPriority      : TwbConflictPriority = cpNormal;
                          aRequired      : Boolean = False;
                          aDontShow      : TwbDontShowCallback = nil)
                                         : IwbSubRecordDef; overload;
begin
  Result := wbInteger(aSignature, aName, itU32, wbFormID(aValidRefs, aValidFlstRefs, aPersistent), aPriority, aRequired, False, aDontShow);
end;

function wbFormIDCk(const aName          : string;
                    const aValidRefs     : array of TwbSignature;
                    const aValidFlstRefs : array of TwbSignature;
                          aPersistent    : Boolean = False;
                          aPriority      : TwbConflictPriority = cpNormal;
                          aRequired      : Boolean = False;
                          aDontShow      : TwbDontShowCallback = nil)
                                         : IwbIntegerDef; overload;
begin
  Result := wbInteger(aName, itU32, wbFormID(aValidRefs, aValidFlstRefs, aPersistent), aPriority, aRequired, aDontShow);
end;

function wbFormIDCkNoReach(const aName          : string;
                           const aValidRefs     : array of TwbSignature;
                           const aValidFlstRefs : array of TwbSignature;
                                 aPersistent    : Boolean = False;
                                 aPriority      : TwbConflictPriority = cpNormal;
                                 aRequired      : Boolean = False;
                                 aDontShow      : TwbDontShowCallback = nil)
                                                : IwbIntegerDef; overload;
begin
  Result := wbInteger(aName, itU32, wbFormIDNoReach(aValidRefs, aValidFlstRefs, aPersistent), aPriority, aRequired, aDontShow);
end;


function wbFlags(const aNames           : array of string;
                       aUnknownIsUnused : Boolean = False)
                                        : IwbFlagsDef;
begin
  Result := TwbFlagsDef.Create(aNames, [], aUnknownIsUnused);
end;

function wbFlags(const aNames           : array of string;
                 const aDontShows       : array of TwbDontShowCallback;
                       aUnknownIsUnused : Boolean = False)
                                        : IwbFlagsDef; overload;
begin
  Result := TwbFlagsDef.Create(aNames, aDontShows, aUnknownIsUnused);
end;


function wbEnum(const aNames : array of string)
                              : IwbEnumDef;
begin
  Result := TwbEnumDef.Create(aNames, []);
end;

function wbEnum(const aNames       : array of string;
                const aSparseNames : array of const)
                                   : IwbEnumDef; overload;
begin
  Result := TwbEnumDef.Create(aNames, aSparseNames);
end;


function wbDiv(aValue : Integer)
                      : IwbIntegerDefFormater;
begin
  Result := TwbDivDef.Create(aValue);
end;

function wbMul(aValue : Integer)
                      : IwbIntegerDefFormater;
begin
  Result := TwbMulDef.Create(aValue);
end;

function wbCallback(const aToStr : TwbIntToStrCallback;
                    const aToInt : TwbStrToIntCallback)
                                 : IwbIntegerDefFormater;
begin
  Result := TwbCallbackDef.Create(aToStr, aToInt);
end;

{ TwbDef }

function TwbDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
begin
  Result := False;
end;

function TwbDef.CanContainFormIDs: Boolean;
begin
  Result := True;
end;

constructor TwbDef.Clone(const aSource: TwbDef);
begin
  with aSource do
    Self.Create(defPriority, defRequired).defRoot := aSource;
end;

constructor TwbDef.Create(aPriority: TwbConflictPriority; aRequired: Boolean);
begin
  defPriority := aPriority;
  defRequired := aRequired;
  inherited Create;
end;

function TwbDef.Duplicate: TwbDef;
begin
  Result := TwbDefClass(ClassType).Clone(Self);
end;

function TwbDef.Equals(const aDef: IwbDef): Boolean;
begin
  Result := Assigned(aDef) and (aDef.DefID = GetDefID);
end;

function TwbDef.GetConflictPriority: TwbConflictPriority;
begin
  Result := defPriority;
end;

function TwbDef.GetDefID: Cardinal;
begin
  Result := Cardinal(Self);
end;

function TwbDef.GetDontShow(const aElement: IwbElement): Boolean;
begin
  Result := False;
end;

function TwbDef.GetHasDontShow: Boolean;
begin
  Result := False;
end;

function TwbDef.GetNoReach: Boolean;
begin
  Result := False;
end;

function TwbDef.GetRequired: Boolean;
begin
  Result := defRequired;
end;

function TwbDef.GetRoot: IwbDef;
begin
  Result := defRoot;
  if not Assigned(Result) then
    Result := Self;
end;

function TwbDef.IsNotRequired: Boolean;
begin
  Result := defNotRequired;
end;

procedure TwbDef.NotRequired;
begin
  defNotRequired := True;
end;

procedure TwbDef.PossiblyRequired;
begin
  defPossiblyRequired := True;
end;

procedure TwbDef.Report(const aParents: TwbDefPath);
var
  i, j : Integer;
  sl   : TStringList;
begin
  if defReported then
    Exit;

  if wbReportUnused then
    if not defUsed then
      WriteLn('Unused: ', wbDefsToPath(aParents), wbDefToName(Self));

  if wbReportRequired and defPossiblyRequired then
    if defNotRequired = defRequired then
      if defNotRequired then
        WriteLn('Not Required: ', wbDefsToPath(aParents), wbDefToName(Self))
      else
        WriteLn('Required: ', wbDefsToPath(aParents), wbDefToName(Self));

  if wbReportUnknown then
    if Assigned(UnknownValues) then begin
      WriteLn('Unknown Field: ', wbDefsToPath(aParents), wbDefToName(Self), ' (', UnknownValues.Count ,')');
      for i := 0 to Pred(UnknownValues.Count) do begin
        sl := UnknownValues.Objects[i] as TStringList;
        WriteLn('  ', UnknownValues[i], ' (', sl.Count ,')');
        for j := 0 to Pred(sl.Count) do
          WriteLn('    ', sl[j]);
      end;
    end else
      if IsUnknown then
        WriteLn('Unknown Field: ', wbDefsToPath(aParents), wbDefToName(Self));

  defReported := True;
end;

function TwbDef.SetParent(const aParent: TwbDef): IwbDef;
begin
  Assert(Assigned(aParent));
  if Assigned(defParent) then
    Result := Duplicate.SetParent(aParent)
  else begin
    Result := Self;
    defParent := aParent;
  end;
end;

procedure TwbDef.Used(const aElement: IwbElement; const s: string);
var
  i: Integer;
  NamedDef: IwbNamedDef;
begin
  if not wbReportMode then
    Exit;

  defUsed := True;

  if not IsUnknown then
    if not IsUnknownChecked then begin
      IsUnknownChecked := True;
      if Supports(defParent, IwbNamedDef, NamedDef) then
        if Pos('unknown', LowerCase(NamedDef.Name)) > 0 then
          IsUnknown := True;
    end;

  if wbReportUnknown then
    if IsUnknown and Assigned(aElement) and (s <> '') then begin

      if not Assigned(UnknownValues) then
        UnknownValues := TwbFastStringListCS.CreateSorted;

      if UnknownValues.Count < 20 then begin
        if not UnknownValues.Find(s, i) then
          i := UnknownValues.AddObject(s, TwbFastStringListCS.CreateSorted(dupIgnore));

        with UnknownValues.Objects[i] as TStringList do
          if Count < 20 then
            Add(aElement.FullPath);
      end;
    end;
end;

{ TwbNamedDef }

procedure TwbNamedDef.AfterLoad(const aElement: IwbElement);
begin
  Used(nil, '');
  if Assigned(noAfterLoad) then
    noAfterLoad(aElement);
end;


procedure TwbNamedDef.AfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  if Assigned(noAfterSet) then
    noAfterSet(aElement, aOldValue, aNewValue);
end;

constructor TwbNamedDef.Clone(const aSource: TwbDef);
begin
  with (aSource as TwbNamedDef) do
    Self.Create(defPriority, defRequired, noName, noAfterLoad, noAfterSet, noDontShow).defRoot := aSource;
end;

constructor TwbNamedDef.Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                         const aName      : string;
                               aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                               aDontShow  : TwbDontShowCallback);
begin
  noName := aName;
  noDontShow := aDontShow;
  noAfterLoad := aAfterLoad;
  noAfterSet := aAfterSet;
  if aPriority = cpNormal then
    if aName = 'Unused' then
      aPriority := cpIgnore;
  inherited Create(aPriority, aRequired);

  if Pos('unknown', LowerCase(aName)) > 0 then
    IsUnknown := True;
end;

function TwbNamedDef.GetDontShow(const aElement: IwbElement): Boolean;
begin
  if Assigned(noDontShow) then
    Result := noDontShow(aElement)
  else
    Result := False;
end;

function TwbNamedDef.GetHasDontShow: Boolean;
begin
  Result := Assigned(noDontShow);
end;

function TwbNamedDef.GetName: string;
begin
  Result := noName;
end;

function TwbNamedDef.SetParent(const aParent: TwbDef): IwbDef;
var
  Parent: IwbNamedDef;
begin
  Result := inherited SetParent(aParent);

  if not IsUnknown and (noName = '') and Supports(defParent, IwbNamedDef, Parent) then
    IsUnknown := Pos('unknown', LowerCase(Parent.Name)) > 0;
end;

{ TwbSignatureDef }

function TwbSignatureDef.CanHandle(aSignature     : TwbSignature;
                             const aDataContainer : IwbDataContainer)
                                                  : Boolean;
begin
  Result := aSignature = GetDefaultSignature;
end;

constructor TwbSignatureDef.Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                             const aSignature : TwbSignature;
                             const aName      : string;
                                   aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                                   aDontShow  : TwbDontShowCallback);
begin
  SetLength(soSignatures, 1);
  soSignatures[0] := aSignature;
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

constructor TwbSignatureDef.Clone(const aSource: TwbDef);
begin
  with (aSource as TwbSignatureDef) do
    Self.Create(defPriority, defRequired, soSignatures, noName, noAfterLoad, noAfterSet, noDontShow).defRoot := aSource;
end;

constructor TwbSignatureDef.Create(aPriority   : TwbConflictPriority; aRequired: Boolean;
                             const aSignatures : array of TwbSignature;
                             const aName       : string;
                                   aAfterLoad  : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                                   aDontShow   : TwbDontShowCallback);
var
  i: Integer;
begin
  Assert(Length(aSignatures) >= 1);
  SetLength(soSignatures, Length(aSignatures));
  for i := Low(soSignatures) to High(soSignatures) do
    soSignatures[i] := aSignatures[i];
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;


function TwbSignatureDef.GetDefaultSignature: TwbSignature;
begin
  Result := soSignatures[0];
end;

function TwbSignatureDef.GetSignatureCount: Integer;
begin
  Result := Length(soSignatures);
end;

function TwbSignatureDef.GetSignatures(const aIndex: Integer): TwbSignature;
begin
  Result := soSignatures[aIndex];
end;

{ TwbRecordDef }

function TwbRecordDef.AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;
begin
  if Assigned(recAddInfoCallback) then
    Result := recAddInfoCallback(aMainRecord)
  else
    Result := '';
end;

procedure TwbRecordDef.AfterLoad(const aElement: IwbElement);
var
  Found     : Boolean;
  Container : IwbContainerElementRef;
  Element   : IwbElement;
  i, j      : Integer;
begin
  inherited;
  if wbReportMode and wbReportRequired and Supports(aElement, IwbContainerElementRef, Container) then begin
    for i := Low(recMembers) to High(recMembers) do if not recMembers[i].IsNotRequired then begin
      Found := False;
      for j := 0 to Pred(Container.ElementCount) do begin
        Element := Container.Elements[j];
        if recMembers[i].Equals(Element.Def) or recMembers[i].Equals(Element.ValueDef) then begin
          Found := True;
          Break;
        end;
      end;
      recMembers[i].PossiblyRequired;
      if not Found then
        recMembers[i].NotRequired;
    end;
  end;
end;

function TwbRecordDef.AllowUnordered: Boolean;
begin
  Result := recAllowUnordered;
end;

function TwbRecordDef.CanContainFormIDs: Boolean;
begin
  Result := recCanContainFormIDs;
end;

constructor TwbRecordDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbRecordDef do
    Self.Create(defPriority, defRequired, GetDefaultSignature, noName, recMembers,
      recAllowUnordered, recAddInfoCallback, noAfterLoad, noAfterSet).defRoot := aSource;
end;

function TwbRecordDef.ContainsMemberFor(aSignature     : TwbSignature;
                                  const aDataContainer : IwbDataContainer)
                                                       : Boolean;
var
  Dummy: Integer;
begin
  Result := recSignatures.Find(aSignature, Dummy);
end;

constructor TwbRecordDef.Create(aPriority        : TwbConflictPriority;
                                aRequired        : Boolean;
                          const aSignature       : TwbSignature;
                          const aName            : string;
                          const aMembers         : array of IwbRecordMemberDef;
                                aAllowUnordered  : Boolean;
                                aAddInfoCallback : TwbAddInfoCallback;
                                aAfterLoad       : TwbAfterLoadCallback;
                                aAfterSet        : TwbAfterSetCallback);
var
  i, j : Integer;
  Sig  : TwbSignature;
begin
  recQuickInitLimit := -1;
  recAllowUnordered := aAllowUnordered;
  recAddInfoCallback := aAddInfoCallback;

  recSignatures := TwbFastStringListCS.CreateSorted(dupAccept);
  if aAllowUnordered then
    recSignatures.Duplicates := dupError;

  SetLength(recMembers, Length(aMembers));
  for i := Low(recMembers) to High(recMembers) do begin
    recMembers[i] := (aMembers[i] as IwbDefInternal).SetParent(Self) as IwbRecordMemberDef;
    recCanContainFormIDs := recCanContainFormIDs or aMembers[i].CanContainFormIDs;
    for j := 0 to Pred(aMembers[i].SignatureCount) do begin
      Sig := aMembers[i].Signatures[j];
      if (Sig = 'EDID') or
         (Sig = 'FULL') or
         (
           (Sig = 'NAME') and
           (
             (aSignature = 'REFR') or
             (aSignature = 'ACHR') or
             (aSignature = 'ACRE') or
             (aSignature = 'PGRE') or
             (aSignature = 'PMIS')
           )
         ) then begin

        recQuickInitLimit := i;
        if Sig = 'EDID' then
          recContainsEditorID := True;

      end;
      recSignatures.AddObject(Sig, Pointer(i) );
    end;
  end;

  inherited Create(aPriority, aRequired, aSignature, aName, aAfterLoad, aAfterSet, nil);
end;

function TwbRecordDef.GetMember(aIndex: Integer): IwbRecordMemberDef;
begin
  Result := recMembers[aIndex];
end;

function TwbRecordDef.GetMemberCount: Integer;
begin
  Result := Length(recMembers);
end;

function TwbRecordDef.GetMemberFor(aSignature     : TwbSignature;
                             const aDataContainer : IwbDataContainer)
                                                  : IwbRecordMemberDef;
var
  i: Integer;
begin
  if recSignatures.Find(aSignature, i) then
    Result := recMembers[Integer(recSignatures.Objects[i])]
  else
    Result := nil;
end;

function TwbRecordDef.GetMemberIndexFor(aSignature     : TwbSignature;
                                  const aDataContainer : IwbDataContainer)
                                                       : Integer;
var
  i: Integer;
begin
  if recSignatures.Find(aSignature, i) then
    Result := Integer(recSignatures.Objects[i])
  else
    Result := -1;
end;

function TwbRecordDef.GetQuickInitLimit: Integer;
begin
  Result := recQuickInitLimit;
end;

function TwbRecordDef.GetSkipSignature(const aSignature: TwbSignature): Boolean;
begin
  Result := False;
end;

procedure TwbRecordDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
  i       : Integer;
begin
  if defReported then
    Exit;

  inherited;
  Parents := aParents;
  SetLength(Parents, Succ(Length(Parents)));
  Parents[High(Parents)].Def := Self;
  for i := Low(recMembers) to High(recMembers) do
    if Assigned(recMembers[i]) then begin
      Parents[High(Parents)].Index := i;
      recMembers[i].Report(Parents);
    end;

  defReported := True;
end;

destructor TwbRecordDef.Destroy;
begin
  inherited;
  FreeAndNil(recSignatures);
end;

function TwbRecordDef.GetContainsEditorID: Boolean;
begin
  Result := recContainsEditorID;
end;

function TwbRecordDef.GetDefType: TwbDefType;
begin
  Result := dtRecord;
end;

{ TwbSubRecordDef }

function TwbSubRecordDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  SubRecordDef : IwbSubRecordDef;
begin
  if Supports(aDef, IwbSubRecordDef, SubRecordDef) then
    Result := Equals(aDef) or Assigned(srValue) and srValue.CanAssign(aIndex, SubRecordDef.Value)
  else
    Result := Assigned(srValue) and srValue.CanAssign(aIndex, aDef);
end;

function TwbSubRecordDef.CanContainFormIDs: Boolean;
begin
  Result := srValue.CanContainFormIDs;
end;

function TwbSubRecordDef.CanHandle(aSignature     : TwbSignature;
                             const aDataContainer : IwbDataContainer)
                                                  : Boolean;
begin
  Result := inherited CanHandle(aSignature, aDataContainer);
  if Result and srSizeMatch and Assigned(aDataContainer) and Assigned(srValue) then
    Result := aDataContainer.DateSize = srValue.Size[nil, nil, nil];
end;

constructor TwbSubRecordDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbSubRecordDef do
    Self.Create(defPriority, defRequired, soSignatures, noName, srValue, noAfterLoad, noAfterSet, srSizeMatch, noDontShow).defRoot := aSource;
end;

constructor TwbSubRecordDef.Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                             const aSignature : TwbSignature;
                             const aName      : string;
                             const aValue     : IwbValueDef;
                                   aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                                   aSizeMatch : Boolean;
                                   aDontShow  : TwbDontShowCallback);
begin
  srSizeMatch := aSizeMatch;
  if Assigned(aValue) then
    srValue := (aValue as IwbDefInternal).SetParent(Self) as IwbValueDef;
  inherited Create(aPriority, aRequired, aSignature, aName, aAfterLoad, aAfterSet,aDontShow);
end;

constructor TwbSubRecordDef.Create(aPriority   : TwbConflictPriority; aRequired: Boolean;
                             const aSignatures : array of TwbSignature;
                             const aName       : string;
                             const aValue      : IwbValueDef;
                                   aAfterLoad  : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                                   aSizeMatch  : Boolean;
                                   aDontShow   : TwbDontShowCallback);
begin
  srSizeMatch := aSizeMatch;
  if Assigned(aValue) then
    srValue := (aValue as IwbDefInternal).SetParent(Self) as IwbValueDef;
  inherited Create(aPriority, aRequired, aSignatures, aName, aAfterLoad, aAfterSet,aDontShow);
end;

function TwbSubRecordDef.GetDefType: TwbDefType;
begin
  Result := dtSubRecord;
end;

function TwbSubRecordDef.GetValue: IwbValueDef;
begin
  Result := srValue;
end;

procedure TwbSubRecordDef.HasUnusedData;
begin
  srHasUnusedData := True;
end;

procedure TwbSubRecordDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
begin
  if defReported then
    Exit;

  inherited;
  if Assigned(srValue) then begin
    Parents := aParents;
    SetLength(Parents, Succ(Length(Parents)));
    Parents[High(Parents)].Def := Self;
    Parents[High(Parents)].Index := -1;
    srValue.Report(Parents);
  end;
  if wbReportUnusedData then
    if srHasUnusedData then
      WriteLn('Has Unused Data: ', wbDefsToPath(aParents), wbDefToName(Self));

  defReported := True;
end;

{ TwbSubRecordArrayDef }

procedure TwbSubRecordArrayDef.AfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
begin
  inherited;
  if wbReportMode and wbReportRequired and Supports(aElement, IwbContainerElementRef, Container) then begin
    sraElement.PossiblyRequired;
    if Container.ElementCount < 1 then
      sraElement.NotRequired;
  end;
end;

function TwbSubRecordArrayDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  SubRecordArrayDef : IwbSubRecordArrayDef;
begin
  if aIndex = Low(Integer) then
    Result := Supports(aDef, IwbSubRecordArrayDef, SubRecordArrayDef) and
      GetElement.CanAssign(aIndex, SubRecordArrayDef.Element)
  else if aIndex = High(Integer) then
    Result := GetElement.CanAssign(Low(Integer), aDef)
  else
    Result := False;
end;

function TwbSubRecordArrayDef.CanContainFormIDs: Boolean;
begin
  Result := sraElement.CanContainFormIDs;
end;

function TwbSubRecordArrayDef.CanHandle(aSignature     : TwbSignature;
                                  const aDataContainer : IwbDataContainer)
                                                       : Boolean;
begin
  Result := sraElement.CanHandle(aSignature, aDataContainer);
end;

constructor TwbSubRecordArrayDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbSubRecordArrayDef do
    Self.Create(defPriority, defRequired, noName, sraElement, sraSorted,
      noAfterLoad, noAfterSet, noDontShow, sraIsSorted).defRoot := aSource;
end;

constructor TwbSubRecordArrayDef.Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                                  const aName      : string;
                                  const aElement   : IwbRecordMemberDef;
                                        aSorted    : Boolean;
                                        aAfterLoad : TwbAfterLoadCallback;
                                        aAfterSet  : TwbAfterSetCallback;
                                        aDontShow  : TwbDontShowCallback;
                                        aIsSorted  : TwbIsSortedCallback);
begin
  if Assigned(aElement) then
    sraElement := (aElement as IwbDefInternal).SetParent(Self) as IwbRecordMemberDef;
  sraSorted := aSorted;
  sraIsSorted := aIsSorted;
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

function TwbSubRecordArrayDef.GetElement: IwbRecordMemberDef;
begin
  Result := sraElement;
end;

function TwbSubRecordArrayDef.GetDefaultSignature: TwbSignature;
begin
  Result := sraElement.GetDefaultSignature;
end;

function TwbSubRecordArrayDef.GetSignatureCount: Integer;
begin
  Result := sraElement.GetSignatureCount;
end;

function TwbSubRecordArrayDef.GetSignatures(const aIndex: Integer): TwbSignature;
begin
  Result := sraElement.GetSignatures(aIndex);
end;

function TwbSubRecordArrayDef.GetSorted(const aContainer: IwbContainer): Boolean;
begin
  if Assigned(sraIsSorted) then
    Result := sraIsSorted(aContainer)
  else
    Result := sraSorted;
end;

procedure TwbSubRecordArrayDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
begin
  if defReported then
    Exit;

  inherited;
  if Assigned(sraElement) then begin
    Parents := aParents;
    SetLength(Parents, Succ(Length(Parents)));
    Parents[High(Parents)].Def := Self;
    Parents[High(Parents)].Index := -1;
    sraElement.Report(Parents);
  end;

  defReported := True;
end;

function TwbSubRecordArrayDef.GetDefType: TwbDefType;
begin
  Result := dtSubRecordArray;
end;

{ TwbSubRecordStructDef }

function TwbSubRecordStructDef.AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;
begin
  Result := '';
end;

procedure TwbSubRecordStructDef.AfterLoad(const aElement: IwbElement);
var
  Found     : Boolean;
  Container : IwbContainerElementRef;
  Element   : IwbElement;
  i, j      : Integer;
begin
  inherited;
  if wbReportMode and wbReportRequired and  Supports(aElement, IwbContainerElementRef, Container) then begin
    for i := 1 to High(srsMembers) do  if not srsMembers[i].IsNotRequired then begin
      Found := False;
      for j := 0 to Pred(Container.ElementCount) do begin
        Element := Container.Elements[j];
        if srsMembers[i].Equals(Element.Def) or srsMembers[i].Equals(Element.ValueDef) then begin
          Found := True;
          Break;
        end;
      end;
      srsMembers[i].PossiblyRequired;
      if not Found then
        srsMembers[i].NotRequired;
    end;
  end;
end;

function TwbSubRecordStructDef.AllowUnordered: Boolean;
begin
  Result := srsAllowUnordered;
end;

function TwbSubRecordStructDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  SubRecordStructDef : IwbSubRecordStructDef;
  RecordDef          : IwbRecordDef;
  i                  : Integer;
begin
  if Supports(aDef, IwbSubRecordStructDef, SubRecordStructDef) then begin
    Result := Equals(aDef);
    if not Result and
      Supports(aDef, IwbRecordDef, RecordDef) and
      (GetMemberCount = RecordDef.MemberCount)then begin
      Result := True;
      for i := 0 to Pred(GetMemberCount) do
        if not srsMembers[i].CanAssign(aIndex, RecordDef.Members[i]) then begin
          Result := False;
          Break;
        end;
    end;
  end else
    Result := False;
end;

function TwbSubRecordStructDef.CanContainFormIDs: Boolean;
begin
  Result := srsCanContainFormIDs;
end;

function TwbSubRecordStructDef.CanHandle(aSignature     : TwbSignature;
                                   const aDataContainer : IwbDataContainer)
                                                        : Boolean;
begin
  if srsAllowUnordered then
    Result := ContainsMemberFor(aSignature, aDataContainer)
  else
    Result := srsMembers[0].CanHandle(aSignature, aDataContainer);
end;

constructor TwbSubRecordStructDef.Clone(const aSource: TwbDef);
var
  SkipSigs : array of TwbSignature;
  i        : Integer;
begin
  with aSource as TwbSubRecordStructDef do begin
    if Assigned(srsSkipSignatures) then begin
      SetLength(SkipSigs, srsSkipSignatures.Count);
      for i := 0 to Pred(srsSkipSignatures.Count) do
        SkipSigs[i] := StrToSignature(srsSkipSignatures[i]);
    end;
    Self.Create(defPriority, defRequired, noName, srsMembers, SkipSigs, noDontShow, srsAllowUnordered, noAfterLoad, noAfterSet).defRoot := aSource;
  end;
end;

function TwbSubRecordStructDef.ContainsMemberFor(aSignature     : TwbSignature;
                                           const aDataContainer : IwbDataContainer)
                                                                : Boolean;
var
  Dummy: Integer;
begin
  Result := srsSignatures.Find(aSignature, Dummy);
end;

constructor TwbSubRecordStructDef.Create(aPriority       : TwbConflictPriority;
                                         aRequired       : Boolean;
                                   const aName           : string;
                                   const aMembers        : array of IwbRecordMemberDef;
                                   const aSkipSigs       : array of TwbSignature;
                                         aDontShow       : TwbDontShowCallback;
                                         aAllowUnordered : Boolean;
                                         aAfterLoad      : TwbAfterLoadCallback;
                                         aAfterSet       : TwbAfterSetCallback);
var
  i,j: Integer;
begin
  srsAllowUnordered := aAllowUnordered;
  srsSignatures := TwbFastStringListCS.CreateSorted(dupIgnore);

  SetLength(srsMembers, Length(aMembers));
  for i := Low(srsMembers) to High(srsMembers) do begin
    srsMembers[i] := (aMembers[i] as IwbDefInternal).SetParent(Self) as IwbRecordMemberDef;
    srsCanContainFormIDs := srsCanContainFormIDs or aMembers[i].CanContainFormIDs;
    for j := 0 to Pred(aMembers[i].SignatureCount) do
      srsSignatures.AddObject(aMembers[i].Signatures[j], Pointer(i) );
  end;

  if Length(aSkipSigs) > 0 then begin
    srsSkipSignatures := TwbFastStringListCS.CreateSorted(dupIgnore);
    for i := Low(aSkipSigs) to High(aSkipSigs) do
      srsSkipSignatures.Add(aSkipSigs[i]);
  end;

  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet, aDontShow);
end;

destructor TwbSubRecordStructDef.Destroy;
begin
  inherited;
  FreeAndNil(srsSignatures);
end;

function TwbSubRecordStructDef.GetDefType: TwbDefType;
begin
  Result := dtSubRecordStruct;
end;

function TwbSubRecordStructDef.GetMember(aIndex: Integer): IwbRecordMemberDef;
begin
  Result := srsMembers[aIndex];
end;

function TwbSubRecordStructDef.GetMemberCount: Integer;
begin
  Result := Length(srsMembers);
end;

function TwbSubRecordStructDef.GetMemberFor(aSignature     : TwbSignature;
                                      const aDataContainer : IwbDataContainer)
                                                           : IwbRecordMemberDef;
var
  i: Integer;
begin
  if srsSignatures.Find(aSignature, i) then
    Result := srsMembers[Integer(srsSignatures.Objects[i])]
  else
    Result := nil;
end;

function TwbSubRecordStructDef.GetMemberIndexFor(aSignature     : TwbSignature;
                                           const aDataContainer : IwbDataContainer)
                                                                : Integer;
var
  i: Integer;
begin
  if srsSignatures.Find(aSignature, i) then
    Result := Integer(srsSignatures.Objects[i])
  else
    Result := -1;
end;

function TwbSubRecordStructDef.GetQuickInitLimit: Integer;
begin
  Result := -1;
end;

function TwbSubRecordStructDef.GetContainsEditorID: Boolean;
begin
  Result := False;
end;

function TwbSubRecordStructDef.GetDefaultSignature: TwbSignature;
begin
  Result := srsMembers[0].GetDefaultSignature;
end;

function TwbSubRecordStructDef.GetSignatureCount: Integer;
begin
  if srsAllowUnordered then
    Result := srsSignatures.Count
  else
    Result := srsMembers[0].GetSignatureCount;
end;

function TwbSubRecordStructDef.GetSignatures(const aIndex: Integer): TwbSignature;
begin
  if srsAllowUnordered then
    Result := StrToSignature(srsSignatures[aIndex])
  else
    Result := srsMembers[0].GetSignatures(aIndex);
end;

function TwbSubRecordStructDef.GetSkipSignature(const aSignature: TwbSignature): Boolean;
var
  Dummy: Integer;
begin
  Result := Assigned(srsSkipSignatures) and srsSkipSignatures.Find(aSignature, Dummy);
end;

procedure TwbSubRecordStructDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
  i       : Integer;
begin
  if defReported then
    Exit;

  inherited;
  Parents := aParents;
  SetLength(Parents, Succ(Length(Parents)));
  Parents[High(Parents)].Def := Self;
  for i := Low(srsMembers) to High(srsMembers) do
    if Assigned(srsMembers[i]) then begin
      Parents[High(Parents)].Index := i;
      srsMembers[i].Report(Parents);
    end;

  defReported := True;
end;

{ TwbSubRecordUnionDef }

function TwbSubRecordUnionDef.AdditionalInfoFor(const aMainRecord: IwbMainRecord): string;
begin
  Result := '';
end;

function TwbSubRecordUnionDef.AllowUnordered: Boolean;
begin
  Result := True;
end;

function TwbSubRecordUnionDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  SubRecordUnionDef : IwbSubRecordUnionDef;
  RecordDef         : IwbRecordDef;
  i                 : Integer;
begin
  for i := Low(sruMembers) to High(sruMembers) do begin
    Result := sruMembers[i].CanAssign(aIndex, aDef);
    if Result = True then
      Exit;
  end;

  if Supports(aDef, IwbSubRecordUnionDef, SubRecordUnionDef) then begin
    Result := Equals(aDef);
    if not Result and
      Supports(aDef, IwbRecordDef, RecordDef) and
      (GetMemberCount = RecordDef.MemberCount)then begin
      Result := True;
      for i := 0 to Pred(GetMemberCount) do
        if not sruMembers[i].CanAssign(aIndex, RecordDef.Members[i]) then begin
          Result := False;
          Break;
        end;
    end;
  end else
    Result := False;
end;

function TwbSubRecordUnionDef.CanContainFormIDs: Boolean;
begin
  Result := sruCanContainFormIDs;
end;

function TwbSubRecordUnionDef.CanHandle(aSignature     : TwbSignature;
                                  const aDataContainer : IwbDataContainer)
                                                       : Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(sruMembers) to High(sruMembers) do begin
    Result := sruMembers[i].CanHandle(aSignature, aDataContainer);
    if Result then
      Exit;
  end;
end;

constructor TwbSubRecordUnionDef.Clone(const aSource: TwbDef);
var
  SkipSigs : array of TwbSignature;
  i        : Integer;
begin
  with aSource as TwbSubRecordUnionDef do begin
    if Assigned(sruSkipSignatures) then begin
      SetLength(SkipSigs, sruSkipSignatures.Count);
      for i := 0 to Pred(sruSkipSignatures.Count) do
        SkipSigs[i] := StrToSignature(sruSkipSignatures[i]);
    end;
    Self.Create(defPriority, defRequired, noName, sruMembers, SkipSigs, noDontShow).defRoot := aSource;
  end;
end;

function TwbSubRecordUnionDef.ContainsMemberFor(aSignature     : TwbSignature;
                                          const aDataContainer : IwbDataContainer)
                                                               : Boolean;
begin
  Result := CanHandle(aSignature, aDataContainer);
end;

constructor TwbSubRecordUnionDef.Create(aPriority : TwbConflictPriority;
                                        aRequired : Boolean;
                                  const aName     : string;
                                  const aMembers  : array of IwbRecordMemberDef;
                                  const aSkipSigs : array of TwbSignature;
                                        aDontShow : TwbDontShowCallback);
var
  i,j: Integer;
begin
  sruSignatures := TwbFastStringListCS.CreateSorted(dupIgnore);

  SetLength(sruMembers, Length(aMembers));
  for i := Low(sruMembers) to High(sruMembers) do begin
    sruMembers[i] := (aMembers[i] as IwbDefInternal).SetParent(Self) as IwbRecordMemberDef;
    sruCanContainFormIDs := sruCanContainFormIDs or aMembers[i].CanContainFormIDs;
    for j := 0 to Pred(aMembers[i].SignatureCount) do
      sruSignatures.AddObject(aMembers[i].Signatures[j], Pointer(i));
  end;

  if Length(aSkipSigs) > 0 then begin
    sruSkipSignatures := TwbFastStringListCS.CreateSorted(dupIgnore);
    for i := Low(aSkipSigs) to High(aSkipSigs) do
      sruSkipSignatures.Add(aSkipSigs[i]);
  end;

  inherited Create(aPriority, aRequired, aName, nil, nil, aDontShow);
end;

destructor TwbSubRecordUnionDef.Destroy;
begin
  inherited;
  FreeAndNil(sruSignatures);
end;

function TwbSubRecordUnionDef.GetContainsEditorID: Boolean;
begin
  Result := False;
end;

function TwbSubRecordUnionDef.GetDefaultSignature: TwbSignature;
begin
  Result := sruMembers[0].GetDefaultSignature;
end;

function TwbSubRecordUnionDef.GetDefType: TwbDefType;
begin
  Result := dtSubRecordUnion;
end;

function TwbSubRecordUnionDef.GetMember(aIndex: Integer): IwbRecordMemberDef;
begin
  Result := sruMembers[aIndex];
end;

function TwbSubRecordUnionDef.GetMemberCount: Integer;
begin
  Result := Length(sruMembers);
end;

function TwbSubRecordUnionDef.GetMemberFor(aSignature     : TwbSignature;
                                     const aDataContainer : IwbDataContainer)
                                                          : IwbRecordMemberDef;
var
  i: Integer;
begin
  Result := nil;
  for i := Low(sruMembers) to High(sruMembers) do begin
    if sruMembers[i].CanHandle(aSignature, aDataContainer) then begin
      Result := sruMembers[i];
      Exit;
    end;
  end;
end;

function TwbSubRecordUnionDef.GetMemberIndexFor(aSignature     : TwbSignature;
                                          const aDataContainer : IwbDataContainer)
                                                               : Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := Low(sruMembers) to High(sruMembers) do begin
    if sruMembers[i].CanHandle(aSignature, aDataContainer) then begin
      Result := i;
      Exit;
    end;
  end;
end;

function TwbSubRecordUnionDef.GetQuickInitLimit: Integer;
begin
  Result := -1;
end;

function TwbSubRecordUnionDef.GetSignatureCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(sruMembers) to High(sruMembers) do
    Inc(Result, sruMembers[i].GetSignatureCount);
end;

function TwbSubRecordUnionDef.GetSignatures(const aIndex: Integer): TwbSignature;
var
  i, j, k: Integer;
begin
  j := aIndex;
  for i := Low(sruMembers) to High(sruMembers) do begin
    k := sruMembers[i].GetSignatureCount;
    if k > 0 then begin
      if j >= k then
        Dec(j, k)
      else begin
        Result := sruMembers[i].GetSignatures(Pred(k));
        Exit;
      end;
    end;
  end;
  raise Exception.Create('Invalid index');
end;

function TwbSubRecordUnionDef.GetSkipSignature(const aSignature: TwbSignature): Boolean;
var
  Dummy: Integer;
begin
  Result := Assigned(sruSkipSignatures) and sruSkipSignatures.Find(aSignature, Dummy);
end;

procedure TwbSubRecordUnionDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
  i       : Integer;
begin
  if defReported then
    Exit;

  inherited;
  Parents := aParents;
  SetLength(Parents, Succ(Length(Parents)));
  Parents[High(Parents)].Def := Self;
  for i := Low(sruMembers) to High(sruMembers) do
    if Assigned(sruMembers[i]) then begin
      Parents[High(Parents)].Index := i;
      sruMembers[i].Report(Parents);
    end;

  defReported := True;
end;

{ TwbIntegerDef }

procedure TwbIntegerDef.BuildRef(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement);
var
  Value       : Int64;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  if Assigned(inFormater) then
    if Cardinal(aEndPtr) - Cardinal(aBasePtr) >= ExpectedLen[inType] then begin
      case inType of
        itS8:  Value := PShortInt(aBasePtr)^;
        itU16: Value := PWord(aBasePtr)^;
        itS16: Value := PSmallInt(aBasePtr)^;
        itU32: Value := PCardinal(aBasePtr)^;
        itS32: Value := PLongInt(aBasePtr)^;
        itU64: Value := PInt64(aBasePtr)^; //no U64 in delphi...
        itS64: Value := PInt64(aBasePtr)^;
      else
        {itU8:}  Value := PByte(aBasePtr)^;
      end;
      inFormater.BuildRef(Value, aElement);
    end;
end;

function TwbIntegerDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  IntegerDef: IwbIntegerDef;
begin
  Result := Supports(aDef, IwbIntegerDef, IntegerDef);
  if Result then
    if Assigned(inFormater) then
      Result := inFormater.CanAssign(aIndex, IntegerDef.Formater)
    else if Assigned(IntegerDef.Formater) then
      Result := IntegerDef.Formater.CanAssign(aIndex, inFormater);
end;

function TwbIntegerDef.CanContainFormIDs: Boolean;
begin
  Result := Assigned(inFormater) and (inFormater.CanContainFormIDs);
end;

function TwbIntegerDef.Check(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
var
  Len         : Cardinal;
  Value       : Int64;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  Result := '';
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < ExpectedLen[inType] then begin
    if wbCheckExpectedBytes then
      Result := Format('Expected %d bytes of data, found %d', [ExpectedLen[inType] , Len])
  end else begin
    case inType of
      itS8:  Value := PShortInt(aBasePtr)^;
      itU16: Value := PWord(aBasePtr)^;
      itS16: Value := PSmallInt(aBasePtr)^;
      itU32: Value := PCardinal(aBasePtr)^;
      itS32: Value := PLongInt(aBasePtr)^;
      itU64: Value := PInt64(aBasePtr)^; //no U64 in delphi...
      itS64: Value := PInt64(aBasePtr)^;
    else
      {itU8:}  Value := PByte(aBasePtr)^;
    end;
    if Assigned(inFormater) then
      Result := inFormater.Check(Value, aElement)
    else
      Result := '';
  end;
end;

constructor TwbIntegerDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbIntegerDef do
    Self.Create(defPriority, defRequired, noName, inType, inFormater, noDontShow, noAfterSet, inDefault).defRoot := aSource;
end;

function TwbIntegerDef.CompareExchangeFormID(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOldFormID, aNewFormID: Cardinal): Boolean;
var
  i: Int64;
begin
  if Assigned(inFormater) then begin
    i := ToInt(aBasePtr, aEndPtr, aElement);
    Result := inFormater.CompareExchangeFormID(i, aOldFormID, aNewFormID, aElement);
    if Result then
      FromInt(i, aBasePtr, aEndPtr, aElement);
  end else
    Result := inherited CompareExchangeFormID(aBasePtr, aEndPtr, aElement, aOldFormID, aNewFormID);
end;

constructor TwbIntegerDef.Create(aPriority : TwbConflictPriority; aRequired: Boolean;
                           const aName     : string;
                           const aIntType  : TwbIntType;
                           const aFormater : IwbIntegerDefFormater;
                                 aDontShow : TwbDontShowCallback;
                                 aAfterSet : TwbAfterSetCallback = nil;
                                 aDefault  : Int64 = 0);
begin
  inDefault := aDefault;
  inType := aIntType;
  if Assigned(aFormater) then
  inFormater := (aFormater as IwbDefInternal).SetParent(Self) as IwbIntegerDefFormater;
  inherited Create(aPriority, aRequired, aName, nil, aAfterSet, aDontShow);
end;

procedure TwbIntegerDef.FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters);
begin
  if Assigned(inFormater) then
    inFormater.FindUsedMasters(ToInt(aBasePtr, aEndPtr, aElement), aMasters)
  else
    inherited FindUsedMasters(aBasePtr, aEndPtr, aElement, aMasters);
end;

procedure TwbIntegerDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
var
  i: Int64;
begin
  if aValue = '' then
    i := 0
  else if Assigned(inFormater) then
    i := inFormater.FromEditValue(aValue, aElement)
  else
    i := StrToInt64(aValue);
  FromInt(i, aBasePtr, aEndPtr, aElement);
end;

procedure TwbIntegerDef.FromInt(aValue: Int64; aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement);
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  aElement.RequestStorageChange(aBasePtr, aEndPtr, ExpectedLen[inType]);
  case inType of
    itS8:  PShortInt(aBasePtr)^ := aValue;
    itU16: PWord(aBasePtr)^ := aValue;
    itS16: PSmallInt(aBasePtr)^ := aValue;
    itU32: PCardinal(aBasePtr)^ := aValue;
    itS32: PLongInt(aBasePtr)^ := aValue;
    itU64: PInt64(aBasePtr)^ := aValue;
    itS64: PInt64(aBasePtr)^ := aValue;
  else
    PByte(aBasePtr)^ := aValue;
  end;
end;

procedure TwbIntegerDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  aElement.RequestStorageChange(aBasePtr, aEndPtr, ExpectedLen[inType]);
  case inType of
    itS8:  PShortInt(aBasePtr)^ := aValue;
    itU16: PWord(aBasePtr)^ := aValue;
    itS16: PSmallInt(aBasePtr)^ := aValue;
    itU32: PCardinal(aBasePtr)^ := aValue;
    itS32: PLongInt(aBasePtr)^ := aValue;
    itU64: PInt64(aBasePtr)^ := aValue;
    itS64: PInt64(aBasePtr)^ := aValue;
  else
    PByte(aBasePtr)^ := aValue;
  end;
end;

function TwbIntegerDef.GetDefType: TwbDefType;
begin
  Result := dtInteger;
end;

function TwbIntegerDef.GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  if Assigned(inFormater) then
    Result := inFormater.EditInfo[ToInt(aBasePtr, aEndPtr, aElement), aElement]
  else
    Result := inherited GetEditInfo(aBasePtr, aEndPtr, aElement);
end;

function TwbIntegerDef.GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType;
begin
  if Assigned(inFormater) then
    Result := inFormater.EditType[ToInt(aBasePtr, aEndPtr, aElement), aElement]
  else
    Result := inherited GetEditType(aBasePtr, aEndPtr, aElement);
end;

function TwbIntegerDef.GetFormater: IwbIntegerDefFormater;
begin
  Result := inFormater;
end;

function TwbIntegerDef.GetIntType: TwbIntType;
begin
  Result := inType;
end;

function TwbIntegerDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := wbIsInternalEdit or (not Assigned(inFormater) or inFormater.IsEditable[ToInt(aBasePtr, aEndPtr, aElement), aElement]);
end;

function TwbIntegerDef.GetLinksTo(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): IwbElement;
var
  Value       : Int64;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  Result := nil;
  if Assigned(inFormater) then
    if Cardinal(aEndPtr) - Cardinal(aBasePtr) >= ExpectedLen[inType] then begin
      case inType of
        itS8:  Value := PShortInt(aBasePtr)^;
        itU16: Value := PWord(aBasePtr)^;
        itS16: Value := PSmallInt(aBasePtr)^;
        itU32: Value := PCardinal(aBasePtr)^;
        itS32: Value := PLongInt(aBasePtr)^;
        itU64: Value := PInt64(aBasePtr)^; //no U64 in delphi...
        itS64: Value := PInt64(aBasePtr)^;
      else
        {itU8:}  Value := PByte(aBasePtr)^;
      end;
      Result := inFormater.LinksTo[Value, aElement];
    end;
end;

function TwbIntegerDef.GetNoReach: Boolean;
begin
  Result := Assigned(inFormater) and inFormater.NoReach;
end;

function TwbIntegerDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  case inType of
    itU8:  Result := SizeOf(Byte);
    itS8:  Result := SizeOf(ShortInt);
    itU16: Result := SizeOf(Word);
    itS16: Result := SizeOf(SmallInt);
    itU32: Result := SizeOf(Cardinal);
    itS32: Result := SizeOf(LongInt);
    itU64: Result := SizeOf(Int64);
    itS64: Result := SizeOf(Int64);
  else
    Result := 0;
  end;
end;

procedure TwbIntegerDef.MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte);
var
  OldValue : Int64;
  NewValue : Int64;
begin
  if Assigned(inFormater) then begin
    OldValue := ToInt(aBasePtr, aEndPtr, aElement);
    NewValue := inFormater.MasterCountUpdated(OldValue, aOld, aNew);
    if OldValue <> NewValue then
      FromInt(NewValue, aBasePtr, aEndPtr, aElement)
  end else
    inherited MasterCountUpdated(aBasePtr, aEndPtr, aElement, aOld, aNew);
end;

procedure TwbIntegerDef.MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes);
var
  OldValue : Int64;
  NewValue : Int64;
begin
  if Assigned(inFormater) then begin
    OldValue := ToInt(aBasePtr, aEndPtr, aElement);
    NewValue := inFormater.MasterIndicesUpdated(OldValue, aOld, aNew);
    if OldValue <> NewValue then
      FromInt(NewValue, aBasePtr, aEndPtr, aElement)
  end else
    inherited MasterIndicesUpdated(aBasePtr, aEndPtr, aElement, aOld, aNew);
end;

procedure TwbIntegerDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
begin
  if defReported then
    Exit;

  inherited;
  if Assigned(inFormater) then begin
    Parents := aParents;
    SetLength(Parents, Succ(Length(Parents)));
    Parents[High(Parents)].Def := Self;
    Parents[High(Parents)].Index := -1;
    inFormater.Report(aParents);
  end;

  defReported := True;
end;

function TwbIntegerDef.SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := ToInt(aBasePtr, aEndPtr, aElement) <> inDefault;
  if Result then
    FromInt(inDefault, aBasePtr, aEndPtr, aElement);
end;

function IntToHex64(Value: Int64; Digits: Integer): string;
begin
  Result := IntToHex(Value, Digits);
end;


function TwbIntegerDef.ToEditValue(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
var
  Len   : Cardinal;
  Value : Int64;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < ExpectedLen[inType] then
    Result := ''
  else begin
    case inType of
      itS8:  Value := PShortInt(aBasePtr)^;
      itU16: Value := PWord(aBasePtr)^;
      itS16: Value := PSmallInt(aBasePtr)^;
      itU32: Value := PCardinal(aBasePtr)^;
      itS32: Value := PLongInt(aBasePtr)^;
      itU64: Value := PInt64(aBasePtr)^; //no U64 in delphi...
      itS64: Value := PInt64(aBasePtr)^;
    else
      {itU8:}  Value := PByte(aBasePtr)^;
    end;

    Result := '';
    if Assigned(inFormater) then
      Result := inFormater.ToEditValue(Value, aElement);

    if Result = '' then
      Result := IntToStr(Value);
  end;
end;

function TwbIntegerDef.ToInt(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Int64;
var
  Len         : Cardinal;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < ExpectedLen[inType] then
    Result := 0
  else
    case inType of
      itS8:  Result := PShortInt(aBasePtr)^;
      itU16: Result := PWord(aBasePtr)^;
      itS16: Result := PSmallInt(aBasePtr)^;
      itU32: Result := PCardinal(aBasePtr)^;
      itS32: Result := PLongInt(aBasePtr)^;
      itU64: Result := PInt64(aBasePtr)^; //no U64 in delphi...
      itS64: Result := PInt64(aBasePtr)^;
    else
      {itU8:}  Result := PByte(aBasePtr)^;
    end;
end;

function TwbIntegerDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  if Cardinal(aEndPtr) - Cardinal(aBasePtr) < ExpectedLen[inType] then
    VarClear(Result)
  else
    case inType of
      itS8:  Result := PShortInt(aBasePtr)^;
      itU16: Result := PWord(aBasePtr)^;
      itS16: Result := PSmallInt(aBasePtr)^;
      itU32: Result := PCardinal(aBasePtr)^;
      itS32: Result := PLongInt(aBasePtr)^;
      itU64: Result := PInt64(aBasePtr)^; //no U64 in delphi...
      itS64: Result := PInt64(aBasePtr)^;
    else
      {itU8:}  Result := PByte(aBasePtr)^;
    end;
end;

function TwbIntegerDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
var
  Len   : Cardinal;
  Value : Int64;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < ExpectedLen[inType] then
    Result := ''
  else begin
    case inType of
      itS8:  Value := PShortInt(aBasePtr)^;
      itU16: Value := PWord(aBasePtr)^;
      itS16: Value := PSmallInt(aBasePtr)^;
      itU32: Value := PCardinal(aBasePtr)^;
      itS32: Value := PLongInt(aBasePtr)^;
      itU64: Value := PInt64(aBasePtr)^; //no U64 in delphi...
      itS64: Value := PInt64(aBasePtr)^;
    else
      {itU8:}  Value := PByte(aBasePtr)^;
    end;

    Result := '';
    if Assigned(inFormater) then
      Result := inFormater.ToSortKey(Value, aElement);

    if Result = '' then begin
      case inType of
        itS8:  Value := Value + Abs(Int64(Low(ShortInt)));
        itS16: Value := Value + Abs(Int64(Low(SmallInt)));
        itS32: Value := Value + Abs(Int64(Low(LongInt)));
        itS64: Value := Value + Abs(Int64(Low(Int64)));
      end;
      Result := Result + IntToHex64(Value, Succ(ExpectedLen[inType] * 2));
    end;
  end;
end;

function TwbIntegerDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
var
  Len         : Cardinal;
  Value       : Int64;
const
  ExpectedLen : array[TwbIntType] of Cardinal = (
    1, 1, 2, 2, 4, 4, 8, 8
  );
begin
  Result := '';
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < ExpectedLen[inType] then begin
    if wbCheckExpectedBytes then
      Result := Format('<Error: Expected %d bytes of data, found %d>', [ExpectedLen[inType] , Len])
  end else begin
    case inType of
      itS8:  Value := PShortInt(aBasePtr)^;
      itU16: Value := PWord(aBasePtr)^;
      itS16: Value := PSmallInt(aBasePtr)^;
      itU32: Value := PCardinal(aBasePtr)^;
      itS32: Value := PLongInt(aBasePtr)^;
      itU64: Value := PInt64(aBasePtr)^; //no U64 in delphi...
      itS64: Value := PInt64(aBasePtr)^;
    else
      {itU8:}  Value := PByte(aBasePtr)^;
    end;
    if Assigned(inFormater) then
      Result := inFormater.ToString(Value, aElement)
    else
      Result := IntToStr(Value);
    if Len > ExpectedLen[inType] then begin
      if wbCheckExpectedBytes then
        Result := Result + Format(' <Warning: Expected %d bytes of data, found %d>', [ExpectedLen[inType] , Len])
    end;
  end;
  Used(aElement, Result);
end;

{ TwbArrayDef }

constructor TwbArrayDef.Create(aPriority  : TwbConflictPriority;
                               aRequired  : Boolean;
                         const aName      : string;
                         const aElement   : IwbValueDef;
                               aCount     : Integer;
                         const aLabels    : array of string;
                               aSorted    : Boolean;
                               aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                               aDontShow  : TwbDontShowCallback);
var
  i: Integer;
begin
  Assert((not aSorted) or (Length(aLabels) < 1));

  SetLength(arLabels, Length(aLabels));
  for i := Low(arLabels) to High(arLabels) do
    arLabels[i] := aLabels[i];

  arCount := aCount;
  if Assigned(aElement) then
    arElement := (aElement as IwbDefInternal).SetParent(Self) as IwbValueDef;
  arSorted := aSorted;
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

function TwbArrayDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  ArrayDef: IwbArrayDef;
begin
  Result := (aIndex = Low(Integer)) and
    Supports(aDef, IwbArrayDef, ArrayDef) and
    ( ( arCount <= 0 ) or (arCount = ArrayDef.ElementCount) ) and
    arElement.CanAssign(aIndex, ArrayDef.Element);
end;

function TwbArrayDef.CanContainFormIDs: Boolean;
begin
  Result := arElement.CanContainFormIDs;
end;

constructor TwbArrayDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbArrayDef do
    if Assigned(arCountCallback) then
      Self.Create(defPriority, defRequired, noName, arElement, arCountCallback,
        arLabels, arSorted, noAfterLoad, noAfterSet, noDontShow).defRoot := aSource
    else
      Self.Create(defPriority, defRequired, noName, arElement, arCount,
        arLabels, arSorted, noAfterLoad, noAfterSet, noDontShow).defRoot := aSource;
end;

constructor TwbArrayDef.Create(aPriority      : TwbConflictPriority;
                               aRequired      : Boolean;
                         const aName          : string;
                         const aElement       : IwbValueDef;
                               aCountCallback : TwbCountCallback;
                         const aLabels        : array of string;
                               aSorted        : Boolean;
                               aAfterLoad     : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                               aDontShow      : TwbDontShowCallback);
begin
  arCountCallback := aCountCallback;
  Create(aPriority, aRequired, aName, aElement, 0, aLabels, aSorted, aAfterLoad, aAfterSet,aDontShow);
end;

function TwbArrayDef.GetCanBeZeroSize: Boolean;
begin
  Result := True;
end;

function TwbArrayDef.GetCount: Integer;
begin
  Result := arCount;
end;

function TwbArrayDef.GetDefType: TwbDefType;
begin
  Result := dtArray;
end;

function TwbArrayDef.GetElement: IwbValueDef;
begin
  Result := arElement;
end;

function TwbArrayDef.GetElementLabel(aIndex: Integer): string;
begin
  if (aIndex >= Low(arLabels)) and (aIndex <= High(arLabels)) then
    Result := arLabels[aIndex]
  else
    Result := '';
end;

function TwbArrayDef.GetIsVariableSize: Boolean;
begin
  Result := (arCount <= 0) or arElement.IsVariableSize;
end;

function TwbArrayDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Prefix  : Integer;
  Count   : Integer;
  Size    : Integer;
  BasePtr : Pointer;
  EndPtr  : Pointer;
begin
  Result := 0;
  Prefix := 0;

  Count := arCount;
  if Count < 0 then begin
    if Count < -1 then
      if Count < -2 then
        Prefix := 1
      else
        Prefix := 2
    else
      Prefix := 4;
    Result := Prefix;
    if Assigned(aBasePtr) then begin
      case Prefix of
        1: begin
             Count := PByte(aBasePtr)^;
             Inc(PByte(aBasePtr));
           end;
        2: begin
             Count := PWord(aBasePtr)^;
             Inc(PWord(aBasePtr));
           end;
        4: begin
             Count := PCardinal(aBasePtr)^;
             Inc(PCardinal(aBasePtr));
           end;
      end;
    end else
      Count := 0;
  end else begin
    if (Count < 1) and Assigned(arCountCallback) then
      Count := arCountCallback(aBasePtr, aEndPtr, aElement);

    if not Assigned(aBasePtr) and (Count < 1) then
      Count := 1;

    if (Count < 1) and not Assigned(arCountCallback) then
      Result := High(Integer);
  end;

  if Count > 0 then
    if arElement.IsVariableSize then begin

      EndPtr := aBasePtr;
      while (Count > 0) and (Cardinal(EndPtr) < Cardinal(aEndPtr)) do begin
        BasePtr := EndPtr;
        Size := arElement.Size[BasePtr, aEndPtr, aElement];
        if Size = High(Integer) then begin
          Result := High(Integer);
          Exit;
        end;
        Inc(Cardinal(EndPtr), Size);
        Inc(Result, Size);
        Dec(Count);
      end;

    end else begin
      Result := arElement.Size[aBasePtr, aEndPtr, aElement];
      if Result < High(Integer) then
        Result := (Count * Result) + Prefix;
    end;
end;

function TwbArrayDef.GetSorted: Boolean;
begin
  Result := arSorted;
end;

procedure TwbArrayDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
begin
  if defReported then
    Exit;

  inherited;
  if Assigned(arElement) then begin
    Parents := aParents;
    SetLength(Parents, Succ(Length(Parents)));
    Parents[High(Parents)].Def := Self;
    Parents[High(Parents)].Index := -1;
    arElement.Report(aParents);
  end;

  defReported := True;
end;

function TwbArrayDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := '';
  Used(aElement, Result);
end;

{ TwbStructDef }

function TwbStructDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  StructDef : IwbStructDef;
  i         : Integer;
begin
  Result := (aIndex = Low(Integer)) and
    Supports(aDef, IwbStructDef, StructDef) and
    ( GetMemberCount = StructDef.MemberCount);
  if Result and not Equals(aDef) then
    for i := 0 to Pred(GetMemberCount) do
      if not stMembers[i].CanAssign(Low(Integer), StructDef.Members[i]) then begin
        Result := False;
        Exit;
      end;
end;

function TwbStructDef.CanContainFormIDs: Boolean;
begin
  Result := stCanContainFormIDs;
end;

constructor TwbStructDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbStructDef do
    Self.Create(defPriority, defRequired, noName, stMembers, stSortKey,
      stExSortKey, stOptionalFromElement, noDontShow, noAfterLoad, noAfterSet).defRoot := aSource;
end;

constructor TwbStructDef.Create(aPriority            : TwbConflictPriority;
                                aRequired            : Boolean;
                          const aName                : string;
                          const aMembers             : array of IwbValueDef;
                          const aSortKey             : array of Integer;
                          const aExSortKey           : array of Integer;
                                aOptionalFromElement : Integer;
                                aDontShow            : TwbDontShowCallback;
                         aAfterLoad : TwbAfterLoadCallback;
                         aAfterSet  : TwbAfterSetCallback);
var
  i: Integer;
begin
  stOptionalFromElement := aOptionalFromElement;
  SetLength(stMembers, Length(aMembers));
  for i := Low(stMembers) to High(stMembers) do begin
    stMembers[i] := (aMembers[i] as IwbDefInternal).SetParent(Self) as IwbValueDef;
    stCanContainFormIDs := stCanContainFormIDs or aMembers[i].CanContainFormIDs;
  end;
  SetLength(stSortKey, Length(aSortKey));
  for i := Low(stSortKey) to High(stSortKey) do
    stSortKey[i] := aSortKey[i];
  SetLength(stExSortKey, Length(aExSortKey));
  for i := Low(stExSortKey) to High(stExSortKey) do
    stExSortKey[i] := aExSortKey[i];
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet, aDontShow);
end;

function TwbStructDef.GetDefType: TwbDefType;
begin
  Result := dtStruct;
end;

function TwbStructDef.GetMember(aIndex: Integer): IwbValueDef;
begin
  Result := stMembers[aIndex];
end;

function TwbStructDef.GetMemberCount: Integer;
begin
  Result := Length(stMembers);
end;

function TwbStructDef.GetOptionalFromElement: Integer;
begin
  Result := stOptionalFromElement;
end;

function TwbStructDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  i    : Integer;
  Size : Integer;
begin
  Result := 0;
  for i := Low(stMembers) to High(stMembers) do begin
    Size := stMembers[i].Size[aBasePtr, aEndPtr, aElement];
    if Size = High(Integer) then begin
      Result := High(Integer);
      Exit;
    end;
    Inc(Result, Size);
  end;
end;

procedure TwbStructDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
  i       : Integer;
begin
  if defReported then
    Exit;

  inherited;
  Parents := aParents;
  SetLength(Parents, Succ(Length(Parents)));
  Parents[High(Parents)].Def := Self;
  for i := Low(stMembers) to High(stMembers) do
    if Assigned(stMembers[i]) then begin
      Parents[High(Parents)].Index := i;
      stMembers[i].Report(Parents);
    end;

  defReported := True;
end;

function TwbStructDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
var
  i, j        : Integer;
  SortMember  : Integer;
  BasePtr     : Pointer;
  EndPtr      : Pointer;
begin
  Result := '';
  if (Length(stSortKey) > 0) or (aExtended and (Length(stExSortKey) > 0)) then begin
    for i := Low(stSortKey) to High(stSortKey) do begin
      SortMember := stSortKey[i];

      BasePtr := aBasePtr;
      for j := Low(stMembers) to Pred(SortMember) do begin
        Inc(Cardinal(BasePtr), stMembers[j].Size[BasePtr, aEndPtr, aElement]);
        if Cardinal(BasePtr) > Cardinal(aEndPtr) then
          BasePtr := aEndPtr;
      end;

      EndPtr := Pointer( Cardinal(BasePtr) + Cardinal(stMembers[SortMember].Size[BasePtr, aEndPtr, aElement]) );

      if Cardinal(BasePtr) > Cardinal(aEndPtr) then
        BasePtr := aEndPtr;
      if Cardinal(EndPtr) > Cardinal(aEndPtr) then
        EndPtr := aEndPtr;

      Result := Result + stMembers[SortMember].ToSortKey(BasePtr, EndPtr, aElement, aExtended);

      if i < High(stSortKey) then
        Result := Result + '|';
    end;
    if aExtended then begin
      if (Length(stSortKey) > 0) and (Length(stExSortKey) > 0) then
        Result := Result + '|';

      for i := Low(stExSortKey) to High(stExSortKey) do begin
        SortMember := stExSortKey[i];

        BasePtr := aBasePtr;
        for j := Low(stMembers) to Pred(SortMember) do begin
          Inc(Cardinal(BasePtr), stMembers[j].Size[BasePtr, aEndPtr, aElement]);
          if Cardinal(BasePtr) > Cardinal(aEndPtr) then
            BasePtr := aEndPtr;
        end;

        EndPtr := Pointer( Cardinal(BasePtr) + Cardinal(stMembers[SortMember].Size[BasePtr, aEndPtr, aElement]) );

        if Cardinal(BasePtr) > Cardinal(aEndPtr) then
          BasePtr := aEndPtr;
        if Cardinal(EndPtr) > Cardinal(aEndPtr) then
          EndPtr := aEndPtr;

        Result := Result + stMembers[SortMember].ToSortKey(BasePtr, EndPtr, aElement, aExtended);

        if i < High(stExSortKey) then
          Result := Result + '|';
      end;
    end;
  end else begin
    BasePtr := aBasePtr;
    for j := Low(stMembers) to High(stMembers) do begin
      EndPtr := Pointer( Cardinal(BasePtr) + Cardinal(stMembers[j].Size[BasePtr, aEndPtr, aElement]) );

      if Cardinal(BasePtr) > Cardinal(aEndPtr) then
        BasePtr := aEndPtr;
      if Cardinal(EndPtr) > Cardinal(aEndPtr) then
        EndPtr := aEndPtr;

      Result := Result + stMembers[j].ToSortKey(BasePtr, EndPtr, aElement, aExtended);

      BasePtr := EndPtr;

      if j < High(stMembers) then
        Result := Result + '|';
    end;
  end;
end;

function TwbStructDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := '';
  Used(aElement, Result);
end;

{ TwbFlagsDef }

function TwbFlagsDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  FlagsDef: IwbFlagsDef;
  i: Integer;
begin
  Result := Supports(aDef, IwbFlagsDef, FlagsDef) and (FlagsDef.FlagCount = GetFlagCount);
  if Result and not Equals(FlagsDef) then
    for i := 0 to Pred(GetFlagCount) do
      if not SameStr(FlagsDef.Flags[i], GetFlag(i)) then begin
        Result := False;
        Exit;
      end;
end;

function TwbFlagsDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

function TwbFlagsDef.Check(aInt: Int64; const aElement: IwbElement): string;
var
  i: Integer;
  s: string;
begin
  Result := '';
  if not flgUnknownIsUnused then begin
    for i := 0 to 63 do
      if (aInt and (Int64(1) shl i)) <> 0 then begin
        s := '';
        if i <= High(flgNames) then
          s := flgNames[i];
        if s = '' then begin
          s := '<Unknown: '+IntToStr(i)+'>';
          Result := Result + s + ', ';
        end;
      end;
    SetLength(Result, Length(Result)-2);
  end;
end;

constructor TwbFlagsDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbFlagsDef do
    Self.Create(flgNames, flgDontShows, flgUnknownIsUnused).defRoot := aSource;
end;

constructor TwbFlagsDef.Create(const aNames           : array of string;
                               const aDontShows       : array of TwbDontShowCallback;
                                     aUnknownIsUnused : Boolean);
var
  i: Integer;
begin
  flgUnknownIsUnused := aUnknownIsUnused;
  flgUnusedMask := 0;
  if flgUnknownIsUnused then
    flgUnusedMask := not flgUnusedMask;
  SetLength(flgNames, Length(aNames));
  for i := Low(flgNames) to High(flgNames) do begin
    flgNames[i] := aNames[i];
    if SameText(flgNames[i], 'Unused') then
      flgUnusedMask := flgUnusedMask or (Int64(1) shl i)
    else if flgUnknownIsUnused and (flgNames[i] <> '') then
      flgUnusedMask := flgUnusedMask and not (Int64(1) shl i);
  end;

  SetLength(flgDontShows, Length(aDontShows));
  for i := Low(flgDontShows) to High(flgDontShows) do begin
    flgDontShows[i] := aDontShows[i];
    flgHasDontShows := flgHasDontShows or Assigned(flgDontShows[i]);
  end;
  inherited Create(cpNormal, False);
end;

function TwbFlagsDef.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(aValue) do
    case aValue[i] of
      '0': {do nothing};
      '1': Result := Result or (Int64(1) shl Pred(i));
    else
      raise Exception.Create('"'+aValue[i]+'" is not a valid character for a flag');
    end;
  Result := Result and not flgUnusedMask;
end;

function TwbFlagsDef.GetEditInfo(aInt: Int64; const aElement: IwbElement): string;
var
  FlagCount  : Integer;
  IntegerDef : IwbIntegerDef;
  i          : Integer;
  s          : string;
begin
  FlagCount := 64;
  if Assigned(aElement) and (Supports(aElement.Def, IwbIntegerDef, IntegerDef) or Supports(aElement.ValueDef, IwbIntegerDef, IntegerDef)) then
    case IntegerDef.IntType of
      itU8, itS8: FlagCount := 8;
      itU16, itS16: FlagCount := 16;
      itU32, itS32: FlagCount := 32;
    end;

  with TStringList.Create do try
    for i := 0 to Pred(FlagCount) do begin
      s := '';
      if i <= High(flgNames) then
        s := flgNames[i];
      if s = '' then
        if flgUnknownIsUnused then
          s := 'Unused'
        else
          s := '<Unknown: '+IntToStr(i)+'>';
      if GetFlagDontShow(aElement, i) then
        s := '(' + s + ')';
      Add(s);
    end;
    Result := CommaText;
  finally
    Free;
  end;
end;

function TwbFlagsDef.GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType;
begin
  Result := etCheckComboBox;
end;

function TwbFlagsDef.GetFlag(aIndex: Integer): string;
begin
  Result := flgNames[aIndex];
end;

function TwbFlagsDef.GetFlagCount: Integer;
begin
  Result := Length(flgNames);
end;

function TwbFlagsDef.GetFlagDontShow(const aElement: IwbElement; aIndex: Integer): Boolean;
begin
  Result := False;
  if flgHasDontShows and (aIndex <= High(flgDontShows)) and Assigned(flgDontShows[aIndex]) then
    Result := flgDontShows[aIndex](aElement);
end;

function TwbFlagsDef.GetFlagHasDontShow(aIndex: Integer): Boolean;
begin
  Result := flgHasDontShows and (aIndex <= High(flgDontShows)) and Assigned(flgDontShows[aIndex]);
end;

function TwbFlagsDef.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

procedure TwbFlagsDef.Report(const aParents: TwbDefPath);
var
  i: Integer;
begin
  if defReported then
    Exit;

  inherited;
  if wbReportMode and wbReportUnknownFlags and HasUnknownFlags then begin
    WriteLn('Unknown Flags in: ', wbDefsToPath(aParents), wbDefToName(Self));
    for i := 0 to 63 do
      if UnknownFlags[i] > 0 then
        WriteLn('  ', i,' (',UnknownFlags[i],')');
  end;

  defReported := True;
end;

function TwbFlagsDef.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
var
  i: Integer;
begin
  aInt := aInt and not flgUnusedMask;
  Result := StringOfChar('0', 64);
  for i := 0 to 63 do
    if (aInt and (Int64(1) shl i)) <> 0 then begin
      Result[Succ(i)] := '1';
      aInt := aInt and not (Int64(1) shl i);
      if aInt = 0 then begin
        SetLength(Result, Succ(i));
        Exit;
      end;
    end;
end;

function TwbFlagsDef.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
var
  i: Integer;
begin
  aInt := aInt and not flgUnusedMask;
  Result := StringOfChar('0', 64);
  for i := 0 to 63 do
    if (aInt and (Int64(1) shl i)) <> 0 then
      if not GetFlagDontShow(aElement, i) then
        Result[Succ(i)] := '1';
end;

function TwbFlagsDef.ToString(aInt: Int64; const aElement: IwbElement): string;
var
  i: Integer;
  s: string;
begin
  Result := '';
  aInt := aInt and not flgUnusedMask;
  for i := 0 to 63 do
    if (aInt and (Int64(1) shl i)) <> 0 then begin
      s := '';
      if i <= High(flgNames) then
        s := flgNames[i];
      if s = '' then begin
        s := '<Unknown: '+IntToStr(i)+'>';
        if wbReportMode and wbReportUnknownFlags then begin
          Inc(UnknownFlags[i]);
          HasUnknownFlags := True;
        end;
      end;
      if not GetFlagDontShow(aElement, i) then
        Result := Result + s + ', ';
    end;
  SetLength(Result, Length(Result)-2);
  Used(aElement, Result);
end;

{ TwbEnumDef }

function TwbEnumDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  EnumDef: IwbEnumDef;
  i: Integer;
begin
  Result := Supports(aDef, IwbEnumDef, EnumDef) and (EnumDef.NameCount = GetNameCount);
  if Result and not Equals(EnumDef) then
    for i := 0 to Pred(GetNameCount) do
      if not SameStr(EnumDef.Names[i], GetName(i)) then begin
        Result := False;
        Exit;
      end;
end;

function TwbEnumDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

function TwbEnumDef.Check(aInt: Int64; const aElement: IwbElement): string;
var
  i: Integer;
begin
  Result := '';

  if (aInt >= Low(enNames)) and (aInt <= High(enNames)) then
    Result := enNames[aInt];

  if Result = '' then
    if FindSparseName(aInt, i) then
      Result := enSparseNamesMap[i].snName;

  if Result = '' then
    Result := '<Unknown: '+IntToStr(aInt)+'>'
  else
    Result := '';
end;

function CompareSparseName(Item1, Item2: Pointer): Integer;
var
  Index1, Index2: Int64;
begin
  Index1 := PwbSparseName(Item1).snIndex;
  Index2 := PwbSparseName(Item2).snIndex;

  if Index1 < Index2 then
    Result := -1
  else if Index1 = Index2 then
    Result := 0
  else
    Result := 1;
end;

constructor TwbEnumDef.Clone(const aSource: TwbDef);
var
  i: Integer;
begin
  with aSource as TwbEnumDef do begin
    inherited Create(defPriority, defRequired).defRoot := aSource;
    Self.enNames := Copy(enNames, 0, Length(enNames));
    Self.enSparseNames := Copy(enSparseNames, 0, Length(enSparseNames));
    Self.enEditInfo := enEditInfo;
  end;

  SetLength(enSparseNamesMap, Length(enSparseNames));
  for i := Low(enSparseNames) to High(enSparseNames) do
    enSparseNamesMap[i] := @enSparseNames[i];
  if Length(enSparseNames) > 0 then
    QuickSort(@enSparseNamesMap[0], Low(enSparseNames), High(enSparseNames), CompareSparseName);
end;

constructor TwbEnumDef.Create(const aNames: array of string;
                              const aSparseNames : array of const);
var
  i        : Integer;
  EditInfo : TStringList;
begin
  EditInfo := TwbFastStringListIC.Create;
  try
    SetLength(enNames, Length(aNames));
    for i := Low(enNames) to High(enNames) do begin
      enNames[i] := aNames[i];
      if aNames[i] <> '' then
        EditInfo.Add(aNames[i]);
    end;

    Assert(Length(aSparseNames) mod 2 = 0);
    SetLength(enSparseNames, Length(aSparseNames) div 2);
    for i := Low(enSparseNames) to High(enSparseNames) do begin
      Assert(aSparseNames[     i * 2 ].VType in [vtInteger, vtInt64]);
      Assert(aSparseNames[Succ(i * 2)].VType in [vtAnsiString, vtChar, vtUnicodeString, vtWideChar]);
      with enSparseNames[i] do begin

        if aSparseNames[i * 2].VType = vtInteger then
          snIndex := aSparseNames[i * 2 ].VInteger
        else
          snIndex := aSparseNames[i * 2 ].VInt64^;

        if aSparseNames[Succ(i * 2)].VType = vtAnsiString then
          snName  := AnsiString(aSparseNames[Succ(i * 2)].VAnsiString)
        else if aSparseNames[Succ(i * 2)].VType = vtChar then
          snName  := aSparseNames[Succ(i * 2)].VChar
        else if aSparseNames[Succ(i * 2)].VType = vtUnicodeString then
          snName  := UnicodeString(aSparseNames[Succ(i * 2)].VUnicodeString)
        else if aSparseNames[Succ(i * 2)].VType = vtWideChar then
          snName  := aSparseNames[Succ(i * 2)].VWideChar;

        if snName <> '' then
          EditInfo.Add(snName);
      end;
    end;
    EditInfo.Sort;
    enEditInfo := EditInfo.CommaText;
  finally
    FreeAndNil(EditInfo);
  end;

  SetLength(enSparseNamesMap, Length(enSparseNames));
  for i := Low(enSparseNames) to High(enSparseNames) do
    enSparseNamesMap[i] := @enSparseNames[i];
  if Length(enSparseNames) > 0 then
    QuickSort(@enSparseNamesMap[0], Low(enSparseNames), High(enSparseNames), CompareSparseName);

  inherited Create(cpNormal, False);
end;

function CmpI32(a, b : Integer) : Integer;
asm
  xor ecx, ecx
  cmp eax, edx
  jg @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;

function CmpW32(a, b: Cardinal): Integer;
asm
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
end;

function CmpI64(const a, b : Int64) : Integer;
//begin
//  if a = b then
//    Result := nxEqual
//  else if a < b then
//    Result := nxSmallerThan
//  else
//    Result := nxGreaterThan;
//end;
asm
  xor eax, eax
  mov edx, [ebp+20]
  cmp edx, [ebp+12]
  jg @@GT
  jl @@LT
  mov edx, [ebp+16]
  cmp edx, [ebp+8]
  ja @@GT
  je @@EQ
@@LT:
  dec eax
  dec eax
@@GT:
  inc eax
@@EQ:
end;

function TwbEnumDef.FindSparseName(aSearchIndex: Int64; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;

  L := Low(enSparseNamesMap);
  H := High(enSparseNamesMap);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpI64(enSparseNamesMap[I].snIndex, aSearchIndex);
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

function TwbEnumDef.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
var
  i: Integer;
begin
  if aValue = '' then
    Result := 0
  else begin
    for i := Low(enNames) to High(enNames) do
      if SameStr(enNames[i], aValue) then begin
        Result := i;
        Exit;
      end;
    for i := Low(enSparseNames) to High(enSparseNames) do with enSparseNames[i] do
      if SameStr(snName, aValue) then begin
        Result := snIndex;
        Exit;
      end;
    Result := StrToInt64(aValue);
  end;
end;

function TwbEnumDef.GetEditInfo(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := enEditInfo;
end;

function TwbEnumDef.GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType;
begin
  Result := etComboBox;
end;

function TwbEnumDef.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbEnumDef.GetName(aIndex: Integer): string;
begin
  Result := enNames[aIndex];
end;

function TwbEnumDef.GetNameCount: Integer;
begin
  Result := Length(enNames);
end;

procedure TwbEnumDef.Report(const aParents: TwbDefPath);
var
  i, j: Integer;
  sl: TStringList;
begin
  if defReported then
    Exit;

  inherited;
  if wbReportMode and wbReportUnknownEnums and Assigned(UnknownEnums) then begin
    WriteLn('Unknown Enums in: ', wbDefsToPath(aParents), wbDefToName(Self));
    for i := 0 to Pred(UnknownEnums.Count) do begin
      sl := UnknownEnums.Objects[i] as TStringList;
      WriteLn('  ', UnknownEnums[i], ' (',sl.Count,')' );
      for j := 0 to Pred(sl.Count) do
        WriteLn('    ', sl[j], ' (',Integer(sl.Objects[j]),')' );
    end;
  end;

  defReported := True;
end;

function TwbEnumDef.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
var
  i: Integer;
begin
  Result := '';

  if (aInt >= Low(enNames)) and (aInt <= High(enNames)) then
    Result := enNames[aInt];

  if Result = '' then
    if FindSparseName(aInt, i) then
      Result := enSparseNamesMap[i].snName;

  if Result = '' then
    Result := IntToStr(aInt);
end;

function TwbEnumDef.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := ''; {handled by IntegerDef}
end;

function TwbEnumDef.ToString(aInt: Int64; const aElement: IwbElement): string;
var
  s: string;
  i: Integer;
begin
  Result := '';

  if (aInt >= Low(enNames)) and (aInt <= High(enNames)) then
    Result := enNames[aInt];

  if Result = '' then begin
    if FindSparseName(aInt, i) then
      Result := enSparseNamesMap[i].snName
    else begin
      Result := '<Unknown: '+IntToStr(aInt)+'>';
      if wbReportMode and wbReportUnknownEnums then begin
        if not Assigned(UnknownEnums) then
          UnknownEnums := TwbFastStringListIC.CreateSorted;
        if not UnknownEnums.Find(Result, i) then
          i := UnknownEnums.AddObject(Result, TwbFastStringListIC.CreateSorted);
        with UnknownEnums.Objects[i] as TStringList do begin
          if Count < 10 then begin
            s := aElement.FullPath;
            if not Find(s, i) then
              i := Add(s);
            Objects[i] := TObject(Succ(Integer(Objects[i])));
          end;
        end;
      end;
    end;
  end;
  Used(aElement, Result);
end;

{ TwbStringDef }

function TwbStringDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  StringDef: IwbStringDef;
begin
  Result := Supports(aDef, IwbStringDef, StringDef) and
    ((sdSize = 0) or (StringDef.StringSize = 0) or (sdSize <= StringDef.StringSize));
end;

function TwbStringDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

constructor TwbStringDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbStringDef do
    Self.Create(defPriority, defRequired, noName, sdSize, noAfterLoad, noAfterSet, noDontShow).defRoot := aSource;
end;

constructor TwbStringDef.Create(aPriority  : TwbConflictPriority;
                                aRequired  : Boolean;
                          const aName      : string;
                                aSize      : Integer;
                                aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                                aDontShow  : TwbDontShowCallback);
begin
  sdSize := aSize;
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

procedure TwbStringDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
begin
  FromStringTransform(aBasePtr, aEndPtr, aElement, aValue, ttFromEditValue);
end;

procedure TwbStringDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
begin
  FromStringTransform(aBasePtr, aEndPtr, aElement, aValue, ttFromNativeValue);
end;

procedure TwbStringDef.FromStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: AnsiString);
var
  NewSize : Integer;
begin
  if sdSize > 0 then
    NewSize := sdSize
  else
    NewSize := Succ(Length(aValue));

  aElement.RequestStorageChange(aBasePtr, aEndPtr, NewSize);

  if sdSize > 0 then begin
    FillChar(aBasePtr^, sdSize, 0);
    NewSize := Length(aValue);
    if NewSize > 0 then
      Move(aValue[1], aBasePtr^, NewSize);
  end else begin
    if NewSize > 1 then
      Move(aValue[1], aBasePtr^, Length(aValue));

    PAnsiChar(aBasePtr)[Pred(NewSize)] := #0;
  end;
end;

procedure TwbStringDef.FromStringTransform(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string; aTransformType: TwbStringTransformType);
begin
  FromStringNative(aBasePtr, aEndPtr, aElement, TransformString(aValue, aTransformType, aElement));
end;

function TwbStringDef.GetDefType: TwbDefType;
begin
  Result := dtString;
end;

function TwbStringDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbStringDef.GetIsVariableSize: Boolean;
begin
  Result := sdSize = 0;
end;

function TwbStringDef.GetStringSize: Integer;
begin
  Result := sdSize;
end;

function TwbStringDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  if sdSize > 0 then
    Result := sdSize
  else begin
    if aBasePtr = nil then
      Result := 1
    else begin
      Result := 0;
      while Cardinal(aBasePtr) < Cardinal(aEndPtr) do begin
        Inc(Result);
        if PAnsiChar(aBasePtr)^ = #0 then
          Exit;

        Inc(Cardinal(aBasePtr));
      end;
    end;
  end;
end;

function TwbStringDef.ToEditValue(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
begin
  Result := ToStringTransform(aBasePtr, aEndPtr, aElement, ttToEditValue);
end;

function TwbStringDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
begin
  Result := ToStringTransform(aBasePtr, aEndPtr, aElement, ttToNativeValue);
end;

function TwbStringDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
begin
  Result := ToStringTransform(aBasePtr, aEndPtr, aElement, ttToSortKey);
end;

function TwbStringDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := ToStringTransform(aBasePtr, aEndPtr, aElement, ttToString);
end;

function TwbStringDef.ToStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): AnsiString;
var
  Len : Cardinal;
begin
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if sdSize > 0 then begin
    if Len > Cardinal(sdSize) then
      Len := sdSize;
  end;

  while (Len > 0) and (PAnsiChar(aBasePtr)[Pred(Len)] = #0) do
    Dec(Len);

  SetLength(Result, Len);
  if Len > 0 then
    Move(aBasePtr^, Result[1], Len);
  Used(aElement, Result);
end;

function TwbStringDef.ToStringTransform(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aTransformType: TwbStringTransformType): string;
begin
  Result := TransformString(ToStringNative(aBasePtr, aEndPtr, aElement), aTransformType, aElement);
end;

function TwbStringDef.TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString;
begin
  Result := s;
end;

{ TwbFloatDef }

function TwbFloatDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  FloatDef: IwbFloatDef;
begin
  Result := Supports(aDef, IwbFloatDef, FloatDef);
end;

function TwbFloatDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

constructor TwbFloatDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbFloatDef do
    Self.Create(defPriority, defRequired, noName, noAfterLoad, noAfterSet, fdScale, fdDigits, noDontShow, fdNormalizer, fdDefault).defRoot := aSource;
end;

constructor TwbFloatDef.Create(aPriority   : TwbConflictPriority;
                               aRequired   : Boolean;
                         const aName       : string;
                               aAfterLoad  : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                               aScale      : Extended;
                               aDigits     : Integer;
                               aDontShow   : TwbDontShowCallback;
                               aNormalizer : TwbFloatNormalizer;
                               aDefault    : Extended);
begin
  fdDefault := aDefault;
  fdScale := aScale;
  fdDigits := aDigits;
  fdNormalizer := aNormalizer;
  if fdDigits < 0 then
    fdDigits := wbFloatDigits;
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

procedure TwbFloatDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
var
  Value: Extended;
begin
  aElement.RequestStorageChange(aBasePtr, aEndPtr, 4);
  if aValue = '' then
    PSingle(aBasePtr)^ := 0.0
  else if SameText(aValue, 'Default') then
    PCardinal(aBasePtr)^ := $7F7FFFFF
  else begin
    Value := RoundToEx(StrToFloat(aValue), -fdDigits);
    Value := Value / fdScale;
    if Assigned(fdNormalizer) then
      Value := fdNormalizer(aElement, Value);
    PSingle(aBasePtr)^ := Value;
  end;
end;

procedure TwbFloatDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
var
  Value: Extended;
begin
  Value := aValue;
  if SameValue(Value, MaxSingle) or (Value > MaxSingle) then
    PCardinal(aBasePtr)^ := $7F7FFFFF
  else begin
    Value := RoundToEx(Value, -fdDigits);
    Value := Value / fdScale;
    aElement.RequestStorageChange(aBasePtr, aEndPtr, 4);
    if Assigned(fdNormalizer) then
      Value := fdNormalizer(aElement, Value);
    PSingle(aBasePtr)^ := Value;
  end;
end;

function TwbFloatDef.GetDefType: TwbDefType;
begin
  Result := dtFloat;
end;

function TwbFloatDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbFloatDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := SizeOf(Single);
end;

function TwbFloatDef.SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
var
  Value: Extended;
begin
  Value := ToNativeValue(aBasePtr, aEndPtr, aElement);
  Result := not SingleSameValue(Value, fdDefault);
  if Result then
    FromNativeValue(aBasePtr, aEndPtr, aElement, fdDefault);
end;

function TwbFloatDef.ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
var
  Len   : Cardinal;
  Value : Extended;
begin
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < 4 then
    Result := ''
  else try
    if PCardinal(aBasePtr)^ = $7F7FFFFF then
      Result := 'Default'
    else begin
      Value := PSingle(aBasePtr)^;
      try
        if Value <> 0.0 then
          if SingleSameValue(Value, 0.0) then
            Value := 0.0;
      except
        Value := 0.0;
      end;

      if Assigned(fdNormalizer) then
        Value := fdNormalizer(aElement, Value);
      Value := Value * fdScale;
      Value := RoundToEx(Value, -fdDigits);
      Result := FloatToStrF(Value, ffFixed, 99, fdDigits);
    end;
  except
    Result := '';
  end;
end;

function TwbFloatDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
var
  Value: Extended;
begin
  if Cardinal(aEndPtr) - Cardinal(aBasePtr) < 4 then
    VarClear(Result)
  else try
    if PCardinal(aBasePtr)^ = $7F7FFFFF then
      Result := MaxSingle
    else begin
      Value := PSingle(aBasePtr)^;
      try
        if Value <> 0.0 then
          if SingleSameValue(Value, 0.0) then
            Value := 0.0;
      except
        Value := 0.0;
      end;

      if Assigned(fdNormalizer) then
        Value := fdNormalizer(aElement, Value);
      Value := Value * fdScale;
      Value := RoundToEx(Value, -fdDigits);
      Result := Value;
    end;
  except
    Result := Null;
  end;
end;

function TwbFloatDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
var
  Len   : Cardinal;
  f, g  : Extended;
const
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < 4 then
    Result := StringOfChar(' ', 23)
  else try
    if PCardinal(aBasePtr)^ = $7F7FFFFF then
      Result := '+' + StringOfChar('9', 22)
    else begin
      f := PSingle(aBasePtr)^;
      try
        if IsNan(f) or IsInfinite(f) then
          f := 0.0
        else if f <> 0 then
          if SingleSameValue(f, 0.0) then
            f := 0.0;
      except
        f := 0.0;
      end;

      if Assigned(fdNormalizer) then
        f := fdNormalizer(aElement, f);
      f := f * fdScale;
      try
        f := RoundToEx(f, -fdDigits);
      except
        f := 0.0;
      end;

      g := Abs(f);
      g := RoundToEx(g, -fdDigits);
      Result := FloatToStrF(g, ffFixed, 99, fdDigits);

      if Length(Result) < 22 then
        Result := StringOfChar('0', 22 - Length(Result)) + Result;
      Result := PlusMinus[(f < 0) and not IsZero(f, 0.0000009999999999)] + Result;
    end;
  except
    Result := StringOfChar('X', 23);
  end;
end;

function TwbFloatDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
var
  Len   : Cardinal;
  f     : Extended;
begin
  Result := '';
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < 4 then begin
    if wbCheckExpectedBytes then
      Result := Format('<Error: Expected %d bytes of data, found %d>', [4, Len])
  end else try
    if PCardinal(aBasePtr)^ = $7F7FFFFF then
      Result := 'Default'
    else begin
      f := PSingle(aBasePtr)^;
      if Assigned(fdNormalizer) then
        f := fdNormalizer(aElement, f);
      f := RoundToEx(f * fdScale, -fdDigits);
      Result := FloatToStrF(f, ffFixed, 99, fdDigits);
    end;
    if Len > 4 then
      if wbCheckExpectedBytes then
       Result := Format(' <Warning: Expected %d bytes of data, found %d>', [4, Len])
  except
    on E: Exception do
      Result := '$'+IntToHex64(PCardinal(aBasePtr)^, 8)+' <Error: '+E.Message+'>';
  end;
  Used(aElement, Result);
end;

{ TwbChar4 }

procedure TwbChar4.BuildRef(aInt: Int64; const aElement: IwbElement);
var
  U32: Cardinal;
  _File: IwbFile;
  Rec: IwbMainRecord;
begin
  U32 := aInt;

  _File := aElement._File;
  if Assigned(_File) then begin
    Rec := _File.RecordByEditorID[PwbSignature(@U32)^];
    if Assigned(Rec) then
      aElement.AddReferencedFromID(Rec.LoadOrderFormID); // should always be 00, these are only defined in Oblivion.esm
  end;
end;

function TwbChar4.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
begin
  Result := Supports(aDef, IwbChar4);
end;

function TwbChar4.CanContainFormIDs: Boolean;
begin
  Result := True;
end;

constructor TwbChar4.Clone(const aSource: TwbDef);
begin
  with aSource as TwbChar4 do
    Self.Create(defPriority, defRequired).defRoot := aSource;
end;

function TwbChar4.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
const
  Empty : TwbSignature = '    ';
var
  s     : AnsiString;
begin
  if aValue = '' then
    Result := Cardinal(Empty)
  else begin
    s := aValue;
    if Length(s) <> 4 then
      raise Exception.Create('The value must be exactly 4 characters');

    Result := PCardinal(@s[1])^;
  end;
end;

function TwbChar4.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbChar4.GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement;
var
  U32: Cardinal;
  _File: IwbFile;
begin
  Result := nil;
  U32 := aInt;
  _File := aElement._File;
  if Assigned(_File) then
    Result := _File.RecordByEditorID[PwbSignature(@U32)^];
end;

function TwbChar4.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := ToSortKey(aInt, aElement);
end;

function TwbChar4.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
var
  U32: Cardinal;
begin
  U32 := aInt;
  Result := PwbSignature(@U32)^;
end;

function TwbChar4.ToString(aInt: Int64; const aElement: IwbElement): string;
var
  U32: Cardinal;
  _File: IwbFile;
  Rec: IwbRecord;
begin
  U32 := aInt;
  Result := PwbSignature(@U32)^;

  _File := aElement._File;
  if Assigned(_File) then begin
    Rec := _File.RecordByEditorID[Result];
    if Assigned(Rec) then begin
      Result := Rec.Name;
      Used(aElement, Result);
      Exit;
    end;
  end;

  if U32 <> 0 then
    Result := Result + ' <Warning: could not be resolved>';
  Used(aElement, Result);
end;

{ TwbFormID }

procedure TwbFormID.BuildRef(aInt: Int64; const aElement: IwbElement);
begin
  if ((aInt < $800) or (aInt = $FFFFFFFF)) and IsValid('ACVA') then
    Exit;

  if (aInt <> 0) and (aInt <> $14) then
    aElement.AddReferencedFromID(aInt);
end;

function TwbFormID.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
begin
  Result := Supports(aDef, IwbFormID);
end;

function TwbFormID.CanContainFormIDs: Boolean;
begin
  Result := True;
end;

function TwbFormID.CheckFlst(const aMainRecord: IwbMainRecord): Boolean;
begin
  Result := True;
end;

constructor TwbFormID.Clone(const aSource: TwbDef);
begin
  with aSource as TwbFormID do
    Self.Create(defPriority, defRequired).defRoot := aSource;
end;

function TwbFormID.CompareExchangeFormID(var aInt: Int64; aOldFormID: Cardinal; aNewFormID: Cardinal; const aElement: IwbElement): Boolean;
var
  _File     : IwbFile;

  FormID    : Cardinal;
  FileID    : Integer;
  NewFileID : Integer;
  i         : Integer;
begin
  Result := False;

  if (aInt < $800) or (aInt = $FFFFFFFF) and IsValid('ACVA') then
    Exit;

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then begin
      FormID := aInt;
      FileID := FormID shr 24;

      if FileID >= _File.MasterCount then
        FileID := _File.LoadOrder
      else
        FileID := _File.Masters[FileID].LoadOrder;

      if FileID < 0 then
        raise Exception.Create('Could not determine load order FormID for old value');

      FormID := (FormID and $00FFFFFF) or (Cardinal(FileID) shl 24);
      if FormID = aOldFormID then begin
        FileID := aNewFormID shr 24;
        NewFileID := -1;
        if FileID = _File.LoadOrder then
          NewFileID := _File.MasterCount
        else
          for i := 0 to Pred(_File.MasterCount) do
            if _File.Masters[i].LoadOrder = FileID then begin
              NewFileID := i;
              break;
            end;
        if NewFileID < 0 then
          raise Exception.Create('FormID ['+IntToHex64(aNewFormID, 8)+'] references a master which is not available in file ' + _File.Name);

        FormID := (aNewFormID and $00FFFFFF) or (Cardinal(NewFileID) shl 24);
        if aInt <> FormID then begin
          aInt := FormID;
          Result := True;
        end;
      end;
    end;
  end;
end;

function TwbFormID.FindRecordForAVCode(aInt: Int64; const aElement: IwbElement): IwbMainRecord;
var
  CheckedFiles : TList;
  MaxLoadOrder : Integer;

  function CheckFile(aFile: IwbFile): IwbMainRecord;
  var
    Group : IwbContainerElementRef;
    i     : Integer;
    AV    : Variant;
  begin
    if CheckedFiles.IndexOf(Pointer(aFile)) >= 0 then
      Exit(nil);
    CheckedFiles.Add(Pointer(aFile));

    if Supports(aFile.GroupBySignature['MISC'], IwbContainerElementRef, Group) then begin
      for i := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[i], IwbMainRecord, Result) then begin
          Result := Result.HighestOverrideOrSelf[MaxLoadOrder];
          if (Result.Flags._Flags and $000000C0) = $000000C0 then begin
            AV := Result.ElementNativeValues['DATA\Actor Value'];
            if not (VarIsNull(AV) or VarIsEmpty(AV)) then begin
              if AV = aInt then
                Exit;
            end;
          end;
        end;
    end;
    Result := nil;
    for i := Pred(aFile.MasterCount) downto 0 do begin
      Result := CheckFile(aFile.Masters[i]);
      if Assigned(Result) then
        Exit;
    end;
  end;

var
  _File : IwbFile;
begin
  Result := nil;

  if not Assigned(aElement) then
    Exit;

  _File := aElement._File;
  if not Assigned(_File) then
    Exit;

  if aInt < $800 then begin
    CheckedFiles := TList.Create;
    try
      MaxLoadOrder := _File.LoadOrder;
      Result := CheckFile(_File);
    finally
      CheckedFiles.Free;
    end;
  end else try
    Result := _File.RecordByFormID[aInt, True];
  except end;
end;

procedure TwbFormID.FindUsedMasters(aInt: Int64; aMasters: PwbUsedMasters);
var
  OldValue   : Cardinal;
  FileID     : Integer;
begin
  if (aInt < $800) or (aInt = $FFFFFFFF) and IsValid('ACVA') then
    Exit;

  OldValue := aInt;
  if OldValue <> 0 then begin
    FileID := OldValue shr 24;
    aMasters[FileID] := True;
  end;
end;

function TwbFormID.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
var
  _File     : IwbFile;

  FormID    : Cardinal;
  FileID    : Integer;
  NewFileID : Integer;
  i         : Integer;
  s, t      : string;
begin
  s := '';
  t := aValue;
  i := Pos('[', t);
  while i > 0 do begin
    Delete(t, 1, i);
    i := Pos(']', t);
    if i > 0 then begin
      s := Copy(t, 1, Pred(i));
      Delete(t, 1, i);
      if (Length(s) = 13) and (s[5] = ':') then
        Delete(s, 1, 5);
    end;
    if Length(s) = 8 then
      i := 0
    else
      i := Pos('[', t);
  end;

  if Length(s) = 8 then
    Result := StrToInt64('$' + s)
  else begin
    if IsValid('ACVA') and SameText(Trim(aValue), 'None') then begin
      Result := $FF;
      Exit;
    end else
      Result := StrToInt64('$' + aValue);
  end;

  if not wbDisplayLoadOrderFormID then
    Exit;

  if Result < $800 then
    Exit;

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then begin
      FormID := Result;

      FileID := FormID shr 24;
      NewFileID := -1;
      if FileID = _File.LoadOrder then
        NewFileID := _File.MasterCount
      else
        for i := 0 to Pred(_File.MasterCount) do
          if _File.Masters[i].LoadOrder = FileID then begin
            NewFileID := i;
            break;
          end;

      if NewFileID < 0 then
        raise Exception.Create('FormID ['+IntToHex64(FormID, 8)+'] references a master which is not available in file ' + _File.Name);

      FormID := (FormID and $00FFFFFF) or (Cardinal(NewFileID) shl 24);
      Result := FormID;
    end;
  end;
end;

function TwbFormID.GetEditInfo(aInt: Int64; const aElement: IwbElement): string;
var
  ACVAIsValid : Boolean;
  Strings     : TStringList;
  CheckAll    : Boolean;
  Wait        : IwbWaitForm;
  FilesProg   : IwbProgress;

  procedure Process(const aFile: IwbFile);
  var
    i, j        : Integer;
    s           : string;
    MainRecord  : IwbMainRecord;
    GroupRecord : IwbGroupRecord;
    GroupsProg  : IwbProgress;
    RecordsProg : IwbProgress;
  begin
    if CheckAll then begin
      for i := 0 to Pred(aFile.RecordCount) do begin
        MainRecord := aFile.Records[i];
        if IsValid(MainRecord.Signature) and IsValidMainRecord(MainRecord) then begin
          if MainRecord.CanHaveEditorID and (MainRecord.EditorID = '') then
            Continue;

          s := Trim(MainRecord.Name);
          if s <> '' then begin
            if s[1] = '<' then
              Delete(s, 1, 1);

            if CheckFlst(MainRecord) then
              Strings.Add(s);

            if not Assigned(RecordsProg) then
              RecordsProg := Wait.CreateProgress('Records', s, Pred(aFile.RecordCount) )
            else
              RecordsProg.UpdateStatus(i, s);
          end;
        end;

        if Wait.IsCanceled then
          Exit;
      end;
    end else
      for i := 0 to Pred(aFile.ElementCount) do begin

        if not Assigned(GroupsProg) then
          GroupsProg := Wait.CreateProgress('Groups', aFile.Elements[i].Name, Pred(aFile.ElementCount) )
        else
          GroupsProg.UpdateStatus(i, aFile.Elements[i].Name);

        if Supports(aFile.Elements[i], IwbGroupRecord, GroupRecord) then
          if GroupRecord.GroupType = 0 then
            if IsValid(TwbSignature(GroupRecord.GroupLabel)) then
              for j := 0 to Pred(GroupRecord.ElementCount) do begin

                if Supports(GroupRecord.Elements[j], IwbMainRecord, MainRecord) then begin
                  if IsValid(MainRecord.Signature) and IsValidMainRecord(MainRecord) then begin
                    if MainRecord.CanHaveEditorID and (MainRecord.EditorID = '') then
                      Continue;

                    s := Trim(MainRecord.Name);
                    if s <> '' then begin
                      if s[1] = '<' then
                        Delete(s, 1, 1);

                      if CheckFlst(MainRecord) then
                        Strings.Add(s);

                      if not Assigned(RecordsProg) then
                        RecordsProg := Wait.CreateProgress('Records', s, Pred(GroupRecord.ElementCount) )
                      else
                        RecordsProg.UpdateStatus(j, s);

                    end;
                  end;
                end;

                if Wait.IsCanceled then
                  Exit;
              end;

        if Wait.IsCanceled then
          Exit;
      end;
  end;

var
  _File : IwbFile;
  i     : Integer;
  s     : string;
begin
  Result := '';
  if not wbDisplayLoadOrderFormID then
    Exit;

  ACVAIsValid := IsValid('ACVA');

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then begin
      Strings := TwbFastStringListIC.Create;
      try
        CheckAll :=
          IsValid('CELL') or
          IsValid('LAND') or
          IsValid('ROAD') or
          IsValid('REFR') or
          IsValid('ACHR') or
          IsValid('ACRE') or
          IsValid('PGRE') or
          IsValid('PGRD') or
          IsValid('NAVM') or
          IsValid('INFO');

        Wait := wbCreateWaitForm('Building DropDownList', 'The DropDown list is being built. Please Wait...', True, 2000, 500);

        FilesProg := Wait.CreateProgress('Files', _File.Name, _File.MasterCount);
        Process(_File);
        for i := Pred(_File.MasterCount) downto 0 do if not Wait.IsCanceled then begin
          FilesProg.UpdateStatus( _File.MasterCount - i, _File.Masters[i].Name );
          Process(_File.Masters[i]);
        end;

        Wait := nil;
        FilesProg := nil;

        if ACVAIsValid then begin
          for i := 0 to Pred(wbActorValueEnum.NameCount) do
            Strings.Add(wbActorValueEnum.Names[i] + ' [ACVA:' + IntToHex64(i, 8) + ']');
          Strings.Add(' None [ACVA:000000FF]');
          Strings.Add(' Invalid [ACVA:00000048]');
        end else begin
          if IsValid('NULL') then
            Strings.Add('NULL - Null Reference [00000000]');
          if IsValid('TRGT') then
            Strings.Add('TARGET - Target Reference [00000000]');
          if IsValid('PLYR') then
            Strings.Add('Player [00000014]');
        end;

        Strings.Sort;
        s := '';
        for i := Pred(Strings.Count) downto 0 do
          if Strings[i] <> s then
            s := Strings[i]
          else
            Strings.Delete(i);

        Result := Strings.CommaText;
      finally
        FreeAndNil(Strings);
      end;
    end;
  end;
end;

function TwbFormID.GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType;
begin
  Result := etComboBox;
end;

function TwbFormID.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbFormID.GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement;
var
  _File : IwbFile;
begin
  Result := nil;

  if aInt = 0 then
    Exit;
  if aInt = $14 then
    Exit;

  if (aInt < $800) and IsValid('ACVA') then
    Exit;

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then try
      Result := _File.RecordByFormID[aInt, True];
    except end;
  end;
end;

function TwbFormID.IsValid(const aSignature: TwbSignature): Boolean;
begin
  Result := aSignature <> 'ACVA';
end;

function TwbFormID.IsValidFlst(const aSignature: TwbSignature): Boolean;
begin
  Result := True;
end;

function TwbFormID.IsValidMainRecord(const aMainRecord: IwbMainRecord): Boolean;
begin
  Result := True;
end;

function TwbFormID.MasterCountUpdated(aInt: Int64; aOld, aNew: Byte): Int64;
var
  OldValue   : Cardinal;
  NewValue   : Cardinal;
  FileID     : Cardinal;
begin
  OldValue := aInt;
  NewValue := OldValue;

  if (aInt < $800) or (aInt = $FFFFFFFF) and IsValid('ACVA') then begin
    Result := NewValue;
    Exit;
  end;

  if OldValue <> 0 then begin
    FileID := OldValue shr 24;
    if FileID >= aOld then begin
      FileID := aNew;
      NewValue := (OldValue and $00FFFFFF) or (FileID shl 24);
    end;
  end;

  Result := NewValue;
end;

function FixupFormID(aFormID: Cardinal; const aOld, aNew: TBytes): Cardinal;
var
  FileID : Integer;
  i      : Integer;
begin
  Result := aFormID;
  if (Result = 0) or (Result = $14) then
    Exit;
  FileID := aFormID shr 24;
  for i := Low(aOld) to High(aOld) do
    if aOld[i] = FileID then begin
      Result := (aFormID and $00FFFFFF) or (Cardinal(aNew[i]) shl 24);
      Exit;
    end;
end;

function TwbFormID.MasterIndicesUpdated(aInt: Int64; const aOld, aNew: TBytes): Int64;
var
  OldValue   : Cardinal;
  NewValue   : Cardinal;
begin
  OldValue := aInt;
  NewValue := OldValue;

  if (aInt < $800) or (aInt = $FFFFFFFF) and IsValid('ACVA') then begin
    Result := NewValue;
    Exit;
  end;

  if OldValue <> 0 then
    NewValue := FixupFormID(OldValue, aOld, aNew);

  Result := NewValue;
end;

procedure TwbFormID.Report(const aParents: TwbDefPath);
var
  i: Integer;
begin
  if defReported then
    Exit;

  inherited;
  if wbReportMode then
    if wbReportFormIDs then begin
      if Assigned(FoundSignatures) then
        if ClassType = TwbFormID then begin
          WriteLn('Unchecked FormID Formater: ', wbDefsToPath(aParents), wbDefToName(Self));
          WriteLn('  ', FoundSignatures.CommaText);
          for i := 0 to Pred(FoundSignatures.Count) do
            WriteLn('  ', FoundSignatures.Strings[i], ' (', Integer(FoundSignatures.Objects[i]),')');
        end;
      if Assigned(NotResolved) then begin
        WriteLn('FormID contains unresolvable values: ', wbDefsToPath(aParents), wbDefToName(Self));
        for i := 0 to Pred(NotResolved.Count) do
          WriteLn('  ', NotResolved.Strings[i], ' (', Integer(NotResolved.Objects[i]),')');
      end;
      if Assigned(FoundNotAllowedReferences) then begin
        WriteLn('FormID contains not allowed references: ', wbDefsToPath(aParents), wbDefToName(Self));
        for i := 0 to Pred(FoundNotAllowedReferences.Count) do
          WriteLn('  ', FoundNotAllowedReferences.Strings[i], ' (', Integer(FoundNotAllowedReferences.Objects[i]),')');
      end;
    end;

  defReported := True;
end;

function TwbFormID.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
begin
  if wbDisplayLoadOrderFormID then begin
    Result := ToString(aInt, aElement);//ToSortKey(aInt, aElement)
    if (Length(Result) > 0) and (Result[1] = '<') then
      Delete(Result, 1, 1);
  end else
    Result := IntToHex64(aInt, 8);
end;

function TwbFormID.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
var
  _File: IwbFile;
  MainRecord: IwbMainRecord;
begin
  if aInt < $800 then begin
    Result := IntToHex64(aInt, 8);
    Exit;
  end;

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then begin
      try
        MainRecord := _File.RecordByFormID[aInt, True];
        if Assigned(MainRecord) then begin
          Result := IntToHex64(MainRecord.LoadOrderFormID, 8);
          Exit;
        end;
      except
        on E: Exception do begin
          Result := IntToHex64(aInt, 8);
          Exit;
        end;
      end;
    end;
  end;

  Result := IntToHex64(aInt, 8);
end;

function TwbFormID.ToString(aInt: Int64; const aElement: IwbElement): string;
var
  _File      : IwbFile;
  i          : Integer;
  s          : string;
  MainRecord : IwbMainRecord;
begin
  if ((aInt < $800) or (aInt = $FFFFFFFF)) and IsValid('ACVA') then begin
    if (aInt = -1) or (aInt = $FF) or (aInt = $FFFFFFFF) then
      Result := ' None [ACVA:000000FF]'
    else if aInt = $48 then
      Result := ' Invalid [ACVA:00000048]'
    else begin
      MainRecord := FindRecordForAVCode(aInt, aElement);
      if Assigned(MainRecord) then
        Result := MainRecord.FullName
      else
        Result := wbActorValueEnum.ToString(aInt, aElement);
      Result := Result + ' [ACVA:' + IntToHex64(aInt,8) + ']';
    end;
    Exit;
  end;

  if aInt = 0 then begin
    if IsValid('TRGT') and not IsValid('NULL') then begin
      Result := 'TARGET - Target Reference ['+IntToHex64(aInt,8)+']';
      if wbReportMode then
        if wbReportFormIDs then begin
          if not Assigned(FoundSignatures) then
            FoundSignatures := TwbFastStringListCS.CreateSorted;
          if not FoundSignatures.Find('TRGT', i) then
            i := FoundSignatures.Add('TRGT');
          FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));
        end;
    end else begin
      Result := 'NULL - Null Reference ['+IntToHex64(aInt,8)+']';
      if wbReportMode then
        if wbReportFormIDs then begin
          if not Assigned(FoundSignatures) then
            FoundSignatures := TwbFastStringListCS.CreateSorted;
          if not FoundSignatures.Find('NULL', i) then
            i := FoundSignatures.Add('NULL');
          FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));
        end;
    end;
    Used(aElement, Result);
    Exit;
  end else if aInt = $14 then begin
    if wbReportMode then
      if wbReportFormIDs then begin
        if not Assigned(FoundSignatures) then
          FoundSignatures := TwbFastStringListCS.CreateSorted;
        if not FoundSignatures.Find('PLYR', i) then
          i := FoundSignatures.Add('PLYR');
        FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));
      end;

    Result := 'Player ['+IntToHex64(aInt,8)+']';
    Used(aElement, Result);
    Exit;
  end;

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then begin
      try
        MainRecord := _File.RecordByFormID[aInt, True];
        if Assigned(MainRecord) then begin
          Result := MainRecord.Name;
          if wbReportMode then
            if wbReportFormIDs then begin
              if not Assigned(FoundSignatures) then
                FoundSignatures := TwbFastStringListCS.CreateSorted;
              if not FoundSignatures.Find(MainRecord.Signature, i) then
                i := FoundSignatures.Add(MainRecord.Signature);
              FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));
            end;

          if wbReportFormIDNotAllowedReferences and (ClassType = TwbFormIDChecked) then with TwbFormIDChecked(Self) do begin
              if fidcValidRefs.IndexOf(MainRecord.Signature) < 0 then begin
                if not Assigned(FoundNotAllowedReferences) then
                  FoundNotAllowedReferences := TwbFastStringListCS.CreateSorted;
                if not FoundNotAllowedReferences.Find(MainRecord.Name, i) then
                  i := FoundNotAllowedReferences.Add(MainRecord.Name);
                FoundNotAllowedReferences.Objects[i] := TObject(Succ(Integer(FoundNotAllowedReferences.Objects[i])));
              end;
          end;

          Used(aElement, Result);
          Exit;
        end;
      except
        on E: Exception do begin
          Result := '['+IntToHex64(aInt,8)+'] <Error: '+E.Message+'>';
          if wbReportMode then
            if wbReportFormIDs then begin
              if not Assigned(FoundSignatures) then
                FoundSignatures := TwbFastStringListCS.CreateSorted;
              if not FoundSignatures.Find('Error', i) then
                i := FoundSignatures.Add('Error');
              FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));
            end;
          Used(aElement, Result);
          Exit;
        end;
      end;
    end;
  end;

  if aInt < $800 then begin
    s := IntToHex64(aInt,8);
    Result := '['+s+'] <Warning: Could not be resolved, but is possibly hardcoded in the engine>';
    if wbReportMode then
      if wbReportFormIDs then begin
        if not Assigned(FoundSignatures) then
          FoundSignatures := TwbFastStringListCS.CreateSorted;
        if not FoundSignatures.Find('Hardcoded', i) then
          i := FoundSignatures.Add('Hardcoded');
        FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));

        if not Assigned(NotResolved) then
          NotResolved := TwbFastStringListCS.CreateSorted;
        if NotResolved.Count < 50 then begin
          if not NotResolved.Find(s, i) then
            i := NotResolved.Add(s);
          NotResolved.Objects[i] := TObject(Succ(Integer(NotResolved.Objects[i])));
        end;
      end;
  end else begin
    s := IntToHex64(aInt,8);
    Result := '['+s+'] <Error: Could not be resolved>';
    if wbReportMode then
      if wbReportFormIDs then begin
        if not Assigned(FoundSignatures) then
          FoundSignatures := TwbFastStringListCS.CreateSorted;
        if not FoundSignatures.Find('NotResolved', i) then
          i := FoundSignatures.Add('NotResolved');
        FoundSignatures.Objects[i] := TObject(Succ(Integer(FoundSignatures.Objects[i])));

        if not Assigned(NotResolved) then
          NotResolved := TwbFastStringListCS.CreateSorted;
        if NotResolved.Count < 50 then begin
          if not NotResolved.Find(s, i) then
            i := NotResolved.Add(s);
          NotResolved.Objects[i] := TObject(Succ(Integer(NotResolved.Objects[i])));
        end;
      end;
  end;
  Used(aElement, Result);
end;

{ TwbByteArrayDef }

function TwbByteArrayDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  ByteArrayDef: IwbByteArrayDef;
begin
  Result := Supports(aDef, IwbByteArrayDef, ByteArrayDef);
  if Result and (badSize > 0) then begin
    Result := ByteArrayDef.IsVariableSize or (ByteArrayDef.Size[nil, nil, nil] <= Integer(badSize));
  end;
end;

function TwbByteArrayDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

constructor TwbByteArrayDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbByteArrayDef do
    Self.Create(defPriority, defRequired, noName, badSize, noDontShow).defRoot := aSource;
end;

constructor TwbByteArrayDef.Create(aPriority : TwbConflictPriority; aRequired: Boolean;
                             const aName     : string;
                                   aSize     : Cardinal;
                                   aDontShow : TwbDontShowCallback);
begin
  badSize := aSize;
  inherited Create(aPriority, aRequired, aName, nil, nil, aDontShow);
end;

procedure TwbByteArrayDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
var
  Bytes: array of Byte;
  i, j: Integer;
begin
  SetLength(Bytes, Length(aValue) div 2);
  i := 1;
  j := 0;
  while i <= Length(aValue) do begin
    case aValue[i] of
      ' ', ',', ';': {allowed whitespace}
        Inc(i);
      '0'..'9', 'a'..'f', 'A'..'F': begin
        if i = Length(aValue) then
          raise Exception.Create('Unexpected and of value');
        if aValue[Succ(i)] in ['0'..'9', 'a'..'f', 'A'..'F'] then begin
          Bytes[j] := StrToInt('$'+Copy(aValue,i, 2));
          Inc(j);
          Inc(i, 2);
        end else
          raise Exception.Create('"'+aValue[Succ(i)]+'" at position '+IntToStr(Succ(i))+' is not a valid character for ' + GetName);
      end;
    else
      raise Exception.Create('"'+aValue[i]+'" at position '+IntToStr(i)+' is not a valid character for ' + GetName);
    end;
  end;

  SetLength(Bytes, j);

  if (badSize <> 0) then
    SetLength(Bytes, badSize);

  aElement.RequestStorageChange(aBasePtr, aEndPtr, Length(Bytes));

  if Length(Bytes) > 0 then
    Move(Bytes[0], aBasePtr^, Length(Bytes));
end;

procedure TwbByteArrayDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
var
  Bytes: TBytes;
begin
  Bytes := aValue;

  if (badSize <> 0) then
    SetLength(Bytes, badSize);

  aElement.RequestStorageChange(aBasePtr, aEndPtr, Length(Bytes));

  if Length(Bytes) > 0 then
    Move(Bytes[0], aBasePtr^, Length(Bytes));
end;

function TwbByteArrayDef.GetDefType: TwbDefType;
begin
  Result := dtByteArray;
end;

function TwbByteArrayDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbByteArrayDef.GetIsVariableSize: Boolean;
begin
  Result := badSize = 0;
end;

function TwbByteArrayDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := badSize;
  if (Result = 0) and Assigned(aBasePtr) then
    Result := High(Integer);
end;

procedure TwbByteArrayDef.Report(const aParents: TwbDefPath);
var
  FoundOne: Boolean;
  {i,} j, k, l : Integer;
  s: string;
  sl: TStringList;
  BA: TwbByteArrayDef;
begin
  if defReported then
    Exit;

  inherited;
  BA := Self;

  s := wbDefsToPath(aParents) + wbDefToName(Self);

  if (Pos('Hashes', s) < 1) and
     (Pos('SCDA', s) < 1) and
     (Pos('SCTX', s) < 1) and
     (Pos('MODT', s) < 1) and
     (Pos('MO2T', s) < 1) and
     (Pos('MO3T', s) < 1) and
     (Pos('MO4T', s) < 1) and
     (Pos('DMDT', s) < 1) and
     (Pos('NIFT', s) < 1) and
     (Pos('XRGD', s) < 1) and
     (Pos('XCLP', s) < 1) and
     (Pos('RCLR', s) < 1) then begin

    if wbReportUnknownFormIDs then begin
      FoundOne := False;
      with BA do begin
        for j := Low(FoundFormIDAtOffSet) to High(FoundFormIDAtOffSet) do
          if (FoundFormIDAtOffSet[j] > 2) and (NotFoundFormIDAtOffSet[j] = 0) then begin
            if not FoundOne then begin
              FoundOne := True;
              WriteLn('Found FormIDs: ', s);
            end;
            with SignaturesAtOffSet[j] do begin
              WriteLn('  Offset ', j, ': ', Count, ' (', FoundFormIDAtOffSet[j],')');
              for k := 0 to Pred(Count) do begin
                sl := Objects[k] as TStringList;
                WriteLn('    ', Strings[k], ' (', sl.Count,')');
                with sl do
                  for l := 0 to Pred(Count) do
                    WriteLn('      ', Strings[l],' (',Integer(Objects[l]),') ');
              end;
              if Assigned(FormIDsAtOffSetFoundIn[j]) then with FormIDsAtOffSetFoundIn[j] do
                for k := 0 to Pred(Count) do
                  WriteLn('    ', Strings[k]);
            end;
          end;

      end;
    end;

    if wbReportUnknownFloats then begin
      FoundOne := False;
      with BA do begin
        for j := Low(FoundFloatAtOffSet) to High(FoundFloatAtOffSet) do
          if (FoundFloatAtOffSet[j] > 2) and (NotFoundFloatAtOffSet[j] = 0) then begin
            if not FoundOne then begin
              FoundOne := True;
              WriteLn('Found Floats: ', s);
            end;
            with FloatsAtOffSet[j] do begin
              WriteLn('  Offset ', j, ': ', Count, ' (', FoundFloatAtOffSet[j],')');
              for k := 0 to Pred(Count) do
                WriteLn('    ', Strings[k], ' (', Integer(Objects[k]),')');
            end;
          end;
      end;
    end;

  end;

  if wbReportUnknownStrings then
    if (FoundString > 0) and (NotFoundString < 1) then begin
      WriteLn('Found Strings: ', s, ': ',Strings.Count,' (', FoundString, ')');
      with Strings do
        for k := 0 to Pred(Count) do
          WriteLn('  ', Strings[k], ' (', Integer(Objects[k]),')');
    end;

//------------------------------------------------------------------------------
// Added LString Routine
//------------------------------------------------------------------------------
  if wbReportUnknownLStrings then
    if (FoundLString > 0) and (NotFoundLString < 1) then begin
      WriteLn('Found Strings: ', s, ': ',Strings.Count,' (', FoundLString, ')');
      with Strings do
        for k := 0 to Pred(Count) do
          WriteLn('  ', Strings[k], ' (', Integer(Objects[k]),')');
    end;

  if wbReportEmpty then
    if IsEmpty > 0 then
      if IsNotEmpty > 0 then begin
        if wbReportSometimesEmpty then
          WriteLn('Sometimes Empty: ', s, ': ', IsEmpty, ' (Empty) vs. ', IsNotEmpty, ' (not Empty)')
      end else
        WriteLn('Always Empty: ', s, ': ', IsEmpty, ' (Empty) vs. ', IsNotEmpty, ' (not Empty)');

  defReported := True;
end;

function TwbByteArrayDef.ToEditValue(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
begin
  Result := ToString(aBasePtr, aEndPtr, aElement);
end;

function TwbByteArrayDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
var
  Bytes: TBytes;
begin
  SetLength(Bytes, Cardinal(aEndPtr) - Cardinal(aBasePtr));
  if Length(Bytes) > 0 then
    Move(aBasePtr^, Bytes[0], Length(Bytes));
  Result := Bytes;
end;

function CountBits(aCardinal: Cardinal): Integer;
var
  i: Integer;
begin
  Result := 0;
  for I := 0 to 31 do
    if (aCardinal shr i) and 1 = 1 then
      Inc(Result);
end;

function TwbByteArrayDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
var
  p: PByte;
{}  _File: IwbFile;
  MainRecord: IwbMainRecord;
  OffSet: Integer;
  aInt: Cardinal;
// Path : string;
  s: string;
  i: Integer;
  f, f2: Single;
begin
  Result := '';
  p := aBasePtr;
  while Cardinal(p) < Cardinal(aEndPtr) do begin
    Result := Result + IntToHex64(p^, 2) + ' ';
    Inc(p);
  end;
  SetLength(Result, Length(Result) - 1);

  if wbReportMode then begin
    if Assigned(aElement) and (Self.noName <> 'Unused') then begin
      _File := aElement._File;

      if wbReportUnknownFormIDs then begin
        p := aBasePtr;
        OffSet := 0;
        while (Cardinal(p)+3) < Cardinal(aEndPtr) do begin
          aInt := PCardinal(p)^;
          if (aInt <> $0) and (aInt <> $14) and ((Length(NotFoundFormIDAtOffSet) < Succ(OffSet)) or (NotFoundFormIDAtOffSet[Offset] < 1)) then begin
            MainRecord := nil;
            try
              MainRecord := _File.RecordByFormID[aInt, True];
            except
              on E: Exception do begin
                MainRecord := nil;
              end;
            end;
            if Length(FoundFormIDAtOffSet) < Succ(Offset) then
              SetLength(FoundFormIDAtOffSet, Succ(Offset));
            if Length(NotFoundFormIDAtOffSet) < Succ(Offset) then
              SetLength(NotFoundFormIDAtOffSet, Succ(Offset));
            if Length(SignaturesAtOffSet) < Succ(Offset) then
              SetLength(SignaturesAtOffSet, Succ(Offset));
            if Length(FormIDsAtOffSetFoundIn) < Succ(Offset) then
              SetLength(FormIDsAtOffSetFoundIn, Succ(Offset));
            if Assigned(MainRecord) then begin
              if (aInt > $14) and (CountBits(aInt) > 4) then begin
                Inc(FoundFormIDAtOffSet[Offset]);
                if not Assigned(SignaturesAtOffSet[Offset]) then
                  SignaturesAtOffSet[Offset] := TwbFastStringListCS.CreateSorted;
                s := MainRecord.Signature;
                if not SignaturesAtOffSet[Offset].Find(s, i) then
                  i := SignaturesAtOffSet[Offset].AddObject(s, TwbFastStringListCS.CreateSorted);
                s := MainRecord.Name;
                with TStringList(SignaturesAtOffSet[Offset].Objects[i]) do
                  if Find(s, i) then
                    Objects[i] := TObject(Succ(Integer(Objects[i])))
                  else
                    if Count < 10 then
                      AddObject(s, TObject(1));

                if not Assigned(FormIDsAtOffSetFoundIn[Offset]) then
                  FormIDsAtOffSetFoundIn[Offset] := TwbFastStringListCS.CreateSorted(dupIgnore);
                if FormIDsAtOffSetFoundIn[Offset].Count < 50 then
                  FormIDsAtOffSetFoundIn[Offset].Add(aElement.FullPath);
              end;
            end else
              Inc(NotFoundFormIDAtOffSet[Offset]);
          end;
          Inc(p,4);
          Inc(OffSet,4);
        end;
      end;

      if wbReportUnknownFloats then begin
        p := aBasePtr;
        OffSet := 0;
        while (Cardinal(p)+3) < Cardinal(aEndPtr) do begin
          aInt := PCardinal(p)^;
          f := PSingle(p)^;
          if (aInt <> $0) and ((Length(NotFoundFloatAtOffSet) < Succ(OffSet)) or (NotFoundFloatAtOffSet[Offset] < 1)) then begin

            if Length(FoundFloatAtOffSet) < Succ(Offset) then
              SetLength(FoundFloatAtOffSet, Succ(Offset));
            if Length(NotFoundFloatAtOffSet) < Succ(Offset) then
              SetLength(NotFoundFloatAtOffSet, Succ(Offset));
            if Length(FloatsAtOffSet) < Succ(Offset) then
              SetLength(FloatsAtOffSet, Succ(Offset));

            try
              f2 := RoundToEx(f, -3);
              if (f2 <> 0) and (Abs(f-f2) < 0.0002) then begin
                if (f2 > -1000000) and (f2 < 1000000) then begin
                  Inc(FoundFloatAtOffSet[Offset]);

                  if not Assigned(FloatsAtOffSet[Offset]) then
                    FloatsAtOffSet[Offset] := TwbFastStringListCS.CreateSorted;

                  s := FloatToStr(RoundToEx(f,-7));
                  with FloatsAtOffSet[Offset] do if Count < 15 then begin
                    if not Find(s, i) then
                      i := AddObject(s, TObject(0));
                    Objects[i] := TObject(Succ(Integer(Objects[i])));
                  end;
                end;

              end else
                Inc(NotFoundFloatAtOffSet[Offset]);
            except
              Inc(NotFoundFloatAtOffSet[Offset]);
            end;

          end;
          Inc(p,4);
          Inc(OffSet,4);
        end;
      end;

      if wbReportUnknownStrings then begin
        if (badSize < 1) and (NotFoundString < 1) then begin
          p := aBasePtr;
          while (Cardinal(p)) < Cardinal(aEndPtr) do begin
            if p^ < 32 then
              if (Succ(Cardinal(p)) = Cardinal(aEndPtr)) and (p^ = 0) then begin
                s := PAnsiChar(aBasePtr);
                if Length(s) > 4 then begin
                  Inc(FoundString);

                  if not Assigned(Strings) then
                    Strings := TwbFastStringListCS.CreateSorted;

                  with Strings do if Count < 15 then begin
                    if not Find(s, i) then
                      i := AddObject(s, TObject(0));
                    Objects[i] := TObject(Succ(Integer(Objects[i])));
                  end;
                end;
              end else begin
                Inc(NotFoundString);
                Break;
              end;

            Inc(p);
          end;
        end;
      end;
//------------------------------------------------------------------------------
// Added LString Routine
//------------------------------------------------------------------------------
      if wbReportUnknownLStrings then begin
        if (badSize < 1) and (NotFoundLString < 1) then begin
          p := aBasePtr;
          while (Cardinal(p)) < Cardinal(aEndPtr) do begin
            if p^ < 32 then
              if (Succ(Cardinal(p)) = Cardinal(aEndPtr)) and (p^ = 0) then begin
                s := PAnsiChar(aBasePtr);
                if Length(s) > 4 then begin
                  Inc(FoundLString);

                  if not Assigned(Strings) then
                    Strings := TwbFastStringListCS.CreateSorted;

                  with Strings do if Count < 15 then begin
                    if not Find(s, i) then
                      i := AddObject(s, TObject(0));
                    Objects[i] := TObject(Succ(Integer(Objects[i])));
                  end;
                end;
              end else begin
                Inc(NotFoundLString);
                Break;
              end;

            Inc(p);
          end;
        end;
      end;

      if wbReportEmpty then begin
        if (Cardinal(aBasePtr)) < Cardinal(aEndPtr) then
          Inc(IsNotEmpty)
        else
          Inc(IsEmpty);
      end;

    end;
  end;
  Used(aElement, Result);
end;

{ TwbDivDef }

function TwbDivDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
begin
  Result := True;
end;

function TwbDivDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

constructor TwbDivDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbDivDef do
    Self.Create(ddValue).defRoot := aSource;
end;

constructor TwbDivDef.Create(aValue: Integer);
begin
  ddValue := aValue;
  inherited Create(cpNormal, False);
end;

function TwbDivDef.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
begin
  Result := Trunc(StrToFloat(aValue) * ddValue);
end;

function TwbDivDef.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbDivDef.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := FloatToStrF(aInt / ddValue, ffFixed, 99, wbFloatDigits);
end;

function TwbDivDef.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
const
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Result := PlusMinus[aInt < 0] + IntToHex64(Abs(aInt), 16);
end;

function TwbDivDef.ToString(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := FloatToStrF(aInt / ddValue, ffFixed, 99, wbFloatDigits);
  Used(aElement, Result);
end;

{ TwbMulDef }

function TwbMulDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
begin
  Result := True;
end;

function TwbMulDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

constructor TwbMulDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbMulDef do
    Self.Create(mdValue).defRoot := aSource;
end;

constructor TwbMulDef.Create(aValue: Integer);
begin
  mdValue := aValue;
  inherited Create(cpNormal, False);
end;

function TwbMulDef.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
begin
  Result := StrToInt64(aValue) div mdValue;
end;

function TwbMulDef.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbMulDef.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := IntToStr(aInt * mdValue);
end;

function TwbMulDef.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := ''; {handled by integer def}
end;

function TwbMulDef.ToString(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := IntToStr(aInt * mdValue);
  Used(aElement, Result);
end;

{ TwbCallbackDef }

function TwbCallbackDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  CallbackDef: IwbCallbackDef;
begin
  Result := Supports(aDef, IwbCallbackDef, CallbackDef) and
    (@CallbackDef.Callback = @cdToStr);
end;

function TwbCallbackDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

function TwbCallbackDef.Check(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := cdToStr(aInt, aElement, ctCheck);
end;

constructor TwbCallbackDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbCallbackDef do
    Self.Create(cdToStr, cdToInt).defRoot := aSource;
end;

constructor TwbCallbackDef.Create(const aToStr : TwbIntToStrCallback;
                                  const aToInt : TwbStrToIntCallback);
begin
  cdToStr := aToStr;
  cdToInt := aToInt;
  inherited Create(cpNormal, False);
end;

function TwbCallbackDef.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
begin
  if Assigned(cdToInt) then
    Result := cdToInt(aValue, aElement)
  else
    Result := StrToInt64(aValue)
end;

function TwbCallbackDef.GetCallback: TwbIntToStrCallback;
begin
  Result := cdToStr;
end;

function TwbCallbackDef.GetEditInfo(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := cdToStr(aInt, aElement, ctEditInfo);
end;

function TwbCallbackDef.GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType;
var
  s: string;
begin
  Result := etDefault;
  s := cdToStr(aInt, aElement, ctEditType);
  if SameText(s, 'ComboBox') then
    Result := etComboBox
  else if SameText(s, 'CheckComboBox') then
    Result := etCheckComboBox;
end;

function TwbCallbackDef.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbCallbackDef.ToEditValue(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := cdToStr(aInt, aElement, ctToEditValue);
  if Result = '' then
    Result := IntToStr(aInt);
end;

function TwbCallbackDef.ToSortKey(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := cdToStr(aInt, aElement, ctToSortKey);
end;

function TwbCallbackDef.ToString(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := cdToStr(aInt, aElement, ctToStr);
  Used(aElement, Result);
end;

{ TwbValueDef }

procedure TwbValueDef.BuildRef;
begin
  {nothing}
end;

function TwbValueDef.Check(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
begin
  Result := '';
end;

function TwbValueDef.CompareExchangeFormID(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOldFormID, aNewFormID: Cardinal): Boolean;
begin
  {can be overriden}
  Result := False;
end;

procedure TwbValueDef.FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters);
begin
  {can be overriden}
end;

procedure TwbValueDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
begin
  raise Exception.Create(GetName + ' is not editable.');
end;

procedure TwbValueDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
begin
  raise Exception.Create(GetName + ' is not editable.');
end;

function TwbValueDef.GetCanBeZeroSize: Boolean;
begin
  Result := False;
end;

function TwbValueDef.GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := '';
end;

function TwbValueDef.GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType;
begin
  Result := etDefault;
end;

function TwbValueDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := wbIsInternalEdit;
end;

function TwbValueDef.GetIsVariableSize: Boolean;
begin
  Result := False;
end;

function TwbValueDef.GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement;
begin
  Result := nil;
end;

procedure TwbValueDef.MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte);
begin
  {can be overriden}
end;

procedure TwbValueDef.MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes);
begin
  {can be overriden}
end;

function TwbValueDef.SetToDefault(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := False;
  {can be overriden}
end;

function TwbValueDef.ToEditValue(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
begin
  Result := '';
end;

function TwbValueDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
begin
  VarClear(Result);
end;

function TwbValueDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
begin
  Result := ToString(aBasePtr, aEndPtr, aElement);
end;

{ TwbSubRecordStructSKDef }

constructor TwbSubRecordStructSKDef.Clone(const aSource: TwbDef);
var
  SkipSigs : array of TwbSignature;
  i        : Integer;
begin
  with aSource as TwbSubRecordStructSKDef do begin
    if Assigned(srsSkipSignatures) then begin
      SetLength(SkipSigs, srsSkipSignatures.Count);
      for i := 0 to Pred(srsSkipSignatures.Count) do
        SkipSigs[i] := StrToSignature(srsSkipSignatures[i]);
    end;
    Self.Create(defPriority, defRequired, noName, srsMembers, SkipSigs, srsSortKey, srsExSortKey, noDontShow, srsAllowUnordered, noAfterLoad, noAfterSet).defRoot := aSource;
  end;
end;

constructor TwbSubRecordStructSKDef.Create(aPriority  : TwbConflictPriority; aRequired: Boolean;
                                     const aName      : string;
                                     const aMembers   : array of IwbRecordMemberDef;
                                     const aSkipSigs  : array of TwbSignature;
                                     const aSortKey   : array of Integer;
                                     const aExSortKey : array of Integer;
                                           aDontShow  : TwbDontShowCallback;
                                           aAllowUnordered : Boolean;
                                           aAfterLoad      : TwbAfterLoadCallback;
                                           aAfterSet       : TwbAfterSetCallback);
var
  i: Integer;
begin
  SetLength(srsMemberInSK, Length(aMembers));

  SetLength(srsSortKey, Length(aSortKey));
  for i := Low(srsSortKey) to High(srsSortKey) do begin
    Assert( not srsMemberInSK[aSortKey[i]] );
    srsMemberInSK[aSortKey[i]] := True;

    srsSortKey[i] := aSortKey[i];
  end;

  SetLength(srsExSortKey, Length(aExSortKey));
  for i := Low(srsExSortKey) to High(srsExSortKey) do
    srsExSortKey[i] := aExSortKey[i];

  inherited Create(aPriority, aRequired, aName, aMembers, aSkipSigs, aDontShow, aAllowUnordered, aAfterLoad, aAfterSet);
end;

function TwbSubRecordStructSKDef.GetSortKey(aIndex: Integer; aExtended: Boolean): Integer;
begin
  if aIndex <= High(srsSortKey) then
    Result := srsSortKey[aIndex]
  else
    Result := srsExSortKey[aIndex-Length(srsSortKey)];
end;

function TwbSubRecordStructSKDef.GetSortKeyCount(aExtended: Boolean): Integer;
begin
  Result := Length(srsSortKey);
  if aExtended then
    Inc(Result, Length(srsExSortKey));
end;

function TwbSubRecordStructSKDef.IsInSK(aIndex: Integer): Boolean;
begin
  Result := (aIndex >= Low(srsMemberInSK)) and (aIndex <= High(srsMemberInSK)) and srsMemberInSK[aIndex];
end;

{ TwbFormIDChecked }

function TwbFormIDChecked.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  FormIDChecked : IwbFormIDChecked;
  i             : Integer;
  Dummy         : Integer;
begin
  if Supports(aDef, IwbFormIDChecked, FormIDChecked) then begin
    Result := False;
    for i := 0 to Pred(FormIDChecked.SignatureCount) do
      if (FormIDChecked.Signatures[i] <> 'NULL') and (FormIDChecked.Signatures[i] <> 'TRGT') then
        if fidcValidRefs.Find(FormIDChecked.Signatures[i], Dummy) then begin
          Result := True;
          Exit;
        end;
  end else
    Result := inherited CanAssign(aIndex, aDef);
end;

function TwbFormIDChecked.Check(aInt: Int64;
  const aElement: IwbElement): string;
var
  _File: IwbFile;
  MainRecord: IwbMainRecord;
  Found: TwbSignature;
begin
  Result := '';

  if aInt = 0 then begin
    if IsValid('TRGT') and not IsValid('NULL') then begin
      Found := 'TRGT';
      if fidcValidRefs.IndexOf(Found) < 0 then
        Result := 'Found a TRGT reference, expected: ' + fidcValidRefs.CommaText;
    end else begin
      Found := 'NULL';
      if fidcValidRefs.IndexOf(Found) < 0 then
        Result := 'Found a NULL reference, expected: ' + fidcValidRefs.CommaText;
    end;
    Exit;
  end else if aInt = $14 then begin
    Found := 'PLYR';
    if fidcValidRefs.IndexOf(Found) < 0 then
      Result := 'Found a PLYR reference, expected: ' + fidcValidRefs.CommaText;
    Exit;
  end;

  if Assigned(aElement) then begin
    _File := aElement._File;
    if Assigned(_File) then begin
      try
        MainRecord := _File.RecordByFormID[aInt, True];
        if Assigned(MainRecord) then begin
          Found := MainRecord.Signature;
          if fidcValidRefs.IndexOf(Found) < 0 then
            Result := 'Found a '+Found+' reference, expected: ' + fidcValidRefs.CommaText
          else begin
            if fidcPersistent then
              if not MainRecord.WinningOverride.Flags.IsPersistent then begin
                Result := 'Target is not persistent';
                Exit;
              end;
            if not CheckFlst(MainRecord) then
              Result := 'Referenced FLST contains invalid entry';
          end;
          Exit;
        end;
      except
        on E: Exception do begin
          Result := E.Message;
          Exit;
        end;
      end;
    end;
  end;

  if aInt > $800 then
    Result := '['+IntToHex64(aInt,8)+'] <Error: Could not be resolved>';
end;

function TwbFormIDChecked.CheckFlst(const aMainRecord: IwbMainRecord): Boolean;
var
  Container  : IwbContainerElementRef;
  i, j       : Integer;
  MainRecord : IwbMainRecord;
begin
  Result := True;

  if fidcValidFlstRefs.Count < 1 then
    Exit;

  if aMainRecord.Signature <> 'FLST' then
    Exit;

  if Supports(aMainRecord.ElementByName['FormIDs'], IwbContainerElementRef, Container) then
    for i := 0 to Pred(Container.ElementCount) do
      if Supports(Container.Elements[i].LinksTo, IwbMainRecord, MainRecord) then
        if not fidcValidFlstRefs.Find(MainRecord.Signature, j) then begin
          Result := False;
          Exit;
        end;
end;

constructor TwbFormIDChecked.Clone(const aSource: TwbDef);
begin
  with aSource as TwbFormIDChecked do
    Self.Create(fidcValidRefsArr, fidcValidFlstRefsArr, fidcPersistent, fidcNoReach).defRoot := aSource;
end;

constructor TwbFormIDChecked.Create(const aValidRefs     : array of TwbSignature;
                                    const aValidFlstRefs : array of TwbSignature;
                                          aPersistent    : Boolean;
                                          aNoReach       : Boolean);
var
  i: Integer;
begin
  fidcPersistent := aPersistent;
  fidcNoReach := aNoReach;

  fidcValidRefs := TwbFastStringListCS.CreateSorted;
  SetLength(fidcValidRefsArr, Length(aValidRefs));
  for i := Low(aValidRefs) to High(aValidRefs) do begin
    fidcValidRefsArr[i] := aValidRefs[i];
    fidcValidRefs.Add(aValidRefs[i]);
  end;

  fidcValidFlstRefs := TwbFastStringListCS.CreateSorted;
  SetLength(fidcValidFlstRefsArr, Length(aValidFlstRefs));
  for i := Low(aValidFlstRefs) to High(aValidFlstRefs) do begin
    fidcValidFlstRefsArr[i] := aValidFlstRefs[i];
    fidcValidFlstRefs.Add(aValidFlstRefs[i]);
  end;

  inherited Create(cpNormal, False);
end;

destructor TwbFormIDChecked.Destroy;
begin
  FreeAndNil(fidcValidRefs);
  FreeAndNil(fidcValidFlstRefs);
  inherited;
end;

function TwbFormIDChecked.FromEditValue(const aValue: string; const aElement: IwbElement): Int64;
var
  Error: string;
begin
  Result := inherited FromEditValue(aValue, aElement);
  Error := Check(Result, aElement);
  if Error <> '' then
    raise Exception.Create(Error);
end;

function TwbFormIDChecked.GetNoReach: Boolean;
begin
  Result := fidcNoReach;
end;

function TwbFormIDChecked.GetSignature(aIndex: Integer): TwbSignature;
begin
  Result := StrToSignature(fidcValidRefs[aIndex]);
end;

function TwbFormIDChecked.GetSignatureCount: Integer;
begin
  Result := fidcValidRefs.Count;
end;

function TwbFormIDChecked.IsValid(const aSignature: TwbSignature): Boolean;
begin
  Result := fidcValidRefs.IndexOf(aSignature) >= 0;
end;

function TwbFormIDChecked.IsValidFlst(const aSignature: TwbSignature): Boolean;
begin
  Result := (fidcValidFlstRefs.Count = 0) or (fidcValidFlstRefs.IndexOf(aSignature) >= 0);
end;

function TwbFormIDChecked.IsValidMainRecord(const aMainRecord: IwbMainRecord): Boolean;
begin
  Result := not fidcPersistent or aMainRecord.IsPersistent;
end;

procedure TwbFormIDChecked.Report(const aParents: TwbDefPath);
var
  i, j : Integer;
  s    : string;
  Sigs : TStringList;
begin
  if defReported then
    Exit;

  inherited;
  if wbReportMode then
    if wbReportFormIDs and Assigned(FoundSignatures) and (FoundSignatures.Count > 0) then begin
      s := '';

      Sigs := TwbFastStringListCS.CreateSorted;
      try
        Sigs.AddStrings(FoundSignatures);

        for i := 0 to Pred(fidcValidRefs.Count) do
          if Sigs.Find(fidcValidRefs[i], j) then
            Sigs.Delete(j)
          else
            s := s + fidcValidRefs[i] + ',';
        SetLength(s, Pred(Length(s)));

        if not wbReportNotFoundButAllowedFormIDs then
          s := '';

        if (s <> '') or (Sigs.Count > 0) then begin
          WriteLn('Differences in Checked FormID Formater: ', wbDefsToPath(aParents), wbDefToName(Self));
          if s <> '' then
            WriteLn('  Not found but allowed: ', s);
          if Sigs.Count > 0 then begin
            WriteLn('  Found but not allowed: ', Sigs.CommaText);
            for i := 0 to Pred(Sigs.Count) do
              WriteLn('    ', Sigs.Strings[i], ' (', Integer(Sigs.Objects[i]),')');
          end;
        end;
      finally
        Sigs.Free;
      end;
    end;

  defReported := True;
end;

{ TwbIntegerDefFormater }

procedure TwbIntegerDefFormater.BuildRef(aInt: Int64;
  const aElement: IwbElement);
begin
  { nothing }
end;

function TwbIntegerDefFormater.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
begin
  Result := False;
end;

function TwbIntegerDefFormater.Check(aInt: Int64;
  const aElement: IwbElement): string;
begin
  Result := '';
end;

constructor TwbIntegerDefFormater.Clone(const aSource: TwbDef);
begin
  with aSource as TwbIntegerDefFormater do
    Self.Create(defPriority, defRequired).defRoot := aSource;
end;

function TwbIntegerDefFormater.CompareExchangeFormID(var aInt: Int64;
  aOldFormID, aNewFormID: Cardinal; const aElement: IwbElement): Boolean;
begin

end;

procedure TwbIntegerDefFormater.FindUsedMasters(aInt: Int64; aMasters: PwbUsedMasters);
begin
  {can be overriden}
end;

function TwbIntegerDefFormater.FromEditValue(const aValue: string;
  const aElement: IwbElement): Int64;
begin
  raise Exception.Create(Classname + ' does not support editing');
end;

function TwbIntegerDefFormater.GetDefType: TwbDefType;
begin
  Result := dtIntegerFormater;
end;

function TwbIntegerDefFormater.GetEditInfo(aInt: Int64; const aElement: IwbElement): string;
begin
  Result := '';
end;

function TwbIntegerDefFormater.GetEditType(aInt: Int64; const aElement: IwbElement): TwbEditType;
begin
  Result := etDefault;
end;

function TwbIntegerDefFormater.GetIsEditable(aInt: Int64; const aElement: IwbElement): Boolean;
begin
  Result := wbIsInternalEdit;
end;

function TwbIntegerDefFormater.GetLinksTo(aInt: Int64; const aElement: IwbElement): IwbElement;
begin
  Result := nil;
end;

function TwbIntegerDefFormater.MasterCountUpdated(aInt: Int64; aOld, aNew: Byte): Int64;
begin
  Result := aInt;
end;

function TwbIntegerDefFormater.MasterIndicesUpdated(aInt: Int64; const aOld, aNew: TBytes): Int64;
begin
  Result := aInt;
end;

function TwbIntegerDefFormater.ToEditValue(aInt: Int64;
  const aElement: IwbElement): string;
begin
  Result := '';
end;

{ TwbUnionDef }

procedure TwbUnionDef.BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement);
begin
  inherited;
  Decide(aBasePtr, aEndPtr, aElement).BuildRef(aBasePtr, aEndPtr, aElement);
end;

function TwbUnionDef.CanAssign(aIndex: Integer; const aDef: IwbDef): Boolean;
var
  UnionDef : IwbUnionDef;
  i        : Integer;
begin
  if Supports(aDef, IwbUnionDef, UnionDef) then begin
    Result := Equals(aDef);
    if not Result then
      for i := 0 to Pred(UnionDef.MemberCount) do begin
        Result := CanAssign(aIndex, UnionDef.Members[i]);
        if Result then
          Exit;
      end;

  end else begin
    Result := False;
    for i := 0 to Pred(GetMemberCount) do begin
      Result := udMembers[i].CanAssign(aIndex, aDef);
      if Result then
        Exit;
    end;
  end;
end;

function TwbUnionDef.CanContainFormIDs: Boolean;
begin
  Result := ubCanContainFormIDs;
end;

function TwbUnionDef.Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).Check(aBasePtr, aEndPtr, aElement);
end;

constructor TwbUnionDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbUnionDef do
    Self.Create(defPriority, defRequired, noName, udDecider, udMembers, noDontShow).defRoot := aSource;
end;

constructor TwbUnionDef.Create(aPriority : TwbConflictPriority;
                               aRequired : Boolean;
                         const aName     : string;
                               aDecider  : TwbUnionDecider;
                         const aMembers  : array of IwbValueDef;
                               aDontShow : TwbDontShowCallback);
var
  i: Integer;
begin
  inherited Create(aPriority, aRequired, aName, nil, nil, aDontShow);
  udDecider := aDecider;
  SetLength(udMembers, Length(aMembers));
  for I := Low(udMembers) to High(udMembers) do begin
    udMembers[i] := (aMembers[i] as IwbDefInternal).SetParent(Self) as IwbValueDef;
    ubCanContainFormIDs := ubCanContainFormIDs or aMembers[i].CanContainFormIDs;
  end;
end;

function TwbUnionDef.Decide(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbValueDef;
begin
  Result := udMembers[udDecider(aBasePtr, aEndPtr, aElement)];
  Used(nil, '');
end;

procedure TwbUnionDef.FromEditValue(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement; const aValue: string);
begin
  Decide(aBasePtr, aEndPtr, aElement).
    EditValue[aBasePtr, aEndPtr, aElement] := aValue;
end;

procedure TwbUnionDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
begin
  Decide(aBasePtr, aEndPtr, aElement).
    NativeValue[aBasePtr, aEndPtr, aElement] := aValue;
end;

function TwbUnionDef.GetDefType: TwbDefType;
begin
  Result := dtUnion;
end;

function TwbUnionDef.GetEditInfo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).
    EditInfo[aBasePtr, aEndPtr, aElement];
end;

function TwbUnionDef.GetEditType(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): TwbEditType;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).
    EditType[aBasePtr, aEndPtr, aElement];
end;

function TwbUnionDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := wbIsInternalEdit or
    Decide(aBasePtr, aEndPtr, aElement).IsEditable[aBasePtr, aEndPtr, aElement];
end;

function TwbUnionDef.GetIsVariableSize: Boolean;
var
  i, j: Integer;
begin
  Result := False;
  for i := Low(udMembers) to High(udMembers) do begin
    Result := udMembers[i].IsVariableSize;
    if Result then
      Break;
  end;

  if not Result then begin
    j := udMembers[0].Size[nil, nil, nil];
    if j <> 0 then
      for i := 1 to High(udMembers) do
        if udMembers[i].Size[nil, nil, nil] <> j then begin
          j := 0;
        end;
    Result := j > 0;
  end;
end;

function TwbUnionDef.GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).LinksTo[aBasePtr, aEndPtr, aElement];
end;

function TwbUnionDef.GetMember(aIndex: Integer): IwbValueDef;
begin
  Result := udMembers[aIndex];
end;

function TwbUnionDef.GetMemberCount: Integer;
begin
  Result := Length(udMembers);
end;

function TwbUnionDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  i: Integer;
begin
  if not Assigned(aBasePtr) then begin
    Result := udMembers[0].Size[aBasePtr, aEndPtr, aElement];
    if Result <> High(Integer) then
      for i := 1 to High(udMembers) do
        if udMembers[i].Size[aBasePtr, aEndPtr, aElement] <> Result then begin
          if Assigned(aBasePtr) then begin
            Result := High(Integer);
            Exit;
          end else begin
            if Result < udMembers[i].Size[aBasePtr, aEndPtr, aElement] then
              Result := udMembers[i].Size[aBasePtr, aEndPtr, aElement];
          end;
        end;
  end else
     Result := Decide(aBasePtr, aEndPtr, aElement).Size[aBasePtr, aEndPtr, aElement];
end;

procedure TwbUnionDef.Report(const aParents: TwbDefPath);
var
  Parents : TwbDefPath;
  i       : Integer;
begin
  if defReported then
    Exit;

  inherited;
  Parents := aParents;
  SetLength(Parents, Succ(Length(Parents)));
  Parents[High(Parents)].Def := Self;
  for i := Low(udMembers) to High(udMembers) do
    if Assigned(udMembers[i]) then begin
      Parents[High(Parents)].Index := i;
      udMembers[i].Report(Parents);
    end;

  defReported := True;
end;

function TwbUnionDef.ToEditValue(aBasePtr, aEndPtr: Pointer;
  const aElement: IwbElement): string;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).
    EditValue[aBasePtr, aEndPtr, aElement];
end;

function TwbUnionDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).
    NativeValue[aBasePtr, aEndPtr, aElement];
end;

function TwbUnionDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).ToSortKey(aBasePtr, aEndPtr, aElement, aExtended);
end;

function TwbUnionDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := Decide(aBasePtr, aEndPtr, aElement).ToString(aBasePtr, aEndPtr, aElement);
  Used(aElement, Result);
end;

{ TwbEmptyDef }

function TwbEmptyDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

constructor TwbEmptyDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbEmptyDef do
    Self.Create(defPriority, defRequired, noName, noAfterLoad, noAfterSet, noDontShow, edSorted).defRoot := aSource;
end;

constructor TwbEmptyDef.Create(aPriority  : TwbConflictPriority;
                               aRequired  : Boolean;
                         const aName      : string;
                               aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                               aDontShow  : TwbDontShowCallback;
                               aSorted    : Boolean);
begin
  edSorted := aSorted;
  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

procedure TwbEmptyDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
begin
end;

function TwbEmptyDef.GetCanBeZeroSize: Boolean;
begin
  Result := True;
end;

function TwbEmptyDef.GetDefType: TwbDefType;
begin
  Result := dtEmpty;
end;

function TwbEmptyDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbEmptyDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
end;

function TwbEmptyDef.GetSorted: Boolean;
begin
  Result := edSorted;
end;

function TwbEmptyDef.ToSortKey(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aExtended: Boolean): string;
//var
//  NamedDef: IwbNamedDef;
begin
//  Result := GetName;
//  if (Result = '') and Supports(defParent, IwbNamedDef, NamedDef) then
//    Result := NamedDef.Name;
//  if Result = '' then
//    Result := 'Empty';
  Result := '';
end;

function TwbEmptyDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
//var
//  NamedDef: IwbNamedDef;
begin
//  Result := GetName;
//  if (Result = '') and Supports(defParent, IwbNamedDef, NamedDef) then
//    Result := NamedDef.Name;
  Result := '';

  Used(aElement, Result);
end;

{ TwbMainRecordStructFlags }

function TwbMainRecordStructFlags.CantWait: Boolean;
begin
  Result := (_Flags and $00080000) <> 0;
end;

function TwbMainRecordStructFlags.CastsShadows: Boolean;
begin
  Result := (_Flags and $00000200) <> 0;
end;

function TwbMainRecordStructFlags.IsCompressed: Boolean;
begin
  Result := (_Flags and $00040000) <> 0;
end;

function TwbMainRecordStructFlags.IsDangerous: Boolean;
begin
  Result := (_Flags and $00020000) <> 0;
end;

function TwbMainRecordStructFlags.IsDeleted: Boolean;
begin
  Result := (_Flags and $00000020) <> 0;
end;

function TwbMainRecordStructFlags.Islocalized: Boolean;
begin
  Result := (_Flags and $00000080) <> 0;
end;

function TwbMainRecordStructFlags.IsESM: Boolean;
begin
  Result := (_Flags and $00000001) <> 0;
end;

function TwbMainRecordStructFlags.IsIgnored: Boolean;
begin
  Result := (_Flags and $00001000) <> 0;
end;

function TwbMainRecordStructFlags.IsInitiallyDisabled: Boolean;
begin
  Result := (_Flags and $00000800) <> 0;
end;

function TwbMainRecordStructFlags.IsPersistent: Boolean;
begin
  Result := (_Flags and $00000400) <> 0;
end;

function TwbMainRecordStructFlags.IsVisibleWhenDistant: Boolean;
begin
  Result := (_Flags and $00008000) <> 0;
end;

procedure TwbMainRecordStructFlags.SetCompressed(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00040000
  else
    _Flags := _Flags and not $00040000;
end;

procedure TwbMainRecordStructFlags.SetDeleted(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00000020
  else
    _Flags := _Flags and not $00000020;
end;

procedure TwbMainRecordStructFlags.SetESM(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00000001
  else
    _Flags := _Flags and not $00000001;
end;

procedure TwbMainRecordStructFlags.SetLocalized(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00000080
  else
    _Flags := _Flags and not $00000080
end;

procedure TwbMainRecordStructFlags.SetInitiallyDisabled(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00000800
  else
    _Flags := _Flags and not $00000800;
end;

procedure TwbMainRecordStructFlags.SetPersistent(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00000400
  else
    _Flags := _Flags and not $00000400;
end;

procedure TwbMainRecordStructFlags.SetVisibleWhenDistant(aValue: Boolean);
begin
  if aValue then
    _Flags := _Flags or $00008000
  else
    _Flags := _Flags and not $00008000;
end;

{ TwbLenStringDef }

function TwbLenStringDef.CanAssign(aIndex: Integer; const aDef: IwbDef) : Boolean;
begin
  Result := aDef.DefType in [dtString, dtLenString];
end;

function TwbLenStringDef.CanContainFormIDs: Boolean;
begin
  Result := False;
end;

function TwbLenStringDef.Check(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
var
  Size : Cardinal;
  Len  : Cardinal;
begin
  Result := '';
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < Prefix then begin
    if wbCheckExpectedBytes then
      Result := Format('Expected at least %d bytes of data, found %d', [Prefix , Len]);
    Exit;
  end;

  case Prefix of
    1: Size := PByte(aBasePtr)^ + Prefix;
    2: Size := PWord(aBasePtr)^ + Prefix;
    4: Size := PCardinal(aBasePtr)^ + Prefix;
  end;
  if Len < Size then begin
    if wbCheckExpectedBytes then
      Result := Format('Expected %d bytes of data, found %d', [Size , Len]);
  end;
end;

constructor TwbLenStringDef.Clone(const aSource: TwbDef);
begin
  with aSource as TwbLenStringDef do
    Self.Create(defPriority, defRequired, noName, Prefix, noAfterLoad, noAfterSet, noDontShow).defRoot := aSource;
end;

constructor TwbLenStringDef.Create(aPriority  : TwbConflictPriority;
                                   aRequired  : Boolean;
                             const aName      : string;
                                   aPrefix    : Integer;
                                   aAfterLoad : TwbAfterLoadCallback; aAfterSet : TwbAfterSetCallback;
                                   aDontShow  : TwbDontShowCallback);
begin
  Prefix := aPrefix;
  if not (Prefix in [1, 2, 4]) then Prefix := 4;

  inherited Create(aPriority, aRequired, aName, aAfterLoad, aAfterSet,aDontShow);
end;

procedure TwbLenStringDef.FromEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: string);
var
  Len     : Cardinal;
  NewSize : Cardinal;
  p       : Pointer;
  s: AnsiString;
begin
  s := aValue;
  Len := Length(s);
  if (Prefix < 4) and (Len >= Cardinal(1) shl (Prefix*8)) then
    raise Exception.Create('String length overflow');

  NewSize := Len + Prefix;
  aElement.RequestStorageChange(aBasePtr, aEndPtr, NewSize);

  p := aBasePtr;
  case Prefix of
    1: PByte(p)^ := Len;
    2: PWord(p)^ := Len;
    4: PCardinal(p)^ := Len;
  end;
  p := Pointer(Cardinal(p) + Prefix);
  if Len > 1 then
    Move(s[1], p^, Len);
end;

procedure TwbLenStringDef.FromNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: Variant);
begin
  FromEditValue(aBasePtr, aEndPtr, aElement, aValue);
end;

function TwbLenStringDef.GetDefType: TwbDefType;
begin
  Result := dtLenString;
end;

function TwbLenStringDef.GetIsEditable(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function TwbLenStringDef.GetIsVariableSize: Boolean;
begin
  Result := True;
end;

function TwbLenStringDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Len : Integer;
begin
  if Assigned(aBasePtr) then begin
    Result := Cardinal(aEndPtr) - Cardinal(aBasePtr);
    if Result < Prefix then
      Exit;

    case Prefix of
      1: Len := PByte(aBasePtr)^ + Prefix;
      2: Len := PWord(aBasePtr)^ + Prefix;
      4: Len := PCardinal(aBasePtr)^ + Prefix;
    end;

    if Len < Result then
      Result := Len;
  end else
    Result := Prefix;
end;

function TwbLenStringDef.ToEditValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
begin
  Result := ToString(aBasePtr, aEndPtr, aElement);
end;

function TwbLenStringDef.ToNativeValue(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Variant;
begin
  Result := ToString(aBasePtr, aEndPtr, aElement);
end;

function TwbLenStringDef.ToString(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): string;
var
  Size : Cardinal;
  Len  : Cardinal;
  p    : Pointer;
  s    : AnsiString;
begin
  s := '';
  Len := Cardinal(aEndPtr) - Cardinal(aBasePtr);
  if Len < Prefix then
    Exit;

  p := aBasePtr;
  case Prefix of
    1: Size := PByte(aBasePtr)^;
    2: Size := PWord(aBasePtr)^;
    4: Size := PCardinal(aBasePtr)^;
  end;
  p := Pointer(Cardinal(p) + Prefix);
  Dec(Len, Prefix);

  if Len > Size then
    Len := Size;

  SetLength(s, Len);
  if Len > 0 then
    Move(p^, s[1], Len);
  Result := s;
  Used(aElement, Result);
end;

{ TwbFastStringList }

procedure TwbFastStringList.Clear(aFreeObjects: Boolean);
var
  i: Integer;
begin
  if aFreeObjects then
    for i := 0 to Pred(Count) do
      Objects[i].Free;
  inherited Clear;
end;

function TwbFastStringList.CompareStrings(const S1, S2: string): Integer;
begin
  {$IFDEF DCC6OrLater}
  if CaseSensitive then
    Result := CompareStr(S1, S2)
  else
  {$ENDIF}
    Result := CompareText(S1, S2);
end;

constructor TwbFastStringList.CreateSorted(aDups: TDuplicates);
begin
  Create;
  Duplicates := aDups;
  Sorted := True;
end;

{ TwbFastStringListCS }

procedure TwbFastStringListCS.AfterConstruction;
begin
  inherited;
  {$IFDEF DCC6OrLater}
  CaseSensitive := True;
  {$ENDIF}
end;

{ TwbStringLCDef }

function TwbStringLCDef.TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString;
begin
  Result := LowerCase(s);
end;

{ TwbLString }

procedure TwbLStringDef.FromStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aValue: AnsiString);
begin
  if aElement._File.IsLocalized then
    raise Exception.Create('Can not assign to a localized string')
  else
    inherited FromStringNative(aBasePtr, aEndPtr, aElement, aValue);
end;

function TwbLStringDef.GetSize(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  if aElement._File.IsLocalized then
    Result := 4
  else
    Result := inherited GetSize(aBasePtr, aEndPtr, aElement);
end;

function TwbLStringDef.ToStringNative(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): AnsiString;
begin
  if aElement._File.IsLocalized then
    Result := GetLocalizedValue(PCardinal(aBasePtr)^, aElement)
  else
    Result := inherited ToStringNative(aBasePtr, aEndPtr, aElement);
end;

{ TwbStringScriptDef }

function TwbStringScriptDef.TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString;
var
  i: Integer;
begin
  if aTransformType = ttToSortKey then begin
    with TStringList.Create do try
      Text := s;
      for i := Pred(Count) downto 0 do begin
        Strings[i] := Trim(Strings[i]);
        if Strings[i] = '' then
          Delete(i);
      end;
      Result := Text;
    finally
      Free;
    end;
  end else
    Result := s;
end;

{ TwbStringMgefCodeDef }

procedure TwbStringMgefCodeDef.BuildRef(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement);
var
  _File : IwbFile;
  Rec   : IwbMainRecord;
begin
  _File := aElement._File;
  if Assigned(_File) then begin
    Rec := _File.RecordByEditorID[ToStringTransform(aBasePtr, aEndPtr, aElement, ttToSortKey)];
    if Assigned(Rec) then
      aElement.AddReferencedFromID(Rec.LoadOrderFormID);
  end;
end;

function TwbStringMgefCodeDef.CanContainFormIDs: Boolean;
begin
  Result := True;
end;

procedure TwbStringMgefCodeDef.FindUsedMasters(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aMasters: PwbUsedMasters);
var
  s        : AnsiString;
  MgefCode : PCardinal;
  i        : Integer;
begin
  s := ToStringNative(aBasePtr, aEndPtr, aElement);

  if Length(s) <> 4 then
    Exit;

  MgefCode := PCardinal(@s[1]);

  if (MgefCode^ and $80000000) <> 0 then
    { yes, it's a dynamic code }
    aMasters[(MgefCode^ and $000000FF)] := True;
end;

function TwbStringMgefCodeDef.GetLinksTo(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement): IwbElement;
var
  _File : IwbFile;
begin
  Result := nil;
  _File := aElement._File;
  if Assigned(_File) then
    Result := _File.RecordByEditorID[ToStringTransform(aBasePtr, aEndPtr, aElement, ttToSortKey)];
end;

procedure TwbStringMgefCodeDef.MasterCountUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; aOld, aNew: Byte);
var
  s        : AnsiString;
  MgefCode : PCardinal;
begin
  s := ToStringNative(aBasePtr, aEndPtr, aElement);

  if Length(s) <> 4 then
    Exit;

  MgefCode := PCardinal(@s[1]);

  if (MgefCode^ and $80000000) <> 0 then
    { yes, it's a dynamic code }
    if (MgefCode^ and $000000FF) >= aOld then begin
      { yes, it refers to this file }
      MgefCode^ := (MgefCode^ and $FFFFFF00) or aNew;
      FromStringNative(aBasePtr, aEndPtr, aElement, s);
      aElement.NotifyChanged;
    end;
end;

procedure TwbStringMgefCodeDef.MasterIndicesUpdated(aBasePtr, aEndPtr: Pointer; const aElement: IwbElement; const aOld, aNew: TBytes);
var
  s        : AnsiString;
  MgefCode : PCardinal;
  i        : Integer;
begin
  s := ToStringNative(aBasePtr, aEndPtr, aElement);

  if Length(s) <> 4 then
    Exit;

  MgefCode := PCardinal(@s[1]);

  Assert(Length(aOld) = Length(aNew));
  if (MgefCode^ and $80000000) <> 0 then
    { yes, it's a dynamic code }
    for i := Low(aOld) to High(aOld) do
      if (MgefCode^ and $000000FF) = aOld[i] then begin
        { yes, it refers to this file }
        MgefCode^ := (MgefCode^ and $FFFFFF00) or aNew[i];
        FromStringNative(aBasePtr, aEndPtr, aElement, s);
        aElement.NotifyChanged;
        Exit;
      end;
end;

function TwbStringMgefCodeDef.TransformString(const s: AnsiString; aTransformType: TwbStringTransformType; const aElement: IwbElement): AnsiString;
var
  IsAlpha  : Boolean;
  i, j     : Integer;
  MgefCode : Cardinal;
  _File    : IwbFile;
  FileID   : Byte;
  t        : AnsiString;
begin
  case aTransformType of
    ttToString, ttToSortKey, ttToEditValue, ttToNativeValue: begin
      Result := s;
      if Length(s) = 4 then begin
        IsAlpha := True;
        for i := 1 to 4 do
          if not(s[i] in ['a'..'z', 'A'..'Z', '0'..'9', '_']) then begin
            IsAlpha := False;
            break;
          end;
        if not IsAlpha then begin
          MgefCode := PCardinal(@s[1])^;
          if (MgefCode and $80000000) <> 0 then begin
            if Assigned(aElement) then begin
              _File := aElement._File;
              if Assigned(_File) then begin
                FileID := MgefCode and $000000FF;

                if FileID >= _File.MasterCount then
                  Result := _File.Name
                else
                  Result := _File.Masters[FileID].Name;

                Result := Result + ':' + IntToStr((MgefCode and not $800000FF) shr 8);

                Exit;
              end;
            end;
          end;
          Result := IntToHex64(MgefCode, 8);
          if aTransformType = ttToString then
            Result := Result + ' <Warning: Effect Code is neither alphanumeric nor dynamic>';
        end;
      end else if aTransformType = ttToString then
        Result := Result + ' <Warning: Expected 4 bytes but found ' + IntToStr(Length(s)) + '>';
    end;
    ttFromEditValue, ttFromNativeValue: begin
      Result := Trim(s);
      i := Pos(':', Result);
      if i > 0 then begin

        t := Copy(Result, 1, Pred(i));

        FileID := $FF;

        if Assigned(aElement) then begin
          _File := aElement._File;
          if Assigned(_File) then begin
            if SameText(t, _File.FileName) then
              FileID := _File.MasterCount
            else if SameText(t, _File.Name) then
              FileID := _File.MasterCount
            else begin
              for j := 0 to Pred(_File.MasterCount) do
                if SameText(t, _File.Masters[j].Name) then begin
                  FileID := j;
                  break;
                end;
              if FileID = $FF then
                for j := 0 to Pred(_File.MasterCount) do
                  if SameText(t, _File.Masters[j].FileName) then begin
                    FileID := j;
                    break;
                  end;
            end;
          end;
        end;

        if FileID = $FF then begin
          if i > 1 then
            FileID := StrToInt('$' + t);

          if Assigned(aElement) then begin
            _File := aElement._File;
            if Assigned(_File) then
              if FileID = $FF then
                FileID := _File.MasterCount
              else
                FileID := _File.LoadOrderFileIDtoFileFileID(FileID);
          end;
        end;

        t := Copy(Result, Succ(i), High(Integer));
        MgefCode := StrToInt(t);
        if MgefCode > $7FFFFF then
          raise Exception.Create('"'+t+'" exceeds the maximum value for a dynamic magic effect code');
        MgefCode := (MgefCode shl 8) or $80000000;

        MgefCode := MgefCode or FileID;

      end else if Length(Result) = 8 then begin

        MgefCode := StrToInt('$' + Result);
        if (MgefCode and $80000000) <> 0 then
          raise Exception.Create('"'+Result+'" is not a valid magic effect code');

      end else if Length(s) = 4 then begin

        IsAlpha := True;
        for i := 1 to 4 do
          if not(s[i] in ['a'..'z', 'A'..'Z', '0'..'9', '_']) then begin
            IsAlpha := False;
            break;
          end;
        if not IsAlpha then
          raise Exception.Create('"'+Result+'" is not a valid magic effect code');
        MgefCode := PCardinal(@Result[1])^;

      end else
        raise Exception.Create('"'+Result+'" is not a valid magic effect code');

      SetLength(Result, 4);
      PCardinal(@Result[1])^ := MgefCode;
    end;
  end;
end;

initialization
  TwoPi := 2 * OnePi;

  if (DebugHook = 0) then
    wbReportMode := False;

  wbIgnoreRecords := TStringList.Create;
  wbIgnoreRecords.Sorted := True;
  wbIgnoreRecords.Duplicates := dupIgnore;
end.
