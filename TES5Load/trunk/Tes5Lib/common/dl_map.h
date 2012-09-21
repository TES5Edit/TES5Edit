/*===========================================================================
 *
 * File:	dl_map.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	May 6, 2006
 *
 * Defines a hash-map template class.
 *
 *=========================================================================*/
#ifndef __DLMAP_H
#define __DLMAP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srerrorhandler.h"
  #include "sstring.h"
  #include "ctype.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default size of the hash map tables */
  #define DLMAP_DEFAULTSIZE 1009

	/* Used to iterate through records */
  typedef void* MAPPOSITION;

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class TGenPtrMap Definition
 *
 * Template class from which specific hash-map implementations will be 
 * created from.
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
class TGenPtrMap {

	/* Private structure used as a linked list for each unique hash value */
  struct CGenMapAssoc {
	CGenMapAssoc* pNext;
	dword	      HashValue;
	TKey	      Key;
	TValue*       Value;
   };

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CGenMapAssoc** m_ppHashTable;		/* Array of hash records */
  dword		 m_RecordCount;
  dword		 m_HashTableSize;
  bool		 m_DeleteValues;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper find method */
  virtual CGenMapAssoc* GetAssocNode (TKeyArg Key, dword& Hash);

	/* Create a new node */
  virtual CGenMapAssoc* NewAssocNode (void);

	
  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  TGenPtrMap();
  virtual ~TGenPtrMap() { Destroy(); }
  virtual void Destroy (void);

	/* Delete a specified key */
  virtual void Delete (TKeyArg Key);

	/* Iterate through records in the map */
  virtual TValue* GetFirstRecord (MAPPOSITION& Position);
  virtual TValue* GetNextRecord  (MAPPOSITION& Position);
  virtual TKey*   GetPosKey      (MAPPOSITION& Position);

	/* Iterate through records in the map */
  virtual TValue* GetFirstRecordKey (TKeyArg Key, MAPPOSITION& Position);
  virtual TValue* GetNextRecordKey  (MAPPOSITION& Position);

	/* Get class members */
  virtual dword GetNumRecords (void) { return (m_RecordCount); }
  virtual dword GetSize       (void) { return (m_RecordCount); }

	/* Initialize the hash table to a specific size */
  virtual void InitHashTable (const dword Size);

	/* Find an existing value by its key */
  virtual bool    Lookup (TKeyArg Key, TValue*& pRecord);
  virtual TValue* Lookup (TKeyArg Key);

	/* Delete all hash table entries */
  virtual void RemoveAll (void);

	/* Set a value */
  virtual void SetAt (TKeyArg Key, TValue* pRecord);

 };
/*===========================================================================
 *		End of Class TGenPtrMap Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class TGenRefPtrMap Definition
 *
 * Template class from which specific hash-map implementations will be 
 * created from.
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
class TGenRefPtrMap : public TGenPtrMap<TKey, TValue, TKeyArg> {
public:

  TGenRefPtrMap() { this->m_DeleteValues = false; }
};
/*===========================================================================
 *		End of Class TGenRefPtrMap Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Constructor
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TGenPtrMap<TKey, TValue, TKeyArg>::TGenPtrMap () {
  m_ppHashTable   = NULL;
  m_RecordCount   = 0;
  m_HashTableSize = DLMAP_DEFAULTSIZE;
  m_DeleteValues  = true;
}
/*===========================================================================
 *		End of Class TGenPtrMap Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - void Destroy (void);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
inline void TGenPtrMap<TKey, TValue, TKeyArg>::Destroy (void) {
  RemoveAll();
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - void Delete (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
void TGenPtrMap<TKey, TValue, TKeyArg>::Delete (TKeyArg Key) {
  CGenMapAssoc* pAssoc;
  CGenMapAssoc* pLastAssoc = NULL;
  dword         Hash;

	/* Ignore if no table defined */
  Hash = HashGenKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return;
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {

    if (CompareGenKeys(pAssoc->Key, Key)) {

      if (pLastAssoc != NULL) 
        pLastAssoc->pNext = pAssoc->pNext;
      else
        m_ppHashTable[Hash] = pAssoc->pNext;

      if (m_DeleteValues) { delete pAssoc->Value; }
      delete pAssoc;
      return;
     }

    pLastAssoc = pAssoc;
   }

 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - CGenMapAssoc* GetAssocNode (Key, Hash);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
