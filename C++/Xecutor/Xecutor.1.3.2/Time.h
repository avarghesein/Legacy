#pragma once

//1 Sec: 1 sec -> 1000 milli sec; 1 milli sec -> 1000000 nano sec

#define SMALL_INT __int32
#define BIG_INT   __int64
 
enum ETimeInclude
{
	Hr = 0,
	HrMin = 1,
	HrMinSec = 2,
	HrMinSecMilli = 3,
	HrMinSecMilliNano = 4
};

class CTime
{
private:
	bool mb24HourClock;
	SMALL_INT mHrs,mMins,mSecs;
	BIG_INT   mMilliSecs,mNanoSecs;
	
private:
	void Initialize(void);

public:
	CTime(void);
	CTime(SYSTEMTIME sysTime);
	CTime(SMALL_INT Hour,SMALL_INT Mins = 0,SMALL_INT Secs = 0,BIG_INT MilliSecs = 0,BIG_INT NanoSecs = 0); 

	void UseClock(bool b24HourClock = true);

	SMALL_INT Hour(void);
	SMALL_INT Minute(void);
	SMALL_INT Second(void);
	BIG_INT   MilliSecond(void);
	BIG_INT   NanoSecond(void);

	SMALL_INT GetTimeInHours(void);
	SMALL_INT GetTimeInMinutes(void);
	SMALL_INT GetTimeInSeconds(void);
	BIG_INT   GetTimeInMilliSeconds(void);
	BIG_INT   GetTimeInNanoSeconds(void);
	BIG_INT   GetTimeInMultipleOfNanoSeconds(BIG_INT biNanoMultiple = 100);

	long double GetTimeInHoursIncludingDecimalPoint(void);
	long double GetTimeInMinutesIncludingDecimalPoint(void);
	long double GetTimeInSecondsIncludingDecimalPoint(void);
	long double GetTimeInMilliSecondsIncludingDecimalPoint(void);
	long double GetTimeInNanoSecondsIncludingDecimalPoint(void);
	long double GetTimeInMultipleOfNanoSecondsIncludingDecimalPoint(BIG_INT biNanoMultiple = 100);

	CTime operator=(CTime &tCopy);

	friend CTime operator+(CTime tFirst,CTime tSecond);
	friend CTime operator-(CTime tFirst,CTime tSecond);

	friend bool operator<(CTime tFirst,CTime tSecond);
	friend bool operator>(CTime tFirst,CTime tSecond);
	friend bool operator==(CTime tFirst,CTime tSecond);
	friend bool operator!=(CTime tFirst,CTime tSecond);
	friend bool operator<=(CTime tFirst,CTime tSecond);
	friend bool operator>=(CTime tFirst,CTime tSecond);

	CTime Add(CTime tTimeToAdd,bool bAdjustToClockIfExceeds = false);
	CTime Subtract(CTime tTimeToAdd,bool bAdjustToClockIfExceeds = false);

