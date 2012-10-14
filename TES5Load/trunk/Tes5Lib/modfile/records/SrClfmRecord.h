/*===========================================================================
 *
 * File:		SrClfmrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrClfmRecord class.
 *
 *=========================================================================*/
#ifndef __SRCLFMRECORD_H
#define __SRCLFMRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrClfmRecord Definition
 *
 *=========================================================================*/
class CSrClfmRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrClfmRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrDwordSubrecord*		m_pFnamData;
	CSrDwordSubrecord*		m_pColor;
	CSrLStringSubrecord*	m_pItemName;


	static srrgba_t	s_NullColor;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrClfmRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrClfmRecord; }

		/* Get class members */
	srrgba_t& GetColor (void) { return m_pColor ? *(srrgba_t *)m_pColor->GetData() : s_NullColor; }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_ITEMNAME(CSrClfmRecord)
	DECLARE_SRFIELD_METHODDWORD(CSrClfmRecord, m_pFnamData, Unknown1, SR_NAME_FNAM)
	DECLARE_SRFIELD_BYTE1(CSrClfmRecord, RedColor,   GetColor().R, GetColor().R)
	DECLARE_SRFIELD_BYTE1(CSrClfmRecord, GreenColor, GetColor().G, GetColor().G)
	DECLARE_SRFIELD_BYTE1(CSrClfmRecord, BlueColor,  GetColor().B, GetColor().B)

};
/*===========================================================================
 *		End of Class CSrClfmRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrClfmRecord.H
 *=========================================================================*/
