#pragma once

class CMailSlot
{
protected:
	HANDLE mhMailSlot;
	HANDLE mhStopEvent;
	CTString msMailSlotName;
	bool mbStop;

protected:
			     CMailSlot(void);
	virtual     ~CMailSlot(void);
	virtual bool Connect(CTString MailSlotName,CTString ServerName = ".") = 0;
	virtual bool ConnectSpecial(CTString MailSlotFullName) = 0;

public:
	virtual void	Disconnect(void);
	bool			IsOpen(void) const;	

public:
	static const CTString LocalServerName;
	static const CTString PrimaryDomainName;
};

const CTString CMailSlot::LocalServerName = ".";
const CTString CMailSlot::PrimaryDomainName = "*";

bool CMailSlot::IsOpen(void) const
{
	return mhMailSlot != INVALID_HANDLE_VALUE;
}

CMailSlot::CMailSlot(void)
{
	mbStop = false;
	mhMailSlot = INVALID_HANDLE_VALUE;
}

CMailSlot::~CMailSlot(void)
{
	Disconnect();
}

void CMailSlot::Disconnect(void)
{
	if (mhMailSlot != INVALID_HANDLE_VALUE) CloseHandle(mhMailSlot);
	mhMailSlot = INVALID_HANDLE_VALUE;
}