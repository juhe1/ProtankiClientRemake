package projects.tanks.client.battlefield.models.tankparts.weapon.smoky
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SmokyModelBase extends Model
   {

      protected var server:SmokyModelServer;

      private static const modelId:Long = Long.getLong(505740619,208573179);

      public function SmokyModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SmokyModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
