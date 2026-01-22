package scpacker.networking.protocol.packets.capturetheflag
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.battle.ctf.ICTFModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagModelBase;
   import alternativa.tanks.models.battle.ctf.CTFModel;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   import utils.TankNameGameObjectMapper;
   
   public class CaptureTheFlagPacketHandler extends AbstractPacketHandler
   {
      private var ctfModel:CTFModel;
      
      public function CaptureTheFlagPacketHandler()
      {
         super();
         this.id = 42;
         this.ctfModel = CTFModel(modelRegistry.getModel(CaptureTheFlagModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case DropFlagInPacket.id:
               this.dropFlag(param1 as DropFlagInPacket);
               break;
            case FlagDeliveredInPacket.id:
               this.flagDelivered(param1 as FlagDeliveredInPacket);
               break;
            case FlagTakenInPacket.id:
               this.flagTaken(param1 as FlagTakenInPacket);
               break;
            case LoadCaptureTheFlagCCInPacket.id:
               this.loadCaptureTheFlagCC(param1 as LoadCaptureTheFlagCCInPacket);
               break;
            case ReturnFlagToBaseInPacket.id:
               this.returnFlagToBase(param1 as ReturnFlagToBaseInPacket);
         }
      }
      
      private function loadCaptureTheFlagCC(param1:LoadCaptureTheFlagCCInPacket) : void
      {
         BattlePacketHandler.battlefieldGameObject.gameClass.models.push(this.ctfModel.id);
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.ctfModel.putInitParams(param1.cc);
         this.ctfModel.objectLoadedPost();
         Model.popObject();
      }
      
      private function dropFlag(param1:DropFlagInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.ctfModel.dropFlag(param1.position,param1.flagTeam);
         Model.popObject();
      }
      
      private function flagDelivered(param1:FlagDeliveredInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.ctfModel.flagDelivered(param1.winnerTeam,param1.delivererTankId);
         Model.popObject();
      }
      
      private function flagTaken(param1:FlagTakenInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.ctfModel.flagTaken(param1.tankId,param1.flagTeam);
         Model.popObject();
      }
      
      private function returnFlagToBase(param1:ReturnFlagToBaseInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.ctfModel.returnFlagToBase(param1.flagTeam,TankNameGameObjectMapper.getGameObjectByTankName(param1.tank));
         Model.popObject();
      }
   }
}
