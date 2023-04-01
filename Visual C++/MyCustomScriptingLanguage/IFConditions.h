
#if !defined(IFCONDITIONS_INCLUDED_)
#define IFCONDITIONS_INCLUDED_

#include "StackTemplate.CPP"

class CIFConditions  
{
public:
	
	// Returns Active Value
	bool IF( bool ExpressionValue );

	// Returns Success/Failure
    bool ELSE( bool& ActiveValue );

	// Returns Success/Failure
    bool EndIF( bool& ActiveValue );

	// Returns Active Value, True: If no conditions registered
    bool GetActiveValue( void );

public:
    CIFConditions( void );
	
private:
    CStack<bool,bool> m_IFStatements;
    bool m_bActiveValue;
    bool m_bIsLastElse;
};

#endif
