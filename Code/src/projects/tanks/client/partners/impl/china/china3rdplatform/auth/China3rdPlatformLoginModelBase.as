package projects.tanks.client.partners.impl.china.china3rdplatform.auth
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class China3rdPlatformLoginModelBase extends Model
   {

      protected var server:China3rdPlatformLoginModelServer;

      public static const modelId:Long = Long.getLong(2066561654,-605405330);

      public function China3rdPlatformLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new China3rdPlatformLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
