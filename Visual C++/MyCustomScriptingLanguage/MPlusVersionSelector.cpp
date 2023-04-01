// MPlusVersionSelector.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "MPlusVersionSelector.h"
#include "VersionCommandLineInfo.h"

#include "ScriptEngine.h"
#include "Logger.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// The one and only application object

CWinApp theApp;

void Pause( void );
void PrintUsage( void );

int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	int nRetCode = 0;

	// initialize MFC and print and error on failure
	if (!AfxWinInit(::GetModuleHandle(NULL), NULL, ::GetCommandLine(), 0))
	{
		//ConsoleErr << T("Fatal Error: MFC initialization failed") << endl;
		nRetCode = 1;
	}
	else
	{
		CVersionCommandLineInfo cmdLineInfo;
		AfxGetApp()->ParseCommandLine( cmdLineInfo );

		if( cmdLineInfo.IsHelpMode() || cmdLineInfo.GetFileName().IsEmpty())
		{
			PrintUsage();
			return 1;
		}

        CLogger::SetVerboseMsgMode( cmdLineInfo.IsVerboseMsg());
        CLogger::Initialize( cmdLineInfo.GetFileName());		
        
        //CLogger::SetVerboseMsgMode( true ); // Remove Here

        CScriptEngine objScriptEngine;
        
        objScriptEngine.SetExecutionMode( cmdLineInfo.IsSimulationMode());

        //objScriptEngine.SetExecutionMode( true );  // Remove Here

        if( !objScriptEngine.ExecuteScriptFile( cmdLineInfo.GetFileName(), cmdLineInfo.GetEnvVars()))
        {
            CLogger::ExitInstance();
            Pause();
            return false;
        }
        CLogger::ExitInstance();	
	}
    CLogger::ExitInstance();
	Pause();
	return nRetCode;
}

void PrintUsage( void )
{	
    ConsoleOut.flush();
	CString csUsage = T( "Usage:\n"); 
	csUsage += theApp.m_pszExeName;
	csUsage += T( " -f {ScriptName} [-s] [-v] [-e {VaribleDefns}]\n\n");
	csUsage += CSTR( "Sample: " ) + theApp.m_pszExeName + T( " -f \"SCRIPTS.txt\" -e \"<SYNGO>=1;VERSION=2\" -s -v\n\n");
	csUsage += T( "-f: File Specifier\n-s: Simulation Mode\n-v: Verbose Msgs to File\n-e: Varible defenitions\n");
	ConsoleOut << csUsage.operator LPCTSTR();
	Pause();
}

void Pause( void )
{
    CLogger::ExitInstance();

    ConsoleOut << T( "\n\nPress Any Character to Exit!!!");
    ConsoleOut.flush();
    int i = getch();
}