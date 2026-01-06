package alternativa.tanks.models.effects.description
{
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.EffectActivatedEvent;
   import alternativa.tanks.battle.events.EffectStoppedEvent;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.effects.activeafetrdeath.IActiveAfterDeath;
   import alternativa.tanks.models.effects.durationTime.IDuration;
   import alternativa.tanks.models.effects.effectlevel.IEffectLevel;
   import alternativa.tanks.models.tank.ITankModel;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.effects.description.EffectDescriptionCC;
   import projects.tanks.client.battlefield.models.effects.description.EffectDescriptionModelBase;
   import projects.tanks.client.battlefield.models.effects.description.IEffectDescriptionModelBase;
   
   [ModelInfo]
   public class EffectDescriptionModel extends EffectDescriptionModelBase implements IEffectDescriptionModelBase, ObjectUnloadListener
   {
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      public function EffectDescriptionModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         this.deactivated();
      }
      
      public function merged(param1:int, param2:Boolean) : void
      {
         this.deactivateIcon();
         this.activateIcon(param1,param2);
      }
      
      public function activated(param1:int, param2:Boolean) : void
      {
         inventorySoundService.playActivationSound(getInitParam().tank,getInitParam().index);
         this.activateIcon(param1,param2);
      }
      
      private function activateIcon(param1:int, param2:Boolean) : void
      {
         var _loc3_:EffectDescriptionCC = getInitParam();
         var _loc4_:Boolean = this.getActiveAfterDeath();
         var _loc5_:int = object.hasModel(IEffectLevel) ? int(IEffectLevel(object.adapt(IEffectLevel)).getEffectLevel()) : 0;
         var _loc6_:Boolean = object.hasModel(IDuration) ? Boolean(IDuration(object.adapt(IDuration)).isInfinite()) : false;
         battleEventDispatcher.dispatchEvent(new EffectActivatedEvent(_loc3_.tank.id,_loc3_.index,param1,param2,_loc4_,_loc5_,_loc6_));
      }
      
      public function deactivated() : void
      {
         var _loc1_:ITankModel = ITankModel(getInitParam().tank.adapt(ITankModel));
         if(_loc1_.isLocal())
         {
            inventorySoundService.playDeactivationSound(getInitParam().index);
         }
         this.deactivateIcon();
      }
      
      private function deactivateIcon() : void
      {
         var _loc1_:EffectDescriptionCC = getInitParam();
         var _loc2_:Boolean = this.getActiveAfterDeath();
         battleEventDispatcher.dispatchEvent(new EffectStoppedEvent(_loc1_.tank.id,_loc1_.index,_loc2_));
      }
      
      private function getActiveAfterDeath() : Boolean
      {
         return Boolean(object.hasModel(IActiveAfterDeath)) && Boolean(IActiveAfterDeath(object.adapt(IActiveAfterDeath)).isEnabled());
      }
   }
}

