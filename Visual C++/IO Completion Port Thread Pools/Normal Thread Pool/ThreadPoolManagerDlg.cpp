// ThreadPoolManagerDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ThreadPoolManager.h"
#include "ThreadPoolManagerDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CThreadPoolManagerDlg dialog

CThreadPoolManagerDlg::CThreadPoolManagerDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CThreadPoolManagerDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CThreadPoolManagerDlg)
	m_nJobCount = 0;
	m_nWorkerThreadCount = 0;
	m_nJobsToPush = 0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CThreadPoolManagerDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CThreadPoolManagerDlg)
	DDX_Text(pDX, IDC_EDIT_JOBCOUNT, m_nJobCount);
	DDV_MinMaxInt(pDX, m_nJobCount, 0, 1000);
	DDX_Text(pDX, IDC_EDIT_WORKERS, m_nWorkerThreadCount);
	DDV_MinMaxInt(pDX, m_nWorkerThreadCount, 0, 1000);
	DDX_Text(pDX, IDC_EDIT_JOBS_TO_PUSH, m_nJobsToPush);
	DDV_MinMaxInt(pDX, m_nJobsToPush, 0, 10000);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CThreadPoolManagerDlg, CDialog)
	//{{AFX_MSG_MAP(CThreadPoolManagerDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START_POOL_MGR, OnButtonStartPoolMgr)
	ON_BN_CLICKED(IDC_BUTTON_START_JOBS, OnButtonStartJobs)
	ON_BN_CLICKED(IDC_BUTTON_STOP_JOB_MGR, OnButtonStopThreadPoolMgr)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CThreadPoolManagerDlg message handlers

BOOL CThreadPoolManagerDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CThreadPoolManagerDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CThreadPoolManagerDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CThreadPoolManagerDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}




// Worker function that will call backed by the thread pool manager
void ClientWorkerProcedure( LPVOID pDataIn_i, LPVOID& pDataOut_o )
{
    int nNumber = (int)pDataIn_i;
    pDataOut_o = (LPVOID)nNumber;
}

// Critical section to lock the output file in to which result will be written by all the workers
CCriticalSection g_FileWriteSync;

// Result Call Back function
void ClientResultCallBack( LPVOID pDataIn_i )
{
    // Get the global lock on the output file
    if( FALSE == g_FileWriteSync.Lock())
    {
        return;
    }
    try
    {
        CFileException Error;
        CFile File;
        // Open the output file
        if( FALSE == File.Open( "C:\\THRDPOOL\\ABC.txt",
                                CFile::modeCreate | CFile::modeWrite | CFile::modeNoTruncate, &Error ))
        {
            g_FileWriteSync.Unlock();
            return;
        }
        // Go to the end of file
        File.SeekToEnd();
        // Write the result to the file
        File.Write( (TCHAR*)pDataIn_i, _tcslen( (TCHAR*)pDataIn_i ));
        // Close the file
        File.Close();
    }
    catch ( CFileException eX )
    {
    }
    // Release the global lock
    g_FileWriteSync.Unlock();
}

void CThreadPoolManagerDlg::OnButtonStartPoolMgr() 
{
    UpdateData( TRUE );
    // Initialize the thread pool first
	if( !m_ThreadPoolManager.InitializeThreadPool( m_nWorkerThreadCount, m_nJobCount ))
    {
        AfxMessageBox( "Thread Pool Initialization Failed!!!" );
        return;
    }
}

void CThreadPoolManagerDlg::OnButtonStartJobs() 
{
    UpdateData( TRUE );
    SetClassLong( m_hWnd, GCL_HCURSOR, (LONG)LoadCursor( NULL, IDC_WAIT ));

    // Create the job item and set the worker and call back functon
    // Which is same for all the worker procedure
    THREAD_POOL_JOB_ITEM JobItem;
    JobItem.pWorkerFunctionCallBack = &ClientWorkerProcedure;
    JobItem.pResultCallback = &ClientResultCallBack;

    bool bNotInitialized = false;
    int nIndex;
    for( nIndex = 1; nIndex <= m_nJobsToPush; ++nIndex )
    {
        // Add the job input to the job item
        JobItem.pJobInput = (LPVOID)nIndex;
        // Check whether there is room available in the job queue
        while( !m_ThreadPoolManager.IsRoomAvailableInJobQueue( bNotInitialized ))
        {
            // If room is not available, because the thread pool is not properly initialized, break form the loop
            if( bNotInitialized )
            {
                break;
            }
            // Wait for some time, so that there is empty slots avilable in the queue
            Sleep( 0 );
        }
        // Add the job item to the job queue
        m_ThreadPoolManager.EnQueue( JobItem );
    }

    SetClassLong( m_hWnd, GCL_HCURSOR, (LONG)LoadCursor( NULL, IDC_ARROW ));	

    return;	
}

void CThreadPoolManagerDlg::OnButtonStopThreadPoolMgr() 
{
    SetClassLong( m_hWnd, GCL_HCURSOR, (LONG)LoadCursor( NULL, IDC_WAIT ));
    // Stop the thread pool gracefully
	m_ThreadPoolManager.StopThreadPool();
    SetClassLong( m_hWnd, GCL_HCURSOR, (LONG)LoadCursor( NULL, IDC_ARROW));	
}
