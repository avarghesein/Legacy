#pragma once


	 #ifndef INCLUDED  
			#import<msxml.dll> named_guids
			#include<TCHAR.H>
			#include <comip.h>
			using namespace MSXML;
	 #endif


class CXmlUtility : public IXmlUtility, public CMemoryManager
{
protected:
	 bool  m_boolErrorFlg; 
	 bool  m_boolForceCreate;
	 CTString m_tchrError;	
	 CTString m_tchrTokenSeperator;
protected:
	 MSXML::IXMLDOMDocumentPtr m_DocPtr;
	 MSXML::IXMLDOMElementPtr m_DocRootPtr;  
	 MSXML::IXMLDOMNodePtr m_DocSearchPtr;  
protected:
   bool GetFinalNodeInHeirarchy
			(MSXML::IXMLDOMNodePtr StartNode,CTString Heirarchy,CTString& NodeText,
			  bool IsAttribute=false,CTString AttributeName=CTString(EMPTY_TSTRING),
				bool IsWrite=false,bool ForSettingSearchPtr=false,bool ReplaceIfExists = false,bool ForDeletion = false);

	 bool GetAttributeByName
			(MSXML::IXMLDOMNodePtr Node,CTString AttributeName,
			 CTString& AttributeValue);

	 long GetNumberOfBrothers(MSXML::IXMLDOMNodePtr Node,bool Older=false);
	 void ClearError(void);
	 bool SetError(CTString Err);
	 bool SetCriticalError(CTString Err);
	 void SaveDocument(void);
	 MSXML::IXMLDOMNodePtr GetChildWithName(MSXML::IXMLDOMNodePtr oParent,CTString tsChildText);

public:
	 CXmlUtility(void);
	 ~CXmlUtility(void);
	 CTString GetError(void);

	 bool SetTokenSeperator(CTString TokenSeperator=CTString("/"));
   bool CreateNewXmlDocument(_bstr_t NewXML_FullFileName,CTString RootNodeName);	
	 bool OpenXmlDocument(_bstr_t bstrXmlFullFileName); 
	 
	 bool GetNodeTextFromHeirarchy(CTString Heirarchy,CTString& NodeText,bool BeginAtRoot=true);
	 bool GetNodeAttributeFromHeirarchy(CTString Heirarchy,CTString AttributeName,CTString& AttributeValue,bool BeginAtRoot=true);
	 bool SetNodeTextIntoHeirarchy(CTString Heirarchy,CTString NodeToBeCreated,CTString NodeValue,bool BeginAtRoot=true,bool CreateNew = false);
	 bool SetTextIntoHeirarchy(CTString Heirarchy,CTString Text,bool BeginAtRoot=true,bool CreateNew = false);
	 bool SetNodeAttributeIntoHeirarchy(CTString Heirarchy,CTString AttributeToBeCreated,CTString AttributeValue,bool BeginAtRoot=true);
	 bool InsertAllNodesFrom(_bstr_t XML_FileToBeMerged,bool InsertAtRoot=true);
	 bool InsertSelectedNodesFrom(IXmlUtility *XmlObjToBeInserted,bool InsertAtRoot=true); 
	 
	 bool MoveToChild(CTString ParentNodeHeirarchy,long ChildIndex=0,bool BeginAtRoot=true);
	 bool MoveToChild(CTString ParentNodeHeirarchy,CTString ChildName,bool BeginAtRoot=true);
	 bool MoveToBrother(bool Older=false);
	 bool MoveToParent(void);
	 bool ResetSearchPointerToRoot(void);
	 long NumberOfBrothers(void);
	 long NumberOfChildren(bool OfRootNode=true);
	 bool GetNodeName(CTString& NodeName,bool OfRootNode=true);

	 bool SetForceCreate(bool MakeOnState=false);
	 CTString operator[](int iIndx);
	 int LevelCount(void);
	 bool RemoveNodes(CTString Heirarchy,bool BeginAtRoot = true);
	 void Destroy(void);
	 
};

//---------Implementation---------//
CXmlUtility::~CXmlUtility(void)
{
	Destroy();
}

void CXmlUtility::Destroy(void)
{
	/* -- Deleting interface pointers 
	try { m_DocSearchPtr.Release();  } catch(...) {}
	try { m_DocSearchPtr.Release();  } catch(...) {}
	try { m_DocPtr.Release();        } catch(...) {}
	::CoUninitialize();
	-- */
}

