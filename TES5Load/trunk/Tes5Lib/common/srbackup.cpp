/*===========================================================================
 *
 * File:		SrBackup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	11 February 2012
 *
 * Implements various helper backup related functions.
 *
 *=========================================================================*/
#include "srbackup.h"
#include "windows.h"



/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

		/* Global backup options */
	srbackupoptions_t g_SrBackupOptions;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrCheckBackups (OldestFile, BackupCount, const int64 BackupSize);
 *
 *=========================================================================*/
bool SrCheckBackups (const char* OldestFile, const dword BackupCount, const int64 BackupSize) 
{
	BOOL Result;
	bool Delete = false;
  
	if (g_SrBackupOptions.MaxBackupCount > 0 && (int)BackupCount > g_SrBackupOptions.MaxBackupCount) 
	{
		Delete = true;
	}
	else if (g_SrBackupOptions.MaxBackupSizeMB > 0 && BackupSize/1000000 > g_SrBackupOptions.MaxBackupSizeMB) 
	{
		Delete = true;
	}

	if (Delete) 
	{
		Result = DeleteFile(OldestFile);
		if (!Result) return AddSrWindowsError("Failed to delete the old backup file '%s'!", OldestFile);
		SystemLog.Printf("Deleted old backup file '%s'.", OldestFile);
	}
  
	return (true);
}
/*===========================================================================
 *		End of Function SrCheckBackups()
 *=========================================================================*/


void SrFindUnusedBackupFile_Priv (CSString& OutputFile)
{
	WIN32_FIND_DATA FindData;
	CSString		OldestFile;
	FILETIME		OldestTime;
	CSString		Filename;
	CSString		Buffer;
	HANDLE			hFind;
	BOOL			Result;
	int				MaxBackupIndex = 0;
	int				BackupIndex;
	dword			BackupCount = 0;
	int64			BackupSize  = 0;

	Filename  = OutputFile + ".*";

		/* Find the maximum existing backup index of the current backup file */
	hFind  = FindFirstFile(Filename, &FindData);
	Result = TRUE;
	
	while (hFind != INVALID_HANDLE_VALUE && Result) 
	{
		Filename = FindData.cFileName;

		Filename.ReverseTruncateAtR('.'); 
		
		BackupIndex = atoi(Filename);
		if (BackupIndex > MaxBackupIndex) MaxBackupIndex = BackupIndex;

		if (OldestFile.IsEmpty() || CompareFileTime(&OldestTime, &FindData.ftLastWriteTime) > 0) 
		{
			OldestFile = FindData.cFileName;
			OldestTime = FindData.ftLastWriteTime;
		}

		++BackupCount;
		BackupSize += (int64) FindData.nFileSizeLow;
		BackupSize += ((int64) FindData.nFileSizeHigh) << 32;
		Result = FindNextFile(hFind, &FindData);
	}

		/* See if we need to delete the oldest backup file */
	if (!OldestFile.IsEmpty()) 
	{
		CSString Path;
		CSString TmpFile;
		CSString TmpExt;

		SplitFilenameString(OutputFile, Path, TmpFile, TmpExt);

		Filename  = Path;
		Filename += OldestFile;
		SrCheckBackups(Filename, BackupCount, BackupSize);
	}
	
		/* Create the output filename */
	++MaxBackupIndex;
	Buffer.Format(".%03d", MaxBackupIndex);
	OutputFile += Buffer;
}


/*===========================================================================
 *
 * Function - bool SrMakeBackupFile (OutputFile, InputFile);
 *
 *=========================================================================*/
bool SrMakeBackupFile (CSString& OutputFile, CSString& InputFile) 
{
	CSString Filename;
	
	Filename = InputFile;
	Filename.ReverseTruncateAtR('\\');

	OutputFile  = g_SrBackupOptions.FullBackupPath;
	OutputFile += Filename;

	SrFindUnusedBackupFile_Priv(OutputFile);
	return true;
}
/*===========================================================================
 *		End of Function SrMakeBackupFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrMakeBackupFilePath (OutputFile, InputFile);
 *
 *=========================================================================*/
