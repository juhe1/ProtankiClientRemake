package projects.tanks.client.panel.model.payment.modes.android
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AndroidPayModelBase extends Model
   {

      protected var server:AndroidPayModelServer;

      public static const modelId:Long = Long.getLong(1588065385,-1735921226);

      public function AndroidPayModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AndroidPayModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
