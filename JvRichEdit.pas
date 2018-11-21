{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvRichEd.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 1997, 1998 Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 2001,2002 SGB Software
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s):
  Polaris Software
  Sébastien Buysse [sbuysse att buypin dott com] (original code in JvRichEdit.pas)
  Michael Beck [mbeck att bigfoot dott com] (contributor to JvRichEdit.pas)
  Roman Kovbasiouk [roko att users dott sourceforge dott net] (merging JvRichEdit.pas)
  Remko Bonte [remkobonte att myrealbox dott com] (insert image procedures, MS Text converters)
  Jacob Boerema [jgboerema att hotmail dott com] (indentation style, zoom, tab styles)

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

unit JvRichEdit;

{$I jvcl.inc}
{$I windowsonly.inc}

{$RANGECHECKS OFF}

interface

{$HPPEMIT '#define CHARFORMAT2A Richedit::CHARFORMAT2A'}

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, ActiveX, ComObj, CommCtrl, Messages, SysUtils, Classes, Controls,
  OleCtnrs,
  Forms, Graphics, StdCtrls, Dialogs, RichEdit, Menus, ComCtrls, SyncObjs,
  JvExStdCtrls, JvTypes;

type
  TJvCustomRichEdit = class;

  TJvAttributeType = (atDefaultText, atSelected, atWord);
  TJvConsistentAttribute = (caBold, caColor, caFace, caItalic, caSize,
    caStrikeOut, caUnderline, caProtected, caOffset, caHidden, caCharset,
    caLink, caBackColor, caDisabled, caWeight, caSubscript, caRevAuthor);
  TJvConsistentAttributes = set of TJvConsistentAttribute;
  TSubscriptStyle = (ssNone, ssSubscript, ssSuperscript);
  TUnderlineType = (utNone, utSolid, utWord, utDouble, utDotted, utDash,
    utDashDot, utDashDotDot, utWave, utThick);
  TUnderlineColor = (ucBlack, ucBlue, ucAqua, ucLime, ucFuchsia, ucRed,
    ucYellow, ucWhite, ucNavy, ucTeal, ucGreen, ucPurple, ucMaroon, ucOlive,
    ucGray, ucSilver);

  TJvTextAttributes = class(TPersistent)
  private
    FRichEdit: TJvCustomRichEdit;
    FType: TJvAttributeType;
    procedure AssignFont(Font: TFont);
    procedure GetAttributes(var Format: TCharFormat2);
    procedure SetAttributes(var Format: RichEdit.TCharFormat2);
    function GetAttribute(const Flag: Integer): Boolean;
    function GetBackColor: TColor;
    function GetCharset: TFontCharset;
    function GetColor: TColor;
    function GetConsistentAttributes: TJvConsistentAttributes;
    function GetDisabled: Boolean;
    function GetHeight: Integer;
    function GetHidden: Boolean;
    function GetLink: Boolean;
    function GetName: TFontName;
    function GetOffset: Integer;
    function GetPitch: TFontPitch;
    function GetProtected: Boolean;
    function GetRevAuthorIndex: Byte;
    function GetSize: Integer;
    function GetStyle: TFontStyles;
    function GetSubscriptStyle: TSubscriptStyle;
    function GetUnderlineColor: TUnderlineColor;
    function GetUnderlineType: TUnderlineType;
    procedure SetAttribute(const Flag: Integer; const Value: Boolean);
    procedure SetBackColor(Value: TColor);
    procedure SetCharset(Value: TFontCharset);
    procedure SetColor(Value: TColor);
    procedure SetDisabled(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetHidden(Value: Boolean);
    procedure SetLink(Value: Boolean);
    procedure SetName(Value: TFontName);
    procedure SetOffset(Value: Integer);
    procedure SetPitch(Value: TFontPitch);
    procedure SetProtected(Value: Boolean);
    procedure SetRevAuthorIndex(Value: Byte);
    procedure SetSize(Value: Integer);
    procedure SetStyle(Value: TFontStyles);
    procedure SetSubscriptStyle(Value: TSubscriptStyle);
    procedure SetUnderlineColor(const Value: TUnderlineColor);
    procedure SetUnderlineType(Value: TUnderlineType);
  protected
    procedure InitFormat(var Format: RichEdit.TCharFormat2);
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TJvCustomRichEdit; AttributeType: TJvAttributeType);
    procedure Assign(Source: TPersistent); override;
    property BackColor: TColor read GetBackColor write SetBackColor;
    property Charset: TFontCharset read GetCharset write SetCharset;
    property Color: TColor read GetColor write SetColor;
    property ConsistentAttributes: TJvConsistentAttributes read GetConsistentAttributes;
    property Disabled: Boolean read GetDisabled write SetDisabled;
    property Height: Integer read GetHeight write SetHeight;
    property Hidden: Boolean read GetHidden write SetHidden;
    property Link: Boolean read GetLink write SetLink;
    property Name: TFontName read GetName write SetName;
    property Offset: Integer read GetOffset write SetOffset;
    property Pitch: TFontPitch read GetPitch write SetPitch;
    property Protected: Boolean read GetProtected write SetProtected;
    property RevAuthorIndex: Byte read GetRevAuthorIndex write SetRevAuthorIndex;
    property Size: Integer read GetSize write SetSize;
    property Style: TFontStyles read GetStyle write SetStyle;
    property SubscriptStyle: TSubscriptStyle read GetSubscriptStyle write SetSubscriptStyle;
    property UnderlineColor: TUnderlineColor read GetUnderlineColor write SetUnderlineColor;
    property UnderlineType: TUnderlineType read GetUnderlineType write SetUnderlineType;
    property Bold: Boolean index CFE_BOLD read GetAttribute write SetAttribute;
    property Italic: Boolean index CFE_ITALIC read GetAttribute write SetAttribute;
    property Underline: Boolean index CFE_UNDERLINE read GetAttribute write SetAttribute;
    property StrikeOut: Boolean index CFE_STRIKEOUT read GetAttribute write SetAttribute;
  end;

  TJvNumbering = (nsNone, nsBullet, nsArabicNumbers, nsLoCaseLetter,
    nsUpCaseLetter, nsLoCaseRoman, nsUpCaseRoman);
  TJvNumberingStyle = (nsParenthesis, nsPeriod, nsEnclosed, nsSimple);
  TParaAlignment = (paLeftJustify, paRightJustify, paCenter, paJustify);
  TLineSpacingRule = (lsSingle, lsOneAndHalf, lsDouble, lsSpecifiedOrMore,
    lsSpecified, lsMultiple);
  THeadingStyle = 0..9;
  TParaTableStyle = (tsNone, tsTableRow, tsTableCellEnd, tsTableCell);

  TJvIndentationStyle = (isRichEdit, isOffice); // added by J.G. Boerema
  // TJvIndentationStyle: default is isRichEdit
  // - isRichEdit: LefIndent relative to FirstIndent
  // - isOffice: FirstIndent relative to LeftIndent (like MsWord and WordPad)
  // For example when FirstIndent=2 and LeftIndent=1 the effect is:
  // isRichEdit: first line starts at 2 and following lines at 3
  // isOffice: first line starts at 3 and following lines at 1

  //  From Msdn PARAFORMAT info:
{
   Rich Edit 2.0: For compatibility with TOM interfaces, you can use the eight
   high-order bits to store additional information about each tab stop.

   Bits 24-27 can specify one of the following values to indicate the tab alignment.
   These bits do not affect the rich edit control display for versions earlier
   than Rich Edit 3.0. [Note J.G.Boerema: This information is incorrect! At
   least, my version of Rich Edit 3 shows all tabs as ordinary tabs.]
   0    Ordinary tab
   1    Center tab
   2    Right-aligned tab
   3    Decimal tab
   4    Word bar tab (vertical bar)

   Bits 28-31 can specify one of the following values to indicate the type of tab leader.
   These bits do not affect the rich edit control display.
   0    No leader
   1    Dotted leader
   2    Dashed leader
   3    Underlined leader
   4    Thick line leader
   5    Double line leader
}

  TJvTabAlignment =
    (taOrdinary, taCenter, taRight, taDecimal, taVertical); // added by J.G. Boerema
  // Note: if taVertical then tableader should be disabled according to Word
  TJvTabLeader =
    (tlNone, tlDotted, tlDashed, tlUnderlined, tlThick, tlDouble); // added by J.G. Boerema

  TJvParaAttributes = class(TPersistent)
  private
    FRichEdit: TJvCustomRichEdit;
    FIndentationStyle: TJvIndentationStyle; // added by J.G. Boerema
    procedure GetAttributes(var Paragraph: TParaFormat2);
    function GetAlignment: TParaAlignment;
    function GetFirstIndent: Longint;
    function GetHeadingStyle: THeadingStyle;
    function GetLeftIndent: Longint;
    function GetLineSpacing: Longint;
    function GetLineSpacingRule: TLineSpacingRule;
    function GetNumbering: TJvNumbering;
    function GetNumberingStart: Integer;
    function GetNumberingStyle: TJvNumberingStyle;
    function GetNumberingTab: Word;
    function GetRightIndent: Longint;
    function GetSpaceAfter: Longint;
    function GetSpaceBefore: Longint;
    function GetTab(Index: Byte): Longint;
    function GetTabCount: Integer;
    function GetTableStyle: TParaTableStyle;
    function GetTabAlignment(Index: Byte): TJvTabAlignment;
    function GetTabLeader(Index: Byte): TJvTabLeader;
    procedure SetAlignment(Value: TParaAlignment);
    procedure SetAttributes(var Paragraph: TParaFormat2);
    procedure SetFirstIndent(Value: Longint);
    procedure SetHeadingStyle(Value: THeadingStyle);
    procedure SetLeftIndent(Value: Longint);
    procedure SetLineSpacing(Value: Longint);
    procedure SetLineSpacingRule(Value: TLineSpacingRule);
    procedure SetNumbering(Value: TJvNumbering);
    procedure SetNumberingStart(const Value: Integer);
    procedure SetNumberingStyle(Value: TJvNumberingStyle);
    procedure SetNumberingTab(Value: Word);
    procedure SetRightIndent(Value: Longint);
    procedure SetSpaceAfter(Value: Longint);
    procedure SetSpaceBefore(Value: Longint);
    procedure SetTab(Index: Byte; Value: Longint);
    procedure SetTabCount(Value: Integer);
    procedure SetTableStyle(Value: TParaTableStyle);
    procedure SetTabAlignment(Index: Byte; Value: TJvTabAlignment);
    procedure SetTabLeader(Index: Byte; Value: TJvTabLeader);
  protected
    procedure InitPara(var Paragraph: TParaFormat2);
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TJvCustomRichEdit);
    procedure Assign(Source: TPersistent); override;
    property Alignment: TParaAlignment read GetAlignment write SetAlignment;
    property FirstIndent: Longint read GetFirstIndent write SetFirstIndent;
    property HeadingStyle: THeadingStyle read GetHeadingStyle write SetHeadingStyle;
    property IndentationStyle: TJvIndentationStyle read FIndentationStyle write FIndentationStyle;
    property LeftIndent: Longint read GetLeftIndent write SetLeftIndent;
    property LineSpacing: Longint read GetLineSpacing write SetLineSpacing;
    property LineSpacingRule: TLineSpacingRule read GetLineSpacingRule write SetLineSpacingRule;
    property Numbering: TJvNumbering read GetNumbering write SetNumbering;
    property NumberingStart: Integer read GetNumberingStart write SetNumberingStart;
    property NumberingStyle: TJvNumberingStyle read GetNumberingStyle write SetNumberingStyle;
    property NumberingTab: Word read GetNumberingTab write SetNumberingTab;
    property RightIndent: Longint read GetRightIndent write SetRightIndent;
    property SpaceAfter: Longint read GetSpaceAfter write SetSpaceAfter;
    property SpaceBefore: Longint read GetSpaceBefore write SetSpaceBefore;
    property Tab[Index: Byte]: Longint read GetTab write SetTab;
    property TabCount: Integer read GetTabCount write SetTabCount;
    property TableStyle: TParaTableStyle read GetTableStyle write SetTableStyle;
    property TabAlignment[Index: Byte]: TJvTabAlignment read GetTabAlignment write SetTabAlignment;
    property TabLeader[Index: Byte]: TJvTabLeader read GetTabLeader write SetTabLeader;
  end;

  TJvConversionKind = (ckImport, ckExport);
  TJvConversionTextKind = (ctkText, ctkRTF, ctkBothPreferText, ctkBothPreferRTF);

  { (rb) Name TJvConverter is already taken, thus: }
  TJvConversion = class(TObject)
  private
    FOnProgress: TNotifyEvent;
    FParentWindow: THandle;
  protected
    FPercentDone: Integer;
    procedure DoProgress(APercentDone: Integer);
  public
    function CanHandle(const AExtension: string; const AKind: TJvConversionKind): Boolean; overload; virtual;
    function CanHandle(const AKind: TJvConversionKind): Boolean; overload; virtual;
    function Filter: string; virtual;
    function TextKind: TJvConversionTextKind; virtual;
    function IsFormatCorrect(const AFileName: string): Boolean; overload; virtual;
    function IsFormatCorrect(AStream: TStream): Boolean; overload; virtual;

    function Open(const AFileName: string; const AKind: TJvConversionKind): Boolean; overload; virtual;
    function Open(Stream: TStream; const AKind: TJvConversionKind): Boolean; overload; virtual;
    procedure Init(AParentWindow: THandle); virtual;
    procedure Done; virtual;
    function Retry: Boolean; virtual;

    function ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; virtual;
    function ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; virtual;

    function UserCancel: Boolean; virtual;
    function Error: Boolean; virtual;
    function ErrorStr: string; virtual;

    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
    property PercentDone: Integer read FPercentDone;
    property ParentWindow: THandle read FParentWindow;
  end;

  TJvStreamConversion = class(TJvConversion)
  private
    FStream: TStream;
    FSavedPosition: Int64;
    FStreamSize: Integer;
    FFreeStream: Boolean;
    FBytesConverted: Integer;
  public
    function Open(const AFileName: string; const AKind: TJvConversionKind): Boolean; override;
    function Open(Stream: TStream; const AKind: TJvConversionKind): Boolean; override;
    procedure Done; override;
    function Retry: Boolean; override;
    function ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; override;
    function ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; override;
    property Stream: TStream read FStream;
  end;

  TJvTextConversion = class(TJvStreamConversion)
  public
    function CanHandle(const AExtension: string; const AKind: TJvConversionKind): Boolean; override;
    function Filter: string; override;
    function TextKind: TJvConversionTextKind; override;
  end;

  TJvRTFConversion = class(TJvStreamConversion)
  public
    function CanHandle(const AExtension: string; const AKind: TJvConversionKind): Boolean; override;
    function Filter: string; override;
    function TextKind: TJvConversionTextKind; override;
    function IsFormatCorrect(const AFileName: string): Boolean; override;
    function IsFormatCorrect(AStream: TStream): Boolean; override;
  end;

  TJvOEMConversion = class(TJvStreamConversion)
  public
    function ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; override;
    function ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; override;
    function TextKind: TJvConversionTextKind; override;
  end;

  FCE = Smallint; // File Conversion Error

  { typedef long (PASCAL *PFN_RTF)(long, long); }
  PFN_RTF = function(I1, I2: Longint): Longint; stdcall;
  { long PASCAL InitConverter32(HANDLE hWnd, char *szModule); }
  TInitConverter32 = function(hWnd: THandle; szModule: PAnsiChar): LongBool; stdcall;
  { void PASCAL UninitConverter(void); }
  TUninitConverter = procedure; stdcall;
  { void PASCAL GetReadNames(HANDLE haszClass, HANDLE haszDescrip, HANDLE haszExt); }
  TGetReadNames = procedure(haszClass, haszDescrip, haszExt: THandle); stdcall;
  { void PASCAL GetWriteNames(HANDLE haszClass, HANDLE haszDescrip, HANDLE haszExt); }
  TGetWriteNames = procedure(haszClass, haszDescrip, haszExt: THandle); stdcall;
  { HGLOBAL PASCAL RegisterApp(unsigned long lFlags, void FAR *lpFuture); }
  TRegisterApp = function(lFlags: DWORD; lpFuture: Pointer): HGLOBAL; stdcall;
  { FCE  PASCAL IsFormatCorrect32(HANDLE ghszFile, HANDLE ghszClass); }
  TIsFormatCorrect32 = function(ghszFile, ghszClass: THandle): FCE; stdcall;
  { FCE  PASCAL ForeignToRtf32(HANDLE ghszFile, void *pstgForeign, HANDLE ghBuff, HANDLE ghszClass, HANDLE ghszSubset, PFN_RTF lpfnOut); }
  TForeignToRtf32 = function(ghszFile: THandle; pstgForeign: Pointer; ghBuff, ghszClass, ghszSubset: THandle;
    lpfnOut: PFN_RTF): FCE; stdcall;
  { FCE  PASCAL RtfToForeign32(HANDLE ghszFile, void *pstgForeign, HANDLE ghBuff, HANDLE ghshClass, PFN_RTF lpfnIn); }
  TRtfToForeign32 = function(ghszFile: THandle; pstgForeign: Pointer; ghBuff, ghshClass: THandle;
    lpfnIn: PFN_RTF): FCE; stdcall;
  { long PASCAL CchFetchLpszError(long fce, char FAR *lpszError, long cb); }
  TCchFetchLpszError = function(fce: Longint; lpszError: PAnsiChar; cb: Longint): Longint; stdcall;
  { long PASCAL FRegisterConverter(HANDLE hkeyRoot); }
  TFRegisterConverter = function(hkeyRoot: THandle): Longint; stdcall;

  TJvMSTextConversion = class(TJvConversion)
  private
    FConverterFileName: string;
    FExtensions: TStringList;
    FDescription: string;
    FConverterKind: TJvConversionKind;

    FConverter: HMODULE;
    FInitConverter32: TInitConverter32;
    FUninitConverter: TUninitConverter;
    FIsFormatCorrect32: TIsFormatCorrect32;
    FForeignToRtf32: TForeignToRtf32;
    FRtfToForeign32: TRtfToForeign32;
    FCchFetchLpszError: TCchFetchLpszError;

    { Indicates whether the thread is done }
    FThreadDone: Boolean;
    { Indicates whether the conversion process has been cancelled by the
      main thread }
    FCancel: Boolean;

    FBytesAvailable: Integer;
    { Buffer accessable by the converter dll }
    FBuffer: HGLOBAL;
    FBufferPtr: PAnsiChar;
    FTempProgress: Integer;

    { Thread synchronization based on the source of Wordpad, see
      http://cvs.wndtabs.com/cgi-bin/viewcvs/viewcvs.cgi/BCG/WordPad/

      Import works as follows

      Thread                            RichEdit
      ------                            --------
      loop:                             loop:
        @@ Converter converts buffer1     @@ Copy buffer1 to buffer2
                                          richedit processes buffer2

      The @@ parts may not happen simultaneously, thus this is converted to:

      Thread                            RichEdit
      ------                            --------
      loop:                             loop:
        @@ Converter converts buffer1     [wait until thread ready]
        [thread ready]                    @@ Copy buffer1 to buffer2
        [wait until richedit ready]       [richedit ready]
                                          richedit retrieves data from buffer2

      Export works as follows:

      Thread                            RichEdit
      ------                            --------
      loop:                             loop:
        @@ Converter converts buffer1     richedit puts data in buffer2
                                          @@ Copy buffer2 to buffer1

      The @@ parts may not happen simultaneously, thus this is converted to:

      Thread                            RichEdit
      ------                            --------
      loop:                             loop:
        [thread ready]                    richedit puts data in buffer2
        [wait until richedit ready]       [wait until thread ready]
        @@ Converter converts buffer1     @@ Copy buffer2 to buffer1
                                          [richedit ready]

      - buffer1 is FBuffer
      - buffer2 is the Buffer param from ConvertRead or ConvertWrite

    }

    FRichEditReady: TEvent;
    FThreadReady: TEvent;
    FConversionError: FCE;
    FFileName: HMODULE;
    FInitDone: Boolean;
  protected
    procedure LoadConverter;
    procedure FreeConverter;
    procedure Check(Result: FCE);
    procedure DoError(ErrorCode: FCE);

    { Handled in the context of the thread: }
    procedure DoConversion;
    function HandleExportCallback(cchBuff, nPercent: Longint): Longint;
    function HandleImportCallback(cchBuff, nPercent: Longint): Longint;
    procedure WaitUntilThreadReady;
    procedure WaitUntilRichEditReady;

    procedure Lock;
    procedure Unlock;

    procedure InitConverter;
  public
    constructor Create(const AConverterFileName, AExtensions, ADescription: string;
      const AKind: TJvConversionKind); virtual;
    destructor Destroy; override;

    function CanHandle(const AExtension: string; const AKind: TJvConversionKind): Boolean; override;
    function CanHandle(const AKind: TJvConversionKind): Boolean; override;

    function Open(const AFileName: string; const AKind: TJvConversionKind): Boolean; override;

    procedure Done; override;

    function TextKind: TJvConversionTextKind; override;
    function Filter: string; override;
    function IsFormatCorrect(const AFileName: string): Boolean; override;
    function TranslateError(ErrorCode: FCE): string;

    function ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; override;
    function ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}; BufSize: Integer): Integer; override;

    function UserCancel: Boolean; override;
    function Error: Boolean; override;
    function ErrorStr: string; override;
  end;

  TUndoName = (unUnknown, unTyping, unDelete, unDragDrop, unCut, unPaste);
  TRichSearchType = (stWholeWord, stMatchCase, stBackward, stSetSelection);
  TRichSearchTypes = set of TRichSearchType;
  TRichSelection = (stText, stObject, stMultiChar, stMultiObject);
  TRichSelectionType = set of TRichSelection;
  TRichLangOption = (rlAutoKeyboard, rlAutoFont, rlImeCancelComplete, rlImeAlwaysSendNotify);
  TRichLangOptions = set of TRichLangOption;
  TRichStreamFormat = (sfDefault, sfRichText, sfPlainText);
  TRichStreamMode = (smSelection, smPlainRtf, smNoObjects, smUnicode);
  TRichStreamModes = set of TRichStreamMode;
  TRichDropEffect = (rdeCopy, rdeMove, rdeLink, rdeScroll);
  TRichDropEffects = set of TRichDropEffect;
  TRichEditURLClickEvent = procedure(Sender: TObject; const URLText: string;
    Button: TMouseButton) of object;
  TRichEditURLHoverEvent = procedure(Sender: TObject; const URLText: string) of object;
  TRichEditProtectChangeEx = procedure(Sender: TObject; const Msg: TMessage;
    StartPos, EndPos: Integer; var AllowChange: Boolean) of object;
  TRichEditFindErrorEvent = procedure(Sender: TObject; const TextToFind: string) of object;
  TRichEditFindCloseEvent = procedure(Sender: TObject; Dialog: TFindDialog) of object;
  TRichEditProgressEvent = procedure(Sender: TObject; PercentDone: Integer) of object;
  TRichEditDragAllowedEvent = procedure(Sender: TObject; ShiftState: TShiftState;
    var AllowedEffects: TRichDropEffects; var Handled: Boolean) of object;
  TRichEditGetDragDropEffectEvent = procedure(Sender: TObject; ShiftState: TShiftState;
    var AllowedEffects: TRichDropEffects; var Handled: Boolean) of object;
  TRichEditQueryAcceptData = procedure(Sender: TObject; const ADataObject: IDataObject;
    var AFormat: TClipFormat; ClipboardOperationKind: Cardinal; Really: Boolean;
    IconMetaPict: HGLOBAL; var Handled: Boolean) of object;

  TJvCustomRichEdit = class(TJvExCustomMemo)
  private
    FHideScrollBars: Boolean;
    FSelectionBar: Boolean;
    FAutoURLDetect: Boolean;
    FWordSelection: Boolean;
    FPlainText: Boolean;
    FSelAttributes: TJvTextAttributes;
    FDefAttributes: TJvTextAttributes;
    FWordAttributes: TJvTextAttributes;
    FParagraph: TJvParaAttributes;
    FOldParaAlignment: TParaAlignment;
    FScreenLogPixels: Integer;
    FUndoLimit: Integer;
    FLines: TStrings;
    FState: TObject;
    FHideSelection: Boolean;
    FLangOptions: TRichLangOptions;
    FLinesUpdating: Boolean;
    FPageRect: TRect;
    FClickRange: TCharRange;
    FClickBtn: TMouseButton;
    FFindDialog: TFindDialog;
    FReplaceDialog: TReplaceDialog;
    FLastFind: TFindDialog;
    FAllowObjects: Boolean;
    FCallback: TObject;
    FRichEditOle: IUnknown;
    FPopupVerbMenu: TPopupMenu;
    FTitle: string;
    FAutoVerbMenu: Boolean;
    FAllowInPlace: Boolean;
    FDefaultConverter: TJvConversion;
    FImageRect: TRect;
    FAutoAdvancedTypography: Boolean;
    FAdvancedTypography: Boolean;
    FOLEDragDrop: Boolean;
    FOnSelChange: TNotifyEvent;
    FOnResizeRequest: TRichEditResizeEvent;
    FOnProtectChange: TRichEditProtectChange;
    FOnProtectChangeEx: TRichEditProtectChangeEx;
    FOnSaveClipboard: TRichEditSaveClipboard;
    FOnURLClick: TRichEditURLClickEvent;
    FOnURLHover: TRichEditURLHoverEvent;
    FOnTextNotFound: TRichEditFindErrorEvent;
    FOnCloseFindDialog: TRichEditFindCloseEvent;
    // From JvRichEdit.pas by Sébastien Buysse
    FOnHorizontalScroll: TNotifyEvent;
    FOnVerticalScroll: TNotifyEvent;
    FOnConversionProgress: TRichEditProgressEvent;
    FForceUndo: Boolean;
    FUseFixedPopup: Boolean;
    // From CCR
    FOnInPlaceActivate: TNotifyEvent;
    FOnInPlaceDeactivate: TNotifyEvent;
    FOnDragAllowed: TRichEditDragAllowedEvent;
    FOnGetDragDropEffect: TRichEditGetDragDropEffectEvent;
    FOnQueryAcceptData: TRichEditQueryAcceptData;

    function GetAdvancedTypography: Boolean;
    function GetAutoURLDetect: Boolean;
    function GetWordSelection: Boolean;
    function GetLangOptions: TRichLangOptions;
    function GetCanRedo: Boolean;
    function GetCanPaste: Boolean;
    function GetRedoName: TUndoName;
    function GetUndoName: TUndoName;
    function GetStreamFormat: TRichStreamFormat;
    function GetStreamMode: TRichStreamModes;
    function GetSelectionType: TRichSelectionType;
    function GetZoom: Integer; // Added by J.G. Boerema
    function IsAdvancedTypographyStored: Boolean;
    procedure PopupVerbClick(Sender: TObject);
    procedure ObjectPropsClick(Sender: TObject);
    procedure CloseObjects;
    procedure UpdateHostNames;
    procedure SetAdvancedTypography(const Value: Boolean);
    procedure SetAllowObjects(Value: Boolean);
    procedure SetStreamFormat(Value: TRichStreamFormat);
    procedure SetStreamMode(Value: TRichStreamModes);
    procedure SetAutoURLDetect(Value: Boolean);
    procedure SetWordSelection(Value: Boolean);
    procedure SetHideScrollBars(Value: Boolean);
    procedure SetHideSelection(Value: Boolean);
    procedure SetTitle(const Value: string);
    procedure SetLangOptions(Value: TRichLangOptions);
    procedure SetRichEditStrings(Value: TStrings);
    procedure SetDefAttributes(Value: TJvTextAttributes);
    procedure SetSelAttributes(Value: TJvTextAttributes);
    procedure SetWordAttributes(Value: TJvTextAttributes);
    procedure SetSelectionBar(Value: Boolean);
    procedure SetOLEDragDrop(const Value: Boolean);
    procedure SetUndoLimit(Value: Integer);
    procedure SetZoom(Value: Integer); // Added by J.G. Boerema
    procedure UpdateTextModes(Plain: Boolean);
    procedure UpdateTypographyOptions(const Advanced: Boolean);
    procedure AdjustFindDialogPosition(Dialog: TFindDialog);
    procedure SetupFindDialog(Dialog: TFindDialog; const SearchStr, ReplaceStr: string);
    function FindEditText(Dialog: TFindDialog; AdjustPos, Events: Boolean): Boolean;
    function GetCanFindNext: Boolean;
    procedure FindDialogFind(Sender: TObject);
    procedure NeedAdvancedTypography;
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure SetSelText(const Value: string);
    procedure FindDialogClose(Sender: TObject);
    procedure SetUIActive(Active: Boolean);
    procedure CMBiDiModeChanged(var Msg: TMessage); message CM_BIDIMODECHANGED;
    procedure CMDocWindowActivate(var Msg: TMessage); message CM_DOCWINDOWACTIVATE;
    procedure CMUIDeactivate(var Msg: TMessage); message CM_UIDEACTIVATE;
    procedure CNNotify(var Msg: TWMNotify); message CN_NOTIFY;
    procedure EMReplaceSel(var Msg: TMessage); message EM_REPLACESEL;
    procedure WMDestroy(var Msg: TWMDestroy); message WM_DESTROY;
    procedure WMMouseMove(var Msg: TMessage); message WM_MOUSEMOVE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFont(var Msg: TWMSetFont); message WM_SETFONT;
    procedure WMSetText(var Msg: TMessage); message WM_SETTEXT;
    // From JvRichEdit.pas by Sébastien Buysse
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    function GetFlat: Boolean;
    procedure SetFlat(const Value: Boolean);
    function GetParentFlat: Boolean;
    procedure SetParentFlat(const Value: Boolean);
  protected
    procedure ColorChanged; override;
    procedure FontChanged; override;

    function GetConverter(const AFileName: string; const Kind: TJvConversionKind): TJvConversion; overload;
    function GetConverter(AStream: TStream; const Kind: TJvConversionKind): TJvConversion; overload;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function GetPopupMenu: TPopupMenu; override;
    {$IFDEF RTL220_UP}
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    {$ENDIF RTL220_UP}
    procedure TextNotFound(Dialog: TFindDialog); virtual;
    procedure RequestSize(const Rect: TRect); virtual;
    procedure SelectionChange; dynamic;
    function ProtectChange(const Msg: TMessage; StartPos, EndPos: Integer): Boolean; dynamic;
    function SaveClipboard(NumObj, NumChars: Integer): Boolean; dynamic;
    procedure URLClick(const URLText: string; Button: TMouseButton); dynamic;
    procedure URLHover(const URLText: string); dynamic;
    function DoDragAllowed(const ShiftState: TShiftState; var AllowedEffects: TRichDropEffects): Boolean; dynamic;
    function DoGetDragDropEffect(const ShiftState: TShiftState; var Effects: TRichDropEffects): Boolean; dynamic;
    function DoQueryAcceptData(const ADataObject: IDataObject; var AFormat: TClipFormat;
      ClipboardOperationKind: Cardinal; Really: Boolean; IconMetaPict: HGLOBAL): Boolean; dynamic;
    procedure SetPlainText(Value: Boolean); virtual;
    procedure CloseFindDialog(Dialog: TFindDialog); virtual;
    procedure DoSetMaxLength(Value: Integer); override;
    procedure DoConversionProgress(const AProgress: Integer);
    function GetSelLength: Integer; override;
    function GetSelStart: Integer; override;
    function GetSelText: string; override;
    procedure SetSelLength(Value: Integer); override;
    procedure SetSelStart(Value: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    property AllowInPlace: Boolean read FAllowInPlace write FAllowInPlace default True;
    property AutoAdvancedTypography: Boolean read FAutoAdvancedTypography write FAutoAdvancedTypography default True;
    property AdvancedTypography: Boolean read GetAdvancedTypography write SetAdvancedTypography stored
      IsAdvancedTypographyStored;
    property AllowObjects: Boolean read FAllowObjects write SetAllowObjects default True;
    property AutoURLDetect: Boolean read GetAutoURLDetect write SetAutoURLDetect default True;
    property AutoVerbMenu: Boolean read FAutoVerbMenu write FAutoVerbMenu default True;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property HideScrollBars: Boolean read FHideScrollBars write SetHideScrollBars default True;
    property Title: string read FTitle write SetTitle;
    property LangOptions: TRichLangOptions read GetLangOptions write SetLangOptions default [rlAutoFont];
    property Lines: TStrings read FLines write SetRichEditStrings;
    property OLEDragDrop: Boolean read FOLEDragDrop write SetOLEDragDrop default True;
    property PlainText: Boolean read FPlainText write SetPlainText default False;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar default True;
    property StreamFormat: TRichStreamFormat read GetStreamFormat write SetStreamFormat default sfDefault;
    property StreamMode: TRichStreamModes read GetStreamMode write SetStreamMode default [];
    property UndoLimit: Integer read FUndoLimit write SetUndoLimit default 100;
    property WordSelection: Boolean read GetWordSelection write SetWordSelection default True;
    property ScrollBars default ssBoth;
    property TabStop default True;
    property SelText: string read GetSelText write SetSelText;
    // Zoom: zoom in/out percentage (100=normal) note: no need to set default (100) in constructor.
    property Zoom: Integer read GetZoom write SetZoom default 100;
    property OnSaveClipboard: TRichEditSaveClipboard read FOnSaveClipboard
      write FOnSaveClipboard;
    property OnSelectionChange: TNotifyEvent read FOnSelChange write FOnSelChange;
    property OnProtectChange: TRichEditProtectChange read FOnProtectChange
      write FOnProtectChange; { obsolete }
    property OnProtectChangeEx: TRichEditProtectChangeEx read FOnProtectChangeEx
      write FOnProtectChangeEx;
    property OnResizeRequest: TRichEditResizeEvent read FOnResizeRequest
      write FOnResizeRequest;
    property OnURLClick: TRichEditURLClickEvent read FOnURLClick write FOnURLClick;

    // This event this is called as long as the Mouse moves over a link.
    // To handle the first call only, check the current cursor handle.
    // The RichEdit control 2.0 or higher sets the cursor to "HandPoint" when
    // the Mouse is over a link and resets the cursor handle to the previous
    // cursor on exit.
    // so basically, you do this in your event handler:
    //
    //  if HandpointCursorHandle = 0 then
    //  begin
    //    // Remember the handle of the "HandPoint" cursor (set by RichEdit 2.0 or higher)
    //    // Must be reset to 0 in JvRichEdit1MouseMove() after handle has changed.
    //    HandpointCursorHandle := Windows.GetCursor;
    //
    //    // Do what you need when Mouse is the first time over a link
    //  end;
    //
    // then in OnMouseMove you do this to reset the global variable
    // 
    //  // "URLHover" event has been called then this value is <> 0
    //  if HandpointCursorHandle <> 0 then
    //  begin
    //    // Mouse is not over a link anymore than the cursor handle has changed
    //    if Windows.GetCursor <> HandpointCursorHandle then
    //    begin
    //      // Reset the cursor handle
    //      HandpointCursorHandle := 0;
    //
    //      // Do what you need when Mouse is not over the link anymore
    //    end;
    //  end;
    //
    property OnURLHover: TRichEditURLHoverEvent read FOnURLHover write FOnURLHover;
    
    property OnTextNotFound: TRichEditFindErrorEvent read FOnTextNotFound write FOnTextNotFound;
    property OnCloseFindDialog: TRichEditFindCloseEvent read FOnCloseFindDialog
      write FOnCloseFindDialog;
    property OnConversionProgress: TRichEditProgressEvent read FOnConversionProgress write FOnConversionProgress;
    // From JvRichEdit.pas by Sébastien Buysse
    property OnVerticalScroll: TNotifyEvent read FOnVerticalScroll write FOnVerticalScroll;
    property OnHorizontalScroll: TNotifyEvent read FOnHorizontalScroll write FOnHorizontalScroll;
    property OnDragAllowed: TRichEditDragAllowedEvent read FOnDragAllowed write FOnDragAllowed;
    property OnGetDragDropEffect: TRichEditGetDragDropEffectEvent read FOnGetDragDropEffect write FOnGetDragDropEffect;
    property OnQueryAcceptData: TRichEditQueryAcceptData read FOnQueryAcceptData write FOnQueryAcceptData;
    property ForceUndo: Boolean read FForceUndo write FForceUndo default True;
    property UseFixedPopup: Boolean read FUseFixedPopup write FUseFixedPopup default True;
    // from CCR
    property OnInPlaceActivate: TNotifyEvent read FOnInPlaceActivate write FOnInPlaceActivate;
    property OnInPlaceDeactivate: TNotifyEvent read FOnInPlaceDeactivate write FOnInPlaceDeactivate;
    property Flat: Boolean read GetFlat write SetFlat default False;
    property ParentFlat: Boolean read GetParentFlat write SetParentFlat default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    procedure SaveToImage(Picture: TPicture);

    procedure InsertGraphic(AGraphic: TGraphic; const Sizeable: Boolean);
    { Same interface as TOleContainer }
    procedure InsertLinkToFile(const FileName: string; Iconic: Boolean);
    procedure InsertObject(const OleClassName: string; Iconic: Boolean);
    procedure InsertObjectFromFile(const FileName: string; Iconic: Boolean);
    procedure InsertObjectFromInfo(const Info: TCreateInfo);
    // InsertFormatText inserts formatted text at the cursor position given by Index.
    // If Index < 0, the text is inserted at the current SelStart position.
    // S is the string to insert
    // AFont is the font to use. If AFont = nil, then the current attributes at the insertion point are used.
    // NOTE: this procedure does not reset the attributes after the call, i.e if you change the text color
    // it will remain that color until you change it again.
    procedure InsertFormatText(Index: Integer; const S: string; const AFont: TFont = nil); overload;
    procedure InsertFormatText(Index: Integer; const S: string;
      FontStyle: TFontStyles; const FontName: string = ''; const FontColor: TColor = clDefault; FontHeight: Integer = 0); overload;

    // AddFormatText works just like InsertFormatText but always moves the insertion
    // point to the end of the available text
    procedure AddFormatText(const S: string; const AFont: TFont = nil); overload;
    procedure AddFormatText(const S: string; FontStyle: TFontStyles; const FontName: string = ''; const FontColor: TColor = clDefault; FontHeight: Integer = 0); overload;

    procedure SetSelection(StartPos, EndPos: Longint; ScrollCaret: Boolean);
    function GetSelection: TCharRange;
    function GetTextRange(StartPos, EndPos: Longint): string;
    // GetTextLenEx is to be used when printing the RichEdit using EM_FORMATRANGE
    // because GetTextLen is unreliable in this case.
    // See Mantis 4782 and http://edn.embarcadero.com/article/26772 for details
    function GetTextLenEx: Integer;
    function CharFromPos(X, Y: Integer): Integer;
    function LineFromChar(CharIndex: Integer): Integer;
    function GetLineIndex(LineNo: Integer): Integer;
    function GetLineLength(CharIndex: Integer): Integer;
    function WordAtCursor: string;
    function FindText(const SearchStr: string;
      StartPos, Length: Integer; Options: TRichSearchTypes): Integer;
    function GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer; override;
    function GetCaretPos: TPoint; override;
    function GetCharPos(CharIndex: Integer): TPoint;
    function InsertObjectDialog: Boolean;
    function ObjectPropertiesDialog: Boolean;
    function PasteSpecialDialog: Boolean;
    function FindDialog(const SearchStr: string): TFindDialog;
    function ReplaceDialog(const SearchStr, ReplaceStr: string): TReplaceDialog;
    function FindNext: Boolean;
    procedure Print(const Caption: string); virtual;
    class procedure RegisterConversionFormat(AConverter: TJvConversion);
    class procedure RegisterMSTextConverters;
    class function Filter(const AKind: TJvConversionKind): string;
    procedure ClearUndo;
    procedure Redo;
    procedure StopGroupTyping;
    procedure CloseActiveObject; // from CCR

    procedure SetSelectionLink;

    property CanFindNext: Boolean read GetCanFindNext;
    property CanRedo: Boolean read GetCanRedo;
    property CanPaste: Boolean read GetCanPaste;
    property RedoName: TUndoName read GetRedoName;
    property UndoName: TUndoName read GetUndoName;
    property DefaultConverter: TJvConversion read FDefaultConverter write FDefaultConverter;
    property DefAttributes: TJvTextAttributes read FDefAttributes write SetDefAttributes;
    property SelAttributes: TJvTextAttributes read FSelAttributes write SetSelAttributes;
    property WordAttributes: TJvTextAttributes read FWordAttributes write SetWordAttributes;
    property PageRect: TRect read FPageRect write FPageRect;
    property Paragraph: TJvParaAttributes read FParagraph;
    property SelectionType: TRichSelectionType read GetSelectionType;
    {>>>}
    property RichEditOle: IUnknown
      read FRichEditOle;
    {<<<}
  end;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TJvRichEdit = class(TJvCustomRichEdit)
  published
    property AdvancedTypography;
    property Align;
    property Alignment;
    property AutoAdvancedTypography;
    property AutoSize default False;
    property AutoURLDetect;
    property AutoVerbMenu;
    property AllowObjects;
    property AllowInPlace;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderWidth;
    property DragKind;
    property BorderStyle;
    property ClipboardCommands;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property Font;
    property ForceUndo;
    property HideSelection;
    property HideScrollBars;
    property HintColor;
    property Title;
    property ImeMode;
    property ImeName;
    property Constraints;
    property ParentBiDiMode;
    property LangOptions;
    property Lines;
    property MaxLength;
    property OLEDragDrop;
    property ParentColor;
    property ParentFlat;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property SelectionBar;
    property SelText;
    property ShowHint;
    property StreamFormat;
    property StreamMode;
    property TabOrder;
    property TabStop;
    property UndoLimit;
    property UseFixedPopup;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordSelection;
    property WordWrap;
    property Zoom; // added by J.G. Boerema
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnContextPopup;
    property OnConversionProgress;
    property OnEndDock;
    property OnStartDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange; { obsolete }
    property OnProtectChangeEx;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDrag;
    property OnTextNotFound;
    property OnCloseFindDialog;
    property OnDragAllowed;
    property OnGetDragDropEffect;
    property OnQueryAcceptData;
    property OnURLClick;
    property OnURLHover;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;
    property OnVerticalScroll;
    property OnHorizontalScroll;
    // From CCR
    property OnInPlaceActivate;
    property OnInPlaceDeactivate;
  end;

var
  RichEditVersion: Integer;

  { Two procedures to construct RTF from a bitmap. You can use this to
    insert bitmaps in the rich edit control, for example:

      Stream := TMemoryStream.Create;
      try
        BitmapToRTF(SomeBitmap, Stream);
        Stream.Position := 0;

        JvRichEdit1.StreamFormat := sfRichText;
        JvRichEdit1.StreamMode := [smSelection, smPlainRtf];
        JvRichEdit1.Lines.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;

    But:

    * if you stream out the RTF content of the rich edit control, the bitmaps
      are *not* included. Use TJvRichEdit.InsertGraphic if you want the bitmaps
      to be included in the RTF.
    * TJvRichEdit.AllowObjects must be set to True.
    * BitmapToRTF is the fastest, TJvRichEdit.InsertGraphic the slowest.
  }

{ uses the \dibitmap identifier }
procedure BitmapToRTF(ABitmap: TBitmap; AStream: TStream);
{ uses the \wmetafile identifier }
function BitmapToRTF2(ABitmap: TBitmap; AStream: TStream): Boolean;

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
  {$IFDEF HAS_UNIT_SYSTEM_UITYPES}
  System.UITypes,
  {$ENDIF HAS_UNIT_SYSTEM_UITYPES}
  Types,
  Printers, ComStrs, OleConst, OleDlg, Math, Registry, Contnrs,
  {$IFDEF RTL200_UP}
  CommDlg,
  {$ENDIF RTL200_UP}
  JclAnsiStrings, JclSysInfo,
  JvThemes, JvConsts, JvResources, JvFixedEditPopUp;

type
  PENLink = ^TENLink;
  PENOleOpFailed = ^TENOleOpFailed;
  {$IFDEF SUPPORTS_UNICODE}
  TFindTextEx = TFindTextExW;
  {$ELSE}
  TFindTextEx = TFindTextExA;
  {$ENDIF SUPPORTS_UNICODE}
  TTextRangeA = record
    chrg: TCharRange;
    lpstrText: PAnsiChar;
  end;

  TTextRangeW = record
    chrg: TCharRange;
    lpstrText: PWideChar;
  end;

  {$IFDEF SUPPORTS_UNICODE}
  TTextRange = TTextRangeW;
  {$ELSE}
  TTextRange = TTextRangeA;
  {$ENDIF SUPPORTS_UNICODE}

  { OLE Extensions to the Rich Text Editor }
  { Converted from RICHOLE.H               }
  { Structure passed to GetObject and InsertObject }

  _ReObject = record
    cbStruct: DWORD; { Size of structure                }
    cp: ULONG; { Character position of object     }
    clsid: TCLSID; { Class ID of object               }
    poleobj: IOleObject; { OLE object interface             }
    pstg: IStorage; { Associated storage interface     }
    polesite: IOleClientSite; { Associated client site interface }
    sizel: TSize; { Size of object (may be 0,0)      }
    dvAspect: Longint; { Display aspect to use            }
    dwFlags: DWORD; { Object status flags              }
    dwUser: DWORD; { DWORD for user's use             }
  end;
  TReObject = _ReObject;

  EMSTextConversionError = class(Exception)
  private
    FErrorCode: FCE;
  public
    constructor Create(const Msg: string; AErrorCode: FCE = 0);
    property ErrorCode: FCE read FErrorCode write FErrorCode;
  end;

  (*  make Delphi 5 compiler happy // andreas
    { RichEdit GUIDs }
    IID_IRichEditOle: TGUID = (
      D1: $00020D00; D2: $0000; D3: $0000; D4: ($C0, $00, $00, $00, $00, $00, $00, $46));
    IID_IRichEditOleCallback: TGUID = (
      D1: $00020D03; D2: $0000; D3: $0000; D4: ($C0, $00, $00, $00, $00, $00, $00, $46));
  *)

  {
   *  IRichEditOle
   *
   *  Purpose:
   *    Interface used by the client of RichEdit to perform OLE-related
   *    operations.
   *
   *    The methods herein may just want to be regular Windows messages.
  }

  IRichEditOle = interface(IUnknown)
    ['{00020d00-0000-0000-c000-000000000046}']
    function GetClientSite(out clientSite: IOleClientSite): HRESULT; stdcall;
    function GetObjectCount: HRESULT; stdcall;
    function GetLinkCount: HRESULT; stdcall;
    function GetObject(iob: Longint; out ReObject: TReObject;
      dwFlags: DWORD): HRESULT; stdcall;
    function InsertObject(var ReObject: TReObject): HRESULT; stdcall;
    function ConvertObject(iob: Longint; rclsidNew: TIID;
      lpstrUserTypeNew: LPCSTR): HRESULT; stdcall;
    function ActivateAs(rclsid: TIID; rclsidAs: TIID): HRESULT; stdcall;
    function SetHostNames(lpstrContainerApp: LPCSTR;
      lpstrContainerObj: LPCSTR): HRESULT; stdcall;
    function SetLinkAvailable(iob: Longint; fAvailable: BOOL): HRESULT; stdcall;
    function SetDvaspect(iob: Longint; dvAspect: DWORD): HRESULT; stdcall;
    function HandsOffStorage(iob: Longint): HRESULT; stdcall;
    function SaveCompleted(iob: Longint; const stg: IStorage): HRESULT; stdcall;
    function InPlaceDeactivate: HRESULT; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HRESULT; stdcall;
    function GetClipboardData(var chrg: TCharRange; reco: DWORD;
      out dataObj: IDataObject): HRESULT; stdcall;
    function ImportDataObject(dataObj: IDataObject; cf: TClipFormat;
      hMetaPict: HGLOBAL): HRESULT; stdcall;
  end;

  {
   *  IRichEditOleCallback
   *
   *  Purpose:
   *    Interface used by the RichEdit to get OLE-related stuff from the
   *    application using RichEdit.
  }

  IRichEditOleCallback = interface(IUnknown)
    ['{00020d03-0000-0000-c000-000000000046}']
    function GetNewStorage(out stg: IStorage): HRESULT; stdcall;
    function GetInPlaceContext(out Frame: IOleInPlaceFrame;
      out Doc: IOleInPlaceUIWindow;
      lpFrameInfo: POleInPlaceFrameInfo): HRESULT; stdcall;
    function ShowContainerUI(fShow: BOOL): HRESULT; stdcall;
    function QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
      cp: Longint): HRESULT; stdcall;
    function DeleteObject(const oleobj: IOleObject): HRESULT; stdcall;
    function QueryAcceptData(const dataObj: IDataObject;
      var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL;
      hMetaPict: HGLOBAL): HRESULT; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HRESULT; stdcall;
    function GetClipboardData(const chrg: TCharRange; reco: DWORD;
      out dataObj: IDataObject): HRESULT; stdcall;
    function GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
      var dwEffect: DWORD): HRESULT; stdcall;
    function GetContextMenu(seltype: Word; const oleobj: IOleObject;
      const chrg: TCharRange; out Menu: HMENU): HRESULT; stdcall;
  end;

  TConversionFormatList = class(TObjectList)
  private
    FRTFConvIndex: Integer;
    FTextConvIndex: Integer;
    function GetItem(Index: Integer): TJvConversion;
  public
    constructor Create; virtual;
    { GetConverter implicitly calls Result.Init, thus caller must call Result.Done }
    function GetConverter(AParentWindow: THandle; const AFileName: string;
      const Kind: TJvConversionKind): TJvConversion; overload;
    function GetConverter(AParentWindow: THandle; AStream: TStream;
      const Kind: TJvConversionKind): TJvConversion; overload;
    function GetFilter(const AKind: TJvConversionKind): string;
    function DefaultConverter: TJvConversion;
    property Items[Index: Integer]: TJvConversion read GetItem {write SetItem}; default;
  end;

  TImageDataObject = class(TInterfacedObject, IDataObject)
  private
    FGraphic: TGraphic;
  public
    constructor Create(AGraphic: TGraphic); virtual;
    { IDataObject }
    function GetData(const FormatEtcIn: TFormatEtc; out Medium: TStgMedium):
      HRESULT; stdcall;
    function GetDataHere(const FormatEtc: TFormatEtc; out Medium: TStgMedium):
      HRESULT; stdcall;
    function QueryGetData(const FormatEtc: TFormatEtc): HRESULT;
      stdcall;
    function GetCanonicalFormatEtc(const FormatEtc: TFormatEtc;
      out FormatEtcOut: TFormatEtc): HRESULT; stdcall;
    function SetData(const FormatEtc: TFormatEtc; var Medium: TStgMedium;
      fRelease: BOOL): HRESULT; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out EnumFormatEtc:
      IEnumFormatEtc): HRESULT; stdcall;
    function DAdvise(const FormatEtc: TFormatEtc; advf: Longint;
      const advSink: IAdviseSink; out dwConnection: Longint): HRESULT; stdcall;
    function DUnadvise(dwConnection: Longint): HRESULT; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HRESULT;
      stdcall;
  end;

  TJvRichEditState = class(TObject)
  private
    FOrigFormat: TRichStreamFormat;
    FOrigMode: TRichStreamModes;
    FStreamFormat: TRichStreamFormat;
    FStreamMode: TRichStreamModes;
    FSelStart: Integer;
    FSelLength: Integer;
    FModified: Boolean;
    FForcePlainText: Boolean;
    FStream: TMemoryStream;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Store(RichEdit: TJvCustomRichEdit);
    procedure Restore(RichEdit: TJvCustomRichEdit);
    property ForcePlainText: Boolean read FForcePlainText write FForcePlainText;
  end;

  TJvRichEditStrings = class(TStrings)
  private
    FRichEdit: TJvCustomRichEdit;
    FFormat: TRichStreamFormat;
    FMode: TRichStreamModes;
    procedure EnableChange(const Value: Boolean);
  protected
    procedure ProgressCallback(Sender: TObject);
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetTextStr(const Value: string); override;

    procedure DoImport(AConverter: TJvConversion);
    procedure DoExport(AConverter: TJvConversion);
  public
    procedure Clear; override;
    procedure AddStrings(Strings: TStrings); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: string); override;
    procedure SaveToStream(Stream: TStream); override;
    property Format: TRichStreamFormat read FFormat write FFormat;
    property Mode: TRichStreamModes read FMode write FMode;
  end;

  TMSTextConversionThread = class(TJvCustomThread)
  protected
    procedure Execute; override;
  public
    constructor Create; virtual;
  end;

  { TOleUILinkInfo - helper interface for Object Properties dialog }

  TOleUILinkInfo = class(TInterfacedObject, IOleUILinkInfo)
  private
    FReObject: TReObject;
    FRichEdit: TJvCustomRichEdit;
    FOleLink: IOleLink;
  public
    constructor Create(ARichEdit: TJvCustomRichEdit; ReObject: TReObject);
    function GetNextLink(dwLink: Longint): Longint; stdcall;
    function SetLinkUpdateOptions(dwLink: Longint;
      dwUpdateOpt: Longint): HRESULT; stdcall;
    function GetLinkUpdateOptions(dwLink: Longint;
      var dwUpdateOpt: Longint): HRESULT; stdcall;
    function SetLinkSource(dwLink: Longint; pszDisplayName: PChar;
      lenFileName: Longint; var chEaten: Longint;
      fValidateSource: BOOL): HRESULT; stdcall;
    function GetLinkSource(dwLink: Longint; var pszDisplayName: PChar;
      var lenFileName: Longint; var pszFullLinkType: PChar;
      var pszShortLinkType: PChar; var fSourceAvailable: BOOL;
      var fIsSelected: BOOL): HRESULT; stdcall;
    function OpenLinkSource(dwLink: Longint): HRESULT; stdcall;
    function UpdateLink(dwLink: Longint; fErrorMessage: BOOL;
      fErrorAction: BOOL): HRESULT; stdcall;
    function CancelLink(dwLink: Longint): HRESULT; stdcall;
    function GetLastUpdate(dwLink: Longint;
      var LastUpdate: TFileTime): HRESULT; stdcall;
  end;

  { TOleUIObjInfo - helper interface for Object Properties dialog }

  TOleUIObjInfo = class(TInterfacedObject, IOleUIObjInfo)
  private
    FRichEdit: TJvCustomRichEdit;
    FReObject: TReObject;
  public
    constructor Create(ARichEdit: TJvCustomRichEdit; ReObject: TReObject);
    function GetObjectInfo(dwObject: Longint;
      var dwObjSize: Longint; var lpszLabel: PChar;
      var lpszType: PChar; var lpszShortType: PChar;
      var lpszLocation: PChar): HRESULT; stdcall;
    function GetConvertInfo(dwObject: Longint; var ClassID: TCLSID;
      var wFormat: Word; var ConvertDefaultClassID: TCLSID;
      var lpClsidExclude: PCLSID; var cClsidExclude: Longint): HRESULT; stdcall;
    function ConvertObject(dwObject: Longint;
      const clsidNew: TCLSID): HRESULT; stdcall;
    function GetViewInfo(dwObject: Longint; var hMetaPict: HGLOBAL;
      var dvAspect: Longint; var nCurrentScale: Integer): HRESULT; stdcall;
    function SetViewInfo(dwObject: Longint; hMetaPict: HGLOBAL;
      dvAspect: Longint; nCurrentScale: Integer;
      bRelativeToOrig: BOOL): HRESULT; stdcall;
  end;

  TRichEditOleCallback = class(TObject, IUnknown, IRichEditOleCallback)
  private
    FDocForm: IVCLFrameForm;
    FFrameForm: IVCLFrameForm;
    FAccelTable: HACCEL;
    FAccelCount: Integer;
    FAutoScroll: Boolean;
    procedure CreateAccelTable;
    procedure DestroyAccelTable;
    procedure AssignFrame;
  private
    FRefCount: Longint;
    FRichEdit: TJvCustomRichEdit;
  public
    constructor Create(ARichEdit: TJvCustomRichEdit);
    destructor Destroy; override;
    function QueryInterface(const iid: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Longint; stdcall;
    function _Release: Longint; stdcall;
    function GetNewStorage(out stg: IStorage): HRESULT; stdcall;
    function GetInPlaceContext(out Frame: IOleInPlaceFrame;
      out Doc: IOleInPlaceUIWindow;
      lpFrameInfo: POleInPlaceFrameInfo): HRESULT; stdcall;
    function GetClipboardData(const chrg: TCharRange; reco: DWORD;
      out dataObj: IDataObject): HRESULT; stdcall;
    function GetContextMenu(seltype: Word; const oleobj: IOleObject;
      const chrg: TCharRange; out Menu: HMENU): HRESULT; stdcall;
    function ShowContainerUI(fShow: BOOL): HRESULT; stdcall;
    function QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
      cp: Longint): HRESULT; stdcall;
    function DeleteObject(const oleobj: IOleObject): HRESULT; stdcall;
    function QueryAcceptData(const dataObj: IDataObject; var cfFormat: TClipFormat;
      reco: DWORD; fReally: BOOL; hMetaPict: HGLOBAL): HRESULT; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HRESULT; stdcall;
    function GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
      var dwEffect: DWORD): HRESULT; stdcall;
  end;

  TBiDiOptions = record
    cbSize: UINT;
    wMask: WORD;
    wEffects: WORD;
  end;