bool CXmlUtility::MoveToParent(void)
{ 
	 try
	 {
			MSXML::IXMLDOMNodePtr TmpNode=this->m_DocSearchPtr;
			TmpNode=TmpNode->parentNode;
			if(TmpNode!=NULL) 
			{
				 m_DocSearchPtr=TmpNode;
				 return true;
			}else return false;
	 }
	 catch(...)
	 {
			return false;
	 }
}

bool CXmlUtility::SetForceCreate(bool MakeOnState)
{
	 if(this->m_boolErrorFlg) return false;
	 this->m_boolForceCreate=MakeOnState;
	 return true;
}

bool CXmlUtility::InsertSelectedNodesFrom(IXmlUtility *XmlObjToBeInserted,bool InsertAtRoot)
{
	 CXmlUtility *objToBeInserted=(CXmlUtility*)XmlObjToBeInserted;
	 if(m_boolErrorFlg || objToBeInserted->m_boolErrorFlg) return false;
	 try
	 {	
			MSXML::IXMLDOMElementPtr NodeToWhichInsert=InsertAtRoot?this->m_DocRootPtr:this->m_DocSearchPtr;  
			NodeToWhichInsert->appendChild(objToBeInserted->m_DocSearchPtr);  
		   this->m_DocPtr->save(this->m_DocPtr->Geturl());
			return true;
	 }
	 catch(TCHAR *ErrStg) { return !(this->SetError(ErrStg)); } 

}

bool CXmlUtility::MoveToChild(CTString ParentNodeHeirarchy,CTString ChildName,bool BeginAtRoot)
{
	 if(this->m_boolErrorFlg) return false;

	 MSXML::IXMLDOMNodePtr TmpSearchNode=this->m_DocSearchPtr;
	 try
	 {
			if(!GetFinalNodeInHeirarchy(BeginAtRoot?m_DocRootPtr:m_DocSearchPtr,ParentNodeHeirarchy,
				 CTString(EMPTY_TSTRING),false,EMPTY_TSTRING,false,true)) 
			{
				 this->m_DocSearchPtr=TmpSearchNode;
				 return false;
			}

			MSXML::IXMLDOMNodePtr TmpChildNode=m_DocSearchPtr->GetfirstChild();
		
			for( ;TmpChildNode!=NULL && ChildName != (TCHAR*)TmpChildNode->GetnodeName();TmpChildNode=TmpChildNode->GetnextSibling());
			if(TmpChildNode)
			{
				 this->m_DocSearchPtr=TmpChildNode;
				 return true;
			}
			else
			{
					this->m_DocSearchPtr=TmpSearchNode;
					return !(this->SetError("Error:No Child with this Name"));
			}
	 }
	 catch(TCHAR *ErrStg)
	 {
			this->m_DocSearchPtr=TmpSearchNode;
			return !(this->SetError(ErrStg)); 
	 }
}

bool CXmlUtility::MoveToChild(CTString ParentNodeHeirarchy,long ChildIndex,bool BeginAtRoot)
{
	 if(this->m_boolErrorFlg) return false;

	 MSXML::IXMLDOMNodePtr TmpSearchNode=this->m_DocSearchPtr;
	 try
	 {
			if(!GetFinalNodeInHeirarchy(BeginAtRoot?m_DocRootPtr:m_DocSearchPtr,ParentNodeHeirarchy,
				 CTString(EMPTY_TSTRING),false,EMPTY_TSTRING,false,true)) 
			{
				 this->m_DocSearchPtr=TmpSearchNode;
				 return false;
			}

			MSXML::IXMLDOMNodePtr TmpChildNode=m_DocSearchPtr->GetfirstChild();
			long Counter;
			for(Counter=0;(Counter<ChildIndex) && (TmpChildNode!=NULL);++Counter,TmpChildNode=TmpChildNode->GetnextSibling());
			if((Counter==ChildIndex) && (TmpChildNode!=NULL))
			{
				 this->m_DocSearchPtr=TmpChildNode;
				 return true;
			}
			else
			{
					this->m_DocSearchPtr=TmpSearchNode;
					return !(this->SetError("Error:No Child with this Index"));
			}
	 }
	 catch(TCHAR *ErrStg)
	 {
			this->m_DocSearchPtr=TmpSearchNode;
			return !(this->SetError(ErrStg)); 
	 }
}



bool CXmlUtility::ResetSearchPointerToRoot(void)
{
	 if(this->m_boolErrorFlg) return false;
	 try { this->m_DocSearchPtr=this->m_DocRootPtr; return true; }
	 catch(TCHAR *ErrStg) { return !(this->SetError(ErrStg));	}
}


