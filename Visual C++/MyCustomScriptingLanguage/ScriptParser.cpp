

#include "stdafx.h"

#include "ScriptParser.h"


bool CScriptParser::ParseScriptFile( CString ScriptFile, CString EnvVars )
{
    m_InstructionList.RemoveAll();
    ScriptFile.TrimLeft();
    ScriptFile.TrimRight();

    if( !EnvVars.IsEmpty())
    {
        ParseCommandLineEnvVars( EnvVars );
    }
       
    if( !ScriptFile.IsEmpty())
    {
        if( !m_ScriptFile.Open( ScriptFile, CFile::modeRead )) return false;
        m_csBrokenInstrn.Empty();

        bool bError = false;

        Instructon_t instruction;
        while( !bError && ReadInstruction( instruction, bError )) m_InstructionList.Add( instruction );
        m_ScriptFile.Close();
        if( bError ) return false;
    } 
    return true;    
}


bool CScriptParser::ParseCommandLineEnvVars( CString EnvVars )
{
    EnvVars.TrimLeft( T( " \"" ));
    EnvVars.TrimRight( T( " \"" ));
    if( EnvVars.IsEmpty()) return true;
    int nIdx = -1;
    while(( nIdx = EnvVars.FindOneOf( ARG_SEPERATORS )) >= 0 )
    {
        Instructon_t ins;
        ins.OP_CODE = OPCODE_SETENV;
        ins.OP_ARG = EnvVars.Left( nIdx );
        m_InstructionList.Add( ins );
        EnvVars = EnvVars.Mid( nIdx + 1 );
    }
    if( !EnvVars.IsEmpty())
    {
        Instructon_t ins;
        ins.OP_CODE = OPCODE_SETENV;
        ins.OP_ARG = EnvVars;
        m_InstructionList.Add( ins );
    }
    return true;
}

bool CScriptParser::ReadInstruction( Instructon_t& Instruction, bool& IsError )
{
    IsError = false;

    CString csIns;
    if( !m_csBrokenInstrn.IsEmpty()) csIns = m_csBrokenInstrn;
    while( m_ScriptFile.ReadString( m_csBrokenInstrn ))
    {
        m_csBrokenInstrn.TrimLeft();
        if( m_csBrokenInstrn.IsEmpty() || m_csBrokenInstrn.Left( 1 ) == OPCODE_COMMENT ) continue;

        if( m_csBrokenInstrn.Find( OPCODE_INDICATOR ) >= 0 )
        {
            if( csIns.IsEmpty())
            {
                csIns += m_csBrokenInstrn;
            }
            else
            {
                break;
            }
        }
        else
        {
            csIns += T( "\n") + m_csBrokenInstrn;            
        }
        m_csBrokenInstrn.Empty();
    }
    
    int nOpCodeIndx = csIns.Find( OPCODE_INDICATOR );
    if( nOpCodeIndx <= -1 )
    {
        csIns.TrimLeft();
        csIns.TrimRight();
        if(!csIns.IsEmpty()) IsError = true;
        return false;
    }
    Instruction.OP_CODE = csIns.Left( nOpCodeIndx );
    Instruction.OP_ARG = csIns.Mid( nOpCodeIndx + 1 );
    return true;    
}

int CScriptParser::GetLength( void )
{
    return m_InstructionList.GetSize();
}

Instructon_t CScriptParser::operator[]( int nIndex )
{
    return m_InstructionList.GetAt( nIndex );
}