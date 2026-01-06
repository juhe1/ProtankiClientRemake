package alternativa.tanks.models.battle.tdm
{
   import alternativa.physics.Body;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.shared.HealingGunTargetEvaluator;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class TDMHealingGunTargetEvaluator implements HealingGunTargetEvaluator, TeamDMTargetEvaluator
   {
      
      private static const ACCURACY:Number = 0.0001;
      
      private var localTeamType:BattleTeam;
      
      public function TDMHealingGunTargetEvaluator()
      {
         super();
      }
      
      public function setLocalTeamType(param1:BattleTeam) : void
      {
         this.localTeamType = param1;
      }
      
      public function getTargetPriority(param1:Body) : Number
      {
         var _loc3_:int = 0;
         var _loc2_:Tank = param1.tank;
         if(_loc2_.isSameTeam(this.localTeamType))
         {
            _loc3_ = 0;
            if(_loc2_.getTemperature() > ACCURACY)
            {
               _loc3_ = 5;
            }
            else if(_loc2_.getTemperature() < -ACCURACY)
            {
               _loc3_ = 4;
            }
            return _loc2_.health > _loc2_.getMaxHealth() - ACCURACY ? 1 : 3 + _loc3_;
         }
         return 2;
      }
   }
}

