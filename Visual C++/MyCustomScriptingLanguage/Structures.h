
#if !defined(STRUCTS_INCLUDED)
#define STRUCTS_INCLUDED

struct IScriptEngine
{
    virtual bool PrepareExecutionStart( void ) = 0;
    virtual bool PreExecuteCommand( CString& OP_CODE, CString& OP_ARG ) = 0;
    virtual bool ExecuteCommand( CString& OP_CODE, CString& OP_ARG ) = 0;
    virtual bool PostExecuteCommand( CString& OP_CODE, CString& OP_ARG ) = 0;
    virtual bool PrepareExecutionEnd( void ) = 0;

    virtual bool InternalPrepareExecutionStart( void ) = 0;
    virtual bool InternalPreExecuteCommand( CString& OP_CODE, CString& OP_ARG ) = 0;
    virtual bool InternalExecuteCommand( CString& OP_CODE, CString& OP_ARG ) = 0;
    virtual bool InternalPostExecuteCommand( CString& OP_CODE, CString& OP_ARG ) = 0;
    virtual bool InternalPrepareExecutionEnd( void ) = 0;
};


#define T( STR ) _T( STR )
#define CSTR( STR ) CString( T( STR ) )

#define OPCODE_INDICATOR                     T("|")
#define OPCODE_COMMENT                       T(";")
#define OPCODE_SETENV                        T("SET")
        #define ARG_SCRIPT_VAR_START            T("<")
        #define ARG_SCRIPT_VAR_END              T(">")
        #define ARG_ENV_VAR_START               T("%")
        #define ARG_ENV_VAR_END                 T("%")
        #define ARG_VALUE_DELEMITER1            T( ";" )
        #define ARG_VALUE_DELEMITER2            T( "," )
#define OPCODE_UNSETENV                      T("UNSET")
#define OPCODE_IF                            T("IF")
#define OPCODE_IFNOT                         T("IF_NOT")
#define OPCODE_ELSE                          T("ELSE")
#define OPCODE_ENDIF                         T("ENDIF")
#define OPCODE_REG                           T("REG")
		#define ARG_REGKEY_START                T("[")
		#define ARG_REGKEY_END                  T("]")
#define OPCODE_UNREG                         T("UNREG")
#define OPCODE_RUN                           T("RUN")
#define OPCODE_RUNWAIT                       T("RUN_WAIT")
#define OPCODE_WAIT                          T("WAIT")
#define OPCODE_BEGIN                         T("BEGIN")
#define OPCODE_END                           T("END")
#define OPCODE_ENVCOMMIT                     T("ENV_COMMIT")
#define OPCODE_REGCOMMIT                     T("REG_COMMIT")
#define OPCODE_INCLUDE                       T("INCLUDE")
#define OPCODE_QUIT                          T("QUIT")
#define OPCODE_CHDIR                         T("CHDIR")
#define OPCODE_RETURN                        T("RETURN")


#define ARG_SEPERATORS                       T(";,")


struct Instructon_t
{
    CString OP_CODE;
    CString OP_ARG;
    Instructon_t() {}
	Instructon_t( CString OP_CODE, CString OP_ARG )
	{
		this->OP_CODE = OP_CODE;
		this->OP_ARG = OP_ARG;
	}
};

struct KeyValueDefn_t
{
	CString VAR;
	CString VAL;
	bool IS_SET;

	KeyValueDefn_t( CString& Var,bool IsSet = false, CString& Val = CString(T( "" )))
	{
		VAR = Var;
		VAL = Val;
		IS_SET = IsSet;
	}

	KeyValueDefn_t()
	{ 
		IS_SET = false;
	}

	const KeyValueDefn_t& operator=( const KeyValueDefn_t& Obj )
	{
		if( this == &Obj ) return *this;
		VAR = Obj.VAR;
		VAL = Obj.VAL;
		IS_SET = Obj.IS_SET;
		return *this;
	}
	
};

typedef CMap<CString,LPCTSTR,KeyValueDefn_t,KeyValueDefn_t&> MAP_KEY_VALUE;

struct RegKeyValueDefn_t
{
	CString KEY_PATH;
	MAP_KEY_VALUE VALUE_NAMES;
	bool IS_SET;

	RegKeyValueDefn_t( void )
	{
		IS_SET = false;
	}

	RegKeyValueDefn_t( CString KeyPath, bool IsSet = false )
	{
		IS_SET = IsSet;
		KEY_PATH = KeyPath;
	}

	const RegKeyValueDefn_t& operator=( const RegKeyValueDefn_t& RegKeys )
	{
		if( this == &RegKeys ) return *this;
		KEY_PATH = RegKeys.KEY_PATH;
		VALUE_NAMES.RemoveAll();
		IS_SET = RegKeys.IS_SET;
		
		POSITION pos = RegKeys.VALUE_NAMES.GetStartPosition();
		while( pos )
		{
			CString csKey;
			KeyValueDefn_t KeyValue;
			RegKeys.VALUE_NAMES.GetNextAssoc( pos, csKey, KeyValue );
			VALUE_NAMES.SetAt( csKey, KeyValue );
		}
		return *this;
	}
};

typedef CMap<CString,LPCTSTR,RegKeyValueDefn_t,RegKeyValueDefn_t&> MAP_REG_KEY_VALUE;

#define LOG CLogger::GetInstance().WriteString
#define LOG_STDOUT CLogger::GetInstance().WriteConsole


#endif