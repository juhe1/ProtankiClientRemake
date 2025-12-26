package alternativa.tanks.servermodels.loginbyhash
{
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.tanks.service.IEntranceClientFacade;
   import flash.net.SharedObject;
   import mx.utils.StringUtil;
   import projects.tanks.client.entrance.model.entrance.loginbyhash.ILoginByHashModelBase;
   import projects.tanks.client.entrance.model.entrance.loginbyhash.LoginByHashModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   [ModelInfo]
   public class LoginByHashModel extends LoginByHashModelBase implements ILoginByHash, ILoginByHashModelBase
   {
      
      [Inject]
      public static var clientFacade:IEntranceClientFacade;
      
      [Inject]
      public static var storageService:IStorageService;
      
      [Inject]
      public static var launcherParams:ILauncherParams;
      
      public function LoginByHashModel()
      {
         super();
      }
      
      public function loginBySingleUseHash(param1:String) : void
      {
         launcherParams.removeParameter("singleUseHash");
         server.loginBySingleUseHash(param1);
      }
      
      public function loginByHash(param1:String) : void
      {
         server.loginByHash(param1);
      }
      
      public function loginBySingleUseHashFailed() : void
      {
         this.goToLoginHashFailed();
      }
      
      public function loginByHashFailed() : void
      {
         this.goToLoginHashFailed();
      }
      
      private function goToLoginHashFailed() : void
      {
         var _loc1_:SharedObject = storageService.getStorage();
         var _loc2_:SharedObject = storageService.getAccountsStorage();
         if(Boolean(_loc2_.data[_loc1_.data.userName]))
         {
            delete _loc2_.data[_loc1_.data.userName];
            _loc2_.flush();
         }
         _loc1_.data.userHash = null;
         clientFacade.goToLoginFormWithHashError();
      }
      
      public function rememberUsersHash(param1:String) : void
      {
         var _loc2_:SharedObject = storageService.getStorage();
         _loc2_.data.userHash = param1;
         _loc2_.flush();
      }
      
      public function rememberAccount(param1:String) : void
      {
         var _loc5_:String = null;
         this.rememberUsersHash(param1);
         var _loc2_:SharedObject = storageService.getStorage();
         if(StringUtil.trim(_loc2_.data.userName).length == 0)
         {
            return;
         }
         var _loc3_:SharedObject = storageService.getAccountsStorage();
         var _loc4_:Object = {};
         for(_loc5_ in _loc2_.data)
         {
            _loc4_[_loc5_] = _loc2_.data[_loc5_];
         }
         _loc3_.data[_loc2_.data.userName] = _loc4_;
         _loc3_.flush();
      }
   }
}

