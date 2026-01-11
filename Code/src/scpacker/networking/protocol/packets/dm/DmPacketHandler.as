package scpacker.networking.protocol.packets.dm
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.battle.dm.BattleDMModel;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.battle.dm.BattleDMModelBase;
   
   public class DmPacketHandler extends AbstractPacketHandler
   {
      private var battleDmModel:BattleDMModel;
      
      public function DmPacketHandler()
      {
         super();
         this.id = 63;
         this.battleDmModel = BattleDMModel(modelRegistry.getModel(BattleDMModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadDmModelPostInPacket.id:
               this.loadDmModelPost();
         }
      }
      
      private function loadDmModelPost() : void
      {
         this.battleDmModel.objectLoadedPost();
      }
   }
}

