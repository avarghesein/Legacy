
#pragma once

#include <Shlobj.h>
#include <Shellapi.h>

#define DEFAULT_WINDOW_STATION "WinSta0"
#define DEFAULT_DESKTOP "Default"
#define PROCESS_DESKTOP "WinSta0/Default" 

typedef DWORD (_stdcall *GenericCall) (HMODULE,LPTSTR,DWORD);

class CWindowUtility
{
	private:
		static DWORD dwGuiThreadId; 
		static DWORD dwThreadId; 
		static HWINSTA hwinstaSave; 
		static HDESK hdeskSave; 
		static HWINSTA hwinstaUser; 
		static HDESK hdeskUser; 

	public:
		static int AcquireDeskTop(LPSTR lpszWindowStation = DEFAULT_WINDOW_STATION,LPSTR lpszDesktop = DEFAULT_DESKTOP);
		static int ReleaseDeskTop(void);
		static int GetUserConfirmation(LPTSTR sCaption,LPTSTR sPrompt,HWND hParent = 0);
		static int GetUserConfirmation(LPTSTR sPrompt,HWND hParent = 0);
		static void PromptUser(LPTSTR sCaption,LPTSTR sPrompt,HWND hParent = 0);
		static void PromptUser(LPTSTR sPrompt,HWND hParent = 0);
		static int GetExeName(CTString &tsExeName,int bPathOnly);
		static int GetExecutableName(CTString &ExePathWithName);
		static int GetExecutablePath(CTString &ExePath);
		static int OpenFile(HWND hwnd,char *szFile,int Size);		
		static int GetFolderName(CTString Caption,CTString &lpszFolderName,HWND hWnd);
		static CTString GetText(HWND hWnd,int iTxtBoxID);
		static void SetText(HWND hWnd,int iTxtBoxID,CTString tsStr);
		static bool ShowWaitCursor(void);
		static bool ShowDefaultCursor(void);
};

DWORD CWindowUtility::dwGuiThreadId = 0; 
DWORD CWindowUtility::dwThreadId; 
HWINSTA CWindowUtility::hwinstaSave; 
HDESK CWindowUtility::hdeskSave; 
HWINSTA CWindowUtility::hwinstaUser; 
HDESK CWindowUtility::hdeskUser; 

int CWindowUtility::AcquireDeskTop(LPSTR lpszWindowStation,LPSTR lpszDesktop)
{
	CWindowUtility::hwinstaSave = GetProcessWindowStation(); 
	CWindowUtility::dwThreadId = GetCurrentThreadId(); 
	CWindowUtility::hdeskSave = GetThreadDesktop(dwThreadId); 
	CWindowUtility::hwinstaUser = OpenWindowStation(lpszWindowStation, FALSE, MAXIMUM_ALLOWED); 
	if (!CWindowUtility::hwinstaUser) return 0;
	SetProcessWindowStation(CWindowUtility::hwinstaUser); 
	CWindowUtility::hdeskUser = OpenDesktop(lpszDesktop, 0, FALSE, MAXIMUM_ALLOWED); 
	if (!CWindowUtility::hdeskUser) 
    { 
		SetProcessWindowStation(CWindowUtility::hwinstaSave); 
		CloseWindowStation(CWindowUtility::hwinstaUser); 
        return 0; 
    } 
	SetThreadDesktop(CWindowUtility::hdeskUser);  
	CWindowUtility::dwGuiThreadId = dwThreadId; 
    dwGuiThreadId = 0; 
	return 1;
}

int CWindowUtility::ReleaseDeskTop(void)
{
	SetThreadDesktop(CWindowUtility::hdeskSave); 
	SetProcessWindowStation(CWindowUtility::hwinstaSave); 
	CloseDesktop(CWindowUtility::hdeskUser); 
	CloseWindowStation(CWindowUtility::hwinstaUser); 
	return 1;
}

void CWindowUtility::SetText(HWND hWnd,int iTxtBoxID,CTString tsStr)
{
	SetDlgItemText(hWnd,iTxtBoxID,tsStr); 
}

CTString CWindowUtility::GetText(HWND hWnd,int iTxtBoxID)
{
	HWND hChldWnd = GetDlgItem(hWnd,iTxtBoxID);
	int iLen = GetWindowTextLength(hChldWnd); 
	CTString tsBuff((ULONG)++iLen,true),tsRet;
	if(GetDlgItemText(hWnd,iTxtBoxID,(TCHAR*)tsBuff,iLen) > 0) tsRet = tsBuff;
	return tsRet;
}

int CWindowUtility::GetUserConfirmation(LPTSTR sPrompt,HWND hParent)
{
	return CWindowUtility::GetUserConfirmation("Confirm!",sPrompt,hParent);
}

