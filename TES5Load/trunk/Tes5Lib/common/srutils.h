/*===========================================================================
 *
 * File:		SrUtils.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Various Skyrim related utility functions and definitions.
 *
 *=========================================================================*/
#ifndef __SRUTILS_H
#define __SRUTILS_H


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

		/* Windows Registry keys */
	#define SR_REG_SUBKEY       "SOFTWARE\\Bethesda Softworks\\Skyrim"
	#define SR_REG_SUBKEY64     "SOFTWARE\\Wow6432Node\\Bethesda Softworks\\Skyrim"
	#define SR_REG_INSTALLPATH  "Installed Path"

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

		/* Attempt to find the Skyrim install path in the registry */
	bool GetSrInstallPath (CSString& Buffer);
	
	CSString CreateSrStringFilename (const char* pFilename, const char* pExtension);
	CSString CreateSrStringPathname (const char* pFilename);

	bool SplitFilenameString (const CSString Filename, CSString& Path, CSString& BaseFilename, CSString& Extension);
	bool SplitFilenameString (const char* pFilename, CSString& Path, CSString& BaseFilename, CSString& Extension);
	void RemoveExtensionString(CSString& Filename);

	bool SrFindSubDataPath (const char* pFilename, CSString& OutputPath, CSString& OutputFilename, CSString& OutputExtension);
	CSString CombinePaths (const char* pPath1, const char* pPath2);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/
	extern CSString g_SrManualInstallPath;
	extern CSString g_SrLanguage;
/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrUtils.H
 *=========================================================================*/
