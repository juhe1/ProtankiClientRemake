package alternativa.tanks.controller.commands.partners
{
   import alternativa.tanks.controller.events.LoginViaPartnerEvent;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class LoginViaPartnerCommand extends Command
   {
      
      [Inject] // added
      public var event:LoginViaPartnerEvent;
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      public function LoginViaPartnerCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.serverFacade.loadPartnerObject(this.event.partnerId);
      }
   }
}

