




#include"\tc\bin\ds\inc\subpoly.c"

//-------------------------------------------------------------------//


poly addpoly(poly *p,poly *q)
{
poly t;
int i,j;

reducepoly(p),reducepoly(q);

t=*p;
for(j=0,i=t.n+1;j<=q->n;j++,i++)
	t.po[i]=q->po[j],t.co[i]=q->co[j];
t.n+=(q->n)+1;

reducepoly(&t);

return(t);
}





poly subpoly(poly *p,poly *q)
{
poly t;
int i,j;

reducepoly(p),reducepoly(q);

t=*p;
for(j=0,i=t.n+1;j<=q->n;j++,i++)
	t.po[i]=q->po[j],t.co[i]=-(q->co[j]);
t.n+=q->n+1;

reducepoly(&t);

return(t);
}






poly mulpoly(poly *p,poly *q)
{
poly t;
int i,j,k=-1;

reducepoly(p),reducepoly(q);

for(i=0;i<=p->n;i++)
	for(j=0;j<=q->n;j++)
		t.po[++k]=p->po[i]+q->po[j],t.co[k]=p->co[i]*q->co[j];

t.n=k;
reducepoly(&t);

return(t);
}


//--------Dividing B/A ie, *p/*q, B must be greater-----------//
//--------newp=Quotient(B/A) & *rem=remainder(B/A)------------//

poly divpoly_rem(poly *p,poly *q,poly *rem)
{

int  k=-1;
poly a=*q,b=*p,t,newp;
t.n=newp.n=-1;


reset0s_sortpoly(&a);
reset0s_sortpoly(&b);

if(a.n==-1||b.n==-1||a.po[0]>b.po[0])
  {		printf("\nError,cannot divide polynomials");
		printf("\nReturning NULL poly to quotient & reminder");
		getch();
		*rem=t;
		return(newp);
  }
else
  {    	while(b.n!=-1&&a.po[0]<=b.po[0])
		{
			++k;
			newp.po[k]=t.po[0]=(b.po[0]-a.po[0]);
			newp.co[k]=t.co[0]=(b.co[0]/a.co[0]);
			t.n=0;

			t=mulpoly(&a,&t);
			b=subpoly(&b,&t);

			reset0s_sortpoly(&b);
		}
		*rem=b;
		newp.n=k;
		return(newp);
  }

}



//-----------Correct only if power of x is >=1------------------//

poly gcdpoly(poly *p,poly *q)
{
poly a=*q,b=*p,remainder;

remainder.n=-1;

	if(a.n==-1||b.n==-1)
		{	printf("\nError in polynomials,Returning NULL gcd\n");
			getch();
			return(remainder);
		}


	reset0s_sortpoly(&a),reset0s_sortpoly(&b);

	if(a.po[0]>b.po[0]) remainder=a,a=b,b=remainder;

	while(a.n!=-1)
		b=divpoly_rem(&b,&a,&remainder),
		b=a,a=remainder,
		reset0s_sortpoly(&a);


   makeco1(&b);

return(b);
}

//-----------------------------------------------------------------//