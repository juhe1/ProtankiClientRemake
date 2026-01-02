package projects.tanks.client.tanksservices.model.notifier.online
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class OnlineNotifierModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(467887314,-1426971041);
      
      protected var server:OnlineNotifierModelServer;
      
      public function OnlineNotifierModelBase()
      {
         super();
         this.server = new OnlineNotifierModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

