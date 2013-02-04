{$IFNDEF JEDI_INC}
{$DEFINE JEDI_INC}

{******************************************************************************}
{                                                                              }
{  The contents of this file are subject to the Mozilla Public License         }
{  Version 1.1 (the "License"); you may not use this file except in            }
{  compliance with the License. You may obtain a copy of the License at        }
{  http://www.mozilla.org/MPL/                                                 }
{                                                                              }
{  Software distributed under the License is distributed on an "AS IS" basis,  }
{  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License    }
{  for the specific language governing rights and limitations under the        }
{  License.                                                                    }
{                                                                              }
{  The Original Code is: jedi.inc.                                             }
{  The Initial Developer of the Original Code is Project JEDI                  }
{  http://www.delphi-jedi.org                                                  }
{                                                                              }
{  Alternatively, the contents of this file may be used under the terms of     }
{  the GNU Lesser General Public License (the  "LGPL License"), in which case  }
{  the provisions of the LGPL License are applicable instead of those above.   }
{  If you wish to allow use of your version of this file only under the terms  }
{  of the LGPL License and not to allow others to use your version of this     }
{  file under the MPL, indicate your decision by deleting the provisions       }
{  above and replace them with the notice and other provisions required by     }
{  the LGPL License. If you do not delete the provisions above, a recipient    }
{  may use your version of this file under either the MPL or the LGPL License. }
{                                                                              }
{  For more information about the LGPL:                                        }
{  http://www.gnu.org/copyleft/lesser.html                                     }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file defines various generic compiler directives used in different     }
{  libraries, e.g. in the JEDI Code Library (JCL) and JEDI Visual Component    }
{  Library Library (J-VCL). The directives in this file are of generic nature  }
{  and consist mostly of mappings from the VERXXX directives defined by        }
{  Delphi, C++ Builder and FPC to friendly names such as DELPHI5 and           }
{  SUPPORTS_WIDESTRING. These friendly names are subsequently used in the      }
{  libraries to test for compiler versions and/or whether the compiler         }
{  supports certain features (such as widestrings or 64 bit integers. The      }
{  libraries provide an additional, library specific, include file. For the    }
{  JCL e.g. this is jcl.inc. These files should be included in source files    }
{  instead of this file (which is pulled in automatically).                    }
{                                                                              }
{******************************************************************************}

// Last modified: $Date: 2005/12/30 21:29:55 $
// For history see end of file

(*

- Development environment directives

  This file defines two directives to indicate which development environment the
  library is being compiled with. Currently this can either be Delphi, Kylix,
  C++ Builder or FPC.

  Directive           Description
  ------------------------------------------------------------------------------
  DELPHI              Defined if compiled with Delphi
  KYLIX               Defined if compiled with Kylix
  DELPHICOMPILER      Defined if compiled with Delphi or Kylix/Delphi
  BCB                 Defined if compiled with C++ Builder
  CPPBUILDER          Defined if compiled with C++ Builder (alias for BCB)
  BCBCOMPILER         Defined if compiled with C++ Builder or Kylix/C++
  DELPHILANGUAGE      Defined if compiled with Delphi, Kylix or C++ Builder
  BORLAND             Defined if compiled with Delphi, Kylix or C++ Builder
  FPC                 Defined if compiled with FPC

- Platform Directives

  Platform directives are not all explicitly defined in this file, some are
  defined by the compiler itself. They are listed here only for completeness.

  Directive           Description
  ------------------------------------------------------------------------------
  WIN32               Defined when target platform is 32 bit Windows
  MSWINDOWS           Defined when target platform is 32 bit Windows
  LINUX               Defined when target platform is Linux
  UNIX                Defined when target platform is Linux or Unix


- Visual library Directives

  The following directives indicate for a visual library. In a Delphi/BCB
  (Win32) application you need to define the VisualCLX symbol in the project
  options, if  you want to use the VisualCLX library. Alternatively you can use
  the IDE expert, which is distributed with the JCL to do this automatically.

  Directive           Description
  ------------------------------------------------------------------------------
  VCL                 Defined for Delphi/BCB (Win32) exactly if VisualCLX is not defined
  VisualCLX           Defined for Kylix; needs to be defined for Delphi/BCB to
                      use JCL with VisualCLX applications.


- Other cross-platform related defines

  These symbols are intended to help in writing portable code.

  Directive           Description
  ------------------------------------------------------------------------------
  PUREPASCAL          Code is machine-independent (as opposed to assembler code)
  Win32API            Code is specific for the Win32 API;
                      use instead of "{$IFNDEF CLR} {$IFDEF MSWINDOWS}" constructs


- Delphi Versions

  The following directives are direct mappings from the VERXXX directives to a
  friendly name of the associated compiler. These directives are only defined if
  the compiler is Delphi (ie DELPHI is defined).

  Directive           Description
  ------------------------------------------------------------------------------
  DELPHI1             Defined when compiling with Delphi 1
  DELPHI2             Defined when compiling with Delphi 2
  DELPHI3             Defined when compiling with Delphi 3
  DELPHI4             Defined when compiling with Delphi 4
  DELPHI5             Defined when compiling with Delphi 5
  DELPHI6             Defined when compiling with Delphi 6
  DELPHI7             Defined when compiling with Delphi 7
  DELPHI8             Defined when compiling with Delphi 8
  DELPHI2005          Defined when compiling with Delphi 2005
  DELPHI9             Alias for DELPHI2005
  DELPHI10            Defined when compiling with Delphi Personality of BDS 4.0
  DELPHI1_UP          Defined when compiling with Delphi 1 or higher
  DELPHI2_UP          Defined when compiling with Delphi 2 or higher
  DELPHI3_UP          Defined when compiling with Delphi 3 or higher
  DELPHI4_UP          Defined when compiling with Delphi 4 or higher
  DELPHI5_UP          Defined when compiling with Delphi 5 or higher
  DELPHI6_UP          Defined when compiling with Delphi 6 or higher
  DELPHI7_UP          Defined when compiling with Delphi 7 or higher
  DELPHI8_UP          Defined when compiling with Delphi 8 or higher
  DELPHI2005_UP       Defined when compiling with Delphi 2005 or higher
  DELPHI9_UP          Alias for DELPHI2005_UP
  DELPHI10_UP         Defined when compiling with Delphi Personality of BDS 4.0


- Kylix Versions

  The following directives are direct mappings from the VERXXX directives to a
  friendly name of the associated compiler. These directives are only defined if
  the compiler is Kylix (ie KYLIX is defined).

  Directive           Description
  ------------------------------------------------------------------------------
  KYLIX1              Defined when compiling with Kylix 1
  KYLIX2              Defined when compiling with Kylix 2
  KYLIX3              Defined when compiling with Kylix 3
  KYLIX1_UP           Defined when compiling with Kylix 1 or higher
  KYLIX2_UP           Defined when compiling with Kylix 2 or higher
  KYLIX3_UP           Defined when compiling with Kylix 3 or higher


- Delphi Compiler Versions (Delphi / Kylix, not in BCB mode)

  Directive           Description
  ------------------------------------------------------------------------------
  DELPHICOMPILER1     Defined when compiling with Delphi 1
  DELPHICOMPILER2     Defined when compiling with Delphi 2
  DELPHICOMPILER3     Defined when compiling with Delphi 3
  DELPHICOMPILER4     Defined when compiling with Delphi 4
  DELPHICOMPILER5     Defined when compiling with Delphi 5
  DELPHICOMPILER6     Defined when compiling with Delphi 6 or Kylix 1, 2 or 3
  DELPHICOMPILER7     Defined when compiling with Delphi 7
  DELPHICOMPILER8     Defined when compiling with Delphi 8
  DELPHICOMPILER9     Defined when compiling with Delphi 2005
  DELPHICOMPILER10    Defined when compiling with Delphi Personality of BDS 4.0
  DELPHICOMPILER1_UP  Defined when compiling with Delphi 1 or higher
  DELPHICOMPILER2_UP  Defined when compiling with Delphi 2 or higher
  DELPHICOMPILER3_UP  Defined when compiling with Delphi 3 or higher
  DELPHICOMPILER4_UP  Defined when compiling with Delphi 4 or higher
  DELPHICOMPILER5_UP  Defined when compiling with Delphi 5 or higher
  DELPHICOMPILER6_UP  Defined when compiling with Delphi 6 or Kylix 1, 2 or 3 or higher
  DELPHICOMPILER7_UP  Defined when compiling with Delphi 7 or higher
  DELPHICOMPILER8_UP  Defined when compiling with Delphi 8 or higher
  DELPHICOMPILER9_UP  Defined when compiling with Delphi 2005
  DELPHICOMPILER10_UP Defined when compiling with Delphi Personality of BDS 4.0 or higher


- C++ Builder Versions

  The following directives are direct mappings from the VERXXX directives to a
  friendly name of the associated compiler. These directives are only defined if
  the compiler is C++ Builder (ie BCB is defined).

  Directive    Description
  ------------------------------------------------------------------------------
  BCB1         Defined when compiling with C++ Builder 1
  BCB3         Defined when compiling with C++ Builder 3
  BCB4         Defined when compiling with C++ Builder 4
  BCB5         Defined when compiling with C++ Builder 5
  BCB6         Defined when compiling with C++ Builder 6
  BCB10        Defined when compiling with C++ Builder Personality of BDS 4.0
  BCB1_UP      Defined when compiling with C++ Builder 1 or higher
  BCB3_UP      Defined when compiling with C++ Builder 3 or higher
  BCB4_UP      Defined when compiling with C++ Builder 4 or higher
  BCB5_UP      Defined when compiling with C++ Builder 5 or higher
  BCB6_UP      Defined when compiling with C++ Builder 6 or higher
  BCB10_UP     Defined when compiling with C++ Builder Personality of BDS 4.0 or higher


- Borland Developer Studio Versions

  The following directives are direct mappings from the VERXXX directives to a
  friendly name of the associated IDE. These directives are only defined if
  the IDE is Borland Developer Studio Version 2 or above.

  Note: Borland Developer Studio 2006 is marketed as Delphi 2006 or C++Builder 2006,
  but those provide only different labels for identical content.

  Directive    Description
  ------------------------------------------------------------------------------
  BDS          Defined when compiling with a Borland Developer Studio version's dcc32.exe
  BDS2         Defined when compiling with BDS 2.0 (Delphi 8)
  BDS3         Defined when compiling with BDS 3.0 (Delphi 2005)
  BDS4         Defined when compiling with BDS 4.0 (Borland Developer Studio 2006)
  BDS2_UP      Defined when compiling with BDS 2.0 or higher
  BDS3_UP      Defined when compiling with BDS 3.0 or higher
  BDS4_UP      Defined when compiling with BDS 4.0 or higher

- Compiler Versions

  The following directives are direct mappings from the VERXXX directives to a
  friendly name of the associated compiler. Unlike the DELPHI_X and BCB_X
  directives, these directives are indepedent of the development environment.
  That is, they are defined regardless of whether compilation takes place using
  Delphi or C++ Builder.

  Directive     Description
  ------------------------------------------------------------------------------
  COMPILER1     Defined when compiling with Delphi 1
  COMPILER2     Defined when compiling with Delphi 2 or C++ Builder 1
  COMPILER3     Defined when compiling with Delphi 3
  COMPILER35    Defined when compiling with C++ Builder 3
  COMPILER4     Defined when compiling with Delphi 4 or C++ Builder 4
  COMPILER5     Defined when compiling with Delphi 5 or C++ Builder 5
  COMPILER6     Defined when compiling with Delphi 6 or C++ Builder 6
  COMPILER7     Defined when compiling with Delphi 7
  COMPILER8     Defined when compiling with Delphi 8
  COMPILER9     Defined when compiling with Delphi 9
  COMPILER10    Defined when compiling with Delphi or C++ Builder Personalities of BDS 4.0
  COMPILER1_UP  Defined when compiling with Delphi 1 or higher
  COMPILER2_UP  Defined when compiling with Delphi 2 or C++ Builder 1 or higher
  COMPILER3_UP  Defined when compiling with Delphi 3 or higher
  COMPILER35_UP Defined when compiling with C++ Builder 3 or higher
  COMPILER4_UP  Defined when compiling with Delphi 4 or C++ Builder 4 or higher
  COMPILER5_UP  Defined when compiling with Delphi 5 or C++ Builder 5 or higher
  COMPILER6_UP  Defined when compiling with Delphi 6 or C++ Builder 6 or higher
  COMPILER7_UP  Defined when compiling with Delphi 7
  COMPILER8_UP  Defined when compiling with Delphi 8
  COMPILER9_UP  Defined when compiling with Delphi Personalities of BDS 3.0
  COMPILER10_UP Defined when compiling with Delphi or C++ Builder Personalities of BDS 4.0 or higher


- RTL Versions

  Use e.g. following to determine the exact RTL version since version 14.0:
    {$IFDEF CONDITIONALEXPRESSIONS}
      {$IF Declared(RTLVersion) and (RTLVersion >= 14.2)}
        // code for Delphi 6.02 or later, Kylix 2 or later, C++ Builder 6 or later
        ...
      {$IFEND}
    {$ENDIF}

  Directive     Description
  ------------------------------------------------------------------------------
  RTL80_UP      Defined when compiling with Delphi 1 or later
  RTL90_UP      Defined when compiling with Delphi 2 or later
  RTL93_UP      Defined when compiling with C++ Builder 1 or later
  RTL100_UP     Defined when compiling with Delphi 3 or later
  RTL110_UP     Defined when compiling with C++ Builder 3 or later
  RTL120_UP     Defined when compiling with Delphi 4 or later
  RTL125_UP     Defined when compiling with C++ Builder 4 or later
  RTL130_UP     Defined when compiling with Delphi 5 or C++ Builder 5 or later
  RTL140_UP     Defined when compiling with Delphi 6, Kylix 1, 2 or 3 or C++ Builder 6 or later
  RTL150_UP     Defined when compiling with Delphi 7 or later
  RTL160_UP     Defined when compiling with Delphi 8 or later
  RTL170_UP     Defined when compiling with Delphi Personalities of BDS 3.0 or later
  RTL180_UP     Defined when compiling with Delphi or C++ Builder Personalities of BDS 4.0 or later


- Feature Directives

  The features directives are used to test if the compiler supports specific
  features, such as method overloading, and adjust the sources accordingly. Use
  of these directives is preferred over the use of the DELPHI and COMPILER
  directives.

  Directive              Description
  ------------------------------------------------------------------------------
  SUPPORTS_CONSTPARAMS          Compiler supports const parameters (D1+)
  SUPPORTS_SINGLE               Compiler supports the Single type (D1+)
  SUPPORTS_DOUBLE               Compiler supports the Double type (D1+)
  SUPPORTS_EXTENDED             Compiler supports the Extended type (D1+)
  SUPPORTS_CURRENCY             Compiler supports the Currency type (D2+)
  SUPPORTS_THREADVAR            Compiler supports threadvar declarations (D2+)
  SUPPORTS_OUTPARAMS            Compiler supports out parameters (D3+)
  SUPPORTS_VARIANT              Compiler supports variant (D2+)
  SUPPORTS_WIDECHAR             Compiler supports the WideChar type (D2+)
  SUPPORTS_WIDESTRING           Compiler supports the WideString type (D3+/BCB3+)
  SUPPORTS_INTERFACE            Compiler supports interfaces (D3+/BCB3+)
  SUPPORTS_DISPINTERFACE        Compiler supports dispatch interfaces (D3+/BCB3+)
  SUPPORTS_DISPID               Compiler supports dispatch ids (D3+/BCB3+/FPC)
  SUPPORTS_EXTSYM               Compiler supports the $EXTERNALSYM directive (D4+/BCB3+)
  SUPPORTS_NODEFINE             Compiler supports the $NODEFINE directive (D4+/BCB3+)
  SUPPORTS_LONGWORD             Compiler supports the LongWord type (unsigned 32 bit) (D4+/BCB4+)
  SUPPORTS_INT64                Compiler supports the Int64 type (D4+/BCB4+)
  SUPPORTS_DYNAMICARRAYS        Compiler supports dynamic arrays (D4+/BCB4+)
  SUPPORTS_DEFAULTPARAMS        Compiler supports default parameters (D4+/BCB4+)
  SUPPORTS_OVERLOAD             Compiler supports overloading (D4+/BCB4+)
  SUPPORTS_IMPLEMENTS           Compiler supports implements (D4+/BCB4+)
  SUPPORTS_DEPRECATED           Compiler supports the deprecated directive (D6+/BCB6+)
  SUPPORTS_PLATFORM             Compiler supports the platform directive (D6+/BCB6+)
  SUPPORTS_LIBRARY              Compiler supports the library directive (D6+/BCB6+)
  SUPPORTS_LOCAL                Compiler supports the local directive (D6+/BCB6+)
  SUPPORTS_INLINE               Compiler supports the inline directive (D9+)
  SUPPORTS_FOR_IN               Compiler supports for in loops (D9+)
  SUPPORTS_NESTED_CONSTANTS     Compiler supports nested constants (D9+)
  SUPPORTS_NESTED_TYPES         Compiler supports nested types (D9+)
  SUPPORTS_ENHANCED_RECORDS     Compiler supports class [operator|function|procedure] for record types (D9.NET, D10+)
  SUPPORTS_CLASS_FIELDS         Compiler supports class fields (D9.NET, D10+)
  SUPPORTS_CLASS_HELPERS        Compiler supports class helpers (D9.NET, D10+)
  SUPPORTS_CLASS_OPERATORS      Compiler supports class operators (D9.NET, D10+)
  SUPPORTS_STRICT               Compiler supports strict keyword (D9.NET, D10+)
  SUPPORTS_STATIC               Compiler supports static keyword (D9.NET, D10+)
  SUPPORTS_FINAL                Compiler supports final keyword (D9.NET, D10+)
  ACCEPT_DEPRECATED             Compiler supports or ignores the deprecated directive (D6+/BCB6+/FPC)
  ACCEPT_PLATFORM               Compiler supports or ignores the platform directive (D6+/BCB6+)
  ACCEPT_LIBRARY                Compiler supports or ignores the library directive (D6+/BCB6+)
  SUPPORTS_CUSTOMVARIANTS       Compiler supports custom variants (D6+/BCB6+)
  SUPPORTS_VARARGS              Compiler supports varargs (D6+/BCB6+)
  SUPPORTS_ENUMVALUE            Compiler supports assigning ordinalities to values of enums (D6+/BCB6+)
  SUPPORTS_DEPRECATED_WARNINGS  Compiler supports deprecated warnings (D6+/BCB6+)
  SUPPORTS_LIBRARY_WARNINGS     Compiler supports library warnings (D6+/BCB6+)
  SUPPORTS_PLATFORM_WARNINGS    Compiler supports platform warnings (D6+/BCB6+)
  SUPPORTS_UNSAFE_WARNINGS      Compiler supports unsafe warnings (D7)
  SUPPORTS_WEAKPACKAGEUNIT      Compiler supports the WEAKPACKAGEUNIT directive
  SUPPORTS_COMPILETIME_MESSAGES Compiler supports the MESSAGE directive
  HAS_UNIT_LIBC                 Unit Libc exists (Kylix, FPC on Linux)
  HAS_UNIT_RTLCONSTS            Unit RTLConsts exists (D6+/BCB6+)
  HAS_UNIT_TYPES                Unit Types exists (D6+/BCB6+)
  HAS_UNIT_VARIANTS             Unit Variants exists (D6+/BCB6+)
  HAS_UNIT_STRUTILS             Unit StrUtils exists (D6+/BCB6+)
  XPLATFORM_RTL                 The RTL supports crossplatform function names (e.g. RaiseLastOSError) (D6+/BCB6+/FPC)


- Compiler Settings

  The compiler settings directives indicate whether a specific compiler setting
  is in effect. This facilitates changing compiler settings locally in a more
  compact and readible manner.

  Directive              Description
  ------------------------------------------------------------------------------
  ALIGN_ON               Compiling in the A+ state (no alignment)
  BOOLEVAL_ON            Compiling in the B+ state (complete boolean evaluation)
  ASSERTIONS_ON          Compiling in the C+ state (assertions on)
  DEBUGINFO_ON           Compiling in the D+ state (debug info generation on)
  IMPORTEDDATA_ON        Compiling in the G+ state (creation of imported data references)
  LONGSTRINGS_ON         Compiling in the H+ state (string defined as AnsiString)
  IOCHECKS_ON            Compiling in the I+ state (I/O checking enabled)
  WRITEABLECONST_ON      Compiling in the J+ state (typed constants can be modified)
  LOCALSYMBOLS           Compiling in the L+ state (local symbol generation)
  TYPEINFO_ON            Compiling in the M+ state (RTTI generation on)
  OPTIMIZATION_ON        Compiling in the O+ state (code optimization on)
  OPENSTRINGS_ON         Compiling in the P+ state (variable string parameters are openstrings)
  OVERFLOWCHECKS_ON      Compiling in the Q+ state (overflow checing on)
  RANGECHECKS_ON         Compiling in the R+ state (range checking on)
  TYPEDADDRESS_ON        Compiling in the T+ state (pointers obtained using the @ operator are typed)
  SAFEDIVIDE_ON          Compiling in the U+ state (save FDIV instruction through RTL emulation)
  VARSTRINGCHECKS_ON     Compiling in the V+ state (type checking of shortstrings)
  STACKFRAMES_ON         Compiling in the W+ state (generation of stack frames)
  EXTENDEDSYNTAX_ON      Compiling in the X+ state (Delphi extended syntax enabled)
*)

{$DEFINE BORLAND}

{ Set FreePascal to Delphi mode }
{$IFDEF FPC}
  {$MODE DELPHI}
  {$ASMMODE Intel}
  {$UNDEF BORLAND}
{$ENDIF}

{$IFDEF BORLAND}
  {$IFDEF LINUX}
    {$DEFINE KYLIX}
  {$ENDIF LINUX}
{$ENDIF BORLAND}

{------------------------------------------------------------------------------}
{ VERXXX to COMPILERX, DELPHIX and BCBX mappings                               }
{------------------------------------------------------------------------------}

{$IFDEF BORLAND}
  {$IFDEF KYLIX}
    {$I kylix.inc} // FPC incompatible stuff
  {$ELSE ~KYLIX}

    {$IFDEF VER180}
      {$DEFINE BDS4}
      {$DEFINE BDS}
      {$DEFINE COMPILER10}
      {$IFDEF BCB}
        {$DEFINE BCB10}
      {$ELSE}
        {$DEFINE DELPHI10}
        {$DEFINE DELPHICOMPILER10}
      {$ENDIF}
      {$DEFINE RTL180_UP}
    {$ENDIF}

    {$IFDEF VER170}
      {$DEFINE BDS3}
      {$DEFINE BDS}
      {$DEFINE COMPILER9}
      {$DEFINE DELPHI9}
      {$DEFINE DELPHI2005} // synonym to DELPHI9
      {$DEFINE DELPHICOMPILER9}
      {$DEFINE RTL170_UP}
    {$ENDIF}

    {$IFDEF VER160}
      {$DEFINE BDS2}
      {$DEFINE BDS}
      {$DEFINE COMPILER8}
      {$DEFINE DELPHI8}
      {$DEFINE DELPHICOMPILER8}
      {$DEFINE RTL160_UP}
    {$ENDIF}

    {$IFDEF VER150}
      {$DEFINE COMPILER7}
      {$DEFINE DELPHI7}
      {$DEFINE DELPHICOMPILER7}
      {$DEFINE RTL150_UP}
    {$ENDIF}

    {$IFDEF VER140}
      {$DEFINE COMPILER6}
      {$IFDEF BCB}
        {$DEFINE BCB6}
      {$ELSE}
        {$DEFINE DELPHI6}
        {$DEFINE DELPHICOMPILER6}
      {$ENDIF}
      {$DEFINE RTL140_UP}
    {$ENDIF}

    {$IFDEF VER130}
      {$DEFINE COMPILER5}
      {$IFDEF BCB}
        {$DEFINE BCB5}
      {$ELSE}
        {$DEFINE DELPHI5}
        {$DEFINE DELPHICOMPILER5}
      {$ENDIF}
      {$DEFINE RTL130_UP}
    {$ENDIF}

    {$IFDEF VER125}
      {$DEFINE COMPILER4}
      {$DEFINE BCB4}
      {$DEFINE BCB}
      {$DEFINE RTL125_UP}
    {$ENDIF}

    {$IFDEF VER120}
      {$DEFINE COMPILER4}
      {$DEFINE DELPHI4}
      {$DEFINE DELPHICOMPILER4}
      {$DEFINE RTL120_UP}
    {$ENDIF}

    {$IFDEF VER110}
      {$DEFINE COMPILER35}
      {$DEFINE BCB3}
      {$DEFINE RTL110_UP}
    {$ENDIF}

    {$IFDEF VER100}
      {$DEFINE COMPILER3}
      {$DEFINE DELPHI3}
      {$DEFINE DELPHICOMPILER3}
      {$DEFINE RTL100_UP}
    {$ENDIF}

    {$IFDEF VER93}
      {$DEFINE COMPILER2}
      {$DEFINE BCB1}
      {$DEFINE BCB}
      {$DEFINE RTL93_UP}
    {$ENDIF}

    {$IFDEF VER90}
      {$DEFINE COMPILER2}
      {$DEFINE DELPHI2}
      {$DEFINE DELPHICOMPILER2}
      {$DEFINE RTL90_UP}
    {$ENDIF}

    {$IFDEF VER80}
      {$DEFINE COMPILER1}
      {$DEFINE DELPHI1}
      {$DEFINE DELPHICOMPILER1}
      {$DEFINE RTL80_UP}
    {$ENDIF}

  {$ENDIF ~KYLIX}

  {$IFDEF BCB}
    {$DEFINE CPPBUILDER}
    {$DEFINE BCBCOMPILER}
  {$ELSE ~BCB}
    {$DEFINE DELPHI}
    {$DEFINE DELPHICOMPILER}
  {$ENDIF ~BCB}

{$ENDIF BORLAND}

{------------------------------------------------------------------------------}
{ DELPHIX_UP from DELPHIX mappings                                             }
{------------------------------------------------------------------------------}

{$IFDEF DELPHI10}
  {$DEFINE DELPHI10_UP}
  {$DEFINE DELPHI2005_UP // synonym to DELPHI9_UP }
  {$DEFINE DELPHI9_UP}
  {$DEFINE DELPHI8_UP}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI9}
  {$DEFINE DELPHI2005_UP} // synonym to DELPHI9_UP
  {$DEFINE DELPHI9_UP}
  {$DEFINE DELPHI8_UP}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI8}
  {$DEFINE DELPHI8_UP}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI7}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI6}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI5}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI4}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI3}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI2}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF DELPHI1}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{------------------------------------------------------------------------------}
{ KYLIXX_UP from KYLIXX mappings                                               }
{------------------------------------------------------------------------------}

