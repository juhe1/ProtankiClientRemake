package alternativa.tanks.model.item.upgradable.calculators
{
   public class BasePropertyCalculator implements PropertyCalculator, PropertyValueCalculator
   {
      
      private var precision:int;
      
      private var factor:Number;
      
      private var calculator:PropertyValueCalculator;
      
      public function BasePropertyCalculator(param1:int, param2:PropertyValueCalculator)
      {
         super();
         this.calculator = param2;
         this.precision = param1;
         this.factor = this.factor = Math.pow(10,-param1);
      }
      
      public function getValue(param1:int) : String
      {
         var _loc2_:Number = this.getRoundValue(param1);
         return this.valueToString(_loc2_);
      }
      
      public function getNumberValue(param1:int) : Number
      {
         return this.calculate(param1);
      }
      
      public function getDelta(param1:int) : String
      {
         var _loc3_:String = null;
         var _loc2_:Number = this.round(this.getRoundValue(param1 + 1) - this.getRoundValue(param1));
         if(this.calculate(1) - this.calculate(0) < 0)
         {
            _loc3_ = "−";
            _loc2_ = -_loc2_;
         }
         else
         {
            _loc3_ = "+";
         }
         return _loc3_ + this.valueToString(_loc2_);
      }
      
      private function valueToString(param1:Number) : String
      {
         return param1.toFixed(this.precision);
      }
      
      private function getRoundValue(param1:int) : Number
      {
         return this.round(this.calculate(param1));
      }
      
      private function calculate(param1:int) : Number
      {
         return this.calculator.getNumberValue(param1);
      }
      
      private function round(param1:Number) : Number
      {
         return Math.round(param1 / this.factor) * this.factor;
      }
      
      public function getPrecision() : int
      {
         return this.precision;
      }
   }
}

