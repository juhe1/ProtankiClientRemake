package projects.tanks.client.partners.impl.miniplay
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MiniplayPaymentModelBase extends Model
   {

      protected var server:MiniplayPaymentModelServer;

      public static const modelId:Long = Long.getLong(922991279,696481140);

      public function MiniplayPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MiniplayPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
