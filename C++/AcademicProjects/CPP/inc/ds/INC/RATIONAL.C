


typedef struct
{	int nr;
	int dr;
}ratio;



void rational(ratio *p)
{
int a=p->nr,b=p->dr,t;

	if(a<0) a*=-1;
	if(b<0) b*=-1;
	if(a<b) t=a,a=b,b=t;

	while(b!=0) t=a%b,a=b,b=t;

	p->nr/=a;
	p->dr/=a;

	if((p->nr<0&&p->dr<0)||(p->nr>0&&p->dr<0)) p->nr*=-1,p->dr*=-1;
return;
}




int equal(ratio *p,ratio *q)
{
ratio r=*p,s=*q;

	  rational(&r),rational(&s);
	  if(r.nr==s.nr&&r.dr==s.dr) return(1); else return(0);
}




ratio addrationals(ratio *p,ratio *q)
{
ratio r=*p,s=*q,t;

	  rational(&r),rational(&s);

	  t.nr=r.nr*s.dr+s.nr*r.dr;
	  t.dr=r.dr*s.dr;

	  rational(&t);

return(t);
}





ratio mulrationals(ratio *p,ratio *q)
{
ratio r=*p,s=*q,t;

	  rational(&r),rational(&s);

	  t.nr=r.nr*s.nr;
	  t.dr=r.dr*s.dr;

	  rational(&t);
return(t);
}

