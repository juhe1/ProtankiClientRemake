package scpacker.networking.protocol.packets.registration
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import projects.tanks.client.entrance.model.entrance.registration.RegistrationModelCC;
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.resource.types.ImageResource;

   import alternativa.tanks.servermodels.registartion.password.PasswordRegistrationModel;
   import projects.tanks.client.entrance.model.entrance.registration.RegistrationModelBase;
   
   public class RegistrationPacketHandler extends AbstractPacketHandler
   {
      private var passwordRegistrationModel:PasswordRegistrationModel;
      
      public function RegistrationPacketHandler()
      {
         super();
         this.id = 8;
         this.passwordRegistrationModel = PasswordRegistrationModel(modelRegistry.getModel(RegistrationModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case InitializeRegistrationInPacket.id:
               this.initializeRegistration(param1 as InitializeRegistrationInPacket);
               break;
            case NameUnavailableInPacket.id:
               this.enteredUidIsBusy(param1 as NameUnavailableInPacket);
               break;
            case NameAvailableInPacket.id:
               this.enteredUidIsFree();
               break;
            case EnteredUidIsIncorrectInPacket.id:
               this.enteredUidIsIncorrect();
         }
      }
      
      private function initializeRegistration(param1:InitializeRegistrationInPacket) : void
      {
         var _loc2_:RegistrationModelCC = new RegistrationModelCC();
         _loc2_.bgResource = param1.bgResourceID as ImageResource;
         //_loc2_.enableRequiredEmail = param1.requireEmail;
         _loc2_.enableRequiredEmail = false;
         _loc2_.maxPasswordLength = param1.maxPWLen;
         _loc2_.minPasswordLength = param1.minPWLen;
         this.passwordRegistrationModel.putInitParams(_loc2_);
         this.passwordRegistrationModel.objectLoaded();
      }
      
      private function enteredUidIsFree() : void
      {
         this.passwordRegistrationModel.enteredUidIsFree();
      }
      
      private function enteredUidIsIncorrect() : void
      {
         this.passwordRegistrationModel.enteredUidIsIncorrect();
      }
      
      private function enteredUidIsBusy(param1:NameUnavailableInPacket) : void
      {
         this.passwordRegistrationModel.enteredUidIsBusy(param1.usernames);
      }
   }
}

