package alternativa.tanks.models.battle.ctf
{
   import alternativa.physics.Body;
   import alternativa.tanks.battle.CTFTargetEvaluator;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class CTFRailgunTargetEvaluator implements RailgunTargetEvaluator, CTFTargetEvaluator
   {
      
      private var localTeamType:BattleTeam;
      
      private var flagCarrier:Body;
      
      public function CTFRailgunTargetEvaluator()
      {
         super();
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
         if(param1 == this.flagCarrier)
         {
            return 10;
         }
         return 1;
      }
      
      public function setLocalTeamType(param1:BattleTeam) : void
      {
         this.localTeamType = param1;
      }
      
      public function setFlagCarrier(param1:Body) : void
      {
         this.flagCarrier = param1;
      }
      
      public function isFriendly(param1:Body) : Boolean
      {
         var _loc2_:Tank = param1.tank;
         return _loc2_.isSameTeam(this.localTeamType);
      }
   }
}

