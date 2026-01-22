package projects.tanks.client.partners.impl.steam
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SteamPaymentModelBase extends Model
   {

      protected var server:SteamPaymentModelServer;

      public static const modelId:Long = Long.getLong(1657527226,-1527425512);

      public function SteamPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SteamPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
