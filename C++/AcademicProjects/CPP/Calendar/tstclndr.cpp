

#include"e:\tc\bin\cpp\calender\calender.cpp"
#include<dos.h>
#include<stdlib.h>



#define B 1
#define E 10000000

//---------------Normal function--------//

long tst(long begy,long endy)
{
long cnt=0;

for(long i=begy;i<=endy;i++)
	if(isleapyear(i)) ++cnt,i+=3;
return cnt;
}

void main()
{
	clrscr();
    struct time t1;
	struct time t2;
    long int x1,y1,z1,w1;
    long x,BEGY=B,ENDY=E;

    cout<<"\nChecking EFFICIENCY of 2 Functions to count leap years bw 2 yrs\n\n";
    cout<<"\nBEGINING,ENDING yrs (defaults:1,1-CRORE)\n";
    cout<<"\n1-BEGINING Yr,2-ENDING yr,3-BOTH yrs REINITIALIZING\nANY OTHER-No change:";
    cin>>x;

    if(x==1||x==3)
			cout<<"\nEnter BEG yr:",cin>>BEGY;
    if(x==2||x==3)
       		cout<<"\nEnter END yr:",cin>>ENDY;

    cout<<"\n\nModified function to find leap yrs\n";
    gettime(&t1);
	x=findleapbw(BEGY,ENDY);
	gettime(&t2);
    x1=t1.ti_hour,y1=t1.ti_min,z1=t1.ti_sec,w1=t1.ti_hund;
    cout<<"\nBEG time "<<x1<<":"<<y1<<":"<<
        z1<<":"<<w1<<"\nYRS="<<x;
    x1=t2.ti_hour,y1=t2.ti_min,z1=t2.ti_sec,w1=t2.ti_hund;

       cout <<"\n"<<"END time "<<x1<<":"<<y1<<":"<<
        z1<<":"<<w1;


   cout<<"\n\nOrdinary function to find leap yrs bw 2 yrs\nWAIT!!!\n";
   gettime(&t1);
   x=tst(BEGY,ENDY);
   gettime(&t2);
   x1=t1.ti_hour,y1=t1.ti_min,z1=t1.ti_sec,w1=t1.ti_hund;
   cout<<"\nBEG time "<<x1<<":"<<y1<<":"<<
   z1<<":"<<w1<<"\nYRS="<<x;
   x1=t2.ti_hour,y1=t2.ti_min,z1=t2.ti_sec,w1=t2.ti_hund;

   cout <<"\n"<<"END time "<<x1<<":"<<y1<<":"<<
   z1<<":"<<w1;

    getch();
}
