package alternativa.tanks.model.item.properties
{
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import projects.tanks.client.garage.models.item.properties.IItemPropertiesModelBase;
   import projects.tanks.client.garage.models.item.properties.ItemGaragePropertyData;
   import projects.tanks.client.garage.models.item.properties.ItemPropertiesModelBase;
   
   [ModelInfo]
   public class ItemPropertiesModel extends ItemPropertiesModelBase implements IItemPropertiesModelBase, ItemProperties
   {
      
      [Inject] // added
      public static var propertyService:ItemPropertyParamsService;
      
      public function ItemPropertiesModel()
      {
         super();
      }
      
      private static function compare(param1:ItemPropertyValue, param2:ItemPropertyValue) : Number
      {
         var _loc3_:ItemPropertyParams = propertyService.getParams(param1.getProperty());
         var _loc4_:ItemPropertyParams = propertyService.getParams(param2.getProperty());
         var _loc5_:int = _loc3_ != null ? _loc3_.sortIndex : 0;
         var _loc6_:int = _loc4_ != null ? _loc4_.sortIndex : 0;
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         if(_loc5_ > _loc6_)
         {
            return 1;
         }
         return 0;
      }
      
      public function getProperties() : Vector.<ItemPropertyValue>
      {
         var _loc1_:Vector.<ItemPropertyValue> = null;
         var _loc3_:ItemGaragePropertyData = null;
         var _loc2_:Object = getData(Vector);
         if(_loc2_ == null)
         {
            _loc1_ = new Vector.<ItemPropertyValue>();
            for each(_loc3_ in getInitParam().properties)
            {
               _loc1_.push(new ItemGaragePropertyValue(_loc3_));
            }
            _loc1_.sort(compare);
            putData(Vector,_loc1_);
         }
         else
         {
            _loc1_ = Vector.<ItemPropertyValue>(_loc2_);
         }
         return _loc1_;
      }
      
      public function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue>
      {
         return this.getProperties();
      }
   }
}

