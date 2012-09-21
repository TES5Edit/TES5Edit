/*===========================================================================
 *
 * File:		SrMgefSnddsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	20 December 2011
 *
 *=========================================================================*/
#ifndef __SRMGEFSNDDSUBRECORD_H
#define __SRMGEFSNDDSUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/

#define SR_MGEFSNDD_RECORDSIZE 8


#pragma pack(push, 1)

struct srmgefsndddata_t
{
	dword		Type;
	srformid_t  SoundID;
};

#pragma pack(pop)

typedef TSrArray<srmgefsndddata_t> CSrMgefSnddArray;


/*===========================================================================
 *
 * Begin Class CSrMgefSnddSubrecord Definition
 *
 *=========================================================================*/
class CSrMgefSnddSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrMgefSnddSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrMgefSnddArray m_Values;

  static srmgefsndddata_t s_NullSnddData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMgefSnddSubrecord();
  virtual void Destroy (void);

  	/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);

    	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord);

  virtual dword CountUses (const srformid_t FormID);

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrMgefSnddSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrMgefSnddSubrecord; }

  	/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray);

	/* Initialize a new record */
  virtual void InitializeNew (void) 
  {
	CSrSubrecord::InitializeNew();
	m_RecordSize = 0; 
  }

	/* Get class members */
  srmgefsndddata_t&  GetSnddData    (const dword Index) { return (m_Values.IsValidIndex(Index) ? m_Values[Index] : s_NullSnddData); }
  virtual byte*	     GetData        (void) { return (byte *)(m_Values.GetRecords()); }
  virtual dword	     GetRecordSize  (void) const { return (m_Values.GetSize() * SR_MGEFSNDD_RECORDSIZE); }
  CSrMgefSnddArray&  GetSnddArray   (void) { return m_Values; }
  dword              GetSoundCount  (void) { return m_Values.GetSize(); }

  	/* Set class methods */
  void SetValue (const dword Index, const dword Value, const srformid_t FormID);
  void SetSize  (const dword Size) { m_Values.SetSize(Size); }
 
};
/*===========================================================================
 *		End of Class CSrMgefSnddSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMgefSnddSubrecord.H
 *=========================================================================*/