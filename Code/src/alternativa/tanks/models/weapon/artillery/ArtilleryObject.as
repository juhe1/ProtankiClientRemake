package alternativa.tanks.models.weapon.artillery
{
   import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfx;
   import alternativa.tanks.models.weapon.splash.Splash;
   import alternativa.tanks.models.weapons.charging.DummyWeaponChargingCommunication;
   import alternativa.tanks.models.weapons.charging.WeaponChargingCommunication;
   import alternativa.tanks.models.weapons.shell.ShellWeaponObject;
   import platform.client.fp10.core.type.IGameObject;
   
   public class ArtilleryObject extends ShellWeaponObject
   {
      
      public function ArtilleryObject(param1:IGameObject)
      {
         super(param1);
      }
      
      public function splash() : Splash
      {
         return Splash(object.adapt(Splash));
      }
      
      public function charging() : WeaponChargingCommunication
      {
         if(remote)
         {
            return DummyWeaponChargingCommunication.INSTANCE;
         }
         return WeaponChargingCommunication(object.adapt(WeaponChargingCommunication));
      }
      
      public function sfx() : ArtillerySfx
      {
         return ArtillerySfx(object.adapt(ArtillerySfx));
      }
      
      public function getSkin() : ArtilleryTurretSkin
      {
         return ArtillerySkin(object.adapt(ArtillerySkin)).getSkin();
      }
      
      public function getEffects() : ArtilleryEffects
      {
         return ArtilleryEffectsProvider(object.adapt(ArtilleryEffectsProvider)).getArtilleryEffects();
      }
   }
}

