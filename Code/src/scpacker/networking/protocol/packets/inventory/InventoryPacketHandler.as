package scpacker.networking.protocol.packets.inventory
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.battle.gui.inventory.InventoryItemModel;
   import alternativa.tanks.models.battle.gui.inventory.InventoryModel;
   import projects.tanks.client.battlefield.models.inventory.item.InventoryItemModelBase;
   import projects.tanks.client.battlefield.models.battle.gui.inventory.InventoryModelBase;
   import flash.utils.Dictionary;
   import scpacker.utils.IdTool;
   import platform.client.fp10.core.type.IGameClass;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.inventory.item.InventoryItemCC;
   import alternativa.tanks.models.effects.durationTime.DurationModel;
   import projects.tanks.client.battlefield.models.effects.duration.time.DurationModelBase;
   import projects.tanks.client.battlefield.models.effects.duration.time.DurationCC;
   import platform.client.fp10.core.model.impl.Model;
   
   public class InventoryPacketHandler extends AbstractPacketHandler
   {
      private var inventoryItemModel:InventoryItemModel;
      private var inventoryModel:InventoryModel;
      private var durationModel:DurationModel;
      
      public function InventoryPacketHandler()
      {
         super();
         this.id = 43;
         this.inventoryItemModel = InventoryItemModel(modelRegistry.getModel(InventoryItemModelBase.modelId));
         this.inventoryModel = InventoryModel(modelRegistry.getModel(InventoryModelBase.modelId));
         this.durationModel = DurationModel(modelRegistry.getModel(DurationModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case InventoryItemActivatedInPacket.id:
               this.handleInventoryItemActivated(param1 as InventoryItemActivatedInPacket);
               break;
            case LoadInventoryInPacket.id:
               this.handleLoadInventory(param1 as LoadInventoryInPacket);
               break;
            case InventoryUpdateCountInPacket.id:
               this.handleInventoryUpdateCount(param1 as InventoryUpdateCountInPacket);
         }
      }
      
      private function handleLoadInventory(param1:LoadInventoryInPacket) : void
      {
         var inventoryItemVector:Vector.<Long> = new Vector.<Long>();
         inventoryItemVector.push(this.inventoryItemModel.id);
         inventoryItemVector.push(this.durationModel.id);
         var inventoryItemGameClass:IGameClass = gameTypeRegistry.createClass(Long.getLong(14025,687788),inventoryItemVector);

         var _loc3_:Object = JSON.parse(param1.battlesJson);
         for each(var itemJson in _loc3_.items)
         {
            var inventoryItemGameObject:IGameObject = BattlePacketHandler.battlefieldGameObject.space.createObject(IdTool.getNextId(), inventoryItemGameClass, itemJson.id);

            var inventoryItemCC:InventoryItemCC = new InventoryItemCC();
            inventoryItemCC.alternativeSlotItem = false;
            inventoryItemCC.count = itemJson.count;
            inventoryItemCC.itemIndex = itemJson.slotId;
            
            var durationCC:DurationCC = new DurationCC();
            durationCC.durationTimeInMs = itemJson.itemEffectTime;
            durationCC.infinite = false;
            
            Model.object = inventoryItemGameObject;
            this.inventoryItemModel.putInitParams(inventoryItemCC);
            this.inventoryItemModel.objectLoadedPost();
            this.durationModel.putInitParams(durationCC);
            Model.popObject();
         }
      }
      
      private function handleInventoryUpdateCount(param1:InventoryUpdateCountInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject.space.getObjectByName(param1.itemId);
         this.inventoryItemModel.updateCount(param1.count);
         Model.popObject();
      }
      
      private function handleInventoryItemActivated(param1:InventoryItemActivatedInPacket) : void
      {
         //this.inventoryItemModel.activated(param1.itemId,param1.clientTime,param1.decrease);
      }
   }
}

