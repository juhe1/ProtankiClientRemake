package alternativa.tanks.controller.commands.socialnetwork
{
   import alternativa.tanks.controller.events.socialnetwork.FinishExternalRegisterEvent;
   import alternativa.tanks.model.EntranceUrlParamsModel;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class FinishExternalRegisterUserCommand extends Command
   {
      
      [Inject] // added
      public var event:FinishExternalRegisterEvent;
      
      [Inject] // added
      public var urlParams:EntranceUrlParamsModel;
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      public function FinishExternalRegisterUserCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.serverFacade.finishExternalRegisterUser(this.event.uid,this.urlParams.referralHash);
      }
   }
}

