package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RailgunShootSFXModelBase extends Model
   {

      protected var server:RailgunShootSFXModelServer;

      public static const modelId:Long = Long.getLong(551471937,-1281432907);

      public function RailgunShootSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RailgunShootSFXModelServer(IModel(this));
      }

      protected function getInitParam() : RailgunShootSFXCC
      {
         return RailgunShootSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
