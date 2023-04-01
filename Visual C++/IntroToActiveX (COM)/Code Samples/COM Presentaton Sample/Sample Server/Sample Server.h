/* this ALWAYS GENERATED file contains the definitions for the interfaces */


/* File created by MIDL compiler version 5.01.0164 */
/* at Mon May 25 13:36:16 2009
 */
/* Compiler settings for H:\UL-PIMS\DOCs PPTs\COM Seminar\Code Samples\COM Presentaton Sample\Sample Server\Sample Server.idl:
    Oicf (OptLev=i2), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __Sample_Server_h__
#define __Sample_Server_h__

#ifdef __cplusplus
extern "C"{
#endif 

/* Forward Declarations */ 

#ifndef __ICallBackReply_FWD_DEFINED__
#define __ICallBackReply_FWD_DEFINED__
typedef interface ICallBackReply ICallBackReply;
#endif 	/* __ICallBackReply_FWD_DEFINED__ */


#ifndef __IFun_FWD_DEFINED__
#define __IFun_FWD_DEFINED__
typedef interface IFun IFun;
#endif 	/* __IFun_FWD_DEFINED__ */


#ifndef __Fun_FWD_DEFINED__
#define __Fun_FWD_DEFINED__

#ifdef __cplusplus
typedef class Fun Fun;
#else
typedef struct Fun Fun;
#endif /* __cplusplus */

#endif 	/* __Fun_FWD_DEFINED__ */


#ifndef __CallBackReply_FWD_DEFINED__
#define __CallBackReply_FWD_DEFINED__

#ifdef __cplusplus
typedef class CallBackReply CallBackReply;
#else
typedef struct CallBackReply CallBackReply;
#endif /* __cplusplus */

#endif 	/* __CallBackReply_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

void __RPC_FAR * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void __RPC_FAR * ); 

#ifndef __ICallBackReply_INTERFACE_DEFINED__
#define __ICallBackReply_INTERFACE_DEFINED__

/* interface ICallBackReply */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_ICallBackReply;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("619E413C-4829-4E97-BAC6-FFB76ADBD034")
    ICallBackReply : public IDispatch
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE OnReply( 
            /* [in] */ BSTR bstr,
            /* [out] */ BSTR __RPC_FAR *P) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ICallBackReplyVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            ICallBackReply __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            ICallBackReply __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            ICallBackReply __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            ICallBackReply __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            ICallBackReply __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            ICallBackReply __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            ICallBackReply __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *OnReply )( 
            ICallBackReply __RPC_FAR * This,
            /* [in] */ BSTR bstr,
            /* [out] */ BSTR __RPC_FAR *P);
        
        END_INTERFACE
    } ICallBackReplyVtbl;

    interface ICallBackReply
    {
        CONST_VTBL struct ICallBackReplyVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ICallBackReply_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define ICallBackReply_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define ICallBackReply_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define ICallBackReply_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define ICallBackReply_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define ICallBackReply_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define ICallBackReply_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define ICallBackReply_OnReply(This,bstr,P)	\
    (This)->lpVtbl -> OnReply(This,bstr,P)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ICallBackReply_OnReply_Proxy( 
    ICallBackReply __RPC_FAR * This,
    /* [in] */ BSTR bstr,
    /* [out] */ BSTR __RPC_FAR *P);


void __RPC_STUB ICallBackReply_OnReply_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __ICallBackReply_INTERFACE_DEFINED__ */


#ifndef __IFun_INTERFACE_DEFINED__
#define __IFun_INTERFACE_DEFINED__

/* interface IFun */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IFun;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("2FCDA75A-43A1-4349-8037-3B89BE1B62C3")
    IFun : public IDispatch
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE SayHello( 
            /* [in] */ BSTR bstrSTR) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE InvokeCallBack( 
            /* [in] */ ICallBackReply __RPC_FAR *pCallBack) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IFunVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            IFun __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            IFun __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            IFun __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            IFun __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            IFun __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            IFun __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            IFun __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SayHello )( 
            IFun __RPC_FAR * This,
            /* [in] */ BSTR bstrSTR);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *InvokeCallBack )( 
            IFun __RPC_FAR * This,
            /* [in] */ ICallBackReply __RPC_FAR *pCallBack);
        
        END_INTERFACE
    } IFunVtbl;

    interface IFun
    {
        CONST_VTBL struct IFunVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IFun_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IFun_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IFun_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IFun_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IFun_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IFun_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IFun_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define IFun_SayHello(This,bstrSTR)	\
    (This)->lpVtbl -> SayHello(This,bstrSTR)

#define IFun_InvokeCallBack(This,pCallBack)	\
    (This)->lpVtbl -> InvokeCallBack(This,pCallBack)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IFun_SayHello_Proxy( 
    IFun __RPC_FAR * This,
    /* [in] */ BSTR bstrSTR);


void __RPC_STUB IFun_SayHello_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IFun_InvokeCallBack_Proxy( 
    IFun __RPC_FAR * This,
    /* [in] */ ICallBackReply __RPC_FAR *pCallBack);


void __RPC_STUB IFun_InvokeCallBack_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IFun_INTERFACE_DEFINED__ */



#ifndef __SAMPLESERVERLib_LIBRARY_DEFINED__
#define __SAMPLESERVERLib_LIBRARY_DEFINED__

/* library SAMPLESERVERLib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_SAMPLESERVERLib;

EXTERN_C const CLSID CLSID_Fun;

#ifdef __cplusplus

class DECLSPEC_UUID("32C2E095-ACD6-454D-8332-0DCB8790263C")
Fun;
#endif

EXTERN_C const CLSID CLSID_CallBackReply;

#ifdef __cplusplus

class DECLSPEC_UUID("6E585F10-E1EB-451A-94DA-4F460080DB46")
CallBackReply;
#endif
#endif /* __SAMPLESERVERLib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long __RPC_FAR *, unsigned long            , BSTR __RPC_FAR * ); 
unsigned char __RPC_FAR * __RPC_USER  BSTR_UserMarshal(  unsigned long __RPC_FAR *, unsigned char __RPC_FAR *, BSTR __RPC_FAR * ); 
unsigned char __RPC_FAR * __RPC_USER  BSTR_UserUnmarshal(unsigned long __RPC_FAR *, unsigned char __RPC_FAR *, BSTR __RPC_FAR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long __RPC_FAR *, BSTR __RPC_FAR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif
