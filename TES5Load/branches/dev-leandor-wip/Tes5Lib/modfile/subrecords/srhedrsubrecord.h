/*===========================================================================
 *
 * File:		Srhedrsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRHEDRSUBRECORD_H
#define __SRHEDRSUBRECORD_H


/*===========================================================================
 *
 * Begin Reqiured Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Reqiured Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Special filespec values */
  //#define SRHEDR_FILETYPE_MASTER 4278230808u

	/* Standard version data */
  #define SRHEDR_VERSION_DEFAULT 0.94f

	/* HEDR data size */
  #define SRHEDR_SUBRECORD_SIZE 12

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* HEDR data structure */
  struct srhedrdata_t
  {
	float Version;
	int   RecordCount;
	dword NextObjectId;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrHedrSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrHedrSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrHedrSubrecord, CSrSubrecord)

  /*---------- Begin Private Class Members ----------------------*/
private:
  srhedrdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SRHEDR_SUBRECORD_SIZE) return File.Read(&m_Data,  SRHEDR_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SRHEDR_SUBRECORD_SIZE) return File.Write(&m_Data, SRHEDR_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrHedrSubrecord();
  virtual void Destroy (void);

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) 
  {
	CSrHedrSubrecord* pSubrecord1 = SrCastClassNull(CSrHedrSubrecord, pSubrecord);
	m_RecordSize = SRHEDR_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetHeaderData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrHedrSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrHedrSubrecord; }

	/* Get class members */
  srhedrdata_t& GetHeaderData   (void) { return (m_Data); }
  virtual byte*	GetData         (void) { return (byte *)(&m_Data); }
  int	        GetRecordCount  (void) { return (m_Data.RecordCount); }
  float			GetVersion      (void) { return (m_Data.Version); }
  dword			GetNextObjectId (void) { return (m_Data.NextObjectId); }
    
	/* Initialize a new record */
  void InitializeNew (void);

	/* Set class members */
  void SetRecordCount  (const int   Value) { m_Data.RecordCount  = Value; }
  void ModRecordCount  (const int   Value) { m_Data.RecordCount += Value; if ( m_Data.RecordCount < 0)  m_Data.RecordCount = 0; }
  void SetVersion      (const float Value) { m_Data.Version      = Value; }
  void SetNextObjectId (const dword Value) { m_Data.NextObjectId = Value; }

};
/*===========================================================================
 *		End of Class CSrHedrSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srhedrsubrecord.H
 *=========================================================================*/
