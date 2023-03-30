// PropertiesDlg.cpp : implementation file
//

#pragma once

#include "stdafx.h"
#include "MyClock.h"
#include "PropertiesDlg.h"
#include "MyClockDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// PropertiesDlg dialog


PropertiesDlg::PropertiesDlg(CWnd* pParent /*=NULL*/)
	: CDialog(PropertiesDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(PropertiesDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

PropertiesDlg::~PropertiesDlg()
{
	m_ColourPage.DestroyWindow();
	m_General.DestroyWindow();
	m_Properties.DestroyWindow();
}

void PropertiesDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(PropertiesDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(PropertiesDlg, CDialog)
	//{{AFX_MSG_MAP(PropertiesDlg)
	ON_BN_CLICKED(IDC_CONFG_APPLY, OnApply)
	ON_BN_CLICKED(IDC_CONFG_CANCEL, OnCancel)
	ON_BN_CLICKED(IDC_CONFG_OK, OnOk)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()



BOOL PropertiesDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE

	// Add the general and color tab pages to the property sheet or tab control
    m_Properties.AddPage( &m_General );
    m_Properties.AddPage( &m_ColourPage ); 
    
	// Create the Tab Control
	// NOTE: Extended style 'WS_EX_CONTROLPARENT' is a must here, to show a modal dialog
	// From a Tab Control / Tab Page. Otherwise it will hang if we call any DoModal.
	// Ex: suppose if we are showing a ColorSelection dialog.
	m_Properties.Create( this, WS_CHILD | WS_VISIBLE, WS_EX_CONTROLPARENT );

    CRect rcClient;
    GetClientRect( &rcClient );

    const int SIZE_ADJUST_WIDTH = 25;
    const int SIZE_ADJUST_HEIGHT = 35;
	// Properly align the tab control with in the form
    m_Properties.MoveWindow( 0, 0 , rcClient.Width() - SIZE_ADJUST_WIDTH, rcClient.Height() - SIZE_ADJUST_HEIGHT );
    CTabCtrl* pCtrl = m_Properties.GetTabControl();
    pCtrl->MoveWindow( 0, 0, rcClient.Width() - SIZE_ADJUST_WIDTH, rcClient.Height() - SIZE_ADJUST_HEIGHT );
	// Set the general settings tab page as default
    m_Properties.SetActivePage( &m_General );


    CRect rcWindow;
    GetWindowRect( &rcWindow );

    int nScreenWidth = ::GetSystemMetrics( SM_CXSCREEN );
    int nScreenHeight = ::GetSystemMetrics( SM_CYSCREEN );

    int nDX = ( nScreenWidth / 2 )- ( rcWindow.Width() / 2 );
    int nDY = ( nScreenHeight / 2 ) - ( rcWindow.Height() / 2 );
	// Show our window in the centre of the screen
    MoveWindow( nDX, nDY, rcWindow.Width() - 25, rcWindow.Height());
	SetIcon( AfxGetApp()->LoadIcon( IDR_MAINFRAME ), TRUE );	
	return TRUE;      
}

void PropertiesDlg::OnApply() 
{
    // Get the user options from the UI into the structure variables...
    m_General.GetData();
	// Specify the clock dialog that to change according to the current user selected
	// preferences and save them to the archive file
    ((CMyClockDlg*)GetParent())->ChangeClockAppearence( m_General.m_stClockGeneral, m_General.m_stClockFont,
                                                        m_ColourPage.m_stPaintStruct );
}


void PropertiesDlg::OnCancel() 
{
    CDialog::OnCancel();	
}

void PropertiesDlg::OnOk() 
{
	// Apply the changes first, then close the form
	OnApply();
    CDialog::OnOK();
}
