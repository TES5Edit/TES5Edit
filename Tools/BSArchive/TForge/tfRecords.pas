{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2016         * }
{ * ------------------------------------------------------- * }
{ * NB: the unit should normally be 'used'                  * }
{ *   in implementation section of other units (inlining)   * }
{ *********************************************************** }

unit tfRecords;

{$I TFL.inc}

interface

uses tfTypes;

type
  PForgeInstance = ^TForgeInstance;
  TForgeInstance = record
    FVTable: PPointer;
    FRefCount: Integer;
    class function QueryIntf(Inst: Pointer; const IID: TGUID;
                             out Obj): TF_RESULT; stdcall; static;
    class function AddRef(Inst: Pointer): Integer; stdcall; static;
    class function Release(Inst: Pointer): Integer; stdcall; static;
    class function SafeRelease(Inst: Pointer): Integer; stdcall; static;
  end;

  PForgeSingleton = ^TForgeSingleton;
  TForgeSingleton = record
    FVTable: PPointer;
    class function AddRef(Inst: Pointer): Integer; stdcall; static;
    class function Release(Inst: Pointer): Integer; stdcall; static;
  end;

function tfIncrement(var Value: Integer): Integer;
function tfDecrement(var Value: Integer): Integer;

procedure tfAddrefInstance(Inst: Pointer); inline;
procedure tfReleaseInstance(Inst: Pointer); inline;
procedure tfFreeInstance(Inst: Pointer); inline;

function tfTryAllocMem(var P: Pointer; Size: Integer): TF_RESULT;
function tfTryGetMem(var P: Pointer; Size: Integer): TF_RESULT;

function HashAlgRelease(Inst: Pointer): Integer; stdcall;

implementation

function tfTryAllocMem(var P: Pointer; Size: Integer): TF_RESULT;
begin
  try
    P:= AllocMem(Size);
    Result:= TF_S_OK;
  except
    Result:= TF_E_OUTOFMEMORY;
  end;
end;

function tfTryGetMem(var P: Pointer; Size: Integer): TF_RESULT;
begin
  try
    GetMem(P, Size);
    Result:= TF_S_OK;
  except
    Result:= TF_E_OUTOFMEMORY;
  end;
end;


class function TForgeInstance.QueryIntf(Inst: Pointer; const IID: TGUID;
  out Obj): TF_RESULT;
begin
  Result:= TF_E_NOINTERFACE;
end;

{
  Warning: IUnknown uses ULONG (Cardinal) type for refcount;
           TtfRecord implementation uses Integer because
           FRefCount = -1 is reserved for read-only constants
}

{$IFDEF TFL_CPUX86_32}
{ We assume register calling conventions for any 32-bit OS}
(*
function InterlockedAdd(var Addend: Integer; Increment: Integer): Integer;
{$IFDEF FPC}nostackframe;{$ENDIF}
asm
      MOV   ECX,EAX
      MOV   EAX,EDX
 LOCK XADD  [ECX],EAX
      ADD   EAX,EDX
end;
*)

function tfIncrement(var Value: Integer): Integer;
{$IFDEF FPC}assembler; nostackframe;{$ENDIF}
asm
      MOV   ECX,EAX
      MOV   EAX,1
 LOCK XADD  [ECX],EAX
      INC   EAX
end;

function tfDecrement(var Value: Integer): Integer;
{$IFDEF FPC}assembler; nostackframe;{$ENDIF}
asm
      MOV   ECX,EAX
      MOV   EAX,-1
 LOCK XADD  [ECX],EAX
      DEC   EAX
end;

{$ELSE}
{$IFDEF TFL_CPUX86_WIN64}
(*
function InterlockedAdd(var Addend: Integer; Increment: Integer): Integer;
{$IFDEF FPC}nostackframe;{$ENDIF}
asm
      MOV   EAX,EDX
 LOCK XADD  DWORD [RCX],EAX
      ADD   EAX,EDX
end;
*)
function tfIncrement(var Value: Integer): Integer;
{$IFDEF FPC}assembler; nostackframe;{$ENDIF}
asm
      MOV   EAX,1
 LOCK XADD  DWORD [RCX],EAX
      INC   EAX
end;

