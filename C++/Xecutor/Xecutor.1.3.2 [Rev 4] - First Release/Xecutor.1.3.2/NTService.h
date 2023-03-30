
#pragma once

#include ".\NTServiceUtility.h"

class CNTService 
{
	private:
		static long m_lSleepInterval;
		static CTString m_tsServiceName;
		static SERVICE_STATUS m_serviceStatus;
		static SERVICE_STATUS_HANDLE m_hStatus;
		static ENTServiceStatus m_eServiceStatus;

	public:
		static CServiceLogDelegate ServiceErrorEvent;
		static CServiceLogDelegate ServiceNotifyEvent;
		static CServiceEventDelegate PreRunEvent;
		static CServiceEventDelegate RunEvent;
		static CServiceEventDelegate PostRunEvent;
		static CServiceEventDelegate ServiceContinueRequestEvent;
		static CServiceEventDelegate ServicePauseRequestEvent;
		static CServiceEventDelegate ServiceStopRequestEvent;
		static CServiceEventDelegate ServiceShutDownRequestEvent;

	private:
		static int  GetServiceManager(SC_HANDLE &rschSCManager);
		static int  LogError(CTString tsError);
		static int  LogEvent(CTString tsEvent);
		static void ServiceMain(int argc, char** argv);
		static void ServiceControlHandler(DWORD request);

	public:
		static void SetServiceName(CTString tsServiceName);
		static int  Install(CTString tsExecutablePath);
		static int  UnInstall(void);
		static int  Stop(void);
		static int  Start(void);
		static int  Run(long lSleepInterval);
};

long CNTService::m_lSleepInterval = 0;
CTString CNTService::m_tsServiceName;
SERVICE_STATUS CNTService::m_serviceStatus;
SERVICE_STATUS_HANDLE CNTService::m_hStatus;
ENTServiceStatus CNTService::m_eServiceStatus;

CServiceLogDelegate CNTService::ServiceErrorEvent;
CServiceLogDelegate CNTService::ServiceNotifyEvent;
CServiceEventDelegate CNTService::PreRunEvent;
CServiceEventDelegate CNTService::RunEvent;
CServiceEventDelegate CNTService::PostRunEvent;
CServiceEventDelegate CNTService::ServiceContinueRequestEvent;
CServiceEventDelegate CNTService::ServicePauseRequestEvent;
CServiceEventDelegate CNTService::ServiceStopRequestEvent;
CServiceEventDelegate CNTService::ServiceShutDownRequestEvent;

void CNTService::SetServiceName(CTString tsServiceName)
{
	m_tsServiceName = tsServiceName;
}

int CNTService::LogError(CTString tsError)
{
	return ServiceErrorEvent(tsError);
}

int CNTService::LogEvent(CTString tsEvent)
{
	return ServiceNotifyEvent(tsEvent); 
}

int CNTService::GetServiceManager(SC_HANDLE &rschSCManager)
{
	rschSCManager = OpenSCManager(/*Local Machine*/NULL,/*ServicesActive database*/NULL,/*full access rights*/SC_MANAGER_ALL_ACCESS);  
	if(!rschSCManager) 
	{
		CNTService::LogError("Opening Service Manager Failed!");
		return 0;
	}
	CNTService::LogEvent("Opening Service Manager OK!");
	return 1;
}

int CNTService::Install(CTString tsExecutablePath)
{
	SC_HANDLE schSCManager,schService;

	CNTService::LogEvent((CTString)"Begin Install Service!" + "Opening Service Manager for Installing the Service!");
	if(!CNTService::GetServiceManager(schSCManager)) return 0;

	schService = CreateService(schSCManager,CNTService::m_tsServiceName,CNTService::m_tsServiceName,
			     SERVICE_ALL_ACCESS,SERVICE_WIN32_OWN_PROCESS|SERVICE_INTERACTIVE_PROCESS ,SERVICE_DEMAND_START, 
				 SERVICE_ERROR_NORMAL,tsExecutablePath,0,0,0,0,0);  

	if(!schService) 
	{
		CNTService::LogError("Creating Service Failed!");
		return 0;
	}
	CNTService::LogEvent("Creating Service OK!");
	if(!StartService(schService,0,0)) 
	{
		CloseServiceHandle(schService); 
		CNTService::LogError("Starting Service Failed!");
		return 0;
	}
	CNTService::LogEvent((CTString)"Starting Service OK!" + "Service Installed and Started!"); 
	return 1;
}

