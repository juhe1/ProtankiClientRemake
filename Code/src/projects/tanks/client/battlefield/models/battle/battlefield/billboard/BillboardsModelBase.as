package projects.tanks.client.battlefield.models.battle.battlefield.billboard
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BillboardsModelBase extends Model
   {

      protected var server:BillboardsModelServer;

      private static const modelId:Long = Long.getLong(489200536,-1856903338);

      public function BillboardsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BillboardsModelServer(IModel(this));
      }

      protected function getInitParam() : BillboardCC
      {
         return BillboardCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
