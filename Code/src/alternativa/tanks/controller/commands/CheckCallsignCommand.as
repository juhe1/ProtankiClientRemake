package alternativa.tanks.controller.commands
{
   import alternativa.tanks.controller.events.CheckCallsignEvent;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class CheckCallsignCommand extends Command
   {
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      [Inject] // added
      public var checkUidEvent:CheckCallsignEvent;
      
      public function CheckCallsignCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.serverFacade.checkCallsign(this.checkUidEvent.uid);
      }
   }
}

