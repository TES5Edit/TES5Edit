/*===========================================================================
 *
 * File:	MWrecordmap.H
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	May 6, 2006
 *
 * Defines various hash-map classes used to hold records.
 *
 *=========================================================================*/
#ifndef __MWRECORDMAP_H
#define __MWRECORDMAP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "esmrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default size of the hash map tables */
  #define MW_RECORDMAP_DEFAULTSIZE 1009

	/* Used to iterate through records */
  typedef void* MWMAPPOS;

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
* Begin Class CMwBaseRecordMap Definition
 *
 * Template class from which specific hash-map implementations will be 
 * created from.
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
class CMwBaseRecordMap {

	/* Private structure used as a linked list for each unique hash value */
  struct CMwMapAssoc {
	CMwMapAssoc* pNext;
	dword	     HashValue;
	TRecord*     Value;
   };

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CMwMapAssoc**	m_ppHashTable;		/* Array of hash records */
  dword		m_RecordCount;
  dword		m_HashTableSize;
  


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Compare two keys */
  virtual bool CompareKeys (TKeyArg     Key1, TKeyArg     Key2);
  virtual bool CompareKeys (TRecord* Record1, TRecord* Record2);
  virtual bool CompareKeys (TRecord* Record,  TKeyArg      Key) = 0;

	/* Helper find method */
  virtual CMwMapAssoc* GetAssocNode (TKeyArg  Key,    dword& Hash);
  virtual CMwMapAssoc* GetAssocNode (TRecord* Record, dword& Hash);

	/* Create a new node */
  virtual CMwMapAssoc* NewAssocNode (void);

	
  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwBaseRecordMap();
  virtual ~CMwBaseRecordMap() { Destroy(); }
  virtual void Destroy (void);

	/* Delete a specified key */
  void Delete (TKeyArg Key, TRecord* pRecord, const bool Delete = true);

	/* Iterate through records in the map */
  TRecord* GetFirstRecord (MWMAPPOS& Position);
  TRecord* GetNextRecord  (MWMAPPOS& Position);

  TRecord* GetFirstRecordKey (TKeyArg Key, MWMAPPOS& Position);
  TRecord* GetNextRecordKey  (TKeyArg Key, MWMAPPOS& Position);

	/* Get class members */
  virtual dword GetRecordCount (void) { return (m_RecordCount); }

	/* Hash a key value */
  virtual dword HashKey (TKeyArg  Key);
  virtual dword HashKey (TRecord* pRecord);

	/* Initialize the hash table to a specific size */
  virtual void InitHashTable (const dword Size);

	/* Checks if the given record is valid or not */
  virtual bool IsValidRecord (TRecord* pRecord) { return (pRecord != NULL); }

	/* Find an existing value by its key */
  virtual bool Lookup (TKeyArg Key, TRecord*& pRecord);

	/* Delete all hash table entries */
  virtual void RemoveAll (void);

	/* Set a value */
  virtual void SetAt (TKeyArg Key, TRecord* pRecord);

 };
/*===========================================================================
 *		End of Class CMwBaseRecordMap Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Constructor
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
CMwBaseRecordMap<TKey, TRecord, TKeyArg>::CMwBaseRecordMap () {
  m_ppHashTable   = NULL;
  m_RecordCount   = 0;
  m_HashTableSize = MW_RECORDMAP_DEFAULTSIZE;
 }
/*===========================================================================
 *		End of Class CMwBaseRecordMap Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - void Destroy (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline void CMwBaseRecordMap<TKey, TRecord, TKeyArg>::Destroy (void) {
  RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - bool CompareKeys (Key1, Key2);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline bool CMwBaseRecordMap<TKey, TRecord, TKeyArg>::CompareKeys (TKeyArg Key1, TKeyArg Key2) {
  return (Key1 == Key2);
 }


template<class TKey, class TRecord, class TKeyArg>
inline bool CMwBaseRecordMap<TKey, TRecord, TKeyArg>::CompareKeys (TRecord* Record1, TRecord* Record2) {
  return (Record1 == Record2);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::CompareKeys()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - void Delete (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CMwBaseRecordMap<TKey, TRecord, TKeyArg>::Delete (TKeyArg Key, TRecord* pRecord, const bool Delete) {
  CMwMapAssoc* pAssoc;
  CMwMapAssoc* pLastAssoc = NULL;
  dword        Hash;

	/* Ignore if no table defined */
  Hash = HashKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return;
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {

    if (CompareKeys(pAssoc->Value, Key)) {

      if (pLastAssoc != NULL) 
        pLastAssoc->pNext = pAssoc->pNext;
      else
        m_ppHashTable[Hash] = pAssoc->pNext;

      if (Delete) delete pAssoc;
      return;
     }

    pLastAssoc = pAssoc;
   }

 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - CMwMapAssoc* GetAssocNode (Key, Hash);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
