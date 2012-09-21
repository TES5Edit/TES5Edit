/*===========================================================================
 *
 * File:	Srptrarray.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRPTRARRAY_H
#define __SRPTRARRAY_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "stdio.h"
  #include "string.h"
  #include "srtypes.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Minimum array size */
  #define SRPTRARRAY_MINSIZE	32

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

  typedef  int (__stdcall *PTRARRAYSORTFUNC) (long lParam1, long lParam2, long lParamSort);

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrPtrArray Definition
 *
 * Description
 *
 *=========================================================================*/
template <class TObj>
class CSrPtrArray 
{

private:
  CSrPtrArray(const CSrPtrArray<TObj>& Source);
  void Copy (const CSrPtrArray<TObj>& Source) { }
  CSrPtrArray<TObj>& operator= (const CSrPtrArray<TObj>& Source);

  /*---------- Begin Private Class Members ----------------------*/
protected:
  TObj**	m_ppRecords;
  dword		m_NumRecords;
  dword		m_NumAllocated;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Change the allocated size */
  void Resize (const dword NewSize);
  void Grow   (void);

  void Sort_Priv (int StartIndex, int EndIndex, PTRARRAYSORTFUNC CompareFunc, const long Data);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrPtrArray();

  virtual   ~CSrPtrArray() { Destroy(); }
  virtual void Destroy (void);
  void         Empty   (void) { Destroy(); }

	/* Add new elements */
  void  Add    (TObj* pRecord);
  TObj* AddNew (void);

	/* Delete elements */
  virtual bool  Delete   (const dword Index);
  virtual bool  Delete   (TObj* pRecord);
  virtual TObj* Remove   (const dword Index);
  virtual TObj* Remove   (TObj* pRecord);

	/* Find elements */
  int Find (TObj* pRecord);

	/* Get class members */
  dword GetSize          (void) const { return (m_NumRecords); }
  dword GetAllocatedSize (void) const { return (m_NumAllocated); }

	/* Access records */
  bool  IsValidIndex (const dword Index) const { return (Index < m_NumRecords); }
  TObj* GetAt        (const dword Index) { return (IsValidIndex(Index) ? m_ppRecords[Index] : NULL); }

	/* Insert at a paticular position */
  int InsertBefore (const dword Index, TObj* pRecord);
  int InsertAfter  (const dword Index, TObj* pRecord);
  int InsertAfter (TObj* pRecord, TObj* pAfter, const int Offset = 0);

    void MoveToEnd (const dword Index);
	int MoveUp   (TObj* pRecord);
	int MoveDown (TObj* pRecord);

	/* Update a record */
  void SetAt (const dword Index, TObj* pRecord) { if (IsValidIndex(Index)) m_ppRecords[Index] = pRecord; }

	/* Set the minimum allocated size */
  void SetAllocatedSize (const dword Size);

	/* Sort records using a comparison function */
  void Sort (PTRARRAYSORTFUNC CompareFunc, const long Data);

	/* Operators */
  TObj* operator[] (const dword Index) { return GetAt(Index); }
  const TObj* operator[] (const dword Index) const { return (IsValidIndex(Index) ? m_ppRecords[Index] : NULL); }

};
/*===========================================================================
 *		End of Class CSrPtrArray Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefPtrArray Definition
 *
 * Does not 'own' pointers (are not deleted when the array is deleted).
 *
 *=========================================================================*/
template <class TObj>
class CSrRefPtrArray : virtual public CSrPtrArray<TObj> 
{

  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrRefPtrArray() { }
	CSrRefPtrArray(const CSrRefPtrArray<TObj>& Source);
	virtual ~CSrRefPtrArray() { Destroy(); }

	CSrRefPtrArray<TObj>& operator= (const CSrRefPtrArray<TObj>& Source);

		/* Class Constructors/Destructors */
	void Destroy (void);

	void Copy (const CSrRefPtrArray<TObj>& Source);

		/* Delete elements */
	bool Delete (const dword Index);
	bool Delete (TObj* pRecord) { return this->Delete( this->Find(pRecord)); }

