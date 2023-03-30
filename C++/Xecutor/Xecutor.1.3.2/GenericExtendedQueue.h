#pragma once

template<class ITEM> class CGenericQueue;

//--------------Queue element

template<class ITEM> class CGenericQueueNode
{
	friend class CGenericQueue<ITEM>;

	protected:
			ITEM *m_ItemPtr;
			CGenericQueueNode<ITEM> *m_qnodeNextQnode;
	public:
			CGenericQueueNode(void);
			CGenericQueueNode(ITEM *ptrToItemCopy);
			CGenericQueueNode(ITEM *ptrToItemCopy,CGenericQueueNode<ITEM> *NextQnodePtr);
			~CGenericQueueNode() {};
	public:
			CGenericQueueNode<ITEM> *GetNextItem(void);
			bool SetNextItem(CGenericQueueNode<ITEM> *NextQnodePtr);
			ITEM *GetItem(void);
			bool SetItem(ITEM *ItemPtr);
			bool DeleteItemPtr(void);
};

//--------------Queue 

template<class ITEM> class CGenericQueue
{
	protected:
			bool mbDeleteObjectsAfterUse;
			HANDLE m_MuxQueue;
			CGenericQueueNode<ITEM> *m_qnodeHeadQnode,*m_qnodeTailQnode;
	
	protected:
		CGenericQueueNode<ITEM>* GetNodeAtIndex(long Index);

	public:
			CGenericQueue(bool DeleteObjectsAfterUse = true);
			~CGenericQueue();
			bool ClearList(void);
			bool InsertAtBack(ITEM *ItemPtr);
			bool InsertAtFront(ITEM *ItemPtr);
			bool DeleteFromBack(ITEM **ItemDblPtr);
			bool DeleteFromFront(ITEM **ItemDblPtr);
			bool FirstItem(ITEM **ItemDblPtr);
			bool IsEmptyList(void);
			long Count(void);
			ITEM* &operator[](long Index); 
			bool InsertAt(long Index,ITEM *ItemPtr);
			bool DeleteFrom(long Index,ITEM **ItemDblPtr);
};

//-------------generic linked list

template<class ITEM> class CExtendedLinkedList:public CGenericQueue<ITEM>
{
	 protected:
			CGenericQueueNode<ITEM> *ParentNodeByAddress(UINT64  Address);
	 public:
			CExtendedLinkedList(bool DeleteObjectsAfterUse = true);
			~CExtendedLinkedList();
			bool DeleteItemByAddress(UINT64  Address);
			ITEM *GetItemByAddress(UINT64  Address);
			void operator=(CExtendedLinkedList<ITEM> &CopyFrom);
};

//----------------implementations

template<class ITEM> bool CGenericQueueNode<ITEM>::DeleteItemPtr(void)
{
	try
	{
		if(m_ItemPtr) delete m_ItemPtr; return true;
	}
	catch(...) { return false; } 
}

template<class ITEM> CGenericQueueNode<ITEM> *CGenericQueueNode<ITEM>::GetNextItem(void)
{				return m_qnodeNextQnode;		}

template<class ITEM> ITEM *CGenericQueueNode<ITEM>::GetItem(void)
{				return m_ItemPtr;		}

template<class ITEM> bool CGenericQueueNode<ITEM>::SetNextItem(CGenericQueueNode<ITEM> *NextQnodePtr)
{
		this->m_qnodeNextQnode=NextQnodePtr;
		return true;
}

template<class ITEM> bool CGenericQueueNode<ITEM>::SetItem(ITEM *ItemPtr)
{
		this->m_ItemPtr=ItemPtr;
		return true;
}

template<class ITEM> CGenericQueueNode<ITEM>::CGenericQueueNode(void)
{	m_ItemPtr=0;  m_qnodeNextQnode=0;	  }

template<class ITEM> CGenericQueueNode<ITEM>::CGenericQueueNode(ITEM *ptrToItemCopy)
{
	if(m_ItemPtr=0,m_qnodeNextQnode=0,ptrToItemCopy) m_ItemPtr=ptrToItemCopy;
}

template<class ITEM> CGenericQueueNode<ITEM>::CGenericQueueNode(ITEM *ptrToItemCopy,CGenericQueueNode<ITEM> *NextQnodePtr)
{
	if(m_ItemPtr=0,m_qnodeNextQnode=0,ptrToItemCopy)
		m_ItemPtr=ptrToItemCopy,this->m_qnodeNextQnode=NextQnodePtr;
}


