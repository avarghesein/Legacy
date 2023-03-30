

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
    CThreadPool();
    virtual ~CThreadPool();

    // Initializes the thread pool, to accept jobs 
    virtual bool InitializeThreadPool( int nThreadPoolSize_i, int nJobQueueSize_i );
    // Adds a new job item to the thread pool's job queue
    virtual bool EnQueue( THREAD_POOL_JOB_ITEM JobItem_io );
    // Stops all the worker threads running and resetes the thread pool
    // Any job item thats not processed will be lost
    virtual bool StopThreadPool( void );
    // Checks for empty slots available in job queue
    virtual bool IsRoomAvailableInJobQueue( bool& bThreadPoolNotInitialized );

protected:
    // Create the worker threads
    bool CreatThreadPoolAndJobQueue();
    // Supportive function for the worker threads, used to remove the job item from
    // the job queue for processing
    virtual bool DQueue( THREAD_POOL_JOB_ITEM& JobItem_o );
    // This is the actual thread function, executed by the worker threads
    static DWORD CommonWorkerProc( LPVOID pThreadParam_i );

protected:
    // Specifies the Job Queue size
    int m_nJobQueueSize;
    // Specifies the number of the worker threads in the pool
    int m_nThreadPoolSize;
    // The Job Queue
    CList<THREAD_POOL_JOB_ITEM,THREAD_POOL_JOB_ITEM&> m_JobQueueArray;
    // List of worker threads
    CList<HANDLE,HANDLE&> m_hWorkerThreadArray;
    // Event to gracefully control the running and shutdown of worker threads
    HANDLE m_hStopThreadPoolEvt;
    // Event to notify the worker threads, whether any job item is available in the job queue, or its empty
    HANDLE m_hJobsInQueueEvt;
    // MuteX object to synchronize the access to the job queue 
    CMutex* m_pJobQueueSynchronizer;
};

#endif 
