
#define HKEY_PERFORMANCE_TEXT       (( HKEY )((LONG)0x80000050) )
#define HKEY_PERFORMANCE_NLSTEXT    (( HKEY )((LONG)0x80000060) )

#define REG_QWORD                   ( 11 )  // 64-bit number
#define REG_QWORD_LITTLE_ENDIAN     ( 11 )  // 64-bit number (same as REG_QWORD)

enum ERegistryRootKeys
{
	KEY_CLASSES_ROOT = 0,
	KEY_CURRENT_CONFIG = 1,
	KEY_CURRENT_USER = 2,
	KEY_LOCAL_MACHINE = 3,
	KEY_USERS = 4,
	KEY_DYN_DATA = 5,
	KEY_PERFORMANCE_DATA = 6,
	KEY_PERFORMANCE_NLSTEXT = 7,
	KEY_PERFORMANCE_TEXT = 8
};

enum ERegistryDataTypes
{
	TYPE_NONE = 0,
	TYPE_SZ = 1,
	TYPE_EXPAND_SZ = 2,
	TYPE_BINARY = 3,
	TYPE_DWORD = 4,
	TYPE_DWORD_LITTLE_ENDIAN = 5,
	TYPE_DWORD_BIG_ENDIAN = 6,
	TYPE_LINK = 7,
	TYPE_MULTI_SZ = 8,
	TYPE_RESOURCE_LIST = 9,
	TYPE_FULL_RESOURCE_DESCRIPTOR = 10,
	TYPE_RESOURCE_REQUIREMENTS_LIST = 11,
	TYPE_QWORD = 12,
	TYPE_QWORD_LITTLE_ENDIAN = 13
};


class CRegistry
{
private:
	HKEY mHeadKey;

private:
	static HKEY GetRootKey(ERegistryRootKeys Root);
	static DWORD GetDataType(ERegistryDataTypes Type);
	static ERegistryDataTypes GetDataType(DWORD Type);
	bool Open(HKEY Root,CTString KeyHierarchy,HKEY &Key);
	bool Create(HKEY Root,CTString KeyHierarchy,HKEY &Key);
	bool DeleteKey(HKEY Root,CTString KeyHierarchy);
	bool Close(HKEY Key);
	inline bool Valid(HKEY Key) { return Key != (HKEY)-1; }
	bool QueryKeyInformation(HKEY Key,int *Keys = 0,int *Values = 0,int *MaxKeyLen = 0,int *MaxValueNameLen = 0,int *MaxValueDataLen = 0);
	bool QueryKeyInformation(HKEY Key,int Index,CTString &SubKeyName);
	bool QueryValueInformation(HKEY Key,int Index,CTString *ValueName = 0,CBytes *ValueData = 0,ERegistryDataTypes *DataType = 0);
	int FindIndexUsingValueName(CTString ValueName);
	int FindIndexUsingKeyName(CTString SubKeyName);

public:
	static const CTString DefaultValueName;

	static CRegistry OpenRegistryKey(ERegistryRootKeys Root,CTString KeyHierarchy);
	static CRegistry CreateRegistryKey(ERegistryRootKeys Root,CTString KeyHierarchy);

public:
	CRegistry(void);
	~CRegistry(void) { Close(); };
	CRegistry(ERegistryRootKeys Root);
	CRegistry(CRegistry &Copy);

	CRegistry OpenSubTree(CTString KeyHierarchy);
	CRegistry CreateSubTree(CTString KeyHierarchy);

	bool Open(ERegistryRootKeys Root,CTString KeyHierarchy);
	bool Open(CTString KeyHierarchy);
	bool Create(ERegistryRootKeys Root,CTString KeyHierarchy);
	bool Create(CTString KeyHierarchy);
	bool DeleteKey(ERegistryRootKeys Root,CTString KeyHierarchy);
	bool DeleteKey(CTString KeyHierarchy);
	bool Close(void);

	bool SetValue(CTString ValueName,CBytes &ValueData,ERegistryDataTypes Type);  
	bool SetValue(CTString ValueName,CTString ValueData);  
	bool DeleteValue(CTString ValueName);

	int KeysCount(void);
	int ValuesCount(void);

