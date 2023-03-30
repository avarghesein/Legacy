Release Note of COBOL-85 (DOS)


Version : 2.01 			          Date : 22nd Mar,2000



This file contains the information relating to the following aspects:


1.     The version of COBOL-85 compiler.
2.     System requirements for COBOL-85 Compiler (Hardware & Software).
3.     Contents of the package.
4.     Installation notes.
5.     Modification and Addition.
6.     Y2K Problem and SOFTEK's COBOL
7.     Errata.
8.     Our Contact Addresses & Phone numbers.


Printing read.me file

You can print this read.me file on your printer by giving the following command

        C:\>PRINT READ.ME



1.   COBOL-85 Version

This version of COBOL-85 is meant for DOS 3.2 or above operating systems. The detailed features are described in the manual.


2.   System Requirements

* Any IBM PC, PC-XT, PC-AT running DOS 3.2 or above.
* At lease 512KB user memory.
* Floppy drive capable of reading 1.44 MB (135 TPI) double sided high density floppies (PC compatible).
* Hard disk and Printer (optional).


3.   Contents of the Package

* One 1.44 MB diskette containing COBOL-85 system in DOS format.
* Documentation consisting of User Guide and Reference Manual.
* A Registration Card, which you must fill and should immediately post to Softek. This would entitle you to future support of the product. For your convenience this registration card is postage prepaid. 

        The files present on the diskettes are listed below.
         COBOL-85 Diskette 1 of 2

          	Filename	Description		Filesize
             ----------------------------------------------------------------
          	COBOL3.EXE	The COBOL-85 Compiler.	        345446 bytes
		SCDB3.EXE	The source-level debugger.	416593 bytes
		SCRUX.EXE	The screen management utility.	144940 bytes
	
COBOL-85 Diskette 1 of 2
	
Filename	Description					Filesize
----------------------------------------------------------------------------

CRUN3.EXE	The COBOL-85 Runtime system.   			592098 bytes
UTLIDX.EXE	The index file creation utility.		254360 bytes
CETF		The COBOL-85 Error template file  		26635 bytes
SAMPLE.COB	Sample COBOL program.		  		20475 bytes
DATE.COB	Sample COBOL program.	            		212 bytes
Y2K.COB		Sample COBOL program		     		649 bytes
COBTEMP1	First template file used by SCRUX for 
		generating COBOL program.	     		440 bytes
COBTEMP2	Second template file used by SCRUX for
		generating COBOL program.	   		8347 bytes
README.TXT	Contains the information regarding 
		the contents of the Compiler	     		9336 bytes
		system. This is the same file which 
		you are currently viewing.


4.   Installation Notes

* Please refer to Chapter 3 of the User Guide Before you use COBOL-85 Compiler on your computer system, you should make a working copy of the software on another set of diskette. The procedure to make a working copy is explained in Chapter 3 of the User Guide titled Getting Started.
* For Screen Utility (SCRUX.EXE), COBDIR has to be set to the directory where the template files COBTEMP1 and COBTEMP2 exist. For example, 

		       set COBDIR=C:\COBOL\

* For ERROR printing COBERR (Cobol error environment variable) has to be set to the directory where CETF file exists, otherwise only a template error containing line number, column number, and name will be printed and the expanded error message will not be printed. For example,
                		
		       set COBERR=C:\COBOL\

        This can be stored in AUTOEXEC.BAT so that this variable are set whenever the machine is booted.	



5.   Modification and Addition

* A new Keyword CURRENT-DATE has been added to read system date in eight digits. Please see y2k.cob (shipped in 2nd floppy) for details.

* A new compiler switch ( -date ) has been added which when used along with (-xref) and (-li) flags, gives listing of those variables and their references in the program  which are annonated with @ in DATA division. Please see y2k.cob(shipped in 2nd floppy) for details .

* A new runtime switch (-m) has been added to suppress the sign on message. This is in addition to (-s) message. 

* A new runtime switch (-e) has been added to detect illegal characters in the case of numeric field. It will cause  crun3 to terminate when we encounter non-numeric characters in source of a numeric entry.

* A new runtime switch (+A) has been added to set AUTOSKIP on.  If this flag is set the default accept will terminate automatically the moment it is fully filled.

* A new runtime flag (-b) has been added to run the job in background mode. In that case, the job will not get killed by pressing (Ctrl-C).

