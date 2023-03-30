#pragma once

#include "ChildControl.h"
#include "GenericExtendedQueue.h"

typedef bool (*ItemToDeleteDelegate)(void* ItemPtr);

class CListBox : public CChildControl
{
protected:
	CExtendedLinkedList<void> mItemData;

protected:
	virtual bool IsBadLResult(LRESULT lResult);

public:
	CListBox(int ListBoxId,CWindow ParentWindow = CWindow(0));
	int AddItem(CTString Item,void* ItemData = 0);
	int InsertItem(int PriorItemIndex,CTString Item,void* ItemData = 0);
	bool DeleteItem(int ItemIndex,ItemToDeleteDelegate ItemToDeleteHandler = 0,bool DeleteItemData = false);
	bool DeleteItem(CTString Item,ItemToDeleteDelegate ItemToDeleteHandler = 0,bool DeleteItemData = false);
	int  SelectedIndex(void);
	CTString SelectedItem(void** SelectedItemData = 0);
	void* SelectedItemData(void);
	bool Clear(ItemToDeleteDelegate ItemToDeleteHandler = 0,bool DeleteItemData = false);
	long Count(void);
}; 

CListBox::CListBox(int ListBoxId,CWindow ParentWindow) : 
CChildControl(ListBoxId,ParentWindow),mItemData(false) {}

bool CListBox::IsBadLResult(LRESULT lResult)
{
	return lResult == LB_ERR || lResult == LB_ERRSPACE;
}

int CListBox::AddItem(CTString Item,void* ItemData)
{
	if(!CChildControl::ValidWindow()) return -1; 
	LRESULT lRes = SendMessage(LB_ADDSTRING,0,(LPARAM)(TCHAR*)Item); 
	if(IsBadLResult(lRes)) return -1;
	mItemData.InsertAtBack(ItemData);
	return (int)lRes;
}

int CListBox::InsertItem(int PriorItemIndex,CTString Item,void* ItemData)
{
	if(!CChildControl::ValidWindow()) return -1; 
	LRESULT lRes = SendMessage(LB_INSERTSTRING,(WPARAM)PriorItemIndex,(LPARAM)(TCHAR*)Item); 
	if(IsBadLResult(lRes)) return -1;
	mItemData.InsertAt(PriorItemIndex,ItemData);
	return (int)lRes;
}

bool CListBox::DeleteItem(int ItemIndex,ItemToDeleteDelegate ItemToDeleteHandler,bool DeleteItemData)
{
	if(!CChildControl::ValidWindow()) return false; 
	LRESULT lRes = SendMessage(LB_DELETESTRING,(WPARAM)ItemIndex,0); 
	if(IsBadLResult(lRes)) return false;
	void *pItem = 0;
	if(mItemData.DeleteFrom((long)ItemIndex,&pItem) && DeleteItemData && pItem && ItemToDeleteHandler) ItemToDeleteHandler(pItem);
	return true;
}

bool CListBox::DeleteItem(CTString Item,ItemToDeleteDelegate ItemToDeleteHandler,bool DeleteItemData)
{
	if(!CChildControl::ValidWindow()) return false; 
	LRESULT lRes = SendMessage(LB_FINDSTRING,(WPARAM)-1,(LPARAM)(TCHAR*)Item); 
	if(IsBadLResult(lRes)) return false;
	return DeleteItem((int)lRes,ItemToDeleteHandler,DeleteItemData);
}

int CListBox::SelectedIndex(void)
{
	if(!CChildControl::ValidWindow()) return -1; 
	LRESULT lRes = SendMessage(LB_GETCURSEL,(WPARAM)0,(LPARAM)0); 
	if(IsBadLResult(lRes)) return -1; else return (int)lRes;
}

CTString CListBox::SelectedItem(void** SelectedItemData)
{
	if(SelectedItemData) *SelectedItemData = 0;
	int iSelIndx = SelectedIndex();
	if(iSelIndx == -1) return CTString();
	DWORD dwLen = SendMessage(LB_GETTEXTLEN,iSelIndx,0L);
	CTString tsBuff(1 + (ULONG)dwLen,true); 
	LRESULT lRes = SendMessage(LB_GETTEXT,iSelIndx,(DWORD)(TCHAR*)tsBuff);
	if(IsBadLResult(lRes)) return CTString();
	if(SelectedItemData) 
	{
		*SelectedItemData = (void*)mItemData[iSelIndx];
	}
	return tsBuff;
}

void* CListBox::SelectedItemData(void)
{
	int iSelIndx = SelectedIndex();
	if(iSelIndx == -1) return 0;
	return (void*)mItemData[iSelIndx];
}

bool CListBox::Clear(ItemToDeleteDelegate ItemToDeleteHandler,bool DeleteItemData)
{
	if(!CChildControl::ValidWindow()) return false; 
	SendMessage(LB_RESETCONTENT,0,0);

	bool bOk = true;
	void *pItem = 0;

	while(!mItemData.IsEmptyList())  
		if(mItemData.DeleteFromFront(&pItem) && DeleteItemData && pItem && ItemToDeleteHandler) 
			bOk &= ItemToDeleteHandler(pItem);    
	
	return bOk;
}

long CListBox::Count(void)
{
	if(!CChildControl::ValidWindow()) return 0;
	LRESULT lRes = SendMessage(LB_GETCOUNT,(WPARAM)0,(LPARAM)0);
	if(IsBadLResult(lRes)) return 0; else return (int)lRes;
}