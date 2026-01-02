package alternativa.tanks.model.item.upgradable
{
   import alternativa.tanks.model.item.properties.ItemProperties;
   import alternativa.tanks.model.item.properties.ItemPropertyValue;
   import alternativa.tanks.service.item.ItemService;
   import controls.timer.CountDownTimer;
   import projects.tanks.client.garage.models.item.upgradeable.IUpgradeableParamsConstructorModelBase;
   import projects.tanks.client.garage.models.item.upgradeable.UpgradeParamsCC;
   import projects.tanks.client.garage.models.item.upgradeable.UpgradeableParamsConstructorModelBase;
   
   [ModelInfo]
   public class UpgradeParamsModel extends UpgradeableParamsConstructorModelBase implements IUpgradeableParamsConstructorModelBase, UpgradableItem, ItemProperties
   {
      
      [Inject]
      public static var itemService:ItemService;
      
      public function UpgradeParamsModel()
      {
         super();
      }
      
      public function getUpgradableItem() : UpgradableItemParams
      {
         return this.data();
      }
      
      public function getProperties() : Vector.<ItemPropertyValue>
      {
         return Vector.<ItemPropertyValue>(this.data().properties);
      }
      
      public function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue>
      {
         return Vector.<ItemPropertyValue>(this.data().visibleProperties);
      }
      
      public function getUpgradableProperties() : Vector.<UpgradableItemPropertyValue>
      {
         return this.data().properties;
      }
      
      public function getVisibleUpgradableProperties() : Vector.<UpgradableItemPropertyValue>
      {
         return this.data().visibleProperties;
      }
      
      public function isUpgrading() : Boolean
      {
         return this.data().isUpgrading();
      }
      
      public function speedUp() : void
      {
         return this.data().speedUp();
      }
      
      public function getCountDownTimer() : CountDownTimer
      {
         return this.data().timer;
      }
      
      public function traceUpgrades() : void
      {
         var _loc1_:String = null;
         if(this.data().getLevelsCount() > 0)
         {
            _loc1_ = itemService.getName(object);
            this.data().traceUpgrades();
         }
      }
      
      private function data() : UpgradableItemParams
      {
         var _loc2_:UpgradeParamsCC = null;
         var _loc1_:UpgradableItemParams = UpgradableItemParams(getData(UpgradableItemParams));
         if(_loc1_ == null)
         {
            _loc2_ = getInitParam();
            _loc1_ = new UpgradableItemParams(_loc2_,object);
            putData(UpgradableItemParams,_loc1_);
         }
         return _loc1_;
      }
      
      public function hasUpgradeDiscount() : Boolean
      {
         var _loc1_:UpgradeParamsCC = getInitParam();
         return _loc1_.timeDiscount > 0 || _loc1_.upgradeDiscount > 0;
      }
      
      public function hasSpeedUpDiscount() : Boolean
      {
         return getInitParam().speedUpDiscount > 0;
      }
   }
}

