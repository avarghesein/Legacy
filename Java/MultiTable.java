

 class PrintLine
 {
   public synchronized void Print(int Num1,int Num2,int Tabs)
   {  int i;
      System.out.print("\n\n");
      for(i=1;i<=Tabs;i++) System.out.print("\t");
      System.out.print(Num1+"x"+Num2+"="+(Num1*Num2));
      return;
   }   
 }

 class Table implements Runnable
 {
   int Tabs;
   int Num;
   int Cols;
   PrintLine PL;
   Thread Td;
   Table(int Num,int Cols,int Tabs,PrintLine PL)
   {
     this.Tabs=Tabs;
     this.Num=Num;
     this.Cols=Cols;
     this.PL=PL;
     Td=new Thread(this,"MultiTable"+Num);
     Td.start();
   }
   public void run()
   {
     int i;
     for(i=1;i<=Cols;i++) 
         synchronized(PL){ PL.Print(Num,i,Tabs); }
     return;
   }
}

 public class MultiTable
 {
  public static void main(String args[])  
  {
    PrintLine Pl=new PrintLine();
    int Cnt=3,Cols=5;
    int num[]={3,5,11};
    Table Te[]=new Table[Cnt];
    int i;
    System.out.print("\n\n***Multiplication Tables For 3,5,11***\n");
    for(i=0;i<Cnt;i++) Te[i]=new Table(num[i],Cols,i*2,Pl);  
    for(i=0;i<Cnt;i++) 
    {  try
       { Te[i].Td.join();}
       catch(InterruptedException e)
       { System.out.println("\n"+i+" th Thread Interrupted\n");}  
    } 
    System.out.println("\n\n\nEnding...\n");
    return;
  }
}
    

      
    
      

	
     
