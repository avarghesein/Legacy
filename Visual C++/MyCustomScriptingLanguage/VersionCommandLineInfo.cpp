

#include "stdafx.h"
#include "VersionCommandLineInfo.h"
#include "Structures.h"


CVersionCommandLineInfo::CVersionCommandLineInfo() : CCommandLineInfo(), 
m_eLastItem( FLAG_NONE ), m_bVerboseMsg( false ), m_bSimulation( false ), m_bHelpMode( false )
{ }

void CVersionCommandLineInfo::ParseParam(const TCHAR* pszParam, BOOL bFlag, BOOL bLast)
{
	CCommandLineInfo::ParseParam( pszParam, bFlag, bLast );

	if( bFlag )
	{
		CString csParam( pszParam );
		
		csParam.TrimLeft();
		csParam.TrimRight();
		csParam.MakeLower();

		if( csParam == T( "f" )) m_eLastItem = FLAG_FILE; else
		if( csParam == T( "e" )) m_eLastItem = FLAG_ENVVAR; else
		if( csParam == T( "s" ))
		{
			m_eLastItem = FLAG_SIMULATION;
			m_bSimulation = true;
		}
		else if( csParam == T( "v" ))
		{
			m_eLastItem = FLAG_VERBOSEMSG; 
			m_bVerboseMsg = true;
		}
		else if( csParam == T( "?" ))
		{
			m_eLastItem = FLAG_HELP; 
			m_bHelpMode = true;
		}
		else
			m_eLastItem = FLAG_NONE;
	}
	else
	{
		switch( m_eLastItem )
		{
			case FLAG_FILE:
				m_csFileName = pszParam;
				m_csFileName.TrimLeft();
				m_csFileName.TrimRight();
				break;

			case FLAG_ENVVAR:
				m_csEnvVars = pszParam;
				m_csEnvVars.TrimLeft();
				m_csEnvVars.TrimRight();
				break;
		}
	}
}

CString CVersionCommandLineInfo::GetFileName( void )
{
	return m_csFileName;
}

CString CVersionCommandLineInfo::GetEnvVars( void )
{
	return m_csEnvVars;
}