package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.primitives.Plane;
   
   public class HelperMesh extends BSP
   {
      
      public function HelperMesh()
      {
         super();
         var _loc1_:Plane = new Plane();
         createTree(_loc1_);
         z = -20000;
         name = "static";
      }
   }
}

