//--------HEXA-NUMBER TO BINARY INCLUDING FLOATING POINT----------//
#include<stdio.h>
#include"\tc\bin\viju's\sourse\basecnvrt.c"
void main()
{
int i,j,k=-1,m=0,dec[50],m1;
char x[50],bny[55];
clrscr();

	printf("Enter the HEXA-DECIMAL number:");
	scanf("%s",x);
	for(i=0;x[i]!='.'&&x[i]!='\0';i++)
		++k,convert(x[i],dec,k);

	for(j=i;x[j]!='\0';j++)
		if(x[j]=='.') continue;
		else
			++m,convert(x[j],dec,j-1);


	for(m1=i=0;i<=k;i++)  m1=biny(dec[i],bny,m1);
	bny[m1++]='.';
	for(i=1;i<=m;i++) m1=biny(dec[k+i],bny,m1);

	bny[m1++]='0',bny[m1]='\0';

	printf("\n\n\n\tEntered HEX-number=%s\n\n\tCorrecponding binary-number=%s",x,bny);
getch();
}
