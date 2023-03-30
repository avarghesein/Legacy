//----------OCTAL TO HEXADECIMAL---------------//
//-----------including decimal parts--------------//

#include"\tc\bin\viju's\sourse\basecnvrt.c"


void main()
{
int i,j,k=-1,m=0,dec[50],m1,oct[50],count;
float p,s;
char x[50],bny[55];
clrscr();

	printf("Enter the OCTAL number:");
	scanf("%s",x);
	for(i=0;x[i]!='.'&&x[i]!='\0';i++)
		++k,oconvert(x[i],dec,k);

	for(j=i;x[j]!='\0';j++)
		if(x[j]=='.') continue;
		else
			++m,oconvert(x[j],dec,j-1);


	for(m1=i=0;i<=k;i++)  m1=obiny(dec[i],bny,m1);
	bny[m1++]='.';
	for(i=1;i<=m;i++) m1=obiny(dec[k+i],bny,m1);

	bny[m1++]='0',bny[m1]='\0';

	//---------------binary to hex---------------//
	k=-1,m=0;
	for(i=0;bny[i]!='.'&&bny[i]!='\0';i++)
		++k,oconvert(bny[i],dec,k);

	for(j=i;bny[j]!='\0';j++)
		if(bny[j]=='.') continue;
		else
			++m,oconvert(bny[j],dec,j-1);


	for(j=0,i=k;i>=0;i--,j++) oct[j]=dec[i];
	for(j=0,i=1;i<=m;i++,j++) dec[j]=dec[k+i];

	count=0,s=0,j=0,p=1;
	for(i=0;i<=k;i++)
	{   if(count<4)
			s+=oct[i]*p,count++,p*=(float)2;

		if(count==4)
		{   if(s<10) bny[j++]=(char)((int)s+48);
			else bny[j++]=(char)((int)s-10+65);
			s=0,p=1,count=0;
		 }
	 }
	 if(count<4)
		if(s<10) bny[j++]=(char)((int)s+48);
		else bny[j++]=(char)((int)s-10+65);


	 bny[j]='\0',rev(bny,j);

	 bny[j++]='.';
	 count=0,s=0,p=8;

	 for(i=0;i<=m-1;i++)
	 {   if(count<4)
			s+=dec[i]*p,count++,p/=(float)2;

		 if(count==4)
		 {   if(s<10) bny[j++]=(char)((int)s+48);
			 else bny[j++]=(char)((int)s-10+65);
			 s=0,p=8,count=0;
		 }

	 }
	 if(count<4)
		 if(s<10) bny[j++]=(char)((int)s+48);
		 else bny[j++]=(char)((int)s-10+65);


	 bny[j]='\0';

	 clrscr(),printf("\n\n\n\Entered OCT-number=%s\n\nCorresponding HEX-NO=%s",x,bny);

getch();
}


