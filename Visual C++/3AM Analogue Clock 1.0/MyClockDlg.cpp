// MyClockDlg.cpp : implementation file
//

#pragma once

#include "stdafx.h"
#include "MyClock.h"
#include "MyClockDlg.h"
#include "PropertiesDlg.h"
#include "AboutDlg.h"
#include <math.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#ifndef IDC_HAND
    #define IDC_HAND MAKEINTRESOURCE(32649)
#endif

#define WM_TRAYMENU WM_USER + 201

CMyClockDlg::CMyClockDlg(CWnd* pParent /*=NULL*/) : CDialog(CMyClockDlg::IDD, pParent)
{
    //{{AFX_DATA_INIT(CMyClockDlg)
        // NOTE: the ClassWizard will add member initialization here
    //}}AFX_DATA_INIT
    // Note that LoadIcon does not require a subsequent DestroyIcon in Win32
    m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
    m_bIsTray = false;
}

CMyClockDlg::~CMyClockDlg()
{
	if( m_MemoryDC.m_hAttribDC ) m_MemoryDC.GetCurrentBitmap()->DeleteObject();
	m_MemoryDC.DeleteDC();
	m_EraseHandsBrush.DeleteObject();
	m_EraseHandsPen.DeleteObject();
	m_ClockPaintStruct.ClearAll();
	m_ClockFonts.ClearAll();
}

