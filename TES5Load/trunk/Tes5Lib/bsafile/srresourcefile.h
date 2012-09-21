/*===========================================================================
 *
 * File:		Srresourcefile.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrResourceFile class for a single resource file.
 *
 *=========================================================================*/
#ifndef __SRRESOURCEFILE_H
#define __SRRESOURCEFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srresourcebase.h"
  #include "srresourceinstance.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definition */
  class CSrResourceFolder;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrResourceFile Definition
 *
 *=========================================================================*/
class CSrResourceFile : public CSrResourceBase {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrRefResourceInstanceArray	m_Instances;
  int							m_ResourceType;
  
  CSrResourceFolder*			m_pParent;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrResourceFile();
  virtual ~CSrResourceFile() { Destroy(); }
  virtual void Destroy (void);

  	/* Add a new instance */
  CSrResourceInstance* AddInstance (CSrBsaFileRecord* pRecord);
  CSrResourceInstance* AddInstance (const char* pFilename);

	/* Abstract methods */
  virtual bool IsFolder (void) const { return (false); }

	/* Get class members */
  CSrResourceInstanceArray& GetInstances    (void) { return (m_Instances); }
  dword                     GetNumInstances (void) { return (m_Instances.GetSize()); }
  CSrResourceInstance*	    GetMainInstance (void) { return (m_Instances.GetAt(0)); }
  CSrResourceFolder*        GetParent       (void) { return (m_pParent); }
  const char*               GetBasePath     (void);
  int64						GetFilesize     (void);
  dword64					GetFiletime     (void);
  int						GetResourceType (void) { return (m_ResourceType); }

	/* Get the full filename of the resource */
  const char* GetFullName (void);
  const char* GetCSName   (void);

	/* Checks if the resource is in the given path or not */
  bool IsInPath (const char* pPath);
  
	/* Set which resource instance is the main one */
  void SetMainInstances (CSrResourceInstance* pInstance);

	/* Set class members */
  void SetParent (CSrResourceFolder* pFolder) { m_pParent = pFolder; }

};
/*===========================================================================
 *		End of Class CSrResourceFile Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srresourcefile.H
 *=========================================================================*/
