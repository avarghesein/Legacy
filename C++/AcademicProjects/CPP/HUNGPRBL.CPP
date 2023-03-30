
#include<stdlib.h>
#include"\tc\bin\cpp\inc\hungary.cpp"

void main()
{
clrscr();

    cout<<"\nEnter number of acceptors & jobs:";
    int a,j;
    cin>>a>>j;
    tp x(a,j);
    cout<<"\nEnter file(with ext) contains data:";
    char na[30];
    cin>>na;
	if(!freadtable(na,x)) cout<<"\nError,file not exsist",getch(),exit(0);
	hungarian_asst(x);
	cout<<x;

getch();
}