

#if !defined(AFX_CLIENTCALLBACKHANDLER_H__INCLUDED_)
#define AFX_CLIENTCALLBACKHANDLER_H__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif

#include "CallBackReply.h"

class CClientCallBackHandler : public CallBackHandler  
{
public:

    void OnReply( BSTR bstr );

	CClientCallBackHandler();
	virtual ~CClientCallBackHandler();

};

#endif 
