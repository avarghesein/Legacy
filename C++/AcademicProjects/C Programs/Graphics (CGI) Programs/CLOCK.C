
#include<string.h>
#include<graphics.h>
#include<dos.h>
#include<math.h>

#define SEC .10
#define SS   15
#define MIN .50
#define MS   35
#define HR   .40
#define HS   45

#define RAD  (3.141519/180.0)
#define FONT (8)
#define INC  (22)


char STRG[100]="     ";

float angle_prop(float timeseg,int prop)
{
	float x=timeseg*360.0/(float)prop-90.0;
    return ( x<0 ? x+360.0 : x );
}

void convert_to_roman(int tseg,char *tchar)
{
int i;

for(tchar[0]='\0',i=1;i<=tseg/10;i++) strcat(tchar,"X");

switch(tseg%=10,tseg)
  {
	case 0:case 1:case 2:case 3:
    	for(i=1;i<=tseg;i++) strcat(tchar,"I");
        return;
    case 4:
    	strcpy(tchar,"IV");
        return;
    case 5:case 6:case 7:case 8:
    	for(strcpy(tchar,"V"),i=1;i<=tseg%5;i++) strcat(tchar,"I");
        return;
	default:
    	strcpy(tchar,"IX");
 }
return;
}


void writenewtime(int pr,int p,int x1,int y1,int clr,int coln)
{
char o[15]="\0";
if(pr>=0) sprintf(o,"%2.2d",pr),setcolor(BLACK),outtextxy(x1,y1,o);
if(sprintf(o,"%2.2d",p),coln) strcat(o,":");
setcolor(clr),outtextxy(x1,y1,o);
return;
}

void timedisplay(int flg,struct time *pr,struct time *p,int x1,int y1,int  clr)
{
setcolor(clr),rectangle(x1-45,y1-5,x1+45,y1+10);
x1-=40;
if(!flg)
{
	writenewtime(-1,p->ti_hour,x1,y1,clr,1),x1+=INC,
	writenewtime(-1,p-> ti_min,x1,y1,clr,1),x1+=INC,
	writenewtime(-1,p-> ti_sec,x1,y1,clr,1),x1+=INC,
	writenewtime(-1,p->ti_hund,x1,y1,clr,0);
    return;
}
if(flg==2||pr->ti_hour!=p->ti_hour)
	writenewtime(pr->ti_hour,p->ti_hour,x1,y1,clr,1);

if(x1+=INC,flg==2||pr->ti_min!=p->ti_min)
	writenewtime(pr->ti_min,p->ti_min,x1,y1,clr,1);

if(x1+=INC,flg==2||pr->ti_sec!=p->ti_sec)
   writenewtime(pr->ti_sec,p->ti_sec,x1,y1,clr,1);

if(x1+=INC,flg==2||pr->ti_hund!=p->ti_hund)
   writenewtime(pr->ti_hund,p->ti_hund,x1,y1,clr,0);

return;
}

void datedisplay(struct date *d,int x1,int y1,int clr)
{
char o[70];
sprintf(o,"CURRENT DATE:%2.2d-%2.2d-%2.2d",d->da_day,d->da_mon,d->da_year);
setcolor(clr),outtextxy(x1-90,y1+30,o);
return;
}

void wishing(int xc,int yc,int r,int clr)
{
setcolor(clr),outtextxy(xc-FONT*strlen("<DIGITAL>")/2.0,yc-r/2,"<DIGITAL>"),
outtextxy(xc-FONT*strlen("QUARTZ")/2.0,yc+r/2,"QUARTZ");
return;
}


int timebwangles(float rang1,float rang2,float tseg,int prop)
{
float ang;
if(rang1>rang2) ang=rang1,rang1=rang2,rang2=ang;
if(ang=angle_prop(tseg,prop),rang1<=ang&&ang<=rang2) return 1;
else return 0;
}