bool CXmlUtility::MoveToBrother(bool Older)
{
	 if(this->m_boolErrorFlg) return false;

	 MSXML::IXMLDOMNodePtr TmpBrother=NULL;

	 try
	 {
			TmpBrother=Older?m_DocSearchPtr->previousSibling:m_DocSearchPtr->nextSibling;
			if(TmpBrother)
			{
				 m_DocSearchPtr=TmpBrother; return true;
			}
			else return !(this->SetError("No additional brothers")); 

	 }
	  catch(TCHAR *ErrStg)
	 {
			return !(this->SetError(ErrStg)); 
	 }
}

CTString CXmlUtility::operator[](int iIndx)
{
	int iCnt = -1;
	MSXML::IXMLDOMNodePtr oCurSrchPtr = m_DocSearchPtr; 
	try
	{
		while(MoveToBrother(true)); 
		while(++iCnt,iCnt < iIndx && MoveToBrother(false));
		if(iCnt != iIndx) throw -1;
		CTString tsRet; 
		if(!GetNodeName(tsRet,false)) throw -1;
		m_DocSearchPtr = oCurSrchPtr;
		return tsRet;
	}
	catch(...) 
	{
		m_DocSearchPtr = oCurSrchPtr;
		SetError("Index out of range exception!");
		throw -1;
	}
}

long CXmlUtility::GetNumberOfBrothers(MSXML::IXMLDOMNodePtr Node,bool Older)
{
	 if((this->m_boolErrorFlg)||(Node==NULL)) return long(false);
	 try
	 {
			long BrotherCnt;
			MSXML::IXMLDOMNodePtr TmpNode;
			TmpNode=Older?Node->previousSibling:Node->nextSibling;
			for(BrotherCnt=0;TmpNode!=NULL;++BrotherCnt,TmpNode=Older?TmpNode->previousSibling:TmpNode->nextSibling);
			return BrotherCnt;  
	 }
	 catch(TCHAR *ErrStg)
	 {
			return long(!(this->SetError(ErrStg))); 
	 }
}

long CXmlUtility::NumberOfBrothers(void)
{
	 return (GetNumberOfBrothers(m_DocSearchPtr,false)+GetNumberOfBrothers(m_DocSearchPtr,true));    
}

int CXmlUtility::LevelCount(void)
{
	return NumberOfBrothers() + 1;
}

long CXmlUtility::NumberOfChildren(bool OfRootNode)
{
	 long lngIsChild=
			(OfRootNode?this->m_DocRootPtr->firstChild:this->m_DocSearchPtr->firstChild)?1:0;

	 return(lngIsChild+(this->GetNumberOfBrothers(OfRootNode?
		      this->m_DocRootPtr->firstChild:
	        this->m_DocSearchPtr->firstChild,false))); 
}

bool CXmlUtility::GetNodeName(CTString& NodeName,bool OfRootNode)
{
	 if(this->m_boolErrorFlg) return false;
	 try
	 {
			NodeName = (TCHAR*)(OfRootNode?this->m_DocRootPtr->GetnodeName():this->m_DocSearchPtr->GetnodeName());    
			return true;
	 }
	 catch(TCHAR *ErrStg)
	 {
			return !(this->SetError(ErrStg)); 
	 }
}


bool CXmlUtility::InsertAllNodesFrom(_bstr_t XML_FileToBeMerged,bool InsertAtRoot)
{
	 if(this->m_boolErrorFlg) return false; 
	 try
	 {
			CXmlUtility XML_ToBeMerged; 
			if(!XML_ToBeMerged.OpenXmlDocument(XML_FileToBeMerged))
				 return false;
			if(InsertAtRoot) this->m_DocPtr->documentElement->appendChild(XML_ToBeMerged.m_DocPtr->GetdocumentElement());
			else this->m_DocSearchPtr->appendChild(XML_ToBeMerged.m_DocPtr->GetdocumentElement());  
			this->m_DocPtr->save(this->m_DocPtr->Geturl());
			return true;
	 }
	 catch(TCHAR *ErrStg) { return !(this->SetError(ErrStg)); } 
}

CTString CXmlUtility::GetError(void) { return this->m_tchrError; }   

