/*===========================================================================
 *
 * File:	Mwranditemgroup.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	July 3, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwranditemgroup.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwRandItemGroup.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Value-Name Arrays
 *
 *=========================================================================*/
valuenames_t l_IDTypes[] = {
	{ MWRID_IDTYPE_LONG,		_T("Long") },	
	{ MWRID_IDTYPE_SHORT4,		_T("Short4") },	
	{ MWRID_IDTYPE_SHORT8,		_T("Short8") },	
	{ -1,				NULL } 
 };
/*===========================================================================
 *		End of Value-Name Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGroup Constructor
 *
 *=========================================================================*/
CMwRandItemGroup::CMwRandItemGroup () {
  //DEFINE_FUNCTION("CMwRandItemGroup::CMwRandItemGroup()");
  DefaultMWRandItemGroupOptions(m_GroupData);
  m_InputLine   = 0;
  m_NumEspFiles = 0;
 }
/*===========================================================================
 *		End of Class CMwRandItemGroup Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGroup Method - void Destroy (void);
 *
 *=========================================================================*/
void CMwRandItemGroup::Destroy (void) {
  //DEFINE_FUNCTION("CMwRandItemGroup::Destroy()");
  m_InputLine   = 0;
  m_NumEspFiles = 0;
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGroup::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGroup Method - bool AddEspFile (pFilename);
 *
 *=========================================================================*/
bool CMwRandItemGroup::AddEspFile (const TCHAR* pFilename) {

	/* Ensure we don't exceed the array limits */
  if (m_NumEspFiles >= MWRIG_MAX_SCRIPTFILES) {
    ErrorHandler.AddError(ERR_MAXINDEX, "Exceeded the maximum of %d ESP files!", m_NumEspFiles);
    return (false);
   }

  strnncpy(m_EspFiles[m_NumEspFiles].Filename, pFilename, _MAX_PATH);
  m_NumEspFiles++;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGroup::AddEspFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGroup Method - bool Load (pFilename);
 *
 * Attempt to load and parse a group file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGroup::Load (const TCHAR* pFilename) {
  TCHAR    LineBuffer[MWRI_MAX_LINELENGTH+1];
  TCHAR*   pVariable;
  TCHAR*   pValue;
  CGenFile File;
  bool	   Result;
  int      ReadResult;
 
	/* Attempt to open file for input */
  Result = File.Open(pFilename, "rt");
  if (!Result) return (false);

  Destroy();
  DefaultMWRandItemGroupOptions(m_GroupData);

  	/* Input until end of file or end of effect */
  while (!File.IsEOF()) {

		/* Input a single line of text from the file */
    ReadResult = File.ReadLine(LineBuffer, MWRI_MAX_LINELENGTH);
    if (ReadResult == READLINE_MSL) ReadResult = File.ReadLine(); 
    if (ReadResult == READLINE_ERROR) return (false);
    m_InputLine++;

		/* Parse input, ignore comments, whitespace trim, etc... */
    Result = SeperateVarValueQ(&pVariable, &pValue, LineBuffer);
    if (Result) SetParameter(pVariable, pValue);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGroup::Load()
 *=========================================================================*/



/*===========================================================================
 *
 * Class CMwRandItemGroup Method - bool Save (pFilename);
 *
 * Attempt to save the group data to the given file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandItemGroup::Save (const TCHAR* pFilename) {
  CGenFile File;
  bool	   Result;
  int      Index;
 
	/* Attempt to open file for output */
  Result = File.Open(pFilename, "wt");
  if (!Result) return (false);

  File.Printf("BaseItems = \"%s\"\n", m_GroupData.BaseItems);
  File.Printf("Effects = \"%s\"\n", m_GroupData.Effects);
  File.Printf("Uniques = \"%s\"\n", m_GroupData.Uniques);
  File.Printf("LevelLists = \"%s\"\n", m_GroupData.LevelLists);
  File.Printf("IDPrefix = \"%s\"\n", m_GroupData.IDPrefix);
  File.Printf("IDType = %s\n", FindValueName(l_IDTypes, m_GroupData.IDType));
  File.Printf("MinLevel = %d\n", m_GroupData.MinLevel);
  File.Printf("MaxLevel = %d\n", m_GroupData.MaxLevel);
  File.Printf("NumItems = %d\n", m_GroupData.NumItems);
  File.Printf("UseBell = %s\n", BooleanToString(m_GroupData.UseBell));
  File.Printf("MakePHLists = %s\n", BooleanToString(m_GroupData.MakePHLists));
  File.Printf("UseListID = %s\n", BooleanToString(m_GroupData.UseListID));
  File.Printf("CreateLevelLists = %s\n", BooleanToString(m_GroupData.CreateLevelLists));
  File.Printf("OutputScript = %s\n", BooleanToString(m_GroupData.OutputScript));
  File.Printf("OutputScriptRecord = %s\n", BooleanToString(m_GroupData.OutputScriptRecord));
  File.Printf("RemoveDuplicates = %s\n", BooleanToString(m_GroupData.RemoveDuplicates));
  File.Printf("UseScriptNames = %s\n", BooleanToString(m_GroupData.UseScriptNames));
  File.Printf("ListID = \"%s\"\n", m_GroupData.ListID);
  File.Printf("PHListID = \"%s\"\n", m_GroupData.PHListID);
  File.Printf("ScriptFile = \"%s\"\n", m_GroupData.ScriptFile);
  File.Printf("InstallScript = \"%s\"\n", m_GroupData.InstallScript);
  File.Printf("UninstallScript = \"%s\"\n", m_GroupData.UninstallScript);
  File.Printf("ItemMask = %s\n", MwRandItemMaskToShortString(m_GroupData.ItemMask));
  File.Printf("RandomBell = %g\n", m_GroupData.RandomBell);
  File.Printf("ChanceNone = %g\n", m_GroupData.ChanceNone);
  File.Printf("PrefixChance = %g\n", m_GroupData.PrefixChance);
  File.Printf("SuffixChance = %g\n", m_GroupData.SuffixChance);
  File.Printf("UniqueChance = %g\n", m_GroupData.UniqueChance);
  File.Printf("CursedChance = %g\n", m_GroupData.CursedChance);

  for (Index = 0; Index < m_NumEspFiles; Index++) {
    File.Printf("ESPFile = \"%s\"\n", m_EspFiles[Index].Filename);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGroup::Save()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandItemGroup Method - bool SetParameter (pVariable, pValue);
 *
 *=========================================================================*/
bool CMwRandItemGroup::SetParameter (const TCHAR* pVariable, const TCHAR* pValue) {
  int  iResult;
  bool Result;

  if (TSTRICMP(pVariable, _T("IDPrefix")) == 0) {
    strnncpy(m_GroupData.IDPrefix, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("BaseItems")) == 0) {
    strnncpy(m_GroupData.BaseItems, pValue, _MAX_PATH);
   }
  else if (TSTRICMP(pVariable, _T("Effects")) == 0) {
    strnncpy(m_GroupData.Effects, pValue, _MAX_PATH);
   }
  else if (TSTRICMP(pVariable, _T("Uniques")) == 0) {
    strnncpy(m_GroupData.Uniques, pValue, _MAX_PATH);
   }
  else if (TSTRICMP(pVariable, _T("LevelLists")) == 0) {
    strnncpy(m_GroupData.LevelLists, pValue, _MAX_PATH);
   }
  else if (TSTRICMP(pVariable, _T("IDType")) == 0) {
    iResult = FindNameValue(l_IDTypes, pValue);

    if (iResult >= 0)
      m_GroupData.IDType = iResult;
    else
      SystemLog.Printf("\t%5ld: Unknown ID type '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("MinLevel")) == 0) {
    m_GroupData.MinLevel = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("MaxLevel")) == 0) {
    m_GroupData.MaxLevel = atoi(pValue);
   }
  else if (TSTRICMP(pVariable, _T("UseBell")) == 0) {
    Result = StringToBoolean(m_GroupData.UseBell, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown UseBell boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("RandomBell")) == 0) {
    m_GroupData.RandomBell = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("NumItems")) == 0) {
    m_GroupData.NumItems = atoi(pValue);
    if (m_GroupData.NumItems <= 0) m_GroupData.NumItems = 1;
   }
  else if (TSTRICMP(pVariable, _T("CreateLevelLists")) == 0) {
    Result = StringToBoolean(m_GroupData.CreateLevelLists, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown CreateLevelLists boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("MakePHLists")) == 0) {
    Result = StringToBoolean(m_GroupData.MakePHLists, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown MakePHLists boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("UseListID")) == 0) {
    Result = StringToBoolean(m_GroupData.UseListID, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown UseListID boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("OutputScript")) == 0) {
    Result = StringToBoolean(m_GroupData.OutputScript, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown OutputScript boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("OutputScriptRecord")) == 0) {
    Result = StringToBoolean(m_GroupData.OutputScriptRecord, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown OutputScriptRecord boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("RemoveDuplicates")) == 0) {
    Result = StringToBoolean(m_GroupData.RemoveDuplicates, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown RemoveDuplicates boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("UseScriptNames")) == 0) {
    Result = StringToBoolean(m_GroupData.UseScriptNames, pValue);
    if (!Result) SystemLog.Printf("\t%5ld: Unknown UseScriptNames boolean value '%s'!", m_InputLine, pValue);
   }
  else if (TSTRICMP(pVariable, _T("ListID")) == 0) {
    strnncpy(m_GroupData.ListID, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("PHListID")) == 0) {
    strnncpy(m_GroupData.PHListID, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("ScriptFile")) == 0) {
    strnncpy(m_GroupData.ScriptFile, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("InstallScript")) == 0) {
    strnncpy(m_GroupData.InstallScript, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("UninstallScript")) == 0) {
    strnncpy(m_GroupData.UninstallScript, pValue, MWRI_MAX_NAMESIZE);
   }
  else if (TSTRICMP(pVariable, _T("ItemMask")) == 0) {
    m_GroupData.ItemMask = ShortStringToMwRandItemMask(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ChanceNone")) == 0) {
    m_GroupData.ChanceNone = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("PrefixChance")) == 0) {
    m_GroupData.PrefixChance = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("SuffixChance")) == 0) {
    m_GroupData.SuffixChance = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("UniqueChance")) == 0) {
    m_GroupData.UniqueChance = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("CursedChance")) == 0) {
    m_GroupData.CursedChance = (float) atof(pValue);
   }
  else if (TSTRICMP(pVariable, _T("ESPFile")) == 0) {

    if (m_NumEspFiles >= MWRIG_MAX_SCRIPTFILES) {
      SystemLog.Printf("\t%5ld: Exceeded the maximum of %d ESP files!", m_InputLine, m_NumEspFiles);
     }
    else {
      strnncpy(m_EspFiles[m_NumEspFiles].Filename, pValue, _MAX_PATH);
      m_NumEspFiles++;
     }
   }
  else {
    SystemLog.Printf("\t%5ld: Unknown group parameter '%s'!", m_InputLine, pVariable);
    return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandItemGroup::SetParameter()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultMWRandItemGroupOptions (Group);
 *
 *=========================================================================*/
void DefaultMWRandItemGroupOptions (mwri_group_t& Group) { 
  Group.CreateLevelLists = MWRIG_DEFAULT_CREATELIST;
  Group.CursedChance = MWRIG_DEFAULT_CURSEDCHANCE;
  Group.PrefixChance = MWRIG_DEFAULT_PREFIXCHANCE;
  Group.SuffixChance = MWRIG_DEFAULT_SUFFIXCHANCE;
  Group.UniqueChance = MWRIG_DEFAULT_UNIQUECHANCE;
  Group.RandomBell   = MWRIG_DEFAULT_RANDOMBELL;
  Group.UseBell      = false;
  Group.UseListID    = false;
  Group.MakePHLists  = false;
  Group.OutputScript = false;
  Group.OutputScriptRecord = false;
  Group.UseScriptNames = false;
  Group.IDType       = MWRID_IDTYPE_LONG;
  Group.ChanceNone   = MWRIG_DEFAULT_CHANCENONE;
  Group.ItemMask = MWRIG_DEFAULT_ITEMMASK;
  Group.MinLevel = MWRIG_DEFAULT_MINLEVEL;
  Group.MaxLevel = MWRIG_DEFAULT_MAXLEVEL;
  Group.NumItems = MWRIG_DEFAULT_NUMITEMS;
  Group.IDPrefix[0] = NULL_CHAR;
  Group.ScriptFile[0] = NULL_CHAR;
  strnncpy(Group.InstallScript, _T("install_scr_01"), MWRI_MAX_NAMESIZE);
  strnncpy(Group.UninstallScript, _T("uninstall_scr_01"), MWRI_MAX_NAMESIZE);
  strnncpy(Group.ListID, _T("list_"), MWRI_MAX_NAMESIZE);
  strnncpy(Group.PHListID, _T("phlist_"), MWRI_MAX_NAMESIZE);
  strnncpy(Group.BaseItems, MWRIG_DEFAULTFILE_ITEM, _MAX_PATH);
  strnncpy(Group.Effects, MWRIG_DEFAULTFILE_EFFECT, _MAX_PATH);
  strnncpy(Group.Uniques, MWRIG_DEFAULTFILE_UNIQUE, _MAX_PATH);
  strnncpy(Group.LevelLists, MWRIG_DEFAULTFILE_LEVELLIST, _MAX_PATH);
 }
/*===========================================================================
 *		End of Function DefaultMWRandItemGroupOptions()
 *=========================================================================*/



