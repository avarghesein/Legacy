
#include "\tc\bin\viju's\sourse\cfitting.c"

#define   SET(x)  for(i=0;i<n;i++) x[i]=1;

void main()
{
	double x[100],y[100];
	int f[100];
	int n,flag=1,i;

	clrscr();
	printf("enter no of classes:");
	scanf("%d",&n);
	printf("enter Xi's:");
	readclass(x,n);
	printf("enter Yi's:");
	readclass(y,n);
	SET(f)
	while(flag!=8)
	{
		printf("\n+1->Y=A*(B^X)      /    -1->X=A*(B^Y):\n");
		printf(  "+2->Y=A*(e^(B*X))  /    -2->X=A*(e^(B*Y)):\n");
		printf(  "+3->Y=A+B*X        /    -3->X=A+B*Y:\n");
		printf(  "+4->Y=A+B*X+C*X*X  /    -4->X=A+B*Y+C*Y*Y:\n");
		printf(  "+5->Y=A+B*LnX      /    -5->X=A+B*LnY):\n");
		printf(  "+6->Y=A*(X^B)      /    -6->X=A*(Y^B):\n");
		printf(  "+7->Y=A+B*1/X      /    -7->X=A+B*1/Y:\n");
		printf(  "+8-exit:");
		scanf("%d",&flag);
		switch(absolute(flag))
		{   case	1:clrscr();
					  if(flag==1) abtox(x,y,f,n);
					  else  abtox(y,x,f,n);
					  break;

			case 	2:clrscr();
					  if(flag==2) aetobx(x,y,f,n);
					  else aetobx(y,x,f,n);
					  break;

			case 	3: clrscr();
					   if(flag==3) abx(x,y,f,n);
					   else abx(y,x,f,n);
					   break;

			case 	4: clrscr();
					   if(flag==4) quad(x,y,f,n);
					   else  quad(y,x,f,n);
					   break;
			case    5: clrscr();
					   if(flag==5) ablnx(x,y,f,n);
					   else ablnx(y,x,f,n);
					   break;
			case	6: clrscr();
					   if(flag==6) axtob(x,y,f,n);
					   else axtob(y,x,f,n);
					   break;
			case 	7: clrscr();
					   if(flag==7) abinvx(x,y,f,n);
					   else abinvx(y,x,f,n);
					   break;
		}


   }

}