package projects.tanks.client.panel.model.shop.kitview.localized
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitViewResourceLocalizedModelBase extends Model
   {

      protected var server:KitViewResourceLocalizedModelServer;

      public static const modelId:Long = Long.getLong(1033850810,311451738);

      public function KitViewResourceLocalizedModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitViewResourceLocalizedModelServer(IModel(this));
      }

      protected function getInitParam() : KitViewResourceLocalizedCC
      {
         return KitViewResourceLocalizedCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
