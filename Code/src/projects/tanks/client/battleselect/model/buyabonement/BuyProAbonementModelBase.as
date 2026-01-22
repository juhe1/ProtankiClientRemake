package projects.tanks.client.battleselect.model.buyabonement
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BuyProAbonementModelBase extends Model
   {

      protected var server:BuyProAbonementModelServer;

      public static const modelId:Long = Long.getLong(1781362325,1040106191);

      public function BuyProAbonementModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BuyProAbonementModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
