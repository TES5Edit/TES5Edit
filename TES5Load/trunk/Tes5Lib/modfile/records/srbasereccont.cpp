/*===========================================================================
 *
 * File:		SrBaseRecCont.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srbasereccont.h"



/*===========================================================================
 *
 * Class CSrBaseRecordCont Method - bool Delete (pObject);
 *
 *=========================================================================*/
bool CSrBaseRecordCont::Delete (CSrBaseRecord* pObject) { 
  CSrBaseRecord* pRecord;
  dword		 Index;
  bool		 Result;

  for (Index = 0; Index < m_Records.GetSize(); ++Index) {
    pRecord = m_Records[Index];

    if (pRecord == pObject) {
      m_Records.Delete(Index);
      return (true);
     }

    Result = pRecord->DeleteChildRecord(pObject);
    if (Result) return (true);
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CSrBaseRecordCont::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefBaseRecordCont Method - bool Delete (pObject);
 *
 *=========================================================================*/
bool CSrRefBaseRecordCont::Delete (CSrBaseRecord* pObject) { 
  CSrBaseRecord* pRecord;
  dword		 Index;
  bool		 Result;

  for (Index = 0; Index < m_Records.GetSize(); ++Index) {
    pRecord = m_Records[Index];

    if (pRecord == pObject) {
      m_Records.Delete(Index);
      return (true);
     }

    Result = pRecord->DeleteChildRecord(pObject);
    if (Result) return (true);
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CSrRefBaseRecordCont::Delete()
 *=========================================================================*/
