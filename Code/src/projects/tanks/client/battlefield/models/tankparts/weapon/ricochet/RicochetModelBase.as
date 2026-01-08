package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RicochetModelBase extends Model
   {

      protected var server:RicochetModelServer;

      private static const modelId:Long = Long.getLong(592429654,1339096271);

      public function RicochetModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RicochetModelServer(IModel(this));
      }

      protected function getInitParam() : RicochetCC
      {
         return RicochetCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
