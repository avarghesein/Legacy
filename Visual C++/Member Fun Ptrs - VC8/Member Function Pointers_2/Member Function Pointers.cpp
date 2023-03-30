// Member Function Pointers.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

//#pragma pointers_to_members( full_generality, multiple_inheritance )


typedef void(Base::*BASEPTR)(void);

class Base
{
};
class Dervied : public Base
{

public:

    void Fun1( float x )
    {
        AfxMessageBox("Hai");
    }
};



int main(int argc, char* argv[])
{

    Dervied objDerived;

    BASEPTR baseFunPtr = (BASEPTR)&Dervied::Fun1;
    Base *baseObj = &objDerived;

    (baseObj->*baseFunPtr)();

	return 0;
}

