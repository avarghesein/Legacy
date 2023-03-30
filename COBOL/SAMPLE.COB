
        identification division.
      *--------------------------
        program-id. sample.
        remarks. tests micro-focus screen handling feature.  

        environment division.
      *-------------------------
        configuration section.
        input-output section.
        file-control.
            select bookrec assign to "book.mst"
            organization is indexed 
            access mode is dynamic
            record key is isbn
            alternate record is category
            file status is flstat.

        data division.
      *-----------------
        file section.
        fd bookrec.
        01 catalog.
           02 isbn       pic x(13).
           02 writer     pic x(20).
           02 title      pic x(20).
           02 publisher	 pic x(20).
           02 category   pic x(17).

        working-storage section.
      *------------------------- 
        01 iofail             pic 9 value 0.
        01 esc-key            pic 99 usage comp.
           88  esc value 27.  
        01 enter-key          pic 99 usage comp.
           88  enterkey value 13.
        01 flstat             pic x(2).
        01 acc-field          pic x(41).
        77 mesrecp            pic x(41) value is 
           "           PRIMARY KEY ACCESS           |".       
        77 mesrecs            pic x(41) value is 
   	   "          SECONDARY KEY ACCESS          |". 
        01 t-data.  
           05 isbnt           pic x(13) value is '             '.
           05 writert         pic x(20) value is '                    '.
           05 titlet          pic x(20) value is '                    '.
           05 publishert      pic x(20) value is '                    '.
           05 categoryt       pic x(17) value is '                 '.
        01 d-data.
           05 isbnd           pic x(13).
           05 writerd         pic x(20).
           05 titled          pic x(20).
           05 publisherd      pic x(20).
           05 categoryd       pic x(17).
        01 permanent-data-1.
           05 isbn-1          pic  x(13) value is '0-07-049138-0'.
           05 writer-1        pic  x(20) value is 'JENSEN & WIRTH      '.
           05 title-1         pic  x(20) value is 'CBASIC - User Manual'.
           05 publisher-1     pic  x(20) value is 'Springer-Verlag'.
           05 category-1      pic  x(17) value is 'CBASIC'.
        01 permanent-data-2.
           05 isbn-2          pic  x(13) value is '0-13-165183-8'.
           05 writer-2        pic  x(20) value is 'TANNENBAUM A.T      '.
           05 title-2         pic  x(20) value is 'Computer Networks   '.
           05 publisher-2     pic  x(20) value is 'Prentice-HALL       '.
           05 category-2      pic  x(17) value is 'NETWORKS'.
        01 permanent-data-3.
           05 isbn-3          pic  x(13) value is '0-13-821728-9'.
           05 writer-3        pic  x(20) value is 'GLASS & NEISEUX     '.
           05 title-3         pic  x(20) value is 'Software Maintenance'.
           05 publisher-3     pic  x(20) value is 'Prentice-HALL '.
           05 category-3      pic  x(17) value is 'SOFTWARE MAINT'.
        01 permanent-data-4.
           05 isbn-4          pic  x(13) value is '0-201-03792-1'.
           05 writer-4        pic  x(20) value is 'KRUTH D.E  '.
           05 title-4         pic  x(20) value is 'ABC of Programming  '.
           05 publisher-4     pic  x(20) value is 'Addison - Wesley'.
           05 category-4      pic  x(17) value is 'PROGRAMMING'.
        01 permanent-data-5.
           05 isbn-5          pic  x(13) value is '0-387-90144-2'.
           05 writer-5        pic  x(20) value is 'THOMSON J B  '.
           05 title-5         pic  x(20) value is 'Microcomputer Design'.
           05 publisher-5     pic  x(20) value is 'McGRAW HILL  '.
           05 category-5      pic  x(17) value is 'MICROCOMPUTERS'.
        01 ci-rec.
           02 char-in         pic 99 usage is comp.
        01 screen-user-area   pic x(50).
 
        screen section.
      *---------------- 
        01 screen-record-message.  
           05 line 23.
           05 blank line.
           05 line 23 col 0.
           05 value 'Message : '.
           05 line 23 col 10.
           05 pic x(30) from screen-user-area blink.

        01 screen-blank.
           05 blank screen.

        01 screen-record-introscr.
           05 line 1 col 15.
           05 value '+------------------------------------------------+'. 
           05 line 2 col 15.
           05 value '|                                                |'.
           05 line 3 col 15.
           05 value '|'.
           05 line 3 col 22.
           05 value 'SOFTEK' blink.
           05 line 3 col 28.
           05 value "'" blink.
           05 line 3 col 29.
           05 value 'S COBOL DEMONSTRATION PROGRAM' blink.
           05 line 3 col 64 blink.
           05 value '|'.
           05 line 4 col 15.
           05 value '|                                                |'.
           05 line 5 col 15.
           05 value '+------------------------------------------------+'. 
           05 line 6 col 15.
           05 value '+------------------------------------------------+'. 
           05 line 7 col 15.
           05 value '|                                                |'.
           05 line 8 col 15.
           05 value '|  This sample program in COBOL illustrates the  |'.
           05 line 9 col 15.
           05 value '|  usage of the following features :-            |'.
           05 line 10 col 15.
           05 value '|                                                |'.
           05 line 11 col 15.
           05 value '|  a. Screen Handling Interface (MF compatible)  |'.
           05 line 12 col 15.
           05 value '|  b. Multiple key Index Sequential File Access  |'.
           05 line 13 col 15.
           05 value '|                                                |'.
           05 line 14 col 15.
           05 value '|  You are encouraged to go through the program  |'.
           05 line 15 col 15.
           05 value '|  SAMPLE.COB and  modify  it in any manner you  |'.
           05 line 16 col 15.
           05 value '|  see fit. After modifying the program compile  |'.
           05 line 17 col 15.
           05 value '|  and execute it. This exercise  will help you  |'.
           05 line 18 col 15.
           05 value '|  in becoming more familiar with  the concepts  |'.
           05 line 19 col 15.
           05 value '|  involved.                                     |'.
           05 line 20 col 15.
           05 value '|                                                |'.
           05 line 21 col 15.
           05 value '+------------------------------------------------+'.
           05 line 22 col 15.
           05 value '|           Press any key to continue            |'.
           05 line 23 col 15.
           05 value '+------------------------------------------------+'.
           05 line 24 col 15.
           05 value '+------------------------------------------------+'. 
 
        01 screen-record-demomsg.
           05 line 1 col 0.
           05 value '+---------------------------------+'.
           05 line 2 col 0.
           05 value '|                                 |'.
           05 line 3 col 0.
           05 value '|'.            
           05 line 3 col 13.
           05 value 'SOFTEK' blink.  
           05 line 3 col is 19.
           05 value "'" blink.
           05 line 3 col is 20.
           05 value 'S' blink.
           05 line 3 col 35.
           05 value '|'.
           05 line 4 col 0.
           05 value '|'.     
           05 line 4 col 5.
           05 value 'COBOL DEMONSTRATION PROGRAM' blink.
           05 line 4 col 35.
           05 value '|'.
           05 line 5 col 0.
           05 value '|                                 |'.
           05 line 6 col 0.
           05 value '+---------------------------------+'.
 
        01 screen-record-accmsg.
           05 line 1 col 36.
           05 value '+-----------------------------------------+'.
           05 line 2 col 36.
           05 value '|                                         |'.
           05 line 3 col 36.
           05 value '|                                         |'.
           05 line 4 col 36.
           05 value '|                                         |'.
           05 line 5 col 36.
           05 value '|                                         |'.
           05 line 6 col 36.
           05 value '|  We shall now  show the access of the   |'.
           05 line 7 col 36.
           05 value '|  records in the file. First, we shall   |'.
           05 line 8 col 36.
           05 value '|  access  the records on  the basis of   |'.
           05 line 9 col 36.
           05 value '|  the primary key, (viz.) ISBN.          |'.
           05 line 10 col 36.
           05 value '|                                         |'.
           05 line 11 col 36.
           05 value '|  After that, we shall access the file   |'.
           05 line 12 col 36.
           05 value '|  based  on the  secondary  key, which   |'.
           05 line 13 col 36.
           05 value '|  is the category.                       |'.
           05 line 14 col 36.
           05 value '|                                         |'.
           05 line 15 col 36.
           05 value '|                                         |'.
           05 line 16 col 36.
           05 value '+-----------------------------------------+'.
           05 line 17 col 36.
           05 value '|                                         |'.
           05 line 18 col 36.
           05 value '|                                         |'.
           05 line 19 col 38.
           05 pic x(41) from acc-field . 
           05 line 20 col 36.
           05 value '|                                         |'.
           05 line 21 col 36.
           05 value '|                                         |'.
           05 line 22 col 36.
           05 value '+-----------------------------------------+'.
 
        01 screen-record-crtext.
           05 line 1 col 36.
           05 value '+-----------------------------------------+'.
           05 line 2 col 36.
           05 value '|  We  shall  create  a  file  that  has  |'.
           05 line 3 col 36.
           05 value '|  information about books.  The various  |'.
           05 line 4 col 36.
           05 value '|  fields of information will be :-       |'.
           05 line 5 col 36.
           05 value '|                                         |'.
           05 line 6 col 36.
           05 value '|  1. ISBN Number        (13 Characters)  |'.
           05 line 7 col 36.
           05 value '|  2. Author Name        (20 Chrarcters)  |'.
           05 line 8 col 36.
           05 value '|  3. Book Title         (20 Characters)  |'.
           05 line 9 col 36.
           05 value '|  4. Publisher Name     (20 Characters)  |'.
           05 line 10 col 36.
           05 value '|  5. Category           (16 Characters)  |'.
           05 line 11 col 36.
           05 value '+-----------------------------------------+'.  
           05 line 12 col 36.
           05 value '|  We would  like to  access information  |'.
           05 line 13 col 36.
           05 value '|  based on ISBN & Category. Accordingly  |'.
           05 line 14 col 36. 
           05 value '|  we have used ISBN'.
           05 line 14 col 56. 
           05 value ' >>>>>>> ' blink.
           05 line 14 col 65. 
           05 value 'Primary key  |'.
           05 line 15 col 36.
           05 value '|  and Category'.
           05 line 15 col 51.
           05 value ' >>>>>>>>> ' blink.
           05 line 15 col 62.
           05 value 'Secondary key.  |'.
           05 line 16 col 36.
           05 value '|  Five sample records will  be shown on  |'.
           05 line 17 col 36.
           05 value '|  the left  side.  You  can modify  any  |'.
           05 line 18 col 36.
           05 value '|  record. If you  do not want to modify  |'.
           05 line 19 col 36.
           05 value '|  or create the  data-file press <ESC>.  |'.
           05 line 20 col 36.
           05 value '|  Otherwise,  press  <ENTER>  or any of  |'.
           05 line 21 col 36.
           05 value '|  the Function keys.                     |'.
           05 line 22 col 36.
           05 value '+-----------------------------------------+'.
 
        01 screen-record-end.
           05 line 08 col 19.
           05 value '+----------------------------------------+'.
           05 line 9 col 19.
           05 value '|                                        |'.         
           05 line 10 col 19.
           05 value '|                                        |'.         
           05 line 11 col 19.
           05 value '|    '.   
           05 line 11 col 24.
           05 value 'COBOL DEMONSTRATION PROGRAM ENDS' blink. 
           05 line 11 col 60.    
           05 value '|'.   
           05 line 12 col 19.
           05 value '|                                        |'.
           05 line 13 col 19.
           05 value '|                                        |'.
           05 line 14 col 19.
           05 value '+----------------------------------------+'.
 
        01 screen-record-recscrn-disp.
           05 line 08 col 0.
           05 value '+---------------------------------+'.
           05 line 9 col 0.
           05 value '|                                 |'.         
           05 line 10 col 0.
           05 value '|                                 |'.         
           05 line 11 col 0.
           05 value '| ISBN      :                     |'.
           05 line 12 col 0.
           05 value '|                                 |'.         
           05 line 13 col 0.
           05 value '| AUTHOR    :                     |'.
           05 line 14 col 0.
           05 value '|                                 |'.         
           05 line 15 col 0.
           05 value '| TITLE     :                     |'.
           05 line 16 col 0.
           05 value '|                                 |'.         
           05 line 17 col 0.
           05 value '| PUBLISHER :                     |'.
           05 line 18 col 0.
           05 value '|                                 |'.         
           05 line 19 col 0.
           05 value '| CATEGORY  :                     |'.
           05 line 20 col 0.
           05 value '|                                 |'.         
           05 line 21 col 0.
           05 value '|                                 |'.         
           05 line 22 col 0.
           05 value '+---------------------------------+'.
 
        01 screen-record-recscrn.
  	   05 line 11 col 14.
           05 pic x(13) using isbnd required auto. 
 	   05 line number is plus 2 col 14.
           05 pic x(20) using writerd required auto.
 	   05 line number is plus 2 col 14.
           05 pic x(20) using titled required auto.
 	   05 line number is plus 2 col 14.
           05 pic x(20) using publisherd required auto.
 	   05 line number is plus 2 col 14.
           05 pic x(17) using categoryd required auto.

       procedure division.
      *------------------- 
       declaratives.
       decl section.
              use after 
              error procedure on bookrec.
              if flstat not = "00** " move 1 to iofail
              else move 0 to iofail.

       end declaratives.
       begin section.
       main-para.
      *----------
              display screen-record-introscr.
              call x"83" using ci-rec.
              display screen-blank.
              display screen-record-demomsg.
              display screen-record-crtext.
              call x"83" using ci-rec.
              move char-in to esc-key enter-key.
              if esc 
              open input bookrec
              if iofail = 1 
              move 'Input file does not exist' to screen-user-area
              display screen-record-message
              go to exit-program
              else
              display screen-record-recscrn-disp  
              perform read-and-display
              perform blink-end-message
              close bookrec go to exit-program.
              if enterkey or not esc
              perform update-or-create thru update-or-create-end
              open input bookrec
              if iofail = 1 
              move 'Input file does not exist' to screen-user-area
              display screen-record-message
              go to exit-program
              else
              perform read-and-display
              perform blink-end-message
              close bookrec.
       exit-program.
      *-------------
              stop run.
       update-or-create.
      *-----------------
              open output bookrec.
              close bookrec.
              open i-o bookrec.
              perform read-rec-and-update.
              close bookrec.
       update-or-create-end.
      *---------------------
              exit.
       read-rec-and-update.
      *--------------------
              display screen-record-recscrn-disp.
              move 'Creating data file ...... ' to screen-user-area
              display screen-record-message
              move permanent-data-5 to t-data
              perform t-data-to-scr
              perform updation.
              move permanent-data-4 to t-data.
              perform t-data-to-scr.
              perform updation.
              move permanent-data-3 to t-data.
              perform t-data-to-scr.
              perform updation.
              move permanent-data-2 to t-data.
              perform t-data-to-scr.
              perform updation.
              move permanent-data-1 to t-data.
              perform t-data-to-scr.
              perform updation.
       updation.
      *---------
              display screen-record-recscrn.
              accept  screen-record-recscrn .
              perform scr-to-t-data.
              write catalog from t-data.
       read-and-display. 
      *-----------------
              move mesrecp to acc-field.
              perform wait-and-display.
              move isbn-1 of permanent-data-1 to isbn.
              start bookrec.
              perform read-next 5 times.
              move mesrecs to acc-field.
              perform wait-and-display.
              move category-1 of permanent-data-1 to category.
              start bookrec key is = category.
              perform read-next 5 times.
       wait-and-display.
      *-----------------
              display screen-record-accmsg.
              move spaces to t-data.
              perform t-data-to-scr.
              display screen-record-recscrn.
       read-next.
      *----------
              move 'Press any key to view records' to screen-user-area.
              display screen-record-message.
              read bookrec next record into t-data.
              perform t-data-to-scr.
              display screen-record-recscrn.
              call x"83" using ci-rec.
       blink-end-message.
      *------------------
              display screen-blank.
              display screen-record-end.
       scr-to-t-data.
      *--------------
              move isbnd      of d-data to isbnt      of t-data.
              move writerd    of d-data to writert    of t-data.
              move titled     of d-data to titlet     of t-data.
              move publisherd of d-data to publishert of t-data.
              move categoryd  of d-data to categoryt  of t-data.
       t-data-to-scr.
      *--------------
              move isbnt      of t-data to isbnd      of d-data.
              move writert    of t-data to writerd    of d-data.
              move titlet     of t-data to titled     of d-data.
              move publishert of t-data to publisherd of d-data.
              move categoryt  of t-data to categoryd  of d-data.
