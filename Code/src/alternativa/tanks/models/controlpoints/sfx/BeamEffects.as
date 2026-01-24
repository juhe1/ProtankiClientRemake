package alternativa.tanks.models.controlpoints.sfx
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.sfx.GraphicEffect;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   
   public class BeamEffects
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var effects:Dictionary = new Dictionary();
      
      public function BeamEffects()
      {
         super();
      }
      
      public function addEffect(param1:IGameObject, param2:GraphicEffect) : void
      {
         this.effects[param1] = param2;
         battleService.getBattleScene3D().addGraphicEffect(param2);
      }
      
      public function removeEffect(param1:IGameObject) : void
      {
         var _loc2_:GraphicEffect = this.effects[param1];
         if(_loc2_ != null)
         {
            _loc2_.kill();
            delete this.effects[param1];
         }
      }
   }
}