const
  { File Conversion Errors }
  fceTrue = FCE(1); // IsFormatCorrect32: recognized the input file.
  fceNoErr = FCE(0); // IsFormatCorrect32: Did not recognize the input file.
  // Operation completed successfully for other APIs
  fceOpenInFileErr = FCE(-1); // could not open input file
  fceReadErr = FCE(-2); // error during read
  fceOpenConvErr = FCE(-3); // error opening conversion file (obsolete)
  fceWriteErr = FCE(-4); // error during write
  fceInvalidFile = FCE(-5); // invalid data in conversion file
  fceOpenExceptErr = FCE(-6); // error opening exception file (obsolete)
  fceWriteExceptErr = FCE(-7); // error writing exception file (obsolete)
  fceNoMemory = FCE(-8); // out of memory
  fceInvalidDoc = FCE(-9); // invalid document (obsolete)
  fceDiskFull = FCE(-10); // out of space on output (obsolete)
  fceDocTooLarge = FCE(-11); // conversion document too large for target (obsolete)
  fceOpenOutFileErr = FCE(-12); // could not open output file
  fceUserCancel = FCE(-13); // conversion cancelled by user
  fceWrongFileType = FCE(-14); // wrong file type for this converter

  CTwipsPerInch = 1440;
  CTwipsPerPoint = 20;
  CHundredthMMPerInch = 2540;
  CPointsPerInch = 72;

  RichEdit10ModuleName = 'RICHED32.DLL';
  RichEdit20ModuleName = 'RICHED20.DLL';
  {>>>}
  RichEditNewModuleName = 'MSFTEDIT.DLL';
  {<<<}

  FT_DOWN = 1;

  // PARAFORMAT2 wNumberingStyle options
  PFNS_PAREN = $0000; // default, e.g., 1)
  PFNS_PARENS = $0100; // tomListParentheses/256, e.g., (1)
  PFNS_PERIOD = $0200; // tomListPeriod/256, e.g., 1.
  PFNS_PLAIN = $0300; // tomListPlain/256, e.g., 1
  PFNS_NONUMBER = $0400; // Used for continuation w/o number
  PFNS_NEWNUMBER = $8000; // Start new number with wNumberingStart

  // (can be combined with other PFNS_xxx)

  EM_GETBIDIOPTIONS = (WM_USER + 200);
  EM_SETBIDIOPTIONS = (WM_USER + 201);
  EM_SETTYPOGRAPHYOPTIONS = (WM_USER + 202);
  EM_GETTYPOGRAPHYOPTIONS = (WM_USER + 203);

  // Options for EM_SETTYPOGRAPHYOPTIONS

  TO_ADVANCEDTYPOGRAPHY = 1;
  TO_SIMPLELINEBREAK = 2;
  TO_DISABLECUSTOMTEXTOUT = 4;
  TO_ADVANCEDLAYOUT = 8;

  // Options for EM_GET/EM_SET TYPOGRAPHYOPTIONS
  BOM_DEFPARADIR        = $0001;   // Default paragraph direction (implies alignment) (obsolete)
  BOM_PLAINTEXT         = $0002;   // Use plain text layout (obsolete)
  BOM_NEUTRALOVERRIDE   = $0004;   // Override neutral layout (obsolete)
  BOM_CONTEXTREADING    = $0008;   // Context reading order
  BOM_CONTEXTALIGNMENT  = $0010;   // Context alignment

  BOE_RTLDIR            = $0001;   // Default paragraph direction (implies alignment) (obsolete)
  BOE_PLAINTEXT         = $0002;   // Use plain text layout (obsolete)
  BOE_NEUTRALOVERRIDE   = $0004;   // Override neutral layout (obsolete)
  BOE_CONTEXTREADING    = $0008;   // Context reading order
  BOE_CONTEXTALIGNMENT  = $0010;   // Context alignment



  // Underline types. RE 1.0 displays only CFU_UNDERLINE
  CFU_CF1UNDERLINE = $FF; // Map charformat's bit underline to CF2
  CFU_INVERT = $FE; // For IME composition fake a selection
  CFU_UNDERLINETHICKLONGDASH = 18; // (*) display as dash
  CFU_UNDERLINETHICKDOTTED = 17; // (*) display as dot
  CFU_UNDERLINETHICKDASHDOTDOT = 16; // (*) display as dash dot dot
  CFU_UNDERLINETHICKDASHDOT = 15; // (*) display as dash dot
  CFU_UNDERLINETHICKDASH = 14; // (*) display as dash
  CFU_UNDERLINELONGDASH = 13; // (*) display as dash
  CFU_UNDERLINEHEAVYWAVE = 12; // (*) display as wave
  CFU_UNDERLINEDOUBLEWAVE = 11; // (*) display as wave
  CFU_UNDERLINEHAIRLINE = 10; // (*) display as single
  CFU_UNDERLINETHICK = 9;
  CFU_UNDERLINEWAVE = 8;
  CFU_UNDERLINEDASHDOTDOT = 7;
  CFU_UNDERLINEDASHDOT = 6;
  CFU_UNDERLINEDASH = 5;
  CFU_UNDERLINEDOTTED = 4;
  CFU_UNDERLINEDOUBLE = 3; // (*) display as single
  CFU_UNDERLINEWORD = 2; // (*) display as single
  CFU_UNDERLINE = 1;
  CFU_UNDERLINENONE = 0;

  AttrFlags: array[TJvAttributeType] of Word =
    (0, SCF_SELECTION, SCF_WORD or SCF_SELECTION);

  CF_EMBEDDEDOBJECT = 'Embedded Object';
  CF_LINKSOURCE = 'Link Source';

  EM_GETZOOM = (WM_USER + 224);
  EM_SETZOOM = (WM_USER + 225);

  // Some masks for tab alignment and leader handling
  // Note: not the official names which I don't know

  TA_ALIGNMENT = $0F000000; // Bits 24-27
  TA_LEADER = $F0000000; // Bits 28-31
  //TA_ALL       = $FF000000; // Bits 24-31
  TA_TAB = $00FFFFFF; // Tab: bits 0-23
  TA_TAB_LEADER = (TA_TAB or TA_LEADER);
  TA_TAB_ALIGNMENT = (TA_TAB or TA_ALIGNMENT);

  { Flags to specify which interfaces should be returned in the structure above }

  REO_GETOBJ_NO_INTERFACES = $00000000;
  REO_GETOBJ_POLEOBJ = $00000001;
  REO_GETOBJ_PSTG = $00000002;
  REO_GETOBJ_POLESITE = $00000004;
  REO_GETOBJ_ALL_INTERFACES = $00000007;

  { Place object at selection }

  REO_CP_SELECTION = ULONG(-1);

  { Use character position to specify object instead of index }

  REO_IOB_SELECTION = ULONG(-1);
  REO_IOB_USE_CP = ULONG(-2);

  { Object flags }

  REO_NULL = $00000000; { No flags                         }
  REO_READWRITEMASK = $0000003F; { Mask out RO bits                 }
  REO_DONTNEEDPALETTE = $00000020; { Object doesn't need palette      }
  REO_BLANK = $00000010; { Object is blank                  }
  REO_DYNAMICSIZE = $00000008; { Object defines size always       }
  REO_INVERTEDSELECT = $00000004; { Object drawn all inverted if sel }
  REO_BELOWBASELINE = $00000002; { Object sits below the baseline   }
  REO_RESIZABLE = $00000001; { Object may be resized            }
  REO_LINK = $80000000; { Object is a link (RO)            }
  REO_STATIC = $40000000; { Object is static (RO)            }
  REO_SELECTED = $08000000; { Object selected (RO)             }
  REO_OPEN = $04000000; { Object open in its server (RO)   }
  REO_INPLACEACTIVE = $02000000; { Object in place active (RO)      }
  REO_HILITED = $01000000; { Object is to be hilited (RO)     }
  REO_LINKAVAILABLE = $00800000; { Link believed available (RO)     }
  REO_GETMETAFILE = $00400000; { Object requires metafile (RO)    }

  { Flags for IRichEditOle.GetClipboardData,   }
  { IRichEditOleCallback.GetClipboardData and  }
  { IRichEditOleCallback.QueryAcceptData       }

  RECO_PASTE = $00000000; { paste from clipboard  }
  RECO_DROP  = $00000001; { drop                  }
  RECO_COPY  = $00000002; { copy to the clipboard }
  RECO_CUT   = $00000003; { cut to the clipboard  }
  RECO_DRAG  = $00000004; { drag                  }

  ReadError = $0001;
  WriteError = $0002;
  NoError = $0000;

  RichLangOptions: array[TRichLangOption] of DWORD = (IMF_AUTOKEYBOARD,
    IMF_AUTOFONT, IMF_IMECANCELCOMPLETE, IMF_IMEALWAYSSENDNOTIFY);

  CHex: array[0..$F] of AnsiChar =
  ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'A', 'B', 'C', 'D', 'E', 'F');

  { Converter API names }

  ForeignToRtf32Name = 'ForeignToRtf32';
  InitConverter32Name = 'InitConverter32';
  IsFormatCorrect32Name = 'IsFormatCorrect32';
  RtfToForeign32Name = 'RtfToForeign32';
  UninitConverterName = 'UninitConverter';
  CchFetchLpszErrorName = 'CchFetchLpszError';

  CConvertBufferSize = $1004;

