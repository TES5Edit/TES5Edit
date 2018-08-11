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
unit wbSort;

{$I wbDefines.inc}

interface

uses
  Classes, wbInterface;

type
  TListSortComparePtr = TListSortCompare;
  TListSortCompare32 = function(Item1, Item2: Cardinal): Integer;
  TListSortCompare64 = function(const Item1, Item2: UInt64): Integer;

procedure wbMergeSortPtr(aList: Pointer; aCount: Integer; aCompare: TListSortComparePtr);
procedure wbMergeSort32(aList: Pointer; aCount: Integer; aCompare: TListSortCompare32);
procedure wbMergeSort64(aList: Pointer; aCount: Integer; aCompare: TListSortCompare64);

type
  TwbMergeSort<T> = class
  public
  type
    TPtr = ^T;
    TArray = array[0..0] of T;
    PArray = ^TArray;
    TListSortCompareTPtr = function(Item1, Item2: TPtr): Integer;
  private
    class procedure InsertionSort(aList: PArray; left, right: integer; aCompare: TListSortCompareTPtr); static;
    class procedure MergeSort(ptrList: PArray; left, right: Integer; aCompare: TListSortCompareTPtr; Buffer: PArray); static;

    class procedure UseStackBufferLarge(aList: Pointer; aCount: Integer; aCompare: TListSortCompareTPtr); static;
    class procedure UseStackBufferSmall(aList: Pointer; aCount: Integer; aCompare: TListSortCompareTPtr); static;
  public
    class procedure Sort(aList: Pointer; aCount: Integer; aCompare: TListSortCompareTPtr); static;
  end;

implementation

type
  TwbMove = procedure(const Source; var Dest; Count : Integer);

var
  wbMove    : TwbMove = nil;

const
  // x64 - use InsertionSort instead MergeSort for small arrays
  MIN_SIZE = 32;

{$IFDEF WIN32}
function wbMergeSortPtrInternal(_A, _B: PwbPointerArray; _Count : Integer; _Compare: TListSortComparePtr): PwbPointerArray; register;
const
  SizeOfPointer  = SizeOf(Pointer);
  SizeOf2Pointer  = 2 * SizeOf(Pointer);

  EspOffset      =  $38;

  A              = EspOffset - SizeOfPointer * 1;
  B              = EspOffset - SizeOfPointer * 2;
  Compare        = EspOffset+$08; //sometimes ebp

  Temp           = EspOffset - SizeOfPointer * 3;

  Count          = EspOffset - SizeOfPointer * 4;
  SegmentSize    = EspOffset - SizeOfPointer * 5;

  Temp2          = EspOffset - SizeOfPointer * 6;

  pRightEnd      = EspOffset - SizeOfPointer * 7;
  pLeftEnd       = EspOffset - SizeOfPointer * 8;

  pListEnd       = EspOffset - SizeOfPointer * 9;

  pNextLeft      = EspOffset - SizeOfPointer * 10;
  SavedCompares  = EspOffset - SizeOfPointer * 11;