void triangle(int x,int y,float r,float t,int prop,float sze,float shape,float dpth,int clr)
{
float x3,x4,x5;

if(t<0) return;

r/=sze,setcolor(clr);
x5=angle_prop(t,prop),x3=angle_prop(t-dpth,prop),x4=angle_prop(t+dpth,prop);

line(x+(r-shape)*cos(x3*RAD),y+(r-shape)*sin(x3*RAD),x+r*cos(x5*RAD),y+r*sin(x5*RAD));
line(x+(r-shape)*cos(x4*RAD),y+(r-shape)*sin(x4*RAD),x+r*cos(x5*RAD),y+r*sin(x5*RAD));
line(x,y,x+(r-shape)*cos(x4*RAD),y+(r-shape)*sin(x4*RAD));
line(x,y,x+(r-shape)*cos(x3*RAD),y+(r-shape)*sin(x3*RAD));

if(clr)
	setcolor(11),circle(x,y,4.0);
else
	setcolor(0),circle(x,y,4.0);

return;
}

void clock_hund(int xc,int yc,int r,struct time *t,int clr,int numclr)
{
char tmp[8];
int i,j;
float x;

    for(j=1;j<=100;j++)
       if(i=j%100,i%10==0)
       setcolor(numclr),x=angle_prop(i,100),sprintf(tmp,"%2.2d",i),
	   outtextxy(xc+r*cos(x*RAD)-6*strlen(tmp)/2.0,yc+r*sin(x*RAD),tmp);

    triangle(xc,yc,r,t->ti_hund,100,1.0,5.0,0,clr);
return;
}


void sec_hr_sound(tp,t)
struct time *tp,*t;
{
static int flg=0,j1;

if((tp->ti_hour+1)%24==t->ti_hour%24||flg)
       {
       		if(!flg) j1=1,flg=1;
            if(t->ti_sec==tp->ti_sec)
            {
				sound(4444),delay(4),nosound();
            	if(j1==t->ti_hour*8) flg=0; else ++j1;
            }
       }
       else
       if(t->ti_sec%60==(tp->ti_sec+1)%60) sound(2333),delay(4),nosound();
return;
}

display_ampm(tp,t,xc,yc,flg,clr)
struct time *tp,*t;
int flg,clr,xc,yc;
{
if((tp->ti_hour+1)%24==t->ti_hour%24)
       		if(t->ti_hour%24==0)
            	setcolor(BLACK),outtextxy(xc-5,yc-15,"PM"),
                setcolor(clr),outtextxy(xc-5,yc-15,"AM");
            else
            if(t->ti_hour%24==12)
            	setcolor(BLACK),outtextxy(xc-5,yc-15,"AM"),
                setcolor(clr),outtextxy(xc-5,yc-15,"PM");
            else ;

if(!flg||timebwangles(angle_prop(9.2,12),angle_prop(9.6,12),t->ti_sec,60)||
   timebwangles(angle_prop(9.2,12),angle_prop(9.6,12),t->ti_min,60)||
   timebwangles(angle_prop(9.2,12),angle_prop(9.6,12),t->ti_hour,12))
   if(setcolor(clr),t->ti_hour%24<12)
   outtextxy(xc-5,yc-15,"AM");
   else
   outtextxy(xc-5,yc-15,"PM");

return;
}

int processchar(char c)
{

    if(c=='7') return 4;
	if(c=='8')
	{
		c=getch();
	return 0;
    }
    if(c==75)  return -1; else if(c==77) return 1; else
    if(c==80)  return -2; else if(c==72) return 2; else
    if(c=='5') return -3; else if(c=='6') return 3; else
	if(c=='1') return -5; else if(c=='2') return 5; else
	if(c=='3') return -6; else if(c=='4') return 6; else return 0;
}