	void Truncate (const dword Index);

};
/*===========================================================================
 *		End of Class CSrRefPtrArray Definition
 *=========================================================================*/



/*===========================================================================
 *
 * Class CSrPtrArray Constructor
 *
 *=========================================================================*/
template <class TObj>
CSrPtrArray< TObj >::CSrPtrArray () {
  m_NumRecords   = 0;
  m_NumAllocated = 0;
  m_ppRecords    = NULL;
 }
/*===========================================================================
 *		End of Class CSrPtrArray Constructor
 *=========================================================================*/


template <class TObj>
CSrPtrArray< TObj >::CSrPtrArray(const CSrPtrArray<TObj>& Source)
{
	m_NumRecords   = 0;
	m_NumAllocated = 0;
	m_ppRecords    = NULL;
	Copy(Source);
}


template <class TObj>
CSrPtrArray<TObj>& CSrPtrArray< TObj >::operator= (const CSrPtrArray<TObj>& Source)
{
	Destroy();
	Copy(Source);
	return *this;
}


template <class TObj>
CSrRefPtrArray< TObj >::CSrRefPtrArray(const CSrRefPtrArray<TObj>& Source)
{
	m_NumRecords   = 0;
	m_NumAllocated = 0;
	m_ppRecords    = NULL;
	Copy(Source);
}

template <class TObj>
CSrRefPtrArray<TObj>& CSrRefPtrArray< TObj >::operator= (const CSrRefPtrArray<TObj>& Source)
{
	Destroy();
	Copy(Source);
	return *this;
}


/*===========================================================================
 *
 * Class CSrPtrArray Method - void Destroy (void);
 *
 * Delete the object contents.
 *
 *=========================================================================*/
template <class TObj>
void CSrPtrArray< TObj >::Destroy (void) {
  dword Index;

  if (m_ppRecords != NULL) {
    for (Index = 0; Index < m_NumRecords; ++Index) {
      if (m_ppRecords[Index] != NULL) {
        delete m_ppRecords[Index];
        m_ppRecords[Index] = NULL;
      }
     }

    delete [] m_ppRecords;
    m_ppRecords = NULL;
   }
  
  m_NumRecords   = 0;
  m_NumAllocated = 0;
 }
/*===========================================================================
 *		End of Class Method CSrPtrArray::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefPtrArray Method - void Destroy (void);
 *
 * Delete the object contents.
 *
 *=========================================================================*/
template <class TObj>
void CSrRefPtrArray< TObj >::Destroy (void) {
  
  if ( this->m_ppRecords != NULL) {
     delete [] this->m_ppRecords;
     this->m_ppRecords = NULL;
   }
  
   this->m_NumRecords   = 0;
   this->m_NumAllocated = 0;
 }
/*===========================================================================
 *		End of Class Method CSrRefPtrArray::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - void Add (TObj* pRecord);
 *
 * Adds a new record to the end of the array.
 *
 *=========================================================================*/
template <class TObj>
void CSrPtrArray< TObj >::Add (TObj* pRecord) {

	/* Ignore NULLs */
  if (pRecord == NULL) return;

  if (m_NumRecords >= m_NumAllocated) Grow();

  m_ppRecords[m_NumRecords] = pRecord;
  ++m_NumRecords;
 }
/*===========================================================================
 *		End of Class Method CSrPtrArray::Add()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - TObj* AddNew (void);
 *
 * Creates and adds a new record to the end of the array. The new record
 * is returned.
 *
 *=========================================================================*/
template <class TObj>
TObj* CSrPtrArray< TObj >::AddNew (void) {
  TObj* pRecord;
  
  if (m_NumRecords >= m_NumAllocated) Grow();

  pRecord = new TObj;
  m_ppRecords[m_NumRecords] = pRecord;
  ++m_NumRecords;

  return (pRecord);
 }
/*===========================================================================
 *		End of Class Method CSrPtrArray::AddNew()
 *=========================================================================*/


