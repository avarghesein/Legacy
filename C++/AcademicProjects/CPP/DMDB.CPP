
#include<iostream.h>
#include<conio.h>

class db;

class dm
{
private:
    	float mtr,cmtr;
public:
        void display(void);
        void read(void);
        friend dm add_dbtodm(db,dm);
        friend db add_dmtodb(dm,db);
};


class db
{
private:
		float ft,inchs;
public:
        void display(void);
        void read(void);
        friend dm add_dbtodm(db,dm);
        friend db add_dmtodb(dm,db);
};


void dm::read(void)
{
	cout<<"\nEnter  meters first then centimeters:";
    cin>>mtr>>cmtr;
	return;
}

void dm::display(void)
{
	cout<<mtr<<" mts "<<cmtr<<" cmts";
    return;
}


void db::read(void)
{
	cout<<"\nEnter  feets first then inches:";
    cin>>ft>>inchs;
    return;
}

void db::display(void)
{
	cout<<ft<<" fts "<<inchs<<" inchs";
    return;
}



dm add_dbtodm(db x,dm y)
{
	dm z;
    z.mtr=y.mtr+x.ft*0.3048;
    z.cmtr=y.cmtr+x.inchs*2.54;

    float t=z.mtr-int(z.mtr);
	z.mtr-=t,z.cmtr+=t*100;
    z.mtr+=int(z.cmtr)/100;
	t=z.cmtr-int(z.cmtr);
    z.cmtr=int(z.cmtr)%100+t;

    return(z);
}


db add_dmtodb(dm x,db y)
{
	db z;
    z.ft=y.ft+x.mtr*3.2808;
    z.inchs=y.inchs+x.cmtr*0.3937;

    float t=z.ft-int(z.ft);
    z.ft-=t,z.inchs+=t*12;
    z.ft+=int(z.inchs)/12;
    t=z.inchs-int(z.inchs);
    z.inchs=int(z.inchs)%12+t;

    return(z);
}