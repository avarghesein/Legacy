
#include"\tc\bin\viju's\sourse\basecnvrt.c"
#include"\tc\bin\viju's\sourse\strings.c"

void main()
{

char *no;
double s;
int m1[100],m2[100],i,j,k,n;

clrscr();

printf("Enter the binary number:\n");
scanf("%s",no);

n=strglen(no);
for(k=-1,i=0;i<n&&no[i]!='.';i++) m1[++k]=chkbin(no[i]);
for(j=i+1,i=-1;j<n;j++) m2[++i]=chkbin(no[j]);

for(s=j=0;j<=k;j++) s+=m1[j]*power(2,k-j);
for(j=0;j<=i;j++) s+=m2[j]*power(2,-(j+1));

printf("\n\nEntered binary number is %s\n\n",no);
printf("\tEqvalent decimal is %lf",s);

getch();
}