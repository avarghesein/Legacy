//--------Matrix addition,subtraction,multiplication-----------//

#include<stdio.h>

void read(int[][20],int,int),print(int[][20],int,int);
void add(),sub(),mul();
int x[10][20],y[10][20],z[10][20];
int r1,c1,r2,c2;

void main()
{
  int w;
  clrscr();
  printf("Enter number of rows & columns of the 1st matrix:");
  scanf("%d%d",&r1,&c1);
  printf("Enter number of rows & columns of the 2nd matrix:");
  scanf("%d%d",&r2,&c2);
  printf("\nEnter 1-for addition,2-for subtracting,3-for multiply:");
  scanf("%d",&w);
  switch(w)
  {	  case 1:add();
			 break;
	  case 2:sub();
			 break;
	  case 3:mul();
			 break;
	  default:printf("Error in entering choice:\n");
  }
  getch();
}
//--------------function for adding
void add()
{
  int i,j;
  if(r1==r2&&c1==c2)
  {   printf("\nEnter elements of 1st matrix:\n");
	  read(x,r1,c1);
	  printf("\nEnter elements of 2nd matrix:\n");
	  read(y,r2,c2);
	  for(i=0;i<r1;i++)
		  for(j=0;j<c1;j++)
			  z[i][j]=x[i][j]+y[i][j];
	  print(z,r1,c1);
  }
  else printf("Matrices cannot be added:\n");
  return;
}
//-------------function for subtracting
void sub()
{
  int i,j;
  if(r1==r2&&c1==c2)
  {   printf("\nEnter elements of 1st matrix:\n");
	  read(x,r1,c1);
	  printf("\nEnter elements of 2nd matrix:\n");
	  read(y,r2,c2);
	  for(i=0;i<r1;i++)
		  for(j=0;j<c1;j++)
			  z[i][j]=x[i][j]-y[i][j];
	  print(z,r1,c1);
  }
  else printf("Matrices cannot be subtracted:\n");
  return;
}
//-------------function for multiplying
void mul()
{
  int i,j,k;
  if(c1==r2)
  {      printf("\nEnter elements of 1st matrix:\n");
		 read(x,r1,c1);
		 printf("\nEnter elements of 2nd matrix:\n");
		 read(y,r2,c2);
		 for(i=0;i<r1;i++)
			 for(j=0;j<c2;j++)
				 for(z[i][j]=0,k=0;k<c1;k++)
					 z[i][j]+=x[i][k]*y[k][j];
		 print(z,r1,c2);
  }
  else printf("Matrices cannot be multiplied:\n");
  return;
}
//---------function for reading matrix
void read(int d[][20],int r,int c)
{
  int i,j;
  for(i=0;i<r;i++)
	  for(j=0;j<c;j++)
		  scanf("%d",&d[i][j]);
  return;
}
//--------function for printing the resulting matrix
void print(int d[][20],int r,int c)
{
  int i,j;
  printf("\n\nResultant Matrix:\n");
  for(i=0;i<r;i++)
  {	  for(j=0;j<c;j++)
		  printf("%d\t",d[i][j]);
	  printf("\n\n");
  }
  return;
}