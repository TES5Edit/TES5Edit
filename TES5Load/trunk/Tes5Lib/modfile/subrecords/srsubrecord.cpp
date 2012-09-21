/*===========================================================================
 *
 * File:	Srsubrecord.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srsubrecord.h"
#include "../records/srrecordfield.h"
#include "limits.h"


/*===========================================================================
 *
 * Class CSrSubrecord Constructor
 *
 *=========================================================================*/
CSrSubrecord::CSrSubrecord () : 
	m_RecordType(SR_NAME_NULL), m_RecordSize(0)
{
  
}
/*===========================================================================
 *		End of Class CSrSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Destructor
 *
 *=========================================================================*/
CSrSubrecord::~CSrSubrecord ()
{

}
/*===========================================================================
 *		End of Class CSrSubrecord Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - void Destroy (void);
 *
 * Delete class contents.
 *
 *=========================================================================*/
void CSrSubrecord::Destroy (void)
{
  m_RecordType  = SR_NAME_NULL;
  m_RecordSize  = 0;
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
bool CSrSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) {

  switch (FieldID)
  {
    case SR_FIELD_RECORDTYPE:
	Result = strnicmp(GetRecordType(), pSubrecord->GetRecordType(), SR_RECTYPE_SIZE);
	return (true);
  }

	/* No match */
  return (false);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - bool Copy (pSubrecord);
 *
 *=========================================================================*/
bool CSrSubrecord::Copy (CSrSubrecord* pSubrecord)
{

  Destroy();

  if (pSubrecord == NULL) return (false);

  m_RecordSize = pSubrecord->GetRecordSize();

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::Copy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - dword Search (srfinddata_t& FindData);
 *
 *=========================================================================*/
dword CSrSubrecord::Search (srfinddata_t& FindData)
{
  dword       Count;
  dword       FindCount = 0;

  ++FindData.SubrecordCount;

	/* Look in the subrecord header if required */
  if (FindData.Flags & SR_FIND_SUBRECORDHEADER)
  {
    Count      = SrFindData((const byte*) &m_RecordType, 6, FindData);
    FindCount += Count;
  }

	/* Look in the subrecord data */
  if (GetData() != NULL) FindCount += SrFindData(GetData(), GetRecordSize(), FindData);
  return (FindCount);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::Search()
 *=========================================================================*/

 
/*===========================================================================
 *
 * Class CSrSubrecord Method - dword SearchText (srfinddata_t& FindData);
 *
 *=========================================================================*/
dword CSrSubrecord::SearchText (srfinddata_t& FindData)
{
  dword       Count;
  dword       FindCount = 0;

  ++FindData.SubrecordCount;

	/* Look in the subrecord header if required */
  if ((FindData.Flags & SR_FIND_SUBRECORDHEADER) != 0)
  {
    Count      = SrFindTextData((const byte*) &m_RecordType, 6, FindData);
    FindCount += Count;
  }

	/* Look in the subrecord data */
  FindCount += SrFindTextData(GetData(), GetRecordSize(), FindData);
  return (FindCount);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::SearchText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
bool CSrSubrecord::GetField (CSString& Buffer, const int FieldID)
{
  
  switch (FieldID)
  {
    case SR_FIELD_RECORDTYPE:
        Buffer.Format("%4.4s", GetRecordType().Name);
	break;
    default:
	return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::GetField()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - bool Read (File);
 *
 * Reads the subrecord data starting from the current location in the 
 * given File. Returns false on any error.
 *
 *=========================================================================*/
bool CSrSubrecord::Read (CSrFile& File)
{
  return ReadData(File);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::Read()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - bool ReadData (File);
 *
 * Reads the subrecord data starting from the current location in the 
 * given File. Returns false on any error.
 *
 *=========================================================================*/
bool CSrSubrecord::ReadData (CSrFile& File)
{
  return File.SeekCur(m_RecordSize);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - bool Write (File);
 *
 * Write the subrecord starting from the current location in the given File.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CSrSubrecord::Write (CSrFile& File)
{
  bool Result;
  
  	/* Output the subrecord header */
  Result = File.Write(&m_RecordType, SR_RECTYPE_SIZE);
  if (!Result) return (false);

  if (m_RecordSize > USHRT_MAX)
  { 
    Result = File.WriteWord(0);
    if (!Result) return (false);
  }
  else
  {
    Result = File.WriteWord(GetRecordSize());
    if (!Result) return (false);
   }

  return WriteData(File);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::Write()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSubrecord Method - bool WriteData (File);
 *
 * Write the raw subrecord data. Returns false on any error.
 *
 *=========================================================================*/
bool CSrSubrecord::WriteData (CSrFile& File)
{
  
  if (m_RecordSize > 0)
  {
    return File.SeekCur(m_RecordSize);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrSubrecord::WriteData()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ReadObSubRecordHeader (File, Header);
 *
 * Reads in a subrecord header. Returns false on any error.
 *
 *=========================================================================*/
bool ReadSrSubRecordHeader (CSrFile& File, srsubrecheader_t& Header)
{
  
	/* Input the record header */
  return File.Read(&Header, sizeof(Header));
}
/*===========================================================================
 *		End of Function ReadSrSubRecordHeader()
 *=========================================================================*/

