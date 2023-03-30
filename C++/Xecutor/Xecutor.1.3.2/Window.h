
#pragma once

class CWindow
{
protected:
	HWND mhWnd;

public:
	CWindow(HWND hWnd);
	CWindow(CWindow &Wnd);
	virtual bool ValidWindow(void);
	virtual HWND Handle(void);
	virtual bool SetHandle(HWND hWnd);
	virtual bool SetHandle(CWindow Wnd);
	virtual CTString GetText(void);
	virtual bool SetText(CTString Text);
	virtual LRESULT SendWindowMessage(UINT Msg,WPARAM wParam = 0,LPARAM lParam = 0);
};

CWindow::CWindow(HWND hWnd) : mhWnd(hWnd) {}

CWindow::CWindow(CWindow &Wnd) : mhWnd(Wnd.Handle()) {}

bool CWindow::ValidWindow(void)
{  
	return mhWnd != 0;
}

CTString CWindow::GetText(void)
{
	if(!ValidWindow()) return CTString();
	int iSze = GetWindowTextLength(mhWnd);  
	CTString tBuff(iSze + 1,true);
	if(GetWindowText(mhWnd,tBuff,iSze + 1)) return tBuff;   
	return CTString();
}

bool CWindow::SetText(CTString Text)
{
	if(!ValidWindow()) return false;
	return SetWindowText(mhWnd,Text) != 0; 
}

HWND CWindow::Handle(void)
{
	return mhWnd;
}

bool CWindow::SetHandle(HWND hWnd)
{
	mhWnd = hWnd;
	return ValidWindow();
}

bool CWindow::SetHandle(CWindow Wnd)
{
	return SetHandle(Wnd.Handle()); 
}

LRESULT CWindow::SendWindowMessage(UINT Msg,WPARAM wParam,LPARAM lParam)
{
	return SendMessage(mhWnd,Msg,wParam,lParam);  
}