package alternativa.tanks.model.item3d
{
   import alternativa.tanks.service.item.ItemService;
   import alternativa.tanks.service.item3d.ITank3DViewer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.garage.models.item.item3d.IItem3DModelBase;
   import projects.tanks.client.garage.models.item.item3d.Item3DModelBase;
   import projects.tanks.clients.flash.commons.models.coloring.IColoring;
   import projects.tanks.clients.flash.commons.models.detach.Detach;
   import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   [ModelInfo]
   public class Item3DModel extends Item3DModelBase implements IItem3DModelBase, ObjectLoadListener
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var tank3DViewer:ITank3DViewer;
      
      public function Item3DModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc2_:Tanks3DSResource = null;
         var _loc3_:IColoring = null;
         var _loc1_:ItemCategoryEnum = itemService.getCategory(object);
         switch(_loc1_)
         {
            case ItemCategoryEnum.ARMOR:
               _loc2_ = IObject3DS(object.adapt(IObject3DS)).getResource3DS();
               tank3DViewer.setArmor(_loc2_);
               break;
            case ItemCategoryEnum.WEAPON:
               _loc2_ = IObject3DS(object.adapt(IObject3DS)).getResource3DS();
               tank3DViewer.setWeapon(_loc2_);
               break;
            //case ItemCategoryEnum.DRONE:
            //   _loc2_ = IObject3DS(object.adapt(IObject3DS)).getResource3DS();
            //   tank3DViewer.setDrone(_loc2_);
            //   break;
            case ItemCategoryEnum.COLOR:
               _loc3_ = IColoring(object.adapt(IColoring));
               if(_loc3_.isAnimated())
               {
                  if(getInitParam().mounted)
                  {
                     tank3DViewer.setAnimation(_loc3_.getAnimatedColoring());
                     break;
                  }
                  tank3DViewer.setPreviewAnimation(_loc3_.getAnimatedColoring());
                  break;
               }
               if(getInitParam().mounted)
               {
                  tank3DViewer.setColor(_loc3_.getColoring().data);
                  break;
               }
               tank3DViewer.setPreviewColor(_loc3_.getColoring().data);
         }
         Detach(object.adapt(Detach)).detach();
      }
   }
}

