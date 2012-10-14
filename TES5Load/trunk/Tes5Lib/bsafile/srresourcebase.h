/*===========================================================================
 *	
 * File:		Srresourcebase.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrResourceBase base abstract class.
 *
 *=========================================================================*/
#ifndef __SRRESOURCEBASE_H
#define __SRRESOURCEBASE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "../common/srerrorhandler.h"
	#include "../common/srptrarray.h"
	#include "../common/sstring.h"
	#include "../common/SrBlockAllocator.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


	#define SR_RESOURCE_SCRIPTEXTENSION "psc"
	#define SR_RESOURCE_SCRIPTBASEPATH	"scripts\\source\\"

	class CSrScriptFile;
	struct srscriptinfo_t;

	class CSrResourceFolder;
	class CSrResourceFile;
	class CSrResourceScript;
	class CSrResourceCompiledScript;
	class CSrResourceInstance;


/*===========================================================================
 *
 * Begin Class CSrResourceBase Definition
 *
 *=========================================================================*/
class CSrResourceBase {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSString	m_Name;

  long		m_UserData;
  void*		m_pUserData;

  static TSrBlockAllocator<CSrResourceFolder>			CSrResourceFolderAllocator;
  static TSrBlockAllocator<CSrResourceFile>				CSrResourceFileAllocator;
  static TSrBlockAllocator<CSrResourceScript>			CSrResourceScriptAllocator;
  static TSrBlockAllocator<CSrResourceCompiledScript>	CSrResourceCompiledScriptAllocator;
  static TSrBlockAllocator<CSrResourceInstance>			CSrResourceInstanceAllocator;
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrResourceBase() { m_UserData = 0; m_pUserData = NULL; }
  virtual ~CSrResourceBase() { Destroy();  }
  virtual void Destroy (void) { m_Name.Empty();  }

  virtual CSrScriptFile*  GetScriptFile (void) { return NULL; }
  virtual srscriptinfo_t* GetScriptInfo (void) { return NULL; }

	/* Abstract methods */
  virtual bool IsFolder (void) const = 0;

  	/* Check the resource name */
  bool IsName (const char* pString) { return stricmp(m_Name, pString) == 0; }  

  bool IsScript (void)
  {
	  if (IsFolder()) return false;
	  if (!IsExtension(SR_RESOURCE_SCRIPTEXTENSION)) return false;

	  CSString FullName = GetFullName();
	  return (strnicmp(FullName, SR_RESOURCE_SCRIPTBASEPATH, strlen(SR_RESOURCE_SCRIPTBASEPATH)) == 0);
  }

  bool IsExtension (const char* pString)
  {
	  int Index = m_Name.FindCharR('.');
	  if (Index < 0) return false;
	  return stricmp(pString, m_Name.c_str() + Index + 1) == 0;
  }

  long	      GetUserData     (void) { return (m_UserData); }
  void*	      GetUserDataPtr  (void) { return (m_pUserData); }
  const char* GetName         (void) { return (m_Name); }

	/* Get the full filename with path for the resource */
  virtual const char* GetFullName (void) = 0;

	/* Set class members */
  void SetUserData    (const long    Value) { m_UserData  = Value; }
  void SetUserDataPtr (void*        pValue) { m_pUserData = pValue; }
  void SetName        (const char* pString) { m_Name      = pString; }

};

	/* Arrays of resources */
  typedef CSrPtrArray<CSrResourceBase>    CSrResourceArray;
  typedef CSrRefPtrArray<CSrResourceBase> CSrRefResourceArray;

/*===========================================================================
 *		End of Class CSrResourceBase Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srresourcebase.H
 *=========================================================================*/
