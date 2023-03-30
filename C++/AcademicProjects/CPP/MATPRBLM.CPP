#include"e:\tc\bin\cpp\matx.cpp"

void main()
{

clrscr();
/*
cout<<"Enter dimmension for the 2 matrices:";
int r1,c1,r2,c2;
cin>>r1>>c1>>r2>>c2;
matx x(r1,c1),y(r2,c2),z;
x.read(),y.read();

	z=x+y;
    z.print();
    getch();
*/
matx()=3;
matx(matx(matx(2,3)))=matx(matx(3,3));
matx x=(2,2);
matx a(2);
matx y=a;
matx z=matx(x);
matx w(x);
x=y=w=3;
x=y;
x=(2,2);
x=matx(y);
int tmp=4;
x=tmp;
x=matx(tmp);
matx()=x;
matx (2,2)=x;
matx(x)=y;
matx(x)=matx(y);
matx(2,2)=matx(3,3);

}