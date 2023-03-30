
import javax.swing.*;
import java.applet.*;
import java.awt.*;
import java.awt.event.*;

/*
<applet code="Face" width=200 height=200>
</applet>
*/

public class Face extends Applet implements ActionListener
{
	int cnt=2;
	String s[]={"cry!","smile!"};
	String cur;
		
	public void HandleButtonsClick(int cnt,String s[],ActionEvent e)
	{
		String c=e.getActionCommand();
		if(c.equals(s[0]))
		{	cur=s[0];	}
		else if(c.equals(s[1]))
		{	cur=s[1];	}
		
		return;
	}

 	public void paint(Graphics g)
	{
		int x=800/2,y=550/2;
		g.setColor(new Color(0,0,0));
		g.drawLine(x,y-100,x-50,y-150);
		g.drawLine(x,y-100,x+50,y-150);
		g.setColor(new Color(0,0,200));
		g.fillOval(x-45,y-45,15,15);								g.fillOval(x+35,y-45,15,15);
		g.setColor(new Color(200,0,0));
		g.drawOval(x-100,y-100,200,200);
		g.drawOval(x-50,y-50,25,25);
		g.drawOval(x+30,y-50,25,25);
		g.drawOval(x+100,y-50,30,60);
		g.drawOval(x-100-30,y-50,30,60);
		g.drawLine(x,y-30,x,y+25);
		int x1=x-50,y1=y-50;
		g.drawArc(x1,y1-15,25,35,0,180);
		x1=x+30;
		g.drawArc(x1,y1-15,25,35,0,180);
		x1=x-25;
		y1=y+30;
		
		if (!(cur.equals("")))
		{
			if(cur.equals(s[0]))
			{ g.drawString("Don't Hurt Me!!!",50,50);
			  g.drawArc(x1,y1,50,50,0,180);}
			else if(cur.equals(s[1]))
			{ g.drawString("You Are My Friend!!!",50,50);
			  g.drawArc(x1,y1-30,50,50,180,180);	}
		}
		else 
		{	
			g.drawString("Why Don't You Do Something?",50,50);
			g.drawLine(x1,y1+10,x1+50,y1+10);	}
	}

	public void actionPerformed(ActionEvent e)
	{
		HandleButtonsClick(cnt,s,e);
		repaint();
	}


	public void CreateButtonsAndLayout()
	{
		this.setLayout(new BorderLayout());
		this.setBackground(new Color(250,250,250));
		this.setForeground(new Color(0,0,250));
		this.setFont(new Font("courier",Font.BOLD,15));
		int i;
		Button j;
		JPanel bbox=new JPanel();
		bbox.setLayout(new FlowLayout(FlowLayout.LEFT,100,10));
		bbox.setBackground(new Color(250,250,250));
		cur="";
		for(i=1;i<=cnt;i++) 
 		{   
                    j=new Button(s[i-1]);
                    j.setFont(new Font("courier",Font.BOLD,12));
		    j.addActionListener(this);
                    bbox.add(j);
		}
                              
	        this.add(bbox,BorderLayout.SOUTH);
		return;

	}
	
	public void init()
	{
		CreateButtonsAndLayout();	
		return;			
	}

	
}
		
