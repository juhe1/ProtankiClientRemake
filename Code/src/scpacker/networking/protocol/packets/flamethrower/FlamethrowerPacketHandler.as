package scpacker.networking.protocol.packets.flamethrower
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.flamethrower.FlamethrowerModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerModelBase;
   import utils.TankNameGameObjectMapper;
   import alternativa.tanks.battle.objects.tank.Tank;
   
   public class FlamethrowerPacketHandler extends AbstractPacketHandler
   {
      private var flamethrowerModel:FlamethrowerModel;
      
      public function FlamethrowerPacketHandler()
      {
         super();
         this.id = 57;
         this.flamethrowerModel = FlamethrowerModel(modelRegistry.getModel(FlameThrowerModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case FlamethrowerStartFireInPacket.id:
               this.startFire(param1 as FlamethrowerStartFireInPacket);
               break;
            case FlamethrowerStopFireInPacket.id:
               this.stopFire(param1 as FlamethrowerStopFireInPacket);
         }
      }
      
      private function startFire(param1:FlamethrowerStartFireInPacket) : void
      {
         this.flamethrowerModel.startFire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
      
      private function stopFire(param1:FlamethrowerStopFireInPacket) : void
      {
         this.flamethrowerModel.stopFire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
   }
}

