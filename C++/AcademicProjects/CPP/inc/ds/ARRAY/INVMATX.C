
#include"\tc\bin\ds\inc\matrix.c"
#include"\tc\bin\ds\inc\rational.c"

void main()
{
float a[50][50],adj[50][50],m;
int i,j,r,c;
ratio p;
clrscr();


	printf("Enter rows & columns of matrix:");
	scanf("%d%d",&r,&c);
	printf("Enter the %d elements\n\n",r*c);

	for(i=0;i<r;i++)
		for(j=0;j<c;j++) scanf("%f",&a[i][j]);

	m=determinantof(a,r,c);
	if(m==0)
		printf("\nInverse not exsist\n"),getch(),exit();

	adjointof(a,r,c,adj,&r,&c);
	printf("\n\n*********INVERSE IS*************\n\n");
	for(i=0;i<r;i++)
	{
		for(j=0;j<c;j++)
		  p.nr=(int)adj[i][j],p.dr=(int)m,rational(&p),
		  printf("\t%d/%d",p.nr,p.dr);

		printf("\n\n");
	}

getch();
}


