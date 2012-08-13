/*===========================================================================
 *
 * File:	Obrecdialog.H
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	May 11, 2006
 *
 * Description
 *
 *=========================================================================*/
#ifndef __OBRECDIALOG_H
#define __OBRECDIALOG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "modfile/obespfile.h"
  #include "modfile/obmultirecordhandler.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Macros to help define a UI field map */
  #define DECLARE_OBRECUIFIELDS()	static obuirecfields_t s_UIRecFields[]; \
	 virtual obuirecfields_t* GetUIFields (void) { return (s_UIRecFields); }

  #define BEGIN_OBRECUIFIELDS(Class) obuirecfields_t Class::s_UIRecFields[] = { 
  #define ADD_OBRECUIFIELDS(Field, ID)  { Field, ID },
  #define END_OBRECUIFIELDS()  { OB_FIELD_NONE, 0 } }; 

  
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds the UI field information */
  struct obuirecfields_t {
	obfieldid_t	FieldID;
	int		ControlID;
   };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CObRecordDialog Definition
 *
 * Description
 *
 *=========================================================================*/
class CObRecordDialog : public CDialog {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  obeditrecinfo_t	m_EditInfo;		/* Holds information on the record being edited */
  CObRecordHandler*	m_pRecordHandler;	/* Main record handler object */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Output defined fields */
  void SetUIFields (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CObRecordDialog (const int ID, CWnd* pParent);
  //virtual ~CObRecordDialog() { Destroy(); }
  //virtual void Destroy (void);

	/* Access the UI field array */
  virtual obuirecfields_t* GetUIFields (void) = 0;

	/* Access the dialog record object */
  CObRecord*	    GetInputRecord  (void) { return (m_EditInfo.pOldRecord); }
  CObRecord*	    GetOutputRecord (void) { return (m_EditInfo.pNewRecord); }
  obeditrecinfo_t&  GetEditInfo     (void) { return (m_EditInfo); }

	/* Return a prefix describing the record type */
  virtual const SSCHAR* GetTitlePrefix (void) = 0;

  	/* Set control data */
  virtual void ClearControlData (void);
  virtual void SetControlData   (void);
  virtual void SetTitle         (const SSCHAR* pEditorID);
  
  	/* Set class members */
  virtual void SetEditInfo      (obeditrecinfo_t& InputInfo);
  virtual void SetRecordHandler (CObRecordHandler* pHandler) { m_pRecordHandler = pHandler; }

 protected:

	/* Generated message map functions */
  //{{AFX_MSG(CObWeapDlg)
  virtual BOOL OnInitDialog();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CObRecordDialog Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Obrecdialog.H
 *=========================================================================*/
