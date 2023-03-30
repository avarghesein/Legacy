// General.cpp : implementation file
//

#pragma once

#include "stdafx.h"
#include "MyClock.h"
#include "General.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// General property page

IMPLEMENT_DYNCREATE(General, CPropertyPage)

General::General() : CPropertyPage(General::IDD)
{
	//{{AFX_DATA_INIT(General)
	m_bDigitalDateChkd = FALSE;
	m_bDigitalTimeChkd = FALSE;
	m_uRadius = 0;
	m_bAlwaysOnTop = FALSE;
	m_bAutoStartUp = FALSE;
	//}}AFX_DATA_INIT
}

General::~General()
{
    m_stClockFont.ClearAll();
}

void General::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(General)
	DDX_Control(pDX, IDC_SLIDER_TRANS, m_SliderTransparency);
	DDX_Check(pDX, IDC_CHK_SHW_DATE, m_bDigitalDateChkd);
	DDX_Check(pDX, IDC_CHK_SHW_TIME, m_bDigitalTimeChkd);
	DDX_Text(pDX, IDC_EDT_CLK_RAD, m_uRadius);
	DDX_Check(pDX, IDC_CHK_ON_TOP, m_bAlwaysOnTop);
	DDX_Check(pDX, IDC_CHK_AUTO_STRT, m_bAutoStartUp);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(General, CPropertyPage)
	//{{AFX_MSG_MAP(General)
	ON_BN_CLICKED(IDC_BTN_CHOOSE_FONT, OnBtnChooseFont)
	ON_WM_HSCROLL()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


#include "PropertiesDlg.h"

void General::OnBtnChooseFont() 
{	
    LOGFONT tmpFont;
	memcpy( &tmpFont, &m_stClockFont.LogFont, sizeof( LOGFONT ));	
    tmpFont.lfHeight /= 10;
	CFontDialog FontDlg( &tmpFont, CF_EFFECTS | CF_SCREENFONTS, 0, this );
    if( IDOK == FontDlg.DoModal())
    {
        _tcscpy( m_stClockFont.LogFont.lfFaceName, FontDlg.GetFaceName());
        m_stClockFont.LogFont.lfHeight = FontDlg.GetSize();
        m_stClockFont.LogFont.lfWeight = FontDlg.IsBold() ?  FW_BOLD : FW_NORMAL;
    }
	FontDlg.DestroyWindow();
}



void General::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	if( IDC_SLIDER_TRANS == pScrollBar->GetDlgCtrlID())
    {
        //m_stClockGeneral.CurrentTransparency = m_SliderTransparency.GetPos();
    }	
	CPropertyPage::OnHScroll(nSBCode, nPos, pScrollBar);
}

void General::GetData( void )
{
    UpdateData();
    m_stClockGeneral.ShowDigitalDate = m_bDigitalDateChkd;
    m_stClockGeneral.ShowDigitalTime = m_bDigitalTimeChkd;
    m_stClockGeneral.ClockRadius = m_uRadius;
    m_stClockGeneral.AlwaysOnTop = m_bAlwaysOnTop;
	m_stClockGeneral.AutoStartUp = m_bAutoStartUp;
    m_stClockGeneral.CurrentTransparency =  255 - m_SliderTransparency.GetPos(); 
}


BOOL General::OnInitDialog() 
{
	CPropertyPage::OnInitDialog();
	
    m_bDigitalDateChkd = m_stClockGeneral.ShowDigitalDate;
    m_bDigitalTimeChkd = m_stClockGeneral.ShowDigitalTime;
    m_uRadius = m_stClockGeneral.ClockRadius;
    m_bAlwaysOnTop = m_stClockGeneral.AlwaysOnTop;
	m_bAutoStartUp = m_stClockGeneral.AutoStartUp;
    UpdateData( FALSE );
    m_SliderTransparency.SetRange( 0, 255 );
    m_SliderTransparency.SetPos( 255 - m_stClockGeneral.CurrentTransparency );	
	return TRUE;  
}
