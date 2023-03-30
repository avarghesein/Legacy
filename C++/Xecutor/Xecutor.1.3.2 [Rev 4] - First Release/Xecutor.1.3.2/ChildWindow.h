
#pragma once

class CChildWindow
{
	private :
		static CTString mtsItemToEdit;
		static bool mbCalledForEdit;
		static HWND hChildWnd;
		static LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
		static bool IsProfileExists(CTString tsProfile);
		static int OpenXml(CXmlUtility &oXmlUtil);
		static CTString GetText(int TxtBoxID);
		static void SetText(int TxtBoxID,CTString tsStr);
	public :

		static bool Create(HINSTANCE hInstance,HWND hParent);
		static void Destroy(void);
		static HWND GetHandle(void) { return hMainWnd; }
		static bool Update(CTString tsEditItem);
};

HWND CChildWindow::hChildWnd = 0;
CTString CChildWindow::mtsItemToEdit;
bool CChildWindow::mbCalledForEdit = false;

CTString CChildWindow::GetText(int TxtBoxID)
{
	return CWindowUtility::GetText(hChildWnd,TxtBoxID);  
}

void CChildWindow::SetText(int TxtBoxID,CTString tsStr)
{   
	CWindowUtility::SetText(hChildWnd,TxtBoxID,tsStr);  
}

int CChildWindow::OpenXml(CXmlUtility &oXmlUtil)
{
	CTString tsXmlFile;
	if(!CWindowUtility::GetExeName(tsXmlFile,1)) return 0;
	tsXmlFile += "\\" + CTString(CONFIG_FILE);
	if(!oXmlUtil.OpenXmlDocument((TCHAR*)tsXmlFile)) 
		if(!oXmlUtil.CreateNewXmlDocument((TCHAR*)tsXmlFile,"PROFILES")) return 0;  

	return oXmlUtil.ResetSearchPointerToRoot();
}

bool CChildWindow::Create(HINSTANCE hInstance,HWND hParent) 
{
	HWND hWnd;
	if(!hChildWnd)
	{
		mbCalledForEdit = false;
		CChildWindow::Destroy();
		hWnd = CreateDialog(hInstance,(LPCTSTR)IDD_DLG_PROFILE,hParent,(DLGPROC)CChildWindow::WndProc);
		if(hWnd)
		{
			SetWindowText(hWnd,"[Untitled] - Profile");  
			ShowWindow(hWnd,SW_SHOWNORMAL);
			hChildWnd = hWnd;
			return true;
		}
		Destroy();    
	} else ShowWindow(hChildWnd,SW_NORMAL);
	return false;
}

void CChildWindow::Destroy(void)
{
	if(hChildWnd)
		try
		{
			SendMessage(hChildWnd,WM_CLOSE,0,0);   
			hChildWnd = 0;
		} 
		catch(...) {}
}

