package alternativa.tanks.servermodels.registartion.password
{
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.newbieservice.NewbieUserService;
   import alternativa.tanks.service.IEntranceClientFacade;
   import alternativa.tanks.service.IPasswordParamsService;
   import alternativa.tanks.tracker.ITrackerService;
   import alternativa.tanks.ymservice.YandexMetricaService;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.entrance.model.entrance.registration.IRegistrationModelBase;
   import projects.tanks.client.entrance.model.entrance.registration.RegistrationModelBase;
   import projects.tanks.clients.flash.commons.models.layout.LobbyLayoutModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import services.alertservice.AlertAnswer;
   import utils.preview.IImageResource;
   import utils.preview.ImageResourceLoadingWrapper;
   
   [ModelInfo]
   public class PasswordRegistrationModel extends RegistrationModelBase implements IRegistrationModelBase, IPasswordRegistration, ObjectLoadListener, IImageResource
   {
      
      [Inject] // added
      public static var facade:IEntranceClientFacade;
      
      [Inject] // added
      public static var passwordParamsService:IPasswordParamsService;
      
      [Inject] // added
      public static var alertService:IAlertService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var trackerService:ITrackerService;
      
      [Inject] // added
      public static var launcherParams:ILauncherParams;
      
      [Inject] // added
      public static var ymService:YandexMetricaService;
      
      [Inject] // added
      public static var newbieUserService:NewbieUserService;
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      private static const USER_IS_REGISTERED:String = "registered";
      
      public function PasswordRegistrationModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         this.checkFormerUser();
         passwordParamsService.minPasswordLength = getInitParam().minPasswordLength;
         passwordParamsService.maxPasswordLength = getInitParam().maxPasswordLength;
         facade.registrationThroughEmail = getInitParam().enableRequiredEmail;
         var _loc1_:ImageResource = getInitParam().bgResource;
         if(_loc1_.isLazy && !_loc1_.isLoaded)
         {
            _loc1_.loadLazyResource(new ImageResourceLoadingWrapper(this));
         }
         else
         {
            this.setPreviewResource(_loc1_);
         }
      }
      
      private function checkFormerUser() : void
      {
         //var _loc1_:Object = storageService.getStorage().data.uniqueUserIdHighDWord;
         //var _loc2_:Object = storageService.getStorage().data.uniqueUserIdLowDWord;
         //if(Boolean(_loc1_) && Boolean(_loc2_))
         //{
         //   server.setFormerUserId(Long.getLong(int(_loc1_),int(_loc2_)));
         //}
      }
      
      public function enteredUidIsFree() : void
      {
         facade.callsignIsFree();
      }
      
      public function anchorRegistration() : void
      {
         if(launcherParams.getParameter("partner") != null)
         {
            trackerService.trackPageView("registered/" + launcherParams.getParameter("partner"));
         }
         else
         {
            trackerService.trackPageView("registered");
         }
         ymService.reachGoalIfPlayerWasInTutorial(USER_IS_REGISTERED);
         newbieUserService.isNewbieUser = true;
         storageService.getStorage().data[LobbyLayoutModel.USE_BATTLE_LIST_KEY] = false;
      }
      
      public function enteredUidIsBusy(param1:Vector.<String>) : void
      {
         facade.callsignIsBusy(param1);
      }
      
      public function enteredUidIsIncorrect() : void
      {
         facade.callsignIsIncorrect();
      }
      
      public function passwordIsIncorrect() : void
      {
         facade.registrationPasswordIsIncorrect();
      }
      
      public function registrationFailed() : void
      {
         alertService.showAlert("Registration failed. Try again.",Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      }
      
      public function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void
      {
         this.resetUniqueUser();
         server.register(param1,param2,param3,param4,param5,param6,param7);
      }
      
      private function resetUniqueUser() : void
      {
         var _loc1_:Object = storageService.getStorage().data;
         _loc1_.uniqueUserIdLowDWord = null;
         _loc1_.uniqueUserIdHighDWord = null;
      }
      
      public function checkCallsign(param1:String) : void
      {
         server.checkUid(param1);
      }
      
      public function setPreviewResource(param1:ImageResource) : void
      {
         if(facade != null)
         {
            facade.registrationFormBackgroundRGB = param1.data;
         }
      }
   }
}

