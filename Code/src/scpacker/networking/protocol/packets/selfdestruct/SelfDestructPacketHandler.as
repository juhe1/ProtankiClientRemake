package scpacker.networking.protocol.packets.selfdestruct
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.tank.suicude.SuicideModel;
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.object.ClientObject;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import utils.TankNameGameObjectMapper;
   import projects.tanks.client.battlefield.models.user.suicide.SuicideModelBase;
   
   public class SelfDestructPacketHandler extends AbstractPacketHandler
   {
      private var suicideModel:SuicideModel;
      
      public function SelfDestructPacketHandler()
      {
         super();
         this.id = 40;
         this.suicideModel = SuicideModel(modelRegistry.getModel(SuicideModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case SuicideInPacket.id:
               this.handleSuicide(param1 as SuicideInPacket);
         }
      }
      
      private function handleSuicide(param1:SuicideInPacket) : void
      {

         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.suicideModel.suicide(param1.delay);
            Model.popObject();
         }
      }
   }
}

