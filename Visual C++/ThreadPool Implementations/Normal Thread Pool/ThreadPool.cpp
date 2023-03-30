
// Class implementaion for the Thread Pool class.

#include "stdafx.h"
#include "ThreadPool.h"

CThreadPool::CThreadPool()
{
   // Initialize the members and the arrays
   m_nJobQueueSize = 0;
   m_nThreadPoolSize = 0;
   m_JobQueueArray.RemoveAll();
   m_hWorkerThreadArray.RemoveAll();
   // Initially all synch objects are initialized to 0, so that StopThreadPool() function work properly in all cases
   m_hStopThreadPoolEvt = 0;
   m_pJobQueueSynchronizer = 0;
   m_hJobsInQueueEvt = 0;
   
}

CThreadPool::~CThreadPool()
{
    // Stop the thread pool, if its running
    StopThreadPool();
}

bool CThreadPool::InitializeThreadPool( int nThreadPoolSize_i, int nJobQueueSize_i )
{
    // Stop the thread pool, if its already running.
    StopThreadPool();
    // Empty out the job queue and worker thread list
    m_JobQueueArray.RemoveAll();
    m_hWorkerThreadArray.RemoveAll();
    // Assign the new sizes for the worker thread queue and the job queue
    m_nJobQueueSize = nJobQueueSize_i;
    m_nThreadPoolSize = nThreadPoolSize_i;
    // Create the mutex that will synchronize the access to the job queue
    m_pJobQueueSynchronizer = new CMutex;

    // Create the event that will be used to signal the worker threads that, they should exit
    // This event is used to shutdown all the worker threads gracefully
    // Initially this event is non signalled, means that all worker threads can continue running
    m_hStopThreadPoolEvt = CreateEvent( 0, TRUE, FALSE, "RUN_THREAD_POOL_EVENT" );

    // Create an event that will notify the worker threads, if there is atleast one item in the job queue
    m_hJobsInQueueEvt = CreateEvent( 0, TRUE, FALSE,  "JOB_QUEUE_EVENT" );
    // Create the worker threads
    return CreatThreadPoolAndJobQueue();
}

bool CThreadPool::CreatThreadPoolAndJobQueue()
{
    int nIndex;
    DWORD dwThreadID;
    HANDLE hThread;
    // Create the worker threads and add it to the worker thread list
    for( nIndex = 0; nIndex < m_nThreadPoolSize; ++nIndex )
    {
        // Pass the current object as the parameter to the thread call so that, the static thread can
        // access the members of the current CThreadPool object
        hThread = CreateThread( 0, 0, &CThreadPool::CommonWorkerProc, (LPVOID)this, 0, &dwThreadID );
        m_hWorkerThreadArray.AddTail( hThread );
    }
    return true;
}

bool CThreadPool::StopThreadPool()
{
    // If we already having a thread pool running?
    if( 0 != m_hStopThreadPoolEvt )
    {
        // Reset the event, notifying all the threads that they must stop their execution.
        if( TRUE == SetEvent( m_hStopThreadPoolEvt ))
        {
            // Aquire the lock on the job queue
            if( 0 != m_pJobQueueSynchronizer )
            {
                m_pJobQueueSynchronizer->Lock();
            }
            if( 0 != m_hJobsInQueueEvt )
            {
                // Notify[ Fake notification ] the worker threads that there is no items in the job queue
                // So that no threads will look for the job item in the job queue now onwards
                ResetEvent( m_hJobsInQueueEvt );
            }
            // Empty out the job queue
            m_JobQueueArray.RemoveAll();
            int nIndex;
            int nThreadCount = m_hWorkerThreadArray.GetCount();
            HANDLE hThread;
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
            // Unlock the job queue synchronizer
            if( 0 != m_pJobQueueSynchronizer )
            {
                m_pJobQueueSynchronizer->Unlock();
            }
            // Delete the job queue synchronizer
            delete m_pJobQueueSynchronizer;
            m_pJobQueueSynchronizer = 0;
            // Remove the Job Queue Event from memory
            if( 0 != m_hJobsInQueueEvt )
            {
                CloseHandle( m_hJobsInQueueEvt );
                m_hJobsInQueueEvt = 0;
            }
        }
        // Remove the Run Notification Event from memory
        CloseHandle( m_hStopThreadPoolEvt );
        m_hStopThreadPoolEvt = 0;
    }
    return true;
}

