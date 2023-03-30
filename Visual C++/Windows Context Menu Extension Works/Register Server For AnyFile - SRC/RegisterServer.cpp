// RegisterServer.cpp : Defines the entry point for the console application.
//

#define _MERGE_RDATA_ 1

#include "stdafx.h"
#include "TCHAR.h"
#include <windows.h>

// Example call to this application
// RegisterServer 1 <Path To the Com exe/dll without quotes>
int main(int argc, char* argv[])
{
    int nLen = 0;
    // Check the first command line arg: 1 means register 0 means unregister
    bool isRegister = argv[1][0] == '1';

    // Combine the path tokens.., If the path contains spaces they are seperate arguments.
    // Join them to get the complete file path.
    for( int i = 2 ; i < argc ; ++i ) nLen += _tcslen( argv[ i ] ) + 1;
    TCHAR *szString = new TCHAR[ nLen + 1 ]; szString[ 0 ] = '\0';
    for( i = 2 ; i < argc ; ++i ) _tcscat(_tcscat( szString , argv [ i ] ) , _T( " " ) );
    int nStrLen = _tcslen( szString );
    // Get rid of the last space we added.
    szString [ --nStrLen ] = _T( '\0' );
    // Find the start position of the file extension.. exe or dll
    for( i = nStrLen - 1; i >= 0; --i ) if( szString[ i ] == '.' ) break;

    // File having no extension. Return error.
    if( i < 0 || i >= nStrLen - 1 ) return 1;
    
    bool isExe = false;
    // Check wether we have an exe file to register
    if( 0 == _tcsicmp( szString + i + 1, _T( "exe" ) ))
    {
        isExe = true;
    }

    TCHAR *cmd = 0;

    if( isExe )
    {
        // Use the -regserver/-unregserver commandline options of the exe for
        // Register or UnRegister
        // Also put the file name in double quotes, so that spaces will not be a problem
        cmd = new TCHAR[ nStrLen + 20 ]; 
        cmd[ 0 ] = '\"', cmd[ 1 ] = '\0';
        _tcscat( _tcscat( cmd, szString ), "\"" );
        _tcscat( _tcscat( cmd , " -" ) , isRegister ? "regserver" : "unregserver" );
    }
    else
    {
        // Use the regsvr32.exe to register/unregister the dll/ocx
        // Use /s for silent operation so that no messagebox will displayed
        // /u is for unregistering, No options in the command line indicates register
        // Also put the file name in double quotes, so that spaces will not be a problem
        cmd = new TCHAR[ nStrLen + 25 ]; 
        cmd[ 0 ] = '\0';
        _tcscat( _tcscat( cmd, "regsvr32 " ), isRegister ? "/s" : "/s /u" );
        _tcscat( _tcscat( _tcscat( cmd , " \"" ) ,  szString ), "\"" );        
    }

    delete[] szString;

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

    // Create the process  that we need, that will do the actual thing 
    if( !CreateProcess( NULL,   // No module name (use command line). 
        cmd,              // Command line. 
        NULL,             // Process handle not inheritable. 
        NULL,             // Thread handle not inheritable. 
        FALSE,            // Set handle inheritance to FALSE. 
        NULL,                // No creation flags. 
        NULL,             // Use parent's environment block. 
        NULL,             // Use parent's starting directory. 
        &si,              // Pointer to STARTUPINFO structure.
        &pi )             // Pointer to PROCESS_INFORMATION structure.
    ) 
    {        
        return 1;
        delete[] cmd;
    }
    delete[] cmd;
	return 0;
}

