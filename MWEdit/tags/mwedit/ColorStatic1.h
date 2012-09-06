/*===========================================================================
 *
 * File:	Colorstatic1.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __COLORSTATIC1_H
#define __COLORSTATIC1_H



/*===========================================================================
 *
 * Begin Class CColorStatic Definition
 *
 *=========================================================================*/
class CColorStatic : public CStatic {

public:
  COLORREF	m_Color;
  int		m_Red;
  int		m_Green;
  int		m_Blue;

	/* Construction */
  CColorStatic();
  virtual ~CColorStatic();

  void SetColor (int Red, int Green, int Blue) { 
    m_Red = Red;  m_Green = Green; m_Blue = Blue;
    m_Color = RGB(m_Red, m_Green, m_Blue);
   }

  void SetColor (const long ColorRef) { 
    m_Red = GetRValue(ColorRef);  m_Green = GetGValue(ColorRef); m_Blue = GetBValue(ColorRef);
    m_Color = ColorRef;
   }

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CColorStatic)
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CColorStatic)
  afx_msg void OnPaint();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CColorStatic Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Colorstatic1.H
 *=========================================================================*/
