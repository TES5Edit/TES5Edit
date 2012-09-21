/*===========================================================================
 *
 * File:		SrBoundsSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	6 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRBOUNDSSUBRECORD_H
#define __SRBOUNDSSUBRECORD_H


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

	#define SR_BOUNDS_SUBRECORD_SIZE	12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srboundsdata_t 
	{
		short	X1;
		short	Y1;
		short	Z1;
		short	X2;
		short	Y2;
		short	Z2;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBoundsSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrBoundsSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrBoundsSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srboundsdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_BOUNDS_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_BOUNDS_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_BOUNDS_SUBRECORD_SIZE) return File.Write(&m_Data, SR_BOUNDS_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrBoundsSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }  

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrBoundsSubrecord* pSubrecord1 = SrCastClassNull(CSrBoundsSubrecord, pSubrecord);
		m_RecordSize = SR_BOUNDS_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL)
			m_Data = pSubrecord1->m_Data;
		else
			memset(&m_Data, 0, sizeof(m_Data));
	
		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrBoundsSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return (new CSrBoundsSubrecord); }

		/* Get class members */
	srboundsdata_t&  GetBoundsData (void) { return (m_Data); }
	virtual byte*	   GetData       (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_BOUNDS_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrBoundsSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBoundsSubrecord.H
 *=========================================================================*/
