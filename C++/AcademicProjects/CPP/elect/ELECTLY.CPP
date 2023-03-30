


#include "e:/tc/bin/cpp/project/project.cpp"




int main()
  {
    int gdriver = DETECT, gmode, errorcode;

    /* initialize graphics mode */
     initgraph(&gdriver, &gmode, "e:\\tc\\bgi");

    /* read result of initialization */
     errorcode = graphresult();

     if (errorcode != grOk)  /* an error occurred */
     {
     cout<<"Graphics error: %s\n"<<grapherrormsg(errorcode);
     cout<<"Press any key to halt:";
     getch();
     exit(1);             /* return with error code */
     }
    menu m;
    candidate ca;
    person p;
    while(1){
	cleardevice();
	int ch=m.menus(0);
	switch(ch)
	{
	 case 100:ca.reset_show("result.txt")
	 case 1: person_entry();break;
	 case 2: add_can();break;
	 case 4:return 0;
	 case 3:do{
		cleardevice();
		ch=m.menus(1);
		switch(ch)
		       {
			 case 1:
				  if (ca.valid_voter(p))
					m.read_candidates("can.txt"),
					ca.inc_vote(m.outsymbol(m.voter_menu(0,m.putlen())),p);
				  break;
			 case 2:  return 0;

			}
		}while(1);
	}
     }
    closegraph();
   }
