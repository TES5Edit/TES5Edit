unit MSAAIntf;

// This unit defines the IAccessible interface and a few helper functions and constants for accessibility support.
// It has been modified by hand because the library import did not import all necessary information.
// This file is used in The VirtualTrees for Delphi 2005 and earlier.
// BDS 2006 and higher include the unit oleacc.pas that already has all necessary defines.

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// Type Lib: C:\WINDOWS\System32\oleacc.dll (1)
// LIBID: {1EA4DBF0-3C3B-11CF-810C-00AA00389B71}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v1.0 Borland_Studio_ToolsAPI, (Borland.Studio.ToolsAPI.tlb)
// Errors:
//   Hint: Parameter 'var' of IAccPropServices.SetPropValue changed to 'var_'
//   Hint: Parameter 'var' of IAccPropServices.SetHwndProp changed to 'var_'
//   Hint: Parameter 'var' of IAccPropServices.SetHmenuProp changed to 'var_'
// ************************************************************************ //
{$I Compilers.inc}

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$ifdef COMPILER_7_UP}
  {$WARN SYMBOL_PLATFORM OFF}
{$endif COMPILE_7_UP}
{$WRITEABLECONST ON}
{$ifdef COMPILER_7_UP}
  {$VARPROPSETTER ON}
{$endif COMPILE_7_UP}
interface

uses Windows, ActiveX;

(*$HPPEMIT '#include <oleacc.h>' *)
{$HPPEMIT 'typedef DelphiInterface<IAccessible> _di_IAccessible;'}

(*
cpp_quote("typedef LRESULT (STDAPICALLTYPE *LPFNLRESULTFROMOBJECT)(REFIID riid, WPARAM wParam, LPUNKNOWN punk);")
cpp_quote("typedef HRESULT (STDAPICALLTYPE *LPFNOBJECTFROMLRESULT)(LRESULT lResult, REFIID riid, WPARAM wParam, void** ppvObject);")
cpp_quote("typedef HRESULT (STDAPICALLTYPE *LPFNACCESSIBLEOBJECTFROMWINDOW)(HWND hwnd, DWORD dwId, REFIID riid, void** ppvObject);")
cpp_quote("typedef HRESULT (STDAPICALLTYPE *LPFNACCESSIBLEOBJECTFROMPOINT)(POINT ptScreen, IAccessible** ppacc, VARIANT* pvarChild);")
cpp_quote("typedef HRESULT (STDAPICALLTYPE *LPFNCREATESTDACCESSIBLEOBJECT)(HWND hwnd, LONG idObject, REFIID riid, void** ppvObject);")
cpp_quote("typedef HRESULT (STDAPICALLTYPE *LPFNACCESSIBLECHILDREN)(IAccessible* paccContainer, LONG iChildStart,LONG cChildren,VARIANT* rgvarChildren,LONG* pcObtained);")

//----------------------------------------------------------------------------
// GUIDs are defined here so that clients and servers that #include "oleacc.h"
// can get them from there by also doing #include <initguid.h> in one and only
// one of their source modules. The way the oleacc.dll actually gets the GUIDs
// is slightly different though - it has copies of the line below in the file
// guids.c, with the prefix __declspec(dllexport), so that the GUIDs are also
// exported from OLEACC.DLL. Then clients and servers have the option of linking
// to oleacc.dll to get them.
//
// So if you add any more GUIDs, make sure to add them here AND in guids.c
//----------------------------------------------------------------------------
*)
var
  {$EXTERNALSYM LresultFromObject}
  LresultFromObject: function (const riid: TGUID; wParam: WPARAM; punk: IUnknown): LRESULT; stdcall;
  {$EXTERNALSYM ObjectFromLresult}
  ObjectFromLresult: function (lResult: LRESULT; const riid: TGUID; wParam: WPARAM; out ppvObject): LRESULT; stdcall;
(*  function WindowFromAccessibleObject(IAccessible*, HWND* phwnd);*)
  {$EXTERNALSYM AccessibleObjectFromWindow}
  AccessibleObjectFromWindow: function (hwnd: THandle; dwId: DWORD; const riid: TGUID; out ppvObject): HRESULT; stdcall;
