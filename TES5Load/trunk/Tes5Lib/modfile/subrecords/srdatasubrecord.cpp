/*===========================================================================
 *
 * File:		SrDataSubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srdatasubrecord.h"


DEFINE_SRALLOCATOR(CSrDataSubrecord)


/*===========================================================================
 *
 * Class CSrDataSubrecord Constructor
 *
 *=========================================================================*/
CSrDataSubrecord::CSrDataSubrecord () :
	m_pData(NULL)
{
   
}
/*===========================================================================
 *		End of Class CSrDataSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Destructor
 *
 *=========================================================================*/
CSrDataSubrecord::~CSrDataSubrecord () 
{

  if (m_pData != NULL) {
    delete[] m_pData;
  }

}
/*===========================================================================
 *		End of Class CSrDataSubrecord Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Method - void Destroy (void);
 *
 * Delete class contents.
 *
 *=========================================================================*/
void CSrDataSubrecord::Destroy (void) 
{
    
  if (m_pData != NULL) {
    delete[] m_pData;
    m_pData = NULL;
  }

}
/*===========================================================================
 *		End of Class Method CSrDataSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Method - void AllocateNew (Size);
 *
 * Allocates a new data buffer the given size.
 *
 *=========================================================================*/
void CSrDataSubrecord::AllocateNew (const dword Size) {

  if (m_pData != NULL) {
    delete[] m_pData;
    m_pData = NULL;
  }

  m_RecordSize = Size;

  m_pData = new byte[Size];
  //memset(m_pData, 0, Size);
}
/*===========================================================================
 *		End of Class Method CSrDataSubrecord::AllocateNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Method - bool Copy (pSubrecord);
 *
 *=========================================================================*/
bool CSrDataSubrecord::Copy (CSrSubrecord* pSubrecord) {
  CSrDataSubrecord* pData;

  if (pSubrecord == NULL) return (false);

  pData = SrCastClass(CSrDataSubrecord, pSubrecord);
  if (pData == NULL) return (false);

  m_RecordSize = pData->GetRecordSize();
  if (m_RecordSize == 0) return (true);

  m_pData = new byte[m_RecordSize];

  memcpy(m_pData, pData->GetData(), m_RecordSize);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrDataSubrecord::Copy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Method - bool ReadData (File);
 *
 * Reads the subrecord data starting from the current location in the 
 * given File. Returns false on any error.
 *
 *=========================================================================*/
bool CSrDataSubrecord::ReadData (CSrFile& File) {
  bool Result;

	/* Delete any existing raw data */
  if (m_pData != NULL) {
    delete[] m_pData;
    m_pData    = NULL;
   }
  
	/* Ignore if no data to load */
  if (m_RecordSize == 0) return (true);

	/* Allocate the raw data buffer */
  m_pData = new byte[m_RecordSize];

	/* Read in the raw data */
  Result = File.Read(m_pData, m_RecordSize);
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrDataSubrecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Method - void SetData (pData, Size);
 *
 *=========================================================================*/
void CSrDataSubrecord::SetData (const byte* pData, const word Size) {

  if (m_pData != NULL) {
    delete[] m_pData;
    m_pData = NULL;
    m_RecordSize = 0;
  }

  if (Size == 0) return;

  m_pData = new byte[Size + 2];
  m_RecordSize = Size;
  memcpy(m_pData, pData, Size);
}
/*===========================================================================
 *		End of Class Method CSrDataSubrecord::SetData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDataSubrecord Method - bool WriteData (File);
 *
 * Write the raw subrecord data. Returns false on any error.
 *
 *=========================================================================*/
bool CSrDataSubrecord::WriteData (CSrFile& File) {
  
  if (m_RecordSize > 0 && m_pData != NULL) {
    return File.Write(m_pData, m_RecordSize);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrDataSubrecord::WriteData()
 *=========================================================================*/
