package alternativa.tanks.battle.objects.tank.tankskin.dynamic
{
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import flash.display.BitmapData;
   import alternativa.engine3d.alternativa3d;

   use namespace alternativa3d;
   
   public class DynamicSkinMaterial extends TextureMaterial
   {
       
      
      public function DynamicSkinMaterial(param1:BitmapData = null, param2:Boolean = false, param3:Boolean = true, param4:int = 0, param5:Number = 1)
      {
         super(param1,param2);
      }
      
      [Obfuscation(rename="false")]
      override alternativa3d function get transparent() : Boolean
      {
         return true;
      }
      
      [Obfuscation(rename="false")]
      override public function clone() : Material
      {
         var _loc1_:DynamicSkinMaterial = new DynamicSkinMaterial(texture,repeat,smooth,_mipMapping,resolution);
         _loc1_.clonePropertiesFrom(this);
         return _loc1_;
      }
   }
}