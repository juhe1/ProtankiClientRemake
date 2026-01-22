package projects.tanks.client.tanksservices.model.ads
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AdShowModelBase extends Model
   {

      protected var server:AdShowModelServer;

      public static const modelId:Long = Long.getLong(1228348229,-753341011);

      public function AdShowModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AdShowModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
