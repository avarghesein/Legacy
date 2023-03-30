
 import java.awt.*;
 import java.applet.*;

/*
<applet code="Banner" width=200 height=200>
 <param name="Message" value="Java Banner Example.">
</applet>
*/

 public class Banner extends Applet implements Runnable
 {
   String Msg;
   Thread Td=null;
   int State;
   boolean Stop;

  public void init()
  {
    this.setForeground(Color.red);
    this.setFont(new Font("Courier",Font.BOLD,50));
		
  }
  
  public void start()
  {
    Msg=getParameter("Message");
    if(Msg==null) Msg="Default Message";
    Msg=" "+Msg;
    Td=new Thread(this);
    Stop=false;
    Td.start();
  }

  public void run()
  {
    char Ch;
    while(true)
    {
       try{
         repaint();
	 Thread.sleep(325);
         Ch=Msg.charAt(0);
         Msg=Msg.substring(1,Msg.length())+Ch;
         if(Stop) break;
       }
       catch(InterruptedException e){}
    } 
  }

  public void stop()
  {
    Stop=true;
    Td=null;
  }
 
  public void paint(Graphics g)
  {
    g.drawString(Msg,45 ,(30+475)/2);
  }
 }
