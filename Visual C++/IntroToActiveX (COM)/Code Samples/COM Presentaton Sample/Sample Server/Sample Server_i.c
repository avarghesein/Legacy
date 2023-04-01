/* this file contains the actual definitions of */
/* the IIDs and CLSIDs */

/* link this file in with the server and any clients */


/* File created by MIDL compiler version 5.01.0164 */
/* at Mon May 25 13:36:16 2009
 */
/* Compiler settings for H:\UL-PIMS\DOCs PPTs\COM Seminar\Code Samples\COM Presentaton Sample\Sample Server\Sample Server.idl:
    Oicf (OptLev=i2), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )
#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

const IID IID_ICallBackReply = {0x619E413C,0x4829,0x4E97,{0xBA,0xC6,0xFF,0xB7,0x6A,0xDB,0xD0,0x34}};


const IID IID_IFun = {0x2FCDA75A,0x43A1,0x4349,{0x80,0x37,0x3B,0x89,0xBE,0x1B,0x62,0xC3}};


const IID LIBID_SAMPLESERVERLib = {0xC863264D,0x6CEE,0x4A84,{0x83,0x6E,0xE1,0xC7,0xF6,0x1A,0x2B,0xD3}};


const CLSID CLSID_Fun = {0x32C2E095,0xACD6,0x454D,{0x83,0x32,0x0D,0xCB,0x87,0x90,0x26,0x3C}};


const CLSID CLSID_CallBackReply = {0x6E585F10,0xE1EB,0x451A,{0x94,0xDA,0x4F,0x46,0x00,0x80,0xDB,0x46}};


#ifdef __cplusplus
}
#endif