bool SrMakeBackupFilePath (CSString& OutputFile, const CSString InputFile) 
{
	CSString SubDataPath;
	CSString FullBackupPath;
	CSString Filename;
	CSString Extension;
	bool     Result;

	Result = SrFindSubDataPath(InputFile, SubDataPath, Filename, Extension);
	if (!Result) AddSrGeneralError("Failed to find the relative '\\data\\' path for '%s'!", InputFile.c_str());
	if (!Extension.IsEmpty()) Extension.Prepend('.');

	FullBackupPath = CombinePaths(g_SrBackupOptions.FullBackupPath, SubDataPath);
	OutputFile = FullBackupPath;
	OutputFile += Filename;
	OutputFile += Extension;

	SrFindUnusedBackupFile_Priv(OutputFile);
	return true;
}
/*===========================================================================
 *		End of Function SrMakeBackupFilePath()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrCreateBackupPath (void);
 *
 *=========================================================================*/
bool SrCreateBackupPath (void) 
{
	bool Result;
  
	Result = MakePathEx(g_SrBackupOptions.FullBackupPath);

	if (!Result) 
	{
		AddSrGeneralError("Failed to create the backup directory '%s'!", g_SrBackupOptions.FullBackupPath);
		return (false);
	}

	return (true);
}
/*===========================================================================
 *		End of Function SrCreateBackupPath()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrCreateBackupPath (const char* pFilename);
 *	
 *=========================================================================*/
bool SrCreateBackupPath (const char* pFilename) 
{
	CSString Filename;
	CSString Extension;
	CSString Path;
	bool     Result;

	SplitFilenameString(pFilename, Path, Filename, Extension);
	Result = MakePathEx(Path);

	if (!Result) 
	{
		AddSrGeneralError("Failed to create the backup directory '%s'!", g_SrBackupOptions.FullBackupPath);
		return (false);
	}

	return (true);
}
/*===========================================================================
 *		End of Function SrCreateBackupPath()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrBackupFile (pFilename);
 *
 *=========================================================================*/
bool SrBackupFile (const SSCHAR* pFilename) 
{
	CSString InputFile;
	CSString OutputFile;
	bool     Result;
	BOOL     CopyResult;

		/* Ignore if the file doesn't yet exist */
	InputFile = pFilename;
	if (!FileExists(InputFile)) return true;

	Result = SrMakeBackupFile(OutputFile, InputFile);
	if (!Result) return false;

	Result = SrCreateBackupPath();
	if (!Result) return false;

	CopyResult = CopyFile(InputFile, OutputFile, FALSE);
	if (!CopyResult) return AddSrWindowsError("Failed to backup '%s' to '%s'!", InputFile, OutputFile);

	SystemLog.Printf("Successfully backed up '%s' to '%s'", InputFile, OutputFile);
	return true;
}
/*===========================================================================
 *		End of Function SrBackupFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrBackupFilePath (pFilename);
 *
 *=========================================================================*/
bool SrBackupFilePath (const SSCHAR* pFilename) 
{
	CSString InputFile;
	CSString OutputFile;
	bool     Result;
	BOOL     CopyResult;

		/* Ignore if the file doesn't yet exist */
	InputFile = pFilename;
	if (!FileExists(InputFile)) return true;

	Result = SrMakeBackupFilePath(OutputFile, InputFile);
	if (!Result) return false;

	Result = SrCreateBackupPath(OutputFile);
	if (!Result) return false;

	CopyResult = CopyFile(InputFile, OutputFile, FALSE);
	if (!CopyResult) return AddSrWindowsError("Failed to backup '%s' to '%s'!", InputFile, OutputFile);

	SystemLog.Printf("Successfully backed up '%s' to '%s'", InputFile, OutputFile);
	return true;
}
/*===========================================================================
 *		End of Function SrBackupFilePath()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrDoSavePluginBackup (pFilename, IsLoadLocalString);
 *
 *=========================================================================*/
bool SrDoSavePluginBackup (const SSCHAR* pFilename, const bool IsLoadLocalString) 
{
	bool Result;

		/* Are backups enabled? */
	if (!g_SrBackupOptions.EnableBackup)       return (true);
	if (!g_SrBackupOptions.EnableBackupOnSave) return (true);

		/* Main plugin backup */
	Result = SrBackupFile(pFilename);
	if (!Result) return false;

		/* Do string file backup only if required */
	if (IsLoadLocalString)
	{
		Result  = SrBackupFilePath(CreateSrStringFilename(pFilename, "ILSTRINGS"));
		Result &= SrBackupFilePath(CreateSrStringFilename(pFilename, "DLSTRINGS"));
		Result &= SrBackupFilePath(CreateSrStringFilename(pFilename, "STRINGS"));
		return Result;
	}

	return true;
}
/*===========================================================================
 *		End of Function SrDoSavePluginBackup()
 *=========================================================================*/