package alternativa.tanks.controller.commands.goto
{
   import alternativa.tanks.controller.events.PartnersEvent;
   import alternativa.tanks.controller.events.showform.ShowPartnersFormEvent;
   import alternativa.tanks.model.EntranceServerParamsModel;
   import alternativa.tanks.model.RegistrationBackgroundModel;
   import alternativa.tanks.service.ICaptchaService;
   import org.robotlegs.mvcs.Command;
   
   public class GoToPartnerLoginCommand extends Command
   {
      
      [Inject] // added
      public var backgroundModel:RegistrationBackgroundModel;
      
      [Inject] // added
      public var serverParamsModel:EntranceServerParamsModel;
      
      [Inject] // added
      public var event:PartnersEvent;
      
      [Inject] // added
      public var captchaService:ICaptchaService;
      
      public function GoToPartnerLoginCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Boolean = this.serverParamsModel.loginCaptchaEnabled || Boolean(this.captchaService.loginCaptchaEnabled);
         dispatch(new ShowPartnersFormEvent(ShowPartnersFormEvent.LOGIN_FORM,this.backgroundModel.backgroundImage,false,_loc1_));
      }
   }
}

