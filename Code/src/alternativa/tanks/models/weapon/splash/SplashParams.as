package alternativa.tanks.models.weapon.splash
{
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   
   public class SplashParams
   {
      
      private var maxSplashDamageRadius:EncryptedNumber;
      
      private var minSplashDamageRadius:EncryptedNumber;
      
      private var minSplashDamagePercent:EncryptedNumber;
      
      private var maxSplashImpactForce:EncryptedNumber;
      
      public function SplashParams(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this.maxSplashDamageRadius = new EncryptedNumberImpl(param1);
         this.minSplashDamageRadius = new EncryptedNumberImpl(param2);
         this.minSplashDamagePercent = new EncryptedNumberImpl(param3);
         this.maxSplashImpactForce = new EncryptedNumberImpl(param4);
      }
      
      public function getSplashRadius() : Number
      {
         return this.minSplashDamageRadius.getNumber();
      }
      
      public function getImpactForce(param1:Number) : Number
      {
         return this.maxSplashImpactForce.getNumber() * this.getSplashImpactCoeff(param1);
      }
      
      private function getSplashImpactCoeff(param1:Number) : Number
      {
         var _loc2_:Number = Number(this.maxSplashDamageRadius.getNumber());
         var _loc3_:Number = Number(this.minSplashDamageRadius.getNumber());
         var _loc4_:Number = Number(this.minSplashDamagePercent.getNumber());
         if(param1 < _loc2_)
         {
            return 1;
         }
         if(param1 > _loc3_)
         {
            return 0.1 * _loc4_;
         }
         return 0.01 * (_loc4_ + (_loc3_ - param1) * (100 - _loc4_) / (_loc3_ - _loc2_));
      }
   }
}

