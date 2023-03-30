
//------HEXA DECIMAL TO DECIMAL INCLUDING FRACTIONAL PART---//

#include<stdio.h>
#include"\tc\bin\viju's\sourse\basecnvrt.c"
void main()
{
int i,j,k=-1,m=0,dec[50];
long int d;
double f;
char x[50];
clrscr();

	printf("Enter the HEXA-DECIMAL number:");
	scanf("%s",x);
	for(i=0;x[i]!='.'&&x[i]!='\0';i++)
		++k,convert(x[i],dec,k);

	for(j=i;x[j]!='\0';j++)
		if(x[j]=='.') continue;
		else
			++m,convert(x[j],dec,j-1);


	for(d=0,i=0;i<=k;i++) d+=dec[i]*power(16,k-i);
	for(f=0,i=1;i<=m;i++) f+=dec[k+i]*power(16,-i);

	printf("\n\n\n\tEntered HEX=%s,Equalent decimal=%10.10lf",x,(double)d+f);

getch();
}

