/*-----------SHEPERD'S RANK CORRELATION COEFFICIENT FOR REPEATED MARKS----*/
 #include<stdio.h>
 void main()
 {
 int i,j,c1,c2,e1,e2,x[20],y[20],r1,r2,n;
 float s,r,m1,m2,d2,or1,or2;
 clrscr();
 printf("Enter no of nos(MUST BE GREATER THAN 1):\n");
 scanf("%d",&n);
 printf("Enter nos for X:\n");
 for(i=0;i<n;i++) scanf("%d",&x[i]);
 printf("\nEnter nos for Y:\n");
 for(i=0;i<n;i++) scanf("%d",&y[i]);

/*------CALCULATION OF RANK CORRELATION STARTS--------------*/
 for(s=0,i=0;i<n;i++)
 {	 c1=c2=0;
      e1=e2=1;
      for(j=0;j<n;j++)
      {   	if(x[i]>x[j]) c1++;
          	if(i!=j&&x[i]==x[j]) e1++;
               if(y[i]>y[j]) c2++;
               if(i!=j&&y[i]==y[j]) e2++;
      }
      r1=n-c1;r2=n-c2;
      for(or1=0,j=1;j<=e1;j++,r1--) or1+=(r1/e1);
      for(or2=0,j=1;j<=e2;j++,r2--) or2+=(r2/e2);
      d2=(or1-or2)*(or1-or2);
      m1=(e1*e1-1)/12;
      m2=(e2*e2-1)/12;
      s+=d2+m1+m2;
 }
 r=1-(6*s/(n*(n*n-1)));
/*------CALCULATION OF RANK CORRELATION ENDS--------------*/

 printf("\nThe RANK correlation coefficient is %f",r);
 getch();
 }