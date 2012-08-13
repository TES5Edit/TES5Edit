/*===========================================================================
 *
 * File:		SrAmmoRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAmmorecord.h"
#include "../srrecordhandler.h"


srammodata_t CSrAmmoRecord::s_NullAmmoData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAmmoRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrAmmoDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAmmoRecord, CSrItem1Record)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrAmmoRecord, FieldDescription)
	ADD_SRFIELDALL("Projectile",	SR_FIELD_PROJECTILE,	0, CSrAmmoRecord, FieldProjectile)
	ADD_SRFIELDALL("Damage",		SR_FIELD_DAMAGE,		0, CSrAmmoRecord, FieldDamage)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,			0, CSrAmmoRecord, FieldValue)
	ADD_SRFIELDALL("PickupSound",	SR_FIELD_PICKUPSOUND,	0, CSrAmmoRecord, FieldPickupSound)
	ADD_SRFIELDALL("DropSound",		SR_FIELD_DROPSOUND,		0, CSrAmmoRecord, FieldDropSound)
	ADD_SRFIELDALL("IgnoreResist",	SR_FIELD_IGNORERESIST,	0, CSrAmmoRecord, FieldIgnoreResist)
	ADD_SRFIELDALL("Vanish",		SR_FIELD_VANISH,		0, CSrAmmoRecord, FieldVanish)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAmmoRecord Constructor
 *
 *=========================================================================*/
CSrAmmoRecord::CSrAmmoRecord () 
{
	m_pDescription = NULL;
	m_pBoundsData  = NULL;
	m_pDropSound   = NULL;
	m_pPickupSound = NULL;
	m_pAmmoData    = NULL;
}
/*===========================================================================
 *		End of Class CSrAmmoRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAmmoRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAmmoRecord::Destroy (void) 
{
	m_pDescription = NULL;
	m_pBoundsData  = NULL;
	m_pDropSound   = NULL;
	m_pPickupSound = NULL;
	m_pAmmoData    = NULL;

	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAmmoRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAmmoRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAmmoRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pAmmoData != NULL) m_pAmmoData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAmmoRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAmmoRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAmmoRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_OBND)
	{
		m_pBoundsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pAmmoData = SrCastClass(CSrAmmoDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
	{
		m_pPickupSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ZNAM)
	{
		m_pDropSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAmmoRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAmmoRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAmmoRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pBoundsData == pSubrecord)
		m_pBoundsData = NULL;
	else if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pAmmoData == pSubrecord)
		m_pAmmoData = NULL;
	else if (m_pPickupSound == pSubrecord)
		m_pPickupSound = NULL;
	else if (m_pDropSound == pSubrecord)
		m_pDropSound = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAmmoRecord::OnDeleteSubrecord()
 *=========================================================================*/


const char* CSrAmmoRecord::GetProjectile (void)
{
	return m_pAmmoData ? CSrRecord::GetEditorIDHelper(m_pAmmoData->GetAmmoData().ProjectileID) : NULL;
}


void CSrAmmoRecord::SetProjectileID (const srformid_t FormID)
{
	if (m_pAmmoData == NULL)
	{
		AddNewSubrecord(SR_NAME_DATA);
		if (m_pAmmoData == NULL) return;
		m_pAmmoData->InitializeNew();
	}

	m_pAmmoData->GetAmmoData().ProjectileID = FormID;
}


void CSrAmmoRecord::SetProjectile (const char* pEditorID)
{
	if (m_pParent == NULL) return;
	CSrRecord* pRecord = m_pParent->FindEditorID(pEditorID);
	if (pRecord != NULL) SetProjectileID(pRecord->GetFormID());
}


/*===========================================================================
 *
 * Begin CSrAmmoRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAmmoRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAmmoRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAmmoRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAmmoRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAmmoRecord Set Field Methods
 *=========================================================================*/
