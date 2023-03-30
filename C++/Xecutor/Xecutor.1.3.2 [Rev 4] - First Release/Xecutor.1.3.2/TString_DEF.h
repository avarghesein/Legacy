#pragma once

CTString::operator long(void)
{
	long lVal;
	if( *this == EMPTY_TSTRING) return 0;
    _stscanf(pvt_tchrString,"%ld",&lVal);
	return lVal; 
}

CTString::operator double(void)
{
	double dVal;
	_stscanf((TCHAR*)(*this),"%lf",&dVal);
	return dVal; 
}

CTString::operator CBytes(void)
{
	CBytes bBytes;
	if(!Convert(bBytes,false)) throw 0; 
	return bBytes;
}


bool CTString::Convert(CBytes &Bytes,bool IncludeTerminatingNull)
{
	if(Bytes.SetMemoryBlock(0,0),Length() > 0)
	{
		return Bytes.SetMemoryBlock((PVOID)(TCHAR*)(*this),((IncludeTerminatingNull ? 1 : 0) + Length()) * sizeof(TCHAR)); 
	}
	return true;
}

bool CTString::StartsWith(TCHAR *vtchrSubString)
{
	return IndexOf(vtchrSubString) == 0;
}

bool CTString::StartsWith(CTString &robjSubString)
{
	return StartsWith((TCHAR*)robjSubString);
}

bool CTString::EndsWith(TCHAR *vtchrSubString)
{
	long lIndxThis,lIndxThat;
	CTString tsThat(vtchrSubString);

	lIndxThis = this->Length(),lIndxThat = tsThat.Length();
	if(!lIndxThis && !lIndxThat) return true;
	if(lIndxThis > 0 && !lIndxThat) return false;
	if(lIndxThis < 0 || lIndxThat < 0 || lIndxThis < lIndxThat) return false;

	for(lIndxThis--,lIndxThat-- ; lIndxThis >= 0 && lIndxThat >= 0; --lIndxThis,--lIndxThat)
		if((*this)[(long)lIndxThis] != tsThat[(long)lIndxThat]) return false;

	return true;
}

bool CTString::EndsWith(CTString &robjSubString)
{
	return EndsWith((TCHAR*)robjSubString);
}

CTString CTString::Replace(TCHAR tcCharInString,TCHAR tcCharNew)
{
	if(!pvt_tchrString) return *this;

	CTString oNewStr(*this);
	if(ReplaceChar(oNewStr.pvt_tchrString,oNewStr.Length(),tcCharInString,tcCharNew))
		return oNewStr;

	return CTString(); 
}

CTString CTString::ToLower(void)
{
	if(pvt_tchrString)
	{
		return CTString((TCHAR*)CharLower((TCHAR*)*this));
	}
	return *this;
}

CTString CTString::ToUpper(void)
{
	if(pvt_tchrString)
	{
		return CTString((TCHAR*)CharUpper((TCHAR*)*this));
	}
	return *this;
}

CTString CTString::AttachAnotherFileName(TCHAR *vptrAnotherFileName)
{
	long lLastIndx = LastIndexOf(_T('\\'));
	CTString oAnotherFile;

	if(lLastIndx != -1)
	{
		oAnotherFile = Cut(0,lLastIndx+1);
		return oAnotherFile + vptrAnotherFileName;
	}
	return oAnotherFile;
}

long CTString::IndexOf(TCHAR *vtchrSubStringToFound)
{
	if(!pvt_tchrString || !vtchrSubStringToFound) return -1;
	TCHAR *tchrTokenSeperator= _tcsstr((TCHAR*)(*this),vtchrSubStringToFound);
	if(!tchrTokenSeperator) return -1;
	return abs((long)(tchrTokenSeperator-pvt_tchrString));
}

long CTString::IndexOf(CTString &robjSubStringToFound)
{
	return IndexOf((TCHAR*)robjSubStringToFound.pvt_tchrString);
}

int CTString::operator==(UINT64 uiAddress)
{
	return pvt_tchrString==(TCHAR*)uiAddress;
}

int CTString::operator!=(UINT64 uiAddress)
{
	return pvt_tchrString!=(TCHAR*)uiAddress;
}

int CTString::operator==(CTString vobjStringToBeCompared)
{
	return (*this)==((TCHAR*)vobjStringToBeCompared);
}

int CTString::operator!=(CTString vobjStringToBeCompared)
{
	return (*this)!=((TCHAR*)vobjStringToBeCompared);
}

