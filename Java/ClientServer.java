
 import java.net.*;
 
 public class ClientServer
 { 
   public static int SPort=998; 
   public static InetAddress CIp;
   public static int CPort=999;
   public static int BSize=1024;
   public static byte Buff[]=new byte[BSize];
   public static DatagramSocket DSocket;

   public static void RunServer() throws Exception
   {
     int i=0,RChar=0;
     while(RChar!=-1)
     {
       RChar=System.in.read();
       switch(RChar)
       {
         case -1:System.out.println("\n\nAborting Server!!!\n\n"+
                 "You will loose any unsend line!\n");
                 i=0;
         case '\n':DSocket.send(new DatagramPacket
                          (Buff,i,CIp,CPort));
                   if(i==0) 
		   {   System.out.println("\n\nServer Quits!!!\n\n");
		       RChar=-1;
                   }   
                   i=0;break;
	 case '\r':break;
         default:Buff[i++]=(byte)RChar;
       }
     }
     return;
   } 
  
   public static void RunClient() throws Exception  
   {
     String s="INITSERVER";
     while(!s.equals("")) 
     {
       DatagramPacket Pkt=new DatagramPacket(Buff,BSize);
       DSocket.receive(Pkt);
       s=new String(Pkt.getData(),0,Pkt.getLength());
       System.out.println(s.equals("")?"\n\nQuitting CLIENT":s);
     }
     return;
   }  	     
	
   private static void Usage(String tmp)
   {	
       System.out.println(tmp+"\n\nUsage\n\nFor Server:"+
       " java ClientServer <-s> <serverport(def:998)> "+                                      "<clientport(def:999)>\n\n                     "+
       "              <ClientHostName(def:This Machine)>\n\n"+
       "For Client: java ClientServer <-c> <clientport(def:999)>\n\n");
        
       return;  
   }

   public static void main(String Arg[])
   {
     int Flg,tmp;
     if(Arg.length==4)
     {
       if(Arg[0].trim().equals("-s")||Arg[0].trim().equals("-S"))
       {
           try 
           { tmp=Integer.parseInt(Arg[1]);
             SPort=tmp;
           }
           catch(NumberFormatException e) {} 
           try 
           { tmp=Integer.parseInt(Arg[2]);
             CPort=tmp;
           }
           catch(NumberFormatException e) {} 
           try
           {
             InetAddress t=InetAddress.getByName(Arg[3]);
             CIp=t;
           }
           catch(UnknownHostException e)
           {
              System.out.println("\n\nCannot Locate "+Arg[3]+
              ", Now using default CLIENT(this machine)\n\n");
              try{ CIp=InetAddress.getLocalHost(); }
              catch(UnknownHostException e1)
              { 
                  Usage("\n\nAdd this Machine to Network to get an IP");
                  return;
              }
           }       
           try
           {
              DSocket=new DatagramSocket(SPort);
              System.out.println
             ("\n\nCTRL+BREAK or a BLANK-LINE to terminate SERVER."+
              "\n\n(This will terminate CLIENT also)"+
              "\n\nEnter your Message.\n\n"); 
              RunServer();
           }
           catch(Exception e)
           {
      	     System.out.println("\n\n(Server):Cannot Connect to the network!!!\n\n");
             return; 
           }  
         }
         else
         {
	     Usage("\n\nUse '-s' or '-S'");
             return; 
         }  
       }
       else if(Arg.length==2)
       {
          if(Arg[0].trim().equals("-c")||Arg[0].trim().equals("-C"))
          {
            try 
            { tmp=Integer.parseInt(Arg[1]);
              CPort=tmp;
            }
            catch(NumberFormatException e) {} 
            try
            {
              DSocket=new DatagramSocket(CPort);
              System.out.println("\n\nWait for Server to respond!!!\n\n"+
              "CTRL+C to terminate CLIENT in any way\n\n");
              RunClient();
            }
            catch(Exception e)
            {
	      System.out.println("\n\n(Client):Cannot Connect to the network!!!\n\n");
              return; 
            }  
          } 
          else   
          {
	     Usage("\n\nUse '-c' or '-C'");
             return; 
          }  
       }
       else
       {
         Usage("");
         return;
       }  

   return;                
   } 
 }