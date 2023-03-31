
#include<stdlib.h>
#include<stdio.h>


//-----------sub structures---------------//

  typedef struct
  {
	int   n;
	char  name[20][20];
	int   cap[30];
  }
  factory;

  typedef struct
  {
	int   n;
	char  name[20][20];
	int   req[30];
  }
  destination;

//--------------------main structure------------------------//

  typedef struct
  {
	factory       f;
	destination   d;
	int             tab[30][30];
	int           alloc[30][30];
  }
  tp;

//-----------------FUNCTIONS INCLUDED------------------------//


void   freadaptable(tp*);
void   readaptable(tp*);
void   printaptable(tp*);
int    hungarian_asst(tp*); ///-----MAIN FUNCTION OF ASST PRBLM-----///
void   make_asst(tp*);
int    findcase(tp*);
int    findcase23(tp*);
void   unmrk_mrk(tp*);
int    find_row_min0(tp*,int *col);
int    find_col_min0(tp*,int *row);
void   noasst_asst(tp*);

//---------------------------------------------------------------//

void freadaptable(tp *t)
{
FILE *p=fopen("hung.txt","r");
int i,j;

   fscanf(p,"%d",&t->f.n);
   fscanf(p,"%d",&t->d.n);

	for(i=0;i<t->f.n;i++)
	fscanf(p,"%s",t->f.name[i]),t->f.cap[i]=1;

	for(j=0;j<t->d.n;j++)
        fscanf(p,"%s",t->d.name[j]),t->d.req[j]=1;

	for(i=0;i<t->f.n;i++)
		for(j=0;j<t->d.n;j++)
		  fscanf(p,"%d",&t->tab[i][j]),
		  t->alloc[i][j]=-1;

return;
}



void readaptable(tp *t)
{
int i,j;

	printf("\nEnter number of acceptors:"),flushall(),scanf("%d",&t->f.n);
	printf("\nEnter number of jobs:"),flushall(),scanf("%d",&t->d.n);
	printf("\n\nEnter name of acceptors\n");
	for(i=0;i<t->f.n;i++)
	   flushall(),scanf("%s",t->f.name[i]),t->f.cap[i]=1;

	printf("\n\nEnter name of jobs\n");
	for(j=0;j<t->d.n;j++)
	   flushall(),scanf("%s",t->d.name[j]),t->d.req[j]=1;

	for(i=0;i<t->f.n;i++)
		for(j=0;j<t->d.n;j++)
		  printf("\nCost of allotment of job %s to acceptor %s:",t->d.name[j],t->f.name[i]),
		  flushall(),scanf("%d",&t->tab[i][j]),
		  t->alloc[i][j]=-1;

return;
}



void printaptable(tp *t)
{
int i,j,cost;

	clrscr();
	printf("\n\nNumber of acceptors:%d\nNumber of jobs:%d",t->f.n,t->d.n);

	for(cost=j=0;j<t->d.n;j++)
	{
		printf("\n\nSheduling details for job %s",t->d.name[j]);
		for(i=0;i<t->f.n;i++)
			if(t->alloc[i][j]==1)
			{
			   cost+=t->alloc[i][j]*t->tab[i][j];
			   printf("\nsheduled to acceptor %s",t->f.name[i]);
			   break;
			}
	}
	printf("\n\nTotal cost of sheduling=%d",cost);

return;
}


