/*===========================================================================
 *
 * File:		SrCamsrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrCamsRecord class.
 *
 *=========================================================================*/
#ifndef __SRCAMSRECORD_H
#define __SRCAMSRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srcamsdatasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCamsRecord Definition
 *
 *=========================================================================*/
class CSrCamsRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrCamsRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrStringSubrecord*		m_pModel;
	CSrSubrecord*			m_pModtData;
	CSrCamsDataSubrecord*	m_pCamsData;
	CSrFormidSubrecord*		m_pImageSpace;

	static srcamsdata_t s_NullCamsData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrCamsRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrCamsRecord; }

		/* Get class members */
	srcamsdata_t& GetCamsData (void) { return m_pCamsData ? m_pCamsData->GetCamsData() : s_NullCamsData; }  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_EDITORID1(CSrCamsRecord, ImageSpace, SR_NAME_MNAM)
	DECLARE_SRFIELD_MODEL(CSrCamsRecord, SR_NAME_MODL)

	DECLARE_SRFIELD_DWORD1(CSrCamsRecord, Unknown1, GetCamsData().Unknown1, GetCamsData().Unknown1)
	DECLARE_SRFIELD_DWORD1(CSrCamsRecord, Unknown2, GetCamsData().Unknown2, GetCamsData().Unknown2)
	DECLARE_SRFIELD_DWORD1(CSrCamsRecord, Unknown3, GetCamsData().Unknown3, GetCamsData().Unknown3)
	DECLARE_SRFIELD_DWORD1(CSrCamsRecord, Unknown4, GetCamsData().Unknown4, GetCamsData().Unknown4)
	DECLARE_SRFIELD_FLOAT1(CSrCamsRecord, X1, GetCamsData().x1, GetCamsData().x1)
	DECLARE_SRFIELD_FLOAT1(CSrCamsRecord, Y1, GetCamsData().y1, GetCamsData().y1)
	DECLARE_SRFIELD_FLOAT1(CSrCamsRecord, Z1, GetCamsData().z1, GetCamsData().z1)
	DECLARE_SRFIELD_FLOAT1(CSrCamsRecord, X2, GetCamsData().x2, GetCamsData().x2)
	DECLARE_SRFIELD_FLOAT1(CSrCamsRecord, Y2, GetCamsData().y2, GetCamsData().y2)
	DECLARE_SRFIELD_FLOAT1(CSrCamsRecord, Z2, GetCamsData().z2, GetCamsData().z2)

};
/*===========================================================================
 *		End of Class CSrCamsRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCamsRecord.H
 *=========================================================================*/
