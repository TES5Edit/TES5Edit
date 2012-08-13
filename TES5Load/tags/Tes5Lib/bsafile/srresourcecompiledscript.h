/*===========================================================================
 *
 * File:		SrResourceCompiledScript.h
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	30 January 2012
 *
 * Defines the CSrResourceCompiledScript class for a single compiled
 * script PEX file.
 *
 *=========================================================================*/
#ifndef __SRRESOURCECOMPILEDSCRIPT_H
#define __SRRESOURCECOMPILEDSCRIPT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srresourcefile.h"
	#include "../scripts/SrScriptFile.h"
	#include "common/srutils.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrResourceCompiledScript Definition
 *
 *=========================================================================*/
class CSrResourceCompiledScript : public CSrResourceFile
{

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srscriptinfo_t		m_ScriptInfo;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrResourceCompiledScript() { }
	virtual ~CSrResourceCompiledScript() {  }
	virtual void Destroy (void) {  }

	srscriptinfo_t* GetScriptInfo (void) { return &m_ScriptInfo; }

	bool InitScriptInfo (void)
	{
		CSString FullName = GetFullName();
		CSString Filename;
		CSString SrcFilename;

		m_ScriptInfo.Name = GetName();
		m_ScriptInfo.Name.TruncateAtR('.');

		GetSrInstallPath(Filename);
		SrcFilename = Filename;
		Filename += "data\\";
		Filename += FullName;

		/* TODO: Load compiled script */

		SrcFilename += "data\\scripts\\source\\";
		SrcFilename += m_ScriptInfo.Name;
		SrcFilename += ".psc";

		m_ScriptInfo.HasSource = FileExists(SrcFilename);
		return true;
	}

};
/*===========================================================================
 *		End of Class CSrResourceCompiledScript Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrResourceCompiledScript.H
 *=========================================================================*/