CXmlUtility::CXmlUtility(void)
{
	 this->m_DocPtr=NULL,this->ClearError(); 
	 m_boolForceCreate=false;
	 this->SetTokenSeperator(); 
	 ::CoInitialize(NULL); 
	 HRESULT ComLoad=(this->m_DocPtr).CreateInstance(MSXML::CLSID_DOMDocument);
	 if(FAILED(ComLoad))
	 {
			_com_error er(ComLoad);
			this->SetCriticalError((TCHAR*)er.ErrorMessage());
	 }
}

void CXmlUtility::ClearError(void)  
{
	  this->m_boolErrorFlg =false;
	this->m_DocRootPtr=this->m_DocSearchPtr=NULL;  
	 this->m_tchrError = EMPTY_TSTRING; 
	 return;
}

bool CXmlUtility::SetCriticalError(CTString Err)
{
	 this->m_boolErrorFlg=true;
	 return this->SetError(Err);
}

bool CXmlUtility::SetError(CTString Err)
{
	 this->m_tchrError = Err;
	 return true;
}

bool CXmlUtility::CreateNewXmlDocument(_bstr_t NewXML_FullFileName,CTString RootNodeName)
{
	 this->ClearError();
	 try
	 {
			this->m_DocRootPtr=NULL;  
			MSXML::IXMLDOMProcessingInstructionPtr XML_Declaration=this->m_DocPtr->createProcessingInstruction("xml","version=\"1.0\" encoding=\"utf-16\" standalone=\"no\""); 
			this->m_DocPtr->appendChild(XML_Declaration);   
			MSXML::IXMLDOMElementPtr RootNode=this->m_DocPtr->createElement((TCHAR*)RootNodeName);
			this->m_DocPtr->documentElement=RootNode;
			this->m_DocPtr->save(NewXML_FullFileName);   
			if(!this->OpenXmlDocument(NewXML_FullFileName)) return !(this->SetCriticalError("Can't Load Newly Created Document"));   
			return true;
	 }
	 catch(TCHAR *ErrStg)
	 {
			return !(this->SetCriticalError(ErrStg)); 
	 }
}

bool CXmlUtility::OpenXmlDocument(_bstr_t bstrXmlFullFileName)
{
	 this->ClearError(); 
	 try
	 {
			if(this->m_DocRootPtr=0,this->m_DocPtr->load(bstrXmlFullFileName),this->m_DocPtr==NULL) 
				 return !(this->SetCriticalError("XML Document Not Found!"));
			
			if(this->m_DocSearchPtr=this->m_DocRootPtr=this->m_DocPtr->GetdocumentElement(),this->m_DocRootPtr==NULL)
				 return !(this->SetCriticalError("XML Root node Not Found!"));
	 }
	 catch(TCHAR *ErrStg) { this->SetCriticalError(ErrStg); }
	 
	 m_boolForceCreate=false;
	 return true;
}


bool CXmlUtility::SetTokenSeperator(CTString TokenSeperator)
{
	 if(this->m_boolErrorFlg) return false; 
	 m_tchrTokenSeperator=EMPTY_TSTRING;
	 m_tchrTokenSeperator = TokenSeperator;
	 return true;
}

bool CXmlUtility::SetNodeAttributeIntoHeirarchy(CTString Heirarchy,CTString AttributeToBeCreated,CTString AttributeValue,bool BeginAtRoot)
{
	 if(this->m_boolErrorFlg) return false; 
	 if(GetFinalNodeInHeirarchy(BeginAtRoot?this->m_DocRootPtr:this->m_DocSearchPtr,Heirarchy,AttributeValue,true,AttributeToBeCreated,true,false)) return true;
	 return false;
}

bool CXmlUtility::SetTextIntoHeirarchy(CTString Heirarchy,CTString Text,bool BeginAtRoot,bool CreateNew)
{
	 return this->SetNodeTextIntoHeirarchy(Heirarchy,EMPTY_TSTRING,Text,BeginAtRoot,!CreateNew); 
}

bool CXmlUtility::SetNodeTextIntoHeirarchy(CTString Heirarchy,CTString NodeToBeCreated,CTString NodeValue,bool BeginAtRoot,bool CreateNew)
{
	 if(this->m_boolErrorFlg) return false; 
	 if(GetFinalNodeInHeirarchy(BeginAtRoot?this->m_DocRootPtr:this->m_DocSearchPtr,Heirarchy,NodeValue,false,NodeToBeCreated,true,false,!CreateNew)) return true;
	 return false;
}


