
#include "\tc\bin\viju's\sourse\FILE.c"
#include "\tc\bin\viju's\sourse\statfuns.c"
void main()
{
char name[20];
int n,i;
double x[100],y[100];
clrscr();

/*-----------ONLY NEEDED FOR 1ST TIME ENTERING DATA THROUG KEY BOARD
AFTER ON WE CAN MODIFY FILE ---------------------------------/

printf("\nEnter number of observations:");
scanf("%d",&n);
printf("Enter xi's & yi's:\n");
writefilenormal("stat.txt",n);
----------------------------------------------------------------*/
printf("\n\nEnter the sourse filename with extension which contains data:");
flushall(),scanf("%s",name);
n=readfilenormal(name,x,y);
if(n==0) printf("\n\nError,Readed items=0:"),getch(),exit();
printf("\n\nReaded data=%d\n\nx\t\t\ty\n",n);for(i=0;i<n;i++) printf("\n%lf\t\t%lf",x[i],y[i]);
printf("\n\n\nRank correlation=%lf",rankcorrelation(x,y,n));
getch();
}

