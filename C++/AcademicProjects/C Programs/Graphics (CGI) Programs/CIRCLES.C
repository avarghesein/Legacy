
#include "\tc\bin\cgi\circline.C"




void main()
{
int gd=DETECT,gm,x1,y1,r,i,stps;
initgraph(&gd,&gm,PATH);


	printf("\n\nEnter xcentre,ycentre & radius:");
	scanf("%d%d%d",&x1,&y1,&r);


    for(stps=0;stps<=100;stps++)
    	for(i=1;i<=r;i++)
    		midpoint_circle(x1,y1,i,1),
        	midpoint_circle(x1,y1,i,0);

	getch();

	closegraph();
}