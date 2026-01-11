package projects.tanks.client.battlefield.models.user.spawn
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankSpawnerModelBase extends Model
   {

      protected var server:TankSpawnerModelServer;

      public static const modelId:Long = Long.getLong(490108405,-1605879749);

      public function TankSpawnerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankSpawnerModelServer(IModel(this));
      }

      protected function getInitParam() : TankSpawnerCC
      {
         return TankSpawnerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
