

#if !defined( THREAD_POOL_HEADER_INCLUDED )
#define THREAD_POOL_HEADER_INCLUDED

#if _MSC_VER > 1000
    #pragma once
#endif // _MSC_VER > 1000

#include <AFXTEMPL.H>
#include <AFXMT.H>
#include "ThreadPoolStructures.h"

// Class declaration for the Thread Pool class.
class CThreadPool  
{
public:
    CThreadPool( void );
    virtual ~CThreadPool();

    // Initializes the thread pool, to accept jobs 
    virtual bool InitializeThreadPool( int nThreadPoolSize_i );
    // Adds a new job item to the thread pool's job queue
    virtual bool EnQueue( THREAD_POOL_JOB_ITEM JobItem_io );
    // Stops all the worker threads running and resetes the thread pool
    // Any job item thats not processed will be lost
    virtual bool StopThreadPool( void );

protected:
    // Create the worker threads
    virtual bool CreateThreadPool( void );    
    // This is the actual thread function, executed by the worker threads
    static DWORD WorkerThreadProcedure( LPVOID pThreadParam_i );
    // Clean Up Job Item
    virtual bool CleanUpJobItem( THREAD_POOL_JOB_ITEM* pJobItem_i );

protected:
    // Specifies the number of the worker threads in the pool
    int m_nThreadPoolSize;
    // List of worker threads
    CList<HANDLE,HANDLE&> m_hWorkerThreadArray;
    // IO completion port, that will manage job queing and minimize the thread context switches
    HANDLE m_hIoCompletionPort;
    // MuteX object to synchronize the access to the job queue 
    CMutex* m_pJobQueueSynchronizer;
    // Variable to specify the worker threads to exit
    volatile bool m_bExitThread;
};

#endif 
