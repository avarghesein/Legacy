
#pragma once

#include "stdafx.h"

#include "Xecutor.h"
#include "include.h"
#include "BytesAndTString.h"
#include "MailSlotAbstract.h"
#include "MailSlotReader.h"
#include "MailSlotWriter.h"
#include "Interfaces.h"
#include "NTService.h"
#include "WindowUtility.h"
#include "Pipe.h"
#include "ConsoleProcess.h"
#include "Time.h"
#include "ConsoleProcessScheduler.h"
#include "CommandLineProvider.h"
#include "StdOutToFile.h"
#include "MAILSLOT-MESSAGES.h"
#include "MailServer.h"
#include "MailClient.h"
#include "MainWindow.h"
#include "Functions.h"


/* -i/-I : Install the service 
   -u/-U : Uninstall the service
   -s/-S : Start the service
   -p/-P : Pause/Stop the service
   -r/-R : Run the process (No Service)
*/

int APIENTRY _tWinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,LPTSTR lpCmdLine,int nCmdShow)
{
	CreateThread(0,0,&LaunchApplications,0,0,0); 
	moServer.Start();  
	/*CMailSlotWriter mw;
	CMailSlotReader mr;
	CTString text;
	
	bool b;

	b = mr.Connect("XX"); 
	text = CTString::GetLastErrorString() ;
	b = mw.Connect("XX");
	b = mw.Write("Hai"); 
	b = mr.Read(text);*/

	CTString tsCmdLine(lpCmdLine);
	eCalledFor = ParseCommandLine(tsCmdLine);

	LogEvent("Start Application \nParameter Passed : " + tsCmdLine);  
	
	CNTService::SetServiceName(SERVICE_NAME);  
	CNTService::ServiceErrorEvent += (LogServiceEvent)LogError;  
	CNTService::ServiceNotifyEvent += (LogServiceEvent)LogEvent;  
	CNTService::PostRunEvent += (ServiceEvent)PostRun; 
	CNTService::PreRunEvent += (ServiceEvent)PreRun;  
	CNTService::RunEvent += (ServiceEvent)Run; 
	CNTService::ServiceContinueRequestEvent += (ServiceEvent)ContinueService;  
	CNTService::ServicePauseRequestEvent += (ServiceEvent)PauseService;  
	CNTService::ServiceShutDownRequestEvent += (ServiceEvent)ShutDownService;
	CNTService::ServiceStopRequestEvent += (ServiceEvent)StopService;
	switch(eCalledFor)
	{
		case InstallingTheService : return MainReturn(InstallService());
		case StartingTheService : return MainReturn(StartService()); 
		case StoppingTheService : return MainReturn(StopService());  
		case ByOSForRunAsService  : return MainReturn(RunService());
		case ByServiceForRunAsProcess : return MainReturn(RunProcess(hInstance,hPrevInstance,nCmdShow));
		case UnInstallingTheService : return MainReturn(UnInstallService());

		case UnKnown : 
		default: return MainReturn(UnKnownCall());
	}
}

