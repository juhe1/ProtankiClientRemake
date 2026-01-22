package platform.client.core.general.socialnetwork.models.google
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GoogleExternalLoginModelBase extends Model
   {

      protected var server:GoogleExternalLoginModelServer;

      public static const modelId:Long = Long.getLong(132443900,-1454404345);

      public function GoogleExternalLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GoogleExternalLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
