package alternativa.tanks.models.drones
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.service.settings.ISettingsService;
   import flash.utils.getTimer;
   
   public class DroneOnGoRenderer extends AbstractDroneRenderer
   {
      
      private var speed:Number = 0;
      
      private var targetPosition:* = new Vector3();
      
      private var positionDelta:* = new Vector3();
      
      private var localTargetPosition:* = new Vector3();
      
      private const DISTANCE_THRESHOLD:* = 10;
      
      private const MAX_DRONE_SPEED:* = 5;
      
      public function DroneOnGoRenderer(param1:Boolean, param2:TankSkin, param3:Drone, param4:BattleService, param5:ISettingsService)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function render(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = param2 * 0.001;
         var _loc4_:Number = 0.1;
         var _loc5_:* = _loc3_ > _loc4_ ? _loc4_ : _loc3_;
         var _loc6_:* = getTimer() - startTime;
         this.localTargetPosition.copy(basePosition);
         getTurretMatrix().transformVector(this.localTargetPosition,this.targetPosition);
         this.positionDelta.diff(this.targetPosition,drone.getPosition());
         _loc3_ = Number(this.positionDelta.length());
         if(_loc3_ > this.DISTANCE_THRESHOLD)
         {
            this.speed = (_loc3_ - this.DISTANCE_THRESHOLD) * this.MAX_DRONE_SPEED;
         }
         var _loc7_:* = this.speed * _loc5_;
         if(_loc7_ > _loc3_)
         {
            _loc7_ = _loc3_;
         }
         this.positionDelta.normalize().scale(_loc7_);
         drone.getPosition().add(this.positionDelta);
         setPositionAndRotation(param1,param2);
         var _loc8_:Number = _loc6_ > 2000 ? 1 : _loc6_ / 2000;
         drone.getObject3D().z = drone.getObject3D().z + _loc8_ * Math.sin(param1 / 1000) * 10;
         updateVisibility();
      }
      
      override public function start() : void
      {
         super.start();
         targetAlpha = 1;
         alpha = 1;
      }
   }
}

