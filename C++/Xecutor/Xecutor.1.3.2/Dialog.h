
#pragma once

#include "Window.h"

class CDialog : public CWindow 
{
protected:
	CWindow mParent;

protected:
	static LRESULT CALLBACK DlgProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
	static CTString WindowProperty;
	
	virtual bool DialogProcedure(UINT message, WPARAM wParam, LPARAM lParam);

public:	
	CDialog(void);
	virtual ~CDialog(void);
	virtual bool Create(HINSTANCE hInstance,int DialogID,CWindow Parent = CWindow(0));
	virtual bool Show(bool Modal);
	virtual bool Destroy(void);
};

CTString CDialog::WindowProperty = "DLG-OBJ";

CDialog::CDialog(void) : CWindow(0),mParent(0) {}

CDialog::~CDialog(void)
{
	Destroy();
}

bool CDialog::Destroy(void)
{
	if(!mhWnd) return true;
	if(mhWnd && DestroyWindow(mhWnd))
	{
		mhWnd = 0;
		return true;
	}
	return false;
}

bool CDialog::Create(HINSTANCE hInstance,int DialogID,CWindow Parent)
{
	Destroy();
	mParent.SetHandle(Parent.Handle());  
	mhWnd = CreateDialogParam(hInstance,(LPCTSTR)DialogID,mParent.Handle(),(DLGPROC)CDialog::DlgProc,(LPARAM)(void*)this);
	return mhWnd != 0;
}

LRESULT CALLBACK CDialog::DlgProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	if(WM_INITDIALOG == message && ((CDialog*)GetProp(hWnd,CDialog::WindowProperty)) == 0)
	{
		SetProp(hWnd,CDialog::WindowProperty,(void*)lParam); 

		CDialog *Dialog = (CDialog*)(void*)lParam;
		Dialog->mhWnd = hWnd; 
	}

	CDialog *Dialog = (CDialog*)GetProp(hWnd,CDialog::WindowProperty); 

	if(!Dialog) return 0;
	try
	{
		return Dialog->DialogProcedure(message,wParam,lParam) ? 1 : 0; 
	}
	catch(...)
	{
		return 0;
	}
}

bool CDialog::DialogProcedure(UINT message, WPARAM wParam, LPARAM lParam)
{
	return false;
}

bool CDialog::Show(bool Modal)
{
	return mhWnd && ShowWindow(mhWnd,SW_SHOWNORMAL) != FALSE;
}