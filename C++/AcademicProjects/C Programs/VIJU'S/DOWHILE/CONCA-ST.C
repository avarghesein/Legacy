/*----CONCATENATION OF 2 STRINGS--------*/

#include<stdio.h>
void main()
{ char p1[40],p2[20];
  int c1=0,c2=0,k1=0,k2=0,i;
  clrscr();
printf("Enter the first string:\n");
scanf("%s",p1);
printf("Enter the 2nd string:\n");
scanf("%s",p2);
i=0;
do
{  if(c1==0)if(p1[i]=='\0')c1=1;else k1++;
   if(c2==0)if(p2[i]=='\0')c2=1;else k2++;
   if(c1!=0&&c2!=0)break;
   i++;
}while(i<20);

for(i=0;i<=k2;i++)p1[k1+i]=p2[i];

printf("\n\nThe concated string is:\n");
printf("%s",p1);
getch();
}