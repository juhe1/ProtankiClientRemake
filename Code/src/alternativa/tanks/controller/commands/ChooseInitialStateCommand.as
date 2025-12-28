package alternativa.tanks.controller.commands
{
   import alternativa.tanks.controller.events.EntranceErrorEvent;
   import alternativa.tanks.controller.events.LoginViaPartnerEvent;
   import alternativa.tanks.controller.events.NavigationEvent;
   import alternativa.tanks.model.EntranceServerParamsModel;
   import alternativa.tanks.model.EntranceUrlParamsModel;
   import alternativa.tanks.service.AccountService;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Command;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   
   public class ChooseInitialStateCommand extends Command
   {
      
      [Inject] // added
      public var serverFacade:IEntranceServerFacade;
      
      [Inject] // added
      public var urlParams:EntranceUrlParamsModel;
      
      [Inject] // added
      public var accountService:AccountService;
      
      [Inject] // added
      public var serverParams:EntranceServerParamsModel;
      
      [Inject] // added
      public var partnerService:IPartnerService;
      
      public function ChooseInitialStateCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:String = null;
         if(this.serverParams.serverFrozen)
         {
            dispatch(new EntranceErrorEvent(EntranceErrorEvent.SERVER_FROZEN));
         }
         else if(this.serverParams.serverHalt)
         {
            dispatch(new EntranceErrorEvent(EntranceErrorEvent.SERVER_HALT));
         }
         else if(Boolean(this.urlParams.singleUseHash))
         {
            this.serverFacade.loginBySingleUseHash(this.urlParams.singleUseHash);
         }
         else if(Boolean(this.urlParams.emailChangeHash))
         {
            this.serverFacade.checkEmailChangeHash(this.urlParams.emailChangeHash);
         }
         else if(this.partnerService.isRunningInsidePartnerEnvironment())
         {
            dispatch(new LoginViaPartnerEvent(this.partnerService.getEnvironmentPartnerId()));
         }
         else if(this.serverParams.inviteEnabled)
         {
            dispatch(new NavigationEvent(NavigationEvent.GO_TO_INVITE_FORM));
         }
         else if(Boolean(this.urlParams.emailConfirmHash) && Boolean(this.urlParams.email))
         {
            this.serverFacade.confirmEmail(this.urlParams.emailConfirmHash,this.urlParams.email);
         }
         //else if(Boolean(this.urlParams.changeUidHash) && Boolean(this.urlParams.email))
         //{
         //   this.serverFacade.checkChangeUidHash(this.urlParams.changeUidHash,this.urlParams.email);
         //}
         else if(Boolean(this.urlParams.referralHash))
         {
            dispatch(new NavigationEvent(NavigationEvent.GO_TO_REGISTRATION_FORM));
         }
         else if(Boolean(this.urlParams.tutorialHash))
         {
            dispatch(new NavigationEvent(NavigationEvent.GO_TO_REGISTRATION_FORM));
         }
         else if(Boolean(this.urlParams.entranceHash) || Boolean(this.accountService.entranceHash))
         {
            _loc1_ = this.urlParams.entranceHash || this.accountService.entranceHash;
            this.serverFacade.loginByHash(_loc1_);
         }
         else if(this.accountService.haveVisitedTankiAlready)
         {
            dispatch(new NavigationEvent(NavigationEvent.GO_TO_LOGIN_FORM));
         }
         else
         {
            this.accountService.haveVisitedTankiAlready = true;
            dispatch(new NavigationEvent(NavigationEvent.GO_TO_REGISTRATION_FORM));
         }
      }
   }
}

