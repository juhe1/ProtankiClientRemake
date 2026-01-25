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
   
   public class TargetingSectorsCalculator
   {
      
      [Inject] // added
      public static var tankUsersRegistry:TankUsersRegistry;
      
      private var upDirection:Vector3 = new Vector3();
      
      private var self:IGameObject;
      
      private var maxDistance:Number;
      
      private var weapon:WeaponObject;
      
      public function TargetingSectorsCalculator(param1:IGameObject, param2:WeaponObject, param3:Number)
      {
         super();
         this.self = param1;
         this.weapon = param2;
         this.maxDistance = param3;
      }
      
      public function getSectors(param1:AllGlobalGunParams) : Vector.<TargetingSector>
      {
         var _loc3_:IGameObject = null;
         var _loc2_:Vector.<TargetingSector> = new Vector.<TargetingSector>();
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
      
      private function calculateSectorAndAdd(param1:AllGlobalGunParams, param2:Vector3, param3:Tank, param4:Vector.<TargetingSector>) : void
      {
         var _loc5_:Vector3 = BattleUtils.tmpVector;
         _loc5_.diff(param3.getBody().state.position,param1.barrelOrigin);
         var _loc6_:Number = _loc5_.length();
         var _loc7_:Number = Math.max(0,_loc5_.length() - param3.getBoundSphereRadius());
         if(_loc7_ > this.maxDistance)
         {
            return;
         }
         var _loc8_:Vector3 = param1.elevationAxis;
         var _loc9_:Vector3 = param1.direction;
         var _loc10_:Number = _loc5_.dot(_loc8_);
         var _loc11_:Number = _loc5_.dot(_loc9_);
         var _loc12_:Number = _loc5_.dot(param2);
         var _loc13_:Number = Math.atan2(_loc10_,_loc11_);
         var _loc14_:Number = Math.atan2(_loc12_,_loc11_);
         var _loc15_:Number = Math.min(param3.getBoundSphereRadius(),_loc6_);
         var _loc16_:Number = Math.asin(_loc15_ / _loc6_);
         var _loc17_:Number = _loc16_;
         var _loc18_:Number = _loc16_;

         // Horizontal auto-aiming limits
         if(Math.abs(_loc13_) > _loc17_)
         {
            return;
         }
         var _loc19_:VerticalAutoAiming = this.weapon.verticalAutoAiming();
         var _loc20_:Number = Math.max(_loc14_ - _loc18_,-_loc19_.getElevationAngleDown());
         var _loc21_:Number = Math.min(_loc14_ + _loc18_,_loc19_.getElevationAngleUp());
         if(_loc20_ < _loc21_)
         {
            param4.push(new TargetingSector(_loc20_,_loc21_,_loc7_,param3));
         }
      }
      
      private function getTank(param1:IGameObject) : Tank
      {
         var _loc2_:ITankModel = ITankModel(param1.adapt(ITankModel));
         return _loc2_.getTank();
      }
   }
}

