
#include "stdafx.h"
#include "ScriptEngine.h"
#include "CommandRunner.h"
#include "Logger.h"
#include "ScriptParser.h"


bool CScriptEngine::PrepareExecutionStart( void )
{
    return InternalPrepareExecutionStart();
}

bool CScriptEngine::PreExecuteCommand( CString& OP_CODE, CString& OP_ARG )
{
    return InternalPreExecuteCommand( OP_CODE, OP_ARG );
}

bool CScriptEngine::ExecuteCommand( CString& OP_CODE, CString& OP_ARG )
{
    return InternalExecuteCommand( OP_CODE, OP_ARG );
}

bool CScriptEngine::PostExecuteCommand( CString& OP_CODE, CString& OP_ARG )
{
    return InternalPostExecuteCommand( OP_CODE, OP_ARG );
}

bool CScriptEngine::PrepareExecutionEnd( void )
{
    return InternalPrepareExecutionEnd();
}


bool CScriptEngine::InternalPrepareExecutionStart( void )
{
    m_bExitSet = false;
    m_bReturn = false;
    return true;
}

bool CScriptEngine::InternalPreExecuteCommand( CString& OP_CODE, CString& OP_ARG )
{
	if( 0 != OP_CODE.CompareNoCase( OPCODE_REG ) && 0 != OP_CODE.CompareNoCase( OPCODE_UNREG ))
	{
		OP_ARG.Replace( T( "\n" ), T( "" ));
	}
    return true;
}

