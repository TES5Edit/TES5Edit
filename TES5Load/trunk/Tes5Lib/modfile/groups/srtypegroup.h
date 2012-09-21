/*===========================================================================
 *
 * File:		Srtypegroup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrTypeGroup for handling type groups.
 *
 *=========================================================================*/
#ifndef __SRTYPEGROUP_H
#define __SRTYPEGROUP_H


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
 * Begin Class CSrTypeGroup Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrTypeGroup : public CSrGroup {
  DECLARE_SRCLASS(CSrTypeGroup, CSrGroup)

  /*---------- Begin Private Class Members ----------------------*/
private:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrTypeGroup(const bool UseRef = false) : CSrGroup(UseRef) { }
  //virtual ~CSrTypeGroup() { Destroy(); }
  //virtual void Destroy (void);

	/* Attempt to add a child record */
  bool AddChildRecord (CSrBaseRecord* pNewRecord);
  //bool IsValidChild   (CSrBaseRecord* pNewRecord);

	/* Delete a child record */
  bool DeleteChildRecord (CSrBaseRecord* pRecord);

	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrTypeGroup); }

	/* Get class members */
  const srrectype_t GetContainsType (void) const { return (m_Header.Data.ContainsType); }

	/* Get class members */
  void SetContainsType (const srrectype_t Type) { memcpy(m_Header.Data.ContainsType, Type.Name, SR_RECTYPE_SIZE); }

};
/*===========================================================================
 *		End of Class CSrTypeGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefTypeGroup Definition
 *
 *=========================================================================*/
class CSrRefTypeGroup : public CSrTypeGroup 
{

public:

  CSrRefTypeGroup() : CSrTypeGroup(true) { }

  	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrRefTypeGroup); }

  
};
/*===========================================================================
 *		End of Class CSrRefTypeGroup Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srtypegroup.H
 *=========================================================================*/
