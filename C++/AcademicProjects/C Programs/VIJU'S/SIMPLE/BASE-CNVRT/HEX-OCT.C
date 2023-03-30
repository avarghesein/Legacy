//----------HEX TO OCTAL INCLUDING FLOATING POINT----------//


#include"e:\tc\bin\viju's\sourse\basecnvrt.c"
void main()
{
int i,j,k=-1,m=0,dec[50],m1,oct[50],count;
float p,s;
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

	//---------------binary to octal---------------//
	k=-1,m=0;
	for(i=0;bny[i]!='.'&&bny[i]!='\0';i++)
		++k,convert(bny[i],dec,k);

	for(j=i;bny[j]!='\0';j++)
		if(bny[j]=='.') continue;
		else
			++m,convert(bny[j],dec,j-1);


	for(j=0,i=k;i>=0;i--,j++) oct[j]=dec[i];
	for(j=0,i=1;i<=m;i++,j++) dec[j]=dec[k+i];

	count=0,s=0,j=0,p=1;
	for(i=0;i<=k;i++)
	{   if(count<3)
			s+=oct[i]*p,count++,p*=(float)2;

		if(count==3)
		   bny[j++]=(char)((int)s+48),s=0,p=1,count=0;

	 }
	 if(count<3) bny[j++]=(char)((int)s+48);
	 bny[j]='\0',rev(bny,j);

	 bny[j++]='.';
	 count=0,s=0,p=4;

	 for(i=0;i<=m-1;i++)
	 {   if(count<3)
			s+=dec[i]*p,count++,p/=(float)2;

		 if(count==3)
			bny[j++]=(char)((int)s+48),s=0,p=4,count=0;

	 }
	 if(count<3) bny[j++]=(char)((int)s+48);
	 bny[j]='\0';

	 clrscr(),printf("\n\n\n\Entered HEX-number=%s\n\nCorresponding octal =%s",x,bny);


getch();
}

