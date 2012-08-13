/*===========================================================================
 *
 * File:		SrFormIDGroup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrFormIDGroup for handling a group with a parent formID.
 *
 *=========================================================================*/
#ifndef __OBFORMIDGROUP_H
#define __OBFORMIDGROUP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srgroup.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrFormIDGroup Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrFormIDGroup : public CSrGroup
{
  DECLARE_SRCLASS(CSrFormIDGroup, CSrGroup)

  /*---------- Begin Private Class Members ----------------------*/
private:
  srformid_t m_OrigParentFormID;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFormIDGroup (const bool UseRef = false) : CSrGroup(UseRef), m_OrigParentFormID(0) { }
  //virtual ~CSrFormIDGroup() { Destroy(); }
  //virtual void Destroy (void);

	/* Attempt to add a child record */
  bool AddChildRecord (CSrBaseRecord* pNewRecord) { return (false); }
  //bool IsValidChild   (CSrBaseRecord* pNewRecord);

  	/* Change one ID for another */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) {
    dword Count = 0;
    if (m_Header.Data.ParentFormID == OldID) { m_Header.Data.ParentFormID = NewID; m_OrigParentFormID = NewID; Count = 1; }
    return (Count + CSrGroup::ChangeFormID(NewID, OldID));
  }

	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrFormIDGroup); }

  	/* Fixup the modindex of formids */
  virtual bool FixupFormids (CSrFormidFixupArray& FixupArray) {
    bool Result;
    Result  = SrFixupFormid(m_Header.Data.ParentFormID, m_OrigParentFormID, FixupArray);
    Result &= CSrGroup::FixupFormids(FixupArray);
    return (Result);
  }

	/* Get class members */
  srformid_t GetParentFormID     (void) const { return (m_Header.Data.ParentFormID); }
  srformid_t GetOrigParentFormID (void) const { return (m_OrigParentFormID); }

  	/* Initialize the record with the given header */
  virtual void Initialize (const srbaseheader_t Header) { CSrGroup::Initialize(Header); m_OrigParentFormID = m_Header.Data.ParentFormID; }
  virtual void Initialize (const int            Type)   { CSrGroup::Initialize(Type);   m_OrigParentFormID = m_Header.Data.ParentFormID; }

	/* Get class members */
  void SetParentFormID     (const srformid_t FormID) { m_Header.Data.ParentFormID = FormID; }
  void SetOrigParentFormID (const srformid_t FormID) { m_OrigParentFormID = FormID; }

};
/*===========================================================================
 *		End of Class CSrFormIDGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefGroup Definition
 *
 *=========================================================================*/
class CSrRefFormIDGroup : public CSrFormIDGroup
{

public:

  CSrRefFormIDGroup() : CSrFormIDGroup(true) { }

  	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrRefFormIDGroup); }

};
/*===========================================================================
 *		End of Class CSrRefGroup Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File SrFormIDGroup.H
 *=========================================================================*/
