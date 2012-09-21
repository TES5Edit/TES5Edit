/*===========================================================================
 *
 * File:		Srbbaserecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srbaserecord.h"
#include "../srrecordhandler.h"


/*===========================================================================
 *
 * Class CSrBaseRecord Constructor
 *
 *=========================================================================*/
CSrBaseRecord::CSrBaseRecord () 
{
  m_pParent      = NULL;
  m_pParentGroup = NULL;

  m_CacheFlags   = 0;
}
/*===========================================================================
 *		End of Class CSrBaseRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecord Destructor
 *
 *=========================================================================*/
CSrBaseRecord::~CSrBaseRecord () 
{
  Destroy();
}
/*===========================================================================
 *		End of Class CSrBaseRecord Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecord Method - void Destroy (void);
 *
 * Destroy object contents.
 *
 *=========================================================================*/
void CSrBaseRecord::Destroy (void) 
{
  m_pParentGroup = NULL;
  m_CacheFlags   = 0;
}
/*===========================================================================
 *		End of Class Method CSrBaseRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBaseRecord Method - bool IsActive (void) const;
 *
 *=========================================================================*/
bool CSrBaseRecord::IsActive (void) const 
{
   return (m_pParent ? m_pParent->IsActive() : false); 
}
/*===========================================================================
 *		End of Class Method CSrBaseRecord::IsActive()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ReadSrBaseHeader (File, Header);
 *
 * Helper function to read base header data for a group or record
 * from the current location in the given file.
 *
 *=========================================================================*/
bool ReadSrBaseHeader (CSrFile& File, srbaseheader_t& Header) 
{
  return File.Read(&Header, SR_BASEHEADER_SIZE);
}
/*===========================================================================
 *		End of Function ReadSrBaseHeader()
 *=========================================================================*/