int CTString::operator!=(TCHAR* vptrStringToBeCompared)
{
	if(!pvt_tchrString || !(vptrStringToBeCompared)) 
	{
		return (long)pvt_tchrString & (long)vptrStringToBeCompared;
	}
	return _tcscmp(pvt_tchrString,vptrStringToBeCompared) != 0;
}

int CTString::operator==(TCHAR* vptrStringToBeCompared)
{
	if(!pvt_tchrString || !(vptrStringToBeCompared)) 
	{
		return !((long)pvt_tchrString & (long)vptrStringToBeCompared);
	}
	return _tcscmp(pvt_tchrString,vptrStringToBeCompared) == 0;
}

void CTString::Clear(void)
{
	DeleteAll((void**)&pvt_tchrString); 
}

long CTString::Length(bool InBytes)
{
	if(pvt_tchrString)
	{
		try 
		{ 
			return (long)(_tcslen(pvt_tchrString) * (InBytes ? sizeof(TCHAR) : 1)); 
		} 
		catch(...) 
		{}
	}
	return -1;
}

CTString CTString::Cut(unsigned long vulStartIndex)
{
	if(Length() >=0 && pvt_tchrString && ((unsigned long)Length())>=vulStartIndex && vulStartIndex>=0)
	{
		try { return CTString((TCHAR*)(pvt_tchrString+vulStartIndex)); }
		catch(...){}
	}
	return CTString();
}

CTString CTString::Cut(unsigned long vulStartIndex,unsigned long vulNumberOfCharactersToCopy)
{
	 long lStrLen = 0;
	 CTString oNewString;

	 try 
	 {
		if(vulStartIndex < 0) vulStartIndex = 0;
		if( (lStrLen = Length()) <= 0 || vulStartIndex > (ULONG)lStrLen) throw -1;
		if(vulNumberOfCharactersToCopy > (lStrLen - vulStartIndex)) vulNumberOfCharactersToCopy = lStrLen - vulStartIndex;  
		if(pvt_tchrString)
		{
			AllocateMem((TCHAR**)&(oNewString.pvt_tchrString),(TCHAR*)(pvt_tchrString+vulStartIndex),vulNumberOfCharactersToCopy,true);  
		}
	 }
	 catch(...) {}
	 return oNewString;
}

long CTString::LastIndexOf(TCHAR vtchrCharToFound)
{
	long lLen;
	if(pvt_tchrString)
	{
		for(lLen=_tcslen(pvt_tchrString)-1;lLen>=0;lLen--)
			if(pvt_tchrString[lLen] == vtchrCharToFound)
				return lLen;
	}
	return (long)-1;
}

long CTString::IndexOf(TCHAR vtchrCharToFound)
{
	UINT uintLen,uintMaxLen;
	if(pvt_tchrString)
	{
		for(uintMaxLen =(UINT)_tcslen(pvt_tchrString)-1,uintLen = 0;uintLen<=uintMaxLen;uintLen++)
			if(pvt_tchrString[uintLen] == vtchrCharToFound)
				return (long)uintLen;
	}
	return (long)-1;
}

TCHAR& CTString::operator[](long vulIndex)
{
	return (TCHAR&)pvt_tchrString[vulIndex];
}

CTString CTString::operator+=(CTString &robjStringToBeAppend)
{
	return (*this).Append(robjStringToBeAppend); 
}

CTString CTString::operator+=(TCHAR* vptrCharPointerToBeAppend)
{
	return (*this).Append(vptrCharPointerToBeAppend); 
}

CTString CTString::Append(CTString &robjStringToBeAppend)
{
	return Append((TCHAR*)robjStringToBeAppend); 
}

CTString CTString::Append(TCHAR* vptrCharPointerToBeAppend)
{
	if(vptrCharPointerToBeAppend)
	{
		TCHAR *mtchrNewString = 0;
		AllocateMem((TCHAR**)&mtchrNewString,(TCHAR*)pvt_tchrString);  
		ReAllocateString((TCHAR**)&(mtchrNewString),(TCHAR*)vptrCharPointerToBeAppend);  
		DeleteAll((void**)&pvt_tchrString);
		pvt_tchrString = mtchrNewString;
	}
	return *this;
}

CTString operator+(CTString &robjFirstString,CTString &robjSecondString)
{	
	return robjFirstString + (TCHAR*)robjSecondString.pvt_tchrString; 
}

