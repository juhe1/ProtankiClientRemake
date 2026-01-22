package projects.tanks.client.panel.model.payment.modes.tianxiafu
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TianxiafuModelBase extends Model
   {

      protected var server:TianxiafuModelServer;

      public static const modelId:Long = Long.getLong(840010560,-1146494716);

      public function TianxiafuModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TianxiafuModelServer(IModel(this));
      }

      protected function getInitParam() : TianxiafuCC
      {
         return TianxiafuCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
