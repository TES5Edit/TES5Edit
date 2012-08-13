/*===========================================================================
 *
 * File:		SrRegnrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrRegnRecord class.
 *
 *=========================================================================*/
#ifndef __SRREGNRECORD_H
#define __SRREGNRECORD_H


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
 * Begin Class CSrRegnRecord Definition
 *
 *=========================================================================*/
class CSrRegnRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrRegnRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pIconData;
	CSrSubrecord*		m_pRclrData;
	CSrSubrecord*		m_pRdwtData;
	CSrSubrecord*		m_pWnamData;
	CSrSubrecord*		m_pRpliData;
	CSrSubrecord*		m_pRdatData;
	CSrSubrecord*		m_pRpldData;
	CSrSubrecord*		m_pRdsaData;
	CSrSubrecord*		m_pRdmoData;
	CSrSubrecord*		m_pRdotData;
	CSrSubrecord*		m_pRdmpData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrRegnRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrRegnRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrRegnRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrRegnRecord.H
 *=========================================================================*/
