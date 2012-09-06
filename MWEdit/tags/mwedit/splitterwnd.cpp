/*===========================================================================
 *
 * File:	SplitterWnd.CPP
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	April 27, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "SplitterWnd.h"
#include <afxpriv.h>


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


  static DWORD s_dwVersion;
  static int   s_nWinVer;
  static int   s_bWin95;
  static int   s_bWin4;
  static int   s_cxBorder2;
  static int   s_cyBorder2;
  static int   CX_BORDER = 1;
  static int   CY_BORDER = 1;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CMwSplitterWnd Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CMwSplitterWnd, CSplitterWnd)
	//{{AFX_MSG_MAP(CMwSplitterWnd)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CMwSplitterWnd Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void _AfxDeferClientPos (lpLayout, pWnd, x, y, cx, cy, bScrollBar;
 *
 *=========================================================================*/
AFX_STATIC void AFXAPI _AfxDeferClientPos(AFX_SIZEPARENTPARAMS* lpLayout, CWnd* pWnd, 
					int x, int y, int cx, int cy, BOOL bScrollBar) {
	ASSERT(pWnd != NULL);
	ASSERT(pWnd->m_hWnd != NULL);

	if (bScrollBar)
	{
		// if there is enough room, draw scroll bar without border
		// if there is not enough room, set the WS_BORDER bit so that
		//   we will at least get a proper border drawn
		BOOL bNeedBorder = (cx <= CX_BORDER || cy <= CY_BORDER);
		pWnd->ModifyStyle(bNeedBorder ? 0 : WS_BORDER,
			bNeedBorder ? WS_BORDER : 0);
	}
	CRect rect(x, y, x+cx, y+cy);

	// adjust for border size (even if zero client size)
	if (!s_bWin4)
	{
		if (bScrollBar)
			rect.InflateRect(CX_BORDER, CY_BORDER);
		else
			pWnd->CalcWindowRect(&rect);
	}

	// adjust for 3d border (splitter windows have implied border)
	if ((pWnd->GetExStyle() & WS_EX_CLIENTEDGE) ||
		  pWnd->IsKindOf(RUNTIME_CLASS(CSplitterWnd)))
		rect.InflateRect(s_cxBorder2, s_cyBorder2);

	// first check if the new rectangle is the same as the current
	CRect rectOld;
	pWnd->GetWindowRect(rectOld);
	pWnd->GetParent()->ScreenToClient(&rectOld);
	if (rect != rectOld)
		AfxRepositionWindow(lpLayout, pWnd->m_hWnd, rect);
}
/*===========================================================================
 *		End of Function _AfxDeferClientPos()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void l_ObLayoutRowCol (pInfoArray, nMax, nSize, nSizeSplitter);
 *
 * Generic routine:
 *	for X direction: pInfo = m_pColInfo, nMax = m_nMaxCols, nSize = cx
 *	for Y direction: pInfo = m_pRowInfo, nMax = m_nMaxRows, nSize = cy
 *
 *=========================================================================*/
