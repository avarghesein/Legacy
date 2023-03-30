#include "\tc\bin\ds\inc\polynom.c"

void main()
{
poly p,q,t,rem;
int n,i;
clrscr();

printf("Enter no  of values for poly 1:\n");
scanf("%d",&n);
printf("Enter powers &  corresponding coeffs:\n");
for(i=0;i<n;i++) scanf("%d%f",&p.po[i],&p.co[i]);
p.n=n-1;


printf("Enter no  of values for poly 2:\n");
scanf("%d",&n);
printf("Enter powers & corresponding coeffs:\n");
for(i=0;i<n;i++) scanf("%d%f",&q.po[i],&q.co[i]);
q.n=n-1;

t=addpoly(&p,&q);
printf("\n\naddition\n\n");
for(i=0;i<=t.n;i++) printf("+(%fX^%d)",t.co[i],t.po[i]);
getch();

t=subpoly(&p,&q);
printf("\n\nsubtraction\n\n");
for(i=0;i<=t.n;i++) printf("+(%fX^%d)",t.co[i],t.po[i]);
getch();


printf("\n\nmultiplication\n\n");
t=mulpoly(&p,&q);
for(i=0;i<=t.n;i++) printf("+(%0.2fX^%d)",t.co[i],t.po[i]);
getch();


printf("\n\nDivision\n\n");
t=divpoly_rem(&p,&q,&rem);
printf("\n\nQuotient\n\n");
for(i=0;i<=t.n;i++) printf("+(%fX^%d)",t.co[i],t.po[i]);
printf("\n\nRemainder\n\n");
for(i=0;i<=rem.n;i++) printf("+(%fX^%d)",rem.co[i],rem.po[i]);
getch();

printf("\n\nFinding GCD\n\n");
t=gcdpoly(&p,&q);
for(i=0;i<=t.n;i++) printf("+(%fX^%d)",t.co[i],t.po[i]);
getch();


}
