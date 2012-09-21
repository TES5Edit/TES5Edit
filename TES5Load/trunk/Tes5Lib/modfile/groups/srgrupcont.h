/*===========================================================================
 *
 * File:		Srgrupcont.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrGrupContainer used to handle a collection of group 
 * records.
 *
 *=========================================================================*/
#ifndef __OBGRUPCONT_H
#define __OBGRUPCONT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srgroup.h"
  #include "../../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrGrupContainer Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrGrupContainer {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrPtrArray<CSrGroup> m_Groups;		/* Container of groups */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrGrupContainer();
  ~CSrGrupContainer() { Destroy(); }
  void Destroy (void);

	/* Add records */
  void Add (CSrGroup* pGroup) { m_Groups.Add(pGroup); }

	/* Access records */
  CSrGroup* GetRecord (const int Index) { return m_Groups[Index]; }

 };
/*===========================================================================
 *		End of Class CSrGrupContainer Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Srgrupcont.H
 *=========================================================================*/
