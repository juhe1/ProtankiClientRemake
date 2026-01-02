package projects.tanks.client.tanksservices.model.notifier.premium
{
   import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;
   
   public class PremiumNotifierCC extends AbstractNotifier
   {
      
      private var _lifeTimeInSeconds:int;
      
      public function PremiumNotifierCC(param1:int = 0)
      {
         super();
         this._lifeTimeInSeconds = param1;
      }
      
      public function get lifeTimeInSeconds() : int
      {
         return this._lifeTimeInSeconds;
      }
      
      public function set lifeTimeInSeconds(param1:int) : void
      {
         this._lifeTimeInSeconds = param1;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "PremiumNotifierCC [";
         _loc1_ += "lifeTimeInSeconds = " + this.lifeTimeInSeconds + " ";
         _loc1_ += super.toString();
         return _loc1_ + "]";
      }
   }
}

