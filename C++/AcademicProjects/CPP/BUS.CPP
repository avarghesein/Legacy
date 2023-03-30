
#include<iostream.h>
#include<conio.h>


class bus
{
 private:
	int no[40],age[40];
    char name[40][40],sex[40];
 public:
	void book(int),cancel(int),dis(void),init(void);
    int  remain(void);
};


void bus::init(void)
{
 for(int i=0;i<40;i++) no[i]=0;
 return;
}


void bus::book(int x)
{
	if(no[x]==1)
    {
	cout<<"\nSeat no "<<x<<" already booked";
	return;
    }
    no[x]=1;
    cout<<"\nEnter name,age,sex for seat no "<<x<<"\n";
    cin>>name[x]>>age[x]>>sex[x];
    return;
}


void bus::cancel(int x)
{
	if(no[x]==0)
    {
	cout<<"\nError in cancellation";
	return;
    }
    no[x]=0;
    return;
}

int bus::remain(void)
{
int i,j;
	for(i=j=0;i<40;i++)
    	if(no[i]==0)
		++j,cout<<"\nSeat no "<<i<<" is avilable";
return j;
}


void bus::dis(void)
{
int i;
	for(i=0;i<40;i++)
    	if(no[i]==1)
		cout<<"\nseat no:"<<i<<" "<<name[i]<<" "
            	<<age[i]<<" "<<sex[i];
return;
}
