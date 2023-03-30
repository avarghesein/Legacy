/*----------INSERTING A NUMBER INTO AN ARRAY----------*/

#include<stdio.h>
void main()
{ int i,n,j,p1,p;
  float x[20],d;
  clrscr();
printf("Enter no nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%f",&x[i]);

printf("Enter location to inserted & number:\n");
scanf("%d%f",&p1,&d);
p=p1-1;
for(i=n-1;i>=p;i--) x[i+1]=x[i];
x[p]=d;

printf("Nos in inserted order:\n");
for(i=0;i<n+1;i++) printf("\n%f",x[i]);
getch();
}