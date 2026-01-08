package projects.tanks.client.battlefield.models.tankparts.weapon.railgun
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RailgunModelBase extends Model
   {

      protected var server:RailgunModelServer;

      private static const modelId:Long = Long.getLong(387277533,1853292335);

      public function RailgunModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RailgunModelServer(IModel(this));
      }

      protected function getInitParam() : RailgunCC
      {
         return RailgunCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
