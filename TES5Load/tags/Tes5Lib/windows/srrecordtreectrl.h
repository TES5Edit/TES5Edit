/*===========================================================================
 *
 * File:		Srrecordtreectrl.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRRECORDTREECTRL_H
#define __SRRECORDTREECTRL_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecordfilter.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Options for the record tree */
  struct srrectreeoptions_t {
	bool	 EnableCounts;
	CSString FilterFile;
	CSString FullFilterFile;

	srrectreeoptions_t() 
	{
		FilterFile     = "displayfilters.dat";
		FullFilterFile = FilterFile;
		EnableCounts   = true;
	}
  };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRecordTreeCtrl Definition
 *
 *=========================================================================*/
class CSrRecordTreeCtrl : public CTreeCtrl {

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  CSrRecFilterArray			m_Filters;
  CSrRecFilterArray*		m_pRefFilters;
  srfilterextra_t			m_ExtraFilter;

  static srrectreeoptions_t	m_Options;


  /*---------- Begin Protected Class Methods ----------------------*/
protected:

	/* Create the tree structure from the current filter data */
  bool CreateItemsFromFilters (void);

	/* Helper update methods */
  void UpdateItemText (HTREEITEM hItem, CSrRecordFilter* pFilter);


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction/Destructor */
  CSrRecordTreeCtrl();
  virtual ~CSrRecordTreeCtrl();

	/* Get the currently selected filter object */
  CSrRecordFilter* GetSelectedFilter (void);

  srfilterextra_t& GetExtraFilter (void) { return m_ExtraFilter; }

	/* Access the current filter array */
  CSrRecFilterArray* GetFilterArray (void) { return (m_pRefFilters == NULL ? &m_Filters : m_pRefFilters); }

	/* Access the static options member */
  static srrectreeoptions_t& GetOptions (void) { return (m_Options); }

	/* Load filters and create tree items from them */
  bool Initialize (const SSCHAR* pFilename);
  bool Initialize (CSrRecFilterArray* pFilterArray);

	/* Load a record filter file */
  bool LoadFilters (const SSCHAR* pFilename) { return LoadObRecordFilters(pFilename, m_Filters); }

	/* Select a tree item with a matching filter ID */
  HTREEITEM SelectFromFilterID (const SSCHAR* pID);

	/* Sets an external filter array object */
  void SetRefFilterArray (CSrRecFilterArray* pFilters = NULL) { m_pRefFilters = pFilters; }

	/* Update the currently displayed filter record counts */
  void  UpdateFilterCounts (CSrEspFile& File);
  void  UpdateFilterCounts (CSrGroup* pTopGroup);
  dword IncludeInCounts    (CSrRecord* pRecord);
  dword RemoveFromCounts   (CSrRecord* pRecord);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CSrRecordTreeCtrl)
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CSrRecordTreeCtrl)
  afx_msg void OnRButtonDown (UINT nFlags, CPoint Point);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()

};
/*===========================================================================
 *		End of Class CSrRecordTreeCtrl Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Srrecordtreectrl.H
 *=========================================================================*/
