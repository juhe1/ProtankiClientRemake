package alternativa.tanks.controller.commands.captcha
{
   import alternativa.tanks.controller.events.CheckCaptchaAnswerEvent;
   import alternativa.tanks.controller.events.RegisterEvent;
   import alternativa.tanks.model.EntranceServerParamsModel;
   import org.robotlegs.mvcs.Command;
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   
   public class CheckRegistrationCaptchaCommand extends Command
   {
      
      [Inject] // added
      public var event:RegisterEvent;
      
      [Inject] // added
      public var serverParams:EntranceServerParamsModel;
      
      public function CheckRegistrationCaptchaCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RegisterEvent = new RegisterEvent(RegisterEvent.REGISTER_AFTER_CAPTCHA_CHECKED,this.event.callsign,this.event.email,this.event.password,this.event.rememberMe,this.event.captchaAnswer);
         if(this.serverParams.registrationCaptchaEnabled)
         {
            dispatch(new CheckCaptchaAnswerEvent(this.event.captchaAnswer,CaptchaLocation.REGISTER_FORM,_loc1_));
         }
         else
         {
            dispatch(_loc1_);
         }
      }
   }
}

