
// Class implementaion for the Thread Pool class.

#include "stdafx.h"
#include "ThreadPool.h"

CThreadPool::CThreadPool( void ) : m_nThreadPoolSize( 0 ), m_hIoCompletionPort( 0 ),
                                   m_pJobQueueSynchronizer( 0 ), m_bExitThread( false )
{
   // Initialize the members and the arrays
   m_hWorkerThreadArray.RemoveAll();
}

CThreadPool::~CThreadPool()
{
    // Stop the thread pool, if its running
    StopThreadPool();
}

bool CThreadPool::InitializeThreadPool( int nThreadPoolSize_i )
{
    // Stop the thread pool, if its already running.
    StopThreadPool();
    // Exit flag to false, so that all worker threads can run
    m_bExitThread = false;
    // Empty out the worker thread list
    m_hWorkerThreadArray.RemoveAll();
    // Assign the Thread pool size, the maximum number of threads that can be run
    m_nThreadPoolSize = nThreadPoolSize_i;
    // Create the mutex that will synchronize the access to the job queue
    if( 0 == ( m_pJobQueueSynchronizer = new CMutex )) 
    {
        return false;
    }
    if( 0 == ( m_hIoCompletionPort = CreateIoCompletionPort( INVALID_HANDLE_VALUE, 0, 0, 0 )))
    {
        return false;
    }
    // Create the worker threads
    return CreateThreadPool();
}

bool CThreadPool::CreateThreadPool( void )
{
    DWORD dwThreadID = 0;
    HANDLE hThread = 0;
    // Create the worker threads and add it to the worker thread list
    for( int nIndex = 0; nIndex < m_nThreadPoolSize; ++nIndex )
    {
        // Pass the current object as the parameter to the thread call so that, the static thread can
        // access the members of the current CThreadPool object
        hThread = CreateThread( 0, 0, &CThreadPool::WorkerThreadProcedure, (LPVOID)this, 0, &dwThreadID );
        m_hWorkerThreadArray.AddTail( hThread );
    }
    return true;
}

bool CThreadPool::StopThreadPool( void )
{
    // If we already having a thread pool running? [IO completion port is already open?]
    if( 0 != m_hIoCompletionPort )
    {
        // Aquire the lock on the job queue [Job queue is basically handled by IO completion port]
        if( 0 != m_pJobQueueSynchronizer )
        {
            m_pJobQueueSynchronizer->Lock();
        }
        // Specify the threads, its time to do clean up on waiting jobs items in the queue
        // and after clean up straight away exit, whent getting the Queued Completion Status
        // 'TRUE' for the OVERLAPPED STRUCT argument
        m_bExitThread = true;
        int nThreadCount = m_hWorkerThreadArray.GetCount();
        int nIndex;
        // Iterate through each thread object in the worker thread array
        for( nIndex = 0; nIndex < nThreadCount; ++nIndex )
        {
            // Post the exit thread request, for each worker thread, OVERLAPPED pointer TRUE means
            // The thread is requested to exit [Thread Exit Request]
            if( FALSE == PostQueuedCompletionStatus( m_hIoCompletionPort, 0, 0, (LPOVERLAPPED)TRUE ))
            {
                // do nothing on failure
            }
        }
        HANDLE hThread = 0;
        // Iterate through each thread object in the worker thread array
        for( nIndex = 0; nIndex < nThreadCount; ++nIndex )
        {
            // Get the thread object
            hThread = m_hWorkerThreadArray.GetAt( m_hWorkerThreadArray.FindIndex( nIndex ));
            if( 0 != hThread )
            {
                // Wait for the thread to exit
                WaitForSingleObject( hThread, INFINITE );
                // Free the thread resource from the memory
                CloseHandle( hThread );
            }
        }
        // Remove all the thread handles from the array
        m_hWorkerThreadArray.RemoveAll();
        // Close the IO completion port and this infact destroys the thread pool
        CloseHandle( m_hIoCompletionPort );
        m_hIoCompletionPort = 0;
        // Unlock the job queue synchronizer
        if( 0 != m_pJobQueueSynchronizer )
        {
            m_pJobQueueSynchronizer->Unlock();
            // Delete the job queue synchronizer
            delete m_pJobQueueSynchronizer;
            m_pJobQueueSynchronizer = 0;
        }        
    }
    return true;
}

bool CThreadPool::EnQueue( THREAD_POOL_JOB_ITEM JobItem_io )
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
    // Unlock the job queue synchronizer
    m_pJobQueueSynchronizer->Unlock();
    return true;
}

bool CThreadPool::CleanUpJobItem( THREAD_POOL_JOB_ITEM* pJobItem_i )
{
    // Delete the job item
    if( 0 != pJobItem_i )
    {
        delete pJobItem_i;
        return true;
    }
    return false;
}

DWORD CThreadPool::WorkerThreadProcedure( LPVOID pThreadParam_i )
{
    // Get the passed CThreadPool object pointer
    CThreadPool* pThreadPoolObj = (CThreadPool*)pThreadParam_i;
    // Do until the thread is asked to exit
    while( true )
    {
        DWORD dwNumberOfBytes = 0;
        ULONG_PTR ulpJobItem = 0;
        LPOVERLAPPED pExitThreadFlag = 0;

        // Wait for the IO completion port to get a Job Item or a [Thread Exit Request] to process
        if( FALSE == GetQueuedCompletionStatus( pThreadPoolObj->m_hIoCompletionPort, &dwNumberOfBytes,
                                                &ulpJobItem, &pExitThreadFlag, INFINITE ))
        {
            //In case of wait error, exit the thread procedure
            break;
        }
        // If the specified IO request is [Thread Exit Request]?
        if(  TRUE == (BOOL)pExitThreadFlag )
        {
            // We are asked to quit the thread service, Exit from the loop
            break;
        }
        else
        {
            if( 0 != ulpJobItem )
            {                
                // Extract the job item
                THREAD_POOL_JOB_ITEM* pJobItem = reinterpret_cast<THREAD_POOL_JOB_ITEM*>( ulpJobItem );
                // If we have a valid job item
                if( 0 != pJobItem )
                {
                    // If the thread pool is asked to exit/stop, dont process the request 
                    // Process the request only if the thread pool is asked to run
                    if( !pThreadPoolObj->m_bExitThread )
                    {
                        // Call the real worker function of the client with the the supplied input data and collect
                        // the input data

                        // If the the object on which the call back function to be invoked is non null
                        if( 0 != pJobItem->pObjectToCallBack )
                        {
                            // If the member funtion pointer provided is non null
                            if( 0 != pJobItem->pMemberWorkerFunctionCallBack )
                            {
                                // Inovoke the member function pointer on the object provided witht the
                                // given input
                                ((pJobItem->pObjectToCallBack)->*(pJobItem->pMemberWorkerFunctionCallBack))
                                ( pJobItem->pJobInput );
                            }
                        }
                        else
                        {
                            // We have a global or static call back function, which is valid
                            if( 0 != pJobItem->pWorkerFunctionCallBack )
                            {
                                // Call the global/static function call back
                                pJobItem->pWorkerFunctionCallBack( pJobItem->pJobInput );
                            }
                        }
                    }
                    // In either case, cleanup the Job Request, once it not needed
                    pThreadPoolObj->CleanUpJobItem( pJobItem );
                }
            }
            else
            {
                // We dont have a valid job item, so continue to pick up a new request
                continue;
            }
        }
    }
    // Signal that the thread is exited. We must call this api, inorder to signal this thread termination
    // So that any WaitForSingleObject(...) call on this thread will return
    ExitThread( 0 );
    return 0;
}
