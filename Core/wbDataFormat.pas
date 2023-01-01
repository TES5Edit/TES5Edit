{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDataFormat;

//{$DEFINE DFDEBUG}

interface

uses
  SysUtils, StrUtils, Classes, Windows, Math, Variants, JsonDataObjects;

type
  TdfDataType = (
    dtNone,
    dtStruct,
    dtArray,
    dtUnion,
    dtMerge,
    dtBytes,
    dtChars,
    dtU8,
    dtS8,
    dtU16,
    dtS16,
    dtU32,
    dtS32,
    dtU64,
    dtS64,
    dtFloat16,
    dtFloat32
  );

  TdfResourceOpenDataCallback = function(const aContainerName, aFileName: string): TBytes;

const
  // embedded value size
  // values that fit don't allocate memory (for optimization)
  dfEmbeddedValueSize = 8;

  DefSizes: array [TdfDataType] of integer = (
    0,  // dtNone
    0,  // dtStruct
    0,  // dtArray
    0,  // dtUnion
    0,  // dtMerge
    0,  // dtBytes
    0,  // dtChars
    1,  // dtU8
    1,  // dtS8
    2,  // dtU16
    2,  // dtS16
    4,  // dtU32
    4,  // dtS32
    8,  // dtU64
    8,  // dtS64
    2,  // dtFloat16
    4   // dtFloat32
  );

  DF_OnCreate = 1;
  DF_OnDestroy = 2;
  DF_OnGetEnabled = 3;
  DF_OnDecide = 4;
  DF_OnAfterLoad = 5;
  DF_OnBeforeSave = 6;
  DF_OnGetValue = 11;
  DF_OnSetValue = 12;
  DF_OnGetText = 13;
  DF_OnSetText = 14;
  DF_OnGetCount = 15;
  DF_OnSetCount = 16;
  DF_OnLinksTo = 17;

  sFlagsDelimiter = '|';
  sFloatByte128 = '0.501961';

var
  dfFloatDecimalDigits: Integer = 6;
  dfResourceGetDataCallback: TdfResourceOpenDataCallback = nil;

type
  TdfDataState = (
    dsInitialized,
    dsEnabled,
    dsUpdating,
    dsDeciding,
    dsDestroying
  );
  TdfDataStates = set of TdfDataState;

  TdfElement = class;
  TdfElements = array of TdfElement;
  TdfDef = class;
  TdfDefs = array of TdfDef;

  TdfOnCreateEvent = procedure(const aElement: TdfElement);
  TdfOnDestroyEvent = procedure(const aElement: TdfElement);
  TdfOnEnabledEvent = function(const aElement: TdfElement): Boolean;
  TdfOnDecideEvent = function(const aElement: TdfElement): Integer;
  TdfOnAfterLoadEvent = procedure(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
  TdfOnBeforeSaveEvent = procedure(const aElement: TdfElement);
  TdfOnValueEvent = procedure(const aElement: TdfElement; var aValue: Variant);
  TdfOnTextEvent = procedure(const aElement: TdfElement; var aText: string);
  TdfOnCountEvent = procedure(const aElement: TdfElement; var aCount: Integer);
  TdfOnLinksToEvent = function(const aElement: TdfElement): TdfElement;

  TdfDef = class
  private
    FName: string;
    FNameHash: Cardinal;
    FDataType: TdfDataType;
    FDefs: TdfDefs;
    FDefaultValue: string;
    FSize: integer;
    FOnCreate: TdfOnCreateEvent;
    FOnDestroy: TdfOnDestroyEvent;
    FOnGetEnabled: TdfOnEnabledEvent;
    FOnDecide: TdfOnDecideEvent;
    FOnAfterLoad: TdfOnAfterLoadEvent;
    FOnBeforeSave: TdfOnBeforeSaveEvent;
    FOnGetValue: TdfOnValueEvent;
    FOnSetValue: TdfOnValueEvent;
    FOnGetText: TdfOnTextEvent;
    FOnSetText: TdfOnTextEvent;
    FOnGetCount: TdfOnCountEvent;
    FOnSetCount: TdfOnCountEvent;
    FOnLinksTo: TdfOnLinksToEvent;
  protected
    function GetDefaultDataSize: integer; virtual;
  public
    constructor Create(const aName: string; aDataType: TdfDataType; const aDefs: array of TdfDef);
    destructor Destroy; override;
    function Clone: TdfDef; virtual; abstract;
    procedure Assign(const aDef: TdfDef); virtual;
    function CalcHash(const s: string): Cardinal;
    procedure AssignEvents(const aEvents: array of const);
    function CreateElement(const aParent: TdfElement): TdfElement; virtual;
    procedure GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); virtual;
    procedure SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); virtual;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); virtual;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); virtual;
    procedure AddDef(const aDef: TdfDef);
    procedure InsertDefsFrom(const aDef: TdfDef; Index: Integer);
    property Name: string read FName;
    property NameHash: Cardinal read FNameHash;
    property DataType: TdfDataType read FDataType;
    property DefaultDataSize: integer read GetDefaultDataSize;
    property Defs: TdfDefs read FDefs;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property Size: integer read FSize write FSize;
    property OnCreate: TdfOnCreateEvent read FOnCreate write FOnCreate;
    property OnDestroy: TdfOnDestroyEvent read FOnDestroy write FOnDestroy;
    property OnGetEnabled: TdfOnEnabledEvent read FOnGetEnabled write FOnGetEnabled;
    property OnDecide: TdfOnDecideEvent read FOnDecide write FOnDecide;
    property OnAfterLoad: TdfOnAfterLoadEvent read FOnAfterLoad write FOnAfterLoad;
    property OnBeforeSave: TdfOnBeforeSaveEvent read FOnBeforeSave write FOnBeforeSave;
    property OnGetValue: TdfOnValueEvent read FOnGetValue write FOnGetValue;
    property OnSetValue: TdfOnValueEvent read FOnSetValue write FOnSetValue;
    property OnGetText: TdfOnTextEvent read FOnGetText write FOnGetText;
    property OnSetText: TdfOnTextEvent read FOnSetText write FOnSetText;
    property OnGetCount: TdfOnCountEvent read FOnGetCount write FOnGetCount;
    property OnSetCount: TdfOnCountEvent read FOnSetCount write FOnSetCount;
    property OnLinksTo: TdfOnLinksToEvent read FOnLinksTo write FOnLinksTo;
  end;

  TdfElement = class
  private
    FDef: TdfDef;
    FState: TdfDataStates;
    FParent: TdfElement;
    FUserData: Integer;
  protected
    function GetDef: TdfDef; virtual;
    function GetName: string; virtual;
    function GetNameHash: Cardinal;
    function GetDataType: TdfDataType;
    function GetDefaultDataSize: integer; virtual;
    function GetCount: Integer; virtual;
    procedure SetCount(NewCount: Integer); virtual;
    function Get(Index: Integer): TdfElement; virtual;
    procedure Put(Index: Integer; const aElement: TdfElement); virtual;
    function GetEnabled: Boolean;
    procedure SetEnabled(aEnabled: Boolean);
    function GetInitialized: Boolean;
    function GetNativeValue: Variant; virtual;
    procedure SetNativeValue(const aValue: Variant); virtual;
    function GetEditValue: string; virtual;
    procedure SetEditValue(const aValue: string); virtual;
    function GetNativeValues(const aPath: string): Variant; virtual;
    procedure SetNativeValues(const aPath: string; const aValue: Variant); virtual;
    function GetEditValues(const aPath: string): string; virtual;
    procedure SetEditValues(const aPath: string; const aValue: string); virtual;
    function EnabledElementByPath(const aPath: string): TdfElement;
    function ActiveIndex: Integer; // for Unions
  public
    constructor Create(const aDef: TdfDef; const aParent: TdfElement); virtual;
    destructor Destroy; override;
    procedure DoException(const aMessage: string);
    function ValidateData(const aDataStart, aDataEnd: Pointer; aSize: Integer): Boolean;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; virtual;
    function Serialize(const aDataStart, aDataEnd: Pointer): Integer; virtual;
    procedure UnSerializeFromJSON(const aJSON: TJSONBaseObject); virtual;
    procedure SerializeToJSON(const aJSON: TJSONBaseObject); virtual;
    procedure LoadFromData(const aData: TBytes); virtual;
    procedure LoadFromFile(const aFileName: string);
    procedure LoadFromJSONFile(const aFileName: string);
    procedure LoadFromResource(const aContainerName, aFileName: string); overload;
    procedure LoadFromResource(const aFileName: string); overload;
    procedure SaveToData(var aData: TBytes); virtual;
    procedure SaveToFile(const aFileName: string);
    procedure SaveToJSONFile(const aFileName: string; aCompact: Boolean);
    procedure SetToDefault;
    procedure Assign(const aElement: TdfElement); virtual;
    function ToJSON(aCompact: Boolean): string; virtual;
    procedure FromJSON(const aText: string); virtual;
    function ToText(aIdent: Integer = 0): string; virtual;
    function Updating: Boolean; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
    function DataSize: Integer; virtual;
    function Path: string;
    function Root: TdfElement;
    function Add: TdfElement; virtual;
    procedure Delete(Index: Integer); virtual;
    procedure Remove; virtual;
    procedure Move(CurIndex, NewIndex: Integer); virtual;
    function Index: Integer; virtual;
    function IndexOf(aElement: TdfElement): Integer; virtual;
    function LinksTo: TdfElement; virtual;
    function ElementByName(const aName: string; aEnabledOnly: Boolean = True): TdfElement; virtual;
    function ElementByPath(const aPath: string; aEnabledOnly: Boolean = True): TdfElement; virtual;
    property Def: TdfDef read GetDef;// write FDef;
    property Parent: TdfElement read FParent write FParent;
    property Name: string read GetName;
    property NameHash: Cardinal read GetNameHash;
    property DataType: TdfDataType read GetDataType;
    property DataState: TdfDataStates read FState;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Initialized: Boolean read GetInitialized;
    property Count: Integer read GetCount write SetCount;
    property NativeValue: Variant read GetNativeValue write SetNativeValue;
    property NativeValues[const aPath: string]: Variant read GetNativeValues write SetNativeValues;
    property EditValue: string read GetEditValue write SetEditValue;
    property EditValues[const aPath: string]: string read GetEditValues write SetEditValues;
    property Items[Index: Integer]: TdfElement read Get; default;
    property Elements[const aPath: string]: TdfElement read EnabledElementByPath;
    property UserData: Integer read FUserData write FUserData;
  end;


  { Generic value }
  TdfValueDef = class(TdfDef);

  TdfValue = class(TdfElement)
  private
    FValue: array [0..dfEmbeddedValueSize-1] of Byte;
    FDataStart: PByte;
    FDataEnd: PByte;
  protected
    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;
    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;
  public
    procedure AllocateValue(var aDataStart, aDataEnd: PByte; aLength: Integer); overload;
    procedure AllocateValue(aLength: Integer); overload;
    destructor Destroy; override;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    function Serialize(const aDataStart, aDataEnd: Pointer): Integer; override;
    procedure UnSerializeFromJSON(const aJSON: TJSONBaseObject); override;
    procedure SerializeToJSON(const aJSON: TJSONBaseObject); override;
    procedure Assign(const aElement: TdfElement); override;
    function DataSize: Integer; override;
    property DataStart: PByte read FDataStart;
  end;


  { Generic container }
  TdfContainer = class(TdfElement)
  private
    FElements: TdfElements;
    FCount: Integer;
  protected
    procedure Clear;
    function GetCapacity: Integer;
    procedure SetCapacity(NewCapacity: Integer);
    function GetCount: Integer; override;
    procedure SetCount(NewCount: Integer); override;
    function Get(Index: Integer): TdfElement; override;
    procedure Put(Index: Integer; const aElement: TdfElement); override;
  public
    destructor Destroy; override;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    function Serialize(const aDataStart, aDataEnd: Pointer): Integer; override;
    function DataSize: integer; override;
    procedure Delete(Index: Integer); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
    function IndexOf(aElement: TdfElement): integer; override;
    function ElementByName(const aName: string; aEnabledOnly: Boolean = True): TdfElement; override;
    property Capacity: Integer read GetCapacity write SetCapacity;
  end;


  { Structure }
  TdfStructDef = class(TdfDef)
  public
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
  end;

  TdfStruct = class(TdfContainer)
  protected
    procedure SetCount(NewCount: Integer); override; // exception
  public
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    procedure UnSerializeFromJSON(const aJSON: TJSONBaseObject); override;
    procedure SerializeToJSON(const aJSON: TJSONBaseObject); override;
    procedure Assign(const aElement: TdfElement); override;
    procedure Delete(Index: Integer); override; // exception
    procedure Move(CurIndex, NewIndex: Integer); override; // exception
  end;


  { Array }
  TdfArrayDef = class(TdfDef)
  private
    FCounter: string;
  public
    function Clone: TdfDef; override;
    procedure Assign(const aDef: TdfDef); override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    property Counter: string read FCounter write FCounter;
  end;

  TdfArray = class(TdfContainer)
  protected
    function GetExternalCount: Integer;
    procedure SetExternalCount(NewCount: Integer);
    procedure SetCount(NewCount: Integer); override;
  public
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    function Serialize(const aDataStart, aDataEnd: Pointer): Integer; override;
    procedure UnSerializeFromJSON(const aJSON: TJSONBaseObject); override;
    procedure SerializeToJSON(const aJSON: TJSONBaseObject); override;
    procedure Assign(const aElement: TdfElement); override;
    function DataSize: integer; override;
    function Add: TdfElement; override;
    procedure Delete(Index: Integer); override;
  end;


  { Union - several different size values but only one is active chosen by decider callack }
  TdfUnionDef = class(TdfValueDef)
  public
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
  end;

  TdfUnion = class(TdfContainer)
  protected
    function GetDef: TdfDef; override;
    function GetCount: Integer; override; // always 0
    procedure SetCount(NewCount: Integer); override; // do nothing
    // redirect to the active element
    function GetNativeValue: Variant; override;
    procedure SetNativeValue(const aValue: Variant); override;
    function GetEditValue: string; override;
    procedure SetEditValue(const aValue: string); override;
    function GetNativeValues(const aPath: string): Variant; override;
    procedure SetNativeValues(const aPath: string; const aValue: Variant); override;
    function GetEditValues(const aPath: string): string; override;
    procedure SetEditValues(const aPath: string; const aValue: string); override;
  public
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    function Serialize(const aDataStart, aDataEnd: Pointer): Integer; override;
    procedure UnSerializeFromJSON(const aJSON: TJSONBaseObject); override;
    procedure SerializeToJSON(const aJSON: TJSONBaseObject); override;
    procedure Assign(const aElement: TdfElement); override;
    function DataSize: Integer; override;
  end;


  {
    Value Union  - same size value but different definitions chosen in OnGetDef by decider callback
    Do not use with flags, no access to individual flags by name, only as a whole value
  }
  TdfValueUnionDef = class(TdfValueDef)
  public
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
  end;

  TdfValueUnion = class(TdfValue)
  protected
    function GetDef: TdfDef; override;
  end;


  {
    Merge - several fixed size values are treated as a single element
    Native Value is an array of bytes
    Edit Value consists of delimited individual values
    Each value can be accessed by name 'X' or index '0'
  }
  TdfMergeDef = class(TdfValueDef)
  private
    // offset and size of each value
    FOffsets: array of record
      Offset: Integer;
      DataSize: Integer;
    end;
    FDelimiter: string;
    procedure UpdateOffsets;
  protected
    function GetDefaultDataSize: Integer; override;
    function GetValueOffset(aIndex: Integer): Integer;
    function GetValueDataSize(aIndex: Integer): Integer;
  public
    constructor Create(const aName: string; aDataType: TdfDataType; const aDefs: array of TdfDef);
    function Clone: TdfDef; override;
    procedure Assign(const aDef: TdfDef); override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    procedure GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    property Delimiter: string read FDelimiter write FDelimiter;
    property ValueOffset[Index: Integer]: Integer read GetValueOffset;
    property ValueDataSize[Index: Integer]: Integer read GetValueDataSize;
  end;

  TdfMerge = class(TdfValue)
    // disable looping callback check
    function Updating: Boolean; override;
    // apply default values of individual elements
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    // override to access by name or index as a virtual child element
    function GetNativeValues(const aPath: string): Variant; override;
    procedure SetNativeValues(const aPath: string; const aValue: Variant); override;
    function GetEditValues(const aPath: string): string; override;
    procedure SetEditValues(const aPath: string; const aValue: string); override;
  end;


  { Integer }
  TdfIntegerDef = class(TdfValueDef)
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    procedure GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
  end;

  TdfInteger = class(TdfValue);


  { Mapped Integer: flags, enums }
  TMappedValue = record
    Key: Int64;
    Value: String;
  end;

  TdfMappedIntegerDef = class(TdfIntegerDef)
  private
    FValuesMap: array of TMappedValue;
    function GetValuesMapCount: Integer;
    function IndexOfKey(const aKey: Int64): integer;
    function IndexOfValue(const aValue: string): integer;
    function GetKey(Index: integer): Int64;
    function GetValue(Index: integer): string;
    function GetValueByKey(Key: Int64): string;
  public
    function Clone: TdfDef; override;
    procedure Assign(const aDef: TdfDef); override;
    procedure AssignValuesMap(const aValuesMap: array of const); virtual;
    property ValuesMapCount: Integer read GetValuesMapCount;
    property Keys[Index: integer]: Int64 read GetKey;
    property Values[Index: integer]: string read GetValue;
    property KeyValues[Key: Int64]: string read GetValueByKey;
  end;


  { Flags }
  TdfFlagsDef = class(TdfMappedIntegerDef)
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    procedure AssignValuesMap(const aValuesMap: array of const); override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
  end;

  TdfFlags = class(TdfInteger)
  protected
    // override to access by flag name as a virtual child element
    function GetNativeValues(const aPath: string): Variant; override;
    procedure SetNativeValues(const aPath: string; const aValue: Variant); override;
    function GetEditValues(const aPath: string): string; override;
    procedure SetEditValues(const aPath: string; const aValue: string); override;
  end;


  { Enum }
  TdfEnumDef = class(TdfMappedIntegerDef)
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    function Clone: TdfDef; override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
  end;

  TdfEnum = class(TdfInteger);


  { Float }
  TdfFloatDef = class(TdfValueDef)
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    procedure GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
  end;

  TdfFloat = class(TdfValue);


  { Bytes }
  TdfBytesDef = class(TdfValueDef)
  protected
    function GetDefaultDataSize: integer; override;
  public
    function Clone: TdfDef; override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    procedure GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
  end;

  TdfBytes = class(TdfValue)
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
  end;


  { Chars }
  TdfCharsDef = class(TdfValueDef)
  private
    FTerminator: AnsiChar;
    FTerminated: Boolean;
  protected
    function GetDefaultDataSize: integer; override;
  public
    function Clone: TdfDef; override;
    procedure Assign(const aDef: TdfDef); override;
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    procedure GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant); override;
    procedure GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    procedure SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string); override;
    property Terminator: AnsiChar read FTerminator write FTerminator;
    property Terminated: Boolean read FTerminated write FTerminated;
  end;

  TdfChars = class(TdfValue)
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    function ReadChars(const aDataStart, aDataEnd: Pointer; var aString: AnsiString): Integer;
    procedure WriteChars(const aString: AnsiString);
  end;


