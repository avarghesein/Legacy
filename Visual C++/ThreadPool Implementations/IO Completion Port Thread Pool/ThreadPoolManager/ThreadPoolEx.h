
#if !defined( THREAD_POOL_EX_HEADER_INCLUDED )
#define THREAD_POOL_EX_HEADER_INCLUDED

#if _MSC_VER > 1000
    #pragma once
#endif

#include "ThreadPool.h"

class CThreadPoolEx : public CThreadPool  
{
public:
	CThreadPoolEx( void );
	virtual ~CThreadPoolEx();

    // Adds a new job item to the thread pool's job queue [Overriding Base Class Version]
    virtual bool EnQueue( THREAD_POOL_JOB_ITEM JobItem_io );
    // Stops all the worker threads running and resetes the thread pool [Overriding Base Class Version]
    // Any job item thats not processed will be lost [Overriding Base Class Version]
    virtual bool StopThreadPool( void );

protected:
    // Create the worker threads [Overriding Base Class Version]
    virtual bool CreateThreadPool( void );
    // Clean Up Job Item [Overriding Base Class Version]
    virtual bool CleanUpJobItem( THREAD_POOL_JOB_ITEM* pJobItem_i );

protected:
    volatile long m_lJobsInQueue;
};

#endif