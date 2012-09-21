/*===========================================================================
 *
 * File:		SrLvloSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRLVLOSUBRECORD_H
#define __SRLVLOSUBRECORD_H


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

	#define SR_LVLO_SUBRECORD_SIZE	12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srlvlodata_t 
  {
	dword		Level;
	srformid_t	FormID;
	dword		Count;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLvloSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrLvloSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrLvloSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srlvlodata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_LVLO_SUBRECORD_SIZE)  return File.Read(&m_Data,  SR_LVLO_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_LVLO_SUBRECORD_SIZE)  return File.Write(&m_Data, SR_LVLO_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
	CSrLvloSubrecord() {  }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

			/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
  {
	if (m_Data.FormID == OldID) 
	{
	  m_Data.FormID = NewID;
	  return (1);
	}

	return (0); 
  }

  virtual dword CountUses (const srformid_t FormID) 
  {
	  if (FormID == m_Data.FormID) return 1;
	  return 0; 
  }

		/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
  {
	return SrFixupFormid(m_Data.FormID, m_Data.FormID, FixupArray);
  }

  	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrLvloSubrecord* pSubrecord1 = SrCastClassNull(CSrLvloSubrecord, pSubrecord);
	m_RecordSize = SR_LVLO_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) 
	{
	  m_Data = pSubrecord1->GetListData();
	}
	else 
	{
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrLvloSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return (new CSrLvloSubrecord); }

	/* Get class members */
  srlvlodata_t&		GetListData	(void) { return (m_Data); }
  virtual byte*	    GetData		(void) { return (byte *)(&m_Data); }
  dword				GetLevel	(void) { return m_Data.Level; }
  srformid_t		GetFormID	(void) { return m_Data.FormID; }
  dword				GetCount	(void) { return m_Data.Count; }
   	
	/* Initialize a new record */
  void InitializeNew (void)
  {
	  CSrSubrecord::InitializeNew(); 
	  memset(&m_Data, 0, sizeof(m_Data)); 
	  m_RecordSize = SR_LVLO_SUBRECORD_SIZE;
  }

	/* Set class members */
  void SetCount  (const dword Value) { m_Data.Count = Value; }
  void SetLevel  (const dword Value) { m_Data.Level = Value; }
  void SetFormID (const dword Value) { m_Data.FormID = Value; }
  

};
/*===========================================================================
 *		End of Class CSrLvloSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrEnitAlchsubrecord.H
 *=========================================================================*/
