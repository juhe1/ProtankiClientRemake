package alternativa.tanks.models.weapon.twins
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RemoteTwinsWeapon implements Weapon
   {
      
      private static const _gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var recoilForce:Number;
      
      private var ammunition:TwinsAmmunition;
      
      private var effects:TwinsEffects;
      
      private var weaponPlatform:WeaponPlatform;
      
      public function RemoteTwinsWeapon(param1:IGameObject, param2:TwinsCC)
      {
         super();
         var _loc3_:WeaponObject = new WeaponObject(param1);
         var _loc4_:WeaponCommonData = _loc3_.commonData();
         var _loc5_:ITwinsSFXModel = ITwinsSFXModel(param1.adapt(ITwinsSFXModel));
         var _loc6_:TwinsAmmunition = new TwinsAmmunition(_loc3_,param2,_loc5_.getSFXData());
         this.recoilForce = _loc4_.getRecoilForce();
         this.ammunition = _loc6_;
         this.effects = _loc5_.getPlasmaWeaponEffects();
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
      }
      
      public function fire(param1:int, param2:int, param3:Vector3) : void
      {
         this.weaponPlatform.getAllGunParams(_gunParams,param1);
         this.createShotEffects(param1,_gunParams);
         var _loc4_:TwinsShot = this.ammunition.getShot();
         _loc4_.addToGame(_gunParams,param3,this.weaponPlatform.getBody(),true,param2);
      }
      
      public function fireDummy(param1:int) : void
      {
         this.weaponPlatform.getAllGunParams(_gunParams,param1);
         this.createShotEffects(param1,_gunParams);
      }
      
      private function createShotEffects(param1:int, param2:AllGlobalGunParams) : void
      {
         this.weaponPlatform.getBody().addWorldForceScaled(param2.muzzlePosition,param2.direction,-this.recoilForce);
         this.weaponPlatform.addDust(1);
         this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(param1));
      }
      
      public function destroy() : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function deactivate() : void
      {
      }
      
      public function enable() : void
      {
      }
      
      public function disable(param1:Boolean) : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function getStatus() : Number
      {
         return 0;
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.TWINS_RESISTANCE;
      }
   }
}

