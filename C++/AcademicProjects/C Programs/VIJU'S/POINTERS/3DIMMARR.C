/*-------READING 3-DIMM ARRAY PASSING TO FUNCTION BY POINTER  TRANSPOSING
.....IT RETURNIG TO MAIN & PRINTING IT
NOTE:2 POINTER VARIABLES REQUIRED SINCE 3-DIMM ARRAY IS CONSIDERING..
	ONE IS TO FIXING EACH 2-DIMM ARRAY & SECOND FOR FIXING EACH 1-DIMM
     ARRAY IN EACH 2-DIMM ARRAY ....(HERE l,q)----------*/

#include<stdio.h>
void main()
{
int i,j,k,m,n,o,*l,*r,*q,*conv(int *,int,int,int);
int x[5][10][15],y[5][10][15];
clrscr();
printf("Enter no of 2-DIMM ARRAYS:\n");
scanf("%d",&m);
printf("Enter raws & columns for the 2-DIMM ARRAYS:\n");
scanf("%d%d",&n,&o);
printf("Enter elements:\n");
for(i=0;i<m;i++)
	for(j=0;j<n;j++)
     	for(k=0;k<o;k++)
          	scanf("%d",&x[i][j][k]);


r=conv(x[0][0],m,n,o);
l=r;
for(i=0;i<o;i++,r=l+15*10*i)
	for(j=0,q=r;j<n;j++,q=r+15*j)
     	for(k=0;k<m;k++,q++)
             y[i][j][k]=*q;


printf("\n\nTRANSPOSED 3-DIMMENSIONAL ARRAY(1ST 2-DIMM,2ND 2-DIMM,..etc:\n\n");
for(j=0;j<n;j++)
   {	 for(i=0;i<o;i++)
        	 for(k=0;k<m;k++)
			 { printf(" %d",y[i][j][k]);
                  if(k==m-1) printf(" |");
			 }
           printf("\n");
   }

getch();
}

int x2[5][10][15];

int *conv(int *p,int m1,int n1,int o1)
{
	int i,j,k,x1[5][10][15],*l,*q;

     l=p;
	for(i=0;i<m1;i++,p=l+15*10*i)
     	for(j=0,q=p;j<n1;j++,q=p+15*j)
          	for(k=0;k<o1;k++,q++)
                  {	  x1[i][j][k]=*q;
                      x2[k][j][i]=x1[i][j][k];

                  }

     return(x2[0][0]);

}

