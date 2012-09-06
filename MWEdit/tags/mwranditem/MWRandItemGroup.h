/*===========================================================================
 *
 * File:	Mwranditemgroup.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	July 3, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWRANDITEMGROUP_H
#define __MWRANDITEMGROUP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "mwrandcom.h"
  #include "mwranditems.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default option values */
  #define MWRIG_DEFAULT_CREATELIST	true
  #define MWRIG_DEFAULT_CURSEDCHANCE	0.33f
  #define MWRIG_DEFAULT_PREFIXCHANCE	0.25f
  #define MWRIG_DEFAULT_SUFFIXCHANCE	0.50f
  #define MWRIG_DEFAULT_UNIQUECHANCE	0.25f	
  #define MWRIG_DEFAULT_CHANCENONE	10.0f	
  #define MWRIG_DEFAULT_RANDOMBELL	50.0f
  #define MWRIG_DEFAULT_ITEMMASK	MWRI_ITEMMASK_ALL
  #define MWRIG_DEFAULT_MINLEVEL	1
  #define MWRIG_DEFAULT_MAXLEVEL	100
  #define MWRIG_DEFAULT_NUMITEMS	100

  #define MWRIG_MAX_SCRIPTFILES		16

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Basic data for a single group */	
  class mwri_group_t {
    public:
  	TCHAR IDPrefix[MWRI_MAX_NAMESIZE+1];
	int   IDType;

	int   MinLevel;
	int   MaxLevel;
	bool  UseBell;
	float RandomBell;
  	int   NumItems;
	bool  CreateLevelLists;
	bool  MakePHLists;
	bool  UseListID;
	TCHAR ListID[MWRI_MAX_NAMESIZE+1];
	TCHAR PHListID[MWRI_MAX_NAMESIZE+1];

	bool  OutputScript;
	bool  OutputScriptRecord;
	TCHAR ScriptFile[MWRI_MAX_NAMESIZE+1];

	float ChanceNone;
	
	bool  RemoveDuplicates;
	int   ItemMask;
	float PrefixChance;
	float SuffixChance;
	float UniqueChance;
	float CursedChance;

	bool  UseScriptNames;
	TCHAR InstallScript[MWRI_MAX_NAMESIZE+1];
	TCHAR UninstallScript[MWRI_MAX_NAMESIZE+1];

	TCHAR BaseItems[_MAX_PATH+1];
	TCHAR Effects[_MAX_PATH+1];
	TCHAR Uniques[_MAX_PATH+1];
	TCHAR LevelLists[_MAX_PATH+1];
   };

  typedef struct {
    	TCHAR Filename[_MAX_PATH+1];
   } mwri_espfile_t;
  

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwRandItemGroup Definition
 *
 * Holds basic information from a group file.
 *
 *=========================================================================*/
class CMwRandItemGroup {

  /*---------- Begin Private Class Members ----------------------*/
private:
  mwri_group_t		m_GroupData;		/* Basic group data */
  int			m_InputLine;

  mwri_espfile_t	m_EspFiles[MWRIG_MAX_SCRIPTFILES];
  int			m_NumEspFiles;
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwRandItemGroup();
  virtual ~CMwRandItemGroup() { Destroy(); }
  virtual void Destroy (void);

	/* Attempt to add an esp file to the group data */
  bool AddEspFile (const TCHAR* pFilename);

	/* Get class members */
  mwri_group_t*   GetGroup       (void) { return (&m_GroupData); }
  mwri_espfile_t* GetEspFiles    (void) { return (m_EspFiles); }
  int		  GetNumEspFiles (void) { return (m_NumEspFiles); }
  bool		  IsValidEspFile (const int Index) { return (Index >= 0 && Index < m_NumEspFiles); }
  const TCHAR*    GetEspFile     (const int Index) { return (IsValidEspFile(Index) ? m_EspFiles[Index].Filename : NULL); }

	/* Attempt to load/save a group file */
  bool Load (const TCHAR* pFilename);
  bool Save (const TCHAR* pFilename);

	/* Sets a group parameter */
  bool SetParameter (const TCHAR* pVariable, const TCHAR* pValue);


 };
/*===========================================================================
 *		End of Class CMwRandItemGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

  void DefaultMWRandItemGroupOptions (mwri_group_t& Group);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


	
#endif
/*===========================================================================
 *		End of File Mwranditemgroup.H
 *=========================================================================*/