bool CChildWindow::Update(CTString tsEditItem)
{
	mbCalledForEdit = true;
	mtsItemToEdit = tsEditItem.ToUpper();

	CXmlUtility oXmlUtil;
	if(!OpenXml(oXmlUtil))
	{
		CWindowUtility::PromptUser("Cannot Open/Create Configuration XML file!",hChildWnd);
		return false;
	}
	SetWindowText(hChildWnd,(TCHAR*)(mtsItemToEdit + CTString(" - Profile")));  

	CTString tsBuff = "PROFILES/" + mtsItemToEdit,tsTmp;
	SetText(IDC_TXT_PROFILENAME,mtsItemToEdit); 

	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/SCRIPT",tsTmp,true);
	SetText(IDC_TXT_SCRIPTFILE,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/DUMP-FOLDER",tsTmp,true);  
	SetText(IDC_TXT_DUMPFOLDER,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/TEMPLATE-FILE",tsTmp,true); 
	SetText(IDC_TXT_TEMPLATEFILE,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/USER-NAME",tsTmp,true); 
	SetText(IDC_TXT_USERNAME,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/PASSWORD",tsTmp,true); 	
	SetText(IDC_TXT_PASSWORD,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/DATABASE",tsTmp,true); 
	SetText(IDC_TXT_DBNAME,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/EXTRA-OPTIONS",tsTmp,true); 
	SetText(IDC_TXT_EXTRAOPT,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/SCHEDULE-HOUR",tsTmp,true); 
	SetText(IDC_TXT_SCHHOUR,tsTmp);  
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/SCHEDULE-MIN",tsTmp,true); 
	SetText(IDC_TXT_SCHMIN,tsTmp);  
	
	oXmlUtil.GetNodeTextFromHeirarchy(tsBuff + "/USE-EXTRA-OPTIONS-ONLY",tsTmp,true); 
	if(tsTmp.ToUpper().Trim() == "TRUE")
	{
		SendMessage(GetDlgItem(hChildWnd,IDC_CHK_USEONLYEXTRA),BM_SETCHECK,1,0L);
	}
	else
	{
		SendMessage(GetDlgItem(hChildWnd,IDC_CHK_USEONLYEXTRA),BM_SETCHECK,0,0L);
	}
	return true;
}

bool CChildWindow::IsProfileExists(CTString tsProfile)
{
	HWND hListBox = GetDlgItem(GetParent(hChildWnd),IDC_LST_PROFILES);  
	if(!hListBox) return false;
	return SendMessage(hListBox,LB_FINDSTRING,-1,(DWORD)(TCHAR*)tsProfile) != LB_ERR;   
}

LRESULT CALLBACK CChildWindow::WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{

	int wmId, wmEvent;
	
	switch (message) 
	{
		case WM_INITDIALOG:
			return 1;
		
		case WM_CLOSE:
			DestroyWindow(hWnd),CChildWindow::hChildWnd = 0;
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
				case IDC_BTN_OK:  
				case IDC_BTN_APPLY:
				{
					CTString tsBuff = GetText(IDC_TXT_PROFILENAME),tsTmp; 
					if(tsBuff.IsEmpty()) 
					{
						CWindowUtility::PromptUser("Invalid Profile Name!",hWnd);
						break;
					}
					CXmlUtility oXmlUtil;
					if(!OpenXml(oXmlUtil))
					{
							CWindowUtility::PromptUser("Cannot Open/Create Configuration XML file!",hWnd);
							break;
					}
					if(!mbCalledForEdit) 
					{
						if(IsProfileExists(tsBuff.ToUpper()))
						{
							CWindowUtility::PromptUser("Profile Name already exists, Please try another!",hWnd);
							break;
						}
					}
					else
					{
						if(mtsItemToEdit.ToUpper() != tsBuff.ToUpper())
						{
							CWindowUtility::PromptUser("You cannot change Profile Name while editing!",hWnd);
							break;
						}
						tsBuff = mtsItemToEdit;
					}
					tsBuff = tsBuff.ToUpper();  
					oXmlUtil.RemoveNodes("PROFILES/" + tsBuff);  					
					oXmlUtil.SetForceCreate(true); 
					tsBuff = "PROFILES/" + tsBuff;
					tsTmp = GetText(IDC_TXT_SCRIPTFILE);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/SCRIPT",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_DUMPFOLDER);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/DUMP-FOLDER",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_TEMPLATEFILE);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/TEMPLATE-FILE",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_USERNAME);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/USER-NAME",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_PASSWORD);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/PASSWORD",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_DBNAME);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/DATABASE",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_EXTRAOPT);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/EXTRA-OPTIONS",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_SCHHOUR);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/SCHEDULE-HOUR",tsTmp,true,true); 
					tsTmp = GetText(IDC_TXT_SCHMIN);  
					oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/SCHEDULE-MIN",tsTmp,true,true); 
					if(SendMessage(GetDlgItem(hWnd,IDC_CHK_USEONLYEXTRA),BM_GETCHECK,0,0L))
					{
						oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/USE-EXTRA-OPTIONS-ONLY","TRUE",true,true); 
					}
					else
					{
						oXmlUtil.SetTextIntoHeirarchy(tsBuff + "/USE-EXTRA-OPTIONS-ONLY","FALSE",true,true); 
					}
					if(!mbCalledForEdit) SendMessage(GetParent(hWnd),WM_LBUTTONDBLCLK,0,WM_LBUTTONDBLCLK);    
					if(wmId == IDC_BTN_OK) SendMessage(hWnd,WM_CLOSE,0,0); 
				}
				return 1;

				case IDC_BTN_BRSESCRIPT:
				{
					CTString tsBuff((ULONG)3000,true);
					if(CWindowUtility::OpenFile(hWnd,(TCHAR*)tsBuff,3000))
						SetDlgItemText(hWnd,IDC_TXT_SCRIPTFILE,(TCHAR*)tsBuff);  
				}
				break;
				
				case IDC_BTN_BRSESDUMPFOLDER:
				{
					CTString tsBuff;
					if(CWindowUtility::GetFolderName("Dump Folder",tsBuff,hWnd))  
						SetDlgItemText(hWnd,IDC_TXT_DUMPFOLDER,(TCHAR*)tsBuff);  
				}
				break;

				case IDC_BTN_CANCEL: 
					SendMessage(hWnd,WM_CLOSE,0,0); return 1;
				
				default:
					return 0;
			}
			return 1;

		case WM_PAINT: break;

		default: return 0;
	}
	return 0;
}