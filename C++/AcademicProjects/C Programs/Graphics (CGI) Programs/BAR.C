
#include<graphics.h>

void main()
{
int gd=DETECT,gm,n,i,x=50,y=430,div=7;
char t[30];
float max,v[50],yinc,j;
initgraph(&gd,&gm,"e:\\tc\\bgi");

printf("\nEnter number of data:"),scanf("%d",&n);
printf("\n\nEnter DATUM\n");
for(i=0;i<n;i++)
		scanf("%f",&v[i]),
        max=(i==0?v[0]:max<v[i]?v[i]:max);


cleardevice(),line(50,50,50,430),line(50,430,600,430);

for(yinc=max/(float)div,j=0;j<=max;j+=yinc)
        sprintf(t,"%2.2f",j),outtextxy(10,430.0-(j/max)*380.0,t);

for(i=0;i<n;i++)
{
x=x+(550.0/n),y=430.0-(v[i]/max)*380.0;
setfillstyle(SLASH_FILL,9);
sprintf(t,"%d",i+1),outtextxy(x,450,t);
bar3d(x-(550.0/n),430,x-550.0/(n*2),y,7,6);
sprintf(t,"%2.2f",v[i]);
outtextxy(x-(550.0/n)+5,y-20,t);
}


getch(),closegraph();
}