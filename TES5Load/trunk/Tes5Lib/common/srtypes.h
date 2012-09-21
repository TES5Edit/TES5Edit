/*===========================================================================
 *
 * File:	SrTypes.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Defines common types used in the library, including those which may
 * be platform dependant.
 *
 *=========================================================================*/
#ifndef __SRTYPES_H
#define __SRTYPES_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srversion.h"
  #include "stdlib.h"
  #include "stdio.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Disable deprecated warnings in VC8 */
  #pragma warning( disable : 4996 )

#if !defined(_W64)
  #define _W64
#endif

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Standard unsigned types */
  typedef unsigned char    byte;	/* 8 bits */
  typedef unsigned short   word;	/* 16 bits */
  typedef unsigned int     dword;	/* 32 bits */

#ifdef _WIN32				/* 64 bits, platform specific */
  typedef unsigned __int64 dword64;	
  typedef __int64 int64;
#else
  typedef unsigned long long dword64;
  typedef long long int64;
#endif

	/* Pointer type */
  typedef _W64 unsigned int obptr_t;

	/* File position */
  typedef fpos_t srfilepos;

  	/* Default string character types */
  typedef char SSCHAR;

	/* Standard RGBA color */
  struct srrgba_t {
	byte R;
	byte G;
	byte B;
	byte A;

	//srrgba_t (const dword Value = 0) { *(dword *)&R = Value; }
	//const srrgba_t& operator= (const int Value) { *(dword *)&R = Value; return (*this); }
	operator int (void) { return *(int *)(this); }
   };

  extern const srrgba_t SR_COLOR_NULL;

	/* File operators */
#ifdef _WIN32
  #define SrFtell64(pFile) _telli64(pFile->_file)
  #define SrFseek64(pFile, Offset, Flag) _lseeki64(pFile->_file, Offset, Flag)
#else
  #define SrFtell64(pFile) ftello64(pFile)
  #define SrFseek64(pFile, Offset, Flag) fseeko64(pFile, Offset, Flag)
#endif

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class TAutoPtr Definition
 *
 * Very simple auto-delete pointer template.
 *
 *=========================================================================*/
template<class TObj>
class TAutoPtr {

  /*---------- Begin Private Class Members ----------------------*/
private:
  TObj*		m_pObject;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  TAutoPtr() { m_pObject = NULL; }
  ~TAutoPtr() { if (m_pObject != NULL) { delete[] m_pObject; } }

  operator TObj* (void) { return (m_pObject); }
  const TObj* operator= (const TObj* pValue) { m_pObject = (TObj *) pValue; return (m_pObject); }

 };

	/* Some default template definitions */
typedef class TAutoPtr<byte> TByteAutoPtr;
typedef class TAutoPtr<char> TCharAutoPtr;

/*===========================================================================
 *		End of Class TAutoPtr Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

	/* Flips flag bits */
  inline void FlipFlagBits(dword& Data, const dword Mask, const bool Flag) {
    if (Flag) Data |= Mask; else Data &= ~Mask;
   }

  inline void FlipFlagBits(word& Data, const word Mask, const bool Flag) {
    if (Flag) Data |= Mask; else Data &= ~Mask;
   }

  inline void FlipFlagBits(byte& Data, const byte Mask, const bool Flag) {
    if (Flag) Data |= Mask; else Data &= ~Mask;
   }

	/* Check flag bits */
  inline bool CheckFlagBits (const dword Data, const dword Mask) {
    return ((Data & Mask) != 0);
   }

  inline bool CheckFlagBits (const word Data, const word Mask) {
    return ((Data & Mask) != 0);
   }

  inline bool CheckFlagBits (const byte Data, const byte Mask) {
    return ((Data & Mask) != 0);
   }

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srtypes.H
 *=========================================================================*/
