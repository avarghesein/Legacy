	IDENTIFICATION DIVISION.
        PROGRAM-ID. fact.
 	ENVIRONMENT DIVISION.
	DATA DIVISION.
	WORKING-STORAGE SECTION.
        77 f PIC 9(10).
        77 k PIC 9(10) value 1.
	PROCEDURE DIVISION.
	MAIN.
           display "Enter the number".
           accept f.
           perform FACTORIAL.
           display "Factorial=", k.
           stop run.

       FACTORIAL.
           if f > 0
               compute k = k * f
               compute f = f - 1
               perform FACTORIAL
           end-if.
           display k.
