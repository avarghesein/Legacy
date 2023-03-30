
#include<stdlib.h>
#include<conio.h>
#include"e:\tc\bin\cpp\calender\calender.cpp"

void main()
{
	clrscr();
    int yr1,yr2,mm,dd,d_na;
    cout<<"\nEnter dd-mm-yy:",cin>>dd>>mm>>yr1;
    char dn[20],mon[20];
    monthname(mon,mm);
    if(!(d_na=finddayname(yr1,mm,dd,dn)))
	{
		cout<<"\nError in Date!!!",getch();
        return;
    }
    if(!(yr2=nextyearwithdayname(yr1+1,yr1+28,dd,mm,d_na)))
    	cout<<"\n\nNo year exsist as "<<dd<<"-"<<mon<<" is a "<<dn
        	<<" After the year "<<yr1<<" Due to Error in Year "<<yr1;
    else
    {
    	cout<<"\n\nYear "<<yr2<<" has exactly "<<dd<<"-"<<mon<<" as a "<<dn
        	<<" After the year "<<yr1,
        cout<<"\n\nThat is "<<dd<<"-"<<mm<<"-"<<yr2<<" is "<<dn;

        cout<<"\n\nYear "<<yr2<<" is far from Year "<<yr1<<" of "<<yr2-yr1<<" YEARS";
     }
    getch();
}
