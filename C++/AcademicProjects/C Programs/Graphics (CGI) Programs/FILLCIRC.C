

#include "\tc\bin\cgi\circline.C"


void main()
{
int gd=DETECT,gm,x,y,rad;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter centreleft,radius:");
	scanf("%d%d%d",&x,&y,&rad);

        midpoint_circle(x,y,rad,1);
	    getch();
        fillboundary(x,y,3,1);

        getch();

		closegraph();
}