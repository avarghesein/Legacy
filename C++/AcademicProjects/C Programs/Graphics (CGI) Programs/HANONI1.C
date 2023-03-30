


#include<string.h>
#include<graphics.h>
#include<stdlib.h>

#define  CLR   LIGHTRED      //-------any other clr
#define  tCLR  YELLOW        //--------text in disk
#define  mtCLR 11            //------moving text
#define otCLR  LIGHTGREEN    //------ordinary text
#define aCLR   13            //------arrow clr

int height=50,dec_horiz=10,decvert=10,strtbott=420,decy,decs;

//---------height==>disk's max-y while moving
//---------dec_horiz==>decrement of x while moving
//---------strtbott==>bottom of pegs
//---------decvert==>decrement of y  while moving

int pg[3]={115,325,535};   //--------pegs x values
int strtsize=95;          //------starting size of disk,MAX size
int del=50;               //------delay

struct disk
{
 int top,sze,n;
};

struct pegs
{
 int x,disks;
 struct disk *l;
};

struct pegs p[3];


void texts(void)
{
 setcolor(otCLR),
 outtextxy(pg[0]-50,strtbott+35,"SOURCE(Peg-1)"),
 outtextxy(pg[1]-50,strtbott+35,"TEMP(Peg-2)"),
 outtextxy(pg[2]-65,strtbott+35,"DESTINATION(Peg-3)");
 return;
}

void draw_pegs(int i)
{
int j;

   for(setcolor(CLR),j=0;j<3;j++)
	if(i==3||j==i)
	{
	    line(pg[j],strtbott,pg[j],height),
	    line(pg[j]-strtsize+8,strtbott,pg[j]+strtsize-8,strtbott);
	    if(i!=3) break;
	}
return;
}

void arrow_h(int x,int y,int d,int clr)
{
 setcolor(clr),setlinestyle(SOLID_LINE,3,3),
 line(x,y,x+d/2.0,y+d/3.0),line(x,y,x+d/2.0,y-d/3.0);
 line(x+d/2.0,y+d/3.0,x+d/3.0,y),line(x+d/2.0,y-d/3.0,x+d/3.0,y),
 line(x+d/3.0,y,x+d,y),setlinestyle(SOLID_LINE,1,1);
 return;
}


void arrow_v(int x,int y,int d,int clr)
{
 setcolor(clr),setlinestyle(SOLID_LINE,3,3),
 line(x,y,x+d/3.0,y+d/2.0),line(x,y,x-d/3.0,y+d/2.0);
 line(x+d/3.0,y+d/2.0,x,y+d/3.0),line(x-d/3.0,y+d/2.0,x,y+d/3.0),
 line(x,y+d/3.0,x,y+d),setlinestyle(SOLID_LINE,1,1);
 return;
}

int true;

void drect(int l,int t,int r,int b,int n,int clr,int dely,int pgs,int aclr,int dir)
{
char s[20];
int i;
	if(pgs==3)
		for(setcolor(CLR),i=0;i<3;i++)
			line(pg[i],b,pg[i],t);
	else
		setcolor(0),line(pg[pgs],b,pg[pgs],t);

	if(dely>0)
		if(dir==-2)   arrow_h(r,(t+b)/2.0,(b-t)/2.0,aCLR); else
		if(dir==+2)   arrow_h(l,(t+b)/2.0,(t-b)/2.0,aCLR); else
		if(dir==-1)   arrow_v(r,b,(b-t)/2.0,aCLR);         else
		if(dir==+1)   arrow_v(l,b,(b-t)/2.0,aCLR);         else
		if(dir==-3)   arrow_v(r,t,(t-b)/2.0,aCLR);         else
			      arrow_v(l,t,(t-b)/2.0,aCLR);

	setcolor(clr),rectangle(l,t,r,b);
	if(true)
		setcolor(aclr),sprintf(s,"DISK"),outtextxy(l+4,(t+b)/2-decy/4,s),sprintf(s,"%d",n),
		outtextxy(r-8*strlen(s),(t+b)/2-decy/4,s);

	if(dely>0)
	{
	  delay(dely),setcolor(0),rectangle(l,t,r,b);
	  if(dely>0)
		if(dir==-2)   arrow_h(r,(t+b)/2.0,(b-t)/2.0,0); else
		if(dir==+2)   arrow_h(l,(t+b)/2.0,(t-b)/2.0,0); else
		if(dir==-1)   arrow_v(r,b,(b-t)/2.0,0);         else
		if(dir==+1)   arrow_v(l,b,(b-t)/2.0,0);         else
		if(dir==-3)   arrow_v(r,t,(t-b)/2.0,0);         else
			      arrow_v(l,t,(t-b)/2.0,0);

	  if(true) sprintf(s,"DISK"),outtextxy(l+4,(t+b)/2-decy/4,s),
		   sprintf(s,"%d",n),outtextxy(r-8*strlen(s),(t+b)/2-decy/4,s);

	  if(setcolor(CLR),pgs>=0&&pgs<=2) line(pg[pgs],b,pg[pgs],t);
	}
return;
}


