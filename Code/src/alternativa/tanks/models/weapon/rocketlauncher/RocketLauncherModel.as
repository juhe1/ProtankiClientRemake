package alternativa.tanks.models.weapon.rocketlauncher
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.RemoteRocketLauncherWeapon;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeapon;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponProvider;
   import alternativa.tanks.models.weapons.shell.ShellWeaponListener;
   import alternativa.tanks.models.weapons.shell.TargetShellWeaponListener;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.IRocketLauncherModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherModelBase;
   
   [ModelInfo]
   public class RocketLauncherModel extends RocketLauncherModelBase implements IRocketLauncherModelBase, ShellWeaponListener, TargetShellWeaponListener, ObjectLoadListener, IWeaponModel, RocketLauncherWeaponProvider
   {
      
      public function RocketLauncherModel()
      {
         super();
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:RocketLauncherObject = new RocketLauncherObject(object);
         return new RocketLauncherWeapon(param1,_loc2_,getInitParam());
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:RocketLauncherObject = new RocketLauncherObject(object);
         _loc2_.markAsRemote();
         var _loc3_:RemoteRocketLauncherWeapon = new RemoteRocketLauncherWeapon(_loc2_,getInitParam());
         putData(RemoteRocketLauncherWeapon,_loc3_);
         return _loc3_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:RocketLauncherCC = getInitParam();
         _loc1_.minSpeed = BattleUtils.toClientScale(_loc1_.minSpeed);
         _loc1_.maxSpeed = BattleUtils.toClientScale(_loc1_.maxSpeed);
         _loc1_.shellRadius = BattleUtils.toClientScale(_loc1_.shellRadius);
         _loc1_.shotRange = BattleUtils.toClientScale(_loc1_.shotRange);
      }
      
      public function onShot(param1:int, param2:int, param3:Vector3) : void
      {
         this.remoteWeapon().simpleShoot(param1,param3,param2);
      }
      
      public function onDummyShot(param1:int) : void
      {
         this.remoteWeapon().dummyShoot(param1);
      }
      
      public function onShotWithTarget(param1:int, param2:int, param3:Vector3, param4:Tank, param5:Vector3) : void
      {
         this.remoteWeapon().salvoShoot(param1,param3,param2,param4,param5);
      }
      
      public function remoteWeapon() : RemoteRocketLauncherWeapon
      {
         return RemoteRocketLauncherWeapon(getData(RemoteRocketLauncherWeapon));
      }
   }
}

