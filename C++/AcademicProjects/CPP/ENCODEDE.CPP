#include<fstream.h>
#include<iostream.h>
#include<conio.h>
#include<stdio.h>

class Block
{
  public: char byte;
	  void Toggle(void) { byte=~byte; }
};

void main()
{
Block Blk;
long Length=sizeof(Blk);
char sname[20],dname[20];
clrscr();
cout<<"\n\n\nEnter Source File & Destination File with Extension\n\n";
cin>>sname>>dname;
fstream sf(sname,ios::binary|ios::in),df(dname,ios::binary|ios::out);
int cnt=0;
sf.seekg(0);
while(sf.read((char*)&Blk,Length)) cnt++;
cout<<"\nSize of Source "<<cnt<<"\n\n";
//----Turn off Error flg(EOF flag)--------use clear--------//
sf.clear(),sf.seekg(0),df.seekp(0);

while(sf.read((char*)&Blk,Length))
     Blk.Toggle(),df.write((char*)&Blk,Length);

sf.close(),df.close();
cout<<"Ended close",getch();
}

