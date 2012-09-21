/*===========================================================================
 *
 * File:		SrCtdasubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srctdasubrecord.h"


/*===========================================================================
 *
 * Class CSrCtdaSubrecord Method - bool IsFormidParam1 (FunctionCode);
 *
 *=========================================================================*/
bool CSrCtdaSubrecord::IsFormidParam1 (const int FunctionCode) 
{
	srfunction_t* pFunction = GetSrFunction(FunctionCode + SR_CTDA_FUNCOFFSET);
	if (pFunction == NULL) return false;
	if (pFunction->NumParams < 1) return false;

	return IsSrFunctionParamFormID(pFunction->Params[0].Type);
}
/*===========================================================================
 *		End of Class Method CSrCtdaSubrecord::IsFormidParam1()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCtdaSubrecord Method - bool IsFormidParam2 (FunctionCode);
 *
 *=========================================================================*/
bool CSrCtdaSubrecord::IsFormidParam2 (const int FunctionCode) 
{
	srfunction_t* pFunction = GetSrFunction(FunctionCode + SR_CTDA_FUNCOFFSET);
	if (pFunction == NULL) return false;
	if (pFunction->NumParams < 2) return false;

	return IsSrFunctionParamFormID(pFunction->Params[1].Type);
}
/*===========================================================================
 *		End of Class Method CSrCtdaSubrecord::IsFormidParam2()
 *=========================================================================*/


bool CSrCtdaSubrecord::IsFormidParam3 (const int FunctionCode) 
{
	srfunction_t* pFunction = GetSrFunction(FunctionCode + SR_CTDA_FUNCOFFSET);
	if (pFunction == NULL) return false;
	if (pFunction->NumParams < 3) return false;

	return IsSrFunctionParamFormID(pFunction->Params[2].Type);
}


bool CSrCtdaSubrecord::IsStringParam1 (void) 
{
	srfunction_t* pFunction = GetSrFunction(m_Data.Function + SR_CTDA_FUNCOFFSET);
	if (pFunction == NULL) return false;
	if (pFunction->NumParams < 1) return false;

	return IsSrFunctionParamString(pFunction->Params[0].Type);
}


bool CSrCtdaSubrecord::IsStringParam2 (void) 
{
	srfunction_t* pFunction = GetSrFunction(m_Data.Function + SR_CTDA_FUNCOFFSET);
	if (pFunction == NULL) return false;
	if (pFunction->NumParams < 2) return false;

	return IsSrFunctionParamString(pFunction->Params[1].Type);
}


bool CSrCtdaSubrecord::IsStringParam3 (void) 
{
	srfunction_t* pFunction = GetSrFunction(m_Data.Function + SR_CTDA_FUNCOFFSET);
	if (pFunction == NULL) return false;
	if (pFunction->NumParams < 3) return false;

	return IsSrFunctionParamString(pFunction->Params[2].Type);
}



/*===========================================================================
 *
 * Class CSrCtdaSubrecord Method - dword ChangeFormID (NewID, OldID);
 *
 *=========================================================================*/
dword CSrCtdaSubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
{
	dword Count = 0;

	if (IsFormidParam1() && (srformid_t) m_Data.Parameter1 == OldID) 
	{
		m_Data.Parameter1 = NewID;
		++Count;
	}

	if (IsFormidParam2() && (srformid_t) m_Data.Parameter2 == OldID) 
	{
		m_Data.Parameter2 = NewID;
		++Count;
	}

	if (IsFormidParam3() && (srformid_t) m_Data.Parameter3 == OldID) 
	{
		m_Data.Parameter3 = NewID;
		++Count;
	}

	if (m_Data.ReferenceID == OldID)
	{
		m_Data.ReferenceID = OldID;
		++Count;
	}

	return Count; 
}
/*===========================================================================
 *		End of Class Method CSrCtdaSubrecord::ChangeFormID()
 *=========================================================================*/


dword CSrCtdaSubrecord::CountUses (const srformid_t FormID)
{
	int Count = 0;

	if (IsFormidParam1() && (srformid_t) m_Data.Parameter1 == FormID) ++Count;
	if (IsFormidParam2() && (srformid_t) m_Data.Parameter2 == FormID) ++Count;
	if (IsFormidParam3() && (srformid_t) m_Data.Parameter3 == FormID) ++Count;

	return Count;
}


/*===========================================================================
 *
 * Class CSrCtdaSubrecord Method - bool FixupFormID (FixupArray);
 *
 *=========================================================================*/
