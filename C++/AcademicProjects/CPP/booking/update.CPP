
#include<conio.h>
#include<stdlib.h>
#include"e:\tc\bin\cpp\train\train.cpp"

void main()
{

clrscr();

    char name[20];
    cout<<"\nEnter file to update that contains train details(with extension):";
    cin>>name;

    if(!updatetrain(name)) cout<<"\nError,File not exsist!!!",getch();
    else
	{
		cout<<"\nFile "<<name<<" updated to the new date";
        cout<<"\n\nEnter 1-add new trains,other-exit:";
        int flg;
        cin>>flg;
        if(flg!=1) exit(0);
        fstream f(name,ios::binary|ios::app);
        train x;
    	char ch='y';
        while(ch!='n')
    	{
        	cout<<"\nDo you want to continue(y/n):",cin>>ch;
            if(ch=='n') continue;
    		cout<<"\nEnter train detils\n",x.gettrain();
            if(!isvaliddate(x))
            {
            	cout<<"\nDate expired!!!,Entry discarded\n";
                continue;
            }
            f.close(),flg=isexsisttrain(x,name),f.open(name,ios::binary|ios::app);

            if(!flg) f<<x; else cout<<"\nTrain already exsist!!!\n";
    	}
    	f.close();
    }
}

