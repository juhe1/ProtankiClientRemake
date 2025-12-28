package alternativa.tanks.controller.commands
{
   import alternativa.tanks.controller.events.CheckEmailEvent;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class CheckEmailCommand extends Command
   {
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      [Inject] // added
      public var checkEmailEvent:CheckEmailEvent;
      
      public function CheckEmailCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.serverFacade.checkEmail(this.checkEmailEvent.email);
      }
   }
}

