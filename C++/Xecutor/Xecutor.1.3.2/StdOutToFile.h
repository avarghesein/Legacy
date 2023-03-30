#pragma once

class CStdOutToFile : public IRedirectedOutput
{
	private:
		FILE *mFilePtr;
		CTString mPath,mFile,mID;
		bool mbNewBlock;

	private:
		bool Write(CTString tsLine);

	public:
		CStdOutToFile(CTString Path,CTString FileName,CTString ID);
		virtual bool WriteToStream(CTString tsOutputLine);
		virtual bool StreamClosed(bool Graceful);
};

CStdOutToFile::CStdOutToFile(CTString Path,CTString FileName,CTString ID)
{
	mFilePtr = 0, mbNewBlock = true; 
	mPath = Path,mFile = FileName,mID = ID;
}

bool CStdOutToFile::Write(CTString tsLine)
{
	bool bOk = false;
	try
	{
		if(!mFilePtr) return false;
		bOk = _ftprintf(mFilePtr,"%s",(TCHAR*)tsLine) == tsLine.Length();
		//bOk = _fputts((TCHAR*)tsLine,mFilePtr) == tsLine.Length();
	}
	catch(...) {}
	return bOk;
}

bool CStdOutToFile::WriteToStream(CTString tsOutputLine)
{
	if(mbNewBlock)
	{
		try { if(mFilePtr) fclose(mFilePtr); } catch(...) {}
		CTString sFile = mPath + "\\" + (mID.IsEmpty() ? EMPTY_TSTRING : (mID + "_")) + mFile + ".out";
		mFilePtr = _tfopen((TCHAR*)sFile,"a+");
		Write("\r\n\r\n*----New Output Started on Date = [" + CTime::CurrentDate("ddd, dd-MMM-yyyy") + "] and Time = [" + CTime::CurrentTime("hh:mm:ss tt") + "]----*\r\n");   
		mbNewBlock = false;
	}
	return Write(tsOutputLine);
}

bool CStdOutToFile::StreamClosed(bool Graceful)
{
	CTString tsOut = "\r\n*---Program Ended Date = [" + CTime::CurrentDate("ddd, dd-MMM-yyyy") + "] and Time = [" + CTime::CurrentTime("hh:mm:ss tt") + "] Status =";
	tsOut += Graceful ? " Succefully Completed---*" : "Aborted/Completed with errors---*";
	mbNewBlock = true;

	bool bOk = Write(tsOut);
	long lSize = 0;

	try { if(mFilePtr) lSize = ftell(mFilePtr),fclose(mFilePtr); } catch(...) {}

	if(mFilePtr = 0, lSize >= 5 * 1024 *1024) 
	{
		CTString sFile = mPath + "\\" + (mID.IsEmpty() ? EMPTY_TSTRING : (mID + "_")) + mFile + ".out";
		DeleteFile((TCHAR*)sFile); 
	}
	return bOk;
}