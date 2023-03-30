




/*-----LINEAR EQUATIONS,SOLVING BY AX=B,==>X=[inv(A)]*B-------------//

	a11*X1+a12*X2+.........+a1n*Xn=b1
	a21*X1+a22*X2+.........+a2n*Xn=b2
	.................................
	.................................
	am1*X1+am2*X2+..........+amn*Xn=bm

-----------*/


#include"\tc\bin\ds\inc\matrix.c"

void main()
{
float res[50][50],a[50][50],adj[50][50],k,b[50][50],inv[50][50];
int i,j,r,c,m,n,m1,n1,r1,c1,m2,n2,flag;
clrscr();


	printf("\nEnter rows(m) & columns(n):");
	scanf("%d%d",&m,&n);
	printf("\n\nEnter a11,a12...a1n,a21....,amn\n\n");
	for(i=0;i<m;i++)
		for(j=0;j<n;j++) scanf("%f",&a[i][j]);
	printf("\n\nEnter bi's\n\n");
	for(i=0;i<m;i++)
		for(j=0;j<1;j++) scanf("%f",&b[i][j]);

	k=determinantof(a,m,n);
	adjointof(a,m,n,adj,&m1,&n1);

	if(k!=0)
	{
		inverseof(a,m,n,inv,&m2,&n2);
		multiply(inv,m2,n2,b,m,1,res,&r1,&c1);
		for(i=0;i<r1;i++)
			for(j=0;j<c1;j++) printf("\nX%d=%f",i+1,res[i][j]);
	}
	else
	{
		multiply(adj,m1,n1,b,m,1,res,&r1,&c1);
		flag=1;
		for(i=0;i<r1;i++)
			for(j=0;j<c1;j++)
				if(res[i][j]!=0)
				{	flag=0;
					break;
				}
		if(flag==0) printf("\n\nNo solution exsist");
		else printf("\n\nSystem has infinite solution");
	}
getch();
}