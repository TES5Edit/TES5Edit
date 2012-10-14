/*===========================================================================
 *
 * File:		Srefitsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SREFITSUBRECORD_H
#define __SREFITSUBRECORD_H


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

	/* Standard EFIT subrecord size in bytes */
  #define SREFIT_SUBRECORD_SIZE	12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* ENIT data structure */
  struct srefitdata_t 
  {
	float	    Magnitude;
	dword	    Area;
	dword	    Duration;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEfitSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrEfitSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrEfitSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srefitdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SREFIT_SUBRECORD_SIZE) return File.Read(&m_Data,  SREFIT_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SREFIT_SUBRECORD_SIZE) return File.Write(&m_Data, SREFIT_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrEfitSubrecord();
  //virtual ~CSrEfitSubrecord() { Destroy(); }
  virtual void Destroy (void);

  	/* Compare two subrecord fields */
  virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrEfitSubrecord* pSubrecord1 = SrCastClassNull(CSrEfitSubrecord, pSubrecord);
	m_RecordSize = SREFIT_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetEffectData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}

	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrEfitSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrEfitSubrecord; }

	/* Get class members */
  srefitdata_t& GetEffectData (void) { return (m_Data); }
  virtual byte*	GetData       (void) { return (byte *)(&m_Data); }
  float         GetMagnitude  (void) { return (m_Data.Magnitude); }
  dword         GetArea       (void) { return (m_Data.Area); }
  dword         GetDuration   (void) { return (m_Data.Duration); }

  	/* Get a string representation of a subrecord field */
  bool GetField (CSString& Buffer, const int FieldID);
  
	/* Initialize a new record */
  void InitializeNew (void);

	/* Set class members */
  void SetMagnitude  (const float   Value)    { m_Data.Magnitude  = Value; }
  void SetArea       (const dword   Value)    { m_Data.Area       = Value; }
  void SetDuration   (const dword   Value)    { m_Data.Duration   = Value; }

};
/*===========================================================================
 *		End of Class CSrEfitSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srefitsubrecord.H
 *=========================================================================*/
