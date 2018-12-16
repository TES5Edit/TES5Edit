{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvInterpreter.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Andrei Prygounkov <a dott prygounkov att gmx dott de>
Copyright (c) 1999, 2002 Andrei Prygounkov
All Rights Reserved.

Contributor(s): Dmitry Osinovsky, Peter Thornqvist, Olga Kobzar
                Peter Schraut (http://www.console-de.de)
                Ivan Ravin (ivan_ra)

Portions created by Dmitry Osinovsky and Olga Kobzar are
Copyright (C) 2003 ProgramBank Ltd.
All Rights Reserved.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

component   : JvInterpreterProgram and more..
description : JVCL Interpreter version 2

Known Issues:
   String fields in records binded from Delphi don't work
-----------------------------------------------------------------------------}
// $Id$

{ history (JVCL Library versions):
  1.10:
   - first release;
  1.12:
   - method HandleException removed as bugged;
   - method UpdateExceptionPos now fill error message
     with error Unit name and Line pos;
   - fixed bug in TJvInterpreterUnit.Assignment method;
   - new public property BaseErrLine used in UpdateExceptionPos;
  1.17.7:
   - local "const" statement for functions;
   - global variables and constants - scope on all units - not normal !;
   - OnGetValue and OnSetValue now called before call to Adapter;
   - fixed bug with "Break" statement inside "for" loop;
  1.17.10:
   - fixed(?) bug with "begin/end" statement in "else" part of "if" statement;
   - fixed few bugs in ole automation support;
  1.21.2 (RALib 1.21 Update 2):
   - fixed bug with multiple external functions defintions
     (greetings to Peter Fischer-Haaser)
   - fixed AV-bug in TJvInterpreterFunction.InFunction if errors in source occurred
     (greetings to Andre N Belokon)
  1.21.4 (RALib 1.21 Update 4):
   - fixed bugs in "if" and "while" with "begin" statements;
   - "div" and "mod" now working;
  1.21.6 (RALib 1.21 Update 6):
   - fixed bug with incorrect error line and unit name if erorr
     occurred in used unit
     (greetings to Dmitry Mokrushin)
   - add parameters check (not fully functional - only count checked)
     in source fucntion calls;
  1.31.2 (RALib 1.31 Update 2):
   - fixed bug: sometimes compare-operators ('=', '>', ...)
     in expressions do not working.
  1.31.4 (RALib 1.31 Update 4):
   - fixed bug: plus and minus operators after symbol ']' not working.
  1.31.5 (RALib 1.31 Update 5):
   - function Statement1 is changed; this remove many bugs and add new ones.
   - fixed many bug in exception handling statements and in nested
     "begin/end" statements;
   - fixed error with source function with TObject (and descendants)
     returning values;
  1.41.1:
   - another fix for bug with incorrect error line and unit name
     if erorr occurred in used unit;
   - fixed bug with "Break" statement;
   - "exit" statement;
   - "repeat" loop;
  1.50:
   - behavior of "UseGlobalAdapter" property was changed; in previous versions
     each TJvInterpreterExpression component creates its own copy of GlobalAdapter and
     then manage it own copy, but now TJvInterpreterExpression manages two adapters:
     own and global, so GlobalJvInterpreterAdapter now is used by all TJvInterpreterExpressions;
     performance of "Compile" function increased (there is no necessity
     more to Assign adapters) (20 msec on my machine with JvInterpreter_all unit)
     and memory requirement decreased;
   - sorting in TJvInterpreterAdapter dramatically increase its performance speed;
   - fixed bug in "except/on" statement;
  1.51:
   - arrays as local and global variables. supports simple types (Integer,
     double, string, tdatetime, object).
     Added by Andrej Olejnik (olej att asset dott sk);
   - type conversion with Integer, string, TObject,... keywords;
  1.51.2:
   - array support was rewritten;
     enhanced indexes support: default indexed properties,
     access to chars in strings. Many changes are made to make this possible:
     new methods: GetElement, SetElement;
   - record support is simplified;
   - new property TJvInterpreterExpression.Error provide extended error information
     about non-interpreter errors.
   - "case" statement; not fully implemented - only one expression for one block.
  1.52:
   - TJvInterpreterExpression.JvInterpreterAdapter property renamed to Adapter;
   - new public property TJvInterpreterExpression.SharedAdapter, setting to
     GlobalJvInterpreterAdapter by default. This allows to create set of global adapters,
     shared between TJvInterpreterExpression components;
   - property TJvInterpreterExpression.GlobalAdapter removed; setting SharedAdapter
     to nil has same effect as GlobalAdapter := False;
   - fixed memory bug in event handling;
   - new: unit name in uses list can be placed in quotes and contains any symbols;
   - fixed bug: selector in case-statement not working with variables (only constants)
  1.53:
   - fixed bug: "Type mistmatch error" in expressions with OleAutomation objects;
   - fixed bug: error while assign function's result to object's published property;
   - call to external functions (placed in dll) in previous versions always
     return Integer, now it can return Boolean, if declared so;
  1.54:
   - new: in call to external function var-parameters are supported for
     Integer type;
   - new: after call to external function (placed in dll) last win32 error
     is restored correctly; in previous versions it was overriden by call to
     FreeLibrary;
   - fixed bug: memory leak: global variables and constants not allways be freed;
  1.60:
   - bug fixed in case-statement;
   - new: global variables and constants in different units now can have
     identical names;
   - new: constants, variables and functions can have prefix with unit name
     and point to determine appropriate unit;
   - new: class declaration for forms (needed for TJvInterpreterFm component);
   - bug fixed: record variables do not work;
  1.61:
   - bug fixed: variable types are not always kept the same when
     assigning values to them;
     thanks to Ritchie Annand (RitchieA att malibugroup dott com);
   - bug fixed: exceptions, raised in dll calls produce AV.
     fix: exception of class Exception is raised.
   - new internal: LocalVars property in TJvInterpreterFunction (it is used in TJvInterpreterFm).
  2.00:
   - Delphi 6 compatibility;
   - Kylix 1 compatibility;
   - exception handling was rewriten in more portable way,
     ChangeTopException function is not used anymore;
   - fixed bug: intefrace section was not processed correct
     (Thanks to Ivan Ravin);
Upcoming JVCL 3.00
   - major code cleanups
   - introduced data type system for variables and record fields initializations
   - interface (IInterface, IUnknown) method call support, see AddIntfGet
   - record declaration support
   - arrays of records, arrays of arrays
   - dynamic arrays
   - variant array support
   - arrays as parameters to Delphi procedures (sorry, no support for arrays
     as procedure parameters)
   - fixed record bugs with Delphi 6
   - fixed OLE bugs
   - (rom) added fix for default properties from ivan_ra  26 Dec 2003

   - (wap) fixed bug: memory leak in local-function LeaveFunction, part of
      TJvInterpreterFunction.InFunction.  See code marker VARLEAKFIX.
      (Fix suggested by ivan_ra att mail dott ru)

   - bug fixed: exceptions, raised in Assign nil to Method property  - dejoy-2004-3-13
   - fixed  Character '"' error in SkipToEnd from dejoy 2004-5-25;

   - peter schraut added shl, shr and xor support
}

unit JvInterpreter;

{$I jvcl.inc}

{.$DEFINE JvInterpreter_DEBUG}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  Variants,
  JvInterpreterParser, JvComponentBase;

const
  // (rom) renamed to longer names
  { max arguments to functions - small values increase performance }
  cJvInterpreterMaxArgs = 32;

  { max fields allowed in records }
  cJvInterpreterMaxRecFields = 32;

  // (rom) added
  cJvInterpreterStackMax = 199;

  { Max available dimensions for arrays }
  JvInterpreter_MAX_ARRAY_DIMENSION = 10;

type

  {$IFNDEF COMPILER12_UP}
  NativeInt = Integer; // also redeclare for Delphi 2007 where it is declared as Int64
  {$ENDIF ~COMPILER12_UP}

  { argument definition }
  PValueArray = ^TValueArray;
  TValueArray = array [0..cJvInterpreterMaxArgs] of Variant;
  PTypeArray = ^TTypeArray;
  TTypeArray = array [0..cJvInterpreterMaxArgs] of Word;
  PNameArray = ^TNameArray;
  TNameArray = array [0..cJvInterpreterMaxArgs] of string;

  TJvInterpreterArgs = class;
  IJvInterpreterDataType = interface;

  TJvInterpreterGetValue = procedure(Sender: TObject; Identifier: string; var Value: Variant;
    Args: TJvInterpreterArgs; var Done: Boolean) of object;
  TJvInterpreterSetValue = procedure(Sender: TObject; Identifier: string;
    const Value: Variant; Args: TJvInterpreterArgs; var Done: Boolean) of object;
  TJvInterpreterGetUnitSource = procedure(UnitName: string; var Source: string;
    var Done: Boolean) of object;

  TJvInterpreterAdapterGetValue = procedure(var Value: Variant; Args: TJvInterpreterArgs);
  TJvInterpreterAdapterSetValue = procedure(const Value: Variant; Args: TJvInterpreterArgs);
  TJvInterpreterAdapterNewRecord = procedure(var Value: Pointer);
  TJvInterpreterAdapterDisposeRecord = procedure(const Value: Pointer);
  TJvInterpreterAdapterCopyRecord = procedure(var Dest: Pointer; const Source: Pointer);

  POpenArray = ^TOpenArray;
  TOpenArray = array [0..cJvInterpreterMaxArgs] of TVarRec;

  TJvInterpreterRecField = record
    Identifier: string;
    Offset: Integer;
    Typ: Word;
    DataType: IJvInterpreterDataType;
  end;

  TJvInterpreterArgs = class(TObject)
  private
    FVarNames: TNameArray;
    FHasVars: Boolean;
    { open array parameter support }
    { allocates memory only if necessary }
    FOAV: PValueArray; { open array values }
  public
    Identifier: string;
    Count: Integer;
    Types: TTypeArray;
    Values: TValueArray;
    Names: TNameArray;
    HasResult: Boolean; { = False, if result not needed - used by calls
                          to OLE automation servers }
    Assignment: Boolean; { internal }
    Obj: TObject;
    ObjTyp: Word; { varObject, varClass, varUnknown }
    ObjRefHolder: Variant; { if ObjType is varDispatch or varUnknown,
                              then we need to hold a reference to it }

    Indexed: Boolean; // if True then Args contain Indexes to Identifier
    ReturnIndexed: Boolean; // established by GetValue function, indicating
                            // what Args used as indexed (matters only if Indexed = True)
  public
    { open array parameter support }
    OA: POpenArray; { open array }
    OAS: Integer; { open array size }
    destructor Destroy; override;
    procedure Clear;
    procedure OpenArray(const Index: Integer);
    procedure Delete(const Index: Integer);
  end;

  { function descriptor }
  TJvInterpreterFunctionDesc = class(TObject)
  private
    FUnitName: string;
    FIdentifier: string;
    FClassIdentifier: string; { class name, if function declared as
                                TClassIdentifier.Identifier}
    FParamCount: Integer; { - 1..cJvInterpreterMaxArgs }
    FParamTypes: TTypeArray;
    FParamTypeNames: TNameArray;
    FParamNames: TNameArray;
    FResTyp: Word;
    FResTypName: string;
    FResDataType: IJvInterpreterDataType;
    FPosBeg: Integer; { position in source }
    FPosEnd: Integer;
    function GetParamName(Index: Integer): string;
    function GetParamType(Index: Integer): Word;
    function GetParamTypeNames(Index: Integer): string;
    function GetDefine: string;
  public
    {$WARNINGS OFF} // Delphi 2009+ has a class function UnitName
    property UnitName: string read FUnitName;
    {$WARNINGS ON}
    property Identifier: string read FIdentifier;
    property ClassIdentifier: string read FClassIdentifier;
    property Define: string read GetDefine;
    property ParamCount: Integer read FParamCount;
    property ParamTypes[Index: Integer]: Word read GetParamType;
    property ParamNames[Index: Integer]: string read GetParamName;
    property ParamTypeNames[Index: Integer]: string read GetParamTypeNames;
    property ResTyp: Word read FResTyp;
    property ResTypName: string read FResTypName;
    property ResDataType: IJvInterpreterDataType read FResDataType;
    property PosBeg: Integer read FPosBeg;
    property PosEnd: Integer read FPosEnd;
  end;

  TSimpleEvent = procedure of object;
  TJvInterpreterExpression = class;
  EJvInterpreterError = class;

  TJvInterpreterEvent = class(TObject)
  private
    FOwner: TJvInterpreterExpression;
    FInstance: TObject;
    FUnitName: string;
    FFunctionName: string;
    FPropName: string;
    FArgs: TJvInterpreterArgs;
    function GetArgs: TJvInterpreterArgs;
  protected
    constructor Create(AOwner: TJvInterpreterExpression; AInstance: TObject;
      const AUnitName, AFunctionName, APropName: string); virtual;
    function CallFunction(Args: TJvInterpreterArgs; Params: array of Variant): Variant;
    property Args: TJvInterpreterArgs read GetArgs;
    property Owner: TJvInterpreterExpression read FOwner;
    property Instance: TObject read FInstance;
    {$WARNINGS OFF} // Delphi 2009+ has a class function UnitName
    property UnitName: string read FUnitName;
    {$WARNINGS ON}
    property FunctionName: string read FFunctionName;
    property PropName: string read FPropName;
  public
    destructor Destroy; override;
  end;

  TJvInterpreterEventClass = class of TJvInterpreterEvent;

  { variable holder }
  TJvInterpreterVar = class(TObject)
  public
    UnitName: string;
    Identifier: string;
    Typ: string;
    VTyp: Word;
    Value: Variant;
  public
    destructor Destroy; override;
  end;

  { variables list }
  TJvInterpreterVarList = class(TList)
  public
    destructor Destroy; override;
    procedure Clear; override;
    procedure AddVar(const UnitName, Identifier, Typ: string; VTyp: Word;
      const Value: Variant; DataType: IJvInterpreterDataType);
    function FindVar(const UnitName, Identifier: string): TJvInterpreterVar;
    procedure DeleteVar(const UnitName, Identifier: string);
    function GetValue(const Identifier: string; var Value: Variant; Args: TJvInterpreterArgs): Boolean;
    function SetValue(const Identifier: string; const Value: Variant; Args: TJvInterpreterArgs): Boolean;
    procedure Assign(source: TJvInterpreterVarList);
  end;
 { notes about TJvInterpreterVarList implementation:
   - list must allow to contain more than one Var with same name;
   - FindVar must return last added Var with given name;
   - DeleteVar must delete last added Var with given name; }

  TJvInterpreterIdentifier = class(TObject)
  public
    UnitName: string;
    Identifier: string;
    Data: Pointer; // provided by user when call to adapter's addxxx methods
  end;

  TJvInterpreterIdentifierList = class(TList)
  private
    FDuplicates: TDuplicates;
  public
    function IndexOf(const UnitName, Identifier: string): TJvInterpreterIdentifier;
    function Find(const Identifier: string; var Index: Integer): Boolean;
    procedure Sort(Compare: TListSortCompare = nil); virtual;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
  end;

  TJvInterpreterMethodList = class(TJvInterpreterIdentifierList)
  public
    procedure Sort(Compare: TListSortCompare = nil); override;
  end;

  IJvInterpreterDataType = interface
    ['{8C5E4071-65AB-11D7-B235-00A0D2043DC7}']
    procedure Init(var V: Variant);
    function GetTyp: Word;
  end;

  //move from implementation section to  interface section
  TParamCount = -1..cJvInterpreterMaxArgs;

  TCallConvention = set of (ccFastCall, ccStdCall, ccCDecl, ccDynamic,
    ccVirtual, ccClass);

  { Adapter classes - translates data from JvInterpreter calls to Delphi functions }
  TJvInterpreterSrcUnit = class(TJvInterpreterIdentifier)
  private
    FSource: string;
    FUsesList: TNameArray;
  public
    function UsesList: TNameArray;
    property Source: string read FSource;
    // Removed because BCB doesn't support it
    //property UsesList: TNameArray read FUsesList;
  end;

  TJvInterpreterMethod = class(TJvInterpreterIdentifier)
  protected
    FClassType: TClass;
    ParamCount: TParamCount;
    ParamTypes: TTypeArray; { varInteger, varString, .. }
    ResTyp: Word; { varInteger, varString, .. }
    Func: Pointer; { TJvInterpreterAdapterGetValue or TJvInterpreterAdapterSetValue }
  end;

  TJvInterpreterIntfMethod = class(TJvInterpreterIdentifier)
  protected
    IID: TGUID;
    ParamCount: TParamCount;
    ParamTypes: TTypeArray; { varInteger, varString, .. }
    ResTyp: Word; { varInteger, varString, .. }
    Func: Pointer; { TJvInterpreterAdapterGetValue or TJvInterpreterAdapterSetValue }
  end;

  TJvInterpreterDMethod = class(TJvInterpreterMethod)
  protected
    ResTyp: Word;
    CallConvention: TCallConvention;
  end;

  TJvInterpreterClass = class(TJvInterpreterIdentifier)
  private
    FClassFields:TJvInterpreterVarList;
  protected
    FClassType: TClass;
  public
    property ClassFields:TJvInterpreterVarList read FClassFields;
    constructor Create;
    destructor Destroy; override;
  end;

  TJvInterpreterConst = class(TJvInterpreterIdentifier)
  protected
    Value: Variant;
  end;

  TJvInterpreterRecFields = array [0..cJvInterpreterMaxRecFields] of TJvInterpreterRecField;

  TJvInterpreterRecord = class(TJvInterpreterIdentifier)
  protected
    RecordSize: Integer; { SizeOf(Rec^) }
    FieldCount: Integer;
    Fields: TJvInterpreterRecFields;
    CreateFunc: TJvInterpreterAdapterNewRecord;
    DestroyFunc: TJvInterpreterAdapterDisposeRecord;
    CopyFunc: TJvInterpreterAdapterCopyRecord;
    procedure AddField(const UnitName, Identifier, Typ: string; VTyp: Word;
      const Value: Variant; DataType: IJvInterpreterDataType);
    procedure NewRecord(var Value: Variant);
  end;

  TJvInterpreterRecMethod = class(TJvInterpreterIdentifier)
  protected
    JvInterpreterRecord: TJvInterpreterRecord;
    ParamCount: TParamCount;
    ParamTypes: TTypeArray; { varInteger, varString and so one .. }
    ResTyp: Word; { varInteger, varString, .. }
    Func: Pointer; { TJvInterpreterAdapterGetValue or TJvInterpreterAdapterSetValue }
  end;

  TJvInterpreterRecHolder = class(TJvInterpreterIdentifier)
  protected
    FRecordType: string;
    JvInterpreterRecord: TJvInterpreterRecord;
    Rec: Pointer; { data }
  public
    constructor Create(const ARecordType: string; ARec: Pointer);
    destructor Destroy; override;
    property RecordType: string read FRecordType;
  end;

  TJvInterpreterArrayValues = array [0..JvInterpreter_MAX_ARRAY_DIMENSION - 1] of Integer;

  PJvInterpreterArrayRec = ^TJvInterpreterArrayRec;
  TJvInterpreterArrayRec = packed record
    Dimension: Integer; {number of dimensions}
    BeginPos: TJvInterpreterArrayValues; {starting range for all dimensions}
    EndPos: TJvInterpreterArrayValues; {ending range for all dimensions}
    ItemType: Integer; {array type}
    DT: IJvInterpreterDataType;
    ElementSize: Integer; {size of element in bytes}
    Size: Integer; {number of elements in array}
    Memory: Pointer; {pointer to memory representation of array}
  end;

  { interpreter function }
  TJvInterpreterSrcFunction = class(TJvInterpreterIdentifier)
  private
    FFunctionDesc: TJvInterpreterFunctionDesc;
  public
    constructor Create;
    destructor Destroy; override;
    property FunctionDesc: TJvInterpreterFunctionDesc read FFunctionDesc; //Move From Private section
  end;

  { external function }
  TJvInterpreterExtFunction = class(TJvInterpreterSrcFunction)
  protected
    DllInstance: HINST;
    DllName: string;
    FunctionName: string;
    {or}
    FunctionIndex: Integer;
    function CallDll(Args: TJvInterpreterArgs): Variant;
  end;

  TJvInterpreterEventDesc = class(TJvInterpreterIdentifier)
  protected
    EventClass: TJvInterpreterEventClass;
    Code: Pointer;
  end;

  TJvInterpreterRecordDataType = class(TInterfacedObject, IJvInterpreterDataType)
  protected
    FRecordDesc: TJvInterpreterRecord;
  public
    constructor Create(ARecordDesc: TJvInterpreterRecord);
    procedure Init(var V: Variant);
    function GetTyp: Word;
  end;

  TJvInterpreterArrayDataType = class(TInterfacedObject, IJvInterpreterDataType)
  protected
    FArrayBegin, FArrayEnd: TJvInterpreterArrayValues;
    FDimension: Integer;
    FArrayType: Integer;
    FDT: IJvInterpreterDataType;
  public
    constructor Create(AArrayBegin, AArrayEnd: TJvInterpreterArrayValues;
      ADimension: Integer; AArrayType: Integer; ADT: IJvInterpreterDataType);
    procedure Init(var V: Variant);
    function GetTyp: Word;
  end;

  TJvInterpreterSimpleDataType = class(TInterfacedObject, IJvInterpreterDataType)
  protected
    FTyp: TVarType;
  public
    constructor Create(ATyp: TVarType);
    procedure Init(var V: Variant);
    function GetTyp: Word;
  end;

  PMethod = ^TMethod;

  { function context - stack }
  PFunctionContext = ^TFunctionContext;
  TFunctionContext = record
    PrevFunContext: PFunctionContext;
    LocalVars: TJvInterpreterVarList;
    Fun: TJvInterpreterSrcFunction;
  end;

  { TJvInterpreterAdapter - route JvInterpreter calls to Delphi functions }
  TJvInterpreterAdapter = class(TObject)
  private
    FOwner: TJvInterpreterExpression;
    FSrcUnitList: TJvInterpreterIdentifierList; // JvInterpreter-units sources
    FExtUnitList: TJvInterpreterIdentifierList; // internal units; like "system" in delphi
    FGetList: TJvInterpreterIdentifierList; // methods
    FSetList: TJvInterpreterIdentifierList; // write properties
    FIGetList: TJvInterpreterIdentifierList; // read indexed properties
    FISetList: TJvInterpreterIdentifierList; // write indexed properties
    FIDGetList: TJvInterpreterIdentifierList; // read default indexed properties
    FIDSetList: TJvInterpreterIdentifierList; // write default indexed properties
    FIntfGetList: TJvInterpreterIdentifierList; // interface methods
    FIntfSetList: TJvInterpreterIdentifierList; // interface write properties
    FIntfIGetList: TJvInterpreterIdentifierList; // interface read indexed properties
    FIntfISetList: TJvInterpreterIdentifierList; // interface write indexed properties
    FIntfIDGetList: TJvInterpreterIdentifierList; // interface read default indexed properties
    FIntfIDSetList: TJvInterpreterIdentifierList; // interface write default indexed properties
    FDirectGetList: TJvInterpreterIdentifierList; // direct get list
    FClassList: TJvInterpreterIdentifierList; // delphi classes
    FConstList: TJvInterpreterIdentifierList; // delphi consts
    FFunctionList: TJvInterpreterIdentifierList; // functions, procedures
    FRecordList: TJvInterpreterIdentifierList; // records
    FRecordGetList: TJvInterpreterIdentifierList; // read record field
    FRecordSetList: TJvInterpreterIdentifierList; // write record field
    FOnGetList: TJvInterpreterIdentifierList; // chain
    FOnSetList: TJvInterpreterIdentifierList; // chain
    FSrcFunctionList: TJvInterpreterIdentifierList; // functions, procedures in JvInterpreter-source
    FExtFunctionList: TJvInterpreterIdentifierList;
    FEventHandlerList: TJvInterpreterIdentifierList;
    FEventList: TJvInterpreterIdentifierList;
    FSrcVarList: TJvInterpreterVarList; // variables, constants in JvInterpreter-source
    FSrcClassList: TJvInterpreterIdentifierList; // JvInterpreter-source classes
    FDisableExternalFunctions: Boolean;
    FSorted: Boolean;
    procedure CheckArgs(var Args: TJvInterpreterArgs; ParamCount: Integer;
      var ParamTypes: TTypeArray);
    function GetRec(const RecordType: string): TObject;
    {$IFDEF JvInterpreter_OLEAUTO}
    function DispatchCall(const Identifier: string; var Value: Variant;
      Args: TJvInterpreterArgs; Get: Boolean): Boolean; stdcall;
    {$ENDIF JvInterpreter_OLEAUTO}
    function GetValueRTTI(const Identifier: string; var Value: Variant;
      Args: TJvInterpreterArgs): Boolean;
    function SetValueRTTI(const Identifier: string; const Value: Variant;
      Args: TJvInterpreterArgs): Boolean;
  protected
    procedure CheckAction(Expression: TJvInterpreterExpression; Args: TJvInterpreterArgs;
      Data: Pointer); virtual;
    function GetValue(Expression: TJvInterpreterExpression; const Identifier: string;
      var Value: Variant; Args: TJvInterpreterArgs): Boolean; virtual;
    function SetValue(Expression: TJvInterpreterExpression; const Identifier: string;
      const Value: Variant; Args: TJvInterpreterArgs): Boolean; virtual;
    function GetElement(Expression: TJvInterpreterExpression; const Variable: Variant;
      var Value: Variant; var Args: TJvInterpreterArgs): Boolean; virtual;
    function SetElement(Expression: TJvInterpreterExpression; var Variable: Variant;
      const Value: Variant; var Args: TJvInterpreterArgs): Boolean; virtual;
    function NewRecord(const RecordType: string; var Value: Variant): Boolean; virtual;
    function FindFunDesc(const UnitName, Identifier: string;
      const ClassIdentifier:string=''): TJvInterpreterFunctionDesc; virtual;
    procedure CurUnitChanged(const NewUnitName: string; var Source: string); virtual;
    function UnitExists(const Identifier: string): Boolean; virtual;
    function IsEvent(Obj: TObject; const Identifier: string): Boolean; virtual;
    function NewEvent(const UnitName, FunctionName, EventType: string;
      AOwner: TJvInterpreterExpression; AObject: TObject;
      const APropName: string): TSimpleEvent; virtual;
    procedure ClearSource; dynamic;
    procedure ClearNonSource; dynamic;
    procedure Sort; dynamic;
  protected
    { for internal use }
    procedure AddSrcClass(JvInterpreterSrcClass: TJvInterpreterIdentifier); virtual;
    function GetSrcClass(const Identifier: string): TJvInterpreterIdentifier; virtual;
  public
    constructor Create(AOwner: TJvInterpreterExpression);
    destructor Destroy; override;
    function SetRecord(var Value: Variant): Boolean; virtual;
    procedure Clear; dynamic;
    procedure Assign(Source: TJvInterpreterAdapter); dynamic;
    procedure AddSrcUnit(const Identifier, Source, UsesList: string); dynamic;
    procedure AddSrcUnitEx(const Identifier, Source, UsesList: string;
      Data: Pointer); dynamic;
    procedure AddExtUnit(const Identifier: string); dynamic;
    procedure AddExtUnitEx(const Identifier: string; Data: Pointer); dynamic;
    procedure AddClass(const UnitName: string; AClassType: TClass; const Identifier: string); dynamic;
    procedure AddClassEx(const UnitName: string; AClassType: TClass; const Identifier: string;
      Data: Pointer); dynamic;
    procedure AddIntfGet(IID: TGUID; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word);
    procedure AddIntfGetEx(IID: TGUID; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
    procedure AddIntfIGet(IID: TGUID; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word);
    procedure AddIntfIGetEx(IID: TGUID; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
    procedure AddIntfIDGet(IID: TGUID;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word);
    procedure AddIntfIDGetEx(IID: TGUID;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
    procedure AddGet(AClassType: TClass; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddGetEx(AClassType: TClass; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer); dynamic;
    procedure AddSet(AClassType: TClass; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddSetEx(AClassType: TClass; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer); dynamic;
    procedure AddIGet(AClassType: TClass; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddIGetEx(AClassType: TClass; const Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer); dynamic;
    procedure AddISet(AClassType: TClass; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddISetEx(AClassType: TClass; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer); dynamic;
    procedure AddIDGet(AClassType: TClass;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddIDGetEx(AClassType: TClass;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer); dynamic;
    procedure AddIDSet(AClassType: TClass;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddIDSetEx(AClassType: TClass;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer); dynamic;
    procedure AddIntfSet(IID: TGUID; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word);
    procedure AddIntfSetEx(IID: TGUID; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer);
    procedure AddIntfISet(IID: TGUID; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word);
    procedure AddIntfISetEx(IID: TGUID; const Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer);
    procedure AddIntfIDSet(IID: TGUID;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word);
    procedure AddIntfIDSetEx(IID: TGUID;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer);
    procedure AddFunction(const UnitName, Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddFunctionEx(const UnitName, Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer); dynamic;
    { function AddDGet under construction - don't use it }
    procedure AddDGet(AClassType: TClass; const Identifier: string;
      GetFunc: Pointer; ParamCount: Integer; ParamTypes: array of Word;
      ResTyp: Word; CallConvention: TCallConvention); dynamic;
    procedure AddDGetEx(AClassType: TClass; const Identifier: string;
      GetFunc: Pointer; ParamCount: Integer; ParamTypes: array of Word;
      ResTyp: Word; CallConvention: TCallConvention; Data: Pointer); dynamic;
    procedure AddRec(const UnitName, Identifier: string; RecordSize: Integer;
      Fields: array of TJvInterpreterRecField; CreateFunc: TJvInterpreterAdapterNewRecord;
      DestroyFunc: TJvInterpreterAdapterDisposeRecord;
      CopyFunc: TJvInterpreterAdapterCopyRecord); dynamic;
    procedure AddRecEx(const UnitName, Identifier: string; RecordSize: Integer;
      Fields: array of TJvInterpreterRecField; CreateFunc: TJvInterpreterAdapterNewRecord;
      DestroyFunc: TJvInterpreterAdapterDisposeRecord; CopyFunc: TJvInterpreterAdapterCopyRecord;
      Data: Pointer); dynamic;
    procedure AddRecGet(const UnitName, RecordType, Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddRecGetEx(const UnitName, RecordType, Identifier: string;
      GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word; Data: Pointer); dynamic;
    procedure AddRecSet(const UnitName, RecordType, Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddRecSetEx(const UnitName, RecordType, Identifier: string;
      SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word; Data: Pointer); dynamic;
    procedure AddConst(const UnitName, Identifier: string; Value: Variant); dynamic;
    procedure AddConstEx(const AUnitName, AIdentifier: string; AValue: Variant;
      AData: Pointer); dynamic;
    procedure AddExtFun(const UnitName, Identifier: string; DllInstance: HINST;
      const DllName, FunctionName: string; FunctionIndex: Integer; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddExtFunEx(const AUnitName, AIdentifier: string; ADllInstance: HINST;
      const ADllName, AFunctionName: string; AFunIndex: Integer; AParamCount: Integer;
      AParamTypes: array of Word; AResTyp: Word; AData: Pointer); dynamic;
    procedure AddSrcFun(const UnitName, Identifier: string;
      ClassIdentifier: string;
      PosBeg, PosEnd: Integer; ParamCount: Integer; ParamTypes: array of Word;
      ParamTypeNames: array of string;
      ParamNames: array of string; ResTyp: Word; const AResTypName: string;
      AResDataType: IJvInterpreterDataType; Data: Pointer); dynamic;
    procedure AddSrcFunEx(const AUnitName, AIdentifier: string;
      AClassIdentifier: string;
      APosBeg, APosEnd: Integer; AParamCount: Integer; AParamTypes: array of Word;
      AParamTypeNames: array of string;
      AParamNames: array of string; AResTyp: Word; const AResTypName: string;
      AResDataType: IJvInterpreterDataType; AData: Pointer); dynamic;
    procedure AddHandler(const UnitName, Identifier: string;
      EventClass: TJvInterpreterEventClass; Code: Pointer); dynamic;
    procedure AddHandlerEx(const AUnitName, AIdentifier: string;
      AEventClass: TJvInterpreterEventClass; ACode: Pointer; AData: Pointer); dynamic;
    procedure AddEvent(const UnitName: string; AClassType: TClass;
      const Identifier: string); dynamic;
    procedure AddEventEx(const AUnitName: string; AClassType: TClass;
      const AIdentifier: string; AData: Pointer); dynamic;
    procedure AddSrcVar(const UnitName, Identifier, Typ: string; VTyp: Word;
      const Value: Variant; DataType: IJvInterpreterDataType); dynamic;
    procedure AddOnGet(Method: TJvInterpreterGetValue); dynamic;
    procedure AddOnSet(Method: TJvInterpreterSetValue); dynamic;
  public
    property DisableExternalFunctions: Boolean read FDisableExternalFunctions write FDisableExternalFunctions;
    property SrcUnitList: TJvInterpreterIdentifierList read FSrcUnitList;
    property ExtUnitList: TJvInterpreterIdentifierList read FExtUnitList;
    property GetList: TJvInterpreterIdentifierList read FGetList;
    property SetList: TJvInterpreterIdentifierList read FSetList;
    property IGetList: TJvInterpreterIdentifierList read FIGetList;
    property ISetList: TJvInterpreterIdentifierList read FISetList;
    property IDGetList: TJvInterpreterIdentifierList read FIDGetList;
    property IDSetList: TJvInterpreterIdentifierList read FIDSetList;
    property IntfGetList: TJvInterpreterIdentifierList read FIntfGetList;
    property IntfSetList: TJvInterpreterIdentifierList read FIntfSetList;
    property IntfIGetList: TJvInterpreterIdentifierList read FIntfIGetList;
    property IntfISetList: TJvInterpreterIdentifierList read FIntfISetList;
    property IntfIDGetList: TJvInterpreterIdentifierList read FIntfIDGetList;
    property IntfIDSetList: TJvInterpreterIdentifierList read FIntfIDSetList;
    property DirectGetList: TJvInterpreterIdentifierList read FDirectGetList;
    property ClassList: TJvInterpreterIdentifierList read FClassList;
    property ConstList: TJvInterpreterIdentifierList read FConstList;
    property FunctionList: TJvInterpreterIdentifierList read FFunctionList;
    property RecordList: TJvInterpreterIdentifierList read FRecordList;
    property RecordGetList: TJvInterpreterIdentifierList read FRecordGetList;
    property RecordSetList: TJvInterpreterIdentifierList read FRecordSetList;
    property OnGetList: TJvInterpreterIdentifierList read FOnGetList;
    property OnSetList: TJvInterpreterIdentifierList read FOnSetList;
    property SrcFunctionList: TJvInterpreterIdentifierList read FSrcFunctionList;
    property ExtFunctionList: TJvInterpreterIdentifierList read FExtFunctionList;
    property EventHandlerList: TJvInterpreterIdentifierList read FEventHandlerList;
    property EventList: TJvInterpreterIdentifierList read FEventList;
    property SrcVarList: TJvInterpreterVarList read FSrcVarList;
    property SrcClassList: TJvInterpreterIdentifierList read FSrcClassList;
  end;

  TStackPtr = -1..cJvInterpreterStackMax;

  { Expression evaluator }
  TJvInterpreterExpression = class(TJvComponent)
  private
    FParser: TJvInterpreterParser;
    FVResult: Variant;
    FExpStack: array [0..cJvInterpreterStackMax] of Variant;
    FExpStackPtr: TStackPtr;
    FToken: Variant;
    FBacked: Boolean;
    FTTyp: TTokenKind;
    FTokenStr: string;
    FPrevTTyp: TTokenKind;
    FAllowAssignment: Boolean;
    FArgs: TJvInterpreterArgs; { data }
    FCurrArgs: TJvInterpreterArgs; { pointer to current }
    FPStream: TStream; { parsed source }
    FParsed: Boolean;
    FAdapter: TJvInterpreterAdapter;
    FSharedAdapter: TJvInterpreterAdapter;
    FCompiled: Boolean;
    FBaseErrLine: Integer;
    FOnGetValue: TJvInterpreterGetValue;
    FOnSetValue: TJvInterpreterSetValue;
    FLastError: EJvInterpreterError;
    FDisableExternalFunctions: Boolean;
    function GetSource: string;
    procedure SetSource(const Value: string);
    procedure SetCurPos(Value: Integer);
    function GetCurPos: Integer;
    function GetTokenStr: string;
    procedure ReadArgs;
    procedure InternalGetValue(Obj: Pointer; ObjTyp: Word; var Result: Variant);
    function CallFunction(const FunctionName: string;
      Args: TJvInterpreterArgs; Params: array of Variant): Variant; virtual; abstract;
    function CallFunctionEx(Instance: TObject; const UnitName: string;
      const FunctionName: string; Args: TJvInterpreterArgs; Params: array of Variant): Variant; virtual; abstract;
    procedure SetDisableExternalFunctions(const Value: Boolean);
  protected
    procedure UpdateExceptionPos(E: Exception; const UnitName: string);
    procedure Init; dynamic;
    procedure ErrorExpected(const Exp: string);
    procedure ErrorNotImplemented(const Msg: string);
    function PosBeg: Integer;
    function PosEnd: Integer;
    procedure Back;
    procedure SafeBack; {? please don't use ?}
    function CreateAdapter: TJvInterpreterAdapter; dynamic;
    procedure ParseToken;
    procedure ReadToken;
    procedure WriteToken;
    procedure Parse;
    function Expression1: Variant;
    function Expression2(const ExpType: Word): Variant;
    function SetExpression1: Variant;
    procedure NextToken;
    function GetValue(const Identifier: string; var Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; virtual;
    function SetValue(const Identifier: string; const Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; virtual;
    function GetElement(const Variable: Variant; var Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; virtual;
    function SetElement(var Variable: Variant; const Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; virtual;
    procedure SourceChanged; dynamic;
    procedure SetAdapter(Adapter: TJvInterpreterAdapter);
    property Token: Variant read FToken;
    property TTyp: TTokenKind read FTTyp;
    property PrevTTyp: TTokenKind read FPrevTTyp;
    property TokenStr: string read GetTokenStr;
    property CurPos: Integer read GetCurPos write SetCurPos;
    property Compiled: Boolean read FCompiled;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; dynamic;
    property Source: string read GetSource write SetSource;
    property VResult: Variant read FVResult;
    property OnGetValue: TJvInterpreterGetValue read FOnGetValue write FOnGetValue;
    property OnSetValue: TJvInterpreterSetValue read FOnSetValue write FOnSetValue;
    property Adapter: TJvInterpreterAdapter read FAdapter;
    property SharedAdapter: TJvInterpreterAdapter read FSharedAdapter;
    property BaseErrLine: Integer read FBaseErrLine write FBaseErrLine;
    property LastError: EJvInterpreterError read FLastError;
    property DisableExternalFunctions: Boolean read FDisableExternalFunctions write SetDisableExternalFunctions;
  end;

  TParserState = record
    CurPos: Integer;
    Token: Variant;
    TTyp: TTokenKind;
    PrevTTyp: TTokenKind;
    Backed: Boolean;
    AllowAssignment: Boolean;
  end;

  TJvInterpreterAddVarFunc = procedure(const UnitName,
    Identifier, Typ: string; VTyp: Word; const Value: Variant;
    ADataType: IJvInterpreterDataType) of object;

  { Function executor }
  TJvInterpreterFunction = class(TJvInterpreterExpression)
  private
    FCurUnitName: string;
    FCurInstance: TObject;
    FBreak: Boolean;
    FContinue: Boolean;
    FExit: Boolean;
    FFunctionStack: TList;
    FFunctionContext: Pointer; { PFunctionContext }
    FSS: TStringList;
    FStateStack: array [0..cJvInterpreterStackMax] of TParserState;
    FStateStackPtr: TStackPtr;
    FEventList: TList;
    function GetLocalVars: TJvInterpreterVarList;
    function GetFunStackCount: Integer;
    function GetDebugPointerToGlobalVars: TJvInterpreterVarList;
    function GetDebugPointerToFunStack: Pointer;
  protected
    procedure Init; override;
    procedure PushState;
    procedure PopState;
    procedure RemoveState;
    procedure DoOnStatement; virtual;
    procedure InFunction(FunctionDesc: TJvInterpreterFunctionDesc);
    procedure InterpretStatement;
    procedure SkipStatement;
    procedure SkipToEnd;
    procedure SkipToUntil;
    procedure SkipIdentifier;
    procedure FindToken(ATTyp: TTokenKind);
    procedure InterpretVar(AddVarFunc: TJvInterpreterAddVarFunc);
    procedure InterpretConst(AddVarFunc: TJvInterpreterAddVarFunc);
    procedure InterpretIdentifier;
    procedure InterpretBegin;
    procedure InterpretIf;
    procedure InterpretWhile;
    procedure InterpretRepeat;
    procedure InterpretFor;
    procedure InterpretCase;
    procedure InterpretTry;
    procedure InterpretRaise;
    function ParseDataType: IJvInterpreterDataType;
    function NewEvent(const UnitName, FunctionName, EventType: string;
      Instance: TObject; const APropName: string): TSimpleEvent;
    function FindEvent(const UnitName: string; Instance: TObject;
      const PropName: string): TJvInterpreterEvent;
    procedure InternalSetValue(const Identifier: string);
    function GetValue(const Identifier: string; var Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; override;
    function SetValue(const Identifier: string; const Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; override;
    property LocalVars: TJvInterpreterVarList read GetLocalVars;
    property EventList: TList read FEventList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; override;
    property CurUnitName: string read FCurUnitName;
    property CurInstance: TObject read FCurInstance;
    property FunStackCount: Integer read GetFunStackCount;
    property DebugPointerToFunStack: Pointer read GetDebugPointerToFunStack;
    property DebugPointerToGlobalVars: TJvInterpreterVarList read GetDebugPointerToGlobalVars;
  end;

  TUnitSection =
    (usUnknown, usInterface, usImplementation, usInitialization, usFinalization);

  { Unit executor }
  TJvInterpreterUnit = class(TJvInterpreterFunction)
  private
    FClearUnits: Boolean;
    FEventHandlerList: TList;
    FOnGetUnitSource: TJvInterpreterGetUnitSource;
    FUnitSection: TUnitSection;
  protected
    procedure Init; override;
    procedure ReadFunctionHeader(FunctionDesc: TJvInterpreterFunctionDesc);
    procedure InterpretUses(var UsesList: string);
    procedure ReadUnit(const UnitName: string);
    procedure InterpretFunction;
    procedure InterpretUnit;
    procedure InterpretType;
    procedure InterpretClass(const Identifier: string);
    function GetValue(const Identifier: string; var Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; override;
    function SetValue(const Identifier: string; const Value: Variant;
      var Args: TJvInterpreterArgs): Boolean; override;
    function GetUnitSource(const UnitName: string; var Source: string): Boolean; dynamic;
    procedure ExecFunction(Fun: TJvInterpreterFunctionDesc);
    procedure SourceChanged; override;
    procedure InterpretRecord(const Identifier: string);
    property EventHandlerList: TList read FEventHandlerList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure DeclareExternalFunction(const Declaration: string);
    procedure Compile;
    function CallFunction(const FunctionName: string; Args: TJvInterpreterArgs;
      Params: array of Variant): Variant; override;
    function CallFunctionEx(Instance: TObject; const UnitName: string;
      const FunctionName: string; Args: TJvInterpreterArgs;
      Params: array of Variant): Variant; override;
    function FunctionExists(const UnitName: string;
      const FunctionName: string): Boolean;
    property OnGetUnitSource: TJvInterpreterGetUnitSource read FOnGetUnitSource
      write FOnGetUnitSource;
    property UnitSection: TUnitSection read FUnitSection;
  end;

  { main JvInterpreter component }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TJvInterpreterProgram = class(TJvInterpreterUnit)
  private
    FPas: TStringList;
    FOnStatement: TNotifyEvent;
    function GetPas: TStrings;
    procedure SetPas(Value: TStrings);
  protected
    procedure DoOnStatement; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; override;
  published
    property Pas: TStrings read GetPas write SetPas;
    property OnGetValue;
    property OnSetValue;
    property OnGetUnitSource;
    property OnStatement: TNotifyEvent read FOnStatement write FOnStatement;
  end;

  TJvSimpleVariantType = class(TCustomVariantType)
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData;
      const AVarType: TVarType); override;
  end;

  TJvRecordVariantType = class(TJvSimpleVariantType);
  TJvObjectVariantType = class(TJvSimpleVariantType);
  TJvClassVariantType = class(TJvSimpleVariantType);
  TJvPointerVariantType = class(TJvSimpleVariantType);
  TJvSetVariantType = class(TJvSimpleVariantType);
  TJvArrayVariantType = class(TJvSimpleVariantType);

  EJvInterpreterError = class(Exception)
  private
    FExceptionPos: Boolean;
    FErrCode: Integer;
    FErrPos: Integer;
    FErrName1: string;
    FErrName2: string;
    FErrUnitName: string;
    FErrLine: Integer;
    FErrMessage: string;
  public
    constructor Create(const AErrCode: Integer; const AErrPos: Integer;
      const AErrName1, AErrName2: string);
    procedure Assign(E: Exception);
    procedure Clear;
    property ErrCode: Integer read FErrCode;
    property ErrPos: Integer read FErrPos;
    property ErrName1: string read FErrName1;
    property ErrName2: string read FErrName2;
    property ErrUnitName: string read FErrUnitName;
    property ErrLine: Integer read FErrLine;
    property ErrMessage: string read FErrMessage;
  end;

{Error raising routines}
procedure JvInterpreterError(const AErrCode: Integer; const AErrPos: Integer);
procedure JvInterpreterErrorN(const AErrCode: Integer; const AErrPos: Integer;
  const AErrName: string);
procedure JvInterpreterErrorN2(const AErrCode: Integer; const AErrPos: Integer;
  const AErrName1, AErrName2: string);

{Utilities functions}
//function LoadStr2(const ResID: Integer): string;

{ RFD - RecordFieldDefinition - return record needed for TJvInterpreterAdapter.AddRec
  Fields parameter }
function RFD(const Identifier: string; Offset: Integer; Typ: Word): TJvInterpreterRecField;

{ raise error ieNotImplemented }
procedure NotImplemented(const Msg: string);

{ clear list of TObject }
procedure ClearList(List: TList);

{ additional variant types - TVarData.VType }

function varRecord: TVarType;
function varObject: TVarType;
function varClass: TVarType;
function varPointer: TVarType;
function varSet: TVarType;
function varArray: TVarType;

type
  TJvInterpreterShiftStateCastType = {$IFDEF COMPILER14_UP}Word{$ELSE}Byte{$ENDIF};

{ V2O - converts variant to object }
function V2O(const V: Variant): TObject;

{ O2V - converts object to variant }
function O2V(O: TObject): Variant;

{ V2C - converts variant to class }
function V2C(const V: Variant): TClass;

{ O2V - converts class to variant }
function C2V(C: TClass): Variant;

{ V2P - converts variant to pointer }
function V2P(const V: Variant): Pointer;

{ P2V - converts pointer to variant }
function P2V(P: Pointer): Variant;

{ R2V - create record holder and put it into variant }
function R2V(const ARecordType: string; ARec: Pointer): Variant;

{ V2R - returns pointer to record from variant, containing record holder }
function V2R(const V: Variant): Pointer;

{ P2R - returns pointer to record from record holder, typically Args.Obj }
function P2R(const P: Pointer): Pointer;

{ S2V - converts Integer to set and put it into variant }
function S2V(const I: Integer): Variant;

{ V2S - give a set from variant and converts it to Integer }
function V2S(V: Variant): Integer;

procedure V2OA(V: Variant; var OA: TOpenArray; var OAValues: TValueArray;
  var Size: Integer);

function TypeName2VarTyp(const TypeName: string): Word;

{ copy variant variable with all JvInterpreter variant extension }
procedure JvInterpreterVarCopy(var Dest: Variant; const Source: Variant);

{ copy variant variable for assignment }
procedure JvInterpreterVarAssignment(var Dest: Variant; const Source: Variant);

function JvInterpreterVarAsType(const V: Variant; const VarType: Integer): Variant;

{ properly free var variable and set it content to empty }
procedure JvInterpreterVarFree(var V: Variant);

{ compare strings }
function Cmp(const S1, S2: string): Boolean;

{ For dynamic array support}
procedure JvInterpreterArraySetLength(AArray: Variant; ASize: Integer);
function JvInterpreterArrayLength(const AArray: Variant): Integer;
function JvInterpreterArrayLow(const AArray: Variant): Integer;
function JvInterpreterArrayHigh(const AArray: Variant): Integer;
procedure JvInterpreterArrayElementDelete(AArray: Variant; AElement: Integer);
procedure JvInterpreterArrayElementInsert(AArray: Variant; AElement: Integer; Value: Variant);

function GlobalJvInterpreterAdapter: TJvInterpreterAdapter;

const
  prArgsNoCheck = -1;
  noInstance = HINST(0);
  RFDNull: TJvInterpreterRecField = (Identifier: ''; Offset: 0; Typ: 0);

  varByConst = $8000;

  {JvInterpreter error codes}
  ieOk = 0; { Okay - no errors }
  ieUnknown = 1;
  ieInternal = 2;
  ieUserBreak = 3; { internal }
  ieRaise = 4; { internal }
  ieErrorPos = 5;
  ieExternal = 6; { non-interpreter error }
  ieAccessDenied = 7;
  ieExpressionStackOverflow = 8;

  { register-time errors }
  ieRegisterBase = 30;
  ieRecordNotDefined = ieRegisterBase + 1;

  { run-time errors }
  ieRuntimeBase = 50;
  ieStackOverFlow = ieRuntimeBase + 2;
  ieTypeMistmatch = ieRuntimeBase + 3;
  ieIntegerOverflow = ieRuntimeBase + 4;
  ieMainUndefined = ieRuntimeBase + 5;
  ieUnitNotFound = ieRuntimeBase + 6;
  ieEventNotRegistered = ieRuntimeBase + 7;
  ieDfmNotFound = ieRuntimeBase + 8;

  { syntax errors (now run-timed) }
  ieSyntaxBase = 100;
  ieBadRemark = ieSyntaxBase + 1; { Bad remark - detected by parser }
  ieIdentifierExpected = ieSyntaxBase + 2;
  ieExpected = ieSyntaxBase + 3;
  ieUnknownIdentifier = ieSyntaxBase + 4;
  ieBooleanRequired = ieSyntaxBase + 5;
  ieClassRequired = ieSyntaxBase + 6;
  ieNotAllowedBeforeElse = ieSyntaxBase + 7;
  ieIntegerRequired = ieSyntaxBase + 8;
  ieROCRequired = ieSyntaxBase + 9;
  ieMissingOperator = ieSyntaxBase + 10;
  ieIdentifierRedeclared = ieSyntaxBase + 11;

  { array indexes }
  ieArrayBase = 170;
  ieArrayIndexOutOfBounds = ieArrayBase + 1;
  ieArrayTooManyParams = ieArrayBase + 2;
  ieArrayNotEnoughParams = ieArrayBase + 3;
  ieArrayBadDimension = ieArrayBase + 4;
  ieArrayBadRange = ieArrayBase + 5;
  ieArrayRequired = ieArrayBase + 6;

  { function call errors (now run-timed) }
  ieFunctionBase = 180;
  ieTooManyParams = ieFunctionBase + 1;
  ieNotEnoughParams = ieFunctionBase + 2;
  ieIncompatibleTypes = ieFunctionBase + 3;
  ieDllErrorLoadLibrary = ieFunctionBase + 4;
  ieDllInvalidArgument = ieFunctionBase + 5;
  ieDllInvalidResult = ieFunctionBase + 6;
  ieDllFunctionNotFound = ieFunctionBase + 7;
  ieDirectInvalidArgument = ieFunctionBase + 8;
  ieDirectInvalidResult = ieFunctionBase + 9;
  ieDirectInvalidConvention = ieFunctionBase + 10;

  {$IFDEF JvInterpreter_OLEAUTO}
  ieOleAuto = ieFunctionBase + 21;
  {$ENDIF JvInterpreter_OLEAUTO}

  ieUserBase = $300;

  irExpression = 301;
  irIdentifier = 302;
  irDeclaration = 303;
  irEndOfFile = 304;
  irClass = 305;
  irIntegerConstant = 306;
  irIntegerValue = 307;
  irStringConstant = 308;
  irStatement = 309;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL$';
    Revision: '$Revision$';
    Date: '$Date$';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Types,
  TypInfo,
  {$IFDEF CPUX64}
  System.Rtti,
  {$ENDIF CPUX64}
  {$IFDEF JvInterpreter_OLEAUTO}
  OleConst, ActiveX, ComObj,
  {$ENDIF JvInterpreter_OLEAUTO}
  JvConsts, JvInterpreterConst, JvJVCLUtils, JvJCLUtils, JvResources, JvTypes,
  JvInterpreterFm; // required uses for class method support

var
  FieldGlobalJvInterpreterAdapter: TJvInterpreterAdapter = nil;

function GlobalJvInterpreterAdapter: TJvInterpreterAdapter;
begin
  if not Assigned(FieldGlobalJvInterpreterAdapter) then
    FieldGlobalJvInterpreterAdapter := TJvInterpreterAdapter.Create(nil);
  Result := FieldGlobalJvInterpreterAdapter;
end;

{ internal structures }



{$IFDEF JvInterpreter_DEBUG}
var
  ObjCount: Integer = 0;
{$ENDIF JvInterpreter_DEBUG}

var
  GlobalVariantRecordInstance: TJvRecordVariantType = nil;
  GlobalVariantObjectInstance: TJvObjectVariantType = nil;
  GlobalVariantClassInstance: TJvClassVariantType = nil;
  GlobalVariantPointerInstance: TJvPointerVariantType = nil;
  GlobalVariantSetInstance: TJvSetVariantType = nil;
  GlobalVariantArrayInstance: TJvArrayVariantType = nil;

function VariantRecordInstance: TJvRecordVariantType;
begin
  if not Assigned(GlobalVariantRecordInstance) then
    GlobalVariantRecordInstance := TJvRecordVariantType.Create;
  Result := GlobalVariantRecordInstance;
end;

function VariantObjectInstance: TJvObjectVariantType;
begin
  if not Assigned(GlobalVariantObjectInstance) then
    GlobalVariantObjectInstance := TJvObjectVariantType.Create;
  Result := GlobalVariantObjectInstance;
end;

function VariantClassInstance: TJvClassVariantType;
begin
  if not Assigned(GlobalVariantClassInstance) then
    GlobalVariantClassInstance := TJvClassVariantType.Create;
  Result := GlobalVariantClassInstance;
end;

function VariantPointerInstance: TJvPointerVariantType;
begin
  if not Assigned(GlobalVariantPointerInstance) then
    GlobalVariantPointerInstance := TJvPointerVariantType.Create;
  Result := GlobalVariantPointerInstance;
end;

function VariantSetInstance: TJvSetVariantType;
begin
  if not Assigned(GlobalVariantSetInstance) then
    GlobalVariantSetInstance := TJvSetVariantType.Create;
  Result := GlobalVariantSetInstance;
end;

function VariantArrayInstance: TJvArrayVariantType;
begin
  if not Assigned(GlobalVariantArrayInstance) then
    GlobalVariantArrayInstance := TJvArrayVariantType.Create;
  Result := GlobalVariantArrayInstance;
end;

//=== { TJvSimpleVariantType } ===============================================

procedure TJvSimpleVariantType.CastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
begin
  //support only inherited classes
  Dest.VPointer := Source.VPointer;
  //inherited;
end;

procedure TJvSimpleVariantType.Clear(var V: TVarData);
begin
  SimplisticClear(V);
end;

procedure TJvSimpleVariantType.Copy(var Dest: TVarData;
  const Source: TVarData; const Indirect: Boolean);
begin
  SimplisticCopy(Dest, Source, Indirect);
end;

function varRecord: TVarType;
begin
  Result := VariantRecordInstance.VarType;
end;

function varObject: TVarType;
begin
  Result := VariantObjectInstance.VarType;
end;

function varClass: TVarType;
begin
  Result := VariantClassInstance.VarType;
end;

function varPointer: TVarType;
begin
  Result := VariantPointerInstance.VarType;
end;

function varSet: TVarType;
begin
  Result := VariantSetInstance.VarType;
end;

function varArray: TVarType;
begin
  Result := VariantArrayInstance.VarType;
end;

//=== EJvInterpreterError ====================================================

function LoadStr2(const ResID: Integer): string;
var
  I: Integer;
begin
  for I := Low(JvInterpreterErrors) to High(JvInterpreterErrors) do
    if JvInterpreterErrors[I].ID = ResID then
    begin
      Result := JvInterpreterErrors[I].Description;
      Break;
    end;
end;

procedure JvInterpreterError(const AErrCode: Integer; const AErrPos: Integer);
begin
  raise EJvInterpreterError.Create(AErrCode, AErrPos, '', '');
end;

procedure JvInterpreterErrorN(const AErrCode: Integer; const AErrPos: Integer;
  const AErrName: string);
begin
  raise EJvInterpreterError.Create(AErrCode, AErrPos, AErrName, '');
end;

procedure JvInterpreterErrorN2(const AErrCode: Integer; const AErrPos: Integer;
  const AErrName1, AErrName2: string);
begin
  raise EJvInterpreterError.Create(AErrCode, AErrPos, AErrName1, AErrName2);
end;

constructor EJvInterpreterError.Create(const AErrCode: Integer;
  const AErrPos: Integer; const AErrName1, AErrName2: string);
begin
  inherited Create('');
  FErrCode := AErrCode;
  FErrPos := AErrPos;
  FErrName1 := AErrName1;
  FErrName2 := AErrName2;
  { function LoadStr don't work sometimes :-( }
  Message := Format(LoadStr2(ErrCode), [ErrName1, ErrName2]);
  FErrMessage := Message;
end;

procedure EJvInterpreterError.Assign(E: Exception);
begin
  Message := E.Message;
  if E is EJvInterpreterError then
  begin
    FErrCode := (E as EJvInterpreterError).ErrCode;
    FErrPos := (E as EJvInterpreterError).ErrPos;
    FErrName1 := (E as EJvInterpreterError).ErrName1;
    FErrName2 := (E as EJvInterpreterError).ErrName2;
    FErrMessage := (E as EJvInterpreterError).ErrMessage;
  end;
end;

procedure EJvInterpreterError.Clear;
begin
  FExceptionPos := False;
  FErrName1 := '';
  FErrName2 := '';
  FErrPos := -1;
  FErrLine := -1;
  FErrUnitName := '';
end;

function V2O(const V: Variant): TObject;
begin
  Result := TVarData(V).VPointer;
end;

function O2V(O: TObject): Variant;
begin
  TVarData(Result).VType := varObject;
  TVarData(Result).VPointer := O;
end;

function V2C(const V: Variant): TClass;
begin
  Result := TVarData(V).VPointer;
end;

function C2V(C: TClass): Variant;
begin
  TVarData(Result).VType := varClass;
  TVarData(Result).VPointer := C;
end;

function V2P(const V: Variant): Pointer;
begin
  Result := TVarData(V).VPointer;
end;

function P2V(P: Pointer): Variant;
begin
  TVarData(Result).VType := varPointer;
  TVarData(Result).VPointer := P;
end;

function R2V(const ARecordType: string; ARec: Pointer): Variant;
begin
  TVarData(Result).VPointer := TJvInterpreterRecHolder.Create(ARecordType, ARec);
  TVarData(Result).VType := varRecord;
end;

function V2R(const V: Variant): Pointer;
begin
  if (TVarData(V).VType <> varRecord) or
    not (TObject(TVarData(V).VPointer) is TJvInterpreterRecHolder) then
    JvInterpreterError(ieROCRequired, -1);
  Result := TJvInterpreterRecHolder(TVarData(V).VPointer).Rec;
end;

function P2R(const P: Pointer): Pointer;
begin
  if not (TObject(P) is TJvInterpreterRecHolder) then
    JvInterpreterError(ieROCRequired, -1);
  Result := TJvInterpreterRecHolder(P).Rec;
end;

function S2V(const I: Integer): Variant;
begin
  Result := I;
  TVarData(Result).VType := varSet;
end;

function V2S(V: Variant): Integer;
var
  I: Integer;
begin
  if (TVarData(V).VType and System.varArray) = 0 then
    Result := TVarData(V).VInteger
  else
  begin
    { JvInterpreter thinks about all function parameters, started
      with '[' symbol that they are open arrays;
      but it may be set constant, so we must convert it now }
    Result := 0;
    for I := VarArrayLowBound(V, 1) to VarArrayHighBound(V, 1) do
      Result := Result or 1 shl Integer(V[I]);
  end;
end;

function RFD(const Identifier: string; Offset: Integer; Typ: Word): TJvInterpreterRecField;
begin
  Result.Identifier := Identifier;
  Result.Offset := Offset;
  Result.Typ := Typ;
end;

procedure NotImplemented(const Msg: string);
begin
  JvInterpreterErrorN(ieInternal, -1, Msg + RsENotImplemented);
end;

//RWare: added check for "char", otherwise function with ref variable
//of type char causes AV, like KeyPress event handler

function Typ2Size(ATyp: Word): Integer;
begin
  Result := 0;
  case ATyp of
    varInteger:
      Result := SizeOf(Integer);
    varDouble:
      Result := SizeOf(Double);
    varByte:
      Result := SizeOf(Byte);
    varSmallint:
      Result := SizeOf(Smallint);
    varDate:
      Result := SizeOf(Double);
    varEmpty, varVariant, varOleStr, varDispatch, varUnknown:
      Result := SizeOf(TVarData);
  else
    if ATyp = varObject then
      Result := SizeOf(TObject);
  end;
end;

function TypeName2VarTyp(const TypeName: string): Word;
begin
  // (rom) reimplemented for speed
  // (rom) LongBool added (untested)
  Result := varEmpty;
  if TypeName <> '' then
  begin
    case TypeName[1] of
      'A', 'a':
        if Cmp(TypeName, 'AnsiString') then
          Result := varString;
      'B', 'b':
        if Cmp(TypeName, 'boolean') or Cmp(TypeName, 'bool') then
          Result := varBoolean
        else
        if Cmp(TypeName, 'byte') then
          Result := varByte;
      'C', 'c':
        if Cmp(TypeName, 'char') then {+RWare}
          Result := varString;
      'D', 'd':
        if Cmp(TypeName, 'dword') then
          Result := varInteger
        else
        if Cmp(TypeName, 'double') then
          Result := varDouble;
      'I', 'i':
        if Cmp(TypeName, 'integer') then
          Result := varInteger;
      'L', 'l':
        if Cmp(TypeName, 'longint') then
          Result := varInteger
        else
        if Cmp(TypeName, 'longbool') then
          Result := varBoolean;
      'P', 'p':
        if Cmp(TypeName, 'PChar') then
          Result := varString;
      'S', 's':
        if Cmp(TypeName, 'string') or Cmp(TypeName, 'ShortString') then
          Result := varString
        else
        if Cmp(TypeName, 'smallint') then
          Result := varSmallint;
      'T', 't':
        if Cmp(TypeName, 'TObject') then
          Result := varObject
        else
        if Cmp(TypeName, 'tdatetime') then
          Result := varDate;
      'W', 'w':
        if Cmp(TypeName, 'word') then
          Result := varSmallint
        else
        if Cmp(TypeName, 'wordbool') then
          Result := varBoolean;
    end;
  end;
end;

procedure ClearList(List: TList);
var
  I: Integer;
begin
  if Assigned(List) then
  begin
    for I := 0 to List.Count - 1 do
      TObject(List[I]).Free;
    List.Clear;
  end;
end;

procedure ClearMethodList(List: TList);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do
    Dispose(PMethod(List[I]));
  List.Clear;
end;

// (rom) JvUtil added to uses and functions deleted

function Cmp(const S1, S2: string): Boolean;
begin
  // Direct call to CompareString is faster than AnsiCompareText.
  Result := (Length(S1) = Length(S2)) and
    (CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PChar(S1),
    -1, PChar(S2), -1) = 2);
end;

{************* Some code from RAStream unit **************}

procedure StringSaveToStream(Stream: TStream; const S: string);
var
  L: Integer;
  UTF8Str: UTF8String;
begin
  UTF8Str := UTF8Encode(S);
  L := Length(UTF8Str);
  Stream.WriteBuffer(L, SizeOf(L));
  if L > 0 then
    Stream.WriteBuffer(UTF8Str[1], L);
end;

function StringLoadFromStream(Stream: TStream): string;
var
  L: Integer;
  UTF8Str: UTF8String;
begin
  Stream.ReadBuffer(L, SizeOf(L));
  SetLength(UTF8Str, L);
  if L > 0 then
    Stream.ReadBuffer(UTF8Str[1], L);
  Result := UTF8ToString(UTF8Str);
end;

procedure IntSaveToStream(Stream: TStream; AInt: Integer);
begin
  Stream.WriteBuffer(AInt, SizeOf(AInt));
end;

function IntLoadFromStream(Stream: TStream): Integer;
begin
  Stream.ReadBuffer(Result, SizeOf(Result));
end;

procedure WordSaveToStream(Stream: TStream; AWord: Word);
begin
  Stream.WriteBuffer(AWord, SizeOf(AWord));
end;

function WordLoadFromStream(Stream: TStream): Word;
begin
  Stream.ReadBuffer(Result, SizeOf(Result));
end;

procedure ExtendedSaveToStream(Stream: TStream; AExt: Extended);
begin
  Stream.WriteBuffer(AExt, SizeOf(AExt));
end;

function ExtendedLoadFromStream(Stream: TStream): Extended;
begin
  Stream.ReadBuffer(Result, SizeOf(Result));
end;

procedure BoolSaveToStream(Stream: TStream; ABool: Boolean);
var
  B: Integer;
begin
  B := Ord(ABool);
  Stream.WriteBuffer(B, SizeOf(B));
end;

function BoolLoadFromStream(Stream: TStream): Boolean;
var
  B: Integer;
begin
  Stream.ReadBuffer(B, SizeOf(B));
  Result := (B <> 0);
end;

{################## from RAStream unit ##################}

{$IFDEF JvInterpreter_OLEAUTO}

{************* Some code from Delphi's OleAuto unit **************}

const
  { Maximum number of dispatch arguments }
  MaxDispArgs = 64;

  { Special variant type codes }
  varStrArg = $0048;

  { Parameter type masks }
  atVarMask = $3F;
  atTypeMask = $7F;
  atByRef = $80;

{ Call GetIDsOfNames method on the given IDispatch interface }

procedure GetIDsOfNames(Dispatch: IDispatch; Names: PChar;
  NameCount: Integer; DispIDs: PDispIDList);
var
  I, N: Integer;
  Ch: WideChar;
  P: PWideChar;
  NameRefs: array [0..MaxDispArgs - 1] of PWideChar;
  WideNames: array [0..1023] of WideChar;
  R: Integer;
begin
  I := 0;
  N := 0;
  repeat
    P := @WideNames[I];
    if N = 0 then
      NameRefs[0] := P
    else
      NameRefs[NameCount - N] := P;
    repeat
      MultiByteToWideChar(0,0,@Names[I], 1, @ch, 1);
      WideNames[I] := Ch;
      Inc(I);
    until Char(Ch) = #0;
    Inc(N);
  until N = NameCount;
  { if Dispatch.GetIDsOfNames(GUID_NULL, @NameRefs, NameCount,
    LOCALE_SYSTEM_DEFAULT, DispIDs) <> 0 then }
  R := Dispatch.GetIDsOfNames(GUID_NULL, @NameRefs, NameCount,
    LOCALE_SYSTEM_DEFAULT, DispIDs);
  if R <> 0 then
    raise EOleError.CreateResFmt(@SNoMethod, [Names]);
end;

{ Central call dispatcher }

procedure VarDispInvoke(Result: PVariant; const Dispatch: Pointer;
  Names: PChar; CallDesc: PCallDesc; ParamTypes: Pointer); cdecl;
var
  DispIDs: array [0..MaxDispArgs - 1] of Integer;
begin
  GetIDsOfNames(IDispatch(Dispatch), Names, CallDesc^.NamedArgCount + 1, PDispIDList(@DispIDs[0]));
  if Result <> nil then
    VarClear(Result^);
  DispatchInvoke(IDispatch(Dispatch), CallDesc, PDispIDList(@DispIDs[0]), ParamTypes, Result);
end;

{################## from OleAuto unit ##################}
{$ENDIF JvInterpreter_OLEAUTO}

type
  TFunc = procedure;
  {$IFNDEF CPU64}
  TiFunc = function: Integer;
  TfFunc = function: Boolean;
  TwFunc = function: Word;
  {$ENDIF ~CPU64}

function CallDllIns(Ins: HINST; const FuncName: string; Args: TJvInterpreterArgs;
  ParamDesc: TTypeArray; ResTyp: Word): Variant;
var
  Func: TFunc;
  {$IFNDEF CPU64}
  iFunc: TiFunc;
  fFunc: TfFunc;
  wFunc: TwFunc;
  {$ELSE}
  Params: TArray<System.Rtti.TValue>;
  {$ENDIF ~CPU64}
  I: Integer;
  AInt: Integer;
 // Abyte : Byte;
  AWord: Word;
  APointer: Pointer;
  Str: string;
begin
  Result := Null;
  Func := GetProcAddress(Ins, PChar(FuncName));
  {$IFNDEF CPU64}
  iFunc := @Func;
  fFunc := @Func;
  wFunc := @Func;
  {$ENDIF ~CPU64}
  if Assigned(Func) then
  begin
    try
      {$IFNDEF CPU64}
      for I := Args.Count - 1 downto 0 do { 'stdcall' call conversion }
      {$ELSE}
      SetLength(Params, Args.Count);
      for I := 0 to Args.Count - 1 do
      {$ENDIF ~CPU64}
      begin
        if (ParamDesc[I] and varByRef) = 0 then
          case ParamDesc[I] of
            varInteger, { ttByte,} varBoolean:
              begin
                AInt := Args.Values[I];
                {$IFNDEF CPU64}
                asm
                  push AInt
                end;
                {$ELSE}
                Params[I] := TValue.From(AInt);
                {$ENDIF ~CPU64}
              end;
            varSmallint:
              begin
                AWord := Word(Args.Values[I]);
                {$IFNDEF CPU64}
                asm
                  push AWord
                end;
                {$ELSE}
                Params[I] := TValue.From(AWord);
                {$ENDIF ~CPU64}
              end;
            varString:
              begin
                APointer := PChar(string(Args.Values[I]));
                {$IFNDEF CPU64}
                asm
                  push APointer
                end;
                {$ELSE}
                Params[I] := TValue.From(APointer);
                {$ENDIF ~CPU64}
              end;
          else
            JvInterpreterErrorN(ieDllInvalidArgument, -1, FuncName);
          end
        else
          case ParamDesc[I] and not varByRef of
            varInteger, { ttByte,} varBoolean:
              begin
                APointer := @TVarData(Args.Values[I]).VInteger;
                {$IFNDEF CPU64}
                asm
                  push APointer
                end;
                {$ELSE}
                Params[I] := TValue.From(APointer);
                {$ENDIF ~CPU64}
              end;
            varSmallint:
              begin
                APointer := @TVarData(Args.Values[I]).vSmallInt;
                {$IFNDEF CPU64}
                asm
                  push APointer
                end;
                {$ELSE}
                Params[I] := TValue.From(APointer);
                {$ENDIF ~CPU64}
              end;
          else
            JvInterpreterErrorN(ieDllInvalidArgument, -1, FuncName);
          end
      end;

      case ResTyp of
        varSmallint:
          {$IFNDEF CPU64}
          Result := wFunc();
          {$ELSE}
          Result := System.Rtti.Invoke(@Func, Params, System.TypInfo.TCallConv.ccStdCall, TypeInfo(SmallInt), True).AsType<SmallInt>();
          {$ENDIF ~CPU64}
        varInteger:
          {$IFNDEF CPU64}
          Result := iFunc();
          {$ELSE}
          Result := System.Rtti.Invoke(@Func, Params, System.TypInfo.TCallConv.ccStdCall, TypeInfo(Integer), True).AsType<Integer>();
          {$ENDIF ~CPU64}
        varBoolean:
          {$IFNDEF CPU64}
          Result := Boolean(Ord(fFunc()));
          {$ELSE}
          Result := Boolean(Ord(System.Rtti.Invoke(@Func, Params, System.TypInfo.TCallConv.ccStdCall, TypeInfo(Boolean), True).AsType<Boolean>()));
          {$ENDIF ~CPU64}
        varEmpty:
          {$IFNDEF CPU64}
          Func();
          {$ELSE}
          System.Rtti.Invoke(@Func, Params, System.TypInfo.TCallConv.ccStdCall, nil, True);
          {$ENDIF ~CPU64}
      else
        JvInterpreterErrorN(ieDllInvalidResult, -1, FuncName);
      end;
    except
      on E: EJvInterpreterError do
        raise E;
      on E: Exception do
      begin
        Str := E.Message;
        UniqueString(Str);
        raise EJVCLException.Create(Str);
      end;
    end;
  end
  else
    JvInterpreterError(ieDllFunctionNotFound, -1);
end;

function CallDll(const DllName, FuncName: string; Args: TJvInterpreterArgs;
  ParamDesc: TTypeArray; ResTyp: Word): Variant;
var
  Ins: HMODULE;
  LastError: DWORD;
begin
  Result := False;
  Ins := SafeLoadLibrary(DllName);
  if Ins = 0 then
    JvInterpreterErrorN(ieDllErrorLoadLibrary, -1, DllName);
  try
    Result := CallDllIns(Ins, FuncName, Args, ParamDesc, ResTyp);
    LastError := GetLastError;
  finally
    FreeLibrary(Ins);
  end;
  SetLastError(LastError);
end;

procedure ConvertParamTypes(InParams: array of Word; var OutParams: TTypeArray);
var
  I: Integer;
begin
  for I := Low(InParams) to High(InParams) do
    OutParams[I] := InParams[I];
end;

procedure ConvertParamNames(InParams: array of string;
  var OutParams: TNameArray);
var
  I: Integer;
begin
  for I := Low(InParams) to High(InParams) do
    OutParams[I] := InParams[I];
end;

{ ************************* Array support ************************* }

function GetArraySize(Dimension: Integer; BeginPos, EndPos: TJvInterpreterArrayValues): Integer;
var
  A: Integer;
begin
  Result := 1;
  for A := 0 to Dimension - 1 do
  begin
    Result := Result * ((EndPos[A] - BeginPos[A]) + 1);
  end;
end;

{ Calculate starting position of element in memory }

function GetArrayOffset(Dimension: Integer; BeginPos, EndPos: TJvInterpreterArrayValues;
  Element: TJvInterpreterArrayValues): Integer;
var
  A: Integer;
  LastDim: Integer;
begin
  Result := 0;
  LastDim := 1;
  for A := 0 to Dimension - 1 do
  begin
    if (Element[A] < BeginPos[A]) or (Element[A] > EndPos[A]) then
      JvInterpreterError(ieArrayIndexOutOfBounds, -1);
    Result := Result + (LastDim * (Element[A] - BeginPos[A]));
    LastDim := LastDim * (EndPos[A] - BeginPos[A] + 1);
  end;
end;

{Allocate memory for new array}

function JvInterpreterArrayInit(const Dimension: Integer;
  const BeginPos, EndPos: TJvInterpreterArrayValues;
  const ItemType: Integer; DataType: IJvInterpreterDataType): PJvInterpreterArrayRec;
var
  PP: PJvInterpreterArrayRec;
  SS: TStringList;
  AA: Integer;
  ArraySize: Integer;
  I: Integer;
begin
  if (Dimension < 1) or (Dimension > cJvInterpreterMaxArgs) then
    JvInterpreterError(ieArrayBadDimension, -1);
  for AA := 0 to Dimension - 1 do
  begin
    // For dynamic arrays BeginPos[AA] <= EndPos[AA]
    if (not (BeginPos[AA] <= EndPos[AA])) and
      (Dimension <> 1) and (BeginPos[AA] <> 0) and (EndPos[AA] <> -1) then
      JvInterpreterError(ieArrayBadRange, -1);
  end;

  New(PP);
  PP^.BeginPos := BeginPos;
  PP^.EndPos := EndPos;
  PP^.ItemType := ItemType;
  PP^.DT := DataType;
  ArraySize := GetArraySize(Dimension, BeginPos, EndPos);
  PP^.Size := ArraySize;
  PP^.Dimension := Dimension;

  if ItemType <> varString then
    PP^.ElementSize := Typ2Size(ItemType)
  else
  begin
    PP^.ElementSize := 0;
    SS := TStringList.Create;
    for AA := 1 to ArraySize do
      SS.Add('');
    PP^.Memory := SS;
  end;

  if ItemType <> varString then
  begin
    GetMem(PP^.Memory, ArraySize * PP^.ElementSize);
    //ZeroMemory(PP^.Memory, ArraySize * PP^.ElementSize);
    FillChar(PP^.Memory^, ArraySize * PP^.ElementSize, 0);
    if ItemType = varEmpty then
      for I := 0 to ArraySize - 1 do
        PP^.DT.Init(Variant(PVarData(PAnsiChar(PP^.Memory) + I * PP^.ElementSize)^));
  end;
  Result := PP;
end;

{ Free memory for array }

procedure JvInterpreterArrayFree(JvInterpreterArrayRec: PJvInterpreterArrayRec);
var
  I: Integer;
  ArraySize: Integer;
begin
  if not Assigned(JvInterpreterArrayRec) then
    Exit;
  ArraySize := GetArraySize(JvInterpreterArrayRec^.Dimension,
    JvInterpreterArrayRec^.BeginPos, JvInterpreterArrayRec^.EndPos);
  if JvInterpreterArrayRec^.ItemType <> varString then
  begin
    if JvInterpreterArrayRec^.ItemType = varEmpty then
      for I := 0 to ArraySize - 1 do
        JvInterpreterVarFree(Variant(PVarData(PAnsiChar(JvInterpreterArrayRec^.Memory) + I *
          JvInterpreterArrayRec^.ElementSize)^));
    FreeMem(JvInterpreterArrayRec^.Memory, (JvInterpreterArrayRec^.Size) *
      JvInterpreterArrayRec^.ElementSize);
    Dispose(JvInterpreterArrayRec);
  end
  else
  begin
    TStringList(JvInterpreterArrayRec^.Memory).Clear;
    TStringList(JvInterpreterArrayRec^.Memory).Free;
    Dispose(JvInterpreterArrayRec);
  end;
end;

{ Set element for array }

procedure JvInterpreterArraySetElement(Element: TJvInterpreterArrayValues; Value: Variant;
  JvInterpreterArrayRec: PJvInterpreterArrayRec);
var
  Offset: Integer;
  P: Pointer;
begin
  if JvInterpreterArrayRec^.Dimension > 1 then
    Offset := GetArrayOffset(JvInterpreterArrayRec^.Dimension, JvInterpreterArrayRec^.BeginPos,
      JvInterpreterArrayRec^.EndPos, Element)
  else
    Offset := Element[0] - JvInterpreterArrayRec^.BeginPos[0];
  P := Pointer(PAnsiChar(JvInterpreterArrayRec^.Memory) + (Offset * JvInterpreterArrayRec^.ElementSize));
  case JvInterpreterArrayRec^.ItemType of
    varInteger:
      PInteger(P)^ := Value;
    varDouble:
      PDouble(P)^ := Value;
    varByte:
      PByte(P)^ := Value;
    varSmallint:
      PSmallInt(P)^ := Value;
    varDate:
      PDouble(P)^ := Value;
    varString:
      begin
        Value := VarAsType(Value, varString);
        TStringList(JvInterpreterArrayRec^.Memory).Strings[Offset] := Value;
      end;
    varEmpty:
      JvInterpreterVarAssignment(Variant(PVarData(P)^), Value);
  else
    if JvInterpreterArrayRec^.ItemType = varObject then
      TObject(P^) := V2O(Value);
  end;
end;

{ Get element for array }

function JvInterpreterArrayGetElement(Element: TJvInterpreterArrayValues;
  JvInterpreterArrayRec: PJvInterpreterArrayRec): Variant;
var
  Offset: Integer;
  P: Pointer;
begin
  if JvInterpreterArrayRec^.Dimension > 1 then
    Offset := GetArrayOffset(JvInterpreterArrayRec^.Dimension, JvInterpreterArrayRec^.BeginPos,
      JvInterpreterArrayRec^.EndPos, Element)
  else
    Offset := Element[0] - JvInterpreterArrayRec^.BeginPos[0];
  P := Pointer(PAnsiChar(JvInterpreterArrayRec^.Memory) + (Offset * JvInterpreterArrayRec^.ElementSize));
  case JvInterpreterArrayRec^.ItemType of
    varInteger:
      Result := Integer(P^);
    varDouble:
      Result := Double(P^);
    varByte:
      Result := Byte(P^);
    varSmallint:
      Result := Smallint(P^);
    varDate:
      Result := TDateTime(P^);
    varString:
      Result := TStringList(JvInterpreterArrayRec^.Memory).Strings[Offset];
    varEmpty:
      JvInterpreterVarCopy(Result, Variant(PVarData(P)^));
  else
    if JvInterpreterArrayRec^.ItemType = varObject then
      Result := O2V(TObject(P^));
  end;
end;

{ For dynamic array support }

procedure JvInterpreterArraySetLength(AArray: Variant; ASize: Integer);
var
  I: Integer;
  OldSize: Integer;
  ArrayRec: PJvInterpreterArrayRec;
begin
  ArrayRec := PJvInterpreterArrayRec(TVarData(AArray).VPointer);
  if ArrayRec^.Dimension > 1 then
    raise EJVCLException.CreateRes(@RsESorryDynamicArraysSupportIsMadeForO);
  OldSize := ArrayRec^.Size;
  if OldSize > ASize then
  begin
    for I := ASize to OldSize - 1 do
      if ArrayRec^.ItemType = varEmpty then
        JvInterpreterVarFree(Variant((PVarData(PAnsiChar(ArrayRec^.Memory) + I * ArrayRec^.ElementSize))^));
    ArrayRec^.EndPos[0] := ArrayRec^.EndPos[0] - (OldSize - ASize);
    ArrayRec^.Size := GetArraySize(1, ArrayRec^.BeginPos, ArrayRec^.EndPos);
    ReallocMem(ArrayRec^.Memory, ASize * ArrayRec^.ElementSize);
  end
  else
  if OldSize < ASize then
  begin
    ReallocMem(ArrayRec^.Memory, ASize * ArrayRec^.ElementSize);
    FillChar((PAnsiChar(ArrayRec^.Memory) + OldSize * ArrayRec^.ElementSize)^,
      (ASize - OldSize) * ArrayRec^.ElementSize, 0);
    for I := OldSize to ASize - 1 do
      if ArrayRec^.ItemType = varEmpty then
        ArrayRec^.DT.Init(Variant(Pointer(PAnsiChar(ArrayRec^.Memory) + I * ArrayRec^.ElementSize)^));
    ArrayRec^.EndPos[0] := ArrayRec^.EndPos[0] + (ASize - OldSize);
    ArrayRec^.Size := GetArraySize(ArrayRec^.Dimension, ArrayRec^.BeginPos, ArrayRec^.EndPos);
  end;
end;

function JvInterpreterArrayLength(const AArray: Variant): Integer;
var
  ArrayRec: PJvInterpreterArrayRec;
begin
  ArrayRec := PJvInterpreterArrayRec(TVarData(AArray).VPointer);
  if ArrayRec^.Dimension > 1 then
    raise EJVCLException.CreateRes(@RsESorryForOneDimensionalArraysOnly);
  Result := ArrayRec^.Size;
end;

function JvInterpreterArrayLow(const AArray: Variant): Integer;
var
  ArrayRec: PJvInterpreterArrayRec;
begin
  ArrayRec := PJvInterpreterArrayRec(TVarData(AArray).VPointer);
  if ArrayRec^.Dimension > 1 then
    raise EJVCLException.CreateRes(@RsESorryForOneDimensionalArraysOnly);
  Result := ArrayRec^.BeginPos[0];
end;

function JvInterpreterArrayHigh(const AArray: Variant): Integer;
var
  ArrayRec: PJvInterpreterArrayRec;
begin
  ArrayRec := PJvInterpreterArrayRec(TVarData(AArray).VPointer);
  if ArrayRec^.Dimension > 1 then
    raise EJVCLException.CreateRes(@RsESorryForOneDimensionalArraysOnly);
  Result := ArrayRec^.EndPos[0];
end;

procedure JvInterpreterArrayElementDelete(AArray: Variant; AElement: Integer);
var
  ArrayRec: PJvInterpreterArrayRec;
begin
  ArrayRec := PJvInterpreterArrayRec(TVarData(AArray).VPointer);
  if ArrayRec^.Dimension > 1 then
    raise EJVCLException.CreateRes(@RsESorryForOneDimensionalArraysOnly);
  if (AElement < ArrayRec^.BeginPos[0]) or (AElement > ArrayRec^.EndPos[0]) then
    JvInterpreterError(ieArrayIndexOutOfBounds, -1);
  ArrayRec^.EndPos[0] := ArrayRec^.EndPos[0] - 1;
  ArrayRec^.Size := GetArraySize(ArrayRec^.Dimension, ArrayRec^.BeginPos, ArrayRec^.EndPos);
  if ArrayRec^.ItemType = varEmpty then
    JvInterpreterVarFree(Variant(PVarData(PAnsiChar(ArrayRec^.Memory) +
      (AElement - ArrayRec^.BeginPos[0]) * ArrayRec^.ElementSize)^));
  Move((PAnsiChar(ArrayRec^.Memory) + (AElement - ArrayRec^.BeginPos[0] + 1) * ArrayRec^.ElementSize)^,
    (PAnsiChar(ArrayRec^.Memory) + (AElement - ArrayRec^.BeginPos[0]) * ArrayRec^.ElementSize)^,
    (ArrayRec^.EndPos[0] - AElement + 1) * ArrayRec^.ElementSize);
  ReallocMem(ArrayRec^.Memory, ArrayRec^.Size * ArrayRec^.ElementSize);

end;

procedure JvInterpreterArrayElementInsert(AArray: Variant; AElement: Integer; Value: Variant);
var
  ArrayRec: PJvInterpreterArrayRec;
begin
  ArrayRec := PJvInterpreterArrayRec(TVarData(AArray).VPointer);
  if ArrayRec^.Dimension > 1 then
    raise EJVCLException.CreateRes(@RsESorryForOneDimensionalArraysOnly);
  if (AElement < ArrayRec^.BeginPos[0]) or (AElement > ArrayRec^.EndPos[0]) then
    JvInterpreterError(ieArrayIndexOutOfBounds, -1);
  ArrayRec^.EndPos[0] := ArrayRec^.EndPos[0] + 1;
  ArrayRec^.Size := GetArraySize(ArrayRec^.Dimension, ArrayRec^.BeginPos, ArrayRec^.EndPos);
  ReallocMem(ArrayRec^.Memory, ArrayRec^.Size * ArrayRec^.ElementSize);
  Move((PAnsiChar(ArrayRec^.Memory) + (AElement - ArrayRec^.BeginPos[0]) * ArrayRec^.ElementSize)^,
    (PAnsiChar(ArrayRec^.Memory) + (AElement - ArrayRec^.BeginPos[0] + 1) * ArrayRec^.ElementSize)^,
    (ArrayRec^.EndPos[0] - AElement) * ArrayRec^.ElementSize);
  if ArrayRec^.ItemType = varEmpty then
    ArrayRec^.DT.Init(Variant(PVarData(PAnsiChar(ArrayRec^.Memory) +
      (AElement - ArrayRec^.BeginPos[0]) * ArrayRec^.ElementSize)^));
  JvInterpreterVarAssignment(Variant(PVarData(PAnsiChar(ArrayRec^.Memory) +
    (AElement - ArrayRec^.BeginPos[0]) * ArrayRec^.ElementSize)^), Value);
end;

procedure V2OA(V: Variant; var OA: TOpenArray; var OAValues: TValueArray;
  var Size: Integer);
var
  I: Integer;
  ArrayRec: PJvInterpreterArrayRec;
  Element: TJvInterpreterArrayValues;
  ElementVariant: Variant;
begin
  if TVarData(V).VType = varArray then
  //JvInterpreterError(ieTypeMistmatch, -1);
  begin
    ArrayRec := PJvInterpreterArrayRec(TVarData(V).VPointer);
    if ArrayRec^.Dimension > 1 then
      raise EJVCLException.CreateRes(@RsESorryForOneDimensionalArraysOnly);
    Size := ArrayRec^.Size;
    for I := 0 to Size - 1 do
    begin
      Element[0] := I;
      ElementVariant := JvInterpreterArrayGetElement(Element, ArrayRec);
      case TVarData(ElementVariant).VType of
        varInteger, varSmallint:
          begin
            OAValues[I] := ElementVariant;
            OA[I].VInteger := ElementVariant;
            OA[I].VType := vtInteger;
          end;
        varString, varOleStr:
          begin
            // OA[I].vPChar := PChar(string(V[I]));
            // OA[I].VType := vtPChar;
            OAValues[I] := ElementVariant;
            OA[I].VVariant := @OAValues[I];
            OA[I].VType := vtVariant;
          end;
        varBoolean:
          begin
            OAValues[I] := ElementVariant;
            OA[I].VBoolean := ElementVariant;
            OA[I].VType := vtBoolean;
          end;
        varDouble, varCurrency:
          begin
            OAValues[i] := V[i];
            VarCast(OAValues[I], OAValues[I], varCurrency);
            OA[i].vCurrency := @TVarData(OAValues[i]).vCurrency;
            OA[i].VType := vtCurrency;
          end;
      else
        OAValues[I] := ElementVariant;
        OA[I].VVariant := @OAValues[I];
        OA[I].VType := vtVariant;
      end;
    end;
  end
  else
  begin
    Size := VarArrayHighBound(V, 1) - VarArrayLowBound(V, 1) + 1;
    for I := VarArrayLowBound(V, 1) to VarArrayHighBound(V, 1) do
    begin
      case TVarData(V[I]).VType of
        varInteger, varSmallint:
          begin
            OAValues[I] := V[I];
            OA[I].VInteger := V[I];
            OA[I].VType := vtInteger;
          end;
        varString, varOleStr:
          begin
            OAValues[I] := V[I];
            OA[I].VVariant := @OAValues[I];
            OA[I].VType := vtVariant;
          end;
        varBoolean:
          begin
            OAValues[I] := V[I];
            OA[I].VBoolean := V[I];
            OA[I].VType := vtBoolean;
          end;
        varDouble, varCurrency:
          begin
            OAValues[i] := V[i];
            VarCast(OAValues[I], OAValues[I], varCurrency);
            OA[i].vCurrency := @TVarData(OAValues[i]).vCurrency;
            OA[i].VType := vtCurrency;
          end;
      else
        OAValues[I] := V[I];
        OA[I].VVariant := @OAValues[I];
        OA[I].VType := vtVariant;
      end;
    end;
  end;

end;

{ ########################## Array support ########################## }

{ ************************ extended variants ************************ }

function JvInterpreterVarAsType(const V: Variant; const VarType: Integer): Variant;
begin
  if (TVarData(V).VType = varEmpty) or (TVarData(V).VType = varNull) then
  begin
    case VarType of
      varString, varOleStr:
        Result := '';
      varInteger, varSmallint, varByte:
        Result := 0;
      varBoolean:
        Result := False;
      varSingle, varDouble, varCurrency, varDate:
        Result := 0.0;
      varVariant:
        Result := Null;
    else
      Result := VarAsType(V, VarType);
    end;
  end
  else
  begin
    if TVarData(V).VType = varArray then
    begin
      TVarData(Result) := TVarData(V);
      TVarData(Result).VType := VarType;
    end
    else
    if (VarType = varEmpty) and not VarIsEmpty(V) then
      Result := V  // because any cast to unassigned = unassigned
    else
      Result := VarAsType(V, VarType);
  end;
end;

procedure JvInterpreterVarAssignment(var Dest: Variant; const Source: Variant);
var
  I: Integer;
  DestRecHolder: TJvInterpreterRecHolder;
  SourceRecHolder: TJvInterpreterRecHolder;
begin
  if TVarData(Source).VType = varArray then
  begin
    NotImplemented(RsArrayToArrayAssignment);
    // TVarData(Dest) := TVarData(Source);
  end
  else
  if TVarData(Source).VType = varRecord then
  begin
    DestRecHolder := TJvInterpreterRecHolder(TVarData(Dest).VPointer);
    SourceRecHolder := TJvInterpreterRecHolder(TVarData(Source).VPointer);
    for I := 0 to SourceRecHolder.JvInterpreterRecord.FieldCount - 1 do
      if SourceRecHolder.JvInterpreterRecord.Fields[I].Typ = varEmpty then
        JvInterpreterVarAssignment(Variant(PVarData(PAnsiChar(DestRecHolder.Rec) +
          DestRecHolder.JvInterpreterRecord.Fields[I].Offset)^),
          Variant(PVarData(PAnsiChar(SourceRecHolder.Rec) +
          SourceRecHolder.JvInterpreterRecord.Fields[I].Offset)^))
      else
        Move((PAnsiChar(SourceRecHolder.Rec) +
          SourceRecHolder.JvInterpreterRecord.Fields[I].Offset)^,
          (PAnsiChar(DestRecHolder.Rec) +
          DestRecHolder.JvInterpreterRecord.Fields[I].Offset)^,
          Typ2Size(SourceRecHolder.JvInterpreterRecord.Fields[I].Typ));
  end
  else
    Dest := Source;
end;

procedure JvInterpreterVarCopy(var Dest: Variant; const Source: Variant);
begin
  if (TVarData(Source).VType = varArray) or (TVarData(Source).VType = varRecord) then
    TVarData(Dest) := TVarData(Source)
  else
    Dest := Source;
end;

procedure JvInterpreterVarFree(var V: Variant);
var
  TempType: TVarType;
begin
  TempType := TVarData(V).VType;
  if TempType = varArray then
    JvInterpreterArrayFree(PJvInterpreterArrayRec(TVarData(V).VPointer))
  else
  if TempType = varRecord then
    TJvInterpreterRecHolder(TVarData(V).VPointer).Free;
  varclear(V);
end;

{
function VarAsType2(const V: Variant; VarType: Integer): Variant;
begin
  if TVarData(V).VType = varNull then
    Result := VarAsType(Unassigned,VarType)
  else
    Result := VarAsType(V,VarType);
end;
}

function Var2Type(V: Variant; const VarType: Integer): Variant;
begin
  if (TVarData(V).VType = varEmpty) or (TVarData(V).VType = varNull) then
  begin
    case VarType of
      varString, varOleStr:
        Result := '';
      varInteger, varSmallint, varByte:
        Result := 0;
      varBoolean:
        Result := False;
      varSingle, varDouble, varCurrency, varDate:
        Result := 0.0;
      varVariant:
        Result := Null;
    else
      Result := VarAsType(V, VarType);
    end;
  end
  else
    Result := VarAsType(V, VarType);
  if (VarType = varInteger) and (TVarData(V).VType = varBoolean) then
    Result := Ord(V = True);
end;
{ ######################## extended variants ######################## }

//=== { TJvInterpreterVar } ==================================================

destructor TJvInterpreterVar.Destroy;
begin
  JvInterpreterVarFree(Value);
  inherited Destroy;
end;

//=== { TJvInterpreterVarList } ==============================================

destructor TJvInterpreterVarList.Destroy;
begin
  inherited Destroy;
end;

procedure TJvInterpreterVarList.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TJvInterpreterVar(Items[I]).Free;
  inherited Clear;
end;

procedure TJvInterpreterVarList.AddVar(const UnitName, Identifier, Typ: string; VTyp: Word;
  const Value: Variant; DataType: IJvInterpreterDataType);
var
  VarRec: TJvInterpreterVar;
begin
  if FindVar(UnitName, Identifier) <> nil then
    JvInterpreterErrorN(ieIdentifierRedeclared, -1, Identifier);
  VarRec := TJvInterpreterVar.Create;
  VarRec.Identifier := Identifier;
  VarRec.UnitName := UnitName;
  JvInterpreterVarCopy(VarRec.Value, Value);
  VarRec.Typ := Typ;
  VarRec.VTyp := VTyp;
  Insert(0, VarRec);
end;

function TJvInterpreterVarList.FindVar(const UnitName, Identifier: string): TJvInterpreterVar;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TJvInterpreterVar(Items[I]);
    { if UnitName = '', any unit allowed }
    if Cmp(Result.Identifier, Identifier) and
      (Cmp(Result.UnitName, UnitName) or (UnitName = '')) then
      Exit;
  end;
  Result := nil;
end;

procedure TJvInterpreterVarList.DeleteVar(const UnitName, Identifier: string);
var
  I: Integer;
  VarRec: TJvInterpreterVar;
begin
  for I := 0 to Count - 1 do
  begin
    VarRec := TJvInterpreterVar(Items[I]);
    if Cmp(VarRec.Identifier, Identifier) and
      (Cmp(VarRec.UnitName, UnitName) or (UnitName = '')) then
    begin
      JvInterpreterVarFree(VarRec.Value);
      VarRec.Free;
      Delete(I);
      Exit;
    end;
  end;
end;

function TJvInterpreterVarList.GetValue(const Identifier: string; var Value: Variant;
  Args: TJvInterpreterArgs): Boolean;
var
  V: TJvInterpreterVar;
begin
  if Args.Obj = nil then
    V := FindVar('', Identifier)
  else
  if (Args.ObjTyp = varObject) and (Args.Obj is TJvInterpreterSrcUnit) then
    V := FindVar((Args.Obj as TJvInterpreterSrcUnit).Identifier, Identifier)
  else
    V := nil;
  Result := V <> nil;
  if Result then
    JvInterpreterVarCopy(Value, V.Value);
end;

(*
function TJvInterpreterVarList.SetValue(Identifier: string; const Value: Variant;
  Args: TJvInterpreterArgs): Boolean;
var
  V: TJvInterpreterVar;
begin
  V := FindVar('', Identifier);
  Result := (V <> nil) and (Args.Obj = nil);
  if Result then
    JvInterpreterVarAssignment(V.Value, Value);
end; { SetValue }
*)

function TJvInterpreterVarList.SetValue(const Identifier: string; const Value: Variant;
  Args: TJvInterpreterArgs): Boolean;
var
  V: TJvInterpreterVar;
begin
  V := FindVar('', Identifier);
  Result := (V <> nil) and (Args.Obj = nil);
  if Result then
    { If 0, then it's probably an object }
    { If a Variant, then we don't care about typecasting }
    { We only want to typecast if the types are not the same, for speed }
    if (V.VTyp <> 0) and
      (V.VTyp <> varVariant) and
      (TVarData(Value).VType <> V.VTyp) then
    begin
      { Is it a passed-by-reference variable? }
      if V.VTyp and varByRef > 0 then
      begin
        JvInterpreterVarAssignment(V.Value, JvInterpreterVarAsType(Value, V.VTyp and not varByRef));
        V.VTyp := V.VTyp or varByRef;
      end
      else
        JvInterpreterVarAssignment(V.Value, JvInterpreterVarAsType(Value, V.VTyp))
    end
    else
      JvInterpreterVarAssignment(V.Value, Value);
end;

procedure TJvInterpreterVarList.Assign(source: TJvInterpreterVarList);
var
  I: Integer;
  SrcVar: TJvInterpreterVar;
begin
  Clear;
  for I := 0 to Source.Count-1 do
  begin
    SrcVar := TJvInterpreterVar(Source[I]);
    with SrcVar do
      AddVar(UnitName, Identifier, Typ, VTyp, Value, nil);  // DataType not used
      //TJvInterpreterSimpleDataType.Create(varVariant);
  end;
end;

//=== { TJvInterpreterFunctionDesc } =========================================

function TJvInterpreterFunctionDesc.GetParamType(Index: Integer): Word;
begin
  Result := FParamTypes[Index];
end;

function TJvInterpreterFunctionDesc.GetParamTypeNames(Index: Integer): string;
begin
  Result := FParamTypeNames[Index];
end;

function TJvInterpreterFunctionDesc.GetDefine: string;
var
  Fun, S, T: string;
  Param, Ret: string;
  I: Integer;
begin
  Result := '';
  if FIdentifier = '' then
    Exit;

  T := '%s %s(%s)%s;';

  if FResTyp = varEmpty then
  begin
    Fun := 'procedure';
    Ret := '';
  end
  else
  begin
    Fun := 'function';
    Ret := ': ' + ResTypName;
  end;

  for I := 0 to ParamCount - 1 do
  begin
    if (ParamTypes[I] and varByRef) = varByRef then
      S := 'Var ' + ParamNames[I]
    else
    if (ParamTypes[I] and varByConst) = varByConst then
      S := 'Const ' + ParamNames[I]
    else
      S := ParamNames[I];

    Param := Param + S + ': ' + ParamTypeNames[I];
    if I <> ParamCount - 1 then
      Param := Param + '; ';
  end;
  Result := Format(T, [Fun, FIdentifier, Param, Ret]);
end;

function TJvInterpreterFunctionDesc.GetParamName(Index: Integer): string;
begin
  Result := FParamNames[Index];
end;

//=== { TJvInterpreterRecHolder } ============================================

constructor TJvInterpreterRecHolder.Create(const ARecordType: string; ARec: Pointer);
begin
  // (rom) added inherited Create
  inherited Create;
  Assert(ARecordType <> '');
  FRecordType := ARecordType;
  Rec := ARec;
  {$IFDEF JvInterpreter_DEBUG}
  Inc(ObjCount);
  {$ENDIF JvInterpreter_DEBUG}
end;

destructor TJvInterpreterRecHolder.Destroy;
var
  I: Integer;
begin
  if Assigned(JvInterpreterRecord) then
  begin
    if Assigned(JvInterpreterRecord.DestroyFunc) then
      JvInterpreterRecord.DestroyFunc(Rec)
    else
    begin
      for I := 0 to JvInterpreterRecord.FieldCount - 1 do
      begin
        if JvInterpreterRecord.Fields[I].Typ = varEmpty then
          JvInterpreterVarFree(Variant(PVarData(PAnsiChar(Rec) + JvInterpreterRecord.Fields[I].Offset)^));
      end;
      FreeMem(Rec, JvInterpreterRecord.RecordSize);
    end;
  end
  else
    JvInterpreterError(ieInternal, -1);
  inherited Destroy;
  {$IFDEF JvInterpreter_DEBUG}
  Dec(ObjCount);
  {$ENDIF JvInterpreter_DEBUG}
end;

//=== { TJvInterpreterSrcFunction } ==========================================

constructor TJvInterpreterSrcFunction.Create;
begin
  inherited Create;
  FFunctionDesc := TJvInterpreterFunctionDesc.Create;
end;

destructor TJvInterpreterSrcFunction.Destroy;
begin
  FFunctionDesc.Free;
  inherited Destroy;
end;

//=== { TJvInterpreterExtFunction } ==========================================

function TJvInterpreterExtFunction.CallDll(Args: TJvInterpreterArgs): Variant;
begin
  if DllInstance > 0 then
    Result := JvInterpreter.CallDllIns(DllInstance, FunctionName, Args, FunctionDesc.FParamTypes,
      FunctionDesc.ResTyp)
  else
    Result := JvInterpreter.CallDll(DllName, FunctionName, Args, FunctionDesc.FParamTypes,
      FunctionDesc.ResTyp)
end;

//=== { TJvInterpreterEvent } ================================================

constructor TJvInterpreterEvent.Create(AOwner: TJvInterpreterExpression;
  AInstance: TObject; const AUnitName, AFunctionName, APropName: string);
begin
  // (rom) added inherited Create
  inherited Create;
  FOwner := AOwner;
  FInstance := AInstance;
  FUnitName := AUnitName;
  FFunctionName := AFunctionName;
  FPropName := APropName;
  {$IFDEF JvInterpreter_DEBUG}
  Inc(ObjCount);
  {$ENDIF JvInterpreter_DEBUG}
end;

destructor TJvInterpreterEvent.Destroy;
begin
  FArgs.Free;
  inherited Destroy;
  {$IFDEF JvInterpreter_DEBUG}
  Dec(ObjCount);
  {$ENDIF JvInterpreter_DEBUG}
end;

function TJvInterpreterEvent.GetArgs: TJvInterpreterArgs;
begin
  if FArgs = nil then
    FArgs := TJvInterpreterArgs.Create;
  Result := FArgs;
end;

function TJvInterpreterEvent.CallFunction(Args: TJvInterpreterArgs;
  Params: array of Variant): Variant;
var
  I: Integer;
  NV: Variant;
begin
  if Args = nil then
    Args := Self.Args;
  Args.Clear;
  for I := Low(Params) to High(Params) do
  begin
    Args.Values[Args.Count] := Params[I];
    Inc(Args.Count);
  end;
  NV := Null;
  Result := FOwner.CallFunctionEx(FInstance, FUnitName, FFunctionName, Args, NV);
end;

//=== { TJvInterpreterIdentifierList } =======================================

function TJvInterpreterIdentifierList.Find(const Identifier: string;
  var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := AnsiStrIComp(PChar(TJvInterpreterIdentifier(List[I]).Identifier), PChar(Identifier));
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

function SortIdentifier(Item1, Item2: Pointer): Integer;
begin
  { function AnsiStrIComp about 30% faster than AnsiCompareText }
  { Result := AnsiCompareText(TJvInterpreterIdentifier(Item1).Identifier,
     TJvInterpreterIdentifier(Item2).Identifier); }
  Result := AnsiStrIComp(PChar(TJvInterpreterIdentifier(Item1).Identifier),
    PChar(TJvInterpreterIdentifier(Item2).Identifier));
end;

procedure TJvInterpreterIdentifierList.Sort(Compare: TListSortCompare = nil);
begin
  if Assigned(Compare) then
    inherited Sort(Compare)
  else
    inherited Sort(SortIdentifier);
end;

function TJvInterpreterIdentifierList.IndexOf(const UnitName, Identifier: string): TJvInterpreterIdentifier;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    Result := TJvInterpreterIdentifier(Items[I]);
    if Cmp(Result.Identifier, Identifier) and
      (Cmp(Result.UnitName, UnitName) or (UnitName = '')) then
      Exit;
  end;
  Result := nil;
end;

//=== { TJvInterpreterAdapter } ==============================================

constructor TJvInterpreterAdapter.Create(AOwner: TJvInterpreterExpression);
begin
  // (rom) added inherited Create
  inherited Create;
  FOwner := AOwner;
  FSrcUnitList := TJvInterpreterIdentifierList.Create;
  FExtUnitList := TJvInterpreterIdentifierList.Create;
  FIntfGetList := TJvInterpreterIdentifierList.Create;
  FIntfSetList := TJvInterpreterIdentifierList.Create;
  FIntfIGetList := TJvInterpreterIdentifierList.Create;
  FIntfISetList := TJvInterpreterIdentifierList.Create;
  FIntfIDGetList := TJvInterpreterIdentifierList.Create;
  FIntfIDSetList := TJvInterpreterIdentifierList.Create;
  FGetList := TJvInterpreterMethodList.Create;
  FSetList := TJvInterpreterMethodList.Create;
  FIGetList := TJvInterpreterMethodList.Create;
  FISetList := TJvInterpreterMethodList.Create;
  FIDGetList := TJvInterpreterIdentifierList.Create;
  FIDSetList := TJvInterpreterIdentifierList.Create;
  FDirectGetList := TJvInterpreterIdentifierList.Create;
  FClassList := TJvInterpreterIdentifierList.Create;
  FConstList := TJvInterpreterIdentifierList.Create;
  FFunctionList := TJvInterpreterMethodList.Create;
  FRecordList := TJvInterpreterIdentifierList.Create;
  FRecordGetList := TJvInterpreterIdentifierList.Create;
  FRecordSetList := TJvInterpreterIdentifierList.Create;
  FOnGetList := TJvInterpreterIdentifierList.Create;
  FOnSetList := TJvInterpreterIdentifierList.Create;
  FExtFunctionList := TJvInterpreterIdentifierList.Create;
  FSrcFunctionList := TJvInterpreterIdentifierList.Create;
  FEventHandlerList := TJvInterpreterIdentifierList.Create;
  FEventList := TJvInterpreterIdentifierList.Create;
  FSrcVarList := TJvInterpreterVarList.Create;
  FSrcClassList := TJvInterpreterIdentifierList.Create;

  FIntfGetList.Duplicates := dupAccept;
  FIntfSetList.Duplicates := dupAccept;
  FIntfIGetList.Duplicates := dupAccept;
  FIntfISetList.Duplicates := dupAccept;
  FGetList.Duplicates := dupAccept;
  FSetList.Duplicates := dupAccept;
  FIGetList.Duplicates := dupAccept;
  FISetList.Duplicates := dupAccept;

  FDisableExternalFunctions := False;
end;

destructor TJvInterpreterAdapter.Destroy;
begin
  Clear;
  FSrcUnitList.Free;
  FExtUnitList.Free;
  FIntfGetList.Free;
  FIntfSetList.Free;
  FIntfIGetList.Free;
  FIntfISetList.Free;
  FIntfIDGetList.Free;
  FIntfIDSetList.Free;
  FGetList.Free;
  FSetList.Free;
  FIGetList.Free;
  FISetList.Free;
  FIDGetList.Free;
  FIDSetList.Free;
  FDirectGetList.Free;
  FClassList.Free;
  FConstList.Free;
  FFunctionList.Free;
  FRecordList.Free;
  FRecordGetList.Free;
  FRecordSetList.Free;
  FOnGetList.Free;
  FOnSetList.Free;
  FExtFunctionList.Free;
  FSrcFunctionList.Free;
  FEventHandlerList.Free;
  FEventList.Free;
  FSrcVarList.Free;
  FSrcClassList.Free;
  inherited Destroy;
end;

procedure TJvInterpreterAdapter.ClearSource;
var
  I: Integer;
begin
  ClearList(FSrcUnitList);
  ClearList(FSrcFunctionList);
  FSrcVarList.Clear;
  for I := 0 to FSrcClassList.Count-1 do
    TJvInterpreterClass(FSrcClassList[I]).ClassFields.Clear;
  ClearList(FSrcClassList);
end;

procedure TJvInterpreterAdapter.ClearNonSource;
begin
  ClearList(FExtUnitList);
  ClearList(FIntfGetList);
  ClearList(FIntfSetList);
  ClearList(FIntfIGetList);
  ClearList(FIntfISetList);
  ClearList(FIntfIDGetList);
  ClearList(FIntfIDSetList);
  ClearList(FGetList);
  ClearList(FSetList);
  ClearList(FIGetList);
  ClearList(FISetList);
  ClearList(FIDGetList);
  ClearList(FIDSetList);
  ClearList(FDirectGetList);
  ClearList(FClassList);
  ClearList(FConstList);
  ClearList(FFunctionList);
  ClearList(FRecordList);
  ClearList(FRecordGetList);
  ClearList(FRecordSetList);
  ClearList(FExtFunctionList);
  ClearList(FEventHandlerList);
  ClearList(FEventList);
  ClearMethodList(FOnGetList);
  ClearMethodList(FOnSetList);
end;

procedure TJvInterpreterAdapter.Clear;
begin
  ClearSource;
  ClearNonSource;
end;

procedure TJvInterpreterAdapter.Assign(Source: TJvInterpreterAdapter);
var
  I: Integer;
begin
  if Source = Self then
    Exit;
  for I := 0 to Source.FGetList.Count - 1 do
    with TJvInterpreterMethod(Source.FGetList[I]) do
      AddGetEx(FClassType, Identifier, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FSetList.Count - 1 do
    with TJvInterpreterMethod(Source.FSetList[I]) do
      AddSetEx(FClassType, Identifier, Func, ParamCount, ParamTypes, Data);
  for I := 0 to Source.FIGetList.Count - 1 do
    with TJvInterpreterMethod(Source.FIGetList[I]) do
      AddIGetEx(FClassType, Identifier, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FISetList.Count - 1 do
    with TJvInterpreterMethod(Source.FISetList[I]) do
      AddISetEx(FClassType, Identifier, Func, ParamCount, ParamTypes, Data);
  for I := 0 to Source.FIDGetList.Count - 1 do
    with TJvInterpreterMethod(Source.FIDGetList[I]) do
      AddIDGetEx(FClassType, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FIDSetList.Count - 1 do
    with TJvInterpreterMethod(Source.FIDSetList[I]) do
      AddIDSetEx(FClassType, Func, ParamCount, ParamTypes, Data);
  for I := 0 to Source.FIntfGetList.Count - 1 do
    with TJvInterpreterIntfMethod(Source.FIntfGetList[I]) do
      AddIntfGetEx(IID, Identifier, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FIntfSetList.Count - 1 do
    with TJvInterpreterIntfMethod(Source.FIntfSetList[I]) do
      AddIntfSetEx(IID, Identifier, Func, ParamCount, ParamTypes, Data);
  for I := 0 to Source.FIntfIGetList.Count - 1 do
    with TJvInterpreterIntfMethod(Source.FIntfIGetList[I]) do
      AddIntfIGetEx(IID, Identifier, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FIntfISetList.Count - 1 do
    with TJvInterpreterIntfMethod(Source.FIntfISetList[I]) do
      AddIntfISetEx(IID, Identifier, Func, ParamCount, ParamTypes, Data);
  for I := 0 to Source.FIntfIDGetList.Count - 1 do
    with TJvInterpreterIntfMethod(Source.FIntfIDGetList[I]) do
      AddIntfIDGetEx(IID, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FIntfIDSetList.Count - 1 do
    with TJvInterpreterIntfMethod(Source.FIntfIDSetList[I]) do
      AddIntfIDSetEx(IID, Func, ParamCount, ParamTypes, Data);
  for I := 0 to Source.FDirectGetList.Count - 1 do
    with TJvInterpreterDMethod(Source.FDirectGetList[I]) do
      AddDGetEx(FClassType, Identifier, Func, ParamCount, ParamTypes, ResTyp,
        CallConvention, Data);
  for I := 0 to Source.FFunctionList.Count - 1 do
    with TJvInterpreterMethod(Source.FFunctionList[I]) do
      AddFunctionEx(UnitName, Identifier, Func, ParamCount, ParamTypes, ResTyp, Data);
  for I := 0 to Source.FExtUnitList.Count - 1 do
    with TJvInterpreterIdentifier(Source.FExtUnitList[I]) do
      AddExtUnitEx(Identifier, Data);
  for I := 0 to Source.FClassList.Count - 1 do
  begin
    with TJvInterpreterClass(Source.FClassList[I]) do
      AddClassEx(UnitName, FClassType, Identifier, Data);
    TJvInterpreterClass(FClassList[FClassList.Count-1]).ClassFields.Assign(
      TJvInterpreterClass(Source.FClassList[I]).ClassFields);
  end;

  for I := 0 to Source.FSrcFunctionList.Count - 1 do
    with TJvInterpreterSrcFunction(Source.FSrcFunctionList[I]).FunctionDesc do
      AddSrcFunEx(UnitName, Identifier, ClassIdentifier, PosBeg, PosEnd, ParamCount, FParamTypes,
        FParamTypeNames, FParamNames, ResTyp, ResTypName, ResDataType,
        TJvInterpreterSrcFunction(Source.FSrcFunctionList[I]).Data);
  for I := 0 to Source.FSrcUnitList.Count - 1 do
  begin
    with TJvInterpreterSrcUnit(Source.FSrcUnitList[I]) do
      AddSrcUnitEx(Identifier, Source, '', Data);
    TJvInterpreterSrcUnit(FSrcUnitList[FSrcUnitList.Count - 1]).FUsesList:=
      TJvInterpreterSrcUnit(Source.FSrcUnitList[I]).UsesList;
  end;

  for I := 0 to Source.FConstList.Count - 1 do
    with TJvInterpreterConst(Source.FConstList[I]) do
      AddConstEx(UnitName, Identifier, Value, Data);
  for I := 0 to Source.FRecordList.Count - 1 do
    with TJvInterpreterRecord(Source.FRecordList[I]) do
      AddRecEx(UnitName, Identifier, RecordSize, Fields, CreateFunc,
        DestroyFunc, CopyFunc, Data);
  for I := 0 to Source.FRecordGetList.Count - 1 do
    with TJvInterpreterRecMethod(Source.FRecordGetList[I]) do
      AddRecGetEx(UnitName, JvInterpreterRecord.Identifier, Identifier, Func, ParamCount,
        ParamTypes, ResTyp, Data);
  for I := 0 to Source.FRecordSetList.Count - 1 do
    with TJvInterpreterRecMethod(Source.FRecordSetList[I]) do
      AddRecSetEx(UnitName, JvInterpreterRecord.Identifier, Identifier, Func, ParamCount,
        ParamTypes, Data);
  for I := 0 to Source.FExtFunctionList.Count - 1 do
    with TJvInterpreterExtFunction(Source.FExtFunctionList[I]) do
      AddExtFunEx(UnitName, Identifier, DllInstance, DllName, FunctionName, FunctionIndex,
        FunctionDesc.FParamCount, FunctionDesc.FParamTypes, FunctionDesc.FResTyp, Data);
  for I := 0 to Source.FEventHandlerList.Count - 1 do
    with TJvInterpreterEventDesc(Source.FEventHandlerList[I]) do
      AddHandlerEx(UnitName, Identifier, EventClass, Code, Data);
  for I := 0 to Source.FEventList.Count - 1 do
    with TJvInterpreterClass(Source.FEventList[I]) do
      AddEventEx(UnitName, FClassType, Identifier, Data);
  for I := 0 to Source.FOnGetList.Count - 1 do
    AddOnGet(TJvInterpreterGetValue(PMethod(Source.FOnGetList[I])^));
  for I := 0 to Source.FOnSetList.Count - 1 do
    AddOnSet(TJvInterpreterSetValue(PMethod(Source.FOnSetList[I])^));
end;

procedure TJvInterpreterAdapter.AddSrcUnit(const Identifier, Source, UsesList: string);
begin
  AddSrcUnitEx(Identifier, Source, UsesList, nil);
end;

{ if unit with name 'Identifier' already exists its source will be replaced }

procedure TJvInterpreterAdapter.AddSrcUnitEx(const Identifier, Source, UsesList: string;
  Data: Pointer);
var
  JvInterpreterUnit: TJvInterpreterSrcUnit;
  S: string;
  I: Integer;
  JvInterpreterIdentifier: TJvInterpreterIdentifier;
begin
  JvInterpreterUnit := nil;
  for I := 0 to FSrcUnitList.Count - 1 do
  begin
    JvInterpreterIdentifier := TJvInterpreterIdentifier(FSrcUnitList.Items[I]);
    if Cmp(JvInterpreterIdentifier.Identifier, Identifier) then
    begin
      JvInterpreterUnit := TJvInterpreterSrcUnit(FSrcUnitList.Items[I]);
      Break;
    end;
  end;
  if JvInterpreterUnit = nil then
  begin
    JvInterpreterUnit := TJvInterpreterSrcUnit.Create;
    FSrcUnitList.Add(JvInterpreterUnit);
  end;

  if JvInterpreterUnit.FSource = '' then
  begin
    JvInterpreterUnit.Identifier := Identifier;
    JvInterpreterUnit.FSource := Source;
    JvInterpreterUnit.Data := Data;
    I := 0;
    S := Trim(SubStrBySeparator(UsesList, I, ','));
    while S <> '' do
    begin
      JvInterpreterUnit.FUsesList[I] := S;
      Inc(I);
      S := Trim(SubStrBySeparator(UsesList, I, ','));
    end;
  end;
end;

procedure TJvInterpreterAdapter.AddExtUnit(const Identifier: string);
begin
  AddExtUnitEx(Identifier, nil);
end;

procedure TJvInterpreterAdapter.AddExtUnitEx(const Identifier: string; Data: Pointer);
var
  JvInterpreterUnit: TJvInterpreterIdentifier;
begin
  JvInterpreterUnit := TJvInterpreterIdentifier.Create;
  JvInterpreterUnit.Identifier := Identifier;
  JvInterpreterUnit.Data := Data;
  FExtUnitList.Add(JvInterpreterUnit);
end;

procedure TJvInterpreterAdapter.AddClass(const UnitName: string; AClassType: TClass;
  const Identifier: string);
begin
  AddClassEx(UnitName, AClassType, Identifier, nil);
end;

procedure TJvInterpreterAdapter.AddClassEx(const UnitName: string; AClassType: TClass;
  const Identifier: string; Data: Pointer);
var
  JvInterpreterClass: TJvInterpreterClass;
begin
  JvInterpreterClass := TJvInterpreterClass.Create;
  JvInterpreterClass.FClassType := AClassType;
  JvInterpreterClass.Identifier := Identifier;
  JvInterpreterClass.Data := Data;
  JvInterpreterClass.UnitName := UnitName;
  FClassList.Add(JvInterpreterClass);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddGet(AClassType: TClass; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word);
begin
  AddGetEx(AClassType, Identifier, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddGetEx(AClassType: TClass; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FGetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIGet(AClassType: TClass; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word);
begin
  AddIGetEx(AClassType, Identifier, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddIGetEx(AClassType: TClass; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIGetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIDGet(AClassType: TClass;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word);
begin
  AddIDGetEx(AClassType, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddIDGetEx(AClassType: TClass;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIDGetList.Add(JvInterpreterMethod);
end;

procedure TJvInterpreterAdapter.AddIntfGet(IID: TGUID; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
  ParamTypes: array of Word; ResTyp: Word);
begin
  AddIntfGetEx(IID, Identifier, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddIntfGetEx(IID: TGUID; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
  ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterIntfMethod;
begin
  JvInterpreterMethod := TJvInterpreterIntfMethod.Create;
  JvInterpreterMethod.IID := IID;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIntfGetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIntfIGet(IID: TGUID; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word; ResTyp: Word);
begin
  AddIntfIGetEx(IID, Identifier, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddIntfIGetEx(IID: TGUID; const Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterIntfMethod;
begin
  JvInterpreterMethod := TJvInterpreterIntfMethod.Create;
  JvInterpreterMethod.IID := IID;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIntfIGetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIntfIDGet(IID: TGUID;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word; ResTyp: Word);
begin
  AddIntfIDGetEx(IID, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddIntfIDGetEx(IID: TGUID;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterIntfMethod;
begin
  JvInterpreterMethod := TJvInterpreterIntfMethod.Create;
  JvInterpreterMethod.IID := IID;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIntfIDGetList.Add(JvInterpreterMethod);
end;

procedure TJvInterpreterAdapter.AddDGet(AClassType: TClass; const Identifier: string;
  GetFunc: Pointer; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; CallConvention: TCallConvention);
begin
  AddDGetEx(AClassType, Identifier, GetFunc, ParamCount, ParamTypes, ResTyp,
    CallConvention, nil);
end;

procedure TJvInterpreterAdapter.AddDGetEx(AClassType: TClass; const Identifier: string;
  GetFunc: Pointer; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; CallConvention: TCallConvention; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterDMethod;
begin
  JvInterpreterMethod := TJvInterpreterDMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  JvInterpreterMethod.CallConvention := CallConvention;
  FDirectGetList.Add(JvInterpreterMethod);
end;

procedure TJvInterpreterAdapter.AddSet(AClassType: TClass; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
begin
  AddSetEx(AClassType, Identifier, SetFunc, ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddSetEx(AClassType: TClass; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word;
  Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @SetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FSetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddISet(AClassType: TClass; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
begin
  AddISetEx(AClassType, Identifier, SetFunc, ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddISetEx(AClassType: TClass; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word;
  Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @SetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FISetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIDSet(AClassType: TClass;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
begin
  AddIDSetEx(AClassType, SetFunc, ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddIDSetEx(AClassType: TClass;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word;
  Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.FClassType := AClassType;
  JvInterpreterMethod.Func := @SetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIDSetList.Add(JvInterpreterMethod);
end;

procedure TJvInterpreterAdapter.AddIntfSet(IID: TGUID; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
  ParamTypes: array of Word);
begin
  AddIntfSetEx(IID, Identifier, SetFunc, ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddIntfSetEx(IID: TGUID; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word;
  Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterIntfMethod;
begin
  JvInterpreterMethod := TJvInterpreterIntfMethod.Create;
  JvInterpreterMethod.IID := IID;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @SetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIntfSetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIntfISet(IID: TGUID; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
begin
  AddIntfISetEx(IID, Identifier, SetFunc, ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddIntfISetEx(IID: TGUID; const Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterIntfMethod;
begin
  JvInterpreterMethod := TJvInterpreterIntfMethod.Create;
  JvInterpreterMethod.IID := IID;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @SetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIntfISetList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddIntfIDSet(IID: TGUID;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
begin
  AddIntfIDSetEx(IID, SetFunc, ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddIntfIDSetEx(IID: TGUID;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterIntfMethod;
begin
  JvInterpreterMethod := TJvInterpreterIntfMethod.Create;
  JvInterpreterMethod.IID := IID;
  JvInterpreterMethod.Func := @SetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  FIntfIDSetList.Add(JvInterpreterMethod);
end;

procedure TJvInterpreterAdapter.AddFunction(const UnitName, Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word);
begin
  AddFunctionEx(UnitName, Identifier, GetFunc, ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddFunctionEx(const UnitName, Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; Data: Pointer);
var
  JvInterpreterMethod: TJvInterpreterMethod;
begin
  JvInterpreterMethod := TJvInterpreterMethod.Create;
  JvInterpreterMethod.Identifier := Identifier;
  JvInterpreterMethod.Func := @GetFunc;
  JvInterpreterMethod.ParamCount := ParamCount;
  JvInterpreterMethod.ResTyp := ResTyp;
  JvInterpreterMethod.Data := Data;
  ConvertParamTypes(ParamTypes, JvInterpreterMethod.ParamTypes);
  JvInterpreterMethod.UnitName := UnitName;
  FFunctionList.Add(JvInterpreterMethod);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddRec(const UnitName, Identifier: string;
  RecordSize: Integer; Fields: array of TJvInterpreterRecField;
  CreateFunc: TJvInterpreterAdapterNewRecord;
  DestroyFunc: TJvInterpreterAdapterDisposeRecord;
  CopyFunc: TJvInterpreterAdapterCopyRecord);
begin
  AddRecEx(UnitName, Identifier, RecordSize, Fields, CreateFunc, DestroyFunc, CopyFunc, nil);
end;

procedure TJvInterpreterAdapter.AddRecEx(const UnitName, Identifier: string;
  RecordSize: Integer; Fields: array of TJvInterpreterRecField;
  CreateFunc: TJvInterpreterAdapterNewRecord;
  DestroyFunc: TJvInterpreterAdapterDisposeRecord;
  CopyFunc: TJvInterpreterAdapterCopyRecord;
  Data: Pointer);
var
  JvInterpreterRecord: TJvInterpreterRecord;
  I: Integer;
begin
  JvInterpreterRecord := TJvInterpreterRecord.Create;
  JvInterpreterRecord.Identifier := Identifier;
  JvInterpreterRecord.RecordSize := RecordSize;
  JvInterpreterRecord.CreateFunc := CreateFunc;
  JvInterpreterRecord.DestroyFunc := DestroyFunc;
  JvInterpreterRecord.CopyFunc := CopyFunc;
  JvInterpreterRecord.Data := Data;
  for I := Low(Fields) to High(Fields) do
  begin
    JvInterpreterRecord.Fields[I] := Fields[I];
    JvInterpreterRecord.Fields[I].DataType := nil;
  end;
  JvInterpreterRecord.FieldCount := High(Fields) - Low(Fields) + 1;
  JvInterpreterRecord.UnitName := UnitName;
  FRecordList.Add(JvInterpreterRecord);
end;

procedure TJvInterpreterAdapter.AddRecGet(const UnitName, RecordType, Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
  ParamTypes: array of Word; ResTyp: Word);
begin
  AddRecGetEx(UnitName, RecordType, Identifier, GetFunc, ParamCount,
    ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddRecGetEx(const UnitName, RecordType, Identifier: string;
  GetFunc: TJvInterpreterAdapterGetValue; ParamCount: Integer;
  ParamTypes: array of Word; ResTyp: Word; Data: Pointer);
var
  RecMethod: TJvInterpreterRecMethod;
begin
  RecMethod := TJvInterpreterRecMethod.Create;
  RecMethod.JvInterpreterRecord := GetRec(RecordType) as TJvInterpreterRecord;
  RecMethod.Identifier := Identifier;
  RecMethod.Func := @GetFunc;
  RecMethod.ParamCount := ParamCount;
  RecMethod.ResTyp := ResTyp;
  RecMethod.Data := Data;
  ConvertParamTypes(ParamTypes, RecMethod.ParamTypes);
  RecMethod.UnitName := UnitName;
  FRecordGetList.Add(RecMethod);
end;

procedure TJvInterpreterAdapter.AddRecSet(const UnitName, RecordType, Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
begin
  AddRecSetEx(UnitName, RecordType, Identifier, SetFunc,
    ParamCount, ParamTypes, nil);
end;

procedure TJvInterpreterAdapter.AddRecSetEx(const UnitName, RecordType, Identifier: string;
  SetFunc: TJvInterpreterAdapterSetValue; ParamCount: Integer;
  ParamTypes: array of Word; Data: Pointer);
var
  RecMethod: TJvInterpreterRecMethod;
begin
  RecMethod := TJvInterpreterRecMethod.Create;
  RecMethod.JvInterpreterRecord := GetRec(RecordType) as TJvInterpreterRecord;
  RecMethod.Identifier := Identifier;
  RecMethod.Func := @SetFunc;
  RecMethod.ParamCount := ParamCount;
  RecMethod.Data := Data;
  ConvertParamTypes(ParamTypes, RecMethod.ParamTypes);
  RecMethod.UnitName := UnitName;
  FRecordSetList.Add(RecMethod);
end;

procedure TJvInterpreterAdapter.AddConst(const UnitName, Identifier: string;
  Value: Variant);
begin
  AddConstEx(UnitName, Identifier, Value, nil);
end;

procedure TJvInterpreterAdapter.AddConstEx(const AUnitName, AIdentifier: string;
  AValue: Variant; AData: Pointer);
var
  JvInterpreterConst: TJvInterpreterConst;
begin
  JvInterpreterConst := TJvInterpreterConst.Create;
  JvInterpreterConst.Identifier := AIdentifier;
  JvInterpreterConst.Value := AValue;
  JvInterpreterConst.Data := AData;
  JvInterpreterConst.UnitName := AUnitName;
  FConstList.Add(JvInterpreterConst);
  FSorted := False;
end;

procedure TJvInterpreterAdapter.AddExtFun(const UnitName, Identifier: string;
  DllInstance: HINST; const DllName, FunctionName: string; FunctionIndex: Integer;
  ParamCount: Integer; ParamTypes: array of Word; ResTyp: Word);
begin
  AddExtFunEx(UnitName, Identifier, DllInstance, DllName, FunctionName, FunctionIndex,
    ParamCount, ParamTypes, ResTyp, nil);
end;

procedure TJvInterpreterAdapter.AddExtFunEx(const AUnitName, AIdentifier: string;
  ADllInstance: HINST; const ADllName, AFunctionName: string; AFunIndex: Integer;
  AParamCount: Integer; AParamTypes: array of Word; AResTyp: Word; AData: Pointer);
var
  JvInterpreterExtFun: TJvInterpreterExtFunction;
begin
  JvInterpreterExtFun := TJvInterpreterExtFunction.Create;
  with JvInterpreterExtFun do
  begin
    FunctionDesc.FUnitName := AUnitName;
    Identifier := AIdentifier;
    DllInstance := ADllInstance;
    DllName := ADllName;
    FunctionName := AFunctionName;
    FunctionIndex := AFunIndex;
    FunctionDesc.FParamCount := AParamCount;
    FunctionDesc.FResTyp := AResTyp;
    Data := AData;
    ConvertParamTypes(AParamTypes, FunctionDesc.FParamTypes);
  end;
  JvInterpreterExtFun.UnitName := AUnitName;
  FExtFunctionList.Add(JvInterpreterExtFun);
end;

procedure TJvInterpreterAdapter.AddSrcFun(const UnitName, Identifier: string;
  ClassIdentifier: string;
  PosBeg, PosEnd: Integer; ParamCount: Integer; ParamTypes: array of Word;
  ParamTypeNames: array of string;
  ParamNames: array of string; ResTyp: Word; const AResTypName: string;
  AResDataType: IJvInterpreterDataType;
  Data: Pointer);
begin
  AddSrcFunEx(UnitName, Identifier, ClassIdentifier, PosBeg, PosEnd, ParamCount, ParamTypes,
    ParamTypeNames,
    ParamNames, ResTyp, AResTypName, AResDataType, nil);
end;

procedure TJvInterpreterAdapter.AddSrcFunEx(const AUnitName, AIdentifier: string;
  AClassIdentifier: string;
  APosBeg, APosEnd: Integer; AParamCount: Integer; AParamTypes: array of Word;
  AParamTypeNames: array of string;
  AParamNames: array of string; AResTyp: Word; const AResTypName: string;
  AResDataType: IJvInterpreterDataType;
  AData: Pointer);
var
  JvInterpreterSrcFun: TJvInterpreterSrcFunction;
begin
  JvInterpreterSrcFun := TJvInterpreterSrcFunction.Create;
  with JvInterpreterSrcFun do
  begin
    FunctionDesc.FUnitName := AUnitName;
    FunctionDesc.FIdentifier := AIdentifier;
    FunctionDesc.FPosBeg := APosBeg;
    FunctionDesc.FPosEnd := APosEnd;
    FunctionDesc.FParamCount := AParamCount;
    FunctionDesc.FResTyp := AResTyp;
    FunctionDesc.FResTypName := AResTypName;
    FunctionDesc.FResDataType := AResDataType;
    FunctionDesc.FClassIdentifier := AClassIdentifier; // class method support
    Identifier := AIdentifier;
    Data := AData;
    ConvertParamTypes(AParamTypes, FunctionDesc.FParamTypes);
    ConvertParamNames(AParamNames, FunctionDesc.FParamNames);
    ConvertParamNames(AParamTypeNames, FunctionDesc.FParamTypeNames);
    FunctionDesc.FResTyp := AResTyp;
  end;
  JvInterpreterSrcFun.UnitName := AUnitName;  // Code Insight
  FSrcFunctionList.Add(JvInterpreterSrcFun);
end;

procedure TJvInterpreterAdapter.AddHandler(const UnitName, Identifier: string;
  EventClass: TJvInterpreterEventClass; Code: Pointer);
begin
  AddHandlerEx(UnitName, Identifier, EventClass, Code, nil);
end;

procedure TJvInterpreterAdapter.AddHandlerEx(const AUnitName, AIdentifier: string;
  AEventClass: TJvInterpreterEventClass; ACode: Pointer; AData: Pointer);
var
  JvInterpreterEventDesc: TJvInterpreterEventDesc;
begin
  JvInterpreterEventDesc := TJvInterpreterEventDesc.Create;
  with JvInterpreterEventDesc do
  begin
    UnitName := AUnitName;
    Identifier := AIdentifier;
    EventClass := AEventClass;
    Code := ACode;
    Data := AData;
  end;
  FEventHandlerList.Add(JvInterpreterEventDesc);
end;

procedure TJvInterpreterAdapter.AddEvent(const UnitName: string; AClassType: TClass;
  const Identifier: string);
begin
  AddEventEx(UnitName, AClassType, Identifier, nil);
end;

procedure TJvInterpreterAdapter.AddEventEx(const AUnitName: string; AClassType: TClass;
  const AIdentifier: string; AData: Pointer);
var
  JvInterpreterEvent: TJvInterpreterClass;
begin
  JvInterpreterEvent := TJvInterpreterClass.Create;
  with JvInterpreterEvent do
  begin
    UnitName := AUnitName;
    Identifier := AIdentifier;
    FClassType := AClassType;
    Data := AData;
  end;
  FEventList.Add(JvInterpreterEvent);
end;

procedure TJvInterpreterAdapter.AddSrcVar(const UnitName, Identifier, Typ: string;
  VTyp: Word; const Value: Variant; DataType: IJvInterpreterDataType);
begin
  FSrcVarList.AddVar(UnitName, Identifier, Typ, VTyp, Value, DataType);
end;

procedure TJvInterpreterAdapter.AddSrcClass(JvInterpreterSrcClass: TJvInterpreterIdentifier);
begin
  FSrcClassList.Add(JvInterpreterSrcClass);
end;

function TJvInterpreterAdapter.GetSrcClass(const Identifier: string): TJvInterpreterIdentifier;
begin
  Result := FSrcClassList.IndexOf('', Identifier);
end;

procedure TJvInterpreterAdapter.AddOnGet(Method: TJvInterpreterGetValue);
var
  PM: PMethod;
begin
  New(PM);
  PM^ := TMethod(Method);
  FOnGetList.Add(PM);
end;

procedure TJvInterpreterAdapter.AddOnSet(Method: TJvInterpreterSetValue);
var
  PM: PMethod;
begin
  New(PM);
  PM^ := TMethod(Method);
  FOnSetList.Add(PM);
end;

function TJvInterpreterAdapter.GetRec(const RecordType: string): TObject;
var
  I: Integer;
begin
  for I := 0 to FRecordList.Count - 1 do
  begin
    Result := FRecordList[I];
    if Cmp(TJvInterpreterRecord(Result).Identifier, RecordType) then
      Exit;
  end;
  Result := nil;
end;

procedure TJvInterpreterAdapter.CheckArgs(var Args: TJvInterpreterArgs; ParamCount: Integer;
  var ParamTypes: TTypeArray);
var
  I: Integer;
begin
  if ParamCount = prArgsNoCheck then
    Exit;
  if Args.Count > ParamCount then
    JvInterpreterError(ieTooManyParams, -1);
  if Args.Count < ParamCount then
    JvInterpreterError(ieNotEnoughParams, -1);

  Args.FHasVars := False;
  Args.Types := ParamTypes;
  for I := 0 to Args.Count - 1 do
    if (Args.FVarNames[I] <> '') and ((ParamTypes[I] and varByRef) <> 0) then
    begin
      Args.FHasVars := True;
      Break;
    end;
end;

procedure TJvInterpreterAdapter.CheckAction(Expression: TJvInterpreterExpression;
  Args: TJvInterpreterArgs; Data: Pointer);
begin
  // abstract
end;

function TJvInterpreterAdapter.FindFunDesc(const UnitName: string;
  const Identifier: string;
  const ClassIdentifier:string=''): TJvInterpreterFunctionDesc;
var
  I: Integer;
begin
  for I := FSrcFunctionList.Count - 1 downto 0 do
  begin
    Result := TJvInterpreterSrcFunction(FSrcFunctionList.Items[I]).FunctionDesc;
    if Cmp(Result.Identifier, Identifier) and
      (Cmp(Result.ClassIdentifier, ClassIdentifier) or (ClassIdentifier='')) and  //  Class methods support
      (Cmp(Result.UnitName, UnitName) or (UnitName = '')) then
      Exit;
  end;
  if (UnitName <> '') and (ClassIdentifier='') then //  Class methods support
    Result := FindFunDesc('', Identifier)
  else
    Result := nil;
end;

function TJvInterpreterAdapter.GetValue(Expression: TJvInterpreterExpression; const Identifier: string;
  var Value: Variant; Args: TJvInterpreterArgs): Boolean;
var
  I: Integer;

  function GetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
  begin
    Result := GetValueRTTI(Identifier, Value, Args);
    if Result then
      Exit;

    if FGetList.Find(Identifier, i) then
      for I := I to FGetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterMethod(FGetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          (((Args.ObjTyp = varObject) and
          (Args.Obj is JvInterpreterMethod.FClassType)) or
          ((Args.ObjTyp = varClass) and
          (TClass(Args.Obj) = JvInterpreterMethod.FClassType))) {?!} then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
          Result := True;
          Exit;
        end;
      end;
    if Cmp(Identifier, 'Free') then
    begin
      Result := True;
      Args.Obj.Free;
      Args.Obj := nil;
      Value := Null;
      Exit;
    end;
  end;

  function IntfGetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterIntfMethod;
    Intf: IUnknown;
  begin
    Result := False;
    if FIntfGetList.Find(Identifier, I) then
      for I := I to FIntfGetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterIntfMethod(FIntfGetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          ((Args.ObjTyp = varUnknown) and
          (IUnknown(Pointer(Args.Obj)).QueryInterface(JvInterpreterMethod.IID, Intf) = S_OK)) then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount,
            JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
          Result := True;
          Exit;
        end;
      end;
  end;

  function IGetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
  begin
    if FIGetList.Find(Identifier, I) then
      for I := I to FIGetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterMethod(FIGetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          (((Args.ObjTyp = varObject) and
          (Args.Obj is JvInterpreterMethod.FClassType)) or
          ((Args.ObjTyp = varClass) and
          (TClass(Args.Obj) = JvInterpreterMethod.FClassType))) {?!} then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
          Result := True;
          Args.ReturnIndexed := True;
          Exit;
        end;
      end;
    Result := False;
  end;

  function IntfIGetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterIntfMethod;
    Intf: IUnknown;
  begin
    Result := False;
    if FIntfIGetList.Find(Identifier, I) then
      for I := I to FIntfIGetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterIntfMethod(FIntfIGetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          ((Args.ObjTyp = varUnknown) and
          (IUnknown(Pointer(Args.Obj)).QueryInterface(JvInterpreterMethod.IID, Intf) = S_OK)) then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount,
            JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
          Args.ReturnIndexed := True;
          Result := True;
          Exit;
        end;
      end;
  end;

  { function DGetMethod is under construction }

  function DGetMethod: Boolean;
  var
    JvInterpreterMethod: TJvInterpreterDMethod;
    I, J: Integer;
    AInt: Integer;
    AWord: Word;
    iRes: Integer;
    Func: Pointer;
    {$IFNDEF CPU64}
    RegEAX, RegEDX, RegECX: Integer;
    {$ELSE}
    Params: TArray<System.Rtti.TValue>;
    {$ENDIF ~CPU64}
  begin
    Result := False;
    {$IFNDEF CPU64}
    iRes := 0;
    {$ENDIF ~CPU64}
    for I := 0 to FDirectGetList.Count - 1 do
    begin
      JvInterpreterMethod := TJvInterpreterDMethod(FDirectGetList[I]);
      Func := JvInterpreterMethod.Func;
      if Assigned(JvInterpreterMethod.Func) and
        (((Args.ObjTyp = varObject) and
        (Args.Obj is JvInterpreterMethod.FClassType)) { or
          ((Args.ObjTyp = varClass) and
          (TClass(Args.Obj) = JvInterpreterMethod.FClassType))}) and
        Cmp(JvInterpreterMethod.Identifier, Identifier) then
      begin
        Args.Identifier := Identifier;
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        {$IFNDEF CPU64}
        if ccFastCall in JvInterpreterMethod.CallConvention then
        begin
          { !!! Delphi fast-call !!! }
          { push parameters to stack }
          for J := 2 to JvInterpreterMethod.ParamCount - 1 do
            if (JvInterpreterMethod.ParamTypes[J] = varInteger) or
              (JvInterpreterMethod.ParamTypes[J] = varObject) or
              (JvInterpreterMethod.ParamTypes[J] = varPointer) or
              (JvInterpreterMethod.ParamTypes[J] = varBoolean) {?} then
            begin
              AInt := Args.Values[J];
              asm
                push AInt
              end;
            end
            else
            if JvInterpreterMethod.ParamTypes[J] = varSmallint then
            begin
              AWord := Word(Args.Values[J]);
              asm
                push AWord
              end;
            end
            else
              JvInterpreterErrorN(ieDirectInvalidArgument, -1, Identifier);

          RegEAX := Integer(Args.Obj);
          if JvInterpreterMethod.ParamCount > 0 then
            if (JvInterpreterMethod.ParamTypes[0] = varInteger) or
              (JvInterpreterMethod.ParamTypes[0] = varObject) or
              (JvInterpreterMethod.ParamTypes[0] = varPointer) or
              (JvInterpreterMethod.ParamTypes[0] = varBoolean) or
              (JvInterpreterMethod.ParamTypes[0] = varSmallint) or
              (JvInterpreterMethod.ParamTypes[0] = varString) then
              RegEDX := TVarData(Args.Values[0]).VInteger
            else
              JvInterpreterErrorN(ieDirectInvalidArgument, -1, Identifier);

          if JvInterpreterMethod.ParamCount > 1 then
            if (JvInterpreterMethod.ParamTypes[1] = varInteger) or
              (JvInterpreterMethod.ParamTypes[1] = varObject) or
              (JvInterpreterMethod.ParamTypes[1] = varPointer) or
              (JvInterpreterMethod.ParamTypes[1] = varBoolean) or
              (JvInterpreterMethod.ParamTypes[1] = varSmallint) or
              (JvInterpreterMethod.ParamTypes[1] = varString) then
              RegECX := TVarData(Args.Values[1]).VInteger
            else
              JvInterpreterErrorN(ieDirectInvalidArgument, -1, Identifier);

          if (JvInterpreterMethod.ResTyp = varSmallint) or
            (JvInterpreterMethod.ResTyp = varInteger) or
            (JvInterpreterMethod.ResTyp = varBoolean) or
            (JvInterpreterMethod.ResTyp = varEmpty) or
            (JvInterpreterMethod.ResTyp = varObject) or
            (JvInterpreterMethod.ResTyp = varPointer) then
            asm
              mov      EAX, RegEAX
              mov      EDX, RegEDX
              mov      ECX, RegECX
              call     Func
              mov      iRes, EAX
            end
          else
            JvInterpreterErrorN(ieDirectInvalidResult, -1, Identifier);
        {$ELSE}
        SetLength(Params, 1 + JvInterpreterMethod.ParamCount);
        Params[0] := TValue.From(Args.Obj);
        for J := 0 to JvInterpreterMethod.ParamCount - 1 do
        begin
          if (JvInterpreterMethod.ParamTypes[J] = varInteger) or
             (JvInterpreterMethod.ParamTypes[J] = varBoolean) {?} then
          begin
            AInt := Args.Values[J];
            Params[1 + J] := TValue.From(AInt);
          end
          else if JvInterpreterMethod.ParamTypes[J] = varSmallint then
          begin
            AWord := Word(Args.Values[J]);
            Params[1 + J] := TValue.From(AWord);
          end
          else if (JvInterpreterMethod.ParamTypes[J] = varObject) or
                  (JvInterpreterMethod.ParamTypes[J] = varString) or
                  (JvInterpreterMethod.ParamTypes[J] = varPointer) then
          begin
            Params[1 + J] := TValue.From(TVarData(Args.Values[J]).VPointer);
          end
          else
            JvInterpreterErrorN(ieDirectInvalidArgument, -1, Identifier);
        end;
        iRes := System.Rtti.Invoke(Func, Params, System.TypInfo.TCallConv.ccReg, TypeInfo(Integer), False).AsType<Integer>();
        {$ENDIF ~CPU64}

          { clear result }
          if (JvInterpreterMethod.ResTyp = varInteger) or
            (JvInterpreterMethod.ResTyp = varObject) then
            Value := iRes
          else
          if JvInterpreterMethod.ResTyp = varSmallint then
            Value := iRes and $0000FFFF
          else
          if JvInterpreterMethod.ResTyp = varBoolean then
          begin
            Value := iRes and $000000FF;
            TVarData(Value).VType := varBoolean;
          end
          else
          if JvInterpreterMethod.ResTyp = varEmpty then
            Value := Null;
        {$IFNDEF CPU64}
        end
        else
          JvInterpreterErrorN(ieDirectInvalidConvention, -1, Identifier);
        {$ENDIF ~CPU64}
        Result := True;
        Exit;
      end;
    end;
  end;

  function GetRecord: Boolean;
  var
    I: Integer;
    JvInterpreterRecord: TJvInterpreterRecord;
    Rec: PAnsiChar;
    JvInterpreterRecMethod: TJvInterpreterRecMethod;
  begin
    Result := False;
    JvInterpreterRecord := (Args.Obj as TJvInterpreterRecHolder).JvInterpreterRecord;
    for I := 0 to JvInterpreterRecord.FieldCount - 1 do
      if Cmp(JvInterpreterRecord.Fields[I].Identifier, Identifier) then
      begin
        Rec := P2R(Args.Obj);
        with JvInterpreterRecord.Fields[I] do
          case Typ of
            varSmallint:
              Value := Smallint(PWord(Rec + Offset)^);
            varInteger:
              Value := PInteger(Rec + Offset)^;
            varSingle:
              Value := PSingle(Rec + Offset)^;
            varDouble:
              Value := PDouble(Rec + Offset)^;
            varCurrency:
              Value := PCurrency(Rec + Offset)^;
            varDate:
              Value := PDateTime(Rec + Offset)^;
            varOleStr:
              Value := PWideString(Rec + Offset)^;
            varBoolean:
              Value := PBool(Rec + Offset)^;
            varVariant:
              Value := PVariant(Rec + Offset)^;
            varString:
              Value := PString(Rec + Offset)^;
            varEmpty:
              JvInterpreterVarCopy(Value, Variant(PVarData(Rec + Offset)^));
          end;
        Result := True;
        Exit;
      end;
    for I := 0 to FRecordGetList.Count - 1 do
    begin
      JvInterpreterRecMethod := TJvInterpreterRecMethod(FRecordGetList[I]);
      if (JvInterpreterRecMethod.JvInterpreterRecord = JvInterpreterRecord) and
        Cmp(JvInterpreterRecMethod.Identifier, Identifier) then
      begin
        Args.Identifier := Identifier;
        CheckArgs(Args, JvInterpreterRecMethod.ParamCount, JvInterpreterRecMethod.ParamTypes);
        TJvInterpreterAdapterGetValue(JvInterpreterRecMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end
  end;

  function GetConst: Boolean;
  var
    I: Integer;
    JvInterpreterConst: TJvInterpreterConst;
  begin
    if Cmp(Identifier, kwNIL) then
    begin
      Value := P2V(nil);
      Result := True;
      Exit;
    end;
    if Cmp(Identifier, 'Null') then
    begin
      Value := Null;
      Result := True;
      Exit;
    end;
    Result := FConstList.Find(Identifier, I);
    if Result then
    begin
      JvInterpreterConst := TJvInterpreterConst(FConstList[I]);
      CheckAction(Expression, Args, JvInterpreterConst.Data);
      Value := JvInterpreterConst.Value;
    end;
  end;

  function GetClass: Boolean;
  var
    I: Integer;
    JvInterpreterClass: TJvInterpreterClass;
  begin
    Result := FClassList.Find(Identifier, I);
    if Result then
    begin
      JvInterpreterClass := TJvInterpreterClass(FClassList[I]);
      if Args.Count = 0 then
        Value := C2V(JvInterpreterClass.FClassType)
      else
      if Args.Count = 1 then
      { typecasting }
      begin
        CheckAction(Expression, Args, JvInterpreterClass.Data);
        Value := Args.Values[0];
        if TVarData(Value).VType <> varClass then
          TVarData(Value).VType := varObject;
      end
      else
        JvInterpreterError(ieTooManyParams, -1);
    end;
  end;

  function GetFun: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
  begin
    Result := FFunctionList.Find(Identifier, I);
    if Result then
    begin
      JvInterpreterMethod := TJvInterpreterMethod(FFunctionList[I]);
      if Cmp(JvInterpreterMethod.Identifier, Identifier) then
      begin
        Args.Identifier := Identifier;
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
      end;
    end;
  end;

  function GetExtFun: Boolean;
  var
    I: Integer;
    JvInterpreterExtFun: TJvInterpreterExtFunction;
  begin
    if DisableExternalFunctions then
    begin
      Result := False;
      Exit;
    end;
    for I := 0 to FExtFunctionList.Count - 1 do
    begin
      JvInterpreterExtFun := TJvInterpreterExtFunction(FExtFunctionList[I]);
      if Cmp(JvInterpreterExtFun.Identifier, Identifier) then
      begin
        Args.Identifier := Identifier;
        CheckAction(Expression, Args, JvInterpreterExtFun.Data);
        CheckArgs(Args, JvInterpreterExtFun.FunctionDesc.ParamCount,
          JvInterpreterExtFun.FunctionDesc.FParamTypes);
        Value := JvInterpreterExtFun.CallDll(Args);
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

  function GetSrcVar: Boolean;
  begin
    Result := FSrcVarList.GetValue(Identifier, Value, Args);
  end;

  function GetSrcUnit: Boolean;
  var
    I: Integer;
    JvInterpreterSrcUnit: TJvInterpreterSrcUnit;
    FParams: TTypeArray;
  begin
    for I := 0 to FSrcUnitList.Count - 1 do
    begin
      JvInterpreterSrcUnit := TJvInterpreterSrcUnit(FSrcUnitList[I]);
      if Cmp(JvInterpreterSrcUnit.Identifier, Identifier) then
      begin
        CheckArgs(Args, 0, FParams);
        Value := O2V(JvInterpreterSrcUnit);
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

  {$IFDEF JvInterpreter_OLEAUTO}
  function GetOleAutoFun: Boolean;
  var
    FParams: TTypeArray;
  begin
    Result := False;
    if Cmp(Identifier, 'CreateOleObject') or
      Cmp(Identifier, 'GetActiveOleObject') or
      Cmp(Identifier, 'GetOleObject') then
    begin
      FParams[0] := varString;
      CheckArgs(Args, 1, FParams);
      if Cmp(Identifier, 'CreateOleObject') then
        Value := CreateOleObject(Args.Values[0])
      else
      if Cmp(Identifier, 'GetActiveOleObject') then
        Value := GetActiveOleObject(Args.Values[0])
      else { GetOleObject }
      begin
        try
          Value := GetActiveOleObject(Args.Values[0])
        except
          on E: EOleError do
            Value := CreateOleObject(Args.Values[0])
        end;
      end;
      Result := True;
      Exit;
    end;
  end;
  {$ENDIF JvInterpreter_OLEAUTO}

  function TypeCast: Boolean;
  var
    VT: Word;
  begin
    VT := TypeName2VarTyp(Identifier);
    Result := VT <> varEmpty;
    if Result then
    begin
      Value := Args.Values[0];
      TVarData(Value).VType := VT;
    end;
  end;

begin
  Result := True;
  if not FSorted then
    Sort;

  if Args.Indexed then
  begin
    if Args.ObjTyp = varRecord then
    begin
      if (Args.Obj is TJvInterpreterRecHolder) and GetRecord then
      begin
        Args.ReturnIndexed := False;
        Exit;
      end;
    end
    else
    if (Args.Obj <> nil) and ((Args.ObjTyp = varObject) or (Args.ObjTyp = varClass)) then
    begin
      if IGetMethod then
        Exit;
      I := Args.Count;
      try // try to get indexed property
        Args.Count := 0;
        Result := GetMethod or DGetMethod;
      finally
        Args.Count := I;
      end;
      if Result then
        Exit;
    end
    else
    if Args.ObjTyp = varUnknown then
    begin
      if IntfIGetMethod then
        Exit;
    end
    else
    if Args.ObjTyp = varDispatch then
    { Ole automation call }
    begin
      {$IFDEF JvInterpreter_OLEAUTO}
      Result := DispatchCall(Identifier, Value, Args, True);
      if Result then
      begin
        Args.ReturnIndexed := True;
        Exit;
      end;
      {$ELSE}
      NotImplemented(RsOleAutomationCall);
      {$ENDIF JvInterpreter_OLEAUTO}
    end;
  end
  else
  begin
    if Args.Obj <> nil then
    begin
      { methods }
      if (Args.ObjTyp = varObject) or (Args.ObjTyp = varClass) then
      begin
        if GetMethod or DGetMethod then
          Exit;
      end
      else
      if Args.ObjTyp = varUnknown then
      begin
        if IntfGetMethod then
          Exit;
      end
      else
      if Args.ObjTyp = varRecord then
      begin
        if (Args.Obj is TJvInterpreterRecHolder) and GetRecord then
          Exit;
      end
      else
      if Args.ObjTyp = varDispatch then
      { Ole automation call }
      begin
        {$IFDEF JvInterpreter_OLEAUTO}
        Result := DispatchCall(Identifier, Value, Args, True);
        if Result then
          Exit;
        {$ELSE}
        NotImplemented(RsOleAutomationCall);
        {$ENDIF JvInterpreter_OLEAUTO}
      end;
    end
    else
    begin
      { classes }
      if GetClass then
        Exit;
      { constants }
      if GetConst then
        Exit;
      { classless functions and procedures }
      if GetFun then
        Exit;
      { external functions }
      if GetExtFun then
        Exit;
      {$IFDEF JvInterpreter_OLEAUTO}
      if GetOleAutoFun then
        Exit;
      {$ENDIF JvInterpreter_OLEAUTO}
      if TypeCast then
        Exit;
    end;
  end;

  { source variables and constants }
  if GetSrcVar then
    Exit;

  if not ((Args.Obj <> nil) and ((Args.ObjTyp = varObject) or (Args.ObjTyp = varClass))) then
    if GetSrcUnit then
      Exit;

  for I := 0 to FOnGetList.Count - 1 do { Iterate }
  begin
    TJvInterpreterGetValue(FOnGetList[I]^)(Self, Identifier, Value, Args, Result);
    if Result then
      Exit;
  end;
  Result := False;
end;

function TJvInterpreterAdapter.SetValue(Expression: TJvInterpreterExpression; const Identifier: string;
  const Value: Variant; Args: TJvInterpreterArgs): Boolean;
var
  I: Integer;
  {$IFDEF JvInterpreter_OLEAUTO}
  V: Variant;
  {$ENDIF JvInterpreter_OLEAUTO}

  function SetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
  begin
    Result := SetValueRTTI(Identifier, Value, Args);
    if Result then
      Exit;
    for I := 0 to FSetList.Count - 1 do
    begin
      JvInterpreterMethod := TJvInterpreterMethod(FSetList[I]);
      if Assigned(JvInterpreterMethod.Func) and
        (Args.Obj is JvInterpreterMethod.FClassType) and
        Cmp(JvInterpreterMethod.Identifier, Identifier) then
      begin
        Args.Identifier := Identifier;
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        TJvInterpreterAdapterSetValue(JvInterpreterMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
  end;

  function ISetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
  begin
    Result := False;
    if FISetList.Find(Identifier, I) then
      for I := I to FISetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterMethod(FISetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          (Args.Obj is JvInterpreterMethod.FClassType) and
          Cmp(JvInterpreterMethod.Identifier, Identifier) then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterSetValue(JvInterpreterMethod.Func)(Value, Args);
          Result := True;
          Args.ReturnIndexed := True;
          Exit;
        end;
      end;
  end;

  function IntfSetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterIntfMethod;
    Intf: IUnknown;
  begin
    Result := False;
    if FIntfSetList.Find(Identifier, I) then
      for I := I to FIntfSetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterIntfMethod(FIntfSetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          ((Args.ObjTyp = varUnknown) and
          (IUnknown(Pointer(Args.Obj)).QueryInterface(JvInterpreterMethod.IID, Intf) = S_OK)) then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount,
            JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterSetValue(JvInterpreterMethod.Func)(Value, Args);
          Result := True;
          Exit;
        end;
      end;
  end;

  function IntfISetMethod: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterIntfMethod;
    Intf: IUnknown;
  begin
    Result := False;
    if FIntfISetList.Find(Identifier, I) then
      for I := I to FIntfISetList.Count - 1 do
      begin
        JvInterpreterMethod := TJvInterpreterIntfMethod(FIntfISetList[I]);
        if not Cmp(JvInterpreterMethod.Identifier, Identifier) then
          Break;
        if Assigned(JvInterpreterMethod.Func) and
          ((Args.ObjTyp = varUnknown) and
          (IUnknown(Pointer(Args.Obj)).QueryInterface(JvInterpreterMethod.IID, Intf) = S_OK)) then
        begin
          Args.Identifier := Identifier;
          CheckAction(Expression, Args, JvInterpreterMethod.Data);
          CheckArgs(Args, JvInterpreterMethod.ParamCount,
            JvInterpreterMethod.ParamTypes);
          TJvInterpreterAdapterSetValue(JvInterpreterMethod.Func)(Value, Args);
          Args.ReturnIndexed := True;
          Result := True;
          Exit;
        end;
      end;
  end;

  function SetRecord: Boolean;
  var
    I: Integer;
    JvInterpreterRecord: TJvInterpreterRecord;
    JvInterpreterRecMethod: TJvInterpreterRecMethod;
    Rec: PAnsiChar;
  begin
    Result := False;
    JvInterpreterRecord := (Args.Obj as TJvInterpreterRecHolder).JvInterpreterRecord;
    for I := 0 to JvInterpreterRecord.FieldCount - 1 do
      if Cmp(JvInterpreterRecord.Fields[I].Identifier, Identifier) then
      begin
        Rec := P2R(Args.Obj);
        with JvInterpreterRecord.Fields[I] do
          case Typ of
            varSmallint:
              PWord(Rec + Offset)^ := Word(Value);
            varInteger:
              PInteger(Rec + Offset)^ := Value;
            varSingle:
              PSingle(Rec + Offset)^ := Value;
            varDouble:
              PDouble(Rec + Offset)^ := Value;
            varCurrency:
              PCurrency(Rec + Offset)^ := Value;
            varDate:
              PDateTime(Rec + Offset)^ := Value;
            varOleStr:
              PWideString(Rec + Offset)^ := Value;
            varBoolean:
              PBool(Rec + Offset)^ := Value;
            varVariant:
              PVariant(Rec + Offset)^ := Value;
            varString:
              PString(Rec + Offset)^ := Value;
            varEmpty:
              JvInterpreterVarAssignment(Variant(PVarData(Rec + Offset)^), Value);
          end;
        Result := True;
        Exit;
      end;
    for I := 0 to FRecordSetList.Count - 1 do
    begin
      JvInterpreterRecMethod := TJvInterpreterRecMethod(FRecordSetList[I]);
      if (JvInterpreterRecMethod.JvInterpreterRecord = JvInterpreterRecord) and
        Cmp(JvInterpreterRecMethod.Identifier, Identifier) then
      begin
        Args.Identifier := Identifier;
        CheckArgs(Args, JvInterpreterRecMethod.ParamCount, JvInterpreterRecMethod.ParamTypes);
        TJvInterpreterAdapterSetValue(JvInterpreterRecMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
  end;

  function SetSrcVar: Boolean;
  begin
    Result := FSrcVarList.SetValue(Identifier, Value, Args);
  end;

begin
  Result := True;
  if not FSorted then
    Sort;

  if Args.Indexed then
  begin
    if (Args.Obj <> nil) and ((Args.ObjTyp = varObject) or (Args.ObjTyp = varClass)) then
    begin
      if ISetMethod then
        Exit;
    end
    else
    if Args.ObjTyp = varUnknown then
    begin
      if IntfISetMethod then
        Exit;
    end;
  end
  else
  begin
    if Args.Obj <> nil then
    begin
      { methods }
      if (Args.ObjTyp = varObject) or (Args.ObjTyp = varClass) then
      begin
        if SetMethod then
          Exit;
      end
      else
      { interface methods }
      if (Args.ObjTyp = varUnknown) then
      begin
        if IntfSetMethod then
          Exit;
      end
      else
      if Args.ObjTyp = varRecord then
      begin
        if (Args.Obj is TJvInterpreterRecHolder) and SetRecord then
          Exit;
      end
      else
      if Args.ObjTyp = varDispatch then
      { Ole automation call }
      begin
        {$IFDEF JvInterpreter_OLEAUTO}
        V := Value;
        Result := DispatchCall(Identifier, V, Args, False);
        if Result then
          Exit;
        {$ELSE}
        NotImplemented(RsOleAutomationCall);
        {$ENDIF JvInterpreter_OLEAUTO}
      end;
    end;
  end;

  { source variables and constants }
  if SetSrcVar then
    Exit;

  for I := 0 to FOnSetList.Count - 1 do { Iterate }
  begin
    TJvInterpreterSetValue(FOnSetList[I]^)(Self, Identifier, Value, Args, Result);
    if Result then
      Exit;
  end;
  Result := False;
end;

function TJvInterpreterAdapter.GetElement(Expression: TJvInterpreterExpression;
  const Variable: Variant; var Value: Variant; var Args: TJvInterpreterArgs): Boolean;

  function GetID: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
    Obj: TObject;
  begin
    Obj := V2O(Variable);
    for I := 0 to FIDGetList.Count - 1 do
    begin
      JvInterpreterMethod := TJvInterpreterMethod(FIDGetList[I]);
      if Obj is JvInterpreterMethod.FClassType then
      begin
        Args.Obj := Obj;
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

  function IntfGetID: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterIntfMethod;
    Intf: IUnknown;
    OIntf: IUnknown;
  begin
    Intf := IUnknown(Variable);
    for I := 0 to FIntfIDGetList.Count - 1 do
    begin
      JvInterpreterMethod := TJvInterpreterIntfMethod(FIntfIDGetList[I]);
      if Intf.QueryInterface(JvInterpreterMethod.IID, OIntf) = S_OK then
      begin
        Args.Obj := Pointer(Intf);
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        TJvInterpreterAdapterGetValue(JvInterpreterMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  Result := True;
  { default indexed properties }
  if TVarData(Variable).VType = varObject then
  begin
    if GetID then
      Exit;
    Result := False;
  end
  else
  if TVarData(Variable).VType = varUnknown then
  begin
    if IntfGetID then
      Exit;
    Result := False;
  end
  else
    Result := False;
end;

function TJvInterpreterAdapter.SetElement(Expression: TJvInterpreterExpression;
  var Variable: Variant; const Value: Variant; var Args: TJvInterpreterArgs): Boolean;

  function SetID: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterMethod;
    Obj: TObject;
  begin
    Obj := V2O(Variable);
    for I := 0 to FIDSetList.Count - 1 do
    begin
      JvInterpreterMethod := TJvInterpreterMethod(FIDSetList[I]);
      if Obj is JvInterpreterMethod.FClassType then
      begin
        Args.Obj := Obj;
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        TJvInterpreterAdapterSetValue(JvInterpreterMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

  function IntfSetID: Boolean;
  var
    I: Integer;
    JvInterpreterMethod: TJvInterpreterIntfMethod;
    Intf: IUnknown;
    OIntf: IUnknown;
  begin
    Intf := IUnknown(Variable);
    for I := 0 to FIntfIDSetList.Count - 1 do
    begin
      JvInterpreterMethod := TJvInterpreterIntfMethod(FIntfIDSetList[I]);
      if Intf.QueryInterface(JvInterpreterMethod.IID, OIntf) = S_OK then
      begin
        Args.Obj := Pointer(Intf);
        CheckAction(Expression, Args, JvInterpreterMethod.Data);
        CheckArgs(Args, JvInterpreterMethod.ParamCount, JvInterpreterMethod.ParamTypes);
        TJvInterpreterAdapterSetValue(JvInterpreterMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  Result := True;
  { default indexed properties }
  if TVarData(Variable).VType = varObject then
  begin
    if SetID then
      Exit;
    Result := False;
  end
  else
  if TVarData(Variable).VType = varUnknown then
  begin
    if IntfSetID then
      Exit;
    Result := False;
  end
  else
    Result := False;
end;

function TJvInterpreterAdapter.SetRecord(var Value: Variant): Boolean;
var
  RecHolder: TJvInterpreterRecHolder;
begin
  if TVarData(Value).VType = varRecord then
  begin
    RecHolder := TJvInterpreterRecHolder(TVarData(Value).VPointer);
    RecHolder.JvInterpreterRecord := TJvInterpreterRecord(GetRec(RecHolder.RecordType));
    Result := Assigned(RecHolder.JvInterpreterRecord);
  end
  else
    Result := False;
end;

function TJvInterpreterAdapter.NewRecord(const RecordType: string;
  var Value: Variant): Boolean;
var
  JvInterpreterRecord: TJvInterpreterRecord;
begin
  JvInterpreterRecord := TJvInterpreterRecord(GetRec(RecordType));
  if JvInterpreterRecord = nil then
    Result := False
  else
  begin
    JvInterpreterRecord.NewRecord(Value);
    Result := True;
  end;
end;

{$IFDEF JvInterpreter_OLEAUTO}
function TJvInterpreterAdapter.DispatchCall(const Identifier: string; var Value: Variant;
  Args: TJvInterpreterArgs; Get: Boolean): Boolean; stdcall;
var
  CallDesc: TCallDesc;
  ParamTypes: array [0..MaxDispArgs * 4 - 1] of Byte;
  Ptr: Integer;
  TypePtr: Integer;
  PVRes: PVariant;
  Names: string;
  I: Integer;

  procedure AddParam(const Param: Variant);
  var
    Int: Integer;
    Wrd: WordBool;
    Poin: Pointer;
    Dbl: Double;
    TempDisp : IDispatch; //ComObj

    procedure AddParam1(Typ: Byte; ParamSize: Integer; const Param);
    begin
     { CallDesc.ArgTypes[Ptr] := Typ;
      Move(Param, ParamTypes[Ptr], ParamSize);
      Inc(Ptr, ParamSize); }
      CallDesc.ArgTypes[TypePtr] := Typ;
      Move(Param, ParamTypes[Ptr], ParamSize);
      Inc(Ptr, ParamSize);
      Inc(TypePtr);
    end;

  begin
    case TVarData(Param).VType of
      varInteger:
        begin
          Int := Param;
          AddParam1(varInteger, SizeOf(Int), Int);
        end;
      varDouble, varCurrency:
        begin
          Dbl := Param;
          AddParam1(varDouble, SizeOf(Dbl), Dbl);
        end;
      varString:
        begin
          Poin := V2P(Param);
          AddParam1(varStrArg, SizeOf(Poin), Poin);
        end;
      varBoolean:
        begin
          Wrd := WordBool(Param);
          AddParam1(varBoolean, SizeOf(Wrd), Wrd);
        end;
      varDispatch:
        begin
          TempDisp := Param;//VarToInterface(Param).IFace);
          AddParam1(varDispatch, SizeOf(TempDisp), TempDisp);
        end;

    end;
  end;

begin
  Result := True;
  { Call method through Ole Automation }
  with CallDesc do
  begin
    if Get then
      CallType := DISPATCH_METHOD or DISPATCH_PROPERTYGET
    else
      CallType := DISPATCH_PROPERTYPUT;
    ArgCount := Args.Count;
    NamedArgCount := 0; { named args not supported by JvInterpreter }
  end;
  Names := Identifier + #00;
  Ptr := 0;
  TypePtr := 0;
  if not Get then
  begin
    AddParam(Value);
    Inc(CallDesc.ArgCount);
  end;
  for I := 0 to Args.Count - 1 do
    AddParam(Args.Values[I]);
  Value := Null;
  { When calling procedures(without result) PVRes must be nil }
  if Args.HasResult and Get then
    PVRes := @Value
  else
    PVRes := nil;
  try
    { call }
    // (rom) absolute removed
    VarDispInvoke(PVRes, Args.Obj, PChar(Names), @CallDesc, @ParamTypes[0]);
    Ptr := 0;
    TypePtr := 0;
  except
    on E: EOleError do
      JvInterpreterErrorN2(ieOleAuto, -1, Identifier, E.Message);
  end;
  if Get and (TVarData(Value).VType = varOleStr) then
    Value := VarAsType(Value, varString);
end;
{$ENDIF JvInterpreter_OLEAUTO}

function TJvInterpreterAdapter.GetValueRTTI(const Identifier: string; var Value: Variant;
  Args: TJvInterpreterArgs): Boolean;
var
  TypeInf: PTypeInfo;
  PropInf: PPropInfo;
  PropTyp: TypInfo.TTypeKind;
begin
  Result := False;
  if (Args.ObjTyp <> varObject) or (Args.Obj = nil) then
    Exit;
  TypeInf := Args.Obj.ClassInfo;
  if TypeInf = nil then
    Exit;
  PropInf := GetPropInfo(TypeInf, Identifier);
  if PropInf = nil then
    Exit;
  PropTyp := PropInf.PropType^.Kind;
  case PropTyp of
    tkInteger, tkEnumeration:
      Value := GetOrdProp(Args.Obj, PropInf);
    tkChar, tkWChar:
      Value := Char(GetOrdProp(Args.Obj, PropInf));
    tkFloat:
      Value := GetFloatProp(Args.Obj, PropInf);
    {$IFDEF UNICODE} tkUString, {$ENDIF}
    tkString, tkLString, tkWString:
      Value := GetStrProp(Args.Obj, PropInf);
    tkClass:
      Value := O2V(TObject(GetOrdProp(Args.Obj, PropInf)));
    tkSet:
      Value := S2V(GetOrdProp(Args.Obj, PropInf));
    tkInterface:
      Value := GetInterfaceProp(Args.Obj, PropInf)
  else
    Exit;
  end;
  if PropInf^.PropType^.Name = 'Boolean' then
    TVarData(Value).VType := varBoolean;
  Result := True;
end;

function TJvInterpreterAdapter.SetValueRTTI(const Identifier: string; const Value: Variant;
  Args: TJvInterpreterArgs): Boolean;
var
  TypeInf: PTypeInfo;
  PropInf: PPropInfo;
  PropTyp: TypInfo.TTypeKind;
  Obj: TObject;
begin
  Result := False;
  if (Args.ObjTyp <> varObject) or (Args.Obj = nil) then
    Exit;
  Obj := Args.Obj;
  TypeInf := Obj.ClassInfo;
  if TypeInf = nil then
    Exit;
  PropInf := GetPropInfo(TypeInf, Identifier);
  if PropInf = nil then
    Exit;
  PropTyp := PropInf.PropType^.Kind;
  case PropTyp of
    tkInteger, tkEnumeration:
      SetOrdProp(Args.Obj, PropInf, Var2Type(Value, varInteger));
    tkChar, tkWChar:
      SetOrdProp(Args.Obj, PropInf, Integer(string(Value)[1]));
    tkFloat:
      SetFloatProp(Args.Obj, PropInf, Value);
    {$IFDEF UNICODE} tkUString, {$ENDIF}
    tkString, tkLString, tkWString:
      SetStrProp(Args.Obj, PropInf, VarToStr(Value));
    tkClass:
      SetOrdProp(Args.Obj, PropInf, NativeInt(V2O(Value)));
    tkSet:
      SetOrdProp(Args.Obj, PropInf, V2S(Value));
    tkInterface:
      SetInterfaceProp(Args.Obj, PropInf, Value);
  else
    Exit;
  end;
  Result := True;
end;

procedure TJvInterpreterAdapter.CurUnitChanged(const NewUnitName: string; var Source: string);
var
  I: Integer;
  JvInterpreterUnitSource: TJvInterpreterSrcUnit;
begin
  for I := 0 to FSrcUnitList.Count - 1 do
  begin
    JvInterpreterUnitSource := TJvInterpreterSrcUnit(FSrcUnitList.Items[I]);
    if Cmp(TJvInterpreterSrcUnit(JvInterpreterUnitSource).Identifier, NewUnitName) then
    begin
      Source := TJvInterpreterSrcUnit(JvInterpreterUnitSource).FSource;
      Exit;
    end;
  end;
  Source := '';
end;

function TJvInterpreterAdapter.UnitExists(const Identifier: string): Boolean;
var
  JvInterpreterIdentifier: TJvInterpreterIdentifier;
  I: Integer;
begin
  Result := True;
  for I := 0 to FSrcUnitList.Count - 1 do
  begin
    JvInterpreterIdentifier := TJvInterpreterIdentifier(FSrcUnitList.Items[I]);
    if Cmp(JvInterpreterIdentifier.Identifier, Identifier) then
      Exit;
  end;
  for I := 0 to FExtUnitList.Count - 1 do
  begin
    JvInterpreterIdentifier := TJvInterpreterIdentifier(FExtUnitList.Items[I]);
    if Cmp(JvInterpreterIdentifier.Identifier, Identifier) then
      Exit;
  end;
  Result := False;
end;

function TJvInterpreterAdapter.NewEvent(const UnitName: string; const FunctionName,
  EventType: string; AOwner: TJvInterpreterExpression; AObject: TObject;
  const APropName: string): TSimpleEvent;
var
  Event: TJvInterpreterEvent;
  I: Integer;
  JvInterpreterEventDesc: TJvInterpreterEventDesc;
begin
  for I := 0 to FEventHandlerList.Count - 1 do
  begin
    JvInterpreterEventDesc := TJvInterpreterEventDesc(FEventHandlerList.Items[I]);
    if Cmp(JvInterpreterEventDesc.Identifier, EventType) then
    begin
      Event := JvInterpreterEventDesc.EventClass.Create(AOwner, AObject, UnitName, FunctionName, APropName);
      TMethod(Result).Code := JvInterpreterEventDesc.Code;
      TMethod(Result).Data := Event;
      Exit;
    end;
  end;
  Result := nil;
end;

function TJvInterpreterAdapter.IsEvent(Obj: TObject; const Identifier: string): Boolean;
var
  JvInterpreterClass: TJvInterpreterClass;
  I: Integer;
begin
  for I := 0 to FEventList.Count - 1 do
  begin
    JvInterpreterClass := TJvInterpreterClass(FEventList[I]);
    if (Obj is JvInterpreterClass.FClassType) and
      Cmp(JvInterpreterClass.Identifier, Identifier) then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

procedure TJvInterpreterAdapter.Sort;
begin
  FConstList.Sort;
  FClassList.Sort;
  FFunctionList.Sort;
  FGetList.Sort;
  FSetList.Sort;
  FIntfGetList.Sort;
  FIntfSetList.Sort;
  FIGetList.Sort;
  FISetList.Sort;
  FIntfIGetList.Sort;
  FIntfISetList.Sort;
  FSorted := True;
end;

//=== { TJvInterpreterArgs } =================================================

destructor TJvInterpreterArgs.Destroy;
begin
  if OA <> nil then
    Dispose(OA);
  if FOAV <> nil then
    Dispose(FOAV);
  inherited Destroy;
end;

procedure TJvInterpreterArgs.Clear;
begin
  Count := 0;
  Obj := nil;
  ObjTyp := 0;
  FHasVars := False;
  Indexed := False;
  ReturnIndexed := False;
  ObjRefHolder := Unassigned;
end;

procedure TJvInterpreterArgs.OpenArray(const Index: Integer);
begin
  if OA = nil then
    New(OA);
  if FOAV = nil then
    New(FOAV);
  V2OA(Values[Index], OA^, FOAV^, OAS);
end;

procedure TJvInterpreterArgs.Delete(const Index: Integer);
var
  I: Integer;
begin
  for I := Index to Count - 2 do
  begin
    Types[I] := Types[I + 1];
    Values[I] := Values[I + 1];
    Names[I] := Names[I + 1];
  end;
  Dec(Count);
end;

//=== { TJvInterpreterExpression } ===========================================

constructor TJvInterpreterExpression.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FParser := TJvInterpreterParser.Create;
  FPStream := TStringStream.Create('');
  FArgs := TJvInterpreterArgs.Create;
  FAdapter := CreateAdapter;
  FDisableExternalFunctions := False;
  FAdapter.DisableExternalFunctions := False;
  FSharedAdapter := GlobalJvInterpreterAdapter;
  FLastError := EJvInterpreterError.Create(-1, -1, '', '');
  FAllowAssignment := True;
  FCompiled := False;
end;

destructor TJvInterpreterExpression.Destroy;
begin
  JvInterpreterVarFree(FVResult);
  FAdapter.Free;
  FArgs.Free;
  FPStream.Free;
  FParser.Free;
  FLastError.Free;
  inherited Destroy;
end;

procedure TJvInterpreterExpression.UpdateExceptionPos(E: Exception; const UnitName: string);

  procedure NoName(E: EJvInterpreterError);
  begin
    if not E.FExceptionPos then
    begin
      if E.FErrPos = -1 then
        E.FErrPos := CurPos;
      if E.FErrUnitName = '' then
        E.FErrUnitName := UnitName;
      if E.FErrUnitName <> '' then
      begin
        { first line has number 1 }
        E.FErrLine := GetLineByPos(FParser.Source, E.FErrPos) + BaseErrLine + 1;
        E.Message := Format(LoadStr2(ieErrorPos), [E.FErrUnitName, E.FErrLine, E.FErrMessage]);
        E.FExceptionPos := True;
      end;
    end;
  end;

begin
  if E is EJvInterpreterError then
  begin
    NoName(E as EJvInterpreterError);
    FLastError.Assign(E as EJvInterpreterError);
  end
  else
  if not FLastError.FExceptionPos then
  begin
    FLastError.FErrCode := ieExternal;
    FLastError.Message := E.Message;
    FLastError.FErrMessage := E.Message;
    NoName(FLastError);
  end;
end;

procedure TJvInterpreterExpression.Init;
begin
  JvInterpreterVarFree(FVResult);
  FExpStackPtr := -1;
  // Parse;
  FParser.Init;
  FBacked := False;
  FCurrArgs := FArgs;
  FAdapter.ClearNonSource;
  FLastError.Clear;
end;

function TJvInterpreterExpression.GetSource: string;
begin
  Result := FParser.Source;
end;

procedure TJvInterpreterExpression.SetSource(const Value: string);
begin
  FParser.Source := Value;
  SourceChanged;
end;

procedure TJvInterpreterExpression.SourceChanged;
begin
end;

procedure TJvInterpreterExpression.SetAdapter(Adapter: TJvInterpreterAdapter);
begin
  FAdapter := Adapter;
end;

procedure TJvInterpreterExpression.SetCurPos(Value: Integer);
begin
  if FParsed then
    FPStream.Position := Value
  else
    FParser.Pos := Value;
  FBacked := False;
end;

function TJvInterpreterExpression.GetCurPos: Integer;
begin
  if FParsed then
    Result := FPStream.Position
  else
    Result := FParser.Pos;
end;

procedure TJvInterpreterExpression.ErrorExpected(const Exp: string);
begin
  if TokenStr <> '' then
    JvInterpreterErrorN2(ieExpected, PosBeg, Exp, '''' + TokenStr + '''')
  else
    JvInterpreterErrorN2(ieExpected, PosBeg, Exp, LoadStr2(irEndOfFile));
end;

procedure TJvInterpreterExpression.ErrorNotImplemented(const Msg: string);
begin
  JvInterpreterErrorN(ieInternal, PosBeg, Msg + RsENotImplemented);
end;

function TJvInterpreterExpression.PosBeg: Integer;
begin
  Result := CurPos - Length(TokenStr);
end;

function TJvInterpreterExpression.PosEnd: Integer;
begin
  Result := CurPos;
end;

function TJvInterpreterExpression.GetTokenStr: string;
begin
  if FParsed and (TTyp <> ttUnknown) then
    Result := TypToken(TTyp)
  else
    Result := FTokenStr;
end;

procedure TJvInterpreterExpression.Parse;
begin
  FPStream.Size := 0;
  FPStream.Position := 0;
  FParser.Init;
  repeat
    ParseToken;
    WriteToken;
  until FTTyp = ttEmpty;
  FParsed := True;
  FPStream.Position := 0;
end;

procedure TJvInterpreterExpression.WriteToken;
begin
  WordSaveToStream(FPStream, Word(FTTyp));
  case FTTyp of
    ttInteger:
      IntSaveToStream(FPStream, FToken);
    ttString:
      StringSaveToStream(FPStream, FToken);
    ttTrue, ttFalse:
      BoolSaveToStream(FPStream, FToken);
    ttDouble:
      ExtendedSaveToStream(FPStream, FToken);
    ttIdentifier:
      StringSaveToStream(FPStream, FToken);
    ttUnknown:
      StringSaveToStream(FPStream, FTokenStr);
  end;
end;

procedure TJvInterpreterExpression.ReadToken;
begin
  FTTyp := Smallint(WordLoadFromStream(FPStream));
  case FTTyp of
    ttInteger:
      FToken := IntLoadFromStream(FPStream);
    ttString:
      FToken := StringLoadFromStream(FPStream);
    ttTrue, ttFalse:
      FToken := BoolLoadFromStream(FPStream);
    ttDouble:
      FToken := ExtendedLoadFromStream(FPStream);
    ttIdentifier:
      FToken := StringLoadFromStream(FPStream);
    ttUnknown:
      FTokenStr := StringLoadFromStream(FPStream);
  end;
end;

procedure TJvInterpreterExpression.NextToken;
begin
  if FBacked then
    FBacked := False
  else
  begin
    FPrevTTyp := FTTyp;
    if FParsed then
      ReadToken
    else
      ParseToken;
  end;
end;

procedure TJvInterpreterExpression.ParseToken;
var
  {$IFDEF DELPHI7_UP}
  FS: TFormatSettings;
  {$ELSE}
  OldDecimalSeparator: Char;
  {$ENDIF DELPHI7_UP}
  Dob: Extended;
  Int: Integer;
  ValueInt64: Int64;
  Stub: Integer;
begin
  FTokenStr := FParser.Token;
  FTTyp := TokenTyp(FTokenStr);
  case TTyp of
    ttInteger:
      begin
        Val(FTokenStr, Int, Stub);
        if Stub <> 0 then
        begin
          Val(FTokenStr, ValueInt64, Stub);
          FToken := ValueInt64;
          if Stub <> 0 then
            JvInterpreterError(ieIntegerRequired, FParser.Pos);
        end
        else
          FToken := Int;
      end;
    ttDouble:
      begin
        {$IFDEF DELPHI7_UP}
        FS.ThousandSeparator := ',';
        FS.DecimalSeparator := '.';
        if not TextToFloat(PChar(FTokenStr), Dob, fvExtended, FS) then
          JvInterpreterError(ieInternal, -1);
        {$ELSE}
        OldDecimalSeparator := DecimalSeparator;
        DecimalSeparator := '.';
        if not TextToFloat(PChar(FTokenStr), Dob, fvExtended) then
        begin
          DecimalSeparator := OldDecimalSeparator;
          JvInterpreterError(ieInternal, -1);
        end
        else
          DecimalSeparator := OldDecimalSeparator;
        {$ENDIF DELPHI7_UP}
        FToken := Dob;
      end;
    ttString:
      FToken := Copy(TokenStr, 2, Length(FTokenStr) - 2);
    ttFalse:
      FToken := False;
    ttTrue:
      FToken := True;
    ttIdentifier:
      FToken := FTokenStr;
    {-----olej-----}
    ttArray:
      FToken := FTokenStr;
    {-----olej-----}
  end;
end;

procedure TJvInterpreterExpression.Back;
begin
  // JvInterpreterError(ieInternal, -2);
  if FBacked then
    JvInterpreterError(ieInternal, -1);
  FBacked := True;
end;

procedure TJvInterpreterExpression.SafeBack;
begin
  if not FBacked then
    Back;
end;

function TJvInterpreterExpression.CreateAdapter: TJvInterpreterAdapter;
begin
  Result := TJvInterpreterAdapter.Create(Self);
end;

function TJvInterpreterExpression.Expression1: Variant;
var
  OldExpStackPtr: Integer;

  procedure PushExp(var Value: Variant);
  begin
    Inc(FExpStackPtr);
    if FExpStackPtr > High(FExpStack) then
      JvInterpreterError(ieExpressionStackOverflow, -1);
    JvInterpreterVarCopy(FExpStack[FExpStackPtr], Value);
  end;

  function PopExp: Variant;
  begin
    if FExpStackPtr = -1 then
      JvInterpreterError(ieInternal, -1);
    JvInterpreterVarCopy(Result, FExpStack[FExpStackPtr]);
    Dec(FExpStackPtr);
  end;

  { function Expression called recursively very often, so placing it
    as local function (not class method) improves performance }

  function Expression(const OpTyp: TTokenKind): Variant;
  var
    Tmp: Variant;
    PrevTTyp: Integer;
  begin
    Result := Unassigned;
    if OpTyp <> ttUnknown then
      NextToken;
    PrevTTyp := TTyp;
    while True do
    begin
      case TTyp of
        ttInteger, ttDouble, ttFalse, ttTrue, ttIdentifier:
          begin
            Result := Token;
            if TTyp = ttIdentifier then
            begin
              FCurrArgs.Clear;
              InternalGetValue(nil, 0, Result);
            end;
            NextToken;
            if TTyp in [ttInteger, ttDouble, ttString,
              ttFalse, ttTrue, ttIdentifier] then
              JvInterpreterError(ieMissingOperator, PosEnd {!!});
            if Prior(TTyp) < Prior(OpTyp) then
              Exit;
          end;
        ttString:
          begin
            Result := '';
            repeat
              Result := Result + Token;
              NextToken;
              if TTyp in [ttInteger, ttDouble, ttFalse, ttTrue, ttIdentifier] then
                JvInterpreterError(ieMissingOperator, PosEnd {!!});
            until TTyp <> ttString;
            if Prior(TTyp) < Prior(OpTyp) then
              Exit;
          end;

        // [peter schraut: added ttShl case on 2005/08/14]
        ttShl:
          if priorShl > Prior(OpTyp) then
            Result := PopExp shl Expression(TTyp)
          else
            Exit;

        // [peter schraut: added ttShr case on 2005/08/14]
        ttShr:
          if priorShr > Prior(OpTyp) then
            Result := PopExp shr Expression(TTyp)
          else
            Exit;

        // [peter schraut: added ttXor case on 2005/08/14]
        ttXor:
          if priorXor > Prior(OpTyp) then
            Result := PopExp xor Expression(TTyp)
          else
            Exit;

        ttMul:
          if priorMul > Prior(OpTyp) then
            Result := PopExp * Expression(TTyp)
          else
            Exit;
        ttPlus:
         { proceed differently depending on type }
          if not (FPrevTTyp in [ttInteger, ttDouble, ttString, ttFalse, ttTrue,
            ttIdentifier, ttRB, ttRS]) then
           { unary plus }
            Result := Expression(ttNot) { highest priority }
          else
          if priorPlus > Prior(OpTyp) then
          begin
            Tmp := PopExp;
            if TVarData(Tmp).VType = varSet then
            begin
              Result := TVarData(Tmp).VInteger or
                TVarData(Expression(TTyp)).VInteger;
              TVarData(Result).VType := varSet;
            end
            else
              Result := Tmp + Expression(TTyp)
          end
          else
            Exit;
        ttMinus:
          { proceed differently depending on type }
          if not (FPrevTTyp in [ttInteger, ttDouble, ttString, ttFalse, ttTrue,
            ttIdentifier, ttRB, ttRS]) then
            { unary minus }
            Result := -Expression(ttNot) { highest priority }
          else
          if priorMinus > Prior(OpTyp) then
          begin
            Tmp := PopExp;
            if TVarData(Tmp).VType = varSet then
            begin
              Result := TVarData(Tmp).VInteger and
                not TVarData(Expression(TTyp)).VInteger;
              TVarData(Result).VType := varSet;
            end
            else
              Result := Tmp - Expression(TTyp)
          end
          else
            Exit;
        ttDiv:
          if priorDiv > Prior(OpTyp) then
            Result := PopExp / Expression(TTyp)
          else
            Exit;
        ttIntDiv:
          if priorIntDiv > Prior(OpTyp) then
            Result := PopExp div Expression(TTyp)
          else
            Exit;
        ttMod:
          if priorMod > Prior(OpTyp) then
            Result := PopExp mod Expression(TTyp)
          else
            Exit;
        ttOr:
          if priorOr > Prior(OpTyp) then
            Result := PopExp or Expression(TTyp)
          else
            Exit;
        ttAnd:
          if priorAnd > Prior(OpTyp) then
            Result := PopExp and Expression(TTyp)
          else
            Exit;
        ttNot:
          { 'Not' has highest priority, so we have no need to check this }
          // if priorNot > Prior(OpTyp) then
          Result := not Expression(TTyp);
          //  else Exit;
        ttEqu:
         { proceed differently depending on type }
          if priorEqu > Prior(OpTyp) then
          begin
            Tmp := PopExp;
            if (TVarData(Tmp).VType = varObject) or (TVarData(Tmp).VType = varClass) or
              (TVarData(Tmp).VType = varSet) or (TVarData(Tmp).VType = varPointer) then
              Result := TVarData(Tmp).VInteger = TVarData(Expression(TTyp)).VInteger
            else
              Result := Tmp = Expression(TTyp)
          end
          else
            Exit;
        ttNotEqu:
          { proceed differently depending on a types }
          if priorNotEqu > Prior(OpTyp) then
          begin
            Tmp := PopExp;
            if (TVarData(Tmp).VType = varObject) or (TVarData(Tmp).VType = varClass) or
              (TVarData(Tmp).VType = varSet) or (TVarData(Tmp).VType = varPointer) then
              Result := TVarData(Tmp).VInteger <>
                TVarData(Expression(TTyp)).VInteger
            else
            if TVarData(Tmp).VType = varUnknown then
              Result := TVarData(Tmp).VUnknown <> TVarData(Expression(TTyp)).VUnknown
            else
              Result := Tmp <> Expression(TTyp)
          end
          else
            Exit;
        ttGreater:
          if priorGreater > Prior(OpTyp) then
            Result := PopExp > Expression(TTyp)
          else
            Exit;
        ttLess:
          if priorLess > Prior(OpTyp) then
            Result := PopExp < Expression(TTyp)
          else
            Exit;
        ttEquLess:
          if priorEquLess > Prior(OpTyp) then
            Result := PopExp <= Expression(TTyp)
          else
            Exit;
        ttEquGreater:
          if priorEquGreater > Prior(OpTyp) then
            Result := PopExp >= Expression(TTyp)
          else
            Exit;
        ttLB:
          begin
            Result := Expression(TTyp);
            if FTTyp <> ttRB then
              ErrorExpected(''')''');
            NextToken;
          end;
        ttRB:
          if (TVarData(Result).VType = varEmpty) and (PrevTTyp <> ttIdentifier) then
            ErrorExpected(LoadStr2(irExpression))
          else
            Exit;
        ttLS:
          begin
            NextToken;
            Result := SetExpression1;
            if FTTyp <> ttRS then
              ErrorExpected(''']''');
            NextToken;
          end;
        ttRS:
          if (TVarData(Result).VType = varEmpty) and (PrevTTyp <> ttIdentifier) then
            ErrorExpected(LoadStr2(irExpression))
          else
            Exit;
      else
        if (TVarData(Result).VType = varEmpty) and (PrevTTyp <> ttIdentifier) then
          ErrorExpected(LoadStr2(irExpression))
        else
          Exit;
      end;
      PushExp(Result);
    end;
  end;

begin
  Result := Null;
  try
    OldExpStackPtr := FExpStackPtr;
    try
      Expression(ttUnknown);
      JvInterpreterVarCopy(Result, PopExp);
    finally
      FExpStackPtr := OldExpStackPtr;
    end;
  except
    on E: EVariantError do
      JvInterpreterError(ieTypeMistmatch, CurPos);
  end;
end;

function TJvInterpreterExpression.Expression2(const ExpType: Word): Variant;
var
  ErrPos: Integer;
  {>>>}
  i64: Int64;
  i32: Integer;
  {<<<}
begin
  ErrPos := PosBeg;
  try
    FAllowAssignment := False;
    Result := Expression1;
  finally
    FAllowAssignment := True;
  end;
  if TVarData(Result).VType <> ExpType then
    case ExpType of
      varInteger: {>>>}begin
        if TVarData(Result).VType in [varSmallint, varShortInt, varByte, varWord, varUInt32, varInt64, varUInt64] then begin
          i64 := Result;
          if (i64 >= Low(Integer)) and (i64 <= High(Integer)) then begin
            i32 := i64;
            Exit(i32);
          end;
        end;
        {<<<}
        JvInterpreterError(ieIntegerRequired, ErrPos);
      {>>>}
      end;
      {<<<}
      varBoolean:
        JvInterpreterError(ieBooleanRequired, ErrPos);
    else
      JvInterpreterError(ieUnknown, ErrPos);
    end;
end;

{ calulate set expressions, such as: [fsBold, fsItalic] }

function TJvInterpreterExpression.SetExpression1: Variant;
var
  V1: Variant;
begin
  Result := 0;
  while True do
  begin
    case TTyp of
      ttIdentifier, ttInteger:
        begin
          if TTyp = ttInteger then
            Result := Result or Integer(Token)
          else
          begin
            FCurrArgs.Clear;
            InternalGetValue(nil, 0, V1);
            if not VarIsOrdinal(V1) then
              JvInterpreterError(ieIntegerRequired, PosBeg);
            Result := Result or 1 shl Integer(V1);
          end;
          NextToken; { skip ',' }
          if TTyp = ttCol then
            NextToken
          else
          if TTyp = ttRS then
            Break
          else
            ErrorExpected(''']''');
        end;
      ttRS:
        Break;
    else
      Break;
    end;
  end;
  TVarData(Result).VType := varSet;
end;

procedure TJvInterpreterExpression.ReadArgs;

  function ReadOpenArray: Variant;
  var
    Values: TValueArray;
    I: Integer;
  begin
    { open array or set constant }
    NextToken;
    Values[0] := Expression1;
    I := 1;
    while TTyp = ttCol do
    begin
      NextToken;
      FCurrArgs.Clear;
      Values[I] := Expression1;
      Inc(I);
    end;
    if TTyp <> ttRS then
      ErrorExpected(''']''');
    Result := VarArrayCreate([0, I - 1], varVariant);
    for I := 0 to I - 1 do
      Result[I] := Values[I];
    NextToken;
  end;

var
  LocalArgs: TJvInterpreterArgs;
  I: Integer;
  SK: TTokenKind;
begin
  LocalArgs := FCurrArgs;
  FCurrArgs := TJvInterpreterArgs.Create;
  FCurrArgs.Indexed := LocalArgs.Indexed;
  try
    I := 0;
    if TTyp = ttLB then
      SK := ttRB
    else
      SK := ttRS;

    NextToken;
    if TTyp = ttIdentifier then
      LocalArgs.FVarNames[I] := Token
    else
      LocalArgs.FVarNames[I] := '';

    FCurrArgs.Clear;
    if TTyp = ttLS then
      LocalArgs.Values[I] := ReadOpenArray
    //added check to recognize C style (), like "NextToken()"
    //RWare: if token ')', skip and exit
    else
    if TTyp = ttRB then
    begin
      NextToken;
      Exit;
    end
    else
      JvInterpreterVarCopy(LocalArgs.Values[I], Expression1);

    while TTyp = ttCol do
    begin
      Inc(I);
      NextToken;
      if TTyp = ttIdentifier then
        LocalArgs.FVarNames[I] := Token
      else
        LocalArgs.FVarNames[I] := '';
      FCurrArgs.Clear;
      if TTyp = ttLS then
        LocalArgs.Values[I] := ReadOpenArray
      else
        JvInterpreterVarCopy(LocalArgs.Values[I], Expression1);
    end;
    if TTyp <> SK then
      if SK = ttRB then
        ErrorExpected(''')''')
      else
        ErrorExpected(''']''');
    NextToken;
    LocalArgs.Count := I + 1;
  finally
    FCurrArgs.Free;
    FCurrArgs := LocalArgs;
  end;
end;

procedure TJvInterpreterExpression.InternalGetValue(Obj: Pointer; ObjTyp: Word;
  var Result: Variant);
var
  Identifier: string;
  V: Variant;
  VType: TVarType;

  procedure UpdateVarParams;
  var
    I, C: Integer;
  begin
    if not FCurrArgs.FHasVars then
      Exit;
    C := FCurrArgs.Count;
    FCurrArgs.Obj := nil;
    FCurrArgs.ObjTyp := 0;
    FCurrArgs.ObjRefHolder := Unassigned;
    FCurrArgs.Count := 0;
    for I := 0 to C - 1 do
      if (FCurrArgs.FVarNames[I] <> '') and ((FCurrArgs.Types[I] and varByRef) <> 0) then
      { if not }SetValue(FCurrArgs.FVarNames[I], FCurrArgs.Values[I], FCurrArgs); { then
          JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, FCurrArgs.VarNames[I])};
    FCurrArgs.FHasVars := False;
  end;

begin
  Identifier := Token;
  NextToken;
  FCurrArgs.Indexed := TTyp = ttLS;
  if TTyp in [ttLB, ttLS] then
    ReadArgs
  else
    FCurrArgs.Count := 0;
  FCurrArgs.Obj := Obj;
  FCurrArgs.ObjTyp := ObjTyp;

  if (TTyp = ttColon) and FAllowAssignment then
  begin
    if ObjTyp = varDispatch then
      FCurrArgs.ObjRefHolder := IDispatch(Obj)
    else
    if ObjTyp = varUnknown then
      FCurrArgs.ObjRefHolder := IUnknown(Obj);

    Back;
    FToken := Identifier; {!!!!!!!!!!!!!!}
    { FCurrArgs.Obj, FCurrArgs.ObjTyp, FCurrArgs.Count needed in caller }
    Exit;
  end;

  { need result if object field or method or assignment }
  FCurrArgs.HasResult := (TTyp in [ttPoint, ttRB, ttCol, ttNot..ttEquLess]) or
    FCurrArgs.Assignment;
  FCurrArgs.ReturnIndexed := False;

  JvInterpreterVarFree(Result);
  if GetValue(Identifier, Result, FCurrArgs) then
  begin
    if TVarData(Result).VType = varRecord then
      if not (FAdapter.SetRecord(Result) or
        (FAdapter <> GlobalJvInterpreterAdapter) and
        GlobalJvInterpreterAdapter.SetRecord(Result)) then
        JvInterpreterErrorN(ieRecordNotDefined, -1, RsEUnknownRecordType);
    { Args.HasVars may be changed in previous call to GetValue }
    if FCurrArgs.FHasVars then
      UpdateVarParams;
    if FCurrArgs.Indexed and not FCurrArgs.ReturnIndexed then
    begin
      JvInterpreterVarCopy(V, Result);
      if not GetElement(V, Result, FCurrArgs) then
        { problem }
        JvInterpreterError(ieArrayRequired, PosBeg);
    end;
  end
  else
    JvInterpreterErrorN(ieUnknownIdentifier, PosBeg {?}, Identifier);

  FCurrArgs.Obj := nil;
  FCurrArgs.ObjTyp := 0;
  FCurrArgs.ObjRefHolder := Unassigned;
  FCurrArgs.Count := 0;
  { FCurrArgs.Obj, FCurrArgs.ObjTyp, FCurrArgs.Count NOT needed in caller }

  if TTyp = ttPoint then { object field or method }
  begin
    NextToken;
    if TTyp <> ttIdentifier then
      ErrorExpected(LoadStr2(irIdentifier));
    VType := TVarData(Result).VType;
    if (VType <> varObject) and (VType <> varClass) and
      (VType <> varRecord) and (VType <> varDispatch) and (VType <> varUnknown) then
    {if not (TVarData(Result).VType in
      [varObject, varClass, varRecord, varDispatch, varUnknown]) then}
      JvInterpreterError(ieROCRequired, PosBeg);

    V := Null;
    InternalGetValue(TVarData(Result).VPointer, TVarData(Result).VType, V);
    JvInterpreterVarCopy(Result, V);

    NextToken;
  end;

  Back;
end;

function TJvInterpreterExpression.GetElement(const Variable: Variant; var Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
var
  II2: Integer;
  VV: TJvInterpreterArrayValues;
  PP: PJvInterpreterArrayRec;
  Bound: Integer;
  AI: array of Integer;
begin
  Result := False;
  if Args.Count <> 0 then
  begin
    if TVarData(Variable).VType = varString then
    begin
      if Args.Count > 1 then
        JvInterpreterError(ieArrayTooManyParams, -1);
      if Length(Variable) = 0 then
        raise ERangeError.CreateRes(@RsERangeCheckError);
      Value := string(Variable)[Integer(Args.Values[0])];
      Result := True;
    end
    else
    if TVarData(Variable).VType = varArray then
    begin
      {Get array value}
      PP := PJvInterpreterArrayRec(NativeInt(JvInterpreterVarAsType(Variable, varInteger)));
      if Args.Count > PP.Dimension then
        JvInterpreterError(ieArrayTooManyParams, -1)
      else
      if Args.Count < PP.Dimension then
        JvInterpreterError(ieArrayNotEnoughParams, -1);
      for II2 := 0 to Args.Count - 1 do
      begin
        Bound := Args.Values[II2];
        if Bound < PP.BeginPos[II2] then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1)
        else
        if Bound > PP.EndPos[II2] then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1);
        VV[II2] := Args.Values[II2];
      end;
      Value := JvInterpreterArrayGetElement(VV, PP);
      Result := True;
    end
    else
    if (TVarData(Variable).VType = varObject) or
      (TVarData(Variable).VType = varClass) or (TVarData(Variable).VType = varUnknown) then
    begin
      Result := FAdapter.GetElement(Self, Variable, Value, Args);
      if not Result and Assigned(FSharedAdapter) then
        Result := FSharedAdapter.GetElement(Self, Variable, Value, Args);
    end
    { for Variant Arrays }
    else
    if VarIsArray(Variable) then
    begin
      if Args.Count > VarArrayDimCount(Variable) then
        JvInterpreterError(ieArrayTooManyParams, -1)
      else
      if Args.Count < VarArrayDimCount(Variable) then
        JvInterpreterError(ieArrayNotEnoughParams, -1);
      AI := nil;
      SetLength(AI, Args.Count);
      for II2 := 0 to Args.Count - 1 do
      begin
        Bound := Args.Values[II2];
        if Bound > VarArrayHighBound(Variable, II2 + 1) then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1);
        if Bound < VarArrayLowBound(Variable, II2 + 1) then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1);
        AI[II2] := Bound;
      end;
      Value := VarArrayGet(Variable, AI);
      Result := True;
    end
    else
      { problem }
      JvInterpreterError(ieArrayRequired, CurPos);
  end;
end;

function TJvInterpreterExpression.SetElement(var Variable: Variant; const Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
var
  II2: Integer;
  VV: TJvInterpreterArrayValues;
  PP: PJvInterpreterArrayRec;
  Bound: Integer;
  AI: array of Integer;
begin
  Result := False;
  if Args.Count <> 0 then
  begin
    if TVarData(Variable).VType = varString then
    begin
      if Args.Count > 1 then
        JvInterpreterError(ieArrayTooManyParams, -1);
      string(TVarData(Variable).vString)[Integer(Args.Values[0])] := string(Value)[1];
      Result := True;
    end
    else
    if TVarData(Variable).VType = varArray then
    begin
      { Get array value }
      PP := PJvInterpreterArrayRec(NativeInt(JvInterpreterVarAsType(Variable, varInteger)));
      if Args.Count > PP.Dimension then
        JvInterpreterError(ieArrayTooManyParams, -1)
      else
      if Args.Count < PP.Dimension then
        JvInterpreterError(ieArrayNotEnoughParams, -1);
      for II2 := 0 to Args.Count - 1 do
      begin
        Bound := Args.Values[II2];
        if Bound < PP.BeginPos[II2] then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1)
        else
        if Bound > PP.EndPos[II2] then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1);
        VV[II2] := Args.Values[II2];
      end;
      JvInterpreterArraySetElement(VV, Value, PP);
      Result := True;
    end
    else
    if (TVarData(Variable).VType = varObject) or
      (TVarData(Variable).VType = varClass) or (TVarData(Variable).VType = varUnknown) then
    begin
      Result := FAdapter.SetElement(Self, Variable, Value, Args);
      if not Result and Assigned(FSharedAdapter) then
        Result := FSharedAdapter.SetElement(Self, Variable, Value, Args);
    end
    { for Variant Array }
    else
    if VarIsArray(Variable) then
    begin
      if Args.Count > VarArrayDimCount(Variable) then
        JvInterpreterError(ieArrayTooManyParams, -1)
      else
      if Args.Count < VarArrayDimCount(Variable) then
        JvInterpreterError(ieArrayNotEnoughParams, -1);
      AI := nil;
      SetLength(AI, Args.Count);
      for II2 := 0 to Args.Count - 1 do
      begin
        Bound := Args.Values[II2];
        if Bound > VarArrayHighBound(Variable, II2 + 1) then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1);
        if Bound < VarArrayLowBound(Variable, II2 + 1) then
          JvInterpreterError(ieArrayIndexOutOfBounds, -1);
        AI[II2] := Bound;
      end;
      VarArrayPut(Variable, Value, AI);
      Result := True;
    end
    else
      { problem }
      JvInterpreterError(ieArrayRequired, CurPos);
  end;
end;

function TJvInterpreterExpression.GetValue(const Identifier: string; var Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
begin
  try
    Result := FAdapter.GetValue(Self, Identifier, Value, Args);
    if not Result and Assigned(FSharedAdapter) then
      Result := FSharedAdapter.GetValue(Self, Identifier, Value, Args);
  except
    on E: Exception do
    begin
      UpdateExceptionPos(E, '');
      raise;
    end;
  end;
  if not Result and Assigned(FOnGetValue) then
    FOnGetValue(Self, Identifier, Value, Args, Result);
end;

function TJvInterpreterExpression.SetValue(const Identifier: string; const Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
begin
  try
    Result := FAdapter.SetValue(Self, Identifier, Value, Args);
    if not Result and Assigned(FSharedAdapter) then
      Result := FSharedAdapter.SetValue(Self, Identifier, Value, Args);
  except
    on E: EJvInterpreterError do
    begin
      E.FErrPos := PosBeg;
      raise;
    end;
  end;
  if not Result and Assigned(FOnSetValue) then
    FOnSetValue(Self, Identifier, Value, Args, Result);
end;

procedure TJvInterpreterExpression.Run;
begin
  Init;
  NextToken;
  FVResult := Expression1;
end;

procedure TJvInterpreterExpression.SetDisableExternalFunctions(const Value: Boolean);
begin
  FDisableExternalFunctions := Value;
  FAdapter.DisableExternalFunctions := Value;
end;

//=== { TJvInterpreterFunction } =============================================

constructor TJvInterpreterFunction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFunctionStack := TList.Create;
  FSS := TStringList.Create;
  FEventList := TList.Create;
end;

destructor TJvInterpreterFunction.Destroy;
begin
  FSS.Free;
  FFunctionStack.Free;
  ClearList(FEventList);
  FEventList.Free;
  inherited Destroy;
end;

procedure TJvInterpreterFunction.Init;
begin
  inherited Init;
  FBreak := False;
  FContinue := False;
  FFunctionStack.Clear;
  FStateStackPtr := -1;
  FCurUnitName := '';
  FCurInstance := nil;
end;

procedure TJvInterpreterFunction.PushState;
begin
  Inc(FStateStackPtr);
  if FStateStackPtr > High(FStateStack) then
    JvInterpreterError(ieInternal, -1);
  FStateStack[FStateStackPtr].Token := FToken;
  FStateStack[FStateStackPtr].TTyp := FTTyp;
  FStateStack[FStateStackPtr].PrevTTyp := FPrevTTyp;
  FStateStack[FStateStackPtr].Backed := FBacked;
  FStateStack[FStateStackPtr].CurPos := CurPos;
  FStateStack[FStateStackPtr].AllowAssignment := FAllowAssignment;
end;

procedure TJvInterpreterFunction.PopState;
begin
  if FStateStackPtr = -1 then
    JvInterpreterError(ieInternal, -1);
  CurPos := FStateStack[FStateStackPtr].CurPos;
  FToken := FStateStack[FStateStackPtr].Token;
  FTTyp := FStateStack[FStateStackPtr].TTyp;
  FPrevTTyp := FStateStack[FStateStackPtr].PrevTTyp;
  FBacked := FStateStack[FStateStackPtr].Backed;
  FAllowAssignment := FStateStack[FStateStackPtr].AllowAssignment;
  Dec(FStateStackPtr);
end;

procedure TJvInterpreterFunction.RemoveState;
begin
  Dec(FStateStackPtr);
end;

function TJvInterpreterFunction.GetLocalVars: TJvInterpreterVarList;
begin
  if FFunctionContext <> nil then
    Result := PFunctionContext(FFunctionContext).LocalVars
  else
    Result := nil;
end;

procedure TJvInterpreterFunction.InFunction(FunctionDesc: TJvInterpreterFunctionDesc);
const
  cResult = 'Result';
var
  FunArgs: TJvInterpreterArgs;
  VarNames: PNameArray;

  procedure EnterFunction; { TJvInterpreterFunction.InFunction local: initialization/entry of function scope }
  var
    FC: PFunctionContext;
    I: Integer;
    V: Variant;
  begin
    New(PFunctionContext(FC));
    FillChar(FC^, SizeOf(FC^), 0);
    New(VarNames);
    PFunctionContext(FC).PrevFunContext := FFunctionContext;
    FFunctionContext := FC;
    PFunctionContext(FFunctionContext).LocalVars := TJvInterpreterVarList.Create;
    FFunctionStack.Add(FFunctionContext);
    JvInterpreterVarFree(FVResult);
    if FunctionDesc <> nil then
    begin
      FCurrArgs.FHasVars := False;
      FCurrArgs.Types := FunctionDesc.FParamTypes;
      for I := 0 to FCurrArgs.Count - 1 do
      begin
        if (FunctionDesc.FParamTypes[I] and varByRef) <> 0 then
          JvInterpreterVarCopy(V, FCurrArgs.Values[I])
        else
          JvInterpreterVarAssignment(V, FCurrArgs.Values[I]);

        PFunctionContext(FFunctionContext).LocalVars.AddVar('', FunctionDesc.FParamNames[I], '',
          FunctionDesc.FParamTypes[I], V,
          TJvInterpreterSimpleDataType.Create(FunctionDesc.FParamTypes[I]));
        VarNames^ := FunctionDesc.FParamNames;
        FCurrArgs.FHasVars := FCurrArgs.FHasVars or ((FunctionDesc.FParamTypes[I] and varByRef) <> 0);
      end;
      if FunctionDesc.ResTyp > 0 then
      begin
        FunctionDesc.ResDataType.Init(V);
        PFunctionContext(FFunctionContext).LocalVars.AddVar('', cResult, '',
          FunctionDesc.ResTyp, V, FunctionDesc.ResDataType);
      end
    end
    else
      PFunctionContext(FFunctionContext).LocalVars.AddVar('', cResult, '', varVariant,
        Null, TJvInterpreterSimpleDataType.Create(varVariant));
    FunArgs := FCurrArgs;
    FCurrArgs := TJvInterpreterArgs.Create;
  end;

  procedure LeaveFunction(Ok: Boolean); { TJvInterpreterFunction.InFunction local: finalization of function scope }
  var
    FC: PFunctionContext;
    C: Integer;

    procedure UpdateVarParams; { TJvInterpreterFunction.InFunction.LeaveFunction local. How bizarre. }
    var
      I, C: Integer;
    begin
      if not FCurrArgs.FHasVars then
        Exit;
      C := FCurrArgs.Count;
      FCurrArgs.Obj := nil;
      FCurrArgs.ObjTyp := 0;
      FCurrArgs.ObjRefHolder := Unassigned;
      FCurrArgs.Count := 0;

      for I := 0 to C - 1 do
        if (VarNames[I] <> '') and
          ((FCurrArgs.Types[I] and varByRef) <> 0) then
          GetValue(VarNames[I], FCurrArgs.Values[I], FCurrArgs);
    end;

  begin
    FCurrArgs.Free;
    FCurrArgs := FunArgs;
    if Ok then
    begin
      C := FCurrArgs.Count;
      UpdateVarParams;
      FCurrArgs.Count := 0;
      if (FunctionDesc = nil) or (FunctionDesc.ResTyp > 0) then
      begin
        { Return the 'result' value from the local function context to the
          FVResult: Variant property of the component }

        //        PFunctionContext(FFunctionContext).LocalVars.GetValue('Result', FVResult, FCurrArgs);
        //LEAKY:  TVarData(PFunctionContext(FFunctionContext).LocalVars.FindVar('', 'Result').Value).VType := varEmpty;
        //LEAKY:  TVarData(PFunctionContext(FFunctionContext).LocalVars.FindVar('', 'Result').Value).VPointer := nil;

        //VARLEAKFIX begin - Feb 2004 - Warren Postma. Fix suggested by ivan_ra att mail dott ru
        JvInterpreterVarCopy(FVResult, LocalVars.FindVar('', cResult).Value);
        //VARLEAKFIX end.
      end;

      FCurrArgs.Count := C;
    end;
    FC := PFunctionContext(FFunctionContext).PrevFunContext;
    LocalVars.Free;
    Dispose(PFunctionContext(FFunctionContext));
    Dispose(VarNames);
    FFunctionStack.Delete(FFunctionStack.Count - 1);
    FFunctionContext := FC;
  end;

  procedure CheckNotSupportedFunctionParameters;
  var
    I: Integer;
  begin
    for I := 0 to FCurrArgs.Count - 1 do
      if (TVarData(FCurrArgs.Values[I]).VType = varArray)
      or (TVarData(FCurrArgs.Values[I]).VType = varRecord) then
        NotImplemented(RsEInterpreter402);
  end;

begin
  CheckNotSupportedFunctionParameters;
  { allocate stack }
  EnterFunction;
  try
    FExit := False;
    while True do
    begin
      case TTyp of
        ttBegin:
          begin
            InterpretBegin;
            if (TTyp <> ttSemicolon) and not FExit then
              ErrorExpected(''';''');
            Break;
          end;
        ttVar:
          InterpretVar(PFunctionContext(FFunctionContext).LocalVars.AddVar);
        ttConst:
          InterpretConst(PFunctionContext(FFunctionContext).LocalVars.AddVar);
      else
        ErrorExpected('''' + kwBEGIN + '''');
      end;
      NextToken;
    end;
    LeaveFunction(True);
    FExit := False;
  except
    on E: Exception do
    begin
     { if (E is EJvInterpreterError) and (Fun <> nil) and
        ((E as EJvInterpreterError).ErrUnitName = '') then }
      if FunctionDesc <> nil then
        UpdateExceptionPos(E, FunctionDesc.UnitName)
      else
        UpdateExceptionPos(E, '');
      LeaveFunction(False);
      FExit := False;
      raise;
    end;
  end;
end;

function TJvInterpreterFunction.GetValue(const Identifier: string; var Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
begin
  Result := False;
  { check in local variables }
  try
    if FFunctionContext <> nil then
      Result := PFunctionContext(FFunctionContext).LocalVars.GetValue(Identifier, Value, Args);
  except
    on E: Exception do
    begin
      if Assigned(PFunctionContext(FFunctionContext).Fun) then
        UpdateExceptionPos(E, PFunctionContext(FFunctionContext).Fun.UnitName)
      else
        UpdateExceptionPos(E, '');
      raise;
    end;
  end;
  if not Result then
    Result := inherited GetValue(Identifier, Value, Args);
end;

function TJvInterpreterFunction.SetValue(const Identifier: string; const Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
begin
  Result := False;
  { check in local variables }
  try
    if FFunctionContext <> nil then
      Result := PFunctionContext(FFunctionContext).LocalVars.SetValue(Identifier, Value, Args);
  except
    on E: Exception do
    begin
      if Assigned(PFunctionContext(FFunctionContext).Fun) then
        UpdateExceptionPos(E, PFunctionContext(FFunctionContext).Fun.UnitName)
      else
        UpdateExceptionPos(E, '');
      raise;
    end;
  end;
  if not Result then
    Result := inherited SetValue(Identifier, Value, Args);
end;

procedure TJvInterpreterFunction.DoOnStatement;
begin
end;

{ exit: current position set to next token }

procedure TJvInterpreterFunction.InterpretStatement;
begin
  DoOnStatement;
  case TTyp of
    ttIdentifier:
      { assignment or function call }
      begin
        InterpretIdentifier;
        if not (TTyp in [ttSemicolon, ttEnd, ttElse, ttUntil, ttFinally, ttExcept]) then
          ErrorExpected(''';''');
       // Back;
      end;
    ttSemicolon:
      ; // Back;
    ttEnd:
      ; // Back;
    ttBegin:
      InterpretBegin;
    ttIf:
      InterpretIf;
    ttElse:
      Exit;
    ttWhile:
      InterpretWhile;
    ttRepeat:
      InterpretRepeat;
    ttFor:
      InterpretFor;
    ttBreak:
      FBreak := True;
    ttContinue:
      FContinue := True;
    ttTry:
      InterpretTry;
    ttRaise:
      InterpretRaise;
    ttExit:
      FExit := True;
    ttCase:
      InterpretCase;
  else
    ErrorExpected(''';''');
  end;
end;

{ exit: current position set to next token }
{ very simple version, many syntax errors are not found }

procedure TJvInterpreterFunction.SkipStatement;
begin
  case TTyp of
    ttEmpty:
      ErrorExpected('''' + kwEND + '''');
    ttIdentifier:
      SkipIdentifier;
    ttSemicolon:
      NextToken;
    ttEnd:
      NextToken;
    ttIf:
      begin
        FindToken(ttThen);
        NextToken;
        SkipStatement;
        if TTyp = ttElse then
        begin
          NextToken;
          SkipStatement;
        end;
        Exit;
      end;
    ttElse:
      Exit;
    ttWhile, ttFor:
      begin
        FindToken(ttDo);
        NextToken;
        SkipStatement;
        Exit;
      end;
    ttRepeat:
      begin
        SkipToUntil;
        SkipIdentifier;
        Exit;
      end;
    ttBreak, ttContinue:
      NextToken;
    ttBegin:
      begin
        SkipToEnd;
        Exit;
      end;
    ttTry:
      begin
        SkipToEnd;
        Exit;
      end;
    ttFunction, ttProcedure:
      ErrorExpected('''' + kwEND + '''');
    ttRaise:
      begin
        NextToken;
        SkipIdentifier;
      end;
    ttExit:
      NextToken;
    ttCase:
      begin
        SkipToEnd;
        Exit;
      end;
  end;
end;

{ out: current position set to token after end }

procedure TJvInterpreterFunction.SkipToEnd;
begin
  while True do
  begin
    NextToken;
    if TTyp = ttEnd then
    begin
      NextToken;
      Break;
    end
    else
    if TTyp in [ttBegin, ttTry, ttCase] then
      SkipToEnd
    else
    if TTyp = ttEmpty then
      ErrorExpected('''' + kwEND + '''')
    else
    if TTyp = ttDoubleQuote then
      NextToken
    else
      SkipStatement;
    if TTyp = ttEnd then
    begin
      NextToken;
      Break;
    end;
  end;
end;

{ out: current position set to token after end }

procedure TJvInterpreterFunction.SkipToUntil;
begin
  while True do
  begin
    NextToken;
    if TTyp = ttUntil then
    begin
      NextToken;
      Break;
    end
    else
    if TTyp = ttEmpty then
      ErrorExpected('''' + kwUNTIL + '''')
    else
      SkipStatement;
    if TTyp = ttUntil then
    begin
      NextToken;
      Break;
    end;
  end;
end;

{exit: current position set to next token after assignment or function call }

procedure TJvInterpreterFunction.SkipIdentifier;
begin
  while True do
    case TTyp of
      ttEmpty:
        ErrorExpected('''' + kwEND + '''');

      ttIdentifier..ttBoolean, ttLB, ttRB, ttCol, ttPoint, ttLS, ttRS,
      ttNot..ttXor, // [peter schraut: replaced ttEquLess with ttXor on 2005/08/14]
      ttDoubleQuote, ttTrue, ttFalse:
        NextToken;

      ttSemicolon, ttEnd, ttElse, ttUntil, ttFinally, ttExcept, ttDo, ttOf:
        Break;
      ttColon:
        { 'case' or assignment }
        begin
          NextToken;
          if TTyp <> ttEqu then
          begin
            Back;
            Break;
          end;
        end;
    else
      ErrorExpected(LoadStr2(irExpression));
    end;
end;

procedure TJvInterpreterFunction.FindToken(ATTyp: TTokenKind);
begin
  while not (TTyp in [ATTyp, ttEmpty]) do
    NextToken;
  if TTyp = ttEmpty then
    ErrorExpected('''' + kwEND + '''');
end;

function TJvInterpreterFunction.NewEvent(const UnitName: string; const FunctionName,
  EventType: string; Instance: TObject; const APropName: string): TSimpleEvent;
begin
  Result := FAdapter.NewEvent(UnitName, FunctionName, EventType, Self, Instance, APropName);
  if not Assigned(Result) then
    Result := GlobalJvInterpreterAdapter.NewEvent(UnitName, FunctionName, EventType, Self, Instance, APropName);
  if not Assigned(Result) then
    JvInterpreterErrorN(ieEventNotRegistered, -1, EventType);
end;

function TJvInterpreterFunction.FindEvent(const UnitName: string;
  Instance: TObject; const PropName: string): TJvInterpreterEvent;
var
  I: Integer;
  Event, Event1: TJvInterpreterEvent;
  Method: TMethod;
begin
  Result := nil;
  Method := GetPropMethod(Instance, PropName);
  Event1 := TJvInterpreterEvent(Method.Data);
  for I := 0 to FEventList.Count - 1 do
  begin
    Event := TJvInterpreterEvent(FEventList[I]);
    if (Event1 = Event) or
      (Cmp(Event.FUnitName, UnitName) and
      (Event.FInstance = Instance) and
      Cmp(Event.FPropName, PropName)) then
    begin
      Result := Event;
      Exit;
    end;
  end;

end;

procedure TJvInterpreterFunction.InternalSetValue(const Identifier: string);
var
  FunctionDesc: TJvInterpreterFunctionDesc;
  PropInf: PPropInfo;
  FunctionName: string;
  PopSt: Boolean;
  MyArgs: TJvInterpreterArgs;
  Variable: Variant;
  Method: TMethod;
  T: TObject;
  Event: TJvInterpreterEvent;
begin
  { may be event assignment }
  if (FCurrArgs.Obj <> nil) and (FCurrArgs.ObjTyp = varObject) then
  begin
    FunctionDesc := FAdapter.FindFunDesc(FCurUnitName, Token);
    if (FunctionDesc <> nil) or ((FunctionDesc = nil) and Cmp(Token, kwNIL)) then
    begin
      PushState;
      PopSt := True;
      try
        NextToken;
        if not (TTyp in [ttFirstExpression..ttLastExpression] - [ttSemicolon]) then
        begin
          FunctionName := Token;
          PropInf := GetPropInfo(FCurrArgs.Obj.ClassInfo, Identifier);
          if Assigned(PropInf) and (PropInf.PropType^.Kind = tkMethod) then
          begin
            { method assignment }
            if not Cmp(Token, kwNIL) then
            begin
              Event := FindEvent(FCurUnitName, FCurrArgs.Obj, {$IFDEF SUPPORTS_UNICODE}UTF8ToString{$ENDIF SUPPORTS_UNICODE}(PropInf^.Name));
              if Event <> nil then
              begin
                FEventList.Remove(Event);
                Event.Free;
              end;
              Method := TMethod(NewEvent(FCurUnitName, FunctionName,
                {$IFDEF SUPPORTS_UNICODE}UTF8ToString{$ENDIF SUPPORTS_UNICODE}(PropInf^.PropType^.Name),
                FCurrArgs.Obj {FCurInstance},
                {$IFDEF SUPPORTS_UNICODE}UTF8ToString{$ENDIF SUPPORTS_UNICODE}(PropInf^.Name)));
              SetMethodProp(FCurrArgs.Obj, PropInf, Method);
              FEventList.Add(Method.Data);
            end
            else
            begin //Fixed Assign nil to Method property bugs - dejoy-2004-3-13
              Method := GetMethodProp(FCurrArgs.Obj, PropInf);
              if Method.Data <> nil then
              begin
                FEventList.Remove(Method.Data);
                T := Method.Data;
                if T is TJvInterpreterEvent then
                  T.Free;
              end;

              Method.Code := nil;
              Method.Data := nil;
              SetMethodProp(FCurrArgs.Obj, PropInf, Method);
            end;

            PopSt := False;
            Exit;
          end
          else
          if FAdapter.IsEvent(FCurrArgs.Obj, Identifier) then { check only local adapter }
          begin
            if not SetValue(Identifier, FunctionName, FCurrArgs) then
              JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, Identifier);
            PopSt := False;
            Exit;
          end;
        end;
      finally
        if PopSt then
          PopState
        else
          RemoveState;
      end;
      //Exit;
    end;
  end;
  { normal (not method) assignmnent }
  JvInterpreterVarFree(FVResult);
  { push args }
  MyArgs := FCurrArgs;
  FCurrArgs := TJvInterpreterArgs.Create;
  try
    FCurrArgs.Assignment := True;
    JvInterpreterVarCopy(FVResult, Expression1);
  finally
    { pop args }
    FCurrArgs.Free;
    FCurrArgs := MyArgs;
  end;
  if FCurrArgs.Indexed then
  begin
    MyArgs := TJvInterpreterArgs.Create;
    MyArgs.Obj := FCurrArgs.Obj;
    MyArgs.ObjTyp := FCurrArgs.ObjTyp;
    try
      if GetValue(Identifier, Variable, MyArgs) then
      begin
        if not SetElement(Variable, FVResult, FCurrArgs) then
          { problem }
          JvInterpreterError(ieArrayRequired, PosBeg);
        if (TVarData(Variable).VType = varString) and
          not SetValue(Identifier, Variable, MyArgs) then
          JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, Identifier);
        if VarIsArray(Variable) and
          not SetValue(Identifier, Variable, MyArgs) then
          JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, Identifier);
      end
      else
      if not SetValue(Identifier, FVResult, FCurrArgs) then
        JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, Identifier);
    finally
      MyArgs.Free;
    end;
  end
  else
  if not SetValue(Identifier, FVResult, FCurrArgs) then
    JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, Identifier);
end;

procedure TJvInterpreterFunction.InterpretIdentifier;
var
  Identifier: string;
begin
  Identifier := Token;
  FCurrArgs.Clear;
  NextToken;
  if TTyp <> ttColon then
  begin
    Back;
    FCurrArgs.Assignment := False;
    InternalGetValue(nil, 0, FVResult);
    Identifier := Token; { Back! }
    NextToken;
  end;
  if TTyp = ttColon then { assignment }
  begin
    NextToken;
    if TTyp <> ttEqu then
      ErrorExpected('''=''');
    NextToken;
    InternalSetValue(Identifier);
  end;
end;

{exit: current position set to next token after "end"}

procedure TJvInterpreterFunction.InterpretBegin;
begin
  NextToken;
  while True do
  begin
    case TTyp of
      ttEnd:
        begin
          NextToken;
          Exit;
        end;
      ttElse, ttDo:
        ErrorExpected(LoadStr2(irStatement));
      ttSemicolon:
        begin
          DoOnStatement;
          NextToken;
        end;
      ttIdentifier, ttBegin, ttIf, ttWhile, ttFor, ttRepeat,
        ttBreak, ttContinue, ttTry, ttRaise, ttExit, ttCase:
        InterpretStatement;
    else
      ErrorExpected('''' + kwEND + '''');
    end;
    if FBreak or FContinue or FExit then
      Exit;
  end;
end;

{ exit: current position set to next token after if block }

procedure TJvInterpreterFunction.InterpretIf;
var
  Condition: Variant;
begin
  NextToken;
  Condition := Expression2(varBoolean);
  if TTyp <> ttThen then
    ErrorExpected('''' + kwTHEN + '''');
  NextToken;
  if TVarData(Condition).VBoolean then
  begin
    InterpretStatement;
    // NextToken; {!!!????}
    if TTyp = ttElse then
    begin
      NextToken;
      SkipStatement;
     // Back; {!!!????}
    end;
  end
  else
  begin
    SkipStatement;
    if TTyp = ttElse then
    begin
      NextToken;
      InterpretStatement;
    end
   { else
    if TTyp = ttSemicolon then
    begin
      NextToken;
      if TTyp = ttElse then
        JvInterpreterError(ieNotAllowedBeforeElse, PosBeg)
    end; }
  end;
end;

{ exit: current position set to next token after loop }

procedure TJvInterpreterFunction.InterpretWhile;
var
  WhileCurPos: Integer;
  WhilePos: Integer;
  Condition: Variant;
begin
  PushState;
  try
    WhilePos := PosEnd;
    WhileCurPos := CurPos;
    while True do
    begin
      NextToken;
      Condition := Expression1;
      if TVarData(Condition).VType <> varBoolean then
        JvInterpreterError(ieBooleanRequired, WhilePos);
      if TTyp <> ttDo then
        ErrorExpected('''' + kwDO + '''');
      NextToken;
      if TVarData(Condition).VBoolean then
      begin
        FContinue := False;
        FBreak := False;
        InterpretStatement;
        if FBreak or FExit then
          Break;
      end
      else
        Break;
      CurPos := WhileCurPos;
    end;
  finally
    PopState;
  end;
  SkipStatement;
  FContinue := False;
  FBreak := False;
end;

{ exit: current position set to next token after loop }

procedure TJvInterpreterFunction.InterpretRepeat;
var
  RepeatCurPos: Integer;
  Condition: Variant;
begin
  RepeatCurPos := CurPos;
  while True do
  begin
    NextToken;
    case TTyp of
      ttElse, ttDo:
        ErrorExpected(LoadStr2(irStatement));
      ttSemicolon:
        DoOnStatement;
      ttIdentifier, ttBegin, ttIf, ttWhile, ttFor, ttRepeat,
        ttBreak, ttContinue, ttTry, ttRaise, ttExit, ttCase:
        begin
          FContinue := False;
          FBreak := False;
          InterpretStatement;
          if FBreak or FExit then
            Break;
        end;
      ttUntil:
        begin
          NextToken;
          Condition := Expression1;
          if TVarData(Condition).VType <> varBoolean then
            JvInterpreterError(ieBooleanRequired, CurPos);
          if TVarData(Condition).VBoolean then
            Break
          else
            CurPos := RepeatCurPos;
        end;
    else
      ErrorExpected('''' + kwUNTIL + '''');
    end;
  end;
  if FBreak or FExit then
  begin
    SkipToUntil;
    SkipIdentifier;
  end;
  FContinue := False;
  FBreak := False;
end;

{ exit: current position set to next token after loop }

procedure TJvInterpreterFunction.InterpretFor;
var
  I: Integer;
  DoCurPos: Integer;
  iBeg, iEnd: Integer;
  LoopVariable: string;
  ForwardDirection: Boolean;
begin
  NextToken;
  if TTyp <> ttIdentifier then
    ErrorExpected(LoadStr2(irIdentifier));
  // CheckLocalIdentifier;
  LoopVariable := Token;
  NextToken;
  if TTyp <> ttColon then
    ErrorExpected(''':''');
  NextToken;
  if TTyp <> ttEqu then
    ErrorExpected('''=''');
  NextToken;
  iBeg := Expression2(varInteger);
  if (TTyp <> ttTo) and (TTyp <> ttDownTo) then
    ErrorExpected('''' + kwTO + RsEXOrX + kwDOWNTO + '''');
  ForwardDirection := TTyp = ttTo;

  NextToken;
  iEnd := Expression2(varInteger);
  if TTyp <> ttDo then
    ErrorExpected('''' + kwDO + '''');
  DoCurPos := CurPos;
  NextToken;

  if ForwardDirection then
  begin
    for I := iBeg to iEnd do
    begin
      FCurrArgs.Clear;
      if not SetValue(LoopVariable, I, FCurrArgs) then
        JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, LoopVariable);
      FContinue := False;
      FBreak := False;
      InterpretStatement;
      if FBreak or FExit then
      begin
        CurPos := DoCurPos;
        NextToken;
        Break;
      end;
      CurPos := DoCurPos;
      NextToken;
    end;
  end
  else
  begin
    for I := iBeg downto iEnd do
    begin
      FCurrArgs.Clear;
      if not SetValue(LoopVariable, I, FCurrArgs) then
        JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, LoopVariable);
      FContinue := False;
      FBreak := False;
      InterpretStatement;
      if FBreak or FExit then
      begin
        CurPos := DoCurPos;
        NextToken;
        Break;
      end;
      CurPos := DoCurPos;
      NextToken;
    end;
  end;

  SkipStatement;
  FContinue := False;
  FBreak := False;
end;

{ exit: current position set to next token after case }

procedure TJvInterpreterFunction.InterpretCase;
var
  Selector, Expression, I: Integer;
  ExpressionArray: array of array [0..1] of Integer;

  function InCase(CaseSel: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to Length(ExpressionArray) - 1 do
      if (CaseSel >= ExpressionArray[I][0]) and (CaseSel <= ExpressionArray[I][1]) then
      begin
        Result := True;
        Exit;
      end;
  end;

begin
  NextToken;
  Selector := Expression2(varInteger);
  if TTyp <> ttOf then
    ErrorExpected('''' + kwOF + '''');
  while True do
  begin
    NextToken;
    case TTyp of
      ttIdentifier, ttInteger:
        begin
          ExpressionArray := nil;
          SetLength(ExpressionArray, 1);
          I := 0;
          while True do
          begin
            Expression := Expression2(varInteger);
            ExpressionArray[Length(ExpressionArray) - 1][I] := Expression;
            if TTyp = ttDoublePoint then
              I := 1
            else
            if TTyp = ttCol then
            begin
              if I = 0 then
                ExpressionArray[Length(ExpressionArray) - 1][1] := Expression
              else
                I := 0;
              SetLength(ExpressionArray, Length(ExpressionArray) + 1);
            end
            else
            begin
              if I = 0 then
                ExpressionArray[Length(ExpressionArray) - 1][1] := Expression;
              Break;
            end;
            NextToken;
          end;
          if TTyp <> ttColon then
            ErrorExpected('''' + ':' + '''');
          NextToken;
          if InCase(Selector) then
          begin
            ExpressionArray := nil;
            InterpretStatement;
            SkipToEnd;
            Break;
          end
          else
            SkipStatement;
        end;
      ttElse:
        begin
          NextToken;
          InterpretStatement;
          SkipToEnd;
          Break;
        end;
      ttEnd:
        begin
          NextToken;
          Break;
        end;
    else
      ErrorExpected('''' + kwEND + '''');
    end;
  end;
end;

procedure TJvInterpreterFunction.InterpretVar(AddVarFunc: TJvInterpreterAddVarFunc);
var
  I: Integer;
  Value: Variant;
  TypName: string;
//  Typ: Word;
  DT: IJvInterpreterDataType;
  {----olej----}
  {Temporary for array type}
//  ArrayType: Integer;
//  Dimension: Integer;
  {----olej----}
begin
  repeat
    FSS.Clear;
    repeat
      NextToken;
      if TTyp <> ttIdentifier then
        ErrorExpected(LoadStr2(irIdentifier));
      FSS.Add(Token);
      NextToken;
    until TTyp <> ttCol;
    if TTyp <> ttColon then
      ErrorExpected(''':''');
    NextToken;
    TypName := Token;
    DT := ParseDataType;
    for I := 0 to FSS.Count - 1 do
    begin
      DT.Init(Value);
      AddVarFunc(FCurUnitName, FSS[I], TypName, DT.GetTyp, Value, DT);
    end;
    FSS.Clear;
    NextToken;
    if TTyp <> ttSemicolon then
      ErrorExpected(''';''');
    NextToken;
    Back;
  until TTyp <> ttIdentifier;
end;

procedure TJvInterpreterFunction.InterpretConst(AddVarFunc: TJvInterpreterAddVarFunc);
var
  Identifier: string;
  Value: Variant;
begin
  repeat
    NextToken;
    if TTyp <> ttIdentifier then
      ErrorExpected(LoadStr2(irIdentifier));
    Identifier := Token;
    NextToken;
    if TTyp <> ttEqu then
      ErrorExpected('=');
    NextToken;
    Value := Expression1;

    AddVarFunc(FCurUnitName, Identifier, '', varEmpty, Value,
      TJvInterpreterSimpleDataType.Create(VarType(Value)));
    if TTyp <> ttSemicolon then
      ErrorExpected(''';''');
    NextToken;
    Back;
  until TTyp <> ttIdentifier;
end;

procedure TJvInterpreterFunction.InterpretTry;
var
  ReRaiseException: Boolean;

  procedure FindFinallyExcept;
  begin
    while True do
    begin
      case TTyp of
        ttEmpty:
          ErrorExpected('''' + kwEND + '''');
        ttSemicolon:
          ;
        ttFinally, ttExcept:
          Exit;
      else
        SkipStatement;
      end;
      NextToken;
    end;
  end;

  procedure InterpretExcept(E: Exception);
  var
    ExceptionClassName, ExceptionVarName: string;
    ExceptionClass: TClass;
    V: Variant;

    function On1: Boolean;
    begin
      NextToken;
      if TTyp <> ttIdentifier then
        ErrorExpected(LoadStr2(irIdentifier));
      ExceptionClassName := Token;
      NextToken;
      if TTyp = ttColon then
      begin
        NextToken;
        if TTyp <> ttIdentifier then
          ErrorExpected(LoadStr2(irIdentifier));
        ExceptionVarName := ExceptionClassName;
        ExceptionClassName := Token;
        NextToken;
      end;
      FCurrArgs.Clear;
      if not GetValue(ExceptionClassName, V, FCurrArgs) then
        JvInterpreterErrorN(ieUnknownIdentifier, PosBeg {?}, ExceptionClassName);
      if VarType(V) <> varClass then
        JvInterpreterError(ieClassRequired, PosBeg {?});
      ExceptionClass := V2C(V);
      if TTyp <> ttDo then
        ErrorExpected('''' + kwDO + '''');
      Result := E is ExceptionClass;
      if Result then
       { do this 'on' section }
      begin
        NextToken;
        PFunctionContext(FFunctionContext).LocalVars.AddVar('', ExceptionVarName,
          ExceptionClassName, varObject, O2V(E),
          TJvInterpreterSimpleDataType.Create(varObject));
        try
          InterpretStatement;
        finally
          PFunctionContext(FFunctionContext).LocalVars.DeleteVar('', ExceptionVarName);
        end;
        SkipToEnd;
      end
      else
      begin
        NextToken;
        SkipStatement;
       { if TTyp = ttSemicolon then
          NextToken; }
      end;
    end;

  begin
    NextToken;
    if TTyp = ttOn then
    begin
      if On1 then
      begin
        ReRaiseException := False;
        Exit;
      end;
      while True do
      begin
        NextToken;
        case TTyp of
          ttEmpty:
            ErrorExpected('''' + kwEND + '''');
          ttOn:
            if On1 then
            begin
              ReRaiseException := False;
              Exit;
            end;
          ttEnd:
            begin
              ReRaiseException := True;
              Exit;
            end;
          ttElse:
            begin
              NextToken;
              InterpretStatement;
              NextToken;
              if TTyp = ttSemicolon then
                NextToken;
              if TTyp <> ttEnd then
                ErrorExpected('''' + kwEND + '''');
              Exit;
            end;
        else
          ErrorExpected('''' + kwEND + '''');
        end;
      end;
    end
    else
    begin
      Back;
      InterpretBegin;
    end;
  end;

  procedure DoFinallyExcept(E: Exception);
  var
    OldExit: Boolean;
  begin
    OldExit := FExit;
    try
      FExit := False;
      case TTyp of
        ttFinally:
          { do statements up to 'end' }
          begin
            InterpretBegin;
            if E <> nil then
              ReRaiseException := True;
          end;
        ttExcept:
          begin
            if E = nil then
              { skip except section }
              SkipToEnd
            else
            { except section }
            begin
              try
                InterpretExcept(E);
                FLastError.Clear;
              except
                on E1: EJvInterpreterError do
                begin
                  if E1.ErrCode = ieRaise then
                    ReRaiseException := True;
                end
                else
                  raise;
              end;
            end;
          end;
      end;
    finally
      FExit := FExit or OldExit;
    end;
  end;

begin
  NextToken;
  while True do
  begin
    case TTyp of
      ttFinally:
        begin
          DoFinallyExcept(nil);
          Exit;
        end;
      ttExcept:
        begin
          DoFinallyExcept(nil);
          Exit;
        end;
      ttSemicolon:
        begin
          DoOnStatement;
          NextToken;
        end;
      ttIdentifier, ttBegin, ttIf, ttWhile, ttFor, ttRepeat,
        ttBreak, ttContinue, ttTry, ttRaise, ttExit, ttCase:
        begin
          try
            InterpretStatement;
            if FBreak or FContinue or FExit then
            begin
              FindFinallyExcept;
              DoFinallyExcept(nil);
              Exit;
            end;
          except
            on E: Exception do
            begin
              FindFinallyExcept;

              ReRaiseException := False;
              DoFinallyExcept(E);

              if ReRaiseException then
                raise
              else
                Exit;
            end;
          end;
        end;
    else
      ErrorExpected('''' + kwFINALLY + '''');
    end;
  end;
end;

procedure TJvInterpreterFunction.InterpretRaise;
var
  V: Variant;
begin
  NextToken;
  case TTyp of
    ttEmpty, ttSemicolon, ttEnd, ttBegin, ttElse, ttFinally, ttExcept:
      { re-raising exception }
      raise EJvInterpreterError.Create(ieRaise, PosBeg, '', '');
    ttIdentifier:
      begin
        InternalGetValue(nil, 0, V);
        if VarType(V) <> varObject then
          JvInterpreterError(ieClassRequired, PosBeg {?});
        UpdateExceptionPos(Exception(V2O(V)), '');
        raise V2O(V);
      end;
  else
    JvInterpreterError(ieClassRequired, PosBeg {?});
  end;
end;

procedure TJvInterpreterFunction.Run;
begin
  Init;
  NextToken;
  InFunction(nil);
end;

function TJvInterpreterFunction.GetFunStackCount: Integer;
begin
  Result := FFunctionStack.Count;
end;

function TJvInterpreterFunction.ParseDataType: IJvInterpreterDataType;
var
  TypName: string;
  Typ: Word;
  ArrayBegin, ArrayEnd: TJvInterpreterArrayValues;
  TempBegin, TempEnd: Integer;
  ArrayType: Integer;
  Dimension: Integer;
  Minus1, Minus2: Boolean;
  //
  JvInterpreterRecord: TJvInterpreterRecord;
  ArrayDT: IJvInterpreterDataType;
begin
  //NextToken;
  TypName := Token;
  Dimension := 0;
  if TTyp = ttIdentifier then
  begin
    Typ := TypeName2VarTyp(TypName);
    JvInterpreterRecord := TJvInterpreterRecord(FAdapter.GetRec(TypName));
    if JvInterpreterRecord = nil then
      JvInterpreterRecord := TJvInterpreterRecord(GlobalJvInterpreterAdapter.GetRec(TypName));
    if JvInterpreterRecord <> nil then
      Result := TJvInterpreterRecordDataType.Create(JvInterpreterRecord)
    else
      Result := TJvInterpreterSimpleDataType.Create(Typ);
  end
  else
  if TTyp = ttArray then
  begin
    { Get Array variables params }
    { This code is not very clear }
    // Typ := varArray;
    NextToken;
    if (TTyp <> ttLS) and (TTyp <> ttOf) then
      ErrorExpected('''[' + RsEXOrX + kwOF + '''');
    { Parse Array Range }
    if TTyp = ttLS then
    begin
      Dimension := 0;
      repeat
        NextToken;
        Minus1 := False;
        if (Trim(FTokenStr) = '-') then
        begin
          Minus1 := True;
          NextToken;
        end;
        TempBegin := StrToInt(FTokenStr);
        try
          ArrayBegin[Dimension] := TempBegin;
          if Minus1 then
            ArrayBegin[Dimension] := ArrayBegin[Dimension] * (-1);
        except
          ErrorExpected(LoadStr2(irIntegerValue));
        end;

        NextToken;
        if TTyp <> ttDoublePoint then
          ErrorExpected('''..''');

        NextToken;
        Minus2 := False;
        if (Trim(FTokenStr) = '-') then
        begin
          Minus2 := True;
          NextToken;
        end;
        TempEnd := StrToInt(FTokenStr);
        try
          ArrayEnd[Dimension] := TempEnd;
        except
          if Minus2 then
            ArrayEnd[Dimension] := ArrayEnd[Dimension] * (-1);
          ErrorExpected(LoadStr2(irIntegerValue));
        end;

        if (Dimension < 0) or (Dimension > cJvInterpreterMaxArgs) then
          JvInterpreterError(ieArrayBadDimension, CurPos);
        if not (ArrayBegin[Dimension] <= ArrayEnd[Dimension]) then
          JvInterpreterError(ieArrayBadRange, CurPos);
      {End Array Range}
        NextToken;
        Inc(Dimension);
      until TTyp <> ttCol; { , }

      if TTyp <> ttRS then
        ErrorExpected(''']''');
      NextToken;
      if TTyp <> ttOf then
        ErrorExpected('''' + kwOF + '''');
    end
    else
    if TTyp = ttOf then
    begin
      Dimension := 1;
      ArrayBegin[0] := 0;
      ArrayEnd[0] := -1;
    end;
    NextToken;
    ArrayType := TypeName2VarTyp(Token);
    // recursion for arrays
    ArrayDT := ParseDataType;

    Result := TJvInterpreterArrayDataType.Create(ArrayBegin, ArrayEnd, Dimension, ArrayType, ArrayDT);
    { end: var A: array [1..200] of Integer, parsing }
  end
  else
    ErrorExpected(LoadStr2(irIdentifier));
end;

//=== { TJvInterpreterUnit } =================================================

constructor TJvInterpreterUnit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClearUnits := True;
  FEventHandlerList := TList.Create;
end;

destructor TJvInterpreterUnit.Destroy;
begin
  ClearList(FEventHandlerList);
  FEventHandlerList.Free;
  inherited Destroy;
end;

procedure TJvInterpreterUnit.Init;
begin
  inherited Init;
  if FClearUnits then
  begin
    FAdapter.ClearSource;
    FUnitSection := usUnknown;
    ClearList(FEventHandlerList);
  end;
end;

procedure TJvInterpreterUnit.ReadFunctionHeader(FunctionDesc: TJvInterpreterFunctionDesc);
var
  TypName: string;
  Fun: Boolean;

  procedure ReadParams;
  var
    VarParam, VarConst: Boolean;
    ParamType: string;
    iBeg: Integer;
  begin
    while True do
    begin
      VarParam := False;
      VarConst := False;
      NextToken;
      FunctionDesc.FParamNames[FunctionDesc.ParamCount] := Token;
      if TTyp = ttRB then
        Break;
      if TTyp = ttVar then
      begin
        VarParam := True;
        NextToken;
      end;
      if TTyp = ttConst then
      begin
        VarConst := True;
//        NextToken;
      end;
      iBeg := FunctionDesc.ParamCount;
      while True do
      begin
        case TTyp of
          ttIdentifier:
            FunctionDesc.FParamNames[FunctionDesc.ParamCount] := Token;
          ttSemicolon: Break;
          ttRB: Exit;
          ttColon:
            begin
              NextToken;
              if TTyp <> ttIdentifier then
                ErrorExpected(LoadStr2(irIdentifier));
              ParamType := Token;
              while True do
              begin
                if TTyp = ttRB then
                  Back;
                if TTyp in [ttRB, ttSemicolon] then
                  Break;
                NextToken;
              end;
              FunctionDesc.FParamTypeNames[FunctionDesc.FParamCount] := ParamType;  // for ParamTypeNames
              Inc(FunctionDesc.FParamCount);
              while iBeg < FunctionDesc.FParamCount do
              begin
                FunctionDesc.FParamTypeNames[iBeg] := ParamType;   // for ParamTypeNames
                FunctionDesc.FParamTypes[iBeg] := TypeName2VarTyp(ParamType);
                if VarParam then
                  FunctionDesc.FParamTypes[iBeg] := FunctionDesc.FParamTypes[iBeg] or
                    varByRef;
                if VarConst then
                  FunctionDesc.FParamTypes[iBeg] := FunctionDesc.FParamTypes[iBeg] or
                    varByConst;

                Inc(iBeg);
              end;
              Break;
            end;
          ttCol:
            Inc(FunctionDesc.FParamCount);
        end;
        NextToken;
      end;
    end;
  end;

begin
  Fun := TTyp = ttFunction;
  NextToken;
  if TTyp <> ttIdentifier then
    ErrorExpected(LoadStr2(irIdentifier));
  FunctionDesc.FIdentifier := Token;
  NextToken;
  if TTyp = ttPoint then
  begin
    FunctionDesc.FClassIdentifier := FunctionDesc.FIdentifier;
    NextToken;
    if TTyp <> ttIdentifier then
      ErrorExpected(LoadStr2(irIdentifier));
    FunctionDesc.FIdentifier := Token;
    NextToken;
  end;
  FunctionDesc.FResTyp := varEmpty;
  FunctionDesc.FParamCount := 0;
  if TTyp = ttLB then
  begin
    // NextToken;
    ReadParams;
    NextToken;
  end;
  if Fun then
    if (TTyp = ttColon) then
    begin
      NextToken;
      if TTyp <> ttIdentifier then
        ErrorExpected(LoadStr2(irIdentifier));
      TypName := Token;
      FunctionDesc.FResDataType := ParseDataType;
      FunctionDesc.FResTyp := FunctionDesc.FResDataType.GetTyp;
      FunctionDesc.FResTypName := TypName;

      if FunctionDesc.FResTyp = 0 then
        FunctionDesc.FResTyp := varVariant;
      NextToken;
    end
    else
      ErrorExpected(''':''');
  if TTyp <> ttSemicolon then
    ErrorExpected(''';''');
end;

procedure TJvInterpreterUnit.InterpretFunction;
var
  FunctionDesc: TJvInterpreterFunctionDesc;
  FunctionName: string;
  FunctionIndex: Integer;
  DllName: string;
  LastTTyp: TTokenKind;
begin
  FunctionDesc := TJvInterpreterFunctionDesc.Create;
  try
    ReadFunctionHeader(FunctionDesc);
    FunctionDesc.FPosBeg := CurPos;
    LastTTyp := TTyp;
    NextToken;
    if TTyp = ttExternal then
    begin
      NextToken;
      if TTyp = ttString then
        DllName := Token
      else
      if TTyp = ttIdentifier then
      begin
        FCurrArgs.Clear;
        if not GetValue(Token, FVResult, FCurrArgs) then
          JvInterpreterErrorN(ieUnknownIdentifier, PosBeg, Token);
        DllName := VResult;
      end
      else
        ErrorExpected(LoadStr2(irStringConstant)); {DEBUG!!!}
      NextToken;
      if TTyp <> ttIdentifier then
        ErrorExpected('''' + drNAME + RsEXOrX + drINDEX + '''');
      FunctionIndex := -1;
      FunctionName := '';
      if Cmp(Token, drNAME) then
      begin
        NextToken;
        if TTyp = ttString then
          FunctionName := Token
        else
          ErrorExpected(LoadStr2(irStringConstant)); {DEBUG!!!}
      end
      else
      if Cmp(Token, drINDEX) then
      begin
        NextToken;
        if TTyp = ttInteger then
          FunctionIndex := Token
        else
          ErrorExpected(LoadStr2(irIntegerConstant)); {DEBUG!!!}
      end
      else
        ErrorExpected('''' + drNAME + RsEXOrX + drINDEX + '''');
      with FunctionDesc do
        FAdapter.AddExtFun(FCurUnitName {??!!}, FIdentifier, noInstance, DllName,
          FunctionName, FunctionIndex, FParamCount, FParamTypes, FResTyp);
      NextToken;
    end
    else
    if FUnitSection = usInterface then
    begin
      CurPos := FunctionDesc.FPosBeg;
      FTTyp := LastTTyp;
    end
    else
    begin
      FindToken(ttBegin);
      SkipToEnd;
      with FunctionDesc do
        FAdapter.AddSrcFun(FCurUnitName {??!!}, FIdentifier, FClassIdentifier, FPosBeg, CurPos,
          FParamCount, FParamTypes, FParamTypeNames, FParamNames, FResTyp, FResTypName, FResDataType,
            nil);
    end;
  finally
    FunctionDesc.Free;
  end;
end;

procedure TJvInterpreterUnit.ReadUnit(const UnitName: string);
var
  OldUnitName: string;
  OldSource: string;
  S: string;
begin
  if FAdapter.UnitExists(UnitName) then
    Exit;
  FAdapter.AddSrcUnit(FCurUnitName, '', '');
  OldUnitName := FCurUnitName;
  OldSource := Source;
  PushState;
  try
    try
      if not GetUnitSource(UnitName, S) then
        JvInterpreterErrorN(ieUnitNotFound, PosBeg, UnitName);
      FCurUnitName := UnitName;
      Source := S;
      NextToken;
      if TTyp <> ttUnit then
        ErrorExpected('''' + kwUNIT + '''');
      InterpretUnit;
    except
      on E: Exception do
      begin
        UpdateExceptionPos(E, FCurUnitName);
        raise;
      end;
    end
  finally
    FCurUnitName := OldUnitName;
    Source := OldSource;
    PopState;
  end;
end;

procedure TJvInterpreterUnit.InterpretUses(var UsesList: string);
begin
  NextToken;
  if not (TTyp in [ttIdentifier, ttString]) then
    ErrorExpected(LoadStr2(irIdentifier));
  UsesList := Token;
  ReadUnit(Token);
  while True do
  begin
    NextToken;
    if TTyp = ttIn then
    begin
      { ignore }
      NextToken;
      NextToken;
    end;
    if TTyp = ttSemicolon then
      Exit;
    if TTyp <> ttCol then
      ErrorExpected(''',''');
    NextToken;
    if not (TTyp in [ttIdentifier, ttString]) then
      ErrorExpected(LoadStr2(irIdentifier));
    UsesList := UsesList + ',';
    ReadUnit(Token);
  end;
end;

procedure TJvInterpreterUnit.InterpretUnit;
var
  UsesList: string;
begin
  NextToken;
  if TTyp <> ttIdentifier then
    ErrorExpected(LoadStr2(irIdentifier));
  FCurUnitName := Token;
  NextToken;
  if TTyp <> ttSemicolon then
    ErrorExpected(''';''');
  UsesList := '';
  NextToken;
  while True do
  begin
    case TTyp of
      ttEmpty:
        ErrorExpected('''' + kwEND + '''');
      ttFunction, ttProcedure:
        begin
          InterpretFunction;
          if TTyp <> ttSemicolon then
            ErrorExpected(''';''');
        end;
      ttEnd:
        Break;
      ttUses:
        InterpretUses(UsesList);
      ttVar:
        InterpretVar(FAdapter.AddSrcVar);
      ttConst:
        InterpretConst(FAdapter.AddSrcVar);
      ttInterface:
        FUnitSection := usInterface;
      ttImplementation:
        FUnitSection := usImplementation;
      ttType:
        InterpretType;
    else
      ErrorExpected(LoadStr2(irDeclaration));
    end;
    NextToken;
  end;
  if TTyp <> ttEnd then
    ErrorExpected('''' + kwEND + '''');
  NextToken;
  if TTyp <> ttPoint then
    ErrorExpected('''.''');
  FAdapter.AddSrcUnit(FCurUnitName, Source, UsesList);
end;

procedure TJvInterpreterUnit.InterpretType;
var
  Identifier: string;
begin
  NextToken;
  if TTyp <> ttIdentifier then
    ErrorExpected(LoadStr2(irIdentifier));
  Identifier := Token;
  NextToken;
  if TTyp <> ttEqu then
    ErrorExpected('''=''');
  NextToken;
  case TTyp of
    ttClass:
      InterpretClass(Identifier);
    ttRecord:
      InterpretRecord(Identifier);
  else
    { only class declaration for form is supported }
    ErrorExpected(LoadStr2(irClass));
  end;
end;

procedure TJvInterpreterUnit.InterpretClass(const Identifier: string);
var
  JvInterpreterSrcClass: TJvInterpreterIdentifier;
  FunDesc: TJvInterpreterFunctionDesc;  // Class Fields support
begin
  NextToken;
  if TTyp <> ttLB then
    ErrorExpected('''(''');
  NextToken;
  if TTyp <> ttIdentifier then
    ErrorExpected(LoadStr2(irIdentifier));
  NextToken;
  if TTyp <> ttRB then
    ErrorExpected(''')''');

  JvInterpreterSrcClass := TJvInterpreterClass.Create;
  try
    JvInterpreterSrcClass.UnitName := FCurUnitName;
    JvInterpreterSrcClass.Identifier := Identifier;
    NextToken;
    if TTyp = ttIdentifier then
    begin // First fields can follow class declaration
      Back;
      InterpretVar(TJvInterpreterClass(JvInterpreterSrcClass).ClassFields.AddVar);
      NextToken;
    end;
    while True do
    begin            // try to interpret other fields
      case TTyp of { }             // property declaration not supported!!
        ttEmpty:
          ErrorExpected('''' + kwEND + '''');
        ttFunction, ttProcedure:   // from InterpetFunction
          begin
            FunDesc := TJvInterpreterFunctionDesc.Create;
            try                    // empty reading
              ReadFunctionHeader(FunDesc);
            finally
              FunDesc.Free;
            end;
          end;
        ttEnd:
          Break;
        ttPrivate,ttProtected,ttPublic,ttPublished:
          begin                    // Add more fields
            NextToken;
            Back;
            if TTyp = ttIdentifier then
              InterpretVar(TJvInterpreterClass(JvInterpreterSrcClass).ClassFields.AddVar);
          end;
        else
          ErrorExpected(LoadStr2(irDeclaration));
      end;
      NextToken;
    end;
    NextToken;
    if TTyp <> ttSemicolon then
      ErrorExpected(''';''');

    FAdapter.AddSrcClass(JvInterpreterSrcClass);
  except
    JvInterpreterSrcClass.Free;
    raise;
  end;
end;

procedure TJvInterpreterUnit.InterpretRecord(const Identifier: string);
var
//  JvInterpreterSrcRecord: TJvInterpreterIdentifier;
//  Fields: array of TJvInterpreterRecField;
//  TempField: TJvInterpreterRecField;
//  TempCount: Integer;
//  TempTyp: Word;
  JvInterpreterRecord: TJvInterpreterRecord;
begin
  JvInterpreterRecord := TJvInterpreterRecord.Create;
  JvInterpreterRecord.RecordSize := 0;
  JvInterpreterRecord.Identifier := Identifier;
  JvInterpreterRecord.FieldCount := 0;
  InterpretVar(JvInterpreterRecord.AddField);
  NextToken;
  if TTyp <> ttEnd then
    ErrorExpected('''' + kwEND + '''');
  NextToken;
  if TTyp <> ttSemicolon then
    ErrorExpected(''';''');
  // конец разбора

  FAdapter.FRecordList.Add(JvInterpreterRecord);
end;

procedure TJvInterpreterUnit.Run;
var
  FunctionDesc: TJvInterpreterFunctionDesc;
begin
  Init;
  NextToken;
  case TTyp of
    ttVar, ttBegin:
      InFunction(nil);
    ttFunction, ttProcedure:
      InterpretFunction;
    ttUnit:
      begin
        try
          InterpretUnit;
        except
          on E: Exception do
          begin
            UpdateExceptionPos(E, FCurUnitName);
            raise;
          end;
        end;
        FCompiled := True;
        { execute main function }
        FunctionDesc := FAdapter.FindFunDesc(FCurUnitName, 'main');
        if FunctionDesc = nil then
          JvInterpreterError(ieMainUndefined, -1);
        CurPos := FunctionDesc.PosBeg;
        NextToken;
        InFunction(FunctionDesc);
      end;
  else
    FVResult := Expression1;
  end;
  FCompiled := True;
end;

procedure TJvInterpreterUnit.Compile;
begin
  Init;
  try
    NextToken;
    if TTyp <> ttUnit then
      ErrorExpected('''' + kwUNIT + '''');
    InterpretUnit;
  except
    on E: Exception do
    begin
      UpdateExceptionPos(E, FCurUnitName);
      raise;
    end;
  end;
  FCompiled := True;
end;

procedure TJvInterpreterUnit.SourceChanged;
begin
  inherited SourceChanged;
end;

type
  TJvInterpreterFormAccessProtected = class(TJvInterpreterForm);

function TJvInterpreterUnit.GetValue(const Identifier: string; var Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
var
  FunctionDesc: TJvInterpreterFunctionDesc;
  OldArgs: TJvInterpreterArgs;
  OldInstance: TObject; // class method support
begin
  Result := inherited GetValue(Identifier, Value, Args);
  if Result then
    Exit;
  FunctionDesc := nil;

  if Args.Obj = nil then
    FunctionDesc := FAdapter.FindFunDesc(FCurUnitName, Identifier)
  else
  if Args.ObjTyp = varObject then
  begin
    if Args.Obj is TJvInterpreterSrcUnit then
      FunctionDesc := FAdapter.FindFunDesc((Args.Obj as TJvInterpreterSrcUnit).Identifier,
        Identifier)
    else
    if (Args.Obj is TJvInterpreterForm) then
      with TJvInterpreterFormAccessProtected(Args.Obj) do
        FunctionDesc := FAdapter.FindFunDesc(UnitName, Identifier, ClassIdentifier);
  end;

  Result := FunctionDesc <> nil;
  if Result then
  begin
    FAdapter.CheckArgs(Args, FunctionDesc.FParamCount, FunctionDesc.FParamTypes); {not tested !}
    OldArgs := FCurrArgs;
    OldInstance := FCurInstance;
    if (Args.Obj is TJvInterpreterForm) then
    begin
      FCurInstance:=Args.Obj;                      // class method support
    end;                                           //
    try
      FCurrArgs := Args;
      ExecFunction(FunctionDesc);
    finally
      FCurrArgs := OldArgs;
      if Args.Obj is TJvInterpreterForm then
        FCurInstance := OldInstance;              // class method support
    end;
    Value := FVResult;
  end;
end;

function TJvInterpreterUnit.SetValue(const Identifier: string; const Value: Variant;
  var Args: TJvInterpreterArgs): Boolean;
begin
  Result := inherited SetValue(Identifier, Value, Args);
end;

function TJvInterpreterUnit.GetUnitSource(const UnitName: string; var Source: string): Boolean;
begin
  Result := False;
  if Assigned(FOnGetUnitSource) then
    FOnGetUnitSource(UnitName, Source, Result);
end;

procedure TJvInterpreterUnit.DeclareExternalFunction(const Declaration: string);
var
  OldSource: string;
  OldPos: Integer;
begin
  Source := Declaration;
  OldSource := Source;
  OldPos := FParser.Pos;
  try
    NextToken;
    if not (TTyp in [ttFunction, ttProcedure]) then
      ErrorExpected('''' + kwFUNCTION + RsEXOrX + kwPROCEDURE + '''');
    InterpretFunction;
  finally
    Source := OldSource;
    FParser.Pos := OldPos;
  end;
end;

procedure TJvInterpreterUnit.ExecFunction(Fun: TJvInterpreterFunctionDesc);
var
  OldUnitName: string;
  S: string;
begin
  PushState;
  FAllowAssignment := True;
  OldUnitName := FCurUnitName;
  try
    if not Cmp(FCurUnitName, Fun.UnitName) then
    begin
      FCurUnitName := Fun.UnitName;
      FAdapter.CurUnitChanged(FCurUnitName, S);
      Source := S;
    end;
    CurPos := Fun.PosBeg;
    NextToken;
    try
      InFunction(Fun);
    except
      on E: Exception do
      begin
        UpdateExceptionPos(E, FCurUnitName);
        raise;
      end;
    end;
  finally
    if not Cmp(FCurUnitName, OldUnitName) then
    begin
      FCurUnitName := OldUnitName;
      FAdapter.CurUnitChanged(FCurUnitName, S);
      Source := S;
    end;
    PopState;
  end;
end;

function TJvInterpreterUnit.CallFunction(const FunctionName: string; Args: TJvInterpreterArgs;
  Params: array of Variant): Variant;
begin
  Result := CallFunctionEx(nil, '', FunctionName, Args, Params);
end;

function TJvInterpreterUnit.CallFunctionEx(Instance: TObject; const UnitName: string;
  const FunctionName: string; Args: TJvInterpreterArgs; Params: array of Variant): Variant;
var
  FunctionDesc: TJvInterpreterFunctionDesc;
  I: Integer;
  OldArgs: TJvInterpreterArgs;
  OldInstance: TObject;
begin
  if not Compiled then
    Compile;
  OldInstance := FCurInstance;
  try
    FCurInstance := Instance;
    FunctionDesc := FAdapter.FindFunDesc(UnitName, FunctionName);
    if FunctionDesc <> nil then
    begin
      OldArgs := FCurrArgs;
      if Args = nil then
      begin
        FCurrArgs.Clear;
        for I := Low(Params) to High(Params) do
        begin
          FCurrArgs.Values[FCurrArgs.Count] := Params[I];
          Inc(FCurrArgs.Count);
        end;
      end
      else
        FCurrArgs := Args;
      try
        { simple init }
        FBreak := False;
        FContinue := False;
        FLastError.Clear;

        ExecFunction(FunctionDesc);

        Result := FVResult;
      finally
        FCurrArgs := OldArgs;
      end;
    end
    else
      JvInterpreterErrorN(ieUnknownIdentifier, -1, FunctionName);
  finally
    FCurInstance := OldInstance;
  end;
end;

function TJvInterpreterUnit.FunctionExists(const UnitName: string;
  const FunctionName: string): Boolean;
begin
  Result := FAdapter.FindFunDesc(UnitName, FunctionName) <> nil;
end;

//=== { TJvInterpreterProgramStrings } =======================================

type
  TJvInterpreterProgramStrings = class(TStringList)
  private
    FJvInterpreterProgram: TJvInterpreterProgram;
  protected
    procedure Changed; override;
  end;

procedure TJvInterpreterProgramStrings.Changed;
begin
  FJvInterpreterProgram.Source := Text;
end;

//=== { TJvInterpreterProgram } ==============================================

constructor TJvInterpreterProgram.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPas := TJvInterpreterProgramStrings.Create;
  (FPas as TJvInterpreterProgramStrings).FJvInterpreterProgram := Self;
end;

destructor TJvInterpreterProgram.Destroy;
begin
  FPas.Free;
  inherited Destroy;
end;

function TJvInterpreterProgram.GetPas: TStrings;
begin
  Result := FPas;
end;

procedure TJvInterpreterProgram.SetPas(Value: TStrings);
begin
  FPas.Assign(Value);
end;

procedure TJvInterpreterProgram.DoOnStatement;
begin
  if Assigned(FOnStatement) then
    FOnStatement(Self);
end;

procedure TJvInterpreterProgram.Run;
var
  UsesList: string;
begin
  // (rom) Does this always work? After "program" a line end or tab is allowed.
  if AnsiStrLIComp(PChar(FParser.Source), 'program ', Length('program ')) <> 0 then
  begin
    inherited Run;
    Exit;
  end;
  Init;
  NextToken;
  while True do
  begin
    case TTyp of
      ttEmpty:
        ErrorExpected('''' + kwEND + '''');
      ttFunction, ttProcedure:
        begin
          InterpretFunction;
          if TTyp <> ttSemicolon then
            ErrorExpected(''';''');
        end;
      ttEnd:
        Break;
      ttUses:
        InterpretUses(UsesList);
      ttVar:
        InterpretVar(FAdapter.AddSrcVar);
      ttConst:
        InterpretConst(FAdapter.AddSrcVar);
      ttInterface:
        FUnitSection := usInterface;
      ttImplementation:
        FUnitSection := usImplementation;
      ttType:
        InterpretType;
      ttProgram:
        begin
          NextToken;
          FCurUnitName := Token;
          NextToken;
          if TTyp <> ttSemicolon then
            ErrorExpected(''';''');
        end;
      ttBegin:
        Break;
    else
      ErrorExpected('''' + kwEND + '''');
    end;
    NextToken;
  end;
  FCompiled := True;
  FAdapter.AddSrcUnit(FCurUnitName, Source, UsesList);
 { execute program function }
{  FunctionDesc := FAdapter.FindFunDesc(FCurUnitName, 'program');
  if FunctionDesc <> nil then
  begin
    CurPos := FunctionDesc.PosBeg;
    NextToken;
    InFunction(FunctionDesc);
  end; }
  try
    InterpretBegin;
    if (TTyp <> ttPoint) then
      ErrorExpected('''.''');
  except
    on E: Exception do
    begin
      UpdateExceptionPos(E, FCurUnitName);
      raise;
    end;
  end;
end;

function TJvInterpreterFunction.GetDebugPointerToGlobalVars: TJvInterpreterVarList;
begin
  Result := Adapter.FSrcVarList;
end;

function TJvInterpreterFunction.GetDebugPointerToFunStack: Pointer;
begin
  Result := FFunctionStack;
end;

//=== { TJvInterpreterMethodList } ===========================================

function SortMethodIdentifier(Item1, Item2: Pointer): Integer;
begin
  { function AnsiStrIComp about 30% faster than AnsiCompareText }
  { Result := AnsiCompareText(TJvInterpreterIdentifier(Item1).Identifier,
    TJvInterpreterIdentifier(Item2).Identifier); }
  Result := AnsiStrIComp(PChar(TJvInterpreterIdentifier(Item1).Identifier),
    PChar(TJvInterpreterIdentifier(Item2).Identifier));

  if (Result = 0) and (Item1 <> Item2) then
  begin
    if TJvInterpreterMethod(Item1).FClassType.InheritsFrom(TJvInterpreterMethod(Item2).FClassType) then
      Result := -1
    else if TJvInterpreterMethod(Item1).FClassType = TJvInterpreterMethod(Item2).FClassType then
      Result := 0
    else
      Result := 1;
  end;
end;

procedure TJvInterpreterMethodList.Sort(Compare: TListSortCompare);
begin
  inherited Sort(SortMethodIdentifier);
end;

//=== { TJvInterpreterRecord } ===============================================

procedure TJvInterpreterRecord.AddField(const UnitName, Identifier, Typ: string;
  VTyp: Word; const Value: Variant; DataType: IJvInterpreterDataType);
begin
  Fields[FieldCount].Identifier := Identifier;
  Fields[FieldCount].Typ := varEmpty;
  Fields[FieldCount].Offset := RecordSize;
  Fields[FieldCount].DataType := DataType;

  Inc(RecordSize, SizeOf(TVarData));
  Inc(FieldCount);
end;

procedure TJvInterpreterRecord.NewRecord(var Value: Variant);
const
  EmptyStr: string = '';
var
  I: Integer;
  Rec: PAnsiChar;
  // Res: Boolean;
  RecHolder: TJvInterpreterRecHolder;
begin
  if Assigned(CreateFunc) then
    CreateFunc(Pointer(Rec))
  else
  begin
    GetMem(Rec, RecordSize);
    for I := 0 to FieldCount - 1 do
    begin
      if Fields[I].Typ = varString then
        PString(PString(Rec + Fields[I].Offset)^) := @EmptyStr
      else
      if Fields[I].Typ = varEmpty then
      begin
        PVarData(Rec + Fields[I].Offset)^.VType := varNull;
        if Fields[I].DataType <> nil then
          Fields[I].DataType.Init(Variant(PVarData(Rec + Fields[I].Offset)^));
      end;
    end;
  end;
  JvInterpreterVarCopy(Value, R2V(Identifier, Rec));
  RecHolder := TJvInterpreterRecHolder(TVarData(Value).VPointer);
  RecHolder.JvInterpreterRecord := Self;
end;

//=== { TJvInterpreterRecordDataType } =======================================

constructor TJvInterpreterRecordDataType.Create(ARecordDesc: TJvInterpreterRecord);
begin
  inherited Create;
  FRecordDesc := ARecordDesc;
end;

function TJvInterpreterRecordDataType.GetTyp: Word;
begin
  Result := varEmpty;
end;

procedure TJvInterpreterRecordDataType.Init(var V: Variant);
begin
  FRecordDesc.NewRecord(V);
end;

//=== { TJvInterpreterArrayDataType } ========================================

constructor TJvInterpreterArrayDataType.Create(AArrayBegin, AArrayEnd: TJvInterpreterArrayValues;
  ADimension: Integer; AArrayType: Integer; ADT: IJvInterpreterDataType);
begin
  inherited Create;
  FArrayBegin := AArrayBegin;
  FArrayEnd := AArrayEnd;
  FDimension := ADimension;
  FArrayType := AArrayType;
  FDT := ADT;
end;

function TJvInterpreterArrayDataType.GetTyp: Word;
begin
  Result := varArray;
end;

procedure TJvInterpreterArrayDataType.Init(var V: Variant);
begin
  V := NativeInt(JvInterpreterArrayInit(FDimension, FArrayBegin, FArrayEnd, FArrayType, FDT));
  TVarData(V).VType := varArray;
end;

//=== { TJvInterpreterSimpleDataType } =======================================

constructor TJvInterpreterSimpleDataType.Create(ATyp: TVarType);
begin
  inherited Create;
  FTyp := ATyp;
end;

function TJvInterpreterSimpleDataType.GetTyp: Word;
begin
  Result := FTyp;
end;

procedure TJvInterpreterSimpleDataType.Init(var V: Variant);
begin
  V := Null;
  TVarData(V).VType := varEmpty;
  if (FTyp <> 0) and (FTyp <> varObject) then //dejoy fixed: can't define TObject up d6
    V := Var2Type(V, FTyp);
end;

//=== { TJvInterpreterSrcUnit } ==============================================

function TJvInterpreterSrcUnit.UsesList: TNameArray;
begin
  Result := FUsesList;
end;

//=== { TJvInterpreterClass } ================================================

constructor TJvInterpreterClass.Create;
begin
  FClassFields:=TJvInterpreterVarList.Create;
end;

destructor TJvInterpreterClass.Destroy;
begin
  FClassFields.Free;
  inherited Destroy;
end;

{$IFDEF JvInterpreter_OLEAUTO}
var
  OleInitialized: Boolean;
{$ENDIF JvInterpreter_OLEAUTO}

procedure Finit;
begin
  FreeAndNil(FieldGlobalJvInterpreterAdapter);
  FreeAndNil(GlobalVariantObjectInstance);
  FreeAndNil(GlobalVariantRecordInstance);
  FreeAndNil(GlobalVariantClassInstance);
  FreeAndNil(GlobalVariantPointerInstance);
  FreeAndNil(GlobalVariantSetInstance);
  FreeAndNil(GlobalVariantArrayInstance);
  {$IFDEF JvInterpreter_OLEAUTO}
  if OleInitialized then
    OleUnInitialize;
  {$ENDIF JvInterpreter_OLEAUTO}
  {$IFDEF JvInterpreter_DEBUG}
  if ObjCount <> 0 then
    Windows.MessageBox(0, PChar('Memory leak in JvInterpreter.pas'#10 +
      'ObjCount = ' + IntToStr(ObjCount)),
      'JvInterpreter Internal Error', MB_ICONERROR);
  {$ENDIF JvInterpreter_DEBUG}
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  {$IFDEF JvInterpreter_OLEAUTO}
  OleInitialized := OleInitialize(nil) = S_OK;
  {$ENDIF JvInterpreter_OLEAUTO}

finalization
  Finit;
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.
