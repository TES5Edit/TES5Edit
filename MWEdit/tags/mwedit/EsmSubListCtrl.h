/*===========================================================================
 *
 * File:	Esmlistctrl.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 5, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSUBLISTCTRL_H
#define __ESMSUBLISTCTRL_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmSubListCtrl Definition
 *
 *=========================================================================*/
class CEsmSubListCtrl : public CEsmListCtrl {
  DECLARE_DYNCREATE(CEsmSubListCtrl);

  /*---------- Begin Protected Class Members --------------------*/
protected:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Construction */
  CEsmSubListCtrl();
  virtual ~CEsmSubListCtrl();

  	/* Add an item to the list */
  int AddItem (CEsmSubCellRef* pCellRef);

	/* Find an existing cellref in the list */
  int FindCellRef (CEsmSubCellRef* pCellRef);

	/* Access the recinfo data for an item */
  virtual esmrecinfo_t* GetRecInfo (const int Item);

  	/* Set the properties of the given armor item */
  void SetItem (const int ListIndex, CEsmSubCellRef* pCellRef);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmSubListCtrl)
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CEsmSubListCtrl)
  afx_msg void OnColumnclick(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnBeginDrag(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnCustomdraw(NMHDR* pNMHDR, LRESULT* pResult);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmSubListCtrl Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/



//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmlistctrl.H
 *=========================================================================*/