CMwBaseRecordMap<TKey, TRecord, TKeyArg>::CMwMapAssoc* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::GetAssocNode (TKeyArg Key, dword& Hash) {
  CMwMapAssoc* pAssoc;

	/* Ignore if no table defined */
  Hash = HashKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return (NULL);
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {
    if (CompareKeys(pAssoc->Value, Key)) return pAssoc;
   }

  return (NULL);
 }


template<class TKey, class TRecord, class TKeyArg>
CMwBaseRecordMap<TKey, TRecord, TKeyArg>::CMwMapAssoc* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::GetAssocNode (TRecord* pRecord, dword& Hash) {
  CMwMapAssoc* pAssoc;

	/* Ignore if no table defined */
  Hash = HashKey(pRecord) % m_HashTableSize;
  if (m_ppHashTable == NULL) return (NULL);
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {
    if (CompareKeys(pAssoc->Value, pRecord)) return pAssoc;
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::GetAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - CMwMapAssoc* GetFirstRecord (Position);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
TRecord* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::GetFirstRecord (MWMAPPOS& Position) {
  CMwMapAssoc* pAssoc;
  dword	       Index;

  Position = (MWMAPPOS) NULL;
  if (m_ppHashTable == NULL) return (NULL);

  for (Index = 0; Index < m_HashTableSize; ++Index) {
    pAssoc = m_ppHashTable[Index];
    
    if (pAssoc != NULL) {
      Position = (MWMAPPOS) pAssoc;
      return (pAssoc->Value);
     }
   }

	/* Nothing to return */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::GetFirstRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - CMwMapAssoc* GetNextRecord (Position);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
TRecord* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::GetNextRecord (MWMAPPOS& Position) {
  CMwMapAssoc* pAssoc;
  dword	       Index;

  pAssoc = (CMwMapAssoc *) Position;
  if (m_ppHashTable == NULL) return (NULL);
  if (pAssoc        == NULL) return (NULL);

  if (pAssoc->pNext != NULL) {
    Position = (MWMAPPOS) pAssoc->pNext;
    return (pAssoc->pNext->Value);
   }

  for (Index = pAssoc->HashValue + 1; Index < m_HashTableSize; ++Index) {
    pAssoc = m_ppHashTable[Index]; 
    
    if (pAssoc != NULL) {
      Position = (MWMAPPOS) pAssoc;
      return (pAssoc->Value);
     }
   }

	/* Nothing to return */
  Position = (MWMAPPOS) NULL;
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::GetNextRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - CMwMapAssoc* GetFirstRecordKey (Key, Position);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
TRecord* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::GetFirstRecordKey (TKeyArg Key, MWMAPPOS& Position) {
  CMwMapAssoc* pAssoc;
  dword        Hash;

  Position = NULL;
  if (m_ppHashTable == NULL) return (NULL);

  Hash = HashKey(Key) % m_HashTableSize;
  pAssoc = m_ppHashTable[Hash];

  while (pAssoc) {

    if (CompareKeys(pAssoc->Value, Key)) {
      Position = (MWMAPPOS) pAssoc;
      return (pAssoc->Value);
    }

    pAssoc = pAssoc->pNext;
  }
  
  Position = NULL;
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::GetFirstRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - CMwMapAssoc* GetNextRecordKey (Key, Position);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
TRecord* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::GetNextRecordKey (TKeyArg Key, MWMAPPOS& Position) {
  CMwMapAssoc* pAssoc;

  pAssoc = (CMwMapAssoc *) Position;
  if (m_ppHashTable == NULL) return (NULL);
  if (pAssoc        == NULL) return (NULL);

  pAssoc = pAssoc->pNext;

  while (pAssoc) {

    if (CompareKeys(pAssoc->Value, Key)) {
      Position = (MWMAPPOS) pAssoc;
      return (pAssoc->Value);
    }

    pAssoc = pAssoc->pNext;
  }

  	/* Nothing to return */
  Position = NULL;
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::GetNextRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - dword HashKey (Key);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline dword CMwBaseRecordMap<TKey, TRecord, TKeyArg>::HashKey (TKeyArg Key) {
  return ((dword) Key) >> 4;
 }


template<class TKey, class TRecord, class TKeyArg>
inline dword CMwBaseRecordMap<TKey, TRecord, TKeyArg>::HashKey (TRecord* pRecord) {
  return ((dword) pRecord) >> 4;
 }
/*===========================================================================
 *		End of Class Method dword CMwBaseRecordMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - void InitHashTable (Size);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CMwBaseRecordMap<TKey, TRecord, TKeyArg>::InitHashTable (const dword Size) {
  
	/* Clear the current table if any */
  if (m_ppHashTable != NULL) {
    delete[] m_ppHashTable;
    m_ppHashTable = NULL;
   }

	/* Allocate the new hash table */ 
  m_HashTableSize = Size;
  m_ppHashTable   = new CMwMapAssoc* [m_HashTableSize];
  m_RecordCount   = 0;
  memset(m_ppHashTable, 0, sizeof(CMwMapAssoc*) * m_HashTableSize);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::InitHashTable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - bool Lookup (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
bool CMwBaseRecordMap<TKey, TRecord, TKeyArg>::Lookup (TKeyArg Key, TRecord*& pRecord) {
  CMwMapAssoc* pAssoc;
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
 *		End of Class Method CMwBaseRecordMap::Lookup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - CMwMapAssoc* NewAssocNode (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
CMwBaseRecordMap<TKey, TRecord, TKeyArg>::CMwMapAssoc* CMwBaseRecordMap<TKey, TRecord, TKeyArg>::NewAssocNode (void) {
  CMwBaseRecordMap::CMwMapAssoc* pAssoc;

  pAssoc = new CMwMapAssoc;
  return (pAssoc);
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::NewAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - void RemoveAll (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CMwBaseRecordMap<TKey, TRecord, TKeyArg>::RemoveAll (void) {
  CMwMapAssoc*	pAssoc;
  CMwMapAssoc*	pAssoc1;
  dword		Index;

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
 *		End of Class Method CMwBaseRecordMap::RemoveAll()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwBaseRecordMap Method - void SetAt (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CMwBaseRecordMap<TKey, TRecord, TKeyArg>::SetAt (TKeyArg Key, TRecord* pRecord) {
  CMwMapAssoc* pAssoc;
  dword        Hash;

	/* Only add valid records */
  if (!IsValidRecord(pRecord)) return;

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

  pAssoc->Value = pRecord;
 }
/*===========================================================================
 *		End of Class Method CMwBaseRecordMap::SetAt()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Default Hash Map Implementations
 *
 *=========================================================================*/

	/* Uses the record type */
class CMwTypeRecordMap : public CMwBaseRecordMap<esmrectype_t, esmrecinfo_t, esmrectype_t> {

protected:

	/* Compare two keys */
  virtual bool CompareKeys (esmrecinfo_t* Record1, esmrecinfo_t*  Record2);
  virtual bool CompareKeys (esmrecinfo_t* Record,  esmrectype_t Key);


public:

	/* Delete record from the map */
  void Delete (esmrecinfo_t* pRecord, const bool Delete = true);

	/* Compute a hash from a record key */
  dword HashKey (esmrecinfo_t*  pRecord);
  dword HashKey (esmrectype_t Key);

	/* Check if a record is valid and can be added to map */
  bool IsValidRecord (esmrecinfo_t* pRecord);

	/* Set a value */
  void SetAt (esmrecinfo_t* pRecord);

 };


	/* Uses the record editor ID */
class CMwIdRecordMap : public CMwBaseRecordMap<CSString, esmrecinfo_t, const TCHAR *> {

protected:

	/* Compare two string keys */
  virtual bool CompareKeys (const TCHAR* Key1,      const TCHAR* Key2);
  virtual bool CompareKeys (esmrecinfo_t*  Record1, esmrecinfo_t*  Record2);
  virtual bool CompareKeys (esmrecinfo_t*  Record,  const TCHAR* Key);


public:

	/* Delete record from the map */
  void Delete (esmrecinfo_t* pRecord, const bool Delete = true);

	/* Lookup a record on its ID */
  esmrecinfo_t* Get (const TCHAR* Key2);

	/* Compute a hash from a string key */
  dword HashKey (const TCHAR* Key);
  dword HashKey (esmrecinfo_t*  pRecord);

	/* Check if a record is valid and can be added to map */
  bool IsValidRecord (esmrecinfo_t* pRecord);

  	/* Set a value */
  void SetAt (esmrecinfo_t* pRecord);

 };
/*===========================================================================
 *		End of Default Hash Map Implementations
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObEditorIdRecordMap Method - bool CompareKeys (Key1, Key2);
 *
 *=========================================================================*/
inline bool CMwTypeRecordMap::CompareKeys (esmrecinfo_t* Record1, esmrecinfo_t* Record2) {
  return (*(dword *) Record1->pRecord->GetType() == *(dword *)Record2->pRecord->GetType());
 }


inline bool CMwTypeRecordMap::CompareKeys (esmrecinfo_t* Record, esmrectype_t Key) {
  return (*(long *) Record->pRecord->GetType() == Key.lType);
 }



inline bool CMwIdRecordMap::CompareKeys (const TCHAR* Key1, const TCHAR* Key2) {
  return (stricmp(Key1, Key2) == 0);
 }


inline bool CMwIdRecordMap::CompareKeys (esmrecinfo_t* Record1, esmrecinfo_t* Record2) {
  return (stricmp(Record1->pRecord->GetID(), Record2->pRecord->GetID()) == 0);
 }


inline bool CMwIdRecordMap::CompareKeys (esmrecinfo_t* Record, const TCHAR* Key) {
  return (stricmp(Record->pRecord->GetID(), Key) == 0);
 }
/*===========================================================================
 *		End of Class Method dword CObEditorIdRecordMap::CompareKeys()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObEditorIdRecordMap Method - void Delete (pRecord);
 *
 *=========================================================================*/
inline void CMwIdRecordMap::Delete (esmrecinfo_t* Record, const bool Delete) {
  if (Record != NULL) CMwBaseRecordMap<CSString, esmrecinfo_t, const TCHAR *>::Delete(Record->pRecord->GetID(), Record, Delete);
 }


inline void CMwTypeRecordMap::Delete (esmrecinfo_t* Record, const bool Delete) {
  if (Record != NULL) CMwBaseRecordMap<esmrectype_t, esmrecinfo_t, esmrectype_t>::Delete(Record->pRecord->GetRawType(), Record, Delete);
 }
/*===========================================================================
 *		End of Class Method dword CObEditorIdRecordMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObEditorIdRecordMap Method - void Delete (pRecord);
 *
 *=========================================================================*/
inline esmrecinfo_t* CMwIdRecordMap::Get (const TCHAR* Key2) {
  esmrecinfo_t* pRecInfo;
  if (Lookup(Key2, pRecInfo)) return (pRecInfo);
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method dword CObEditorIdRecordMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObEditorIdRecordMap Method - dword HashKey (Key);
 *
 * Specific implementations for hashing keys.
 *
 *=========================================================================*/
inline dword CMwIdRecordMap::HashKey (const TCHAR* Key) {
  dword nHash = 0;

  while (*Key) {
    nHash = (nHash << 5) + nHash + tolower(*Key);
    ++Key;
   }

  return nHash;
 }


inline dword CMwIdRecordMap::HashKey (esmrecinfo_t* pRecord) {
  return HashKey(pRecord->pRecord->GetID());
 }


inline dword CMwTypeRecordMap::HashKey (esmrecinfo_t* pRecord) {
  return ((dword) (pRecord->pRecord->GetRawType().lType)) >> 4;
 }


inline dword CMwTypeRecordMap::HashKey (esmrectype_t Key) {
   return ((dword) (Key.lType)) >> 4;
 }
/*===========================================================================
 *		End of Class Method dword CObEditorIdRecordMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObEditorIdRecordMap Method - bool IsValidRecord (pRecord);
 *
 *=========================================================================*/	
inline bool CMwTypeRecordMap::IsValidRecord (esmrecinfo_t* pRecord) { 
  return (pRecord != NULL && pRecord->pRecord != NULL); 
 }


inline bool CMwIdRecordMap::IsValidRecord (esmrecinfo_t* pRecord) { 
  return (pRecord != NULL && pRecord->pRecord != NULL && pRecord->pRecord->GetID() != NULL && pRecord->pRecord->GetID()[0] != NULL_CHAR); 
 }
/*===========================================================================
 *		End of Class Method dword CObEditorIdRecordMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class void CObEditorIdRecordMap Method - inline SetAt (pRecord);
 *
 *=========================================================================*/
inline void CMwTypeRecordMap::SetAt (esmrecinfo_t* pRecord) {
  CMwBaseRecordMap<esmrectype_t, esmrecinfo_t, esmrectype_t>::SetAt(pRecord->pRecord->GetRawType(), pRecord);
 }


inline void CMwIdRecordMap::SetAt (esmrecinfo_t* pRecord) {
  if (pRecord == NULL) return;
  CMwBaseRecordMap<CSString, esmrecinfo_t, const TCHAR *>::SetAt(pRecord->pRecord->GetID(), pRecord);
 }
/*===========================================================================
 *		End of Class Method void CObEditorIdRecordMap::SetAt()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File MwRecordmap.H
 *=========================================================================*/
