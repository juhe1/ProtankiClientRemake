package scpacker.networking.protocol.packets.smoky
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.weapon.smoky.SmokyModel;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.tankparts.weapon.smoky.SmokyModelBase;
   import utils.TankNameGameObjectMapper;
   
   public class SmokyPacketHandler extends AbstractPacketHandler
   {
      private var smokyModel:SmokyModel;
      
      public function SmokyPacketHandler()
      {
         super();
         this.id = 49;
         this.smokyModel = SmokyModel(modelRegistry.getModel(SmokyModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case SmokyLocalCriticalHitInPacket.id:
               this.localCriticalHit(param1 as SmokyLocalCriticalHitInPacket);
               break;
            case SmokyShootInPacket.id:
               this.shoot(param1 as SmokyShootInPacket);
               break;
            case SmokyShootStaticInPacket.id:
               this.shootStatic(param1 as SmokyShootStaticInPacket);
               break;
            case SmokyShootTargetInPacket.id:
               this.shootTarget(param1 as SmokyShootTargetInPacket);
         }
      }
      
      private function shoot(param1:SmokyShootInPacket) : void
      {
         this.smokyModel.shoot(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
      
      private function shootStatic(param1:SmokyShootStaticInPacket) : void
      {
         this.smokyModel.shootStatic(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.hitPoint);
      }
      
      private function shootTarget(param1:SmokyShootTargetInPacket) : void
      {
         this.smokyModel.shootTarget(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),TankNameGameObjectMapper.getGameObjectByTankName(param1.target),param1.hitPoint,param1.weakeningCoeff,param1.isCritical);
      }
      
      private function localCriticalHit(param1:SmokyLocalCriticalHitInPacket) : void
      {
         this.smokyModel.localCriticalHit(TankNameGameObjectMapper.getGameObjectByTankName(param1.target));
      }
   }
}

