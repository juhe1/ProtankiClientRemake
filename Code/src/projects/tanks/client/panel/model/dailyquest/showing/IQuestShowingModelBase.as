package projects.tanks.client.panel.model.dailyquest.showing
{
   import alternativa.types.Long;
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   
   public interface IQuestShowingModelBase
   {
      
      function showQuestWindow(param1:Vector.<DailyQuestInfo>, param2:WeeklyQuestDescription) : void;
      
      function showQuestWindowWithoutDailyQuests(param1:WeeklyQuestDescription) : void;
      
      function skipDailyQuest(param1:Long, param2:DailyQuestInfo) : void;
      
      function takeDailyQuestPrize(param1:Long) : void;
   }
}

