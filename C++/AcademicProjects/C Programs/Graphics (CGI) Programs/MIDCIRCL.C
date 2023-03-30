
#include "\tc\bin\cgi\circline.C"


void main()
{
int gd=DETECT,gm,x,y,r;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter xcntre,ycntre & radius:");
	scanf("%d%d%d",&x,&y,&r);


	midpoint_circle(x,y,r,5);
	getch();

	closegraph();
}