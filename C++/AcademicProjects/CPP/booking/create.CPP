
#include"e:\tc\bin\cpp\train\train.cpp"
#include<conio.h>

void main()
{

clrscr();

    fstream tr;
	train x;
    char name[20];
    cout<<"\nEnter file to store train details(with extension):";
    cin>>name;
    tr.open(name,ios::out|ios::binary),tr.seekp(0);
    char ch='y';
    int flg;

    	while(ch!='n')
    	{
    		cout<<"\nEnter train detils\n";
        	x.gettrain();

            tr.close(),flg=isexsisttrain(x,name),
			tr.open(name,ios::app|ios::binary|ios::nocreate);

            if(!flg) tr<<x; else cout<<"\nTrain already exsist!!!\n";

        	cout<<"\nDo you want to continue:",cin>>ch;
    	}

    tr.close(),cout<<"\nFile created",getch();
}
