package alternativa.tanks.controller.commands
{
   import alternativa.tanks.controller.events.SendNewPasswordAndEmailToChangeEvent;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class SendNewPasswordAndEmailToChangeCommand extends Command
   {
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      [Inject] // added
      public var event:SendNewPasswordAndEmailToChangeEvent;
      
      public function SendNewPasswordAndEmailToChangeCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.serverFacade.changePasswordAndEmail(this.event.password,this.event.email);
      }
   }
}

