
Sample Serverps.dll: dlldata.obj Sample Server_p.obj Sample Server_i.obj
	link /dll /out:Sample Serverps.dll /def:Sample Serverps.def /entry:DllMain dlldata.obj Sample Server_p.obj Sample Server_i.obj \
		kernel32.lib rpcndr.lib rpcns4.lib rpcrt4.lib oleaut32.lib uuid.lib \

.c.obj:
	cl /c /Ox /DWIN32 /D_WIN32_WINNT=0x0400 /DREGISTER_PROXY_DLL \
		$<

clean:
	@del Sample Serverps.dll
	@del Sample Serverps.lib
	@del Sample Serverps.exp
	@del dlldata.obj
	@del Sample Server_p.obj
	@del Sample Server_i.obj
