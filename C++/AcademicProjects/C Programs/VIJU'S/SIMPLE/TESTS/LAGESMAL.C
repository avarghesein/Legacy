  /*-----CONDITIONAL OPERATORS--------*/

  #include<stdio.h>
  void main()
  {
   int a,b,c,l,s;
   clrscr();
   printf("Enter the 3 numbers:\n");
   scanf("%d%d%d",&a,&b,&c);
   l=(a>b)?(a>c)?a:c : (b>c)?b:c ;
   s=(a<b)?(a<c)?a:c : (b<c)?b:c ;
   printf("\nThe largest no=%d",l);
   printf("\nThe smallest no=%d",s);
   getch();
   }