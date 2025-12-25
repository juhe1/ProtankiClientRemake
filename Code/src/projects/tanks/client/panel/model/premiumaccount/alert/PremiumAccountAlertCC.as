package projects.tanks.client.panel.model.premiumaccount.alert
{
   public class PremiumAccountAlertCC
   {
      private var newname_11795__END:Boolean;
      
      private var newname_11796__END:Boolean;
      
      private var newname_11797__END:Boolean;
      
      private var newname_11798__END:Number;
      
      private var newname_11799__END:Boolean;
      
      private var newname_11800__END:Boolean;
      
      public function PremiumAccountAlertCC(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super();
         this.newname_11795__END = param1;
         this.newname_11796__END = param2;
         this.newname_11797__END = param3;
         this.newname_11798__END = param4;
         this.newname_11799__END = param5;
         this.newname_11800__END = param6;
      }
      
      public function get localRuntimeUser() : Boolean
      {
         return this.newname_11795__END;
      }
      
      public function set localRuntimeUser(param1:Boolean) : void
      {
         this.newname_11795__END = param1;
      }
      
      public function get needShowNotificationCompletionPremium() : Boolean
      {
         return this.newname_11796__END;
      }
      
      public function set needShowNotificationCompletionPremium(param1:Boolean) : void
      {
         this.newname_11796__END = param1;
      }
      
      public function get needShowWelcomeAlert() : Boolean
      {
         return this.newname_11797__END;
      }
      
      public function set needShowWelcomeAlert(param1:Boolean) : void
      {
         this.newname_11797__END = param1;
      }
      
      public function get reminderCompletionPremiumTime() : Number
      {
         return this.newname_11798__END;
      }
      
      public function set reminderCompletionPremiumTime(param1:Number) : void
      {
         this.newname_11798__END = param1;
      }
      
      public function get wasShowAlertForFirstPurchasePremium() : Boolean
      {
         return this.newname_11799__END;
      }
      
      public function set wasShowAlertForFirstPurchasePremium(param1:Boolean) : void
      {
         this.newname_11799__END = param1;
      }
      
      public function get wasShowReminderCompletionPremium() : Boolean
      {
         return this.newname_11800__END;
      }
      
      public function set wasShowReminderCompletionPremium(param1:Boolean) : void
      {
         this.newname_11800__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "PremiumAccountAlertCC [";
         _loc1_ += "localRuntimeUser = " + this.newname_11795__END + " ";
         _loc1_ += "needShowNotificationCompletionPremium = " + this.newname_11796__END + " ";
         _loc1_ += "needShowWelcomeAlert = " + this.newname_11797__END + " ";
         _loc1_ += "reminderCompletionPremiumTime = " + this.newname_11798__END + " ";
         _loc1_ += "wasShowAlertForFirstPurchasePremium = " + this.newname_11799__END + " ";
         _loc1_ += "wasShowReminderCompletionPremium = " + this.newname_11800__END + " ";
         return _loc1_ + "]";
      }
   }
}

