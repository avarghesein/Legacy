
#include"e:\tc\bin\cpp\manemp.cpp"

void main()
{
clrscr();

	int w=1;
    while(w!=4)
    {
    	cout<<"\n\n1-Employee,2-manager,3-sales_person processing";
        cout<<",4-exit:",cin>>w;
        switch(w)
        {
        	case 1:
            		employee e;
                    e.getemployee(),e.putemployee();
                    break;
            case 2:
            		manager m;
                    m.getmanager(),m.putmanager();
                    break;
            case 3:
            		sales_person s;
                    s.getsales_person(),s.putsales_person();
                    break;
            case 4:break;
            default:cout<<"\nError in choice";
        }
    }
}