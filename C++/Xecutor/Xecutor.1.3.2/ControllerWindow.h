
#pragma once

#include "Dialog.h"
#include "ListBox.h"

class CControllerWindow : public CDialog 
{
protected:
	CListBox mListBox;

protected:
	bool LoadListBox(void);
	virtual bool DialogProcedure(UINT message, WPARAM wParam, LPARAM lParam);

public:
	CControllerWindow(void);
	bool Create(HINSTANCE hInstance,CWindow Parent = CWindow(0));
};

CControllerWindow::CControllerWindow(void) : CDialog(),mListBox(0) {}

bool CControllerWindow::Create(HINSTANCE hInstance,CWindow Parent)
{
	bool bOk = CDialog::Create(hInstance,IDD_DLG_CONTROLLER,Parent); 
	mListBox.ResetParent(CWindow(Handle()));
	mListBox.ResetChild(IDC_LST_CONTROLLER_PROFILES); 
	LoadListBox();  
	return bOk;
}

bool CControllerWindow::LoadListBox(void)
{
	CWindowUtility::ShowWaitCursor();  
	mListBox.Clear(); 
	CTString Name,Stat,Ttime;
	CMailClient oClient;
	oClient.Set();
	int iCnt = oClient.ProfileCount(); 
	for(int i = 0; i < iCnt; i++)
	{
		oClient.GetProfile(i,Name,Stat);
		oClient.GetProfileTriggerTime(i,Ttime); 
		mListBox.AddItem(Name + "," + Stat + ", Next Trigger:" + Ttime);  
	} 
	CWindowUtility::ShowDefaultCursor(); 
	return 1; 
}

bool CControllerWindow::DialogProcedure(UINT message, WPARAM wParam, LPARAM lParam)
{
	int wmId, wmEvent;
	
	switch (message) 
	{
		case WM_INITDIALOG:
			return true;
			
		case WM_CLOSE:
			Destroy();
			return 1;
			
		
		case WM_LBUTTONDBLCLK:
		
		case WM_MOUSEMOVE: break;

		case WM_DESTROY: 
			return 0;
		
		case WM_COMMAND:
			wmId    = LOWORD(wParam); 
			wmEvent = HIWORD(wParam); 

			switch (wmId)
			{
				case IDC_BTN_CONTROLLER_REFRESH: 
					LoadListBox();									
					return 1;

				default:
					return 1;
			}
			return 1;

		case WM_PAINT: 

		default: return 0;
	}
	return 0;
}