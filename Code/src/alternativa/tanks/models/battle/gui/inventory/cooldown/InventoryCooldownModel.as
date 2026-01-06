package alternativa.tanks.models.battle.gui.inventory.cooldown
{
   import alternativa.tanks.models.battle.gui.inventory.IInventoryItem;
   import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.inventory.cooldown.DependedCooldownItem;
   import projects.tanks.client.battlefield.models.inventory.cooldown.IInventoryCooldownModelBase;
   import projects.tanks.client.battlefield.models.inventory.cooldown.InventoryCooldownModelBase;
   
   [ModelInfo]
   public class InventoryCooldownModel extends InventoryCooldownModelBase implements IInventoryCooldownModelBase, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var inventoryPanel:IInventoryPanel;
      
      private var slotIndexByObjectId:Dictionary = new Dictionary();
      
      public function InventoryCooldownModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function activateCooldown(param1:int) : void
      {
         inventoryPanel.activateCooldown(this.slotIndexByObjectId[object.id],param1);
      }
      
      [Obfuscation(rename="false")]
      public function activateDependentCooldown(param1:Vector.<DependedCooldownItem>) : void
      {
         var _loc4_:DependedCooldownItem = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            inventoryPanel.activateDependedCooldown(this.slotIndexByObjectId[_loc4_.id],_loc4_.duration);
            _loc3_++;
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:IInventoryItem = IInventoryItem(object.adapt(IInventoryItem));
         this.slotIndexByObjectId[object.id] = int(_loc1_.getSlotIndex());
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         delete this.slotIndexByObjectId[object.id];
      }
      
      [Obfuscation(rename="false")]
      public function setCooldownDuration(param1:int) : void
      {
         inventoryPanel.setCooldownDuration(this.slotIndexByObjectId[object.id],param1);
      }
      
      public function ready() : void
      {
         inventoryPanel.ready(this.slotIndexByObjectId[object.id]);
      }
   }
}

