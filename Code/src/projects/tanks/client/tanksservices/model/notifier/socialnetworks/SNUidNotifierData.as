package projects.tanks.client.tanksservices.model.notifier.socialnetworks
{
   import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;
   
   public class SNUidNotifierData extends AbstractNotifier
   {
      
      private var _snUid:String;
      
      public function SNUidNotifierData(param1:String = null)
      {
         super();
         this._snUid = param1;
      }
      
      public function get snUid() : String
      {
         return this._snUid;
      }
      
      public function set snUid(param1:String) : void
      {
         this._snUid = param1;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "SNUidNotifierData [";
         _loc1_ += "snUid = " + this.snUid + " ";
         _loc1_ += super.toString();
         return _loc1_ + "]";
      }
   }
}