{$IFDEF KYLIX3}
  {$DEFINE KYLIX3_UP}
  {$DEFINE KYLIX2_UP}
  {$DEFINE KYLIX1_UP}
{$ENDIF}

{$IFDEF KYLIX2}
  {$DEFINE KYLIX2_UP}
  {$DEFINE KYLIX1_UP}
{$ENDIF}

{$IFDEF KYLIX1}
  {$DEFINE KYLIX1_UP}
{$ENDIF}

{------------------------------------------------------------------------------}
{ BCBX_UP from BCBX mappings                                                   }
{------------------------------------------------------------------------------}

{$IFDEF BCB10}
  {$DEFINE BCB10_UP}
  {$DEFINE BCB6_UP}
  {$DEFINE BCB5_UP}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB6}
  {$DEFINE BCB6_UP}
  {$DEFINE BCB5_UP}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB5}
  {$DEFINE BCB5_UP}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB4}
  {$DEFINE BCB4_UP}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB3}
  {$DEFINE BCB3_UP}
  {$DEFINE BCB1_UP}
{$ENDIF}

{$IFDEF BCB1}
  {$DEFINE BCB1_UP}
{$ENDIF}

{------------------------------------------------------------------------------}
{ BDSX_UP from BDSX mappings                                                   }
{------------------------------------------------------------------------------}

