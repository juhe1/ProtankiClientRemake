package alternativa.tanks.models.weapon.weakening
{
   public class DistanceWeakening
   {
      
      private var maximumDamageRadius:Number;
      
      private var minimumDamageRadius:Number;
      
      private var minimumDamagePercent:Number;
      
      private var falloffInterval:Number;
      
      public function DistanceWeakening(_maximumDamageRadius:Number, _minimumDamageRadius:Number, _minimumDamagePercent:Number)
      {
         super();
         this.maximumDamageRadius = _maximumDamageRadius;
         this.minimumDamageRadius = _minimumDamageRadius;
         this.minimumDamagePercent = _minimumDamagePercent;
         this.falloffInterval = _minimumDamageRadius - _maximumDamageRadius;
      }
      
      public function getImpactCoeff(param1:Number) : Number
      {
         if(this.falloffInterval <= 0)
         {
            return 1;
         }
         if(param1 <= this.maximumDamageRadius)
         {
            return 1;
         }
         if(param1 >= this.minimumDamageRadius)
         {
            return 0.01 * this.minimumDamagePercent;
         }
         return 0.01 * (this.minimumDamagePercent + (this.minimumDamageRadius - param1) * (100 - this.minimumDamagePercent) / this.falloffInterval);
      }
      
      public function getFullDamageDistance() : Number
      {
         return this.maximumDamageRadius;
      }
      
      public function getDistance() : Number
      {
         return this.minimumDamageRadius;
      }
   }
}