	CTime AddHours(SMALL_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime AddMinutes(SMALL_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime AddSeconds(SMALL_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime AddMilliSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime AddNanoSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds = true);

	CTime SubtractHours(SMALL_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime SubtractMinutes(SMALL_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime SubtractSeconds(SMALL_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime SubtractMilliSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds = true);
	CTime SubtractNanoSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds = true);

	CTString ToString(CTString Seperator,ETimeInclude Include); 

	static CTString CurrentDate(CTString Format);
	static CTString CurrentTime(CTString Format);
	static CTString CurrentDateTime(CTString DateFormat,CTString TimeFormat,CTString Seperator);
};

SMALL_INT CTime::Hour(void) { return mHrs; } 
SMALL_INT CTime::Minute(void) { return mMins; }  
SMALL_INT CTime::Second(void) { return mSecs; }  
BIG_INT   CTime::MilliSecond(void) { return mMilliSecs; } 
BIG_INT   CTime::NanoSecond(void) { return mNanoSecs; } 


CTString CTime::ToString(CTString Seperator,ETimeInclude Include)
{
	CTString sRet;

	switch(Include)
	{
		case HrMinSecMilliNano: 
			{
				sRet = CTString::Format(Seperator + "%ld",mNanoSecs) + sRet;  
			}
		case HrMinSecMilli:
			{
				sRet = CTString::Format(Seperator + "%ld",mMilliSecs) + sRet;  
			}
		case HrMinSec:
			{
				sRet = CTString::Format(Seperator + "%ld",mSecs) + sRet;  
			}
		case HrMin:
			{
				sRet = CTString::Format(Seperator + "%ld",mMins) + sRet;  
			}
		default://case Hr:		
			{
				sRet = CTString::Format(Seperator + "%ld",mHrs) + sRet;  
			}
	}
	return sRet.Cut(Seperator.Length());  
}

CTime CTime::SubtractHours(SMALL_INT Period,bool bAdjustToClockIfExceeds)
{
	return AddHours(-Period,bAdjustToClockIfExceeds);
}

CTime CTime::SubtractMinutes(SMALL_INT Period,bool bAdjustToClockIfExceeds)
{
	return AddMinutes(-Period,bAdjustToClockIfExceeds);
}

CTime CTime::SubtractSeconds(SMALL_INT Period,bool bAdjustToClockIfExceeds)
{
	return AddSeconds(-Period,bAdjustToClockIfExceeds);
}

CTime CTime::SubtractMilliSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds)
{
	return AddMilliSeconds(-Period,bAdjustToClockIfExceeds);
}

CTime CTime::SubtractNanoSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds)
{
	return AddNanoSeconds(-Period,bAdjustToClockIfExceeds);
}

CTime CTime::AddHours(SMALL_INT Period,bool bAdjustToClockIfExceeds)
{
	SMALL_INT stClockPeriod = mb24HourClock ? 24 : 12;
	mHrs += Period;
	if(bAdjustToClockIfExceeds)
	{
		mHrs %= stClockPeriod;
		if(mHrs < 0)  mHrs = stClockPeriod + mHrs;
	}
	return *this;
}

CTime CTime::AddMinutes(SMALL_INT Period,bool bAdjustToClockIfExceeds)
{
	SMALL_INT stClockPeriod = mb24HourClock ? 24 : 12;
	SMALL_INT siQuo = (mMins + Period) / 60;
	mMins = (mMins + Period) % 60;
	if(mMins < 0) mMins = 60 + mMins,--siQuo;
	mHrs += siQuo;
	if(bAdjustToClockIfExceeds)
	{
		mHrs %= stClockPeriod;
		if(mHrs < 0)  mHrs = stClockPeriod + mHrs;
	}
	return *this;
}

CTime CTime::AddSeconds(SMALL_INT Period,bool bAdjustToClockIfExceeds)
{
	SMALL_INT stClockPeriod = mb24HourClock ? 24 : 12;
	SMALL_INT siQuo = (mSecs + Period) / 60;
	mSecs = (mSecs + Period) % 60;
	if(mSecs < 0) mSecs = 60 + mSecs,--siQuo;
	mMins += siQuo;
	siQuo = mMins / 60;
	mMins = mMins % 60;
	if(mMins < 0) mMins = 60 + mMins,--siQuo;
	mHrs += siQuo;
	if(bAdjustToClockIfExceeds)
	{
		mHrs %= stClockPeriod;
		if(mHrs < 0)  mHrs = stClockPeriod + mHrs;
	}
	return *this;
}

CTime CTime::AddMilliSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds)
{
	SMALL_INT stClockPeriod = mb24HourClock ? 24 : 12;
	SMALL_INT siQuo = (SMALL_INT)((mMilliSecs + Period) / (BIG_INT)1000);
	mMilliSecs = (mMilliSecs + Period) % 1000;
	if(mMilliSecs < 0) mMilliSecs = 1000 + mMilliSecs,--siQuo;
	mSecs += siQuo;
	siQuo = mSecs / 60;
	mSecs = mSecs % 60;
	if(mSecs < 0) mSecs = 60 + mSecs,--siQuo;
	mMins += siQuo;
	siQuo = mMins / 60;
	mMins = mMins % 60;
	if(mMins < 0) mMins = 60 + mMins,--siQuo;
	mHrs += siQuo;
	if(bAdjustToClockIfExceeds)
	{
		mHrs %= stClockPeriod;
		if(mHrs < 0)  mHrs = stClockPeriod + mHrs;
	}
	return *this;
}

CTime CTime::AddNanoSeconds(BIG_INT Period,bool bAdjustToClockIfExceeds)
{
	SMALL_INT stClockPeriod = mb24HourClock ? 24 : 12;
	SMALL_INT siQuo;
	BIG_INT biQuo = (mNanoSecs + Period) / 1000000;
	mNanoSecs = (mNanoSecs + Period) % 1000000;
	if(mNanoSecs < 0) mNanoSecs = 1000000 + mNanoSecs,--biQuo;
	mMilliSecs += biQuo; 
	siQuo = (SMALL_INT)(mMilliSecs /(BIG_INT)1000);
	mMilliSecs = mMilliSecs % 1000;
	if(mMilliSecs < 0) mMilliSecs = 1000 + mMilliSecs,--siQuo;
	mSecs += siQuo;
	siQuo = mSecs / 60;
	mSecs = mSecs % 60;
	if(mSecs < 0) mSecs = 60 + mSecs,--siQuo;
	mMins += siQuo;
	siQuo = mMins / 60;
	mMins = mMins % 60;
	if(mMins < 0) mMins = 60 + mMins,--siQuo;
	mHrs += siQuo;
	if(bAdjustToClockIfExceeds)
	{
		mHrs %= stClockPeriod;
		if(mHrs < 0)  mHrs = stClockPeriod + mHrs;
	}
	return *this;
}

