// Sample Client.h : main header file for the SAMPLE CLIENT application
//

#if !defined(AFX_SAMPLECLIENT_H__8AFC02CD_F06F_4465_BDC4_0601BBE805CC__INCLUDED_)
#define AFX_SAMPLECLIENT_H__8AFC02CD_F06F_4465_BDC4_0601BBE805CC__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CSampleClientApp:
// See Sample Client.cpp for the implementation of this class
//

class CSampleClientApp : public CWinApp
{
public:
	CSampleClientApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSampleClientApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CSampleClientApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SAMPLECLIENT_H__8AFC02CD_F06F_4465_BDC4_0601BBE805CC__INCLUDED_)
