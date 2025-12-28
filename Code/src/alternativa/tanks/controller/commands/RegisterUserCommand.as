package alternativa.tanks.controller.commands
{
   import alternativa.tanks.controller.events.RegisterEvent;
   import alternativa.tanks.model.EntranceServerParamsModel;
   import alternativa.tanks.model.EntranceUrlParamsModel;
   import alternativa.tanks.service.AccountService;
   import alternativa.tanks.service.IEntranceServerFacade;
   import alternativa.tanks.tracker.ITrackerService;
   import org.robotlegs.mvcs.Command;
   
   public class RegisterUserCommand extends Command
   {
      
      [Inject] // added
      public var event:RegisterEvent;
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      [Inject] // added
      public var urlParams:EntranceUrlParamsModel;
      
      [Inject] // added
      public var accountService:AccountService;
      
      [Inject] // added
      public var serverParams:EntranceServerParamsModel;
      
      [Inject] // added
      public var trackerService:ITrackerService;
      
      public function RegisterUserCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.accountService.storedUserName = this.event.callsign;
         this.trackerService.trackEventAfter("entrance","registerUser","showRegistrationForm");
         if(this.serverParams.registrationThroughEmail)
         {
            this.serverFacade.registerThroughEmail(this.event.callsign,this.event.email,this.urlParams.domain,this.urlParams.referralHash,this.event.realName,this.event.idNumber);
         }
         else
         {
            this.serverFacade.registerUserThroughPassword(this.event.callsign,this.event.password,this.urlParams.domain,this.event.rememberMe,this.urlParams.referralHash,this.event.realName,this.event.idNumber);
         }
      }
   }
}

