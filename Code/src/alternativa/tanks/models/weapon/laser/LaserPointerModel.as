package alternativa.tanks.models.weapon.laser
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.tank.TankPartReset;
   import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.laser.ILaserPointerModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.laser.LaserPointerModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   [ModelInfo]
   public class LaserPointerModel extends LaserPointerModelBase implements LaserPointer, ILaserPointerModelBase, TankPartReset
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var localTankInfoService:LocalTankInfoService;
      
      public function LaserPointerModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function updateRemoteDirection(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.doUpdateLaserDirection(param1);
         }
      }
      
      [Obfuscation(rename="false")]
      public function aimRemoteAtTank(param1:IGameObject, param2:Vector3d) : void
      {
         if(param1 == null || BattleUtils.isVector3dNaN(param2))
         {
            return;
         }
         var _loc3_:ITankModel = ITankModel(param1.adapt(ITankModel));
         this.doAimAtTank(_loc3_.getTank(),BattleUtils.getVector3(param2));
      }
      
      [Obfuscation(rename="false")]
      public function hideRemote() : void
      {
         this.doHideLaser();
      }
      
      public function updateDirection(param1:Vector3) : void
      {
         var _loc2_:Matrix3 = BattleUtils.tmpMatrix3;
         _loc2_.setRotationMatrixForObject3D(localTankInfoService.getTurret3D());
         var _loc3_:Vector3 = BattleUtils.tmpVector;
         _loc2_.getUp(_loc3_);
         var _loc4_:Number = _loc3_.dot(param1);
         if(this.doUpdateLaserDirection(_loc4_))
         {
            server.updateDirection(_loc4_);
         }
      }
      
      public function aimAtTank(param1:Tank, param2:Vector3) : void
      {
         if(this.doAimAtTank(param1,param2))
         {
            server.aimAtTank(param1.getUser(),BattleUtils.getVector3d(param2));
         }
      }
      
      public function hideLaser() : void
      {
         if(this.doHideLaser())
         {
            server.hide();
         }
      }
      
      public function doUpdateLaserDirection(param1:Number) : Boolean
      {
         this.showLaserIfNeed();
         var _loc2_:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
         return _loc2_.updateDirection(param1);
      }
      
      private function doAimAtTank(param1:Tank, param2:Vector3) : Boolean
      {
         this.showLaserIfNeed();
         var _loc3_:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
         return _loc3_.aimAtTank(param1,param2);
      }
      
      private function showLaserIfNeed() : void
      {
         var _loc1_:LaserPointerEffect = this.getOrCreateLaser();
         if(_loc1_.isVisible())
         {
            return;
         }
         var _loc2_:Tank = this.getTank();
         var _loc3_:Boolean = Boolean(ITankModel(_loc2_.getUser().adapt(ITankModel)).isLocal());
         if(_loc3_ && !getInitParam().locallyVisible)
         {
            _loc1_.markAsVisible();
            return;
         }
         _loc1_.show(this.getColorForTeam(_loc2_.teamType));
      }
      
      private function getOrCreateLaser() : LaserPointerEffect
      {
         var _loc1_:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
         if(_loc1_ == null)
         {
            _loc1_ = new LaserPointerEffect(getInitParam().fadeInTimeMs,this.getTank());
            putData(LaserPointerEffect,_loc1_);
         }
         return _loc1_;
      }
      
      public function resetTankPart(param1:Tank) : void
      {
         this.getOrCreateLaser().reset(param1);
      }
      
      private function getTank() : Tank
      {
         return IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      }
      
      private function doHideLaser() : Boolean
      {
         var _loc1_:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
         if(Boolean(_loc1_) && _loc1_.isVisible())
         {
            _loc1_.hide();
            return true;
         }
         return false;
      }
      
      private function getColorForTeam(param1:BattleTeam) : uint
      {
         switch(param1)
         {
            case BattleTeam.BLUE:
               return this.getLaserPointerBlueColor();
            case BattleTeam.RED:
               return this.getLaserPointerRedColor();
            default:
               return this.getLaserPointerRedColor();
         }
      }
      
      public function getLaserPointerBlueColor() : uint
      {
         return uint(getInitParam().laserPointerBlueColor);
      }
      
      public function getLaserPointerRedColor() : uint
      {
         return uint(getInitParam().laserPointerRedColor);
      }
   }
}