bool CSrCtdaSubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) 
{
	bool Result = true;

	if (IsFormidParam1()) 
	{
		Result &= SrFixupFormid(*(srformid_t *)&m_Data.Parameter1, m_Data.Parameter1, FixupArray);
	}

	if (IsFormidParam2()) 
	{
		Result &= SrFixupFormid(*(srformid_t *)&m_Data.Parameter2, m_Data.Parameter2, FixupArray);
	}

	if (IsFormidParam3()) 
	{
		Result &= SrFixupFormid(*(srformid_t *)&m_Data.Parameter3, m_Data.Parameter3, FixupArray);
	}

	Result &= SrFixupFormid(m_Data.ReferenceID, m_Data.ReferenceID, FixupArray);

	return (Result);
}
/*===========================================================================
 *		End of Class Method CSrCtdaSubrecord::FixupFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCtdaSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
bool CSrCtdaSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) 
{
	CSrCtdaSubrecord* pCond1 = SrCastClass(CSrCtdaSubrecord, pSubrecord);

	if (pCond1 != NULL) 
	{
		switch (FieldID) 
		{
		case SR_FIELD_RUNON:
			if (m_Data.RunOnType == pCond1->m_Data.RunOnType) Result = 0;
			else if (m_Data.RunOnType > pCond1->m_Data.RunOnType) Result = 1;
			else Result = -1;
			return true;
		case SR_FIELD_OPERATOR:
			Result = (int) m_Data.CompareType -  (int) pCond1->m_Data.CompareType;
			return true;
		case SR_FIELD_REFERENCE:
			Result = m_Data.ReferenceID - pCond1->m_Data.ReferenceID;
			return (true);
		case SR_FIELD_FUNCTION:
			Result =  (int) m_Data.Function -  (int) pCond1->m_Data.Function;
			return (true);
		case SR_FIELD_VALUE:
			Result = (int)((m_Data.Value - pCond1->m_Data.Value)*100);
			return (true);
		case SR_FIELD_PARAM1:
			Result = m_Data.Parameter1 - pCond1->m_Data.Parameter1;
			return (true);
		case SR_FIELD_PARAM2:
			Result = m_Data.Parameter2 - pCond1->m_Data.Parameter2;
			return (true);
		case SR_FIELD_PARAM3:
			Result = m_Data.Parameter3 - pCond1->m_Data.Parameter3;
			return (true);
		case SR_FIELD_CONDFLAGS:
		case SR_FIELD_CONDFLAGSEX:
			Result = m_Data.Flags - pCond1->m_Data.Flags;
			return (true);
		}

	}

		/* No match */
	return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
}
/*===========================================================================
 *		End of Class Method CSrCtdaSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCtdaSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
bool CSrCtdaSubrecord::GetField (CSString& Buffer, const int FieldID) 
{
	srfunction_t* pFunction = GetSrFunction(m_Data.Function + SR_CTDA_FUNCOFFSET);
  
	switch (FieldID) 
	{
	case SR_FIELD_RUNON:
		Buffer = GetSrConditionRunonTypeString(m_Data.RunOnType);
		return true;
    case SR_FIELD_OPERATOR:
		Buffer = GetSrConditionOperatorString(m_Data.CompareType);
		return (true);
    case SR_FIELD_REFERENCE:
		if (m_Data.ReferenceID > 0) Buffer.Format("0x%08X", m_Data.ReferenceID);
		return (true);
    case SR_FIELD_FUNCTION:
		if (pFunction)
			Buffer = pFunction->Name;
		else
			Buffer.Format("0x%04X", m_Data.Function + SR_CTDA_FUNCOFFSET);			
		return (true);
    case SR_FIELD_VALUE:
        Buffer.Format("%g", m_Data.Value);
		return (true);
    case SR_FIELD_PARAM1:
		Buffer.Format("0x%08X", m_Data.Parameter1);
		return (true);
	case SR_FIELD_PARAM2:
		Buffer.Format("0x%08X", m_Data.Parameter2);
		return (true);
	case SR_FIELD_PARAM3:
		Buffer.Format("0x%08X", m_Data.Parameter3);
		return (true);
	case SR_FIELD_CONDFLAGS:
		Buffer.Format("0x%02X", m_Data.Flags);
		return true;
	case SR_FIELD_CONDFLAGSEX:
		Buffer.Format("%s%s%s%s%s(%02X)", CheckFlagBits(m_Data.Flags, SR_CTDA_FLAG_OR) ? "OR " : "AND ", 
								  CheckFlagBits(m_Data.Flags, SR_CTDA_FLAG_USEQUESTALIASES) ? "QST " : "",
								  CheckFlagBits(m_Data.Flags, SR_CTDA_FLAG_USEGLOBAL) ? "GLOB " : "",
								  CheckFlagBits(m_Data.Flags, SR_CTDA_FLAG_USEPACKDATA) ? "PACK " : "",
								  CheckFlagBits(m_Data.Flags, SR_CTDA_FLAG_SWAPSUBJECTTARGET) ? "SWAP " : "",
								  m_Data.Flags);
		return true;
	}

	return CSrSubrecord::GetField(Buffer, FieldID);
}
/*===========================================================================
 *		End of Class Method CSrCtdaSubrecord::GetField()
 *=========================================================================*/