{$IFDEF BDS4}
  {$DEFINE BDS4_UP}
  {$DEFINE BDS3_UP}
  {$DEFINE BDS2_UP}
{$ENDIF}

{$IFDEF BDS3}
  {$DEFINE BDS3_UP}
  {$DEFINE BDS2_UP}
{$ENDIF}

{$IFDEF BDS2}
  {$DEFINE BDS2_UP}
{$ENDIF}

{------------------------------------------------------------------------------}
{ DELPHICOMPILERX_UP from DELPHICOMPILERX mappings                             }
{------------------------------------------------------------------------------}

{$IFDEF DELPHICOMPILER10}
  {$DEFINE DELPHICOMPILER10_UP}
  {$DEFINE DELPHICOMPILER9_UP}
  {$DEFINE DELPHICOMPILER8_UP}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER9}
  {$DEFINE DELPHICOMPILER9_UP}
  {$DEFINE DELPHICOMPILER8_UP}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER8}
  {$DEFINE DELPHICOMPILER8_UP}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER7}
  {$DEFINE DELPHICOMPILER7_UP}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER6}
  {$DEFINE DELPHICOMPILER6_UP}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER5}
  {$DEFINE DELPHICOMPILER5_UP}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER4}
  {$DEFINE DELPHICOMPILER4_UP}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER3}
  {$DEFINE DELPHICOMPILER3_UP}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER2}
  {$DEFINE DELPHICOMPILER2_UP}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{$IFDEF DELPHICOMPILER1}
  {$DEFINE DELPHICOMPILER1_UP}
{$ENDIF}

