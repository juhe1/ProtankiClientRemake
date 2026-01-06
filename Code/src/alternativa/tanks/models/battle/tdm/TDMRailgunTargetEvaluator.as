package alternativa.tanks.models.battle.tdm
{
   import alternativa.physics.Body;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class TDMRailgunTargetEvaluator implements RailgunTargetEvaluator, TeamDMTargetEvaluator
   {
      
      private var localTeamType:BattleTeam;
      
      public function TDMRailgunTargetEvaluator()
      {
         super();
      }
      
      public function setLocalTeamType(param1:BattleTeam) : void
      {
         this.localTeamType = param1;
      }
      
      public function getHitEfficiency(param1:Body) : Number
      {
         var _loc2_:Tank = param1.tank;
         if(_loc2_.health <= 0)
         {
            return 0;
         }
         if(_loc2_.isSameTeam(this.localTeamType))
         {
            return 0;
         }
         return 1;
      }
      
      public function isFriendly(param1:Body) : Boolean
      {
         var _loc2_:Tank = param1.tank;
         return _loc2_.isSameTeam(this.localTeamType);
      }
   }
}

