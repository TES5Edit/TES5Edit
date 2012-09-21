/*===========================================================================
 *
 * File:	Srblockallocator.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRBLOCKALLOCATOR_H
#define __SRBLOCKALLOCATOR_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srerrorhandler.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default block size */
  #define SRBLOCK_DEFAULT_BLOCKSIZE 10000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Template TSrBlockAllocator Definition
 *
 *=========================================================================*/
template <class TClass>
class TSrBlockAllocator {

	/* Internal structure that maintains a linked list of allocated blocks */
  struct TObBlock {
	TClass*		pNodes;
	dword		NextFreeIndex;
	TObBlock*	pNextBlock;
  };


  /*---------- Begin Protected Class Members ---------------------------*/
protected:
  TObBlock*	m_pHeadBlock;
  TObBlock*	m_pFreeBlocks;

  dword		m_BlockSize;		/* Number of elements allocated per block */


	/* Clears the content in the given block */
  void DestroyBlockContent (TObBlock* pBlock);


  /*---------- Begin Public Class Methods ------------------------------*/
public:

	/* Constructor/Destructor */
  TSrBlockAllocator (const dword BlockSize = SRBLOCK_DEFAULT_BLOCKSIZE);
  ~TSrBlockAllocator() { DestroyBlocks(); }
  void Destroy (void);
  void DestroyBlocks (void);

	/* Create a new object of the templated class */
  TClass* CreateObject (void);

};
/*===========================================================================
 *		End of Template TSrBlockAllocator Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrBlockAllocator Constructor
 *
 *=========================================================================*/
template<class TClass>
TSrBlockAllocator<TClass>::TSrBlockAllocator (const dword BlockSize) {
  m_BlockSize   = BlockSize;
  m_pHeadBlock  = NULL;
  m_pFreeBlocks = NULL;
}
/*===========================================================================
 *		End of Class TSrBlockAllocator Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrBlockAllocator Method - void Destroy (void);
 *
 *=========================================================================*/
template<class TClass>
void TSrBlockAllocator<TClass>::Destroy (void) {
  TObBlock* pBlock = m_pHeadBlock;
  TObBlock* pNextBlock;
  
  while (pBlock != NULL) {
    DestroyBlockContent(pBlock);

    pNextBlock = pBlock->pNextBlock;

    pBlock->pNextBlock = m_pFreeBlocks;
    m_pFreeBlocks      = pBlock;

    pBlock = pNextBlock;
  }

  m_pHeadBlock = NULL;
}
/*===========================================================================
 *		End of Class Method TSrBlockAllocator::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrBlockAllocator Method - void DestroyBlocks (void);
 *
 *=========================================================================*/
template<class TClass>
void TSrBlockAllocator<TClass>::DestroyBlocks (void) {
  TObBlock* pBlock     = m_pHeadBlock;
  TObBlock* pNextBlock;

  while (pBlock != NULL) {
    delete[] pBlock->pNodes;

    pNextBlock = pBlock->pNextBlock;
    delete pBlock;
    pBlock = pNextBlock;
  }

  m_pHeadBlock = NULL;

  pBlock = m_pFreeBlocks;

  while (pBlock != NULL) {
    delete[] pBlock->pNodes;

    pNextBlock = pBlock->pNextBlock;
    delete pBlock;
    pBlock = pNextBlock;
  }

  m_pFreeBlocks = NULL;
}
/*===========================================================================
 *		End of Class Method TSrBlockAllocator::DestroyBlocks()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrBlockAllocator Method - void Destroy (void);
 *
 *=========================================================================*/
template<class TClass>
void TSrBlockAllocator<TClass>::DestroyBlockContent (TObBlock* pBlock) {
  dword Index;

  if (pBlock == NULL) return;

  for (Index = 0; Index < m_BlockSize; ++Index) {
    pBlock->pNodes[Index].Destroy();
  }

}
/*===========================================================================
 *		End of Class Method TSrBlockAllocator::DestroyBlockContent()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TSrBlockAllocator Method - void CreateObject (void);
 *
 *=========================================================================*/
template<class TClass>
TClass* TSrBlockAllocator<TClass>::CreateObject (void) {
  TClass*   pNewObject;
  
  if (m_pHeadBlock == NULL || m_pHeadBlock->NextFreeIndex >= m_BlockSize) {
    TObBlock* pNewBlock;

    if (m_pFreeBlocks == NULL) {
      pNewBlock = new TObBlock;
    }
    else {
      pNewBlock = m_pFreeBlocks;
      m_pFreeBlocks = m_pFreeBlocks->pNextBlock;
    }

    pNewBlock->NextFreeIndex = 0;
    pNewBlock->pNodes        = new TClass[m_BlockSize];
    pNewBlock->pNextBlock    = m_pHeadBlock;
    m_pHeadBlock = pNewBlock;
  }

  pNewObject = &(m_pHeadBlock->pNodes[m_pHeadBlock->NextFreeIndex]);
  ++m_pHeadBlock->NextFreeIndex;

  return (pNewObject);
}
/*===========================================================================
 *		End of Class Method TSrBlockAllocator::CreateObject()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Obblockallocator.H
 *=========================================================================*/
