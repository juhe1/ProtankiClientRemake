package alternativa.tanks.display.resistance
{
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import flash.display.Bitmap;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class ResistanceShieldIcon
   {
      
      private static var blueShield:Class = ResistanceShieldIcon_blueShield;
      
      private static var greenShield:Class = ResistanceShieldIcon_greenShield;
      
      private static var redShield:Class = ResistanceShieldIcon_redShield;
      
      public function ResistanceShieldIcon()
      {
         super();
      }
      
      public static function getBitmap(param1:BattleTeam) : Bitmap
      {
         switch(param1)
         {
            case BattleTeam.BLUE:
               return new blueShield();
            case BattleTeam.RED:
               return new redShield();
            default:
               return new greenShield();
         }
      }
      
      public static function getBitmapFor(param1:IGameObject, userId:String) : Bitmap
      {
         var _loc2_:IGameObject = param1.space.rootObject;
         var _loc3_:IClientUserInfo = IClientUserInfo(_loc2_.adapt(IClientUserInfo));
         var _loc4_:ShortUserInfo = _loc3_.getShortUserInfo(userId);
         return getBitmap(_loc4_.teamType);
      }
   }
}

