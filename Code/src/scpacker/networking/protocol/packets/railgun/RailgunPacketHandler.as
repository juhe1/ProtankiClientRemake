package scpacker.networking.protocol.packets.railgun
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.weapon.railgun.RailgunModel;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.type.IGameObject;
   
   public class RailgunPacketHandler extends AbstractPacketHandler
   {
      private var railgunModel:RailgunModel;
      
      public function RailgunPacketHandler()
      {
         super();
         this.id = 54;
         this.railgunModel = RailgunModel(modelRegistry.getModel(Long.getLong(387277533,1853292335)));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case RailgunFireDummyInPacket.id:
               this.newname_6735__END(param1 as RailgunFireDummyInPacket);
               break;
            case RailgunShootTargetInPacket.id:
               this.newname_6734__END(param1 as RailgunShootTargetInPacket);
               break;
            case RailgunStartChargingInPacket.id:
               this.newname_7041__END(param1 as RailgunStartChargingInPacket);
         }
      }
      
      private function newname_6735__END(param1:RailgunFireDummyInPacket) : void
      {
         this.railgunModel.fireDummy(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
      
      private function newname_6734__END(param1:RailgunShootTargetInPacket) : void
      {
         var targetGameObjects:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(var targetName:String in param1.targets)
         {
            targetGameObjects.push(TankNameGameObjectMapper.getGameObjectByTankName(targetName));
         }
         this.railgunModel.fire(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter),param1.staticHitPoint,targetGameObjects,param1.targetHitPoints);
      }
      
      private function newname_7041__END(param1:RailgunStartChargingInPacket) : void
      {
         this.railgunModel.startCharging(TankNameGameObjectMapper.getGameObjectByTankName(param1.shooter));
      }
   }
}

