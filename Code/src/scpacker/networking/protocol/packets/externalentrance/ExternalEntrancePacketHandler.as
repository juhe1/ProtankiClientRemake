package scpacker.networking.protocol.packets.externalentrance
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.servermodels.socialnetwork.ExternalEntranceModel;
   import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceCC;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceModelBase;
   
   public class ExternalEntrancePacketHandler extends AbstractPacketHandler
   {
      private var externalEntranceModel:ExternalEntranceModel;
      
      public function ExternalEntrancePacketHandler()
      {
         super();
         this.id = 3;
         this.externalEntranceModel = ExternalEntranceModel(modelRegistry.getModel(ExternalEntranceModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadExternalEntranceInPacket.id:
               this.loadExternalEntrance(param1 as LoadExternalEntranceInPacket);
               break;
            case LinkAlreadyExistsInPacket.id:
               this.linkAlreadyExists();
               break;
            case ValidationFailedInPacket.id:
               this.validationFailed();
               break;
            case ValidationSuccessInPacket.id:
               this.validationSuccess();
         }
      }
      
      private function loadExternalEntrance(param1:LoadExternalEntranceInPacket) : void
      {
         this.externalEntranceModel.putInitParams(new ExternalEntranceCC(param1.socialNetworkEntranceParams));
         this.externalEntranceModel.objectLoaded();
      }
      
      private function validationSuccess() : void
      {
         this.externalEntranceModel.validationSuccess();
      }
      
      private function validationFailed() : void
      {
         this.externalEntranceModel.validationFailed();
      }
      
      private function linkAlreadyExists() : void
      {
         this.externalEntranceModel.linkAlreadyExists();
      }
      
      private function wrongPassword() : void
      {
         this.externalEntranceModel.wrongPassword();
      }
   }
}

