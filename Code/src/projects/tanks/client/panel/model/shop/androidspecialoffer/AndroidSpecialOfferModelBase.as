package projects.tanks.client.panel.model.shop.androidspecialoffer
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AndroidSpecialOfferModelBase extends Model
   {

      protected var server:AndroidSpecialOfferModelServer;

      public static const modelId:Long = Long.getLong(743312616,-1714816118);

      public function AndroidSpecialOfferModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AndroidSpecialOfferModelServer(IModel(this));
      }

      protected function getInitParam() : AndroidSpecialOfferModelCC
      {
         return AndroidSpecialOfferModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
