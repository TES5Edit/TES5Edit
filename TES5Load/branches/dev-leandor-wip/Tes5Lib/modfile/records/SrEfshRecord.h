/*===========================================================================
 *
 * File:		SrEfshrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrEfshRecord class.
 *
 *=========================================================================*/
#ifndef __SREFSHRECORD_H
#define __SREFSHRECORD_H


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
 * Begin Class CSrEfshRecord Definition
 *
 *=========================================================================*/
class CSrEfshRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrEfshRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pIconData;
	CSrSubrecord*		m_pIco2Data;
	CSrSubrecord*		m_pNam7Data;
	CSrSubrecord*		m_pNam8Data;
	CSrSubrecord*		m_pNam9Data;
	CSrSubrecord*		m_pDataData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrEfshRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrEfshRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrEfshRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrEfshRecord.H
 *=========================================================================*/
