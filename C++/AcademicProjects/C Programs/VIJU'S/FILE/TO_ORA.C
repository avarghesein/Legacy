#include<string.h>
#include<stdlib.h>
#include<stdio.h>

void main()
{
FILE *p,*q;
int flg,i,k,prompt,re,in;
char tmp[1000],tmp1[1000],tmp2[1000],c;

  clrscr();
  printf("\nEnter the Source file(with extension):"),scanf("%s",tmp);
  printf("\nEnter the Destination file(with extension):"),scanf("%s",tmp1);
  printf("\nEnter Non-zero value for prompting Field Sizes for numeric fields:");
  scanf("%d",&prompt);
  if(!prompt)
	printf("\nEnter default field width for Integer & Real Parts\n"),
	scanf("%d%d",&in,&re);

  p=fopen(tmp,"r"),q=fopen(tmp1,"w");
  fseek(p,0,SEEK_SET);
  while(k=ftell(p),fscanf(p,"%s",tmp),k!=-1&&!feof(p))
  {
	fputc(' ',q);
	if(tmp[0]=='l' || tmp[0]=='l'||tmp[0]=='D' || tmp[0]=='d')
	{
	     for(i=0;i<strlen(tmp);i++) tmp[i]=tolower(tmp[i]);
	     if(tmp[0]=='l') flg=0; else flg=1;
	     for(i=0;tmp[i]!='\0' && (!flg&&i<=3||flg&&i<=5);i++)
			tmp1[i]=tmp[i];
	     tmp1[i]='\0';
	     if((!flg&&!strcmp(tmp1,"long")) || (flg&&!strcmp(tmp1,"double")))
	     {
		fseek(p,k,SEEK_SET);
		while(c=fgetc(p),c!=EOF && c==' ') k++;
		k+=strlen(tmp1);
		while(tmp[i]!='\0' && tmp[i]!=')')
			  k++,i++;

		if(!prompt)
		      if(!flg)
				fprintf(q," number(%d)",in);
		      else
				 fprintf(q," number(%d,%d)",in,re);
		else
		    if(printf("\nEnter field width/widths for Following Expression\n%s\n",tmp2),scanf("%d",&in),!flg)
			  fprintf(q," number(%d)",in);
		    else
			  scanf("%d",re),fprintf(q," number(%d,%d)",in,re);


		k++,fseek(p,k,SEEK_SET);
		continue;
	     }

	}
	if(tmp[0]=='c' || tmp[0]=='C'||tmp[0]=='t'||tmp[0]=='T')
	{

	     for(i=0;i<strlen(tmp);i++) tmp[i]=tolower(tmp[i]);
	     for(i=0;tmp[i]!='\0' && i<=3;i++) tmp1[i]=tmp[i];
	     tmp1[i]='\0';
	     if(!strcmp(tmp1,"text") || !strcmp(tmp1,"char"))
	     {
		fseek(p,k,SEEK_SET);
		while(c=fgetc(p),c!=EOF && c==' ') k++;
		fprintf(q," varchar2");
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

	strcpy(tmp2,tmp);

}
fclose(p);
fclose(q);
printf("\nProgram End");
getch();
}