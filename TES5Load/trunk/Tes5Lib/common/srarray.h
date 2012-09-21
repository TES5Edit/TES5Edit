/*===========================================================================
 *
 * File:	Srarray.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRARRAY_H
#define __SRARRAY_H


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
  #define SRARRAY_MINSIZE	32

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

  typedef  int (__stdcall *ARRAYSORTFUNC) (long lParam1, long lParam2, long lParamSort);

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class TSrArray Definition
 *
 * Description
 *
 *=========================================================================*/
template <class TObj>
class TSrArray {

  /*---------- Begin Private Class Members ----------------------*/
protected:
  TObj*		m_pRecords;
  dword		m_NumRecords;
  dword		m_NumAllocated;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Change the allocated size */
  void Resize (const dword NewSize);
  void Grow   (void);

	/* Internal sort helper */
  void Sort_Priv (int StartIndex, int EndIndex, ARRAYSORTFUNC CompareFunc, const long Data);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  TSrArray();
  TSrArray(const TSrArray<TObj>& Source);
  ~TSrArray() { Destroy(); }
  void Destroy (void);
  void Empty (void) { Destroy(); }

	/* Add new elements */
  void Add (const TObj& Record);

	/* Delete elements */
  void Delete (const dword Index);

	/* Find elements */
  int Find (const TObj& Record);

	/* Get class members */
  dword GetSize          (void) const { return (m_NumRecords); }
  dword GetAllocatedSize (void) const { return (m_NumAllocated); }

	/* Access records */
  bool  IsValidIndex (const dword Index) const { return (Index < m_NumRecords); }
  //TObj  GetAt        (const dword Index) { if (IsValidIndex(Index)) return m_pRecords[Index]; TObj Temp; return Temp; }
  TObj* GetRecords   (void)              { return (m_pRecords); }

	/* Manually set the array size */
  void SetSize (const dword NewSize) { Resize(NewSize); m_NumRecords = NewSize; }

	/* Sort records using a comparison function */
  void Sort (ARRAYSORTFUNC CompareFunc, const long Data);

	/* Operators */
  TObj& operator[] (const dword Index) { if (Index >= m_NumRecords) { throw("TSrArray::operator[] - Invalid Index!"); } return m_pRecords[Index]; }
  const TObj& operator[] (const dword Index) const { if (Index >= m_NumRecords) { throw("TSrArray::operator[] const - Invalid Index!"); } return m_pRecords[Index]; }

	/* Copy assignment */
  TSrArray<TObj>& operator= (const TSrArray<TObj>& Source);

};
/*===========================================================================
 *		End of Class TSrArray Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Constructor
 *
 *=========================================================================*/
template <class TObj>
TSrArray< TObj >::TSrArray () {
  m_NumRecords   = 0;
  m_NumAllocated = 0;
  m_pRecords     = NULL;
 }


template <class TObj>
TSrArray< TObj >::TSrArray (const TSrArray<TObj>& Source) 
{
  m_NumRecords   = 0;
  m_NumAllocated = 0;
  m_pRecords     = NULL;

  Resize(Source.GetSize());

  for (unsigned int i = 0; i < Source.GetSize(); ++i)
  {
	  m_pRecords[i] = Source.m_pRecords[i];
  }

  m_NumRecords = Source.GetSize();
}

template <class TObj>
TSrArray<TObj>& TSrArray< TObj >::operator= (const TSrArray<TObj>& Source)
{
	if (&Source == this) return *this;

	Destroy();
	Resize(Source.GetSize());

	for (unsigned int i = 0; i < Source.GetSize(); ++i)
	{
		m_pRecords[i] = Source.m_pRecords[i];
	}

	m_NumRecords = Source.GetSize();
	return *this;
}
/*===========================================================================
 *		End of Class TSrArray Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - void Destroy (void);
 *
 * Delete the object contents.
 *
 *=========================================================================*/
template <class TObj>
void TSrArray< TObj >::Destroy (void) {

  if (m_pRecords != NULL) {
    delete [] m_pRecords;
    m_pRecords = NULL;
   }
  
  m_NumRecords   = 0;
  m_NumAllocated = 0;
 }
/*===========================================================================
 *		End of Class Method TSrArray::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - void Add (Record);
 *
 * Adds a new record to the end of the array.
 *
 *=========================================================================*/
