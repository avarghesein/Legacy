
#pragma once

#include "ChildControl.h"

class CTextBox : public CChildControl
{
public:
	CTextBox(int TextBoxId,CWindow ParentWindow);
	virtual CTString GetText(void);
	virtual bool SetText(CTString Text);
};

CTextBox::CTextBox(int TextBoxId,CWindow ParentWindow)
: CChildControl(TextBoxId,ParentWindow) {};

bool CTextBox::SetText(CTString Text)
{
	return CChildControl::SetText(Text); 
}

CTString CTextBox::GetText(void)
{
	return CChildControl::GetText(); 
}