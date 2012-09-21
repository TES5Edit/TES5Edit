/*===========================================================================
 *
 * File:		Srrecordmap.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines various hash-map classes used to hold records.
 *
 *=========================================================================*/
#ifndef __SRRECORDMAP_H
#define __SRRECORDMAP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sridrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default size of the hash map tables */
  #define SR_RECORDMAP_DEFAULTSIZE 1009

	/* Used to iterate through records */
  typedef void* SRMAPPOS;

	/* Number of nodes to allocate at a time */
  #define SR_RECORDMAP_BLOCKSIZE 10000

	/* Use block allocators or not */
  #define SR_RECORDMAP_ALLOCATEBLOCK 1

#if SR_RECORDMAP_ALLOCATEBLOCK
  #define SRMAP_DELETENODE(pNode)	/* Don't delete a node when using blocked allocators */
#else
  #define SRMAP_DELETENODE(pNode) delete pNode
#endif

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBaseRecordMap Definition
 *
 * Template class from which specific hash-map implementations will be 
 * created from.
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
class CSrBaseRecordMap {

	/* Private structure used as a linked list for each unique hash value */
  struct CSrMapAssoc {
	CSrMapAssoc* pNext;
	dword	     HashValue;
	TRecord*     Value;
  };

  struct CSrMapBlock {
	CSrMapAssoc*	pNodes;
	dword			NextFreeIndex;
	dword			BlockSize;
	CSrMapBlock*	pNextBlock;
  };

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrMapAssoc**	m_ppHashTable;		/* Array of hash records */
  dword			m_RecordCount;
  dword			m_HashTableSize;

  CSrMapBlock*	m_pHeadBlock;
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Create a new node */
  virtual CSrMapAssoc* CreateAssocNode (void);

	/* Delete all allocated node blocks */
  void DestroyBlocks (void);

	/* Compare two keys */
  virtual bool CompareKeys (TKeyArg     Key1, TKeyArg     Key2);
  virtual bool CompareKeys (TRecord* Record1, TRecord* Record2);
  virtual bool CompareKeys (TRecord* Record,  TKeyArg      Key) = 0;

	/* Helper find method */
  virtual CSrMapAssoc* GetAssocNode (TKeyArg  Key,    dword& Hash);
  virtual CSrMapAssoc* GetAssocNode (TRecord* Record, dword& Hash);

		
  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBaseRecordMap();
  virtual ~CSrBaseRecordMap() { Destroy(); }
  virtual void Destroy (void);

	/* Delete a specified key */
  void Delete (TKeyArg Key, TRecord* pRecord);

