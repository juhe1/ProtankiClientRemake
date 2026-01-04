package alternativa.tanks.model.item.upgradable.calculators
{
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
   import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;
   
   public class CriticalChanceCalculator extends BasePropertyCalculator implements PropertyCalculator, PropertyValueCalculator
   {
      
      [Inject] // added
      public static var propertyParamsService:ItemPropertyParamsService;
      
      private var afterCrit:LinearPropertyValueCalculator;
      
      private var deltaCrit:LinearPropertyValueCalculator;
      
      private var maxCrit:LinearPropertyValueCalculator;
      
      private var data:GaragePropertyParams;
      
      private var multiplier:Number;
      
      public function CriticalChanceCalculator(param1:int, param2:GaragePropertyParams)
      {
         this.data = param2;
         var _loc3_:ItemPropertyParams = propertyParamsService.getParams(param2.property);
         this.multiplier = _loc3_.getMultiplier();
         this.afterCrit = this.createPropertyCalculator(ItemProperty.AFTER_CRIT_CRITICAL_HIT_CHANCE,param1);
         this.deltaCrit = this.createPropertyCalculator(ItemProperty.CRITICAL_CHANCE_DELTA,param1);
         this.maxCrit = this.createPropertyCalculator(ItemProperty.MAX_CRITICAL_HIT_CHANCE,param1);
         super(param2.precision,this);
      }
      
      override public function getNumberValue(param1:int) : Number
      {
         return this.calculate(param1);
      }
      
      private function calculate(param1:int) : Number
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:Number = this.afterCrit.getNumberValue(param1);
         var _loc3_:Number = this.deltaCrit.getNumberValue(param1);
         var _loc4_:Number = this.maxCrit.getNumberValue(param1);
         var _loc5_:Number = 0;
         var _loc6_:Number = 1;
         var _loc7_:int = 1;
         while(true)
         {
            if(_loc2_ > _loc4_)
            {
               _loc5_ += _loc6_ * (_loc7_ - 1 + 1 / _loc4_);
               break;
            }
            _loc9_ = Math.max(_loc2_,0);
            _loc5_ += _loc6_ * _loc9_ * _loc7_;
            _loc6_ *= 1 - _loc9_;
            _loc2_ += _loc3_;
            _loc7_++;
         }
         _loc8_ = 1 / _loc5_;
         return _loc8_ * this.multiplier;
      }
      
      private function createPropertyCalculator(param1:ItemProperty, param2:int) : LinearPropertyValueCalculator
      {
         var _loc3_:PropertyData = this.getPropertyData(param1);
         return new LinearPropertyValueCalculator(_loc3_.initialValue,_loc3_.finalValue,param2);
      }
      
      private function getPropertyData(param1:ItemProperty) : PropertyData
      {
         var _loc2_:PropertyData = null;
         for each(_loc2_ in this.data.properties)
         {
            if(_loc2_.property == param1)
            {
               return _loc2_;
            }
         }
         throw new PropertyNotFoundError(param1);
      }
   }
}

