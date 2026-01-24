package scpacker.networking.protocol.packets.usercountry
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.model.usercountry.UserCountryModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.panel.model.usercountry.UserCountryModelBase;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.panel.PanelPacketHandler;
   
   public class UserCountryPacketHandler extends AbstractPacketHandler
   {
      private var userCountryModel:UserCountryModel;
      
      public function UserCountryPacketHandler()
      {
         super();
         this.id = 75;
         this.userCountryModel = UserCountryModel(modelRegistry.getModel(UserCountryModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadUserCountryModelInPacket.id:
               this.load(param1 as LoadUserCountryModelInPacket);
               break;
            case RequestUserCountryInPacket.id:
               this.requestUserCountry(param1 as RequestUserCountryInPacket);
               break;
            case ShowPaymentWindowInPacket.id:
               this.showPaymentWindow(param1 as ShowPaymentWindowInPacket);
         }
      }
      
      private function load(param1:LoadUserCountryModelInPacket) : void
      {
         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(this.userCountryModel.id);
         var userCountryGameClass:IGameClass = this.gameTypeRegistry.createClass(Long.getLong(12665678,97654321), modelVector);

         Model.object = PanelPacketHandler.panelSpace.createObject(Long.getLong(12545678,85654321), userCountryGameClass, "User Country game object");
         this.userCountryModel.putInitParams(param1.cc);
         this.userCountryModel.objectLoaded();
         Model.popObject();
      }
      
      private function requestUserCountry(param1:RequestUserCountryInPacket) : void
      {
         this.userCountryModel.requestUserCountry(param1.country);
      }
      
      private function showPaymentWindow(param1:ShowPaymentWindowInPacket) : void
      {
         this.userCountryModel.showPaymentWindow();
      }
   }
}

