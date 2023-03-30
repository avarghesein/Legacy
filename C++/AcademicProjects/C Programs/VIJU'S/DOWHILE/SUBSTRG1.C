/*---------FINDING WHETHER THE GIVEN SUBSTRING IS PRESENT IN..
....IN THE GIVEN STRING--------*/

#include<stdio.h>
void main()
{
  char p[20],p1[20];
  int c1=0,c2=0,k1=0,k2=0,i,j,r;
  clrscr();

printf("Enter the string:\n");
scanf("%s",p);
printf("\nEnter the sub-string:\n");
scanf("%s",p1);

i=0;
do
{  if(c1==0)if(p[i]=='\0')c1=1;else k1++;
   if(c2==0)if(p1[i]=='\0')c2=1;else k2++;
   if(c1!=0&&c2!=0)break;
   i++;
}while(i<20);

for(i=0;i<k1;i++)
{	if(p[i]==p1[0])
		for(j=0,r=i;j<k2;j++,r++)
	  		  {	if(p1[j]!=p[r])break;
                    if(j==k2-1)
                    	{ printf("\n\nSubstring found:\n");
                           i=k1-1;
                         }
                 }
}
if(i==k1&&j!=k2)printf("\n\nSubstring not find:\n");

getch();
}





