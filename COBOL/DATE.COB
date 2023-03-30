	working-storage section.
@       01 date-var.
	   02  month-1   pic x(2).
	   02  date-1    pic x(2). 
	   02  year-1    pic x(2).
	77 data-1 pic  x(6).

	procedure division.
		move date-var to data-1.
