{
  User Options
  Following defines and options can be changed by user.
}

{ Source options }

{$DEFINE USE_INLINE}          // Use function inlining for some functions
                              // works in Free Pascal and Delphi 9+.
{$DEFINE USE_ASM}             // Ff defined, assembler versions of some
                              // functions will be used (only for x86).

                              // Debug options: If none of these two are defined
                              // your project settings are used.
{ $DEFINE IMAGING_DEBUG}      // If defined, debug info, range/IO/overflow
                              // checking, stack frames, assertions, and
                              // other debugging options will be turned on.
{ $DEFINE IMAGING_RELEASE}    // If defined, all debug info is off.



(* File format support linking options.
  Define formats which you don't want to be registred automatically.
  Default: all formats are registered = no symbols defined.
  Example: If you want to disable JPEG support just uncomment //{$DEFINE DONT_LINK_JPEG} line
*)

{$DEFINE DONT_LINK_JPEG}        // link support for Jpeg images
//{$DEFINE DONT_LINK_PNG}         // link support for PNG images
//{$DEFINE DONT_LINK_TARGA}       // link support for Targa images
//{$DEFINE DONT_LINK_BITMAP}      // link support for Windows Bitmap images
//{$DEFINE DONT_LINK_DDS}         // link support for DDS images
{$DEFINE DONT_LINK_GIF}         // link support for GIF images
{$DEFINE DONT_LINK_MNG}         // link support for MNG images
{$DEFINE DONT_LINK_JNG}         // link support for JNG images
{$DEFINE DONT_LINK_PNM}         // link support for PortableMap images (PBM, PGM, PPM, PAM, PFM)
{$DEFINE DONT_LINK_RADHDR}      // link support for Radiance HDR/RGBE file format

{$DEFINE DONT_LINK_EXTRAS}  // link support for file formats defined in
                             // Extras package. Exactly which formats will be
                             // registered depends on settings in
                             // ImagingExtras.pas unit.

{ Component set used in ImagignComponents.pas unit. You usually don't need
  to be concerned with this - proper component library is selected automatically
  according to your compiler. }

{$DEFINE COMPONENT_SET_VCL}   // use Delphi VCL
{ $DEFINE COMPONENT_SET_LCL}  // use Lazarus LCL (set automatically when compiling with FPC)

{
  Auto Options
  Following options and defines are set automatically and some
  are required for Imaging to compile successfully. Do not change
  anything here if you don't know what you are doing.
}

{ Compiler options }

{$ALIGN ON}               // Field alignment: 8 Bytes (in D6+)
{$BOOLEVAL OFF}           // Boolean eval: off
{$EXTENDEDSYNTAX ON}      // Extended syntax: on
{$LONGSTRINGS ON}         // string = AnsiString: on
{$MINENUMSIZE 4}          // Min enum size: 4 B
{$TYPEDADDRESS OFF}       // Typed pointers: off
{$WRITEABLECONST OFF}     // Writeable constants: off

{$IFNDEF FPC}
  {$DEFINE DCC}           // if not using FPC then DCC compiler is used (Delphi/BCB)
                          // others are not supported
{$ENDIF}

{$IFDEF DCC}
  {$DEFINE DELPHI}
{$ENDIF}

{$IF (Defined(DCC) and (CompilerVersion >= 18.5))}
  {$IFDEF RELEASE}
    {$UNDEF DEBUG} // If we are using Delphi 2007+ where you can set
                   // DEBUG/RELEASE mode in project options and RELEASE
                   // is currently set we undef DEBUG mode
  {$ENDIF}
{$IFEND}

{$IF Defined(IMAGING_DEBUG)}
  {$ASSERTIONS ON}
  {$DEBUGINFO ON}
  {$RANGECHECKS ON}
  {$IOCHECKS ON}
  {$OVERFLOWCHECKS ON}
  {$IFDEF DCC}
    {$OPTIMIZATION OFF}
    {$STACKFRAMES ON}
    {$LOCALSYMBOLS ON}
    {$DEFINE MEMCHECK}
  {$ENDIF}
  {$IFDEF FPC}
    {$S+}
    {$CHECKPOINTER ON}
  {$ENDIF}
{$ELSEIF Defined(IMAGING_RELEASE)}
  {$ASSERTIONS OFF}
  {$DEBUGINFO OFF}
  {$RANGECHECKS OFF}
  {$IOCHECKS OFF}
  {$OVERFLOWCHECKS OFF}
  {$IFDEF DCC}
    {$OPTIMIZATION ON}
    {$STACKFRAMES OFF}
    {$LOCALSYMBOLS OFF}
  {$ENDIF}
  {$IFDEF FPC}
    {$S-}
  {$ENDIF}
{$IFEND}

