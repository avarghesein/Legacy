
#include"\tc\bin\ds\inc\matxrank.c"


void main()
{
int r,c,i,j;
float x[50][50];
clrscr();


printf("Enter number of rows & cols for matrix:");
scanf("%d%d",&r,&c);


printf("\nEnter %d elements\n\n",r*c);

for(i=0;i<r;i++)
	for(j=0;j<c;j++) scanf("%f",&x[i][j]);

i=rankof(x,r,c);
printf("\n\n\n\tRank of MATRIX=%d",i);
getch();
}