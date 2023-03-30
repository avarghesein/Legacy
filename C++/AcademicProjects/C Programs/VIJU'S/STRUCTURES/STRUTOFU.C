#include<stdio.h>

struct list
{	char name[15];
	int  qnty;
	float price;
}item[100],*itemptr;

void main()
{
struct list extern *update(struct list [],int);
int i,n;
clrscr();
printf("Enter no of items:\n\n");
scanf("%d",&n);
for(i=0;i<n;i++)
{
printf("\n\n\nEnter %dth item-name:",i+1);
scanf("%s",item[i].name);
printf("Number of item:");
scanf("%d",&item[i].qnty);
printf("Price of item:");
scanf("%f",&item[i].price);
}
itemptr=update(item,n);
printf("\n\n\ndetails of item has maximum price is:\n\n");
printf("%s\t\t%d\t\t%f",itemptr->name,itemptr->qnty,itemptr->price);
getch();

}

struct list *update(struct list item[],int n)
{
int i,d,q;
float p;
d=0;
for(i=0;i<n;i++)
{	printf("\n\n\nEnter new values for %d th item\n",i+1);
	printf("Quantity increased:");
	scanf("%d",&q);
	item[i].qnty+=q;
	printf("Price increased:");
	scanf("%f",&p);
	item[i].price+=p;
	if(item[d].price<item[i].price) d=i;
}
clrscr();
printf("\n\nInventory Store\n\n");
printf("\nItem-name\tQuantity\tPrice\t\ttotal-price\n\n");
for(i=0;i<n;i++)
	printf("%s\t\t%d\t\t%f\t%f\n",item[i].name,item[i].qnty,item[i].price,item[i].price*item[i].qnty);
return(&item[d]);
}

