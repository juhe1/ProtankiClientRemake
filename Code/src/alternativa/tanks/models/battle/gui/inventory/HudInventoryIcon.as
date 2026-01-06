package alternativa.tanks.models.battle.gui.inventory
{
   import alternativa.tanks.models.inventory.InventoryItemType;
   import flash.display.BitmapData;
   import forms.ColorConstants;
   
   public class HudInventoryIcon
   {
      
      private static const ultimateBgdClass:Class = HudInventoryIcon_ultimateBgdClass;
      
      private static const ultimateBgdBitmapData:BitmapData = new ultimateBgdClass().bitmapData;
      
      private static const ultimateWhiteIconClass:Class = HudInventoryIcon_ultimateWhiteIconClass;
      
      private static const ultimateWhiteIconBitmapData:BitmapData = new ultimateWhiteIconClass().bitmapData;
      
      private static const bgdClass:Class = HudInventoryIcon_bgdClass;
      
      private static const bgdBitmapData:BitmapData = new bgdClass().bitmapData;
      
      private static const overdriveBg2xClass:Class = HudInventoryIcon_overdriveBg2xClass;
      
      private static const overdriveBgBitmapData:BitmapData = new overdriveBg2xClass().bitmapData;
      
      private static const lockClass:Class = HudInventoryIcon_lockClass;
      
      private static const lockBitmapData:BitmapData = new lockClass().bitmapData;
      
      private static const borderClass:Class = HudInventoryIcon_borderClass;
      
      private static const borderBitmapData:BitmapData = new borderClass().bitmapData;
      
      private static const darkClass:Class = HudInventoryIcon_darkClass;
      
      private static const darkBitmapData:BitmapData = new darkClass().bitmapData;
      
      private static const dark2xClass:Class = HudInventoryIcon_dark2xClass;
      
      private static const dark2xBitmapData:BitmapData = new dark2xClass().bitmapData;
      
      private static const firstAidBgdClass:Class = HudInventoryIcon_firstAidBgdClass;
      
      private static const firstAidBgdBitmapData:BitmapData = new firstAidBgdClass().bitmapData;
      
      private static const armorBgdClass:Class = HudInventoryIcon_armorBgdClass;
      
      private static const armorBgdBitmapData:BitmapData = new armorBgdClass().bitmapData;
      
      private static const damageBgdClass:Class = HudInventoryIcon_damageBgdClass;
      
      private static const damageBgdBitmapData:BitmapData = new damageBgdClass().bitmapData;
      
      private static const nitroBgdClass:Class = HudInventoryIcon_nitroBgdClass;
      
      private static const nitroBgdBitmapData:BitmapData = new nitroBgdClass().bitmapData;
      
      private static const mineBgdClass:Class = HudInventoryIcon_mineBgdClass;
      
      private static const mineBgdBitmapData:BitmapData = new mineBgdClass().bitmapData;
      
      private static const firstAidWhiteIconClass:Class = HudInventoryIcon_firstAidWhiteIconClass;
      
      private static const firstAidWhiteIconBitmapData:BitmapData = new firstAidWhiteIconClass().bitmapData;
      
      private static const armorWhiteIconClass:Class = HudInventoryIcon_armorWhiteIconClass;
      
      private static const armorWhiteIconBitmapData:BitmapData = new armorWhiteIconClass().bitmapData;
      
      private static const damageWhiteIconClass:Class = HudInventoryIcon_damageWhiteIconClass;
      
      private static const damageWhiteIconBitmapData:BitmapData = new damageWhiteIconClass().bitmapData;
      
      private static const nitroWhiteIconClass:Class = HudInventoryIcon_nitroWhiteIconClass;
      
      private static const nitroWhiteIconBitmapData:BitmapData = new nitroWhiteIconClass().bitmapData;
      
      private static const mineWhiteIconClass:Class = HudInventoryIcon_mineWhiteIconClass;
      
      private static const mineWhiteIconBitmapData:BitmapData = new mineWhiteIconClass().bitmapData;
      
      private static const firstAidColorIconClass:Class = HudInventoryIcon_firstAidColorIconClass;
      
      private static const firstAidColorIconBitmapData:BitmapData = new firstAidColorIconClass().bitmapData;
      
      private static const armorColorIconClass:Class = HudInventoryIcon_armorColorIconClass;
      
      private static const armorColorIconBitmapData:BitmapData = new armorColorIconClass().bitmapData;
      
      private static const damageColorIconClass:Class = HudInventoryIcon_damageColorIconClass;
      
      private static const damageColorIconBitmapData:BitmapData = new damageColorIconClass().bitmapData;
      
      private static const nitroColorIconClass:Class = HudInventoryIcon_nitroColorIconClass;
      
      private static const nitroColorIconBitmapData:BitmapData = new nitroColorIconClass().bitmapData;
      
      private static const mineColorIconClass:Class = HudInventoryIcon_mineColorIconClass;
      
      private static const mineColorIconBitmapData:BitmapData = new mineColorIconClass().bitmapData;
      
      private static const firstAidGrayIconClass:Class = HudInventoryIcon_firstAidGrayIconClass;
      
      private static const firstAidGrayIconBitmapData:BitmapData = new firstAidGrayIconClass().bitmapData;
      
      private static const armorGrayIconClass:Class = HudInventoryIcon_armorGrayIconClass;
      
      private static const armorGrayIconBitmapData:BitmapData = new armorGrayIconClass().bitmapData;
      
      private static const damageGrayIconClass:Class = HudInventoryIcon_damageGrayIconClass;
      
      private static const damageGrayIconBitmapData:BitmapData = new damageGrayIconClass().bitmapData;
      
      private static const nitroGrayIconClass:Class = HudInventoryIcon_nitroGrayIconClass;
      
      private static const nitroGrayIconBitmapData:BitmapData = new nitroGrayIconClass().bitmapData;
      
      private static const mineGrayIconClass:Class = HudInventoryIcon_mineGrayIconClass;
      
      private static const mineGrayIconBitmapData:BitmapData = new mineGrayIconClass().bitmapData;
      
      private static const goldBgdClass:Class = HudInventoryIcon_goldBgdClass;
      
      private static const goldBgdBitmapData:BitmapData = new goldBgdClass().bitmapData;
      
      private static const goldWhiteIconClass:Class = HudInventoryIcon_goldWhiteIconClass;
      
      private static const goldWhiteIconBitmapData:BitmapData = new goldWhiteIconClass().bitmapData;
      
      private static const goldColorIconClass:Class = HudInventoryIcon_goldColorIconClass;
      
      private static const goldColorIconBitmapData:BitmapData = new goldColorIconClass().bitmapData;
      
      private static const goldGrayIconClass:Class = HudInventoryIcon_goldGrayIconClass;
      
      private static const goldGrayIconBitmapData:BitmapData = new goldGrayIconClass().bitmapData;
      
      private static const droneIconClass:Class = HudInventoryIcon_droneIconClass;
      
      private static const droneIconBitmapData:BitmapData = new droneIconClass().bitmapData;
      
      public static const BGD:int = 10;
      
      public static const LOCK_OVERLAY:int = 11;
      
      public static const BORDER:int = 12;
      
      public static const COOLDOWN_OVERLAY:int = 14;
      
      public static const OVERDRIVE_BG:int = 15;
      
      public static const OVERDRIVE_LOCK_OVERLAY:int = 16;
      
      public static const OVERDRIVE_COOLDOWN_OVERLAY:int = 17;
      
      public function HudInventoryIcon()
      {
         super();
      }
      
      public static function getIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         switch(param1)
         {
            case HudInventoryIcon.BGD:
               _loc2_ = bgdBitmapData;
               break;
            case HudInventoryIcon.OVERDRIVE_BG:
               _loc2_ = overdriveBgBitmapData;
               break;
            case HudInventoryIcon.LOCK_OVERLAY:
               _loc2_ = lockBitmapData;
               break;
            case HudInventoryIcon.BORDER:
               _loc2_ = borderBitmapData;
               break;
            case HudInventoryIcon.COOLDOWN_OVERLAY:
               _loc2_ = darkBitmapData;
               break;
            case HudInventoryIcon.OVERDRIVE_COOLDOWN_OVERLAY:
               _loc2_ = dark2xBitmapData;
         }
         return _loc2_;
      }
      
      public static function getBgdIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         switch(param1)
         {
            case InventoryItemType.ULTIMATE:
               _loc2_ = ultimateBgdBitmapData;
               break;
            case InventoryItemType.FIRST_AID:
               _loc2_ = firstAidBgdBitmapData;
               break;
            case InventoryItemType.ARMOR:
               _loc2_ = armorBgdBitmapData;
               break;
            case InventoryItemType.DAMAGE:
               _loc2_ = damageBgdBitmapData;
               break;
            case InventoryItemType.NITRO:
               _loc2_ = nitroBgdBitmapData;
               break;
            case InventoryItemType.MINE:
               _loc2_ = mineBgdBitmapData;
               break;
            case InventoryItemType.GOLD:
               _loc2_ = goldBgdBitmapData;
               break;
            case InventoryItemType.BATTERY:
               _loc2_ = droneIconBitmapData;
         }
         return _loc2_;
      }
      
      public static function getNeutralInventoryIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         switch(param1)
         {
            case InventoryItemType.ULTIMATE:
               _loc2_ = ultimateWhiteIconBitmapData;
               break;
            case InventoryItemType.FIRST_AID:
               _loc2_ = firstAidWhiteIconBitmapData;
               break;
            case InventoryItemType.ARMOR:
               _loc2_ = armorWhiteIconBitmapData;
               break;
            case InventoryItemType.DAMAGE:
               _loc2_ = damageWhiteIconBitmapData;
               break;
            case InventoryItemType.NITRO:
               _loc2_ = nitroWhiteIconBitmapData;
               break;
            case InventoryItemType.MINE:
               _loc2_ = mineWhiteIconBitmapData;
               break;
            case InventoryItemType.GOLD:
               _loc2_ = goldWhiteIconBitmapData;
               break;
            case InventoryItemType.BATTERY:
               _loc2_ = droneIconBitmapData;
         }
         return _loc2_;
      }
      
      public static function getEffectInventoryIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         switch(param1)
         {
            case InventoryItemType.FIRST_AID:
               _loc2_ = firstAidColorIconBitmapData;
               break;
            case InventoryItemType.ARMOR:
               _loc2_ = armorColorIconBitmapData;
               break;
            case InventoryItemType.DAMAGE:
               _loc2_ = damageColorIconBitmapData;
               break;
            case InventoryItemType.NITRO:
               _loc2_ = nitroColorIconBitmapData;
               break;
            case InventoryItemType.MINE:
               _loc2_ = mineColorIconBitmapData;
               break;
            case InventoryItemType.GOLD:
               _loc2_ = goldColorIconBitmapData;
               break;
            case InventoryItemType.BATTERY:
               _loc2_ = droneIconBitmapData;
         }
         return _loc2_;
      }
      
      public static function getCooldownInventoryIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         switch(param1)
         {
            case InventoryItemType.FIRST_AID:
               _loc2_ = firstAidGrayIconBitmapData;
               break;
            case InventoryItemType.ARMOR:
               _loc2_ = armorGrayIconBitmapData;
               break;
            case InventoryItemType.DAMAGE:
               _loc2_ = damageGrayIconBitmapData;
               break;
            case InventoryItemType.NITRO:
               _loc2_ = nitroGrayIconBitmapData;
               break;
            case InventoryItemType.MINE:
               _loc2_ = mineGrayIconBitmapData;
               break;
            case InventoryItemType.GOLD:
               _loc2_ = goldGrayIconBitmapData;
               break;
            case InventoryItemType.BATTERY:
               _loc2_ = droneIconBitmapData;
         }
         return _loc2_;
      }
      
      public static function getIndicatorColor(param1:int) : uint
      {
         switch(param1)
         {
            case InventoryItemType.FIRST_AID:
               return 10210624;
            case InventoryItemType.ARMOR:
               return 15248503;
            case InventoryItemType.DAMAGE:
               return 15623237;
            case InventoryItemType.NITRO:
               return 15648305;
            case InventoryItemType.MINE:
               return 3193743;
            case InventoryItemType.GOLD:
               return 16760654;
            case InventoryItemType.BATTERY:
               return ColorConstants.WHITE;
            default:
               return 0;
         }
      }
   }
}

