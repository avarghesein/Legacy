
#include<iostream.h>
#include<conio.h>
#include<string.h>


class person
{
 protected:
 		 char name[20],sex[5];
         int  age;
 public:
 		void getperson(void);
        void putperson(void);
};

void person::getperson(void)
{
	cout<<"\nEnter name,age,sex:",cin>>name>>age>>sex;
    return;
}

void person::putperson(void)
{
	cout<<"\nName:"<<name<<"\nAge:"<<age<<"\nSex:"<<sex;
    return;
}


class bus
{
	protected:
        person *p;
    	int    bus_cde,capacity,booked,*seat;
        float  rate;
    public:
    	void getbus(void),putbus(void),book(int),cancel(int),putseat(int);
        int getcode(void);
};

int bus::getcode(void)
{	return bus_cde;	   }

void bus::getbus(void)
{
	cout<<"\nEnter Bus-code,Total seats,Rate/seat:";
    cin>>bus_cde>>capacity>>rate;
    booked=0,seat=new int[capacity],p=new person[capacity];
    for(int i=0;i<capacity;i++) seat[i]=0;
    return;
}

void bus::putbus(void)
{
	cout<<"\nBus-code:"<<bus_cde<<"\nTotal seats:"<<capacity
    	<<"\nRate/seat:"<<rate<<"\nBooked seats:"<<booked
        <<"\nAvailable seats:"<<capacity-booked;
    return;
}

void bus::putseat(int sno)
{
	if(sno>capacity||sno<1)
    {
    	cout<<"\nError in seat number";
        return;
    }
    if(seat[sno-1]==0) cout<<"\nSeat in not booked";
    else
       cout<<"\n\nPersonnel details for seat no "<<sno<<"\n",
	   	   p[sno-1].putperson();

    return;
}

void bus::book(int sno)
{
    if(booked==capacity||sno>capacity||sno<1)
    {
    		cout<<"\nError in seat number";
            return;
    }
    if(seat[sno-1]==1)
    {
    	cout<<"\nSeat is already booked,Booking cancelled";
        return;
    }
    cout<<"\nEnter personeel details for seat no "<<sno<<"\n";
    p[sno-1].getperson(),seat[sno-1]=1,booked++;
    cout<<"\nAmout to pay:"<<rate;
    return;
}

void bus::cancel(int sno)
{
    if(sno>capacity||sno<1)
    {
    		cout<<"\nError in seat number";
            return;
    }
    if(seat[sno-1]==0)
    {
    	cout<<"\nError seat not booked,Booking cancelled";
        return;
    }
    seat[sno-1]=0,booked--,cout<<"\nAmout Refunded:"<<rate;
    return;
}


class reserve
{
	protected:
        int buses;
        bus businfo[50];
    public:
    	void getsystem(void);
        void book(int),cancel(int),display(int);
        int  ismatching(int);

};

void reserve::getsystem(void)
{
	cout<<"\nEnter number of buses:",cin>>buses;
    for(int i=0;i<buses;i++)
    	cout<<"\nEnter details for bus "<<i+1<<"\n",
        businfo[i].getbus();
    return;
}

int reserve::ismatching(int bcde)
{
    for(int i=0;i<buses;i++)
    	if(bcde==businfo[i].getcode()) return i;

    return -1;
}

void reserve::book(int bno)
{
	int indx=ismatching(bno);
    if(indx==-1)
    {
    	cout<<"\nBus does not exsist with code "<<bno<<" booking aborted";
        return;
    }
    cout<<"\nEnter seat number to reserve:";
    int sno;
    cin>>sno,businfo[indx].book(sno);
    return;
}

void reserve::cancel(int bno)
{
	int indx=ismatching(bno);
    if(indx==-1)
    {
    	cout<<"\nBus does not exsist with code "<<bno<<" cancelling aborted";
        return;
    }
    cout<<"\nEnter seat number to cancel:";
    int sno;
    cin>>sno,businfo[indx].cancel(sno);
    return;
}

void reserve::display(int bno)
{
	int indx=ismatching(bno);
    if(indx==-1)
    {
    	cout<<"\nBus does not exsist with code "<<bno<<" display aborted";
        return;
    }
    businfo[indx].putbus();
    int w=1,sno;
    while(w==1)
    {
    	cout<<"\nEnter seat number for information:",cin>>sno;
        businfo[indx].putseat(sno);
        cout<<"\n1-continue:",cin>>w;
    }
    return;
}
