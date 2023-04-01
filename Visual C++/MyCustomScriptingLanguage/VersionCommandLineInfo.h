
#if !defined(VERSIONCOMMANDLINEINFO_INCLUDED)
#define VERSIONCOMMANDLINEINFO_INCLUDED

class CVersionCommandLineInfo : public CCommandLineInfo  
{
public:

	CString GetFileName( void );
	CString GetEnvVars( void );
	bool IsVerboseMsg( void ) { return m_bVerboseMsg;	}
	bool IsSimulationMode( void ) { return m_bSimulation; }
	bool IsHelpMode( void ) { return m_bHelpMode; }

	CVersionCommandLineInfo( void );

private:
    
	virtual void ParseParam(const TCHAR* pszParam, BOOL bFlag, BOOL bLast);

private:

	enum CMD_LNE_ARG_e
	{
		FLAG_NONE = 0,
		FLAG_FILE,
		FLAG_ENVVAR,
		FLAG_SIMULATION,
		FLAG_VERBOSEMSG,
		FLAG_HELP
	};

	CMD_LNE_ARG_e m_eLastItem;
	CString m_csFileName;
	CString m_csEnvVars;
	bool m_bVerboseMsg;
	bool m_bSimulation;
	bool m_bHelpMode;
};

#endif
