package projects.tanks.clients.flash.commons.models.externalauth
{
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   import projects.tanks.client.commons.models.externalauth.ExternalAuthApiModelBase;
   import projects.tanks.client.commons.models.externalauth.ExternalAuthParameters;
   import projects.tanks.client.commons.models.externalauth.IExternalAuthApiModelBase;
   
   [ModelInfo]
   public class ExternalAuthApiModel extends ExternalAuthApiModelBase implements IExternalAuthApiModelBase, ExternalAuthApi
   {
      
      private static const CALLBACK_NAME:String = "authorizeLoginParams";
      
      private static const LOGIN_METHOD_NAME:String = "loginViaExternal";
      
      public function ExternalAuthApiModel()
      {
         super();
      }
      
      private function authorize(param1:String, param2:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc3_:Dictionary = new Dictionary();
         for(_loc4_ in param2)
         {
            _loc5_ = param2[_loc4_];
            _loc3_[_loc4_] = _loc5_;
         }
         server.authorize(param1,new ExternalAuthParameters(_loc3_));
         ExternalInterface.addCallback(CALLBACK_NAME,null);
      }
      
      public function initLogin(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback(CALLBACK_NAME,getFunctionWrapper(this.authorize));
            ExternalInterface.call(LOGIN_METHOD_NAME,param1);
         }
      }
   }
}

