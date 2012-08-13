/*===========================================================================
 *
 * File:		SrApparecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrAppaRecord class.
 *
 *=========================================================================*/
#ifndef __SRAPPARECORD_H
#define __SRAPPARECORD_H


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
 * Begin Class CSrAppaRecord Definition
 *
 *=========================================================================*/
class CSrAppaRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrAppaRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pDescData;
	CSrSubrecord*		m_pQualData;
	CSrSubrecord*		m_pDataData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrAppaRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrAppaRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrAppaRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAppaRecord.H
 *=========================================================================*/
