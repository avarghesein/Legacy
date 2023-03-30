#include<string.h>
#include<stdlib.h>
#include<stdio.h>

void main()
{
FILE *p,*q;
int flg,i,k;
char tmp[1000],tmp1[1000],c;

  clrscr();
  printf("\nEnter the Source file(with extension):"),scanf("%s",tmp);
  printf("\nEnter the Destination file(with extension):"),scanf("%s",tmp1);
  p=fopen(tmp,"r"),q=fopen(tmp1,"w");
  fseek(p,0,SEEK_SET);
  while(k=ftell(p),fscanf(p,"%s",tmp),k!=-1&&!feof(p))
  {
	fputc(' ',q);
	if(tmp[0]=='n' || tmp[0]=='N')
	{
	     fseek(p,k,SEEK_SET);
	     while(c=fgetc(p),c!=EOF && c==' ');
	     for(i=0;tmp[i]!='\0' && i<=5;i++) tmp1[i]=tmp[i];
	     tmp1[i]='\0';
	     if(!strcmp(tmp1,"number") || !strcmp(tmp1,"NUMBER"))
	     {
		fseek(p,k,SEEK_SET);
		while(c=fgetc(p),c!=EOF && c==' ') k++;
		k+=strlen(tmp1);
		flg=0;
		while(tmp[i]!='\0' && tmp[i]!=')')
		{
		  if(tmp[i]==',') flg=1;
		  k++,i++;
		}
		if(!flg) fprintf(q," long"); else
			fprintf(q," double");

		k++,fseek(p,k,SEEK_SET);
		continue;
	     }

	}
	if(tmp[0]=='V' || tmp[0]=='v')
	{
	     for(i=0;tmp[i]!='\0'&&i<=7;i++) tmp1[i]=tmp[i];
	     tmp1[i]='\0';
	     if(!strcmp(tmp1,"varchar2") || !strcmp(tmp1,"VARCHAR2"))
	     {
		fseek(p,k,SEEK_SET);
		while(c=fgetc(p),c!=EOF&&c==' ') k++;
		fprintf(q," char");
		k+=strlen(tmp1);
		while(tmp[i]!='\0' && tmp[i]!=')') fputc(tmp[i],q),k++,i++;
		fputc(')',q);
		k++,fseek(p,k,SEEK_SET);
		continue;
	     }
	}
	i=0;
	while(c=tmp[i],c!='\0')
		if(i++,c==';')  fprintf(q,"%c\n\n",c); else fprintf(q,"%c",c);

}
fclose(p);
fclose(q);
printf("\nProgram End");
getch();
}