

#include"\tc\bin\viju's\sourse\mat.c"

#define MIN(x,y) ((x)<(y)?(x):(y))

//-----------sub structures---------------//

  typedef struct
  {
	int   num;
	char *name[100];
	int   capacity[100];
  }
  factory;

  typedef struct
  {
	int   num;
	char *name[100];
	int   reqs[100];
  }
  destination;

//--------------------main structure------------------------//

  typedef struct
  {
	factory       f;
	destination   d;
	int             tptable[100][100];
	int           allocated[100][100];
  }
  tp;

//-----------------------------------------------------------//

void readtptable(tp *t)
{
int i,j;

	printf("\nEnter number of sources:"),scanf("%d",&t->f.num);
	printf("\nEnter number of destinations:"),scanf("%d",&t->d.num);
	printf("\n\nEnter name & capacity of sources\n");
	for(i=0;i<t->f.num;i++)
	   scanf("%s%d",t->f.name[i],&t->f.capacity[i]);

	printf("\n\nEnter name & requirements of destinations\n");
	for(j=0;j<t->d.num;j++)
	   scanf("%s%d",t->d.name[j],&t->d.reqs[j]);

	for(i=0;i<t->f.num;i++)
		for(j=0;j<t->d.num;j++)
			printf("\nEnter unit cost of transporting from %s to %s:",
			t->f.name[i],t->d.name[j]),
			scanf("%d",&t->tptable[i][j]),
			t->allocated[i][j]=-1;

return;
}



void printtptable(tp *t)
{
int i,j,cost;

	clrscr();
	printf("\n\nNumber of sources:%d\nNumber of destinations:%d"
		   ,t->f.num,t->d.num);

	for(cost=j=0;j<t->d.num;j++)
	{
		printf("\n\nAllocation details for %s",t->d.name[j]);
		for(i=0;i<t->f.num;i++)
			if(t->allocated[i][j]>0)
			{
			   cost+=t->allocated[i][j]*t->tptable[i][j];
			   printf("\n%d items are allocated from %s",
					   t->allocated[i][j],t->f.name[i]);
			}
	}
	printf("\n\nTotal cost of transportation=%d",cost);

return;
}



void vam_method(tp *t)
{
int i,j,t1,t2,row,col,num,max,flag1,flag2,rflg;


   for(rflg=flag1=i=0;i<t->f.num;i++)
	  if(t->f.capacity[i]<=0) continue;
	  else
	  {
		  for(flag2=j=0;j<t->d.num;j++)
			 if(t->d.reqs[j]<=0) continue;
			 else
				 if(flag2==0) t2=t->tptable[i][j],t1=0,flag2++;
				 else
					 if(flag2==1) t1=t->tptable[i][j],flag2++;
					 else
						  if((num=t->tptable[i][j])<t1) t1=num;
						  else
							   if(num<t2) t2=num;
							   else continue;

		  if(flag2==0) continue;
		  num=abso(t1-t2);
		  if(flag1==0) rflg=1,flag1++,row=i,max=num;
		  else if(num>max) max=num,row=i;
	  }

   if(flag1==0) return;


   for(flag1=j=0;j<t->d.num;j++)
	  if(t->d.reqs[j]<=0) continue;
	  else
	  {
		  for(flag2=i=0;i<t->f.num;i++)
			 if(t->f.capacity[i]<=0) continue;
			 else
				 if(flag2==0) t2=t->tptable[i][j],t1=0,flag2++;
				 else
					 if(flag2==1) t1=t->tptable[i][j],flag2++;
					 else
						  if((num=t->tptable[i][j])<t1) t1=num;
						  else
							   if(num<t2) t2=num;
							   else continue;

		  if(flag2==0) continue;
		  num=abso(t1-t2);
		  if(flag1==0) flag1++;
		  if(num>max) rflg=0,max=num,col=j;
	  }

   if(flag1==0) return;

   if(rflg==1)
	  {	for(col=-1,j=0;j<t->d.num;j++)
			if(t->d.reqs[j]>0)
				if(col==-1) col=j; else
				if(t->tptable[row][j]<t->tptable[row][col]) col=j;
	  }
   else
	  {	for(row=-1,i=0;i<t->f.num;i++)
			if(t->f.capacity[i]>0)
				if(row==-1) row=i; else
				if(t->tptable[i][col]<t->tptable[row][col]) row=i;
	  }

   num=MIN(t->d.reqs[col],t->f.capacity[row]);

   t->allocated[row][col]=num;
   t->d.reqs[col]-=num;
   t->f.capacity[row]-=num;

   vam_method(t);
   return;
}