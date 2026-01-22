package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import scpacker.networking.protocol.packets.shotgun.ShotgunTryDummyShootOutPacket;
   import scpacker.networking.protocol.packets.shotgun.ShotgunShotOutPacket;
   import alternativa.osgi.OSGi;

   public class DiscreteWeaponCommunicationModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function DiscreteWeaponCommunicationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function tryToDummyShoot(param1:int, param2:Vector3d) : void
      {
         this.network.send(new ShotgunTryDummyShootOutPacket(param1, param2));
      }

      public function tryToShoot(param1:int, param2:Vector3d, param3:Vector.<TargetPosition>) : void
      {
         this.network.send(new ShotgunShotOutPacket(param1, param2, param3));
      }
   }
}
