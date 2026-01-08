package projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MachineGunSFXModelBase extends Model
   {

      protected var server:MachineGunSFXModelServer;

      private static const modelId:Long = Long.getLong(2045216394,-936740390);

      public function MachineGunSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MachineGunSFXModelServer(IModel(this));
      }

      protected function getInitParam() : MachineGunSFXCC
      {
         return MachineGunSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
