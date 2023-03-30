// Member Function Pointers.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

//#pragma pointers_to_members( full_generality, multiple_inheritance )

class Base;

typedef void(Base::*PTR)(void);

class Base
{
public:
    virtual PTR GetFunPtr( void ) = 0;
    void Fun1( char x )
    {

    }
};


PTR Base::GetFunPtr( void )
{
    return 0;
}

class Dervied : public Base, public CObject/*, public Base, public CRect*/
{
public:
    float i;
    CString cs;
    void Fun( void );
    static PTR p;
    static void(CObject::*Q)(void);

public:
    PTR GetFunPtr( void )
    {
        return p;
    }
    void Fun1( float x )
    {

    }
};

void Dervied::Fun( void )
{
   // __asm mov eax, [this];

    ASSERT( 0 != this );
    i += 1;
    ///CString cs;
    cs += _T("Hai");
    
    AfxMessageBox( cs );
}

PTR Dervied::p = (PTR)&Fun;
void(CObject::*(Dervied::Q))(void) = (void(CObject::*)(void))&Fun;

int main(int argc, char* argv[])
{
    class AFX_NOVTABLE A
    { 
    public :
        void (A::*H)(int);
        void (A::*P)(void);
        virtual fun( void ) = 0;
        virtual fun( int ) = 0;
        virtual fun1( void ) = 0;
        virtual fun2( void ) = 0;
    };

    class B : public A
    {
    public :
        void (B::*P)(int);
        void (B::*Q)(void);
        fun( void )
        {
        };
        fun( int )
        {
        };
        fun1( void )
        {
        };
        fun2( void )
        {
        };
    };
    class C : public B
    {
    public :
        fun( void )
        {
        };
         fun( int )
        {
        };
    };

    B *t = new C;
    t->fun(3);
    //A h;
    B i;

    int as = sizeof(A);
    int bs = sizeof(B);


    Dervied d;    
     
    Base *b = &d;
    (b->*(b->GetFunPtr()))();

    CObject *o = &d;
    (o->*(Dervied::Q))();


	printf("Hello World!\n");
	return 0;
}

