
	
	
		This software needs a database to store & retrieve problems. Available options are Oracle 8I/9I or MS-Access.
	If you use MS-Access database you can exclusively provide an existing database or can allow OpTech to create
	a new MS-Access database for it's use.

		If you provide an existing database then specify the provider from the available two options(Oracle/Ms-
	Access), Username,Password(if any),datasource which can be browsed if it is of MS-Access type .There provided 
	a default database for OpTech called dbOpTech and is maintained in the ./sdbase directory. If you go for default 
	database then OpTech will search this folder for  the database file dbOpTech and if not found it will allow you to create
	a new database(directory sdbase will be created if necessory). You can reassign a database by using the option called 'reassign database' from the 'Edit'
Menu.In this case first you must specify database requirements all over 
	again.

		If you are using MS-access which supports 97 file formats or lower  then databases having file format  2000 or higher
	cannot be assigned for OpTech. That means if the database's fileformats is higher than your system can support,
	then assigning this database to OpTech will not work properly. This will cause errors while saving problems or 
	at solving especially Branch & Bound method.

		So your system must support the fileformat of the database used.For example if you copy a datbase of MS-Access
	from an NT-environment to Windows98 environment it may not work properly with OpTech. Sharing of database will not
	work.	 

		