	/* Iterate through records in the map */
  TRecord* GetFirstRecord (SRMAPPOS& Position);
  TRecord* GetNextRecord  (SRMAPPOS& Position);

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
 *		End of Class CSrBaseRecordMap Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Constructor
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CSrBaseRecordMap () {
  m_ppHashTable   = NULL;
  m_RecordCount   = 0;
  m_HashTableSize = SR_RECORDMAP_DEFAULTSIZE;
  m_pHeadBlock    = NULL;
 }
/*===========================================================================
 *		End of Class CSrBaseRecordMap Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - void Destroy (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline void CSrBaseRecordMap<TKey, TRecord, TKeyArg>::Destroy (void) {
  RemoveAll();
}
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - void DestroyBlocks (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline void CSrBaseRecordMap<TKey, TRecord, TKeyArg>::DestroyBlocks (void) {
  CSrMapBlock* pBlock     = m_pHeadBlock;
  CSrMapBlock* pNextBlock = m_pHeadBlock;

  while (pBlock != NULL) {
    delete[] pBlock->pNodes;

    pNextBlock = pBlock->pNextBlock;
    delete pBlock;
    pBlock = pNextBlock;
  }

  m_pHeadBlock = NULL;
}
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - CSrMapAssoc* CreateAssocNode (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
typename CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CSrMapAssoc* CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CreateAssocNode (void)
{
  typename CSrBaseRecordMap::CSrMapAssoc* pAssoc;

#if SR_RECORDMAP_ALLOCATEBLOCK

  if (m_pHeadBlock == NULL || m_pHeadBlock->NextFreeIndex >= m_pHeadBlock->BlockSize) {
    CSrMapBlock* pNewBlock   = new CSrMapBlock;
    pNewBlock->BlockSize     = SR_RECORDMAP_BLOCKSIZE;
    pNewBlock->NextFreeIndex = 0;
    pNewBlock->pNodes        = new CSrMapAssoc[SR_RECORDMAP_BLOCKSIZE];
    pNewBlock->pNextBlock    = m_pHeadBlock;
    m_pHeadBlock = pNewBlock;
  }

  pAssoc = &(m_pHeadBlock->pNodes[m_pHeadBlock->NextFreeIndex]);
  ++m_pHeadBlock->NextFreeIndex;

#else
  pAssoc = new CSrMapAssoc;
#endif

  return (pAssoc);
}
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::CreateAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - bool CompareKeys (Key1, Key2);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline bool CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CompareKeys (TKeyArg Key1, TKeyArg Key2) {
  return (Key1 == Key2);
 }


template<class TKey, class TRecord, class TKeyArg>
inline bool CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CompareKeys (TRecord* Record1, TRecord* Record2) {
  return (Record1 == Record2);
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::CompareKeys()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - void Delete (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CSrBaseRecordMap<TKey, TRecord, TKeyArg>::Delete (TKeyArg Key, TRecord* pRecord) {
  CSrMapAssoc* pAssoc;
  CSrMapAssoc* pLastAssoc = NULL;
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

      SRMAP_DELETENODE(pAssoc);
      return;
     }

    pLastAssoc = pAssoc;
   }

 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - CSrMapAssoc* GetAssocNode (Key, Hash);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
typename CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CSrMapAssoc* CSrBaseRecordMap<TKey, TRecord, TKeyArg>::GetAssocNode (TKeyArg Key, dword& Hash) {
  CSrMapAssoc* pAssoc;

	/* Ignore if no table defined */
  Hash = HashKey(Key) % m_HashTableSize;
  if (m_ppHashTable == NULL) return (NULL);
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {
    if (CompareKeys(pAssoc->Value, Key)) return pAssoc;
   }

  return (NULL);
 }


