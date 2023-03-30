#pragma once

class CMailSlotWriter : public CMailSlot
{
public:
					CMailSlotWriter(void);
	virtual        ~CMailSlotWriter(void);
	virtual bool    Connect(CTString MailSlotName,CTString ServerName = CMailSlot::LocalServerName);
	virtual bool ConnectSpecial(CTString MailSlotFullName);

	bool Write(CTString Message);
	bool Write(CBytes Message);
};


CMailSlotWriter::CMailSlotWriter(void) : CMailSlot() {}

CMailSlotWriter::~CMailSlotWriter(void) {}

bool CMailSlotWriter::ConnectSpecial(CTString MailSlotFullName)
{
	msMailSlotName = MailSlotFullName;
	Disconnect();
	return (mhMailSlot = CreateFile(
									(TCHAR*)msMailSlotName,GENERIC_WRITE, 
									FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, 
									OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
								  )) 
								  != INVALID_HANDLE_VALUE;
}

bool CMailSlotWriter::Connect(CTString MailSlotName,CTString ServerName)
{
	return CMailSlotWriter::ConnectSpecial("\\\\" + ServerName + "\\mailslot\\" + MailSlotName);
}


bool CMailSlotWriter::Write(CTString Message)
{
	CBytes Bytes;
	Message.Convert(Bytes,false);
	return Write(Bytes); 
}

bool CMailSlotWriter::Write(CBytes Message)
{
	const BYTE *pMsg = (const BYTE*)Message;
	DWORD dwToWrite = Message.Length(), dwWritten = 0;
	if(IsOpen())
	{
		while((int)dwToWrite > 0 && WriteFile(mhMailSlot,(void*)(pMsg + dwWritten),dwToWrite,&dwWritten,0) && (int)dwWritten > 0) 
		{
			dwToWrite =(DWORD)((int)dwToWrite - (int)dwWritten);
			//SleepEx(100,true);
		}
		return dwToWrite == 0;
	}
	return false;
}