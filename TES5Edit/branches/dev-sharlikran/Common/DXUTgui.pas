(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK December 2006 C++ common framework adaptation for Delphi    *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: Direct3D part of framework.                                         *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: DXUTgui.pas,v 1.31 2007/02/05 22:21:00 clootie Exp $
 *----------------------------------------------------------------------------*)
{******************************************************************************}
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

//--------------------------------------------------------------------------------------
// File: DXUTgui.h, DXUTgui.cpp
//
// Desc:
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

{$I DirectX.inc}

unit DXUTgui;

interface

uses
  Windows, Messages, Classes, imm, usp10,
  DXTypes, Direct3D9, D3DX9, dxerr9;

{$IFNDEF FPC}
type
  //todo: Fill BUG REPORT TO BORLAND -> Wrong conversion in Imm.pas.
  PCandidateList = ^TCandidateList;
  {$EXTERNALSYM tagCANDIDATELIST}
  tagCANDIDATELIST = record
    dwSize: DWORD;
    dwStyle: DWORD;
    dwCount: DWORD;
    dwSelection: DWORD;
    dwPageStart: DWORD;
    dwPageSize: DWORD;
    dwOffset: array[0..0] of DWORD;
  end;
  TCandidateList = tagCANDIDATELIST;
  {$EXTERNALSYM CANDIDATELIST}
  CANDIDATELIST = tagCANDIDATELIST;

{$ENDIF}

const
  //--------------------------------------------------------------------------------------
  // Defines and macros
  //--------------------------------------------------------------------------------------
  EVENT_BUTTON_CLICKED             = $0101;
  EVENT_COMBOBOX_SELECTION_CHANGED = $0201;
  EVENT_RADIOBUTTON_CHANGED        = $0301;
  EVENT_CHECKBOX_CHANGED           = $0401;
  EVENT_SLIDER_VALUE_CHANGED       = $0501;
  EVENT_EDITBOX_STRING             = $0601;
  // EVENT_EDITBOX_CHANGE is sent when the listbox content changes
  // due to user input.
  EVENT_EDITBOX_CHANGE                = $0602;
  EVENT_LISTBOX_ITEM_DBLCLK           = $0701;
  // EVENT_LISTBOX_SELECTION is fired off when the selection changes in
  // a single selection list box.
  EVENT_LISTBOX_SELECTION             = $0702;
  EVENT_LISTBOX_SELECTION_END         = $0703;

  //-----------------------------------------------------------------------------
  // IME-enabled EditBox control
  //-----------------------------------------------------------------------------
  IMM32_DLLNAME = '\imm32.dll';
  VER_DLLNAME = '\version.dll';
  MAX_CANDLIST = 10;
  MAX_COMPSTRING_SIZE = 256;

{$IFDEF FPC}
  SPI_GETWHEELSCROLLLINES = 104;
  
{$ENDIF}

var
  g_fTimeRefresh: Double = 0.0; //Clootie: static for CDXUTDialog class

type
  //--------------------------------------------------------------------------------------
  // Forward declarations
  //--------------------------------------------------------------------------------------
  CDXUTDialogResourceManager = class;
  CDXUTControl = class;
  CDXUTButton = class;
  CDXUTStatic = class;
  CDXUTCheckBox = class;
  CDXUTRadioButton = class;
  CDXUTComboBox = class;
  CDXUTSlider = class;
  CDXUTEditBox = class;
  CDXUTIMEEditBox = class;
  CDXUTListBox = class;
  CDXUTScrollBar = class;
  CDXUTElement = class;

  PCDXUTControl = ^CDXUTControl;
  PCDXUTButton = ^CDXUTButton;
  PCDXUTStatic = ^CDXUTStatic;
  PCDXUTCheckBox = ^CDXUTCheckBox;
  PCDXUTRadioButton = ^CDXUTRadioButton;
  PCDXUTComboBox = ^CDXUTComboBox;
  PCDXUTListBox = ^CDXUTListBox;
  PCDXUTSlider = ^CDXUTSlider;
  PCDXUTEditBox = ^CDXUTEditBox;
  PCDXUTIMEEditBox = ^CDXUTIMEEditBox;
  PCDXUTElement = ^CDXUTElement;

  PCallbackDXUTguiEvent = procedure (nEvent: LongWord; nControlID: Integer; pControl: CDXUTControl; pUserContext: Pointer); stdcall;

  //--------------------------------------------------------------------------------------
  // Enums for pre-defined control types
  //--------------------------------------------------------------------------------------
  TDXUTControlType = (
    DXUT_CONTROL_BUTTON,
    DXUT_CONTROL_STATIC,
    DXUT_CONTROL_CHECKBOX,
    DXUT_CONTROL_RADIOBUTTON,
    DXUT_CONTROL_COMBOBOX,
    DXUT_CONTROL_SLIDER,
    DXUT_CONTROL_EDITBOX,
    DXUT_CONTROL_IMEEDITBOX,
    DXUT_CONTROL_LISTBOX,
    DXUT_CONTROL_SCROLLBAR
  );

  TDXUTControlState = (
    DXUT_STATE_NORMAL {=0},
    DXUT_STATE_DISABLED,
    DXUT_STATE_HIDDEN,
    DXUT_STATE_FOCUS,
    DXUT_STATE_MOUSEOVER,
    DXUT_STATE_PRESSED
  );


  TDXUTBlendColor = class
    States: array[Low(TDXUTControlState)..High(TDXUTControlState)] of TD3DColor; // Modulate colors for all possible control states
    Current: TD3DXColor;

    procedure Init(defaultColor: TD3DColor; disabledColor: TD3DColor = $C8808080 {D3DCOLOR_ARGB(200, 128, 128, 128)}; hiddenColor: TD3DColor = 0);
    procedure Blend(iState: TDXUTControlState; fElapsedTime: Single; fRate: Single = 0.7);
  end;

  //-----------------------------------------------------------------------------
  // Contains all the display tweakables for a sub-control
  //-----------------------------------------------------------------------------
  CDXUTElement = class(TPersistent)
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    iTexture: LongWord;      // Index of the texture for this Element
    iFont: LongWord;         // Index of the font for this Element
    dwTextFormat: DWORD;     // The format argument to DrawText

    rcTexture: TRect;        // Bounding rect of this element on the composite texture

    TextureColor: TDXUTBlendColor;
    FontColor: TDXUTBlendColor;

    constructor Create;
    destructor Destroy; override;

    procedure SetTexture(iTexture: LongWord; prcTexture: PRect; defaultTextureColor: TD3DColor = $FFFFFFFF);
    procedure SetFont(iFont: LongWord; defaultFontColor: TD3DColor = $FFFFFFFF; dwTextFormat: DWORD = DT_CENTER or DT_VCENTER);

    procedure Refresh;
  end;

  //--------------------------------------------------------------------------------------
  // Structs for shared resources
  //--------------------------------------------------------------------------------------
  PDXUTTextureNode = ^TDXUTTextureNode;
  TDXUTTextureNode = record
    bFileSource: Boolean;  // True if this texture is loaded from a file. False if from resource.
    hResourceModule: HMODULE;
    nResourceID: Integer;  // Resource ID. If 0, string-based ID is used and stored in strFilename.
    strFilename: array[0..MAX_PATH-1] of WideChar;
    pTexture: IDirect3DTexture9;
    dwWidth: DWORD;
    dwHeight: DWORD;
  end;

  PDXUTFontNode = ^TDXUTFontNode;
  TDXUTFontNode = record
    strFace: array[0..MAX_PATH-1] of WideChar;
    pFont: ID3DXFont;
    nHeight: Longint;
    nWeight: Longint;
  end;

  //-----------------------------------------------------------------------------
  // Contains all the display information for a given control type
  //-----------------------------------------------------------------------------
  PDXUTElementHolder = ^TDXUTElementHolder;
  TDXUTElementHolder = record
    nControlType: TDXUTControlType; //Clootie: was LongWord
    iElement: LongWord;

    Element: CDXUTElement;
  end;

  TDXUTLBStyle = (NORMAL, MULTISELECTION); { MULTISELECTION = 1 }

  //-----------------------------------------------------------------------------
  // All controls must be assigned to a dialog, which handles
  // input and rendering for the controls.
  //-----------------------------------------------------------------------------
  CDXUTDialog = class
  private
    m_bVisible: Boolean;
    m_bCaption: Boolean;
    m_bMinimized: Boolean;
    m_bDrag: Boolean;
    m_wszCaption: array[0..255] of WideChar;

    m_x: Integer;
    m_y: Integer;
    m_width: Integer;
    m_height: Integer;
    m_nCaptionHeight: Integer;

    m_colorTopLeft: TD3DColor;
    m_colorTopRight: TD3DColor;
    m_colorBottomLeft: TD3DColor;
    m_colorBottomRight: TD3DColor;

    m_pManager: CDXUTDialogResourceManager;
    m_pCallbackEvent: PCallbackDXUTguiEvent;
    m_pCallbackEventUserContext: Pointer;

    m_Textures: array of Integer;   // Index into m_TextureCache;
    m_Fonts: array of Integer;      // Index into m_FontCache;

    m_Controls: array of CDXUTControl;
    m_DefaultElements: array of PDXUTElementHolder;

    m_CapElement: CDXUTElement;  // Element for the caption

    m_pNextDialog: CDXUTDialog;
    m_pPrevDialog: CDXUTDialog;

  private
    m_nDefaultControlID: Integer;
    m_fTimeLastRefresh: Double;
    m_pControlMouseOver: CDXUTControl;    // The control which is hovered over

    // Initialize default Elements
    procedure InitDefaultElements;

    // Windows message handlers
    procedure OnMouseMove(pt: TPoint);
    {$HINTS OFF}
    procedure OnMouseUp(pt: TPoint);
    {$HINTS ON}

    procedure SetNextDialog(pNextDialog: CDXUTDialog);

    // Control events
    function OnCycleFocus(bForward: Boolean): Boolean;

  public
    constructor Create;
    destructor Destroy; override;

    // Need to call this now
    procedure Init(pManager: CDXUTDialogResourceManager; bRegisterDialog: Boolean = True); overload;
    procedure Init(pManager: CDXUTDialogResourceManager; bRegisterDialog: Boolean; const pszControlTextureFilename: PWideChar); overload;
    procedure Init(pManager: CDXUTDialogResourceManager; bRegisterDialog: Boolean; szControlTextureResourceName: PWideChar; hControlTextureResourceModule: HMODULE); overload;

    // Windows message handler
    function MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;

    // Control creation
    function AddStatic(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bIsDefault: Boolean = False; ppCreated: PCDXUTStatic = nil): HRESULT;
    function AddButton(ID: Integer; strText: PWideChar; x, y, width, height: Integer; nHotkey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTButton = nil): HRESULT;
    function AddCheckBox(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bChecked: Boolean = False; nHotkey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTCheckBox = nil): HRESULT;
    function AddRadioButton(ID: Integer; nButtonGroup: LongWord; strText: PWideChar; x, y, width, height: Integer; bChecked: Boolean = False; nHotkey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTRadioButton = nil): HRESULT;
    function AddComboBox(ID: Integer; x, y, width, height: Integer; nHotKey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTComboBox = nil): HRESULT;
    function AddSlider(ID: Integer; x, y, width, height: Integer; min: Integer = 0; max: Integer = 100; value: Integer = 50; bIsDefault: Boolean = False; ppCreated: PCDXUTSlider = nil): HRESULT;
    function AddEditBox(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bIsDefault: Boolean = False; ppCreated: PCDXUTEditBox = nil): HRESULT;
    function AddIMEEditBox(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bIsDefault: Boolean = False; ppCreated: PCDXUTIMEEditBox = nil): HRESULT;
    function AddListBox(ID: Integer; x, y, width, height: Integer; dwStyle: TDXUTLBStyle = NORMAL; ppCreated: PCDXUTListBox = nil): HRESULT;
    function AddControl(pControl: CDXUTControl): HRESULT;
    function InitControl(pControl: CDXUTControl): HRESULT;

    // Control retrieval
    function GetStatic(ID: Integer): CDXUTStatic;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetButton(ID: Integer): CDXUTButton;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetCheckBox(ID: Integer): CDXUTCheckBox;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetRadioButton(ID: Integer): CDXUTRadioButton;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetComboBox(ID: Integer): CDXUTComboBox;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetSlider(ID: Integer): CDXUTSlider;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetEditBox(ID: Integer): CDXUTEditBox;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetIMEEditBox(ID: Integer): CDXUTIMEEditBox;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetListBox(ID: Integer): CDXUTListBox;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}

    function GetControl(ID: Integer): CDXUTControl; overload;
    function GetControlProp(ID: Integer): CDXUTControl;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetControl(ID: Integer; nControlType: TDXUTControlType): CDXUTControl; overload;
    function GetControlAtPoint(pt: TPoint): CDXUTControl;

    function GetControlEnabled(ID: Integer): Boolean;
    procedure SetControlEnabled(ID: Integer; bEnabled: Boolean);

    procedure ClearRadioButtonGroup(nGroup: LongWord);
    procedure ClearComboBox(ID: Integer);

    // Access the default display Elements used when adding new controls
    function SetDefaultElement(nControlType: TDXUTControlType; iElement: LongWord; pElement: CDXUTElement): HRESULT;
    function GetDefaultElement(nControlType: TDXUTControlType; iElement: LongWord): CDXUTElement;

    // Methods called by controls
    procedure SendEvent(nEvent: LongWord; bTriggeredByUser: Boolean; pControl: CDXUTControl);
    procedure RequestFocus(pControl: CDXUTControl);

    // Render helpers
    function DrawRect(const pRect: TRect; color: TD3DColor): HRESULT;
    function DrawPolyLine(apPoints: PPoint; nNumPoints: LongWord; color: TD3DColor): HRESULT;
    function DrawSprite(pElement: CDXUTElement; const prcDest: TRect): HRESULT;
    function CalcTextRect(strText: PWideChar; pElement: CDXUTElement; prcDest: PRect; nCount: Integer = -1): HRESULT;
    function DrawText(strText: PWideChar; pElement: CDXUTElement; const rcDest: TRect; bShadow: Boolean = False; nCount: Integer = -1): HRESULT;

    // Attributes
    (*bool GetVisible() { return m_bVisible; }
    void SetVisible( bool bVisible ) { m_bVisible = bVisible; }
    bool GetMinimized() { return m_bMinimized; } //Clootie: -> property
    void SetMinimized( bool bMinimized ) { m_bMinimized = bMinimized; }*)
    procedure SetBackgroundColors(colorAllCorners: TD3DColor); overload; { SetBackgroundColors( colorAllCorners, colorAllCorners, colorAllCorners, colorAllCorners ); }
    procedure SetBackgroundColors(colorTopLeft, colorTopRight, colorBottomLeft, colorBottomRight: TD3DColor); overload;
    // procedure EnableCaption(bEnable: Boolean); { m_bCaption = bEnable; }
    // procedure SetCaptionHeight(nHeight: Integer); { m_nCaptionHeight = nHeight; }
    procedure SetCaptionText(const pwszText: PWideChar); { wcsncpy( m_wszCaption, pwszText, sizeof(m_wszCaption)/sizeof(m_wszCaption[0]) ); m_wszCaption[sizeof(m_wszCaption)/sizeof(m_wszCaption[0])-1] = 0; }
    procedure GetLocation(out Pt: TPoint); { Pt.x = m_x; Pt.y = m_y; }
    procedure SetLocation(x, y: Integer); { m_x = x; m_y = y; }
    procedure SetSize(width, height: Integer); { m_width = width; m_height = height;  }
    // function GetWidth: Integer; { return m_width; } //Clootie: -> property
    // function GetHeight: Integer; { return m_height; } //Clootie: -> property

    class procedure SetRefreshTime(fTime: Single); { s_fTimeRefresh = fTime; }

    class function GetNextControl(pControl: CDXUTControl): CDXUTControl;
    class function GetPrevControl(pControl: CDXUTControl): CDXUTControl;

    procedure RemoveControl(ID: Integer);
    procedure RemoveAllControls;

    // Sets the callback used to notify the app of control events
    procedure SetCallback(pCallback: PCallbackDXUTguiEvent; pUserContext: Pointer = nil);
    procedure EnableNonUserEvents(bEnable: Boolean); { m_bNonUserEvents = bEnable; }
    procedure EnableKeyboardInput(bEnable: Boolean); { m_bKeyboardInput = bEnable; }
    procedure EnableMouseInput(bEnable: Boolean); { m_bMouseInput = bEnable; }
    // function IsKeyboardInputEnabled: Boolean; { return m_bKeyboardInput; } //Clootie: Moved to property

    // Device state notification
    procedure Refresh;
    function OnRender(fElapsedTime: Single): HRESULT;

    // Shared resource access. Indexed fonts and textures are shared among
    // all the controls.
    function SetFont(index: LongWord; strFaceName: PWideChar; height, weight: Longint): HRESULT;
    function GetFont(index: LongWord): PDXUTFontNode;

    function SetTexture(index: LongWord; strFilename: PWideChar): HRESULT; overload;
    function SetTexture(index: LongWord; strResourceName: PWideChar; hResourceModule: HMODULE): HRESULT; overload;
    function GetTexture(index: LongWord): PDXUTTextureNode;

    //CDXUTDialogResourceManager* GetManager() { return m_pManager; } //Clootie: -> property

    class procedure ClearFocus;
    procedure FocusDefaultControl;

  public
    m_bNonUserEvents: Boolean;
    m_bKeyboardInput: Boolean;
    m_bMouseInput: Boolean;

  public
    property Manager: CDXUTDialogResourceManager read m_pManager;

    property Static[ID: Integer]: CDXUTStatic read GetStatic;
    property Button[ID: Integer]: CDXUTButton read GetButton;
    property CheckBox[ID: Integer]: CDXUTCheckBox read GetCheckBox;
    property RadioButton[ID: Integer]: CDXUTRadioButton read GetRadioButton;
    property ComboBox[ID: Integer]: CDXUTComboBox read GetComboBox;
    property Slider[ID: Integer]: CDXUTSlider read GetSlider;
    property EditBox[ID: Integer]: CDXUTEditBox read GetEditBox;
    property IMEEditBox[ID: Integer]: CDXUTIMEEditBox read GetIMEEditBox;
    property ListBox[ID: Integer]: CDXUTListBox read GetListBox;

    property Controls[ID: Integer]: CDXUTControl read GetControlProp;

    property IsKeyboardInputEnabled: Boolean read m_bKeyboardInput;

  published
    property CaptionHeight: Integer read m_nCaptionHeight write m_nCaptionHeight;
    property EnableCaption: Boolean read m_bCaption write m_bCaption;
    property Minimized: Boolean read m_bMinimized write m_bMinimized;
    property Width: Integer read m_width write m_width;
    property Height: Integer read m_height write m_height;
  end;


  //-----------------------------------------------------------------------------
  // Manages shared resources of dialogs
  //-----------------------------------------------------------------------------
  CDXUTDialogResourceManager = class
  private
    function GetFontNode(iIndex: Integer): PDXUTFontNode; { return m_FontCache.GetAt( iIndex ); }
    function GetTextureNode(iIndex: Integer): PDXUTTextureNode;  { return m_TextureCache.GetAt( iIndex ); }
  protected
    m_TextureCache: array of PDXUTTextureNode;   // Shared textures
    m_FontCache: array of PDXUTFontNode;         // Shared fonts

    m_pd3dDevice: IDirect3DDevice9;

    // Resource creation helpers
    function CreateFont(index: LongWord): HRESULT;
    function CreateTexture(iTexture: LongWord): HRESULT;

  public
    // Shared between all dialogs
    m_pStateBlock: IDirect3DStateBlock9;
    m_pSprite: ID3DXSprite; // Sprite used for drawing

    m_Dialogs: TList; // array of CDXUTDialog;   // Dialogs registered

    constructor Create;
    destructor Destroy; override;

    function OnCreateDevice(const pd3dDevice: IDirect3DDevice9): HRESULT;
    function OnResetDevice: HRESULT;
    procedure OnLostDevice;
    procedure OnDestroyDevice;
    function MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;

    function AddFont(strFaceName: PWideChar; height, weight: Longint): Integer;
    function AddTexture(strFilename: PWideChar): Integer; overload;
    function AddTexture(strResourceName: PWideChar; hResourceModule: HMODULE): Integer; overload;

    function RegisterDialog(pDialog: CDXUTDialog): Boolean;
    procedure UnregisterDialog(pDialog: CDXUTDialog);
    procedure EnableKeyboardInputForAllDialogs;

    property FontNode[i: Integer]: PDXUTFontNode read GetFontNode;
    property TextureNode[i: Integer]: PDXUTTextureNode read GetTextureNode;
    property D3DDevice: IDirect3DDevice9 read m_pd3dDevice;
  end;

  CDXUTControlClass = class of CDXUTControl;

  //-----------------------------------------------------------------------------
  // Base class for controls
  //-----------------------------------------------------------------------------
  CDXUTControl = class
  protected
    m_ID:  Integer;           // ID number
    m_Type: TDXUTControlType; // Control type, set once in constructor
    m_nHotkey: LongWord;      // Virtual key code for this control's hotkey

    m_pUserData: Pointer;     // Data associated with this control that is set by user.
    m_bEnabled: Boolean;      // Enabled/disabled flag
    m_bVisible: Boolean;      // Shown/hidden flag
    m_rcBoundingBox: TRect;   // Rectangle defining the active region of the control

    m_bMouseOver: Boolean;              // Mouse pointer is above control
    m_bHasFocus: Boolean;               // Control has input focus
    m_bIsDefault: Boolean;              // Is the default control

    m_Elements: array of CDXUTElement;  // All display elements

    procedure UpdateRects; virtual;

    procedure SetEnabled(bEnabled: Boolean); virtual; { m_bEnabled = bEnabled; }
    function GetEnabled: Boolean; virtual; { return m_bEnabled; }
    procedure SetVisible(bVisible: Boolean); virtual; { m_bVisible = bVisible; }
    // function GetVisible: Boolean; virtual; { return m_bVisible; }

    // function GetType: LongWord; { return m_Type; } //Clootie: -> property

    // function GetID: Integer; { return m_ID; } //Clootie: -> property
    // procedure SetID(ID: Integer); { m_ID = ID; } //Clootie: -> property

    procedure SetTextColor(Color: TD3DColor); virtual;
    function GetElement(iElement: LongWord): CDXUTElement; { return m_Elements.GetAt( iElement ); }
    procedure SetElement(iElement: LongWord; pElement: CDXUTElement);

    // procedure SetUserData(pUserData: Pointer); { m_pUserData = pUserData; } //Clootie: -> property
    // function GetUserData: Pointer; { return m_pUserData; } //Clootie: -> property

    // procedure SetHotkey(nHotkey: LongWord); { m_nHotkey = nHotkey; } //Clootie: -> property
    // function GetHotkey: LongWord; { return m_nHotkey; } //Clootie: -> property

  public
    constructor Create(pDialog: CDXUTDialog = nil); virtual;
    destructor Destroy; override;

    function OnInit: HRESULT; virtual; { return S_OK; }
    procedure Refresh; virtual;
    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); virtual; { return S_OK; }

    // Windows message handler
    function MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; virtual; { return false; }

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; virtual; { return false; }
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; virtual; { return false; }

    function CanHaveFocus: Boolean; virtual; { return false; }
    procedure OnFocusIn; virtual; { m_bHasFocus = true; }
    procedure OnFocusOut; virtual; { m_bHasFocus = false; }
    procedure OnMouseEnter; virtual; { m_bMouseOver = true; }
    procedure OnMouseLeave; virtual; { m_bMouseOver = false; }
    procedure OnHotkey; virtual; {}

    function ContainsPoint(pt: TPoint): LongBool; virtual; { return PtInRect( &m_rcBoundingBox, pt); virtual;; }

    procedure SetLocation(x, y: Integer); { m_x = x; m_y = y; UpdateRects(); }
    procedure SetSize(width, height: Integer); { m_width = width; m_height = height; UpdateRects(); }

  public
    // Size, scale, and positioning members
    m_x, m_y: Integer;
    m_width, m_height: Integer;

    // These members are set by the container
    m_pDialog: CDXUTDialog;   // Parent container
    m_Index: LongWord;        // Index within the control list

  public
    property Element[i: LongWord]: CDXUTElement read GetElement write SetElement;
    property UserData: Pointer read m_pUserData write m_pUserData;

  published
    property GetType: TDXUTControlType read m_Type;
    property ID: Integer read m_ID write m_ID;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Visible: Boolean read m_bVisible write SetVisible;
    property Default: Boolean read m_bIsDefault write m_bIsDefault;
    property Hotkey: LongWord read m_nHotkey write m_nHotkey;
    property TextColor: TD3DColor write SetTextColor;
  end;


  //-----------------------------------------------------------------------------
  // Static control
  //-----------------------------------------------------------------------------
  CDXUTStatic = class(CDXUTControl)
  protected
    m_strText: array[0..MAX_PATH-1] of WideChar;      // Window text

    function GetText: PWideChar; { return m_strText; }
    procedure SetText(strText: PWideChar);
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;

    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;
    function ContainsPoint(pt: TPoint): LongBool; override; { return false; }
    function GetTextCopy(strDest: PWideChar; bufferCount: LongWord): HRESULT;

    property Text: PWideChar read GetText write SetText;
  end;

  //-----------------------------------------------------------------------------
  // Button control
  //-----------------------------------------------------------------------------
  CDXUTButton = class(CDXUTStatic)
  protected
    m_bPressed: Boolean;
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    procedure OnHotkey; override;

    function ContainsPoint(pt: TPoint): LongBool; override; { return PtInRect( &m_rcBoundingBox, pt ); }
    function CanHaveFocus: Boolean; override; { return (m_bVisible && m_bEnabled); }

    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;
  public
    property Pressed: Boolean read m_bPressed;
  end;

  //-----------------------------------------------------------------------------
  // CheckBox control
  //-----------------------------------------------------------------------------
  CDXUTCheckBox = class(CDXUTButton)
  protected
    m_bChecked: Boolean;
    m_rcButton: TRect;
    m_rcText: TRect;

    function GetChecked: Boolean; virtual;
    procedure SetChecked(bChecked: Boolean); virtual; { SetCheckedInternal( bChecked, false ); }
    procedure SetCheckedInternal(bChecked, bFromInput: Boolean); virtual;
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    procedure OnHotkey; override;

    function ContainsPoint(pt: TPoint): LongBool; override;
    procedure UpdateRects; override;

    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;

  published
    property Checked: Boolean read GetChecked write SetChecked;
  end;

  //-----------------------------------------------------------------------------
  // RadioButton control
  //-----------------------------------------------------------------------------
  CDXUTRadioButton = class(CDXUTCheckBox)
  protected
    m_nButtonGroup: LongWord;

    procedure SetChecked(bChecked: Boolean); overload; override; { SetCheckedInternal(bChecked, True, False); }
    procedure SetCheckedInternal(bChecked, bClearGroup, bFromInput: Boolean); reintroduce; virtual;
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    procedure OnHotkey; override;

    procedure SetChecked(bChecked: Boolean; bClearGroup: Boolean = True); reintroduce; overload; { SetCheckedInternal( bChecked, bClearGroup, false ); }
  published
    property ButtonGroup: LongWord read m_nButtonGroup write m_nButtonGroup;
  end;


  // ARROWSTATE indicates the state of the arrow buttons.
  // CLEAR            No arrow is down.
  // CLICKED_UP       Up arrow is clicked.
  // CLICKED_DOWN     Down arrow is clicked.
  // HELD_UP          Up arrow is held down for sustained period.
  // HELD_DOWN        Down arrow is held down for sustained period.
  TDXUTScrollBar_ArrayState = (CLEAR, CLICKED_UP, CLICKED_DOWN, HELD_UP, HELD_DOWN);

  //-----------------------------------------------------------------------------
  // Scrollbar control
  //-----------------------------------------------------------------------------
  CDXUTScrollBar = class(CDXUTControl)
  protected
    m_bShowThumb: Boolean;
    m_bDrag: Boolean;
    m_rcUpButton: TRect;
    m_rcDownButton: TRect;
    m_rcTrack: TRect;
    m_rcThumb: TRect;
    m_nPosition: Integer;  // Position of the first displayed item
    m_nPageSize: Integer;  // How many items are displayable in one page
    m_nStart: Integer;     // First item
    m_nEnd: Integer;       // The index after the last item
    m_LastMouse: TPoint;   // Last mouse position
    m_Arrow: TDXUTScrollBar_ArrayState; // State of the arrows
    m_dArrowTS: Double;    // Timestamp of last arrow event.

    procedure UpdateThumbRect;
    procedure Cap; // Clips position at boundaries. Ensures it stays within legal range.

    // int GetTrackPos() { return m_nPosition; }
    procedure SetTrackPos(nPosition: Integer); { m_nPosition = nPosition; Cap(); UpdateThumbRect(); }
    // int GetPageSize() { return m_nPageSize; }
    procedure SetPageSize(nPageSize: Integer); { m_nPageSize = nPageSize; Cap(); UpdateThumbRect(); }
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;
    destructor Destroy; override;

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;

    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;
    procedure UpdateRects; override;

    procedure SetTrackRange(nStart, nEnd: Integer);

    procedure Scroll(nDelta: Integer);    // Scroll by nDelta items (plus or minus)
    procedure ShowItem(nIndex: Integer);  // Ensure that item nIndex is displayed, scroll if necessary

    property TrackPos: Integer read m_nPosition write SetTrackPos;
    property PageSize: Integer read m_nPageSize write SetPageSize;
  end;


  //-----------------------------------------------------------------------------
  // ListBox control
  //-----------------------------------------------------------------------------
  PDXUTListBoxItem = ^TDXUTListBoxItem;
  TDXUTListBoxItem = record
    strText: array[0..255] of WideChar;
    pData: Pointer;

    rcActive:  TRect;
    bSelected: Boolean;
  end;

  CDXUTListBox = class(CDXUTControl)
  protected
    m_rcText: TRect;      // Text rendering bound
    m_rcSelection: TRect; // Selection box bound
    m_ScrollBar: CDXUTScrollBar;
    m_nSBWidth: Integer;
    m_nBorder: Integer;
    m_nMargin: Integer;
    m_nTextHeight: Integer;  // Height of a single line of text
    m_dwStyle: TDXUTLBStyle; // List box style
    m_nSelected: Integer;    // Index of the selected item for single selection list box
    m_nSelStart: Integer;    // Index of the item where selection starts (for handling multi-selection)
    m_bDrag: Boolean;        // Whether the user is dragging the mouse to select

    m_Items: TList; // array of PDXUTListBoxItem;

    // DWORD GetStyle() const { return m_dwStyle; }
    function GetSize: Integer; // const { return m_Items.GetSize(); }
    procedure SetStyle(dwStyle: TDXUTLBStyle); { m_dwStyle = dwStyle; }
    procedure SetScrollBarWidth(nWidth: Integer); { m_nSBWidth = nWidth; UpdateRects(); }
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;
    destructor Destroy; override;

    function OnInit: HRESULT; override; { return m_pDialog->InitControl( &m_ScrollBar ); }
    function CanHaveFocus: Boolean; override; { return (m_bVisible && m_bEnabled); }
    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;

    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;
    procedure UpdateRects; override;

    procedure SetBorder(nBorder, nMargin: Integer); { m_nBorder = nBorder; m_nMargin = nMargin; }
    function AddItem(const wszText: PWideChar; pData: Pointer): HRESULT;
    function InsertItem(nIndex: Integer; const wszText: PWideChar; pData: Pointer): HRESULT;
    procedure RemoveItem(nIndex: Integer);
    procedure RemoveItemByText(wszText: PWideChar);
    procedure RemoveItemByData(pData: Pointer);
    procedure RemoveAllItems;

    function GetItem(nIndex: Integer): PDXUTListBoxItem;
    function GetSelectedIndex(nPreviousSelected: Integer = -1): Integer;
    function GetSelectedItem(nPreviousSelected: Integer = -1): PDXUTListBoxItem;  { return GetItem( GetSelectedIndex( nPreviousSelected ) ); }
    procedure SelectItem(nNewIndex: Integer);

    property Items[Index: Integer]: PDXUTListBoxItem read GetItem;

  published
    property ItemIndex: Integer read m_nSelected write SelectItem; // VCL "compatibility" - same as Selected
    property SelectedIndex: Integer read m_nSelected write SelectItem;
    property ScrollBarWidth: Integer read m_nSBWidth write SetScrollBarWidth;
    property Style: TDXUTLBStyle read m_dwStyle write SetStyle;
    property Size: Integer read GetSize;
  end;


  //-----------------------------------------------------------------------------
  // ComboBox control
  //-----------------------------------------------------------------------------
  PDXUTComboBoxItem = ^TDXUTComboBoxItem;
  TDXUTComboBoxItem = record
    strText: array[0..255] of WideChar;
    pData: Pointer;

    rcActive: TRECT;
    bVisible: Boolean;
  end;


  CDXUTComboBox = class(CDXUTButton)
  protected
    m_iSelected: Integer;
    m_iFocused: Integer;
    m_nDropHeight: Integer;
    m_ScrollBar: CDXUTScrollBar;
    m_nSBWidth: Integer;

    m_bOpened: Boolean;

    m_rcText: TRect;
    m_rcButton: TRect;
    m_rcDropdown: TRect;
    m_rcDropdownText: TRect;

    m_Items: array of PDXUTComboBoxItem;

    procedure SetTextColor(Color: TD3DColor); override;

  private
    function GetNumItems: LongWord; { return m_Items.GetSize(); }
    function GetItem(index: LongWord): PDXUTComboBoxItem; { return m_Items.GetAt( index ); }

  public
    constructor Create(pDialog: CDXUTDialog = nil); override;
    destructor Destroy; override;

    function OnInit: HRESULT; override; { return m_pDialog->InitControl( &m_ScrollBar ); }

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override; { return false; }
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override; { return false; }
    procedure OnHotkey; override;

    function CanHaveFocus: Boolean; override; { return (m_bVisible && m_bEnabled); }
    procedure OnFocusOut; override;
    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;

    procedure UpdateRects; override;

    function AddItem(const strText: PWideChar; pData: Pointer): HRESULT;
    procedure RemoveAllItems;
    procedure RemoveItem(index: LongWord);
    function ContainsItem(const strText: PWideChar; iStart: LongWord = 0): Boolean;
    function FindItem(const strText: PWideChar; iStart: LongWord = 0): Integer;
    function GetItemData(const strText: PWideChar): Pointer; overload;
    function GetItemData(nIndex: Integer): Pointer; overload;
    procedure SetDropHeight(nHeight: LongWord); { m_nDropHeight = nHeight; UpdateRects(); }
    procedure SetScrollBarWidth(nWidth: Integer); { m_nSBWidth = nWidth; UpdateRects(); }

    function GetSelectedData: Pointer;
    function GetSelectedItem: PDXUTComboBoxItem;

    function SetSelectedByIndex(index: LongWord): HRESULT;
    function SetSelectedByText(const strText: PWideChar): HRESULT;
    function SetSelectedByData(pData: Pointer): HRESULT;

    property Item[index: LongWord]: PDXUTComboBoxItem read GetItem;

  published
    property NumItems: LongWord read GetNumItems;
    property ScrollBarWidth: Integer read m_nSBWidth write SetScrollBarWidth;
  end;


  //-----------------------------------------------------------------------------
  // Slider control
  //-----------------------------------------------------------------------------
  CDXUTSlider = class(CDXUTControl)
  protected
    m_nValue: Integer;

    m_nMin: Integer;
    m_nMax: Integer;

    m_nDragX: Integer;      // Mouse position at start of drag
    m_nDragOffset: Integer; // Drag offset from the center of the button
    m_nButtonX: Integer;

    m_bPressed: Boolean;
    m_rcButton: TRect;

    procedure SetValueInternal(nValue: Integer; bFromInput: Boolean);
    function ValueFromPos(x: Integer): Integer;

    procedure SetValue(nValue: Integer); { SetValueInternal( nValue, false ); }
    // function GetValue: Integer; { return m_nValue; };
  public
    constructor Create(pDialog: CDXUTDialog = nil); override;

    function ContainsPoint(pt: TPoint): LongBool; override;
    function CanHaveFocus: Boolean; override; { return (m_bVisible && m_bEnabled); }
    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;

    procedure UpdateRects; override;
    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;

    procedure GetRange(out nMin, nMax: Integer); { nMin = m_nMin; nMax = m_nMax; }
    procedure SetRange(nMin, nMax: Integer);

    property Value: Integer read m_nValue write SetValue;
  end;


  //-----------------------------------------------------------------------------
  // CUniBuffer class for the edit control
  //-----------------------------------------------------------------------------
  CUniBuffer = class
  private
    m_pwszBuffer:  PWideChar;    // Buffer to hold text
    m_nBufferSize: Integer;      // Size of the buffer allocated, in characters
    // Uniscribe-specific
    m_pFontNode: PDXUTFontNode;  // Font node for the font that this buffer uses
    m_bAnalyseRequired: Boolean; // True if the string has changed since last analysis.
    m_Analysis: TScriptStringAnalysis; // Analysis for the current string

    function Analyse: HRESULT; // Uniscribe -- Analyse() analyses the string in the buffer

  public
    constructor Create(nInitialSize: Integer = 1);
    destructor Destroy; override;

    class procedure Initialize;
    class procedure Uninitialize;

    // int GetBufferSize() { return m_nBufferSize; }
    function SetBufferSize(nNewSize: Integer): Boolean;
    function GetTextSize: Integer; { return lstrlenW( m_pwszBuffer ); }
    // const WCHAR *GetBuffer() { return m_pwszBuffer; }
    function GetChar(i: Integer): WideChar;
    procedure SetChar(i: Integer; ch: WideChar);
    // const WCHAR &operator[]( int n ) const { return m_pwszBuffer[n]; }
    // WCHAR &operator[]( int n );
    // function GetFontNode: PDXUTFontNode { return m_pFontNode; }
    // void SetFontNode( DXUTFontNode *pFontNode ) { m_pFontNode = pFontNode; }
    procedure Clear;

    function InsertChar(nIndex: Integer; wChar: WideChar): Boolean; // Inserts the char at specified index. If nIndex == -1, insert to the end.
    function RemoveChar(nIndex: Integer): Boolean; // Removes the char at specified index. If nIndex == -1, remove the last char.
    function InsertString(nIndex: Integer; const pStr: PWideChar; nCount: Integer = -1): Boolean; // Inserts the first nCount characters of the string pStr at specified index. If nCount == -1, the entire string is inserted. If nIndex == -1, insert to the end.
    procedure SetText(wszText: PWideChar); // can raise EOutOfMemory

    // Uniscribe
    function CPtoX(nCP: Integer; bTrail: BOOL; out pX: Integer): HRESULT;
    function XtoCP(nX: Integer; out pCP: Integer; out pnTrail: LongBool): HRESULT;
    procedure GetPriorItemPos(nCP: Integer; out pPrior: Integer);
    procedure GetNextItemPos(nCP: Integer; out pPrior: Integer);

    property BufferSize: Integer read m_nBufferSize;
    property Buffer: PWideChar read m_pwszBuffer;
    property Chars[i: Integer]: WideChar read GetChar write SetChar; default;
    property FontNode: PDXUTFontNode read m_pFontNode write m_pFontNode;
    property TextSize: Integer read GetTextSize;
  end;


  //-----------------------------------------------------------------------------
  // EditBox control
  //-----------------------------------------------------------------------------
  CDXUTEditBox = class(CDXUTControl)
  protected
    m_Buffer: CUniBuffer;      // Buffer to hold text
    m_nBorder: Integer;        // Border of the window
    m_nSpacing: Integer;       // Spacing between the text and the edge of border
    m_rcText: TRect;           // Bounding rectangle for the text
    m_rcRender: array[0..8] of TRect; // Convenient rectangles for rendering elements
    m_dfBlink:Double;          // Caret blink time in milliseconds
    m_dfLastBlink: Double;     // Last timestamp of caret blink
    m_bCaretOn: Boolean;       // Flag to indicate whether caret is currently visible
    m_nCaret: Integer;         // Caret position, in characters
    m_bInsertMode: Boolean;    // If true, control is in insert mode. Else, overwrite mode.
    m_nSelStart: Integer;      // Starting position of the selection. The caret marks the end.
    m_nFirstVisible: Integer;  // First visible character in the edit control
    m_TextColor: TD3DColor;    // Text color
    m_SelTextColor: TD3DColor; // Selected text color
    m_SelBkColor: TD3DColor;   // Selected background color
    m_CaretColor: TD3DColor;   // Caret color

    // Mouse-specific
    m_bMouseDrag: Boolean;     // True to indicate drag in progress

    procedure PlaceCaret(nCP: Integer);
    procedure DeleteSelectionText;
    procedure ResetCaretBlink;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;

    procedure SetTextColor(Color: TD3DColor); override; { m_TextColor = Color; }  // Text color

  private
    function GetText: PWideChar; { return m_Buffer.GetBuffer(); }
    procedure SetText_p(wszText: PWideChar);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
    function GetTextLength: Integer; { return m_Buffer.GetTextSize(); }  // Returns text length in chars excluding NULL.

    (* procedure SetSelectedTextColor(Color: TD3DColor); { m_SelTextColor = Color; }  // Selected text color
    procedure SetSelectedBackColor(Color: TD3DColor); { m_SelBkColor = Color; }  // Selected background color
    procedure SetCaretColor(Color: TD3DColor); { m_CaretColor = Color; }  // Caret color *)
    procedure SetBorderWidth(nBorder: Integer); { m_nBorder = nBorder; UpdateRects(); }  // Border of the window
    procedure SetSpacing(nSpacing: Integer); { m_nSpacing = nSpacing; UpdateRects(); }

  public
    constructor Create(pDialog: CDXUTDialog = nil); override;
    destructor Destroy; override;

    function HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    procedure UpdateRects; override;
    function CanHaveFocus: Boolean; override; { return (m_bVisible && m_bEnabled); }
    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;
    procedure OnFocusIn; override;

    procedure SetText(wszText: PWideChar; bSelected: Boolean = False);
    function GetTextCopy(strDest: PWideChar; bufferCount: LongWord): HRESULT;
    procedure ClearText;
    procedure ParseFloatArray(pNumbers: PSingle; nCount: Integer);
    procedure SetTextFloatArray(pNumbers: PSingle; nCount: Integer);

    property Text: PWideChar read GetText write SetText_p;
    property TextColor: TD3DColor read m_TextColor write SetTextColor; // Text color
    property TextLength: Integer read GetTextLength;
    property SelectedTextColor: TD3DColor read m_SelTextColor write m_SelTextColor;  // Selected text color
    property SelectedBackColor: TD3DColor read m_SelBkColor write m_SelBkColor;  // Selected background color
    property CaretColor: TD3DColor read m_CaretColor write m_CaretColor;  // Caret color
    property BorderWidth: Integer read m_nBorder write SetBorderWidth;  // Border of the window
    property Spacing: Integer read m_nSpacing write SetSpacing;
  end;


  //-----------------------------------------------------------------------------
  // IME-enabled EditBox control
  //-----------------------------------------------------------------------------

  TIndicatorEnum = (INDICATOR_NON_IME, INDICATOR_CHS, INDICATOR_CHT, INDICATOR_KOREAN, INDICATOR_JAPANESE);
  TImeState = (IMEUI_STATE_OFF, IMEUI_STATE_ON, IMEUI_STATE_ENGLISH);

  CCandList = record
    awszCandidate: array[0..MAX_CANDLIST-1, 0..255] of WideChar;
    HoriCand: CUniBuffer;      // Candidate list string (for horizontal candidate window)
    nFirstSelected: Integer;   // First character position of the selected string in HoriCand
    nHoriSelectedLen: Integer; // Length of the selected string in HoriCand
    dwCount: DWORD;            // Number of valid entries in the candidate list
    dwSelection: DWORD;        // Currently selected candidate entry relative to page top
    dwPageSize: DWORD;
    nReadingError: Integer;    // Index of the error character
    bShowWindow:  BOOL;        // Whether the candidate list window is visible
    rcCandidate:  TRect;       // Candidate rectangle computed and filled each time before rendered
  end;

  CInputLocale = record
    m_hKL: HKL;            // Keyboard layout
    m_wszLangAbb: array[0..2] of WideChar;  // Language abbreviation
    m_wszLang: array[0..63] of WideChar;    // Localized language name
  end;

  CDXUTIMEEditBox = class(CDXUTEditBox)
  protected
    // Color of various IME elements
    m_ReadingColor:        TD3DColor; // Reading string color
    m_ReadingWinColor:     TD3DColor; // Reading window color
    m_ReadingSelColor:     TD3DColor; // Selected character in reading string
    m_ReadingSelBkColor:   TD3DColor; // Background color for selected char in reading str
    m_CandidateColor:      TD3DColor; // Candidate string color
    m_CandidateWinColor:   TD3DColor; // Candidate window color
    m_CandidateSelColor:   TD3DColor; // Selected candidate string color
    m_CandidateSelBkColor: TD3DColor; // Selected candidate background color
    m_CompColor:           TD3DColor; // Composition string color
    m_CompWinColor:        TD3DColor; // Composition string window color
    m_CompCaretColor:      TD3DColor; // Composition string caret color
    m_CompTargetColor:     TD3DColor; // Composition string target converted color
    m_CompTargetBkColor:   TD3DColor; // Composition string target converted background
    m_CompTargetNonColor:  TD3DColor; // Composition string target non-converted color
    m_CompTargetNonBkColor:TD3DColor; // Composition string target non-converted background
    m_IndicatorImeColor:   TD3DColor; // Indicator text color for IME
    m_IndicatorEngColor:   TD3DColor; // Indicator text color for English
    m_IndicatorBkColor:    TD3DColor; // Indicator text background color

    // Edit-control-specific data
    m_nIndicatorWidth:     Integer;   // Width of the indicator symbol
    m_rcIndicator:         TRect;     // Rectangle for drawing the indicator button

    class function GetLanguage: Word; { return LOWORD( s_hklCurrent ); }
    class function GetPrimaryLanguage: Word; { return PRIMARYLANGID( LOWORD( s_hklCurrent ) ); }
    class function GetSubLanguage: Word; { return SUBLANGID( LOWORD( s_hklCurrent ) ); }
    class procedure SendKey(nVirtKey: Byte);
    class function GetImeId(uIndex: LongWord = 0): DWORD;
    class procedure CheckInputLocale();
    class procedure CheckToggleState;
    class procedure SetupImeApi;
    class procedure ResetCompositionString;
    procedure TruncateCompString(bUseBackSpace: Boolean = True; iNewStrLen: Integer = 0);
    procedure FinalizeString(bSend: Boolean);
    class procedure GetReadingWindowOrientation(dwId: DWORD);
    class procedure GetPrivateReadingString;

    procedure SendCompString;

  public
    constructor Create(pDialog: CDXUTDialog = nil); override;
    destructor Destroy; override;

    class procedure Initialize;
    class procedure Uninitialize;
    
    class function StaticOnCreateDevice: HRESULT;
    class function StaticMsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): BOOL;

    class procedure EnableImeSystem(bEnable: Boolean);

    procedure Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); override;
    function MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    function HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean; override;
    procedure UpdateRects; override;
    procedure OnFocusIn; override;
    procedure OnFocusOut; override;

    procedure PumpMessage;

    procedure RenderCandidateReadingWindow(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single; bReading: Boolean); virtual;
    procedure RenderComposition(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); virtual;
    procedure RenderIndicator(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single); virtual;
  end;

const
  MAX_CONTROL_STATES = {6} Ord(High(TDXUTControlState))+1;

const
  WM_XBUTTONDOWN   = $020B; // (not always defined)
  WM_XBUTTONUP     = $020C; // (not always defined)
  WM_XBUTTONDBLCLK = $020D;
  WM_MOUSEWHEEL    = $020A; // (not always defined)
  WHEEL_DELTA      = 120;   // (not always defined)

  MK_XBUTTON1         = $0020;
  MK_XBUTTON2         = $0040;

implementation

uses
  SysUtils, StrSafe, Math,
  DXUT, DXUTcore, DXUTmisc, DXUTRes;

const
  UnitName = 'DXUTgui.pas';

//--------------------------------------------------------------------------------------
// File: DXUTgui.cpp
//
// Desc:
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

const
  // Minimum scroll bar thumb size
  SCROLLBAR_MINTHUMBSIZE = 8;

  // Delay and repeat period when clicking on the scroll bar arrows
  SCROLLBAR_ARROWCLICK_DELAY  = 0.33;
  SCROLLBAR_ARROWCLICK_REPEAT = 0.05;

  UNISCRIBE_DLLNAME = '\usp10.dll';

{ #define GETPROCADDRESS( Module, APIName, Temp ) \
    Temp = GetProcAddress( Module, #APIName ); \
    if( Temp ) \
        *(FARPROC* )&_##APIName = Temp

#define PLACEHOLDERPROC( APIName ) \
    _##APIName = Dummy_##APIName }


  // DXUT_MAX_EDITBOXLENGTH is the maximum string length allowed in edit boxes,
  // including the NULL terminator.
  //
  // Uniscribe does not support strings having bigger-than-16-bits length.
  // This means that the string must be less than 65536 characters long,
  // including the NULL terminator.
  DXUT_MAX_EDITBOXLENGTH = $FFFF;


var
  s_fTimeRefresh: Double = 0.0;            // static CDXUTDialog::s_fTimeRefresh
  s_pControlFocus: CDXUTControl     = nil; // static CDXUTDialog::s_pControlFocus // The control which has focus
  s_pControlPressed: CDXUTControl   = nil; // static CDXUTDialog::s_pControlPressed // The control currently pressed


type
  TDXUTScreenVertex = record
    x, y, z, h: Single;
    color: TD3DColor;
    tu, tv: Single;
  end;
const
  TDXUTScreenVertex_FVF = D3DFVF_XYZRHW or D3DFVF_DIFFUSE or D3DFVF_TEX1;

function DXUTScreenVertex(x, y, z, h: Single; color: TD3DColor; tu, tv: Single): TDXUTScreenVertex;
begin
  Result.x:= x; Result.y:= y; Result.z:= z; Result.h:= h;
  Result.color:= color;
  Result.tu:= tu; Result.tv:= tv;
end;

type
  TDXUTScreenVertexUntex = record
    x, y, z, h: Single;
    color: TD3DColor;
  end;
const
  TDXUTScreenVertexUntex_FVF = D3DFVF_XYZRHW or D3DFVF_DIFFUSE;

function DXUTScreenVertexUntex(x, y, z, h: Single; color: TD3DColor): TDXUTScreenVertexUntex;
begin
  Result.x:= x; Result.y:= y; Result.z:= z; Result.h:= h;
  Result.color:= color;
end;


function RectWidth(const prc: TRect): Integer; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF} begin Result:= prc.right - prc.left; end;
function RectHeight(const prc: TRect): Integer;{$IFDEF SUPPORTS_INLINE}inline;{$ENDIF} begin Result:= prc.bottom - prc.top; end;


//--------------------------------------------------------------------------------------
procedure TDXUTBlendColor.Init(defaultColor: TD3DColor; disabledColor: TD3DColor = $C8808080 {D3DCOLOR_ARGB(200, 128, 128, 128)}; hiddenColor: TD3DColor = 0);
var
  i: TDXUTControlState;
begin
  for i:= Low(TDXUTControlState) to High(TDXUTControlState) do
  begin
    States[i] := defaultColor;
  end;

  States[DXUT_STATE_DISABLED] := disabledColor;
  States[DXUT_STATE_HIDDEN] := hiddenColor;
  Current := D3DXColorFromDWord(hiddenColor);
end;

//--------------------------------------------------------------------------------------
procedure TDXUTBlendColor.Blend(iState: TDXUTControlState; fElapsedTime: Single; fRate: Single = 0.7);
var
  destColor: TD3DXColor;
begin
  destColor := D3DXColorFromDWord(States[iState]);
  D3DXColorLerp(Current, Current, destColor, 1.0 - Power(fRate, 30 * fElapsedTime));
end;


//--------------------------------------------------------------------------------------
constructor CDXUTElement.Create;
begin
  TextureColor:= TDXUTBlendColor.Create;
  FontColor:= TDXUTBlendColor.Create;
end;

destructor CDXUTElement.Destroy;
begin
  TextureColor.Free;
  FontColor.Free;
  inherited;
end;

procedure CDXUTElement.AssignTo(Dest: TPersistent);
begin
  if Dest is CDXUTElement then
    with CDXUTElement(Dest) do
    begin
      iTexture:= Self.iTexture;
      iFont:= Self.iFont;
      dwTextFormat:= Self.dwTextFormat;

      rcTexture:= Self.rcTexture;

      TextureColor.States:= Self.TextureColor.States;
      TextureColor.Current:= Self.TextureColor.Current;
      FontColor.States:= Self.FontColor.States;
      FontColor.Current:= Self.FontColor.Current;
    end
  else inherited AssignTo(Dest);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTElement.SetTexture(iTexture: LongWord; prcTexture: PRect; defaultTextureColor: TD3DColor = $FFFFFFFF);
begin
  Self.iTexture := iTexture;

  if (prcTexture <> nil)
  then rcTexture := prcTexture^
  else SetRectEmpty(rcTexture);

  TextureColor.Init(defaultTextureColor);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTElement.SetFont(iFont: LongWord; defaultFontColor: TD3DColor = $FFFFFFFF; dwTextFormat: DWORD = DT_CENTER or DT_VCENTER);
begin
  Self.iFont := iFont;
  Self.dwTextFormat := dwTextFormat;

  FontColor.Init(defaultFontColor);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTElement.Refresh;
begin
  TextureColor.Current := D3DXColorFromDWord(TextureColor.States[DXUT_STATE_HIDDEN]);
  FontColor.Current := D3DXColorFromDWord(FontColor.States[DXUT_STATE_HIDDEN]);
end;



//--------------------------------------------------------------------------------------
// CDXUTDialogManager class
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
constructor CDXUTDialog.Create;
begin
  inherited;

  m_x := 0;
  m_y := 0;
  m_width := 0;
  m_height := 0;

  m_pManager := nil;
  m_bVisible := True;
  m_bCaption := False;
  m_bMinimized := False;
  m_bDrag := False;
  m_wszCaption[0] := #0;
  m_nCaptionHeight := 18;

  m_colorTopLeft := 0;
  m_colorTopRight := 0;
  m_colorBottomLeft := 0;
  m_colorBottomRight := 0;

  m_pCallbackEvent := nil;
  m_pCallbackEventUserContext := nil;

  m_fTimeLastRefresh := 0;

  m_pControlMouseOver := nil;

  m_pNextDialog := Self;
  m_pPrevDialog := Self;

  m_nDefaultControlID := $ffff;
  m_bNonUserEvents := False;
  m_bKeyboardInput := False;
  m_bMouseInput := True;

  m_CapElement:= CDXUTElement.Create;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTDialog.Destroy;
var
  i: Integer;
  pElementHolder: PDXUTElementHolder;
begin
  RemoveAllControls;
  m_Fonts := nil; // RemoveAll
  m_Textures := nil; // RemoveAll

  for i:= 0 to Length(m_DefaultElements) - 1 do
  begin
    pElementHolder := m_DefaultElements[i];
    Dispose(pElementHolder);
  end;

  m_DefaultElements := nil; // RemoveAll;

  FreeAndNil(m_CapElement);
  inherited;
end;

{$IFDEF FPC}
type
  MakeIntResourceW = PWideChar;
{$ENDIF FPC}

//--------------------------------------------------------------------------------------
procedure CDXUTDialog.Init(pManager: CDXUTDialogResourceManager; bRegisterDialog: Boolean = True);
begin
  m_pManager := pManager;
  if bRegisterDialog then pManager.RegisterDialog(Self);
  SetTexture(0, MakeIntResourceW($FFFF), HMODULE($FFFF));
  InitDefaultElements;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.Init(pManager: CDXUTDialogResourceManager; bRegisterDialog: Boolean; const pszControlTextureFilename: PWideChar);
begin
  m_pManager := pManager;
  if bRegisterDialog then pManager.RegisterDialog(Self);
  SetTexture(0, pszControlTextureFilename);
  InitDefaultElements;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.Init(pManager: CDXUTDialogResourceManager; bRegisterDialog: Boolean; szControlTextureResourceName: PWideChar; hControlTextureResourceModule: HMODULE);
begin
  m_pManager := pManager;
  if bRegisterDialog then pManager.RegisterDialog(Self);
  SetTexture(0, szControlTextureResourceName, hControlTextureResourceModule);
  InitDefaultElements;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.SetCallback(pCallback: PCallbackDXUTguiEvent; pUserContext: Pointer = nil);
begin
  // If this assert triggers, you need to call CDXUTDialog::Init() first.  This change
  // was made so that the DXUT's GUI could become seperate and optional from DXUT's core.  The
  // creation and interfacing with CDXUTDialogResourceManager is now the responsibility
  // of the application if it wishes to use DXUT's GUI.
  Assert((m_pManager <> nil), 'To fix call CDXUTDialog.Init() first.  See comments for details.');

  m_pCallbackEvent := pCallback;
  m_pCallbackEventUserContext := pUserContext;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.RemoveControl(ID: Integer);
var
  i: Integer;
  pControl: CDXUTControl;
begin
  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];
    if (pControl.ID = ID) then
    begin
      // Clean focus first
      ClearFocus;

      // Clear references to this control
      if (s_pControlFocus = pControl) then s_pControlFocus := nil;
      if (s_pControlPressed = pControl) then s_pControlPressed := nil;
      if (m_pControlMouseOver = pControl) then m_pControlMouseOver := nil;

      pControl.Free;
      // m_Controls.Remove( i );
      if Length(m_Controls) <> i+1 // not last element
      then Move(m_Controls[i+1], m_Controls[i], SizeOf(pControl)*(Length(m_Controls)-i-1));
      SetLength(m_Controls, Length(m_Controls)-1);

      Exit;
    end;
  end;
end;

//--------------------------------------------------------------------------------------
procedure CDXUTDialog.RemoveAllControls;
var
  i: Integer;
  pControl: CDXUTControl;
begin
  if (s_pControlFocus<>nil) and (s_pControlFocus.m_pDialog = Self) then s_pControlFocus := nil;
  if (s_pControlPressed<>nil) and (s_pControlPressed.m_pDialog = Self) then s_pControlPressed := nil;
  m_pControlMouseOver := nil;

  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];
    pControl.Free;
  end;

  m_Controls := nil; // RemoveAll;
end;

procedure CDXUTDialog.EnableNonUserEvents(bEnable: Boolean);
begin m_bNonUserEvents := bEnable; end;

procedure CDXUTDialog.EnableKeyboardInput(bEnable: Boolean);
begin m_bKeyboardInput := bEnable; end;

procedure CDXUTDialog.EnableMouseInput(bEnable: Boolean);
begin m_bMouseInput := bEnable; end;

//--------------------------------------------------------------------------------------
constructor CDXUTDialogResourceManager.Create;
begin
  m_Dialogs := TList.Create;
   
  m_pd3dDevice := nil;
  m_pStateBlock := nil;
  m_pSprite := nil;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTDialogResourceManager.Destroy;
var
  i: Integer;
  pFontNode: PDXUTFontNode;
  pTextureNode: PDXUTTextureNode;
begin
  for i:= 0 to Length(m_FontCache) - 1 do
  begin
    pFontNode := m_FontCache[i];
    Dispose(pFontNode);
  end;
  m_FontCache:= nil; // RemoveAll

  for i:= 0 to Length(m_TextureCache) - 1 do
  begin
    pTextureNode := m_TextureCache[i];
    Dispose(pTextureNode);
  end;
  m_TextureCache:= nil; // RemoveAll

  FreeAndNil(m_Dialogs);

  CUniBuffer.Uninitialize;
  CDXUTIMEEditBox.Uninitialize;
end;


function CDXUTDialogResourceManager.GetFontNode(iIndex: Integer): PDXUTFontNode;
begin Result:= m_FontCache[iIndex]; end;

function CDXUTDialogResourceManager.GetTextureNode(iIndex: Integer): PDXUTTextureNode;
begin Result:= m_TextureCache[iIndex]; end;

//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.OnCreateDevice(const pd3dDevice: IDirect3DDevice9): HRESULT;
var
  i: Integer;
begin
  Result:= S_OK;
  m_pd3dDevice := pd3dDevice;
  try
    for i:= 0 to Length(m_FontCache) - 1 do
    begin
      Result := CreateFont(i);
      if FAILED(Result) then Exit;
    end;

    for i:= 0 to Length(m_TextureCache) - 1 do
    begin
      Result := CreateTexture(i);
      if FAILED(Result) then Exit;
    end;

    Result := D3DXCreateSprite(pd3dDevice, m_pSprite);
    if FAILED(Result) then
    begin
      Result:= DXUT_ERR('D3DXCreateSprite', Result);
      Exit;
    end;

    // Call CDXUTIMEEditBox's StaticOnCreateDevice()
    // to initialize certain window-dependent data.
    CDXUTIMEEditBox.StaticOnCreateDevice;

    Result:= S_OK;
  finally
    if FAILED(Result) then OnDestroyDevice;
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.OnResetDevice: HRESULT;
var
  i: Integer;
  pFontNode: PDXUTFontNode;
  pd3dDevice: IDirect3DDevice9;
begin
  for i:= 0 to Length(m_FontCache) - 1 do
  begin
    pFontNode := m_FontCache[i];
    if (pFontNode.pFont <> nil) then pFontNode.pFont.OnResetDevice;
  end;

  if (m_pSprite <> nil) then m_pSprite.OnResetDevice;

  //todo: Fill bug report to MS: why use DXUTGetD3DDevice if we introduced special m_pd3dDevice class member?
  pd3dDevice := DXUTGetD3DDevice;

  Result:= pd3dDevice.CreateStateBlock(D3DSBT_ALL, m_pStateBlock);
  if V_FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  // Let the CDXUTIMEEditBox's static message proc handle the msg.
  // This is because some IME messages must be handled to ensure
  // proper functionalities and the static msg proc ensures that
  // this happens even if no control has the input focus.
  Result:= CDXUTIMEEditBox.StaticMsgProc(uMsg, wParam, lParam);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTDialogResourceManager.OnLostDevice;
var
  i: Integer;
  pFontNode: PDXUTFontNode;
begin
  for i:= 0 to Length(m_FontCache) - 1 do
  begin
    pFontNode := m_FontCache[i];
    if (pFontNode.pFont <> nil) then pFontNode.pFont.OnLostDevice;
  end;

  if (m_pSprite <> nil) then m_pSprite.OnLostDevice;

  m_pStateBlock := nil;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialogResourceManager.OnDestroyDevice;
var
  i: Integer;
  pFontNode: PDXUTFontNode;
  pTextureNode: PDXUTTextureNode;
begin
  m_pd3dDevice := nil;

  // Release the resources but don't clear the cache, as these will need to be
  // recreated if the device is recreated
  for i:= 0 to Length(m_FontCache) - 1 do
  begin
    pFontNode := m_FontCache[i];
    pFontNode.pFont := nil;
  end;
  if (m_pSprite <> nil) then m_pSprite.OnLostDevice;

  for i:= 0 to Length(m_TextureCache) - 1 do
  begin
    pTextureNode := m_TextureCache[i];
    pTextureNode.pTexture := nil;
  end;

  m_pSprite := nil;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.RegisterDialog(pDialog: CDXUTDialog): Boolean;
var
  i: Integer;
begin
  Result:= True;

  // Check that the dialog isn't already registered.
  for i := 0 to m_Dialogs.Count - 1 do
    if (m_Dialogs[i] = pDialog) then Exit;

  // Add to the list.
  try
    m_Dialogs.Add(pDialog);
  except
    Result:= False;
    Exit;
  end;

  // Set up next and prev pointers.
  if (m_Dialogs.Count > 1)
  then CDXUTDialog(m_Dialogs[m_Dialogs.Count - 2]).SetNextDialog(pDialog);
  CDXUTDialog(m_Dialogs[m_Dialogs.Count - 1]).SetNextDialog(m_Dialogs[0]);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialogResourceManager.UnregisterDialog(pDialog: CDXUTDialog);
var
  i: Integer;
  l, r: Integer;
begin
  // Search for the dialog in the list.
  for i := 0 to m_Dialogs.Count - 1 do
    if (m_Dialogs[i] = pDialog) then
    begin
      m_Dialogs.Delete(i);
      
      if (m_Dialogs.Count > 0) then
      begin
        if (i = 0)
        then l := m_Dialogs.Count - 1
        else l := i - 1;

        if (m_Dialogs.Count = i)
        then r := 0
        else r := i;

        CDXUTDialog(m_Dialogs[l]).SetNextDialog(m_Dialogs[r]);
      end;
      Break;
    end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialogResourceManager.EnableKeyboardInputForAllDialogs;
var
  i: Integer;
begin
  // Enable keyboard input for all registered dialogs
  for i := 0 to m_Dialogs.Count - 1 do
    CDXUTDialog(m_Dialogs[i]).EnableKeyboardInput(True);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.Refresh;
var
  i: Integer;
begin
  if (s_pControlFocus <> nil) then s_pControlFocus.OnFocusOut;

  if (m_pControlMouseOver <> nil) then m_pControlMouseOver.OnMouseLeave;

  s_pControlFocus := nil;
  s_pControlPressed := nil;
  m_pControlMouseOver := nil;

  for i:= 0 to Length(m_Controls) - 1 do
  begin
    m_Controls[i].Refresh;
  end;

  if m_bKeyboardInput then FocusDefaultControl;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.OnRender(fElapsedTime: Single): HRESULT;
var
  pd3dDevice: IDirect3DDevice9;
  pTextureNode: PDXUTTextureNode;
  rc: TRect;
  wszOutput: array[0..255] of WideChar;
  pControl: CDXUTControl;
  i: Integer;
  bBackgroundIsVisible: Boolean;
  vertices: array[0..3] of TDXUTScreenVertexUntex;
begin
  // If this assert triggers, you need to call CDXUTDialogResourceManager::On*Device() from inside
  // the application's device callbacks.  See the SDK samples for an example of how to do this.
  Assert(Assigned(m_pManager.D3DDevice) and Assigned(m_pManager.m_pStateBlock), 'To fix hook up CDXUTDialogResourceManager to device callbacks. See comments for details.');

  // See if the dialog needs to be refreshed
  if (m_fTimeLastRefresh < s_fTimeRefresh) then
  begin
    m_fTimeLastRefresh := DXUTGetTime;
    Refresh;
  end;

  // For invisible dialog, out now.
  if not m_bVisible or (m_bMinimized and not m_bCaption) then
  begin
    Result:= S_OK;
    Exit;
  end;

{  vertices[0]:= DXUTScreenVertex(m_x,           m_y,            0.5, 1.0, m_colorTopLeft,     0.0, 0.5);
  vertices[1]:= DXUTScreenVertex(m_x + m_width, m_y,            0.5, 1.0, m_colorTopRight,    1.0, 0.5);
  vertices[2]:= DXUTScreenVertex(m_x + m_width, m_y + m_height, 0.5, 1.0, m_colorBottomRight, 1.0, 1.0);
  vertices[3]:= DXUTScreenVertex(m_x,           m_y + m_height, 0.5, 1.0, m_colorBottomLeft,  0.0, 1.0);
}
  pd3dDevice := Manager.D3DDevice;

  // Set up a state block here and restore it when finished drawing all the controls
  Manager.m_pStateBlock.Capture;

  pd3dDevice.SetRenderState(D3DRS_ALPHABLENDENABLE, iTrue);
  pd3dDevice.SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
  pd3dDevice.SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
  pd3dDevice.SetRenderState(D3DRS_ALPHATESTENABLE, iFalse);
  pd3dDevice.SetRenderState(D3DRS_SEPARATEALPHABLENDENABLE, iFalse);
  pd3dDevice.SetRenderState(D3DRS_BLENDOP, D3DBLENDOP_ADD);
  pd3dDevice.SetRenderState(D3DRS_COLORWRITEENABLE, D3DCOLORWRITEENABLE_ALPHA or D3DCOLORWRITEENABLE_BLUE or D3DCOLORWRITEENABLE_GREEN or D3DCOLORWRITEENABLE_RED);
  pd3dDevice.SetRenderState(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);
  pd3dDevice.SetRenderState(D3DRS_FOGENABLE, iFalse);
  pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE, iFalse);
  pd3dDevice.SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
  pd3dDevice.SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW);

  pd3dDevice.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG2);
  pd3dDevice.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_DIFFUSE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_RESULTARG, D3DTA_CURRENT);
  pd3dDevice.SetTextureStageState(1, D3DTSS_COLOROP, D3DTOP_DISABLE);
  pd3dDevice.SetTextureStageState(1, D3DTSS_ALPHAOP, D3DTOP_DISABLE);

  bBackgroundIsVisible := ((m_colorTopLeft or m_colorTopRight or m_colorBottomRight or m_colorBottomLeft) and $FF000000) <> 0;
  if (not m_bMinimized and bBackgroundIsVisible) then
  begin
    vertices[0]:= DXUTScreenVertexUntex(m_x,           m_y,            0.5, 1.0, m_colorTopLeft);
    vertices[1]:= DXUTScreenVertexUntex(m_x + m_width, m_y,            0.5, 1.0, m_colorTopRight);
    vertices[2]:= DXUTScreenVertexUntex(m_x + m_width, m_y + m_height, 0.5, 1.0, m_colorBottomRight);
    vertices[3]:= DXUTScreenVertexUntex(m_x,           m_y + m_height, 0.5, 1.0, m_colorBottomLeft);

    pd3dDevice.SetVertexShader(nil);
    pd3dDevice.SetPixelShader(nil);

    pd3dDevice.SetRenderState(D3DRS_ZENABLE, iFalse);

    pd3dDevice.SetFVF(TDXUTScreenVertexUntex_FVF);
    pd3dDevice.DrawPrimitiveUP(D3DPT_TRIANGLEFAN, 2, vertices, SizeOf(TDXUTScreenVertexUntex));
  end;

  pd3dDevice.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);

  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_DIFFUSE);

  pd3dDevice.SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);

  pTextureNode := GetTexture(0);
  pd3dDevice.SetTexture(0, pTextureNode.pTexture);

  Manager.m_pSprite._Begin(D3DXSPRITE_DONOTSAVESTATE);

  // Render the caption if it's enabled.
  if (m_bCaption) then
  begin
    // DrawSprite will offset the rect down by
    // m_nCaptionHeight, so adjust the rect higher
    // here to negate the effect.
    rc := Rect(0, -m_nCaptionHeight, m_width, 0);
    DrawSprite(m_CapElement, rc);
    Inc(rc.left, 5); // Make a left margin
    StringCchCopy(wszOutput, 256, m_wszCaption);
    if (m_bMinimized) then
      StringCchCat(wszOutput, 256, PWideChar(WideString(' (Minimized)')));
    DrawText(wszOutput, m_CapElement, rc, True);
  end;

  // If the dialog is minimized, skip rendering
  // its controls.
  if (not m_bMinimized) then
  begin
    for i:= 0 to Length(m_Controls) - 1 do
    begin
      pControl := m_Controls[i];

      // Focused control is drawn last
      if (pControl = s_pControlFocus) then Continue;

      pControl.Render(pd3dDevice, fElapsedTime);
    end;

    if (s_pControlFocus <> nil) and (s_pControlFocus.m_pDialog = Self)
    then s_pControlFocus.Render(pd3dDevice, fElapsedTime);
  end;

  Manager.m_pSprite._End;

  Manager.m_pStateBlock.Apply;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.SendEvent(nEvent: LongWord; bTriggeredByUser: Boolean; pControl: CDXUTControl);
begin
  // If no callback has been registered there's nowhere to send the event to
  if (@m_pCallbackEvent = nil) then Exit;

  // Discard events triggered programatically if these types of events haven't been
  // enabled
  if (not bTriggeredByUser and not m_bNonUserEvents) then Exit;

  m_pCallbackEvent(nEvent, pControl.ID, pControl, m_pCallbackEventUserContext);
end;


//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.AddFont(strFaceName: PWideChar; height, weight: Longint): Integer;
var
  i: Integer;
  pFontNode: PDXUTFontNode;
  pNewFontNode: PDXUTFontNode;
  iFont: Integer;
  // nLen: size_t;
begin
  // See if this font already exists
  for i:= 0 to Length(m_FontCache) - 1 do
  begin
    pFontNode := m_FontCache[i];
    // StringCchLength(strFaceName, MAX_PATH, nLen);
    if (0 = lstrcmpiW(pFontNode.strFace, strFaceName{, nLen})) and
       (pFontNode.nHeight = height) and
       (pFontNode.nWeight = weight) then
    begin
      Result:= i;
      Exit;
    end;
  end;

  // Add a new font and try to create it
  try
    New(pNewFontNode);
  except
    Result:= -1;
    Exit;
  end;

  ZeroMemory(pNewFontNode, SizeOf(TDXUTFontNode));
  StringCchCopy(pNewFontNode.strFace, MAX_PATH, strFaceName);
  pNewFontNode.nHeight := height;
  pNewFontNode.nWeight := weight;

  // m_FontCache.Add(pNewFontNode);
  iFont := Length(m_FontCache);
  SetLength(m_FontCache, iFont+1);
  m_FontCache[iFont]:= pNewFontNode;

  // If a device is available, try to create immediately
  if (m_pd3dDevice <> nil) then CreateFont(iFont);

  Result:= iFont;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.SetFont(index: LongWord; strFaceName: PWideChar; height, weight: Longint): HRESULT;
var
  i, l, iFont: Integer;
begin
  // If this assert triggers, you need to call CDXUTDialog::Init() first.  This change
  // was made so that the DXUT's GUI could become seperate and optional from DXUT's core.  The
  // creation and interfacing with CDXUTDialogResourceManager is now the responsibility
  // of the application if it wishes to use DXUT's GUI.
  Assert(Assigned(Manager), 'To fix call CDXUTDialog.Init() first. See comments for details.');

  // Make sure the list is at least as large as the index being set
  l:= Length(m_Fonts);
  if l <= Integer(index) then
  begin
    SetLength(m_Fonts, index+1);
    for i:= l to index do m_Fonts[i]:= -1;
  end;

  iFont := Manager.AddFont(strFaceName, height, weight);
  m_Fonts[index]:= iFont;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetFont(index: LongWord): PDXUTFontNode;
begin
  if (Manager = nil) then
  begin
    Result:= nil;
    Exit;
  end;

  Result:= Manager.FontNode[m_Fonts[index]];
end;


//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.AddTexture(strFilename: PWideChar): Integer;
var
  i: Integer;
  pTextureNode, pNewTextureNode: PDXUTTextureNode;
  iTexture: Integer;
  nLen: size_t;
begin
  // See if this texture already exists
  for i:= 0 to Length(m_TextureCache) - 1 do
  begin
    pTextureNode := m_TextureCache[i];
    StringCchLength(strFilename, MAX_PATH, nLen);
    if pTextureNode.bFileSource and // Sources must match
       // (0 = _wcsnicmp(pTextureNode.strFilename, strFilename, nLen)) then
       (0 =  lstrcmpiW(pTextureNode.strFilename, strFilename)) then
    begin
      Result:= i;
      Exit;
    end;
  end;

  // Add a new texture and try to create it
  try
    New(pNewTextureNode);
  except
    Result:= -1;
    Exit;
  end;

  ZeroMemory(pNewTextureNode, SizeOf(TDXUTTextureNode));
  pNewTextureNode.bFileSource := True;
  StringCchCopy(pNewTextureNode.strFilename, MAX_PATH, strFilename);

  //m_TextureCache.Add(pNewTextureNode);
  iTexture := Length(m_TextureCache);
  SetLength(m_TextureCache, iTexture+1);
  m_TextureCache[iTexture]:= pNewTextureNode;

  // If a device is available, try to create immediately
  if (m_pd3dDevice <> nil) then CreateTexture(iTexture);

  Result:= iTexture;
end;


function IS_INTRESOURCE(_r: Pointer): Boolean;
begin
  Result:= ((ULONG_PTR(_r) shr 16) = 0);
end;

//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.AddTexture(strResourceName: PWideChar; hResourceModule: HMODULE): Integer;
var
  i: Integer;
  pTextureNode, pNewTextureNode: PDXUTTextureNode;
  iTexture: Integer;
  nLen: size_t;
begin
  // See if this texture already exists
  for i:= 0 to Length(m_TextureCache) - 1 do
  begin
    pTextureNode := m_TextureCache[i];
    if not pTextureNode.bFileSource and      // Sources must match
       (pTextureNode.hResourceModule = hResourceModule) then // Module handles must match
    begin
      if IS_INTRESOURCE(strResourceName) then
      begin
        // Integer-based ID
        if (INT_PTR(strResourceName) = pTextureNode.nResourceID) then
        begin
          Result:= i;
          Exit;
        end;
      end else
      begin
        // String-based ID
        StringCchLength(strResourceName, MAX_PATH, nLen);
        // if (0 = _wcsnicmp(pTextureNode.strFilename, strResourceName, nLen)) then
        if (0 = lstrcmpiW(pTextureNode.strFilename, strResourceName{, nLen})) then
        begin
          Result:= i;
          Exit;
        end;
      end;
    end;
  end;

  // Add a new texture and try to create it
  try
    New(pNewTextureNode);
  except
    Result:= -1;
    Exit;
  end;

  ZeroMemory(pNewTextureNode, SizeOf(TDXUTTextureNode));
  pNewTextureNode.hResourceModule := hResourceModule;
  if IS_INTRESOURCE(strResourceName)
  then pNewTextureNode.nResourceID := Integer(size_t(strResourceName))
  else
  begin
    pNewTextureNode.nResourceID := 0;
    StringCchCopy(pNewTextureNode.strFilename, MAX_PATH, strResourceName);
  end;

  //m_TextureCache.Add(pNewTextureNode);
  iTexture := Length(m_TextureCache);
  SetLength(m_TextureCache, iTexture+1);
  m_TextureCache[iTexture]:= pNewTextureNode;

  // If a device is available, try to create immediately
  if (m_pd3dDevice <> nil) then CreateTexture(iTexture);

  Result:= iTexture;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.SetTexture(index: LongWord; strFilename: PWideChar): HRESULT;
var
  i, l, iTexture: Integer;
begin
  // If this assert triggers, you need to call CDXUTDialog::Init() first.  This change
  // was made so that the DXUT's GUI could become seperate and optional from DXUT's core.  The
  // creation and interfacing with CDXUTDialogResourceManager is now the responsibility
  // of the application if it wishes to use DXUT's GUI.
  Assert(Assigned(Manager), 'To fix this, call CDXUTDialog::Init() first. See comments for details.');

  // Make sure the list is at least as large as the index being set
  l:= Length(m_Textures);
  if l <= Integer(index) then
  begin
    SetLength(m_Textures, index+1);
    for i:= l to index do m_Textures[i]:= -1;
  end;

  iTexture := Manager.AddTexture(strFilename);

  m_Textures[index]:= iTexture;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.SetTexture(index: LongWord; strResourceName: PWideChar; hResourceModule: HMODULE): HRESULT;
var
  i, L: LongWord;
  iTexture: Integer;
begin
  // If this assert triggers, you need to call CDXUTDialog::Init() first.  This change
  // was made so that the DXUT's GUI could become seperate and optional from DXUT's core.  The
  // creation and interfacing with CDXUTDialogResourceManager is now the responsibility
  // of the application if it wishes to use DXUT's GUI.
  Assert(Assigned(Manager), 'To fix this, call CDXUTDialog::Init() first.  See comments for details.');

  // Make sure the list is at least as large as the index being set
  L:= Length(m_Textures);
  if (L >= index) then
  begin
    SetLength(m_Textures, index+1);
    for i:= L to index do m_Textures[i]:= -1;
  end;

  iTexture := m_pManager.AddTexture(strResourceName, hResourceModule);

  m_Textures[index] := iTexture;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetTexture(index: LongWord): PDXUTTextureNode;
begin
  if (Manager = nil) then
  begin
    Result:= nil;
    Exit;
  end;

  Result:= Manager.GetTextureNode(m_Textures[index]);
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
var
  bHandled: Boolean;
  mousePoint: TPoint;
  i: Integer;
  pControl: CDXUTControl;
  bShiftDown: Boolean;
begin
  Result:= True;

  // For invisible dialog, do not handle anything.
  if not m_bVisible then
  begin
    Result:= False;
    Exit;
  end;

  // If automation command-line switch is on, enable this dialog's keyboard input
  // upon any key press or mouse click.
  if DXUTGetAutomation and
    ((WM_LBUTTONDOWN = uMsg) or (WM_LBUTTONDBLCLK = uMsg) or (WM_KEYDOWN = uMsg)) then
  begin
    m_pManager.EnableKeyboardInputForAllDialogs;
  end;

  // If caption is enable, check for clicks in the caption area.
  if (m_bCaption) then
  begin
    if (uMsg = WM_LBUTTONDOWN) or (uMsg = WM_LBUTTONDBLCLK) then
    begin
      mousePoint := Point(short(LOWORD(DWORD(lParam))), short(HIWORD(DWORD(lParam))));

      if (mousePoint.x >= m_x) and (mousePoint.x < m_x + m_width) and
         (mousePoint.y >= m_y) and (mousePoint.y < m_y + m_nCaptionHeight) then
      begin
        m_bDrag := True;
        SetCapture(DXUTGetHWND);
        Exit;
      end;
    end else
    if (uMsg = WM_LBUTTONUP) and m_bDrag then
    begin
      mousePoint := Point(short(LOWORD(DWORD(lParam))), short(HIWORD(DWORD(lParam))));

      if (mousePoint.x >= m_x) and (mousePoint.x < m_x + m_width) and
         (mousePoint.y >= m_y) and (mousePoint.y < m_y + m_nCaptionHeight) then
      begin
        ReleaseCapture;
        m_bDrag := False;
        m_bMinimized := not m_bMinimized;
        Exit;
      end;
    end;
  end;

  // If the dialog is minimized, don't send any messages to controls.
  if (m_bMinimized) then
  begin
    Result:= False;
    Exit;
  end;

  // If a control is in focus, it belongs to this dialog, and it's enabled, then give
  // it the first chance at handling the message.
  if (s_pControlFocus <> nil) and
     (s_pControlFocus.m_pDialog = Self) and
     (s_pControlFocus.Enabled) then
  begin
    // If the control MsgProc handles it, then we don't.
    if (s_pControlFocus.MsgProc(uMsg, wParam, lParam)) then Exit;
  end;

  case uMsg of
    WM_SIZE,
    WM_MOVE:
    begin
      // Handle sizing and moving messages so that in case the mouse cursor is moved out
      // of an UI control because of the window adjustment, we can properly
      // unhighlight the highlighted control.
      OnMouseMove(Point(-1, -1));
    end;

    WM_ACTIVATEAPP:
    begin
      // Call OnFocusIn()/OnFocusOut() of the control that currently has the focus
      // as the application is activated/deactivated.  This matches the Windows
      // behavior.
      if (s_pControlFocus <> nil) and
         (s_pControlFocus.m_pDialog = Self) and
         (s_pControlFocus.GetEnabled) then
      begin
        if (wParam <> 0)
        then s_pControlFocus.OnFocusIn
        else s_pControlFocus.OnFocusOut;
      end;
    end;

    // Keyboard messages
    WM_KEYDOWN,
    WM_SYSKEYDOWN,
    WM_KEYUP,
    WM_SYSKEYUP:
    begin
      // If a control is in focus, it belongs to this dialog, and it's enabled, then give
      // it the first chance at handling the message.
      if (s_pControlFocus <> nil) and
         (s_pControlFocus.m_pDialog = Self) and
         (s_pControlFocus.GetEnabled) then
      begin
        if (s_pControlFocus.HandleKeyboard(uMsg, wParam, lParam)) then Exit;
      end;

      // Not yet handled, see if this matches a control's hotkey
      // Activate the hotkey if the focus doesn't belong to an
      // edit box.
      if (uMsg = WM_KEYDOWN) and
         (
           (s_pControlFocus = nil) or
           not (s_pControlFocus.GetType in [DXUT_CONTROL_EDITBOX, DXUT_CONTROL_IMEEDITBOX])
         ) then
      begin
        for i:= 0 to Length(m_Controls) - 1 do
        begin
          pControl := m_Controls[i];
          if (pControl.Hotkey = Cardinal(wParam)) then
          begin
            pControl.OnHotkey;
            Exit;
          end;
        end;
      end;

      // Not yet handled, check for focus messages
      if (uMsg = WM_KEYDOWN) then
      begin
        // If keyboard input is not enabled, this message should be ignored
        if (not m_bKeyboardInput) then
        begin
          Result:= False;
          Exit;
        end;

        case wParam of
          VK_RIGHT,
          VK_DOWN:
            if (s_pControlFocus <> nil) then
            begin
              Result:= OnCycleFocus(True);
              Exit;
            end;

          VK_LEFT,
          VK_UP:
            if (s_pControlFocus <> nil) then
            begin
              Result:= OnCycleFocus(False);
              Exit;
            end;

          VK_TAB:
          begin
            bShiftDown := ((GetKeyState(VK_SHIFT) and $8000) <> 0);
            Result:= OnCycleFocus(not bShiftDown);
            Exit;
          end;
        end;
      end;
    end;


    // Mouse messages
    WM_MOUSEMOVE,
    WM_LBUTTONDOWN,
    WM_LBUTTONUP,
    WM_MBUTTONDOWN,
    WM_MBUTTONUP,
    WM_RBUTTONDOWN,
    WM_RBUTTONUP,
    WM_XBUTTONDOWN,
    WM_XBUTTONUP,
    WM_LBUTTONDBLCLK,
    WM_MBUTTONDBLCLK,
    WM_RBUTTONDBLCLK,
    WM_XBUTTONDBLCLK,
    WM_MOUSEWHEEL:
    begin
      // If not accepting mouse input, return false to indicate the message should still
      // be handled by the application (usually to move the camera).
      if (not m_bMouseInput) then
      begin
        Result:= False;
        Exit;
      end;

      mousePoint := Point(short(LOWORD(DWORD(lParam))), short(HIWORD(DWORD(lParam))));
      Dec(mousePoint.x, m_x);
      Dec(mousePoint.y, m_y);

      // If caption is enabled, offset the Y coordinate by the negative of its height.
      if (m_bCaption) then Dec(mousePoint.y, m_nCaptionHeight);

      // If a control is in focus, it belongs to this dialog, and it's enabled, then give
      // it the first chance at handling the message.
      if (s_pControlFocus <> nil) and
         (s_pControlFocus.m_pDialog = Self) and
         (s_pControlFocus.GetEnabled) then
      begin
        if s_pControlFocus.HandleMouse(uMsg, mousePoint, wParam, lParam)
        then Exit;
      end;

      // Not yet handled, see if the mouse is over any controls
      pControl := GetControlAtPoint(mousePoint);
      if (pControl <> nil) and pControl.Enabled then
      begin
        bHandled := pControl.HandleMouse(uMsg, mousePoint, wParam, lParam);
        if bHandled then Exit;
      end else
      begin
        // Mouse not over any controls in this dialog, if there was a control
        // which had focus it just lost it
        if (uMsg = WM_LBUTTONDOWN) and
           (s_pControlFocus <> nil) and
           (s_pControlFocus.m_pDialog = Self) then
        begin
          s_pControlFocus.OnFocusOut;
          s_pControlFocus := nil;
        end;
      end;

      // Still not handled, hand this off to the dialog. Return false to indicate the
      // message should still be handled by the application (usually to move the camera).
      case uMsg of
        WM_MOUSEMOVE:
        begin
          OnMouseMove(mousePoint);
          Result:= False;
          Exit;
        end;
      end;
    end;

    WM_CAPTURECHANGED:
    begin
      // The application has lost mouse capture.
      // The dialog object may not have received
      // a WM_MOUSEUP when capture changed. Reset
      // m_bDrag so that the dialog does not mistakenly
      // think the mouse button is still held down.
      if (THandle(lParam) <> hWnd) then m_bDrag := False;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetControlAtPoint(pt: TPoint): CDXUTControl;
var
  i: Integer;
  pControl: CDXUTControl;
begin
  // Search through all child controls for the first one which
  // contains the mouse point
  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];

    if (pControl = nil) then Continue;

    // We only return the current control if it is visible
    // and enabled.  Because GetControlAtPoint() is used to do mouse
    // hittest, it makes sense to perform this filtering.
    if pControl.ContainsPoint(pt) and pControl.Enabled and pControl.Visible then
    begin
      Result:= pControl;
      Exit;
    end;
  end;

  Result:= nil;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetControlEnabled(ID: Integer): Boolean;
var
  pControl: CDXUTControl;
begin
  pControl := GetControl(ID);
  if (pControl = nil) then Result:= False
  else Result:= pControl.Enabled;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.SetControlEnabled(ID: Integer; bEnabled: Boolean);
var
  pControl: CDXUTControl;
begin
  pControl := GetControl(ID);
  if (pControl <> nil) then pControl.Enabled:= bEnabled;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.OnMouseUp(pt: TPoint);
begin
  s_pControlPressed := nil;
  m_pControlMouseOver := nil;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.OnMouseMove(pt: TPoint);
var
  pControl: CDXUTControl;
begin
  // Figure out which control the mouse is over now
  pControl := GetControlAtPoint(pt);

  // If the mouse is still over the same control, nothing needs to be done
  if (pControl = m_pControlMouseOver) then Exit;

  // Handle mouse leaving the old control
  if (m_pControlMouseOver <> nil) then m_pControlMouseOver.OnMouseLeave;

  // Handle mouse entering the new control
  m_pControlMouseOver := pControl;
  if (pControl <> nil) then m_pControlMouseOver.OnMouseEnter;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.SetDefaultElement(nControlType: TDXUTControlType; iElement: LongWord; pElement: CDXUTElement): HRESULT;
var
  i, l: Integer;
  pElementHolder: PDXUTElementHolder;
  pNewHolder: PDXUTElementHolder;
begin
  // If this Element type already exist in the list, simply update the stored Element
  for i:= 0 to Length(m_DefaultElements) - 1 do
  begin
    pElementHolder := m_DefaultElements[i];

    if (pElementHolder.nControlType = nControlType) and
       (pElementHolder.iElement = iElement) then
    begin
      pElementHolder.Element.Assign(pElement);
      Result:= S_OK;
      Exit;
    end;
  end;

  // Otherwise, add a new entry
  try
    New(pNewHolder);
    pNewHolder.Element:= CDXUTElement.Create;
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;

  pNewHolder.nControlType := nControlType;
  pNewHolder.iElement := iElement;
  pNewHolder.Element.Assign(pElement);

  // m_DefaultElements.Add(pNewHolder);
  l:= Length(m_DefaultElements);
  SetLength(m_DefaultElements, l+1);
  m_DefaultElements[l]:= pNewHolder;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetDefaultElement(nControlType: TDXUTControlType; iElement: LongWord): CDXUTElement;
var
  i: Integer;
  pElementHolder: PDXUTElementHolder;
begin
  for i:= 0 to Length(m_DefaultElements) - 1 do
  begin
    pElementHolder := m_DefaultElements[i];

    if (pElementHolder.nControlType = nControlType) and
       (pElementHolder.iElement = iElement) then
    begin
      Result:= pElementHolder.Element;
      Exit;
    end;
  end;

  Result:= nil;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.AddStatic(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bIsDefault: Boolean = False; ppCreated: PCDXUTStatic = nil): HRESULT;
var
  pStatic: CDXUTStatic;
begin
  try
    pStatic := CDXUTStatic.Create(Self);
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
  if (ppCreated <> nil) then ppCreated^ := pStatic;

  Result := AddControl(pStatic);
  if FAILED(Result) then Exit;

  // Set the ID and list index
  pStatic.ID := ID;
  pStatic.Text:= strText;
  pStatic.SetLocation(x, y);
  pStatic.SetSize(width, height);
  pStatic.Default:= bIsDefault;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.AddButton(ID: Integer; strText: PWideChar; x, y, width, height: Integer; nHotkey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTButton = nil): HRESULT;
var
  pButton: CDXUTButton;
begin
  try
    pButton := CDXUTButton.Create(Self);
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
  if (ppCreated <> nil) then ppCreated^ := pButton;

  Result := AddControl(pButton);
  if FAILED(Result) then Exit;

  // Set the ID and list index
  pButton.ID:= ID;
  pButton.Text:= strText;
  pButton.SetLocation(x, y);
  pButton.SetSize(width, height);
  pButton.Hotkey:= nHotkey;
  pButton.Default:= bIsDefault;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.AddCheckBox(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bChecked: Boolean = False; nHotkey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTCheckBox = nil): HRESULT;
var
  pCheckBox: CDXUTCheckBox;
begin
  try
    pCheckBox := CDXUTCheckBox.Create(Self);
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
  if (ppCreated <> nil) then ppCreated^ := pCheckBox;

  Result := AddControl(pCheckBox);
  if FAILED(Result) then Exit;

  // Set the ID and list index
  pCheckBox.ID:= ID;
  pCheckBox.Text:= strText;
  pCheckBox.SetLocation(x, y);
  pCheckBox.SetSize(width, height);
  pCheckBox.Hotkey:= nHotkey;
  pCheckBox.Default:= bIsDefault;
  pCheckBox.Checked:= bChecked;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.AddRadioButton(ID: Integer; nButtonGroup: LongWord; strText: PWideChar; x, y, width, height: Integer; bChecked: Boolean = False; nHotkey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTRadioButton = nil): HRESULT;
var
  pRadioButton: CDXUTRadioButton;
begin
  try
    pRadioButton := CDXUTRadioButton.Create(Self);
    if (ppCreated <> nil) then ppCreated^ := pRadioButton;
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;

  Result := AddControl(pRadioButton);
  if FAILED(Result) then Exit;

  // Set the ID and list index
  pRadioButton.ID:= ID;
  pRadioButton.Text:= strText;
  pRadioButton.ButtonGroup:= nButtonGroup;
  pRadioButton.SetLocation(x, y);
  pRadioButton.SetSize(width, height);
  pRadioButton.Hotkey:= nHotkey;
  pRadioButton.Checked:= bChecked; // <-- look HERE
  pRadioButton.Default:= bIsDefault;
  pRadioButton.Checked:= bChecked; //todo: look above - validate what is't really needed

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.AddComboBox(ID: Integer; x, y, width, height: Integer; nHotKey: LongWord = 0; bIsDefault: Boolean = False; ppCreated: PCDXUTComboBox = nil): HRESULT;
var
  pComboBox: CDXUTComboBox;
begin
  try
    pComboBox := CDXUTComboBox.Create(Self);
    if (ppCreated <> nil) then ppCreated^ := pComboBox;
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;

  Result := AddControl(pComboBox);
  if FAILED(Result) then Exit;

  // Set the ID and list index
  pComboBox.ID:= ID;
  pComboBox.SetLocation(x, y);
  pComboBox.SetSize(width, height);
  pComboBox.Hotkey:= nHotkey;
  pComboBox.m_bIsDefault := bIsDefault;

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.AddSlider(ID: Integer; x, y, width, height: Integer; min: Integer = 0; max: Integer = 100; value: Integer = 50; bIsDefault: Boolean = False; ppCreated: PCDXUTSlider = nil): HRESULT;
var
  pSlider: CDXUTSlider;
begin
  try
    pSlider := CDXUTSlider.Create(Self);

    if (ppCreated <> nil) then ppCreated^ := pSlider;
  except
    on EOutOfMemory do
    begin
      Result:= E_OUTOFMEMORY;
      Exit;
    end;
  end;

  Result := AddControl(pSlider);
  if FAILED(Result) then Exit;

  // Set the ID and list index
  pSlider.ID:= ID;
  pSlider.SetLocation(x, y);
  pSlider.SetSize(width, height);
  pSlider.m_bIsDefault := bIsDefault;
  pSlider.SetRange(min, max);
  pSlider.SetValue(value);
  pSlider.UpdateRects;

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.AddEditBox(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bIsDefault: Boolean = False; ppCreated: PCDXUTEditBox = nil): HRESULT;
var
  pEditBox: CDXUTEditBox;
begin
  try
    pEditBox := CDXUTEditBox.Create(Self);

    if (ppCreated <> nil) then ppCreated^ := pEditBox;
  except
    on EOutOfMemory do
    begin
      Result:= E_OUTOFMEMORY;
      Exit;
    end;
  end;

  Result := AddControl(pEditBox);
  if FAILED(Result) then Exit;

  // Set the ID and position
  pEditBox.ID := ID;
  pEditBox.SetLocation(x, y);
  pEditBox.SetSize(width, height);
  pEditBox.m_bIsDefault := bIsDefault;

  if (strText <> nil) then pEditBox.SetText(strText);

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.AddIMEEditBox(ID: Integer; strText: PWideChar; x, y, width, height: Integer; bIsDefault: Boolean = False; ppCreated: PCDXUTIMEEditBox = nil): HRESULT;
var
  pEditBox: CDXUTIMEEditBox;
begin
  try
    pEditBox := CDXUTIMEEditBox.Create(Self);

    if (ppCreated <> nil) then ppCreated^ := pEditBox;
  except
    on EOutOfMemory do
    begin
      Result:= E_OUTOFMEMORY;
      Exit;
    end;
  end;

  Result := AddControl(pEditBox);
  if FAILED(Result) then Exit;

  // Set the ID and position
  pEditBox.ID := ID;
  pEditBox.SetLocation(x, y);
  pEditBox.SetSize(width, height);
  pEditBox.m_bIsDefault := bIsDefault;

  if (strText <> nil) then pEditBox.SetText(strText);

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.AddListBox(ID: Integer; x, y, width, height: Integer; dwStyle: TDXUTLBStyle = NORMAL; ppCreated: PCDXUTListBox = nil): HRESULT;
var
  pListBox: CDXUTListBox;
begin
  try
    pListBox := CDXUTListBox.Create(Self);
    if (ppCreated <> nil) then ppCreated^ := pListBox;
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;

  Result := AddControl(pListBox);
  if FAILED(Result) then Exit;

  // Set the ID and position
  pListBox.ID:= ID;
  pListBox.SetLocation(x, y);
  pListBox.SetSize(width, height);
  pListBox.Style:= dwStyle;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.InitControl(pControl: CDXUTControl): HRESULT;
var
  i: Integer;
  pElementHolder: PDXUTElementHolder;
begin
  if (pControl = nil) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  pControl.m_Index := Length(m_Controls);
    
  // Look for a default Element entries
  for i:= 0 to Length(m_DefaultElements) - 1 do
  begin
    pElementHolder := m_DefaultElements[i];
    if (pElementHolder.nControlType = pControl.GetType)
    then pControl.SetElement(pElementHolder.iElement, pElementHolder.Element);
  end;

  Result:= pControl.OnInit;
  if V_Failed(Result) then Exit;

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.AddControl(pControl: CDXUTControl): HRESULT;
var
  l: Integer;
begin
  Result := InitControl(pControl);
  if FAILED(Result) then
  begin
    Result:= DXTRACE_ERR('CDXUTDialog.InitControl', Result);
    Exit;
  end;

  // Add to the list
  // Result := m_Controls.Add(pControl);
  l:= Length(m_Controls);
  SetLength(m_Controls, l+1);
  m_Controls[l]:= pControl;
{  if FAILED(Result) then
  begin
    Result:= DXTRACE_ERR('CGrowableArray::Add', Result);
    Exit;
  end; }

  Result:= S_OK;
end;

function CDXUTDialog.GetStatic(ID: Integer): CDXUTStatic;
begin Result:= CDXUTStatic(GetControl(ID, DXUT_CONTROL_STATIC)); end;

function CDXUTDialog.GetButton(ID: Integer): CDXUTButton;
begin Result:= CDXUTButton(GetControl(ID, DXUT_CONTROL_BUTTON)); end;

function CDXUTDialog.GetCheckBox(ID: Integer): CDXUTCheckBox;
begin Result:= CDXUTCheckBox(GetControl(ID, DXUT_CONTROL_CHECKBOX)); end;

function CDXUTDialog.GetRadioButton(ID: Integer): CDXUTRadioButton;
begin Result:= CDXUTRadioButton(GetControl(ID, DXUT_CONTROL_RADIOBUTTON)); end;

function CDXUTDialog.GetComboBox(ID: Integer): CDXUTComboBox;
begin Result:= CDXUTComboBox(GetControl(ID, DXUT_CONTROL_COMBOBOX)); end;

function CDXUTDialog.GetSlider(ID: Integer): CDXUTSlider;
begin Result:= CDXUTSlider(GetControl(ID, DXUT_CONTROL_SLIDER)); end;

function CDXUTDialog.GetEditBox(ID: Integer): CDXUTEditBox;
begin Result:= CDXUTEditBox(GetControl(ID, DXUT_CONTROL_EDITBOX)); end;

function CDXUTDialog.GetIMEEditBox(ID: Integer): CDXUTIMEEditBox;
begin Result:= CDXUTIMEEditBox(GetControl(ID, DXUT_CONTROL_IMEEDITBOX)); end;

function CDXUTDialog.GetListBox(ID: Integer): CDXUTListBox;
begin Result:= CDXUTListBox(GetControl(ID, DXUT_CONTROL_LISTBOX)); end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetControl(ID: Integer): CDXUTControl;
var
  i: Integer;
  pControl: CDXUTControl;
begin
  // Try to find the control with the given ID
  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];

    if (pControl.ID = ID) then
    begin
      Result:= pControl;
      Exit;
    end;
  end;

  // Not found
  Result:= nil;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetControlProp(ID: Integer): CDXUTControl;
begin
  Result := GetControlProp(ID);
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.GetControl(ID: Integer; nControlType: TDXUTControlType): CDXUTControl;
var
  i: Integer;
  pControl: CDXUTControl;
begin
  // Try to find the control with the given ID
  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];

    if (pControl.ID = ID) and (pControl.GetType = nControlType) then
    begin
      Result:= pControl;
      Exit;
    end;
  end;

  // Not found
  Result:= nil;
end;



//--------------------------------------------------------------------------------------
class function CDXUTDialog.GetNextControl(pControl: CDXUTControl): CDXUTControl;
var
  index: Integer;
  pDialog: CDXUTDialog;
begin
  index := pControl.m_Index + 1;
  pDialog := pControl.m_pDialog;

  // Cycle through dialogs in the loop to find the next control. Note
  // that if only one control exists in all looped dialogs it will
  // be the returned 'next' control.
  while (index >= Length(pDialog.m_Controls)) do
  begin
    pDialog := pDialog.m_pNextDialog;
    index := 0;
  end;

  Result:= pDialog.m_Controls[index];
end;

//--------------------------------------------------------------------------------------
class function CDXUTDialog.GetPrevControl(pControl: CDXUTControl): CDXUTControl;
var
  index: Integer;
  pDialog: CDXUTDialog;
begin
  index := pControl.m_Index - 1;

  pDialog := pControl.m_pDialog;

  // Cycle through dialogs in the loop to find the next control. Note
  // that if only one control exists in all looped dialogs it will
  // be the returned 'previous' control.
  while (index < 0) do
  begin
    pDialog := pDialog.m_pPrevDialog;
    if (pDialog = nil) then pDialog := pControl.m_pDialog;

    index := length(pDialog.m_Controls) - 1;
  end;

  Result:= pDialog.m_Controls[index];
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.ClearRadioButtonGroup(nGroup: LongWord);
var
  i: Integer;
  pControl: CDXUTControl;
  pRadioButton: CDXUTRadioButton;
begin
  // Find all radio buttons with the given group number
  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];

    if (pControl.GetType = DXUT_CONTROL_RADIOBUTTON) then
    begin
      pRadioButton := pControl as CDXUTRadioButton;

      if (pRadioButton.ButtonGroup = nGroup)
      then pRadioButton.SetChecked(False, False);
    end;
  end;
end;



//--------------------------------------------------------------------------------------
procedure CDXUTDialog.ClearComboBox(ID: Integer);
var
  pComboBox: CDXUTComboBox;
begin
  pComboBox := GetComboBox(ID);
  if (pComboBox = nil) then Exit;

  pComboBox.RemoveAllItems;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.RequestFocus(pControl: CDXUTControl);
begin
  if (s_pControlFocus = pControl) then Exit;

  if (not pControl.CanHaveFocus) then Exit;

  if (s_pControlFocus <> nil) then s_pControlFocus.OnFocusOut;

  pControl.OnFocusIn;
  s_pControlFocus := pControl;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.DrawRect(const pRect: TRect; color: TD3DColor): HRESULT;
var
  rcScreen: TRect;
  vertices: array[0..3] of TDXUTScreenVertex;
  pd3dDevice: IDirect3DDevice9;
  pDecl: IDirect3DVertexDeclaration9;
begin
  rcScreen := pRect;
  OffsetRect(rcScreen, m_x, m_y);

  // If caption is enabled, offset the Y position by its height.
  if m_bCaption then OffsetRect(rcScreen, 0, m_nCaptionHeight);

  vertices[0]:= DXUTScreenVertex(rcScreen.left  -0.5, rcScreen.top -0.5,    0.5, 1.0, color, 0, 0);
  vertices[1]:= DXUTScreenVertex(rcScreen.right -0.5, rcScreen.top -0.5,    0.5, 1.0, color, 0, 0);
  vertices[2]:= DXUTScreenVertex(rcScreen.right -0.5, rcScreen.bottom -0.5, 0.5, 1.0, color, 0, 0);
  vertices[3]:= DXUTScreenVertex(rcScreen.left  -0.5, rcScreen.bottom -0.5, 0.5, 1.0, color, 0, 0);

  pd3dDevice := Manager.D3DDevice;

  // Since we're doing our own drawing here we need to flush the sprites
  Manager.m_pSprite.Flush;
  pd3dDevice.GetVertexDeclaration(pDecl);  // Preserve the sprite's current vertex decl
  pd3dDevice.SetFVF(TDXUTScreenVertex_FVF);

  pd3dDevice.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG2);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG2);

  pd3dDevice.DrawPrimitiveUP(D3DPT_TRIANGLEFAN, 2, vertices, SizeOf(TDXUTScreenVertex));

  pd3dDevice.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);

  // Restore the vertex decl
  pd3dDevice.SetVertexDeclaration(pDecl);
  pDecl:= nil;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.DrawPolyLine(apPoints: PPoint; nNumPoints: LongWord; color: TD3DColor): HRESULT;
begin
//todo: Don't forget convert this to Pascal 
(*  DXUT_SCREEN_VERTEX* vertices = new DXUT_SCREEN_VERTEX[ nNumPoints ];
  if( vertices == NULL )
      return E_OUTOFMEMORY;

  DXUT_SCREEN_VERTEX* pVertex = vertices;
  POINT* pt = apPoints;
  for( UINT i=0; i < nNumPoints; i++ )
  {
      pVertex->x = m_x + (float) pt->x;
      pVertex->y = m_y + (float) pt->y;
      pVertex->z = 0.5f;
      pVertex->h = 1.0f;
      pVertex->color = color;
      pVertex->tu = 0.0f;
      pVertex->tv = 0.0f;

      pVertex++;
      pt++;
  }

  IDirect3DDevice9* pd3dDevice = Manager.GetD3DDevice();

  // Since we're doing our own drawing here we need to flush the sprites
  Manager.m_pSprite->Flush();
  IDirect3DVertexDeclaration9 *pDecl = NULL;
  pd3dDevice->GetVertexDeclaration( &pDecl );  // Preserve the sprite's current vertex decl
  pd3dDevice->SetFVF( DXUT_SCREEN_VERTEX::FVF );

  pd3dDevice->SetTextureStageState( 0, D3DTSS_COLOROP, D3DTOP_SELECTARG2 );
  pd3dDevice->SetTextureStageState( 0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG2 );

  pd3dDevice->DrawPrimitiveUP( D3DPT_LINESTRIP, nNumPoints - 1, vertices, sizeof(DXUT_SCREEN_VERTEX) );

  pd3dDevice->SetTextureStageState( 0, D3DTSS_COLOROP, D3DTOP_MODULATE );
  pd3dDevice->SetTextureStageState( 0, D3DTSS_ALPHAOP, D3DTOP_MODULATE );

  // Restore the vertex decl
  pd3dDevice->SetVertexDeclaration( pDecl );
  pDecl->Release();

  SAFE_DELETE_ARRAY( vertices ); *)
  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTDialog.DrawSprite(pElement: CDXUTElement; const prcDest: TRect): HRESULT;
var
  rcTexture, rcScreen: TRect;
  pTextureNode: PDXUTTextureNode;
  fScaleX, fScaleY: Single;
  matTransform: TD3DXMatrixA16;
  vPos: TD3DXVector3;
begin
  Result:= S_OK;

  // No need to draw fully transparent layers
  if (pElement.TextureColor.Current.a = 0) then Exit;
  // No need to draw ZERO square sprite
  if (RectWidth(prcDest) = 0) or (RectHeight(prcDest) = 0) then Exit;

  rcTexture := pElement.rcTexture;

  rcScreen := prcDest;
  OffsetRect(rcScreen, m_x, m_y);

  // If caption is enabled, offset the Y position by its height.
  if m_bCaption then OffsetRect(rcScreen, 0, m_nCaptionHeight);

  pTextureNode := GetTexture(pElement.iTexture);
  if (pTextureNode = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  fScaleX := RectWidth(rcScreen) / RectWidth(rcTexture);
  fScaleY := RectHeight(rcScreen) / RectHeight(rcTexture);

  D3DXMatrixScaling(matTransform, fScaleX, fScaleY, 1.0);

  Manager.m_pSprite.SetTransform(matTransform);

  vPos:= D3DXVector3(rcScreen.left, rcScreen.top, 0.0);

  vPos.x := vPos.x / fScaleX;
  vPos.y := vPos.y / fScaleY;

  Result:= Manager.m_pSprite.Draw(pTextureNode.pTexture, @rcTexture, nil, @vPos, D3DXColorToDWord(pElement.TextureColor.Current));
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.CalcTextRect(strText: PWideChar; pElement: CDXUTElement; prcDest: PRect; nCount: Integer = -1): HRESULT;
var
  pFontNode: PDXUTFontNode;
  dwTextFormat: DWORD;
begin
  pFontNode := GetFont(pElement.iFont);
  if (pFontNode = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;
  
  dwTextFormat := pElement.dwTextFormat or DT_CALCRECT;
  // Since we are only computing the rectangle, we don't need a sprite.
  Result := pFontNode.pFont.DrawTextW(nil, strText, nCount, prcDest, dwTextFormat, D3DXColorToDWord(pElement.FontColor.Current));
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.DrawText(strText: PWideChar; pElement: CDXUTElement; const rcDest: TRect; bShadow: Boolean = False; nCount: Integer = -1): HRESULT;
var
  rcScreen, rcShadow: TRect;
  matTransform: TD3DXMatrixA16;
  pFontNode: PDXUTFontNode;
begin
  // No need to draw fully transparent layers
  if (pElement.FontColor.Current.a = 0) then
  begin
    Result:= S_OK;
    Exit;
  end;

  rcScreen := rcDest;
  OffsetRect(rcScreen, m_x, m_y);

  // If caption is enabled, offset the Y position by its height.
  if m_bCaption then OffsetRect(rcScreen, 0, m_nCaptionHeight);

  //debug
  //DrawRect(rcScreen, D3DCOLOR_ARGB(100, 255, 0, 0));

  D3DXMatrixIdentity(matTransform);
  Manager.m_pSprite.SetTransform(matTransform);

  pFontNode := GetFont(pElement.iFont);

  if (bShadow) then
  begin
    rcShadow := rcScreen;
    OffsetRect(rcShadow, 1, 1);
    Result := pFontNode.pFont.DrawTextW(Manager.m_pSprite, strText, nCount, @rcShadow, pElement.dwTextFormat, D3DCOLOR_ARGB(Trunc(pElement.FontColor.Current.a * 255), 0, 0, 0));
    if FAILED(Result) then Exit;
  end;

  Result := pFontNode.pFont.DrawTextW(Manager.m_pSprite, strText, nCount, @rcScreen, pElement.dwTextFormat, D3DXColorToDWord(pElement.FontColor.Current));
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.SetBackgroundColors(colorAllCorners: TD3DColor);
begin
  SetBackgroundColors(colorAllCorners, colorAllCorners, colorAllCorners, colorAllCorners);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTDialog.SetBackgroundColors(colorTopLeft, colorTopRight, colorBottomLeft, colorBottomRight: TD3DColor); 
begin
  m_colorTopLeft := colorTopLeft;
  m_colorTopRight := colorTopRight;
  m_colorBottomLeft := colorBottomLeft;
  m_colorBottomRight := colorBottomRight;
end;


procedure CDXUTDialog.SetCaptionText(const pwszText: PWideChar);
begin
  StringCchCopy(m_wszCaption, SizeOf(m_wszCaption) div SizeOf(m_wszCaption[0]), pwszText);
end;

procedure CDXUTDialog.GetLocation(out Pt: TPoint);
begin
  Pt.x := m_x; Pt.y := m_y;
end;

procedure CDXUTDialog.SetLocation(x, y: Integer);
begin
  m_x := x; m_y := y;
end;

procedure CDXUTDialog.SetSize(width, height: Integer);
begin
  m_width := width; m_height := height;
end;

//--------------------------------------------------------------------------------------
procedure CDXUTDialog.SetNextDialog(pNextDialog: CDXUTDialog);
begin
  if (pNextDialog = nil) then pNextDialog := Self;

  m_pNextDialog := pNextDialog;
  if Assigned(pNextDialog) then m_pNextDialog.m_pPrevDialog := Self;
end;

class procedure CDXUTDialog.SetRefreshTime(fTime: Single);
begin
  s_fTimeRefresh := fTime;
end;

//--------------------------------------------------------------------------------------
class procedure CDXUTDialog.ClearFocus;
begin
  if (s_pControlFocus <> nil) then
  begin
    s_pControlFocus.OnFocusOut;
    s_pControlFocus := nil;
  end;

  ReleaseCapture;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.FocusDefaultControl;
var
  i: Integer;
  pControl: CDXUTControl;
begin
  // Check for default control in this dialog
  for i:= 0 to Length(m_Controls) - 1 do
  begin
    pControl := m_Controls[i];
    if (pControl.Default) then
    begin
      // Remove focus from the current control
      ClearFocus;

      // Give focus to the default control
      s_pControlFocus := pControl;
      s_pControlFocus.OnFocusIn;
      Exit;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialog.OnCycleFocus(bForward: Boolean): Boolean;
var
  pControl: CDXUTControl;
  pDialog: CDXUTDialog;      // pDialog and pLastDialog are used to track wrapping of
  pLastDialog: CDXUTDialog;  // focus from first control to last or vice versa.

  i: Integer;
  d: Integer;
  nLastDialogIndex: Integer;
  nDialogIndex: Integer;
begin
  Result:= True;
  
  pControl := nil;
  pDialog := nil;
  pLastDialog := nil;

  if (s_pControlFocus = nil) then
  begin
    // If s_pControlFocus is NULL, we focus the first control of first dialog in
    // the case that bForward is true, and focus the last control of last dialog when
    // bForward is false.
    //
    if bForward then
    begin
      // Search for the first control from the start of the dialog
      // array.
      for d := 0 to m_pManager.m_Dialogs.Count - 1 do
      begin
        pDialog := m_pManager.m_Dialogs[d];
        pLastDialog := m_pManager.m_Dialogs[d];
        if Assigned(pDialog) and (Length(pDialog.m_Controls) > 0) then
        begin
          pControl := pDialog.m_Controls[0];
          Break;
        end;
      end;

      if not (Assigned(pDialog) and Assigned(pControl)) then
      begin
        // No dialog has been registered yet or no controls have been
        // added to the dialogs. Cannot proceed.
        Exit;
      end;
    end
    else
    begin
      // Search for the first control from the end of the dialog
      // array.
      for d := m_pManager.m_Dialogs.Count - 1 downto 0 do
      begin
        pDialog := m_pManager.m_Dialogs[d];
        pLastDialog := m_pManager.m_Dialogs[d];
        if Assigned(pDialog) and (Length(pDialog.m_Controls) > 0) then
        begin
          pControl := pDialog.m_Controls[Length(pDialog.m_Controls) - 1];
          Break;
        end;
      end;

      if not (Assigned(pDialog) and Assigned(pControl)) then
      begin
        // No dialog has been registered yet or no controls have been
        // added to the dialogs. Cannot proceed.
        Exit;
      end;
    end;
  end
  else
  if (s_pControlFocus.m_pDialog <> Self) then
  begin
    // If a control belonging to another dialog has focus, let that other
    // dialog handle this event by returning false.
    //
    Result:= False;
    Exit;
  end
  else
  begin
    // Focused control belongs to this dialog. Cycle to the
    // next/previous control.
    pLastDialog := s_pControlFocus.m_pDialog;
    if bForward
    then pControl := GetNextControl(s_pControlFocus)
    else pControl := GetPrevControl(s_pControlFocus);
    pDialog := pControl.m_pDialog;
  end;

  for i := 0 to $ffff - 1 do
  begin
    // If we just wrapped from last control to first or vice versa,
    // set the focused control to NULL. This state, where no control
    // has focus, allows the camera to work.

    nLastDialogIndex := m_pManager.m_Dialogs.IndexOf(pLastDialog);
    nDialogIndex := m_pManager.m_Dialogs.IndexOf(pDialog);

    if (not bForward and (nLastDialogIndex < nDialogIndex)) or
       (bForward and (nDialogIndex < nLastDialogIndex)) then
    begin
      if Assigned(s_pControlFocus) then s_pControlFocus.OnFocusOut;
      s_pControlFocus := nil;
      Exit;
    end;

    // If we've gone in a full circle then focus doesn't change
    if (pControl = s_pControlFocus) then Exit;

    // If the dialog accepts keybord input and the control can have focus then
    // move focus
    if (pControl.m_pDialog.m_bKeyboardInput and pControl.CanHaveFocus) then
    begin
      if Assigned(s_pControlFocus) then s_pControlFocus.OnFocusOut;
      s_pControlFocus := pControl;
      s_pControlFocus.OnFocusIn;
      Exit;
    end;

    pLastDialog := pDialog;
    if bForward
    then pControl := GetNextControl(pControl)
    else pControl := GetPrevControl(pControl);
    pDialog := pControl.m_pDialog;
  end;

  // If we reached this point, the chain of dialogs didn't form a complete loop
  DXTRACE_ERR('CDXUTDialog: Multiple dialogs are improperly chained together', E_FAIL);
  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.CreateFont(index: LongWord): HRESULT; // ( UINT iFont )
var
  pFontNode: PDXUTFontNode;
begin
  pFontNode := m_FontCache[index];

  SAFE_RELEASE(pFontNode.pFont);

  Result:= D3DXCreateFontW(m_pd3dDevice, pFontNode.nHeight, 0, pFontNode.nWeight, 1, False, DEFAULT_CHARSET,
                           OUT_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE,
                           pFontNode.strFace, pFontNode.pFont);
  if V_FAILED(Result) then Exit;

  Result:= S_OK;
end;

//--------------------------------------------------------------------------------------
function CDXUTDialogResourceManager.CreateTexture(iTexture: LongWord): HRESULT;
var
  pTextureNode: PDXUTTextureNode;
  strPath: array[0..MAX_PATH-1] of WideChar;
  info: TD3DXImageInfo;
  pID: PWideChar;
begin
  pTextureNode := m_TextureCache[iTexture];

  if not pTextureNode.bFileSource then
  begin
    if (pTextureNode.nResourceID = $FFFF) and (pTextureNode.hResourceModule = HMODULE($FFFF)) then
    begin
      Result := DXUTCreateGUITextureFromInternalArray(m_pd3dDevice, pTextureNode.pTexture, @info);
      if FAILED(Result) then
      begin
        Result:= DXTRACE_ERR('D3DXCreateTextureFromFileInMemoryEx', Result);
        Exit;
      end;
    end else
    begin
      if (pTextureNode.nResourceID <> 0)
      then pID := PWideChar(size_t(pTextureNode.nResourceID))
      else pID := pTextureNode.strFilename;

      // Create texture from resource
      Result :=  D3DXCreateTextureFromResourceExW(m_pd3dDevice,
                     pTextureNode.hResourceModule, pID, D3DX_DEFAULT, D3DX_DEFAULT,
                     1, 0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED,
                     D3DX_DEFAULT, D3DX_DEFAULT, 0,
                     @info, nil, pTextureNode.pTexture);
      if FAILED(Result) then
      begin
        Result:= DXTRACE_ERR('D3DXCreateTextureFromResourceEx', Result);
        Exit;
      end;
    end;
  end else
  begin
    // Make sure there's a texture to create
    if (pTextureNode.strFilename[0] = #0) then
    begin
      Result:= S_OK;
      Exit;
    end;

    // Find the texture on the hard drive
    Result := DXUTFindDXSDKMediaFile(strPath, MAX_PATH, pTextureNode.strFilename);
    if FAILED(Result) then
    begin
      Result:= DXTRACE_ERR('DXUTFindDXSDKMediaFileCch', Result);
      Exit;
    end;

    // Create texture from file
    Result :=  D3DXCreateTextureFromFileExW(m_pd3dDevice, strPath, D3DX_DEFAULT, D3DX_DEFAULT,
                   1, 0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED,
                   D3DX_DEFAULT, D3DX_DEFAULT, 0,
                   @info, nil, pTextureNode.pTexture);
    if FAILED(Result) then
    begin
      Result:= DXTRACE_ERR('D3DXCreateTextureFromFileEx', Result);
      Exit;
    end;
  end;

  // Store dimensions
  pTextureNode.dwWidth := info.Width;
  pTextureNode.dwHeight := info.Height;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTDialog.InitDefaultElements;
var
  Element: CDXUTElement;
  rcTexture: TRect;
  nScrollBarStartX: Integer;
  nScrollBarStartY: Integer;
begin
  SetFont(0, 'Arial', 14, FW_NORMAL);

  Element:= CDXUTElement.Create;

  //-------------------------------------
  // Element for the caption
  //-------------------------------------
  m_CapElement.SetFont(0);
  SetRect(rcTexture, 17, 269, 241, 287);
  m_CapElement.SetTexture(0, @rcTexture);
  m_CapElement.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_CapElement.FontColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_CapElement.SetFont(0, D3DCOLOR_ARGB(255, 255, 255, 255), DT_LEFT or DT_VCENTER);
  // Pre-blend as we don't need to transition the state
  m_CapElement.TextureColor.Blend(DXUT_STATE_NORMAL, 10.0);
  m_CapElement.FontColor.Blend(DXUT_STATE_NORMAL, 10.0);

  //-------------------------------------
  // CDXUTStatic
  //-------------------------------------
  Element.SetFont(0);
  Element.FontColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(200, 200, 200, 200);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_STATIC, 0, Element);


  //-------------------------------------
  // CDXUTButton - Button
  //-------------------------------------
  SetRect(rcTexture, 0, 0, 136, 54);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0);
  Element.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(150, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_PRESSED ] := D3DCOLOR_ARGB(200, 255, 255, 255);
  Element.FontColor.States[ DXUT_STATE_MOUSEOVER ] := D3DCOLOR_ARGB(255, 0, 0, 0);
    
  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_BUTTON, 0, Element);
    

  //-------------------------------------
  // CDXUTButton - Fill layer
  //-------------------------------------
  SetRect(rcTexture, 136, 0, 252, 54);
  Element.SetTexture(0, @rcTexture, D3DCOLOR_ARGB(0, 255, 255, 255));
  Element.TextureColor.States[ DXUT_STATE_MOUSEOVER ] := D3DCOLOR_ARGB(160, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_PRESSED ] := D3DCOLOR_ARGB(60, 0, 0, 0);
  Element.TextureColor.States[ DXUT_STATE_FOCUS ] := D3DCOLOR_ARGB(30, 255, 255, 255);
    
    
  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_BUTTON, 1, Element);


  //-------------------------------------
  // CDXUTCheckBox - Box
  //-------------------------------------
  SetRect(rcTexture, 0, 54, 27, 81);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 255, 255, 255), DT_LEFT or DT_VCENTER);
  Element.FontColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB( 200, 200, 200, 200);
  Element.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(150, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_FOCUS ] := D3DCOLOR_ARGB(200, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_PRESSED ] := D3DCOLOR_ARGB(255, 255, 255, 255);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_CHECKBOX, 0, Element);


  //-------------------------------------
  // CDXUTCheckBox - Check
  //-------------------------------------
  SetRect(rcTexture, 27, 54, 54, 81);
  Element.SetTexture(0, @rcTexture);
    
  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_CHECKBOX, 1, Element );


  //-------------------------------------
  // CDXUTRadioButton - Box
  //-------------------------------------
  SetRect(rcTexture, 54, 54, 81, 81 );
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 255, 255, 255), DT_LEFT or DT_VCENTER);
  Element.FontColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB( 200, 200, 200, 200);
  Element.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(150, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_FOCUS ] := D3DCOLOR_ARGB(200, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_PRESSED ] := D3DCOLOR_ARGB(255, 255, 255, 255);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_RADIOBUTTON, 0, Element);


  //-------------------------------------
  // CDXUTRadioButton - Check
  //-------------------------------------
  SetRect(rcTexture, 81, 54, 108, 81);
  Element.SetTexture(0, @rcTexture);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_RADIOBUTTON, 1, Element);


  //-------------------------------------
  // CDXUTComboBox - Main
  //-------------------------------------
  SetRect(rcTexture, 7, 81, 247, 123);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0);
  Element.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(150, 200, 200, 200);
  Element.TextureColor.States[ DXUT_STATE_FOCUS ] := D3DCOLOR_ARGB(170, 230, 230, 230);
  Element.TextureColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(70, 200, 200, 200);
  Element.FontColor.States[ DXUT_STATE_MOUSEOVER ] := D3DCOLOR_ARGB(255, 0, 0, 0);
  Element.FontColor.States[ DXUT_STATE_PRESSED ] := D3DCOLOR_ARGB(255, 0, 0, 0);
  Element.FontColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(200, 200, 200, 200);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_COMBOBOX, 0, Element);


  //-------------------------------------
  // CDXUTComboBox - Button
  //-------------------------------------
  SetRect(rcTexture, 98, 189, 151, 238);
  Element.SetTexture(0, @rcTexture);
  Element.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(150, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_PRESSED ] := D3DCOLOR_ARGB(255, 150, 150, 150);
  Element.TextureColor.States[ DXUT_STATE_FOCUS ] := D3DCOLOR_ARGB(200, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(70, 255, 255, 255);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_COMBOBOX, 1, Element);


  //-------------------------------------
  // CDXUTComboBox - Dropdown
  //-------------------------------------
  SetRect(rcTexture, 13, 123, 241, 160);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 0, 0, 0), DT_LEFT or DT_TOP);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_COMBOBOX, 2, Element);


  //-------------------------------------
  // CDXUTComboBox - Selection
  //-------------------------------------
  SetRect(rcTexture, 12, 163, 239, 183);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 255, 255, 255), DT_LEFT or DT_TOP);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_COMBOBOX, 3, Element);


  //-------------------------------------
  // CDXUTSlider - Track
  //-------------------------------------
  SetRect(rcTexture, 1, 187, 93, 228);
  Element.SetTexture(0, @rcTexture);
  Element.TextureColor.States[ DXUT_STATE_NORMAL ] := D3DCOLOR_ARGB(150, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_FOCUS ] := D3DCOLOR_ARGB(200, 255, 255, 255);
  Element.TextureColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(70, 255, 255, 255);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_SLIDER, 0, Element);

  //-------------------------------------
  // CDXUTSlider - Button
  //-------------------------------------
  SetRect(rcTexture, 151, 193, 192, 234);
  Element.SetTexture(0, @rcTexture);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_SLIDER, 1, Element);

  //-------------------------------------
  // CDXUTScrollBar - Track
  //-------------------------------------
  nScrollBarStartX := 196;
  nScrollBarStartY := 191;
  SetRect(rcTexture, nScrollBarStartX + 0, nScrollBarStartY + 21, nScrollBarStartX + 22, nScrollBarStartY + 32);
  Element.SetTexture(0, @rcTexture);
  Element.TextureColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(255, 200, 200, 200);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_SCROLLBAR, 0, Element);

  //-------------------------------------
  // CDXUTScrollBar - Up Arrow
  //-------------------------------------
  SetRect(rcTexture, nScrollBarStartX + 0, nScrollBarStartY + 1, nScrollBarStartX + 22, nScrollBarStartY + 21);
  Element.SetTexture(0, @rcTexture);
  Element.TextureColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(255, 200, 200, 200);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_SCROLLBAR, 1, Element);


  //-------------------------------------
  // CDXUTScrollBar - Down Arrow
  //-------------------------------------
  SetRect(rcTexture, nScrollBarStartX + 0, nScrollBarStartY + 32, nScrollBarStartX + 22, nScrollBarStartY + 53);
  Element.SetTexture(0, @rcTexture);
  Element.TextureColor.States[ DXUT_STATE_DISABLED ] := D3DCOLOR_ARGB(255, 200, 200, 200);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_SCROLLBAR, 2, Element);

  //-------------------------------------
  // CDXUTScrollBar - Button
  //-------------------------------------
  SetRect(rcTexture, 220, 192, 238, 234);
  Element.SetTexture(0, @rcTexture);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_SCROLLBAR, 3, Element);


  //-------------------------------------
  // CDXUTEditBox
  //-------------------------------------
  // Element assignment:
  //   0 - text area
  //   1 - top left border
  //   2 - top border
  //   3 - top right border
  //   4 - left border
  //   5 - right border
  //   6 - lower left border
  //   7 - lower border
  //   8 - lower right border

  Element.SetFont(0, D3DCOLOR_ARGB(255, 0, 0, 0 ), DT_LEFT or DT_TOP);

  // Assign the style
  SetRect(rcTexture, 14, 90, 241, 113);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 0, Element);
  SetRect(rcTexture, 8, 82, 14, 90);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 1, Element);
  SetRect(rcTexture, 14, 82, 241, 90);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 2, Element);
  SetRect(rcTexture, 241, 82, 246, 90);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 3, Element);
  SetRect(rcTexture, 8, 90, 14, 113);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 4, Element);
  SetRect(rcTexture, 241, 90, 246, 113);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 5, Element);
  SetRect(rcTexture, 8, 113, 14, 121);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 6, Element);
  SetRect(rcTexture, 14, 113, 241, 121);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 7, Element);
  SetRect(rcTexture, 241, 113, 246, 121);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_EDITBOX, 8, Element);


  //-------------------------------------
  // CDXUTIMEEditBox
  //-------------------------------------

  Element.SetFont(0, D3DCOLOR_ARGB(255, 0, 0, 0), DT_LEFT or DT_TOP);

  // Assign the style
  SetRect(rcTexture, 14, 90, 241, 113);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 0, Element);
  SetRect(rcTexture, 8, 82, 14, 90);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 1, Element);
  SetRect(rcTexture, 14, 82, 241, 90);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 2, Element);
  SetRect(rcTexture, 241, 82, 246, 90);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 3, Element);
  SetRect(rcTexture, 8, 90, 14, 113);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 4, Element);
  SetRect(rcTexture, 241, 90, 246, 113);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 5, Element);
  SetRect(rcTexture, 8, 113, 14, 121);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 6, Element);
  SetRect(rcTexture, 14, 113, 241, 121);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 7, Element);
  SetRect(rcTexture, 241, 113, 246, 121);
  Element.SetTexture(0, @rcTexture);
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 8, Element);
  // Element 9 for IME text, and indicator button
  SetRect(rcTexture, 0, 0, 136, 54);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 0, 0, 0), DT_CENTER or DT_VCENTER );
  SetDefaultElement(DXUT_CONTROL_IMEEDITBOX, 9, Element);

  //-------------------------------------
  // CDXUTListBox - Main
  //-------------------------------------

  SetRect(rcTexture, 13, 123, 241, 160);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 0, 0, 0), DT_LEFT or DT_TOP);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_LISTBOX, 0, Element);

  //-------------------------------------
  // CDXUTListBox - Selection
  //-------------------------------------

  SetRect(rcTexture, 16, 166, 240, 183);
  Element.SetTexture(0, @rcTexture);
  Element.SetFont(0, D3DCOLOR_ARGB(255, 255, 255, 255), DT_LEFT or DT_TOP);

  // Assign the Element
  SetDefaultElement(DXUT_CONTROL_LISTBOX, 1, Element);

  Element.Free;
end;



//--------------------------------------------------------------------------------------
// CDXUTControl class
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
constructor CDXUTControl.Create(pDialog: CDXUTDialog = nil); 
begin
  inherited Create;

  m_Type := DXUT_CONTROL_BUTTON;
  m_pDialog := pDialog;
  m_ID := 0;
  m_Index := 0;
  m_pUserData := nil;

  m_bEnabled := True;
  m_bVisible := True;
  m_bMouseOver := False;
  m_bHasFocus := False;
  m_bIsDefault := False;

  m_pDialog := nil;

  m_x := 0;
  m_y := 0;
  m_width := 0;
  m_height := 0;

  ZeroMemory(@m_rcBoundingBox, SizeOf(m_rcBoundingBox));
end;


destructor CDXUTControl.Destroy; 
var
  i: Integer;
begin
  for i:= 0 to Length(m_Elements) - 1 do
    m_Elements[i].Free;
    
  m_Elements:= nil; // RemoveAll;
end;


function CDXUTControl.OnInit: HRESULT;
begin Result:= S_OK; end;

procedure CDXUTControl.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
begin end;

function CDXUTControl.MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin Result:= False; end;

function CDXUTControl.HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin Result:= False; end;

function CDXUTControl.HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean;
begin Result:= False; end;

function CDXUTControl.CanHaveFocus: Boolean;
begin Result:= False; end;

procedure CDXUTControl.OnFocusIn;
begin m_bHasFocus := True; end;

procedure CDXUTControl.OnFocusOut;
begin m_bHasFocus := False; end;

procedure CDXUTControl.OnMouseEnter;
begin m_bMouseOver := True; end;

procedure CDXUTControl.OnMouseLeave;
begin m_bMouseOver := False; end;

procedure CDXUTControl.OnHotkey;
begin end;

function CDXUTControl.ContainsPoint(pt: TPoint): LongBool;
begin
  Result:= PtInRect(m_rcBoundingBox, pt);
end;

procedure CDXUTControl.SetLocation(x, y: Integer);
begin
  m_x := x; m_y := y;
  UpdateRects;
end;

procedure CDXUTControl.SetSize(width, height: Integer);
begin
  m_width := width; m_height := height;
  UpdateRects;
end;

//--------------------------------------------------------------------------------------
procedure CDXUTControl.SetTextColor(Color: TD3DColor);
var
  pElement: CDXUTElement;
begin
  pElement := m_Elements[0];

  if (pElement <> nil) then
    pElement.FontColor.States[DXUT_STATE_NORMAL] := Color;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTControl.SetElement(iElement: LongWord; pElement: CDXUTElement);
var
  i: Integer;
  pNewElement, pCurElement: CDXUTElement;
begin
  // Make certain the array is this large
  for i:= Length(m_Elements) to iElement do
  begin
    pNewElement := CDXUTElement.Create;

    // Result := m_Elements.Add(pNewElement);
    SetLength(m_Elements, i+1);
    m_Elements[i]:= pNewElement;
  end;

  // Update the data
  pCurElement := m_Elements[iElement];
  pCurElement.Assign(pElement);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTControl.Refresh;
var
  i: Integer;
begin
  m_bMouseOver := False;
  m_bHasFocus := False;

  for i:= 0 to Length(m_Elements) - 1 do
    m_Elements[i].Refresh;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTControl.UpdateRects;
begin
  SetRect(m_rcBoundingBox, m_x, m_y, m_x + m_width, m_y + m_height);
end;

procedure CDXUTControl.SetEnabled(bEnabled: Boolean);
begin m_bEnabled := bEnabled; end;

function CDXUTControl.GetEnabled: Boolean; 
begin Result:= m_bEnabled; end;

procedure CDXUTControl.SetVisible(bVisible: Boolean);
begin m_bVisible := bVisible; end;

function CDXUTControl.GetElement(iElement: LongWord): CDXUTElement;
begin Result:= m_Elements[iElement]; end;

//--------------------------------------------------------------------------------------
// CDXUTStatic class
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
constructor CDXUTStatic.Create(pDialog: CDXUTDialog = nil);
var
  i: Integer;
begin
  inherited;
  
  m_Type := DXUT_CONTROL_STATIC;
  m_pDialog := pDialog;

  ZeroMemory(@m_strText, SizeOf(m_strText));

  for i:= 0 to Length(m_Elements) - 1 do
  begin
    m_Elements[i].Free;
  end;

  m_Elements:= nil; // RemoveAll;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTStatic.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
var
  iState: TDXUTControlState;
  pElement: CDXUTElement;
begin
  if not Visible then Exit;

  iState := DXUT_STATE_NORMAL;
  if not Enabled then iState := DXUT_STATE_DISABLED;

  pElement := m_Elements[0];

  pElement.FontColor.Blend(iState, fElapsedTime);

  m_pDialog.DrawText(m_strText, pElement, m_rcBoundingBox, True);
end;


//--------------------------------------------------------------------------------------
function CDXUTStatic.ContainsPoint(pt: TPoint): LongBool;
begin
  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTStatic.GetTextCopy(strDest: PWideChar; bufferCount: LongWord): HRESULT;
begin
  // Validate incoming parameters
  if (strDest = nil) or (bufferCount = 0) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  // Copy the window text
  StringCchCopy(strDest, bufferCount, m_strText);

  Result:= S_OK;
end;


function CDXUTStatic.GetText: PWideChar;
begin
  Result:= m_strText;
end;

//--------------------------------------------------------------------------------------
procedure CDXUTStatic.SetText(strText: PWideChar);
begin
  if (strText = nil)
  then m_strText[0] := #0
  else StringCchCopy(m_strText, MAX_PATH, strText);
end;


//--------------------------------------------------------------------------------------
// CDXUTButton class
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
constructor CDXUTButton.Create(pDialog: CDXUTDialog = nil);
begin
  inherited;
  m_Type := DXUT_CONTROL_BUTTON;
  m_pDialog := pDialog;

  m_bPressed := False;
  m_nHotkey := 0;
end;

//--------------------------------------------------------------------------------------
function CDXUTButton.HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if not Enabled or not Visible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;
  
  case uMsg of
    WM_KEYDOWN:
    begin
      case wParam of
        VK_SPACE:
        begin
          m_bPressed := True;
          Exit;
        end;
      end;
    end;

    WM_KEYUP:
    begin
      case wParam of
        VK_SPACE:
        begin
          if (m_bPressed) then
          begin
            m_bPressed := False;
            m_pDialog.SendEvent(EVENT_BUTTON_CLICKED, True, Self);
          end;
          Exit;
        end;
      end;
    end;

  end; {case}
  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTButton.HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if not Enabled or not Visible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      if ContainsPoint(pt) then
      begin
        // Pressed while inside the control
        m_bPressed := True;
        SetCapture(DXUTGetHWND);

        if (not m_bHasFocus) then m_pDialog.RequestFocus(Self);

        Exit;
      end;
    end;

    WM_LBUTTONUP:
    begin
      if (m_bPressed) then
      begin
        m_bPressed := False;
        ReleaseCapture;

        if (not m_pDialog.m_bKeyboardInput) then m_pDialog.ClearFocus;

        // Button click
        if ContainsPoint(pt) then
          m_pDialog.SendEvent(EVENT_BUTTON_CLICKED, True, Self);

        Exit;
      end;
    end;
  end;

  Result:= False;
end;

procedure CDXUTButton.OnHotkey;
begin
  if m_pDialog.IsKeyboardInputEnabled then m_pDialog.RequestFocus(Self);
  m_pDialog.SendEvent(EVENT_BUTTON_CLICKED, True, Self);
end;

function CDXUTButton.ContainsPoint(pt: TPoint): LongBool;
begin
  Result:= PtInRect(m_rcBoundingBox, pt);
end;

function CDXUTButton.CanHaveFocus: Boolean;
begin
  Result:= Visible and Enabled;
end;

//--------------------------------------------------------------------------------------
procedure CDXUTButton.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
var
  nOffsetX, nOffsetY: Integer;
  iState: TDXUTControlState;
  pElement: CDXUTElement;
  fBlendRate: Single;
  rcWindow: TRect;
begin
  nOffsetX := 0;
  nOffsetY := 0;

  iState := DXUT_STATE_NORMAL;

  if not Visible then iState := DXUT_STATE_HIDDEN else
  if not Enabled then iState := DXUT_STATE_DISABLED else
  if Pressed then
  begin
    iState := DXUT_STATE_PRESSED;

    nOffsetX := 1;
    nOffsetY := 2;
  end
  else if (m_bMouseOver) then
  begin
    iState := DXUT_STATE_MOUSEOVER;

    nOffsetX := -1;
    nOffsetY := -2;
  end
  else if (m_bHasFocus) then
  begin
    iState := DXUT_STATE_FOCUS;
  end;

  // Background fill layer
  //TODO: remove magic numbers
  pElement := m_Elements[0];

  fBlendRate := IfThen((iState = DXUT_STATE_PRESSED), 0.0, 0.8);

  rcWindow := m_rcBoundingBox;
  OffsetRect(rcWindow, nOffsetX, nOffsetY);


  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  pElement.FontColor.Blend(iState, fElapsedTime, fBlendRate);

  m_pDialog.DrawSprite(pElement, rcWindow);
  m_pDialog.DrawText(m_strText, pElement, rcWindow);

  // Main button
  pElement := m_Elements[1];


  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  pElement.FontColor.Blend(iState, fElapsedTime, fBlendRate);

  m_pDialog.DrawSprite(pElement, rcWindow);
  m_pDialog.DrawText(m_strText, pElement, rcWindow);
end;



//--------------------------------------------------------------------------------------
// CDXUTCheckBox class
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
constructor CDXUTCheckBox.Create(pDialog: CDXUTDialog = nil);
begin
  inherited;
  m_Type := DXUT_CONTROL_CHECKBOX;
  m_pDialog := pDialog;

  m_bChecked := False;
end;
    

//--------------------------------------------------------------------------------------
function CDXUTCheckBox.HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if not Enabled or not Visible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;
  
  case uMsg of
    WM_KEYDOWN:
    begin
      case wParam of
        VK_SPACE:
        begin
          m_bPressed := True;
          Exit;
        end;
      end;
    end;

    WM_KEYUP:
    begin
      case wParam of
        VK_SPACE:
        begin
          if Pressed then
          begin
            m_bPressed := false;
            SetCheckedInternal(not Checked, True);
          end;
          Exit;
        end;
      end;
    end;
  end;
  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTCheckBox.HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if not Enabled or not Visible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      if ContainsPoint(pt) then
      begin
        // Pressed while inside the control
        m_bPressed := True;
        SetCapture(DXUTGetHWND);

        if (not m_bHasFocus) then m_pDialog.RequestFocus(Self);

        Exit;
      end;
    end;

    WM_LBUTTONUP:
    begin
      if Pressed then
      begin
        m_bPressed := false;
        ReleaseCapture;

        // Button click
        if ContainsPoint(pt) then SetCheckedInternal(not Checked, True);

        Exit;
      end;
    end;
  end;

  Result:= False;
end;

procedure CDXUTCheckBox.OnHotkey;
begin
  if m_pDialog.IsKeyboardInputEnabled then m_pDialog.RequestFocus(Self);
  SetCheckedInternal(not m_bChecked, True);
end;

function CDXUTCheckBox.GetChecked: Boolean;
begin
  Result:= m_bChecked;
end;

procedure CDXUTCheckBox.SetChecked(bChecked: Boolean);
begin
  SetCheckedInternal(bChecked, False);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTCheckBox.SetCheckedInternal(bChecked, bFromInput: Boolean);
begin
  m_bChecked := bChecked;

  m_pDialog.SendEvent(EVENT_CHECKBOX_CHANGED, bFromInput, Self);
end;


//--------------------------------------------------------------------------------------
function CDXUTCheckBox.ContainsPoint(pt: TPoint): LongBool;
begin
  Result:= PtInRect(m_rcBoundingBox, pt) or
           PtInRect(m_rcButton, pt);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTCheckBox.UpdateRects;
begin
  inherited;

  m_rcButton := m_rcBoundingBox;
  m_rcButton.right := m_rcButton.left + RectHeight(m_rcButton);

  m_rcText := m_rcBoundingBox;
  Inc(m_rcText.left, Trunc(1.25 * RectWidth(m_rcButton)));
end;


//--------------------------------------------------------------------------------------
procedure CDXUTCheckBox.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
var
  iState: TDXUTControlState;
  pElement: CDXUTElement;
  fBlendRate: Single;
begin
  iState := DXUT_STATE_NORMAL;

  if not Visible then iState := DXUT_STATE_HIDDEN else
  if not Enabled then iState := DXUT_STATE_DISABLED else
  if Pressed then iState := DXUT_STATE_PRESSED else
  if m_bMouseOver then iState := DXUT_STATE_MOUSEOVER else
  if m_bHasFocus then iState := DXUT_STATE_FOCUS;

  pElement := m_Elements[0];
    
  fBlendRate := IfThen((iState = DXUT_STATE_PRESSED), 0.0, 0.8);

  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  pElement.FontColor.Blend(iState, fElapsedTime, fBlendRate);

  m_pDialog.DrawSprite(pElement, m_rcButton);
  m_pDialog.DrawText(m_strText, pElement, m_rcText, True);

  if not Checked then iState := DXUT_STATE_HIDDEN;

  pElement := m_Elements[1];

  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcButton);
end;




//--------------------------------------------------------------------------------------
// CDXUTRadioButton class
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
constructor CDXUTRadioButton.Create(pDialog: CDXUTDialog = nil);
begin
  inherited;
  m_Type := DXUT_CONTROL_RADIOBUTTON;
  m_pDialog := pDialog;
end;



//--------------------------------------------------------------------------------------
function CDXUTRadioButton.HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if not Enabled or not Visible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;
  
  case uMsg of
    WM_KEYDOWN:
    begin
      case wParam of
        VK_SPACE:
        begin
          m_bPressed := True;
          Exit;
        end;

        WM_KEYUP:
        begin
          case wParam of
            VK_SPACE:
            begin
              if Pressed then
              begin
                m_bPressed := False;

                m_pDialog.ClearRadioButtonGroup(m_nButtonGroup);
                m_bChecked := not m_bChecked;

                m_pDialog.SendEvent(EVENT_RADIOBUTTON_CHANGED, True, Self);
              end;
              Exit;
            end;
          end;
        end;
      end;
    end; 
  end; {case}
  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTRadioButton.HandleMouse(uMsg: LongWord; pt: TPoint; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if not Enabled or not Visible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      if ContainsPoint(pt) then
      begin
        // Pressed while inside the control
        m_bPressed := true;
        SetCapture(DXUTGetHWND);

        if (not m_bHasFocus) then m_pDialog.RequestFocus(Self);
        Exit;
      end;
    end;

    WM_LBUTTONUP:
    begin
      if Pressed then
      begin
        m_bPressed := False;
        ReleaseCapture;

        // Button click
        if ContainsPoint(pt) then
        begin
          m_pDialog.ClearRadioButtonGroup(m_nButtonGroup);
          m_bChecked := not m_bChecked;

          m_pDialog.SendEvent(EVENT_RADIOBUTTON_CHANGED, True, Self);
        end;
        Exit;
      end;
    end;
  end;

  Result:= false;
end;

procedure CDXUTRadioButton.OnHotkey;
begin
  if m_pDialog.IsKeyboardInputEnabled then m_pDialog.RequestFocus(Self);
  SetCheckedInternal(True, True, True);
end;

procedure CDXUTRadioButton.SetChecked(bChecked: Boolean);
begin
  SetCheckedInternal(bChecked, True, False);
end;

procedure CDXUTRadioButton.SetChecked(bChecked: Boolean; bClearGroup: Boolean = True);
begin
  SetCheckedInternal(bChecked, bClearGroup, False);
end;

//--------------------------------------------------------------------------------------
procedure CDXUTRadioButton.SetCheckedInternal(bChecked, bClearGroup, bFromInput: Boolean);
begin
  if (bChecked and bClearGroup) then m_pDialog.ClearRadioButtonGroup(m_nButtonGroup);

  m_bChecked := bChecked;
  m_pDialog.SendEvent(EVENT_RADIOBUTTON_CHANGED, bFromInput, Self);
end;



//--------------------------------------------------------------------------------------
// CDXUTScrollBar class
//--------------------------------------------------------------------------------------

{ CDXUTScrollBar }

//--------------------------------------------------------------------------------------
constructor CDXUTScrollBar.Create(pDialog: CDXUTDialog);
begin
  inherited;
  m_Type := DXUT_CONTROL_SCROLLBAR;
  m_pDialog := pDialog;

  m_bShowThumb := True;
  m_bDrag := False;

  SetRect(m_rcUpButton, 0, 0, 0, 0);
  SetRect(m_rcDownButton, 0, 0, 0, 0);
  SetRect(m_rcTrack, 0, 0, 0, 0);
  SetRect(m_rcThumb, 0, 0, 0, 0);
  m_nPosition := 0;
  m_nPageSize := 1;
  m_nStart := 0;
  m_nEnd := 1;
  m_Arrow := CLEAR;
  m_dArrowTS := 0.0;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTScrollBar.Destroy;
begin
  inherited;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTScrollBar.UpdateRects;
begin
  inherited; 

  // Make the buttons square

  SetRect(m_rcUpButton, m_rcBoundingBox.left, m_rcBoundingBox.top,
                        m_rcBoundingBox.right, m_rcBoundingBox.top + RectWidth(m_rcBoundingBox));
  SetRect(m_rcDownButton, m_rcBoundingBox.left, m_rcBoundingBox.bottom - RectWidth(m_rcBoundingBox),
                          m_rcBoundingBox.right, m_rcBoundingBox.bottom);
  SetRect(m_rcTrack, m_rcUpButton.left, m_rcUpButton.bottom,
                     m_rcDownButton.right, m_rcDownButton.top);
  m_rcThumb.left := m_rcUpButton.left;
  m_rcThumb.right := m_rcUpButton.right;

  UpdateThumbRect;
end;


//--------------------------------------------------------------------------------------
// Compute the dimension of the scroll thumb
procedure CDXUTScrollBar.UpdateThumbRect;
var
  nThumbHeight: Integer;
  nMaxPosition: Integer;
begin
  if (m_nEnd - m_nStart > m_nPageSize) then
  begin
    nThumbHeight := Max(RectHeight(m_rcTrack) * m_nPageSize div (m_nEnd - m_nStart), SCROLLBAR_MINTHUMBSIZE);
    nMaxPosition := m_nEnd - m_nStart - m_nPageSize;
    m_rcThumb.top := m_rcTrack.top + (m_nPosition - m_nStart) * (RectHeight(m_rcTrack) - nThumbHeight) div nMaxPosition;
    m_rcThumb.bottom := m_rcThumb.top + nThumbHeight;
    m_bShowThumb := True;
  end else
  begin
    // No content to scroll
    m_rcThumb.bottom := m_rcThumb.top;
    m_bShowThumb := False;
  end;
end;


//--------------------------------------------------------------------------------------
// Scroll() scrolls by nDelta items.  A positive value scrolls down, while a negative
// value scrolls up.
procedure CDXUTScrollBar.Scroll(nDelta: Integer);
begin
  // Perform scroll
  Inc(m_nPosition, nDelta);

  // Cap position
  Cap;

  // Update thumb position
  UpdateThumbRect;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTScrollBar.ShowItem(nIndex: Integer);
begin
  // Cap the index
  if (nIndex < 0) then nIndex := 0;
  if (nIndex >= m_nEnd) then nIndex := m_nEnd - 1;

  // Adjust position
  if (m_nPosition > nIndex) then m_nPosition := nIndex else
  if (m_nPosition + m_nPageSize <= nIndex) then m_nPosition := nIndex - m_nPageSize + 1;

  UpdateThumbRect;
end;


//--------------------------------------------------------------------------------------
function CDXUTScrollBar.HandleKeyboard(uMsg: LongWord; wParam: WPARAM;
  lParam: LPARAM): Boolean;
begin
  Result:= False;
end;


//--------------------------------------------------------------------------------------
var
  ThumbOffsetY: Integer = 0;

function CDXUTScrollBar.HandleMouse(uMsg: LongWord; pt: TPoint;
  wParam: WPARAM; lParam: LPARAM): Boolean;
var
  nMaxFirstItem: Integer;
  nMaxThumb: Integer;
begin
  Result:= True;

  m_LastMouse := pt;
  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      // Check for click on up button
      if PtInRect(m_rcUpButton, pt) then
      begin
        SetCapture(DXUTGetHWND);
        if (m_nPosition > m_nStart) then Dec(m_nPosition);
        UpdateThumbRect;
        m_Arrow := CLICKED_UP;
        m_dArrowTS := DXUTGetTime;
        Exit;
      end;

      // Check for click on down button
      if PtInRect(m_rcDownButton, pt) then
      begin
        SetCapture(DXUTGetHWND);
        if (m_nPosition + m_nPageSize < m_nEnd) then Inc(m_nPosition);
        UpdateThumbRect;
        m_Arrow := CLICKED_DOWN;
        m_dArrowTS := DXUTGetTime;
        Exit;
      end;

      // Check for click on thumb
      if PtInRect(m_rcThumb, pt) then
      begin
        SetCapture(DXUTGetHWND);
        m_bDrag := True;
        ThumbOffsetY := pt.y - m_rcThumb.top;
        Exit;
      end;

      // Check for click on track
      if (m_rcThumb.left <= pt.x) and (m_rcThumb.right > pt.x) then
      begin
        SetCapture(DXUTGetHWND);
        if (m_rcThumb.top > pt.y) and
           (m_rcTrack.top <= pt.y) then
        begin
          Scroll(-(m_nPageSize - 1));
          Exit;
        end else
        if (m_rcThumb.bottom <= pt.y) and
           (m_rcTrack.bottom > pt.y) then
        begin
          Scroll(m_nPageSize - 1);
          Exit;
        end;
      end;
    end;

    WM_LBUTTONUP:
    begin
      m_bDrag := False;
      ReleaseCapture;
      UpdateThumbRect;
      m_Arrow := CLEAR;
    end;

    WM_MOUSEMOVE:
    begin
      if m_bDrag then
      begin
        Inc(m_rcThumb.bottom, pt.y - ThumbOffsetY - m_rcThumb.top);
        m_rcThumb.top := pt.y - ThumbOffsetY;
        if (m_rcThumb.top < m_rcTrack.top) then OffsetRect(m_rcThumb, 0, m_rcTrack.top - m_rcThumb.top) else
        if (m_rcThumb.bottom > m_rcTrack.bottom) then OffsetRect(m_rcThumb, 0, m_rcTrack.bottom - m_rcThumb.bottom);

        // Compute first item index based on thumb position
        nMaxFirstItem := m_nEnd - m_nStart - m_nPageSize;  // Largest possible index for first item
        nMaxThumb := RectHeight(m_rcTrack) - RectHeight(m_rcThumb);  // Largest possible thumb position from the top

        m_nPosition := m_nStart +
                      ( m_rcThumb.top - m_rcTrack.top +
                        nMaxThumb div (nMaxFirstItem * 2) ) * // Shift by half a row to avoid last row covered by only one pixel
                      nMaxFirstItem  div nMaxThumb;

        Exit;
      end;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTScrollBar.MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if (WM_CAPTURECHANGED = uMsg) then
  begin
    // The application just lost mouse capture. We may not have gotten
    // the WM_MOUSEUP message, so reset m_bDrag here.
    if (THandle(lParam) <> DXUTGetHWND) then m_bDrag := False;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTScrollBar.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
var
  dCurrTime: Double;
  iState: TDXUTControlState;
  fBlendRate: Single;
  pElement: CDXUTElement;
begin
  // Check if the arrow button has been held for a while.
  // If so, update the thumb position to simulate repeated
  // scroll.
  if (m_Arrow <> CLEAR) then
  begin
    dCurrTime := DXUTGetTime;
    if PtInRect(m_rcUpButton, m_LastMouse) then
    begin
      case m_Arrow of
        CLICKED_UP:
          if (SCROLLBAR_ARROWCLICK_DELAY < dCurrTime - m_dArrowTS) then
          begin
            Scroll(-1);
            m_Arrow := HELD_UP;
            m_dArrowTS := dCurrTime;
          end;

        HELD_UP:
          if (SCROLLBAR_ARROWCLICK_REPEAT < dCurrTime - m_dArrowTS) then
          begin
            Scroll(-1);
            m_dArrowTS := dCurrTime;
          end;
      end; {case}
    end else
    if PtInRect(m_rcDownButton, m_LastMouse) then
    begin
      case m_Arrow of
        CLICKED_DOWN:
          if (SCROLLBAR_ARROWCLICK_DELAY < dCurrTime - m_dArrowTS) then
          begin
            Scroll(1);
            m_Arrow := HELD_DOWN;
            m_dArrowTS := dCurrTime;
          end;

        HELD_DOWN:
          if (SCROLLBAR_ARROWCLICK_REPEAT < dCurrTime - m_dArrowTS) then
          begin
            Scroll(1);
            m_dArrowTS := dCurrTime;
          end;
      end;
    end;
  end;


  iState := DXUT_STATE_NORMAL;

  if not m_bVisible then iState := DXUT_STATE_HIDDEN
  else if (not m_bEnabled or not m_bShowThumb) then iState := DXUT_STATE_DISABLED
  else if m_bMouseOver then iState := DXUT_STATE_MOUSEOVER
  else if m_bHasFocus  then iState := DXUT_STATE_FOCUS;

  fBlendRate := IfThen(iState = DXUT_STATE_PRESSED, 0.0, 0.8);

  // Background track layer
  pElement := m_Elements[0];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcTrack);

  // Up Arrow
  pElement := m_Elements[1];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcUpButton);

  // Down Arrow
  pElement := m_Elements[2];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcDownButton);

  // Thumb button
  pElement := m_Elements[3];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcThumb);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTScrollBar.SetTrackRange(nStart, nEnd: Integer);
begin
  m_nStart := nStart;
  m_nEnd := nEnd;
  Cap;
  UpdateThumbRect;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTScrollBar.Cap; // Clips position at boundaries. Ensures it stays within legal range.
begin
  if (m_nPosition < m_nStart) or
     (m_nEnd - m_nStart <= m_nPageSize) then
  begin
    m_nPosition := m_nStart;
  end else
  if (m_nPosition + m_nPageSize > m_nEnd)
  then m_nPosition := m_nEnd - m_nPageSize;
end;


procedure CDXUTScrollBar.SetPageSize(nPageSize: Integer);
begin
  m_nPageSize := nPageSize;
  Cap;
  UpdateThumbRect;
end;


procedure CDXUTScrollBar.SetTrackPos(nPosition: Integer);
begin
  m_nPosition := nPosition;
  Cap;
  UpdateThumbRect;
end;



//--------------------------------------------------------------------------------------
// CDXUTListBox class
//--------------------------------------------------------------------------------------

{ CDXUTListBox }

//--------------------------------------------------------------------------------------
constructor CDXUTListBox.Create(pDialog: CDXUTDialog);
begin
  m_ScrollBar:= CDXUTScrollBar.Create(pDialog);
  m_Items:= TList.Create;
  inherited;

  m_Type := DXUT_CONTROL_LISTBOX;
  m_pDialog := pDialog;

  m_dwStyle := NORMAL;
  m_nSBWidth := 16;
  m_nSelected := -1;
  m_nSelStart := 0;
  m_bDrag := false;
  m_nBorder := 6;
  m_nMargin := 5;
  m_nTextHeight := 0;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTListBox.Destroy;
begin
  RemoveAllItems;
  FreeAndNil(m_Items);
  FreeAndNil(m_ScrollBar);
  inherited;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTListBox.UpdateRects;
var
  pFontNode: PDXUTFontNode;
begin
  inherited;

  m_rcSelection := m_rcBoundingBox;
  Dec(m_rcSelection.right, m_nSBWidth);
  InflateRect(m_rcSelection, -m_nBorder, -m_nBorder);
  m_rcText := m_rcSelection;
  InflateRect(m_rcText, -m_nMargin, 0);

  // Update the scrollbar's rects
  m_ScrollBar.SetLocation(m_rcBoundingBox.right - m_nSBWidth, m_rcBoundingBox.top);
  m_ScrollBar.SetSize(m_nSBWidth, m_height);
  pFontNode := m_pDialog.Manager.FontNode[m_Elements[0].iFont];
  if (pFontNode <> nil) and (pFontNode.nHeight <> 0) then
  begin
    m_ScrollBar.SetPageSize(RectHeight(m_rcText) div pFontNode.nHeight);

    // The selected item may have been scrolled off the page.
    // Ensure that it is in page again.
    m_ScrollBar.ShowItem(m_nSelected);
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTListBox.AddItem(const wszText: PWideChar; pData: Pointer): HRESULT;
var
  pNewItem: PDXUTListBoxItem;
begin
  Result:= S_OK;
  pNewItem:= nil;
  try
    New(pNewItem);

    StringCchCopy(pNewItem.strText, 256, wszText);
    pNewItem.pData := pData;
    SetRect(pNewItem.rcActive, 0, 0, 0, 0);
    pNewItem.bSelected := False;

    m_Items.Add(pNewItem);
    m_ScrollBar.SetTrackRange(0, m_Items.Count);
  except
    Dispose(pNewItem);
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTListBox.InsertItem(nIndex: Integer; const wszText: PWideChar;
  pData: Pointer): HRESULT;
var
  pNewItem: PDXUTListBoxItem;
begin
  Result:= S_OK;
  pNewItem:= nil;
  try
    New(pNewItem);

    StringCchCopy(pNewItem.strText, 256, wszText);
    pNewItem.pData := pData;
    SetRect(pNewItem.rcActive, 0, 0, 0, 0);
    pNewItem.bSelected := False;

    m_Items.Insert(nIndex, pNewItem);
    m_ScrollBar.SetTrackRange(0, m_Items.Count);
  except
    Dispose(pNewItem);
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTListBox.RemoveItem(nIndex: Integer);
var
  pItem: PDXUTListBoxItem;
begin
  if (nIndex < 0) or (nIndex >= m_Items.Count) then Exit;

  pItem := PDXUTListBoxItem(m_Items[nIndex]);
  Dispose(pItem);
  m_Items.Delete(nIndex); // Remove(nIndex);

  m_ScrollBar.SetTrackRange(0, m_Items.Count);
  if (m_nSelected >= m_Items.Count) then m_nSelected := m_Items.Count - 1;

  m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTListBox.RemoveItemByText(wszText: PWideChar);
begin
end;


//--------------------------------------------------------------------------------------
procedure CDXUTListBox.RemoveItemByData(pData: Pointer);
begin
end;


//--------------------------------------------------------------------------------------
procedure CDXUTListBox.RemoveAllItems;
var
  i: Integer;
  pItem: PDXUTListBoxItem;
begin
  for i := 0 to m_Items.Count - 1 do
  begin
    pItem := PDXUTListBoxItem(m_Items[i]);
    Dispose(pItem);
  end;

  m_Items.Clear; // RemoveAll;
  m_ScrollBar.SetTrackRange(0, 1);
end;


//--------------------------------------------------------------------------------------
function CDXUTListBox.GetItem(nIndex: Integer): PDXUTListBoxItem;
begin
  Result:= nil;
  if (nIndex < 0) or (nIndex >= m_Items.Count) then Exit;
  Result:= m_Items[nIndex];
end;


//--------------------------------------------------------------------------------------
// For single-selection listbox, returns the index of the selected item.
// For multi-selection, returns the first selected item after the nPreviousSelected position.
// To search for the first selected item, the app passes -1 for nPreviousSelected.  For
// subsequent searches, the app passes the returned index back to GetSelectedIndex as.
// nPreviousSelected.
// Returns -1 on error or if no item is selected.
function CDXUTListBox.GetSelectedIndex(nPreviousSelected: Integer): Integer;
var
  i: Integer;
  pItem: PDXUTListBoxItem;
begin
  Result:= -1;
  if (nPreviousSelected < -1) then Exit;

  if (m_dwStyle = MULTISELECTION) then
  begin
    // Multiple selection enabled. Search for the next item with the selected flag.
    for i := nPreviousSelected + 1 to m_Items.Count - 1 do
    begin
      pItem := PDXUTListBoxItem(m_Items[i]);

      if (pItem.bSelected) then
      begin
        Result:= i;
        Exit;
      end;
    end;

    Result:= -1;
  end else
  begin
    // Single selection
    Result:= m_nSelected;
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTListBox.SelectItem(nNewIndex: Integer);
var
  nOldSelected: Integer;
begin
  // If no item exists, do nothing.
  if (m_Items.Count = 0) then Exit;

  nOldSelected := m_nSelected;

  // Adjust m_nSelected
  m_nSelected := nNewIndex;

  // Perform capping
  if (m_nSelected < 0) then m_nSelected := 0;
  if (m_nSelected >= m_Items.Count) then m_nSelected := m_Items.Count - 1;

  if (nOldSelected <> m_nSelected) then
  begin
    if (m_dwStyle = MULTISELECTION) then
    begin
      PDXUTListBoxItem(m_Items[m_nSelected])^.bSelected := True;
    end;

    // Update selection start
    m_nSelStart := m_nSelected;

    // Adjust scroll bar
    m_ScrollBar.ShowItem(m_nSelected);
  end;

  m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
end;


//--------------------------------------------------------------------------------------
function CDXUTListBox.HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
var
  nOldSelected: Integer;
  i, n: Integer;
  nEnd: Integer;
begin
  Result:= True;
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

  // Let the scroll bar have a chance to handle it first
  if m_ScrollBar.HandleKeyboard(uMsg, wParam, lParam) then Exit;

  case uMsg of
    WM_KEYDOWN:
    begin
      case wParam of
        VK_UP, VK_DOWN,
        VK_NEXT, VK_PRIOR,
        VK_HOME, VK_END:
        begin
          // If no item exists, do nothing.
          if (m_Items.Count = 0) then Exit;
          nOldSelected := m_nSelected;

          // Adjust m_nSelected
          case wParam of
            VK_UP:    Dec(m_nSelected);
            VK_DOWN:  Inc(m_nSelected);
            VK_NEXT:  Inc(m_nSelected, m_ScrollBar.PageSize - 1);
            VK_PRIOR: Dec(m_nSelected, m_ScrollBar.PageSize - 1);
            VK_HOME:  m_nSelected := 0;
            VK_END:   m_nSelected := m_Items.Count - 1;
          end;

          // Perform capping
          if (m_nSelected < 0) then m_nSelected := 0;
          if (m_nSelected >= m_Items.Count) then m_nSelected := m_Items.Count - 1;

          if (nOldSelected <> m_nSelected) then
          begin
            if (m_dwStyle = MULTISELECTION) then
            begin
              // Multiple selection

              // Clear all selection
              for i := 0 to m_Items.Count - 1 do
              begin
                PDXUTListBoxItem(m_Items[i]).bSelected := False;
              end;

              if (GetKeyState(VK_SHIFT) < 0) then
              begin
                // Select all items from m_nSelStart to
                // m_nSelected
                nEnd := Max(m_nSelStart, m_nSelected);

                for n := Min(m_nSelStart, m_nSelected) to nEnd - 1 do
                  PDXUTListBoxItem(m_Items[n]).bSelected := true;
              end else
              begin
                PDXUTListBoxItem(m_Items[m_nSelected]).bSelected := True;

                // Update selection start
                m_nSelStart := m_nSelected;
              end;
            end else
              m_nSelStart := m_nSelected;

            // Adjust scroll bar
            m_ScrollBar.ShowItem(m_nSelected);

            // Send notification
            m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
          end;
          Exit;
        end;

        // Space is the hotkey for double-clicking an item.
        //
        VK_SPACE:
        begin
          m_pDialog.SendEvent(EVENT_LISTBOX_ITEM_DBLCLK, True, Self);
          Exit;
        end;
      end;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTListBox.HandleMouse(uMsg: LongWord; pt: TPoint;
  wParam: WPARAM; lParam: LPARAM): Boolean;
var
  nClicked: Integer;
  pSelItem: PDXUTListBoxItem;
  nBegin, nEnd: Integer;
  i, n: Integer;
  bLastSelected: Boolean;
  nItem: Integer;
  uLines: LongWord;
  nScrollAmount: Integer;  
begin
  Result:= True;
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

  // First acquire focus
  if (WM_LBUTTONDOWN = uMsg) and (not m_bHasFocus)
  then m_pDialog.RequestFocus(Self);

  // Let the scroll bar handle it first.
  if m_ScrollBar.HandleMouse( uMsg, pt, wParam, lParam) then Exit;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      // Check for clicks in the text area
      if (m_Items.Count > 0) and PtInRect(m_rcSelection, pt) then
      begin
        // Compute the index of the clicked item

        if (m_nTextHeight <> 0)
        then nClicked := m_ScrollBar.TrackPos + (pt.y - m_rcText.top) div m_nTextHeight
        else nClicked := -1;

        // Only proceed if the click falls on top of an item.

        if (nClicked >= m_ScrollBar.TrackPos) and
           (nClicked < m_Items.Count) and
           (nClicked < m_ScrollBar.TrackPos + m_ScrollBar.PageSize) then
        begin
          SetCapture(DXUTGetHWND);
          m_bDrag := True;

          // If this is a double click, fire off an event and exit
          // since the first click would have taken care of the selection
          // updating.
          if (uMsg = WM_LBUTTONDBLCLK) then
          begin
            m_pDialog.SendEvent(EVENT_LISTBOX_ITEM_DBLCLK, True, Self);
            Exit;
          end;

          m_nSelected := nClicked;
          if (wParam and MK_SHIFT = 0) then m_nSelStart := m_nSelected;

          // If this is a multi-selection listbox, update per-item
          // selection data.
          if (m_dwStyle = MULTISELECTION) then
          begin
            pSelItem := PDXUTListBoxItem(m_Items[m_nSelected]);

            // Determine behavior based on the state of Shift and Ctrl
            if (wParam and (MK_SHIFT or MK_CONTROL) = MK_CONTROL) then
            begin
              // Control click. Reverse the selection of this item.
              pSelItem.bSelected := not pSelItem.bSelected;
            end else
            if (wParam and (MK_SHIFT or MK_CONTROL) = MK_SHIFT) then
            begin
              // Shift click. Set the selection for all items
              // from last selected item to the current item.
              // Clear everything else.

              nBegin := Min(m_nSelStart, m_nSelected);
              nEnd := Max(m_nSelStart, m_nSelected);

              for i := 0 to nBegin - 1 do
                PDXUTListBoxItem(m_Items[i]).bSelected := False;

              for i := nEnd + 1 to m_Items.Count - 1 do
                PDXUTListBoxItem(m_Items[i]).bSelected := False;

              for i := nBegin to nEnd do
                PDXUTListBoxItem(m_Items[i]).bSelected := True;

            end else
            if (wParam and (MK_SHIFT or MK_CONTROL) = (MK_SHIFT or MK_CONTROL)) then
            begin
              // Control-Shift-click.

              // The behavior is:
              //   Set all items from m_nSelStart to m_nSelected to
              //     the same state as m_nSelStart, not including m_nSelected.
              //   Set m_nSelected to selected.

              nBegin := Min(m_nSelStart, m_nSelected);
              nEnd := Max(m_nSelStart, m_nSelected);

              // The two ends do not need to be set here.

              bLastSelected := PDXUTListBoxItem(m_Items[m_nSelStart]).bSelected;
              for i := nBegin + 1 to nEnd - 1 do
                PDXUTListBoxItem(m_Items[i]).bSelected := bLastSelected;

              pSelItem.bSelected := True;

              // Restore m_nSelected to the previous value
              // This matches the Windows behavior

              m_nSelected := m_nSelStart;
            end else
            begin
              // Simple click.  Clear all items and select the clicked
              // item.

              for i := 0 to m_Items.Count - 1 do
                PDXUTListBoxItem(m_Items[i]).bSelected := False;

              pSelItem.bSelected := True;
            end;
          end;  // End of multi-selection case

          m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
        end;

        Exit;
      end;
    end;

    WM_LBUTTONUP:
    begin
      ReleaseCapture;
      m_bDrag := False;

      if (m_nSelected <> -1) then
      begin
        // Set all items between m_nSelStart and m_nSelected to
        // the same state as m_nSelStart
        nEnd := Max(m_nSelStart, m_nSelected);

        for n := Min(m_nSelStart, m_nSelected) + 1 to nEnd - 1 do
          PDXUTListBoxItem(m_Items[n]).bSelected := PDXUTListBoxItem(m_Items[m_nSelStart]).bSelected;
        PDXUTListBoxItem(m_Items[m_nSelected]).bSelected := PDXUTListBoxItem(m_Items[m_nSelStart]).bSelected;

        // If m_nSelStart and m_nSelected are not the same,
        // the user has dragged the mouse to make a selection.
        // Notify the application of this.
        if (m_nSelStart <> m_nSelected)
        then m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);

        m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION_END, True, Self);
      end;
      Result:= False;
      Exit;
    end;

    WM_MOUSEMOVE:
    if m_bDrag then
    begin
      // Compute the index of the item below cursor

      if (m_nTextHeight <> 0) 
      then nItem := m_ScrollBar.TrackPos + (pt.y - m_rcText.top) div m_nTextHeight
      else nItem := -1;

      // Only proceed if the cursor is on top of an item.

      if (nItem >= m_ScrollBar.TrackPos) and
         (nItem < m_Items.Count) and
         (nItem < m_ScrollBar.TrackPos + m_ScrollBar.PageSize) then
      begin
        m_nSelected := nItem;
        m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
      end else
      if (nItem < m_ScrollBar.TrackPos) then
      begin
        // User drags the mouse above window top
        m_ScrollBar.Scroll(-1);
        m_nSelected := m_ScrollBar.TrackPos;
        m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
      end else
      if (nItem >= m_ScrollBar.TrackPos + m_ScrollBar.PageSize) then
      begin
        // User drags the mouse below window bottom
        m_ScrollBar.Scroll(1);
        m_nSelected := Min(m_Items.Count, m_ScrollBar.TrackPos + m_ScrollBar.PageSize ) - 1;
        m_pDialog.SendEvent(EVENT_LISTBOX_SELECTION, True, Self);
      end;
    end;

    WM_MOUSEWHEEL:
    begin
      SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @uLines, 0);
      nScrollAmount := Integer(ShortInt(HIWORD(wParam))) div WHEEL_DELTA * Integer(uLines);
      m_ScrollBar.Scroll( -nScrollAmount);
      Result:= true;
      Exit;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTListBox.MsgProc(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  if (WM_CAPTURECHANGED = uMsg) then
  begin
    // The application just lost mouse capture. We may not have gotten
    // the WM_MOUSEUP message, so reset m_bDrag here.
    if (THandle(lParam) <> DXUTGetHWND) then m_bDrag := False;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
var bSBInit: Boolean = False;

procedure CDXUTListBox.Render(pd3dDevice: IDirect3DDevice9;
  fElapsedTime: Single);
var
  pElement: CDXUTElement;
  pSelElement: CDXUTElement;
  rc, rcSel: TRect;
  i: Integer;
  pItem: PDXUTListBoxItem;
  bSelectedStyle: Boolean;
begin
  if (m_bVisible = False) then Exit;

  pElement := m_Elements[0];
  pElement.TextureColor.Blend(DXUT_STATE_NORMAL, fElapsedTime);
  pElement.FontColor.Blend(DXUT_STATE_NORMAL, fElapsedTime);

  pSelElement := m_Elements[1];
  pSelElement.TextureColor.Blend(DXUT_STATE_NORMAL, fElapsedTime);
  pSelElement.FontColor.Blend(DXUT_STATE_NORMAL, fElapsedTime);

  m_pDialog.DrawSprite(pElement, m_rcBoundingBox);

  // Render the text
  if (m_Items.Count > 0) then
  begin
    // Find out the height of a single line of text
    rc := m_rcText;
    rcSel := m_rcSelection;
    rc.bottom := rc.top + m_pDialog.Manager.FontNode[pElement.iFont].nHeight;

    // Update the line height formation
    m_nTextHeight := rc.bottom - rc.top;

    if not bSBInit then
    begin
      // Update the page size of the scroll bar
      if (m_nTextHeight <> 0)
      then m_ScrollBar.SetPageSize(RectHeight(m_rcText) div m_nTextHeight)
      else m_ScrollBar.SetPageSize(RectHeight(m_rcText));
      bSBInit := True;
    end;

    rc.right := m_rcText.right;
    for i := m_ScrollBar.TrackPos to m_Items.Count - 1 do
    begin
      if (rc.bottom > m_rcText.bottom) then Break;

      pItem := PDXUTListBoxItem(m_Items[i]);

      // Determine if we need to render this item with the
      // selected element.
      bSelectedStyle := False;

      if (m_dwStyle <> MULTISELECTION) and (i = m_nSelected)
      then bSelectedStyle := True
      else if (m_dwStyle = MULTISELECTION) then
      begin
        if m_bDrag and
           ( (i >= m_nSelected) and (i < m_nSelStart) or
             (i <= m_nSelected) and (i > m_nSelStart) )
        then bSelectedStyle := PDXUTListBoxItem(m_Items[m_nSelStart]).bSelected
        else if pItem.bSelected then
          bSelectedStyle := True;
      end;

      if bSelectedStyle then
      begin
        rcSel.top := rc.top;
        rcSel.bottom := rc.bottom;
        m_pDialog.DrawSprite(pSelElement, rcSel);
        m_pDialog.DrawText(pItem.strText, pSelElement, rc);
      end else
        m_pDialog.DrawText(pItem.strText, pElement, rc);

      OffsetRect(rc, 0, m_nTextHeight);
    end;
  end;

  // Render the scroll bar
  m_ScrollBar.Render(pd3dDevice, fElapsedTime);
end;


function CDXUTListBox.CanHaveFocus: Boolean;
begin
  Result:= m_bVisible and m_bEnabled;
end;


function CDXUTListBox.GetSelectedItem(nPreviousSelected: Integer): PDXUTListBoxItem;
begin
  Result:= GetItem(GetSelectedIndex(nPreviousSelected));
end;


function CDXUTListBox.OnInit: HRESULT;
begin
  Result:= m_pDialog.InitControl(m_ScrollBar);
end;


procedure CDXUTListBox.SetBorder(nBorder, nMargin: Integer);
begin
  m_nBorder := nBorder;
  m_nMargin := nMargin;
end;

procedure CDXUTListBox.SetScrollBarWidth(nWidth: Integer);
begin
  m_nSBWidth := nWidth;
  UpdateRects;
end;

procedure CDXUTListBox.SetStyle(dwStyle: TDXUTLBStyle);
begin
  m_dwStyle := dwStyle;
end;

function CDXUTListBox.GetSize: Integer;
begin
  Result:= m_Items.Count;
end;


//--------------------------------------------------------------------------------------
// CDXUTComboBox class
//--------------------------------------------------------------------------------------

{ CDXUTComboBox }

//--------------------------------------------------------------------------------------
constructor CDXUTComboBox.Create(pDialog: CDXUTDialog);
begin
  m_ScrollBar:= CDXUTScrollBar.Create(pDialog);
  inherited;

  m_Type := DXUT_CONTROL_COMBOBOX;
  m_pDialog := pDialog;

  m_nDropHeight := 100;

  m_nSBWidth := 16;
  m_bOpened := False;
  m_iSelected := -1;
  m_iFocused := -1;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTComboBox.Destroy;
begin
  RemoveAllItems;
  FreeAndNil(m_ScrollBar);
  inherited;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTComboBox.SetTextColor(Color: TD3DColor);
var
  pElement: CDXUTElement;
begin
  pElement := m_Elements[0];

  if (pElement <> nil) then
    pElement.FontColor.States[DXUT_STATE_NORMAL] := Color;

  pElement := m_Elements[2];

  if (pElement <> nil) then
    pElement.FontColor.States[DXUT_STATE_NORMAL] := Color;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTComboBox.UpdateRects;
var
  pFontNode: PDXUTFontNode;
begin
  inherited;

  m_rcButton := m_rcBoundingBox;
  m_rcButton.left := m_rcButton.right - RectHeight(m_rcButton);

  m_rcText := m_rcBoundingBox;
  m_rcText.right := m_rcButton.left;

  m_rcDropdown := m_rcText;
  OffsetRect(m_rcDropdown, 0, Trunc(0.90 * RectHeight(m_rcText)));
  Inc(m_rcDropdown.bottom,  m_nDropHeight);
  Dec(m_rcDropdown.right, m_nSBWidth);

  m_rcDropdownText := m_rcDropdown;
  Inc(m_rcDropdownText.left,   Trunc(0.1 * RectWidth(m_rcDropdown)));
  Dec(m_rcDropdownText.right,  Trunc(0.1 * RectWidth(m_rcDropdown)));
  Inc(m_rcDropdownText.top,    Trunc(0.1 * RectHeight(m_rcDropdown)));
  Dec(m_rcDropdownText.bottom, Trunc(0.1 * RectHeight(m_rcDropdown)));

  // Update the scrollbar's rects
  m_ScrollBar.SetLocation(m_rcDropdown.right, m_rcDropdown.top+2);
  m_ScrollBar.SetSize(m_nSBWidth, RectHeight(m_rcDropdown)-2);
  pFontNode := m_pDialog.Manager.FontNode[m_Elements[2].iFont];
  if (pFontNode <> nil) and (pFontNode.nHeight <> 0) then
  begin
    m_ScrollBar.SetPageSize(RectHeight(m_rcDropdownText) div pFontNode.nHeight);

    // The selected item may have been scrolled off the page.
    // Ensure that it is in page again.
    m_ScrollBar.ShowItem(m_iSelected);
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTComboBox.OnFocusOut;
begin
  inherited;
  m_bOpened := False;
end;



//--------------------------------------------------------------------------------------
function CDXUTComboBox.HandleKeyboard(uMsg: LongWord; wParam: WPARAM;
  lParam: LPARAM): Boolean;
const
  REPEAT_MASK = $40000000;
begin
  Result:= True;
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;                 
    Exit;
  end;

  // Let the scroll bar have a chance to handle it first
  if m_ScrollBar.HandleKeyboard(uMsg, wParam, lParam) then Exit;

  case uMsg of
    WM_KEYDOWN:
    case wParam of
      VK_RETURN:
      if m_bOpened then
      begin
        if (m_iSelected <> m_iFocused) then
        begin
          m_iSelected := m_iFocused;
          m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
        end;
        m_bOpened := False;

        if not m_pDialog.m_bKeyboardInput then m_pDialog.ClearFocus;
        
        Exit;
      end;

      VK_F4:
      begin
        // Filter out auto-repeats
        if (lParam and REPEAT_MASK <> 0) then Exit;

        m_bOpened := not m_bOpened;

        if not m_bOpened then
        begin
          m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
          if not m_pDialog.m_bKeyboardInput then m_pDialog.ClearFocus;
        end;
        
        Exit;
      end;

      VK_LEFT, VK_UP:
      begin
        if (m_iFocused > 0) then
        begin
          Dec(m_iFocused);
          m_iSelected := m_iFocused;

          if not m_bOpened then
            m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
        end;
        Exit;
      end;

      VK_RIGHT, VK_DOWN:
      begin
        if (m_iFocused+1 < Integer(GetNumItems)) then
        begin
          Inc(m_iFocused);
          m_iSelected := m_iFocused;

          if not m_bOpened then
            m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
        end;
        Exit;
      end;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.HandleMouse(uMsg: LongWord; pt: TPoint;
  wParam: WPARAM; lParam: LPARAM): Boolean;
var
  i: Integer;
  pItem: PDXUTComboBoxItem;
  zDelta: Integer;
  uLines: LongWord;
begin
  Result:= True;
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

  // Let the scroll bar handle it first.
  if m_ScrollBar.HandleMouse(uMsg, pt, wParam, lParam) then Exit;

  case uMsg of
    WM_MOUSEMOVE:
    begin
      if m_bOpened and PtInRect(m_rcDropdown, pt) then
      begin
        // Determine which item has been selected
        for i:= 0 to Length(m_Items) - 1 do
        begin
          pItem := m_Items[i];
          if pItem.bVisible and PtInRect(pItem.rcActive, pt)
          then m_iFocused := i;
        end;
        Exit;
      end;
    end;

    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      if ContainsPoint(pt) then
      begin
        // Pressed while inside the control
        m_bPressed := True;
        SetCapture(DXUTGetHWND);

        if not m_bHasFocus then m_pDialog.RequestFocus(Self);

        // Toggle dropdown
        if m_bHasFocus then
        begin
          m_bOpened := not m_bOpened;

          if not m_bOpened then
            if not m_pDialog.m_bKeyboardInput then m_pDialog.ClearFocus;
        end;
        Exit;
      end;

      // Perhaps this click is within the dropdown
      if m_bOpened and PtInRect(m_rcDropdown, pt) then
      begin
        // Determine which item has been selected
        for i:= m_ScrollBar.TrackPos to Length(m_Items) - 1 do
        begin
          pItem := m_Items[i];
          if pItem.bVisible and PtInRect(pItem.rcActive, pt) then
          begin
            m_iSelected := i;
            m_iFocused := i;
            m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
            m_bOpened := False;

            if not m_pDialog.m_bKeyboardInput then m_pDialog.ClearFocus;
            Break;
          end;
        end;

        Exit;
      end;

      // Mouse click not on main control or in dropdown, fire an event if needed
      if m_bOpened then
      begin
        m_iFocused := m_iSelected;

        m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
        m_bOpened := False;
      end;

      // Make sure the control is no longer in a pressed state
      m_bPressed := False;

      // Release focus if appropriate
      if not m_pDialog.m_bKeyboardInput then m_pDialog.ClearFocus;
    end;

    WM_LBUTTONUP:
    begin
      if m_bPressed and ContainsPoint(pt) then
      begin
        // Button click
        m_bPressed := False;
        ReleaseCapture;
        Exit;
      end;
    end;

    WM_MOUSEWHEEL:
    begin
      zDelta := HIWORD(wParam) div WHEEL_DELTA;
      if m_bOpened then 
      begin
        SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @uLines, 0);
        m_ScrollBar.Scroll(-zDelta * Integer(uLines));
      end else
      begin
        if (zDelta > 0) then
        begin
          if (m_iFocused > 0) then
          begin
            Dec(m_iFocused);
            m_iSelected := m_iFocused;

            if not m_bOpened then
              m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
          end;
        end else
        begin
          if (m_iFocused + 1 < Integer(GetNumItems)) then
          begin
            Inc(m_iFocused);
            m_iSelected := m_iFocused;

            if not m_bOpened then
              m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
          end;
        end;
      end;
      Exit;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTComboBox.OnHotkey;
begin
  if m_bOpened then Exit;
  if (m_iSelected = -1) then Exit;

  if m_pDialog.IsKeyboardInputEnabled then m_pDialog.RequestFocus(Self);

  Inc(m_iSelected);
  if (m_iSelected >= Length(m_Items)) then m_iSelected := 0;

  m_iFocused := m_iSelected;
  m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, True, Self);
end;


//--------------------------------------------------------------------------------------
//var CDXUTComboBox_bSBInit: Boolean = False;

procedure CDXUTComboBox.Render(pd3dDevice: IDirect3DDevice9;
  fElapsedTime: Single);
var
  iState: TDXUTControlState;
  pElement: CDXUTElement;
  pSelectionElement: CDXUTElement;
  pFont: PDXUTFontNode;
  curY: Integer;
  nRemainingHeight: Integer;
  i: Integer;
  pItem: PDXUTComboBoxItem;
  rc: TRect;
  nOffsetX: Integer;
  nOffsetY: Integer;
  fBlendRate: Single;
  rcWindow: TRect;
begin
  iState := DXUT_STATE_NORMAL;

  if not m_bOpened then iState := DXUT_STATE_HIDDEN;

  // Dropdown box
  pElement := m_Elements[2];

  // If we have not initialized the scroll bar page size,
  // do that now.
  if not bSBInit then
  begin
    // Update the page size of the scroll bar
    if (m_pDialog.Manager.FontNode[pElement.iFont].nHeight <> 0)
    then m_ScrollBar.SetPageSize(RectHeight(m_rcDropdownText) div m_pDialog.Manager.FontNode[pElement.iFont].nHeight)
    else m_ScrollBar.SetPageSize(RectHeight(m_rcDropdownText));
    bSBInit := true;
  end;

  // Scroll bar
  if m_bOpened then
    m_ScrollBar.Render(pd3dDevice, fElapsedTime);

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime);
  pElement.FontColor.Blend(iState, fElapsedTime);

  m_pDialog.DrawSprite(pElement, m_rcDropdown);

  // Selection outline
  pSelectionElement := m_Elements[3];
  pSelectionElement.TextureColor.Current := pElement.TextureColor.Current;
  pSelectionElement.FontColor.Current := D3DXColorFromDWord(pSelectionElement.FontColor.States[DXUT_STATE_NORMAL]);

  pFont := m_pDialog.GetFont(pElement.iFont);
  if Assigned(pFont) then
  begin
    curY := m_rcDropdownText.top;
    nRemainingHeight := RectHeight(m_rcDropdownText);
    //WCHAR strDropdown[4096] = {0};

    for i := m_ScrollBar.TrackPos to Length(m_Items) - 1 do
    begin
      pItem := m_Items[i];

      // Make sure there's room left in the dropdown
      Dec(nRemainingHeight, pFont.nHeight);
      if (nRemainingHeight < 0) then
      begin
        pItem.bVisible := False;
        Continue;
      end;

      SetRect(pItem.rcActive, m_rcDropdownText.left, curY, m_rcDropdownText.right, curY + pFont.nHeight);
      Inc(curY, pFont.nHeight);

      //debug
      //int blue = 50 * i;
      //m_pDialog->DrawRect( &pItem->rcActive, 0xFFFF0000 | blue );

      pItem.bVisible := True;

      if m_bOpened then
      begin
        if (i = m_iFocused) then
        begin
          SetRect(rc, m_rcDropdown.left, pItem.rcActive.top-2, m_rcDropdown.right, pItem.rcActive.bottom+2);
          m_pDialog.DrawSprite(pSelectionElement, rc);
          m_pDialog.DrawText(pItem.strText, pSelectionElement, pItem.rcActive);
        end else
        begin
          m_pDialog.DrawText(pItem.strText, pElement, pItem.rcActive);
        end;
      end;
    end;
  end;

  nOffsetX := 0;
  nOffsetY := 0;

  iState := DXUT_STATE_NORMAL;

  if not m_bVisible then iState := DXUT_STATE_HIDDEN
  else if not m_bEnabled then iState := DXUT_STATE_DISABLED
  else if m_bPressed  then
  begin
    iState := DXUT_STATE_PRESSED;

    nOffsetX := 1;
    nOffsetY := 2;
  end
  else if m_bMouseOver then
  begin
    iState := DXUT_STATE_MOUSEOVER;

    nOffsetX := -1;
    nOffsetY := -2;
  end
  else if m_bHasFocus then
    iState := DXUT_STATE_FOCUS;

  fBlendRate := IfThen(iState = DXUT_STATE_PRESSED, 0.0, 0.8);

  // Button
  pElement := m_Elements[1];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);

  rcWindow := m_rcButton;
  OffsetRect(rcWindow, nOffsetX, nOffsetY);
  m_pDialog.DrawSprite(pElement, rcWindow);

  if m_bOpened then iState := DXUT_STATE_PRESSED;

  // Main text box
  //TODO: remove magic numbers
  pElement := m_Elements[0];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  pElement.FontColor.Blend(iState, fElapsedTime, fBlendRate);

  m_pDialog.DrawSprite(pElement, m_rcText);

  if (m_iSelected >= 0) and (m_iSelected < Length(m_Items)) then
  begin
    pItem := m_Items[m_iSelected];
    if (pItem <> nil) then m_pDialog.DrawText(pItem.strText, pElement, m_rcText);
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.AddItem(const strText: PWideChar; pData: Pointer): HRESULT;
var
  pItem: PDXUTComboBoxItem;
  l: Integer;
begin
  // Validate parameters
  if (strText = nil) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  // Create a new item and set the data
  try
    New(pItem);
  except
    Result:= DXTRACE_ERR_MSGBOX('new', E_OUTOFMEMORY);
    Exit;
  end;

  ZeroMemory(pItem, SizeOf(TDXUTComboBoxItem));
  StringCchCopy(pItem.strText, 256, strText);
  pItem.pData := pData;

  // m_Items.Add(pItem);
  l:= Length(m_Items);
  SetLength(m_Items, l+1);
  m_Items[l]:= pItem;

  // Update the scroll bar with new range
  m_ScrollBar.SetTrackRange(0, Length(m_Items));

  // If this is the only item in the list, it's selected
  if (GetNumItems = 1) then
  begin
    m_iSelected := 0;
    m_iFocused := 0;
    m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, False, Self);
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTComboBox.RemoveItem(index: LongWord);
var
  pItem: PDXUTComboBoxItem;
begin
  pItem := m_Items[index];
  Dispose(pItem);
  // m_Items.Remove(index);
  Move(m_Items[index+1], m_Items[index], (Length(m_Items)-Integer(index)-1)*SizeOf(PDXUTComboBoxItem));
  SetLength(m_Items, Length(m_Items)-1);

  m_ScrollBar.SetTrackRange(0, Length(m_Items));
  if (m_iSelected >= Length(m_Items)) then m_iSelected := Length(m_Items) - 1;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTComboBox.RemoveAllItems;
var
  i: Integer;
  pItem: PDXUTComboBoxItem;
begin
  for i:= 0 to Length(m_Items) - 1 do
  begin
    pItem := PDXUTComboBoxItem(m_Items[i]);
    Dispose(pItem);
  end;

  m_Items:= nil; // RemoveAll;
  m_ScrollBar.SetTrackRange(0, 1);
  m_iSelected := -1;
  m_iFocused := -1;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.ContainsItem(const strText: PWideChar; iStart: LongWord = 0): Boolean;
begin
  Result:= (-1 <> FindItem(strText));
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.FindItem(const strText: PWideChar; iStart: LongWord = 0): Integer;
var
  i: Integer;
begin
  Result:= -1;
  if (strText = nil) then Exit;

  for i:= iStart to Length(m_Items) - 1 do
  begin
    if (lstrcmpW(m_Items[i].strText, strText) = 0) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.GetSelectedData: Pointer;
begin
  if (m_iSelected < 0) then Result:= nil
  else Result:= m_Items[m_iSelected].pData;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.GetSelectedItem: PDXUTComboBoxItem;
begin
  if (m_iSelected < 0) then Result:= nil
  else Result:= m_Items[m_iSelected];
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.GetItemData(const strText: PWideChar): Pointer;
var
  index: Integer;
  pItem: PDXUTComboBoxItem;
begin
  Result:= nil;
  index := FindItem(strText);
  if (index = -1) then Exit;

  pItem := m_Items[index];
  if (pItem = nil) then
  begin
    DXTRACE_ERR('GetItemData', E_FAIL);
    Exit;
  end;

  Result:= pItem.pData;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.GetItemData(nIndex: Integer): Pointer;
begin
  Result:= nil;
  if (nIndex < 0) or (nIndex >= Length(m_Items)) then Exit;

  Result:= m_Items[nIndex].pData;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.SetSelectedByIndex(index: LongWord): HRESULT;
begin
  if (index >= GetNumItems) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  m_iSelected := index;
  m_iFocused := index;
  m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, False, Self);

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
function CDXUTComboBox.SetSelectedByText(const strText: PWideChar): HRESULT;
var
  index: Integer;
begin
  if (strText = nil) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  index := FindItem( strText);
  if (index = -1) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  m_iSelected := index;
  m_iFocused := index;
  m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, False, Self);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTComboBox.SetSelectedByData(pData: Pointer): HRESULT;
var
  i: Integer;
begin
  for i:= 0 to Length(m_Items) - 1 do
  begin
    if (m_Items[i].pData = pData) then
    begin
      m_iSelected := i;
      m_iFocused := i;
      m_pDialog.SendEvent(EVENT_COMBOBOX_SELECTION_CHANGED, False, Self);
      Result:= S_OK;
      Exit;
    end;
  end;

  Result:= E_FAIL;
end;


function CDXUTComboBox.CanHaveFocus: Boolean;
begin
  Result:= m_bVisible and m_bEnabled;
end;


function CDXUTComboBox.GetItem(index: LongWord): PDXUTComboBoxItem;
begin
  Result:= m_Items[index];
end;

function CDXUTComboBox.GetNumItems: LongWord;
begin
  Result:= Length(m_Items);
end;


function CDXUTComboBox.OnInit: HRESULT;
begin
  Result:= m_pDialog.InitControl(m_ScrollBar); 
end;

procedure CDXUTComboBox.SetDropHeight(nHeight: LongWord);
begin
  m_nDropHeight := nHeight;
  UpdateRects;
end;

procedure CDXUTComboBox.SetScrollBarWidth(nWidth: Integer);
begin
  m_nSBWidth := nWidth;
  UpdateRects;
end;


{ CDXUTSlider }

//--------------------------------------------------------------------------------------
constructor CDXUTSlider.Create(pDialog: CDXUTDialog);
begin
  inherited;
  m_Type := DXUT_CONTROL_SLIDER;
  m_pDialog := pDialog;

  m_nMin := 0;
  m_nMax := 100;
  m_nValue := 50;

  m_bPressed := False;
end;


//--------------------------------------------------------------------------------------
function CDXUTSlider.ContainsPoint(pt: TPoint): LongBool;
begin
  Result:= PtInRect(m_rcBoundingBox, pt) or
           PtInRect(m_rcButton, pt);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTSlider.UpdateRects;
begin
  inherited;

  m_rcButton := m_rcBoundingBox;
  m_rcButton.right := m_rcButton.left + RectHeight(m_rcButton);
  OffsetRect(m_rcButton, -RectWidth(m_rcButton) div 2, 0);

  if (m_nMax - m_nMin) <> 0 then
  begin
    m_nButtonX := Trunc(((m_nValue - m_nMin) * RectWidth(m_rcBoundingBox) / (m_nMax - m_nMin)));
    OffsetRect(m_rcButton, m_nButtonX, 0);
  end;
end;


function CDXUTSlider.ValueFromPos(x: Integer): Integer;
var
  fValuePerPixel: Single;
begin
  fValuePerPixel := (m_nMax - m_nMin) / RectWidth(m_rcBoundingBox);
  Result:= Trunc((0.5 + m_nMin + fValuePerPixel * (x - m_rcBoundingBox.left)));
end;


//--------------------------------------------------------------------------------------
function CDXUTSlider.HandleKeyboard(uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): Boolean;
begin
  Result:= False;
  if not m_bEnabled or not m_bVisible then Exit;

  case uMsg of
    WM_KEYDOWN:
    begin
      Result:= True;
      case wParam of
        VK_HOME:          SetValueInternal(m_nMin, True);
        VK_END:           SetValueInternal(m_nMax, True);
        VK_LEFT, VK_DOWN: SetValueInternal(m_nValue - 1, True);
        VK_RIGHT, VK_UP:  SetValueInternal(m_nValue + 1, True);
        VK_NEXT:          SetValueInternal(m_nValue - IfThen(10 > (m_nMax - m_nMin) div 10, 10, (m_nMax - m_nMin) div 10), True);
        VK_PRIOR:         SetValueInternal(m_nValue + IfThen(10 > (m_nMax - m_nMin) div 10, 10, (m_nMax - m_nMin) div 10), True);
       else
        Result:= False;
      end;
      Exit;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTSlider.HandleMouse(uMsg: LongWord; pt: TPoint;
  wParam: WPARAM; lParam: LPARAM): Boolean;
var
  nScrollAmount: Integer;
begin
  if not m_bEnabled or not m_bVisible then
  begin
    Result:= False;
    Exit;
  end;

  Result:= True;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      if PtInRect(m_rcButton, pt) then
      begin
        // Pressed while inside the control
        m_bPressed := True;
        SetCapture(DXUTGetHWND);

        m_nDragX := pt.x;
        //m_nDragY = pt.y;
        m_nDragOffset := m_nButtonX - m_nDragX;

        //m_nDragValue = m_nValue;

        if not m_bHasFocus then m_pDialog.RequestFocus(Self);
        Exit;
      end;

      if PtInRect(m_rcBoundingBox, pt) then
      begin
        m_nDragX := pt.x;
        m_nDragOffset := 0;
        m_bPressed := True;

        if not m_bHasFocus then m_pDialog.RequestFocus(Self);

        if not m_bHasFocus then m_pDialog.RequestFocus(Self);

        if (pt.x > m_nButtonX + m_x) then
        begin
          SetValueInternal(m_nValue + 1, True);
          Exit;
        end;

        if (pt.x < m_nButtonX + m_x) then
        begin
          SetValueInternal(m_nValue - 1, True);
          Exit;
        end;
      end;
    end;

    WM_LBUTTONUP:
    begin
      if m_bPressed then
      begin
        m_bPressed := False;
        ReleaseCapture;
        m_pDialog.SendEvent(EVENT_SLIDER_VALUE_CHANGED, True, Self);
        Exit;
      end;
    end;

    WM_MOUSEMOVE:
    begin
      if m_bPressed then
      begin
        SetValueInternal(ValueFromPos(m_x + pt.x + m_nDragOffset), True);
        Exit;
      end;
    end;

    WM_MOUSEWHEEL:
    begin
      nScrollAmount := Integer(ShortInt(HIWORD(wParam))) div WHEEL_DELTA;
      SetValueInternal(m_nValue - nScrollAmount, True);
      Exit;
    end;
  end;

  Result:= False;
end;


procedure CDXUTSlider.GetRange(out nMin, nMax: Integer);
begin
  nMin := m_nMin;
  nMax := m_nMax;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTSlider.SetRange(nMin, nMax: Integer);
begin
  m_nMin := nMin;
  m_nMax := nMax;
  SetValueInternal(m_nValue, False);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTSlider.SetValueInternal(nValue: Integer; bFromInput: Boolean);
begin
  // Clamp to range
  nValue := Max(m_nMin, nValue);
  nValue := Min(m_nMax, nValue);

  if (nValue = m_nValue) then Exit;

  m_nValue := nValue;
  UpdateRects;

  m_pDialog.SendEvent(EVENT_SLIDER_VALUE_CHANGED, bFromInput, Self);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTSlider.Render(pd3dDevice: IDirect3DDevice9;
  fElapsedTime: Single);
var
//  nOffsetX, nOffsetY: Integer;
  iState: TDXUTControlState;
  fBlendRate: Single;
  pElement: CDXUTElement;
begin
  // nOffsetX := 0; // - never used
  // nOffsetY := 0; // - never used

  iState := DXUT_STATE_NORMAL;

  if not m_bVisible then iState := DXUT_STATE_HIDDEN
  else if not m_bEnabled then iState := DXUT_STATE_DISABLED
  else if m_bPressed then
  begin
    iState := DXUT_STATE_PRESSED;
    // nOffsetX := 1; // - never used
    //nOffsetY := 2; // - never used
  end else if m_bMouseOver then
  begin
    iState := DXUT_STATE_MOUSEOVER;

    // nOffsetX := -1; // - never used
    // nOffsetY := -2; // - never used
  end else if m_bHasFocus then
  begin
    iState := DXUT_STATE_FOCUS;
  end; 

  fBlendRate := IfThen(iState = DXUT_STATE_PRESSED, 0.0, 0.8);

  pElement := m_Elements[0];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcBoundingBox);

  //TODO: remove magic numbers
  pElement := m_Elements[1];

  // Blend current color
  pElement.TextureColor.Blend(iState, fElapsedTime, fBlendRate);
  m_pDialog.DrawSprite(pElement, m_rcButton);
end;


function CDXUTSlider.CanHaveFocus: Boolean;
begin
  Result:= True;
end;



procedure CDXUTSlider.SetValue(nValue: Integer);
begin
  SetValueInternal(nValue, False); 
end;


(*// Static member initialization
HINSTANCE CDXUTEditBox::CUniBuffer::s_hDll = NULL;
HRESULT (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptApplyDigitSubstitution)( const SCRIPT_DIGITSUBSTITUTE*, SCRIPT_CONTROL*, SCRIPT_STATE* )
    = Dummy_ScriptApplyDigitSubstitution;
HRESULT (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptStringAnalyse)( HDC, const void *, int, int, int, DWORD, int, SCRIPT_CONTROL*, SCRIPT_STATE*,
                                                    const int*, SCRIPT_TABDEF*, const BYTE*, SCRIPT_STRING_ANALYSIS* )
    = Dummy_ScriptStringAnalyse;
HRESULT (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptStringCPtoX)( SCRIPT_STRING_ANALYSIS, int, BOOL, int* )
    = Dummy_ScriptStringCPtoX;
HRESULT (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptStringXtoCP)( SCRIPT_STRING_ANALYSIS, int, int*, int* )
    = Dummy_ScriptStringXtoCP;
HRESULT (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptStringFree)( SCRIPT_STRING_ANALYSIS* )
    = Dummy_ScriptStringFree;
const SCRIPT_LOGATTR* (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptString_pLogAttr)( SCRIPT_STRING_ANALYSIS )
    = Dummy_ScriptString_pLogAttr;
const int* (WINAPI *CDXUTEditBox::CUniBuffer::_ScriptString_pcOutChars)( SCRIPT_STRING_ANALYSIS )
    = Dummy_ScriptString_pcOutChars;
bool CDXUTEditBox::s_bHideCaret;   // If true, we don't render the caret. *)
var
  s_bHideCaret: {static} Boolean; // If true, we don't render the caret.


{ CUniBuffer }

type
  TUSP_ScriptApplyDigitSubstitution = function (
    const psds: PScriptDigitSubstitute;   // In   Digit substitution settings
    psc: PScriptControl;                  // Out  Script control structure
    pss: PScriptState                     // Out  Script state structure
    ): HRESULT; stdcall;

  TUSP_ScriptStringAnalyse = function (
    hdc: HDC;                  //In  Device context (required)
    const pString: Pointer;    //In  String in 8 or 16 bit characters
    cString: Integer;          //In  Length in characters (Must be at least 1)
    cGlyphs: Integer;          //In  Required glyph buffer size (default cString*1.5 + 16)
    iCharset: Integer;         //In  Charset if an ANSI string, -1 for a Unicode string
    dwFlags: DWORD;            //In  Analysis required
    iReqWidth: Integer;        //In  Required width for fit and/or clip
    psControl: PScriptControl; //In  Analysis control (optional)
    psState: PScriptState;     //In  Analysis initial state (optional)
    const piDx: PInteger;      //In  Requested logical dx array
    pTabdef: PScriptTabDef;    //In  Tab positions (optional)
    const pbInClass: PByte;    //In  Legacy GetCharacterPlacement character classifications (deprecated)

    pssa:  PScriptStringAnalysis //Out Analysis of string
    ): HRESULT; stdcall;

  TUSP_ScriptStringCPtoX = function (
    ssa: TScriptStringAnalysis;        //In  String analysis
    icp: Integer;                      //In  Caret character position
    fTrailing: BOOL;                   //In  Which edge of icp
    out pX: Integer                    //Out Corresponding x offset
    ): HRESULT; stdcall;

  TUSP_ScriptStringXtoCP = function (
    ssa: TScriptStringAnalysis;        // In
    iX: Integer;                       // In
    piCh: PInteger;                    // Out
    piTrailing: PInteger               // Out
    ): HRESULT; stdcall;

  TUSP_ScriptStringFree = function (
    pssa: PScriptStringAnalysis  //InOut Address of pointer to analysis
    ): HRESULT; stdcall;

  TUSP_ScriptString_pLogAttr = function (
    ssa: TScriptStringAnalysis
    ): {const} PScriptLogAttr; stdcall;

  TUSP_ScriptString_pcOutChars = function (
    ssa: TScriptStringAnalysis
    ): {const} PInteger; stdcall; 


// Empty implementation of the Uniscribe API
function Dummy_ScriptApplyDigitSubstitution(
    const psds: PScriptDigitSubstitute;   // In   Digit substitution settings
    psc: PScriptControl;                  // Out  Script control structure
    pss: PScriptState                     // Out  Script state structure
    ): HRESULT; stdcall;
begin Result:= E_NOTIMPL; end;

function Dummy_ScriptStringAnalyse(
    hdc: HDC;                  //In  Device context (required)
    const pString: Pointer;    //In  String in 8 or 16 bit characters
    cString: Integer;          //In  Length in characters (Must be at least 1)
    cGlyphs: Integer;          //In  Required glyph buffer size (default cString*1.5 + 16)
    iCharset: Integer;         //In  Charset if an ANSI string, -1 for a Unicode string
    dwFlags: DWORD;            //In  Analysis required
    iReqWidth: Integer;        //In  Required width for fit and/or clip
    psControl: PScriptControl; //In  Analysis control (optional)
    psState: PScriptState;     //In  Analysis initial state (optional)
    const piDx: PInteger;      //In  Requested logical dx array
    pTabdef: PScriptTabDef;    //In  Tab positions (optional)
    const pbInClass: PByte;    //In  Legacy GetCharacterPlacement character classifications (deprecated)

    pssa:  PScriptStringAnalysis //Out Analysis of string
    ): HRESULT; stdcall;
begin Result:= E_NOTIMPL; end;

function Dummy_ScriptStringCPtoX(
    ssa: TScriptStringAnalysis;        //In  String analysis
    icp: Integer;                      //In  Caret character position
    fTrailing: BOOL;                   //In  Which edge of icp
    out pX: Integer                    //Out Corresponding x offset
    ): HRESULT; stdcall;
begin Result:= E_NOTIMPL; end;

function Dummy_ScriptStringXtoCP(
    ssa: TScriptStringAnalysis;        // In
    iX: Integer;                       // In
    piCh: PInteger;                    // Out
    piTrailing: PInteger               // Out
    ): HRESULT; stdcall;
begin Result:= E_NOTIMPL; end;

function Dummy_ScriptStringFree(
    pssa: PScriptStringAnalysis  //InOut Address of pointer to analysis
    ): HRESULT; stdcall; 
begin Result:= E_NOTIMPL; end;

function Dummy_ScriptString_pLogAttr(
    ssa: TScriptStringAnalysis
    ): {const} PScriptLogAttr; stdcall;
begin Result:= nil; end;

function Dummy_ScriptString_pcOutChars(
    ssa: TScriptStringAnalysis
    ): {const} PInteger; stdcall;
begin Result:= nil; end;

var
  // Function pointers
  _ScriptApplyDigitSubstitution: TUSP_ScriptApplyDigitSubstitution = Dummy_ScriptApplyDigitSubstitution;
  _ScriptStringAnalyse: TUSP_ScriptStringAnalyse = Dummy_ScriptStringAnalyse;
  _ScriptStringCPtoX: TUSP_ScriptStringCPtoX = Dummy_ScriptStringCPtoX;
  _ScriptStringXtoCP: TUSP_ScriptStringXtoCP = Dummy_ScriptStringXtoCP;
  _ScriptStringFree: TUSP_ScriptStringFree = Dummy_ScriptStringFree;
  _ScriptString_pLogAttr: TUSP_ScriptString_pLogAttr = Dummy_ScriptString_pLogAttr;
  _ScriptString_pcOutChars: TUSP_ScriptString_pcOutChars = Dummy_ScriptString_pcOutChars;

  s_hDll: THandle {HINSTANCE} = 0; // Uniscribe DLL handle

  
//--------------------------------------------------------------------------------------
constructor CUniBuffer.Create(nInitialSize: Integer);
begin
  CUniBuffer.Initialize;  // ensure static vars are properly init'ed first

  m_nBufferSize := 0;
  m_pwszBuffer := nil;
  m_bAnalyseRequired := True;
  m_Analysis := nil;
  m_pFontNode := nil;

  if (nInitialSize > 0) then SetBufferSize(nInitialSize);
end;


//--------------------------------------------------------------------------------------
destructor CUniBuffer.Destroy;
begin
  FreeMem(m_pwszBuffer);
  if (m_Analysis <> nil) then _ScriptStringFree(@m_Analysis);
  inherited;
end;

//--------------------------------------------------------------------------------------
class procedure CUniBuffer.Initialize;
var
  temp: FARPROC;
begin
  if (s_hDll <> 0) then Exit; // Only need to do once

  s_hDll := LoadLibrary(UNISCRIBE_DLLNAME);
  if (s_hDll <> 0) then
  begin
    temp:= GetProcAddress(s_hDll, 'ScriptApplyDigitSubstitution'); if (temp<>nil) then _ScriptApplyDigitSubstitution:= temp;
    temp:= GetProcAddress(s_hDll, 'ScriptStringAnalyse'); if (temp<>nil) then _ScriptStringAnalyse:= temp;
    temp:= GetProcAddress(s_hDll, 'ScriptStringCPtoX'); if (temp<>nil) then _ScriptStringCPtoX:= temp;
    temp:= GetProcAddress(s_hDll, 'ScriptStringXtoCP'); if (temp<>nil) then _ScriptStringXtoCP:= temp;
    temp:= GetProcAddress(s_hDll, 'ScriptStringFree'); if (temp<>nil) then _ScriptStringFree:= temp;
    temp:= GetProcAddress(s_hDll, 'ScriptString_pLogAttr'); if (temp<>nil) then _ScriptString_pLogAttr:= temp;
    temp:= GetProcAddress(s_hDll, 'ScriptString_pcOutChars'); if (temp<>nil) then _ScriptString_pcOutChars:= temp;
  end;
end;


//--------------------------------------------------------------------------------------
class procedure CUniBuffer.Uninitialize;
begin
  if (s_hDll <> 0) then
  begin
    _ScriptApplyDigitSubstitution := Dummy_ScriptApplyDigitSubstitution;
    _ScriptStringAnalyse := Dummy_ScriptStringAnalyse;
    _ScriptStringCPtoX := Dummy_ScriptStringCPtoX;
    _ScriptStringXtoCP := Dummy_ScriptStringXtoCP;
    _ScriptStringFree := Dummy_ScriptStringFree;
    _ScriptString_pLogAttr := Dummy_ScriptString_pLogAttr;
    _ScriptString_pcOutChars:= Dummy_ScriptString_pcOutChars;

    FreeLibrary(s_hDll);
    s_hDll := 0;
  end;
end;


//--------------------------------------------------------------------------------------
function CUniBuffer.SetBufferSize(nNewSize: Integer): Boolean;
var
  nAllocateSize: Integer;
  pTempBuffer: PWideChar;
begin
  // If the current size is already the maximum allowed,
  // we can't possibly allocate more.
  if (m_nBufferSize = DXUT_MAX_EDITBOXLENGTH) then
  begin
    Result:= False;
    Exit;
  end;

  nAllocateSize := IfThen((nNewSize = -1) or (nNewSize < m_nBufferSize * 2),
                     IfThen((m_nBufferSize <> 0), m_nBufferSize * 2, 256), nNewSize * 2);

  // Cap the buffer size at the maximum allowed.
  if (nAllocateSize > DXUT_MAX_EDITBOXLENGTH) then
    nAllocateSize := DXUT_MAX_EDITBOXLENGTH;

  try
    GetMem(pTempBuffer, SizeOf(WideChar) * nAllocateSize);
  except
    Result:= False;
    Exit;
  end;

  if (m_pwszBuffer <> nil) then
  begin
    CopyMemory(pTempBuffer, m_pwszBuffer, (lstrlenW(m_pwszBuffer) + 1) * SizeOf(WideChar));
    FreeMem(m_pwszBuffer);
  end else
    ZeroMemory(pTempBuffer, SizeOf(WideChar) * nAllocateSize);

  m_pwszBuffer := pTempBuffer;
  m_nBufferSize := nAllocateSize;
  Result:= True;
end;


//--------------------------------------------------------------------------------------
// Uniscribe -- Analyse() analyses the string in the buffer
//--------------------------------------------------------------------------------------
function CUniBuffer.Analyse: HRESULT;
var
  ScriptControl: TScriptControl; // For uniscribe
  ScriptState:   TScriptState;   // For uniscribe
begin
  if (m_Analysis <> nil) then _ScriptStringFree(@m_Analysis);

  ZeroMemory(@ScriptControl, SizeOf(ScriptControl));
  ZeroMemory(@ScriptState, SizeOf(ScriptState));
  _ScriptApplyDigitSubstitution(nil, @ScriptControl, @ScriptState);

  if (m_pFontNode = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  Result := _ScriptStringAnalyse(IfThen(Assigned(m_pFontNode.pFont), m_pFontNode.pFont.GetDC, 0),
                                 m_pwszBuffer,
                                 lstrlenW(m_pwszBuffer) + 1,  // nil is also analyzed.
                                 lstrlenW(m_pwszBuffer) * 3 div 2 + 16,
                                 -1,
                                 SSA_BREAK or SSA_GLYPHS or SSA_FALLBACK or SSA_LINK,
                                 0,
                                 @ScriptControl,
                                 @ScriptState,
                                 nil,
                                 nil,
                                 nil,
                                 @m_Analysis);
  if SUCCEEDED(Result) then m_bAnalyseRequired := False;  // Analysis is up-to-date
end;


//--------------------------------------------------------------------------------------
function CUniBuffer.GetTextSize: Integer; { return lstrlenW( m_pwszBuffer ); }
begin
  Result:= lstrlenW(m_pwszBuffer);
end;


//--------------------------------------------------------------------------------------
function CUniBuffer.GetChar(i: Integer): WideChar; // No param checking
begin
  Result:= m_pwszBuffer[i];
end;

//--------------------------------------------------------------------------------------
procedure CUniBuffer.SetChar(i: Integer; ch: WideChar);
begin
  // This version of operator[] is called only
  // if we are asking for write access, so
  // re-analysis is required.
  m_bAnalyseRequired := True;
  m_pwszBuffer[i]:= ch;
end;

//--------------------------------------------------------------------------------------
procedure CUniBuffer.Clear;
begin
  m_pwszBuffer^ := #0;
  m_bAnalyseRequired := True;
end;


//--------------------------------------------------------------------------------------
// Inserts the char at specified index.
// If nIndex == -1, insert to the end.
//--------------------------------------------------------------------------------------
function CUniBuffer.InsertChar(nIndex: Integer; wChar: WideChar): Boolean;
var
  dest, stop, src: PWideChar;
begin
  Assert(nIndex >= 0);
  Result:= False;

  if (nIndex < 0) or (nIndex > lstrlenW(m_pwszBuffer)) then Exit;  // invalid index

  // Check for maximum length allowed
  if (TextSize + 1 >= DXUT_MAX_EDITBOXLENGTH) then Exit;

  if (lstrlenW(m_pwszBuffer) + 1 >= m_nBufferSize) then
  begin
    if not SetBufferSize(-1) then Exit;  // out of memory
  end;

  Assert(m_nBufferSize >= 2);

//  MoveMemory(m_pwszBuffer + nIndex + 1, m_pwszBuffer + nIndex, SizeOf(WideChar) * (lstrlenW(m_pwszBuffer) - nIndex + 1));
  // Shift the characters after the index, start by copying the null terminator
  dest := m_pwszBuffer + lstrlenW(m_pwszBuffer)+1;
  //todo: new! replace lstrlenW
  stop := m_pwszBuffer + nIndex;
  src := dest - 1;

  while (dest > stop) do
  begin
    dest^ := src^;
    Dec(dest); Dec(src);
  end;

  // Set new character
  m_pwszBuffer[nIndex] := wChar;
  m_bAnalyseRequired := True;

  Result:= True;
end;


//--------------------------------------------------------------------------------------
// Removes the char at specified index.
// If nIndex == -1, remove the last char.
//--------------------------------------------------------------------------------------
function CUniBuffer.RemoveChar(nIndex: Integer): Boolean;
begin
  if (lstrlenW(m_pwszBuffer)=0) or (nIndex < 0) or (nIndex >= lstrlenW(m_pwszBuffer)) then
  begin
    Result:= False;  // Invalid index
    Exit;
  end;

  MoveMemory(m_pwszBuffer + nIndex, m_pwszBuffer + nIndex + 1, SizeOf(WideChar) * (lstrlenW(m_pwszBuffer) - nIndex));
  m_bAnalyseRequired := True;
  Result:= True;
end;


//--------------------------------------------------------------------------------------
// Inserts the first nCount characters of the string pStr at specified index.
// If nCount == -1, the entire string is inserted.
// If nIndex == -1, insert to the end.
//--------------------------------------------------------------------------------------
function CUniBuffer.InsertString(nIndex: Integer; const pStr: PWideChar; nCount: Integer = -1): Boolean;
begin
  Assert(nIndex >= 0);
  Result:= False;

  if (nIndex > lstrlenW(m_pwszBuffer)) then Exit; // invalid index

  if (-1 = nCount) then nCount := lstrlenW(pStr);

  // Check for maximum length allowed
  if (TextSize + nCount >= DXUT_MAX_EDITBOXLENGTH) then Exit;

  if (lstrlenW(m_pwszBuffer) + nCount >= m_nBufferSize) then 
  begin
    if not SetBufferSize(lstrlenW(m_pwszBuffer) + nCount + 1) then Exit; // out of memory
  end;

  MoveMemory(m_pwszBuffer + nIndex + nCount, m_pwszBuffer + nIndex, SizeOf(WideChar) * (lstrlenW(m_pwszBuffer) - nIndex + 1));
  CopyMemory(m_pwszBuffer + nIndex, pStr, nCount * SizeOf(WideChar));
  m_bAnalyseRequired := True;

  Result:= True;
end;


//--------------------------------------------------------------------------------------
procedure CUniBuffer.SetText(wszText: PWideChar);
var
  nRequired: Integer;
begin
  Assert(wszText <> nil);

  nRequired := lstrlenW(wszText) + 1;

  // Check for maximum length allowed
  if (nRequired >= DXUT_MAX_EDITBOXLENGTH) then
    raise EOutOfMemory.Create('CUniBuffer.SetText - max length reached'); // Result:= False;
  {begin
    Result:= False;
    Exit;
  end;}

  while (BufferSize < nRequired) do
    if not SetBufferSize(-1) then Break;
  // Check again in case out of memory occurred inside while loop.
  if (BufferSize >= nRequired) then
  begin
    StringCchCopy(m_pwszBuffer, BufferSize, wszText);
    m_bAnalyseRequired := True;
    // Result:= True;
  end else
    raise EOutOfMemory.Create('CUniBuffer.Grow'); // Result:= False;
end;


//--------------------------------------------------------------------------------------
function CUniBuffer.CPtoX(nCP: Integer; bTrail: BOOL;
  out pX: Integer): HRESULT;
begin
  // Assert(pX <> nil);
  pX := 0;  // Default

  Result := S_OK;
  if m_bAnalyseRequired then Result := Analyse;

  if SUCCEEDED(Result) then
    Result := _ScriptStringCPtoX(m_Analysis, nCP, bTrail, pX);
end;


//--------------------------------------------------------------------------------------
function CUniBuffer.XtoCP(nX: Integer; out pCP: Integer; out pnTrail: LongBool): HRESULT;
begin
  // assert( pCP && pnTrail );
  pCP := 0; pnTrail := False;  // Default

  Result := S_OK;
  if m_bAnalyseRequired then Result := Analyse;

  if SUCCEEDED(Result) then
    Result := _ScriptStringXtoCP(m_Analysis, nX, @pCP, @pnTrail);

  // If the coordinate falls outside the text region, we
  // can get character positions that don't exist.  We must
  // filter them here and convert them to those that do exist.
  if (pCP = -1) and (pnTrail = TRUE) then
  begin
    pCP := 0; pnTrail := False;
  end else
  if (pCP > lstrlenW(m_pwszBuffer)) and (pnTrail = False) then
  begin
    pCP := lstrlenW(m_pwszBuffer); pnTrail := True;
  end;
end;


type
  TScriptLogAttrArray = array[0..MaxInt div SizeOf(TScriptLogAttr)-1] of TScriptLogAttr;
  PScriptLogAttrArray = ^TScriptLogAttrArray;
  
//--------------------------------------------------------------------------------------
procedure CUniBuffer.GetPriorItemPos(nCP: Integer; out pPrior: Integer);
var
  pLogAttr: PScriptLogAttrArray;
  nInitial: Integer;
  i: Integer;
begin
  pPrior := nCP;  // Default is the char itself

  if m_bAnalyseRequired then
    if FAILED(Analyse) then Exit;

  pLogAttr := PScriptLogAttrArray(_ScriptString_pLogAttr(m_Analysis));
  if (pLogAttr = nil) then Exit;

  if (_ScriptString_pcOutChars(m_Analysis) = nil) then Exit;

  nInitial := _ScriptString_pcOutChars(m_Analysis)^;
  if (nCP - 1 < nInitial) then nInitial := nCP - 1;

  for i := nInitial downto 1 do
    if (fWordStop in pLogAttr[i]) or   // Either the fWordStop flag is set
       (fWhiteSpace in pLogAttr[i]) or  // Or the previous char is whitespace but this isn't.
       (fWhiteSpace in pLogAttr[i-1]) then
    begin
      pPrior := i;
      Exit;
    end;
  // We have reached index 0.  0 is always a break point, so simply return it.
  pPrior := 0;
end;


//--------------------------------------------------------------------------------------
procedure CUniBuffer.GetNextItemPos(nCP: Integer; out pPrior: Integer);
var
  pLogAttr: PScriptLogAttrArray;
  nInitial: Integer;
  i: Integer;
begin
  pPrior := nCP;  // Default is the char itself

  if m_bAnalyseRequired then
    if FAILED(Analyse) then Exit;

  pLogAttr := PScriptLogAttrArray(_ScriptString_pLogAttr(m_Analysis));
  if (pLogAttr = nil) then Exit;

  if (_ScriptString_pcOutChars(m_Analysis) = nil) then Exit;

  nInitial := _ScriptString_pcOutChars(m_Analysis)^;
  if (nCP + 1 < nInitial) then nInitial := nCP + 1;

  for i := nInitial to _ScriptString_pcOutChars(m_Analysis)^ - 2 do
  begin
    if (fWordStop in pLogAttr[i]) then      // Either the fWordStop flag is set
    begin
      pPrior := i;
      Exit;
    end
    else
    if (fWhiteSpace in pLogAttr[i]) and // Or this whitespace but the next char isn't.
       (fWhiteSpace in pLogAttr[i+1]) then
    begin
      pPrior := i+1;  // The next char is a word stop
      Exit;
    end;
  end;
  // We have reached the end. It's always a word stop, so simply return it.
  pPrior := _ScriptString_pcOutChars(m_Analysis)^ - 1;
end;





//--------------------------------------------------------------------------------------
// CDXUTEditBox class
//--------------------------------------------------------------------------------------

{const
  // When scrolling, EDITBOX_SCROLLEXTENT is reciprocal of the amount to scroll.
  // If EDITBOX_SCROLLEXTENT = 4, then we scroll 1/4 of the control each time.
  EDITBOX_SCROLLEXTENT = 4;}

{ CDXUTEditBox }


//--------------------------------------------------------------------------------------
constructor CDXUTEditBox.Create(pDialog: CDXUTDialog);
begin
  inherited;
  m_Buffer:= CUniBuffer.Create;

  m_Type := DXUT_CONTROL_EDITBOX;
  m_pDialog := pDialog;

  m_nBorder := 5;  // Default border width
  m_nSpacing := 4;  // Default spacing

  m_bCaretOn := True;
  m_dfBlink := GetCaretBlinkTime * 0.001;
  m_dfLastBlink := DXUTGetGlobalTimer.GetAbsoluteTime;
  s_bHideCaret := False;
  m_nFirstVisible := 0;
  m_TextColor := D3DCOLOR_ARGB(255, 16, 16, 16);
  m_SelTextColor := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_SelBkColor := D3DCOLOR_ARGB(255, 40, 50, 92);
  m_CaretColor := D3DCOLOR_ARGB(255, 0, 0, 0);
  m_nSelStart := 0;
  m_nCaret := 0;
  m_bInsertMode := True;

  m_bMouseDrag := False;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTEditBox.Destroy;
begin
  FreeAndNil(m_Buffer);
  inherited;
end;


//--------------------------------------------------------------------------------------
// PlaceCaret: Set the caret to a character position, and adjust the scrolling if
//             necessary.
//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.PlaceCaret(nCP: Integer);
var
  nX1st, nX, nX2: Integer;
  nXNewLeft: Integer;
  nCPNew1st: Integer;
  nNewTrail: LongBool;
  nXNew1st: Integer;
begin
  Assert((nCP >= 0) and (nCP <= m_Buffer.TextSize));
  m_nCaret := nCP;

  // Obtain the X offset of the character.
  m_Buffer.CPtoX(m_nFirstVisible, False, nX1st);  // 1st visible char
  m_Buffer.CPtoX(nCP, False, nX);  // LEAD
  // If nCP is the NULL terminator, get the leading edge instead of trailing.
  if (nCP = m_Buffer.TextSize) then nX2 := nX
  else m_Buffer.CPtoX(nCP, True, nX2);  // TRAIL

  // If the left edge of the char is smaller than the left edge of the 1st visible char,
  // we need to scroll left until this char is visible.
  if (nX < nX1st) then
  begin
    // Simply make the first visible character the char at the new caret position.
    m_nFirstVisible := nCP;
  end else
  // If the right of the character is bigger than the offset of the control's
  // right edge, we need to scroll right to this character.
  if (nX2 > nX1st + RectWidth(m_rcText)) then
  begin
    // Compute the X of the new left-most pixel
    nXNewLeft := nX2 - RectWidth(m_rcText);

    // Compute the char position of this character
    m_Buffer.XtoCP(nXNewLeft, nCPNew1st, nNewTrail);

    // If this coordinate is not on a character border,
    // start from the next character so that the caret
    // position does not fall outside the text rectangle.
    m_Buffer.CPtoX(nCPNew1st, False, nXNew1st);
    if (nXNew1st < nXNewLeft) then Inc(nCPNew1st);

    m_nFirstVisible := nCPNew1st;
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.ClearText;
begin
  m_Buffer.Clear;
  m_nFirstVisible := 0;
  PlaceCaret(0);
  m_nSelStart := 0;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.SetText(wszText: PWideChar; bSelected: Boolean);
begin
  Assert(wszText <> nil);

  m_Buffer.SetText(wszText);
  m_nFirstVisible := 0;
  // Move the caret to the end of the text
  PlaceCaret(m_Buffer.TextSize);
  m_nSelStart := IfThen(bSelected, 0, m_nCaret);
end;


//--------------------------------------------------------------------------------------
function CDXUTEditBox.GetTextCopy(strDest: PWideChar; bufferCount: LongWord): HRESULT;
begin
  Assert(Assigned(strDest));
  StringCchCopy(strDest, bufferCount, m_Buffer.Buffer);
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.DeleteSelectionText;
var
  nFirst, nLast: Integer;
  i: Integer;
begin
  nFirst := Min(m_nCaret, m_nSelStart);
  nLast := Max(m_nCaret, m_nSelStart);
  // Update caret and selection
  PlaceCaret(nFirst);
  m_nSelStart := m_nCaret;
  // Remove the characters
  for i := nFirst to nLast - 1 do m_Buffer.RemoveChar(nFirst);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.UpdateRects;
begin
  inherited;

  // Update the text rectangle
  m_rcText := m_rcBoundingBox;
  // First inflate by m_nBorder to compute render rects
  InflateRect(m_rcText, -m_nBorder, -m_nBorder);

  // Update the render rectangles
  m_rcRender[0] := m_rcText;
  SetRect(m_rcRender[1], m_rcBoundingBox.left, m_rcBoundingBox.top, m_rcText.left, m_rcText.top);
  SetRect(m_rcRender[2], m_rcText.left, m_rcBoundingBox.top, m_rcText.right, m_rcText.top);
  SetRect(m_rcRender[3], m_rcText.right, m_rcBoundingBox.top, m_rcBoundingBox.right, m_rcText.top);
  SetRect(m_rcRender[4], m_rcBoundingBox.left, m_rcText.top, m_rcText.left, m_rcText.bottom);
  SetRect(m_rcRender[5], m_rcText.right, m_rcText.top, m_rcBoundingBox.right, m_rcText.bottom);
  SetRect(m_rcRender[6], m_rcBoundingBox.left, m_rcText.bottom, m_rcText.left, m_rcBoundingBox.bottom);
  SetRect(m_rcRender[7], m_rcText.left, m_rcText.bottom, m_rcText.right, m_rcBoundingBox.bottom);
  SetRect(m_rcRender[8], m_rcText.right, m_rcText.bottom, m_rcBoundingBox.right, m_rcBoundingBox.bottom);

  // Inflate further by m_nSpacing
  InflateRect(m_rcText, -m_nSpacing, -m_nSpacing);
end;


procedure CDXUTEditBox.CopyToClipboard;
var
  hBlock: HGLOBAL;
  pwszText: PWideChar;
  nFirst, nLast: Integer;
begin
  // Copy the selection text to the clipboard
  if (m_nCaret <> m_nSelStart) and OpenClipboard(0) then
  begin
    EmptyClipboard;

    hBlock := GlobalAlloc(GMEM_MOVEABLE, SizeOf(WideChar) * (m_Buffer.TextSize + 1));
    if (hBlock <> 0) then
    begin
      pwszText := GlobalLock(hBlock);
      if (pwszText <> nil) then
      begin
        nFirst := Min(m_nCaret, m_nSelStart);
        nLast := Max(m_nCaret, m_nSelStart);
        if (nLast - nFirst > 0) then
          CopyMemory(pwszText, m_Buffer.Buffer + nFirst, (nLast - nFirst) * SizeOf(WideChar));
        pwszText[nLast - nFirst] := #0;  // Terminate it
        GlobalUnlock(hBlock);
      end;
      SetClipboardData(CF_UNICODETEXT, hBlock);
    end;
    CloseClipboard;
    // We must not free the object until CloseClipboard is called.
    if (hBlock <> 0) then GlobalFree(hBlock);
  end;
end;


procedure CDXUTEditBox.PasteFromClipboard;
var
  handle: THandle;
  pwszText: PWideChar;
begin
  DeleteSelectionText;

  if OpenClipboard(0) then
  begin
    handle := GetClipboardData( CF_UNICODETEXT);
    if (handle <> 0) then
    begin
      // Convert the ANSI string to Unicode, then
      // insert to our buffer.
      pwszText := GlobalLock(handle);
      if (pwszText <> nil) then
      begin
        // Copy all characters up to null.
        if m_Buffer.InsertString(m_nCaret, pwszText) then
          PlaceCaret(m_nCaret + lstrlenW(pwszText));
        m_nSelStart := m_nCaret;
        GlobalUnlock(handle);
      end;
    end;
    CloseClipboard;
  end;
end;


//--------------------------------------------------------------------------------------
function CDXUTEditBox.HandleKeyboard(uMsg: LongWord; wParam: WPARAM;
  lParam: LPARAM): Boolean;
var
  bHandled: Boolean;
begin
  Result:= False;
  if (not m_bEnabled or not m_bVisible) then Exit;

  bHandled := False;

  case uMsg of
    WM_KEYDOWN:
    begin
      case wParam of
        VK_TAB: ;
          // We don't process Tab in case keyboard input is enabled and the user
          // wishes to Tab to other controls.
        //todo: is it as designed?

        VK_HOME:
        begin
          PlaceCaret(0);
          if (GetKeyState(VK_SHIFT) >= 0) then
          begin
            // Shift is not down. Update selection
            // start along with the caret.
            m_nSelStart := m_nCaret;
          end;
          ResetCaretBlink;
          bHandled := True;
        end;

        VK_END:
        begin
          PlaceCaret(m_Buffer.TextSize);
          if (GetKeyState(VK_SHIFT) >= 0) then
              // Shift is not down. Update selection
              // start along with the caret.
              m_nSelStart := m_nCaret;
          ResetCaretBlink;
          bHandled := True;
        end;

        VK_INSERT:
        begin
          if (GetKeyState(VK_CONTROL) < 0) then
          begin
            // Control Insert. Copy to clipboard
            CopyToClipboard;
          end else
          if (GetKeyState(VK_SHIFT) < 0) then 
          begin
            // Shift Insert. Paste from clipboard
            PasteFromClipboard();
          end else
          begin
            // Toggle caret insert mode
            m_bInsertMode := not m_bInsertMode;
          end;
        end;

        VK_DELETE:
        begin
          // Check if there is a text selection.
          if (m_nCaret <> m_nSelStart) then
          begin
            DeleteSelectionText;
            m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
          end else
          begin
            // Deleting one character
            if (m_Buffer.RemoveChar(m_nCaret)) then
              m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
          end;
          ResetCaretBlink;
          bHandled := True;
        end;

        VK_LEFT:
        begin
          if (GetKeyState(VK_CONTROL) < 0) then
          begin
            // Control is down. Move the caret to a new item
            // instead of a character.
            m_Buffer.GetPriorItemPos(m_nCaret, m_nCaret);
            PlaceCaret(m_nCaret);
          end else
          if (m_nCaret > 0) then PlaceCaret( m_nCaret - 1);
          if (GetKeyState(VK_SHIFT) >= 0) then
            // Shift is not down. Update selection
            // start along with the caret.
            m_nSelStart := m_nCaret;
          ResetCaretBlink;
          bHandled := True;
        end;

        VK_RIGHT:
        begin
          if (GetKeyState(VK_CONTROL) < 0) then
          begin
            // Control is down. Move the caret to a new item
            // instead of a character.
            m_Buffer.GetNextItemPos(m_nCaret, m_nCaret);
            PlaceCaret(m_nCaret);
          end else
          if (m_nCaret < m_Buffer.TextSize) then PlaceCaret(m_nCaret + 1);
          if (GetKeyState( VK_SHIFT ) >= 0) then
            // Shift is not down. Update selection
            // start along with the caret.
            m_nSelStart := m_nCaret;
          ResetCaretBlink;
          bHandled := True;
        end;

      VK_UP, VK_DOWN:
        // Trap up and down arrows so that the dialog
        // does not switch focus to another control.
        bHandled := true;

      else
        bHandled := wParam <> VK_ESCAPE;  // Let the application handle Esc.
      end;
    end;
  end;
  Result:= bHandled;
end;


//--------------------------------------------------------------------------------------
function CDXUTEditBox.HandleMouse(uMsg: LongWord; pt: TPoint;
  wParam: WPARAM; lParam: LPARAM): Boolean;
var
  nCP, nX1st: Integer;
  nTrail: LongBool;
begin
  Result:= True;
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      if (not m_bHasFocus) then m_pDialog.RequestFocus(Self);

      if not ContainsPoint(pt) then
      begin
        Result:= False;
        Exit;
      end;

      m_bMouseDrag := True;
      SetCapture(DXUTGetHWND);
      // Determine the character corresponding to the coordinates.
      m_Buffer.CPtoX(m_nFirstVisible, False, nX1st);  // X offset of the 1st visible char
      if SUCCEEDED(m_Buffer.XtoCP(pt.x - m_rcText.left + nX1st, nCP, nTrail)) then
      begin
        // Cap at the NULL character.
        if nTrail and (nCP < m_Buffer.TextSize)
          then PlaceCaret(nCP + 1)
          else PlaceCaret(nCP);
        m_nSelStart := m_nCaret;
        ResetCaretBlink;
      end;
      // Result:= True;
      Exit;
    end;

    WM_LBUTTONUP:
    begin
      ReleaseCapture;
      m_bMouseDrag := False;
    end;

    WM_MOUSEMOVE:
      if (m_bMouseDrag) then
      begin
        // Determine the character corresponding to the coordinates.
        m_Buffer.CPtoX(m_nFirstVisible, False, nX1st);  // X offset of the 1st visible char
        if SUCCEEDED(m_Buffer.XtoCP(pt.x - m_rcText.left + nX1st, nCP, nTrail)) then
        begin
          // Cap at the NULL character.
          if nTrail and (nCP < m_Buffer.TextSize)
          then PlaceCaret(nCP + 1)
          else PlaceCaret(nCP);
        end;
      end;
  end;

  Result:= false;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.OnFocusIn;
begin
  inherited;
  ResetCaretBlink;
end;


//--------------------------------------------------------------------------------------
function CDXUTEditBox.MsgProc(uMsg: LongWord; wParam: WPARAM;
  lParam: LPARAM): Boolean;
begin
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

  case uMsg of
    // Make sure that while editing, the keyup and keydown messages associated with
    // WM_CHAR messages don't go to any non-focused controls or cameras
    WM_KEYUP,
    WM_KEYDOWN:
    begin
      Result:= True;
      Exit;
    end;

    WM_CHAR:
    begin
      case (wParam) of
        // Backspace
        VK_BACK:
        begin
          // If there's a selection, treat this
          // like a delete key.
          if (m_nCaret <> m_nSelStart) then
          begin
            DeleteSelectionText;
            m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
          end else
          if (m_nCaret > 0) then
          begin
            // Move the caret, then delete the char.
            PlaceCaret(m_nCaret - 1);
            m_nSelStart := m_nCaret;
            m_Buffer.RemoveChar(m_nCaret);
            m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
          end;
          ResetCaretBlink;
        end;

        24,        // Ctrl-X Cut
        VK_CANCEL: // Ctrl-C Copy
        begin
          CopyToClipboard;

          // If the key is Ctrl-X, delete the selection too.
          if (wParam = 24) then
          begin
            DeleteSelectionText;
            m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
          end;
        end;

        // Ctrl-V Paste
        22:
        begin
          PasteFromClipboard;
          m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
        end;

        // Ctrl-A Select All
        1:
        begin
          if (m_nSelStart = m_nCaret) then
          begin
            m_nSelStart := 0;
            PlaceCaret(m_Buffer.TextSize);
          end;
        end;

        VK_RETURN:
          // Invoke the callback when the user presses Enter.
          m_pDialog.SendEvent(EVENT_EDITBOX_STRING, True, Self);

        // Junk characters we don't want in the string
        26,  // Ctrl Z
        2,   // Ctrl B
        14,  // Ctrl N
        19,  // Ctrl S
        4,   // Ctrl D
        6,   // Ctrl F
        7,   // Ctrl G
        10,  // Ctrl J
        11,  // Ctrl K
        12,  // Ctrl L
        17,  // Ctrl Q
        23,  // Ctrl W
        5,   // Ctrl E
        18,  // Ctrl R
        20,  // Ctrl T
        25,  // Ctrl Y
        21,  // Ctrl U
        9,   // Ctrl I
        15,  // Ctrl O
        16,  // Ctrl P
        27,  // Ctrl [
        29,  // Ctrl ]
        28:  // Ctrl \
          {Do Nothing};

      else {case}
        // If there's a selection and the user
        // starts to type, the selection should
        // be deleted.
        if (m_nCaret <> m_nSelStart) then DeleteSelectionText;

        // If we are in overwrite mode and there is already
        // a char at the caret's position, simply replace it.
        // Otherwise, we insert the char as normal.
        if not m_bInsertMode and (m_nCaret < m_Buffer.TextSize) then
        begin
          m_Buffer[m_nCaret] := WideChar(wParam);
          PlaceCaret(m_nCaret + 1);
          m_nSelStart := m_nCaret;
        end else
        begin
          // Insert the char
          if m_Buffer.InsertChar(m_nCaret, WideChar(wParam)) then
          begin
            PlaceCaret(m_nCaret + 1);
            m_nSelStart := m_nCaret;
          end;
        end;
        ResetCaretBlink;
        m_pDialog.SendEvent(EVENT_EDITBOX_CHANGE, True, Self);
      end;
      Result:= True;
      Exit;
    end;
  end;
  Result:= False;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
var
  nSelStartX, nCaretX: Integer ;  // Left and right X cordinates of the selection region
  pElement: CDXUTElement;
  e: Integer;
  nXFirst: Integer;
  rcSelection: TRect;  // Make this available for rendering selected text
  nSelLeftX, nSelRightX: Integer;
  nTemp: Integer;
  nFirstToRender: Integer;
  nNumChatToRender: Integer;
  rcCaret: TRect;
  nRightEdgeX: Integer;
begin
  if not m_bVisible then Exit;

  nSelStartX := 0; nCaretX := 0;  // Left and right X cordinates of the selection region

  pElement := GetElement(0);
  if (pElement <> nil) then
  begin
    m_Buffer.FontNode := m_pDialog.GetFont(pElement.iFont);
    PlaceCaret(m_nCaret);  // Call PlaceCaret now that we have the font info (node),
                           // so that scrolling can be handled.
  end;

  // Render the control graphics
  for e := 0 to 8 do
  begin
    pElement := m_Elements[e];
    pElement.TextureColor.Blend(DXUT_STATE_NORMAL, fElapsedTime);

    m_pDialog.DrawSprite(pElement, m_rcRender[e]);
  end;

  //
  // Compute the X coordinates of the first visible character.
  //
  m_Buffer.CPtoX(m_nFirstVisible, FALSE, nXFirst );

  //
  // Compute the X coordinates of the selection rectangle
  //
  {hr := }m_Buffer.CPtoX(m_nCaret, False, nCaretX);
  if (m_nCaret <> m_nSelStart)
  then {hr := }m_Buffer.CPtoX(m_nSelStart, False, nSelStartX)
  else nSelStartX := nCaretX;

  //
  // Render the selection rectangle
  //
  if (m_nCaret <> m_nSelStart) then
  begin
    nSelLeftX := nCaretX; nSelRightX := nSelStartX;
    // Swap if left is bigger than right
    if (nSelLeftX > nSelRightX) then
    begin
      nTemp := nSelLeftX;
      nSelLeftX := nSelRightX;
      nSelRightX := nTemp;
    end;

    SetRect(rcSelection, nSelLeftX, m_rcText.top, nSelRightX, m_rcText.bottom);
    OffsetRect(rcSelection, m_rcText.left - nXFirst, 0);
    IntersectRect(rcSelection, m_rcText, rcSelection);
    m_pDialog.DrawRect(rcSelection, m_SelBkColor);
  end;

  //
  // Render the text
  //
  // Element 0 for text
  m_Elements[0].FontColor.Current := D3DXColorFromDWord(m_TextColor);
  m_pDialog.DrawText(m_Buffer.Buffer + m_nFirstVisible, m_Elements[0], m_rcText);

  // Render the selected text
  if (m_nCaret <> m_nSelStart) then
  begin
    nFirstToRender := Max(m_nFirstVisible, Min( m_nSelStart, m_nCaret));
    nNumChatToRender := Max(m_nSelStart, m_nCaret) - nFirstToRender;
    m_Elements[0].FontColor.Current := D3DXColorFromDWord(m_SelTextColor);
    m_pDialog.DrawText(m_Buffer.Buffer + nFirstToRender,
                       m_Elements[0], rcSelection, False, nNumChatToRender);
  end;

  //
  // Blink the caret
  //
  if (DXUTGetGlobalTimer.GetAbsoluteTime - m_dfLastBlink >= m_dfBlink) then
  begin
    m_bCaretOn := not m_bCaretOn;
    m_dfLastBlink := DXUTGetGlobalTimer.GetAbsoluteTime;
  end;

  //
  // Render the caret if this control has the focus
  //
  if (m_bHasFocus and m_bCaretOn and not s_bHideCaret) then
  begin
    // Start the rectangle with insert mode caret
    rcCaret := Rect(m_rcText.left - nXFirst + nCaretX - 1, m_rcText.top,
                    m_rcText.left - nXFirst + nCaretX + 1, m_rcText.bottom);

    // If we are in overwrite mode, adjust the caret rectangle
    // to fill the entire character.
    if (not m_bInsertMode) then
    begin
      // Obtain the right edge X coord of the current character
      m_Buffer.CPtoX(m_nCaret, True, nRightEdgeX);
      rcCaret.right := m_rcText.left - nXFirst + nRightEdgeX;
    end;

    m_pDialog.DrawRect(rcCaret, m_CaretColor);
  end;
end;

function IN_FLOAT_CHARSET(c: WideChar): Boolean;
begin
  Result:= (c = '-') or (c = '.') or (c >= '0') or (c <= '9');
end;

procedure CDXUTEditBox.ParseFloatArray(pNumbers: PSingle; nCount: Integer);
{$IFDEF FPC}
begin // this function is not used anyway
end;
{$ELSE}
var
  nWritten: Integer;  // Number of floats written
  {const }pToken, pEnd: PWideChar;
  wszToken: array [0..59] of WideChar;
  nTokenLen: Integer;
begin
  nWritten := 0;  // Number of floats written

  pToken := m_Buffer.Buffer;
  while (nWritten < nCount) and (pToken^ <> #0) do
  begin
    // Skip leading spaces
    while (pToken^ = ' ') do Inc(pToken);

    if (pToken^ = #0) then Break;

    // Locate the end of number
    pEnd := pToken;
    while IN_FLOAT_CHARSET(pEnd^) do Inc(pEnd);

    // Copy the token to our buffer
    nTokenLen := Min(SizeOf(wszToken) div SizeOf(wszToken[0]) - 1, Integer(pEnd - pToken));
    StringCchCopy(wszToken, nTokenLen, pToken);
    {$IFDEF COMPILER6_UP}
    pNumbers^ := StrToFloatDef(wszToken, 0);
    {$ELSE}
    try
      pNumbers^ := StrToFloat(wszToken);
    except
      pNumbers^ := 0;
    end;
    {$ENDIF}
    Inc(nWritten);
    Inc(pNumbers);
    pToken := pEnd;
  end;
end;
{$ENDIF}


procedure CDXUTEditBox.SetTextFloatArray(pNumbers: PSingle; nCount: Integer);
var
  wszBuffer: array[0..511] of WideChar{ = 0};
  wszTmp:array[0..63] of WideChar;
  i: Integer;
begin
  if (pNumbers = nil) then Exit;

  for i := 0 to nCount - 1 do
  begin
    //StringCchFormat(wszTmp, 64, '%.4f ', [pNumbers[i]]);
    StringCchFormat(wszTmp, 64, PWideChar(WideString('%.4f ')), [pNumbers^]); Inc(pNumbers);
    StringCchCat(wszBuffer, 512, wszTmp);
  end;

  // Don't want the last space
  if (nCount > 0) and (lstrlenW(wszBuffer) > 0)
  then wszBuffer[lstrlenW(wszBuffer)-1] := #0;
  
  SetText(wszBuffer);
end;


function CDXUTEditBox.CanHaveFocus: Boolean;
begin
  Result:= (m_bVisible and m_bEnabled);
end;


function CDXUTEditBox.GetText: PWideChar;
begin
  Result:= m_Buffer.Buffer;
end;


function CDXUTEditBox.GetTextLength: Integer;
begin
  Result:= m_Buffer.TextSize; // Returns text length in chars excluding nil.
end;


//--------------------------------------------------------------------------------------
procedure CDXUTEditBox.ResetCaretBlink;
begin
  m_bCaretOn := True;
  m_dfLastBlink := DXUTGetGlobalTimer.GetAbsoluteTime;
end;


// Text color
procedure CDXUTEditBox.SetTextColor(Color: TD3DColor);
begin
  m_TextColor := Color;
end;

procedure CDXUTEditBox.SetBorderWidth(nBorder: Integer);
begin
  m_nBorder := nBorder;
  UpdateRects; // Border of the window
end;


procedure CDXUTEditBox.SetSpacing(nSpacing: Integer);
begin
  m_nSpacing := nSpacing;
  UpdateRects;
end;

procedure CDXUTEditBox.SetText_p(wszText: PWideChar);
begin
  SetText(wszText, False);
end;





//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// IME-enabled EditBox control
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

var
  s_hDllImm32: THandle;  // IMM32 DLL handle
  s_hDllVer: THandle;    // Version DLL handle
  s_hImcDef: HIMC;       // Default input context

// Empty implementation of the IMM32 API
type
  HIMCC = HIMC;
  
  // tagINPUTCONTEXT - from Windows 98/Me: Windows DDK
  tagINPUTCONTEXT = record
    hWnd:   HWND;
    fOpen:   BOOL;
    ptStatusWndPos:  TPOINT;
    ptSoftKbdPos:  TPOINT;
    fdwConversion:  DWORD;
    fdwSentence:  DWORD;
    (* union {
        LOGFONTA  A;
        LOGFONTW  W;
    } lfFont; *)
    W: TLogFontW;
    cfCompForm: COMPOSITIONFORM;
    cfCandForm: array[0..3] of CANDIDATEFORM;
    hCompStr:  HIMCC;
    hCandInfo:  HIMCC;
    hGuideLine:  HIMCC;
    hPrivate:  HIMCC;
    dwNumMsgBuf: DWORD;
    hMsgBuf:  HIMCC;
    fdwInit:  DWORD;
    dwReserve: array[0..2] of DWORD;
  end;
  {$EXTERNALSYM tagINPUTCONTEXT}
  TInputContext = tagINPUTCONTEXT;
  PInputContext = ^TInputContext;

  
function Dummy_ImmLockIMC(imc: HIMC): PINPUTCONTEXT; stdcall;  begin Result:= nil; end;
function Dummy_ImmUnlockIMC(imc: HIMC): BOOL; stdcall;         begin Result:= FALSE; end;
function Dummy_ImmLockIMCC(imcc: HIMCC): Pointer; stdcall;     begin Result:= nil; end;
function Dummy_ImmUnlockIMCC(imcc: HIMCC): BOOL; stdcall;      begin Result:= FALSE; end;
function Dummy_ImmDisableTextFrameService(d: DWORD): BOOL; stdcall; begin Result:= TRUE; end;
function Dummy_ImmGetCompositionStringW(hImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall; begin Result:= IMM_ERROR_GENERAL; end;
function Dummy_ImmGetCandidateListW(hImc: HIMC; deIndex: DWORD; lpCandidateList: PCandidateList; dwBufLen: DWORD): DWORD; stdcall; begin Result:= 0; end;
function Dummy_ImmGetContext(hWnd: HWND): HIMC; stdcall; begin Result:= 0; end;
function Dummy_ImmReleaseContext(hWnd: HWND; hImc: HIMC): Boolean; stdcall; begin Result:= FALSE; end;
function Dummy_ImmAssociateContext(hWnd: HWND; hImc: HIMC): HIMC; stdcall; begin Result:= 0; end;
function Dummy_ImmGetOpenStatus(hImc: HIMC): Boolean; stdcall; begin Result:= False; end;
function Dummy_ImmSetOpenStatus(hImc: HIMC; fOpen: Boolean): Boolean; stdcall; begin Result:= False; end;
function Dummy_ImmGetConversionStatus(hImc: HIMC; var Conversion, Sentence: DWORD): Boolean; stdcall; begin Result:= False; end;
function Dummy_ImmGetDefaultIMEWnd(hWnd: HWND): HWND; stdcall; begin Result:= 0; end;
function Dummy_ImmGetIMEFileNameA(hKl: HKL; PAnsiChar: PAnsiChar; uBufLen: UINT): UINT; stdcall; begin Result:= 0; end;
function Dummy_ImmGetVirtualKey(hWnd: HWND): UINT; stdcall; begin Result:= 0; end;
function Dummy_ImmNotifyIME(hImc: HIMC; dwAction, dwIndex, dwValue: DWORD): Boolean; stdcall; begin Result:= FALSE; end;
function Dummy_ImmSetConversionStatus(hImc: HIMC; Conversion, Sentence: DWORD): Boolean; stdcall; begin Result:= FALSE; end;
function Dummy_ImmSimulateHotKey(hWnd: HWND; dWord: DWORD): Boolean; stdcall; begin Result:= FALSE; end;
function Dummy_ImmIsIME(hKl: HKL): Boolean; stdcall;begin Result:= FALSE; end;

// Traditional Chinese IME
function Dummy_GetReadingString(himc: HIMC; u: UINT; w: PWideChar; i: PInteger; b: PBOOL; pu: PUINT): LongWord; begin Result:= 0; end;
function Dummy_ShowReadingWindow(imc: HIMC; b: BOOL): BOOL; begin Result:= FALSE; end;

// Verion library imports
function Dummy_VerQueryValueA(const p: Pointer; s: PAnsiChar; pp: PPointer; i: PUINT): BOOL; stdcall; begin Result:= False; end;
function Dummy_GetFileVersionInfoA(s: PChar; d1, d2: DWORD; p: Pointer): DWORD; stdcall; begin Result:= iFalse; end;
function Dummy_GetFileVersionInfoSizeA(s: PChar; var d: DWORD): DWORD; stdcall; begin Result:= 0; end;

var
  // Function pointers: IMM32
  _ImmLockIMC: function (imc: HIMC): PINPUTCONTEXT; stdcall = Dummy_ImmLockIMC;
  _ImmUnlockIMC: function (imc: HIMC): BOOL; stdcall = Dummy_ImmUnlockIMC;
  _ImmLockIMCC: function (imcc: HIMCC): Pointer; stdcall = Dummy_ImmLockIMCC;
  _ImmUnlockIMCC: function (imcc: HIMCC): BOOL; stdcall = Dummy_ImmUnlockIMCC;
  _ImmDisableTextFrameService: function (d: DWORD): BOOL; stdcall = Dummy_ImmDisableTextFrameService;
  _ImmGetCompositionStringW: function (hImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall = Dummy_ImmGetCompositionStringW;
  _ImmGetCandidateListW: function (hImc: HIMC; deIndex: DWORD; lpCandidateList: PCandidateList; dwBufLen: DWORD): DWORD; stdcall = Dummy_ImmGetCandidateListW;
  _ImmGetContext: function (hWnd: HWND): HIMC; stdcall = Dummy_ImmGetContext;
  _ImmReleaseContext: function (hWnd: HWND; hImc: HIMC): Boolean; stdcall = Dummy_ImmReleaseContext;
  _ImmAssociateContext: function (hWnd: HWND; hImc: HIMC): HIMC; stdcall = Dummy_ImmAssociateContext;
  _ImmGetOpenStatus: function (hImc: HIMC): Boolean; stdcall = Dummy_ImmGetOpenStatus;
  _ImmSetOpenStatus: function (hImc: HIMC; fOpen: Boolean): Boolean; stdcall = Dummy_ImmSetOpenStatus;
  _ImmGetConversionStatus: function (hImc: HIMC; var Conversion, Sentence: DWORD): Boolean; stdcall = Dummy_ImmGetConversionStatus;
  _ImmGetDefaultIMEWnd: function (hWnd: HWND): HWND; stdcall = Dummy_ImmGetDefaultIMEWnd;
  _ImmGetIMEFileNameA: function (hKl: HKL; PAnsiChar: PAnsiChar; uBufLen: UINT): UINT; stdcall = Dummy_ImmGetIMEFileNameA;
  _ImmGetVirtualKey: function (hWnd: HWND): UINT; stdcall = Dummy_ImmGetVirtualKey;
  _ImmNotifyIME: function (hImc: HIMC; dwAction, dwIndex, dwValue: DWORD): Boolean; stdcall = Dummy_ImmNotifyIME;
  _ImmSetConversionStatus: function (hImc: HIMC; Conversion, Sentence: DWORD): Boolean; stdcall = Dummy_ImmSetConversionStatus;
  _ImmSimulateHotKey: function (hWnd: HWND; dWord: DWORD): Boolean; stdcall = Dummy_ImmSimulateHotKey;
  _ImmIsIME: function (hKl: HKL): Boolean; stdcall = Dummy_ImmIsIME;

  // Function pointers: Traditional Chinese IME
  _GetReadingString: function (himc: HIMC; u: UINT; w: PWideChar; i: PInteger; b: PBOOL; pu: PUINT): LongWord = Dummy_GetReadingString;
  _ShowReadingWindow: function (imc: HIMC; b: BOOL): BOOL = Dummy_ShowReadingWindow;

  // Function pointers: Verion library imports
  _VerQueryValueA: function (const p: Pointer; s: PAnsiChar; pp: PPointer; i: PUINT): BOOL; stdcall = Dummy_VerQueryValueA;
  _GetFileVersionInfoA: function (s: PChar; d1, d2: DWORD; p: Pointer): DWORD; stdcall = Dummy_GetFileVersionInfoA;
  _GetFileVersionInfoSizeA: function (s: PChar; var d: DWORD): DWORD; stdcall = Dummy_GetFileVersionInfoSizeA;

var
  // Application-wide data
  s_hklCurrent: HKL;             // Current keyboard layout of the process
  s_bVerticalCand: Boolean;      // Indicates that the candidates are listed vertically
  s_aszIndicator: array[Low(TIndicatorEnum)..High(TIndicatorEnum), 0..2] of WideChar = (
    ('E','n', #0),
    (#$7B80, #0, #0),
    (#$7E41, #0, #0),
    (#$AC00, #0, #0),
    (#$3042, #0, #0)); // String to draw to indicate current input locale
  {$IFDEF FPC}
  s_wszCurrIndicator: PWideChar;
  {$ELSE}
  s_wszCurrIndicator: PWideChar = @s_aszIndicator[Low(TIndicatorEnum)]; // Points to an indicator string that corresponds to current input locale
  {$ENDIF}
  s_bInsertOnType: Boolean;      // Insert the character as soon as a key is pressed (Korean behavior)
  s_hDllIme: THandle{HINSTANCE}; // Instance handle of the current IME module
  s_ImeState: TImeState;         // IME global state
  s_bEnableImeSystem: Boolean;   // Whether the IME system is active
  s_ptCompString: TPoint;        // Composition string position. Updated every frame.
  s_nCompCaret: Integer;         // Caret position of the composition string
  s_nFirstTargetConv: Integer;   // Index of the first target converted char in comp string.  If none, -1.
  s_CompString: CUniBuffer;      // Buffer to hold the composition string (we fix its length)
  s_abCompStringAttr: array[0..MAX_COMPSTRING_SIZE-1] of Byte;
  s_adwCompStringClause: array[0..MAX_COMPSTRING_SIZE-1] of DWORD;
  s_wszReadingString: array[0..31] of WideChar; // Used only with horizontal reading window (why?)
  s_CandList: CCandList;  // Data relevant to the candidate list
  s_bShowReadingWindow: Boolean; // Indicates whether reading window is visible
  s_bHorizontalReading: Boolean; // Indicates whether the reading window is vertical or horizontal
  s_bChineseIME: BOOL;
  s_Locale: array of CInputLocale; // Array of loaded keyboard layout on system
{$IFDEF DEBUG}
  m_bIMEStaticMsgProcCalled: Boolean = False;
{$ENDIF}

//--------------------------------------------------------------------------------------
// CDXUTIMEEditBox class
//--------------------------------------------------------------------------------------
const
  // IME constants
  CHT_IMEFILENAME1    = 'TINTLGNT.IME'; // New Phonetic
  CHT_IMEFILENAME2    = 'CINTLGNT.IME'; // New Chang Jie
  CHT_IMEFILENAME3    = 'MSTCIPHA.IME'; // Phonetic 5.1
  CHS_IMEFILENAME1    = 'PINTLGNT.IME'; // MSPY1.5/2/3
  CHS_IMEFILENAME2    = 'MSSCIPYA.IME'; // MSPY3 for OfficeXP

  LANG_CHT            = (SUBLANG_CHINESE_TRADITIONAL shl 10) or LANG_CHINESE; // MAKELANGID(LANG_CHINESE, SUBLANG_CHINESE_TRADITIONAL);
  LANG_CHS            = (SUBLANG_CHINESE_SIMPLIFIED  shl 10) or LANG_CHINESE; // MAKELANGID(LANG_CHINESE, SUBLANG_CHINESE_SIMPLIFIED);
  _CHT_HKL            = HKL($E0080404); // New Phonetic
  _CHT_HKL2           = HKL($E0090404); // New Chang Jie
  _CHS_HKL            = HKL($E00E0804); // MSPY

{#define MAKEIMEVERSION( major, minor ) \
    ( (DWORD)( ( (BYTE)( major ) << 24 ) | ( (BYTE)( minor ) << 16 ) ) )}
function MAKEIMEVERSION(major, minor: Byte): DWORD;
begin
  Result:= (major shl 24) or (minor shl 16);
end;

const
  IMEID_CHT_VER42 = LANG_CHT or (4 shl 24 or 2 shl 16); // 4, 2 ) )	// New(Phonetic/ChanJie)IME98  : 4.2.x.x // Win98
  IMEID_CHT_VER43 = LANG_CHT or (4 shl 24 or 3 shl 16); // 4, 3 ) )	// New(Phonetic/ChanJie)IME98a : 4.3.x.x // Win2k
  IMEID_CHT_VER44 = LANG_CHT or (4 shl 24 or 4 shl 16); // 4, 4 ) )	// New ChanJie IME98b          : 4.4.x.x // WinXP
  IMEID_CHT_VER50 = LANG_CHT or (5 shl 24 or 0 shl 16); // 5, 0 ) )	// New(Phonetic/ChanJie)IME5.0 : 5.0.x.x // WinME
  IMEID_CHT_VER51 = LANG_CHT or (5 shl 24 or 1 shl 16); // 5, 1 ) )	// New(Phonetic/ChanJie)IME5.1 : 5.1.x.x // IME2002(w/OfficeXP)
  IMEID_CHT_VER52 = LANG_CHT or (5 shl 24 or 2 shl 16); // 5, 2 ) )	// New(Phonetic/ChanJie)IME5.2 : 5.2.x.x // IME2002a(w/Whistler)
  IMEID_CHT_VER60 = LANG_CHT or (6 shl 24 or 0 shl 16); // 6, 0 ) )	// New(Phonetic/ChanJie)IME6.0 : 6.0.x.x // IME XP(w/WinXP SP1)
  IMEID_CHS_VER41	= LANG_CHS or (4 shl 24 or 1 shl 16); // 4, 1 ) )	// MSPY1.5	// SCIME97 or MSPY1.5 (w/Win98, Office97)
  IMEID_CHS_VER42	= LANG_CHS or (4 shl 24 or 2 shl 16); // 4, 2 ) )	// MSPY2	// Win2k/WinME
  IMEID_CHS_VER53	= LANG_CHS or (5 shl 24 or 3 shl 16); // 5, 3 ) )	// MSPY3	// WinXP

  // Function pointers
(* INPUTCONTEXT* (WINAPI * CDXUTIMEEditBox::_ImmLockIMC)( HIMC )
    = CDXUTIMEEditBox::Dummy_ImmLockIMC;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmUnlockIMC)( HIMC )
    = CDXUTIMEEditBox::Dummy_ImmUnlockIMC;
LPVOID (WINAPI * CDXUTIMEEditBox::_ImmLockIMCC)( HIMCC )
    = CDXUTIMEEditBox::Dummy_ImmLockIMCC;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmUnlockIMCC)( HIMCC )
    = CDXUTIMEEditBox::Dummy_ImmUnlockIMCC;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmDisableTextFrameService)( DWORD )
    = CDXUTIMEEditBox::Dummy_ImmDisableTextFrameService;
LONG (WINAPI * CDXUTIMEEditBox::_ImmGetCompositionStringW)( HIMC, DWORD, LPVOID, DWORD )
    = CDXUTIMEEditBox::Dummy_ImmGetCompositionStringW;
DWORD (WINAPI * CDXUTIMEEditBox::_ImmGetCandidateListW)( HIMC, DWORD, LPCANDIDATELIST, DWORD )
    = CDXUTIMEEditBox::Dummy_ImmGetCandidateListW;
HIMC (WINAPI * CDXUTIMEEditBox::_ImmGetContext)( HWND )
    = CDXUTIMEEditBox::Dummy_ImmGetContext;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmReleaseContext)( HWND, HIMC )
    = CDXUTIMEEditBox::Dummy_ImmReleaseContext;
HIMC (WINAPI * CDXUTIMEEditBox::_ImmAssociateContext)( HWND, HIMC )
    = CDXUTIMEEditBox::Dummy_ImmAssociateContext;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmGetOpenStatus)( HIMC )
    = CDXUTIMEEditBox::Dummy_ImmGetOpenStatus;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmSetOpenStatus)( HIMC, BOOL )
    = CDXUTIMEEditBox::Dummy_ImmSetOpenStatus;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmGetConversionStatus)( HIMC, LPDWORD, LPDWORD )
    = CDXUTIMEEditBox::Dummy_ImmGetConversionStatus;
HWND (WINAPI * CDXUTIMEEditBox::_ImmGetDefaultIMEWnd)( HWND )
    = CDXUTIMEEditBox::Dummy_ImmGetDefaultIMEWnd;
UINT (WINAPI * CDXUTIMEEditBox::_ImmGetIMEFileNameA)( HKL, LPSTR, UINT )
    = CDXUTIMEEditBox::Dummy_ImmGetIMEFileNameA;
UINT (WINAPI * CDXUTIMEEditBox::_ImmGetVirtualKey)( HWND )
    = CDXUTIMEEditBox::Dummy_ImmGetVirtualKey;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmNotifyIME)( HIMC, DWORD, DWORD, DWORD )
    = CDXUTIMEEditBox::Dummy_ImmNotifyIME;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmSetConversionStatus)( HIMC, DWORD, DWORD )
    = CDXUTIMEEditBox::Dummy_ImmSetConversionStatus;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmSimulateHotKey)( HWND, DWORD )
    = CDXUTIMEEditBox::Dummy_ImmSimulateHotKey;
BOOL (WINAPI * CDXUTIMEEditBox::_ImmIsIME)( HKL )
    = CDXUTIMEEditBox::Dummy_ImmIsIME;
// Traditional Chinese IME
UINT (WINAPI * CDXUTIMEEditBox::_GetReadingString)( HIMC, UINT, LPWSTR, PINT, BOOL*, PUINT )
    = CDXUTIMEEditBox::Dummy_GetReadingString;
BOOL (WINAPI * CDXUTIMEEditBox::_ShowReadingWindow)( HIMC, BOOL )
    = CDXUTIMEEditBox::Dummy_ShowReadingWindow;

BOOL (APIENTRY * CDXUTIMEEditBox::_VerQueryValueA)( const LPVOID, LPSTR, LPVOID *, PUINT )
    = CDXUTIMEEditBox::Dummy_VerQueryValueA;
BOOL (APIENTRY * CDXUTIMEEditBox::_GetFileVersionInfoA)( LPSTR, DWORD, DWORD, LPVOID )
    = CDXUTIMEEditBox::Dummy_GetFileVersionInfoA;
DWORD (APIENTRY * CDXUTIMEEditBox::_GetFileVersionInfoSizeA)( LPSTR, LPDWORD )
    = CDXUTIMEEditBox::Dummy_GetFileVersionInfoSizeA;
*)

(*
HINSTANCE CDXUTIMEEditBox::s_hDllImm32;      // IMM32 DLL handle
HINSTANCE CDXUTIMEEditBox::s_hDllVer;        // Version DLL handle
HKL       CDXUTIMEEditBox::s_hklCurrent;     // Current keyboard layout of the process
bool      CDXUTIMEEditBox::s_bVerticalCand;  // Indicates that the candidates are listed vertically
WCHAR     CDXUTIMEEditBox::s_aszIndicator[5][3] = // String to draw to indicate current input locale
            {
                L"En",
                L"\x7B80",
                L"\x7E41",
                L"\xAC00",
                L"\x3042",
            };
LPWSTR    CDXUTIMEEditBox::s_wszCurrIndicator   // Points to an indicator string that corresponds to current input locale
            = CDXUTIMEEditBox::s_aszIndicator[0];
bool      CDXUTIMEEditBox::s_bInsertOnType;     // Insert the character as soon as a key is pressed (Korean behavior)
HINSTANCE CDXUTIMEEditBox::s_hDllIme;           // Instance handle of the current IME module
HIMC      CDXUTIMEEditBox::s_hImcDef;           // Default input context
CDXUTIMEEditBox::IMESTATE  CDXUTIMEEditBox::s_ImeState = IMEUI_STATE_OFF;
bool      CDXUTIMEEditBox::s_bEnableImeSystem;  // Whether the IME system is active
POINT     CDXUTIMEEditBox::s_ptCompString;      // Composition string position. Updated every frame.
int       CDXUTIMEEditBox::s_nCompCaret;
int       CDXUTIMEEditBox::s_nFirstTargetConv;  // Index of the first target converted char in comp string.  If none, -1.
CDXUTEditBox::CUniBuffer CDXUTIMEEditBox::s_CompString = CDXUTEditBox::CUniBuffer( MAX_COMPSTRING_SIZE );
BYTE      CDXUTIMEEditBox::s_abCompStringAttr[MAX_COMPSTRING_SIZE];
DWORD     CDXUTIMEEditBox::s_adwCompStringClause[MAX_COMPSTRING_SIZE];
WCHAR     CDXUTIMEEditBox::s_wszReadingString[32];
CDXUTIMEEditBox::CCandList CDXUTIMEEditBox::s_CandList;       // Data relevant to the candidate list
bool      CDXUTIMEEditBox::s_bShowReadingWindow; // Indicates whether reading window is visible
bool      CDXUTIMEEditBox::s_bHorizontalReading; // Indicates whether the reading window is vertical or horizontal
bool      CDXUTIMEEditBox::s_bChineseIME;
CGrowableArray< CDXUTIMEEditBox::CInputLocale > CDXUTIMEEditBox::s_Locale; // Array of loaded keyboard layout on system
*)



{ CDXUTIMEEditBox }

//--------------------------------------------------------------------------------------
constructor CDXUTIMEEditBox.Create(pDialog: CDXUTDialog);
begin
  inherited;
  CDXUTIMEEditBox.Initialize; // ensure static vars are properly init'ed first
  _ImmDisableTextFrameService(DWORD(-1));  // Disable TSF for the current process

  m_Type := DXUT_CONTROL_IMEEDITBOX;
  m_pDialog := pDialog;

  s_bEnableImeSystem := True;
  m_nIndicatorWidth := 0;
  m_ReadingColor := D3DCOLOR_ARGB(188, 255, 255, 255);
  m_ReadingWinColor := D3DCOLOR_ARGB(128, 0, 0, 0);
  m_ReadingSelColor := D3DCOLOR_ARGB(255, 255, 0, 0);
  m_ReadingSelBkColor := D3DCOLOR_ARGB(128, 80, 80, 80);
  m_CandidateColor := D3DCOLOR_ARGB(255, 200, 200, 200);
  m_CandidateWinColor := D3DCOLOR_ARGB(128, 0, 0, 0);
  m_CandidateSelColor := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_CandidateSelBkColor := D3DCOLOR_ARGB(128, 158, 158, 158);
  m_CompColor := D3DCOLOR_ARGB(255, 200, 200, 255);
  m_CompWinColor := D3DCOLOR_ARGB(198, 0, 0, 0);
  m_CompCaretColor := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_CompTargetColor := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_CompTargetBkColor := D3DCOLOR_ARGB(255, 150, 150, 150);
  m_CompTargetNonColor := D3DCOLOR_ARGB(255, 255, 255, 0);
  m_CompTargetNonBkColor := D3DCOLOR_ARGB(255, 150, 150, 150);
  m_IndicatorImeColor := D3DCOLOR_ARGB(255, 255, 255, 255);
  m_IndicatorEngColor := D3DCOLOR_ARGB(255, 0, 0, 0);
  m_IndicatorBkColor := D3DCOLOR_ARGB(255, 128, 128, 128);
end;

//--------------------------------------------------------------------------------------
destructor CDXUTIMEEditBox.Destroy;
begin
  inherited;
end;


//--------------------------------------------------------------------------------------
class procedure CDXUTIMEEditBox.SendKey(nVirtKey: Byte);
begin
  keybd_event(nVirtKey, 0, 0,               0);
  keybd_event(nVirtKey, 0, KEYEVENTF_KEYUP, 0);
end;


//--------------------------------------------------------------------------------------
// Called by CDXUTDialogResourceManager.OnCreateDevice.  This gives the class a
// chance to initialize its default input context associated with the app window.
class function CDXUTIMEEditBox.StaticOnCreateDevice: HRESULT;
begin
  // Save the default input context
  s_hImcDef := _ImmGetContext(DXUTGetHWND);
  _ImmReleaseContext(DXUTGetHWND, s_hImcDef);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.UpdateRects;
var
  nWidth: Integer;
begin
  // Temporary adjust m_width so that CDXUTEditBox can compute
  // the correct rects for its rendering since we need to make space
  // for the indicator button
  nWidth := m_width;
  Dec(m_width, m_nIndicatorWidth + m_nBorder * 2); // Make room for the indicator button
  inherited;
  m_width := nWidth;  // Restore

  // Compute the indicator button rectangle
  SetRect(m_rcIndicator, m_rcBoundingBox.right, m_rcBoundingBox.top, m_x + m_width, m_rcBoundingBox.bottom);
// InflateRect( &m_rcIndicator, -m_nBorder, -m_nBorder );
  m_rcBoundingBox.right := m_rcBoundingBox.left + m_width;
end;



//    MAKELCID            - construct the locale id from a language id and a sort id.
//#define MAKELCID(lgid, srtid)  ((DWORD)((((DWORD)((WORD  )(srtid))) << 16) |  \
//                                         ((DWORD)((WORD  )(lgid)))))
function MAKELCID(lgid, srtid: Word): DWORD;
begin
  Result:= (srtid shl 16) or lgid;
end;

//    MAKELANGID    - construct language id from a primary language id and
//                    a sublanguage id.
//#define MAKELANGID(p, s)       ((((WORD  )(s)) << 10) | (WORD  )(p))
function MAKELANGID(p, s: Word): Word;
begin
  Result:= (s shl 10) or p;
end;

const
  NORM_IGNORECASE      			= $00000001;     {* ignore case *}
//  NORM_IGNORENONSPACE  			= $00000002;     {* ignore diacritics *}
//  NORM_IGNORESYMBOLS   			= $00000004;     {* ignore symbols *}

//--------------------------------------------------------------------------------------
//	GetImeId( UINT uIndex )
//		returns
//	returned value:
//	0: In the following cases
//		- Non Chinese IME input locale
//		- Older Chinese IME
//		- Other error cases
//
//	Othewise:
//      When uIndex is 0 (default)
//			bit 31-24:	Major version
//			bit 23-16:	Minor version
//			bit 15-0:	Language ID
//		When uIndex is 1
//			pVerFixedInfo->dwFileVersionLS
//
//	Use IMEID_VER and IMEID_LANG macro to extract version and language information.
//	

// We define the locale-invariant ID ourselves since it doesn't exist prior to WinXP
// For more information, see the CompareString() reference.
const
  // LCID_INVARIANT = MAKELCID(MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US), SORT_DEFAULT)
  LCID_INVARIANT = (SORT_DEFAULT shl 16) or (SUBLANG_ENGLISH_US shl 10) or LANG_ENGLISH;

var
  GetImeId_hklPrev: {static} HKL = 0;
  dwID: array[0..1] of DWORD = (0, 0);  // Cache the result

class function CDXUTIMEEditBox.GetImeId(uIndex: LongWord): DWORD;
var
  dwVerSize: DWORD;
  dwVerHandle: DWORD;
  lpVerBuffer: Pointer;
  lpVerData: Pointer;
  cbVerData: LongWord;
  szTmp: array[0..1023] of Char;
  dwVer: DWORD;
begin
  if (uIndex >= SizeOf(dwID) div SizeOf(dwID[0])) then
  begin
    Result:= 0;
    Exit;
  end;

  if (GetImeId_hklPrev = s_hklCurrent) then
  begin
    Result:= dwID[uIndex];
    Exit;
  end;

  GetImeId_hklPrev := s_hklCurrent;  // Save for the next invocation

  // Check if we are using an older Chinese IME
  if not ( (s_hklCurrent = _CHT_HKL) or (s_hklCurrent = _CHT_HKL2) or (s_hklCurrent = _CHS_HKL) ) then
  begin
    dwID[1] := 0;
    dwID[0] := 0;
    Result:= dwID[uIndex];
    Exit;
  end;

  // Obtain the IME file name
  if _ImmGetIMEFileNameA(s_hklCurrent, szTmp, (SizeOf(szTmp) div SizeOf(szTmp[0])) - 1 ) = 0 then
  begin
    dwID[1] := 0;
    dwID[0] := 0;
    Result:= dwID[uIndex];
    Exit;
  end;

  // Check for IME that doesn't implement reading string API
  if (@_GetReadingString = nil) then
  begin
    if (CompareStringA(LCID_INVARIANT, NORM_IGNORECASE, szTmp, -1, CHT_IMEFILENAME1, -1) <> CSTR_EQUAL) and
       (CompareStringA(LCID_INVARIANT, NORM_IGNORECASE, szTmp, -1, CHT_IMEFILENAME2, -1) <> CSTR_EQUAL) and
       (CompareStringA(LCID_INVARIANT, NORM_IGNORECASE, szTmp, -1, CHT_IMEFILENAME3, -1) <> CSTR_EQUAL) and
       (CompareStringA(LCID_INVARIANT, NORM_IGNORECASE, szTmp, -1, CHS_IMEFILENAME1, -1) <> CSTR_EQUAL) and
       (CompareStringA(LCID_INVARIANT, NORM_IGNORECASE, szTmp, -1, CHS_IMEFILENAME2, -1) <> CSTR_EQUAL) then
    begin
      dwID[1] := 0;
      dwID[0] := 0;
      Result:= dwID[uIndex];
      Exit;
    end;
  end;

  dwVerSize := _GetFileVersionInfoSizeA(szTmp, dwVerHandle);
  if (dwVerSize <> 0) then
  begin
    lpVerBuffer := HeapAlloc(GetProcessHeap, 0, dwVerSize);
    if (lpVerBuffer <> nil) then
    begin
      if _GetFileVersionInfoA(szTmp, dwVerHandle, dwVerSize, lpVerBuffer) <> 0 then
      begin
        if _VerQueryValueA(lpVerBuffer, '\', @lpVerData, @cbVerData) then
        begin
          dwVer := PVSFixedFileInfo(lpVerData).dwFileVersionMS;
          dwVer := (dwVer and $00ff0000) shl 8 or (dwVer and $000000ff) shl 16;
          if (@_GetReadingString <> nil)
              or
             ((GetLanguage = LANG_CHT) and
               ((dwVer = MAKEIMEVERSION(4, 2)) or
                (dwVer = MAKEIMEVERSION(4, 3)) or
                (dwVer = MAKEIMEVERSION(4, 4)) or
                (dwVer = MAKEIMEVERSION(5, 0)) or
                (dwVer = MAKEIMEVERSION(5, 1)) or
                (dwVer = MAKEIMEVERSION(5, 2)) or
                (dwVer = MAKEIMEVERSION(6, 0))))
              or
             ((GetLanguage = LANG_CHS) and
              ((dwVer = MAKEIMEVERSION(4, 1)) or
               (dwVer = MAKEIMEVERSION(4, 2)) or
               (dwVer = MAKEIMEVERSION(5, 3))))
            then
          begin
            dwID[0] := dwVer or GetLanguage;
            dwID[1] := PVSFixedFileInfo(lpVerData).dwFileVersionLS;
          end;
        end;
      end;
      HeapFree(GetProcessHeap, 0, lpVerBuffer);
    end;
  end;

  Result:= dwID[uIndex];
end;


{*---------------------------------------------------------------------*
Name            _ltowlower - translates wide-characters to lower-case
Usage           wchar_t _ltowlower(wchar_t c);
Prototype in    _ltowlower is a function that converts a wide-character c
                to its lower-case value according to the current locale
Return value    returns the converted value of c, on success, and
                nothing on failure.
*---------------------------------------------------------------------*}
function towlower(ch: WideChar): WideChar;
begin
  CharLowerBuffW(@ch, 1);
  Result:= ch;
  // LCMapString(locale->handle, LCMAP_LOWERCASE, (LPCSTR) &ch, 1, (LPTSTR)&result, sizeof(result));
end;

//--------------------------------------------------------------------------------------
var
  CheckInputLocale_hklPrev: {static} HKL = 0;
class procedure CDXUTIMEEditBox.CheckInputLocale;
var
  wszLang: array[0..4] of WideChar;
begin
  // static HKL hklPrev = 0;
  s_hklCurrent := GetKeyboardLayout(0);
  if (CheckInputLocale_hklPrev = s_hklCurrent) then Exit;

  CheckInputLocale_hklPrev := s_hklCurrent;
  case GetPrimaryLanguage of
    // Simplified Chinese
    LANG_CHINESE:
    begin
      s_bVerticalCand := True;
      case GetSubLanguage of
        SUBLANG_CHINESE_SIMPLIFIED:
        begin
          s_wszCurrIndicator := s_aszIndicator[INDICATOR_CHS];
          s_bVerticalCand := (GetImeId = 0);
        end;
        SUBLANG_CHINESE_TRADITIONAL:
          s_wszCurrIndicator := s_aszIndicator[INDICATOR_CHT];
      else {case}
        // unsupported sub-language
        s_wszCurrIndicator := s_aszIndicator[INDICATOR_NON_IME];
      end;
    end;

    // Korean
    LANG_KOREAN:
    begin
      s_wszCurrIndicator := s_aszIndicator[INDICATOR_KOREAN];
      s_bVerticalCand := False;
    end;

    // Japanese
    LANG_JAPANESE:
    begin
      s_wszCurrIndicator := s_aszIndicator[INDICATOR_JAPANESE];
      s_bVerticalCand := True;
    end;

  else {case GetPrimaryLanguage}
    // A non-IME language.  Obtain the language abbreviation
    // and store it for rendering the indicator later.
    s_wszCurrIndicator := s_aszIndicator[INDICATOR_NON_IME];
  end;

  // If non-IME, use the language abbreviation.
  if (s_wszCurrIndicator = @s_aszIndicator[INDICATOR_NON_IME]) then
  begin
    GetLocaleInfoW(MAKELCID(LOWORD(s_hklCurrent), SORT_DEFAULT), LOCALE_SABBREVLANGNAME, wszLang, 5);
    s_wszCurrIndicator[0] := wszLang[0];
    s_wszCurrIndicator[1] := towlower(wszLang[1]);
  end;
end;


//--------------------------------------------------------------------------------------
class procedure CDXUTIMEEditBox.CheckToggleState;
var
  bIme: Boolean;
  hImc: Imm.HIMC;
  dwConvMode, dwSentMode: DWORD;
begin
  CheckInputLocale;
  bIme := _ImmIsIME(s_hklCurrent);
  s_bChineseIME := (GetPrimaryLanguage = LANG_CHINESE) and bIme;

  hImc := _ImmGetContext(DXUTGetHWND);
  if (0 <> hImc) then
  begin
    if (s_bChineseIME) then
    begin
      _ImmGetConversionStatus(hImc, dwConvMode, dwSentMode);
      if (dwConvMode and IME_CMODE_NATIVE <> 0)
        then s_ImeState := IMEUI_STATE_ON
        else s_ImeState := IMEUI_STATE_ENGLISH;
    end else
    begin
      if (bIme and _ImmGetOpenStatus(hImc))
        then s_ImeState := IMEUI_STATE_ON
        else s_ImeState := IMEUI_STATE_OFF;
    end;
    _ImmReleaseContext(DXUTGetHWND, hImc);
  end
  else
    s_ImeState := IMEUI_STATE_OFF;
end;


//--------------------------------------------------------------------------------------
// Enable/disable the entire IME system.  When disabled, the default IME handling
// kicks in.
class procedure CDXUTIMEEditBox.EnableImeSystem(bEnable: Boolean);
begin
  s_bEnableImeSystem := bEnable;
end;


//--------------------------------------------------------------------------------------
// Sets up IME-specific APIs for the IME edit controls.  This is called every time
// the input locale changes.
class procedure CDXUTIMEEditBox.SetupImeApi;
var
  szImeFile: array[0..MAX_PATH] of Char;
begin
  _GetReadingString := nil;
  _ShowReadingWindow := nil;
  if (_ImmGetIMEFileNameA(s_hklCurrent, szImeFile, SizeOf(szImeFile) div SizeOf(szImeFile[0]) - 1) = 0)
  then Exit;

  if (s_hDllIme <> 0) then FreeLibrary(s_hDllIme);
  s_hDllIme := LoadLibraryA(szImeFile);
  if (s_hDllIme = 0) then Exit;

  _GetReadingString := GetProcAddress(s_hDllIme, 'GetReadingString');
  _ShowReadingWindow := GetProcAddress(s_hDllIme, 'ShowReadingWindow');
end;


//--------------------------------------------------------------------------------------
// Resets the composition string.
class procedure CDXUTIMEEditBox.ResetCompositionString;
begin
  s_nCompCaret := 0;
  s_CompString.SetText('');
  ZeroMemory(@s_abCompStringAttr, SizeOf(s_abCompStringAttr));
end;


//--------------------------------------------------------------------------------------
// Truncate composition string by sending keystrokes to the window.
procedure CDXUTIMEEditBox.TruncateCompString(bUseBackSpace: Boolean;
  iNewStrLen: Integer);
var
  cc: Integer;
  i: Integer;
begin
  if not s_bInsertOnType then Exit;

  cc := lstrlenW(s_CompString.Buffer);
  Assert((iNewStrLen = 0) or (iNewStrLen >= cc));
  
  // Send right arrow keystrokes to move the caret
  //   to the end of the composition string.
  for i := 0 to (cc - s_nCompCaret) - 1 do
    SendMessage(DXUTGetHWND, WM_KEYDOWN, VK_RIGHT, 0);
  SendMessage(DXUTGetHWND, WM_KEYUP, VK_RIGHT, 0);

  if (bUseBackSpace or m_bInsertMode) then iNewStrLen := 0;

  // The caller sets bUseBackSpace to false if there's possibility of sending
  // new composition string to the app right after this function call.
  //
  // If the app is in overwriting mode and new comp string is
  // shorter than current one, delete previous comp string
  // till it's same long as the new one. Then move caret to the beginning of comp string.
  // New comp string will overwrite old one.
  if (iNewStrLen < cc) then
  begin
    for i := 0 to (cc - iNewStrLen) - 1 do 
    begin
      SendMessage(DXUTGetHWND, WM_KEYDOWN, VK_BACK, 0);  // Backspace character
      SendMessageW(DXUTGetHWND, WM_CHAR, VK_BACK, 0);
    end;
    SendMessage(DXUTGetHWND, WM_KEYUP, VK_BACK, 0);
  end else
    iNewStrLen := cc;

  // Move the caret to the beginning by sending left keystrokes
  for i := 0 to iNewStrLen - 1 do
    SendMessage(DXUTGetHWND, WM_KEYDOWN, VK_LEFT, 0);
  SendMessage(DXUTGetHWND, WM_KEYUP, VK_LEFT, 0);
end;


//--------------------------------------------------------------------------------------
// Sends the current composition string to the application by sending keystroke
// messages.
procedure CDXUTIMEEditBox.SendCompString;
var
  i: Integer;
begin
  for i := 0 to lstrlenW(s_CompString.Buffer) - 1 do
    MsgProc(WM_CHAR, WPARAM(s_CompString[i]), 0);
end;


//--------------------------------------------------------------------------------------
// Outputs current composition string then cleans up the composition task.
var
  bProcessing: {static} Boolean = False;

procedure CDXUTIMEEditBox.FinalizeString(bSend: Boolean);
var
  hImc: Imm.HIMC;
  lLength: Longint;
begin
  hImc := _ImmGetContext(DXUTGetHWND);
  if (hImc = 0) then Exit;

  if bProcessing then    // avoid infinite recursion
  begin
    DXUTTRACE(UnitName, $FFFF, 0, 'CDXUTIMEEditBox::FinalizeString: Reentrant detected!'#10, False);
    _ImmReleaseContext(DXUTGetHWND, hImc);
    Exit;
  end;
  bProcessing := True;

  if not s_bInsertOnType and bSend then
  begin
    // Send composition string to app.
    lLength := lstrlenW(s_CompString.Buffer);
    // In case of CHT IME, don't send the trailing double byte space, if it exists.
    if (GetLanguage = LANG_CHT)
       and (s_CompString[lLength - 1] = #$3000) then
    begin
      s_CompString[lLength - 1] := #0;
    end;
    SendCompString;
  end;

  ResetCompositionString;
  // Clear composition string in IME
  _ImmNotifyIME(hImc, NI_COMPOSITIONSTR, CPS_CANCEL, 0);
  // the following line is necessary as Korean IME doesn't close cand list
  // when comp string is cancelled.
  _ImmNotifyIME(hImc, NI_CLOSECANDIDATE, 0, 0);
  _ImmReleaseContext(DXUTGetHWND, hImc);
  bProcessing := False;
end;


//--------------------------------------------------------------------------------------
// Determine whether the reading window should be vertical or horizontal.
class procedure CDXUTIMEEditBox.GetReadingWindowOrientation(dwId: DWORD);
var
  wszRegPath: array[0..MAX_PATH-1] of WideChar;
  hKey: Windows.HKEY;
  dwVer: DWORD;
  lRc: Longint;
  dwSize, dwMapping, dwType: DWORD;
begin
  s_bHorizontalReading := (s_hklCurrent = _CHS_HKL) or (s_hklCurrent = _CHT_HKL2) or (dwId = 0);
  if not s_bHorizontalReading and ((dwId and $0000FFFF) = LANG_CHT) then
  begin
    dwVer := dwId and $FFFF0000;
    StringCchCopy(wszRegPath, MAX_PATH, 'software\microsoft\windows\currentversion\');
    if (dwVer >= MAKEIMEVERSION(5, 1))
      then StringCchCat(wszRegPath, MAX_PATH, 'MSTCIPH')
      else StringCchCat(wszRegPath, MAX_PATH, 'TINTLGNT');
    lRc := RegOpenKeyExW(HKEY_CURRENT_USER, wszRegPath, 0, KEY_READ, hKey);
    if (lRc = ERROR_SUCCESS) then
    begin
      dwSize := SizeOf(DWORD);
      lRc := RegQueryValueExW(hKey, 'Keyboard Mapping', nil, @dwType, @dwMapping, @dwSize);
      if (lRc = ERROR_SUCCESS) then
      begin
        if ( (dwVer <= MAKEIMEVERSION(5, 0)) and ( (dwMapping = $22) or (dwMapping = $23) ) )
             or
           ( ( (dwVer = MAKEIMEVERSION(5, 1)) or (dwVer = MAKEIMEVERSION(5, 2) ) and
             ( (dwMapping >= $22) and (dwMapping <= $24) ) ) )
          then
        begin
          s_bHorizontalReading := True;
        end;
      end;
      RegCloseKey(hKey);
    end;
  end;
end;



//--------------------------------------------------------------------------------------
// Obtain the reading string upon WM_IME_NOTIFY/INM_PRIVATE notification.
class procedure CDXUTIMEEditBox.GetPrivateReadingString;
var
  dwId: DWORD;
  hImc: Imm.HIMC;
  dwReadingStrLen: DWORD;
  dwErr: Integer;
  pwszReadingStringBuffer: PWideChar;  // Buffer for when the IME supports GetReadingString()
  wstr: PWideChar;
  bUnicodeIme: Boolean;  // Whether the IME context component is Unicode.
  lpIC: PInputContext;
  uMaxUiLen: LongWord;
  bVertical: BOOL;
  p: PByte;
  nOffset: Integer;
  osi: TOSVersionInfoW;
  nTcharSize: Integer;
  i: Integer;
  pch: PChar;
  j: DWORD;
  wszCodePage: array[0..7] of WideChar;
  uCodePage: LongWord;  // Default code page
begin
  dwId := GetImeId;
  if (dwId = 0) then
  begin
    s_bShowReadingWindow := False;
    Exit;
  end;

  hImc := _ImmGetContext(DXUTGetHWND);
  if (hImc = 0) then
  begin
    s_bShowReadingWindow := False;
    Exit;
  end;


  dwReadingStrLen := 0;
  dwErr := 0;
  pwszReadingStringBuffer := nil;  // Buffer for when the IME supports GetReadingString()
  wstr := nil;
  bUnicodeIme := False;  // Whether the IME context component is Unicode.
  lpIC := nil;

  if (@_GetReadingString <> nil) then
  begin            
    // Obtain the reading string size
    dwReadingStrLen := _GetReadingString(hImc, 0, nil, @dwErr, @bVertical, @uMaxUiLen);
    if (dwReadingStrLen <> 0) then
    begin
      pwszReadingStringBuffer := HeapAlloc(GetProcessHeap, 0, SizeOf(WideChar) * dwReadingStrLen);
      wstr := pwszReadingStringBuffer;
      if (pwszReadingStringBuffer = nil) then
      begin
        // Out of memory. Exit.
        _ImmReleaseContext(DXUTGetHWND, hImc);
        Exit;
      end;

      // Obtain the reading string
      dwReadingStrLen := _GetReadingString(hImc, dwReadingStrLen, wstr, @dwErr, @bVertical, @uMaxUiLen);
    end;

    s_bHorizontalReading := not bVertical;
    bUnicodeIme := True;
  end else
  begin
    // IMEs that doesn't implement Reading String API

    lpIC := _ImmLockIMC(hImc);

    // p := nil; // - never used
    case dwId of
      IMEID_CHT_VER42, // New(Phonetic/ChanJie)IME98  : 4.2.x.x // Win98
      IMEID_CHT_VER43, // New(Phonetic/ChanJie)IME98a : 4.3.x.x // WinMe, Win2k
      IMEID_CHT_VER44: // New ChanJie IME98b          : 4.4.x.x // WinXP
      begin
        // p = *(LPBYTE *)((LPBYTE)_ImmLockIMCC( lpIC->hPrivate ) + 24 );
        p:= PByte(PPointer(Longword(_ImmLockIMCC(lpIC^.hPrivate)) + 24)^);
        if (p <> nil) then
        begin
          dwReadingStrLen := PDWORD(Longword(p) + 7 * 4 + 32 * 4)^;
          dwErr := PDWORD(Longword(p) + 8 * 4 + 32 * 4)^;
          wstr := PWideChar(Longword(p) + 56);
          bUnicodeIme := True;
        end;
      end;

      IMEID_CHT_VER50: // 5.0.x.x // WinME
      begin
        // p = *(LPBYTE *)( (LPBYTE)_ImmLockIMCC( lpIC->hPrivate ) + 3 * 4 );
        p:= PByte(PPointer(Longword(_ImmLockIMCC(lpIC^.hPrivate)) + 3 * 4)^);
        if (p <> nil) then
        begin
          p := PByte(PPointer(Longword(p) + 1*4 + 5*4 + 4*2)^);
          if (p <> nil) then
          begin
            dwReadingStrLen := PDWORD(Longword(p) + 1*4 + (16*2+2*4) + 5*4 + 16)^;
            dwErr := PDWORD(Longword(p) + 1*4 + (16*2+2*4) + 5*4 + 16 + 1*4)^;
            wstr := PWideChar(Longword(p) + 1*4 + (16*2+2*4) + 5*4);
            bUnicodeIme := False;
          end;
        end;
      end;

      IMEID_CHT_VER51, // 5.1.x.x // IME2002(w/OfficeXP)
      IMEID_CHT_VER52, // 5.2.x.x // (w/whistler)
      IMEID_CHS_VER53: // 5.3.x.x // SCIME2k or MSPY3 (w/OfficeXP and Whistler)
      begin
        // p = *(LPBYTE *)( (LPBYTE)_ImmLockIMCC( lpIC->hPrivate ) + 4 );
        p:= PByte(PPointer(Longword(_ImmLockIMCC(lpIC^.hPrivate)) + 4)^);
        if (p <> nil) then
        begin
          p := PByte(PPointer(Longword(p) + 1*4 + 5*4)^);
          if (p <> nil) then
          begin                               
            dwReadingStrLen := PDWORD(Longword(p) + 1*4 + (16*2+2*4) + 5*4 + 16 * 2)^;
            dwErr := PDWORD(Longword(p) + 1*4 + (16*2+2*4) + 5*4 + 16 * 2 + 1*4)^;
            wstr := PWideChar(Longword(p) + 1*4 + (16*2+2*4) + 5*4);
            bUnicodeIme := True;
          end;
        end;
      end;

      // the code tested only with Win 98 SE (MSPY 1.5/ ver 4.1.0.21)
      IMEID_CHS_VER41:
      begin
        nOffset := IfThen((GetImeId(1) >= $00000002), 8, 7);
        // p = *(LPBYTE *)( (LPBYTE)_ImmLockIMCC( lpIC->hPrivate ) + nOffset * 4 );
        p:= PByte(PPointer(Integer(_ImmLockIMCC(lpIC^.hPrivate)) + nOffset * 4)^);
        if (p <> nil) then
        begin
          dwReadingStrLen := PDWORD(Longword(p) + 7*4 + 16*2*4)^;
          dwErr := PDWORD(Longword(p) + 8*4 + 16*2*4)^;
          dwErr := Min(dwErr, Integer(dwReadingStrLen));
          wstr := PWideChar(Longword(p) + 6*4 + 16*2*1);
          bUnicodeIme := True;
        end;
      end;

      IMEID_CHS_VER42: // 4.2.x.x // SCIME98 or MSPY2 (w/Office2k, Win2k, WinME, etc)
      begin
        osi.dwOSVersionInfoSize := SizeOf(TOSVersionInfoW);
        {$IFDEF FPC}
        GetVersionExW(osi);
        {$ELSE}
        GetVersionExW(POSVersionInfo(@osi)^); //todo: Bug in all Delphi versions
        {$ENDIF}

        nTcharSize := IfThen((osi.dwPlatformId = VER_PLATFORM_WIN32_NT), SizeOf(WideChar), SizeOf(Char));
        // p = *(LPBYTE *)((LPBYTE)_ImmLockIMCC( lpIC->hPrivate ) + 1*4 + 1*4 + 6*4);
        p:= PByte(PPointer(Longword(_ImmLockIMCC(lpIC^.hPrivate)) + 1*4 + 1*4 + 6*4)^);
        if (p <> nil) then
        begin
          dwReadingStrLen := PDWORD(Integer(p) + 1*4 + (16*2+2*4) + 5*4 + 16 * nTcharSize)^;
          dwErr := PDWORD(Integer(p) + 1*4 + (16*2+2*4) + 5*4 + 16 * nTcharSize + 1*4)^;
          wstr := PWideChar(Longword(p) + 1*4 + (16*2+2*4) + 5*4);
          bUnicodeIme := (osi.dwPlatformId = VER_PLATFORM_WIN32_NT);
        end;
      end;
    end; // case
  end;

  // Copy the reading string to the candidate list first
  s_CandList.awszCandidate[0][0] := #0;
  s_CandList.awszCandidate[1][0] := #0;
  s_CandList.awszCandidate[2][0] := #0;
  s_CandList.awszCandidate[3][0] := #0;
  s_CandList.dwCount := dwReadingStrLen;
  s_CandList.dwSelection := DWORD(-1); // do not select any char
  if bUnicodeIme then
  begin
    for i := 0 to dwReadingStrLen - 1 do // dwlen > 0, if known IME
    begin
      if (dwErr <= i) and (s_CandList.dwSelection = DWORD(-1)) then 
      begin
        // select error char
        s_CandList.dwSelection := i;
      end;

      s_CandList.awszCandidate[i][0] := wstr[i];
      s_CandList.awszCandidate[i][1] := #0;
    end;
    s_CandList.awszCandidate[dwReadingStrLen][0] := #0; //todo: check if this conversion is correct [dwReadingStrLen]==[i]
  end else
  begin
    pch := PChar(wstr);
    i := 0;
    // for i = 0, j = 0; i < dwReadingStrLen; ++i, ++j ) // dwlen > 0, if known IME
    for j := 0 to dwReadingStrLen - 1 do // dwlen > 0, if known IME
    begin
      if (dwErr <= i) and (s_CandList.dwSelection = DWORD(-1)) then
      begin
        s_CandList.dwSelection := j;
      end;
      // Obtain the current code page
      uCodePage := CP_ACP;  // Default code page
      if (GetLocaleInfoW(MAKELCID(GetLanguage, SORT_DEFAULT ),
                         LOCALE_IDEFAULTANSICODEPAGE,
                         wszCodePage,
                         SizeOf(wszCodePage) div SizeOf(wszCodePage[0])) <> 0) then
      begin
        {$IFDEF FPC}
        uCodePage := StrToInt(WideCharToString(wszCodePage)); // wcstoul(wszCodePage, nil, 0);
        {$ELSE}
        uCodePage := StrToInt(wszCodePage); // wcstoul(wszCodePage, nil, 0);
        {$ENDIF}
      end;
      MultiByteToWideChar(uCodePage, 0, pch + i,
                          IfThen(Boolean(IsDBCSLeadByteEx(uCodePage, Byte(pch[i]))), 2, 1),
                          s_CandList.awszCandidate[j], 1);
      if IsDBCSLeadByteEx(uCodePage, Byte(pch[i])) then Inc(i);
      Inc(i);
    end;
    s_CandList.awszCandidate[dwReadingStrLen][0] := #0;  //todo: check if this conversion is correct [dwReadingStrLen]==[j]
    s_CandList.dwCount := dwReadingStrLen;
  end;
  if (@_GetReadingString = nil) then
  begin
    _ImmUnlockIMCC(lpIC.hPrivate);
    _ImmUnlockIMC(hImc);
    GetReadingWindowOrientation(dwId);
  end;
  _ImmReleaseContext(DXUTGetHWND, hImc);

  if (pwszReadingStringBuffer <> nil) then
    HeapFree(GetProcessHeap, 0, pwszReadingStringBuffer);

  // Copy the string to the reading string buffer
  s_bShowReadingWindow := (s_CandList.dwCount > 0);
  if (s_bHorizontalReading) then
  begin
    s_CandList.nReadingError := -1;
    s_wszReadingString[0] := #0;
    for i := 0 to s_CandList.dwCount - 1 do
    begin
      if (s_CandList.dwSelection = DWORD(i)) then
        s_CandList.nReadingError := lstrlenW(s_wszReadingString);
      StringCchCat(s_wszReadingString, 32, s_CandList.awszCandidate[i]);
    end;
  end;

  s_CandList.dwPageSize := MAX_CANDLIST;
end;


//--------------------------------------------------------------------------------------
// This function is used only briefly in CHT IME handling,
// so accelerator isn't processed.
procedure CDXUTIMEEditBox.PumpMessage;
var
  msg: TMSG;
begin
  while PeekMessageW(msg, 0, 0, 0, PM_NOREMOVE) do
  begin
    if (not GetMessageW(msg, 0, 0, 0)) then
    begin
      PostQuitMessage(msg.wParam);
      Exit;
    end;
    TranslateMessage(msg);
    DispatchMessageA(msg);
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.OnFocusIn;
var
  hImc: Imm.HIMC;
begin
  inherited; // CDXUTEditBox::OnFocusIn();

  if s_bEnableImeSystem then
  begin
    _ImmAssociateContext(DXUTGetHWND, s_hImcDef);
    CheckToggleState;
  end else
    _ImmAssociateContext(DXUTGetHWND, 0);

  //
  // Set up the IME global state according to the current instance state
  //
  hImc := _ImmGetContext(DXUTGetHWND);
  if (hImc <> 0) then
  begin
    if not s_bEnableImeSystem then s_ImeState := IMEUI_STATE_OFF;

    _ImmReleaseContext(DXUTGetHWND, hImc);
    CheckToggleState;
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.OnFocusOut;
begin
  inherited; // CDXUTEditBox::OnFocusOut();

  FinalizeString(False);  // Don't send the comp string as to match RichEdit behavior

  _ImmAssociateContext(DXUTGetHWND, 0);
end;


//Clootie: Delphi7 bug in Windows.pas
function GetKeyboardLayoutList(nBuff: Integer; List: Pointer): UINT; stdcall; external user32 name 'GetKeyboardLayoutList';


//#define PRIMARYLANGID(lgid)    ((WORD  )(lgid) & 0x3ff)
function PRIMARYLANGID(lgid: DWORD): Word;
begin
  Result:= (lgid and $3ff);
end;

//#define SUBLANGID(lgid)        ((WORD  )(lgid) >> 10)
function SUBLANGID(lgid: DWORD): Word;
begin
  Result:= (lgid shr 10);
end;

const
  WM_INPUTLANGCHANGE              = $0051;

//--------------------------------------------------------------------------------------
class function CDXUTIMEEditBox.StaticMsgProc(uMsg: LongWord;
  wParam: WPARAM; lParam: LPARAM): BOOL;
type
  PHKLarray = ^THKLarray;
  THKLarray = array[0..MaxInt div SizeOf(Windows.HKL)-1] of Windows.HKL;
var
  hImc: Imm.HIMC;
  cKL: LongWord;
  phKL: PHKLarray; // ^Windows.HKL;
  i: LongWord;
  Locale: CInputLocale;
  bBreak: Boolean;
  e, l: Integer;
  wszDesc: array[0..127] of WideChar;
  uLang: LongWord;
begin
  Result:= False;
  if not s_bEnableImeSystem then Exit;

{$IFDEF DEBUG}
  m_bIMEStaticMsgProcCalled := True;
{$ENDIF}

  case uMsg of
    WM_ACTIVATEAPP:
      if (wParam <> 0) then
      begin
        // Populate s_Locale with the list of keyboard layouts.
        cKL := GetKeyboardLayoutList(0, nil);
        s_Locale:= nil; // RemoveAll;
        GetMem(phKL, SizeOf(HKL)*cKL);
        if (phKL <> nil) then //Clootie: This is aloways TRUE in Delphi (overwise exception will be raized)
        begin
          GetKeyboardLayoutList(cKL, phKL);
          for i := 0 to cKL-1 do
          begin
            // Filter out East Asian languages that are not IME.
            if ( (PRIMARYLANGID(LOWORD(phKL[i])) = LANG_CHINESE) or
                 (PRIMARYLANGID(LOWORD(phKL[i])) = LANG_JAPANESE) or
                 (PRIMARYLANGID(LOWORD(phKL[i])) = LANG_KOREAN)
                ) and
               not _ImmIsIME(phKL[i])
            then Continue;

            // If this language is already in the list, don't add it again.
            bBreak := False;
            for e := 0 to Length(s_Locale) - 1 do
              if (LOWORD(s_Locale[e].m_hKL) = LOWORD(phKL[i])) then
              begin
                bBreak := True;
                Break;
              end;

            if not bBreak then
            begin
              Locale.m_hKL := phKL[i];
              wszDesc[0] := #0;
              case PRIMARYLANGID(LOWORD(phKL[i])) of
                // Simplified Chinese
                LANG_CHINESE:
                  case SUBLANGID(LOWORD(phKL[i])) of
                    SUBLANG_CHINESE_SIMPLIFIED:  StringCchCopy(Locale.m_wszLangAbb, 3, s_aszIndicator[INDICATOR_CHS]);
                    SUBLANG_CHINESE_TRADITIONAL: StringCchCopy(Locale.m_wszLangAbb, 3, s_aszIndicator[INDICATOR_CHT]);
                  else // unsupported sub-language
                    GetLocaleInfoW(MAKELCID(LOWORD(phKL[i]), SORT_DEFAULT), LOCALE_SABBREVLANGNAME, wszDesc, 128);
                    Locale.m_wszLangAbb[0] := wszDesc[0];
                    Locale.m_wszLangAbb[1] := towlower(wszDesc[1]);
                    Locale.m_wszLangAbb[2] := #0;
                  end;

                // Korean
                LANG_KOREAN: StringCchCopy(Locale.m_wszLangAbb, 3, s_aszIndicator[INDICATOR_KOREAN]);

                // Japanese
                LANG_JAPANESE: StringCchCopy(Locale.m_wszLangAbb, 3, s_aszIndicator[INDICATOR_JAPANESE]);

              else
                // A non-IME language.  Obtain the language abbreviation
                // and store it for rendering the indicator later.
                GetLocaleInfoW(MAKELCID(LOWORD(phKL[i]), SORT_DEFAULT), LOCALE_SABBREVLANGNAME, wszDesc, 128);
                Locale.m_wszLangAbb[0] := wszDesc[0];
                Locale.m_wszLangAbb[1] := towlower(wszDesc[1]);
                Locale.m_wszLangAbb[2] := #0;
              end;

              GetLocaleInfoW(MAKELCID(LOWORD(phKL[i]), SORT_DEFAULT), LOCALE_SLANGUAGE, wszDesc, 128);
              StringCchCopy(Locale.m_wszLang, 64, wszDesc);
              Locale.m_wszLang[SizeOf(Locale.m_wszLang) div SizeOf(Locale.m_wszLang[0]) - 1] := #0;

              // s_Locale.Add(Locale);
              l:= Length(s_Locale);
              SetLength(s_Locale, l+1);
              s_Locale[l]:= Locale;
            end;
          end;
          FreeMem(phKL);
        end;
      end;

    WM_INPUTLANGCHANGE:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, 'WM_INPUTLANGCHANGE'#10, False);
      begin
        uLang := GetPrimaryLanguage;
        CheckToggleState;
        if (uLang <> GetPrimaryLanguage) then
        begin
          // Korean IME always inserts on keystroke.  Other IMEs do not.
          s_bInsertOnType := (GetPrimaryLanguage = LANG_KOREAN);
        end;

        // IME changed.  Setup the new IME.
        SetupImeApi;
        if (@_ShowReadingWindow <> nil) then
        begin
          hImc := _ImmGetContext(DXUTGetHWND);
          if (hImc <> 0) then
          begin
            _ShowReadingWindow(hImc, False);
            _ImmReleaseContext(DXUTGetHWND, hImc);
          end;
        end;
      end;
      Result:= True;
      Exit;
    end;

    WM_IME_SETCONTEXT:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, 'WM_IME_SETCONTEXT'#10, False);
      //
      // We don't want anything to display, so we have to clear this
      //
      // lParam := 0; // - never used
      Result:= False;
      Exit;
    end;

      // Handle WM_IME_STARTCOMPOSITION here since
      // we do not want the default IME handler to see
      // this when our fullscreen app is running.
    WM_IME_STARTCOMPOSITION:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, 'WM_IME_STARTCOMPOSITION'#10, False);
      ResetCompositionString;
      // Since the composition string has its own caret, we don't render
      // the edit control's own caret to avoid double carets on screen.
      s_bHideCaret := True;
      Result:= True;
      Exit;
    end;

    WM_IME_COMPOSITION:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, 'WM_IME_COMPOSITION'#10, False);
      Result:= False;
      Exit;
    end;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
function CDXUTIMEEditBox.HandleMouse(uMsg: LongWord; pt: TPoint;
  wParam: WPARAM; lParam: LPARAM): Boolean;
var
  pFont: PDXUTFontNode;
  nCompStrWidth: Integer;
  nCharBodyHit, nCharHit: Integer;
  nTrail: LongBool;
  hImc: Imm.HIMC;
  nClauseClicked: Integer;
  nClauseSelected: Integer;
  nVirtKey: Byte;
  nSendCount: Integer;
  nRow: Integer;
  nNumToHit: Integer;
  nStrike: Integer;
  nCandidate: Integer;
  nEntryStart: Integer;
  i: LongWord;
label
  label_LANG_CHINESE;
begin
  Result:= True;
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      pFont := m_pDialog.GetFont(m_Elements[9].iFont);

      // Check if this click is on top of the composition string
      s_CompString.CPtoX(s_CompString.TextSize, False, nCompStrWidth);

      if (s_ptCompString.x <= pt.x) and
         (s_ptCompString.y <= pt.y) and
         (s_ptCompString.x + nCompStrWidth > pt.x) and
         (s_ptCompString.y + pFont.nHeight > pt.y) then
      begin
        // Determine the character clicked on.
        s_CompString.XtoCP(pt.x - s_ptCompString.x, nCharBodyHit, nTrail);
        if nTrail and (nCharBodyHit < s_CompString.TextSize)
        then nCharHit := nCharBodyHit + 1
        else nCharHit := nCharBodyHit;

        // Now generate keypress events to move the comp string cursor
        // to the click point.  First, if the candidate window is displayed,
        // send Esc to close it.
        hImc := _ImmGetContext(DXUTGetHWND);
        if (hImc = 0) then Exit;

        _ImmNotifyIME(hImc, NI_CLOSECANDIDATE, 0, 0);
        _ImmReleaseContext(DXUTGetHWND, hImc);

        if (GetPrimaryLanguage = LANG_JAPANESE) then
        begin
          // For Japanese, there are two cases.  If s_nFirstTargetConv is
          // -1, the comp string hasn't been converted yet, and we use
          // s_nCompCaret.  For any other value of s_nFirstTargetConv,
          // the string has been converted, so we use clause information.

          if (s_nFirstTargetConv <> -1) then
          begin
            nClauseClicked := 0;
            while (s_adwCompStringClause[nClauseClicked + 1] <= LongWord(nCharBodyHit))
            do Inc(nClauseClicked);

            nClauseSelected := 0;
            while (s_adwCompStringClause[nClauseSelected + 1] <= LongWord(s_nFirstTargetConv))
            do Inc(nClauseSelected);

            nVirtKey := Byte(IfThen(nClauseClicked > nClauseSelected, VK_RIGHT, VK_LEFT));
            nSendCount := Abs(nClauseClicked - nClauseSelected);
            // while ( nSendCount-- > 0 )
            while (nSendCount > 0 ) do
            begin
              Dec(nSendCount);
              SendKey(nVirtKey);
            end;
            Exit;
          end;

          // Not converted case. Fall thru to Chinese case.
          goto label_LANG_CHINESE; //Clootie: this is due to awfull usage of switch statement in C++
        end else
        if (GetPrimaryLanguage = LANG_CHINESE) then
        begin
          label_LANG_CHINESE:

          // For Chinese, use s_nCompCaret.
          nVirtKey := Byte(IfThen(nCharHit > s_nCompCaret, VK_RIGHT, VK_LEFT));
          nSendCount := Abs(nCharHit - s_nCompCaret);
          while (nSendCount > 0) do
          begin
            Dec(nSendCount);
            SendKey(nVirtKey);
          end;
        end;

        Exit;
      end;

      // Check if the click is on top of the candidate window
      if (s_CandList.bShowWindow and PtInRect(s_CandList.rcCandidate, pt)) then
      begin
        if (s_bVerticalCand) then
        begin
          // Vertical candidate window

          // Compute the row the click is on
          nRow := (pt.y - s_CandList.rcCandidate.top) div pFont.nHeight;

          if (LongWord(nRow) < s_CandList.dwCount) then
          begin
            // nRow is a valid entry.
            // Now emulate keystrokes to select the candidate at this row.
            case GetPrimaryLanguage of
              LANG_CHINESE,
              LANG_KOREAN:
                // For Chinese and Korean, simply send the number keystroke.
                SendKey(Ord('0') + nRow + 1);

              LANG_JAPANESE:
              begin
                // For Japanese, move the selection to the target row,
                // then send Right, then send Left.

                if (LongWord(nRow) > s_CandList.dwSelection)
                  then nVirtKey := VK_DOWN
                  else nVirtKey := VK_UP;

                nNumToHit := Abs(nRow - Integer(s_CandList.dwSelection));
                for nStrike := 0 to nNumToHit - 1 do SendKey(nVirtKey);

                // Do this to close the candidate window without ending composition.
                SendKey(VK_RIGHT);
                SendKey(VK_LEFT);
              end;
            end; {case}
          end
        end else
        begin
          // Horizontal candidate window

          // Determine which the character the click has hit.
          s_CandList.HoriCand.XtoCP(pt.x - s_CandList.rcCandidate.left, nCharHit, nTrail);

          // Determine which candidate string the character belongs to.
          nCandidate := s_CandList.dwCount - 1;

          nEntryStart := 0;
          for i := 0 to s_CandList.dwCount - 1 do
          begin
            if (nCharHit >= nEntryStart) then
            begin
              // Haven't found it.
              Inc(nEntryStart, lstrlenW(s_CandList.awszCandidate[i] ) + 1);  // plus space separator
            end else
            begin
              // Found it.  This entry starts at the right side of the click point,
              // so the char belongs to the previous entry.
              nCandidate := i - 1;
              Break;
            end;
          end;

          // Now emulate keystrokes to select the candidate entry.
          case GetPrimaryLanguage of
            LANG_CHINESE,
            LANG_KOREAN:
              // For Chinese and Korean, simply send the number keystroke.
              SendKey(Ord('0') + nCandidate + 1);
          end;
        end;

        Exit;
      end;
    end;
  end;

  // If we didn't care for the msg, let the parent process it.
  Result:= inherited {CDXUTEditBox::}HandleMouse(uMsg, pt, wParam, lParam);
end;



//--------------------------------------------------------------------------------------
var
  {static}
  lAlt:   DWORD = $80000000;
  lCtrl:  DWORD = $80000000;
  lShift: DWORD = $80000000;

function CDXUTIMEEditBox.MsgProc(uMsg: LongWord; wParam: WPARAM;
  lParam: LPARAM): Boolean;
var
  trappedData: Boolean;
  trapped: {$IFDEF FPC}System.{$ENDIF}PBoolean;
  hImc: Imm.HIMC;
  lRet: Longint;  // Returned count in CHARACTERS
  wszCompStr: array[0..MAX_COMPSTRING_SIZE-1] of WideChar;
  i, j: Integer;
  nCount: Integer;
  lpCandList: PCandidateList;
  dwLenRequired: DWORD;
  nPageTopIndex: Integer;
  pwsz: PWideChar;
  pwszNewCand: PWideChar;
  wszCand: array[0..255] of WideChar;
  wszEntry: array[0..31] of WideChar;
  dwId: DWORD;
begin
  // Result:= True; // - never used
  if (not m_bEnabled or not m_bVisible) then
  begin
    Result:= False;
    Exit;
  end;

{$IFDEF DEBUG}
  // DXUT.cpp used to call CDXUTIMEEditBox::StaticMsgProc() so that, but now
  // this is the application's responsiblity.  To do this, call
  // CDXUTDialogResourceManager::MsgProc() before calling this function.
  Assert(m_bIMEStaticMsgProcCalled, 'To fix, call CDXUTDialogResourceManager.MsgProc() first');
{$ENDIF}

  trapped := @trappedData;

//  static LPARAM lAlt = 0x80000000, lCtrl = 0x80000000, lShift = 0x80000000;

  trapped^ := False;
  if (not s_bEnableImeSystem) then
  begin
    Result:= inherited {CDXUTEditBox::}MsgProc(uMsg, wParam, lParam);
    Exit;
  end;

  case uMsg of
    //
    //  IME Handling
    //
    WM_IME_COMPOSITION:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, 'WM_IME_COMPOSITION'#10, False);

      trapped^ := True;
      hImc := _ImmGetContext(DXUTGetHWND);
      if (0 <> hImc) then
      begin
        // Get the caret position in composition string
        if (lParam and GCS_CURSORPOS <> 0) then
        begin
          s_nCompCaret := _ImmGetCompositionStringW(hImc, GCS_CURSORPOS, nil, 0);
          if (s_nCompCaret < 0) then s_nCompCaret := 0; // On error, set caret to pos 0.
        end;

        // ResultStr must be processed before composition string.
        //
        // This is because for some IMEs, such as CHT, pressing Enter
        // to complete the composition sends WM_IME_COMPOSITION with both
        // GCS_RESULTSTR and GCS_COMPSTR.  Retrieving the result string
        // gives the correct string, while retrieving the comp string
        // (GCS_COMPSTR) gives empty string.  GCS_RESULTSTR should be
        // handled first so that the application receives the string.  Then
        // GCS_COMPSTR can be handled to clear the comp string buffer.

        if (lParam and GCS_RESULTSTR <> 0) then
        begin
          DXUTTRACE(UnitName, $FFFF, 0, '  GCS_RESULTSTR'#10, False);
          lRet := _ImmGetCompositionStringW(hImc, GCS_RESULTSTR, @wszCompStr, SizeOf(wszCompStr));
          if (lRet > 0) then
          begin
            lRet:= lRet div SizeOf(WideChar);
            wszCompStr[lRet] := #0;  // Force terminate
            TruncateCompString(False, lstrlenW(wszCompStr));
            s_CompString.SetText(wszCompStr);
            SendCompString;
            ResetCompositionString;
          end;
        end;

        //
        // Reads in the composition string.
        //
        if (lParam and GCS_COMPSTR <> 0) then
        begin
          DXUTTRACE(UnitName, $FFFF, 0, '  GCS_COMPSTR'#10, False);
          //////////////////////////////////////////////////////
          // Retrieve the latest user-selected IME candidates
          lRet := _ImmGetCompositionStringW(hImc, GCS_COMPSTR, @wszCompStr, SizeOf(wszCompStr));
          if (lRet > 0) then
          begin
            lRet:= lRet div SizeOf(WideChar);  // Convert size in byte to size in char
            wszCompStr[lRet] := #0;  // Force terminate
            //
            // Remove the whole of the string
            //
            TruncateCompString(False, lstrlenW(wszCompStr));

            s_CompString.SetText(wszCompStr);

            // Older CHT IME uses composition string for reading string
            if (GetLanguage = LANG_CHT) and not (GetImeId <> 0) then
            begin
              if lstrlenW(s_CompString.Buffer) <> 0 then
              begin
                s_CandList.dwCount := 4;             // Maximum possible length for reading string is 4
                s_CandList.dwSelection := DWORD(-1); // don't select any candidate

                // Copy the reading string to the candidate list
                for i := 3 downto 0 do
                begin
                  if (i > lstrlenW(s_CompString.Buffer) - 1) then
                    s_CandList.awszCandidate[i][0] := #0  // Doesn't exist
                  else
                  begin
                    s_CandList.awszCandidate[i][0] := s_CompString[i];
                    s_CandList.awszCandidate[i][1] := #0;
                  end;
                end;
                s_CandList.dwPageSize := MAX_CANDLIST;
                // Clear comp string after we are done copying
                ZeroMemory(s_CompString.Buffer, 4 * SizeOf(WideChar));
                s_bShowReadingWindow := True;
                GetReadingWindowOrientation(0);
                if (s_bHorizontalReading) then
                begin
                  s_CandList.nReadingError := -1;  // Clear error

                  // Create a string that consists of the current
                  // reading string.  Since horizontal reading window
                  // is used, we take advantage of this by rendering
                  // one string instead of several.
                  //
                  // Copy the reading string from the candidate list
                  // to the reading string buffer.
                  s_wszReadingString[0] := #0;
                  for i := 0 to s_CandList.dwCount - 1 do
                  begin
                    if (s_CandList.dwSelection = DWORD(i)) then
                      s_CandList.nReadingError := lstrlenW(s_wszReadingString);
                    StringCchCat(s_wszReadingString, 32, s_CandList.awszCandidate[i]);
                  end;
                end;
              end else
              begin
                s_CandList.dwCount := 0;
                s_bShowReadingWindow := False;
              end;
            end;

            if (s_bInsertOnType) then
            begin
              // Send composition string to the edit control
              SendCompString;
              // Restore the caret to the correct location.
              // It's at the end right now, so compute the number
              // of times left arrow should be pressed to
              // send it to the original position.
              nCount := lstrlenW(s_CompString.Buffer + s_nCompCaret);
              // Send left keystrokes
              for i := 0 to nCount - 1 do
                SendMessage(DXUTGetHWND, WM_KEYDOWN, VK_LEFT, 0);
              SendMessage(DXUTGetHWND, WM_KEYUP, VK_LEFT, 0);
            end;
          end;

          ResetCaretBlink;
        end;

        // Retrieve comp string attributes
        if (lParam and GCS_COMPATTR <> 0) then
        begin
          lRet := _ImmGetCompositionStringW(hImc, GCS_COMPATTR, @s_abCompStringAttr, SizeOf(s_abCompStringAttr));
          if (lRet > 0) then s_abCompStringAttr[lRet] := 0;  // ??? Is this needed for attributes?
        end;

        // Retrieve clause information
        if (lParam and GCS_COMPCLAUSE <> 0) then
        begin
          lRet := _ImmGetCompositionStringW(hImc, GCS_COMPCLAUSE, @s_adwCompStringClause, SizeOf(s_adwCompStringClause));
          s_adwCompStringClause[lRet div SizeOf(DWORD)] := 0;  // Terminate
        end;

        _ImmReleaseContext(DXUTGetHWND, hImc);
      end;
    end; {:WM_IME_COMPOSITION:}

    WM_IME_ENDCOMPOSITION:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, 'WM_IME_ENDCOMPOSITION'#10, False);
      TruncateCompString;
      ResetCompositionString;
      // We can show the edit control's caret again.
      s_bHideCaret := False;
      // Hide reading window
      s_bShowReadingWindow := False;
    end;

    WM_IME_NOTIFY:
    begin
      DXUTTRACE(UnitName, $FFFF, 0, PWideChar(WideString('WM_IME_NOTIFY ') + IntToStr(wParam) + #10), False);

      case wParam of
        IMN_SETCONVERSIONMODE,
        IMN_SETOPENSTATUS:
        begin
          if (wParam = IMN_SETCONVERSIONMODE)
          then DXUTTRACE(UnitName, $FFFF, 0, '  IMN_SETCONVERSIONMODE'#10, False)
          else DXUTTRACE(UnitName, $FFFF, 0, '  IMN_SETOPENSTATUS'#10, False);
          CheckToggleState;
        end;

        IMN_OPENCANDIDATE,
        IMN_CHANGECANDIDATE:
        begin
          if (wParam = IMN_CHANGECANDIDATE)
          then DXUTTRACE(UnitName, $FFFF, 0, '  IMN_CHANGECANDIDATE'#10, False)
          else DXUTTRACE(UnitName, $FFFF, 0, '  IMN_OPENCANDIDATE'#10, False);

          s_CandList.bShowWindow := True;
          trapped^ := True;
          hImc := _ImmGetContext(DXUTGetHWND);
          if (hImc <> 0) then
          begin
            lpCandList := nil;

            s_bShowReadingWindow := False;
            // Retrieve the candidate list
            dwLenRequired := _ImmGetCandidateListW(hImc, 0, nil, 0);
            if (dwLenRequired <> 0) then
            begin
              lpCandList := PCandidateList(HeapAlloc(GetProcessHeap, 0, dwLenRequired));
              {dwLenRequired := }_ImmGetCandidateListW(hImc, 0, lpCandList, dwLenRequired);
            end;

            if (lpCandList <> nil) then
            begin
              // Update candidate list data
              s_CandList.dwSelection := lpCandList.dwSelection;
              s_CandList.dwCount := lpCandList.dwCount;

              // nPageTopIndex := 0; // - never used
              s_CandList.dwPageSize := DWORD(Min(lpCandList.dwPageSize, MAX_CANDLIST));
              if (GetPrimaryLanguage = LANG_JAPANESE) then
              begin
                // Japanese IME organizes its candidate list a little
                // differently from the other IMEs.
                nPageTopIndex := (s_CandList.dwSelection div s_CandList.dwPageSize) * s_CandList.dwPageSize;
              end
              else
                nPageTopIndex := lpCandList.dwPageStart;

              // Make selection index relative to first entry of page
              s_CandList.dwSelection := IfThen((GetLanguage = LANG_CHS) and (GetImeId = 0),
                                          -1, Integer(s_CandList.dwSelection) - nPageTopIndex);

              ZeroMemory(@s_CandList.awszCandidate, SizeOf(s_CandList.awszCandidate));
              {for i := nPageTopIndex, j := 0;
                  (DWORD)i < lpCandList->dwCount && j < s_CandList.dwPageSize;
                  i++, j++ )}
              i := nPageTopIndex; j := 0;
              while (i < Integer(lpCandList.dwCount)) and (j < Integer(s_CandList.dwPageSize)) do
              begin
                // Initialize the candidate list strings
                pwsz := s_CandList.awszCandidate[j];
                // For every candidate string entry,
                // write [index] + Space + [String] if vertical,
                // write [index] + [String] + Space if horizontal.
                pwsz^:= WideChar(Ord('0') + ( (j + 1) mod 10)); Inc(pwsz); // Index displayed is 1 based

                if (s_bVerticalCand) then
                begin
                  pwsz^ := ' ';
                  Inc(pwsz);
                end;

                pwszNewCand := PWideChar(PChar{PByte}(lpCandList) + lpCandList.dwOffset[i]);
                while (pwszNewCand^ <> #0) do
                begin
                  pwsz^ := pwszNewCand^;
                  Inc(pwsz);
                  Inc(pwszNewCand);
                end;

                if (not s_bVerticalCand) then
                begin
                  pwsz^ := ' ';
                  Inc(pwsz);
                end;
                pwsz^ := #0;  // Terminate

                Inc(i); Inc(j);
              end;

              // Make dwCount in s_CandList be number of valid entries in the page.
              s_CandList.dwCount := lpCandList.dwCount - lpCandList.dwPageStart;
              if (s_CandList.dwCount > lpCandList.dwPageSize)
              then s_CandList.dwCount := lpCandList.dwPageSize;

              HeapFree(GetProcessHeap, 0, lpCandList);
              _ImmReleaseContext(DXUTGetHWND, hImc);

              // Korean and old Chinese IME can't have selection.
              // User must use the number hotkey or Enter to select
              // a candidate.
              if (GetPrimaryLanguage = LANG_KOREAN) or
                 (GetLanguage = LANG_CHT) and (GetImeId = 0) then
              begin
                s_CandList.dwSelection := DWORD(-1);
              end;

              // Initialize s_CandList.HoriCand if we have a
              // horizontal candidate window.
              if (not s_bVerticalCand) then
              begin
                ZeroMemory(@wszCand, SizeOf(wszCand));

                s_CandList.nFirstSelected := 0;
                s_CandList.nHoriSelectedLen := 0;
                for i := 0 to MAX_CANDLIST - 1 do
                begin
                  if (s_CandList.awszCandidate[i][0] = #0) then Break;

                  StringCchFormat(wszEntry, 32, '%s ', [s_CandList.awszCandidate[i]]);
                  // If this is the selected entry, mark its char position.
                  if (Integer(s_CandList.dwSelection) = i) then
                  begin
                    s_CandList.nFirstSelected := lstrlenW(wszCand);
                    s_CandList.nHoriSelectedLen := lstrlenW(wszEntry) - 1;  // Minus space
                  end;
                  StringCchCat(wszCand, 256, wszEntry);
                end;
                wszCand[lstrlenW(wszCand) - 1] := #0;  // Remove the last space
                s_CandList.HoriCand.SetText(wszCand);
              end;
            end;
          end;
        end;

        IMN_CLOSECANDIDATE:
        begin
          DXUTTRACE(UnitName, $FFFF, 0, '  IMN_CLOSECANDIDATE'#10, False);
          s_CandList.bShowWindow := False;
          if not s_bShowReadingWindow then
          begin
            s_CandList.dwCount := 0;
            ZeroMemory(@s_CandList.awszCandidate, SizeOf(s_CandList.awszCandidate));
          end;
          trapped^ := True;
        end;

        IMN_PRIVATE:
        begin
          DXUTTRACE(UnitName, $FFFF, 0, '  IMN_PRIVATE'#10, False);
          if not s_CandList.bShowWindow then GetPrivateReadingString;

          // Trap some messages to hide reading window
          dwId := GetImeId;
          case dwId of
            IMEID_CHT_VER42,
            IMEID_CHT_VER43,
            IMEID_CHT_VER44,
            IMEID_CHS_VER41,
            IMEID_CHS_VER42:
              if (lParam = 1) or (lParam = 2) then
              begin
                trapped^ := True;
              end;

            IMEID_CHT_VER50,
            IMEID_CHT_VER51,
            IMEID_CHT_VER52,
            IMEID_CHT_VER60,
            IMEID_CHS_VER53:
              if (lParam = 16) or (lParam = 17) or (lParam = 26) or (lParam = 27) or (lParam = 28) then
              begin
                trapped^ := True;
              end;
          end;
        end;

      else {case}
          trapped^ := True;
      end;
    end;

    // fix for #15386 - When Text Service Framework is installed in Win2K, Alt+Shift and Ctrl+Shift combination (to switch
    // input locale / keyboard layout) doesn't send WM_KEYUP message for the key that is released first. We need to check
    // if these keys are actually up whenever we receive key up message for other keys.
    WM_KEYUP,
    WM_SYSKEYUP,
    WM_KEYDOWN,
    WM_SYSKEYDOWN:
    begin
      if (uMsg = WM_KEYUP) or (uMsg = WM_SYSKEYUP) then
      begin
        // if ( !( lAlt & 0x80000000 ) && wParam != VK_MENU && ( GetAsyncKeyState( VK_MENU ) & 0x8000 ) == 0 )
        if (lAlt and $80000000 = 0) and (wParam <> VK_MENU) and (GetAsyncKeyState(VK_MENU) and $8000 = 0) then
        begin
          PostMessageW(GetFocus, WM_KEYUP, VK_MENU, (lAlt and $01ff0000) or $C0000001);
        end
        // else if ( !( lCtrl & 0x80000000 ) && wParam != VK_CONTROL && ( GetAsyncKeyState( VK_CONTROL ) & 0x8000 ) == 0 )
        else if (lCtrl and $80000000 = 0) and (wParam <> VK_CONTROL) and (GetAsyncKeyState(VK_CONTROL) and $8000 = 0) then
        begin
          PostMessageW(GetFocus, WM_KEYUP, VK_CONTROL, (lCtrl and $01ff0000 ) or $C0000001);
        end
        // else if ( !( lShift & 0x80000000 ) && wParam != VK_SHIFT && ( GetAsyncKeyState( VK_SHIFT ) & 0x8000 ) == 0 )
        else if (lShift and $80000000 = 0) and (wParam <> VK_SHIFT) and (GetAsyncKeyState(VK_SHIFT) and $8000 = 0) then
        begin
          PostMessageW(GetFocus, WM_KEYUP, VK_SHIFT, (lShift and $01ff0000) or $C0000001);
        end;
      end;
    // fall through WM_KEYDOWN / WM_SYSKEYDOWN
   {WM_KEYDOWN, WM_SYSKEYDOWN:}
      case wParam of
        VK_MENU:    lAlt := lParam;
        VK_SHIFT:   lShift := lParam;
        VK_CONTROL: lCtrl := lParam;
      end;
      //break;
      // Fall through to default case
      // so we invoke the parent.
      Result:= inherited {CDXUTEditBox::}MsgProc(uMsg, wParam, lParam);
      Exit;
    end;

    else
      // Let the parent handle the message that we
      // don't handle.
      Result:= inherited {CDXUTEditBox::}MsgProc(uMsg, wParam, lParam);
      Exit;
  end; // case

  Result:= trapped^;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.RenderCandidateReadingWindow(
  pd3dDevice: IDirect3DDevice9; fElapsedTime: Single; bReading: Boolean);
var
  rc: TRect;
  nNumEntries: LongWord;
  TextColor, TextBkColor, SelTextColor, SelBkColor: TD3DColor;
  nX, nXFirst, nXComp: Integer;
  nWidthRequired: Integer;
  nHeightRequired: Integer;
  nSingleLineHeight: Integer;
  i: LongWord;
  bHasPosition: Boolean;
  nXCompTrail: Integer;
  nXLeft, nXRight: Integer;
begin
  nNumEntries := IfThen(bReading, 4, MAX_CANDLIST);
  m_Buffer.CPtoX(m_nCaret, False, nX);
  m_Buffer.CPtoX(m_nFirstVisible, False, nXFirst);

  if bReading then
  begin
    TextColor := m_ReadingColor;
    TextBkColor := m_ReadingWinColor;
    SelTextColor := m_ReadingSelColor;
    SelBkColor := m_ReadingSelBkColor;
  end else
  begin
    TextColor := m_CandidateColor;
    TextBkColor := m_CandidateWinColor;
    SelTextColor := m_CandidateSelColor;
    SelBkColor := m_CandidateSelBkColor;
  end;

  // For Japanese IME, align the window with the first target converted character.
  // For all other IMEs, align with the caret.  This is because the caret
  // does not move for Japanese IME.
  if (GetLanguage = LANG_CHT) and (GetImeId = 0) then nXComp := 0
  else
  if (GetPrimaryLanguage = LANG_JAPANESE) then
    s_CompString.CPtoX(s_nFirstTargetConv, False, nXComp)
  else
    s_CompString.CPtoX(s_nCompCaret, False, nXComp);

  // Compute the size of the candidate window
  nWidthRequired := 0;
  // nHeightRequired := 0; // - never used
  nSingleLineHeight := 0;

  if (s_bVerticalCand and not bReading) or
     (not s_bHorizontalReading and bReading) then
  begin
    // Vertical window
    for i := 0 to nNumEntries - 1 do
    begin
      if (s_CandList.awszCandidate[i][0] = #0) then Break;

      SetRect(rc, 0, 0, 0, 0);
      m_pDialog.CalcTextRect(s_CandList.awszCandidate[i], m_Elements[1], @rc);
      nWidthRequired := Max(nWidthRequired, rc.right - rc.left);
      nSingleLineHeight := Max(nSingleLineHeight, rc.bottom - rc.top);
    end;
    nHeightRequired := nSingleLineHeight * Integer(nNumEntries);
  end else
  begin
    // Horizontal window
    SetRect(rc, 0, 0, 0, 0);
    if (bReading) then
      m_pDialog.CalcTextRect(s_wszReadingString, m_Elements[1], @rc)
    else
      m_pDialog.CalcTextRect(s_CandList.HoriCand.Buffer, m_Elements[1], @rc);
    nWidthRequired := rc.right - rc.left;
    nHeightRequired := rc.bottom - rc.top;
    nSingleLineHeight := nHeightRequired;
  end;

  // Now that we have the dimension, calculate the location for the candidate window.
  // We attempt to fit the window in this order:
  // bottom, top, right, left.

  bHasPosition := False;

  // Bottom
  SetRect(rc, s_ptCompString.x + nXComp, s_ptCompString.y + m_rcText.bottom - m_rcText.top,
              s_ptCompString.x + nXComp + nWidthRequired, s_ptCompString.y + m_rcText.bottom - m_rcText.top + nHeightRequired);
  // if the right edge is cut off, move it left.
  if (rc.right > m_pDialog.Width) then
  begin
    Dec(rc.left, rc.right - m_pDialog.Width);
    rc.right := m_pDialog.Width;
  end;
  if (rc.bottom <= m_pDialog.Height) then bHasPosition := True;

  // Top
  if not bHasPosition then
  begin
    SetRect(rc, s_ptCompString.x + nXComp, s_ptCompString.y - nHeightRequired,
                s_ptCompString.x + nXComp + nWidthRequired, s_ptCompString.y);
    // if the right edge is cut off, move it left.
    if (rc.right > m_pDialog.Width) then
    begin
      Dec(rc.left, rc.right - m_pDialog.Width);
      rc.right := m_pDialog.Width;
    end;
    if (rc.top >= 0) then bHasPosition := True;
  end;

  // Right
  if not bHasPosition then
  begin
    s_CompString.CPtoX(s_nCompCaret, True, nXCompTrail);
    SetRect(rc, s_ptCompString.x + nXCompTrail, 0,
                s_ptCompString.x + nXCompTrail + nWidthRequired, nHeightRequired);
    if (rc.right <= m_pDialog.Width) then bHasPosition := True;
  end;

  // Left
  if not bHasPosition then
  begin
    SetRect(rc, s_ptCompString.x + nXComp - nWidthRequired, 0,
                s_ptCompString.x + nXComp, nHeightRequired);
    if (rc.right >= 0) then bHasPosition := True;
  end;

  if not bHasPosition then
  begin
    // The dialog is too small for the candidate window.
    // Fall back to render at 0, 0.  Some part of the window
    // will be cut off.
    rc.left := 0;
    rc.right := nWidthRequired;
  end;

  // If we are rendering the candidate window, save the position
  // so that mouse clicks are checked properly.
  if not bReading then s_CandList.rcCandidate := rc;

  // Render the elements
  m_pDialog.DrawRect(rc, TextBkColor);
  if (s_bVerticalCand and not bReading) or
     (not s_bHorizontalReading and bReading) then
  begin
    // Vertical candidate window
    for i := 0 to nNumEntries - 1 do
    begin
      // Here we are rendering one line at a time
      rc.bottom := rc.top + nSingleLineHeight;
      // Use a different color for the selected string
      if (s_CandList.dwSelection = i) then
      begin
        m_pDialog.DrawRect(rc, SelBkColor);
        m_Elements[1].FontColor.Current := D3DXColorFromDWord(SelTextColor);
      end else
        m_Elements[1].FontColor.Current := D3DXColorFromDWord(TextColor);

      m_pDialog.DrawText(s_CandList.awszCandidate[i], m_Elements[1], rc);

      Inc(rc.top, nSingleLineHeight);
    end;
  end else
  begin
    // Horizontal candidate window
    m_Elements[1].FontColor.Current := D3DXColorFromDWord(TextColor);
    if bReading then
      m_pDialog.DrawText(s_wszReadingString, m_Elements[1], rc)
    else
      m_pDialog.DrawText(s_CandList.HoriCand.Buffer, m_Elements[1], rc);

    // Render the selected entry differently
    if not bReading then
    begin
      s_CandList.HoriCand.CPtoX(s_CandList.nFirstSelected, False, nXLeft);
      s_CandList.HoriCand.CPtoX(s_CandList.nFirstSelected + s_CandList.nHoriSelectedLen, False, nXRight);

      rc.right := rc.left + nXRight;
      Inc(rc.left, nXLeft);
      m_pDialog.DrawRect(rc, SelBkColor);
      m_Elements[1].FontColor.Current := D3DXColorFromDWord(SelTextColor);
      m_pDialog.DrawText(s_CandList.HoriCand.Buffer + s_CandList.nFirstSelected,
                         m_Elements[1], rc, False, s_CandList.nHoriSelectedLen);
    end;
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.RenderComposition(pd3dDevice: IDirect3DDevice9;
  fElapsedTime: Single);
var
  rcCaret, rcFirst: TRect;
  nX, nXFirst: Integer;
  pElement: CDXUTElement;
  rc: TRect;
  TextColor: TD3DColor;
  pwszComp: PWideChar;
  nCharLeft: Integer;
  nLastInLine: Integer;
  bTrail: LongBool;
  nNumCharToDraw: Integer;
  nCharFirst: Integer;
  pAttr: PByte;
  pcComp: PWideChar;
  bkColor: TD3DColor;
  nXLeft, nXRight: Integer;
  rcTarget: TRect;
begin
  rcCaret := Rect(0, 0, 0, 0);
  m_Buffer.CPtoX(m_nCaret, False, nX);
  m_Buffer.CPtoX(m_nFirstVisible, False, nXFirst);
  pElement := m_Elements[1];

  // Get the required width
  rc := Rect(m_rcText.left + nX - nXFirst, m_rcText.top,
             m_rcText.left + nX - nXFirst, m_rcText.bottom);
  m_pDialog.CalcTextRect(s_CompString.Buffer, pElement, @rc);

  // If the composition string is too long to fit within
  // the text area, move it to below the current line.
  // This matches the behavior of the default IME.
  if (rc.right > m_rcText.right) then
    OffsetRect(rc, m_rcText.left - rc.left, rc.bottom - rc.top);

  // Save the rectangle position for processing highlighted text.
  rcFirst := rc;

  // Update s_ptCompString for RenderCandidateReadingWindow().
  s_ptCompString.x := rc.left; s_ptCompString.y := rc.top;

  TextColor := m_CompColor;
  // Render the window and string.
  // If the string is too long, we must wrap the line.
  pElement.FontColor.Current := D3DXColorFromDWord(TextColor);
  pwszComp := s_CompString.Buffer;
  nCharLeft := s_CompString.TextSize;
  while True do
  begin
    // Find the last character that can be drawn on the same line.
    s_CompString.XtoCP(m_rcText.right - rc.left, nLastInLine, bTrail);
    nNumCharToDraw := Min(nCharLeft, nLastInLine);
    m_pDialog.CalcTextRect(pwszComp, pElement, @rc, nNumCharToDraw);

    // Draw the background
    // For Korean IME, blink the composition window background as if it
    // is a cursor.
    if (GetPrimaryLanguage = LANG_KOREAN) then
    begin
      if m_bCaretOn then
      begin
        m_pDialog.DrawRect(rc, m_CompWinColor);
      end else
      begin
        // Not drawing composition string background. We
        // use the editbox's text color for composition
        // string text.
        TextColor := m_Elements[0].FontColor.States[DXUT_STATE_NORMAL];
      end;
    end else
    begin
      // Non-Korean IME. Always draw composition background.
      m_pDialog.DrawRect(rc, m_CompWinColor);
    end;

    // Draw the text
    pElement.FontColor.Current := D3DXColorFromDWord(TextColor);
    m_pDialog.DrawText(pwszComp, pElement, rc, False, nNumCharToDraw);

    // Advance pointer and counter
    Dec(nCharLeft, nNumCharToDraw);
    Inc(pwszComp, nNumCharToDraw);
    if (nCharLeft <= 0) then Break;

    // Advance rectangle coordinates to beginning of next line
    OffsetRect(rc, m_rcText.left - rc.left, rc.bottom - rc.top);
  end;

  // Load the rect for the first line again.
  rc := rcFirst;

  // Inspect each character in the comp string.
  // For target-converted and target-non-converted characters,
  // we display a different background color so they appear highlighted.
  //nCharFirst := 0;
  nXFirst := 0;
  s_nFirstTargetConv := -1;
//  for pcComp := s_CompString.GetBuffer, pAttr := s_abCompStringAttr;
//        *pcComp != L'\0'; ++pcComp, ++pAttr )
  pcComp := s_CompString.Buffer;
  pAttr := @s_abCompStringAttr;
  bkColor:= 0;
  while (pcComp^ <> #0) do
  begin
    // Render a different background for this character
    s_CompString.CPtoX(Integer(pcComp - s_CompString.Buffer), False, nXLeft);
    s_CompString.CPtoX(Integer(pcComp - s_CompString.Buffer), True, nXRight);

    // Check if this character is off the right edge and should
    // be wrapped to the next line.
    if (nXRight - nXFirst > m_rcText.right - rc.left) then
    begin
      // Advance rectangle coordinates to beginning of next line
      OffsetRect(rc, m_rcText.left - rc.left, rc.bottom - rc.top);

      // Update the line's first character information
      nCharFirst := Integer(pcComp - s_CompString.Buffer);
      s_CompString.CPtoX(nCharFirst, False, nXFirst);
    end;

    // If the caret is on this character, save the coordinates
    // for drawing the caret later.
    if (s_nCompCaret = Integer(pcComp - s_CompString.Buffer)) then
    begin
      rcCaret := rc;
      Inc(rcCaret.left, nXLeft - nXFirst - 1);
      rcCaret.right := rcCaret.left + 2;
    end;

    // Set up color based on the character attribute
    if (pAttr^ = ATTR_TARGET_CONVERTED) then
    begin
      pElement.FontColor.Current := D3DXColorFromDWord(m_CompTargetColor);
      bkColor := m_CompTargetBkColor;
    end else
    if (pAttr^ = ATTR_TARGET_NOTCONVERTED) then
    begin
      pElement.FontColor.Current := D3DXColorFromDWord(m_CompTargetNonColor);
      bkColor := m_CompTargetNonBkColor;
    end else
    begin
      Inc(pcComp); Inc(pAttr);
      Continue;
    end;

    rcTarget := Rect(rc.left + nXLeft - nXFirst, rc.top, rc.left + nXRight - nXFirst, rc.bottom);
    m_pDialog.DrawRect(rcTarget, bkColor);
    m_pDialog.DrawText(pcComp, pElement, rcTarget, False, 1);

    // Record the first target converted character's index
    if (-1 = s_nFirstTargetConv) then
      s_nFirstTargetConv := Integer(pAttr) - Integer(@s_abCompStringAttr);

    Inc(pcComp); Inc(pAttr);
  end;

  // Render the composition caret
  if m_bCaretOn then
  begin
    // If the caret is at the very end, its position would not have
    // been computed in the above loop.  We compute it here.
    if (s_nCompCaret = s_CompString.TextSize) then
    begin
      s_CompString.CPtoX(s_nCompCaret, False, nX);
      rcCaret := rc;
      Inc(rcCaret.left, nX - nXFirst - 1);
      rcCaret.right := rcCaret.left + 2;
    end;

    m_pDialog.DrawRect(rcCaret, m_CompCaretColor);
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.RenderIndicator(pd3dDevice: IDirect3DDevice9;
  fElapsedTime: Single);
var
  pElement: CDXUTElement;
  rc: TRect;
  rcCalc: TRect;
  pwszIndicator: PWideChar;
begin
  pElement := m_Elements[9];
  pElement.TextureColor.Blend(DXUT_STATE_NORMAL, fElapsedTime);

  m_pDialog.DrawSprite(pElement, m_rcIndicator);
  rc := m_rcIndicator;
  InflateRect(rc, -m_nSpacing, -m_nSpacing);
  if (s_ImeState = IMEUI_STATE_ON) and s_bEnableImeSystem
    then pElement.FontColor.Current := D3DXColorFromDWord(m_IndicatorImeColor)
    else pElement.FontColor.Current := D3DXColorFromDWord(m_IndicatorEngColor);
  rcCalc := Rect(0, 0, 0, 0);
  // If IME system is off, draw English indicator.
  if s_bEnableImeSystem
  then pwszIndicator := s_wszCurrIndicator
  else pwszIndicator := s_aszIndicator[Low(TIndicatorEnum)];

  m_pDialog.CalcTextRect(pwszIndicator, pElement, @rcCalc);
  m_pDialog.DrawText(pwszIndicator, pElement, rc);
end;


//--------------------------------------------------------------------------------------
procedure CDXUTIMEEditBox.Render(pd3dDevice: IDirect3DDevice9; fElapsedTime: Single);
var
  i: TIndicatorEnum;
  rc: TRect;
  pElement: CDXUTElement;
begin
  if not m_bVisible then Exit;

  // If we have not computed the indicator symbol width,
  // do it.
  if (m_nIndicatorWidth = 0) then
  begin
    for i := INDICATOR_NON_IME to INDICATOR_JAPANESE do
    begin
      rc := Rect(0, 0, 0, 0);
      m_pDialog.CalcTextRect(@s_aszIndicator[i], m_Elements[9], @rc);
      m_nIndicatorWidth := Max(m_nIndicatorWidth, rc.right - rc.left);
    end;
    // Update the rectangles now that we have the indicator's width
    UpdateRects;
  end;

  // Let the parent render first (edit control)
  inherited {CDXUTEditBox::}Render(pd3dDevice, fElapsedTime);

  pElement := GetElement(1);
  if (pElement <> nil) then
  begin
    s_CompString.FontNode := m_pDialog.GetFont(pElement.iFont);
    s_CandList.HoriCand.FontNode := m_pDialog.GetFont(pElement.iFont);
  end;

  //
  // Now render the IME elements
  //
  if m_bHasFocus then
  begin
    // Render the input locale indicator
    RenderIndicator(pd3dDevice, fElapsedTime);

    // Display the composition string.
    // This method should also update s_ptCompString
    // for RenderCandidateReadingWindow.
    RenderComposition(pd3dDevice, fElapsedTime);

    // Display the reading/candidate window. RenderCandidateReadingWindow()
    // uses s_ptCompString to position itself.  s_ptCompString must have
    // been filled in by RenderComposition().
    if s_bShowReadingWindow then
      // Reading window
      RenderCandidateReadingWindow(pd3dDevice, fElapsedTime, True)
    else
    if s_CandList.bShowWindow then
      // Candidate list window
      RenderCandidateReadingWindow(pd3dDevice, fElapsedTime, False);
  end;
end;


//--------------------------------------------------------------------------------------
class procedure CDXUTIMEEditBox.Initialize;
var
  temp: FARPROC;
begin
  if (s_hDllImm32 <> 0) then Exit; // Only need to do once
  
  s_CompString.SetBufferSize(MAX_COMPSTRING_SIZE);

  s_hDllImm32 := LoadLibrary(IMM32_DLLNAME);
  if (s_hDllImm32 <> 0) then
  begin
    temp:= GetProcAddress(s_hDllImm32, 'ImmLockIMC'); if (temp<>nil) then _ImmLockIMC:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmUnlockIMC'); if (temp<>nil) then _ImmUnlockIMC:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmLockIMCC'); if (temp<>nil) then _ImmLockIMCC:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmUnlockIMCC'); if (temp<>nil) then _ImmUnlockIMCC:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmDisableTextFrameService'); if (temp<>nil) then _ImmDisableTextFrameService:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetCompositionStringW'); if (temp<>nil) then _ImmGetCompositionStringW:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetCandidateListW'); if (temp<>nil) then _ImmGetCandidateListW:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetContext'); if (temp<>nil) then _ImmGetContext:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmReleaseContext'); if (temp<>nil) then _ImmReleaseContext:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmAssociateContext'); if (temp<>nil) then _ImmAssociateContext:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetOpenStatus'); if (temp<>nil) then _ImmGetOpenStatus:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmSetOpenStatus'); if (temp<>nil) then _ImmSetOpenStatus:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetConversionStatus'); if (temp<>nil) then _ImmGetConversionStatus:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetDefaultIMEWnd'); if (temp<>nil) then _ImmGetDefaultIMEWnd:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetIMEFileNameA'); if (temp<>nil) then _ImmGetIMEFileNameA:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmGetVirtualKey'); if (temp<>nil) then _ImmGetVirtualKey:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmNotifyIME'); if (temp<>nil) then _ImmNotifyIME:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmSetConversionStatus'); if (temp<>nil) then _ImmSetConversionStatus:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmSimulateHotKey'); if (temp<>nil) then _ImmSimulateHotKey:= temp;
    temp:= GetProcAddress(s_hDllImm32, 'ImmIsIME'); if (temp<>nil) then _ImmIsIME:= temp;
  end;

  s_hDllVer := LoadLibrary(VER_DLLNAME);
  if (s_hDllVer <> 0) then
  begin
    temp:= GetProcAddress(s_hDllVer, 'VerQueryValueA'); if (temp<>nil) then _VerQueryValueA:= temp;
    temp:= GetProcAddress(s_hDllVer, 'GetFileVersionInfoA'); if (temp<>nil) then _GetFileVersionInfoA:= temp;
    temp:= GetProcAddress(s_hDllVer, 'GetFileVersionInfoSizeA'); if (temp<>nil) then _GetFileVersionInfoSizeA:= temp;
  end;
end;


//--------------------------------------------------------------------------------------
class procedure CDXUTIMEEditBox.Uninitialize;
begin
  if (s_hDllImm32 <> 0) then
  begin
    _ImmLockIMC := Dummy_ImmLockIMC;
    _ImmUnlockIMC := Dummy_ImmUnlockIMC;
    _ImmLockIMCC := Dummy_ImmLockIMCC;
    _ImmUnlockIMCC := Dummy_ImmUnlockIMCC;
    _ImmDisableTextFrameService := Dummy_ImmDisableTextFrameService;
    _ImmGetCompositionStringW := Dummy_ImmGetCompositionStringW;
    _ImmGetCandidateListW := Dummy_ImmGetCandidateListW;
    _ImmGetContext := Dummy_ImmGetContext;
    _ImmReleaseContext := Dummy_ImmReleaseContext;
    _ImmAssociateContext := Dummy_ImmAssociateContext;
    _ImmGetOpenStatus := Dummy_ImmGetOpenStatus;
    _ImmSetOpenStatus := Dummy_ImmSetOpenStatus;
    _ImmGetConversionStatus := Dummy_ImmGetConversionStatus;
    _ImmGetDefaultIMEWnd := Dummy_ImmGetDefaultIMEWnd;
    _ImmGetIMEFileNameA := Dummy_ImmGetIMEFileNameA;
    _ImmGetVirtualKey := Dummy_ImmGetVirtualKey;
    _ImmNotifyIME := Dummy_ImmNotifyIME;
    _ImmSetConversionStatus := Dummy_ImmSetConversionStatus;
    _ImmSimulateHotKey := Dummy_ImmSimulateHotKey;
    _ImmIsIME := Dummy_ImmIsIME;

    FreeLibrary(s_hDllImm32);
    s_hDllImm32 := 0;
  end;

  if (s_hDllIme <> 0) then
  begin
    _GetReadingString := Dummy_GetReadingString;
    _ShowReadingWindow := Dummy_ShowReadingWindow;

    FreeLibrary(s_hDllIme);
    s_hDllIme := 0;
  end;

  if (s_hDllVer <> 0) then
  begin
    _VerQueryValueA := Dummy_VerQueryValueA;
    _GetFileVersionInfoA := Dummy_GetFileVersionInfoA;
    _GetFileVersionInfoSizeA := Dummy_GetFileVersionInfoSizeA;

    FreeLibrary(s_hDllVer);
    s_hDllVer := 0;
  end;
end;

class function CDXUTIMEEditBox.GetLanguage: Word;
begin
  Result:= LOWORD(s_hklCurrent);
end;

class function CDXUTIMEEditBox.GetPrimaryLanguage: Word;
begin
  Result:= PRIMARYLANGID(LOWORD(s_hklCurrent));
end;

class function CDXUTIMEEditBox.GetSubLanguage: Word;
begin
  Result:= SUBLANGID(LOWORD(s_hklCurrent));
end;


initialization
  {$IFDEF FPC}
  s_wszCurrIndicator:= @s_aszIndicator[Low(TIndicatorEnum)]; // Points to an indicator string that corresponds to current input locale
  {$ENDIF}
  s_CompString := CUniBuffer.Create(0); // Buffer to hold the composition string (we fix its length)
  s_CandList.HoriCand := CUniBuffer.Create;
finalization
  FreeAndNil(s_CandList.HoriCand);
  FreeAndNil(s_CompString);
end.

