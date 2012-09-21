/*===========================================================================
 *
 * File:		Sringrenitsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRINGRENITSUBRECORD_H
#define __SRINGRENITSUBRECORD_H


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

		/* Standard ENIT subrecord size in bytes */
	#define SRINGRENIT_SUBRECORD_SIZE	8
	
	#define SRINGRENIT_FLAG_MANUALCALC			0x001
	#define SRINGRENIT_FLAG_FOOD				0x002
	#define SRINGRENIT_FLAG_REFERENCEPERSIST	0x100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

		/* Ingredient ENIT data structure */
	struct sringrenitdata_t 
	{
		dword		BaseCost;
		dword		Flags;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrIngrEnitSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrIngrEnitSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrIngrEnitSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	sringrenitdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SRINGRENIT_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SRINGRENIT_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrIngrEnitSubrecord() {  }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

  		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrIngrEnitSubrecord* pSubrecord1 = SrCastClassNull(CSrIngrEnitSubrecord, pSubrecord);
		m_RecordSize = SRINGRENIT_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return new CSrIngrEnitSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrIngrEnitSubrecord; }

		/* Get class members */
	sringrenitdata_t& GetIngrData			(void) { return (m_Data); }
	virtual byte*	  GetData				(void) { return (byte *)(&m_Data); }
	bool			  IsAutoCalc			(void) { return !CheckFlagBits(m_Data.Flags, SRINGRENIT_FLAG_MANUALCALC); }
	bool			  IsFood				(void) { return CheckFlagBits(m_Data.Flags, SRINGRENIT_FLAG_FOOD); }
	bool			  IsReferencePersist	(void) { return CheckFlagBits(m_Data.Flags, SRINGRENIT_FLAG_REFERENCEPERSIST); }
 	
		/* Initialize a new record */
	void InitializeNew (void)
	{
		CSrSubrecord::InitializeNew(); 
		memset(&m_Data, 0, sizeof(m_Data)); 
		m_RecordSize = SRINGRENIT_SUBRECORD_SIZE;
	}

		/* Set class members */
	void SetAutoCalc          (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRINGRENIT_FLAG_MANUALCALC, !Flag); }
	void SetFood			  (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRINGRENIT_FLAG_FOOD, Flag); }
	void SetReferencePersist  (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRINGRENIT_FLAG_REFERENCEPERSIST, Flag); }

};
/*===========================================================================
 *		End of Class CSrIngrEnitSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrIngrEnitsubrecord.H
 *=========================================================================*/