int CNTService::UnInstall(void)
{
	SC_HANDLE schSCManager,schService;

	CNTService::LogEvent("Opening Service Manager for UnInstalling the Service!");
	if(!CNTService::GetServiceManager(schSCManager)) return 0;

	if(schService = OpenService(schSCManager,CNTService::m_tsServiceName,DELETE),!schService) 
	{
		LogError("Opening Service for Uninstall Failed!");
		return 0;
	}
	CNTService::LogEvent("Opening Service for Uninstall OK!");
	
	SERVICE_STATUS hTmpStat;
	ControlService(schService,SERVICE_CONTROL_STOP,&hTmpStat);
	SleepEx(1000,1);
	if(!DeleteService(schService)) 
	{
		CloseServiceHandle(schService); 
		CNTService::LogError("UnInstalling the Service Failed!");
		return 0;
	}
	CNTService::LogEvent("UnInstalling the Service OK!");	
	return 1;
}

int CNTService::Stop(void)
{
	SC_HANDLE schSCManager,schService;
	SERVICE_STATUS hTmpStat;

	CNTService::LogEvent((CTString)"Begin Stop Service!" + "Opening Service Manager for Stopping the Service!");
	if(!CNTService::GetServiceManager(schSCManager)) return 0;
	schService = OpenService(schSCManager,CNTService::m_tsServiceName,SC_MANAGER_ALL_ACCESS); 
	
	if(!schService) 
	{
		CNTService::LogError("Opening Service Failed!");
		return 0;
	}
	CNTService::LogEvent("Opening Service OK!");

	if(!ControlService(schService,SERVICE_CONTROL_STOP,&hTmpStat)) 
	{
		CloseServiceHandle(schService); 
		CNTService::LogError("Stopping Service Failed!");
		return 0;
	}
	CNTService::LogEvent("Stopping Service OK!"); 
	return 1; 
}

int CNTService::Start(void)
{
	SC_HANDLE schSCManager,schService;

	CNTService::LogEvent((CTString)"Begin Start Service!" + "Opening Service Manager for Starting the Service!");
	if(!CNTService::GetServiceManager(schSCManager)) return 0;
	schService = OpenService(schSCManager,CNTService::m_tsServiceName,SC_MANAGER_ALL_ACCESS); 
	
	if(!schService) 
	{
		CNTService::LogError("Opening Service Failed!");
		return 0;
	}
	CNTService::LogEvent("Opening Service OK!");

	if(!StartService(schService,0,0)) 
	{
		CloseServiceHandle(schService); 
		CNTService::LogError("Starting Service Failed!");
		return 0;
	}
	CNTService::LogEvent("Starting Service OK!"); 
	return 1; 
}

int CNTService::Run(long lSleepInterval)
{
	CNTService::m_lSleepInterval = lSleepInterval;

	SERVICE_TABLE_ENTRY ServiceTable[2];

	CNTService::LogEvent("Creating Servicer Table!");

	ServiceTable[0].lpServiceName = m_tsServiceName;
	ServiceTable[0].lpServiceProc = (LPSERVICE_MAIN_FUNCTION)(CNTService::ServiceMain);
	ServiceTable[1].lpServiceName = NULL;
	ServiceTable[1].lpServiceProc = NULL;

	CNTService::LogEvent("Calling Dispatcher and inturn calling Servicer Main(...)!");
	
	return (int)StartServiceCtrlDispatcher(ServiceTable); 
}

