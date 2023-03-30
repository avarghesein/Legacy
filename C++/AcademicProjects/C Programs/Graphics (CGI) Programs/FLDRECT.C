

#include "\tc\bin\cgi\circline.C"


void main()
{
int gd=DETECT,gm,x1,x2,y1,y2;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter left,top,right,bottom:");
	scanf("%d%d%d%d",&x1,&y1,&x2,&y2);


		dda_line(x1,y1,x2,y1,5);
        dda_line(x2,y1,x2,y2,5);
        dda_line(x2,y2,x1,y2,5);
        dda_line(x1,y2,x1,y1,5);

	    getch();
        fillflood(x1+2,y1-2,3,getpixel(x1+2,y1-2));

        getch();

		closegraph();
}