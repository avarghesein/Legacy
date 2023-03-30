

#include<iostream.h>
#include<conio.h>

void main()
{
    int ins_pos(int[],int,int,int);
	clrscr();
    cout<<"\nEnter no of elmnts in the array:";
	int n;
	cin>>n;
    cout<<"\nEnter elements\n\n";
    int x[50];
    for(int i=0;i<n;i++) cin>>x[i];
    cout<<"\nEnter position & value to insert:";
    int pos,val;
    cin>>pos>>val;
    n=ins_pos(x,n,pos,val);
    cout<<"\nInserted array\n\n";
    for(i=0;i<n;i++) cout<<x[i]<<"\n";
    getch();
    return;
}


int ins_pos(int x[],int n,int pos,int val)
{
	if(pos>=n+1) return n;
    for(int i=n-1;i>=pos;i--) x[i+1]=x[i];
    x[pos]=val;
    return n+1;
}
