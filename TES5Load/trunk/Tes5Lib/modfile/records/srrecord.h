/*===========================================================================
 *
 * File:		SbRecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrRecord class from which all main record classes 
 * will be derived from.
 *
 *=========================================================================*/
#ifndef __OBRECORD_H
#define __OBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../../common/srmemfile.h"
  #include "../subrecords/srdatasubrecord.h"
  #include "../subrecords/srdwordsubrecord.h"
  #include "../subrecords/srlongsubrecord.h"
  #include "../subrecords/srwordsubrecord.h"
  #include "../subrecords/srformidsubrecord.h"
  #include "../subrecords/srsubreccont.h"
  #include "../subrecords/srstringsubrecord.h"
  #include "../subrecords/srfloatsubrecord.h"
  #include "srbaserecord.h"
  #include "srrecordfield.h"
  #include "../srrectypeinfo.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Record flags */
  #define SR_RECFLAG_MASTER         0x00000001
  #define SR_RECFLAG_DELETED        0x00000020
  #define SR_RECFLAG_LOCALSTRINGS   0x00000080
  #define SR_RECFLAG_CASTSHADOWS    0x00000200
  #define SR_RECFLAG_QUESTITEM      0x00000400
  #define SR_RECFLAG_INITDISABLED   0x00000800
  #define SR_RECFLAG_IGNORED        0x00001000
  #define SR_RECFLAG_VISIBLEDISTANT 0x00008000
  #define SR_RECFLAG_DANGEROUS      0x00020000
  #define SR_RECFLAG_COMPRESSED     0x00040000
  #define SR_RECFLAG_CANTWAIT       0x00080000
  
	/* Used when compressing data for output (arbitrary) */
  #define SR_ZLIBCOMPRESS_BUFFER 8192

	/* The compression level to use */
  #define SR_ZLIB_DEFLATELEVEL 6

	/* Default buffer sizes used for input and output operations */
  #define SR_ZLIB_BUFFERSIZE 200000

  	/* Static array for creating the record's subrecords */
  #define DECLARE_SRSUBRECCREATE()	protected: \
		 static  const srsubreccreate_t   s_SubrecCreate; \
		 static  const srsubrecentries_t  s_SubrecEntries[]; \
		 virtual const srsubreccreate_t*  GetSubrecCreate     (void) const { return (&s_SubrecCreate); }

	/* Used to define a subrecord creation array */
  #define BEGIN_SRSUBRECCREATE(Class, BaseClass) \
	const srsubreccreate_t   Class::s_SubrecCreate = { &BaseClass::s_SubrecCreate, Class::s_SubrecEntries }; \
	const srsubrecentries_t  Class::s_SubrecEntries[] = {

  #define DEFINE_SRSUBRECCREATE(Name, Method) { &Name, Method }, 

  #define END_SRSUBRECCREATE() { NULL, NULL } }; 

		/* Most records have a version of 40 in Skyrim */
  #define SR_RECORD_DEFAULTVERSION 40

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* Record header type */
  struct srrecheader_t
  {
	srrectype_t	RecordType;
	dword		Size;
	dword		Flags1;
	srformid_t	FormID;
	dword		Flags2;
	word		Version;
	word		Unknown;

		/* Copy operators */
	const srrecheader_t& operator= (const srbaseheader_t& Header) { *this = *(srrecheader_t *) &Header; return (*this); }
  };


#pragma pack(pop)

	/* Pointer to a class method to create a record object */
  class CSrRecord;
  typedef CSrRecord* (*SRREC_CREATEFUNC) (void);

	/* Structure to hold information on record creation */
  struct srreccreate_t
  {
	const srrectype_t*	pType;
	SRREC_CREATEFUNC	CreateMethod;
  };

	/* Array of record pointers */
  typedef CSrPtrArray<CSrRecord>    CSrRecordArray;
  typedef CSrRefPtrArray<CSrRecord> CSrRefRecordArray;
  
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRecord Definition
 *
 * The base record class from which all other record classes will be derived
 * from. The base class considers the record data as merely a collection
 * of sub-records and groups.
 *
 * sizeof(CSrRecord) = 36
 *	Vtable		= 4
 *	Header		= 24
 *	Subrecords	= 12
 *	Members		= 0
 *	Total =========== 40
 *
 *=========================================================================*/
class CSrRecord : public CSrBaseRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrRecord, CSrBaseRecord)
  DECLARE_SRALLOCATOR(CSrRecord, CSrRecord)


  /*---------- Begin Protected Class Members --------------------*/
