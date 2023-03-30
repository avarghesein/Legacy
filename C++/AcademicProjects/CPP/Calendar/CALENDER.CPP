


//--------This program can be used to generate calender
//---------Upto year 20,000------//


//-----------------BASIC 1-1-1 is a monday-----------//

#include<conio.h>
#include<fstream.h>
#include<iostream.h>
#include<string.h>

#define MONDAY 2


///-----------------Change only here-----------------///

int isleapyear(long yr)
{
    if(yr%10000==0&&yr%20000==0)   return 1;   else
	if(yr%1000==0&&yr%4000==0)     return 0;   else
    if(yr%100==0)
				if(yr%400==0) return 1;
				else          return 0;
    else
    if(yr%4==0)  return 1; else return 0;
}

long yrs_div_by_n(long,long,long);

long findleapbw(long begy,long endy)
{
    if(begy>endy) return 0;

	long lpyr=yrs_div_by_n(begy,endy,4);
	 lpyr-=yrs_div_by_n(begy,endy,100);
	 lpyr+=yrs_div_by_n(begy,endy,400);
	 lpyr-=yrs_div_by_n(begy,endy,4000);
	 lpyr+=yrs_div_by_n(begy,endy,20000);
    return lpyr;
}

///---------------------------------------------///


class calender
{
 private:
		long year;
		int mon[12],day_beg;
 public:
			    calender(long);
		   ~calender() {};
	       int  printcalender(char*);
	friend int  printmonthinyear(int,long);
	friend int  monthname(char*,int);
	friend int  dayname(char*,int);
	friend int  finddayname(long,int,int,char*);
	friend int  finddaysinmonths(int*,long);
	friend long findtotaldays_fromupto(long,long);
	friend long findleapbw(long,long);
	friend  int nextyearwithdayname(long,long,int,int,int);
	       void calculatecalender(void);
	       void calculatecalenderreduced(void);
};

calender::calender(long yr)
{	year=yr;	}

void  calender::calculatecalender(void)
{
	long totdays=findtotaldays_fromupto(1,year-1);
	day_beg=(totdays%7+MONDAY)%7;
	return;
}

void  calender::calculatecalenderreduced(void)
{
long totdays;
int n=year/1000,i,j;

  for(day_beg=MONDAY,i=j=1;i<=n;j=i*1000,i++)
     totdays=findtotaldays_fromupto(j,i*1000-1),day_beg=(totdays%7+day_beg)%7;

  if(year%1000!=0)
	totdays=findtotaldays_fromupto(j,year-1),day_beg=(totdays%7+day_beg)%7;
  return;
}


long findtotaldays_fromupto(long begy,long endy)
{
	int n=findleapbw(begy,endy),rem=(endy-begy+1)-n;
	long tot=n*366.0+rem*365.0;
    return tot;
}

int finddaysinmonths(int *mon,long yr)
{
if(yr<=0) return 0;

int i=-1;
while(++i,i<12)
	if(i+1<=7)
	if((i+1)%2==1) mon[i]=31;
	else
		if((i+1)==2)
		   if(isleapyear(yr))   mon[i]=29;
		   else		     mon[i]=28;
	    else   mon[i]=30;
    else
	if((i+1)%2==1)  mon[i]=30;
	else		    mon[i]=31;

return 1;
}




int monthname(char *name,int mrep)
{
	if(mrep<=0||mrep>12)
	{
	strcpy(name,"ERROR IN MONTH");
		return 0;
	}
	else
    if(mrep==1)  strcpy(name,"JANUARY");  else
    if(mrep==2)  strcpy(name,"FEBRUARY"); else
    if(mrep==3)  strcpy(name,"MARCH");    else
    if(mrep==4)  strcpy(name,"APRIL");    else
    if(mrep==5)  strcpy(name,"MAY");      else
    if(mrep==6)  strcpy(name,"JUNE"); 	  else
    if(mrep==7)  strcpy(name,"JULY"); 	  else
    if(mrep==8)  strcpy(name,"AUGEST");   else
    if(mrep==9)  strcpy(name,"SEPTEMBER");else
    if(mrep==10) strcpy(name,"OCTOBER");  else
    if(mrep==11) strcpy(name,"NOVEMBER"); else strcpy(name,"DECEMBER");
return 1;
}


