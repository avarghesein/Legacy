
#pragma once

#include "ListBox.h"
#include "WinMonitorXmlUtility.h"
#include "ChildWindow.h"
#include "ControllerWindow.h"

class CMainWindow
{
	private :
		static HWND hMainWnd;
		static HINSTANCE hInst;

		static LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
		static int AddIconToTray(int iAdd,HWND hWnd);		
		static int LoadListBox(CListBox &oListBox);
		static int LoadXml(CXmlUtility &oXmlUtil);

	public:
		static WORD mQuitMessage;

	public :
		CMainWindow(void);
		static bool Create(HINSTANCE hInstance);
		static void Destroy(void);
		static HWND GetHandle(void) { return hMainWnd; }		
		static int LoadListBox(void);
};

HINSTANCE CMainWindow::hInst = 0;
HWND CMainWindow::hMainWnd = 0;
WORD CMainWindow::mQuitMessage = (WORD)RegisterWindowMessage("QUIT XECUTOR NON-SERVICE PROCESS!");

CMainWindow::CMainWindow(void) {}

int CMainWindow::LoadListBox(void)
{
	if(!hMainWnd) return 0;
	return LoadListBox(CListBox(IDC_LST_PROFILES,hMainWnd)); 
}

int CMainWindow::LoadXml(CXmlUtility &oXmlUtil)
{
	CTString tsXmlFile;
	if(!CWindowUtility::GetExeName(tsXmlFile,1)) return 0;
	tsXmlFile += "\\" + CTString(CONFIG_FILE);
	if(!oXmlUtil.OpenXmlDocument((TCHAR*)tsXmlFile)) return 0;
	return oXmlUtil.ResetSearchPointerToRoot();
}

int CMainWindow::LoadListBox(CListBox &oListBox)
{
	CXmlUtility oXmlUtil;
	int iLevelCnt,iIndx;

	if(!LoadXml(oXmlUtil) || !oXmlUtil.MoveToChild("PROFILES")) return 0;  
	oListBox.Clear(); 
	for(iLevelCnt = oXmlUtil.LevelCount(), iIndx = 0; iIndx < iLevelCnt; ++iIndx) 
	{
		oListBox.AddItem(oXmlUtil[iIndx]); 
	}
	return 1;
}

bool CMainWindow::Create(HINSTANCE hInstance)
{
	hInst = hInstance;

	HWND hWnd = 0;
	if(!hMainWnd)
	{
		hWnd = CreateDialog(hInstance,(LPCTSTR)IDD_DLG_XECUTOR,0,(DLGPROC)CMainWindow::WndProc);
		if(hWnd)
			if(ShowWindow(hWnd,SW_HIDE),CMainWindow::AddIconToTray(1,hWnd))
			{
				hMainWnd = hWnd;
				return true;
			} 
		Destroy();    
	}
	return false;
}

void CMainWindow::Destroy(void)
{
	if(hMainWnd)
		try
		{
			SendMessage(hMainWnd,CMainWindow::mQuitMessage,0,0);   
			CMainWindow::AddIconToTray(0,hMainWnd); 
			hMainWnd = 0;
		} 
		catch(...) {}
}

int CMainWindow::AddIconToTray(int iAdd,HWND hWnd)
{
	char szBuff[64] = SERVICE_NAME;
	NOTIFYICONDATA oData;

	oData.cbSize = sizeof(NOTIFYICONDATA);
    oData.hWnd = hWnd;
    oData.uID = 0;
    oData.uFlags = NIF_ICON | NIF_TIP | NIF_MESSAGE;
    oData.uCallbackMessage = WM_LBUTTONDBLCLK ;
    oData.hIcon = LoadIcon(hInst,(LPTSTR)IDI_SMALL);
   _tcscpy(oData.szTip,szBuff);

	Shell_NotifyIcon(iAdd ? NIM_ADD : NIM_DELETE,&oData);  

	return 1;
}

CControllerWindow Controller; 

LRESULT CALLBACK CMainWindow::WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	static int bIsClose=0;
	
	if(message==(UINT)CMainWindow::mQuitMessage) 
	{
		bIsClose=true,SendMessage(hWnd,WM_CLOSE,0,0L); 
		return 1;
	}

	CListBox oLstBox(IDC_LST_PROFILES,hWnd);

	int wmId, wmEvent;
	
	switch (message) 
	{
		case WM_INITDIALOG:
			bIsClose=false; return 1;
		
		case WM_CLOSE:
			CChildWindow::Destroy(); 
			if(!bIsClose) 
				ShowWindow(hWnd,SW_HIDE);
			else
				CMainWindow::AddIconToTray(0,hWnd),DestroyWindow(hWnd),CMainWindow::hMainWnd = 0;

			return 1;
		
		case WM_LBUTTONDBLCLK:
			if(lParam == WM_LBUTTONDBLCLK) 
			{
				try { LoadListBox(oLstBox); } catch(...) {}
				ShowWindow(hWnd,SW_SHOWNORMAL); 
				return 1;
			}

		case WM_MOUSEMOVE: break;

		case WM_DESTROY:
			if(bIsClose) PostQuitMessage(0); return 1;

		case WM_COMMAND:
			wmId    = LOWORD(wParam); 
			wmEvent = HIWORD(wParam); 

			switch (wmId)
			{
				case IDC_BTN_SHOW_CONTROLLER:
					Controller.Create(CMainWindow::hInst,CWindow(hWnd));  
					Controller.Show(true);
					return 1;

				case IDC_BTN_CANCELXECUTOR: 
					SendMessage(hWnd,WM_CLOSE,0,0); return 1;
				
				case IDC_BTN_DELETEPROFILE:
					{
						CXmlUtility oXmlUtil;
						int iSelIndx = oLstBox.SelectedIndex(); 
						if(iSelIndx != -1 && CWindowUtility::GetUserConfirmation("Are you sure to delete this?",hWnd))
						{
							CTString tsBuff = oLstBox.SelectedItem(); 
							if(!LoadXml(oXmlUtil)) break;
							if(!oXmlUtil.RemoveNodes("PROFILES/" + tsBuff)) break;
							oLstBox.DeleteItem(iSelIndx); 
						}
					}
					return 1;

				case IDC_BTN_ADDPROFILE:
					{
						CChildWindow::Create(CMainWindow::hInst,hWnd);    
					}
					return 1;

				case IDC_BTN_EDITPROFILE: 
				{
					int iSelIndx = oLstBox.SelectedIndex(); 
					if(iSelIndx == -1) break;
					CTString tsBuff = oLstBox.SelectedItem(); 
					CChildWindow::Create(CMainWindow::hInst,hWnd);
					CChildWindow::Update(tsBuff); 
				}
				return 1;

				default:
					return 0;
			}
			return 1;

		case WM_PAINT: break;

		default: return 0;
	}
	return 0;
}