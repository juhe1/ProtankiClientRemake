package alternativa.tanks.display
{
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.sfx.Blinker;
   
   public class EffectBlinkerUtil
   {
      
      public static const EFFECT_WARNING_PERIOD:int = 3000;
      
      public static const FIRST_AID_WARNING_PERIOD:int = 100000;
      
      public static const INITIAL_BLINK_INTERVAL:int = 300;
      
      public static const MIN_INTERVAL:int = 20;
      
      public static const BLINK_INTERVAL_DECREMENT:int = 30;
      
      public static const FIRST_AID_BLINK_INTERVAL_DECREMENT:int = 0;
      
      public static const MIN_VALUE:Number = 0.2;
      
      public static const MAX_VALUE:Number = 1;
      
      public static const SPEED_COEFF:Number = 10;
      
      public function EffectBlinkerUtil()
      {
         super();
      }
      
      public static function createBlinker(param1:int) : Blinker
      {
         var _loc7_:int = 0;
         var _loc2_:int = int(EffectBlinkerUtil.INITIAL_BLINK_INTERVAL);
         var _loc3_:int = int(EffectBlinkerUtil.MIN_INTERVAL);
         var _loc4_:Number = Number(EffectBlinkerUtil.MIN_VALUE);
         var _loc5_:Number = Number(EffectBlinkerUtil.MAX_VALUE);
         var _loc6_:Number = Number(EffectBlinkerUtil.SPEED_COEFF);
         if(param1 == InventoryItemType.FIRST_AID)
         {
            _loc7_ = int(EffectBlinkerUtil.FIRST_AID_BLINK_INTERVAL_DECREMENT);
         }
         else
         {
            _loc7_ = int(EffectBlinkerUtil.BLINK_INTERVAL_DECREMENT);
         }
         return new Blinker(_loc2_,_loc3_,_loc7_,_loc4_,_loc5_,_loc6_);
      }
      
      public static function getBlinkingPeriod(param1:int) : int
      {
         if(param1 == InventoryItemType.FIRST_AID)
         {
            return EffectBlinkerUtil.FIRST_AID_WARNING_PERIOD;
         }
         return EffectBlinkerUtil.EFFECT_WARNING_PERIOD;
      }
   }
}

