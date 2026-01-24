package alternativa.tanks.model.dailyquest
{
   import alternativa.tanks.gui.dailyquests.window.QuestWindow;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestChangeEvent;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestGetPrizeEvent;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestWindowCloseEvent;
   import alternativa.tanks.service.panel.IPanelView;
   import alternativa.types.Long;
   import forms.events.MainButtonBarEvents;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadPostListener;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   import projects.tanks.client.panel.model.dailyquest.showing.IQuestShowingModelBase;
   import projects.tanks.client.panel.model.dailyquest.showing.QuestShowingModelBase;
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
   
   [ModelInfo]
   public class QuestShowingModel extends QuestShowingModelBase implements IQuestShowingModelBase, ObjectLoadPostListener, ObjectUnloadPostListener
   {
      
      [Inject] // added
      public static var panelView:IPanelView;
      
      [Inject] // added
      public static var userChangeGameScreenService:UserChangeGameScreenService;
      
      private var questWindow:QuestWindow;
      
      private var isQuestWindowOpened:Boolean;
      
      public function QuestShowingModel()
      {
         super();
      }
      
      public function showQuestWindowWithoutDailyQuests(param1:WeeklyQuestDescription) : void
      {
         if(!this.isQuestWindowOpened)
         {
            this.questWindow = new QuestWindow();
            this.questWindow.addEventListener(DailyQuestWindowCloseEvent.DAILY_QUEST_WINDOW_CLOSE,getFunctionWrapper(this.onDailyQuestWindowClose));
            this.questWindow.initWeeklyQuest(param1);
            this.questWindow.initWithoutQuests();
            this.questWindow.show();
            this.isQuestWindowOpened = true;
            userChangeGameScreenService.questWindowOpened();
         }
      }
      
      public function showQuestWindow(param1:Vector.<DailyQuestInfo>, param2:WeeklyQuestDescription) : void
      {
         if(!this.isQuestWindowOpened)
         {
            this.questWindow = new QuestWindow();
            this.questWindow.addEventListener(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,getFunctionWrapper(this.onDailyQuestChange));
            this.questWindow.addEventListener(DailyQuestGetPrizeEvent.DAILY_QUEST_GET_PRIZE,getFunctionWrapper(this.onDailyQuestGetPrize));
            this.questWindow.addEventListener(DailyQuestWindowCloseEvent.DAILY_QUEST_WINDOW_CLOSE,getFunctionWrapper(this.onDailyQuestWindowClose));
            this.isQuestWindowOpened = true;
            this.questWindow.init(param1);
            this.questWindow.initWeeklyQuest(param2);
            this.questWindow.show();
            userChangeGameScreenService.questWindowOpened();
         }
      }
      
      private function onDailyQuestWindowClose(param1:DailyQuestWindowCloseEvent) : void
      {
         this.questWindow.removeEventListener(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,getFunctionWrapper(this.onDailyQuestChange));
         this.questWindow.removeEventListener(DailyQuestGetPrizeEvent.DAILY_QUEST_GET_PRIZE,getFunctionWrapper(this.onDailyQuestGetPrize));
         this.questWindow.removeEventListener(DailyQuestWindowCloseEvent.DAILY_QUEST_WINDOW_CLOSE,getFunctionWrapper(this.onDailyQuestWindowClose));
         this.isQuestWindowOpened = false;
      }
      
      private function onDailyQuestGetPrize(param1:DailyQuestGetPrizeEvent) : void
      {
         DailyQuest(object.adapt(DailyQuest)).takePrize(param1.dailyQuestInfo);
      }
      
      private function onDailyQuestChange(param1:DailyQuestChangeEvent) : void
      {
         DailyQuest(object.adapt(DailyQuest)).skipDailyQuest(param1.dailyQuestInfo);
      }
      
      public function skipDailyQuest(param1:Long, param2:DailyQuestInfo) : void
      {
         if(this.isQuestWindowOpened)
         {
            this.questWindow.updateWhenQuestChanged(param1,param2);
         }
      }
      
      public function takeDailyQuestPrize(param1:Long) : void
      {
         if(this.isQuestWindowOpened)
         {
            this.questWindow.takePrize(param1);
         }
      }
      
      public function objectLoadedPost() : void
      {
         panelView.getPanel().buttonBar.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
      }
      
      public function objectUnloadedPost() : void
      {
         panelView.getPanel().buttonBar.removeEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
      }
      
      private function onButtonBarButtonClick(param1:MainButtonBarEvents) : void
      {
         if(param1.typeButton == MainButtonBarEvents.QUESTS)
         {
            server.openQuestWindow();
         }
      }
   }
}

