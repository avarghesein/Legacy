#ifndef _ABOUTDLG_H_
#define _ABOUTDLG_H_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CAboutDlg : public CDialog
{
    public:

        CAboutDlg(CWnd* pParent = NULL);

		//{{AFX_DATA(CAboutDlg)
		enum { IDD = IDD_ABOUT_DLG };
			// NOTE: the ClassWizard will add data members here
		//}}AFX_DATA


		//{{AFX_VIRTUAL(CAboutDlg)
		public:
		virtual BOOL PreTranslateMessage(MSG* pMsg);
		protected:
		virtual void DoDataExchange(CDataExchange* pDX);
		//}}AFX_VIRTUAL

    protected:

		// Generated message map functions
		//{{AFX_MSG(CAboutDlg)
		virtual BOOL OnInitDialog();
		afx_msg void OnPaint();
		afx_msg void OnDestroy();
		//}}AFX_MSG
		DECLARE_MESSAGE_MAP()

    protected:

        HICON m_hIcon;
		CDC m_MemDC;
		CBitmap m_Bitmap;
		CFont m_Font;
};

//{{AFX_INSERT_LOCATION}}

#endif // _ABOUTDLG_H_
