#pragma once

class CPipe
{
private:
	HANDLE mhReadEnd,mhWriteEnd;

	bool mbUseAsciiCodePageForReadEnd;
	bool mbUseAsciiCodePageForWriteEnd;

public:

	bool DestroyReadEnd(void);
	bool DestroyWriteEnd(void);
	bool Destroy(void);

public:
	CPipe(void);
	CPipe(bool Inheritable,bool UseAsciiCodePageForReadEnd = false,bool UseAsciiCodePageForWriteEnd = false);
	CPipe(const CPipe &Copy,bool ReadEndInheritable = true,bool WriteEndInheritable = true);
	CPipe(const CPipe &ReadCopy,const CPipe &WriteCopy);
   ~CPipe(void);

	bool DuplicateReadEnd(CPipe &TargetPipe,bool Inheritable = true);			
	bool DuplicateWriteEnd(CPipe &TargetPipe,bool Inheritable = true);			
	bool Duplicate(CPipe &TargetPipe,bool ReadEndInheritable = true,bool WriteEndInheritable = true);

	bool ValidReadEnd(bool &DataAvailable);

	void DiscardReadEnd(void);
	void DiscardWriteEnd(void);
	void Discard(void);

	CPipe &operator=(const CPipe& oPipe);
	bool IsBrocken(void);
	bool Create(bool Inheritable = true);
	bool Create(const CPipe &ReadCopy,const CPipe &WriteCopy);
	void SetReadEnd(const CPipe &ReadCopy);
	void SetWriteEnd(const CPipe &WriteCopy);
	bool WriteToPipe(CTString tsInput);
	bool ReadFromPipe(CTString &tsOutPut);
	friend CPipe& operator<<(CPipe &oPipe,CTString tsString);
	friend CPipe& operator>>(CPipe &oPipe,CTString& tsString);

	friend const HANDLE operator+(CPipe &Pipe);
	friend const HANDLE operator-(CPipe &Pipe);
};

const HANDLE operator+(CPipe &Pipe)
{
	return (const HANDLE)Pipe.mhWriteEnd;
}

const HANDLE operator-(CPipe &Pipe)
{
	return (const HANDLE)Pipe.mhReadEnd;
}

void CPipe::DiscardReadEnd(void) { mhReadEnd = 0; }
void CPipe::DiscardWriteEnd(void) { mhWriteEnd = 0; } 
void CPipe::Discard(void) { mhReadEnd = mhWriteEnd = 0; }

bool CPipe::Create(bool Inheritable)
{
	Destroy(); 

	bool bOk;
	SECURITY_ATTRIBUTES saAttr; 
    
	saAttr.nLength = sizeof(SECURITY_ATTRIBUTES); 
	saAttr.bInheritHandle = Inheritable ? TRUE : FALSE; 
	saAttr.lpSecurityDescriptor = NULL; 

	if(!(bOk = CreatePipe(&mhReadEnd, &mhWriteEnd, &saAttr,0) != 0)) mhReadEnd = mhWriteEnd = 0;

	return bOk;
}

bool CPipe::IsBrocken(void) { return GetLastError() == ERROR_BROKEN_PIPE; }

bool CPipe::ValidReadEnd(bool &DataAvailable)
{
	if(DataAvailable = false,!mhReadEnd) return false;

	DWORD dwAvail = 0;
	if(PeekNamedPipe(mhReadEnd,0,0,0,&dwAvail,0)) 
		DataAvailable = dwAvail > 0;
	else
		return GetLastError()!=ERROR_BROKEN_PIPE;
	return true;
}

bool CPipe::DestroyReadEnd(void)
{
	bool bRet = true;
	if(mhReadEnd) 
	{
		bRet = CloseHandle(mhReadEnd) != 0; 
		if(bRet) mhReadEnd = 0;
	}
	return bRet;
}

bool CPipe::DestroyWriteEnd(void)
{
	bool bRet = true;

	if(mhWriteEnd)
	{
		bRet = CloseHandle(mhWriteEnd) != 0; 
		if(bRet) mhWriteEnd = 0;
	}
	return bRet;
}

bool CPipe::Destroy(void)
{
	return DestroyReadEnd() & DestroyWriteEnd();
}

