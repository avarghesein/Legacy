
#if !defined(SCRIPTENGINE_INCLUDED)
#define SCRIPTENGINE_INCLUDED

#include "StdAfx.h"
#include "Structures.h"
#include "IFConditions.h"

class CCommandRunner;

class CScriptEngine : public IScriptEngine  
{
    friend class CCommandRunner;
    
public:
	
    bool ExecuteScriptFile( CString& FileArg, CString& EnvVars );
    bool IsQuitSet( void ) { return m_bExitSet; } ;
    
    virtual bool PrepareExecutionStart( void );
    virtual bool PreExecuteCommand( CString& OP_CODE, CString& OP_ARG );
    virtual bool ExecuteCommand( CString& OP_CODE, CString& OP_ARG );
    virtual bool PostExecuteCommand( CString& OP_CODE, CString& OP_ARG);
    virtual bool PrepareExecutionEnd( void );

    virtual bool InternalPrepareExecutionStart( void );
    virtual bool InternalPreExecuteCommand( CString& OP_CODE, CString& OP_ARG );
    virtual bool InternalExecuteCommand( CString& OP_CODE, CString& OP_ARG );
    virtual bool InternalPostExecuteCommand( CString& OP_CODE, CString& OP_ARG );
    virtual bool InternalPrepareExecutionEnd( void );

    void SetExecutionMode( bool IsSimulation ) {  m_bSimulationMode = IsSimulation; };    

private:

    bool ProcessEnvVarDefn( CString& EnvVar );
    bool ProcessEnvVarCommit( CString& Args );
	bool ProcessEnvVarRemoval( CString& EnvVar );
	bool ProcessIFStatement( CString& EnvVar, bool bApplyNot = false );
	bool ProcessELSEStatement( CString& EnvVar );
	bool ProcessENDIFStatement( CString& EnvVar );
	bool ProcessREGStatement( CString& RegKeys, bool IsRegister = true );
	bool ProcessRegistryCommit( CString& Args );
    bool ProcessWaitStatement( CString& Args );
    bool ProcessQuitStatement( CString& Args );
    bool ProcessReturnStatement( CString& Args );
    bool ProcessRunStatement( CString& Args, bool IsWait = false );
    bool ProcessIncludeStatement( CString& FileArgs );
    bool ProcessChangeDirectory( CString& Args );

private:

    bool ReplaceEnvVars( CString& ValueString, bool bReplaceEnvVar, bool ProcessPath = true );
    bool LookupProcessEnvVar( CString& EnvVar, CString& EnvVal, bool LookUpLocalMap = true );
	bool ProcessKeyValuePair( CString& Key, CString& Value, bool& bIsScriptVar, bool bReplaceEnvVar );
	bool ParseKeyValueToken( CString& String, CString& Seperator, CString& Key, CString& Value );
	bool FindEnvVarValue( CString& Var, CString& Value, bool bDefaultProcessEnvVar = false  );
	bool FindEnvolopedItem( CString& Value, CString& LeftEnvolope, CString& RightEnvolope, CString& Item );
	bool FindEnvolopedSubItemFrom( CString& Value, CString& LeftEnvolope, CString& RightEnvolope,
		                           CString& Item, CString& LeftPart, CString& RightPart );
    bool SeperateItems( CString& Value, CStringArray& Seperators, CString& TrimChars, CStringArray& Items );
    bool AddOrRemoveSubItems( CStringArray& Values, CStringArray& SubItems, CString& TrimChars, bool bRemove );
    bool ConcatItems( CStringArray& Values, CString& Seperator, CString& FinalString );
	bool Replace( CString& Value, CString& ValueToFind, CString& ValueToReplace );
	bool ProcessPathString( CString& Value, bool RemoveEdgeSlashes = false );
	bool AddToRegVariableMap( CString& KeyPath, bool IsRegister = false, KeyValueDefn_t* NameValuePair = NULL );
	bool ProcessNameValuePairDefn( CString& NameValue, CString& Key, CString& Value, bool& IsScriptVar,
		                           CString& RegKeyPath = CString( T( "" )), bool IsForRegNameValue = false);
	bool FindRegKeyValueName( CString& Key, CString& ValueName, CString& Value, bool LookUpLocalMap = true );
	bool FindRegistryRoot( CString& Root, HKEY& HRoot );
	bool GetRegValue( CRegKey& Key, CString& ValueName, CString& Value );
    bool ArrangeMutliLineCommands( CStringArray& Commands, CStringArray& Operators );

private:

	

    CIFConditions m_IFConditions;
    bool m_bStartBeginBlock;

    CMap<CString,LPCTSTR,CString,LPCTSTR> m_ScriptVariables;

    MAP_KEY_VALUE m_EnvVariables;	
	MAP_REG_KEY_VALUE m_RegVariables;

    bool m_bSimulationMode;
    bool m_bExitSet;
    bool m_bReturn;

};

#endif