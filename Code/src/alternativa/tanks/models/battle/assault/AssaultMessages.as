package alternativa.tanks.models.battle.assault
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.ctf.FlagMessage;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class AssaultMessages
   {
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      private var spectatorMessage:FlagMessage;
      
      private var redTeamMessage:FlagMessage;
      
      private var blueTeamMessage:FlagMessage;
      
      public function AssaultMessages()
      {
         super();
         this.initMessages();
      }
      
      private function initMessages() : void
      {
         var _loc1_:String = localeService.getText(TanksLocale.TEXT_ASSAULT_DELIVER_FLAG);
         this.redTeamMessage = new FlagMessage(_loc1_,MessageColor.POSITIVE);
         this.blueTeamMessage = new FlagMessage(_loc1_,MessageColor.NEGATIVE);
         this.spectatorMessage = new FlagMessage(_loc1_,MessageColor.WHITE);
      }
      
      public function getMessage(param1:BattleTeam) : FlagMessage
      {
         switch(param1)
         {
            case BattleTeam.RED:
               return this.redTeamMessage;
            case BattleTeam.BLUE:
               return this.blueTeamMessage;
            default:
               return this.spectatorMessage;
         }
      }
   }
}

