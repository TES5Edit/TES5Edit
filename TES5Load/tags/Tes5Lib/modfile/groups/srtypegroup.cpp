/*===========================================================================
 *
 * File:		Srtypegroup.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srtypegroup.h"


/*===========================================================================
 *
 * Class CSrTypeGroup Method - bool AddChildRecord (pNewRecord);
 *
 * Attempts to add the given record to the group or its children. If
 * the record does not belong in the group it is not added and false
 * is returned. On success true is returned.
 *
 * Type groups can only accept records of the same type.
 *
 *=========================================================================*/
bool CSrTypeGroup::AddChildRecord (CSrBaseRecord* pNewRecord) 
{

  if (pNewRecord->GetRecordType() == GetContainsType()) 
  {
    m_pRecords->Add(pNewRecord);
    pNewRecord->SetParentGroup(this);
    return (true);
  }

  return (false);
}
/*===========================================================================
 *		End of Class Method CSrTypeGroup::AddChildRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTypeGroup Method - bool DeleteChildRecord (pNewRecord);
 *
 * Attempts to delete the given record from the group or its children. If
 * the record does not belong in the group it is not deleted and false
 * is returned. On success true is returned.
 *
 *=========================================================================*/
bool CSrTypeGroup::DeleteChildRecord (CSrBaseRecord* pRecord) 
{
  return m_pRecords->Delete(pRecord);
}
/*===========================================================================
 *		End of Class Method CSrTypeGroup::DeleteChildRecord()
 *=========================================================================*/

