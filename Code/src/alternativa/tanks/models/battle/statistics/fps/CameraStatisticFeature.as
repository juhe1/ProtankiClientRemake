package alternativa.tanks.models.battle.statistics.fps
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.camera.GameCamera;
   
   public class CameraStatisticFeature
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var fieldName:String;
      
      private var bit:int;
      
      public function CameraStatisticFeature(param1:String, param2:int)
      {
         super();
         this.fieldName = param1;
         this.bit = param2;
      }
      
      public function isTesting() : Boolean
      {
         var _loc1_:Number = this.getStrength();
         return 0 < _loc1_ && _loc1_ < 1;
      }
      
      public function getMask() : int
      {
         return this.getStrength() == 1 ? this.bit : 0;
      }
      
      private function getStrength() : Number
      {
         var _loc1_:GameCamera = battleService.getBattleScene3D().getCamera();
         return _loc1_[this.fieldName];
      }
   }
}

