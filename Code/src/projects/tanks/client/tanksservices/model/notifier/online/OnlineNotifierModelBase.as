package projects.tanks.client.tanksservices.model.notifier.online
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class OnlineNotifierModelBase extends Model
   {

      protected var server:OnlineNotifierModelServer;

      public static const modelId:Long = Long.getLong(467887314,-1426971041);

      public function OnlineNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new OnlineNotifierModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
