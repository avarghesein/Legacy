/*-----SORTING BY PASSING ARRAY TO FUNCTION THEN RECALLING SORTED...
      ...ARRAY TO MAIN FUNCTION AND PRINTING IT--------------------*/

#include<stdio.h>
void main()
{
int n,m,i,x[10],y[10],*q,*chan(int *,int);
clrscr();

printf("Enter no of nos for the 1st & 2nd array:\n");
scanf("%d%d",&n,&m);

printf("Enter nos for 1st array:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);
printf("Enter nos for 2nd array:\n");
for(i=0;i<m;i++) scanf("%d",&y[i]);

q=chan(x,n);
printf("\nSORTED 1st ARRAY IN ASCENDING ORDER IS:\n");
for(i=0;i<n;i++,q++) x[i]=*q;
for(i=0;i<n;i++) printf("\n%d",x[i]);

q=chan(y,m);
printf("\nSORTED 2nd ARRAY IN ASCENDING ORDER IS:\n");
for(i=0;i<m;i++,q++) y[i]=*q;
for(i=0;i<m;i++) printf("\n%d",y[i]);

getch();
}

/*-------------POINTER RETURNIG FUNCTION---------------*/
 int x1[10];

 int *chan(int *p,int n1)
 {
  int j,k,t;

  for(j=0;j<n1;j++,p++)x1[j]=*p;
  for(j=0;j<n1-1;j++)
     	for(k=j+1;k<n1;k++)
	     	if(x1[j]>x1[k])
			 {
			   t=x1[j];
     		   x1[j]=x1[k];
      		   x1[k]=t;
			 }
 return(x1);
 }
/*------FUNNCTION ENDING WITH RETURNING A POINTER--------*/