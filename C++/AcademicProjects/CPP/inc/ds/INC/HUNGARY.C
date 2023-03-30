

#include"\tc\bin\ds\inc\hunginc.c"



//------------------Asst_Function-------------------//


int hungarian_asst(tp *y)
{
int i,j,k,num,choice;
tp x=*y;

	if(x.f.n==0||x.d.n==0||x.f.n!=x.d.n) return(0);

	for(i=0;i<x.f.n;i++)
	{
		for(k=0,j=1;j<x.d.n;j++)
			if(x.tab[i][j]<x.tab[i][k]) k=j;

		for(num=x.tab[i][k],j=0;j<x.d.n;j++) x.tab[i][j]-=num;
	}

	for(j=0;j<x.d.n;j++)
	{
		for(k=0,i=1;i<x.f.n;i++)
			if(x.tab[i][j]<x.tab[k][j]) k=i;

		for(num=x.tab[k][j],i=0;i<x.f.n;i++) x.tab[i][j]-=num;
	}

	do
	{
		make_asst(&x),choice=findcase(&x);
		switch(choice)
		{
			case  1:break;
			case  2:unmrk_mrk(&x);break;
			default:noasst_asst(&x);
		}

	}while(choice==3);

	for(i=0;i<x.f.n;i++)
		for(j=0;j<x.d.n;j++)
			y->alloc[i][j]=x.alloc[i][j];

return(1);
}

///-----------------------------------------------------///


void make_asst(tp *x)
{
int i,j,k,f1,f2,zf;

do
{
	for(f1=i=0;i<x->f.n;i++)
		if(x->f.cap[i]==0) continue; else
		{
			for(k=-1,zf=j=0;j<x->d.n;j++)
				if(x->d.req[j]==0) continue; else
				if(x->tab[i][j]==0) ++zf,k=j;

			if(k==-1||zf!=1) continue;

			f1=1,x->alloc[i][k]=1,x->f.cap[i]=0,x->d.req[k]=0;
		}

	for(f2=j=0;j<x->d.n;j++)
		if(x->d.req[j]==0) continue; else
		{
			for(k=-1,zf=i=0;i<x->f.n;i++)
				if(x->f.cap[i]==0) continue; else
				if(x->tab[i][j]==0) ++zf,k=i;

			if(k==-1||zf!=1) continue;

			f2=1,x->alloc[k][j]=1,x->f.cap[k]=0,x->d.req[j]=0;
		}

}while(f1==1||f2==1);

return;
}


//--------------------------------------------------------------//

int findcase(tp *x)
{
int n=x->f.n,i,j,made;

	for(made=i=0;i<n;i++)
		for(j=0;j<x->d.n;j++)
			if(x->alloc[i][j]==1) ++made;

	if(n==made) return(1); else return(findcase23(x));
}



int findcase23(tp *x)
{
int i,j,zf;

	for(i=0;i<x->f.n;i++)
		if(x->f.cap[i]==0) continue; else
		{
			for(zf=j=0;j<x->d.n;j++)
				if(x->d.req[j]==0) continue; else
				if(x->tab[i][j]==0) zf++;
			if(zf<2) return(3);
		}

	for(j=0;j<x->d.n;j++)
		if(x->d.req[j]==0) continue; else
		{
			for(zf=i=0;i<x->f.n;i++)
				if(x->f.cap[i]==0) continue; else
				if(x->tab[i][j]==0) zf++;
			if(zf<2) return(3);
		}

	return(2);
}

//----------------------------------------------------------------//


void unmrk_mrk(tp *x)
{
int f1,f2,i,j,row,col;

do
{
	for(f1=i=0;i<x->f.n;i++)
	{
		row=find_row_min0(x,&col);
		if(x->f.cap[i]==0||row==-1||row!=i) continue; else
		  f1=1,x->alloc[row][col]=1,x->f.cap[row]=0,x->d.req[col]=0;
	}

	for(f2=j=0;j<x->d.n;j++)
	{
		col=find_col_min0(x,&row);
		if(x->d.req[j]==0||col==-1||col!=j) continue; else
		  f2=1,x->alloc[row][col]=1,x->f.cap[row]=0,x->d.req[col]=0;
	}

}while(f1==1||f2==1);

return;
}



int find_row_min0(tp *x,int *col)
{
int i,j,k,zf,coln,nz;

	for(k=nz=-1,i=0;i<x->f.n;i++)
		if(x->f.cap[i]==0) continue; else
		{
			for(zf=j=0;j<x->d.n;j++)
				if(x->d.req[j]==0) continue; else
				if(x->tab[i][j]==0) ++zf,coln=j;

			if(k==-1) k=i,nz=zf,*col=coln; else
			if(zf<nz) k=i,nz=zf,*col=coln; else continue;
		}

return(k);
}



int find_col_min0(tp *x,int *row)
{
int i,j,k,zf,rowt,nz;

	for(k=nz=-1,j=0;j<x->d.n;j++)
		if(x->d.req[j]==0) continue; else
		{
			for(zf=i=0;i<x->f.n;i++)
				if(x->f.cap[i]==0) continue; else
				if(x->tab[i][j]==0) ++zf,rowt=i;

			if(k==-1) k=j,nz=zf,*row=rowt; else
			if(zf<nz) k=j,nz=zf,*row=rowt; else continue;
		}

return(k);
}



//----------------------------------------------------------------//

void noasst_asst(tp *x)
{
int cap1[30],req1[30],i,j,k,f,f1,f2,cnt,low;

	for(i=0;i<x->f.n;i++) cap1[i]=req1[i]=-1;

	for(f=i=0;i<x->f.n;i++)
		if(x->f.cap[i]!=0) f=1,cap1[i]=1;

	while(f)
	{
		for(f1=i=0;i<x->f.n;i++)
			if(cap1[i]==-1) continue; else
			  for(j=0;j<x->d.n;j++)
				 if(req1[j]==1) continue; else
				 if(x->tab[i][j]==0) f1=1,req1[j]=1;

		for(f2=j=0;j<x->d.n;j++)
			if(req1[j]==-1) continue; else
			  for(i=0;i<x->f.n;i++)
				 if(cap1[i]==1) continue; else
				 if(x->alloc[i][j]==1) f2=1,cap1[i]=1;

		if(f1==1||f2==1) f=1; else f=0;
	}

	for(cnt=i=0;i<x->f.n;i++)
		if(cap1[i]*=-1,cap1[i]==1) ++cnt;

	for(j=0;j<x->d.n;j++)
		if(req1[j]==1) ++cnt;

	if(x->f.n==cnt) return;


	for(low=f=i=0;i<x->f.n;i++)
	   if(cap1[i]==1) continue; else
		 for(j=0;j<x->d.n;j++)
			if(req1[j]==1) continue; else
			if(f==0) f=1,low=x->tab[i][j]; else
			if(x->tab[i][j]<low) low=x->tab[i][j]; else continue;

	for(i=0;i<x->f.n;i++)
		for(x->f.cap[i]=x->d.req[i]=1,j=0;j<x->d.n;j++)
		  if(x->alloc[i][j]=-1,cap1[i]==1&&req1[j]==1) x->tab[i][j]+=low;
		  else
			if(cap1[i]==-1&&req1[j]==-1) x->tab[i][j]-=low;
			else
				continue;

return;
}



//----------------------------------------------------------//