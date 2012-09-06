/*===========================================================================
 *
 * File:	Esmgloboptions.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 7, 2003
 *
 * Defines the functions for accessing the various MWEdit options.
 *
 *=========================================================================*/
#ifndef __ESMGLOBOPTIONS_H
#define __ESMGLOBOPTIONS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmOptionsDef.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
  

  bool	GetEsmOptNoScriptFormat       (void);
  bool  GetEsmOptBackupSaves          (void);
  bool  GetEsmOptNoScriptPrompt       (void);
  bool  GetEsmOptAllowExtFuncs	      (void);
  bool  GetEsmOptUseExtraFile	      (void);
  bool  GetEsmOptStrictIDs	      (void);
  bool  GetEsmOptInitialIndentLevel   (void);
  bool  GetEsmOptIndentCommentsMore   (void);
  bool  GetEsmOptAllowBloodmoon       (void);
  bool  GetEsmOptAllowTribunal        (void);
  int	GetEsmOptScriptWarnLevel      (void);
  int	GetEsmOptScriptFormatType     (void);
  const TCHAR* GetEsmOptDefaultAuthor (void);
  const TCHAR* GetEsmOptExtraFile     (void);
  const TCHAR* GetEsmOptScriptIndentString (void);

	/* Forward definition */
  class CEsmScriptOptions;
  CEsmScriptOptions* GetEsmOptScriptOptions (void);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmgloboptions.H
 *=========================================================================*/
