package alternativa.tanks.service.delaymountcategory
{
   import alternativa.osgi.service.logging.LogService;
   import alternativa.tanks.service.item.ItemService;
   import controls.timer.CountDownTimer;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;
   
   public class DelayMountCategoryServiceImpl implements IDelayMountCategoryService
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var logService:LogService;
      
      private var timers:Dictionary = new Dictionary();
      
      public function DelayMountCategoryServiceImpl()
      {
         super();
      }
      
      public function getDownTimer(param1:IGameObject) : CountDownTimer
      {
         var _loc2_:ItemCategoryEnum = itemService.getCategory(param1);
         return this.timers[_loc2_];
      }
      
      public function createTimers(param1:DelayMountCategoryCC) : void
      {
         this.createTimer(ItemCategoryEnum.ARMOR,param1.delayMountArmorInSec);
         this.createTimer(ItemCategoryEnum.WEAPON,param1.delayMountWeaponInSec);
         this.createTimer(ItemCategoryEnum.COLOR,param1.delayMountResistanceInSec);
         //this.createTimer(ItemCategoryEnum.RESISTANCE_MODULE,param1.delayMountResistanceInSec);
         //this.createTimer(ItemCategoryEnum.DRONE,param1.delayMountDroneInSec);
      }
      
      private function createTimer(param1:ItemCategoryEnum, param2:int) : void
      {
         var _loc3_:CountDownTimer = new CountDownTimer();
         _loc3_.start(param2 * 1000 + getTimer());
         this.timers[param1] = _loc3_;
      }
      
      public function destroyTimers() : void
      {
         var _loc1_:CountDownTimer = null;
         for each(_loc1_ in this.timers)
         {
            if(_loc1_ != null)
            {
               _loc1_.destroy();
            }
         }
         delete this.timers[ItemCategoryEnum.ARMOR];
         //delete this.timers[ItemCategoryEnum.RESISTANCE_MODULE];
         delete this.timers[ItemCategoryEnum.WEAPON];
         //delete this.timers[ItemCategoryEnum.DRONE];
      }
      
      public function resetTimers() : void
      {
         var _loc1_:CountDownTimer = null;
         for each(_loc1_ in this.timers)
         {
            if(_loc1_ != null)
            {
               _loc1_.stop();
            }
         }
      }
   }
}

