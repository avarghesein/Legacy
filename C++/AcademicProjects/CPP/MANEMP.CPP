
#include<iostream.h>
#include<conio.h>

class person
{
	protected:
    	float bonous;
    private:
    	char name[25];
        int  id,dep_no;
    public:
    	void getperson(void);
        void putperson(void);
};


void person::getperson(void)
{
	cout<<"\nEnter Name,id,dep_no of the person:",cin>>name>>id>>dep_no;
    return;
}

void person::putperson(void)
{
	cout<<"\nName:"<<name<<"\npersonal_id:"<<id<<"\nDep_no:"<<dep_no;
    return;
}


class employee:virtual public person
{
	protected:
    	int sale;
    public:
    	void getemployee(void);
        void putemployee(void);
};

void employee::getemployee(void)
{
    cout<<"\nEnter details of Employee\n-------------------------";
	getperson();
    cout<<"\nEnter sales for employee:",cin>>sale;
    bonous=0.1*sale;
    return;
}

void employee::putemployee(void)
{
	cout<<"\nEmployee Details\n----------------";
	putperson();
    cout<<"\nSales:"<<sale<<"\nBonous:"<<bonous;
    return;
}


class manager:virtual public person
{
	protected:
    	int yoe;
    public:
    	void getmanager(void);
        void putmanager(void);
};


void manager::getmanager(void)
{
    cout<<"\nEnter details of Manager\n------------------------";
	getperson();
    cout<<"\nEnter year of experience of manager:",cin>>yoe;
    bonous=100*yoe;
    return;
}

void manager::putmanager(void)
{
    cout<<"\nManager Details\n---------------";
	putperson();
    cout<<"\nYear of experience:"<<yoe<<"\nBonous:"<<bonous;
    return;
}


class sales_person:private employee,private manager
{
	public:
    	void getsales_person(void);
        void putsales_person(void);
};

void sales_person::getsales_person(void)
{
    cout<<"\nEnter details for Sales_person\n------------------------------";
	getperson();
    cout<<"\nEnter sales,year of experience:";
    cin>>sale>>yoe;
    bonous=0.1*sale+100*yoe;
    return;
}

void sales_person::putsales_person(void)
{
    cout<<"\nSales_person Details\n--------------------";
	putperson();
    cout<<"\nSales:"<<sale<<"\nYear of experience:"<<yoe
    	<<"\nBonous:"<<bonous;

    return;
}