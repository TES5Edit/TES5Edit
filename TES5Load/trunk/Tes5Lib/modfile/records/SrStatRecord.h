/*===========================================================================
 *
 * File:		SrStatrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrStatRecord class.
 *
 *=========================================================================*/
#ifndef __SRSTATRECORD_H
#define __SRSTATRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srdnamsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrStatRecord Definition
 *
 *=========================================================================*/
class CSrStatRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrStatRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrStringSubrecord*	m_pModlData;
	CSrDnamSubrecord*	m_pDnamData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pModsData;

	static srdnamdata_t s_NullDnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrStatRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrStatRecord; }
	
		/* Get class members */
	srdnamdata_t& GetDnamData (void) { return m_pDnamData ? m_pDnamData->GetDnamData() : s_NullDnamData; }
	const char* GetMaterial (void) { return CSrRecord::GetEditorIDHelper(GetDnamData().MaterialID); }
  
		/* Initialize a new record */
	void InitializeNew (void);
	
		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	void SetMaterial (const char* pString);


		/* Begin field method definitions */
	DECLARE_SRFIELD_STRING(CSrStatRecord, m_pModlData, Model, SR_NAME_MODL)
	DECLARE_SRFIELD_FLOAT1(CSrStatRecord, Scale, GetDnamData().Scale, GetDnamData().Scale)
	DECLARE_SRFIELD_EDITORID(CSrStatRecord, Material, GetMaterial, SetMaterial)

};
/*===========================================================================
 *		End of Class CSrStatRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrStatRecord.H
 *=========================================================================*/
