package projects.tanks.client.panel.model.payment.modes.description
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BottomDescriptionModelBase extends Model
   {

      protected var server:BottomDescriptionModelServer;

      public static const modelId:Long = Long.getLong(1430690468,-801954961);

      public function BottomDescriptionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BottomDescriptionModelServer(IModel(this));
      }

      protected function getInitParam() : BottomDescriptionCC
      {
         return BottomDescriptionCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
