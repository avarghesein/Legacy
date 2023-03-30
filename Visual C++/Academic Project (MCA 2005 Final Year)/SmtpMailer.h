
#include<windows.h>
#include<Winsock2.h>
#include <stdlib.h>


enum EWinMonitorSMTP_MAILER_ERRORS 
{
	EWinMonitorSMTP_MAILER_ERRORS_WSASTARTUP_ERR,
    EWinMonitorSMTP_MAILER_ERRORS_HOSTNAME_ERR,
	EWinMonitorSMTP_MAILER_ERRORS_CONNECT_ERR,
	EWinMonitorSMTP_MAILER_ERRORS_SERVER_ERR,
	EWinMonitorSMTP_MAILER_ERRORS_NO_ERR
};


#define WinMonitorSMTP_MAILER_MSG_MAX_LEN 1000 

class CWinMonitorSmtpMailer
{
protected:
	
	char rcpt[256];
	char from[256];
	char subject[256];
	char xmailer[256];
	char smtpserver[256];
	char message[WinMonitorSMTP_MAILER_MSG_MAX_LEN];
	char attachedFileName[MAX_PATH];
	BOOL bAttachment;
	UINT port;
	long base64encode(char* buffer,int size);

	
public:
    //set sender, recipient, subject and message
	void SetParams(const char* from,const char* to,const char* subject,const char* msg);
	// set smtp server [and port(default=25)]
	void SetServer(const char* server,UINT port);
	// attach a file(only 1!) [yet]
	void Attach(const char* filename);
    //send  message
	EWinMonitorSMTP_MAILER_ERRORS Send();
	CWinMonitorSmtpMailer();
	virtual ~CWinMonitorSmtpMailer();
};


CWinMonitorSmtpMailer::CWinMonitorSmtpMailer()
{
   bAttachment=0;
   strcpy(xmailer,"CWinMonitorSmtpMailer\'s Mailer v.1.0.0");		
}

CWinMonitorSmtpMailer::~CWinMonitorSmtpMailer(){}

void CWinMonitorSmtpMailer::Attach(const char* filename)
{
	strncpy(attachedFileName,filename,sizeof(attachedFileName));
	bAttachment=1;
}

void CWinMonitorSmtpMailer::SetServer(const char* server, UINT smtp_port=25){

	strncpy(smtpserver,server,sizeof(smtpserver));
	port=smtp_port;

}

void CWinMonitorSmtpMailer::SetParams(const char* _from, const char* to, const char* _subject, const char* msg)
{
	strncpy(from,_from,sizeof(from));
	strncpy(rcpt,to,sizeof(rcpt));
	strncpy(subject,_subject,sizeof(subject));
	strncpy(message,msg,sizeof(message));
	return;
}
//sends msg, returns:
//
// EWinMonitorSMTP_MAILER_ERRORS_WSASTARTUP_ERR error during winsock initialization
// EWinMonitorSMTP_MAILER_ERRORS_HOSTNAME_ERR   cannot resolve smtp server host
// EWinMonitorSMTP_MAILER_ERRORS_CONNECT_ERR    cannot connect to smtp server
// EWinMonitorSMTP_MAILER_ERRORS_SERVER_ERR     server error (relaying denied, etc.. )
// EWinMonitorSMTP_MAILER_ERRORS_NO_ERR         success

