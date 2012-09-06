/*===========================================================================
 *
 * File:	Convertnif3ds.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	December 6, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __CONVERTNIF3DS_H
#define __CONVERTNIF3DS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "NifFile.h"
  #include "NifTriShape.h"
  #include "NifNode.h"
  #include "3dsftk.h"
  #include "NifSourceTexture.h"
  #include "NifMaterialProperty.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Structure used for internal functions */
  struct nif3ds_info_t {
	CNifFile*		pNifFile;
	file3ds*		p3dsFile;
	database3ds*		p3dsDB;
	const TCHAR*		p3dsFilename;

	CNifTriShape*		pLastTriShape;
	CNifNode*		pLastNode;
	CNifNode*		pPrimaryNode;
	CNifSourceTexture*	pLastSourceTexture;
	CNifMaterialProperty*	pLastMaterial;

	int			MaterialIndex;
	int			TextureIndex;
	int			ObjectIndex;
	TCHAR			MatName[11];
	bool			HasTexture;
	TCHAR			TextureName[14];
   };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/



/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
  bool ConvertNifTo3ds (CNifFile& NifFile, const TCHAR* p3dsFilename);
/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Convertnif3ds.H
 *=========================================================================*/

