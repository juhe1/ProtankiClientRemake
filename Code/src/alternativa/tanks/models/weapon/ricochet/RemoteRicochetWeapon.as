package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RemoteRicochetWeapon implements Weapon
   {
      
      private static const _gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var recoilForce:Number;
      
      private var ammunition:RicochetAmmunition;
      
      private var effects:RicochetEffects;
      
      private var weaponPlatform:WeaponPlatform;
      
      public function RemoteRicochetWeapon(param1:IGameObject, param2:RicochetCC)
      {
         super();
         var _loc3_:IRicochetSFXModel = IRicochetSFXModel(param1.adapt(IRicochetSFXModel));
         var _loc4_:WeaponObject = new WeaponObject(param1);
         var _loc5_:RicochetAmmunition = new RicochetAmmunition(_loc4_,param2,_loc3_.getSfxData());
         this.recoilForce = _loc4_.commonData().getRecoilForce();
         this.ammunition = _loc5_;
         this.effects = _loc3_.getRicochetEffects();
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
      }
      
      public function shoot(param1:Vector3) : void
      {
         this.weaponPlatform.getAllGunParams(_gunParams);
         this.createShotEffects(_gunParams);
         var _loc2_:RicochetShot = this.ammunition.getShot();
         _loc2_.addToGame(_gunParams,param1,this.weaponPlatform.getBody(),true,-1);
      }
      
      public function shootDummy() : void
      {
         this.weaponPlatform.getAllGunParams(_gunParams);
         this.createShotEffects(_gunParams);
      }
      
      private function createShotEffects(param1:AllGlobalGunParams) : void
      {
         this.weaponPlatform.getBody().addWorldForceScaled(param1.muzzlePosition,param1.direction,-this.recoilForce);
         this.weaponPlatform.addDust();
         this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(),param1.muzzlePosition);
         this.effects.createLightEffect(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition());
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
         return ItemProperty.RICOCHET_RESISTANCE;
      }
   }
}

