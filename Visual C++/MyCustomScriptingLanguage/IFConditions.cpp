// IFConditions.cpp: implementation of the CIFConditions class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "IFConditions.h"


CIFConditions::CIFConditions() : m_bActiveValue( true ), m_bIsLastElse( false ) { }

// Returns Active Value
bool CIFConditions::IF( bool ExpressionValue )
{
    m_bIsLastElse = false;
    return m_IFStatements.Push( m_bActiveValue &= ExpressionValue );
}

// Returns Success/Failure
bool CIFConditions::EndIF( bool& ActiveValue )
{
    if( m_IFStatements.StackEmpty()) return false;
    
    m_IFStatements.Pop();
    m_bIsLastElse = false;

    if( m_IFStatements.StackEmpty())
        m_bActiveValue = true; 
    else
        m_IFStatements.StackTop( m_bActiveValue );

    ActiveValue = m_bActiveValue;
    return true;
}

// Return Success/Failure
bool CIFConditions::ELSE( bool& ActiveValue )
{
    if( m_bIsLastElse || m_IFStatements.StackEmpty()) return false;

    m_bIsLastElse = true;
    m_IFStatements.Pop( m_bActiveValue );

    m_bActiveValue = !m_bActiveValue;

    if( m_IFStatements.StackEmpty())
        m_bActiveValue &= true;
    else
    {
        bool bStackTop;
        m_IFStatements.StackTop( bStackTop );
        m_bActiveValue &= bStackTop;
    }
	ActiveValue = m_IFStatements.Push( m_bActiveValue );
    return true;
}

// Returns Active Value, True: If no conditions registered
bool CIFConditions::GetActiveValue( void )
{
    return m_bActiveValue;
}




















