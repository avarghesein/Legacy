
#include<iostream.h>
#include<conio.h>
#include<string.h>

class str
{
	private:
    	int len;
        char *p;
    public:
        str(char* ='\0');
        str(str&);
        friend str operator+(str&,str&);
        friend int operator==(str&,str&);
        friend int operator<(str&,str&);
        str &operator=(str&);
        friend ostream &operator<<(ostream&,str&);
        friend istream &operator>>(istream&,str&);
        ~str();
};

str::str(char *x)
{
	len=strlen(x);
    p=new char[len+1];
    strcpy(p,x);
}

str::str(str &x)
{
	 p=0,*this=x;
}

str operator+(str &x,str &y)
{
str z;
	z.len=x.len+y.len;
    z.p=new char[z.len+1];
    strcpy(z.p,x.p);
    strcat(z.p,y.p);
return z;
}

int operator==(str &x,str &y)
{
	if(!strcmp(x.p,y.p)) return 1;
    else return 0;
}

int operator<(str &x,str &y)
{
	if(strcmp(x.p,y.p)<0) return 1;
    else return 0;
}

str &str::operator=(str &x)
{
	if(p!=0) delete []p;
    len=x.len;
    p=new char[len+1];
    strcpy(p,x.p);
    return x;
}

ostream &operator<<(ostream &out,str &x)
{
	if(x.len!=0) out<<x.p;
    return out;
}

istream &operator>>(istream &in,str &x)
{
	char *tmp;
    in>>tmp;
    str y(tmp);
    x=y;
    return in;
}

str::~str()
{
	delete []p;
}