

#include<conio.h>
#include"e:\tc\bin\cpp\train\train.cpp"



void main()
{

clrscr();

	cout<<"\nEnter file name contains train data(with extension):";
    char tname[20];
    cin>>tname;
    int w=1;
    while(w!=5)
    {
		cout<<"\n1-Booking,2-Cancelling,3-Enquiary,4-display all,5-exit:",cin>>w;
        switch(w)
        {
    		case 1:if(!booking(tname)) cout<<"\nBooking aborted\n";
				   break;
         	case 2:if(!cancelling(tname)) cout<<"\nCancelling aborted\n";
				   break;
       	  	case 3:if(!display(tname)) cout<<"\nEnquiary failed\n";
				   break;
            case 4:if(!displayall(tname)) cout<<"\nError in display\n";
            	   break;
        	case 5:break;
        	default:cout<<"\nError in choice!!!\n";
        }
    }
}

int booking(char *file)
{

    fstream f(file,ios::binary|ios::in|ios::out|ios::nocreate);

    if(f.fail())
    {
		cout<<"\nFile "<<file<<" not exsist,Error!!!";
    	return 0;
    }

    f.seekg(0),cout<<"\nEnter train number & date(dd/mm/yy):";

    char trno[20];
	int d,m,y,flg=0,seat,ch;
    train tr;

    cin>>trno>>d>>m>>y;

    while(f.read((char*)&tr,tz))
    		if(!strcmp(trno,tr.tno)&&d==tr.dd&&m==tr.mm&&y==tr.yy)
        	{	flg=1;
				break;
        	}


    if(flg==0)
    {
    	cout<<"\nTrain not exsist,Error!!!",f.close();
        return 0;
    }

    cout<<"\nEnter number of seats to reserve:",cin>>seat;

    if(seat>tr.tickets-tr.booked)
    {
    	cout<<"\nSeats not avilable:",f.close();
        return 0;
    }

    person per;
    char pn[20];

    cout<<"\nEnter 1-rebooking,Other-For a new passenger:",cin>>ch,
    combine(trno,trno,d,m,y);

    fstream p(trno,ios::in|ios::out|ios::nocreate|ios::binary);

    if(ch==1)
    {
    	cout<<"\nEnter your id:",cin>>pn,flg=ch=0,p.seekg(0);
    	while(p.read((char*)&per,pz))
				if(!strcmp(per.id,pn))
        		{
        			flg=1;
            		break;
        		}

    	if(flg)  p.clear(),p.seekp(-1*pz,ios::cur),per.reserved+=seat,per.getperson(),p<<per;
        else
        {
        	cout<<"\nError,ID not exsist,Rebooking aborted!!!\n",
            f.close(),p.close();
            return 0;
        }
    }
    else
    {
         cout<<"\nEnter your name:",cin>>pn;
         char name[20],tmp[20];
         do
         {
            strcpy(name,pn),flg=random(tr.tickets+1),cnvrt(tmp,flg);
            strcat(name,tmp),p.clear(),p.seekg(0),flg=0;
            while(p.read((char*)&per,pz))
            		if(!strcmp(per.id,name))
                	{
                		flg=1;
                    	break;
                	}
          }
		  while(flg==1);

          cout<<"\nYour Id:"<<name,
	      p.clear(),p.seekp(0,ios::end),per.getperson(pn,name),per.reserved=seat,
          p<<per;
    }

    cout<<"\n\nAmount to pay="<<float(seat)*float(tr.rate)<<"\n",
    f.clear(),
	f.seekp(-1*tz,ios::cur),tr.booked+=seat,f<<tr,p.close(),f.close();

    return 1;
}


