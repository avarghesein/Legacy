
#include"e:\tc\bin\cpp\str.cpp"

void main()
{
char *tmp;

    clrscr();
	cout<<"\nEnter string1:";
    cin>>tmp;

    str x(tmp),y;

    cout<<"\nEnter string2:";
    cin>>y;

    cout<<"\n\n";
    if(x<y) cout<<x<<" lessthan "<<y;
    else    cout<<x<<" not lessthan "<<y;

    cout<<"\n\n";
    if(x==y) cout<<x<<" equal to "<<y;
    else	 cout<<x<<" not equal to "<<y;

    str z(y);

    z=x+y;

    cout<<"\n\n"<<x<<"+"<<y<<"="<<z;

	getch();
}

