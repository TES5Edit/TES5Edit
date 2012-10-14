/*===========================================================================
 *
 * File:		SrresourceScript.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	30 January 2012
 *
 * Defines the CSrResourceScript class for a single script PSC file.
 *
 *=========================================================================*/
#ifndef __SRRESOURCESCRIPT_H
#define __SRRESOURCESCRIPT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srresourcefile.h"
	#include "../scripts/SrScriptFile.h"
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
 * Begin Class CSrResourceScript Definition
 *
 *=========================================================================*/
class CSrResourceScript : public CSrResourceFile
{

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrScriptFile	m_ScriptFile;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrResourceScript() { }
	virtual ~CSrResourceScript() {  }
	virtual void Destroy (void) { m_ScriptFile.Destroy(); }

	CSrScriptFile* GetScriptFile (void) { return &m_ScriptFile; }

};
/*===========================================================================
 *		End of Class CSrResourceScript Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrResourceScript.H
 *=========================================================================*/
