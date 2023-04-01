// Member Fun Ptrs - VC8.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "Member Fun Ptrs - VC8.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// The one and only application object

CWinApp theApp;

using namespace std;

class Base;

typedef void(Base::*PTR)(void);

class Base
{
public:
    virtual PTR GetFunPtr( void )
    {
        return 0;
    }
};


class __multiple_inheritance Dervied : public Base, public CObject/*, public Base, public CRect*/
{
public:
    float i;
    CString cs;
    void Fun( void );
    static PTR p;
    static void(CObject::*Q)(void);

public:
    virtual PTR GetFunPtr( void )
    {
        return p;
    }
};

void Dervied::Fun( void )
{
    //__asm mov ecx, [this];

    ASSERT( 0 != this );
    i += 1;
    ///CString cs;
    cs += _T("Hai");
    
    AfxMessageBox( cs );
}

PTR Dervied::p = (PTR)&Fun;
void(CObject::*(Dervied::Q))(void) = (void(CObject::*)(void))&Fun;

int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	Dervied d;

    CObject *o = &d;
    (o->*(Dervied::Q))();

    Base *b = &d;
    (b->*(b->GetFunPtr()))();

	int nRetCode = 0;

	// initialize MFC and print and error on failure
	if (!AfxWinInit(::GetModuleHandle(NULL), NULL, ::GetCommandLine(), 0))
	{
		// TODO: change error code to suit your needs
		_tprintf(_T("Fatal Error: MFC initialization failed\n"));
		nRetCode = 1;
	}
	else
	{
		// TODO: code your application's behavior here.
	}

	return nRetCode;
}
