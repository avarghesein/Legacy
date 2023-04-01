// Fun.h : Declaration of the Fun

#ifndef __FUN_H_
#define __FUN_H_

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// Fun
class ATL_NO_VTABLE Fun : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<Fun, &CLSID_Fun>,
	public IDispatchImpl<IFun, &IID_IFun, &LIBID_SAMPLESERVERLib>
{
public:
	Fun()
	{
	}

DECLARE_REGISTRY_RESOURCEID(IDR_FUN)

DECLARE_PROTECT_FINAL_CONSTRUCT()

BEGIN_COM_MAP(Fun)
	COM_INTERFACE_ENTRY(IFun)
	COM_INTERFACE_ENTRY(IDispatch)
END_COM_MAP()

// IFun
public:
	STDMETHOD(InvokeCallBack)(/*[in]*/ICallBackReply* pCallBack);
	STDMETHOD(SayHello)(/*[in]*/BSTR bstrSTR);
};

#endif //__FUN_H_
