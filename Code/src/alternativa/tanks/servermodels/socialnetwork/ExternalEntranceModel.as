package alternativa.tanks.servermodels.socialnetwork
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.service.IEntranceClientFacade;
   import alternativa.tanks.service.IExternalEntranceService;
   import alternativa.tanks.view.forms.RegistrationForm;
   import alternativa.tanks.ymservice.YandexMetricaService;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceModelBase;
   import projects.tanks.client.entrance.model.entrance.externalentrance.IExternalEntranceModelBase;
   import projects.tanks.client.entrance.model.entrance.externalentrance.SocialNetworkEntranceParams;
   import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApi;
   import projects.tanks.clients.flash.commons.services.externalauth.ExternalAuthParamsService;
   import projects.tanks.clients.flash.commons.services.nameutils.SocialNetworkNameUtils;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   import services.alertservice.AlertAnswer;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.commons.models.externalauth.ExternalAuthApiModelBase;
   
   [ModelInfo]
   public class ExternalEntranceModel extends ExternalEntranceModelBase implements IExternalEntranceModelBase, ObjectLoadListener, IExternalEntranceModel
   {
      
      [Inject]
      public static var externalEntranceService:IExternalEntranceService;
      
      [Inject]
      public static var clientFacade:IEntranceClientFacade;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var alertService:IAlertService;
      
      [Inject]
      public static var ymService:YandexMetricaService;
      
      [Inject]
      public static var externalAuthParamsService:ExternalAuthParamsService;

      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      private static const VK_REGISTRATION_COMPLETED:String = "VKRegistration:completed";
      
      private static const FB_REGISTRATION_COMPLETED:String = "FBRegistration:completed";
      
      private var isSendStartRegisterFacade:Boolean;
      
      private var isSendStartLoginFacade:Boolean;
      
      private var _socialNetworkId:String;
      
      public function ExternalEntranceModel()
      {
         super();
      }
      
      public function login(param1:String, param2:String) : void
      {
         server.createLinkForExistingUser(param1,param2);
      }
      
      public function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void
      {
         this.isSendStartRegisterFacade = true;
         this.startExternalEnter(param1,param2,param3);
      }
      
      public function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void
      {
         this.isSendStartLoginFacade = true;
         this.startExternalEnter(param1,param2,param3);
      }
      
      private function startExternalEnter(param1:String, param2:Boolean, param3:String) : void
      {
         this._socialNetworkId = param1;
         server.setLoginData(param2,param3);
         var _loc4_:String = this.getAuthorizationUrl(param1);
         if(Boolean(_loc4_))
         {
            this.goToURL(_loc4_);
         }
         else
         {
            ExternalAuthApi(modelRegistry.getModel(ExternalAuthApiModelBase.modelId)).initLogin(param1);
         }
      }
      
      private function getAuthorizationUrl(param1:String) : String
      {
         var _loc2_:SocialNetworkEntranceParams = null;
         for each(_loc2_ in getInitParam().socialNetworkParams)
         {
            if(_loc2_.snId == param1)
            {
               return _loc2_.authorizationUrl;
            }
         }
         return null;
      }
      
      private function goToURL(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("newPopup",param1);
         }
         else
         {
            navigateToURL(new URLRequest(param1));
         }
      }
      
      public function finishExternalRegisterUser(param1:String, param2:String) : void
      {
         if(this._socialNetworkId == RegistrationForm.VK_ID)
         {
            ymService.reachGoalIfPlayerWasInTutorial(VK_REGISTRATION_COMPLETED);
         }
         if(this._socialNetworkId == RegistrationForm.FB_ID)
         {
            ymService.reachGoalIfPlayerWasInTutorial(FB_REGISTRATION_COMPLETED);
         }
         server.registerNewUser(param1,param2);
      }
      
      public function objectLoaded() : void
      {
         var _loc2_:SocialNetworkEntranceParams = null;
         var _loc1_:Vector.<SocialNetworkEntranceParams> = getInitParam().socialNetworkParams;
         for each(_loc2_ in _loc1_)
         {
            externalEntranceService.setEnabled(_loc2_.snId,_loc2_.enabled);
         }
      }
      
      public function validationSuccess() : void
      {
         if(this.isSendStartRegisterFacade)
         {
            this.isSendStartRegisterFacade = false;
            clientFacade.goToExternalRegistrationForm(this._socialNetworkId);
         }
         if(this.isSendStartLoginFacade)
         {
            this.isSendStartLoginFacade = false;
            clientFacade.goToExternalLoginForm(this._socialNetworkId);
         }
      }
      
      public function wrongPassword() : void
      {
         clientFacade.wrongPasswordExternalEntrance();
      }
      
      public function validationFailed() : void
      {
         alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ERROR_EXTERNAL_ENTER),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
         clientFacade.externalValidationFailed();
      }
      
      public function linkAlreadyExists() : void
      {
         alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_GAME_ACCOUNT_ALREADY_LINKED,SocialNetworkNameUtils.makeSocialNetworkNameFromId(this._socialNetworkId)),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
         clientFacade.externalLinkAlreadyExists();
      }
   }
}

