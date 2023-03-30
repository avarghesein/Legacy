// MyClock.cpp : Defines the class behaviors for the application.
//

#pragma once

#include "stdafx.h"
#include "MyClock.h"
#include "MyClockDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMyClockApp

BEGIN_MESSAGE_MAP(CMyClockApp, CWinApp)
	//{{AFX_MSG_MAP(CMyClockApp)
	//}}AFX_MSG_MAP
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMyClockApp construction

CMyClockApp::CMyClockApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CMyClockApp object

CMyClockApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CMyClockApp initialization

BOOL CMyClockApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

    if( 0 == m_wndOwner.m_hWnd )
    {
		// This block is to make to remove the icons from the task bar for the application
		// We create a hidden window and making it as the parent of our clock so that
		// No task bar icon will be shown
        LPCTSTR pstrOwnerClass = AfxRegisterWndClass( 0 ) ;
        if ( !m_wndOwner.CreateEx( 0, pstrOwnerClass, _T(""), WS_POPUP, CW_USEDEFAULT,
				                   CW_USEDEFAULT,
				                   CW_USEDEFAULT,
				                   CW_USEDEFAULT,
				                   NULL, 0 ))
		return FALSE;
    }

	CMyClockDlg ClockDlg( &m_wndOwner );
	m_pMainWnd = &ClockDlg;
    
    // Show the clock...
	ClockDlg.DoModal();
    
    m_wndOwner.DestroyWindow();
	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}