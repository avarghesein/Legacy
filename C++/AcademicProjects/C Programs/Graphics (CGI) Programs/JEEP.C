
#include<graphics.h>
#include<conio.h>
#include<dos.h>

void plot2quads(int xc,int yc,int x,int y,int clr)
{
	putpixel(xc+x,yc-y,clr);
	putpixel(xc-x,yc-y,clr);
	putpixel(xc+y,yc-x,clr);
	putpixel(xc-y,yc-x,clr);
    return;
}


void circles(int xcntre,int ycntre,int radi,int clr)
{
int x,y;
float p;

	x=0,y=radi;
    plot2quads(xcntre,ycntre,x,y,clr);
    p=1-radi;
    while(x<y)
    {
    	if(++x,p<0) p+=2*x+1; else --y,p+=2*(x-y)+1;
        plot2quads(xcntre,ycntre,x,y,clr);
    }

return;
}

void bridge(int x,int y)
{
    int i;

	line(x,y-70,x+550,y-70);
    line(x,y+80,x+550,y+80);
    rectangle(x+135,y-90,x+420,y-70);
    rectangle(x+135,y+80,x+420,y+60);


    for(i=0;i<=2;i++)
     circles(x+135+47+i*95,y-90,47,15),
     circles(x+135+47+i*95,y+60,47,15),
     line(x+135+47+i*95,y-90,x+135+47+i*95,y-90-47),
     line(x+135+47+i*95,y+60,x+135+47+i*95,y+60-47);

    for(i=0;i<=5;i++)
     line(x+135+i*47+23,y-90,x+135+i*47+23,y-90-40),
     line(x+135+i*47+23,y+60,x+135+i*47+23,y+60-40);

	return;
}


void main()
{
int gd=DETECT,gm,x=10,y=300,x1,y1;
initgraph(&gd,&gm,"e:\\tc\\bgi\\");


	x1=x,y1=y;
    while(x1<=x+500)
    {
        delay(50);
    	cleardevice();
        bridge(x,y);
        line(x1,y1,x1+50,y1);
        line(x1,y1,x1,y1+50);
        line(x1,y1+50,x1+125,y1+50);
        line(x1+125,y1+50,x1+125,y1+25);
        line(x1+125,y1+25,x1+75,y1+25);
        line(x1+75,y1+25,x1+50,y1);
        circle(x1+20,y1+50,10);
        circle(x1+100,y1+50,10);
        x1+=5;
    }

   	closegraph();
}