#include<stdio.h>
void main()
{
	int r,c,i,j,k;
     clrscr();
	printf("Enter no of raws & columns:\n");
     scanf("%d%d",&r,&c);
     printf("\nMULTIPLICATION-TABLE:\n\n");
     i=1;
     do
     {	j=1;
     	k=i;
          do
          {	printf("%d\t",k);
          	k+=i;
               j++;
          } while(j<=c);
          printf("\n");
          i++;
     } while(i<=r);
     getch();
     }