void l_ObLayoutRowCol (CSplitterWnd::CRowColInfo* pInfoArray, int nMax, 
			int nSize, int nSizeSplitter) {
	ASSERT(pInfoArray != NULL);
	ASSERT(nMax > 0);
	ASSERT(nSizeSplitter > 0);

	CSplitterWnd::CRowColInfo* pInfo;
	int i;
	int TotalSize = 0;
	bool bNoSize = false;

	// 495 == 502 = 7 y
	// 480 == 480 x


	if (nSize < 0)
		nSize = 0;  // if really too small, layout as zero size

	// start with ideal sizes
	for (i = 0, pInfo = pInfoArray; i < nMax-1; i++, pInfo++)
	{
		TotalSize += pInfo->nCurSize + nSizeSplitter;
		if (pInfo->nCurSize <= 0) bNoSize = true;
		
		if (pInfo->nIdealSize < pInfo->nMinSize)
			pInfo->nIdealSize = 0;      // too small to see
		pInfo->nCurSize = pInfo->nIdealSize;
	}

	if (pInfo->nCurSize <= 0) bNoSize = true;
	TotalSize += pInfo->nCurSize;
	pInfo->nCurSize = INT_MAX;  // last row/column takes the rest

	if (TotalSize < nSize && !bNoSize && nMax > 1) {
	  pInfoArray[0].nCurSize += nSize - TotalSize;
	 }

	for (i = 0, pInfo = pInfoArray; i < nMax; i++, pInfo++)
	{
		ASSERT(nSize >= 0);
		if (nSize == 0)
		{
			// no more room (set pane to be invisible)
			pInfo->nCurSize = 0;
			continue;       // don't worry about splitters
		}
		else if (nSize < pInfo->nMinSize && i != 0)
		{
			// additional panes below the recommended minimum size
			//   aren't shown and the size goes to the previous pane
			pInfo->nCurSize = 0;

			// previous pane already has room for splitter + border
			//   add remaining size and remove the extra border
			ASSERT(s_cxBorder2 == s_cyBorder2);
			(pInfo-1)->nCurSize += nSize + s_cxBorder2;
			nSize = 0;
		}
		else
		{
			// otherwise we can add the second pane
			ASSERT(nSize > 0);
			if (pInfo->nCurSize == 0)
			{
				// too small to see
				if (i != 0)
					pInfo->nCurSize = 0;
			}
			else if (nSize < pInfo->nCurSize)
			{
				// this row/col won't fit completely - make as small as possible
				pInfo->nCurSize = nSize;
				nSize = 0;
			}
			else
			{
				// can fit everything
				nSize -= pInfo->nCurSize;
			}
		}

		// see if we should add a splitter
		ASSERT(nSize >= 0);
		if (i != nMax - 1)
		{
			// should have a splitter
			if (nSize > nSizeSplitter)
			{
				nSize -= nSizeSplitter; // leave room for splitter + border
				ASSERT(nSize > 0);
			}
			else
			{
				// not enough room - add left over less splitter size
				ASSERT(s_cxBorder2 == s_cyBorder2);
				pInfo->nCurSize += nSize;
				if (pInfo->nCurSize > (nSizeSplitter - s_cxBorder2))
					pInfo->nCurSize -= (nSizeSplitter - s_cyBorder2);
				nSize = 0;
			}
		}
	}
	ASSERT(nSize == 0); // all space should be allocated
 }
/*===========================================================================
 *		End of Function l_ObLayoutRowCol()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwSplitterWnd Constructor
 *
 *=========================================================================*/
CMwSplitterWnd::CMwSplitterWnd() {
  s_dwVersion = ::GetVersion();
  s_nWinVer   = (LOBYTE(s_dwVersion) << 8) + HIBYTE(s_dwVersion);
  s_bWin4     = (BYTE)s_dwVersion >= 4;

  s_cxBorder2 = s_bWin4 ? 2*CX_BORDER : CX_BORDER;
  s_cyBorder2 = s_bWin4 ? 2*CY_BORDER : CY_BORDER;

 }
/*===========================================================================
 *		End of Class CMwSplitterWnd Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwSplitterWnd Destructor
 *
 *=========================================================================*/
CMwSplitterWnd::~CMwSplitterWnd() {
 }
/*===========================================================================
 *		End of Class CMwSplitterWnd Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwSplitterWnd Method - void RecalcLayout ();
 *
 *=========================================================================*/
