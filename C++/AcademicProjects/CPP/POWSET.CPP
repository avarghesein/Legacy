
#include<iostream.h>
#include<fstream.h>
#include<conio.h>
#include<string.h>

#define ToFile    0
#define ToConsole 1

class PowerSet
{
   private:
	    static float Counter;
	    char *FileName;
	    fstream FileStream;

  public:
	    char **Set;
	    char **SubSet;
	    int  Elements;

   public:
	    PowerSet(char*,int);
	    ~PowerSet();
	    void FindPowerSet(int,int);
	    fstream &GetFileStream(void);
	    char *ProvideSeperator(int,char*);
	    friend istream &operator>>(istream&,PowerSet&);
	    friend fstream &operator<<(fstream&,PowerSet&);
	    friend ostream &operator<<(ostream&,PowerSet&);

};

  float PowerSet::Counter;

  fstream &operator<<(fstream &fout,PowerSet &obj)
  {
     int i;
     char sep[2];
     for(fout<<"\n\n   "<<++PowerSet::Counter<<": {",i=0;i<obj.Elements;i++)
	fout<<obj.ProvideSeperator(i,sep)<<obj.SubSet[i];

     fout<<"}";
     return fout;
  }

  char *PowerSet::ProvideSeperator(int upto,char* sep)
  {
    if(SubSet[upto]==0) return strcpy(sep,"");

    for(int i=upto-1;i>=0;i--)
       if(SubSet[i]!=0) return strcpy(sep,",");

    return strcpy(sep,"");
  }

  ostream &operator<<(ostream &out,PowerSet &obj)
  {
     int i;
     char sep[2];
     for(out<<"\n   "<<++PowerSet::Counter<<": {",i=0;i<obj.Elements;i++)
	out<<obj.ProvideSeperator(i,sep)<<obj.SubSet[i];

     out<<"}";
     return out;
  }

  PowerSet::PowerSet(char *FileName,int Elements)
  {
    PowerSet::Counter=0;
    this->FileName=new char[strlen(FileName)];
    strcpy(this->FileName,FileName);
    this->FileStream.open(this->FileName,ios::out);
    this->Set=new char*[this->Elements=Elements];
    this->SubSet=new char*[this->Elements];
    for(int i=0;i<this->Elements;this->SubSet[i]=0,i++);
   }

  PowerSet::~PowerSet()
  {
    for(int i=0;i<Elements;delete Set[i],i++);
    delete Set;delete SubSet;
  }

  void PowerSet::FindPowerSet(int i,int PrintWhere)
  {
     if(i>0)
       SubSet[i]=0,FindPowerSet(i-1,PrintWhere),
       SubSet[i]=Set[i],FindPowerSet(i-1,PrintWhere);
     else if(i==0)
     {
       if(SubSet[i]=0,PrintWhere==ToFile) FileStream<<*this;
       else cout<<*this;

       if(SubSet[i]=Set[i],PrintWhere==ToFile) FileStream<<*this;
       else cout<<*this;
     }

     return;
  }

  istream &operator>>(istream &in,PowerSet &obj)
  {
    char Name[50];
    cout<<"\n\nEnter "<<obj.Elements<<" elements\n\n";
    for(int i=0;i<obj.Elements;i++)
	in>>Name,
	obj.Set[i]=new char[strlen(Name)+1],
	strcpy(obj.Set[i],Name);

    return in;
  }

  fstream &PowerSet::GetFileStream(void)
  {	return FileStream;	       }




 void main(void)
 {
  clrscr();
  int cnt,place;
  char fname[20];

  cout<<"\n\nEnter Number of elements:",cin>>cnt;
  cout<<"\n\nEnter place for display(0-file/1-console):",cin>>place;
  if(place==ToFile)
    cout<<"\n\nEnter File Nmae:",cin>>fname;
  else strcpy(fname,"Default.txt");

  PowerSet p(fname,cnt);
  cin>>p;
  p.FindPowerSet(cnt-1,place);
  cout<<"\n\nEnded...",getch();
  return;
 }
