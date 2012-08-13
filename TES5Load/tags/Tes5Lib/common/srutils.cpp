/*===========================================================================
 *
 * File:	Srutils.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srutils.h"
#include "windows.h"


CSString g_SrManualInstallPath("");
CSString g_SrLanguage("English");


/*===========================================================================
 *
 * Function - bool GetSrInstallPath (Buffer);
 *
 * Attempt to find Skyrim's install path in the registry. On success true
 * is returned and the path copied to the given buffer. On error false is
 * returned.
 *
 * HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Bethesda Softworks\Skyrim
 *
 *=========================================================================*/
bool GetSrInstallPath (CSString& OutputBuffer) 
{
  HKEY  hKey;
  BYTE  Buffer[300];
  DWORD Size = 256;
  DWORD Type;
  int   Result;

		/* Use the manual install path if set */
  if (!g_SrManualInstallPath.IsEmpty())
  {
	  OutputBuffer = g_SrManualInstallPath;
	  return true;
  }

  OutputBuffer.Empty();
  Result = RegOpenKeyEx(HKEY_LOCAL_MACHINE, SR_REG_SUBKEY, 0, KEY_READ, &hKey);

  if (Result != ERROR_SUCCESS) 
  {
	  Result = RegOpenKeyEx(HKEY_LOCAL_MACHINE, SR_REG_SUBKEY64, 0, KEY_READ, &hKey);

	  if (Result != ERROR_SUCCESS)
	  {
		AddSrGeneralError("Failed to find Skyrim's install path in the Windows registry!");
		return (false);
	  }
  }

  Result = RegQueryValueEx(hKey, SR_REG_INSTALLPATH, NULL, &Type, Buffer, &Size);

  if (Result == ERROR_SUCCESS && Type == REG_SZ) 
  {
    OutputBuffer = (char *)Buffer;
  }
  else 
  {
    AddSrGeneralError("Failed to find Skyrim's install path in the Windows registry!");
    RegCloseKey(hKey);
    return (false);
  }
     
  RegCloseKey(hKey);
  return (true);
}
/*===========================================================================
 *		End of Function GetSrInstallPath()
 *=========================================================================*/


CSString CreateSrStringFilename (const char* pFilename, const char* pExtension)
{
	CSString	  BaseFilename(pFilename);
	CSString	  Pathname(pFilename);
	CSString	  Extension(pExtension);
	CSString	  Filename;
	int           Index;

	Index = Pathname.FindCharR('\\');

	if (Index > 0) 
	{
		Pathname.Truncate(Index);
		Pathname += "\\";
		BaseFilename.Delete(0, Index+1);
	}
	else
	{
		Pathname.Empty();
	}

	Pathname += "Strings\\";

	Index = BaseFilename.FindCharR('.');
	if (Index > 0) BaseFilename.Truncate(Index);

	Filename = Pathname + BaseFilename;
	Filename += "_" + g_SrLanguage + "." + Extension;
	
	return Filename;
}


CSString CreateSrStringPathname (const char* pFilename)
{
	CSString	Pathname(pFilename);
	int			Index;

	Index = Pathname.FindCharR('\\');

	if (Index > 0) 
	{
		Pathname.Truncate(Index);
		Pathname += "\\";
	}
	else
	{
		Pathname.Empty();
	}

	Pathname += "Strings\\";
	return Pathname;
}



void RemoveExtensionString(CSString& Filename)
{
	const char* pParse = Filename.c_str();
	int Index = Filename.GetLength() - 1;

	while (Index >= 0)
	{
		if (pParse[Index] == '.')
		{
			Filename.Truncate(Index);
			return;
		}
		else if (pParse[Index] == '\\' || pParse[Index] == '/' || pParse[Index] == ':')
		{
			return;
		}

		--Index;
	}

}


bool SplitFilenameString_Priv (const char* pFilename, const size_t Length, CSString& Path, CSString& BaseFilename, CSString& Extension)
{
	const char* pParse = pFilename;
	int Index = Length - 1;
	int ExtensionIndex;
	
	Extension.Empty();
	BaseFilename.Empty();
	Path.Empty();

	if (Length == 0) return true;

	while (Index >= 0)
	{
		if (pParse[Index] == '.')
		{
			Extension = pParse + Index + 1;
			ExtensionIndex = Index;
			break;
		}
		else if (pParse[Index] == '\\' || pParse[Index] == '/' || pParse[Index] == ':')
		{
			ExtensionIndex = Length;
			Extension.Empty();
			break;
		}

		--Index;
	}

	while (Index >= 0)
	{
		if (pParse[Index] == '\\' || pParse[Index] == '/' || pParse[Index] == ':')
		{
			BaseFilename = pParse + Index + 1;
			BaseFilename.Truncate(ExtensionIndex - Index - 1);
			Path.Copy(pFilename, Index + 1);
			return true;
		}

		--Index;
	}

	BaseFilename.Copy(pFilename, ExtensionIndex - Index - 1);
	return true;
}


bool SplitFilenameString (const char* pFilename, CSString& Path, CSString& BaseFilename, CSString& Extension)
{
	return SplitFilenameString_Priv(pFilename, strlen(pFilename), Path, BaseFilename, Extension);
}


bool SplitFilenameString (const CSString Filename, CSString& Path, CSString& BaseFilename, CSString& Extension)
{
	return SplitFilenameString_Priv(Filename, Filename.GetLength(), Path, BaseFilename, Extension);
}


bool SrFindSubDataPath (const char* pFilename, CSString& OutputPath, CSString& OutputFilename, CSString& OutputExtension)
{
	CSString Path;
	int      Index;

	SplitFilenameString(pFilename, Path, OutputFilename, OutputExtension);

	Index = Path.FindRI("\\data\\");

	if (Index >= 0)
		++Index;
	else if (Index < 0 && Path.StartsWithI("data\\")) 
		Index = 0;

	if (Index < 0) 
	{
		OutputPath.Empty();
		return false;
	}

	OutputPath.Copy(Path.c_str() + Index + 5, Path.GetLength() - Index - 5);
	return true;
}


CSString CombinePaths(const char* pPath1, const char* pPath2)
{
	CSString ResultPath(pPath1);

	TerminatePathString(ResultPath);

	if (pPath2 != NULL)
	{
		if (pPath2[0] == '\\' || pPath2[0] == '/')
			ResultPath += pPath2 + 1;
		else
			ResultPath += pPath2;

		TerminatePathString(ResultPath);
	}	

	return ResultPath;
}