bool CThreadPool::EnQueue( THREAD_POOL_JOB_ITEM JobItem_io )
{
    // If we dont have a synchronizer object, its an error
    if( 0 == m_pJobQueueSynchronizer )
    {
        return false;
    }
    // Try to lock the job queue. Attempt upto 10 secs.. If failed to lock return failure
    if( FALSE == m_pJobQueueSynchronizer->Lock( /*10000*/ )) // Adding job to the queue can wait for indefinitely
    {
        return false;
    }
    // Get the number of jobs in the job queue
    int nSize = m_JobQueueArray.GetCount();
    // Is the Job Queue is already attained its maximum limit?
    if( nSize >= m_nJobQueueSize )
    {
        // If yes return failure after unlocking the jobqueue
        m_pJobQueueSynchronizer->Unlock();
        return false;
    }
    // Add the job item to the end of the queue
    m_JobQueueArray.AddTail( JobItem_io );
    // Set the Job Queue Event, Notifying all the worker threads that Job Item is now available in the queue
    SetEvent( m_hJobsInQueueEvt );
    // Unlock the queue, so that the worker threads can access it for processing the job item
    m_pJobQueueSynchronizer->Unlock();
    return true;
}

bool CThreadPool::DQueue( THREAD_POOL_JOB_ITEM& JobItem_o )
{
    if( 0 == m_pJobQueueSynchronizer )
    {
        return false;
    }
    // Try to lock the job queue. Attempt upto 10 secs.. If failed to lock return failure
    if( FALSE == m_pJobQueueSynchronizer->Lock( 10000 ))
    {
        return false;
    }
    // Get the Current job count
    int nSize = m_JobQueueArray.GetCount();
    // If the job queue is empty?
    if( 0 >= nSize )
    {
        // Since the jobqueue is empty notify all threads that Job Queue is empty, so that they dont look in
        // the job queue until one EnQueue [ Adding an item to the job queue ], will be done
        ResetEvent( m_hJobsInQueueEvt );
        // Unlock the job queue, so that another EnQueue(), call can fill the job queue
        m_pJobQueueSynchronizer->Unlock();
        return false;
    }
    // Get the first job item in the queue
    THREAD_POOL_JOB_ITEM JobItem = m_JobQueueArray.GetAt( m_JobQueueArray.FindIndex( 0 ));
    JobItem_o = JobItem;
    m_JobQueueArray.RemoveAt( m_JobQueueArray.FindIndex( 0 ));
    // Is this item is the last item in the Job Queue?
    if( 1 >= nSize )
    {
        // Since the jobqueue is empty notify all threads that Job Queue is empty, so that they dont look in
        // the job queue until one EnQueue [ Adding an item to the job queue ], will be done
        ResetEvent( m_hJobsInQueueEvt );
    }
    // Release the lock on the job queue
    m_pJobQueueSynchronizer->Unlock();
    return true;
}

void GetDateTime( CString& csDate_o, CString& csTime_o )
{
    try
    {
        // Get system time and date
        SYSTEMTIME stSysDate;
        GetLocalTime( &stSysDate );
        long lYear = static_cast<long>( stSysDate.wYear );
        long lMonth = static_cast<long>( stSysDate.wMonth );
        long lDay = static_cast<long>( stSysDate.wDay );
        long lHour = static_cast<long>( stSysDate.wHour );
        long lMin = static_cast<long>( stSysDate.wMinute );
        long lSec = static_cast<long>( stSysDate.wSecond );
        long lMilliSec = static_cast<long>( stSysDate.wMilliseconds );

        // Format date to YYYYMMDD
        csDate_o.Format( _T( "%.4ld%.2ld%.2ld" ), lYear, lMonth, lDay );
        csTime_o.Format( _T( "%.2ld%.2ld%.2ld.%.6ld" ),
                         lHour, lMin, lSec, lMilliSec );
    }
    catch(...)
    {
    }
}

