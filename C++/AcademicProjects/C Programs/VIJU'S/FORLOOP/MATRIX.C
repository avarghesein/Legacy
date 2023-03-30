/*----------MATRIX MULTIPLICATION--------------*/

#include<stdio.h>
#include<math.h>
void main()
{  int m,n,o,p,i,j,k;
   float m1[25][25],m2[25][25],m3[25][25];
   clrscr();
   printf("Enter no of rows&columns for Matrix1 &Matrix2 respectiveley:\n");
   scanf("%d%d%d%d",&m,&n,&o,&p);
  if(!(n==o)) printf("MATRICES CANNOT BE MULTYPLIED:\n");
  else
  {
 	 printf("Enter elements for Matrix1:\n");
	 for(i=1;i<=m;i++)
 		for(j=1;j<=n;j++)
		    scanf("%f",&m1[i][j]);

 	 printf("Enter elemments for Matrix2:\n");
	 for(i=1;i<=o;i++)
 		for(j=1;j<=p;j++)
		    scanf("%f",&m2[i][j]);

	 for(i=1;i<=m;i++)
 		for(j=1;j<=p;j++)
 			for(m3[i][j]=0,k=1;k<=n;k++)
 			    m3[i][j]+=m1[i][k]*m2[k][j];

	 printf("\nThe Resultant Matrix is:\n\n");
  	 for(i=1;i<=m;i++)
 	 {
 		 for(j=1;j<=p;j++)
 			 printf("%5.0f",m3[i][j]);
 	 printf("\n\n");
 	 }

  }
   getch();
}