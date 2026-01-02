package alternativa.tanks.service.resistance
{
   import alternativa.tanks.model.item.properties.ItemPropertyValue;
   import alternativa.tanks.model.item.resistance.MountedResistances;
   import alternativa.tanks.model.item.resistance.view.MountedResistancesPanel;
   import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
   import alternativa.tanks.service.garage.GarageService;
   import alternativa.tanks.service.item.ItemService;
   import controls.timer.CountDownTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemGarageProperty;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
   
   public class ResistanceServiceImpl implements ResistanceService
   {
      
      [Inject]
      public static var garageService:GarageService;
      
      [Inject]
      public static var userGarageActionsService:UserGarageActionsService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var delayMountCategoryService:IDelayMountCategoryService;
      
      [Inject]
      public static var itemService:ItemService;
      
      private var view:MountedResistancesPanel = null;
      
      private var mountedResistancesObject:MountedResistances = null;
      
      public function ResistanceServiceImpl()
      {
         super();
      }
      
      public function getView() : MountedResistancesPanel
      {
         return this.view;
      }
      
      public function registerView(param1:MountedResistancesPanel) : void
      {
         this.view = param1;
      }
      
      public function registerModel(param1:IGameObject) : void
      {
         var _loc4_:IGameObject = null;
         this.mountedResistancesObject = MountedResistances(param1.adapt(MountedResistances));
         var _loc2_:* = this.mountedResistancesObject.getMounted();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_ != null)
            {
               if(this.isAllResist(_loc4_))
               {
                  this.getView().setAllResist(_loc4_);
                  return;
               }
               this.getView().setResistInCell(_loc3_,_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function unregisterModel() : void
      {
         this.mountedResistancesObject = null;
      }
      
      public function unregisterView() : void
      {
         this.view = null;
      }
      
      public function mountBought(param1:IGameObject) : void
      {
         var _loc2_:IGameObject = null;
         var _loc3_:int = 0;
         for each(_loc2_ in itemService.getModifications(param1))
         {
            _loc3_ = this.getView().getIndex(_loc2_);
            if(_loc3_ != -1)
            {
               this.getView().unequipResist(_loc2_);
               this.mount(_loc3_,param1);
               break;
            }
            this.mountIntoFreeSlot(param1);
         }
      }
      
      public function mount(param1:int, param2:IGameObject) : void
      {
         if(this.canBeMount(param2))
         {
            if(this.isAllResist(param2))
            {
               this.unmountAll();
               this.getView().setAllResist(param2);
            }
            else
            {
               this.getView().unequipResist(param2);
               this.getView().setResistInCell(param1,param2);
            }
            this.mountedResistancesObject.mount(param1,param2);
            garageService.getView().mountItem(param2);
            garageService.getView().getItemInfoPanel().onMountItem();
         }
      }
      
      public function mountIntoFreeSlot(param1:IGameObject) : void
      {
         var _loc2_:int = 0;
         if(!this.isMounted(param1))
         {
            _loc2_ = this.getView().getFreeSlot();
            if(_loc2_ > -1)
            {
               this.mount(_loc2_,param1);
            }
         }
      }
      
      public function unmount(param1:IGameObject) : void
      {
         this.getView().unequipResist(param1);
         this.mountedResistancesObject.unmount(param1);
         garageService.getView().unmountItem(param1);
         garageService.getView().getItemInfoPanel().onMountItem();
      }
      
      public function isMounted(param1:IGameObject) : Boolean
      {
         if(this.mountedResistancesObject != null)
         {
            return this.mountedResistancesObject.getMounted().indexOf(param1) >= 0;
         }
         return false;
      }
      
      private function unmountAll() : void
      {
         var _loc2_:IGameObject = null;
         var _loc1_:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(_loc2_ in this.mountedResistancesObject.getMounted())
         {
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_);
            }
         }
         for each(_loc2_ in _loc1_)
         {
            this.unmount(_loc2_);
         }
      }
      
      private function isAllResist(param1:IGameObject) : Boolean
      {
         var _loc3_:ItemPropertyValue = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Vector.<ItemPropertyValue> = itemService.getProperties(param1);
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getProperty() == ItemGarageProperty.ALL_RESISTANCE)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setOnlyUnmountMode() : void
      {
         this.getView().onlyUnmountMode();
      }
      
      public function canBeMount(param1:IGameObject) : Boolean
      {
         if(!battleInfoService.isInBattle())
         {
            return true;
         }
         if(!battleInfoService.reArmorEnabled)
         {
            return false;
         }
         var _loc2_:CountDownTimer = delayMountCategoryService.getDownTimer(param1);
         if(_loc2_ != null && _loc2_.getRemainingSeconds() > 0)
         {
            return false;
         }
         return true;
      }
   }
}

