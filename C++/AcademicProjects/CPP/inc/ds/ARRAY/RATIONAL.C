
#include "\tc\bin\ds\inc\rational.c"

void main()
{
ratio p,q,t;
clrscr();


printf("\nEnter nr1 & dr1 for nr1/dr1:");
scanf("%d%d",&p.nr,&p.dr);
printf("\n\nEnter nr2 & dr2 for nr2/dr2:");
scanf("%d%d",&q.nr,&q.dr);

if(equal(&p,&q)) printf("\n\nRationals are equal:");   else
				 printf("\n\nRationals are unequal:");

t=addrationals(&p,&q);
printf("\n\n\n\t\t(%d/%d)+(%d/%d)=(%d/%d)",p.nr,p.dr,q.nr,q.dr,t.nr,t.dr);

t=mulrationals(&p,&q);
printf("\n\n\n\n\t\t(%d/%d)x(%d/%d)=(%d/%d)",p.nr,p.dr,q.nr,q.dr,t.nr,t.dr);


getch();
}
