package alternativa.tanks.models.weapons.targeting.direction.sector
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.tanks.models.weapons.targeting.debug.TargetingVisualDebug;
   
   public class CheatTargetingSectorsCalculator
   {
      
      [Inject] // added
      public static var tankUsersRegistry:TankUsersRegistry;
      
      private var upDirection:Vector3 = new Vector3();
      
      private var self:IGameObject;
      
      private var maxDistance:Number;
      
      private var weapon:WeaponObject;
      
      public static var maxAngleUpOverride:Number = 0;
      public static var maxAngleDownOverride:Number = 0;
      public static var maxAngleLeft:Number = 0;
      public static var maxAngleRight:Number = 0;
      
      public function CheatTargetingSectorsCalculator(param1:IGameObject, param2:WeaponObject, param3:Number)
      {
         super();
         this.self = param1;
         this.weapon = param2;
         this.maxDistance = param3;
      }
      
      public function getSectors(param1:AllGlobalGunParams) : Vector.<TargetingSector2D>
      {
         var _loc3_:IGameObject = null;
         var _loc2_:Vector.<TargetingSector2D> = new Vector.<TargetingSector2D>();
         this.upDirection.cross2(param1.elevationAxis,param1.direction);
         for each(_loc3_ in tankUsersRegistry.getUsers())
         {
            if(_loc3_ != this.self)
            {
               this.calculateSectorAndAdd(param1,this.upDirection,this.getTank(_loc3_),_loc2_);
            }
         }
         return _loc2_;
      }
      
      private function calculateSectorAndAdd(gunParams:AllGlobalGunParams, upDirection:Vector3, targetTank:Tank, sectors:Vector.<TargetingSector2D>) : void
      {
         var toTarget:Vector3 = BattleUtils.tmpVector;
         toTarget.diff(targetTank.getBody().state.position,gunParams.barrelOrigin);
         var distanceToTarget:Number = toTarget.length();
         var effectiveDistance:Number = Math.max(0,toTarget.length() - targetTank.getBoundSphereRadius());
         if(effectiveDistance > this.maxDistance)
         {
            return;
         }

         var gunRight = gunParams.elevationAxis.clone();
         var gunForward = gunParams.direction.clone();
         var gunUp:Vector3 = gunRight.clone().cross(gunForward).normalize();

         var pitch:Number = Math.atan2(
             toTarget.dot(gunUp),
             toTarget.dot(gunForward)
         );

         var yaw:Number = Math.atan2(
             -toTarget.dot(gunRight),
             toTarget.dot(gunForward)
         );

         var effectiveRadius:Number = Math.min(targetTank.getBoundSphereRadius(),distanceToTarget);
         var angularRadius:Number = Math.asin(effectiveRadius / distanceToTarget);
         var horizontalTolerance:Number = angularRadius;
         var verticalTolerance:Number = angularRadius;
         
         var yawAbs:Number = Math.abs(yaw);

         // If horizontal aiming is not used, skip targets that are outside horizontal tolerance
         if(maxAngleLeft == 0 && maxAngleRight == 0 && yawAbs > horizontalTolerance)
         {
            return;
         } else if (yaw > maxAngleRight + verticalTolerance || yaw < -(maxAngleLeft + verticalTolerance)) {
            return;
         }

         var verticalAutoAiming:VerticalAutoAiming = this.weapon.verticalAutoAiming();

         var down:Number;
         var up:Number;
         if (maxAngleUpOverride == 0 && maxAngleDownOverride == 0) {
            down = Math.max(pitch - verticalTolerance,-verticalAutoAiming.getElevationAngleDown());
            up = Math.min(pitch + verticalTolerance,verticalAutoAiming.getElevationAngleUp());
         } else {
            down = Math.max(pitch - verticalTolerance,-maxAngleDownOverride);
            up = Math.min(pitch + verticalTolerance,maxAngleUpOverride);
         }

         var left:Number = Math.max(yaw - horizontalTolerance, -maxAngleLeft);
         var right:Number = Math.min(yaw + horizontalTolerance, maxAngleRight);

         if(down < up)
         {
            sectors.push(new TargetingSector2D(down,up,left,right,effectiveDistance,targetTank));
         }
      }
      
      private function getTank(param1:IGameObject) : Tank
      {
         var _loc2_:ITankModel = ITankModel(param1.adapt(ITankModel));
         return _loc2_.getTank();
      }
   }
}

