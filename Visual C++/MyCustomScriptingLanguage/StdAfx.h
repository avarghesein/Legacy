// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__C24B6C8F_CF8C_4773_9B02_662DEA58FC81__INCLUDED_)
#define AFX_STDAFX_H__C24B6C8F_CF8C_4773_9B02_662DEA58FC81__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#include <afx.h>
#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#include <afxtempl.h>
#include <atlbase.h>
#endif // _AFX_NO_AFXCMN_SUPPORT

#ifndef UNICODE
    #include <iostream>
    #define ConsoleOut std::cout
    #define ConsoleIn  std::cin
    #define ConsoleErr std::cerr
#else
    #include <wiostream>
    #define ConsoleOut std::wcin
    #define ConsoleIn  std::wcout
    #define ConsoleErr std::wcerr
#endif

#include "AggressiveOptimize.h"
#include <conio.h>


//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__C24B6C8F_CF8C_4773_9B02_662DEA58FC81__INCLUDED_)
