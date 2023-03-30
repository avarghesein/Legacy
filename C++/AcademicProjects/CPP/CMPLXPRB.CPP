
#include"e:\tc\bin\cpp\cmplx.cpp"


void main()
{
cmplx a,b,c;
clrscr();

	int w=1;
    while(w!=9)
    {
    	cout<<"\n\n1=>+,2=>-,3=>*,4=>/,5=>+=,6=>/=,7=>*=,8=>-=,9-exit:";
        cin>>w;
        if(w==9) continue;
        cout<<"\ncomplex1\n",a.read(),cout<<"\ncomplex2\n",b.read();
        switch(w)
        {
        	case 1:c=a+b,c.print();break;
            case 2:c=a-b,c.print();break;
            case 3:c=a*b,c.print();break;
            case 4:c=a/b,c.print();break;
            case 5:c=(a+=b),a.print();break;
            case 6:c=(a/=b),a.print();break;
            case 7:c=(a*=b),a.print();break;
            case 8:c=(a-=b),a.print();break;
            case 9:break;
            default:cout<<"\nError in choice";
        }
    }
}