EWinMonitorSMTP_MAILER_ERRORS CWinMonitorSmtpMailer::Send()
{
	
	WSADATA W;
	SOCKET Sock;
	struct sockaddr_in Saddr;
	char text[WinMonitorSMTP_MAILER_MSG_MAX_LEN];
	if(WSAStartup( 0x101, &W )) return EWinMonitorSMTP_MAILER_ERRORS_WSASTARTUP_ERR;
        
    Sock=socket(AF_INET,SOCK_STREAM,0);
	Saddr.sin_family=AF_INET;
	Saddr.sin_port=htons(25);
	hostent *H=gethostbyname(smtpserver);
	if(H==NULL) return EWinMonitorSMTP_MAILER_ERRORS_HOSTNAME_ERR;
	Saddr.sin_addr.s_addr=*((unsigned long *) H->h_addr);
	
	if( connect(Sock,(sockaddr*)&Saddr,sizeof(Saddr)) ) return EWinMonitorSMTP_MAILER_ERRORS_CONNECT_ERR;
	
	recv(Sock,text,sizeof(text),0);
	strcpy(text,"HELO yahoo.com\r\n");
	send(Sock,text,strlen(text),0);
	recv(Sock,text,sizeof(text),0);
	if(text[0]==0x32 && text[1]==0x35 && text[2]==0x30 ); else return EWinMonitorSMTP_MAILER_ERRORS_SERVER_ERR;
	sprintf(text,"MAIL FROM:%s\r\n",from);
	send(Sock,text,strlen(text),0);
	sprintf(text,"RCPT TO:%s\r\n",rcpt);
	send(Sock,text,strlen(text),0);
	recv(Sock,text,sizeof(text),0);
	if(text[0]==0x32 && text[1]==0x35 && text[2]==0x30 ); else return EWinMonitorSMTP_MAILER_ERRORS_SERVER_ERR;
	strcpy(text,"DATA\r\n");
	send(Sock,text,strlen(text),0);
	sprintf(text,"MESSAGE_ID:WinMonitorMailer\r\nX-Mailer:%s\r\nSUBJECT:%s\r\n",xmailer,subject);
	send(Sock,text,strlen(text),0);

	if(bAttachment)
	{
	//   -----------------  MIME header
		send(Sock,"MIME-Version: 1.0\r\n",19,0);
		strcpy(text,"Content-Type: multipart/mixed; boundary=\"--------bound--\"\r\n");
		send(Sock,text,strlen(text),0);
		send(Sock,"\r\n",2,0);
		send(Sock,"----------bound--\r\n",19,0);
		strcpy(text,"Content-Type: text/plain; charset=us-ascii\r\nContent-Transfer-Encoding: 7bit\r\n");
		send(Sock,text,strlen(text),0);
		send(Sock,"\r\n",2,0);
	//   -----------------  
	}
	sprintf(text,"%s\r\n",message);
	send(Sock,text,strlen(text),0);
        
        if(bAttachment){ // encode & send attachment
        	char fname[MAX_PATH];
        	char ext[MAX_PATH];
        	_tsplitpath(attachedFileName,NULL,NULL,fname,ext);
        	send(Sock,"----------bound--\r\n",19,0);
		sprintf(text,"Content-Type: application/x-msdownload; name=\"%s%s\"\r\nContent-Transfer-Encoding: base64\r\nContent-Disposition: attachment; filename=\"%s%s\"\r\n",fname,ext,fname,ext);
	
		send(Sock,text,strlen(text),0);
		send(Sock,"\r\n",2,0);
		
		int size;
		HANDLE FileData=CreateFile(attachedFileName,GENERIC_READ,FILE_SHARE_READ,0,OPEN_EXISTING,0,0);
		size=GetFileSize(FileData,NULL)*2; // voobshe-to vrode nado *4/3 no pochemu-to etogo malo [?] 
		char* CodedData=new char[size];
				
		if((size=base64encode(CodedData,size))!=0) send(Sock,CodedData,size,0);
				else send(Sock,"base64 encoding failed :[",25,0);
		delete [] CodedData;
	
		send(Sock,"\r\n",2,0);
	
		send(Sock,"----------bound--\r\n",19,0);
        }
        
	strcpy(text,"\r\n.\r\n");
	send(Sock,text,strlen(text),0);
	recv(Sock,text,sizeof(text),0);      	
	if(text[0]==0x32 && text[1]==0x35 && text[2]==0x30 ); else return EWinMonitorSMTP_MAILER_ERRORS_SERVER_ERR;
	strcpy(text,"QUIT\r\n");
	send(Sock,text,strlen(text),0);
	recv(Sock,text,sizeof(text),0);      
	closesocket(Sock);
	return EWinMonitorSMTP_MAILER_ERRORS_NO_ERR;
}

long CWinMonitorSmtpMailer::base64encode(char *buffer,int length){

	const char base64[]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"; 
	unsigned char ReadData[57];
	unsigned char ResData[76];
	unsigned long p=0;
	unsigned long len=0;	
	unsigned long SourceLen=0;
	HANDLE FileData;
	DWORD nReadBytes;
	unsigned long CurResBufferPos=0;
	unsigned int j;
	unsigned char tmpchar;
	
	FileData=CreateFile(attachedFileName,GENERIC_READ,FILE_SHARE_READ,0,OPEN_EXISTING,0,0);
	if(FileData==INVALID_HANDLE_VALUE) return 0;
	
	
	do{
		memset(ReadData,0,57);
		ReadFile(FileData,ReadData,57,&nReadBytes,NULL);
		if (nReadBytes==0){
			CloseHandle(FileData);
			return len;
		}
		j=0;
		SourceLen+=nReadBytes;
		for(unsigned int i=0;i<nReadBytes;i+=3){
			p=ReadData[i+2]+ReadData[i+1]*256+ReadData[i]*65536;
			for(unsigned char i1=0;i1<3;i1++){
				tmpchar=(unsigned char)p;
				tmpchar<<=2;
				tmpchar>>=2;
				ResData[j+3-i1]=tmpchar;
				p>>=6;
			}
			ResData[j]=(unsigned char)p;
			j+=4;
		}

		len+=j+1;
		if((unsigned long)len<=length){
			for(unsigned char i1=0;i1<j;i1++)
				buffer[CurResBufferPos+i1]=base64[ResData[i1]];
			buffer[CurResBufferPos+j]='\n';
			CurResBufferPos+=j+1;
		}
		else return 0;
	} while(nReadBytes==57);

	char pad=(char)(3-SourceLen%3)%3;
	while(pad>0){
		buffer[CurResBufferPos-1-pad]='=';
		pad--;
	}
	CloseHandle(FileData);
	return len;
}


 
////-----------------------------------------------------------------------------------------