CTString operator+(TCHAR* vptrCharPointer,CTString &robjSecondString)
{
	return CTString(vptrCharPointer) + (TCHAR*)robjSecondString.pvt_tchrString;   
}

CTString operator+(CTString &robjFirstString,TCHAR* vptrCharPointer)
{
	CTString oTmpStr(robjFirstString);
	return oTmpStr.Append((TCHAR*)vptrCharPointer); 
}

CTString::operator TCHAR*(void)
{
	return (TCHAR*)pvt_tchrString;  
}

CTString::operator const TCHAR*(void)
{
	return (TCHAR*)pvt_tchrString;  
}

CTString& CTString::operator=(const CTString &robjStringToBeAssigned)
{
	return (*this)=(TCHAR*)robjStringToBeAssigned.pvt_tchrString;//((TCHAR*)robjStringToBeAssigned);
}

CTString& CTString::operator=(TCHAR* vptrCharPointer)
{
	if(vptrCharPointer)
	{
		if(AllocateMem((TCHAR**)&pvt_tchrString,(TCHAR*)vptrCharPointer)) return *this;
	}
	else
	{
		Clear(); 
	}
	return *this;
}

CTString::CTString(void):CMemoryManager()
{
	pvt_tchrString = 0;
}

CTString::~CTString(void)
{
	DeleteAll((void**)&pvt_tchrString);
}

CTString::CTString(TCHAR* vptrCharPointer) : pvt_tchrString(0),CMemoryManager()
{
	pvt_tchrString = 0;
	AllocateMem((TCHAR**)&pvt_tchrString,(TCHAR*)vptrCharPointer);
}

CTString::CTString(const CTString& robjStringToBeCloned): pvt_tchrString(0),CMemoryManager()
{
	AllocateMem((TCHAR**)&pvt_tchrString,robjStringToBeCloned.pvt_tchrString);
}

bool CTString::CreatePath(void)
{
	CTString CurPath,PendingPath,CreatePath,tchrTmp;
	CTString thrFILE_SLASH(_T("\\"));

	if(!SplitByToken(thrFILE_SLASH,CurPath,PendingPath)) return false; 
	CreatePath = CurPath + thrFILE_SLASH;

	UINT uintPrevMode=SetErrorMode(SEM_FAILCRITICALERRORS);
	try
	{
		while(PendingPath.SplitByToken(thrFILE_SLASH,CurPath,tchrTmp))
		{
			CreatePath+=CurPath;
			CreateDirectory(CreatePath,0);
			CreatePath += thrFILE_SLASH;
			PendingPath=tchrTmp;
			tchrTmp=0;
		}
	}
	catch(...) {}	
	SetErrorMode(uintPrevMode);
	if(PendingPath == (TCHAR*)0) return true; else return false;
}

CTString CTString::LTrim(void)
{
	TCHAR *tOrg = (TCHAR*)(*this);
	tOrg += Length(); 
	TCHAR *tchrPtr = (TCHAR*)(*this);
	while(tchrPtr && tOrg >= tchrPtr && (*tchrPtr) == _T(' ') ) ++tchrPtr;
	return CTString(tchrPtr); 
}

CTString CTString::RTrim(void)
{
	CTString oNewStr(*this);
	TCHAR *tOrg = (TCHAR*)oNewStr;
	if(tOrg && oNewStr.Length() > 0)
	{
		TCHAR *tchrPtr = ((TCHAR*)oNewStr) + oNewStr.Length() - 1;
		while(tOrg <= tchrPtr && (*tchrPtr) == _T(' ') ) *tchrPtr = 0, --tchrPtr;
	}
	return CTString(oNewStr);
}

CTString CTString::Trim(void)
{
	return (*this).LTrim().RTrim();   
}

CTString CTString::GetDirectoryPart(void)
{
	long lIndx = LastIndexOf(_T('\\')); 

	if(lIndx <= 0) return CTString();
	return Cut(0,lIndx);  
}

CTString CTString::GetFileNamePart(void)
{
	long lIndx = LastIndexOf(_T('\\')); 

	if(lIndx <= 0) return *this;
	else 
		if(lIndx >= (Length() - 1)) return CTString();

	return Cut(lIndx + 1);  
}

CTString CTString::GetDirectory(GetFixedDirectory DirectoryRetrievalAPIdelegate)
{
	UINT uintLen=DirectoryRetrievalAPIdelegate(0,0);
	CTString oBuffer(uintLen + 1,true);	
	DirectoryRetrievalAPIdelegate(uintLen+1,(LPTSTR)oBuffer.pvt_tchrString);
	return oBuffer;
}

