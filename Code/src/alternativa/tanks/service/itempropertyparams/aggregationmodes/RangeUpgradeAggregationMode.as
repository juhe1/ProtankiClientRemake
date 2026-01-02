package alternativa.tanks.service.itempropertyparams.aggregationmodes
{
   import alternativa.tanks.model.item.upgradable.calculators.BasePropertyCalculator;
   import alternativa.tanks.model.item.upgradable.calculators.LinearPropertyValueCalculator;
   import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
   import alternativa.tanks.model.item.upgradable.calculators.RangePropertyCalculator;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
   import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;
   
   public class RangeUpgradeAggregationMode implements UpgradeAggregationMode
   {
      
      [Inject]
      public static var propertyParamsService:ItemPropertyParamsService;
      
      public function RangeUpgradeAggregationMode()
      {
         super();
      }
      
      public function createValueCalculator(param1:int, param2:GaragePropertyParams) : PropertyCalculator
      {
         var _loc6_:PropertyData = null;
         var _loc3_:ItemPropertyParams = propertyParamsService.getParams(param2.property);
         var _loc4_:Vector.<ItemProperty> = _loc3_.getProperties();
         var _loc5_:Vector.<BasePropertyCalculator> = new Vector.<BasePropertyCalculator>();
         for each(_loc6_ in param2.properties)
         {
            if(_loc4_.indexOf(_loc6_.property) != -1)
            {
               _loc5_.push(new BasePropertyCalculator(param2.precision,new LinearPropertyValueCalculator(_loc6_.initialValue,_loc6_.finalValue,param1)));
            }
         }
         if(_loc5_.length != 2)
         {
            throw new Error("Unexpected number subproperties: property=" + param2.property + "; valueCalculators=" + _loc5_);
         }
         return new RangePropertyCalculator(_loc5_[0],_loc5_[1]);
      }
   }
}

