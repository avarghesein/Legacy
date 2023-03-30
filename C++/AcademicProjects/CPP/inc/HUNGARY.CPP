

#include"\tc\bin\cpp\inc\hunginc.cpp"

int hungarian_asst(tp &y)
{
int i,j,k,num,choice;
tp  x=y;

	if(x.fn==0||x.dn==0||x.fn!=x.dn) return 0;

	for(i=0;i<x.fn;i++)
	{
		for(k=0,j=1;j<x.dn;j++)
			if(x.tab[i][j]<x.tab[i][k]) k=j;

		for(num=x.tab[i][k],j=0;j<x.dn;j++) x.tab[i][j]-=num;
	}

	for(j=0;j<x.dn;j++)
	{
		for(k=0,i=1;i<x.fn;i++)
			if(x.tab[i][j]<x.tab[k][j]) k=i;

		for(num=x.tab[k][j],i=0;i<x.fn;i++) x.tab[i][j]-=num;
	}

	do
	{
		x.make_asst(),choice=x.findcase();
		switch(choice)
		{
			case  1:break;
			case  2:x.unmrk_mrk();break;
			default:x.noasst_asst();
		}

	}while(choice==3);

	for(i=0;i<x.fn;i++)
		for(j=0;j<x.dn;j++)
			y.alloc[i][j]=x.alloc[i][j];

return 1;
}


void tp::make_asst(void)
{
int i,j,k,f1,f2,zf;

do
{
	for(f1=i=0;i<fn;i++)
		if(cap[i]==0) continue; else
		{
			for(k=-1,zf=j=0;j<dn;j++)
				if(req[j]==0) continue; else
				if(tab[i][j]==0) ++zf,k=j;

			if(k==-1||zf!=1) continue;

			f1=1,alloc[i][k]=1,cap[i]=0,req[k]=0;
		}

	for(f2=j=0;j<dn;j++)
		if(req[j]==0) continue; else
		{
			for(k=-1,zf=i=0;i<fn;i++)
				if(cap[i]==0) continue; else
				if(tab[i][j]==0) ++zf,k=i;

			if(k==-1||zf!=1) continue;

			f2=1,alloc[k][j]=1,cap[k]=0,req[j]=0;
		}

}while(f1==1||f2==1);

return;
}

int tp::findcase(void)
{
int n=fn,i,j,made;

	for(made=i=0;i<n;i++)
		for(j=0;j<dn;j++)
			if(alloc[i][j]==1) ++made;

	if(n==made) return(1); else return(this->findcase23());
}



int tp::findcase23(void)
{
int i,j,zf;

	for(i=0;i<fn;i++)
		if(cap[i]==0) continue; else
		{
			for(zf=j=0;j<dn;j++)
				if(req[j]==0) continue; else
				if(tab[i][j]==0) zf++;
			if(zf<2) return(3);
		}

	for(j=0;j<dn;j++)
		if(req[j]==0) continue; else
		{
			for(zf=i=0;i<fn;i++)
				if(cap[i]==0) continue; else
				if(tab[i][j]==0) zf++;
			if(zf<2) return(3);
		}

	return(2);
}

void tp::unmrk_mrk(void)
{
int f1,f2,i,j,row,col;

do
{
	for(f1=i=0;i<fn;i++)
	{
		row=this->find_row_min0(col);
		if(cap[i]==0||row==-1||row!=i) continue; else
		  f1=1,alloc[row][col]=1,cap[row]=0,req[col]=0;
	}

	for(f2=j=0;j<dn;j++)
	{
		col=this->find_col_min0(row);
		if(req[j]==0||col==-1||col!=j) continue; else
		  f2=1,alloc[row][col]=1,cap[row]=0,req[col]=0;
	}

}while(f1==1||f2==1);

return;
}



int tp::find_row_min0(int &col)
{
int i,j,k,zf,coln,nz;

	for(k=nz=-1,i=0;i<fn;i++)
		if(cap[i]==0) continue; else
		{
			for(zf=j=0;j<dn;j++)
				if(req[j]==0) continue; else
				if(tab[i][j]==0) ++zf,coln=j;

			if(k==-1) k=i,nz=zf,col=coln; else
			if(zf<nz) k=i,nz=zf,col=coln; else continue;
		}

return(k);
}



int tp::find_col_min0(int &row)
{
int i,j,k,zf,rowt,nz;

	for(k=nz=-1,j=0;j<dn;j++)
		if(req[j]==0) continue; else
		{
			for(zf=i=0;i<fn;i++)
				if(cap[i]==0) continue; else
				if(tab[i][j]==0) ++zf,rowt=i;

			if(k==-1) k=j,nz=zf,row=rowt; else
			if(zf<nz) k=j,nz=zf,row=rowt; else continue;
		}

return(k);
}



//----------------------------------------------------------------//

void tp::noasst_asst(void)
{
int *cap1=new int[fn],*req1=new int[dn],i,j,k,f,f1,f2,cnt,low;

	for(i=0;i<fn;i++) cap1[i]=req1[i]=-1;

	for(f=i=0;i<fn;i++)
		if(cap[i]!=0) f=1,cap1[i]=1;

	while(f)
	{
		for(f1=i=0;i<fn;i++)
			if(cap1[i]==-1) continue; else
			  for(j=0;j<dn;j++)
				 if(req1[j]==1) continue; else
				 if(tab[i][j]==0) f1=1,req1[j]=1;

		for(f2=j=0;j<dn;j++)
			if(req1[j]==-1) continue; else
			  for(i=0;i<fn;i++)
				 if(cap1[i]==1) continue; else
				 if(alloc[i][j]==1) f2=1,cap1[i]=1;

		if(f1==1||f2==1) f=1; else f=0;
	}

	for(cnt=i=0;i<fn;i++)
		if(cap1[i]*=-1,cap1[i]==1) ++cnt;

	for(j=0;j<dn;j++)
		if(req1[j]==1) ++cnt;

	if(fn==cnt) return;


	for(low=f=i=0;i<fn;i++)
	   if(cap1[i]==1) continue; else
		 for(j=0;j<dn;j++)
			if(req1[j]==1) continue; else
			if(f==0) f=1,low=tab[i][j]; else
			if(tab[i][j]<low) low=tab[i][j]; else continue;

	for(i=0;i<fn;i++)
		for(cap[i]=req[i]=1,j=0;j<dn;j++)
		  if(alloc[i][j]=-1,cap1[i]==1&&req1[j]==1) tab[i][j]+=low;
		  else
			if(cap1[i]==-1&&req1[j]==-1) tab[i][j]-=low;
			else
				continue;

return;
}



