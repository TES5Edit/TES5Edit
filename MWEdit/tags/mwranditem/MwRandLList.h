/*===========================================================================
 *
 * File:	Mwrandllist.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	June 13, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWRANDLLIST_H
#define __MWRANDLLIST_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "mwrandcom.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* The level list structure */
  typedef struct {
	TCHAR ID[MWESM_ID_MAXSIZE+1];	/* Level list ID */
	int   Number;			/* Number of times to add the list */
   } mwri_levellist_t;

	/* Array of level list pointers */
  typedef TPtrArray<mwri_levellist_t> CMwRandLListArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwRandLList Definition
 *
 * Holds the list of external level lists.
 *
 *=========================================================================*/
class CMwRandLList {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CMwRandLListArray	m_LevelLists;		/* Array of level lists */
  int			m_MaxNumber;
  long			m_InputLine;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

  	/* Add a new level list to the end of the array */
  bool AddLevelList (const TCHAR* pListID, const int Number);
	
	/* Parses an input line to it's components */
  bool ParseLine (TCHAR* pLineBuffer, TCHAR** ppVariable, TCHAR** ppListID, TCHAR** ppNumber);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwRandLList();
  virtual ~CMwRandLList() { Destroy(); }
  virtual void Destroy (void);


	/* Access class members */
  mwri_levellist_t* GetLevelList (const int Index) { return (m_LevelLists.GetAt(Index)); }
  int		    GetNumLists  (void)		   { return (m_LevelLists.GetNumElements()); }
  int		    GetMaxNumber (void)		   { return (m_MaxNumber); }

	/* Input a level list data file */
  bool Read (const TCHAR* pFilename);


 };
/*===========================================================================
 *		End of Class CMwRandLList Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Mwrandllist.H
 *=========================================================================*/
