
#include"\tc\bin\cgi\circline.c"

void main()
{
int gd=DETECT,gm,y;
initgraph(&gd,&gm,"\\tc\\bgi");

for(y=480;y-75>=75;y-=4)
	cleardevice(),setcolor(YELLOW),
	line(320,480,320,50),rectangle(320,y-75,450,y),
	line(320,y-50,450,y-50),line(320,y-25,450,y-25),
	fillflood(325,y-30,GREEN,BLACK);

getch(),closegraph();
}