{------------------------------------------------------------------------------}
{ COMPILERX_UP from COMPILERX mappings                                         }
{------------------------------------------------------------------------------}

{$IFDEF COMPILER10}
  {$DEFINE COMPILER10_UP}
  {$DEFINE COMPILER9_UP}
  {$DEFINE COMPILER8_UP}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER9}
  {$DEFINE COMPILER9_UP}
  {$DEFINE COMPILER8_UP}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER8}
  {$DEFINE COMPILER8_UP}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER7}
  {$DEFINE COMPILER7_UP}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER6}
  {$DEFINE COMPILER6_UP}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER5}
  {$DEFINE COMPILER5_UP}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER4}
  {$DEFINE COMPILER4_UP}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER35}
  {$DEFINE COMPILER35_UP}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER3}
  {$DEFINE COMPILER3_UP}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER2}
  {$DEFINE COMPILER2_UP}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{$IFDEF COMPILER1}
  {$DEFINE COMPILER1_UP}
{$ENDIF}

{------------------------------------------------------------------------------}

{$IFDEF DELPHICOMPILER}
  {$DEFINE DELPHILANGUAGE}
{$ENDIF}

{$IFDEF BCBCOMPILER}
  {$DEFINE DELPHILANGUAGE}
{$ENDIF}

