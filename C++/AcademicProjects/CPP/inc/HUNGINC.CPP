
#include<string.h>
#include<iostream.h>
#include<fstream.h>
#include<conio.h>
#include<math.h>

//-----------sub classes---------------//

class factory
{
	protected:
        	int fn;
            char **fname;
            int  *cap;
    public:
       void factcon(int);
       void factdel(void);
            factory(int=0);
           ~factory();
};


factory::factory(int n)
{	this->factcon(n);  }

factory::~factory()
{	this->factdel();   }


void factory::factcon(int n)
{
	fn=n;
    if(fn<=0)
    {
        fn=0,fname=0,cap=0;
        return;
    }
	fname=new char*[fn],cap=new int[fn];
    for(int i=0;i<fn;i++) cap[i]=1;
    return;
}

void factory::factdel(void)
{
    if(fname&&cap)
    {
	   	for(int i=0;i<fn;i++)
		 	if(fname[i]!=0) delete []fname[i];
    	delete []fname,delete []cap;
    }
    return;
}

class destination
{
	protected:
            int dn;
            char **dname;
            int *req;
    public:
       void destdel(void);
       void destcon(int);
    		destination(int=0);
           ~destination();
};


destination::destination(int n)
{	  this->destcon(n);	      }

destination::~destination()
{	  this->destdel();    }


void destination::destcon(int n)
{
    dn=n;
    if(dn<=0)
    {
		dn=0,dname=0,req=0;
        return;
    }
	dname=new char*[dn],req=new int[dn];
   	for(int i=0;i<dn;i++) req[i]=1;
    return;
}

void destination::destdel(void)
{
    if(dname&&req)
    {
		for(int i=0;i<dn;i++)
		 	if(dname[i]!=0) delete []dname[i];
    	delete []dname,delete []req;
    }
    return;
}


//-------------Class(Main)----------------------//

class tp:protected factory,protected destination
{
	protected:
    		int **tab,**alloc;
    public:
             tp(tp&);
    		 tp(int=0,int=0);
            ~tp();
             tp& operator=(tp&);
    protected:                         //-----For job allocation prblm
              void  tpcon(void);
              void  tpdel(void);
			  int   findcase(void);
			  int   findcase23(void);
			  void  unmrk_mrk(void);
              void  make_asst(void);
	          int   find_row_min0(int&);
			  int   find_col_min0(int&);
              void  noasst_asst(void);
    public:                        //-------for job allocation prblm
              friend int      freadtable(char*,tp&);
              friend istream &operator>>(istream&,tp&);
              friend ostream &operator<<(ostream&,tp&);
			  friend int   hungarian_asst(tp&);
};



tp::tp(int n1,int n2):factory(n1),destination(n2)
{			    this->tpcon();					}

tp::tp(tp &x):factory(0),destination(0)
{		   alloc=tab=0,*this=x;			  }

tp::~tp()
{	this->tpdel();	}


void tp::tpcon(void)
{
     if(fn<=0||dn<=0)
	 {
	 	tab=alloc=0;
	 	return;
     }
     tab=new int*[fn],alloc=new int*[fn];
     for(int i=0;i<fn;i++) tab[i]=new int[dn],alloc[i]=new int[dn];
     int j;
     for(i=0;i<fn;i++)
     	for(j=0;j<dn;j++) alloc[i][j]=-1;

	 return;
}


void tp::tpdel(void)
{
    if(tab&&alloc)
	{
		for(int i=0;i<fn;i++)
        {
        	if(tab[i]!=0)   delete []tab[i];
        	if(alloc[i]!=0) delete []alloc[i];
        }
        delete []tab,delete []alloc;
    }
    return;
}


tp &tp::operator=(tp &x)
{
	this->destdel(),this->factdel(),this->tpdel();
    this->destcon(x.dn),this->factcon(x.fn),this->tpcon();

    for(int i=0;i<fn;i++) fname[i]=new char[strlen(x.fname[i])+1],
		                  strcpy(fname[i],x.fname[i]),cap[i]=x.cap[i];

    for(int j=0;j<dn;j++) dname[j]=new char[strlen(x.dname[j])+1],
						  strcpy(dname[j],x.dname[j]),req[j]=x.req[j];
    for(i=0;i<fn;i++)
    	for(j=0;j<dn;j++)
        	alloc[i][j]=x.alloc[i][j],tab[i][j]=x.tab[i][j];

    return *this;
}


int freadtable(char *fname,tp &x)
{
ifstream  p(fname);

    if(p==0) return 0;

    char tmp[50];
    int i,j,len;

	for(i=0;i<x.fn;i++)
			p>>tmp,len=strlen(tmp),x.fname[i]=new char[len+1],
			strcpy(x.fname[i],tmp);

	for(j=0;j<x.dn;j++)
			p>>tmp,len=strlen(tmp),x.dname[j]=new char[len+1],
			strcpy(x.dname[j],tmp);

	for(i=0;i<x.fn;i++)
		for(j=0;j<x.dn;j++)  p>>x.tab[i][j],cout<<"";

p.close();
return 1;
}


istream &operator>>(istream &in,tp &x)
{

    char tmp[50];
    int i,j,len;

	cout<<"\n\nEnter name of acceptors\n";
	for(i=0;i<x.fn;i++)
			in>>tmp,len=strlen(tmp),x.fname[i]=new char[len+1],
			strcpy(x.fname[i],tmp);

	cout<<"\n\nEnter name of jobs\n";
	for(j=0;j<x.dn;j++)
			in>>tmp,len=strlen(tmp),x.dname[j]=new char[len+1],
			strcpy(x.dname[j],tmp);

	for(i=0;i<x.fn;i++)
			for(j=0;j<x.dn;j++)
        cout<<"\nCost of allotment of job "<<x.dname[j]
			<<" to acceptor "<<x.fname[i]<<":",
		in>>x.tab[i][j];

return in;
}


ostream &operator<<(ostream &out,tp &t)
{
int i,j,cost;

	clrscr();
	out<<"\n\nNumber of acceptors:"<<t.fn<<"\nNumber of jobs:"<<t.dn;

	for(cost=j=0;j<t.dn;j++)
	{
		out<<"\n\nSheduling details for job "<<t.dname[j];
		for(i=0;i<t.fn;i++)
			if(t.alloc[i][j]==1)
			{
			   cost+=t.alloc[i][j]*t.tab[i][j];
			   out<<"\nsheduled to acceptor "<<t.fname[i];
			   break;
			}
	}
	out<<"\n\nTotal cost of sheduling="<<cost;

return out;
}


