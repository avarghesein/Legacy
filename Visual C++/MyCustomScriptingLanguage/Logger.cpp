
#include "stdafx.h"
#include "Logger.h"
#include "Structures.h"

CLogger* CLogger::m_Logger = 0;
bool CLogger::m_bVerboseMsg = false;
CString CLogger::m_csExePath = CLogger::GetModulePath();
CString CLogger::m_csLogFilePath = T( "MVSelector" );

CLogger& CLogger::GetInstance( void )
{
	if( !m_Logger ) m_Logger = new CLogger;
	return *m_Logger;
}


void CLogger::Initialize( CString& FileName )
{
    CString csLogFolder = m_csExePath + T( "\\Logs-MVSelector\\" );
    m_csLogFilePath = csLogFolder;
    if( !FileName.IsEmpty())    
    {
        m_csLogFilePath += FileName;
    }
    else
    {
        m_csLogFilePath += T( "MVSelector" );
    }
    m_csLogFilePath.TrimLeft();
    m_csLogFilePath.TrimRight();
    int nDotIdx = m_csLogFilePath.ReverseFind( T( '.' ));
    if( -1 != nDotIdx )
    {
        m_csLogFilePath = m_csLogFilePath.Left( nDotIdx );
    }
    m_csLogFilePath += T( ".log" );
    ::DeleteFile( m_csLogFilePath );
    if( m_bVerboseMsg ) ::CreateDirectory( csLogFolder, 0 );
}

bool CLogger::ExitInstance( void )
{
	if( m_Logger )
    {
        delete m_Logger;
        m_Logger = 0;
    }
	return true;
}

void CLogger::SetVerboseMsgMode( bool VerboseMsg )
{
	m_bVerboseMsg = VerboseMsg;
}

CString CLogger::GetModulePath( void )
{
	TCHAR szExePath[ 1024 ];
	GetModuleFileName( 0, szExePath, 1024 );
	CString csModulePath = szExePath;
	int nIndex = csModulePath.ReverseFind( T( '\\' ));
	return csModulePath.Left( nIndex + 1 );
}

CLogger::CLogger( void )
{   
	m_bFileOpened = false;
	if( m_bVerboseMsg )
	{
		m_bFileOpened = TRUE == m_LogFile.Open( m_csLogFilePath,
            CFile::modeCreate | CFile::modeWrite | CFile::modeNoTruncate | CFile::shareDenyNone );
        if( m_bFileOpened )
        {
            m_LogFile.SeekToEnd();
        }
	}
}

bool CLogger::WriteString( CString Value )
{	
	if( !m_bFileOpened ) return false;
	m_LogFile.WriteString( Value + T( "\n\n" ));
	return true;
}

bool CLogger::WriteConsole( CString Value )
{
	ConsoleOut << Value.operator LPCTSTR() << T( "\n" );
    ConsoleOut.flush();
	return true;
}

CLogger::~CLogger()
{
	if( m_bFileOpened )
	{
		m_LogFile.Flush();
		m_LogFile.Close();
        m_bFileOpened = false;
	}
}
