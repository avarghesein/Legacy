
#pragma once

class CMail
{
protected:

	bool PackMessage(BYTE Message,CBytes &Arg,CTString &Server,CBytes& OutArg);
	bool GetArg(MsgHeader &Header,CBytes &Bytes,CBytes &Args);
	bool LastPart(MsgHeader &Header,CBytes &Bytes,CTString &Arg);
	bool GetClient(MsgHeader &Header,CBytes &Bytes,CMailSlotWriter &oWriter);
};


bool CMail::PackMessage(BYTE Message,CBytes &Arg,CTString &Server,CBytes& OutArg)
{
	MsgHeader Header;
	CBytes ServerBuff;

	Server.Convert(ServerBuff);

	Header.Message = Message;
	Header.ArgLength = Arg.Length(); 
	Header.ServerNameLength = Server.IsEmpty() ? 0 : Server.Length(true);

	OutArg.Clear(); 
	OutArg.Append((void*)&Header,sizeof(MsgHeader)); 
	OutArg.Append(Arg);
	OutArg.Append(ServerBuff);  
	
	return true;
}

bool CMail::GetArg(MsgHeader &Header,CBytes &Bytes,CBytes &Args)
{
	CBytes Buff(Bytes.Cut(sizeof(MsgHeader),Header.ServerNameLength));
	Args = Buff;
	return true;
}

bool CMail::LastPart(MsgHeader &Header,CBytes &Bytes,CTString &Arg)
{
	Arg.Clear(); 
	CBytes Buff(Bytes.Cut(sizeof(MsgHeader) + Header.ArgLength,Header.ServerNameLength));  
	CTString sArg;
	if(!Buff.Convert(sArg)) return false;
	Arg = sArg;
	return true;
}

bool CMail::GetClient(MsgHeader &Header,CBytes &Bytes,CMailSlotWriter &oWriter)
{
	CBytes Buff(Bytes.Cut(sizeof(MsgHeader) + Header.ArgLength,Header.ServerNameLength));  

	CTString sArg;
	if(!Buff.Convert(sArg)) return false;
	return oWriter.ConnectSpecial(sArg);	
}
