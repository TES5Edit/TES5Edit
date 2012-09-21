/*===========================================================================
 *
 * File:		SrIpctrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrIpctRecord class.
 *
 *=========================================================================*/
#ifndef __SRIPCTRECORD_H
#define __SRIPCTRECORD_H


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
 * Begin Class CSrIpctRecord Definition
 *
 *=========================================================================*/
class CSrIpctRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrIpctRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pNam2Data;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pDodtData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pEnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrIpctRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrIpctRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrIpctRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrIpctRecord.H
 *=========================================================================*/
