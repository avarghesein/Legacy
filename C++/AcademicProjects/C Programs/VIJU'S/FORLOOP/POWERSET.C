
#include<math.h>
#include<stdlib.h>


void main()
{
char *x;
int  n,flag;
unsigned long int tot,i,leftbit=0x00000001,j;
clrscr();


	printf("\n\n\nEnter number of elements:");
	scanf("%d",&n);
	printf("\n\nEnter elements of the set\n");
	for(x=(char*)malloc(n+1),i=0;i<n;i++) flushall(),scanf("%c",&x[i]);

	clrscr();
	if(n>=0)
	{   printf("ENTERED SET IS {");
		for(flag=0,i=0;i<n;i++)
			if(flag!=0) printf(",%c",x[i]); else printf("%c",x[i]),flag=1;
		printf("}\n\n");
		if(n>0)    printf("\n\nPOWER SET IS\n\n");   else
				   printf("\n\nNULL SET,POWER SET IS\n\n");
	}
	else printf("\n\nERROR!!!,Number of elements is -ve\n\n");

	for(tot=pow(2,n),i=0;i<tot;i++)
	{
		printf("\nSUB SET %d\t{",i+1);
		for(flag=0,j=0;j<n;j++)
			if( ( (i>>j)&leftbit) ==1)
			{	if(flag!=0) printf(",");
				printf("%c",x[j]);
				flag=1;
			}
		printf("}");
	}

free(x),getch();
}