void CMyClockDlg::DoDataExchange(CDataExchange* pDX)
{
    CDialog::DoDataExchange(pDX);
    //{{AFX_DATA_MAP(CMyClockDlg)
        // NOTE: the ClassWizard will add DDX and DDV calls here
    //}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CMyClockDlg, CDialog)
    //{{AFX_MSG_MAP(CMyClockDlg)
    ON_WM_SYSCOMMAND()
    ON_WM_PAINT()
    ON_WM_QUERYDRAGICON()
    ON_WM_TIMER()
    ON_COMMAND(ID_MAIN_EXIT, OnMainExit)
    ON_WM_CONTEXTMENU()
    ON_WM_CTLCOLOR()
    ON_COMMAND(ID_MAIN_OPTIONS, OnMainOptions)
    ON_MESSAGE( WM_TRAYMENU, OnSysTrayMsg )
    ON_WM_DESTROY()
    ON_COMMAND(ID_MAIN_ABOUT, OnAbout)
	ON_WM_ENDSESSION()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMyClockDlg message handlers

BOOL CMyClockDlg::OnInitDialog()
{
    CDialog::OnInitDialog();

    // Set the icon for this dialog.  The framework does this automatically
    //  when the application's main window is not a dialog
    SetIcon(m_hIcon, TRUE);         // Set big icon
    SetIcon(m_hIcon, FALSE);        // Set small icon


    //START: Create the Clock drawing are and structures
    ModifyStyleEx( WS_EX_APPWINDOW, 0 );
    // Load user prefernces saved previously from the archive
    LoadSettings();
    memset( &m_stNotifyData, 0, sizeof( m_stNotifyData ));
    m_stNotifyData.cbSize = sizeof( m_stNotifyData );
    m_stNotifyData.uID = 101;
    m_stNotifyData.uFlags = NIF_ICON | NIF_MESSAGE | NIF_TIP;
    m_stNotifyData.hIcon = ::LoadIcon( AfxGetInstanceHandle(), MAKEINTRESOURCE( IDR_MAINFRAME ));
    m_stNotifyData.hWnd = m_hWnd;
	AfxLoadString( IDS_APP_NAME ,m_stNotifyData.szTip, 64 );
    m_stNotifyData.uCallbackMessage = WM_TRAYMENU;

    CreateClockRegionAndStyle( false );
    CreateClockStructures();
    // Generate an Initial Snap shot of Clock for the current time
    DrawClockForTimeInstance( CTime::GetCurrentTime(), true );
    SetTimer( 1, 1000, 0 );
    //END: Create the Clock drawing are and structures
    ::Shell_NotifyIcon( NIM_ADD, &m_stNotifyData );

    return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMyClockDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
    CDialog::OnSysCommand(nID, lParam);
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CMyClockDlg::OnPaint()
{
    if (IsIconic())
    {
        CPaintDC dc(this); // device context for painting
        SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);
        // Center icon in client rectangle
        int cxIcon = GetSystemMetrics(SM_CXICON);
        int cyIcon = GetSystemMetrics(SM_CYICON);
        CRect rect;
        GetClientRect(&rect);
        int x = (rect.Width() - cxIcon + 1) / 2;
        int y = (rect.Height() - cyIcon + 1) / 2;
        // Draw the icon
        dc.DrawIcon(x, y, m_hIcon);
    }
    else
    {
        // START: From the Memory DC, Bit Block Transfer the current graphical clock representation to the Screen [Paint DC]
        CPaintDC PaintDC(this);
        CRect ClientRect;
        GetClientRect( &ClientRect );
        PaintDC.BitBlt( 0, 0, ClientRect.Width(), ClientRect.Height(), &m_MemoryDC, 0, 0,  SRCCOPY );
        // END: From the Memory DC, Bit Block Transfer the current graphical clock representation to the Screen [Paint DC]
    }
	CDialog::OnPaint();
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CMyClockDlg::OnQueryDragIcon()
{
    return (HCURSOR) m_hIcon;
}


void CMyClockDlg::DrawClockForTimeInstance( const CTime& Time_i, bool IsInitialCall_i )
{
    if( IsInitialCall_i )
    {
        // PERFORMANCE_BLOCK:
        // Drawing the clock boarder and background only need at initial time
        // This area will be reused during successive calls to this function
        // And no drawing of this area will be done on those calls
        CRect ClientRect;
        GetClientRect( &ClientRect );

        m_CentrePoint = ClientRect.CenterPoint();
        m_fRadius = float(( double(ClientRect.Width() > ClientRect.Height() ?
                          ClientRect.Height() :
                          ClientRect.Width()) / 2.0 ) - 14.0 );

        CRect ClockRectangle( m_CentrePoint.x - m_fRadius, m_CentrePoint.y - m_fRadius,
                              m_CentrePoint.x + m_fRadius, m_CentrePoint.y + m_fRadius );

        CPen BoarderlessPen( PS_NULL, 0, RGB( 0, 0, 0 ));
        m_MemoryDC.SelectObject ( &BoarderlessPen );

        CBrush* pOldBr = m_MemoryDC.SelectObject ( &m_ClockPaintStruct.DialogBackGround );
        m_MemoryDC.Ellipse( &ClientRect );
		m_SmoothingGrpahics.DrawEllipse( m_MemoryDC, ClientRect, m_ClockPaintStruct.DialogBackGroundColor );
        pOldBr = m_MemoryDC.SelectObject ( &m_ClockPaintStruct.ClockBackGround );
        m_MemoryDC.Ellipse( &ClockRectangle );
		m_SmoothingGrpahics.DrawEllipse( m_MemoryDC, ClockRectangle, m_ClockPaintStruct.DialogBackGroundColor);
        m_MemoryDC.SelectObject( pOldBr );
		BoarderlessPen.DeleteObject();
    }
    else
    {
        // PERFORMANCE_BLOCK:
        // If this is not the initial drawing of the clock we need to delete the previous
        // Hand positions, for Hour, Minitue and Second and also the date and time digital displays
        m_MemoryDC.SelectObject( &m_EraseHandsBrush );
        m_MemoryDC.SelectObject( &m_EraseHandsPen );
        float fRadius = m_fRadius / SEC_HAND_RADIUS_PROPOTION;
        CRect EraseRectangle( m_CentrePoint.x - fRadius, m_CentrePoint.y - fRadius,
                              m_CentrePoint.x + fRadius, m_CentrePoint.y + fRadius );
        m_MemoryDC.Ellipse( &EraseRectangle );
    }

    // Display Date and Time digitally
    DigitalDisplay( &m_MemoryDC, m_fRadius, m_CentrePoint, Time_i, IsInitialCall_i );
    // Extract the real Second, Minitue, Hour Parts from the time instance
    // Get the second
    m_fSec = Time_i.GetSecond();
    // Get the minute, also add the minitue part of the second..so that we get the exact loaction
    m_fMin = Time_i.GetMinute() + m_fSec / 60.0;
    // Get the Hr, also add the hour part of the minitue..so that we get the exact loaction
    m_fHr = Time_i.GetHour() + m_fMin / 60.0;
    
    // Display the Hour Hand of the clock
    CreateClockHand( m_fHr, 12.0, m_fRadius, m_CentrePoint, HOUR_HAND_RADIUS_PROPOTION,
                     HOUR_HAND_RADIUS_BENDING_PROPOTION, HOUR_HAND_TIME_GAP, m_ClockPaintStruct.HourHandBrush,
                     m_ClockPaintStruct.HourHandPen, m_ClockPaintStruct.HourHandColor );
    // Display the Minitue Hand of the clock
    CreateClockHand( m_fMin, 60.0, m_fRadius, m_CentrePoint, MIN_HAND_RADIUS_PROPOTION,
                     MIN_HAND_RADIUS_BENDING_PROPOTION, MIN_HAND_TIME_GAP, m_ClockPaintStruct.MinHandBrush,
                     m_ClockPaintStruct.MinHandPen, m_ClockPaintStruct.MinHandColor );    
    // Display the Second Hand of the clock
    CreateClockHand( m_fSec, 60.0, m_fRadius, m_CentrePoint, SEC_HAND_RADIUS_PROPOTION,
                     SEC_HAND_RADIUS_BENDING_PROPOTION, SEC_HAND_TIME_GAP, m_ClockPaintStruct.SecHandBrush,
                     m_ClockPaintStruct.SecHandPen, m_ClockPaintStruct.SecHandColor );
    return;
}


void CMyClockDlg::CreateClockHand(
                      float fCurrentTimeSegment_i, float fTimeUnits_i, float fClockRadius_i,
                      const CPoint& CentreOfClock_i, float fRadiusPropotionForTimeSegment_i,
                      float fHandRadiusBendingPropotion_i, float fTimeGap_i, const CBrush& HandColorBrush_i,
                      const CPen& HandColorPen_i , COLORREF HandColor_i )
{
    // Find the length/radius for the given Clock hand
    fClockRadius_i /= fRadiusPropotionForTimeSegment_i;
    // Find the coordinates of the clock hand given for, the current time
    CPoint TimePoint( GetCordinatesOfClockHand(
                                    fCurrentTimeSegment_i , fTimeUnits_i, fClockRadius_i, CentreOfClock_i ));
    // Find the coordinate of the clock handle given, for the current time - delta and radius adjusted
    CPoint LeftTimePoint( GetCordinatesOfClockHand(
                                    fCurrentTimeSegment_i - fTimeGap_i, fTimeUnits_i,
                                    fClockRadius_i / fHandRadiusBendingPropotion_i,
                                    CentreOfClock_i ));
    // Find the coordinate of the clock handle given, for the current time + delta and radius adjusted
    CPoint RightTimePoint( GetCordinatesOfClockHand(
                                fCurrentTimeSegment_i + fTimeGap_i, fTimeUnits_i,
                                fClockRadius_i / fHandRadiusBendingPropotion_i,
                                CentreOfClock_i ));
    // Create the handle of the clock by joining the four points we found above,
    // So that the handle of the clock looks like a polygon
    m_MemoryDC.AbortPath();
    m_MemoryDC.BeginPath();
    m_MemoryDC.MoveTo( CentreOfClock_i );
    m_MemoryDC.LineTo( LeftTimePoint );
    m_MemoryDC.LineTo( TimePoint );
    m_MemoryDC.LineTo( RightTimePoint );
    m_MemoryDC.LineTo( CentreOfClock_i );
    m_MemoryDC.EndPath();
    m_MemoryDC.SelectObject( HandColorBrush_i );
    m_MemoryDC.SetPolyFillMode( WINDING );
    m_MemoryDC.SelectObject( HandColorPen_i );
    m_MemoryDC.FillPath();
    // Smoothen the irregular line, with anti aliasing technique...
    // Draw the boarder lines only, since smoothness needs at the edge of the hand..
	m_SmoothingGrpahics.DrawLine( m_MemoryDC, CentreOfClock_i, LeftTimePoint, HandColor_i );
	m_SmoothingGrpahics.DrawLine( m_MemoryDC, LeftTimePoint, TimePoint, HandColor_i );
	m_SmoothingGrpahics.DrawLine( m_MemoryDC, TimePoint, RightTimePoint, HandColor_i );
	m_SmoothingGrpahics.DrawLine( m_MemoryDC, RightTimePoint, CentreOfClock_i, HandColor_i );
}

/*
 * This function will return the carteesion point related to a time segment, translated to an origin.
 *
 * Consider the time 3:30:50 on a 12 hr clock
 *
 * fCurrentTimeSegment_i: Its the time segment , for the above example it will be 3 or 30 or 50 for the diff hands
 *
 * fTimeUnits_i: Its the total time units for the current time segment, for above example it will be 12 or 60 or 60
 *
 * fRadiusForTimeSegment_i: Its the length of the hand
 *
 * CentreOfClock_i: This is the centre of the clock, Origin.
*/
CPoint CMyClockDlg::GetCordinatesOfClockHand( float fCurrentTimeSegment_i, float fTimeUnits_i, float fRadiusForTimeSegment_i,
                                              const CPoint& CentreOfClock_i )
{
    const double RAD = (3.141519/180.0);
    // Calculate the angle for the current time segment: THETA = TimeSeg * 360 / TimeUnits
    // Here 360 is the total angle of a circle
    double dAngle = double( fCurrentTimeSegment_i ) * double( 360 ) / double( fTimeUnits_i );
    // Get the X coordinate, using x = r sin ( Theta )
    double dX = fRadiusForTimeSegment_i * sinf( dAngle * RAD );
    // Get the Y coordinate, using y = r cos ( Theta )
    double dY = fRadiusForTimeSegment_i * cosf( dAngle * RAD );
    // Since in the monitor/screen the Y axis is reverted from the normal XY plane. Revert the Y coordinate
    dY *= double( -1 );
    // Translate X,Y values to centre of the clock circle
    dX += CentreOfClock_i.x;
    dY += CentreOfClock_i.y;
    // Return the the resultant point for the time segment
    return CPoint( int( dX ), int( dY ));
}

typedef BOOL ( *UpdateLayeredWindow )( HWND hwnd, HDC hdcDst, POINT *pptDst, SIZE *psize, HDC hdcSrc, POINT *pptSrc,
                                       COLORREF crKey, BLENDFUNCTION *pblend, DWORD dwFlags );


void CMyClockDlg::CreateClockRegionAndStyle( bool bUpdate_i  )
{
    const CWnd* pWndToRefer = m_ClockCommon.AlwaysOnTop ? &CWnd::wndTopMost : &CWnd::wndNoTopMost;
    SetWindowPos( pWndToRefer, m_ClockCommon.CurrentPosition.x, m_ClockCommon.CurrentPosition.y,
                  m_ClockCommon.ClockRadius, m_ClockCommon.ClockRadius, SWP_SHOWWINDOW );
    // START: Creation Of the Round Region/Area for the Clock
    CClientDC ClientDC( this );
    CRect RectClient;
    // Get the window rect
    GetWindowRect( &RectClient );	
    m_CentrePoint = RectClient.CenterPoint();
    // Find the minimal radius to draw the clock [ Select Height/Width, which ever is lesser so that we have an
    // exact round, not an elipse ]
    m_fRadius = float(( double( RectClient.Width() > RectClient.Height() ?
                        RectClient.Height() :
                        RectClient.Width()) / 2.0 ));

    RectClient = CRect( m_CentrePoint.x - m_fRadius, m_CentrePoint.y - m_fRadius,
                        m_CentrePoint.x + m_fRadius, m_CentrePoint.y + m_fRadius );
    // Adjust the boarder
    RectClient.left += 7, RectClient.top += 7;
	//RectClient.top += 6, RectClient.bottom +=6;
    ScreenToClient( &RectClient );
    ClientDC.BeginPath();
    ClientDC.Ellipse( &RectClient );
    ClientDC.EndPath();
    CRgn RoundRegion;
    RoundRegion.CreateFromPath( &ClientDC );
    SetWindowRgn((HRGN)RoundRegion, TRUE );
    RoundRegion.DeleteObject();
    // END: Creation Of the Round Region/Area for the Clock


    // START: Creation Of Transparency Style for the clock
    const DWORD WS_EX_LAYERED = 0x00080000;
    const DWORD LWA_COLORKEY = 0x00000001;
    const DWORD LWA_ALPHA = 0x00000002;
    const DWORD  ULW_COLORKEY = 0x00000001;
    const DWORD  ULW_ALPHA = 0x00000002;
    const DWORD  ULW_OPAQUE = 0x00000004;

    HINSTANCE hDll = ::LoadLibrary( "User32.dll" );
    BOOL ( CALLBACK* SetLayeredWindowAttributesAPI )( HWND, COLORREF, BYTE, DWORD ) =
    ( BOOL ( CALLBACK* )( HWND, COLORREF, BYTE, DWORD )) GetProcAddress( hDll, "SetLayeredWindowAttributes" );

    if( !bUpdate_i )
    {
        SetWindowLong( m_hWnd, GWL_EXSTYLE, GetWindowLong( m_hWnd, GWL_EXSTYLE ) | WS_EX_LAYERED );
    }
    SetLayeredWindowAttributesAPI((HWND)m_hWnd, 0, (BYTE) m_ClockCommon.CurrentTransparency, (DWORD)( LWA_COLORKEY| LWA_ALPHA ));
    ::FreeLibrary( hDll );
    // END: Creation Of Transparency Style for the clock
    return;
}

void  CMyClockDlg::CreateClockStructures( void )
{
	if( m_MemoryDC.m_hAttribDC ) m_MemoryDC.GetCurrentBitmap()->DeleteObject();
	m_MemoryDC.DeleteDC();

    // START: Creation Of the Memory DC for the Clock Client Area [For avoiding flickering]
    CClientDC ClockAreaDC(this);
    CRect ClientRect;
    GetClientRect( &ClientRect );
    CBitmap BitMap;
    BitMap.CreateCompatibleBitmap( &ClockAreaDC, ClientRect.Width(), ClientRect.Height());    
    m_MemoryDC.CreateCompatibleDC( &ClockAreaDC );
    m_MemoryDC.SelectObject( BitMap );
    // END: Creation Of the Memory DC for the Clock Client Area

    // START: Creation Of Font Data for various elements in the clock
    m_ClockFonts.CreateFonts( &m_MemoryDC );
    // END: Creation Of Font Data for various elements in the clock

    // START: Creation Of Paint Data for various elements in the clock
    m_ClockPaintStruct.CreateBrushesAndPensFromColors();
    // END: Creation Of Paint Data for various elements in the clock

    m_EraseHandsPen.DeleteObject();
    m_EraseHandsPen.CreatePen( PS_SOLID, 7, m_ClockPaintStruct.ClockBackGroundColor );
    m_EraseHandsBrush.DeleteObject();
    m_EraseHandsBrush.CreateSolidBrush( m_ClockPaintStruct.ClockBackGroundColor );
    return;
}

void CMyClockDlg::OnTimer( UINT nIDEvent )
{
    // Generate a Clock Snap shot for the current time
    DrawClockForTimeInstance( CTime::GetCurrentTime(), false );
    // Force the drawing of clock
    Invalidate( FALSE );

    CDialog::OnTimer(nIDEvent);
}

void CMyClockDlg::DigitalDisplay( CDC *pDc_i, float fRad_i, const CPoint& CentrePoint_i , const CTime& CurrentTime_i,
                                  bool IsInitialCall_i )
{
    pDc_i->SetBkMode( TRANSPARENT );

    CFont* OldFont = pDc_i->SelectObject( &m_ClockFonts.TimeDigits );
    pDc_i->SetTextColor( m_ClockPaintStruct.DigitalDisplay );
    // START: Creating Digital Date and Time Display
    CPoint Point;
    CSize Size;
    if( m_ClockCommon.ShowDigitalTime )
    {
        CString csTime( CurrentTime_i.Format( "%#I:%#M:%S %p"));
        Point = CentrePoint_i;
        // Drawing current Time String
        Point.y += int( double( fRad_i ) / 2 );
        CSize Size = pDc_i->GetTextExtent( csTime );
        Size.cx /= 2, Size.cy /= 2;
        m_DigitalTimeRect = CRect(  Point.x - Size.cx , Point.y - Size.cy ,Point.x + Size.cx , Point.y + Size.cy );
        pDc_i->DrawText( csTime, &m_DigitalTimeRect,DT_CENTER);
    }
    if( m_ClockCommon.ShowDigitalDate )
    {
        // Drawing current Date String
        CString csDate( CurrentTime_i.Format( "%#d %B %Y" ));
        Point = CentrePoint_i;
        Point.y -= int( double( fRad_i ) / 2 );
        Size = pDc_i->GetTextExtent( csDate );
        Size.cx /= 2, Size.cy /= 2;
        m_DigitalDateRect = CRect(  Point.x - Size.cx , Point.y - Size.cy ,Point.x + Size.cx , Point.y + Size.cy );
        pDc_i->DrawText( csDate, &m_DigitalDateRect,DT_CENTER);
    }
    // END: Creating Digital Date and Time Display

    // PERFORMANCE_BLOCK:
    // The Time numbers and the dots between them need to be only drawn at initial drawing of the clock.
    // Successive calls to this function will reuse that area and will not do any redrawing of time numbers
    // and the dots between them. So here we are returning from this function,
    // if this area is already drawn in the initial call
    if( !IsInitialCall_i ) return;

    CPen Pen;
    Pen.CreatePen( PS_SOLID, 2, m_ClockPaintStruct.TimeDigits );
    pDc_i->SelectObject( &Pen );
    pDc_i->SetTextColor( m_ClockPaintStruct.TimeDigits );

    CString csVal;
    CPoint TimePoint, TimePointRef;
    CSize TimeSize;
    CRect TimeRect;
    // Create times display valures from 1 to 12
    for( int iTime = 1; iTime <= 60; ++iTime )
    {
        // Get the coordinate position, which is the centere point to display the string
        TimePoint = GetCordinatesOfClockHand( iTime ,60, fRad_i , CentrePoint_i );
        if( !( iTime % 5 ))
        {
            // Get the string for the current time ie. 1-12
            csVal.Format( _T( "%d" ), iTime / 5 );
            // Get the width and height of the string value to display
            TimeSize = pDc_i->GetTextExtent( csVal );
            // Calculate the rectangle to display the string. Logic is find a rectangle of width, height
            // of the text length and the centre point as coordinate position
            TimeRect.left = long( TimePoint.x - double( TimeSize.cx ) / 2);
            TimeRect.top = long( TimePoint.y - double( TimeSize.cy ) / 2);
            TimeRect.right = long( TimePoint.x + double( TimeSize.cx ) / 2);
            TimeRect.bottom = long( TimePoint.y + double( TimeSize.cy ) / 2);
            // Draw the Time Digit to the screen
            pDc_i->DrawText( csVal, TimeRect,DT_CENTER );
        }
        else
        {
            TimePointRef = GetCordinatesOfClockHand( iTime ,60, fRad_i - 1, CentrePoint_i );
            pDc_i->MoveTo( TimePointRef );
            // Drawing dots in place of minitues in the clock
            pDc_i->LineTo( TimePoint );
        }
    }
    Pen.DeleteObject();
 }

HBRUSH CMyClockDlg::OnCtlColor( CDC* pDC, CWnd* pWnd, UINT nCtlColor )
{
    if( CTLCOLOR_DLG == nCtlColor )
    {
        return m_ClockPaintStruct.DialogBackGround;
    }
    return CDialog::OnCtlColor(pDC, pWnd, nCtlColor);
}

BOOL CMyClockDlg::PreTranslateMessage( MSG* pMsg )
{
     static bool IsMouseDown = false;
     static CRect MainRect;
     static HCURSOR Cursor;
     static CPoint Point;

     Cursor = ::AfxGetApp()->LoadStandardCursor( IsMouseDown ? IDC_HAND :  IDC_ARROW );

     switch( pMsg->message )
     {
     case WM_LBUTTONDOWN:
         //Save current dialog’s rectangle
         GetWindowRect( &MainRect );
         //Save current cursor coordinate
         Point = pMsg->pt;
         ScreenToClient( &Point );
         SetCapture();
         //Change the sign
         IsMouseDown = true;
         Cursor = ::AfxGetApp()->LoadStandardCursor( IDC_HAND );
         break;

     case WM_LBUTTONUP:
         ReleaseCapture();
         //Stop the sign
         IsMouseDown = false;
         Cursor = ::AfxGetApp()->LoadStandardCursor( IDC_ARROW );
         break;

     case WM_MOUSEMOVE :
         if( IsMouseDown )
         {
              MoveWindow( pMsg->pt.x - Point.x, pMsg->pt.y - Point.y, MainRect.Width(), MainRect.Height(), TRUE );
              m_ClockCommon.CurrentPosition = CPoint( pMsg->pt.x - Point.x, pMsg->pt.y - Point.y );
         }
         break;
    }
    SetCursor( Cursor );
    return CDialog::PreTranslateMessage( pMsg );
}

void CMyClockDlg::OnMainExit()
{
    CDialog::OnOK();
}

void CMyClockDlg::OnContextMenu(CWnd* pWnd, CPoint point)
{
	OnSysTrayMsg( 0, WM_RBUTTONDOWN );
    return;
}

void CMyClockDlg::OnMainOptions()
{
    PropertiesDlg PropertyDlg;
    PropertyDlg.m_General.m_stClockFont = m_ClockFonts;
    PropertyDlg.m_General.m_stClockGeneral = m_ClockCommon;
    PropertyDlg.m_ColourPage.m_stPaintStruct = m_ClockPaintStruct;
    PropertyDlg.DoModal();
	PropertyDlg.DestroyWindow();
}

LRESULT CMyClockDlg::OnSysTrayMsg( WPARAM wParam, LPARAM lParam )
{
    if( WM_LBUTTONDBLCLK == lParam )
    {
       OnMainOptions();
    }
    else if( WM_RBUTTONDOWN == lParam )
    {
        CMenu menu;
        SetForegroundWindow();
        menu.LoadMenu( IDR_CLOCK_MENU );
        CPoint pt;
        ::GetCursorPos( &pt );
        menu.GetSubMenu( 0 )->TrackPopupMenu( TPM_RIGHTALIGN, pt.x, pt.y, this );
    }
    else if( WM_LBUTTONDOWN == lParam )
    {
        SetForegroundWindow();
        ShowWindow( SW_RESTORE );
    }
    return 0;
}

void CMyClockDlg::OnDestroy()
{
    // Save the settings and user preferences, on closing the clock window
    SaveSettings();
    // Deletes shell notify icon
    ::Shell_NotifyIcon( NIM_DELETE, &m_stNotifyData );
    CDialog::OnDestroy();
}

void CMyClockDlg::ChangeClockAppearence( const CLOCK_COMMON& stCommon_i, const CLOCK_FONT_REF& stFonts_i,
                                         const CLOCK_PAINT_STRUCT_REF& stPaints_i )
{
    m_ClockFonts = stFonts_i;
    m_ClockCommon = stCommon_i;
    m_ClockPaintStruct = stPaints_i;
    CreateClockRegionAndStyle( true );
    CreateClockStructures();
    // SaveSettings(); [No need to save here, we are saving on close or during system shutdown ]
    // Generate an Initial Snap shot of Clock for the current time
    DrawClockForTimeInstance( CTime::GetCurrentTime(), true );
}

void CMyClockDlg::OnAbout()
{
    CAboutDlg About;
	Sleep( 100 );
    About.DoModal();
	About.DestroyWindow();
}

CString CMyClockDlg::GetModulePath( void )
{
	TCHAR szExePath[ 1024 ];
	GetModuleFileName( 0, szExePath, 1024 );
	m_csExeFileName = szExePath;
	int nIndex = m_csExeFileName.ReverseFind( '\\' );
	return m_csExeFileName.Left( nIndex + 1 );
}

void CMyClockDlg::LoadSettings( void )
{
    try
    {
        m_csSettingsFile = GetModulePath() + "3AM Analogue Clock.DAT";
	    // Try block to load user preferences for the clock
        CFile InFile( m_csSettingsFile , CFile::modeRead );
        CArchive ArchiveIn( &InFile, CArchive::load  );
        m_ClockCommon.Serialize( ArchiveIn );
        m_ClockFonts.Serialize( ArchiveIn );
        m_ClockPaintStruct.Serialize( ArchiveIn );
        ArchiveIn.Close();
        InFile.Close();
    }
    catch( ... ) 
    {
    }
}

void CMyClockDlg::SaveSettings( void )
{
    // Save the user preferences to the archive file...
    try
    {
		// Try block to save the preferences made by the user
		// So that we can load the same on next startup
        CFile OutFile( m_csSettingsFile , CFile::modeWrite | CFile::modeCreate );
        CArchive ArchiveOut( &OutFile, CArchive::store );
        m_ClockCommon.Serialize( ArchiveOut );
        m_ClockFonts.Serialize( ArchiveOut );
        m_ClockPaintStruct.Serialize( ArchiveOut );
        ArchiveOut.Close();
        OutFile.Close();    
    }
    catch( ... ) 
    {
    }
    // Save the auto startup, registry option
    try
    {
        // Save the auto start up option...
        CRegKey RegKey;
        // Create/Open the required regkey
	    bool bSuccess = ERROR_SUCCESS == RegKey.Create(  HKEY_CURRENT_USER,
												         "Software\\Microsoft\\Windows\\CurrentVersion\\Run" );
        // If we successfully opened the registry key
	    if( bSuccess )
	    {
            // If user selected the auto start option
            if( m_ClockCommon.AutoStartUp )
		    {
                // Register our exe in the registry for auto startup	
			    bSuccess = ERROR_SUCCESS == RegKey.SetValue( m_csExeFileName , "3AM Analogue Clock 1.0" );
		    }
		    else
		    {
                // Remove the auto startup option from the registry, if its already there
			    RegKey.DeleteValue( "3AM Analogue Clock 1.0" );
		    }
            // Close the registry key...
		    RegKey.Close();
	    }
    }
    catch( ... ) 
    {
    }
}

void CMyClockDlg::OnEndSession( BOOL bEnding ) 
{
	CDialog::OnEndSession(bEnding);
	// Save the current settings of the clock to the file
    // Especially this needed to save the current clock position
    // While the system is goin to shutdown or logging off...
	if( bEnding ) SaveSettings();
}

void CMyClockDlg::OnOK() {}

void CMyClockDlg::OnCancel() {}