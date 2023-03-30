

#define MAIL_SLOT_SERVER "XecutorServer"
#define MAIL_SLOT_CLIENT "XecutorClient"


CExtendedLinkedList<CConsoleProcessScheduler> moProcessList;

/* Msg Struct
	BYTE : Header
	ARG  : If Any
	MailSlot Name/Result: If Required
*/

#pragma pack(1)

typedef struct 
{
	BYTE Message;	
	int  ArgLength;
	int  ServerNameLength;
}
MsgHeader;

#define MSG_UNKNOWN 0x00

#define MSG_PROFILE_CNT            0x01
#define MSG_PROFILE_GET_NAME       0x02
#define MSG_PROFILE_GET_STAT       0x03
#define MSG_PROFILE_GET_SCH_TIME   0x04
