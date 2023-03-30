
#include<iostream.h>
#include<conio.h>

void main()
{
int x[30],i,j,k,n;
clrscr();

		cout<<"\nEnter no of elements:";
        cin>>n;
        cout<<"\nEnter elements\n\n";
        for(i=0;i<n;i++) cin>>x[i];

        i=0;
        while(i<n)
        {
        	j=i+1;
            while(j<n)
                if(x[i]==x[j])
                {
                	for(k=j;k<n-1;k++) x[k]=x[k+1];
                    --n;
                }
                else ++j;

            ++i;
        }

        cout<<"\n\nNew array is\n\n";
        for(i=0;i<n;i++) cout<<x[i]<<"\n";

getch();
}
