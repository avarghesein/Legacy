

#if !defined(LOGGER__INCLUDED)
#define LOGGER__INCLUDED

class CLogger  
{

public:
    static CString GetModulePath( void );
	static CLogger& GetInstance( void );
    static void Initialize( CString& FileName );
	static bool ExitInstance( void );	
	static void SetVerboseMsgMode( bool VerboseMsg );
	bool WriteString( CString Value );
	bool WriteConsole( CString Value );    

private:
	static CLogger* m_Logger;
	static bool m_bVerboseMsg;
    static CString m_csExePath;
    static CString m_csLogFilePath;

private:
	CLogger();
   ~CLogger();

private:
	CStdioFile m_LogFile;
	bool m_bFileOpened;

};


#endif