template<class ITEM> CGenericQueue<ITEM>::CGenericQueue(bool DeleteObjectsAfterUse) : mbDeleteObjectsAfterUse(DeleteObjectsAfterUse)
{		m_qnodeHeadQnode=m_qnodeTailQnode=0; m_MuxQueue=CreateMutex(0,0,0); 	}


template<class ITEM> bool CGenericQueue<ITEM>::FirstItem(ITEM **ItemDblPtr)
{
	WaitForSingleObject(m_MuxQueue,INFINITE); 
	if(this->m_qnodeHeadQnode==0)
	{
		ReleaseMutex(m_MuxQueue);
		return false;
	}
	*ItemDblPtr=this->m_qnodeHeadQnode->GetItem();
	ReleaseMutex(m_MuxQueue);
	return true;
}

template<class ITEM> bool CGenericQueue<ITEM>::DeleteFromFront(ITEM **ItemDblPtr)
{
	 WaitForSingleObject(m_MuxQueue,INFINITE); 
     if(m_qnodeHeadQnode==0 || m_qnodeTailQnode==0)
	 {
		 ReleaseMutex(m_MuxQueue); 
		 return false;
	 }
	 try
	 {
			CGenericQueueNode<ITEM> *FrontNode=this->m_qnodeHeadQnode; 
			this->m_qnodeHeadQnode=this->m_qnodeHeadQnode->GetNextItem();
			if(m_qnodeHeadQnode==0) m_qnodeTailQnode=0;
			*ItemDblPtr=FrontNode->GetItem(); 
			delete FrontNode;
			ReleaseMutex(m_MuxQueue); 
			return true;
	 }catch(...) { ReleaseMutex(m_MuxQueue); return false; }
}

template<class ITEM>
long CGenericQueue<ITEM>::Count(void)
{
	long lCnt = 0;
	try
	{
		CGenericQueueNode<ITEM> *FrontNode=this->m_qnodeHeadQnode;
		while(FrontNode) ++lCnt,FrontNode = FrontNode->GetNextItem(); 
	}
	catch(...) {}
	return lCnt;
}

template<class ITEM>
CGenericQueueNode<ITEM>* CGenericQueue<ITEM>::GetNodeAtIndex(long Index)
{
	long lCnt = 0;
	CGenericQueueNode<ITEM> *FrontNode=this->m_qnodeHeadQnode;
	try
	{
		while(FrontNode && lCnt<Index) ++lCnt,FrontNode = FrontNode->GetNextItem(); 
	}
	catch(...) {}
	if(lCnt != Index) return 0; else return FrontNode;
}

template<class ITEM>
bool CGenericQueue<ITEM>::InsertAt(long Index,ITEM *ItemPtr)
{
	CGenericQueueNode<ITEM> *Node = GetNodeAtIndex(Index),*NodeAfter,*NewNode;
	if(!Node && Index > 0) return false;
	NewNode = new CGenericQueueNode<ITEM>();
	NewNode->SetItem(ItemPtr);
	WaitForSingleObject(m_MuxQueue,INFINITE);
	if(Node)
	{
		NodeAfter = Node->m_qnodeNextQnode;
		Node->SetNextItem(NewNode);
		NewNode->SetNextItem(NodeAfter);
		if(!NodeAfter) m_qnodeTailQnode = NewNode;
	}
	else
	{
		NewNode->SetNextItem(0);
		m_qnodeHeadQnode = m_qnodeTailQnode = NewNode;
	}
	ReleaseMutex(m_MuxQueue);
	return true;
}

template<class ITEM>
bool CGenericQueue<ITEM>::DeleteFrom(long Index,ITEM **ItemDblPtr)
{
	CGenericQueueNode<ITEM> *Node = GetNodeAtIndex(Index),*NodePrior = 0,*NodeNext = 0;
	if(!Node) return false;
	if(Index > 0) NodePrior = GetNodeAtIndex(Index - 1);
	WaitForSingleObject(m_MuxQueue,INFINITE);
	*ItemDblPtr = Node->GetItem(); 
	NodeNext = Node->m_qnodeNextQnode;
	if(NodePrior) NodePrior->SetNextItem(NodeNext); else m_qnodeHeadQnode = NodeNext;
	if(!NodeNext) m_qnodeTailQnode = NodePrior;
	ReleaseMutex(m_MuxQueue);
	return true;
}

