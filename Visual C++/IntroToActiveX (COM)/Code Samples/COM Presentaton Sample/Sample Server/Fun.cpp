// Fun.cpp : Implementation of Fun
#include "stdafx.h"
#include "Sample Server.h"
#include "Fun.h"

/////////////////////////////////////////////////////////////////////////////
// Fun


STDMETHODIMP Fun::SayHello(BSTR bstrSTR)
{
	AfxMessageBox( CString( bstrSTR ).operator LPCTSTR());

	return S_OK;
}

STDMETHODIMP Fun::InvokeCallBack(ICallBackReply *pCallBack)
{
    BSTR p = 0;
	pCallBack->OnReply( CString( "Hai From Callback").AllocSysString(), &p);    
    AfxMessageBox( CString(p));
	return S_OK;
}