	bool SubKeyAt(int Index,CTString &KeyName);
	CRegistry SubKeyAt(int Index);
	CRegistry SubKey(CTString SubKeyName);
	bool ValueNameAt(int Index,CTString &ValueName);
	bool ValueDataAt(int Index,CBytes &ValueData);
	bool ValueDataStringAt(int Index,CTString &ValueData);
	bool ValueTypeAt(int Index,ERegistryDataTypes &Type);

	bool ValueData(CTString ValueName,CBytes &ValueData);
	bool ValueDataString(CTString ValueName,CTString &ValueData);
	bool ValueType(CTString ValueName,ERegistryDataTypes &Type);
	
	bool Value(CTString ValueName,CBytes &ValueData,ERegistryDataTypes &Type);
	bool Value(int Index,CTString &ValueName,CBytes &ValueData,ERegistryDataTypes &Type);
	bool Value(int Index,CTString &ValueName,CTString &ValueData);

	bool inline Valid(void) { return Valid(mHeadKey); }  

	CRegistry& operator=(CRegistry &RegKey);
};

const CTString CRegistry::DefaultValueName = EMPTY_TSTRING;

ERegistryDataTypes CRegistry::GetDataType(DWORD Type)
{
	switch(Type)
	{
		case REG_NONE: return TYPE_NONE;
		case REG_SZ: return TYPE_SZ; 
		case REG_EXPAND_SZ: return TYPE_EXPAND_SZ;
		case REG_BINARY: return TYPE_BINARY;
		case REG_DWORD: return TYPE_DWORD;
		//case REG_DWORD_LITTLE_ENDIAN: return TYPE_DWORD_LITTLE_ENDIAN;
		case REG_DWORD_BIG_ENDIAN: return TYPE_DWORD_BIG_ENDIAN;
		case REG_LINK: return TYPE_LINK;
		case REG_MULTI_SZ: return TYPE_MULTI_SZ;
		case REG_RESOURCE_LIST: return TYPE_RESOURCE_LIST;
		case REG_FULL_RESOURCE_DESCRIPTOR: return TYPE_FULL_RESOURCE_DESCRIPTOR;
		case REG_RESOURCE_REQUIREMENTS_LIST: return TYPE_RESOURCE_REQUIREMENTS_LIST;
		case REG_QWORD: return TYPE_QWORD;
		//case REG_QWORD_LITTLE_ENDIAN: return TYPE_QWORD_LITTLE_ENDIAN;
	}
	return TYPE_NONE;
}

DWORD CRegistry::GetDataType(ERegistryDataTypes Type)
{
	switch(Type)
	{
		case TYPE_NONE: return REG_NONE;
		case TYPE_SZ: return REG_SZ; 
		case TYPE_EXPAND_SZ: return REG_EXPAND_SZ;
		case TYPE_BINARY: return REG_BINARY;
		case TYPE_DWORD: return REG_DWORD;
		case TYPE_DWORD_LITTLE_ENDIAN: return REG_DWORD_LITTLE_ENDIAN;
		case TYPE_DWORD_BIG_ENDIAN: return REG_DWORD_BIG_ENDIAN;
		case TYPE_LINK: return REG_LINK;
		case TYPE_MULTI_SZ: return REG_MULTI_SZ;
		case TYPE_RESOURCE_LIST: return REG_RESOURCE_LIST;
		case TYPE_FULL_RESOURCE_DESCRIPTOR: return REG_FULL_RESOURCE_DESCRIPTOR;
		case TYPE_RESOURCE_REQUIREMENTS_LIST: return REG_RESOURCE_REQUIREMENTS_LIST;
		case TYPE_QWORD: return REG_QWORD;
		case TYPE_QWORD_LITTLE_ENDIAN: return REG_QWORD_LITTLE_ENDIAN;
	}
	return REG_NONE;
}

