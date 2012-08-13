/*===========================================================================
 *
 * File:	Srsimplemap.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSIMPLEMAP_H
#define __SRSIMPLEMAP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "common/srtypes.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/



/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default size of the hash map tables */
  #define SR_SIMPLEMAP_DEFAULTSIZE 1009


/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSimpleMap Definition
 *
 * Template class from which simple hash-map implementations can be 
 * created from. 
 *
 *=========================================================================*/
template<class TKey>
class CSrSimpleMap {

	/* Private structure used as a linked list for each unique hash value */
  struct CSrSimpleMapAssoc {
	CSrSimpleMapAssoc* pNext;
	dword		   HashValue;
	TKey               Value;
   };

  /*---------- Begin Protected Class Members --------------------*/
protected:

  CSrSimpleMapAssoc**	m_ppHashTable;		/* Array of hash records */
  dword			m_RecordCount;
  dword			m_HashTableSize;
  


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Compare two keys */
  virtual bool CompareKeys (const TKey Key1, const TKey Key2);

	/* Helper find method */
  virtual CSrSimpleMapAssoc* GetAssocNode (const TKey Key, dword& Hash);

	/* Create a new node */
  virtual CSrSimpleMapAssoc* NewAssocNode (void);

	
  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSimpleMap();
  virtual ~CSrSimpleMap() { Destroy(); }
  virtual void Destroy (void) { RemoveAll(); }

	/* Delete a specified key */
  void Delete (const TKey Key);

	/* Get class members */
  virtual dword GetRecordCount (void) { return (m_RecordCount); }

	/* Hash a key value */
  virtual dword HashKey (const TKey Key);

	/* Initialize the hash table to a specific size */
  virtual void InitHashTable (const dword Size);
	
	/* Find an existing value by its key */
  virtual bool Lookup (const TKey TempKey, TKey*& pKey);

	/* Delete all hash table entries */
  virtual void RemoveAll (void);

	/* Set a value */
  virtual void SetAt (const TKey Key);

 };
/*===========================================================================
 *		End of Class CSrSimpleMap Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Constructor
 *
 *=========================================================================*/
template<class TKey>
CSrSimpleMap<TKey>::CSrSimpleMap () {
  m_ppHashTable   = NULL;
  m_RecordCount   = 0;
  m_HashTableSize = SR_SIMPLEMAP_DEFAULTSIZE;
 }
/*===========================================================================
 *		End of Class CSrSimpleMap Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - bool CompareKeys (Key1, Key2);
 *
 *=========================================================================*/
template<class TKey>
inline bool CSrSimpleMap<TKey>::CompareKeys (const TKey Key1, const TKey Key2) {
  return (Key1 == Key2);
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::CompareKeys()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - void Delete (Key);
 *
 *=========================================================================*/
template<class TKey>
void CSrSimpleMap<TKey>::Delete (const TKey Key) {
  CSrSimpleMapAssoc*	pAssoc;
  CSrSimpleMapAssoc*	pLastAssoc = NULL;
  dword			Hash;

	/* Ignore if no table defined */
  Hash = HashKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return;
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {

    if (CompareKeys(pAssoc->Value, Key)) {

      if (pLastAssoc == NULL)
        m_ppHashTable[Hash] = pAssoc->pNext;
      else
        pLastAssoc->pNext = pAssoc->pNext;

      delete pAssoc;
      return;
     }

    pLastAssoc = pAssoc;
   }

 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - CSrSimpleMapAssoc* GetAssocNode (Key, Hash);
 *
 *=========================================================================*/
template<class TKey>
CSrSimpleMap<TKey>::CSrSimpleMapAssoc* CSrSimpleMap<TKey>::GetAssocNode (const TKey Key, dword& Hash) {
  CSrSimpleMapAssoc* pAssoc;

	/* Ignore if no table defined */
  Hash = HashKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return (NULL);
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {
    if (CompareKeys(pAssoc->Value, Key)) return pAssoc;
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::GetAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - dword HashKey (Key);
 *
 *=========================================================================*/
template<class TKey>
inline dword CSrSimpleMap<TKey>::HashKey (const TKey Key) {
  return ((dword) Key) >> 4;
 }
/*===========================================================================
 *		End of Class Method dword CSrSimpleMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - void InitHashTable (Size);
 *
 *=========================================================================*/
template<class TKey>
void CSrSimpleMap<TKey>::InitHashTable (const dword Size) {
  
	/* Clear the current table if any */
  if (m_ppHashTable != NULL) {
    delete[] m_ppHashTable;
    m_ppHashTable = NULL;
   }

   int Temp = sizeof(CSrSimpleMapAssoc);

	/* Allocate the new hash table */ 
  m_HashTableSize = Size;
  m_ppHashTable   = new CSrSimpleMapAssoc* [m_HashTableSize];
  m_RecordCount   = 0;
  memset(m_ppHashTable, 0, sizeof(CSrSimpleMapAssoc*) * m_HashTableSize);
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::InitHashTable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - bool Lookup (TempKey, pKey);
 *
 *=========================================================================*/
template<class TKey>
bool CSrSimpleMap<TKey>::Lookup (const TKey TempKey, TKey*& pKey) {
  CSrSimpleMapAssoc* pAssoc;
  dword        Hash;

  pAssoc = GetAssocNode(TempKey, Hash);

  if (pAssoc == NULL) {
    pKey = NULL;
    return (false);
   }

  pKey = &pAssoc->Value;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::Lookup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - CSrSimpleMapAssoc* NewAssocNode (void);
 *
 *=========================================================================*/
template<class TKey>
CSrSimpleMap<TKey>::CSrSimpleMapAssoc* CSrSimpleMap<TKey>::NewAssocNode (void) {
  CSrSimpleMap::CSrSimpleMapAssoc* pAssoc;

  pAssoc = new CSrSimpleMapAssoc;
  return (pAssoc);
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::NewAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - void RemoveAll (void);
 *
 *=========================================================================*/
template<class TKey>
void CSrSimpleMap<TKey>::RemoveAll (void) {
  CSrSimpleMapAssoc*	pAssoc;
  CSrSimpleMapAssoc*	pAssoc1;
  dword			Index;

	/* Delete all records in the table */
  if (m_ppHashTable != NULL) {
    for (Index = 0; Index < m_HashTableSize; ++Index) {
      for (pAssoc = m_ppHashTable[Index]; pAssoc != NULL; ) {
        pAssoc1 = pAssoc->pNext;
        delete pAssoc;
        pAssoc = pAssoc1;
       }
     }

    delete[] m_ppHashTable;
    m_ppHashTable = NULL;
   }

  m_RecordCount = 0;
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::RemoveAll()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleMap Method - void SetAt (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey>
void CSrSimpleMap<TKey>::SetAt (const TKey Key) {
  CSrSimpleMapAssoc* pAssoc;
  dword        Hash;

	/* Find an existing node */
  pAssoc = GetAssocNode(Key, Hash);

  if (pAssoc == NULL) {
    if (m_ppHashTable == NULL) InitHashTable(m_HashTableSize);

    pAssoc = NewAssocNode();
    pAssoc->HashValue = Hash;

    pAssoc->pNext       = m_ppHashTable[Hash];
    m_ppHashTable[Hash] = pAssoc;
    ++m_RecordCount;
   }

  pAssoc->Value = Key;
 }
/*===========================================================================
 *		End of Class Method CSrSimpleMap::SetAt()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Obsimplemap.H
 *=========================================================================*/
