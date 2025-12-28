package alternativa.tanks.service.impl
{
   //import alternativa.tanks.servermodels.changeuid.IChangeUid;
   import alternativa.tanks.servermodels.emailandpasswordchanger.IPasswordRecovery;
   import alternativa.tanks.servermodels.emailconfirm.IEmailConfirm;
   //import alternativa.tanks.servermodels.invite.IInvite;
   import alternativa.tanks.servermodels.login.ILogin;
   import alternativa.tanks.servermodels.loginbyhash.ILoginByHash;
   import alternativa.tanks.servermodels.loginwithoutregistration.ILoginWithoutRegistration;
   import alternativa.tanks.servermodels.partners.ICompositePartnerModel;
   import alternativa.tanks.servermodels.registartion.email.IEmailRegistration;
   import alternativa.tanks.servermodels.registartion.password.IPasswordRegistration;
   import alternativa.tanks.servermodels.socialnetwork.IExternalEntranceModel;
   import alternativa.tanks.service.IEntranceServerFacade;
   import org.robotlegs.mvcs.Actor;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   import projects.tanks.clients.flash.commons.models.captcha.IServerCaptcha;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.entrance.model.entrance.registration.RegistrationModelBase;
   import projects.tanks.client.entrance.model.entrance.email.EmailRegistrationModelBase;
   import projects.tanks.client.entrance.model.entrance.passwordchange.PasswordChangeModelBase;
   import projects.tanks.client.entrance.model.entrance.login.LoginModelBase;
   import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceModelBase;
   import alternativa.tanks.servermodels.loginwithoutregistration.LoginWithoutRegistrationModel;
   import projects.tanks.client.entrance.model.entrance.loginwithoutregistration.LoginWithoutRegistrationModelBase;
   import projects.tanks.client.entrance.model.entrance.loginbyhash.LoginByHashModelBase;
   import projects.tanks.client.entrance.model.entrance.emailconfirm.EmailConfirmModelBase;
   import projects.tanks.client.commons.models.captcha.CaptchaModelBase;
   import projects.tanks.client.entrance.model.entrance.partners.CompositePartnerModelBase;
   
   public class EntranceServerFacade extends Actor implements IEntranceServerFacade
   {
      
      private var _gameObject:IGameObject;

      [Inject] // added
      public static var modelRegistry:ModelRegistry;

      public function EntranceServerFacade()
      {
         super();
      }
      
      public function checkCallsign(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IPasswordRegistration(modelRegistry.getModel(RegistrationModelBase.modelId)).checkCallsign(param1);
      }
      
      public function checkEmail(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IEmailRegistration(modelRegistry.getModel(EmailRegistrationModelBase.modelId)).checkEmail(param1);
      }
      
      //public function checkInviteCode(param1:String) : void
      //{
      //   this.checkIfGameObjectIsLoaded();
      //   IInvite(this._gameObject.adapt(IInvite)).checkInvite(param1);
      //}
      
      public function sendEmailRestoreMessage(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IPasswordRecovery(modelRegistry.getModel(PasswordChangeModelBase.modelId)).sendUsersRestorePasswordLink(param1);
      }
      
      public function login(param1:String, param2:String, param3:Boolean) : void
      {
         this.checkIfGameObjectIsLoaded();
         ILogin(modelRegistry.getModel(LoginModelBase.modelId)).login(param1,param2,param3);
      }
      
      public function loginExternal(param1:String, param2:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IExternalEntranceModel(modelRegistry.getModel(ExternalEntranceModelBase.modelId)).login(param1,param2);
      }
      
      public function fightWithoutRegistration() : void
      {
         this.checkIfGameObjectIsLoaded();
         ILoginWithoutRegistration(modelRegistry.getModel(LoginWithoutRegistrationModelBase.modelId)).passToFirstBattle();
      }
      
      public function checkEmailChangeHash(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IPasswordRecovery(modelRegistry.getModel(PasswordChangeModelBase.modelId)).startEmailAndPasswordChangeProcess(param1);
      }
      
      public function loginByHash(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         ILoginByHash(modelRegistry.getModel(LoginByHashModelBase.modelId)).loginByHash(param1);
      }
      
      public function loginBySingleUseHash(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         ILoginByHash(modelRegistry.getModel(LoginByHashModelBase.modelId)).loginBySingleUseHash(param1);
      }
      
      public function confirmEmail(param1:String, param2:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IEmailConfirm(modelRegistry.getModel(EmailConfirmModelBase.modelId)).startEmailConfirm(param1,param2);
      }
      
      public function set entranceObject(param1:IGameObject) : void
      {
         this._gameObject = param1;
      }
      
      public function registerUserThroughPassword(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         (modelRegistry.getModel(RegistrationModelBase.modelId) as IPasswordRegistration).register(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function registerThroughEmail(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         (modelRegistry.getModel(EmailRegistrationModelBase.modelId) as IEmailRegistration).register(param1,param2,param3,param4,param5,param6);
      }
      
      public function getNewCaptcha(param1:CaptchaLocation) : void
      {
         this.checkIfGameObjectIsLoaded();
         (modelRegistry.getModel(CaptchaModelBase.modelId) as IServerCaptcha).getNewCaptcha(param1);
      }
      
      public function checkCaptcha(param1:String, param2:CaptchaLocation) : void
      {
         this.checkIfGameObjectIsLoaded();
         (modelRegistry.getModel(CaptchaModelBase.modelId) as IServerCaptcha).checkCaptcha(param1,param2);
      }
      
      public function changePasswordAndEmail(param1:String, param2:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IPasswordRecovery(modelRegistry.getModel(PasswordChangeModelBase.modelId)).changePasswordAndEmail(param1,param2);
      }
      
      public function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IExternalEntranceModel(modelRegistry.getModel(ExternalEntranceModelBase.modelId)).startExternalRegisterUser(param1,param2,param3);
      }
      
      public function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IExternalEntranceModel(modelRegistry.getModel(ExternalEntranceModelBase.modelId)).startExternalLoginUser(param1,param2,param3);
      }
      
      public function finishExternalRegisterUser(param1:String, param2:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         IExternalEntranceModel(modelRegistry.getModel(ExternalEntranceModelBase.modelId)).finishExternalRegisterUser(param1,param2);
      }
      
      public function loadPartnerObject(param1:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         ICompositePartnerModel(modelRegistry.getModel(CompositePartnerModelBase.modelId)).loadPartnerObject(param1);
      }
      
      public function finishPartnerRegistration(param1:String, param2:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         ICompositePartnerModel(modelRegistry.getModel(CompositePartnerModelBase.modelId)).finishRegistration(param1,param2);
      }
      
      public function bindAccountToPartner(param1:String, param2:String) : void
      {
         this.checkIfGameObjectIsLoaded();
         ICompositePartnerModel(modelRegistry.getModel(CompositePartnerModelBase.modelId)).bindAccount(param1,param2);
      }
      
      private function checkIfGameObjectIsLoaded() : void
      {
         //if(this._gameObject == null)
         //{
         //   throw new Error("Entrance gameObject is not loaded");
         //}
      }
   }
}

