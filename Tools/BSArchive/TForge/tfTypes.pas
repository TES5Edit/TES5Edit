{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2016         * }
{ *********************************************************** }

unit tfTypes;

{$I TFL.inc}

interface

uses
  tfLimbs;

type
//  PInt8 = ^Int8;
//  PUInt8 = ^UInt8;
//  PInt16 = ^Int16;
//  PUInt16 = ^UInt16;
  PInt32 = ^Int32;
  PUInt32 = ^UInt32;

type
  TF_RESULT = type Int32;

// Codes returned by TF functions; see also
//   http://msdn.microsoft.com/en-us/library/cc231198(v=prot.10).aspx
//   http://msdn.microsoft.com/en-us/library/windows/desktop/aa378137(v=vs.85).aspx
const
                                              // = common microsoft codes =
  TF_S_OK           = TF_RESULT(0);           // Operation successful
  TF_S_FALSE        = TF_RESULT(1);           // Operation successful
  TF_E_FAIL         = TF_RESULT($80004005);   // Unspecified failure
  TF_E_INVALIDARG   = TF_RESULT($80070057);   // One or more arguments are not valid
  TF_E_NOINTERFACE  = TF_RESULT($80004002);   // No such interface supported
  TF_E_NOTIMPL      = TF_RESULT($80004001);   // Not implemented
  TF_E_OUTOFMEMORY  = TF_RESULT($8007000E);   // Failed to allocate necessary memory
  TF_E_UNEXPECTED   = TF_RESULT($8000FFFF);   // Unexpected failure

                                              // = tforge codes =
  TF_E_NOMEMORY     = TF_RESULT($A0000003);   // specific TFL memory error
  TF_E_LOADERROR    = TF_RESULT($A0000004);   // Error loading tforge dll

//  TF_E_STATE        = TF_RESULT($A0001001);   // Invalid instance state

{$IFNDEF FPC}
const
  FPC_VERSION = 2;
  FPC_RELEASE = 6;
{$ELSE}
type
  TBytes = array of Byte;
  PUInt64 = ^UInt64;
{$IF FPC_VERSION = 2}
  {$IF FPC_RELEASE <= 6}
type
  RawByteString = AnsiString;
  {$IFEND}
{$IFEND}

{$ENDIF}