template<class TKey, class TRecord, class TKeyArg>
typename CSrBaseRecordMap<TKey, TRecord, TKeyArg>::CSrMapAssoc* CSrBaseRecordMap<TKey, TRecord, TKeyArg>::GetAssocNode (TRecord* pRecord, dword& Hash) {
  CSrMapAssoc* pAssoc;

	/* Ignore if no table defined */
  Hash = HashKey(pRecord) % m_HashTableSize;
  if (m_ppHashTable == NULL) return (NULL);
  
  for (pAssoc = m_ppHashTable[Hash]; pAssoc != NULL; pAssoc = pAssoc->pNext) {
    if (CompareKeys(pAssoc->Value, pRecord)) return pAssoc;
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::GetAssocNode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - CSrMapAssoc* GetFirstRecord (Position);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
TRecord* CSrBaseRecordMap<TKey, TRecord, TKeyArg>::GetFirstRecord (SRMAPPOS& Position) {
  CSrMapAssoc* pAssoc;
  dword	       Index;

  Position = (SRMAPPOS) NULL;
  if (m_ppHashTable == NULL) return (NULL);

  for (Index = 0; Index < m_HashTableSize; ++Index) {
    pAssoc = m_ppHashTable[Index];
    
    if (pAssoc != NULL) {
      Position = (SRMAPPOS) pAssoc;
      return (pAssoc->Value);
     }
   }

	/* Nothing to return */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::GetFirstRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - CSrMapAssoc* GetNextRecord (Key, Hash);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
TRecord* CSrBaseRecordMap<TKey, TRecord, TKeyArg>::GetNextRecord (SRMAPPOS& Position) {
  CSrMapAssoc* pAssoc;
  dword	       Index;

  pAssoc = (CSrMapAssoc *) Position;
  if (m_ppHashTable == NULL) return (NULL);
  if (pAssoc        == NULL) return (NULL);

  if ( pAssoc->pNext != NULL) {
    Position = (SRMAPPOS)  pAssoc->pNext;
    return ( pAssoc->pNext->Value);
   }

  for (Index = pAssoc->HashValue + 1; Index < m_HashTableSize; ++Index) {
    pAssoc = m_ppHashTable[Index]; 
    
    if (pAssoc != NULL) {
      Position = (SRMAPPOS) pAssoc;
      return (pAssoc->Value);
     }
   }

	/* Nothing to return */
  Position = (SRMAPPOS) NULL;
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::GetNextRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - dword HashKey (Key);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
inline dword CSrBaseRecordMap<TKey, TRecord, TKeyArg>::HashKey (TKeyArg Key) {
  return (dword) (((obptr_t) Key) >> 4);
 }


template<class TKey, class TRecord, class TKeyArg>
inline dword CSrBaseRecordMap<TKey, TRecord, TKeyArg>::HashKey (TRecord* pRecord) {
  return (dword) (((obptr_t) pRecord) >> 4);
 }
/*===========================================================================
 *		End of Class Method dword CSrBaseRecordMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - void InitHashTable (Size);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CSrBaseRecordMap<TKey, TRecord, TKeyArg>::InitHashTable (const dword Size) {
  
	/* Clear the current table if any */
  if (m_ppHashTable != NULL) {
    delete[] m_ppHashTable;
    m_ppHashTable = NULL;
   }

	/* Allocate the new hash table */ 
  m_HashTableSize = Size;
  m_ppHashTable   = new CSrMapAssoc* [m_HashTableSize];
  m_RecordCount   = 0;
  memset(m_ppHashTable, 0, sizeof(CSrMapAssoc*) * m_HashTableSize);
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::InitHashTable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - bool Lookup (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
bool CSrBaseRecordMap<TKey, TRecord, TKeyArg>::Lookup (TKeyArg Key, TRecord*& pRecord) {
  CSrMapAssoc* pAssoc;
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
 *		End of Class Method CSrBaseRecordMap::Lookup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - void RemoveAll (void);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CSrBaseRecordMap<TKey, TRecord, TKeyArg>::RemoveAll (void) {
  CSrMapAssoc*	pAssoc;
  CSrMapAssoc*	pAssoc1;
  dword		Index;

	/* Delete all records in the table */
  if (m_ppHashTable != NULL) {
    for (Index = 0; Index < m_HashTableSize; ++Index) {
      for (pAssoc = m_ppHashTable[Index]; pAssoc != NULL; ) {
        pAssoc1 = pAssoc->pNext;
        SRMAP_DELETENODE(pAssoc);
        pAssoc = pAssoc1;
       }
     }

    delete[] m_ppHashTable;
    m_ppHashTable = NULL;
   }

  m_RecordCount = 0;

	/* Allocate all nodes in blocks */
  DestroyBlocks();
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::RemoveAll()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecordMap Method - void SetAt (Key, pRecord);
 *
 *=========================================================================*/
template<class TKey, class TRecord, class TKeyArg>
void CSrBaseRecordMap<TKey, TRecord, TKeyArg>::SetAt (TKeyArg Key, TRecord* pRecord) {
  CSrMapAssoc* pAssoc;
  dword        Hash;

	/* Only add valid records */
  if (!IsValidRecord(pRecord)) return;

	/* Find an existing node */
  pAssoc = GetAssocNode(Key, Hash);

  if (pAssoc == NULL) {
    if (m_ppHashTable == NULL) InitHashTable(m_HashTableSize);

    pAssoc = CreateAssocNode();
    pAssoc->HashValue = Hash;

    pAssoc->pNext       = m_ppHashTable[Hash];
    m_ppHashTable[Hash] = pAssoc;
    ++m_RecordCount;
   }

  pAssoc->Value = pRecord;
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordMap::SetAt()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Default Hash Map Implementations
 *
 *=========================================================================*/

	/* Uses the lowest 24 bits of the form ID */
class CSrFormIdRecordMap : public CSrBaseRecordMap<srformid_t, CSrRecord, srformid_t> {

protected:

	/* Compare two keys */
  virtual bool CompareKeys (CSrRecord* Record1, CSrRecord* Record2);
  virtual bool CompareKeys (CSrRecord* Record,  srformid_t Key);


public:

	/* Delete record from the map */
  void Delete (CSrRecord* pRecord);

	/* Compute a hash from a record key */
  dword HashKey (CSrRecord* pRecord);
  dword HashKey (srformid_t     Key);

	/* Check if a record is valid and can be added to map */
  bool IsValidRecord (CSrRecord* pRecord);

	/* Set a value */
  void SetAt (CSrRecord* pRecord);

 };


	/* Uses the full form id */
class CSrFullFormIdRecordMap : public CSrFormIdRecordMap {

protected:

	/* Compare two keys */
  virtual bool CompareKeys (CSrRecord* Record1, CSrRecord* Record2);
  virtual bool CompareKeys (CSrRecord* Record,  srformid_t Key);


public:

  	/* Compute a hash from a record key */
  dword HashKey (CSrRecord* pRecord);
  dword HashKey (srformid_t Key);

 };


class CSrEditorIdRecordMap : public CSrBaseRecordMap<CSString, CSrIdRecord, const SSCHAR *> {

protected:

	/* Compare two string keys */
  virtual bool CompareKeys (const SSCHAR* Key1,    const SSCHAR* Key2);
  virtual bool CompareKeys (CSrIdRecord*  Record1, CSrIdRecord*  Record2);
  virtual bool CompareKeys (CSrIdRecord*  Record,  const SSCHAR* Key);


public:

	/* Delete record from the map */
  void Delete (CSrIdRecord* pRecord);

	/* Compute a hash from a string key */
  dword HashKey (const SSCHAR* Key);
  dword HashKey (CSrIdRecord*  pRecord);

	/* Check if a record is valid and can be added to map */
  bool IsValidRecord (CSrIdRecord* pRecord);

  	/* Set a value */
  void SetAt (CSrIdRecord* pRecord);

 };
/*===========================================================================
 *		End of Default Hash Map Implementations
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEditorIdRecordMap Method - bool CompareKeys (Key1, Key2);
 *
 *=========================================================================*/
inline bool CSrFormIdRecordMap::CompareKeys (CSrRecord* Record1, CSrRecord*  Record2) {
  return ((Record1->GetFormID() & 0x00FFFFFF) == (Record2->GetFormID() & 0x00FFFFFF));
 }


inline bool CSrFormIdRecordMap::CompareKeys (CSrRecord* Record, srformid_t Key) {
  return ((Record->GetFormID() & 0x00FFFFFF) == (Key & 0x00FFFFFF));
 }


inline bool CSrFullFormIdRecordMap::CompareKeys (CSrRecord* Record1, CSrRecord*  Record2) {
  return (Record1->GetFormID() == Record2->GetFormID());
 }


inline bool CSrFullFormIdRecordMap::CompareKeys (CSrRecord* Record, srformid_t Key) {
  return (Record->GetFormID() == Key);
 }



inline bool CSrEditorIdRecordMap::CompareKeys (const SSCHAR* Key1, const SSCHAR* Key2) {
  return (stricmp(Key1, Key2) == 0);
 }


inline bool CSrEditorIdRecordMap::CompareKeys (CSrIdRecord* Record1, CSrIdRecord* Record2) {
  return (stricmp(Record1->GetEditorID(), Record2->GetEditorID()) == 0);
 }


inline bool CSrEditorIdRecordMap::CompareKeys (CSrIdRecord* Record, const SSCHAR* Key) {
  return (stricmp(Record->GetEditorID(), Key) == 0);
 }
/*===========================================================================
 *		End of Class Method dword CSrEditorIdRecordMap::CompareKeys()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEditorIdRecordMap Method - void Delete (pRecord);
 *
 *=========================================================================*/
inline void CSrEditorIdRecordMap::Delete (CSrIdRecord* Record) {
  if (Record != NULL) CSrBaseRecordMap<CSString, CSrIdRecord, const SSCHAR *>::Delete(Record->GetEditorID(), Record);
 }

inline void CSrFormIdRecordMap::Delete (CSrRecord* Record) {
  if (Record != NULL) CSrBaseRecordMap<srformid_t, CSrRecord, srformid_t>::Delete(Record->GetFormID(), Record);
 }
/*===========================================================================
 *		End of Class Method dword CSrEditorIdRecordMap::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEditorIdRecordMap Method - dword HashKey (Key);
 *
 * Specific implementations for hashing keys.
 *
 *=========================================================================*/
inline dword CSrEditorIdRecordMap::HashKey (const SSCHAR* Key) {
  dword nHash = 0;

  while (*Key) {
    nHash = (nHash << 5) + nHash + tolower(*Key);
    ++Key;
   }

  return nHash;
 }


inline dword CSrEditorIdRecordMap::HashKey (CSrIdRecord* pRecord) {
  return HashKey(pRecord->GetEditorID());
 }


inline dword CSrFormIdRecordMap::HashKey (CSrRecord* pRecord) {
  return ((dword) (pRecord->GetFormID() & 0x00FFFFFF)) >> 4;
 }


inline dword CSrFormIdRecordMap::HashKey (srformid_t Key) {
   return ((dword) (Key & 0x00FFFFFF)) >> 4;
 }


inline dword CSrFullFormIdRecordMap::HashKey (CSrRecord* pRecord) {
  return ((dword) pRecord->GetFormID()) >> 4;
 }


inline dword CSrFullFormIdRecordMap::HashKey (srformid_t Key) {
   return ((dword) Key) >> 4;
 }
/*===========================================================================
 *		End of Class Method dword CSrEditorIdRecordMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEditorIdRecordMap Method - bool IsValidRecord (pRecord);
 *
 *=========================================================================*/	
inline bool CSrFormIdRecordMap::IsValidRecord (CSrRecord* pRecord) { 
  return (pRecord != NULL && pRecord->GetFormID() != 0); 
 }


inline bool CSrEditorIdRecordMap::IsValidRecord (CSrIdRecord* pRecord) { 
  return (pRecord != NULL && pRecord->GetEditorID() != NULL && pRecord->GetEditorID()[0] != NULL_CHAR); 
 }
/*===========================================================================
 *		End of Class Method dword CSrEditorIdRecordMap::HashKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class void CSrEditorIdRecordMap Method - inline SetAt (pRecord);
 *
 *=========================================================================*/
inline void CSrFormIdRecordMap::SetAt (CSrRecord* pRecord) {
  CSrBaseRecordMap<srformid_t, CSrRecord, srformid_t>::SetAt(pRecord->GetFormID(), pRecord);
 }


inline void CSrEditorIdRecordMap::SetAt (CSrIdRecord* pRecord) {
  //CSrIdRecord* pIdRecord;

  //if (pRecord == NULL) return;
  //pIdRecord = SrCastClass(CSrIdRecord, pRecord);
  //if (pIdRecord != NULL) 
  CSrBaseRecordMap<CSString, CSrIdRecord, const SSCHAR *>::SetAt(pRecord->GetEditorID(), pRecord);
 }
/*===========================================================================
 *		End of Class Method void CSrEditorIdRecordMap::SetAt()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srbaserecordmap.H
 *=========================================================================*/