function dfFloatToStr(const aFloat: Extended): string;
function dfStrToFloat(const aValue: string): Extended;
function dfCalcHash(const s: string): Cardinal;

function dfStruct(
  const aName: string;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TdfStructDef; overload;
function dfStruct(const aName: string; const aDefs: array of TdfDef): TdfStructDef; overload;

function dfArray(
  const aName: string;
  const aMemberDef: TdfDef;
  aSize: integer;
  const aCounter: string;
  const aEvents: array of const
): TdfArrayDef; overload;
function dfArray(const aName: string; const aMemberDef: TdfDef; aSize: integer): TdfArrayDef; overload;
function dfArray(const aName: string; const aMemberDef: TdfDef; const aCounter: string): TdfArrayDef; overload;

function dfUnion(
  aDecider: TdfOnDecideEvent;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TdfUnionDef; overload;
function dfUnion(const aDefs: array of TdfDef; const aEvents: array of const): TdfUnionDef; overload;
function dfUnion(aDecider: TdfOnDecideEvent; const aDefs: array of TdfDef): TdfUnionDef; overload;

function dfValueUnion(
  aDataType: TdfDataType;
  aDecider: TdfOnDecideEvent;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TdfValueUnionDef; overload;
function dfValueUnion(aDataType: TdfDataType; aDecider: TdfOnDecideEvent; const aDefs: array of TdfDef): TdfValueUnionDef; overload;

function dfMerge(
  const aName: string;
  const aDefs: array of TdfDef;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfMergeDef; overload;
function dfMerge(const aName: string; const aDefs: array of TdfDef; const aEvents: array of const): TdfMergeDef; overload;
function dfMerge(const aName: string; const aDefs: array of TdfDef): TdfMergeDef; overload;

function dfInteger(
  const aName: string;
  aDataType: TdfDataType;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfIntegerDef; overload;
function dfInteger(const aName: string; aDataType: TdfDataType; const aDefaultValue: string): TdfIntegerDef; overload;
function dfInteger(const aName: string; aDataType: TdfDataType; const aEvents: array of const): TdfIntegerDef; overload;
function dfInteger(const aName: string; aDataType: TdfDataType): TdfIntegerDef; overload;
function dfHexInteger(const aName: string; aDataType: TdfDataType): TdfDef;

function dfFlags(
  const aName: string;
  aDataType: TdfDataType;
  const aFlags: array of const;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfFlagsDef; overload;
function dfFlags(const aName: string; aDataType: TdfDataType; const aFlags: array of const): TdfFlagsDef; overload;

function dfEnum(
  const aName: string;
  aDataType: TdfDataType;
  const aValues: array of const;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfEnumDef; overload;
function dfEnum(const aName: string; aDataType: TdfDataType; const aValues: array of const): TdfEnumDef; overload;
function dfBool(const aName: string; aDataType: TdfDataType; const aDefaultValue: string; const aEvents: array of const): TdfEnumDef; overload;
function dfBool(const aName: string; aDataType: TdfDataType; const aDefaultValue: string): TdfEnumDef; overload;
function dfBool(const aName: string; aDataType: TdfDataType; const aEvents: array of const): TdfEnumDef; overload;
function dfBool(const aName: string; aDataType: TdfDataType): TdfEnumDef; overload;

function dfFloat(
  const aName: string;
  aDataType: TdfDataType;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfFloatDef; overload;
function dfFloat(const aName: string; aDataType: TdfDataType): TdfFloatDef; overload;
function dfFloat(const aName: string; const aDefaultValue: string; const aEvents: array of const): TdfFloatDef; overload;
function dfFloat(const aName: string; const aEvents: array of const): TdfFloatDef; overload;
function dfFloat(const aName: string; const aDefaultValue: string): TdfFloatDef; overload;
function dfFloat(const aName: string): TdfFloatDef; overload;

function dfBytes(
  const aName: string;
  aSize: integer;
  const aEvents: array of const
): TdfBytesDef; overload;
function dfBytes(const aName: string; aSize: integer): TdfBytesDef; overload;

function dfChars(
  const aName: string;
  aSize: integer;
  const aDefaultValue: string;
  aTerminator: AnsiChar;
  aTerminated: Boolean;
  const aEvents: array of const
): TdfCharsDef;


implementation

uses
  wbHalfFloat;

const
  SingleNaN : Single = 0.0/0.0;
  DoubleNaN : Double = 0.0/0.0;
  SingleInf : Single = 1.0/0.0;
  DoubleInf : Double = 1.0/0.0;

function DoSingleSameValue(const A, B: Single): Boolean;
const
  SingleResolution : Single = 0.000000499999999999999999999;
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

function IsNegZeroString(const aValue: string): Boolean;
var
  i: Integer;
begin
  Result := False;

  if not ( (Length(aValue) >= 2) and (aValue[1] = '-') ) then
    Exit;

  for i := 2 to Length(aValue) do
    if not CharInSet(aValue[i], ['.', '0']) then
      Exit;

  Result := True;
end;

function dfFloatToStr(const aFloat: Extended): string;// inline;
var
  S: Single;
begin
  S := aFloat;
  if PCardinal(@S)^ = $80000000 then
    Result := '-' + FloatToStrF(0.0, ffFixed, 99, dfFloatDecimalDigits)
  else
    Result := FloatToStrF(aFloat, ffFixed, 99, dfFloatDecimalDigits);
end;

function dfStrToFloat(const aValue: string): Extended;
begin
  if SameText(aValue, 'NaN') then
    Result := SingleNaN
  else if SameText(aValue, 'Inf') then
    Result := SingleInf
  else if SameText(aValue, '-Inf') then
    Result := -SingleInf   
  else if SameText(aValue, 'Max') then
    Result := MaxSingle
  else if SameText(aValue, 'Min') then
    Result := -MaxSingle
  else if IsNegZeroString(aValue) then
    Result := -0.0
  else if aValue = '' then
    Result := 0.0
  else
    Result := StrToFloat(aValue);
end;

function dfStrToHalfFloat(const aValue: string): Extended;
begin
  if SameText(aValue, 'NaN') then
    Result := HalfToFloat(HalfNaN)
  else if SameText(aValue, 'Inf') then
    Result := HalfToFloat(HalfPosInf)
  else if SameText(aValue, '-Inf') then
    Result := -HalfToFloat(HalfPosInf)
  else if SameText(aValue, 'Max') then
    Result := MaxHalf
  else if SameText(aValue, 'Min') then
    Result := -MaxHalf
  else if IsNegZeroString(aValue) then
    Result := -0.0
  else if aValue = '' then
    Result := 0.0
  else
    Result := StrToFloat(aValue);
end;

function dfCalcHash(const s: string): Cardinal; inline;
begin
  Result := HashName(PAnsiChar(AnsiString(s)));
end;


{ TdfDef }

constructor TdfDef.Create(const aName: string; aDataType: TdfDataType; const aDefs: array of TdfDef);
var
  i: integer;
begin
  FName := aName;
  FNameHash := CalcHash(aName);
  FDataType := aDataType;

  if Length(aDefs) > 0 then begin
    SetLength(FDefs, Length(aDefs));
    for i := Low(aDefs) to High(aDefs) do
      FDefs[i] := aDefs[i];
  end;
end;

destructor TdfDef.Destroy;
var
  i: integer;
begin
  for i := Low(FDefs) to High(FDefs) do
    FDefs[i].Free;
  inherited;
end;

function TdfDef.CalcHash(const s: string): Cardinal;
begin
  Result := dfCalcHash(s);
end;

procedure TdfDef.Assign(const aDef: TdfDef);
var
  i: integer;
begin
  FSize := aDef.Size;
  FDefaultValue := aDef.DefaultValue;

  SetLength(FDefs, Length(aDef.Defs));
  for i := Low(FDefs) to High(FDefs) do
    FDefs[i] := aDef.Defs[i].Clone;

  FOnCreate       := aDef.OnCreate;
  FOnDestroy      := aDef.OnDestroy;
  FOnGetEnabled   := aDef.OnGetEnabled;
  FOnDecide       := aDef.OnDecide;
  FOnAfterLoad    := aDef.OnAfterLoad;
  FOnBeforeSave   := aDef.OnBeforeSave;
  FOnGetValue     := aDef.OnGetValue;
  FOnSetValue     := aDef.OnSetValue;
  FOnGetText      := aDef.OnGetText;
  FOnSetText      := aDef.OnSetText;
  FOnGetCount     := aDef.OnGetCount;
  FOnSetCount     := aDef.OnSetCount;
  FOnLinksTo      := aDef.OnLinksTo;
end;

procedure TdfDef.AssignEvents(const aEvents: array of const);
var
  i, ev: integer;
  P: Pointer;
begin
  Assert(Length(aEvents) mod 2 = 0);

  for i := Low(aEvents) to High(aEvents) do begin
    if aEvents[i].VType <> vtInteger then
      Continue;

    Assert(aEvents[Succ(i)].VType = vtPointer);

    ev := aEvents[i].VInteger;
    P := aEvents[Succ(i)].VPointer;
    case ev of
      DF_OnCreate         : FOnCreate := P;
      DF_OnDestroy        : FOnDestroy := P;
      DF_OnGetEnabled     : FOnGetEnabled := P;
      DF_OnDecide         : FOnDecide := P;
      DF_OnAfterLoad      : FOnAfterLoad := P;
      DF_OnBeforeSave     : FOnBeforeSave := P;
      DF_OnGetValue       : FOnGetValue := P;
      DF_OnSetValue       : FOnSetValue := P;
      DF_OnGetText        : FOnGetText := P;
      DF_OnSetText        : FOnSetText := P;
      DF_OnGetCount       : FOnGetCount := P;
      DF_OnSetCount       : FOnSetCount := P;
      DF_OnLinksTo        : FOnLinksTo := P;
    end;
  end;
end;

function TdfDef.GetDefaultDataSize: integer;
begin
  if FSize >= 0 then
    Result := DefSizes[FDataType]
  else
    Result := -FSize;
end;

function TdfDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfElement.Create(Self, aParent);
end;

procedure TdfDef.GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
begin
  if Assigned(FOnGetValue) and not aElement.Updating then begin
    aElement.BeginUpdate;
    try
      FOnGetValue(aElement, aValue);
    finally
      aElement.EndUpdate;
    end;
  end;
end;

procedure TdfDef.SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
begin
  if Assigned(FOnSetValue) and not aElement.Updating then begin
    aElement.BeginUpdate;
    try
      FOnSetValue(aElement, aValue);
    finally
      aElement.EndUpdate;
    end;
  end;
end;

procedure TdfDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
begin
  if Assigned(FOnGetText) and not aElement.Updating then begin
    aElement.BeginUpdate;
    try
      FOnGetText(aElement, aValue);
    finally
      aElement.EndUpdate;
    end;
  end;
end;

procedure TdfDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
begin
  if Assigned(FOnSetText) and not aElement.Updating then begin
    aElement.BeginUpdate;
    try
      FOnSetText(aElement, aValue);
    finally
      aElement.EndUpdate;
    end;
  end;
end;

procedure TdfDef.AddDef(const aDef: TdfDef);
begin
  SetLength(FDefs, Succ(Length(FDefs)));
  FDefs[Pred(Length(FDefs))] := aDef;
end;

procedure TdfDef.InsertDefsFrom(const aDef: TdfDef; Index: Integer);
var
  i: integer;
begin
  if Length(aDef.Defs) = 0 then
    Exit;

  if Length(FDefs) = 0 then
    Index := 0
  else if (Index < Low(FDefs)) or (Index > High(FDefs)) then
    raise Exception.Create('Invalid index to insert defs');

  SetLength(FDefs, Length(FDefs) + Length(aDef.Defs));
  Move(FDefs[Index], FDefs[Index + Length(aDef.Defs)], SizeOf(Pointer) * (Length(FDefs) - Length(aDef.Defs) - Index));
  for i := Low(aDef.Defs) to High(aDef.Defs) do
    FDefs[Index + i] := aDef.Defs[i].Clone;
end;



{ TdfElement }

constructor TdfElement.Create(const aDef: TdfDef; const aParent: TdfElement);
begin
  FDef := aDef;
  FParent := aParent;
  Include(FState, dsEnabled);
  if Assigned(FDef.OnCreate) then
    FDef.OnCreate(Self);
end;

destructor TdfElement.Destroy;
begin
  Include(FState, dsDestroying);
  // check FDef in case if exception occured in constructor and FDef is not set yet
  if Assigned(FDef) and Assigned(FDef.OnDestroy) then
    FDef.OnDestroy(Self);
end;

procedure TdfElement.DoException(const aMessage: string);
begin
  raise Exception.Create('Error in "' + Self.Path + '": ' + aMessage);
end;

function TdfElement.ValidateData(const aDataStart, aDataEnd: Pointer; aSize: Integer): Boolean;
var
  i: integer;
begin
  Result := True;

  if aDataStart <> nil then begin
    i := PByte(aDataEnd) - PByte(aDataStart);
    if aSize > i then begin
      DoException(Format('Unexpected end of stream: need %d bytes, available %d', [aSize, i]));
      Result := False;
    end;
  end;
end;

function TdfElement.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
begin
  Result := 0;
  Include(FState, dsInitialized);
  if Assigned(FDef.OnAfterLoad) then
    FDef.OnAfterLoad(Self, aDataStart, aDataSize);
end;

function TdfElement.Serialize(const aDataStart, aDataEnd: Pointer): Integer;
begin
  Result := 0;
end;

procedure TdfElement.UnSerializeFromJSON(const aJSON: TJSONBaseObject);
begin
  Include(FState, dsInitialized);
  if Assigned(FDef.OnAfterLoad) then
    FDef.OnAfterLoad(Self, @Self, 0); // no real data, just a not nil pointer
end;

procedure TdfElement.SerializeToJSON(const aJSON: TJSONBaseObject);
begin
end;

procedure TdfElement.LoadFromData(const aData: TBytes);
begin
  UnSerialize(@aData[0], @aData[Length(aData)], 0);
end;

procedure TdfElement.LoadFromFile(const aFileName: string);
var
  //Buffer: TBytes;
  flFileHandle, flMapHandle: THandle;
  DataStart, DataEnd: PByte;
begin
  {
  with TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone) do try
    SetLength(Buffer, Size);
    ReadBuffer(Buffer[0], Length(Buffer));
  finally
    Free;
  end;
  LoadFromData(Buffer);
  }
  DataStart := nil;
  flFileHandle := INVALID_HANDLE_VALUE;
  flMapHandle := INVALID_HANDLE_VALUE;

  try
    flFileHandle := CreateFile(
      PChar(aFileName),
      GENERIC_READ,
      FILE_SHARE_READ,
      nil,
      OPEN_EXISTING,
      FILE_FLAG_SEQUENTIAL_SCAN, //FILE_FLAG_RANDOM_ACCESS,
      0
    );
    if (flFileHandle = INVALID_HANDLE_VALUE) or (flFileHandle = 0) then
      RaiseLastOSError;

    flMapHandle := CreateFileMapping(
      flFileHandle,
      nil,
      PAGE_READONLY,
      0,
      0,
      nil
    );
    if (flMapHandle = INVALID_HANDLE_VALUE) or (flMapHandle = 0) then
      RaiseLastOSError;

    DataStart := MapViewOfFileEx(
      flMapHandle,
      FILE_MAP_READ,
      0,
      0,
      0,
      nil
    );

    if not Assigned(DataStart) then
      RaiseLastOSError;

    DataEnd := DataStart + GetFileSize(flFileHandle, nil);

    Unserialize(DataStart, DataEnd, 0);

  finally
    if Assigned(DataStart) then
      UnmapViewOfFile(DataStart);

    if (flMapHandle <> INVALID_HANDLE_VALUE) and (flMapHandle <> 0) then
      CloseHandle(flMapHandle);

    if (flFileHandle <> INVALID_HANDLE_VALUE) and (flFileHandle <> 0) then
      CloseHandle(flFileHandle);
  end;
end;

procedure TdfElement.LoadFromJSONFile(const aFileName: string);
begin
  with TStringList.Create do try
    LoadFromFile(aFileName);
    FromJSON(Text);
  finally
    Free;
  end;
end;

procedure TdfElement.LoadFromResource(const aContainerName, aFileName: string);
var
  data: TBytes;
begin
  if not Assigned(dfResourceGetDataCallback) then
    DoException('Resource data handler is not initialized');

  data := dfResourceGetDataCallback(aContainerName, aFileName);
  if Length(data) > 0 then
    LoadFromData(data)
  else
    raise Exception.CreateFmt('Resource not found (File "%s" in container "%s")', [aFileName, aContainerName]);
end;

procedure TdfElement.LoadFromResource(const aFileName: string);
var
  data: TBytes;
begin
  if not Assigned(dfResourceGetDataCallback) then
    DoException('Resource data handler is not initialized');

  data := dfResourceGetDataCallback('', aFileName);
  if Length(data) > 0 then
    LoadFromData(data)
  else
    raise Exception.CreateFmt('Resource not found (File "%s")', [aFileName]);
end;

procedure TdfElement.SaveToData(var aData: TBytes);
begin
  SetLength(aData, DataSize);
  Serialize(@aData[0], @aData[Length(aData)]);
end;

procedure TdfElement.SaveToFile(const aFileName: string);
var
  Buffer: TBytes;
begin
  SaveToData(Buffer);
  with TFileStream.Create(aFileName, fmCreate) do try
    WriteBuffer(Buffer[0], Length(Buffer));
  finally
    Free;
  end;
end;

procedure TdfElement.SaveToJSONFile(const aFileName: string; aCompact: Boolean);
var
  ss: TStringStream;
begin
  ss := TStringStream.Create;
  try
    ss.WriteString(ToJSON(aCompact));
    ss.SaveToFile(aFileName);
  finally
    ss.Free;
  end;
end;

procedure TdfElement.SetToDefault;
begin
  UnSerialize(nil, nil, 0);
end;

procedure TdfElement.Assign(const aElement: TdfElement);
begin
end;

function TdfElement.ToJSON(aCompact: Boolean): string;
var
  json: TJSONObject;
begin
  json := TJSONObject.Create;
  try
    SerializeToJSON(json);
    Result := json.ToJSON(aCompact);
  finally
    json.Free;
  end;
end;

procedure TdfElement.FromJSON(const aText: string);
var
  json: TJSONObject;
begin
  json := TJSONObject.Create;
  try
    json.FromJSON(aText);
    SetToDefault;
    UnSerializeFromJSON(json);
  finally
    json.Free;
  end;
  // call OnAfterLoad event
  inherited;
end;

function TdfElement.ToText(aIdent: Integer = 0): string;
var
  i: integer;
begin
  if not Enabled then
    Exit('');

  Result := StringOfChar(#9, aIdent) + Name;

  if Def is TdfValueDef then
    Result := Result + ': ' + EditValue;

  Result := Result + #13#10;

  for i := 0 to Pred(Count) do
    Result := Result + Items[i].ToText(aIdent + 1);
end;


function TdfElement.DataSize: integer;
begin
  Result := 0;
  // since saving preparations affect data size, call event here
  if Assigned(FDef.OnBeforeSave) then
    FDef.OnBeforeSave(Self);
end;

function TdfElement.GetDefaultDataSize: integer;
begin
  Result := Def.DefaultDataSize;
end;

function TdfElement.Path: string;
var
  Element: TdfElement;
begin
  Result := Name;
  Element := Parent;
  while Assigned(Element) and Assigned(Element.Parent) do begin
    Result := Element.Name + '\' + Result;
    Element := Element.Parent;
  end;
end;

function TdfElement.Root: TdfElement;
begin
  Result := Self;
  while Assigned(Result.Parent) do
    Result := Result.Parent;
end;

function TdfElement.Add: TdfElement;
begin
  Result := nil;
  DoException('Can not add to this element');
end;

procedure TdfElement.Delete(Index: Integer);
begin
  DoException('Can not delete from this element');
end;

procedure TdfElement.Remove;
begin
  if Assigned(FParent) and (FParent.DataType = dtArray) then
    FParent.Delete(FParent.IndexOf(Self))
  else
    DoException('Can not remove this element');
end;

procedure TdfElement.Move(CurIndex, NewIndex: Integer);
begin
  DoException('Can not reorder in this element');
end;

function TdfElement.Index: Integer;
begin
  if Assigned(Parent) then
    Result := Parent.IndexOf(Self)
  else
    Result := -1;
end;

function TdfElement.IndexOf(aElement: TdfElement): Integer;
begin
  Result := -1;
end;

function TdfElement.LinksTo: TdfElement;
begin
  if Assigned(Def.OnLinksTo) then
    Result := Def.OnLinksTo(Self)
  else
    Result := nil;
end;

function TdfElement.ElementByName(const aName: string; aEnabledOnly: Boolean = True): TdfElement;
begin
  if aName = '..' then
    Result := FParent
  else if aName = '.' then
    Result := Root
  else if (Length(aName) > 2) and (aName[1] = '[') and (aName[Length(aName)] = ']') then
    Result := Items[StrToIntDef(Copy(aName, 2, Length(aName) - 2), -1)]
  else
    Result := nil;
end;

function TdfElement.ElementByPath(const aPath: string; aEnabledOnly: Boolean = True): TdfElement;
var
  i: integer;
  Element: TdfElement;
begin
  i := Pos('\', aPath);
  if i <> 0 then begin
    Element := ElementByName(Copy(aPath, 1, i - 1), aEnabledOnly);
    if Assigned(Element) then
      Result := Element.ElementByPath(Copy(aPath, i + 1, Length(aPath)), aEnabledOnly)
    else
      Result := nil;
  end else
    Result := ElementByName(aPath, aEnabledOnly);
end;

function TdfElement.EnabledElementByPath(const aPath: string): TdfElement;
begin
  Result := ElementByPath(aPath);
end;

function TdfElement.GetDef: TdfDef;
begin
  Result := FDef;
end;

function TdfElement.GetName: string;
begin
  Result := Def.Name;

  if Assigned(FParent) and (FParent.DataType = dtArray) then
    Result := Result + ' #' + IntToStr(FParent.IndexOf(Self));
end;

function TdfElement.GetNameHash: Cardinal;
begin
  if Assigned(FParent) and (FParent.DataType = dtArray) then
    Result := Def.CalcHash(GetName)
  else
    Result := Def.NameHash;
end;

function TdfElement.GetDataType: TdfDataType;
begin
  Result := Def.DataType;
end;

function TdfElement.GetEnabled: Boolean;
begin
  // enabled is checked on element's def itself (not decided by union)
  if Assigned(FDef.OnGetEnabled) then
    {$IFDEF DFDEBUG} try {$ENDIF}
      Result := FDef.OnGetEnabled(Self)
    {$IFDEF DFDEBUG} except raise Exception.Create('Exception in OnGetEnabled'); end {$ENDIF}
  else
    Result := dsEnabled in FState;
end;

procedure TdfElement.SetEnabled(aEnabled: Boolean);
begin
  Exclude(FState, dsEnabled);
end;

function TdfElement.GetInitialized: Boolean;
begin
  Result := dsInitialized in FState;
end;

function TdfElement.Updating: Boolean;
begin
  Result := dsUpdating in FState;
end;

procedure TdfElement.BeginUpdate;
begin
  Include(FState, dsUpdating);
end;

procedure TdfElement.EndUpdate;
begin
  Exclude(FState, dsUpdating);
end;

function TdfElement.GetCount: Integer;
begin
  Result := 0;
end;

procedure TdfElement.SetCount(NewCount: Integer);
begin
end;

function TdfElement.Get(Index: Integer): TdfElement;
begin
  Result := nil;
end;

procedure TdfElement.Put(Index: Integer; const aElement: TdfElement);
begin
end;

function TdfElement.GetNativeValue: Variant;
begin
end;

procedure TdfElement.SetNativeValue(const aValue: Variant);
begin
end;

function TdfElement.GetEditValue: string;
begin
end;

procedure TdfElement.SetEditValue(const aValue: string);
begin
end;

function LastCharPos(const S: string; const Chr: Char): Integer; inline;
begin
  for Result := Length(S) downto 1 do
    if S[Result] = Chr then
      Exit;
  Result := 0;
end;

function TdfElement.GetNativeValues(const aPath: string): Variant;
var
  Element: TdfElement;
  i: Integer;
begin
  // access last element in path separately to work with virtual values of flags and merges
  i := LastCharPos(aPath, '\');
  if i = 0 then
    Element := ElementByPath(aPath)
  else
    Element := ElementByPath(Copy(aPath, 1, i - 1));

  if Assigned(Element) then
    if i = 0 then
      Result := Element.NativeValue
    else
      Result := Element.NativeValues[Copy(aPath, i + 1, Length(aPath) - i)];
end;

procedure TdfElement.SetNativeValues(const aPath: string; const aValue: Variant);
var
  Element: TdfElement;
  i: Integer;
begin
  i := LastCharPos(aPath, '\');
  if i = 0 then
    Element := ElementByPath(aPath)
  else
    Element := ElementByPath(Copy(aPath, 1, i - 1));

  if Assigned(Element) then
    if i = 0 then
      Element.NativeValue := aValue
    else
      Element.NativeValues[Copy(aPath, i + 1, Length(aPath) - i)] := aValue;
end;

function TdfElement.GetEditValues(const aPath: string): string;
var
  Element: TdfElement;
  i: Integer;
begin
  i := LastCharPos(aPath, '\');
  if i = 0 then
    Element := ElementByPath(aPath)
  else
    Element := ElementByPath(Copy(aPath, 1, i - 1));

  if Assigned(Element) then
    if i = 0 then
      Result := Element.EditValue
    else
      Result := Element.EditValues[Copy(aPath, i + 1, Length(aPath) - i)];
end;

procedure TdfElement.SetEditValues(const aPath: string; const aValue: string);
var
  Element: TdfElement;
  i: Integer;
begin
  i := LastCharPos(aPath, '\');
  if i = 0 then
    Element := ElementByPath(aPath)
  else
    Element := ElementByPath(Copy(aPath, 1, i - 1));

  if Assigned(Element) then
    if i = 0 then
      Element.EditValue := aValue
    else
      Element.EditValues[Copy(aPath, i + 1, Length(aPath) - i)] := aValue;
end;

function TdfElement.ActiveIndex: Integer;
begin
  if not (dsDeciding in FState) and Assigned(FDef.OnDecide) then begin
    Include(FState, dsDeciding);
    try
      Result := FDef.OnDecide(Self);
    finally
      Exclude(FState, dsDeciding);
    end;
    if (Result < Low(FDef.Defs)) or (Result > High(FDef.Defs)) then
      Result := Low(FDef.Defs);
  end else
    Result := 0;
end;


{ TdfValue }

function TdfValue.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  PData: PByte;
begin
  // disabled element doesn't advance pointer and initializes with default value
  if not Enabled then
    PData := nil
  else
    PData := aDataStart;

  // if data length is not set explicitly, then use default length
  if aDataSize <> 0 then
    Result := aDataSize
  else
    Result := GetDefaultDataSize;

  // have some data to read
  if Result <> 0 then begin
    ValidateData(PData, aDataEnd, Result);
    AllocateValue(Result);

    if Assigned(PData) then
      // copy data
      System.Move(PData^, FDataStart^, Result)
    else
      // clear data if unserializing from nil on already existing value
      FillChar(FDataStart^, Result, 0);
  end else
    // init value data pointers
    AllocateValue(Result);

  inherited; // set Initialized

  // default unserialization from nil
  if not Assigned(PData) then begin
    // don't advance pointer
    Result := 0;
    // set the default value
    with Def do if DefaultValue <> '' then
      EditValue := DefaultValue;
  end;
end;

function TdfValue.Serialize(const aDataStart, aDataEnd: Pointer): Integer;
begin
  if not Enabled then begin
    Result := 0;
    Exit;
  end;

  if not Initialized then
    SetToDefault;

  Result := FDataEnd - FDataStart;
  System.Move(FDataStart^, aDataStart^, Result)
end;

procedure TdfValue.UnSerializeFromJSON(const aJSON: TJSONBaseObject);
begin
  if not Enabled then
    Exit;

  if aJSON is TJSONObject then
    EditValue := TJSONObject(aJSON).S[Name]
  else if aJSON is TJSONArray then
    EditValue := TJSONArray(aJSON).S[Index];
  // call OnAfterLoad event
  inherited;
end;

procedure TdfValue.SerializeToJSON(const aJSON: TJSONBaseObject);
begin
  if Enabled then
    if aJSON is TJSONObject then
      TJSONObject(aJSON).S[Name] := EditValue
    else if aJSON is TJSONArray then
      TJSONArray(aJSON).Add(EditValue);
end;

procedure TdfValue.Assign(const aElement: TdfElement);
begin
  if not Assigned(aElement) then
    Exit;

  if not Enabled then
    Exit;

  if not ((aElement is TdfValue) or (aElement is TdfUnion)) then
    Exit;

  EditValue := aElement.EditValue;
end;

function TdfValue.DataSize: integer;
begin
  if Enabled then begin
    if not Initialized then
      SetToDefault;

    inherited;
    Result := FDataEnd - FDataStart;
  end else
    Result := 0;
end;

procedure TdfValue.AllocateValue(var aDataStart, aDataEnd: PByte; aLength: Integer);
begin
  if aLength <= SizeOf(FValue) then begin
    if (FDataStart <> nil) and (FDataStart <> @FValue) then
      ReallocMem(FDataStart, 0);
    FDataStart := @FValue[0];
    FDataEnd := FDataStart + aLength;
  end
  else begin
    if FDataStart = @FValue then
      FDataStart := nil;
    ReallocMem(FDataStart, aLength);
    FDataEnd := FDataStart + aLength;
  end;
  aDataStart := FDataStart;
  aDataEnd := FDataEnd;
end;

procedure TdfValue.AllocateValue(aLength: Integer);
begin
  AllocateValue(FDataStart, FDataEnd, aLength);
end;

function TdfValue.GetNativeValue: Variant;
begin
  Def.GetElementNativeValue(Self, FDataStart, FDataEnd, Result);
end;

procedure TdfValue.SetNativeValue(const aValue: Variant);
var
  Value: Variant;
begin
  Value := aValue;
  Def.SetElementNativeValue(Self, FDataStart, FDataEnd, Value);
end;

function TdfValue.GetEditValue: string;
begin
  Def.GetElementEditValue(Self, FDataStart, FDataEnd, Result);
end;

procedure TdfValue.SetEditValue(const aValue: string);
var
  Value: string;
begin
  Value := aValue;
  Def.SetElementEditValue(Self, FDataStart, FDataEnd, Value);
end;

destructor TdfValue.Destroy;
begin
  inherited;
  if FDataStart <> @FValue then
    ReallocMem(FDataStart, 0);
end;


{ TdfContainer }

destructor TdfContainer.Destroy;
begin
  inherited;
  Clear;
  FElements := nil;
end;

function TdfContainer.Serialize(const aDataStart, aDataEnd: Pointer): Integer;
var
  i: integer;
begin
  Result := 0;

  if not Enabled then
    Exit;

  for i := 0 to Pred(FCount) do
    Result := Result + FElements[i].Serialize(PByte(aDataStart) + Result, aDataEnd);
end;

function TdfContainer.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
begin
  inherited;
  Result := aDataSize;
end;

function TdfContainer.DataSize: integer;
var
  i: integer;
begin
  Result := 0;

  if not Enabled then
    Exit;

  inherited;
  for i := 0 to Pred(FCount) do
    Result := Result + FElements[i].DataSize;
end;

procedure TdfContainer.Clear;
var
  i: integer;
begin
  for i := 0 to Pred(FCount) do
    FElements[i].Free;
  FCount := 0;
end;

function TdfContainer.GetCapacity: Integer;
begin
  Result := Length(FElements);
end;

procedure TdfContainer.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <= FCount then
    Exit;

  SetLength(FElements, NewCapacity);
end;

function TdfContainer.GetCount: integer;
begin
  Result := FCount;
end;

procedure TdfContainer.SetCount(NewCount: Integer);
var
  i: integer;
begin
  try
    BeginUpdate;

    if FCount > NewCount then
      for i := Pred(FCount) downto NewCount do
        FElements[i].Free;

    if NewCount > FCount then
      for i := FCount to Pred(NewCount) do
        Add;

    FCount := NewCount;
  finally
    EndUpdate;
  end;
end;

function TdfContainer.Get(Index: Integer): TdfElement;
begin
  if (Index < 0) or (Index >= FCount) then begin
    DoException(Format('List index (%d) is out of bounds', [Index]));
    Result := nil; // suppress compiler warning
  end else
    Result := FElements[Index];
end;

procedure TdfContainer.Put(Index: Integer; const aElement: TdfElement);
var
  NewLength: integer;
begin
  try
    if Index >= FCount then begin
      if FCount = Capacity then begin
        NewLength := Capacity * 2;
        if NewLength < 4 then NewLength := 4;
        Capacity := NewLength;
      end;
      FElements[FCount] := aElement;
      Inc(FCount);
    end else
      FElements[Index] := aElement;
  except
    on E: Exception do
      DoException(E.Message);
  end;
end;

procedure TdfContainer.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    DoException(Format('List index (%d) is out of bounds', [Index]));

  FElements[Index].Free;
  Dec(FCount);
  System.Move(FElements[Succ(Index)], FElements[Index], (FCount - Index) * SizeOf(Pointer));
end;

procedure TdfContainer.Move(CurIndex, NewIndex: Integer);
var
  Element: TdfElement;
begin
  if (CurIndex < 0) or (CurIndex >= FCount) then
    DoException(Format('List index (%d) is out of bounds', [CurIndex]));
  if (NewIndex < 0) or (NewIndex >= FCount) then
    DoException(Format('List index (%d) is out of bounds', [NewIndex]));

  Element := FElements[CurIndex];
  // moving backward
  if CurIndex > NewIndex then
    System.Move(FElements[NewIndex], FElements[Succ(NewIndex)], (CurIndex - NewIndex) * SizeOf(Pointer))
  // moving forward
  else
    System.Move(FElements[Succ(CurIndex)], FElements[CurIndex], (NewIndex - CurIndex) * SizeOf(Pointer));
  FElements[NewIndex] := Element;
end;

function TdfContainer.IndexOf(aElement: TdfElement): integer;
begin
  for Result := 0 to FCount - 1 do
    if FElements[Result] = aElement then
      Exit;
  Result := -1;
end;

function TdfContainer.ElementByName(const aName: string; aEnabledOnly: Boolean = True): TdfElement;
var
  i, cnt: integer;
  h: Cardinal;
  Element: TdfElement;
begin
  Result := inherited;
  if Assigned(Result) or (aName = '') then
    Exit;

  h := Def.CalcHash(aName);
  cnt := Count;
  for i := 0 to Pred(cnt) do begin
    Element := FElements[i];
    if Assigned(Element) and
      Element.Initialized and
      (Element.NameHash = h) and
      (not aEnabledOnly or Element.Enabled)
    then begin
      Result := Element;
      Exit;
    end;
  end;
  Result := nil;
end;


{ Structure }

function TdfStructDef.Clone: TdfDef;
begin
  Result := TdfStructDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfStructDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfStruct.Create(Self, aParent);
end;

function TdfStruct.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  i, Bytes: integer;
  Element: TdfElement;
  PData: PByte;
begin
  // disabled element doesn't advance pointer and initializes with default value
  if not Enabled then
    PData := nil
  else
    PData := aDataStart;

  // free existing elements
  Clear;
  // preallocate container capacity
  Capacity := Length(FDef.Defs);

  Result := 0;
  for i := Low(FDef.Defs) to High(FDef.Defs) do begin
    Element := FDef.Defs[i].CreateElement(Self);
    Put(High(Integer), Element);
    Bytes := Element.UnSerialize(PData, aDataEnd, 0);
    Result := Result + Bytes;
    if PData <> nil then
      PData := PData + Bytes;
  end;

  // call OnAfterLoad event
  inherited Unserialize(aDataStart, aDataEnd, Result);
end;

procedure TdfStruct.SetCount(NewCount: Integer);
begin
  DoException('Can not change the size of structure');
end;

procedure TdfStruct.Delete(Index: Integer);
begin
  DoException('Can not change the size of structure');
end;

procedure TdfStruct.Move(CurIndex, NewIndex: Integer);
begin
  DoException('Can not reorder a structure');
end;

procedure TdfStruct.UnSerializeFromJSON(const aJSON: TJSONBaseObject);
var
  o: TJSONObject;
  i: integer;
begin
  if not Enabled then
    Exit;

  if aJSON is TJSONObject then
    o := TJSONObject(aJSON).O[Name]
  else if aJSON is TJSONArray then
    o := TJSONArray(aJSON).O[Index]
  else
    o := nil;

  if Assigned(o) then
    for i := 0 to Pred(FCount) do
      Items[i].UnSerializeFromJSON(o);

  // call OnAfterLoad event
  inherited;
end;

procedure TdfStruct.SerializeToJSON(const aJSON: TJSONBaseObject);
var
  o: TJSONObject;
  i: integer;
begin
  if not Enabled then
    Exit;

  if aJSON is TJSONArray then
    o := TJSONArray(aJSON).AddObject
  else
    o := TJSONObject.Create;

  for i := 0 to Pred(FCount) do
    Items[i].SerializeToJSON(o);

  if aJSON is TJSONObject then
    TJSONObject(aJSON).O[Name] := o;
end;

procedure TdfStruct.Assign(const aElement: TdfElement);
var
  i: Integer;
begin
  if not Assigned(aElement) then
    Exit;

  if not Enabled then
    Exit;

  if not (aElement is TdfStruct) then
    Exit;

  for i := 0 to Pred(FCount) do
    FElements[i].Assign(aElement.ElementByName(FElements[i].Name));
end;



{ Array }

function TdfArrayDef.Clone: TdfDef;
begin
  Result := TdfArrayDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

procedure TdfArrayDef.Assign(const aDef: TdfDef);
begin
  inherited;
  if aDef is TdfArrayDef then
    FCounter := TdfArrayDef(aDef).Counter;
end;

function TdfArrayDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfArray.Create(Self, aParent);
end;

function TdfArray.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  i, Bytes, Size, StoredSize: integer;
  bEnabled, bAutoExpanding: Boolean;
  Element: TdfElement;
  PData: PByte;
begin
  // disabled element doesn't advance pointer and initializes with default value
  bEnabled := Enabled;
  if not bEnabled then
    PData := nil
  else
    PData := aDataStart;

  // clear existing elements
  Clear;
  Result := 0;

  // determining array size
  Size := FDef.Size;
  bAutoExpanding := (Size = 0) and (TdfArrayDef(FDef).Counter = '') and not Assigned(FDef.OnGetCount);

  // getting size from prefix if any
  if Size < 0 then begin

    if PData = nil
      then Size := 0
    else
      ValidateData(aDataStart, aDataEnd, -Size);

    case Size of
      -1: StoredSize := PByte(PData)^;
      -2: StoredSize := PWord(PData)^;
      -4: StoredSize := PCardinal(PData)^;
      else StoredSize := 0;
    end;
    // adjust pointer past prefix
    PData := PData + (-Size);
    // increase processed bytes count by prefix size
    Result := -Size;
    // new array size
    Size := StoredSize;
  end
  // getting external size
  else if Size = 0 then
    Size := GetExternalCount;

  // disabled variable size arrays are initialized with zero elements
  if not bEnabled and (FDef.Size <= 0) then
    Size := 0;

  // preallocate container capacity if size is known
  if Size > 0 then
    Capacity := Size;

  i := 0;
  while (i < Size) or (bAutoExpanding and Assigned(PData) and (PByte(aDataEnd) > PData)) do begin
    Element := FDef.Defs[0].CreateElement(Self);
    Put(High(Integer), Element);
    Bytes := Element.UnSerialize(PData, aDataEnd, 0);
    Result := Result + Bytes;
    if PData <> nil then
      PData := PData + Bytes;
    Inc(i);
  end;

  // call OnAfterLoad event
  inherited Unserialize(aDataStart, aDataEnd, Result);
end;

function TdfArray.Serialize(const aDataStart, aDataEnd: Pointer): Integer;
var
  Size: integer;
begin
  Result := 0;

  if not Enabled then
    Exit;

  if not Initialized then
    SetToDefault;

  // stored length in prefix
  Size := Def.Size;
  if Size < 0 then begin
    case Size of
      -1: PByte(aDataStart)^ := FCount;
      -2: PWord(aDataStart)^ := FCount;
      -4: PCardinal(aDataStart)^ := FCount;
    end;
    Result := -Size;
  end;

  Result := Result + inherited Serialize(PByte(aDataStart) + Result, aDataEnd);
end;

procedure TdfArray.UnSerializeFromJSON(const aJSON: TJSONBaseObject);
var
  a: TJSONArray;
  i: integer;
begin
  if not Enabled then
    Exit;

  if aJSON is TJSONObject then
    a := TJSONObject(aJSON).A[Name]
  else if aJSON is TJSONArray then
    a := TJSONArray(aJSON).A[Index]
  else
    a := nil;

  if Assigned(a) then begin
    // allocate dynamic array elements
    if FDef.Size <= 0 then begin
      Count := 0;
      Capacity := a.Count;
    end;
    for i := 0 to Pred(a.Count) do
      if FDef.Size <= 0 then
        Add.UnSerializeFromJSON(a)
      else
        Items[i].UnSerializeFromJSON(a);

    // call OnAfterLoad event
    inherited;
  end;
end;

procedure TdfArray.SerializeToJSON(const aJSON: TJSONBaseObject);
var
  a: TJSONArray;
  i: integer;
begin
  if not Enabled then
    Exit;

  if aJSON is TJSONArray then
    a := TJSONArray(aJSON).AddArray
  else
    a := TJSONArray.Create;

  for i := 0 to Pred(FCount) do
    Items[i].SerializeToJSON(a);

  if aJSON is TJSONObject then
    TJSONObject(aJSON).A[Name] := a;
end;

procedure TdfArray.Assign(const aElement: TdfElement);
var
  i: Integer;
begin
  if not Assigned(aElement) then
    Exit;

  if not Enabled then
    Exit;

  if not (aElement is TdfArray) then
    Exit;

  Count := aElement.Count;

  for i := 0 to Pred(FCount) do
    FElements[i].Assign(aElement[i]);
end;

function TdfArray.DataSize: integer;
var
  cnt: Integer;
begin
  Result := 0;

  if not Enabled then
    Exit;

  // DataSize is called before serialization, make sure that we have the same
  // number of elements as the external count otherwise saved data will be invalid
  if (TdfArrayDef(FDef).Counter <> '') or Assigned(FDef.OnGetCount) then begin
    cnt := GetExternalCount;
    if Count <> cnt then
      Count := cnt;
  end;

  Result := inherited;
  // add prefix size
  if FDef.Size < 0 then
    Result := Result + -FDef.Size;
end;

function TdfArray.GetExternalCount: Integer;
var
  CounterElement: TdfElement;
begin
  if TdfArrayDef(FDef).Counter <> '' then begin
    if Assigned(FParent) then
      CounterElement := FParent.ElementByPath(TdfArrayDef(FDef).Counter, False)
    else
      CounterElement := nil;
  
    if not Assigned(CounterElement) then
      DoException('Counter element "' + TdfArrayDef(FDef).Counter + '" not found for array');

    if CounterElement.Initialized then
      Result := CounterElement.NativeValue
    else
      Result := 0;
  end
  else if Assigned(FDef.OnGetCount) then
    {$IFDEF DFDEBUG} try {$ENDIF}
    FDef.OnGetCount(Self, Result)
    {$IFDEF DFDEBUG} except raise Exception.Create('Exception in OnGetCount'); end {$ENDIF}
  else
    Result := 0;
end;

procedure TdfArray.SetExternalCount(NewCount: Integer);
var
  CounterElement: TdfElement;
begin
  if TdfArrayDef(FDef).Counter <> '' then begin
    if Assigned(FParent) then
      CounterElement := FParent.ElementByPath(TdfArrayDef(FDef).Counter, False)
    else
      CounterElement := nil;

    if not Assigned(CounterElement) then
      DoException('Counter element "' + TdfArrayDef(FDef).Counter + '" not found for array');

    if CounterElement.NativeValue <> NewCount then
      CounterElement.NativeValue := NewCount;
  end
  else if not Updating and Assigned(FDef.OnSetCount) then
    {$IFDEF DFDEBUG} try {$ENDIF}
    FDef.OnSetCount(Self, NewCount);
    {$IFDEF DFDEBUG} except raise Exception.Create('Exception in OnSetCount'); end {$ENDIF}
end;

procedure TdfArray.SetCount(NewCount: Integer);
begin
  if FDef.Size > 0 then
    Exit;

  inherited;

  // update external counter element
  //if not Updating then
  //  SetExternalCount(Count);
end;

function TdfArray.Add: TdfElement;
begin
  if FDef.Size > 0 then
    DoException('Can not change size of a fixed array');

  Result := FDef.Defs[0].CreateElement(Self);
  Result.SetToDefault;
  Put(High(Integer), Result);

  // update external counter element
  //if not Updating then
  //  SetExternalCount(Count);
end;

procedure TdfArray.Delete(Index: Integer);
begin
  if FDef.Size > 0 then
    DoException('Can not change size of a fixed array');

  inherited;

  // update external counter element
  //if not Updating then
  //  SetExternalCount(Count);
end;



{ Union }

function TdfUnionDef.Clone: TdfDef;
begin
  Result := TdfUnionDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfUnionDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfUnion.Create(Self, aParent);
end;

function TdfUnion.GetDef: TdfDef;
begin
  Result := FDef.Defs[ActiveIndex];
end;

function TdfUnion.GetCount: Integer;
begin
  Result := 0;
end;

procedure TdfUnion.SetCount(NewCount: Integer);
begin
end;

function TdfUnion.GetNativeValue: Variant;
begin
  Result := Items[ActiveIndex].NativeValue;
end;

procedure TdfUnion.SetNativeValue(const aValue: Variant);
begin
  Items[ActiveIndex].NativeValue := aValue;
end;

function TdfUnion.GetEditValue: string;
begin
  Result := Items[ActiveIndex].EditValue;
end;

procedure TdfUnion.SetEditValue(const aValue: string);
begin
  Items[ActiveIndex].EditValue := aValue;
end;

function TdfUnion.GetNativeValues(const aPath: string): Variant;
begin
  // OnEnabled and other events can be called before members are created
  if FCount <> 0 then
    Result := Items[ActiveIndex].NativeValues[aPath]
  else
    Result := inherited;
end;

procedure TdfUnion.SetNativeValues(const aPath: string; const aValue: Variant);
begin
  if FCount <> 0 then
    Items[ActiveIndex].NativeValues[aPath] := aValue
  else
    inherited;
end;

function TdfUnion.GetEditValues(const aPath: string): string;
begin
  if FCount <> 0 then
    Result := Items[ActiveIndex].EditValues[aPath]
  else
    Result := inherited;
end;

procedure TdfUnion.SetEditValues(const aPath: string; const aValue: string);
begin
  if FCount <> 0 then
    Items[ActiveIndex].EditValues[aPath] := aValue
  else
    inherited;
end;

function TdfUnion.DataSize: integer;
begin
  if Enabled then
    Result := Items[ActiveIndex].DataSize
  else
    Result := 0;
end;

function TdfUnion.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  i, idx: integer;
  Element: TdfElement;
  PData: PByte;
begin
  // disabled element doesn't advance pointer and initalizes with default value
  if not Enabled then
    PData := nil
  else
    PData := aDataStart;

  idx := ActiveIndex;
  // free existing elements
  Clear;
  // preallocate
  Capacity := Length(FDef.Defs);

  Result := 0;
  for i := Low(FDef.Defs) to High(FDef.Defs) do begin
    // use our Parent, not us
    Element := FDef.Defs[i].CreateElement(Parent);
    Put(High(Integer), Element);
    // active element reads real data, others are initialized empty
    if i = idx then
      Result := Element.UnSerialize(PData, aDataEnd, 0)
    else
      Element.SetToDefault;
  end;

  // call OnAfterLoad event
  inherited Unserialize(aDataStart, aDataEnd, Result);
end;

function TdfUnion.Serialize(const aDataStart, aDataEnd: Pointer): Integer;
begin
  // serialize active element only
  if Enabled then
    Result := Items[ActiveIndex].Serialize(aDataStart, aDataEnd)
  else
    Result := 0;
end;

procedure TdfUnion.UnSerializeFromJSON(const aJSON: TJSONBaseObject);
begin
  if not Enabled then
    Exit;

  if aJSON is TJSONObject then
    EditValue := TJSONObject(aJSON).S[Name]
  else if aJSON is TJSONArray then
    EditValue := TJSONArray(aJSON).S[Index];

  // call OnAfterLoad event
  inherited;
end;

procedure TdfUnion.SerializeToJSON(const aJSON: TJSONBaseObject);
begin
  if Enabled then
    if aJSON is TJSONObject then
      TJSONObject(aJSON).S[Name] := EditValue
    else if aJSON is TJSONArray then
      TJSONArray(aJSON).Add(EditValue);
end;

procedure TdfUnion.Assign(const aElement: TdfElement);
begin
  if not Assigned(aElement) then
    Exit;

  if not Enabled then
    Exit;

  if not ((aElement is TdfValue) or (aElement is TdfUnion)) then
    Exit;

  EditValue := aElement.EditValue;
end;


{ Value union }

function TdfValueUnionDef.Clone: TdfDef;
begin
  Result := TdfValueUnionDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfValueUnionDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfValueUnion.Create(Self, aParent);
end;

function TdfValueUnion.GetDef: TdfDef;
begin
  Result := FDef.Defs[ActiveIndex];
end;


{ Merge }

constructor TdfMergeDef.Create(const aName: string; aDataType: TdfDataType; const aDefs: array of TdfDef);
begin
  inherited;
  FDelimiter := ' ';
  UpdateOffsets;
end;

function TdfMergeDef.Clone: TdfDef;
begin
  Result := TdfMergeDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

procedure TdfMergeDef.Assign(const aDef: TdfDef);
begin
  inherited;
  UpdateOffsets;
  if aDef is TdfMergeDef then
    FDelimiter := TdfMergeDef(aDef).Delimiter;
end;

function TdfMergeDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfMerge.Create(Self, aParent);
end;

procedure TdfMergeDef.UpdateOffsets;
var
  i, Offset: integer;
begin
  Offset := 0;
  SetLength(FOffsets, Length(FDefs));
  for i := Low(FDefs) to High(FDefs) do begin
    FOffsets[i].Offset := Offset;
    FOffsets[i].DataSize := FDefs[i].DefaultDataSize;
    Inc(Offset, FOffsets[i].DataSize);
    Assert(FOffsets[i].DataSize <> 0);
  end;
end;

function TdfMergeDef.GetValueOffset(aIndex: Integer): Integer;
begin
  Result := FOffsets[aIndex].Offset;
end;

function TdfMergeDef.GetValueDataSize(aIndex: Integer): Integer;
begin
  Result := FOffsets[aIndex].DataSize;
end;

function TdfMergeDef.GetDefaultDataSize: Integer;
var
  i: integer;
begin
  Result := 0;
  for i := Low(FOffsets) to High(FOffsets) do
    Inc(Result, FOffsets[i].DataSize);
end;

procedure TdfMergeDef.GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  Bytes: TBytes;
begin
  SetLength(Bytes, aDataEnd - aDataStart);
  if Length(Bytes) > 0 then
    Move(aDataStart^, Bytes[0], Length(Bytes));
  aValue := Bytes;
end;

procedure TdfMergeDef.SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  Bytes: TBytes;
begin
  Bytes := aValue;
  SetLength(Bytes, GetDefaultDataSize);
  Move(Bytes[0], aDataStart^, Length(Bytes));
end;

procedure TdfMergeDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  i: integer;
  s: string;
begin
  aValue := '';
  for i := Low(FDefs) to High(FDefs) do begin
    FDefs[i].GetElementEditValue(aElement, aDataStart + FOffsets[i].Offset, aDataStart + FOffsets[i].Offset + FOffsets[i].DataSize, s);
    aValue := aValue + s + FDelimiter;
  end;
  SetLength(aValue, Length(aValue) - Length(FDelimiter));

  // call OnGet* event after value was read
  inherited;
end;

procedure TdfMergeDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  i: integer;
  s: string;
  Value: string;
begin
  // call OnSet* event before value is written
  inherited;

  i := 0;
  for s in SplitString(aValue, FDelimiter) do begin
    if i >= Length(FDefs) then
      Break;

    Value := s;
    FDefs[i].SetElementEditValue(aElement, aDataStart + FOffsets[i].Offset, aDataStart + FOffsets[i].Offset + FOffsets[i].DataSize, Value);
    Inc(i);
  end;
end;

function TdfMerge.Updating: Boolean;
begin
  Result := False;
end;

function TdfMerge.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  i: Integer;
  Value: string;
begin
  Result := inherited;

  if (FDef.DefaultValue = '') and not Assigned(aDataStart) then
    for i := Low(FDef.Defs) to High(FDef.Defs) do
      if FDef.Defs[i].DefaultValue <> '' then with TdfMergeDef(FDef) do begin
        Value := FDef.Defs[i].DefaultValue;
        Defs[i].SetElementEditValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Value);
      end;
end;

function TdfMerge.GetNativeValues(const aPath: string): Variant;
var
  i: integer;
begin
  // real path, call inherited
  if Pos('\', aPath) <> 0 then
    Result := inherited
  // acess by index [N]
  else if (Length(aPath) > 2) and (aPath[1] = '[') and (aPath[Length(aPath)] = ']') then begin
    i := StrToIntDef(Copy(aPath, 2, Length(aPath) - 2), 0);
    with TdfMergeDef(FDef) do
      Defs[i].GetElementNativeValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Result);
  // access by name
  end else
    with TdfMergeDef(FDef) do
    for i := Low(Defs) to High(Defs) do
      if aPath = Defs[i].Name then begin
        Defs[i].GetElementNativeValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Result);
        Exit;
      end;
end;

procedure TdfMerge.SetNativeValues(const aPath: string; const aValue: Variant);
var
  i: integer;
  Value: Variant;
begin
  // real path, call inherited
  if Pos('\', aPath) <> 0 then
    inherited
  // acess by index [N]
  else if (Length(aPath) > 2) and (aPath[1] = '[') and (aPath[Length(aPath)] = ']') then begin
    i := StrToIntDef(Copy(aPath, 2, Length(aPath) - 2), 0);
    Value := aValue;
    with TdfMergeDef(FDef) do
      Defs[i].SetElementNativeValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Value);
  // access by name
  end else
    with TdfMergeDef(FDef) do
    for i := Low(Defs) to High(Defs) do
      if aPath = Defs[i].Name then begin
        Value := aValue;
        Defs[i].SetElementNativeValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Value);
        Exit;
      end;
end;

function TdfMerge.GetEditValues(const aPath: string): string;
var
  i: integer;
begin
  // real path, call inherited
  if Pos('\', aPath) <> 0 then
    Result := inherited
  // acess by index [N]
  else if (Length(aPath) > 2) and (aPath[1] = '[') and (aPath[Length(aPath)] = ']') then begin
    i := StrToIntDef(Copy(aPath, 2, Length(aPath) - 2), 0);
    with TdfMergeDef(FDef) do
      Defs[i].GetElementEditValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Result);
  // access by name
  end else
    with TdfMergeDef(FDef) do
    for i := Low(Defs) to High(Defs) do
      if (aPath = Defs[i].Name) or (aPath = IntToStr(i)) then begin
        Defs[i].GetElementEditValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Result);
        Exit;
      end;
end;

procedure TdfMerge.SetEditValues(const aPath: string; const aValue: string);
var
  i: integer;
  Value: string;
begin
  // real path, call inherited
  if Pos('\', aPath) <> 0 then
    inherited
  // acess by index [N]
  else if (Length(aPath) > 2) and (aPath[1] = '[') and (aPath[Length(aPath)] = ']') then begin
    i := StrToIntDef(Copy(aPath, 2, Length(aPath) - 2), 0);
    Value := aValue;
    with TdfMergeDef(FDef) do
      Defs[i].SetElementEditValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Value);
  // access by name
  end else
    with TdfMergeDef(FDef) do
    for i := Low(Defs) to High(Defs) do
      if (aPath = Defs[i].Name) or (aPath = IntToStr(i)) then begin
        Value := aValue;
        Defs[i].SetElementEditValue(Self, FDataStart + ValueOffset[i], FDataStart + ValueOffset[i] + ValueDataSize[i], Value);
        Exit;
      end;
end;


{ Integer }

function TdfIntegerDef.Clone: TdfDef;
begin
  Result := TdfIntegerDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfIntegerDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfInteger.Create(Self, aParent);
end;

procedure TdfIntegerDef.GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
begin
  case DataType of
    dtU8: aValue := PByte(aDataStart)^;
    dtS8: aValue := PShortInt(aDataStart)^;
    dtU16: aValue := PWord(aDataStart)^;
    dtS16: aValue := PSmallInt(aDataStart)^;
    dtU32: aValue := PCardinal(aDataStart)^;
    dtS32: aValue := PInteger(aDataStart)^;
    dtU64: aValue := PUInt64(aDataStart)^;
    dtS64: aValue := PInt64(aDataStart)^;
  end;
  // call OnGet* event after value was read
  inherited;
end;

procedure TdfIntegerDef.SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
begin
  // call OnSet* event before value is written
  inherited;
  case DataType of
    dtU8: PByte(aDataStart)^ := aValue;
    dtS8: PShortInt(aDataStart)^ := aValue;
    dtU16: PWord(aDataStart)^ := aValue;
    dtS16: PSmallInt(aDataStart)^ := aValue;
    dtU32: PCardinal(aDataStart)^ := aValue;
    dtS32: PInteger(aDataStart)^ := aValue;
    dtU64: PUInt64(aDataStart)^ := aValue;
    dtS64: PInt64(aDataStart)^ := aValue;
  end;
end;

procedure TdfIntegerDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
  Integer64: Int64;
  UInteger64: UInt64;
begin
  GetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
  case DataType of
    dtU8, dtU16, dtU32: aValue := UIntToStr(Value);
    dtS8, dtS16, dtS32: aValue := IntToStr(Value);
    dtU64, dtNone: begin UInteger64 := Value; aValue := IntToStr(UInteger64); end;
    dtS64: begin Integer64 := Value; aValue := IntToStr(Integer64); end;
  end;
  // call OnGet* event after value was read
  inherited;
end;

procedure TdfIntegerDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
begin
  // call OnSet* event before value is written
  inherited;
  case DataType of
    dtU8, dtS8, dtU16, dtS16, dtS32: begin
      if aValue = '' then Value := 0 else Value := StrToInt(aValue);
      SetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
    end;
    dtU32, dtU64, dtS64, dtNone: begin
      if aValue = '' then Value := 0 else Value := StrToInt64(aValue);
      SetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
    end;
  end;
end;


{ Mapped Integer }

function TdfMappedIntegerDef.Clone: TdfDef;
begin
  Result := TdfMappedIntegerDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

procedure TdfMappedIntegerDef.Assign(const aDef: TdfDef);
var
  d: TdfMappedIntegerDef;
  i: Integer;
begin
  inherited;
  if aDef is TdfMappedIntegerDef then begin
    d := TdfMappedIntegerDef(aDef);
    SetLength(FValuesMap, d.ValuesMapCount);
    for i := Low(FValuesMap) to High(FValuesMap) do begin
      FValuesMap[i].Key := d.Keys[i];
      FValuesMap[i].Value := d.Values[i];
    end;
  end;
end;

procedure TdfMappedIntegerDef.AssignValuesMap(const aValuesMap: array of const);
var
  i: integer;
begin
  Assert(Length(aValuesMap) mod 2 = 0);
  SetLength(FValuesMap, Length(aValuesMap) div 2);

  for i := Low(FValuesMap) to High(FValuesMap) do begin
    Assert(aValuesMap[     i * 2 ].VType in [vtInteger, vtInt64]);
    Assert(aValuesMap[Succ(i * 2)].VType in [vtAnsiString, vtChar, vtUnicodeString, vtWideChar]);

    with FValuesMap[i] do begin
      if aValuesMap[i * 2].VType = vtInteger then
        Key := aValuesMap[i * 2].VInteger
      else
        Key := aValuesMap[i * 2].VInt64^;

      if aValuesMap[Succ(i * 2)].VType = vtAnsiString then
        Value  := String(AnsiString(aValuesMap[Succ(i * 2)].VAnsiString))
      else if aValuesMap[Succ(i * 2)].VType = vtChar then
        Value  := String(aValuesMap[Succ(i * 2)].VChar)
      else if aValuesMap[Succ(i * 2)].VType = vtUnicodeString then
        Value  := UnicodeString(aValuesMap[Succ(i * 2)].VUnicodeString)
      else if aValuesMap[Succ(i * 2)].VType = vtWideChar then
        Value  := aValuesMap[Succ(i * 2)].VWideChar;
    end;
  end;
end;

function TdfMappedIntegerDef.GetValuesMapCount: Integer;
begin
  Result := Length(FValuesMap);
end;

function TdfMappedIntegerDef.IndexOfKey(const aKey: Int64): integer;
var
  i: integer;
begin
  Result := -1;
  for i := Low(FValuesMap) to High(FValuesMap) do
    if FValuesMap[i].Key = aKey then begin
      Result := i;
      Break;
    end;
end;

function TdfMappedIntegerDef.IndexOfValue(const aValue: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := Low(FValuesMap) to High(FValuesMap) do
    if FValuesMap[i].Value = aValue then begin
      Result := i;
      Break;
    end;
end;

function TdfMappedIntegerDef.GetKey(Index: integer): Int64;
begin
  Result := FValuesMap[Index].Key;
end;

function TdfMappedIntegerDef.GetValue(Index: integer): string;
begin
  Result := FValuesMap[Index].Value;
end;

function TdfMappedIntegerDef.GetValueByKey(Key: Int64): string;
var
  i: integer;
begin
  i := IndexOfKey(Key);
  if i <> -1 then
    Result := FValuesMap[i].Value
  else
    Result := '';
end;


{ Flags }

function TdfFlagsDef.Clone: TdfDef;
begin
  Result := TdfFlagsDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfFlagsDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfFlags.Create(Self, aParent);
end;

procedure TdfFlagsDef.AssignValuesMap(const aValuesMap: array of const);
var
  i: integer;
begin
  inherited;

  // add unknown bits as "Bit N"
  for i := 0 to Pred(GetDefaultDataSize*8) do
    if IndexOfKey(i) = -1 then begin
      SetLength(FValuesMap, Succ(Length(FValuesMap)));
      FValuesMap[Pred(Length(FValuesMap))].Key := i;
      FValuesMap[Pred(Length(FValuesMap))].Value := 'Bit ' + IntToStr(i);
    end;
end;

procedure TdfFlagsDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Key: Int64;
  i, j: integer;
begin
  inherited;
  Key := StrToInt64(aValue);
  aValue := '';

  for i := 0 to Pred(DefaultDataSize * 8) do begin
    if Key and (1 shl i) = 0 then
      Continue;

    j := IndexOfKey(i);

    if j <> -1 then begin
      if aValue <> '' then
        aValue := aValue + ' ' + sFlagsDelimiter + ' ';
      aValue := aValue + FValuesMap[j].Value;
    end;
  end;
end;

procedure TdfFlagsDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Key: Int64;
  i: integer;
  s: string;
begin
  Key := 0;
  for s in SplitString(aValue, sFlagsDelimiter) do begin
    i := IndexOfValue(Trim(s));
    if i <> -1 then
      Key := Key or (1 shl FValuesMap[i].Key);
    //else
    //  aElement.DoException('Unknown flag ' + s);
  end;
  // set flags only if matched names found or empty string is assigned (clear flags)
  if (Key <> 0) or (aValue = '') then
    s := IntToStr(Key);
  inherited SetElementEditValue(aElement, aDataStart, aDataEnd, s);
end;

function TdfFlags.GetNativeValues(const aPath: string): Variant;
var
  Key: Int64;
  i: integer;
begin
  if Pos('\', aPath) = 0 then
    i := TdfFlagsDef(Def).IndexOfValue(aPath)
  else
    i := -1;

  if i = -1 then
    Result := inherited
  else begin
    Key := NativeValue;
    Result := Key and (1 shl TdfFlagsDef(Def).Keys[i]) <> 0;
  end;
end;

procedure TdfFlags.SetNativeValues(const aPath: string; const aValue: Variant);
var
  Key: Int64;
  i: integer;
begin
  if Pos('\', aPath) = 0 then
    i := TdfFlagsDef(Def).IndexOfValue(aPath)
  else
    i := -1;

  if i = -1 then
    inherited
  else begin
    Key := NativeValue;
    if Boolean(aValue) then
      NativeValue := Key or (1 shl TdfFlagsDef(Def).Keys[i])
    else
      NativeValue := Key and not (1 shl TdfFlagsDef(Def).Keys[i]);
  end;
end;

function TdfFlags.GetEditValues(const aPath: string): string;
begin
  if Pos('\', aPath) <> 0 then
    Result := inherited
  else
    if Boolean(GetNativeValues(aPath)) then
      Result := '1'
    else
      Result := '0';
end;

procedure TdfFlags.SetEditValues(const aPath: string; const aValue: string);
begin
  if Pos('\', aPath) <> 0 then
    inherited
  else
    SetNativeValues(aPath, not ((aValue = '0') or (aValue = '')));
end;


{ Enum }

function TdfEnumDef.Clone: TdfDef;
begin
  Result := TdfEnumDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfEnumDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfEnum.Create(Self, aParent);
end;

procedure TdfEnumDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  i: integer;
begin
  inherited;

  // replace with enumeration value if matched
  i := IndexOfKey(StrToInt64(aValue));
  if i <> -1 then
    aValue := FValuesMap[i].Value;
end;

procedure TdfEnumDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  i: integer;
  s: string;
begin
  // replace with enumeration value if matched
  i := IndexOfValue(Trim(aValue));
  if i <> -1 then
    s := IntToStr(FValuesMap[i].Key)
  else
    s := aValue;

  inherited SetElementEditValue(aElement, aDataStart, aDataEnd, s);
end;


{ Float }

function TdfFloatDef.Clone: TdfDef;
begin
  Result := TdfFloatDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfFloatDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfFloat.Create(Self, aParent);
end;

procedure TdfFloatDef.GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  Value: Extended;
begin
  case DataType of
    dtFloat16: aValue := HalfToFloat(PHalfFloat(aDataStart)^);
    dtFloat32:
      try
        if PCardinal(aDataStart)^ = $7F7FFFFF then
          aValue := MaxSingle
        else if PCardinal(aDataStart)^ = $FF7FFFFF then
          aValue := -MaxSingle
        else if PCardinal(aDataStart)^ = $80000000 then begin
          Value := -0.0;
          aValue := Value;
        end
        else begin
          Value := PSingle(aDataStart)^;
          if True {IsInfinite(Value) or IsNan(Value)} then
            aValue := Value
          else begin
            try
              if Value <> 0.0 then
                if SingleSameValue(Value, 0.0) then
                  Value := 0.0;
            except
              Value := 0.0;
            end;
            aValue := Value;
          end;
        end;
      except
        aValue := NaN;
      end;
  end;
  // call OnGet* event after value was read
  inherited;
end;

procedure TdfFloatDef.SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  Value: Extended;
  S: Single;
begin
  // call OnSet* event before value is written
  inherited;
  Value := aValue;
  S := Value;
  case DataType of
    dtFloat16: PHalfFloat(aDataStart)^ := FloatToHalf(Value);
    dtFloat32: begin
      if VarIsClear(aValue) or IsNaN(Value) then
        PSingle(aDataStart)^ := SingleNaN
      else if IsInfinite(Value) then
        PCardinal(aDataStart)^ := $7F7FFFFF
      else if SameValue(Value, MaxSingle) or (Value > MaxSingle) then
        PCardinal(aDataStart)^ := $7F7FFFFF
      else if SameValue(Value, -MaxSingle) or (Value < -MaxSingle) then
        PCardinal(aDataStart)^ := $FF7FFFFF
      else if PCardinal(@S)^ = $80000000 then
        PCardinal(aDataStart)^ := $80000000
      else
        PSingle(aDataStart)^ := aValue;
    end;
  end;
end;

procedure TdfFloatDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
  F: Extended;
begin
  GetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
  F := Value;
  case DataType of
    dtFloat16: aValue := dfFloatToStr(F);
    // half floats don't need that
    {dtFloat16: begin
      if IsNaN(F) then
        aValue := 'NaN'
      else if IsInfinite(F) then
        aValue := 'Inf'
      else if SameValue(F, MaxHalf) or (F > MaxHalf) then
        aValue := 'Max'
      else if SameValue(F, -MaxHalf) or (F < -MaxHalf) then
        aValue := 'Min'
      else
        aValue := dfFloatToStr(F);
    end;}
    dtFloat32: begin
      if IsNaN(F) then
        aValue := 'NaN'
      else if IsInfinite(F) then
        aValue := 'Inf'
      else if SameValue(F, MaxSingle) or (F > MaxSingle) then
        aValue := 'Max'
      else if SameValue(F, -MaxSingle) or (F < -MaxSingle) then
        aValue := 'Min'
      else
        aValue := dfFloatToStr(F);
    end;
  end;
  // call OnGet* event after value was read
  inherited;
end;

procedure TdfFloatDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
  F: Extended;
begin
  // call OnSet* event before value is written
  inherited;
  case DataType of
    // convert from abbreaviations if assigning from a full float
    dtFloat16: F := dfStrToHalfFloat(aValue);
    dtFloat32: F := dfStrToFloat(aValue);
    else
      F := 0.0;
  end;
  Value := F;
  SetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
end;


{ Bytes }

function TdfBytesDef.Clone: TdfDef;
begin
  Result := TdfBytesDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

function TdfBytesDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfBytes.Create(Self, aParent);
end;

function TdfBytesDef.GetDefaultDataSize: integer;
begin
  if FSize > 0 then
    Result := FSize
  else
    Result := inherited;
end;

procedure TdfBytesDef.GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  Prefix, Bytes: Integer;
  SafeArray: PVarArray;
begin
  if Size < 0 then
    Prefix := -Size
  else
    Prefix := 0;

  Bytes := aDataEnd - aDataStart - Prefix;
  aValue := VarArrayCreate([0, Pred(Bytes)], varByte);
  SafeArray := VarArrayAsPSafeArray(aValue);
  System.Move((aDataStart + Prefix)^, SafeArray.Data^, Bytes);

  // call OnGet* event after value was read
  inherited;
end;

procedure TdfBytesDef.SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  Prefix, Bytes, ValueBytes: Cardinal;
  SafeArray: PVarArray;
begin
  // call OnSet* event before value is written
  inherited;

  if Size < 0 then
    Prefix := -Size
  else
    Prefix := 0;

  SafeArray := VarArrayAsPSafeArray(aValue);
  Assert(SafeArray.ElementSize = 1);
  ValueBytes := SafeArray.Bounds[0].ElementCount;

  // predefined size for fixed array
  if Size > 0 then
    Bytes := Size
  else
    Bytes := ValueBytes;

  // cap at length limited by prefix size
  if (Prefix > 0) and (Bytes >= Cardinal(1) shl Pred(Prefix*8)) then
    Bytes := Pred(Cardinal(1) shl Pred(Prefix*8));

  TdfValue(aElement).AllocateValue(aDataStart, aDataEnd, Bytes + Prefix);

  case Prefix of
    1: PByte(aDataStart)^ := Bytes;
    2: PWord(aDataStart)^ := Bytes;
    4: PCardinal(aDataStart)^ := Bytes;
  end;

  Move(SafeArray.Data^, (aDataStart + Prefix)^, Min(Bytes, ValueBytes));
end;

procedure TdfBytesDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
  Bytes: TBytes;
  i: integer;
  SafeArray: PVarArray;
begin
  GetElementNativeValue(aElement, aDataStart, aDataEnd, Value);

  SafeArray := VarArrayAsPSafeArray(Value);
  Assert(SafeArray.ElementSize = 1);
  SetLength(Bytes, SafeArray.Bounds[0].ElementCount);
  System.Move(SafeArray.Data^, Pointer(Bytes)^, Length(Bytes));


  aValue := '';
  for i := Low(Bytes) to High(Bytes) do
    aValue := aValue + IntToHex(Bytes[i], 2) + ' ';
  SetLength(aValue, Pred(Length(aValue)));

  // call OnGet* event after value was read
  inherited;
end;

procedure TdfBytesDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value  : Variant;
  Bytes  : TBytes;
  i, j   : Integer;
  SafeArray: PVarArray;
begin
  // call OnSet* event before value is written
  inherited;

  SetLength(Bytes, Length(aValue) div 2);
  i := 1;
  j := 0;
  while i <= Length(aValue) do begin
    case aValue[i] of
      ' ', ',', ';': {allowed whitespace}
        Inc(i);
      '0'..'9', 'a'..'f', 'A'..'F': begin
        if i = Length(aValue) then
          aElement.DoException('Unexpected end of value. Single digit in hexadecimal pair');
        if CharInSet(aValue[Succ(i)], ['0'..'9', 'a'..'f', 'A'..'F']) then begin
          Bytes[j] := StrToInt('$'+Copy(aValue,i, 2));
          Inc(j);
          Inc(i, 2);
        end else
          aElement.DoException('"'+aValue[Succ(i)]+'" at position '+IntToStr(Succ(i))+' is not a valid character');
      end;
    else
      aElement.DoException('"'+aValue[i]+'" at position '+IntToStr(i)+' is not a valid character');
    end;
  end;
  SetLength(Bytes, j);

  Value := VarArrayCreate([0, High(Bytes)], varByte);
  SafeArray := VarArrayAsPSafeArray(Value);
  System.Move(Pointer(Bytes)^, SafeArray.Data^, Length(Bytes));

  SetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
end;

function TdfBytes.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  Size: integer;
begin
  // calculate our size and call inherited TdfValue
  Result := 0;
  Size := Def.Size;
  if Size < 0 then begin
    Size := -Size;
    if Assigned(aDataStart) and Enabled then begin
      ValidateData(aDataStart, aDataEnd, Size);
      case Size of
        1: Result := PByte(aDataStart)^;
        2: Result := PWord(aDataStart)^;
        4: Result := PCardinal(aDataStart)^;
      end;
    end;
    Result := Result + Size;
  end
  else if Size = 0 then begin
    if Enabled then
      if Assigned(FDef.OnGetCount) and not Updating then
        FDef.OnGetCount(Self, Result)
      else
        Result := PByte(aDataEnd) - PByte(aDataStart);
  end else
    Result := Size;

  Result := inherited UnSerialize(aDataStart, aDataEnd, Result);
end;


{ Chars }

function TdfCharsDef.Clone: TdfDef;
begin
  Result := TdfCharsDef.Create(FName, FDataType, []);
  Result.Assign(Self);
end;

procedure TdfCharsDef.Assign(const aDef: TdfDef);
begin
  inherited;
  if aDef is TdfCharsDef then begin
    FTerminator := TdfCharsDef(aDef).Terminator;
    FTerminated := TdfCharsDef(aDef).Terminated;
  end;
end;

function TdfCharsDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TdfChars.Create(Self, aParent);
end;

function TdfCharsDef.GetDefaultDataSize: integer;
begin
  if FSize > 0 then
    Result := FSize
  else
    Result := inherited;
end;

procedure TdfCharsDef.GetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
var
  s: AnsiString;
begin
  TdfChars(aElement).ReadChars(aDataStart, aDataEnd, s);
  aValue := UTF8ToString(s);
  // call OnGet* event after value was read
  inherited;
end;

procedure TdfCharsDef.SetElementNativeValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: Variant);
begin
  // call OnSet* event before value is written
  inherited;
  TdfChars(aElement).WriteChars(AnsiString(UTF8Encode(aValue)));
end;

procedure TdfCharsDef.GetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
begin
  GetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
  aValue := Value;
  // call OnGet* event after value was read
  inherited;
end;

procedure TdfCharsDef.SetElementEditValue(const aElement: TdfElement; aDataStart, aDataEnd: PByte; var aValue: string);
var
  Value: Variant;
begin
  // call OnSet* event before value is written
  inherited;
  Value := aValue;
  SetElementNativeValue(aElement, aDataStart, aDataEnd, Value);
end;

function TdfChars.ReadChars(const aDataStart, aDataEnd: Pointer; var aString: AnsiString): Integer;
var
  Size, StringSize: Integer;
  PData: PByte;
  Terminated: Boolean;
  Term: Byte;
begin
  Size := Def.Size;
  Terminated := TdfCharsDef(Def).Terminated;
  // predefined size
  if Size > 0 then begin
    ValidateData(aDataStart, aDataEnd, Size);
    Result := Size;
    // omit terminator
    if Terminated then
      Dec(Size);
    SetLength(aString, Size);
    System.Move(aDataStart^, aString[1], Size);
  end

  // variable length
  else if Size = 0 then begin
    // not terminated - copy all the available data
    if not Terminated then begin
      Size := PByte(aDataEnd) - PByte(aDataStart);
      Result := Size;
      SetLength(aString, Size);
      System.Move(aDataStart^, aString[1], Size);
    end
    // terminated - copy up to terminator char
    else begin
      ValidateData(aDataStart, aDataEnd, 1); // has terminator at least
      PData := aDataStart;
      Term := Byte(TdfCharsDef(Def).Terminator);
      while (PData < PByte(aDataEnd)) and (PData^ <> Term) do
        Inc(PData);
      // terminator not found
      if PData = PByte(aDataEnd) then
        DoException('Terminator character not found for terminated string');

      Result := PData - PByte(aDataStart) + 1; // length including terminator
      SetLength(aString, Pred(Result));
      if Result > 1 then
        System.Move(aDataStart^, aString[1], Pred(Result));
    end;
  end

  // Size < 0, prefixed string
  else begin
    Size := -Size;
    ValidateData(aDataStart, aDataEnd, Size);

    PData := aDataStart;
    case Size of
      1: StringSize := PByte(PData)^;
      2: StringSize := PWord(PData)^;
      4: StringSize := PCardinal(PData)^;
      else StringSize := 0;
    end;
    Result := Size + StringSize;
    ValidateData(aDataStart, aDataEnd, Result);

    // exception if no terminator
    {if (StringSize > 0) and Terminated then begin
      if PAnsiChar(PData + Pred(Result))^ <> TdfCharsDef(Def).Terminator then
        DoException('Prefixed terminated string does not end with terminator');
      Dec(StringSize);
    end;}

    // no exception, but don't omit the last char if it is not a terminator
    if (StringSize > 0) and Terminated and (PAnsiChar(PData + Pred(Result))^ = TdfCharsDef(Def).Terminator) then
      Dec(StringSize);

    if StringSize < 0 then
      DoException('Prefixed string size is negative');

    SetLength(aString, StringSize);
    if StringSize <> 0 then begin
      Inc(PData, Size);
      System.Move(PData^, aString[1], StringSize);
    end;
  end;
end;

procedure TdfChars.WriteChars(const aString: AnsiString);
var
  Size: integer;
  StringSize: Cardinal;
  Terminated: Boolean;
begin
  Size := Def.Size;
  Terminated := TdfCharsDef(Def).Terminated;
  // predefined size
  if Size > 0 then begin
    //SetLength(FValue, Size);
    AllocateValue(Size);
    FillChar(FDataStart^, Size, TdfCharsDef(Def).Terminator);
    StringSize := Length(aString);
    if StringSize > Cardinal(Size) then StringSize := Size;
    if StringSize <> 0 then
      System.Move(aString[1], FDataStart^, Length(aString));
    if Terminated then
      (FDataStart + Pred(Size))^ := Byte(TdfCharsDef(Def).Terminator);
  end
  // variable length
  else if Size = 0 then begin
    //SetLength(FValue, Length(aString));
    AllocateValue(Length(aString));
    System.Move(aString[1], FDataStart^, Length(aString));
    if TdfCharsDef(Def).Terminated then begin
      //SetLength(FValue, Succ(Length(FValue)));
      AllocateValue(Length(aString) + 1);
      //[Pred(Length(FValue))] := Byte(TdfCharsDef(Def).Terminator);
      (FDataEnd - 1)^ := Byte(TdfCharsDef(Def).Terminator);
    end;
  end
  // Size < 0, prefixed string
  else begin
    Size := -Size;
    StringSize := Length(aString);
    if Terminated then
      Inc(StringSize);
    // cap at length limited by prefix size
    if StringSize >= Cardinal(1) shl Pred(Size*8) then
      StringSize := Pred(Cardinal(1) shl Pred(Size*8));

    //SetLength(FValue, Cardinal(Size) + StringSize);
    AllocateValue(Cardinal(Size) + StringSize);
    case Size of
      1: PByte(FDataStart)^ := StringSize;
      2: PWord(FDataStart)^ := StringSize;
      4: PCardinal(FDataStart)^ := StringSize;
    end;
    if Terminated then
      Dec(StringSize);

    System.Move(aString[1], (FDataStart + Size)^, StringSize);

    if Terminated then
      (FDataEnd - 1)^ := Byte(TdfCharsDef(Def).Terminator);
  end;
end;

function TdfChars.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  s: AnsiString;
begin
  if not Assigned(aDataStart) then begin
    Result := inherited;
    // set terminator if string is terminated
    // if it has DefaultValue then it was already set in inherited call
    if TdfCharsDef(Def).Terminated and (Def.DefaultValue = '') then
      WriteChars(AnsiString(''));
  end
  else if Enabled then
    // read calculated chars or init with default value if 0
    Result := inherited UnSerialize(aDataStart, aDataEnd, ReadChars(aDataStart, aDataEnd, s))
  else
    Result := 0;
end;




{ Definition Functions }

function dfStruct(
  const aName: string;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TdfStructDef;
begin
  Result := TdfStructDef.Create(aName, dtStruct, aDefs);
  Result.AssignEvents(aEvents);
end;

function dfStruct(const aName: string; const aDefs: array of TdfDef): TdfStructDef;
begin
  Result := dfStruct(aName, aDefs, []);
end;


function dfArray(
  const aName: string;
  const aMemberDef: TdfDef;
  aSize: integer;
  const aCounter: string;
  const aEvents: array of const
): TdfArrayDef;
begin
  Assert((aSize >= 0) or (aSize = -1) or (aSize = -2) or (aSize = -4));
  if aCounter <> '' then Assert(aSize = 0); // of counter element is set, Size should be 0
  Result := TdfArrayDef.Create(aName, dtArray, [aMemberDef]);
  Result.Size := aSize;
  Result.Counter := aCounter;
  Result.AssignEvents(aEvents);
end;

function dfArray(const aName: string; const aMemberDef: TdfDef; aSize: integer): TdfArrayDef;
begin
  Result := dfArray(aName, aMemberDef, aSize, '', []);
end;

function dfArray(const aName: string; const aMemberDef: TdfDef; const aCounter: string): TdfArrayDef;
begin
  Result := dfArray(aName, aMemberDef, 0, aCounter, []);
end;


function dfUnion(
  aDecider: TdfOnDecideEvent;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TdfUnionDef;
begin
  Assert(Length(aDefs) > 1);
  Result := TdfUnionDef.Create('', dtUnion, aDefs);
  Result.OnDecide := aDecider;
  Result.AssignEvents(aEvents);
end;

function dfUnion(const aDefs: array of TdfDef; const aEvents: array of const): TdfUnionDef;
begin
  Result := dfUnion(nil, aDefs, aEvents);
end;

function dfUnion(aDecider: TdfOnDecideEvent; const aDefs: array of TdfDef): TdfUnionDef;
begin
  Result := dfUnion(aDecider, aDefs, []);
end;


function dfValueUnion(
  aDataType: TdfDataType;
  aDecider: TdfOnDecideEvent;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TdfValueUnionDef;
begin
  Assert(aDataType in [dtU8, dtS8, dtU16, dtS16, dtU32, dtS32, dtU64, dtS64]);
  Assert(Length(aDefs) > 1);
  Result := TdfValueUnionDef.Create('', aDataType, aDefs);
  Result.OnDecide := aDecider;
  Result.AssignEvents(aEvents);
end;

function dfValueUnion(aDataType: TdfDataType; aDecider: TdfOnDecideEvent; const aDefs: array of TdfDef): TdfValueUnionDef;
begin
  Result := dfValueUnion(aDataType, aDecider, aDefs, []);
end;


function dfMerge(
  const aName: string;
  const aDefs: array of TdfDef;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfMergeDef;
begin
  Result := TdfMergeDef.Create(aName, dtMerge, aDefs);
  Result.DefaultValue := aDefaultValue;
  Result.AssignEvents(aEvents);
end;

function dfMerge(const aName: string; const aDefs: array of TdfDef; const aEvents: array of const): TdfMergeDef;
begin
  Result := dfMerge(aName, aDefs, '', aEvents);
end;

function dfMerge(const aName: string; const aDefs: array of TdfDef): TdfMergeDef;
begin
  Result := dfMerge(aName, aDefs, '', []);
end;


function dfInteger(
  const aName: string;
  aDataType: TdfDataType;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfIntegerDef;
begin
  Assert(aDataType in [dtNone, dtU8, dtS8, dtU16, dtS16, dtU32, dtS32, dtU64, dtS64]);
  Result := TdfIntegerDef.Create(aName, aDataType, []);
  Result.DefaultValue := aDefaultValue;
  Result.AssignEvents(aEvents);
end;

function dfInteger(const aName: string; aDataType: TdfDataType; const aDefaultValue: string): TdfIntegerDef;
begin
  Result := dfInteger(aName, aDataType, aDefaultValue, []);
end;

function dfInteger(const aName: string; aDataType: TdfDataType; const aEvents: array of const): TdfIntegerDef;
begin
  Result := dfInteger(aName, aDataType, '', aEvents);
end;

function dfInteger(const aName: string; aDataType: TdfDataType): TdfIntegerDef;
begin
  Result := dfInteger(aName, aDataType, '', []);
end;

procedure GetTextHexInt(const aElement: TdfElement; var aText: string);
begin
  aText := IntToHex(StrToInt64(aText), aElement.DataSize * 2);
end;

procedure SetTextHexInt(const aElement: TdfElement; var aText: string);
begin
  try
    aText := IntToStr(StrToInt64('$' + aText));
  except
    raise Exception.Create('Invalid hex value');
  end;
end;

function dfHexInteger(const aName: string; aDataType: TdfDataType): TdfDef;
begin
  Result := dfInteger(aName, aDataType, [
    DF_OnGetText, @GetTextHexInt,
    DF_OnSetText, @SetTextHexInt
  ]);
end;



function dfFlags(
  const aName: string;
  aDataType: TdfDataType;
  const aFlags: array of const;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfFlagsDef;
begin
  Assert(aDataType in [dtNone, dtU8, dtS8, dtU16, dtS16, dtU32, dtS32, dtU64, dtS64]);
  Result := TdfFlagsDef.Create(aName, aDataType, []);
  Result.DefaultValue := aDefaultValue;
  Result.AssignEvents(aEvents);
  Result.AssignValuesMap(aFlags);
end;

function dfFlags(const aName: string; aDataType: TdfDataType; const aFlags: array of const): TdfFlagsDef;
begin
  Result := dfFlags(aName, aDataType, aFlags, '', []);
end;

function dfEnum(
  const aName: string;
  aDataType: TdfDataType;
  const aValues: array of const;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfEnumDef;
begin
  Assert(aDataType in [dtNone, dtU8, dtS8, dtU16, dtS16, dtU32, dtS32, dtU64, dtS64]);
  Result := TdfEnumDef.Create(aName, aDataType, []);
  Result.DefaultValue := aDefaultValue;
  Result.AssignEvents(aEvents);
  Result.AssignValuesMap(aValues);
end;

function dfEnum(const aName: string; aDataType: TdfDataType; const aValues: array of const): TdfEnumDef;
begin
  Result := dfEnum(aName, aDataType, aValues, '', []);
end;

function dfBool(const aName: string; aDataType: TdfDataType; const aDefaultValue: string; const aEvents: array of const): TdfEnumDef;
begin
  Result := dfEnum(aName, aDataType, [0, 'no', 1, 'yes'], aDefaultValue, aEvents);
end;

function dfBool(const aName: string; aDataType: TdfDataType; const aDefaultValue: string): TdfEnumDef;
begin
  Result := dfBool(aName, aDataType, aDefaultValue, []);
end;

function dfBool(const aName: string; aDataType: TdfDataType; const aEvents: array of const): TdfEnumDef;
begin
  Result := dfBool(aName, aDataType, '', [])
end;

function dfBool(const aName: string; aDataType: TdfDataType): TdfEnumDef;
begin
  Result := dfBool(aName, aDataType, []);
end;


function dfFloat(
  const aName: string;
  aDataType: TdfDataType;
  const aDefaultValue: string;
  const aEvents: array of const
): TdfFloatDef;
begin
  Assert(aDataType in [dtFloat16, dtFloat32]);
  Result := TdfFloatDef.Create(aName, aDataType, []);
  Result.DefaultValue := aDefaultValue;
  Result.AssignEvents(aEvents);
end;

function dfFloat(const aName: string; aDataType: TdfDataType): TdfFloatDef;
begin
  Result := dfFloat(aName, aDataType, '', []);
end;

function dfFloat(const aName: string; const aDefaultValue: string; const aEvents: array of const): TdfFloatDef;
begin
  Result := dfFloat(aName, dtFloat32, aDefaultValue, aEvents);
end;

function dfFloat(const aName: string; const aEvents: array of const): TdfFloatDef;
begin
  Result := dfFloat(aName, dtFloat32, '', aEvents);
end;

function dfFloat(const aName: string; const aDefaultValue: string): TdfFloatDef;
begin
  Result := dfFloat(aName, dtFloat32, aDefaultValue, []);
end;

function dfFloat(const aName: string): TdfFloatDef;
begin
  Result := dfFloat(aName, dtFloat32, '', []);
end;

function dfBytes(
  const aName: string;
  aSize: integer;
  const aEvents: array of const
): TdfBytesDef;
begin
  Result := TdfBytesDef.Create(aName, dtBytes, []);
  Result.Size := aSize;
  Result.AssignEvents(aEvents);
end;

function dfBytes(const aName: string; aSize: integer): TdfBytesDef;
begin
  Result := dfBytes(aName, aSize, []);
end;


function dfChars(
  const aName: string;
  aSize: integer;
  const aDefaultValue: string;
  aTerminator: AnsiChar;
  aTerminated: Boolean;
  const aEvents: array of const
): TdfCharsDef;
begin
  Result := TdfCharsDef.Create(aName, dtChars, []);
  Result.Size := aSize;
  Result.DefaultValue := aDefaultValue;
  Result.Terminator := aTerminator;
  Result.Terminated := aTerminated;
  Result.AssignEvents(aEvents);
end;

end.

