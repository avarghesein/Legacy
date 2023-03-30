
#include<iostream.h>
#include<conio.h>

class ac
{
    protected:
	int a;
    public:
    void geta(void) { a=1; }
	void puta(void) { cout<<"\na in ac="<<a,getch(); }
};

class bc: virtual public ac
{
    protected:
	int b;
    public:
    	void getb(void) { geta(),cout<<"\na in bc="<<a,b=4,getch(); }
        void putb(void) { puta(),cout<<"\na in bc="<<a,getch(),cout<<"\nb="<<b,getch(); }
};

class cc: virtual public ac
{            protected:
	int c;
    public:
    	void getc(void) { geta(),cout<<"\na in cc="<<a,c=7,getch(); }
        void putc(void) { puta(),cout<<"\na in cc"<<a,getch(),cout<<"\nc="<<c,getch(); }
};

class dc:public bc,public cc
{
	int d;
    public:
    	void getd(void) { getb(),getc(),cout<<"\na in dc="<<a,getch(),
						  cout<<"\nb in dc="<<b,getch(),cout<<"\nc in dc="<<c,d=10,getch(); }
        void putd(void) { cout<<"\na in dc="<<a,getch(),putb(),putc(),/*puta(),*/cout<<"\nd="<<d,getch(); }
};


void main()
{
clrscr();

	dc d;
    d.getd();
    d.putd();
    d.ac::puta();
    d.dc::puta();
    d.bc::puta();         //--a to dc is from cc;
    d.cc::puta();
    getch();
}