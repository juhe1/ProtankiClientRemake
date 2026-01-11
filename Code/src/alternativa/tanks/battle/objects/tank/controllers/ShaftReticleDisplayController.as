package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.BattleView;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.weapon.shaft.ReticleDisplay;
   import alternativa.engine3d.alternativa3d;

   use namespace alternativa3d;
   
   public class ShaftReticleDisplayController
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var camera:GameCamera;
      
      private var reticleDisplay:ReticleDisplay;
      
      public function ShaftReticleDisplayController(param1:ReticleDisplay)
      {
         super();
         this.reticleDisplay = param1;
         this.camera = battleService.getBattleScene3D().getCamera();
      }
      
      public function update(param1:Vector3) : void
      {
         var _loc11_:BattleView = null;
         var _loc2_:Number = Number(this.camera.focalLength);
         var _loc3_:Number = Number(this.camera.viewSizeX);
         var _loc4_:Number = Number(this.camera.viewSizeY);
         var _loc5_:Number = Math.atan((_loc4_ + this.reticleDisplay.height / 2) / _loc2_);
         var _loc6_:Number = Math.atan((_loc3_ + this.reticleDisplay.width / 2) / _loc2_);
         var _loc7_:Matrix3 = BattleUtils.tmpMatrix3;
         _loc7_.setRotationMatrixForObject3D(this.camera);
         var _loc8_:Vector3 = BattleUtils.tmpVector;
         _loc7_.transformVectorInverse(param1,_loc8_);
         var _loc9_:Number = Math.atan2(_loc8_.x,_loc8_.z);
         var _loc10_:Number = Math.atan2(_loc8_.y,_loc8_.z);
         this.reticleDisplay.visible = Math.abs(_loc10_) <= _loc5_ && Math.abs(_loc9_) <= _loc6_;
         if(this.reticleDisplay.visible)
         {
            _loc11_ = battleService.getBattleView();
            this.reticleDisplay.x = _loc11_.getX() + Math.tan(_loc9_) * _loc2_ + _loc3_ - this.reticleDisplay.width / 2;
            this.reticleDisplay.y = _loc11_.getY() + Math.tan(_loc10_) * _loc2_ + _loc4_ - this.reticleDisplay.height / 2;
         }
      }
   }
}