{------------------------------------------------------------------------------}
{ RTLX_UP from RTLX_UP mappings                                                }
{------------------------------------------------------------------------------}

{$IFDEF RTL180_UP}
  {$DEFINE RTL170_UP}
{$ENDIF}

{$IFDEF RTL170_UP}
  {$DEFINE RTL160_UP}
{$ENDIF}

{$IFDEF RTL160_UP}
  {$DEFINE RTL150_UP}
{$ENDIF}

{$IFDEF RTL150_UP}
  {$DEFINE RTL145_UP}
{$ENDIF}

{$IFDEF RTL145_UP}
  {$DEFINE RTL142_UP}
{$ENDIF}

{$IFDEF RTL142_UP}
  {$DEFINE RTL140_UP}
{$ENDIF}

{$IFDEF RTL140_UP}
  {$DEFINE RTL130_UP}
{$ENDIF}

{$IFDEF RTL130_UP}
  {$DEFINE RTL125_UP}
{$ENDIF}

{$IFDEF RTL125_UP}
  {$DEFINE RTL120_UP}
{$ENDIF}

{$IFDEF RTL120_UP}
  {$DEFINE RTL110_UP}
{$ENDIF}

{$IFDEF RTL110_UP}
  {$DEFINE RTL100_UP}
{$ENDIF}

