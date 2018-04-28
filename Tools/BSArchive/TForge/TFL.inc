{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2016         * }
{ *********************************************************** }

{$IFDEF FPC}
  {$mode delphi}
  {$asmmode intel}
  {$DEFINE TFL_POINTERMATH}
{$ENDIF}

{$IFNDEF FPC}
  {$IFDEF CONDITIONALEXPRESSIONS}
     {$IF CompilerVersion >= 20.0}
       {$DEFINE TFL_D2009_PLUS}
       {$DEFINE TFL_POINTERMATH}
       {$DEFINE TFL_EXITPARAM}
       {$DEFINE TFL_ANONYMOUS}
     {$IFEND}
     {$IF CompilerVersion >= 21.0}
       {$DEFINE TFL_D2010_PLUS}
       {$DEFINE TFL_DELAYLOAD}
     {$IFEND}
     {$IF CompilerVersion >= 22.0}
       {$DEFINE TFL_DXE_PLUS}
     {$IFEND}
     {$IF CompilerVersion >= 23.0}
       {$DEFINE TFL_DXE2_PLUS}
     {$IFEND}
  {$ENDIF}
{$ENDIF}

{$IFNDEF TFL_LIMB8}
  {$IFNDEF TFL_LIMB16}
    {$IFNDEF TFL_LIMB32}
      {$IFNDEF TFL_LIMB64}
        {$DEFINE TFL_LIMB32}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFNDEF TFL_STDCALL}
  {$IFDEF TFL_DLL}
    {$DEFINE TFL_STDCALL}
  {$ENDIF}
{$ENDIF}

{$IFNDEF TFL_INTFCALL}
  {$IFDEF TFL_DLL}
    {$DEFINE TFL_INTFCALL}
  {$ENDIF}
{$ENDIF}

{$DEFINE TFL_HACK}

// Enable logging
{.$DEFINE TFL_LOG}

// -----------------------------------------------------

// build target:
// TFL_CPUX86_32    - intel x86 32- or 64-bit CPU on 32-bit OS
// TFL_CPUX86_64    - intel x86 64-bit CPU on 64-bit OS
// TFL_CPUX86_WIN32 - intel x86 32- or 64-bit CPU on 32-bit Windows
// TFL_CPUX86_WIN64 - intel x86 64-bit CPU on 64-bit Windows

{$IFDEF FPC}
  {$IFDEF CPUX86_64}
    {$DEFINE CPUX64}
  {$ENDIF}
{$ENDIF}

{$IFDEF WIN32}
  {$DEFINE TFL_WINDOWS}
{$ENDIF}

{$IFDEF WIN64}
  {$DEFINE TFL_WINDOWS}
{$ENDIF}


{$IFDEF CPU386}
  {$DEFINE TFL_CPUX86_32}
  {$IFDEF TFL_LIMB32}
    {$DEFINE TFL_LIMB32_CPUX86_32}
  {$ENDIF}
  {$IFDEF WIN32}
    {$DEFINE TFL_CPUX86_WIN32}
    {$DEFINE TFL_CPU386_WIN32}
    {$IFDEF TFL_LIMB32}
      {$DEFINE TFL_LIMB32_CPUX86_WIN32}
      {$DEFINE TFL_LIMB32_CPU386_WIN32}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF CPUX64}
  {$DEFINE TFL_CPUX86_64}
  {$IFDEF TFL_LIMB32}
    {$DEFINE TFL_LIMB32_CPUX86_64}
  {$ENDIF}
  {$IFDEF WIN64}
    {$DEFINE TFL_CPUX86_WIN64}
    {$DEFINE TFL_CPUX64_WIN64}
    {$IFDEF TFL_LIMB32}
      {$DEFINE TFL_LIMB32_CPUX86_WIN64}
      {$DEFINE TFL_LIMB32_CPUX64_WIN64}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
