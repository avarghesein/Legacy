#pragma once

bool CBytes::Convert(CTString &String)
{
	String.Clear();
	if(Length() > 0)
	{
		if(AllocateMem((void**)&String.pvt_tchrString,Length() + sizeof(TCHAR)))
			if(CopyBytes((BYTE*)String.pvt_tchrString,mpMemoryBlock,Length()))
			{
				*((TCHAR*)(((BYTE*)String.pvt_tchrString) + Length())) = _T('\0');
				return true;
			}
		return false;
	}
	return true;	
}

bool CBytes::SetMemoryBlock(void *pMemBlock,DWORD dwSize)
{
	if(Clear(), pMemBlock)
	{
		try
		{
			return CopyBytes((BYTE**)&mpMemoryBlock,(BYTE*)pMemBlock,dwSize);
		}
		catch(...) 
		{ 
			mpMemoryBlock = 0; 
			return false;
		}
	}
	return true;
}

CBytes CBytes::NullBytes(void)
{
	return CBytes();
}

BYTE CBytes::InsertAt(long vlSrcIndex,BYTE ByteToInsert)
{
	CBytes bNew;
	bNew += (BYTE)ByteToInsert;
	InsertAt(vlSrcIndex,bNew); 
	return ByteToInsert;
}

CBytes& CBytes::InsertAt(long vlSrcIndex,CBytes &rTarget)
{
	return InsertAt(vlSrcIndex,rTarget,0); 
}

CBytes& CBytes::InsertAt(long vlSrcIndex,CBytes &rTarget,long vlTargetIndex)
{
	return InsertAt(vlSrcIndex,rTarget,vlTargetIndex,rTarget.Length()); 
}

CBytes& CBytes::InsertAt(long vlSrcIndex,CBytes &rTarget,long vlTargetIndex,long vlTargetLength)
{
	CBytes bLeft,bRight,bMiddle;

	bLeft = (*this).Cut(0,vlSrcIndex); 
	bMiddle = rTarget.Cut(vlTargetIndex,vlTargetLength);
	bRight = (*this).Cut(vlSrcIndex);

	return *this = bLeft + bMiddle + bRight;
}

CBytes& CBytes::InsertAt(long vlSrcIndex,void *pMemBlock,long lSize)
{
	CBytes Buff(pMemBlock,lSize);
	return InsertAt(vlSrcIndex,Buff);
}

CBytes& CBytes::InsertAt(long vlSrcIndex,void *pMemBlock,long lSize,long vlTargetIndex)
{
	CBytes Buff(pMemBlock,lSize);
	return InsertAt(vlSrcIndex,Buff,vlTargetIndex);
}

CBytes& CBytes::InsertAt(long vlSrcIndex,void *pMemBlock,long lSize,long vlTargetIndex,long vlTargetLength)
{
	CBytes Buff(pMemBlock,lSize);
	return InsertAt(vlSrcIndex,Buff,vlTargetIndex,vlTargetLength);
}

CBytes  CBytes::RemoveAt(long vlSrcIndex,long vlLength)
{
	CBytes bLeft,bRight,bMiddle;
	
	bLeft = Cut(0,vlSrcIndex);
	bMiddle = Cut(vlSrcIndex,vlLength);
	bRight = Cut(vlSrcIndex + vlLength);
	(*this) = bLeft + bRight;
	return bMiddle;
}

CBytes CBytes::Left(long vlLength)
{
	return Cut(0,vlLength); 
}

CBytes CBytes::Right(long vlLength)
{
	return Cut(Length() - vlLength); 
}

CBytes CBytes::Cut(long vlStartIndex)
{
	if(Length() <= 0) return CBytes();
	return Cut(vlStartIndex,Length() - vlStartIndex);
}

CBytes CBytes::Cut(long vlStartIndex,long vlNumberOfCharactersToCut)
{
	long lLen = 0;
	CBytes oNewBytes;

	try 
	{
		if(vlStartIndex < 0) vlStartIndex = 0;
		if( (lLen = Length()) <= 0 || vlStartIndex >= lLen) throw 0;
		if(vlNumberOfCharactersToCut > (lLen - vlStartIndex)) vlNumberOfCharactersToCut = lLen - vlStartIndex;  
		if(mpMemoryBlock)
		{
			CopyBytes(&oNewBytes.mpMemoryBlock,mpMemoryBlock + vlStartIndex,vlNumberOfCharactersToCut);   
		}
	 }
	 catch(...) {}
	 return oNewBytes;
}

CBytes& CBytes::CopyTo(CBytes &rTarget,long vlTargetIndex)
{
	return CopyTo(rTarget,0,vlTargetIndex); 
}

