/*===========================================================================
 *
 * File:		SrFlorrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrFlorRecord class.
 *
 *=========================================================================*/
#ifndef __SRFLORRECORD_H
#define __SRFLORRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrFlorRecord Definition
 *
 *=========================================================================*/
class CSrFlorRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrFlorRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pFullData;
	CSrVmadSubrecord*	m_pVmadData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pPfpcData;
	CSrSubrecord*		m_pPfigData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pModsData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFlorRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrFlorRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrFlorRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFlorRecord.H
 *=========================================================================*/
