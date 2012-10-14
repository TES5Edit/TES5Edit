/*===========================================================================
 *
 * File:		SrFileGroup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrFileGroup for handling top level records/groups in 
 * a ESP/ESM file.
 *
 *=========================================================================*/
#ifndef __OBFILEGROUP_H
#define __OBFILEGROUP_H


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
 * Begin Class CSrFileGroup Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrFileGroup : public CSrGroup 
{

  /*---------- Begin Private Class Members ----------------------*/
private:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrFileGroup(const bool UseRef = false) : CSrGroup(UseRef) { m_Header.GroupType = SR_GROUP_NONE; }
  
		/* Return a new class instance */
	static CSrGroup* Create (void) { return (new CSrFileGroup); }

		/* Override to just output records with no group header */
	virtual bool Write (CSrFile& File, CSrCallback* pCallback);

};
/*===========================================================================
 *		End of Class CSrFileGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefGroup Definition
 *
 *=========================================================================*/
class CSrRefFileGroup : public CSrFileGroup {

public:

  CSrRefFileGroup() : CSrFileGroup(true) { }

  	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrRefFileGroup); }

};
/*===========================================================================
 *		End of Class CSrRefGroup Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFileGroup.H
 *=========================================================================*/