{$IFDEF RTL100_UP}
  {$DEFINE RTL93_UP}
{$ENDIF}

{$IFDEF RTL93_UP}
  {$DEFINE RTL90_UP}
{$ENDIF}

{$IFDEF RTL90_UP}
  {$DEFINE RTL80_UP}
{$ENDIF}

{------------------------------------------------------------------------------}
{ Map COMPILERX_UP to friendly feature names                                   }
{------------------------------------------------------------------------------}

{$IFDEF FPC}
  {$IFDEF  VER1_0}
     Please use FPC 2.0 or later to compile this.
  {$ELSE}
    {$DEFINE SUPPORTS_OUTPARAMS}
    {$DEFINE SUPPORTS_WIDECHAR}
    {$DEFINE SUPPORTS_WIDESTRING}
    {$IFDEF HASINTF}
      {$DEFINE SUPPORTS_INTERFACE}
    {$ENDIF}
    {$IFDEF HASVARIANT}
      {$DEFINE SUPPORTS_VARIANT}
    {$ENDIF}
    {$IFDEF FPC_HAS_TYPE_SINGLE}
      {$DEFINE SUPPORTS_SINGLE}
    {$ENDIF}
    {$IFDEF FPC_HAS_TYPE_DOUBLE}
      {$DEFINE SUPPORTS_DOUBLE}
    {$ENDIF}
    {$IFDEF FPC_HAS_TYPE_EXTENDED}
      {$DEFINE SUPPORTS_EXTENDED}
    {$ENDIF}
    {$IFDEF HASCURRENCY}
      {$DEFINE SUPPORTS_CURRENCY}
    {$ENDIF}
    {$DEFINE SUPPORTS_THREADVAR}
    {$DEFINE SUPPORTS_CONSTPARAMS}
    {$DEFINE SUPPORTS_LONGWORD}
    {$DEFINE SUPPORTS_INT64}
    {$DEFINE SUPPORTS_DYNAMICARRAYS}
    {$DEFINE SUPPORTS_DEFAULTPARAMS}
    {$DEFINE SUPPORTS_OVERLOAD}
    {$DEFINE ACCEPT_DEPRECATED}
    {$DEFINE ACCEPT_PLATFORM}
    {$DEFINE ACCEPT_LIBRARY}
    {$DEFINE SUPPORTS_EXTSYM}
    {$DEFINE SUPPORTS_NODEFINE}

    {$DEFINE SUPPORTS_CUSTOMVARIANTS}
    {$DEFINE SUPPORTS_VARARGS}
    {$DEFINE SUPPORTS_ENUMVALUE}
    {$IFDEF LINUX}
      {$DEFINE HAS_UNIT_LIBC}
    {$ENDIF LINUX}
    {$DEFINE HAS_UNIT_TYPES}
    {$DEFINE HAS_UNIT_VARIANTS}
    {$DEFINE HAS_UNIT_STRUTILS}
    {$DEFINE HAS_UNIT_RTLCONSTS}

    {$DEFINE XPLATFORM_RTL}

    {$UNDEF SUPPORTS_DISPINTERFACE}
    {$UNDEF SUPPORTS_IMPLEMENTS}
    {$UNDEF SUPPORTS_UNSAFE_WARNINGS}
  {$ENDIF}
{$ENDIF FPC}

{$IFDEF COMPILER1_UP}
  {$DEFINE SUPPORTS_CONSTPARAMS}
  {$DEFINE SUPPORTS_SINGLE}
  {$DEFINE SUPPORTS_DOUBLE}
  {$DEFINE SUPPORTS_EXTENDED}
{$ENDIF COMPILER1_UP}

{$IFDEF COMPILER2_UP}
  {$DEFINE SUPPORTS_CURRENCY}
  {$DEFINE SUPPORTS_THREADVAR}
  {$DEFINE SUPPORTS_VARIANT}
  {$DEFINE SUPPORTS_WIDECHAR}
{$ENDIF COMPILER2_UP}

