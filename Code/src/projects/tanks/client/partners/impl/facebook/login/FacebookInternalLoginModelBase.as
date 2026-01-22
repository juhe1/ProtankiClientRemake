package projects.tanks.client.partners.impl.facebook.login
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FacebookInternalLoginModelBase extends Model
   {

      protected var server:FacebookInternalLoginModelServer;

      public static const modelId:Long = Long.getLong(1312719709,-729411475);

      public function FacebookInternalLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FacebookInternalLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