asm
  { begin }
        sub    esp, EspOffset
        mov    [esp + 00], edi
        mov    [esp + 08], esi
        mov    [esp + 04], ebx

        mov    [esp+Count], ecx
        mov    [esp+B], edx
        mov    [esp+A], eax

  {======== first run =========================================================}
        xor    ebp, ebp

  { pBuffer := @b; }
        mov    edi, [esp+B]
  { pLeft := @a; }
        mov    esi, [esp+A]
  { pListEnd := @a[Pred(Count)]; }
        mov    ebx, [esp+Count]
        dec    ebx
        lea    ebx, [esi+ebx*SizeOfPointer]

        mov    dword ptr [esp+Temp], 0

        jmp   @@FirstRun_CompareLoop

        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@FirstRun_CompareLoop:
  { if Compare(pLeft^, pRight^) <= 0 then begin }
        mov    eax, [esi]
        mov    edx, [esi + SizeOfPointer]
        call   [esp+Compare]
        test   eax, eax
        jg    @@FirstRun_MergeFromRight
        jl    @@FirstRun_MergeFromLeft
        add    dword ptr [esp+Temp], 1
        jmp   @@FirstRun_MergeFromLeft

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@FirstRun_MergeFromLeft:
  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { pBuffer+1^ := pLeft+1^; }
        mov    eax, [esi + SizeOfPointer]
        mov    [edi + SizeOfPointer], eax
  { Inc(pBuffer, 2); }
        add    edi, SizeOf2Pointer
  { Inc(pLeft, 2); }
        add    esi, SizeOf2Pointer

  { until pLeft+1 >= pListEnd }
        cmp    esi, ebx
        jb    @@FirstRun_CompareLoop
        ja    @@FirstRun_NoRemaining
        jmp   @@FirstRun_CopyRemaining

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@FirstRun_MergeFromRight:
        lea    ebp, [ebp +1]
  { pBuffer+1^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi + SizeOfPointer], eax
  { pBuffer^ := pLeft+1^; }
        mov    eax, [esi + SizeOfPointer]
        mov    [edi], eax
  { Inc(pBuffer, 2); }
        add    edi, SizeOf2Pointer
  { Inc(pLeft, 2); }
        add    esi, SizeOf2Pointer

  { until pLeft+1 >= pListEnd }
        cmp    esi, ebx
        jb    @@FirstRun_CompareLoop
        ja    @@FirstRun_NoRemaining

   @@FirstRun_CopyRemaining:
  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax

        nop
        nop
        nop

   @@FirstRun_NoRemaining:
        mov    edx, ebp
        mov    ebp, [esp+Compare]

        { if never merged from left... }
        test   edx, edx
        jz    @@ShortCutFwd_Entry

        { if always merged from right... }
        mov    eax, [esp+Count]
        shr    eax, 1
        add    edx, [esp+Temp]
        cmp    edx, eax
        je    @@ShortCutBwd_Entry

  { T := A; }
        mov    eax, [esp+A]
  { A := B; }
        mov    edx, [esp+B]
        mov    [esp+A], edx
  { B := T; }
        mov    [esp+B], eax

        jmp   @@SmallRuns_Entry

  {======== shortcut forward run ==============================================}
        nop
        nop
        nop

  @@ShortCutFwd_Entry:
  { pLeft := @a; }
        mov    esi, [esp+A]
  { pListEnd := @a[Pred(Count)]; - still valid}

  { skip first element }
        add    esi, SizeOfPointer

        cmp    esi, ebx
        jae   @@Exit

        nop

  @@ShortCutFwd_CompareLoop:
  { if Compare(pLeft^, pRight^) <= 0 then begin }
        mov    eax, [esi]
        mov    edx, [esi + SizeOfPointer]
        call   ebp
        test   eax, eax
  { if any element didn't fit, do a full merge }
        jg    @@SmallRuns_Entry

  { Inc(pLeft, 2); }
        add    esi, SizeOf2Pointer

  { until pLeft+1 >= pListEnd }
        cmp    esi, ebx
        jb    @@ShortCutFwd_CompareLoop
        jmp   @@Exit

  {======== shortcut forward run ==============================================}

        nop
        nop
        nop
        nop
        nop

  @@ShortCutBwd_Entry:
        mov    esi, [esp+A]
        mov    ebx, [esp + Count]
        cmp    ebx, 2
        je    @@ShortCutBwd_ExchangeLoop_Entry

        sub    ebx, 3
        or     ebx, 1
        lea    ebx, [esi + ebx * 4]

        cmp    esi, ebx
        jae   @@Exit

        nop
        nop

  @@ShortCutBwd_CompareLoop:
  { if Compare(pLeft^, pRight^) <= 0 then begin }
        mov    eax, [ebx]
        mov    edx, [ebx + SizeOfPointer]
        call   ebp
        test   eax, eax
  { if any element didn't fit, do a full merge }
        jl    @@ShortCutBwd_Error

  { Inc(pLeft, 2); }
        sub    ebx, SizeOf2Pointer

  { until pLeft+1 >= pListEnd }
        cmp    esi, ebx
        jb    @@ShortCutBwd_CompareLoop

  @@ShortCutBwd_ExchangeLoop_Entry:
        mov    esi, [esp+A]
        mov    ebx, [esp + Count]
        sub    ebx, 1
        lea    ebx, [esi + ebx * 4]

  @@ShortCutBwd_ExchangeLoop:
        mov    eax, [esi]
        mov    edx, [ebx]
        mov    [ebx], eax
        mov    [esi], edx

        add    esi, SizeOfPointer
        sub    ebx, SizeOfPointer

        cmp    esi, ebx
        jb    @@ShortCutBwd_ExchangeLoop

        jmp   @@Exit

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@ShortCutBwd_Error:

  { T := A; }
        mov    eax, [esp+A]
  { A := B; }
        mov    edx, [esp+B]
        mov    [esp+A], edx
  { B := T; }
        mov    [esp+B], eax

        jmp   @@SmallRuns_Entry

  {======== small runs ====================================================}
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@SmallRuns_Entry:
  { SegmentSize := 2; }
        mov    eax, 2
        mov    dword ptr [esp+SegmentSize], eax

        nop
        nop
        nop
        nop
        nop
        nop
        nop
  @@SmallRuns_OuterLoop_Entry:
        mov    ebp, [esp + Compare]
  @@SmallRuns_OuterLoop:  // requires SegmentSize in eax
  { pBuffer := @b; }
        mov    edi, [esp+B]
  { pLeft := @a; }
        mov    esi, [esp+A]
  { pRight := @a[SegmentSize]; }
        lea    ebx, [esi+eax*SizeOfPointer]
  { pLeftEnd := pRight; }
        mov    [esp+pLeftEnd], ebx
  { pListEnd := @a[Count]; }
        mov    edx, [esp+Count]
        lea    edx, [esi+ edx*SizeOfPointer]
        mov    [esp+pListEnd], edx
  { pRightEnd := @a[SegmentSize + SegmentSize]; }
        lea    eax, [ebx+eax*SizeOfPointer]
        mov    [esp+pRightEnd], eax

        jmp   @@SmallRuns_InnerLoopEntry //requires pRightEnd in eax and pListEnd in edx

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@SmallRuns_InnerLoopSetRightEnd:
  { pRightEnd := pListEnd; }
        mov    [esp+pRightEnd], edx

  @@SmallRuns_InnerLoop:
  @@SmallRuns_CompareLoop:
  { if Compare(pLeft^, pRight^) <= 0 then begin }
        mov    edx, [ebx]
        mov    eax, [esi]
        call   ebp
        test   eax, eax
        jg    @@SmallRuns_MergeFromRight

  @@SmallRuns_MergeFromLeft:
  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
  { if Cardinal(pLeft) >= Cardinal(pLeftEnd) then begin }
        cmp    esi, [esp+pLeftEnd]
        jb    @@SmallRuns_CompareLoop

        nop
        nop

  @@SmallRuns_CopyRemainingFromRight_Entry:
        mov    edx, [esp+pRightEnd] //used in CopyRemainingFromRight
  @@SmallRuns_CopyRemainingFromRight:
  { pBuffer^ := pRight^; }
        mov    eax, [ebx]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pRight); }
        add    ebx, SizeOfPointer
  { while Cardinal(pRight) < Cardinal(pRightEnd) do begin }
        cmp    ebx, edx
        jb    @@SmallRuns_CopyRemainingFromRight
  { Break; }
        jmp   @@SmallRuns_BreakOutOfCompareLoop

  @@SmallRuns_MergeBoth:
  { pBuffer^ := pRight^; }
        mov    eax, [esi]
        mov    [edi], eax
        mov    eax, [ebx]
        mov    [edi + SizeOfPointer], eax
  { Inc(pBuffer); }
        add    edi, SizeOf2Pointer
  { Inc(pRight); }
        add    ebx, SizeOfPointer
        add    esi, SizeOfPointer

        cmp    esi, [esp+pLeftEnd]
        jae   @@SmallRuns_LeftDone

        cmp    ebx, [esp+pRightEnd]
        jb    @@SmallRuns_CompareLoop
        jmp   @@SmallRuns_CopyRemainingFromLeft_Entry

  @@SmallRuns_LeftDone:
        cmp    ebx, [esp+pRightEnd]
        jb    @@SmallRuns_CopyRemainingFromRight_Entry
        jmp   @@SmallRuns_BreakOutOfCompareLoop

  @@SmallRuns_MergeFromRight:
  { pBuffer^ := pRight^; }
        mov    eax, [ebx]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pRight); }
        add    ebx, SizeOfPointer
  { if Cardinal(pRight) >= Cardinal(pRightEnd) then begin }
        cmp    ebx, [esp+pRightEnd]
        jb    @@SmallRuns_CompareLoop

  @@SmallRuns_CopyRemainingFromLeft_Entry:
        mov    edx, [esp+pLeftEnd] // used in CopyRemainingFromLeft
  @@SmallRuns_CopyRemainingFromLeft:

  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
  { while Cardinal(pLeft) < Cardinal(pLeftEnd) do begin }
        cmp    esi, edx
        jb @@SmallRuns_CopyRemainingFromLeft

  @@SmallRuns_BreakOutOfCompareLoop:
  { Inc(pLeft, SegmentSize); }
        mov    eax, [esp+SegmentSize]
        shl    eax, 02h
        add    esi, eax
  { Inc(pRight, SegmentSize); }
        add    ebx, eax
  { pLeftEnd := pRight; }
        mov    [esp+pLeftEnd], ebx
  { Inc(pRightEnd, SegmentSize + SegmentSize); }
        lea    eax, [ebx + eax]
        mov    [esp+pRightEnd], eax

        mov    edx, [esp+pListEnd]
  @@SmallRuns_InnerLoopEntry: //requires pRightEnd in eax and pListEnd in edx
  { while Cardinal(pRightEnd) <= Cardinal(pListEnd) do begin }
        cmp    eax, edx
        jbe   @@SmallRuns_InnerLoop

  { if Cardinal(pLeft) < Cardinal(pListEnd) then begin }
        cmp    edx, esi
        jbe   @@SmallRuns_NoRemaining
  { if Cardinal(pRight) < Cardinal(pListEnd) then begin }
        cmp    edx, ebx
        ja    @@SmallRuns_InnerLoopSetRightEnd

  @@SmallRuns_CopyRemaining:

  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
  { while Cardinal(pLeft) < Cardinal(pListEnd) do begin }
        cmp    esi, edx
        jb    @@SmallRuns_CopyRemaining

  @@SmallRuns_NoRemaining:
  { T := A; }
        mov    eax, [esp+A]
  { A := B; }
        mov    edx, [esp+B]
        mov    [esp+A], edx
  { B := T; }
        mov    [esp+B], eax
  { SegmentSize := SegmentSize shl 1; }
        mov    eax, [esp+SegmentSize]
        shl    eax, 1
        mov    [esp+SegmentSize], eax
  { while SegmentSize < Count do begin }
        cmp    eax, [esp+Count]
        jge   @@Exit

        cmp    eax, 128
        jne   @@SmallRuns_OuterLoop // requires SegmentSize in eax

  {======== large runs ====================================================}
  @@LargeRuns_OuterLoop:  // requires SegmentSize in eax
  { pBuffer := @b; }
        mov    edi, [esp+B]
  { pLeft := @a; }
        mov    esi, [esp+A]
  { pRight := @a[SegmentSize]; }
        lea    ebx, [esi+eax*SizeOfPointer]
  { pLeftEnd := pRight; }
        mov    [esp+pLeftEnd], ebx
  { pListEnd := @a[Count]; }
        mov    edx, [esp+Count]
        lea    edx, [esi+ edx*SizeOfPointer]
        mov    [esp+pListEnd], edx
  { pRightEnd := @a[SegmentSize + SegmentSize]; }
        lea    eax, [ebx+eax*SizeOfPointer]
        mov    [esp+pRightEnd], eax
        mov    [esp+pNextLeft], eax

        mov    [esp+SavedCompares], 0

        jmp   @@LargeRuns_InnerLoopEntry //requires pRightEnd in eax and pListEnd in edx

        nop
        nop
        nop

  @@LargeRuns_InnerLoopSetRightEnd:
  { pRightEnd := pListEnd; }
        mov    [esp+pRightEnd], edx
        mov    [esp+pNextLeft], edx

  @@LargeRuns_InnerLoop:

  { Compare(pLeft^, pRight^) }
        mov    edx, [ebx]
        mov    eax, [esi]
        call   [esp+Compare]
        test   eax, eax
  { if equal -> perfect overlap, copy both, no need to waste a comparison... }
        je    @@LargeRuns_CopyBoth

        mov    edx, [esp+pLeftEnd]
        jl    @@LargeRuns_MoveFromLeft // requires LeftEnd in edx

  @@LargeRuns_SwitchLeftAndRight:

  { if greater -> right one is smaller }

  { move it over to the buffer, no need to waste a comparison}
        mov    ecx, [ebx]
        mov    [edi], ecx
        add    ebx, SizeOfPointer
        add    edi, SizeOfPointer

  { switch left and right }
        xchg   ebx, esi

        mov    eax, [esp+pRightEnd]
        mov    [esp+pLeftEnd], eax
        mov    [esp+pRightEnd], edx

  { if we reached the end, copy the rest }
        cmp    esi, eax
        jae   @@LargeRuns_CopyRemainingFromRight_Entry

        mov    edx, eax
        jmp   @@LargeRuns_CompareLeftEndAndRight

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@LargeRuns_MoveFromLeft: // requires LeftEnd in edx

  { if lesser -> left one is smaller}

  { move it over to the buffer, no need to waste a comparison}
        mov    ecx, [esi]
        mov    [edi], ecx
        add    esi, SizeOfPointer
        add    edi, SizeOfPointer

  { if we reached the end, copy the rest }
        cmp    esi, edx{LeftEnd}
        jae   @@LargeRuns_CopyRemainingFromRight_Entry

  @@LargeRuns_CompareLeftEndAndRight: // requires LeftEnd in edx

        sub    edx, SizeOfPointer
        mov    eax, [edx]
        mov    edx, [ebx]
        call   [esp+Compare]
        test   eax, eax
        jg    @@LargeRuns_BinarySearchLeft_Entry

  { LeftEnd <= Right, no need to continue merging, just copy and get out of here }

  { first copy just left }
        mov    eax, esi
        mov    edx, edi
        mov    ecx, [esp+pLeftEnd]
        sub    ecx, eax
        add    edi, ecx
        add    [esp+SavedCompares], ecx
        call   [wbMove]

  { then copy just right }
        mov    eax, ebx
        mov    edx, edi
        mov    ecx, [esp+pRightEnd]
        sub    ecx, eax
        add    edi, ecx
        add    [esp+SavedCompares], ecx
        call   [wbMove]

  { we are done here }
        jmp   @@LargeRuns_BreakOutOfCompareLoop

        nop
        nop
        nop
        nop
        nop
        nop

  @@LargeRuns_CopyBoth:
        mov    eax, [ebx]
        mov    [edi], eax
        mov    eax, [esi]
        mov    [edi + SizeOfPointer], eax

        add    ebx, SizeOfPointer
        add    esi, SizeOfPointer
        add    edi, SizeOf2Pointer

        cmp    esi, [esp+pLeftEnd]
        jae   @@LargeRuns_CopyRemainingFromRight_Entry
        cmp    ebx, [esp+pRightEnd]
        jae   @@LargeRuns_CopyRemainingFromLeft_Entry

        jmp   @@LargeRuns_InnerLoop

        nop
        nop
        nop
        nop
        nop

  @@LargeRuns_BinarySearchLeft_Entry:
  { save our old Left }
        mov    [esp+Temp], esi
  { save our old Buffer }
        mov    [esp+Temp2], edi

        mov    edi, [esp+pLeftEnd]
        sub    edi, SizeOfPointer

  { we start with esi = Low and edi = High}

        nop

  @@LargeRuns_BinarySearchLeft_Loop:
  { calculate the middle into ebp }
        mov    ebp, edi
        sub    ebp, esi
        shr    ebp, 3

        lea    ebp, [esi + ebp *4];

  { compare middle with Right}
        mov    eax, [ebp]
        mov    edx, [ebx]
        sub    [esp+SavedCompares], 4
        call   [esp+Compare]
        test   eax, eax
        jg    @@LargeRuns_BinarySearchLeft_Greater

  @@LargeRuns_BinarySearchLeft_LesserOrEqual:
  { move the lower bound }
        lea    esi, [ebp + SizeOfPointer]

        cmp    esi, edi
        jbe   @@LargeRuns_BinarySearchLeft_Loop
        jmp   @@LargeRuns_BinarySearchLeft_Exit

  @@LargeRuns_BinarySearchLeft_Greater:
  { mov the higher bound }
        lea    edi, [ebp - SizeOfPointer]

        cmp    esi, edi
        jbe   @@LargeRuns_BinarySearchLeft_Loop
        jmp   @@LargeRuns_BinarySearchLeft_Exit

        nop
        nop
        nop
        nop
        nop
        nop
        nop

  @@LargeRuns_BinarySearchLeft_Exit:
  { edi is pointing to the last entry that's <= Right }

  { get our old left }
        mov    esi, [esp+Temp]
        mov    edx, edi
  { restore Buffer}
        mov    edi, [esp+Temp2]
        jmp   @@LargeRuns_BinarySearchLeft_CopyLeadingLeft_Entry

        nop
        nop
        nop
        nop

  @@LargeRuns_BinarySearchLeft_CopyLeadingLeft_Loop:
  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
        add    [esp+SavedCompares], 4
  { while Cardinal(pLeft) <= FoundItem do begin }
  @@LargeRuns_BinarySearchLeft_CopyLeadingLeft_Entry:
        cmp    esi, edx
        jbe @@LargeRuns_BinarySearchLeft_CopyLeadingLeft_Loop

  { we've copied all entries from Left that where <= Right }

  { are we done with Left? }
        cmp    esi, [esp+pLeftEnd]
        jae   @@LargeRuns_CopyRemainingFromRight_Entry

  { pBuffer^ := pRight^; }
        mov    eax, [ebx]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pRight); }
        add    ebx, SizeOfPointer

  { are we done with Right? }
        cmp    ebx, [esp+pRightEnd]
        jae   @@LargeRuns_CopyRemainingFromLeft_Entry

  { now we can start with the normal compare loop}
        mov    ebp, [esp+Compare]

        jmp   @@LargeRuns_CompareLoop

        nop
        nop
        nop
        nop
        nop
        nop

  @@LargeRuns_CompareLoop:
  { if Compare(pLeft^, pRight^) <= 0 then begin }
        mov    edx, [ebx]
        mov    eax, [esi]
        call   ebp
        test   eax, eax
        jg    @@LargeRuns_MergeFromRight

  @@LargeRuns_MergeFromLeft:
  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
  { if Cardinal(pLeft) >= Cardinal(pLeftEnd) then begin }
        cmp    esi, [esp+pLeftEnd]
        jb    @@LargeRuns_CompareLoop

        nop
        nop

  @@LargeRuns_CopyRemainingFromRight_Entry:
        mov    edx, [esp+pRightEnd] //used in CopyRemainingFromRight
  @@LargeRuns_CopyRemainingFromRight:
  { pBuffer^ := pRight^; }
        mov    eax, [ebx]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pRight); }
        add    ebx, SizeOfPointer
  { while Cardinal(pRight) < Cardinal(pRightEnd) do begin }
        cmp    ebx, edx
        jb    @@LargeRuns_CopyRemainingFromRight
  { Break; }
        jmp   @@LargeRuns_BreakOutOfCompareLoop

  @@LargeRuns_MergeFromRight:
  { pBuffer^ := pRight^; }
        mov    eax, [ebx]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pRight); }
        add    ebx, SizeOfPointer
  { if Cardinal(pRight) >= Cardinal(pRightEnd) then begin }
        cmp    ebx, [esp+pRightEnd]
        jb    @@LargeRuns_CompareLoop

  @@LargeRuns_CopyRemainingFromLeft_Entry:
        mov    edx, [esp+pLeftEnd] // used in CopyRemainingFromLeft
  @@LargeRuns_CopyRemainingFromLeft:

  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
  { while Cardinal(pLeft) < Cardinal(pLeftEnd) do begin }
        cmp    esi, edx
        jb @@LargeRuns_CopyRemainingFromLeft

  @@LargeRuns_BreakOutOfCompareLoop:
  { Inc(pLeft, SegmentSize); }
        mov    eax, [esp+SegmentSize]
        shl    eax, 02h

        mov    esi, [esp+pNextLeft]
  { Inc(pRight, SegmentSize); }
        lea    ebx, [esi + eax]
  { pLeftEnd := pRight; }
        mov    [esp+pLeftEnd], ebx
  { Inc(pRightEnd, SegmentSize + SegmentSize); }
        lea    eax, [ebx + eax]
        mov    [esp+pRightEnd], eax
        mov    [esp+pNextLeft], eax

        mov    edx, [esp+pListEnd]
  @@LargeRuns_InnerLoopEntry: //requires pRightEnd in eax and pListEnd in edx
  { while Cardinal(pRightEnd) <= Cardinal(pListEnd) do begin }
        cmp    eax, edx
        jbe   @@LargeRuns_InnerLoop

  { if Cardinal(pLeft) < Cardinal(pListEnd) then begin }
        cmp    edx, esi
        jbe   @@LargeRuns_NoRemaining
  { if Cardinal(pRight) < Cardinal(pListEnd) then begin }
        cmp    edx, ebx
        ja    @@LargeRuns_InnerLoopSetRightEnd

  @@LargeRuns_CopyRemaining:
  { pBuffer^ := pLeft^; }
        mov    eax, [esi]
        mov    [edi], eax
  { Inc(pBuffer); }
        add    edi, SizeOfPointer
  { Inc(pLeft); }
        add    esi, SizeOfPointer
  { while Cardinal(pLeft) < Cardinal(pListEnd) do begin }
        cmp    esi, edx
        jb    @@LargeRuns_CopyRemaining

  @@LargeRuns_NoRemaining:
  { T := A; }
        mov    eax, [esp+A]
  { A := B; }
        mov    edx, [esp+B]
        mov    [esp+A], edx
  { B := T; }
        mov    [esp+B], eax
  { SegmentSize := SegmentSize shl 1; }
        mov    eax, [esp+SegmentSize]
        shl    eax, 1
        mov    [esp+SegmentSize], eax
  { while SegmentSize < Count do begin }
        mov    edx, [esp+Count]
        cmp    eax, edx
        jge    @@Exit

        cmp    [esp+SavedCompares], edx
        jl    @@SmallRuns_OuterLoop_Entry

        jmp   @@LargeRuns_OuterLoop // requires SegmentSize in eax

  @@Exit:
  { Result := A; }
        mov    eax, [esp+A]

  { end; }
        mov    edi, [esp + 00]
        mov    esi, [esp + 08]
        mov    ebx, [esp + 04]

        add    esp, EspOffset
