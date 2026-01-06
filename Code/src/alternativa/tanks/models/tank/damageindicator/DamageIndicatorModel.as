package alternativa.tanks.models.tank.damageindicator
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.sfx.damageindicator.DamageIndicatorEffect;
   import forms.ColorConstants;
   import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorModelBase;
   import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorType;
   import projects.tanks.client.battlefield.models.user.damageindicator.IDamageIndicatorModelBase;
   import projects.tanks.client.battlefield.models.user.damageindicator.TargetTankDamage;
   
   [ModelInfo]
   public class DamageIndicatorModel extends DamageIndicatorModelBase implements IDamageIndicatorModelBase
   {
      
      public function DamageIndicatorModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function showDamageForShooter(param1:Vector.<TargetTankDamage>) : void
      {
         var _loc2_:TargetTankDamage = null;
         var _loc3_:Tank = null;
         var _loc4_:Vector3 = null;
         var _loc5_:Object3D = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.target != null)
            {
               _loc3_ = ITankModel(_loc2_.target.adapt(ITankModel)).getTank();
               _loc4_ = BattleUtils.tmpVector;
               if(_loc3_.isLastHitPointSet)
               {
                  _loc4_.copy(_loc3_.lastHitPoint);
                  BattleUtils.localToGlobal(_loc3_.getBody(),_loc4_);
               }
               else
               {
                  _loc5_ = _loc3_.getTurret3D();
                  _loc4_.reset(_loc5_.x,_loc5_.y,_loc5_.z);
               }
               DamageIndicatorEffect.start(_loc4_,this.getEffectColor(_loc2_),_loc2_.damageAmount);
            }
         }
      }
      
      private function getEffectColor(param1:TargetTankDamage) : uint
      {
         switch(param1.damageIndicatorType)
         {
            case DamageIndicatorType.FATAL:
               return ColorConstants.USER_TITLE_RED;
            case DamageIndicatorType.CRITICAL:
               return ColorConstants.USER_TITLE_YELLOW;
            case DamageIndicatorType.HEAL:
               return ColorConstants.GREEN_TEXT;
            default:
               return ColorConstants.WHITE;
         }
      }
   }
}

