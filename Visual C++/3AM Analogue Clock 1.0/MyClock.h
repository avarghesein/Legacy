
#if !defined(_AFX_MYCLOCK_H)
#define _AFX_MYCLOCK_H

#if _MSC_VER > 1000
#pragma once
#endif 

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"


class CMyClockApp : public CWinApp
{
public:
	CMyClockApp();

	//{{AFX_VIRTUAL(CMyClockApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

	//{{AFX_MSG(CMyClockApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

    private:

        CWnd m_wndOwner;
};

//{{AFX_INSERT_LOCATION}}

#endif 
