
#include<stdio.h>
#include<dos.h>
#include<iostream.h>
#include<iomanip.h>
#include<fstream.h>
#include<string.h>



void cnvrt(char *tmp,int num)
{
	int i=0;
    tmp[i]='0';
    while(num>0) tmp[i++]=char(num%10+'0'),num/=10;
    if(i==0) ++i;
    tmp[i]='\0';
    return;
}

void combine(char *t,const char *s1,int d,int m,int y)
{
	strcpy(t,s1);

    char tmp[25];
    cnvrt(tmp,d),strcat(t,tmp),
	cnvrt(tmp,m),strcat(t,tmp),
    cnvrt(tmp,y),strcat(t,tmp);

	strcat(t,".txt");
    return;
}

//-----------------------------------------------------------//


class ticket
{
 protected:
    int tickets,booked,rate;
 public:
 	void getticket(void);
    void putticket(void);
};

class dates
{
 protected:
 	int dd,mm,yy;
 public:
 	void getdates(void);
    void putdates(void);
};

class times
{
 protected:
 	int hr,min,sec;
 public:
 	void gettimes(void);
    void puttimes(void);
};

class train:public ticket,public dates,public times
{
 protected:
	char tno[15],name[15];
 public:
 	void gettrain(void);
    void puttrain(void);
	friend int booking(char*);
	friend int cancelling(char*);
	friend int display(char*);
    friend int displayall(char*);
    friend int updatetrain(char*);
	friend int updateperson(char*);
    friend int isexsisttrain(train&,char*);
    friend int isvaliddate(train&);
    friend int isvalidbasedate(train&);
    friend int isvalidtime(train&);
	friend fstream &operator>>(fstream&,train&);
	friend fstream &operator<<(fstream&,train&);
};


class person:public dates,public times
{
 protected:
 	char name[20],id[20];
    int  reserved;
 public:
    friend fstream &operator<<(fstream&,person&);
    friend fstream &operator>>(fstream&,person&);
    friend int full(char*);
    friend int booking(char*);
    friend int cancelling(char*);
    friend int display(char*);
	friend int updateperson(char*);
    void getperson(char* ='\0',char* ='\0');
    void getdateper(void);
    void gettimeper(void);
    void putperson(void);
};

///-----------------------------------------------------------------///

void ticket::getticket(void)
{
	cout<<"\nEnter total number of seats & rate/seat:";
    cin>>tickets>>rate,booked=0;
    return;
}

void ticket::putticket(void)
{
	cout<<"\nTotal number of seats:"<<tickets<<"\nBooked seats:"
    	<<booked<<"\nRate/seat:"<<rate;

    return;
}



void dates::getdates(void)
{
	cout<<"\nEnter dd/mm/yy:",cin>>dd>>mm>>yy;
    return;
}

void dates::putdates(void)
{
	cout<<"\nDate:"<<dd<<"/"<<mm<<"/"<<yy;
    return;
}

void times::gettimes(void)
{
	cout<<"\nEnter hrs/mins/secs:",cin>>hr>>min>>sec;
    return;
}

void times::puttimes(void)
{
	cout<<"\nTime(hrs/mins/secs)["<<hr<<":"<<min<<":"<<sec<<"]";
    return;
}

void train::gettrain(void)
{
	cout<<"\nEnter train-no,name:",cin>>tno>>name;
    getticket(),getdates(),gettimes();
    return;
}


void train::puttrain(void)
{
	cout<<"\nTrain-no:"<<tno<<"\nName:"<<name;
    putticket(),putdates(),puttimes();
    return;
}


void person::getdateper(void)
{
    struct date d;
    getdate(&d),dd=d.da_day,mm=d.da_mon,yy=d.da_year;
    return;
}

void person::gettimeper(void)
{
	struct time t;
    gettime(&t),hr=t.ti_hour,min=t.ti_min,sec=t.ti_sec;
    return;
}


void person::getperson(char *x,char *y)
{
    (*this).getdateper(),(*this).gettimeper();
	if(strlen(x)!=0) strcpy(name,x);
    if(strlen(y)!=0) strcpy(id,y);
    return;
}


void person::putperson(void)
{
	cout<<"\nName:"<<name<<"\nSeats reserved:"<<reserved<<"\nId:"<<id;
    putdates(),puttimes();
    return;
}




