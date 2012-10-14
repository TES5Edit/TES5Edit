/*===========================================================================
 *
 * File:		SrCamsDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	6 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCAMSDATASUBRECORD_H
#define __SRCAMSDATASUBRECORD_H


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

	#define SR_CAMSDATA_SUBRECORD_SIZE	40

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srcamsdata_t 
	{
		dword	Unknown1;
		dword	Unknown2;
		dword	Unknown3;
		dword	Unknown4;
		float	x1;
		float	y1;
		float	z1;
		float	x2;
		float	y2;
		float	z2;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCamsDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrCamsDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrCamsDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srcamsdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_CAMSDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_CAMSDATA_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_CAMSDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_CAMSDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrCamsDataSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

    	/* Change any matching formid in the subrecord */
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


 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrCamsDataSubrecord* pSubrecord1 = SrCastClassNull(CSrCamsDataSubrecord, pSubrecord);
		m_RecordSize = SR_CAMSDATA_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->GetCamsData();
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrCamsDataSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrCamsDataSubrecord); }

		/* Get class members */
	srcamsdata_t&  GetCamsData (void) { return (m_Data); }
	virtual byte*	 GetData     (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_CAMSDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrCamsDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCamsDataSubrecord.H
 *=========================================================================*/
