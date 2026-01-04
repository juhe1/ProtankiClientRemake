package alternativa.tanks.model.item.resistance
{
   import alternativa.tanks.model.garage.resistance.ModuleResistances;
   import alternativa.tanks.model.item.info.ItemActionPanel;
   import alternativa.tanks.model.item.properties.ItemPropertyValue;
   import alternativa.tanks.model.item.resistance.view.ResistancePanel;
   import alternativa.tanks.service.item.ItemService;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import projects.tanks.client.commons.types.ItemGarageProperty;
   import projects.tanks.client.garage.models.item.resistance.IResistanceModuleModelBase;
   import projects.tanks.client.garage.models.item.resistance.ResistanceModuleModelBase;
   
   [ModelInfo]
   public class ResistanceModuleModel extends ResistanceModuleModelBase implements IResistanceModuleModelBase, ModuleResistances, ItemActionPanel
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      private var actionPanel:ResistancePanel;
      
      public function ResistanceModuleModel()
      {
         super();
      }
      
      public function getPanel() : ResistancePanel
      {
         if(this.actionPanel == null)
         {
            this.actionPanel = new ResistancePanel();
         }
         return this.actionPanel;
      }
      
      public function getResistances() : Vector.<ItemGarageProperty>
      {
         var _loc1_:Vector.<ItemPropertyValue> = itemService.getProperties(object);
         var _loc2_:Vector.<ItemGarageProperty> = new Vector.<ItemGarageProperty>(_loc1_.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_[_loc3_] = _loc1_[_loc3_].getProperty();
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function handleDoubleClickOnItemPreview() : void
      {
         this.getPanel().onDoubleClick();
      }
      
      public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void
      {
         this.getPanel().updateActionElements(param1,param2,object);
      }
   }
}

