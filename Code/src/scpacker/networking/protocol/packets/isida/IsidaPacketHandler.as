package scpacker.networking.protocol.packets.isida
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.healing.HealingGunModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisModelBase;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.isida.ResetIsidaTargetInPacket;
   import scpacker.networking.protocol.packets.isida.SetIsidaTargetInPacket;
   import scpacker.networking.protocol.packets.isida.StopIsidaInPacket;
   
   public class IsidaPacketHandler extends AbstractPacketHandler
   {
      private var isisdaModel:HealingGunModel;
      
      public function IsidaPacketHandler()
      {
         super();
         this.id = 55;
         this.isisdaModel = HealingGunModel(modelRegistry.getModel(IsisModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ResetIsidaTargetInPacket.id:
               this.resetTarge(param1 as ResetIsidaTargetInPacket);
               break;
            case SetIsidaTargetInPacket.id:
               this.setTarget(param1 as SetIsidaTargetInPacket);
               break;
            case StopIsidaInPacket.id:
               this.stop(param1 as StopIsidaInPacket);
         }
      }
      
      private function resetTarge(param1:ResetIsidaTargetInPacket) : void
      {
         Model.object = TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter);
         this.isisdaModel.resetTarget();
         Model.popObject();
      }
      
      private function setTarget(param1:SetIsidaTargetInPacket) : void
      {
         Model.object = TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter);
         this.isisdaModel.setTarget(param1.currentState,param1.target);
         Model.popObject();
      }
      
      private function stop(param1:StopIsidaInPacket) : void
      {
         Model.object = TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter);
         this.isisdaModel.stopWeapon();
         Model.popObject();
      }
   }
}

