   /*------FIBONACCI SERIES 112358...*/
   
   #include<stdio.h>
   void main()
   {
	int f1,f2,f3,i,n;
	clrscr();
	printf("Enter no of terms\n  ");
	scanf("%d",&n);
	f1=0;f2=1;f3=1;i=1;
	printf("THE FIBONCCI SERIES UP TO %d TERMS \n\n",n);
	printf("%d  \n",1);
	while(i<=n-1)
	{
		printf("%d \n",f3);
		f1=f2;
		f2=f3;
		f3=f1+f2;
		i=i+1;
	}
	getch();
   }
