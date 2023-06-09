	IDENTIFICATION DIVISION.
	PROGRAM-ID. REWRITING.
	ENVIRONMENT DIVISION.
	INPUT-OUTPUT SECTION.
	FILE-CONTROL
	   SELECT MASTER ASSIGN TO DISK
	   ORGANIZATION IS LINE SEQUENTIAL.
	   SELECT TRANS   ASSIGN TO DISK
	   ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORT-F ASSIGN TO DISK
	   ORGANIZATION IS LINE SEQUENTIAL.	
        DATA DIVISION.
	FILE SECTION.
	FD MASTER
	   LABEL RECORDS ARE STANDARD
	   VALUE OF FILE-ID IS "EMPFILE.DAT"
	   DATA RECORD IS MREC.
	01 MREC.
	   02 ITEM PIC X(10).
	   02 CDE  PIC X(10).
	   02 NUM  PIC 9(5).
	   02 QNTY PIC 9(5).
	FD TRANS
	   LABEL RECORDS ARE STANDARD
	   VALUE OF FILE-ID IS "TRANS.DAT"
	   DATA RECORD IS TREC.
        01 TREC.
	   02 CDE  PIC X(10).
	   02 QNTY PIC 9(5).
	FD REPORT-F
	   LABEL RECORDS ARE STANDARD
	   VALUE OF FILE-ID IS "EUPDATE.DAT"
	   DATA RECORD IS RREC.
	01 RREC PIC X(80).
	WORKING-STORAGE SECTION.
	77 MF PIC X(3).
	77 TF PIC X(3).
	77 VERROR PIC 9(1) VALUE 0.
        01 S-LINE.
	  02 PIC X(80) VALUE ALL "*".
	01 S-HEAD1.
	  02 PIC X(25) VALUE SPACES.
	  02 PIC X(10) VALUE "STORE-ROOM".
	  02 PIC X(25) VALUE SPACES.
	01 S-HEAD2.
 	  02 PIC X(5)  VALUE SPACES.
	  02 PIC X(10) VALUE "ITEM".
	  02 PIC X(5)  VALUE SPACES.
	  02 PIC X(10) VALUE "CODE".
	  02 PIC X(5)  VALUE SPACES.
	  02 PIC X(5) VALUE "NUM".
	  02 PIC X(5)  VALUE SPACES.
	  02 PIC X(5) VALUE "QNTY".
	  02 PIC X(5) VALUE SPACES.
	01 S-PRINT.
	  02 PIC X(5)  VALUE SPACES.
	  02 ITEM PIC  X(10).
	  02 PIC X(5)  VALUE SPACES.
	  02 COD PIC   X(10).
	  02 PIC X(5)  VALUE SPACES.
	  02 NUM PIC   X(5).
	  02 PIC X(5)  VALUE SPACES.
	  02 QUNTY PIC X(5).
	  02 PIC X(5) VALUE SPACES. 
	PROCEDURE DIVISION.
	MAIN.
	   PERFORM OPENING.
	   PERFORM READ-MATRA UNTIL ( MF = "NO" OR TF = "NO" ).
	   IF ( MF = "NO" AND TF = "YES" ) PERFORM REMAIN-T
	   ELSE  
	       IF ( MF = "YES" AND TF = "NO") PERFORM REMAIN-M
	       END-IF
           END-IF.  
	   PERFORM PENDING.

	OPENING.
	   OPEN I-O MASTER
	        INPUT TRANS
	        OUTPUT REPORT-F.
	   MOVE "YES" TO MF, TF.
	   WRITE RREC FROM S-HEAD1.
	   WRITE RREC FROM S-LINE.
	   WRITE RREC FROM S-HEAD2.
	   WRITE RREC FROM S-LINE.
	   READ MASTER AT END MOVE "NO" TO MF.
	   READ TRANS  AT END MOVE "NO" TO TF.
	
	READ-MATRA.
	   IF ( CDE OF MREC = CDE OF TREC )  PERFORM EQUALCASE   
	   ELSE 
	       IF ( CDE OF MREC < CDE OF TREC )  PERFORM LESSMASTER
	       ELSE
	           PERFORM ERRORPARA
	       END-IF
	   END-IF.

	EQUALCASE.
	   PERFORM UNTIL ( TF = "NO" OR CDE OF MREC NOT= CDE OF TREC )
	            ADD QNTY OF TREC TO QNTY OF MREC
	            READ TRANS AT END MOVE "NO" TO TF
	   END-PERFORM.
	   PERFORM COPYING.
	   REWRITE MREC.
	   WRITE RREC.
	   READ MASTER AT END MOVE "NO" TO MF.
	   
	
	LESSMASTER.
	   PERFORM COPYING.
	   WRITE RREC.
	   READ MASTER AT END MOVE "NO" TO MF.

	ERRORPARA.
	   MOVE 1 TO VERROR.
	   READ TRANS AT END MOVE "NO" TO TF.

	REMAIN-T.
	   PERFORM ERRORPARA UNTIL TF = "NO".
	
	REMAIN-M.
	   PERFORM LESSMASTER UNTIL MF = "NO".
	
	PENDING.
	   CLOSE MASTER, TRANS, REPORT-F.
           IF VERROR = 1 
	       DISPLAY (1,1) ERASE
	       DISPLAY "ERROR IN TRANSACTION FILE"
	       ACCEPT VERROR  
           END-IF.
	   STOP RUN. 

	   
	COPYING.
	   MOVE ITEM OF MREC TO ITEM OF S-PRINT.
	   MOVE CDE  OF MREC TO COD  OF S-PRINT.
	   MOVE NUM  OF MREC TO NUM  OF S-PRINT.
	   MOVE QNTY OF MREC TO QUNTY OF S-PRINT.
	   MOVE S-PRINT TO RREC.