int CWindowUtility::GetUserConfirmation(LPTSTR sCaption,LPTSTR sPrompt,HWND hParent)
{
	return MessageBox(hParent,sPrompt,sCaption,MB_YESNO | MB_ICONQUESTION) == IDYES;  
}

void CWindowUtility::PromptUser(LPTSTR sCaption,LPTSTR sPrompt,HWND hParent)
{
	MessageBox(hParent,sPrompt,sCaption,MB_OK | MB_ICONWARNING);
}

void CWindowUtility::PromptUser(LPTSTR sPrompt,HWND hParent)
{
	CWindowUtility::PromptUser("Warning!",sPrompt,hParent);
}

int CWindowUtility::GetExeName(CTString &tsExeName,int bPathOnly)
{
	UINT uintLen=0;
	TCHAR tchrExeFileName[1500];
	GenericCall oCall;

	try
	{  
		tsExeName.Clear(); 
		oCall = &GetModuleFileName;
		oCall(0,(LPTSTR)tchrExeFileName,1500);
		if(bPathOnly) 
			while(tchrExeFileName[_tcslen(tchrExeFileName) - 1] != '\\') 
				tchrExeFileName[_tcslen(tchrExeFileName) - 1] = '\0';

		tsExeName = tchrExeFileName;
		return 1;
	}
	catch(...) { tsExeName.Clear(); }
	return 0;
}

int CWindowUtility::OpenFile(HWND hwnd,char *szFile,int Size)
{
	OPENFILENAME ofn;       // common dialog box structure

	// Initialize OPENFILENAME
	ZeroMemory(&ofn, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrFile = szFile;
	//
	// Set lpstrFile[0] to '\0' so that GetOpenFileName does not 
	// use the contents of szFile to initialize itself.
	//
	ofn.lpstrFile[0] = '\0';
	ofn.nMaxFile = Size;
	ofn.lpstrFilter = "All\0*.*\0Text\0*.TXT\0";
	ofn.nFilterIndex = 1;
	ofn.lpstrFileTitle = NULL;
	ofn.nMaxFileTitle = 0;
	ofn.lpstrInitialDir = NULL;
	ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;

	// Display the Open dialog box. 

	if (GetOpenFileName(&ofn)) return 1;
	return 0;
}

int CWindowUtility::GetFolderName(CTString Caption,CTString &lpszFolderName,HWND hWnd)
{
	LPMALLOC pMalloc;

	lpszFolderName = EMPTY_TSTRING;
	if (SUCCEEDED(::SHGetMalloc(&pMalloc))) 
	{
		BROWSEINFO	 BrowseInfo;
		LPITEMIDLIST lpItemIdList;
		TCHAR		 szFolderName[MAX_PATH];
		TCHAR		 szDisplayName[MAX_PATH];
		//TCHAR        *szCaption=new TCHAR[Caption.Length() + 1];
		
		//try {_tcscpy(szCaption,Caption); } catch(...) { szCaption[0]='\0'; }

		szDisplayName[0] = '\0';
		szFolderName[0]  = '\0';
		::ZeroMemory(&BrowseInfo, sizeof(BrowseInfo));

		BrowseInfo.hwndOwner	  = hWnd;
		BrowseInfo.pidlRoot		  = NULL;
		BrowseInfo.pszDisplayName = szDisplayName;
		BrowseInfo.lpszTitle	  = (TCHAR*)Caption;
		BrowseInfo.ulFlags		  = BIF_EDITBOX | BIF_VALIDATE;
		BrowseInfo.lParam		  = NULL;
		BrowseInfo.iImage		  = 0;

		if ((lpItemIdList = SHBrowseForFolder(&BrowseInfo)) != NULL)
		{
			if (SHGetPathFromIDList(lpItemIdList,(LPTSTR)szFolderName))
			{
				pMalloc->Free(lpItemIdList);
				pMalloc->Release();
				if (_tcslen(szFolderName))
				{
					lpszFolderName = szFolderName;
					return 1;
				}
			}
		}			
		return 0;
	}
	return 0;
}

int CWindowUtility::GetExecutableName(CTString &ExePathWithName)
{
	return GetExeName(ExePathWithName,0);
}

int CWindowUtility::GetExecutablePath(CTString &ExePath)
{
	return GetExeName(ExePath,1);
}

bool CWindowUtility::ShowWaitCursor(void)
{
	SetCursor(LoadCursor(0,IDC_WAIT));   
	return true;
}

bool CWindowUtility::ShowDefaultCursor(void)
{
	SetCursor(LoadCursor(0,IDC_ARROW));   
	return true;
}