void activity(xc,yc,r,ch,tpx,tpy,dpx,dpy,hpx,hpy)
int *xc,*yc,*r,ch;
int *tpx,*tpy,*dpx,*dpy,*hpx,*hpy;
{
    int tmp1=(*xc-*r<35?1:0),tmp2=(*yc-*r<50?1:0);
    int tmp3=(*xc+*r>610?1:0),tmp4=(*yc+*r>420?1:0);

    if(ch==4)
		*xc=320,*yc=240,*r=140;   else
    if(abs(ch)==1)
	  *xc=(ch==-1?tmp1?*xc:*xc-2:tmp3?*xc:*xc+2); else
	if(abs(ch)==2)
	  *yc=(ch==-2?tmp4?*yc:*yc+2:tmp2?*yc:*yc-2); else
    if(abs(ch)==3)
	  *r=(ch==-3?*r-1:(tmp1||tmp2||tmp3||tmp4)?*r:*r+1),*r=*r<120?120:*r; else
	if(abs(ch)==5)
	if(ch==-5&&!(tmp1||tmp2)) *xc=*xc-2,*yc=*yc-2;
	else if(!(tmp3||tmp2)) *xc=*xc+2,*yc=*yc-2; else;
    if(abs(ch)==6)
	if(ch==-6&&!(tmp1||tmp4)) *xc=*xc-2,*yc=*yc+2;
	else if(!(tmp3||tmp4)) *xc=*xc+2,*yc=*yc+2; else;
    else ;

    *tpx=(*xc-*r/2.0),*tpy=*yc,*dpx=*xc,*dpy=(*yc+*r),*hpx=(*xc+*r/2.0),*hpy=*yc;

    return;
}

void printhrs(int xc,int yc,int r,int clr)
{
char tmp[10];
int i;
float x;
    for(settextstyle(1,0,1),i=1;i<=60;i++)
           if(i%5!=0)
		     clr!=0?setcolor(MAGENTA):setcolor(0),x=angle_prop(i,60),
             line(xc+r*cos(x*RAD),yc+r*sin(x*RAD),xc+(r-10)*cos(x*RAD),yc+(r-10)*sin(x*RAD));
	   else
           {
		clr!=0?setcolor(LIGHTRED):setcolor(0),x=angle_prop(i,60),convert_to_roman(i/5,tmp),
				outtextxy(xc+(5+r+FONT*2)*cos(x*RAD)-FONT*strlen(tmp)/2.0,yc+(r+FONT*2)*sin(x*RAD)-12,tmp);
                clr!=0?setcolor(LIGHTGREEN):setcolor(0),line(xc+(r+3)*cos(x*RAD),yc+(r+3)*sin(x*RAD),xc+(r-14)*cos(x*RAD),yc+(r-14)*sin(x*RAD));
           }
    settextstyle(0,0,0);
return;
}

