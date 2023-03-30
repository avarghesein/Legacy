/*--------DELETING A NUMBER FROM AN ARRAY-----------*/

#include<stdio.h>
void main()
{ int i,n,j,p1,p;
  float x[20];
  clrscr();

printf("Enter no nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%f",&x[i]);


printf("Enter location to deleted:\n");
scanf("%d",p1);
p=p1-1;
for(i=p;i<n-1;i++) x[i]=x[i+1];
printf("Nos in deleted arry is:\n");
for(i=0;i<n-1;i++) printf("\n%f",x[i]);


getch();
}