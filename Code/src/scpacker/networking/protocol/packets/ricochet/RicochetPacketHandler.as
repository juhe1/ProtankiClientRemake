package scpacker.networking.protocol.packets.ricochet
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.ricochet.RicochetModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetModelBase;
   import utils.TankNameGameObjectMapper;
   
   public class RicochetPacketHandler extends AbstractPacketHandler
   {
      private var ricochetModel:RicochetModel;
      
      public function RicochetPacketHandler()
      {
         super();
         this.id = 53;
         this.ricochetModel = RicochetModel(modelRegistry.getModel(RicochetModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case RicochetFireDummyInPacket.id:
               this.fireDummy(param1 as RicochetFireDummyInPacket);
               break;
            case RicochetShootTargetInPacket.id:
               this.shootTarget(param1 as RicochetShootTargetInPacket);
         }
      }
      
      private function fireDummy(param1:RicochetFireDummyInPacket) : void
      {
         this.ricochetModel.fireDummy(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
      
      private function shootTarget(param1:RicochetShootTargetInPacket) : void
      {
         this.ricochetModel.fire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.shotDirectionX,param1.shotDirectionY,param1.shotDirectionZ);
      }
   }
}

