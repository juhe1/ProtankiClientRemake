package projects.tanks.client.tanksservices.model.notifier.premium
{
   import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;
   
   public class PremiumNotifierData extends AbstractNotifier
   {
      
      private var _premiumTimeLeftInSeconds:int;
      
      public function PremiumNotifierData(param1:int = 0)
      {
         super();
         this._premiumTimeLeftInSeconds = param1;
      }
      
      public function get premiumTimeLeftInSeconds() : int
      {
         return this._premiumTimeLeftInSeconds;
      }
      
      public function set premiumTimeLeftInSeconds(param1:int) : void
      {
         this._premiumTimeLeftInSeconds = param1;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "PremiumNotifierData [";
         _loc1_ += "premiumTimeLeftInSeconds = " + this.premiumTimeLeftInSeconds + " ";
         _loc1_ += super.toString();
         return _loc1_ + "]";
      }
   }
}