void freeall(int n)
{
int i,j;

     if(n>0)
	for(i=0;i<3;i++)
		free(p[i].l);
closegraph();
return;
}


void initialpegs(int n)
{
 int i,j,size;

 p[0].x=pg[0],p[1].x=pg[1],p[2].x=pg[2];
 size=strtsize;
 if(n>1) decs=((float)strtsize-25.0)/(float)(n-1); else decs=10;
 if(n>4) decy=(strtbott-height)/(n+1);  else decy=60;

 for(i=0;i<3;i++) p[i].l=(struct disk *)calloc(n+1,sizeof(struct disk)),
		  p[i].l[0].top=strtbott,p[i].disks=0;

 for(texts(),draw_pegs(3),j=1,i=n,p[0].disks=n;i>=1;i--,j++)
    p[0].l[j].top=p[0].l[j-1].top-decy,p[0].l[j].sze=size,size-=decs,
    p[0].l[j].n=i,setcolor(CLR),
    drect(p[0].x-p[0].l[j].sze,p[0].l[j].top,p[0].x+p[0].l[j].sze,p[0].l[j].top+decy,i,CLR,0,0,tCLR,0);

return;
}


void set_stod(int i,int j)
{
	p[j].l[p[j].disks+1].top=p[j].l[p[j].disks].top-decy;
	p[j].l[p[j].disks+1].sze=p[i].l[p[i].disks].sze;
	p[j].l[p[j].disks+1].n=p[i].l[p[i].disks].n;
	p[j].disks++,p[i].disks--;
return;
}

int sf;
double tmp;


void single_rect(int l,int t,int size,int num)
{
char s[10];

if(setcolor(0),t<strtbott)
{
   if(true) sprintf(s,"DISK"),outtextxy(l+4,(t+(t+decy))/2-decy/4,s),
	    sprintf(s,"%d",num),outtextxy((l+2*size)-8*strlen(s),(t+(t+decy))/2-decy/4,s);
   rectangle(l,t,l+2*size,t+decy);
}
else
   line((l+size)-strtsize+8,strtbott,(l+2*size)+strtsize-8,strtbott);

if(setcolor(tCLR),t<strtbott)
{
  if(true)
     sprintf(s,"DISK"),outtextxy(l+4,(t+(t+decy))/2-decy/4,s),
     sprintf(s,"%d",num),outtextxy((l+2*size)-8*strlen(s),(t+(t+decy))/2-decy/4,s);

 setcolor(CLR),rectangle(l,t,l+2*size,t+decy);
}
else
   setcolor(CLR),line((l+size)-strtsize+8,strtbott,(l+2*size)+strtsize-8,strtbott);

return;
}


