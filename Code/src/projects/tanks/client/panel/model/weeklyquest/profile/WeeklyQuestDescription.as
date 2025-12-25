package projects.tanks.client.panel.model.weeklyquest.profile
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class WeeklyQuestDescription
   {
      private var newname_10635__END:int;
      
      private var newname_10636__END:int;
      
      private var newname_10637__END:Boolean;
      
      private var newname_10638__END:ImageResource;
      
      private var newname_10639__END:ImageResource;
      
      public function WeeklyQuestDescription(param1:int = 0, param2:int = 0, param3:Boolean = false, param4:ImageResource = null, param5:ImageResource = null)
      {
         super();
         this.newname_10635__END = param1;
         this.newname_10636__END = param2;
         this.newname_10637__END = param3;
         this.newname_10638__END = param4;
         this.newname_10639__END = param5;
      }
      
      public function get currentQuestLevel() : int
      {
         return this.newname_10635__END;
      }
      
      public function set currentQuestLevel(param1:int) : void
      {
         this.newname_10635__END = param1;
      }
      
      public function get currentQuestStreak() : int
      {
         return this.newname_10636__END;
      }
      
      public function set currentQuestStreak(param1:int) : void
      {
         this.newname_10636__END = param1;
      }
      
      public function get doneForToday() : Boolean
      {
         return this.newname_10637__END;
      }
      
      public function set doneForToday(param1:Boolean) : void
      {
         this.newname_10637__END = param1;
      }
      
      public function get questImage() : ImageResource
      {
         return this.newname_10638__END;
      }
      
      public function set questImage(param1:ImageResource) : void
      {
         this.newname_10638__END = param1;
      }
      
      public function get rewardImage() : ImageResource
      {
         return this.newname_10639__END;
      }
      
      public function set rewardImage(param1:ImageResource) : void
      {
         this.newname_10639__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "WeeklyQuestDescription [";
         _loc1_ += "currentQuestLevel = " + this.newname_10635__END + " ";
         _loc1_ += "currentQuestStreak = " + this.newname_10636__END + " ";
         _loc1_ += "doneForToday = " + this.newname_10637__END + " ";
         _loc1_ += "questImage = " + this.newname_10638__END + " ";
         _loc1_ += "rewardImage = " + this.newname_10639__END + " ";
         return _loc1_ + "]";
      }
   }
}

