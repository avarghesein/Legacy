
#pragma once

#include "Window.h"

class CChildControl : public CWindow 
{
protected:
	int mChildItemId; 
	CWindow mParentWnd;

protected:
	virtual bool ValidWindow(void);
	LRESULT SendMessage(UINT Msg,WPARAM wParam = 0,LPARAM lParam = 0);

public:
	CChildControl(int ChildItemID,CWindow ParentWindow);
	virtual CTString GetText(void);
	virtual bool SetText(CTString Text);
	virtual long GetTextAsLong(void);
	virtual bool ResetChild(int NewChildItemId);
	virtual bool ResetParent(CWindow NewParent);
};

CChildControl::CChildControl(int ChildItemID,CWindow ParentWindow) 
: mParentWnd(ParentWindow),mChildItemId(ChildItemID),CWindow(0) 
{}

bool CChildControl::ValidWindow(void) 
{
	if(!mParentWnd.ValidWindow()) return false;
	if(!mhWnd) mhWnd = GetDlgItem(mParentWnd.Handle(),mChildItemId);  
	return mhWnd != 0;  
}

LRESULT CChildControl::SendMessage(UINT Msg,WPARAM wParam,LPARAM lParam)
{
	if(!ValidWindow()) return 0;
	return SendDlgItemMessage(mParentWnd.Handle(),mChildItemId,Msg,wParam,lParam); 
}

CTString CChildControl::GetText(void)
{
	return CWindow::GetText(); 
}
bool CChildControl::SetText(CTString Text)
{
	return CWindow::SetText(Text); 
}

long CChildControl::GetTextAsLong(void)
{
	return (long)GetDlgItemInt(mParentWnd.Handle(),mChildItemId,0,true);
}

bool CChildControl::ResetChild(int NewChildItemId)
{
	mChildItemId = NewChildItemId;
	mhWnd = 0;
	return ValidWindow();  
}

bool CChildControl::ResetParent(CWindow NewParent)
{
	return mParentWnd.SetHandle(NewParent.Handle()) && ValidWindow(); 
}