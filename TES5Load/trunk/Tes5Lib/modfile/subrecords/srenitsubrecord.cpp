/*===========================================================================
 *
 * File:		Srenitsubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srenitsubrecord.h"


/*===========================================================================
 *
 * Class CSrEnitSubrecord Constructor
 *
 *=========================================================================*/
CSrEnitSubrecord::CSrEnitSubrecord () 
{
}
/*===========================================================================
 *		End of Class CSrEnitSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnitSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEnitSubrecord::Destroy (void) 
{
	CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEnitSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnitSubrecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEnitSubrecord::InitializeNew (void) 
{
	CSrSubrecord::InitializeNew();

	memset(&m_Data, 0, sizeof(m_Data));
	m_Data.EnchantType = SR_ENCHANTTYPE_ENCHANT;

	m_RecordSize = SRENIT_SUBRECORD_SIZE;
}
/*===========================================================================
 *		End of Class Method CSrEnitSubrecord::InitializeNew()
 *=========================================================================*/

