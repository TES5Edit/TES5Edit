/*===========================================================================
 *
 * File:		SrBaseRecCont.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrBaseRecordContBase used to handle a collection of 
 * groups and records.
 *
 *=========================================================================*/
#ifndef __SRBASERECCONT_H
#define __SRBASERECCONT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srbaserecord.h"
  #include "../../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBaseRecordContBase Definition
 *
 * Base abstract class.
 *
 *=========================================================================*/
class CSrBaseRecordContBase {

  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  //CSrBaseRecordContBase();
  //virtual ~CSrBaseRecordContBase() { Destroy(); }
  virtual void Destroy (void) = 0;

	/* Add records */
  virtual void Add         (CSrBaseRecord* pObject) = 0;
  virtual void InsertAfter (CSrBaseRecord* pObject, CSrBaseRecord* pInsert) = 0;

	/* Delete records */
  virtual bool Delete (CSrBaseRecord* pObject) = 0;

  	/* Access records */
  virtual CSrBaseRecord* GetRecord  (const int Index) = 0;
  virtual CSrBaseRecord* GetAt      (const int Index) = 0;
  virtual CSrBaseRecord* operator[] (const int Index) = 0;

  virtual dword GetSize (void) const = 0;

	/* Set a specific record */
  virtual void SetAt (const int Index, CSrBaseRecord* pObject) = 0;

	/* Set the minimum array allocated size */
  virtual void SetAllocatedSize (const int Index) = 0;

 };
/*===========================================================================
 *		End of Class CSrBaseRecordContBase Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBaseRecordCont Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrBaseRecordCont : public CSrBaseRecordContBase {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrBaseRecordArray	m_Records;		/* Container of records and groups */


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  //CSrBaseRecordCont();
  virtual ~CSrBaseRecordCont() { Destroy(); }
  virtual void Destroy (void) { m_Records.Destroy(); }

	/* Add records */
  virtual void Add (CSrBaseRecord* pObject) { m_Records.Add(pObject); }
  virtual void InsertAfter (CSrBaseRecord* pObject, CSrBaseRecord* pInsert) { m_Records.InsertAfter(pObject, pInsert); }

	/* Delete records */
  virtual bool Delete (CSrBaseRecord* pObject);

  	/* Access records */
  virtual CSrBaseRecord* GetRecord  (const int Index) { return m_Records.GetAt(Index); }
  virtual CSrBaseRecord* GetAt      (const int Index) { return m_Records.GetAt(Index); }
  virtual CSrBaseRecord* operator[] (const int Index) { return m_Records.GetAt(Index); }

  virtual dword GetSize (void) const { return (m_Records.GetSize()); }
  
	/* Set a specific record */
  virtual void SetAt (const int Index, CSrBaseRecord* pObject) { m_Records.SetAt(Index, pObject); }

	/* Set the minimum array allocated size */
  virtual void SetAllocatedSize (const int Size) { m_Records.SetAllocatedSize((dword) Size); }

 };
/*===========================================================================
 *		End of Class CSrBaseRecordCont Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefBaseRecordCont
 *
 *=========================================================================*/
class CSrRefBaseRecordCont : public CSrBaseRecordContBase {

 /*---------- Begin Private Class Members ----------------------*/
private:
  CSrRefBaseRecordArray	m_Records;		/* Container of records and groups */


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructor */
	virtual ~CSrRefBaseRecordCont() { Destroy(); }
	virtual void Destroy (void) { m_Records.Destroy(); }
  
	/* Add records */
  virtual void Add (CSrBaseRecord* pObject) { m_Records.Add(pObject); }
  virtual void InsertAfter (CSrBaseRecord* pObject, CSrBaseRecord* pInsert) { m_Records.InsertAfter(pObject, pInsert); }

	/* Delete records */
  virtual bool Delete (CSrBaseRecord* pObject);

  	/* Access records */
  virtual CSrBaseRecord* GetRecord  (const int Index) { return m_Records.GetAt(Index); }
  virtual CSrBaseRecord* GetAt      (const int Index) { return m_Records.GetAt(Index); }
  virtual CSrBaseRecord* operator[] (const int Index) { return m_Records.GetAt(Index); }

  virtual dword GetSize (void) const { return (m_Records.GetSize()); }

  	/* Set a specific record */
  virtual void SetAt (const int Index, CSrBaseRecord* pObject) { m_Records.SetAt(Index, pObject); }

	/* Set the minimum array allocated size */
  virtual void SetAllocatedSize (const int Size) { m_Records.SetAllocatedSize((dword) Size); }

};
/*===========================================================================
 *		End of Class CSrRefBaseRecordCont
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBaseRecCont.H
 *=========================================================================*/
