

#include<stdlib.h>
#include"e:\tc\bin\cpp\calender\calender.cpp"

void main()
{
    clrscr();
    cout<<"\nEnter the month,year:";
    int yr,mn;
    cin>>mn>>yr;
    if(!printmonthinyear(mn,yr)) cout<<"\nError invalid Month/Year!!!";
    else cout<<"\n\n\nThank you!!!\n";
    getch();
}
