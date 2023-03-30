
struct list
{
	char   nam[20];
	int    m[3];
	float  d;
}s[50],t;

void main()
{
int i,j,n;
clrscr();
printf("Enter number of students:");
scanf("%d",&n);
printf("\n\nEnter name,3 marks for %d students:",n);
for(i=0;i<n;i++)
{	scanf("%s",(*(s+i)).nam);
	for(s[i].d=j=0;j<3;j++)
	{	scanf("%d",&s[i].m[j]);
		s[i].d+=s[i].m[j];
	}
}

for(i=0;i<n-1;i++)
	for(j=i+1;j<n;j++)
		if(s[i].d<s[j].d)
			t=s[i],s[i]=s[j],s[j]=t;

clrscr();
printf("\n\t******RANK LIST*******\n\n");
printf("RANK\tNAME\tMARK1\tMARK2\tMARK3\tTOTAL\n\n");
for(i=0;i<n;i++)
	printf("%d\t%s\t%d\t%d\t%d\t%f\n",i+1,s[i].nam,s[i].m[0],s[i].m[1],s[i].m[2],s[i].d);
getch();
}