void  clock(void)
{
char tmp[15],c='S';
int ch,xc=320,yc=240,r=140,i,tflg=0,hrflg=0,minflg=0,secflg=0;
int tpx=xc-r/2.0,tpy=yc,dpx=xc,dpy=yc+r,hpx=xc+r/2,hpy=yc;
float x,t1=-1,t2=-1,t3=-1;
struct time t,tp;
struct date d,dp;

cleardevice(),gettime(&t),getdate(&d);

do
{

    wishing(xc,yc,r,11),printhrs(xc,yc,r,1);
    do
    {
		if(kbhit())
			if(c=getch(),ch=processchar(c),ch) break;
       dp=d,tp=t,gettime(&t),getdate(&d);

       timedisplay(tflg,&tp,&t,tpx,tpy,LIGHTGREEN);

       if(!tflg||dp.da_day!=d.da_day||dp.da_mon!=d.da_mon||dp.da_year!=d.da_year)
		datedisplay(&dp,dpx,dpy,0),
	    datedisplay(&d,dpx,dpy,LIGHTBLUE);

       display_ampm(&tp,&t,tpx,tpy,tflg,11);

       if(tp.ti_hund!=t.ti_hund)
		clock_hund(hpx,hpy,r/4,&tp,0,13),
			clock_hund(hpx,hpy,r/4,&t,LIGHTGREEN,13);

       if(!tflg||tp.ti_sec!=t.ti_sec)
       {
	    triangle(xc,yc,r,t1,60,1.0,SS,SEC,0),
		triangle(xc,yc,r,t2,60,1.2,MS,MIN,0),
		triangle(xc,yc,r,t3,12,1.7,HS,HR,0);
	    settextstyle(1,0,1);
	    if(tp.ti_sec%5!=0)
		setcolor(MAGENTA),x=angle_prop(tp.ti_sec,60),
		line(xc+r*cos(x*RAD),yc+r*sin(x*RAD),xc+(r-10)*cos(x*RAD),yc+(r-10)*sin(x*RAD));
	    else
	    {
		i=(tp.ti_sec/5==0?12:tp.ti_sec/5),setcolor(LIGHTRED),x=angle_prop(i,12),convert_to_roman(i,tmp),
		outtextxy(xc+(5+r+FONT*2)*cos(x*RAD)-FONT*strlen(tmp)/2.0,yc+(r+FONT*2)*sin(x*RAD)-12,tmp);
		setcolor(LIGHTGREEN),line(xc+(r+3)*cos(x*RAD),yc+(r+3)*sin(x*RAD),xc+(r-14)*cos(x*RAD),yc+(r-14)*sin(x*RAD));
	    }
	    settextstyle(0,0,0);

	    t1=t.ti_sec,t2=t.ti_min+t1/60.0,t3=t.ti_hour+t2/60.0;

	    triangle(xc,yc,r,t1,60,1.0,SS,SEC,YELLOW),
	    triangle(xc,yc,r,t2,60,1.2,MS,MIN,LIGHTBLUE),
	    triangle(xc,yc,r,t3,12,1.7,HS,HR,LIGHTRED);
       }
       else
       {
	    if(!secflg) triangle(xc,yc,r,t1,60,1.0,SS,SEC,YELLOW);
	    if(!minflg) triangle(xc,yc,r,t2,60,1.2,MS,MIN,LIGHTBLUE);
	    if(!hrflg)  triangle(xc,yc,r,t3,12,1.7,HS,HR,LIGHTRED);
       }



       if(timebwangles(angle_prop(8.9,12),angle_prop(9.2,12),t.ti_sec,60)||
	  timebwangles(angle_prop(8.9,12),angle_prop(9.2,12),t.ti_min,60)||
	  timebwangles(angle_prop(8.9,12),angle_prop(9.2,12),t.ti_hour,12))
						tflg=2; else tflg=1;

       if(timebwangles(angle_prop(2.0,12),angle_prop(4.0,12),t.ti_sec,60))
		secflg=0; else secflg=1;
       if(timebwangles(angle_prop(2.0,12),angle_prop(4.0,12),t.ti_min,60))
		minflg=0; else minflg=1;
       if(timebwangles(angle_prop(2.0,12),angle_prop(4.0,12),t.ti_hour,12))
		hrflg=0; else hrflg=1;


      wishing(xc,yc,r,11),sec_hr_sound(&tp,&t);
    } while(c!='X'&&c!='x'&&c!=13);

   if(ch)
   {
	tflg=0,hrflg=0,minflg=0,secflg=0;
	wishing(xc,yc,r,0),printhrs(xc,yc,r,0);
	timedisplay(tflg,&t,&t,tpx,tpy,0),datedisplay(&d,dpx,dpy,0);
	clock_hund(hpx,hpy,r/4,&t,0,0),display_ampm(&tp,&t,tpx,tpy,tflg,0);
	triangle(xc,yc,r,t1,60,1.0,SS,SEC,0),triangle(xc,yc,r,t2,60,1.2,MS,MIN,0),
	triangle(xc,yc,r,t3,12,1.7,HS,HR,0),t1=t2=t3=-1;
	activity(&xc,&yc,&r,ch,&tpx,&tpy,&dpx,&dpy,&hpx,&hpy);
   }

}while(ch);

return;
}


void main(void)
{
char w[40]="HOW GOES UR ENEMY";
int gd=DETECT,gm;
initgraph(&gd,&gm,"e:\\tc\\bgi\\");

   // printf("\nEnter the comment:"),gets(w);
    strcat(STRG,w);
    clock();
closegraph();
return;
}




