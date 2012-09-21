/*===========================================================================
 *
 * File:		Srresourceinstance.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrResourceInstance class
 *
 *=========================================================================*/
#ifndef __SRRESOURCEINSTANCE_H
#define __SRRESOURCEINSTANCE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srbsafile.h"
  #include "../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

		/* Resource types */
	#define SR_RESOURCETYPE_UNKNOWN			0
	#define SR_RESOURCETYPE_TEXT			1
	#define SR_RESOURCETYPE_HTML			2
	#define SR_RESOURCETYPE_XML				3
	#define SR_RESOURCETYPE_IMAGE			4
	#define SR_RESOURCETYPE_NIF				5
	#define SR_RESOURCETYPE_SOUND			6
	#define SR_RESOURCETYPE_SCRIPT			7
	#define SR_RESOURCETYPE_COMPILEDSCRIPT	8

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definitions */
  class CSrResourceFile;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrResourceInstance Definition
 *
 *=========================================================================*/
class CSrResourceInstance 
{

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrBsaFileRecord*	m_pBsaRecord;		/* Parent record if in a BSA file */

  CSString		m_Filename;			/* Just the filename for a non-BSA file */
  CSString		m_FullFilename;		/* Complete path+filename for a non-BSA file */

  int64			m_Filesize;
  bool			m_HasFilesize;

  dword64		m_Filetime;
  bool			m_HasFiletime;

  CSrResourceFile*	m_pParent;

  long			m_UserData;
  void*			m_pUserData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	

  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrResourceInstance();
  virtual ~CSrResourceInstance() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  CSrBsaFileRecord* GetBsaRecord       (void) { return (m_pBsaRecord); }
  const char*       GetFilename        (void);
  const char*       GetFullFilename    (void);
  const char*       GetFullFilenameAbs (void);
  CSrResourceFile*  GetParent          (void) { return (m_pParent); }
  const char*       GetBasePath        (void);

	/* Determine the type of the resource */
  int GetResourceType (void);

  bool	HasFilesize (void) const { return (m_HasFilesize); }
  bool	HasFiletime (void) const { return (m_HasFiletime); }

	/* Get the filesize/time of a resource */
  bool    GetFilesize (int64& Filesize);
  int64   GetFilesize (void);
  bool    GetFiletime (dword64& Filetime);
  dword64 GetFiletime (void);

	/* Set class members */
  void SetBsaRecord (CSrBsaFileRecord* pRecord) { m_pBsaRecord = pRecord; }
  void SetFilename  (const char*       pString);
  void SetParent    (CSrResourceFile*    pFile) { m_pParent = pFile; }
  void SetFilesize  (const int64          Size) { m_Filesize = Size; m_HasFilesize = true; }
  void SetFiletime  (const dword64        Time) { m_Filetime = Time; m_HasFiletime = true; }

  void SetFilesize  (const dword Low, const dword High) { 
	m_Filesize    = (int64) (((dword64)Low) | ((dword64)High)<<32);
	m_HasFilesize = true; }

  void SetFiletime  (const dword Low, const dword High) { 
	m_Filetime    = (dword64) (((dword64)Low) | ((dword64)High)<<32);
	m_HasFiletime = true; }
    
	/* Update the filesize of the resource instance */
  bool UpdateFileInfo (void);

};


	/* Arrays of resource instances */
  typedef CSrPtrArray<CSrResourceInstance>     CSrResourceInstanceArray;
  typedef CSrRefPtrArray<CSrResourceInstance>  CSrRefResourceInstanceArray;

/*===========================================================================
 *		End of Class CSrResourceInstance Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srresourceinstance.H
 *=========================================================================*/
