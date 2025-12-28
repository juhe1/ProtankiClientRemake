package alternativa.tanks.controller.commands.goto
{
   import alternativa.tanks.controller.events.showform.ShowLoginFormEvent;
   import alternativa.tanks.model.EntranceServerParamsModel;
   import alternativa.tanks.model.EntranceUrlParamsModel;
   import alternativa.tanks.service.AccountService;
   import alternativa.tanks.service.ICaptchaService;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   
   public class GoToLoginCommand extends Command
   {
      
      [Inject] // added
      public var entranceUrlParamsModel:EntranceUrlParamsModel;
      
      [Inject] // added
      public var accountService:AccountService;
      
      [Inject] // added
      public var serverParamsModel:EntranceServerParamsModel;
      
      [Inject] // added
      public var captchaService:ICaptchaService;
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      public function GoToLoginCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Boolean = false;
         if(this.serverParamsModel.loginCaptchaEnabled)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = Boolean(this.captchaService.loginCaptchaEnabled);
         }
         dispatch(new ShowLoginFormEvent(this.entranceUrlParamsModel.passedCallsign || this.accountService.storedUserName,true,_loc1_,this.entranceUrlParamsModel.passedPassword));
      }
   }
}

