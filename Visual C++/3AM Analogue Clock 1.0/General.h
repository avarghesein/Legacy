#if !defined(_AFX_GENERAL_H)
#define _AFX_GENERAL_H

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "ClockStructs.h"

class General : public CPropertyPage
{
	DECLARE_DYNCREATE(General)

public:
	General();
	~General();

	//{{AFX_DATA(General)
	enum { IDD = IDD_GENERAL };
	CSliderCtrl	m_SliderTransparency;
	BOOL	m_bDigitalDateChkd;
	BOOL	m_bDigitalTimeChkd;
	UINT	m_uRadius;
	BOOL	m_bAlwaysOnTop;
	BOOL	m_bAutoStartUp;
	//}}AFX_DATA


	//{{AFX_VIRTUAL(General)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX); 
	//}}AFX_VIRTUAL


protected:

	//{{AFX_MSG(General)
	afx_msg void OnBtnChooseFont();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
    void GetData( void );

public:

    CLOCK_COMMON m_stClockGeneral;
    CLOCK_FONT_REF m_stClockFont;

};

//{{AFX_INSERT_LOCATION}}

#endif
