package projects.tanks.client.battlefield.models.tankparts.weapons.artillery
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WeaponRotationLimitModelBase extends Model
   {

      protected var server:WeaponRotationLimitModelServer;

      public static const modelId:Long = Long.getLong(1326062457,-784723685);

      public function WeaponRotationLimitModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WeaponRotationLimitModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
