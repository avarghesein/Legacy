// CallBackReply.h : Declaration of the CallBackReply

#ifndef __CALLBACKREPLY_H_
#define __CALLBACKREPLY_H_

class CallBackHandler
{
public:

	virtual void OnReply( BSTR bstr ) = 0;
};


/////////////////////////////////////////////////////////////////////////////
// CallBackReply
class ATL_NO_VTABLE CallBackReply : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CallBackReply, &CLSID_CallBackReply>,
	public IDispatchImpl<ICallBackReply, &IID_ICallBackReply, &LIBID_SAMPLESERVERLib>
{
public:
	CallBackReply()
	{
	}

DECLARE_PROTECT_FINAL_CONSTRUCT()

BEGIN_COM_MAP(CallBackReply)
	COM_INTERFACE_ENTRY(ICallBackReply)
	COM_INTERFACE_ENTRY(IDispatch)
END_COM_MAP()

// ICallBackReply
public:	
	STDMETHOD(OnReply)(/*[in]*/BSTR bstr);

	static ICallBackReply* GetCallback( CallBackHandler* pCallbackHandler_i );
	void SetCallbackHandler( CallBackHandler* const pCallbackHandler_i )
	{
		m_ReplyPtr = pCallbackHandler_i;
	}

private:
	CallBackHandler* m_ReplyPtr;
};

#endif //__CALLBACKREPLY_H_