(*  function AccessibleObjectFromEvent(HWND hwnd, DWORD dwId, DWORD dwChildId, IAccessible** ppacc, VARIANT* pvarChild);")
  AccessibleObjectFromPoint: function (POINT ptScreen, IAccessible ** ppacc, VARIANT* pvarChild);")
  AccessibleChildren : function (IAccessible* paccContainer, LONG iChildStart,LONG cChildren, VARIANT* rgvarChildren,LONG* pcObtained);")
(*
cpp_quote("")
cpp_quote("STDAPI_(UINT)   GetRoleTextA(DWORD lRole, LPSTR lpszRole, UINT cchRoleMax);")
cpp_quote("STDAPI_(UINT)   GetRoleTextW(DWORD lRole, LPWSTR lpszRole, UINT cchRoleMax);")
cpp_quote("")
cpp_quote("#ifdef UNICODE")
cpp_quote("#define GetRoleText     GetRoleTextW")
cpp_quote("#else")
cpp_quote("#define GetRoleText     GetRoleTextA")
cpp_quote("#endif // UNICODE")
cpp_quote("")
cpp_quote("STDAPI_(UINT)   GetStateTextA(DWORD lStateBit, LPSTR lpszState, UINT cchState);")
cpp_quote("STDAPI_(UINT)   GetStateTextW(DWORD lStateBit, LPWSTR lpszState, UINT cchState);")
cpp_quote("#ifdef UNICODE")
cpp_quote("#define GetStateText    GetStateTextW")
cpp_quote("#else")
cpp_quote("#define GetStateText    GetStateTextA")
cpp_quote("#endif // UNICODE")
cpp_quote("")
cpp_quote("STDAPI_(VOID)   GetOleaccVersionInfo(DWORD* pVer, DWORD* pBuild);")
cpp_quote("")
*)
  {$EXTERNALSYM CreateStdAccessibleObject}
  CreateStdAccessibleObject: function (hwnd: THandle; idObject: Cardinal; const riid: TGUID; out ppvObject: Pointer): HRESULT; stdcall;
  {$EXTERNALSYM CreateStdAccessibleProxy}
  CreateStdAccessibleProxy: function (hwnd: THandle; pClassName: PChar; idObject: Cardinal; const riid: TGUID; out ppvObject): HRESULT; stdcall;

(*
cpp_quote("STDAPI          CreateStdAccessibleProxyW(HWND hwnd, LPCWSTR pClassName, LONG idObject, REFIID riid, void** ppvObject);")
cpp_quote("")
cpp_quote("#ifdef UNICODE")
cpp_quote("#define CreateStdAccessibleProxy     CreateStdAccessibleProxyW")
cpp_quote("#else")
cpp_quote("#define CreateStdAccessibleProxy     CreateStdAccessibleProxyA")
cpp_quote("#endif // UNICODE")
cpp_quote("")
cpp_quote("")
cpp_quote("// Simple Owner-Drawn Menu support...")
cpp_quote("")
cpp_quote("#define MSAA_MENU_SIG 0xAA0DF00DL")
cpp_quote("")
cpp_quote("// Menu's dwItemData should point to one of these structs:")
cpp_quote("// (or can point to an app-defined struct containing this as the first member)")
cpp_quote("typedef struct tagMSAAMENUINFO {")
cpp_quote("    DWORD   dwMSAASignature; // Must be MSAA_MENU_SIG")
cpp_quote("    DWORD   cchWText;        // Length of text, in Unicode characters, excluding terminating NUL")
cpp_quote("    LPWSTR  pszWText;        // NUL-terminated text, in Unicode")
cpp_quote("} MSAAMENUINFO, *LPMSAAMENUINFO;")
*)

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AccessibilityMajorVersion = 1;
  AccessibilityMinorVersion = 1;

  LIBID_Accessibility: TGUID = '{1EA4DBF0-3C3B-11CF-810C-00AA00389B71}';
  {$EXTERNALSYM LIBID_Accessibility}  

  IID_IAccessible: TGUID = '{618736E0-3C3D-11CF-810C-00AA00389B71}';
  {$EXTERNALSYM IID_IAccessible}
  IID_IAccessibleHandler: TGUID = '{03022430-ABC4-11D0-BDE2-00AA001A1953}';
  {$EXTERNALSYM IID_IAccessibleHandler}
  IID_IAccIdentity: TGUID = '{7852B78D-1CFD-41C1-A615-9C0C85960B5F}';
  {$EXTERNALSYM IID_IAccIdentity}
  IID_IAccPropServer: TGUID = '{76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0}';
  {$EXTERNALSYM IID_IAccPropServer}
  IID_IAccPropServices: TGUID = '{6E26E776-04F0-495D-80E4-3330352E3169}';
  {$EXTERNALSYM IID_IAccPropServices}
  CLASS_CAccPropServices: TGUID = '{B5F8350B-0548-48B1-A6EE-88BD00B4A5E7}';
  {$EXTERNALSYM CLASS_CAccPropServices}

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum AnnoScope
type
  {$IFNDEF COMPILER_5_UP}
    TOleEnum = type Integer;
  {$ENDIF}
  AnnoScope = TOleEnum;
  {$EXTERNALSYM AnnoScope}  
const
  ANNO_THIS = $00000000;
  {$EXTERNALSYM ANNO_THIS}
  ANNO_CONTAINER = $00000001;
  {$EXTERNALSYM ANNO_CONTAINER}

//  These are constants added from oleacc.h

  DISPID_ACC_PARENT = -5000 ;
  {$EXTERNALSYM DISPID_ACC_PARENT}
  DISPID_ACC_CHILDCOUNT = -5001 ;
  {$EXTERNALSYM DISPID_ACC_CHILDCOUNT}
  DISPID_ACC_CHILD = -5002 ;
  {$EXTERNALSYM DISPID_ACC_CHILD}
  DISPID_ACC_NAME = -5003 ;
  {$EXTERNALSYM DISPID_ACC_NAME}
  DISPID_ACC_VALUE = -5004 ;
  {$EXTERNALSYM DISPID_ACC_VALUE}
  DISPID_ACC_DESCRIPTION = -5005 ;
  {$EXTERNALSYM DISPID_ACC_DESCRIPTION}
  DISPID_ACC_ROLE = -5006 ;
  {$EXTERNALSYM DISPID_ACC_ROLE}
  DISPID_ACC_STATE = -5007 ;
  {$EXTERNALSYM DISPID_ACC_STATE}
  DISPID_ACC_HELP = -5008 ;
  {$EXTERNALSYM DISPID_ACC_HELP}
  DISPID_ACC_HELPTOPIC = -5009 ;
  {$EXTERNALSYM DISPID_ACC_HELPTOPIC}
  DISPID_ACC_KEYBOARDSHORTCUT = -5010 ;
  {$EXTERNALSYM DISPID_ACC_KEYBOARDSHORTCUT}
  DISPID_ACC_FOCUS = -5011 ;
  {$EXTERNALSYM DISPID_ACC_FOCUS}
  DISPID_ACC_SELECTION = -5012 ;
  {$EXTERNALSYM DISPID_ACC_SELECTION}
  DISPID_ACC_DEFAULTACTION = -5013 ;
  {$EXTERNALSYM DISPID_ACC_DEFAULTACTION}
  DISPID_ACC_SELECT = -5014 ;
  {$EXTERNALSYM DISPID_ACC_SELECT}
  DISPID_ACC_LOCATION = -5015 ;
  {$EXTERNALSYM DISPID_ACC_LOCATION}
  DISPID_ACC_NAVIGATE = -5016 ;
  {$EXTERNALSYM DISPID_ACC_NAVIGATE}
  DISPID_ACC_HITTEST = -5017 ;
  {$EXTERNALSYM DISPID_ACC_HITTEST}
  DISPID_ACC_DODEFAULTACTION = -5018 ;
  {$EXTERNALSYM DISPID_ACC_DODEFAULTACTION}
  NAVDIR_MIN = 0 ;
  {$EXTERNALSYM NAVDIR_MIN}
  NAVDIR_UP = $1 ;
  {$EXTERNALSYM NAVDIR_UP}
  NAVDIR_DOWN = $2 ;
  {$EXTERNALSYM NAVDIR_DOWN}
  NAVDIR_LEFT = $3 ;
  {$EXTERNALSYM NAVDIR_LEFT}
  NAVDIR_RIGHT = $4 ;
  {$EXTERNALSYM NAVDIR_RIGHT}
  NAVDIR_NEXT = $5 ;
  {$EXTERNALSYM NAVDIR_NEXT}
  NAVDIR_PREVIOUS = $6 ;
  {$EXTERNALSYM NAVDIR_PREVIOUS}
  NAVDIR_FIRSTCHILD = $7 ;
  {$EXTERNALSYM NAVDIR_FIRSTCHILD}
  NAVDIR_LASTCHILD = $8 ;
  {$EXTERNALSYM NAVDIR_LASTCHILD}
  NAVDIR_MAX = $9 ;
  {$EXTERNALSYM NAVDIR_MAX}
  SELFLAG_NONE = 0 ;
  {$EXTERNALSYM SELFLAG_NONE}
  SELFLAG_TAKEFOCUS = $1 ;
  {$EXTERNALSYM SELFLAG_TAKEFOCUS}
  SELFLAG_TAKESELECTION = $2 ;
  {$EXTERNALSYM SELFLAG_TAKESELECTION}
  SELFLAG_EXTENDSELECTION = $4 ;
  {$EXTERNALSYM SELFLAG_EXTENDSELECTION}
  SELFLAG_ADDSELECTION = $8 ;
  {$EXTERNALSYM SELFLAG_ADDSELECTION}
  SELFLAG_REMOVESELECTION = $10 ;
  {$EXTERNALSYM SELFLAG_REMOVESELECTION}
  SELFLAG_VALID = $1f ;
  {$EXTERNALSYM SELFLAG_VALID}
  STATE_SYSTEM_NORMAL = 0 ;
  {$EXTERNALSYM STATE_SYSTEM_NORMAL}
  STATE_SYSTEM_UNAVAILABLE = $1 ;
  {$EXTERNALSYM STATE_SYSTEM_UNAVAILABLE}
  STATE_SYSTEM_SELECTED = $2 ;
  {$EXTERNALSYM STATE_SYSTEM_SELECTED}
  STATE_SYSTEM_FOCUSED = $4 ;
  {$EXTERNALSYM STATE_SYSTEM_FOCUSED}
  STATE_SYSTEM_PRESSED = $8 ;
  {$EXTERNALSYM STATE_SYSTEM_PRESSED}
  STATE_SYSTEM_CHECKED = $10 ;
  {$EXTERNALSYM STATE_SYSTEM_CHECKED}
  STATE_SYSTEM_MIXED = $20 ;
  {$EXTERNALSYM STATE_SYSTEM_MIXED}
  STATE_SYSTEM_INDETERMINATE = STATE_SYSTEM_MIXED;
  {$EXTERNALSYM STATE_SYSTEM_INDETERMINATE}
  STATE_SYSTEM_READONLY = $40 ;
  {$EXTERNALSYM STATE_SYSTEM_READONLY}
  STATE_SYSTEM_HOTTRACKED = $80 ;
  {$EXTERNALSYM STATE_SYSTEM_HOTTRACKED}
  STATE_SYSTEM_DEFAULT = $100 ;
  {$EXTERNALSYM STATE_SYSTEM_DEFAULT}
  STATE_SYSTEM_EXPANDED = $200 ;
  {$EXTERNALSYM STATE_SYSTEM_EXPANDED}
  STATE_SYSTEM_COLLAPSED = $400 ;
  {$EXTERNALSYM STATE_SYSTEM_COLLAPSED}
  STATE_SYSTEM_BUSY = $800 ;
  {$EXTERNALSYM STATE_SYSTEM_BUSY}
  STATE_SYSTEM_FLOATING = $1000 ;
  {$EXTERNALSYM STATE_SYSTEM_FLOATING}
  STATE_SYSTEM_MARQUEED = $2000 ;
  {$EXTERNALSYM STATE_SYSTEM_MARQUEED}
  STATE_SYSTEM_ANIMATED = $4000 ;
  {$EXTERNALSYM STATE_SYSTEM_ANIMATED}
  STATE_SYSTEM_INVISIBLE = $8000 ;
  {$EXTERNALSYM STATE_SYSTEM_INVISIBLE}
  STATE_SYSTEM_OFFSCREEN = $10000 ;
  {$EXTERNALSYM STATE_SYSTEM_OFFSCREEN}
  STATE_SYSTEM_SIZEABLE = $20000 ;
  {$EXTERNALSYM STATE_SYSTEM_SIZEABLE}
  STATE_SYSTEM_MOVEABLE = $40000 ;
  {$EXTERNALSYM STATE_SYSTEM_MOVEABLE}
  STATE_SYSTEM_SELFVOICING = $80000 ;
  {$EXTERNALSYM STATE_SYSTEM_SELFVOICING}
  STATE_SYSTEM_FOCUSABLE = $100000 ;
  {$EXTERNALSYM STATE_SYSTEM_FOCUSABLE}
  STATE_SYSTEM_SELECTABLE = $200000 ;
  {$EXTERNALSYM STATE_SYSTEM_SELECTABLE}
  STATE_SYSTEM_LINKED = $400000 ;
  {$EXTERNALSYM STATE_SYSTEM_LINKED}
  STATE_SYSTEM_TRAVERSED = $800000 ;
  {$EXTERNALSYM STATE_SYSTEM_TRAVERSED}
  STATE_SYSTEM_MULTISELECTABLE = $1000000 ;
  {$EXTERNALSYM STATE_SYSTEM_MULTISELECTABLE}
  STATE_SYSTEM_EXTSELECTABLE = $2000000 ;
  {$EXTERNALSYM STATE_SYSTEM_EXTSELECTABLE}
  STATE_SYSTEM_ALERT_LOW = $4000000 ;
  {$EXTERNALSYM STATE_SYSTEM_ALERT_LOW}
  STATE_SYSTEM_ALERT_MEDIUM = $8000000 ;
  {$EXTERNALSYM STATE_SYSTEM_ALERT_MEDIUM}
  STATE_SYSTEM_ALERT_HIGH = $10000000 ;
  {$EXTERNALSYM STATE_SYSTEM_ALERT_HIGH}
  STATE_SYSTEM_PROTECTED = $20000000 ;
  {$EXTERNALSYM STATE_SYSTEM_PROTECTED}
  STATE_SYSTEM_HASPOPUP = $40000000;
  {$EXTERNALSYM STATE_SYSTEM_HASPOPUP}
  STATE_SYSTEM_VALID = $3fffffff ;
  {$EXTERNALSYM STATE_SYSTEM_VALID}
  ROLE_SYSTEM_TITLEBAR = $1 ;
  {$EXTERNALSYM ROLE_SYSTEM_TITLEBAR}
  ROLE_SYSTEM_MENUBAR = $2 ;
  {$EXTERNALSYM ROLE_SYSTEM_MENUBAR}
  ROLE_SYSTEM_SCROLLBAR = $3 ;
  {$EXTERNALSYM ROLE_SYSTEM_SCROLLBAR}
  ROLE_SYSTEM_GRIP = $4 ;
  {$EXTERNALSYM ROLE_SYSTEM_GRIP}
  ROLE_SYSTEM_SOUND = $5 ;
  {$EXTERNALSYM ROLE_SYSTEM_SOUND}
  ROLE_SYSTEM_CURSOR = $6 ;
  {$EXTERNALSYM ROLE_SYSTEM_CURSOR}
  ROLE_SYSTEM_CARET = $7 ;
  {$EXTERNALSYM ROLE_SYSTEM_CARET}
  ROLE_SYSTEM_ALERT = $8 ;
  {$EXTERNALSYM ROLE_SYSTEM_ALERT}
  ROLE_SYSTEM_WINDOW = $9 ;
  {$EXTERNALSYM ROLE_SYSTEM_WINDOW}
  ROLE_SYSTEM_CLIENT = $a ;
  {$EXTERNALSYM ROLE_SYSTEM_CLIENT}
  ROLE_SYSTEM_MENUPOPUP = $b ;
  {$EXTERNALSYM ROLE_SYSTEM_MENUPOPUP}
  ROLE_SYSTEM_MENUITEM = $c ;
  {$EXTERNALSYM ROLE_SYSTEM_MENUITEM}
  ROLE_SYSTEM_TOOLTIP = $d ;
  {$EXTERNALSYM ROLE_SYSTEM_TOOLTIP}
  ROLE_SYSTEM_APPLICATION = $e ;
  {$EXTERNALSYM ROLE_SYSTEM_APPLICATION}
  ROLE_SYSTEM_DOCUMENT = $f ;
  {$EXTERNALSYM ROLE_SYSTEM_DOCUMENT}
  ROLE_SYSTEM_PANE = $10 ;
  {$EXTERNALSYM ROLE_SYSTEM_PANE}
  ROLE_SYSTEM_CHART = $11 ;
  {$EXTERNALSYM ROLE_SYSTEM_CHART}
  ROLE_SYSTEM_DIALOG = $12 ;
  {$EXTERNALSYM ROLE_SYSTEM_DIALOG}
  ROLE_SYSTEM_BORDER = $13 ;
  {$EXTERNALSYM ROLE_SYSTEM_BORDER}
  ROLE_SYSTEM_GROUPING = $14 ;
  {$EXTERNALSYM ROLE_SYSTEM_GROUPING}
  ROLE_SYSTEM_SEPARATOR = $15 ;
  {$EXTERNALSYM ROLE_SYSTEM_SEPARATOR}
  ROLE_SYSTEM_TOOLBAR = $16 ;
  {$EXTERNALSYM ROLE_SYSTEM_TOOLBAR}
  ROLE_SYSTEM_STATUSBAR = $17 ;
  {$EXTERNALSYM ROLE_SYSTEM_STATUSBAR}
  ROLE_SYSTEM_TABLE = $18 ;
  {$EXTERNALSYM ROLE_SYSTEM_TABLE}
  ROLE_SYSTEM_COLUMNHEADER = $19 ;
  {$EXTERNALSYM ROLE_SYSTEM_COLUMNHEADER}
  ROLE_SYSTEM_ROWHEADER = $1a ;
  {$EXTERNALSYM ROLE_SYSTEM_ROWHEADER}
  ROLE_SYSTEM_COLUMN = $1b ;
  {$EXTERNALSYM ROLE_SYSTEM_COLUMN}
  ROLE_SYSTEM_ROW = $1c ;
  {$EXTERNALSYM ROLE_SYSTEM_ROW}
  ROLE_SYSTEM_CELL = $1d ;
  {$EXTERNALSYM ROLE_SYSTEM_CELL}
  ROLE_SYSTEM_LINK = $1e ;
  {$EXTERNALSYM ROLE_SYSTEM_LINK}
  ROLE_SYSTEM_HELPBALLOON = $1f ;
  {$EXTERNALSYM ROLE_SYSTEM_HELPBALLOON}
  ROLE_SYSTEM_CHARACTER = $20 ;
  {$EXTERNALSYM ROLE_SYSTEM_CHARACTER}
  ROLE_SYSTEM_LIST = $21 ;
  {$EXTERNALSYM ROLE_SYSTEM_LIST}
  ROLE_SYSTEM_LISTITEM = $22 ;
  {$EXTERNALSYM ROLE_SYSTEM_LISTITEM}
  ROLE_SYSTEM_OUTLINE = $23 ;
  {$EXTERNALSYM ROLE_SYSTEM_OUTLINE}
  ROLE_SYSTEM_OUTLINEITEM = $24 ;
  {$EXTERNALSYM ROLE_SYSTEM_OUTLINEITEM}
  ROLE_SYSTEM_PAGETAB = $25 ;
  {$EXTERNALSYM ROLE_SYSTEM_PAGETAB}
  ROLE_SYSTEM_PROPERTYPAGE = $26 ;
  {$EXTERNALSYM ROLE_SYSTEM_PROPERTYPAGE}
  ROLE_SYSTEM_INDICATOR = $27 ;
  {$EXTERNALSYM ROLE_SYSTEM_INDICATOR}
  ROLE_SYSTEM_GRAPHIC = $28 ;
  {$EXTERNALSYM ROLE_SYSTEM_GRAPHIC}
  ROLE_SYSTEM_STATICTEXT = $29 ;
  {$EXTERNALSYM ROLE_SYSTEM_STATICTEXT}
  ROLE_SYSTEM_TEXT = $2a ;
  {$EXTERNALSYM ROLE_SYSTEM_TEXT}
  ROLE_SYSTEM_PUSHBUTTON = $2b ;
  {$EXTERNALSYM ROLE_SYSTEM_PUSHBUTTON}
  ROLE_SYSTEM_CHECKBUTTON = $2c ;
  {$EXTERNALSYM ROLE_SYSTEM_CHECKBUTTON}
  ROLE_SYSTEM_RADIOBUTTON = $2d ;
  {$EXTERNALSYM ROLE_SYSTEM_RADIOBUTTON}
  ROLE_SYSTEM_COMBOBOX = $2e ;
  {$EXTERNALSYM ROLE_SYSTEM_COMBOBOX}
  ROLE_SYSTEM_DROPLIST = $2f ;
  {$EXTERNALSYM ROLE_SYSTEM_DROPLIST}
  ROLE_SYSTEM_PROGRESSBAR = $30 ;
  {$EXTERNALSYM ROLE_SYSTEM_PROGRESSBAR}
  ROLE_SYSTEM_DIAL = $31 ;
  {$EXTERNALSYM ROLE_SYSTEM_DIAL}
  ROLE_SYSTEM_HOTKEYFIELD = $32 ;
  {$EXTERNALSYM ROLE_SYSTEM_HOTKEYFIELD}
  ROLE_SYSTEM_SLIDER = $33 ;
  {$EXTERNALSYM ROLE_SYSTEM_SLIDER}
  ROLE_SYSTEM_SPINBUTTON = $34 ;
  {$EXTERNALSYM ROLE_SYSTEM_SPINBUTTON}
  ROLE_SYSTEM_DIAGRAM = $35 ;
  {$EXTERNALSYM ROLE_SYSTEM_DIAGRAM}
  ROLE_SYSTEM_ANIMATION = $36 ;
  {$EXTERNALSYM ROLE_SYSTEM_ANIMATION}
  ROLE_SYSTEM_EQUATION = $37 ;
  {$EXTERNALSYM ROLE_SYSTEM_EQUATION}
  ROLE_SYSTEM_BUTTONDROPDOWN = $38 ;
  {$EXTERNALSYM ROLE_SYSTEM_BUTTONDROPDOWN}
  ROLE_SYSTEM_BUTTONMENU = $39 ;
  {$EXTERNALSYM ROLE_SYSTEM_BUTTONMENU}
  ROLE_SYSTEM_BUTTONDROPDOWNGRID = $3a ;
  {$EXTERNALSYM ROLE_SYSTEM_BUTTONDROPDOWNGRID}
  ROLE_SYSTEM_WHITESPACE = $3b ;
  {$EXTERNALSYM ROLE_SYSTEM_WHITESPACE}
  ROLE_SYSTEM_PAGETABLIST = $3c ;
  {$EXTERNALSYM ROLE_SYSTEM_PAGETABLIST}
  ROLE_SYSTEM_CLOCK = $3d ;
  {$EXTERNALSYM ROLE_SYSTEM_CLOCK}
  CHILDID_SELF = 0;
  {$EXTERNALSYM CHILDID_SELF}

// END: Constants added from oleacc.h

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  {$EXTERNALSYM IAccessible}
  IAccessible = interface;
  {$EXTERNALSYM IAccessibleDisp}
  IAccessibleDisp = dispinterface;
  {$EXTERNALSYM IAccessibleHandler}
  IAccessibleHandler = interface;
  {$EXTERNALSYM IAccIdentity}
  IAccIdentity = interface;
  {$EXTERNALSYM IAccPropServer}
  IAccPropServer = interface;
  {$EXTERNALSYM IAccPropServices}
  IAccPropServices = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  {$EXTERNALSYM CAccPropServices}
  CAccPropServices = IAccPropServices;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  {$EXTERNALSYM wireHWND}
  wireHWND = ^_RemotableHandle;
  {$EXTERNALSYM wireHMENU}
  wireHMENU = ^_RemotableHandle;
  PByte1 = ^Byte; {*}
  PUserType1 = ^TGUID; {*}


  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = packed record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;


// *********************************************************************//
// Interface: IAccessible
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {618736E0-3C3D-11CF-810C-00AA00389B71}
// *********************************************************************//
  {$EXTERNALSYM IAccessible}
  IAccessible = interface(IDispatch)
    ['{618736E0-3C3D-11CF-810C-00AA00389B71}']
    function Get_accParent(out ppdispParent: IDispatch): HResult; stdcall;
    function Get_accChildCount(out pcountChildren: Integer): HResult; stdcall;
    function Get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HResult; stdcall;
    function Get_accName(varChild: OleVariant; out pszName: WideString): HResult; stdcall;
    function Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult; stdcall;
    function Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult; stdcall;
    function Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult; stdcall;
    function Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult; stdcall;
    function Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult; stdcall;
    function Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant;
                              out pidTopic: Integer): HResult; stdcall;
    function Get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: WideString): HResult; stdcall;
    function Get_accFocus(out pvarChild: OleVariant): HResult; stdcall;
    function Get_accSelection(out pvarChildren: OleVariant): HResult; stdcall;
    function Get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: WideString): HResult; stdcall;
    function accSelect(flagsSelect: Integer; varChild: OleVariant): HResult; stdcall;
    function accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer;
                         out pcyHeight: Integer; varChild: OleVariant): HResult; stdcall;
    function accNavigate(navDir: Integer; varStart: OleVariant; out pvarEndUpAt: OleVariant): HResult; stdcall;
    function accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult; stdcall;
    function accDoDefaultAction(varChild: OleVariant): HResult; stdcall;
    function Set_accName(varChild: OleVariant; const pszName: WideString): HResult; stdcall;
    function Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IAccessibleDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {618736E0-3C3D-11CF-810C-00AA00389B71}
