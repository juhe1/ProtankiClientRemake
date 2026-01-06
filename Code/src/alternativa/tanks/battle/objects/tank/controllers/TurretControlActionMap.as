package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   
   public class TurretControlActionMap
   {
      
      public static var DEFAULT_ACTION_MAP:TurretControlActionMap = new TurretControlActionMap(GameActionEnum.ROTATE_TURRET_LEFT,GameActionEnum.ROTATE_TURRET_RIGHT,GameActionEnum.CENTER_TURRET);
      
      public var actionLeft:GameActionEnum;
      
      public var actionRight:GameActionEnum;
      
      public var actionCenter:GameActionEnum;
      
      public var actionUp:GameActionEnum;
      
      public var actionDown:GameActionEnum;
      
      public function TurretControlActionMap(param1:GameActionEnum, param2:GameActionEnum, param3:GameActionEnum, param4:GameActionEnum = null, param5:GameActionEnum = null)
      {
         super();
         this.actionLeft = param1;
         this.actionRight = param2;
         this.actionCenter = param3;
         this.actionUp = param4;
         this.actionDown = param5;
      }
   }
}

