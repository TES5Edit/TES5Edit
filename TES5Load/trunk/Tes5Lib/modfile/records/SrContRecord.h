/*===========================================================================
 *
 * File:		SrContrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrContRecord class.
 *
 *=========================================================================*/
#ifndef __SRCONTRECORD_H
#define __SRCONTRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srcontdatasubrecord.h"
	#include "../subrecords/srdwordsubrecord.h"
	#include "../subrecords/srcntosubrecord.h"
	#include "../subrecords/srcoedsubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


	#define SR_CNTO_MAXCOUNT 1000000		//Arbitrary limit for sanity


/*===========================================================================
 *
 * Begin Class CSrContRecord Definition
 *
 *=========================================================================*/
class CSrContRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrContRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrStringSubrecord*		m_pModel;
	CSrSubrecord*			m_pObndData;
	CSrLStringSubrecord*	m_pItemName;
	CSrSubrecord*			m_pModtData;
	CSrDwordSubrecord*		m_pItemCount;
	CSrContDataSubrecord*	m_pContData;
	CSrFormidSubrecord*		m_pOpenSound;
	CSrFormidSubrecord*		m_pCloseSound;
	CSrSubrecord*			m_pCoedData;
	CSrSubrecord*			m_pModsData;
	CSrVmadSubrecord*		m_pVmadData;

	static srcontdata_t		s_NullContData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	void SetItemCount (const dword Value);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrContRecord();
  virtual void Destroy (void);

  CSrCntoSubrecord* AddItem (const srformid_t FormID, const dword Count);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrContRecord; }

  bool DeleteItem (CSrCntoSubrecord* pItem);

		/* Get class members */
  srcontdata_t& GetContData  (void) { return m_pContData ? m_pContData->GetContData() : s_NullContData; }
  dword         GetItemCount (void) { return CountSubrecords(SR_NAME_CNTO); }
  const char*   GetContainerType (void) { return GetSrContainerTypeString(GetContData().Type); }

  CSrCntoSubrecord* GetFirstItem (int& Position);
  CSrCntoSubrecord* GetNextItem  (int& Position);  
  void UpdateItemCount (void);

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

  void SetContainerType (const char* pString) { GetSrContainerTypeValue(GetContData().Type, pString); }


		/* Begin field method definitions */
	DECLARE_SRFIELD_MODEL(CSrContRecord, SR_NAME_MODL)
	DECLARE_SRFIELD_ITEMNAME(CSrContRecord)
	DECLARE_SRFIELD_METHOD(CSrContRecord, Type, GetContainerType, SetContainerType)
	DECLARE_SRFIELD_DWORD1(CSrContRecord, ItemCount, GetItemCount(), dword Tmp)

	DECLARE_SRFIELD_EDITORID(CSrContRecord, OpenSound, GetOpenSound, SetOpenSound)
	DECLARE_SRMETHOD_FORMID(OpenSound, m_pOpenSound, SR_NAME_QNAM)

	DECLARE_SRFIELD_EDITORID(CSrContRecord, CloseSound, GetCloseSound, SetCloseSound)
	DECLARE_SRMETHOD_FORMID(CloseSound, m_pCloseSound, SR_NAME_SNAM)


};
/*===========================================================================
 *		End of Class CSrContRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrContRecord.H
 *=========================================================================*/
