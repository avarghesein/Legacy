
#if !defined(SCRIPTPARSER_INCLUDED)
#define SCRIPTPARSER_INCLUDED

#include "Structures.h"

class CScriptParser  
{
public:

	bool ParseScriptFile( CString ScriptFile, CString EnvVars );
    int GetLength( void );
    Instructon_t operator[](int nIndex);

    CArray<Instructon_t,Instructon_t&>& GetInstructionList( void )
    {
        return m_InstructionList;
    }

private:
    
    bool ReadInstruction( Instructon_t& Instruction, bool& IsError );
    bool ParseCommandLineEnvVars( CString EnvVars );

private:

    CString m_csBrokenInstrn;
    CStdioFile m_ScriptFile;    
    CArray<Instructon_t,Instructon_t&> m_InstructionList;
};

#endif