var
  { Clipboard formats }
  CFEmbeddedObject: Integer;
  CFLinkSource: Integer;
  CFRtf: Integer;
  CFRtfNoObjs: Integer;

  { Global converter vars }
  GlobalConversionFormatList: TConversionFormatList = nil;
  GCurrentConverter: TJvMSTextConversion = nil;
  GMSTextConvertersRegistered: Boolean;

  Painting: Boolean = False;

//=== Local procedures =======================================================

function GConversionFormatList: TConversionFormatList;
begin
  if not Assigned(GlobalConversionFormatList) then
    GlobalConversionFormatList := TConversionFormatList.Create;
  Result := GlobalConversionFormatList;
end;

function GetParentWindow(Control: TControl): THandle;
begin
  if Control <> nil then
    Control := GetParentForm(Control);

  if Control is TWinControl then
    Result := TWinControl(Control).Handle
  else
    Result := Application.Handle;
end;

{ OLE utility routines }

function WStrLen(Str: PWideChar): Integer;
begin
  Result := 0;
  while Str[Result] <> #0 do
    Inc(Result);
end;

procedure ReleaseObject(var Obj);
begin
  if IUnknown(Obj) <> nil then
  begin
    IUnknown(Obj) := nil;
  end;
end;

procedure CreateStorage(var Storage: IStorage);
var
  LockBytes: ILockBytes;
begin
  OleCheck(CreateILockBytesOnHGlobal(0, True, LockBytes));
  try
    OleCheck(StgCreateDocfileOnILockBytes(LockBytes,
      STGM_READWRITE or STGM_SHARE_EXCLUSIVE or STGM_CREATE, 0, Storage));
  finally
    ReleaseObject(LockBytes);
  end;
end;

procedure DestroyMetaPict(MetaPict: HGLOBAL);
begin
  if MetaPict <> 0 then
  begin
    DeleteMetaFile(PMetafilePict(GlobalLock(MetaPict))^.hMF);
    GlobalUnlock(MetaPict);
    GlobalFree(MetaPict);
  end;
end;

function OleSetDrawAspect(OleObject: IOleObject; Iconic: Boolean;
  IconMetaPict: HGLOBAL; var DrawAspect: Longint): HRESULT;
var
  OleCache: IOleCache;
  EnumStatData: IEnumStatData;
  OldAspect, AdviseFlags, Connection: Longint;
  TempMetaPict: HGLOBAL;
  FormatEtc: TFormatEtc;
  Medium: TStgMedium;
  ClassID: TCLSID;
  StatData: TStatData;
begin
  Result := S_OK;
  OldAspect := DrawAspect;
  if Iconic then
  begin
    DrawAspect := DVASPECT_ICON;
    AdviseFlags := ADVF_NODATA;
  end
  else
  begin
    DrawAspect := DVASPECT_CONTENT;
    AdviseFlags := ADVF_PRIMEFIRST;
  end;
  if (DrawAspect <> OldAspect) or (DrawAspect = DVASPECT_ICON) then
  begin
    Result := OleObject.QueryInterface(IOleCache, OleCache);
    if Succeeded(Result) then
    try
      if DrawAspect <> OldAspect then
      begin
        { Setup new cache with the new aspect }
        FillChar(FormatEtc, SizeOf(FormatEtc), 0);
        FormatEtc.dwAspect := DrawAspect;
        FormatEtc.lindex := -1;
        Result := OleCache.Cache(FormatEtc, AdviseFlags, Connection);
      end;
      if Succeeded(Result) and (DrawAspect = DVASPECT_ICON) then
      begin
        TempMetaPict := 0;
        if IconMetaPict = 0 then
        begin
          if Succeeded(OleObject.GetUserClassID(ClassID)) then
          begin
            TempMetaPict := OleGetIconOfClass(ClassID, nil, True);
            IconMetaPict := TempMetaPict;
          end;
        end;
        try
          FormatEtc.cfFormat := CF_METAFILEPICT;
          FormatEtc.ptd := nil;
          FormatEtc.dwAspect := DVASPECT_ICON;
          FormatEtc.lindex := -1;
          FormatEtc.tymed := TYMED_MFPICT;
          Medium.tymed := TYMED_MFPICT;
          Medium.hMetaFilePict := IconMetaPict;
          Medium.unkForRelease := nil;
          Result := OleCache.SetData(FormatEtc, Medium, False);
        finally
          DestroyMetaPict(TempMetaPict);
        end;
      end;
      if Succeeded(Result) and (DrawAspect <> OldAspect) then
      begin
        { remove any existing caches that are set up for the old display aspect }
        OleCache.EnumCache(EnumStatData);
        if EnumStatData <> nil then
        try
          while EnumStatData.Next(1, StatData, nil) = 0 do
            if StatData.FormatEtc.dwAspect = OldAspect then
              OleCache.Uncache(StatData.dwConnection);
        finally
          ReleaseObject(EnumStatData);
        end;
      end;
    finally
      ReleaseObject(OleCache);
    end;
    if Succeeded(Result) and (DrawAspect <> DVASPECT_ICON) then
      OleObject.Update;
  end;
end;

function GetIconMetaPict(OleObject: IOleObject; DrawAspect: Longint): HGLOBAL;
var
  DataObject: IDataObject;
  FormatEtc: TFormatEtc;
  Medium: TStgMedium;
  ClassID: TCLSID;
begin
  Result := 0;
  if DrawAspect = DVASPECT_ICON then
  begin
    OleObject.QueryInterface(IDataObject, DataObject);
    if DataObject <> nil then
    begin
      FormatEtc.cfFormat := CF_METAFILEPICT;
      FormatEtc.ptd := nil;
      FormatEtc.dwAspect := DVASPECT_ICON;
      FormatEtc.lindex := -1;
      FormatEtc.tymed := TYMED_MFPICT;
      if Succeeded(DataObject.GetData(FormatEtc, Medium)) then
        Result := Medium.hMetaFilePict;
      ReleaseObject(DataObject);
    end;
  end;
  if Result = 0 then
  begin
    OleCheck(OleObject.GetUserClassID(ClassID));
    Result := OleGetIconOfClass(ClassID, nil, True);
  end;
end;

{ Return the first piece of a moniker }

function OleStdGetFirstMoniker(Moniker: IMoniker): IMoniker;
var
  Mksys: Longint;
  EnumMoniker: IEnumMoniker;
begin
  Result := nil;
  if Moniker <> nil then
  begin
    if (Moniker.IsSystemMoniker(Mksys) = 0) and
      (Mksys = MKSYS_GENERICCOMPOSITE) then
    begin
      if Moniker.Enum(True, EnumMoniker) <> 0 then
        Exit;
      EnumMoniker.Next(1, Result, nil);
      ReleaseObject(EnumMoniker);
    end
    else
    begin
      Result := Moniker;
    end;
  end;
end;

{ Return length of file moniker piece of the given moniker }

function OleStdGetLenFilePrefixOfMoniker(Moniker: IMoniker): Integer;
var
  MkFirst: IMoniker;
  BindCtx: IBindCtx;
  Mksys: Longint;
  P: PWideChar;
begin
  Result := 0;
  if Moniker <> nil then
  begin
    MkFirst := OleStdGetFirstMoniker(Moniker);
    if MkFirst <> nil then
    begin
      if (MkFirst.IsSystemMoniker(Mksys) = 0) and
        (Mksys = MKSYS_FILEMONIKER) then
      begin
        if CreateBindCtx(0, BindCtx) = 0 then
        begin
          if (MkFirst.GetDisplayName(BindCtx, nil, P) = 0) and (P <> nil) then
          begin
            Result := WStrLen(P);
            CoTaskMemFree(P);
          end;
          ReleaseObject(BindCtx);
        end;
      end;
      ReleaseObject(MkFirst);
    end;
  end;
end;

function CoAllocCStr(const S: string): PChar;
begin
  Result := StrCopy(CoTaskMemAlloc(Length(S) * SizeOf(Char) + 1), PChar(S));
end;

function WStrToString(P: PWideChar): string;
begin
  Result := '';
  if P <> nil then
  begin
    Result := WideCharToString(P);
    CoTaskMemFree(P);
  end;
end;

function GetFullNameStr(OleObject: IOleObject): string;
var
  P: PWideChar;
begin
  OleObject.GetUserType(USERCLASSTYPE_FULL, P);
  Result := WStrToString(P);
end;

function GetShortNameStr(OleObject: IOleObject): string;
var
  P: PWideChar;
begin
  OleObject.GetUserType(USERCLASSTYPE_SHORT, P);
  Result := WStrToString(P);
end;

function GetDisplayNameStr(OleLink: IOleLink): string;
var
  P: PWideChar;
begin
  OleLink.GetSourceDisplayName(P);
  Result := WStrToString(P);
end;

function GetVCLFrameForm(Form: TCustomForm): IVCLFrameForm;
begin
  if Form.OleFormObject = nil then
    TOleForm.Create(Form);
  Result := Form.OleFormObject as IVCLFrameForm;
end;

function IsFormMDIChild(Form: TCustomForm): Boolean;
begin
  Result := (Form is TForm) and (TForm(Form).FormStyle = fsMDIChild);
end;

procedure LinkError(const Ident: string);
begin
  Application.MessageBox(PChar(Ident), PChar(SLinkProperties),
    MB_OK or MB_ICONSTOP);
end;

{ Get RichEdit OLE interface }

function GetRichEditOle(Wnd: HWND; var RichEditOle): Boolean;
begin
  Result := SendMessage(Wnd, EM_GETOLEINTERFACE, 0, LPARAM(@RichEditOle)) <> 0;
end;

