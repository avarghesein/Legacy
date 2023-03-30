/*PROGRAM TO CHECK WHETHER THE GIVEN NO IS APRIME NO: WITHOUT"GOTO" STATEMENT*/
#include<stdio.h>
void main()
{    int n,j,i;
     clrscr();
	printf("Enter the no:\n");
     scanf("%d",&n);
     j=2;
     do
       {
		if(n%j==0)break;
          j++;
        }
     while(j<i);
     if(n==2)printf("prime"); else
     if(n!=1  && j!=n) printf("Not prime");
     else  printf("prime");
     getch();
 }