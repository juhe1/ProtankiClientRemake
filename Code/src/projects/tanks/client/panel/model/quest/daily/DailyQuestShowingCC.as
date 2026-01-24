package projects.tanks.client.panel.model.quest.daily
{
   public class DailyQuestShowingCC
   {
      
      private var _hasNewQuests:Boolean;
      
      private var _timeToNextQuest:int;
      
      public function DailyQuestShowingCC(param1:Boolean = false, param2:int = 0)
      {
         super();
         this._hasNewQuests = param1;
         this._timeToNextQuest = param2;
      }
      
      public function get hasNewQuests() : Boolean
      {
         return this._hasNewQuests;
      }
      
      public function set hasNewQuests(param1:Boolean) : void
      {
         this._hasNewQuests = param1;
      }
      
      public function get timeToNextQuest() : int
      {
         return this._timeToNextQuest;
      }
      
      public function set timeToNextQuest(param1:int) : void
      {
         this._timeToNextQuest = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DailyQuestShowingCC [";
         _loc1_ += "hasNewQuests = " + this.hasNewQuests + " ";
         _loc1_ += "timeToNextQuest = " + this.timeToNextQuest + " ";
         return _loc1_ + "]";
      }
   }
}

