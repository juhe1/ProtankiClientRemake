package projects.tanks.client.panel.model.socialnetwork.notification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SNGroupReminderModelBase extends Model
   {

      protected var server:SNGroupReminderModelServer;

      public static const modelId:Long = Long.getLong(490510137,-613242056);

      public function SNGroupReminderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SNGroupReminderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
