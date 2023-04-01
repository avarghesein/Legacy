
#if !defined( THREAD_POOL_STRUCTS_INCLUDED )
#define THREAD_POOL_STRUCTS_INCLUDED

// Function prototype of the worker function to be supported at the client side
typedef void ( WINAPI *WORKER_CALLBACK_PROTOTYPE )( LPVOID pDataIn_i, LPVOID& pDataOut_o );
// Function prototype of the result call back function  to be supported the client side
typedef void ( WINAPI *RESULT_CALLBACK_PROTOTYPE )( LPVOID pDataIn_i );

// The Actual Job Item in the Job Queue
typedef struct _THREAD_POOL_JOB_ITEM
{

public:
    // This is the input data for the job supplied by the client
    LPVOID pJobInput;
    // This is the worker function at the client side
    // [Pointer to a function at the client side]
    WORKER_CALLBACK_PROTOTYPE pWorkerFunctionCallBack;
    // This is the call back function at the client side, that will be called once the processing is over
    // and the resultant data available and ready to be handed over to the client
    // [Pointer to a function at the client side]
    RESULT_CALLBACK_PROTOTYPE pResultCallback;
    
public:

    // Initialize the members on object creation
    _THREAD_POOL_JOB_ITEM()
    {
        pJobInput = 0;
        pWorkerFunctionCallBack = 0;
        pResultCallback = 0;
    }
}
THREAD_POOL_JOB_ITEM;

#endif