DWORD CThreadPool::CommonWorkerProc( LPVOID pThreadParam_i )
{
    // Get the passed CThreadPool object pointer
    CThreadPool* pThreadPoolObj = (CThreadPool*)pThreadParam_i;
    // Do until the thread is asked to exit
    while( true )
    {
        CString csOutData;
        CString csDate;
        CString csTime;

        GetDateTime( csDate, csTime );
        csOutData = "\r\n<--\r\nStart Date & Time: " + csDate + " " + csTime + "\r\n";
        
        // Create an array to hold the Exit Thread Event and the Job Queue Event
        HANDLE hWaitHandleArray[ 2 ] = { pThreadPoolObj->m_hStopThreadPoolEvt, pThreadPoolObj->m_hJobsInQueueEvt };
        // Wait for the two events indefinitely
        DWORD dwResult = WaitForMultipleObjects( 2, hWaitHandleArray, FALSE, INFINITE );
        // Is te signalled event is 'm_hStopThreadPoolEvt'?
        if(  WAIT_OBJECT_0 == dwResult )
        {
            // 'm_hStopThreadPoolEvt', signalled
            // We are asked to quit the thread service, Exit from the loop
            break;
        }
        else
        {
            // Is the signalled event is 'm_hJobsInQueueEvt'?
            if( WAIT_OBJECT_0 + 1 == dwResult )
            {
                Sleep( 1000 );
                // 'm_hJobsInQueueEvt' signalled, means that there is atleast one job in the job queue
                THREAD_POOL_JOB_ITEM JobItem;
                // Get the very first job from the Job Queue to process
                if( pThreadPoolObj->DQueue( JobItem ))
                {
                    GetDateTime( csDate, csTime );
                    csOutData += "End Date & Time: " + csDate + " " + csTime + "\r\n";

                    LPVOID pOutData = 0;
                    // Call the real worker function of the client with the the supplied input data and collect
                    // the output data
                    JobItem.pWorkerFunctionCallBack( JobItem.pJobInput, pOutData );

                     TCHAR szBuff[ 500 ];
                    _stprintf( szBuff, "Thread ID:%d; Result: %d\r\n-->\r\n",
                               GetCurrentThreadId(), (int)pOutData );
                    csOutData += CString( szBuff );                    
                    pOutData = (LPVOID)csOutData.LockBuffer();

                    // Call the result notification handler on side of the client with the output data
                    JobItem.pResultCallback( pOutData );

                    csOutData.UnlockBuffer();
                }
            }
            else
            {
                // This is an error wait is abandoned; Quit the thread
                break;
            }
        }
    }
    // Signal that the thread is exited. We must call this api, inorder to signal this thread termination
    // So that any WaitForSingleObject(...) call on this thread will return
    ExitThread( 0 );
    return 0;
}

bool CThreadPool::IsRoomAvailableInJobQueue( bool& bThreadPoolNotInitialized )
{
    bThreadPoolNotInitialized = true;
    if( 0 == m_pJobQueueSynchronizer )
    {
        return false;
    }
    bThreadPoolNotInitialized = false;
    // Try to lock the job queue. Attempt upto 10 secs.. If failed to lock return failure
    if( FALSE == m_pJobQueueSynchronizer->Lock( 10000 ))
    {
        return false;
    }
    int nSize = m_JobQueueArray.GetCount();
    // Is the Job Queue is already attained its maximum limit?
    if( nSize >= m_nJobQueueSize )
    {
        // If yes return failure after unlocking the jobqueue
        m_pJobQueueSynchronizer->Unlock();
        return false;
    }
    m_pJobQueueSynchronizer->Unlock();
    // Empty slots are avilable in the job queue for a new job item
    return true;
}
