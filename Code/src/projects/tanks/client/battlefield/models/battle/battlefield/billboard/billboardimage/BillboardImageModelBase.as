package projects.tanks.client.battlefield.models.battle.battlefield.billboard.billboardimage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BillboardImageModelBase extends Model
   {

      protected var server:BillboardImageModelServer;

      private static const modelId:Long = Long.getLong(1692209065,-740073254);

      public function BillboardImageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BillboardImageModelServer(IModel(this));
      }

      protected function getInitParam() : BillboardImageCC
      {
         return BillboardImageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
