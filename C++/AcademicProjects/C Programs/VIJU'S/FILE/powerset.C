

#include<math.h>
#include<stdio.h>


void main()
{
FILE *p=fopen("pset.txt","w");

char *x;
int  n,flag;
unsigned long int tot,i,leftbit=0x00000001,j;
clrscr();


	printf("\n\n\nEnter number of elements:");
	scanf("%d",&n);
	printf("\n\nEnter elements of the set\n");
	for(x=(char*)malloc(n+1),i=0;i<n;i++) flushall(),scanf("%c",&x[i]);

	if(n>=0)
	{       printf("\n\n\n\t\t\tWAIT!!!");
		fprintf(p,"\nTOTAL NUMBER OF ELEMENTS %d\n\n",n);
		fprintf(p,"ENTERED SET IS {");
		for(flag=0,j=0;j<n;j++)
			if(flag!=0) fprintf(p,",%c",x[j]); else fprintf(p,"%c",x[j]),flag=1;
		fprintf(p,"}\n\n");
		fprintf(p,"TOTAL NUMBER OF SUBSETS %ld\n\n",(long)(pow(2,n)));
		if(n>0)    fprintf(p,"POWER SET IS\n");   else
				   fprintf(p,"NULL SET,POWER SET IS\n");
	}
	else fprintf(p,"\n\nERROR!!!,Number of elements is -ve\n\n");



	for(tot=pow(2,n),i=0;i<tot;i++)
	{
		fprintf(p,"\n%ld\t{",i+1);
		for(flag=0,j=0;j<n;j++)
			if( ( (i>>j)&leftbit) ==1)
			{	if(flag!=0) fprintf(p,",");
				fprintf(p,"%c",x[j]);
				flag=1;
			}
		fprintf(p,"}");
	}

fclose(p),printf("\n\n\tSUCCESS IN GENERATING POWER SET");
getch();
}



