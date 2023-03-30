
#include<stdlib.h>
#include<conio.h>
#include"e:\tc\bin\cpp\calender\calender.cpp"

void main()
{
	clrscr();
    cout<<"\nEnter the year:";
    int yr;
    cin>>yr;
    if(yr<=0)
    {
    		cout<<"\nError in year\n",getch();
            return;
    }
    calender c(yr);
    cout<<"\nEnter file name to save calender(with extension):";
    char fn[20];
    cin>>fn;
    if(!c.printcalender(fn)) cout<<"\nError!!!",getch(),exit(0);
    cout<<"\nFile "<<fn<<" contains calender for year "<<yr;
    getch();
}
