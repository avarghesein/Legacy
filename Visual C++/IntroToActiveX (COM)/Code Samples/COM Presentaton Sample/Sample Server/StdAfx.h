 // stdafx.h : include file for standard system include files,
//      or project specific include files that are used frequently,
//      but are changed infrequently

#if !defined(AFX_STDAFX_H__9E826DA9_6EE6_4462_8FDB_E4BCB38F787B__INCLUDED_)
#define AFX_STDAFX_H__9E826DA9_6EE6_4462_8FDB_E4BCB38F787B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define STRICT
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0400
#endif
#define _ATL_FREE_THREADED
#include <afxwin.h>
#include <atlbase.h>
#include <afxtempl.h>
//You may derive a class from CComModule and use it if you want to override
//something, but do not change the name of _Module

#ifdef BUILD_AS_SERVICE

class CServiceModule : public CComModule
{
public:
	HRESULT RegisterServer(BOOL bRegTypeLib, BOOL bService);
	HRESULT UnregisterServer();
	void Init(_ATL_OBJMAP_ENTRY* p, HINSTANCE h, UINT nServiceNameID, const GUID* plibid = NULL);
    void Start();
	void ServiceMain(DWORD dwArgc, LPTSTR* lpszArgv);
    void Handler(DWORD dwOpcode);
    void Run();
    BOOL IsInstalled();
    BOOL Install();
    BOOL Uninstall();
	LONG Unlock();
	void LogEvent(LPCTSTR pszFormat, ...);
    void SetServiceStatus(DWORD dwState);
    void SetupAsLocalServer();

//Implementation
private:
	static void WINAPI _ServiceMain(DWORD dwArgc, LPTSTR* lpszArgv);
    static void WINAPI _Handler(DWORD dwOpcode);

// data members
public:
    TCHAR m_szServiceName[256];
    SERVICE_STATUS_HANDLE m_hServiceStatus;
    SERVICE_STATUS m_status;
	DWORD dwThreadID;
	BOOL m_bService;
};

extern CServiceModule _Module;
#else
extern CComModule _Module;
#endif

#include <atlcom.h>


#ifdef BUILD_AS_SERVICE
#define REGKEY OLESTR("LocalServer32")
#else
#define REGKEY OLESTR("InprocServer32")
#endif

#undef DECLARE_REGISTRY_RESOURCEID
#define DECLARE_REGISTRY_RESOURCEID DECLARE_REGISTRY_RESOURCEID_CUSTOM

#define DECLARE_REGISTRY_RESOURCEID_CUSTOM(x)\
	static HRESULT WINAPI UpdateRegistry(BOOL bRegister)\
	{\
	static struct _ATL_REGMAP_ENTRY Entry[] = \
		{ { OLESTR("Server32"), REGKEY }, { NULL, NULL } };\
	return _Module.UpdateRegistryFromResource(x, bRegister, Entry);\
} 



//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__9E826DA9_6EE6_4462_8FDB_E4BCB38F787B__INCLUDED)
