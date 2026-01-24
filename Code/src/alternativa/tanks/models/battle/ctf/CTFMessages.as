package alternativa.tanks.models.battle.ctf
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import utils.TankNameGameObjectMapper;
   
   public class CTFMessages
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var userInfoService:BattleUserInfoService;
      
      public static const MESSAGE_TAKEN:String = "taken";
      
      public static const MESSAGE_LOST:String = "lost";
      
      public static const MESSAGE_RETURNED:String = "returned";
      
      public static const MESSAGE_CAPTURED:String = "captured";
      
      private var defaultMessages:Dictionary = new Dictionary();
      
      private var spectatorRedMessages:Dictionary = new Dictionary();
      
      private var spectatorBlueMessages:Dictionary = new Dictionary();
      
      public var ourFlagReturnedMessage:String;
      
      public var enemyFlagReturnedMessage:String;
      
      public var blueFlagReturnedMessage:FlagMessage;
      
      public var redFlagReturnedMessage:FlagMessage;
      
      private var guiModel:BattlefieldGUI;
      
      public function CTFMessages()
      {
         super();
         this.initMessages();
      }
      
      public function init(param1:BattlefieldGUI) : void
      {
         this.guiModel = param1;
      }
      
      public function getFlagMessage(param1:String, param2:Boolean) : FlagMessage
      {
         var _loc3_:FlagActionMessages = this.defaultMessages[param1];
         return param2 ? _loc3_.positive : _loc3_.negative;
      }
      
      public function getFlagMessageForSpectator(param1:String, param2:BattleTeam) : FlagMessage
      {
         var _loc3_:Object = param2 == BattleTeam.BLUE ? this.spectatorBlueMessages : this.spectatorRedMessages;
         return _loc3_[param1];
      }
      
      public function showBattleMessage(param1:FlagMessage, param2:IGameObject) : void
      {
         var _loc3_:String = param2 != null ? userInfoService.getUserName(TankNameGameObjectMapper.getTankNameByGameObject(param2)) : null;
         if(Boolean(_loc3_))
         {
            this.guiModel.showBattleMessage(param1.color,_loc3_ + " " + param1.text);
         }
      }
      
      private function initMessages() : void
      {
         this.createDefaultFlagMessages();
         this.createSpectatorMessages(this.spectatorBlueMessages,MessageColor.BLUE);
         this.createSpectatorMessages(this.spectatorRedMessages,MessageColor.RED);
         this.ourFlagReturnedMessage = localeService.getText(TanksLocale.TEXT_CTF_OUR_FLAG_RETURNED);
         this.enemyFlagReturnedMessage = localeService.getText(TanksLocale.TEXT_CTF_ENEMY_FLAG_RETURNED);
         this.blueFlagReturnedMessage = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_BLUE_FLAG_RETURNED),MessageColor.BLUE);
         this.redFlagReturnedMessage = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_RED_FLAG_RETURNED),MessageColor.RED);
      }
      
      private function createDefaultFlagMessages() : void
      {
         this.createFlagActionMessages(MESSAGE_TAKEN,TanksLocale.TEXT_CTF_GOT_ENEMY_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_GOT_OUR_FLAG,MessageColor.NEGATIVE);
         this.createFlagActionMessages(MESSAGE_LOST,TanksLocale.TEXT_CTF_LOST_OUR_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_LOST_ENEMY_FLAG,MessageColor.NEGATIVE);
         this.createFlagActionMessages(MESSAGE_RETURNED,TanksLocale.TEXT_CTF_RETURNED_OUR_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_RETURNED_ENEMY_FLAG,MessageColor.NEGATIVE);
         this.createFlagActionMessages(MESSAGE_CAPTURED,TanksLocale.TEXT_CTF_CAPTURED_ENEMY_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_CAPTURED_OUR_FLAG,MessageColor.NEGATIVE);
      }
      
      private function createSpectatorMessages(param1:Object, param2:uint) : void
      {
         param1[MESSAGE_TAKEN] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_GOT_FLAG_NEUTRAL),param2);
         param1[MESSAGE_LOST] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_LOST_FLAG_NEUTRAL),param2);
         param1[MESSAGE_RETURNED] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_RETURNED_FLAG_NEUTRAL),param2);
         param1[MESSAGE_CAPTURED] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_CAPTURED_FLAG_NEUTRAL),param2);
      }
      
      private function createFlagActionMessages(param1:String, param2:String, param3:uint, param4:String, param5:uint) : void
      {
         var _loc6_:FlagMessage = new FlagMessage(localeService.getText(param2),param3);
         var _loc7_:FlagMessage = new FlagMessage(localeService.getText(param4),param5);
         this.defaultMessages[param1] = new FlagActionMessages(_loc6_,_loc7_);
      }
   }
}

