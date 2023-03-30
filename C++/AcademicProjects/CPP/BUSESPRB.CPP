
#include"e:\tc\bin\cpp\buses.cpp"

void main()
{
reserve r;
clrscr();

    r.getsystem();
	int w=1,num;
    while(w!=4)
    {
     cout<<"\n1-booking,2-cancel,3-disp,4-exit:";
     cin>>w;
     switch(w)
     	{
        	case 1:
                   cout<<"\nEnter bus-code:",cin>>num;
                   r.book(num);
                   break;
            case 2:
            	   cout<<"\nEnter bus-code:",cin>>num;
				   r.cancel(num);
				   break;

            case 3:cout<<"\nEnter bus-code:",cin>>num;
                   r.display(num);
                   break;
            case 4:break;
            default:cout<<"\n\nError in choice";
        }
     }
}