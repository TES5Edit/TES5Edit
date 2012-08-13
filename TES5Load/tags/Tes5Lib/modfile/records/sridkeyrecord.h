/*===========================================================================
 *
 * File:		Sridkeyrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 *=========================================================================*/
#ifndef __SRIDKEYRECORD_H
#define __SRIDKEYRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sridrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
  #define SR_KEYWORD_SEPCHAR ','
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrIdKeyRecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrIdKeyRecord : public CSrIdRecord {
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrIdKeyRecord, CSrIdRecord)


  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrDwordSubrecord*		m_pKeywordCount;
  CSrFormidArraySubrecord*	m_pKeywords;
  bool						m_HasKeywords;


  /*---------- Begin Protected Class Methods --------------------*/
protected:
	void SetKeywordCount (const dword Count);

  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrIdKeyRecord();
  //virtual ~CSrIdKeyRecord() { Destroy(); }
  virtual void Destroy (void);

	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return (new CSrIdRecord); }

		/* Get keyword data */
  dword			GetKeywordCount	  (void) { return (m_pKeywordCount ? m_pKeywordCount->GetValue()     : 0); }
  CSString      GetKeywords       (void);

	/* Initialize a new record */
  virtual void InitializeNew (void);

	/* Called when a subrecord is added to the record */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);
  
	/* Set keyword data */
  void SetKeywords (const CSString Buffer);
  void SetKeywords (CSrFormidArray& FormIDs);


	/* Begin field method definitions */
  DECLARE_SRFIELD(FieldKeywordCount)
  DECLARE_SRFIELD(FieldKeywords)

};
/*===========================================================================
 *		End of Class CSrIdKeyRecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Sridkeyrecord.H
 *=========================================================================*/
