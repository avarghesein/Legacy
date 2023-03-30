
#include<stdlib.h>
#include<conio.h>
#include"e:\tc\bin\cpp\calender\calender.cpp"

void main()
{
	clrscr();
    cout<<"\nEnter the date,month,year:";
    int yr,mn,dd,d_na;
    cin>>dd>>mn>>yr;
    char dn[20],mon[20];
    monthname(mon,mn);
    if(!finddayname(yr,mn,dd,dn)) cout<<"\nError invalid date!!!";
    else cout<<"\n"<<dd<<"-"<<mon<<"-"<<yr<<" is "<<dn;
    getch();
}
