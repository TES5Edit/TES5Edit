/*===========================================================================
 *
 * File:	EsmScriptOptions.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Tuesday, February 11, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRIPTOPTIONS_H
#define __ESMSCRIPTOPTIONS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Format type indices */
  #define ESMSCRIPT_FORMAT_DEFAULT	0
  #define ESMSCRIPT_FORMAT_SYMBOL	1
  #define ESMSCRIPT_FORMAT_FUNCTION	2
  #define ESMSCRIPT_FORMAT_RESERVED	3
  #define ESMSCRIPT_FORMAT_INTEGER	4
  #define ESMSCRIPT_FORMAT_FLOAT	5
  #define ESMSCRIPT_FORMAT_STRING	6
  #define ESMSCRIPT_FORMAT_COMMENT	7
  #define ESMSCRIPT_FORMAT_OPERATOR	8  
  #define ESMSCRIPT_FORMAT_ERROR	9
  #define ESMSCRIPT_FORMAT_MAX		9
  #define ESMSCRIPT_NUMFORMATS		10

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScriptOptions Definition
 *
 * Description
 *
 *=========================================================================*/
class CEsmScriptOptions {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CFont		m_TextFont;		/* Base font for the rich edit control */
  COLORREF	m_BackgroundColor;	/* Background color of control */
  bool		m_NoToolTips;		/* Disable any tools tips */
	
			/* Formatting structures for the rich edit control */
  CHARFORMAT2	m_Formats[ESMSCRIPT_NUMFORMATS];

  
  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmScriptOptions();
  virtual ~CEsmScriptOptions() { Destroy(); }
  virtual void Destroy (void);

	/* Create default formats */
  void CreateDefaultWhiteFormat (void);
  void CreateDefaultBlueFormat  (void);

	/* Get class members */
  CFont*	GetTextFont   (void)		{ return (&m_TextFont); }
  COLORREF	GetBGColor    (void)		{ return (m_BackgroundColor); }
  CHARFORMAT2*  GetCharFormat (const int Index) { return (Index >= 0 && Index <= ESMSCRIPT_FORMAT_MAX) ? &m_Formats[Index] : NULL; } 
  bool		GetNoToolTips (void) const      { return (m_NoToolTips); }

	/* Initializes the given format */
  static void InitCharFormat (CHARFORMAT2& Format, COLORREF Color);

	/* Set class members */
  void SetBGColor    (COLORREF Color)			{ m_BackgroundColor = Color; }
  void SetCharFormat (const int Index, COLORREF Color)	{ if (Index >= 0 && Index <= ESMSCRIPT_FORMAT_MAX) InitCharFormat(m_Formats[Index], Color); }
  void SetNoToolTips (const bool Flag)			{ m_NoToolTips = Flag; }

	/* Read options from the application registry */
  bool ReadFromRegistry  (void);
  bool ReadRegCharFormat (void);
  bool ReadRegFont       (void);

  	/* Write options to the application registry */
  bool WriteToRegistry    (void);
  bool WriteRegCharFormat (void);
  bool WriteRegFont       (void);

	/* Standard copy operator */
  const CEsmScriptOptions& operator= (CEsmScriptOptions& Options);

 };
/*===========================================================================
 *		End of Class CEsmScriptOptions Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File EsmScriptOptions.H
 *=========================================================================*/
