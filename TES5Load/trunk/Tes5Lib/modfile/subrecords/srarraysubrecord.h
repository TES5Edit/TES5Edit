/*===========================================================================
 *
 * File:		SrArraySubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 January 2012
 *
 * WARNING: Untesting/trial code
 *
 * Defines a custom subrecord which holds an array of other subrecords.
 * Be careful if using this inside records as some methods may not expect
 * a nested subrecord structure.
 *
 *=========================================================================*/
#ifndef __SRARRAYSUBRECORD_H
#define __SRARRAYSUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
	#include "srsubreccont.h"
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
#pragma pack(push, 1)
#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrArraySubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrArraySubrecord : public CSrSubrecord {
	DECLARE_SRCLASS(CSrArraySubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubRecContainer	m_Subrecords;
	byte*				m_pRawData;
	dword				m_RawDataSize;
	


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File);
	virtual bool WriteData (CSrFile& File) { return false; }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrArraySubrecord();
	virtual void Destroy (void);

	void Add (CSrSubrecord* pSubrecord) { m_Subrecords.Add(pSubrecord); }

	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);
	virtual dword CountUses (const srformid_t FormID);
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray);

	virtual bool Copy (CSrSubrecord* pSource);
	
	static CSrSubrecord* Create (void) { return new CSrArraySubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrArraySubrecord; }

	virtual byte* GetData (void);
	virtual dword GetRecordSize (void) const;
  
	void InitializeNew (void);

	virtual bool Write (CSrFile& File);
   
};
/*===========================================================================
 *		End of Class CSrArraySubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPrkeSubrecord.H
 *=========================================================================*/
