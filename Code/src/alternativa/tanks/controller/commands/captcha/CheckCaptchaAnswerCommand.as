package alternativa.tanks.controller.commands.captcha
{
   import alternativa.tanks.controller.events.CheckCaptchaAnswerEvent;
   import alternativa.tanks.service.ICaptchaService;
   import org.robotlegs.mvcs.Command;
   
   public class CheckCaptchaAnswerCommand extends Command
   {
      
      [Inject] // added
      public var captchaService:ICaptchaService;
      
      [Inject] // added
      public var event:CheckCaptchaAnswerEvent;
      
      public function CheckCaptchaAnswerCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         commandMap.detain(this);
         this.captchaService.checkAnswer(this.event.location,this.event.captchaAnswer,this.onCaptchaAnswerCorrect);
      }
      
      private function onCaptchaAnswerCorrect() : void
      {
         commandMap.release(this);
         dispatch(this.event.onSuccessEvent);
      }
   }
}

