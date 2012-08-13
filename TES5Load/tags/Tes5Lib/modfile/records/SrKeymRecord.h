/*===========================================================================
 *
 * File:		SrKeymrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrKeymRecord class.
 *
 *=========================================================================*/
#ifndef __SRKEYMRECORD_H
#define __SRKEYMRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sritem1record.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrKeymRecord Definition
 *
 *=========================================================================*/
class CSrKeymRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrKeymRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pYnamData;
	CSrSubrecord*		m_pZnamData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pVmadData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrKeymRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrKeymRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrKeymRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrKeymRecord.H
 *=========================================================================*/
