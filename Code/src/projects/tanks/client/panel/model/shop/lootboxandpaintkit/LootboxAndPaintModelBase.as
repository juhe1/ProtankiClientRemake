package projects.tanks.client.panel.model.shop.lootboxandpaintkit
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LootboxAndPaintModelBase extends Model
   {

      protected var server:LootboxAndPaintModelServer;

      public static const modelId:Long = Long.getLong(1165216544,-1144784906);

      public function LootboxAndPaintModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LootboxAndPaintModelServer(IModel(this));
      }

      protected function getInitParam() : LootboxAndPaintCC
      {
         return LootboxAndPaintCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
