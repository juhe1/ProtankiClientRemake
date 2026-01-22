package projects.tanks.client.panel.model.payment.modes.asyncurl
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AsyncUrlModelBase extends Model
   {

      protected var server:AsyncUrlModelServer;

      public static const modelId:Long = Long.getLong(963439945,1016496094);

      public function AsyncUrlModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AsyncUrlModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
