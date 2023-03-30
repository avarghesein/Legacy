#if !defined(_AFX_PROPERTIESDLG_H)
#define _AFX_PROPERTIESDLG_H

#if _MSC_VER > 1000
#pragma once
#endif
//
#include "General.h"
#include "Colour.h"

class PropertiesDlg : public CDialog
{
public:
	PropertiesDlg(CWnd* pParent = NULL);  
	~PropertiesDlg();

	//{{AFX_DATA(PropertiesDlg)
	enum { IDD = IDD_DIALOG_CONFIG };
	//}}AFX_DATA


	//{{AFX_VIRTUAL(PropertiesDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);
	//}}AFX_VIRTUAL

protected:

	//{{AFX_MSG(PropertiesDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnApply();
	afx_msg void OnCancel();
	afx_msg void OnOk();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

    CPropertySheet m_Properties;

public:
    General m_General;
    Colour m_ColourPage;
};

//{{AFX_INSERT_LOCATION}}

#endif