template<class ITEM>
ITEM* &CGenericQueue<ITEM>::operator[](long Index) 
{
	CGenericQueueNode<ITEM> *Node = GetNodeAtIndex(Index);
	if(!Node) throw -1;
	return Node->m_ItemPtr; 
}

template<class ITEM> bool CGenericQueue<ITEM>::IsEmptyList(void)
{
	WaitForSingleObject(m_MuxQueue,INFINITE);
	bool blnEmpty=(m_qnodeHeadQnode==0 || m_qnodeTailQnode==0)?true:false;
	ReleaseMutex(m_MuxQueue);
	return blnEmpty;
}

template<class ITEM> bool CGenericQueue<ITEM>::DeleteFromBack(ITEM **ItemDblPtr)
{
	 WaitForSingleObject(m_MuxQueue,INFINITE); 
	 if(m_qnodeHeadQnode==0 || m_qnodeTailQnode==0)
	 {
		 ReleaseMutex(m_MuxQueue); 
		 return false;
	 }
	 try
	 {
			CGenericQueueNode<ITEM> *TailNode=this->m_qnodeTailQnode,*TmpNode=this->m_qnodeHeadQnode; 
			if(TmpNode==TailNode)
			{
				 *ItemDblPtr=TmpNode->GetItem();
				 delete TmpNode;
				 m_qnodeHeadQnode=m_qnodeTailQnode=0;
				 ReleaseMutex(m_MuxQueue); 
				 return true;
			}

			while(TmpNode->GetNextItem()!=TailNode) TmpNode=TmpNode->GetNextItem();
			m_qnodeTailQnode=TmpNode;
			*ItemDblPtr=TailNode->GetItem(); 
			delete TailNode;
			ReleaseMutex(m_MuxQueue); 
			return true;
	 }catch(...) { ReleaseMutex(m_MuxQueue); return false; }
}

template<class ITEM> bool CGenericQueue<ITEM>::InsertAtFront(ITEM *ItemPtr)
{
	try
	{
		WaitForSingleObject(m_MuxQueue,INFINITE); 
		CGenericQueueNode<ITEM> *TmpHead=new CGenericQueueNode<ITEM>(ItemPtr);
		TmpHead->SetNextItem(this->m_qnodeHeadQnode);
		if(m_qnodeHeadQnode==0) m_qnodeTailQnode=m_qnodeHeadQnode=TmpHead; else m_qnodeHeadQnode=TmpHead;
		ReleaseMutex(m_MuxQueue); 
		return true;
	}
	catch(...) { ReleaseMutex(m_MuxQueue); return false; }

}

template<class ITEM> bool CGenericQueue<ITEM>::InsertAtBack(ITEM *ItemPtr)
{
	try
	{
		WaitForSingleObject(m_MuxQueue,INFINITE); 
		if(!m_qnodeHeadQnode || !m_qnodeTailQnode) 
		{
			ReleaseMutex(m_MuxQueue); 
			return InsertAtFront(ItemPtr);
		}
		CGenericQueueNode<ITEM> *TmpTail=new CGenericQueueNode<ITEM>(ItemPtr);
		this->m_qnodeTailQnode->SetNextItem(TmpTail);
		this->m_qnodeTailQnode=TmpTail; 
		ReleaseMutex(m_MuxQueue); 
		return true;
	}
	catch(...) { ReleaseMutex(m_MuxQueue); return false; }
}


template<class ITEM>  bool CGenericQueue<ITEM>::ClearList(void)
{
	try
	{
	   WaitForSingleObject(m_MuxQueue,INFINITE);
	   if(!m_qnodeHeadQnode) 
	   {
		   ReleaseMutex(m_MuxQueue); 
		   return true;
	   }
	   CGenericQueueNode<ITEM> *TmpHead=this->m_qnodeHeadQnode,*Obsolete;
	   while(TmpHead) 
		 {
				Obsolete=TmpHead,TmpHead=TmpHead->GetNextItem();
				if(mbDeleteObjectsAfterUse) Obsolete->DeleteItemPtr();
				delete Obsolete;
		 }
	   m_qnodeHeadQnode=m_qnodeTailQnode=0;
	   ReleaseMutex(m_MuxQueue); 
	   return true;
	}
	catch(...) { ReleaseMutex(m_MuxQueue); return false; }
}

