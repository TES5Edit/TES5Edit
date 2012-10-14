/*===========================================================================
 *
 * File:		SrBackup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 February 2012
 *
 * Contains various functions and definitions for backin up files.
 *
 *=========================================================================*/
#ifndef __SRBACKUP_H
#define __SRBACKUP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
#include "srfile.h"
#include "srlogfile.h"
#include "textutils.h"
#include "srcallback.h"
#include "srarray.h"
#include "srptrarray.h"
#include "srtime.h"
#include "srutils.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/  


/*===========================================================================
 *
 * Begin srbackupoptions_t Definition
 *
 *=========================================================================*/
struct srbackupoptions_t 
{
	bool		EnableBackup;

	bool		EnableBackupOnSave;
	int			MaxBackupCount;
	int			MaxBackupSizeMB;
	CSString	BackupPath;
	CSString	FullBackupPath;

	bool		EnableAutoBackup;
	int			AutoBackupTime;

	srbackupoptions_t() 
	{
		BackupPath     = "backup\\";
		EnableBackup   = true;

		EnableBackupOnSave = true;
		MaxBackupCount     = 0;
		MaxBackupSizeMB    = 0;

		EnableAutoBackup   = false;
		AutoBackupTime     = 10;
	}
};
/*===========================================================================
 *		End of srbackupoptions_t Definition
 *=========================================================================*/  


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
	bool SrCheckBackups (const char* OldestFile, const dword BackupCount, const int64 BackupSize);
	bool SrMakeBackupFile (CSString& OutputFile, CSString& InputFile);
	bool SrMakeBackupFilePath (CSString& OutputFile, const CSString InputFile);
	bool SrCreateBackupPath (void);
	bool SrCreateBackupPath (const char* pFilename);
	bool SrBackupFile (const SSCHAR* pFilename);	
	bool SrBackupFilePath (const SSCHAR* pFilename);
	bool SrDoSavePluginBackup (const SSCHAR* pFilename, const bool IsLoadLocalString);
/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Prototypes
 *
 *=========================================================================*/
	extern srbackupoptions_t g_SrBackupOptions;
/*===========================================================================
 *		End of External Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBackup.H
 *=========================================================================*/