void CNTService::ServiceMain(int argc, char** argv) 
{  
   CNTService::m_serviceStatus.dwServiceType = SERVICE_WIN32; 
   CNTService::m_serviceStatus.dwCurrentState = SERVICE_START_PENDING; 
   CNTService::m_serviceStatus.dwControlsAccepted   = SERVICE_ACCEPT_STOP | SERVICE_ACCEPT_SHUTDOWN | SERVICE_ACCEPT_PAUSE_CONTINUE;
   CNTService::m_serviceStatus.dwWin32ExitCode = 0; 
   CNTService::m_serviceStatus.dwServiceSpecificExitCode = 0; 
   CNTService::m_serviceStatus.dwCheckPoint = 0; 
   CNTService::m_serviceStatus.dwWaitHint = 0; 

   CNTService::m_eServiceStatus = StartPending;  
 
   PreRunEvent(CNTService::m_eServiceStatus);

   LogEvent("Registering Service begin!"); 

   LPHANDLER_FUNCTION controlHandler = (LPHANDLER_FUNCTION)&CNTService::ServiceControlHandler;
   CNTService::m_hStatus = RegisterServiceCtrlHandler(CNTService::m_tsServiceName,controlHandler); 

   if (CNTService::m_hStatus == (SERVICE_STATUS_HANDLE)0) 
   {
	   CNTService::LogError("Registering Service failed!");
	   return;
   }
   CNTService::LogEvent("Registering Service OK!"); 
  
   CNTService::m_serviceStatus.dwCurrentState = SERVICE_RUNNING; 
   SetServiceStatus(CNTService::m_hStatus, &CNTService::m_serviceStatus);

   CNTService::m_eServiceStatus = Running; 

    PreRunEvent(CNTService::m_eServiceStatus);
	while(CNTService::m_serviceStatus.dwCurrentState != SERVICE_STOPPED)
	{
		RunEvent(CNTService::m_eServiceStatus);
		SleepEx(CNTService::m_lSleepInterval,1);
	}	  
	PostRunEvent(CNTService::m_eServiceStatus);

	CNTService::LogEvent("Exit Service Main!");
	return;
}

void CNTService::ServiceControlHandler(DWORD request) 
{ 
   CNTService::m_serviceStatus.dwWin32ExitCode = 0; 
   switch(request) 
   { 
	  case SERVICE_CONTROL_CONTINUE : 
		  if(!ServiceContinueRequestEvent(m_eServiceStatus)) break;
		  CNTService::LogEvent("Service Continued!");
		  CNTService::m_serviceStatus.dwCurrentState = SERVICE_RUNNING; 
		  CNTService::m_eServiceStatus = Running;
		  break;

	  case SERVICE_CONTROL_PAUSE : 
		  if(!ServicePauseRequestEvent(m_eServiceStatus)) break;
		  CNTService::LogEvent("Service Paused!");
		  CNTService::m_serviceStatus.dwCurrentState = SERVICE_PAUSED; 
		  CNTService::m_eServiceStatus = Paused; 
		  break;

      case SERVICE_CONTROL_STOP: 
		 if(!ServiceStopRequestEvent(m_eServiceStatus)) break;
         CNTService::LogEvent("Service stopped!");
         CNTService::m_serviceStatus.dwCurrentState = SERVICE_STOPPED; 
		 CNTService::m_eServiceStatus = Stopped;  
         break; 
 
      case SERVICE_CONTROL_SHUTDOWN: 
	     if(!ServiceShutDownRequestEvent(m_eServiceStatus)) break;
         CNTService::LogEvent("Service Shutdown!");
         CNTService::m_serviceStatus.dwCurrentState = SERVICE_STOPPED; 
		 CNTService::m_eServiceStatus = ShutDowned; 
         break; 
        
      default:
		 CNTService::m_serviceStatus.dwCurrentState = SERVICE_RUNNING;
		 CNTService::m_eServiceStatus = Running;  
         break;
    } 
    SetServiceStatus (CNTService::m_hStatus, &CNTService::m_serviceStatus); 
    return; 
}