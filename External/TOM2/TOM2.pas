unit TOM2;

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

// $Rev: 8291 $
// File generated on 2018-11-21 04:32:34 from Type Library described below.

// ************************************************************************  //
// Type Lib: c:\Windows\System32\msftedit.dll (1)
// LIBID: {8CC497C9-A1DF-11CE-8098-00AA0047BE5D}
// LCID: 0
// Helpfile:
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Errors:
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Unit' of ITextSelection.MoveLeft changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextSelection.MoveRight changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextSelection.MoveUp changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextSelection.MoveDown changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextSelection.HomeKey changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextSelection.EndKey changed to 'Unit_'
//   Hint: Member 'End' of 'ITextRange' changed to 'End_'
//   Hint: Parameter 'Unit' of ITextRange.Expand changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.GetIndex changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.SetIndex changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.StartOf changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.EndOf changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.Move changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.MoveStart changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.MoveEnd changed to 'Unit_'
//   Hint: Parameter 'Unit' of ITextRange.Delete changed to 'Unit_'
//   Hint: Parameter 'Type' of ITextRange.ChangeCase changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange.GetPoint changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange.SetPoint changed to 'Type_'
//   Hint: Member 'Protected' of 'ITextFont' changed to 'Protected_'
//   Hint: Parameter 'Type' of ITextDocument2.GetClientRect changed to 'Type_'
//   Hint: Parameter 'Type' of ITextDocument2.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextDocument2.RangeFromPoint2 changed to 'Type_'
//   Hint: Parameter 'Type' of ITextDocument2.SetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextFont2.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextFont2.SetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextPara2.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextPara2.SetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange2.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange2.GetRect changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange2.SetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange2.SetInlineObject changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRange2.InsertImage changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRow.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextRow.SetProperty changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ITextStrings.EncodeFunction changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ITextStory.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of ITextStory.SetProperty changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'End' of 'ITextRange' changed to 'End_'
//   Hint: Member 'Protected' of 'ITextFont' changed to 'Protected_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties
// which return objects that may need to be explicitly created via a function
// call prior to any access via the property. These items have been disabled
// in order to prevent accidental use from within the object inspector. You
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively
// removing them from the $IFDEF blocks. However, such items must still be
// programmatically created via a method of the appropriate CoClass before
// they can be used.
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  tomMajorVersion = 1;
  tomMinorVersion = 0;

  LIBID_tom: TGUID = '{8CC497C9-A1DF-11CE-8098-00AA0047BE5D}';

  IID_ITextDocument: TGUID = '{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextRange: TGUID = '{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextSelection: TGUID = '{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextFont: TGUID = '{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextPara: TGUID = '{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextStoryRanges: TGUID = '{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextDocument2: TGUID = '{C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextDisplays: TGUID = '{C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextFont2: TGUID = '{C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextPara2: TGUID = '{C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextRange2: TGUID = '{C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextSelection2: TGUID = '{C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextRow: TGUID = '{C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_ITextStoryRanges2: TGUID = '{C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextStrings: TGUID = '{C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3}';
  IID_ITextStory: TGUID = '{C241F5F3-7206-11D8-A2C7-00A0D1D6C6B3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_tom_0000_0000_0001
type
  __MIDL___MIDL_itf_tom_0000_0000_0001 = TOleEnum;
const
  tomFalse = $00000000;
  tomTrue = Integer($FFFFFFFF);
  tomUndefined = Integer($FF676981);
  tomToggle = Integer($FF676982);
  tomAutoColor = Integer($FF676983);
  tomDefault = Integer($FF676984);
  tomSuspend = Integer($FF676985);
  tomResume = Integer($FF676986);
  tomApplyNow = $00000000;
  tomApplyLater = $00000001;
  tomTrackParms = $00000002;
  tomCacheParms = $00000003;
  tomApplyTmp = $00000004;
  tomDisableSmartFont = $00000008;
  tomEnableSmartFont = $00000009;
  tomUsePoints = $0000000A;
  tomUseTwips = $0000000B;
  tomBackward = $C0000001;
  tomForward = $3FFFFFFF;
  tomMove = $00000000;
  tomExtend = $00000001;
  tomNoSelection = $00000000;
  tomSelectionIP = $00000001;
  tomSelectionNormal = $00000002;
  tomSelectionFrame = $00000003;
  tomSelectionColumn = $00000004;
  tomSelectionRow = $00000005;
  tomSelectionBlock = $00000006;
  tomSelectionInlineShape = $00000007;
  tomSelectionShape = $00000008;
  tomSelStartActive = $00000001;
  tomSelAtEOL = $00000002;
  tomSelOvertype = $00000004;
  tomSelActive = $00000008;
  tomSelReplace = $00000010;
  tomSelMathZone = $00000020;
  tomSelIpAtRange = $00000040;
  tomEnd = $00000000;
  tomStart = $00000020;
  tomCollapseEnd = $00000000;
  tomCollapseStart = $00000001;
  tomClientCoord = $00000100;
  tomAllowOffClient = $00000200;
  tomTransform = $00000400;
  tomObjectArg = $00000800;
  tomAtEnd = $00001000;
  tomUseXamlRect = $00002000;
  tomImageTypeMask = $000000E0;
  tomInlineImage = $00000000;
  tomBackgroundImage = $00000020;
  tomWrapTextAround = $00000040;
  tomNoWrapSides = $00000060;
  tomNone = $00000000;
  tomSingle = $00000001;
  tomWords = $00000002;
  tomDouble = $00000003;
  tomDotted = $00000004;
  tomDash = $00000005;
  tomDashDot = $00000006;
  tomDashDotDot = $00000007;
  tomWave = $00000008;
  tomThick = $00000009;
  tomHair = $0000000A;
  tomDoubleWave = $0000000B;
  tomHeavyWave = $0000000C;
  tomLongDash = $0000000D;
  tomThickDash = $0000000E;
  tomThickDashDot = $0000000F;
  tomThickDashDotDot = $00000010;
  tomThickDotted = $00000011;
  tomThickLongDash = $00000012;
  tomLineSpaceSingle = $00000000;
  tomLineSpace1pt5 = $00000001;
  tomLineSpaceDouble = $00000002;
  tomLineSpaceAtLeast = $00000003;
  tomLineSpaceExactly = $00000004;
  tomLineSpaceMultiple = $00000005;
  tomLineSpacePercent = $00000006;
  tomAlignLeft = $00000000;
  tomAlignCenter = $00000001;
  tomAlignRight = $00000002;
  tomAlignJustify = $00000003;
  tomAlignDecimal = $00000003;
  tomAlignBar = $00000004;
  tomDefaultTab = $00000005;
  tomAlignInterWord = $00000003;
  tomAlignNewspaper = $00000004;
  tomAlignInterLetter = $00000005;
  tomAlignScaled = $00000006;
  tomSpaces = $00000000;
  tomDots = $00000001;
  tomDashes = $00000002;
  tomLines = $00000003;
  tomThickLines = $00000004;
  tomEquals = $00000005;
  tomTabBack = Integer($FFFFFFFD);
  tomTabNext = Integer($FFFFFFFE);
  tomTabHere = Integer($FFFFFFFF);
  tomListNone = $00000000;
  tomListBullet = $00000001;
  tomListNumberAsArabic = $00000002;
  tomListNumberAsLCLetter = $00000003;
  tomListNumberAsUCLetter = $00000004;
  tomListNumberAsLCRoman = $00000005;
  tomListNumberAsUCRoman = $00000006;
  tomListNumberAsSequence = $00000007;
  tomListNumberedCircle = $00000008;
  tomListNumberedBlackCircleWingding = $00000009;
  tomListNumberedWhiteCircleWingding = $0000000A;
  tomListNumberedArabicWide = $0000000B;
  tomListNumberedChS = $0000000C;
  tomListNumberedChT = $0000000D;
  tomListNumberedJpnChS = $0000000E;
  tomListNumberedJpnKor = $0000000F;
  tomListNumberedArabic1 = $00000010;
  tomListNumberedArabic2 = $00000011;
  tomListNumberedHebrew = $00000012;
  tomListNumberedThaiAlpha = $00000013;
  tomListNumberedThaiNum = $00000014;
  tomListNumberedHindiAlpha = $00000015;
  tomListNumberedHindiAlpha1 = $00000016;
  tomListNumberedHindiNum = $00000017;
  tomListParentheses = $00010000;
  tomListPeriod = $00020000;
  tomListPlain = $00030000;
  tomListNoNumber = $00040000;
  tomListMinus = $00080000;
  tomIgnoreNumberStyle = $01000000;
  tomParaStyleNormal = Integer($FFFFFFFF);
  tomParaStyleHeading1 = Integer($FFFFFFFE);
  tomParaStyleHeading2 = Integer($FFFFFFFD);
  tomParaStyleHeading3 = Integer($FFFFFFFC);
  tomParaStyleHeading4 = Integer($FFFFFFFB);
  tomParaStyleHeading5 = Integer($FFFFFFFA);
  tomParaStyleHeading6 = Integer($FFFFFFF9);
  tomParaStyleHeading7 = Integer($FFFFFFF8);
  tomParaStyleHeading8 = Integer($FFFFFFF7);
  tomParaStyleHeading9 = Integer($FFFFFFF6);
  tomCharacter = $00000001;
  tomWord = $00000002;
  tomSentence = $00000003;
  tomParagraph = $00000004;
  tomLine = $00000005;
  tomStory = $00000006;
  tomScreen = $00000007;
  tomSection = $00000008;
  tomTableColumn = $00000009;
  tomColumn = $00000009;
  tomRow = $0000000A;
  tomWindow = $0000000B;
  tomCell = $0000000C;
  tomCharFormat = $0000000D;
  tomParaFormat = $0000000E;
  tomTable = $0000000F;
  tomObject = $00000010;
  tomPage = $00000011;
  tomHardParagraph = $00000012;
  tomCluster = $00000013;
  tomInlineObject = $00000014;
  tomInlineObjectArg = $00000015;
  tomLeafLine = $00000016;
  tomLayoutColumn = $00000017;
  tomInlineObjectArgDelim = $00000018;
  tomSmartLink = $00000019;
  tomProcessId = $40000001;
  tomMatchWord = $00000002;
  tomMatchCase = $00000004;
  tomMatchPattern = $00000008;
  tomUnknownStory = $00000000;
  tomMainTextStory = $00000001;
  tomFootnotesStory = $00000002;
  tomEndnotesStory = $00000003;
  tomCommentsStory = $00000004;
  tomTextFrameStory = $00000005;
  tomEvenPagesHeaderStory = $00000006;
  tomPrimaryHeaderStory = $00000007;
  tomEvenPagesFooterStory = $00000008;
  tomPrimaryFooterStory = $00000009;
  tomFirstPageHeaderStory = $0000000A;
  tomFirstPageFooterStory = $0000000B;
  tomScratchStory = $0000007F;
  tomFindStory = $00000080;
  tomReplaceStory = $00000081;
  tomStoryInactive = $00000000;
  tomStoryActiveDisplay = $00000001;
  tomStoryActiveUI = $00000002;
  tomStoryActiveDisplayUI = $00000003;
  tomNoAnimation = $00000000;
  tomLasVegasLights = $00000001;
  tomBlinkingBackground = $00000002;
  tomSparkleText = $00000003;
  tomMarchingBlackAnts = $00000004;
  tomMarchingRedAnts = $00000005;
  tomShimmer = $00000006;
  tomWipeDown = $00000007;
  tomWipeRight = $00000008;
  tomAnimationMax = $00000008;
  tomLowerCase = $00000000;
  tomUpperCase = $00000001;
  tomTitleCase = $00000002;
  tomSentenceCase = $00000004;
  tomToggleCase = $00000005;
  tomReadOnly = $00000100;
  tomShareDenyRead = $00000200;
  tomShareDenyWrite = $00000400;
  tomPasteFile = $00001000;
  tomCreateNew = $00000010;
  tomCreateAlways = $00000020;
  tomOpenExisting = $00000030;
  tomOpenAlways = $00000040;
  tomTruncateExisting = $00000050;
  tomRTF = $00000001;
  tomText = $00000002;
  tomHTML = $00000003;
  tomWordDocument = $00000004;
  tomBold = $80000001;
  tomItalic = $80000002;
  tomUnderline = $80000004;
  tomStrikeout = $80000008;
  tomProtected = $80000010;
  tomLink = $80000020;
  tomSmallCaps = $80000040;
  tomAllCaps = $80000080;
  tomHidden = $80000100;
  tomOutline = $80000200;
  tomShadow = $80000400;
  tomEmboss = $80000800;
  tomImprint = $80001000;
  tomDisabled = $80002000;
  tomRevised = $80004000;
  tomSubscriptCF = $80010000;
  tomSuperscriptCF = $80020000;
  tomFontBound = $80100000;
  tomLinkProtected = $80800000;
  tomInlineObjectStart = $81000000;
  tomExtendedChar = $82000000;
  tomAutoBackColor = $84000000;
  tomMathZoneNoBuildUp = $88000000;
  tomMathZone = $90000000;
  tomMathZoneOrdinary = $A0000000;
  tomAutoTextColor = $C0000000;
  tomMathZoneDisplay = $00040000;
  tomParaEffectRTL = $00000001;
  tomParaEffectKeep = $00000002;
  tomParaEffectKeepNext = $00000004;
  tomParaEffectPageBreakBefore = $00000008;
  tomParaEffectNoLineNumber = $00000010;
  tomParaEffectNoWidowControl = $00000020;
  tomParaEffectDoNotHyphen = $00000040;
  tomParaEffectSideBySide = $00000080;
  tomParaEffectCollapsed = $00000100;
  tomParaEffectOutlineLevel = $00000200;
  tomParaEffectBox = $00000400;
  tomParaEffectTableRowDelimiter = $00001000;
  tomParaEffectTable = $00004000;
  tomModWidthPairs = $00000001;
  tomModWidthSpace = $00000002;
  tomAutoSpaceAlpha = $00000004;
  tomAutoSpaceNumeric = $00000008;
  tomAutoSpaceParens = $00000010;
  tomEmbeddedFont = $00000020;
  tomDoublestrike = $00000040;
  tomOverlapping = $00000080;
  tomNormalCaret = $00000000;
  tomKoreanBlockCaret = $00000001;
  tomNullCaret = $00000002;
  tomIncludeInset = $00000001;
  tomUnicodeBiDi = $00000001;
  tomMathCFCheck = $00000004;
  tomUnlink = $00000008;
  tomUnhide = $00000010;
  tomCheckTextLimit = $00000020;
  tomDontSelectText = $00000040;
  tomIgnoreCurrentFont = $00000000;
  tomMatchCharRep = $00000001;
  tomMatchFontSignature = $00000002;
  tomMatchAscii = $00000004;
  tomGetHeightOnly = $00000008;
  tomMatchMathFont = $00000010;
  tomCharset = $80000000;
  tomCharRepFromLcid = $40000000;
  tomAnsi = $00000000;
  tomEastEurope = $00000001;
  tomCyrillic = $00000002;
  tomGreek = $00000003;
  tomTurkish = $00000004;
  tomHebrew = $00000005;
  tomArabic = $00000006;
  tomBaltic = $00000007;
  tomVietnamese = $00000008;
  tomDefaultCharRep = $00000009;
  tomSymbol = $0000000A;
  tomThai = $0000000B;
  tomShiftJIS = $0000000C;
  tomGB2312 = $0000000D;
  tomHangul = $0000000E;
  tomBIG5 = $0000000F;
  tomPC437 = $00000010;
  tomOEM = $00000011;
  tomMac = $00000012;
  tomArmenian = $00000013;
  tomSyriac = $00000014;
  tomThaana = $00000015;
  tomDevanagari = $00000016;
  tomBengali = $00000017;
  tomGurmukhi = $00000018;
  tomGujarati = $00000019;
  tomOriya = $0000001A;
  tomTamil = $0000001B;
  tomTelugu = $0000001C;
  tomKannada = $0000001D;
  tomMalayalam = $0000001E;
  tomSinhala = $0000001F;
  tomLao = $00000020;
  tomTibetan = $00000021;
  tomMyanmar = $00000022;
  tomGeorgian = $00000023;
  tomJamo = $00000024;
  tomEthiopic = $00000025;
  tomCherokee = $00000026;
  tomAboriginal = $00000027;
  tomOgham = $00000028;
  tomRunic = $00000029;
  tomKhmer = $0000002A;
  tomMongolian = $0000002B;
  tomBraille = $0000002C;
  tomYi = $0000002D;
  tomLimbu = $0000002E;
  tomTaiLe = $0000002F;
  tomNewTaiLue = $00000030;
  tomSylotiNagri = $00000031;
  tomKharoshthi = $00000032;
  tomKayahli = $00000033;
  tomUsymbol = $00000034;
  tomEmoji = $00000035;
  tomGlagolitic = $00000036;
  tomLisu = $00000037;
  tomVai = $00000038;
  tomNKo = $00000039;
  tomOsmanya = $0000003A;
  tomPhagsPa = $0000003B;
  tomGothic = $0000003C;
  tomDeseret = $0000003D;
  tomTifinagh = $0000003E;
  tomCharRepMax = $0000003F;
  tomRE10Mode = $00000001;
  tomUseAtFont = $00000002;
  tomTextFlowMask = $0000000C;
  tomTextFlowES = $00000000;
  tomTextFlowSW = $00000004;
  tomTextFlowWN = $00000008;
  tomTextFlowNE = $0000000C;
  tomNoIME = $00080000;
  tomSelfIME = $00040000;
  tomNoUpScroll = $00010000;
  tomNoVpScroll = $00040000;
  tomNoLink = $00000000;
  tomClientLink = $00000001;
  tomFriendlyLinkName = $00000002;
  tomFriendlyLinkAddress = $00000003;
  tomAutoLinkURL = $00000004;
  tomAutoLinkEmail = $00000005;
  tomAutoLinkPhone = $00000006;
  tomAutoLinkPath = $00000007;
  tomCompressNone = $00000000;
  tomCompressPunctuation = $00000001;
  tomCompressPunctuationAndKana = $00000002;
  tomCompressMax = $00000002;
  tomUnderlinePositionAuto = $00000000;
  tomUnderlinePositionBelow = $00000001;
  tomUnderlinePositionAbove = $00000002;
  tomUnderlinePositionMax = $00000002;
  tomFontAlignmentAuto = $00000000;
  tomFontAlignmentTop = $00000001;
  tomFontAlignmentBaseline = $00000002;
  tomFontAlignmentBottom = $00000003;
  tomFontAlignmentCenter = $00000004;
  tomFontAlignmentMax = $00000004;
  tomRubyBelow = $00000080;
  tomRubyAlignCenter = $00000000;
  tomRubyAlign010 = $00000001;
  tomRubyAlign121 = $00000002;
  tomRubyAlignLeft = $00000003;
  tomRubyAlignRight = $00000004;
  tomLimitsDefault = $00000000;
  tomLimitsUnderOver = $00000001;
  tomLimitsSubSup = $00000002;
  tomUpperLimitAsSuperScript = $00000003;
  tomLimitsOpposite = $00000004;
  tomShowLLimPlaceHldr = $00000008;
  tomShowULimPlaceHldr = $00000010;
  tomDontGrowWithContent = $00000040;
  tomGrowWithContent = $00000080;
  tomSubSupAlign = $00000001;
  tomLimitAlignMask = $00000003;
  tomLimitAlignCenter = $00000000;
  tomLimitAlignLeft = $00000001;
  tomLimitAlignRight = $00000002;
  tomShowDegPlaceHldr = $00000008;
  tomAlignDefault = $00000000;
  tomAlignMatchAscentDescent = $00000002;
  tomMathVariant = $00000020;
  tomStyleDefault = $00000000;
  tomStyleScriptScriptCramped = $00000001;
  tomStyleScriptScript = $00000002;
  tomStyleScriptCramped = $00000003;
  tomStyleScript = $00000004;
  tomStyleTextCramped = $00000005;
  tomStyleText = $00000006;
  tomStyleDisplayCramped = $00000007;
  tomStyleDisplay = $00000008;
  tomMathRelSize = $00000040;
  tomDecDecSize = $000000FE;
  tomDecSize = $000000FF;
  tomIncSize = $00000041;
  tomIncIncSize = $00000042;
  tomGravityUI = $00000000;
  tomGravityBack = $00000001;
  tomGravityFore = $00000002;
  tomGravityIn = $00000003;
  tomGravityOut = $00000004;
  tomGravityBackward = $20000000;
  tomGravityForward = $40000000;
  tomTeX = $00000001;
  tomNeedTermOp = $00000002;
  tomOmitRubyText = $00000002;
  tomMathAlphabetics = $00000004;
  tomMathSingleChar = $00000008;
  tomPlain = $00000010;
  tomHaveDelimiter = $00000020;
  tomUseOperandPrec = $00000040;
  tomMathCollapseSel = $00000080;
  tomMathAutoCorrect = $00000100;
  tomMathBuildUpArgOrZone = $00000200;
  tomMathBuildUpRecurse = $00000400;
  tomMathBuildDownOutermost = $00000800;
  tomChemicalFormula = $00001000;
  tomMathBuildDown = $00002000;
  tomMathApplyTemplate = $00004000;
  tomMathRemoveOutermost = $00008000;
  tomMathChangeMask = $001F0000;
  tomMathInsRowBefore = $00010000;
  tomMathInsRowAfter = $00020000;
  tomMathInsColBefore = $00030000;
  tomMathInsColAfter = $00040000;
  tomMathDeleteRow = $00050000;
  tomMathDeleteCol = $00060000;
  tomMathDeleteArg = $00070000;
  tomMathDeleteArg1 = $00080000;
  tomMathDeleteArg2 = $00090000;
  tomMathMakeFracLinear = $000A0000;
  tomMathMakeFracStacked = $000B0000;
  tomMathMakeFracSlashed = $000C0000;
  tomMathMakeLeftSubSup = $000D0000;
  tomMathMakeSubSup = $000E0000;
  tomMathBackspace = $00100000;
  tomMathEnter = $00110000;
  tomMathShiftTab = $00120000;
  tomMathTab = $00130000;
  tomMathAlignBreakLeft = $00140000;
  tomMathAlignBreakCenter = $00150000;
  tomMathAlignBreakRight = $00160000;
  tomMathSubscript = $00170000;
  tomMathSuperscript = $00180000;
  tomBrailleIn = $00400000;
  tomMathArabicAlphabetics = $00800000;
  tomMathAutoCorrectOpPairs = $01000000;
  tomMathAutoCorrectExt = $02000000;
  tomShowEmptyArgPlaceholders = $04000000;
  tomMathAutoComplete = $08000000;
  tomMathSpeech = $10000000;
  tomMathRichEdit = $40000000;
  tomSpecialChar = $80000000;
  tomAdjustCRLF = $00000001;
  tomUseCRLF = $00000002;
  tomTextize = $00000004;
  tomAllowFinalEOP = $00000008;
  tomFoldMathAlpha = $00000010;
  tomNoHidden = $00000020;
  tomIncludeNumbering = $00000040;
  tomTranslateTableCell = $00000080;
  tomNoMathZoneBrackets = $00000100;
  tomConvertMathChar = $00000200;
  tomNoUCGreekItalic = $00000400;
  tomAllowMathBold = $00000800;
  tomLanguageTag = $00001000;
  tomConvertRTF = $00002000;
  tomApplyRtfDocProps = $00004000;
  tomGetTextForSpell = $00008000;
  tomConvertMathML = $00010000;
  tomGetUtf16 = $00020000;
  tomConvertLinearFormat = $00040000;
  tomConvertUnicodeMath = $00040000;
  tomConvertOMML = $00080000;
  tomConvertMask = $00F00000;
  tomConvertRuby = $00100000;
  tomConvertTeX = $00200000;
  tomConvertMathSpeech = $00300000;
  tomConvertSpeechTokens = $00400000;
  tomConvertNemeth = $00500000;
  tomConvertNemethAscii = $00600000;
  tomConvertNemethNoItalic = $00700000;
  tomConvertNemethDefinition = $00800000;
  tomConvertCRtoLF = $01000000;
  tomLaTeXDelim = $02000000;
  tomPhantomShow = $00000001;
  tomPhantomZeroWidth = $00000002;
  tomPhantomZeroAscent = $00000004;
  tomPhantomZeroDescent = $00000008;
  tomPhantomTransparent = $00000010;
  tomPhantomASmash = $00000005;
  tomPhantomDSmash = $00000009;
  tomPhantomHSmash = $00000003;
  tomPhantomSmash = $0000000D;
  tomPhantomHorz = $0000000C;
  tomPhantomVert = $00000002;
  tomBoxHideTop = $00000001;
  tomBoxHideBottom = $00000002;
  tomBoxHideLeft = $00000004;
  tomBoxHideRight = $00000008;
  tomBoxStrikeH = $00000010;
  tomBoxStrikeV = $00000020;
  tomBoxStrikeTLBR = $00000040;
  tomBoxStrikeBLTR = $00000080;
  tomRoundedBoxDashStyleMask = $00000007;
  tomRoundedBoxHideBorder = $00000008;
  tomRoundedBoxCapStyleMask = $00000030;
  tomRoundedBoxNullRadius = $00000040;
  tomRoundedBoxCompact = $00000080;
  tomBoxAlignCenter = $00000001;
  tomSpaceMask = $0000001C;
  tomSpaceDefault = $00000000;
  tomSpaceUnary = $00000004;
  tomSpaceBinary = $00000008;
  tomSpaceRelational = $0000000C;
  tomSpaceSkip = $00000010;
  tomSpaceOrd = $00000014;
  tomSpaceDifferential = $00000018;
  tomSizeText = $00000020;
  tomSizeScript = $00000040;
  tomSizeScriptScript = $00000060;
  tomNoBreak = $00000080;
  tomTransparentForPositioning = $00000100;
  tomTransparentForSpacing = $00000200;
  tomStretchCharBelow = $00000000;
  tomStretchCharAbove = $00000001;
  tomStretchBaseBelow = $00000002;
  tomStretchBaseAbove = $00000003;
  tomMatrixAlignMask = $00000003;
  tomMatrixAlignCenter = $00000000;
  tomMatrixAlignTopRow = $00000001;
  tomMatrixAlignBottomRow = $00000003;
  tomShowMatPlaceHldr = $00000008;
  tomEqArrayLayoutWidth = $00000001;
  tomEqArrayAlignMask = $0000000C;
  tomEqArrayAlignCenter = $00000000;
  tomEqArrayAlignTopRow = $00000004;
  tomEqArrayAlignBottomRow = $0000000C;
  tomMathManualBreakMask = $0000007F;
  tomMathBreakLeft = $0000007D;
  tomMathBreakCenter = $0000007E;
  tomMathBreakRight = $0000007F;
  tomMathEqAlign = $00000080;
  tomMathArgShadingStart = $00000251;
  tomMathArgShadingEnd = $00000252;
  tomMathObjShadingStart = $00000253;
  tomMathObjShadingEnd = $00000254;
  tomFunctionTypeNone = $00000000;
  tomFunctionTypeTakesArg = $00000001;
  tomFunctionTypeTakesLim = $00000002;
  tomFunctionTypeTakesLim2 = $00000003;
  tomFunctionTypeIsLim = $00000004;
  tomMathParaAlignDefault = $00000000;
  tomMathParaAlignCenterGroup = $00000001;
  tomMathParaAlignCenter = $00000002;
  tomMathParaAlignLeft = $00000003;
  tomMathParaAlignRight = $00000004;
  tomMathDispAlignMask = $00000003;
  tomMathDispAlignCenterGroup = $00000000;
  tomMathDispAlignCenter = $00000001;
  tomMathDispAlignLeft = $00000002;
  tomMathDispAlignRight = $00000003;
  tomMathDispIntUnderOver = $00000004;
  tomMathDispFracTeX = $00000008;
  tomMathDispNaryGrow = $00000010;
  tomMathDocEmptyArgMask = $00000060;
  tomMathDocEmptyArgAuto = $00000000;
  tomMathDocEmptyArgAlways = $00000020;
  tomMathDocEmptyArgNever = $00000040;
  tomMathDocSbSpOpUnchanged = $00000080;
  tomMathDocDiffMask = $00000300;
  tomMathDocDiffDefault = $00000000;
  tomMathDocDiffUpright = $00000100;
  tomMathDocDiffItalic = $00000200;
  tomMathDocDiffOpenItalic = $00000300;
  tomMathDispNarySubSup = $00000400;
  tomMathDispDef = $00000800;
  tomMathEnableRtl = $00001000;
  tomMathBrkBinMask = $00030000;
  tomMathBrkBinBefore = $00000000;
  tomMathBrkBinAfter = $00010000;
  tomMathBrkBinDup = $00020000;
  tomMathBrkBinSubMask = $000C0000;
  tomMathBrkBinSubMM = $00000000;
  tomMathBrkBinSubPM = $00040000;
  tomMathBrkBinSubMP = $00080000;
  tomSelRange = $00000255;
  tomHstring = $00000254;
  tomTeXBuildDown = $00000257;
  tomFontPropTeXStyle = $0000033C;
  tomFontPropAlign = $0000033D;
  tomFontStretch = $0000033E;
  tomFontStyle = $0000033F;
  tomFontStyleUpright = $00000000;
  tomFontStyleOblique = $00000001;
  tomFontStyleItalic = $00000002;
  tomFontStretchDefault = $00000000;
  tomFontStretchUltraCondensed = $00000001;
  tomFontStretchExtraCondensed = $00000002;
  tomFontStretchCondensed = $00000003;
  tomFontStretchSemiCondensed = $00000004;
  tomFontStretchNormal = $00000005;
  tomFontStretchSemiExpanded = $00000006;
  tomFontStretchExpanded = $00000007;
  tomFontStretchExtraExpanded = $00000008;
  tomFontStretchUltraExpanded = $00000009;
  tomFontWeightDefault = $00000000;
  tomFontWeightThin = $00000064;
  tomFontWeightExtraLight = $000000C8;
  tomFontWeightLight = $0000012C;
  tomFontWeightNormal = $00000190;
  tomFontWeightRegular = $00000190;
  tomFontWeightMedium = $000001F4;
  tomFontWeightSemiBold = $00000258;
  tomFontWeightBold = $000002BC;
  tomFontWeightExtraBold = $00000320;
  tomFontWeightBlack = $00000384;
  tomFontWeightHeavy = $00000384;
  tomFontWeightExtraBlack = $000003B6;
  tomFontWeightMax = $000003B6;
  tomParaPropMathAlign = $00000437;
  tomDocMathBuild = $00000080;
  tomMathLMargin = $00000081;
  tomMathRMargin = $00000082;
  tomMathWrapIndent = $00000083;
  tomMathWrapRight = $00000084;
  tomMathPostSpace = $00000086;
  tomMathPreSpace = $00000085;
  tomMathInterSpace = $00000087;
  tomMathIntraSpace = $00000088;
  tomCanCopy = $00000089;
  tomCanRedo = $0000008A;
  tomCanUndo = $0000008B;
  tomUndoLimit = $0000008C;
  tomDocAutoLink = $0000008D;
  tomEllipsisMode = $0000008E;
  tomEllipsisState = $0000008F;
  tomMathZoneSurround = $00000090;
  tomUnderlineTrailSpace = $00000091;
  tomAlignWithTrailSpace = $00000092;
  tomEncloseSurroundSpacing = $00000093;
  tomRichText = $00000094;
  tomIgnoreTrailSpacing = $00000095;
  tomStoryLength = $00000A40;
  tomEllipsisNone = $00000000;
  tomEllipsisEnd = $00000001;
  tomEllipsisWord = $00000003;
  tomEllipsisPresent = $00000001;
  tomVTopCell = $00000001;
  tomVLowCell = $00000002;
  tomHStartCell = $00000004;
  tomHContCell = $00000008;
  tomRowUpdate = $00000001;
  tomRowApplyDefault = $00000000;
  tomCellStructureChangeOnly = $00000001;
  tomRowHeightActual = $0000080B;
  tomImageFlipH = $00000001;
  tomImageFlipV = $00000002;
  tomImageRotate0 = $00000000;
  tomImageRotate90 = $00000001;
  tomImageRotate180 = $00000002;
  tomImageRotate270 = $00000003;

// Constants for enum __MIDL___MIDL_itf_tom_0000_0000_0002
type
  __MIDL___MIDL_itf_tom_0000_0000_0002 = TOleEnum;
const
  tomSimpleText = $00000000;
  tomRuby = $00000001;
  tomHorzVert = $00000002;
  tomWarichu = $00000003;
  tomHorzHorz = $00000004;
  tomEnclose = $00000005;
  tomEq = $00000009;
  tomMath = $0000000A;
  tomAccent = $0000000A;
  tomBox = $0000000B;
  tomBoxedFormula = $0000000C;
  tomBrackets = $0000000D;
  tomBracketsWithSeps = $0000000E;
  tomEquationArray = $0000000F;
  tomFraction = $00000010;
  tomFunctionApply = $00000011;
  tomLeftSubSup = $00000012;
  tomLowerLimit = $00000013;
  tomMatrix = $00000014;
  tomNary = $00000015;
  tomOpChar = $00000016;
  tomOverbar = $00000017;
  tomPhantom = $00000018;
  tomRadical = $00000019;
  tomSlashedFraction = $0000001A;
  tomStack = $0000001B;
  tomStretchStack = $0000001C;
  tomSubscript = $0000001D;
  tomSubSup = $0000001E;
  tomSuperscript = $0000001F;
  tomUnderbar = $00000020;
  tomUpperLimit = $00000021;
  tomObjectMax = $00000021;

// Constants for enum __MIDL___MIDL_itf_tom_0000_0000_0003
type
  __MIDL___MIDL_itf_tom_0000_0000_0003 = TOleEnum;
const
  MBOLD = $00000010;
  MITAL = $00000020;
  MGREEK = $00000040;
  MROMN = $00000000;
  MSCRP = $00000001;
  MFRAK = $00000002;
  MOPEN = $00000003;
  MSANS = $00000004;
  MMONO = $00000005;
  MMATH = $00000006;
  MISOL = $00000007;
  MINIT = $00000008;
  MTAIL = $00000009;
  MSTRCH = $0000000A;
  MLOOP = $0000000B;
  MOPENA = $0000000C;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITextDocument = interface;
  ITextDocumentDisp = dispinterface;
  ITextRange = interface;
  ITextRangeDisp = dispinterface;
  ITextSelection = interface;
  ITextSelectionDisp = dispinterface;
  ITextFont = interface;
  ITextFontDisp = dispinterface;
  ITextPara = interface;
  ITextParaDisp = dispinterface;
  ITextStoryRanges = interface;
  ITextStoryRangesDisp = dispinterface;
  ITextDocument2 = interface;
  ITextDocument2Disp = dispinterface;
  ITextDisplays = interface;
  ITextDisplaysDisp = dispinterface;
  ITextFont2 = interface;
  ITextFont2Disp = dispinterface;
  ITextPara2 = interface;
  ITextPara2Disp = dispinterface;
  ITextRange2 = interface;
  ITextRange2Disp = dispinterface;
  ITextSelection2 = interface;
  ITextSelection2Disp = dispinterface;
  ITextRow = interface;
  ITextRowDisp = dispinterface;
  ISequentialStream = interface;
  IStream = interface;
  ITextStoryRanges2 = interface;
  ITextStoryRanges2Disp = dispinterface;
  ITextStrings = interface;
  ITextStringsDisp = dispinterface;
  ITextStory = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PInteger1 = ^Integer; {*}
  PByte1 = ^Byte; {*}

  tomConstants = __MIDL___MIDL_itf_tom_0000_0000_0001; 
  OBJECTTYPE = __MIDL___MIDL_itf_tom_0000_0000_0002; 
  MANCODE = __MIDL___MIDL_itf_tom_0000_0000_0003; 

  _LARGE_INTEGER = packed record
    QuadPart: Int64;
  end;

  _ULARGE_INTEGER = packed record
    QuadPart: Largeuint;
  end;

  _FILETIME = packed record
    dwLowDateTime: LongWord;
    dwHighDateTime: LongWord;
  end;

  tagSTATSTG = packed record
    pwcsName: PWideChar;
    type_: LongWord;
    cbSize: _ULARGE_INTEGER;
    mtime: _FILETIME;
    ctime: _FILETIME;
    atime: _FILETIME;
    grfMode: LongWord;
    grfLocksSupported: LongWord;
    clsid: TGUID;
    grfStateBits: LongWord;
    reserved: LongWord;
  end;


// *********************************************************************//
// Interface: ITextDocument
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C0-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextDocument = interface(IDispatch)
    ['{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Name: WideString; safecall;
    function Get_Selection: ITextSelection; safecall;
    function Get_StoryCount: Integer; safecall;
    function Get_StoryRanges: ITextStoryRanges; safecall;
    function Get_Saved: Integer; safecall;
    procedure Set_Saved(pValue: Integer); safecall;
    function Get_DefaultTabStop: Single; safecall;
    procedure Set_DefaultTabStop(pValue: Single); safecall;
    procedure New; safecall;
    procedure Open(var pVar: OleVariant; Flags: Integer; CodePage: Integer); safecall;
    procedure Save(var pVar: OleVariant; Flags: Integer; CodePage: Integer); safecall;
    function Freeze: Integer; safecall;
    function Unfreeze: Integer; safecall;
    procedure BeginEditCollection; safecall;
    procedure EndEditCollection; safecall;
    function Undo(Count: Integer): Integer; safecall;
    function Redo(Count: Integer): Integer; safecall;
    function Range(cpActive: Integer; cpAnchor: Integer): ITextRange; safecall;
    function RangeFromPoint(x: Integer; y: Integer): ITextRange; safecall;
    property Name: WideString read Get_Name;
    property Selection: ITextSelection read Get_Selection;
    property StoryCount: Integer read Get_StoryCount;
    property StoryRanges: ITextStoryRanges read Get_StoryRanges;
    property Saved: Integer read Get_Saved write Set_Saved;
    property DefaultTabStop: Single read Get_DefaultTabStop write Set_DefaultTabStop;
  end;

// *********************************************************************//
// DispIntf:  ITextDocumentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C0-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextDocumentDisp = dispinterface
    ['{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}']
    property Name: WideString readonly dispid 0;
    property Selection: ITextSelection readonly dispid 1;
    property StoryCount: Integer readonly dispid 2;
    property StoryRanges: ITextStoryRanges readonly dispid 3;
    property Saved: Integer dispid 4;
    property DefaultTabStop: Single dispid 5;
    procedure New; dispid 6;
    procedure Open(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 7;
    procedure Save(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 8;
    function Freeze: Integer; dispid 9;
    function Unfreeze: Integer; dispid 10;
    procedure BeginEditCollection; dispid 11;
    procedure EndEditCollection; dispid 12;
    function Undo(Count: Integer): Integer; dispid 13;
    function Redo(Count: Integer): Integer; dispid 14;
    function Range(cpActive: Integer; cpAnchor: Integer): ITextRange; dispid 15;
    function RangeFromPoint(x: Integer; y: Integer): ITextRange; dispid 16;
  end;

// *********************************************************************//
// Interface: ITextRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C2-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextRange = interface(IDispatch)
    ['{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstr: WideString); safecall;
    function Get_Char: Integer; safecall;
    procedure Set_Char(pChar: Integer); safecall;
    function Get_Duplicate: ITextRange; safecall;
    function Get_FormattedText: ITextRange; safecall;
    procedure Set_FormattedText(const ppRange: ITextRange); safecall;
    function Get_Start: Integer; safecall;
    procedure Set_Start(pcpFirst: Integer); safecall;
    function Get_End_: Integer; safecall;
    procedure Set_End_(pcpLim: Integer); safecall;
    function Get_Font: ITextFont; safecall;
    procedure Set_Font(const ppFont: ITextFont); safecall;
    function Get_Para: ITextPara; safecall;
    procedure Set_Para(const ppPara: ITextPara); safecall;
    function Get_StoryLength: Integer; safecall;
    function Get_StoryType: Integer; safecall;
    procedure Collapse(bStart: Integer); safecall;
    function Expand(Unit_: Integer): Integer; safecall;
    function GetIndex(Unit_: Integer): Integer; safecall;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); safecall;
    procedure SetRange(cpAnchor: Integer; cpActive: Integer); safecall;
    function InRange(const pRange: ITextRange): Integer; safecall;
    function InStory(const pRange: ITextRange): Integer; safecall;
    function IsEqual(const pRange: ITextRange): Integer; safecall;
    procedure Select; safecall;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; safecall;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; safecall;
    function Move(Unit_: Integer; Count: Integer): Integer; safecall;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; safecall;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; safecall;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function FindText(const bstr: WideString; Count: Integer; Flags: Integer): Integer; safecall;
    function FindTextStart(const bstr: WideString; Count: Integer; Flags: Integer): Integer; safecall;
    function FindTextEnd(const bstr: WideString; Count: Integer; Flags: Integer): Integer; safecall;
    function Delete(Unit_: Integer; Count: Integer): Integer; safecall;
    procedure Cut(out pVar: OleVariant); safecall;
    procedure Copy(out pVar: OleVariant); safecall;
    procedure Paste(var pVar: OleVariant; Format: Integer); safecall;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; safecall;
    function CanEdit: Integer; safecall;
    procedure ChangeCase(Type_: Integer); safecall;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); safecall;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); safecall;
    procedure ScrollIntoView(Value: Integer); safecall;
    function GetEmbeddedObject: IUnknown; safecall;
    property Text: WideString read Get_Text write Set_Text;
    property Char: Integer read Get_Char write Set_Char;
    property Duplicate: ITextRange read Get_Duplicate;
    property FormattedText: ITextRange read Get_FormattedText write Set_FormattedText;
    property Start: Integer read Get_Start write Set_Start;
    property End_: Integer read Get_End_ write Set_End_;
    property Font: ITextFont read Get_Font write Set_Font;
    property Para: ITextPara read Get_Para write Set_Para;
    property StoryLength: Integer read Get_StoryLength;
    property StoryType: Integer read Get_StoryType;
  end;

// *********************************************************************//
// DispIntf:  ITextRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C2-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextRangeDisp = dispinterface
    ['{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}']
    property Text: WideString dispid 0;
    property Char: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property End_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function Expand(Unit_: Integer): Integer; dispid 529;
    function GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpAnchor: Integer; cpActive: Integer); dispid 532;
    function InRange(const pRange: ITextRange): Integer; dispid 533;
    function InStory(const pRange: ITextRange): Integer; dispid 534;
    function IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function FindText(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 560;
    function FindTextStart(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 561;
    function FindTextEnd(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 562;
    function Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function CanEdit: Integer; dispid 568;
    procedure ChangeCase(Type_: Integer); dispid 569;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// Interface: ITextSelection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C1-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextSelection = interface(ITextRange)
    ['{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Flags: Integer; safecall;
    procedure Set_Flags(pFlags: Integer); safecall;
    function Get_type_: Integer; safecall;
    function MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function HomeKey(Unit_: Integer; Extend: Integer): Integer; safecall;
    function EndKey(Unit_: Integer; Extend: Integer): Integer; safecall;
    procedure TypeText(const bstr: WideString); safecall;
    property Flags: Integer read Get_Flags write Set_Flags;
    property type_: Integer read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  ITextSelectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C1-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextSelectionDisp = dispinterface
    ['{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}']
    property Flags: Integer dispid 257;
    property type_: Integer readonly dispid 258;
    function MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 259;
    function MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 260;
    function MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 261;
    function MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 262;
    function HomeKey(Unit_: Integer; Extend: Integer): Integer; dispid 263;
    function EndKey(Unit_: Integer; Extend: Integer): Integer; dispid 264;
    procedure TypeText(const bstr: WideString); dispid 265;
    property Text: WideString dispid 0;
    property Char: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property End_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function Expand(Unit_: Integer): Integer; dispid 529;
    function GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpAnchor: Integer; cpActive: Integer); dispid 532;
    function InRange(const pRange: ITextRange): Integer; dispid 533;
    function InStory(const pRange: ITextRange): Integer; dispid 534;
    function IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function FindText(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 560;
    function FindTextStart(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 561;
    function FindTextEnd(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 562;
    function Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function CanEdit: Integer; dispid 568;
    procedure ChangeCase(Type_: Integer); dispid 569;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// Interface: ITextFont
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C3-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextFont = interface(IDispatch)
    ['{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Duplicate: ITextFont; safecall;
    procedure Set_Duplicate(const ppFont: ITextFont); safecall;
    function CanChange: Integer; safecall;
    function IsEqual(const pFont: ITextFont): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(pValue: Integer); safecall;
    function Get_AllCaps: Integer; safecall;
    procedure Set_AllCaps(pValue: Integer); safecall;
    function Get_Animation: Integer; safecall;
    procedure Set_Animation(pValue: Integer); safecall;
    function Get_BackColor: Integer; safecall;
    procedure Set_BackColor(pValue: Integer); safecall;
    function Get_Bold: Integer; safecall;
    procedure Set_Bold(pValue: Integer); safecall;
    function Get_Emboss: Integer; safecall;
    procedure Set_Emboss(pValue: Integer); safecall;
    function Get_ForeColor: Integer; safecall;
    procedure Set_ForeColor(pValue: Integer); safecall;
    function Get_Hidden: Integer; safecall;
    procedure Set_Hidden(pValue: Integer); safecall;
    function Get_Engrave: Integer; safecall;
    procedure Set_Engrave(pValue: Integer); safecall;
    function Get_Italic: Integer; safecall;
    procedure Set_Italic(pValue: Integer); safecall;
    function Get_Kerning: Single; safecall;
    procedure Set_Kerning(pValue: Single); safecall;
    function Get_LanguageID: Integer; safecall;
    procedure Set_LanguageID(pValue: Integer); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstr: WideString); safecall;
    function Get_Outline: Integer; safecall;
    procedure Set_Outline(pValue: Integer); safecall;
    function Get_Position: Single; safecall;
    procedure Set_Position(pValue: Single); safecall;
    function Get_Protected_: Integer; safecall;
    procedure Set_Protected_(pValue: Integer); safecall;
    function Get_Shadow: Integer; safecall;
    procedure Set_Shadow(pValue: Integer); safecall;
    function Get_Size: Single; safecall;
    procedure Set_Size(pValue: Single); safecall;
    function Get_SmallCaps: Integer; safecall;
    procedure Set_SmallCaps(pValue: Integer); safecall;
    function Get_Spacing: Single; safecall;
    procedure Set_Spacing(pValue: Single); safecall;
    function Get_StrikeThrough: Integer; safecall;
    procedure Set_StrikeThrough(pValue: Integer); safecall;
    function Get_Subscript: Integer; safecall;
    procedure Set_Subscript(pValue: Integer); safecall;
    function Get_Superscript: Integer; safecall;
    procedure Set_Superscript(pValue: Integer); safecall;
    function Get_Underline: Integer; safecall;
    procedure Set_Underline(pValue: Integer); safecall;
    function Get_Weight: Integer; safecall;
    procedure Set_Weight(pValue: Integer); safecall;
    property Duplicate: ITextFont read Get_Duplicate write Set_Duplicate;
    property Style: Integer read Get_Style write Set_Style;
    property AllCaps: Integer read Get_AllCaps write Set_AllCaps;
    property Animation: Integer read Get_Animation write Set_Animation;
    property BackColor: Integer read Get_BackColor write Set_BackColor;
    property Bold: Integer read Get_Bold write Set_Bold;
    property Emboss: Integer read Get_Emboss write Set_Emboss;
    property ForeColor: Integer read Get_ForeColor write Set_ForeColor;
    property Hidden: Integer read Get_Hidden write Set_Hidden;
    property Engrave: Integer read Get_Engrave write Set_Engrave;
    property Italic: Integer read Get_Italic write Set_Italic;
    property Kerning: Single read Get_Kerning write Set_Kerning;
    property LanguageID: Integer read Get_LanguageID write Set_LanguageID;
    property Name: WideString read Get_Name write Set_Name;
    property Outline: Integer read Get_Outline write Set_Outline;
    property Position: Single read Get_Position write Set_Position;
    property Protected_: Integer read Get_Protected_ write Set_Protected_;
    property Shadow: Integer read Get_Shadow write Set_Shadow;
    property Size: Single read Get_Size write Set_Size;
    property SmallCaps: Integer read Get_SmallCaps write Set_SmallCaps;
    property Spacing: Single read Get_Spacing write Set_Spacing;
    property StrikeThrough: Integer read Get_StrikeThrough write Set_StrikeThrough;
    property Subscript: Integer read Get_Subscript write Set_Subscript;
    property Superscript: Integer read Get_Superscript write Set_Superscript;
    property Underline: Integer read Get_Underline write Set_Underline;
    property Weight: Integer read Get_Weight write Set_Weight;
  end;

// *********************************************************************//
// DispIntf:  ITextFontDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C3-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextFontDisp = dispinterface
    ['{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}']
    property Duplicate: ITextFont dispid 0;
    function CanChange: Integer; dispid 769;
    function IsEqual(const pFont: ITextFont): Integer; dispid 770;
    procedure Reset(Value: Integer); dispid 771;
    property Style: Integer dispid 772;
    property AllCaps: Integer dispid 773;
    property Animation: Integer dispid 774;
    property BackColor: Integer dispid 775;
    property Bold: Integer dispid 776;
    property Emboss: Integer dispid 777;
    property ForeColor: Integer dispid 784;
    property Hidden: Integer dispid 785;
    property Engrave: Integer dispid 786;
    property Italic: Integer dispid 787;
    property Kerning: Single dispid 788;
    property LanguageID: Integer dispid 789;
    property Name: WideString dispid 790;
    property Outline: Integer dispid 791;
    property Position: Single dispid 792;
    property Protected_: Integer dispid 793;
    property Shadow: Integer dispid 800;
    property Size: Single dispid 801;
    property SmallCaps: Integer dispid 802;
    property Spacing: Single dispid 803;
    property StrikeThrough: Integer dispid 804;
    property Subscript: Integer dispid 805;
    property Superscript: Integer dispid 806;
    property Underline: Integer dispid 807;
    property Weight: Integer dispid 808;
  end;

// *********************************************************************//
// Interface: ITextPara
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C4-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextPara = interface(IDispatch)
    ['{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Duplicate: ITextPara; safecall;
    procedure Set_Duplicate(const ppPara: ITextPara); safecall;
    function CanChange: Integer; safecall;
    function IsEqual(const pPara: ITextPara): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(pValue: Integer); safecall;
    function Get_Alignment: Integer; safecall;
    procedure Set_Alignment(pValue: Integer); safecall;
    function Get_Hyphenation: Integer; safecall;
    procedure Set_Hyphenation(pValue: Integer); safecall;
    function Get_FirstLineIndent: Single; safecall;
    function Get_KeepTogether: Integer; safecall;
    procedure Set_KeepTogether(pValue: Integer); safecall;
    function Get_KeepWithNext: Integer; safecall;
    procedure Set_KeepWithNext(pValue: Integer); safecall;
    function Get_LeftIndent: Single; safecall;
    function Get_LineSpacing: Single; safecall;
    function Get_LineSpacingRule: Integer; safecall;
    function Get_ListAlignment: Integer; safecall;
    procedure Set_ListAlignment(pValue: Integer); safecall;
    function Get_ListLevelIndex: Integer; safecall;
    procedure Set_ListLevelIndex(pValue: Integer); safecall;
    function Get_ListStart: Integer; safecall;
    procedure Set_ListStart(pValue: Integer); safecall;
    function Get_ListTab: Single; safecall;
    procedure Set_ListTab(pValue: Single); safecall;
    function Get_ListType: Integer; safecall;
    procedure Set_ListType(pValue: Integer); safecall;
    function Get_NoLineNumber: Integer; safecall;
    procedure Set_NoLineNumber(pValue: Integer); safecall;
    function Get_PageBreakBefore: Integer; safecall;
    procedure Set_PageBreakBefore(pValue: Integer); safecall;
    function Get_RightIndent: Single; safecall;
    procedure Set_RightIndent(pValue: Single); safecall;
    procedure SetIndents(First: Single; Left: Single; Right: Single); safecall;
    procedure SetLineSpacing(Rule: Integer; Spacing: Single); safecall;
    function Get_SpaceAfter: Single; safecall;
    procedure Set_SpaceAfter(pValue: Single); safecall;
    function Get_SpaceBefore: Single; safecall;
    procedure Set_SpaceBefore(pValue: Single); safecall;
    function Get_WidowControl: Integer; safecall;
    procedure Set_WidowControl(pValue: Integer); safecall;
    function Get_TabCount: Integer; safecall;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); safecall;
    procedure ClearAllTabs; safecall;
    procedure DeleteTab(tbPos: Single); safecall;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer; 
                     out ptbLeader: Integer); safecall;
    property Duplicate: ITextPara read Get_Duplicate write Set_Duplicate;
    property Style: Integer read Get_Style write Set_Style;
    property Alignment: Integer read Get_Alignment write Set_Alignment;
    property Hyphenation: Integer read Get_Hyphenation write Set_Hyphenation;
    property FirstLineIndent: Single read Get_FirstLineIndent;
    property KeepTogether: Integer read Get_KeepTogether write Set_KeepTogether;
    property KeepWithNext: Integer read Get_KeepWithNext write Set_KeepWithNext;
    property LeftIndent: Single read Get_LeftIndent;
    property LineSpacing: Single read Get_LineSpacing;
    property LineSpacingRule: Integer read Get_LineSpacingRule;
    property ListAlignment: Integer read Get_ListAlignment write Set_ListAlignment;
    property ListLevelIndex: Integer read Get_ListLevelIndex write Set_ListLevelIndex;
    property ListStart: Integer read Get_ListStart write Set_ListStart;
    property ListTab: Single read Get_ListTab write Set_ListTab;
    property ListType: Integer read Get_ListType write Set_ListType;
    property NoLineNumber: Integer read Get_NoLineNumber write Set_NoLineNumber;
    property PageBreakBefore: Integer read Get_PageBreakBefore write Set_PageBreakBefore;
    property RightIndent: Single read Get_RightIndent write Set_RightIndent;
    property SpaceAfter: Single read Get_SpaceAfter write Set_SpaceAfter;
    property SpaceBefore: Single read Get_SpaceBefore write Set_SpaceBefore;
    property WidowControl: Integer read Get_WidowControl write Set_WidowControl;
    property TabCount: Integer read Get_TabCount;
  end;

// *********************************************************************//
// DispIntf:  ITextParaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C4-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextParaDisp = dispinterface
    ['{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}']
    property Duplicate: ITextPara dispid 0;
    function CanChange: Integer; dispid 1025;
    function IsEqual(const pPara: ITextPara): Integer; dispid 1026;
    procedure Reset(Value: Integer); dispid 1027;
    property Style: Integer dispid 1028;
    property Alignment: Integer dispid 1029;
    property Hyphenation: Integer dispid 1030;
    property FirstLineIndent: Single readonly dispid 1031;
    property KeepTogether: Integer dispid 1032;
    property KeepWithNext: Integer dispid 1033;
    property LeftIndent: Single readonly dispid 1040;
    property LineSpacing: Single readonly dispid 1041;
    property LineSpacingRule: Integer readonly dispid 1042;
    property ListAlignment: Integer dispid 1043;
    property ListLevelIndex: Integer dispid 1044;
    property ListStart: Integer dispid 1045;
    property ListTab: Single dispid 1046;
    property ListType: Integer dispid 1047;
    property NoLineNumber: Integer dispid 1048;
    property PageBreakBefore: Integer dispid 1049;
    property RightIndent: Single dispid 1056;
    procedure SetIndents(First: Single; Left: Single; Right: Single); dispid 1057;
    procedure SetLineSpacing(Rule: Integer; Spacing: Single); dispid 1058;
    property SpaceAfter: Single dispid 1059;
    property SpaceBefore: Single dispid 1060;
    property WidowControl: Integer dispid 1061;
    property TabCount: Integer readonly dispid 1062;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); dispid 1063;
    procedure ClearAllTabs; dispid 1064;
    procedure DeleteTab(tbPos: Single); dispid 1065;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer; 
                     out ptbLeader: Integer); dispid 1072;
  end;

// *********************************************************************//
// Interface: ITextStoryRanges
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C5-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextStoryRanges = interface(IDispatch)
    ['{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}']
    function _NewEnum: IUnknown; safecall;
    function Item(Index: Integer): ITextRange; safecall;
    function Get_Count: Integer; safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ITextStoryRangesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C5-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextStoryRangesDisp = dispinterface
    ['{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}']
    function _NewEnum: IUnknown; dispid -4;
    function Item(Index: Integer): ITextRange; dispid 0;
    property Count: Integer readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ITextDocument2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextDocument2 = interface(ITextDocument)
    ['{C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Get_CaretType: Integer; safecall;
    procedure Set_CaretType(pValue: Integer); safecall;
    function Get_Displays: ITextDisplays; safecall;
    function Get_DocumentFont: ITextFont2; safecall;
    procedure Set_DocumentFont(const ppFont: ITextFont2); safecall;
    function Get_DocumentPara: ITextPara2; safecall;
    procedure Set_DocumentPara(const ppPara: ITextPara2); safecall;
    function Get_EastAsianFlags: Integer; safecall;
    function Get_Generator: WideString; safecall;
    procedure Set_IMEInProgress(Param1: Integer); safecall;
    function Get_NotificationMode: Integer; safecall;
    procedure Set_NotificationMode(pValue: Integer); safecall;
    function Get_Selection2: ITextSelection2; safecall;
    function Get_StoryRanges2: ITextStoryRanges2; safecall;
    function Get_TypographyOptions: Integer; safecall;
    function Get_Version: Integer; safecall;
    function Get_Window: Int64; safecall;
    procedure AttachMsgFilter(const pFilter: IUnknown); safecall;
    procedure CheckTextLimit(Cch: Integer; var pcch: Integer); safecall;
    function GetCallManager: IUnknown; safecall;
    procedure GetClientRect(Type_: Integer; out pLeft: Integer; out pTop: Integer; 
                            out pRight: Integer; out pBottom: Integer); safecall;
    procedure GetEffectColor(Index: Integer; out pValue: Integer); safecall;
    function GetImmContext: Int64; safecall;
    procedure GetPreferredFont(cp: Integer; CharRep: Integer; Options: Integer; 
                               curCharRep: Integer; curFontSize: Integer; out pbstr: WideString; 
                               out pPitchAndFamily: Integer; out pNewFontSize: Integer); safecall;
    procedure GetProperty(Type_: Integer; out pValue: Integer); safecall;
    procedure GetStrings(out ppStrs: ITextStrings); safecall;
    procedure Notify(Notify: Integer); safecall;
    function Range2(cpActive: Integer; cpAnchor: Integer): ITextRange2; safecall;
    function RangeFromPoint2(x: Integer; y: Integer; Type_: Integer): ITextRange2; safecall;
    procedure ReleaseCallManager(const pVoid: IUnknown); safecall;
    procedure ReleaseImmContext(Context: Int64); safecall;
    procedure SetEffectColor(Index: Integer; Value: Integer); safecall;
    procedure SetProperty(Type_: Integer; Value: Integer); safecall;
    procedure SetTypographyOptions(Options: Integer; Mask: Integer); safecall;
    procedure SysBeep; safecall;
    procedure Update(Value: Integer); safecall;
    procedure UpdateWindow; safecall;
    procedure GetMathProperties(out pOptions: Integer); safecall;
    procedure SetMathProperties(Options: Integer; Mask: Integer); safecall;
    function Get_ActiveStory: ITextStory; safecall;
    procedure Set_ActiveStory(const ppStory: ITextStory); safecall;
    function Get_MainStory: ITextStory; safecall;
    function Get_NewStory: ITextStory; safecall;
    function GetStory(Index: Integer): ITextStory; safecall;
    property CaretType: Integer read Get_CaretType write Set_CaretType;
    property Displays: ITextDisplays read Get_Displays;
    property DocumentFont: ITextFont2 read Get_DocumentFont write Set_DocumentFont;
    property DocumentPara: ITextPara2 read Get_DocumentPara write Set_DocumentPara;
    property EastAsianFlags: Integer read Get_EastAsianFlags;
    property Generator: WideString read Get_Generator;
    property IMEInProgress: Integer write Set_IMEInProgress;
    property NotificationMode: Integer read Get_NotificationMode write Set_NotificationMode;
    property Selection2: ITextSelection2 read Get_Selection2;
    property StoryRanges2: ITextStoryRanges2 read Get_StoryRanges2;
    property TypographyOptions: Integer read Get_TypographyOptions;
    property Version: Integer read Get_Version;
    property Window: Int64 read Get_Window;
    property ActiveStory: ITextStory read Get_ActiveStory write Set_ActiveStory;
    property MainStory: ITextStory read Get_MainStory;
    property NewStory: ITextStory read Get_NewStory;
  end;

// *********************************************************************//
// DispIntf:  ITextDocument2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextDocument2Disp = dispinterface
    ['{C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3}']
    property CaretType: Integer dispid 17;
    property Displays: ITextDisplays readonly dispid 18;
    property DocumentFont: ITextFont2 dispid 19;
    property DocumentPara: ITextPara2 dispid 20;
    property EastAsianFlags: Integer readonly dispid 21;
    property Generator: WideString readonly dispid 22;
    property IMEInProgress: Integer writeonly dispid 23;
    property NotificationMode: Integer dispid 24;
    property Selection2: ITextSelection2 readonly dispid 25;
    property StoryRanges2: ITextStoryRanges2 readonly dispid 26;
    property TypographyOptions: Integer readonly dispid 27;
    property Version: Integer readonly dispid 28;
    property Window: {??Int64}OleVariant readonly dispid 29;
    procedure AttachMsgFilter(const pFilter: IUnknown); dispid 30;
    procedure CheckTextLimit(Cch: Integer; var pcch: Integer); dispid 31;
    function GetCallManager: IUnknown; dispid 32;
    procedure GetClientRect(Type_: Integer; out pLeft: Integer; out pTop: Integer; 
                            out pRight: Integer; out pBottom: Integer); dispid 33;
    procedure GetEffectColor(Index: Integer; out pValue: Integer); dispid 34;
    function GetImmContext: {??Int64}OleVariant; dispid 35;
    procedure GetPreferredFont(cp: Integer; CharRep: Integer; Options: Integer; 
                               curCharRep: Integer; curFontSize: Integer; out pbstr: WideString; 
                               out pPitchAndFamily: Integer; out pNewFontSize: Integer); dispid 36;
    procedure GetProperty(Type_: Integer; out pValue: Integer); dispid 37;
    procedure GetStrings(out ppStrs: ITextStrings); dispid 38;
    procedure Notify(Notify: Integer); dispid 39;
    function Range2(cpActive: Integer; cpAnchor: Integer): ITextRange2; dispid 40;
    function RangeFromPoint2(x: Integer; y: Integer; Type_: Integer): ITextRange2; dispid 41;
    procedure ReleaseCallManager(const pVoid: IUnknown); dispid 42;
    procedure ReleaseImmContext(Context: {??Int64}OleVariant); dispid 43;
    procedure SetEffectColor(Index: Integer; Value: Integer); dispid 44;
    procedure SetProperty(Type_: Integer; Value: Integer); dispid 45;
    procedure SetTypographyOptions(Options: Integer; Mask: Integer); dispid 46;
    procedure SysBeep; dispid 47;
    procedure Update(Value: Integer); dispid 48;
    procedure UpdateWindow; dispid 49;
    procedure GetMathProperties(out pOptions: Integer); dispid 50;
    procedure SetMathProperties(Options: Integer; Mask: Integer); dispid 51;
    property ActiveStory: ITextStory dispid 60;
    property MainStory: ITextStory readonly dispid 61;
    property NewStory: ITextStory readonly dispid 62;
    function GetStory(Index: Integer): ITextStory; dispid 66;
    property Name: WideString readonly dispid 0;
    property Selection: ITextSelection readonly dispid 1;
    property StoryCount: Integer readonly dispid 2;
    property StoryRanges: ITextStoryRanges readonly dispid 3;
    property Saved: Integer dispid 4;
    property DefaultTabStop: Single dispid 5;
    procedure New; dispid 6;
    procedure Open(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 7;
    procedure Save(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 8;
    function Freeze: Integer; dispid 9;
    function Unfreeze: Integer; dispid 10;
    procedure BeginEditCollection; dispid 11;
    procedure EndEditCollection; dispid 12;
    function Undo(Count: Integer): Integer; dispid 13;
    function Redo(Count: Integer): Integer; dispid 14;
    function Range(cpActive: Integer; cpAnchor: Integer): ITextRange; dispid 15;
    function RangeFromPoint(x: Integer; y: Integer): ITextRange; dispid 16;
  end;

// *********************************************************************//
// Interface: ITextDisplays
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextDisplays = interface(IDispatch)
    ['{C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3}']
  end;

// *********************************************************************//
// DispIntf:  ITextDisplaysDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextDisplaysDisp = dispinterface
    ['{C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3}']
  end;

// *********************************************************************//
// Interface: ITextFont2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextFont2 = interface(ITextFont)
    ['{C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Get_Count: Integer; safecall;
    function Get_AutoLigatures: Integer; safecall;
    procedure Set_AutoLigatures(pValue: Integer); safecall;
    function Get_AutospaceAlpha: Integer; safecall;
    procedure Set_AutospaceAlpha(pValue: Integer); safecall;
    function Get_AutospaceNumeric: Integer; safecall;
    procedure Set_AutospaceNumeric(pValue: Integer); safecall;
    function Get_AutospaceParens: Integer; safecall;
    procedure Set_AutospaceParens(pValue: Integer); safecall;
    function Get_CharRep: Integer; safecall;
    procedure Set_CharRep(pValue: Integer); safecall;
    function Get_CompressionMode: Integer; safecall;
    procedure Set_CompressionMode(pValue: Integer); safecall;
    function Get_Cookie: Integer; safecall;
    procedure Set_Cookie(pValue: Integer); safecall;
    function Get_DoubleStrike: Integer; safecall;
    procedure Set_DoubleStrike(pValue: Integer); safecall;
    function Get_Duplicate2: ITextFont2; safecall;
    procedure Set_Duplicate2(const ppFont: ITextFont2); safecall;
    function Get_LinkType: Integer; safecall;
    function Get_MathZone: Integer; safecall;
    procedure Set_MathZone(pValue: Integer); safecall;
    function Get_ModWidthPairs: Integer; safecall;
    procedure Set_ModWidthPairs(pValue: Integer); safecall;
    function Get_ModWidthSpace: Integer; safecall;
    procedure Set_ModWidthSpace(pValue: Integer); safecall;
    function Get_OldNumbers: Integer; safecall;
    procedure Set_OldNumbers(pValue: Integer); safecall;
    function Get_Overlapping: Integer; safecall;
    procedure Set_Overlapping(pValue: Integer); safecall;
    function Get_PositionSubSuper: Integer; safecall;
    procedure Set_PositionSubSuper(pValue: Integer); safecall;
    function Get_Scaling: Integer; safecall;
    procedure Set_Scaling(pValue: Integer); safecall;
    function Get_SpaceExtension: Single; safecall;
    procedure Set_SpaceExtension(pValue: Single); safecall;
    function Get_UnderlinePositionMode: Integer; safecall;
    procedure Set_UnderlinePositionMode(pValue: Integer); safecall;
    procedure GetEffects(out pValue: Integer; out pMask: Integer); safecall;
    procedure GetEffects2(out pValue: Integer; out pMask: Integer); safecall;
    function GetProperty(Type_: Integer): Integer; safecall;
    procedure GetPropertyInfo(Index: Integer; out pType: Integer; out pValue: Integer); safecall;
    function IsEqual2(const pFont: ITextFont2): Integer; safecall;
    procedure SetEffects(Value: Integer; Mask: Integer); safecall;
    procedure SetEffects2(Value: Integer; Mask: Integer); safecall;
    procedure SetProperty(Type_: Integer; Value: Integer); safecall;
    property Count: Integer read Get_Count;
    property AutoLigatures: Integer read Get_AutoLigatures write Set_AutoLigatures;
    property AutospaceAlpha: Integer read Get_AutospaceAlpha write Set_AutospaceAlpha;
    property AutospaceNumeric: Integer read Get_AutospaceNumeric write Set_AutospaceNumeric;
    property AutospaceParens: Integer read Get_AutospaceParens write Set_AutospaceParens;
    property CharRep: Integer read Get_CharRep write Set_CharRep;
    property CompressionMode: Integer read Get_CompressionMode write Set_CompressionMode;
    property Cookie: Integer read Get_Cookie write Set_Cookie;
    property DoubleStrike: Integer read Get_DoubleStrike write Set_DoubleStrike;
    property Duplicate2: ITextFont2 read Get_Duplicate2 write Set_Duplicate2;
    property LinkType: Integer read Get_LinkType;
    property MathZone: Integer read Get_MathZone write Set_MathZone;
    property ModWidthPairs: Integer read Get_ModWidthPairs write Set_ModWidthPairs;
    property ModWidthSpace: Integer read Get_ModWidthSpace write Set_ModWidthSpace;
    property OldNumbers: Integer read Get_OldNumbers write Set_OldNumbers;
    property Overlapping: Integer read Get_Overlapping write Set_Overlapping;
    property PositionSubSuper: Integer read Get_PositionSubSuper write Set_PositionSubSuper;
    property Scaling: Integer read Get_Scaling write Set_Scaling;
    property SpaceExtension: Single read Get_SpaceExtension write Set_SpaceExtension;
    property UnderlinePositionMode: Integer read Get_UnderlinePositionMode write Set_UnderlinePositionMode;
  end;

// *********************************************************************//
// DispIntf:  ITextFont2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextFont2Disp = dispinterface
    ['{C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3}']
    property Count: Integer readonly dispid 2;
    property AutoLigatures: Integer dispid 809;
    property AutospaceAlpha: Integer dispid 810;
    property AutospaceNumeric: Integer dispid 811;
    property AutospaceParens: Integer dispid 812;
    property CharRep: Integer dispid 813;
    property CompressionMode: Integer dispid 814;
    property Cookie: Integer dispid 815;
    property DoubleStrike: Integer dispid 816;
    property Duplicate2: ITextFont2 dispid 817;
    property LinkType: Integer readonly dispid 818;
    property MathZone: Integer dispid 819;
    property ModWidthPairs: Integer dispid 820;
    property ModWidthSpace: Integer dispid 821;
    property OldNumbers: Integer dispid 822;
    property Overlapping: Integer dispid 823;
    property PositionSubSuper: Integer dispid 824;
    property Scaling: Integer dispid 825;
    property SpaceExtension: Single dispid 826;
    property UnderlinePositionMode: Integer dispid 827;
    procedure GetEffects(out pValue: Integer; out pMask: Integer); dispid 832;
    procedure GetEffects2(out pValue: Integer; out pMask: Integer); dispid 833;
    function GetProperty(Type_: Integer): Integer; dispid 834;
    procedure GetPropertyInfo(Index: Integer; out pType: Integer; out pValue: Integer); dispid 835;
    function IsEqual2(const pFont: ITextFont2): Integer; dispid 836;
    procedure SetEffects(Value: Integer; Mask: Integer); dispid 837;
    procedure SetEffects2(Value: Integer; Mask: Integer); dispid 838;
    procedure SetProperty(Type_: Integer; Value: Integer); dispid 839;
    property Duplicate: ITextFont dispid 0;
    function CanChange: Integer; dispid 769;
    function IsEqual(const pFont: ITextFont): Integer; dispid 770;
    procedure Reset(Value: Integer); dispid 771;
    property Style: Integer dispid 772;
    property AllCaps: Integer dispid 773;
    property Animation: Integer dispid 774;
    property BackColor: Integer dispid 775;
    property Bold: Integer dispid 776;
    property Emboss: Integer dispid 777;
    property ForeColor: Integer dispid 784;
    property Hidden: Integer dispid 785;
    property Engrave: Integer dispid 786;
    property Italic: Integer dispid 787;
    property Kerning: Single dispid 788;
    property LanguageID: Integer dispid 789;
    property Name: WideString dispid 790;
    property Outline: Integer dispid 791;
    property Position: Single dispid 792;
    property Protected_: Integer dispid 793;
    property Shadow: Integer dispid 800;
    property Size: Single dispid 801;
    property SmallCaps: Integer dispid 802;
    property Spacing: Single dispid 803;
    property StrikeThrough: Integer dispid 804;
    property Subscript: Integer dispid 805;
    property Superscript: Integer dispid 806;
    property Underline: Integer dispid 807;
    property Weight: Integer dispid 808;
  end;

// *********************************************************************//
// Interface: ITextPara2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextPara2 = interface(ITextPara)
    ['{C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Get_Borders: IUnknown; safecall;
    function Get_Duplicate2: ITextPara2; safecall;
    procedure Set_Duplicate2(const ppPara: ITextPara2); safecall;
    function Get_FontAlignment: Integer; safecall;
    procedure Set_FontAlignment(pValue: Integer); safecall;
    function Get_HangingPunctuation: Integer; safecall;
    procedure Set_HangingPunctuation(pValue: Integer); safecall;
    function Get_SnapToGrid: Integer; safecall;
    procedure Set_SnapToGrid(pValue: Integer); safecall;
    function Get_TrimPunctuationAtStart: Integer; safecall;
    procedure Set_TrimPunctuationAtStart(pValue: Integer); safecall;
    procedure GetEffects(out pValue: Integer; out pMask: Integer); safecall;
    function GetProperty(Type_: Integer): Integer; safecall;
    function IsEqual2(const pPara: ITextPara2): Integer; safecall;
    procedure SetEffects(Value: Integer; Mask: Integer); safecall;
    procedure SetProperty(Type_: Integer; Value: Integer); safecall;
    property Borders: IUnknown read Get_Borders;
    property Duplicate2: ITextPara2 read Get_Duplicate2 write Set_Duplicate2;
    property FontAlignment: Integer read Get_FontAlignment write Set_FontAlignment;
    property HangingPunctuation: Integer read Get_HangingPunctuation write Set_HangingPunctuation;
    property SnapToGrid: Integer read Get_SnapToGrid write Set_SnapToGrid;
    property TrimPunctuationAtStart: Integer read Get_TrimPunctuationAtStart write Set_TrimPunctuationAtStart;
  end;

// *********************************************************************//
// DispIntf:  ITextPara2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextPara2Disp = dispinterface
    ['{C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3}']
    property Borders: IUnknown readonly dispid 1073;
    property Duplicate2: ITextPara2 dispid 1074;
    property FontAlignment: Integer dispid 1075;
    property HangingPunctuation: Integer dispid 1076;
    property SnapToGrid: Integer dispid 1077;
    property TrimPunctuationAtStart: Integer dispid 1078;
    procedure GetEffects(out pValue: Integer; out pMask: Integer); dispid 1088;
    function GetProperty(Type_: Integer): Integer; dispid 1089;
    function IsEqual2(const pPara: ITextPara2): Integer; dispid 1090;
    procedure SetEffects(Value: Integer; Mask: Integer); dispid 1091;
    procedure SetProperty(Type_: Integer; Value: Integer); dispid 1092;
    property Duplicate: ITextPara dispid 0;
    function CanChange: Integer; dispid 1025;
    function IsEqual(const pPara: ITextPara): Integer; dispid 1026;
    procedure Reset(Value: Integer); dispid 1027;
    property Style: Integer dispid 1028;
    property Alignment: Integer dispid 1029;
    property Hyphenation: Integer dispid 1030;
    property FirstLineIndent: Single readonly dispid 1031;
    property KeepTogether: Integer dispid 1032;
    property KeepWithNext: Integer dispid 1033;
    property LeftIndent: Single readonly dispid 1040;
    property LineSpacing: Single readonly dispid 1041;
    property LineSpacingRule: Integer readonly dispid 1042;
    property ListAlignment: Integer dispid 1043;
    property ListLevelIndex: Integer dispid 1044;
    property ListStart: Integer dispid 1045;
    property ListTab: Single dispid 1046;
    property ListType: Integer dispid 1047;
    property NoLineNumber: Integer dispid 1048;
    property PageBreakBefore: Integer dispid 1049;
    property RightIndent: Single dispid 1056;
    procedure SetIndents(First: Single; Left: Single; Right: Single); dispid 1057;
    procedure SetLineSpacing(Rule: Integer; Spacing: Single); dispid 1058;
    property SpaceAfter: Single dispid 1059;
    property SpaceBefore: Single dispid 1060;
    property WidowControl: Integer dispid 1061;
    property TabCount: Integer readonly dispid 1062;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); dispid 1063;
    procedure ClearAllTabs; dispid 1064;
    procedure DeleteTab(tbPos: Single); dispid 1065;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer; 
                     out ptbLeader: Integer); dispid 1072;
  end;

// *********************************************************************//
// Interface: ITextRange2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextRange2 = interface(ITextSelection)
    ['{C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Get_Cch: Integer; safecall;
    function Get_Cells: IUnknown; safecall;
    function Get_Column: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Get_Duplicate2: ITextRange2; safecall;
    function Get_Font2: ITextFont2; safecall;
    procedure Set_Font2(const ppFont: ITextFont2); safecall;
    function Get_FormattedText2: ITextRange2; safecall;
    procedure Set_FormattedText2(const ppRange: ITextRange2); safecall;
    function Get_Gravity: Integer; safecall;
    procedure Set_Gravity(pValue: Integer); safecall;
    function Get_Para2: ITextPara2; safecall;
    procedure Set_Para2(const ppPara: ITextPara2); safecall;
    function Get_Row: ITextRow; safecall;
    function Get_StartPara: Integer; safecall;
    function Get_Table: IUnknown; safecall;
    function Get_URL: WideString; safecall;
    procedure Set_URL(const pbstr: WideString); safecall;
    procedure AddSubrange(cp1: Integer; cp2: Integer; Activate: Integer); safecall;
    procedure BuildUpMath(Flags: Integer); safecall;
    procedure DeleteSubrange(cpFirst: Integer; cpLim: Integer); safecall;
    procedure Find(const pRange: ITextRange2; Count: Integer; Flags: Integer; out pDelta: Integer); safecall;
    procedure GetChar2(out pChar: Integer; Offset: Integer); safecall;
    procedure GetDropCap(out pcLine: Integer; out pPosition: Integer); safecall;
    procedure GetInlineObject(out pType: Integer; out pAlign: Integer; out pChar: Integer; 
                              out pChar1: Integer; out pChar2: Integer; out pCount: Integer; 
                              out pTeXStyle: Integer; out pcCol: Integer; out pLevel: Integer); safecall;
    procedure GetProperty(Type_: Integer; out pValue: Integer); safecall;
    procedure GetRect(Type_: Integer; out pLeft: Integer; out pTop: Integer; out pRight: Integer; 
                      out pBottom: Integer; out pHit: Integer); safecall;
    procedure GetSubrange(iSubrange: Integer; out pcpFirst: Integer; out pcpLim: Integer); safecall;
    procedure GetText2(Flags: Integer; out pbstr: WideString); safecall;
    procedure HexToUnicode; safecall;
    procedure InsertTable(cCol: Integer; cRow: Integer; AutoFit: Integer); safecall;
    procedure Linearize(Flags: Integer); safecall;
    procedure SetActiveSubrange(cpAnchor: Integer; cpActive: Integer); safecall;
    procedure SetDropCap(cLine: Integer; Position: Integer); safecall;
    procedure SetProperty(Type_: Integer; Value: Integer); safecall;
    procedure SetText2(Flags: Integer; const bstr: WideString); safecall;
    procedure UnicodeToHex; safecall;
    procedure SetInlineObject(Type_: Integer; Align: Integer; Char: Integer; Char1: Integer; 
                              Char2: Integer; Count: Integer; TeXStyle: Integer; cCol: Integer); safecall;
    procedure GetMathFunctionType(const bstr: WideString; out pValue: Integer); safecall;
    procedure InsertImage(width: Integer; Height: Integer; ascent: Integer; Type_: Integer; 
                          const bstrAltText: WideString; const pStream: IStream); safecall;
    property Cch: Integer read Get_Cch;
    property Cells: IUnknown read Get_Cells;
    property Column: IUnknown read Get_Column;
    property Count: Integer read Get_Count;
    property Duplicate2: ITextRange2 read Get_Duplicate2;
    property Font2: ITextFont2 read Get_Font2 write Set_Font2;
    property FormattedText2: ITextRange2 read Get_FormattedText2 write Set_FormattedText2;
    property Gravity: Integer read Get_Gravity write Set_Gravity;
    property Para2: ITextPara2 read Get_Para2 write Set_Para2;
    property Row: ITextRow read Get_Row;
    property StartPara: Integer read Get_StartPara;
    property Table: IUnknown read Get_Table;
    property URL: WideString read Get_URL write Set_URL;
  end;

// *********************************************************************//
// DispIntf:  ITextRange2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextRange2Disp = dispinterface
    ['{C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3}']
    property Cch: Integer readonly dispid 580;
    property Cells: IUnknown readonly dispid 581;
    property Column: IUnknown readonly dispid 582;
    property Count: Integer readonly dispid 583;
    property Duplicate2: ITextRange2 readonly dispid 584;
    property Font2: ITextFont2 dispid 585;
    property FormattedText2: ITextRange2 dispid 586;
    property Gravity: Integer dispid 587;
    property Para2: ITextPara2 dispid 588;
    property Row: ITextRow readonly dispid 589;
    property StartPara: Integer readonly dispid 590;
    property Table: IUnknown readonly dispid 591;
    property URL: WideString dispid 592;
    procedure AddSubrange(cp1: Integer; cp2: Integer; Activate: Integer); dispid 608;
    procedure BuildUpMath(Flags: Integer); dispid 609;
    procedure DeleteSubrange(cpFirst: Integer; cpLim: Integer); dispid 610;
    procedure Find(const pRange: ITextRange2; Count: Integer; Flags: Integer; out pDelta: Integer); dispid 611;
    procedure GetChar2(out pChar: Integer; Offset: Integer); dispid 612;
    procedure GetDropCap(out pcLine: Integer; out pPosition: Integer); dispid 613;
    procedure GetInlineObject(out pType: Integer; out pAlign: Integer; out pChar: Integer; 
                              out pChar1: Integer; out pChar2: Integer; out pCount: Integer; 
                              out pTeXStyle: Integer; out pcCol: Integer; out pLevel: Integer); dispid 614;
    procedure GetProperty(Type_: Integer; out pValue: Integer); dispid 615;
    procedure GetRect(Type_: Integer; out pLeft: Integer; out pTop: Integer; out pRight: Integer; 
                      out pBottom: Integer; out pHit: Integer); dispid 616;
    procedure GetSubrange(iSubrange: Integer; out pcpFirst: Integer; out pcpLim: Integer); dispid 617;
    procedure GetText2(Flags: Integer; out pbstr: WideString); dispid 618;
    procedure HexToUnicode; dispid 619;
    procedure InsertTable(cCol: Integer; cRow: Integer; AutoFit: Integer); dispid 620;
    procedure Linearize(Flags: Integer); dispid 621;
    procedure SetActiveSubrange(cpAnchor: Integer; cpActive: Integer); dispid 622;
    procedure SetDropCap(cLine: Integer; Position: Integer); dispid 623;
    procedure SetProperty(Type_: Integer; Value: Integer); dispid 624;
    procedure SetText2(Flags: Integer; const bstr: WideString); dispid 625;
    procedure UnicodeToHex; dispid 626;
    procedure SetInlineObject(Type_: Integer; Align: Integer; Char: Integer; Char1: Integer; 
                              Char2: Integer; Count: Integer; TeXStyle: Integer; cCol: Integer); dispid 627;
    procedure GetMathFunctionType(const bstr: WideString; out pValue: Integer); dispid 628;
    procedure InsertImage(width: Integer; Height: Integer; ascent: Integer; Type_: Integer; 
                          const bstrAltText: WideString; const pStream: IStream); dispid 629;
    property Flags: Integer dispid 257;
    property type_: Integer readonly dispid 258;
    function MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 259;
    function MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 260;
    function MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 261;
    function MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 262;
    function HomeKey(Unit_: Integer; Extend: Integer): Integer; dispid 263;
    function EndKey(Unit_: Integer; Extend: Integer): Integer; dispid 264;
    procedure TypeText(const bstr: WideString); dispid 265;
    property Text: WideString dispid 0;
    property Char: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property End_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function Expand(Unit_: Integer): Integer; dispid 529;
    function GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpAnchor: Integer; cpActive: Integer); dispid 532;
    function InRange(const pRange: ITextRange): Integer; dispid 533;
    function InStory(const pRange: ITextRange): Integer; dispid 534;
    function IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function FindText(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 560;
    function FindTextStart(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 561;
    function FindTextEnd(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 562;
    function Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function CanEdit: Integer; dispid 568;
    procedure ChangeCase(Type_: Integer); dispid 569;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// Interface: ITextSelection2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextSelection2 = interface(ITextRange2)
    ['{C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3}']
  end;

// *********************************************************************//
// DispIntf:  ITextSelection2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextSelection2Disp = dispinterface
    ['{C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3}']
    property Cch: Integer readonly dispid 580;
    property Cells: IUnknown readonly dispid 581;
    property Column: IUnknown readonly dispid 582;
    property Count: Integer readonly dispid 583;
    property Duplicate2: ITextRange2 readonly dispid 584;
    property Font2: ITextFont2 dispid 585;
    property FormattedText2: ITextRange2 dispid 586;
    property Gravity: Integer dispid 587;
    property Para2: ITextPara2 dispid 588;
    property Row: ITextRow readonly dispid 589;
    property StartPara: Integer readonly dispid 590;
    property Table: IUnknown readonly dispid 591;
    property URL: WideString dispid 592;
    procedure AddSubrange(cp1: Integer; cp2: Integer; Activate: Integer); dispid 608;
    procedure BuildUpMath(Flags: Integer); dispid 609;
    procedure DeleteSubrange(cpFirst: Integer; cpLim: Integer); dispid 610;
    procedure Find(const pRange: ITextRange2; Count: Integer; Flags: Integer; out pDelta: Integer); dispid 611;
    procedure GetChar2(out pChar: Integer; Offset: Integer); dispid 612;
    procedure GetDropCap(out pcLine: Integer; out pPosition: Integer); dispid 613;
    procedure GetInlineObject(out pType: Integer; out pAlign: Integer; out pChar: Integer; 
                              out pChar1: Integer; out pChar2: Integer; out pCount: Integer; 
                              out pTeXStyle: Integer; out pcCol: Integer; out pLevel: Integer); dispid 614;
    procedure GetProperty(Type_: Integer; out pValue: Integer); dispid 615;
    procedure GetRect(Type_: Integer; out pLeft: Integer; out pTop: Integer; out pRight: Integer; 
                      out pBottom: Integer; out pHit: Integer); dispid 616;
    procedure GetSubrange(iSubrange: Integer; out pcpFirst: Integer; out pcpLim: Integer); dispid 617;
    procedure GetText2(Flags: Integer; out pbstr: WideString); dispid 618;
    procedure HexToUnicode; dispid 619;
    procedure InsertTable(cCol: Integer; cRow: Integer; AutoFit: Integer); dispid 620;
    procedure Linearize(Flags: Integer); dispid 621;
    procedure SetActiveSubrange(cpAnchor: Integer; cpActive: Integer); dispid 622;
    procedure SetDropCap(cLine: Integer; Position: Integer); dispid 623;
    procedure SetProperty(Type_: Integer; Value: Integer); dispid 624;
    procedure SetText2(Flags: Integer; const bstr: WideString); dispid 625;
    procedure UnicodeToHex; dispid 626;
    procedure SetInlineObject(Type_: Integer; Align: Integer; Char: Integer; Char1: Integer; 
                              Char2: Integer; Count: Integer; TeXStyle: Integer; cCol: Integer); dispid 627;
    procedure GetMathFunctionType(const bstr: WideString; out pValue: Integer); dispid 628;
    procedure InsertImage(width: Integer; Height: Integer; ascent: Integer; Type_: Integer; 
                          const bstrAltText: WideString; const pStream: IStream); dispid 629;
    property Flags: Integer dispid 257;
    property type_: Integer readonly dispid 258;
    function MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 259;
    function MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 260;
    function MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 261;
    function MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 262;
    function HomeKey(Unit_: Integer; Extend: Integer): Integer; dispid 263;
    function EndKey(Unit_: Integer; Extend: Integer): Integer; dispid 264;
    procedure TypeText(const bstr: WideString); dispid 265;
    property Text: WideString dispid 0;
    property Char: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property End_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function Expand(Unit_: Integer): Integer; dispid 529;
    function GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpAnchor: Integer; cpActive: Integer); dispid 532;
    function InRange(const pRange: ITextRange): Integer; dispid 533;
    function InStory(const pRange: ITextRange): Integer; dispid 534;
    function IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function FindText(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 560;
    function FindTextStart(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 561;
    function FindTextEnd(const bstr: WideString; Count: Integer; Flags: Integer): Integer; dispid 562;
    function Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function CanEdit: Integer; dispid 568;
    procedure ChangeCase(Type_: Integer); dispid 569;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// Interface: ITextRow
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextRow = interface(IDispatch)
    ['{C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Get_Alignment: Integer; safecall;
    procedure Set_Alignment(pValue: Integer); safecall;
    function Get_CellCount: Integer; safecall;
    procedure Set_CellCount(pValue: Integer); safecall;
    function Get_CellCountCache: Integer; safecall;
    procedure Set_CellCountCache(pValue: Integer); safecall;
    function Get_CellIndex: Integer; safecall;
    procedure Set_CellIndex(pValue: Integer); safecall;
    function Get_CellMargin: Integer; safecall;
    procedure Set_CellMargin(pValue: Integer); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(pValue: Integer); safecall;
    function Get_Indent: Integer; safecall;
    procedure Set_Indent(pValue: Integer); safecall;
    function Get_KeepTogether: Integer; safecall;
    procedure Set_KeepTogether(pValue: Integer); safecall;
    function Get_KeepWithNext: Integer; safecall;
    procedure Set_KeepWithNext(pValue: Integer); safecall;
    function Get_NestLevel: Integer; safecall;
    function Get_RTL: Integer; safecall;
    procedure Set_RTL(pValue: Integer); safecall;
    function Get_CellAlignment: Integer; safecall;
    procedure Set_CellAlignment(pValue: Integer); safecall;
    function Get_CellColorBack: Integer; safecall;
    procedure Set_CellColorBack(pValue: Integer); safecall;
    function Get_CellColorFore: Integer; safecall;
    procedure Set_CellColorFore(pValue: Integer); safecall;
    function Get_CellMergeFlags: Integer; safecall;
    procedure Set_CellMergeFlags(pValue: Integer); safecall;
    function Get_CellShading: Integer; safecall;
    procedure Set_CellShading(pValue: Integer); safecall;
    function Get_CellVerticalText: Integer; safecall;
    procedure Set_CellVerticalText(pValue: Integer); safecall;
    function Get_CellWidth: Integer; safecall;
    procedure Set_CellWidth(pValue: Integer); safecall;
    procedure GetCellBorderColors(out pcrLeft: Integer; out pcrTop: Integer; out pcrRight: Integer; 
                                  out pcrBottom: Integer); safecall;
    procedure GetCellBorderWidths(out pduLeft: Integer; out pduTop: Integer; out pduRight: Integer; 
                                  out pduBottom: Integer); safecall;
    procedure SetCellBorderColors(crLeft: Integer; crTop: Integer; crRight: Integer; 
                                  crBottom: Integer); safecall;
    procedure SetCellBorderWidths(duLeft: Integer; duTop: Integer; duRight: Integer; 
                                  duBottom: Integer); safecall;
    procedure Apply(cRow: Integer; Flags: Integer); safecall;
    function CanChange: Integer; safecall;
    procedure GetProperty(Type_: Integer; out pValue: Integer); safecall;
    procedure Insert(cRow: Integer); safecall;
    function IsEqual(const pRow: ITextRow): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    procedure SetProperty(Type_: Integer; Value: Integer); safecall;
    property Alignment: Integer read Get_Alignment write Set_Alignment;
    property CellCount: Integer read Get_CellCount write Set_CellCount;
    property CellCountCache: Integer read Get_CellCountCache write Set_CellCountCache;
    property CellIndex: Integer read Get_CellIndex write Set_CellIndex;
    property CellMargin: Integer read Get_CellMargin write Set_CellMargin;
    property Height: Integer read Get_Height write Set_Height;
    property Indent: Integer read Get_Indent write Set_Indent;
    property KeepTogether: Integer read Get_KeepTogether write Set_KeepTogether;
    property KeepWithNext: Integer read Get_KeepWithNext write Set_KeepWithNext;
    property NestLevel: Integer read Get_NestLevel;
    property RTL: Integer read Get_RTL write Set_RTL;
    property CellAlignment: Integer read Get_CellAlignment write Set_CellAlignment;
    property CellColorBack: Integer read Get_CellColorBack write Set_CellColorBack;
    property CellColorFore: Integer read Get_CellColorFore write Set_CellColorFore;
    property CellMergeFlags: Integer read Get_CellMergeFlags write Set_CellMergeFlags;
    property CellShading: Integer read Get_CellShading write Set_CellShading;
    property CellVerticalText: Integer read Get_CellVerticalText write Set_CellVerticalText;
    property CellWidth: Integer read Get_CellWidth write Set_CellWidth;
  end;

// *********************************************************************//
// DispIntf:  ITextRowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextRowDisp = dispinterface
    ['{C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3}']
    property Alignment: Integer dispid 2048;
    property CellCount: Integer dispid 2049;
    property CellCountCache: Integer dispid 2050;
    property CellIndex: Integer dispid 2051;
    property CellMargin: Integer dispid 2052;
    property Height: Integer dispid 2053;
    property Indent: Integer dispid 2054;
    property KeepTogether: Integer dispid 2055;
    property KeepWithNext: Integer dispid 2056;
    property NestLevel: Integer readonly dispid 2057;
    property RTL: Integer dispid 2058;
    property CellAlignment: Integer dispid 2080;
    property CellColorBack: Integer dispid 2081;
    property CellColorFore: Integer dispid 2082;
    property CellMergeFlags: Integer dispid 2083;
    property CellShading: Integer dispid 2084;
    property CellVerticalText: Integer dispid 2085;
    property CellWidth: Integer dispid 2086;
    procedure GetCellBorderColors(out pcrLeft: Integer; out pcrTop: Integer; out pcrRight: Integer; 
                                  out pcrBottom: Integer); dispid 2096;
    procedure GetCellBorderWidths(out pduLeft: Integer; out pduTop: Integer; out pduRight: Integer; 
                                  out pduBottom: Integer); dispid 2097;
    procedure SetCellBorderColors(crLeft: Integer; crTop: Integer; crRight: Integer; 
                                  crBottom: Integer); dispid 2098;
    procedure SetCellBorderWidths(duLeft: Integer; duTop: Integer; duRight: Integer; 
                                  duBottom: Integer); dispid 2099;
    procedure Apply(cRow: Integer; Flags: Integer); dispid 2112;
    function CanChange: Integer; dispid 2113;
    procedure GetProperty(Type_: Integer; out pValue: Integer); dispid 2114;
    procedure Insert(cRow: Integer); dispid 2115;
    function IsEqual(const pRow: ITextRow): Integer; dispid 2116;
    procedure Reset(Value: Integer); dispid 2117;
    procedure SetProperty(Type_: Integer; Value: Integer); dispid 2118;
  end;

// *********************************************************************//
// Interface: ISequentialStream
// Flags:     (0)
// GUID:      {0C733A30-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStream
// Flags:     (0)
// GUID:      {0000000C-0000-0000-C000-000000000046}
// *********************************************************************//
  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function RemoteSeek(dlibMove: _LARGE_INTEGER; dwOrigin: LongWord; 
                        out plibNewPosition: _ULARGE_INTEGER): HResult; stdcall;
    function SetSize(libNewSize: _ULARGE_INTEGER): HResult; stdcall;
    function RemoteCopyTo(const pstm: IStream; cb: _ULARGE_INTEGER; out pcbRead: _ULARGE_INTEGER; 
                          out pcbWritten: _ULARGE_INTEGER): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function UnlockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
    function Clone(out ppstm: IStream): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextStoryRanges2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextStoryRanges2 = interface(ITextStoryRanges)
    ['{C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Item2(Index: Integer): ITextRange2; safecall;
  end;

// *********************************************************************//
// DispIntf:  ITextStoryRanges2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextStoryRanges2Disp = dispinterface
    ['{C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Item2(Index: Integer): ITextRange2; dispid 3;
    function _NewEnum: IUnknown; dispid -4;
    function Item(Index: Integer): ITextRange; dispid 0;
    property Count: Integer readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ITextStrings
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextStrings = interface(IDispatch)
    ['{C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Item(Index: Integer): ITextRange2; safecall;
    function Get_Count: Integer; safecall;
    procedure Add(const bstr: WideString); safecall;
    procedure Append(const pRange: ITextRange2; iString: Integer); safecall;
    procedure Cat2(iString: Integer); safecall;
    procedure CatTop2(const bstr: WideString); safecall;
    procedure DeleteRange(const pRange: ITextRange2); safecall;
    procedure EncodeFunction(Type_: Integer; Align: Integer; Char: Integer; Char1: Integer; 
                             Char2: Integer; Count: Integer; TeXStyle: Integer; cCol: Integer; 
                             const pRange: ITextRange2); safecall;
    procedure GetCch(iString: Integer; out pcch: Integer); safecall;
    procedure InsertNullStr(iString: Integer); safecall;
    procedure MoveBoundary(iString: Integer; Cch: Integer); safecall;
    procedure PrefixTop(const bstr: WideString); safecall;
    procedure Remove(iString: Integer; cString: Integer); safecall;
    procedure SetFormattedText(const pRangeD: ITextRange2; const pRangeS: ITextRange2); safecall;
    procedure SetOpCp(iString: Integer; cp: Integer); safecall;
    procedure SuffixTop(const bstr: WideString; const pRange: ITextRange2); safecall;
    procedure Swap; safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ITextStringsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextStringsDisp = dispinterface
    ['{C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Item(Index: Integer): ITextRange2; dispid 0;
    property Count: Integer readonly dispid 2;
    procedure Add(const bstr: WideString); dispid 3;
    procedure Append(const pRange: ITextRange2; iString: Integer); dispid 4;
    procedure Cat2(iString: Integer); dispid 5;
    procedure CatTop2(const bstr: WideString); dispid 6;
    procedure DeleteRange(const pRange: ITextRange2); dispid 7;
    procedure EncodeFunction(Type_: Integer; Align: Integer; Char: Integer; Char1: Integer; 
                             Char2: Integer; Count: Integer; TeXStyle: Integer; cCol: Integer; 
                             const pRange: ITextRange2); dispid 8;
    procedure GetCch(iString: Integer; out pcch: Integer); dispid 9;
    procedure InsertNullStr(iString: Integer); dispid 10;
    procedure MoveBoundary(iString: Integer; Cch: Integer); dispid 11;
    procedure PrefixTop(const bstr: WideString); dispid 12;
    procedure Remove(iString: Integer; cString: Integer); dispid 13;
    procedure SetFormattedText(const pRangeD: ITextRange2; const pRangeS: ITextRange2); dispid 14;
    procedure SetOpCp(iString: Integer; cp: Integer); dispid 15;
    procedure SuffixTop(const bstr: WideString; const pRange: ITextRange2); dispid 16;
    procedure Swap; dispid 17;
  end;

// *********************************************************************//
// Interface: ITextStory
// Flags:     (128) NonExtensible
// GUID:      {C241F5F3-7206-11D8-A2C7-00A0D1D6C6B3}
// *********************************************************************//
  ITextStory = interface(IUnknown)
    ['{C241F5F3-7206-11D8-A2C7-00A0D1D6C6B3}']
    function Get_Active(out pValue: Integer): HResult; stdcall;
    function Set_Active(pValue: Integer): HResult; stdcall;
    function Get_Display(out ppDisplay: IUnknown): HResult; stdcall;
    function Get_Index(out pValue: Integer): HResult; stdcall;
    function Get_type_(out pValue: Integer): HResult; stdcall;
    function Set_type_(pValue: Integer): HResult; stdcall;
    function GetProperty(Type_: Integer; out pValue: Integer): HResult; stdcall;
    function GetRange(cpActive: Integer; cpAnchor: Integer; out ppRange: ITextRange2): HResult; stdcall;
    function GetText(Flags: Integer; out pbstr: WideString): HResult; stdcall;
    function SetFormattedText(const pUnk: IUnknown): HResult; stdcall;
    function SetProperty(Type_: Integer; Value: Integer): HResult; stdcall;
    function SetText(Flags: Integer; const bstr: WideString): HResult; stdcall;
  end;

implementation

uses ComObj;

end.