end;


procedure wbMergeSortPtr(aList: Pointer; aCount: Integer; aCompare: TListSortComparePtr);

  procedure UseStackBufferLarge;
  var
    Buffer: array[0..Pred(4 * 1024)] of Pointer;
  begin
    if wbMergeSortPtrInternal(aList, @Buffer[0], aCount, aCompare) <> aList then
      Move(Buffer, aList^, aCount * SizeOf(Pointer) );
  end;

  procedure UseStackBufferSmall;
  var
    Buffer: array[0..Pred(1024)] of Pointer;
  begin
    if wbMergeSortPtrInternal(aList, @Buffer[0], aCount, aCompare) <> aList then
      Move(Buffer, aList^, aCount * SizeOf(Pointer) );
  end;

var
  Buffer: Pointer;
begin
  if (aCount < 2) or (not Assigned(aList)) then
    Exit;

  if aCount > 4 * 1024 then begin
    GetMem(Buffer, aCount * SizeOf(Pointer));
    if wbMergeSortPtrInternal(aList, Buffer, aCount, aCompare) <> aList then
      Move(Buffer^, aList^, aCount * SizeOf(Pointer));
    FreeMem(Buffer);
  end else if aCount > 1024 then
    UseStackBufferLarge
  else
    UseStackBufferSmall;
