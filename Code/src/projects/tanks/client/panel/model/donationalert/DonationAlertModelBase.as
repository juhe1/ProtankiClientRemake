package projects.tanks.client.panel.model.donationalert
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DonationAlertModelBase extends Model
   {

      protected var server:DonationAlertModelServer;

      public static const modelId:Long = Long.getLong(790638048,-212453148);

      public function DonationAlertModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DonationAlertModelServer(IModel(this));
      }

      protected function getInitParam() : DonationAlertCC
      {
         return DonationAlertCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
