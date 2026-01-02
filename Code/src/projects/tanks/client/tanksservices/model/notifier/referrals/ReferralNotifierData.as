package projects.tanks.client.tanksservices.model.notifier.referrals
{
   import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;
   
   public class ReferralNotifierData extends AbstractNotifier
   {
      
      private var _referral:Boolean;
      
      public function ReferralNotifierData(param1:Boolean = false)
      {
         super();
         this._referral = param1;
      }
      
      public function get referral() : Boolean
      {
         return this._referral;
      }
      
      public function set referral(param1:Boolean) : void
      {
         this._referral = param1;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "ReferralNotifierData [";
         _loc1_ += "referral = " + this.referral + " ";
         _loc1_ += super.toString();
         return _loc1_ + "]";
      }
   }
}

