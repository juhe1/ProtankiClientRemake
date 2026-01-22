package projects.tanks.client.panel.model.kitoffer
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitOfferModelBase extends Model
   {

      protected var server:KitOfferModelServer;

      public static const modelId:Long = Long.getLong(648458850,1480220388);

      public function KitOfferModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitOfferModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
