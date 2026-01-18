package scpacker.networking.protocol.packets.battlemine
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.battle.battlefield.mine.BattleMinesModel;
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMinesModelBase;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   
   public class BattleMinePacketHandler extends AbstractPacketHandler
   {
      private var battleMinesModel:BattleMinesModel;
      
      public function BattleMinePacketHandler()
      {
         super();
         this.id = 62;
         this.battleMinesModel = BattleMinesModel(modelRegistry.getModel(BattleMinesModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ActivateMineInPacket.id:
               this.activateMine(param1 as ActivateMineInPacket);
               break;
            case ExplodeMineInPacket.id:
               this.explodeMine(param1 as ExplodeMineInPacket);
               break;
            case LoadBattleMinesCCInPacket.id:
               this.loadBattleMinesCC(param1 as LoadBattleMinesCCInPacket);
               break;
            case PutMineInPacket.id:
               this.putMine(param1 as PutMineInPacket);
               break;
            case RemoveMinesInPacket.id:
               this.removeAllMines(param1 as RemoveMinesInPacket);
         }
      }
      
      private function activateMine(param1:ActivateMineInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleMinesModel.activateMine(param1.mineId);
         Model.popObject();
      }
      
      private function explodeMine(param1:ExplodeMineInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleMinesModel.explodeMine(param1.mineId,param1.targetId);
         Model.popObject();
      }
      
      private function loadBattleMinesCC(param1:LoadBattleMinesCCInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleMinesModel.putInitParams(param1.cc);
         this.battleMinesModel.objectLoaded();
         Model.popObject();
      }
      
      private function putMine(param1:PutMineInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleMinesModel.putMine(param1.mineId,param1.x,param1.y,param1.z,param1.userId);
         Model.popObject();
      }
      
      private function removeAllMines(param1:RemoveMinesInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleMinesModel.removeAllMines(param1.ownerId);
         Model.popObject();
      }
   }
}