void move(int i,int j)
{
static int k=0;
int cnt,y1,dist,x1,x2,i1,j1,s1,sflg,t1,t2,n=p[i].l[p[i].disks].n;
char stg[100],c;

   if(true==1)
	 tmp-=1.0,sprintf(stg,"MOVING DISK-%d FROM PEG-%d TO PEG-%d (MOVE REMAINS %0.0lf) [ENTER-EXIT]",n,i+1,j+1,tmp);
   else
	 sprintf(stg,"MOVING DISK-%d FROM PEG-%d TO PEG-%d [ENTER-EXIT]",n,i+1,j+1);

   setcolor(otCLR),outtextxy(10,height-40,stg);

 if(sf) sound(291);

 t1=p[i].l[p[i].disks-1].top,t2=p[i].l[p[i].disks-1].sze;
 for(cnt=0,x1=p[j].x,x2=p[i].x,s1=p[i].l[p[i].disks].sze,dist=x1-x2,
     sflg=dist<0?-1:1,i1=p[i].l[p[i].disks].top;
   i1>=height;i1-=decvert)
   {
	drect(x2-s1,i1,x2+s1,i1+decy,n,k++%16,del,i,mtCLR,sflg*1);
	if(i1+decy+decy/2.0>=t1) single_rect(x2-t2,t1,t2,p[i].l[p[i].disks-1].n);
	if(cnt<5) ++cnt; else  nosound();
   }

 if(cnt<=5) nosound();

 for(i1+=decvert,j1=x2;(dist<0?j1>=x1:j1<=x1);j1+=(sflg*dec_horiz))
		drect(j1-s1,i1,j1+s1,i1+decy,n,k++%16,del,3,mtCLR,sflg*2);

 if(sf) sound(271);
 for(cnt=0,j1-=(sflg*dec_horiz),y1=p[j].l[p[j].disks].top;i1<=y1-decy;i1+=decvert)
 {
       drect(j1-s1,i1,j1+s1,i1+decy,n,k++%16,del,j,mtCLR,sflg*3);
       if(cnt<5) ++cnt; else  nosound();
 }

 if(cnt<=5) nosound();

 drect(x1-s1,y1-decy,x1+s1,y1,n,CLR,0,j,tCLR,0),set_stod(i,j),
 setcolor(0),outtextxy(10,height-40,stg);

 if(kbhit()) if(c=getch(),c==13) exit(1);
 return;
}


double cnthanoni(int n)
{
double cnt;

if(n>0) cnt=cnthanoni(n-1),cnt+=1.0,cnt+=cnthanoni(n-1); else  return 0;
return cnt;
}

//----------------CORE-------------//

void hanoni(int n,int s,int t,int d)
{
 if(n>0) hanoni(n-1,s,d,t),move(s,d),hanoni(n-1,t,s,d);
 return;
}


void main()
{
int gd=DETECT,gm,n,f;
char x[100];
double y;
initgraph(&gd,&gm,"e:\\tc\\bgi");

 printf("\n\n\n\n\n   TOWER OF HANONI!!!\n   Enter number of disks(MAX 71):"),scanf("%d",&n);
 printf("\n\n\n   ENTER 1 TO CHANGE DELAY:"),scanf("%d",&f);
 if(f==1) printf("\n\n\n   ENTER DELAY:"),scanf("%d",&del);
 if(del<=0) del=45;
 printf("\n\n\n   NON ZERO-FOR SOUND-ANIMATION:"),scanf("%d",&sf);

 if(n>0&&n<=71)
 {
   if(n<26)
	printf("\n\n   WAIT!!!"),
	printf("\n\n\n   MOVES REQUIRED %0.0lf (TO CONTINUE ENTER 1 ):",y=cnthanoni(n)),
	tmp=y,true=1;
   else
       true=(n<=30)?2:0,printf("\n\n\n   1-TO CONTINUE:");

 if(scanf("%d",&f),f!=1) exit(0);
 cleardevice(),flushall(),initialpegs(n),hanoni(n,0,1,2),setcolor(tCLR),
 sprintf(x,"SUCCESS ALL DISKS MOVED FROM PEG-1 TO PEG-3,TOTAL MOVES %0.0lf",y),
 outtextxy(20,height-20,x);
 }
 else
    outtextxy(20,height-20,"INVALID NUMBER OF DISKS");

getch(),freeall(n);
}

//-------------------------------------------//