/*===========================================================================
 *
 * File:		SrAchrrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrAchrRecord class.
 *
 *=========================================================================*/
#ifndef __SRACHRRECORD_H
#define __SRACHRRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sridrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAchrRecord Definition
 *
 *=========================================================================*/
class CSrAchrRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrAchrRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pNameData;
	CSrSubrecord*		m_pXrgdData;
	CSrSubrecord*		m_pXlkrData;
	CSrSubrecord*		m_pXlcmData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pXlcnData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pXppaData;
	CSrSubrecord*		m_pXlrtData;
	CSrSubrecord*		m_pXespData;
	CSrSubrecord*		m_pXapdData;
	CSrSubrecord*		m_pPdtoData;
	CSrSubrecord*		m_pXaprData;
	CSrSubrecord*		m_pXrgbData;
	CSrSubrecord*		m_pXsclData;
	CSrSubrecord*		m_pXownData;
	CSrSubrecord*		m_pXeznData;
	CSrSubrecord*		m_pXprdData;
	CSrSubrecord*		m_pInamData;
	CSrSubrecord*		m_pXhorData;
	CSrSubrecord*		m_pXis2Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrAchrRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrAchrRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrAchrRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAchrRecord.H
 *=========================================================================*/
