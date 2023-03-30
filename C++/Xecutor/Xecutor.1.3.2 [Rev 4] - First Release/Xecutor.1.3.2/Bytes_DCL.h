
#pragma once

class CTString;

class CBytes : protected CMemoryManager 
{
	private: 
		BYTE FAR *mpMemoryBlock;
	
	private:
		void Copy(void *pMemBlock,DWORD dwSize);

	public:
		static CBytes NullBytes(void);

		CBytes(void);
		CBytes(void *pMemBlock,DWORD dwSize);
		CBytes(CBytes &oCopyObj);
		CBytes(DWORD dwSize);
	   ~CBytes(void);

	    void   Clear(void);
	    long   Length(void);
 	    bool   Append(CBytes &robjToAppend);
		bool   Append(void *pMemBlock,long lSize);
		void   Swap(CBytes &robjToSwap);

		operator const FAR BYTE*(void);
		operator FAR BYTE*(void);
		bool operator !(void);
		bool operator ==(int iBoolVal);
		bool operator !=(int iBoolVal);
		CBytes& operator+=(CBytes &roSecondOperand);
		CBytes& operator+=(BYTE ByteToAppend);
		CBytes& operator+=(ULONG ulngSize);
		CBytes& operator=(CBytes &roSecondOperand);
		BYTE& operator[](long Index);
	    friend CBytes  operator+(CBytes &roFirstOperand,CBytes &roSecondOperand);

		CBytes& CopyTo(CBytes &rTarget,long vlTargetIndex = 0);	
		CBytes& CopyTo(CBytes &rTarget,long vlSrcIndex,long vlTargetIndex);	
		CBytes& CopyTo(CBytes &rTarget,long vlSrcIndex,long vlLength,long vlTargetIndex);	
		CBytes  Left(long vlLength);
		CBytes  Right(long vlLength);
		CBytes Cut(long vlStartIndex);
		CBytes Cut(long vlStartIndex,long vlNumberOfCharactersToCut);

		BYTE    InsertAt(long vlSrcIndex,BYTE ByteToInsert);
		CBytes& InsertAt(long vlSrcIndex,CBytes &rTarget);
		CBytes& InsertAt(long vlSrcIndex,CBytes &rTarget,long vlTargetIndex);
		CBytes& InsertAt(long vlSrcIndex,CBytes &rTarget,long vlTargetIndex,long vlTargetLength);

		CBytes& InsertAt(long vlSrcIndex,void *pMemBlock,long lSize);
		CBytes& InsertAt(long vlSrcIndex,void *pMemBlock,long lSize,long vlTargetIndex);
		CBytes& InsertAt(long vlSrcIndex,void *pMemBlock,long lSize,long vlTargetIndex,long vlTargetLength);

		CBytes  RemoveAt(long vlSrcIndex,long vlLength = 1);
		bool SetMemoryBlock(void *pMemBlock,DWORD dwSize);

		bool Convert(CTString &String);

		friend FAR BYTE* operator+(CBytes &Bytes,long Value);
		friend FAR BYTE* operator+(long Value,CBytes &Bytes);
};
