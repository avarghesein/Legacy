
#include"\tc\bin\ds\inc\matxrank.c"


void main()
{
int r,c,i,j,rnk,r1,c1;
float x[50][50],y[50][50];
clrscr();


printf("Enter number of rows & cols for matrix:");
scanf("%d%d",&r,&c);


printf("\nEnter %d elements\n\n",r*c);

for(i=0;i<r;i++)
	for(j=0;j<c;j++) scanf("%f",&x[i][j]);


rnk=rowcanonicalmatxof(x,r,c,y,&r1,&c1);

printf("\n\n\nROW EQUVALENT CANONICAL MATRIX\n\n\n");

for(i=0;i<r1;i++)
{
	for(j=0;j<c1;j++) printf("%f\t",y[i][j]);
	printf("\n\n");
}

printf("\n\n\nRank of matrix from canonical form=%d",rnk);
getch();
}