template <class TObj>
void CSrRefPtrArray< TObj >::Copy (const CSrRefPtrArray<TObj>& Source)
{
	Destroy();
	SetAllocatedSize(Source.GetSize() + 1);

	for (dword i = 0; i < Source.GetSize(); ++i)
	{
		m_ppRecords[i] = Source.m_ppRecords[i];
		++m_NumRecords;
	}

}


/*===========================================================================
 *
 * Class CSrPtrArray Method - bool Delete (Index);
 *
 * Deletes the specified record from the array (also deletes the object).
 *
 *=========================================================================*/
template <class TObj>
bool CSrPtrArray< TObj >::Delete (const dword Index) {

	/* Ignore invalid input */
  if (!IsValidIndex(Index)) return (false);

	/* Unallocate the specified record */
  delete m_ppRecords[Index];
  m_ppRecords[Index] = NULL;

	/* Shift array to the right of deletion point */
  memmove(m_ppRecords + Index, m_ppRecords + Index + 1, (m_NumRecords - Index) * sizeof(TObj *));
  
  --m_NumRecords;
  return (true);
 }


template <class TObj>
bool CSrPtrArray< TObj >::Delete (TObj* pRecord) {
  return Delete(Find(pRecord));
}
/*===========================================================================
 *		End of Class Method CSrPtrArray::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefPtrArray Method - bool Delete (Index);
 *
 * Deletes the specified record from the array (does not delete the object).
 *
 *=========================================================================*/
