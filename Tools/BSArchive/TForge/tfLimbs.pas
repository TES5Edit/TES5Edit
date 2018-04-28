{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2016         * }
{ *********************************************************** }

unit tfLimbs;

{$I TFL.inc}
{$IFDEF TFL_POINTERMATH}
   {$POINTERMATH ON}      // PLimb is compiled with POINTERMATH ON
{$ENDIF}

interface

type
  PLimb = ^TLimb;
  PIntLimb = ^TIntLimb;
  PDLimb = ^TDLimb;
  PDIntLimb = ^TDIntLimb;

{$IFDEF TFL_LIMB32}
  TLimb = UInt32;
  TIntLimb = Int32;
  TDLimb = UInt64;
  TDIntLimb = Int64;

  TLimbVector = record
    case Byte of
      0: (Value: UInt64);
      1: (Lo, Hi: UInt32);
  end;

  TLimbInfo = record
  public const
    BitSize = 32;
    BitShift = 5;
    BitShiftMask = $1F;
    MaxLimb = $FFFFFFFF;
    MaxIntLimb = $7FFFFFFF;
    MaxDblLimb = UInt64($FFFFFFFFFFFFFFFF);
    MaxDblIntLimb = Int64($7FFFFFFFFFFFFFFF);
                               // max number of limbs in big number
    MaxCapacity = $01000000 div SizeOf(TLimb);
  end;
{$ENDIF}

{$IFDEF TFL_LIMB16}
  TLimb = UInt16;
  TIntLimb = Int16;
  TDLimb = UInt32;
  TDIntLimb = Int32;

  TLimbVector = record
    case Byte of
      0: (Value: UInt32);
      1: (Lo, Hi: UInt16);
  end;

  TLimbInfo = record
  const
    BitSize = 16;
    BitShift = 4;
    BitShiftMask = $0F;
    MaxLimb = $FFFF;
    MaxIntLimb = $7FFF;
    MaxCapacity = $01000000 div SizeOf(TLimb);
  end;
{$ENDIF}

{$IFDEF TFL_LIMB8}
  TLimb = UInt8;
  TIntLimb = Int8;
  TDLimb = UInt16;
  TDIntLimb = Int16;

  TLimbVector = record
    case Byte of
      0: (Value: UInt16);
      1: (Lo, Hi: UInt8);
  end;

  TLimbInfo = record
  public const
    BitSize = 8;
    BitShift = 3;
    BitShiftMask = $07;
    MaxLimb = $FF;
    MaxIntLimb = $7F;
    MaxCapacity = $01000000 div SizeOf(TLimb);
  end;
{$ENDIF}

implementation

end.
