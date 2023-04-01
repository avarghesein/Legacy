// ClientCallBackHandler.cpp: implementation of the CClientCallBackHandler class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Sample Client.h"
#include "ClientCallBackHandler.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CClientCallBackHandler::CClientCallBackHandler()
{

}

CClientCallBackHandler::~CClientCallBackHandler()
{

}

void CClientCallBackHandler::OnReply( BSTR bstr )
{
    AfxMessageBox( CString(bstr) );
}