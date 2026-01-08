package projects.tanks.client.battlefield.models.tankparts.weapon.thunder
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ThunderModelBase extends Model
   {

      protected var server:ThunderModelServer;

      private static const modelId:Long = Long.getLong(254322684,-956504003);

      public function ThunderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ThunderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
