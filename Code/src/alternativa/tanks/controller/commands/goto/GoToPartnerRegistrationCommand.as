package alternativa.tanks.controller.commands.goto
{
   import alternativa.tanks.controller.events.PartnersEvent;
   import alternativa.tanks.controller.events.showform.ShowPartnersFormEvent;
   import alternativa.tanks.model.RegistrationBackgroundModel;
   import org.robotlegs.mvcs.Command;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   
   public class GoToPartnerRegistrationCommand extends Command
   {
      
      [Inject] // added
      public static var partnerService:IPartnerService;
      
      [Inject] // added
      public var backgroundModel:RegistrationBackgroundModel;
      
      [Inject] // added
      public var event:PartnersEvent;
      
      public function GoToPartnerRegistrationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         dispatch(new ShowPartnersFormEvent(ShowPartnersFormEvent.REGISTRATION_FORM,this.backgroundModel.backgroundImage,partnerService.isExternalLoginAllowed()));
      }
   }
}

