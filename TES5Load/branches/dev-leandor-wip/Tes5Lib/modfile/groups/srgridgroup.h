/*===========================================================================
 *
 * File:		SrGridGroup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrGridGroup for handling type groups.
 *
 *=========================================================================*/
#ifndef __SRGRIDGROUP_H
#define __SRGRIDGROUP_H


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
 * Begin Class CSrGridGroup Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrGridGroup : public CSrGroup
{
  DECLARE_SRCLASS(CSrGridGroup, CSrGroup)

  /*---------- Begin Private Class Members ----------------------*/
private:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrGridGroup(const bool UseRef = false) : CSrGroup(UseRef) { }
  //virtual ~CSrGridGroup() { Destroy(); }
  //virtual void Destroy (void);

	/* Attempt to add a child record */
  bool AddChildRecord (CSrBaseRecord* pNewRecord) { return (false); }
  //bool IsValidChild   (CSrBaseRecord* pNewRecord);

	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrGridGroup); }

	/* Get class members */
  int GetGridX (void) const { return (m_Header.Data.XGrid); }
  int GetGridY (void) const { return (m_Header.Data.YGrid); }

	/* Get class members */
  void SetGridX (const int X) { m_Header.Data.XGrid = X; }
  void SetGridY (const int Y) { m_Header.Data.YGrid = Y; }
  void SetGrid  (const int X, const int Y) { m_Header.Data.XGrid = X; m_Header.Data.XGrid = Y; }

};
/*===========================================================================
 *		End of Class CSrGridGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefGroup Definition
 *
 *=========================================================================*/
class CSrRefGridGroup : public CSrGridGroup
{

public:

  CSrRefGridGroup() : CSrGridGroup(true) { }

  	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrRefGridGroup); }

};
/*===========================================================================
 *		End of Class CSrRefGroup Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrGridGroup.H
 *=========================================================================*/
