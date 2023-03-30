// ThreadPoolManager.h : main header file for the THREADPOOLMANAGER application
//

#if !defined(AFX_THREADPOOLMANAGER_H__20380BC3_0585_432E_A6D5_B7CE93C1F3FD__INCLUDED_)
#define AFX_THREADPOOLMANAGER_H__20380BC3_0585_432E_A6D5_B7CE93C1F3FD__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CThreadPoolManagerApp:
// See ThreadPoolManager.cpp for the implementation of this class
//

class CThreadPoolManagerApp : public CWinApp
{
public:
	CThreadPoolManagerApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CThreadPoolManagerApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CThreadPoolManagerApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_THREADPOOLMANAGER_H__20380BC3_0585_432E_A6D5_B7CE93C1F3FD__INCLUDED_)