type
  IRandom = interface(IInterface)
    procedure Burn;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetRand(Buf: PByte; BufLen: Cardinal): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

  IBytesEnumerator = interface(IInterface)
    function GetCurrent: Byte;
    function MoveNext: Boolean;
    procedure Reset;
    property Current: Byte read GetCurrent;
  end;

  IBytes = interface(IInterface)
    procedure Burn;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetEnum(var R: IBytesEnumerator): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function GetHashCode: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetLen: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SetLen(Value: Integer): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetRawData: PByte;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AssignBytes(var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CopyBytes(var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CopyBytes1(var R: IBytes; I: Cardinal): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CopyBytes2(var R: IBytes; I, L: Cardinal): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function RemoveBytes1(var R: IBytes; I: Cardinal): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function RemoveBytes2(var R: IBytes; I, L: Cardinal): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ReverseBytes(var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ConcatBytes(const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function InsertBytes(Index: Cardinal; const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EqualBytes(const B: IBytes): Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AddBytes(const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubBytes(const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AndBytes(const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function OrBytes(const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function XorBytes(const B: IBytes; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AppendByte(B: Byte; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function InsertByte(Index: Cardinal; B: Byte; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EqualToByte(B: Byte): Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AppendPByte(P: PByte; L: Cardinal; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function InsertPByte(Index: Cardinal; P: PByte; L: Cardinal; var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EqualToPByte(P: PByte; L: Integer): Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ToDec(var R: IBytes): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function Incr: TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Decr: TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    procedure Fill(Value: Byte);{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ToInt(Data: PByte; L: Cardinal; Reversed: Boolean): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function IncrLE: TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DecrLE: TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ShiftLeft(Shift: Cardinal; var R: IBytes): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ShiftRight(Shift: Cardinal; var R: IBytes): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function GetBitSet(Shift: Cardinal): Boolean;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetSeniorBit: Integer;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

  end;

(*
  IBytesServer = interface(IInterface)
    function Allocate(var A: IBytes; ASize: Cardinal): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ReAllocate(var A: IBytes; ASize: Cardinal): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function FromPByte(var A: IBytes; P: PByte; L: Cardinal): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function FromPCharHex(var A: IBytes; P: PByte; L: Cardinal; CharSize: Cardinal): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function FromByte(var A: IBytes; Value: Byte): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;
*)

type
  IBigNumber = interface(IInterface)
    procedure Burn;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetHashCode: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetLen: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetRawData: PByte;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function GetIsEven: Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetIsOne: Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetIsPowerOfTwo: Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetIsZero: Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetSign: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetSize: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function CompareNumber(const Num: IBigNumber): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareNumberU(const Num: IBigNumber): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EqualsNumber(const Num: IBigNumber): Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EqualsNumberU(const Num: IBigNumber): Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AddNumber(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AddNumberU(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubNumber(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubNumberU(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function MulNumber(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function MulNumberU(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemNumber(const Num: IBigNumber; var Q, R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemNumberU(const Num: IBigNumber; var Q, R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AndNumber(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AndNumberU(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function OrNumber(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function OrNumberU(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function XorNumber(const Num: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ShlNumber(Shift: Cardinal; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ShrNumber(Shift: Cardinal; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AssignNumber(var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AbsNumber(var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function NegateNumber(var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DuplicateNumber(var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Pow(Value: Cardinal; var IRes: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function PowU(Value: Cardinal; var IRes: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function SqrNumber(const A: IBigNumber; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SqrtNumber(var IRes: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GCD(const B: IBigNumber; var G: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EGCD(const B: IBigNumber; var G, X, Y: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function LCM(const B: IBigNumber; var G: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ModPow(const IExp, IMod: IBigNumber; var IRes: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ModInverse(const M: IBigNumber; var R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ToLimb(var Value: TLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ToIntLimb(var Value: TIntLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ToDec(P: PByte; var L: Integer): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ToHex(P: PByte; var L: Integer; TwoCompl: Boolean): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ToPByte(P: PByte; var L: Cardinal): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function CompareToLimb(Limb: TLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToLimbU(Limb: TLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToIntLimb(Limb: TIntLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToIntLimbU(Limb: TIntLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function AddLimb(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AddLimbU(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AddIntLimb(Limb: TIntLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function SubLimb(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubLimb2(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubLimbU(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubLimbU2(Limb: TLimb; var Res: TLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubIntLimb(Limb: TIntLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubIntLimb2(Limb: TIntLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function MulLimb(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function MulLimbU(Limb: TLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function MulIntLimb(Limb: TIntLimb; var Res: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function DivRemLimb(Limb: TLimb; var Q: IBigNumber; var R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemLimb2(Limb: TLimb; var Q: IBigNumber; var R: TLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemLimbU(Limb: TLimb; var Q: IBigNumber; var R: TLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemLimbU2(Limb: TLimb; var Q: TLimb; var R: TLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemIntLimb(Limb: TIntLimb; var Q: IBigNumber; var R: TIntLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DivRemIntLimb2(Limb: TIntLimb; var Q: TIntLimb; var R: TIntLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function NextNumber(var R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function NextNumberU(var R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function PrevNumber(var R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function PrevNumberU(var R: IBigNumber): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function GetLimb(var Value: TLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetDblLimb(var Value: TDLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function ToDblLimb(var Value: TDLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ToDblIntLimb(var Value: TDIntLimb): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToDblLimb(B: TDLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToDblLimbU(B: TDLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToDblIntLimb(B: TDIntLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function CompareToDblIntLimbU(B: TDIntLimb): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

type
  IMont = interface(IInterface)
    procedure Burn;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Reduce(const A: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Convert(const A: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function AddNumbers(const A, B: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SubNumbers(const A, B: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function MulNumbers(const A, B: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ModMulNumbers(const A, B: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ModPowNumber(const A, B: IBigNumber; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ModPowLimb(const A: IBigNumber; B: TLimb; var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetRModulus(var Res: IBigNumber): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;


const
                            // Cryptographic Hash Algorithms
  TF_ALG_MD5      = $1001;
  TF_ALG_SHA1     = $1002;
  TF_ALG_SHA256   = $1003;
  TF_ALG_SHA512   = $1004;
  TF_ALG_SHA224   = $1005;
  TF_ALG_SHA384   = $1006;
                            // Non-cryptographic Hash Algorithms
  TF_ALG_CRC32    = $1801;
  TF_ALG_JENKINS1 = $1802;
                            // Block ciphers
  TF_ALG_AES      = $2001;
  TF_ALG_DES      = $2002;
  TF_ALG_RC5      = $2003;
  TF_ALG_3DES     = $2004;
                            // Stream ciphers
  TF_ALG_RC4      = $2801;
  TF_ALG_SALSA20  = $2802;
  TF_ALG_CHACHA20 = $2803;

type
  IHashAlgorithm = interface(IInterface)
    procedure Init;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    procedure Update(Data: Pointer; DataSize: Cardinal);{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    procedure Done(PDigest: Pointer);{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    procedure Burn;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetDigestSize: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetBlockSize: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Duplicate(var Inst: IHashAlgorithm): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

//  THashGetter = function(var A: IHashAlgorithm): TF_RESULT;
//                {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

  IHMACAlgorithm = interface(IInterface)
    procedure Init(Key: Pointer; KeySize: Cardinal);{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    procedure Update(Data: Pointer; DataSize: Cardinal);{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    procedure Done(PDigest: Pointer);{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    procedure Burn;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetDigestSize: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
//    function GetBlockSize: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Duplicate(var Inst: IHMACAlgorithm): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function PBKDF2(Password: Pointer; PassLen: Cardinal;
          Salt: Pointer; SaltLen: Cardinal;
          Rounds, DKLen: Cardinal; var Key: IBytes): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

  IHashServer = interface(IInterface)
    function GetByAlgID(AlgID: UInt32; var Alg: IHashAlgorithm): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetByName(Name: Pointer; CharSize: Integer; var Alg: IHashAlgorithm): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetByIndex(Index: Integer; var Alg: IHashAlgorithm): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetName(Index: Integer; var Name: IBytes): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetCount: Integer;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetHMAC(var HMACAlg: IHMACAlgorithm;
          const HashAlg: IHashAlgorithm): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function PBKDF1(HashAlg: IHashAlgorithm;
          Password: Pointer; PassLen: Cardinal;
          Salt: Pointer; SaltLen: Cardinal;
          Rounds, dkLen: Cardinal; var Key: IBytes): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
//    function RegisterHash(Name: Pointer; CharSize: Integer; Getter: THashGetter;
//          var Index: Integer): TF_RESULT;
//          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

  ICipher = interface(IInterface)
    procedure Burn;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Duplicate(var Inst: ICipher): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ExpandKey(Key: Pointer; KeySize: Cardinal): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SetKeyParam(Param: UInt32; Data: Pointer; DataLen: Cardinal): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKeyParam(Param: UInt32; Data: Pointer; var DataLen: Cardinal): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetBlockSize: Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Encrypt(Data: PByte; var DataSize: Cardinal; BufSize: Cardinal;
             Last: Boolean): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Decrypt(Data: PByte; var DataSize: Cardinal;
             Last: Boolean): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function EncryptBlock(Data: PByte): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function DecryptBlock(Data: PByte): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKeyStream(Data: PByte; DataSize: Cardinal): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function KeyBlock(Data: PByte): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function KeyCrypt(Data: PByte; DataSize: Cardinal;
             Last: Boolean): TF_RESULT;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetIsBlockCipher: Boolean;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

  IStreamCipher = interface(IInterface)
    procedure Burn;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Duplicate(var Inst: IStreamCipher): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function ExpandKey(Key: PByte; KeySize: Cardinal; Nonce: UInt64): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function SetNonce(Nonce: UInt64): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetNonce(var Nonce: UInt64): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Skip(Dist: Int64): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKeyStream(Data: PByte; DataSize: Cardinal): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function Apply(Data: PByte; DataSize: Cardinal): TF_RESULT;
      {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
  end;

  ICipherServer = interface(IInterface)
    function GetByAlgID(AlgID: UInt32; var Alg: ICipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetByName(Name: Pointer; CharSize: Integer; var Alg: ICipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetByIndex(Index: Integer; var Alg: ICipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetName(Index: Integer; var Name: IBytes): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetCount: Integer;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function GetRC5(BlockSize, Rounds: Cardinal;
          var Alg: ICipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetSalsa20(Rounds: Cardinal; var Alg: ICipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetChaCha20(Rounds: Cardinal; var Alg: ICipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

    function GetKSByAlgID(AlgID: UInt32; var KS: IStreamCipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKSByName(Name: Pointer; CharSize: Cardinal; var KS: IStreamCipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKSRC5(BlockSize, Rounds: Cardinal; var KS: IStreamCipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKSSalsa20(Rounds: Cardinal; var KS: IStreamCipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
    function GetKSChaCha20(Rounds: Cardinal; var KS: IStreamCipher): TF_RESULT;
          {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

  end;

const
                            // max block size for supported block ciphers:
                            //   256 bytes = 2048 bits
  TF_MAX_CIPHER_BLOCK_SIZE = 256;

                            // ICipherAlgorithm.SetKeyParam Param values
  TF_KP_DIR       = 1;      // encrypt/decrypt
  TF_KP_MODE      = 2;      // mode of operation
  TF_KP_PADDING   = 3;      // block padding
  TF_KP_FLAGS     = 4;      // DIR + MODE + PADDING
  TF_KP_IV        = 5;      // initialization vector
  TF_KP_NONCE     = 6;      // nonce
  TF_KP_INCNO     = 7;      // increment block number
  TF_KP_DECNO     = 8;      // decrement block number

//  TF_KP_LE        = $1000;  // little endian
                            // _LE - suffix means the param is integer
                            //       in little-endian format;
                            //    that is optimization for little-endian CPU
                            //    and algorithms expecting data in
                            //    little-endian format;

//  TF_KP_NONCE_LE     = TF_KP_LE + TF_KP_NONCE;
//  TF_KP_INCNO_LE     = TF_KP_LE + TF_KP_INCNO;

// Key Flags bits:
//     0002            0040           0800
//  0  1 | 2  3  4  5  6 | 7  8  9 10 11 |
//  DIR  | MODE          | PADDING       |

                          // KP_DIR values
                          //   01 - encrypt only
                          //   10 - decrypt only
                          //   11 - encrypt & decrypt
  TF_KEYDIR_SHIFT = 0;
  TF_KEYDIR_BASE  = 1;
//  TF_KEYDIR_BASE  = $0002;
  TF_KEYDIR_MASK  = $0003;

  TF_KEYDIR_ENCRYPT = TF_KEYDIR_BASE;
  TF_KEYDIR_DECRYPT = TF_KEYDIR_BASE + 1;

                          // TF_KP_MODE values
                          //   00001 - ECB
                          //   00010 - CBC
                          //   00011 - CTR
  TF_KEYMODE_SHIFT = 2;
  TF_KEYMODE_BASE  = 4;
  TF_KEYMODE_MASK  = $003C;

//  TF_KEYMODE_ECB = TF_KEYMODE_BASE + 1 shl TF_KEYMODE_SHIFT;
//  TF_KEYMODE_CBC = TF_KEYMODE_BASE + 2 shl TF_KEYMODE_SHIFT;
//  TF_KEYMODE_CTR = TF_KEYMODE_BASE + 3 shl TF_KEYMODE_SHIFT;

  TF_KEYMODE_ECB = TF_KEYMODE_BASE;
  TF_KEYMODE_CBC = TF_KEYMODE_BASE + 1 shl TF_KEYMODE_SHIFT;
  TF_KEYMODE_CTR = TF_KEYMODE_BASE + 2 shl TF_KEYMODE_SHIFT;

  TF_KEYMODE_MIN = TF_KEYMODE_ECB;
  TF_KEYMODE_MAX = TF_KEYMODE_CTR;

                          // TF_KP_PADDING values
                          //   00001 - default
                          //   00011 - NONE
                          //   00101 - ZERO
                          //   00111 - ANSI
                          //   ...
  TF_PADDING_SHIFT = 8;
  TF_PADDING_BASE  = 128;
  TF_PADDING_MASK  = $0F80;

  TF_PADDING_DEFAULT  = TF_PADDING_BASE;
  TF_PADDING_NONE     = TF_PADDING_BASE + 1 shl TF_PADDING_SHIFT;
                                              // XX 00 00 00 00
  TF_PADDING_ZERO     = TF_PADDING_BASE + 2 shl TF_PADDING_SHIFT;
                                              // XX 00 00 00 04
  TF_PADDING_ANSI     = TF_PADDING_BASE + 3 shl TF_PADDING_SHIFT;
                                              // XX 04 04 04 04
  TF_PADDING_PKCS     = TF_PADDING_BASE + 4 shl TF_PADDING_SHIFT;
                                              // XX ?? ?? ?? 04
  TF_PADDING_ISO10126 = TF_PADDING_BASE + 5 shl TF_PADDING_SHIFT;
                                              // XX 80 00 00 00
  TF_PADDING_ISOIEC   = TF_PADDING_BASE + 6 shl TF_PADDING_SHIFT;

  TF_PADDING_MIN = TF_PADDING_DEFAULT;
  TF_PADDING_MAX = TF_PADDING_ISOIEC;

// "user-friendly" constants

  ECB_ENCRYPT = TF_KEYDIR_ENCRYPT or TF_KEYMODE_ECB or TF_PADDING_DEFAULT;
  ECB_DECRYPT = TF_KEYDIR_DECRYPT or TF_KEYMODE_ECB or TF_PADDING_DEFAULT;

  CBC_ENCRYPT = TF_KEYDIR_ENCRYPT or TF_KEYMODE_CBC or TF_PADDING_DEFAULT;
  CBC_DECRYPT = TF_KEYDIR_DECRYPT or TF_KEYMODE_CBC or TF_PADDING_DEFAULT;

  CTR_ENCRYPT = TF_KEYDIR_ENCRYPT or TF_KEYMODE_CTR or TF_PADDING_DEFAULT;
  CTR_DECRYPT = TF_KEYDIR_DECRYPT or TF_KEYMODE_CTR or TF_PADDING_DEFAULT;

  PADDING_DEFAULT  = TF_PADDING_DEFAULT;
  PADDING_NONE     = TF_PADDING_NONE;
  PADDING_ZERO     = TF_PADDING_ZERO;
  PADDING_ANSI     = TF_PADDING_ANSI;
  PADDING_PKCS     = TF_PADDING_PKCS;
  PADDING_ISO10126 = TF_PADDING_ISO10126;
  PADDING_ISOIEC   = TF_PADDING_ISOIEC;


{ Hash digests }
type
                                  // 128-bit MD5 digest
  PMD5Digest = ^TMD5Digest;
  TMD5Digest = array[0..3] of UInt32;
                                  // 160-bit SHA1 digest
  PSHA1Digest = ^TSHA1Digest;
  TSHA1Digest = array[0..4] of UInt32;
                                  // 256-bit SHA256 digest
  PSHA256Digest = ^TSHA256Digest;
  TSHA256Digest = array[0..7] of UInt32;
                                  // 512-bit SHA512 digest
  PSHA512Digest = ^TSHA512Digest;
  TSHA512Digest = array[0..7] of UInt64;
                                  // 224-bit SHA224 digest
  PSHA224Digest = ^TSHA224Digest;
  TSHA224Digest = array[0..6] of UInt32;
                                  // 384-bit SHA384 digest
  PSHA384Digest = ^TSHA384Digest;
  TSHA384Digest = array[0..5] of UInt64;

implementation

end.
