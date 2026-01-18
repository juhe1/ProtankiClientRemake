package scpacker.utils
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import projects.tanks.client.battleservice.BattleMode;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import projects.tanks.client.battleservice.model.map.params.MapTheme;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import projects.tanks.client.battleservice.EquipmentConstraintsMode;
   import projects.tanks.client.commons.types.ItemGarageProperty;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class EnumUtils
   {
      public function EnumUtils()
      {
         super();
      }
      
      public static function stringToItemGarageProperty(param1:String) : ItemGarageProperty
      {
         return ItemGarageProperty[param1] || ItemGarageProperty.RICOCHET_RESISTANCE;
      }
      
      public static function stringToItemProperty(param1:String) : ItemProperty
      {
         return ItemProperty[param1] || ItemProperty.RICOCHET_RESISTANCE;
      }
      
      public static function stringToItemViewCategoryEnum(param1:String) : ItemViewCategoryEnum
      {
         return ItemViewCategoryEnum[param1.toUpperCase()];
      }
      
      public static function intToItemCategoryEnum(param1:int) : ItemCategoryEnum
      {
         switch(param1 - 1)
         {
            case 0:
               return ItemCategoryEnum.WEAPON;
            case 1:
               return ItemCategoryEnum.ARMOR;
            case 2:
               return ItemCategoryEnum.COLOR;
            case 3:
               return ItemCategoryEnum.INVENTORY;
            case 4:
               return ItemCategoryEnum.PLUGIN;
            case 5:
               return ItemCategoryEnum.KIT;
            case 6:
               return ItemCategoryEnum.PRESENT;
            case 7:
               return ItemCategoryEnum.EMBLEM;
            case 8:
               return ItemCategoryEnum.GIVEN_PRESENT;
            default:
               return null;
         }
      }
      
      public static function objectToVector3d(param1:Object) : Vector3d
      {
         return new Vector3d(param1.x,param1.y,param1.z);
      }
      
      public static function stringToClientTankState(param1:String) : ClientTankState
      {
         switch(param1)
         {
            case "newcome":
               return ClientTankState.SEMI_ACTIVE;
            case "active":
               return ClientTankState.ACTIVE;
            case "suicide":
               return ClientTankState.DEAD;
            default:
               return ClientTankState.DEAD;
         }
      }

      public static function stringToTankLogicState(param1:String) : TankLogicState
      {
         switch(param1)
         {
            case "newcome":
               return TankLogicState.ACTIVATING;
            case "active":
               return TankLogicState.ACTIVE;
            case "suicide":
               return TankLogicState.DEAD;
            default:
               return TankLogicState.DEAD;
         }
      }
      
      public static function battleModeToBattleType(param1:BattleMode) : BattleType
      {
         switch(param1)
         {
            case BattleMode.CP:
               return BattleType.DOMINATION;
            case BattleMode.CTF:
               return BattleType.CTF;
            case BattleMode.DM:
               return BattleType.DM;
            case BattleMode.TDM:
               return BattleType.TDM;
            case BattleMode.AS:
               return BattleType.AS;
            default:
               return BattleType.DM;
         }
      }

      public static function stringToBattleSuspicionLevel(param1:String) : BattleSuspicionLevel
      {
         switch(param1)
         {
            case "NONE":
               return BattleSuspicionLevel.NONE;
            case "LOW":
               return BattleSuspicionLevel.LOW;
            case "HIGH":
               return BattleSuspicionLevel.HIGH;
            default:
               throw new Error(param1);
         }
      }
      
      public static function stringToBattleMode(param1:String) : BattleMode
      {
         switch(param1)
         {
            case "DM":
               return BattleMode.DM;
            case "TDM":
               return BattleMode.TDM;
            case "CTF":
               return BattleMode.CTF;
            case "CP":
               return BattleMode.CP;
            case "AS":
               return BattleMode.AS;
            default:
               throw new Error(param1);
         }
      }
      
      public static function stringToEquipmentConstraintsMode(param1:String) : EquipmentConstraintsMode
      {
         switch(param1)
         {
            case "NONE":
               return EquipmentConstraintsMode.NONE;
            case "WASP_RAILGUN":
               return EquipmentConstraintsMode.WASP_RAILGUN;
            case "HORNET_RAILGUN":
               return EquipmentConstraintsMode.HORNET_RAILGUN;
            case "HORNET_WASP_RAILGUN":
               return EquipmentConstraintsMode.HORNET_WASP_RAILGUN;
            default:
               throw new Error(param1);
         }
      }
      
      public static function stringToMapTheme(param1:String) : MapTheme
      {
         switch(param1)
         {
            case "SUMMER":
               return MapTheme.SUMMER;
            case "WINTER":
               return MapTheme.WINTER;
            case "SPACE":
               return MapTheme.SPACE;
            case "SUMMER_DAY":
               return MapTheme.SUMMER_DAY;
            case "SUMMER_NIGHT":
               return MapTheme.SUMMER_NIGHT;
            case "WINTER_DAY":
               return MapTheme.WINTER_DAY;
            case "WINTER_NIGHT":
               return MapTheme.WINTER_NIGHT;
            default:
               throw new Error(param1);
         }
      }
      
      public static function stringToBattleTeam(param1:String) : BattleTeam
      {
         switch(param1)
         {
            case "RED":
               return BattleTeam.RED;
            case "BLUE":
               return BattleTeam.BLUE;
            case "NONE":
               return BattleTeam.NONE;
            default:
               throw new Error(param1);
         }
      }
   }
}