bool CXmlUtility::GetNodeTextFromHeirarchy(CTString Heirarchy,CTString& NodeText,bool BeginAtRoot)
{
	 if(this->m_boolErrorFlg) return false; 
	 if(GetFinalNodeInHeirarchy(BeginAtRoot?this->m_DocRootPtr:this->m_DocSearchPtr,Heirarchy,NodeText,false,EMPTY_TSTRING,false,false)) return true;
	 return false;
}

bool CXmlUtility::GetNodeAttributeFromHeirarchy(CTString Heirarchy,CTString AttributeName,CTString& AttributeValue,bool BeginAtRoot)
{
	 if(this->m_boolErrorFlg) return false; 
	 if(GetFinalNodeInHeirarchy(BeginAtRoot?this->m_DocRootPtr:this->m_DocSearchPtr,Heirarchy,AttributeValue,true,AttributeName,false,false))return true;
	 return false;
}

bool CXmlUtility::RemoveNodes(CTString Heirarchy,bool BeginAtRoot)
{
	if(this->m_boolErrorFlg) return false; 
	return GetFinalNodeInHeirarchy(BeginAtRoot?this->m_DocRootPtr:this->m_DocSearchPtr,Heirarchy,CTString(EMPTY_TSTRING),false,CTString(EMPTY_TSTRING),false,false,false,true);   
}

bool CXmlUtility::GetAttributeByName(MSXML::IXMLDOMNodePtr Node,CTString AttributeName,CTString& AttributeValue)
{
	 if(this->m_boolErrorFlg) return false; 
	 MSXML::IXMLDOMNamedNodeMapPtr nodemapptrAttributes;
	 try
	 {
	 		nodemapptrAttributes=Node->Getattributes();
			for(int i=0;i<nodemapptrAttributes->Getlength();i++)
				 if(AttributeName == (TCHAR*)nodemapptrAttributes->Getitem(i)->GetnodeName()) 
				 {
						AttributeValue = nodemapptrAttributes->Getitem(i)->Gettext();
						return true;
				 }
	 }
	 catch(TCHAR *ErrStg)
	 {	return !(this->SetError(ErrStg)); }
	 
	 return !(this->SetError(_T("Attribute Not Found!")));
}


void CXmlUtility::SaveDocument(void)
{	 
	 this->m_DocPtr->save(this->m_DocPtr->Geturl());
	 return;
}

MSXML::IXMLDOMNodePtr CXmlUtility::GetChildWithName(MSXML::IXMLDOMNodePtr oParent,CTString tsChildText)
{
	MSXML::IXMLDOMNodePtr oChild = 0;

	for(oChild = oParent->firstChild;oChild;oChild = oChild->nextSibling)
		if(tsChildText == (TCHAR*)oChild->text) return oChild;     
	
	return 0;
}

