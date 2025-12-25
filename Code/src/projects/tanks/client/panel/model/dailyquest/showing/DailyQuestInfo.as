package projects.tanks.client.panel.model.dailyquest.showing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.panel.model.dailyquest.DailyQuestPrizeInfo;
   
   public class DailyQuestInfo
   {
      private var newname_10375__END:Boolean;
      
      private var newname_7320__END:String;
      
      private var newname_10376__END:int;
      
      private var newname_8856__END:ImageResource;
      
      private var newname_10377__END:Vector.<DailyQuestPrizeInfo>;
      
      private var newname_10378__END:int;
      
      private var newname_10379__END:Long;
      
      private var newname_10380__END:int;
      
      public function DailyQuestInfo(param1:Boolean = false, param2:String = null, param3:int = 0, param4:ImageResource = null, param5:Vector.<DailyQuestPrizeInfo> = null, param6:int = 0, param7:Long = null, param8:int = 0)
      {
         super();
         this.newname_10375__END = param1;
         this.newname_7320__END = param2;
         this.newname_10376__END = param3;
         this.newname_8856__END = param4;
         this.newname_10377__END = param5;
         this.newname_10378__END = param6;
         this.newname_10379__END = param7;
         this.newname_10380__END = param8;
      }
      
      public function get canSkipForFree() : Boolean
      {
         return this.newname_10375__END;
      }
      
      public function set canSkipForFree(param1:Boolean) : void
      {
         this.newname_10375__END = param1;
      }
      
      public function get description() : String
      {
         return this.newname_7320__END;
      }
      
      public function set description(param1:String) : void
      {
         this.newname_7320__END = param1;
      }
      
      public function get finishCriteria() : int
      {
         return this.newname_10376__END;
      }
      
      public function set finishCriteria(param1:int) : void
      {
         this.newname_10376__END = param1;
      }
      
      public function get image() : ImageResource
      {
         return this.newname_8856__END;
      }
      
      public function set image(param1:ImageResource) : void
      {
         this.newname_8856__END = param1;
      }
      
      public function get prizes() : Vector.<DailyQuestPrizeInfo>
      {
         return this.newname_10377__END;
      }
      
      public function set prizes(param1:Vector.<DailyQuestPrizeInfo>) : void
      {
         this.newname_10377__END = param1;
      }
      
      public function get progress() : int
      {
         return this.newname_10378__END;
      }
      
      public function set progress(param1:int) : void
      {
         this.newname_10378__END = param1;
      }
      
      public function get questId() : Long
      {
         return this.newname_10379__END;
      }
      
      public function set questId(param1:Long) : void
      {
         this.newname_10379__END = param1;
      }
      
      public function get skipCost() : int
      {
         return this.newname_10380__END;
      }
      
      public function set skipCost(param1:int) : void
      {
         this.newname_10380__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DailyQuestInfo [";
         _loc1_ += "canSkipForFree = " + this.newname_10375__END + " ";
         _loc1_ += "description = " + this.newname_7320__END + " ";
         _loc1_ += "finishCriteria = " + this.newname_10376__END + " ";
         _loc1_ += "image = " + this.newname_8856__END + " ";
         _loc1_ += "prizes = " + this.newname_10377__END + " ";
         _loc1_ += "progress = " + this.newname_10378__END + " ";
         _loc1_ += "questId = " + this.newname_10379__END + " ";
         _loc1_ += "skipCost = " + this.newname_10380__END + " ";
         return _loc1_ + "]";
      }
   }
}

