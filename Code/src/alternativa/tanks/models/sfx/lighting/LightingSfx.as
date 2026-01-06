package alternativa.tanks.models.sfx.lighting
{
   import alternativa.tanks.sfx.LightAnimation;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingEffectEntity;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class LightingSfx
   {
      
      private var entity:LightingSFXEntity = null;
      
      public function LightingSfx(param1:LightingSFXEntity)
      {
         super();
         this.entity = param1;
      }
      
      public function createAnimation(param1:String) : LightAnimation
      {
         var _loc2_:LightingEffectEntity = null;
         for each(_loc2_ in this.entity.effects)
         {
            if(_loc2_.effectName == param1)
            {
               return new LightAnimation(_loc2_.items);
            }
         }
         return null;
      }
   }
}

