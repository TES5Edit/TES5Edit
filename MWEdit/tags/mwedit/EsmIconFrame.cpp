/*===========================================================================
 *
 * File:	Esmiconframe.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Thursday, February 13, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "EsmIconFrame.h"
#include "il/il.h"
#include "il/ilut.h"
#include "EsmUtils.h"
#include "EsmDefs.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  DEFINE_FILE("EsmIconFrame.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmIconFrame Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmIconFrame, CStatic)
  //{{AFX_MSG_MAP(CEsmIconFrame)
  ON_WM_PAINT()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmIconFrame Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIconFrame Constructor
 *
 *=========================================================================*/
CEsmIconFrame::CEsmIconFrame() {
  m_IsInitialized = false;
 }
/*===========================================================================
 *		End of Class CEsmIconFrame Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIconFrame Destructor
 *
 *=========================================================================*/
CEsmIconFrame::~CEsmIconFrame() {
  
	/* Destroy the frame's bitmap if required */
  if (m_IsInitialized) {
    m_Bitmap.DeleteObject();
   }

 }
/*===========================================================================
 *		End of Class CEsmIconFrame Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIconFrame Event - void OnInitialUpdate (void);
 *
 *=========================================================================*/
void CEsmIconFrame::OnInitialUpdate (void) {
  CRect	ClientRect;
  CDC*  pDC;

	/* Get the output area */
  GetClientRect(&ClientRect);
  pDC = GetDC();

	/* Create the bitmap of the desired size that is compatible
	 * with the current output DC */
  m_Bitmap.CreateCompatibleBitmap(pDC, MWESM_ICON_DEFAULTWIDTH, MWESM_ICON_DEFAULTHEIGHT);
  ReleaseDC(pDC);

  m_IsInitialized = true;
 }
/*===========================================================================
 *		End of Class Event CEsmIconFrame::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIconFrame Event - void OnPaint ();
 *
 *=========================================================================*/
void CEsmIconFrame::OnPaint() {
  CPaintDC DC(this);
  CRect    ClientRect;
  CDC	   BitmapDC;

	/* Get the output area */
  GetClientRect(&ClientRect);

	/* Initialize the bitmap memory DC */
  BitmapDC.CreateCompatibleDC(&DC);
  BitmapDC.SelectObject(&m_Bitmap);

	/* Output the stretched bitmap to the frame */
  DC.StretchBlt(0, 0, ClientRect.Width(), ClientRect.Height(), &BitmapDC, 
			0, 0, MWESM_ICON_DEFAULTWIDTH, MWESM_ICON_DEFAULTHEIGHT, SRCCOPY);
 }
/*===========================================================================
 *		End of Class Event CEsmIconFrame::OnPaint()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIconFrame Method - void SetEsmIcon (pFilename, RelativePath);
 *
 *=========================================================================*/
void CEsmIconFrame::SetEsmIcon (const TCHAR* pFilename, const bool RelativePath) {
  HBITMAP hBMP;
  CBitmap TempBitmap;
  CDC*    pDC;

	/* Ensure things are initialized */
  if (!m_IsInitialized) OnInitialUpdate();
  
	/* Attempt to load the given image into a bitmap handle that is
	 * compatible with the current display */
  pDC = GetDC();

  if (pFilename == NULL || *pFilename == NULL_CHAR) {
    hBMP = NULL;
   }
  else if (RelativePath) {
    TCHAR   FileBuffer[_MAX_PATH+1];
    CString Path = GetMWDataPath();
    Path += MWPATH_ICONS;

    _makepath(FileBuffer, NULL, Path, pFilename, NULL);
    //_makepath(FileBuffer, NULL, "c:\\temp\\test\\", pFilename, NULL);
    hBMP = ilutWinLoadImage(FileBuffer, pDC->GetSafeHdc());
   }
  else
    hBMP = ilutWinLoadImage((char *const) pFilename, pDC->GetSafeHdc());

  ReleaseDC(pDC);

	/* Copy the bitmap to the local bitmap object */
  if (hBMP != NULL) {;
    TempBitmap.Attach(hBMP);
    SetIconBitmap(&TempBitmap);
   }
  else {	/* Create a black bitmap */
    CDC OutDC;
    OutDC.CreateCompatibleDC(NULL);
    OutDC.SelectObject(&m_Bitmap);
    OutDC.FillSolidRect(0, 0, MWESM_ICON_DEFAULTWIDTH, MWESM_ICON_DEFAULTHEIGHT, RGB(0,0,0));
   }

  RedrawWindow();
 }
/*===========================================================================
 *		End of Class Method CEsmIconFrame::SetEsmIcon()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmIconFrame Method - void SetIconBitmap (pBitmap);
 *
 *=========================================================================*/
void CEsmIconFrame::SetIconBitmap (CBitmap* pBitmap) {
  DEFINE_FUNCTION("CEsmIconFrame::SetIconBitmap()");
  BITMAP BmpInfo;
  CDC    OutDC;
  CDC    InDC;
  
	/* Initialize the contexts for copying */
  OutDC.CreateCompatibleDC(NULL);
  OutDC.SelectObject(&m_Bitmap);
  InDC.CreateCompatibleDC(NULL);
  InDC.SelectObject(pBitmap);
  pBitmap->GetBitmap(&BmpInfo);
  
	
	/* Copy the bitmap */
  OutDC.StretchBlt(0, 0, MWESM_ICON_DEFAULTWIDTH, MWESM_ICON_DEFAULTHEIGHT, &InDC, 
			0, 0, BmpInfo.bmWidth, BmpInfo.bmHeight, SRCCOPY);
 }
/*===========================================================================
 *		End of Class Method CEsmIconFrame::SetIconBitmap()
 *=========================================================================*/
  