void CMwSplitterWnd::RecalcLayout() {
	ASSERT_VALID(this);
	ASSERT(m_nRows > 0 && m_nCols > 0); // must have at least one pane

	/* Force no scroll bars */
  m_bHasHScroll = FALSE;
  m_bHasVScroll = FALSE;

	CRect rectClient;
	GetClientRect(rectClient);
	rectClient.InflateRect(-m_cxBorder, -m_cyBorder);

	CRect rectInside;
	GetInsideRect(rectInside);

		/* layout columns (restrict to possible sizes) */
	l_ObLayoutRowCol(m_pColInfo, m_nCols, rectInside.Width(),  m_cxSplitterGap);
	l_ObLayoutRowCol(m_pRowInfo, m_nRows, rectInside.Height(), m_cySplitterGap);

	// adjust the panes (and optionally scroll bars)

	// give the hint for the maximum number of HWNDs
	AFX_SIZEPARENTPARAMS layout;
	layout.hDWP = ::BeginDeferWindowPos((m_nCols + 1) * (m_nRows + 1) + 1);

	// size of scrollbars
	int cx = (rectClient.right - rectInside.right) - (1 - s_bWin4);
	int cy = (rectClient.bottom - rectInside.bottom) - (1 - s_bWin4);

	// reposition size box
	if (m_bHasHScroll && m_bHasVScroll)
	{
		CWnd* pScrollBar = GetDlgItem(AFX_IDW_SIZE_BOX);
		ASSERT(pScrollBar != NULL);

		// fix style if necessary
		BOOL bSizingParent = (GetSizingParent() != NULL);
		// modifyStyle returns TRUE if style changes
		if (pScrollBar->ModifyStyle(SBS_SIZEGRIP|SBS_SIZEBOX,
				bSizingParent ? SBS_SIZEGRIP : SBS_SIZEBOX))
			pScrollBar->Invalidate();
		pScrollBar->EnableWindow(bSizingParent);

		// reposition the size box
		_AfxDeferClientPos(&layout, pScrollBar,
			rectInside.right + 1 - s_bWin4,
			rectInside.bottom + 1 - s_bWin4, cx, cy, TRUE);
	}

	// reposition scroll bars
	if (m_bHasHScroll)
	{
		int cxSplitterBox = m_cxSplitter + 1 - s_bWin4;// split box bigger
		int x = rectClient.left;
		int y = rectInside.bottom + 1 - s_bWin4;
		for (int col = 0; col < m_nCols; col++)
		{
			CWnd* pScrollBar = GetDlgItem(AFX_IDW_HSCROLL_FIRST + col);
			ASSERT(pScrollBar != NULL);
			int cx = m_pColInfo[col].nCurSize;
			if (col == 0 && m_nCols < m_nMaxCols)
				x += cxSplitterBox, cx -= cxSplitterBox;
			_AfxDeferClientPos(&layout, pScrollBar, x, y, cx, cy, TRUE);
			x += cx + m_cxSplitterGap;
		}
	}

	if (m_bHasVScroll)
	{
		int cySplitterBox = m_cySplitter + 1 - s_bWin4;// split box bigger
		int x = rectInside.right + 1 - s_bWin4;
		int y = rectClient.top;
		for (int row = 0; row < m_nRows; row++)
		{
			CWnd* pScrollBar = GetDlgItem(AFX_IDW_VSCROLL_FIRST + row);
			ASSERT(pScrollBar != NULL);
			int cy = m_pRowInfo[row].nCurSize;
			if (row == 0 && m_nRows < m_nMaxRows)
				y += cySplitterBox, cy -= cySplitterBox;
			_AfxDeferClientPos(&layout, pScrollBar, x, y, cx, cy, TRUE);
			y += cy + m_cySplitterGap;
		}
	}

	//BLOCK: Reposition all the panes
	{
		int x = rectClient.left;
		for (int col = 0; col < m_nCols; col++)
		{
			int cx = m_pColInfo[col].nCurSize;
			int y = rectClient.top;
			for (int row = 0; row < m_nRows; row++)
			{
				int cy = m_pRowInfo[row].nCurSize;
				CWnd* pWnd = GetPane(row, col);
				_AfxDeferClientPos(&layout, pWnd, x, y, cx, cy, FALSE);
				y += cy + m_cySplitterGap;
			}
			x += cx + m_cxSplitterGap;
		}
	}

	// move and resize all the windows at once!
	if (layout.hDWP == NULL || !::EndDeferWindowPos(layout.hDWP))
		TRACE0("Warning: DeferWindowPos failed - low system resources.\n");

	// invalidate all the splitter bars (with NULL pDC)
	DrawAllSplitBars(NULL, rectInside.right, rectInside.bottom);
  }
/*===========================================================================
 *		End of Class Method CMwSplitterWnd::RecalcLayout()
 *=========================================================================*/
 