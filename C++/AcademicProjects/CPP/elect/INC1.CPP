  #include<fstream.h>
  #include<iostream.h>
  #include<stdio.h>
  #include<graphics.h>
  #include<conio.h>
  #include<string.h>
  #include<stdlib.h>
  #include<dos.h>


enum boolean{false,true};

class person
{
    private:
	char name[35];
	long id;
	int age;
	char sex[2];
	char house[35];
	char street[35];
	char district[35];
	char state[35];
	boolean voted;
	long  pin;

    public:
	friend istream &operator>>(istream&,person&);
	friend ostream &operator<<(ostream&,person&);
	friend fstream &operator>>(fstream&,person&);
	friend fstream &operator<<(fstream&,person&);
	char *getname()
	{
		return name;
	}
	boolean getvoted()
	{
		return voted;
	}
	boolean putvoted(boolean b)
	{	voted=b;	}
	void putname(char *n)
	{
		strcpy(name,n);
	}
	long getid()
	{
		return id;
	}
	void putid(long pid)
	{
		id=pid;
	}
	long int getmaxidperson(char*);
};

long int l=sizeof(person);

class candidate:public person
{
  private:
	 char symbol;
	 unsigned long vote_cnt;
  public:
	friend istream &operator>>(istream&,candidate&);
	friend ostream &operator<<(ostream&,candidate&);
	friend ostream &operator<<(ostream&,candidate&);
	friend fstream &operator<<(fstream&,candidate&);
	friend fstream &operator>>(fstream&,candidate&);
	void inc_vote(char,person&);
	boolean is_valid_person(char*,person&);
	boolean is_symbol_xists(char*);
	boolean valid_voter(person&);
	void reset_show(char*);
	friend class menu;
};

long int lc=sizeof(candidate);

void candidate::inc_vote(char c,person &per)
{
candidate p;
person per1;
fstream f("can.txt",ios::binary|ios::in|ios::out);
fstream f1("person.txt",ios::binary|ios::in|ios::out);

	if (f==0) return;
	f.clear();
	f.seekg(0);
	while(f.read((char*)&p,lc))
		if(p.symbol==c)
		{
			f.clear();
			p.vote_cnt+=1;
				f1.clear();
				while(f1.read((char*)&per1,l))
				    if(per.getid()==per1.getid())
				       {
						f1.clear(),per1.putvoted(true),f1.seekp(-l,ios::cur),
						f1.write((char*)&per1,l);
						break;
				       }

			f.seekp(-lc,ios::cur);
			f.write((char*)&p,lc);
			f.close();
			f1.close();
			return;
		}
	f.close();
	f1.close();
	return;
}


ostream &operator<<(ostream &out,candidate &ca)
{
char tmp[200];
int i=25;

	sprintf(tmp,"NAME:%s",ca.getname());
	outtextxy(25,i,tmp);
	sprintf(tmp,"ID:%ld",ca.getid());
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"ID:%c",ca.symbol);
	outtextxy(25,i+=50,tmp);

	return out;

}
ostream &operator<<(ostream &out,person &p)
{
char tmp[200];
int i=25;

	sprintf(tmp,"NAME:%s",p.name);
	outtextxy(25,i,tmp);
	sprintf(tmp,"HOUSE:%s",p.house);
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"STREET:%s",p.street);
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"DISTRICT:%s",p.district);
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"STATE:%s",p.state);
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"PIN:%ld",p.pin);
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"AGE:%d",p.age);
	outtextxy(25,i+=50,tmp);
	sprintf(tmp,"SEX:%c",p.sex[0]);
	outtextxy(25,i+=50,tmp);

	sprintf(tmp,"ID:%ld",p.id);
	outtextxy(25,i+=50,tmp);

	return out;
}

fstream &operator>>(fstream &fin,candidate &c)
{
	fin.read((char*)&c,lc);
	return fin;
}

fstream &operator<<(fstream &fin,candidate &ca)
{
	fin.clear();
	fin.write((char*)&ca,lc);
	return fin;
}