end;

procedure wbMergeSort32(aList: Pointer; aCount: Integer; aCompare: TListSortCompare32);
begin
  wbMergeSortPtr(aList, aCount, TListSortComparePtr(aCompare));
end;

procedure InsertionSort64(aList: PwbUInt64Array; left, right: integer; aCompare: TListSortCompare64);
var
  i: Integer;
  j: integer;
  temp: UInt64;
begin
  for i := Succ(left) to right do begin
    j := i;
    temp := aList[j];
    while (j > left) AND (aCompare(temp, aList[Pred(j)]) < 0) do begin
      aList[j] := aList[Pred(j)];
      dec(j);
    end;
    aList[j] := temp;
 end;
end;

procedure MergeSort64(ptrList: PwbUInt64Array; left: Integer; right: Integer; aCompare: TListSortCompare64; Buffer: PwbUInt64Array);
var
  i, j, k, mid, aCount: Integer;
begin
  mid := (left + right) div 2;
  if (left < mid) then begin
    if (mid - left) <= MIN_SIZE then begin
      InsertionSort64(ptrList, left, mid, aCompare)
    end
    else begin
      MergeSort64(ptrList, left, mid, aCompare, Buffer);
    end;
  end;
  if (succ(mid) < right) then begin
    if (right - succ(mid)) <= MIN_SIZE then begin
      InsertionSort64(ptrList, succ(mid), right, aCompare);
    end
    else begin
       MergeSort64(ptrList, succ(mid), right, aCompare, Buffer);
    end;
  end;
  if aCompare(ptrList[mid], ptrList[Succ(mid)]) < 0 then
    exit;
  aCount := succ(mid - left);
  Move(ptrList[left], Buffer[0], aCount * SizeOf(UInt64));
  i := 0;
  j := succ(mid);
  k := left;
  while (i < aCount) and (j <= right) do begin
    if (aCompare(Buffer[i], ptrList[j]) <= 0) then begin
      ptrList[k] := Buffer[i];
      inc(i);
    end else begin
      ptrList[k] := ptrList[j];
      inc(j);
    end;
    inc(k);
  end;
  if (i < aCount) then begin
    Move(Buffer[i], ptrList[k], (aCount - i) * SizeOf(UInt64));
  end;
