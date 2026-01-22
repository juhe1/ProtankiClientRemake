package projects.tanks.client.panel.model.shop.kitview
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitViewResourceModelBase extends Model
   {

      protected var server:KitViewResourceModelServer;

      public static const modelId:Long = Long.getLong(928038786,-2000755286);

      public function KitViewResourceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitViewResourceModelServer(IModel(this));
      }

      protected function getInitParam() : KitViewResourceCC
      {
         return KitViewResourceCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
