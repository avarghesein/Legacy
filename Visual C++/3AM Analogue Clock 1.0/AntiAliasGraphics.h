
#if !defined(TGRAPHICS_H)
#define TGRAPHICS_H



class CSmoothingGraphics
{
public:
	
	void DrawEllipse(HDC hDC, CRect BoundingRectangle, COLORREF color);
	void DrawLine(HDC hDC, CPoint Point1, CPoint Point2, COLORREF color);

};

#endif 