
#if !defined(_CLK_GNRL_H)
#define _CLK_GNRL_H


const float HOUR_HAND_RADIUS_BENDING_PROPOTION = 2.0;
const float MIN_HAND_RADIUS_BENDING_PROPOTION = 2.0;
const float SEC_HAND_RADIUS_BENDING_PROPOTION = 2.0;

const float HOUR_HAND_TIME_GAP = 0.30;
const float MIN_HAND_TIME_GAP = 0.70;
const float SEC_HAND_TIME_GAP = 0.08;

const float HOUR_HAND_RADIUS_PROPOTION = 1.70;
const float MIN_HAND_RADIUS_PROPOTION = 1.25;
const float SEC_HAND_RADIUS_PROPOTION = 1.15;

struct CLOCK_COMMON
{
public:
    
    int ClockRadius;
    BOOL ShowDigitalDate;
    BOOL ShowDigitalTime;
    int CurrentTransparency;
    CPoint CurrentPosition;
    BOOL AlwaysOnTop;
	BOOL AutoStartUp;

public:
    
    CLOCK_COMMON(): ClockRadius( 250 ), CurrentPosition( 509, 256 ), ShowDigitalDate( true ),
                    ShowDigitalTime( true ), CurrentTransparency( 188 ), AlwaysOnTop( true ) ,
					AutoStartUp( FALSE )
    {
    }

    CLOCK_COMMON& operator=( const CLOCK_COMMON& stCommonToCopy_i )
    {
        if( &stCommonToCopy_i == this ) return *this;
        ClockRadius = stCommonToCopy_i.ClockRadius;
        ShowDigitalDate = stCommonToCopy_i.ShowDigitalDate;
        ShowDigitalTime = stCommonToCopy_i.ShowDigitalTime;
        CurrentTransparency = stCommonToCopy_i.CurrentTransparency;
        CurrentPosition = stCommonToCopy_i.CurrentPosition;
        AlwaysOnTop = stCommonToCopy_i.AlwaysOnTop;
		AutoStartUp = stCommonToCopy_i.AutoStartUp;
        return *this;
    }

    void Serialize( CArchive& Archive_io )
	{
		if( Archive_io.IsStoring() )
        {
            Archive_io << ClockRadius;
            Archive_io << ShowDigitalDate;
            Archive_io << ShowDigitalTime;
            Archive_io << CurrentTransparency;
            Archive_io << CurrentPosition.x;
            Archive_io << CurrentPosition.y;
            Archive_io << AlwaysOnTop;
			Archive_io << AutoStartUp;
        }
        else
        {
            Archive_io >> ClockRadius;
            Archive_io >> ShowDigitalDate;
            Archive_io >> ShowDigitalTime;
            Archive_io >> CurrentTransparency;
            Archive_io >> CurrentPosition.x;
            Archive_io >> CurrentPosition.y;
            Archive_io >> AlwaysOnTop;
			Archive_io >> AutoStartUp;
        }
	}
};

struct CLOCK_PAINT_STRUCT_REF
{
public:

	CBrush DialogBackGround;
	CBrush ClockBackGround;	
	CBrush HourHandBrush;
	CBrush MinHandBrush;
	CBrush SecHandBrush;
	CPen HourHandPen;
	CPen MinHandPen;
	CPen SecHandPen;

	COLORREF HourHandColor;
	COLORREF MinHandColor;
	COLORREF SecHandColor;
	COLORREF TimeDigits;
	COLORREF DigitalDisplay;
	COLORREF DialogBackGroundColor;
	COLORREF ClockBackGroundColor;

public:

    CLOCK_PAINT_STRUCT_REF& operator=( const CLOCK_PAINT_STRUCT_REF& stPaintStructToCopy_i )
    {
        if( &stPaintStructToCopy_i == this ) return *this;
		ClearAll();
        HourHandColor = stPaintStructToCopy_i.HourHandColor;
        MinHandColor = stPaintStructToCopy_i.MinHandColor;
        SecHandColor = stPaintStructToCopy_i.SecHandColor;
        TimeDigits = stPaintStructToCopy_i.TimeDigits;
        DigitalDisplay = stPaintStructToCopy_i.DigitalDisplay;
        DialogBackGroundColor = stPaintStructToCopy_i.DialogBackGroundColor;
        ClockBackGroundColor = stPaintStructToCopy_i.ClockBackGroundColor;
        CreateBrushesAndPensFromColors();
        return *this;
    }

public:
	