// *********************************************************************//
  {$EXTERNALSYM IAccessibleDisp}
  IAccessibleDisp = dispinterface
    ['{618736E0-3C3D-11CF-810C-00AA00389B71}']
    property accParent: IDispatch readonly dispid -5000;
    property accChildCount: Integer readonly dispid -5001;
    property accChild[varChild: OleVariant]: IDispatch readonly dispid -5002;
    property accName[varChild: OleVariant]: WideString dispid -5003;
    property accValue[varChild: OleVariant]: WideString dispid -5004;
    property accDescription[varChild: OleVariant]: WideString readonly dispid -5005;
    property accRole[varChild: OleVariant]: OleVariant readonly dispid -5006;
    property accState[varChild: OleVariant]: OleVariant readonly dispid -5007;
    property accHelp[varChild: OleVariant]: WideString readonly dispid -5008;
    property accHelpTopic[out pszHelpFile: WideString; varChild: OleVariant]: Integer readonly dispid -5009;
    property accKeyboardShortcut[varChild: OleVariant]: WideString readonly dispid -5010;
    property accFocus: OleVariant readonly dispid -5011;
    property accSelection: OleVariant readonly dispid -5012;
    property accDefaultAction[varChild: OleVariant]: WideString readonly dispid -5013;
    procedure accSelect(flagsSelect: Integer; varChild: OleVariant); dispid -5014;
    procedure accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer; 
                          out pcyHeight: Integer; varChild: OleVariant); dispid -5015;
    function accNavigate(navDir: Integer; varStart: OleVariant): OleVariant; dispid -5016;
    function accHitTest(xLeft: Integer; yTop: Integer): OleVariant; dispid -5017;
    procedure accDoDefaultAction(varChild: OleVariant); dispid -5018;
  end;