template <class TObj>
bool CSrRefPtrArray< TObj >::Delete (const dword Index) {

	/* Ignore invalid input */
  if (! this->IsValidIndex(Index)) return (false);
   this->m_ppRecords[Index] = NULL;

	/* Shift array to the right of deletion point */
  memmove( this->m_ppRecords + Index,  this->m_ppRecords + Index + 1, ( this->m_NumRecords - Index) * sizeof(TObj *));
  
  -- this->m_NumRecords;

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrRefPtrArray::Delete()
 *=========================================================================*/


template <class TObj>
void CSrRefPtrArray< TObj >::Truncate (const dword Index) 
{
	if (Index >= m_NumRecords) return;
	m_NumRecords = Index;
}
  

/*===========================================================================
 *
 * Class CSrPtrArray Method - int InsertAfter (Index, pRecord);
 *
 *=========================================================================*/
template <class TObj>
int  CSrPtrArray< TObj >::InsertAfter (const dword Index, TObj* pRecord) {
  int InsertIndex = Index;

  if (m_NumRecords >= m_NumAllocated) Grow();
  
  if (InsertIndex < 0) InsertIndex = 0;
  if (InsertIndex >= (int)m_NumRecords) InsertIndex = m_NumRecords - 1;

		/* Shift records if required */
  if (InsertIndex < (int)m_NumRecords-1) {
    memmove(m_ppRecords + InsertIndex + 2, m_ppRecords + InsertIndex + 1, ( (int)m_NumRecords - InsertIndex) * sizeof(TObj *));
  }
  
  m_ppRecords[InsertIndex+1] = pRecord;
  ++m_NumRecords;

  return (InsertIndex);
}
/*===========================================================================
 *		End of Class Method CSrRefPtrArray::InsertAfter()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - int InsertAfter (pRecord, pAfter, Offset);
 *
 *=========================================================================*/
template <class TObj>
int  CSrPtrArray< TObj >::InsertAfter (TObj* pRecord, TObj* pAfter, const int Offset) {
  int InsertIndex;

  if (m_NumRecords >= m_NumAllocated) Grow();

  InsertIndex = Find(pAfter);
  if (InsertIndex < 0) InsertIndex = (int) m_NumRecords - 1;

  InsertIndex += Offset;
  if (InsertIndex < 0) InsertIndex = 0;
  if (InsertIndex > (int)m_NumRecords) InsertIndex = m_NumRecords;

	/* Shift records if required */
  if (InsertIndex < (int)m_NumRecords-1) {
    memmove(m_ppRecords + InsertIndex + 2,  m_ppRecords + InsertIndex + 1, ( (int)m_NumRecords - InsertIndex) * sizeof(TObj *));
  }
  
  m_ppRecords[InsertIndex+1] = pRecord;
  ++m_NumRecords;

  return (InsertIndex);
}
/*===========================================================================
 *		End of Class Method CSrRefPtrArray::InsertAfter()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - int InsertBefore (Index, pRecord);
 *
 *=========================================================================*/
template <class TObj>
int  CSrPtrArray< TObj >::InsertBefore (const dword Index, TObj* pRecord) {
  int InsertIndex = Index;
  
  if (m_NumRecords >= m_NumAllocated) Grow();
  
  if (InsertIndex < 0) InsertIndex = 0;
  if (InsertIndex > (int)m_NumRecords) InsertIndex = m_NumRecords;

		/* Shift records if required */
  if (InsertIndex < (int)m_NumRecords) {
    memmove(m_ppRecords + InsertIndex + 1, m_ppRecords + InsertIndex, ( (int)m_NumRecords - InsertIndex) * sizeof(TObj *));
  }
  
  m_ppRecords[InsertIndex] = pRecord;
  ++m_NumRecords;

  return (InsertIndex);
}
/*===========================================================================
 *		End of Class Method CSrRefPtrArray::InsertBefore()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - TObj* Remove (Index);
 *
 * Removes and returns the given record from the array. Returns NULL if
 * the input index is invalid.
 *
 *=========================================================================*/
template <class TObj>
TObj* CSrPtrArray< TObj >::Remove (const dword Index) {
  TObj* pRecord;

	/* Ignore invalid input */
  if (!IsValidIndex(Index)) return (NULL);

	/* Save the record to return */
  pRecord = m_ppRecords[Index];

	/* Shift array to the right of deletion point */
  memmove(m_ppRecords + Index, m_ppRecords + Index + 1, (m_NumRecords - Index) * sizeof(TObj *));
  --m_NumRecords;

  return (pRecord);
 }


template <class TObj>
TObj* CSrPtrArray< TObj >::Remove (TObj* pRecord) {
  return Remove(Find(pRecord));
}
/*===========================================================================
 *		End of Class Method CSrPtrArray::Remove()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - int Find (TObj* pRecord);
 *
 * Finds the location of the given record in the array. Returns -1 if
 * the record was not found.
 *
 *=========================================================================*/
template <class TObj>
int CSrPtrArray< TObj >::Find (TObj* pRecord) {
  dword Index;

	/* Ignore NULLs */
  if (pRecord == NULL) return (-1);

  for (Index = 0; Index < m_NumRecords; ++Index) {
    if (m_ppRecords[Index] == pRecord) return (Index);
   }

	/* Not found */
  return (-1);
 }
/*===========================================================================
 *		End of Class Method CSrPtrArray::Add()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - void Grow (void);
 *
 * Grows the size of the array by a set amount.
 *
 *=========================================================================*/
template <class TObj>
void CSrPtrArray< TObj >::Grow (void) { 

  if (m_NumAllocated*2 < SRPTRARRAY_MINSIZE) {
    Resize(SRPTRARRAY_MINSIZE);
   }
  else {
    Resize(m_NumAllocated * 3 / 2);
   }

 }
/*===========================================================================
 *		End of Class Method CSrPtrArray< TObj >::Grow()
 *=========================================================================*/


template <class TObj>
void CSrPtrArray< TObj >::MoveToEnd (const dword Index)
{
	if (Index + 1 >= m_NumRecords) return;

	TObj* pRecord = m_ppRecords[Index];

	memmove(m_ppRecords + Index, m_ppRecords + Index + 1, sizeof(m_ppRecords[0]) * (m_NumRecords - Index));
	m_ppRecords[m_NumRecords - 1] = pRecord;
}


template <class TObj>
int CSrPtrArray< TObj >::MoveUp (TObj* pRecord)
{
	int ListIndex = Find(pRecord);
	if (ListIndex <= 0) return ListIndex;
	
	TObj* pTmp  = m_ppRecords[ListIndex - 1];
	m_ppRecords[ListIndex-1] = pRecord;
	m_ppRecords[ListIndex]   = pTmp ;

	return ListIndex - 1;
}


template <class TObj>
int CSrPtrArray< TObj >::MoveDown (TObj* pRecord)
{
	int ListIndex = Find(pRecord);
	if (ListIndex < 0) return -1;
    if (ListIndex >= (int) m_NumRecords) return -1;

	TObj* pTmp = m_ppRecords[ListIndex + 1];
	m_ppRecords[ListIndex+1] = pRecord;
	m_ppRecords[ListIndex]   = pTmp ;

	return ListIndex + 1;
}


/*===========================================================================
 *
 * Class CSrPtrArray Method - void Resize (NewSize);
 *
 * Protected class method to resize the number of allocated elements.
 *
 *=========================================================================*/
template <class TObj>
void CSrPtrArray< TObj >::Resize (const dword NewSize) {
  TObj** ppNewRecords;
  dword  Size = NewSize;

  if (Size < SRPTRARRAY_MINSIZE) Size = SRPTRARRAY_MINSIZE;
  if (m_NumAllocated >= Size) return;

  ppNewRecords   = new TObj*[Size];

  if (m_ppRecords != NULL) {
    memmove(ppNewRecords, m_ppRecords, sizeof(TObj*)*m_NumAllocated);
    delete [] m_ppRecords;
   }

  m_NumAllocated = Size;
  m_ppRecords = ppNewRecords;
 }
/*===========================================================================
 *		End of Class Method CSrPtrArray::Resize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - void Sort (CompareFunc, Data);
 *
 *=========================================================================*/
template <class TObj>
void CSrPtrArray< TObj >::Sort (PTRARRAYSORTFUNC CompareFunc, const long Data) {

  if (CompareFunc == NULL) return;

  Sort_Priv(0, m_NumRecords - 1, CompareFunc, Data);

}
/*===========================================================================
 *		End of Class Method CSrPtrArray::Sort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPtrArray Method - void SetAllocatedSize (Size);
 *
 *=========================================================================*/
template <class TObj>
void CSrPtrArray< TObj >::SetAllocatedSize (const dword Size) {

  if (m_NumAllocated < Size) {
    Resize(Size);
  }

}
/*===========================================================================
 *		End of Class Method CSrPtrArray::Sort()
 *=========================================================================*/


//* ComCtl32 QuickSort
template <class TObj>
void CSrPtrArray< TObj >::Sort_Priv (int StartIndex, int EndIndex, PTRARRAYSORTFUNC CompareFunc, const long Data) {
//static VOID DPA_QuickSort (LPVOID *lpPtrs, INT l, INT r, PFNDPACOMPARE pfnCompare, LPARAM lParam)
  int   MidIndex;
  int   Result;
  TObj* pTemp;
 
  if (StartIndex < 0 || EndIndex < 0) return;	/* Empty list sort calls with a negative value */
  if (StartIndex == EndIndex) return;

  if (EndIndex < StartIndex) {
    Sort_Priv(EndIndex, StartIndex, CompareFunc, Data);
    return;
  }

  MidIndex = (StartIndex + EndIndex) / 2;
  Sort_Priv(StartIndex,   MidIndex, CompareFunc, Data);
  Sort_Priv(MidIndex + 1, EndIndex, CompareFunc, Data);
 
	/* Join the two sides */
  while( (StartIndex <= MidIndex) && (MidIndex < EndIndex) ) {
    Result = CompareFunc((long)m_ppRecords[StartIndex], (long)m_ppRecords[MidIndex + 1], Data);

    if (Result > 0) {
      pTemp = m_ppRecords[MidIndex + 1];
      memmove(&m_ppRecords[StartIndex + 1], &m_ppRecords[StartIndex], (MidIndex - StartIndex + 1)*sizeof(m_ppRecords[StartIndex]));
      m_ppRecords[StartIndex] = pTemp;

      ++MidIndex;
    }
    ++StartIndex;
  }

} //*/


/* Heap Sort

template <class TObj>
void CSrPtrArray< TObj >::Sort_Priv (const int , const int , PTRARRAYSORTFUNC CompareFunc, const long Data) {
  TObj* pTemp;
  int   StartIndex = 0;
  int   EndIndex   = m_NumRecords - 1;
  int   RootIndex, ChildIndex;
  int   Result;
  int   Remainder;

  while (StartIndex <= (int)m_NumRecords - 2) {
    ++StartIndex;
    //SiftUp(StartIndex);
    ChildIndex = StartIndex;
    
    while (ChildIndex > 0) {
      Remainder = (ChildIndex - 1) % 2;
      RootIndex = ((ChildIndex - 1) - Remainder) / 2;

      Result = CompareFunc((long)m_ppRecords[RootIndex], (long)m_ppRecords[ChildIndex], Data);
      
      if (Result < 0) {
        pTemp = m_ppRecords[RootIndex];
        m_ppRecords[RootIndex] = m_ppRecords[ChildIndex];
        m_ppRecords[ChildIndex] = pTemp;
        ChildIndex = RootIndex;
      }
      else {
        break;
      }
    }
    //SiftUp(StartIndex);
  }

  while (EndIndex > 0) {
    pTemp = m_ppRecords[EndIndex];
    m_ppRecords[EndIndex] = m_ppRecords[0];
    m_ppRecords[0] = pTemp;

    //SiftDown(0, EndIndex);
    RootIndex = 0;

    while (RootIndex * 2 + 1 < EndIndex) {
      ChildIndex = RootIndex * 2 + 1;

      if (ChildIndex < EndIndex - 1) {
        Result = CompareFunc((long)m_ppRecords[ChildIndex], (long)m_ppRecords[ChildIndex + 1], Data);
        if (Result < 0) ++ChildIndex;
      }

      Result = CompareFunc((long)m_ppRecords[RootIndex], (long)m_ppRecords[ChildIndex], Data);

      if (Result < 0) {
        pTemp = m_ppRecords[RootIndex];
        m_ppRecords[RootIndex] = m_ppRecords[ChildIndex];
        m_ppRecords[ChildIndex] = pTemp;
	RootIndex = ChildIndex;
      }
      else {
        break;
      }
    }
    //SiftDown(0, EndIndex);

    --EndIndex;
  }

}
//*/

 
/* Partitioned Quick Sort
template <class TObj>
void CSrPtrArray< TObj >::Sort_Priv (const int StartIndex, const int EndIndex, PTRARRAYSORTFUNC CompareFunc, const long Data) {

  if (EndIndex <= StartIndex) return;

  int   PivotIndex  = (EndIndex + StartIndex)/2;
  TObj* pPivot = m_ppRecords[PivotIndex];
  TObj* pTemp;

  pTemp = m_ppRecords[EndIndex];
  m_ppRecords[EndIndex]   = pPivot;
  m_ppRecords[PivotIndex] = pTemp;

  int StoreIndex = StartIndex;
  int Index;
  int Result;
  
  for (Index = StartIndex; Index < EndIndex; ++Index) {
    Result = CompareFunc((long)m_ppRecords[Index], (long)pPivot, Data);

    if (Result <= 0) {
      pTemp = m_ppRecords[StoreIndex];
      m_ppRecords[StoreIndex] = m_ppRecords[Index];
      m_ppRecords[Index]      = pTemp;
      ++StoreIndex;
    }
  }    

  pTemp = m_ppRecords[EndIndex];
  m_ppRecords[EndIndex]   = m_ppRecords[StoreIndex];
  m_ppRecords[StoreIndex] = pTemp;

  PivotIndex = StoreIndex;

  Sort_Priv(StartIndex, PivotIndex - 1, CompareFunc, Data);
  Sort_Priv(PivotIndex + 1, EndIndex, CompareFunc, Data);
}
//*/


#endif
/*===========================================================================
 *		End of File Obptrarray.H
 *=========================================================================*/
