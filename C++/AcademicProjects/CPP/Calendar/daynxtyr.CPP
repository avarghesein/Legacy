
#include<stdlib.h>
#include<conio.h>
#include"e:\tc\bin\cpp\calender\calender.cpp"

void main()
{
	clrscr();
    int yr1,yr2,mm,dd,d_na,yr3;
    cout<<"\nEnter the Day-name(Sun=1..Sat=7):",cin>>d_na;
    char dn[20],mon[20];
    dayname(dn,d_na);
    cout<<"\nEnter the Date & Month:",cin>>dd>>mm;
    monthname(mon,mm);
    cout<<"\nEnter the 2 Years to check the exsistance of an Year 'YR' Between them\nSatisfies "
    	<<dd<<"-"<<mon<<"-YR is a "<<dn<<":";
    cin>>yr1>>yr2;

    if(!(yr3=nextyearwithdayname(yr1,yr2,dd,mm,d_na)))
    	cout<<"\n\nNo year exsist as "<<dd<<"-"<<mon<<" is a "<<dn
        	<<" Between the years "<<yr1<<" & "<<yr2;
    else
    {
    	cout<<"\n\nYear "<<yr3<<" exsist as "<<dd<<"-"<<mon<<" is a "<<dn
        	<<" Between the years "<<yr1<<" & "<<yr2,
        cout<<"\n\nThat is "<<dd<<"-"<<mm<<"-"<<yr3<<" is "<<dn;

        if(yr1>yr2) yr1=yr2;
        cout<<"\n\nYear "<<yr3<<" is far from Year "<<yr1<<" of "<<yr3-yr1<<" YEARS";
     }
    getch();
}
