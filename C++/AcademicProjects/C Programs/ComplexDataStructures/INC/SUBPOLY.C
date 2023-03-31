

#include"\tc\bin\viju's\sourse\mat.c"

#define S 50




typedef struct
{
	int   po[S];      //----------Powers of  X
	float co[S];     //-----------Coefficient of powers
	int   n;
}poly;



//---------------------------------------------------------------------//

int gcd(float x[],int n)
{
int i,a,b,t;


	 if(n==-1)
	 {	printf("Array is empty:Returning NULL");
		return(0);
	 }

	 a=(int)x[0];
	 for(a=(a>=0?a:-a),i=1;i<=n;i++)
	 {	b=(int)x[i];

		if(b<0) b*=-1;
		if(a<b) t=a,a=b,b=t;

		while(b!=0) t=a%b,a=b,b=t;

		if(a==1) break;
	 }

return(a);
}



//------------------------------------------------------------------------//


int allintegers(poly *s)
{
int i;
	 for(i=0;i<=s->n;i++)
		if( (s->co[i]-(int)(s->co[i])) !=00.00) return(0);

return(1);
}





void makeco1(poly *s)
{
int i;
float x;


if(s->n!=-1)
	if(allintegers(s))
		for(x=(float)(s->co[0]>=0?gcd(s->co,s->n):-gcd(s->co,s->n)),i=0;
			i<=s->n;s->co[i++]/=x);
	else
		for(x=s->co[0],i=0;i<=s->n;s->co[i++]/=x);


return;
}





void sortpoly(poly *s)
{
int i,j,k;
float t;
for(i=0;i<s->n;i++)
	for(j=i+1;j<=s->n;j++)
		if(s->po[i]<s->po[j])
		   k=s->po[i],s->po[i]=s->po[j],s->po[j]=k,
		   t=s->co[i],s->co[i]=s->co[j],s->co[j]=t;
return;
}






void reset0s_sortpoly(poly *p)
{
int i,j;

	for(i=0;i<=p->n;i++)
	   if(abso(p->co[i])<=0.00001)
	   {	for(j=i;j<p->n;j++)
				p->po[j]=p->po[j+1],p->co[j]=p->co[j+1];
			--p->n,--i;
	   }
	sortpoly(p);
return;
}






void reducepoly(poly *s)
{
poly t;
int i=0,j=-1,k;

sortpoly(s);

while(i<=s->n)
{  t.po[++j]=s->po[i],t.co[j]=s->co[i];
   k=i+1;
   while(k<=s->n&&s->po[i]==s->po[k])
		 t.co[j]+=s->co[k],k++;
   i=k;
}
t.n=j;

*s=t;
return;
}


//-------------------------------------------------------------------//