fstream &operator<<(fstream &out,train &t)
{
	out<<"\n"<<setw(5)<<t.tickets<<" "<<setw(5)<<t.booked<<" "<<setw(5)
	   <<t.rate<<" "<<setw(5)<<t.dd<<" "<<setw(5)<<t.mm<<" "<<setw(5)
	   <<t.yy<<" "<<setw(15)<<t.tno<<" "<<setw(15)<<t.name<<" "
       <<setw(5)<<t.hr<<" "<<setw(5)<<t.min<<" "<<setw(5)<<t.sec;


    char tmp[50];
    combine(tmp,t.tno,t.dd,t.mm,t.yy);
    fstream f(tmp,ios::in|ios::out);
    f.close();

    return out;
}

fstream &operator>>(fstream &in,train &t)
{
	in>>t.tickets>>t.booked>>t.rate>>t.dd>>t.mm>>t.yy>>t.tno>>t.name
      >>t.hr>>t.min>>t.sec;
    return in;
}


fstream &operator<<(fstream &out,person &t)
{
	out<<"\n"<<setw(15)<<t.name<<" "<<setw(5)<<t.reserved
       <<" "<<setw(5)<<t.dd<<" "<<setw(5)<<t.mm<<" "<<setw(5)<<t.yy
       <<" "<<setw(5)<<t.hr<<" "<<setw(5)<<t.min<<" "<<setw(5)<<t.sec
       <<" "<<setw(15)<<t.id;

    return out;
}

fstream &operator>>(fstream &in,person &t)
{
	in>>t.name>>t.reserved>>t.dd>>t.mm>>t.yy>>t.hr>>t.min>>t.sec>>t.id;
    return in;
}


int updatetrain(char *name)
{
    fstream i(name,ios::in);
    if(i==0) return 0;

    fstream o("traintmp.txt",ios::out);
    i.seekg(0),o.seekp(0);
    train t;
    char   x[20];

    while(!i.eof())
    	if(i>>t,!i.fail())
			if(combine(x,t.tno,t.dd,t.mm,t.yy),isvaliddate(t))
				   o<<t,updateperson(x);
        	else   remove(x);

   i.close(),o.close(),remove(name),rename("traintmp.txt",name);

   return 1;
}



int isvaliddate(train &t)
{
if(!isvalidbasedate(t)) return 0;

struct date d;

getdate(&d);
    if(t.yy<d.da_year) return 0; else
    if(t.yy>d.da_year) return 1; else
    if(t.mm<d.da_mon)  return 0; else
    if(t.mm>d.da_mon)  return 1; else
    if(t.dd<d.da_day)  return 0; else
    if(t.dd>d.da_day)  return 1; else
    return isvalidtime(t);
}

int isvalidbasedate(train &t)
{
if(t.yy<=0||t.mm<=0||t.mm>12||t.dd<=0) return 0;

    if(t.mm<=7)
       	if(t.mm%2==1) return t.dd<=31?1:0;
        else
        	if(t.mm==2)
            	if(t.yy%4==0) return t.dd<=29?1:0;
                else		  return t.dd<=28?1:0;
            else   return t.dd<=30?1:0;
    else
    	if(t.mm%2==1) return t.dd<=30?1:0;
        else		  return t.dd<=31?1:0;

}




int isvalidtime(train &t)
{
if(t.hr<=0||t.hr>24||t.min<=0||t.min>60||t.sec<=0||t.sec>60) return 0;

struct time te;
gettime(&te);

    if(t.hr<te.ti_hour) return 0; else
    if(t.hr>te.ti_hour) return 1; else
    if(t.min<te.ti_min) return 0; else
    if(t.min>te.ti_min) return 1; else
    if(t.sec<te.ti_sec) return 0; else return 1;
}


int updateperson(char *fname)
{
	fstream i(fname,ios::in);
    if(i==0) return 0;
    fstream o("pertmp.txt",ios::out);
    i.seekg(0),o.seekp(0);
    person p;

    while(!i.eof())
         if(i>>p,!i.fail())
		 	if(p.reserved>0) o<<p;

    i.close(),o.close(),remove(fname),rename("pertmp.txt",fname);

    return 1;
}


int isexsisttrain(train &t,char *fname)
{
    fstream i(fname,ios::in);
    if(i==0) return 0;
    int flg=0;
    train tr;
    while(!i.eof())
	  if(i>>tr,!i.fail())
	  	if(!strcmp(t.tno,tr.tno)&&t.dd==tr.dd&&t.mm==tr.mm&&t.yy==tr.yy)
      	{
        	flg=1;
            break;
      	}


    i.close();

    if(flg) return 1; else return 0;
}
