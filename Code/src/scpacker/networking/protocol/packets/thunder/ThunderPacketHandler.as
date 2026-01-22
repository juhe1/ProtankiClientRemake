package scpacker.networking.protocol.packets.thunder
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.weapon.thunder.ThunderModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.tankparts.weapon.thunder.ThunderModelBase;
   import utils.TankNameGameObjectMapper;
   
   public class ThunderPacketHandler extends AbstractPacketHandler
   {
      private var thunderModel:ThunderModel;
      
      public function ThunderPacketHandler()
      {
         super();
         this.id = 52;
         this.thunderModel = ThunderModel(modelRegistry.getModel(ThunderModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ThunderShootInPacket.id:
               this.shoot(param1 as ThunderShootInPacket);
               break;
            case ThunderShootStaticInPacket.id:
               this.shootStatic(param1 as ThunderShootStaticInPacket);
               break;
            case ThunderShootTargetInPacket.id:
               this.shootTarget(param1 as ThunderShootTargetInPacket);
         }
      }
      
      private function shoot(param1:ThunderShootInPacket) : void
      {
         this.thunderModel.shoot(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
      
      private function shootStatic(param1:ThunderShootStaticInPacket) : void
      {
         this.thunderModel.shootStatic(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.hitPoint);
      }
      
      private function shootTarget(param1:ThunderShootTargetInPacket) : void
      {
         this.thunderModel.shootTarget(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),TankNameGameObjectMapper.getGameObjectByTankName(param1.target),param1.relativeHitPoint);
      }
   }
}

