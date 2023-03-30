

#include "\tc\bin\cgi\circline.C"



void blink_circle(x1,y1,r1,c1,x2,y2,r2,c2,x3,y3,r3,c3)
int x1,y1,r1,c1,x2,y2,r2,c2,x3,y3,r3,c3;
{
int i,j,max=(r1>r2?r1>r3?r1:r3:r2>r3?r2:r3);

    for(i=1;i<=1000;i++)
    	for(j=0;j<=max;j++)
    		midpoint_circle(x1,y1,j,c1),midpoint_circle(x1,y1,j,0),
            midpoint_circle(x2,y2,j,c2),midpoint_circle(x2,y2,j,0),
	         midpoint_circle(x3,y3,j,c3),midpoint_circle(x3,y3,j,0);
return;
}


void main()
{
int gd=DETECT,gm,xc,yc,r,i,j;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter xcntre,ycntre & radius:");
	scanf("%d%d%d",&xc,&yc,&r);


	midpoint_circle(xc,yc,r,1);

    dda_line(xc,yc,xc,yc+r/2-r/4,1);
    dda_line(xc-2*r,yc,xc,yc-2*r,1);
    dda_line(xc+2*r,yc,xc,yc-2*r,1);
    dda_line(xc-2*r,yc,xc-r,yc,1);
    dda_line(xc+2*r,yc,xc+r,yc,1);

    blink_circle(xc,yc+r/2,r/4,1,xc+r/2,yc-r/4,r/8,5,xc-r/2,yc-r/4,r/8,5);

    midpoint_circle(xc+r/2,yc-r/4,r/4,1);
    midpoint_circle(xc-r/2,yc-r/4,r/4,1);
    midpoint_circle(xc,yc+r/2,r/4,1);
    midpoint_circle(xc+r/2,yc-r/4,r/8,5);
    midpoint_circle(xc-r/2,yc-r/4,r/8,5);

	getch();

	closegraph();
}