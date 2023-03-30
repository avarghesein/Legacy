/*------------------Binary search & Linear search---------------*/
#include<stdio.h>
void main()
{
  int i,j,n,x[20],p,l,u,f=0,m,flag;
  clrscr();
  printf("Enter the no of nos:\n");
  scanf("%d",&n);
  printf("Enter elements:\n");
  for(i=0;i<n;i++) scanf("%d",&x[i]);

  printf("Enter the no to be searched:\n");
  scanf("%d",&p);
  printf("Enter 1-for binary search,any other number for linear search:\n");
  scanf("%d",&flag);
  if(flag==1)
/*------------------Binary searching-----------------------*/
  {
  /*------Sorting the array elements before searching----*/
	  for(i=0;i<n-1;i++)
		  for(j=i+1;j<n;j++)
			  if(x[i]>x[j])
				  {	  m=x[i];
					  x[i]=x[j];
					  x[j]=m;
				  }
  /*---------------Binary searching starts------------*/
	  l=0,u=n-1;
	  while(l<=u)
	  {		  m=(l+u)/2;
			  if(x[m]>p) u=m-1; else
			  if(x[m]<p) l=m+1; else
			  if(x[m]==p)
			  {	  f=1;
				  break;
			  }
	  }
  /*---------------Binary searching ends-------------*/
	  if(f) printf("\n\nNumber is in the array:\n");
	  else printf("\n\nNumber is not in the array:");
  }
  else
/*------------------------Linear searching--------------------*/
  {
   /*---------Linear searching starts----------*/
	  for(i=0;i<n;i++)
	  {		  if(x[i]==p)
			  {	  printf("\n\nNumber is in the array:");
				  break;
			  }
	  }
  /*-------------Linear searching ends----------*/
	  if(i==n) printf("\n\nNumber is not in the array:");
  }
  getch();
}
