
#pragma once

#define INCLUDED "true"

	 #import<msxml.dll> named_guids
	 #include<TCHAR.H>
	 #include <comip.h>
	 using namespace MSXML;


struct IXmlUtility
{
public:
	 virtual CTString GetError(void)=0;

	 virtual bool SetTokenSeperator(CTString TokenSeperator=CTString("/"))=0;
   virtual bool CreateNewXmlDocument(_bstr_t NewXML_FullFileName,CTString RootNodeName)=0;	
	 virtual bool OpenXmlDocument(_bstr_t bstrXmlFullFileName)=0; 
	 
	 virtual bool GetNodeTextFromHeirarchy(CTString Heirarchy,CTString& NodeText,bool BeginAtRoot=true)=0;
	 virtual bool GetNodeAttributeFromHeirarchy(CTString Heirarchy,CTString AttributeName,CTString& AttributeValue,bool BeginAtRoot=true)=0;
	 virtual bool SetTextIntoHeirarchy(CTString Heirarchy,CTString Text,bool BeginAtRoot=true,bool CreateNew=false)=0;
	 virtual bool SetNodeTextIntoHeirarchy(CTString Heirarchy,CTString NodeToBeCreated,CTString NodeValue,bool BeginAtRoot=true,bool CreateNew=false)=0;
	 virtual bool SetNodeAttributeIntoHeirarchy(CTString Heirarchy,CTString AttributeToBeCreated,CTString AttributeValue,bool BeginAtRoot=true)=0;
	 virtual bool InsertAllNodesFrom(_bstr_t XML_FileToBeMerged,bool InsertAtRoot=true)=0;
	 virtual bool InsertSelectedNodesFrom(IXmlUtility *XmlObjToBeInserted,bool InsertAtRoot=true)=0; 
	 
	 virtual bool MoveToChild(CTString ParentNodeHeirarchy,long ChildIndex=0,bool BeginAtRoot=true)=0;
	 virtual bool MoveToChild(CTString ParentNodeHeirarchy,CTString ChildName,bool BeginAtRoot=true)=0;
	 virtual bool MoveToBrother(bool Older=false)=0;
	 virtual bool MoveToParent(void)=0;
	 virtual bool ResetSearchPointerToRoot(void)=0;
	 virtual long NumberOfBrothers(void)=0;
	 virtual long NumberOfChildren(bool OfRootNode=true)=0;
	 virtual bool GetNodeName(CTString& NodeName,bool OfRootNode=true)=0;

	 virtual bool SetForceCreate(bool MakeOnState=false)=0;
	 virtual bool RemoveNodes(CTString Heirarchy,bool BeginAtRoot = true) = 0;
};

bool Create_IXmlUtility(IXmlUtility **objptrIXmlUtility);
bool Delete_IXmlUtility(IXmlUtility **objptrIXmlUtility);

#include "WinMonitorXmlUtilityIMP.h" 






