/*===========================================================================
 *
 * File:	Mwranduniques.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, May 23, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWRANDUNIQUES_H
#define __MWRANDUNIQUES_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "MwRandEffects.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Number of effects allowed per unique */
  #define MWRU_MAX_EFFECTS 6

	/* Type of name generations */
  #define MWRU_NAMETYPE_EXACT  0
  #define MWRU_NAMETYPE_SUFFIX 1
  #define MWRU_NAMETYPE_PREFIX 2 

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* The unique item data */
  typedef struct {
	char  Name[MWRI_MAX_NAMESIZE+1];	/* Unique item name/suffix/prefix */
	int   NameType;				/* Type of name generation */
	long  ItemMask;				/* Bitmask indicating which items are allowed */
	int   ItemLevel;			/* Basic level of unique item (higher levels will be rarer) */
	char  Model[MWRI_MAX_NAMESIZE+1];	/* Optional unique model/picture for the item */
	char  Icon[MWRI_MAX_NAMESIZE+1];

	mwrand_effect_t* pEffects[MWRU_MAX_EFFECTS];	/* Effect data */
	int		 NumEffects;
   } mwru_unique_t;

	/* Array of unique pointers */
  typedef TPtrArray<mwru_unique_t> CMwRandUniqueArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwRandUniques Definition
 *
 * Description
 *
 *=========================================================================*/
class CMwRandUniques {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CMwRandUniqueArray	m_UniqueArray;	/* Array of unique records */
  CMwRandEffects*	m_pEffects;	/* Reference to effects object */
  long			m_InputLine;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Attempt to add an effect to the unique item */
  bool AddEffect (mwru_unique_t* pNewUnique, const TCHAR* pEffectName);

	/* Input unique record data from a text file */
  bool ReadUnique (CGenFile& File, mwru_unique_t* pNewUnique);
  bool ReadUnique (CGenFile& File);

  	/* Set unique parameters from string values */
  bool SetUniqueParam (mwru_unique_t* pNewUnique, const TCHAR* pVariable, const TCHAR* pValue);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwRandUniques();
  virtual ~CMwRandUniques() { Destroy(); }
  virtual void Destroy (void);

  	/* Get class members */
  int		 GetNumUniques (void)		 { return (m_UniqueArray.GetNumElements()); }
  mwru_unique_t* GetUnique     (const int Index) { return (m_UniqueArray.GetAt(Index)); }

	/* Read unique data file */
  bool ReadUniqueFile (const TCHAR* pFilename);

	/* Set class methods */
  void SetEffects (CMwRandEffects* pEffects) { m_pEffects = pEffects; }

 };
/*===========================================================================
 *		End of Class CMwRandUniques Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Initialize an unique structure */
  void DefaultMwRandUnique (mwru_unique_t& UniqueItem);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/




#endif
/*===========================================================================
 *		End of File Mwranduniques.H
 *=========================================================================*/
