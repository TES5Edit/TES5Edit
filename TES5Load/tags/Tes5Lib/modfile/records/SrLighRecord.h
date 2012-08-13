/*===========================================================================
 *
 * File:		SrLighrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrLighRecord class.
 *
 *=========================================================================*/
#ifndef __SRLIGHRECORD_H
#define __SRLIGHRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlighdatasubrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLighRecord Definition
 *
 *=========================================================================*/
class CSrLighRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrLighRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrStringSubrecord*		m_pModel;
	CSrFloatSubrecord*		m_pFnamData;
	CSrSubrecord*			m_pObndData;
	CSrLighDataSubrecord*	m_pLightData;
	CSrSubrecord*			m_pModtData;
	CSrFormidSubrecord*		m_pSnamData;
	CSrLStringSubrecord*	m_pItemName;

	static srlighdata_t s_NullLightData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrLighRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrLighRecord; }

		/* Get class members */
  srlighdata_t& GetLightData (void) { return m_pLightData ? m_pLightData->GetLightData() : s_NullLightData; }
  const char* GetLightType (void) { return GetSrLightTypeFlagString(GetLightData().Flags); }

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

  void SetLightType (const char* pString) { GetSrLightTypeFlagValue(GetLightData().Flags, pString); }

  
  		/* Begin field method definitions */
	DECLARE_SRFIELD_ITEMNAME(CSrLighRecord)
	DECLARE_SRFIELD_MODEL(CSrLighRecord, SR_NAME_MODL)

	DECLARE_SRFIELD_EDITORID(CSrLighRecord, HoldSound, GetHoldSound, SetHoldSound)
	DECLARE_SRMETHOD_FORMID(HoldSound, m_pSnamData, SR_NAME_SNAM)

	DECLARE_SRFIELD_METHODFLOAT(CSrLighRecord, m_pFnamData, Fade, SR_NAME_FNAM)
	DECLARE_SRFIELD_INT1(CSrLighRecord, Time, GetLightData().Time, GetLightData().Time)
	DECLARE_SRFIELD_DWORD1(CSrLighRecord, Radius, GetLightData().Radius, GetLightData().Radius)
	DECLARE_SRFIELD_DWORD1(CSrLighRecord, Value, GetLightData().Value, GetLightData().Value)
	DECLARE_SRFIELD_DWORDFLAG1(CSrLighRecord, LightFlags, GetLightData().Flags, GetLightData().Flags)	
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, FallOff, GetLightData().FallOff, GetLightData().FallOff)
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, FOV, GetLightData().FOV, GetLightData().FOV)
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, Unknown1, GetLightData().Unknown1, GetLightData().Unknown1)
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, Unknown2, GetLightData().Unknown2, GetLightData().Unknown2)
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, Unknown3, GetLightData().Unknown3, GetLightData().Unknown3)
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, Unknown4, GetLightData().Unknown4, GetLightData().Unknown4)
	DECLARE_SRFIELD_FLOAT1(CSrLighRecord, Weight, GetLightData().Weight, GetLightData().Weight)
	DECLARE_SRFIELD_BYTE1(CSrLighRecord, RedColor,   GetLightData().Color.R, GetLightData().Color.R)
	DECLARE_SRFIELD_BYTE1(CSrLighRecord, GreenColor, GetLightData().Color.G, GetLightData().Color.G)
	DECLARE_SRFIELD_BYTE1(CSrLighRecord, BlueColor,  GetLightData().Color.B, GetLightData().Color.B)
	DECLARE_SRFIELD_BOOL1(CSrLighRecord, Dynamic, GetLightData().Flags, 0x0001)
	DECLARE_SRFIELD_BOOL1(CSrLighRecord, Carried, GetLightData().Flags, 0x0002)
	DECLARE_SRFIELD_BOOL1(CSrLighRecord, SpotShadow, GetLightData().Flags, 0x0400)
	DECLARE_SRFIELD_BOOL1(CSrLighRecord, UnknownFlag1, GetLightData().Flags, 0x0800)
	DECLARE_SRFIELD_BOOL1(CSrLighRecord, UnknownFlag2, GetLightData().Flags, 0x1000)
	DECLARE_SRFIELD_BOOL1(CSrLighRecord, UnknownFlag3, GetLightData().Flags, 0x2000)
	DECLARE_SRFIELD_METHOD(CSrLighRecord, LightType, GetLightType, SetLightType)

};
/*===========================================================================
 *		End of Class CSrLighRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLighRecord.H
 *=========================================================================*/
