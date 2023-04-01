
#if !defined( THREAD_POOL_STRUCTS_INCLUDED )
#define THREAD_POOL_STRUCTS_INCLUDED

#if defined(_WIN64)
 typedef unsigned __int64 ULONG_PTR;
#else
 typedef unsigned long ULONG_PTR;
#endif

// Function prototype of the worker function to be supported at the client side
// [For Non Member functions, i.e. For static or global functions
typedef void ( WINAPI   *WORKER_CALLBACK_PROTOTYPE )( LPVOID pDataIn_i );
// Function prototype of the worker function to be supported at the client side
// [For Class Member Functions that should be invoked using an object]
typedef void ( CObject::*MEMBER_FUNCTION_WORKER_CALLBACK_PROTOTYPE )( LPVOID pDataIn_i );

// The Actual Job Item in the Job Queue
typedef struct _THREAD_POOL_JOB_ITEM
{

public:
    // This is the input data for the job supplied by the client
    LPVOID pJobInput;
    // This is the object on which the 'pMemberWorkerFunctionCallBack', is to be invoked
    // In other words, if 'pMemberWorkerFunctionCallBack' is a valid member function pointer, ie non null
    // This, Will the object on which the function will be invoked. If this object is null
    // We will consider 'pWorkerFunctionCallBack' as a static or global function pointer to be
    // Call backed
    CObject* pObjectToCallBack;
    // Following will be a union, because we will have only one call back
    // Which is either a static/global function pointer or it will be a member
    // Function poiner, both cannot be given at the same time.
    union
    {
        // This is the worker function at the client side
        // [Pointer to a function at the client side]
        MEMBER_FUNCTION_WORKER_CALLBACK_PROTOTYPE pMemberWorkerFunctionCallBack;
        // This is the worker function at the client side
        // [Pointer to a function at the client side]
        WORKER_CALLBACK_PROTOTYPE pWorkerFunctionCallBack;
    };
    
public:

    // Initialize the members on object creation
    _THREAD_POOL_JOB_ITEM()
    {
        pJobInput = 0;
        pObjectToCallBack = 0;
        pMemberWorkerFunctionCallBack = 0;        
        pWorkerFunctionCallBack = 0;
    }
}
THREAD_POOL_JOB_ITEM;


#define CREATE_MEMBER_FUNCTION_CALLBACK( CallBack, JobItem ) \
{ \
    JobItem.pObjectToCallBack = this; \
    JobItem.pMemberWorkerFunctionCallBack = (MEMBER_FUNCTION_WORKER_CALLBACK_PROTOTYPE)&CallBack; \
}

#define CREATE_FUNCTION_CALLBACK( CallBack, JobItem ) \
{ \
    JobItem.pObjectToCallBack = 0; \
    JobItem.pWorkerFunctionCallBack = (WORKER_CALLBACK_PROTOTYPE)&CallBack; \
}

#endif