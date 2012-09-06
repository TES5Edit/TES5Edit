/*===========================================================================
 *
 * File:	Convertnif3ds.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	December 6, 2003
 *
 * Description
 *
 * 29 Dec 2003 - Dave Humphrey
 *	- Fixed bug in the save 3DS function which was incorrectly returning
 *	  failure even on success.
 *	- Short texture filenames used instead of long ones.
 *	- Morrowind path is read from the registry instead of being
 *	  hard coded.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "convertnif3ds.h"
#include "NifTriShapeData.h"
#include "mwcommon.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("ConvertNif3ds.h");

	/* Save the absolute path to the Morrowind data files */
  CString l_MWDataFilesPath(GetMWDataFilePath());
  CString l_MWTexturesPath(GetMWTexturesPath());

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void l_Store3dsError (const TCHAR* pString, ...);
 *
 * Stores any current 3DS errors to the main ErrorHandler object. Local
 * function. The 3DS error list is cleared. Accepts optional input in the
 * same format of the printf() type functions.
 *
 *=========================================================================*/
void l_Store3dsError (const TCHAR* pString, ...) {
  //DEFINE_FUNCTION("l_Store3dsError()");
  const ErrRec3ds* p3dsError = ReturnErrorList3ds();
  va_list	   pArgs;
  
	/* Use a default error string if none was supplied to the function */
  if (pString == NULL) {
    ErrorHandler.AddError(ERR_CUSTOM, p3dsError->id, _T("%s"), p3dsError->desc);
   }
	/* Use a custom printf() type formatted string to create the error message */
  else {
    CString Buffer;

    va_start(pArgs, pString);
    Buffer.FormatV(pString, pArgs);
    va_end(pArgs);

    ErrorHandler.AddError(ERR_CUSTOM, p3dsError->id, _T("%s\n\r%s"), p3dsError->desc, Buffer);
   }

 }
/*===========================================================================
 *		End of Function l_Store3dsError()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_Init3dsFile (Info);
 *
 * Prepares the 3DS file/objects for export. Local function.
 *
 *=========================================================================*/
bool l_Init3dsFile (nif3ds_info_t& Info) {
  //DEFINE_FUNCTION("l_Init3dsFile()");
  meshset3ds* pMeshSettings = NULL;

  ClearErrList3ds();
   
  Info.p3dsFile = OpenFile3ds(Info.p3dsFilename, "w");

  if (ftkerr3ds) {
    l_Store3dsError(_T("Failed to open the 3DS file '%s'!"), Info.p3dsFilename);
    ON_ERROR_RETURNR(false);
   }
  
  InitDatabase3ds(&Info.p3dsDB);

  if (ftkerr3ds) {
    l_Store3dsError(_T("Failed to initialize the 3DS database!"));
    ON_ERROR_RETURNR(false);
   }
    
  CreateNewDatabase3ds(Info.p3dsDB, MeshFile);

	/* Initialize the global mesh settings */
  InitMeshSet3ds(&pMeshSettings);
  ON_ERROR_RETURNR(false);
   
  pMeshSettings->ambientlight.r = 0.3f;
  pMeshSettings->ambientlight.g = 0.3f;
  pMeshSettings->ambientlight.b = 0.3F;

  PutMeshSet3ds(Info.p3dsDB, pMeshSettings);  
  ReleaseMeshSet3ds(&pMeshSettings);
  ON_ERROR_RETURNR(false);

  return (true);
 }
/*===========================================================================
 *		End of Function l_Init3dsFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* l_GetMaterialName (Info);
 *
 * Creates and returns a material name.
 *
 *=========================================================================*/
const TCHAR* l_GetMaterialName (nif3ds_info_t& Info) {
  //DEFINE_FUNCTION("TCHAR* l_GetMaterialName()");
  static TCHAR s_Name[32];

  snprintf(s_Name, 31, _T("mat%05d"), Info.MaterialIndex);
  strnncpy(Info.MatName, s_Name, 10);
  Info.MaterialIndex++;

  return (s_Name);
 }
/*===========================================================================
 *		End of Function TCHAR* l_GetMaterialName()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* l_GetTextureName (Info);
 *
 * Creates and returns a texture name. Finds the short DOS 8.3 filename for
 * the given texture using the Windows GetShortPathName() function, storing
 * the result in the Info.TextureName as well as returning it. 
 *
 * This will not work unless the texture files have been copied to the 
 * game's Data Files\Textures\ directory.
 *
 *=========================================================================*/
const TCHAR* l_GetTextureName (nif3ds_info_t& Info) {
  //DEFINE_FUNCTION("TCHAR* l_GetTextureName()");
  static TCHAR  s_Name[32];
  TCHAR		OutputPath[_MAX_PATH];
  CString	FileBuffer;
  int		iResult;

  if (Info.pLastSourceTexture != NULL) {
    FileBuffer  = l_MWTexturesPath;
    FileBuffer += Info.pLastSourceTexture->GetRecordName();

		/* Ensure the texture file exists */
    if (!FileExists(FileBuffer)) {
       ErrorHandler.AddError(ERR_CUSTOM, _T("The texture file\n\r\t%s\n\rwas not found!"), FileBuffer);
       strnncpy(Info.TextureName, _T(""), 12);
       strnncpy(s_Name, _T(""), 12);
       return (s_Name);
     }

    iResult = GetShortPathName(FileBuffer, OutputPath, _MAX_PATH);
    if (iResult == 0) OutputPath[0] = NULL_CHAR;
   }

  strnncpy(Info.TextureName, FindFilename(OutputPath), 12);
  strnncpy(s_Name, Info.TextureName, 12);
  return (s_Name);
 }
/*===========================================================================
 *		End of Function TCHAR* l_GetTextureName()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* l_GetObjectName (Info);
 *
 * Description
 *
 *=========================================================================*/
const TCHAR* l_GetObjectName (nif3ds_info_t& Info) {
  //DEFINE_FUNCTION("TCHAR* l_GetObjectName()");
  static TCHAR  s_Name[32];

  snprintf(s_Name, 31, _T("obj%05d"), Info.ObjectIndex);
  Info.ObjectIndex++;
  return (s_Name);
 }
/*===========================================================================
 *		End of Function TCHAR* l_GetObjectName()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_Cleanup3ds (Info);
 *
 * Performs any cleanup of 3DS objects. Returns false on any error.
 *
 *=========================================================================*/
bool l_Cleanup3ds (nif3ds_info_t& Info) {
  ReleaseDatabase3ds(&Info.p3dsDB);
  Info.p3dsDB = NULL;

  return (true);
 }
/*===========================================================================
 *		End of Function l_Cleanup3ds()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_Save3dsFile (Info);
 *
 * Writes the converted information to the 3ds file and closes it. Returns
 * false on any error.
 *
 *=========================================================================*/
