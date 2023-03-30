
#pragma once

#include <Windows.h>
#include <Math.h>
#include <Malloc.h>

class CMemoryManager
{
	private:
		static HANDLE m_hPrivateHeap;

	public:
		static bool SetLocalHeap(HANDLE &HndToHeap);
		static HANDLE &GetLocalHeap(void);

    public:
		void DeleteAll(void **ArrayObject);
		void DeleteNew(void **ArrayObject);
		bool AllocateMem(void **TarObj,UINT32 NumberOfBytes);
		bool AllocateMem(TCHAR **TarObj,TCHAR *SrcObj);
		bool AllocateMem(TCHAR **TarObj,TCHAR *SrcObj,UINT32 NumOfChrsToCopy,bool IsAllocate=true);
		bool ReplaceChar(TCHAR *TarString,UINT32 NumOfCharsToConsider,TCHAR CharToReplace,TCHAR NewChar);
		bool CopyBytes(BYTE *Dst,BYTE *Src,UINT32 BytesToCopy);
		bool CopyBytes(BYTE **Dst,BYTE *Src,UINT32 BytesToCopy);
		bool AllocateNew(TCHAR **TarObj,TCHAR *SrcObj,UINT32 NumChars=0);
		void *ReAllocateMemory(void *MemoryBlock,size_t size_tNewSize);
		bool ReAllocateString(TCHAR **StringToReallocate,TCHAR *StringToAppend);
		bool GetMemoryBlockSize(void *pMemoryBlock,DWORD &dwSizeInBytes);
};


HANDLE CMemoryManager::m_hPrivateHeap = (HANDLE)HeapCreate((DWORD)0,100,(DWORD)0) ; 

bool CMemoryManager::SetLocalHeap(HANDLE &HndToHeap)
{
	m_hPrivateHeap = HndToHeap;
	return true;
}

HANDLE &CMemoryManager::GetLocalHeap(void)
{
	return (HANDLE&)m_hPrivateHeap; 
}

bool CMemoryManager::ReAllocateString(TCHAR **StringToReallocate,TCHAR *StringToAppend)
{
	if(!(*StringToReallocate)) return AllocateMem(StringToReallocate,StringToAppend);
	try
	{
		UINT32 uintLen=(UINT32)(_tcslen(*StringToReallocate)+_tcslen(StringToAppend)+1)*sizeof(TCHAR);
		_tcscat(*StringToReallocate=(TCHAR*)ReAllocateMemory(*StringToReallocate,uintLen),StringToAppend);
		return true;
	}
	catch(...)
	{
		return false;
	}
}

bool CMemoryManager::AllocateMem(void **TarObj,UINT32 NumberOfBytes)
{
	if(*TarObj) try { DeleteAll((void**)TarObj); } catch(...) {}
	*TarObj=(void*)HeapAlloc(m_hPrivateHeap,HEAP_ZERO_MEMORY,NumberOfBytes);
	if(!(*TarObj)) return false; else return true;
}

void *CMemoryManager::ReAllocateMemory(void *MemoryBlock,size_t size_tNewSize)
{
	if(MemoryBlock)
		return (void*)HeapReAlloc(m_hPrivateHeap,HEAP_ZERO_MEMORY,MemoryBlock,size_tNewSize);
	else 
		return (void*)HeapAlloc(m_hPrivateHeap,HEAP_ZERO_MEMORY,size_tNewSize);
}

bool CMemoryManager::AllocateNew(TCHAR **TarObj,TCHAR *SrcObj,UINT32 NumChars)
{ 
	try
	{
		//ULONG i;

		if(!SrcObj) return false;
		UINT32 Length=(NumChars?NumChars:_tcslen(SrcObj))+1;
		DeleteNew((void**)TarObj);
		*TarObj=new TCHAR[Length];
		memcpy(*TarObj,SrcObj,Length);
		(*TarObj)[Length-1]=_T('\0');
		return true;
	}
	catch(...) { return false; }

}

bool CMemoryManager::CopyBytes(BYTE **Dst,BYTE *Src,UINT32 BytesToCopy)
{
	if(*Dst) try { DeleteAll((void**)Dst); } catch(...) {}
	*Dst=(BYTE*)HeapAlloc(m_hPrivateHeap,HEAP_ZERO_MEMORY,(BytesToCopy));
	if(!(*Dst)) return false;
	else return CopyBytes(*Dst,Src,BytesToCopy);
}

bool CMemoryManager::CopyBytes(BYTE *Dst,BYTE *Src,UINT32 BytesToCopy)
{
	try
	{
		memcpy(Dst,Src,BytesToCopy);
		return true;
	}
	catch(...) { return false; }
}

void CMemoryManager::DeleteAll(void **ArrayObject)
{
	try
	{
		if(*ArrayObject && HeapSize(m_hPrivateHeap,0,*ArrayObject) > 0) //!=((sizeof(SIZE_T)) -1)) 
		{
			try 
			{ 
				HeapFree(m_hPrivateHeap,0,*ArrayObject); 
			} 
			catch(...) {}
		}

	}catch(...) {}
	*ArrayObject=0;
	return;
}

void CMemoryManager::DeleteNew(void **ArrayObject)
{
	try
	{	if(*ArrayObject && (_msize(*ArrayObject)>0)) 
		{
			try { delete[] (*ArrayObject); } catch(...) {}
		}
	}catch(...) {}
	*ArrayObject=0;
	return;
}

bool CMemoryManager::ReplaceChar(TCHAR *TarString,UINT32 NumOfCharsToConsider,TCHAR CharToReplace,TCHAR NewChar)
{
	try
	{
		if(!TarString) return false;

		for(ULONG i=0;i<NumOfCharsToConsider;i++)
			if(TarString[i]==CharToReplace) TarString[i]=NewChar;
		return true;
	}
	catch(...) { return false; }
}

bool CMemoryManager::AllocateMem(TCHAR **TarObj,TCHAR *SrcObj,UINT32 NumOfChrsToCopy,bool IsAllocate)
{
	try
	{
		if(!SrcObj) return false;
		if(IsAllocate) 
		{	
			DeleteAll((void**)TarObj);
			*TarObj=(TCHAR*)HeapAlloc(m_hPrivateHeap,HEAP_ZERO_MEMORY,(sizeof(TCHAR)*(NumOfChrsToCopy+1)));
		}
		memcpy(*TarObj,SrcObj,NumOfChrsToCopy);
		(*TarObj)[NumOfChrsToCopy]=_T('\0');
		return true;
	}
	catch(...) { return false; }

}

bool CMemoryManager::AllocateMem(TCHAR **TarObj,TCHAR *SrcObj)
{
	try
	{
		if(!SrcObj) return false;
		DeleteAll((void**)TarObj);
		*TarObj=(TCHAR*)HeapAlloc(m_hPrivateHeap,HEAP_ZERO_MEMORY,(sizeof(TCHAR)*(_tcslen(SrcObj)+1)));
		if(*TarObj) _tcscpy(*TarObj,SrcObj); else throw 0;
		return true;
	}
	catch(...) 
	{ 
		return false; 
	}
}

bool CMemoryManager::GetMemoryBlockSize(void *pMemoryBlock,DWORD &dwSizeInBytes)
{
	try {	dwSizeInBytes = HeapSize(m_hPrivateHeap,0,pMemoryBlock); }
	catch(...) { dwSizeInBytes = -1; }

	return ((long)dwSizeInBytes) != -1;
}

