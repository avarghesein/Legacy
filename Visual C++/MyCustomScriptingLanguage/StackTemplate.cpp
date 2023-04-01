
#include "stdafx.h"
#include "StackTemplate.h"


template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::StackEmpty()
{
    return ( m_Stack.GetSize() <= 0 );
}

template<class STACK_TYPE, class ARG_TYPE>
ARG_TYPE CStack<STACK_TYPE,ARG_TYPE>::Push( ARG_TYPE Value )
{
    m_Stack.InsertAt( 0, Value );
	return Value;
}

template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::UpdateStackTop( ARG_TYPE Value )
{
    if( StackEmpty()) return false;
    m_Stack.SetAt( 0, Value );
	return true;
}

template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::Pop( STACK_TYPE& Value)
{
    if( !StackElementAt( 0, Value )) return false;
    m_Stack.RemoveAt( 0 );
    return true;
}

template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::Pop( void )
{
    STACK_TYPE Value;
    return Pop( Value );
}

template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::StackTop( STACK_TYPE& Value)
{
    return StackElementAt( 0, Value );
}

template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::StackTopIfPop( STACK_TYPE& Value)
{
    return StackElementAt( 1, Value );
}

template<class STACK_TYPE, class ARG_TYPE>
bool CStack<STACK_TYPE,ARG_TYPE>::StackElementAt( int ItemAt, STACK_TYPE& Value )
{
    if( m_Stack.GetSize() <= ItemAt ) return false;
    Value = m_Stack.GetAt( ItemAt );
    return true;
}