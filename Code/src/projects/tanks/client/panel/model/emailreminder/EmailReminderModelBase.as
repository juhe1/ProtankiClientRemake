package projects.tanks.client.panel.model.emailreminder
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EmailReminderModelBase extends Model
   {

      protected var server:EmailReminderModelServer;

      public static const modelId:Long = Long.getLong(1515742461,1294189212);

      public function EmailReminderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EmailReminderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
