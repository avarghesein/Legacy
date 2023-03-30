

#if !defined(_CLOCK_DIALOG_INCLUDED_)
#define _CLOCK_DIALOG_INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif

#include "AntiAliasGraphics.h"
#include "ClockStructs.h"

class CMyClockDlg : public CDialog
{
public:
    CMyClockDlg(CWnd* pParent = NULL);
	virtual ~CMyClockDlg();

    //{{AFX_DATA(CMyClockDlg)
	enum { IDD = IDD_MYCLOCK_DIALOG };
	//}}AFX_DATA

    //{{AFX_VIRTUAL(CMyClockDlg)
    public:
    virtual BOOL PreTranslateMessage(MSG* pMsg);
    protected:
    virtual void DoDataExchange(CDataExchange* pDX);
    //}}AFX_VIRTUAL

protected:
    HICON m_hIcon;

    //{{AFX_MSG(CMyClockDlg)
    virtual BOOL OnInitDialog();
    afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
    afx_msg void OnPaint();
    afx_msg HCURSOR OnQueryDragIcon();
    afx_msg void OnTimer(UINT nIDEvent);
    afx_msg void OnMainExit();
    afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
    afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
    afx_msg void OnMainOptions();
    afx_msg LRESULT OnSysTrayMsg( WPARAM wParam, LPARAM lParam );
    afx_msg void OnDestroy();
	afx_msg void OnAbout();
	afx_msg void OnEndSession(BOOL bEnding);
	//}}AFX_MSG
    DECLARE_MESSAGE_MAP()

private:
        CString GetModulePath( void );

        void CreateClockRegionAndStyle( bool bUpdate_i );
        void CreateClockStructures( void );
        void DrawClockForTimeInstance( const CTime& Time_i, bool IsInitialCall_i );
        void DigitalDisplay( CDC *pDc_i, float fRad_i, const CPoint& CentrePoint_i, const CTime& CurrentTime_i, bool IsInitialCall_i );
        CPoint GetCordinatesOfClockHand( float fCurrentTimeSegment_i, float fTimeUnits_i,
                                         float fRadiusForTimeSegment_i, const CPoint& CentreOfClock_i );
        void CreateClockHand( float fCurrentTimeSegment_i, float fTimeUnits_i, float fClockRadius_i,
                              const CPoint& CentreOfClock_i, float fRadiusPropotionForTimeSegment_i,
                              float fHandRadiusBendingPropotion_i, float fTimeGap_i, const CBrush& HandColorBrush_i,
                              const CPen& HandColorPen_i, COLORREF HandColor_i );
        void OnOK();
        void OnCancel();
public:

        void ChangeClockAppearence( const CLOCK_COMMON& stCommon_i, const CLOCK_FONT_REF& stFonts_i,
                                    const CLOCK_PAINT_STRUCT_REF& stPaints_i );
        void LoadSettings( void );
        void SaveSettings( void );

private:
        CString m_csSettingsFile;
        CString m_csExeFileName;
        CDC m_MemoryDC;
        CPoint m_CentrePoint;
        float m_fRadius;
        CRect m_DigitalDateRect, m_DigitalTimeRect;
        float m_fSec, m_fMin, m_fHr;
        CBrush m_EraseHandsBrush;
        CPen m_EraseHandsPen;
        bool m_bIsTray;
		CSmoothingGraphics m_SmoothingGrpahics;
        NOTIFYICONDATA m_stNotifyData;

public:
        CLOCK_PAINT_STRUCT_REF m_ClockPaintStruct;
        CLOCK_FONT_REF m_ClockFonts;
        CLOCK_COMMON m_ClockCommon;

};

//{{AFX_INSERT_LOCATION}}

#endif
