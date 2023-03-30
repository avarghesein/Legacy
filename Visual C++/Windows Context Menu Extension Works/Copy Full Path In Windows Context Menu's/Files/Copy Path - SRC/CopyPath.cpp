// CopyPath.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "TCHAR.h"
#include <windows.h>

// Example call to this application
// CopyPath <Fullpath to the Folder/File>
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
    // Open the Clipboard
    if(OpenClipboard( 0 ))
    {
	    HGLOBAL hClipBuffer = 0;
        // Clear the clip board
	    EmptyClipboard();
        // Create a global memory
	    hClipBuffer = GlobalAlloc(GMEM_DDESHARE, nStrLen + 1 );
        // Get the pointer to the allocated global memory
	    TCHAR* szBuffer = (TCHAR*)GlobalLock( hClipBuffer );
        // Copy the data to the global memory
        _tcscpy( szBuffer, szString );
        // Unlock the global memory
	    GlobalUnlock( hClipBuffer );
        // Set the clipboard with global memory
	    SetClipboardData( CF_TEXT, hClipBuffer );
        // Close the clip board
	    CloseClipboard();
    }
    // Delete the allocated string
    delete[] szString;
	return 0;
}

