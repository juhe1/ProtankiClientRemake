package scpacker.networking.protocol.packets.tankreloader
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.tank.reloader.TankReloaderModel;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.object.ClientObject;
   import projects.tanks.client.battlefield.models.user.reloader.TankReloaderModelBase;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import alternativa.osgi.OSGi;
   
   public class TankReloaderPacketHandler extends AbstractPacketHandler
   {
      private var tankReloaderModel:TankReloaderModel;
      private var userPropertiesService:IUserPropertiesService;
      
      public function TankReloaderPacketHandler()
      {
         super();
         this.id = 59;
         this.tankReloaderModel = TankReloaderModel(modelRegistry.getModel(TankReloaderModelBase.modelId));
         this.userPropertiesService = IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case TankReloaderDieInPacket.id:
               this.handleDie(param1 as TankReloaderDieInPacket);
               break;
            case TankReloaDeathScheduledInPacket.id:
               this.handleDeathScheduled(param1 as TankReloaDeathScheduledInPacket);
               break;
            case ReloadTankInPacket.id:
               this.handleReloadTank(param1 as ReloadTankInPacket);
         }
      }
      
      private function handleDie(param1:TankReloaderDieInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tank);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankReloaderModel.die(param1.delay);
            Model.popObject();
         }
      }
      
      private function handleDeathScheduled(param1:TankReloaDeathScheduledInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(this.userPropertiesService.userId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankReloaderModel.onDeathScheduled(param1.suicideDelayMS);
            Model.popObject();
         }
      }
      
      private function handleReloadTank(param1:ReloadTankInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tank);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankReloaderModel.onReload();
            Model.popObject();
         }
      }
   }
}

