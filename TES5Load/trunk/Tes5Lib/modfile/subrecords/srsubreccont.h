/*===========================================================================
 *
 * File:		SrSubreccont.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrSubRecContainer used to hold a collection of records.
 *
 *=========================================================================*/
#ifndef __SRSUBRECCONT_H
#define __SRSUBRECCONT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
  #include "../../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSubRecContainer Definition
 *
 * Should be designed and implemented as a generic container class. The exact
 * nature of the container (array, list, map, tree, etc...) should be 
 * irrelevant and not discernable from outside the class.
 *
 * Current implementation uses a simple dynamic array.
 *
 *=========================================================================*/
class CSrSubRecContainer {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrSubrecordArray m_Subrecords;		/* Container of subrecords */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSubRecContainer();
  ~CSrSubRecContainer() { Destroy(); }
  void Destroy (void);

	/* Add records */
  void Add (CSrSubrecord* pRecord) { m_Subrecords.Add(pRecord); }

	/* Delete records */
  void Delete (const dword       Index) { m_Subrecords.Delete(Index); }
  void Delete (const srrectype_t Type);

	/* Find the specified record in the container */
  int Find (CSrSubrecord* pRecord) { return m_Subrecords.Find(pRecord); }

	/* Insert in a certain position */
  int InsertAfter (CSrSubrecord* pSubrecord, CSrSubrecord* pAfter, const int Offset) { return m_Subrecords.InsertAfter(pSubrecord, pAfter, Offset); }

  	/* Access records */
  CSrSubrecord* GetRecord  (const dword Index) { return m_Subrecords[Index]; }
  CSrSubrecord* operator[] (const dword Index) { return m_Subrecords[Index]; }

  dword GetSize (void) const { return (m_Subrecords.GetSize()); }

 };
/*===========================================================================
 *		End of Class CSrSubRecContainer Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSubreccont.H
 *=========================================================================*/
