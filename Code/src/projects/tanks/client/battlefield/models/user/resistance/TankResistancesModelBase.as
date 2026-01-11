package projects.tanks.client.battlefield.models.user.resistance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankResistancesModelBase extends Model
   {

      protected var server:TankResistancesModelServer;

      public static const modelId:Long = Long.getLong(1659531301,-819911951);

      public function TankResistancesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankResistancesModelServer(IModel(this));
      }

      protected function getInitParam() : TankResistancesCC
      {
         return TankResistancesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