end;

procedure wbMergeSort64(aList: Pointer; aCount: Integer; aCompare: TListSortCompare64);

  procedure UseStackBufferLarge;
  var
    Buffer: array[0..Pred(4 * 512)] of UInt64;
  begin
    MergeSort64(aList, 0, Pred(aCount), aCompare, @Buffer);
  end;

  procedure UseStackBufferSmall;
  var
    Buffer: array[0..Pred(512)] of UInt64;
  begin
    MergeSort64(aList, 0, Pred(aCount), aCompare, @Buffer);
  end;

var
  Buffer: Pointer;
begin
  if (aCount < 2) or (not Assigned(aList)) then
    Exit;

  if aCount <= MIN_SIZE then
    InsertionSort64(aList, 0, Pred(aCount), aCompare)
  else if aCount > 4 * 512 then begin
    GetMem(Buffer, aCount * SizeOf(UInt64));
    MergeSort64(aList, 0, Pred(aCount), aCompare, Buffer);
    FreeMem(Buffer);
  end else if aCount > 512 then
    UseStackBufferLarge
  else
    UseStackBufferSmall;
end;
{$ENDIF WIN32}

{$IFDEF WIN64}
procedure InsertionSortPtr(aList: PwbPointerArray; left, right: integer; aCompare: TListSortComparePtr);
var
  i: Integer;
  j: integer;
  temp: Pointer;
