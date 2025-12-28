package alternativa.tanks.controller.commands
{
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.tanks.controller.events.NavigationEvent;
   import alternativa.tanks.model.EntranceUrlParamsModel;
   import flash.utils.Dictionary;
   import org.robotlegs.mvcs.Command;
   import platform.client.fp10.core.service.address.AddressService;
   
   public class ParseUrlParamsCommand extends Command
   {
      
      [Inject] // added
      public var paramsModel:EntranceUrlParamsModel;
      
      [Inject] // added
      public var launcherParams:ILauncherParams;
      
      [Inject] // added
      public var addressService:AddressService;
      
      public function ParseUrlParamsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.paramsModel.entranceHash = this.parseEntranceHash();
         this.paramsModel.singleUseHash = this.parseSingleUseHash();
         this.paramsModel.domain = this.addressService != null ? this.addressService.getBaseURL() : "";
         this.paramsModel.passedCallsign = this.launcherParams.getParameter("user");
         this.paramsModel.passedPassword = this.launcherParams.getParameter("password");
         this.paramsModel.emailConfirmHash = this.parseEmailConfirmHash();
         this.paramsModel.emailChangeHash = this.parseEmailChangeHash();
         this.paramsModel.email = this.parseEmail();
         this.paramsModel.referralHash = this.parseReferralHash();
         this.paramsModel.tutorialHash = this.parseTutorialHash();
         this.paramsModel.changeUidHash = this.parseChangeUidHash();
         dispatch(new NavigationEvent(NavigationEvent.GO_TO_STAND_ALONE_CAPTCHA));
      }
      
      private function parseChangeUidHash() : String
      {
         var _loc1_:String = this.getAddressParams()["changeUidHash"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("changeUidHash");
         }
         return _loc1_;
      }
      
      private function parseTutorialHash() : String
      {
         var _loc1_:String = this.getAddressParams()["tutorial"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("tutorial");
         }
         return _loc1_;
      }
      
      private function parseReferralHash() : String
      {
         var _loc1_:String = this.getAddressParams()["friend"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("friend");
         }
         return _loc1_;
      }
      
      private function parseEmail() : String
      {
         var _loc1_:String = this.getAddressParams()["userEmail"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("userEmail");
         }
         return _loc1_;
      }
      
      private function parseEntranceHash() : String
      {
         var _loc1_:String = this.getAddressParams()["hash"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("hash");
         }
         return _loc1_;
      }
      
      private function parseSingleUseHash() : String
      {
         var _loc1_:String = this.getAddressParams()["singleUseHash"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("singleUseHash");
         }
         return _loc1_;
      }
      
      private function parseEmailConfirmHash() : String
      {
         var _loc1_:String = this.getAddressParams()["emailConfirmHash"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("emailConfirmHash");
         }
         return _loc1_;
      }
      
      private function parseEmailChangeHash() : String
      {
         var _loc1_:String = this.getAddressParams()["emailChangeHash"];
         if(_loc1_ == null)
         {
            _loc1_ = this.launcherParams.getParameter("emailChangeHash");
         }
         return _loc1_;
      }
      
      private function getAddressParams() : Dictionary
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc1_:Dictionary = new Dictionary();
         if(this.addressService != null)
         {
            _loc2_ = this.addressService.getValue();
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.split("&");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = (_loc3_[_loc4_] as String).split("=");
                  _loc1_[_loc5_[0]] = _loc5_[1];
                  _loc4_++;
               }
            }
         }
         return _loc1_;
      }
   }
}

