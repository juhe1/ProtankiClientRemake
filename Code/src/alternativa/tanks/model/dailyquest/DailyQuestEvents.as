package alternativa.tanks.model.dailyquest
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   public class DailyQuestEvents implements DailyQuest
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<DailyQuest>;
      
      public function DailyQuestEvents(param1:IGameObject, param2:Vector.<IModel>)
      {
         super();
         this.object = param1;
         this.impl = new Vector.<DailyQuest>();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            this.impl.push(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public function skipDailyQuest(param1:DailyQuestInfo) : void
      {
         var i:int = 0;
         var m:DailyQuest = null;
         var dailyQuestInfo:DailyQuestInfo = param1;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.skipDailyQuest(dailyQuestInfo);
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function takePrize(param1:DailyQuestInfo) : void
      {
         var i:int = 0;
         var m:DailyQuest = null;
         var dailyQuestInfo:DailyQuestInfo = param1;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.takePrize(dailyQuestInfo);
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}

