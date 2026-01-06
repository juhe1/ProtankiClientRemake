package alternativa.tanks.models.battle.gui.inventory.splash
{
   import alternativa.tanks.models.inventory.InventoryItemType;
   
   public class SplashColor
   {
      
      public static const WHITE:uint = 4294967295;
      
      public static const COOLDOWN:uint = 126;
      
      private static const FIRST_AID:uint = 3135184319;
      
      private static const ARMOR:uint = 3819201471;
      
      private static const DAMAGE:uint = 4285085631;
      
      private static const NITRO:uint = 4293333951;
      
      private static const MINE:uint = 14527935;
      
      private static const GOLD:uint = 4289270719;
      
      public function SplashColor()
      {
         super();
      }
      
      public static function getColor(param1:int) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case InventoryItemType.FIRST_AID:
               _loc2_ = SplashColor.FIRST_AID;
               break;
            case InventoryItemType.ARMOR:
               _loc2_ = SplashColor.ARMOR;
               break;
            case InventoryItemType.DAMAGE:
               _loc2_ = SplashColor.DAMAGE;
               break;
            case InventoryItemType.NITRO:
               _loc2_ = SplashColor.NITRO;
               break;
            case InventoryItemType.MINE:
               _loc2_ = SplashColor.MINE;
               break;
            case InventoryItemType.GOLD:
               _loc2_ = SplashColor.GOLD;
               break;
            default:
               _loc2_ = SplashColor.WHITE;
         }
         return _loc2_;
      }
   }
}

