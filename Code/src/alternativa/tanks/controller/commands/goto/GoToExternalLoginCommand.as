package alternativa.tanks.controller.commands.goto
{
   import alternativa.tanks.controller.events.showform.ShowExternalEntranceFormEvent;
   import alternativa.tanks.controller.events.socialnetwork.NavigationExternalEvent;
   import alternativa.tanks.model.EntranceServerParamsModel;
   import alternativa.tanks.model.EntranceUrlParamsModel;
   import alternativa.tanks.service.AccountService;
   import alternativa.tanks.service.ICaptchaService;
   import org.robotlegs.mvcs.Command;
   
   public class GoToExternalLoginCommand extends Command
   {
      
      [Inject] // added
      public var entranceUrlParamsModel:EntranceUrlParamsModel;
      
      [Inject] // added
      public var serverParamsModel:EntranceServerParamsModel;
      
      [Inject] // added
      public var accountService:AccountService;
      
      [Inject] // added
      public var event:NavigationExternalEvent;
      
      [Inject] // added
      public var captchaService:ICaptchaService;
      
      public function GoToExternalLoginCommand()
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
         dispatch(new ShowExternalEntranceFormEvent(ShowExternalEntranceFormEvent.LOGIN_FORM,this.event.socialNetworkId,this.entranceUrlParamsModel.passedCallsign || this.accountService.storedUserName,_loc1_));
      }
   }
}

