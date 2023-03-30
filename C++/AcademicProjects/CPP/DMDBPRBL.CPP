
#include"e:\tc\bin\cpp\dmdb.cpp"

void main()
{
dm m;
db b;
clrscr();

	int w=1;

    while(!(w<1)&&!(w>=3))
    {
    	cout<<"\n\n1-add mts & fts to mts,2-add mts & fts to fts,";
        cout<<"any other number to exit:",cin>>w;
        if(w<1||w>=3) continue;
        m.read(),b.read();
        cout<<"\nResult\n";
        if(w==1)  m=add_dbtodm(b,m),m.display();
        else      b=add_dmtodb(m,b),b.display();
	}


}