CTString CTString::GetDirectory(GetGenericDirectory DirectoryRetrievalAPIdelegate)
{
	UINT uintLen=DirectoryRetrievalAPIdelegate(0,0);
	CTString oBuffer(uintLen + 1,true);	
	DirectoryRetrievalAPIdelegate((LPTSTR)oBuffer.pvt_tchrString,uintLen+1);
	return oBuffer;
}

CTString CTString::CreateFolderLocation(CTString VirtualRootFolder,CTString RemainPath)
{
	UINT uintLen=0;
	CTString tchrLowerRootDir,tchrLowerRoot,tchrPrevCurDir;

	tchrLowerRootDir = VirtualRootFolder.ToLower();
	if(tchrLowerRootDir == "system")
	{
		tchrLowerRoot = CTString::GetDirectory((GetGenericDirectory)&GetSystemDirectory); 
		tchrLowerRoot += _T("\\");
	}
	else
	{
		tchrPrevCurDir  = CTString::GetDirectory((GetGenericDirectory)&GetCurrentDirectory); 
		tchrLowerRoot = CTString::GetDirectory((GetGenericDirectory)&GetWindowsDirectory); 
		tchrLowerRoot += _T("\\..\\");

		SetCurrentDirectory(tchrLowerRoot);
		tchrLowerRoot  = CTString::GetDirectory((GetGenericDirectory)&GetCurrentDirectory); 
		SetCurrentDirectory(tchrPrevCurDir);

		if(tchrLowerRootDir == "program files")
			tchrLowerRoot += _T("program files\\");
		else
			if(tchrLowerRootDir == "common files")
				tchrLowerRoot += _T("program files\\common files\\");
	}
	return tchrLowerRoot + RemainPath;
}


bool CTString::SplitByToken(CTString robjToken,CTString &robjFirstPart,CTString &robjSecondPart,bool bLeftToRight)
{
	return SplitByToken((TCHAR*)robjToken,robjFirstPart,robjSecondPart,bLeftToRight);
}

bool CTString::SplitByToken(TCHAR *vtchrToken,CTString &robjFirstPart,CTString &robjSecondPart,bool bLeftToRight)
{
	if(!pvt_tchrString || !vtchrToken) return false;
	long lTokenIndex = bLeftToRight ? IndexOf(vtchrToken) : LastIndexOf(vtchrToken);
	if(lTokenIndex == -1)
	{
		robjFirstPart = *this;
		robjSecondPart = (TCHAR*)0;
	}
	else 
	{
		CTString oTmp(vtchrToken);
		robjFirstPart = Cut(0,lTokenIndex); 
		robjSecondPart = Cut(lTokenIndex+oTmp.Length());
	}
	return true;
}

long CTString::SplitByToken(CTString robjToken,CTString* &roSplittedStrings,bool bLeftToRight)
{
	ULONG ulStrings = 0;
	CTString tsSrc(*this),tsRemain,tsSpltd;

	roSplittedStrings = 0;
	while(tsSrc.SplitByToken(robjToken,tsSpltd,tsRemain,bLeftToRight)) ++ulStrings,tsSrc = tsRemain;
	if(ulStrings) 
	{
		roSplittedStrings = new CTString[ulStrings];
		ulStrings = 0,tsSrc = *this;
		while(tsSrc.SplitByToken(robjToken,tsSpltd,tsRemain,bLeftToRight)) 
			roSplittedStrings[ulStrings] = CTString(tsSpltd),tsSrc = tsRemain,++ulStrings;
	}
	return ulStrings;;
}

long CTString::SplitByToken(TCHAR *vtchrToken,CTString* &roSplittedStrings,bool bLeftToRight)
{
	return SplitByToken(CTString(vtchrToken),roSplittedStrings,bLeftToRight);
}

CTString CTString::GetErrorString(long ErrorCode)
{
	CTString tsError(EMPTY_TSTRING);

	LPVOID lpMsgBuf;
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,NULL,ErrorCode,MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),(LPTSTR) &lpMsgBuf,0,NULL);
	tsError += (LPTSTR)lpMsgBuf;
	LocalFree( lpMsgBuf );

	return tsError;
}

CTString CTString::GetLastErrorString(void)
{
	return GetErrorString(GetLastError());
}