function StreamSave(dwCookie: {$IFDEF COMPILER19_UP}DWORD_PTR{$ELSE}Longint{$ENDIF}; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Converter: TJvConversion;
begin
  Result := NoError;
  Converter := TJvConversion(dwCookie);
  try
    pcb := 0;
    if Converter <> nil then
      pcb := Converter.ConvertWrite({$IFNDEF COMPILER12_UP}PAnsiChar{$ENDIF !COMPILER12_UP}(pbBuff), cb);
  except
    Result := WriteError;
  end;
end;

type
  TCookie = class
  private
    FConverter: TJvConversion;
    FSkipLf, FSkipCr: Boolean;
    // SourceLength is number of characters
    function AdjustLineBreaks(Dest, Source: PAnsiChar; SourceLength: Integer): Integer;
    function AdjustLineBreaksW(Dest, Source: PWideChar; SourceLength: Integer): Integer;
  public
    constructor Create(AConverter: TJvConversion);
    // BufferSize is the size of the Buffer in bytes
    function Load(Buffer: PByte; BufferSize: Longint): Longint;
    function LoadW(Buffer: PByte; BufferSize: Longint): Longint;
    property Converter: TJvConversion read FConverter;
  end;

{ AdjustLineBreaks adjusts all line breaks in the given string S to be true
  #13/#10 sequences. The function changes any #13 characters not followed by a #10
  and any #10 characters not preceded by a #13 into #13/#10 pairs. It also
  converts #10/#13 pairs to #13/#10 pairs. The #10/#13 pair is common in Unix text
  files. (SysUtils)
}

function TCookie.AdjustLineBreaks(Dest, Source: PAnsiChar; SourceLength: Integer): Integer;
var
  SourceEnd: PAnsiChar;
  DestStart: PAnsiChar;
begin
  SourceEnd := Source + SourceLength;
  DestStart := Dest;
  while Source < SourceEnd do
  begin
    case Source^ of
      Lf:
        if FSkipLf then
          FSkipLf := False
        else
        begin
          Dest^ := Cr;
          Inc(Dest);
          Dest^ := Lf;
          Inc(Dest);
          FSkipCr := True;
        end;
      Cr:
        if FSkipCr then
          FSkipCr := False
        else
        begin
          Dest^ := Cr;
          Inc(Dest);
          Dest^ := Lf;
          Inc(Dest);
          FSkipLf := True;
        end;
    else
      FSkipCr := False;
      FSkipLf := False;
      Dest^ := Source^;
      Inc(Dest);
    end;
    Inc(Source);
  end;
  Result := Dest - DestStart;
end;

function TCookie.AdjustLineBreaksW(Dest, Source: PWideChar;
  SourceLength: Integer): Integer;
var
  SourceEnd: PWideChar;
  DestStart: PWideChar;
begin
  SourceEnd := Source + SourceLength;
  DestStart := Dest;
  while Source < SourceEnd do
  begin
    case Source^ of
      #10:
        if FSkipLf then
          FSkipLf := False
        else
        begin
          Dest^ := #13;
          Inc(Dest);
          Dest^ := #10;
          Inc(Dest);
          FSkipCr := True;
        end;
      #13:
        if FSkipCr then
          FSkipCr := False
        else
        begin
          Dest^ := #13;
          Inc(Dest);
          Dest^ := #10;
          Inc(Dest);
          FSkipLf := True;
        end;
    else
      FSkipCr := False;
      FSkipLf := False;
      Dest^ := Source^;
      Inc(Dest);
    end;
    Inc(Source);
  end;
  Result := Dest - DestStart;
end;

constructor TCookie.Create(AConverter: TJvConversion);
begin
  inherited Create;
  FConverter := AConverter;
end;

function TCookie.Load(Buffer: PByte; BufferSize: Longint): Longint;
var
  pBuff: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
begin
  BufferSize := BufferSize div 2;
  Result := 0;
  pBuff := {$IFNDEF COMPILER12_UP}PAnsiChar{$ENDIF !COMPILER12_UP}(Buffer) + BufferSize;
  if Converter <> nil then
    Result := Converter.ConvertRead(pBuff, BufferSize);
  if Result > 0 then
    Result := AdjustLineBreaks(PAnsiChar(Buffer), PAnsiChar(pBuff), Result);
end;

function TCookie.LoadW(Buffer: PByte; BufferSize: Integer): Longint;
var
  pBuff: PWideChar;
begin
  // AdjustLineBreaksW can double the needed buffer size; so tell the converter
  // to use only half the buffer and (Mantis #4129) ensure BufferSize is even.
  BufferSize := (BufferSize div 4) * 2;
  Result := 0;
  pBuff := PWideChar(Buffer) + BufferSize div 2;
  if Converter <> nil then
    Result := Converter.ConvertRead({$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}(pBuff), BufferSize);
  if Result > 0 then
    Result := 2 * AdjustLineBreaksW(PWideChar(Buffer), PWideChar(pBuff), Result div 2);
end;

function StreamLoad(dwCookie: {$IFDEF COMPILER19_UP}DWORD_PTR{$ELSE}Longint{$ENDIF}; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
begin
  Result := NoError;
  try
    pcb := TCookie(dwCookie).Load(pbBuff, cb);
  except
    Result := ReadError;
  end;
end;

function StreamLoadW(dwCookie: {$IFDEF COMPILER19_UP}DWORD_PTR{$ELSE}Longint{$ENDIF}; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
begin
  Result := NoError;
  try
    pcb := TCookie(dwCookie).LoadW(pbBuff, cb);
  except
    Result := ReadError;
  end;
end;

function FileNameToHGLOBAL(const AFileName: AnsiString): HGLOBAL;
var
  DataPtr: Pointer;
  Buffer: array[0..MAX_PATH] of AnsiChar;
  Len: Integer;
begin
  // DOC : Each entry point that accepts file names should expect all file name
  //       arguments from Word to be in the OEM character set (unless the character
  //       set is explicitly negotiated using RegisterApp).
  //
  //  For example: CharToOem will translate the copyright (c) symbol (=1 char)
  //  to C¸ (or something). Not doing so will result in errors.

  StrLCopyA(Buffer, PAnsiChar(AFileName), Length(Buffer));
  CharToOemA(Buffer, Buffer);

  Len := StrLenA(Buffer);
  Result := GlobalAlloc(GHND, Len + 1); // with last #0, thus + 1
  try
    DataPtr := GlobalLock(Result);
    try
      StrLCopyA(DataPtr, Buffer, Len);
    finally
      GlobalUnlock(Result);
    end;
  except
    GlobalFree(Result);
    raise;
  end;
end;

function AnsiStringToHGLOBAL(const S: AnsiString): HGLOBAL;
var
  DataPtr: Pointer;
  Size: Integer;
begin
  Size := Length(S) + 1; // with last #0, thus + 1
  Result := GlobalAlloc(GHND, Size);
  try
    DataPtr := GlobalLock(Result);
    try
      Move(PAnsiChar(S)^, DataPtr^, Size);
    finally
      GlobalUnlock(Result);
    end;
  except
    GlobalFree(Result);
    raise;
  end;
end;

function ExportCallback(cchBuff, nPercent: Longint): Longint; stdcall;
begin
  Result := GCurrentConverter.HandleExportCallback(cchBuff, nPercent);
end;

function ImportCallback(cchBuff, nPercent: Longint): Longint; stdcall;
begin
  Result := GCurrentConverter.HandleImportCallback(cchBuff, nPercent);
end;

function FCEToString(AErrorCode: FCE): string;
begin
  case AErrorCode of
    fceOpenInFileErr: Result := RsEOpenInFileErr;
    fceReadErr: Result := RsEReadErr;
    fceOpenConvErr: Result := RsEOpenConvErr;
    fceWriteErr: Result := RsEWriteErr;
    fceInvalidFile: Result := RsEInvalidFile;
    fceOpenExceptErr: Result := RsEOpenExceptErr;
    fceWriteExceptErr: Result := RsEWriteExceptErr;
    fceNoMemory: Result := RsENoMemory;
    fceInvalidDoc: Result := RsEInvalidDoc;
    fceDiskFull: Result := RsEDiskFull;
    fceDocTooLarge: Result := RsEDocTooLarge;
    fceOpenOutFileErr: Result := RsEOpenOutFileErr;
    fceUserCancel: Result := RsEUserCancel;
    fceWrongFileType: Result := RsEWrongFileType;
  else
    Result := '';
  end;
end;

//=== Global procedures ======================================================

procedure BitmapToRTF(ABitmap: TBitmap; AStream: TStream);
const
  CPrefix = '{\rtf1 {\pict\picw%d\pich%d\dibitmap0 ';
  CPostfix = AnsiString(' }}');
var
  Header, Bits: PAnsiChar;
  HeaderSize, BitsSize: DWORD;
  P, Q: PAnsiChar;
  S: AnsiString;
begin
  GetDIBSizes(ABitmap.Handle, HeaderSize, BitsSize);
  GetMem(Header, 2 * (HeaderSize + BitsSize));
  try
    Bits := Header + HeaderSize;
    GetDIB(ABitmap.Handle, ABitmap.Palette, Header^, Bits^);

    { Example :

      HeaderSize = 2, BitsSize = 2

      Header = $AB, $00, $DE, $F8, ?? , ?? , ?? , ??
      ->
      Header = 'A', 'B', '0', '0', 'D', 'E', 'F', '8'
    }
    Q := Header + HeaderSize + BitsSize - 1;
    //P := Header + 2 * (HeaderSize + BitsSize) - 1;
    P := Q + HeaderSize + BitsSize;
    while Q >= Header do
    begin
      P^ := CHex[Byte(Q^) mod 16];
      Dec(P);
      P^ := CHex[Byte(Q^) div 16];
      Dec(P);
      Dec(Q);
    end;
    S := AnsiString(Format(CPrefix, [ABitmap.Width, ABitmap.Height]));
    AStream.Write(PAnsiChar(S)^, Length(S));
    AStream.Write(Header^, (HeaderSize + BitsSize) * 2);
    AStream.Write(CPostfix, Length(CPostfix));
  finally
    FreeMem(Header);
  end;
end;

function BitmapToRTF2(ABitmap: TBitmap; AStream: TStream): Boolean;

{

  \wmetafileN  - Source of the picture is a Windows metafile. The N argument
                 identifies the metafile type (the default type is 1).
  \picwN       - xExt field if the picture is a Windows metafile; picture
                 width in pixels if the picture is a bitmap or from QuickDraw.
                 The N argument is a long integer.
  \pichN       - yExt field if the picture is a Windows metafile; picture
                 height in pixels if the picture is a bitmap or from QuickDraw.
                 The N argument is a long integer.
  \picwgoalN   - Desired width of the picture in twips. The N argument is a
                 long integer.
  \pichgoalN   - Desired height of the picture in twips. The N argument is a
                 long integer.
}

const
  CPrefix = '{\rtf1 {\pict\wmetafile8\picw%d\pich%d\picwgoal%d\pichgoal%d ';
  CPostfix = AnsiString(' }}');
var
  P, Q: PAnsiChar;
  S: AnsiString;
  DC: HDC;
  MetafileHandle: HMETAFILE;
  Size: TPoint;
  BitsLength: UINT;
  Bits: PAnsiChar;
begin
  Result := False;

  // Retrieve Extent
  Size.X := MulDiv(ABitmap.Width, CHundredthMMPerInch, Screen.PixelsPerInch);
  Size.Y := MulDiv(ABitmap.Height, CHundredthMMPerInch, Screen.PixelsPerInch);

  // Create Metafile DC and set it up
  DC := CreateMetafile(nil);

  SetWindowOrgEx(DC, 0, 0, nil);
  SetWindowExtEx(DC, Size.X, Size.Y, nil);

  StretchBlt(DC, 0, 0, Size.X, Size.Y,
    ABitmap.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, SRCCOPY);

  MetafileHandle := CloseMetaFile(DC);

  if MetafileHandle = 0 then
    Exit;

  try
    BitsLength := GetMetaFileBitsEx(MetafileHandle, 0, nil);
    GetMem(Bits, BitsLength * 2);
    try
      if GetMetaFileBitsEx(MetafileHandle, BitsLength, Bits) < BitsLength then
        Exit;

      Q := Bits + BitsLength - 1;
      //P := Bits + 2 * BitsLength - 1;
      P := Q + BitsLength;
      while Q >= Bits do
      begin
        P^ := CHex[Byte(Q^) mod 16];
        Dec(P);
        P^ := CHex[Byte(Q^) div 16];
        Dec(P);
        Dec(Q);
      end;

      S := AnsiString(Format(CPrefix, [Size.X, Size.Y,
        MulDiv(ABitmap.Width, CTwipsPerInch, Screen.PixelsPerInch),
          MulDiv(ABitmap.Height, CTwipsPerInch, Screen.PixelsPerInch)]));
      AStream.Write(PAnsiChar(S)^, Length(S));
      AStream.Write(Bits^, BitsLength * 2);
      AStream.Write(CPostfix, Length(CPostfix));

      Result := True;
    finally
      FreeMem(Bits, BitsLength * 2);
    end;
  finally
    DeleteMetaFile(MetafileHandle);
  end;
end;

//=== { EMSTextConversionError } =============================================

constructor EMSTextConversionError.Create(const Msg: string; AErrorCode: FCE);
var
  S: string;
begin
  S := Msg;
  if S = '' then
  begin
    S := FCEToString(AErrorCode);
    if S = '' then
      S := Format(RsEConversionError, [AErrorCode]);
  end;
  inherited Create(S);
  FErrorCode := AErrorCode;
end;

//=== { TConversionFormatList } ==============================================

constructor TConversionFormatList.Create;
begin
  inherited Create;
  FRTFConvIndex := Add(TJvRTFConversion.Create);
  FTextConvIndex := Add(TJvTextConversion.Create);
end;

function TConversionFormatList.DefaultConverter: TJvConversion;
begin
  Result := Items[FRTFConvIndex];
end;

function TConversionFormatList.GetConverter(
  AParentWindow: THandle; AStream: TStream;
  const Kind: TJvConversionKind): TJvConversion;
begin
  { Return either the RTF converter or the text converter }
  Result := Items[FRTFConvIndex];
  Result.Init(AParentWindow);
  if Result.CanHandle(Kind) and
    ((Kind <> ckImport) or Result.IsFormatCorrect(AStream)) then
    { Caller must call Done }
    Exit;
  Result.Done;

  Result := Items[FTextConvIndex];
  Result.Init(AParentWindow);
end;

function TConversionFormatList.GetConverter(AParentWindow: THandle;
  const AFileName: string; const Kind: TJvConversionKind): TJvConversion;
var
  Ext: string;
  I: Integer;
begin
  Ext := AnsiLowerCase(ExtractFileExt(AFileName));
  System.Delete(Ext, 1, 1);

  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    Result.Init(AParentWindow);
    if Result.CanHandle(Ext, Kind) and
      ((Kind <> ckImport) or Result.IsFormatCorrect(AFileName)) then
      { Caller must call Done }
      Exit;
    Result.Done;
  end;
  Result := nil;
end;

function TConversionFormatList.GetFilter(const AKind: TJvConversionKind): string;
var
  I: Integer;
begin
  Result := '';

  for I := 0 to Count - 1 do
    if Items[I].CanHandle(AKind) then
      Result := Result + Items[I].Filter + '|';

  if Result > '' then
    System.Delete(Result, Length(Result), 1);
end;

function TConversionFormatList.GetItem(Index: Integer): TJvConversion;
begin
  Result := inherited Items[Index] as TJvConversion;
end;

//=== { TImageDataObject } ===================================================

constructor TImageDataObject.Create(AGraphic: TGraphic);
begin
  inherited Create;
  FGraphic := AGraphic;
end;

function TImageDataObject.DAdvise(const FormatEtc: TFormatEtc;
  advf: Integer; const advSink: IAdviseSink;
  out dwConnection: Integer): HRESULT;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TImageDataObject.DUnadvise(dwConnection: Integer): HRESULT;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TImageDataObject.EnumDAdvise(
  out enumAdvise: IEnumStatData): HRESULT;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TImageDataObject.EnumFormatEtc(dwDirection: Integer;
  out EnumFormatEtc: IEnumFormatEtc): HRESULT;
begin
  EnumFormatEtc := nil;
  Result := E_NOTIMPL;
end;

function TImageDataObject.GetCanonicalFormatEtc(const FormatEtc: TFormatEtc;
  out FormatEtcOut: TFormatEtc): HRESULT;
begin
  FormatEtcOut.ptd := nil;
  Result := E_NOTIMPL;
end;

function TImageDataObject.GetData(const FormatEtcIn: TFormatEtc;
  out Medium: TStgMedium): HRESULT;
var
  SizeMetric: TPoint;
  Buffer: Pointer;
  Length: UINT;
  DC: HDC;
  hMF: HMETAFILE;
  hMem: THandle;
  pMFP: PMetafilePict;
begin
  // Handle only MetaFile
  if (FormatEtcIn.tymed and TYMED_MFPICT) = 0 then
  begin
    Result := DV_E_FORMATETC;
    Exit;
  end;
  if FGraphic is TMetafile then //Get a Win3x-style HMETAFILE handle
    with TMetafile(FGraphic) do //from a HENHMETAFILE one.
    begin
      SizeMetric.X := MMWidth;
      SizeMetric.Y := MMHeight;
      Buffer := nil;
      Length := 0;
      DC := GetDC(0);
      try
        Length := GetWinMetaFileBits(Handle, 0, nil, MM_ANISOTROPIC, DC);
        GetMem(Buffer, Length);
        if GetWinMetaFileBits(Handle, Length, Buffer,
             MM_ANISOTROPIC, DC) = Length then
          hMF := SetMetaFileBitsEx(Length, Buffer)
        else
          hMF := 0;
      finally
        if Buffer <> nil then
          FreeMem(Buffer, Length);
        ReleaseDC(0, DC);
      end;
    end
  else
  begin
    // convert pixels to mm
    SizeMetric.X := MulDiv(FGraphic.Width,
      cHundredthMMPerInch, Screen.PixelsPerInch);
    SizeMetric.Y := MulDiv(FGraphic.Height,
      cHundredthMMPerInch, Screen.PixelsPerInch);
    // Create Metafile DC and set it up
    DC := CreateMetafile(nil);
    SetWindowOrgEx(DC, 0, 0, nil);
    SetWindowExtEx(DC, SizeMetric.X, SizeMetric.Y, nil);

    if FGraphic.ClassType = TIcon then
      DrawIconEx(DC, 0, 0, TIcon(FGraphic).Handle, SizeMetric.X, SizeMetric.Y,
        0, 0, DI_NORMAL)
    else
      with TCanvas.Create do
      try
        Handle := DC;
        StretchDraw(Rect(0, 0, SizeMetric.X, SizeMetric.Y), FGraphic);
      finally
        Free;
      end;
    hMF := CloseMetaFile(DC);
  end;
  if hMF = 0 then
  begin
    Result := E_UNEXPECTED;
    Exit;
  end;

  // Get memory handle
  hMem := GlobalAlloc(GMEM_SHARE or GMEM_MOVEABLE, SizeOf(METAFILEPICT));
  if hMem = 0 then
  begin
    DeleteMetaFile(hMF);
    Result := STG_E_MEDIUMFULL;
    Exit;
  end;
  pMFP := PMetafilePict(GlobalLock(hMem));
  pMFP^.hMF := hMF;
  pMFP^.mm := MM_ANISOTROPIC;
  pMFP^.xExt := SizeMetric.X;
  pMFP^.yExt := SizeMetric.Y;
  GlobalUnlock(hMem);

  Medium.tymed := TYMED_MFPICT;
  Medium.hGlobal := hMem;
  Medium.unkForRelease := nil;

  Result := S_OK;
end;

function TImageDataObject.GetDataHere(const FormatEtc: TFormatEtc;
  out Medium: TStgMedium): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TImageDataObject.QueryGetData(const FormatEtc: TFormatEtc): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TImageDataObject.SetData(const FormatEtc: TFormatEtc;
  var Medium: TStgMedium; fRelease: BOOL): HRESULT;
begin
  Result := E_NOTIMPL;
end;

//=== { TJvConversion } ======================================================

function TJvConversion.CanHandle(const AKind: TJvConversionKind): Boolean;
begin
  Result := True;
end;

function TJvConversion.CanHandle(const AExtension: string;
  const AKind: TJvConversionKind): Boolean;
begin
  Result := True;
end;

function TJvConversion.ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
begin
  Result := -1;
end;

function TJvConversion.ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
begin
  Result := -1;
end;

procedure TJvConversion.Done;
begin
  FParentWindow := 0;
end;

procedure TJvConversion.DoProgress(APercentDone: Integer);
begin
  if APercentDone < 0 then
    APercentDone := 0
  else
  if APercentDone > 100 then
    APercentDone := 100;
  if APercentDone <> FPercentDone then
  begin
    FPercentDone := APercentDone;
    if Assigned(FOnProgress) then
      FOnProgress(Self);
  end;
end;

function TJvConversion.Error: Boolean;
begin
  Result := False;
end;

function TJvConversion.ErrorStr: string;
begin
  Result := '';
end;

function TJvConversion.Filter: string;
begin
  Result := '';
end;

procedure TJvConversion.Init(AParentWindow: THandle);
begin
  FParentWindow := AParentWindow;
end;

function TJvConversion.IsFormatCorrect(const AFileName: string): Boolean;
begin
  Result := True;
end;

function TJvConversion.IsFormatCorrect(AStream: TStream): Boolean;
begin
  Result := True;
end;

function TJvConversion.Open(const AFileName: string;
  const AKind: TJvConversionKind): Boolean;
begin
  Result := False;
end;

function TJvConversion.Open(Stream: TStream;
  const AKind: TJvConversionKind): Boolean;
begin
  Result := False;
end;

function TJvConversion.Retry: Boolean;
begin
  Result := False;
end;

function TJvConversion.TextKind: TJvConversionTextKind;
begin
  Result := ctkRTF;
end;

function TJvConversion.UserCancel: Boolean;
begin
  Result := False;
end;

//=== { TJvCustomRichEdit } ==================================================

constructor TJvCustomRichEdit.Create(AOwner: TComponent);
var
  DC: HDC;
begin
  inherited Create(AOwner);
  { If you create a TJvRichEdit control at design-time the Text of the control
    will NOT be set to its Name because csSetCaption is excluded }
  // ControlStyle := ControlStyle + [csAcceptsControls] - [csSetCaption];
  ControlStyle := ControlStyle - [csSetCaption];
  IncludeThemeStyle(Self, [csNeedsBorderPaint]);
  FSelAttributes := TJvTextAttributes.Create(Self, atSelected);
  FDefAttributes := TJvTextAttributes.Create(Self, atDefaultText);
  FWordAttributes := TJvTextAttributes.Create(Self, atWord);
  FParagraph := TJvParaAttributes.Create(Self);
  FLines := TJvRichEditStrings.Create;
  TJvRichEditStrings(FLines).FRichEdit := Self;
  TabStop := True;
  Width := 185;
  Height := 89;
  AutoSize := False;
  DoubleBuffered := False;
  {$IFDEF COMPILER12_UP}
  ParentDoubleBuffered := False;
  {$ENDIF COMPILER12_UP}
  FAllowObjects := True;
  FAllowInPlace := True;
  FAutoVerbMenu := True;
  FHideSelection := True;
  FHideScrollBars := True;
  ScrollBars := ssBoth;
  FSelectionBar := True;
  FAutoAdvancedTypography := True;
  FOLEDragDrop := True;
  FLangOptions := [rlAutoFont];
  DC := GetDC(HWND_DESKTOP);
  FScreenLogPixels := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(HWND_DESKTOP, DC);
  DefaultConverter := nil;
  FOldParaAlignment := TParaAlignment(Alignment);
  FUndoLimit := 100;
  FAutoURLDetect := True;
  FWordSelection := True;
  with FClickRange do
  begin
    cpMin := -1;
    cpMax := -1;
  end;
  FForceUndo := True;
  FCallback := TRichEditOleCallback.Create(Self);
  FUseFixedPopup := True;
  Perform(CM_PARENTBIDIMODECHANGED, 0, 0);
end;

destructor TJvCustomRichEdit.Destroy;
begin
  FLastFind := nil;
  FSelAttributes.Free;
  FDefAttributes.Free;
  FWordAttributes.Free;
  FParagraph.Free;
  FLines.Free;
  FState.Free;
  FPopupVerbMenu.Free;
  FFindDialog.Free;
  FReplaceDialog.Free;
  inherited Destroy;
  { be sure that callback object is destroyed after inherited Destroy }
  TRichEditOleCallback(FCallback).Free;
end;

procedure TJvCustomRichEdit.AddFormatText(const S: string; const AFont: TFont);
begin
  InsertFormatText(GetTextLen, S, AFont);
end;

procedure TJvCustomRichEdit.AddFormatText(const S: string;
  FontStyle: TFontStyles; const FontName: string; const FontColor: TColor;
  FontHeight: Integer);
begin
  InsertFormatText(GetTextLen, S, FontStyle, FontName, FontColor, FontHeight);
end;

procedure TJvCustomRichEdit.AdjustFindDialogPosition(Dialog: TFindDialog);
var
  TextRect, R: TRect;
begin
  if Dialog.Handle = 0 then
    Exit;
  TextRect.TopLeft := ClientToScreen(GetCharPos(SelStart));
  TextRect.BottomRight := ClientToScreen(GetCharPos(SelStart + SelLength));
  Inc(TextRect.Bottom, 20);
  with Dialog do
  begin
    GetWindowRect(Handle, R);
    if PtInRect(R, TextRect.TopLeft) or PtInRect(R, TextRect.BottomRight) then
    begin
      if TextRect.Top > R.Bottom - R.Top + 20 then
        OffsetRect(R, 0, TextRect.Top - R.Bottom - 20)
      else
      begin
        if TextRect.Top + R.Bottom - R.Top < GetSystemMetrics(SM_CYSCREEN) then
          OffsetRect(R, 0, 40 + TextRect.Top - R.Top);
      end;
      Position := R.TopLeft;
    end;
  end;
end;

procedure TJvCustomRichEdit.Clear;
begin
  CloseObjects;
  inherited Clear;
  Modified := False;
end;

procedure TJvCustomRichEdit.ClearUndo;
begin
  SendMessage(Handle, EM_EMPTYUNDOBUFFER, 0, 0);
end;

procedure TJvCustomRichEdit.CloseActiveObject;
begin
  if FRichEditOle <> nil then
    IRichEditOle(FRichEditOle).InPlaceDeactivate;
end;

procedure TJvCustomRichEdit.CloseFindDialog(Dialog: TFindDialog);
begin
  if Assigned(FOnCloseFindDialog) then
    FOnCloseFindDialog(Self, Dialog);
end;

procedure TJvCustomRichEdit.CloseObjects;
var
  I: Integer;
  ReObject: TReObject;
begin
  if Assigned(FRichEditOle) then
  begin
    FillChar(ReObject, SizeOf(ReObject), 0);
    ReObject.cbStruct := SizeOf(ReObject);
    with IRichEditOle(FRichEditOle) do
    begin
      for I := GetObjectCount - 1 downto 0 do
        if Succeeded(GetObject(I, ReObject, REO_GETOBJ_POLEOBJ)) then
        begin
          if ReObject.dwFlags and REO_INPLACEACTIVE <> 0 then
            IRichEditOle(FRichEditOle).InPlaceDeactivate;
          ReObject.poleobj.Close(OLECLOSE_NOSAVE);
          ReleaseObject(ReObject.poleobj);
        end;
    end;
  end;
end;

procedure TJvCustomRichEdit.CMBiDiModeChanged(var Msg: TMessage);
var
  AParagraph: TParaFormat2;
  BiDiOptions: TBiDiOptions;
begin
  HandleNeeded; { we REALLY need the handle for BiDi }
  inherited;

  BiDiOptions.cbSize := SizeOf(BiDiOptions);
  BiDiOptions.wMask := BOM_NEUTRALOVERRIDE or BOM_CONTEXTREADING or BOM_CONTEXTALIGNMENT;
  BiDiOptions.wEffects := BOE_NEUTRALOVERRIDE or BOE_CONTEXTREADING or BOE_CONTEXTALIGNMENT;
  SendMessage(Handle, EM_SETBIDIOPTIONS, 0, LPARAM(@BiDiOptions));

  Paragraph.GetAttributes(AParagraph);
  AParagraph.dwMask := PFM_ALIGNMENT;
  AParagraph.wAlignment := Ord(Alignment) + 1;
  Paragraph.SetAttributes(AParagraph);
end;

// From JvRichEdit.pas by Sébastien Buysse

procedure TJvCustomRichEdit.CMDocWindowActivate(var Msg: TMessage);
begin
  if Assigned(FCallback) then
    with TRichEditOleCallback(FCallback) do
      if Assigned(FDocForm) and IsFormMDIChild(FDocForm.Form) then
      begin
        if Msg.WParam = 0 then
        begin
          FFrameForm.SetMenu(0, 0, 0);
          FFrameForm.ClearBorderSpace;
        end;
      end;
end;

procedure TJvCustomRichEdit.CMUIDeactivate(var Msg: TMessage);
begin
  if (GetParentForm(Self) <> nil) and Assigned(FRichEditOle) and
    (GetParentForm(Self).ActiveOleControl = Self) then
    {IRichEditOle(FRichEditOle).InPlaceDeactivate};
end;

procedure TJvCustomRichEdit.CNNotify(var Msg: TWMNotify);
var
  AMsg: TMessage;
begin
  with Msg do
    case NMHdr^.code of
      EN_SELCHANGE:
        SelectionChange;
      EN_REQUESTRESIZE:
        RequestSize(PReqSize(NMHdr)^.rc);
      EN_SAVECLIPBOARD:
        with PENSaveClipboard(NMHdr)^ do
          if not SaveClipboard(cObjectCount, cch) then
            Result := 1;
      EN_PROTECTED:
        with PENProtected(NMHdr)^ do
        begin
          AMsg.Msg := Msg;
          AMsg.WParam := WParam;
          AMsg.LParam := LParam;
          AMsg.Result := 0;
          if not ProtectChange(AMsg, chrg.cpMin, chrg.cpMax) then
            Result := 1;
        end;
      EN_LINK:
        with PENLink(NMHdr)^ do
        begin
          case Msg of
            WM_MOUSEMOVE:
              begin
                URLHover(GetTextRange(chrg.cpMin, chrg.cpMax));
              end;
            WM_RBUTTONDOWN:
              begin
                FClickRange := chrg;
                FClickBtn := mbRight;
              end;
            WM_RBUTTONUP:
              begin
                if (FClickBtn = mbRight) and (FClickRange.cpMin = chrg.cpMin) and
                  (FClickRange.cpMax = chrg.cpMax) then
                  URLClick(GetTextRange(chrg.cpMin, chrg.cpMax), mbRight);
                with FClickRange do
                begin
                  cpMin := -1;
                  cpMax := -1;
                end;
              end;
            WM_LBUTTONDOWN:
              begin
                FClickRange := chrg;
                FClickBtn := mbLeft;
              end;
            WM_LBUTTONUP:
              begin
                if (FClickBtn = mbLeft) and (FClickRange.cpMin = chrg.cpMin) and
                  (FClickRange.cpMax = chrg.cpMax) then
                  URLClick(GetTextRange(chrg.cpMin, chrg.cpMax), mbLeft);
                with FClickRange do
                begin
                  cpMin := -1;
                  cpMax := -1;
                end;
              end;
          end;
        end;
      EN_STOPNOUNDO:
        begin
          { cannot allocate enough memory to maintain the undo state }
        end;
    end;
end;

procedure TJvCustomRichEdit.ColorChanged;
begin
  inherited ColorChanged;
  SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(Color))
end;

procedure TJvCustomRichEdit.CreateParams(var Params: TCreateParams);
const
{>>>}
  MSFTEDIT_CLASS = 'RichEdit50W';
{<<<}
  HideScrollBars: array[Boolean] of DWORD = (ES_DISABLENOSCROLL, 0);
  HideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
  SelectionBars: array[Boolean] of DWORD = (0, ES_SELECTIONBAR);
  OLEDragDrops: array[Boolean] of DWORD = (ES_NOOLEDRAGDROP, 0);
begin
  inherited CreateParams(Params);
  case RichEditVersion of
    1:
      CreateSubClass(Params, RICHEDIT_CLASS10A);
{>>>}
    4:
      CreateSubClass(Params, MSFTEDIT_CLASS);
{<<<}
  else
    CreateSubClass(Params, RICHEDIT_CLASS);
  end;
  with Params do
  begin
    Style := (Style and not (WS_HSCROLL or WS_VSCROLL)) or ES_SAVESEL or
      (WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
    { NOTE: WS_CLIPCHILDREN and WS_CLIPSIBLINGS are essential otherwise }
    { once the object is inserted you see some painting problems.       }
    Style := Style and not (WS_HSCROLL or WS_VSCROLL);
    if ScrollBars in [ssVertical, ssBoth] then
      Style := Style or WS_VSCROLL;
    if (ScrollBars in [ssHorizontal, ssBoth]) and not WordWrap then
      Style := Style or WS_HSCROLL;
    Style := Style or OLEDragDrops[FOLEDragDrop] or HideScrollBars[FHideScrollBars] or
      SelectionBars[FSelectionBar] or HideSelections[FHideSelection] and
      not WordWraps[WordWrap];
    WindowClass.Style := WindowClass.Style {>>>and not}or{<<<} (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TJvCustomRichEdit.CreateWindowHandle(const Params: TCreateParams);
var
  Bounds: TRect;
begin
  Bounds := BoundsRect;
  inherited CreateWindowHandle(Params);
  if HandleAllocated then
    BoundsRect := Bounds;
end;

procedure TJvCustomRichEdit.CreateWnd;
var
  SavedAdvancedTypography: Boolean;
  SavedModified: Boolean;
  Mask: Longint;
begin
  SavedAdvancedTypography := AdvancedTypography;
  inherited CreateWnd;
  if (SysLocale.FarEast) and not (SysLocale.PriLangID = LANG_JAPANESE) then
    Font.Charset := GetDefFontCharSet;
  Mask := ENM_CHANGE or ENM_SELCHANGE or ENM_REQUESTRESIZE or ENM_PROTECTED;
  if RichEditVersion >= 2 then
    Mask := Mask or ENM_LINK;
  SendMessage(Handle, EM_SETEVENTMASK, 0, Mask);
  SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(Color));
  DoSetMaxLength(MaxLength);
  SetWordSelection(FWordSelection);
  if RichEditVersion >= 2 then
  begin
    SendMessage(Handle, EM_AUTOURLDETECT, WPARAM(FAutoURLDetect), 0);
    FUndoLimit := SendMessage(Handle, EM_SETUNDOLIMIT, FUndoLimit, 0);
    UpdateTextModes(PlainText);
    // GetAdvancedTypography returns now always false, because the handle
    // is recreated, so can't use property AdvancedTypography
    FAdvancedTypography := SavedAdvancedTypography;
    UpdateTypographyOptions(FAdvancedTypography);
    SetLangOptions(FLangOptions);
  end;
  if FAllowObjects then
  begin
    SendMessage(Handle, EM_SETOLECALLBACK, 0,
      LParam(TRichEditOleCallback(FCallback) as IRichEditOleCallback));
    GetRichEditOle(Handle, FRichEditOle);
    UpdateHostNames;
  end;

  if FState is TJvRichEditState then
    TJvRichEditState(FState).Restore(Self);
  FState.Free;
  FState := nil;
  if RichEditVersion < 2 then
  begin
    { (rb) This code is probably unnecessary; it only assigns Font to
      FDefAttributes, see WM_SETFONT handler; but that is also done in
      TWinControl.CreateWnd }
    SavedModified := Modified;
    { This changes the Modified property }
    SendMessage(Handle, WM_SETFONT, 0, 0);
    Modified := SavedModified;
  end;
end;

procedure TJvCustomRichEdit.DestroyWnd;
begin
  {$IFDEF DELPHI10_UP}
  if csRecreating in ControlState then
  begin
  {$ENDIF DELPHI10_UP}
    FState := TJvRichEditState.Create;
    TJvRichEditState(FState).ForcePlainText := csDesigning in ComponentState;
    TJvRichEditState(FState).Store(Self);
  {$IFDEF DELPHI10_UP}
  end;
  {$ENDIF DELPHI10_UP}
  inherited DestroyWnd;
end;

procedure TJvCustomRichEdit.DoConversionProgress(const AProgress: Integer);
begin
  if Assigned(FOnConversionProgress) then
    FOnConversionProgress(Self, AProgress);
end;

procedure TJvCustomRichEdit.DoSetMaxLength(Value: Integer);
begin
  { The rich edit control's default maximum amount of text is 32K }
  { Let's set it at 16M by default }
  if Value = 0 then
    Value := $FFFFFF;
  SendMessage(Handle, EM_EXLIMITTEXT, 0, Value);
end;

function TJvCustomRichEdit.DoQueryAcceptData(const ADataObject: IDataObject;
  var AFormat: TClipFormat; ClipboardOperationKind: Cardinal; Really: Boolean;
  IconMetaPict: HGLOBAL): Boolean;
begin
  Result := False;
  // ClipboardOperationKind is either RECO_DROP or RECO_PASTE
  case ClipboardOperationKind of
    RECO_PASTE: if not (caPaste in ClipboardCommands) then Result := True;
    RECO_DROP: ;
  end;

  if Assigned(FOnQueryAcceptData) then
    FOnQueryAcceptData(Self, ADataObject, AFormat, ClipboardOperationKind, Really, IconMetaPict, Result);
end;

function TJvCustomRichEdit.DoDragAllowed(const ShiftState: TShiftState;
  var AllowedEffects: TRichDropEffects): Boolean;
begin
  Result := False;
  //  if ReadOnly then
  //  begin
  //    Result := True;
  //    AllowedEffects := [];
  //  end
  //  else
  if Assigned(FOnDragAllowed) then
    FOnDragAllowed(Self, ShiftState, AllowedEffects, Result);
end;

function TJvCustomRichEdit.DoGetDragDropEffect(
  const ShiftState: TShiftState; var Effects: TRichDropEffects): Boolean;
begin
  Result := False;
  if Assigned(FOnGetDragDropEffect) then
    FOnGetDragDropEffect(Self, ShiftState, Effects, Result);
end;

procedure TJvCustomRichEdit.EMReplaceSel(var Msg: TMessage);
var
  CharRange: TCharRange;
begin
  Perform(EM_EXGETSEL, 0, LPARAM(@CharRange));
  with CharRange do
    cpMax := cpMin + Integer(StrLen(PChar(Msg.LParam)));
  if (FUndoLimit > 1) and (RichEditVersion >= 2) and (not FLinesUpdating or ForceUndo) then
    Msg.WParam := 1; { allow Undo }
  inherited;
  if FLinesUpdating then
    CharRange.cpMin := CharRange.cpMax;
  Perform(EM_EXSETSEL, 0, LPARAM(@CharRange));
  Perform(Messages.EM_SCROLLCARET, 0, 0);
end;

class function TJvCustomRichEdit.Filter(
  const AKind: TJvConversionKind): string;
begin
  Result := GConversionFormatList.GetFilter(AKind);
end;

function TJvCustomRichEdit.FindDialog(const SearchStr: string): TFindDialog;
begin
  if FFindDialog = nil then
  begin
    FFindDialog := TFindDialog.Create(Self);
    if FReplaceDialog <> nil then
      FFindDialog.FindText := FReplaceDialog.FindText;
  end;
  Result := FFindDialog;
  SetupFindDialog(FFindDialog, SearchStr, '');
  FFindDialog.Execute;
end;

procedure TJvCustomRichEdit.FindDialogClose(Sender: TObject);
begin
  CloseFindDialog(Sender as TFindDialog);
end;

procedure TJvCustomRichEdit.FindDialogFind(Sender: TObject);
begin
  FindEditText(TFindDialog(Sender), True, True);
end;

function TJvCustomRichEdit.FindEditText(Dialog: TFindDialog; AdjustPos, Events: Boolean): Boolean;
var
  Length, StartPos: Integer;
  SrchOptions: TRichSearchTypes;
begin
  with TFindDialog(Dialog) do
  begin
    SrchOptions := [stSetSelection];
    if frDown in Options then
    begin
      StartPos := Max(SelStart, SelStart + SelLength);
      Length := System.Length(Text) - StartPos + 1;
    end
    else
    begin
      SrchOptions := SrchOptions + [stBackward];
      StartPos := Min(SelStart, SelStart + SelLength);
      Length := StartPos + 1;
    end;
    if frMatchCase in Options then
      SrchOptions := SrchOptions + [stMatchCase];
    if frWholeWord in Options then
      SrchOptions := SrchOptions + [stWholeWord];
    Result := Self.FindText(FindText, StartPos, Length, SrchOptions) >= 0;
    if FindText <> '' then
      FLastFind := Dialog;
    if Result then
    begin
      if AdjustPos then
        AdjustFindDialogPosition(Dialog);
    end
    else
    if Events then
      TextNotFound(Dialog);
  end;
end;

function TJvCustomRichEdit.FindNext: Boolean;
begin
  if CanFindNext then
    Result := FindEditText(FLastFind, False, True)
  else
    Result := False;
end;

function TJvCustomRichEdit.FindText(const SearchStr: string;
  StartPos, Length: Integer; Options: TRichSearchTypes): Integer;
var
  Find: TFindTextEx;
  Flags: Integer;
begin
  with Find.chrg do
  begin
    cpMin := StartPos;
    cpMax := cpMin + Abs(Length);
  end;
  if RichEditVersion >= 2 then
  begin
    if not (stBackward in Options) then
      Flags := FT_DOWN
    else
      Flags := 0;
  end
  else
  begin
    Options := Options - [stBackward];
    Flags := 0;
  end;
  if stWholeWord in Options then
    Flags := Flags or {$IFDEF RTL200_UP}FR_WHOLEWORD{$ELSE}FT_WHOLEWORD{$ENDIF RTL200_UP};
  if stMatchCase in Options then
    Flags := Flags or {$IFDEF RTL200_UP}FR_MATCHCASE{$ELSE}FT_MATCHCASE{$ENDIF RTL200_UP};
  Find.lpstrText := PChar(SearchStr);
  Result := SendMessage(Handle, EM_FINDTEXTEX, Flags, LPARAM(@Find));
  if (Result >= 0) and (stSetSelection in Options) then
  begin
    SendMessage(Handle, EM_EXSETSEL, 0, LPARAM(@Find.chrgText));
    SendMessage(Handle, Messages.EM_SCROLLCARET, 0, 0);
  end;
end;

procedure TJvCustomRichEdit.FontChanged;
begin
  inherited FontChanged;
  FDefAttributes.Assign(Font);
end;

function TJvCustomRichEdit.GetAdvancedTypography: Boolean;
begin
  // Advanced and normal line breaking may also be turned on automatically by
  // the rich edit control if it is needed for certain languages. So don't
  // rely on FAdvancedTypography alone.
  if HandleAllocated and not (csDesigning in ComponentState) then
  begin
    if RichEditVersion >= 3 then
      FAdvancedTypography := SendMessage(Handle, EM_GETTYPOGRAPHYOPTIONS, 0, 0) and TO_ADVANCEDTYPOGRAPHY =
        TO_ADVANCEDTYPOGRAPHY;
  end;
  Result := FAdvancedTypography;
end;

function TJvCustomRichEdit.GetAutoURLDetect: Boolean;
begin
  Result := FAutoURLDetect;
  if HandleAllocated and not (csDesigning in ComponentState) then
  begin
    if RichEditVersion >= 2 then
      Result := Boolean(SendMessage(Handle, EM_GETAUTOURLDETECT, 0, 0));
  end;
end;

function TJvCustomRichEdit.GetCanFindNext: Boolean;
begin
  Result := HandleAllocated and (FLastFind <> nil) and
    (FLastFind.FindText <> '');
end;

function TJvCustomRichEdit.GetCanPaste: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANPASTE, 0, 0) <> 0;
end;

function TJvCustomRichEdit.GetCanRedo: Boolean;
begin
  Result := False;
  if HandleAllocated and (RichEditVersion >= 2) then
    Result := SendMessage(Handle, EM_CANREDO, 0, 0) <> 0;
end;

function TJvCustomRichEdit.GetCaretPos: TPoint;
var
  CharRange: TCharRange;
begin
  SendMessage(Handle, EM_EXGETSEL, 0, LPARAM(@CharRange));
  Result.X := CharRange.cpMax;
  Result.Y := LineFromChar(Result.X);
  Dec(Result.X, GetLineIndex(-1));
end;

function TJvCustomRichEdit.GetCharPos(CharIndex: Integer): TPoint;
var
  Res: Longint;
begin
  Result.X := 0;
  Result.Y := 0;
  //  FillChar(Result, SizeOf(Result), 0);
  if HandleAllocated then
  begin
    if RichEditVersion = 2 then
    begin
      Res := SendMessage(Handle, EM_POSFROMCHAR, CharIndex, 0);
      Result.X := LoWord(Res);
      Result.Y := HiWord(Res);
    end
    else { RichEdit 1.0 and 3.0 }
      SendMessage(Handle, EM_POSFROMCHAR, WPARAM(@Result), CharIndex);
  end;
end;

function TJvCustomRichEdit.GetConverter(AStream: TStream;
  const Kind: TJvConversionKind): TJvConversion;
begin
  Result := DefaultConverter;
  if Result = nil then
    Result := GConversionFormatList.GetConverter(
      GetParentWindow(Self), AStream, Kind)
  else
    Result.Init(GetParentWindow(Self));
end;

function TJvCustomRichEdit.GetConverter(const AFileName: string;
  const Kind: TJvConversionKind): TJvConversion;
begin
  { Note: First AFileName determines the converter, if not found then we pick
          the default converter. Same behaviour as TRichEdit }
  Result := GConversionFormatList.GetConverter(
    GetParentWindow(Self), AFileName, Kind);
  if Result = nil then
  begin
    Result := DefaultConverter;
    if Result = nil then
      Result := GConversionFormatList.DefaultConverter;
    Result.Init(GetParentWindow(Self));
  end;
end;

function TJvCustomRichEdit.GetFlat: Boolean;
begin
  Result := not Ctl3D;
end;

function TJvCustomRichEdit.GetLangOptions: TRichLangOptions;
var
  Flags: Longint;
  I: TRichLangOption;
begin
  Result := FLangOptions;
  if HandleAllocated and not (csDesigning in ComponentState) and
    (RichEditVersion >= 2) then
  begin
    Result := [];
    Flags := SendMessage(Handle, EM_GETLANGOPTIONS, 0, 0);
    for I := Low(TRichLangOption) to High(TRichLangOption) do
      if Flags and RichLangOptions[I] <> 0 then
        Include(Result, I);
  end;
end;

function TJvCustomRichEdit.GetLineIndex(LineNo: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_LINEINDEX, LineNo, 0);
end;

function TJvCustomRichEdit.GetLineLength(CharIndex: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_LINELENGTH, CharIndex, 0);
end;

function TJvCustomRichEdit.GetParentFlat: Boolean;
begin
  Result := ParentCtl3D;
end;

function TJvCustomRichEdit.GetPopupMenu: TPopupMenu;
var
  EnumOleVerb: IEnumOleVerb;
  OleVerb: TOleVerb;
  Item: TMenuItem;
  ReObject: TReObject;
begin
  FPopupVerbMenu.Free;
  FPopupVerbMenu := nil;
  Result := inherited GetPopupMenu;
  if FAutoVerbMenu and (SelectionType = [stObject]) and
    Assigned(FRichEditOle) then
  begin
    FillChar(ReObject, SizeOf(ReObject), 0);
    ReObject.cbStruct := SizeOf(ReObject);
    if Succeeded(IRichEditOle(FRichEditOle).GetObject(
      Longint(REO_IOB_SELECTION), ReObject, REO_GETOBJ_POLEOBJ)) then
    try
      if Assigned(ReObject.poleobj) and
        (ReObject.dwFlags and REO_INPLACEACTIVE = 0) then
      begin
        FPopupVerbMenu := TPopupMenu.Create(Self);
        if ReObject.poleobj.EnumVerbs(EnumOleVerb) = 0 then
        try
          while (EnumOleVerb.Next(1, OleVerb, nil) = 0) and
            (OleVerb.lVerb >= 0) and
            (OleVerb.grfAttribs and OLEVERBATTRIB_ONCONTAINERMENU <> 0) do
          begin
            Item := TMenuItem.Create(FPopupVerbMenu);
            Item.Caption := WideCharToString(OleVerb.lpszVerbName);
            Item.Tag := OleVerb.lVerb;
            Item.Default := (OleVerb.lVerb = OLEIVERB_PRIMARY);
            Item.OnClick := PopupVerbClick;
            FPopupVerbMenu.Items.Add(Item);
          end;
        finally
          ReleaseObject(EnumOleVerb);
        end;
        if (Result <> nil) and (Result.Items.Count > 0) then
        begin
          Item := TMenuItem.Create(FPopupVerbMenu);
          Item.Caption := '-';
          Result.Items.Add(Item);
          Item := TMenuItem.Create(FPopupVerbMenu);
          Item.Caption := Format(SPropDlgCaption, [GetFullNameStr(ReObject.poleobj)]);
          Item.OnClick := ObjectPropsClick;
          Result.Items.Add(Item);
          if FPopupVerbMenu.Items.Count > 0 then
          begin
            FPopupVerbMenu.Items.Caption := GetFullNameStr(ReObject.poleobj);
            Result.Items.Add(FPopupVerbMenu.Items);
          end;
        end
        else
        if FPopupVerbMenu.Items.Count > 0 then
        begin
          Item := TMenuItem.Create(FPopupVerbMenu);
          Item.Caption := Format(SPropDlgCaption, [GetFullNameStr(ReObject.poleobj)]);
          Item.OnClick := ObjectPropsClick;
          FPopupVerbMenu.Items.Insert(0, Item);
          Result := FPopupVerbMenu;
        end;
      end;
    finally
      ReleaseObject(ReObject.poleobj);
    end;
  end
  else
  if (Result = nil) and UseFixedPopup then
    Result := FixedDefaultEditPopUp(Self);
end;

{$IFDEF RTL220_UP}
procedure TJvCustomRichEdit.DoContextPopup(MousePos: TPoint; var Handled: Boolean);
begin
  inherited DoContextPopup(MousePos, Handled);

  if not Assigned(PopupMenu) and not Handled then
  begin
    MousePos := ClientToScreen(MousePos);
    FixedDefaultEditPopUp(Self).Popup(MousePos.X, MousePos.Y);
    Handled := True;
  end;
end;
{$ENDIF RTL220_UP}

function TJvCustomRichEdit.GetRedoName: TUndoName;
begin
  Result := unUnknown;
  if (RichEditVersion >= 2) and HandleAllocated then
    Result := TUndoName(SendMessage(Handle, EM_GETREDONAME, 0, 0));
end;

function TJvCustomRichEdit.GetSelection: TCharRange;
begin
  SendMessage(Handle, EM_EXGETSEL, 0, LPARAM(@Result));
end;

function TJvCustomRichEdit.GetSelectionType: TRichSelectionType;
const
  SelTypes: array[TRichSelection] of Integer =
  (SEL_TEXT, SEL_OBJECT, SEL_MULTICHAR, SEL_MULTIOBJECT);
var
  Selection: Integer;
  I: TRichSelection;
begin
  Result := [];
  if HandleAllocated then
  begin
    Selection := SendMessage(Handle, EM_SELECTIONTYPE, 0, 0);
    for I := Low(TRichSelection) to High(TRichSelection) do
      if SelTypes[I] and Selection <> 0 then
        Include(Result, I);
  end;
end;

function TJvCustomRichEdit.GetSelLength: Integer;
begin
  with GetSelection do
    Result := cpMax - cpMin;
end;

function TJvCustomRichEdit.GetSelStart: Integer;
begin
  Result := GetSelection.cpMin;
end;

function TJvCustomRichEdit.GetSelText: string;
begin
  with GetSelection do
    Result := GetTextRange(cpMin, cpMax);
end;

function TJvCustomRichEdit.GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer;
var
  S: string;
begin
  S := SelText;
  Result := Length(S);
  if BufSize < Length(S) then
    Result := BufSize;
  StrPLCopy(Buffer, S, Result);
end;

function TJvCustomRichEdit.GetStreamFormat: TRichStreamFormat;
begin
  Result := TJvRichEditStrings(Lines).Format;
end;

function TJvCustomRichEdit.GetStreamMode: TRichStreamModes;
begin
  Result := TJvRichEditStrings(Lines).Mode;
end;

function TJvCustomRichEdit.GetTextLenEx: Integer;
var
  TextLenEx: TGetTextLengthEx;
begin
  if RichEditVersion >= 2 then
  begin
    with TextLenEx do
    begin
      Flags := GTL_DEFAULT;
      codepage := CP_ACP;
    end;
    Result := Perform(EM_GETTEXTLENGTHEX, WPARAM(@TextLenEx), 0);
  end
  else
    Result := GetTextLen;
end;

function TJvCustomRichEdit.GetTextRange(StartPos, EndPos: Longint): string;
var
  TextRange: TTextRange;
begin
  SetLength(Result, EndPos - StartPos + 1);
  TextRange.chrg.cpMin := StartPos;
  TextRange.chrg.cpMax := EndPos;
  TextRange.lpstrText := PChar(Result);
  SetLength(Result, SendMessage(Handle, EM_GETTEXTRANGE, 0, LPARAM(@TextRange)));
end;

function TJvCustomRichEdit.GetUndoName: TUndoName;
begin
  Result := unUnknown;
  if (RichEditVersion >= 2) and HandleAllocated then
    Result := TUndoName(SendMessage(Handle, EM_GETUNDONAME, 0, 0));
end;

function TJvCustomRichEdit.GetWordSelection: Boolean;
begin
  Result := FWordSelection;
  if HandleAllocated then
    Result := (SendMessage(Handle, EM_GETOPTIONS, 0, 0) and
      ECO_AUTOWORDSELECTION) <> 0;
end;

function TJvCustomRichEdit.GetZoom: Integer; // Added by J.G. Boerema
var
  WP, LP: Integer;
begin
  Result := 100;
  if (RichEditVersion >= 3) and HandleAllocated then
  begin
    SendMessage(Handle, EM_GETZOOM, WPARAM(@WP), LPARAM(@LP));
    if (LP > 0) then
      Result := MulDiv(100, WP, LP);
  end;
end;

procedure TJvCustomRichEdit.InsertGraphic(AGraphic: TGraphic; const Sizeable: Boolean);
var
  OleClientSite: IOleClientSite;
  Storage: IStorage;
  OleObject: IOleObject;
  ReObject: TReObject;
  DataObject: IDataObject;
  Selection: TCharRange;
  FormatEtc: TFormatEtc;
begin
  if HandleAllocated and Assigned(FRichEditOle) then
  begin
    DataObject := TImageDataObject.Create(AGraphic);

    FillChar(ReObject, SizeOf(TReObject), 0);
    IRichEditOle(FRichEditOle).GetClientSite(OleClientSite);
    Storage := nil;
    OleObject := nil;
    try
      CreateStorage(Storage);

      FormatEtc.cfFormat := CF_METAFILEPICT;
      FormatEtc.ptd := nil;
      FormatEtc.dwAspect := DVASPECT_CONTENT;
      FormatEtc.lindex := -1;
      FormatEtc.tymed := TYMED_MFPICT;

      OleCheck(OleCreateStaticFromData(DataObject, IOleObject, OLERENDER_FORMAT,
        @FormatEtc, OleClientSite, Storage, OleObject));
      OleSetContainedObject(OleObject, True);
      try
        FillChar(ReObject, SizeOf(TReObject), #0);
        with ReObject do
        begin
          cbStruct := SizeOf(TReObject);
          cp := REO_CP_SELECTION;
          poleobj := OleObject;
          OleObject.GetUserClassID(clsid);
          pstg := Storage;
          polesite := OleClientSite;
          dvAspect := DVASPECT_CONTENT;
          if Sizeable then
            dwFlags := REO_RESIZABLE;
          //OleCheck(OleSetDrawAspect(OleObject,
          //  Data.dwFlags and PSF_CHECKDISPLAYASICON <> 0,
          //  Data.hMetaPict, dvAspect));
        end;
        SendMessage(Handle, EM_EXGETSEL, 0, LPARAM(@Selection));
        Selection.cpMax := Selection.cpMin + 1;
        OleCheck(IRichEditOle(FRichEditOle).InsertObject(ReObject));
        SendMessage(Handle, EM_EXSETSEL, 0, LPARAM(@Selection));
        IRichEditOle(FRichEditOle).SetDvaspect(
          Longint(REO_IOB_SELECTION), ReObject.dvAspect);
      finally
        ReleaseObject(OleObject);
      end;
    finally
      ReleaseObject(OleClientSite);
      ReleaseObject(Storage);
    end;
  end;
end;

procedure TJvCustomRichEdit.InsertFormatText(Index: Integer; const S: string; FontStyle: TFontStyles;
  const FontName: string; const FontColor: TColor; FontHeight: Integer);
var
  AFont: TFont;
begin
  if S = '' then
    Exit;
  AFont := TFont.Create;
  try
    AFont.Assign(SelAttributes);
    AFont.Style := FontStyle;
    if FontName <> '' then
      AFont.Name := FontName;
    if FontColor <> clDefault then
      AFont.Color := FontColor;
    if FontHeight <> 0 then
      AFont.Height := FontHeight;
    InsertFormatText(Index, S, AFont);

  finally
    AFont.Free;
  end;
end;

procedure TJvCustomRichEdit.InsertFormatText(Index: Integer; const S: string; const AFont: TFont = nil);
var
  ASelStart, ASelLength: Integer;
begin
  if S = '' then
    Exit;
  ASelStart := SelStart;
  ASelLength := SelLength;
  try
    if Index > -1 then
      SelStart := Index;
    SelLength := 0;
    if AFont <> nil then
      SelAttributes.Assign(AFont);
    SelText := S;
  finally
    SelStart := ASelStart;
    SelLength := ASelLength;
  end;
end;

procedure TJvCustomRichEdit.InsertLinkToFile(const FileName: string;
  Iconic: Boolean);
var
  Info: TCreateInfo;
begin
  Info.CreateType := ctLinkToFile;
  Info.ShowAsIcon := Iconic;
  Info.IconMetaPict := 0;
  Info.FileName := FileName;
  InsertObjectFromInfo(Info);
end;

procedure TJvCustomRichEdit.InsertObject(const OleClassName: string;
  Iconic: Boolean);
var
  Info: TCreateInfo;
begin
  Info.CreateType := ctNewObject;
  Info.ShowAsIcon := Iconic;
  Info.IconMetaPict := 0;
  Info.ClassID := ProgIDToClassID(OleClassName);
  InsertObjectFromInfo(Info);
end;

function TJvCustomRichEdit.InsertObjectDialog: Boolean;
var
  Data: TOleUIInsertObject;
  NameBuffer: array[0..MAX_PATH - 1] of Char; // MSDN: cchFile must not exceed MAX_PATH
  OleClientSite: IOleClientSite;
  Storage: IStorage;
  OleObject: IOleObject;
  ReObject: TReObject;
  IsNewObject: Boolean;
  Selection: TCharRange;
begin
  FillChar(Data, SizeOf(Data), 0);
  FillChar(NameBuffer, SizeOf(NameBuffer), 0);
  FillChar(ReObject, SizeOf(TReObject), 0);
  if Assigned(FRichEditOle) then
  begin
    IRichEditOle(FRichEditOle).GetClientSite(OleClientSite);
    Storage := nil;
    try
      CreateStorage(Storage);
      with Data do
      begin
        cbStruct := SizeOf(Data);
        dwFlags := IOF_SELECTCREATENEW or IOF_VERIFYSERVERSEXIST or
          IOF_CREATENEWOBJECT or IOF_CREATEFILEOBJECT or IOF_CREATELINKOBJECT;
        hWndOwner := Handle;
        lpszFile := NameBuffer;
        cchFile := Length(NameBuffer);
        iid := IOleObject;
        oleRender := OLERENDER_DRAW;
        lpIOleClientSite := OleClientSite;
        lpIStorage := Storage;
        ppvObj := @OleObject;
      end;
      try
        Result := OleUIInsertObject(Data) = OLEUI_OK;
        if Result then
        try
          IsNewObject := Data.dwFlags and IOF_SELECTCREATENEW = IOF_SELECTCREATENEW;
          with ReObject do
          begin
            cbStruct := SizeOf(TReObject);
            cp := REO_CP_SELECTION;
            clsid := Data.clsid;
            poleobj := OleObject;
            pstg := Storage;
            polesite := OleClientSite;
            dvAspect := DVASPECT_CONTENT;
            dwFlags := REO_RESIZABLE;
            if IsNewObject then
              dwFlags := dwFlags or REO_BLANK;
          end;
          OleCheck(OleSetDrawAspect(OleObject,
            Data.dwFlags and IOF_CHECKDISPLAYASICON <> 0,
            Data.hMetaPict, ReObject.dvAspect));
          SendMessage(Handle, EM_EXGETSEL, 0, LPARAM(@Selection));
          Selection.cpMax := Selection.cpMin + 1;
          OleCheck(IRichEditOle(FRichEditOle).InsertObject(ReObject));
          SendMessage(Handle, EM_EXSETSEL, 0, LPARAM(@Selection));
          SendMessage(Handle, Messages.EM_SCROLLCARET, 0, 0);
          IRichEditOle(FRichEditOle).SetDvaspect(Longint(REO_IOB_SELECTION), ReObject.dvAspect);
          if IsNewObject then
            OleObject.DoVerb(OLEIVERB_SHOW, nil, OleClientSite, 0, Handle, ClientRect);
        finally
          ReleaseObject(OleObject);
        end;
      finally
        DestroyMetaPict(Data.hMetaPict);
      end;
    finally
      ReleaseObject(OleClientSite);
      ReleaseObject(Storage);
    end;
  end
  else
    Result := False;
end;

procedure TJvCustomRichEdit.InsertObjectFromFile(const FileName: string; Iconic: Boolean);
var
  Info: TCreateInfo;
begin
  Info.CreateType := ctFromFile;
  Info.ShowAsIcon := Iconic;
  Info.IconMetaPict := 0;
  Info.FileName := FileName;
  InsertObjectFromInfo(Info);
end;

procedure TJvCustomRichEdit.InsertObjectFromInfo(const Info: TCreateInfo);
var
  OleClientSite: IOleClientSite;
  Storage: IStorage;
  OleObject: IOleObject;
  ReObject: TReObject;
  Selection: TCharRange;
begin
  if not Assigned(FRichEditOle) then
    Exit;

  IRichEditOle(FRichEditOle).GetClientSite(OleClientSite);
  Storage := nil;
  OleObject := nil;
  try
    CreateStorage(Storage);
    with Info do
    begin
      case CreateType of
        ctNewObject:
          OleCheck(OleCreate(ClassID, IOleObject, OLERENDER_DRAW, nil,
            OleClientSite, Storage, OleObject));
        ctFromFile:
          OleCheck(OleCreateFromFile(GUID_NULL, PWideChar(FileName), IOleObject,
            OLERENDER_DRAW, nil, OleClientSite, Storage, OleObject));
        ctLinkToFile:
          OleCheck(OleCreateLinkToFile(PWideChar(FileName), IOleObject,
            OLERENDER_DRAW, nil, OleClientSite, Storage, OleObject));
        ctFromData:
          OleCheck(OleCreateFromData(DataObject, IOleObject,
            OLERENDER_DRAW, nil, OleClientSite, Storage, OleObject));
        ctLinkFromData:
          OleCheck(OleCreateLinkFromData(DataObject, IOleObject,
            OLERENDER_DRAW, nil, OleClientSite, Storage, OleObject));
      end;
      try
        if CreateType = ctNewObject then
          OleSetContainedObject(OleObject, True);
        FillChar(ReObject, SizeOf(TReObject), 0);
        with ReObject do
        begin
          cbStruct := SizeOf(TReObject);
          cp := REO_CP_SELECTION;
          poleobj := OleObject;
          OleObject.GetUserClassID(clsid);
          pstg := Storage;
          polesite := OleClientSite;
          dvAspect := DVASPECT_CONTENT;
          dwFlags := REO_RESIZABLE;
          if CreateType = ctNewObject then
            dwFlags := dwFlags or REO_BLANK;
        end;
        OleCheck(OleSetDrawAspect(OleObject, ShowAsIcon,
          IconMetaPict, ReObject.dvAspect));
        SendMessage(Handle, EM_EXGETSEL, 0, LPARAM(@Selection));
        Selection.cpMax := Selection.cpMin + 1;
        OleCheck(IRichEditOle(FRichEditOle).InsertObject(ReObject));
        SendMessage(Handle, EM_EXSETSEL, 0, LPARAM(@Selection));
        SendMessage(Handle, Messages.EM_SCROLLCARET, 0, 0);
        IRichEditOle(FRichEditOle).SetDvaspect(
          Longint(REO_IOB_SELECTION), ReObject.dvAspect);
        if CreateType = ctNewObject then
          OleObject.DoVerb(OLEIVERB_SHOW, nil,
            OleClientSite, 0, Handle, ClientRect);
      finally
        ReleaseObject(OleObject);
      end;
    end;
  finally
    ReleaseObject(OleClientSite);
    ReleaseObject(Storage);
  end;
end;

function TJvCustomRichEdit.IsAdvancedTypographyStored: Boolean;
begin
  Result := not AutoAdvancedTypography;
end;

procedure TJvCustomRichEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  // Mantis 6231: TCustomRichEdit from the VCL ignores WantReturns
  if not WantReturns and (Key = $D) and (Shift = []) then
    Key := 0;

  inherited KeyDown(Key, Shift);
end;

function TJvCustomRichEdit.CharFromPos(X, Y: Integer): Integer;
var
  Pt: TPoint;
begin
  Pt := Point(X, Y);
  Result := SendMessage(Handle, EM_CHARFROMPOS, 0, LPARAM(@Pt));
end;

function TJvCustomRichEdit.LineFromChar(CharIndex: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_EXLINEFROMCHAR, 0, CharIndex);
end;

procedure TJvCustomRichEdit.NeedAdvancedTypography;
begin
  if AutoAdvancedTypography and (RichEditVersion >= 3) then
  begin
    HandleNeeded;
    AdvancedTypography := True;
    // setting AdvancedTypography will set AutoAdvancedTypography to False, so:
    AutoAdvancedTypography := True;
  end;
end;

function TJvCustomRichEdit.ObjectPropertiesDialog: Boolean;
var
  ObjectProps: TOleUIObjectProps;
  PropSheet: TPropSheetHeader;
  GeneralProps: TOleUIGnrlProps;
  ViewProps: TOleUIViewProps;
  LinkProps: TOleUILinkProps;
  DialogCaption: string;
  ReObject: TReObject;
begin
  Result := False;
  if not Assigned(FRichEditOle) or (SelectionType <> [stObject]) then
    Exit;
  FillChar(ObjectProps, SizeOf(ObjectProps), 0);
  FillChar(PropSheet, SizeOf(PropSheet), 0);
  FillChar(GeneralProps, SizeOf(GeneralProps), 0);
  FillChar(ViewProps, SizeOf(ViewProps), 0);
  FillChar(LinkProps, SizeOf(LinkProps), 0);
  FillChar(ReObject, SizeOf(ReObject), 0);
  ReObject.cbStruct := SizeOf(ReObject);
  if Succeeded(IRichEditOle(FRichEditOle).GetObject(Longint(REO_IOB_SELECTION),
    ReObject, REO_GETOBJ_POLEOBJ or REO_GETOBJ_POLESITE)) then
    if ReObject.dwFlags and REO_INPLACEACTIVE = 0 then
    begin
      ObjectProps.cbStruct := SizeOf(ObjectProps);
      ObjectProps.dwFlags := OPF_DISABLECONVERT;
      ObjectProps.lpPS := @PropSheet;
      ObjectProps.lpObjInfo := TOleUIObjInfo.Create(Self, ReObject);
      if (ReObject.dwFlags and REO_LINK) <> 0 then
      begin
        ObjectProps.dwFlags := ObjectProps.dwFlags or OPF_OBJECTISLINK;
        ObjectProps.lpLinkInfo := TOleUILinkInfo.Create(Self, ReObject);
      end;
      ObjectProps.lpGP := @GeneralProps;
      ObjectProps.lpVP := @ViewProps;
      ObjectProps.lpLP := @LinkProps;
      PropSheet.dwSize := SizeOf(PropSheet);
      PropSheet.hWndParent := Handle;
      PropSheet.HInstance := MainInstance;
      DialogCaption := Format(SPropDlgCaption, [GetFullNameStr(ReObject.poleobj)]);
      PropSheet.pszCaption := PChar(DialogCaption);
      GeneralProps.cbStruct := SizeOf(GeneralProps);
      ViewProps.cbStruct := SizeOf(ViewProps);
      ViewProps.dwFlags := VPF_DISABLESCALE;
      LinkProps.cbStruct := SizeOf(LinkProps);
      LinkProps.dwFlags := ELF_DISABLECANCELLINK;
      Result := OleUIObjectProperties(ObjectProps) = OLEUI_OK;
    end;
end;

procedure TJvCustomRichEdit.ObjectPropsClick(Sender: TObject);
begin
  ObjectPropertiesDialog;
end;

function TJvCustomRichEdit.PasteSpecialDialog: Boolean;

  procedure SetPasteEntry(var Entry: TOleUIPasteEntry; Format: TClipFormat;
    tymed: DWORD; const FormatName, ResultText: string; Flags: DWORD);
  begin
    with Entry do
    begin
      fmtetc.cfFormat := Format;
      fmtetc.dwAspect := DVASPECT_CONTENT;
      fmtetc.lindex := -1;
      fmtetc.tymed := tymed;
      if FormatName <> '' then
        lpstrFormatName := PChar(FormatName)
      else
        lpstrFormatName := '%s';
      if ResultText <> '' then
        lpstrResultText := PChar(ResultText)
      else
        lpstrResultText := '%s';
      dwFlags := Flags;
    end;
  end;

const
  PasteFormatCount = 6;
var
  Data: TOleUIPasteSpecial;
  PasteFormats: array[0..PasteFormatCount - 1] of TOleUIPasteEntry;
  Format: Integer;
  Info: TCreateInfo;
begin
  Result := False;
  if not CanPaste or not Assigned(FRichEditOle) then
    Exit;
  FillChar(Data, SizeOf(Data), 0);
  FillChar(PasteFormats, SizeOf(PasteFormats), 0);
  with Data do
  begin
    cbStruct := SizeOf(Data);
    hWndOwner := Handle;
    arrPasteEntries := @PasteFormats[0];
    cPasteEntries := PasteFormatCount;
    arrLinkTypes := @CFLinkSource;
    cLinkTypes := 1;
    dwFlags := PSF_SELECTPASTE;
  end;
  SetPasteEntry(PasteFormats[0], CFEmbeddedObject, TYMED_ISTORAGE, '', '',
    OLEUIPASTE_PASTE or OLEUIPASTE_ENABLEICON);
  SetPasteEntry(PasteFormats[1], CFLinkSource, TYMED_ISTREAM, '', '',
    OLEUIPASTE_LINKTYPE1 or OLEUIPASTE_ENABLEICON);
  SetPasteEntry(PasteFormats[2], CFRtf, TYMED_ISTORAGE,
    CF_RTF, CF_RTF, OLEUIPASTE_PASTE);
  SetPasteEntry(PasteFormats[3], CFRtfNoObjs, TYMED_ISTORAGE,
    CF_RTFNOOBJS, CF_RTFNOOBJS, OLEUIPASTE_PASTE);
  SetPasteEntry(PasteFormats[4], CF_TEXT, TYMED_HGLOBAL,
    'Unformatted text', 'text without any formatting', OLEUIPASTE_PASTE);
  SetPasteEntry(PasteFormats[5], CF_BITMAP, TYMED_GDI,
    'Windows Bitmap', 'bitmap image', OLEUIPASTE_PASTE);
  try
    if OleUIPasteSpecial(Data) = OLEUI_OK then
    begin
      Result := True;
      if Data.nSelectedIndex in [0, 1] then
      begin
        case Data.nSelectedIndex of
          0: Info.CreateType := ctFromData;
          1: Info.CreateType := ctLinkFromData;
        end;
        Info.DataObject := Data.lpSrcDataObj;
        Info.ShowAsIcon := Data.dwFlags and PSF_CHECKDISPLAYASICON <> 0;
        Info.IconMetaPict := Data.hMetaPict;

        InsertObjectFromInfo(Info);
      end
      else
      begin
        Format := PasteFormats[Data.nSelectedIndex].fmtetc.cfFormat;
        OleCheck(IRichEditOle(FRichEditOle).ImportDataObject(
          Data.lpSrcDataObj, Format, Data.hMetaPict));
        SendMessage(Handle, Messages.EM_SCROLLCARET, 0, 0);
      end;
    end;
  finally
    DestroyMetaPict(Data.hMetaPict);
    ReleaseObject(Data.lpSrcDataObj);
  end;
end;

procedure TJvCustomRichEdit.PopupVerbClick(Sender: TObject);
var
  ReObject: TReObject;
begin
  if Assigned(FRichEditOle) then
  begin
    FillChar(ReObject, SizeOf(ReObject), 0);
    ReObject.cbStruct := SizeOf(ReObject);
    if Succeeded(IRichEditOle(FRichEditOle).GetObject(
      Longint(REO_IOB_SELECTION), ReObject, REO_GETOBJ_POLEOBJ or
      REO_GETOBJ_POLESITE)) then
    try
      if ReObject.dwFlags and REO_INPLACEACTIVE = 0 then
        OleCheck(ReObject.poleobj.DoVerb((Sender as TMenuItem).Tag, nil,
          ReObject.polesite, 0, Handle, ClientRect));
    finally
      ReleaseObject(ReObject.polesite);
      ReleaseObject(ReObject.poleobj);
    end;
  end;
end;

procedure TJvCustomRichEdit.Print(const Caption: string);
var
  Range: TFormatRange;
  LastChar, MaxLen, LogX, LogY, OldMap: Integer;
  SaveRect: TRect;
begin
  FillChar(Range, SizeOf(TFormatRange), 0);
  with Printer, Range do
  begin
    Title := Caption;
    BeginDoc;
    HDC := Handle;
    hdcTarget := HDC;
    LogX := GetDeviceCaps(Handle, LOGPIXELSX);
    LogY := GetDeviceCaps(Handle, LOGPIXELSY);
    if IsRectEmpty(PageRect) then
    begin
      rc.Right := PageWidth * CTwipsPerInch div LogX;
      rc.Bottom := PageHeight * CTwipsPerInch div LogY;
    end
    else
    begin
      rc.Left := PageRect.Left * CTwipsPerInch div LogX;
      rc.Top := PageRect.Top * CTwipsPerInch div LogY;
      rc.Right := PageRect.Right * CTwipsPerInch div LogX;
      rc.Bottom := PageRect.Bottom * CTwipsPerInch div LogY;
    end;
    rcPage := rc;
    SaveRect := rc;
    LastChar := 0;
    MaxLen := GetTextLenEx;
    chrg.cpMax := -1;
    { ensure printer DC is in text map mode }
    OldMap := SetMapMode(HDC, MM_TEXT);
    SendMessage(Self.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
    try
      repeat
        rc := SaveRect;
        chrg.cpMin := LastChar;
        LastChar := SendMessage(Self.Handle, EM_FORMATRANGE, 1, LPARAM(@Range));
        if (LastChar < MaxLen) and (LastChar <> -1) then
          NewPage;
      until (LastChar >= MaxLen) or (LastChar = -1);
      EndDoc;
    finally
      SendMessage(Self.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
      SetMapMode(HDC, OldMap); { restore previous map mode }
    end;
  end;
end;

function TJvCustomRichEdit.ProtectChange(const Msg: TMessage;
  StartPos, EndPos: Integer): Boolean;
begin
  Result := False;
  if Assigned(OnProtectChangeEx) then
    OnProtectChangeEx(Self, Msg, StartPos, EndPos, Result)
  else
  if Assigned(OnProtectChange) then
    OnProtectChange(Self, StartPos, EndPos, Result);
end;

procedure TJvCustomRichEdit.Redo;
begin
  SendMessage(Handle, EM_REDO, 0, 0);
end;

class procedure TJvCustomRichEdit.RegisterConversionFormat(AConverter: TJvConversion);
begin
  if Assigned(AConverter) then
    GConversionFormatList.Add(AConverter);
end;

class procedure TJvCustomRichEdit.RegisterMSTextConverters;
{ http://support.microsoft.com/support/kb/articles/q212/2/65.asp
  http://www.microsoft.com/office/ork/2003/tools/BoxA07.htm
}
const
  SKey = '\Software\Microsoft\Shared Tools\Text Converters\';
  SImportExportKey: array[TJvConversionKind] of string = ('Import\', 'Export\');
var
  KeyNames: TStringList;
  Registry: TRegistry;

  procedure RegisterConverters(const AKind: TJvConversionKind);
  var
    I: Integer;
  begin
    with Registry do
    begin
      if not OpenKey(SKey + SImportExportKey[AKind], False) then
        Exit;

      GetKeyNames(KeyNames);
      for I := 0 to KeyNames.Count - 1 do
        if OpenKey(SKey + SImportExportKey[AKind] + KeyNames[I], False) then
        begin
          RegisterConversionFormat(TJvMSTextConversion.Create(
            ReadString('Path'),
            ReadString('Extensions'),
            ReadString('Name'),
            AKind
            ));
        end;
    end;
  end;

begin
  if GMSTextConvertersRegistered then
    Exit;
  GMSTextConvertersRegistered := True;

  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;

    KeyNames := TStringList.Create;
    try
      RegisterConverters(ckImport);
      RegisterConverters(ckExport);
    finally
      KeyNames.Free;
    end;
  finally
    Registry.Free;
  end;
end;

function TJvCustomRichEdit.ReplaceDialog(const SearchStr, ReplaceStr: string): TReplaceDialog;
begin
  if FReplaceDialog = nil then
  begin
    FReplaceDialog := TReplaceDialog.Create(Self);
    if FFindDialog <> nil then
      FReplaceDialog.FindText := FFindDialog.FindText;
  end;
  Result := FReplaceDialog;
  SetupFindDialog(FReplaceDialog, SearchStr, ReplaceStr);
  FReplaceDialog.Execute;
end;

procedure TJvCustomRichEdit.ReplaceDialogReplace(Sender: TObject);
var
  Cnt: Integer;
  SaveSelChange: TNotifyEvent;

  function MatchesText(const FindText, FoundText: string; Options: TFindOptions): Boolean;
  begin
    if frWholeWord in Options then
    begin
      if frMatchCase in Options then
        Result := AnsiSameStr(FindText, FoundText)
      else
        Result := AnsiSameText(FindText, FoundText);
    end
    else
    begin
      if frMatchCase in Options then
        Result := Pos(FoundText, FindText) > 0
      else
        Result := Pos(AnsiLowerCase(FindText), AnsiLowerCase(FoundText)) > 0;
    end;
  end;
begin
  with TReplaceDialog(Sender) do
  begin
    if frReplaceAll in Options then
    begin
      Cnt := 0;
      SaveSelChange := FOnSelChange;
      TJvRichEditStrings(Lines).EnableChange(False);
      try
        FOnSelChange := nil;
        while FindEditText(TFindDialog(Sender), False, False) do
        begin
          SelText := ReplaceText;
          Inc(Cnt);
        end;
        if Cnt = 0 then
          TextNotFound(TFindDialog(Sender))
        else
          AdjustFindDialogPosition(TFindDialog(Sender));
      finally
        TJvRichEditStrings(Lines).EnableChange(True);
        FOnSelChange := SaveSelChange;
        if Cnt > 0 then
        begin
          Change;
          SelectionChange;
        end;
      end;
    end
    else
    if frReplace in Options then
    begin
      if MatchesText(SelText, FindText, Options) then
        SelText := ReplaceText;
      FindEditText(TFindDialog(Sender), True, True);
    end;
  end;
end;

procedure TJvCustomRichEdit.RequestSize(const Rect: TRect);
begin
  if Assigned(OnResizeRequest) then
    OnResizeRequest(Self, Rect);
  FImageRect := Rect;
end;

function TJvCustomRichEdit.SaveClipboard(NumObj, NumChars: Integer): Boolean;
begin
  Result := True;
  if Assigned(OnSaveClipboard) then
    OnSaveClipboard(Self, NumObj, NumChars, Result);
end;

procedure TJvCustomRichEdit.SaveToImage(Picture: TPicture);
const
  cSelectionBarWidth = 9;
var
  ABmp: TBitmap;
  Range: TFormatRange;
  R: TRect;
begin
  if (Picture = nil) or (ClientWidth = 0) or (ClientHeight = 0) or not HandleAllocated then
    Exit;
  ABmp := TBitmap.Create;
  try
    if IsRectEmpty(FImageRect) then
    begin
      FImageRect.Right := ClientWidth;
      FImageRect.Bottom := ClientHeight;
    end;
    // Determine draw width ("formatting rectangle"), FImageRect is control width
    SendMessage(Handle, EM_GETRECT, 0, LPARAM(@R));
    // According to MSDN the selection bar is not included in the formatting
    // rectangle, but this seems to be NOT true
    if SelectionBar then
      Dec(R.Right, cSelectionBarWidth);
    ABmp.Width := R.Right - R.Left;
    ABmp.Height := FImageRect.Bottom;
    R.Top := 0;
    R.Left := 0;
    // R must be in twips:
    // pixels * (twips/inch) / (pixels/inch) = twips
    R.Right := MulDiv(ABmp.Width, cTwipsPerInch, Screen.PixelsPerInch);
    R.Bottom := MulDiv(ABmp.Height, cTwipsPerInch, Screen.PixelsPerInch);
    Range.hdc := ABmp.Canvas.Handle;
    Range.hdcTarget := ABmp.Canvas.Handle;
    Range.rc := R;
    Range.rcPage := R;
    Range.chrg.cpMin := 0;
    Range.chrg.cpMax := -1;
    SendMessage(Handle, EM_FORMATRANGE, 1, LPARAM(@Range));
    SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
    Picture.Assign(ABmp);
  finally
    ABmp.Free;
  end;
end;

procedure TJvCustomRichEdit.SelectionChange;
begin
  if Assigned(OnSelectionChange) then
    OnSelectionChange(Self);
end;

procedure TJvCustomRichEdit.SetAdvancedTypography(const Value: Boolean);
begin
  FAdvancedTypography := Value;
  if FAdvancedTypography then
    AutoAdvancedTypography := False;
  UpdateTypographyOptions(FAdvancedTypography);
end;

procedure TJvCustomRichEdit.SetAllowObjects(Value: Boolean);
begin
  if FAllowObjects <> Value then
  begin
    FAllowObjects := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomRichEdit.SetAutoURLDetect(Value: Boolean);
begin
  if Value <> FAutoURLDetect then
  begin
    FAutoURLDetect := Value;
    if HandleAllocated and (RichEditVersion >= 2) then
      SendMessage(Handle, EM_AUTOURLDETECT, WPARAM(FAutoURLDetect), 0);
  end;
end;

procedure TJvCustomRichEdit.SetDefAttributes(Value: TJvTextAttributes);
begin
  FDefAttributes.Assign(Value);
end;

procedure TJvCustomRichEdit.SetFlat(const Value: Boolean);
begin
  Ctl3D := not Value;
end;

procedure TJvCustomRichEdit.SetHideScrollBars(Value: Boolean);
begin
  if HideScrollBars <> Value then
  begin
    FHideScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomRichEdit.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
  begin
    FHideSelection := Value;
    SendMessage(Handle, EM_HIDESELECTION, Ord(HideSelection), LPARAM(True));
  end;
end;

procedure TJvCustomRichEdit.SetLangOptions(Value: TRichLangOptions);
var
  Flags: DWORD;
  I: TRichLangOption;
begin
  FLangOptions := Value;
  if HandleAllocated and (RichEditVersion >= 2) then
  begin
    Flags := 0;
    for I := Low(TRichLangOption) to High(TRichLangOption) do
      if I in Value then
        Flags := Flags or RichLangOptions[I];
    SendMessage(Handle, EM_SETLANGOPTIONS, 0, LPARAM(Flags));
  end;
end;

procedure TJvCustomRichEdit.SetOLEDragDrop(const Value: Boolean);
begin
  if FOLEDragDrop <> Value then
  begin
    FOLEDragDrop := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomRichEdit.SetParentFlat(const Value: Boolean);
begin
  ParentCtl3D := Value;
end;

procedure TJvCustomRichEdit.SetPlainText(Value: Boolean);
var
  State: TJvRichEditState;
begin
  if PlainText <> Value then
  begin
    if HandleAllocated and (RichEditVersion >= 2) then
    begin
      State := TJvRichEditState.Create;
      try
        State.ForcePlainText := (csDesigning in ComponentState) or Value;
        State.Store(Self);

        TJvRichEditStrings(Lines).EnableChange(False);
        try
          SendMessage(Handle, WM_SETTEXT, 0, 0);
          UpdateTextModes(Value);
          FPlainText := Value;
        finally
          TJvRichEditStrings(Lines).EnableChange(True);
        end;

        State.Restore(Self);
      finally
        State.Free;
      end;
    end;
    FPlainText := Value;
  end;
end;

procedure TJvCustomRichEdit.SetRichEditStrings(Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TJvCustomRichEdit.SetSelAttributes(Value: TJvTextAttributes);
begin
  FSelAttributes.Assign(Value);
end;

procedure TJvCustomRichEdit.SetSelection(StartPos, EndPos: Longint;
  ScrollCaret: Boolean);
var
  CharRange: TCharRange;
begin
  with CharRange do
  begin
    cpMin := StartPos;
    cpMax := EndPos;
  end;
  SendMessage(Handle, EM_EXSETSEL, 0, LPARAM(@CharRange));
  if ScrollCaret then
    SendMessage(Handle, Messages.EM_SCROLLCARET, 0, 0);
end;

procedure TJvCustomRichEdit.SetSelectionBar(Value: Boolean);
begin
  if FSelectionBar <> Value then
  begin
    FSelectionBar := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomRichEdit.SetSelectionLink;
var
  CharFormat: TCharFormat;
begin
  FillChar(CharFormat, SizeOf(CharFormat), 0);
  CharFormat.cbSize := SizeOf(CharFormat);
  CharFormat.dwMask := CFM_LINK;
  CharFormat.dwEffects := CFE_LINK;
  SendMessage(Handle, EM_SETCHARFORMAT, SCF_SELECTION, LPARAM(@CharFormat));
end;

procedure TJvCustomRichEdit.SetSelLength(Value: Integer);
begin
  with GetSelection do
    SetSelection(cpMin, cpMin + Value, True);
end;

procedure TJvCustomRichEdit.SetSelStart(Value: Integer);
begin
  SetSelection(Value, Value, False);
end;

procedure TJvCustomRichEdit.SetSelText(const Value: string);
begin
  FLinesUpdating := True;
  inherited SelText := Value;
  FLinesUpdating := False;
end;

procedure TJvCustomRichEdit.SetStreamFormat(Value: TRichStreamFormat);
begin
  TJvRichEditStrings(Lines).Format := Value;
end;

procedure TJvCustomRichEdit.SetStreamMode(Value: TRichStreamModes);
begin
  TJvRichEditStrings(Lines).Mode := Value;
end;

procedure TJvCustomRichEdit.SetTitle(const Value: string);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    UpdateHostNames;
  end;
end;

procedure TJvCustomRichEdit.SetUIActive(Active: Boolean);
var
  Form: TCustomForm;
begin
  try
    Form := GetParentForm(Self);
    if Form <> nil then
      if Active then
      begin
        if (Form.ActiveOleControl <> nil) and
          (Form.ActiveOleControl <> Self) then
          Form.ActiveOleControl.Perform(CM_UIDEACTIVATE, 0, 0);
        Form.ActiveOleControl := Self;
        if AllowInPlace and CanFocus then
          SetFocus;
        if Assigned(FOnInPlaceActivate) then
          FOnInPlaceActivate(Self); // CCR
      end
      else
      begin
        if Form.ActiveOleControl = Self then
          Form.ActiveOleControl := nil;
        if (Form.ActiveControl = Self) and AllowInPlace then
        begin
          Windows.SetFocus(Handle);
          SelectionChange;
        end;
        if Assigned(FOnInPlaceDeactivate) then
          FOnInPlaceDeactivate(Self); //  CCR
      end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TJvCustomRichEdit.SetUndoLimit(Value: Integer);
begin
  if Value <> FUndoLimit then
  begin
    FUndoLimit := Value;
    if (RichEditVersion >= 2) and HandleAllocated then
      FUndoLimit := SendMessage(Handle, EM_SETUNDOLIMIT, Value, 0);
  end;
end;

{ Find & Replace Dialogs }

procedure TJvCustomRichEdit.SetupFindDialog(Dialog: TFindDialog;
  const SearchStr, ReplaceStr: string);
begin
  with Dialog do
  begin
    if SearchStr <> '' then
      FindText := SearchStr;
    if RichEditVersion = 1 then
      Options := Options + [frHideUpDown, frDown];
    OnFind := FindDialogFind;
    OnClose := FindDialogClose;
  end;
  if Dialog is TReplaceDialog then
    with TReplaceDialog(Dialog) do
    begin
      if ReplaceStr <> '' then
        ReplaceText := ReplaceStr;
      OnReplace := ReplaceDialogReplace;
    end;
end;

procedure TJvCustomRichEdit.SetWordAttributes(Value: TJvTextAttributes);
begin
  FWordAttributes.Assign(Value);
end;

procedure TJvCustomRichEdit.SetWordSelection(Value: Boolean);
var
  Options: LPARAM;
begin
  FWordSelection := Value;
  if HandleAllocated then
  begin
    Options := SendMessage(Handle, EM_GETOPTIONS, 0, 0);
    if Value then
      Options := Options or ECO_AUTOWORDSELECTION
    else
      Options := Options and not ECO_AUTOWORDSELECTION;
    SendMessage(Handle, EM_SETOPTIONS, ECOOP_SET, Options);
  end;
end;

procedure TJvCustomRichEdit.SetZoom(Value: Integer);
begin
  if (RichEditVersion >= 3) and HandleAllocated then
    if Value = 0 then
      SendMessage(Handle, EM_SETZOOM, 0, 0)
    else
      SendMessage(Handle, EM_SETZOOM, Value, 100);
end;

procedure TJvCustomRichEdit.StopGroupTyping;
begin
  if (RichEditVersion >= 2) and HandleAllocated then
    SendMessage(Handle, EM_STOPGROUPTYPING, 0, 0);
end;

procedure TJvCustomRichEdit.TextNotFound(Dialog: TFindDialog);
begin
  with Dialog do
    if Assigned(FOnTextNotFound) then
      FOnTextNotFound(Self, FindText);
end;

procedure TJvCustomRichEdit.UpdateHostNames;
var
  AppName: string;
begin
  if HandleAllocated and Assigned(FRichEditOle) then
  begin
    AppName := Application.Title;
    if Trim(AppName) = '' then
      AppName := ExtractFileName(Application.ExeName);
    if Trim(Title) = '' then
      IRichEditOle(FRichEditOle).SetHostNames(PAnsiChar({$IFDEF SUPPORTS_UNICODE}UTF8Encode{$ENDIF SUPPORTS_UNICODE}(AppName)),
                                              PAnsiChar({$IFDEF SUPPORTS_UNICODE}UTF8Encode{$ENDIF SUPPORTS_UNICODE}(AppName)))
    else
      IRichEditOle(FRichEditOle).SetHostNames(PAnsiChar({$IFDEF SUPPORTS_UNICODE}UTF8Encode{$ENDIF SUPPORTS_UNICODE}(AppName)),
                                              PAnsiChar({$IFDEF SUPPORTS_UNICODE}UTF8Encode{$ENDIF SUPPORTS_UNICODE}(Title)));
  end;
end;

procedure TJvCustomRichEdit.UpdateTextModes(Plain: Boolean);
const
  TextModes: array[Boolean] of DWORD = (TM_RICHTEXT, TM_PLAINTEXT);
  UndoModes: array[Boolean] of DWORD = (TM_SINGLELEVELUNDO, TM_MULTILEVELUNDO);
begin
  if (RichEditVersion >= 2) and HandleAllocated then
    SendMessage(Handle, EM_SETTEXTMODE, WPARAM(TextModes[Plain] or UndoModes[FUndoLimit > 1]), 0);
end;

procedure TJvCustomRichEdit.UpdateTypographyOptions(const Advanced: Boolean);
const
  AdvancedModes: array[Boolean] of DWORD = (0, TO_ADVANCEDTYPOGRAPHY);
begin
  if HandleAllocated and (RichEditVersion >= 3) then
    SendMessage(Handle, EM_SETTYPOGRAPHYOPTIONS, WPARAM(AdvancedModes[Advanced]), TO_ADVANCEDTYPOGRAPHY);
end;

procedure TJvCustomRichEdit.URLClick(const URLText: string; Button: TMouseButton);
begin
  if Assigned(OnURLClick) then
    OnURLClick(Self, URLText, Button);
end;

procedure TJvCustomRichEdit.URLHover(const URLText: string);
begin
  if Assigned(OnURLHover) then
    OnURLHover(Self, URLText);
end;

procedure TJvCustomRichEdit.WMDestroy(var Msg: TWMDestroy);
begin
  CloseObjects;
  ReleaseObject(FRichEditOle);
  inherited;
end;

procedure TJvCustomRichEdit.WMHScroll(var Msg: TWMHScroll);
begin
  inherited;
  if Assigned(FOnHorizontalScroll) then
    FOnHorizontalScroll(Self);
end;

procedure TJvCustomRichEdit.WMMouseMove(var Msg: TMessage);
begin
  inherited;
end;

procedure TJvCustomRichEdit.WMPaint(var Msg: TWMPaint);
var
  R, R1: TRect;
begin
  if RichEditVersion >= 2 then
    inherited
  else
  begin
    if GetUpdateRect(Handle, R, True) then
    begin
      R1 := ClientRect;
      R1.Left := R.Right - 3;
      if IntersectRect(R, R, R1) then
        InvalidateRect(Handle, @R1, True);
    end;
    if Painting then
      Invalidate
    else
    begin
      Painting := True;
      try
        inherited;
      finally
        Painting := False;
      end;
    end;
  end;
end;

procedure TJvCustomRichEdit.WMRButtonUp(var Msg: TMessage);
begin
  { RichEd20 does not pass the WM_RBUTTONUP message to defwndproc, }
  { so we get no WM_CONTEXTMENU message. Simulate message here.    }
  if ((RichEditVersion <> 1) or not JclCheckWinVersion(5, 0)) and AllowObjects then
    Perform(WM_CONTEXTMENU, Handle, {$IFDEF RTL230_UP}PointToLParam{$ELSE}LPARAM{$ENDIF RTL230_UP}(PointToSmallPoint(
      ClientToScreen(SmallPointToPoint(TWMMouse(Msg).Pos)))));
  inherited;
end;

procedure TJvCustomRichEdit.WMSetCursor(var Msg: TWMSetCursor);
begin
  inherited;
end;

procedure TJvCustomRichEdit.WMSetFont(var Msg: TWMSetFont);
begin
  FDefAttributes.Assign(Font);
end;

procedure TJvCustomRichEdit.WMSetText(var Msg: TMessage);
begin
  // if auto URL detection is active, then the handle must have been
  // created before setting the text so that the appropriate flag is
  // set on the underlying control.
  // This way the URL detection mechanism can work (Mantis 5792)
  if AutoURLDetect then
    HandleNeeded;

  inherited;
end;

procedure TJvCustomRichEdit.WMVScroll(var Msg: TWMVScroll);
begin
  inherited;
  if Assigned(FOnVerticalScroll) then
    FOnVerticalScroll(Self);
end;

function TJvCustomRichEdit.WordAtCursor: string;
var
  Range: TCharRange;
begin
  Result := '';
  if HandleAllocated then
  begin
    Range.cpMax := SelStart;
    if Range.cpMax = 0 then
      Range.cpMin := 0
    else
    if SendMessage(Handle, EM_FINDWORDBREAK, WB_ISDELIMITER, Range.cpMax) <> 0 then
      Range.cpMin := SendMessage(Handle, EM_FINDWORDBREAK, WB_MOVEWORDLEFT, Range.cpMax)
    else
      Range.cpMin := SendMessage(Handle, EM_FINDWORDBREAK, WB_LEFT, Range.cpMax);
    while SendMessage(Handle, EM_FINDWORDBREAK, WB_ISDELIMITER, Range.cpMin) <> 0 do
      Inc(Range.cpMin);
    Range.cpMax := SendMessage(Handle, EM_FINDWORDBREAK, WB_RIGHTBREAK, Range.cpMax);
    Result := Trim(GetTextRange(Range.cpMin, Range.cpMax));
  end;
end;

//=== { TJvMSTextConversion } ================================================

constructor TJvMSTextConversion.Create(const AConverterFileName, AExtensions,
  ADescription: string; const AKind: TJvConversionKind);
begin
  inherited Create;
  FExtensions := TStringList.Create;
  FExtensions.Delimiter := ' ';
  FExtensions.DelimitedText := AExtensions;
  FConverterFileName := AConverterFileName;
  FDescription := ADescription;
  FConverterKind := AKind;
  FThreadDone := True;
  FCancel := False;
end;

destructor TJvMSTextConversion.Destroy;
begin
  Done;
  FExtensions.Free;
  inherited Destroy;
end;

function TJvMSTextConversion.CanHandle(const AExtension: string;
  const AKind: TJvConversionKind): Boolean;
var
  I: Integer;
begin
  Result := CanHandle(AKind);
  if not Result then
    Exit;

  for I := 0 to FExtensions.Count - 1 do
    if (FExtensions[I] = '*') or (FExtensions[I] = AExtension) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

function TJvMSTextConversion.CanHandle(
  const AKind: TJvConversionKind): Boolean;
begin
  Result := AKind = FConverterKind;
end;

procedure TJvMSTextConversion.Check(Result: FCE);
begin
  if Result <> fceNoErr then
    DoError(Result);
end;

function TJvMSTextConversion.ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
var
  AvailableBufferSize: Integer;
  DestBufferPtr: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  ByteCount: Integer;
begin
  { Fill Buffer with BufSize bytes data from FBuffer }

  if not Assigned(FForeignToRtf32) then
    DoError(fceReadErr);

  AvailableBufferSize := BufSize;
  DestBufferPtr := Buffer;

  repeat
    if FBytesAvailable = 0 then
    begin
      Unlock;
      FRichEditReady.SetEvent;

      WaitUntilThreadReady;
      FThreadReady.ResetEvent;
      { Thread can have set FConversionError & FThreadDone so check those: }

      if FConversionError <> fceNoErr then
        DoError(FConversionError);

      if FThreadDone then
      begin
        Result := BufSize - AvailableBufferSize;
        Exit;
      end;
    end;

    Lock;

    ByteCount := Min(AvailableBufferSize, FBytesAvailable);
    Move(FBufferPtr^, DestBufferPtr^, ByteCount);
    Inc(DestBufferPtr, ByteCount);
    Inc(FBufferPtr, ByteCount);
    Dec(FBytesAvailable, ByteCount);
    Dec(AvailableBufferSize, ByteCount);

    DoProgress(FTempProgress);
  until AvailableBufferSize = 0;

  Result := BufSize;
end;

function TJvMSTextConversion.ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
var
  DestBufferPtr: PAnsiChar;
begin
  if not Assigned(FForeignToRtf32) then
    DoError(fceWriteErr);

  { Result = bytes actually written }
  Result := BufSize;

  while BufSize <> 0 do
  begin
    { wait until thread is ready to export more data.. }
    WaitUntilThreadReady;
    FThreadReady.ResetEvent;

    if FConversionError <> fceNoErr then
      DoError(FConversionError);

    { FBytesAvailable indicates here how many bytes of data are available for
      the converter dll to convert. }
    FBytesAvailable := Min(BufSize, CConvertBufferSize);
    Dec(BufSize, FBytesAvailable);

    DestBufferPtr := GlobalLock(FBuffer);
    if not Assigned(DestBufferPtr) then
      DoError(fceNoMemory);
    Move(Buffer^, DestBufferPtr^, FBytesAvailable);
    GlobalUnlock(FBuffer);

    DoProgress(FTempProgress);

    { Signal that data is ready to be exported }
    FRichEditReady.SetEvent;
  end;
end;

procedure TJvMSTextConversion.DoConversion;
{ This procedure is called in the context of the thread }
var
  hDesc: HGLOBAL;
  hSubset: HGLOBAL;
  LConversionError: FCE;
begin
  { insanity check }
  if (FBuffer = 0) or (GCurrentConverter <> Self) then
  begin
    FConversionError := fceNoMemory;
    FThreadDone := True;
    FThreadReady.SetEvent;

    Exit;
  end;

  hDesc := AnsiStringToHGLOBAL('');
  hSubset := AnsiStringToHGLOBAL('');

  if FConverterKind = ckImport then
  begin
    WaitUntilRichEditReady;
    FRichEditReady.ResetEvent;

    LConversionError := FForeignToRtf32(FFileName, nil, FBuffer,
      hDesc, hSubset, ImportCallback);

    { This ensures that the ConvertRead picks up the last bytes before FThreadDone is set }
    FThreadReady.SetEvent;
    WaitUntilRichEditReady;
  end
  else
    LConversionError := FRtfToForeign32(FFileName, nil, FBuffer,
      hDesc, ExportCallback);

  GlobalFree(hDesc);
  GlobalFree(hSubset);

  if (FConversionError = fceNoErr) and not FCancel then
    FConversionError := LConversionError;

  FThreadDone := True;
  FThreadReady.SetEvent;
end;

procedure TJvMSTextConversion.DoError(ErrorCode: FCE);
begin
  FConversionError := ErrorCode;
  raise EMSTextConversionError.Create(TranslateError(ErrorCode), ErrorCode);
end;

procedure TJvMSTextConversion.Done;
begin
  if Error then
    FCancel := True;

  while not FThreadDone do
  begin
    FRichEditReady.SetEvent;
    WaitUntilThreadReady;

    FBytesAvailable := 0;

    FThreadReady.ResetEvent;
  end;

  Unlock;
  if FBuffer <> 0 then
    GlobalFree(FBuffer);
  FBuffer := 0;

  FreeAndNil(FThreadReady);
  FreeAndNil(FRichEditReady);

  if Assigned(FUninitConverter) then
    FUninitConverter;

  FreeConverter;

  if FFileName <> 0 then
    GlobalFree(FFileName);
  FFileName := 0;

  if GCurrentConverter = Self then
    GCurrentConverter := nil;
  FInitDone := False;

  inherited Done;
end;

function TJvMSTextConversion.Error: Boolean;
begin
  Result := (FConversionError <> fceNoErr) and
    (FConversionError <> fceUserCancel);
end;

function TJvMSTextConversion.ErrorStr: string;
begin
  if not Error then
  begin
    Result := '';
    Exit;
  end;

  Result := TranslateError(FConversionError);
  if Result = '' then
  begin
    Result := FCEToString(FConversionError);
    if Result = '' then
      Result := Format(RsEConversionError, [FConversionError]);
  end;
end;

function TJvMSTextConversion.Filter: string;
var
  I: Integer;
  LFilter: string;
begin
  //'Text files (*.txt)|*.TXT'
  //'Description (*.htm; *.html)|*.HTM;*.HTML'

  LFilter := '';
  Result := '';
  for I := 0 to FExtensions.Count - 1 do
  begin
    Result := Result + '*.' + FExtensions[I] + '; ';
    LFilter := LFilter + '*.' + FExtensions[I] + ';';
  end;
  if Result > '' then
    Delete(Result, Length(Result) - 1, 2);
  if LFilter > '' then
    Delete(LFilter, Length(LFilter), 1);
  if Result > '' then
    Result := FDescription + ' (' + Result + ')|' + LFilter
  else
    Result := FDescription;
end;

procedure TJvMSTextConversion.FreeConverter;
begin
  if FConverter <> 0 then
    FreeLibrary(FConverter);

  FConverter := 0;

  FInitConverter32 := nil;
  FIsFormatCorrect32 := nil;
  FForeignToRtf32 := nil;
  FRtfToForeign32 := nil;
  FUninitConverter := nil;
  FCchFetchLpszError := nil;
end;

function TJvMSTextConversion.HandleExportCallback(cchBuff, nPercent: Integer): Longint;
begin
  if FBuffer = 0 then
  begin
    Result := fceNoMemory;
    Exit;
  end;

  FTempProgress := nPercent;

  { Signal that we're ready to convert data.. }
  FThreadReady.SetEvent;
  { ..and wait until the richedit has data available to convert }
  WaitUntilRichEditReady;
  FRichEditReady.ResetEvent;

  { Result = 0 indicates that we're done
    Result < 0 indicates error or user cancel
    Result > 0 indicates # of bytes put in FBuffer
  }
  if FCancel then
    Result := fceUserCancel
  else
    Result := FBytesAvailable;
end;

function TJvMSTextConversion.HandleImportCallback(cchBuff, nPercent: Integer): Longint;
begin
  // cchBuff = a count of the bytes of RTF data that the converter has placed in
  //           ghBuff.
  // nPercent can range between 0 and 100, representing the estimate made by
  // the converter of how much of the conversion process has been completed.

  if FBuffer = 0 then
  begin
    Result := fceNoMemory;
    Exit;
  end;

  FTempProgress := nPercent;
  FBytesAvailable := cchBuff;

  { Signal that data is ready.. }
  FThreadReady.SetEvent;
  { ..and wait until additional data is wanted }
  WaitUntilRichEditReady;
  FRichEditReady.ResetEvent;

  { Result = 0 indicates that we're done
    Result < 0 indicates error or user cancel
    Result > 0 indicates # of bytes put in FBuffer
  }

  if FCancel then
    Result := fceUserCancel
  else
    { FBytesAvailable should be 0 by now }
    Result := FBytesAvailable;
end;

procedure TJvMSTextConversion.InitConverter;
begin
  if FInitDone then
    Exit;
  FInitDone := True;

  LoadConverter;
  if not Assigned(FInitConverter32) or
    not FInitConverter32(ParentWindow, PAnsiChar(AnsiString(AnsiUpperCase(Application.ExeName)))) then

    raise EMSTextConversionError.CreateRes(@RsECouldNotInitConverter);
end;

function TJvMSTextConversion.IsFormatCorrect(
  const AFileName: string): Boolean;
var
  hFile: THandle;
  hClass: THandle;
begin
  InitConverter;

  Result := Assigned(FIsFormatCorrect32);
  if not Result then
    Exit;

  hFile := FileNameToHGLOBAL({$IFDEF SUPPORTS_UNICODE}UTF8Encode{$ENDIF SUPPORTS_UNICODE}(AFileName));
  hClass := AnsiStringToHGLOBAL('');
  try
    Result := FIsFormatCorrect32(hFile, hClass) = fceTrue;
  finally
    GlobalFree(hClass);
    GlobalFree(hFile);
  end;
end;

procedure TJvMSTextConversion.LoadConverter;
begin
  if FConverter <> 0 then
    Exit;

  FConverter := SafeLoadLibrary(FConverterFileName);
  if FConverter <> 0 then
  begin
    @FInitConverter32 := GetProcAddress(FConverter, InitConverter32Name);
    @FIsFormatCorrect32 := GetProcAddress(FConverter, IsFormatCorrect32Name);
    @FForeignToRtf32 := GetProcAddress(FConverter, ForeignToRtf32Name);
    @FRtfToForeign32 := GetProcAddress(FConverter, RtfToForeign32Name);
    @FUninitConverter := GetProcAddress(FConverter, UninitConverterName);
    @FCchFetchLpszError := GetProcAddress(FConverter, CchFetchLpszErrorName);
  end;
end;

procedure TJvMSTextConversion.Lock;
begin
  if FBufferPtr = nil then
    FBufferPtr := GlobalLock(FBuffer);

  if FBufferPtr = nil then
    DoError(fceNoMemory);
end;

function TJvMSTextConversion.Open(const AFileName: string;
  const AKind: TJvConversionKind): Boolean;
var
  Sa: TSecurityAttributes;
begin
  { Note: cleanup is done in method Done; method Done is always called
          after Open is called }

  Result := (AKind <> ckImport) or FileExists(AFileName);
  if not Result then
    Exit;

  if GCurrentConverter <> nil then
    raise EMSTextConversionError.CreateRes(@RsEConversionBusy);
  GCurrentConverter := Self;

  InitConverter;

  FFileName := FileNameToHGLOBAL({$IFDEF SUPPORTS_UNICODE}UTF8Encode{$ENDIF SUPPORTS_UNICODE}(AFileName));
  if FFileName = 0 then
    DoError(fceNoMemory);

  FBuffer := GlobalAlloc(GHND, CConvertBufferSize);
  if FBuffer = 0 then
    DoError(fceNoMemory);

  Sa.nLength := SizeOf(TSecurityAttributes);
  Sa.lpSecurityDescriptor := nil;
  Sa.bInheritHandle := True;

  FThreadReady := TEvent.Create(@Sa, True, False, '');
  FRichEditReady := TEvent.Create(@Sa, True, False, '');

  FConversionError := fceNoErr;
  FThreadDone := False;
  FCancel := False;
  FBufferPtr := nil;

  FPercentDone := -1;
  DoProgress(0);

  TMSTextConversionThread.Create;

  Result := True;
end;

function TJvMSTextConversion.TextKind: TJvConversionTextKind;
begin
  Result := ctkRTF;
end;

function TJvMSTextConversion.TranslateError(ErrorCode: FCE): string;
const
  CMaxErrorStrSize = 1024; { arbitrary value }
var
  Data: THandle;
  DataPtr: PAnsiChar;
  Size: Longint;
begin
  InitConverter;

  if not Assigned(FCchFetchLpszError) then
  begin
    Result := FCEToString(ErrorCode);
    Exit;
  end;

  Data := GlobalAlloc(GHND, CMaxErrorStrSize + 1); // with last #0, thus + 1
  try
    DataPtr := GlobalLock(Data);
    try
      Size := FCchFetchLpszError(ErrorCode, DataPtr, CMaxErrorStrSize);
      if Size > 0 then
        SetString(Result, DataPtr, Size)
      else
        Result := '';
    finally
      GlobalUnlock(Data);
    end;
  finally
    GlobalFree(Data);
  end;
end;

procedure TJvMSTextConversion.Unlock;
begin
  if FBufferPtr <> nil then
    GlobalUnlock(FBuffer);
  FBufferPtr := nil;
end;

function TJvMSTextConversion.UserCancel: Boolean;
begin
  Result := FConversionError = fceUserCancel;
end;

procedure TJvMSTextConversion.WaitUntilRichEditReady;
var
  Msg: TMsg;
  H: THandle;
begin
  H := FRichEditReady.Handle;

  while MsgWaitForMultipleObjects(1, H, False, INFINITE, QS_SENDMESSAGE) <> WAIT_OBJECT_0 do
  begin
    PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE);
  end;
end;

procedure TJvMSTextConversion.WaitUntilThreadReady;
var
  Msg: TMsg;
  H: THandle;
begin
  H := FThreadReady.Handle;

  while MsgWaitForMultipleObjects(1, H, False, INFINITE, QS_SENDMESSAGE) <> WAIT_OBJECT_0 do
  begin
    if PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE) then
      Application.HandleMessage;
  end;
end;

//=== { TJvOEMConversion } ===================================================

function TJvOEMConversion.ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
var
  Mem: TMemoryStream;
begin
  Mem := TMemoryStream.Create;
  try
    Mem.SetSize(BufSize);
    Result := inherited ConvertRead({$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}(Mem.Memory), BufSize);
    OemToCharBuffA(PAnsiChar(Mem.Memory), PAnsiChar(Buffer), Result);
  finally
    Mem.Free;
  end;
end;

function TJvOEMConversion.ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
var
  Mem: TMemoryStream;
begin
  Mem := TMemoryStream.Create;
  try
    Mem.SetSize(BufSize);
    CharToOemBuffA(PAnsiChar(Buffer), PAnsiChar(Mem.Memory), BufSize);
    Result := inherited ConvertWrite({$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP}(Mem.Memory), BufSize);
  finally
    Mem.Free;
  end;
end;

function TJvOEMConversion.TextKind: TJvConversionTextKind;
begin
  Result := ctkBothPreferRTF;
end;

//=== { TJvParaAttributes } ==================================================

constructor TJvParaAttributes.Create(AOwner: TJvCustomRichEdit);
begin
  inherited Create;
  FRichEdit := AOwner;
  // FIndentationStyle := isRichEdit; // = 0 so not needed; added by J.G. Boerema
end;

procedure TJvParaAttributes.Assign(Source: TPersistent);
var
  I: Integer;
  Paragraph: TParaFormat2;
begin
  if Source is TParaAttributes then
  begin
    Alignment := TParaAlignment(TParaAttributes(Source).Alignment);
    FirstIndent := TParaAttributes(Source).FirstIndent;
    LeftIndent := TParaAttributes(Source).LeftIndent;
    RightIndent := TParaAttributes(Source).RightIndent;
    Numbering := TJvNumbering(TParaAttributes(Source).Numbering);
    for I := 0 to MAX_TAB_STOPS - 1 do
      Tab[I] := TParaAttributes(Source).Tab[I];
  end
  else
  if Source is TJvParaAttributes then
  begin
    TJvParaAttributes(Source).GetAttributes(Paragraph);
    SetAttributes(Paragraph);
  end
  else
    inherited Assign(Source);
end;

procedure TJvParaAttributes.AssignTo(Dest: TPersistent);
var
  I: Integer;
begin
  if Dest is TParaAttributes then
  begin
    with TParaAttributes(Dest) do
    begin
      if Self.Alignment = paJustify then
        Alignment := taLeftJustify
      else
        Alignment := TAlignment(Self.Alignment);
      FirstIndent := Self.FirstIndent;
      LeftIndent := Self.LeftIndent;
      RightIndent := Self.RightIndent;
      if Self.Numbering <> nsNone then
        Numbering := TNumberingStyle(nsBullet)
      else
        Numbering := TNumberingStyle(nsNone);
      for I := 0 to MAX_TAB_STOPS - 1 do
        Tab[I] := Self.Tab[I];
    end;
  end
  else
    inherited AssignTo(Dest);
end;

function TJvParaAttributes.GetAlignment: TParaAlignment;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := TParaAlignment(Paragraph.wAlignment - 1);
end;

procedure TJvParaAttributes.GetAttributes(var Paragraph: TParaFormat2);
begin
  InitPara(Paragraph);
  if FRichEdit.HandleAllocated then
    SendMessage(FRichEdit.Handle, EM_GETPARAFORMAT, 0, LPARAM(@Paragraph));
end;

function TJvParaAttributes.GetFirstIndent: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  if IndentationStyle = isRichEdit then
    Result := Paragraph.dxStartIndent div CTwipsPerPoint
  else // isOffice
    Result := -Paragraph.dxOffset div CTwipsPerPoint;
end;

function TJvParaAttributes.GetHeadingStyle: THeadingStyle;
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 3 then
    Result := 0
  else
  begin
    { See MSDN, ITextPara.GetStyle documentation:

      -1  : StyleNormal
      -2  : StyleHeading1
      -3  : StyleHeading2
      ..
      -10 : StyleHeading9

    }
    GetAttributes(Paragraph);
    Paragraph.sStyle := -(Paragraph.sStyle + 1);
    if (Paragraph.sStyle >= Low(THeadingStyle)) and (Paragraph.sStyle <= High(THeadingStyle)) then
      Result := THeadingStyle(Paragraph.sStyle)
    else
      Result := 0;
  end;
end;

function TJvParaAttributes.GetLeftIndent: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  if IndentationStyle = isRichEdit then
    Result := Paragraph.dxOffset div CTwipsPerPoint
  else // isOffice
    Result := (Paragraph.dxStartIndent + Paragraph.dxOffset) div CTwipsPerPoint;
end;

function TJvParaAttributes.GetLineSpacing: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.dyLineSpacing div CTwipsPerPoint;
end;

function TJvParaAttributes.GetLineSpacingRule: TLineSpacingRule;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := TLineSpacingRule(Paragraph.bLineSpacingRule);
end;

function TJvParaAttributes.GetNumbering: TJvNumbering;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := TJvNumbering(Paragraph.wNumbering);
  if RichEditVersion = 1 then
    if Result <> nsNone then
      Result := nsBullet;
end;

function TJvParaAttributes.GetNumberingStart: Integer;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.wNumberingStart;
end;

function TJvParaAttributes.GetNumberingStyle: TJvNumberingStyle;
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Result := nsSimple
  else
  begin
    GetAttributes(Paragraph);
    case Paragraph.wNumberingStyle of
      PFNS_PERIOD: Result := nsPeriod;
      PFNS_PARENS: Result := nsEnclosed;
      PFNS_PLAIN: Result := nsSimple;
    else
      Result := nsParenthesis;
    end;
  end;
end;

function TJvParaAttributes.GetNumberingTab: Word;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.wNumberingTab div CTwipsPerPoint;
end;

function TJvParaAttributes.GetRightIndent: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.dxRightIndent div CTwipsPerPoint;
end;

function TJvParaAttributes.GetSpaceAfter: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.dySpaceAfter div CTwipsPerPoint;
end;

function TJvParaAttributes.GetSpaceBefore: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.dySpaceBefore div CTwipsPerPoint;
end;

function TJvParaAttributes.GetTab(Index: Byte): Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := (Paragraph.rgxTabs[Index] and TA_TAB) div CTwipsPerPoint;
end;

function TJvParaAttributes.GetTabAlignment(Index: Byte): TJvTabAlignment;
var
  Paragraph: TParaFormat2;
  Temp: Integer;
begin
  if Index >= MAX_TAB_STOPS - 1 then
  begin
    Result := TJvTabAlignment(0);
    Exit;
  end;
  GetAttributes(Paragraph);
  {Result := TJvTabAlignment((Paragraph.rgxTabs[Index] and TA_ALIGNMENT) shr 24);}
  // D6 doesnt want to do it in one step so:
  Temp := (Paragraph.rgxTabs[Index] and TA_ALIGNMENT) shr 24;
  Result := TJvTabAlignment(Temp);
end;

function TJvParaAttributes.GetTabCount: Integer;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result := Paragraph.cTabCount;
end;

function TJvParaAttributes.GetTabLeader(Index: Byte): TJvTabLeader;
var
  Paragraph: TParaFormat2;
  Temp: Integer;
begin
  if Index >= MAX_TAB_STOPS - 1 then
  begin
    Result := TJvTabLeader(0);
    Exit;
  end;
  GetAttributes(Paragraph);
  {Result := TJvTabAlignment((Paragraph.rgxTabs[Index] and TA_LEADER) shr 28);}
  // D6 doesnt want to do it in one step so:
  // Note: and TA_LEADER not necessary: those bits get shifted out anyway
  Temp := (Paragraph.rgxTabs[Index] {and TA_LEADER}) shr 28;
  Result := TJvTabLeader(Temp);
end;

function TJvParaAttributes.GetTableStyle: TParaTableStyle;
var
  Paragraph: TParaFormat2;
begin
  Result := tsNone;
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Paragraph);
  with Paragraph do
  begin
    if (wReserved and PFE_TABLEROW) <> 0 then
      Result := tsTableRow
    else
    if (wReserved and PFE_TABLECELLEND) <> 0 then
      Result := tsTableCellEnd
    else
    if (wReserved and PFE_TABLECELL) <> 0 then
      Result := tsTableCell;
  end;
end;

procedure TJvParaAttributes.InitPara(var Paragraph: TParaFormat2);
begin
  FillChar(Paragraph, SizeOf(Paragraph), 0);
  if RichEditVersion >= 2 then
    Paragraph.cbSize := SizeOf(Paragraph)
  else
    Paragraph.cbSize := SizeOf(TParaFormat);
end;

procedure TJvParaAttributes.SetAlignment(Value: TParaAlignment);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  if Value = paJustify then
    FRichEdit.NeedAdvancedTypography;
  with Paragraph do
  begin
    dwMask := PFM_ALIGNMENT;
    wAlignment := Ord(Value) + 1;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetAttributes(var Paragraph: TParaFormat2);
begin
  FRichEdit.HandleNeeded; { we REALLY need the handle for BiDi }
  if FRichEdit.HandleAllocated then
  begin
    if FRichEdit.UseRightToLeftAlignment then
      if Paragraph.wAlignment = PFA_LEFT then
        Paragraph.wAlignment := PFA_RIGHT
      else
      if Paragraph.wAlignment = PFA_RIGHT then
        Paragraph.wAlignment := PFA_LEFT;
    SendMessage(FRichEdit.Handle, EM_SETPARAFORMAT, 0, LPARAM(@Paragraph));
  end;
end;

procedure TJvParaAttributes.SetFirstIndent(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  with Paragraph do
  begin
    if IndentationStyle = isRichEdit then
    begin
      dwMask := PFM_STARTINDENT;
      dxStartIndent := Value * CTwipsPerPoint;
    end
    else // isOffice
    begin
      dwMask := PFM_STARTINDENT + PFM_OFFSET;
      dxStartIndent := (Value + LeftIndent) * CTwipsPerPoint;
      dxOffset := (LeftIndent * CTwipsPerPoint) - dxStartIndent;
    end;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetHeadingStyle(Value: THeadingStyle);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 3 then
    Exit;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_STYLE;
    sStyle := -Value - 1;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetLeftIndent(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  with Paragraph do
  begin
    if IndentationStyle = isRichEdit then
    begin
      dwMask := PFM_OFFSET;
      dxOffset := Value * CTwipsPerPoint;
    end
    else // isOffice
    begin
      dwMask := PFM_STARTINDENT + PFM_OFFSET;
      dxStartIndent := (FirstIndent + Value) * CTwipsPerPoint;
      dxOffset := (Value * CTwipsPerPoint) - dxStartIndent;
    end;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetLineSpacing(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_LINESPACING;
    dyLineSpacing := Value * CTwipsPerPoint;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetLineSpacingRule(Value: TLineSpacingRule);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_LINESPACING;
    bLineSpacingRule := Ord(Value);
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetNumbering(Value: TJvNumbering);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion = 1 then
    if Value <> nsNone then
      Value := TJvNumbering(PFN_BULLET);
  case Value of
    nsNone:
      LeftIndent := 0;
  else
    if LeftIndent < 10 then
      LeftIndent := 10;
  end;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_NUMBERING;
    wNumbering := Ord(Value);
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetNumberingStart(const Value: Integer);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_NUMBERINGSTART;
    wNumberingStart := Value
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetNumberingStyle(Value: TJvNumberingStyle);
const
  CNumberingStyle: array[TJvNumberingStyle] of Word = (PFNS_PAREN, PFNS_PERIOD, PFNS_PARENS, PFNS_PLAIN);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_NUMBERINGSTYLE;
    wNumberingStyle := CNumberingStyle[Value];
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetNumberingTab(Value: Word);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_NUMBERINGTAB;
    wNumberingTab := Value * CTwipsPerPoint;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetRightIndent(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_RIGHTINDENT;
    dxRightIndent := Value * CTwipsPerPoint;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetSpaceAfter(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_SPACEAFTER;
    dySpaceAfter := Value * CTwipsPerPoint;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetSpaceBefore(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_SPACEBEFORE;
    dySpaceBefore := Value * CTwipsPerPoint;
  end;
  SetAttributes(Paragraph);
end;

procedure TJvParaAttributes.SetTab(Index: Byte; Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  // Added a check for max tab (J.G. Boerema)
  if Index >= MAX_TAB_STOPS - 1 then
    Exit;
  GetAttributes(Paragraph);
  with Paragraph do
  begin
    // Note: the first part is a bugfix
    if cTabCount <= Index then
    begin
      cTabCount := Index + 1;
      rgxTabs[Index] := 0; // is this necessary?
    end;
    // Replace the TAB value with the new one but
    // remember the alignment and leader values
    rgxTabs[Index] := (rgxTabs[Index] and
      Longint(TA_ALIGNMENT or TA_LEADER)) or (Value * CTwipsPerPoint);
    dwMask := PFM_TABSTOPS;
    SetAttributes(Paragraph);
  end;
end;

procedure TJvParaAttributes.SetTabAlignment(Index: Byte; Value: TJvTabAlignment);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  if Index >= MAX_TAB_STOPS - 1 then
    Exit;
  if Value <> taOrdinary then
    FRichEdit.NeedAdvancedTypography;

  GetAttributes(Paragraph);
  with Paragraph do
  begin
    if cTabCount <= Index then
    begin
      cTabCount := Index + 1;
      rgxTabs[Index] := 0; // is this necessary?
    end;
    // Replace the old alignment value with the new one but
    // remember the tab and leader values
    rgxTabs[Index] := Longint(rgxTabs[Index] and TA_TAB_LEADER) or (Ord(Value) shl 24);
    dwMask := PFM_TABSTOPS;
    SetAttributes(Paragraph);
  end;
end;

procedure TJvParaAttributes.SetTabCount(Value: Integer);
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_TABSTOPS;
    cTabCount := Value;
    SetAttributes(Paragraph);
  end;
end;

procedure TJvParaAttributes.SetTabLeader(Index: Byte; Value: TJvTabLeader);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  if Index >= MAX_TAB_STOPS - 1 then
    Exit;
  if Value <> tlNone then
    FRichEdit.NeedAdvancedTypography;

  GetAttributes(Paragraph);
  with Paragraph do
  begin
    if cTabCount <= Index then
    begin
      cTabCount := Index + 1;
      rgxTabs[Index] := 0; // is this necessary?
    end;
    // Replace the old leader value with the new one but
    // remember the tab and alignment values
    rgxTabs[Index] := (rgxTabs[Index] and TA_TAB_ALIGNMENT) or (Ord(Value) shl 28);
    dwMask := PFM_TABSTOPS;
    SetAttributes(Paragraph);
  end;
end;

procedure TJvParaAttributes.SetTableStyle(Value: TParaTableStyle);
var
  Paragraph: TParaFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitPara(Paragraph);
  with Paragraph do
  begin
    dwMask := PFM_TABLE;
    case Value of
      tsTableRow:
        wReserved := PFE_TABLEROW;
      tsTableCellEnd:
        wReserved := PFE_TABLECELLEND;
      tsTableCell:
        wReserved := PFE_TABLECELL;
    end;
  end;
  SetAttributes(Paragraph);
end;

//=== { TJvRichEditState } ===================================================

constructor TJvRichEditState.Create;
begin
  inherited Create;
  FStream := TMemoryStream.Create;
end;

destructor TJvRichEditState.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

procedure TJvRichEditState.Restore(RichEdit: TJvCustomRichEdit);
begin
  TJvRichEditStrings(RichEdit.Lines).Format := FStreamFormat;
  TJvRichEditStrings(RichEdit.Lines).Mode := FStreamMode;

  FStream.Position := 0;
  RichEdit.Lines.LoadFromStream(FStream);

  TJvRichEditStrings(RichEdit.Lines).Format := FOrigFormat;
  TJvRichEditStrings(RichEdit.Lines).Mode := FOrigMode;

  RichEdit.SelStart := FSelStart;
  RichEdit.SelLength := FSelLength;
  RichEdit.Modified := FModified;
end;

procedure TJvRichEditState.Store(RichEdit: TJvCustomRichEdit);
begin
  FModified := RichEdit.Modified;

  FSelStart := RichEdit.SelStart;
  FSelLength := RichEdit.SelLength;

  FOrigFormat := TJvRichEditStrings(RichEdit.Lines).Format;
  FOrigMode := TJvRichEditStrings(RichEdit.Lines).Mode;

  if RichEdit.PlainText or ForcePlainText then
    TJvRichEditStrings(RichEdit.Lines).Format := sfPlainText
  else
    TJvRichEditStrings(RichEdit.Lines).Format := sfRichText;
  TJvRichEditStrings(RichEdit.Lines).Mode := [smUnicode];

  FStreamFormat := TJvRichEditStrings(RichEdit.Lines).Format;
  FStreamMode := TJvRichEditStrings(RichEdit.Lines).Mode;

  RichEdit.Lines.SaveToStream(FStream);

  TJvRichEditStrings(RichEdit.Lines).Format := FOrigFormat;
  TJvRichEditStrings(RichEdit.Lines).Mode := FOrigMode;
end;

//=== { TJvRichEditStrings } =================================================

procedure TJvRichEditStrings.AddStrings(Strings: TStrings);
var
  SelChange: TNotifyEvent;
begin
  SelChange := FRichEdit.OnSelectionChange;
  FRichEdit.OnSelectionChange := nil;
  try
    inherited AddStrings(Strings);
  finally
    FRichEdit.OnSelectionChange := SelChange;
  end;
end;

procedure TJvRichEditStrings.Clear;
begin
  FRichEdit.Clear;
end;

procedure TJvRichEditStrings.Delete(Index: Integer);
const
  Empty: PChar = '';
var
  Selection: TCharRange;
begin
  if Index < 0 then
    Exit;
  Selection.cpMin := FRichEdit.GetLineIndex(Index);
  if Selection.cpMin <> -1 then
  begin
    Selection.cpMax := FRichEdit.GetLineIndex(Index + 1);
    if Selection.cpMax = -1 then
      Selection.cpMax := Selection.cpMin +
        FRichEdit.GetLineLength(Selection.cpMin);
    SendMessage(FRichEdit.Handle, EM_EXSETSEL, 0, LPARAM(@Selection));
    FRichEdit.FLinesUpdating := True;
    try
      SendMessage(FRichEdit.Handle, EM_REPLACESEL, 0, LPARAM(Empty));
    finally
      FRichEdit.FLinesUpdating := False;
    end;
  end;
end;

procedure TJvRichEditStrings.DoExport(AConverter: TJvConversion);
var
  EditStream: TEditStream;
  TextType: Longint;
begin
  with EditStream do
  begin
    dwCookie := {$IFDEF COMPILER19_UP}DWORD_PTR{$ELSE}Longint{$ENDIF}(AConverter);
    pfnCallBack := StreamSave;
    dwError := 0;
  end;
  case FFormat of
    sfDefault:
      if FRichEdit.PlainText then
        TextType := SF_TEXT
      else
        TextType := SF_RTF;
    sfRichText:
      TextType := SF_RTF;
  else {sfPlainText}
    TextType := SF_TEXT;
  end;
  if TextType = SF_RTF then
  begin
    if smNoObjects in Mode then
      TextType := SF_RTFNOOBJS;
    if smPlainRtf in Mode then
      TextType := TextType or SFF_PLAINRTF;
  end
  else
  if TextType = SF_TEXT then
  begin
    if (smUnicode in Mode) and (RichEditVersion > 1) then
      TextType := TextType or SF_UNICODE;
  end;
  if smSelection in Mode then
    TextType := TextType or SFF_SELECTION;
  SendMessage(FRichEdit.Handle, EM_STREAMOUT, TextType, LPARAM(@EditStream));

  if not AConverter.UserCancel then
  begin
    if AConverter.Error then
      raise EOutOfResources.Create(AConverter.ErrorStr)
    else
    if EditStream.dwError <> 0 then
      raise EOutOfResources.CreateRes(@sRichEditSaveFail);
  end;
end;

procedure TJvRichEditStrings.DoImport(AConverter: TJvConversion);
var
  EditStream: TEditStream;
  TextType: Longint;
  Cookie: TCookie;
begin
  Cookie := TCookie.Create(AConverter);
  try
    with EditStream do
    begin
      dwCookie := {$IFDEF COMPILER19_UP}DWORD_PTR{$ELSE}Longint{$ENDIF}(Cookie);
      pfnCallBack := StreamLoad;
      dwError := 0;
    end;
    case FFormat of
      sfDefault:
        if FRichEdit.PlainText then
          TextType := SF_TEXT
        else
          TextType := SF_RTF;
      sfRichText:
        TextType := SF_RTF;
    else {sfPlainText}
      TextType := SF_TEXT;
    end;
    if TextType = SF_RTF then
    begin
      if smPlainRtf in Mode then
        TextType := TextType or SFF_PLAINRTF;
    end;
    if TextType = SF_TEXT then
    begin
      if (smUnicode in Mode) and (RichEditVersion > 1) then
      begin
        TextType := TextType or SF_UNICODE;
        EditStream.pfnCallback := StreamLoadW;
      end;
    end;
    if smSelection in Mode then
      TextType := TextType or SFF_SELECTION;
    SendMessage(FRichEdit.Handle, EM_STREAMIN, TextType, LPARAM(@EditStream));

    if not AConverter.UserCancel then
    begin
      if (EditStream.dwError <> 0) and AConverter.Retry then
      begin
        if (TextType and SF_RTF) = SF_RTF then
        begin
          TextType := SF_TEXT;
          if (smUnicode in Mode) and (RichEditVersion > 1) then
          begin
            TextType := TextType or SF_UNICODE;
            EditStream.pfnCallback := StreamLoadW;
          end;
        end
        else
        begin
          TextType := SF_RTF;
          if smPlainRtf in Mode then
            TextType := TextType or SFF_PLAINRTF;
          EditStream.pfnCallback := StreamLoad;
        end;
        SendMessage(FRichEdit.Handle, EM_STREAMIN, TextType, LPARAM(@EditStream));
      end;

      if AConverter.Error then
        raise EOutOfResources.Create(AConverter.ErrorStr)
      else
      if EditStream.dwError <> 0 then
        raise EOutOfResources.CreateRes(@sRichEditLoadFail);
    end;

    if not (smSelection in Mode) then // Mantis 2591: do not change the selection if there is one
      FRichEdit.SetSelection(0, 0, True);
  finally
    Cookie.Free;
  end;
end;

procedure TJvRichEditStrings.EnableChange(const Value: Boolean);
var
  EventMask: LPARAM;
begin
  with FRichEdit do
  begin
    EventMask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0);
    if Value then
      EventMask := EventMask or ENM_CHANGE
    else
      EventMask := EventMask and not ENM_CHANGE;
    SendMessage(Handle, EM_SETEVENTMASK, 0, EventMask);
  end;
end;

function TJvRichEditStrings.Get(Index: Integer): string;
var
  L: Integer;
begin
  L := FRichEdit.GetLineLength(FRichEdit.GetLineIndex(Index));
  SetLength(Result, L);
  if L > 0 then
  begin
    PWord(Pointer(Result))^ := L;
    L := SendMessage(FRichEdit.Handle, EM_GETLINE, Index, LPARAM(Pointer(Result)));
    if (Result[L - 2] = Cr) and (Result[L - 1] = Lf) then
      SetLength(Result, L - 2)
    else
    if (RichEditVersion >= 2) and (Result[L - 1] = Cr) then
      SetLength(Result, L - 1);
  end;
end;

function TJvRichEditStrings.GetCount: Integer;
begin
  with FRichEdit do
  begin
    Result := SendMessage(Handle, EM_GETLINECOUNT, 0, 0);
    if GetLineLength(GetLineIndex(Result - 1)) = 0 then
      Dec(Result);
  end;
end;

procedure TJvRichEditStrings.Insert(Index: Integer; const S: string);
var
  L: Integer;
  Selection: TCharRange;
  Fmt: PChar;
  Str: string;
begin
  if Index >= 0 then
  begin
    Selection.cpMin := FRichEdit.GetLineIndex(Index);
    if Selection.cpMin >= 0 then
    begin
      if RichEditVersion = 1 then
        Fmt := '%s' + sLineBreak
      else
        Fmt := '%s' + Cr;
    end
    else
    begin
      Selection.cpMin := FRichEdit.GetLineIndex(Index - 1);
      if Selection.cpMin < 0 then
      begin
        Selection.cpMin :=
          SendMessage(FRichEdit.Handle, EM_LINEINDEX, Index - 1, 0);
        if Selection.cpMin < 0 then
          Exit;
        L := SendMessage(FRichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
        if L = 0 then
          Exit;
        Inc(Selection.cpMin, L);
        if RichEditVersion = 1 then
          Fmt := sLineBreak + '%s'
        else
          Fmt := Cr + '%s';
      end
      else
      begin
        L := FRichEdit.GetLineLength(Selection.cpMin);
        if L = 0 then
          Exit;
        Inc(Selection.cpMin, L);
        if RichEditVersion = 1 then
          Fmt := '%s' + sLineBreak
        else
          Fmt := '%s' + Cr;
      end;
    end;
    Selection.cpMax := Selection.cpMin;
    SendMessage(FRichEdit.Handle, EM_EXSETSEL, 0, LPARAM(@Selection));
    Str := SysUtils.Format(Fmt, [S]);
    FRichEdit.FLinesUpdating := True;
    try
      SendMessage(FRichEdit.Handle, EM_REPLACESEL, 0, LPARAM(PChar(Str)));
    finally
      FRichEdit.FLinesUpdating := False;
    end;
    if RichEditVersion = 1 then
      if FRichEdit.SelStart <> (Selection.cpMax + Length(Str)) then
        raise EOutOfResources.CreateRes(@sRichEditInsertError);
  end;
end;

procedure TJvRichEditStrings.LoadFromFile(const FileName: string);
var
  SaveFormat: TRichStreamFormat;
  Converter: TJvConversion;
begin
  Converter := FRichEdit.GetConverter(FileName, ckImport);
  try
    Converter.OnProgress := ProgressCallback;
    SaveFormat := Format;
    try
      if FRichEdit.PlainText then
        { When PlainText is set, the control does not accept RTF }
        FFormat := sfPlainText
      else
      if FFormat = sfDefault then
        case Converter.TextKind of
          ctkText, ctkBothPreferText:
            FFormat := sfPlainText;
          ctkRTF, ctkBothPreferRTF:
            FFormat := sfRichText;
        end;

      if not Converter.Open(FileName, ckImport) then
        raise EOutOfResources.CreateRes(@sRichEditLoadFail);

      DoImport(Converter);
    finally
      FFormat := SaveFormat;
    end;
  finally
    Converter.Done;
    Converter.OnProgress := nil;
  end;
end;

procedure TJvRichEditStrings.LoadFromStream(Stream: TStream);
var
  SaveFormat: TRichStreamFormat;
  Converter: TJvConversion;
begin
  FRichEdit.HandleNeeded;
  // HandleNeeded raises an error if unsuccessful, so no if HandleAllocated
  // check needed..
  Converter := FRichEdit.GetConverter(Stream, ckImport);
  try
    Converter.OnProgress := ProgressCallback;
    SaveFormat := Format;
    try
      if FRichEdit.PlainText then
        { When PlainText is set, the control does not accept RTF }
        FFormat := sfPlainText
      else
      if FFormat = sfDefault then
        case Converter.TextKind of
          ctkText, ctkBothPreferText:
            FFormat := sfPlainText;
          ctkRTF, ctkBothPreferRTF:
            FFormat := sfRichText;
        end;

      if not Converter.Open(Stream, ckImport) then
        raise EOutOfResources.CreateRes(@sRichEditLoadFail);

      DoImport(Converter)
    finally
      FFormat := SaveFormat;
    end;
  finally
    Converter.Done;
    Converter.OnProgress := nil;
  end;
end;

procedure TJvRichEditStrings.ProgressCallback(Sender: TObject);
begin
  if Sender is TJvConversion then
    FRichEdit.DoConversionProgress(TJvConversion(Sender).PercentDone);
end;

procedure TJvRichEditStrings.Put(Index: Integer; const S: string);
var
  Selection: TCharRange;
begin
  if Index >= 0 then
  begin
    Selection.cpMin := FRichEdit.GetLineIndex(Index);
    if Selection.cpMin <> -1 then
    begin
      Selection.cpMax := Selection.cpMin +
        FRichEdit.GetLineLength(Selection.cpMin);
      SendMessage(FRichEdit.Handle, EM_EXSETSEL, 0, LPARAM(@Selection));
      FRichEdit.FLinesUpdating := True;
      try
        SendMessage(FRichEdit.Handle, EM_REPLACESEL, 0, LPARAM(PChar(S)));
      finally
        FRichEdit.FLinesUpdating := False;
      end;
    end;
  end;
end;

procedure TJvRichEditStrings.SaveToFile(const FileName: string);
var
  SaveFormat: TRichStreamFormat;
  Converter: TJvConversion;
begin
  FRichEdit.HandleNeeded;
  Converter := FRichEdit.GetConverter(FileName, ckExport);
  try
    Converter.OnProgress := ProgressCallback;
    SaveFormat := Format;
    try
      if FRichEdit.PlainText then
        { When PlainText is set, the control does not accept RTF }
        FFormat := sfPlainText
      else
      if FFormat = sfDefault then
        case Converter.TextKind of
          ctkText, ctkBothPreferText:
            FFormat := sfPlainText;
          ctkRTF, ctkBothPreferRTF:
            FFormat := sfRichText;
        end;

      if not Converter.Open(FileName, ckExport) then
        raise EOutOfResources.CreateRes(@sRichEditSaveFail);

      DoExport(Converter)
    finally
      FFormat := SaveFormat;
    end;
  finally
    Converter.Done;
    Converter.OnProgress := nil;
  end;
end;

procedure TJvRichEditStrings.SaveToStream(Stream: TStream);
var
  SaveFormat: TRichStreamFormat;
  Converter: TJvConversion;
begin
  FRichEdit.HandleNeeded;
  Converter := FRichEdit.GetConverter(Stream, ckExport);
  try
    Converter.OnProgress := ProgressCallback;
    SaveFormat := Format;
    try
      if FRichEdit.PlainText then
        { When PlainText is set, the control does not accept RTF }
        FFormat := sfPlainText
      else
      if FFormat = sfDefault then
        case Converter.TextKind of
          ctkText, ctkBothPreferText:
            FFormat := sfPlainText;
          ctkRTF, ctkBothPreferRTF:
            FFormat := sfRichText;
        end;

      if not Converter.Open(Stream, ckExport) then
        raise EOutOfResources.CreateRes(@sRichEditSaveFail);

      DoExport(Converter)
    finally
      FFormat := SaveFormat;
    end;
  finally
    Converter.Done;
    Converter.OnProgress := nil;
  end;
end;

procedure TJvRichEditStrings.SetTextStr(const Value: string);
begin
  EnableChange(False);
  try
    inherited SetTextStr(Value);
  finally
    EnableChange(True);
  end;
end;

procedure TJvRichEditStrings.SetUpdateState(Updating: Boolean);
begin
  if FRichEdit.Showing then
    SendMessage(FRichEdit.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
  begin
    FRichEdit.Refresh;
    FRichEdit.Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

//=== { TJvRTFConversion } ===================================================

function TJvRTFConversion.CanHandle(const AExtension: string;
  const AKind: TJvConversionKind): Boolean;
begin
  Result := AExtension = 'rtf';
end;

function TJvRTFConversion.Filter: string;
begin
  Result := RsRTFFilter;
end;

function TJvRTFConversion.IsFormatCorrect(AStream: TStream): Boolean;
const
  CRTFHeader = AnsiString('{\rtf');
  CRTFHeaderSize = Length(CRTFHeader);
var
  SavedPosition: Int64;
  Buffer: array[0..CRTFHeaderSize] of AnsiChar; // + #0
begin
  SavedPosition := AStream.Position;
  try
    Buffer[CRTFHeaderSize] := #0;

    Result :=
      (AStream.Read(Buffer, CRTFHeaderSize) = CRTFHeaderSize) and
      (StrICompA(PAnsiChar(CRTFHeader), Buffer) = 0);
  finally
    AStream.Position := SavedPosition;
  end;
end;

function TJvRTFConversion.IsFormatCorrect(const AFileName: string): Boolean;
var
  LStream: TStream;
begin
  Result := FileExists(AFileName);
  if not Result then
    Exit;

  LStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Result := IsFormatCorrect(LStream);
  finally
    LStream.Free;
  end;
end;

function TJvRTFConversion.TextKind: TJvConversionTextKind;
begin
  Result := ctkBothPreferRTF;
end;

//=== { TJvStreamConversion } ================================================

function TJvStreamConversion.ConvertRead(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
begin
  Result := FStream.Read(Buffer^, BufSize);
  if FStreamSize > 0 then
  begin
    Inc(FBytesConverted, Result);
    DoProgress((FBytesConverted * 100 + FStreamSize div 2) div FStreamSize);
  end;
end;

function TJvStreamConversion.ConvertWrite(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PAnsiChar{$ENDIF COMPILER12_UP};
  BufSize: Integer): Integer;
begin
  Result := FStream.Write(Buffer^, BufSize);
  if FStreamSize > 0 then
  begin
    Inc(FBytesConverted, Result);
    DoProgress((FBytesConverted * 100 + FStreamSize div 2) div FStreamSize);
  end;
end;

procedure TJvStreamConversion.Done;
begin
  if FFreeStream then
    FStream.Free;
  FStream := nil;
  inherited Done;
end;

function TJvStreamConversion.Open(Stream: TStream; const AKind: TJvConversionKind): Boolean;
begin
  FFreeStream := False;
  FStream := Stream;

  FSavedPosition := FStream.Seek(0, soCurrent);
  FStreamSize := FStream.Seek(0, soEnd);
  FStream.Seek(FSavedPosition, soBeginning);
  FBytesConverted := 0;

  Result := True;
end;

function TJvStreamConversion.Open(const AFileName: string;
  const AKind: TJvConversionKind): Boolean;
begin
  FFreeStream := True;
  if AKind = ckImport then
    FStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite)
  else
    FStream := TFileStream.Create(AFileName, fmCreate);

  FSavedPosition := 0;
  FStreamSize := FStream.Size;
  FBytesConverted := 0;

  Result := True;
end;

function TJvStreamConversion.Retry: Boolean;
begin
  Result := TextKind in [ctkBothPreferText, ctkBothPreferRTF];
  if Result then
  begin
    FStream.Position := FSavedPosition;
    FBytesConverted := 0;
  end;
end;

//=== { TJvTextAttributes } ==================================================

constructor TJvTextAttributes.Create(AOwner: TJvCustomRichEdit;
  AttributeType: TJvAttributeType);
begin
  inherited Create;
  FRichEdit := AOwner;
  FType := AttributeType;
end;

procedure TJvTextAttributes.Assign(Source: TPersistent);
var
  Format: TCharFormat2;
begin
  if Source is TFont then
    AssignFont(TFont(Source))
  else
  if Source is TTextAttributes then
  begin
    Name := TTextAttributes(Source).Name;
    Charset := TTextAttributes(Source).Charset;
    Style := TTextAttributes(Source).Style;
    Pitch := TTextAttributes(Source).Pitch;
    Color := TTextAttributes(Source).Color;
  end
  else
  if Source is TJvTextAttributes then
  begin
    TJvTextAttributes(Source).GetAttributes(Format);
    SetAttributes(Format);
  end
  else
    inherited Assign(Source);
end;

procedure TJvTextAttributes.AssignFont(Font: TFont);
var
  LogFont: TLogFont;
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    case Font.Pitch of
      fpVariable:
        bPitchAndFamily := VARIABLE_PITCH;
      fpFixed:
        bPitchAndFamily := FIXED_PITCH;
    else
      bPitchAndFamily := DEFAULT_PITCH;
    end;
    dwMask := dwMask or CFM_SIZE or CFM_BOLD or CFM_ITALIC or
      CFM_UNDERLINE or CFM_STRIKEOUT or CFM_FACE or CFM_COLOR;
    { Font.Size is in points; yHeight is in twips }
    yHeight := Font.Size * CTwipsPerPoint;
    if (Font.Color = clWindowText) or (Font.Color = clDefault) then
      dwEffects := dwEffects or CFE_AUTOCOLOR
    else
      crTextColor := ColorToRGB(Font.Color);
    if fsBold in Font.Style then
      dwEffects := dwEffects or CFE_BOLD;
    if fsItalic in Font.Style then
      dwEffects := dwEffects or CFE_ITALIC;
    if fsUnderline in Font.Style then
      dwEffects := dwEffects or CFE_UNDERLINE;
    if fsStrikeOut in Font.Style then
      dwEffects := dwEffects or CFE_STRIKEOUT;
    StrPLCopy(szFaceName, Font.Name, SizeOf(szFaceName));
    dwMask := dwMask or CFM_CHARSET;
    bCharSet := Font.Charset;
    if GetObject(Font.Handle, SizeOf(LogFont), @LogFont) <> 0 then
    begin
      dwMask := dwMask or DWORD(CFM_WEIGHT);
      wWeight := Word(LogFont.lfWeight);
    end;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.AssignTo(Dest: TPersistent);
begin
  if Dest is TFont then
  begin
    TFont(Dest).Color := Color;
    TFont(Dest).Name := Name;
    TFont(Dest).Charset := Charset;
    TFont(Dest).Style := Style;
    TFont(Dest).Size := Size;
    TFont(Dest).Pitch := Pitch;
  end
  else
  if Dest is TTextAttributes then
  begin
    TTextAttributes(Dest).Color := Color;
    TTextAttributes(Dest).Name := Name;
    TTextAttributes(Dest).Charset := Charset;
    TTextAttributes(Dest).Style := Style;
    TTextAttributes(Dest).Pitch := Pitch;
  end
  else
    inherited AssignTo(Dest);
end;

function TJvTextAttributes.GetAttribute(const Flag: Integer): Boolean;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Format.dwEffects and Flag <> 0;
end;

procedure TJvTextAttributes.GetAttributes(var Format: TCharFormat2);
begin
  InitFormat(Format);
  if FRichEdit.HandleAllocated then
    SendMessage(FRichEdit.Handle, EM_GETCHARFORMAT, AttrFlags[FType], LPARAM(@Format));
end;

function TJvTextAttributes.GetBackColor: TColor;
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
  begin
    Result := clWindow;
    Exit;
  end;
  GetAttributes(Format);
  with Format do
    if (dwEffects and CFE_AUTOBACKCOLOR) <> 0 then
      Result := clWindow
    else
      Result := crBackColor;
end;

function TJvTextAttributes.GetCharset: TFontCharset;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Format.bCharSet;
end;

function TJvTextAttributes.GetColor: TColor;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  with Format do
    if (dwEffects and CFE_AUTOCOLOR) <> 0 then
      Result := clWindowText
    else
      Result := crTextColor;
end;

function TJvTextAttributes.GetConsistentAttributes: TJvConsistentAttributes;
var
  Format: TCharFormat2;
begin
  Result := [];
  if FRichEdit.HandleAllocated and (FType <> atDefaultText) then
  begin
    InitFormat(Format);
    SendMessage(FRichEdit.Handle, EM_GETCHARFORMAT,
      AttrFlags[FType], LParam(@Format));
    with Format do
    begin
      if (dwMask and CFM_BOLD) <> 0 then
        Include(Result, caBold);
      if (dwMask and CFM_COLOR) <> 0 then
        Include(Result, caColor);
      if (dwMask and CFM_FACE) <> 0 then
        Include(Result, caFace);
      if (dwMask and CFM_ITALIC) <> 0 then
        Include(Result, caItalic);
      if (dwMask and CFM_SIZE) <> 0 then
        Include(Result, caSize);
      if (dwMask and CFM_STRIKEOUT) <> 0 then
        Include(Result, caStrikeOut);
      if (dwMask and CFM_UNDERLINE) <> 0 then
        Include(Result, caUnderline);
      if (dwMask and CFM_PROTECTED) <> 0 then
        Include(Result, caProtected);
      if (dwMask and CFM_OFFSET) <> 0 then
        Include(Result, caOffset);
      if (dwMask and CFM_HIDDEN) <> 0 then
        Include(Result, caHidden);
      if (dwMask and CFM_CHARSET) <> 0 then
        Include(Result, caCharset);
      if RichEditVersion >= 2 then
      begin
        if (dwMask and CFM_LINK) <> 0 then
          Include(Result, caLink);
        if (dwMask and CFM_BACKCOLOR) <> 0 then
          Include(Result, caBackColor);
        if (dwMask and CFM_DISABLED) <> 0 then
          Include(Result, caDisabled);
        if (dwMask and CFM_WEIGHT) <> 0 then
          Include(Result, caWeight);
        if (dwMask and CFM_SUBSCRIPT) <> 0 then
          Include(Result, caSubscript);
        if (dwMask and CFM_REVAUTHOR) <> 0 then
          Include(Result, caRevAuthor);
      end;
    end;
  end;
end;

function TJvTextAttributes.GetDisabled: Boolean;
var
  Format: TCharFormat2;
begin
  Result := False;
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Format);
  Result := Format.dwEffects and CFE_DISABLED <> 0;
end;

function TJvTextAttributes.GetHeight: Integer;
begin
  { Points -> Logical pixels }
  Result := MulDiv(Size, FRichEdit.FScreenLogPixels, CPointsPerInch);
end;

function TJvTextAttributes.GetHidden: Boolean;
var
  Format: TCharFormat2;
begin
  Result := False;
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Format);
  Result := Format.dwEffects and CFE_HIDDEN <> 0;
end;

function TJvTextAttributes.GetLink: Boolean;
var
  Format: TCharFormat2;
begin
  Result := False;
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Format);
  with Format do
    Result := (dwEffects and CFE_LINK) <> 0;
end;

function TJvTextAttributes.GetName: TFontName;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Format.szFaceName;
end;

function TJvTextAttributes.GetOffset: Integer;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Format.yOffset div CTwipsPerPoint;
end;

function TJvTextAttributes.GetPitch: TFontPitch;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  case Format.bPitchAndFamily and $03 of
    DEFAULT_PITCH:
      Result := fpDefault;
    VARIABLE_PITCH:
      Result := fpVariable;
    FIXED_PITCH:
      Result := fpFixed;
  else
    Result := fpDefault;
  end;
end;

function TJvTextAttributes.GetProtected: Boolean;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  with Format do
    Result := (dwEffects and CFE_PROTECTED) <> 0;
end;

function TJvTextAttributes.GetRevAuthorIndex: Byte;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Format.bRevAuthor;
end;

function TJvTextAttributes.GetSize: Integer;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Format.yHeight div CTwipsPerPoint;
end;

function TJvTextAttributes.GetStyle: TFontStyles;
var
  Format: TCharFormat2;
begin
  Result := [];
  GetAttributes(Format);
  with Format do
  begin
    if (dwEffects and CFE_BOLD) <> 0 then
      Include(Result, fsBold);
    if (dwEffects and CFE_ITALIC) <> 0 then
      Include(Result, fsItalic);
    if (dwEffects and CFE_UNDERLINE) <> 0 then
      Include(Result, fsUnderline);
    if (dwEffects and CFE_STRIKEOUT) <> 0 then
      Include(Result, fsStrikeOut);
  end;
end;

function TJvTextAttributes.GetSubscriptStyle: TSubscriptStyle;
var
  Format: TCharFormat2;
begin
  Result := ssNone;
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Format);
  with Format do
  begin
    if (dwEffects and CFE_SUBSCRIPT) <> 0 then
      Result := ssSubscript
    else
    if (dwEffects and CFE_SUPERSCRIPT) <> 0 then
      Result := ssSuperscript;
  end;
end;

function TJvTextAttributes.GetUnderlineColor: TUnderlineColor;
var
  Format: TCharFormat2;
begin
  Result := ucBlack;
  if RichEditVersion < 3 then
    Exit;
  GetAttributes(Format);
  with Format do
  begin
    if (dwEffects and CFE_UNDERLINE <> 0) and
      (dwMask and CFM_UNDERLINETYPE = CFM_UNDERLINETYPE) then
      Result := TUnderlineColor(bUnderlineType div $10);
  end;
end;

function TJvTextAttributes.GetUnderlineType: TUnderlineType;
var
  Format: TCharFormat2;
begin
  Result := utNone;
  if RichEditVersion < 2 then
    Exit;
  GetAttributes(Format);
  with Format do
  begin
    if (dwEffects and CFE_UNDERLINE <> 0) and
      (dwMask and CFM_UNDERLINETYPE = CFM_UNDERLINETYPE) then
      Result := TUnderlineType(bUnderlineType mod $10);
  end;
end;

procedure TJvTextAttributes.InitFormat(var Format: TCharFormat2);
begin
  FillChar(Format, SizeOf(Format), 0);
  if RichEditVersion >= 2 then
    Format.cbSize := SizeOf(Format)
  else
    Format.cbSize := SizeOf(TCharFormat);
end;

procedure TJvTextAttributes.SetAttribute(const Flag: Integer; const Value: Boolean);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  { Assume Mask value is same as Flag, this is correct for CFE_BOLD, CFE_ITALIC,
    CFE_UNDERLINE and CFE_STRIKEOUT }
  Format.dwMask := Flag;
  if Value then
    Format.dwEffects := Flag;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetAttributes(var Format: TCharFormat2);
begin
  if FRichEdit.HandleAllocated then
    SendMessage(FRichEdit.Handle, EM_SETCHARFORMAT, AttrFlags[FType], LPARAM(@Format));
end;

procedure TJvTextAttributes.SetBackColor(Value: TColor);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_BACKCOLOR;
    if (Value = clWindow) or (Value = clDefault) then
      dwEffects := CFE_AUTOBACKCOLOR
    else
      crBackColor := ColorToRGB(Value);
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetCharset(Value: TFontCharset);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_CHARSET;
    bCharSet := Value;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetColor(Value: TColor);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_COLOR;
    if (Value = clWindowText) or (Value = clDefault) then
      dwEffects := CFE_AUTOCOLOR
    else
      crTextColor := ColorToRGB(Value);
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetDisabled(Value: Boolean);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_DISABLED;
    if Value then
      dwEffects := CFE_DISABLED;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetHeight(Value: Integer);
begin
  { Logical pixels -> Points }
  Size := MulDiv(Value, CPointsPerInch, FRichEdit.FScreenLogPixels);
end;

procedure TJvTextAttributes.SetHidden(Value: Boolean);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_HIDDEN;
    if Value then
      dwEffects := CFE_HIDDEN;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetLink(Value: Boolean);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_LINK;
    if Value then
      dwEffects := CFE_LINK;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetName(Value: TFontName);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_FACE;
    StrPLCopy(szFaceName, Value, SizeOf(szFaceName));
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetOffset(Value: Integer);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := DWORD(CFM_OFFSET);
    yOffset := Value * CTwipsPerPoint;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetPitch(Value: TFontPitch);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    case Value of
      fpVariable:
        bPitchAndFamily := VARIABLE_PITCH;
      fpFixed:
        bPitchAndFamily := FIXED_PITCH;
    else
      bPitchAndFamily := DEFAULT_PITCH;
    end;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetProtected(Value: Boolean);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_PROTECTED;
    if Value then
      dwEffects := CFE_PROTECTED;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetRevAuthorIndex(Value: Byte);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_REVAUTHOR;
    bRevAuthor := Value;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetSize(Value: Integer);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := DWORD(CFM_SIZE);
    yHeight := Value * CTwipsPerPoint;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetStyle(Value: TFontStyles);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_BOLD or CFM_ITALIC or CFM_UNDERLINE or CFM_STRIKEOUT;
    if fsBold in Value then
      dwEffects := dwEffects or CFE_BOLD;
    if fsItalic in Value then
      dwEffects := dwEffects or CFE_ITALIC;
    if fsUnderline in Value then
      dwEffects := dwEffects or CFE_UNDERLINE;
    if fsStrikeOut in Value then
      dwEffects := dwEffects or CFE_STRIKEOUT;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetSubscriptStyle(Value: TSubscriptStyle);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := DWORD(CFM_SUBSCRIPT);
    case Value of
      ssSubscript:
        dwEffects := CFE_SUBSCRIPT;
      ssSuperscript:
        dwEffects := CFE_SUPERSCRIPT;
    end;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetUnderlineColor(const Value: TUnderlineColor);
var
  Format: TCharFormat2;
  LUnderlineType: TUnderlineType;
begin
  if RichEditVersion < 3 then
    Exit;

  LUnderlineType := UnderlineType;
  if LUnderlineType = utNone then
    Exit;

  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_UNDERLINETYPE or CFM_UNDERLINE;
    bUnderlineType := Ord(LUnderlineType) + $10 * Ord(Value);
    dwEffects := dwEffects or CFE_UNDERLINE;
  end;
  SetAttributes(Format);
end;

procedure TJvTextAttributes.SetUnderlineType(Value: TUnderlineType);
var
  Format: TCharFormat2;
begin
  if RichEditVersion < 2 then
    Exit;
  InitFormat(Format);
  with Format do
  begin
    dwMask := CFM_UNDERLINETYPE or CFM_UNDERLINE;
    bUnderlineType := Ord(Value);
    if Value <> utNone then
    begin
      Inc(bUnderlineType, $10 * Ord(UnderlineColor));
      dwEffects := dwEffects or CFE_UNDERLINE;
    end;
  end;
  SetAttributes(Format);
end;

//=== { TJvTextConversion } ==================================================

function TJvTextConversion.CanHandle(const AExtension: string;
  const AKind: TJvConversionKind): Boolean;
begin
  Result := AExtension = 'txt';
end;

function TJvTextConversion.Filter: string;
begin
  Result := RsTextFilter;
end;

function TJvTextConversion.TextKind: TJvConversionTextKind;
begin
  Result := ctkBothPreferText;
end;

//=== { TMSTextConversionThread } ============================================

constructor TMSTextConversionThread.Create;
begin
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TMSTextConversionThread.Execute;
begin
  NameThread(ThreadName);
  if GCurrentConverter <> nil then
    GCurrentConverter.DoConversion;
end;

//=== { TOleUILinkInfo } =====================================================

constructor TOleUILinkInfo.Create(ARichEdit: TJvCustomRichEdit;
  ReObject: TReObject);
begin
  inherited Create;
  FReObject := ReObject;
  FRichEdit := ARichEdit;
  OleCheck(FReObject.poleobj.QueryInterface(IOleLink, FOleLink));
end;

function TOleUILinkInfo.CancelLink(dwLink: Longint): HRESULT;
begin
  LinkError(SCannotBreakLink);
  Result := E_NOTIMPL;
end;

function TOleUILinkInfo.GetLastUpdate(dwLink: Longint;
  var LastUpdate: TFileTime): HRESULT;
begin
  Result := S_OK;
end;

function TOleUILinkInfo.GetLinkSource(dwLink: Longint; var pszDisplayName: PChar;
  var lenFileName: Longint; var pszFullLinkType: PChar;
  var pszShortLinkType: PChar; var fSourceAvailable: BOOL;
  var fIsSelected: BOOL): HRESULT;
var
  Moniker: IMoniker;
begin
  if @pszDisplayName <> nil then
    pszDisplayName := CoAllocCStr(GetDisplayNameStr(FOleLink));
  if @lenFileName <> nil then
  begin
    lenFileName := 0;
    FOleLink.GetSourceMoniker(Moniker);
    if Moniker <> nil then
    begin
      lenFileName := OleStdGetLenFilePrefixOfMoniker(Moniker);
      ReleaseObject(Moniker);
    end;
  end;
  if @pszFullLinkType <> nil then
    pszFullLinkType := CoAllocCStr(GetFullNameStr(FReObject.poleobj));
  if @pszShortLinkType <> nil then
    pszShortLinkType := CoAllocCStr(GetShortNameStr(FReObject.poleobj));
  Result := S_OK;
end;

function TOleUILinkInfo.GetLinkUpdateOptions(dwLink: Longint;
  var dwUpdateOpt: Longint): HRESULT;
begin
  Result := FOleLink.GetUpdateOptions(dwUpdateOpt);
end;

function TOleUILinkInfo.GetNextLink(dwLink: Longint): Longint;
begin
  if dwLink = 0 then
    Result := Longint(FRichEdit)
  else
    Result := 0;
end;

function TOleUILinkInfo.OpenLinkSource(dwLink: Longint): HRESULT;
begin
  try
    OleCheck(FReObject.poleobj.DoVerb(OLEIVERB_SHOW, nil, FReObject.polesite,
      0, FRichEdit.Handle, FRichEdit.ClientRect));
  except
    Application.HandleException(FRichEdit);
  end;
  Result := S_OK;
end;

function TOleUILinkInfo.SetLinkSource(dwLink: Longint; pszDisplayName: PChar;
  lenFileName: Longint; var chEaten: Longint;
  fValidateSource: BOOL): HRESULT;
var
  DisplayName: string;
  Buffer: array[0..255] of WideChar;
begin
  Result := E_FAIL;
  if fValidateSource then
  begin
    DisplayName := pszDisplayName;
    if Succeeded(FOleLink.SetSourceDisplayName(StringToWideChar(DisplayName,
      Buffer, SizeOf(Buffer) div 2))) then
    begin
      chEaten := Length(DisplayName);
      try
        OleCheck(FReObject.poleobj.Update);
      except
        Application.HandleException(FRichEdit);
      end;
      Result := S_OK;
    end;
  end
  else
    LinkError(SInvalidLinkSource);
end;

function TOleUILinkInfo.SetLinkUpdateOptions(dwLink: Longint;
  dwUpdateOpt: Longint): HRESULT;
begin
  Result := FOleLink.SetUpdateOptions(dwUpdateOpt);
  if Succeeded(Result) then
    FRichEdit.Modified := True;
end;

function TOleUILinkInfo.UpdateLink(dwLink: Longint; fErrorMessage: BOOL;
  fErrorAction: BOOL): HRESULT;
begin
  try
    OleCheck(FReObject.poleobj.Update);
  except
    Application.HandleException(FRichEdit);
  end;
  Result := S_OK;
end;

//=== { TOleUIObjInfo } ======================================================

constructor TOleUIObjInfo.Create(ARichEdit: TJvCustomRichEdit;
  ReObject: TReObject);
begin
  inherited Create;
  FRichEdit := ARichEdit;
  FReObject := ReObject;
end;

function TOleUIObjInfo.ConvertObject(dwObject: Longint;
  const clsidNew: TCLSID): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TOleUIObjInfo.GetConvertInfo(dwObject: Longint; var ClassID: TCLSID;
  var wFormat: Word; var ConvertDefaultClassID: TCLSID;
  var lpClsidExclude: PCLSID; var cClsidExclude: Longint): HRESULT;
begin
  FReObject.poleobj.GetUserClassID(ClassID);
  Result := S_OK;
end;

function TOleUIObjInfo.GetObjectInfo(dwObject: Longint;
  var dwObjSize: Longint; var lpszLabel: PChar;
  var lpszType: PChar; var lpszShortType: PChar;
  var lpszLocation: PChar): HRESULT;
begin
  if @dwObjSize <> nil then
    dwObjSize := -1; { Unknown size }
  if @lpszLabel <> nil then
    lpszLabel := CoAllocCStr(GetFullNameStr(FReObject.poleobj));
  if @lpszType <> nil then
    lpszType := CoAllocCStr(GetFullNameStr(FReObject.poleobj));
  if @lpszShortType <> nil then
    lpszShortType := CoAllocCStr(GetShortNameStr(FReObject.poleobj));
  if @lpszLocation <> nil then
  begin
    if Trim(FRichEdit.Title) <> '' then
      lpszLocation := CoAllocCStr(Format('%s - %s', [FRichEdit.Title, Application.Title]))
    else
      lpszLocation := CoAllocCStr(Application.Title);
  end;
  Result := S_OK;
end;

function TOleUIObjInfo.GetViewInfo(dwObject: Longint; var hMetaPict: HGLOBAL;
  var dvAspect: Longint; var nCurrentScale: Integer): HRESULT;
begin
  if @hMetaPict <> nil then
    hMetaPict := GetIconMetaPict(FReObject.poleobj, FReObject.dvAspect);
  if @dvAspect <> nil then
    dvAspect := FReObject.dvAspect;
  if @nCurrentScale <> nil then
    nCurrentScale := 0;
  Result := S_OK;
end;

function TOleUIObjInfo.SetViewInfo(dwObject: Longint; hMetaPict: HGLOBAL;
  dvAspect: Longint; nCurrentScale: Integer;
  bRelativeToOrig: BOOL): HRESULT;
var
  Iconic: Boolean;
begin
  if Assigned(FRichEdit.FRichEditOle) then
  begin
    case dvAspect of
      DVASPECT_CONTENT:
        Iconic := False;
      DVASPECT_ICON:
        Iconic := True;
    else
      Iconic := FReObject.dvAspect = DVASPECT_ICON;
    end;
    IRichEditOle(FRichEdit.FRichEditOle).InPlaceDeactivate;
    Result := OleSetDrawAspect(FReObject.poleobj, Iconic, hMetaPict,
      FReObject.dvAspect);
    if Succeeded(Result) then
      IRichEditOle(FRichEdit.FRichEditOle).SetDvaspect(
        Longint(REO_IOB_SELECTION), FReObject.dvAspect);
  end
  else
    Result := E_NOTIMPL;
end;

//=== { TRichEditOleCallback } ===============================================

constructor TRichEditOleCallback.Create(ARichEdit: TJvCustomRichEdit);
begin
  inherited Create;
  FRichEdit := ARichEdit;
end;

destructor TRichEditOleCallback.Destroy;
begin
  DestroyAccelTable;
  FFrameForm := nil;
  FDocForm := nil;
  inherited Destroy;
end;

procedure TRichEditOleCallback.AssignFrame;
begin
  if (GetParentForm(FRichEdit) <> nil) and not Assigned(FFrameForm) and
    FRichEdit.AllowInPlace then
  begin
    FDocForm := GetVCLFrameForm(ValidParentForm(FRichEdit));
    FFrameForm := FDocForm;
    if IsFormMDIChild(FDocForm.Form) then
      FFrameForm := GetVCLFrameForm(Application.MainForm);
  end;
end;

function TRichEditOleCallback.ContextSensitiveHelp(fEnterMode: BOOL): HRESULT;
begin
  Result := NoError;
end;

procedure TRichEditOleCallback.CreateAccelTable;
var
  Menu: TMainMenu;
begin
  if (FAccelTable = 0) and Assigned(FFrameForm) then
  begin
    Menu := FFrameForm.Form.Menu;
    if Menu <> nil then
      Menu.GetOle2AcceleratorTable(FAccelTable, FAccelCount, [0, 2, 4]);
  end;
end;

function TRichEditOleCallback.DeleteObject(const oleobj: IOleObject): HRESULT;
begin
  if Assigned(oleobj) then
    oleobj.Close(OLECLOSE_NOSAVE);
  Result := NoError;
end;

procedure TRichEditOleCallback.DestroyAccelTable;
begin
  if FAccelTable <> 0 then
  begin
    DestroyAcceleratorTable(FAccelTable);
    FAccelTable := 0;
    FAccelCount := 0;
  end;
end;

function TRichEditOleCallback.GetClipboardData(const chrg: TCharRange; reco: DWORD;
  out dataObj: IDataObject): HRESULT;
begin
  // MSDN documentation: "If the SCODE of the return value is a failure other than
  // E_NOTIMPL, the operation fails." This seems to be incorrect: returning S_OK
  // otoh works, ie fails the operation.

  // cut commands are done as 'copy; delete'

  dataObj := nil;
  Result := E_NOTIMPL;
  case reco of
    RECO_COPY: if not (caCopy in FRichEdit.ClipboardCommands) then Result := S_OK;
    RECO_CUT: if not (caCut in FRichEdit.ClipboardCommands) then Result := S_OK;
    RECO_DRAG: ;
    RECO_DROP: ;
    RECO_PASTE: if not (caPaste in FRichEdit.ClipboardCommands) then Result := S_OK;
  end;
end;

function TRichEditOleCallback.GetContextMenu(seltype: Word;
  const oleobj: IOleObject; const chrg: TCharRange; out Menu: HMENU): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function EffectsToDropEffects(const dwEffect: Longint): TRichDropEffects;
begin
  Result := [];
  if dwEffect and DROPEFFECT_COPY > 0 then Include(Result, rdeCopy);
  if dwEffect and DROPEFFECT_MOVE > 0 then Include(Result, rdeMove);
  if dwEffect and DROPEFFECT_LINK > 0 then Include(Result, rdeLink);
  if dwEffect and DROPEFFECT_SCROLL > 0 then Include(Result, rdeScroll);
end;

function DropEffectsToEffects(const Effects: TRichDropEffects): Longint;
begin
  Result := 0;
  if rdeCopy in Effects then Inc(Result, DROPEFFECT_COPY);
  if rdeMove in Effects then Inc(Result, DROPEFFECT_MOVE);
  if rdeLink in Effects then Inc(Result, DROPEFFECT_LINK);
  if rdeScroll in Effects then Inc(Result, DROPEFFECT_SCROLL);
end;

function TRichEditOleCallback.GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
  var dwEffect: DWORD): HRESULT;
var
  ShiftState: TShiftState;
  DropEffects: TRichDropEffects;
  Handled: Boolean;
begin
  try
    ShiftState := KeysToShiftState(grfKeyState);
    DropEffects := EffectsToDropEffects(dwEffect);

    if fDrag then
      // dwEffect: its content is set to the effect allowable by the rich edit control.
      Handled := FRichEdit.DoDragAllowed(ShiftState, DropEffects)
    else
      // dwEffect: the variable is set to the effect to use.
      Handled := FRichEdit.DoGetDragDropEffect(ShiftState, DropEffects);

    if Handled then
    begin
      Result := S_OK;
      dwEffect := DropEffectsToEffects(DropEffects);
    end
    else
      // let the rich edit control specify the effects of a drop operation.
      Result := E_NOTIMPL;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TRichEditOleCallback.GetInPlaceContext(out Frame: IOleInPlaceFrame; out Doc: IOleInPlaceUIWindow;
  lpFrameInfo: POleInPlaceFrameInfo): HRESULT;
begin
  AssignFrame;
  if Assigned(FFrameForm) and FRichEdit.AllowInPlace then
  begin
    Frame := FFrameForm;
    Doc := FDocForm;
    CreateAccelTable;
    with lpFrameInfo^ do
    begin
      fMDIApp := False;
      FFrameForm.GetWindow(hwndFrame);
      haccel := FAccelTable;
      cAccelEntries := FAccelCount;
    end;
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

function TRichEditOleCallback.GetNewStorage(out stg: IStorage): HRESULT;
begin
  try
    CreateStorage(stg);
    Result := S_OK;
  except
    Result := E_OUTOFMEMORY;
  end;
end;

function TRichEditOleCallback.QueryAcceptData(const dataObj: IDataObject;
  var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL;
  hMetaPict: HGLOBAL): HRESULT;
var
  Handled: Boolean;
begin
  try
    Handled := FRichEdit.DoQueryAcceptData(dataObj, cfFormat, reco, fReally, hMetaPict);

    if Handled then
      // Callback imported the data itself
      Result := S_FALSE
    else
      // Let the rich edit control check the data itself for acceptable formats.
      Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TRichEditOleCallback.QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
  cp: Longint): HRESULT;
begin
  Result := NoError;
end;

function TRichEditOleCallback.QueryInterface(const iid: TGUID; out Obj): HRESULT;
begin
  if GetInterface(iid, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TRichEditOleCallback.ShowContainerUI(fShow: BOOL): HRESULT;
begin
  if not fShow then
    AssignFrame;
  if Assigned(FFrameForm) then
  begin
    if fShow then
    begin
      FFrameForm.SetMenu(0, 0, 0);
      FFrameForm.ClearBorderSpace;
      FRichEdit.SetUIActive(False);
      DestroyAccelTable;
      TForm(FFrameForm.Form).AutoScroll := FAutoScroll;
      FFrameForm := nil;
      FDocForm := nil;
    end
    else
    begin
      FAutoScroll := TForm(FFrameForm.Form).AutoScroll;
      TForm(FFrameForm.Form).AutoScroll := False;
      FRichEdit.SetUIActive(True);
    end;
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

function TRichEditOleCallback._AddRef: Longint;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TRichEditOleCallback._Release: Longint;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

{ Initialization part }

var
  GLibHandle: THandle = 0;

procedure InitRichEditDll;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  RichEditVersion := 1;
  {>>>}
  GLibHandle := SafeLoadLibrary(RichEditNewModuleName);
  if (GLibHandle > 0) and (GLibHandle < HINSTANCE_ERROR) then
    GLibHandle := 0;
  if GLibHandle <> 0 then begin
    RichEditVersion := 4;
    Exit;
  end;
  {<<<}
  GLibHandle := SafeLoadLibrary(RichEdit20ModuleName);
  if (GLibHandle > 0) and (GLibHandle < HINSTANCE_ERROR) then
    GLibHandle := 0;
  if GLibHandle = 0 then
  begin
    GLibHandle := SafeLoadLibrary(RichEdit10ModuleName);
    if (GLibHandle > 0) and (GLibHandle < HINSTANCE_ERROR) then
      GLibHandle := 0;
  end
  else
  begin
    RichEditVersion := 2;

    FileName := GetModuleName(GLibHandle);
    InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
    if InfoSize <> 0 then
    begin
      GetMem(VerBuf, InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
          begin
            if FI.dwFileVersionMS and $FFFF0000 = $00050000 then
              RichEditVersion := (FI.dwFileVersionMS and $FFFF) div 10
            else
            if FI.dwFileVersionMS and $FFFF0000 = $000C0000 then
              RichEditVersion := 3;
            if RichEditVersion = 0 then
              RichEditVersion := 2;
          end;
      finally
        FreeMem(VerBuf);
      end;
    end;
  end;
end;

procedure FinalRichEditDll;
begin
  if GLibHandle > 0 then
  begin
    FreeLibrary(GLibHandle);
    GLibHandle := 0;
  end;
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  InitRichEditDll;
  CFEmbeddedObject := RegisterClipboardFormat(CF_EMBEDDEDOBJECT);
  CFLinkSource := RegisterClipboardFormat(CF_LINKSOURCE);
  CFRtf := RegisterClipboardFormat(CF_RTF);
  CFRtfNoObjs := RegisterClipboardFormat(CF_RTFNOOBJS);

finalization
  FreeAndNil(GlobalConversionFormatList);
  FinalRichEditDll;
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.
