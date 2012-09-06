/*===========================================================================
 *
 * File:	Esmscrfuncarray.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 2, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRFUNCARRAY_H
#define __ESMSCRFUNCARRAY_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmScrFuncData.h"
  #include "contain/PtrArray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default data file */
  #define MWESM_SFDATA_DEFAULTFILE _T("Functions.dat")

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Array of function definition objects */
  typedef TPtrArray<CEsmScrFuncData> CEsmSFDataArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrFuncArray Definition
 *
 * Holds an array of string function definitions
 *
 *=========================================================================*/
class CEsmScrFuncArray {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CEsmSFDataArray	m_Functions;		/* Function definition array */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input function data from the file */
  bool ReadFunction (CGenFile& File, const TCHAR* pFuncName);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmScrFuncArray();
  virtual ~CEsmScrFuncArray() { Destroy(); }
  virtual void Destroy (void);

	/* Find and return a function record */
  CEsmScrFuncData* FindFunction (const TCHAR* pName);

	/* Get class members */
  int              GetCount     (void)            { return (m_Functions.GetNumElements()); }
  CEsmScrFuncData* GetFunction  (const int Index) { return (m_Functions.GetAt(Index)); }
  bool		   IsValidIndex (const int Index) { return (m_Functions.IsValidIndex(Index)); }

	/* Load a function data file */
  bool LoadDefault (void) { return Load(MWESM_SFDATA_DEFAULTFILE); }
  bool Load (const TCHAR* pFilename);
  bool Read (CGenFile& File);


 };
/*===========================================================================
 *		End of Class CEsmScrFuncArray Definition
 *=========================================================================*/




#endif
/*===========================================================================
 *		End of File Esmscrfuncarray.H
 *=========================================================================*/
