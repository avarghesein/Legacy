
#include<math.h>

//-------------finding inverse of 3x3 matrix by "adj(A)%|A|"-------------//

void inv(float a[][25],float inva[][25])
{
int i,j,i1,j1,i2,j2,sign;
float c[25][25],adj[25][25],det,d;
for(sign=1,det=i=0;i<3;i++)
	for(i1=(i==0?2:i-1),i2=(i==2?0:i+1),j=0;j<3;j++)
	{	j1=(j==0?2:j-1),j2=(j==2?0:j+1);

		d=a[i1][j2]*a[i2][j1]-a[i1][j1]*a[i2][j2];
		if((i1>i2&&j1>j2)||(i1==0&&j1==0&&i2==2&&j2==2)) c[i][j]=-d;
		else c[i][j]=d;

		if(i==0) det+=sign*a[i][j]*c[i][j],sign*=-1;
		c[i][j]*=pow(-1,i+j+2);
	}

if(det==0)
	printf("\n\n\nDeterminant is 0,inverse not exsist,press any key:\n"),getch(),exit();

for(i=0;i<3;i++)
	for(j=0;j<3;j++) adj[j][i]=c[i][j];

for(i=0;i<3;i++)
	for(j=0;j<3;j++)   inva[i][j]=adj[i][j]/det;

return;
}

//---------------multyplying matx m1(3x3) & matx m2(3x1) and resultant is
//---------------stored to m1(3x1) -------------//

void multy(float m1[][25],float m2[][25])
{
float m3[25][25];
int i,j,k;

for(i=0;i<=2;i++)
		for(j=0;j<=0;j++)
			for(m3[i][j]=0,k=0;k<=2;k++)
				m3[i][j]+=m1[i][k]*m2[k][j];
for(i=0;i<3;i++)
	for(j=0;j<1;j++) m1[i][j]=m3[i][j];

return;
}


//-------Finding solution of 3 eq'ns in 3 unknowns by matrix method-----//
/*------let eqns be a(11)X1+a(12)X2+a(13)X3=b1,
					a(21)X1+a(22)X2+a(23)X3=b2,
					a(31)X1+a(32)X2+a(33)X3=b3,

  let define matrices A=| a(11) a(12) a(13) |       B=|b1|
						| a(21) a(22) a(23) |         |b2|
						| a(31) a(32) a(33) |    ,    |b3|   ,
  and X=|x1|
		|x2|     if |A|!=0 we have AX=B ==> X=inverse(A)xB,
		|x3|     we can find inverse(A) by adj(A)%|A|,
-----------------------------------------------------------------*/
void main()
{
float x[25][25],y[25][25],b[25][25];
int i,j;
clrscr();

printf("Enter 'a(ij)'s\n");
for(i=0;i<3;i++)
	for(j=0;j<3;j++) scanf("%f",&x[i][j]);
printf("\n\nEnter b(i)'s\n");
for(i=0;i<3;i++)
	for(j=0;j<1;j++) scanf("%f",&b[i][j]);

inv(x,y);
multy(y,b);

printf("\n\n\nRoots are:\n\n\n");
for(i=0;i<3;i++)
	{	for(j=0;j<1;j++) printf("x(%d)=%f\t",i+1,y[i][j]);
		 printf("\n\n");
	}
getch();
}