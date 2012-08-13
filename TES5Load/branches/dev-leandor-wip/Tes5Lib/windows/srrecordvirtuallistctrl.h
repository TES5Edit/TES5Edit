/*===========================================================================
 *
 * File:		Srrecordvirtuallistctrl.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRRECORDVIRTUALLISTCTRL_H
#define __SRRECORDVIRTUALLISTCTRL_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecordlistctrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRecordVirtualListCtrl Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrRecordVirtualListCtrl : public CSrRecordListCtrl {
  DECLARE_DYNCREATE(CSrRecordVirtualListCtrl);

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrRefRecordArray	m_Records;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

  	/* Sorts the current list by the given field */
  virtual void SortListPriv (const srrecfieldid_t FieldID);



  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrRecordVirtualListCtrl();
  virtual ~CSrRecordVirtualListCtrl();

	/* Add a new item */
  virtual int AddCustomRecord (srrlcustomdata_t& CustomData); 

	/* Set default list settings */
  virtual void DefaultSettings (void);

	/* Clear all items */
  virtual BOOL DeleteAllItems (void);

  	/* Find a record in the list */
  virtual int FindRecord (CSrRecord* pRecord);

  	/* Finds the closest match to the given editorid string in the list */
  virtual int FindEditorID (const SSCHAR* pString);

	/* Get a record object */
  virtual CSrRecord* GetRecord  (const int ListIndex);
  CSrRefRecordArray* GetRecords (void) { return (&m_Records); }

  	/* Remove an item from the list */
  virtual bool RemoveItem (const int ListIndex);

  	/* Update a record in the list */
  virtual int UpdateRecord (CSrRecord* pNewRecord, CSrRecord* pOldRecord);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CSrRecordVirtualListCtrl)
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CSrRecordVirtualListCtrl)
  afx_msg void OnGetDispInfo(NMHDR* pNMHDR, LRESULT* pResult);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()

 };
/*===========================================================================
 *		End of Class CSrRecordVirtualListCtrl Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srrecordvirtuallistctrl.H
 *=========================================================================*/
