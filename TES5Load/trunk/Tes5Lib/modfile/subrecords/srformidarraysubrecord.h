/*===========================================================================
 *
 * File:		SrFormidArraysubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	27 November 2011
 *
 * Defines the CSrFormidArraySubrecord used for storing an array of formids.
 *
 *=========================================================================*/
#ifndef __OBFORMIDARRAYSUBRECORD_H
#define __OBFORMIDARRAYSUBRECORD_H


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
 * Begin Class CSrFormidArraySubrecord Definition
 *
 *=========================================================================*/
class CSrFormidArraySubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrFormidArraySubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrFormidArray m_Values;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFormidArraySubrecord();
  virtual void Destroy (void);

  	/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);

    	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord);

  virtual dword CountUses (const srformid_t FormID);

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrFormidArraySubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrFormidArraySubrecord; }

  	/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray);

  void ForceArraySize (const dword Size)
  {
	  m_Values.SetSize(Size);
  }

	/* Initialize a new record */
  virtual void InitializeNew (void) { 
	CSrSubrecord::InitializeNew();
	m_RecordSize = 0; 
  }

	/* Get class members */
  srformid_t      GetFormID      (const dword Index) { return (m_Values.IsValidIndex(Index) ? m_Values[Index] : SR_FORMID_NULL); }
  virtual byte*	  GetData        (void) { return (byte *)(m_Values.GetRecords()); }
  virtual dword	  GetRecordSize  (void) const { return m_Values.GetSize() * sizeof(srformid_t); }
          dword	  GetArraySize   (void) const { return m_Values.GetSize(); }
  CSrFormidArray& GetFormIDArray (void) { return m_Values; }

  	/* Set class methods */
  void SetValue (const dword Index, const srformid_t Value) { m_Values[Index] = Value; }
  void SetSize  (const dword Size) { m_Values.SetSize(Size); }
 
};
/*===========================================================================
 *		End of Class CSrFormidArraySubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFormidArraySubrecord.H
 *=========================================================================*/