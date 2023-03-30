// StartDosFromFileNew.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "TCHAR.h"
#include <windows.h>

// Example call to this application
// StartDosFromFileNew <Fullpath to the Folder without quotes, with trailing slash>New Dos Prompt Here!.DosPromptHere
int main(int argc, char* argv[])
{
    int nLen = 0;

    // Combine the token to get the full path, since spaces within the path will split the commandline tokens
    for( int i = 1 ; i < argc ; ++i ) nLen += _tcslen( argv[ i ] ) + 1;
    TCHAR *szString = new TCHAR[ nLen + 1 ]; szString[ 0 ] = '\0';
    // Insert space b/w each tokens since they actually seperated by spaces
    for( i = 1 ; i < argc ; ++i ) _tcscat(_tcscat( szString , argv [ i ] ) , _T( " " ) );
    int nStrLen = _tcslen( szString );
    // Reomove the last unneeded space
    szString [ --nStrLen ] = _T( '\0' );
    
    // We have to remove the trailing string 'New Dos Prompt Here!.DosPromptHere', from the path
    int nUnLen = _tcslen( _T( "New Dos Prompt Here!.DosPromptHere" ) );
    // Remove it :P
    szString[  nStrLen - nUnLen  ] = _T( '\0' );
    TCHAR *cmd = new TCHAR[ _tcslen( szString ) + _tcslen( "CMD.EXE /K CHDIR /D \"\"" ) + 1 ];
    cmd[ 0 ] = '\0';
    // Create the command as the following
    // CMD.exe /K CHDIR /D "<Path To the folder>"
    // Never forget to add double quotes around the path
    _tcscat(_tcscat(_tcscat( cmd , "CMD.EXE /K CHDIR /D \"" ) , szString ) , "\"" );
    delete[] szString;

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

    // Start the dos command line console with the previous commandline created
    // And Allocate a new console window instead of using the console of this 
    // Process, so that this process can gracefully exit after the following command.
    if( !CreateProcess( NULL,   // No module name (use command line). 
        cmd,              // Command line. 
        NULL,             // Process handle not inheritable. 
        NULL,             // Thread handle not inheritable. 
        FALSE,            // Set handle inheritance to FALSE. 
        CREATE_NEW_CONSOLE,                // No creation flags. 
        NULL,             // Use parent's environment block. 
        NULL,             // Use parent's starting directory. 
        &si,              // Pointer to STARTUPINFO structure.
        &pi )             // Pointer to PROCESS_INFORMATION structure.
    ) 
    {
        delete[] cmd;
        return 1;
    }
    delete[] cmd;
	return 0;
}

