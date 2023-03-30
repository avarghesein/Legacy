// TGraphics.cpp: implementation of the CTGraphics class.
//
//////////////////////////////////////////////////////////////////////

#pragma once

#include "stdafx.h"
#include "AntiAliasGraphics.h"
#include "math.h"


void CSmoothingGraphics::DrawLine(HDC hDC,CPoint Point1, CPoint Point2 , COLORREF color)
{
	int x1 = Point1.x, y1 = Point1.y, x2 = Point2.x, y2 = Point2.y;
	// Calculate line params
	int dx = (x2 - x1);
	int dy = (y2 - y1);
	COLORREF bgColor;
	int temp;
	float k;

	// Set start pixel
	::SetPixel(hDC, x1, y1, color);

	// X-dominant line
	if (abs(dx) > abs(dy))
	{
		// Ex-change line end points
		if (dx < 0)
		{
			temp = x1;
			x1 = x2;
			x2 = temp;

			temp = y1;
			y1 = y2;
			y2 = temp;
		}
		k = (float)dy / (float)dx;

		// Set middle pixels
		int xs;
		float yt = (float)y1 + k;
		float distance;
		UCHAR red, green, blue;
		for (xs=x1+1; xs<x2; xs++)
		{
			distance = (float)(yt - (int)(yt));

			bgColor = ::GetPixel(hDC, xs, (int)yt);
			red = (UCHAR)(distance*GetRValue(bgColor)) + (UCHAR)((1.0f-distance)*GetRValue(color));
			green = (UCHAR)(distance*GetGValue(bgColor)) + (UCHAR)((1.0f-distance)*GetGValue(color));
			blue = (UCHAR)(distance*GetBValue(bgColor)) + (UCHAR)((1.0f-distance)*GetBValue(color));
			::SetPixel(hDC, xs, (int)yt, RGB(red,green,blue));

			bgColor = ::GetPixel(hDC, xs, (int)yt+1);
			red = (UCHAR)((1.0f-distance)*GetRValue(bgColor)) + (UCHAR)(distance*GetRValue(color));
			green = (UCHAR)((1.0f-distance)*GetGValue(bgColor)) + (UCHAR)(distance*GetGValue(color));
			blue = (UCHAR)((1.0f-distance)*GetBValue(bgColor)) + (UCHAR)(distance*GetBValue(color));
			::SetPixel(hDC, xs, (int)yt+1, RGB(red,green,blue));
			yt += k;
			
		}
	}
	// Y-dominant line
	else
	{
		// Ex-change line end points
		if (dy < 0)
		{
			temp = x1;
			x1 = x2;
			x2 = temp;

			temp = y1;
			y1 = y2;
			y2 = temp;
		}
		k = (float)dx / (float)dy;

		// Set middle pixels
		int ys;
		float xt = (float)x1 + k;
		float distance;
		UCHAR red, green, blue;
		for (ys=y1+1; ys<y2; ys++)
		{
			distance = (float)(xt - (int)(xt));

			bgColor = ::GetPixel(hDC, (int)xt, ys);
			red = (UCHAR)(distance*GetRValue(bgColor)) + (UCHAR)((1.0f-distance)*GetRValue(color));
			green = (UCHAR)(distance*GetGValue(bgColor)) + (UCHAR)((1.0f-distance)*GetGValue(color));
			blue = (UCHAR)(distance*GetBValue(bgColor)) + (UCHAR)((1.0f-distance)*GetBValue(color));
			::SetPixel(hDC, (int)xt, ys, RGB(red,green,blue));

			bgColor = ::GetPixel(hDC, (int)xt+1, ys);
			red = (UCHAR)((1.0f-distance)*GetRValue(bgColor)) + (UCHAR)(distance*GetRValue(color));
			green = (UCHAR)((1.0f-distance)*GetGValue(bgColor)) + (UCHAR)(distance*GetGValue(color));
			blue = (UCHAR)((1.0f-distance)*GetBValue(bgColor)) + (UCHAR)(distance*GetBValue(color));
			::SetPixel(hDC, (int)xt+1, ys, RGB(red,green,blue));

			xt += k;
		}
	}

	// Set end pixel
	::SetPixel(hDC, x2, y2, color);
}

