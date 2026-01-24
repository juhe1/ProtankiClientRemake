package alternativa.tanks.models.weapon.machinegun
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.machinegun.sfx.IMachineGunSFXModel;
   import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
   import alternativa.tanks.models.weapons.stream.StreamWeaponCommunication;
   import alternativa.tanks.models.weapons.stream.StreamWeaponListener;
   import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.IMachineGunModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.MachineGunModelBase;
   
   [ModelInfo]
   public class MachineGunModel extends MachineGunModelBase implements IMachineGunModelBase, StreamWeaponListener, IWeaponModel
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const MAX_DISTANCE:Number = 1000000;
      
      public function MachineGunModel()
      {
         super();
      }
      
      public function onStart() : void
      {
         this.remoteWeapon().start();
      }
      
      public function onStop() : void
      {
         this.remoteWeapon().stop();
      }
      
      public function onTargetsUpdated(param1:Vector3, param2:Vector.<TargetHit>) : void
      {
         this.remoteWeapon().updateTargets(param1,param2);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponObject = new WeaponObject(object);
         var _loc3_:WeaponCommonData = _loc2_.commonData();
         var _loc4_:TargetingSystem = new CommonTargetingSystem(param1,_loc2_,MAX_DISTANCE);
         var _loc5_:MachineGunWeapon = new MachineGunWeapon(_loc4_,param1,getInitParam(),this.getSfxData(),_loc3_,StreamWeaponCommunication(object.adapt(StreamWeaponCommunication)),object);
         putData(MachineGunWeapon,_loc5_);
         return _loc5_;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponObject = new WeaponObject(object);
         var _loc3_:WeaponCommonData = _loc2_.commonData();
         var _loc4_:MachineGunRemoteWeapon = new MachineGunRemoteWeapon(param1,getInitParam(),this.getSfxData(),_loc3_);
         putData(MachineGunRemoteWeapon,_loc4_);
         return _loc4_;
      }
      
      private function getSfxData() : MachineGunSFXData
      {
         return IMachineGunSFXModel(object.adapt(IMachineGunSFXModel)).getSfxData();
      }
      
      private function remoteWeapon() : MachineGunRemoteWeapon
      {
         return MachineGunRemoteWeapon(getData(MachineGunRemoteWeapon));
      }
   }
}

