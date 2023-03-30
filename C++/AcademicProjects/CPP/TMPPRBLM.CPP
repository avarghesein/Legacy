
#include"e:\tc\bin\cpp\inc\template.cpp"

void main()
{

clrscr();

cout<<"\nEnter r,c:";
int r,c;
cin>>r>>c;
matx <float> m(r,c),canon;
matx <double> *xy=(matx<double> *)&m,*yz=(matx<double> *)&canon;
cin>>m;

cout<<"\nRank="<<rowcanonicalof(*xy,*yz)<<"\n"<<canon;

getch();
}