HKEY CRegistry::GetRootKey(ERegistryRootKeys Root)
{
	switch(Root)
	{
		case KEY_CLASSES_ROOT: return HKEY_CLASSES_ROOT;
		case KEY_CURRENT_CONFIG: return HKEY_CURRENT_CONFIG;
		case KEY_CURRENT_USER: return HKEY_CURRENT_USER;
		case KEY_LOCAL_MACHINE: return HKEY_LOCAL_MACHINE;
		case KEY_USERS: return HKEY_USERS;
		case KEY_DYN_DATA: return HKEY_DYN_DATA;
		case KEY_PERFORMANCE_DATA: return HKEY_PERFORMANCE_DATA;
		case KEY_PERFORMANCE_NLSTEXT: return HKEY_PERFORMANCE_NLSTEXT;
		case KEY_PERFORMANCE_TEXT: return HKEY_PERFORMANCE_TEXT;
	}
	return (HKEY)(LONG)-1;
}

CRegistry::CRegistry(void)
{
	mHeadKey = (HKEY)(LONG)-1;
}

CRegistry::CRegistry(ERegistryRootKeys Root)
{
	mHeadKey = GetRootKey(Root);
}

CRegistry::CRegistry(CRegistry &Copy)
{
	CTString emptySubKey;
	if(!Copy.Open(Copy.mHeadKey,emptySubKey,mHeadKey)) mHeadKey = (HKEY)(LONG)-1;  
}

bool CRegistry::DeleteKey(HKEY Root,CTString KeyHierarchy)
{
	if(!Valid(Root)) return false;
	return ERROR_SUCCESS == RegDeleteKey(Root,(TCHAR*)KeyHierarchy); 
}

bool CRegistry::Open(HKEY Root,CTString KeyHierarchy,HKEY &Key)
{
	if(!Valid(Root)) return false;
	return ERROR_SUCCESS == RegOpenKeyEx(Root,(TCHAR*)KeyHierarchy,0,KEY_ALL_ACCESS,&Key);   
}

bool CRegistry::Create(HKEY Root,CTString KeyHierarchy,HKEY &Key)
{
	if(!Valid(Root)) return false;
	return ERROR_SUCCESS == RegCreateKeyEx(Root,KeyHierarchy,0,0,REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,0,&Key,0); 
}

bool CRegistry::Open(ERegistryRootKeys Root,CTString KeyHierarchy)
{
	Close(),mHeadKey = GetRootKey(Root);
	return Open(mHeadKey,KeyHierarchy,mHeadKey);
}

bool CRegistry::Close(HKEY Key)
{
	if(!Valid(Key)) return true;
	return ERROR_SUCCESS == RegCloseKey(Key); 
}

bool CRegistry::Close(void)
{
	if(Close(mHeadKey)) 
	{
		mHeadKey = (HKEY)(LONG)-1; 
		return true;
	}
	return false;
}

bool CRegistry::Open(CTString KeyHierarchy)
{
	if(!Valid(mHeadKey)) return false;
	HKEY tmpKey = mHeadKey;
	bool openSuccess = Open(tmpKey,KeyHierarchy,mHeadKey);  
	if(openSuccess) Close(tmpKey); else mHeadKey = tmpKey;
	return openSuccess;	
}

bool CRegistry::Create(ERegistryRootKeys Root,CTString KeyHierarchy)
{
	Close(),mHeadKey = GetRootKey(Root);
	return Create(mHeadKey,KeyHierarchy,mHeadKey);
}

bool CRegistry::Create(CTString KeyHierarchy)
{
	if(!Valid(mHeadKey)) return false;
	HKEY tmpKey = mHeadKey;
	bool openSuccess = Create(tmpKey,KeyHierarchy,mHeadKey);  
	if(openSuccess) Close(tmpKey); else mHeadKey = tmpKey;
	return openSuccess;	
}

bool CRegistry::DeleteKey(ERegistryRootKeys Root,CTString KeyHierarchy)
{
	Close(),mHeadKey = GetRootKey(Root);
	return DeleteKey(mHeadKey,KeyHierarchy);
}

bool CRegistry::DeleteKey(CTString KeyHierarchy)
{
	if(!Valid(mHeadKey)) return false;
	return DeleteKey(mHeadKey,KeyHierarchy);  
}

