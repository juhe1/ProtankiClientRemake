package projects.tanks.client.battlefield.models.tankparts.armor.explosion
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankExplosionModelBase extends Model
   {

      protected var server:TankExplosionModelServer;

      public static const modelId:Long = Long.getLong(1983242842,420087132);

      public function TankExplosionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankExplosionModelServer(IModel(this));
      }

      protected function getInitParam() : TankExplosionCC
      {
         return TankExplosionCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
