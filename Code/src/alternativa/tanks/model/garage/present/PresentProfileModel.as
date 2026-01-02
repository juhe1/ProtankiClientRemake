package alternativa.tanks.model.garage.present
{
   import alternativa.tanks.gui.GarageWindowEvent;
   import alternativa.tanks.gui.IGarageWindow;
   import alternativa.tanks.service.garage.GarageService;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.type.impl.GameObject;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import projects.tanks.client.garage.models.user.present.IPresentProfileModelBase;
   import projects.tanks.client.garage.models.user.present.PresentItem;
   import projects.tanks.client.garage.models.user.present.PresentProfileModelBase;
   
   [ModelInfo]
   public class PresentProfileModel extends PresentProfileModelBase implements IPresentProfileModelBase, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var garageService:GarageService;
      
      public function PresentProfileModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc2_:PresentItem = null;
         var _loc3_:GameObject = null;
         var _loc1_:IGarageWindow = garageService.getView();
         for each(_loc2_ in getInitParam().presents)
         {
            _loc3_ = new GameObject(_loc2_.id,null,"",object.space);
            _loc3_.addComponent(new UserPresentComponent(_loc2_));
            _loc1_.addItemToDepot(_loc3_);
         }
         _loc1_.setCategoryButtonVisibility(ItemViewCategoryEnum.GIVEN_PRESENTS,getInitParam().presents.length > 0);
         _loc1_.addEventListener(GarageWindowEvent.DELETE_PRESENT,getFunctionWrapper(this.onDeletePresentClick));
      }
      
      public function objectUnloaded() : void
      {
         var _loc1_:IGarageWindow = garageService.getView();
         if(_loc1_ != null)
         {
            _loc1_.removeEventListener(GarageWindowEvent.DELETE_PRESENT,getFunctionWrapper(this.onDeletePresentClick));
         }
      }
      
      private function onDeletePresentClick(param1:GarageWindowEvent) : void
      {
         PresentGiven(object.adapt(PresentGiven)).removePresent(param1.item.id);
      }
   }
}

