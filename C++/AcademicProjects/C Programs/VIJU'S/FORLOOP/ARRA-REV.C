/*-----REVERSING AN ARRAY WITHOUT A TEMPORARY VARIABLE----------*/

#include<stdio.h>
void main()
{ int i,n,j,x[20];
   clrscr();
printf("Enter no nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);

for(i=0;i<n;i++)
{	for(j=n-1;j>=i;j--) x[j+1]=x[j];
	x[i]=x[n];
}
printf("Nos in reverse order:\n");
for(i=0;i<n;i++) printf("\n%d",x[i]);
getch();
}