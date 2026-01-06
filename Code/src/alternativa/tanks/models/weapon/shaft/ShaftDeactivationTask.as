package alternativa.tanks.models.weapon.shaft
{
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.camera.GameCamera;
   
   public class ShaftDeactivationTask extends BattleRunnerProvider implements LogicUnit
   {
      
      private static const FOV_SPEED:Number = 5 * 0.001;
      
      private static const ALPHA_SPEED:Number = 5 * 0.001;
      
      private static const DEFAULT_TARGET_FOV:Number = Math.PI / 2;
      
      private var camera:GameCamera;
      
      private var skin:TankSkin;
      
      private var targetFov:Number;
      
      public function ShaftDeactivationTask(param1:GameCamera)
      {
         super();
         this.camera = param1;
         this.targetFov = DEFAULT_TARGET_FOV;
      }
      
      public function setSkin(param1:TankSkin) : void
      {
         this.skin = param1;
      }
      
      public function setTargetFov(param1:Number) : void
      {
         this.targetFov = param1;
      }
      
      public function start() : void
      {
         getBattleRunner().addLogicUnit(this);
      }
      
      public function stop() : void
      {
         getBattleRunner().removeLogicUnit(this);
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         this.camera.fov += FOV_SPEED * param2;
         if(this.camera.fov > this.targetFov)
         {
            this.camera.fov = this.targetFov;
         }
         var _loc3_:Number = this.skin.getHullAlpha();
         _loc3_ += ALPHA_SPEED * param2;
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         this.skin.setAlpha(_loc3_);
         if(this.camera.fov == this.targetFov && _loc3_ == 1)
         {
            this.stop();
         }
      }
   }
}