begin
  for i := Succ(left) to right do begin
    j := i;
    temp := aList[j];
    while (j > left) AND (aCompare(temp, aList[Pred(j)]) < 0) do begin
      aList[j] := aList[Pred(j)];
      dec(j);
    end;
    aList[j] := temp;
 end;
end;

procedure MergeSortPtr(ptrList: PwbPointerArray; left: Integer; right: Integer; aCompare: TListSortComparePtr; Buffer: PwbPointerArray);
var
  i, j, k, mid, aCount: Integer;
begin
  mid := (left + right) div 2;
  if (left < mid) then begin
    if (mid - left) <= MIN_SIZE then begin
      InsertionSortPtr(ptrList, left, mid, aCompare)
    end
    else begin
      MergeSortPtr(ptrList, left, mid, aCompare, Buffer);
    end;
  end;
  if (succ(mid) < right) then begin
    if (right - succ(mid)) <= MIN_SIZE then begin
      InsertionSortPtr(ptrList, succ(mid), right, aCompare);
    end
    else begin
       MergeSortPtr(ptrList, succ(mid), right, aCompare, Buffer);
    end;
  end;
  if aCompare(ptrList[mid], ptrList[Succ(mid)]) < 0 then
    exit;
  aCount := succ(mid - left);
  Move(ptrList[left], Buffer[0], aCount * SizeOf(Pointer));
  i := 0;
  j := succ(mid);
  k := left;
  while (i < aCount) and (j <= right) do begin
    if (aCompare(Buffer[i], ptrList[j]) <= 0) then begin
      ptrList[k] := Buffer[i];
      inc(i);
    end else begin
      ptrList[k] := ptrList[j];
      inc(j);
    end;
    inc(k);
  end;
  if (i < aCount) then begin
    Move(Buffer[i], ptrList[k], (aCount - i) * SizeOf(Pointer));
  end;