bool CRegistry::SetValue(CTString ValueName,CBytes &ValueData,ERegistryDataTypes Type)
{
	if(!Valid(mHeadKey) || ValueData.Length() <= 0) return false; 
	return ERROR_SUCCESS == RegSetValueEx(mHeadKey,(TCHAR*)ValueName,0,GetDataType(Type),(BYTE*)ValueData,ValueData.Length());      
}

bool CRegistry::SetValue(CTString ValueName,CTString ValueData)
{
	CBytes bytes;
	if(ValueData.IsEmpty()) ValueData = EMPTY_TSTRING;
	if(!ValueData.Convert(bytes,true)) return false; 
	return SetValue(ValueName,bytes,TYPE_SZ);  
}

bool CRegistry::DeleteValue(CTString ValueName)
{
	if(!Valid(mHeadKey)) return false; 
	return ERROR_SUCCESS == RegDeleteValue(mHeadKey,(TCHAR*)ValueName);
}

bool CRegistry::QueryKeyInformation(HKEY Key,int *Keys,int *Values,int *MaxKeyLen,int *MaxValueNameLen,int *MaxValueDataLen)
{
	if(!Valid(Key)) return false; 
	return ERROR_SUCCESS == RegQueryInfoKey(Key,0,0,0,(DWORD*)Keys,(DWORD*)MaxKeyLen,0,(DWORD*)Values,(DWORD*)MaxValueNameLen,(DWORD*)MaxValueDataLen,0,0);        
}


int CRegistry::KeysCount(void)
{
	int subKeys = 0;
	if(!QueryKeyInformation(mHeadKey,&subKeys)) return 0;
	return subKeys;
}

int CRegistry::ValuesCount(void)
{
	int values = 0;
	if(!QueryKeyInformation(mHeadKey,0,&values)) return 0;
	return values;
}

bool CRegistry::QueryKeyInformation(HKEY Key,int Index,CTString &SubKeyName)
{
	int maxKeyNameLen = 0;
	
	SubKeyName.Clear(); 
	if(Index < 0 || !QueryKeyInformation(Key,0,0,&maxKeyNameLen,0,0) || maxKeyNameLen <= 0) return false; 
	CTString keyName(++maxKeyNameLen,true);
	if(ERROR_SUCCESS != RegEnumKeyEx(Key,Index,(TCHAR*)keyName,(DWORD*)&maxKeyNameLen,0,0,0,0)) return false; 
	SubKeyName = keyName;
	return true;
}

bool CRegistry::QueryValueInformation(HKEY Key,int Index,CTString *ValueName,CBytes *ValueData,ERegistryDataTypes *DataType)
{
	int maxValueNameLen = 0;
	if(Index < 0 || !QueryKeyInformation(Key,0,0,0,&maxValueNameLen,0)) return false; 

	DWORD valueDataLen = 0;
	CTString valueName(++maxValueNameLen,true);
	DWORD valueType = 0;

	if(ERROR_SUCCESS != RegEnumValue(Key,Index,(TCHAR*)valueName,(DWORD*)&maxValueNameLen,0,&valueType,0,&valueDataLen)) return false;  
	if(ValueName) *ValueName = valueName;
	if(DataType) *DataType = GetDataType(valueType);
	if(ValueData)
		if(valueDataLen > 0)
		{
			try
			{
				CBytes valueData(++valueDataLen); 
				bool bOk = ERROR_SUCCESS == RegEnumValue(Key,Index,(TCHAR*)valueName,(DWORD*)&(++maxValueNameLen),0,&valueType,(LPBYTE)(BYTE*)valueData,&valueDataLen); 
				if(bOk) (*ValueData) = valueData;
			}
			catch(...)
			{
				return false;
			}
		}
		else ValueData->Clear(); 
	
	return true;
}

bool CRegistry::SubKeyAt(int Index,CTString &KeyName)
{
	return QueryKeyInformation(mHeadKey,Index,KeyName); 
}

bool CRegistry::ValueNameAt(int Index,CTString &ValueName)
{
	return QueryValueInformation(mHeadKey,Index,&ValueName,0,0); 
}

bool CRegistry::ValueDataAt(int Index,CBytes &ValueData)
{
	return QueryValueInformation(mHeadKey,Index,0,&ValueData,0); 
}

