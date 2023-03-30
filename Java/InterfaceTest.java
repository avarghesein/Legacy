
 interface Area
 { 
   public final static double HALF=.5;
   public abstract double ComputeArea(float x,float y);
 }
 
 class Rectangle implements Area
 {
   public double ComputeArea(float x,float y)
   {
      return x*y;
   }
 }
 
 class Triangle implements Area
 {
   public double ComputeArea(float x,float y)
   {
      return HALF*x*y;
   }
 }
 
 class InterfaceTest
 {
   public static void main(String arg[])
   {
      Area a;
      Rectangle r=new Rectangle();
      Triangle t=new Triangle();

      a=r;
      System.out.println("\n\n\nArea Of Rectangle with Length=4,Height=3 is "+
      a.ComputeArea(4,3)); 
          
      a=t;
      System.out.println("\n\nArea Of Triangle with Base=4,Height=3 is "+
      a.ComputeArea(4,3)+"\n\n\n"); 

      return;
   }
 }	