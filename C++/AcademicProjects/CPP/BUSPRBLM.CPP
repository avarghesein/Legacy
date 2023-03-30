
#include"e:\tc\bin\cpp\bus.cpp"

void main()
{
bus b;
b.init();
clrscr();

	int w=1,num;
    while(w!=4)
    {
     cout<<"\n0-booking,1-cancel,2-remains,3-disp,4-exit:";
     cin>>w;
     switch(w)
     	{
        	case 0:
                   cout<<"\nEnter seat no:",cin>>num;
                   b.book(num);
                   break;
            case 1:
            	   cout<<"\nEnter seat no:",cin>>num;
				   b.cancel(num);
				   break;
			case 2:
            	   cout<<"\n\nRemaining seats="<<b.remain();
                   break;
            case 3:
                   b.dis();
                   break;
            case 4:break;
            case 5:cout<<"\n\nError in choice";
        }
     }
}