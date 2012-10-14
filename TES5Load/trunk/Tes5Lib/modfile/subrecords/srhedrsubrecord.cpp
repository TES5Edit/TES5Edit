/*===========================================================================
 *
 * File:		Srhedrsubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srhedrsubrecord.h"


/*===========================================================================
 *
 * Class CSrHedrSubrecord Constructor
 *
 *=========================================================================*/
CSrHedrSubrecord::CSrHedrSubrecord ()
{
}
/*===========================================================================
 *		End of Class CSrHedrSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHedrSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrHedrSubrecord::Destroy (void) 
{
  m_Data.RecordCount  = 0;
  m_Data.Version      = SRHEDR_VERSION_DEFAULT;
  m_Data.NextObjectId = 0;

  CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrHedrSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHedrSubrecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrHedrSubrecord::InitializeNew (void) 
{
  CSrSubrecord::InitializeNew();

  m_Data.RecordCount  = 0;
  m_Data.Version      = SRHEDR_VERSION_DEFAULT;
  m_Data.NextObjectId = 0;

  m_RecordSize = SRHEDR_SUBRECORD_SIZE;
}
/*===========================================================================
 *		End of Class Method CSrHedrSubrecord::InitializeNew()
 *=========================================================================*/
