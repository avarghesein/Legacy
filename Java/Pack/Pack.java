
 package Pack;
 
 import java.io.*;
 
 public class Pack
 {
   public static double ReadDouble() throws IOException
   {
     BufferedReader br=new BufferedReader(
                       new InputStreamReader(System.in));  
    
     Double num=new Double(br.readLine());
     
     return num.doubleValue();
   }

   public static void main(String arg[])
   {
     double n1,n2;
    
     try
     {
        System.out.println("\n\nEnter First Number\n");
        n1=ReadDouble();   
        System.out.println("\n\nEnter Second Number\n");
        n2=ReadDouble();    
        if(n1==n2)
           System.out.println("\n\n"+n1+" equal to "+n2+"\n\n");
        else if(n1>n2)
           System.out.println("\n\n"+n1+" is greater than "+n2+"\n\n");
        else 
           System.out.println("\n\n"+n2+" is greater than "+n1+"\n\n");
 
        return;
     }
  
     catch(Exception e)
     {
         System.out.println("\n\nIllegal Input Format\n\nError:"+e.getMessage());
         return;
     }
   }
 }    