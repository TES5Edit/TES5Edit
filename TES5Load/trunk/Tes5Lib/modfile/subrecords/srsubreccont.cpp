/*===========================================================================
 *
 * File:		SrSubreccont.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srsubreccont.h"


/*===========================================================================
 *
 * Class CSrSubRecContainer Constructor
 *
 *=========================================================================*/
CSrSubRecContainer::CSrSubRecContainer () 
{

}
/*===========================================================================
 *		End of Class CSrSubRecContainer Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubRecContainer Method - void Destroy (void);
 *
 * Destroy object contents.
 *
 *=========================================================================*/
void CSrSubRecContainer::Destroy (void) 
{
  m_Subrecords.Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSubRecContainer::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubRecContainer Method - void Delete (Type);
 *
 * Delete all subrecords matching the given type.
 *
 *=========================================================================*/
void CSrSubRecContainer::Delete (const srrectype_t Type) 
{
  int Index;

	/* Iterate through the array in reverse looking for name matches */
  for (Index = m_Subrecords.GetSize() - 1; Index >= 0; --Index) 
  {
    if (m_Subrecords[Index]->GetRecordType() == Type) m_Subrecords.Delete(Index);
  }

}
/*===========================================================================
 *		End of Class Method CSrSubRecContainer::Delete()
 *=========================================================================*/