void CPipe::SetReadEnd(const CPipe &ReadCopy)
{
	DestroyReadEnd(); 
	mhReadEnd = ReadCopy.mhReadEnd;
	mbUseAsciiCodePageForReadEnd = ReadCopy.mbUseAsciiCodePageForReadEnd;
}

void CPipe::SetWriteEnd(const CPipe &WriteCopy)
{
	DestroyWriteEnd(); 
	mhWriteEnd = WriteCopy.mhWriteEnd;
	mbUseAsciiCodePageForWriteEnd = WriteCopy.mbUseAsciiCodePageForWriteEnd;
}

bool CPipe::Create(const CPipe &ReadCopy,const CPipe &WriteCopy)
{
	SetReadEnd(ReadCopy);
	SetWriteEnd(WriteCopy);
	return true;
}

CPipe::CPipe(const CPipe &ReadCopy,const CPipe &WriteCopy)
:
mhReadEnd(ReadCopy.mhReadEnd),mhWriteEnd(WriteCopy.mhWriteEnd),
mbUseAsciiCodePageForReadEnd(ReadCopy.mbUseAsciiCodePageForReadEnd),
mbUseAsciiCodePageForWriteEnd(WriteCopy.mbUseAsciiCodePageForWriteEnd)
{}

CPipe::CPipe(void):
mhReadEnd(0),mhWriteEnd(0),
mbUseAsciiCodePageForReadEnd(false),
mbUseAsciiCodePageForWriteEnd(false)
{}

CPipe::CPipe(bool Inheritable,bool UseAsciiCodePageForReadEnd,bool UseAsciiCodePageForWriteEnd)
: 
mhReadEnd(0),mhWriteEnd(0),
mbUseAsciiCodePageForReadEnd(UseAsciiCodePageForReadEnd),
mbUseAsciiCodePageForWriteEnd(UseAsciiCodePageForWriteEnd)
{
	Create(Inheritable);;
}


CPipe::CPipe(const CPipe &Copy,bool ReadEndInheritable,bool WriteEndInheritable)
: 
mbUseAsciiCodePageForReadEnd(Copy.mbUseAsciiCodePageForReadEnd),
mbUseAsciiCodePageForWriteEnd(Copy.mbUseAsciiCodePageForWriteEnd)
{
	HANDLE hProcess = GetCurrentProcess();
	if(!Copy.mhReadEnd || !DuplicateHandle(hProcess,Copy.mhReadEnd,hProcess,&mhReadEnd,0,ReadEndInheritable,DUPLICATE_SAME_ACCESS)) mhReadEnd = 0;  
	if(!Copy.mhWriteEnd || !DuplicateHandle(hProcess,Copy.mhWriteEnd,hProcess,&mhWriteEnd,0,WriteEndInheritable,DUPLICATE_SAME_ACCESS)) mhWriteEnd = 0;  
}

CPipe::~CPipe(void)
{
	Destroy();
}

bool CPipe::DuplicateReadEnd(CPipe &TargetPipe,bool Inheritable)			
{
	TargetPipe.DestroyReadEnd(); 
	TargetPipe.mbUseAsciiCodePageForReadEnd = mbUseAsciiCodePageForReadEnd;
	HANDLE hProcess = GetCurrentProcess();
	if(!mhReadEnd || !DuplicateHandle(hProcess,mhReadEnd,hProcess,&TargetPipe.mhReadEnd,0,Inheritable,DUPLICATE_SAME_ACCESS)) 
		TargetPipe.mhReadEnd = 0;  
	else 
		return true;
	return false;
}

bool CPipe::DuplicateWriteEnd(CPipe &TargetPipe,bool Inheritable)			
{
	TargetPipe.DestroyWriteEnd(); 
	TargetPipe.mbUseAsciiCodePageForWriteEnd = mbUseAsciiCodePageForWriteEnd;
	HANDLE hProcess = GetCurrentProcess();
	if(!mhWriteEnd || !DuplicateHandle(hProcess,mhWriteEnd,hProcess,&TargetPipe.mhWriteEnd,0,Inheritable,DUPLICATE_SAME_ACCESS)) 
		TargetPipe.mhWriteEnd = 0;  
	else
		return true;
	return false;
}