long double CTime::GetTimeInHoursIncludingDecimalPoint(void)
{
	long double ldRet = (long double)mNanoSecs;
	ldRet /= (long double)1000000;
	ldRet += (long double)mMilliSecs;
	ldRet /= (long double)1000;
	ldRet += (long double)mSecs;
	ldRet /= (long double)60;
	ldRet += (long double)mMins;
	ldRet /= (long double)60;
	ldRet += (long double)mHrs;
	return ldRet;
}

long double CTime::GetTimeInMinutesIncludingDecimalPoint(void)
{
	long double ldRet = (long double)mNanoSecs;
	ldRet /= (long double)1000000;
	ldRet += (long double)mMilliSecs;
	ldRet /= (long double)1000;
	ldRet += (long double)mSecs;
	ldRet /= (long double)60;
	ldRet += (long double)mMins;
	ldRet += (long double)60 * mHrs; 
	return ldRet;
}

long double CTime::GetTimeInSecondsIncludingDecimalPoint(void)
{
	long double ldRet = (long double)mNanoSecs;
	ldRet /= (long double)1000000;
	ldRet += (long double)mMilliSecs;
	ldRet /= (long double)1000;
	ldRet += (long double)mSecs;
	ldRet += (long double)60 * mMins + (long double)60 * 60 * mHrs;
	return ldRet;
}

long double CTime::GetTimeInMilliSecondsIncludingDecimalPoint(void)
{
	long double ldRet = (long double)mNanoSecs;
	ldRet /= (long double)1000000;
	ldRet += (long double)mMilliSecs;
	ldRet += ((long double)mSecs + (long double)60 * mMins + (long double)60 * 60 * mHrs)*1000;
	return ldRet;
}

long double CTime::GetTimeInNanoSecondsIncludingDecimalPoint(void)
{
	long double ldRet = (long double)mNanoSecs;
	ldRet += ((long double)mMilliSecs + ((long double)mSecs + (long double)60 * mMins + (long double)60 * 60 * mHrs)*1000) * 1000000;
	return ldRet;
}

long double CTime::GetTimeInMultipleOfNanoSecondsIncludingDecimalPoint(BIG_INT biNanoMultiple)
{
	long double ldRet = (long double)mNanoSecs;
	ldRet += ((long double)mMilliSecs + ((long double)mSecs + (long double)60 * mMins + (long double)60 * 60 * mHrs)*1000) * 1000000;
	ldRet /= biNanoMultiple;
	return ldRet;
}

SMALL_INT CTime::GetTimeInHours(void)
{
	return (SMALL_INT)GetTimeInHoursIncludingDecimalPoint();
}

SMALL_INT CTime::GetTimeInMinutes(void)
{
	return (SMALL_INT)GetTimeInMinutesIncludingDecimalPoint();
}

SMALL_INT CTime::GetTimeInSeconds(void)
{
	return (SMALL_INT)GetTimeInSecondsIncludingDecimalPoint();
}

BIG_INT CTime::GetTimeInMilliSeconds(void)
{
	return (BIG_INT)GetTimeInMilliSecondsIncludingDecimalPoint();
}

BIG_INT CTime::GetTimeInNanoSeconds(void)
{
	return (BIG_INT)GetTimeInNanoSecondsIncludingDecimalPoint();
}

BIG_INT CTime::GetTimeInMultipleOfNanoSeconds(BIG_INT biNanoMultiple)
{
	return (BIG_INT)GetTimeInMultipleOfNanoSecondsIncludingDecimalPoint(biNanoMultiple);
}

void CTime::Initialize(void)
{
	 mHrs = mMins = mSecs = 0;
	 mMilliSecs = mNanoSecs = 0;
	 mb24HourClock = true;
}

void CTime::UseClock(bool b24HourClock)
{
	mb24HourClock = b24HourClock;
}

CTime::CTime(void) { Initialize(); }

CTime::CTime(SYSTEMTIME sysTime)
{
	Initialize();
	mMilliSecs = sysTime.wMilliseconds; 
	mSecs = sysTime.wSecond,mMins = sysTime.wMinute,mHrs = sysTime.wHour;
}

