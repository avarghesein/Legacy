

    #include"alloc.h"
    #define MAXROW 3
    #define MAXCOL 8
    main()
    {
    float (*p)[MAXCOL];
    p=(float(*)[MAXCOL]) malloc(MAXROW *sizeof(*p));
    clrscr(),printf("%d %d",sizeof(p),sizeof(*p)),getch();
     }









   extern struct s;
    struct s
			    {
				int i;
				float p;
			    };

   void f(int y)
  {
	struct s *ptr;
	ptr = malloc (sizeof(struct s)+99*sizeof(int));
   }

