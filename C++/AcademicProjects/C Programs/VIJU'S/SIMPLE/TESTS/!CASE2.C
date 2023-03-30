/*----IF N>0  '!N' WILL RETURN '0' SINCE IT CHECKS  FOR THE CASE
	N==0   ,SINCE N>0 IT IS FALSE SO RETURNS '0':
     HERE ! CAUSES CHECKING FOR N==0,WHICH IS DIFFERENT FROM NORMAL
     CHECKING N!=0-------------*/

#include<stdio.h>
void main()
{  int i=-3,j=3;

clrscr();

if(!i+!j*5)printf("DEPUAL");
else printf("COLLEGE");

getch();
}