function tfDecrement(var Value: Integer): Integer;
{$IFDEF FPC}assembler; nostackframe;{$ENDIF}
asm
      MOV   EAX,-1
 LOCK XADD  DWORD [RCX],EAX
      DEC   EAX
end;
{$ELSE}

function tfIncrement(var Value: Integer): Integer;
begin
  Result:= Value + 1;
  Value:= Result;
end;

function tfDecrement(var Value: Integer): Integer;
begin
  Result:= Value - 1;
  Value:= Result;
end;
{$ENDIF}
{$ENDIF}

class function TForgeInstance.Addref(Inst: Pointer): Integer;
begin
// we need this check because FRefCount = -1 is allowed
  if PForgeInstance(Inst).FRefCount > 0 then
    Result:= tfIncrement(PForgeInstance(Inst).FRefCount)
  else
    Result:= PForgeInstance(Inst).FRefCount;
end;

class function TForgeInstance.Release(Inst: Pointer): Integer;
begin
// we need this check because FRefCount = -1 is allowed
  if PForgeInstance(Inst).FRefCount > 0 then begin
    Result:= tfDecrement(PForgeInstance(Inst).FRefCount);
    if Result = 0 then begin
      FreeMem(Inst);
    end;
  end
  else
    Result:= PForgeInstance(Inst).FRefCount;
end;

class function TForgeInstance.SafeRelease(Inst: Pointer): Integer;
type
  TVTable = array[0..3] of Pointer;
  PVTable = ^TVTable;
  PPVTable = ^PVTable;

  TBurn = function(Inst: Pointer): Integer;{$IFDEF TFL_STDCALL}stdcall;{$ENDIF}

begin
// we need this check because FRefCount = -1 is allowed
  if PForgeInstance(Inst).FRefCount > 0 then begin
    Result:= tfDecrement(PForgeInstance(Inst).FRefCount);
    if Result = 0 then begin
      if PPVTable(Inst)^^[3] <> nil then
        TBurn(PPVTable(Inst)^^[3])(Inst);
      FreeMem(Inst);
    end;
  end
  else
    Result:= PForgeInstance(Inst).FRefCount;
end;

procedure tfAddrefInstance(Inst: Pointer);
type
  TVTable = array[0..2] of Pointer;
  PVTable = ^TVTable;
  PPVTable = ^PVTable;

  TAddref = function(Inst: Pointer): Integer; stdcall;

begin
  TAddref(PPVTable(Inst)^^[1])(Inst);
end;


procedure tfReleaseInstance(Inst: Pointer);
type
  TVTable = array[0..2] of Pointer;
  PVTable = ^TVTable;
  PPVTable = ^PVTable;

  TRelease = function(Inst: Pointer): Integer; stdcall;

begin
  TRelease(PPVTable(Inst)^^[2])(Inst);
end;

procedure tfFreeInstance(Inst: Pointer);
type
  TVTable = array[0..2] of Pointer;
  PVTable = ^TVTable;
  PPVTable = ^PVTable;

  TRelease = function(Inst: Pointer): Integer; stdcall;

begin
  if Inst <> nil then TRelease(PPVTable(Inst)^^[2])(Inst);
end;

// todo: remove
// release with purging sensitive information for hash algorithms
function HashAlgRelease(Inst: Pointer): Integer;
type
  TVTable = array[0..9] of Pointer;
  PVTable = ^TVTable;
  PPVTable = ^PVTable;

  TPurgeProc = procedure(Inst: Pointer);
               {$IFDEF TFL_STDCALL}stdcall;{$ENDIF}
var
  PurgeProc: Pointer;

begin
  if PForgeInstance(Inst).FRefCount > 0 then begin
    Result:= tfDecrement(PForgeInstance(Inst).FRefCount);
    if Result = 0 then begin
      PurgeProc:= PPVTable(Inst)^^[6];  // 6 is 'Purge' index
      TPurgeProc(PurgeProc)(Inst);
      FreeMem(Inst);
    end;
  end
  else
    Result:= PForgeInstance(Inst).FRefCount;
end;

{ TForgeSingleton }

class function TForgeSingleton.Addref(Inst: Pointer): Integer;
begin
  Result:= -1;
end;

class function TForgeSingleton.Release(Inst: Pointer): Integer;
begin
  Result:= -1;
end;

end.
