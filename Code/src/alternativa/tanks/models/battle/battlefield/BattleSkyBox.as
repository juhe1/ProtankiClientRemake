package alternativa.tanks.models.battle.battlefield
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.SkyBox;
   import projects.tanks.client.battlefield.models.map.SkyboxSides;
   
   public class BattleSkyBox extends SkyBox
   {
      
      private static const SKYBOX_SIZE:int = 200000;
      
      public function BattleSkyBox(param1:SkyboxSides)
      {
         var _loc2_:TextureMaterial = new TextureMaterial(param1.left.data);
         var _loc3_:TextureMaterial = new TextureMaterial(param1.right.data);
         var _loc4_:TextureMaterial = new TextureMaterial(param1.front.data);
         var _loc5_:TextureMaterial = new TextureMaterial(param1.back.data);
         var _loc6_:TextureMaterial = new TextureMaterial(param1.top.data);
         var _loc7_:TextureMaterial = new TextureMaterial(param1.bottom.data);
         super(SKYBOX_SIZE,_loc2_,_loc3_,_loc5_,_loc4_,_loc7_,_loc6_,0);
      }
   }
}

