
#include<iostream.h>
#include<conio.h>

class cmplx
{
 private: float re,im;
 public:
        cmplx(float real=0,float ima=0) { re=real,im=ima;cout<<"\nconstruct "<<re<<"+i"<<im<<"\n";getch(); }
        cmplx(cmplx &x) { re=x.re,im=x.im;cout<<"\nconstruct "<<re<<"+i"<<im<<"\n";getch(); }
        friend cmplx operator+(cmplx,cmplx);
        friend cmplx operator-(cmplx,cmplx);
        friend cmplx operator*(cmplx,cmplx);
        friend cmplx operator/(cmplx,cmplx);
        friend cmplx operator+=(cmplx&,cmplx);
        friend cmplx operator-=(cmplx&,cmplx);
        friend cmplx operator*=(cmplx&,cmplx);
        friend cmplx operator/=(cmplx&,cmplx);
        friend cmplx operator++(cmplx&);
        friend cmplx operator--(cmplx&);
        friend cmplx operator-(cmplx&);
               cmplx &operator=(cmplx&);
        ~cmplx(){cout<<"\ndestructing "<<re<<"+i"<<im,getch();}
        void   read(void);
        void   print(void);
};


cmplx &cmplx::operator=(cmplx &x)
{
	re=x.re,im=x.im;
    return x;
}
void cmplx::read(void)
{
    cout<<"Enter real & imaginary parts:";
	cin>>re>>im;
    return;
}


void cmplx::print(void)
{
	if(im<0) cout<<re<<"-i"<<-im;
    else     cout<<re<<"+i"<<im;
	return;
}

cmplx operator+(cmplx c1,cmplx c2)
{
	return cmplx((c1.re+c2.re),(c1.im+c2.im));
}

cmplx operator-(cmplx c1,cmplx c2)
{
	return cmplx((c1.re-c2.re),(c1.im-c2.im));
}

cmplx operator*(cmplx c1,cmplx c2)
{
	return cmplx((c1.re*c2.re-c1.im*c2.im),(c1.re*c2.im+c2.re*c1.im));
}

cmplx operator/(cmplx c1,cmplx c2)
{
    float t=c2.re*c2.re+c2.im*c2.im;
	return cmplx((c1.re*c2.re+c1.im*c2.im)/t,(c2.re*c1.im-c2.im*c1.re)/t);
}

cmplx operator+=(cmplx &c1,cmplx c2)
{
    c1=c1+c2;
	return c1;
}

cmplx operator-=(cmplx &c1,cmplx c2)
{
    c1=c1-c2;
	return c1;
}


cmplx operator*=(cmplx &c1,cmplx c2)
{
    c1=c1*c2;
	return c1;
}


cmplx operator/=(cmplx &c1,cmplx c2)
{
    c1=c1/c2;
	return c1;
}


cmplx operator++(cmplx &c1)
{
	c1.re++,c1.im++;
    return cmplx(c1.re,c1.im);
}


cmplx operator--(cmplx &c1)
{
	c1.re--,c1.im--;
    return cmplx(c1.re,c1.im);
}

cmplx operator-(cmplx &c1)
{
	c1.re*=-1,c1.im*=-1;
    return cmplx(c1.re,c1.im);
}