/*===========================================================================
 *
 * File:		SrSnddDatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	6 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSNDDDATASUBRECORD_H
#define __SRSNDDDATASUBRECORD_H


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

	#define SR_SNDDDATA_SUBRECORD_SIZE	36

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srsndddata_t 
	{
		dword	Unknown1;
		dword	Unknown2;
		dword	Unknown3;
		word	Unknown4;
		word	Unknown5;
		word	Unknown6;
		word	Unknown7;
		word	Unknown8;
		word	Unknown9;
		dword	Unknown10;
		dword	Unknown11;
		dword	Unknown12;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSnddDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSnddDataSubrecord : public CSrSubrecord {
	DECLARE_SRCLASS(CSrSnddDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srsndddata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SNDDDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_SNDDDATA_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_SNDDDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_SNDDDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSnddDataSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

		/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		return (0); 
	}
  
	virtual dword CountUses (const srformid_t FormID) 
	{
		return 0; 
	}

		/* Fixup the modindex of formids */
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		return true;
	}

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrSnddDataSubrecord* pSubrecord1 = SrCastClassNull(CSrSnddDataSubrecord, pSubrecord);
		m_RecordSize = SR_SNDDDATA_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL)
			m_Data = pSubrecord1->m_Data;
		else
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return new CSrSnddDataSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrSnddDataSubrecord; }

		/* Get class members */
	srsndddata_t&  GetSnddData (void) { return (m_Data); }
	virtual byte*	 GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_SNDDDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrSnddDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSnddDatasubrecord.H
 *=========================================================================*/
