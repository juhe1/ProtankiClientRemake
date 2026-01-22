package scpacker.networking.protocol.packets.shotgun
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.battle.BattleUtils;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAimingModel;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.ShotgunHittingModelBase;
   import alternativa.tanks.models.weapons.discrete.DiscreteWeaponCommunicationModel;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.DiscreteWeaponCommunicationModelBase;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.model.impl.Model;
   import alternativa.tanks.models.tank.configuration.TankConfiguration;
   import scpacker.utils.CoreUtils;
   
   public class ShotGunPacketHandler extends AbstractPacketHandler
   {
      private var shotgunModel:DiscreteWeaponCommunicationModel;
      
      public function ShotGunPacketHandler()
      {
         super();
         this.id = 70;
         this.shotgunModel = DiscreteWeaponCommunicationModel(modelRegistry.getModel(DiscreteWeaponCommunicationModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ShotgunShootInPacket.id:
               this.shoot(param1 as ShotgunShootInPacket);
         }
      }
      
      private function shoot(param1:ShotgunShootInPacket) : void
      {
         var shooterGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter);
         var turretGameObject:IGameObject = CoreUtils.getTurretObjectByTankName(param1.shooter);
         Model.object = turretGameObject;
         this.shotgunModel.shoot(shooterGameObject,param1.shootDirection,param1.targets);
         Model.popObject();
         //WeaponsManager.newname_5991__END(newname_2399__END.getUser(param1.shooter)).newname_7050__END(newname_2399__END.getUser(param1.shooter),BattleUtils.getVector3(param1.shootDirection),param1.targets);
      }
   }
}

