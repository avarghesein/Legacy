
#include"e:\tc\bin\cpp\inc\exprn.cpp"
#include<conio.h>

void main()
{
	clrscr();
    cout<<"\n\nEnter expression\n\n";
    char x[50];
    cin>>x;
    exprn e(x);
    if(exprncorrect(e)) cout<<"\n\n"<<x<<" is CORRECT!!!";
    else cout<<"\n\n"<<x<<" is NOT CORRECT!!!";

    getch();
}