// *********************************************************************//
// Interface: IAccessibleHandler
// Flags:     (272) Hidden OleAutomation
// GUID:      {03022430-ABC4-11D0-BDE2-00AA001A1953}
// *********************************************************************//
  {$EXTERNALSYM IAccessibleHandler}
  IAccessibleHandler = interface(IUnknown)
    ['{03022430-ABC4-11D0-BDE2-00AA001A1953}']
    function AccessibleObjectFromID(hwnd: Integer; lObjectID: Integer; out pIAccessible: IAccessible): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAccIdentity
// Flags:     (0)
// GUID:      {7852B78D-1CFD-41C1-A615-9C0C85960B5F}
// *********************************************************************//
  {$EXTERNALSYM IAccIdentity}
  IAccIdentity = interface(IUnknown)
    ['{7852B78D-1CFD-41C1-A615-9C0C85960B5F}']
    function GetIdentityString(dwIDChild: LongWord; out ppIDString: PByte1;
                               out pdwIDStringLen: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAccPropServer
// Flags:     (0)
// GUID:      {76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0}
// *********************************************************************//
  {$EXTERNALSYM IAccPropServer}
  IAccPropServer = interface(IUnknown)
    ['{76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0}']
    function GetPropValue(var pIDString: Byte; dwIDStringLen: LongWord; idProp: TGUID;
                          out pvarValue: OleVariant; out pfHasProp: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAccPropServices
// Flags:     (0)
// GUID:      {6E26E776-04F0-495D-80E4-3330352E3169}
// *********************************************************************//
  {$EXTERNALSYM IAccPropServices}
  IAccPropServices = interface(IUnknown)
    ['{6E26E776-04F0-495D-80E4-3330352E3169}']
    function SetPropValue(var pIDString: Byte; dwIDStringLen: LongWord; idProp: TGUID;
                          var_: OleVariant): HResult; stdcall;
    function SetPropServer(var pIDString: Byte; dwIDStringLen: LongWord; var paProps: TGUID; 
                           cProps: SYSINT; const pServer: IAccPropServer; AnnoScope: AnnoScope): HResult; stdcall;
    function ClearProps(var pIDString: Byte; dwIDStringLen: LongWord; var paProps: TGUID; 
                        cProps: SYSINT): HResult; stdcall;
    function SetHwndProp(var hwnd: _RemotableHandle; idObject: LongWord; idChild: LongWord; 
                         idProp: TGUID; var_: OleVariant): HResult; stdcall;
    function SetHwndPropStr(var hwnd: _RemotableHandle; idObject: LongWord; idChild: LongWord; 
                            idProp: TGUID; str: PWideChar): HResult; stdcall;
    function SetHwndPropServer(var hwnd: _RemotableHandle; idObject: LongWord; idChild: LongWord; 
                               var paProps: TGUID; cProps: SYSINT; const pServer: IAccPropServer; 
                               AnnoScope: AnnoScope): HResult; stdcall;
    function ClearHwndProps(var hwnd: _RemotableHandle; idObject: LongWord; idChild: LongWord; 
                            var paProps: TGUID; cProps: SYSINT): HResult; stdcall;
    function ComposeHwndIdentityString(var hwnd: _RemotableHandle; idObject: LongWord; 
                                       idChild: LongWord; out ppIDString: PByte1; 
                                       out pdwIDStringLen: LongWord): HResult; stdcall;
    function DecomposeHwndIdentityString(var pIDString: Byte; dwIDStringLen: LongWord; 
                                         out phwnd: wireHWND; out pidObject: LongWord; 
                                         out pidChild: LongWord): HResult; stdcall;
    function SetHmenuProp(var hmenu: _RemotableHandle; idChild: LongWord; idProp: TGUID; 
                          var_: OleVariant): HResult; stdcall;
    function SetHmenuPropStr(var hmenu: _RemotableHandle; idChild: LongWord; idProp: TGUID; 
                             str: PWideChar): HResult; stdcall;
    function SetHmenuPropServer(var hmenu: _RemotableHandle; idChild: LongWord; var paProps: TGUID; 
                                cProps: SYSINT; const pServer: IAccPropServer; AnnoScope: AnnoScope): HResult; stdcall;
    function ClearHmenuProps(var hmenu: _RemotableHandle; idChild: LongWord; var paProps: TGUID; 
                             cProps: SYSINT): HResult; stdcall;
    function ComposeHmenuIdentityString(var hmenu: _RemotableHandle; idChild: LongWord;
                                        out ppIDString: PByte1; out pdwIDStringLen: LongWord): HResult; stdcall;
    function DecomposeHmenuIdentityString(var pIDString: Byte; dwIDStringLen: LongWord; 
                                          out phmenu: wireHMENU; out pidChild: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoCAccPropServices provides a Create and CreateRemote method to          
// create instances of the default interface IAccPropServices exposed by              
// the CoClass CAccPropServices. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  {$EXTERNALSYM CoCAccPropServices}
  CoCAccPropServices = class
    class function Create: IAccPropServices;
    class function CreateRemote(const MachineName: string): IAccPropServices;
  end;

{$EXTERNALSYM CreateAccessibleProxy}
function CreateAccessibleProxy(Handle: THandle; Classname: string): IDispatch;

// this is an override for the NotifyWinEvent function normally defined in windows.pas.
// In Windows.pas, this declaration is missing a stdcall; at the end, resulting in a crash when called.
// As a consequence, this unit must always be AFTER windows.pas in the uses clause.
{$EXTERNALSYM NotifyWinEvent}
  procedure NotifyWinEvent(event: DWORD; hwnd: HWND; idObject, idChild: Cardinal); stdcall;

function InitAccLibrary: boolean;
procedure FreeAccLibrary;

implementation

uses ComObj, SyncObjs;

const
  OleAccLib = 'oleacc.dll';

var
  AccLibrary: THandle;
  Lock: TCriticalSection;
  ReferenceCount: Integer = 0;

function InitAccLibrary: boolean;
begin
  Lock.Enter;
  try
    Inc(ReferenceCount);

    if AccLibrary = 0 then
    begin
      AccLibrary := LoadLibrary(OleAccLib);
      if AccLibrary > 0 then
      begin
        LresultFromObject := GetProcAddress(AccLibrary, 'LresultFromObject');
        ObjectFromLresult := GetProcAddress(AccLibrary, 'ObjectFromLresult');
        AccessibleObjectFromWindow := GetProcAddress(AccLibrary, 'AccessibleObjectFromWindow');
        CreateStdAccessibleObject := GetProcAddress(AccLibrary, 'CreateStdAccessibleObject');
        CreateStdAccessibleProxy := GetProcAddress(AccLibrary, 'CreateStdAccessibleProxyA');
      end;
    end;
    Result := AccLibrary > 0;
  finally
    Lock.Leave;
  end;
end;

procedure FreeAccLibrary;
begin
  Lock.Enter;
  try
    if ReferenceCount > 0 then
      Dec(ReferenceCount);

    if (AccLibrary <> 0) and (ReferenceCount = 0) then
    begin
      FreeLibrary(AccLibrary);
      AccLibrary := 0;
  
      LresultFromObject := nil;
      ObjectFromLresult := nil;
      AccessibleObjectFromWindow := nil;
      CreateStdAccessibleObject := nil;
      CreateStdAccessibleProxy := nil;
    end;
  finally
    Lock.Leave;
  end;
end;

(*$HPPEMIT '#pragma link "oleacc.lib"'*)

function CreateAccessibleProxy(Handle: THandle; Classname: string): IDispatch;
var
  AccPtr: Pointer;
begin
  CreateStdAccessibleProxy(Handle, PChar(Classname), OBJID_CLIENT, IID_IAccessible, AccPtr);  { do not localize }
  Result := IDispatch(AccPtr);
end;

class function CoCAccPropServices.Create: IAccPropServices;
begin
  Result := CreateComObject(CLASS_CAccPropServices) as IAccPropServices;
end;

class function CoCAccPropServices.CreateRemote(const MachineName: string): IAccPropServices;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CAccPropServices) as IAccPropServices;
end;

procedure NotifyWinEvent; external user32 name 'NotifyWinEvent';

initialization
  Lock := TCriticalSection.Create;
finalization
  while ReferenceCount > 0 do
    FreeAccLibrary;
  Lock.Free;
end.
