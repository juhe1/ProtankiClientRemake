package projects.tanks.client.battlefield.models.user.reloader
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankReloaderModelBase extends Model
   {

      protected var server:TankReloaderModelServer;

      public static const modelId:Long = Long.getLong(1286074115,-176946994);

      public function TankReloaderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankReloaderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
