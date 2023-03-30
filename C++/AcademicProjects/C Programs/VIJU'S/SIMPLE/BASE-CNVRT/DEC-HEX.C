//--------------DECIMAL TO HEXA-DECIMAL-------------//

void main()
{
double dec,fl;
int inte,x[20],y[20],i=-1,j=-1,k;
clrscr();
printf("Enter decimal number:");
scanf("%lf",&dec);
inte=dec;fl=dec-inte;

while(inte>0)
	x[++i]=inte%16,inte/=16;
while(fl!=0&&j<=15)
	  y[++j]=(fl=fl*16),fl=fl-y[j];


printf("\n\n\nEntered decimal=%f\n\n\nCorresponding hexadecimal-number=",dec);

printf("0");
for(k=i;k>=0;k--)
	if(x[k]>9) printf("%c",x[k]-10+65);
	else printf("%d",x[k]);
printf(".");
for(k=0;k<j;k++)
   if(y[k]>9) printf("%c",y[k]-10+65);
   else printf("%d",y[k]);
printf("0");

getch();
}

