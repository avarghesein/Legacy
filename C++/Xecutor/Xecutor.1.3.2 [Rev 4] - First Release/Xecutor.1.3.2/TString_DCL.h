#pragma once

#define EMPTY_TSTRING ""

#ifdef _CRTBLD
	#include <Internal.h>
#endif

#include <Tchar.h>
#include <Limits.h>
#include <Stdarg.h>

typedef UINT  (_stdcall *GetGenericDirectory) (LPTSTR lpBuffer,UINT uiBufferSize);
typedef DWORD (_stdcall *GetFixedDirectory) (DWORD dwBufferSize,LPTSTR lpBuffer);

class CTString : protected CMemoryManager 
{
	friend class CBytes;
	
	private:
		void Construct(TCHAR tcChar,long vlRepCount);
		CTString AppendFormat(TCHAR *tchrFormat,va_list ptrLst);

		#ifdef _CRTBLD
			int GetFormatStringLength(TCHAR *tchrFormat,va_list ptrLst);
		#endif

	protected: 
		TCHAR FAR *pvt_tchrString;

	public:
		static CTString GetDirectory(GetGenericDirectory DirectoryRetrievalAPIdelegate);
		static CTString GetDirectory(GetFixedDirectory DirectoryRetrievalAPIdelegate);
		static CTString CreateFolderLocation(CTString VirtualRootFolder,CTString RemainPath);
		static CTString GetLastErrorString(void);
		static CTString GetErrorString(long ErrorCode);
		static CTString NullString(void);
		static CTString Format(TCHAR *tchrFormat,...);

		CTString(void);
		CTString(double dValue);
		CTString(TCHAR* vptrCharPointer);
		CTString(TCHAR tcChar,long vlRepCount);		
		CTString(const CTString& robjStringToBeCloned);
		CTString(unsigned long vulValue,bool bIsBuffersize);		
	   ~CTString();
		
		CTString& CopyTo(CTString &rtsTarget,long vlTargetIndex = 0);	
		CTString& CopyTo(CTString &rtsTarget,long vlSrcIndex,long vlTargetIndex);	
		CTString& CopyTo(CTString &rtsTarget,long vlSrcIndex,long vlLength,long vlTargetIndex);	
		CTString  RemoveAt(long vlSrcIndex,long vlLength = 1);
		TCHAR     InsertAt(long vlSrcIndex,TCHAR tcCharToInsert);
		CTString& InsertAt(long vlSrcIndex,CTString &rtsTarget);
		CTString& InsertAt(long vlSrcIndex,CTString &rtsTarget,long vlTargetIndex);
		CTString& InsertAt(long vlSrcIndex,CTString &rtsTarget,long vlTargetIndex,long vlTargetLength);
		CTString  Left(long vlLength);
		CTString  Right(long vlLength);

		CTString GetDirectoryPart(void);
		CTString GetFileNamePart(void);
		CTString Append(CTString &robjStringToBeAppend);
		CTString Append(TCHAR* vptrCharPointerToBeAppend);
		long LastIndexOf(TCHAR vtchrCharToFound);
		long LastIndexOf(TCHAR *vtchrSubStringToFound);
		long LastIndexOf(CTString &robjSubStringToFound);
		long IndexOf(TCHAR vtchrCharToFound);
		long IndexOf(TCHAR *vtchrSubStringToFound);
		long IndexOf(CTString &robjSubStringToFound);
		CTString Cut(unsigned long vulStartIndex);
		CTString Cut(unsigned long vulStartIndex,unsigned long vulNumberOfCharactersToCut);
		long Length(bool InBytes = false);
		void Clear(void);
		bool SplitByToken(TCHAR *vtchrToken,CTString &robjFirstPart,CTString &robjSecondPart,bool bLeftToRight = true);
		bool SplitByToken(CTString robjToken,CTString &robjFirstPart,CTString &robjSecondPart,bool bLeftToRight = true);
		long SplitByToken(TCHAR *vtchrToken,CTString* &roSplittedStrings,bool bLeftToRight = true);
		long SplitByToken(CTString robjToken,CTString* &roSplittedStrings,bool bLeftToRight = true);
		CTString AttachAnotherFileName(CTString vobjAnotherFileName);
		CTString AttachAnotherFileName(TCHAR *vptrAnotherFileName);
		bool CreatePath(void);
		CTString ToLower(void);
		CTString ToUpper(void);
		CTString LTrim(void);
		CTString RTrim(void);
		CTString Trim(void);
		CTString Replace(TCHAR tcCharInString,TCHAR tcCharNew);

		CTString Replace(TCHAR* tSubStr,TCHAR *tNewSubStr);
		CTString Replace(TCHAR* tSubStr,CTString tNewSubStr);
		CTString Replace(CTString tSubStr,TCHAR *tNewSubStr);
		CTString Replace(CTString tSubStr,CTString tNewSubStr);

		bool StartsWith(TCHAR *vtchrSubString);
		bool StartsWith(CTString &robjSubString);
		bool EndsWith(TCHAR *vtchrSubString);
		bool EndsWith(CTString &robjSubString);
		void Swap(CTString &tsStringToSwap);
		CTString Construct(long lValue);
		CTString Construct(double dValue);
		int IsEmpty(void);
		CTString AppendFormat(TCHAR *tchrFormat,...);

		operator const TCHAR*(void);
		operator TCHAR*(void);
		operator long(void);
		operator double(void);
		operator CBytes(void); 
		CTString& operator=(const CTString &robjStringToBeAssigned);
		CTString& operator=(TCHAR* vptrCharPointer);
		CTString operator+=(CTString &robjStringToBeAppend);
		CTString operator+=(TCHAR* vptrCharPointerToBeAppend);
		CTString operator+=(long lValueToAppend);
		CTString operator+=(double dValueToAppend);	

		friend CTString operator+(CTString &robjFirstString,CTString &robjSecondString);
		friend CTString operator+(CTString &robjFirstString,TCHAR* vptrCharPointer);
		friend CTString operator+(TCHAR* vptrCharPointer,CTString &robjSecondString);		
		friend CTString operator+(CTString &robjFirstString,long lValue);
		friend CTString operator+(long lValue,CTString &robjSecondString);
		friend CTString operator+(CTString &robjFirstString,double dValue);
		friend CTString operator+(double dValue,CTString &robjSecondString);

		TCHAR& operator[](long vulIndex);
		int operator==(UINT64 uiAddress);
		int operator!=(UINT64 uiAddress);
		int operator==(CTString vobjStringToBeCompared);
		int operator!=(TCHAR* vptrStringToBeCompared);
		int operator==(TCHAR* vptrStringToBeCompared);
		int operator!=(CTString vobjStringToBeCompared);

		bool Convert(CBytes &Bytes,bool IncludeTerminatingNull = false);
};