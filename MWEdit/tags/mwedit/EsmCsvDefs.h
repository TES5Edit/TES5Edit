/*===========================================================================
 *
 * File:	Esmcsvdefs.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 13, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCSVDEFS_H
#define __ESMCSVDEFS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "file/csvfile.h"
  #include "EsmDefs.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds extended CSV import/export column information */
  typedef struct {
	int	FieldID;
	long	UserData;
   } esmcsvcol_t;

	/* Holds information for importing/exporting a record type */
  typedef struct {
	const TCHAR* pEsmRecType;
	const TCHAR* pRecordName;
	int*	     pColArray;
	esmcsvcol_t* pExColArray;
   } esmcsvrecinfo_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Convert an input CSV item type to a regular item type string */
  const TCHAR*	GetEsmCsvRecordType	(const TCHAR* pString);
  const TCHAR*	GetEsmCsvRecordString	(const TCHAR* pString);
  int*		GetEsmCsvColArray	(const TCHAR* pType);
  esmcsvcol_t*  GetEsmCsvExColArray     (const TCHAR* pType);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Esmcsvdefs.H
 *=========================================================================*/
