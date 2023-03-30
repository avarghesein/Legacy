
#include"\tc\bin\viju's\sourse\bases.c"

void main()
{

char *no;
double s;
int m1[100],m2[100],i,j,k,n;

clrscr();

printf("Enter the octal number:\n");
scanf("%s",no);


n=strglen(no);
for(k=-1,i=0;i<n&&no[i]!='.';i++) m1[++k]=chkoct(no[i]);
for(j=i+1,i=-1;j<n;j++) m2[++i]=chkoct(no[j]);

for(s=j=0;j<=k;j++) s+=m1[j]*power(8,k-j);
for(j=0;j<=i;j++)   s+=m2[j]*power(8,-(j+1));

printf("\n\nEntered octal is %s",no);
printf("\n\nEqvalent decimal is %lf",s);

getch();
}