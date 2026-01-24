package alternativa.tanks.models.tank.premium
{
   import alternativa.tanks.display.usertitle.UserTitle;
   import alternativa.tanks.models.tank.ITankModel;
   import flash.events.Event;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.user.premium.DisplayPremiumStatusModelBase;
   import projects.tanks.client.battlefield.models.user.premium.IDisplayPremiumStatusModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   
   [ModelInfo]
   public class DisplayPremiumStatusModel extends DisplayPremiumStatusModelBase implements IDisplayPremiumStatusModelBase, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var userInfoService:IUserInfoService;
      
      [Inject] // added
      public static var premiumService:PremiumService;
      
      public function DisplayPremiumStatusModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         premiumService.addEventListener(Event.CHANGE,getFunctionWrapper(this.onChangePremiumStatus));
         this.updatePremiumStatusAtUserTitle();
      }
      
      private function updatePremiumStatusAtUserTitle() : void
      {
         var tankModel:ITankModel = ITankModel(object.adapt(ITankModel));
         var _loc2_:UserTitle = tankModel.getTitle();
         _loc2_.setPremium(userInfoService.hasPremium(tankModel.getUserInfo().name));
      }
      
      private function onChangePremiumStatus(param1:Event = null) : void
      {
         this.updatePremiumStatusAtUserTitle();
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         premiumService.removeEventListener(Event.CHANGE,getFunctionWrapper(this.onChangePremiumStatus));
      }
   }
}

