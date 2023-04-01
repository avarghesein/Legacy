
#include "stdafx.h"
#include "MPlusVersionSelector.h"
#include "CommandRunner.h"
#include "Logger.h"

bool CCommandRunner::Run( CScriptEngine& ScriptEngine, CString& CommandLine, bool WaitForCompletion )
{
    CString csCurDir;
    GetCurrentDirectory( csCurDir );

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

    CommandLine = T( "\"cmd.exe\" /C " ) + CommandLine;

    LOG( CSTR( "Command:" ) + CommandLine );
    LOG( CSTR( "WORKING DIR| " ) + csCurDir );

    if( !ScriptEngine.m_bSimulationMode )
    {        // Start the child process. 
        if( !CreateProcess(
            0,   // No module name (use command line). 
            CommandLine.GetBuffer( CommandLine.GetLength()), // Command line. 
            0,             // Process handle not inheritable. 
            0,             // Thread handle not inheritable. 
            FALSE,            // Set handle inheritance to FALSE. 
            CREATE_NEW_CONSOLE | CREATE_NEW_PROCESS_GROUP, //NORMAL_PRIORITY_CLASS,                // No creation flags. 
            NULL,             // Use parent's environment block. 
            csCurDir,             // Use parent's starting directory. 
            &si,              // Pointer to STARTUPINFO structure.
            &pi )             // Pointer to PROCESS_INFORMATION structure.
        ) 
        {
            return true;
        }
        if( WaitForCompletion )
        {
            WaitForSingleObject( pi.hProcess, INFINITE );
        }
        CloseHandle( pi.hProcess );
    }
    return true;    
}

bool CCommandRunner::Wait( CString& Msg )
{
    CLogger::ExitInstance();

	CString csMsg( Msg );
	csMsg.TrimLeft();
	csMsg.TrimRight();
	if( csMsg.IsEmpty())
	{
		csMsg = T( "Waiting!!! Press Any Key to execute next step...");
	}
	csMsg = T( "\n\n" ) + csMsg;
	
    ConsoleOut << csMsg.operator LPCTSTR();
    ConsoleOut.flush();
    int i = getch();
    return true;
}

bool CCommandRunner::SetCurrentDirectory( CString& Path )
{
    return TRUE == ::SetCurrentDirectory( Path );
}

bool CCommandRunner::GetCurrentDirectory( CString& Path )
{
    DWORD dwBufLen = 0;
    dwBufLen = ::GetCurrentDirectory( 0, 0 );
    TCHAR* pszBuff = new TCHAR[ ++dwBufLen ];
    ::GetCurrentDirectory( dwBufLen, pszBuff );
    Path = pszBuff;
    delete[] pszBuff;
    return true;
}

bool CCommandRunner::SetEnvironment( CScriptEngine& ScriptEngine )
{
    POSITION pos = ScriptEngine.m_EnvVariables.GetStartPosition();
    if( !pos ) return true;
    
    CRegKey RegKey;

    if( !ScriptEngine.m_bSimulationMode )
    {
        bool bSuccess = ERROR_SUCCESS == RegKey.Create(  HKEY_LOCAL_MACHINE,
												    T( "SYSTEM\\ControlSet001\\Control\\Session Manager\\Environment" ));
        if( !bSuccess ) return false;
    }
    

    while( pos )
    {
        CString csKey;
        KeyValueDefn_t VarVal;
        ScriptEngine.m_EnvVariables.GetNextAssoc( pos, csKey, VarVal );

        CString csPrevValue;
        ScriptEngine.LookupProcessEnvVar( csKey, csPrevValue , false );
        
        LOG( CSTR( "Previous:" ) + VarVal.VAR + T( "=" ) + csPrevValue );
        if( !ScriptEngine.m_bSimulationMode )
        {
            if( VarVal.IS_SET )
            {
                if( ERROR_SUCCESS != RegKey.SetValue( VarVal.VAL, VarVal.VAR ))
                {
                    RegKey.Close();
                    return false;
                }
            }
            else
            {
                RegKey.DeleteValue( VarVal.VAR );
            }
        }
        if( VarVal.IS_SET )
        {
            if( !SetEnvironmentVariable( VarVal.VAR, VarVal.VAL ))
            {
                if( !ScriptEngine.m_bSimulationMode ) RegKey.Close();
                return false;
            }
            LOG( CSTR( "Updated:" ) + VarVal.VAR + T( "=" ) + VarVal.VAL );
            LOG_STDOUT( CSTR( "SETTING:" ) + VarVal.VAR + T( "=" ) + VarVal.VAL );
        }
        else
        {
            SetEnvironmentVariable( VarVal.VAR, 0 );
            LOG( CSTR( "DELETED:" ) + VarVal.VAR );
            LOG_STDOUT( CSTR( "DELETED:" ) + VarVal.VAR );
        }        
    }
    if( !ScriptEngine.m_bSimulationMode ) RegKey.Close();
    DWORD dwRes;
    ::SendMessageTimeout( HWND_BROADCAST, WM_SETTINGCHANGE , 0, (LPARAM)T("Environment"), SMTO_NORMAL , 7000, &dwRes );
    ScriptEngine.m_EnvVariables.RemoveAll();
    return true;    
}