CBytes& CBytes::CopyTo(CBytes &rTarget,long vlSrcIndex,long vlTargetIndex)	
{
	return CopyTo(rTarget,vlSrcIndex,Length() - vlSrcIndex,vlTargetIndex);
}

CBytes& CBytes::CopyTo(CBytes &rTarget,long vlSrcIndex,long vlLength,long vlTargetIndex)
{
	CBytes bLeft = rTarget.Cut(0,vlTargetIndex);
	CBytes bMid = (*this).Cut(vlSrcIndex,vlLength);
	CBytes bRight = rTarget.Cut(vlTargetIndex + vlLength);
    
	return rTarget = bLeft + bMid + bRight;
}

BYTE& CBytes::operator[](long Index)
{
	if(Index < 0 && Index >= Length()) throw 0;
	return (BYTE&)mpMemoryBlock[Index];  
}

void CBytes::Swap(CBytes &robjToSwap)
{ 
	BYTE *ptrTmp = mpMemoryBlock;
	mpMemoryBlock = robjToSwap.mpMemoryBlock; 
	robjToSwap.mpMemoryBlock = ptrTmp; 
}

void CBytes::Clear(void) 
{ 
	DeleteAll((void**)&mpMemoryBlock);
	mpMemoryBlock = 0;
}

CBytes& CBytes::operator=(CBytes &roSecondOperand)
{
	Clear(); 
	Append(roSecondOperand);
	return *this;
}

CBytes& CBytes::operator+=(BYTE ByteToAppend)
{
	(*this).Append(CBytes(&ByteToAppend,1));  
	return *this;
}

CBytes& CBytes::operator+=(CBytes &roSecondOperand)
{
	(*this).Append(roSecondOperand);
	return *this;
}

bool CBytes::operator !(void)
{
	return !mpMemoryBlock;
}

bool CBytes::operator ==(int iBoolVal)
{
	int iVal = mpMemoryBlock != 0 ? 1 : 0;
	iBoolVal = iBoolVal ? 1 : 0;
	return iBoolVal == iVal; 
}

bool CBytes::operator !=(int iBoolVal)
{
	return !((*this)==iBoolVal);
}

long  CBytes::Length(void)
{
	DWORD wSize = 0; 

	if(mpMemoryBlock) if(GetMemoryBlockSize(mpMemoryBlock,wSize)) return (long)wSize;  
	return 0;
}

bool CBytes::Append(CBytes &robjToAppend)
{
	return Append(robjToAppend.mpMemoryBlock,robjToAppend.Length());  
}

CBytes::operator const FAR BYTE*(void)
{
	return (const FAR BYTE*)mpMemoryBlock;
}

CBytes::operator FAR BYTE*(void)
{
	return (FAR BYTE*)mpMemoryBlock;
}

CBytes operator+(CBytes &roFirstOperand,CBytes &roSecondOperand)
{
	CBytes oResult(roFirstOperand);
	return oResult.Append(roSecondOperand); 
}

CBytes::CBytes(void)
{
	mpMemoryBlock = 0;
}

void CBytes::Copy(void *pMemBlock,DWORD dwSize)
{
	SetMemoryBlock(pMemBlock,dwSize);
}

CBytes::CBytes(void *pMemBlock,DWORD dwSize) : mpMemoryBlock(0)
{
	Copy(pMemBlock,dwSize);
}

CBytes::CBytes(DWORD dwSize) : mpMemoryBlock(0)
{
	AllocateMem((void**)&mpMemoryBlock,dwSize);
}

CBytes::CBytes(CBytes &oCopyObj) : mpMemoryBlock(0)
{
	if(oCopyObj == true) Copy(oCopyObj.mpMemoryBlock,oCopyObj.Length());  
}

CBytes::~CBytes(void)
{
	Clear();
}

CBytes& CBytes::operator+=(ULONG ulngSize)
{
	mpMemoryBlock = (BYTE*)ReAllocateMemory(mpMemoryBlock,Length() + ulngSize);
	return *this;
}

FAR BYTE* operator+(CBytes &Bytes,long Value)
{
	return Value + Bytes;
}

FAR BYTE* operator+(long Value,CBytes &Bytes)
{
	if(Value >= Bytes.Length()) return (FAR BYTE*)0;
	return Bytes.mpMemoryBlock + Value;
}

bool CBytes::Append(void *pMemBlock,long lSize)
{
	long lSrcLen,lTarLen;
	try
	{
		if( (lTarLen = lSize) > 0)
		{
			mpMemoryBlock = (BYTE*)ReAllocateMemory(mpMemoryBlock,(lSrcLen = Length()) + lTarLen);
			return CopyBytes((BYTE*)mpMemoryBlock + lSrcLen,(BYTE*)pMemBlock,lTarLen);   
		}
		return true;
	} 
	catch (...) { return false; }
}