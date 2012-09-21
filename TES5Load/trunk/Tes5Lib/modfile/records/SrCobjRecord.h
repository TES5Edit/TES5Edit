/*===========================================================================
 *
 * File:		SrCobjrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrCobjRecord class.
 *
 *=========================================================================*/
#ifndef __SRCOBJRECORD_H
#define __SRCOBJRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srctdasubrecord.h"
	#include "../subrecords/srformidsubrecord.h"
	#include "../subrecords/srcntosubrecord.h"
	#include "../subrecords/srdwordsubrecord.h"
	#include "../subrecords/srcoedsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCobjRecord Definition
 *
 *=========================================================================*/
class CSrCobjRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrCobjRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrFormidSubrecord*		m_pStation;
	CSrDwordSubrecord*		m_pComponentCount;
	CSrFormidSubrecord*		m_pItemResult;
	CSrWordSubrecord*		m_pResultQnt;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrCobjRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrCobjRecord; }

		/* Get class members */
  dword       GetComponentCount (void) { return m_pComponentCount	? m_pComponentCount->GetValue() : 0; }
  word        GetResultCount    (void) { return m_pResultQnt		? m_pResultQnt->GetValue() : 0; }
  srformid_t  GetStationID      (void) { return m_pStation			? m_pStation->GetValue() : 0; }
  srformid_t  GetResultItemID   (void) { return m_pItemResult		? m_pItemResult->GetValue() : 0; }
  const char* GetResultItem     (void);
  const char* GetStation        (void);

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
  void SetResultCount   (const word       Value) { if (m_pResultQnt)  m_pResultQnt->SetValue(Value); }
  void SetResultItemID  (const srformid_t Value) { if (m_pItemResult) m_pItemResult->SetValue(Value); }
  void SetStationID     (const srformid_t Value) { if (m_pStation)    m_pStation->SetValue(Value); }

  void UpdateComponentCount (void);

		/* Begin field method definitions */
  DECLARE_SRFIELD(FieldComponentCount)
  DECLARE_SRFIELD(FieldResultCount)
  DECLARE_SRFIELD(FieldStation)
  DECLARE_SRFIELD(FieldResultItem)

  DECLARE_SRFIELD_CONDITION(CSrCobjRecord)

};
/*===========================================================================
 *		End of Class CSrCobjRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCobjRecord.H
 *=========================================================================*/
