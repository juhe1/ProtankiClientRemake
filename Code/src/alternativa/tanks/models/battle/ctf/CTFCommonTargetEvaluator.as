
package alternativa.tanks.models.battle.ctf
{
   import alternativa.physics.Body;
   import alternativa.tanks.battle.CTFTargetEvaluator;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.battlefield.CommonTargetEvaluatorConst;
   import alternativa.tanks.models.weapon.FlagTargetEvaluator;
   import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.client.battlefield.models.battle.ctf.ClientFlag;
   
   public class CTFCommonTargetEvaluator implements CommonTargetEvaluator, CTFTargetEvaluator
   {
      
      private static const FLAG_CARRIER_PRIORITY_BONUS:Number = 5;
      
      private var localTeamType:BattleTeam;
      
      private var flagCarrier:Body;
      
      public function CTFCommonTargetEvaluator()
      {
         super();
      }
      
      public function setLocalTeamType(param1:BattleTeam) : void
      {
         this.localTeamType = param1;
      }
      
      public function setFlagCarrier(param1:Body) : void
      {
         this.flagCarrier = param1;
      }
      
      public function getTargetPriority(param1:Body, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         var _loc7_:Number = NaN;
         var _loc6_:Tank = param1.tank;
         if(_loc6_.health > 0 && !_loc6_.isSameTeam(this.localTeamType))
         {
            _loc7_ = param1 == this.flagCarrier ? FLAG_CARRIER_PRIORITY_BONUS : 0;
            return CommonTargetEvaluatorConst.MAX_PRIORITY - (CommonTargetEvaluatorConst.DISTANCE_WEIGHT * param2 / param4 + (1 - CommonTargetEvaluatorConst.DISTANCE_WEIGHT) * Math.abs(param3) / param5) + _loc7_;
         }
         return 0;
      }
   }
}