bool CXmlUtility::GetFinalNodeInHeirarchy(MSXML::IXMLDOMNodePtr StartNode,CTString Heirarchy,CTString& NodeText,bool IsAttribute,CTString AttributeName,bool IsWrite,bool ForSettingSearchPtr,bool ReplaceIfExists,bool ForDeletion)
{

	if((this->m_boolErrorFlg) || (StartNode==NULL)) return false; 

    CTString tchrToken,tchrSubHeirarchy;

	try
	{		     
		if(!Heirarchy.SplitByToken(m_tchrTokenSeperator,tchrToken,tchrSubHeirarchy,true)) return !(this->SetError(_T("Err:Cannot Parse Token"))); 
		
		MSXML::IXMLDOMNodePtr SiblingNode;
		
		for(SiblingNode=StartNode;SiblingNode;SiblingNode=(MSXML::IXMLDOMElementPtr)SiblingNode->nextSibling)   
			if(tchrSubHeirarchy.IsEmpty())
			{
				if(tchrToken == (TCHAR*)SiblingNode->nodeName) 
				{   
					if(ForDeletion)
					{
						MSXML::IXMLDOMNodePtr oParent = SiblingNode->parentNode;
						oParent->removeChild(SiblingNode);
						SaveDocument(); 
						if(m_DocSearchPtr == SiblingNode) m_DocSearchPtr = oParent;
						return true;
					}
					else if(ForSettingSearchPtr)
					{
							m_DocSearchPtr= SiblingNode;
							return true;
					}
					else
					{
						if(!IsWrite)
						{
							if(!IsAttribute)	
							{
								if(SiblingNode->firstChild != 0) NodeText = SiblingNode->firstChild->text;
								else NodeText = EMPTY_TSTRING; 
								return true;
							}
					  		else if(this->GetAttributeByName(SiblingNode,AttributeName,NodeText)) return true;
						}
						else
						{
							if(!IsAttribute)
							{
								if(AttributeName != EMPTY_TSTRING)
								{
									MSXML::IXMLDOMElementPtr NewNode=this->m_DocPtr->createElement((TCHAR*)AttributeName);
									if(NodeText != EMPTY_TSTRING) NewNode->appendChild(this->m_DocPtr->createTextNode((TCHAR*)NodeText));   
									if(ReplaceIfExists) 
									{
										MSXML::IXMLDOMElementPtr ChildNode = GetChildWithName(SiblingNode,(TCHAR*)AttributeName);
										if(ChildNode) SiblingNode->replaceChild(NewNode,ChildNode); else SiblingNode->appendChild(NewNode);  
									}
									else SiblingNode->appendChild(NewNode);
									SaveDocument();  
								}
								else
								{
									MSXML::IXMLDOMTextPtr NewTextNode=this->m_DocPtr->createTextNode((TCHAR*)NodeText);
									if(ReplaceIfExists) 
									{
										MSXML::IXMLDOMElementPtr ChildNode = GetChildWithName(SiblingNode,(TCHAR*)NodeText);
										if(ChildNode) SiblingNode->replaceChild(NewTextNode,ChildNode); else SiblingNode->appendChild(NewTextNode);  
										}
										else SiblingNode->appendChild(NewTextNode);
										SaveDocument(); 
								}
							}
							else
							{
								MSXML::IXMLDOMElementPtr TmpElmnt=(MSXML::IXMLDOMElementPtr)SiblingNode; 
								TmpElmnt->setAttribute((TCHAR*)AttributeName,(TCHAR*)NodeText); 
								SaveDocument();  
							}
 							return true;
						}
					}
				}
			}
			else
			{
				if(tchrToken == (TCHAR*)SiblingNode->nodeName)
					if(SiblingNode->firstChild!=NULL)
					{
						if(GetFinalNodeInHeirarchy(SiblingNode->firstChild,tchrSubHeirarchy,NodeText,IsAttribute,AttributeName,IsWrite,ForSettingSearchPtr,ReplaceIfExists,ForDeletion))
						return true;
					}
					else
					{
						if(ForDeletion) return false;
						if(IsWrite==true && (this->m_boolForceCreate)==true && (StartNode!=NULL))
						{
							CTString tchrNextToken,tchrNextSubHeirarchy;
							if(tchrSubHeirarchy.SplitByToken(m_tchrTokenSeperator,tchrNextToken,tchrNextSubHeirarchy,true))
							{
								MSXML::IXMLDOMElementPtr NewNode=this->m_DocPtr->createElement((TCHAR*)tchrNextToken);
								SiblingNode->appendChild(NewNode);
								SaveDocument();
    							bool boolSuccess=GetFinalNodeInHeirarchy(NewNode,tchrSubHeirarchy,NodeText,IsAttribute,AttributeName,IsWrite,ForSettingSearchPtr,ReplaceIfExists,ForDeletion);												
								return boolSuccess; 
							}
						}
					}
			}
		if(ForDeletion) return false;
		if(IsWrite==true && (this->m_boolForceCreate)==true && (StartNode!=NULL) && (StartNode->parentNode!=NULL))
		{
			MSXML::IXMLDOMElementPtr NewNode=this->m_DocPtr->createElement((TCHAR*)tchrToken);
			StartNode->parentNode->appendChild(NewNode);
			SaveDocument();
    		if(GetFinalNodeInHeirarchy(NewNode,Heirarchy,NodeText,IsAttribute,AttributeName,IsWrite,ForSettingSearchPtr,ReplaceIfExists,ForDeletion))
			{
				return true;
			}
		}
	}	 
	catch(TCHAR *ErrStg)
	{	
		return !(this->SetError(ErrStg));
	} 
	return !(this->SetError(_T("Error:Element not found")));
}



bool Create_IXmlUtility(IXmlUtility **objptrIXmlUtility)
{
	 try
	 {
			if((*objptrIXmlUtility=new CXmlUtility())!=0)return true; 
			else return false;
	 }
	 catch(...)
	 {	return false; }
}

bool Delete_IXmlUtility(IXmlUtility **objptrIXmlUtility)
{
	  
	 try 
	 {     
			   delete *objptrIXmlUtility;
		 		 return true;
	 }
	 catch(...) {return false; }
}

	