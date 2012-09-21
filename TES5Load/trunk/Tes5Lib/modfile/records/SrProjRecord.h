/*===========================================================================
 *
 * File:		SrProjrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrProjRecord class.
 *
 *=========================================================================*/
#ifndef __SRPROJRECORD_H
#define __SRPROJRECORD_H


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
 * Begin Class CSrProjRecord Definition
 *
 *=========================================================================*/
class CSrProjRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrProjRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*			m_pVnamData;
	CSrSubrecord*			m_pModlData;
	CSrSubrecord*			m_pObndData;
	CSrSubrecord*			m_pNam1Data;
	CSrSubrecord*			m_pModtData;
	CSrSubrecord*			m_pDataData;
	CSrSubrecord*			m_pDestData;
	CSrLStringSubrecord*	m_pItemName;
	CSrSubrecord*			m_pDstdData;
	CSrSubrecord*			m_pNam2Data;
	CSrSubrecord*			m_pDstfData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrProjRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrProjRecord; }

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Begin field method definitions */
  DECLARE_SRFIELD_ITEMNAME(CSrProjRecord)


};
/*===========================================================================
 *		End of Class CSrProjRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrProjRecord.H
 *=========================================================================*/
