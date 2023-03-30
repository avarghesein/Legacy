#include<stdio.h>
void main()
{
	long int  n,i,j,k,p,f1,f2;
     clrscr();
	printf("Enter no of raws:\n");
	scanf("%ld",&n);
     for(i=0;i<n;i++)
     {	for(j=0;j<=n-i;j++) printf(" ");
     	for(j=0;j<=i;j++)
             {      for(f1=f2=k=1,p=i;k<=j;k++,p--)
		   		{ f1*=p;
				  f2*=k;
				}
				printf("%ld ",f1/f2);
             }
          printf("\n");
    }
    getch();
}
