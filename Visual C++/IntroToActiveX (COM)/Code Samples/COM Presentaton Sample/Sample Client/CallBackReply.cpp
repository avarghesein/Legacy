
#include "stdafx.h"
#include "CallBackReply.h"


CComModule _Module;


STDMETHODIMP CallBackReply::OnReply(BSTR bstr,BSTR* p)
{
	if( 0 != m_ReplyPtr )
	{
	  m_ReplyPtr->OnReply( bstr );
      *p = CString("allocating").AllocSysString();
	}
	return S_OK;
}

ICallBackReply* CallBackReply::GetCallback( CallBackHandler* pCallbackHandler_i )
{
	CComObject<CallBackReply>* pCallback = 0;
	HRESULT hRes = CComObject<CallBackReply>::CreateInstance( &pCallback );
	ICallBackReply* pCallbackReturn = 0;
   	if(SUCCEEDED( hRes ))
	{
		hRes = pCallback->QueryInterface(IID_ICallBackReply, reinterpret_cast<void**>( & pCallbackReturn ));
		pCallback->SetCallbackHandler( pCallbackHandler_i );
	}
	return pCallbackReturn;
}
