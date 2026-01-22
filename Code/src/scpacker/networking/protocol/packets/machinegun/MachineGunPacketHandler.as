package scpacker.networking.protocol.packets.machinegun
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapons.stream.StreamWeaponCommunicationModel;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.stream.StreamWeaponCommunicationModelBase;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.utils.CoreUtils;
   
   public class MachineGunPacketHandler extends AbstractPacketHandler
   {
      private var streamWeaponCommunicationModel:StreamWeaponCommunicationModel;
      
      public function MachineGunPacketHandler()
      {
         super();
         this.id = 74;
         this.streamWeaponCommunicationModel = StreamWeaponCommunicationModel(modelRegistry.getModel(StreamWeaponCommunicationModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case MachineGunStartFireInPacket.id:
               this.startFire(param1 as MachineGunStartFireInPacket);
               break;
            case MachineGunStopFireInPacket.id:
               this.stopFire(param1 as MachineGunStopFireInPacket);
               break;
            case MachineGunHitInPacket.id:
               this.hit(param1 as MachineGunHitInPacket);
         }
      }
      
      private function startFire(param1:MachineGunStartFireInPacket) : void
      {
         var shooter:IGameObject = CoreUtils.getTurretObjectByTankName(param1.shooter);
         Model.object = shooter;
         this.streamWeaponCommunicationModel.startFire();
         Model.popObject();
      }
      
      private function stopFire(param1:MachineGunStopFireInPacket) : void
      {
         var shooter:IGameObject = CoreUtils.getTurretObjectByTankName(param1.shooter);
         Model.object = shooter;
         this.streamWeaponCommunicationModel.stopFire();
         Model.popObject();
      }
      
      private function hit(param1:MachineGunHitInPacket) : void
      {
         var shooter:IGameObject = CoreUtils.getTurretObjectByTankName(param1.shooter);
         Model.object = shooter;
         this.streamWeaponCommunicationModel.updateTargets(param1.shootDirection,param1.targets);
         Model.popObject();
      }
   }
}