end;

procedure wbMergeSortPtr(aList: Pointer; aCount: Integer; aCompare: TListSortComparePtr);
var
  Buffer: Pointer;
begin
  if (aCount < 2) or (not Assigned(aList)) then
    Exit;
  if aCount <= MIN_SIZE then begin
    InsertionSortPtr(aList, 0, Pred(aCount), aCompare);
  end
  else begin
    GetMem(Buffer, aCount * SizeOf(Pointer));
    MergeSortPtr(aList, 0, Pred(aCount), aCompare, Buffer);
    FreeMem(Buffer, aCount * SizeOf(Pointer));
  end;
end;

procedure InsertionSort32(aList: PwbCardinalArray; left, right: integer; aCompare: TListSortCompare32);
var
  i: Integer;
  j: integer;
  temp: Cardinal;
begin
  for i := Succ(left) to right do begin
    j := i;
    temp := aList[j];
    while (j > left) AND (aCompare(temp, aList[Pred(j)]) < 0) do begin
      aList[j] := aList[Pred(j)];
      dec(j);
    end;
    aList[j] := temp;
 end;
end;

procedure MergeSort32(ptrList: PwbCardinalArray; left: Integer; right: Integer; aCompare: TListSortCompare32; Buffer: PwbCardinalArray);
var
  i, j, k, mid, aCount: Integer;
