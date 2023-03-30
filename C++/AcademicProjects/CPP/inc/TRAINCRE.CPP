
#include"e:\tc\bin\cpp\inc\train.cpp"
#include<conio.h>

void main()
{

clrscr();

    fstream tr;
	train x;
    char name[20];
    cout<<"\nEnter file to store train details(with extension):";
    cin>>name;
    tr.open(name,ios::app),tr.seekp(0);
    char ch='y';
    int flg;

    	while(ch!='n')
    	{
    		cout<<"\nEnter train detils\n";
        	x.gettrain();

            tr.close(),flg=isexsisttrain(x,name),tr.open(name,ios::app);

            if(!flg) tr<<x; else cout<<"\nTrain already exsist!!!\n";

        	cout<<"\nDo you want to continue:",cin>>ch;
    	}

    tr.close(),cout<<"\nFile created",getch();
}