long CTString::LastIndexOf(TCHAR *vtchrSubStringToFound)
{
	return LastIndexOf(CTString(vtchrSubStringToFound));
}

long CTString::LastIndexOf(CTString &robjSubStringToFound)
{
	long lStrIndx,lStrInnerIndx,lStrLen = (*this).Length();
	long lSubStrIndx,lSubStrLen = robjSubStringToFound.Length();

	if(lStrLen <= 0 || lSubStrLen <= 0 || lStrLen < lSubStrLen) return -1;

	for(lStrIndx = lStrLen - 1 ; lStrIndx >= 0 ; lStrIndx--)
		if(robjSubStringToFound[(long)(lSubStrLen - 1)] == (*this)[(long)lStrIndx])			
		{
			for(lStrInnerIndx = lStrIndx - 1,lSubStrIndx = lSubStrLen - 2 ; lSubStrIndx >= 0 && lStrInnerIndx >= 0; lSubStrIndx--,lStrInnerIndx--) 
				if(robjSubStringToFound[lSubStrIndx] != (*this)[lStrInnerIndx]) break;

			if(lSubStrIndx >= 0) continue; else return lStrInnerIndx + 1;   
		}	
	return -1;
}

void CTString::Swap(CTString &tsStringToSwap)
{
	TCHAR *ptrTmp = this->pvt_tchrString;
	this->pvt_tchrString = tsStringToSwap.pvt_tchrString;
	tsStringToSwap.pvt_tchrString = ptrTmp; 
	return;
}

void CTString::Construct(TCHAR tcChar,long vlRepCount)
{
	pvt_tchrString = 0;
	AllocateMem((void**)&pvt_tchrString,sizeof(TCHAR)*vlRepCount);
	memset(pvt_tchrString,tcChar,sizeof(TCHAR)*vlRepCount);
	pvt_tchrString[vlRepCount - 1] = _T('\0');
}

CTString::CTString(TCHAR tcChar,long vlRepCount) : pvt_tchrString(0),CMemoryManager() 
{
	Construct(tcChar,vlRepCount);
}

CTString &CTString::CopyTo(CTString &rtsTarget,long vlTargetIndex)
{
	return CopyTo(rtsTarget,0,vlTargetIndex); 
}

CTString &CTString::CopyTo(CTString &rtsTarget,long vlSrcIndex,long vlTargetIndex)
{
	return CopyTo(rtsTarget,vlSrcIndex,(*this).Length() - vlSrcIndex,vlTargetIndex); 
}

CTString &CTString::CopyTo(CTString &rtsTarget,long vlSrcIndex,long vlLength,long vlTargetIndex)	
{
	CTString tsLeft = rtsTarget.Cut(0,vlTargetIndex);
	CTString tsMid = (*this).Cut(vlSrcIndex,vlLength);
	CTString tsRight = rtsTarget.Cut(vlTargetIndex + vlLength);
    
	return rtsTarget = tsLeft + tsMid + tsRight;
}

CTString CTString::RemoveAt(long vlSrcIndex,long vlLength)
{
	CTString tsLeft,tsRight,tsMiddle;
	
	tsLeft = (*this).Cut(0,vlSrcIndex);
	tsMiddle = (*this).Cut(vlSrcIndex,vlLength);
	tsRight = (*this).Cut(vlSrcIndex + vlLength);
	(*this) = tsLeft + tsRight;
	return tsMiddle;
}

TCHAR CTString::InsertAt(long vlSrcIndex,TCHAR tcCharToInsert)
{
	CTString tsNew(tcCharToInsert);
	InsertAt(vlSrcIndex,tsNew); 
	return tcCharToInsert;
}

CTString &CTString::InsertAt(long vlSrcIndex,CTString &rtsTarget)
{
	return InsertAt(vlSrcIndex,rtsTarget,0); 
}

CTString &CTString::InsertAt(long vlSrcIndex,CTString &rtsTarget,long vlTargetIndex)
{
	return InsertAt(vlSrcIndex,rtsTarget,vlTargetIndex,rtsTarget.Length()); 
}

CTString &CTString::InsertAt(long vlSrcIndex,CTString &rtsTarget,long vlTargetIndex,long vlTargetLength)
{
	CTString tsLeft,tsRight,tsMiddle;

	tsLeft = (*this).Cut(0,vlSrcIndex); 
	tsMiddle = rtsTarget.Cut(vlTargetIndex,vlTargetLength);
	tsRight = (*this).Cut(vlSrcIndex);

	return *this = tsLeft + tsMiddle + tsRight;
}

