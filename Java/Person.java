

import java.applet.*;
import java.awt.*;
import java.awt.event.*;

/*
<applet code="Person" width=200 height=200>
</applet>
*/

public class Person extends Applet implements ActionListener
{
	int cnt=1;
	String s[]={"Accept"};
	String cur;
		
	public void HandleButtonsClick(int cnt,String s[],ActionEvent e)
	{
		String c=e.getActionCommand();
		if(c.equals(s[0]))
		{	cur=s[0];	}
		return;
	}

	Label l[]=new Label[7];
	TextField t[]=new TextField[5];
	CheckboxGroup cgp=new CheckboxGroup();
	CheckboxGroup cgp1=new CheckboxGroup();
	Checkbox cb[]=new Checkbox[2];
	Checkbox cb1[]=new Checkbox[2];

	private String GiveProperText(String s)
	{
		String S1=new String(s.trim());
		if(S1.equals("")) return "[unknown]"; else
		return S1;
	}


 	public void paint(Graphics g)
	{
		String prnt;
		this.setForeground(new Color(0,0,0));
		if(!cur.equals("")){
		g.drawString("***REPORT***",50,420);
		if((cgp.getSelectedCheckbox().getLabel()).equals("Male"))
			prnt="Mr." +GiveProperText(t[0].getText())+" son of,";
		else									prnt=((cgp1.getSelectedCheckbox().getLabel()).equals("Married")?
		"Mrs.":"Ms.")+GiveProperText(t[0].getText())+" daughter of,";
		
		g.drawString(prnt,50,435);
		prnt="Mr."+GiveProperText(t[2].getText())+" and Mrs."					+GiveProperText(t[3].getText())+",";
		g.drawString(prnt,50,450);
		prnt="Having " +GiveProperText(t[1].getText())+
		" years old,";
		g.drawString(prnt,50,465);
		prnt="Is from "+GiveProperText(t[4].getText())+".";
		g.drawString(prnt,50,480);
		}
		return; 
	}

	public void actionPerformed(ActionEvent e)
	{
		HandleButtonsClick(cnt,s,e);
		repaint();
	}


	public void CreateControlsAndLayout()
	{
		
		this.setBackground(new Color(250,250,250));
		this.setForeground(new Color(0,0,250));
		this.setFont(new Font("courier",Font.BOLD,15));	
		Button b;

		b=new Button(s[0]);
                b.setFont(new Font("courier",Font.BOLD,12));
	        b.addActionListener(this);
	
		int i,j;
		for(i=0;i<7;i++) l[i]=new Label("",Label.RIGHT);
		l[0].setText("Name:"); 
		l[1].setText("Age:"); 
		l[2].setText("Sex:"); 
		l[3].setText("Marital Status:");
		l[4].setText("Father's Name:"); 		
		l[5].setText("Mother's Name:"); 
		l[6].setText("Place:"); 
		for(i=0;i<5;i++) 
		{	t[i]=new TextField(10);
			t[i].setForeground(new Color(0,0,0));
		}
		cb[0]=new Checkbox("Male",cgp,true);
		cb[1]=new Checkbox("Female",cgp,false);
		cb1[0]=new Checkbox("Married",cgp1,true);
		cb1[1]=new Checkbox("Unmarried",cgp1,false);
		this.setLayout(new GridLayout(12,3,1,1));
		for(i=0;i<3;i++)
			this.add(new Label(i==1?"-----Fill The Details-----":""));
		for(i=0;i<7;i++)
		{	
			this.add(l[i]);
			if(i<=1) this.add(t[i]); else
			if(i==2)
			{	this.add(cb[0]);
				this.add(cb[1]);
				continue;
			}else 
			if(i==3)
			{	this.add(cb1[0]);
				this.add(cb1[1]);
				continue;
			}else this.add(t[i-2]);
			this.add(new Label());
		}
		this.add(new Label());
	        this.add(b);
		return;

	}
	
	public void init()
	{
		CreateControlsAndLayout();	
		return;			
	}

	
}
		