{$IFDEF COMPILER3_UP}
  {$DEFINE SUPPORTS_OUTPARAMS}
  {$DEFINE SUPPORTS_WIDESTRING}
  {$DEFINE SUPPORTS_INTERFACE}
  {$DEFINE SUPPORTS_DISPINTERFACE}
  {$DEFINE SUPPORTS_DISPID}
  {$DEFINE SUPPORTS_WEAKPACKAGEUNIT}
{$ENDIF COMPILER3_UP}

{$IFDEF COMPILER35_UP}
  {$DEFINE SUPPORTS_EXTSYM}
  {$DEFINE SUPPORTS_NODEFINE}
{$ENDIF COMPILER35_UP}

{$IFDEF COMPILER4_UP}
  {$DEFINE SUPPORTS_LONGWORD}
  {$DEFINE SUPPORTS_INT64}
  {$DEFINE SUPPORTS_DYNAMICARRAYS}
  {$DEFINE SUPPORTS_DEFAULTPARAMS}
  {$DEFINE SUPPORTS_OVERLOAD}
  {$DEFINE SUPPORTS_IMPLEMENTS}
{$ENDIF COMPILER4_UP}

{$IFDEF COMPILER6_UP}
  {$DEFINE SUPPORTS_DEPRECATED}
  {$DEFINE SUPPORTS_LIBRARY}
  {$DEFINE SUPPORTS_PLATFORM}
  {$DEFINE SUPPORTS_LOCAL}
  {$DEFINE ACCEPT_DEPRECATED}
  {$DEFINE ACCEPT_PLATFORM}
  {$DEFINE ACCEPT_LIBRARY}
  {$DEFINE SUPPORTS_DEPRECATED_WARNINGS}
  {$DEFINE SUPPORTS_LIBRARY_WARNINGS}
  {$DEFINE SUPPORTS_PLATFORM_WARNINGS}
  {$DEFINE SUPPORTS_CUSTOMVARIANTS}
  {$DEFINE SUPPORTS_VARARGS}
  {$DEFINE SUPPORTS_ENUMVALUE}
  {$DEFINE SUPPORTS_COMPILETIME_MESSAGES}
{$ENDIF COMPILER6_UP}

{$IFDEF COMPILER7_UP}
  {$DEFINE SUPPORTS_UNSAFE_WARNINGS}
{$ENDIF COMPILER7_UP}

{$IFDEF COMPILER9_UP}
  {$DEFINE SUPPORTS_FOR_IN}
  {$DEFINE SUPPORTS_INLINE}
  {$DEFINE SUPPORTS_NESTED_CONSTANTS}
  {$DEFINE SUPPORTS_NESTED_TYPES}
  {$IFDEF CLR}
    {$DEFINE SUPPORTS_ENHANCED_RECORDS}
    {$DEFINE SUPPORTS_CLASS_FIELDS}
    {$DEFINE SUPPORTS_CLASS_HELPERS}
    {$DEFINE SUPPORTS_CLASS_OPERATORS}
    {$DEFINE SUPPORTS_STRICT}
    {$DEFINE SUPPORTS_STATIC}
    {$DEFINE SUPPORTS_FINAL}
  {$ENDIF CLR}
{$ENDIF COMPILER9_UP}

{$IFDEF COMPILER10_UP}
  {$DEFINE SUPPORTS_ENHANCED_RECORDS}
  {$DEFINE SUPPORTS_CLASS_FIELDS}
  {$DEFINE SUPPORTS_CLASS_HELPERS}
  {$DEFINE SUPPORTS_CLASS_OPERATORS}
  {$DEFINE SUPPORTS_STRICT}
  {$DEFINE SUPPORTS_STATIC}
  {$DEFINE SUPPORTS_FINAL}
{$ENDIF COMPILER10_UP}

{$IFDEF RTL140_UP}
  {$IFDEF LINUX}
    {$DEFINE HAS_UNIT_LIBC}
  {$ENDIF LINUX}
  {$DEFINE HAS_UNIT_RTLCONSTS}
  {$DEFINE HAS_UNIT_TYPES}
  {$DEFINE HAS_UNIT_VARIANTS}
  {$DEFINE HAS_UNIT_STRUTILS}
  {$DEFINE XPLATFORM_RTL}
{$ENDIF RTL140_UP}

{------------------------------------------------------------------------------}
{ Cross-platform related defines                                               }
{------------------------------------------------------------------------------}

{$IFNDEF CPU386}
  {$DEFINE PUREPASCAL}
{$ENDIF}

{$IFDEF WIN32}
  {$DEFINE MSWINDOWS} // predefined for D6+/BCB6+
  {$DEFINE Win32API}
{$ENDIF}

{$IFDEF DELPHILANGUAGE}
  {$IFDEF LINUX}
    {$DEFINE UNIX}
  {$ENDIF}

  {$IFNDEF CONSOLE}
    {$IFDEF LINUX}
      {$DEFINE VisualCLX}
    {$ENDIF}
    {$IFNDEF VisualCLX}
      {$DEFINE VCL}
    {$ENDIF}
  {$ENDIF ~CONSOLE}
{$ENDIF DELPHILANGUAGE}

{------------------------------------------------------------------------------}
{ Compiler settings                                                            }
{------------------------------------------------------------------------------}

