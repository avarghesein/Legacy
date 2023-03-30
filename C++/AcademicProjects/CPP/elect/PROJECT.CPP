

  #include<dos.h>
  #include<math.h>
  #include "inc1.cpp"

  union REGS i,o;
  int x,y,button;

  initmouse()
  {
    i.x.ax;
    int86(0x33,&i,&o);
    return(o.x.ax);
  }

  showmouseptr()
  {
    i.x.ax=1;
    int86(0x33,&i,&o);
  }

  hidemouseptr()
  {
    i.x.ax=2;
    int86(0x33,&i,&o);
  }

  getmousepos(int *button,int *x,int *y)
  {
    i.x.ax=3;
    int86(0x33,&i,&o);

    *button=o.x.bx;
    *x=o.x.cx;
    *y=o.x.dx;
  }

  class menu
  {
      private:
	   char options[20][30];
	   int len;

      public :
	  char outsymbol(int indx)
	  {	return options[indx][0];    }
	  int menus(int);
	  int putlen()
	  {	return len<=3?len:3; }
	  int voter_menu(int,int);
	  void read_candidates(char*);
	  friend class candidate;
  };

 void menu::read_candidates(char *fn)
 {
 fstream f(fn,ios::in|ios::binary);
 candidate c;
	if(f==0)
	{

		return;
	}
	len=-1;
	f.clear();
	f.seekg(0);
	while(f.read((char*)&c,lc))
	  options[++len][0]=c.symbol,strcpy((options[len]+1),c.getname());

       f.close();
       return;
 }


  int menu :: menus(int type)
  {

   int i,n,f=0;

   initmouse();

   if( initmouse()==0)
   {
     closegraph();
     restorecrtmode();
     cout<<"\nMOUSE DRIVER NOT FOUND";
     exit(0);
   }

   if(type==0)
   {
     strcpy(options[0],"ADMINISTRATOR");
     strcpy(options[1],"ADD VOTER");
     strcpy(options[2],"ADD CANDIDATE");
     strcpy(options[3],"SWITCH TO VOTING");
     strcpy(options[4],"EXIT");
     n=4;
   }
   if(type==1)
   {
     strcpy(options[0],"VOTING MENU");
     strcpy(options[1],"ALLOW VOTE");
     strcpy(options[2],"STOP VOTING");
     n=2;
   }

	       // flag  hoist
    /*     for(y=480;y-75>=75;y-=4)
	cleardevice(),setcolor(YELLOW),
	line(320,480,320,50),rectangle(320,y-75,450,y),
	line(320,y-50,450,y-50),line(320,y-25,450,y-25),
	fillflood(325,y-30,GREEN,BLACK);
	 #define incre  3.14*25*2/24;

   for(y=450;y>=250;y-=4)
   {
   clearviewport();
   setcolor(BLUE);
   rectangle(400,y-150,600,y);
   line(400,100,400,480);
   line(400,y-50,600,y-50);
   line(400,y-100,600,y-100);
   setfillstyle(SOLID_FILL,GREEN);
   floodfill(410,110,BLUE);
   setfillstyle(SOLID_FILL,WHITE);
   floodfill(410,160,BLUE);
   setfillstyle(SOLID_FILL,RED);
   floodfill(410,210,BLUE);
   setcolor(DARKGRAY);

   circle(500,175,25);
   int x1=500,y1=175,x2=500,y2=150;
   moveto(x1,y1);
   lineto(x2,y2);
   for(i=0;i<2;i++)
   {
     x2+=incre;y2+=incre;
     x2+=2,y2-=3;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   for(i=0;i<3;i++)
   {
     x2+=incre;y2+=incre;
     x2-=3,y2+=.95;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   for(i=0;i<2;i++)
   {
     x2-=incre;y2+=incre;
     x2+=5;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   for(i=0;i<4;i++)
   {
     x2-=incre;y2+=incre;
     x2+=2;y2-=1.2;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   for(i=0;i<4;i++)
   {
     x2-=incre;y2-=incre;
     x2+=1;y2+=3;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   for(i=0;i<3;i++)
   {
     x2-=incre;y2-=incre;
     y2+=2;x2+=6;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   x2=500,y2=150;
   for(i=0;i<2;i++)
   {
     x2-=incre;y2+=incre;
     x2+=2,y2-=5;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   for(i=0;i<3;i++)
   {
     x2-=incre;y2+=incre;
     x2+=3,y2-=1;
     moveto(x1,y1);
     lineto(x2,y2);
   }
   }                         */

   setcolor(WHITE);
   settextstyle(8,HORIZ_DIR,4);
   outtextxy(150,type==0?20:50,options[f++]);
   setbkcolor(LIGHTBLUE);
   for(i=type==0?100:150;i<=150+(n-1)*100;i+=100)
   {
     setcolor(GREEN);
     rectangle(100,i,350,i+50);
     setfillstyle(SOLID_FILL,LIGHTBLUE);
     floodfill(105,i+5,GREEN);
     setcolor(RED);
     settextstyle(7,HORIZ_DIR,2);
     outtextxy(115,i+10,options[f++]);
     setcolor(WHITE);
     line(100,i,350,i);
     line(100,i,100,i+50);
     setcolor(DARKGRAY);
     line(350,i,350,i+50);
     line(100,i+50,350,i+50);

   }
   if (type==0)
   {
     i=175;
     setcolor(GREEN);
     rectangle(400,i,600,i+200);
     setfillstyle(SOLID_FILL,LIGHTBLUE);
     floodfill(405,i+5,GREEN);
     setcolor(RED);
     settextstyle(7,HORIZ_DIR,2);
     outtextxy(450,i+90,"RESULTS");
     setcolor(WHITE);
     line(400,i,600,i);
     line(400,i,400,i+200);
     setcolor(DARKGRAY);
     line(600,i,600,i+200);
     line(400,i+200,600,i+200);

   }


   while(1)
   {
      showmouseptr();
      f=1; int x1=100,x2=350,y1=type==0?100:150,y2=y1+50;
      getmousepos(&button,&x,&y);
	if(type==0 && (button & 1)==1 && (x>=400 && x<=600 && y>=175&&y<=375))
	   {

	    i=175;
     setcolor(DARKGRAY);
     line(400,i,600,i);
     line(400,i,400,i+200);
     setcolor(WHITE);
     line(600,i,600,i+200);
     line(400,i+200,600,i+200);
     delay(300);
      setcolor(WHITE);
     line(400,i,600,i);
     line(400,i,400,i+200);
     setcolor(DARKGRAY);
     line(600,i,600,i+200);
     line(400,i+200,600,i+200);
     delay(300);
     return 100;


	   }

       for(i=0;i<n;i++)
       {
	if(y>y1 && y<y2 && x>x1 && x<x2)
	 {
	  if((button &1)==1)
	   {
	     hidemouseptr();
	     setcolor(DARKGRAY);
	     line(x1,y1,x2,y2-50);
	     line(x1,y1,x1,y2);
	     setcolor(WHITE);
	     line(x1,y1+50,x2,y2);
	     line(x2,y2,x2,y1);
	     delay(1000);
	     setcolor(WHITE);
	     line(x1,y1,x2,y2-50);
	     line(x1,y1,x1,y2);
	     setcolor(DARKGRAY);
	     line(x1,y1+50,x2,y2);
	     line(x2,y2,x2,y1);
	     delay(255);
	     return(f);
	   }
	 }
	else

	 f++,y1+=100,y2+=100;
       }
   }
  }









   int menu :: voter_menu(int m,int n)
  {
   int i,f=m;
   char tmp[3];

   initmouse();

   if( initmouse()==0)
   {
     closegraph();
     restorecrtmode();
     cout<<"\nMOUSE DRIVER NOT FOUND";
     exit(0);
   }
   clearviewport();
   setbkcolor(LIGHTBLUE);
      int j;
   int k;
   for(j=m%(len+1),i=100;j<=n%(len+1);i+=100,j++)
   {
     setcolor(GREEN);
     rectangle(100,i,400,i+50);
     rectangle(450,i,500,i+50);
     setfillstyle(SOLID_FILL,LIGHTBLUE);
     floodfill(105,i+5,GREEN);
     setcolor(RED);
     settextstyle(7,HORIZ_DIR,0);
     outtextxy(115,i+10,options[f]+1);
     sprintf(tmp,"%c",options[f++][0]);
     outtextxy(465,i+10,tmp);
     setcolor(WHITE);
     line(450,i,500,i);
     line(450,i,450,i+50);
     setcolor(DARKGRAY);
     line(500,i,500,i+50);
     line(450,i+50,500,i+50);

   }

   for(j=1,i-=75,k=525;j<=2;j++,k+=50)
   {
     setcolor(GREEN);
     rectangle(k,i,k+25,i+25);
     setfillstyle(SOLID_FILL,LIGHTBLUE);
     floodfill(k+5,i+5,GREEN);
     setcolor(RED);
     settextstyle(7,HORIZ_DIR,1);
     outtextxy(j==2?k+3:k+3,i+1,j==1?"<-":"->");
     setcolor(WHITE);
     line(k,i,k+25,i);
     line(k,i,k,i+25);
     setcolor(DARKGRAY);
     line(k+25,i,k+25,i+25);
     line(k,i+25,k+25,i+25);
   }


   while(1){
      showmouseptr();
      int x1=450,x2=500,y1=100,y2=150,x3=525,x4=550,y3=i,y4=i+25;
      getmousepos(&button,&x,&y);
      if((button &1)==1)
      {
       for(f=m,i=m%(len+1);i<=n%(len+1);i++,f++)
       {
	if(y>y1 && y<y2 && x>x1 && x<x2)
	 {
	  hidemouseptr();
	  setcolor(DARKGRAY);
	  line(450,y1,500,y2-50);
	  line(450,y1,450,y2);
	  setcolor(WHITE);
	  line(450,y1+50,500,y2);
	  line(500,y2,500,y1);
	  delay(1000);
	  setcolor(WHITE);
	  line(450,y1,500,y2-50);
	  line(450,y1,450,y2);
	  setcolor(DARKGRAY);
	  line(450,y1+50,500,y2);
	  line(500,y2,500,y1);
	  delay(255);
	  return(f);
	 }
	else
	 {
	 for(j=1;j<=2;j++,x3+=50,x4+=50)
	 if(y>y3 && y<y4 && x>x3 && x<x4)
	  {
	 hidemouseptr();
	 setcolor(DARKGRAY);
	 line(x3,y3,x3+25,y3);
	 line(x3,y3,x3,y3+25);
	 setcolor(WHITE);
	line(x3+25,y3,x3+25,y3+25);
	line(x3,y3+25,x3+25,y3+25);
	delay(500);
	 setcolor(WHITE);
		 line(x3,y3,x3+25,y3);
	 line(x3,y3,x3,y3+25);

	 setcolor(DARKGRAY);
	 line(x3+25,y3,x3+25,y3+25);
	line(x3,y3+25,x3+25,y3+25);

	if (j==1)
	   {if (!(n+1>len))
	     m=m+1,n=n+1;}
	else
	   {if (!(m-1<0))
		 n=n-1,m=m-1;}
	break;
	}

	if(j<=2)

		 return voter_menu(m,n);

	else
		f++,y1+=100,y2+=100;
       }
      }
      }
  }

   }
 /*  void main(void)
   {
   menu m;

   int gdriver = DETECT, gmode, errorcode;

     initgraph(&gdriver, &gmode, "e:\\tc\\bgi");
     setbkcolor(LIGHTBLUE);
     settextstyle(7,HORIZ_DIR,2);
     setcolor(RED);
   //person_entry();
//   add_can();
   m.read_candidates("can.txt");
   m.voter_menu(0,m.putlen());
   }*/