{$IF Defined (CPU86) and not Defined(CPUX86)}
  {$DEFINE CPUX86} // Compatibility with Delphi
{$IFEND}

{$IF Defined (CPUX86_64) and not Defined(CPUX64)}
  {$DEFINE CPUX64} // Compatibility with Delphi
{$IFEND}

{$IF Defined (DARWIN) and not Defined(MACOSX)}
  {$DEFINE MACOS} // Compatibility with Delphi
{$IFEND}

{$IF Defined(DCC) and (CompilerVersion < 23)}
  {$DEFINE CPUX86} // Compatibility with older Delphi
{$IFEND}

{ Compiler capabilities }

// Define if compiler supports inlining of functions and procedures
{$IF (Defined(DCC) and (CompilerVersion >= 17)) or Defined(FPC)}
  {$DEFINE HAS_INLINE}
{$IFEND}

// Define if compiler supports advanced records with methods
{$IF (Defined(DCC) and (CompilerVersion >= 18)) or
  (Defined(FPC) and (FPC_FULLVERSION >= 20600))}
  {$DEFINE HAS_ADVANCED_RECORDS}
{$IFEND}

// Define if compiler supports operator overloading
// (unfortunately Delphi and FPC operator overloading is not compatible).
// FPC supports Delphi compatible operator overloads since 2.6.0
{$IF (Defined(DCC) and (CompilerVersion >= 18)) or
  (Defined(FPC) and (FPC_FULLVERSION >= 20600))}
  {$DEFINE HAS_OPERATOR_OVERLOADING}
{$IFEND}

// Anonymous methods
{$IF Defined(DCC) and (CompilerVersion >= 20) }
  {$DEFINE HAS_ANON_METHODS}
{$IFEND}

// Generic types (Delphi and FPC implementations incompatible).
// Update: FPC supports Delphi compatible generics since 2.6.0
{$IF (Defined(DCC) and (CompilerVersion >= 20)) or
  (Defined(FPC) and (FPC_FULLVERSION >= 20600))}
  {$DEFINE HAS_GENERICS}
{$IFEND}

{ Imaging options check}

{$IFNDEF HAS_INLINE}
  {$UNDEF USE_INLINE}
{$ENDIF}

{$IF not Defined(CPUX86)}
  {$UNDEF USE_ASM}
{$IFEND}

{$IFDEF FPC}
  {$DEFINE COMPONENT_SET_LCL}
  {$UNDEF COMPONENT_SET_VCL}
{$ENDIF}

{$IFDEF DELPHI}
  {$UNDEF COMPONENT_SET_LCL}
  {$DEFINE COMPONENT_SET_VCL}
{$ENDIF}

{ Platform options }

{$IF Defined(WIN32) or Defined(WIN64)}
  {$DEFINE MSWINDOWS}
{$IFEND}

{$IFDEF LINUX}
  {$DEFINE UNIX}
{$ENDIF}

{ More compiler options }

{$IFDEF FPC}               // Free Pascal options - some options set above (like min enum size)
                           // are reset to defaults by setting {$MODE} so they are
                           // redeclared here 
  {$MODE DELPHI}           // compatible with delphi
  {$GOTO ON}               // alow goto
  {$PACKRECORDS 8}         // same as ALING 8 for Delphi
  {$PACKENUM 4}            // Min enum size: 4 B
  {$IFDEF CPU86}
    {$ASMMODE INTEL}       // intel assembler mode
  {$ENDIF}
{$ENDIF}

{$IFDEF HAS_INLINE}        
  {$INLINE ON}             // turns inlining on for compilers that support it
{$ENDIF}


