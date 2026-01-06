package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.physics.Body;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.objects.tank.Tank;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class TeamDMRicochetTargetEvaluator extends BaseRicochetTargeEvaluator implements RicochetTargetEvaluator, TeamDMTargetEvaluator
   {
      
      private var teamType:BattleTeam;
      
      public function TeamDMRicochetTargetEvaluator()
      {
         super();
      }
      
      public function setLocalTeamType(param1:BattleTeam) : void
      {
         this.teamType = param1;
      }
      
      public function getTargetPriority(param1:Body, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Number
      {
         var _loc7_:Tank = param1.tank;
         if(!_loc7_.isSameTeam(this.teamType))
         {
            return getBasePriority(_loc7_,param2,param3,param4,param5,param6);
         }
         return 0;
      }
   }
}

