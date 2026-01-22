package projects.tanks.client.panel.model.antiaddictionalert
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AntiAddictionAlertModelBase extends Model
   {

      protected var server:AntiAddictionAlertModelServer;

      public static const modelId:Long = Long.getLong(804749612,407465188);

      public function AntiAddictionAlertModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AntiAddictionAlertModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
