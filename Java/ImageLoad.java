 
 import java.applet.*;
 import java.net.*;
 import java.awt.*;

 /*
 <applet code="ImageLoad" width=248 height=150>
   <param name="img" value="fig.jpg">
 </applet>
 */

 public class ImageLoad extends Applet
 {
   Image img;
   
   public void init()
   {
     img=getImage(getDocumentBase(),getParameter("img"));
   }
  
   public void paint(Graphics g)
   {
     g.drawImage(img,0,0,this);
   }
 }