{$IFOPT A+} {$DEFINE ALIGN_ON} {$ENDIF}
{$IFOPT B+} {$DEFINE BOOLEVAL_ON} {$ENDIF}
{$IFDEF COMPILER2_UP}
  {$IFOPT C+} {$DEFINE ASSERTIONS_ON} {$ENDIF}
{$ENDIF}
{$IFOPT D+} {$DEFINE DEBUGINFO_ON} {$ENDIF}
{$IFOPT G+} {$DEFINE IMPORTEDDATA_ON} {$ENDIF}
{$IFDEF COMPILER2_UP}
  {$IFOPT H+} {$DEFINE LONGSTRINGS_ON} {$ENDIF}
{$ENDIF}
{ HINTS }
{$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF}
{$IFDEF COMPILER2_UP}
  {$IFOPT J+} {$DEFINE WRITEABLECONST_ON} {$ENDIF}
{$ENDIF}
{$IFOPT L+} {$DEFINE LOCALSYMBOLS} {$ENDIF}
{$IFOPT M+} {$DEFINE TYPEINFO_ON} {$ENDIF}
{$IFOPT O+} {$DEFINE OPTIMIZATION_ON} {$ENDIF}
{$IFOPT P+} {$DEFINE OPENSTRINGS_ON} {$ENDIF}
{$IFOPT Q+} {$DEFINE OVERFLOWCHECKS_ON} {$ENDIF}
{$IFOPT R+} {$DEFINE RANGECHECKS_ON} {$ENDIF}
{ REALCOMPATIBILITY }
{$IFOPT T+} {$DEFINE TYPEDADDRESS_ON} {$ENDIF}
{$IFOPT U+} {$DEFINE SAFEDIVIDE_ON} {$ENDIF}
{$IFOPT V+} {$DEFINE VARSTRINGCHECKS_ON} {$ENDIF}
{$IFOPT W+} {$DEFINE STACKFRAMES_ON} {$ENDIF}
{ WARNINGS }
{$IFOPT X+} {$DEFINE EXTENDEDSYNTAX_ON} {$ENDIF}

// for Delphi/BCB trial versions remove the point from the line below
{.$UNDEF SUPPORTS_WEAKPACKAGEUNIT}

// History:

// $Log: Jedi.inc,v $
// Revision 1.3  2005/12/30 21:29:55  clootie
// Synchronization with JEDI JCL unit (Delphi2006 additions, etc.)
//
// Revision 1.30  2005/12/04 10:10:58  obones
// Borland Developer Studio 2006 support
//
// Revision 1.29  2005/11/01 20:46:20  obones
// Removed COMPLIB_VCL and COMPLIB_VisualCLX, they are not used and obsolete
//
// Revision 1.28  2005/10/28 04:33:17  rrossmair
// - added BDS and BDSX_UP symbols
//
// Revision 1.27  2005/10/12 21:18:43  ahuser
// Moved comments out of the compiler directives.
//
// Revision 1.26  2005/09/03 15:46:42  marquardt
// new SUPPORTS_ added to description section
//
// Revision 1.25  2005/09/03 15:22:24  rrossmair
// - support for Delphi.NET personality syntax
//
// Revision 1.24  2005/08/22 01:43:02  rrossmair
// - added symbols Win32API, PUREPASCAL, DELPHI2005, DELPHI2005_UP
// - reworked/reformated some comments
//
// Revision 1.23  2005/04/15 08:27:38  marquardt
// introduced SUPPORTS_DISPID for FPC
//
// Revision 1.22  2005/04/07 00:41:35  rrossmair
// - changed for FPC 1.9.8
//
// Revision 1.21  2005/02/22 07:36:46  marquardt
// introduced SUPPORTS_INLINE, minor cleanups in JclRegistry
//
// Revision 1.20  2004/11/18 00:57:13  rrossmair
// - check-in for release 1.93
//
// Revision 1.19  2004/11/06 02:11:20  mthoma
// history cleaning.
//
// Revision 1.18  2004/08/10 02:52:02  rrossmair
// - moved {$ENDIF ~JEDI_INC} to EOF.
//
// Revision 1.17  2004/08/09 06:38:08  peter3
// - D8 support added
// - D9 support added (guesswork)
//
// Revision 1.16  2004/07/29 17:12:28  rrossmair
// fixed comment ("KYLIXX_UP from KYLIXX mappings")
//
// Revision 1.15  2004/07/29 07:58:21  marquardt
// inc files updated
//
// Revision 1.14  2004/06/21 01:10:17  rrossmair
// - $IFDEFed contents (to prevent from repeated inclusion)
// - introduced symbols SUPPORTS_DEPRECATED_WARNINGS, SUPPORTS_LIBRARY_WARNINGS, SUPPORTS_PLATFORM_WARNINGS, SUPPORTS_COMPILETIME_MESSAGES
// - reordered pre-CVS history
//
// Revision 1.13  2004/05/08 08:44:20  rrossmair
// introduced & applied symbol HAS_UNIT_LIBC
//
// Revision 1.12  2004/05/06 05:03:59  rrossmair
// SUPPORTS_ENUMVALUE definition fixed for Free Pascal Compiler
//
// Revision 1.11  2004/05/05 03:20:13  rrossmair
// jedi.inc: moved FPC-incompatible Kylix-related code to separate include file "kylix.inc", disposed of FPC-related TODOs
//
// Revision 1.10  2004/05/01 00:03:59  rrossmair
// FPC workaround removed; didn't work with Kylix
//
// Revision 1.9  2004/04/30 18:25:15  rrossmair
// added symbols BORLAND, CPPBUILDER, BCBCOMPILER
// removed symbol NONBORLAND
// cleanup (reduced redundancy)
// corrected embarrassing typo "widestring's" (for the 3rd time, I believe)
//
// Revision 1.8  2004/04/14 20:26:33  mthoma
// Changed data to date
// Local is Delphi 6 - removed todo comment
// Replaced CLX with VisualCLX to be consistent with Borlands current definition of what "CLX" is.
//
// Revision 1.7  2004/04/06 05:06:12
// add support for Kylix, FPC, RTL, versions, some speaking directives
//
// 2004-03-22,
//  - add SUPPORTS_WEAKPACKAGEUNIT
//
// 2004-03-20,
//  - add SUPPORTS_LOCAL
//
// 2004-03-18,
//  - add SUPPORTS_LONGWORD
//
// 2004-03-16,
//  - add HAS_UNIT_STRUTILS
//  - add XPLATFORM_RTL
//
// 2003-12-03,
//  - add SUPPORTS_ENUMVALUE
//
// 2003-11-14,
//  - add SUPPORTS_VARARGS
//
// 2003-10-30,
//  - correct and complete comments
//  - add Kylix definitions
//  - add RTL definitions
//  - add FPC definitions

{$ENDIF ~JEDI_INC}
