package projects.tanks.client.panel.model.weeklyquest.showing
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class WeeklyQuestRewardItem
   {
      private var newname_5346__END:int;
      
      private var newname_11694__END:ImageResource;
      
      public function WeeklyQuestRewardItem(param1:int = 0, param2:ImageResource = null)
      {
         super();
         this.newname_5346__END = param1;
         this.newname_11694__END = param2;
      }
      
      public function get count() : int
      {
         return this.newname_5346__END;
      }
      
      public function set count(param1:int) : void
      {
         this.newname_5346__END = param1;
      }
      
      public function get itemImage() : ImageResource
      {
         return this.newname_11694__END;
      }
      
      public function set itemImage(param1:ImageResource) : void
      {
         this.newname_11694__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "WeeklyQuestRewardItem [";
         _loc1_ += "count = " + this.newname_5346__END + " ";
         _loc1_ += "itemImage = " + this.newname_11694__END + " ";
         return _loc1_ + "]";
      }
   }
}

