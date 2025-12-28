package projects.tanks.client.panel.model.dailyquest.notifier
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class DailyQuestNotifierModelBase extends Model
   {
      
      protected var server:DailyQuestNotifierModelServer = new DailyQuestNotifierModelServer(IModel(this));
      
      private var client:IDailyQuestNotifierModelBase = IDailyQuestNotifierModelBase(this);
      
      static public var modelId:Long = Long.getLong(1044301282,-2025301046);
      
      public function DailyQuestNotifierModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return DailyQuestNotifierModelBase.modelId;
      }
   }
}

