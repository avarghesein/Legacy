
#include<stdlib.h>
#include"\tc\bin\cpp\inc\transpo.cpp"

void main()
{
clrscr();

    cout<<"\nEnter number of factories & destinations & filename:";
    int f,d;
    char n[20];
    cin>>f>>d>>n;
    transport x(f,d);
    if(!freadtable(n,x)) cout<<"\nError",getch(),exit(0);
   	transport y(x);
    x=y;
    y=x;
    vam_method(y);
	cout<<y;

getch();
}