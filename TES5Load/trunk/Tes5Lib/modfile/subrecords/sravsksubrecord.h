/*===========================================================================
 *
 * File:		SrAvskSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRAVSKSUBRECORD_H
#define __SRAVSKSUBRECORD_H


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

	#define SR_AVSK_SUBRECORD_SIZE	16

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct sravskdata_t 
	{
		float		Unknown[4];
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAvskSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrAvskSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrAvskSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sravskdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_AVSK_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_AVSK_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_AVSK_SUBRECORD_SIZE) return File.Write(&m_Data, SR_AVSK_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrAvskSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrAvskSubrecord* pSubrecord1 = SrCastClassNull(CSrAvskSubrecord, pSubrecord);
		m_RecordSize = SR_AVSK_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		return 0; 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		return 0;
	}

	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		return true;
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return (new CSrAvskSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrAvskSubrecord); }

		/* Get class members */
	sravskdata_t&  GetAvskData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_AVSK_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrAvskSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
