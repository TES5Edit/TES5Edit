/*===========================================================================
 *
 * File:		SrRaceDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRRACEDATASUBRECORD_H
#define __SRRACEDATASUBRECORD_H


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

	#define SR_RACEDATA_SUBRECORD_SIZE	128

	#define SR_RACE_MAXSKILLINDEX 7

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srraceactorvalue_t
	{
			byte ActorValue;	//6-23
			byte Value;			//0-40
	};

	struct srracedata_t 
	{
		srraceactorvalue_t Skills[7];

		word	NullValue1;		//0x0000

		float	MaleHeight;		//0.65-1.9
		float	FemaleHeight;	//0.75-1.1
		float	Unknown1;		//0.5-1
		float	Unknown2;		//0.5-1
		dword	Unknown3;		//Large range of values, 2-words or 4-bytes or flags?
		float	Unknown4;		//5-1000
		float	Unknown5;		//0-200
		float	Unknown6;		//0-250
		float	Unknown7;		//150-9999
		float	Unknown8;		//0.1-7
		float	Unknown9;		//0.01-4
		float	Unknown10;		//0.01-4
		int     Unknown11;		//1-3
		int     Unknown12;		//-1 or 0
		int     Unknown13;		//-1, 0 or 1
		float   Unknown14;		//0-0.75
		int     Unknown15;		//9 or -1
		float	Unknown16;		//0-20
		float	Unknown17;		//0-15
		float	Unknown18;		//0-20
		float	Unknown19;		//1-100
		float	Unknown20;		//32-512
		int  	Unknown21;		//-1, 0 or 2
		float	Unknown22;		//0-90
		float	Unknown23;		//0 or 400
		float	Unknown24;		//0.12-1
		float	Unknown25;		//5-50
		dword	Unknown26;		//0, 1, or 2
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRaceDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrRaceDataSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrRaceDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srracedata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_RACEDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_RACEDATA_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_RACEDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_RACEDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrRaceDataSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrRaceDataSubrecord* pSubrecord1 = SrCastClassNull(CSrRaceDataSubrecord, pSubrecord);
		m_RecordSize = SR_RACEDATA_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrRaceDataSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrRaceDataSubrecord); }

		/* Get class members */
	srracedata_t&  GetRaceData  (void) { return (m_Data); }
	virtual byte*  GetData      (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) 
	{
		CSrSubrecord::InitializeNew(); 
		memset(&m_Data, 0, sizeof(m_Data)); 
		m_Data.Skills[0].ActorValue = -1;
		m_Data.Skills[1].ActorValue = -1;
		m_Data.Skills[2].ActorValue = -1;
		m_Data.Skills[3].ActorValue = -1;
		m_Data.Skills[4].ActorValue = -1;
		m_Data.Skills[5].ActorValue = -1;
		m_Data.Skills[6].ActorValue = -1;
		m_RecordSize = SR_RACEDATA_SUBRECORD_SIZE; 
	}
   
};
/*===========================================================================
 *		End of Class CSrRaceDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchDataSubrecord.H
 *=========================================================================*/