bool CScriptEngine::InternalExecuteCommand( CString& OP_CODE, CString& OP_ARG )
{
	OP_CODE.TrimLeft();
	OP_CODE.TrimRight();
	OP_ARG.TrimLeft();
	OP_ARG.TrimRight();
	
    LOG( CString( OP_CODE ) + OPCODE_INDICATOR + OP_ARG );
      
	if( 0 == OP_CODE.CompareNoCase( OPCODE_IF ))
	{
		if( !ProcessIFStatement( OP_ARG ))
		{
			LOG_STDOUT( CSTR( "IF: <-{PARSE ERROR} - "));
			LOG( CSTR( "IF: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false; 
		}
		return true;
	}
	if( 0 == OP_CODE.CompareNoCase( OPCODE_IFNOT ))
	{
		if( !ProcessIFStatement( OP_ARG, true ))
		{
			LOG_STDOUT( CSTR( "IFNOT: <-{PARSE ERROR} - "));
			LOG( CSTR( "IFNOT: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false; 
		}
		return true;
	}
	if( 0 == OP_CODE.CompareNoCase( OPCODE_ELSE ))
	{
		if( !ProcessELSEStatement( OP_ARG )) 
		{
			LOG_STDOUT( CSTR( "ELSE: <-{PARSE ERROR} - "));
			LOG( CSTR( "ELSE: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;
		}
		return true;
	}
	if( 0 == OP_CODE.CompareNoCase( OPCODE_ENDIF ))
	{
		if( !ProcessENDIFStatement( OP_ARG ))
		{
			LOG_STDOUT( CSTR( "ENDIF: <-{PARSE ERROR} - "));
			LOG( CSTR( "ENDIF: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false; 
		}
		return true;
	}

	if( !m_IFConditions.GetActiveValue())
	{
		LOG( CString( OP_CODE ) + OPCODE_INDICATOR + OP_ARG );
		LOG( T( "SKIPPED INSTRUCTION DUE TO IF: FALSE") );
		return true;
	}	

	if( 0 != OP_CODE.CompareNoCase( OPCODE_WAIT ))
    {
		LOG_STDOUT( CString( OP_CODE ) + OPCODE_INDICATOR + OP_ARG );    
	}

    if( 0 == OP_CODE.CompareNoCase( OPCODE_BEGIN ) || 0 == OP_CODE.CompareNoCase( OPCODE_END ) )
    {
        return true;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_SETENV ))
    {
        if( !ProcessEnvVarDefn( OP_ARG ))
		{
			LOG_STDOUT( CSTR( "SET: <-{PARSE ERROR} - "));
			LOG( CSTR( "SET: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
	if( 0 == OP_CODE.CompareNoCase( OPCODE_UNSETENV ))
    {
        if( !ProcessEnvVarRemoval( OP_ARG ))
		{
			LOG_STDOUT( CSTR( "UNSET: <-{PARSE ERROR} - "));
			LOG( CSTR( "UNSET: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }	
	if( 0 == OP_CODE.CompareNoCase( OPCODE_REG ))
    {
        if( !ProcessREGStatement( OP_ARG ))
		{
			LOG_STDOUT( CSTR( "REG: <-{PARSE ERROR} - "));
			LOG( CSTR( "REG: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
	if( 0 == OP_CODE.CompareNoCase( OPCODE_UNREG ))
    {
        if( !ProcessREGStatement( OP_ARG, false ))
		{
			LOG_STDOUT( CSTR( "UNREG: <-{PARSE ERROR} - "));
			LOG( CSTR( "UNREG: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_RUN ))
    {
        if( !ProcessRunStatement( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "RUN: <-{PARSE ERROR} - "));
			LOG( CSTR( "RUN: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_RUNWAIT ))
    {
        if( !ProcessRunStatement( OP_ARG, true  ))
		{
			LOG_STDOUT( CSTR( "RUNWAIT: <-{PARSE ERROR} - "));
			LOG( CSTR( "RUNWAIT: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }	
    if( 0 == OP_CODE.CompareNoCase( OPCODE_WAIT ))
    {
        if( !ProcessWaitStatement( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "WAIT: <-{PARSE ERROR} - "));
			LOG( CSTR( "WAIT: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }	
    if( 0 == OP_CODE.CompareNoCase( OPCODE_ENVCOMMIT ))
    {
        if( !ProcessEnvVarCommit( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "ENV_COMMIT: <-{PARSE ERROR} - "));
			LOG( CSTR( "ENV_COMMIT: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
	if( 0 == OP_CODE.CompareNoCase( OPCODE_REGCOMMIT ))
    {
        if( !ProcessRegistryCommit( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "REG_COMMIT: <-{PARSE ERROR} - "));
			LOG( CSTR( "REG_COMMIT: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_CHDIR ))
    {
        if( !ProcessChangeDirectory( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "CHDIR: <-{PARSE ERROR} - "));
			LOG( CSTR( "CHDIR: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_INCLUDE ))
    {
        if( !ProcessIncludeStatement( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "INCLUDE: <-{PARSE ERROR} - "));
			LOG( CSTR( "INCLUDE: <-{PARSE ERROR} - ") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return true;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_QUIT ))
    {
        m_bExitSet = true;
        if( !ProcessQuitStatement( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "QUIT: ERROR"));
			LOG( CSTR( "QUIT: ERROR") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return false;
    }
    if( 0 == OP_CODE.CompareNoCase( OPCODE_RETURN ))
    {
        m_bReturn = true;
        if( !ProcessQuitStatement( OP_ARG  ))
		{
			LOG_STDOUT( CSTR( "RETURN: ERROR"));
			LOG( CSTR( "RETURN: ERROR") + OP_CODE + OPCODE_INDICATOR + OP_ARG );
			return false;        
		}
        return false;
    }
    return false;
}

bool CScriptEngine::ProcessChangeDirectory( CString& Args )
{
    CString csCurDir = Args;
    if( !ReplaceEnvVars( csCurDir, true )) return false;
    LOG( CSTR( "CHDIR: " ) + csCurDir );
    return CCommandRunner::SetCurrentDirectory( csCurDir );
}

bool CScriptEngine::ProcessQuitStatement( CString& Args )
{
    return true;
}

bool CScriptEngine::ProcessReturnStatement( CString& Args )
{
    return true;
}

bool CScriptEngine::ProcessELSEStatement( CString& EnvVar )
{
	bool bVal;
	bool bRet = m_IFConditions.ELSE( bVal );
	if( bRet )
	{
		LOG( CSTR( "ELSE: Active Value = " ) + ( bVal ? T( "TRUE" ) : T( "FALSE" ) ));
	}
	return bRet;
}

bool CScriptEngine::ProcessENDIFStatement( CString& EnvVar )
{
	bool bVal;
	bool bRet = m_IFConditions.EndIF( bVal );
	if( bRet )
	{
		LOG( CSTR( "ENDIF: Active Value = " ) + ( bVal ? T( "TRUE" ) : T( "FALSE" ) ));
	}
	return bRet;
}

bool CScriptEngine::ProcessIFStatement( CString& EnvVar , bool bApplyNot )
{
	CString csMsg( !bApplyNot ? T( "IF:" ) : T( "IFNOT:" ));
	CString csKey, csValue;

	EnvVar.TrimLeft();
	EnvVar.TrimRight();

	if( ParseKeyValueToken( EnvVar, CString(T( "!=" )), csKey, csValue ))
	{
		if( !ReplaceEnvVars( csKey, true ) || !ReplaceEnvVars( csValue, true )) return false;
		bool bVal = 0 != csKey.CompareNoCase( csValue );
		if( bApplyNot ) bVal = !bVal;
		m_IFConditions.IF( bVal );
		LOG( csMsg + T( " Active Value = " ) + ( bVal ? T( "TRUE" ) : T( "FALSE" ) ));
		return true;
	}
	if( ParseKeyValueToken( EnvVar, CString(T( "=" )), csKey, csValue ))
	{
		if( !ReplaceEnvVars( csKey, true ) || !ReplaceEnvVars( csValue, true )) return false;
		bool bVal = 0 == csKey.CompareNoCase( csValue );
		if( bApplyNot ) bVal = !bVal;
		m_IFConditions.IF( bVal );
		LOG( csMsg + T( " Active Value = " ) + ( bVal ? T( "TRUE" ) : T( "FALSE" ) ));
		return true;
	}
	bool bVal = FindEnvVarValue( EnvVar, csValue );
	if( bApplyNot ) bVal = !bVal;
	m_IFConditions.IF( bVal );
	LOG( csMsg + T( " Active Value = " ) + ( bVal ? T( "TRUE" ) : T( "FALSE" ) ));
	return true;
}

bool CScriptEngine::ProcessEnvVarRemoval( CString& EnvVar )
{
	CString csKey( EnvVar ), csValue;
	bool bIsScriptVar;
	if( !ProcessKeyValuePair( csKey, csValue, bIsScriptVar, false)) return false;
	CString csKeyLower = csKey;
	csKeyLower.MakeLower();
	if( bIsScriptVar )
		m_ScriptVariables.RemoveKey( csKeyLower );
	else
		m_EnvVariables.SetAt( csKeyLower, KeyValueDefn_t( csKey ));

	LOG( CSTR( "UNSET:") + ( bIsScriptVar ? T( "[SCRIPT_VAR] " ) : T( "[ENV_VAR] " ))+ EnvVar );

	return true;
}

bool CScriptEngine::ProcessEnvVarDefn( CString& EnvVar )
{
	CString csKey, csValue;
	bool bIsScriptVar;

	if( !ProcessNameValuePairDefn( EnvVar, csKey, csValue, bIsScriptVar )) return false;
	
	CString csKeyLower = csKey;
	csKeyLower.MakeLower();

	if( bIsScriptVar )
		m_ScriptVariables.SetAt( csKeyLower, csValue );
	else
		m_EnvVariables.SetAt( csKeyLower, KeyValueDefn_t( csKey, true, csValue ) );
    
    return true;
}

bool CScriptEngine::ProcessNameValuePairDefn( 
				CString& NameValue, CString& Key, CString& Value,
				bool& IsScriptVar, CString& RegKeyPath, bool IsForRegNameValue )
{
	CString csKey, csValue;
	bool bIsScriptVar;
    bool bPlusEqual = false, bPlusMinus = false;

    if(( bPlusEqual = ParseKeyValueToken( NameValue, CSTR( "+=" ), csKey, csValue )) ||
       ( bPlusMinus = ParseKeyValueToken( NameValue, CSTR( "-=" ), csKey, csValue )))
    {
        if( !ProcessKeyValuePair( csKey, csValue, bIsScriptVar, false )) return false;
		LOG( CSTR( "COMMAND STRING:") + NameValue );	
        CString csEnvVarVal;
		if( !IsForRegNameValue )
		{
			if( !FindEnvVarValue( csKey, csEnvVarVal, true )) csEnvVarVal = T( "" );
		}
		else
		{
			if( !FindRegKeyValueName( RegKeyPath, csKey, csEnvVarVal )) csEnvVarVal = T( "" );
		}
		LOG( CSTR( "ORIGINAL VAR:") + csEnvVarVal );
        CStringArray ValueArray, ReplaceArray;
        CStringArray DelemiterArray;
		CString csTrimChars = T( " /\\" );
        DelemiterArray.Add( ARG_VALUE_DELEMITER1 );
        DelemiterArray.Add( ARG_VALUE_DELEMITER2 );
        if( !SeperateItems( csEnvVarVal, DelemiterArray, csTrimChars, ValueArray )) return false;
        if( !SeperateItems( csValue, DelemiterArray, csTrimChars , ReplaceArray )) return false;
        if( !AddOrRemoveSubItems( ValueArray, ReplaceArray, csTrimChars, !bPlusEqual )) return false;
        if( !ConcatItems( ValueArray, CString(ARG_VALUE_DELEMITER1), csEnvVarVal )) return false;

		Key = csKey;
		Value = csEnvVarVal;
		IsScriptVar = bIsScriptVar;		
        
		LOG( CSTR( "UPDATED VAR:") + csKey + T( "=" ) + csEnvVarVal );
        return true;
    }

	if( !ParseKeyValueToken( NameValue, CSTR( "=" ), csKey, csValue )) return false;
	if( !ProcessKeyValuePair( csKey, csValue, bIsScriptVar, false )) return false;

	LOG( CSTR( "COMMAND STRING:") + NameValue );	

	Key = csKey;
	Value = csValue;
	IsScriptVar = bIsScriptVar;		
	
	LOG( CSTR( "UPDATED VAR:") + csKey + T( "=" ) + csValue );
    return true;
}

bool CScriptEngine::ParseKeyValueToken( CString& String, CString& Seperator, CString& Key, CString& Value )
{
	int iIndex = -1;
    iIndex = String.Find( Seperator );
    if( iIndex <= -1 ) return false;

    Key = String.Left( iIndex );
    Value = String.Mid( iIndex + Seperator.GetLength());
    Key.TrimLeft(), Key.TrimRight();
    Value.TrimLeft();Value.TrimRight();
	return true;
}

bool CScriptEngine::ProcessKeyValuePair( CString& Key, CString& Value, bool& bIsScriptVar, bool bReplaceEnvVar )
{
    CString csKey = Key;
    CString csValue = Value;
    csKey.TrimLeft(), csKey.TrimRight();
    csValue.TrimLeft();

	if( csKey.Find( T( "=")) >= 0 ) return false;
	
	if( FindEnvolopedItem( csKey, CString(ARG_SCRIPT_VAR_START), CString(ARG_SCRIPT_VAR_END),csKey))
	{
		if( !ReplaceEnvVars( csValue, bReplaceEnvVar )) return false;
        
		Key = csKey, Value = csValue;
		bIsScriptVar = true;
        return true;
	}
	FindEnvolopedItem( csKey, CString(ARG_ENV_VAR_START), CString(ARG_ENV_VAR_END),csKey);
	if( !ReplaceEnvVars( csValue, bReplaceEnvVar )) return false;     
	Key = csKey, Value = csValue;
	bIsScriptVar = false;
    return true;
}

bool CScriptEngine::FindEnvolopedItem( CString& Value, CString& LeftEnvolope, CString& RightEnvolope,
									   CString& Item )
{
	int VAR_START_LEN = LeftEnvolope.GetLength();
	int VAR_END_LEN = RightEnvolope.GetLength();

    if( 0 == Value.Left( VAR_START_LEN ).CompareNoCase( LeftEnvolope ))
    {
        if( 0 == Value.Right( VAR_END_LEN ).CompareNoCase( RightEnvolope ))
		{
			Item = Value.Mid( VAR_START_LEN, Value.GetLength() - VAR_END_LEN - 1 );
			Item.TrimLeft();
			Item.TrimRight();
			return true;
		}
	}
	return false;
}

bool CScriptEngine::FindEnvolopedSubItemFrom(
								   CString& Value, CString& LeftEnvolope, CString& RightEnvolope,
		                           CString& Item, CString& LeftPart, CString& RightPart )
{
	CString csValueLower = Value;
	csValueLower.MakeLower();

	CString csLeftEnvolopeLower = LeftEnvolope;
	csLeftEnvolopeLower.MakeLower();

	CString csRightEnvolopeLower = RightEnvolope;
	csRightEnvolopeLower.MakeLower();

	int nLeftEnvIndx = -1;
	int nRightEnvIndx = -1;
	if(( nLeftEnvIndx = csValueLower.Find( csLeftEnvolopeLower )) < 0 ) return false;

	int VAR_START_LEN = LeftEnvolope.GetLength();
	int VAR_END_LEN = RightEnvolope.GetLength();

	if(( nRightEnvIndx = csValueLower.Find( csRightEnvolopeLower, nLeftEnvIndx + VAR_START_LEN )) < 0 )
		return false;

	LeftPart = Value.Left( nLeftEnvIndx );
	RightPart = Value.Mid( nRightEnvIndx + VAR_END_LEN );
	return FindEnvolopedItem( Value.Mid( nLeftEnvIndx, nRightEnvIndx - nLeftEnvIndx + VAR_END_LEN ),
		                      LeftEnvolope, RightEnvolope, Item );

}

bool CScriptEngine::FindEnvVarValue( CString& Var, CString& Value , bool bDefaultProcessEnvVar )
{
	CString csKey = Var;
	if( FindEnvolopedItem( csKey, CString(ARG_SCRIPT_VAR_START), CString(ARG_SCRIPT_VAR_END),csKey ))
	{
		csKey.MakeLower();
		if( !m_ScriptVariables.Lookup( csKey, Value )) return false;
		ProcessPathString( Value );
		return true;
	}
	if( FindEnvolopedItem( csKey, CString(ARG_ENV_VAR_START), CString(ARG_ENV_VAR_END),csKey ))
	{
		csKey.MakeLower();
		if( !LookupProcessEnvVar( csKey, Value )) return false;
		ProcessPathString( Value );
		return true;
	}
    if( bDefaultProcessEnvVar )
    {
        csKey.MakeLower();
		if( !LookupProcessEnvVar( csKey, Value )) return false;
		ProcessPathString( Value );
		return true;
    }
	return false;
}

bool CScriptEngine::ReplaceEnvVars( CString& ValueString, bool bReplaceEnvVar, bool ProcessPath )
{
	int SVAR_START_LEN = CString( ARG_SCRIPT_VAR_START ).GetLength();
	int SVAR_END_LEN = CString( ARG_SCRIPT_VAR_END ).GetLength();
	int EVAR_START_LEN = CString( ARG_ENV_VAR_START ).GetLength();
	int EVAR_END_LEN = CString( ARG_ENV_VAR_END ).GetLength();
	
    ValueString.TrimLeft();
    int nIndxStart = -1, nIndxEnd = -1;
    while(( nIndxStart = ValueString.Find( ARG_SCRIPT_VAR_START )) >= 0 )
    {
        if(( nIndxEnd = ValueString.Find( ARG_SCRIPT_VAR_END, nIndxStart + SVAR_START_LEN )) <= -1 ) return false;
        CString csScriptVar = ValueString.Mid( nIndxStart + SVAR_START_LEN, nIndxEnd - nIndxStart - SVAR_START_LEN );
        csScriptVar.TrimLeft();
        csScriptVar.TrimRight();
        csScriptVar.MakeLower();
        CString csScriptVal;
        if( !m_ScriptVariables.Lookup( csScriptVar, csScriptVal )) return false;
        ValueString = ValueString.Left( nIndxStart ) + csScriptVal + ValueString.Mid( nIndxEnd + SVAR_END_LEN );
    }

    if( !bReplaceEnvVar )
	{
		if( ProcessPath ) ProcessPathString( ValueString );
		return true;
	}

    nIndxStart = -1, nIndxEnd = -1;
    while(( nIndxStart = ValueString.Find( ARG_ENV_VAR_START )) >= 0 )
    {
        if(( nIndxEnd = ValueString.Find( ARG_ENV_VAR_END, nIndxStart + EVAR_START_LEN )) <= -1 ) return false;
        CString csEnvVar = ValueString.Mid( nIndxStart + EVAR_START_LEN, nIndxEnd - nIndxStart - EVAR_START_LEN );
        csEnvVar.TrimLeft();
        csEnvVar.TrimRight();
        csEnvVar.MakeLower();
        CString csEnvVal;
        if( !LookupProcessEnvVar( csEnvVar, csEnvVal )) return false;
        ValueString = ValueString.Left( nIndxStart ) + csEnvVal + ValueString.Mid( nIndxEnd + EVAR_END_LEN );
    }
	if( ProcessPath ) ProcessPathString( ValueString );
    return true;
}

bool CScriptEngine::LookupProcessEnvVar( CString& EnvVar, CString& EnvVal, bool LookUpLocalMap )
{   
	CString csKey = EnvVar;
	csKey.TrimLeft();
	csKey.TrimRight();
	csKey.MakeLower();
    if( LookUpLocalMap )
    {
	    KeyValueDefn_t objEnvVar;
	    if( m_EnvVariables.Lookup( csKey, objEnvVar ))
	    {
		    EnvVal = objEnvVar.VAL;
		    return objEnvVar.IS_SET;
	    }
    }
	
    CString csEnvRegKey = T( "HKEY_LOCAL_MACHINE\\SYSTEM\\ControlSet001\\Control\\Session Manager\\Environment" );
    if( FindRegKeyValueName( csEnvRegKey ,csKey, EnvVal, false ))
    {
        return true;
    }

    TCHAR temp[ 32767 ];
    temp[ 0 ] = T('\0');
    DWORD dwRes = ::GetEnvironmentVariable( EnvVar, temp, 32767 );
    if( ERROR_ENVVAR_NOT_FOUND == dwRes || !dwRes )
    {
        EnvVal.Empty();
        return false;
    }
    EnvVal = temp;
    return true;
}

bool CScriptEngine::InternalPostExecuteCommand( CString& OP_CODE, CString& OP_ARG )
{
    return true;
}

bool CScriptEngine::InternalPrepareExecutionEnd( void )
{
    if( !ProcessEnvVarCommit( CSTR("")))
	{
		LOG_STDOUT( CSTR( "ENV_COMMIT: <-{ ERROR on Appliaton End} - "));
		LOG( CSTR( "ENV_COMMIT: <-{ ERROR on Appliaton End} - "));
		return false;        
	}
	if( !ProcessRegistryCommit( CSTR("")))
	{
		LOG_STDOUT( CSTR( "REG_COMMIT: <-{ ERROR on Appliaton End} - "));
		LOG( CSTR( "REG_COMMIT: <-{ ERROR on Appliaton End} - "));
		return false;        
	}
    return true;
}

bool CScriptEngine::SeperateItems( CString& Value, CStringArray& Seperators, CString& TrimChars,
								   CStringArray& Items )
{
    Items.RemoveAll();
    Value.TrimLeft( TrimChars );
    Value.TrimRight( TrimChars );
    Items.Add( Value );

    int iSepIndx = 0;
    int iSepCnt = Seperators.GetSize();
    for( iSepIndx = 0; iSepIndx < iSepCnt; ++iSepIndx )
    {
        int iItmIndx = 0;
        int iItmCnt = Items.GetSize();
        CString csSep = Seperators.GetAt( iSepIndx );
        csSep.MakeLower();

        for( iItmIndx = 0; iItmIndx < iItmCnt; ++iItmIndx )
        {
            CString csItem = Items.GetAt( iItmIndx );
            csItem.TrimLeft( TrimChars );
            csItem.TrimRight( TrimChars );
            CString csItemLower = csItem;
            csItemLower.MakeLower();

            int iFind = csItemLower.Find( csSep );
            if( iFind <= -1 ) continue;
            
            CString csLeft = csItem.Left( iFind );
            CString csRight = csItem.Mid( iFind + csSep.GetLength());

            csLeft.TrimLeft( TrimChars );
            csLeft.TrimRight( TrimChars );
            csRight.TrimLeft( TrimChars );
            csRight.TrimRight( TrimChars );

            if( csLeft.IsEmpty() && csRight.IsEmpty())
            {
                Items.RemoveAt( iItmIndx-- );
                --iItmCnt;
            }
            else if( csLeft.IsEmpty() )
            {
                Items.SetAt( iItmIndx--, csRight );
            }
            else if( csRight.IsEmpty())
            {
                Items.SetAt( iItmIndx--, csLeft );
            }
            else
            {
                Items.SetAt( iItmIndx--, csLeft );
                Items.Add( csRight );
                ++iItmCnt;
            }
        }
    }
    return true;
}

bool CScriptEngine::Replace( CString& Value, CString& ValueToFind, CString& ValueToReplace )
{
	while( Value.Replace( ValueToFind, ValueToReplace ) > 0 );
	return true;
}

bool CScriptEngine::ProcessPathString( CString& Value, bool RemoveEdgeSlashes )
{
	Replace( Value, CSTR("/"), CSTR("\\"));
	Replace( Value, CSTR( "\\\\" ), CSTR( "\\" ));
    Value.TrimLeft( T( " " ));
	Value.TrimRight( T( " " ));
    if( RemoveEdgeSlashes )
    {
        if( Value == T("\\") ) return true;
	    Value.TrimLeft( T( "\\" ));
	    Value.TrimRight( T( "\\" ));
    }
	return true;
}

bool CScriptEngine::AddOrRemoveSubItems( CStringArray& Values, CStringArray& SubItems, CString& TrimChars,
										 bool bRemove )
{
    int nSubItemCount = SubItems.GetSize();
    int nSubItemIndx = 0;

    for( nSubItemIndx = 0; nSubItemIndx < nSubItemCount; ++ nSubItemIndx )
    {
        CString csSubItem = SubItems.GetAt( nSubItemIndx );
        //csSubItem.TrimLeft();
        //csSubItem.TrimRight();
        CString csSubItemLower = csSubItem;
        csSubItemLower.MakeLower();
        if( !ReplaceEnvVars( csSubItemLower, true ));// return false;
        csSubItemLower.TrimLeft(TrimChars);
        csSubItemLower.TrimRight(TrimChars);

        if( csSubItemLower.IsEmpty()) continue;

        bool bLeftWildChar = 0 == csSubItemLower.Left( 1 ).Compare( T( "*" ));
        bool bRightWildChar = 0 == csSubItemLower.Right( 1 ).Compare( T( "*" ));

		if( !bRemove && ( bLeftWildChar || bRightWildChar )) return false;

        if( bLeftWildChar ) csSubItemLower = csSubItemLower.Right( csSubItemLower.GetLength() - 1 );
        if( bRightWildChar ) csSubItemLower = csSubItemLower.Left( csSubItemLower.GetLength() - 1 );

		csSubItemLower.TrimLeft(TrimChars);
        csSubItemLower.TrimRight(TrimChars);

        int iItmIndx = 0;
        int iItmCnt = Values.GetSize();
		bool bMainStringFound = false;
        for( iItmIndx = 0; iItmIndx < iItmCnt; ++iItmIndx )
        {
            CString csItem = Values.GetAt( iItmIndx );
            csItem.TrimLeft(TrimChars);
            csItem.TrimRight(TrimChars);
            CString csItemLower = csItem;
            csItemLower.MakeLower();

            if( !ReplaceEnvVars( csItemLower, true ));// return false;

			ProcessPathString( csSubItemLower, true );
			ProcessPathString( csItemLower, true );
			
            bool bStringFound = false;
            if( bLeftWildChar && bRightWildChar )
            {
                bStringFound = csItemLower.Find( csSubItemLower ) >= 0;
            }
            else if( bLeftWildChar )
            {
                CString csTmp = csItemLower.Right( csSubItemLower.GetLength());
                bStringFound = csTmp.CompareNoCase( csSubItemLower ) == 0;
            }
            else if( bRightWildChar )
            {
                CString csTmp = csItemLower.Left( csSubItemLower.GetLength());
                bStringFound = csTmp.CompareNoCase( csSubItemLower ) == 0;
            }
            else
            {
                bStringFound = csItemLower.CompareNoCase( csSubItemLower ) == 0;
            }
            if( bStringFound ) 
            {
                if( bRemove )
                {
                    Values.RemoveAt( iItmIndx-- );
                    iItmCnt--;
                    continue;
                }
                else
                {
					bMainStringFound = true;
                    break;
                }
            }
        }
		if( !bMainStringFound && !bRemove )
		{
			Values.Add( csSubItem );
		}
    }
    return true;
}

bool CScriptEngine::ConcatItems( CStringArray& Values, CString& Seperator, CString& FinalString )
{
    int nIdx = 0;
    int nLen = Values.GetSize();
    FinalString.Empty();
    bool bSepAdded = false;
    for( nIdx = 0; nIdx < nLen; ++nIdx )
    {
        CString csItem = Values.GetAt( nIdx );
        csItem.TrimLeft();
        csItem.TrimRight();
        if( !csItem.IsEmpty())
        {
            FinalString += csItem + Seperator;
            bSepAdded = true;
        }
    }
    if( bSepAdded ) FinalString = FinalString.Left( FinalString.GetLength() - Seperator.GetLength());
    return true;
}


bool CScriptEngine::ProcessREGStatement( CString& RegKeys, bool IsRegister )
{
	RegKeys.TrimLeft();
	CString csLeft, csRight, csRegKey;
	if( !FindEnvolopedSubItemFrom( RegKeys, CString(ARG_REGKEY_START), CString(ARG_REGKEY_END), csRegKey, csLeft, csRight ))
		return false;
	csLeft.TrimRight();
	csLeft.TrimLeft();
	csRegKey.TrimLeft();
	csRegKey.TrimRight();
    if(!ReplaceEnvVars( csRegKey, true )) return false;
	if( !csLeft.IsEmpty() || csRegKey.IsEmpty()) return false;
	CStringArray Seps, Values;
	Seps.Add( T( "\n" ));
	CString csTrimChar( T( " /\\" ));
	if(!SeperateItems( csRight, Seps, csTrimChar, Values )) return false;
    Seps.RemoveAll();
    Seps.Add( T( "=" ));
    if(!ArrangeMutliLineCommands( Values, Seps )) return false;
	if(!AddToRegVariableMap( csRegKey, IsRegister )) return false;
	LOG( CSTR( "Key:") + csRegKey );	
	int nNameValueIdx = 0;
	int nNameValueCnt = Values.GetSize();
	bool bIsScriptVar;

	for( nNameValueIdx = 0; nNameValueIdx < nNameValueCnt; ++nNameValueIdx )
	{
		CString csNameValue = Values.GetAt( nNameValueIdx );
		CString csName, csValue;
		if( IsRegister )
		{
			if( !ProcessNameValuePairDefn( csNameValue, csName, csValue, bIsScriptVar, csRegKey, true))
				return false;
		}
		else
		{
			if( !ProcessKeyValuePair( csNameValue, csValue, bIsScriptVar, false )) return false;
			csName = csNameValue;
		}
		if( !ReplaceEnvVars( csName, true )) return false;
		LOG( CSTR( "ValueName:") + csName );	
		KeyValueDefn_t NameValue( csName, true, csValue );
		if( !AddToRegVariableMap( csRegKey, IsRegister, &NameValue )) return false;		
	}
	return true;
}

bool CScriptEngine::FindRegKeyValueName( CString& Key, CString& ValueName, CString& Value, bool LookUpLocalMap )
{	
	CString csKeyPathLower = Key;
	ProcessPathString( csKeyPathLower );
	csKeyPathLower.MakeLower();
	
	CString csValueNameLower = ValueName;
	csValueNameLower.TrimLeft(), csValueNameLower.TrimRight();
	csValueNameLower.MakeLower();

	RegKeyValueDefn_t RegKeyVal;
	if( LookUpLocalMap&& TRUE == m_RegVariables.Lookup( csKeyPathLower, RegKeyVal ))
	{	
		KeyValueDefn_t ValueName;
		if( TRUE == RegKeyVal.VALUE_NAMES.Lookup( csValueNameLower, ValueName ) && ValueName.IS_SET )
		{
			Value = ValueName.VAL;
			return true;
		}
	}

	CString csRoot, csSubKey;
	int nSlashIdx = csKeyPathLower.FindOneOf(T( "/\\"));
	if( nSlashIdx >= 0 )
	{
		csRoot = csKeyPathLower.Left( nSlashIdx );
		csSubKey = csKeyPathLower.Mid( nSlashIdx + 1 );
	}
	
	HKEY hRoot = HKEY_CURRENT_USER;
	if( !FindRegistryRoot( csRoot, hRoot )) return false;

	CRegKey RegKey;
	if( ERROR_SUCCESS != RegKey.Open( hRoot, csSubKey )) return false;
	bool bSucc = GetRegValue( RegKey, csValueNameLower, Value );
	RegKey.Close();
	return bSucc;
}

bool CScriptEngine::GetRegValue( CRegKey& Key, CString& ValueName, CString& Value )
{
	Value.Empty();
	DWORD dwBufLen = 32767;
	TCHAR temp[ 32767 ];
	if( ERROR_SUCCESS != Key.QueryValue( temp, ValueName, &dwBufLen )) return false;
	temp[ dwBufLen ] = T( '\0' );
	Value = temp;
	return true;
}

bool CScriptEngine::FindRegistryRoot( CString& Root, HKEY& HRoot )
{
	Root.TrimLeft();
	Root.TrimRight();
	if( 0== Root.CompareNoCase( T( "HKEY_CLASSES_ROOT" ))) 
	{
		HRoot = HKEY_CLASSES_ROOT;
		return true;
	}
	if( 0== Root.CompareNoCase( T( "HKEY_CURRENT_USER" ))) 
	{
		HRoot = HKEY_CURRENT_USER;
		return true;
	}
	if( 0== Root.CompareNoCase( T( "HKEY_LOCAL_MACHINE" ))) 
	{
		HRoot = HKEY_LOCAL_MACHINE;
		return true;
	}
	if( 0== Root.CompareNoCase( T( "HKEY_USERS" ))) 
	{
		HRoot = HKEY_USERS;
		return true;
	}
	if( 0== Root.CompareNoCase( T( "HKEY_CURRENT_CONFIG" ))) 
	{
		HRoot = HKEY_CURRENT_CONFIG;
		return true;
	}
	return false;
}

bool CScriptEngine::AddToRegVariableMap( CString& KeyPath, bool IsRegister, KeyValueDefn_t* NameValuePair )
{
	CString csKeyPath = KeyPath;
	ProcessPathString( csKeyPath );
	CString csKeyPathLower = csKeyPath;
	csKeyPathLower.MakeLower();
	
	RegKeyValueDefn_t RegKeyVal;
	if( FALSE == m_RegVariables.Lookup( csKeyPathLower, RegKeyVal ))
	{
		RegKeyVal.KEY_PATH = csKeyPath;		
	}
	RegKeyVal.IS_SET = IsRegister;	

	if( !NameValuePair )
    {
        m_RegVariables.SetAt( csKeyPathLower, RegKeyVal );
        return true;
    }
	KeyValueDefn_t NameValue = *NameValuePair;
	ProcessPathString( NameValue.VAR );
	NameValue.IS_SET = IsRegister;
	CString csNameLower = NameValue.VAR;
	csNameLower.MakeLower();

	RegKeyVal.VALUE_NAMES.SetAt( csNameLower, NameValue );
	m_RegVariables.SetAt( csKeyPathLower, RegKeyVal );
	
	return true;
}

bool CScriptEngine::ArrangeMutliLineCommands( CStringArray& Commands, CStringArray& Operators )
{
    if( Commands.GetSize() <= 0 || Operators.GetSize() <= 0 ) return true;

    int nOprIdx = 0, nOprCnt = Operators.GetSize();
    int nCmdIdx = 0, nCmdCnt = Commands.GetSize();

    for( nOprIdx = 0; nOprIdx < nOprCnt; ++nOprIdx )
    {
        CString csOptr = Operators.GetAt( nOprIdx );
        csOptr.MakeLower();
        for( nCmdIdx = 0; nCmdIdx < nCmdCnt; ++nCmdIdx )
        {
            CString csCmd = Commands.GetAt( nCmdIdx );
            CString csCmdLower = csCmd;
            csCmdLower.MakeLower();
            if( csCmdLower.Find( csOptr ) >= 0 ) continue;
            if( nCmdIdx == 0 ) return false;
            CString csPrevCommand = Commands.GetAt( nCmdIdx - 1 );
            csPrevCommand += csCmd;
            Commands.SetAt( nCmdIdx - 1, csPrevCommand );
            Commands.RemoveAt( nCmdIdx-- );
            nCmdCnt--;
        }
    }
    return true;
}

bool CScriptEngine::ProcessWaitStatement( CString& Args )
{
	CString csMsg = Args;
    if( !ReplaceEnvVars( csMsg, true, false )) return false;
    LOG( CSTR( "MSG STRING:") + csMsg );	

    return CCommandRunner::Wait( csMsg );
}

bool CScriptEngine::ProcessRunStatement( CString& Args, bool IsWait )
{
    CString csCmdLine= Args;
    if( !ReplaceEnvVars( csCmdLine, true, false ))return false;
    LOG( CSTR( "COMMAND STRING:") + csCmdLine );	
    if( !CCommandRunner::Run( *this, csCmdLine, false )) return false;
    if( IsWait ) return CCommandRunner::Wait( CSTR( "" )); else return true;
}

bool CScriptEngine::ProcessEnvVarCommit( CString& Args )
{
    return CCommandRunner::SetEnvironment( *this );
}

bool CScriptEngine::ProcessRegistryCommit( CString& Args )
{
	return CCommandRunner::SetRegistry( *this );
}

bool CScriptEngine::ProcessIncludeStatement( CString& FileArgs )
{
    return ExecuteScriptFile( FileArgs, CString(T( "" )));
}

bool CScriptEngine::ExecuteScriptFile( CString& FileArg, CString& EnvVars )
{
    CScriptParser objScriptParser;

    CString csFileArgs = FileArg;
    if(!ReplaceEnvVars( csFileArgs, true )) return false;
    
    while( csFileArgs.Replace( T("\""), T("")));
    
    if(!objScriptParser.ParseScriptFile( csFileArgs, EnvVars )) return false;
    
    int nIndex = 0;
    int nInsCount = objScriptParser.GetLength();

    LOG( CSTR( "----------------SCRIPT BEGIN-----------:") + csFileArgs );
    if(!PrepareExecutionStart()) return false;
    for( nIndex = 0; nIndex < nInsCount; ++nIndex )
    {
        Instructon_t inst = objScriptParser[ nIndex ];
		LOG( CSTR( "----------------START Instruction-----------"));
        if( PreExecuteCommand( inst.OP_CODE, inst.OP_ARG ))
            if( ExecuteCommand( inst.OP_CODE, inst.OP_ARG ))
                if( PostExecuteCommand( inst.OP_CODE, inst.OP_ARG ))
				{
					LOG( CSTR( "----------------END Instruction-----------"));
                    continue;
				}
                
        if( m_bReturn )
        {
            m_bReturn = false;
            LOG( CSTR( "----------------SCRIPT END-----------:") + csFileArgs );
            return true;
        }

		if( !m_bExitSet )
        {
            LOG( CSTR( "----------------SCRIPT ERROR-----------"));
            return false;
        }
        break;
    }
    if( !m_bExitSet ) if(!PrepareExecutionEnd()) return false;
	LOG( CSTR( "----------------SCRIPT END-----------:" ) + csFileArgs );
    return true;
}