void CSmoothingGraphics::DrawEllipse(HDC hDC, CRect BoundingRectangle, COLORREF color)
{
	int x1 = BoundingRectangle.left, y1 = BoundingRectangle.top;
	int x2 = BoundingRectangle.right, y2 = BoundingRectangle.bottom;
	int centerX = (x1 + x2) / 2;
	int centerY = (y1 + y2) / 2;
	int dx = (x2 - x1);
	int dy = (y2 - y1);
	int radiusX = (int)(fabs(dx) / 2.0f);
	int radiusY = (int)(fabs(dy) / 2.0f);
	float rel = (float)sqrt(radiusX*radiusX + radiusY*radiusY) / (float)radiusY;
	COLORREF bgColor;
	int temp;
	float distance;
	UCHAR red, green, blue;

	if (x2 < x1)
	{
		temp = x1;
		x1 = x2;
		x2 = temp;

		temp = y1;
		y1 = y2;
		y2 = temp;
	}

	int xs;
	float yt;
	for (xs=-radiusX; xs<=radiusX; xs++)
	{
		yt = (float)(radiusY * sqrt(1-(float)(xs*xs)/(float)(radiusX*radiusX)));
		distance = (float)(yt - (int)yt);

		bgColor = ::GetPixel(hDC, centerX+xs, centerY+(int)yt);
		red = (UCHAR)(distance*GetRValue(bgColor)) + (UCHAR)((1.0f-distance)*GetRValue(color));
		green = (UCHAR)(distance*GetGValue(bgColor)) + (UCHAR)((1.0f-distance)*GetGValue(color));
		blue = (UCHAR)(distance*GetBValue(bgColor)) + (UCHAR)((1.0f-distance)*GetBValue(color));
		::SetPixel(hDC, centerX+xs, centerY+(int)yt, RGB(red,green,blue));

		bgColor = ::GetPixel(hDC, centerX+xs, centerY+(int)yt+1);
		red = (UCHAR)((1.0f-distance)*GetRValue(bgColor)) + (UCHAR)(distance*GetRValue(color));
		green = (UCHAR)((1.0f-distance)*GetGValue(bgColor)) + (UCHAR)(distance*GetGValue(color));
		blue = (UCHAR)((1.0f-distance)*GetBValue(bgColor)) + (UCHAR)(distance*GetBValue(color));
		::SetPixel(hDC, centerX+xs, centerY+(int)yt+1, RGB(red,green,blue));

		bgColor = ::GetPixel(hDC, centerX-xs, centerY-(int)yt);
		red = (UCHAR)(distance*GetRValue(bgColor)) + (UCHAR)((1.0f-distance)*GetRValue(color));
		green = (UCHAR)(distance*GetGValue(bgColor)) + (UCHAR)((1.0f-distance)*GetGValue(color));
		blue = (UCHAR)(distance*GetBValue(bgColor)) + (UCHAR)((1.0f-distance)*GetBValue(color));
		::SetPixel(hDC, centerX-xs, centerY-(int)yt, RGB(red,green,blue));

		bgColor = ::GetPixel(hDC, centerX-xs, centerY-(int)yt-1);
		red = (UCHAR)((1.0f-distance)*GetRValue(bgColor)) + (UCHAR)(distance*GetRValue(color));
		green = (UCHAR)((1.0f-distance)*GetGValue(bgColor)) + (UCHAR)(distance*GetGValue(color));
		blue = (UCHAR)((1.0f-distance)*GetBValue(bgColor)) + (UCHAR)(distance*GetBValue(color));
		::SetPixel(hDC, centerX-xs, centerY-(int)yt-1, RGB(red,green,blue));
	}

	int ys;
	float xt;
	for (ys=-(int)((float)radiusY/rel); ys<=(int)((float)radiusY/rel); ys++)
	{
		xt = (float)(radiusX * sqrt(1-(float)(ys*ys)/(float)(radiusY*radiusY)));
		distance = (float)(xt - (int)xt);

		bgColor = ::GetPixel(hDC, centerX+(int)xt, centerY+ys);
		red = (UCHAR)(distance*GetRValue(bgColor)) + (UCHAR)((1.0f-distance)*GetRValue(color));
		green = (UCHAR)(distance*GetGValue(bgColor)) + (UCHAR)((1.0f-distance)*GetGValue(color));
		blue = (UCHAR)(distance*GetBValue(bgColor)) + (UCHAR)((1.0f-distance)*GetBValue(color));
		::SetPixel(hDC, centerX+(int)xt, centerY+ys, RGB(red,green,blue));

		bgColor = ::GetPixel(hDC, centerX+(int)xt+1, centerY+ys);
		red = (UCHAR)((1.0f-distance)*GetRValue(bgColor)) + (UCHAR)(distance*GetRValue(color));
		green = (UCHAR)((1.0f-distance)*GetGValue(bgColor)) + (UCHAR)(distance*GetGValue(color));
		blue = (UCHAR)((1.0f-distance)*GetBValue(bgColor)) + (UCHAR)(distance*GetBValue(color));
		::SetPixel(hDC, centerX+(int)xt+1, centerY+ys, RGB(red,green,blue));

		bgColor = ::GetPixel(hDC, centerX-(int)xt, centerY-ys);
		red = (UCHAR)(distance*GetRValue(bgColor)) + (UCHAR)((1.0f-distance)*GetRValue(color));
		green = (UCHAR)(distance*GetGValue(bgColor)) + (UCHAR)((1.0f-distance)*GetGValue(color));
		blue = (UCHAR)(distance*GetBValue(bgColor)) + (UCHAR)((1.0f-distance)*GetBValue(color));
		::SetPixel(hDC, centerX-(int)xt, centerY-ys, RGB(red,green,blue));

		bgColor = ::GetPixel(hDC, centerX-(int)xt-1, centerY-ys);
		red = (UCHAR)((1.0f-distance)*GetRValue(bgColor)) + (UCHAR)(distance*GetRValue(color));
		green = (UCHAR)((1.0f-distance)*GetGValue(bgColor)) + (UCHAR)(distance*GetGValue(color));
		blue = (UCHAR)((1.0f-distance)*GetBValue(bgColor)) + (UCHAR)(distance*GetBValue(color));
		::SetPixel(hDC, centerX-(int)xt-1, centerY-ys, RGB(red,green,blue));
	}
}