bool l_Save3dsFile (nif3ds_info_t& Info) {
  //DEFINE_FUNCTION("l_Save3dsFile()");

	/* Write the database to the file */
  WriteDatabase3ds(Info.p3dsFile, Info.p3dsDB);

  if (ftkerr3ds) {
    l_Store3dsError(_T("Failed to write the 3DS database to the file!"));
    ON_ERROR_RETURNR(false);
   }

	/* Close the 3ds file */
  CloseFile3ds(Info.p3dsFile);
  Info.p3dsFile = NULL;

  if (ftkerr3ds) {
    l_Store3dsError(_T("Failed to close the 3DS file!"));
    ON_ERROR_RETURNR(false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function l_Save3dsFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_ConvertTriShapeData (pTriShapeData, Info);
 *
 * Description
 *
 *=========================================================================*/
bool l_ConvertTriShapeData(CNifTriShapeData* pTriShapeData, nif3ds_info_t& Info) {
  mesh3ds*   pMesh = NULL;
  kfmesh3ds* pMotion = NULL;
  nifpos_t*  pNifPos;
  short*     pFaceIndex;
  int        Index;

	/* Attempt to intialize a new mesh object */
  InitMeshObj3ds(&pMesh, pTriShapeData->GetNumPoints(), pTriShapeData->GetNumFaces(), InitNoExtras3ds);

  if (ftkerr3ds) {
    l_Store3dsError(_T("Failed to initialize 3DS mesh object!"));
    ON_ERROR_RETURNR(false);
   }

	/* Set the mesh name */
  if (Info.pLastNode != NULL)
    strnncpy(pMesh->name, Info.pLastNode->GetRecordName(), 10);
  else if (Info.pLastTriShape != NULL)
    strnncpy(pMesh->name, Info.pLastTriShape->GetRecordName(), 10);
  
  //if (pMesh->name[0] == 0) 
  strnncpy(pMesh->name, l_GetObjectName(Info), 10);

	/* Set the mesh points */
  for (Index = 0; Index < pTriShapeData->GetNumPoints(); Index++) {
    pNifPos = pTriShapeData->GetPoint(Index);
    pMesh->vertexarray[Index].x = pNifPos->X;
    pMesh->vertexarray[Index].y = pNifPos->Y;
    pMesh->vertexarray[Index].z = pNifPos->Z;
   }

	/* Set the mesh faces */
  for (Index = 0; Index < pTriShapeData->GetNumFaces(); Index++) {
    pFaceIndex = pTriShapeData->GetFace(Index*3);
    pMesh->facearray[Index].v1   = pFaceIndex[0];
    pMesh->facearray[Index].v2   = pFaceIndex[1];
    pMesh->facearray[Index].v3   = pFaceIndex[2];
    pMesh->facearray[Index].flag = FaceABVisable3ds | FaceBCVisable3ds | FaceCAVisable3ds;
   }

  FillMatrix3ds(pMesh);

  if (Info.pLastNode != NULL && Info.pLastTriShape != NULL) {
    pMesh->locmatrix[0]  = Info.pLastNode->GetFloat(3);
    pMesh->locmatrix[1]  = Info.pLastNode->GetFloat(4);
    pMesh->locmatrix[2]  = Info.pLastNode->GetFloat(5);
    pMesh->locmatrix[3]  = Info.pLastNode->GetFloat(6);
    pMesh->locmatrix[4]  = Info.pLastNode->GetFloat(7);
    pMesh->locmatrix[5]  = Info.pLastNode->GetFloat(8);
    pMesh->locmatrix[6]  = Info.pLastNode->GetFloat(9);
    pMesh->locmatrix[7]  = Info.pLastNode->GetFloat(10);
    pMesh->locmatrix[8]  = Info.pLastNode->GetFloat(11);
    pMesh->locmatrix[9]  = Info.pLastNode->GetFloat(0) + Info.pLastTriShape->GetFloat(0);
    pMesh->locmatrix[10] = Info.pLastNode->GetFloat(1) + Info.pLastTriShape->GetFloat(1);
    pMesh->locmatrix[11] = Info.pLastNode->GetFloat(2) + Info.pLastTriShape->GetFloat(2);
    //pMesh->locmatrix[9]  = Info.pLastNode->GetFloat(0);
    //pMesh->locmatrix[10] = Info.pLastNode->GetFloat(1);
    //pMesh->locmatrix[11] = Info.pLastNode->GetFloat(2);
   }

  if (Info.pLastMaterial != NULL) {
    pMesh->nmats = 1;
    InitMeshObjField3ds (pMesh, InitMatArray3ds);
    if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

    InitMatArrayIndex3ds (pMesh, 0, pTriShapeData->GetNumFaces());
    if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

    strnncpy(pMesh->matarray[0].name, Info.MatName, 10);

    for (Index = 0; Index < pTriShapeData->GetNumFaces(); Index++) {
      pMesh->matarray[0].faceindex[Index] = Index;
     }

    pMesh->matarray[0].nfaces = pTriShapeData->GetNumFaces();
  
    pMesh->ntextverts = pTriShapeData->GetNumPoints();
    InitMeshObjField3ds(pMesh, InitTextArray3ds);
    if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

    for (Index = 0; Index < pTriShapeData->GetNumPoints(); Index++) {
      pMesh->textarray[Index].u = pTriShapeData->GetUVPoint(Index * 2);
      pMesh->textarray[Index].v = pTriShapeData->GetUVPoint(Index * 2 + 1);
     }
   }

  PutMesh3ds(Info.p3dsDB, pMesh);
  if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

  InitObjectMotion3ds(&pMotion, 0, 0, 0, 0, 0);
  if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

  strcpy(pMotion->name, pMesh->name);
  strcpy(pMotion->parent, "MAXSCENE");
  pMotion->pivot.x = 0.0f;
  pMotion->pivot.y = 0.0f;
  pMotion->pivot.z = 0.0f;

  SetBoundBox3ds (pMesh, pMotion);
  if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

  PutObjectMotion3ds(Info.p3dsDB, pMotion);
  if (ftkerr3ds) goto ON_TRISHAPEDATA_ERROR;

  ReleaseObjectMotion3ds(&pMotion);
  RelMeshObj3ds(&pMesh);

  if (ftkerr3ds) {
    l_Store3dsError(_T("Failed to release the 3DS mesh/motion objects!"));
    ON_ERROR_RETURNR(false);
   }

  return (true);

ON_TRISHAPEDATA_ERROR:
  l_Store3dsError(_T("3DS mesh object error!"));
  if (pMesh != NULL) RelMeshObj3ds(&pMesh);
  return (false);
 }
/*===========================================================================
 *		End of Function l_ConvertTriShapeData()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_ConvertMaterial (pMatProperty, Info);
 *
 * Description
 *
 *=========================================================================*/
bool l_ConvertMaterial (CNifMaterialProperty* pMatProperty, nif3ds_info_t& Info) {
  material3ds* pMaterial = NULL;

  InitMaterial3ds(&pMaterial);
  if (ftkerr3ds) goto ON_MATERIAL_ERROR;

  strnncpy(pMaterial->name, l_GetMaterialName(Info), 10);

  pMaterial->ambient.r = pMatProperty->GetAmbientRed();
  pMaterial->ambient.g = pMatProperty->GetAmbientGreen();
  pMaterial->ambient.b = pMatProperty->GetAmbientBlue();

  pMaterial->diffuse.r = pMatProperty->GetDiffuseRed();
  pMaterial->diffuse.g = pMatProperty->GetDiffuseGreen();
  pMaterial->diffuse.b = pMatProperty->GetDiffuseBlue();

  pMaterial->specular.r = pMatProperty->GetSpecularRed();
  pMaterial->specular.g = pMatProperty->GetSpecularGreen();
  pMaterial->specular.b = pMatProperty->GetSpecularBlue();

  pMaterial->shininess    = 0.0f;
  pMaterial->shinstrength = 0.0f;
  pMaterial->blur         = 0.2f;
  pMaterial->transparency = 0.0f;
  pMaterial->transfalloff = 0.0f;
  pMaterial->selfillumpct = 0.0f;
  pMaterial->wiresize     = 1.0f;
  pMaterial->shading      = Phong;
  pMaterial->useblur      = True3ds;

  if (Info.HasTexture) {
    strnncpy(pMaterial->texture.map.name, Info.TextureName, 12);
    pMaterial->texture.map.percent = 1.0f;
   }

  PutMaterial3ds(Info.p3dsDB, pMaterial);
  if (ftkerr3ds) goto ON_MATERIAL_ERROR;

  ReleaseMaterial3ds(&pMaterial);
  if (ftkerr3ds) goto ON_MATERIAL_ERROR;

  Info.pLastMaterial = (CNifMaterialProperty *) pMatProperty;
  return (true);

ON_MATERIAL_ERROR:
  l_Store3dsError(_T("3DS material error!"));
  if (pMaterial != NULL) ReleaseMaterial3ds(&pMaterial);
  return (false);
 }
/*===========================================================================
 *		End of Function l_ConvertMaterial()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_ConvertSourceTexture (pSourceTexture, Info);
 *
 * Description
 *
 *=========================================================================*/
bool l_ConvertSourceTexture (CNifSourceTexture* pSourceTexture, nif3ds_info_t& Info) {
  //DEFINE_FUNCTION("l_ConvertSourceTexture()");
  
  Info.pLastSourceTexture = pSourceTexture;
  strnncpy(Info.TextureName, l_GetTextureName(Info), 12);

  return (true);
 }
/*===========================================================================
 *		End of Function l_ConvertSourceTexture()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool l_ConvertRecords (Info);
 *
 * Iterates through all records in the NIF file, converting them as 
 * necessary. Returns false on any error.
 *
 *=========================================================================*/
bool l_ConvertRecords (nif3ds_info_t& Info) {
  CNifBaseRecord* pNifRecord;
  POSITION	  RecordPos;
  bool		  Result;

	/* Iterate through all records in the NIF file */
  pNifRecord = Info.pNifFile->GetFirstRecord(RecordPos);

  while (pNifRecord != NULL) {

    if (pNifRecord->IsName("NiTriShapeData")) {
      Result = l_ConvertTriShapeData((CNifTriShapeData *)pNifRecord, Info);

      Info.pLastNode          = NULL;
      Info.pLastTriShape      = NULL;
      Info.pLastSourceTexture = NULL;
      Info.pLastMaterial      = NULL;
      Info.HasTexture         = false;
     }
    else if (pNifRecord->IsName("NiTriShape")) {
      Info.pLastTriShape = (CNifTriShape *) pNifRecord;
     }
    else if (pNifRecord->IsName("NiNode")) {
      Info.pLastNode = (CNifNode *) pNifRecord;
      if (Info.pPrimaryNode == NULL) Info.pPrimaryNode = (CNifNode *) pNifRecord;
     }
    else if (pNifRecord->IsName("NiSourceTexture")) {
      Result = l_ConvertSourceTexture((CNifSourceTexture *) pNifRecord, Info);
     }
    else if (pNifRecord->IsName("NiTexturingProperty")) {
      Info.HasTexture = true;
      Result = true;
     }
    else if (pNifRecord->IsName("NiMaterialProperty")) {
      Result = l_ConvertMaterial ((CNifMaterialProperty *) pNifRecord, Info);
     }
    else {
      Result = true;
     }
     
    if (!Result) return (false);
    pNifRecord = Info.pNifFile->GetNextRecord(RecordPos);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function l_ConvertRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ConvertNifTo3ds (NifFile, p3dsFilename);
 *
 * Attempt to export the given NIF data to the specified 3DS type file. 
 * Returns false on any error.
 *
 *=========================================================================*/
bool ConvertNifTo3ds (CNifFile& NifFile, const TCHAR* p3dsFilename) {
  DEFINE_FUNCTION("ConvertNifTo3ds()");
  nif3ds_info_t Info;
  bool		Result;
  
	/* Initialize the conversion info structure */
  Info.pNifFile			= &NifFile;
  Info.p3dsFilename		= p3dsFilename;
  Info.p3dsDB			= NULL;
  Info.p3dsFile			= NULL;
  Info.pLastNode		= NULL;
  Info.pLastTriShape		= NULL;
  Info.pPrimaryNode		= NULL;
  Info.pLastSourceTexture	= NULL;
  Info.pLastMaterial		= NULL;
  Info.MaterialIndex		= 1;
  Info.TextureIndex		= 1;
  Info.ObjectIndex		= 1;
  Info.HasTexture               = false;

	/* Attempt to initialize the base 3ds files/objects */
  Result = l_Init3dsFile(Info);
  if (!Result) goto ON_NIF3DS_ERROR;

  Result = l_ConvertRecords(Info);
  if (!Result) goto ON_NIF3DS_ERROR;

	/* Save the 3ds file */
  Result = l_Save3dsFile(Info);
  if (!Result) goto ON_NIF3DS_ERROR;

	/* Cleanup the 3DS objects */
  Result = l_Cleanup3ds(Info);
  if (!Result) return (false);

  return (true);

ON_NIF3DS_ERROR:
  l_Cleanup3ds(Info);
  return (false);
 }
/*===========================================================================
 *		End of Function ConvertNifTo3ds()
 *=========================================================================*/