int cancelling(char *file)
{

    fstream f(file,ios::binary|ios::in|ios::out|ios::nocreate);

    if(f.fail())
    {
		cout<<"\nFile "<<file<<" not exsist,Error!!!";
    	return 0;
    }

    char trno[20];
	int d,m,y,flg=0;
    train tr;
	f.seekg(0),cout<<"\nEnter train number & date(dd/mm/yy):",cin>>trno>>d>>m>>y;

    while(f.read((char*)&tr,tz))
		if(!strcmp(trno,tr.tno)&&d==tr.dd&&m==tr.mm&&y==tr.yy)
        	{	flg=1;
				break;
        	}


    if(flg==0)
    {
    	cout<<"\nTrain not exsist,Error!!!",f.close();
        return 0;
    }

    int seat;
    cout<<"\nEnter number of seats to cancel:",cin>>seat,flg=0,
	combine(trno,trno,d,m,y);

    fstream p(trno,ios::binary|ios::in|ios::out|ios::nocreate);
    person per;
    char pn[20];

    p.seekg(0),cout<<"\nEnter your ID:",cin>>pn;

    while(p.read((char*)&per,pz))
   		if(!strcmp(per.id,pn))
        	{
        		flg=1;
            	break;
        	}


    if(flg)
		if(per.reserved>=seat&&seat>0)
		 {
		 	 p.clear(),p.seekp(-1*pz,ios::cur),
			 per.reserved-=seat,per.getperson(),
    		 p<<per,f.clear(),
			 f.seekp(-1*tz,ios::cur),tr.booked-=seat,f<<tr,
	  		 cout<<"\nAmount refunded="<<float(seat)*float(tr.rate)<<"\n",
           	 p.close(),f.close();
             return 1;
         }

    cout<<"\nError in Cancelling!!!\n",p.close(),f.close();
    return 0;
}


int display(char *file)
{
    fstream f(file,ios::binary|ios::in|ios::nocreate);

    if(f.fail())
    {
		cout<<"\nFile "<<file<<" not exsist,Error!!!";
    	return 0;
    }

    char trno[20];
	int d,m,y,flg=0;
    train tr;

	f.seekg(0),
	cout<<"\nEnter train number & date(dd/mm/yy):",cin>>trno>>d>>m>>y;

    while(f.read((char*)&tr,tz))
			if(!strcmp(trno,tr.tno)&&d==tr.dd&&m==tr.mm&&y==tr.yy)
        	{	flg=1;
				break;
        	}

    if(flg==0)
    {
    	cout<<"\nTrain not exsist,Error!!!",f.close();
        return 0;
    }

    f.close(),tr.puttrain(),combine(trno,trno,d,m,y);
    cout<<"\n\n1-personeel,2-full passenger details,other-exit:",cin>>flg;

    if(flg==2) return full(trno); else
    if(flg!=1) return 1;

    fstream p(trno,ios::binary|ios::in|ios::nocreate);
    person per;
    char pn[20];

    flg=0,p.seekg(0),cout<<"\nEnter your ID:",cin>>pn;

    while(p.read((char*)&per,pz))
			if(!strcmp(per.id,pn))
        	{
        		flg=1;
            	break;
        	}

    if(flg)  per.putperson(),cout<<"\n";
    else     cout<<"Person not exsist\n";

    p.close();
    return 1;
}


int displayall(char *file)
{
    fstream f(file,ios::binary|ios::in|ios::nocreate);

    if(f.fail())
    {
		cout<<"\nFile "<<file<<" not exsist,Error!!!";
    	return 0;
    }

    char trno[20];
	int flg=0,i=1;
    train tr;

	f.seekg(0);
    while(f.read((char*)&tr,tz))
		{
            cout<<"\n//-------------Train "<<i++<<"------------//\n",tr.puttrain();
            cout<<"\n\nEnter 1-for passenger details,2-Exit display,other-Next train:",cin>>flg;
            if(flg==1) combine(trno,tr.tno,tr.dd,tr.mm,tr.yy),full(trno),getch();
            else if(flg==2) break; else continue;
        }

    f.close();
    return 1;
}



int full(char *trno)
{
    fstream p(trno,ios::in|ios::binary|ios::nocreate);

    if(p.fail()) return 0;

    person per;
    p.seekg(0);
    cout<<"\n//================Passengers====================//\n";
    while(p.read((char*)&per,pz))
		 	if(per.reserved!=0) per.putperson(),cout<<"\n";

return 1;
}
