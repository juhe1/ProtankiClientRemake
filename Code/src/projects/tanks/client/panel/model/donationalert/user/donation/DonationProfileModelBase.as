package projects.tanks.client.panel.model.donationalert.user.donation
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DonationProfileModelBase extends Model
   {

      protected var server:DonationProfileModelServer;

      public static const modelId:Long = Long.getLong(1259588891,1134912464);

      public function DonationProfileModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DonationProfileModelServer(IModel(this));
      }

      protected function getInitParam() : DonationProfileCC
      {
         return DonationProfileCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
