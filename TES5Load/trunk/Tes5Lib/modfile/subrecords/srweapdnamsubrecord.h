/*===========================================================================
 *
 * File:		SrWeapDnamSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	21 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRWEAPDNAMSUBRECORD_H
#define __SRWEAPDNAMSUBRECORD_H


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

  #define SR_WEAPDNAM_SUBRECORD_SIZE	100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srweapdnamdata_t 
	{
		int			WeaponType;
		float		Unknown2;
		float		Unknown3;
		word		Unknown4;
		word		Padding0;
		float		Unknown5;
		dword		Padding1;
		srformid_t	ReferenceID;
		float		Unknown6;
		float		Unknown7;
		dword		Padding2;
		dword		UnknownFlags1;
		float		Padding3;
		float		Unknown8;
		float		Unknown9;
		float		Unknown10;
		float		Unknown11;
		dword		Padding4;
		dword		Padding5;
		dword		Padding6;
		dword		Unknown12;
		dword		Padding7;
		dword		Padding8;
		int			Padding9;
		dword		Padding10;
		float		Unknown13;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrWeapDnamSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrWeapDnamSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrWeapDnamSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srweapdnamdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { if (m_RecordSize != SR_WEAPDNAM_SUBRECORD_SIZE) return false; return File.Read(&m_Data,  SR_WEAPDNAM_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { if (m_RecordSize != SR_WEAPDNAM_SUBRECORD_SIZE) return false; return File.Write(&m_Data, SR_WEAPDNAM_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrWeapDnamSubrecord() : m_Data() 
	{
		m_Data.Padding0 = 145;
		m_Data.Padding2 = 1;
		m_Data.Padding9 = -1;
		m_Data.ReferenceID = 0x0001ff00;
	}

  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrWeapDnamSubrecord* pSubrecord1 = SrCastClassNull(CSrWeapDnamSubrecord, pSubrecord);
	m_RecordSize = SR_WEAPDNAM_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetDnamData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrWeapDnamSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return (new CSrWeapDnamSubrecord); }

	/* Get class members */
  srweapdnamdata_t& GetDnamData   (void) { return (m_Data); }
  virtual byte*	    GetData       (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_WEAPDNAM_SUBRECORD_SIZE; }
     
};
/*===========================================================================
 *		End of Class CSrWeapDnamSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCrdtsubrecord.H
 *=========================================================================*/
