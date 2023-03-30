// Colour.cpp : implementation file
//

#pragma once

#include "stdafx.h"
#include "MyClock.h"
#include "Colour.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// Colour property page

IMPLEMENT_DYNCREATE(Colour, CPropertyPage)

Colour::Colour() : CPropertyPage(Colour::IDD)
{
	//{{AFX_DATA_INIT(Colour)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

Colour::~Colour()
{
	m_stPaintStruct.ClearAll();
}

void Colour::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(Colour)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(Colour, CPropertyPage)
	//{{AFX_MSG_MAP(Colour)
	ON_BN_CLICKED(IDC_BTN_HR_HND_CLR, OnBtnChangeColor)
    ON_BN_CLICKED(IDC_BTN_MIN_HND_CLR, OnBtnChangeColor)
    ON_BN_CLICKED(IDC_BTN_SEC_HND_CLR, OnBtnChangeColor)
    ON_BN_CLICKED(IDC_BTN_TME_DGTS_CLR, OnBtnChangeColor)
    ON_BN_CLICKED(IDC_BTN_DGTL_DSPLY_CLR, OnBtnChangeColor)
    ON_BN_CLICKED(IDC_BTN_DLG_BKD_CLR, OnBtnChangeColor)
    ON_BN_CLICKED(IDC_BTN_CLK_BKD_CLR, OnBtnChangeColor)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// Colour message handlers

void Colour::OnBtnChangeColor() 
{
    const MSG* pMsg = GetCurrentMessage();
    DWORD dwBtnID = LOWORD( pMsg->wParam );
    
    COLORREF clrSel;
    switch( dwBtnID )
    {
        case IDC_BTN_HR_HND_CLR:
            clrSel = m_stPaintStruct.HourHandColor;
            break;
        case IDC_BTN_MIN_HND_CLR:
            clrSel = m_stPaintStruct.MinHandColor;
            break;
        case IDC_BTN_SEC_HND_CLR:
             clrSel = m_stPaintStruct.SecHandColor;
            break;
        case IDC_BTN_TME_DGTS_CLR:
            clrSel = m_stPaintStruct.TimeDigits;
            break;
        case IDC_BTN_DGTL_DSPLY_CLR:
            clrSel = m_stPaintStruct.DigitalDisplay;
            break;
        case IDC_BTN_DLG_BKD_CLR:
            clrSel = m_stPaintStruct.DialogBackGroundColor;
            break;
        case IDC_BTN_CLK_BKD_CLR:
            clrSel = m_stPaintStruct.ClockBackGroundColor;
            break;
        default:
            break;
     }

    CColorDialog ClrDlg( clrSel, 0, this );

    if( IDOK == ClrDlg.DoModal())
    {
        clrSel = ClrDlg.GetColor();
        switch( dwBtnID )
        {
        case IDC_BTN_HR_HND_CLR:
            m_stPaintStruct.HourHandColor = clrSel;
            break;
        case IDC_BTN_MIN_HND_CLR:
            m_stPaintStruct.MinHandColor = clrSel;
            break;
        case IDC_BTN_SEC_HND_CLR:
            m_stPaintStruct.SecHandColor = clrSel;
            break;
        case IDC_BTN_TME_DGTS_CLR:
            m_stPaintStruct.TimeDigits = clrSel;
            break;
        case IDC_BTN_DGTL_DSPLY_CLR:
            m_stPaintStruct.DigitalDisplay = clrSel;
            break;
        case IDC_BTN_DLG_BKD_CLR:
            m_stPaintStruct.DialogBackGroundColor = clrSel;
            break;
        case IDC_BTN_CLK_BKD_CLR:
            m_stPaintStruct.ClockBackGroundColor = clrSel;
            break;
        default:
            break;
        }
    }
	ClrDlg.DestroyWindow();
}


BOOL Colour::OnInitDialog() 
{
	CPropertyPage::OnInitDialog();
	
	// TODO: Add extra initialization here
	
	return TRUE;
}

