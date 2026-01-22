package projects.tanks.client.panel.model.shop.androidspecialoffer
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AndroidBannerModelBase extends Model
   {

      protected var server:AndroidBannerModelServer;

      public static const modelId:Long = Long.getLong(2009542026,-1314328031);

      public function AndroidBannerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AndroidBannerModelServer(IModel(this));
      }

      protected function getInitParam() : AndroidBannerModelCC
      {
         return AndroidBannerModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