bool CRegistry::ValueTypeAt(int Index,ERegistryDataTypes &Type)
{
	return QueryValueInformation(mHeadKey,Index,0,0,&Type); 
}

bool CRegistry::ValueDataStringAt(int Index,CTString &ValueData)
{
	ValueData.Clear();
	
	CBytes ValueDataBytes;
	if(QueryValueInformation(mHeadKey,Index,0,&ValueDataBytes,0))
	{
		return ValueDataBytes.Convert(ValueData); 
	}
	return false;
}

int CRegistry::FindIndexUsingValueName(CTString ValueName)
{
	int indx,valCnt = ValuesCount();
	CTString valueName;

	for(indx = 0; indx < valCnt; ++indx)
		if(ValueNameAt(indx,valueName) && valueName == ValueName) 
			return indx;
	
	return -1;
}

int CRegistry::FindIndexUsingKeyName(CTString SubKeyName)
{
	int indx,keyCnt = KeysCount();
	CTString keyName;

	for(indx = 0; indx < keyCnt; ++indx)
		if(SubKeyAt(indx,keyName) && keyName == SubKeyName) 
			return indx;
	
	return -1;
}

bool CRegistry::ValueData(CTString ValueName,CBytes &ValueData)
{
	return ValueDataAt(FindIndexUsingValueName(ValueName),ValueData);
}

bool CRegistry::ValueDataString(CTString ValueName,CTString &ValueData)
{
	return ValueDataStringAt(FindIndexUsingValueName(ValueName),ValueData);
}

bool CRegistry::ValueType(CTString ValueName,ERegistryDataTypes &Type)
{
	return ValueTypeAt(FindIndexUsingValueName(ValueName),Type);
}

CRegistry CRegistry::SubKeyAt(int Index)
{
	CTString keyName;
	CRegistry regKey;

	if(SubKeyAt(Index,keyName)) 
		if(!regKey.Open(mHeadKey,keyName,regKey.mHeadKey)) regKey.mHeadKey = (HKEY)(LONG)-1;    

	return regKey;
}

CRegistry CRegistry::SubKey(CTString SubKeyName)
{
	return SubKeyAt(FindIndexUsingKeyName(SubKeyName));
}

CRegistry& CRegistry::operator=(CRegistry &RegKey)
{
	CTString emptySubKey;
	Close(); 
	if(!RegKey.Open(RegKey.mHeadKey,emptySubKey,mHeadKey)) mHeadKey = (HKEY)(LONG)-1; 
	return *this;
}

CRegistry CRegistry::OpenSubTree(CTString KeyHierarchy)
{
	CRegistry subKey(*this);
	if(!subKey.Open(KeyHierarchy)) subKey.Close();
	return subKey;
}

CRegistry CRegistry::CreateSubTree(CTString KeyHierarchy)
{
	CRegistry subKey(*this);
	if(!subKey.Create(KeyHierarchy)) subKey.Close();
	return subKey;
}

CRegistry CRegistry::OpenRegistryKey(ERegistryRootKeys Root,CTString KeyHierarchy)
{
	CRegistry key(Root);
	key.Open(KeyHierarchy);
	return key;
}

CRegistry CRegistry::CreateRegistryKey(ERegistryRootKeys Root,CTString KeyHierarchy)
{
	CRegistry key(Root);
	key.Create(KeyHierarchy);
	return key;
}

bool CRegistry::Value(CTString ValueName,CBytes &ValueData,ERegistryDataTypes &Type)
{	
	return QueryValueInformation(mHeadKey,FindIndexUsingValueName(ValueName),0,&ValueData,&Type);
}

bool CRegistry::Value(int Index,CTString &ValueName,CBytes &ValueData,ERegistryDataTypes &Type)
{
	return QueryValueInformation(mHeadKey,Index,&ValueName,&ValueData,&Type);
}

bool CRegistry::Value(int Index,CTString &ValueName,CTString &ValueData)
{
	CBytes valueData;
	
	if(ValueData.Clear(),QueryValueInformation(mHeadKey,Index,&ValueName,&valueData,0))
		if(valueData.Convert(ValueData)) return true;
	
	return false;
}