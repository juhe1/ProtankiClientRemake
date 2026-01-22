package projects.tanks.client.panel.model.payment.modes.errors
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ErrorsDescriptionModelBase extends Model
   {

      protected var server:ErrorsDescriptionModelServer;

      public static const modelId:Long = Long.getLong(1456185857,-299115092);

      public function ErrorsDescriptionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ErrorsDescriptionModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
