/*===========================================================================
 *
 * File:		SrClasDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCLASDATASUBRECORD_H
#define __SRCLASDATASUBRECORD_H


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

  #define SR_CLASDATA_SUBRECORD_SIZE	36

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srclasdata_t 
	{
		word	Unknown1;		//Flags?
		short	Unknown2;		//-4 to 0
		byte	TrainerSkill;	//0-17
		byte	TrainerLevel;	//0-100
		byte	Skills[18];		//0-6, follows the regular skill indices
		float	Unknown3;		//0-0.25
		dword	Unknown4;		//0-300
		byte	Unknown5;		//1-4
		byte	Unknown6;		//0-4
		byte	Unknown7;		//0-7
		byte	Unknown8;		//0-1
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrClasDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrClasDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrClasDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srclasdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_CLASDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_CLASDATA_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_CLASDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_CLASDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrClasDataSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrClasDataSubrecord* pSubrecord1 = SrCastClassNull(CSrClasDataSubrecord, pSubrecord);
		m_RecordSize = SR_CLASDATA_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
		{
			m_Data = pSubrecord1->GetClassData();
		}
		else 
		{
			memset(&m_Data, 0, sizeof(m_Data));
		}

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrClasDataSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrClasDataSubrecord); }

		/* Get class members */
	srclasdata_t&  GetClassData (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_CLASDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrClasDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
