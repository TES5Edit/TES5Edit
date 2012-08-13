/*===========================================================================
 *
 * File:		SrDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRDATASUBRECORD_H
#define __SRDATASUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
   
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrDataSubrecord Definition
 *
 *=========================================================================*/
class CSrDataSubrecord : public CSrSubrecord {
  DECLARE_SRBASE(CSrDataSubrecord)
  DECLARE_SRALLOCATOR(CSrDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  byte*		m_pData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Output the raw subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrDataSubrecord();
  virtual ~CSrDataSubrecord();
  virtual void Destroy (void);

	/* Allocate a raw buffer */
  void AllocateNew (const dword Size);

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord);

  virtual CSrSubrecord* CreateV (void) { return new CSrDataSubrecord; }
  	
	/* Get class members */
  virtual byte*	GetData (void) { return (m_pData); }

  virtual void InitializeNew (void) { m_RecordSize = 0; delete m_pData; m_pData = NULL; }

	/* Set data */
  virtual void SetData (const byte* pData, const word Size);

};
/*===========================================================================
 *		End of Class CSrDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrDataSubrecord.H
 *=========================================================================*/