bool CCommandRunner::SetRegistry( CScriptEngine& ScriptEngine )
{
	POSITION pos = ScriptEngine.m_RegVariables.GetStartPosition();
    if( !pos ) return true;
	while( pos )
	{
		CString csRegKey;
		RegKeyValueDefn_t NameValueCollection;
		ScriptEngine.m_RegVariables.GetNextAssoc( pos, csRegKey, NameValueCollection );

		CString csRoot, csSubKey;
		int nSlashIdx = csRegKey.FindOneOf(T( "/\\"));
		if( nSlashIdx >= 0 )
		{
			csRoot = csRegKey.Left( nSlashIdx );
			csSubKey = csRegKey.Mid( nSlashIdx + 1 );
		}
		
		HKEY hRoot = HKEY_CURRENT_USER;
		if( !ScriptEngine.FindRegistryRoot( csRoot, hRoot )) return false;
		
		CRegKey RegKey;

        if( !ScriptEngine.m_bSimulationMode )
        {
		    if( NameValueCollection.IS_SET )
		    {
			    if( ERROR_SUCCESS != RegKey.Create( hRoot, csSubKey )) return false;
		    }
		    else
		    {
			    if( ERROR_SUCCESS != RegKey.Open( hRoot, csSubKey )) return false;
		    }
        }
        LOG( CSTR( "ROOT  KEY:" ) + NameValueCollection.KEY_PATH );

		bool bAtleastOneNameVal = false;
		POSITION posVars = NameValueCollection.VALUE_NAMES.GetStartPosition();		
		while( posVars )
		{
			CString csValueName;
			KeyValueDefn_t NameValuePair;
			NameValueCollection.VALUE_NAMES.GetNextAssoc( posVars, csValueName, NameValuePair );
			
			CString csPrevValue;
			ScriptEngine.FindRegKeyValueName( csRegKey, NameValuePair.VAR, csPrevValue, false );
            LOG( CSTR( "Previous:" ) + NameValuePair.VAR + T( "=" ) + csPrevValue );

            if( !ScriptEngine.m_bSimulationMode )
            {
			    if( NameValuePair.IS_SET )
			    {
				    if( ERROR_SUCCESS != RegKey.SetValue( NameValuePair.VAL, NameValuePair.VAR )) return false;
			    }
			    else
			    {
				    RegKey.DeleteValue( NameValuePair.VAR );
			    }
            }
            if( NameValuePair.IS_SET )
            {
                LOG( CSTR( "Updated:" ) + NameValuePair.VAR + T( "=" ) + NameValuePair.VAL );
                LOG_STDOUT( CSTR( "SETTING:" ) + NameValuePair.VAR + T( "=" ) + NameValuePair.VAL );
            }
            else
            {
                LOG( CSTR( "DELETED:" ) + NameValuePair.VAR );
                LOG_STDOUT( CSTR( "DELETED:" ) + NameValuePair.VAR );
            }            
			bAtleastOneNameVal = true;
		}
		if( !bAtleastOneNameVal && !NameValueCollection.IS_SET )
		{
			RegKey.Close();
			CString csSubParentKey, csKeyToDelete;
			nSlashIdx = csSubKey.ReverseFind( T( '\\' ));
			if( nSlashIdx < 0 ) nSlashIdx = csSubKey.ReverseFind( T( '/' ));
			if( nSlashIdx >= 0 )
			{
				csSubParentKey = csSubKey.Left( nSlashIdx );
				csKeyToDelete = csSubKey.Mid( nSlashIdx + 1 );
			}
            if( !ScriptEngine.m_bSimulationMode )
            {
			    if( ERROR_SUCCESS == RegKey.Open( hRoot, csSubParentKey ))
                {
			        RegKey.DeleteSubKey( csKeyToDelete );
			        RegKey.Close();
                }
            }
            LOG( CSTR( "DELETED ROOT KEY:" ) + NameValueCollection.KEY_PATH );
            LOG_STDOUT( CSTR( "DELETED ROOT KEY:" ) + NameValueCollection.KEY_PATH );
		}
		else
		{
			if( !ScriptEngine.m_bSimulationMode ) RegKey.Close();
		}
		NameValueCollection.VALUE_NAMES.RemoveAll();
	}
	ScriptEngine.m_RegVariables.RemoveAll();
	return true;
}