begin
  mid := (left + right) div 2;
  if (left < mid) then begin
    if (mid - left) <= MIN_SIZE then begin
      InsertionSort32(ptrList, left, mid, aCompare)
    end
    else begin
      MergeSort32(ptrList, left, mid, aCompare, Buffer);
    end;
  end;
  if (succ(mid) < right) then begin
    if (right - succ(mid)) <= MIN_SIZE then begin
      InsertionSort32(ptrList, succ(mid), right, aCompare);
    end
    else begin
       MergeSort32(ptrList, succ(mid), right, aCompare, Buffer);
    end;
  end;
  if aCompare(ptrList[mid], ptrList[Succ(mid)]) < 0 then
    exit;
  aCount := succ(mid - left);
  Move(ptrList[left], Buffer[0], aCount * SizeOf(Cardinal));
  i := 0;
  j := succ(mid);
  k := left;
  while (i < aCount) and (j <= right) do begin
    if (aCompare(Buffer[i], ptrList[j]) <= 0) then begin
      ptrList[k] := Buffer[i];
      inc(i);
    end else begin
      ptrList[k] := ptrList[j];
      inc(j);
    end;
    inc(k);
  end;
  if (i < aCount) then begin
    Move(Buffer[i], ptrList[k], (aCount - i) * SizeOf(Cardinal));
  end;
end;

procedure wbMergeSort32(aList: Pointer; aCount: Integer; aCompare: TListSortCompare32);
var
  Buffer: Pointer;
begin
  if (aCount < 2) or (not Assigned(aList)) then
    Exit;
  if aCount <= MIN_SIZE then begin
    InsertionSort32(aList, 0, Pred(aCount), aCompare);
  end
  else begin
    GetMem(Buffer, aCount * SizeOf(Cardinal));
    MergeSort32(aList, 0, Pred(aCount), aCompare, Buffer);
    FreeMem(Buffer, aCount * SizeOf(Cardinal));
  end;
end;

procedure wbMergeSort64(aList: Pointer; aCount: Integer; aCompare: TListSortCompare64);
begin
  wbMergeSortPtr(aList, aCount, TListSortComparePtr(aCompare));
end;
{$ENDIF WIN64}

{$R-} //range checking must be off

class procedure TwbMergeSort<T>.InsertionSort(aList: PArray; left, right: integer; aCompare: TListSortCompareTPtr);
var
  i: Integer;
  j: integer;
  temp: T;
begin
  for i := Succ(left) to right do begin
    j := i;
    temp := aList[j];
    while (j > left) AND (aCompare(@temp, @aList[Pred(j)]) < 0) do begin
      aList[j] := aList[Pred(j)];
      dec(j);
    end;
    aList[j] := temp;
 end;
end;

class procedure TwbMergeSort<T>.MergeSort(ptrList: PArray; left, right: Integer; aCompare: TListSortCompareTPtr; Buffer: PArray);
var
  i, j, k, mid, aCount: Integer;
begin
  mid := (left + right) div 2;
  if (left < mid) then begin
    if (mid - left) <= MIN_SIZE then begin
      InsertionSort(ptrList, left, mid, aCompare)
    end
    else begin
      MergeSort(ptrList, left, mid, aCompare, Buffer);
    end;
  end;
  if (succ(mid) < right) then begin
    if (right - succ(mid)) <= MIN_SIZE then begin
      InsertionSort(ptrList, succ(mid), right, aCompare);
    end
    else begin
       MergeSort(ptrList, succ(mid), right, aCompare, Buffer);
    end;
  end;
  if aCompare(@ptrList[mid], @ptrList[Succ(mid)]) < 0 then
    exit;
  aCount := succ(mid - left);
  Move(ptrList[left], Buffer[0], aCount * SizeOf(T));
  i := 0;
  j := succ(mid);
  k := left;
  while (i < aCount) and (j <= right) do begin
    if (aCompare(@Buffer[i], @ptrList[j]) <= 0) then begin
      ptrList[k] := Buffer[i];
      inc(i);
    end else begin
      ptrList[k] := ptrList[j];
      inc(j);
    end;
    inc(k);
  end;
  if (i < aCount) then begin
    Move(Buffer[i], ptrList[k], (aCount - i) * SizeOf(T));
  end;
end;

class procedure TwbMergeSort<T>.UseStackBufferLarge(aList: Pointer; aCount: Integer; aCompare: TListSortCompareTPtr);
var
  Buffer: array[0..Pred(4 * 512)] of T;
begin
  MergeSort(aList, 0, Pred(aCount), aCompare, @Buffer);
end;

class procedure TwbMergeSort<T>.UseStackBufferSmall(aList: Pointer; aCount: Integer; aCompare: TListSortCompareTPtr);
var
  Buffer: array[0..Pred(512)] of T;
begin
  MergeSort(aList, 0, Pred(aCount), aCompare, @Buffer);
end;

class procedure TwbMergeSort<T>.Sort(aList: Pointer; aCount: Integer; aCompare: TListSortCompareTPtr);

var
  Buffer: Pointer;
begin
  if (aCount < 2) or (not Assigned(aList)) then
    Exit;

  if aCount <= MIN_SIZE then
    InsertionSort(aList, 0, Pred(aCount), aCompare)
  else if aCount > 4 * 512 then begin
    GetMem(Buffer, aCount * SizeOf(T));
    MergeSort(aList, 0, Pred(aCount), aCompare, Buffer);
    FreeMem(Buffer);
  end else if aCount > 512 then
    UseStackBufferLarge(aList, aCount, aCompare)
  else
    UseStackBufferSmall(aList, aCount, aCompare);
end;

initialization
  wbMove := @Move;
finalization
end.

