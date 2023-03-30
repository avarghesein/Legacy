
#pragma once

enum ENTServiceStatus
{
	StartPending = 0,
	Running = 1,
	Paused = 2,
	Stopped = 3,
	ShutDowned =4
};

typedef int (*LogServiceEvent)(CTString);

typedef int (*ServiceEvent)(ENTServiceStatus);


class CServiceLogDelegate
{
	private:
		LogServiceEvent m_ptrDelegate;

	public:
		CServiceLogDelegate(void);
		void operator+=(LogServiceEvent oCallBack); 
		void operator-=(LogServiceEvent oCallBack); 

	public:
		int  operator()(CTString tsArg);
};


CServiceLogDelegate::CServiceLogDelegate(void) { m_ptrDelegate = 0; }

void CServiceLogDelegate::operator+=(LogServiceEvent oCallBack) { m_ptrDelegate = oCallBack; } 

void CServiceLogDelegate::operator-=(LogServiceEvent oCallBack) { m_ptrDelegate = 0; } 

int  CServiceLogDelegate::operator()(CTString tsArg)
{
	if(m_ptrDelegate) return m_ptrDelegate(tsArg);
	return 1;
}

class CServiceEventDelegate
{
	private:
		ServiceEvent m_ptrDelegate;

	public:
		CServiceEventDelegate(void);
		void operator+=(ServiceEvent oCallBack); 
		void operator-=(ServiceEvent oCallBack); 

	public:
		int  operator()(ENTServiceStatus eStat);
};


CServiceEventDelegate::CServiceEventDelegate(void) { m_ptrDelegate = 0; }

void CServiceEventDelegate::operator+=(ServiceEvent oCallBack) { m_ptrDelegate = oCallBack; } 

void CServiceEventDelegate::operator-=(ServiceEvent oCallBack) { m_ptrDelegate = 0; } 

int  CServiceEventDelegate::operator()(ENTServiceStatus eStat)
{
	if(m_ptrDelegate) return m_ptrDelegate(eStat);
	return 1;
}