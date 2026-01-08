package projects.tanks.client.battlefield.models.tankparts.weapons.machinegun
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;

   public class MachineGunModelBase extends Model
   {

      protected var server:MachineGunModelServer;

      private static const modelId:Long = Long.getLong(1635158664,1411719504);

      public function MachineGunModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MachineGunModelServer(IModel(this));
      }

      protected function getInitParam() : MachineGunCC
      {
         return MachineGunCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