template <class TObj>
void TSrArray< TObj >::Add (const TObj& Record) {

  if (m_NumRecords >= m_NumAllocated) Grow();

  m_pRecords[m_NumRecords] = Record;
  ++m_NumRecords;
 }
/*===========================================================================
 *		End of Class Method TSrArray::Add()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - void Delete (Index);
 *
 * Deletes the specified record from the array (also deletes the object).
 *
 *=========================================================================*/
template <class TObj>
void TSrArray< TObj >::Delete (const dword Index) {

	/* Ignore invalid input */
  if (!IsValidIndex(Index)) return;

	/* Shift array to the right of deletion point */
//  memmove(m_pRecords + Index, m_pRecords + Index + 1, (m_NumRecords - Index) * sizeof(TObj));

  for (dword i = Index; i < m_NumRecords; ++i)
  {
		  m_pRecords[i] = m_pRecords[i+1];
  }
  
  --m_NumRecords;
 }
/*===========================================================================
 *		End of Class Method TSrArray::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - int Find (Record);
 *
 * Finds the location of the given record in the array. Returns -1 if
 * the record was not found.
 *
 *=========================================================================*/
template <class TObj>
int TSrArray< TObj >::Find (const TObj& Record) {
  dword Index;


  for (Index = 0; Index < m_NumRecords; ++Index) {
    if (m_pRecords[Index] == Record) return (Index);
   }

	/* Not found */
  return (-1);
 }
/*===========================================================================
 *		End of Class Method TSrArray::Add()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - void Grow (void);
 *
 * Grows the size of the array by a set amount.
 *
 *=========================================================================*/
template <class TObj>
void TSrArray< TObj >::Grow (void) { 

  if (m_NumAllocated*2 < SRARRAY_MINSIZE) {
    Resize(SRARRAY_MINSIZE);
   }
  else {
    Resize(m_NumAllocated * 2);
   }

 }
/*===========================================================================
 *		End of Class Method TSrArray< TObj >::Grow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - void Resize (NewSize);
 *
 * Protected class method to resize the number of allocated elements.
 *
 *=========================================================================*/
template <class TObj>
void TSrArray< TObj >::Resize (const dword NewSize) {
  TObj* pNewRecords;
  dword Size = NewSize;

  if (Size < SRARRAY_MINSIZE) Size = SRARRAY_MINSIZE;
  if (m_NumAllocated >= Size) return;

  pNewRecords = new TObj[Size];

  if (m_pRecords != NULL) {
    //memmove(pNewRecords, m_pRecords, sizeof(TObj)*m_NumAllocated);

	  for (dword i = 0; i < m_NumRecords; ++i)
	  {
		  pNewRecords[i] = m_pRecords[i];
	  }

	  delete [] m_pRecords;
   }

  m_NumAllocated = Size;
  m_pRecords = pNewRecords;
 }
/*===========================================================================
 *		End of Class Method TSrArray::Resize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrArray Method - void Sort (CompareFunc, Data);
 *
 *=========================================================================*/
template <class TObj>
void TSrArray< TObj >::Sort (ARRAYSORTFUNC CompareFunc, const long Data) {

  if (CompareFunc == NULL) return;

  Sort_Priv(0, m_NumRecords - 1, CompareFunc, Data);

}
/*===========================================================================
 *		End of Class Method TSrArray::Sort()
 *=========================================================================*/


//* ComCtl32 QuickSort
template <class TObj>
void TSrArray< TObj >::Sort_Priv (int StartIndex, int EndIndex, ARRAYSORTFUNC CompareFunc, const long Data) {
  int   MidIndex;
  int   Result;
  TObj  Temp;
 
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
    Result = CompareFunc((long)m_pRecords[StartIndex], (long)m_pRecords[MidIndex + 1], Data);

    if (Result > 0) {
      Temp = m_pRecords[MidIndex + 1];
      //memmove(&m_pRecords[StartIndex + 1], &m_pRecords[StartIndex], (MidIndex - StartIndex + 1)*sizeof(m_pRecords[StartIndex]));

	  for (dword i = MidIndex + 1; i > StartIndex; --i)
	  {
		  m_pRecords[i] = m_pRecords[i-1];
	  }

      m_pRecords[StartIndex] = Temp;

      ++MidIndex;
    }

    ++StartIndex;
  }

}


#endif
/*===========================================================================
 *		End of File SrArray.H
 *=========================================================================*/
