#pragma loop_opt(on)
#define comb(x,y) printf("\n" #x"[%d]=%d",y,x##[##y##])
#define combine(x,y) printf(#x#y"=%d",x##y)
#define print(x,y) printf(#x","#y" ARE %d,%d",x,y)
#define comb1(x,y) printf("\n" #x#y"=%d",x##y)

void main()
{
int k[30],i;
int a5=20,b20=33,b453=303;
clrscr();

	print(3+2,4+5);
	printf("\n");
	combine(a,5);
	printf("\n");
	combine(b2,0);
	printf("\n");
	combine(b,453);
	getch();
	clrscr();
	comb1(k,[8]);
	printf("\nArray printed");

	for(i=0;i<=20;i++) comb(k,i);
	getch();

}