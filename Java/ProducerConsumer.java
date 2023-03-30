 

 import java.io.*;
 
 class Queue
 {
    String Q[];
    int Length,Front,Rear;

    public Queue(int Size)
    {
        Q=new String[Length=Size];
        Front=Rear=-1;
    }  
    public boolean Insert(String Item)
    {
       int tmp=(this.Rear+1)%Length;

       if(tmp==this.Front) return false;
       else
       {
            Rear=tmp;
            Q[Rear]=Item;
            if(Front==-1) Front=Rear;
            return true;
       }     
    }
    public String Delete()
    {
        if(Front==-1) return "NULL";
        String tmp=new String(Q[Front]);
        if(Front==Rear) Front=Rear=-1;
        else Front=(Front+1)%Length;
        return new String(tmp);
    }
    public void Display(String Prompt)
    {
        System.out.println(Prompt);
        if(Front==-1) System.out.println("\nQueue is Empty\n");
        else
        {
            int i;
            for(i=Front;i!=Rear;i=(i+1)%Length)
               System.out.println("\n\nItem>"+Q[i]);      
            System.out.println("\n\nItem>"+Q[Rear]);      
        }
        return;
    }
 }  
         
 class Consumer implements Runnable
 {
    static volatile boolean Consume=true;
    int id;
    Queue Q;
    Thread Thrd;
    
    public Consumer(int Id,Queue Q)
    {
      id=Id;
      this.Q=Q;   
      Thrd=new Thread(this,"Consumer"+id);
      Thrd.start(); 
    }
    
    public void run() 
    { 
      String s=new String("Starting...");
      while(Consume)
      {
           try
           {  synchronized(Q){ s=Q.Delete(); }
              if(s.equals("NULL"));
              else
              {
                  System.out.println("\nC"+id+"<--"+s+"\n");
                  Thread.sleep(800);
              }
           } 
           catch(InterruptedException e){}
       }  
     }
 
     public static void Stop() { Consume=false; }
 }  
             
 class Producer implements Runnable
 {
    static volatile boolean Produce=true;
    int i,id;
    Thread Thrd;
    Queue Q; 
    
    public Producer(int Id,Queue Q)
    {
      i=0;id=Id;this.Q=Q;
      Thrd=new Thread(this,"Producer"+id);
      Thrd.start();
    }   
    public void run() 
    {
         while(Produce)
         {
                boolean flg;
                synchronized(Q) { flg=Q.Insert("P"+id+":"+(i+1)); }
                if(!flg);
                else
                {
                   System.out.println("\nP"+id+":"+(i+1)+"-->Queue\n");
                   //try{ Thread.sleep(1600); }
                   //catch(InterruptedException e){} 
                   i=i+1;     
                }
         }  
    }    
    
    public static void Stop() { Produce=false; }
  }
      
        
        
 public class ProducerConsumer
 {
        
   public static int ReadInteger(String Prompt) throws IOException
   {
     BufferedReader br=new BufferedReader(
                       new InputStreamReader(System.in));  
    
     System.out.println("\n"+Prompt);
     return Integer.parseInt(br.readLine());
     
   }
   
   public static void main(String arg[]) throws IOException,InterruptedException  
   {
     
     int Consumers,Producers;
     Consumer c[]=new Consumer[Consumers=ReadInteger("Number of Consumers:")];
     Producer p[]=new Producer[Producers=ReadInteger("Number of Producers:")]; 

     Queue Q=new Queue(ReadInteger("Size of Product Queue:")); 
     int i;
     for(i=0;i<Producers;i++)
         p[i]=new Producer(i+1,Q);
 
     for(i=0;i<Consumers;i++)
         c[i]=new Consumer(i+1,Q);

     
     Thread.sleep(20000);
      
     Producer.Stop();Consumer.Stop();

     try{ for(i=0;i<Producers;i++) p[i].Thrd.join(); }
     catch(InterruptedException e){}
     try{ for(i=0;i<Consumers;i++) c[i].Thrd.join(); }
     catch(InterruptedException e){}
    
     Q.Display("\n\n\nRemaining Items\n\n");
  }
 
}
     
     
