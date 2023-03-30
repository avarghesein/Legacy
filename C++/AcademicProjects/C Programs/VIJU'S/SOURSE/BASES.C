#include"\tc\bin\viju's\sourse\basecnvrt.c"

//----------------------------------------------------------------------//

double octtodec(char *no)
{

double s;
int m1[100],m2[100],i,j,k,n;


n=strglen(no);
for(k=-1,i=0;i<n&&no[i]!='.';i++) m1[++k]=chkoct(no[i]);
for(j=i+1,i=-1;j<n;j++) m2[++i]=chkoct(no[j]);

for(s=j=0;j<=k;j++) s+=m1[j]*power(8,k-j);
for(j=0;j<=i;j++)   s+=m2[j]*power(8,-(j+1));

return(s);
}

//-----------------------------------------------------------------------------     //

double bintodec(char *no)
{
	double s;
	int m1[100],m2[100],i,j,k,n;

	n=strglen(no);
	for(k=-1,i=0;i<n&&no[i]!='.';i++)  m1[++k]=chkbin(no[i]);
	for(j=i+1,i=-1;j<n;j++)            m2[++i]=chkbin(no[j]);

	for(s=j=0;j<=k;j++) s+=m1[j]*power(2,k-j);
	for(j=0;j<=i;j++) s+=m2[j]*power(2,-(j+1));

	return(s);
}

//-------------------------------------------------------------------------       //

double dectobin(char *num)
{   double a,b,i,y,no=stod(num);
	int x;

	x=(int)(no),y=no-x;

	a=0,i=1;
	while(x>0)
	{	a+=(x%2)*i;
		i*=10;
		x/=2;
	}

	b=0.0,i=10;
	while(y!=0&&i<=1E15)
	{	b+=((int)(y*2))/i;
		i*=10;
		y=(y*2)-((int)(y*2));
	}

	return(a+b);
}


//-----------------------------------------------------------------------       //

double dectooct(char *num)
{   double a,b,i,y,no=stod(num);
	int x;

	x=(int)(no),y=no-x;

	a=0,i=1;
	while(x>0)
	{	a+=(x%8)*i;
		i*=10;
		x/=8;
	}

	b=0.0,i=10;
	while(y!=0&&i<=1E15)
	{	b+=((int)(y*8))/i;
		i*=10;
		y=(y*8)-((int)(y*8));
	}

	return(a+b);
}

//----------------------------------------------------------------------        //

double hextobin(char *x,char *bny)
{
	int i,j,k=-1,m=0,dec[50],m1;


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

	return(stod(bny));

}

//-------------------------------------------------------------------------   //

double  hextodec(char *x)
{
int i,j,k=-1,m=0,dec[50];
long int d;
double f;

	for(i=0;x[i]!='.'&&x[i]!='\0';i++)
		++k,convert(x[i],dec,k);

	for(j=i;x[j]!='\0';j++)
		if(x[j]=='.') continue;
		else
			++m,convert(x[j],dec,j-1);


	for(d=0,i=0;i<=k;i++) d+=dec[i]*power(16,k-i);
	for(f=0,i=1;i<=m;i++) f+=dec[k+i]*power(16,-i);

	return((double)d+f);
}
//------------------------------------------------------------------------- //

double hextooct(char *x,char *bny)
{
int i,j,k=-1,m=0,dec[50],m1,oct[50],count;
float p,s;


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

	 return(stod(bny));

}
//----------------------------------------------------------------------  //

void octtohex(char *x,char *bny)
{
int i,j,k=-1,m=0,dec[50],m1,oct[50],count;
float p,s;

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

	 return;
}

//--------------------------------------------------------------------- //