CTime::CTime(SMALL_INT Hour,SMALL_INT Mins,SMALL_INT Secs,BIG_INT MilliSecs,BIG_INT NanoSecs)
{
	Initialize();
	mHrs = Hour,mMins = Mins,mSecs = Secs;
	mMilliSecs = MilliSecs,mNanoSecs = NanoSecs;
}

CTime operator+(CTime tFirst,CTime tSecond)
{
	return tFirst.AddNanoSeconds(tSecond.mNanoSecs).AddMilliSeconds(tSecond.mMilliSecs).AddSeconds(tSecond.mSecs).AddMinutes(tSecond.mMins).AddHours(tSecond.mHrs);           
}

CTime operator-(CTime tFirst,CTime tSecond)
{
	return tFirst.SubtractNanoSeconds(tSecond.mNanoSecs).SubtractMilliSeconds(tSecond.mMilliSecs).SubtractSeconds(tSecond.mSecs).SubtractMinutes(tSecond.mMins).SubtractHours(tSecond.mHrs);           
}

CTime CTime::Add(CTime tTimeToAdd,bool bAdjustToClockIfExceeds)
{
	return (*this).AddNanoSeconds(tTimeToAdd.mNanoSecs,bAdjustToClockIfExceeds).
		           AddMilliSeconds(tTimeToAdd.mMilliSecs,bAdjustToClockIfExceeds).
				   AddSeconds(tTimeToAdd.mSecs,bAdjustToClockIfExceeds).
				   AddMinutes(tTimeToAdd.mMins,bAdjustToClockIfExceeds).
				   AddHours(tTimeToAdd.mHrs,bAdjustToClockIfExceeds);           
}

CTime CTime::Subtract(CTime tTimeToAdd,bool bAdjustToClockIfExceeds)
{
	return (*this).SubtractNanoSeconds(tTimeToAdd.mNanoSecs,bAdjustToClockIfExceeds).
		           SubtractMilliSeconds(tTimeToAdd.mMilliSecs,bAdjustToClockIfExceeds).
				   SubtractSeconds(tTimeToAdd.mSecs,bAdjustToClockIfExceeds).
				   SubtractMinutes(tTimeToAdd.mMins,bAdjustToClockIfExceeds).
				   SubtractHours(tTimeToAdd.mHrs,bAdjustToClockIfExceeds);           
}

bool operator<(CTime tFirst,CTime tSecond)
{
	return tFirst.GetTimeInNanoSeconds() < tSecond.GetTimeInNanoSeconds(); 
}

bool operator>(CTime tFirst,CTime tSecond)
{
	return tFirst.GetTimeInNanoSeconds() > tSecond.GetTimeInNanoSeconds(); 
}

bool operator==(CTime tFirst,CTime tSecond)
{
	return tFirst.GetTimeInNanoSeconds() == tSecond.GetTimeInNanoSeconds(); 
}

bool operator!=(CTime tFirst,CTime tSecond)
{
	return tFirst.GetTimeInNanoSeconds() != tSecond.GetTimeInNanoSeconds(); 
}

bool operator<=(CTime tFirst,CTime tSecond)
{
	return tFirst.GetTimeInNanoSeconds() <= tSecond.GetTimeInNanoSeconds(); 
}

bool operator>=(CTime tFirst,CTime tSecond)
{
	return tFirst.GetTimeInNanoSeconds() >= tSecond.GetTimeInNanoSeconds(); 
}

CTime CTime::operator=(CTime &tCopy)
{
	mb24HourClock = tCopy.mb24HourClock;
	mHrs = tCopy.mHrs,mMins = tCopy.mMins,mSecs = tCopy.mSecs;
	mMilliSecs = tCopy.mMilliSecs,mNanoSecs = tCopy.mNanoSecs;
	return *this;
}

CTString CTime::CurrentDate(CTString Format)
{
	char sBuff[250]; sBuff[0]= 0;
	Format = Format.Replace(":","':'").Replace("-","'-'").Replace("_","'_'").Replace(",","','");
	GetDateFormat(LOCALE_SYSTEM_DEFAULT, LOCALE_USE_CP_ACP, NULL,(TCHAR*)Format, sBuff,250);
	return CTString(sBuff);
}

CTString CTime::CurrentTime(CTString Format)
{
	char sBuff[250]; sBuff[0]= 0;
	Format = Format.Replace(":","':'").Replace("-","'-'").Replace("_","'_'").Replace(",","','");
	GetTimeFormat(LOCALE_SYSTEM_DEFAULT,LOCALE_USE_CP_ACP, NULL,(TCHAR*)Format,sBuff,250);
	return CTString(sBuff);
}

CTString CTime::CurrentDateTime(CTString DateFormat,CTString TimeFormat,CTString Seperator)
{
	return CurrentDate(DateFormat) + Seperator + CurrentTime(TimeFormat); 
}