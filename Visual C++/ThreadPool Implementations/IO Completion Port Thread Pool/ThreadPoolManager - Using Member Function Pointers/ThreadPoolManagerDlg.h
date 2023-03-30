// ThreadPoolManagerDlg.h : header file
//

#if !defined(AFX_THREADPOOLMANAGERDLG_H__9381C2C4_8B3B_448D_B7FE_9B8C5315C946__INCLUDED_)
#define AFX_THREADPOOLMANAGERDLG_H__9381C2C4_8B3B_448D_B7FE_9B8C5315C946__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

// Added Thread Pool header file here
#include "ThreadPoolEx.h"

/////////////////////////////////////////////////////////////////////////////
// CThreadPoolManagerDlg dialog

class CThreadPoolManagerDlg : public CDialog
{
// Construction
public:
	CThreadPoolManagerDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CThreadPoolManagerDlg)
	enum { IDD = IDD_THREADPOOLMANAGER_DIALOG };
	int		m_nJobCount;
	int		m_nWorkerThreadCount;
	int		m_nJobsToPush;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CThreadPoolManagerDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CThreadPoolManagerDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonStartPoolMgr();
	afx_msg void OnButtonStartJobs();
	afx_msg void OnButtonStopThreadPoolMgr();
	afx_msg void OnButtonStartJobsNonmember();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

protected:
    CThreadPoolEx m_ThreadPoolManager;

public:
    // The member function to be call backed by the thread pool
    void MemberFunctionWorkerProc( LPVOID pDataIn_i );
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_THREADPOOLMANAGERDLG_H__9381C2C4_8B3B_448D_B7FE_9B8C5315C946__INCLUDED_)
