package projects.tanks.client.tanksservices.model.notifier.premium
{
   public class PremiumNotifierCC
   {
      private var newname_10794__END:int;
      
      public function PremiumNotifierCC(param1:int = 0)
      {
         super();
         this.newname_10794__END = param1;
      }
      
      public function get lifeTimeInSeconds() : int
      {
         return this.newname_10794__END;
      }
      
      public function set lifeTimeInSeconds(param1:int) : void
      {
         this.newname_10794__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "PremiumNotifierCC [";
         _loc1_ += "lifeTimeInSeconds = " + this.newname_10794__END + " ";
         return _loc1_ + "]";
      }
   }
}

