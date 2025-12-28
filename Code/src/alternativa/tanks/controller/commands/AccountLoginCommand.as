package alternativa.tanks.controller.commands
{
   import alternativa.tanks.controller.events.AccountLoginEvent;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class AccountLoginCommand extends Command
   {
      
      [Inject] // added
      public var entranceGateway:IEntranceServerFacade;
      
      [Inject] // added
      public var loginEvent:AccountLoginEvent;
      
      public function AccountLoginCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.entranceGateway.loginByHash(this.loginEvent.hash);
      }
   }
}