* A new key (Ctrl-Y) has been added to scdb3 as a substitute key for (Ctrl-Z) where the later doesn't work. Also (Ctrl-K) has been added as an substitute key for (Esc) where the later doesn't work.

* Perform stack is given in a file PERFORM.ERR in case of perform stack overflow.

* Perform nesting has been increased from 32 to 128.

* Line sequential files can be opened in I-O mode. File level locking and record level locking have been provided.

* Three  additional options have been provided in Utlidx, i.e. Line sequential to sequential file, Sequential to line sequential file conversion and Statistical information..



6.     Y2K Problem and Softek Cobol
					
Softek Cobol incorporates features that helps the software developers to locate Y2K problems in their applications and to fix them.

Impact Analysis

Softek COBOL provides a facility to identify the location of date variable references in the existing applications. The developer has to first identify date fields in a program and mark their definition by putting '@' symbol in the first column of the line containg date field definition. Date fields could be identified by going through various documents and source code. Softek COBOL compiler will then list all the reference of the date fields in the program. Further the data files which are based on the data in the program have to be reviewed to identify those files which need to be modified. At the end of this phase, one will know all the places in the application where changes have to be made. At this stage, one can estimate the effort and time required to carry out the modification and testing. For example, date.cob

	working-storage section.

@    01  date-var.
procedure division.
move date-var to data-1.The COBOL program given above is compiled as follows -

cobol3 date.cob -date -xref -li

It produces the following list file (date.lst) along with date.crn file.

 SOFTEK COBOL V1.005 SOURCE:  date.cob          DATE 16 Jul 98   TIME 16:30:17       PAGE: 00001
 
    1   working-storage section.
    2   01  date-var.
    3        02    month-1   pic x(2).
    4        02    date-1    pic x(2).
    5        02    year-1    pic x(2).
    6   77 data-1 pic  x(6).
    7   procedure division.
    8   move date-var to data-1.
date.crn is created.

Variable         Defined      Refrence
--------         -------      --------
DATA-1              6              8
DATE-1              4
DATE-VAR            2              8
MONTH-1             3
YEAR-1               

 SOFTEK COBOL V1.005 SOURCE:  date.cob          DATE 16 Jul 98   TIME 16:30:17       PAGE: 00002
date   object is generated



Four Digit Year using CURRENT-DATE


COBOL allows the developer to get the system date in YYMMDD format using ACCEPT <variable> FROM DATE. As the year has only 2 digits, this construct cannot be used for dates after Dec 31, 1999. To get over this problem, this version of Softek COBOL provides a new construct ACCEPT <variable> FROM CURRENT-DATE. This will return the date in YYYYMMDD format allowing the developer to manipulate dates beyond Dec 31,1999. A sample program highlighting the use of this is given below.


Y2k.cob
	working-storage section.
		display "OUTPUT " at 0508 with blink.
		display "DATE " at 0537 with blink.
		accept date1 from current-date.
		display "DATE OUTPUT IN EIGHT DIGITS :" at 1001.
		display date1 at 1035.
		accept date2 from date.
		display "DATE OUTPUT IN SIX DIGITS   :" at 2001.
		display date2 at 2035.



7.   Errata

a)	Please refer to Chapter 3 titled, Getting Started in the User Guide and make a note of the following corrections.

	Page 3-1 Section 3-4 (Installing Softek Cobol)

	Floppy drive capable of reading 48TPI double sided double density 5-1/4" floppies.

b)     	READ PREVIOUS statement has not been implemented in Softek's COBOL. 
	However, by mistake some references, for READ PREVIOUS have been 
	made in the SOFTEK COBOL-85 RELEASE III manual. Therefore, please 
	ignore all references to READ PREVIOUS statement in this manual 
	(Page no. 10-33 & index-12).




8.   Address for Communication

In case of problem, please get in touch with your hardware/software vendor or contact us at any of the following addresses :





			       SOFTEK LIMITED

	  Head Office : M-42, Commercial Complex, Greater Kailash - II,
  	                     New Delhi - 110048.
			Phone 	: 6415312, 6447308
			Fax	: 91-(011) 6482680

	Development Office : 1 Club Road, Anupam Garden, IGNOU Road,
	 	             New Delhi - 110068
			Phone 	: 6565902,6565904
			Fax	: 91-(011) 6561683

