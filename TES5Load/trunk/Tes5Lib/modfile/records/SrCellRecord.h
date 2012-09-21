/*===========================================================================
 *
 * File:		SrCellrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrCellRecord class.
 *
 *=========================================================================*/
#ifndef __SRCELLRECORD_H
#define __SRCELLRECORD_H


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
 * Begin Class CSrCellRecord Definition
 *
 *=========================================================================*/
class CSrCellRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrCellRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pXcmoData;
	CSrSubrecord*		m_pXwcnData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pXcimData;
	CSrSubrecord*		m_pXlcnData;
	CSrSubrecord*		m_pTvdtData;
	CSrSubrecord*		m_pLtmpData;
	CSrSubrecord*		m_pXclwData;
	CSrSubrecord*		m_pXclrData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pXwemData;
	CSrSubrecord*		m_pXillData;
	CSrSubrecord*		m_pXcllData;
	CSrSubrecord*		m_pXeznData;
	CSrSubrecord*		m_pXcasData;
	CSrSubrecord*		m_pXccmData;
	CSrSubrecord*		m_pXownData;
	CSrSubrecord*		m_pXcwtData;
	CSrSubrecord*		m_pMhdtData;
	CSrSubrecord*		m_pLnamData;
	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pXclcData;
	CSrSubrecord*		m_pXwcuData;
	CSrSubrecord*		m_pXwcsData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrCellRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrCellRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrCellRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCellRecord.H
 *=========================================================================*/
