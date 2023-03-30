/*PROGRAM TO PRINT PRIME NOS WITH IN A RANGE WITHOUT "GOTO" STATEMENT*/

#include<stdio.h>
#include<math.h>
void main()
{
	int s,e,i,j;
     clrscr();
	printf("Enter the range:\n");
     scanf("%d%d",&s,&e);
     printf("\nThe prime nos between %d & %d are:\n\n",s,e);
     i=s-1;
     do
     {    i++;
          if(i>e) break;
         	j=2;
          do
          { 	if(i%j==0)break;
            	j++;
          }
		while(j<i);
          if (i==2) printf("%d\n",i); else
          if (i!=1 && j!=i) continue;
		else printf("%d\n",i);
	}
	while(i<=e);
     getch();
}
