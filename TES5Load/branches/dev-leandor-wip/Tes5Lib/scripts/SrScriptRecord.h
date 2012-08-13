/*===========================================================================
 *
 * File:		SrScriptRecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	10 February 2012
 *
 * Defines the CSrScriptRecord class which is used in lists to simulate
 * a script record.
 *
 *=========================================================================*/
#ifndef __SRSCRIPTRECORD_H
#define __SRSCRIPTRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../modfile/records/srrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrScriptRecord Definition
 *
 *=========================================================================*/
class CSrScriptRecord : public CSrRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrScriptRecord, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSString	m_ScriptName;
	

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrScriptRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrScriptRecord; }

		/* Get class members */
	const char* GetScriptName (void) { return m_ScriptName; }
  
	void SetScriptName (const char* pString) { m_ScriptName = pString; }

	DECLARE_SRFIELD(FieldEditorID)
	DECLARE_SRFIELD(FieldFormID)
	DECLARE_SRFIELD(FieldRecordType)

};
/*===========================================================================
 *		End of Class CSrScriptRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrScriptRecord.H
 *=========================================================================*/
