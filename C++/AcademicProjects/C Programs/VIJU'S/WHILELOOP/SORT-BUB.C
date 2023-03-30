/*----------BUBBLE SORTING---------*/

#include<stdio.h>
void main()
{ int n,i,x[20],p,r,t;
  clrscr();
printf("enter no of nos:\n");
scanf("%d",&n);
printf("Enter the nos:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);

/*-------BUBBLE SORTING STARTS-----------*/

for(i=n-1;i>=1;i--)
{
	p=0;r=0;
	while(p<i)
		{	if(x[p]>x[p+1])
			{      t=x[p];
 	    	            x[p]=x[p+1];
  			       x[p+1]=t;
 			       r++;
    			 }
    			 p++;
    		}
	if(r==0)break;
}

/*----------BUBBLE SORTING ENDS-----------*/

printf("The nos in ASCENDINGo order is:\n");
for(i=0;i<n;i++)printf("\n%d",x[i]);
getch();
}