CTString CTString::Left(long vlLength)
{
	return (*this).Cut(0,vlLength); 
}

CTString  CTString::Right(long vlLength)
{
	return (*this).Cut((*this).Length() - vlLength); 
}

CTString CTString::Construct(long lValue)
{
	TCHAR sTmp[250];
	_stprintf(sTmp,"%ld",lValue);
	return CTString(sTmp); 
}

CTString CTString::Construct(double dValue)
{
	TCHAR sTmp[250];
	_stprintf(sTmp,"%lf",dValue);
	return CTString(sTmp); 
}

CTString::CTString(unsigned long vulValue,bool bIsBuffersize) : pvt_tchrString(0),CMemoryManager()
{
	if(bIsBuffersize) Construct(' ',vulValue);
	else *this = Construct((long)vulValue);
}

CTString::CTString(double dValue) : pvt_tchrString(0),CMemoryManager()
{
	*this = Construct(dValue);
}

CTString CTString::operator+=(long lValueToAppend)
{
	return (*this) += Construct(lValueToAppend);
}
		
CTString CTString::operator+=(double dValueToAppend)
{
	return (*this) += Construct(dValueToAppend);
}

CTString operator+(CTString &robjFirstString,long lValue)
{
	return robjFirstString + CTString(long(lValue)); 
}

CTString operator+(long lValue,CTString &robjSecondString)
{
	return robjSecondString + long(lValue);
}

CTString operator+(CTString &robjFirstString,double dValue)
{
	return robjFirstString + CTString(double(dValue));
}

CTString operator+(double dValue,CTString &robjSecondString)
{
	return robjSecondString + double(dValue);
}

int CTString::IsEmpty(void)
{
	if(!pvt_tchrString) return 1; else return (*this) == EMPTY_TSTRING;
}

CTString CTString::AppendFormat(TCHAR *tchrFormat,...)
{
	va_list ptrLst;
	va_start(ptrLst,tchrFormat);
	return AppendFormat(tchrFormat,ptrLst);
}

#ifdef _CRTBLD

int CTString::GetFormatStringLength(TCHAR *tchrFormat,va_list ptrLst)
{
	FILE str;
    REG1 FILE *outfile = &str;
    REG2 int retval;        
    outfile->_cnt = INT_MAX;
    outfile->_flag = _IOWRT|_IOSTRG;
    outfile->_ptr = outfile->_base = NULL;
    retval = _output(outfile,tchrFormat,ptrLst);
    return(retval);
}

#endif

CTString CTString::AppendFormat(TCHAR *tchrFormat,va_list ptrLst)
{
	#ifdef _CRTBLD
		CTString tPtr(GetFormatStringLength(tchrFormat,ptrLst) + 1,true);
	#else
		TCHAR tPtr[2500/*INT_MAX*/];
	#endif	
   _vstprintf((TCHAR*)tPtr,tchrFormat,ptrLst);	
	va_end(ptrLst);
    return Append(tPtr); 
}

//_stprintf()

CTString CTString::NullString(void)
{
	return CTString();
}

CTString CTString::Replace(TCHAR* tSubStr,TCHAR *tNewSubStr)
{
	return Replace((CTString)tSubStr,(CTString)tNewSubStr);
}

CTString CTString::Replace(TCHAR* tSubStr,CTString tNewSubStr)
{
	return Replace((CTString)tSubStr,tNewSubStr);
}

CTString CTString::Replace(CTString tSubStr,TCHAR *tNewSubStr)
{
	return Replace(tSubStr,(CTString)tNewSubStr);
}

CTString CTString::Replace(CTString tSubStr,CTString tNewSubStr)
{
	CTString tsOut,tFirst,tSec,tsCur = *this;
	while(tsCur.SplitByToken(tSubStr,tFirst,tSec))
	{
		tsOut += tFirst; 
		if(!tSec.Trim().IsEmpty()) tsOut += tNewSubStr;
		tsCur = tSec;
	}
	tsOut += tsCur;
	return tsOut; 
}

CTString CTString::Format(TCHAR *tchrFormat,...)
{
	CTString sTmp;
	va_list ptrLst;
	va_start(ptrLst,tchrFormat);
	sTmp.AppendFormat(tchrFormat,ptrLst);
	return sTmp; 
}