	CLOCK_PAINT_STRUCT_REF( void ) :
	  TimeDigits( RGB( 255,255,128 )), DigitalDisplay( RGB( 128,128,255 )), HourHandColor( RGB( 0,0,255 )),
	  MinHandColor( RGB( 0,0,255 )), SecHandColor( RGB( 255,0,0 )),
	  DialogBackGroundColor( RGB( 145,145,145 )), ClockBackGroundColor( RGB( 0,0,64 ))
		  
	{
		  CreateBrushesAndPensFromColors();
	}
	
	~CLOCK_PAINT_STRUCT_REF()
	{
		ClearAll();
	}

	void ClearAll( void )
	{
		DialogBackGround.DeleteObject();
		ClockBackGround.DeleteObject();
		SecHandBrush.DeleteObject();
		SecHandPen.DeleteObject();
		MinHandBrush.DeleteObject();
		MinHandPen.DeleteObject();
		HourHandBrush.DeleteObject();
		HourHandPen.DeleteObject();
	}

	void CreateBrushesAndPensFromColors( void )
	{
		ClearAll();
		// START: Creation Of Paint Data for various elements in the clock		
		DialogBackGround.CreateSolidBrush( DialogBackGroundColor );
		ClockBackGround.CreateSolidBrush( ClockBackGroundColor );

		SecHandBrush.CreateSolidBrush( SecHandColor );
		SecHandPen.CreatePen( PS_SOLID, 2, SecHandColor );

		MinHandBrush.CreateSolidBrush( MinHandColor );
		MinHandPen.CreatePen( PS_SOLID, 3, MinHandColor );

		HourHandBrush.CreateSolidBrush( HourHandColor );
		HourHandPen.CreatePen( PS_SOLID,5, HourHandColor );
		// END: Creation Of Paint Data for various elements in the clock
	}

	void Serialize( CArchive& Archive_io )
	{
		if( Archive_io.IsStoring() )
        {
	        Archive_io << HourHandColor;
	        Archive_io << MinHandColor;
	        Archive_io << SecHandColor;
	        Archive_io << TimeDigits;
	        Archive_io << DigitalDisplay;
	        Archive_io << DialogBackGroundColor;
	        Archive_io << ClockBackGroundColor;
        }
        else
        {
            Archive_io >> HourHandColor;
	        Archive_io >> MinHandColor;
	        Archive_io >> SecHandColor;
	        Archive_io >> TimeDigits;
	        Archive_io >> DigitalDisplay;
	        Archive_io >> DialogBackGroundColor;
	        Archive_io >> ClockBackGroundColor;
        }
	}
};

struct CLOCK_FONT_REF
{
public:

	LOGFONT LogFont;
	CFont TimeDigits;
	CFont DigitalDisplay;

public:

    CLOCK_FONT_REF& operator=( const CLOCK_FONT_REF& stFontsToCopy_i )
    {
        if( &stFontsToCopy_i == this ) return *this;
		ClearAll();
        memcpy( &LogFont, &stFontsToCopy_i.LogFont, sizeof( LOGFONT ));	
        CreateFonts();
        return *this;
    }

public:
	
	~CLOCK_FONT_REF()
	{
		ClearAll();
	}
	
	CLOCK_FONT_REF( void )
	{
		::memset( &LogFont, 0, sizeof( LOGFONT ));
		LogFont.lfHeight = 130;
	   _tcscpy( LogFont.lfFaceName, "Courier New" );
	    LogFont.lfWeight = FW_BOLD;
	}

	void ClearAll( void )
	{
		TimeDigits.DeleteObject();
		DigitalDisplay.DeleteObject();
	}
	
	void CreateFonts( CDC* pDc_i = 0 )
	{
		ClearAll();
		// START: Creation Of Font Data for various elements in the clock
		TimeDigits.CreatePointFontIndirect( &LogFont, pDc_i );			
		DigitalDisplay.CreatePointFontIndirect( &LogFont, pDc_i );
		// END: Creation Of Font Data for various elements in the clock
	}

	void Serialize( CArchive& Archive_io )
	{
		if( Archive_io.IsStoring() )
        {
            CString csFaceNameOut( LogFont.lfFaceName );
            Archive_io << csFaceNameOut;
            Archive_io << LogFont.lfWeight;
            Archive_io << LogFont.lfHeight;
        }
        else
        {
            CString csFaceNameIn;
            Archive_io >> csFaceNameIn;
            _tcscpy( LogFont.lfFaceName, csFaceNameIn );
            Archive_io >> LogFont.lfWeight;
            Archive_io >> LogFont.lfHeight;
        }
	}
};

#endif