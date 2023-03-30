
#pragma once

#include "stdafx.h"
#include "myclock.h"
#include "AboutDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif




CAboutDlg::CAboutDlg(CWnd* pParent /*=NULL*/)
    : CDialog(CAboutDlg::IDD, pParent)
{
    //{{AFX_DATA_INIT(CAboutDlg)
        // NOTE: the ClassWizard will add member initialization here
    //}}AFX_DATA_INIT

    m_hIcon = AfxGetApp()->LoadIcon( IDR_MAINFRAME );

}


void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
    CDialog::DoDataExchange(pDX);
    //{{AFX_DATA_MAP(CAboutDlg)
        // NOTE: the ClassWizard will add DDX and DDV calls here
    //}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
    //{{AFX_MSG_MAP(CAboutDlg)
    ON_WM_PAINT()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

BOOL CAboutDlg::OnInitDialog()
{
    CWnd* wndDeskTop;
    wndDeskTop = GetDesktopWindow();
    CDC* pScrDc = wndDeskTop->GetWindowDC();

    int nScreenW = GetSystemMetrics( SM_CXSCREEN );
    int nScreenH = GetSystemMetrics( SM_CYSCREEN );

    m_Bitmap.CreateCompatibleBitmap( pScrDc, nScreenW, nScreenH );
    m_MemDC.CreateCompatibleDC( pScrDc);
    m_MemDC.SelectObject( &m_Bitmap );
    m_MemDC.BitBlt( 0, 0, nScreenW,nScreenH, pScrDc, 0, 0, SRCCOPY );

	LOGFONT LogFont = { 0 };
	LogFont.lfHeight = 20;
	_tcscpy( LogFont.lfFaceName, "Times New Roman" );
	LogFont.lfWeight = FW_BOLD;
    m_Font.CreateFontIndirect( &LogFont );

    CDialog::OnInitDialog();


    ::SetWindowPos( m_hWnd, HWND_TOPMOST, 0, 0, nScreenW, nScreenH, SWP_SHOWWINDOW );

    return TRUE;  // return TRUE unless you set the focus to a control
                  // EXCEPTION: OCX Property Pages should return FALSE
}

void CAboutDlg::OnPaint()
{
    CDC* dc = GetDC(); // device context for painting

    CSize size;
    size.cx = GetSystemMetrics( SM_CXSCREEN );
    size.cy = GetSystemMetrics( SM_CYSCREEN );

    if(dc)
    {
       m_MemDC.SetTextColor( RGB( 0, 50, 250 ));
       m_MemDC.SetBkMode( TRANSPARENT );
       CFont* pOldFont = m_MemDC.SelectObject( &m_Font );
	   TCHAR *pzToDraw[] = { "3AM Analogue Clock 1.0", "**********************" , "\n" ,
							 "Credits:" , "\n" , "Maya Devi...", "Afsal M...", "Abraham Varghese...","\n",
							 "Special Thanks To","*****************", 
							 "Arun Kumar G, For innovative ideas..." };

	   float fYval = float( size.cy ) / 2;
	   CSize TextSize;
	   CString csToDraw;
	   CRect DrawRect;
	   for( int i = 7; i >= 0; --i )
	   {
		   csToDraw = pzToDraw[ i ];
		   TextSize = m_MemDC.GetTextExtent( csToDraw );
		   DrawRect.left = float( size.cx ) / 2 - 180;
		   DrawRect.top = fYval - TextSize.cy;
		   DrawRect.right = float( size.cx ) / 2 - 180 + float( TextSize.cx );
		   DrawRect.bottom = fYval;
		   m_MemDC.DrawText( csToDraw,  &DrawRect, DT_LEFT );
		   fYval -=  TextSize.cy;

	   }
	   fYval = float( size.cy ) / 2;
	   for( i = 8; i <= 11; ++i )
	   {
		   csToDraw = pzToDraw[ i ];
		   TextSize = m_MemDC.GetTextExtent( csToDraw );
		   DrawRect.left = float( size.cx ) / 2 - 180;
		   DrawRect.top = fYval;
		   DrawRect.right = float( size.cx ) / 2 - 180 + float( TextSize.cx );
		   DrawRect.bottom = fYval + TextSize.cy;
		   m_MemDC.DrawText( csToDraw,  &DrawRect, DT_LEFT );
		   fYval +=  TextSize.cy;

	   }
       dc->BitBlt( 0, 0, size.cx, size.cy, &m_MemDC, 0, 0, SRCCOPY );
       m_MemDC.SelectObject( pOldFont );
    }

}

void CAboutDlg::OnDestroy() 
{
	CDialog::OnDestroy();

	m_Bitmap.DeleteObject();
    m_Font.DeleteObject();
    m_MemDC.DeleteDC();
	
}

BOOL CAboutDlg::PreTranslateMessage(MSG* pMsg) 
{
	switch( pMsg->message )
     {
		case WM_LBUTTONDOWN:
		case WM_RBUTTONDOWN:
        case WM_KEYDOWN:
			CDialog::OnOK();
			break;
    }	
	return CDialog::PreTranslateMessage(pMsg);
}
