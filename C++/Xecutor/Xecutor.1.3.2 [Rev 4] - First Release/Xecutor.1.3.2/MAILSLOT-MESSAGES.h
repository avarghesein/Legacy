

#define MAIL_SLOT_SERVER "XecutorServer"
#define MAIL_SLOT_CLIENT "XecutorClient"


CExtendedLinkedList<CConsoleProcessScheduler,CTString> moProcessList;

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
#define MSG_PROFILE_START_SCH      0x05
#define MSG_PROFILE_STOP_SCH       0x06
#define MSG_OK                     0x07
#define MSG_ERR                    0x08
#define MSG_PROFILE_GET_SHORT_NAME 0x09
#define MSG_PROFILE_TERMINATE_SCH  0x0A
#define MSG_TERMINATE_ALL          0x0B
#define MSG_RESET_ALL              0x0C
#define MSG_RESTART                0x0D