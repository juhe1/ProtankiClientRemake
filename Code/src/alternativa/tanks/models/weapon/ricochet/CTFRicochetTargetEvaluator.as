package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.physics.Body;
   import alternativa.tanks.battle.CTFTargetEvaluator;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.commonflag.CommonFlag;
   import alternativa.tanks.models.weapon.FlagTargetEvaluator;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class CTFRicochetTargetEvaluator extends BaseRicochetTargeEvaluator implements RicochetTargetEvaluator, TeamDMTargetEvaluator, CTFTargetEvaluator
   {
      
      private static const FLAG_CARRIER_PRIORITY:int = 3;
      
      private var teamType:BattleTeam;
      
      private var flagTargetEvaluator:FlagTargetEvaluator = new FlagTargetEvaluator();
      
      public function CTFRicochetTargetEvaluator()
      {
         super();
      }
      
      public function setLocalTeamType(param1:BattleTeam) : void
      {
         this.teamType = param1;
      }
      
      public function setFlagCarrier(param1:CommonFlag, param2:Body) : void
      {
         this.flagTargetEvaluator.setFlagCarrier(param1,param2);
      }
      
      public function getTargetPriority(param1:Body, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Number
      {
         var _loc8_:Number = NaN;
         var _loc7_:Tank = param1.tank;
         if(!_loc7_.isSameTeam(this.teamType))
         {
            _loc8_ = getBasePriority(_loc7_,param2,param3,param4,param5,param6);
            if(this.flagTargetEvaluator.isCarrier(param1))
            {
               _loc8_ += FLAG_CARRIER_PRIORITY;
            }
            return _loc8_;
         }
         return 0;
      }
   }
}

