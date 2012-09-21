/*===========================================================================
 *
 * File:		SrCNtoSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrCntoSubrecord used for storing a 32-bit dword.
 *
 *=========================================================================*/
#ifndef __SRCNTOSUBRECORD_H
#define __SRCNTOSUBRECORD_H


/*===========================================================================
 *
 * Begin Reqiured Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Reqiured Includes
 *=========================================================================*/


#define SR_CNTO_SUBRECORD_SIZE 8


/*===========================================================================
 *
 * Begin Class CSrCntoSubrecord Definition
 *
 *=========================================================================*/
class CSrCntoSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrCntoSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srformid_t	m_FormID;
  dword			m_Count;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { 
		bool Result; 
		SR_VERIFY_SUBRECORDSIZE_MAX(SR_CNTO_SUBRECORD_SIZE) 
		  if (m_RecordSize < SR_CNTO_SUBRECORD_SIZE)
		  {
			  struct tmp_t {
					dword formid;
					dword count;
			  };

			  tmp_t Temp;

			  Result = File.Read(&Temp, m_RecordSize);  
			  m_Count = Temp.count; 
			  m_FormID = Temp.formid;
			  
			  Result = File.ReadDWord(m_FormID);  
			  Result &= File.ReadDWord(m_Count); 
		  }
		  else
		  {		
			Result = File.ReadDWord(m_FormID);  
			Result &= File.ReadDWord(m_Count); 
		  }
		  return Result; 
		}

  virtual bool WriteData (CSrFile& File) { bool Result; SR_VERIFY_SUBRECORDSIZE_MAX(SR_CNTO_SUBRECORD_SIZE) Result = File.WriteDWord(m_FormID); Result &= File.WriteDWord(m_Count); return Result; }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrCntoSubrecord() : m_FormID(0), m_Count(0) { }
  virtual void Destroy (void) { m_FormID = m_Count = 0; CSrSubrecord::Destroy(); }

  dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);
  bool FixupFormID (CSrFormidFixupArray& FixupArray);
  bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);
  bool GetField (CSString& Buffer, const int FieldID);

  virtual dword CountUses (const srformid_t FormID) 
  {
	  if (m_FormID == FormID) return 1;
	  return 0; 
  }

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrCntoSubrecord* pSubrecord1 = SrCastClassNull(CSrCntoSubrecord, pSubrecord);
	m_RecordSize = SR_CNTO_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_FormID = pSubrecord1->m_FormID;
	  m_Count  = pSubrecord1->m_Count;
	}
	else
	{
		m_FormID = 0;
		m_Count  = 0;
	}
	
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrCntoSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrCntoSubrecord; }

	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_FormID = m_Count = 0; m_RecordSize = SR_CNTO_SUBRECORD_SIZE; }
  	  
	/* Get class members */
  srformid_t	GetFormID   (void) { return (m_FormID); }
  dword			GetCount    (void) { return (m_Count); }
  virtual byte*	GetData     (void) { return (byte *)(&m_FormID); }

  	/* Set class methods */
  void SetFormID (const srformid_t Value) { m_FormID = Value; }
  void SetCount  (const dword      Value) { m_Count = Value; }
 
};
/*===========================================================================
 *		End of Class CSrCntoSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srwordsubrec.H
 *=========================================================================*/
