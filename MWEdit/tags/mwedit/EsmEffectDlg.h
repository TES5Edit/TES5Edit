/*===========================================================================
 *
 * File:	Esmeffectdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMEFFECTDLG_H
#define __ESMEFFECTDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "ColorStatic1.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmEffectDlg Definition
 *
 *=========================================================================*/
class CEsmEffectDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmEffectDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmMagicEffect*	m_pEffect;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmEffectDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmEffectDlg)
  enum { IDD = IDD_EFFECT_DLG };
  CComboBox	m_CastSoundList;
  CComboBox	m_BoltSoundList;
  CComboBox	m_HitSoundList;
  CComboBox	m_AreaSoundList;
  CComboBox	m_CastVisualList;
  CComboBox	m_BoltVisualList;
  CComboBox	m_HitVisualList;
  CComboBox	m_AreaVisualList;
  CComboBox	m_SchoolList;
  CButton	m_EnchantCheck;
  CButton	m_SpellCheck;
  CButton	m_NegativeCheck;
  CEsmIconFrame	m_ParticleBox;
  CButton	m_ParticleButton;
  CEsmIconFrame	m_IconBox;
  CButton	m_IconButton;
  CColorStatic	m_ColorBox;
  CSpinButtonCtrl	m_RedSpin;
  CSpinButtonCtrl	m_GreenSpin;
  CSpinButtonCtrl	m_BlueSpin;
  CEdit		m_NameText;
  CEdit		m_BaseCostText;
  CEdit		m_MaxSizeText;
  CEdit		m_SizeText;
  CEdit		m_SpeedText;
  CEdit		m_RedText;
  CEdit		m_GreenText;
  CEdit		m_BlueText;
  CEdit		m_DescText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmEffectDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmEffectDlg)
  afx_msg void OnOpenbutton();
  afx_msg void OnClosebutton();
  afx_msg void OnCastPlay();
  afx_msg void OnAreaPlay();
  afx_msg void OnHitPlay();
  afx_msg void OnBoltPlay();
  afx_msg void OnChangeColor();
  afx_msg void OnColorbutton();
  afx_msg void OnParticlebutton();
  afx_msg void OnIconbutton();
  //}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmEffectDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmeffectdlg.H
 *=========================================================================*/
