
#include "\tc\bin\cgi\circline.C"


void main()
{
int gd=DETECT,gm,x1,x2,y1,y2;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter x1,y1,x2,y2:");
	scanf("%d%d%d%d",&x1,&y1,&x2,&y2);


	dda_line(x1,y1,x2,y2,1);
	getch();

	closegraph();
}