package scpacker.networking.protocol.packets.damageindicator
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.tank.damageindicator.DamageIndicatorModel;
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.model.impl.Model;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import alternativa.osgi.OSGi;
   import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorModelBase;
   
   public class DamageIndicatorPacketHandler extends AbstractPacketHandler
   {
      private var damageIndicatorModel:DamageIndicatorModel;
      private var userPropertiesService:IUserPropertiesService;
      
      public function DamageIndicatorPacketHandler()
      {
         super();
         this.id = 47;
         this.damageIndicatorModel = DamageIndicatorModel(modelRegistry.getModel(DamageIndicatorModelBase.modelId));
         this.userPropertiesService = IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ShowDamageForShooterInPacket.id:
               this.showDamageForShooter(param1 as ShowDamageForShooterInPacket);
         }
      }
      
      public function showDamageForShooter(param1:ShowDamageForShooterInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(this.userPropertiesService.userId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.damageIndicatorModel.showDamageForShooter(param1.damages);
            Model.popObject();
         }
      }
   }
}

