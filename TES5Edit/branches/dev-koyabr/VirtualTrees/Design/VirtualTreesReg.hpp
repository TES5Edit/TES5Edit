// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Virtualtreesreg.pas' rev: 11.00

#ifndef VirtualtreesregHPP
#define VirtualtreesregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Vcleditors.hpp>	// Pascal unit
#include <Propertycategories.hpp>	// Pascal unit
#include <Colnedit.hpp>	// Pascal unit
#include <Virtualtrees.hpp>	// Pascal unit
#include <Vtheaderpopup.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Virtualtreesreg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TVirtualTreeEditor;
class PASCALIMPLEMENTATION TVirtualTreeEditor : public Designeditors::TDefaultEditor 
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TVirtualTreeEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TVirtualTreeEditor(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Virtualtreesreg */
using namespace Virtualtreesreg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Virtualtreesreg