int calender::printcalender(char *filen)
{

    if(year<=0) return 0;

    fstream  o(filen,ios::out);
    if(o==0) return 0;

	(*this).calculatecalenderreduced(),finddaysinmonths(mon,year);
    int i=day_beg,m=0,day,j;
    char month[15];

    o<<"\n\n     \t//***************YEAR "<<year<<" CALENDER***************//\n\n";
    while(m<12)
    {
	day=1,monthname(month,m+1);
	o<<"\n\n\n\n\t\t\t   "<<year<<"  "<<month<<"\n\n"
	 <<"\n     SUN\tMON\tTUE\tWED\tTHU\tFRI\tSAT\n";
	while(day<=mon[m])
	{   if(day==1)
		for(j=1,o<<"     ";j<=(i+6)%7;j++) o<<"   \t";
	    if(o<<day++<<"   \t",i=(i+1)%7,i==1) o<<"\n\n     ";
	}
	++m;
    }
    o<<"\n\n\n",o.close();
    return 1;
}


int finddayname(long yr,int mnth,int date,char *dname)
{
    if(yr<=0||mnth<=0||mnth>12||date<=0)
	{
	strcpy(dname,"Error in DATE");
	return 0;
    }
    calender c(yr);
    c.calculatecalender(),finddaysinmonths(c.mon,c.year);
    if(date>c.mon[mnth-1]) return 0;
    long x=date;
    for(int i=0;i<=mnth-2;i++) x+=c.mon[i];
    --x,i=(x%7+c.day_beg)%7;

    if(i==0) i=7;
    dayname(dname,i);
    return i;
}


int printmonthinyear(int mnth,long yr)
{
    if(yr<=0||mnth<=0||mnth>12) return 0;
    calender c(yr);
    c.calculatecalender(),finddaysinmonths(c.mon,yr);
    int day,j;
	long i=c.day_beg;
    char month[15];
    for(j=0;j<=mnth-2;j++) i+=c.mon[j];
    i%=7,day=1,monthname(month,mnth);
    cout<<"\n\n\n\n\t\t\t     "<<yr<<"  "<<month<<"\n\n";
    cout<<"\n     SUN\tMON\tTUE\tWED\tTHU\tFRI\tSAT\n\n\n";
    while(day<=c.mon[mnth-1])
    {   if(day==1)
	    for(j=1,cout<<"     ";j<=(i+6)%7;j++) cout<<"   \t";
	if(cout<<day++<<"   \t",i=(i+1)%7,i==1) cout<<"\n\n     ";
    }
return 1;
}

int dayname(char *name,int dp)
{
	if(dp<=0||dp>7)
	{
        strcpy(name,"ERROR IN DAY");
		return 0;
    }
	else
    if(dp==1) strcpy(name,"SUNDAY");   else
    if(dp==2) strcpy(name,"MONDAY");   else
    if(dp==3) strcpy(name,"TUESDAY");  else
    if(dp==4) strcpy(name,"WEDNESDAY");else
    if(dp==5) strcpy(name,"THURSDAY"); else
    if(dp==6) strcpy(name,"FRIDAY");   else  strcpy(name,"SATURDAY");
return 1;
}

int nextyearwithdayname(long refyr1,long refyr2,int dd,int mm,int day_na)
{
    if(refyr1<=0||refyr2<=0) return 0;
    long x;
    int i;
    if((i=refyr1)>refyr2) refyr1=refyr2,refyr2=i;
    day_na%=7;
    calender z(refyr1);
    z.calculatecalenderreduced();
    while(z.year<=refyr2)
    {
        for(finddaysinmonths(z.mon,z.year),x=i=0;i<=mm-2;x+=z.mon[i++]);
        if(dd<=z.mon[mm-1])
        	if((x+dd-1+z.day_beg)%7==day_na) return z.year;

        while(i<=11) x+=z.mon[i++];
        z.day_beg=(x+z.day_beg)%7,++z.year;
    }
    return 0;
}


long yrs_div_by_n(long begy,long endy,long n)
{
    long bn=begy,en,rem;
    if(endy<begy) begy=endy,endy=bn;

    bn=begy+n-((rem=begy%n)==0?n:rem);
    en=endy-endy%n;

    return en<bn?0:(en-bn)/n+1;
}