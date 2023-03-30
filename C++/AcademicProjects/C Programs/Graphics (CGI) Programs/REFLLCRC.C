

#include "\tc\bin\cgi\circline.C"


void main()
{
int gd=DETECT,gm,x,y,rad;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter centreleft,radius:");
	scanf("%d%d%d",&x,&y,&rad);

        midpoint_circle(x,y,rad,BLUE);
	    getch();
        fillboundary(x,y,RED,BLUE);
        getch();
        fillflood(x,y,YELLOW,getpixel(x,y));
        getch();

		closegraph();
}