package scpacker.networking.protocol.packets.shaft
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.weapon.laser.LaserPointerModel;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.shaft.ShaftModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.laser.LaserPointerModelBase;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.utils.CoreUtils;
   import platform.client.fp10.core.type.IGameObject;
   
   public class ShaftPacketHandler extends AbstractPacketHandler
   {
      private var shaftfmodel:ShaftModel;
      
      private var laserPointerModel:LaserPointerModel;
      
      public function ShaftPacketHandler()
      {
         super();
         this.id = 50;
         this.shaftfmodel = ShaftModel(modelRegistry.getModel(ShaftModelBase.modelId));
         this.laserPointerModel = LaserPointerModel(modelRegistry.getModel(LaserPointerModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ShaftActivateManualTargetingInPacket.id:
               this.handleActivateManualTargeting(param1 as ShaftActivateManualTargetingInPacket);
               break;
            case ShaftLaserAimAtTankInPacket.id:
               this.handleLaserAimAtTank(param1 as ShaftLaserAimAtTankInPacket);
               break;
            case ShaftShootTargetInPacket.id:
               this.handleShootTarget(param1 as ShaftShootTargetInPacket);
               break;
            case ShaftLaserHideInPacket.id:
               this.handleLaserHide(param1 as ShaftLaserHideInPacket);
               break;
            case ShaftStopManualTargetingInPacket.id:
               this.handleStopManualTargeting(param1 as ShaftStopManualTargetingInPacket);
               break;
            case ShaftLaserUpdateDirectionInPacket.id:
               this.handleLaserUpdateDirection(param1 as ShaftLaserUpdateDirectionInPacket);
         }
      }
      
      private function handleActivateManualTargeting(param1:ShaftActivateManualTargetingInPacket) : void
      {
         Model.object = CoreUtils.getTurretObjectByTankName(param1.shooter);
         this.shaftfmodel.activateManualTargeting(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
         Model.popObject();
      }
      
      private function handleLaserAimAtTank(param1:ShaftLaserAimAtTankInPacket) : void
      {
         Model.object = CoreUtils.getTurretObjectByTankName(param1.shooterId);
         this.laserPointerModel.aimRemoteAtTank(TankNameGameObjectMapper.getGameObjectByTankName(param1.targetTank),param1.localSpotPosition);
         Model.popObject();
      }
      
      private function handleShootTarget(param1:ShaftShootTargetInPacket) : void
      {
         var targetGameObjects:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(var targetName:String in param1.targets)
         {
            targetGameObjects.push(TankNameGameObjectMapper.getGameObjectByTankName(targetName));
         }

         if(targetGameObjects.length == 0)
         {
            targetGameObjects = null;
         }

         Model.object = CoreUtils.getTurretObjectByTankName(param1.shooter);
         this.shaftfmodel.fire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.staticHitPoint,targetGameObjects,param1.targetHitPoints,param1.impactForce);
         Model.popObject();
      }
      
      private function handleLaserHide(param1:ShaftLaserHideInPacket) : void
      {
         Model.object = CoreUtils.getTurretObjectByTankName(param1.shooterId);
         this.laserPointerModel.hideRemote();
         Model.popObject();
      }
      
      private function handleStopManualTargeting(param1:ShaftStopManualTargetingInPacket) : void
      {
         Model.object = CoreUtils.getTurretObjectByTankName(param1.shooter);
         this.shaftfmodel.stopManulaTargeting(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
         Model.popObject();
      }
      
      private function handleLaserUpdateDirection(param1:ShaftLaserUpdateDirectionInPacket) : void
      {
         Model.object = CoreUtils.getTurretObjectByTankName(param1.shooterId);
         this.laserPointerModel.updateRemoteDirection(param1.projectionOnVerticalAxis);
         Model.popObject();
      }
   }
}

