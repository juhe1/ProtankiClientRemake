package alternativa.tanks.models.weapon.common
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretControllerFactory;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponConst;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battlefield.models.tankparts.weapon.common.IWeaponCommonModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonModelBase;
   
   [ModelInfo]
   public class WeaponCommonModel extends WeaponCommonModelBase implements IWeaponCommonModelBase, IWeaponCommonModel, WeaponSound
   {
      
      [Inject]
      public static var display:IDisplay;
      
      private static var allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      public function WeaponCommonModel()
      {
         super();
      }
      
      public function getCommonData() : WeaponCommonData
      {
         var _loc2_:WeaponCommonCC = null;
         var _loc1_:WeaponCommonData = WeaponCommonData(getData(WeaponCommonData));
         if(_loc1_ == null)
         {
            _loc2_ = getInitParam();
            _loc1_ = new WeaponCommonData(_loc2_.turretRotationSpeed,_loc2_.turretRotationAcceleration,_loc2_.impactForce * WeaponConst.BASE_IMPACT_FORCE.getNumber(),_loc2_.kickback * WeaponConst.BASE_IMPACT_FORCE.getNumber());
            putData(WeaponCommonData,_loc1_);
         }
         return _loc1_;
      }
      
      public function getTurretController() : TurretController
      {
         var _loc1_:TurretController = TurretController(getData(TurretController));
         if(_loc1_ == null)
         {
            putData(TurretController,_loc1_ = new TurretController(object,true));
         }
         return _loc1_;
      }
      
      public function getLocalTurretController() : LocalTurretController
      {
         var _loc2_:TurretController = null;
         var _loc1_:LocalTurretController = LocalTurretController(getData(LocalTurretController));
         if(_loc1_ == null)
         {
            _loc2_ = new TurretController(object,false);
            putData(TurretController,_loc2_);
            if(object.hasModel(LocalTurretControllerFactory))
            {
               _loc1_ = LocalTurretControllerFactory(object.adapt(LocalTurretControllerFactory)).createLocalTurretController(_loc2_);
            }
            else
            {
               _loc1_ = new LocalTurretController(_loc2_);
            }
            putData(LocalTurretController,_loc1_);
         }
         return _loc1_;
      }
      
      public function getTurretRotationSound() : SoundResource
      {
         return getInitParam().turretRotationSound;
      }
      
      public function storeTank(param1:Tank) : void
      {
         putData(Tank,param1);
      }
      
      public function getTank() : Tank
      {
         return Tank(getData(Tank));
      }
      
      public function getGunParams(param1:int = 0) : AllGlobalGunParams
      {
         this.getTank().getAllGunParams(allGunParams,param1);
         return allGunParams;
      }
   }
}