template<class ITEM>  CGenericQueue<ITEM>::~CGenericQueue()
{
	 ClearList();
	 CloseHandle(m_MuxQueue); 
	 m_MuxQueue=0;
}


template<class ITEM>  CExtendedLinkedList<ITEM>::CExtendedLinkedList(bool DeleteObjectsAfterUse):CGenericQueue<ITEM>(DeleteObjectsAfterUse) 
{}

template<class ITEM>  CExtendedLinkedList<ITEM>::~CExtendedLinkedList()
{} 

template<class ITEM> CGenericQueueNode<ITEM> *CExtendedLinkedList<ITEM>::ParentNodeByAddress(UINT64  Address)
{
	try
	{
	   if(!m_qnodeHeadQnode) return 0;
	   CGenericQueueNode<ITEM> *TmpHead=this->m_qnodeHeadQnode;
	   while((TmpHead->GetNextItem()) && (((UINT64 )(TmpHead->GetNextItem()->GetItem()))!=Address)) TmpHead=TmpHead->GetNextItem();
	   CGenericQueueNode<ITEM> *TmpItem=TmpHead->GetNextItem();
	   if(!TmpItem) return 0;
	   else return TmpHead;
	}
	catch(...) { return 0; }
}

template<class ITEM> ITEM *CExtendedLinkedList<ITEM>::GetItemByAddress(UINT64  Address)
{
	 WaitForSingleObject(m_MuxQueue,INFINITE); 
	 if(!m_qnodeHeadQnode) 
	 {
		 ReleaseMutex(m_MuxQueue); 
		 return 0;
	 }
	 ITEM *TmpItem=m_qnodeHeadQnode->GetItem();
	 if(((UINT64 )TmpItem)==Address) 
	 {
		 ReleaseMutex(m_MuxQueue); 
		 return TmpItem;  
	 }
	 CGenericQueueNode<ITEM> *TmpHead=ParentNodeByAddress(Address);
	 if(TmpHead!=0) 
	 {
		 TmpItem=TmpHead->GetNextItem()->GetItem();
	 }
	 else TmpItem=0;
	 ReleaseMutex(m_MuxQueue);
	 return TmpItem; 
}

template<class ITEM>  bool CExtendedLinkedList<ITEM>::DeleteItemByAddress(UINT64  Address)
{
	 WaitForSingleObject(m_MuxQueue,INFINITE);
	 if(!m_qnodeHeadQnode) 
	 {
		 ReleaseMutex(m_MuxQueue); 
		 return false;
	 }
	 if(((UINT64 )m_qnodeHeadQnode->GetItem())==Address)
	 {
			CGenericQueueNode<ITEM> *TmpHead=this->m_qnodeHeadQnode->GetNextItem();  
			delete m_qnodeHeadQnode;
			m_qnodeHeadQnode=TmpHead;
			if(m_qnodeHeadQnode==0) m_qnodeTailQnode=0;
			ReleaseMutex(m_MuxQueue); 
			return true;
	 }
	 CGenericQueueNode<ITEM> *TmpHead=ParentNodeByAddress(Address),*ObsoleteItem;
	 if(TmpHead==0) 
	 {
		 ReleaseMutex(m_MuxQueue); 
		 return false;
	 }
	 try
	 {
			ObsoleteItem=TmpHead->GetNextItem();
			TmpHead->SetNextItem(ObsoleteItem->GetNextItem());  
			if(ObsoleteItem==m_qnodeTailQnode) m_qnodeTailQnode=TmpHead;
			delete ObsoleteItem;
			ReleaseMutex(m_MuxQueue); 
			return true;
	 }catch(...) {	 ReleaseMutex(m_MuxQueue); return false;	}
}

template<class ITEM> 
void CExtendedLinkedList<ITEM>::operator=(CExtendedLinkedList<ITEM> &CopyFrom)
{
	CloseHandle(m_MuxQueue); 
	
	m_MuxQueue = CopyFrom.m_MuxQueue;
	m_qnodeHeadQnode = CopyFrom.m_qnodeHeadQnode; 
	m_qnodeTailQnode = CopyFrom.m_qnodeTailQnode;
	
	CopyFrom.m_MuxQueue = CreateMutex(0,0,0);
	CopyFrom.m_qnodeHeadQnode = 0, CopyFrom.m_qnodeTailQnode = 0;
}