package alternativa.tanks.models.weapons.targeting.priority.targeting
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
   import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
   
   public class ShaftTargetPriorityCalculator implements TargetPriorityCalculator
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private const MAX_DISTANCE:Number = 10000000000;
      
      private var commonTargetEvaluator:CommonTargetEvaluator;
      
      private var maxAngle:Number;
      
      public function ShaftTargetPriorityCalculator(param1:WeaponObject)
      {
         super();
         this.commonTargetEvaluator = battleService.getCommonTargetEvaluator();
         var _loc2_:VerticalAutoAiming = param1.verticalAutoAiming();
         this.maxAngle = _loc2_.getMaxAngle();
      }
      
      public function getTargetPriority(param1:Tank, param2:Number, param3:Number) : Number
      {
         return this.commonTargetEvaluator.getTargetPriority(param1.getBody(),param2,param3,this.MAX_DISTANCE,this.maxAngle);
      }
   }
}

