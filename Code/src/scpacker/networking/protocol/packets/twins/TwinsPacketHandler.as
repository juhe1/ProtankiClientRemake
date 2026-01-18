package scpacker.networking.protocol.packets.twins
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.weapon.twins.TwinsModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsModelBase;
   import utils.TankNameGameObjectMapper;
   
   public class TwinsPacketHandler extends AbstractPacketHandler
   {
      private var twinsModel:TwinsModel;
      
      public function TwinsPacketHandler()
      {
         super();
         this.id = 51;
         this.twinsModel = TwinsModel(modelRegistry.getModel(TwinsModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case TwinsShootTargetIn.id:
               this.shootTarget(param1 as TwinsShootTargetIn);
               break;
            case TwinsFireDummyIn.id:
               this.shootDummy(param1 as TwinsFireDummyIn);
         }
      }
      
      private function shootTarget(param1:TwinsShootTargetIn) : void
      {
         this.twinsModel.fire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.barrel,-1,param1.shotDirection);
      }
      
      private function shootDummy(param1:TwinsFireDummyIn) : void
      {
         this.twinsModel.fireDummy(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.barrel);
      }
   }
}

