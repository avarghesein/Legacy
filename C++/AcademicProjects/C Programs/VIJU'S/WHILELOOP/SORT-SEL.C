/*---------SELECTION SORTING----------*/

#include<stdio.h>
void main()
{  int n,i,p,k;
   long int t,x[20];
   clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%ld",&x[i]);

/*-------------SELECTION SORTING STARTS--------------*/

for(i=0;i<n;i++)
{	p=i;
	k=i+1;
     while(k<n)
      {	 if(x[p]>x[k]) p=k;
           k++;
      }
     t=x[i];
     x[i]=x[p];
     x[p]=t;
}

/*---------------SELECTION SORTING ENDS------------------*/

printf("\nNos in ASCENDING order:");
for(i=0;i<n;i++) printf("\n%ld",x[i]);
printf("\n\nNos in DESCENDING order:");
for(i=n-1;i>=0;i--) printf("\n%ld",x[i]);
getch();
}
