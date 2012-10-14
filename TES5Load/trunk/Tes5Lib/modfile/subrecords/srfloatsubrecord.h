/*===========================================================================
 *
 * File:		Srfloatsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrFloatSubrecord used for storing a 32-bit float.
 *
 *=========================================================================*/
#ifndef __SRFLOATSUBREC_H
#define __SRFLOATSUBREC_H


/*===========================================================================
 *
 * Begin Reqiured Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Reqiured Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrFloatSubrecord Definition
 *
 *=========================================================================*/
class CSrFloatSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrFloatSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  float	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(4) return File.Read(&m_Value, 4); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(4) return File.Write(&m_Value, 4); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFloatSubrecord() : m_Value(0.0f) { }
  //virtual ~CSrFloatSubrecord() { Destroy(); }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); }

  	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrFloatSubrecord* pSubrecord1 = SrCastClassNull(CSrFloatSubrecord, pSubrecord);
	m_RecordSize = sizeof(float);

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrFloatSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrFloatSubrecord; }

	/* Get class members */
  float         GetValue    (void) { return (m_Value); }
  float*        GetValuePtr (void) { return (&m_Value); }
  float&        GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }
  
	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = sizeof(float); }

  	/* Set class methods */
  void SetValue (const float Value) { m_Value = Value; }
 
 };
/*===========================================================================
 *		End of Class CSrFloatSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srfloatsubrecord.H
 *=========================================================================*/
