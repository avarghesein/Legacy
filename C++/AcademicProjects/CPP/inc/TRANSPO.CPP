

#include"\tc\bin\cpp\inc\hunginc.cpp"


inline int MIN(int x,int y)
{
    if(x<y) return x; else return y;
}


class transport:public tp
{
 public:
             transport(transport&);
             transport(int=0,int=0);
            ~transport();
 	         transport &operator=(transport&);
 public:
              friend int      freadtable(char*,transport&);
              friend istream &operator>>(istream&,transport&);
              friend ostream &operator<<(ostream&,transport&);
			  friend void     vam_method(transport&);
};

transport::transport(transport &x):tp(*((tp*)(&x))) {}

transport::transport(int fs,int ds):tp(fs,ds) {}

transport::~transport() {}

transport &transport::operator=(transport &x)
{
    *((tp*)(this))=*((tp*)(&x));
    return *this;
}


istream &operator>>(istream &in,transport &x)
{

    char tmp[50];
    int i,j,len;

	cout<<"\n\nEnter name of factories & thier capacities\n";
	for(i=0;i<x.fn;i++)
			in>>tmp,len=strlen(tmp),x.fname[i]=new char[len+1],
			strcpy(x.fname[i],tmp),in>>x.cap[i];

	cout<<"\n\nEnter name of destinations & thier requirements\n";
	for(j=0;j<x.dn;j++)
			in>>tmp,len=strlen(tmp),x.dname[j]=new char[len+1],
			strcpy(x.dname[j],tmp),in>>x.req[j];

	for(i=0;i<x.fn;i++)
			for(j=0;j<x.dn;j++)
        cout<<"\nTranspotation cost (charge/unit) to "<<x.dname[j]
			<<" from  factory"<<x.fname[i]<<":",
		in>>x.tab[i][j];

return in;
}

int freadtable(char *fname,transport &x)
{
ifstream  p(fname);

    if(p==0) return 0;

    char tmp[50];
    int i,j,len;

	for(i=0;i<x.fn;i++)
			p>>tmp,len=strlen(tmp),x.fname[i]=new char[len+1],
			strcpy(x.fname[i],tmp),p>>x.cap[i];

	for(j=0;j<x.dn;j++)
			p>>tmp,len=strlen(tmp),x.dname[j]=new char[len+1],
			strcpy(x.dname[j],tmp),p>>x.req[j];

	for(i=0;i<x.fn;i++)
		for(j=0;j<x.dn;j++)  p>>x.tab[i][j],cout<<"";

p.close();
return 1;
}



ostream &operator<<(ostream &out,transport &t)
{
int i,j,cost;

	clrscr();
	out<<"\n\nNumber of sources:"<<t.fn<<"\nNumber of destinations:"<<t.dn;

	for(cost=j=0;j<t.dn;j++)
	{
		out<<"\n\nAllocation details for Destination "<<t.dname[j];
		for(i=0;i<t.fn;i++)
			if(t.alloc[i][j]>0)
			{
			   cost+=t.alloc[i][j]*t.tab[i][j];
			   out<<"\n"<<t.alloc[i][j]<<" items are allocated from source "
				  <<t.fname[i];
			}
	}
	out<<"\n\nTotal cost of sheduling="<<cost;

return out;
}



void vam_method(transport &t)
{
int i,j,t1,t2,row,col,num,max,flag1,flag2,rflg;


   for(rflg=flag1=i=0;i<t.fn;i++)
	  if(t.cap[i]<=0) continue;
	  else
	  {
		  for(flag2=j=0;j<t.dn;j++)
			 if(t.req[j]<=0) continue;
			 else
				 if(flag2==0) t2=t.tab[i][j],t1=0,flag2++;
				 else
					 if(flag2==1) t1=t.tab[i][j],flag2++;
					 else
						  if((num=t.tab[i][j])<t1) t1=num;
						  else
							   if(num<t2) t2=num;
							   else continue;

		  if(flag2==0) continue;
		  num=abs(t1-t2);
		  if(flag1==0) rflg=1,flag1++,row=i,max=num;
		  else if(num>max) max=num,row=i;
	  }

   if(flag1==0) return;


   for(flag1=j=0;j<t.dn;j++)
	  if(t.req[j]<=0) continue;
	  else
	  {
		  for(flag2=i=0;i<t.fn;i++)
			 if(t.cap[i]<=0) continue;
			 else
				 if(flag2==0) t2=t.tab[i][j],t1=0,flag2++;
				 else
					 if(flag2==1) t1=t.tab[i][j],flag2++;
					 else
						  if((num=t.tab[i][j])<t1) t1=num;
						  else
							   if(num<t2) t2=num;
							   else continue;

		  if(flag2==0) continue;
		  num=abs(t1-t2);
		  if(flag1==0) flag1++;
		  if(num>max) rflg=0,max=num,col=j;
	  }

   if(flag1==0) return;

   if(rflg==1)
	  {	for(col=-1,j=0;j<t.dn;j++)
			if(t.req[j]>0)
				if(col==-1) col=j; else
				if(t.tab[row][j]<t.tab[row][col]) col=j;
	  }
   else
	  {	for(row=-1,i=0;i<t.fn;i++)
			if(t.cap[i]>0)
				if(row==-1) row=i; else
				if(t.tab[i][col]<t.tab[row][col]) row=i;
	  }

   num=MIN(t.req[col],t.cap[row]);

   t.alloc[row][col]=num;
   t.req[col]-=num;
   t.cap[row]-=num;

   vam_method(t);
   return;
}