/*===========================================================================
 *
 * File:		SrBlockGroup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrBlockGroup for handling a group with a block value.
 *
 *=========================================================================*/
#ifndef __SRBLOCKGROUP_H
#define __SRBLOCKGROUP_H


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
 * Begin Class CSrBlockGroup Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrBlockGroup : public CSrGroup
{
  DECLARE_SRCLASS(CSrBlockGroup, CSrGroup)

  /*---------- Begin Private Class Members ----------------------*/
private:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBlockGroup(const bool UseRef = false) : CSrGroup(UseRef) { }
  //virtual ~CSrBlockGroup() { Destroy(); }
  //virtual void Destroy (void);

	/* Attempt to add a child record */
  bool AddChildRecord (CSrBaseRecord* pNewRecord) { return (false); }
  //bool IsValidChild   (CSrBaseRecord* pNewRecord);

	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrBlockGroup); }

	/* Get class members */
  srformid_t GetBlock (void) const { return (m_Header.Data.Block); }

	/* Get class members */
  void SetBlock (const int Block) { m_Header.Data.Block = Block; }

};
/*===========================================================================
 *		End of Class CSrBlockGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefGroup Definition
 *
 *=========================================================================*/
class CSrRefBlockGroup : public CSrBlockGroup 
{

public:

  CSrRefBlockGroup() : CSrBlockGroup(true) { }

  	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrRefBlockGroup); }

};
/*===========================================================================
 *		End of Class CSrRefGroup Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBlockGroup.H
 *=========================================================================*/
