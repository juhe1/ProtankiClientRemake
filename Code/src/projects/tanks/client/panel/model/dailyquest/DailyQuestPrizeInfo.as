package projects.tanks.client.panel.model.dailyquest
{
   public class DailyQuestPrizeInfo
   {
      private var newname_5346__END:int;
      
      private var newname_3259__END:String;
      
      public function DailyQuestPrizeInfo(param1:int = 0, param2:String = null)
      {
         super();
         this.newname_5346__END = param1;
         this.newname_3259__END = param2;
      }
      
      public function get count() : int
      {
         return this.newname_5346__END;
      }
      
      public function set count(param1:int) : void
      {
         this.newname_5346__END = param1;
      }
      
      public function get name() : String
      {
         return this.newname_3259__END;
      }
      
      public function set name(param1:String) : void
      {
         this.newname_3259__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DailyQuestPrizeInfo [";
         _loc1_ += "count = " + this.newname_5346__END + " ";
         _loc1_ += "name = " + this.newname_3259__END + " ";
         return _loc1_ + "]";
      }
   }
}

