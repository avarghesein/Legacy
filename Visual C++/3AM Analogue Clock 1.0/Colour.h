#if !defined(_AFX_COLOUR_H)
#define _AFX_COLOUR_H

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "ClockStructs.h"

class Colour : public CPropertyPage
{
	DECLARE_DYNCREATE(Colour)

public:
	Colour();
	~Colour();

	//{{AFX_DATA(Colour)
	enum { IDD = IDD_DIALOG_COLOUR };
		// NOTE - ClassWizard will add data members here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_DATA


	//{{AFX_VIRTUAL(Colour)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL


protected:

	// Generated message map functions
	//{{AFX_MSG(Colour)
	afx_msg void OnBtnChangeColor();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:

    CLOCK_PAINT_STRUCT_REF m_stPaintStruct;

};

//{{AFX_INSERT_LOCATION}}

#endif
