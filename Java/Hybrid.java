
 class Student
 {
   int rlno;
   Student(int rlno)
   {
     this.rlno=rlno;
   }
   void PutStudent()
   {
     System.out.println("\n\n\nRoll Number of the Student:"+rlno);
     return;
   }
 }

 class Test extends Student
 {
   float Part1,Part2;
   Test(int rlno,float Part1,float Part2)
   {
     super(rlno);
     this.Part1=Part1; 
     this.Part2=Part2; 
   }
   void PutTest()
   {
     System.out.println("\nMark for Part1:"+Part1); 
     System.out.println("\nMark for Part2:"+Part2); 
   }
 }

 interface Sport
 {
   final float Spwt=6.0F;
   abstract void PutSport(); 
 }

 class Result extends Test implements Sport
 {
   float Total;
   Result(int rlno,float Part1,float Part2)
   {      super(rlno,Part1,Part2);	  }
   public void PutSport()
   {
      System.out.println("\nSport Weight:"+Spwt);
   }
   void PutResult()
   {
      Total=Part1+Part2+Spwt;
      PutStudent();   
      PutTest();
      PutSport();
      System.out.println("\nTotal Score:"+Total+"\n\n");
      return;
   }
 }

 public class Hybrid
 {
   public static void main(String s[])
   {
     Result Res=new Result(1024,27.8F,36.6F);
     Res.PutResult();
     return;
   }
 }