boolean candidate::is_symbol_xists(char *fname)
{
candidate p;
fstream f(fname,ios::binary|ios::in);

	if (f==0) return false;
	f.clear();
	f.seekg(0);
	while(f.read((char*)&p,l))
		if(p.symbol==symbol||p.getid()==getid())
		{
			f.close();
			return true;
		}
	f.close();
	return false;
}

boolean candidate::is_valid_person(char *fname,person &p)
{
fstream f(fname,ios::binary|ios::in);

	if (f==0) return false;
	f.clear();
	f.seekg(0);
	while(f.read((char*)&p,l))
		if(p.getid()==getid())
		{       f.close();
			return true;
		}
	f.close();
	return false;
}

boolean candidate::valid_voter(person &p)
{
char tmp[50];
long pid;
int i;
boolean flg;
int j=50;

	cleardevice(),outtextxy(25,j,"ENTER PERSON-ID:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("ENTER PERSON-ID:"),j,tmp);
	tmp[i-1]='\0';
	sscanf(tmp,"%ld",&pid);
	putid(pid);
	flg=is_valid_person("PERSON.TXT",p);
	if (!flg||p.getvoted())
	{
		cleardevice(),outtextxy(50,getmaxy()/2.0-20,"INVALID PERSON,ENTRY REJECTED"),getch();
		return false;
	}
	else return true;
}


istream &operator>>(istream &in,candidate &ca)
{
char tmp[50];
long pid;
int i;
char c;
boolean flg;
person p;
int j=50;

	outtextxy(25,j,"ENTER PERSON-ID:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("ENTER PERSON-ID:"),j,tmp);
	tmp[i-1]='\0';
	sscanf(tmp,"%ld",&pid);
	ca.putid(pid);
	flg=ca.is_valid_person("PERSON.TXT",p);
	if (!flg)
	{
		cleardevice(),outtextxy(50,getmaxy()/2.0-20,"INVALID PERSON,ENTRY REJECTED"),getch();
		return in;
	}
	else
	{
		ca.putname(p.getname());
		outtextxy(25,j+=50,"ENTER SYMBOL(SPECIAL CHARACTERS):");
		i=0;
		while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("ENTER SYMBOL(SPECIAL CHARACTERS):"),j,tmp);
		tmp[i-1]='\0';
		c=tmp[0];
		if (strlen(tmp)>1 || !(c=='~'||c=='!'||c=='@'||c=='#'||c=='$'||c=='%'||c=='^'||c=='&'||c=='*'||c=='+'||c=='='||c=='|'||c=='-'))
		{
			cleardevice(),outtextxy(getmaxx()/3,getmaxy()/2.0-20,"INVALID SYMBOL,ENTRY REJECTED"),getch();
			return in;
		}

		ca.symbol=c;
		flg=ca.is_symbol_xists("can.txt");
		if (flg)
		{
			cleardevice(),outtextxy(50,getmaxy()/2.0-20,"SYMBOL/ID ALREADY ALLOCATED,ENTRY REJECTED"),getch();
			return in;
		}
		ca.vote_cnt=0;
		fstream f("can.txt",ios::binary|ios::app|ios::in);
		f<<ca;
		f.close();
		return in;
	}
}

istream &operator>>(istream &in,person &p)
{
char tmp[200];
int i;
int j=50;
	p.id=p.getmaxidperson("PERSON.txt");

	outtextxy(25,j,"NAME:"),
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("NAME:"),j,tmp);
	tmp[i-1]='\0';
	strcpy(p.name,tmp);
	outtextxy(25,j+=50,"HOUSE:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("HOUSE:"),j,tmp);
	tmp[i-1]='\0';
	strcpy(p.house,tmp);

	outtextxy(25,j+=50,"STREET:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("STREET:"),j,tmp);
	tmp[i-1]='\0';
	strcpy(p.street,tmp);

	outtextxy(25,j+=50,"DISTRICT:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("DISTRICT:"),j,tmp);
	tmp[i-1]='\0';
	strcpy(p.district,tmp);

	outtextxy(25,j+=50,"STATE:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("STATE:"),j,tmp);
	tmp[i-1]='\0';
	strcpy(p.state,tmp);

	outtextxy(25,j+=50,"AGE:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("AGE:"),j,tmp);
	tmp[i-1]='\0';
	sscanf(tmp,"%d",&p.age);

	outtextxy(25,j+=50,"SEX(M/F):");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("SEX(M/F):"),j,tmp);
	tmp[i-1]='\0';
	p.sex[0]=tmp[0];
	p.sex[1]='\0';
	outtextxy(25,j+=50,"PIN:");
	i=0;
	while ((tmp[i++]=getch())!=13)tmp[i]='\0',outtextxy(25+textwidth("PIN:"),j,tmp);
	tmp[i-1]='\0';
	sscanf(tmp,"%ld",&p.pin);
	p.voted=false;
	return in;
}


long int person::getmaxidperson(char *fname)
{
person p;
long int maxid=1000;
int flg;
fstream f(fname,ios::binary|ios::in);

	if (f==0)
		return maxid;
	else
	{
		flg=0;
		f.clear();
		f.seekg(0);
		while (f.read((char*)&p,l))
			maxid=(flg=0?p.id:maxid<p.id?p.id:maxid),flg=1;

		maxid=maxid+1;
		f.close();

	}
	return maxid;
}


fstream &operator<<(fstream &fin,person &p)
{
char tmp[100];
	cleardevice();
	if (p.age<18) outtextxy(getmaxx()/3,getmaxy()/2.0-20,"INVALID AGE,ENTRY REJECTED"),getch();
	else
	    if (!(p.sex[0]=='M' ||p.sex[0]=='F' || p.sex[0]=='m'||p.sex[0]=='f'))
		outtextxy(getmaxx()/3,getmaxy()/2.0-20,"INVALID SEX,ENTRY REJECTED"),getch();
	    else
		fin.clear(),
		fin.write((char*)&p,l),outtextxy(getmaxx()/3,getmaxy()/2.0-20,"ENTRY ACCEPTED"),
		sprintf(tmp,"ID PROVIDED:%ld",p.id),
		outtextxy(getmaxx()/3,getmaxy()/2.0+30,tmp),
		getch();

	return fin;
}


fstream &operator>>(fstream &fout,person &p)
{
	fout.read((char*)&p,l);
	return fout;
}


void person_entry(void)
{
person p;
fstream f("PERSON.txt",ios::binary|ios::in|ios::out);
     char ch;
     do{
     cleardevice(),setbkcolor(LIGHTBLUE),setcolor(WHITE),outtextxy(150,20,"PERSON DETAILS");
     f.close(),cin>>p,f.open("PERSON.txt",ios::binary|ios::in|ios::out|ios::app),f<<p;
     cleardevice(),outtextxy(150,50,"press e/E to exit"),ch=getch();
     }while(ch!='e'&& ch!='E');
     cleardevice(),outtextxy(150,50,"press s/S to see persons in list"),ch=getch();

     f.clear();
     f.seekg(0);
     while(f.read((char*)&p,l)&&(ch=='s'|| ch=='S')) clearviewport(),cleardevice(),setbkcolor(LIGHTBLUE),cout<<p,ch=getch();

}

void add_can(void)
{
candidate p;

char ch;

     do{
     cleardevice(),setbkcolor(LIGHTBLUE),setcolor(WHITE),outtextxy(150,20,"CANDIDATE DETAILS");
     cin>>p;cleardevice(),outtextxy(150,50,"press e/E to exit"),ch=getch();
     }while(ch!='e'&& ch!='E');
     cleardevice(),outtextxy(150,50,"press s/S to see candidates in list"),ch=getch();

     fstream f("can.txt",ios::binary|ios::in);
     f.clear();
     f.seekg(0);
     while(f.read((char*)&p,lc)&&(ch=='s'|| ch=='S')) cleardevice(),setbkcolor(LIGHTBLUE),cout<<p,ch=getch();
     f.close();
/*setbkcolor(LIGHTBLUE);
     settextstyle(7,HORIZ_DIR,2);
     setcolor(RED);
     cleardevice();
     cin>>p;
     cleardevice();
     fstream f("can.txt",ios::binary|ios::in);
     f.seekg(0);
     while(f.read((char*)&p,lc))   cleardevice(),
     setbkcolor(LIGHTBLUE),
     settextstyle(7,HORIZ_DIR,2),
     setcolor(RED),cout<<p,getch();
     f.close();   */
    }