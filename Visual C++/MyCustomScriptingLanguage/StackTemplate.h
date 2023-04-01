
#if !defined(STACK_TEMPLATE_INCLUDED_)
#define STACK_TEMPLATE_INCLUDED_

template<class STACK_TYPE = bool, class ARG_TYPE = bool>
class CStack  
{
public:

	//Returns Updated Stacktop value
	ARG_TYPE Push( ARG_TYPE Value );

	//Returns Success or Failure
    bool Pop( STACK_TYPE& Value);

	//Returns Success or Failure
    bool Pop( void );

	//Returns Success or Failure
    bool UpdateStackTop( ARG_TYPE Value );

	//Returns Success or Failure
    bool StackTop( STACK_TYPE& Value);

	//Returns Success or Failure
    bool StackTopIfPop( STACK_TYPE& Value);

	//Returns true/false
    bool StackEmpty();

private:
    bool StackElementAt( int ItemAt, STACK_TYPE& Value );
    
private:
    CArray<STACK_TYPE,ARG_TYPE> m_Stack;
};

#endif
