
// ThreadPoolEx.cpp: implementation of the CThreadPoolEx class.

#include "stdafx.h"
#include "ThreadPoolEx.h"

CThreadPoolEx::CThreadPoolEx( void ) : CThreadPool(), m_lJobsInQueue( 0 )
{ }

CThreadPoolEx::~CThreadPoolEx()
{ }

bool CThreadPoolEx::StopThreadPool( void )
{
    // If we are able to get the base class version of this method a success
    // DeInitialize the number of jobs to 0
    if( CThreadPool::StopThreadPool())
    {
        m_lJobsInQueue = 0;
        return true;
    }
    return false;
}

bool CThreadPoolEx::CleanUpJobItem( THREAD_POOL_JOB_ITEM* pJobItem_i )
{
    // On a successful Cleanup, of a job item, Decrement the Number of Jobs counter by 1
    // As we taken and processed this job item from the job queue
    if( CThreadPool::CleanUpJobItem( pJobItem_i ))
    {
        InterlockedDecrement( &m_lJobsInQueue );
        return true;
    }
    return false;
}

bool CThreadPoolEx::CreateThreadPool( void )
{
    DWORD dwThreadID = 0;
    // On this extended version of thread pool create only a single thread on startup
    // On coming job requests, we will create additional threads only if needed
    HANDLE hThread = CreateThread( 0, 0, &CThreadPool::WorkerThreadProcedure, (LPVOID)this, 0, &dwThreadID );
    m_hWorkerThreadArray.AddTail( hThread );
    // Specify that there is no jobs in the job queue
    m_lJobsInQueue = 0;
    return true;
}


bool CThreadPoolEx::EnQueue( THREAD_POOL_JOB_ITEM JobItem_io )
{
    // If we are in the middle of stopping the thread pool? or we still dont
    // Initialized our thread pool? in those cases exit with failure
    if( m_bExitThread || 0 == m_hIoCompletionPort || 0 == m_pJobQueueSynchronizer )
    {
        return false;
    }
    // Adding job to the queue can wait for indefinitely
    if( FALSE == m_pJobQueueSynchronizer->Lock( /*10000*/ ))
    {
        return false;
    }
    int nThreadCount = m_hWorkerThreadArray.GetCount();
    // If we have waiting jobs in the job queue, means all the threads will be busy. And
    // We dont created the maximum no of threads allowed in the pool, then create and add
    // a new thread into the thread pool to process the request. On the other hand if we have
    // 0 Jobs in the job queue, we wont create an additional thread, since already existing threads
    // in the thread pool are free to take the this new Job Item
    if( 0 != m_lJobsInQueue && nThreadCount < m_nThreadPoolSize )
    {
        DWORD dwThreadID = 0;
        HANDLE hThread = CreateThread( 0, 0, &CThreadPool::WorkerThreadProcedure, (LPVOID)this, 0, &dwThreadID );
        if ( hThread )
        {
            m_hWorkerThreadArray.AddTail( hThread );
        }
    }
    // Post the job request to the IO completion port, so that it will be added to its
    // internal queue, where the OVERLAPPED pointer is specified as FALSE, specifying
    // that this is a Job request, not a Thread Exit Request
    if( FALSE == PostQueuedCompletionStatus( m_hIoCompletionPort, 0,
                                            (ULONG_PTR)new THREAD_POOL_JOB_ITEM( JobItem_io ),
                                            (LPOVERLAPPED)FALSE ))
    {
        m_pJobQueueSynchronizer->Unlock();
        return false;
    }
    // Increment the No Of Jobs in the queue counter as we added a new job item into the queue
    InterlockedIncrement( &m_lJobsInQueue );
    // Unlock the job queue synchronizer
    m_pJobQueueSynchronizer->Unlock();
    return true;
}
