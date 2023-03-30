*********  This program is to test Compiler & Runtime     *******
*********  for verifying Year 2000 problem                *******
*********  i.e.  ACCEPTING & DISPLAYING DATE IN 8-DIGITS. *******



	working-storage section.
	01 date1 pic 9(8).
	01 date2 pic 9(6).
	procedure division.
		display " SOFTEK COBOL'S DEMO PROGRAM " at 0210. 
		display "OUTPUT " at 0508 with blink.
		display "DATE " at 0537 with blink.
		accept date1 from current-date.
		display "DATE OUTPUT IN EIGHT DIGITS :" at 1001.
		display date1 at 1035.
		accept date2 from date.
		display "DATE OUTPUT IN SIX DIGITS   :" at 2001.
		display date2 at 2035.
