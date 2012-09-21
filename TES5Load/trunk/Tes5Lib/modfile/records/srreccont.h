/*===========================================================================
 *
 * File:		Srreccont.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrRecContainer used to hold a collection of records.
 *
 *=========================================================================*/
#ifndef __SRBRECCONT_H
#define __SRRECCONT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecord.h"
  #include "../../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Array of record pointers (not owned) */
  typedef CSrRefPtrArray<CSrBaseRecord> CSrRefBaseRecordArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRecContainer Definition
 *
 * Should be designed and implemented as a generic container class. The exact
 * nature of the container (array, list, map, tree, etc...) should be 
 * irrelevant and not discernable from outside the class.
 *
 * Current implementation uses a simple dynamic array.
 *
 *=========================================================================*/
class CSrRecContainer 
{

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrPtrArray<CSrRecord> m_Records;		/* Container of records */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrRecContainer();
  ~CSrRecContainer() { Destroy(); }
  void Destroy (void);

	/* Add records */
  void Add (CSrRecord* pRecord) { m_Records.Add(pRecord); }

	/* Access records */
  CSrRecord* GetRecord (const int Index) { return m_Records[Index]; }

};
/*===========================================================================
 *		End of Class CSrRecContainer Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Srreccont.H
 *=========================================================================*/
