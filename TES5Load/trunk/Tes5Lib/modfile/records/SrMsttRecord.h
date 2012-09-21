/*===========================================================================
 *
 * File:		SrMsttrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrMsttRecord class.
 *
 *=========================================================================*/
#ifndef __SRMSTTRECORD_H
#define __SRMSTTRECORD_H


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
 * Begin Class CSrMsttRecord Definition
 *
 *=========================================================================*/
class CSrMsttRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrMsttRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pModsData;
	CSrSubrecord*		m_pDestData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pDstdData;
	CSrSubrecord*		m_pDmdlData;
	CSrSubrecord*		m_pDmdtData;
	CSrSubrecord*		m_pDstfData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMsttRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrMsttRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrMsttRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMsttRecord.H
 *=========================================================================*/
