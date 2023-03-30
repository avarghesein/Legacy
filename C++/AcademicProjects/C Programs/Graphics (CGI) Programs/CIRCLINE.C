
#include"e:\tc\bin\cgi\incall.c"

void dda_line(int x1,int y1,int x2,int y2,int clr)
{
int x,y,dx,dy,xinc,yinc,n,i;

	dx=x2-x1,dy=y2-y1;
	n=abs(dx)>abs(dy)?abs(dx):abs(dy);
	xinc=dx/n,yinc=dy/n;
	for(x=x1,y=y1,i=1;i<=n;x+=xinc,y+=yinc,i++)  putpixel(x,y,clr);

return;
}


void bresen_line(int x1,int y1,int x2,int y2,int clr)
{
int x,y,dx,dy,xend;
float p;

	dx=abs(x2-x1),dy=abs(y2-y1);
    if(dy/dx>=1)
    {
    	printf("\nError,slope>=1 can't draw line\n");
        return;
    }

    if(x2<x1) x=x2,y=y2,xend=x1; else x=x1,y=y1,xend=x2;

    putpixel(x,y,clr);
    p=2*dy-dx;
    while(x<xend)
    {
    	++x;
        if(p<0) p+=2*dy; else ++y,p+=2*(dy-dx);
        putpixel(x,y,clr);
    }

return;
}





void plot8segs(int xc,int yc,int x,int y,int clr)
{
	putpixel(xc+x,yc+y,clr);
	putpixel(xc-x,yc+y,clr);
	putpixel(xc+x,yc-y,clr);
	putpixel(xc-x,yc-y,clr);
	putpixel(xc+y,yc+x,clr);
	putpixel(xc-y,yc+x,clr);
	putpixel(xc+y,yc-x,clr);
	putpixel(xc-y,yc-x,clr);
    return;
}


void midpoint_circle(int xcntre,int ycntre,int radi,int clr)
{
int x,y;
float p;

	x=0,y=radi;
    plot8segs(xcntre,ycntre,x,y,clr);
    p=1-radi;
    while(x<y)
    {
    	++x;
        if(p<0) y=y; else --y;
        if(p<0) p+=2*x+1; else p+=2*(x-y)+1;
        plot8segs(xcntre,ycntre,x,y,clr);
    }

return;
}


void fillboundary(int x,int y,int fillclr,int bndryclr)
{
int cur=getpixel(x,y);

	if(cur!=bndryclr&&cur!=fillclr)
    	putpixel(x,y,fillclr),
        fillboundary(x+1,y,fillclr,bndryclr),
        fillboundary(x-1,y,fillclr,bndryclr),
        fillboundary(x,y+1,fillclr,bndryclr),
        fillboundary(x,y-1,fillclr,bndryclr);

return;
}


void fillflood(int x,int y,int fillclr,int old)
{

	if(getpixel(x,y)==old)
    	putpixel(x,y,fillclr),
        fillflood(x+1,y,fillclr,old),
        fillflood(x-1,y,fillclr,old),
        fillflood(x,y+1,fillclr,old),
        fillflood(x,y-1,fillclr,old);

return;
}

