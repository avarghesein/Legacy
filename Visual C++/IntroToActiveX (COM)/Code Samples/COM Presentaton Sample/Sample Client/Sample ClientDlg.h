// Sample ClientDlg.h : header file
//

#if !defined(AFX_SAMPLECLIENTDLG_H__6AB6FEA9_2D18_408B_8768_16FB5656F433__INCLUDED_)
#define AFX_SAMPLECLIENTDLG_H__6AB6FEA9_2D18_408B_8768_16FB5656F433__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CSampleClientDlg dialog

class CSampleClientDlg : public CDialog
{
// Construction
public:
	CSampleClientDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CSampleClientDlg)
	enum { IDD = IDD_SAMPLECLIENT_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSampleClientDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CSampleClientDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SAMPLECLIENTDLG_H__6AB6FEA9_2D18_408B_8768_16FB5656F433__INCLUDED_)