typename TGenPtrMap<TKey, TValue, TKeyArg>::CGenMapAssoc* TGenPtrMap<TKey, TValue, TKeyArg>::GetAssocNode (TKeyArg Key, dword& Hash) {
  CGenMapAssoc* pAssoc;

	/* Ignore if no table defined */
  Hash = HashGenKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return (NULL);
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {
    if (CompareGenKeys(pAssoc->Key, Key)) return pAssoc;
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::GetAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - CGenMapAssoc* GetFirstRecord (Position);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TValue* TGenPtrMap<TKey, TValue, TKeyArg>::GetFirstRecord (MAPPOSITION& Position) {
  CGenMapAssoc* pAssoc;
  dword	       Index;

  Position = (MAPPOSITION) NULL;
  if (m_ppHashTable == NULL) return (NULL);

  for (Index = 0; Index < m_HashTableSize; ++Index) {
    pAssoc = m_ppHashTable[Index];
    
    if (pAssoc != NULL) {
      Position = (MAPPOSITION) pAssoc;
      return (pAssoc->Value);
     }
   }

	/* Nothing to return */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::GetFirstRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - CGenMapAssoc* GetNextRecord (Key, Hash);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TValue* TGenPtrMap<TKey, TValue, TKeyArg>::GetNextRecord (MAPPOSITION& Position) {
  CGenMapAssoc* pAssoc;
  dword	       Index;

  pAssoc = (CGenMapAssoc *) Position;
  if (m_ppHashTable == NULL) return (NULL);
  if (pAssoc        == NULL) return (NULL);
  
  if (pAssoc->pNext != NULL) {
    Position = (MAPPOSITION) pAssoc->pNext;
    return (pAssoc->pNext->Value);
   }

  for (Index = pAssoc->HashValue + 1; Index < m_HashTableSize; ++Index) {
    pAssoc = m_ppHashTable[Index]; 
    
    if (pAssoc != NULL) {
      Position = (MAPPOSITION) pAssoc;
      return (pAssoc->Value);
     }
   }

	/* Nothing to return */
  Position = (MAPPOSITION) NULL;
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::GetNextRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - TKey* GetPosKey (Position);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TKey* TGenPtrMap<TKey, TValue, TKeyArg>::GetPosKey (MAPPOSITION& Position) {
  CGenMapAssoc* pAssoc;

  pAssoc = (CGenMapAssoc *) Position;
  if (pAssoc        == NULL) return (NULL);
  if (m_ppHashTable == NULL) return (NULL);
  if (m_ppHashTable[pAssoc->HashValue] == NULL) return (NULL); 

  return &(m_ppHashTable[pAssoc->HashValue]->Key);
}
/*===========================================================================
 *		End of Class Method TGenPtrMap::GetPosKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - CGenMapAssoc* GetFirstRecordKey (Key, Position);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TValue* TGenPtrMap<TKey, TValue, TKeyArg>::GetFirstRecordKey (TKeyArg Key, MAPPOSITION& Position) {
  CGenMapAssoc* pAssoc;
  dword	        Hash;

  Position = (MAPPOSITION) NULL;
  if (m_ppHashTable == NULL) return (NULL);

  Hash = HashGenKey(Key) % m_HashTableSize;

  pAssoc   = m_ppHashTable[Hash];
  Position = (MAPPOSITION) pAssoc;
  return (pAssoc->Value);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::GetFirstRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - CGenMapAssoc* GetNextRecordKey (Hash);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TValue* TGenPtrMap<TKey, TValue, TKeyArg>::GetNextRecordKey (MAPPOSITION& Position) {
  CGenMapAssoc* pAssoc;

  pAssoc = (CGenMapAssoc *) Position;
  if (m_ppHashTable == NULL) return (NULL);
  if (pAssoc        == NULL) return (NULL);

  pAssoc = pAssoc->pNext;

  if (pAssoc != NULL) {
    Position = (MAPPOSITION) pAssoc;
    return (pAssoc->Value);
   }

	/* Nothing to return */
  Position = (MAPPOSITION) NULL;
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::GetNextRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - void InitHashTable (Size);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
void TGenPtrMap<TKey, TValue, TKeyArg>::InitHashTable (const dword Size) {
  
	/* Clear the current table if any */
  delete[] m_ppHashTable;

	/* Allocate the new hash table */ 
  m_HashTableSize = Size;
  m_ppHashTable   = new CGenMapAssoc* [m_HashTableSize];
  m_RecordCount   = 0;
  memset(m_ppHashTable, 0, sizeof(CGenMapAssoc*) * m_HashTableSize);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::InitHashTable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - bool Lookup (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
bool TGenPtrMap<TKey, TValue, TKeyArg>::Lookup (TKeyArg Key, TValue*& pRecord) {
  CGenMapAssoc* pAssoc;
  dword        Hash;

  pAssoc = GetAssocNode(Key, Hash);

  if (pAssoc == NULL) {
    pRecord = NULL;
    return (false);
   }

  pRecord = pAssoc->Value;
  return (true);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::Lookup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - TRecord* Lookup (Key);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
TValue* TGenPtrMap<TKey, TValue, TKeyArg>::Lookup (TKeyArg Key) {
  CGenMapAssoc* pAssoc;
  dword         Hash;

  pAssoc = GetAssocNode(Key, Hash);

  if (pAssoc == NULL) 
  {
	  //SystemLog.Printf("Unknown key %d found!", (int) Key);
	  return (NULL);
  }

  return pAssoc->Value;
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::Lookup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - CGenMapAssoc* NewAssocNode (void);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
typename TGenPtrMap<TKey, TValue, TKeyArg>::CGenMapAssoc* TGenPtrMap<TKey, TValue, TKeyArg>::NewAssocNode (void) {
  typename TGenPtrMap::CGenMapAssoc* pAssoc;

  pAssoc = new CGenMapAssoc;
  return (pAssoc);
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::NewAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - void RemoveAll (void);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
void TGenPtrMap<TKey, TValue, TKeyArg>::RemoveAll (void) {
  CGenMapAssoc*	pAssoc;
  CGenMapAssoc*	pAssoc1;
  dword		Index;

	/* Delete all records in the table */
  if (m_ppHashTable != NULL) {
    for (Index = 0; Index < m_HashTableSize; ++Index) {
      for (pAssoc = m_ppHashTable[Index]; pAssoc != NULL; ) {
        pAssoc1 = pAssoc->pNext;

	if (m_DeleteValues) { delete pAssoc->Value; }
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
 *		End of Class Method TGenPtrMap::RemoveAll()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TGenPtrMap Method - void SetAt (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TValue, class TKeyArg>
void TGenPtrMap<TKey, TValue, TKeyArg>::SetAt (TKeyArg Key, TValue* pRecord) {
  CGenMapAssoc* pAssoc;
  dword         Hash;

	/* Find an existing node */
  pAssoc = GetAssocNode(Key, Hash);

  if (pAssoc == NULL) {
    if (m_ppHashTable == NULL) InitHashTable(m_HashTableSize);

    pAssoc = NewAssocNode();
    pAssoc->HashValue = Hash;
    pAssoc->Key       = Key;

    pAssoc->pNext       = m_ppHashTable[Hash];
    m_ppHashTable[Hash] = pAssoc;
    ++m_RecordCount;
   }

  pAssoc->Value = pRecord;
 }
/*===========================================================================
 *		End of Class Method TGenPtrMap::SetAt()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Predefined CompareGenKeys Functions
 *
 *=========================================================================*/
inline bool CompareGenKeys (dword Key1, dword Key2) {
  return (Key1 == Key2);
}

inline bool CompareGenKeys (const char* Key1, const char* Key2) {
  return (SafeStringCompare(Key1, Key2, true) == 0);
}
/*===========================================================================
 *		End of Predefined CompareGenKeys Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Predefined HashGenKey Functions
 *
 *=========================================================================*/
inline dword HashGenKey (dword Key) {
  return (Key >> 4);
}


inline dword HashGenKey (const char* Key) {
  dword nHash = 0;

  while (*Key) {
    nHash = (nHash << 5) + nHash + tolower(*Key);
    ++Key;
   }

  return nHash;
}
/*===========================================================================
 *		End of Predefined HashGenKey Functions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File dl_map.H
 *=========================================================================*/
