
 import java.awt.*;
 import java.applet.*;

/*
<applet code="Bar" width=200 height=200>
    <param name="count" value=7>

    <param name="label1" value=1990>
    <param name="label2" value=1991>
    <param name="label3" value=1992>
    <param name="label4" value=1993>
    <param name="label5" value=1994>
    <param name="label6" value=1995>
    <param name="label7" value=1996>

    <param name="value1" value=20>
    <param name="value2" value=30>
    <param name="value3" value=10>
    <param name="value4" value=5>
    <param name="value5" value=20>
    <param name="value6" value=15>
    <param name="value7" value=50>
</applet>
*/

 public class Bar extends Applet
 {
   int num=0;
   String label[];
   int values[];

   public void init()
   {
     	try{
	 num=Integer.parseInt(getParameter("count"));
	 int i;
	 for(label=new String[num],values=new int[num],i=0;i<num;i++)
	 {   label[i]=getParameter("label"+(i+1));
             values[i]=Integer.parseInt(getParameter("value"+(i+1)));
	 }
	}
	catch(NumberFormatException e)
	{ System.out.println("Cannot Parse Integer\n"+e.getMessage());}
   }
   public void paint(Graphics g)
   {
     int MinX=20,MaxX=825,MinY=30,MaxY=475,Xlen=MaxX-MinX,Ylen=MaxY-MinY;
     float tmp,avg=FindAverage(values,num);
     int MaxVal=FindMaxMin(values,num,true);
     int MinVal=FindMaxMin(values,num,false);
     int Xinc=((int)((float)Xlen/(float)num)),X,Y,i;
     X=MinX;i=0;			
     while(i<num)
     {    g.setColor(new Color(0,0,200));
	  tmp=(((float)values[i])/((float)MaxVal))*((float)Ylen);	
          g.fillRect(X,MaxY-(int)tmp,(int)(Xinc-(float)Xinc*0.5),(int)tmp);
	  g.setColor(new Color(200,0,0));
	  g.drawString(label[i],X+3,MaxY+15);
	  g.setColor(new Color(0,0,0));
	  g.drawString(values[i]
          +"<"+(((float)values[i])/((float)MaxVal)*(float)100)
          +"%>",X,MaxY-(int)tmp-5);
	  X+=Xinc;i++;
     }  
     g.setColor(new Color(0,0,0));
     g.drawString("Maximum:"+MaxVal+"  Minimum:"+MinVal+
     "  Average:"+avg,MinX+1,MaxY+30);
     return;
   }
   private int FindMaxMin(int val[],int cnt,boolean Max)
   {
      int i,maxmin;
      maxmin=val[0];
      for(i=1;i<cnt;i++) 
        maxmin=(Max&&val[i]>maxmin)||(!Max&&val[i]<maxmin)?val[i]:maxmin;
      
      return maxmin;
   }
   private float FindAverage(int val[],int cnt)
   {
      int i;
      float avg=0; 
      for(i=0;i<cnt;i++) avg+=val[i];
      return avg/((float)(cnt==0?1:cnt));  	
   }
 }

