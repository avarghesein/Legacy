

#if !defined(COMMANDRUNNER_INCLUDED)
#define COMMANDRUNNER_INCLUDED

#include "Structures.h"
#include "ScriptEngine.h"

class CCommandRunner  
{
public:
	static bool Run( CScriptEngine& ScriptEngine, CString& CommandLine, bool WaitForCompletion );
    static bool Wait( CString& Msg );
    static bool SetCurrentDirectory( CString& Path );
    static bool GetCurrentDirectory( CString& Path );
    static bool SetEnvironment( CScriptEngine& ScriptEngine );
	static bool SetRegistry( CScriptEngine& ScriptEngine );

};

#endif
