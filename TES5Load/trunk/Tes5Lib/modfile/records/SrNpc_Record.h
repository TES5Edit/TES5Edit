/*===========================================================================
 *
 * File:		SrNpc_record.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrNpc_Record class.
 *
 *=========================================================================*/
#ifndef __SRNPC_RECORD_H
#define __SRNPC_RECORD_H


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
 * Begin Class CSrNpc_Record Definition
 *
 *=========================================================================*/
class CSrNpc_Record : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrNpc_Record, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pTincData;
	CSrSubrecord*		m_pSploData;
	CSrSubrecord*		m_pCsdiData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pDestData;
	CSrSubrecord*		m_pSporData;
	CSrSubrecord*		m_pAtkrData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pAcbsData;
	CSrSubrecord*		m_pTpltData;
	CSrSubrecord*		m_pSpctData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pAidtData;
	CSrSubrecord*		m_pSoftData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pNam5Data;
	CSrSubrecord*		m_pKsizData;
	CSrSubrecord*		m_pNam6Data;
	CSrSubrecord*		m_pTiasData;
	CSrSubrecord*		m_pNam7Data;
	CSrSubrecord*		m_pNam8Data;
	CSrSubrecord*		m_pPkidData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pInamData;
	CSrSubrecord*		m_pVtckData;
	CSrSubrecord*		m_pNamaData;
	CSrSubrecord*		m_pWnamData;
	CSrSubrecord*		m_pDoftData;
	CSrSubrecord*		m_pZnamData;
	CSrSubrecord*		m_pDpltData;
	CSrSubrecord*		m_pKwdaData;
	CSrSubrecord*		m_pCscrData;
	CSrSubrecord*		m_pCsdtData;
	CSrSubrecord*		m_pCoctData;
	CSrSubrecord*		m_pTiniData;
	CSrSubrecord*		m_pPrkrData;
	CSrSubrecord*		m_pCntoData;
	CSrSubrecord*		m_pPrkzData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pHclfData;
	CSrSubrecord*		m_pFtstData;
	CSrSubrecord*		m_pNam9Data;
	CSrSubrecord*		m_pTinvData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pCsdcData;
	CSrSubrecord*		m_pEcorData;
	CSrSubrecord*		m_pCrifData;
	CSrSubrecord*		m_pShrtData;
	CSrSubrecord*		m_pDstfData;
	CSrSubrecord*		m_pAtkdData;
	CSrSubrecord*		m_pAtkeData;
	CSrSubrecord*		m_pDstdData;
	CSrSubrecord*		m_pGnamData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrNpc_Record();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrNpc_Record; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrNpc_Record Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrNpc_Record.H
 *=========================================================================*/
