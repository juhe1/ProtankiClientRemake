package scpacker.networking.protocol.packets.freeze
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.weapon.freeze.FreezeModel;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.tankparts.weapon.freeze.FreezeModelBase;
   import utils.TankNameGameObjectMapper;
   
   public class FreezePacketHandler extends AbstractPacketHandler
   {
      private var freezeModel:FreezeModel;
      
      public function FreezePacketHandler()
      {
         super();
         this.id = 56;
         this.freezeModel = FreezeModel(modelRegistry.getModel(FreezeModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case FreezeStartInPacket.id:
               this.newname_5141__END(param1 as FreezeStartInPacket);
               break;
            case FreezeStopInPacket.id:
               this.newname_5142__END(param1 as FreezeStopInPacket);
         }
      }
      
      private function newname_5141__END(param1:FreezeStartInPacket) : void
      {
         this.freezeModel.startFire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
      
      private function newname_5142__END(param1:FreezeStopInPacket) : void
      {
         this.freezeModel.stopFire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
   }
}

