package alternativa.tanks.models.weapon.weakening
{
   import alternativa.tanks.battle.BattleUtils;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.IWeaponWeakeningModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningModelBase;
   
   [ModelInfo]
   public class WeaponWeakeningModel extends WeaponWeakeningModelBase implements IWeaponWeakeningModelBase, IWeaponWeakeningModel, ObjectLoadListener
   {
      
      public function WeaponWeakeningModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:WeaponWeakeningCC = getInitParam();
         var _loc2_:WeaponWeakeningData = new WeaponWeakeningData();
         _loc2_.maximumDamageRadius = isNaN(_loc1_.maximumDamageRadius) ? 0 : BattleUtils.toClientScale(_loc1_.maximumDamageRadius);
         _loc2_.minimumDamageRadius = isNaN(_loc1_.minimumDamageRadius) ? 1 : BattleUtils.toClientScale(_loc1_.minimumDamageRadius);
         _loc2_.minimumDamagePercent = isNaN(_loc1_.minimumDamagePercent) ? 0 : _loc1_.minimumDamagePercent;
         if(_loc2_.minimumDamagePercent > 100)
         {
            _loc2_.minimumDamagePercent = 100;
         }
         putData(WeaponWeakeningData,_loc2_);
      }
      
      public function getDistanceWeakening() : DistanceWeakening
      {
         var _loc1_:WeaponWeakeningData = WeaponWeakeningData(getData(WeaponWeakeningData));
         return new DistanceWeakening(_loc1_.maximumDamageRadius,_loc1_.minimumDamageRadius,_loc1_.minimumDamagePercent);
      }
   }
}

