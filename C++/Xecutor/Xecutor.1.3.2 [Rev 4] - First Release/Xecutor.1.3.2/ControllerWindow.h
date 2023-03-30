
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
	~CControllerWindow(void);
	CControllerWindow(void);
	bool Create(HINSTANCE hInstance,CWindow Parent = CWindow(0));
	static bool ItemToDelete(void* ItemPtr);
};

bool CControllerWindow::ItemToDelete(void* ItemPtr)
{
	try
	{ 
		if(ItemPtr) delete (CTString*)ItemPtr;
	}
	catch(...) { return false; }
	return true;
}

CControllerWindow::~CControllerWindow(void)
{
	mListBox.Clear(&ItemToDelete,true); 
}

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
	mListBox.Clear(&ItemToDelete,true); 
	CTString Name,Stat,Ttime,*ShortName = 0;
	CMailClient oClient;
	oClient.Set();
	int iCnt = oClient.ProfileCount(); 
	for(int i = 0; i < iCnt; i++)
	{
		ShortName = new CTString();
		oClient.GetProfile(i,*ShortName,Stat);
		oClient.GetProfile(i,Name,Stat,false);
		oClient.GetProfileTriggerTime(i,Ttime); 
		mListBox.AddItem(Name + "," + Stat + ", Next Trigger:" + Ttime,(void*)ShortName);  
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

				case IDC_BTN_STOP_SCHED:
				case IDC_BTN_START_SCHED:
				case IDC_BTN_TERMINATE_PROCESS:
					if(mListBox.SelectedIndex() >= 0)
					{
						CMailClient oClient;
						if(oClient.Set()) 
						{
							CWindowUtility::ShowWaitCursor(); 
							if(IDC_BTN_TERMINATE_PROCESS != wmId)
							{
								oClient.Schedule(wmId == IDC_BTN_START_SCHED,mListBox.SelectedItem());
							}
							else
							{
								oClient.Terminate(mListBox.SelectedItem()); 
							}
							SleepEx(800,1);
							LoadListBox();
						}
					}
					return 1;

				case IDC_BTN_RESET_ALL:
				case IDC_BTN_TERMINATE_ALL:
				case IDC_BTN_RESTART_SERVICE:
					{
						CMailClient oClient;
						if(oClient.Set()) 
						{
							CWindowUtility::ShowWaitCursor(); 
							if(IDC_BTN_RESTART_SERVICE == wmId)
							{
								oClient.RestartService(); 
							}
							else
							{
								oClient.AllProfiles(IDC_BTN_TERMINATE_ALL == wmId);
							}
							SleepEx(1000,1);
							LoadListBox();
						}
					}
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