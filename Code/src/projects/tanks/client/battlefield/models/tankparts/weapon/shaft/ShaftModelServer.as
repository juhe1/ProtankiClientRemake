package projects.tanks.client.battlefield.models.tankparts.weapon.shaft
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.shaft.ShaftAimedShotOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftScopeInitOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftQuickShotOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftStopManualTargetingOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftActivateManualTargetingOutPacket;

   public class ShaftModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function ShaftModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function activateManualTargetingCommand() : void
      {
         this.network.send(new ShaftActivateManualTargetingOutPacket());
      }

      public function aimedShotCommand(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>) : void
      {
         var targetStrings:Vector.<String> = new Vector.<String>();
         for each (var target:IGameObject in param3)
         {
            targetStrings.push(target.name);
         }
         if(targetStrings.length == 0)
         {
            targetStrings = null;
         }
         this.network.send(new ShaftAimedShotOutPacket(param1,param2,targetStrings,param4,param5,param6,param7));
      }

      public function beginEnergyDrainCommand(param1:int) : void
      {
         this.network.send(new ShaftScopeInitOutPacket(param1));
      }

      public function quickShotCommand(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>) : void
      {
         var targetStrings:Vector.<String> = new Vector.<String>();
         for each (var target:IGameObject in param3)
         {
            targetStrings.push(target.name);
         }
         if(targetStrings.length == 0)
         {
            targetStrings = null;
         }
         this.network.send(new ShaftQuickShotOutPacket(param1,param2,targetStrings,param4,param5,param6,param7));
      }

      public function stopManualTargetingCommand(param1:int) : void
      {
         this.network.send(new ShaftStopManualTargetingOutPacket(param1));
      }
   }
}
