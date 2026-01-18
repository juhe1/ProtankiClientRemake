package scpacker.networking.protocol.packets.tdm
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.battle.tdm.BattleTDMModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.battle.tdm.BattleTDMModelBase;
   
   public class TdmPacketHandler extends AbstractPacketHandler
   {
      private var tdmModel:BattleTDMModel;
      
      public function TdmPacketHandler()
      {
         super();
         this.id = 64;
         this.tdmModel = BattleTDMModel(modelRegistry.getModel(BattleTDMModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadTdmPostInPacket.id:
               this.loadObject();
         }
      }
      
      private function loadObject() : void
      {
         this.tdmModel.objectLoadedPost();
      }
   }
}

