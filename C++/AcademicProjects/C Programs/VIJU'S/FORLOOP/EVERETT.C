//---------everret's interpolation for middle values------//

void main()
{


int i,j,k,n,fix;
static float x[50],f[50][50],s,term1,term2,temp1,temp2,r,q,x0;
clrscr();

printf("\nEnter no of obs:\n");
scanf("%d",&n);
printf("\nEnter all Xi's first & then Fi's:\n");

for(i=0;i<n;i++) scanf("%f",&x[i]);
for(i=0;i<n;i++) scanf("%f",&f[0][i]);



for(k=n-1,i=1;i<n;i++,k--)
	for(j=0;j<k;j++) f[i][j]=(f[i-1][j+1]-f[i-1][j]);

printf("Enter x:");
scanf("%f",&x0);

for(i=0;i<n;i++)
   if(x0<x[i]) break;

fix=(i==0?0:i-1);
r=(x0-x[fix])/(x[1]-x[0]);
q=1-r;


for(s=i=0;(2*i)<n&&fix>=0;fix--,i++)
{
	for(temp1=q+i,temp2=r+i,term1=term2=j=1;
		j<=2*i+1;j++,temp1-=1,temp2-=1) term1*=temp1/j,term2*=temp2/j;

	s+=term1*f[2*i][fix]+term2*f[2*i][fix+1];
}

printf("\n\n\nFUNCTION(%f)=%f",x0,s);
getch();
}
