/*===========================================================================
 *
 * File:		Sritem1record.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrItem1Record class for records with:
 *
 *	FULL - Item Name
 *	MODL - Model filename
 *	ICON - ICON filename
 *	SCRI - Script
 *
 *=========================================================================*/
#ifndef __SRSTRINGFILE_H
#define __SRSTRINGFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../common/srfile.h"
  #include "../modfile/srmoddefs.h"
  #include "../common/srarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

  typedef TGenRefPtrMap<srlstringid_t, CSString, srlstringid_t> CSrStringFileMap;

  #define SR_STRING_HEADERSIZE 8
  #define SR_STRING_DIRENTRYSIZE 8

	struct srstringrecord_h
	{
		srlstringid_t	ID;
		CSString		String;
		dword			Offset;
	};
	
	typedef TSrArray<srstringrecord_h> CSrStringArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrItem1Record Definition
 *
 * Holds enchantment data.
 *
 *=========================================================================*/
class CSrStringFile
{
protected:
	CSString		m_Filename;
	CSrStringArray	m_Strings;
	bool			m_IsBStringFile;


	virtual bool ReadDirectory    (CSrFile& File);
	virtual bool ReadStrings      (CSrFile& File);
	virtual bool ReadBStrings     (CSrFile& File);
	virtual bool ReadBStringsFast (CSrFile& File);
	virtual bool ReadStringsFast  (CSrFile& File);

	bool WriteDirectory(CSrFile& File);
	bool WriteStrings(CSrFile& File);
	bool WriteBStrings(CSrFile& File);

public:

	CSrStringFile();
	virtual ~CSrStringFile() { Destroy(); }

	virtual void Destroy (void);

	void Add (const srlstringid_t ID, const CSString String);

	void Dump (void);

	CSrStringArray& GetStrings    (void) { return m_Strings; }
	bool            IsBStringFile (void) { return m_IsBStringFile; }
	CSString        GetFilename   (void) { return m_Filename; }

	virtual bool Load (const SSCHAR* pFile);
	virtual bool Save (const SSCHAR* pFile, const SSCHAR* pExtension);

};

	typedef TSrArray<CSrStringFile> CSrStringFileArray;
/*===========================================================================
 *		End of Class CSrStringFile Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrStringFile.H
 *=========================================================================*/