bool CPipe::Duplicate(CPipe &TargetPipe,bool ReadEndInheritable,bool WriteEndInheritable)
{
	return DuplicateReadEnd(TargetPipe,ReadEndInheritable) & DuplicateWriteEnd(TargetPipe,WriteEndInheritable);
}

CPipe& CPipe::operator=(const CPipe& oPipe)
{
	Destroy();
	
	HANDLE hProcess = GetCurrentProcess();
	DWORD dwRet = 0;

	mbUseAsciiCodePageForReadEnd = oPipe.mbUseAsciiCodePageForReadEnd; 
	if(oPipe.mhReadEnd && GetHandleInformation(oPipe.mhReadEnd,&dwRet))
	{
		if(!DuplicateHandle(hProcess,oPipe.mhReadEnd,hProcess,&mhReadEnd,0,dwRet & HANDLE_FLAG_INHERIT,DUPLICATE_SAME_ACCESS)) mhReadEnd = 0;  
	}
	else mhReadEnd = 0;

	mbUseAsciiCodePageForWriteEnd = oPipe.mbUseAsciiCodePageForWriteEnd; 
	if(oPipe.mhWriteEnd && GetHandleInformation(oPipe.mhWriteEnd,&dwRet))
	{
		if(!DuplicateHandle(hProcess,oPipe.mhWriteEnd,hProcess,&mhWriteEnd,0,dwRet & HANDLE_FLAG_INHERIT,DUPLICATE_SAME_ACCESS)) mhWriteEnd = 0;  
	}
	else mhWriteEnd = 0;
		  
	return *this;  
}

bool CPipe::WriteToPipe(CTString tsInput)
{
	if(!mhWriteEnd) return false;
	
	DWORD dwLen = tsInput.Length();
	if(!dwLen) return 0;
	LPSTR oem;

#ifdef UNICODE
	DWORD tmp = 2 * dwLen;
	oem = (LPSTR)_alloca(tmp + 1); 
	if(dwLen != WideCharToMultiByte(mbUseAsciiCodePageForWriteEnd ? CP_ACP : CP_OEMCP,0,(TCHAR*)tsInput,dwLen,oem,tmp, NULL,NULL)) return false;
#else
	if(mbUseAsciiCodePageForWriteEnd) oem = (LPSTR)(TCHAR*)tsInput; else 
	{
		oem = (LPSTR)_alloca(dwLen + 1);
		if(!CharToOem((TCHAR*)tsInput,oem)) return false;
	}
#endif  

	DWORD dwWritten = 0;
	bool bOk = WriteFile(mhWriteEnd,oem,dwLen,&dwWritten,0) && FlushFileBuffers(mhWriteEnd);   

	return bOk && dwWritten == dwLen;
}

CPipe& operator<<(CPipe &oPipe,CTString tsString)
{
	oPipe.WriteToPipe(tsString);
	return oPipe;
}

#define MIN(a,b) (((a) < (b)) ? (a) : (b))

bool CPipe::ReadFromPipe(CTString &tsOutPut)
{
	if(!mhReadEnd) return false;
	char sBuff[256];
	CTString tsData;

	DWORD dwRed,dwAvail;
	while(PeekNamedPipe(mhReadEnd,0,0,0,&dwAvail,0) && dwAvail > 0) 
	{
		if (!ReadFile(mhReadEnd,sBuff, MIN(255, dwAvail),&dwRed,0) || !dwRed) break;
		sBuff[(long)dwRed] = 0;
#ifdef UNICODE
			WCHAR wbuf[256];
			MultiByteToWideChar( mbUseAsciiCodePageForReadEnd ? CP_ACP : CP_OEMCP,0,sBuff,dwRed,wbuf, 255);
			wbuf[nBytesRead] = 0;
			tsData += wbuf;
#else
			if(mbUseAsciiCodePageForReadEnd) OemToChar(sBuff,sBuff); // inplace ok
			tsData += sBuff;
#endif
	}
	tsOutPut = tsData; 
	return !tsOutPut.IsEmpty(); 
}

CPipe& operator>>(CPipe &oPipe,CTString& tsString)
{
	oPipe.ReadFromPipe(tsString); 
	return oPipe;
}