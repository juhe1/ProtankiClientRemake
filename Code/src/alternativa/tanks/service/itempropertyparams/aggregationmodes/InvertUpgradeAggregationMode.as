package alternativa.tanks.service.itempropertyparams.aggregationmodes
{
   import alternativa.tanks.model.item.upgradable.calculators.BasePropertyCalculator;
   import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
   import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;
   
   public class InvertUpgradeAggregationMode implements UpgradeAggregationMode
   {
      
      [Inject] // added
      public static var propertyParamsService:ItemPropertyParamsService;
      
      public function InvertUpgradeAggregationMode()
      {
         super();
      }
      
      public function createValueCalculator(param1:int, param2:GaragePropertyParams) : PropertyCalculator
      {
         var _loc7_:PropertyData = null;
         var _loc8_:Number = NaN;
         var _loc3_:ItemPropertyParams = propertyParamsService.getParams(param2.property);
         var _loc4_:Vector.<ItemProperty> = _loc3_.getProperties();
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         for each(_loc7_ in param2.properties)
         {
            if(_loc4_.indexOf(_loc7_.property) != -1)
            {
               _loc5_ += _loc7_.initialValue;
               _loc6_ += _loc7_.finalValue;
            }
         }
         _loc8_ = _loc3_.getMultiplier();
         _loc5_ /= _loc8_;
         _loc6_ /= _loc8_;
         return new BasePropertyCalculator(param2.precision,new InvertPropertyCalculator(_loc5_,_loc6_,param1));
      }
   }
}

