/*===========================================================================
 *
 * File:		SrLighdatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRLIGHDATASUBRECORD_H
#define __SRLIGHDATASUBRECORD_H


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

  #define SR_LIGHDATA_SUBRECORD_SIZE	48

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srlighdata_t 
	{
		int			Time;
		dword		Radius;
		srrgba_t	Color;
		dword		Flags;
		float		FallOff;
		float		FOV;
		float		Unknown1;
		float		Unknown2;
		float		Unknown3;
		float		Unknown4;
		dword		Value;
		float		Weight;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLighDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrLighDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrLighDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srlighdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_LIGHDATA_SUBRECORD_SIZE) return File.Read(&m_Data, SR_LIGHDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_LIGHDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_LIGHDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLighDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrLighDataSubrecord* pSubrecord1 = SrCastClassNull(CSrLighDataSubrecord, pSubrecord);
	m_RecordSize = SR_LIGHDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetLightData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrLighDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrLighDataSubrecord; }

	/* Get class members */
  srlighdata_t&  GetLightData (void) { return (m_Data); }
  virtual byte*	 GetData      (void) { return (byte *)(&m_Data); }
  
	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_LIGHDATA_SUBRECORD_SIZE; }
   
};
/*===========================================================================
 *		End of Class CSrLighDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchdatasubrecord.H
 *=========================================================================*/