protected:
  srrecheader_t		m_Header;		/* Record header data */
  CSrSubrecordArray	m_Subrecords;

  long				m_UserData;		/* Custom user data */

	/* Static buffers used when loading and saving */
  static CSrMemFile	s_MemFile;
  static byte*		s_pTempBuffer;
  static dword		s_TempBufferSize;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Find a subrecord creation method from this and any any classes */
  SRSUBREC_CREATEFUNC FindSubrecCreate (const srrectype_t Type);

	/* Change all formid subrecords of the given type */
  virtual dword ChangeFormidSubrecords (const srrectype_t Type, const srformid_t NewID, const srformid_t OldID);
  virtual dword ChangeFormidSubrecords (const srformid_t NewID, const srformid_t OldID);

	/* Fixup all formid subrecords of the given type */
  virtual bool FixupFormidSubrecords (const srrectype_t Type, CSrFormidFixupArray& FixupArray);
  virtual bool FixupFormidSubrecords (CSrFormidFixupArray& FixupArray);

	/* Initialize a map of all class fields */
  bool InitializeFieldMap (CSrRecFieldIDMap& s_FieldIDMap);

  void LoadLocalStrings (CSrCallback* pCallback);

	/* Input and output helpers */
  bool ReadSubRecords      (CSrFile& File);
  bool ReadCompressedData  (CSrFile& File);
  bool WriteSubRecords     (CSrFile& File);
  bool WriteCompressedData (CSrFile& File);
  bool WriteRecordSize     (CSrFile& File, const int Offset);
  bool WriteDeflate        (CSrFile& File, CSrMemFile& RecordData);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrRecord();
  virtual ~CSrRecord();
  virtual void Destroy (void);

	/* Records cannot contain other records */
  bool AddChildRecord    (CSrBaseRecord* ) { return (false); }
  bool DeleteChildRecord (CSrBaseRecord* ) { return (false); }

	/* Create a new subrecord */
  CSrSubrecord* AddNewSubrecord     (const srrectype_t      Type); 
  CSrSubrecord* AddInitNewSubrecord (const srrectype_t      Type); 
  CSrSubrecord* AddNewSubrecord     (const srsubrecheader_t Header); 
  CSrSubrecord* CreateSubrecord     (const srsubrecheader_t Header);
  CSrSubrecord* CreateSubrecord     (const srrectype_t      Type);

  CSrSubrecord* AddNewSubrecordAfter     (const srsubrecheader_t Header, const srrectype_t AddAfter); 
  CSrSubrecord* AddNewSubrecordAfter     (const srrectype_t Type, const srrectype_t AddAfter); 
  CSrSubrecord* AddInitNewSubrecordAfter (const srrectype_t Type, const srrectype_t AddAfter);

	/* Static methods to initialize/destroy temporary input/output buffers */
  static bool InitIOBuffers    (void);
  static void DestroyIOBuffers (void);

	/* Change one ID for another */
  virtual dword ChangeFormID   (const srformid_t NewID, const srformid_t OldID);
  virtual dword ChangeEditorID (const SSCHAR*   pNewID, const SSCHAR*   pOldID);

	/* Compares fields in two records */
  virtual int CompareFields (const srrecfieldid_t FieldID, CSrRecord* pRecord);

	/* Count the number of subrecords of the given type */
  virtual int CountSubrecords (const srrectype_t Type);

	/* Count the uses of the given form */
  virtual dword CountUses (const srformid_t FormID);

	/* Copy an existing record content */
  bool Copy (CSrRecord* pRecord);
  
	/* Return a new instance of the class */
  //static CSrRecord* Create (void) { return new CSrRecord; }

	/* Deletes all subrecords of the given type */
  int DeleteSubrecords (const srrectype_t Type);

	/* Export/import the record to other formats */
  bool ExportCsv    (srcsvinfo_t& CsvInfo);
  bool ImportCsvRow (srcsvinfo_t& CsvInfo, CCsvRow& Row);

  const char* GetEditorIDHelper (CSrFormidSubrecord* pSubrecord);
  const char* GetEditorIDHelper (const srformid_t FormID);
  void SetSubrecordFormID (CSrFormidSubrecord* pSubrecord, const srformid_t FormID, const srrectype_t Type);
  void SetSubrecordFormID (CSrFormidSubrecord* pSubrecord, const char*   pEditorID, const srrectype_t Type);
  void SetSubrecordFormID (srformid_t& ResultFormID, const char* pEditorID);

	/* Find information in the record */
  virtual bool Search     (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback = NULL);
  virtual bool SearchText (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback = NULL);

	/* Find a subrecord */
  CSrSubrecord* FindSubrecord      (const srrectype_t Type);
  CSrSubrecord* FindFirstSubrecord (const srrectype_t Type, int& Position) { Position = -1; return FindNextSubrecord(Type, Position); }
  CSrSubrecord* FindNextSubrecord  (const srrectype_t Type, int& Position);

	/* Find a record based on its formID */
  CSrBaseRecord* FindFormID (const srformid_t FormID) { return (m_Header.FormID == FormID ? this : NULL); }

  	/* Fixup the modindex of formids */
  virtual bool FixupFormids (CSrFormidFixupArray& FixupArray);
  
	/* Get a string representation of a record field */
  bool GetField (CSString& Buffer, const srrecfieldid_t FieldID);

  	/* Computes the size in bytes needed to output all sub-records */
  dword GetSubrecordSize (void);

	/* Access subrecords */
  CSrSubrecord*      GetSubrecord         (CSrSubrecord* pSubrecord, const int Offset, const srrectype_t Type);
  CSrSubrecord*      GetSubrecord         (const dword Index) { return m_Subrecords.GetAt(Index); }
  dword              GetNumSubrecords     (void) { return m_Subrecords.GetSize(); }
  CSrSubrecordArray& GetSubrecordArray    (void) { return m_Subrecords; }

	/* Get record members */
  srformid_t        GetFormID     (void) const { return (m_Header.FormID); }
  const srrectype_t GetRecordType (void) const { return (m_Header.RecordType); }
  dword	            GetFlags      (void) const { return (m_Header.Flags1); }
  bool              IsRecord      (void) const { return (true); }
  long				GetUserData   (void) const { return (m_UserData); }
  srrecheader_t&    GetHeader     (void)       { return (m_Header); }

	/* Get record flags */
  bool IsCompressed			(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_COMPRESSED); }
  bool IsDeleted			(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_DELETED); }
  bool IsQuestItem			(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_QUESTITEM); }
  bool IsDangerous			(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_DANGEROUS); }
  bool IsMaster				(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_MASTER); }
  bool IsCastShadows		(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_CASTSHADOWS); }
  bool IsIgnored			(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_IGNORED); }
  bool IsInitiallyDisabled	(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_INITDISABLED); }
  bool IsVisibleDistant		(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_VISIBLEDISTANT); }
  bool IsCantWait			(void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_CANTWAIT); }
  bool IsLocalStrings       (void) const { return CheckFlagBits(m_Header.Flags1, SR_RECFLAG_LOCALSTRINGS); }

	/* Check the record against a form type (script function parameter) */
  virtual bool IsFormType      (const int Type);
  
  	/* Initialize the record with the given header */
  void Initialize (const srbaseheader_t Header) { m_Header = Header; }
  void Initialize (const srrectype_t    Type)   { m_Header.RecordType = Type; m_Header.Size = 0; m_Header.FormID = 0; }

	/* Initialize a new record */
  virtual void InitializeNew (void);

  void MoveToEnd (const srrectype_t Name);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	/* Attempt to read the record data from a file */
  virtual bool ReadData (CSrFile& File);

	/* Set record flags */
  void SetCompressed		(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_COMPRESSED,		Flag); }
  void SetDeleted			(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_DELETED,		Flag); }
  void SetQuestItem			(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_QUESTITEM,		Flag); }
  void SetDangerous			(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_DANGEROUS,		Flag); }
  void SetMaster			(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_MASTER,			Flag); }
  void SetIgnored			(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_IGNORED,		Flag); }
  void SetCastShadows		(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_CASTSHADOWS,	Flag); }
  void SetInitiallyDisabled	(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_INITDISABLED,	Flag); }
  void SetVisibleDistant	(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_VISIBLEDISTANT,	Flag); }
  void SetCantWait			(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_CANTWAIT,		Flag); }
  void SetLocalStrings		(const bool       Flag)  { FlipFlagBits(m_Header.Flags1, SR_RECFLAG_LOCALSTRINGS,	Flag); }
  void SetFormID			(const srformid_t Value) { m_Header.FormID = Value; }
  void SetUserData			(const long       Value) { m_UserData      = Value; }

  	/* Set a  record field from a string value */
  bool SetField (const srrecfieldid_t FieldID, const SSCHAR* pString);

  void UpdateLoadLocalString (const bool LoadLocal);
  
	/* Output the record to a file */
  bool Write (CSrFile& File);

	/* Begin field method definitions */
  DECLARE_SRFIELD(FieldFormID)
  DECLARE_SRFIELD(FieldName)
  DECLARE_SRFIELD(FieldRecordFlags)
  DECLARE_SRFIELD(FieldUserData)
  DECLARE_SRFIELD(FieldQuestItem)
  DECLARE_SRFIELD(FieldIgnored)
  DECLARE_SRFIELD(FieldDangerous)
  DECLARE_SRFIELD(FieldDeleted)

};
/*===========================================================================
 *		End of Class CSrBaseRecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin More Type Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

	/* Find a */
  const srrecfield_t* FindSrFieldEntry (const srrecfieldmap_t* pFieldMap, const srrecfieldid_t FieldID);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File ObRecord.H
 *=========================================================================*/
